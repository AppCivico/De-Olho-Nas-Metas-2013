#!/usr/bin/perl
use utf8;
use FindBin qw($Bin);
use lib "$Bin/../../lib";

use SMM::Test::Further;

api_auth_as user_id => 1, roles => ['superadmin'];

db_transaction {

    # ao inves de
    my $list = rest_get '/companies';

    is( scalar @{ $list->{companies} }, 5716, '5716 companies' );

    is(
        $list->{companies}[1]{name},
        'EDINEIR MATOS AMARAL DE SOUSA',
        'listing ok'
    );

    my $budgets =
      rest_get '/companies/' . $list->{companies}[1]{id} . '/budgets';

    is( scalar @{ $budgets->{budgets} }, 2, '2 budgets' );

    is(
        $budgets->{budgets}[1]{business_name},
        'EDINEIR MATOS AMARAL DE SOUSA',
        'listing ok'
    );

};

done_testing;
