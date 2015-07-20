use lib './lib';
use SMM::Schema;
use lib "$Bin/../files";
use URI;
use Furl;
use JSON;
use DDP;
use Catalyst::Test q(SMM);
use utf8;
use DateTime::Format::DateParse;
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my $furl = Furl->new(
    agent   => 'SMM',
    timeout => '100',
);

my $url            = URI->new('http://planejasampa.prefeitura.sp.gov.br');
my %reject_project = (
    district             => 1,
    goal_id              => 1,
    prefectures          => 1,
    project_type         => 1,
    created_at           => 1,
    location_type        => 1,
    weight_about_goal    => 1,
    updated_at           => 1,
    id                   => 1,
    budget_executed_2014 => 1,
    budget_executed_2015 => 1,
    budget_executed_2016 => 1
);
my %reject_goal = (
    schedule_2015_2016 => 1,
    schedule_2013_2014 => 1,
    axis_id            => 1,
    articulation_id    => 1,
    status             => 1,
    project            => 1,
    secretaries        => 1,
    created_at         => 1,
    updated_at         => 1,
    porcentagem        => 1
);
my %reject_prefecture =
  ( pivot => 1, created_at => 1, updated_at => 1, id => 1 );

my $return;
my $res;
my $res_obj;
my @prefectures;
my @projects;
my @secretary;
my @secretaries;
my $db = $schema->resultset('Goal');


print "start update:";

$url->path_segments( 'metas', 'api', 'goals' );

my $res_goal = $furl->get($url);

$url->path_segments( 'metas', 'api', 'objectives' );
$res_obj = $furl->get($url);
my $data_obj = decode_json $res_obj->content;
my $data     = decode_json $res_goal->content;

#	p $data_obj;

