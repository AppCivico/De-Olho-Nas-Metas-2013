package SMM::Schema::ResultSet::Event;
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
                description => {
                    required => 1,
                    type     => 'Str',
                },
                date => {
                    required => 1,
                    type     => DataStr,
                },
                council_id => {
                    required => 1,
                    type     => 'Str',
                },
                campaign_id => {
                    required => 0,
                    type     => 'Str',
                },
                user_id => {
                    required => 0,
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

sub action_specs {
    my $self = shift;
    return {
        create => sub {

            my %values = shift->valid_values;
            my $event  = $self->create( \%values );
            use DDP;
            p %values;

            my @followers_users =
              $self->result_source->schema->resultset('UserFollowCounsil')
              ->search( { counsil_id => $values{council_id}, 'me.active' => 1 },
                { prefetch => [ 'user', 'counsil' ] } )->all;

            if (@followers_users) {
                for my $fu (@followers_users) {
                    my $body    = '';
                    my $wrapper = get_data_section('alert_users.tt');
                    $tt->process(
                        \$wrapper,
                        {
                            date => DateTime->now(
                                formatter => $strp,
                                time_zone => 'local'
                            ),
                            web_url  => '[% web_url %]',
                            email    => $fu->user->email,
                            council  => $fu->counsil->name,
                            event_id => $event->id,
                        },
                        \$body
                    );
                    my $title =
                      'De Olho nas Metas: Alerta de alteração do conselho';
                    my $email = SMM::Mailer::Template->new(
                        to      => $fu->user,
                        from    => q{"donm" <no-reply@deolhonasmetas.org.br>},
                        subject => $title,
                        content => $body,
                        title   => 'Alerta de alteração - De Olho Nas Metas',

                    )->build_many_emails;

                    $self->result_source->schema->resultset('EmailQueue')
                      ->create(
                        { body => $email->as_string, title => $title } );
                }
            }

            return $event;
        }
    };
}

1;

__DATA__

@@ alert_users.tt

<div style="font-family: arial, verdana; color: #333333;">

<p>Caro(a) usuário(a),</p>

<p>Email: [% email %]</p>

<p>Data: [% date %]</p>

<p>Prezado Usuário, 
         O Conselho Participativo "[% council %]" criou um novo evento. Acompanhe acessando o link abaixo: 
</p>
<p>
         <a href="[% web_url %]/home/event/[%event_id%]">[% web_url %]/home/event/[%event_id%]</a>
         </p>
<p>
         Abraços. 
         Equipe do De Olho nas Metas.

</p>

</div>
