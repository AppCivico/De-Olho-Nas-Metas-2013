use utf8;
package SMM::Schema::Result::OrganizationType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::OrganizationType

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<organization_type>

=cut

__PACKAGE__->table("organization_type");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'organization_type_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 type

  data_type: 'enum'
  extra: {custom_type_name => "org_type",list => ["counsil","organization"]}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "organization_type_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "type",
  {
    data_type => "enum",
    extra => { custom_type_name => "org_type", list => ["counsil", "organization"] },
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 organizations

Type: has_many

Related object: L<SMM::Schema::Result::Organization>

=cut

__PACKAGE__->has_many(
  "organizations",
  "SMM::Schema::Result::Organization",
  { "foreign.organization_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-10-13 14:22:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0Fp4nUHDjb4owyWTh1ZpSw
with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;

sub verifiers_specs {
    my $self = shift;
    return {
        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name => {
                    required => 0,
                    type     => 'Str',
                },
            }
        ),
    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $organization_type = $self->update( \%values );

            return $organization_type;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
