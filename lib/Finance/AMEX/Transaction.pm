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
    _file_type   => undef,
    _file_format => undef,
    _parser      => undef,
  }, $class;

  my $type_map = {
    EPRAW => 'Finance::AMEX::Transaction::EPRAW',
    EPPRC => 'Finance::AMEX::Transaction::EPPRC',
    EPTRN => 'Finance::AMEX::Transaction::EPTRN',
    CBNOT => 'Finance::AMEX::Transaction::CBNOT',
    GRRCN => 'Finance::AMEX::Transaction::GRRCN',
  };

  $self->{_file_type}   = $props{file_type};
  $self->{_file_format} = $props{file_format};

  if ($self->file_type and exists $type_map->{$self->file_type}) {
    $self->{_parser} = $type_map->{$self->file_type}->new(file_format => $self->file_format);
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
  return $ret;
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

Sets the format of the file that we are parsing.  Currently only useful for L<Finance::AMEX::Transaction::GRRCN> files.  This can usually be auto-detected.

Should be one of FIXED, CSV, TSV.

=begin :list

= fixed

The file is in a fixed width format.

= csv

The file has comma seperated values.

= tsv

The file has tab seperated values.

=end :list

=end :list

=method file_type

Access method for the file type you set when calling C<new>

=method file_format

Access method for the file formated type that was set when calling C<new> or was auto-detected.

=method parser

Access method for the parser that is set depending on C<file_type>

=method getline

When passed a filehandle, takes the next line from the file and returns the appropriate object.

 my $record = $cbnot->getline($fh);

=method parse_line

Parses a single line from a file and returns the appropriate object.
