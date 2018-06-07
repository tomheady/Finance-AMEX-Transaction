package Finance::AMEX::Transaction::GRRCN::Header;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Global Reconciliation (GRRCN) Header Rows

use base 'Finance::AMEX::Transaction::GRRCN::Base';

sub field_map {
  return {
    RECORD_TYPE         => [1, 10],
    FILE_CREATION_DATE  => [11, 8],
    FILE_CREATION_TIME  => [19, 6],
    SEQUENTIAL_NUMBER   => [25, 10],
    FILE_ID             => [35, 10],
    FILE_NAME           => [45, 20],
    FILE_VERSION_NUMBER => [65, 4],
  };
}

sub type {return 'HEADER'}

sub RECORD_TYPE         {return $_[0]->_get_column('RECORD_TYPE')}
sub FILE_CREATION_DATE  {return $_[0]->_get_column('FILE_CREATION_DATE')}
sub FILE_CREATION_TIME  {return $_[0]->_get_column('FILE_CREATION_TIME')}
sub SEQUENTIAL_NUMBER   {return $_[0]->_get_column('SEQUENTIAL_NUMBER')}
sub FILE_ID             {return $_[0]->_get_column('FILE_ID')}
sub FILE_NAME           {return $_[0]->_get_column('FILE_NAME')}
sub FILE_VERSION_NUMBER {return $_[0]->_get_column('FILE_VERSION_NUMBER')}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::GRRCN::Header - Object methods for Global Reconciliation records.

=head1 SYNOPSIS

 use Finance::AMEX::Transaction;

 my $epraw = Finance::AMEX::Transaction->new(file_type => 'GRRCN');
 open my $fh, '<', '/path to GRRCN file' or die "cannot open GRRCN file: $!";

 while (my $record = $epraw->getline($fh)) {

  if ($record->type eq 'HEADER') {
    print $record->FILE_CREATION_DATE . "\n";
  }
 }

 # to parse a single line

 my $record = $epraw->parse_line('line from an GRRCN  file');
 if ($record->type eq 'HEADER') {
   ...
 }

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

=method new

Returns a new Finance::AMEX::Transaction::GRRCN::Header object.

 my $record = Finance::AMEX::Transaction::GRRCN::Header->new(line => $line);

=method type

This will always return the string HEADER.

 print $record->type; # HEADER

=method line

Returns the full line that is represented by this object.

 print $record->line;

=method RECORD_TYPE

This field contains the Record identifier, which will always be “HEADER” for the Header Record.

=method FILE_CREATION_DATE

This field contains the File Creation Date.

The format is: YYYYMMDD

=for :list
= YYYY = Year
= MM   = Month
= DD   = Day

=method FILE_CREATION_TIME

This field contains the File Creation Time (24-hour format), when the file was created.

The format is: HHMMSS

=for :list
= HH = Hours
= MM = Minutes
= SS = Seconds

=method SEQUENTIAL_NUMBER

This field contains a Sequential Number, where each time a file is sent it will be incrementally higher than that in the previous file. It is intended to identify whether the file is a duplicate and ensure there has been no missing file.

A sequential number with a prefix of “A” indicates an Adhoc file.

=method FILE_ID

This field contains an American Express File ID, which will always be “GRRCN” for the Global Raw Data Reconciliation File.

=method FILE_NAME

This field contains the raw data profile name chosen by the consumer of this service. It is established during the file setup process and is intended to assist in recognizing the file.

=method FILE_VERSION_NUMBER

This field contains the version of the raw data format being consumed by the customer.
