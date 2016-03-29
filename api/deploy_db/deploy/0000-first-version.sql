--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.6
-- Dumped by pg_dump version 9.4.6
-- Started on 2016-03-28 17:32:39 BRT

begin;


CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 4099 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 2 (class 3079 OID 209187)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4100 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

--
-- TOC entry 1827 (class 1247 OID 210553)
-- Name: org_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE org_type AS ENUM (
    'counsil',
    'organization'
);


--
-- TOC entry 1830 (class 1247 OID 210558)
-- Name: project_progress_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE project_progress_type AS ENUM (
    'late',
    'in_progress',
    'completed'
);


--
-- TOC entry 1833 (class 1247 OID 210566)
-- Name: user_request_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE user_request_type AS ENUM (
    'pending',
    'denied',
    'accepted'
);


SET default_with_oids = false;

--
-- TOC entry 189 (class 1259 OID 210573)
-- Name: budget; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE budget (
    id integer NOT NULL,
    business_name text,
    cnpj text,
    goal_number integer,
    dedicated_value text,
    liquidated_value text,
    observation text,
    contract_code text,
    dedicated_year text,
    organ_code integer,
    organ_name text,
    business_name_url text,
    company_id integer,
    cod_emp text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


--
-- TOC entry 190 (class 1259 OID 210580)
-- Name: budget_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE budget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4101 (class 0 OID 0)
-- Dependencies: 190
-- Name: budget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE budget_id_seq OWNED BY budget.id;


--
-- TOC entry 191 (class 1259 OID 210582)
-- Name: campaign; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE campaign (
    id integer NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    user_id integer,
    name text NOT NULL,
    start_in date NOT NULL,
    end_on date NOT NULL,
    region_id integer,
    address text,
    latitude text,
    longitude text,
    organization_id integer,
    free_text text,
    objective text NOT NULL,
    project_id integer,
    mobile_campaign_id integer,
    request_council boolean DEFAULT false
);


--
-- TOC entry 192 (class 1259 OID 210590)
-- Name: campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4102 (class 0 OID 0)
-- Dependencies: 192
-- Name: campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campaign_id_seq OWNED BY campaign.id;


--
-- TOC entry 193 (class 1259 OID 210592)
-- Name: city; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE city (
    id integer NOT NULL,
    name text NOT NULL,
    name_url text,
    state_id integer,
    country_id integer
);


--
-- TOC entry 194 (class 1259 OID 210598)
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 195 (class 1259 OID 210600)
-- Name: comment_goal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE comment_goal (
    id integer NOT NULL,
    description text,
    "timestamp" timestamp without time zone DEFAULT now(),
    approved boolean DEFAULT false,
    goal_id integer,
    active boolean DEFAULT true,
    user_id integer
);


--
-- TOC entry 196 (class 1259 OID 210609)
-- Name: comment_goal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comment_goal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4103 (class 0 OID 0)
-- Dependencies: 196
-- Name: comment_goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comment_goal_id_seq OWNED BY comment_goal.id;


--
-- TOC entry 197 (class 1259 OID 210611)
-- Name: comment_project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE comment_project (
    id integer NOT NULL,
    description text,
    "timestamp" timestamp without time zone DEFAULT now(),
    approved boolean DEFAULT false,
    project_id integer,
    user_id integer,
    active boolean DEFAULT true,
    org_id integer
);


--
-- TOC entry 198 (class 1259 OID 210620)
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4104 (class 0 OID 0)
-- Dependencies: 198
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comment_id_seq OWNED BY comment_project.id;


--
-- TOC entry 199 (class 1259 OID 210622)
-- Name: company; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE company (
    id integer NOT NULL,
    name text NOT NULL,
    name_url text NOT NULL,
    cnpj text
);


--
-- TOC entry 200 (class 1259 OID 210628)
-- Name: company_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE company_documents (
    id integer NOT NULL,
    url_name text NOT NULL,
    company_id integer,
    description text
);


--
-- TOC entry 201 (class 1259 OID 210634)
-- Name: company_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE company_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4105 (class 0 OID 0)
-- Dependencies: 201
-- Name: company_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE company_documents_id_seq OWNED BY company_documents.id;


--
-- TOC entry 202 (class 1259 OID 210636)
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4106 (class 0 OID 0)
-- Dependencies: 202
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE company_id_seq OWNED BY company.id;


--
-- TOC entry 203 (class 1259 OID 210638)
-- Name: contact; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contact (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 204 (class 1259 OID 210645)
-- Name: contact_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4107 (class 0 OID 0)
-- Dependencies: 204
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contact_id_seq OWNED BY contact.id;


--
-- TOC entry 205 (class 1259 OID 210647)
-- Name: country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE country (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 210653)
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 207 (class 1259 OID 210655)
-- Name: district; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE district (
    id integer NOT NULL,
    name text NOT NULL,
    city_id integer NOT NULL,
    center_lat_long point NOT NULL,
    perimeter text NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 210661)
-- Name: district_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4108 (class 0 OID 0)
-- Dependencies: 208
-- Name: district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE district_id_seq OWNED BY district.id;


--
-- TOC entry 209 (class 1259 OID 210663)
-- Name: email_queue; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE email_queue (
    id integer NOT NULL,
    recipient_id integer,
    body text NOT NULL,
    sent boolean DEFAULT false,
    sent_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    title character varying
);


--
-- TOC entry 210 (class 1259 OID 210671)
-- Name: email_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE email_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4109 (class 0 OID 0)
-- Dependencies: 210
-- Name: email_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE email_queue_id_seq OWNED BY email_queue.id;


--
-- TOC entry 211 (class 1259 OID 210673)
-- Name: event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE event (
    id integer NOT NULL,
    description text,
    date timestamp without time zone NOT NULL,
    campaign_id integer,
    created_at timestamp without time zone DEFAULT now(),
    user_id integer,
    name text NOT NULL,
    council_id integer
);


--
-- TOC entry 212 (class 1259 OID 210680)
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4110 (class 0 OID 0)
-- Dependencies: 212
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE event_id_seq OWNED BY event.id;


--
-- TOC entry 213 (class 1259 OID 210682)
-- Name: file; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE file (
    id integer NOT NULL,
    name text,
    status_text json,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer
);


--
-- TOC entry 214 (class 1259 OID 210689)
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4111 (class 0 OID 0)
-- Dependencies: 214
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE file_id_seq OWNED BY file.id;


--
-- TOC entry 215 (class 1259 OID 210691)
-- Name: goal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE goal (
    id integer NOT NULL,
    name text NOT NULL,
    will_be_delivered text,
    description text NOT NULL,
    technically text NOT NULL,
    expected_start_date timestamp without time zone,
    expected_end_date timestamp without time zone,
    start_date date,
    end_date date,
    percentage text,
    management_id integer,
    user_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone,
    country_id integer,
    original_link text,
    keywords text[],
    expected_budget double precision,
    real_value_expended double precision,
    origin text,
    transversality text,
    objective_id integer,
    goal_number integer,
    qualitative_progress_1 text,
    qualitative_progress_2 text,
    qualitative_progress_3 text,
    qualitative_progress_4 text,
    qualitative_progress_5 text,
    qualitative_progress_6 text
);


--
-- TOC entry 216 (class 1259 OID 210698)
-- Name: goal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4112 (class 0 OID 0)
-- Dependencies: 216
-- Name: goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goal_id_seq OWNED BY goal.id;


--
-- TOC entry 217 (class 1259 OID 210700)
-- Name: goal_organization; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE goal_organization (
    id integer NOT NULL,
    goal_id integer,
    organization_id integer
);


--
-- TOC entry 218 (class 1259 OID 210703)
-- Name: goal_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goal_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4113 (class 0 OID 0)
-- Dependencies: 218
-- Name: goal_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goal_organization_id_seq OWNED BY goal_organization.id;


--
-- TOC entry 219 (class 1259 OID 210705)
-- Name: goal_porcentage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE goal_porcentage (
    id integer NOT NULL,
    goal_id integer,
    owned double precision NOT NULL,
    remainder double precision NOT NULL,
    active boolean DEFAULT true
);


--
-- TOC entry 220 (class 1259 OID 210709)
-- Name: goal_porcentage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goal_porcentage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4114 (class 0 OID 0)
-- Dependencies: 220
-- Name: goal_porcentage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goal_porcentage_id_seq OWNED BY goal_porcentage.id;


--
-- TOC entry 221 (class 1259 OID 210711)
-- Name: goal_project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE goal_project (
    id integer NOT NULL,
    goal_id integer NOT NULL,
    project_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


--
-- TOC entry 222 (class 1259 OID 210715)
-- Name: goal_project_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goal_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4115 (class 0 OID 0)
-- Dependencies: 222
-- Name: goal_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goal_project_id_seq OWNED BY goal_project.id;


--
-- TOC entry 223 (class 1259 OID 210717)
-- Name: goal_secretary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE goal_secretary (
    id integer NOT NULL,
    goal_id integer NOT NULL,
    secretary_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    update_at timestamp without time zone
);


--
-- TOC entry 224 (class 1259 OID 210721)
-- Name: goal_secretary_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goal_secretary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4116 (class 0 OID 0)
-- Dependencies: 224
-- Name: goal_secretary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goal_secretary_id_seq OWNED BY goal_secretary.id;


--
-- TOC entry 225 (class 1259 OID 210723)
-- Name: images_project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE images_project (
    id integer NOT NULL,
    project_id integer,
    name_image text NOT NULL,
    user_id integer,
    description text
);


--
-- TOC entry 226 (class 1259 OID 210729)
-- Name: invite_counsil; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invite_counsil (
    id integer NOT NULL,
    email text NOT NULL,
    hash text NOT NULL,
    organization_id integer,
    valid_until boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 227 (class 1259 OID 210737)
-- Name: invite_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invite_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4117 (class 0 OID 0)
-- Dependencies: 227
-- Name: invite_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invite_counsil_id_seq OWNED BY invite_counsil.id;


--
-- TOC entry 228 (class 1259 OID 210739)
-- Name: management; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE management (
    id integer NOT NULL,
    name text NOT NULL,
    start_date text NOT NULL,
    expected_end_date text NOT NULL,
    city_id integer NOT NULL,
    organization_id integer NOT NULL,
    active boolean,
    created_at text
);


--
-- TOC entry 229 (class 1259 OID 210745)
-- Name: management_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE management_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4118 (class 0 OID 0)
-- Dependencies: 229
-- Name: management_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE management_id_seq OWNED BY management.id;


--
-- TOC entry 230 (class 1259 OID 210747)
-- Name: milestones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE milestones (
    id integer NOT NULL,
    name text NOT NULL,
    project_type_id integer,
    percentage integer,
    sequence integer
);


--
-- TOC entry 231 (class 1259 OID 210753)
-- Name: milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE milestones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4119 (class 0 OID 0)
-- Dependencies: 231
-- Name: milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE milestones_id_seq OWNED BY milestones.id;


--
-- TOC entry 232 (class 1259 OID 210755)
-- Name: objective; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE objective (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


--
-- TOC entry 233 (class 1259 OID 210762)
-- Name: objective_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE objective_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4120 (class 0 OID 0)
-- Dependencies: 233
-- Name: objective_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE objective_id_seq OWNED BY objective.id;


--
-- TOC entry 234 (class 1259 OID 210764)
-- Name: organization; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organization (
    id integer NOT NULL,
    name text NOT NULL,
    address text,
    postal_code text,
    city_id integer,
    description text,
    email text,
    website text,
    phone text,
    subprefecture_id integer,
    organization_type_id integer
);


--
-- TOC entry 235 (class 1259 OID 210770)
-- Name: organization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4121 (class 0 OID 0)
-- Dependencies: 235
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organization_id_seq OWNED BY organization.id;


--
-- TOC entry 236 (class 1259 OID 210772)
-- Name: organization_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organization_type (
    id integer NOT NULL,
    name text,
    type org_type
);


--
-- TOC entry 237 (class 1259 OID 210778)
-- Name: organization_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organization_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4122 (class 0 OID 0)
-- Dependencies: 237
-- Name: organization_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organization_type_id_seq OWNED BY organization_type.id;


--
-- TOC entry 238 (class 1259 OID 210780)
-- Name: password_reset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE password_reset (
    id integer NOT NULL,
    user_id integer,
    hash text NOT NULL,
    expires_at timestamp without time zone DEFAULT (now() + '7 days'::interval),
    valid boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 239 (class 1259 OID 210789)
-- Name: password_reset_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE password_reset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4123 (class 0 OID 0)
-- Dependencies: 239
-- Name: password_reset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE password_reset_id_seq OWNED BY password_reset.id;


--
-- TOC entry 240 (class 1259 OID 210791)
-- Name: pre_register; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pre_register (
    id integer NOT NULL,
    username text NOT NULL,
    useremail text NOT NULL
);


--
-- TOC entry 241 (class 1259 OID 210797)
-- Name: pre_register_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pre_register_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4124 (class 0 OID 0)
-- Dependencies: 241
-- Name: pre_register_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pre_register_id_seq OWNED BY pre_register.id;


--
-- TOC entry 242 (class 1259 OID 210799)
-- Name: prefecture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE prefecture (
    id integer NOT NULL,
    name text NOT NULL,
    acronym text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    latitude text NOT NULL,
    longitude text NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 210806)
-- Name: prefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4125 (class 0 OID 0)
-- Dependencies: 243
-- Name: prefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prefecture_id_seq OWNED BY prefecture.id;


--
-- TOC entry 244 (class 1259 OID 210808)
-- Name: progress_goal_counsil; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE progress_goal_counsil (
    id integer NOT NULL,
    remainder double precision NOT NULL,
    owned double precision NOT NULL,
    goal_id integer,
    created_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 245 (class 1259 OID 210812)
-- Name: progress_goal_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE progress_goal_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4126 (class 0 OID 0)
-- Dependencies: 245
-- Name: progress_goal_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE progress_goal_counsil_id_seq OWNED BY progress_goal_counsil.id;


--
-- TOC entry 246 (class 1259 OID 210814)
-- Name: project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project (
    id integer NOT NULL,
    name text NOT NULL,
    address text,
    latitude text,
    longitude text,
    budget_executed double precision,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    region_id integer,
    project_number integer,
    qualitative_progress_6 text,
    qualitative_progress_5 text,
    qualitative_progress_4 text,
    qualitative_progress_3 text,
    qualitative_progress_2 text,
    qualitative_progress_1 text,
    percentage numeric,
    type integer,
    goal_id integer
);


--
-- TOC entry 247 (class 1259 OID 210821)
-- Name: project_accept_porcentage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_accept_porcentage (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT now(),
    progress project_progress_type
);


--
-- TOC entry 248 (class 1259 OID 210825)
-- Name: project_accept_porcentage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_accept_porcentage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4127 (class 0 OID 0)
-- Dependencies: 248
-- Name: project_accept_porcentage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_accept_porcentage_id_seq OWNED BY project_accept_porcentage.id;


--
-- TOC entry 249 (class 1259 OID 210827)
-- Name: project_event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_event (
    id integer NOT NULL,
    text text,
    ts timestamp without time zone DEFAULT now(),
    project_id integer,
    user_id integer,
    approved boolean DEFAULT false,
    active boolean DEFAULT true,
    is_last boolean DEFAULT true,
    CONSTRAINT project_event_is_last_check CHECK ((is_last <> false))
);


--
-- TOC entry 250 (class 1259 OID 210838)
-- Name: project_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4128 (class 0 OID 0)
-- Dependencies: 250
-- Name: project_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_event_id_seq OWNED BY project_event.id;


--
-- TOC entry 251 (class 1259 OID 210840)
-- Name: project_event_read; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_event_read (
    id integer NOT NULL,
    project_event_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now()
);


--
-- TOC entry 252 (class 1259 OID 210844)
-- Name: project_event_read_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_event_read_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4129 (class 0 OID 0)
-- Dependencies: 252
-- Name: project_event_read_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_event_read_id_seq OWNED BY project_event_read.id;


--
-- TOC entry 253 (class 1259 OID 210846)
-- Name: project_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4130 (class 0 OID 0)
-- Dependencies: 253
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_id_seq OWNED BY project.id;


--
-- TOC entry 254 (class 1259 OID 210848)
-- Name: project_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_image (
    id integer NOT NULL,
    project_id integer,
    md5_image text NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 210854)
-- Name: project_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4131 (class 0 OID 0)
-- Dependencies: 255
-- Name: project_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_image_id_seq OWNED BY project_image.id;


--
-- TOC entry 256 (class 1259 OID 210856)
-- Name: project_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4132 (class 0 OID 0)
-- Dependencies: 256
-- Name: project_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_images_id_seq OWNED BY images_project.id;


--
-- TOC entry 257 (class 1259 OID 210858)
-- Name: project_milestones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_milestones (
    id integer NOT NULL,
    project_id integer,
    milestone integer,
    status integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


--
-- TOC entry 258 (class 1259 OID 210862)
-- Name: project_milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_milestones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4133 (class 0 OID 0)
-- Dependencies: 258
-- Name: project_milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_milestones_id_seq OWNED BY project_milestones.id;


--
-- TOC entry 259 (class 1259 OID 210864)
-- Name: project_prefecture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_prefecture (
    id integer NOT NULL,
    project_id integer NOT NULL,
    prefecture_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


--
-- TOC entry 260 (class 1259 OID 210868)
-- Name: project_prefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_prefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4134 (class 0 OID 0)
-- Dependencies: 260
-- Name: project_prefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_prefecture_id_seq OWNED BY project_prefecture.id;


--
-- TOC entry 261 (class 1259 OID 210870)
-- Name: project_progress; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_progress (
    project_id integer NOT NULL,
    milestone_id integer NOT NULL,
    status integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


--
-- TOC entry 262 (class 1259 OID 210874)
-- Name: project_region; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_region (
    id integer NOT NULL,
    project_id integer,
    region_id integer
);


--
-- TOC entry 263 (class 1259 OID 210877)
-- Name: project_region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4135 (class 0 OID 0)
-- Dependencies: 263
-- Name: project_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_region_id_seq OWNED BY project_region.id;


--
-- TOC entry 264 (class 1259 OID 210879)
-- Name: project_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE project_types (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 265 (class 1259 OID 210885)
-- Name: project_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4136 (class 0 OID 0)
-- Dependencies: 265
-- Name: project_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_types_id_seq OWNED BY project_types.id;


--
-- TOC entry 266 (class 1259 OID 210887)
-- Name: region; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE region (
    id integer NOT NULL,
    geom geometry,
    name text COLLATE pg_catalog."C.UTF-8",
    lat text,
    long text,
    subprefecture_id integer
);


--
-- TOC entry 267 (class 1259 OID 210893)
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4137 (class 0 OID 0)
-- Dependencies: 267
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE region_id_seq OWNED BY region.id;


--
-- TOC entry 268 (class 1259 OID 210895)
-- Name: register_counsil_manual; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE register_counsil_manual (
    id integer NOT NULL,
    email text NOT NULL,
    phone_number text NOT NULL,
    council text NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 269 (class 1259 OID 210902)
-- Name: register_counsil_manual_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE register_counsil_manual_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4138 (class 0 OID 0)
-- Dependencies: 269
-- Name: register_counsil_manual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE register_counsil_manual_id_seq OWNED BY register_counsil_manual.id;


--
-- TOC entry 270 (class 1259 OID 210904)
-- Name: role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE role (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 271 (class 1259 OID 210910)
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4139 (class 0 OID 0)
-- Dependencies: 271
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- TOC entry 272 (class 1259 OID 210912)
-- Name: secretary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE secretary (
    id integer NOT NULL,
    acronym text NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 273 (class 1259 OID 210919)
-- Name: secretary_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE secretary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4140 (class 0 OID 0)
-- Dependencies: 273
-- Name: secretary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE secretary_id_seq OWNED BY secretary.id;


--
-- TOC entry 274 (class 1259 OID 210921)
-- Name: state; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE state (
    id integer NOT NULL,
    name text NOT NULL,
    uf text NOT NULL,
    country_id integer NOT NULL,
    created_by integer
);


--
-- TOC entry 275 (class 1259 OID 210927)
-- Name: state_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE state_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 276 (class 1259 OID 210929)
-- Name: status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE status (
    id integer NOT NULL,
    description text NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 210935)
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4141 (class 0 OID 0)
-- Dependencies: 277
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- TOC entry 278 (class 1259 OID 210937)
-- Name: subprefecture; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE subprefecture (
    id integer NOT NULL,
    acronym text,
    name text NOT NULL,
    latitude text,
    longitude text,
    "timestamp" timestamp without time zone DEFAULT now(),
    site text,
    deputy_mayor text,
    email text,
    telephone text,
    address text
);


--
-- TOC entry 279 (class 1259 OID 210944)
-- Name: subprefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subprefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4142 (class 0 OID 0)
-- Dependencies: 279
-- Name: subprefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE subprefecture_id_seq OWNED BY subprefecture.id;


--
-- TOC entry 280 (class 1259 OID 210946)
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "user" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    password text NOT NULL,
    created_by integer,
    type character varying(12),
    organization_id integer,
    username text,
    phone_number text,
    image_perfil text,
    accept_email boolean,
    accept_sms boolean,
    request_council boolean DEFAULT false,
    mobile_campaign_id integer
);


--
-- TOC entry 281 (class 1259 OID 210955)
-- Name: user_follow_counsil; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_follow_counsil (
    id integer NOT NULL,
    counsil_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now(),
    active boolean DEFAULT true
);


--
-- TOC entry 282 (class 1259 OID 210960)
-- Name: user_follow_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_follow_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4143 (class 0 OID 0)
-- Dependencies: 282
-- Name: user_follow_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_follow_counsil_id_seq OWNED BY user_follow_counsil.id;


--
-- TOC entry 283 (class 1259 OID 210962)
-- Name: user_follow_project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_follow_project (
    id integer NOT NULL,
    project_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now(),
    active boolean DEFAULT true
);


--
-- TOC entry 284 (class 1259 OID 210967)
-- Name: user_follow_project_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_follow_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4144 (class 0 OID 0)
-- Dependencies: 284
-- Name: user_follow_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_follow_project_id_seq OWNED BY user_follow_project.id;


--
-- TOC entry 285 (class 1259 OID 210969)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4145 (class 0 OID 0)
-- Dependencies: 285
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- TOC entry 286 (class 1259 OID 210971)
-- Name: user_request_council; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_request_council (
    id integer NOT NULL,
    user_id integer NOT NULL,
    organization_id integer NOT NULL,
    user_status user_request_type NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 287 (class 1259 OID 210975)
-- Name: user_request_council_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_request_council_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4146 (class 0 OID 0)
-- Dependencies: 287
-- Name: user_request_council_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_request_council_id_seq OWNED BY user_request_council.id;


--
-- TOC entry 288 (class 1259 OID 210977)
-- Name: user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_role (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


--
-- TOC entry 289 (class 1259 OID 210980)
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4147 (class 0 OID 0)
-- Dependencies: 289
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_role_id_seq OWNED BY user_role.id;


--
-- TOC entry 290 (class 1259 OID 210982)
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_session (
    id integer NOT NULL,
    user_id integer NOT NULL,
    api_key text,
    valid_for_ip text,
    valid_until timestamp without time zone DEFAULT (now() + '1 day'::interval) NOT NULL,
    ts_created timestamp without time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 291 (class 1259 OID 210990)
-- Name: user_session_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4148 (class 0 OID 0)
-- Dependencies: 291
-- Name: user_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_session_id_seq OWNED BY user_session.id;


--
-- TOC entry 3579 (class 2604 OID 211041)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget ALTER COLUMN id SET DEFAULT nextval('budget_id_seq'::regclass);


--
-- TOC entry 3582 (class 2604 OID 211042)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaign ALTER COLUMN id SET DEFAULT nextval('campaign_id_seq'::regclass);


--
-- TOC entry 3586 (class 2604 OID 211043)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_goal ALTER COLUMN id SET DEFAULT nextval('comment_goal_id_seq'::regclass);


--
-- TOC entry 3590 (class 2604 OID 211044)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_project ALTER COLUMN id SET DEFAULT nextval('comment_id_seq'::regclass);


--
-- TOC entry 3591 (class 2604 OID 211045)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY company ALTER COLUMN id SET DEFAULT nextval('company_id_seq'::regclass);


--
-- TOC entry 3592 (class 2604 OID 211046)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY company_documents ALTER COLUMN id SET DEFAULT nextval('company_documents_id_seq'::regclass);


--
-- TOC entry 3594 (class 2604 OID 211047)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contact ALTER COLUMN id SET DEFAULT nextval('contact_id_seq'::regclass);


--
-- TOC entry 3595 (class 2604 OID 211048)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY district ALTER COLUMN id SET DEFAULT nextval('district_id_seq'::regclass);


--
-- TOC entry 3598 (class 2604 OID 211049)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY email_queue ALTER COLUMN id SET DEFAULT nextval('email_queue_id_seq'::regclass);


--
-- TOC entry 3600 (class 2604 OID 211050)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY event ALTER COLUMN id SET DEFAULT nextval('event_id_seq'::regclass);


--
-- TOC entry 3602 (class 2604 OID 211051)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY file ALTER COLUMN id SET DEFAULT nextval('file_id_seq'::regclass);


--
-- TOC entry 3604 (class 2604 OID 211052)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal ALTER COLUMN id SET DEFAULT nextval('goal_id_seq'::regclass);


--
-- TOC entry 3605 (class 2604 OID 211053)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_organization ALTER COLUMN id SET DEFAULT nextval('goal_organization_id_seq'::regclass);


--
-- TOC entry 3607 (class 2604 OID 211054)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_porcentage ALTER COLUMN id SET DEFAULT nextval('goal_porcentage_id_seq'::regclass);


--
-- TOC entry 3609 (class 2604 OID 211055)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_project ALTER COLUMN id SET DEFAULT nextval('goal_project_id_seq'::regclass);


--
-- TOC entry 3611 (class 2604 OID 211056)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_secretary ALTER COLUMN id SET DEFAULT nextval('goal_secretary_id_seq'::regclass);


--
-- TOC entry 3612 (class 2604 OID 211057)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY images_project ALTER COLUMN id SET DEFAULT nextval('project_images_id_seq'::regclass);


--
-- TOC entry 3615 (class 2604 OID 211058)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY invite_counsil ALTER COLUMN id SET DEFAULT nextval('invite_counsil_id_seq'::regclass);


--
-- TOC entry 3616 (class 2604 OID 211059)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY management ALTER COLUMN id SET DEFAULT nextval('management_id_seq'::regclass);


--
-- TOC entry 3617 (class 2604 OID 211060)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY milestones ALTER COLUMN id SET DEFAULT nextval('milestones_id_seq'::regclass);


--
-- TOC entry 3619 (class 2604 OID 211061)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY objective ALTER COLUMN id SET DEFAULT nextval('objective_id_seq'::regclass);


--
-- TOC entry 3620 (class 2604 OID 211062)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization ALTER COLUMN id SET DEFAULT nextval('organization_id_seq'::regclass);


--
-- TOC entry 3621 (class 2604 OID 211063)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_type ALTER COLUMN id SET DEFAULT nextval('organization_type_id_seq'::regclass);


--
-- TOC entry 3625 (class 2604 OID 211064)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY password_reset ALTER COLUMN id SET DEFAULT nextval('password_reset_id_seq'::regclass);


--
-- TOC entry 3626 (class 2604 OID 211065)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pre_register ALTER COLUMN id SET DEFAULT nextval('pre_register_id_seq'::regclass);


--
-- TOC entry 3628 (class 2604 OID 211066)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY prefecture ALTER COLUMN id SET DEFAULT nextval('prefecture_id_seq'::regclass);


--
-- TOC entry 3630 (class 2604 OID 211067)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY progress_goal_counsil ALTER COLUMN id SET DEFAULT nextval('progress_goal_counsil_id_seq'::regclass);


--
-- TOC entry 3632 (class 2604 OID 211068)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project ALTER COLUMN id SET DEFAULT nextval('project_id_seq'::regclass);


--
-- TOC entry 3634 (class 2604 OID 211069)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_accept_porcentage ALTER COLUMN id SET DEFAULT nextval('project_accept_porcentage_id_seq'::regclass);


--
-- TOC entry 3639 (class 2604 OID 211070)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event ALTER COLUMN id SET DEFAULT nextval('project_event_id_seq'::regclass);


--
-- TOC entry 3642 (class 2604 OID 211071)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event_read ALTER COLUMN id SET DEFAULT nextval('project_event_read_id_seq'::regclass);


--
-- TOC entry 3643 (class 2604 OID 211072)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_image ALTER COLUMN id SET DEFAULT nextval('project_image_id_seq'::regclass);


--
-- TOC entry 3645 (class 2604 OID 211073)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_milestones ALTER COLUMN id SET DEFAULT nextval('project_milestones_id_seq'::regclass);


--
-- TOC entry 3647 (class 2604 OID 211074)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_prefecture ALTER COLUMN id SET DEFAULT nextval('project_prefecture_id_seq'::regclass);


--
-- TOC entry 3649 (class 2604 OID 211075)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_region ALTER COLUMN id SET DEFAULT nextval('project_region_id_seq'::regclass);


--
-- TOC entry 3650 (class 2604 OID 211076)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_types ALTER COLUMN id SET DEFAULT nextval('project_types_id_seq'::regclass);


--
-- TOC entry 3651 (class 2604 OID 211077)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY region ALTER COLUMN id SET DEFAULT nextval('region_id_seq'::regclass);


--
-- TOC entry 3653 (class 2604 OID 211078)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY register_counsil_manual ALTER COLUMN id SET DEFAULT nextval('register_counsil_manual_id_seq'::regclass);


--
-- TOC entry 3654 (class 2604 OID 211079)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- TOC entry 3656 (class 2604 OID 211080)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY secretary ALTER COLUMN id SET DEFAULT nextval('secretary_id_seq'::regclass);


--
-- TOC entry 3657 (class 2604 OID 211081)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- TOC entry 3659 (class 2604 OID 211082)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY subprefecture ALTER COLUMN id SET DEFAULT nextval('subprefecture_id_seq'::regclass);


--
-- TOC entry 3663 (class 2604 OID 211083)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- TOC entry 3666 (class 2604 OID 211084)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_follow_counsil ALTER COLUMN id SET DEFAULT nextval('user_follow_counsil_id_seq'::regclass);


--
-- TOC entry 3669 (class 2604 OID 211085)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_follow_project ALTER COLUMN id SET DEFAULT nextval('user_follow_project_id_seq'::regclass);


--
-- TOC entry 3671 (class 2604 OID 211086)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_request_council ALTER COLUMN id SET DEFAULT nextval('user_request_council_id_seq'::regclass);


--
-- TOC entry 3672 (class 2604 OID 211087)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role ALTER COLUMN id SET DEFAULT nextval('user_role_id_seq'::regclass);


--
-- TOC entry 3675 (class 2604 OID 211088)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session ALTER COLUMN id SET DEFAULT nextval('user_session_id_seq'::regclass);


--
-- TOC entry 3990 (class 0 OID 210573)
-- Dependencies: 189
-- Data for Name: budget; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4149 (class 0 OID 0)
-- Dependencies: 190
-- Name: budget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('budget_id_seq', 56492, true);


--
-- TOC entry 3992 (class 0 OID 210582)
-- Dependencies: 191
-- Data for Name: campaign; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4150 (class 0 OID 0)
-- Dependencies: 192
-- Name: campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campaign_id_seq', 13, true);


--
-- TOC entry 3994 (class 0 OID 210592)
-- Dependencies: 193
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO city VALUES (1, 'São Paulo', 'sao-paulo', 25, 1);


--
-- TOC entry 4151 (class 0 OID 0)
-- Dependencies: 194
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('city_id_seq', 2, true);


--
-- TOC entry 3996 (class 0 OID 210600)
-- Dependencies: 195
-- Data for Name: comment_goal; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 196
-- Name: comment_goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('comment_goal_id_seq', 6, true);


--
-- TOC entry 4153 (class 0 OID 0)
-- Dependencies: 198
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('comment_id_seq', 26, true);


--
-- TOC entry 3998 (class 0 OID 210611)
-- Dependencies: 197
-- Data for Name: comment_project; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4000 (class 0 OID 210622)
-- Dependencies: 199
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4001 (class 0 OID 210628)
-- Dependencies: 200
-- Data for Name: company_documents; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 201
-- Name: company_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('company_documents_id_seq', 6686, true);


--
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 202
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('company_id_seq', 11122, true);


--
-- TOC entry 4004 (class 0 OID 210638)
-- Dependencies: 203
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 204
-- Name: contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('contact_id_seq', 265, true);


--
-- TOC entry 4006 (class 0 OID 210647)
-- Dependencies: 205
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO country VALUES (1, 'Brasil');


--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 206
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('country_id_seq', 2, true);


--
-- TOC entry 4008 (class 0 OID 210655)
-- Dependencies: 207
-- Data for Name: district; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 208
-- Name: district_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('district_id_seq', 1, false);


--
-- TOC entry 4010 (class 0 OID 210663)
-- Dependencies: 209
-- Data for Name: email_queue; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 210
-- Name: email_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('email_queue_id_seq', 63, true);


--
-- TOC entry 4012 (class 0 OID 210673)
-- Dependencies: 211
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 212
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('event_id_seq', 3, true);


--
-- TOC entry 4014 (class 0 OID 210682)
-- Dependencies: 213
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 214
-- Name: file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('file_id_seq', 1, false);


--
-- TOC entry 4016 (class 0 OID 210691)
-- Dependencies: 215
-- Data for Name: goal; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 216
-- Name: goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('goal_id_seq', 123, true);


--
-- TOC entry 4018 (class 0 OID 210700)
-- Dependencies: 217
-- Data for Name: goal_organization; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 218
-- Name: goal_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('goal_organization_id_seq', 1, false);


--
-- TOC entry 4020 (class 0 OID 210705)
-- Dependencies: 219
-- Data for Name: goal_porcentage; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 220
-- Name: goal_porcentage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('goal_porcentage_id_seq', 124, true);


--
-- TOC entry 4022 (class 0 OID 210711)
-- Dependencies: 221
-- Data for Name: goal_project; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 222
-- Name: goal_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('goal_project_id_seq', 14701, true);


--
-- TOC entry 4024 (class 0 OID 210717)
-- Dependencies: 223
-- Data for Name: goal_secretary; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 224
-- Name: goal_secretary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('goal_secretary_id_seq', 15524, true);


--
-- TOC entry 4026 (class 0 OID 210723)
-- Dependencies: 225
-- Data for Name: images_project; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4027 (class 0 OID 210729)
-- Dependencies: 226
-- Data for Name: invite_counsil; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 227
-- Name: invite_counsil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('invite_counsil_id_seq', 29, true);


--
-- TOC entry 4029 (class 0 OID 210739)
-- Dependencies: 228
-- Data for Name: management; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 229
-- Name: management_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('management_id_seq', 3, true);


--
-- TOC entry 4031 (class 0 OID 210747)
-- Dependencies: 230
-- Data for Name: milestones; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 231
-- Name: milestones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('milestones_id_seq', 39, true);


--
-- TOC entry 4033 (class 0 OID 210755)
-- Dependencies: 232
-- Data for Name: objective; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 233
-- Name: objective_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('objective_id_seq', 20, true);


--
-- TOC entry 4035 (class 0 OID 210764)
-- Dependencies: 234
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 235
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('organization_id_seq', 35, true);


--
-- TOC entry 4037 (class 0 OID 210772)
-- Dependencies: 236
-- Data for Name: organization_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO organization_type VALUES (2, 'Conselho Participativo', 'counsil');
INSERT INTO organization_type VALUES (3, 'Conselho de Política Pública', 'counsil');
INSERT INTO organization_type VALUES (1, 'Organização da Sociedade Civil', 'organization');


--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 237
-- Name: organization_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('organization_type_id_seq', 3, true);


--
-- TOC entry 4039 (class 0 OID 210780)
-- Dependencies: 238
-- Data for Name: password_reset; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 239
-- Name: password_reset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('password_reset_id_seq', 21, true);


--
-- TOC entry 4041 (class 0 OID 210791)
-- Dependencies: 240
-- Data for Name: pre_register; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 241
-- Name: pre_register_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('pre_register_id_seq', 9, true);


--
-- TOC entry 4043 (class 0 OID 210799)
-- Dependencies: 242
-- Data for Name: prefecture; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 243
-- Name: prefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('prefecture_id_seq', 338, true);


--
-- TOC entry 4045 (class 0 OID 210808)
-- Dependencies: 244
-- Data for Name: progress_goal_counsil; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 245
-- Name: progress_goal_counsil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('progress_goal_counsil_id_seq', 7, true);


--
-- TOC entry 4047 (class 0 OID 210814)
-- Dependencies: 246
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4048 (class 0 OID 210821)
-- Dependencies: 247
-- Data for Name: project_accept_porcentage; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 248
-- Name: project_accept_porcentage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_accept_porcentage_id_seq', 6, true);


--
-- TOC entry 4050 (class 0 OID 210827)
-- Dependencies: 249
-- Data for Name: project_event; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 250
-- Name: project_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_event_id_seq', 41, true);


--
-- TOC entry 4052 (class 0 OID 210840)
-- Dependencies: 251
-- Data for Name: project_event_read; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 252
-- Name: project_event_read_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_event_read_id_seq', 22, true);


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 253
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_id_seq', 4966, true);


--
-- TOC entry 4055 (class 0 OID 210848)
-- Dependencies: 254
-- Data for Name: project_image; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 255
-- Name: project_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_image_id_seq', 1, false);


--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 256
-- Name: project_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_images_id_seq', 40, true);


--
-- TOC entry 4058 (class 0 OID 210858)
-- Dependencies: 257
-- Data for Name: project_milestones; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 258
-- Name: project_milestones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_milestones_id_seq', 23114, true);


--
-- TOC entry 4060 (class 0 OID 210864)
-- Dependencies: 259
-- Data for Name: project_prefecture; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 260
-- Name: project_prefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_prefecture_id_seq', 317669, true);


--
-- TOC entry 4062 (class 0 OID 210870)
-- Dependencies: 261
-- Data for Name: project_progress; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4063 (class 0 OID 210874)
-- Dependencies: 262
-- Data for Name: project_region; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 263
-- Name: project_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_region_id_seq', 1, false);


--
-- TOC entry 4065 (class 0 OID 210879)
-- Dependencies: 264
-- Data for Name: project_types; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO project_types VALUES (1, 'Construção de equipamento');
INSERT INTO project_types VALUES (2, 'Obras de infraestrutura');
INSERT INTO project_types VALUES (3, 'Novos equipamentos em imóvel alugado');
INSERT INTO project_types VALUES (4, 'Equipamentos readequados');
INSERT INTO project_types VALUES (5, 'Novos órgãos ou estruturas administrativas');
INSERT INTO project_types VALUES (6, 'Sistemas');
INSERT INTO project_types VALUES (7, 'Atos Normativos');
INSERT INTO project_types VALUES (8, 'Novos serviços ou benefícios');


--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 265
-- Name: project_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('project_types_id_seq', 8, true);


--
-- TOC entry 4067 (class 0 OID 210887)
-- Dependencies: 266
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 267
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('region_id_seq', 674, true);


--
-- TOC entry 4069 (class 0 OID 210895)
-- Dependencies: 268
-- Data for Name: register_counsil_manual; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 269
-- Name: register_counsil_manual_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('register_counsil_manual_id_seq', 18, true);


--
-- TOC entry 4071 (class 0 OID 210904)
-- Dependencies: 270
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO role VALUES (0, 'superadmin');
INSERT INTO role VALUES (1, 'admin');
INSERT INTO role VALUES (2, 'organization');
INSERT INTO role VALUES (3, 'user');
INSERT INTO role VALUES (4, 'webapi');
INSERT INTO role VALUES (6, 'management');
INSERT INTO role VALUES (11, 'counsil');
INSERT INTO role VALUES (12, 'counsil_master');


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 271
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('role_id_seq', 12, true);


--
-- TOC entry 4073 (class 0 OID 210912)
-- Dependencies: 272
-- Data for Name: secretary; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 273
-- Name: secretary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('secretary_id_seq', 24, true);


--
-- TOC entry 3577 (class 0 OID 209476)
-- Dependencies: 175
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4075 (class 0 OID 210921)
-- Dependencies: 274
-- Data for Name: state; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO state VALUES (1, 'Acre', 'AC', 1, 1);
INSERT INTO state VALUES (2, 'Alagoas', 'AL', 1, 1);
INSERT INTO state VALUES (3, 'Amapá', 'AP', 1, 1);
INSERT INTO state VALUES (4, 'Amazonas', 'AM', 1, 1);
INSERT INTO state VALUES (5, 'Bahia', 'BA', 1, 1);
INSERT INTO state VALUES (6, 'Ceará', 'CE', 1, 1);
INSERT INTO state VALUES (7, 'Distrito Federal', 'DF', 1, 1);
INSERT INTO state VALUES (8, 'Espírito Santo', 'ES', 1, 1);
INSERT INTO state VALUES (9, 'Goiás', 'GO', 1, 1);
INSERT INTO state VALUES (10, 'Maranhão', 'MA', 1, 1);
INSERT INTO state VALUES (11, 'Mato Grosso', 'MT', 1, 1);
INSERT INTO state VALUES (12, 'Mato Grosso do Sul', 'MS', 1, 1);
INSERT INTO state VALUES (13, 'Minas Gerais', 'MG', 1, 1);
INSERT INTO state VALUES (14, 'Pará', 'PA', 1, 1);
INSERT INTO state VALUES (15, 'Paraíba', 'PB', 1, 1);
INSERT INTO state VALUES (16, 'Paraná', 'PR', 1, 1);
INSERT INTO state VALUES (17, 'Pernambuco', 'PE', 1, 1);
INSERT INTO state VALUES (18, 'Piauí', 'PI', 1, 1);
INSERT INTO state VALUES (19, 'Rio de Janeiro', 'RJ', 1, 1);
INSERT INTO state VALUES (20, 'Rio Grande do Norte', 'RN', 1, 1);
INSERT INTO state VALUES (21, 'Rio Grande do Sul', 'RS', 1, 1);
INSERT INTO state VALUES (22, 'Rondônia', 'RO', 1, 1);
INSERT INTO state VALUES (23, 'Roraima', 'RR', 1, 1);
INSERT INTO state VALUES (24, 'Santa Catarina', 'SC', 1, 1);
INSERT INTO state VALUES (25, 'São Paulo', 'SP', 1, 1);
INSERT INTO state VALUES (26, 'Sergipe', 'SE', 1, 1);
INSERT INTO state VALUES (27, 'Tocantins', 'TO', 1, 1);


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 275
-- Name: state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('state_id_seq', 2, false);


--
-- TOC entry 4077 (class 0 OID 210929)
-- Dependencies: 276
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 277
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('status_id_seq', 1, false);


--
-- TOC entry 4079 (class 0 OID 210937)
-- Dependencies: 278
-- Data for Name: subprefecture; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 279
-- Name: subprefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('subprefecture_id_seq', 35, true);


--
-- TOC entry 4081 (class 0 OID 210946)
-- Dependencies: 280
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4082 (class 0 OID 210955)
-- Dependencies: 281
-- Data for Name: user_follow_counsil; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 282
-- Name: user_follow_counsil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_follow_counsil_id_seq', 68, true);


--
-- TOC entry 4084 (class 0 OID 210962)
-- Dependencies: 283
-- Data for Name: user_follow_project; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 284
-- Name: user_follow_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_follow_project_id_seq', 303, true);


--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 285
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_id_seq', 421, true);


--
-- TOC entry 4087 (class 0 OID 210971)
-- Dependencies: 286
-- Data for Name: user_request_council; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 287
-- Name: user_request_council_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_request_council_id_seq', 12, true);


--
-- TOC entry 4089 (class 0 OID 210977)
-- Dependencies: 288
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 289
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_role_id_seq', 467, true);


--
-- TOC entry 4091 (class 0 OID 210982)
-- Dependencies: 290
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 291
-- Name: user_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_session_id_seq', 850, true);


--
-- TOC entry 3678 (class 2606 OID 211238)
-- Name: budget_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_pkey PRIMARY KEY (id);


--
-- TOC entry 3680 (class 2606 OID 211240)
-- Name: campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_pkey PRIMARY KEY (id);


--
-- TOC entry 3682 (class 2606 OID 211242)
-- Name: city_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- TOC entry 3686 (class 2606 OID 211244)
-- Name: comment_goal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_pkey PRIMARY KEY (id);


--
-- TOC entry 3689 (class 2606 OID 211246)
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3695 (class 2606 OID 211248)
-- Name: company_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY company_documents
    ADD CONSTRAINT company_documents_pkey PRIMARY KEY (id);


--
-- TOC entry 3691 (class 2606 OID 211250)
-- Name: company_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- TOC entry 3697 (class 2606 OID 211252)
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 3699 (class 2606 OID 211254)
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- TOC entry 3701 (class 2606 OID 211256)
-- Name: district_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY district
    ADD CONSTRAINT district_pkey PRIMARY KEY (id);


--
-- TOC entry 3703 (class 2606 OID 211258)
-- Name: email_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY email_queue
    ADD CONSTRAINT email_queue_pkey PRIMARY KEY (id);


--
-- TOC entry 3705 (class 2606 OID 211260)
-- Name: event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- TOC entry 3707 (class 2606 OID 211262)
-- Name: file_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- TOC entry 3713 (class 2606 OID 211264)
-- Name: goal_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_pkey PRIMARY KEY (id);


--
-- TOC entry 3709 (class 2606 OID 211266)
-- Name: goal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_pkey PRIMARY KEY (id);


--
-- TOC entry 3715 (class 2606 OID 211268)
-- Name: goal_porcentage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_porcentage
    ADD CONSTRAINT goal_porcentage_pkey PRIMARY KEY (id);


--
-- TOC entry 3718 (class 2606 OID 211270)
-- Name: goal_project_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_pkey PRIMARY KEY (id);


--
-- TOC entry 3721 (class 2606 OID 211272)
-- Name: goal_secretary_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_pkey PRIMARY KEY (id);


--
-- TOC entry 3725 (class 2606 OID 211274)
-- Name: invite_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invite_counsil
    ADD CONSTRAINT invite_counsil_pkey PRIMARY KEY (id);


--
-- TOC entry 3728 (class 2606 OID 211276)
-- Name: management_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY management
    ADD CONSTRAINT management_pkey PRIMARY KEY (id);


--
-- TOC entry 3730 (class 2606 OID 211278)
-- Name: milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id);


--
-- TOC entry 3693 (class 2606 OID 211280)
-- Name: name_idx; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY company
    ADD CONSTRAINT name_idx UNIQUE (name);


--
-- TOC entry 3732 (class 2606 OID 211282)
-- Name: objective_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY objective
    ADD CONSTRAINT objective_pkey PRIMARY KEY (id);


--
-- TOC entry 3735 (class 2606 OID 211284)
-- Name: organization_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- TOC entry 3737 (class 2606 OID 211286)
-- Name: organization_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_type
    ADD CONSTRAINT organization_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3739 (class 2606 OID 211288)
-- Name: password_reset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY password_reset
    ADD CONSTRAINT password_reset_pkey PRIMARY KEY (id);


--
-- TOC entry 3741 (class 2606 OID 211290)
-- Name: pre_register_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pre_register
    ADD CONSTRAINT pre_register_pkey PRIMARY KEY (id);


--
-- TOC entry 3743 (class 2606 OID 211292)
-- Name: prefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prefecture
    ADD CONSTRAINT prefecture_pkey PRIMARY KEY (id);


--
-- TOC entry 3745 (class 2606 OID 211294)
-- Name: progress_goal_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY progress_goal_counsil
    ADD CONSTRAINT progress_goal_counsil_pkey PRIMARY KEY (id);


--
-- TOC entry 3749 (class 2606 OID 211296)
-- Name: project_event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_pkey PRIMARY KEY (id);


--
-- TOC entry 3751 (class 2606 OID 211298)
-- Name: project_event_project_id_is_last_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_project_id_is_last_key UNIQUE (project_id, is_last);


--
-- TOC entry 3753 (class 2606 OID 211300)
-- Name: project_event_read_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_pkey PRIMARY KEY (id);


--
-- TOC entry 3755 (class 2606 OID 211302)
-- Name: project_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_image
    ADD CONSTRAINT project_image_pkey PRIMARY KEY (id);


--
-- TOC entry 3723 (class 2606 OID 211304)
-- Name: project_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT project_images_pkey PRIMARY KEY (id);


--
-- TOC entry 3757 (class 2606 OID 211306)
-- Name: project_milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_pkey PRIMARY KEY (id);


--
-- TOC entry 3747 (class 2606 OID 211308)
-- Name: project_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- TOC entry 3759 (class 2606 OID 211310)
-- Name: project_prefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_pkey PRIMARY KEY (id);


--
-- TOC entry 3761 (class 2606 OID 211312)
-- Name: project_region_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_pkey PRIMARY KEY (id);


--
-- TOC entry 3763 (class 2606 OID 211314)
-- Name: project_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_types
    ADD CONSTRAINT project_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3765 (class 2606 OID 211316)
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- TOC entry 3767 (class 2606 OID 211318)
-- Name: register_counsil_manual_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY register_counsil_manual
    ADD CONSTRAINT register_counsil_manual_pkey PRIMARY KEY (id);


--
-- TOC entry 3769 (class 2606 OID 211320)
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- TOC entry 3771 (class 2606 OID 211322)
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 3773 (class 2606 OID 211324)
-- Name: secretary_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY secretary
    ADD CONSTRAINT secretary_pkey PRIMARY KEY (id);


--
-- TOC entry 3775 (class 2606 OID 211326)
-- Name: state_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id);


--
-- TOC entry 3777 (class 2606 OID 211328)
-- Name: status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- TOC entry 3779 (class 2606 OID 211330)
-- Name: subprefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subprefecture
    ADD CONSTRAINT subprefecture_pkey PRIMARY KEY (id);


--
-- TOC entry 3782 (class 2606 OID 211332)
-- Name: user_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 3788 (class 2606 OID 211334)
-- Name: user_follow_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_pkey PRIMARY KEY (id);


--
-- TOC entry 3790 (class 2606 OID 211336)
-- Name: user_follow_project_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_pkey PRIMARY KEY (id);


--
-- TOC entry 3784 (class 2606 OID 211338)
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3792 (class 2606 OID 211340)
-- Name: user_request_council_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_pkey PRIMARY KEY (id);


--
-- TOC entry 3796 (class 2606 OID 211342)
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 3798 (class 2606 OID 211344)
-- Name: user_session_api_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_api_key_key UNIQUE (api_key);


--
-- TOC entry 3801 (class 2606 OID 211346)
-- Name: user_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- TOC entry 3786 (class 2606 OID 211348)
-- Name: user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- TOC entry 3676 (class 1259 OID 211367)
-- Name: budget_goal_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX budget_goal_idx ON budget USING btree (goal_number);


--
-- TOC entry 3687 (class 1259 OID 211368)
-- Name: comment_approved_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX comment_approved_idx ON comment_project USING btree (approved);


--
-- TOC entry 3733 (class 1259 OID 211369)
-- Name: fki_city_id_fkey; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_city_id_fkey ON organization USING btree (city_id);


--
-- TOC entry 3683 (class 1259 OID 211370)
-- Name: fki_country_id_fkey; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_country_id_fkey ON city USING btree (country_id);


--
-- TOC entry 3726 (class 1259 OID 211371)
-- Name: fki_organization_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_organization_id_fk ON management USING btree (organization_id);


--
-- TOC entry 3780 (class 1259 OID 211372)
-- Name: fki_organization_id_fk_id_organization; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_organization_id_fk_id_organization ON "user" USING btree (organization_id);


--
-- TOC entry 3684 (class 1259 OID 211373)
-- Name: fki_state_id_fkey; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_state_id_fkey ON city USING btree (state_id);


--
-- TOC entry 3710 (class 1259 OID 211374)
-- Name: goal_organization_goal_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX goal_organization_goal_id_idx ON goal_organization USING btree (goal_id);


--
-- TOC entry 3711 (class 1259 OID 211375)
-- Name: goal_organization_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX goal_organization_organization_id_idx ON goal_organization USING btree (organization_id);


--
-- TOC entry 3716 (class 1259 OID 211376)
-- Name: goal_project_goal_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX goal_project_goal_id_idx ON goal_project USING btree (goal_id);


--
-- TOC entry 3719 (class 1259 OID 211377)
-- Name: goal_project_project_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX goal_project_project_id_idx ON goal_project USING btree (project_id);


--
-- TOC entry 3793 (class 1259 OID 211378)
-- Name: user_role_idx_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_role_idx_role_id ON user_role USING btree (role_id);


--
-- TOC entry 3794 (class 1259 OID 211379)
-- Name: user_role_idx_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_role_idx_user_id ON user_role USING btree (user_id);


--
-- TOC entry 3799 (class 1259 OID 211380)
-- Name: user_session_idx_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_session_idx_user_id ON user_session USING btree (user_id);


--
-- TOC entry 3802 (class 2606 OID 211381)
-- Name: budget_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_company_id_fkey FOREIGN KEY (company_id) REFERENCES company(id);


--
-- TOC entry 3803 (class 2606 OID 211386)
-- Name: budget_goal_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_goal_number_fkey FOREIGN KEY (goal_number) REFERENCES goal(id);


--
-- TOC entry 3804 (class 2606 OID 211391)
-- Name: campaign_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3805 (class 2606 OID 211396)
-- Name: campaign_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3806 (class 2606 OID 211401)
-- Name: campaign_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- TOC entry 3807 (class 2606 OID 211406)
-- Name: campaign_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3839 (class 2606 OID 211411)
-- Name: city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


--
-- TOC entry 3810 (class 2606 OID 211416)
-- Name: comment_goal_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3811 (class 2606 OID 211421)
-- Name: comment_goal_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3812 (class 2606 OID 211426)
-- Name: comment_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_org_id_fkey FOREIGN KEY (org_id) REFERENCES organization(id);


--
-- TOC entry 3813 (class 2606 OID 211431)
-- Name: comment_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3814 (class 2606 OID 211436)
-- Name: comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3815 (class 2606 OID 211441)
-- Name: company_documents_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY company_documents
    ADD CONSTRAINT company_documents_company_id_fkey FOREIGN KEY (company_id) REFERENCES company(id);


--
-- TOC entry 3808 (class 2606 OID 211446)
-- Name: country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY city
    ADD CONSTRAINT country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- TOC entry 3816 (class 2606 OID 211451)
-- Name: district_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY district
    ADD CONSTRAINT district_city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


--
-- TOC entry 3817 (class 2606 OID 211456)
-- Name: email_queue_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY email_queue
    ADD CONSTRAINT email_queue_recipient_id_fkey FOREIGN KEY (recipient_id) REFERENCES "user"(id) ON DELETE CASCADE;


--
-- TOC entry 3818 (class 2606 OID 211461)
-- Name: event_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES campaign(id);


--
-- TOC entry 3819 (class 2606 OID 211466)
-- Name: event_council_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_council_id_fkey FOREIGN KEY (council_id) REFERENCES organization(id);


--
-- TOC entry 3820 (class 2606 OID 211471)
-- Name: event_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3821 (class 2606 OID 211476)
-- Name: file_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file_created_by_fkey FOREIGN KEY (created_by) REFERENCES "user"(id);


--
-- TOC entry 3822 (class 2606 OID 211481)
-- Name: goal_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- TOC entry 3823 (class 2606 OID 211486)
-- Name: goal_management_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_management_id_fkey FOREIGN KEY (management_id) REFERENCES management(id);


--
-- TOC entry 3824 (class 2606 OID 211491)
-- Name: goal_objective_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_objective_id FOREIGN KEY (objective_id) REFERENCES objective(id);


--
-- TOC entry 3826 (class 2606 OID 211496)
-- Name: goal_organization_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3827 (class 2606 OID 211501)
-- Name: goal_organization_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3828 (class 2606 OID 211506)
-- Name: goal_porcentage_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_porcentage
    ADD CONSTRAINT goal_porcentage_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3829 (class 2606 OID 211511)
-- Name: goal_project_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3830 (class 2606 OID 211516)
-- Name: goal_project_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3831 (class 2606 OID 211521)
-- Name: goal_secretary_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3832 (class 2606 OID 211526)
-- Name: goal_secretary_secretary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_secretary_id_fkey FOREIGN KEY (secretary_id) REFERENCES secretary(id);


--
-- TOC entry 3825 (class 2606 OID 211531)
-- Name: goal_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3833 (class 2606 OID 211536)
-- Name: images_project_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT images_project_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3835 (class 2606 OID 211541)
-- Name: invite_counsil_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invite_counsil
    ADD CONSTRAINT invite_counsil_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3836 (class 2606 OID 211546)
-- Name: management_fk_city_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY management
    ADD CONSTRAINT management_fk_city_id FOREIGN KEY (city_id) REFERENCES city(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 3838 (class 2606 OID 211551)
-- Name: milestones_project_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY milestones
    ADD CONSTRAINT milestones_project_type_id_fkey FOREIGN KEY (project_type_id) REFERENCES project_types(id);


--
-- TOC entry 3837 (class 2606 OID 211556)
-- Name: organization_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY management
    ADD CONSTRAINT organization_id_fk FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3863 (class 2606 OID 211561)
-- Name: organization_id_fk_id_organization; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT organization_id_fk_id_organization FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3840 (class 2606 OID 211566)
-- Name: organization_organization_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_organization_type_id_fkey FOREIGN KEY (organization_type_id) REFERENCES organization_type(id);


--
-- TOC entry 3841 (class 2606 OID 211571)
-- Name: organization_subprefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_subprefecture_id_fkey FOREIGN KEY (subprefecture_id) REFERENCES subprefecture(id);


--
-- TOC entry 3842 (class 2606 OID 211576)
-- Name: password_reset_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY password_reset
    ADD CONSTRAINT password_reset_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3843 (class 2606 OID 211581)
-- Name: progress_goal_counsil_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY progress_goal_counsil
    ADD CONSTRAINT progress_goal_counsil_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3847 (class 2606 OID 211586)
-- Name: project_accept_porcentage_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_accept_porcentage
    ADD CONSTRAINT project_accept_porcentage_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3848 (class 2606 OID 211591)
-- Name: project_accept_porcentage_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_accept_porcentage
    ADD CONSTRAINT project_accept_porcentage_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3849 (class 2606 OID 211596)
-- Name: project_event_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3851 (class 2606 OID 211601)
-- Name: project_event_read_project_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_project_event_id_fkey FOREIGN KEY (project_event_id) REFERENCES project_event(id);


--
-- TOC entry 3852 (class 2606 OID 211606)
-- Name: project_event_read_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3850 (class 2606 OID 211611)
-- Name: project_event_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3844 (class 2606 OID 211616)
-- Name: project_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- TOC entry 3853 (class 2606 OID 211621)
-- Name: project_image_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_image
    ADD CONSTRAINT project_image_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3834 (class 2606 OID 211626)
-- Name: project_images_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT project_images_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3854 (class 2606 OID 211631)
-- Name: project_milestones_milestone_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_milestone_fkey FOREIGN KEY (milestone) REFERENCES milestones(id);


--
-- TOC entry 3855 (class 2606 OID 211636)
-- Name: project_milestones_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3856 (class 2606 OID 211641)
-- Name: project_prefecture_prefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_prefecture_id_fkey FOREIGN KEY (prefecture_id) REFERENCES prefecture(id);


--
-- TOC entry 3857 (class 2606 OID 211646)
-- Name: project_prefecture_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3858 (class 2606 OID 211651)
-- Name: project_progress_milestone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_progress
    ADD CONSTRAINT project_progress_milestone_id_fkey FOREIGN KEY (milestone_id) REFERENCES project_types(id);


--
-- TOC entry 3859 (class 2606 OID 211656)
-- Name: project_progress_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_progress
    ADD CONSTRAINT project_progress_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3845 (class 2606 OID 211661)
-- Name: project_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- TOC entry 3860 (class 2606 OID 211666)
-- Name: project_region_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3861 (class 2606 OID 211671)
-- Name: project_region_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- TOC entry 3846 (class 2606 OID 211676)
-- Name: project_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_type_fkey FOREIGN KEY (type) REFERENCES project_types(id);


--
-- TOC entry 3862 (class 2606 OID 211681)
-- Name: region_subprefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_subprefecture_id_fkey FOREIGN KEY (subprefecture_id) REFERENCES subprefecture(id);


--
-- TOC entry 3809 (class 2606 OID 211686)
-- Name: state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY city
    ADD CONSTRAINT state_id_fkey FOREIGN KEY (state_id) REFERENCES state(id);


--
-- TOC entry 3864 (class 2606 OID 211691)
-- Name: user_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_created_by_fkey FOREIGN KEY (created_by) REFERENCES "user"(id);


--
-- TOC entry 3865 (class 2606 OID 211696)
-- Name: user_follow_counsil_counsil_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_counsil_id_fkey FOREIGN KEY (counsil_id) REFERENCES organization(id);


--
-- TOC entry 3866 (class 2606 OID 211701)
-- Name: user_follow_counsil_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3867 (class 2606 OID 211706)
-- Name: user_follow_project_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 3868 (class 2606 OID 211711)
-- Name: user_follow_project_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3869 (class 2606 OID 211716)
-- Name: user_request_council_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 3870 (class 2606 OID 211721)
-- Name: user_request_council_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 3871 (class 2606 OID 211726)
-- Name: user_role_fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_fk_role_id FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 3872 (class 2606 OID 211731)
-- Name: user_role_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_fk_user_id FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 3873 (class 2606 OID 211736)
-- Name: user_session_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_fk_user_id FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


-- Completed on 2016-03-28 17:32:39 BRT

--
-- PostgreSQL database dump complete
--



INSERT INTO "user" ("id", "name", "email", "active", "created_at", "password", "created_by", "type")
 VALUES (1, 'superadmin', 'superadmin@email.com', true, '2013-10-28 10:18:12.570887', '$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW', NULL, 'superadmin');
INSERT INTO "user" ("id", "name", "email", "active", "created_at", "password", "created_by", "type")
 VALUES (2, 'admin', 'admin@email.com', true, '2013-10-28 10:18:12.570887', '$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW', NULL, 'admin');
 INSERT INTO "user" ("id", "name", "email", "active", "created_at", "password", "created_by", "type")
 VALUES (3, 'webapi', 'no-email', true, '2015-10-28 10:18:12.570887', 'no-password', NULL, '');

 INSERT INTO user_role (user_id, role_id)
 VALUES (1, 0);
 INSERT INTO user_role (user_id, role_id)
 VALUES (1, 1);
 INSERT INTO user_role (user_id, role_id)
 VALUES (2, 1);
 INSERT INTO user_role (user_id, role_id)
 VALUES (3, 4);
insert into user_session (user_id, api_key, valid_until) values (3, 'you-may-change-it-on-user-session-where-user-id=3', '2040-01-01');

commit;
