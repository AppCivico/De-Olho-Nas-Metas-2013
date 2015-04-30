use utf8;
use FindBin qw($Bin);
use lib "$Bin/../../lib";

use SMM::Test::Further;

api_auth_as user_id => 1, roles => ['superadmin'];

db_transaction {

    rest_post '/companies',
      name  => 'criar compania',
      list  => 1,
      stash => 'company',
      [
        name           => 'Foo Bar',
        name_url => 'foo-bar',
      ];
    stash_test 'company.get', sub {
        my ($me) = @_;
        is( $me->{id},   stash 'company.id', 'get has the same id!' );
        is( $me->{name}, 'Foo Bar',          'name ok!' );
        is( $me->{name_url}, 'foo-bar',          'name ok!' );
    };
    stash_test 'company.list', sub {
        my ($me) = @_;

        ok( $me = delete $me->{companies}, 'companies list exists' );

        is( @$me, 5717, '5717 companies' );

        $me = [ sort { $a->{id} <=> $b->{id} } @$me ];

        is( $me->[5716]{name}, 'Foo Bar', 'listing ok' );
    };

    rest_put stash 'company.url',
      name => 'atualizar empresa',
      [ name => 'AAAAAAAAA', ];

    rest_reload 'company';

    stash_test 'company.get', sub {
        my ($me) = @_;

        is( $me->{name}, 'AAAAAAAAA', 'name updated!' );
    };

    rest_delete stash 'company.url';

    rest_reload 'company', 404;

    # ao inves de
    # my $list = rest_get '/users';
    # use DDP; p $list;

    # utilizar
    rest_reload_list 'company';

    stash_test 'company.list', sub {
        my ($me) = @_;
        ok( $me = delete $me->{companies}, 'companies list exists' );

        is( @$me, 5716, '5716 companies' );

        is( $me->[1]{name}, 'EDINEIR MATOS AMARAL DE SOUSA', 'listing ok' );
    };
};

done_testing;
