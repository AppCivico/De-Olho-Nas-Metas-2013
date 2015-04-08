use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Text::CSV;
use DDP;
use List::Util qw/sum/;
use JSON;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my $csv = Text::CSV->new(
    { binary => 1, sep_char => ';' } )    # should set binary attribute.
  or die "Cannot use CSV: " . Text::CSV->error_diag();

open my $fh, '<:encoding(utf8)', 'data/project_milestones.csv'
  or die "nao abriu";

my $furl = Furl->new(
    agent   => 'SMM',
    timeout => 100
);

my @project = $schema->resultset('Project')->all;

for my $p (@project) {

    my $url = URI->new("http://planejasampa.prefeitura.sp.gov.br/metas/api");
    next unless $p->project_number;
    $url->path_segments( 'metas', 'api', 'project', $p->project_number );
    my $resp  = $furl->get( $url->as_string );
    my $value = decode_json $resp->content;

    $schema->resultset('Project')->search( { name => { ilike => $p->name } } )
      ->update( { type => $value->{project_type} } );

}
