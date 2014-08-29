use utf8;
package SMM::Schema::Result::Management;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Management

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

  data_type: 'text'
  is_nullable: 0

=head2 organization_id

  data_type: 'text'
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
  { data_type => "text", is_nullable => 0 },
  "organization_id",
  { data_type => "text", is_nullable => 0 },
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


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-08-28 21:03:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0ni6DtAbwl32aGM4pP6/4A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
