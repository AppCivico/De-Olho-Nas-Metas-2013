-- Deploy flipr:0006-create_organization_type to pg
-- requires: 0005-column-description-company-documents

BEGIN;

-- XXX Add DDLs here.
CREATE TYPE org_type AS ENUM ('counsil', 'organization');

alter table organization_type add column type org_type;

update organization_type set type = 'counsil' where name = 'Conselho de Política Pública' or name = 'Conselho Participativo';

update organization_type set type = 'organization' where name = 'Organização da Sociedade Civil';


COMMIT;
