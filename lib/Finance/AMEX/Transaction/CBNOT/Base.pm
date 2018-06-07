package Finance::AMEX::Transaction::CBNOT::Base;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Chargeback Notification Files (CBNOT) Base methods

sub new {
  my ($class, %props) = @_;
  my $self = bless {
    _line => $props{line},
  }, $class;

  return $self;
}

sub line {
  my ($self) = @_;
  return $self->{_line};
}

sub _get_column {
  my ($self, $field) = @_;
  my $map = $self->field_map->{$field};

  my $ret = substr($self->{_line}, $map->[0] - 1, $map->[1]);
  $ret =~ s{\s+\z}{};
  return $ret;
}

sub REC_TYPE {
  my ($self) = @_;
  return $self->_get_column('REC_TYPE');
}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::CBNOT::Base - Shared methods for AMEX chargeback notification file records.

=head1 DESCRIPTION

Don't use this module directly, it is the base module for CBNOT::Header, CBNOT::Detail, and CBNOT::Trailer objects.

=method new

The shared new method.

=method line

The shared line method.

=method REC_TYPE

The shared REC_TYPE method.
