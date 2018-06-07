package Finance::AMEX::Transaction::GRRCN::Unknown;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Global Reconciliation (GRRCN)

sub new {
  my ($class, %props) = @_;
  my $self = bless {
    _line => $props{line},
  }, $class;
  return $self;
}

sub type {return 'UNKNOWN'}

sub line {
  my ($self) = @_;
  return $self->{_line};
}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::GRRCN::Unknown - Object methods for unknown AMEX reconciliation file records.

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

You should only be getting this type of object if it is an unknown or invalid GRRCN file or line.

=method new

Returns a new Finance::AMEX::Transaction::GRRCN::Unknown object.

 my $record = Finance::AMEX::Transaction::GRRCN::Unknown->new(line => $line);

=method type

This will always return the string UNKNOWN.

 print $record->type; # UNKNOWN

=method line

Returns the full line that was given to the object.
