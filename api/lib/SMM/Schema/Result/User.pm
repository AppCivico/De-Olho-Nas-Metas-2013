use utf8;
package SMM::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::User

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

=head2 username

  data_type: 'text'
  is_nullable: 1

=head2 phone_number

  data_type: 'text'
  is_nullable: 1

=head2 image_perfil

  data_type: 'text'
  is_nullable: 1

=head2 accept_sms

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 accept_email

  data_type: 'boolean'
  default_value: false
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
  "username",
  { data_type => "text", is_nullable => 1 },
  "phone_number",
  { data_type => "text", is_nullable => 1 },
  "image_perfil",
  { data_type => "text", is_nullable => 1 },
  "accept_sms",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "accept_email",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
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

=head2 C<user_username_key>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("user_username_key", ["username"]);

=head1 RELATIONS

=head2 campaigns

Type: has_many

Related object: L<SMM::Schema::Result::Campaign>

=cut

__PACKAGE__->has_many(
  "campaigns",
  "SMM::Schema::Result::Campaign",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 comment_goals

Type: has_many

Related object: L<SMM::Schema::Result::CommentGoal>

=cut

__PACKAGE__->has_many(
  "comment_goals",
  "SMM::Schema::Result::CommentGoal",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 comment_projects

Type: has_many

Related object: L<SMM::Schema::Result::CommentProject>

=cut

__PACKAGE__->has_many(
  "comment_projects",
  "SMM::Schema::Result::CommentProject",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 email_queues

Type: has_many

Related object: L<SMM::Schema::Result::EmailQueue>

=cut

__PACKAGE__->has_many(
  "email_queues",
  "SMM::Schema::Result::EmailQueue",
  { "foreign.recipient_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 events

Type: has_many

Related object: L<SMM::Schema::Result::Event>

=cut

__PACKAGE__->has_many(
  "events",
  "SMM::Schema::Result::Event",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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

=head2 images_projects

Type: has_many

Related object: L<SMM::Schema::Result::ImagesProject>

=cut

__PACKAGE__->has_many(
  "images_projects",
  "SMM::Schema::Result::ImagesProject",
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

=head2 project_events

Type: has_many

Related object: L<SMM::Schema::Result::ProjectEvent>

=cut

__PACKAGE__->has_many(
  "project_events",
  "SMM::Schema::Result::ProjectEvent",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_events_read

Type: has_many

Related object: L<SMM::Schema::Result::ProjectEventRead>

=cut

__PACKAGE__->has_many(
  "project_events_read",
  "SMM::Schema::Result::ProjectEventRead",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_follow_counsils

Type: has_many

Related object: L<SMM::Schema::Result::UserFollowCounsil>

=cut

__PACKAGE__->has_many(
  "user_follow_counsils",
  "SMM::Schema::Result::UserFollowCounsil",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_follow_projects

Type: has_many

Related object: L<SMM::Schema::Result::UserFollowProject>

=cut

__PACKAGE__->has_many(
  "user_follow_projects",
  "SMM::Schema::Result::UserFollowProject",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-04-08 17:32:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xBNt1lDxkG4PW54snaupqQ

__PACKAGE__->many_to_many( roles => user_roles => 'role' );

__PACKAGE__->remove_column('password');
__PACKAGE__->add_column(
    password => {
        data_type        => "text",
        passphrase       => 'crypt',
        passphrase_class => 'BlowfishCrypt',
        passphrase_args  => {
            cost        => 8,
            salt_random => 1,
        },
        passphrase_check_method => 'check_password',
        is_nullable             => 0
    },
);

__PACKAGE__->has_many(
    "sessions",
    "SMM::Schema::Result::UserSession",
    { "foreign.user_id" => "self.id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

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
                name => {
                    required => 0,
                    type     => 'Str',
                },
                username => {
                    required => 0,
                    type     => 'Str',
                },
                phone_number => {
                    required => 0,
                    type     => 'Str',
                },

                organization_id => {
                    required => 0,
                    type     => 'Int',
                },
                role => {
                    required => 0,
                    type     => 'Str',
                },
                email => {
                    required   => 0,
                    type       => EmailAddress,
                    post_check => sub {
                        my $r = shift;
                        return 1 if $self->email eq $r->get_value('email');

                        return 0
                          if $self->resultset_find(
                            { email => $r->get_value('email') } );

                        return 1;
                    }
                },
                current_password => {
                    required   => 0,
                    type       => 'Str',
                    post_check => sub {
                        my $r = shift;
                        return $self->check_password(
                            $r->get_value('current_password') );
                    },
                },

                password => {
                    required   => 0,
                    type       => 'Str',
                    min_length => 5,
                    max_length => 256,
                    dependent  => {
                        password_confirm => {
                            required => 1,
                            type     => 'Str',
                        },
                    },
                    post_check => sub {
                        my $r = shift;
                        return $r->get_value('password') eq
                          $r->get_value('password_confirm')
                          && $self->check_password(
                            $r->get_value('current_password') );
                    },
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

            delete $values{password_confirm};
            delete $values{current_password};

            my $new_role = delete $values{roles};

            my $user = $self->update( \%values );
            use DDP;
            p $new_role;
            $user->set_roles( { id => $new_role } ) if $new_role;
            return $user;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;

1;
