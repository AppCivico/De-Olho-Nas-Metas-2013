use utf8;

package SMM::Schema::Result::ViewCompanies;
use strict;
use warnings;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

# For the time being this is necessary even for virtual views
__PACKAGE__->table('ViewCompanies');

__PACKAGE__->add_columns(qw/business_name business_name_url goals total_value agg_budgets/);

# do not attempt to deploy() this view
__PACKAGE__->result_source_instance->is_virtual(1);

# business_name

__PACKAGE__->result_source_instance->view_definition(
    q[
    SELECT
		business_name,
		business_name_url,
		array_agg( g.id || E'|' || g.name ) as goals,
		sum(dedicated_value::numeric) as total_value,
        array_agg( replace(observation, E'|', ' ') || E'|' || dedicated_value   ) as agg_budgets
    FROM budget b JOIN goal g  ON b.goal_number = g.goal_number
         GROUP BY 1, b.goal_number, b.business_name_url ORDER BY 3
]
);

1;
