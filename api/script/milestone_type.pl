use lib './lib';
use utf8;
use SMM::Schema;
use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use URI;
use Furl;
use JSON;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);
my $furl = Furl->new(
    agent   => 'SMM',
    timeout => 100
);

my @types = $schema->resultset('ProjectType')->all;

use DDP;
p @types;
for my $t (@types) {
    p $t;
    next if $t->id eq 8;
    my $url = URI->new("http://planejasampa.prefeitura.sp.gov.br/metas/api");

    $url->path_segments( 'metas', 'api', 'project', 'type', $t->id,
        'milestones' );

    my $res = $furl->get( $url->as_string );
    my $data = decode_json $res->content if decode_json $res->content;
    use DDP;
    p $data;
    for my $d ( sort { $a <=> $b } keys %{$data} ) {
        p $d;
        my $pt = $schema->resultset('Milestone')->create(
            {
                name            => $data->{$d}->{name},
                percentage      => $data->{$d}->{percentage},
                project_type_id => $t->id,
                sequence        => $d
            }
        );

    }
}
