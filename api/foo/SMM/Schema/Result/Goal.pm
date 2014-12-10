use utf8;
package SMM::Schema::Result::Goal;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Goal

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

=head1 TABLE: C<goal>

=cut

__PACKAGE__->table("goal");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'goal_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 will_be_delivered

  data_type: 'text'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 0

=head2 technically

  data_type: 'text'
  is_nullable: 0

=head2 expected_start_date

  data_type: 'timestamp'
  is_nullable: 1

=head2 expected_end_date

  data_type: 'timestamp'
  is_nullable: 1

=head2 start_date

  data_type: 'date'
  is_nullable: 1

=head2 end_date

  data_type: 'date'
  is_nullable: 1

=head2 porcentage

  data_type: 'text'
  is_nullable: 1

=head2 management_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 update_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 country_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 state_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 city_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 district_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 lat_lng

  data_type: 'text'
  is_nullable: 1

=head2 status_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 original_link

  data_type: 'text'
  is_nullable: 1

=head2 keywords

  data_type: 'text[]'
  is_nullable: 1

=head2 expected_budget

  data_type: 'double precision'
  is_nullable: 1

=head2 real_value_expended

  data_type: 'double precision'
  is_nullable: 1

=head2 origin

  data_type: 'text'
  is_nullable: 1

=head2 transversality

  data_type: 'text'
  is_nullable: 1

=head2 objective_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "goal_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "will_be_delivered",
  { data_type => "text", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "technically",
  { data_type => "text", is_nullable => 0 },
  "expected_start_date",
  { data_type => "timestamp", is_nullable => 1 },
  "expected_end_date",
  { data_type => "timestamp", is_nullable => 1 },
  "start_date",
  { data_type => "date", is_nullable => 1 },
  "end_date",
  { data_type => "date", is_nullable => 1 },
  "porcentage",
  { data_type => "text", is_nullable => 1 },
  "management_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "update_at",
  { data_type => "timestamp", is_nullable => 1 },
  "country_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "state_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "city_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "district_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "lat_lng",
  { data_type => "text", is_nullable => 1 },
  "status_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "original_link",
  { data_type => "text", is_nullable => 1 },
  "keywords",
  { data_type => "text[]", is_nullable => 1 },
  "expected_budget",
  { data_type => "double precision", is_nullable => 1 },
  "real_value_expended",
  { data_type => "double precision", is_nullable => 1 },
  "origin",
  { data_type => "text", is_nullable => 1 },
  "transversality",
  { data_type => "text", is_nullable => 1 },
  "objective_id",
  { data_type => "integer", is_nullable => 1 },
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

=head2 district

Type: belongs_to

Related object: L<SMM::Schema::Result::District>

=cut

__PACKAGE__->belongs_to(
  "district",
  "SMM::Schema::Result::District",
  { id => "district_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 goal_projects

Type: has_many

Related object: L<SMM::Schema::Result::GoalProject>

=cut

__PACKAGE__->has_many(
  "goal_projects",
  "SMM::Schema::Result::GoalProject",
  { "foreign.goal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 goal_secretaries

Type: has_many

Related object: L<SMM::Schema::Result::GoalSecretary>

=cut

__PACKAGE__->has_many(
  "goal_secretaries",
  "SMM::Schema::Result::GoalSecretary",
  { "foreign.goal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 management

Type: belongs_to

Related object: L<SMM::Schema::Result::Management>

=cut

__PACKAGE__->belongs_to(
  "management",
  "SMM::Schema::Result::Management",
  { id => "management_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
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

=head2 status

Type: belongs_to

Related object: L<SMM::Schema::Result::Status>

=cut

__PACKAGE__->belongs_to(
  "status",
  "SMM::Schema::Result::Status",
  { id => "status_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 user

Type: belongs_to

Related object: L<SMM::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "SMM::Schema::Result::User",
  { id => "user_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-12-07 13:48:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kfWm8r4melkkr8KGFL8mcw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
