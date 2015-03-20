package SMM::Schema::ResultSet::Campaign;
use namespace::autoclean;

use utf8;
use Moose;
use MooseX::Types::Email qw/EmailAddress/;
extends 'DBIx::Class::ResultSet';
with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::InflateAsHashRef';
use SMM::Types qw /DataStr TimeStr/;

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
                start_in => {
                    required => 0,
                    type     => DataStr,
					post_check => sub {
                        my $r = shift;
						use DDP; p $r;
						return 0 unless  $r->get_value('start_in') <
                          $r->get_value('end_on');
						return 1;

                    },

                },
                end_on => {
                    required => 0,
                    type     => DataStr,
					post_check => sub {
                        my $r = shift;
                        return 0 unless  $r->get_value('start_in') <
                          $r->get_value('end_on');
						return 1;
						
                    },

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
            my $campaign = $self->create( \%values );
            return $campaign;
        }
    };
}

1;
