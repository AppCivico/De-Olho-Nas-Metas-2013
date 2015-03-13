package SMM::Schema::ResultSet::Event;
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
                description => {
                    required => 1,
                    type     => 'Str',
                },
                date => {
                    required => 1,
                    type     => 'Str',
                },
                campaign_id => {
                    required => 0,
                    type     => 'Str',
                },
                user_id => {
                    required => 0,
                    type     => 'Str',
                },
            }
        )
    };
}

sub action_specs {
    my $self = shift;
    return {
        create => sub {
            my %values  = shift->valid_values;
            my $event = $self->create( \%values );
            return $event;
        }
    };
}

1;
