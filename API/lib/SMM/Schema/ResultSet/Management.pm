package SMM::Schema::ResultSet::Management;
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
                start_date => {
                    required => 0,
                    type     => 'Str',
                },
                expected_end_date => {
                    required => 0,
                    type     => 'Str',
                },
                city_id => {
                    required => 0,
                    type     => 'Int',
                },
                organization_id => {
                    required => 1,
                    type     => 'Int',
                },
                active => {
		    required => 0,
                    type     => 'Bool',
                },
                created_at => {
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
			my $management = $self->create( \%values );
			return $management;
        }
    };
}

1;
