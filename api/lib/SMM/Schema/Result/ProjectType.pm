use utf8;
package SMM::Schema::Result::ProjectType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::ProjectType

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

=head1 TABLE: C<project_types>

=cut

__PACKAGE__->table("project_types");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'project_types_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "project_types_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 milestones

Type: has_many

Related object: L<SMM::Schema::Result::Milestone>

=cut

__PACKAGE__->has_many(
  "milestones",
  "SMM::Schema::Result::Milestone",
  { "foreign.project_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_milestones

Type: has_many

Related object: L<SMM::Schema::Result::ProjectMilestone>

=cut

__PACKAGE__->has_many(
  "project_milestones",
  "SMM::Schema::Result::ProjectMilestone",
  { "foreign.project_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_progresses

Type: has_many

Related object: L<SMM::Schema::Result::ProjectProgress>

=cut

__PACKAGE__->has_many(
  "project_progresses",
  "SMM::Schema::Result::ProjectProgress",
  { "foreign.milestone_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 projects

Type: has_many

Related object: L<SMM::Schema::Result::Project>

=cut

__PACKAGE__->has_many(
  "projects",
  "SMM::Schema::Result::Project",
  { "foreign.type" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-03-24 02:47:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:O6ENqn9wc3zWcBy3+FLdHg

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
