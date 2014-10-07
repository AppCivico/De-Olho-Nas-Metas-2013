use utf8;
package SMM::Schema::Result::District;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::District

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

=head1 TABLE: C<district>

=cut

__PACKAGE__->table("district");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'district_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 city_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 center_lat_long

  data_type: 'point'
  is_nullable: 0

=head2 perimeter

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "district_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "city_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "center_lat_long",
  { data_type => "point", is_nullable => 0 },
  "perimeter",
  { data_type => "text", is_nullable => 0 },
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
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 goals

Type: has_many

Related object: L<SMM::Schema::Result::Goal>

=cut

__PACKAGE__->has_many(
  "goals",
  "SMM::Schema::Result::Goal",
  { "foreign.district_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 prefectures

Type: has_many

Related object: L<SMM::Schema::Result::Prefecture>

=cut

__PACKAGE__->has_many(
  "prefectures",
  "SMM::Schema::Result::Prefecture",
  { "foreign.district_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 projects

Type: has_many

Related object: L<SMM::Schema::Result::Project>

=cut

__PACKAGE__->has_many(
  "projects",
  "SMM::Schema::Result::Project",
  { "foreign.district_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-10-06 19:49:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0i+B3T2bnRhfQ8tE7UbKGA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
