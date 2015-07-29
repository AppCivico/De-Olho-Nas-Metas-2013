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

=head2 accept_email

  data_type: 'boolean'
  is_nullable: 1

=head2 accept_sms

  data_type: 'boolean'
  is_nullable: 1

=head2 request_council

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 mobile_campaign_id

  data_type: 'integer'
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
  "accept_email",
  { data_type => "boolean", is_nullable => 1 },
  "accept_sms",
  { data_type => "boolean", is_nullable => 1 },
  "request_council",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "mobile_campaign_id",
  { data_type => "integer", is_nullable => 1 },
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

=head2 files

Type: has_many

Related object: L<SMM::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "SMM::Schema::Result::File",
  { "foreign.created_by" => "self.id" },
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

=head2 password_resets

Type: has_many

Related object: L<SMM::Schema::Result::PasswordReset>

=cut

__PACKAGE__->has_many(
  "password_resets",
  "SMM::Schema::Result::PasswordReset",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_accept_porcentages

Type: has_many

Related object: L<SMM::Schema::Result::ProjectAcceptPorcentage>

=cut

__PACKAGE__->has_many(
  "project_accept_porcentages",
  "SMM::Schema::Result::ProjectAcceptPorcentage",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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

=head2 user_request_councils

Type: has_many

Related object: L<SMM::Schema::Result::UserRequestCouncil>

=cut

__PACKAGE__->has_many(
  "user_request_councils",
  "SMM::Schema::Result::UserRequestCouncil",
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-07-29 14:29:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2ZzbYac7a9RsCWZlOTgSFg

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
                          $r->get_value('password_confirm');
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

            my $new_role = delete $values{role};
            delete $values{password_confirm};
            delete $values{current_password};

            not defined $values{$_} and delete $values{$_} for keys %values;
            my $user = $self->update( \%values );

            $user->set_roles( { id => $new_role } ) if $new_role;
            return $user;
        },

    };
}
use Data::Section::Simple qw(get_data_section);
use Template;

use SMM::Mailer::Template;
use DateTime::Format::Strptime;

my $strp = DateTime::Format::Strptime->new(
    pattern   => '%d/%m/%y %T',
    locale    => 'pt_BR',
    time_zone => 'local',
);

my $tt = Template->new();

use DateTime;
use MIME::Base64 qw(decode_base64);

sub _build_email {
    my ( $self, $email, $title, $content ) = @_;

    my $data = '';

    my $wrapper = get_data_section('body_password.tt');

    my $env = {
        year => DateTime->now( time_zone => 'local' )->year,

        partner_name => 'veratrum',
        url          => 'http://www.deolhonasmetas.org.br',
        web_url      => 'http://localhost:5040',
        title        => $title

    };

    my $processed_content = '';
    $tt->process( \$content, $env, \$processed_content );
    $tt->process( \$wrapper, { content => $processed_content, %$env }, \$data );

    $email->attach(
        Type => 'text/html; charset=UTF-8',
        Data => $data,
    );

    $email->attach(
        Type     => 'image/png',
        Id       => 'logo.png',
        Encoding => 'base64',
        Data     => decode_base64( get_data_section('logo.png') ),
    );

    return $email;

}

sub _build_many_emails {
    my ( $self, $email, $title, $content ) = @_;

    my $data = '';

    my $wrapper = get_data_section('body.tt');

    my $env = {
        year => DateTime->now( time_zone => 'local' )->year,

        partner_name => 'deolhonasmetas',
        url          => 'www.deolhonasmetas.org.br',
        web_url      => 'http://localhost:5040',
        title        => $title

    };

    my $processed_content = '';
    $tt->process( \$content, $env, \$processed_content );
    $tt->process( \$wrapper, { content => $processed_content, %$env }, \$data );
    use DDP;
    p $email;

    $email->attach(
        Type => 'text/html; charset=UTF-8',
        Data => $data,
    );
    $email->attach(
        Type     => 'image/png',
        Id       => 'logo.png',
        Encoding => 'base64',
        Data     => decode_base64( get_data_section('logo.png') ),
    );

    p $email;
    return $email;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
__DATA__


@@ body_password.tt


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
<title>veratrum: Informativo</title>
</head>
<body style="padding: 0; margin: 0; background-color: #FAFAFA;">
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" style="background-color: #FAFAFA;">
    <tr>
        <td align="center" vertical-align="top">
      <table cellspacing="0" cellpadding="6" border="0" width="638">
        <tr>
          <td align="center" vertical-align="top" style="background-color: #00a99d;">
            <!--// header //-->
            <table cellspacing="0" cellpadding="0" border="0" width="638" style="background-color: #00a99d;">
              <tr>
                <td style="padding: 10px 20px;">
                  <div style="text-align: left;">
                  </div>
                </td>
              </tr>
              <tr>
                <td style="padding: 20px;">
                  <p style="font-family: arial, verdana; font-size: 16pt; color: #FFFFFF; text-align: left; margin: 0; padding: 0;">[%title%]</p>
                </td>
              </tr>
            </table>
            <!--// fim header //-->

            <table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td style="background-color: #ffffff; text-align: left;" bgcolor="#ffffff" width="638">
                  <table border="0" width="100%"><tr><td>
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                      <tr>
                        <td style="vertical-align: top; padding: 50px;font-family: arial, verdana;">
                            [%content%]
                        </td>
                      </tr>
                    </table>
                  </td></tr></table>
                </td>
              </tr>
            </table>
            <!--// footer //-->

          </td>
        </tr>
      </table>
      <table cellspacing="0" cellpadding="0" border="0" width="650" height="25">
        <tr>
          <td align="center" vertical-align="top">
          </td>
        </tr>
      </table>
        </td>
    </tr>
</table>
</body>
</html>





@@ body.tt

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
<title>Donm: Informativo</title>
</head>
<body style="padding: 0; margin: 0; background-color: #FAFAFA;">
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" style="background-color: #FAFAFA;">
    <tr>
        <td align="center" vertical-align="top">
      <table cellspacing="0" cellpadding="6" border="0" width="638">
        <tr>
          <td align="center" vertical-align="top" style="background-color: #00a99d;">
            <!--// header //-->
            <table cellspacing="0" cellpadding="0" border="0" width="638" style="background-color: #00a99d;">
              <tr>
                <td style="padding: 20px;">
                  <p style="font-family: arial, verdana; font-size: 16pt; color: #FFFFFF; text-align: left; margin: 0; padding: 0;">[%title%]</p>
                </td>
              </tr>
            </table>
            <!--// fim header //-->

            <table cellspacing="0" cellpadding="0" border="0">
              <tr>
                <td style="background-color: #ffffff; text-align: left;" bgcolor="#ffffff" width="638">
                  <table border="0" width="100%"><tr><td>
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                      <tr>
                        <td style="vertical-align: top; padding: 50px;font-family: arial, verdana;">
                            [%content%]
                        </td>
                      </tr>
                    </table>
                  </td></tr></table>
                </td>
              </tr>
            </table>
            <!--// footer //-->
            <table cellspacing="0" cellpadding="0" border="0" width="638" style="background-color: #f0b14e;">
            </table>
            <!--// fim footer //-->

          </td>
        </tr>
      </table>
      <table cellspacing="0" cellpadding="0" border="0" width="650" height="25">
        <tr>
          <td align="center" vertical-align="top">
          </td>
        </tr>
      </table>
        </td>
    </tr>
</table>
</body>
</html>           


@@ logo.png


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
fgAAAABJRU5ErkJggg==
