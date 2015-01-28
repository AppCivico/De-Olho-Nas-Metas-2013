use utf8;
package SMM::Schema::Result::Region;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Region

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

=head1 TABLE: C<region>

=cut

__PACKAGE__->table("region");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'region_id_seq'

=head2 geom

  data_type: 'geometry'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 lat

  data_type: 'text'
  is_nullable: 1

=head2 long

  data_type: 'text'
  is_nullable: 1

=head2 subprefecture_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "region_id_seq",
  },
  "geom",
  { data_type => "geometry", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "lat",
  { data_type => "text", is_nullable => 1 },
  "long",
  { data_type => "text", is_nullable => 1 },
  "subprefecture_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 project_regions

Type: has_many

Related object: L<SMM::Schema::Result::ProjectRegion>

=cut

__PACKAGE__->has_many(
  "project_regions",
  "SMM::Schema::Result::ProjectRegion",
  { "foreign.region_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 projects

Type: has_many

Related object: L<SMM::Schema::Result::Project>

=cut

__PACKAGE__->has_many(
  "projects",
  "SMM::Schema::Result::Project",
  { "foreign.region_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 subprefecture

Type: belongs_to

Related object: L<SMM::Schema::Result::Subprefecture>

=cut

__PACKAGE__->belongs_to(
  "subprefecture",
  "SMM::Schema::Result::Subprefecture",
  { id => "subprefecture_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2015-01-27 06:10:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rcMPzM1A6BZqTS1zEGeCpw


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
                name => {
                    required => 0,
                    type     => 'Str',
                },
                geom => {
                    required => 0,
                    type     => 'Str',
                },
                lat => {
                    required => 0,
                    type     => 'Str',
                },
                long => {
                    required => 0,
                    type     => 'Str',
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

            my $region = $self->update( \%values );

            return $region;
		}
	}
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
