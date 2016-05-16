use utf8;
package SMM::Schema::Result::Budget;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Budget

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<budget>

=cut

__PACKAGE__->table("budget");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'budget_id_seq'

=head2 business_name

  data_type: 'text'
  is_nullable: 1

=head2 cnpj

  data_type: 'text'
  is_nullable: 1

=head2 goal_number

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 dedicated_value

  data_type: 'text'
  is_nullable: 1

=head2 liquidated_value

  data_type: 'text'
  is_nullable: 1

=head2 observation

  data_type: 'text'
  is_nullable: 1

=head2 contract_code

  data_type: 'text'
  is_nullable: 1

=head2 dedicated_year

  data_type: 'text'
  is_nullable: 1

=head2 organ_code

  data_type: 'integer'
  is_nullable: 1

=head2 organ_name

  data_type: 'text'
  is_nullable: 1

=head2 business_name_url

  data_type: 'text'
  is_nullable: 1

=head2 company_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 cod_emp

  data_type: 'text'
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "budget_id_seq",
  },
  "business_name",
  { data_type => "text", is_nullable => 1 },
  "cnpj",
  { data_type => "text", is_nullable => 1 },
  "goal_number",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "dedicated_value",
  { data_type => "text", is_nullable => 1 },
  "liquidated_value",
  { data_type => "text", is_nullable => 1 },
  "observation",
  { data_type => "text", is_nullable => 1 },
  "contract_code",
  { data_type => "text", is_nullable => 1 },
  "dedicated_year",
  { data_type => "text", is_nullable => 1 },
  "organ_code",
  { data_type => "integer", is_nullable => 1 },
  "organ_name",
  { data_type => "text", is_nullable => 1 },
  "business_name_url",
  { data_type => "text", is_nullable => 1 },
  "company_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "cod_emp",
  { data_type => "text", is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "updated_at",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 company

Type: belongs_to

Related object: L<SMM::Schema::Result::Company>

=cut

__PACKAGE__->belongs_to(
  "company",
  "SMM::Schema::Result::Company",
  { id => "company_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 goal_number

Type: belongs_to

Related object: L<SMM::Schema::Result::Goal>

=cut

__PACKAGE__->belongs_to(
  "goal_number",
  "SMM::Schema::Result::Goal",
  { id => "goal_number" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-13 12:05:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NmOTXrPnTFJiFGQ8o+aA7A

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
