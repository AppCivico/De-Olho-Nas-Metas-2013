package SMM::Schema::ResultSet::Contact;
use namespace::autoclean;

use utf8;
use Moose;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;
extends 'DBIx::Class::ResultSet';
with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::InflateAsHashRef';

use Data::Verifier;

sub verifiers_specs {
    my $self = shift;
    return {
        create => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name => {
                    required => 1,
                    type     => 'Str',
                },
                email => {
                    required => 1,
                    type     => EmailAddress,
                },
                message => {
                    required => 1,
                    type     => 'Str',
                },
            }
        )
    };
}
use String::Random qw(random_regex);
use Template;
use Data::Section::Simple qw(get_data_section);
use SMM::Mailer::Template;
use DateTime::Format::Strptime;

my $strp = DateTime::Format::Strptime->new(
    pattern   => '%d/%m/%y %T',
    locale    => 'pt_BR',
    time_zone => 'local',
);
my $tt = Template->new( EVAL_PERL => 0 );

# cache of escaped characters
our $URI_ESCAPES;

use DateTime;
use MIME::Base64 qw(decode_base64);

sub uri_filter {
    my $text = shift;

    $URI_ESCAPES ||=
      { map { ( chr($_), sprintf( "%%%02X", $_ ) ) } ( 0 .. 255 ), };

    if ( $] >= 5.008 && utf8::is_utf8($text) ) {
        utf8::encode($text);
    }

    $text =~ s/([^A-Za-z0-9\-_.!~*'()])/$URI_ESCAPES->{$1}/eg;
    $text;
}

sub action_specs {
    my $self = shift;
    return {
        create => sub {
            my %values  = shift->valid_values;
            my $contact = $self->create( \%values );
            my $body    = '';

            my $wrapper = get_data_section('faleconosco.tt');
            $tt->process(
                \$wrapper,
                {
                    name    => $values{name},
                    email   => $values{email},
                    message => $values{message},
                },
                \$body
            );
            my $title = 'Fale Conosco - De Olho Nas Metas:';
            my $data  = SMM::Mailer::Template->new(
                to   => $ENV{EMAIL_ADMIN},
                from => q{"De Olho Nas Metas" <no-reply@deolhonasmetas.org.br>},
                subject => $title,
                content => $body,
                title   => 'Convite - De Olho Nas Metas',

            )->build_email_without_user;
            my $email =
              $self->_build_email( $data->{email}, $data->{title},
                $data->{content} );

            $self->result_source->schema->resultset('EmailQueue')
              ->create( { body => $email->as_string, title => $title } );

            return $contact;
        }
    };
}
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

    return $email;

}

1;

__DATA__

@@ faleconosco.tt

<div style="font-family: arial, verdana; color: #333333;">


<p>Nome : [% name %]</p>
<p>Email: [% email %]</p>
<p>Mensagem: [% message %]</p>


</div>


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
			  	<th>Fale Conosco</th>
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
