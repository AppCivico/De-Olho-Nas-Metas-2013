package SMM::Schema::ResultSet::File;

use namespace::autoclean;

use Moose;

extends 'DBIx::Class::ResultSet';

with 'SMM::Schema::Role::InflateAsHashRef';
