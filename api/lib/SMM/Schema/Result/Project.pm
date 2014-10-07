use utf8;
package SMM::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Project

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

=head1 TABLE: C<project>

=cut

__PACKAGE__->table("project");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'project_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 district_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 address

  data_type: 'text'
  is_nullable: 0

=head2 latitude

  data_type: 'text'
  is_nullable: 1

=head2 longitude

  data_type: 'text'
  is_nullable: 1

=head2 budget_executed

  data_type: 'double precision'
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 update_at

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "project_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "district_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "address",
  { data_type => "text", is_nullable => 0 },
  "latitude",
  { data_type => "text", is_nullable => 1 },
  "longitude",
  { data_type => "text", is_nullable => 1 },
  "budget_executed",
  { data_type => "double precision", is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "update_at",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 district

Type: belongs_to

Related object: L<SMM::Schema::Result::District>

=cut

__PACKAGE__->belongs_to(
  "district",
  "SMM::Schema::Result::District",
  { id => "district_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 project_prefectures

Type: has_many

Related object: L<SMM::Schema::Result::ProjectPrefecture>

=cut

__PACKAGE__->has_many(
  "project_prefectures",
  "SMM::Schema::Result::ProjectPrefecture",
  { "foreign.project_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-10-06 19:49:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HKC1EPqqUTSAVLdoxPV04A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
