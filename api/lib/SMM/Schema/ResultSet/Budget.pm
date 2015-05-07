package SMM::Schema::ResultSet::Budget;
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
                business_name => {
                    required => 1,
                    type     => 'Str',
                },
                business_name_url => {
                    required => 1,
                    type     => 'Str',
                },
                dedicated_value => {
                    required => 0,
                    type     => 'Str',
                },
                liquidated_value => {
                    required => 0,
                    type     => 'Str',
                },
                observation => {
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
            my $company = $self->create( \%values );
            return $company;
        }
    };
}

1;
