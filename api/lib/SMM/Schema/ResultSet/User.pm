package SMM::Schema::ResultSet::User;
use namespace::autoclean;

use utf8;
use Moose;
extends 'DBIx::Class::ResultSet';
with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::InflateAsHashRef';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;

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
                username => {
                    required => 0,
                    type     => 'Str',
                },
                phone_number => {
                    required => 1,
                    type     => 'Str',
                },
                organization_id => {
                    required => 0,
                    type     => 'Int',
                },
                password => {
                    required  => 1,
                    type      => 'Str',
                    dependent => {
                        password_confirm => {
                            required => 1,
                            type     => 'Str',
                        },
                    },
                    post_check => sub {
                        my $r = shift;
                        return $r->get_value('password') eq
                          $r->get_value('password_confirm');
                    },
                },
                role => {
                    required => 0,
                    type     => 'Str',
                },
                hash => {
                    required => 0,
                    type     => 'Str',
                },
                email => {
                    required   => 1,
                    type       => EmailAddress,
                    post_check => sub {
                        my $r = shift;
                        return 0
                          if (
                            $self->find(
                                { email => lc $r->get_value('email') }
                            )
                          );
                        return 1;
                    }
                },
                active => {
                    required => 0,
                    type     => 'Bool'
                },
            },
        ),
        login => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                email => {
                    required => 1,
                    type     => EmailAddress
                },
                password => {
                    required => 1,
                    type     => 'Str',
                },
            }
        ),
        check_email => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                email => {
                    required => 1,
                    type     => EmailAddress
                }
            }
        ),
        reset_password_key => {
            required => 0,
            type     => 'Str'
        }
    };
}

sub action_specs {
    my $self = shift;
    return {
        login => sub { 1 },

        create => sub {
            my %values = shift->valid_values;

            delete $values{password_confirm};

            $values{email} = lc $values{email};
            my $role = delete $values{role};
            my $hash = delete $values{hash};
			if ($hash){
				$self->resultset('InviteCounsil')->search({ hash => $hash})->update({ valid_until => 0});
			}
            my $user = $self->create( \%values );
            if ($role) {
                $user->set_roles( { name => $role } );
            }

            return $user;
        }

    };
}

1;

