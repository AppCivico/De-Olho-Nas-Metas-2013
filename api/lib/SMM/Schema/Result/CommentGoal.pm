use utf8;

package SMM::Schema::Result::CommentGoal;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::CommentGoal

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

=head1 TABLE: C<comment_goal>

=cut

__PACKAGE__->table("comment_goal");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'comment_goal_id_seq'

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 timestamp

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 approved

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 goal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 1

=head2 user_id

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
        sequence          => "comment_goal_id_seq",
    },
    "description",
    { data_type => "text", is_nullable => 1 },
    "timestamp",
    {
        data_type     => "timestamp",
        default_value => \"current_timestamp",
        is_nullable   => 1,
        original      => { default_value => \"now()" },
    },
    "approved",
    { data_type => "boolean", default_value => \"false", is_nullable => 1 },
    "goal_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
    "active",
    { data_type => "boolean", default_value => \"true", is_nullable => 1 },
    "user_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 goal

Type: belongs_to

Related object: L<SMM::Schema::Result::Goal>

=cut

__PACKAGE__->belongs_to(
    "goal",
    "SMM::Schema::Result::Goal",
    { id => "goal_id" },
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

# Created by DBIx::Class::Schema::Loader v0.07041 @ 2015-02-19 05:24:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:z59tG4kvHsH0QnlA+Fyo8A

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
                description => {
                    required => 0,
                    type     => 'Int',
                },
                approved => {
                    required => 0,
                    type     => 'Bool',
                },
                goal_id => {
                    required => 0,
                    type     => 'Int',
                },
                active => {
                    required => 0,
                    type     => 'Bool',
                },
                user_id => {
                    required => 0,
                    type     => 'Int',
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

            my $comment = $self->update( \%values );

            return $comment;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
