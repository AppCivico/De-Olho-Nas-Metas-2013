package SMM::Schema::ResultSet::ImagesProject;
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
                project_id => {
                    required => 1,
                    type     => 'Int',
                },
                name_image => {
                    required => 1,
                    type     => 'Str',
                },
                description => {
                    required => 0,
                    type     => 'Str',
                },
                user_id => {
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
            my %values         = shift->valid_values;
            my $images_project = $self->create( \%values );
            return $images_project;
        }
    };
}

1;
