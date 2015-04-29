use utf8;
package SMM::Schema::Result::InviteCounsil;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::InviteCounsil

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

=head1 TABLE: C<invite_counsil>

=cut

__PACKAGE__->table("invite_counsil");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'invite_counsil_id_seq'

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 hash

  data_type: 'text'
  is_nullable: 0

=head2 organization_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 valid_until

  data_type: 'boolean'
  default_value: true
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
    sequence          => "invite_counsil_id_seq",
  },
  "email",
  { data_type => "text", is_nullable => 0 },
  "hash",
  { data_type => "text", is_nullable => 0 },
  "organization_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "valid_until",
  { data_type => "boolean", default_value => \"true", is_nullable => 1 },
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-04-08 17:24:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cESI09qWzbuD0iWGMWYkLQ
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
                email => {
                    required => 0,
                    type     => 'Str',
                },
                valid_until => {
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

            my $goal = $self->update( \%values );

            return $goal;
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
        url          => 'www.deolhonasmetas.org.br',
        web_url      => 'www.deolhonasmetas.org.br',
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

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
__DATA__


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
AElFTkSuQmCC