my $objectives = {};
map { $objectives->{ $_->{id} } = $_->{name} } @$data_obj;
$schema->txn_do(
    sub {
        for my $goal (@$data) {
            my $return_goal = $schema->resultset('Goal')
              ->search( { goal_number => $goal->{id} } )->next;
            next unless $return_goal;

            @projects    = ();
            @secretaries = ();
            for my $sec ( @{ $goal->{secretaries} } ) {
                my $return_sec;

                $return_sec =
                  $schema->resultset('Secretary')
                  ->search( { name => $sec->{name} } )->next;
                delete $sec->{created_at};
                delete $sec->{updated_at};
                delete $sec->{pivot};
                $return_sec = $schema->resultset('Secretary')->create($sec)
                  unless $return_sec;

                push( @secretary, $return_sec->id );
            }
            for my $key ( @{ $goal->{projects} } ) {
                my $return_proj =
                  $schema->resultset('Project')
                  ->search( { project_number => $key->{id} } )->next;
                next unless $return_proj;

                @prefectures = ();

                for my $pref ( @{ $key->{prefectures} } ) {
                    my $return_pref;
                    $return_pref =
                      $schema->resultset('Prefecture')
                      ->search( { name => $pref->{name} } )->next;
                    delete $pref->{$_} for keys %reject_prefecture;
                    $pref->{latitude}  = delete $pref->{gps_lat};
                    $pref->{longitude} = delete $pref->{gps_long};

                    $return_pref =
                      $schema->resultset('Prefecture')->create($lol)
                      unless $return_pref;
                    push( @prefectures, $return_pref->id );
                }
                my $dt_proj = DateTime::Format::DateParse->parse_datetime(
                    $key->{updated_at} );
                if (   ( not defined $return_proj->updated_at )
                    || ( $dt_proj > $return_proj->updated_at ) )
                {
                    $return_proj->update(
                        {
                            qualitative_progress_1 =>
                              $key->{qualitative_progress_1},
                            qualitative_progress_2 =>
                              $key->{qualitative_progress_2},
                            qualitative_progress_3 =>
                              $key->{qualitative_progress_3},
                            qualitative_progress_4 =>
                              $key->{qualitative_progress_4},
                            qualitative_progress_5 =>
                              $key->{qualitative_progress_5},
                            qualitative_progress_6 =>
                              $key->{qualitative_progress_6},
                            updated_at => \"NOW()",
                            latitude   => $key->{gps_lat},
                            longitude  => $key->{gps_long}
                        }
                    );
                }
                delete $key->{$_} for keys %reject_project;
                percentage => {
                    required => 0,
                    type     => 'Str',
                  },

                  $key->{latitude} = delete $key->{gps_lat};
                $key->{longitude} = delete $key->{gps_long};

                $return_proj = $schema->resultset('Project')->create($key)
                  unless $return_proj;

                my $proj_vs_pref = {};
                map {
                    push(
                        @{ $proj_vs_pref->{ $_->{project_id} } },
                        $_->{prefecture_id}
                    );
                  } $schema->resultset('ProjectPrefecture')->search(
                    {},
                    {
                        result_class =>
                          'DBIx::Class::ResultClass::HashRefInflator',
                    }
                  )->all;

                for (@prefectures) {
                    next
                      if grep { $_ } @{ $proj_vs_pref->{ $return_proj->id } };
                    $schema->resultset('ProjectPrefecture')->create(
                        {
                            project_id    => $return_proj->id,
                            prefecture_id => $_
                        }
                    );
                }
                push( @projects, $return_proj->id )

            }
            my $dt_goal = DateTime::Format::DateParse->parse_datetime(
                $goal->{updated_at} );
            if (   ( not defined $return_goal->updated_at )
                || ( $dt_goal > $return_goal->updated_at ) )
            {
                $return_goal->update(
                    {
                        qualitative_progress_1 =>
                          $goal->{qualitative_progress_1},
                        qualitative_progress_2 =>
                          $goal->{qualitative_progress_2},
                        qualitative_progress_3 =>
                          $goal->{qualitative_progress_3},
                        qualitative_progress_4 =>
                          $goal->{qualitative_progress_4},
                        qualitative_progress_5 =>
                          $goal->{qualitative_progress_5},
                        qualitative_progress_6 =>
                          $goal->{qualitative_progress_6},
                        updated_at => \'NOW()',

                    }
                );
                $schema->resultset('GoalPorcentage')
                  ->search( { goal_id => $return_goal->id } )->update(
                    {
                        owned     => $goal->{porcentagem}->{concluido},
                        remainder => $goal->{porcentagem}->{restante}
                    }
                  );

            }
            delete $goal->{$_} for keys %reject_goal;
            $goal->{transversality}  = delete $goal->{transversalidade};
            $goal->{description}     = delete $goal->{observation};
            $goal->{expected_budget} = delete $goal->{total_cost};

            #my $porcentage = $furl->get( $c->stash->{url} . '' );

            my $goal_porcentage_obj;
            $goal_porcentage_obj =
              $schema->resultset('GoalPorcentage')
              ->search( { goal_id => $goal->{id} } )->next;

            $goal_porcentage_obj =
              $schema->resultset('GoalPorcentage')->create(
                {
                    goal_id   => $goal->{id},
                    owned     => $goal->{porcentagem}->{concluido},
                    remainder => $goal->{porcentagem}->{restante}
                }
              ) unless $goal_porcentage_obj;

            my $return_obj;
            $return_obj =
              $schema->resultset('Objective')
              ->search( { name => $objectives->{ $goal->{objective_id} } } )
              ->next;

            $return_obj =
              $schema->resultset('Objective')
              ->create( { name => $objectives->{ $goal->{objective_id} } } )
              unless $return_obj;

            $goal->{objective_id} = $return_obj->id;

            my $return_goal;
            $return_goal =
              $schema->resultset('Goal')->search( { id => $goal->{id} } )->next;

            $return_goal = $schema->resultset('Goal')->create($goal)
              unless $return_goal;

            my $goal_vs_proj = {};
            map {
                push( @{ $goal_vs_proj->{ $_->{goal_id} } }, $_->{project_id} );
              } $schema->resultset('GoalProject')->search(
                {},
                {
                    result_class => 'DBIx::Class::ResultClass::HashRefInflator',
                }
              )->all;

            for (@projects) {
                next if grep { $_ } @{ $goal_vs_proj->{ $return_goal->id } };
                my $lol = $c->model('DB::GoalProject')->create(
                    {
                        goal_id    => $return_goal->id,
                        project_id => $_
                    }
                );
            }
            my $goal_vs_sec = {};
            map {
                push( @{ $goal_vs_sec->{ $_->{goal_id} } },
                    $_->{secretary_id} );
              } $schema->resultset('GoalSecretary')->search(
                {},
                {
                    result_class => 'DBIx::Class::ResultClass::HashRefInflator',
                }
              )->all;
            for (@secretary) {
                next if $goal_vs_sec->{ $return_goal->id }{$_};
                next if grep { $_ } @{ $goal_vs_sec->{ $return_goal->id } };

                my $sec = $schema->resultset('GoalSecretary')->create(
                    {
                        goal_id      => $return_goal->id,
                        secretary_id => $_
                    }
                );
            }
        }
    }
);

print "finish update";
