package SMM::Schema::ResultSet::UserRequestCouncil;
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
                user_id => {
                    required => 1,
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

sub action_specs {
    my $self = shift;
    return {
        login => sub { 1 },

        create => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $user_request_council = $self->create( \%values );

            return $user_request_council;
        }

    };
}

1;
