-- Deploy appschema

BEGIN;
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-10-28 10:24:03 BRST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1951 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


--
-- TOC entry 169 (class 3079 OID 11680)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "plpgsql" WITH SCHEMA "pg_catalog";


--
-- TOC entry 1952 (class 0 OID 0)
-- Dependencies: 169
-- Name: EXTENSION "plpgsql"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "plpgsql" IS 'PL/pgSQL procedural language';


SET search_path = "public", pg_catalog;

SET default_with_oids = false;

--
-- TOC entry 164 (class 1259 OID 582725)
-- Dependencies: 5
-- Name: role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "role" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL
);


--
-- TOC entry 163 (class 1259 OID 582723)
-- Dependencies: 5 164
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "role_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1953 (class 0 OID 0)
-- Dependencies: 163
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "role_id_seq" OWNED BY "role"."id";


--
-- TOC entry 162 (class 1259 OID 582705)
-- Dependencies: 1910 1911 5
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "user" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "email" "text" NOT NULL,
    "active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "password" "text" NOT NULL,
    "created_by" integer,
    "type" character varying(12)
);


--
-- TOC entry 161 (class 1259 OID 582703)
-- Dependencies: 5 162
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "user_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1954 (class 0 OID 0)
-- Dependencies: 161
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "user_id_seq" OWNED BY "user"."id";


--
-- TOC entry 166 (class 1259 OID 582738)
-- Dependencies: 5
-- Name: user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "user_role" (
    "id" integer NOT NULL,
    "user_id" integer NOT NULL,
    "role_id" integer NOT NULL
);


--
-- TOC entry 165 (class 1259 OID 582736)
-- Dependencies: 166 5
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "user_role_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1955 (class 0 OID 0)
-- Dependencies: 165
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "user_role_id_seq" OWNED BY "user_role"."id";


--
-- TOC entry 168 (class 1259 OID 582758)
-- Dependencies: 1915 1916 5
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "user_session" (
    "id" integer NOT NULL,
    "user_id" integer NOT NULL,
    "api_key" "text",
    "valid_for_ip" "text",
    "valid_until" timestamp without time zone DEFAULT ("now"() + '1 day'::interval) NOT NULL,
    "ts_created" timestamp without time zone DEFAULT "now"() NOT NULL
);


--
-- TOC entry 167 (class 1259 OID 582756)
-- Dependencies: 168 5
-- Name: user_session_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "user_session_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 1956 (class 0 OID 0)
-- Dependencies: 167
-- Name: user_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "user_session_id_seq" OWNED BY "user_session"."id";


--
-- TOC entry 1912 (class 2604 OID 582728)
-- Dependencies: 164 163 164
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "role" ALTER COLUMN "id" SET DEFAULT "nextval"('"role_id_seq"'::"regclass");


--
-- TOC entry 1909 (class 2604 OID 582708)
-- Dependencies: 162 161 162
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user" ALTER COLUMN "id" SET DEFAULT "nextval"('"user_id_seq"'::"regclass");


--
-- TOC entry 1913 (class 2604 OID 582741)
-- Dependencies: 165 166 166
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user_role" ALTER COLUMN "id" SET DEFAULT "nextval"('"user_role_id_seq"'::"regclass");


--
-- TOC entry 1914 (class 2604 OID 582761)
-- Dependencies: 168 167 168
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user_session" ALTER COLUMN "id" SET DEFAULT "nextval"('"user_session_id_seq"'::"regclass");


--
-- TOC entry 1941 (class 0 OID 582725)
-- Dependencies: 164 1946
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "role" ("id", "name") VALUES (0, 'superadmin');
INSERT INTO "role" ("id", "name") VALUES (1, 'admin');
INSERT INTO "role" ("id", "name") VALUES (3, 'user');


--
-- TOC entry 1957 (class 0 OID 0)
-- Dependencies: 163
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"role_id_seq"', 10, true);


