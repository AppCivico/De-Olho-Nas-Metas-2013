package SMM::Schema::ResultSet::Region;
use namespace::autoclean;

use utf8;
use Moose;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;
extends 'DBIx::Class::ResultSet';
with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::InflateAsHashRef';

use Data::Verifier;

sub verifiers_specs {
    my $self = shift;
    return {
        create => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name => {
                    required => 1,
                    type     => 'Str',
                },
                geom => {
                    required => 0,
                    type     => 'Str',
                },
                lat => {
                    required => 0,
                    type     => 'Str',
                },
                long => {
                    required => 0,
                    type     => 'Int',
                },
            }
        )
    };
}

sub action_specs {
    my $self = shift;
    return {
        create => sub {
            my %values = shift->valid_values;

            my $region = $self->create( \%values );
            return $region;
        }
    };
}

1;
