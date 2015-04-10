package SMM::Schema::ResultSet::InviteCounsil;
use namespace::autoclean;

use utf8;
use Moose;
extends 'DBIx::Class::ResultSet';
with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::InflateAsHashRef';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;

sub verifiers_specs {
    my $self = shift;
    return {
        create => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                organization_id => {
                    required => 1,
                    type     => 'Int',
                },
                hash => {
                    required => 0,
                    type     => 'Str',
                },
                email => {
                    required   => 1,
                    type       => EmailAddress,
                    post_check => sub {
                        return 1;
                    }
                },
            },
        ),
        login => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                email => {
                    required => 1,
                    type     => EmailAddress
                },
                password => {
                    required => 1,
                    type     => 'Str',
                },
            }
        ),
        key_check => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                hash => {
                    required   => 1,
                    type       => 'Str',
                    post_check => sub {
                        my $r     = shift;
                        my $where = {
                            hash        => $r->get_value('hash'),
                            valid_until => 1
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
                            email       => $r->get_value('email'),
                            valid_until => 1
                        };

                        # email precisa conferir com o do dono da chave
                        return $self->search( $where, { rows => 1 } )->count ==
                          1;

                    }
                },
              }

        ),
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
        key_check => sub {
            my %values = shift->valid_values;
            return 0 unless $self->search( { hash => $values{hash} } )->next;
            return 1;
        },
        create => sub {
            my %values = shift->valid_values;

            my $db = $self;

#            my $user = $self->schema->resultset('InviteCounsil')->search( { email => $values{email} } )->first;

            my $key = random_regex(q([a-zA-Z0-9]{20}));

            $key = random_regex(q([a-zA-Z0-9]{20}))
              while ( $self->search( { hash => $key }, { rows => 1 } )->next );

            $values{hash} = $key;
            $self->search( { email => lc $values{email} } )
              ->update( { valid_until => 0 } );

            my $invite_counsil = $self->create(
                {
                    organization_id => $values{organization_id},
                    hash            => $values{hash},
                    email           => $values{email}
                }
            );

            my $body = '';

            my $wrapper = get_data_section('invite_counsil.tt');
            $tt->process(
                \$wrapper,
                {
                    date =>
                      DateTime->now( formatter => $strp, time_zone => 'local' ),
                    web_url         => '[% web_url %]',
                    secret_key      => $key,
                    email           => $values{email},
                    organization_id => $values{organization_id},
                    email_uri       => &uri_filter( $values{email} )
                },
                \$body
            );
            my $title = 'De Olho nas Metas: Convite de conselheiro';
            my $email = SMM::Mailer::Template->new(
                to      => $invite_counsil,
                from    => q{"donm" <no-reply@deolhonasmetas.org.br>},
                subject => $title,
                content => $body,
                title   => 'Convite - De Olho Nas Metas',

            )->build_email;
            $self->result_source->schema->resultset('EmailQueue')
              ->create( { body => $email->as_string, title => $title } );

            return 1;
        },
    };
}

1;

__DATA__

@@ invite_counsil.tt

<div style="font-family: arial, verdana; color: #333333;">

<p>Caro(a) usuário(a),</p>

<p>Email: [% email %]</p>

<p>Data: [% date %]</p>
<p> Código: [% secret_key %]</p>

<p>Prezad@ Conselheir@, 
			Você foi convidad@ para participar do programa De Olho nas Metas. Clique aqui para participar!. 
			Abraços. 
			Equipe do De Olho nas Metas.
</p>

<p><a href="[% web_url %]/cadastro?key=[% secret_key  %]&email=[%email_uri%]&organization_id=[%organization_id%]">
  [% web_url %]/cadastro?key=[% secret_key %]&email=[%email_uri%]&organization_id=[%organization_id%]</a></p>

</div>