--
-- TOC entry 1939 (class 0 OID 582705)
-- Dependencies: 162 1946
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "user" ("id", "name", "email", "active", "created_at", "password", "created_by", "type") VALUES (1, 'superadmin', 'superadmin@email.com', true, '2013-10-28 10:18:12.570887', '$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW', NULL, NULL);
INSERT INTO "user" ("id", "name", "email", "active", "created_at", "password", "created_by", "type") VALUES (2, 'admin', 'admin@email.com', true, '2013-10-28 10:18:12.570887', '$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW', NULL, NULL);


--
-- TOC entry 1958 (class 0 OID 0)
-- Dependencies: 161
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"user_id_seq"', 22, true);


--
-- TOC entry 1943 (class 0 OID 582738)
-- Dependencies: 166 1946
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "user_role" ("id", "user_id", "role_id") VALUES (5, 1, 0);
INSERT INTO "user_role" ("id", "user_id", "role_id") VALUES (6, 1, 1);
INSERT INTO "user_role" ("id", "user_id", "role_id") VALUES (7, 2, 1);


--
-- TOC entry 1959 (class 0 OID 0)
-- Dependencies: 165
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"user_role_id_seq"', 25, true);


--
-- TOC entry 1945 (class 0 OID 582758)
-- Dependencies: 168 1946
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 1960 (class 0 OID 0)
-- Dependencies: 167
-- Name: user_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"user_session_id_seq"', 3, true);


--
-- TOC entry 1922 (class 2606 OID 582735)
-- Dependencies: 164 164 1947
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "role"
    ADD CONSTRAINT "role_name_key" UNIQUE ("name");


--
-- TOC entry 1924 (class 2606 OID 582733)
-- Dependencies: 164 164 1947
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "role"
    ADD CONSTRAINT "role_pkey" PRIMARY KEY ("id");


--
-- TOC entry 1918 (class 2606 OID 582717)
-- Dependencies: 162 162 1947
-- Name: user_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT "user_email_key" UNIQUE ("email");


--
-- TOC entry 1920 (class 2606 OID 582715)
-- Dependencies: 162 162 1947
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT "user_pkey" PRIMARY KEY ("id");


--
-- TOC entry 1928 (class 2606 OID 582743)
-- Dependencies: 166 166 1947
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user_role"
    ADD CONSTRAINT "user_role_pkey" PRIMARY KEY ("id");


--
-- TOC entry 1930 (class 2606 OID 582770)
-- Dependencies: 168 168 1947
-- Name: user_session_api_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user_session"
    ADD CONSTRAINT "user_session_api_key_key" UNIQUE ("api_key");


--
-- TOC entry 1933 (class 2606 OID 582768)
-- Dependencies: 168 168 1947
-- Name: user_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user_session"
    ADD CONSTRAINT "user_session_pkey" PRIMARY KEY ("id");


--
-- TOC entry 1925 (class 1259 OID 582754)
-- Dependencies: 166 1947
-- Name: user_role_idx_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "user_role_idx_role_id" ON "user_role" USING "btree" ("role_id");


--
-- TOC entry 1926 (class 1259 OID 582755)
-- Dependencies: 166 1947
-- Name: user_role_idx_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "user_role_idx_user_id" ON "user_role" USING "btree" ("user_id");


--
-- TOC entry 1931 (class 1259 OID 582776)
-- Dependencies: 168 1947
-- Name: user_session_idx_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "user_session_idx_user_id" ON "user_session" USING "btree" ("user_id");


--
-- TOC entry 1934 (class 2606 OID 582777)
-- Dependencies: 162 1919 162 1947
-- Name: user_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT "user_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "user"("id");


--
-- TOC entry 1935 (class 2606 OID 582744)
-- Dependencies: 1923 164 166 1947
-- Name: user_role_fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user_role"
    ADD CONSTRAINT "user_role_fk_role_id" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 1936 (class 2606 OID 582749)
-- Dependencies: 166 1919 162 1947
-- Name: user_role_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user_role"
    ADD CONSTRAINT "user_role_fk_user_id" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 1937 (class 2606 OID 582771)
-- Dependencies: 168 162 1919 1947
-- Name: user_session_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user_session"
    ADD CONSTRAINT "user_session_fk_user_id" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


-- Completed on 2013-10-28 10:24:03 BRST

--
-- PostgreSQL database dump complete
--



COMMIT;
