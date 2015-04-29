use utf8;

package SMM::Schema::Result::UserRequestCouncil;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::UserRequestCouncil

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

__PACKAGE__->load_components( "InflateColumn::DateTime", "TimeStamp",
    "PassphraseColumn" );

=head1 TABLE: C<user_request_council>

=cut

__PACKAGE__->table("user_request_council");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'user_request_council_id_seq'

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 organization_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_status

  data_type: 'enum'
  extra: {custom_type_name => "user_request_type",list => ["pending","denied","accepted"]}
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
        sequence          => "user_request_council_id_seq",
    },
    "user_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
    "organization_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
    "user_status",
    {
        data_type => "enum",
        extra     => {
            custom_type_name => "user_request_type",
            list             => [ "pending", "denied", "accepted" ],
        },
        is_nullable => 0,
    },
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
    { id            => "organization_id" },
    { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 user

Type: belongs_to

Related object: L<SMM::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
    "user",
    "SMM::Schema::Result::User",
    { id            => "user_id" },
    { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-04-24 18:09:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2Z7ywtwoyl5tW+Dlr+y3jA
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
                organization_id => {
                    required => 0,
                    type     => 'Int',
                },
                user_status => {
                    required => 0,
                    type     => 'Str',
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
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $project = $self->update( \%values );

            my $user = $self->search_related('user')->next;

            $user->set_roles( { name => 'counsil' } )
              if $values{user_status} eq 'accepted';
            my $body = '';
            my $wrapper;
            $wrapper = get_data_section('response_denied_council.tt')
              if $values{user_status} eq 'denied';
            $wrapper = get_data_section('response_accepted_council.tt')
              if $values{user_status} eq 'accepted';
            $tt->process(
                \$wrapper,
                {
                    date =>
                      DateTime->now( formatter => $strp, time_zone => 'local' ),
                    web_url   => '[% web_url %]',
                    email     => $user->email,
                    email_uri => &uri_filter( $user->email )
                },
                \$body
            );
            my $title =
              'De Olho nas Metas: Resposta de solicitação de conselheiro';
            my $email = SMM::Mailer::Template->new(
                to      => $user,
                from    => q{"donm" <no-reply@deolhonasmetas.org.br>},
                subject => $title,
                content => $body,
                title =>
'Resposta de solicitação de conselheiro - De Olho Nas Metas',

            )->build_email;
            $self->result_source->schema->resultset('EmailQueue')
              ->create( { body => $email->as_string, title => $title } );

            return $project;
        },

    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

__DATA__

@@ response_accepted_council.tt

<div style="font-family: arial, verdana; color: #333333;">

<p>Caro(a) usuário(a),</p>

<p>Email: [% email %]</p>

<p>Data: [% date %]</p>

<p>Prezado Usuário, 
         O seu cadastro como conselheiro foi aceito. Obrigado por se cadastrar! E fique De Olho nas Metas!
</p>
<p>
         Abraços. 
         Equipe do De Olho nas Metas.

</p>

</div>

@@ response_denied_council.tt

<div style="font-family: arial, verdana; color: #333333;">

<p>Caro(a) usuário(a),</p>

<p>Email: [% email %]</p>

<p>Data: [% date %]</p>

<p>Prezado Usuário, 
         O seu cadastro como conselheiro não foi aceito porque seu nome não está na lista oficial de conselheiros.
</p>
<p>
         Abraços. 
         Equipe do De Olho nas Metas.

</p>

</div>
