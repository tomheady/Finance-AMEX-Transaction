package Finance::AMEX::Transaction::EPRAW;

use strict;
use warnings;

use Finance::AMEX::Transaction::EPRAW::Header;
use Finance::AMEX::Transaction::EPRAW::Summary;
use Finance::AMEX::Transaction::EPRAW::Detail::ChargeSummary;
use Finance::AMEX::Transaction::EPRAW::Detail::Chargeback;
use Finance::AMEX::Transaction::EPRAW::Detail::Adjustment;
use Finance::AMEX::Transaction::EPRAW::Detail::Other;
use Finance::AMEX::Transaction::EPRAW::Trailer;
use Finance::AMEX::Transaction::EPRAW::Unknown;

# ABSTRACT: Parse AMEX Reconciliation Files (EPRAW)

sub new {
  my ($class, %props) = @_;

  my $type_map = {
    HEADER            => 'Finance::AMEX::Transaction::EPRAW::Header',
    SUMMARY           => 'Finance::AMEX::Transaction::EPRAW::Summary',
    SOC_DETAIL        => 'Finance::AMEX::Transaction::EPRAW::Detail::ChargeSummary',
    CHARGEBACK_DETAIL => 'Finance::AMEX::Transaction::EPRAW::Detail::Chargeback',
    ADJUSTMENT_DETAIL => 'Finance::AMEX::Transaction::EPRAW::Detail::Adjustment',
    OTHER_DETAIL      => 'Finance::AMEX::Transaction::EPRAW::Detail::Other',
    TRAILER           => 'Finance::AMEX::Transaction::EPRAW::Trailer',
  };

  my $self = bless {
    _type_map => $type_map,
  }, $class;

  return $self;
}

sub parse_line {
  my ($self, $line) = @_;

  return if not defined $line;

  my $header_trailer_indicator = substr($line, 0, 5);

  # DFHDR = header
  # DFTRL = trailer
  # 1-00 = summary
  # 2-10 = SOC detail
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
  return Finance::AMEX::Transaction::EPRAW::Unknown->new(line => $line);
}

1;
