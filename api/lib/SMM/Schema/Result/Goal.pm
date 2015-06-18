use utf8;

package SMM::Schema::Result::Goal;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Goal

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

=head2 percentage

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

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 country_id

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
  is_foreign_key: 1
  is_nullable: 1

=head2 goal_number

  data_type: 'integer'
  is_nullable: 1

=head2 qualitative_progress_1

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_2

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_3

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_4

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_5

  data_type: 'text'
  is_nullable: 1

=head2 qualitative_progress_6

  data_type: 'text'
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
    "percentage",
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
    "updated_at",
    { data_type => "timestamp", is_nullable => 1 },
    "country_id",
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
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
    "goal_number",
    { data_type => "integer", is_nullable => 1 },
    "qualitative_progress_1",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_2",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_3",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_4",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_5",
    { data_type => "text", is_nullable => 1 },
    "qualitative_progress_6",
    { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 budgets

Type: has_many

Related object: L<SMM::Schema::Result::Budget>

=cut

__PACKAGE__->has_many(
    "budgets", "SMM::Schema::Result::Budget",
    { "foreign.goal_number" => "self.id" },
    { cascade_copy          => 0, cascade_delete => 0 },
);

=head2 comment_goals

Type: has_many

Related object: L<SMM::Schema::Result::CommentGoal>

=cut

__PACKAGE__->has_many(
    "comment_goals",
    "SMM::Schema::Result::CommentGoal",
    { "foreign.goal_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
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

=head2 goal_organizations

Type: has_many

Related object: L<SMM::Schema::Result::GoalOrganization>

=cut

__PACKAGE__->has_many(
    "goal_organizations",
    "SMM::Schema::Result::GoalOrganization",
    { "foreign.goal_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 goal_porcentages

Type: has_many

Related object: L<SMM::Schema::Result::GoalPorcentage>

=cut

__PACKAGE__->has_many(
    "goal_porcentages",
    "SMM::Schema::Result::GoalPorcentage",
    { "foreign.goal_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 goal_projects

Type: has_many

Related object: L<SMM::Schema::Result::GoalProject>

=cut

__PACKAGE__->has_many(
    "goal_projects",
    "SMM::Schema::Result::GoalProject",
    { "foreign.goal_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 goal_secretaries

Type: has_many

Related object: L<SMM::Schema::Result::GoalSecretary>

=cut

__PACKAGE__->has_many(
    "goal_secretaries",
    "SMM::Schema::Result::GoalSecretary",
    { "foreign.goal_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
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

=head2 objective

Type: belongs_to

Related object: L<SMM::Schema::Result::Objective>

=cut

__PACKAGE__->belongs_to(
    "objective",
    "SMM::Schema::Result::Objective",
    { id => "objective_id" },
    {
        is_deferrable => 0,
        join_type     => "LEFT",
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION",
    },
);

=head2 progress_goal_counsils

Type: has_many

Related object: L<SMM::Schema::Result::ProgressGoalCounsil>

=cut

__PACKAGE__->has_many(
    "progress_goal_counsils",
    "SMM::Schema::Result::ProgressGoalCounsil",
    { "foreign.goal_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 projects

Type: has_many

Related object: L<SMM::Schema::Result::Project>

=cut

__PACKAGE__->has_many(
    "project",
    "SMM::Schema::Result::Project",
    { "foreign.goal_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
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

# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-10 18:16:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7gme5RFzZ7Dcp5rMzebUww

__PACKAGE__->has_many(
    approved_comments => 'SMM::Schema::Result::CommentGoal',
    sub {
        my $args = shift;

        return {
            "$args->{foreign_alias}.goal_id" =>
              { -ident => "$args->{self_alias}.id" },
            "$args->{foreign_alias}.approved" => 1,
        };
    },
    { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->many_to_many( projects => goal_projects => 'project' );

__PACKAGE__->many_to_many( secretaries => 'goal_secretaries' => 'secretary', );

with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;

sub verifiers_specs {
    my $self = shift;
    return {
        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name => {
                    required => 1,
                    type     => 'Str',
                },
                description => {
                    required => 0,
                    type     => 'Str',
                },
                technically => {
                    required => 1,
                    type     => 'Str',
                },
                will_be_delivered => {
                    required => 0,
                    type     => 'Str',
                },
                expected_start_date => {
                    required => 0,
                    type     => 'Str',
                },
                expected_end_date => {
                    required => 0,
                    type     => 'Str',
                },
                start_date => {
                    required => 0,
                    type     => 'Str',
                },
                end_date => {
                    required => 0,
                    type     => 'Str',
                },
                percentage => {
                    required => 0,
                    type     => 'Str',
                },
                goal_number => {
                    required => 1,
                    type     => 'Int',
                },
                updated_at => {
                    required => 0,
                    type     => DataStr,
                },
                qualitative_progress_1 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_2 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_3 => {
                    required => 0,
                },
                qualitative_progress_4 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_5 => {
                    required => 0,
                    type     => 'Str',
                },
                qualitative_progress_6 => {
                    required => 0,
                    type     => 'Str',
                },

              }

        ),
    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $goal = $self->update( \%values );

            return $goal;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
