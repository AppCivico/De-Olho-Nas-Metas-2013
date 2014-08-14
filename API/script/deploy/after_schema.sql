SELECT setval('user_id_seq', 10, true);
SELECT setval('role_id_seq', 10, true);


-- all passwords are 12345

INSERT INTO "role"(id,name)
VALUES
(0,'superadmin'),
(1,'admin'),
(2,'client'),
(3,'user'),
(4,'admin-print'),
(5,'admin-sticker'),
(6,'admin-tracker'),
(7,'webapi');


INSERT INTO "user"(id, name, email, password) VALUES (1, 'superadmin','superadmin@email.com', '$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW');
INSERT INTO "user"(id, name, email, password) VALUES (2, 'webapi-1','no email', 'no password');
INSERT INTO "user"(id, name, email, password) VALUES (3, 'admin-tracker','admin-tracker@email.com', '$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW');
INSERT INTO "user"(id, name, email, password) VALUES (4, 'admin','admin@email.com', '$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW');



-- role: superadmin                                     user:
INSERT INTO "user_role" ( user_id, role_id) VALUES (1, 0); -- superadmin

-- role: webapi                                         user:
INSERT INTO "user_role" ( user_id, role_id) VALUES (2, 7); -- webapi-1

-- role: admintracker                                         user:
INSERT INTO "user_role" ( user_id, role_id) VALUES (3, 6); -- admin-tracker

-- role: admin
INSERT INTO "user_role" ( user_id, role_id) VALUES (4, 1); -- admin

-- usuario da API
-- que tem acesso aos endpoints 'publicos'
INSERT INTO user_session(user_id,api_key,valid_for_ip,valid_until)
VALUES (2, 'p01IpoDpNjPAzB8azQVTcK7v450u1EAjlnFu0J0DPbDz6uuMVgSsFst8wDRF17v9qOcGP8mK6wJfAOMwnRDMhHmsnK84Tma20kdC', null, '2020-01-01');


-- estados/paises/cidades
INSERT INTO "country" (name, name_url, created_by) VALUES ('Brasil', 'brasil', 1); -- default country

--insert brazilian states
INSERT INTO state (id, name, uf, country_id, created_by) VALUES
(1, 'Acre', 'AC',1,1),
(2, 'Alagoas', 'AL',1,1),
(3, 'Amapá', 'AP',1,1),
(4, 'Amazonas', 'AM',1,1),
(5, 'Bahia', 'BA',1,1),
(6, 'Ceará', 'CE',1,1),
(7, 'Distrito Federal', 'DF',1,1),
(8, 'Espírito Santo', 'ES',1,1),
(9, 'Goiás', 'GO',1,1),
(10, 'Maranhão', 'MA',1,1),
(11, 'Mato Grosso', 'MT',1,1),
(12, 'Mato Grosso do Sul', 'MS',1,1),
(13, 'Minas Gerais', 'MG',1,1),
(14, 'Pará', 'PA',1,1),
(15, 'Paraíba', 'PB',1,1),
(16, 'Paraná', 'PR',1,1),
(17, 'Pernambuco', 'PE',1,1),
(18, 'Piauí', 'PI',1,1),
(19, 'Rio de Janeiro', 'RJ',1,1),
(20, 'Rio Grande do Norte', 'RN',1,1),
(21, 'Rio Grande do Sul', 'RS',1,1),
(22, 'Rondônia', 'RO',1,1),
(23, 'Roraima', 'RR',1,1),
(24, 'Santa Catarina', 'SC',1,1),
(25, 'São Paulo', 'SP',1,1),
(26, 'Sergipe', 'SE',1,1),
(27, 'Tocantins', 'TO',1,1);

INSERT INTO "city" (name, state_id, country_id, name_url) VALUES ('São paulo', 1, 1, 'sao-paulo'); -- insert default city



CREATE OR REPLACE FUNCTION f_driver_documents_validated()
  RETURNS trigger AS
$BODY$
    BEGIN

        IF TG_OP = 'DELETE' THEN

        UPDATE driver
        SET documents_validated = false
        WHERE user_id = OLD.user_id;

        RETURN OLD;
    ELSE

        UPDATE driver
        SET documents_validated = (
            ( select count(1) from "document" where user_id = NEW.user_id and class_name = 'registro_cnh' AND validated_at IS NOT NULL )+
            ( select count(1) from "document" where user_id = NEW.user_id and class_name = 'comprovante_residencia' AND validated_at IS NOT NULL)+
            ( select count(1) from "document" where user_id = NEW.user_id and class_name = 'foto_carro' AND validated_at IS NOT NULL)
        ) = 3
        WHERE user_id = NEW.user_id;

        RETURN NEW;
    END IF;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE TRIGGER t_driver_documents_validated
  AFTER INSERT OR UPDATE OR DELETE
  ON document
  FOR EACH ROW
  EXECUTE PROCEDURE f_driver_documents_validated();
