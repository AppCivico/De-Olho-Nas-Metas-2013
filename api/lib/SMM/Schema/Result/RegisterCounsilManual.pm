use utf8;
package SMM::Schema::Result::RegisterCounsilManual;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::RegisterCounsilManual

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

=head1 TABLE: C<register_counsil_manual>

=cut

__PACKAGE__->table("register_counsil_manual");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'register_counsil_manual_id_seq'

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 phone_number

  data_type: 'text'
  is_nullable: 0

=head2 council

  data_type: 'text'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

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
    sequence          => "register_counsil_manual_id_seq",
  },
  "email",
  { data_type => "text", is_nullable => 0 },
  "phone_number",
  { data_type => "text", is_nullable => 0 },
  "council",
  { data_type => "text", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-04-02 12:58:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cdm2lMwNeijNIXeSLAH8oQ
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
                    required => 1,
                    type     => 'Str',
                },
                name => {
                    required => 0,
                    type     => 'Str',
                },
                phone_number => {
                    required => 1,
                    type     => 'Str',
                },
                council => {
                    required => 1,
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

            my $register_counsil_manual = $self->update( \%values );

            return $register_counsil_manual;
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
