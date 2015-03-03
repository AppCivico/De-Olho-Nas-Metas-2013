use utf8;

package SMM::Schema::Result::ViewCompanies;
use strict;
use warnings;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

# For the time being this is necessary even for virtual views
__PACKAGE__->table('ViewCompanies');

__PACKAGE__->add_columns(qw/business_name total_value agg_budgets/);

# do not attempt to deploy() this view
__PACKAGE__->result_source_instance->is_virtual(1);

# business_name

__PACKAGE__->result_source_instance->view_definition(
    q[
    SELECT
		business_name,
		sum(dedicated_value::numeric) as total_value,
        array_agg( replace(observation, E'|', ' ') || E'|' || dedicated_value   ) as agg_budgets
    FROM budget
        WHERE business_name = ? GROUP BY 1 ORDER BY 3
]
);

1;
