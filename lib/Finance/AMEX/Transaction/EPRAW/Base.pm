package Finance::AMEX::Transaction::EPRAW::Base;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Chargeback Notification Files (EPRAW) Base methods

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

  # if the line is not long enough to handle the start of the field,
  # it is an optional field that we don't have
  if (length($self->{_line}) < $map->[0]) {
    return '';
  }

  my $ret = substr($self->{_line}, $map->[0] - 1, $map->[1]);
  $ret =~ s{\s+\z}{};
  return $ret;
}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::EPRAW::Base - Shared methods for AMEX reconciliation file records.

=head1 DESCRIPTION

Don't use this module directly, it is the base module for EPRAW::Header, EPRAW::Detail, and EPRAW::Trailer objects.

=method new

The shared new method.

=method line

The shared line method.
