package Finance::AMEX::Transaction::EPTRN::Trailer;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Transaction/Invoice Level Reconciliation (EPTRN) Trailer Rows

use base 'Finance::AMEX::Transaction::EPTRN::Base';

sub field_map {
  return {
    DF_TRL_RECORD_TYPE   => [1,  5],
    DF_TRL_DATE          => [6,  8],
    DF_TRL_TIME          => [14, 4],
    DF_TRL_FILE_ID       => [18, 6],
    DF_TRL_FILE_NAME     => [24, 20],
    DF_TRL_RECIPIENT_KEY => [44, 40],
    DF_TRL_RECORD_COUNT  => [84, 7],
  };
}

sub type {return 'TRAILER'}

sub DF_TRL_RECORD_TYPE   {return $_[0]->_get_column('DF_TRL_RECORD_TYPE')}
sub DF_TRL_DATE          {return $_[0]->_get_column('DF_TRL_DATE')}
sub DF_TRL_TIME          {return $_[0]->_get_column('DF_TRL_TIME')}
sub DF_TRL_FILE_ID       {return $_[0]->_get_column('DF_TRL_FILE_ID')}
sub DF_TRL_FILE_NAME     {return $_[0]->_get_column('DF_TRL_FILE_NAME')}
sub DF_TRL_RECIPIENT_KEY {return $_[0]->_get_column('DF_TRL_RECIPIENT_KEY')}
sub DF_TRL_RECORD_COUNT  {return $_[0]->_get_column('DF_TRL_RECORD_COUNT')}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::EPTRN::Trailer - Object methods for AMEX Transaction/Invoice Level Reconciliation (EPTRN) Trailer Rows

=head1 SYNOPSIS

 use Finance::AMEX::Transaction;

 my $epraw = Finance::AMEX::Transaction->new(file_type => 'EPTRN');
 open my $fh, '<', '/path to EPTRN file' or die "cannot open EPTRN file: $!";

 while (my $record = $epraw->getline($fh)) {

  if ($record->type eq 'FOOTER') {
    print $record->DF_TRL_DATE . "\n";
  }
 }

 # to parse a single line

 my $record = $epraw->parse_line('line from an EPTRN  file');
 if ($record->type eq 'TRAILER') {
   ...
 }

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

=method new

Returns a new L<Finance::AMEX::Transaction::EPTRN::Trailer> object.

 my $record = Finance::AMEX::Transaction::EPTRN::Trailer->new(line => $line);

=method type

This will always return the string TRAILER.

 print $record->type; # TRAILER

=method line

Returns the full line that is represented by this object.

 print $record->line;

=method field_map

Returns a hashref where the name is the record name and 
the value is an arrayref of the start position and length of that field.

 # print the start position of the DF_TRL_DATE field
 print $record->field_map->{DF_TRL_DATE}->[0]; # 6

=method DF_TRL_RECORD_TYPE

This field contains the constant literal "DFTRL", a Record Type code that indicates that this is a Data File Trailer Record.

=method DF_TRL_DATE

This field contains the File Creation Date.

The format is: MMDDYYYY

=for :list
= MM = Month
= DD = Day
= YYYY = Year

=method DF_TRL_TIME

This field contains the File Creation Time (24-hour format), when the file was created.

The format is: HHMM

=for :list
= HH = Hours
= MM = Minutes

=method DF_TRL_FILE_ID

This field contains an American Express, system-generated, File ID number that uniquely identifies this data file.

=method DF_TRL_FILE_NAME

This field contains the File Name (as entered in the American Express data distribution database) that corresponds to DF_TRL_FILE_ID.

=method DF_TRL_RECIPIENT_KEY

This field contains the Recipient Key, a unique, American Express, system-generated number that identifies this data file.

Note: This number is unique to each individual file.

=method DF_TRL_RECORD_COUNT

This field contains the Record Count for all items in this data file, including the header and trailer records.
