package SMM::Schema::ResultSet::ProgressGoalCounsil;
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
                owned => {
                    required => 1,
                    type     => 'Num',
                },
                remainder => {
                    required => 1,
                    type     => 'Num',
                },
                goal_id => {
                    required => 1,
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
            my $progress_goal_counsil = $self->create( \%values );
            return $progress_goal_counsil;
        }
    };
}

1;
