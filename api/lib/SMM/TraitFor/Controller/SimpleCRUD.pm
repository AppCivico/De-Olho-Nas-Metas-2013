package SMM::TraitFor::Controller::SimpleCRUD;

use Moose::Role;

# keep in order!!
with 'SMM::TraitFor::Controller::AutoBase';      # 1
with 'SMM::TraitFor::Controller::AutoObject';    # 2
with 'SMM::TraitFor::Controller::AutoResult';    # 3

with 'SMM::TraitFor::Controller::CheckRoleForPUT';
with 'SMM::TraitFor::Controller::CheckRoleForPOST';

with 'SMM::TraitFor::Controller::AutoList';      # 1
with 'SMM::TraitFor::Controller::Search';        # 2

1;

