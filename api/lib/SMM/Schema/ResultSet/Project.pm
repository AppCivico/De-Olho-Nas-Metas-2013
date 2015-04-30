package SMM::Schema::ResultSet::Project;
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
                address => {
                    required => 0,
                    type     => 'Str',
                },
                latitude => {
                    required => 0,
                    type     => 'Str',
                },
                longitude => {
                    required => 0,
                    type     => 'Str',
                },
                region_id => {
                    required => 0,
                    type     => 'Int',
                },
                project_number => {
                    required => 1,
                    type     => 'Int',
                },
                qualitative_progress_1 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_2 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_3 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_4 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_5 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_6 => {
                    required => 0,
                    type     => 'Str',
                },
                percentage => {
                    required => 0,
                    type     => 'Str',
                },
                goal_id => {
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
            my %values  = shift->valid_values;
            my $project = $self->create( \%values );
            return $project;
        }
    };
}

1;
