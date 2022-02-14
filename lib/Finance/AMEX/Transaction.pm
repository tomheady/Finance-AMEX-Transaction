package Finance::AMEX::Transaction;

use strict;
use warnings;

# ABSTRACT: Parse AMEX transaction files: EPRAW, EPPRC, EPTRN, CBNOT, GRRCN

use Finance::AMEX::Transaction::CBNOT;
use Finance::AMEX::Transaction::EPRAW;
use Finance::AMEX::Transaction::EPPRC;
use Finance::AMEX::Transaction::EPTRN;
use Finance::AMEX::Transaction::GRRCN;

sub new {
  my ($class, %props) = @_;

  my $self = bless {
    _file_type    => undef,
    _file_format  => undef,
    _file_version => undef,
    _parser       => undef,
  }, $class;

  my $type_map = {
    EPRAW => 'Finance::AMEX::Transaction::EPRAW',
    EPPRC => 'Finance::AMEX::Transaction::EPPRC',
    EPTRN => 'Finance::AMEX::Transaction::EPTRN',
    CBNOT => 'Finance::AMEX::Transaction::CBNOT',
    GRRCN => 'Finance::AMEX::Transaction::GRRCN',
  };

  $self->{_file_type}    = $props{file_type};
  $self->{_file_format}  = $props{file_format}  || 'UNKNOWN';
  $self->{_file_version} = $props{file_version} || 'UNKNOWN';

  if ($self->file_type and exists $type_map->{$self->file_type}) {
    $self->{_parser} = $type_map->{$self->file_type}->new(
      file_format  => $self->file_format,
      file_version => $self->file_version,
    );
  }

  return $self;
}

sub file_type {
  my ($self) = @_;

  return $self->{_file_type};
}

sub file_format {
  my ($self) = @_;

  return $self->{_file_format};
}

sub file_version {
  my ($self) = @_;

  return $self->{_file_version};
}

sub parser {
  my ($self) = @_;

  return $self->{_parser};
}

sub getline {
  my ($self, $fh) = @_;

  my $line = <$fh>;
  return $self->parse_line($line);
}

sub parse_line {
  my ($self, $line) = @_;

  my $ret = $self->{_parser}->parse_line($line);

  $self->_set_file_format;
  $self->_set_file_version;

  return $ret;
}

sub _set_file_format {
  my ($self) = @_;

  return if not $self->file_format eq 'UNKNOWN';
  return if $self->file_format eq $self->{_parser}->file_format;
  return if $self->{_parser}->file_format eq 'UNKNOWN';

  $self->{_file_format} = $self->{_parser}->file_format;

  return $self->file_format;
}

sub _set_file_version {
  my ($self) = @_;

  return if not $self->file_version eq 'UNKNOWN';
  return if $self->file_version eq $self->{_parser}->file_version;
  return if $self->{_parser}->file_version eq 'UNKNOWN';

  $self->{_file_version} = $self->{_parser}->file_version;

  return $self->file_version;
}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction - Parse AMEX transaction files: EPRAW, EPPRC, EPA, CBNOT, GRRCN

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

This module parses AMEX transaction files and returns object that are appropriate for the line that it was asked to parse.

=method new

Creates a new L<Finance::AMEX::Transaction> object.  Required options are C<file_type>).

 my $cbnot = Finance::AMEX::Transaction->new(file_type => 'CBNOT');

=begin :list

= C<file_type> (required)

Sets the type of file that we are parsing.  Valid values are:

=begin :list

= EPRAW

returns L<Finance::AMEX::Transaction::EPRAW> objects.

= EPPRC

returns L<Finance::AMEX::Transaction::EPPRC> objects.

= EPTRN

returns L<Finance::AMEX::Transaction::EPTRN> objects.

= CBNOT

returns L<Finance::AMEX::Transaction::CBNOT> objects.

= GRRCN

returns L<Finance::AMEX::Transaction::GRRCN> objects.

=end :list

= C<file_format>

Sets the format of the file that we are parsing.  Currently only useful for L<Finance::AMEX::Transaction::GRRCN> files.  This should be auto-detected after the first row is parsed.

Should be one of FIXED, CSV, TSV.

=begin :list

= fixed

The file is in a fixed width format.

= csv

The file has comma separated values.

= tsv

The file has tab separated values.

=end :list

= C<file_version>

Sets the version of the file we are parsing.  Currently only useful for L<Finance::AMEX::Transaction::GRRCN> files.  This should be auto-detected after the HEADER row is parsed.

Should be one of 1.01, 2.01, 3.01.

=end :list

=method file_type

Access method for the file type you set when calling C<new>

=method file_format

Access method for the file formatted type that was set when calling C<new> or was auto-detected after the first row is parsed.

=method file_version

Access method for the file version that was set when calling C<new> or was auto-detected after the HEADER row is parsed.

=method parser

Access method for the parser that is set depending on C<file_type>

=method getline

When passed a filehandle, takes the next line from the file and returns the appropriate object.

 my $record = $cbnot->getline($fh);

=method parse_line

Parses a single line from a file and returns the appropriate object.
