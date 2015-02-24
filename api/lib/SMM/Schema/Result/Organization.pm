use utf8;
package SMM::Schema::Result::Organization;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Organization

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

=head1 TABLE: C<organization>

=cut

__PACKAGE__->table("organization");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'organization_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 address

  data_type: 'text'
  is_nullable: 1

=head2 postal_code

  data_type: 'text'
  is_nullable: 1

=head2 city_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 email

  data_type: 'text'
  is_nullable: 1

=head2 website

  data_type: 'text'
  is_nullable: 1

=head2 phone

  data_type: 'text'
  is_nullable: 1

=head2 number

  data_type: 'text'
  is_nullable: 1

=head2 complement

  data_type: 'text'
  is_nullable: 1

=head2 subprefecture_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "organization_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "address",
  { data_type => "text", is_nullable => 1 },
  "postal_code",
  { data_type => "text", is_nullable => 1 },
  "city_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "email",
  { data_type => "text", is_nullable => 1 },
  "website",
  { data_type => "text", is_nullable => 1 },
  "phone",
  { data_type => "text", is_nullable => 1 },
  "number",
  { data_type => "text", is_nullable => 1 },
  "complement",
  { data_type => "text", is_nullable => 1 },
  "subprefecture_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 city

Type: belongs_to

Related object: L<SMM::Schema::Result::City>

=cut

__PACKAGE__->belongs_to(
  "city",
  "SMM::Schema::Result::City",
  { id => "city_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 comment_projects

Type: has_many

Related object: L<SMM::Schema::Result::CommentProject>

=cut

__PACKAGE__->has_many(
  "comment_projects",
  "SMM::Schema::Result::CommentProject",
  { "foreign.org_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 goal_organizations

Type: has_many

Related object: L<SMM::Schema::Result::GoalOrganization>

=cut

__PACKAGE__->has_many(
  "goal_organizations",
  "SMM::Schema::Result::GoalOrganization",
  { "foreign.organization_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 managements

Type: has_many

Related object: L<SMM::Schema::Result::Management>

=cut

__PACKAGE__->has_many(
  "managements",
  "SMM::Schema::Result::Management",
  { "foreign.organization_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 subprefecture

Type: belongs_to

Related object: L<SMM::Schema::Result::Subprefecture>

=cut

__PACKAGE__->belongs_to(
  "subprefecture",
  "SMM::Schema::Result::Subprefecture",
  { id => "subprefecture_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 user_follow_counsils

Type: has_many

Related object: L<SMM::Schema::Result::UserFollowCounsil>

=cut

__PACKAGE__->has_many(
  "user_follow_counsils",
  "SMM::Schema::Result::UserFollowCounsil",
  { "foreign.counsil_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users

Type: has_many

Related object: L<SMM::Schema::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "SMM::Schema::Result::User",
  { "foreign.organization_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2015-02-20 11:02:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:u2sy7NGB6Fej55idYllVPg
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
                address => {
                    required => 0,
                    type     => 'Str',
                },
                postal_code => {
                    required => 0,
                    type     => 'Str',
                },
                city_id => {
                    required => 0,
                    type     => 'Int',
                },
                description => {
                    required => 0,
                    type     => 'Str',
                },
                phone => {
                    required => 0,
                    type     => 'Str',
                },
                email => {
                    required => 0,
                    type     => 'Str',
                },
                website => {
                    required => 0,
                    type     => 'Str',
                },
                complement => {
                    required => 0,
                    type     => 'Str',
                },
                number => {
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

            my $organization = $self->update( \%values );

            return $organization;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
