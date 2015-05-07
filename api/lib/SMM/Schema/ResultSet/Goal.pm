package SMM::Schema::ResultSet::Goal;
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
                    required => 0,
                    type     => 'Str',
                },
                technically => {
                    required => 1,
                    type     => 'Str',
                },
                will_be_delivered => {
                    required => 0,
                    type     => 'Str',
                },
                expected_start_date => {
                    required => 0,
                    type     => 'Str',
                },
                expected_end_date => {
                    required => 0,
                    type     => 'Str',
                },
                start_date => {
                    required => 0,
                    type     => 'Str',
                },
                end_date => {
                    required => 0,
                    type     => 'Str',
                },
                percentage => {
                    required => 0,
                    type     => 'Str',
                },
                goal_number => {
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

            }
        )
    };
}

sub action_specs {
    my $self = shift;
    return {
        create => sub {
            my %values = shift->valid_values;
            my $goal   = $self->create( \%values );
            return $goal;
        }
    };
}

1;
