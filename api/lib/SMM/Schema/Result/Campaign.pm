use utf8;
package SMM::Schema::Result::Campaign;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Campaign

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

=head1 TABLE: C<campaign>

=cut

__PACKAGE__->table("campaign");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'campaign_id_seq'

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 start_in

  data_type: 'date'
  is_nullable: 0

=head2 end_on

  data_type: 'date'
  is_nullable: 0

=head2 address

  data_type: 'text'
  is_nullable: 1

=head2 latitude

  data_type: 'text'
  is_nullable: 1

=head2 longitude

  data_type: 'text'
  is_nullable: 1

=head2 region_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 organization_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 free_text

  data_type: 'text'
  is_nullable: 1

=head2 objective

  data_type: 'text'
  is_nullable: 0

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 mobile_campaign_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "campaign_id_seq",
  },
  "description",
  { data_type => "text", is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "start_in",
  { data_type => "date", is_nullable => 0 },
  "end_on",
  { data_type => "date", is_nullable => 0 },
  "address",
  { data_type => "text", is_nullable => 1 },
  "latitude",
  { data_type => "text", is_nullable => 1 },
  "longitude",
  { data_type => "text", is_nullable => 1 },
  "region_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "organization_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "free_text",
  { data_type => "text", is_nullable => 1 },
  "objective",
  { data_type => "text", is_nullable => 0 },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "mobile_campaign_id",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 events

Type: has_many

Related object: L<SMM::Schema::Result::Event>

=cut

__PACKAGE__->has_many(
  "events",
  "SMM::Schema::Result::Event",
  { "foreign.campaign_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organization

Type: belongs_to

Related object: L<SMM::Schema::Result::Organization>

=cut

__PACKAGE__->belongs_to(
  "organization",
  "SMM::Schema::Result::Organization",
  { id => "organization_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 project

Type: belongs_to

Related object: L<SMM::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "SMM::Schema::Result::Project",
  { id => "project_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 region

Type: belongs_to

Related object: L<SMM::Schema::Result::Region>

=cut

__PACKAGE__->belongs_to(
  "region",
  "SMM::Schema::Result::Region",
  { id => "region_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 user

Type: belongs_to

Related object: L<SMM::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "SMM::Schema::Result::User",
  { id => "user_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-04-17 16:01:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Drfwz+43yxFahgT4JzAHBQ

with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;

sub verifiers_specs {
    my $self = shift;
    return {
        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                description => {
                    required => 1,
                    type     => 'Str',
                },
                start_in=> {
                    required => 1,
                    type     => 'DateTime',
                },
                end_on=> {
                    required => 1,
                    type     => 'DateTime',
                },
                user_id => {
                    required => 0,
                    type     => 'Int',
                },
            }
        ),
    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $campaign = $self->update( \%values );

            return $campaign;
        },

    };
}
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
