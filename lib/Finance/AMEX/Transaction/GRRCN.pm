package Finance::AMEX::Transaction::GRRCN;

use strict;
use warnings;

use Text::CSV;

use Finance::AMEX::Transaction::GRRCN::Header;
use Finance::AMEX::Transaction::GRRCN::Summary;
use Finance::AMEX::Transaction::GRRCN::TaxRecord;
use Finance::AMEX::Transaction::GRRCN::Submission;
use Finance::AMEX::Transaction::GRRCN::Transaction;
use Finance::AMEX::Transaction::GRRCN::TxnPricing;
use Finance::AMEX::Transaction::GRRCN::Chargeback;
use Finance::AMEX::Transaction::GRRCN::Adjustment;
use Finance::AMEX::Transaction::GRRCN::FeeRevenue;
use Finance::AMEX::Transaction::GRRCN::Trailer;
use Finance::AMEX::Transaction::GRRCN::Unknown;

# ABSTRACT: Parse AMEX Global Reconciliation (GRRCN)

sub new {
  my ($class, %props) = @_;

  my $type_map = {
    HEADER     => 'Finance::AMEX::Transaction::GRRCN::Header',
    SUMMARY    => 'Finance::AMEX::Transaction::GRRCN::Summary',
    TAXRECORD  => 'Finance::AMEX::Transaction::GRRCN::TaxRecord',
    SUBMISSION => 'Finance::AMEX::Transaction::GRRCN::Submission',
    TRANSACTN  => 'Finance::AMEX::Transaction::GRRCN::Transaction',
    TXNPRICING => 'Finance::AMEX::Transaction::GRRCN::TxnPricing',
    CHARGEBACK => 'Finance::AMEX::Transaction::GRRCN::Chargeback',
    ADJUSTMENT => 'Finance::AMEX::Transaction::GRRCN::Adjustment',
    FEEREVENUE => 'Finance::AMEX::Transaction::GRRCN::FeeRevenue',
    TRAILER    => 'Finance::AMEX::Transaction::GRRCN::Trailer',
  };

  my $file_format = $props{format} || 'UNKNOWN';

  my $self = bless {
    _type_map    => $type_map,
    _file_format => $file_format,
  }, $class;

  return $self;
}

sub file_format {
  my ($self) = @_;
  return $self->{_file_format};
}

sub detect_file_format {
  my ($self, $line) = @_;

  if (substr($line, 0, 1) eq '"') {
    if ($line =~ m{","}) {
      $self->{_file_format} = 'CSV';
    } elsif ($line =~ m{\"\t\"}) {
      $self->{_file_format} = 'TSV';
    }

    return $self->{_file_format};
  }
  $self->{_file_format} = 'FIXED';
  return $self->{_file_format};
}

sub parse_line {
  my ($self, $line) = @_;

  return if not defined $line;

  if ($self->file_format eq 'UNKNOWN') {
    $self->detect_file_format($line);
  }

  my $type = $self->detect_line_type($line);

  if (exists $self->{_type_map}->{$type}) {
    return $self->{_type_map}->{$type}->new(line => $line, file_format => $self->file_format);
  }

  return Finance::AMEX::Transaction::GRRCN::Unknown->new(line => $line);
}

sub detect_line_type {
  my ($self, $line) = @_;

  if ($self->file_format eq 'FIXED') {
    return substr($line, 0, 10);
  }

  my $csv = Text::CSV->new ({
    binary      => 1,
    quote_char  => '"',
    escape_char => "\\",
  }) or die "Cannot use CSV: ".Text::CSV->error_diag ();
  $line =~ s{\s+\z}{}; # csv parser does not like trailing whitespace

  if ($self->file_format eq 'CSV') {
    $csv->sep_char(',');
  } elsif ($self->file_format eq 'TSV') {
    $csv->sep_char("\t");
  }

  if (my $status = $csv->parse($line)) {
    return ($csv->fields)[0];
  }
}

1;
