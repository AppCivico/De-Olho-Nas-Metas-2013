use strict;
use warnings;
use utf8;

use FindBin qw($Bin);
use lib "$Bin/../../lib";

use SMM::Test::Further;

db_transaction {

    my $res = rest_get '/users', 403;
    is($res->{error}, 'access denied','access denied');

    rest_post '/login',
      name  => 'teste o login',
      is_fail => 1,
      stash => 'login',
      [
        'email'    => 'superadmin@email.com',
        'password' => '44444'
      ];

    stash_test 'login', sub {
        my ($me) = @_;

        is($me->{error}, "Login invalid(2)", 'Login invalid');
    };

    rest_post '/login',
      name  => 'teste o login',
      code  => 200,
      stash => 'login',
      [
        'email'    => 'superadmin@email.com',
        'password' => '12345'
      ];

    stash_test 'login', sub {
        my ($me) = @_;

        ok($me->{api_key}, 'has api_key');
        is($me->{email}, 'superadmin@email.com', 'email ok');

        is_deeply($me->{roles}, ['superadmin','admin'], 'roles looks good');

        my $users = rest_get '/users', 200, {api_key => $me->{api_key}};

        is (@{$users->{users}}, 2, 'have 2 users');

    };

};

done_testing;
