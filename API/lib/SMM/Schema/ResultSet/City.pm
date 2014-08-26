package SMM::Schema::ResultSet::City;
use namespace::autoclean;

use utf8;
use Moose;
extends 'DBIx::Class::ResultSet';
with 'SMM::Schema::Role::InflateAsHashRef';

1;

