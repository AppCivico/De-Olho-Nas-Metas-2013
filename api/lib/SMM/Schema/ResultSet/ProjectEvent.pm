package SMM::Schema::ResultSet::ProjectEvent;
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
                user_id => {
                    required => 1,
                    type     => 'Int',
                },
                text => {
                    required => 1,
                    type     => 'Str',
                },
                project_id => {
                    required => 1,
                    type     => 'Int',
                },
                approved => {
                    required => 0,
                    type     => 'Bool',
                }
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

sub action_specs {
    my $self = shift;
    return {
        create => sub {
            my %values = shift->valid_values;
            not defined $values{$_} and delete $values{$_} for keys %values;
            $values{approved} = 1;
            $self->search( { project_id => $values{project_id}, is_last => 1 } )
              ->update( { is_last => undef } );

            my $user = $self->result_source->schema->resultset('User')
              ->find( $values{user_id} );

            my $project = $self->result_source->schema->resultset('Project')
              ->find( $values{project_id} );
            my $project_event = $self->create( \%values );
            my $body          = '';

            my $wrapper = get_data_section('notification.tt');
            $tt->process(
                \$wrapper,
                {
                    name    => $user->name,
                    email   => $user->email,
                    message => $values{text},
                    project => $project->name,

                },
                \$body
            );
            my $title = 'Notificações Conselheiros - De Olho Nas Metas:';
            my $data  = SMM::Mailer::Template->new(
                to   => $ENV{EMAIL_ADMIN},
                from => q{"De Olho Nas Metas" <no-reply@deolhonasmetas.org.br>},
                subject => $title,
                content => $body,
                title   => 'Convite - De Olho Nas Metas',

            )->build_email_without_user;
            my $email =
              $project_event->_build_email( $data->{email}, $data->{title},
                $data->{content} );

            $self->result_source->schema->resultset('EmailQueue')
              ->create( { body => $email->as_string, title => $title } );

            return $project_event;
        }
    };
}

1;

__DATA__

@@ notification.tt

<div style="font-family: arial, verdana; color: #333333;">


<p>Nome : [% name %]</p>
<p>Email: [% email %]</p>
<p>Mensagem: [% message %]</p>
<p>Projeto: [% project %]</p>


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
