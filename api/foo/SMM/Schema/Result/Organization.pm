use utf8;
package SMM::Schema::Result::Organization;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Organization

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


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-12-07 13:48:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LwhmK4tDNbZZNW/xmofhgw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
