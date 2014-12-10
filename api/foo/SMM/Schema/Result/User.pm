use utf8;
package SMM::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::User

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

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'user_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 password

  data_type: 'text'
  is_nullable: 0

=head2 created_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 12

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
    sequence          => "user_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "email",
  { data_type => "text", is_nullable => 0 },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "password",
  { data_type => "text", is_nullable => 0 },
  "created_by",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "organization_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<user_email_key>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("user_email_key", ["email"]);

=head1 RELATIONS

=head2 created_by

Type: belongs_to

Related object: L<SMM::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "created_by",
  "SMM::Schema::Result::User",
  { id => "created_by" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 goals

Type: has_many

Related object: L<SMM::Schema::Result::Goal>

=cut

__PACKAGE__->has_many(
  "goals",
  "SMM::Schema::Result::Goal",
  { "foreign.user_id" => "self.id" },
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
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 user_roles

Type: has_many

Related object: L<SMM::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "SMM::Schema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_sessions

Type: has_many

Related object: L<SMM::Schema::Result::UserSession>

=cut

__PACKAGE__->has_many(
  "user_sessions",
  "SMM::Schema::Result::UserSession",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users

Type: has_many

Related object: L<SMM::Schema::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "SMM::Schema::Result::User",
  { "foreign.created_by" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-12-07 13:48:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sM3NKGYx/obEExzMbLL/Hw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
