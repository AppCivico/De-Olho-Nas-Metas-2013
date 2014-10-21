package SMM::Schema::ResultSet::PreRegister;
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
                username => {
                    required => 1,
                    type     => 'Str',
				    post_check => sub {
                        my $r = shift;
                        return 0 if ( $self->find( { username => lc $r->get_value('username') } ) );
                        return 1;
                      }

                },
                email => {
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
            my %values       = shift->valid_values;
            my $preregister = $self->create( \%values );
            return $preregister;
        }
    };
}

1;
