package SMM::Schema::ResultSet::PasswordReset;
use utf8;
use namespace::autoclean;

use Moose;
extends 'DBIx::Class::ResultSet';
with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::InflateAsHashRef';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;

use Data::Printer;

sub verifiers_specs {
    my $self = shift;

    return {
        reset_password => Data::Verifier->new(
            profile => {
                hash => {
                    required   => 1,
                    type       => 'Str',
                    post_check => sub {
                        my $r     = shift;
                        my $where = {
                            hash       => $r->get_value('hash'),
                            valid      => 1,
                            expires_at => { '>=' => \'NOW()' }
                        };

                        return $self->search( $where, { rows => 1 } )->count ==
                          1;
                    }
                },
                email => {
                    required   => 1,
                    type       => EmailAddress,
                    post_check => sub {
                        my $r     = shift;
                        my $where = {
                            hash       => $r->get_value('hash'),
                            valid      => 1,
                            expires_at => { '>=' => \'NOW()' }
                        };

                        # email precisa conferir com o do dono da chave
                        return eval {
                            $self->search($where)->search_related(
                                'user',
                                { email => $r->get_value('email') },
                                { rows  => 1 }
                            )->count == 1;
                        };

                    }
                },
                password => {
                    required   => 1,
                    type       => 'Str',
                    min_length => 5,
                    max_length => 256,

                    dependent => {
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
        email => Data::Verifier->new(
            profile => {
                ip => {
                    required => 1,
                    type     => 'Str',
                },
                email => {
                    required   => 1,
                    type       => EmailAddress,
                    post_check => sub {

                        my $r = shift;

                        my $user = $self->schema->resultset('User');
                        use DDP;
                        p $r;
                        my $qtde =
                          $user->search( { email => $r->get_value('email') } )
                          ->count;

                        return $qtde >= 1;
                    }

                },

            },
        ),

    };
}

use String::Random qw(random_regex);
use Template;
use Data::Section::Simple qw(get_data_section);
use SMM::Mailer::Template;
use DateTime::Format::Strptime;
use Digest::MD5 qw/md5_hex/;
my $strp = DateTime::Format::Strptime->new(
    pattern   => '%d/%m/%y %T',
    locale    => 'pt_BR',
    time_zone => 'local',
);
my $tt = Template->new( EVAL_PERL => 0 );

our $URI_ESCAPES;

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
        reset_password => sub {
            my %values = shift->valid_values;

            $self->schema->resultset('User')
              ->find( { email => $values{email} } )
              ->update( { password => $values{password} } );

            $self->find( { hash => $values{hash} } )->update( { valid => 0 } );

            return 1;
        },
        email => sub {
            my %values = shift->valid_values;
            warn "lol2";
            use DDP;
            p %values;
            my $user = $self->schema->resultset('User')
              ->search( { email => $values{email} } )->first;

            my %user_attrs = $user->get_inflated_columns;
            delete $user_attrs{password};

            my $key = md5_hex( time, {}, $$ );

            $self->search( { user_id => $user->id } )->update( { valid => 0 } );

            my $result = $self->create(
                {
                    user_id => $user->id,
                    hash    => $key
                }
            );

            $user_attrs{hash} = $key;

            my $body = '';

            my $wrapper = get_data_section('forgot_password.tt');
            $tt->process(
                \$wrapper,
                {
                    date =>
                      DateTime->now( formatter => $strp, time_zone => 'local' ),
                    ip      => $values{ip},
                    web_url => '[% web_url %]',
                    ( map { $_ => $user_attrs{$_} } qw / name email hash / ),

                    email_uri => &uri_filter( $user_attrs{email} )
                },
                \$body
            );

            my $title = 'De Olho Nas Metas: Solicitação de nova senha';
            my $email = SMM::Mailer::Template->new(
                to      => $user,
                from    => q{"donm" <no-reply@deolhonasmetas.com.br>},
                subject => $title,
                content => $body,
                title   => 'Solicitação de nova senha',

            )->build_email;
            $self->result_source->schema->resultset('EmailQueue')->create(
                {
                    recipient => $user,
                    body      => $email->as_string,
                    title     => $title
                }
            );

            return 1;
        },
    };
}

1;

__DATA__

@@ forgot_password.tt

<div style="font-family: arial, verdana; color: #333333;">

<p>Caro(a) usuário(a),</p>

Conforme solicitado, estamos enviando um link para que você altere sua senha


<p>Nome: [% name %]</p>
<p>Email: [% email %]</p>

<p>Data: [% date %]</p>
<p>IP: [% ip %]</p>
<p> Código: [% hash %]</p>

<p>Para efetuar a alteração, basta acessar o link abaixo e digitar a
nova senha de acesso, este acesso é válido apenas por 7 dias
seguintes a solicitação realizada através do sistema do De Olho Nas Metas.</p>


<p><a href="[% web_url %]/change-password?hash=[% hash  %]&email=[%email_uri%]">
  [% web_url %]/change-password?hash=[% hash %]&email=[%email_uri%]</a></p>

<p>Caso você não tenha solicitado esta alteração de senha, acima
encontram-se informações sobre o horário e o endereço IP da máquina de
onde partiu a solicitação.</p>

</div>
