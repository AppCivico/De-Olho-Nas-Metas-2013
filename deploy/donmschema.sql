--
-- PostgreSQL database dump
--
BEGIN;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: sqitch; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sqitch;


ALTER SCHEMA sqitch OWNER TO postgres;

--
-- Name: SCHEMA sqitch; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA sqitch IS 'Sqitch database deployment metadata v1.0.';


--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

--
-- Name: project_progress_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE project_progress_type AS ENUM (
    'late',
    'in_progress',
    'completed'
);


ALTER TYPE public.project_progress_type OWNER TO postgres;

--
-- Name: user_request_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE user_request_type AS ENUM (
    'pending',
    'denied',
    'accepted'
);


ALTER TYPE public.user_request_type OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: budget; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.budget OWNER TO postgres;

--
-- Name: budget_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE budget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.budget_id_seq OWNER TO postgres;

--
-- Name: budget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE budget_id_seq OWNED BY budget.id;


--
-- Name: campaign; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE campaign (
    id integer NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now(),
    user_id integer,
    name text NOT NULL,
    start_in date NOT NULL,
    end_on date NOT NULL,
    address text,
    latitude text,
    longitude text,
    region_id integer,
    organization_id integer,
    free_text text,
    objective text NOT NULL,
    project_id integer,
    mobile_campaign_id integer
);


ALTER TABLE public.campaign OWNER TO postgres;

--
-- Name: campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaign_id_seq OWNER TO postgres;

--
-- Name: campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE campaign_id_seq OWNED BY campaign.id;


--
-- Name: city; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE city (
    id integer NOT NULL,
    name text NOT NULL,
    name_url text,
    state_id integer,
    country_id integer
);


ALTER TABLE public.city OWNER TO postgres;

--
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_id_seq OWNER TO postgres;

--
-- Name: comment_goal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.comment_goal OWNER TO postgres;

--
-- Name: comment_goal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comment_goal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_goal_id_seq OWNER TO postgres;

--
-- Name: comment_goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comment_goal_id_seq OWNED BY comment_goal.id;


--
-- Name: comment_project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.comment_project OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comment_id_seq OWNED BY comment_project.id;


--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE company (
    id integer NOT NULL,
    name text NOT NULL,
    name_url text NOT NULL,
    cnpj text
);


ALTER TABLE public.company OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_id_seq OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE company_id_seq OWNED BY company.id;


--
-- Name: contact; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contact (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    message text NOT NULL
);


ALTER TABLE public.contact OWNER TO postgres;

--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_id_seq OWNER TO postgres;

--
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contact_id_seq OWNED BY contact.id;


