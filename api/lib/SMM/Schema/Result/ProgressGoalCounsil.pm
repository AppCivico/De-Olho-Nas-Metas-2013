use utf8;
package SMM::Schema::Result::ProgressGoalCounsil;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::ProgressGoalCounsil

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

=head1 TABLE: C<progress_goal_counsil>

=cut

__PACKAGE__->table("progress_goal_counsil");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'progress_goal_counsil_id_seq'

=head2 remainder

  data_type: 'double precision'
  is_nullable: 0

=head2 owned

  data_type: 'double precision'
  is_nullable: 0

=head2 goal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "progress_goal_counsil_id_seq",
  },
  "remainder",
  { data_type => "double precision", is_nullable => 0 },
  "owned",
  { data_type => "double precision", is_nullable => 0 },
  "goal_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-13 12:05:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:W0LX++A0YRZHha05M6e22g

with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;

sub verifiers_specs {
    my $self = shift;
    return {

        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                owned => {
                    required => 0,
                    type     => 'Num',
                },
                remainder => {
                    required => 0,
                    type     => 'Num',
                },
                goal_id => {
                    required => 0,
                    type     => 'Int',
                },
            },
        ),

    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $progress_goals_counsil = $self->update( \%values );
            return $progress_goals_counsil;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
