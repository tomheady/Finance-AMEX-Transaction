package t::lib::CompareFile;

use strict;
use warnings;

use Test::More;
use JSON ();


sub compare {
  my ($type, $file, $data, $counts) = @_;

  my $obj = Finance::AMEX::Transaction->new(file_type => $type);

  open my $fh, '<', $file or die "cannot open test file: $!";

  my $tests = JSON->new->utf8->decode($data);

  while (my $line = $obj->getline($fh)) {

    my $type = $line->type;
    if (exists $counts->{$type}) {

      my $have = $counts->{$type}->{have};
      my $answers = $tests->{$type}->[$have];

      my $map = $line->field_map;

      if (ref($map) eq 'HASH') {
        foreach my $k (keys %{$map}) {
          is ($line->$k, $answers->{$k}, $type .' '. $have .': '. $k);
        }
      } elsif (ref($map) eq 'ARRAY') {
        foreach my $column (@{$map}) {
          my ($k) = keys %{$column};
          if ($line->can($k)) {
            is ($line->$k, $answers->{$k}, $type .' '. $have .': '. $k);
          }
        }
      } else {
        fail "field_map returned an unknown type for file_type => $type";
      }

      $counts->{$line->type}->{have}++;

    } else {
      #fail("unknown line type: $type");
    }
  }

  foreach my $type (keys %{$counts}) {
    is ($counts->{$type}->{have}, $counts->{$type}->{want}, 'We saw the expected amount of '. $type .' records');
  }

  close $fh;

  return $obj;
}






1;
