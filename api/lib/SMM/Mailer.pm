package SMM::Mailer;

use Moose;
use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP::TLS;
use Try::Tiny;

my ( $password, $username );

BEGIN {
    $username = $ENV{SENDGRID_USER}     || 'bdatum';
    $password = $ENV{SENDGRID_PASSWORD} || die 'ENV SENDGRID_PASSWORD MISSING';
}

has from      => ( is => 'ro', default    => 'no-reply@deolhonasmetas.com.br' );
has transport => ( is => 'ro', lazy_build => 1 );

sub _build_transport {
    return Email::Sender::Transport::SMTP::TLS->new(
        helo     => 'deolhonasmetas',
        host     => 'smtp.gmail.com',
        timeout  => 20,
        port     => 587,
        username => $username,
        password => $password
    );

}

sub send {
    my ( $self, $email, @others ) = @_;
    sendmail( $email, { from => $self->from, transport => $self->transport } );

    sendmail( $email,
        { to => $_, from => $self->from, transport => $self->transport } )
      for @others;

}

1;
