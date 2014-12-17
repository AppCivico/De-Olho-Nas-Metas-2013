use utf8;
package SMM::Schema::Result::RasterColumn;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::RasterColumn

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
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<raster_columns>

=cut

__PACKAGE__->table("raster_columns");

=head1 ACCESSORS

=head2 r_table_catalog

  data_type: 'name'
  is_nullable: 1
  size: 64

=head2 r_table_schema

  data_type: 'name'
  is_nullable: 1
  size: 64

=head2 r_table_name

  data_type: 'name'
  is_nullable: 1
  size: 64

=head2 r_raster_column

  data_type: 'name'
  is_nullable: 1
  size: 64

=head2 srid

  data_type: 'integer'
  is_nullable: 1

=head2 scale_x

  data_type: 'double precision'
  is_nullable: 1

=head2 scale_y

  data_type: 'double precision'
  is_nullable: 1

=head2 blocksize_x

  data_type: 'integer'
  is_nullable: 1

=head2 blocksize_y

  data_type: 'integer'
  is_nullable: 1

=head2 same_alignment

  data_type: 'boolean'
  is_nullable: 1

=head2 regular_blocking

  data_type: 'boolean'
  is_nullable: 1

=head2 num_bands

  data_type: 'integer'
  is_nullable: 1

=head2 pixel_types

  data_type: 'text[]'
  is_nullable: 1

=head2 nodata_values

  data_type: 'double precision[]'
  is_nullable: 1

=head2 out_db

  data_type: 'boolean[]'
  is_nullable: 1

=head2 extent

  data_type: 'geometry'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "r_table_catalog",
  { data_type => "name", is_nullable => 1, size => 64 },
  "r_table_schema",
  { data_type => "name", is_nullable => 1, size => 64 },
  "r_table_name",
  { data_type => "name", is_nullable => 1, size => 64 },
  "r_raster_column",
  { data_type => "name", is_nullable => 1, size => 64 },
  "srid",
  { data_type => "integer", is_nullable => 1 },
  "scale_x",
  { data_type => "double precision", is_nullable => 1 },
  "scale_y",
  { data_type => "double precision", is_nullable => 1 },
  "blocksize_x",
  { data_type => "integer", is_nullable => 1 },
  "blocksize_y",
  { data_type => "integer", is_nullable => 1 },
  "same_alignment",
  { data_type => "boolean", is_nullable => 1 },
  "regular_blocking",
  { data_type => "boolean", is_nullable => 1 },
  "num_bands",
  { data_type => "integer", is_nullable => 1 },
  "pixel_types",
  { data_type => "text[]", is_nullable => 1 },
  "nodata_values",
  { data_type => "double precision[]", is_nullable => 1 },
  "out_db",
  { data_type => "boolean[]", is_nullable => 1 },
  "extent",
  { data_type => "geometry", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-12-16 09:32:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SOEdBNo79qdsRkwAv/eonA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
