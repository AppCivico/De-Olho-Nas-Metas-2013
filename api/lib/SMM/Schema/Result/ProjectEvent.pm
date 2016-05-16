use utf8;
package SMM::Schema::Result::ProjectEvent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::ProjectEvent

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

=head1 TABLE: C<project_event>

=cut

__PACKAGE__->table("project_event");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'project_event_id_seq'

=head2 text

  data_type: 'text'
  is_nullable: 1

=head2 ts

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 approved

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 1

=head2 is_last

  data_type: 'boolean'
  default_value: true
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "project_event_id_seq",
  },
  "text",
  { data_type => "text", is_nullable => 1 },
  "ts",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "approved",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 1 },
  "is_last",
  { data_type => "boolean", default_value => \"true", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<project_event_project_id_is_last_key>

=over 4

=item * L</project_id>

=item * L</is_last>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "project_event_project_id_is_last_key",
  ["project_id", "is_last"],
);

=head1 RELATIONS

=head2 project

Type: belongs_to

Related object: L<SMM::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "SMM::Schema::Result::Project",
  { id => "project_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 project_events_read

Type: has_many

Related object: L<SMM::Schema::Result::ProjectEventRead>

=cut

__PACKAGE__->has_many(
  "project_events_read",
  "SMM::Schema::Result::ProjectEventRead",
  { "foreign.project_event_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-13 12:05:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3/k3V99OO4jUjeyp2Lg29A

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
                user_id => {
                    required => 0,
                    type     => 'Int',
                },
                text => {
                    required => 0,
                    type     => 'Str',
                },
                project_id => {
                    required => 0,
                    type     => 'Int',
                },
                approved => {
                    required => 0,
                    type     => 'Bool',
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

            my $project = $self->update( \%values );

            return $project;
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

    my $wrapper = get_data_section('body.tt');

    my $env = {
        year => DateTime->now( time_zone => 'local' )->year,

        partner_name => 'deolhonasmetas',
        url          => 'http://192.168.1.161:5040',
        web_url      => 'http://192.168.1.161:5040',
        title        => $title

    };

    my $processed_content = '';
    $tt->process( \$content, $env, \$processed_content );
    $tt->process( \$wrapper, { content => $processed_content, %$env }, \$data );

    $email->attach(
        Type => 'text/html; charset=UTF-8',
        Data => $data,
    );

    return $email;

}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

__DATA__

@@ body.tt


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
<title>De Olho Nas Metas: Informativo</title>
</head>
<body style="padding: 0; margin: 0; background-color: #FAFAFA;">
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" style="background-color: #FAFAFA;">
    <tr>
        <td align="center" vertical-align="top">
      <table cellspacing="0" cellpadding="6" border="0" width="638">
        <tr>
          <td align="center" vertical-align="top" style="background-color: #00a99d;">
            <!--// header //-->


            <table cellspacing="0" cellpadding="0" border="0">
			  <tr>
			  	<th>Notificações de Conselheiros</th>
			  </tr>
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
              </tr>            </table> 
            </table> 

          </td>
        </tr>
        </td>
    </tr>
</table>
</body>
</html>
