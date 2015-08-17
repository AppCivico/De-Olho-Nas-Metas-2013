use lib './lib';
use strict;
use warnings;
use utf8;
use SMM::Schema;
use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use DDP;
use Moose;
use Catalyst::Test q(SMM);
use JSON;
my $config = SMM->config;
my $model  = SMM::Model::File::CSV->new();

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);
my $furl = Furl->new(
    agent   => 'SMM',
    timeout => '100',
);

$schema->txn_do(
    sub {
        my @projects =
          $schema->resultset('Project')
          ->search( { 'goal_projects.project_id' => undef },
            { join => 'goal_projects' } )->all;

        for my $p (@projects) {
            my $url = URI->new('http://planejasampa.prefeitura.sp.gov.br');
            p $p->project_number;
            $url->path_segments( 'metas', 'api', 'project',
                $p->project_number );
            p $url->as_string;
            my $res = $furl->get($url);

            use DDP;
            my $json = decode_json( $res->content );

            my $lat  if $json->{latitude} =~ qr/^(\-?\d+(\.\d+)?)$/;
            my $long if $json->{longitude} =~ qr/^(\-?\d+(\.\d+)?)$/;
            my $lnglat;
            my $lnglat_split;
            if ( $json->{latitude} && $json->{longitude} ) {

                $lnglat = join( q/ /, $lat, $long );
                $lnglat_split = $lnglat
                  if $lnglat =~ qr/^(\-?\d+(\.\d+)?)\ \s*(\-?\d+(\.\d+)?)$/;
            }
            if ($lnglat_split) {
                my $region = $schema->resultset('Region')->search_rs(

                    \[
                        q{ST_Intersects(me.geom::geography, ?::geography )},
                        [ _coords => qq{SRID=4326;POINT($lnglat)} ]
                    ],
                    {
                        select => [qw/id/],
                        result_class =>
                          'DBIx::Class::ResultClass::HashRefInflator',
                    }
                )->next;
                $p->update( { region_id => $region->id } ) if $region;
            }

            $p->add_to_goal_projects( { goal_id => $json->{goal_id} } )
              unless $schema->resultset('GoalProject')
              ->search( { project_id => $p->id, goal_id => $json->{goal_id} } )
              ->next;
        }
    }
);
