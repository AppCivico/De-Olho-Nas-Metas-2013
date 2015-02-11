package SMM::Schema::ResultSet::ProjectEventRead;
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
			    project_event_id => {
                    required => 1,
                    type     => 'Int',
                },
                user_id => {
                    required => 1,
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
            my %values     = shift->valid_values;
            not defined $values{$_} and delete $values{$_} for keys %values;

            my $project_event_read = $self->create( \%values );
            return $project_event_read;
        }
    };
}

1;
