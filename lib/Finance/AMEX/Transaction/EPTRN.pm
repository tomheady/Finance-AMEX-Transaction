package Finance::AMEX::Transaction::EPTRN;

use strict;
use warnings;

use Finance::AMEX::Transaction::EPTRN::Header;
use Finance::AMEX::Transaction::EPTRN::Summary;
use Finance::AMEX::Transaction::EPTRN::Detail::ChargeSummary;
use Finance::AMEX::Transaction::EPTRN::Detail::RecordSummary;
use Finance::AMEX::Transaction::EPTRN::Detail::Chargeback;
use Finance::AMEX::Transaction::EPTRN::Detail::Adjustment;
use Finance::AMEX::Transaction::EPTRN::Detail::Other;
use Finance::AMEX::Transaction::EPTRN::Trailer;
use Finance::AMEX::Transaction::EPTRN::Unknown;

# ABSTRACT: Parse AMEX Transaction/Invoice Level Reconciliation (EPTRN)

sub new {
  my ($class, %props) = @_;

  my $type_map = {
    HEADER            => 'Finance::AMEX::Transaction::EPTRN::Header',
    SUMMARY           => 'Finance::AMEX::Transaction::EPTRN::Summary',
    SOC_DETAIL        => 'Finance::AMEX::Transaction::EPTRN::Detail::ChargeSummary',
    ROC_DETAIL        => 'Finance::AMEX::Transaction::EPTRN::Detail::RecordSummary',
    CHARGEBACK_DETAIL => 'Finance::AMEX::Transaction::EPTRN::Detail::Chargeback',
    ADJUSTMENT_DETAIL => 'Finance::AMEX::Transaction::EPTRN::Detail::Adjustment',
    OTHER_DETAIL      => 'Finance::AMEX::Transaction::EPTRN::Detail::Other',
    TRAILER           => 'Finance::AMEX::Transaction::EPTRN::Trailer',
  };

  my $self = bless {
    _type_map => $type_map,
  }, $class;

  return $self;
}

sub file_format  {'N/A'}
sub file_version {'N/A'}

sub parse_line {
  my ($self, $line) = @_;

  return if not defined $line;

  my $header_trailer_indicator = substr($line, 0, 5);

  # DFHDR = header
  # DFTRL = trailer

  # 1-00 = Summary
  # 2-10 = SOC detail
  # 3-11 = ROC detail
  # 2-20 = Chargeback detail
  # 2-30 = Adjustment detail
  # 2-40, 2-41, 2-50 = Other Fees and Revenues detail

  my $indicator = 'UNKNOWN';

  if ($header_trailer_indicator eq 'DFHDR') {
    $indicator = 'HEADER';
  } elsif ($header_trailer_indicator eq 'DFTRL') {
    $indicator = 'TRAILER';
  } elsif ($indicator eq 'UNKNOWN') {
    my $summary_detail_indicator = join('-', substr($line, 42, 1), substr($line, 43, 2));
    if ($summary_detail_indicator eq '1-00') {
      $indicator = 'SUMMARY';
    } elsif ($summary_detail_indicator eq '2-10') {
      $indicator = 'SOC_DETAIL';
    } elsif ($summary_detail_indicator eq '2-12') {
      $indicator = 'SOC_PRICING';
    } elsif ($summary_detail_indicator eq '3-11') {
      $indicator = 'ROC_DETAIL';
    } elsif ($summary_detail_indicator eq '3-13') {
      $indicator = 'ROC_PRICING';
    } elsif ($summary_detail_indicator eq '2-20') {
      $indicator = 'CHARGEBACK_DETAIL';
    } elsif ($summary_detail_indicator eq '2-30') {
      $indicator = 'ADJUSTMENT_DETAIL';
    } elsif ($summary_detail_indicator eq '2-40' or $summary_detail_indicator eq '2-41' or $summary_detail_indicator eq '2-50') {
      $indicator = 'OTHER_DETAIL';
    }
  }
  if (exists $self->{_type_map}->{$indicator}) {
    return $self->{_type_map}->{$indicator}->new(line => $line);
  }
  return Finance::AMEX::Transaction::EPTRN::Unknown->new(line => $line);
}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::EPTRN - Parse AMEX Transaction/Invoice Level Reconciliation (EPTRN)

=head1 SYNOPSIS

  use Finance::AMEX::Transaction;

  my $eptrn = Finance::AMEX::Transaction->new(file_type => 'EPTRN');
  open my $fh, '<', '/path to EPTRN file' or die "cannot open EPTRN file: $!";

  while (my $record = $eptrn->getline($fh)) {

    if ($record->type eq 'TRAILER') {
      print $record->FILE_CREATION_DATE . "\n";
    }
  }

=head1 DESCRIPTION

This module parses AMEX Transaction/Invoice Level Reconciliation (EPTRN) files and returns objects which are appropriate for the line that it was asked to parse.

You would not normally be calling this module directly, it is merely a router to the correct object type that is returned to L<Finance::AMEX::Transaction>'s getline method.

Object returned are one of:

=begin :list

= L<Finance::AMEX::Transaction::EPTRN::Header>

Header Rows

 print $record->type; # HEADER

= L<Finance::AMEX::Transaction::EPTRN::Summary>

Summary Rows

 print $record->type; # SUMMARY

= L<Finance::AMEX::Transaction::EPTRN::Detail::ChargeSummary>

Summary of Charge (SOC) Detail Rows

 print $record->type; # SOC_DETAIL

= L<Finance::AMEX::Transaction::EPTRN::Detail::RecordSummary>

Record of Charge (ROC) Detail Rows

 print $record->type; # ROC_DETAIL

= L<Finance::AMEX::Transaction::EPTRN::Detail::Chargeback>

Chargeback Detail Rows

 print $record->type; # CHARGEBACK_DETAIL

= L<Finance::AMEX::Transaction::EPTRN::Detail::Adjustment>

Adjustment Detail Rows

 print $record->type; # ADJUSTMENT_DETAIL

= L<Finance::AMEX::Transaction::EPTRN::Detail::Other>

Other Fees and Revenues Detail Rows

 print $record->type; # OTHER_DETAIL

= L<Finance::AMEX::Transaction::EPTRN::Trailer>

Trailer Rows

 print $record->type; # TRAILER

= L<Finance::AMEX::Transaction::EPTRN::Unknown>

Unknown lines.

 print $record->type; # UNKNOWN

=end :list

=method new

Returns a L<Finance::AMEX::Transaction::EPTRN> object.

 my $eptrn = Finance::AMEX::Transaction::EPTRN->new;

=method parse_line

Returns one of the L<Finance::AMEX::Transaction::EPTRN::Header>, L<Finance::AMEX::Transaction::EPTRN::Summary>, L<Finance::AMEX::Transaction::EPTRN::Detail::ChargeSummary>, L<Finance::AMEX::Transaction::EPTRN::Detail::RecordSummary>, L<Finance::AMEX::Transaction::EPTRN::Detail::Chargeback>, L<Finance::AMEX::Transaction::EPTRN::Detail::Adjustment>, L<Finance::AMEX::Transaction::EPTRN::Detail::Other>, L<Finance::AMEX::Transaction::EPTRN::Trailer>, or L<Finance::AMEX::Transaction::EPTRN::Unknown> records depending on the contents of the line.

 my $record = $eptrn->parse_line('line from a eptrn file');
