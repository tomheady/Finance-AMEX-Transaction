package Finance::AMEX::Transaction::CBNOT;

use strict;
use warnings;

use Finance::AMEX::Transaction::CBNOT::Header;
use Finance::AMEX::Transaction::CBNOT::Detail;
use Finance::AMEX::Transaction::CBNOT::Trailer;
use Finance::AMEX::Transaction::CBNOT::Unknown;

# ABSTRACT: Parse AMEX Chargeback Notification Files (CBNOT)

sub new {
  my ($class, %props) = @_;

  my $type_map = {
    H => 'Finance::AMEX::Transaction::CBNOT::Header',
    D => 'Finance::AMEX::Transaction::CBNOT::Detail',
    T => 'Finance::AMEX::Transaction::CBNOT::Trailer',
  };

  my $self = bless {
    _type_map => $type_map,
  }, $class;

  return $self;
}

sub parse_line {
  my ($self, $line) = @_;

  return if not defined $line;

  my $indicator = substr($line, 0, 1);
  if (exists $self->{_type_map}->{$indicator}) {
    return $self->{_type_map}->{$indicator}->new(line => $line);
  }
  return Finance::AMEX::Transaction::CBNOT::Unknown->new(line => $line);
}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::CBNOT - Parse AMEX Chargeback Notification Files (CBNOT)

=head1 SYNOPSIS

  use Finance::AMEX::Transaction;

  my $cbnot = Finance::AMEX::Transaction->new(file_type => 'CBNOT');
  open my $fh, '<', '/path to CBNOT file' or die "cannot open CBNOT file: $!";

  while (my $record = $cbnot->getline($fh)) {

    if ($record->type eq 'TRAILER') {
      print $record->FILE_CREATION_DATE . "\n";
    }
  }

=head1 DESCRIPTION

This module parses AMEX Chargeback Notification Files (CBNOT) returns object that are appropriate for the line that it was asked to parse.

You would not normally be calling this module directly, it is merely a router to the correct object type that is returned to F<Finance::AMEX::Transaction>'s getline method.

Object returned are one of:

=begin :list

= F<Finance::AMEX::Transaction::CBNOT::Header>

Header lines.

= F<Finance::AMEX::Transaction::CBNOT::Detail>

Detail lines.

= F<Finance::AMEX::Transaction::CBNOT::Trailer>

Trailer lines.

= F<Finance::AMEX::Transaction::CBNOT::Unknown>

Unknown lines.

=end :list

=method new

Returns a Finance::AMEX::Transaction::CBNOT object.

 my $cbnot = Finance::AMEX::Transaction::CBNOT->new;

=method parse_line

Returns one of the Header, Detail, Trailer, or Unknown records depending on the contents of the line.

 my $record = $cbnot->parse_line('line from a cbnot file');




