use utf8;
package SMM::Schema::Result::Management;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Management

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<management>

=cut

__PACKAGE__->table("management");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'management_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 start_date

  data_type: 'text'
  is_nullable: 0

=head2 expected_end_date

  data_type: 'text'
  is_nullable: 0

=head2 city_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 organization_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 active

  data_type: 'boolean'
  is_nullable: 1

=head2 created_at

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "management_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "start_date",
  { data_type => "text", is_nullable => 0 },
  "expected_end_date",
  { data_type => "text", is_nullable => 0 },
  "city_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "organization_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "active",
  { data_type => "boolean", is_nullable => 1 },
  "created_at",
  { data_type => "text", is_nullable => 1 },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 goals

Type: has_many

Related object: L<SMM::Schema::Result::Goal>

=cut

__PACKAGE__->has_many(
  "goals",
  "SMM::Schema::Result::Goal",
  { "foreign.management_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organization

Type: belongs_to

Related object: L<SMM::Schema::Result::Organization>

=cut

__PACKAGE__->belongs_to(
  "organization",
  "SMM::Schema::Result::Organization",
  { id => "organization_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-12-07 13:48:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MUCAimnM3MMRyacUoodEDQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
