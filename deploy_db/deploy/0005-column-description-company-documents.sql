-- Deploy flipr:0005-column-description-company-documents to pg
-- requires: 0004-column-created_at

BEGIN;

ALTER TABLE company_documents ADD COLUMN description text;
COMMIT;