--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE country (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_id_seq OWNER TO postgres;

--
-- Name: district; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE district (
    id integer NOT NULL,
    name text NOT NULL,
    city_id integer NOT NULL,
    center_lat_long point NOT NULL,
    perimeter text NOT NULL
);


ALTER TABLE public.district OWNER TO postgres;

--
-- Name: district_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.district_id_seq OWNER TO postgres;

--
-- Name: district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE district_id_seq OWNED BY district.id;


--
-- Name: email_queue; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.email_queue OWNER TO postgres;

--
-- Name: email_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE email_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_queue_id_seq OWNER TO postgres;

--
-- Name: email_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE email_queue_id_seq OWNED BY email_queue.id;


--
-- Name: event; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.event OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE event_id_seq OWNED BY event.id;


--
-- Name: file; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE file (
    id integer NOT NULL,
    name text,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    status_text json
);


ALTER TABLE public.file OWNER TO postgres;

--
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_id_seq OWNER TO postgres;

--
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE file_id_seq OWNED BY file.id;


--
-- Name: goal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.goal OWNER TO postgres;

--
-- Name: goal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_id_seq OWNER TO postgres;

--
-- Name: goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_id_seq OWNED BY goal.id;


--
-- Name: goal_organization; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal_organization (
    id integer NOT NULL,
    goal_id integer,
    organization_id integer
);


ALTER TABLE public.goal_organization OWNER TO postgres;

--
-- Name: goal_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_organization_id_seq OWNER TO postgres;

--
-- Name: goal_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_organization_id_seq OWNED BY goal_organization.id;


--
-- Name: goal_porcentage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal_porcentage (
    id integer NOT NULL,
    goal_id integer,
    owned double precision NOT NULL,
    remainder double precision NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.goal_porcentage OWNER TO postgres;

--
-- Name: goal_porcentage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_porcentage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_porcentage_id_seq OWNER TO postgres;

--
-- Name: goal_porcentage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_porcentage_id_seq OWNED BY goal_porcentage.id;


--
-- Name: goal_project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal_project (
    id integer NOT NULL,
    goal_id integer NOT NULL,
    project_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.goal_project OWNER TO postgres;

--
-- Name: goal_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_project_id_seq OWNER TO postgres;

--
-- Name: goal_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_project_id_seq OWNED BY goal_project.id;


--
-- Name: goal_secretary; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE goal_secretary (
    id integer NOT NULL,
    goal_id integer NOT NULL,
    secretary_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    update_at timestamp without time zone
);


ALTER TABLE public.goal_secretary OWNER TO postgres;

--
-- Name: goal_secretary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE goal_secretary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_secretary_id_seq OWNER TO postgres;

--
-- Name: goal_secretary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE goal_secretary_id_seq OWNED BY goal_secretary.id;


--
-- Name: images_project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE images_project (
    id integer NOT NULL,
    project_id integer,
    name_image text NOT NULL,
    description text,
    user_id integer
);


ALTER TABLE public.images_project OWNER TO postgres;

--
-- Name: invite_counsil; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE invite_counsil (
    id integer NOT NULL,
    email text NOT NULL,
    hash text NOT NULL,
    organization_id integer,
    valid_until boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.invite_counsil OWNER TO postgres;

--
-- Name: invite_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE invite_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invite_counsil_id_seq OWNER TO postgres;

--
-- Name: invite_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE invite_counsil_id_seq OWNED BY invite_counsil.id;


--
-- Name: management; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.management OWNER TO postgres;

--
-- Name: management_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE management_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.management_id_seq OWNER TO postgres;

--
-- Name: management_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE management_id_seq OWNED BY management.id;


--
-- Name: milestones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE milestones (
    id integer NOT NULL,
    name text NOT NULL,
    project_type_id integer,
    percentage integer,
    sequence integer
);


ALTER TABLE public.milestones OWNER TO postgres;

--
-- Name: milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE milestones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.milestones_id_seq OWNER TO postgres;

--
-- Name: milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE milestones_id_seq OWNED BY milestones.id;


--
-- Name: objective; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE objective (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.objective OWNER TO postgres;

--
-- Name: objective_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE objective_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.objective_id_seq OWNER TO postgres;

--
-- Name: objective_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE objective_id_seq OWNED BY objective.id;


--
-- Name: organization; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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
    subprefecture_id integer
);


ALTER TABLE public.organization OWNER TO postgres;

--
-- Name: organization_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_id_seq OWNER TO postgres;

--
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organization_id_seq OWNED BY organization.id;


--
-- Name: password_reset; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE password_reset (
    id integer NOT NULL,
    user_id integer,
    hash text NOT NULL,
    expires_at timestamp without time zone DEFAULT (now() + '7 days'::interval),
    valid boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.password_reset OWNER TO postgres;

--
-- Name: password_reset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE password_reset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.password_reset_id_seq OWNER TO postgres;

--
-- Name: password_reset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE password_reset_id_seq OWNED BY password_reset.id;


--
-- Name: pre_register; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pre_register (
    id integer NOT NULL,
    username text NOT NULL,
    useremail text NOT NULL
);


ALTER TABLE public.pre_register OWNER TO postgres;

--
-- Name: pre_register_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pre_register_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pre_register_id_seq OWNER TO postgres;

--
-- Name: pre_register_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pre_register_id_seq OWNED BY pre_register.id;


--
-- Name: prefecture; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.prefecture OWNER TO postgres;

--
-- Name: prefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE prefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prefecture_id_seq OWNER TO postgres;

--
-- Name: prefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE prefecture_id_seq OWNED BY prefecture.id;


--
-- Name: progress_goal_counsil; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE progress_goal_counsil (
    id integer NOT NULL,
    remainder double precision NOT NULL,
    owned double precision NOT NULL,
    goal_id integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.progress_goal_counsil OWNER TO postgres;

--
-- Name: progress_goal_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE progress_goal_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.progress_goal_counsil_id_seq OWNER TO postgres;

--
-- Name: progress_goal_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE progress_goal_counsil_id_seq OWNED BY progress_goal_counsil.id;


--
-- Name: project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.project OWNER TO postgres;

--
-- Name: project_accept_porcentage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_accept_porcentage (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT now(),
    progress project_progress_type
);


ALTER TABLE public.project_accept_porcentage OWNER TO postgres;

--
-- Name: project_accept_porcentage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_accept_porcentage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_accept_porcentage_id_seq OWNER TO postgres;

--
-- Name: project_accept_porcentage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_accept_porcentage_id_seq OWNED BY project_accept_porcentage.id;


--
-- Name: project_event; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.project_event OWNER TO postgres;

--
-- Name: project_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_event_id_seq OWNER TO postgres;

--
-- Name: project_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_event_id_seq OWNED BY project_event.id;


--
-- Name: project_event_read; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_event_read (
    id integer NOT NULL,
    project_event_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_event_read OWNER TO postgres;

--
-- Name: project_event_read_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_event_read_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_event_read_id_seq OWNER TO postgres;

--
-- Name: project_event_read_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_event_read_id_seq OWNED BY project_event_read.id;


--
-- Name: project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_id_seq OWNER TO postgres;

--
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_id_seq OWNED BY project.id;


--
-- Name: project_image; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_image (
    id integer NOT NULL,
    project_id integer,
    md5_image text NOT NULL
);


ALTER TABLE public.project_image OWNER TO postgres;

--
-- Name: project_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_image_id_seq OWNER TO postgres;

--
-- Name: project_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_image_id_seq OWNED BY project_image.id;


--
-- Name: project_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_images_id_seq OWNER TO postgres;

--
-- Name: project_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_images_id_seq OWNED BY images_project.id;


--
-- Name: project_milestones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_milestones (
    id integer NOT NULL,
    project_id integer,
    milestone integer,
    status integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    project_type_id integer
);


ALTER TABLE public.project_milestones OWNER TO postgres;

--
-- Name: project_milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_milestones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_milestones_id_seq OWNER TO postgres;

--
-- Name: project_milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_milestones_id_seq OWNED BY project_milestones.id;


--
-- Name: project_prefecture; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_prefecture (
    id integer NOT NULL,
    project_id integer NOT NULL,
    prefecture_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.project_prefecture OWNER TO postgres;

--
-- Name: project_prefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_prefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_prefecture_id_seq OWNER TO postgres;

--
-- Name: project_prefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_prefecture_id_seq OWNED BY project_prefecture.id;


--
-- Name: project_progress; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_progress (
    project_id integer NOT NULL,
    milestone_id integer NOT NULL,
    status integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE public.project_progress OWNER TO postgres;

--
-- Name: project_region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_region (
    id integer NOT NULL,
    project_id integer,
    region_id integer
);


ALTER TABLE public.project_region OWNER TO postgres;

--
-- Name: project_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_region_id_seq OWNER TO postgres;

--
-- Name: project_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_region_id_seq OWNED BY project_region.id;


--
-- Name: project_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_types (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.project_types OWNER TO postgres;

--
-- Name: project_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_types_id_seq OWNER TO postgres;

--
-- Name: project_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_types_id_seq OWNED BY project_types.id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE region (
    id integer NOT NULL,
    geom geometry,
    name text COLLATE pg_catalog."C.UTF-8",
    lat text,
    long text,
    subprefecture_id integer
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_id_seq OWNER TO postgres;

--
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE region_id_seq OWNED BY region.id;


--
-- Name: register_counsil_manual; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE register_counsil_manual (
    id integer NOT NULL,
    email text NOT NULL,
    phone_number text NOT NULL,
    council text NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.register_counsil_manual OWNER TO postgres;

--
-- Name: register_counsil_manual_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE register_counsil_manual_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.register_counsil_manual_id_seq OWNER TO postgres;

--
-- Name: register_counsil_manual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE register_counsil_manual_id_seq OWNED BY register_counsil_manual.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: secretary; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE secretary (
    id integer NOT NULL,
    acronym text NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.secretary OWNER TO postgres;

--
-- Name: secretary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secretary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secretary_id_seq OWNER TO postgres;

--
-- Name: secretary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE secretary_id_seq OWNED BY secretary.id;


--
-- Name: state; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE state (
    id integer NOT NULL,
    name text NOT NULL,
    uf text NOT NULL,
    country_id integer NOT NULL,
    created_by integer
);


ALTER TABLE public.state OWNER TO postgres;

--
-- Name: state_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE state_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_id_seq OWNER TO postgres;

--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE status (
    id integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_id_seq OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- Name: subprefecture; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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


ALTER TABLE public.subprefecture OWNER TO postgres;

--
-- Name: subprefecture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE subprefecture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subprefecture_id_seq OWNER TO postgres;

--
-- Name: subprefecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE subprefecture_id_seq OWNED BY subprefecture.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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
    accept_sms boolean DEFAULT false,
    accept_email boolean DEFAULT false
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_follow_counsil; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_follow_counsil (
    id integer NOT NULL,
    counsil_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now(),
    active boolean DEFAULT true
);


ALTER TABLE public.user_follow_counsil OWNER TO postgres;

--
-- Name: user_follow_counsil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_follow_counsil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_follow_counsil_id_seq OWNER TO postgres;

--
-- Name: user_follow_counsil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_follow_counsil_id_seq OWNED BY user_follow_counsil.id;


--
-- Name: user_follow_project; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_follow_project (
    id integer NOT NULL,
    project_id integer,
    user_id integer,
    ts timestamp without time zone DEFAULT now(),
    active boolean DEFAULT true
);


ALTER TABLE public.user_follow_project OWNER TO postgres;

--
-- Name: user_follow_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_follow_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_follow_project_id_seq OWNER TO postgres;

--
-- Name: user_follow_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_follow_project_id_seq OWNED BY user_follow_project.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: user_request_council; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_request_council (
    id integer NOT NULL,
    user_id integer NOT NULL,
    organization_id integer NOT NULL,
    user_status user_request_type NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.user_request_council OWNER TO postgres;

--
-- Name: user_request_council_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_request_council_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_request_council_id_seq OWNER TO postgres;

--
-- Name: user_request_council_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_request_council_id_seq OWNED BY user_request_council.id;


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_role (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_role_id_seq OWNER TO postgres;

--
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_role_id_seq OWNED BY user_role.id;


--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_session (
    id integer NOT NULL,
    user_id integer NOT NULL,
    api_key text,
    valid_for_ip text,
    valid_until timestamp without time zone DEFAULT (now() + '1 day'::interval) NOT NULL,
    ts_created timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_session_id_seq OWNER TO postgres;

--
-- Name: user_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_session_id_seq OWNED BY user_session.id;


SET search_path = sqitch, pg_catalog;

--
-- Name: changes; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE changes (
    change_id text NOT NULL,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE sqitch.changes OWNER TO postgres;

--
-- Name: TABLE changes; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE changes IS 'Tracks the changes currently deployed to the database.';


--
-- Name: COLUMN changes.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.change_id IS 'Change primary key.';


--
-- Name: COLUMN changes.change; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.change IS 'Name of a deployed change.';


--
-- Name: COLUMN changes.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- Name: COLUMN changes.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.note IS 'Description of the change.';


--
-- Name: COLUMN changes.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committed_at IS 'Date the change was deployed.';


--
-- Name: COLUMN changes.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committer_name IS 'Name of the user who deployed the change.';


--
-- Name: COLUMN changes.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.committer_email IS 'Email address of the user who deployed the change.';


--
-- Name: COLUMN changes.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planned_at IS 'Date the change was added to the plan.';


--
-- Name: COLUMN changes.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planner_name IS 'Name of the user who planed the change.';


--
-- Name: COLUMN changes.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN changes.planner_email IS 'Email address of the user who planned the change.';


--
-- Name: dependencies; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE dependencies (
    change_id text NOT NULL,
    type text NOT NULL,
    dependency text NOT NULL,
    dependency_id text,
    CONSTRAINT dependencies_check CHECK ((((type = 'require'::text) AND (dependency_id IS NOT NULL)) OR ((type = 'conflict'::text) AND (dependency_id IS NULL))))
);


ALTER TABLE sqitch.dependencies OWNER TO postgres;

--
-- Name: TABLE dependencies; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE dependencies IS 'Tracks the currently satisfied dependencies.';


--
-- Name: COLUMN dependencies.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.change_id IS 'ID of the depending change.';


--
-- Name: COLUMN dependencies.type; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.type IS 'Type of dependency.';


--
-- Name: COLUMN dependencies.dependency; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.dependency IS 'Dependency name.';


--
-- Name: COLUMN dependencies.dependency_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN dependencies.dependency_id IS 'Change ID the dependency resolves to.';


--
-- Name: events; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE events (
    event text NOT NULL,
    change_id text NOT NULL,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    requires text[] DEFAULT '{}'::text[] NOT NULL,
    conflicts text[] DEFAULT '{}'::text[] NOT NULL,
    tags text[] DEFAULT '{}'::text[] NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL,
    CONSTRAINT events_event_check CHECK ((event = ANY (ARRAY['deploy'::text, 'revert'::text, 'fail'::text])))
);


ALTER TABLE sqitch.events OWNER TO postgres;

--
-- Name: TABLE events; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE events IS 'Contains full history of all deployment events.';


--
-- Name: COLUMN events.event; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.event IS 'Type of event.';


--
-- Name: COLUMN events.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.change_id IS 'Change ID.';


--
-- Name: COLUMN events.change; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.change IS 'Change name.';


--
-- Name: COLUMN events.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- Name: COLUMN events.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.note IS 'Description of the change.';


--
-- Name: COLUMN events.requires; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.requires IS 'Array of the names of required changes.';


--
-- Name: COLUMN events.conflicts; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.conflicts IS 'Array of the names of conflicting changes.';


--
-- Name: COLUMN events.tags; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.tags IS 'Tags associated with the change.';


--
-- Name: COLUMN events.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committed_at IS 'Date the event was committed.';


--
-- Name: COLUMN events.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committer_name IS 'Name of the user who committed the event.';


--
-- Name: COLUMN events.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.committer_email IS 'Email address of the user who committed the event.';


--
-- Name: COLUMN events.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planned_at IS 'Date the event was added to the plan.';


--
-- Name: COLUMN events.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planner_name IS 'Name of the user who planed the change.';


--
-- Name: COLUMN events.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN events.planner_email IS 'Email address of the user who plan planned the change.';


--
-- Name: projects; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE projects (
    project text NOT NULL,
    uri text,
    created_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    creator_name text NOT NULL,
    creator_email text NOT NULL
);


ALTER TABLE sqitch.projects OWNER TO postgres;

--
-- Name: TABLE projects; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE projects IS 'Sqitch projects deployed to this database.';


--
-- Name: COLUMN projects.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.project IS 'Unique Name of a project.';


--
-- Name: COLUMN projects.uri; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.uri IS 'Optional project URI';


--
-- Name: COLUMN projects.created_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.created_at IS 'Date the project was added to the database.';


--
-- Name: COLUMN projects.creator_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.creator_name IS 'Name of the user who added the project.';


--
-- Name: COLUMN projects.creator_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN projects.creator_email IS 'Email address of the user who added the project.';


--
-- Name: tags; Type: TABLE; Schema: sqitch; Owner: postgres; Tablespace: 
--

CREATE TABLE tags (
    tag_id text NOT NULL,
    tag text NOT NULL,
    project text NOT NULL,
    change_id text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE sqitch.tags OWNER TO postgres;

--
-- Name: TABLE tags; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON TABLE tags IS 'Tracks the tags currently applied to the database.';


--
-- Name: COLUMN tags.tag_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.tag_id IS 'Tag primary key.';


--
-- Name: COLUMN tags.tag; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.tag IS 'Project-unique tag name.';


--
-- Name: COLUMN tags.project; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.project IS 'Name of the Sqitch project to which the tag belongs.';


--
-- Name: COLUMN tags.change_id; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.change_id IS 'ID of last change deployed before the tag was applied.';


--
-- Name: COLUMN tags.note; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.note IS 'Description of the tag.';


--
-- Name: COLUMN tags.committed_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committed_at IS 'Date the tag was applied to the database.';


--
-- Name: COLUMN tags.committer_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committer_name IS 'Name of the user who applied the tag.';


--
-- Name: COLUMN tags.committer_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.committer_email IS 'Email address of the user who applied the tag.';


--
-- Name: COLUMN tags.planned_at; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planned_at IS 'Date the tag was added to the plan.';


--
-- Name: COLUMN tags.planner_name; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planner_name IS 'Name of the user who planed the tag.';


--
-- Name: COLUMN tags.planner_email; Type: COMMENT; Schema: sqitch; Owner: postgres
--

COMMENT ON COLUMN tags.planner_email IS 'Email address of the user who planned the tag.';


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY budget ALTER COLUMN id SET DEFAULT nextval('budget_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign ALTER COLUMN id SET DEFAULT nextval('campaign_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_goal ALTER COLUMN id SET DEFAULT nextval('comment_goal_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_project ALTER COLUMN id SET DEFAULT nextval('comment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY company ALTER COLUMN id SET DEFAULT nextval('company_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact ALTER COLUMN id SET DEFAULT nextval('contact_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY district ALTER COLUMN id SET DEFAULT nextval('district_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY email_queue ALTER COLUMN id SET DEFAULT nextval('email_queue_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event ALTER COLUMN id SET DEFAULT nextval('event_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY file ALTER COLUMN id SET DEFAULT nextval('file_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal ALTER COLUMN id SET DEFAULT nextval('goal_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_organization ALTER COLUMN id SET DEFAULT nextval('goal_organization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_porcentage ALTER COLUMN id SET DEFAULT nextval('goal_porcentage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_project ALTER COLUMN id SET DEFAULT nextval('goal_project_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_secretary ALTER COLUMN id SET DEFAULT nextval('goal_secretary_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images_project ALTER COLUMN id SET DEFAULT nextval('project_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invite_counsil ALTER COLUMN id SET DEFAULT nextval('invite_counsil_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY management ALTER COLUMN id SET DEFAULT nextval('management_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY milestones ALTER COLUMN id SET DEFAULT nextval('milestones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY objective ALTER COLUMN id SET DEFAULT nextval('objective_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization ALTER COLUMN id SET DEFAULT nextval('organization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY password_reset ALTER COLUMN id SET DEFAULT nextval('password_reset_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pre_register ALTER COLUMN id SET DEFAULT nextval('pre_register_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prefecture ALTER COLUMN id SET DEFAULT nextval('prefecture_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY progress_goal_counsil ALTER COLUMN id SET DEFAULT nextval('progress_goal_counsil_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project ALTER COLUMN id SET DEFAULT nextval('project_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_accept_porcentage ALTER COLUMN id SET DEFAULT nextval('project_accept_porcentage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event ALTER COLUMN id SET DEFAULT nextval('project_event_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event_read ALTER COLUMN id SET DEFAULT nextval('project_event_read_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_image ALTER COLUMN id SET DEFAULT nextval('project_image_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_milestones ALTER COLUMN id SET DEFAULT nextval('project_milestones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_prefecture ALTER COLUMN id SET DEFAULT nextval('project_prefecture_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_region ALTER COLUMN id SET DEFAULT nextval('project_region_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_types ALTER COLUMN id SET DEFAULT nextval('project_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY region ALTER COLUMN id SET DEFAULT nextval('region_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY register_counsil_manual ALTER COLUMN id SET DEFAULT nextval('register_counsil_manual_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY secretary ALTER COLUMN id SET DEFAULT nextval('secretary_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subprefecture ALTER COLUMN id SET DEFAULT nextval('subprefecture_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_counsil ALTER COLUMN id SET DEFAULT nextval('user_follow_counsil_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_project ALTER COLUMN id SET DEFAULT nextval('user_follow_project_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_request_council ALTER COLUMN id SET DEFAULT nextval('user_request_council_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role ALTER COLUMN id SET DEFAULT nextval('user_role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_session ALTER COLUMN id SET DEFAULT nextval('user_session_id_seq'::regclass);


--
-- Name: budget_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_pkey PRIMARY KEY (id);


--
-- Name: campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_pkey PRIMARY KEY (id);


--
-- Name: city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: comment_goal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_pkey PRIMARY KEY (id);


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: district_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY district
    ADD CONSTRAINT district_pkey PRIMARY KEY (id);


--
-- Name: email_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY email_queue
    ADD CONSTRAINT email_queue_pkey PRIMARY KEY (id);


--
-- Name: event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- Name: goal_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_pkey PRIMARY KEY (id);


--
-- Name: goal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_pkey PRIMARY KEY (id);


--
-- Name: goal_porcentage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal_porcentage
    ADD CONSTRAINT goal_porcentage_pkey PRIMARY KEY (id);


--
-- Name: goal_project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_pkey PRIMARY KEY (id);


--
-- Name: goal_secretary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_pkey PRIMARY KEY (id);


--
-- Name: invite_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY invite_counsil
    ADD CONSTRAINT invite_counsil_pkey PRIMARY KEY (id);


--
-- Name: management_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY management
    ADD CONSTRAINT management_pkey PRIMARY KEY (id);


--
-- Name: milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id);


--
-- Name: name_idx; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY company
    ADD CONSTRAINT name_idx UNIQUE (name);


--
-- Name: objective_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY objective
    ADD CONSTRAINT objective_pkey PRIMARY KEY (id);


--
-- Name: organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: password_reset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY password_reset
    ADD CONSTRAINT password_reset_pkey PRIMARY KEY (id);


--
-- Name: pre_register_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pre_register
    ADD CONSTRAINT pre_register_pkey PRIMARY KEY (id);


--
-- Name: prefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prefecture
    ADD CONSTRAINT prefecture_pkey PRIMARY KEY (id);


--
-- Name: progress_goal_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY progress_goal_counsil
    ADD CONSTRAINT progress_goal_counsil_pkey PRIMARY KEY (id);


--
-- Name: project_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_pkey PRIMARY KEY (id);


--
-- Name: project_event_project_id_is_last_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_project_id_is_last_key UNIQUE (project_id, is_last);


--
-- Name: project_event_read_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_pkey PRIMARY KEY (id);


--
-- Name: project_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_image
    ADD CONSTRAINT project_image_pkey PRIMARY KEY (id);


--
-- Name: project_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT project_images_pkey PRIMARY KEY (id);


--
-- Name: project_milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_pkey PRIMARY KEY (id);


--
-- Name: project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: project_prefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_pkey PRIMARY KEY (id);


--
-- Name: project_region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_pkey PRIMARY KEY (id);


--
-- Name: project_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY project_types
    ADD CONSTRAINT project_types_pkey PRIMARY KEY (id);


--
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: register_counsil_manual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY register_counsil_manual
    ADD CONSTRAINT register_counsil_manual_pkey PRIMARY KEY (id);


--
-- Name: role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: secretary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY secretary
    ADD CONSTRAINT secretary_pkey PRIMARY KEY (id);


--
-- Name: state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id);


--
-- Name: status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: subprefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subprefecture
    ADD CONSTRAINT subprefecture_pkey PRIMARY KEY (id);


--
-- Name: user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user_follow_counsil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_pkey PRIMARY KEY (id);


--
-- Name: user_follow_project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_request_council_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_pkey PRIMARY KEY (id);


--
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- Name: user_session_api_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_api_key_key UNIQUE (api_key);


--
-- Name: user_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- Name: user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


SET search_path = sqitch, pg_catalog;

--
-- Name: changes_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_pkey PRIMARY KEY (change_id);


--
-- Name: dependencies_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_pkey PRIMARY KEY (change_id, dependency);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (change_id, committed_at);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project);


--
-- Name: projects_uri_key; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_uri_key UNIQUE (uri);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: tags_project_tag_key; Type: CONSTRAINT; Schema: sqitch; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_project_tag_key UNIQUE (project, tag);


SET search_path = public, pg_catalog;

--
-- Name: budget_goal_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX budget_goal_idx ON budget USING btree (goal_number);


--
-- Name: comment_approved_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comment_approved_idx ON comment_project USING btree (approved);


--
-- Name: fki_city_id_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_city_id_fkey ON organization USING btree (city_id);


--
-- Name: fki_country_id_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_country_id_fkey ON city USING btree (country_id);


--
-- Name: fki_organization_id_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_organization_id_fk ON management USING btree (organization_id);


--
-- Name: fki_organization_id_fk_id_organization; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_organization_id_fk_id_organization ON "user" USING btree (organization_id);


--
-- Name: fki_state_id_fkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_state_id_fkey ON city USING btree (state_id);


--
-- Name: goal_organization_goal_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX goal_organization_goal_id_idx ON goal_organization USING btree (goal_id);


--
-- Name: goal_organization_organization_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX goal_organization_organization_id_idx ON goal_organization USING btree (organization_id);


--
-- Name: goal_project_goal_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX goal_project_goal_id_idx ON goal_project USING btree (goal_id);


--
-- Name: goal_project_project_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX goal_project_project_id_idx ON goal_project USING btree (project_id);


--
-- Name: user_role_idx_role_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX user_role_idx_role_id ON user_role USING btree (role_id);


--
-- Name: user_role_idx_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX user_role_idx_user_id ON user_role USING btree (user_id);


--
-- Name: user_session_idx_user_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX user_session_idx_user_id ON user_session USING btree (user_id);


--
-- Name: budget_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_company_id_fkey FOREIGN KEY (company_id) REFERENCES company(id);


--
-- Name: budget_goal_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY budget
    ADD CONSTRAINT budget_goal_number_fkey FOREIGN KEY (goal_number) REFERENCES goal(id);


--
-- Name: campaign_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: campaign_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: campaign_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- Name: campaign_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


--
-- Name: comment_goal_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- Name: comment_goal_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_goal
    ADD CONSTRAINT comment_goal_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: comment_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_org_id_fkey FOREIGN KEY (org_id) REFERENCES organization(id);


--
-- Name: comment_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment_project
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY city
    ADD CONSTRAINT country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- Name: district_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY district
    ADD CONSTRAINT district_city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


--
-- Name: email_queue_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY email_queue
    ADD CONSTRAINT email_queue_recipient_id_fkey FOREIGN KEY (recipient_id) REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: event_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES campaign(id);


--
-- Name: event_council_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_council_id_fkey FOREIGN KEY (council_id) REFERENCES organization(id);


--
-- Name: event_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: goal_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- Name: goal_management_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_management_id_fkey FOREIGN KEY (management_id) REFERENCES management(id);


--
-- Name: goal_objective_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_objective_id FOREIGN KEY (objective_id) REFERENCES objective(id);


--
-- Name: goal_organization_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- Name: goal_organization_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_organization
    ADD CONSTRAINT goal_organization_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: goal_porcentage_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_porcentage
    ADD CONSTRAINT goal_porcentage_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- Name: goal_project_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- Name: goal_project_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_project
    ADD CONSTRAINT goal_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: goal_secretary_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- Name: goal_secretary_secretary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal_secretary
    ADD CONSTRAINT goal_secretary_secretary_id_fkey FOREIGN KEY (secretary_id) REFERENCES secretary(id);


--
-- Name: goal_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: images_project_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT images_project_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: invite_counsil_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invite_counsil
    ADD CONSTRAINT invite_counsil_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: management_fk_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY management
    ADD CONSTRAINT management_fk_city_id FOREIGN KEY (city_id) REFERENCES city(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- Name: milestones_project_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY milestones
    ADD CONSTRAINT milestones_project_type_id_fkey FOREIGN KEY (project_type_id) REFERENCES project_types(id);


--
-- Name: organization_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY management
    ADD CONSTRAINT organization_id_fk FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: organization_id_fk_id_organization; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT organization_id_fk_id_organization FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: organization_subprefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_subprefecture_id_fkey FOREIGN KEY (subprefecture_id) REFERENCES subprefecture(id);


--
-- Name: password_reset_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY password_reset
    ADD CONSTRAINT password_reset_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: progress_goal_counsil_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY progress_goal_counsil
    ADD CONSTRAINT progress_goal_counsil_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- Name: project_accept_porcentage_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_accept_porcentage
    ADD CONSTRAINT project_accept_porcentage_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_accept_porcentage_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_accept_porcentage
    ADD CONSTRAINT project_accept_porcentage_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: project_event_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_event_read_project_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_project_event_id_fkey FOREIGN KEY (project_event_id) REFERENCES project_event(id);


--
-- Name: project_event_read_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event_read
    ADD CONSTRAINT project_event_read_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: project_event_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_event
    ADD CONSTRAINT project_event_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: project_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES goal(id);


--
-- Name: project_image_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_image
    ADD CONSTRAINT project_image_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_images_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images_project
    ADD CONSTRAINT project_images_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_milestones_milestone_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_milestone_fkey FOREIGN KEY (milestone) REFERENCES milestones(id);


--
-- Name: project_milestones_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_milestones_project_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_milestones
    ADD CONSTRAINT project_milestones_project_type_id_fkey FOREIGN KEY (project_type_id) REFERENCES project_types(id);


--
-- Name: project_prefecture_prefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_prefecture_id_fkey FOREIGN KEY (prefecture_id) REFERENCES prefecture(id);


--
-- Name: project_prefecture_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_prefecture
    ADD CONSTRAINT project_prefecture_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_progress_milestone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_progress
    ADD CONSTRAINT project_progress_milestone_id_fkey FOREIGN KEY (milestone_id) REFERENCES project_types(id);


--
-- Name: project_progress_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_progress
    ADD CONSTRAINT project_progress_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- Name: project_region_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_region_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_region
    ADD CONSTRAINT project_region_region_id_fkey FOREIGN KEY (region_id) REFERENCES region(id);


--
-- Name: project_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_type_fkey FOREIGN KEY (type) REFERENCES project_types(id);


--
-- Name: region_subprefecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_subprefecture_id_fkey FOREIGN KEY (subprefecture_id) REFERENCES subprefecture(id);


--
-- Name: state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY city
    ADD CONSTRAINT state_id_fkey FOREIGN KEY (state_id) REFERENCES state(id);


--
-- Name: user_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_created_by_fkey FOREIGN KEY (created_by) REFERENCES "user"(id);


--
-- Name: user_follow_counsil_counsil_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_counsil_id_fkey FOREIGN KEY (counsil_id) REFERENCES organization(id);


--
-- Name: user_follow_counsil_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_counsil
    ADD CONSTRAINT user_follow_counsil_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: user_follow_project_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: user_follow_project_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_follow_project
    ADD CONSTRAINT user_follow_project_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: user_request_council_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- Name: user_request_council_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_request_council
    ADD CONSTRAINT user_request_council_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: user_role_fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_fk_role_id FOREIGN KEY (role_id) REFERENCES role(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- Name: user_role_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_fk_user_id FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- Name: user_session_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT user_session_fk_user_id FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


SET search_path = sqitch, pg_catalog;

--
-- Name: changes_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: dependencies_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_change_id_fkey FOREIGN KEY (change_id) REFERENCES changes(change_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dependencies_dependency_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_dependency_id_fkey FOREIGN KEY (dependency_id) REFERENCES changes(change_id) ON UPDATE CASCADE;


--
-- Name: events_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: tags_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_change_id_fkey FOREIGN KEY (change_id) REFERENCES changes(change_id) ON UPDATE CASCADE;


--
-- Name: tags_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: budget; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE budget FROM PUBLIC;
REVOKE ALL ON TABLE budget FROM postgres;
GRANT ALL ON TABLE budget TO postgres;
GRANT ALL ON TABLE budget TO smm;


--
-- Name: budget_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE budget_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE budget_id_seq FROM postgres;
GRANT ALL ON SEQUENCE budget_id_seq TO postgres;
GRANT ALL ON SEQUENCE budget_id_seq TO smm;


--
-- Name: campaign; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE campaign FROM PUBLIC;
REVOKE ALL ON TABLE campaign FROM postgres;
GRANT ALL ON TABLE campaign TO postgres;
GRANT ALL ON TABLE campaign TO smm;


--
-- Name: campaign_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE campaign_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE campaign_id_seq FROM postgres;
GRANT ALL ON SEQUENCE campaign_id_seq TO postgres;
GRANT ALL ON SEQUENCE campaign_id_seq TO smm;


--
-- Name: city; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE city FROM PUBLIC;
REVOKE ALL ON TABLE city FROM postgres;
GRANT ALL ON TABLE city TO postgres;
GRANT ALL ON TABLE city TO smm;


--
-- Name: city_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE city_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE city_id_seq FROM postgres;
GRANT ALL ON SEQUENCE city_id_seq TO postgres;
GRANT ALL ON SEQUENCE city_id_seq TO smm;


--
-- Name: comment_goal; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE comment_goal FROM PUBLIC;
REVOKE ALL ON TABLE comment_goal FROM postgres;
GRANT ALL ON TABLE comment_goal TO postgres;
GRANT ALL ON TABLE comment_goal TO smm;


--
-- Name: comment_goal_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE comment_goal_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE comment_goal_id_seq FROM postgres;
GRANT ALL ON SEQUENCE comment_goal_id_seq TO postgres;
GRANT ALL ON SEQUENCE comment_goal_id_seq TO smm;


--
-- Name: comment_project; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE comment_project FROM PUBLIC;
REVOKE ALL ON TABLE comment_project FROM postgres;
GRANT ALL ON TABLE comment_project TO postgres;
GRANT ALL ON TABLE comment_project TO smm;


--
-- Name: comment_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE comment_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE comment_id_seq FROM postgres;
GRANT ALL ON SEQUENCE comment_id_seq TO postgres;
GRANT ALL ON SEQUENCE comment_id_seq TO smm;


--
-- Name: company; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE company FROM PUBLIC;
REVOKE ALL ON TABLE company FROM postgres;
GRANT ALL ON TABLE company TO postgres;
GRANT ALL ON TABLE company TO smm;


--
-- Name: company_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE company_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE company_id_seq FROM postgres;
GRANT ALL ON SEQUENCE company_id_seq TO postgres;
GRANT ALL ON SEQUENCE company_id_seq TO smm;


--
-- Name: contact; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE contact FROM PUBLIC;
REVOKE ALL ON TABLE contact FROM postgres;
GRANT ALL ON TABLE contact TO postgres;
GRANT ALL ON TABLE contact TO smm;


--
-- Name: contact_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE contact_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE contact_id_seq FROM postgres;
GRANT ALL ON SEQUENCE contact_id_seq TO postgres;
GRANT ALL ON SEQUENCE contact_id_seq TO smm;


--
-- Name: country; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE country FROM PUBLIC;
REVOKE ALL ON TABLE country FROM postgres;
GRANT ALL ON TABLE country TO postgres;
GRANT ALL ON TABLE country TO smm;


--
-- Name: country_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE country_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE country_id_seq FROM postgres;
GRANT ALL ON SEQUENCE country_id_seq TO postgres;
GRANT ALL ON SEQUENCE country_id_seq TO smm;


--
-- Name: district; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE district FROM PUBLIC;
REVOKE ALL ON TABLE district FROM postgres;
GRANT ALL ON TABLE district TO postgres;
GRANT ALL ON TABLE district TO smm;


--
-- Name: district_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE district_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE district_id_seq FROM postgres;
GRANT ALL ON SEQUENCE district_id_seq TO postgres;
GRANT ALL ON SEQUENCE district_id_seq TO smm;


--
-- Name: email_queue; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE email_queue FROM PUBLIC;
REVOKE ALL ON TABLE email_queue FROM postgres;
GRANT ALL ON TABLE email_queue TO postgres;
GRANT ALL ON TABLE email_queue TO smm;


--
-- Name: email_queue_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE email_queue_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE email_queue_id_seq FROM postgres;
GRANT ALL ON SEQUENCE email_queue_id_seq TO postgres;
GRANT ALL ON SEQUENCE email_queue_id_seq TO smm;


--
-- Name: event; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE event FROM PUBLIC;
REVOKE ALL ON TABLE event FROM postgres;
GRANT ALL ON TABLE event TO postgres;
GRANT ALL ON TABLE event TO smm;


--
-- Name: event_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE event_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE event_id_seq FROM postgres;
GRANT ALL ON SEQUENCE event_id_seq TO postgres;
GRANT ALL ON SEQUENCE event_id_seq TO smm;


--
-- Name: goal; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE goal FROM PUBLIC;
REVOKE ALL ON TABLE goal FROM postgres;
GRANT ALL ON TABLE goal TO postgres;
GRANT ALL ON TABLE goal TO smm;


--
-- Name: goal_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE goal_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE goal_id_seq FROM postgres;
GRANT ALL ON SEQUENCE goal_id_seq TO postgres;
GRANT ALL ON SEQUENCE goal_id_seq TO smm;


--
-- Name: goal_organization; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE goal_organization FROM PUBLIC;
REVOKE ALL ON TABLE goal_organization FROM postgres;
GRANT ALL ON TABLE goal_organization TO postgres;
GRANT ALL ON TABLE goal_organization TO smm;


--
-- Name: goal_organization_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE goal_organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE goal_organization_id_seq FROM postgres;
GRANT ALL ON SEQUENCE goal_organization_id_seq TO postgres;
GRANT ALL ON SEQUENCE goal_organization_id_seq TO smm;


--
-- Name: goal_porcentage; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE goal_porcentage FROM PUBLIC;
REVOKE ALL ON TABLE goal_porcentage FROM postgres;
GRANT ALL ON TABLE goal_porcentage TO postgres;
GRANT ALL ON TABLE goal_porcentage TO smm;


--
-- Name: goal_porcentage_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE goal_porcentage_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE goal_porcentage_id_seq FROM postgres;
GRANT ALL ON SEQUENCE goal_porcentage_id_seq TO postgres;
GRANT ALL ON SEQUENCE goal_porcentage_id_seq TO smm;


--
-- Name: goal_project; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE goal_project FROM PUBLIC;
REVOKE ALL ON TABLE goal_project FROM postgres;
GRANT ALL ON TABLE goal_project TO postgres;
GRANT ALL ON TABLE goal_project TO smm;


--
-- Name: goal_project_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE goal_project_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE goal_project_id_seq FROM postgres;
GRANT ALL ON SEQUENCE goal_project_id_seq TO postgres;
GRANT ALL ON SEQUENCE goal_project_id_seq TO smm;


--
-- Name: goal_secretary; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE goal_secretary FROM PUBLIC;
REVOKE ALL ON TABLE goal_secretary FROM postgres;
GRANT ALL ON TABLE goal_secretary TO postgres;
GRANT ALL ON TABLE goal_secretary TO smm;


--
-- Name: goal_secretary_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE goal_secretary_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE goal_secretary_id_seq FROM postgres;
GRANT ALL ON SEQUENCE goal_secretary_id_seq TO postgres;
GRANT ALL ON SEQUENCE goal_secretary_id_seq TO smm;


--
-- Name: images_project; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE images_project FROM PUBLIC;
REVOKE ALL ON TABLE images_project FROM postgres;
GRANT ALL ON TABLE images_project TO postgres;
GRANT ALL ON TABLE images_project TO smm;


--
-- Name: invite_counsil; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE invite_counsil FROM PUBLIC;
REVOKE ALL ON TABLE invite_counsil FROM postgres;
GRANT ALL ON TABLE invite_counsil TO postgres;
GRANT ALL ON TABLE invite_counsil TO smm;


--
-- Name: invite_counsil_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE invite_counsil_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE invite_counsil_id_seq FROM postgres;
GRANT ALL ON SEQUENCE invite_counsil_id_seq TO postgres;
GRANT ALL ON SEQUENCE invite_counsil_id_seq TO smm;


--
-- Name: management; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE management FROM PUBLIC;
REVOKE ALL ON TABLE management FROM postgres;
GRANT ALL ON TABLE management TO postgres;
GRANT ALL ON TABLE management TO smm;


--
-- Name: management_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE management_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE management_id_seq FROM postgres;
GRANT ALL ON SEQUENCE management_id_seq TO postgres;
GRANT ALL ON SEQUENCE management_id_seq TO smm;


--
-- Name: milestones; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE milestones FROM PUBLIC;
REVOKE ALL ON TABLE milestones FROM postgres;
GRANT ALL ON TABLE milestones TO postgres;
GRANT ALL ON TABLE milestones TO smm;


--
-- Name: milestones_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE milestones_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE milestones_id_seq FROM postgres;
GRANT ALL ON SEQUENCE milestones_id_seq TO postgres;
GRANT ALL ON SEQUENCE milestones_id_seq TO smm;


--
-- Name: objective; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE objective FROM PUBLIC;
REVOKE ALL ON TABLE objective FROM postgres;
GRANT ALL ON TABLE objective TO postgres;
GRANT ALL ON TABLE objective TO smm;


--
-- Name: objective_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE objective_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE objective_id_seq FROM postgres;
GRANT ALL ON SEQUENCE objective_id_seq TO postgres;
GRANT ALL ON SEQUENCE objective_id_seq TO smm;


--
-- Name: organization; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE organization FROM PUBLIC;
REVOKE ALL ON TABLE organization FROM postgres;
GRANT ALL ON TABLE organization TO postgres;
GRANT ALL ON TABLE organization TO smm;


--
-- Name: organization_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE organization_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE organization_id_seq FROM postgres;
GRANT ALL ON SEQUENCE organization_id_seq TO postgres;
GRANT ALL ON SEQUENCE organization_id_seq TO smm;


--
-- Name: pre_register; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE pre_register FROM PUBLIC;
REVOKE ALL ON TABLE pre_register FROM postgres;
GRANT ALL ON TABLE pre_register TO postgres;
GRANT ALL ON TABLE pre_register TO smm;


--
-- Name: pre_register_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE pre_register_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE pre_register_id_seq FROM postgres;
GRANT ALL ON SEQUENCE pre_register_id_seq TO postgres;
GRANT ALL ON SEQUENCE pre_register_id_seq TO smm;


--
-- Name: prefecture; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE prefecture FROM PUBLIC;
REVOKE ALL ON TABLE prefecture FROM postgres;
GRANT ALL ON TABLE prefecture TO postgres;
GRANT ALL ON TABLE prefecture TO smm;


--
-- Name: prefecture_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE prefecture_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE prefecture_id_seq FROM postgres;
GRANT ALL ON SEQUENCE prefecture_id_seq TO postgres;
GRANT ALL ON SEQUENCE prefecture_id_seq TO smm;


--
-- Name: progress_goal_counsil; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE progress_goal_counsil FROM PUBLIC;
REVOKE ALL ON TABLE progress_goal_counsil FROM postgres;
GRANT ALL ON TABLE progress_goal_counsil TO postgres;
GRANT ALL ON TABLE progress_goal_counsil TO smm;


--
-- Name: progress_goal_counsil_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE progress_goal_counsil_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE progress_goal_counsil_id_seq FROM postgres;
GRANT ALL ON SEQUENCE progress_goal_counsil_id_seq TO postgres;
GRANT ALL ON SEQUENCE progress_goal_counsil_id_seq TO smm;


--
-- Name: project; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project FROM PUBLIC;
REVOKE ALL ON TABLE project FROM postgres;
GRANT ALL ON TABLE project TO postgres;
GRANT ALL ON TABLE project TO smm;


--
-- Name: project_accept_porcentage; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_accept_porcentage FROM PUBLIC;
REVOKE ALL ON TABLE project_accept_porcentage FROM postgres;
GRANT ALL ON TABLE project_accept_porcentage TO postgres;
GRANT ALL ON TABLE project_accept_porcentage TO smm;


--
-- Name: project_event; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_event FROM PUBLIC;
REVOKE ALL ON TABLE project_event FROM postgres;
GRANT ALL ON TABLE project_event TO postgres;
GRANT ALL ON TABLE project_event TO smm;


--
-- Name: project_event_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_event_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_event_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_event_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_event_id_seq TO smm;


--
-- Name: project_event_read; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_event_read FROM PUBLIC;
REVOKE ALL ON TABLE project_event_read FROM postgres;
GRANT ALL ON TABLE project_event_read TO postgres;
GRANT ALL ON TABLE project_event_read TO smm;


--
-- Name: project_event_read_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_event_read_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_event_read_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_event_read_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_event_read_id_seq TO smm;


--
-- Name: project_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_id_seq TO smm;


--
-- Name: project_image; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_image FROM PUBLIC;
REVOKE ALL ON TABLE project_image FROM postgres;
GRANT ALL ON TABLE project_image TO postgres;
GRANT ALL ON TABLE project_image TO smm;


--
-- Name: project_image_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_image_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_image_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_image_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_image_id_seq TO smm;


--
-- Name: project_images_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_images_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_images_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_images_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_images_id_seq TO smm;


--
-- Name: project_milestones; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_milestones FROM PUBLIC;
REVOKE ALL ON TABLE project_milestones FROM postgres;
GRANT ALL ON TABLE project_milestones TO postgres;
GRANT ALL ON TABLE project_milestones TO smm;


--
-- Name: project_milestones_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_milestones_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_milestones_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_milestones_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_milestones_id_seq TO smm;


--
-- Name: project_prefecture; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_prefecture FROM PUBLIC;
REVOKE ALL ON TABLE project_prefecture FROM postgres;
GRANT ALL ON TABLE project_prefecture TO postgres;
GRANT ALL ON TABLE project_prefecture TO smm;


--
-- Name: project_prefecture_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_prefecture_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_prefecture_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_prefecture_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_prefecture_id_seq TO smm;


--
-- Name: project_progress; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_progress FROM PUBLIC;
REVOKE ALL ON TABLE project_progress FROM postgres;
GRANT ALL ON TABLE project_progress TO postgres;
GRANT ALL ON TABLE project_progress TO smm;


--
-- Name: project_region; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_region FROM PUBLIC;
REVOKE ALL ON TABLE project_region FROM postgres;
GRANT ALL ON TABLE project_region TO postgres;
GRANT ALL ON TABLE project_region TO smm;


--
-- Name: project_region_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_region_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_region_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_region_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_region_id_seq TO smm;


--
-- Name: project_types; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE project_types FROM PUBLIC;
REVOKE ALL ON TABLE project_types FROM postgres;
GRANT ALL ON TABLE project_types TO postgres;
GRANT ALL ON TABLE project_types TO smm;


--
-- Name: project_types_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE project_types_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE project_types_id_seq FROM postgres;
GRANT ALL ON SEQUENCE project_types_id_seq TO postgres;
GRANT ALL ON SEQUENCE project_types_id_seq TO smm;


--
-- Name: region; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE region FROM PUBLIC;
REVOKE ALL ON TABLE region FROM postgres;
GRANT ALL ON TABLE region TO postgres;
GRANT ALL ON TABLE region TO smm;


--
-- Name: region_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE region_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE region_id_seq FROM postgres;
GRANT ALL ON SEQUENCE region_id_seq TO postgres;
GRANT ALL ON SEQUENCE region_id_seq TO smm;


--
-- Name: register_counsil_manual; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE register_counsil_manual FROM PUBLIC;
REVOKE ALL ON TABLE register_counsil_manual FROM postgres;
GRANT ALL ON TABLE register_counsil_manual TO postgres;
GRANT ALL ON TABLE register_counsil_manual TO smm;


--
-- Name: register_counsil_manual_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE register_counsil_manual_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE register_counsil_manual_id_seq FROM postgres;
GRANT ALL ON SEQUENCE register_counsil_manual_id_seq TO postgres;
GRANT ALL ON SEQUENCE register_counsil_manual_id_seq TO smm;


--
-- Name: role; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE role FROM PUBLIC;
REVOKE ALL ON TABLE role FROM postgres;
GRANT ALL ON TABLE role TO postgres;
GRANT ALL ON TABLE role TO smm;


--
-- Name: role_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE role_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE role_id_seq FROM postgres;
GRANT ALL ON SEQUENCE role_id_seq TO postgres;
GRANT ALL ON SEQUENCE role_id_seq TO smm;


--
-- Name: secretary; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE secretary FROM PUBLIC;
REVOKE ALL ON TABLE secretary FROM postgres;
GRANT ALL ON TABLE secretary TO postgres;
GRANT ALL ON TABLE secretary TO smm;


--
-- Name: secretary_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE secretary_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE secretary_id_seq FROM postgres;
GRANT ALL ON SEQUENCE secretary_id_seq TO postgres;
GRANT ALL ON SEQUENCE secretary_id_seq TO smm;


--
-- Name: state; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE state FROM PUBLIC;
REVOKE ALL ON TABLE state FROM postgres;
GRANT ALL ON TABLE state TO postgres;
GRANT ALL ON TABLE state TO smm;


--
-- Name: state_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE state_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE state_id_seq FROM postgres;
GRANT ALL ON SEQUENCE state_id_seq TO postgres;
GRANT ALL ON SEQUENCE state_id_seq TO smm;


--
-- Name: status; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE status FROM PUBLIC;
REVOKE ALL ON TABLE status FROM postgres;
GRANT ALL ON TABLE status TO postgres;
GRANT ALL ON TABLE status TO smm;


--
-- Name: status_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE status_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE status_id_seq FROM postgres;
GRANT ALL ON SEQUENCE status_id_seq TO postgres;
GRANT ALL ON SEQUENCE status_id_seq TO smm;


--
-- Name: subprefecture; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE subprefecture FROM PUBLIC;
REVOKE ALL ON TABLE subprefecture FROM postgres;
GRANT ALL ON TABLE subprefecture TO postgres;
GRANT ALL ON TABLE subprefecture TO smm;


--
-- Name: subprefecture_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE subprefecture_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE subprefecture_id_seq FROM postgres;
GRANT ALL ON SEQUENCE subprefecture_id_seq TO postgres;
GRANT ALL ON SEQUENCE subprefecture_id_seq TO smm;


--
-- Name: user; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE "user" FROM PUBLIC;
REVOKE ALL ON TABLE "user" FROM postgres;
GRANT ALL ON TABLE "user" TO postgres;
GRANT ALL ON TABLE "user" TO smm;


--
-- Name: user_follow_counsil; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE user_follow_counsil FROM PUBLIC;
REVOKE ALL ON TABLE user_follow_counsil FROM postgres;
GRANT ALL ON TABLE user_follow_counsil TO postgres;
GRANT ALL ON TABLE user_follow_counsil TO smm;


--
-- Name: user_follow_counsil_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE user_follow_counsil_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_follow_counsil_id_seq FROM postgres;
GRANT ALL ON SEQUENCE user_follow_counsil_id_seq TO postgres;
GRANT ALL ON SEQUENCE user_follow_counsil_id_seq TO smm;


--
-- Name: user_follow_project; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE user_follow_project FROM PUBLIC;
REVOKE ALL ON TABLE user_follow_project FROM postgres;
GRANT ALL ON TABLE user_follow_project TO postgres;
GRANT ALL ON TABLE user_follow_project TO smm;


--
-- Name: user_follow_project_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE user_follow_project_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_follow_project_id_seq FROM postgres;
GRANT ALL ON SEQUENCE user_follow_project_id_seq TO postgres;
GRANT ALL ON SEQUENCE user_follow_project_id_seq TO smm;


--
-- Name: user_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE user_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_id_seq FROM postgres;
GRANT ALL ON SEQUENCE user_id_seq TO postgres;
GRANT ALL ON SEQUENCE user_id_seq TO smm;


--
-- Name: user_role; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE user_role FROM PUBLIC;
REVOKE ALL ON TABLE user_role FROM postgres;
GRANT ALL ON TABLE user_role TO postgres;
GRANT ALL ON TABLE user_role TO smm;


--
-- Name: user_role_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE user_role_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_role_id_seq FROM postgres;
GRANT ALL ON SEQUENCE user_role_id_seq TO postgres;
GRANT ALL ON SEQUENCE user_role_id_seq TO smm;


--
-- Name: user_session; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE user_session FROM PUBLIC;
REVOKE ALL ON TABLE user_session FROM postgres;
GRANT ALL ON TABLE user_session TO postgres;
GRANT ALL ON TABLE user_session TO smm;


--
-- Name: user_session_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE user_session_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_session_id_seq FROM postgres;
GRANT ALL ON SEQUENCE user_session_id_seq TO postgres;
GRANT ALL ON SEQUENCE user_session_id_seq TO smm;


--
-- PostgreSQL database dump complete
--
COMMIT;
