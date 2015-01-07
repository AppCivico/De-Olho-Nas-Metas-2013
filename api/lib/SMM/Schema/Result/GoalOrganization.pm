use utf8;
package SMM::Schema::Result::GoalOrganization;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::GoalOrganization

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

=head1 TABLE: C<goal_organization>

=cut

__PACKAGE__->table("goal_organization");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'goal_organization_id_seq'

=head2 goal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 organization_id

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
    sequence          => "goal_organization_id_seq",
  },
  "goal_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "organization_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 goal

Type: belongs_to

Related object: L<SMM::Schema::Result::Goal>

=cut

__PACKAGE__->belongs_to(
  "goal",
  "SMM::Schema::Result::Goal",
  { id => "goal_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 organization

Type: belongs_to

Related object: L<SMM::Schema::Result::Organization>

=cut

__PACKAGE__->belongs_to(
  "organization",
  "SMM::Schema::Result::Organization",
  { id => "organization_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2015-01-06 17:54:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EPuRebrFoU64TLg6PPWKCw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
