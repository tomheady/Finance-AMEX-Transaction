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
    _version     => $props{version} || 1.01,
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

    my $parsed = $self->{_type_map}->{$type}->new(
      line => $line,
      file_format => $self->file_format,
      version => $self->{_version},
    );

    if ($type eq 'HEADER') {
      $self->{_version} = $parsed->FILE_VERSION_NUMBER;
    }

    return $parsed;
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

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::GRRCN - Parse AMEX Chargeback Notification Files (GRRCN)

=head1 SYNOPSIS

  use Finance::AMEX::Transaction;

  my $grrcn = Finance::AMEX::Transaction->new(file_type => 'GRRCN');
  open my $fh, '<', '/path to GRRCN file' or die "cannot open GRRCN file: $!";

  while (my $record = $grrcn->getline($fh)) {

    if ($record->type eq 'TRAILER') {
      print $record->FILE_CREATION_DATE . "\n";
    }
  }

=head1 DESCRIPTION

This module parses AMEX Global Reconciliation (GRRCN) files and returns an object which is appropriate for the line that it was asked to parse.

You would not normally be calling this module directly, it is merely a router to the correct object type that is returned to L<Finance::AMEX::Transaction>'s getline method.

Object returned are one of:

=begin :list

= L<Finance::AMEX::Transaction::GRRCN::Header>

Header Rows

 print $record->type; # HEADER

= L<Finance::AMEX::Transaction::GRRCN::Summary>

Summary Rows

 print $record->type; # SUMMARY

= L<Finance::AMEX::Transaction::GRRCN::TaxRecord>

TaxRecord Rows

 print $record->type; # TAXRECORD

= L<Finance::AMEX::Transaction::GRRCN::Submission>

Submission or summary of charge (SOC) Rows

 print $record->type; # SUBMISSION

= L<Finance::AMEX::Transaction::GRRCN::Transaction>

Transaction or summary of charge (SOC) Rows

 print $record->type; # TRANSACTION

= L<Finance::AMEX::Transaction::GRRCN::TxnPricing>

transaction or ROC pricing Rows

 print $record->type; # TXNPRICING

= L<Finance::AMEX::Transaction::GRRCN::Chargeback>

Chargeback Rows

 print $record->type; # CHARGEBACK

= L<Finance::AMEX::Transaction::GRRCN::Adjustment>

Adjustment Rows

 print $record->type; # ADJUSTMENT

= L<Finance::AMEX::Transaction::GRRCN::FeeRevenue>

Fees and Revenues Record

 print $record->type; # FEEREVENUE

= L<Finance::AMEX::Transaction::GRRCN::Trailer>

Trailer Rows

 print $record->type; # TRAILER

= L<Finance::AMEX::Transaction::GRRCN::Unknown>

Unknown lines.

 print $record->type; # UNKNOWN

=end :list

=method new

Returns a L<Finance::AMEX::Transaction::GRRCN> object.

 my $grrcn = Finance::AMEX::Transaction::GRRCN->new;

=method parse_line

Returns one of the L<Finance::AMEX::Transaction::GRRCN::Header>, L<Finance::AMEX::Transaction::GRRCN::Summary>, L<Finance::AMEX::Transaction::GRRCN::TaxRecord>, L<Finance::AMEX::Transaction::GRRCN::Submission>, L<Finance::AMEX::Transaction::GRRCN::Transaction>, L<Finance::AMEX::Transaction::GRRCN::TxnPricing>, L<Finance::AMEX::Transaction::GRRCN::Chargeback>, L<Finance::AMEX::Transaction::GRRCN::Adjustment>, L<Finance::AMEX::Transaction::GRRCN::FeeRevenue>, L<Finance::AMEX::Transaction::GRRCN::Trailer>, or L<Finance::AMEX::Transaction::GRRCN::Unknown> records depending on the contents of the line.

 my $record = $grrcn->parse_line('line from a grrcn file');
