BEGIN {
#    die "*** Attention ***\n\nAWS_ACCESS_KEY_ID not defined. Exiting...\n\n"     unless $ENV{AWS_ACCESS_KEY_ID};
#    die "*** Attention ***\n\nAWS_SECRET_ACCESS_KEY not defined. Exiting...\n\n" unless $ENV{AWS_SECRET_ACCESS_KEY};
}

package SMM::DaemonTools;
$|++;
use v5.16;
use strict;
use warnings;
use utf8;

use Log::Log4perl qw(:easy);

Log::Log4perl->easy_init(
    {
        level  => $DEBUG,
        layout => '[%P] %d %m%n',
        'utf8' => 1
    }
);

# importa o projeto ja
use FindBin::libs qw( base=api subdir=lib );

# coloca ja o use no KV
#use SMM::KeyValueStorage;

my $logger = get_logger();
our $BAIL_OUT = 0;

# importa as funcoes para o script.
no strict 'refs';
*{"main::$_"} = *$_ for grep { defined &{$_} } keys %SMM::DaemonTools::;
use strict 'refs';

our $SMM_s3_obj;
our $SMM_s3_client_obj;

# coloca use strict/warnings sozinho
sub import {
    strict->import;
    warnings->import;
}

# logs
sub log_info {
    my (@texts) = @_;
    $logger->info( join ' ', @texts );
}

sub log_error {
    my (@texts) = @_;
    $logger->error( join ' ', @texts );
}

sub log_fatal {
    my (@texts) = @_;
    $logger->fatal( join ' ', @texts );
}

# daemon functions
sub log_and_exit {
    log_info "Graceful exit.";
    exit(0);
}

sub log_and_wait {
    log_info "SIG [TERM|INT] RECV. Waiting job...";
    $BAIL_OUT = 1;
}

# atalhos do daemon
sub ASKED_TO_EXIT {
    $BAIL_OUT;
}

sub EXIT_IF_ASKED {
    &log_and_exit() if $BAIL_OUT;
}

sub ON_TERM_EXIT {
    $SIG{TERM} = \&log_and_exit;
    $SIG{INT}  = \&log_and_exit;
}

sub ON_TERM_WAIT {
    $SIG{TERM} = \&log_and_wait;
    $SIG{INT}  = \&log_and_wait;
}

sub GET_SCHEMA {

    log_info "require SMM::Schema...";
    require SMM::Schema;

    # database
    my $db_host = $ENV{SMM_DB_HOST} || 'localhost';
    my $db_pass = $ENV{SMM_DB_PASS} || 'no-password';
    my $db_port = $ENV{SMM_DB_PORT} || '5432';
    my $db_user = $ENV{SMM_DB_USER} || 'postgres';
    my $db_name = $ENV{SMM_DB_NAME} || 'smm';

    SMM::Schema->connect(
        "dbi:Pg:host=$db_host;port=$db_port;dbname=$db_name",
        $db_user, $db_pass,
        {
            "AutoCommit"     => 1,
            "quote_char"     => "\"",
            "name_sep"       => ".",
            "pg_enable_utf8" => 1,
            "on_connect_do"  => "SET client_encoding=UTF8"
        }
    );

}

sub GET_S3 {
    return $SMM_s3_obj if $SMM_s3_obj;

    require Net::Amazon::S3;
    require LWP::UserAgent::Determined;
    require LWP::ConnCache;

    my $s3 = Net::Amazon::S3->new(
        {
            aws_access_key_id     => $ENV{AWS_ACCESS_KEY_ID},
            aws_secret_access_key => $ENV{AWS_SECRET_ACCESS_KEY},
            secure                => 0
        }
    );
    if ($s3) {
        my $ua_cache = LWP::ConnCache->new();
        $ua_cache->total_capacity(5);

        my $ua =
          LWP::UserAgent::Determined->new(
            requests_redirectable => [qw(GET HEAD DELETE PUT POST)], );
        $ua->timing('1,2,4,8,16,32');
        $ua->conn_cache($ua_cache);

        $s3->ua($ua);

        $SMM_s3_obj = $s3;
    }

    return $SMM_s3_obj;
}

sub GET_S3_CLIENT {
    $SMM_s3_client_obj
      ? $SMM_s3_client_obj
      : $SMM_s3_client_obj = Net::Amazon::S3::Client->new( s3 => $SMM_s3_obj );
}

1;
