package SMM::Schema::ResultSet::RegisterCounsilManual;
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
                name => {
                    required => 1,
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
                email => {
                    required => 1,
                    type     => 'Str',
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
        create => sub {
            my %values = shift->valid_values;
            use DDP;
            p %values;
            my $register_counsil_manual = $self->create(
                {
                    phone_number => $values{phone_number},
                    council      => $values{council},
                    email        => 'renan.azevedo.carvalho@gmail.com',
                    name         => $values{name}
                }
            );

            my $body = '';

            my $wrapper = get_data_section('register_counsil_manual.tt');
            $tt->process(
                \$wrapper,
                {
                    name         => $values{name},
                    council      => $values{council},
                    phone_number => $values{phone_number},
                    email        => $values{email}
                },
                \$body
            );
            my $title = 'Requisição de conselheiro:';
            my $email = SMM::Mailer::Template->new(
                to   => $register_counsil_manual,
                from => q{"De Olho Nas Metas" <no-reply@deolhonasmetas.org.br>},
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

@@ register_counsil_manual.tt

<div style="font-family: arial, verdana; color: #333333;">


<p>Nome : [% name %]</p>
<p>Email: [% email %]</p>
<p>Conselho: [% council %]</p>
<p>Telefone: [% phone_number %]</p>


</div>
