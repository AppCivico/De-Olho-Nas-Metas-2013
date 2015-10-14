#!/usr/bin/env perl
use FindBin::libs qw( base=daemon subdir=lib );
use SMM::DaemonTools;
use utf8;
use Encode qw/decode/;

use SMM::Mailer;
use Try::Tiny;
use DateTime;

my $schema = GET_SCHEMA;

my $mailer = SMM::Mailer->new;
log_info "running...";

while (1) {
    EXIT_IF_ASKED;
    ON_TERM_WAIT;
    $schema->txn_do(
        sub {
            my @not_sent = eval {
                $schema->resultset('EmailQueue')->search(
                    { sent => 0 },
                    {
                        rows => 20,
                        for  => 'update',
                        columns =>
                          [qw/me.id me.body me.sent me.sent_at me.title/]
                    }
                )->all;
            };

            print DateTime->now( time_zone => 'local' ) . '> '
              . ( scalar @not_sent )
              . " emails para enviar...\n"
              if @not_sent;

            foreach my $mail (@not_sent) {
                try {
                    my $txt   = $mail->body;
                    my $title = $mail->title;

                    my ($to) = $txt =~ /To: (.+)/;

                    my @others = ();

                    push @others, qw/renan.carvalho@eokoe.com/;

                    print DateTime->now( time_zone => 'local' )
                      . "> enviando '$title' para $to [cc @others]\n";
                    $mailer->send( $txt, @others );
                }
                finally {
                    warn @_ if @_;
                    $mail->delete unless @_;
                };

            }
            print "sleeping..\n" if @not_sent;
        }
    );

    EXIT_IF_ASKED;
    ON_TERM_EXIT;
    sleep(5);
}
