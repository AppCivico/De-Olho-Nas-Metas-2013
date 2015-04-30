use utf8;
use FindBin qw($Bin);
use lib "$Bin/../../lib";

use SMM::Test::Further;

api_auth_as user_id => 1, roles => ['superadmin'];

db_transaction {

    rest_post '/goals',
      name  => 'criar meta',
      list  => 1,
      stash => 'goal',
      [
        name        => 'Foo Bar',
        description => 'Foo',
        goal_number => '999',
        technically => 'Foo'
      ];

    stash_test 'goal.get', sub {
        my ($me) = @_;
        is( $me->{id},    stash 'goal.id',  'get has the same id!' );
        is( $me->{name}, 'Foo Bar', 'name ok!' );
    };
    stash_test 'goal.list', sub {
        my ($me) = @_;

        ok( $me = delete $me->{goals}, 'users list exists' );

        is( @$me, 124, '124 goals' );

        $me = [ sort { $a->{id} <=> $b->{id} } @$me ];

        is( $me->[123]{name}, 'Foo Bar', 'listing ok' );
    };

    rest_put stash 'goal.url',
      name => 'atualizar meta',
      [
        name             => 'AAAAAAAAA',
      ];

    rest_reload 'goal';

    stash_test 'goal.get', sub {
        my ($me) = @_;

        is( $me->{name}, 'AAAAAAAAA', 'name updated!' );
    };

    rest_delete stash 'goal.url';

    rest_reload 'goal', 404;

    # ao inves de
    # my $list = rest_get '/users';
    # use DDP; p $list;

    # utilizar
    rest_reload_list 'goal';

    stash_test 'goal.list', sub {
        my ($me) = @_;
        ok( $me = delete $me->{goals}, 'goals list exists' );

        is( @$me, 123, '123 goals' );

        is( $me->[1]{name}, 'Beneficiar 228 mil novas famílias com o Programa Bolsa Família', 'listing ok' );
    };
};

done_testing;
