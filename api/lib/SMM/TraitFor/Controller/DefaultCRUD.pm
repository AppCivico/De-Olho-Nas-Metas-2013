package SMM::TraitFor::Controller::DefaultCRUD;

use Moose::Role;

with 'SMM::TraitFor::Controller::Search';
with 'SMM::TraitFor::Controller::AutoBase';
with 'SMM::TraitFor::Controller::AutoObject';
with 'SMM::TraitFor::Controller::CheckRoleForPUT';
#with 'SMM::TraitFor::Controller::CheckRoleForPOST';

1;

