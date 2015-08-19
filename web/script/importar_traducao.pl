use lib '.lib';
use utf8;
use WebSMM::Schema;
use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use DDP;
use Moose;
use Text::CSV;

use Catalyst::Test q(WebSMM);
my $config = WebSMM->config;

my $schema = WebSMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password},
    {
        quote_char => q{"},
        name_sep   => q{.}

    }
);

$schema->txn_do(
    sub {

        my $file = $ARGV[0];

        my $csv = Text::CSV_XS->new( { binary => 1, sep_char => q/;/ } )
          or die "Cannot use CSV: " . Text::CSV_XS->error_diag();
        open my $fh, "<:encoding(utf8)", $file or die "$file: $!";
        while ( my $row = $csv->getline($fh) ) {
            use DDP;
            p $row;
            my $lexicon = $schema->resultset('Lexicon')
              ->search( { lang => 'es', lex_key => $row->[2] } )->next;

            if ($lexicon) {

                $lexicon->update( { lex_value => $row->[3] } );
            }
        }
    }
);
