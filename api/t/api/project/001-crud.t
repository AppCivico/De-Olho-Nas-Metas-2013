use utf8;
use FindBin qw($Bin);
use lib "$Bin/../../lib";

use SMM::Test::Further;

api_auth_as user_id => 1, roles => ['superadmin'];

db_transaction {

    rest_post '/projects',
      name  => 'criar projeto',
      list  => 1,
      stash => 'project',
      [
        name        => 'Foo Bar',
        description => 'Foo',
        project_number => '9999',
      ];
    stash_test 'project.get', sub {
        my ($me) = @_;
        is( $me->{id},   stash 'project.id', 'get has the same id!' );
        is( $me->{name}, 'Foo Bar',       'name ok!' );
    };
    stash_test 'project.list', sub {
        my ($me) = @_;

        ok( $me = delete $me->{projects}, 'projects list exists' );

        is( @$me, 2162, '2162 projects' );

        $me = [ sort { $a->{id} <=> $b->{id} } @$me ];

        is( $me->[2161]{name}, 'Foo Bar', 'listing ok' );
    };

    rest_put stash 'project.url',
      name => 'atualizar projeto',
      [ name => 'AAAAAAAAA', ];

    rest_reload 'project';

    stash_test 'project.get', sub {
        my ($me) = @_;

        is( $me->{name}, 'AAAAAAAAA', 'name updated!' );
    };

    rest_delete stash 'project.url';

    rest_reload 'project', 404;

    # ao inves de
    # my $list = rest_get '/users';
    # use DDP; p $list;

    # utilizar
    rest_reload_list 'project';

    stash_test 'project.list', sub {
        my ($me) = @_;
        ok( $me = delete $me->{projects}, 'projects list exists' );

        is( @$me, 2161, '2161 projects' );

        is(
            $me->[1]{name},
            'Abel Marciano (Jardim Japão 1)',
            'listing ok'
        );
    };
};

done_testing;
