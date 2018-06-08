package Finance::AMEX::Transaction::EPPRC::Header;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Transaction/Invoice Level Reconciliation (EPPRC) Header Rows

use base 'Finance::AMEX::Transaction::EPPRC::Base';

sub field_map {
  return {
    DF_HDR_RECORD_TYPE => [1, 5],
    DF_HDR_DATE        => [6, 8],
    DF_HDR_TIME        => [14, 4],
    DF_HDR_FILE_ID     => [18, 6],
    DF_HDR_FILE_NAME   => [24, 20],
  };
}

sub type {return 'HEADER'}

sub DF_HDR_RECORD_TYPE {return $_[0]->_get_column('DF_HDR_RECORD_TYPE')}
sub DF_HDR_DATE        {return $_[0]->_get_column('DF_HDR_DATE')}
sub DF_HDR_TIME        {return $_[0]->_get_column('DF_HDR_TIME')}
sub DF_HDR_FILE_ID     {return $_[0]->_get_column('DF_HDR_FILE_ID')}
sub DF_HDR_FILE_NAME   {return $_[0]->_get_column('DF_HDR_FILE_NAME')}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::EPPRC::Header - Object methods for AMEX Reconciliation file header records.

=head1 SYNOPSIS

 use Finance::AMEX::Transaction;

 my $epraw = Finance::AMEX::Transaction->new(file_type => 'EPPRC');
 open my $fh, '<', '/path to EPPRC file' or die "cannot open EPPRC file: $!";

 while (my $record = $epraw->getline($fh)) {

  if ($record->type eq 'HEADER') {
    print $record->DF_HDR_DATE . "\n";
  }
 }

 # to parse a single line

 my $record = $epraw->parse_line('line from an EPPRC  file');
 if ($record->type eq 'HEADER') {
   ...
 }

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

=method new

Returns a new L<Finance::AMEX::Transaction::EPPRC::Header> object.

 my $record = Finance::AMEX::Transaction::EPPRC::Header->new(line => $line);

=method type

This will always return the string HEADER.

 print $record->type; # HEADER

=method line

Returns the full line that is represented by this object.

 print $record->line;

=method DF_HDR_RECORD_TYPE

This field contains the constant literal “DFHDR”, a Record Type code that indicates that this is a Data File Header Record.

=method DF_HDR_DATE

This field contains the File Creation Date. The format is: MMDDYYYY

=for :list
= MM = Month
= DD = Day
= YYYY = Year

=method DF_HDR_TIME

This field contains the File Creation Time (24-hour format), when the file was created.

The format is: HHMM

=for :list
= HH = Hours
= MM = Minutes

=method DF_HDR_FILE_ID

This field may contain an American Express, system-generated, File ID number that uniquely identifies this data file.

If unused, this field is zero filled.

=method DF_HDR_FILE_NAME

This field may contain a File Name (as entered in the American Express data distribution database) that corresponds to DF_HDR_FILE_ID. Alternately, it may be populated with the first line of settlement name/address data.
