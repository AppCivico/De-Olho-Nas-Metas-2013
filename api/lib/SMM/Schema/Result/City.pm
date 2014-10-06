use utf8;

package SMM::Schema::Result::City;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::City

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

__PACKAGE__->load_components( "InflateColumn::DateTime", "TimeStamp",
    "PassphraseColumn" );

=head1 TABLE: C<city>

=cut

__PACKAGE__->table("city");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 name_url

  data_type: 'text'
  is_nullable: 1

=head2 state_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 country_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
    "id",
    { data_type => "integer", is_nullable => 0 },
    "name",
    { data_type => "text", is_nullable => 0 },
    "name_url",
    { data_type => "text", is_nullable => 1 },
    "state_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
    "country_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 country

Type: belongs_to

Related object: L<SMM::Schema::Result::Country>

=cut

__PACKAGE__->belongs_to(
    "country",
    "SMM::Schema::Result::Country",
    { id => "country_id" },
    {
        is_deferrable => 0,
        join_type     => "LEFT",
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION",
    },
);

=head2 managements

Type: has_many

Related object: L<SMM::Schema::Result::Management>

=cut

__PACKAGE__->has_many(
    "managements",
    "SMM::Schema::Result::Management",
    { "foreign.city_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 organizations

Type: has_many

Related object: L<SMM::Schema::Result::Organization>

=cut

__PACKAGE__->has_many(
    "organizations",
    "SMM::Schema::Result::Organization",
    { "foreign.city_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 state

Type: belongs_to

Related object: L<SMM::Schema::Result::State>

=cut

__PACKAGE__->belongs_to(
    "state",
    "SMM::Schema::Result::State",
    { id => "state_id" },
    {
        is_deferrable => 0,
        join_type     => "LEFT",
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION",
    },
);

# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-09-01 15:52:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6NWvM6RfEKS0r54Wj3/LVg

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
