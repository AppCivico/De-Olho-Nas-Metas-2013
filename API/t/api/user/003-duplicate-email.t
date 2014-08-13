use strict;
use warnings;
use utf8;

use FindBin qw($Bin);
use lib "$Bin/../../lib";

use SMM::Test::Further;

api_auth_as;

db_transaction {

    rest_post '/users',
      name  => 'criar usuario',
      stash => 'user1',
      [
        name     => 'Foo Bar',
        email    => 'foo1@email.com',
        password => 'foobarquux1',
        role     => 'user'
      ];

    rest_post '/users',
      name    => 'nao criar usuario com mesmo email',
      stash   => 'user2',
      is_fail => 1,
      [
        name     => 'Foo Bar',
        email    => 'foo1@email.com',
        password => 'foobarquux1',
        role     => 'user'
      ];

    stash_test 'user2', sub {
        my ($me) = @_;
        like( $me->{error}, qr/"email":"invalid"/, 'email invalido' );
    };


    rest_post '/users',
      name    => 'criando mais um usuario com email diferente',
      stash   => 'user2',
      [
        name     => 'ZumbBar',
        email    => 'foo2@email.com',
        password => 'foobarquux1',
        role     => 'user'
      ];

    stash_test 'user2.get', sub {
        my ($me) = @_;

        is( $me->{email}, 'foo2@email.com', 'email valido' );
    };

    rest_put stash 'user2.url',
      name => 'atualizar o email do usuario',
      [
        'email'              => 'email_novo@email.com'
      ];

    rest_reload 'user2';

    stash_test 'user2.get', sub {
        my ($me) = @_;
        is( $me->{email}, 'email_novo@email.com', 'email atualizado' );
    };


    rest_put stash 'user2.url',
      is_fail => 1,
      stash => 'user2',
      name => 'atualizar usuario novo com o email do antigo tem que dar pau',
      [
        'email'              => 'foo1@email.com'
      ];

    stash_test 'user2', sub {
        my ($me) = @_;
        like( $me->{error}, qr/"email":"invalid"/, 'email invalido' );
    };

};
done_testing;
