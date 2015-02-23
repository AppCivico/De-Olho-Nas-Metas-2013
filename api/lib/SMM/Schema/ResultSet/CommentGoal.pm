package SMM::Schema::ResultSet::CommentGoal;
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
			    user_id => {
                    required => 1,
                    type     => 'Int',
                },
                description => {
                    required => 1,
                    type     => 'Str',
                },
				goal_id => {
					required => 1,
					type     => 'Int',
				},
				approved => {
					required => 0,
					type     => 'Bool',
				}
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

            my $comment = $self->create( \%values );
            return $comment;
        }
    };
}

1;
