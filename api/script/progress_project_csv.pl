use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Text::CSV;

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

open my $fh, '<:encoding(utf8)', 'data/projects_sort.csv' or die "nao abriu";

my @rows;
my $data = {};
while ( my $row = $csv->getline($fh) ) {
    if ( defined $data->{ $row->[0] } ) {
        $data->{ $row->[0] } = $row->[1] if $data->{ $row->[0] } < $row->[1];
        $data->{ $row->[0] } = $row->[1] if $data->{ $row->[0] } eq "";
        next;
    }
    $data->{ $row->[0] } = $row->[1];
}

for my $k ( keys %{$data} ) {
    use DDP;
    $data->{$k} =~ s/%//;
    $data->{$k} =~ s/,/./;
    $data->{$k} =~ s/.0$//;
    $schema->resultset('Project')->search( { name => { ilike => $k } } )
      ->update( { porcentage => $data->{$k} } );

    p $k;
}
$csv->eol("\r\n");
