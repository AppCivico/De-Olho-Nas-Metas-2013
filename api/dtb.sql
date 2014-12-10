--
-- PostgreSQL database dump
--

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

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
    porcentage text,
    management_id integer,
    user_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    update_at timestamp without time zone,
    country_id integer,
    state_id integer,
    city_id integer,
    district_id integer,
    lat_lng text,
    status_id integer,
    original_link text,
    keywords text[],
    expected_budget double precision,
    real_value_expended double precision,
    origin text,
    transversality text,
    objective_id integer
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
    number text,
    complement text
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
    updated_at timestamp without time zone
);


ALTER TABLE public.project OWNER TO postgres;

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
-- Name: project_prefecture; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE project_prefecture (
    id integer NOT NULL,
    project_id integer NOT NULL,
    prefecture_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    update_at timestamp without time zone
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
    organization_id integer
);


ALTER TABLE public."user" OWNER TO postgres;

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

ALTER TABLE ONLY contact ALTER COLUMN id SET DEFAULT nextval('contact_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY district ALTER COLUMN id SET DEFAULT nextval('district_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal ALTER COLUMN id SET DEFAULT nextval('goal_id_seq'::regclass);


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

ALTER TABLE ONLY management ALTER COLUMN id SET DEFAULT nextval('management_id_seq'::regclass);


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

ALTER TABLE ONLY pre_register ALTER COLUMN id SET DEFAULT nextval('pre_register_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prefecture ALTER COLUMN id SET DEFAULT nextval('prefecture_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project ALTER COLUMN id SET DEFAULT nextval('project_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_prefecture ALTER COLUMN id SET DEFAULT nextval('project_prefecture_id_seq'::regclass);


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

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role ALTER COLUMN id SET DEFAULT nextval('user_role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_session ALTER COLUMN id SET DEFAULT nextval('user_session_id_seq'::regclass);


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY city (id, name, name_url, state_id, country_id) FROM stdin;
1	São Paulo	sao-paulo	25	1
\.


--
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('city_id_seq', 2, true);


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contact (id, name, email, message) FROM stdin;
\.


--
-- Name: contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contact_id_seq', 1, false);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY country (id, name) FROM stdin;
1	Brasil
\.


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('country_id_seq', 2, true);


--
-- Data for Name: district; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY district (id, name, city_id, center_lat_long, perimeter) FROM stdin;
\.


--
-- Name: district_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('district_id_seq', 1, false);


--
-- Data for Name: goal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal (id, name, will_be_delivered, description, technically, expected_start_date, expected_end_date, start_date, end_date, porcentage, management_id, user_id, created_at, update_at, country_id, state_id, city_id, district_id, lat_lng, status_id, original_link, keywords, expected_budget, real_value_expended, origin, transversality, objective_id) FROM stdin;
1	Inserir aproximadamente 280 mil famílias com renda de até meio salário mínimo no Cadastro Único para atingir 773 mil famílias cadastradas	280 mil famílias inscritas no Cadastro Único	Prioridade para implementação das ações nas Subprefeituras com maior concentração de famílias em situação de extrema pobreza e pobreza. Busca Ativa apoiada pelas áreas de interface e sociedade civil. Disponibilização de espaços públicos e equipamentos municipais para ações cadastrais.	Cadastro Único para Programas Sociais do Governo Federal (Cadastro Único): é um instrumento que identifica e caracteriza as famílias de baixa renda (renda mensal de até meio salário mínimo por pessoa ou renda mensal total de até três salários mínimos). Ele é utilizado por mais de 15 programas sociais do Governo Federal, como o Bolsa Família, Minha Casa Minha Vida, PRONATEC, Tarifa Social de Energia Elétrica, Brasil Carinhoso, etc. Busca Ativa: estratégia do Plano Brasil Sem Miséria que tem como objetivo levar o Estado ao cidadão, sem esperar que as pessoas mais pobres cheguem até o poder público. Um dos grandes desafios do Brasil Sem Miséria é alcançar aqueles que não acessam os serviços públicos e vivem fora de qualquer rede de proteção social.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:31.679807	\N	\N	\N	\N	\N	\N	\N	\N	\N	103305927	\N	\N	juventude-viva                                                                sp-carinhosa                                   pop rua	1
2	Beneficiar 228 mil novas famílias com o Programa Bolsa Família	Pagamento dos benefícios do Programa Bolsa Família viabilizado	A Secretaria Municipal de Assistência e Desenvolvimento Social faz toda a mobilização necessária e executa o cadastramento que viabiliza o pagamento dos benefícios do Programa Bolsa Família (articulação com outras Secretarias e agentes, capacitações, divulgações etc).	Programa Bolsa Família: O Programa Bolsa Família (PBF) é um programa de transferência direta de renda que beneficia famílias em situação de pobreza e de extrema pobreza em todo o País. O Bolsa Família integra o Plano Brasil Sem Miséria (BSM). Linha da extrema Pobreza: renda familiar per capita inferior a R$ 70 mensais. Linha da pobreza: renda familiar per capita entre R$ 70 e R$ 140 mensais.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:31.905736	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	juventude-viva                                                                sp-carinhosa                                   pop rua	1
3	Implantar 60 Centros de Referência da Assistência Social - CRAS	60 CRAS em funcionamento	Os CRAS serão construídos ou adaptados em imóveis alugados ou cedidos. Eles serão dotados de estrutura física com garantia de acessibilidade, estrutura administrativa e recursos humanos, e cada unidade terá a capacidade de referenciar até 5 mil famílias.	Centro de Referência de Assistência Social - CRAS: unidade estatal de proteção social básica do Sistema Único de Assistência Social - SUAS, que tem o objetivo de assegurar a proteção integral à famílias em situação de vulnerabilidade social.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:32.246561	\N	\N	\N	\N	\N	\N	\N	\N	\N	14532500	\N	\N	sp-mais-inclusiva	1
4	Implantar 7 Centros de Referência Especializados da Assistência Social - CREAS	7 CREAS em funcionamento	A definição da meta - 7 unidades - responde à diretriz de garantir um equipamento em cada subprefeitura da cidade. Os CREAS serão construidos ou adaptados em imóveis alugados ou cedidos. Eles terão estrutura física adequada para acolher e garantir o atendimento e condições de privacidade, sigilo e dignidade (recepção, sala de atendimento individual e em grupo, sala para administração, banheiros, copa, espaço externo, almoxarifado). A capacidade de atendimento será de aproximadamente 80 famílias/indivíduos mês por unidade.	Centro de Referência Especializado de Assistência Social - CREAS: unidade pública e estatal, que oferta serviços especializados e continuados a famílias e indivíduos em situação de ameaça ou violação de direitos (violência física, psicológica, sexual, tráfico de pessoas, cumprimento de medidas socioeducativas em meio aberto, dentre outros).	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:32.386664	\N	\N	\N	\N	\N	\N	\N	\N	\N	2184500	\N	\N	sp-mais-inclusiva	1
5	Garantir 100.000 vagas do Programa Nacional de Acesso ao Ensino Técnico e Emprego (PRONATEC)	100 mil vagas pactuadas com o Governo Federal	Publico-alvo: Beneficiários dos programas de transferência de renda, alunos de Educação de Jovens e Adultos (EJA) inscritos no Cadastro Único e beneficiários do Seguro Desemprego. Um Grupo de Trabalho intersecretarial definirá diretrizes de execução levando em conta as necessidades específicas de populações mais vulneráveis como: juventude (observando os critérios de territórios prioritários do Plano Juventude Viva, descrito em meta específica sobre o tema), mulheres vítimas de violência, negros, índios, transsexuais, população de rua e pessoas com deficiência. O planejamento já prevê 4.000 vagas para famílias em situação de rua, conforme explicado em meta específica sobre o tema.	PRONATEC: Programa Nacional de Acesso ao Ensino Técnico e Emprego criado pelo Governo Federal, em 2011, com o objetivo de ampliar a oferta de cursos de educação profissional e tecnológica.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:32.438025	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	agenda-pop-rua, sp-mais-inclusiva, juventude-viva	1
6	Formalizar aproximadamente 22.500 microempreendedores individuais	22.500 microempreendedores individuais formalizados	O Centro de Apoio ao Trabalho (CAT) realiza sobretudo atendimentos relacionados à intermediação de mão de obra. Porém, dentro da perspectiva de geração de renda, a formalização de micro empreendedores individuais se configura em uma nova modalidade de formalização de agentes econômicos, direcionada aos trabalhadores autônomos e que não se enquadram nos vínculos empregatícios estipulados pela CLT. Esta nova modalidade tem por objetivo a formalização e a promoção de cursos e palestras nos CAT. O público atendido prioritariamente nesses espaços referese àquele considerado de alta vulnerabilidade. Serão definidas diretrizes específicas para definição de público-alvo, levando em conta recortes de gênero, juventude, étnico-racial e pessoas com deficiência.	Microempreendedor Individual (MEI): é a pessoa que trabalha por conta própria e que se legaliza como pequeno empresário. É necessário faturar no máximo até R$ 60 mil por ano e não ter participação em outra empresa como sócio ou titular. O MEI também pode ter um empregado contratado que receba o salário mínimo ou o piso da categoria.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:32.481944	\N	\N	\N	\N	\N	\N	\N	\N	\N	8721206	\N	\N	\N	1
7	Ampliar em 20 mil o número de matrículas na Educação de Jovens e Adultos e implantar 3 novos Centros Integrados (CIEJA)	3 CIEJAs instalados e 20.000 novas vagas de EJA abertas no município	Está em elaboração uma proposta de reorientação curricular que articule a educação escolar com o mundo do trabalho, da cultura e a pratica social, bem como os diferentes atendimentos oferecidos na modalidade EJA: Noturno, modular, CIEJA, CMCT e MOVA. O custo da meta apresentado refere-se à instalação dos 3 novos CIEJAs e o custo das 20 mil novas vagas no período de 1 ano.	EJA: Educação de Jovens e Adultos\nCIEJA: Centro Integrado de Educação de Jovens e Adultos\nMOVA: Movimento de Alfabetização\nCMCT: Centro Municipal de Capacitação eTreinamento	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:32.556363	\N	\N	\N	\N	\N	\N	\N	\N	\N	3030198	\N	\N	historia-africa, juventude-viva	1
8	Implantar 5 Centros de Referência Especializados para a população em situação de rua (Centros POP)	5 Centros PopRua em funcionamento	Os Centros PopRua fazem parte do Plano Municipal da Política da População em Situação de Rua. O conjunto integrado de ações e entregas desse Plano, incluindo a implantação dos 5 Centros PopRua serão monitorados pelo Comitê Intersetorial criado pelo Decreto n. 53.795/2013.	População em situação de rua: grupo populacional heterogêneo que possui em comum a pobreza extrema, os vínculos familiares interrompidos ou fragilizados e a inexistência de moradia convencional regular, e que utiliza os logradouros públicos e as áreas degradadas como espaço de moradia e de sustento, de forma temporária ou permanente, bem como as unidades de acolhimento para pernoite temporário ou como moradia provisória (definição dada pelo Decreto\nPresidencial nº 7053/2009).\nCentros PopRua: Centro de Referência Especializado com rede de atendimento socioassistencial voltado à população adulta, oferecendo: abordagens sistemáticas nas ruas e encaminhamentos para os núcleos de serviços de convivência e centros de acolhida.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:32.652233	\N	\N	\N	\N	\N	\N	\N	\N	\N	1000000	\N	\N	agenda-pop-rua, sp-mais-inclusiva	1
9	Implantar 2 restaurantes comunitários	2 Restaurantes comunitários implantados	A implantação dos restaurantes comunitários visa garantir segurança alimentar à população em situação de rua e faz parte do Plano Municipal da Política da População em Situação de Rua. Essa ação, assim como o conjunto integrado de ações e entregas do Plano será monitorada pelo Comitê Intersetorial criado pelo Decreto n. 53.795/2013.	Restaurante comunitário: tem a finalidade de servir refeições adequadas para pessoas adultas em situação de rua de forma continuada. Deverá oferecer refeições prontas, saudáveis e de qualidade. Com atendimento prioritário aos grupos da população que se encontram em situação de insegurança alimentar contribui para a\nmelhoria da saúde e qualidade de vida.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:32.716207	\N	\N	\N	\N	\N	\N	\N	\N	\N	620000	\N	\N	agenda-pop-rua, sp-mais-inclusiva	1
10	Implantar 22 Serviços de Acolhimento Institucional à população em situação de rua	22 Serviços de Acolhimento Institucional implantados	A implantação dos serviços de acolhimento compõe o Plano Municipal da Política da População em Situação de Rua e será monitorado em conjunto com as demais ações do Plano pelo Comitê Intersetorial criado pelo Decreto n. 53.795/2013, em consonância com a Politica Nacional de População de Rua. O atendimento prestado deve ser personalizado e em pequenos grupos e favorecer o convívio familiar e comunitário, bem como a utilização de serviços disponíveis na comunidade local. As regras de gestão e de convivência deverão ser construídas de forma participativa e coletiva, a fim de assegurar a autonomia dos usuários, conforme perfis. Serão 12 serviços para atendimento às famílias, 8 para atendimento a adultos de ambos os sexos e 2 para carroceiros.	Serviço de Acolhimento Institucional: acolhimento em diferentes tipos de equipamentos, destinado a famílias e/ou indivíduos com vínculos familiares rompidos ou fragilizados, a fim de garantir proteção integral. A organização do serviço deverá garantir privacidade, o respeito aos costumes, às tradições e à diversidade de: ciclos de vida, arranjos, raça/etnia, gênero e orientação sexual.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:33.057715	\N	\N	\N	\N	\N	\N	\N	\N	\N	6763025	\N	\N	agenda-pop-rua, sp-mais-inclusiva	1
11	Implantar 12 novos Consultórios na Rua com tratamentos odontológicos e relacionados ao abuso de álcool e outras drogas	12 consultórios na rua em funcionamento com equipes multidisciplinares		Consultório na rua: equipes de saúde móveis para atender à população em situação de risco e vulnerabilidade social, principalmente crianças e adolescentes e usuários de álcool e outras drogas.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:33.347631	\N	\N	\N	\N	\N	\N	\N	\N	\N	24000000	\N	\N	agenda-pop-rua	1
12	Promover ações para a inclusão social e econômica da população em situação de rua	Campanha de conscientização da população sobre os direitos e vulnerabilidades sociais da população em situação de rua, acesso de pelo menos 4.000 pessoas em situação de rua ao PRONATEC ou outros programas de qualificação profissional, promovendo ingresso ao mercado de trabalho, 2.000 habitações construídas e/ou reformadas por meio do MCMV ou outros programas habitacionais de interesse social e  articulação para empregabilidade da população em situação de rua, mediante projetos de integração e promoção social e econômica incluídos nos grandes eventos da cidade.	A política de garantia de direitos da população em situação de rua será tratada como uma das prioridades da gestão na ótica da garantia de\ndireitos humanos. Para isso, foi criada no âmbito da Secretaria de Direitos Humanos e Cidadania a Coordenação de Políticas para População em Situação de Rua que tem por objetivo articular a gestão transversal das ações públicas voltadas a esta comunidade, pautada na ampliação do diálogo com organizações da sociedade civil e movimentos sociais. Assim, a necessidade da criação de um colegiado, o Comitê Intersetorial da Política Municipal para a População em Situação de Rua (Comitê PopRua) para contribuir na criação do Plano Municipal desta políticas com ênfase na promoção da cidadania, no respeito dos direitos humanos, combate a todas as formas de discriminação e preconceito e à valorização da diversidade. O Plano Municipal da Política da População em Situação de Rua e seu conjunto integrado de ações e entregas serão monitorados por esse Comitê Intersetorial, criado pelo Decreto n. 53.795/2013. No custo total dessa meta não estão incluídos os dados de custo das Unidades Habitacionais e das vagas do PRONATEC. Tais custos estão incorporados nas fichas específicas de cada uma dessas metas.	População em situação de rua: Considera-se população em situação de rua o grupo populacional heterogêneo que possui em comum a pobreza extrema, os vínculos familiares interrompidos ou fragilizados e a inexistência de moradia convencional regular, e que utiliza os logradouros públicos e as áreas degradadas como espaço de moradia e de sustento, de forma temporária ou permanente, bem como as unidades de acolhimento para pernoite temporário ou como moradia provisória" (definição dada pelo Decreto Presidencial nº 7053/2009).	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:33.495238	\N	\N	\N	\N	\N	\N	\N	\N	\N	3142313	\N	\N	agenda-pop-rua	1
13	Implementar 4 Centros de Referência em Segurança Alimentar e Nutricional e desenvolver ações de apoio à agricultura urbana e periurbana	04 Centros de Referência de Segurança Alimentar e Nutricional e ações municipais de apoio à agricultra urbana e periurbana	Os Centros de Referência de Segurança Alimentar e Nutricional são equipados com cozinha experimental, biblioteca, espaços multimídia (salas de aula)\ne anfiteatro.	Centro de Referência em Segurança Alimentar e Nutricional (CRSAN): equipamento público onde se desenvolvem atividades de formação e assessoria para pessoas que atuam em programas relacionados aos Direitos Humanos e à Alimentação Adequada como merendeiras, nutricionistas, assistentes sociais, agentes comunitários de saúde e entidades assistenciais.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:33.644701	\N	\N	\N	\N	\N	\N	\N	\N	\N	10000000	\N	\N	\N	1
14	Valorizar o profissional da educação por meio da implantação de 31 polos da Universidade Aberta do Brasil (UAB)	 31 polos da UAB instalados nos CEUs	Os pólos de apoio presencial são as unidades operacionais para o desenvolvimento descentralizado de atividades pedagógicas e administrativas relativas aos cursos e programas ofertados à distância pelas instituições públicas de ensino superior no âmbito do Sistema UAB. Mantidos por Municípios ou Governos de Estado, os pólos oferecem a infraestrutura física, tecnológica e pedagógica para que os alunos possam acompanhar os cursos a distância. Os CEUs Rosa da China e Sapopemba (jurisdicionados à Subprefeitura de Sapopemba) atenderão também o público da Subprefeitura da Vila Prudente que não conta com unidades CEU.	Universidade Aberta do Brasil (UAB): Sistema UAB funciona como articulador entre as instituições de ensino superior e os governos estaduais e municipais, com o objetivo de atender às demandas locais por educação superior.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:34.065577	\N	\N	\N	\N	\N	\N	\N	\N	\N	3485000	\N	\N	historia-africa	2
47	Promover a prática de atividades esportivas, recreativas e de lazer por 24 horas aos finais de semanas nas 32 subprefeituras	32 equipamentos funcionando com atividades no período de 24 horas nos finais de semana	Atividades de esportes, lazer e recreação (Ex. futebol, vôlei, jogos, atividades lúdicas). A equipe de suporte contará com segurança, limpeza e monitores. A capacidade de atendimento vai variar de acordo com o tamanho do equipamento, beneficiando de 400 a 2.000 pessoas.	Revirando a Virada: abertura das unidade da Secretaria Municipal de Esportes (centro educacionais, balneários, mini balneário, estádios e parques) para 24h de esportes durante os finais de semana.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:01.16269	\N	\N	\N	\N	\N	\N	\N	\N	\N	30315964	\N	\N	sp-carinhosa, juventude-viva	7
15	Ampliar a jornada escolar de 100 mil alunos da Rede Municipal de Ensino	435 módulos de jornada extendida implantados e em funcionamento que atenderão 100 mil alunos	Os módulos do Programa Mais Educação são voltados à educação básica e visam a ampliação da permanência do aluno na escola participando de atividades de acompanhamento pedagógico ligadas ao meio ambiente, lazer e esporte, cultura e artes, cultura digital e outras áreas. Cada módulo atende a 230 alunos que passam a contar com o período extendido da jornada escolar em suas unidades de ensino. A adesão ao programa depende da aprovação do plano de trabalho apresentado pelas Unidades Escolares ao MEC. As atividades previstas nos planos de trabalho visam a extensão da jornada escolar diária para 7 horas, com atividades complementares vinculadas à proposta pedagógica. O custo total da meta representa o valor necessário para manter o Programa Mais Educação para 100 mil alunos durante o período de um ano.	Programa Mais Educação: instituído pela Portaria Interministerial n.º 17/2007, integra as ações do Plano de Desenvolvimento da Educação (PDE) como uma estratégia do Governo Federal para induzir a ampliação da jornada escolar e a organização curricular, na perspectiva da Educação Integral. Módulo: O programa é desenvolvido em módulos, sendo que cada módulo atenderá um grupo de 230 alunos.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:34.198955	\N	\N	\N	\N	\N	\N	\N	\N	\N	37447630	\N	\N	juventude-viva	2
16	Ampliar a Rede CEU em 20 unidades, expandindo a oferta de vagas para a educação infantil	20 unidades da Rede CEU implantadas	Cada nova unidade da Rede CEU contará com 1 CEMEI, 1 EMEF, quadra poliesportiva, teatro, playground, piscinas, biblioteca, telecentro e espaços para oficinas, ateliês e reuniões. Os espaços serão abertos à comunidade, inclusive aos finais de semana. Com a ampliação, a Rede CEU passará das 45 unidades em 2012 para 65 unidades em 2016. A diretriz fundamental que orienta a escolha das áreas é a identificação dos territórios com maior vulnerabilidade social e menor demanda atendida.	Rede CEU: Centro Educacional Unificado que se constitui em um complexo educacional, esportivo e cultural caracterizado como espaço público múltiplo.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:34.502791	\N	\N	\N	\N	\N	\N	\N	\N	\N	620000000	\N	\N	sp-mais-inclusiva, historia-africa	2
17	Obter terrenos, projetar, licitar, licenciar, garantir a fonte de financiamento e construir 243 Centros de Educação Infantil	243 CEIs implantados	A meta será atingida com a construção de novos equipamentos com recursos do município e de parcerias com o Governo do Estado de São Paulo e com o Governo Federal. A política de expansão de vagas em creches é estruturada como um direito das crianças e das mulheres, articulada ao Programa Brasil Carinhoso e a um projeto educacional comprometido com uma educação não-sexista, não-racista e não-homofóbica. O cumprimento da meta gerará aproximadamente 53 mil novas vagas.	Centro de Educação Infantil: unidade de educação municipal para\ncrianças de 0 a 3 anos de idade	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:37.969045	\N	\N	\N	\N	\N	\N	\N	\N	\N	1280547630	\N	\N	sp-carinhosa, sp-mais-inclusiva	2
18	Construir 65 Escolas Municipais de Educação Infantil (EMEI) e um Centro Municipal de Educação Infantil (CEMEI)	65 EMEIs e 1 CEMEI implantados	A meta será atingida com a construção de novos equipamentos com recursos do município e em parceria com o Governo do Estado de São Paulo. A política de expansão de vagas em creches é estruturada como um direito das crianças e das mulheres, articulada ao Programa Brasil Carinhoso e a um projeto educacional comprometido com uma educação não-sexista, não-racista e não-homofóbica. O cumprimento da meta gerará a abertura de cerca de 30 mil novas vagas.	EMEI: Escola Municipal de Educação Infantil: unidade de educação municipal para crianças de 4 a 5 anos de idade.\nCEMEI: Centro Municipal de Educação Infantil: unidade de educação municipal para crianças de 0 a 5 anos de idade.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:39.741578	\N	\N	\N	\N	\N	\N	\N	\N	\N	295714464	\N	\N	sp-carinhosa, sp-mais-inclusiva	2
19	Expandir a oferta de vagas para educação infantil por meio da rede conveniada e outras modalidades de parcerias	52 mil novas vagas para educação infantil na rede conveniada e por outras modalidades de parcerias	A Rede Conveniada representa os convênios firmados com instituições não governamentais para operação e manutenção das unidades municipais. Pretende-se ainda firmar acordos e parcerias com empresas privadas, em observância ao estabelecido no art. 389 § 2º da CLT, e ainda outras parcerias como PPPs. A política de expansão de vagas em creches é estruturada como um direito das crianças e das mulheres, articulada ao Programa Brasil Carinhoso e a um projeto educacional comprometido com uma educação não-sexista, não-racista e não-homofóbica. O custo total da meta refere-se à manutenção de 52 mil vagas para educação infantil por meio da rede conveniada e outras modalidades de parcerias durante o período de 1 ano.	Rede Conveniada: Instituições não governamentais que oferecem o serviço de educação infantil.\nParcerias: Convênios e acordos com empresas privadas e Parcerias Publico Privadas- PPP.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:40.009375	\N	\N	\N	\N	\N	\N	\N	\N	\N	306263135	\N	\N	\N	2
20	Instalar 32 unidades da Rede Hora Certa distribuídas em cada uma das Subprefeituras	32 unidades da Rede Hora Certa instaladas com ambulatório de especialidades	A Rede Hora Certa compõe a atenção ambulatorial especializada definida como um conjunto de ações e serviços que visam atender aos principais problemas de saúde e agravos da população. É necessária a disponibilidade de profissionais especializados de nível superior e médio para a realização dos procedimentos tais como: cirurgia ambulatoriais, procedimentos traumato-ortopédicos, ações especializadas em odontologia, citopatologia, radiodiagnóstico, exames ultrassonográficos e outros. O principal objetivo da Rede Hora Certa é conseguir reduzir o tempo de espera para exames, consultas e procedimentos especializados, incluindo as cirurgias eletivas.	Rede Hora Certa: serviços de atenção ambulatorial especializada com recursos tecnológicos de apoio diagnóstico e terapêutico e procedimentos cirúrgicos de pequeno e médio porte.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:40.682146	\N	\N	\N	\N	\N	\N	\N	\N	\N	224000000	\N	\N	sp-mais-inclusiva	3
21	Desenvolver o processo de inclusão do módulo do prontuário eletrônico do paciente (PE) na rede municipal de saúde, integrada ao Sistema SIGA 	Prontuário eletrônico do paciente com o registro da história clínica, exame físico, medicamentos, resultado de exames clínicos, procedimentos, dentre outros, implantados em todos os serviços ambulatoriais e hospitalares com a informatização dos consultórios de cada serviço.	A inclusão do módulo prontuário eletrônico do paciente no SIGA disponibiliza as informações em tempo real para o planejamento e acompanhamento de atividades para a implantação de novos modelos assistenciais; aperfeiçoa a organização do processo de trabalho assistencial, possibilitando subsídios para a agilização de tomadas de decisão clínica e melhoria na qualidade assistencial; integra as atividades administrativas e assistenciais, permitindo redução de custos; utiliza o Cartão Nacional de Saúde como elemento integrador dos diversos níveis do sistema. O prontuário eletrônico deve estar de acordo com as orientações e determinações da Resoluções CFM Nº 1821/2007, 1638/2002.	Prontuário eletrônico do paciente: é o repositório de informações a respeito da saúde do indivíduo, de forma processável eletronicamente.\nSIGA: Sistema Integrado de Gestão e Assistência à Saúde	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:40.858103	\N	\N	\N	\N	\N	\N	\N	\N	\N	105000000	\N	\N	\N	3
22	Obter terrenos, projetar, licitar, licenciar, garantir a fonte de financiamento e construir 3 novos hospitais, ampliando em 750 o número de leitos do sistema municipal de saúde	3 hospitais em funcionamento	Construção de 3 hospitais, com 250 leitos cada um, sendo eles:\n- Hospital Municipal de Parelheiros;\n- Hospital Municipal Brasilândia;\n- Construção de um novo Hospital em substituição ao Hospital Municipal Alexandre Zaio, no mesmo local.\nCom essas construções busca-se aumentar o número e a qualidade dos atendimentos à população, através de ambientes mais propícios a um atendimento\nacolhedor e humanizado.	Hospital: unidade de saúde que busca oferecer atendimento à população no diagnóstico e tratamento em ambientes de internação acolhedores e humanizados	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:40.986565	\N	\N	\N	\N	\N	\N	\N	\N	\N	603500000	\N	\N	sp-mais-inclusiva	3
23	Recuperar e adequar 16 hospitais municipais, com a ativação de 250 leitos	250 leitos ativados em 16 hospitais recuperados	A recuperação dos hospitais, com ativação de leitos, inclui:\n- reformas na estrutura física\n- renovação de equipamentos e mobiliário\n- adequação do quadro de pessoal\nAtravés de reformas, ampliações e adequações necessárias a serem realizadas busca-se:\n- Garantia de segurança aos trabalhadores e usuários destas unidades;\n- Melhores condições de trabalho e atendimento, criando ambientes mais propícios a um atendimento acolhedor e humanizado;\n- Cumprimento integral das normas do Ministério da Saúde, adequando estas unidades ao preconizado pela RDC Nº 50;\n- Atender os apontamentos da Lei Federal nº 10.098 de 19/12/2000 Art.11.\n\nHospitais a serem recuperados e readequados:\n\nHospital Municipal Prof. Waldomiro de Paula\nHospital Municipal José Soares Hungria\nHospital Municipal Tide Setubal\nHospital Municipal Alípio Correa Neto\nHospital Municipal Dr. Carmino Caricchio\nHospital Municipal Dr. Arthur Ribeiro de Saboya\nHospital Municipal Sorocabana\nHospital Municipal Dr. Mario Degni\nHospital Municipal Dr. Fernando Mauro Pires da Rocha\nHospital Municipal Maternidade Escola Dr. Mario de Moraes Altenfeider Silva\nHospital Municipal Infantil Menino Jesus\nHospital Municipal Vereador José Storopoli\nHospital Municipal Cidade Tiradentes - Carmen Prudente\nHospital Municipal Benedicto Montenegro\nHospital Municipal São Luiz Gonzaga\nHospital Municipal Dr. Moysés Deustch - M`Boi Mirim	Recuperação: envolve os aspectos físicos e estruturais das instalações e dos equipamentos.\nAdequação: garantir que a estrutura e funcionamento dos hospitais estejam de acordo com as normas vigentes.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:41.348788	\N	\N	\N	\N	\N	\N	\N	\N	\N	193256000	\N	\N	\N	3
24	Obter terrenos, projetar, licitar, licenciar, garantir a fonte de financiamento, construir e instalar 43 novas Unidades Básicas de Saúde - segundo o modelo da UBS Integral	43 Unidade Básica de Saúde - UBS em funcionamento	Diretrizes: integração da atividade programática com o atendimento não agendado; promoção da saúde de forma intersetorial e com a comunidade; organização das condições para coordenar a continuidade do cuidado com os outros pontos de atenção da rede, quando necessário.	Unidade Básica de Saúde Integral: é a porta de entrada preferencial do Sistema Único de Saúde (SUS). Contempla princípios de clínica ampliada, integralidade de ações, resolubilidade, acolhimento, humanização, gestão qualificada do cuidado e atendimento de demanda espontânea, além de apropriação e participação efetiva da comunidade, particularmente em atividades de colegiado de gestão.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:42.499961	\N	\N	\N	\N	\N	\N	\N	\N	\N	236500000	\N	\N	sp-mais-inclusiva	3
25	Reformar e melhorar 20 Prontos Socorros utilizando o modelo conceitual da Unidade de Pronto Atendimento (UPA) e implantar 5 novas UPAs	05 novas UPAS em funcionamento e  reformas em 20 equipamentos de pronto atendimento existentes (Pronto Socorro, AMA 24h), transformando-os em UPAs	As UPA serão implantadas em locais estratégicos para a atenção às urgências funcionando ininterruptamente, 24horas por dia, todos os dias da semana. Serão constituídas por equipe multiprofissional interdisciplinar compatível com seu porte e as necessidades assistenciais da região. Sua estrutura garantirá retaguarda às urgências atendidas pela Rede de Atenção Básica e também como local de estabilização de pacientes atendidos pelo SAMU 192.\n\nUPAs a serem reformadas e construídas\nUPA PS Municipal Dr. Caetano Virgilio Netto (serviço existente - ampliação)\nUPA São Jorge (construção nova)\nUPA AMA Paraisópolis (serviço existente - ampliação)\nUPA PA Municipal Jardim Macedônia (serviço existente - ampliação)\nUPA PS Municipal Dona Maria Antonieta F de Barros (serviço existente - ampliação)\nUPA PS Municipal 21 de Junho / Freguesia do Ó (serviço existente - reforma)\nUPA PS Municipal Júlio Tupy (serviço existente - ampliação)\nUPA PS Municipal Augusto Gomes de Matos (serviço existente - ampliação)\nUPA Prof. Waldomiro de Paula - Itaquera (serviço existente - construção nova)\nUPA AMA Dr. Arthur Ribeiro Saboya - Jabaquara (construção nova)\nUPA São Luiz Gonzaga (construção nova)\nUPA AMA Sorocabana (serviço existente - ampliação)\nUPA PS Municipal Prof. João Catarin Mezomo - Lapa (serviço existente - construção nova)\nUPA AMA Dr. Fernando Mauro Pires da Rocha - Campo Limpo (serviço existente - ampliação)\nUPA AMA Dr. Carmino Caricchio - Tatuapé (serviço existente - construção nova)\nUPA PS Municipal Balneário São José (serviço existente - reforma)\nUPA AMA José Soares Hungria - Pirituba (serviço existente - construção nova)\nUPA PS Municipal Lauro Ribas Braga - Santana (serviço existente - reforma)\nUPA PA Municipal São Mateus II (serviço existente - ampliação)\nUPA AMA Complexo Prates (serviço existente - ampliação)\nUPA AMA Sé (serviço existente - ampliação)\nUPA PS Municipal Dr. Álvaro Dino de Almeida (serviço existente - ampliação)\nUPA Santa Casa de São Paulo (construção nova)\nUPA PS Municipal Vila Maria Baixa (serviço existente - ampliação)\nUPA Hospital São Paulo - Vila Mariana (construção nova)\n	Unidades de Pronto Atendimento - UPA 24h: são estruturas de complexidade intermediária entre as UBS e as portas de urgência hospitalares.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:43.435312	\N	\N	\N	\N	\N	\N	\N	\N	\N	237000000	\N	\N	sp-mais-inclusiva	3
26	Implantar 30 Centros de Atenção Psicossocial (CAPS)	30 CAPS em funcionamento, sendo: - 13 CAPS III Álcool e Drogas; - 07 CAPS Infantil;  e 10 CAPS III Adulto	Os CAPs são constituídos por equipe multiprofissional que atuam na ótica interdisciplinar. O cuidado no âmbito dos CAPS é desenvolvido por intermédio de Projeto Terapêutico Singular, envolvendo em sua construção a equipe, o usuário e sua família. Os atendimentos são: acolhimento inicial, acolhimento diurno e/ou noturno, atendimento individual, atenção às situações de crise, atendimento em grupo, práticas corporais, práticas expressivas e comunicativas, atendimento para a família, atendimento domiciliar e ações de reabilitação psicossocial, promoção de contratualidade, fortalecimento do protagonismo de usuários e familiares, ações de articulação de redes intra e intersetoriais, matriciamento de equipes dos pontos de atenção da atenção básica, urgência e emergência e dos serviços hospitalares de referência e todas as ações de redução de danos.	CAPS: são pontos de atenção estratégicos para o atendimento das pessoas com transtornos mentais graves e persistentes e também com\nnecessidades decorrentes do uso de crack, álcool e outras drogas, de todas as faixas etárias.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:44.168501	\N	\N	\N	\N	\N	\N	\N	\N	\N	64140000	\N	\N	\N	3
27	Construir, requalificar ou reformar 16 equipamentos culturais	16 equipamentos culturais implantados	Serão priorizadas as áreas localizadas nas regiões de maior vulnerabilidade socioeconômica, alta densidade demográfica e carência de equipamentos\nculturais públicos, mas estratégicas para a produção e difusão cultural da cidade.	Construção: edificação integral de equipamento com finalidade cultural, desde a seleção do terreno até a finalização total da obra.\nRequalificação: adaptação de edificação já existente, através de reforma, ou alteração de seu uso para atender a finalidade cultural.\nReforma: restauro ou retificação de edificação existente, caracterizada como de finalidade cultural, através de obra parcial.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:44.641917	\N	\N	\N	\N	\N	\N	\N	\N	\N	67508000	\N	\N	sp-mais-inclusiva, historia-africa	4
85	Criar e efetivar um programa de incentivos fiscais para prédios verdes	Um Projeto de Lei que permita o uso dos mecanismos de isenção fiscal para o fortalecimento do uso de tecnologias verdes em edifícios.	Esta meta não possui custo de implantação.	Incentivos Fiscais: Redução da carga tributária concedida a certas empresas e munícipes que atendem a critérios previstos em lei, com o objetivo de incentivar o uso de tecnologias verdes.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:19.900813	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	14
28	Alcançar um calendário anual de programação cultural que inclua uma virada cultural no centro, duas descentralizadas e outros pequenos e médios eventos em diferentes temáticas e regiões da cidade	4 Viradas Culturais no Centro,  8 Viradas Culturais em novas centralidades,  4 Festas de São João, 4 Festivais dos Povos do Mundo e demais atividades do Calendário Anual Cultural: Aniversário da Cidade, Maratona de Música, Viradinha das Férias, Festival de Comida, Mês da Cultura Independente, Festa Baile e São Paulo: Cidade do Samba		Calendário de eventos culturais: sistematização de agendas periódicas ou fixas de festivais, bienais feiras, fóruns e encontros, abrangendo todo o território e todos os segmentos culturais.\nEvento cultural: Atividade cultural temporária com o objetivo de difundir manifestações, estimular a criatividade e expressões populares e artísticas, ou promover debates em torno do assunto.\nEvento cultural de pequeno porte: para até 300 pessoas.\nEvento cultural de médio porte: para até 4 mil pessoas.\nEvento cultural de grande porte: para mais de 4 mil pessoas.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:44.84737	\N	\N	\N	\N	\N	\N	\N	\N	\N	51362103	\N	\N	sp-carinhosa, sp-mais-inclusiva	4
29	Viabilizar três Centros Culturais de Referência	3 Centros Culturais de Referência em funcionamento (2 novas instalações e 1 instalação viabilizada)	Cada Centro Cultural deverá ser construído em módulos distintos e independentes, de maneira que sua utilização possa ser iniciada enquanto a construção ainda se realiza. A previsão é de atendimento de um público estimado de 85 mil pessoas/mês, através da realização de programação cultural específica e da oferta de outros programas já desenvolvidos pela Secretaria Municipal de Cultura, como o Programa Vocacional e o Programa de Iniciação Artística (PIÁ). A implantação dos equipamentos leva em conta a necessidade de ampliar a oferta de equipamentos em duas regiões que concentram grande número de atores e iniciativas culturais, a zona sul e a zona leste. A viabilização do Centro de Formação Cultural Cidade Tiradentes também foi incorporada à meta. Por viabilização entende-se a criação de condições técnicas, orçamentárias e institucionais para a implementação de cursos e atividades culturais previstos em seu projeto, permitindo o amplo aproveitamento do espaço e do potencial formativo ali existentes.	Centro Cultural: equipamento cultural que contará com área para produção cultural para utilização dos grupos e coletivos culturais da cidade, cinema, área expositiva, centro de memória, biblioteca, centro de estudo de idiomas, espaço para arte e cultural digital e teatro.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:45.00518	\N	\N	\N	\N	\N	\N	\N	\N	\N	33000000	\N	\N	juventude-viva	4
30	Criar o Programa Cultura Viva Municipal com a ativação de 300 Pontos de Cultura	300 Pontos de Cultura em funcionamento	Os Pontos de Cultura são ações que integram o Programa Cultura Viva, atualmente mantido pelo Ministério da Cultura. A SMC prevê criar o Programa Cultura Viva com a ativação de 300 diferentes Pontos de Cultura considerando que os contemplados irão desenvolver suas atividades por 2 anos, prorrogáveis por igual período. Articular as ações desenvolvidas pelos Pontos de Cultura com a rede de equipamentos culturais (públicos e não públicos), atores e iniciativas culturais do entorno. Serão priorizadas as regiões com baixa estrutura de equipamentos culturais públicos, alta densidade populacional, considerando os índices de vulnerabilidade social. As definições específicas de ações ou projetos contemplados por território ocorre mediante demandas apresentadas anualmente por meio de editais.	Pontos de Cultura: núcleos culturais juridicamente constituídos por ONGs que visam potencializar iniciativas culturais já existentes, ampliando e garantindo o acesso da população à fruição, criação e produção da diversidade cultural da cidade.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:45.14681	\N	\N	\N	\N	\N	\N	\N	\N	\N	25850000	\N	\N	sp-mais-inclusiva, historia-africa, juventude-viva	4
31	Adaptar e consolidar o Fundo Municipal de Cultura	Fundo Municipal de Cultura em funcionamento	O Fundo Municipal de Cultura será uma readequação do atual Fundo Especial de Promoção de Atividades Culturais - FEPAC, incorporando as resoluções e determinações do Conselho Municipal de Cultural e do Plano Municipal de Cultura. O Fundo tem a finalidade de financiar ações finalísticas da Secretaria Municipal de Cultura e sua adaptação serve para que ações-meio e políticas também estejam aptas a serem suportadas. Para o ingresso no Sistema Nacional de Cultura, também é preciso que o Fundo ganhe atribuições específicas, como a capacidade de receber transferências fundo a fundo (federal, estadual e municipal).	Fundo Municipal de Cultura: tem por objetivo fomentar projetos e ações culturais na cidade, a partir de diretrizes definidas pelo Conselho\nMunicipal de Cultura e consolidadas no Plano Municipal de Cultura. O Fundo deve permitir a transferência de recursos dos fundos de cultura estadual e federal, bem como a utilização dos recursos em diferentes ações: curadoria, desenvolvimento de projetos, programação cultural etc.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:45.258148	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	4
32	Conceder 300 Bolsas Cultura para agentes culturais da cidade. 	300 Bolsas Cultura concedidas	O objetivo do programa é democratizar a produção cultural a partir da remuneração de agentes que já praticam cultura numa visão ampliada. Público-Alvo: Agentes culturais que já desenvolvem práticas culturais numa acepção ampliada (isto é, não apenas ligadas às tradicionais linguagens artísticas, mas também a expressões culturais mais amplas), principalmente na periferia. Entende-se por práticas culturais periféricas não apenas aquelas realizadas em regiões geograficamente separadas das regiões mais ricas da cidade como também aquelas realizadas em condições sociais adversas e não contempladas pelo mercado.Está previsto para 2014 o lançamento do primeiro edital do programa. Serão concedidas nos anos de 2014, 2015 e 2016, 100 bolsas mensais no\nvalor de R$ 1.000,00 a agentes culturais distintos, pelo período de 12 meses, renováveis por igual período. O programa prioriza ações culturais realizadas nas regiões com baixa estrutura de equipamentos culturais públicos, alta densidade populacional, considerando os índices de vulnerabilidade social. As definições específicas de ações ou projetos contemplados por território ocorre mediante demandas apresentadas anualmente por meio de editais. O custo das renovações das bolsas concedidas em 2016 não foi considerado no Custo Total da Meta por ser pago no ano de 2017.	Bolsa Cultura: A seleção é feita por edital público e se dará em duas etapas; eliminatória seguida de sorteio. Forma de inscrição: individual. Modalidade de prestação de contas: relatório anual de atividades.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:45.374458	\N	\N	\N	\N	\N	\N	\N	\N	\N	6982917	\N	\N	\N	4
33	Atingir 160 projetos anuais de fomento às linguagens artísticas	160 projetos fomentados	Projetos artísticos e culturais focados na pesquisa continuada, com produtos resultantes como: espetáculos, intervenções artísticas, audiovisuais.O período de duração varia em função da ação proposta em cada projeto, não ultrapassando o prazo máximo de 2 anos. O objetivo é chegar no ano de 2016 com 160 projetos sendo financiados pelos programas de fomento, por isso as entregas previstas para o primeiro e o segundo biênio aqui apresentadas não são cumulativas.	Programa Municipal de Fomento ao Teatro: criado em 8 de janeiro de 2002 - Lei nº 13.279.\nPrograma Municipal de Fomento à Dança: criado em setembro de 2006 - Lei 14.071/05.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:45.518888	\N	\N	\N	\N	\N	\N	\N	\N	\N	183733241	\N	\N	sp-mais-inclusiva, historia-africa, juventude-viva	4
34	Atingir 500 projetos fomentados pelo Programa para a Valorização de Iniciativas Culturais - VAI, nas modalidades 1 e 2	500 projetos fomentados	O programa prioriza ações culturais realizadas nas regiões com baixa estrutura de equipamentos culturais públicos, alta densidade populacional, considerando os índices de vulnerabilidade social. As definições específicas de ações ou projetos contemplados por território ocorre mediante demandas apresentadas anualmente por meio de editais. Os pagamentos são realizados em duas parcelas, sendo 60% na primeira e 40% na segunda parcela. Para a modalidade I o valor destinado para cada projeto é de no máximo R$ 30.000,00 (trinta mil reais) e na modalidade II o valor destinado para cada projeto é de no máximo R$ 60.000,00 (sessenta mil reais) reajustados anualmente conforme o IPCA. É importante potencializar a articulação dos grupos fomentados pelo programa VAI com a rede de equipamentos culturais (públicos e não públicos), atores e iniciativas culturais do entorno. A meta é partir de 175 apoios concedidos em 2013 para 500 projetos apoiados nos anos de 2014, 2015 e 2016.	Programa VAI: tem por finalidade apoiar financeiramente, por meio de subsídio, atividades artístico-culturais de pessoas físicas de baixa renda,\ncom faixa etária de 18 a 29 anos, oriundas de regiões do Município desprovidas de recursos e equipamentos culturais.\nPrograma VAI 2: terá por finalidade apoiar financeiramente, por meio de subsídio, atividades artístico-culturais de grupos e coletivos mais\nconsolidados, cujo escopo das atividades não permite mais seu enquadramento dentro do VAI. Os editais são anuais e o período de realização dos projetos contemplados pelo VAI são de no máximo 12 meses.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:45.641557	\N	\N	\N	\N	\N	\N	\N	\N	\N	25392425	\N	\N	sp-mais-inclusiva, historia-africa, juventude-viva	4
35	Obter terrenos, projetar, licitar, licenciar, garantir a fonte de financiamento e produzir 55 mil unidades habitacionais	55 mil Unidades prontas para o uso em Conjuntos Habitacionais de Interesse Social (HIS)	Engloba a desapropriação de terrenos, a construção de unidades e a entrega destas às famílias demandantes, tendo como algumas das diretrizes de priorização o recorte de gênero, idade (5% para idosos) e a presença de pessoas com deficiência na família. Além dessas diretrizes gerais, o planejamento prevê 2.000 unidades habitacionais para famílias em situação de rua, conforme explicado em meta específica sobre o tema. Para garantir a entrega de 55.000 Unidades Habitacionais no prazo do Programa de Metas, é necessário a elaboração e execução de projetos para além da meta estabelecida, de forma a se antecipar a eventuais imprevistos. Por esse motivo, a regionalização que aqui se apresenta é superior ao quantitativo da meta.	Unidades Habitacionais de Interesse Social: unidades habitacionais definidas pelo inciso XIII do Art. 146 da Lei nº 13.430/02 (PDE) construídas em terrenos desapropriados ou em áreas públicas desafetadas.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:53.114507	\N	\N	\N	\N	\N	\N	\N	\N	\N	1072880200	\N	\N	agenda-pop-rua, sp-mais-inclusiva, braços abertos	5
36	Beneficiar 70 mil famílias no Programa de Urbanização de Favelas	Assentamentos dotados de infraestrutura, tendo sido eliminadas todas as áreas de risco	Engloba a implantação de infraestrutura urbana nos assentamentos precários, possibilitando o acesso dos moradores aos serviços urbanos, a consolidação geotécnica e/ou remoções em áreas de risco. A regionalização aqui descrita é parcial. Outras 20.000 famílias serão beneficiadas em locais ainda a definir.	Programa Urbanização de Favelas: Qualificação urbanística e o reconhecimento formal dos assentamentos precários e/ou informais, garantindo a melhoria da qualidade de vida da população moradora.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:55.06126	\N	\N	\N	\N	\N	\N	\N	\N	\N	552047438	\N	\N	\N	5
37	Beneficiar 200 mil famílias no Programa de Regularização Fundiária	Títulos de posse ou de propriedade e emissão de autos de regularização	O Programa engloba o diagnóstico fundiário, levantamentos topográficos, projetos de regularização fundiária, cadastramento e coleta de documentação. Para garantir a entrega de 200.000 Unidades Habitacionais no prazo do Programa de Metas, é necessário a elaboração e execução de projetos para além da meta estabelecida, de forma a se antecipar a eventuais imprevistos. Por esse motivo, a regionalização que aqui se apresenta é superior ao quantitativo da meta.	Regularização Fundiária: Reconhecimento formal dos assentamentos precários e/ou informais, garantindo a segurança na posse da população moradora.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:57.421334	\N	\N	\N	\N	\N	\N	\N	\N	\N	258807703	\N	\N	\N	5
38	Ampliar o efetivo da Guarda Civil Metropolitana em 2.000 novos integrantes	Realização de concurso de ingresso e tomada de posse de 2.000 novos guardas civis municipais	A ampliação do efetivo será acompanhada das diretrizes de formação em Direitos Humanos e mediação de conflitos.		\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:57.999917	\N	\N	\N	\N	\N	\N	\N	\N	\N	24000000	\N	\N	\N	6
39	Capacitar 6.000 agentes da Guarda Civil Metropolitana em Direitos Humanos e 2.000 em Mediação de Conflitos	6.000 GCMs capacitados em Direitos Humanos e  2.000 GCMs capacitados em Mediação de Conflitos	A meta visa aprimorar a capacitação continuada dos Guardas Civis Metropolitanos, através do Centro de Formação em Segurança Urbana, mediante curso de reciclagem profissional com foco na formação em Direitos Humanos para o policiamento comunitário, inclusive para 2.000 novos GCMs para a capacitação em Mediação de Conflitos. Será constituído um grupo mobilizador estratégico para planejar sistematicamente todas as ações. Serão formados 250 agentes para que atuem como multiplicadores perante toda a GCM. A partir do trabalho do grupo mobilizador, dos educadores já formados e de organizações parceiras, toda a Guarda Municipal será capacitada através do Estágio de Qualificação Profissional. Espera-se com isso promover uma cultura de valorização profissional, a diminuição dos confrontos entre GCM e a população e a institucionalização da educação em Direitos Humanos no sistema de segurança urbana, para atuação em todo o território do município. Todos os cursos serão disponibilizados mediante parceria da Prefeitura junto às Secretarias Nacionais de Segurança Pública e Reforma do Judiciário, do Ministério da Justiça. Haverá também um Acordo de Cooperação junto à Escola Nacional de Mediação - ENAM. A meta será executada diretamente com recursos dos parceiros.	Mediação de Conflitos: é um processo autocompositivo segundo o qual as partes em disputa são auxiliadas por uma terceira parte, neutra ao conflito, sem interesse na causa,para auxiliá-las a chegar a uma composição. Este terceiro, imparcial, facilitará a negociação entre pessoas em conflito, habilitando-as a melhor compreender suas posições e a encontrar soluções que se compatibilizem aos seus interesse e necessidades.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:58.162909	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	agenda-pop-rua, sp-mais-inclusiva, juventude-viva	6
40	Instalar 1 Casa da Mulher Brasileira em São Paulo	1 Casa da Mulher Brasileira em funcionamento	A Casa da Mulher Brasileira contará com Delegacia especializada de atendimento à Mulher; Juizado especializado de violência doméstica e familiar contra a Mulher; Promotoria pública especializada da Mulher; Defensoria pública especializada da Mulher; atendimento psicossocial; alojamento de passagem; brinquedoteca; orientação e direcionamento para programas de auxílio e promoção da autonomia, geração de trabalho, emprego e renda, bem como integração com os demais serviços da rede de saúde e socioassistencial. Todo o custo de implantação será de responsabilidade da Presidência da República.	Casa da Mulher Brasileira: Centro de Referência integrante do Programa Mulher, Viver sem Violência do governo federal, que reunirá serviços especializados de assistência à mulher em situação de violência.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:58.320436	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	sp-carinhosa, sp-mais-inclusiva	6
41	Instalar 1 Casa Abrigo e 1 Casa de Passagem para ampliar a capacidade de atendimento de proteção às mulheres vítimas de violência	1 Casa Abrigo e 1 Casa de Passagem	A Casa Abrigo garante a integridade física e psicológica de mulheres e de seus dependentes, com atendimento multidisciplinar que favorece o resgate da autoestima e a reconstrução da autonomia da mulher. A permanência neste local é temporária, até que a mulher reúna condições para retomar ocurso de sua vida. A Casa de Passagem tem por objetivo garantir a integridade física e emocional das mulheres, bem como realizar diagnóstico da situação da mulher para encaminhamentos necessários. A Casa Abrigo tem capacidade para atender 5 famílias. Pretende-se com a construção de uma nova casa, aumentar o número de famílias atendidas nessa modalidade de serviço. Além da Casa Abrigo, a Casa de Passagem complementará o serviço.	Casa Abrigo: serviço de acolhimento institucional de caráter sigiloso para garantia da defesa e da proteção de mulheres em situação de violência doméstica e sexual, que estejam sob grave ameaça ou risco iminente de morte.\nCasa de Passagem: serviço de acolhimento provisório de curta duração (até 15 dias), não sigiloso, para as mulheres em situação de violência doméstica e seus filhos e filhas, que não corram risco iminente de morte.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:58.488223	\N	\N	\N	\N	\N	\N	\N	\N	\N	7986065	\N	\N	sp-carinhosa	6
42	Reestruturar as Casas de Mediação nas 31 inspetorias regionais da Guarda Civil Metropolitana para promover a cultura de mediação e a solução pacífica de conflitos	Reestruturação das 31 casas de mediação já existentes nas Inspetorias regionais da GCM	A proposta das Casas de Mediação contribui para que a Guarda Civil Metropolitana fortaleça sua vocação comunitária e sua relação com a sociedade. As experiências das 31 casas já em funcionamento apresentam bons resultados e sua reestruturação implica em: requalificação dos mediadores em atividades e formação dos novos mediadores pela Escola Nacional de Mediação do Ministério da Justiça (ENAM/MJ); aparelhamento das casas de mediação; implementação de um sistema de monitoramento e avaliação dos serviços prestados. A formação dos líderes comunitários e a campanha ampliarão o alcance e a efetividade da mediação nas comunidades, promovendo uma cultura de resolução extrajudicial de conflitos.	Mediação de Conflitos: é um processo autocompositivo segundo o qual as partes em disputa são auxiliadas por uma terceira parte, neutra ao conflito, sem interesse na causa, para auxiliá-las a chegar a uma composição. Este terceiro, imparcial, facilitará a negociação entre pessoas em conflito,habilitando-as a melhor compreender suas posições e a encontrar soluções que se compatibilizem aos seus interesses e necessidades.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:59.31686	\N	\N	\N	\N	\N	\N	\N	\N	\N	380886	\N	\N	juventude-viva	6
43	Implementar as ações do Plano Juventude Viva como estratégia de prevenção à violência, ao racismo e à exclusão da juventude negra e de periferia	Campanhas de mobilização da Rede Juventude Viva realizadas,  1 Portal em funcionamento na internet, Guia de Políticas Públicas da Juventude publicado,  2 unidades da Estação Juventude implantadas,  Mapa da Juventude publicado, Projetos locais de prevenção da violência nos territórios prioritários fomentados por edital,  Projetos especiais para fortalecimento e qualificação do sistema socioeducativo, Diretrizes e territórios prioritários para um conjunto de ações transversais indicadas.	Informações sobre as entregas prevista nesta meta:\n%u2022 Campanhas de mobilização: as campanhas de mobilização serão realizadas por meio de eventos artísticos e esportivos, como shows, saraus, campeonatos de skate, além de campanhas publicitárias de televisão, internet e rádio contra a cultura de violência e pela prevenção da mortalidade da juventude negra e de periferia.\n%u2022 Portal: criação de um Portal que tenha uma linguagem menos formal, mais plural e interativa, com a predominância de imagens, vídeos, textos\ncurtos e notícias. O Portal deverá fazer uma interface com o Observatório Participativo da Secretaria Nacional da Juventude.\n%u2022 Guia de Políticas Públicas da Juventude: sistematiza as políticas públicas executadas no município que tem como público alvo os jovens, em nível\nmunicipal, estadual e federal.\n%u2022 Estação Juventude: a Estação Juventude é um programa do Governo Federal que tem como principal objetivo instaurar espaços públicos de atendimento à juventude visando facilitar o acesso a políticas públicas de jovens de 15 a 29 anos, além de criar redes para emancipação da juventude, em especial para jovens de territórios com dificuldades de garantia de acesso aos direitos.\n%u2022 Mapa da Juventude: pesquisa quantitativa sobre o perfil e a situação da juventude paulistana e pesquisa qualitativa sobre as expectativas e os hábitos da juventude paulistana.\n%u2022 Projetos Locais de prevenção da violência: a ação prevê selecionar, por meio de edital, projetos da sociedade civil que tenham como ações a prevenção da mortalidade da juventude negra e de periferia, combate ao racismo e desconstrução da cultura de violência.\n%u2022 Diretrizes e territórios prioritários para um conjunto de ações transversais nos territórios prioritários: o Plano será prioritariamente implementado nos territórios da cidade com maior número de jovens negros, maiores índices de homicício contra a juventude, menor IDH, menor número de equipamentos públicos e pior situação no Sistema Intramunicipal de Direitos Humanos SIM-DH. Além das ações previstas nesta Meta, outras secretarias priorizarão os territórios onde o Plano será implantado no desenvolvimento de suas metas: Secretaria Municipal de Educação (Mais Educação); Secretaria Municipal de Desenvolvimento, Trabalho e Empreendedorismo (PRONATEC e VAI-TEC), Secretaria Municipal de Cultura (Pontos de Cultura e VAI), Secretaria Municipal de Serviços (Pontos de Iluminação Pública e Wi-Fi), Secretaria Municipal de Segurança Urbana (Capacitação da GCM); Secretaria Municipal de Saúde (Núcleos de Prevenção de Violência) e Secretaria Municipal de Coordenação de Subprefeituras (Requalificação do espaço público e melhoria de bairro). Além destes programas e ações previstas no Programa de Metas, outras também serão incluídas no Plano Juventude Viva, como o Pro Jovem e o Bolsa Trabalho. O cronograma de entrega, bem como os custos de implantação dessas ações transversais estão descritos em suas respectivas Fichas de Identidade da meta.	Plano Juventude Viva: é uma iniciativa da Secretaria Geral da Presidência da República e da Secretaria de Promoção da Igualdade Racial e reúne ações de onze Ministérios e campanhas de prevenção que visam reduzir a vulnerabilidade dos jovens à situações de violência física e simbólica, a partir da criação de oportunidades de inclusão social e autonomia; da oferta de equipamentos, serviços públicos e espaços de convivência em territórios que concentram altos índices de homicídio; e do aprimoramento da atuação do Estado por meio do enfrentamento ao racismo institucional e da sensibilização de agentes públicos para o problema. Em São Paulo a municipalização do Plano estará a cargo de treze secretarias e será monitorado pelo Comitê Gestor Juventude Viva criado por Decreto 54.511 de 25/10/2013.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:59.696133	\N	\N	\N	\N	\N	\N	\N	\N	\N	33445244	\N	\N	SMS e SMPIR	6
44	Implementar 2 novos espaços de convivência e 8 novos serviço de proteção social a crianças e adolescentes vítimas de violência	8 novos Serviços de Proteção Social a crianças e adolescentes vítimas de violência, abuso e exploração sexual e 2 novos Espaços de Convivência para crianças e adolescentes em situação de risco social e pessoal.		Serviço de Proteção à criança e adolescente vítima de violência: (SPVV) serviço referenciado que oferece um conjunto de procedimentos técnicos especializados por meio do atendimento social e psicossocial para atendimento às crianças e aos adolescentes vítimas de violência doméstica, abuso ou exploração sexual, bem como aos seus familiares, proporcionando-lhes condições para o fortalecimento da auto-estima, superação da situação de violação de direitos e reparação da violência vivida. Espaços de convivência para crianças e adolescentes: (ECCA) serviço que visa acolher crianças e adolescentes em situação de vulnerabilidade social, oferecendo um espaço alternativo de sociabilidade entre a rua e o território de origem da família.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:16:59.915004	\N	\N	\N	\N	\N	\N	\N	\N	\N	13000000	\N	\N	sp-carinhosa, juventude-viva	6
45	Ampliar e modernizar 1 Centro Olímpico de Treinamento e Pesquisa e construir 1 Centro Olímpico de Iniciação e Formação 	1 Centro Olímpico de Treinamento e Pesquisa e 1 Centro Olímpico de Iniciação e Formação	Os terrenos que serão utilizados para a construção dos Centros são de administração da Secretaria Municipal de Esportes, Lazer e Recreação e atualmente são destinados para lazer e recreação.	Centro Olímpico de Treinamento e Pesquisa: Equipamento voltado ao esporte de alto rendimento, nos moldes de um clube, com foco em esportes olímpicos, tendo crianças e jovens participando das principais competições municipais, estaduais, nacionais e até internacionais, sem nenhum custo para atletas ou seus pais.\nCentro Olímpico de Iniciação e Formação: Equipamento que permite o treinamento de modalidades olímpicas em suas categorias de base/formação com recurso humanos compatíveis e metodologia utilizada pelo Centro Olímpico de Treinamento e Pesquisa.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:00.095245	\N	\N	\N	\N	\N	\N	\N	\N	\N	435335000	\N	\N	sp-mais-inclusiva	7
46	Criar 1 Parque de Esportes Radicais	1 Parque de Esportes Radicais no Parque Dom Pedro	O Parque de Esporte Radicais terá uma área de 30 mil m². A Secretaria Municipal de Direitos Humanos e Cidadania, por meio da Coordenadoria de Juventude, será parceira e articuladora do público-alvo para a execução da meta.	Parque de Esportes Radicais: Skate, BMX e Patins in line, nas modalidades Street, Park e Vertical, nos níveis de Lazer, Recreação e Alto Rendimento, além de um local para receber eventos relacionados.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:00.283387	\N	\N	\N	\N	\N	\N	\N	\N	\N	27000000	\N	\N	\N	7
48	Requalificar 50 equipamentos esportivos entre Centros Desportivos da Comunidade (CDC) e Clubes-Escola	50 equipamentos requalificados	Por requalificação entende-se reforma básica e, quando possível, implantação de novos serviços e/ou equipamentos na área a ser qualificada. Há um grupo intersecretarial formado para identificar os CDCs que poderiam passar pela requalificação e para definir a integração desse Centros com equipamentos de outras áreas, como educação ou saúde, por exemplo.	Clube Desportivo da Comunidade (CDC): unidades esportivas em terrenos municipais, mas de administração indireta. A gestão do espaço é feita por entidades da comunidade local com reconhecida vocação para o trabalho esportivo, legalmente constituídos em forma de associação comunitária ou eleitos pela própria população do bairro. São menores que os equipamentos diretamente administrados pela prefeitura.\nClube Escola: tem o objetivo de oferecer ao munícipe em idade escolar a oportunidade de participar das atividades esportivas, recreativas e de\nlazer, nos Clubes Esportivos Municipais.\nClubes Esportivos Municipais: estruturas públicas que oferecem diversas atividades para a saúde, bem-estar, lazer e recreação da população de todas as regiões de São Paulo.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:02.571259	\N	\N	\N	\N	\N	\N	\N	\N	\N	61060000	\N	\N	sp-carinhosa	7
49	Construir 5 Centros de Iniciação Esportiva - CIE	Construção de 5 Centros de Iniciação Esportiva (CIE)	Os CIEs são dimensionados em três modelos que se adaptam ao tamanho do terreno. MODELO I: Prevê a construção de ginásio poliesportivo com arquibancada para 195 pessoas e área de apoio com administração, vestiários, chuveiros, enfermaria, copa, depósito e academia (2.500 m²). MODELO II: Prevê a construção de ginásio poliesportivo com arquibancada para 195 pessoas, área de apoio com administração, vestiários, chuveiros, enfermaria, copa, depósito e academia e arena poliesportiva externa (3.500 m²). MODELO III: Prevê a construção de ginásio poliesportivo com arquibancada para 195 pessoas, área de apoio com administração, vestiários, chuveiros, enfermaria, copa, depósito e academia e complexo de atletismo (7.000 m²).	CIE: O CIEs são instalações públicas multiesportivas para crianças e jovens inciarem a prática de modalidades olímpicas e paraolímpicas, localizado em áreas de vulnerabilidade social, voltados à iniciação esportiva e ao esporte de alto rendimento, estimulando a detecção de talentos e a formação de atletas.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:02.9509	\N	\N	\N	\N	\N	\N	\N	\N	\N	15870000	\N	\N	sp-carinhosa, sp-mais-inclusiva, juventude-viva	7
50	Tornar acessíveis 850 mil m² de passeios públicos	850 mil m2 de passeio público acessíveis pelos Programas Caminho Seguro e Rotas Turísticas	Padronização e readequação de passeios públicos em vias estruturais, em rotas estratégicas e diante de prédios municipais, com adequações em acessibilidade e um conjunto de intervenções: implantação de rampas, colocação de piso tátil, e outras medidas, implementando novo conceito de passeio público, organizando a localização do mobiliário urbano, garantindo livre circulação de pedestre e pessoas com deficiência ou mobilidade reduzida. A execução do serviço seguirá os padrões estabelecidos pela Portaria Intersecretarial 04/SMSP/SMPED publicada em 06/2008 que estabelece diretrizes executivas para passeios públicos em concreto moldado "in loco".	Acessibilidade: Condição para utilização, com segurança e autonomia, total ou assistida, dos espaços mobiliários e equipamentos urbanos, das edificações, dos serviços de transportes e dispositivos, sistemas e meios de comunicação e informação, por pessoa com deficiência ou mobilidade reduzida.\nCaminho Seguro: Percurso segregado da via destinado a circulação de pedestres de forma a permitir seu deslocamento com segurança e autonomia, inclusive para pessoas com deficiência e mobilidade reduzida.\nRotas Turísticas: Caminho seguro no entorno de pontos turísticos.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:03.241099	\N	\N	\N	\N	\N	\N	\N	\N	\N	167070000	\N	\N	sp-mais-inclusiva	8
51	Garantir a acessibilidade para pessoas com mobilidade reduzida em 100% da frota de ônibus	%u2022 Ônibus com plataforma elevatória ou veículo de piso baixo com acesso por rampa e dispositivo de sinalização sonora, tátil e visual.	Renovação da frota de ônibus realizada pela empresa contratada mediante as regras estabelecidas em contrato (pela gestora SPTrans). Todo veículo novo obrigatoriamente deve ser acessível.\n* Meta viabilizada por meio do contrato de concessão do sistema municipal de transporte.	Frota Acessível: ônibus com acesso para as pessoas com mobilidade reduzida, em duas modalidades - veículos com piso baixo e rampa de acesso ou com plataforma elevatória (e.g. "elevador" para veículos com degraus de acesso) e com sinalização sonora, tátil e visual para acesso de pessoas com deficiência visual e auditiva.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:03.515762	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	sp-mais-inclusiva	8
52	Garantir a oferta de vagas a todas as crianças beneficiárias do Benefício de Prestação Continuada da Assistência Social (BPC) e seu acompanhamento nos moldes do BPC Escola	Vagas garantidas e acompanhamento das crianças beneficiárias do BPC	Programa BPC na Escola tem quatro eixos principais: 1) identificar, entre os beneficiários do BPC até 18 anos, aqueles que estão na escola e aqueles que estão fora da escola; 2) identificar as principais barreiras para o acesso e a permanência na  escola das pessoas com deficiência beneficiárias do BPC; 3) desenvolver estudos e estratégias conjuntas para superação dessas barreiras; e 4) manter acompanhamento sistemático das ações e programas dos entes federados que aderirem ao programa. A meta é garantir vagas para crianças de 0 a 5 anos (dentro da governabilidade do município) e garantir o acompanhamento em todas as idades (0 a 18) pela ação intersetorial - Educação, Assistência Social, Saúde e Direitos Humanos. O Programa BPC na Escola é uma das ações previstas no Plano Nacional dos Direitos da Pessoas com Deficiência - Plano Viiver sem Limite, pactuado entre a Prefeitura de São Paulo e Governo Federal no dia 19 de Abril de 2013.	BPC: Benefício da Política de Assistência Social que garante o pagamento de 1 salário mínimo a todas as pessoas com deficiência (em qualquer idade).\nBPC na Escola: tem como objetivo desenvolver ações intersetoriais, visando garantir o acesso e a permanência na escola de crianças e adolescentes com deficiência, de 0 a 18 anos, beneficiários do BPC.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:03.69604	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	sp-carinhosa, sp-mais-inclusiva	8
53	Efetivar o funcionamento da Central de Libras 	Central de Libras em funcionamento.	O atendimento deverá ser 24 horas e direcionado às pessoas surdas ou com deficiência auditiva e surdocegas, conforme estabelecido pela Lei 14.441/07. A Central atenderá toda a cidade e deverá proporcionar a comunicação dos munícipes surdos ou com deficiência auditiva e surdocegos nos serviços municipais a partir de modalidade presencial e virtual.	Tradução /Interpretação da Libras/Português: Serviço de mediação entre surdo ou com deficiência auditiva, usuário da Libras e o atendente do órgão público.\nGuia-Interpretação: Fornecimento de Guia-Intérprete para atendimento presencial ao munícipe surdocego nos serviços municipais	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:03.888822	\N	\N	\N	\N	\N	\N	\N	\N	\N	24500000	\N	\N	sp-mais-inclusiva	8
54	Revitalizar os Centros de Formação e Acompanhamento à Inclusão (CEFAI) ampliando a oferta de vagas para crianças com necessidades especiais	13 CEFAIs revitalizados	A ação de revitalização prevê a modernização dos equipamentos, atualização do acervo bibliográfico, produção e aquisição de novos materiais, ações de formação continuada dos professores, desenvolvimento de técnicas para o acompanhamento e supervisão do trabalho realizado nas Salas de Apoio e Acompanhamento à Inclusão.	CEFAI: Centros de formação e Acompanhamento a Inclusão - é responsável por desenvolver ações de formação e projetos, produzir materiais, orientar e supervisionar as Salas de Apoio e Acompanhamento à Inclusão (SAAI), além de dispor de acervo bibliográfico e de disponibilizar equipamentos específicos para alunos com necessidades educacionais especiais.\nSAAI: Sala de Apoio e Acompanhamento à Inclusão - atende a alunos com necessidades educacionais que podem ou não se relacionar com deficiências, limitações ou disfunções no processo desenvolvimento, assim como com situação de superdotação ou altas habilidades. Este espaço se constitui como um serviço de apoio pedagógico especializado, desenvolvido por professores especializados. A Unidade Educacional é quem requisita a instalação desta sala e disponibiliza o serviço para os alunos da própria escola ou de outras Unidades da Rede Municipal de Ensino de seu entorno, onde não exista tal atendimento.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:04.454345	\N	\N	\N	\N	\N	\N	\N	\N	\N	1820000	\N	\N	sp-carinhosa, sp-mais-inclusiva	8
55	Implantação de 10 residências inclusivas para pessoas com deficiência	10 Residências inclusivas em funcionamento	O público-alvo do Serviço de Acolhimento Institucional em Residência Inclusiva são jovens e adultos com deficiência, em situação de dependência, prioritariamente aqueles atendidos pelo Benefício de Prestação Continuada - BPC, que não disponham de condições de autossustentabilidade ou de retaguarda familiar e/ou que estejam em processo de desinstitucionalização de instituições de longa permanência.	Residência Inclusiva: unidade que oferta Serviço de Acolhimento Institucional, no âmbito da Proteção Social Especial de Alta Complexidade do SUAS, conforme estabelece a Tipificação Nacional dos Serviços Socioassistenciais.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:04.773603	\N	\N	\N	\N	\N	\N	\N	\N	\N	2800000	\N	\N	sp-mais-inclusiva	8
56	Implantação de 5 Centros Especializados de Reabilitação (CER) 	05 CER em funcionamento, com quatro modalidades de reabilitação: Auditiva, Física, Intelectual e Visual		Centro Especializado de Reabilitação: serviço de atendimento de pacientes, em todas as faixas etárias, que necessitam de tratamento especializado em reabilitação, diagnóstico, avaliação e orientação, dentro de uma estrutura adequada à sua condição física e mental.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:05.221653	\N	\N	\N	\N	\N	\N	\N	\N	\N	60420000	\N	\N	sp-mais-inclusiva	8
57	Criar e efetivar a Secretaria Municipal de Promoção da Igualdade Racial	Secretaria instituída e em funcionamento	A implementação da Secretaria tornará possível a institucionalização das politicas de promoção da igualdade racial tendo como instrumento o Plano Municipal da Igualdade Racial do município de São Paulo.		\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:05.446577	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	historia-africa	9
58	Viabilizar a implementação das Leis Federais 10.639/2003 e 11.645/2008 que incluem no currículo oficial da rede de ensino a temática da História e Cultura Afro-Brasileira e Indígena	Professores da Rede Municipal de Ensino formados	A capacitação deverá atender os profissionais da educação inicialmente nas Diretorias Regionais de Ensino onde há uma maior concentração de população negra ou indígena.	Leis Federais 10.639/2003 e 11.645/2008: Leis que incluíram no currículo oficial da rede de ensino a obrigatoriedade da temática da História e Cultura Afro-Brasileira e Indígena.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:05.703775	\N	\N	\N	\N	\N	\N	\N	\N	\N	3000000	\N	\N	historia-africa	9
59	Criar e efetivar a Secretaria Municipal de Políticas Para as Mulheres	Secretaria instituída e em funcionamento	Construir o projeto de lei, através da elaboração do organograma, da exposição de motivos e da minuta do projeto, que irá propor a criação da Secretaria Municipal de Políticas para as Mulheres para a Câmara dos Vereadores.		\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:05.911751	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	9
60	Reestruturar os 5 Centros de Cidadania da Mulher, redefinindo suas diretrizes de atuação	5 Centros de Cidadania da Mulher reestruturados	A reestruturação consiste em reformular as atividades realizadas no espaço, formar e capacitar as gestoras para que os Centros cumpram a proposta de favorecer o processo de reflexão coletiva sobre a situação e a condição das mulheres com vistas a estimular a análise e o debate sobre a desigualdade entre os gêneros e os caminhos para a sua superação, através do empoderamento e da construção da autonomia das mulheres.\nPretende-se, com isso, que estes Centros sejam espaços, primordialmente, que desenvolvam, implementem e apoiem programas e projetos voltados à construção da autonomia econômica das mulheres, inclusive em áreas que não são consideradas tradicionalmente femininas.	Centros de Cidadania da Mulher (CCM): equipamento público que se constitui como espaço de qualificação e formação da cidadania ativa, no qual as mulheres podem se organizar para defender seus direitos sociais, econômicos e culturais, propor e participar de ações e projetos que estimulem a implementação de políticas de igualdade e potencializar, por meio do controle social, os serviços públicos existentes, de tal modo a atender a suas necessidades e da sua comunidade, com vistas a superação das desigualdades de gênero.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:06.215924	\N	\N	\N	\N	\N	\N	\N	\N	\N	1115707	\N	\N	juventude-viva	9
61	Desenvolver ações permanentes de combate à homofobia e respeito à diversidade sexual	Campanha de mobilização contra a homofobia e respeito à diversidade sexual: conjunto de ações que compreende a produção e distribuição de diversos materiais como panfletos, pequenos cartões, cartazes, broches, camisetas, spots de rádio, peças de audiovisual para TV e filmetes para internet, Atividades culturais no Largo do Arouche e República, Atividades de formação continuada na rede municipal de ensino pela convivência pacífica com as diferenças, 17ª, 18ª, 19ª e 20ª Paradas do Orgulho LGBT, Ações de integração social e econômica para travestis e transexuais , 5 Centros de Combate à Homofobia em funcionamento , 5 Unidades de atendimento móvel com equipe e materiais de orientação sobre direitos e políticas públicas.	A meta envolve um conjunto articulado de entregas que se complementam. As campanhas de mobilização atuarão diretamente no combate à homofobia, promovendo o respeito à livre orientação sexual e identidade de gênero. As atividades de formação buscam combater o bullying homofóbico e a evasão escolar da população LGBT. A Parada do Orgulho LGBT de São Paulo é o maior evento desse tipo, em todo o mundo. É uma manifestação da sociedade civil, organizada pela Associação da Parada do Orgulho LGBT (APOGLBT), porém apoiada pela Prefeitura Municipal de São Paulo, por ser uma legítima manifestação democrática e de afirmação dos direitos humanos. Com a criação dos 4 novos Centros de Combate à Homofobia e a reformulação do já existente na região central, pretende-se criar uma rede de proteção às vitimas de violência homofóbica. As unidades móveis atuarão como porta de entrada para a rede de proteção às vitimas de violência homofóbica nos locais de convívio da população LGBT , aproximando os serviços públicos municipais da comunidade. O Largo do Arouche, por sua vez, é um reduto histórico da comunidade LGBT desde os anos 30 e carece de revitalização e incentivo à ocupação do espaço pela cidadania.	Diversidade Sexual: designa as várias formas de expressão da sexualidade humana\nHomofobia: ódio ou aversão que gera discriminação e/ou violência contra pessoas lésbicas, gays, bissexuais, travestis e transexuais (LGBT)	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:06.596294	\N	\N	\N	\N	\N	\N	\N	\N	\N	19664928	\N	\N	\N	9
84	Concluir as fases II e III do Programa de Mananciais beneficiando 70 mil famílias	Assentamentos saneados dotados de infraestrutura, tendo sido eliminadas todas as áreas de risco.	Engloba a implantação de infraestrutura urbana nos assentamentos precários, possibilitando o acesso dos moradores aos serviços urbanos, a consolidação geotécnica e/ ou remoções em áreas de risco. A regionalização aqui descrita é parcial. Outras 20.000 famílias serão beneficiadas em locais ainda a definir.	Programa de Mananciais: Qualificação urbanística e o reconhecimento formal dos assentamentos precários e/ou informais, garantindo a melhoria da qualidade de vida da população moradora em áreas de mananciais.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:19.506538	\N	\N	\N	\N	\N	\N	\N	\N	\N	3533268058	\N	\N	\N	14
62	Implantar a Ouvidoria Municipal de Direitos Humanos	Ouvidoria em funcionamento, que contará com: Serviço de atendimento presencial com equipe interdisciplinar (advogados, assistentes sociais e psicólogos), serviço telefônico gratuito.	A Ouvidoria fará conexão com a Ouvidoria Nacional dos Direitos Humanos, vinculada à Secretaria de Direitos Humanos da Presidência da República, e será o interlocutor do Disque 100 em âmbito local.\nPor meio destes serviços, fará o recebimento e registro de violações a direitos humanos, orientações e encaminhamentos, assim como o monitoramento das violações. As informações da Ouvidoria poderão subsidiar a base do Centro de Informações em Direitos Humanos, relatórios e estudos para o fortalecimento das políticas públicas no município. O serviço Disque 100 fará o encaminhamento das denúncias lá recebidas. Com base nesta parceria será desenvolvido um sistema informatizado de encaminhamento de denúncias na Ouvidoria municipal, que se dará a partir de módulos temáticos de tipos de violações de direitos, por exemplo, contra crianças e adolescentes, população LGBT, idosos, denúncias de tortura e racismo.	Ouvidoria de Direitos Humanos: canal de atendimento direto à população para recebimento de denúncias sobre violações aos direitos humanos e encaminhamento à rede de garantia de direitos	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:06.821318	\N	\N	\N	\N	\N	\N	\N	\N	\N	945418	\N	\N	\N	9
63	Implementar a Educação em Direitos Humanos na rede municipal de ensino	6.000 profissionais de educação formados (aproximadamente 10% do total), Guia de orientação escolar e 4 cadernos temáticos sobre EDH produzidos e distribuídos para as escolas, Prêmio Municipal de EDH, 4 Centros de Educação em Direitos Humanos em CEUs	Por meio das entregas mencionadas, pretende-se que as escolas da rede municipal insiram EDH em seu Projeto Político-Pedagógico e efetivamente trabalhem as questões de Direitos Humanos junto a toda a comunidade escolar.\nAs formações serão oferecidas na modalidade Ensino à Distância - EaD por meio de parceria com o Ministério da Educação e universidades federais. Será feita ampla divulgação para toda a rede municipal e a adesão dos participantes será voluntária. As escolas formarão grupos de trabalho compostos por professores, funcionários e gestores.\nTambém serão produzidos um guia escolar e quatro cadernos temáticos para serem utilizados em escolas. Os materiais didáticos têm como proposta abordar as diversas formas de discriminação e violência existentes no cotidiano escolar, contribuindo para que os profissionais de educação trabalhem estes temas de forma efetiva.\nO Prêmio Municipal de EDH tem como objetivo dar visibilidade e valorizar as iniciativas e boas práticas desenvolvidas na rede. Realizado anualmente, contribuirá para o desenvolvimento de novas iniciativas e a disseminação das experiências bem sucedidas.\nPor fim, serão implantados 4 %u201CCentros de Educação em Direitos Humanos%u201D em CEUs, criando pólos de irradiação de conhecimento, material didático, pesquisa, articulação comunitária e promoção da cultura dos Direitos Humanos na rede municipal de ensino. Os custos iniciais de implementação e manutenção serão viabilizados por convênio com a Secretaria de Direitos Humanos da Presidência da República, aproveitando-se a infraestrutura já existente dos CEUs.	Educação em Direitos Humanos (EDH): promove a formação para a cidadania e a democracia, através do conhecimento e do exercício de direitos.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:07.203346	\N	\N	\N	\N	\N	\N	\N	\N	\N	2796442	\N	\N	\N	9
64	Criar a Comissão da Verdade, da Memória e da Justiça no âmbito do Executivo municipal	Comissão criada e em funcionamento, Construção de, ao menos, 4 sítios de memória nos Cemitérios do Araçá, Perus e Vila Formosa e no Parque do Ibirapuera, Apoio técnico para identificação dos restos mortais de desaparecidos políticos, Ações de educação e cultura pelo direito à memória e à verdade apoiados.	Os trabalhos da Comissão da Memória e Verdade da Prefeitura Municipal de São Paulo, em colaboração com as demais comissões da verdade com atuação no muncípio, deverão contribuir para a) o esclarecimento sobre casos de graves violações de direitos humanos ocorridas no município; b) a identificação de corpos e restos mortais de desaparecidos políticos; c) o levantamento de informações sobre esse período ocorridas na cidade de São Paulo; d) adoção de medidas e políticas públicas de educação e cultura para prevenir violação de direitos humanos, assegurar sua não repetição e promover a efetiva reconciliação. Um dos trabalhos esperados é a nominação de escolas, bibliotecas, praças, parques e vias públicas, homenageando mortos e desaparecidos políticos durante a Ditadura Militar (conforme previsto pela Lei municipal n. 15.717/2013).	Comissão da Verdade: tem como objetivo examinar e esclarecer as graves violações de direitos humanos praticadas no município de São Paulo no período de 1964 a 1988, a fim de efetivar o direito à memória e à verdade histórica, à luz da Comissão Nacional da Verdade, instituída pela Lei Federal 12.528/2011\nSítios de memória: são locais que estiveram de alguma forma relacionados às violações de direitos humanos ocorridas durante o período militar ou locais simbólicos escolhidos para prestar homenagens aos mortos e desaparecidos durante esse período. Nesses lugares serão construídos memoriais para resgatar e registrar esses fatos, entre os quais monumentos, centros de reflexão, placas de identificação, entre outros.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:07.573986	\N	\N	\N	\N	\N	\N	\N	\N	\N	2967535	\N	\N	\N	9
65	Criar e implantar a Política Municipal para Migrantes e de Combate à Xenofobia	Regularização das feiras culturais da Rua Coimbra (Mooca) e do Rosário (Penha), reconhecidas como verdadeiro patrimônio cultural contemporâneo de São Paulo e inclusão da Feira de Alasita no Calendário festivo da Cidade, Curso permanente de português para migrantes, Mapeamento da população migrante, Cursos de qualificação de agentes públicos para atenção ao migrante, Campanha permanente de conscientização da população e prevenção à xenofobia, com foco na promoção dos direitos dos migrantes.	O conjunto articulado de ações ora proposto busca dar conta do problema histórico da falta de atenção aos migrantes por parte do poder público. A regularização das feiras da Rua Coimbra e do Largo do Rosário serão realizadas por meio do diálogo com todos os setores envolvidos, para que os migrantes possam legalmente desenvolver atividades econômicas e auferir renda. A regularização também vai ao encontro da política da atual gestão de apoiar e reconhecer como verdadeiro patrimônio cultural contemporâneo de São Paulo as feiras e espaços abertos de convivência que os migrantes vêm criando e fortalecendo ao longo dos anos.\nAlém das entregas acima mencionadas, outras ações em apoio à essa população serão realizadas, com destaque para a primeira Conferência Municipal de Migrantes e a construção de um Centro Cultural da Migração, que servirá como um espaço para a difusão de suas tradições, e também como local de referência tanto para estas comunidades quanto para os brasileiros natos (os custos e entregas dessas ações estão descritas em suas respectivas metas e orçamentos próprios).	Migrante: é toda a pessoa que se transfere de seu lugar habitual de residência para outro lugar, região ou país.\nXenofobia: preconceito que engendra discriminação e/ou violência contra pessoas migrantes principalmente em razão de sua origem territorial diversa.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:07.993886	\N	\N	\N	\N	\N	\N	\N	\N	\N	2474435	\N	\N	Apoio à Festa Nacional da Bolívia no Mamorial da América Latina	9
66	Fortalecer os Conselhos Tutelares, dotando-os de infraestrutura adequada e oferecendo política permanente de formação	Infraestrutura básica para o funcionamento do Conselho Tutelar, buscando adequá-los ao que preconiza a Resolução n. 139 do Conselho Nacional dos Direitos da Criança e do Adolescente - CONANDA, Capacitação de 440 conselheiros (atuais e os eleitos em 2014), Novo Conselho Tutelar modelo em Itaquera.	O objetivo dessa meta é garantir infraestrutura mínima e padronizada aos Conselhos Tutelares e uma política permanente de formação para melhorar seu funcionamento, com vistas à garantia integral dos direitos da criança e do adolescente e suas famílias. Como "infraestrutura mínima" entende-se adequar os Conselhos Tutelares da cidade de São Paulo ao que preconiza a Resolução n. 139 do Conselho Nacional dos Direitos da Criança e do Adolescente - CONANDA. Parte desta será fornecida por meio de kits de equipagem doados pela Secretaria de Direitos Humanos da Presidência da República SDH/PR. A legislação municipal de garantia de direitos trabalhistas e sociais será baseada no que preconiza a lei federal n. 12.696/12. A política de formação permanente também será estruturada a partir de parceria com a SDH/PR por meio da Escola Nacional de Formação Continuada de Conselheiros/as de Direitos e Conselheiros (as) Tutelares. Por fim, o Conselho modelo de Itaquera será a 1ª iniciativa de uma série de mudanças propostas pela SDH/PR que visam consolidar o Sistema de Garantia de Direitos de Crianças e Adolescentes e constituir-se-á em um dos legados da Copa do Mundo de 2014, contribuindo para o fortalecimento da rede de conselhos tutelares na cidade. Os recursos para a construção do novo Conselho serão disponibilizados pelo governo federal mediante convênio a ser assinado junto à Prefeitura de São Paulo.	Conselho Tutelar: Conforme previsão do Estatuto da Criança e do Adolescente, é órgão permanente e autônomo, não jurisdicional, encarregado pela sociedade de zelar pelo cumprimento dos direitos da criança e do adolescente. Entre suas atribuições estão: atender as crianças e adolescentes visando a aplicação de medidas específicas de proteção, atender e aconselhar pais ou responsáveis, requisitar serviços públicos nas áreas de saúde, educação, serviço social, previdência, trabalho e segurança e encaminhar ao Ministério Público notícia de fato contra os direitos da criança ou adolescente.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:08.276665	\N	\N	\N	\N	\N	\N	\N	\N	\N	1500000	\N	\N	sp-carinhosa, sp-mais-inclusiva	9
67	Implantar 08 novas Unidades de Referência à Saúde do Idoso (URSI)	Unidade de Referência à Saúde do Idoso em funcionamento	As Unidades de Referência à Saúde do Idoso vem de encontro à necessidade de respostas efetivas às demandas da população idosa e estão inseridas na atenção à saúde do segmento idoso, da Política Municipal e Nacional do Idoso e nas recomendações de organismos internacionais.	Unidade de Referência à Saúde do Idoso: unidade especializada para atender à pessoa idosa na sua área de abrangência. Insere-se no nível secundário da atenção à saúde, oferecendo atendimento por equipe especializada de gerontologia e geriatria e interprofissional, com visão integral em âmbito individual e coletivo; desenvolve ações preventivas e de promoção e proteção à saúde, atividades de treinamento e capacitação de profissionais da atenção básica e pesquisas específicas na área da gerontologia.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:08.726227	\N	\N	\N	\N	\N	\N	\N	\N	\N	6400000	\N	\N	\N	10
68	Implantar 15 Centros Dia destinados à população idosa	15 Centros Dia em funcionamento	O atendimento também pode incluir a elaboração de um Plano Individual e/ou Familiar de Atendimento, orientação e apoio nos autocuidados; apoio ao desenvolvimento do convívio familiar, grupal e social; identificação e fortalecimento de redes comunitárias de apoio; ajudas técnicas de autonomia no serviço, no domicílio, e na comunidade; apoio e orientação aos cuidadores familiares com vistas a favorecer a autonomia da dupla pessoa cuidada e cuidador familiar.\nO Centro Dia é um serviço que ainda não tem as orientações técnicas elaboradas pelo MDS, que são necessárias para o seu funcionamento. Assim também não é um serviço tipificado, portanto para sua implantação será necessário a apresentação e aprovação do COMAS-Conselho Municipal de Assistência Social.	Centro Dia: equipamento social destinado à atenção diurna de pessoas idosas em situação de dependência, em que uma equipe multidisciplinar presta serviço de proteção social especial e de cuidados pessoais, fortalecimento de vínculos, autonomia e inclusão social, por meio de ações de acolhida, escuta, informação e orientação.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:09.344771	\N	\N	\N	\N	\N	\N	\N	\N	\N	4650000	\N	\N	\N	10
69	Desenvolver campanha de conscientização sobre a violência contra a pessoa idosa	4 campanhas de conscientização da violência contra a pessoa idosa, Seminários anuais de conscientização da violência contra a pessoa idosa.	A violência contra a pessoa idosa é crime. Diariamente esta população se depara com a violência em todas as instâncias e espaços de convivência da cidade - na família, nas ruas, nos serviços públicos e privados. Ela tem dificuldade de encontrar suporte para dar uma resposta a esta situação e, com frequência, se cala. Diversos são os tipos de violência contra a pessoa idosa: física, psicológica, sexual, emocional e social, abandono, negligência, financeira ou econômica e auto-negligência.\nEsta meta tem como objetivo fortalecer a luta pelos direitos da pessoa idosa, evidenciar os principais aspectos da violência no município e divulgar os meios de denúncia disponíveis. As campanhas de mídia convidam ao diálogo, à reflexão e ao debate, incentivando a participação intergeracional da sociedade, além de integrar e fortalecer as ações de enfrentamento a todo tipo de agressão. A conscientização sobre a violência contra a pessoa idosa deverá contribuir sensivelmente para a construção de uma cidade do futuro, uma cidade melhor e mais acolhedora para a pessoa que envelhece.	Campanha de conscientização da violência contra a pessoa idosa: conjunto de ações que compreende a produção e distribuição periódica de diversos materiais como panfletos, cartazes, spots de radio e peças de audiovisual.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:09.635122	\N	\N	\N	\N	\N	\N	\N	\N	\N	480000	\N	\N	\N	10
70	Implantar 5 unidades de Instituições de Longa Permanência do Idoso - ILPI	5 ILPIs em funcionamento	Deve funcionar em unidade inserida na comunidade, com características residenciais e estrutura física adequada, visando o desenvolvimento de relações mais próximas do ambiente familiar e a interação social com pessoas da comunidade. As edificações devem ser organizadas de forma a atender aos requisitos previstos na regulamentação pertinente.	fdsa	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:09.994232	\N	\N	\N	\N	\N	\N	\N	\N	\N	1550000	\N	\N	\N	10
71	Criar a Universidade Aberta da Pessoa Idosa do Município	Cursos gratuitos com grade curricular diversificada destinados à população idosa e servidores públicos que trabalham com esta população.	Os cursos visam à promoção da saúde da pessoa idosa, oferecendo subsídios teóricos para a análise das bases conceituais que fundamentam o processo de envelhecimento humano individual e populacional e a sua inter-relação com as áreas da saúde, sociologia, artes, educação física e assistência social. Os primeiros cursos terão a duração de um ano e serão compostos por 19 professores especialistas convidados que ministrarão aulas teóricas e práticas em áreas do conhecimento como: gerontologia, biologia do envelhecimento, enfermagem, segurança alimentar, fisioterapia, educação física, história, artes (história da arte e artes plásticas), teatro e fotografia. A UAPI estará sediada no Pólo do Idoso, localizado no bairro do Cambuci e terá cursos ministrados em outros equipamentos públicos do município nos bairros do Cambuci, Brasilândia, Raposo Tavares e Sapopemba.	Universidade Aberta da Pessoa Idosa - UAPI: conjunto de cursos que visam à promoção da saúde e conscientização do processo do envelhecimento entre a população idosa e servidores públicos que trabalham com esta temática	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:10.279929	\N	\N	\N	\N	\N	\N	\N	\N	\N	3107525	\N	\N	\N	10
72	Requalificar a infraestrutura e os espaços públicos do Centro	Espaços de convivência, de caráter multiuso	Requalificar espaço público de uma centralidade urbana. A secretaria Municipal de Direitos Humanos e Cidadania, por meio de suas coordenadorias, será articuladora do público-alvo para execução da meta, devendo considerar a necessidade da presença humana permanente nesses espaços, a fim de promover uma cultura de cidadania baseada na convivência, na tolerância e na ocupação contínua dos espaços públicos.	Programa de Requalificação do Espaço Público: urbanização e qualificação de espaços públicos que configuram uma centralidade urbana apropriada pelos cidadãos.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:10.651946	\N	\N	\N	\N	\N	\N	\N	\N	\N	130829488	\N	\N	sp-carinhosa, juventude-viva	11
73	Implantar 42 áreas de conexão wi-fi aberta, com qualidade e estabilidade de sinal	42 áreas de conexão wi-fi em operação	Serão instalados roteadores, antenas e concentradores capazes de fornecer acesso de qualidade à internet, com velocidade mínima de 512 kbps, podendo chegar a 2 Mbps, em praças ou outros equipamentos públicos, onde munícipes e visitantes poderão acessar livremente a internet a partir de diversos dispositivos. O número máximo de usuários simultâneos será calculado com base no fluxo de pessoas que transitam e na média de uso, garantindo qualidade e estabilidade de sinal.\n* O custo total da meta reflete os recursos necessários para manutenção de 42 áreas de wi-fi durante um ano	Área de conexão wi-fi aberta: área de acesso livre e gratuito à internet por tecnologia wi-fi, principalmente a partir de PCs, Laptops, celulares.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:12.830497	\N	\N	\N	\N	\N	\N	\N	\N	\N	30000000	\N	\N	juventude-viva, sp-aberta	11
74	Implantar 18.000 novos pontos de iluminação pública eficiente	18 mil novos pontos de Iluminação Pública instalados	Instalação de novos postes com fiações sendo alguns subterrâneos e outros aéreos, e com lâmpadas de vapor de sódio de 70 a 250W. Inicialmente priorizar locais com altos índices de criminalidade tomando como referencia o INFOCRIM (mapeamento dos pontos de criminalidade na cidade ), o Sistema Intraurbano de Monitoramento dos Direitos Humanos, os territórios prioritários definidos no Juventude Viva e também locais de grande concentração de pessoas (equipamentos de educação e saúde, saídas e entrada das estações do metrô e trem, pontos de ônibus etc.).	Novo Ponto de Iluminação Pública Eficiente: Criação de ponto de iluminação em ruas, vielas ou praças com lâmpadas de vapor de sódio, com baixo consumo de energia elétrica.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:13.37247	\N	\N	\N	\N	\N	\N	\N	\N	\N	40670189	\N	\N	juventude-viva	11
75	Realizar as obras previstas no âmbito da Operação Urbana Consorciada Água Espraiada (OUCAE)	Prolongamento da Av. Jornalista Roberto Marinho, Parque Linear,  Parque do Chuvisco,  Canalização do Córrego Água Espraiada e Córrego Pinheirinho,  Viadutos Dr. Lino de Moraes Leme e George Corbisier, Prolongamento da Av. Chucri Zaidan até a Av. João Dias,  Pontes sobre o Rio Pinheiros (Itapaiúna e Laguna).	O prolongamento da Av. Jornalista Roberto Marinho entre a Av. Dr. Lino de Moraes Leme e a Rodovia dos Imigrantes abrange um Parque de Linear de aproximadamente 271.600m2 de área e circundado por vias de trânsito local, canalização dos Córregos Água Espraiada e do Pinheirinho, construção de Habitações de Interesse Social, e a construção de 2 viadutos sobre a Av. Jornalista Roberto Marinho e/ou Parque Linear. Implantação do Parque do Chuvisco com área de aproximadamente 35.450m2, contendo quadras poliesportivas, equipamentos para a melhor idade, quadra de bocha, ciclovia, área para compostagem / hortas / pomar, quiosques, playground aquático, playground seco, arvorismo, pista de patinação, escalada, núcleo para vivência, galpão multiuso, núcleo de educação ambiental, e playground / área de apoio à Creche Municipal existente (CEI Vila Ernestina / Creche Jardim Aeroporto).\nO prolongamento da Av. Chucri Zaidan até a Av. João Dias terá inicio a cerca de 200 metros do Largo Los Andes e terminará no entroncamento da Av. João Dias, com extensão aproximada de 3.400m e que servirá de suporte a um sistema de transporte coletivo dando continuidade ao eixo formado pela Av. Luis Carlos Berrini e Av. Faria Lima, e suporte a construção de transposição sobre o rio Pinheiros entre as pontes do Morumbi e João Dias (Pontes Itapaiúna e Laguna).\n*Além das obras, a Operação Urbana Água Espraiada prevê a construção de Unidades Habitacionais de Interesse Social que estão consideradas na Meta 35	Operação Urbana Consorciada: é um instrumento de política urbana previsto na Lei nº 10.257/2001, conhecida como Estatuto da Cidade (art. 4º, inc. V, "p", e art. 32 e ss). O art. 32, parágrafo único, da Lei define a operação urbana consorciada como "o conjunto de intervenções e medidas coordenadas pelo Poder Público municipal, com a participação dos proprietários, moradores, usuários permanentes e investidores provados, com o objetivo de alcançar em uma área transformações urbanísticas estruturais, melhorias sociais e a valorização ambiental".	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:13.678695	\N	\N	\N	\N	\N	\N	\N	\N	\N	1560000000	\N	\N	\N	11
76	Criar 32 programas de requalificação do espaço público e melhoria de bairro	1 Programa de requalificação criado em cada subprefeitura.	A Secretaria Municipal de Coordenação de Subprefeituras contará com o apoio da Secretaria Municipal de Direitos Humanos e Cidadania, por meio de suas coordenadorias, para a articulação do público-alvo para execução da meta. Há necessidade da presença humana permanente desses espaços, a fim de promover uma cultura de cidadania baseada na convivência, na tolerância e na ocupação contínua dos espaços públicos.	Programa de Requalificação do Espaço Público: urbanização e qualificação de espaços públicos que configuram uma centralidade urbana apropriada pelos cidadãos.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:14.798724	\N	\N	\N	\N	\N	\N	\N	\N	\N	118000000	\N	\N	sp-carinhosa, juventude-viva	11
77	Criar e efetivar a Agência São Paulo de Desenvolvimento	Agência São Paulo de Desenvolvimento criada, 32 Representações da Agência São Paulo de Desenvolvimento instaladas	A Agência São Paulo de Desenvolvimento será constituída por quadro técnico qualificado que irá identificar as possibilidades de projetos, emitir relatórios técnicos e orientar ações para promoção e potencialização de vocações regionais. As representações nas subprefeituras atuarão localmente, interagindo com os Núcleos de Desenvolvimento Local (representações da sociedade civil), as Casas do Empreendedor (apoio local aos empreendedores), os Centros de Tecnologia e demais projetos de desenvolvimento. Atendimento ao público com utilização da estrutura da subprefeitura. Recorte de gênero e juventude para definição de público-alvo nas ações da Agência.	Agência SP: dará apoio ao desenvolvimento de projetos e incentivos aos micro e pequenos empreendedores.\nRepresentações da Agência SP: estruturas descentralizadas de apoio aos empreendedores locais com assessoria jurídica, técnica e financeira (agentes de microcrédito), para dar celeridade ao processo de formalização, regularização, abertura de empresas e concessão de crédito.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:15.944884	\N	\N	\N	\N	\N	\N	\N	\N	\N	3932099	\N	\N	\N	12
78	Criar uma agência de promoção de investimentos para a cidade de São Paulo a partir da expansão da atuação da Companhia São Paulo de Parcerias - SPP	Escopo de atuação da Companhia São Paulo de Parcerias %u2013 SPP alterado	Projeto de Lei Municipal para alterar o escopo de atuação da Companhia São Paulo de Parcerias %u2013 SPP, adicionando a função de agência de promoção do investimento na cidade de São Paulo, com capacidade de auxiliar a administração pública na identificação de processos ineficazes, propor a adoção de medidas necessárias para a desburocratização e melhoria do ambiente de negócios no Município, a promover e buscar oportunidades de negócios, atrair novos investimentos para o Município de São Paulo. Esta meta não apresenta custo de implantação uma vez que a empresa já dispõe de estrutura da antiga SPP.	Companhia São Paulo de Parcerias - SPP: Sociedade de Economia Mista, autorizada pela Lei nº 14.517, de 16 de outubro de 2010, que tem por objeto viabilizar, garantir a implementação e atuar em outras atividades relacionadas ao Programa Municipal de Parcerias Público-Privadas.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:16.267658	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	12
79	Criar e efetivar o Programa de Incentivos Fiscais nas Regiões Leste e extremo Sul	Empresas participando do Programa de incetivos fiscais na Zona Leste e extremo sul do Município.	Os incentivos serão concedidos às empresas que se instalarem na área delimitada em lei a ser aprovada. O perímetro exato desta área depende de deliberação da Câmara Municipal. Na região do extremo Sul, os incentivos serão concedidos levando em conta as potencialidades e vocações econômicas específicas dessa\nregião, privilegiando empreendimento e serviços ligado à concepção de economia sustentável, como o ecoturismo.	Incentivos Fiscais: Redução da carga tributária concedida a certas empresas que atendem a critérios previstos em lei, com o objetivo de incentivar sua instalação em determinado local ou região.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:16.52738	\N	\N	\N	\N	\N	\N	\N	\N	\N	3000	\N	\N	\N	12
80	Criar 1 Parque Tecnológico Municipal na Zona Leste e apoiar e criação do Parque Tecnológico Estadual do Jaguaré	1 Parque Tecnológico na Zona Leste,  Apoio ao Governo do Estado de SP para a criação do Parque Tecnológico Estadual do Jaguaré			\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:16.798376	\N	\N	\N	\N	\N	\N	\N	\N	\N	24500000	\N	\N	\N	13
81	Implantar o Programa VAI TEC para o incentivo de desenvolvedores de tecnologias inovadoras, abertas e colaborativas 	Apoio a projetos de tecnologia inovadora e cultura digital implementados por meio de bolsas e/ou prêmios	O Programa VAI TEC tem por objetivos: estimular a criação, o acesso, a formação e a participação do pequeno empreendedor e criador no desenvolvimento tecnológico da Cidade; promover a pesquisa, a difusão de tecnologias e a inovação; promover a estruturação e desenvolvimento de cadeiras produtivas formadas por micro, pequenas e médias empresas. A implementação do projeto se dará através do chamamento de edital, pelo menos uma vez por ano. O valor destinado a cada proposta será de até R$ 25.000,00.	VAI TEC: Programa de bolsas e premiação de projetos com foco na apropriação crítica de tecnologias de informação e cultura digital.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:17.049232	\N	\N	\N	\N	\N	\N	\N	\N	\N	9000000	\N	\N	sp-mais-inclusiva	13
82	Apoiar a implantação da UNIFESP e do IFSP nas Zonas Leste e Norte, respectivamente	Apoio à implantação da UNIFESP e do IFSP	Meta abrange a doação de terrenos para a instalação das referidas instituições.		\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:17.311781	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	13
83	Criar um sistema de contrapartida para fins de implantação de áreas verdes e financiamento de terrenos para parques	Elaboração de Estudos e diagnósticos,  Discussão dos modelos propostos com a sociedade, por meio de um seminário, Criação de novos marcos legais (portarias, decretos, projetos de lei)	O Sistema de Áreas Verdes do Município (SISMAVE) é constituído pelo conjunto de espaços significativos ajardinados e arborizados, de propriedade pública ou privada, necessários à manutenção da qualidade ambiental urbana tendo por objetivo a preservação, proteção, recuperação e ampliação desses espaços. Nesse sentido, o desenvolvimento de um sistema de contrapartidas que apoie a consolidação deste sistema, com a ampliação da oferta de áreas verdes públicas à população, proporcionará a melhoria do bem estar social e ambiental na cidade.	Sistema de contrapartida: Marco legal que estabelece critérios para que grandes empreendedores privados contribuam para a ampliação de áreas verdes no município de São Paulo.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:17.580555	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	14
86	Readequar e requalificar com ações prioritárias 34 Parques e Unidades de Conservação Municipais	Obras de readequação e requalificação em 34 Parques Municipais	Adequar e requalificar parques e unidade de conservação nos aspectos de acessibilidade, bebedouros, equipamentos, edificações e obras. Muitos parques se encontram depredados, sem equipamentos adequados para a população e sem acessibilidade, conforme exigências do Ministério Público. Há necessidade de contenção de margens de córregos e de encostas que estão pondo em risco edificações e usuários.\n\nParques a serem readequados:\nPq. Rodrigo de Gásperi\nPq. São Domungos\nPq. Guarapiranga\nPq. Anhanguera\nPq. Natural Varginha\nPq. Natural Itaim\nPq. Linear Rio Verde\nPq. Aterro Sapopemba\nPq. Linear Itaim\nPq. Piqueri\nPq. Pinheirinho D'Água\nPq. Linear Córrego do Fogo\nPq. Jardim Felicidade\nPq. Cidade de Toronto\nPq. do Trote\nPq. Independência\nPq. Ibirapuera\nPq. do Bispo - Borda da Cantareira\nPq. Paraisópolis\nPq. Horto do Ipê\nPq. Morumbi Sul\nPq. CEU 3 Lagos\nPq. do Carmo - Olavo Egydio Setúbal\nPq. Raul Seixas\nPq. Chácaras das Flores\nPq. da Luz\nPq. COHAB Raposo Tavares I - Juliana de C. Torres\nPq. Linear Água Vermelha\nPq. Leopoldina - Orlando Villas-Boas\nPq. Jacques Cousteau\nPq. Linear Itararé - Sérgio Vieira de Mello\nPq. Tenente Siqueira Campos - Trianon\nPq. Chico Mendes\nPq. Linear Sapé	Readequar e requalificar: Adequar e requalificar parques implantados em aspectos prioritários, como obras de drenagem, contenção de\ncórrego, encostas e taludes em erosão, acessibilidade e edificações de apoio (sanitários e guaritas). Instalação de bebedouros em parques já\nimplantados para atendimento da solicitação do Ministério Público. Instalação e readequação de playgrounds e equipamentos de idosos para o uso da população.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:21.085916	\N	\N	\N	\N	\N	\N	\N	\N	\N	177262000	\N	\N	sp-carinhosa, sp-mais-inclusiva	14
87	Implantar 32 polos de Educação ambiental, capacitando e sensibilizando 120.000 cidadãos	Infraestrutura básica (projetor, cadeiras, mesas, material didático) para a implantação em 32 polos de difusão da educação ambiental em cada subprefeitura, aproveitando a potencialidade de parques e outros equipamentos, dando novos usos a espaços públicos existentes, Cursos, oficinas e atividades de sensibilização e educação ambiental e de cultura de paz	O fomento e a difusão das práticas de educação ambiental visa contribuir, para que integrantes de diferentes segmentos da população, de forma criativa, critica e autônoma, construam conhecimentos sobre a situação e perspectivas socioambientais e para que se capacitem a incorporar hábitos e estilos de vida amigáveis por meio da convivência pacífica e compatíveis com a sustentabilidade da vida na cidade de São Paulo e no planeta. Para dar andamento a essas práticas, criam-se os pólos de difusão em educação ambiental e cultura de paz nos territórios de cada Subprefeitura, para descentralizar as ações de capacitação (cursos e outras atividades de longa duração) e sensibilização (atividades diversas de curta duração) na educação ambiental não formal.	Pólos de difusão de educação ambiental e cultura de paz: espaços abertos localizados em equipamentos públicos como parques e CEUs que receberão atividades promovidas pela SVMA e outros órgãos interessados, além de servir como espaço de articulação para o desenvolvimento local.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:21.519442	\N	\N	\N	\N	\N	\N	\N	\N	\N	5800651	\N	\N	sp-carinhosa, sp-mais-inclusiva	14
88	Plantar 900 mil mudas de árvores em passeios públicos, canteiros centrais e no Sistema de Áreas Verdes	900 mil mudas de árvores plantadas com recursos dos Termos de Compensação Ambiental.	O plantio de mudas será realizado prioritariamente com recursos dos Termos de Compensação Ambiental. O plantio de mudas de árvores deverá alcançar todo o território de São Paulo, partindo das demandas da população local e do diagnóstico técnico de áreas que precisam mais de intervenções urbanísticas e revitalização ambiental. As ações de plantio buscarão melhorar a qualidade ambiental do local com escolha de espécies adequadas para as calçadas e que tragam uma paisagem mais confortável para os moradores. A articulação local com as Subprefeituras se dará para a implantação de calçadas acessíveis e para o planejamento das intervenções. A meta será cumprida com o atendimento das solicitações de manutenção e plantio recebidas por SACs, demandas da sociedade civil organizada, instituições públicas municipais e demais atores sociais. Para a realização também deverá ser atendida à legislação vigente, em especial quanto à acessibilidade, uso do solo e arborização, como o Manual de Arborização Urbana do Município de São Paulo.\n* - Os custos ora estimados refletem o valor estimado para o plantio de 50.112 árvores. As árvores restantes para atingir a meta serão plantadas por\nmeio de Termos de Ajustamento de Conduta.		\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:21.798572	\N	\N	\N	\N	\N	\N	\N	\N	\N	20549400	\N	\N	\N	14
89	Ampliar a coleta seletiva municipal para os 21 distritos que ainda não são atendidos	21 distritos atendidos por alguma modalidade do serviço de coleta seletiva	Complementar a abrangência da coleta seletiva nos distritos que já contam com circuitos e efetivar a coleta seletiva para os que ainda não são atendidos por nenhuma modalidade com implantação de pontos de entrega voluntária. A ampliação da coleta seletiva não possui custo de implantação e manutenção.\n* Meta viabilizada por meio do contrato de concessão dos serviços de coleta de resíduos sólidos.	Modalidades de coleta seletiva: coleta pode ser feita pelos caminhões disponibilizados pelas concessionárias, pelos caminhões alugados pela Prefeitura e cedido às cooperativas ou misto (distrito atendido por 2 modalidades).\nCircuito: trajeto pelo qual é feita a coleta seletiva.\nPonto de Entrega Voluntária: local onde o munícipe pode fazer o descarte dos resíduos recicláveis.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:22.811216	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	agenda-pop-rua	15
90	Obter terrenos, projetar, licitar, licenciar, garantir a fonte de financiamento e construir 4 novas centrais de triagem automatizadas 	4 Centrais de Triagem Automatizadas	As centrais de triagem automatizadas contam com dispositivos para triagem automatizada, com maior capacidade de processamento de material. Trata-se de conjunto de processos de separação automática por meio de equipamentos providos de sensores ópticos, separador magnético, separador balístico e sistemas de aspiração, entre outros, que promovem a classificação e seleção automática dos materiais, de acordo com suas características físicas. A triagem automática permite separar as frações de Politereftalato de Etileno (PET); Plástico filme; Polietileno de Alta Densidade (PEAD); Plásticos mistos; Metais ferrosos e não-ferrosos; Embalagens acartonadas para produtos líquidos e semilíquidos (tetrapak).	Central de Triagem: é o equipamento que promove a triagem do material coletado pelos caminhões a serviço da PMSP, no âmbito do Programa de Coleta Seletiva.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:23.237976	\N	\N	\N	\N	\N	\N	\N	\N	\N	123300000	\N	\N	\N	15
91	Implantar 84 novos Ecopontos	84 Ecopontos implantados	A concepção do ecoponto é oferecer ao munícipe uma opção para a entrega voluntária de resíduos, sobretudo os provenientes de pequenas reformas e materiais inservíveis, como sofás, colchões, eletrodomésticos. O equipamento é entregue devidamente cercado e com portão de acesso e totem de identificação, equipado com baias para o recebimento de resíduos volumosos, caçambas para resíduos da construção civil e containers para o acondicionamento de material reciclável, em uma área impermeabilizada, com iluminação e vigilância (horário de operação: 2a.feira a sábado das 6h às 22h e aos domingos e feriados das 6h às 18h). As áreas onde serão implantadas os novos ecopontos priorizam os distritos que ainda não dispõem desse equipamento.	Ecoponto: Equipamento com aproximadamente 800 m², com acesso para veículos e caminhões, localizado próximo a áreas com histórico de descarte irregular de resíduos para a recepção voluntária de pequenos volumes de resíduos da construção civil e demolição (até 1m³), resíduos volumosos (móveis inservíveis, colchões, restos de poda) e materiais recicláveis, cuja operação é realizada pelas empresas contratadas para a realização dos serviços de limpeza indivisíveis (varrição, lavagem de vias, remoção de objetos volumosos e outros).	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:24.426375	\N	\N	\N	\N	\N	\N	\N	\N	\N	57443426	\N	\N	agenda-pop-rua	15
92	Promover a compostagem dos resíduos sólidos orgânicos provenientes das 900 Feiras Livres Municipais e dos serviços de poda da cidade	04 Centros de Compostagem modulares, 900 Feiras convertidas em feiras sustentáveis (com resíduos destinados à compostagem)	O volume de resíduos sólidos orgânicos gerados pelas feiras livres da cidade atinge cerca de 62 mil toneladas/ano (Fonte: Sistema de Controle de Resíduos Sólidos Urbanos - SISCOR, 2012). A coleta seletiva dos resíduos orgânicos das feiras livres em junção com os resíduos de poda permitem a promoção de um composto de alta qualidade para uso na agricultura urbana e periurbana de São Paulo, em perfeito atendimento ao Art.º 36, V, da Lei 12.305/10.\n* Meta viabilizada por meio de mudanças nas diretrizes de execução do contrato de concessão dos serviços de varrição e coleta de resíduos sólidos.	Resíduos sólidos orgânicos: compondo mais de 50% do lixo produzido no município, estão nessa categoria restos de frutas, verduras e legumes, folhas, sementes etc., os quais se tornam grande problema quando depositados nos aterros sanitários (gases de efeito estufa, vetores, mau cheiro e chorume tóxico). Compostagem: processo de biodecomposição controlada de resíduos orgânicos, com o objetivo de obter um composto (húmus) rico em nutrientes para uso agrícola.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:24.906761	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	15
93	Projetar, licitar, licenciar, garantir a fonte de financiamento e construir 150 km de novos corredores de ônibus	Corredores de ônibus implantados com pavimento rígido, ultrapassagem nas paradas com pré-embarque, tecnologia para informação ao usuário,  Implantação de terminais para a troncalização com os bairros.	A meta inclui a implantação de vias segredadas em pavimento rigído com largura de 3,5m e 7m nas paradas para ultrapassagem, pré-embarque em todas as paradas ao longo do corredor e nos terminais e tecnologia para informação ao usuário. Prevê também a redução do número de linhas para um máximo de 3 a 5 linhas por corredor; enterrar a fiação; realizar ciclovias ao longo dos corredores.\nCorredores planejados**:\nCorredor Aricanduva - Extensão: 14 km\nCorredor Leste Radial - Extensão: 25,5 km\nCorredor Leste Itaquera - Extensão: 14,1 km\nCorredor Berrini - Extensão: 3,3 km\nCorredor Vila Natal - Extensão: 6,3 km\nCorredor Sabará - Extensão: 7,6 km\nCorredor Miguel Yunes - Extensão: 4,23 km\nCorredor Capão Redondo / Campo Limpo / Vila Sônia - Extensão: 12 km\nCorredor Perimetral Itaim Paulista / São Mateus (Ragheb Chohfi) - Extensão: 24,1 km\nCorredor Belmira Marin - Trecho 2 - Extensão: 3,8 km\nCorredor Canal Cocaia - Extensão: 10 km\nCorredor Inajar de Souza - Requalificação - Extensão: 14,6 km\nCorredor M`Boi Mirim / Santo Amaro - Requalificação - Extensão: 16 km\n\nTerminais de Ônibus a serem implantados:\nTerminal Itaquera\nTerminal Novo Jd. Ângela\nTerminal Perus\nTerminal Novo Parelhereiros\n\nCorredores do Plano Viário Sul (custos previstos na ficha da meta correspondente):\nCorredor M`Boi Mirim / Cachoeirinha - Extensão 5,5 km\nCorredor Guarapiranga / Guavirutuba - Extensão: 5,7 km\nCorredor Agamenon - Baronesa - Extensão: 7,5 km\nCorredor Av. Carlos Caldera Filho - Extensão: 3,3 km\nCorredor Belmira Marin - Trecho 1 - Extensão: 3,1 km\n\n*O custo total de implantação de corredores descrito no campo "Custo Total da Meta" corresponde a 125 km de corredores e 4 terminais. Os 25 km de corredores faltantes serão implantados no Plano Viário Sul (meta 99), e seus custos estão descritos na ficha daquela meta.\n** Para garantir a execução de 150 km de corredores no prazo do Programa de Metas, é necessário a elaboração e execução de projetos para além da meta estabelecida, de forma a se antecipar a eventuais imprevistos. Por esse motivo, a quilometragem total dos projetos aqui descritos é superior ao quantitativo da meta.\n	Corredor de Ônibus: Via exclusiva, à esquerda, para a circulação de ônibus.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:26.783434	\N	\N	\N	\N	\N	\N	\N	\N	\N	5627479056	\N	\N	\N	16
94	Implantar as novas modalidades temporais de Bilhete Único (Diária, Semanal e Mensal)	Um instrumento de política tarifária que permitirá aos usuários o deslocamento, sem restrição, por toda a cidade pelo período adquirido (diário, semanal ou mensal). Esse instrumento é composto por novos cartões, novos aplicativos e atualização tecnológica do Sistema Bilhete Único.	A implantação das novas modalidades consiste na emissão de cartões (bilhetes) com validade no período e à atualização tecnológica de todo o sistema de bilhetagem.\n* Custo referente à infraestrutura tecnológica e física necessária para a implantação da meta, entregue em 2013	Bilhete Único Mensal: bilhete de validade mensal, com o qual o valor pago dá direito ao deslocamento por toda a cidade, sem limitação de viagens no período.\nBilhete Único Semanal: como o mensal, porém para o período de uma semana.\nBilhete Único Diário: analogamente, com validade para um dia.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:27.19314	\N	\N	\N	\N	\N	\N	\N	\N	\N	17500000	\N	\N	\N	16
95	Implantar horário de funcionamento 24h no transporte público municipal	Linhas de ônibus operando 24h/dia com linhas noturnas ou diuturnas	O planejamento inicial prevê que os ônibus noturnos percorram o mesmo trajeto das linhas do Metrô, seguindo modelos de referência internacional e facilitando a orientação do usuário. A definição precisa dos trajetos, dos intervalos entre os ônibus e das ligações entre a rede noturna planejada e já existente ainda está em planejamento pela SPTrans	Linha noturna: linha de ônibus com programação de partidas no período noturno.\nLinha diuturna: linha de ônibus com operação initerrupta (24h).	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:27.501438	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	16
96	Implantar 150 km de faixas exclusivas de ônibus	150 Km de faixas exclusivas de ônibus, sinalizadas e com tratamento prioritário para o transporte coletivo	As diretrizes do Plano Diretor Estratégico estabelecem a prioridade do transporte público. A meta prevê a instalação de mais 150 km de faixas à direita em eixos de transporte cuja frequência dos ônibus estejam acima de 40 ônibus por sentido no horário pico. Os atuais recursos de vigilância, como radares, câmeras de vigilância, sensores de massa veicular e outros, tornam possível assegurar um nível de respeito às faixas exclusivas à direita. Os conflitos com veículos nas conversões à direita, o acesso e saídas das garagens e as operações de cargas e descargas deverão ser mantidos sob controle através de fiscalização adequada. A implantação de faixas exclusivas à direita requer como medida prévia a proibição de estacionamento nesta faixa, para que a mesma seja dedicada exclusivamente aos ônibus.\n\nVias que receberão faixas exclusivas (informação completa dos trechos contemplados estará disponível no site do Programa de Metas):\n\nAv. Jabaquara / Av. Eng. Armando de Arruda Av. Luís Dumont Vilares Pereira\nR. Cesário Galeno / R. Honório Maia\nR. Gonçalo Nunes / R. Rodrigues Velho\nAv. Raimundo Pereira de Magalhães\nAv. Casa Verde / R. D. Amaral Mousinho\nAv. Auro Soares de Moura Andrade\nAv. Antártica / Av. Sumaré / Av. Paulo VI\nAv. das Nações Unidas R. Silva Bueno\nAv. Magalhães de Castro / Av. Mj. Sílvio de Magalhães Padilha (Marginal Pinheiros)\nAv. Pres. Castelo Branco / Av. Condessa Elisabeth de Robiano (Marginal Tietê)\nAv. Elísio Teixeira Leite Rótula Central\nR. Alfredo Pujol\nR. Nossa Senhora da Lapa / R. Monteiro de Melo\nR. Tomazzo Ferrara\nR. John Harrisson / R. Gago Coutinho\nAv. Itaberaba\nAv. Imirim\nAv. Zaki Narchi\nAv. Eng. Caetano Alvares\nR. Sumidouro\nR. Bom Pastor / R. Antonio Marcondes / Av. Nazaré\nAv. Amador Bueno da Veiga\nAv. Brigadeiro Luís Antonio\nAv. Águia de Haia\nR. Rodovalho Júnior\nAv. Nova Cantareira\nAv. Conselheiro Carrão\nViaduto Conselheiro Carrão\nR. Antonio de Barros\nR. Domingos Calheiros\nAv. Regente Feijó\nAv. Tucuruvi\nR. Cel. Sezefredo Fagundes\nR. Monte D´Ouro\nR. Luis Gama / R. Silveira da Mota / R. Otto de Alencar / R. Barão de Iguape\nR. Francisco Alves / R. Jeroaquara / R. Trajano\nR. Duarte de Azevedo\nAv. Conselheiro Rodrigues Alves\nViad. Domingos de Morais\nR. Loefgreen\nR. Baltazar Carrasco\nAv. Água Fria\nAv. Nordestina\nR. Dr. João Ribeiro\nR. Monte Pascal\nR. Brig. Gavião Peixoto\nR. Faustolo\nR. João XXIII\nR. Padre Benedito de Carvalho\nR. Ver. Cid Galvão\nR. Cel. Rodovalho Av. Dr. Eduardo Cotching\nAv. Corifeu de Azevedo Marques\nAv. Morvan Dias de Figueiredo (Marginal Tietê)\nAv. Pedro Alvares Cabral / Av. Ibirapuera\nR. Maria Cândida / R. Olavo Egídio\nR. do Lavapés\nR. da Independência\nAv. D. Pedro I\nAv. Cangaíba\nAv. Penha de França\nR. Clímaco Barbosa\nR. Comendador Cantinho\nR. João Teodoro\nAv. Eng. George Corbisier\nR. Ibitirama / R. e Viad. Cap.\nPacheco e Chaves / R. do\nAv. Sapopemba\nR. Heitor Penteado / Dr. Arnaldo / Av. Paulista / Av. Bernardino de Campos\nAv. Indianópolis\n\nEixo Norte-Sul (Av. Santos Dumont / Av. Tiradentes / Av. 23 de Maio / Av. Rubem Berta / Av. Moreira Guimarães / Washington Luiz / Interlagos/ Jangadeiro / Teotônio Vilela)	Faixa exclusiva de ônibus à direita: Faixa de trânsito reservada ao tráfego exclusivo de ônibus em tempo integral ou em horários pré-determinados.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:27.991377	\N	\N	\N	\N	\N	\N	\N	\N	\N	45000000	\N	\N	\N	16
119	Implementar o Ciclo Participativo de Planejamento e Orçamento 	Realização de eventos presenciais participativos (Audiências Públicas, Plenárias, Seminários etc.), Criação do Conselho de Planejamento e Orçamento Participativos (CPOP), Criação de um portal eletrônico para acompanhamento das atividades de planejamento e orçamento 	Para ampliar os mecanismos efetivos de controle da sociedade sobre a administração pública é necessário assegurar aos cidadãos as condições de participação no debate público sobre a cidade e na priorização e decisão acerca do planejamento e dos orçamentos públicos. O Ciclo Participativo de Planejamento e Orçamento visa garantir a participação popular na elaboração e acompanhamento do Programa de Metas, do Plano Plurianual (PPA), das Leis de Diretrizes Orçamentárias (LDOs) e das Leis Orçamentárias Anuais (LOAs), por meio da participação presencial em Audiências Públicas, Plenárias, Seminários etc., pela criação do Conselho de Planejamento e Orçamento Participativos (CPOP) e por meio de um Portal Eletrônico.	Programa de Metas: documento descrevendo as prioridades dos 4 anos da gestão do governo municipal, explicitando as ações estratégicas, os\nindicadores e as metas quantitativas para cada um dos setores da Prefeitura. Deve ser apresentado em até 90 dias após a posse do Prefeito eleito.\nPlano Plurianual - PPA: é o principal instrumento de planejamento público e determina a orientação estratégica e as prioridades do governo\ntraduzidas em programas e ações. O Projeto de Lei deve ser enviado ao Legislativo até o dia 30 de Setembro do primeiro ano do mandato, deve\nser votado pelo Legislativo até o fim do ano e vale para os 4 anos seguintes.\nLei de Diretrizes Orçamentárias - LDO: é o instrumento que conecta o PPA com o Orçamento Anual, estabelecendo as Diretrizes e orientando a\nelaboração da Lei Orçamentária Anual. Na LDO são fixadas as prioridades e metas para o ano seguinte, bem como previsões de alterações na legislação tributária e de metas e riscos fiscais. O Projeto de Lei deve ser enviado ao Legislativo até o dia 15 de Abril e deve ser votado até o dia 30 de Junho de cada ano.\nLei Orçamentária Anual - LOA: é a proposta orçamentária anual de todos os órgãos da administração, prevendo a Receita e fixando a Despesa para o ano seguinte. O Projeto de Lei deve ser enviado ao Legislativo até o dia 30 de Setembro e deve ser votado até o final de cada ano.\nConselho de Planejamento e Orçamento Participativos - CPOP: será criado um Conselho para acompanhar a execução dos instrumentos de planejamento e orçamento, com representantes territoriais das Subprefeituras, representantes temáticos dos diversos setores damPrefeitura e representantes do Poder Público.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:43.284687	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	sp-aberta	19
97	Implantar uma rede de 400 km de vias cicláveis	400 km de infraestrutura cicloviária de circulação (ciclovias, ciclofaixas, ciclorrotas, calçadas compartilhadas)	A meta inclui a instalação de estacionamentos para bicicletas e a implantação de um sistema de compartilhamento que será gerenciado pelo Bilhete Único.\nProjetos de vias cicláveis a serem implantados:\nPlano Cicloviário SMT/CET Setor Norte - 18,43 km de Infraestrutura Cicloviária, sendo 4,52 km de Ciclovia; 7,36 km de Ciclofaixa; 5,03 km de tráfego\nCompartilhado e 1,52 km de Rota de Bicicleta.\nPlano Cicloviário SMT/CET Setor Sul - 12,14 km de Infraestrutura Cicloviária, sendo 6,70 km de Ciclovia; 0,76 km de Ciclofaixa; 3,90 km de Tráfego\nCompartilhado e 0,78 km de Rota de Bicicleta.\nPlano Cicloviário SMT/CET Setor Leste - 26,27 km de Infraestrutua Cicloviária, sendo 7,51 km de Ciclovia; 13,46 km de Ciclofaixa; 2,18 km de tráfego\nCompartilhado e 3,12 km de Rota de Bicicleta.\nExpansão do Plano Cicloviário SMT/CET Setor Norte - 46,00 km de Infraestrutura cicloviária.\nExpansão do Plano cicloviário SMT/CET Setor Sul- 11,00 km de Infraestrutura Cicloviária.\nExpansão do Plano cicloviário SMT/CET Setor Leste - 63,00 km de Infraestrutura Cicloviária.\nProjeto Bike Sampa - Ciclorrotas compartilhadas\nCiclovias nos corredores de ônibus (custos das ciclovias nos corredores estão imbutidos nos custos do projeto de corredor e não contribuem para o\nvalor definido no campo "Custo Total da Meta")	Rota de Bicicleta ou Ciclorrota: Ruas já utilizadas por ciclistas que circulam nos bordos da via junto com o tráfego geral e que recebem sinalização vertical e horizontal especifica (placas e pintura de solo) alertando os motoristas sobre a presença e a prioridade a ser dada ao tráfego ciclístico, além da adoção da velocidade veicular em 30 km/h..\nCiclovia: Pista para uso exclusivo para circulação de bicicletas, segregada fisicamente do restante da via, dotada de sinalização vertical\ne horizontal especifica (placas e pintura de solo). Pode estar situada na calçada, no canteiro central de uma via ou na própria pista onde circula o tráfego geral.\nCiclofaixa: Faixa para uso exclusivo para circulação de bicicletas sem segregação física em relação ao restante da via e caracterizada por sinalização vertical e horizontal especifica (placas e pintura de solo). Normalmente situa-se nos bordos da pista por onde circula o tráfego geral, mas pode também situar-se na calçada e no canteiro central.\nCalçada Compartilhada: Calçadas onde é autorizada a circulação montada de bicicletas e que recebem sinalização vertical (placas) regulamentando esta situação.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:30.326367	\N	\N	\N	\N	\N	\N	\N	\N	\N	70000000	\N	\N	\N	16
98	Modernizar a rede semafórica	Projeto DNA Semafórico: É composto pelo Cadastro Semafórico, Programa Olho no Semáforo e Indicador de Qualidade Semafórica Realização e tem como finalidade o diagnóstico da situação atual dos semáforos na cidade, com participação ativa da população para identificação e tratamento dos problemas,  Recuperação de 4.800 intersecções do Sistema de Sinalização Semafórica	Orientar a ampliação da rede de semáforos operando em tempo real ao longo dos principais corredores de transporte e trânsito do município	Automação Semafórica: programação semafórica dos cruzamentos conectada ao sistema de controle centralizado operando em tempo real.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:30.923689	\N	\N	\N	\N	\N	\N	\N	\N	\N	274192935.379999995	\N	\N	sp-mais-inclusiva	16
99	Projetar, licitar, licenciar e garantir a fonte de financiamento para a execução do Plano Viário Sul	Melhoramento e duplicação de 7,5km da R. Agamenon e Estrada da Baronesa com implantação de corredor de ônibus, Prolongamento e duplicação de 5,5 km da Estrada do M'Boi Mirim com implantação de corredor de ônibus,  Duplicação de 1,2km da Estrada da Cachoeirinha com implantação de corredor de ônibus, Prolongamento de 3,3km da Av. Carlos Caldeira Filho com implantação de corredor de ônibus e canalização do córrego Água dos Brancos, Melhoramentos e duplicação de 3,1km da Av. Dona Belmira Marin com implantação de corredor de ônibus, Melhoramento e alargamento de 4,9km da Estrada de Itapecerica, Duplicação de 6,3km da Estrada do Alvarenga, Melhoramento e duplicação de 5,7km da Av. Guarapiranga/ Estrada Guavirituba com implantação de corredor de ônibus.	Além dos melhoramentos viários, o custo e a descrição da meta inclui a implantação de 25km de corredores de ônibus que devem ser contabilizados como entrega para os 150km de corredores de ônibus. O total das intervenções de melhoramento, duplicação, prolongamento ou implantação de corredor é de 36,3km.	Plano Viário Sul: Plano de obras viárias localizadas na região do extremo sul da cidade de São Paulo.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:31.506611	\N	\N	\N	\N	\N	\N	\N	\N	\N	1743000000	\N	\N	\N	16
100	Concluir obras do complexo Nova Radial	Obras Viárias Complementares ao Prolongamento da Radial Leste - 2ª Etapa (Subprefeituras Guaianases, Itaquera, Penha e São Miguel): conjunto de intervenções para acesso e apoio ao novo trecho da Radial Leste.			\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:31.860607	\N	\N	\N	\N	\N	\N	\N	\N	\N	309999000	\N	\N	\N	16
101	Projetar, licitar, licenciar, garantir a fonte de financiamento e construir a ponte Raimundo Pereira de Magalhães	Ponte Raimundo Pereira Magalhães construída.	A Ponte da Avenida Raimundo Pereira de Magalhães será construída sobre o rio Tietê reestabelece a ligação entre a parte norte da avenida com o bairro da Lapa e a Avenida Marginal do Tietê, numa extensão de cerca de 200 metros, além de viário complementar.		\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:32.192717	\N	\N	\N	\N	\N	\N	\N	\N	\N	220000000	\N	\N	\N	16
102	Ampliar o Programa de Proteção ao Pedestre atingindo 18 novas grandes avenidas e 14 locais de intensa circulação de pedestres	Programa Proteção ao Pedestre, com ações educativas, de engenharia e de fiscalização.	Reduzir em 10% / ano o número de acidentes de trânsito com pedestres, ampliando o programa de proteção ao pedestre para toda a cidade, enfatizando corredores de ônibus periféricos, subcentros comerciais e pólos geradores de pedestres (regiões com alto índice de atropelamentos) com a implementação de ações de educação, engenharia e fiscalização.\nLocais a serem atendidos:\nGrandes Avenidas\nAv. S. João\nR. Vergueiro\nAv. 9 de Julho/Sto Amaro\nConsolação/Rebouças/Fco Morato\nAv. Inajar de Sousa/Rio Branco\nEdgar Facó/Lapa/Centro\nPaes de Barros\nAv Ragueb Chohfi\nAv. S. Miguel\nAv. Sapopemba\nAv. Marechal Tito\nAv. Matteo Bei/ Cons Carrão\nAv. Teotônio Vilela,\nAv. Guarapiranga\nEstrada M' Boi Mirim\nAv. Cupecê\nEstrada Itapecerica\nAv. Ibirapuera/Ver.José Diniz\n\nLocais de intensa circulação de pedestres\nCentro Antigo\nBrás\nBela Vista\nSantana\nV. Maria\nUSP\nLapa\nPinheiros\nPenha\nSapopemba\nItaquera\nSão Miguel\nLgo. 13 de Maio\nItaim Bibi	Programa de Proteção ao Pedestre: programa cujo objetivo é criar a cultura de respeito ao pedestre, resgatando os valores de proteção ao pedestre, de maneira a ampliar a segurança destes e reduzir os índices de acidentalidade por atropelamentos	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:32.524689	\N	\N	\N	\N	\N	\N	\N	\N	\N	12000000	\N	\N	\N	16
103	Construir a Alça do Aricanduva	Alça construída	A alça permitirá o acesso à Marginal Tietê evitando a entrada no bairro da Penha.		\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:32.886797	\N	\N	\N	\N	\N	\N	\N	\N	\N	10000000	\N	\N	\N	16
104	Intervir em 79 pontos de alagamentos por meio do Programa de Redução de Alagamentos - PRA	Intervenções em 79 pontos de alagamentos realizadas	O Programa compreende a execução de serviços para redução dos pontos de alagamento e margens de córrego com situação crítica quanto à interdição de tráfego e erosão ou solapamento. Os locais de execução dos serviços foram definidos e priorizados em estudos realizados pela SIURB, SMSP, Subprefeituras e CET. O programa está organizado em lotes regionais que reúnem intervenções em ruas / logradouros por subprefeitura: Lote I - Sul (Capela do Socorro, Ipiranga, Jabaquara, Santo Amaro); Lote II - Oeste/Centro/ Sudeste (Móoca, Lapa, Sé, Pinheiros); Lote III - Norte/ Noroeste (Casa Verde, Freguesia do Ó, Jaçanã/Tremembé, Vila Maria/Vila Guilherme, Pirituba, Santana); Lote IV - Leste (Ermelino Matarazzo, Itaquera, Itaim Paulista, São Miguel); Lote IV - Leste (Ermelino Matarazzo, Itaquera, Itaim Paulista, São Miguel).	Programa de Redução de Alagamentos – PRA: prevê minimizar alagamentos em vários pontos da cidade, em função de insuficiências do sistema existente de drenagem ou de margens de córregos com solapamentos. As obras e serviços previstos no PRA são pontuais e de rápida implantação, servindo como complemento aos macro-programas de drenagem da cidade.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:34.815181	\N	\N	\N	\N	\N	\N	\N	\N	\N	133000000	\N	\N	\N	17
105	Realizar intervenções de controle de cheias em bacias dos córregos: Ponte Baixa, Zavuvus, Sumaré/Água Preta, Aricanduva, Cordeiro, Praça da Bandeira, Av. Anhaia Mello, Freitas/Capão Redondo, Paraguai/Éguas, Riacho do Ipiranga, Tremembé, Ribeirão Perus e Paciência e desenvolver o projeto para intervenção nos córregos do Itaim Paulista	Canalização de 15,4km de córregos, construção de 8 reservatórios e 2 parques lineares com um total de 560.000m² de área verde.	1. PONTE BAIXA (Subprefeitura do M'Boi Mirim) - Canalização de 3.080m do Córrego e implantação de 1 reservatório.\n2. ZAVUVUS (Subprefeituras de Santo Amaro e Cidade Ademar) - Canalização de 3.520m do Córrego Zavuvus com implantação de 2 reservatórios e um parque linear de 200.000m².\n3. SUMARÉ E ÁGUA PRETA (Subprefeitura Lapa) - Canalização de 8.800m do Córrego.\n4. ARICANDUVA (Subprefeitura Aricanduva e São Mateus) - Implantação de 2 reservatórios e um parque linear de 360.000m² na área do Córrego.\n5. PRAÇA DA BANDEIRA (Subprefeitura Sé) - Implantação do reservatório do Anhangabaú.\n6. ANHAIA MELLO (Subprefeitura Vila Prudente/Sapopemba) - Implantação de 2 reservatórios\n7. Ribeirão Perus (Subprefeitura Perus) - Canalização de 110m do Córrego com implantação de 5 reservatórios e um parque linear de 1.100.000 m².\n8. Riacho do Ipiranga (Subprefeitura Ipiranga) - Canalização de 2.200 m do Córrego com implantação de um reservatório.\n9. Paciência (Subprefeitura Jaçana/Tremembé) - Canalização de 2.400m com implantação de um reservatório no Córrego Paciência.\n10. Tremembé (Subprefeitura Jaçana/Tremembé) - Canalização de 2.500 m com implantação de 6 reservatórios no Córrego.\n11. Morro do S - Freitas/Capão Redondo (Subprefeitura Campo Limpo) -\n12. Cordeiro (Subprefeitura Cidade Ademar e Santo Amaro) - Canalização de 2.200m do Córrego Alcatrazes e 270m de canalização do Córrego Cordeiro com implantação de 6 reservatórios, 4 caixas de equalização de vazão e 2 caixas de interligação de galerias.\n13. Paraguai/Éguas (Subprefeitura Santo Amaro e Vila Mariana) - Implantação de um reservatório.\n14. Ribeirão Água Vermelha, Ribeirão Lajeado, Córrego Itaim, Córrego Tijuco Preto e afluentes (Subprefeitura Itaim Paulista) - Elaboração de projeto básico e viabilização do inicio da intervenção\nOs custos relacionados às obras acima incluem gastos com as desapropriações necessárias à execução da obra.	Intervenções de macrodrenagem: obras de apoio à drenagem associadas à bacia ou à sub-bacia hidrográfica	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:35.6946	\N	\N	\N	\N	\N	\N	\N	\N	\N	3300000000	\N	\N	\N	17
106	Desenvolver o programa de drenagem e manejo das águas pluviais, com a criação de uma instância municipal de regulação, articulação e monitoramento da drenagem urbana	1 Programa de drenagem criado, 1 Instância municipal de drenagem.	Será realizada a elaboração de estudos de 6 seis bacias hidrográficas inscritas no território do município, com objetivo básico de recuperação dos cursos d%u2019água e de suas bacias hidrográficas, de modo a integrá-las ao tecido urbano com sustentabilidade ambiental. Tal estudo engloba o levantamento realizado de informações básicas das bacias hidrográficas, diagnóstico hidrológico e hidráulico e desenvolvimento dos modelos computacionais de simulação hidráulica, proposição de medidas estruturais e não estruturais de implantação imediata, de curto, médio e longo prazos, execução de anteprojetos de intervenções, viabilidade ambiental das obras propostas; proposição de aprimoramento institucional. O Programa prevê também a institucionalização de uma instância municipal que articule os órgãos que atuam na questão da drenagem urbana.	Bacia hidrográfica: é uma área de captação natural da água de precipitação que faz convergir o escoamento para um único ponto de saída.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:36.137863	\N	\N	\N	\N	\N	\N	\N	\N	\N	20076242	\N	\N	\N	17
107	Criar 32 Centros de Atendimento ao Cidadão - CAC	Centros de Atendimento ao Cidadão funcionando em cada subprefeitura.	Adequação do espaço físico, modernização do atendimento e ampliação dos serviços oferecidos.	Centros de Atendimento ao Cidadão – CAC: é a modernização de toda a infraestrutura das atuais Praças de Atendimento que irá incluir adequação do espaço físico, otimização e ampliação dos serviços atendidos, integração dos sistemas de atendimento oferecidos.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:37.918382	\N	\N	\N	\N	\N	\N	\N	\N	\N	55000000	\N	\N	\N	18
108	Ampliar e modernizar os serviços oferecidos por meio do 156	Serviço de atendimento ao cidadão reestruturado, tanto na parte externa do serviço como nos fluxos internos das demandas dos cidadãos.	Os serviços de atendimento ao cidadão encontram-se hoje desarticulados e sem um fluxo adequado para que as respostas sejam dadas num período de\ntempo adequado ao cidadão. A ampliação e reestruturação destes canais visam garantir um atendimento ágil e eficaz das demandas dos cidadãos.	156: É a Central telefônica da Prefeitura de São Paulo que fornece informações sobre os serviços públicos municipais.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:38.348044	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000000	\N	\N	\N	18
109	Criar a Subprefeitura de Sapopemba	Subprefeitura de Sapopemba criada	A Subprefeitura de Sapopemba deverá responder as atribuições e responsabilidades definidas pela lei nº 13.399 de 01/08/2002 de criação das Subprefeituras. Sua criação aumentará a capilaridade do Estado, aproximando-o da população.	Subprefeitura: Criadas em pela lei 13.399, são unidades do poder público municipal responsáveis pela maioria dos equipamentos públicos, como clubes da comunidade (antigos CDMs) e clubes da cidade. Têm o papel de receber pedidos e reclamações da população, solucionar os problemas apontados; preocupam-se com a educação, saúde e cultura de cada região, tentando sempre promover atividades para a população. Além disso, elas cuidam da manutenção do sistema viário, da rede de drenagem, limpeza urbana, vigilância sanitária e epidemiológica, entre outros papéis que transformam, a cada dia, essas regiões da cidade em locais mais humanizados e cheios de vida.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:38.705039	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	18
110	Integrar os sistemas de informação dos diversos órgãos municipais (Guarda Civil Metropolitana, Companhia de Engenharia de Tráfego, SAMU, Defesa Civil)  e implantar a Central de Operações da Defesa Civil para a gestão de riscos e respostas a desastres 	Sistema de informações das diversas instituições com base de dados integrada, Implantação de uma Central de operações e atendimento da Defesa Civil no tocante a sua infra-estrutura e equipamentos para alimentação de um sistema em um banco de dados integrados com diversas centrais setoriais e emergência da Cidade de São Paulo	A implantação da Central de Operações da Defesa Civil permitirá aos órgãos envolvidos o aperfeiçoamento dos processos, com agilização no atendimento à população nas situações de emergência e no planejamento estratégico. Nesse sentido, os esforços para seu funcionamento compreende o desenvolvimento do projeto, a implantação de infraestrutura e do Centro, a qualificação dos profissionais, a instalação dos sistemas de integração e dos equipamentos e a definição de protocolos de atendimento para os órgãos de emergência. E, ainda o desenvolvimento de uma base de dados da Defesa Civil para coleta, sistematização e compartilhamento com a sociedade	Central de operações: Centro onde se coordena as ações de prevenção e resposta a desastres e calamidades.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:39.060088	\N	\N	\N	\N	\N	\N	\N	\N	\N	30000000	\N	\N	\N	18
120	Revisar o Plano Diretor Estratégico	Projetos de Lei apresentados à Câmara Municipal para revisão do Plano Diretor Estratégico	Os projetos de lei serão construídos de forma participativa, mediante audiências públicas e outros instrumentos pertinentes ao processo de participação cidadã. O processo de revisão e aprovação do Plano Diretor Estratégico não envolve custo de implantação e manutenção.	Marco Regulatório: é o conjunto de instrumentos de planejamento e gestão urbana que serve para definir as diretrizes das políticas públicas e\ncontrolar o desenvolvimento da cidade.\nPlano Diretor Estratégico: é o instrumento básico da política de desenvolvimento e expansão urbana do município. Deve ordenar o cumprimento das funções sociais da cidade e das propriedades urbanas, integrar ao processo de planejamento municipal e orientar o plano plurianual, as diretrizes orçamentárias e o orçamento anual.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:43.686269	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	20
111	Implantar um Sistema de Informação Geográfica, com dados abertos e livre consulta pelo público	Sistema de Informação Geográfica implantado.	O SIG-SP está institucionalizado pelo Decreto nº 50.736/2009. O SIG gerido pela SMDU, envolverá informações disponibilizadas pelas secretarias e órgão externos, relacionados com atividades de expressão territorial. Será desenvolvido em padrões compatíveis com os sistemas livres e de mercado, aderentes à Infraestrutura Nacional de Dados Espaciais (INDE), bem como à Open Geospatial Consortium (OGC).\nComo sistema corporativo, produz e reproduz informação de maneira inteligente com o apoio das geotecnologias. No âmbito de SMDU e SPUrbanismo, produzirá um sistema integrado dos bancos de dados existentes, agregando a informação geográfica como componente de suas análises, seja em ambiente interno (módulo I de integração) ou externo (Infolocal).	Sistema de Informação Geográfica (SIG): Conjunto de pessoas, organizações, dados, equipamentos e programas de coleta, processamento, análise e disseminação da informação geográfica.\nInfraestrutura de Dados Espaciais (IDE): Conjunto integrado de tecnologias; políticas; mecanismos e procedimentos de coordenação e monitoramento; padrões e acordos, necessário para facilitar e ordenar a geração, o armazenamento, o acesso, o compartilhamento, a disseminação e o uso dos dados geoespaciais de origem federal, estadual, distrital e municipal.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:39.414099	\N	\N	\N	\N	\N	\N	\N	\N	\N	10700000	\N	\N	\N	18
112	Criar 400 Núcleos de Defesa Civil	Banco de dados com as informações inerentes as lideranças e áreas de riscos,  Treinamento das lideranças cadastradas para em caso de ocorrências adotarem providências no sentido de alertar os demais moradores da comunidade e contatar a Defesa Civil	Para a criação de 400 novos NUDECs, será realizado o mapeamento das áreas pelo IPT, cadastramento de pessoas da comunidade e treinamento. O mapeamento será priorizado para as áreas de risco 4 - perigo eminente (morro/encosta).	Núcleos de Defesa Civil: grupos locais cuja finalidade é desenvolver um processo de orientação permanente junto à população	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:40.060035	\N	\N	\N	\N	\N	\N	\N	\N	\N	21000	\N	\N	\N	18
113	Criar o Conselho da Cidade, o Conselho Municipal de Transportes e mais 6 novos Conselhos Temáticos	Conselhos criados e em atuação	Os Conselhos Previstos são: Desenvolvimento Econômico e Social (Conselho da Cidade); Igualdade Racial; Esporte, Lazer e Recreação; Políticas paraas Mulheres; Defesa do Consumidor; Transparência Pública e Combate à Corrupção; Comunicação.	Conselhos: órgão colegiado envolvendo membros da sociedade civil e do governo para apoio à gestão de políticas públicas.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:40.657105	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	sp-aberta	19
114	Criar Conselhos Participativos nas 32 Subprefeituras	Os Conselhos de Representantes efetivados em cada subprefeitura		Conselhos Participativos das Subprefeituras: são espaços institucionalizados de tomada de decisão e de controle social no que se refere às ações empreendidas pelos governos locais, seja no processo de elaboração, no processo de implantação, execução, seja no processo de avaliação e monitoramento.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:41.209068	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N	\N	19
115	Realizar 44 Conferências Municipais Temáticas	Grandes conferências temáticas realizadas, com participação direta da sociedade civil	Cada conferência pressupõe no mínimo o seguinte conjunto de ações: elaboração de edital de convocação e regulamento, realizações de préconferências regionais, mobilização da sociedade civil e do governo, definição de infra-estrutura, elaboração de relatoria, publicização do relatório final e eleição de delegados, que devem ter recursos garantidos para participação nas conferências estaduais e na federal (se for o caso). Para 2013 já estão previstas as seguintes conferências municipais: Cidade, Cultura, Educação, Promoção da Igualdade Racial, Meio Ambiente, Assistência Social, Migrantes, Participação e Atenção às Drogas, Segurança Alimentar e Nutricional e Saúde.	Conferências municipais: espaços de participação direta da sociedade civil para apresentação de proposições para formulação e acompanhamento de políticas públicas (controle social). Em geral são uma etapa prévia à realização de conferências nas esferas estadual e federal	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:41.595005	\N	\N	\N	\N	\N	\N	\N	\N	\N	6768928	\N	\N	sp-aberta	19
116	Implantar o Gabinete Digital, como instrumento de transparência e participação social	Portal na internet implantada com funcionalidades interativas	Portal na internet com as seguintes funcionalidades básicas: Agenda Colaborativa, Perguntas e Respostas da Prefeitura, Fórum de Discussão Pública via internet e interface com as redes sociais. Outras funcionalidades podem ser desenvolvidas de acordo com as necessidades detectadas.	Gabinete Digital: Portal na internet que permite a participação do cidadão e interação direta com a equipe da Prefeitura.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:41.973507	\N	\N	\N	\N	\N	\N	\N	\N	\N	930300	\N	\N	sp-aberta	19
117	Fortalecer os Órgãos Colegiados Municipais, dotando-os de infraestrutura e gestão adequadas para a realização das atribuições previstas em lei.	Infraestrutura básica para funcionamento adequado dos órgãos colegiados, de acordo com suas funções e rotinas	O objetivo dessa meta é garantir infraestrutura mínima e padronizada para que os órgãos colegiados realizem suas atividades, tais como: audiências, reuniões, monitoramento das políticas, mobilização social, registro de pautas, elaboração de atas, agendas e relatórios e disponibilização de informações (fortalecendo a dimensão da transparência e incentivando a adoção de novos mecanismos de cidadania digital). A depender da rotina de funcionamento (alguns têm reuniões periódicas, outros funcionamento diário), dos equipamentos já existentes e da quantidade de participantes, a infraestrutura poderá ser individual ou compartilhada entre vários órgãos. Para tanto será feito inicialmente um diagnóstico que irá detalhar de forma mais precisa as necessidades de cada um deles. Prevê-se como estrutura mínima: 1 sala para gabinete/administrativo e 1 sala para reunião/atividades diversas, 1 computador com acesso à internet e microfone, livros, datashow, equipamento de som para palestra, 1 notebook, impressora colorida, móveis para sala de reunião, telefone %u2013 aparelho e linha (ou ramal), materiais educativos\nimpressos, material de escritório e informática.	Órgãos Colegiados Municipais: compreendem os conselhos,comitês e comissões, que congregam cidadãos e Poder Público em representação a segmentos populacionais para construção de políticas públicas. São responsáveis por acompanhar políticas públicas pertinentes a sua temática, bem como promover a participação social, podendo ainda fazer propositura de planos de ação e a gestão de fundos.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:42.35353	\N	\N	\N	\N	\N	\N	\N	\N	\N	600000	\N	\N	sp-carinhosa, sp-aberta	19
118	Implementar o Observatório de Indicadores da Cidade de São Paulo	Portal web com um sistema de indicadores da prefeitura e da cidade acompanhado de análises setoriais relevantes para a elaboração e avaliação de políticas públicas		Portal web com um sistema de indicadores da prefeitura e da cidade acompanhado de análises setoriais relevantes para a elaboração e avaliação de políticas públicas	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:42.739576	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.52000000000000002	\N	\N	sp-carinhosa, sp-aberta	19
121	Revisar a Lei de Parcelamento, Uso e Ocupação do Solo	Projeto de Lei apresentado à Câmara Municipal	Será realizada a avaliação da lei vigente e proposição de projeto de lei de sua revisão por meio de um processo participativo envolvendo a sociedade e os diversos segmentos sociais.	Marco Regulatório: é o conjunto de instrumentos de planejamento e gestão urbana que serve para definir as diretrizes das políticas públicas e\ncontrolar o desenvolvimento da cidade.\nLei de parcelamento, uso e ocupação do solo: também conhecida como lei de zoneamento, trata das regras de quanto, como e onde podem ser construídas determinadas atividades no território municipal. É um instrumento que estabelece parâmetros objetivos para o cumprimento da função social da propriedade com base no que for estabelecido no Plano Diretor.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:44.081677	\N	\N	\N	\N	\N	\N	\N	\N	\N	7900000	\N	\N	\N	20
122	Revisar os Planos Regionais Estratégicos	Projeto de Lei apresentados à Câmara Municipal para revisão dos Planos Regionais Estratégicos	Os projetos de lei serão construídos de forma participativa, mediante audiências públicas e outros instrumentos pertinentes.	Marco Regulatório: é o conjunto de instrumentos de planejamento e gestão urbana que serve para definir as diretrizes das políticas públicas e controlar o desenvolvimento da cidade.\nPlano Regional Estratégico: Instrumento de planejamento urbano baseado no Plano Diretor Estratégico com abrangência no território de cada subprefeitura do Município de São Paulo.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:44.487773	\N	\N	\N	\N	\N	\N	\N	\N	\N	2100000	\N	\N	\N	20
123	Aprovar as Operações Urbanas Mooca/Vila Carioca, a revisão da Operação Urbana Água Branca e iniciar os estudos do projeto Arco Tietê	Projetos de Lei apresentados à Câmara Municipal estabelecendo as áreas e mecanismos que comporão as operações urbanas citadas.		Operação Urbana: instrumentos da política urbana que visam a promover melhorias em regiões pré - determinadas da cidade através de parcerias entre o Poder Público e a iniciativa privada. Cada área objeto de Operação Urbana tem uma lei específica estabelecendo as metas a serem cumpridas, bem como os mecanismos de incentivos e benefícios.	\N	\N	\N	\N	\N	\N	\N	2014-12-07 16:17:44.970524	\N	\N	\N	\N	\N	\N	\N	\N	\N	14350000	\N	\N	\N	20
\.


--
-- Name: goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_id_seq', 1, false);


--
-- Data for Name: goal_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal_project (id, goal_id, project_id, created_at, updated_at) FROM stdin;
8546	1	2805	2014-12-07 16:16:31.686605	\N
8547	2	2806	2014-12-07 16:16:31.910897	\N
8548	2	2807	2014-12-07 16:16:31.914915	\N
8549	3	2808	2014-12-07 16:16:32.249976	\N
8550	3	2809	2014-12-07 16:16:32.2528	\N
8551	3	2810	2014-12-07 16:16:32.255155	\N
8552	3	2811	2014-12-07 16:16:32.257683	\N
8553	3	2812	2014-12-07 16:16:32.260179	\N
8554	3	2813	2014-12-07 16:16:32.262499	\N
8555	3	2814	2014-12-07 16:16:32.264751	\N
8556	3	2815	2014-12-07 16:16:32.266914	\N
8557	3	2816	2014-12-07 16:16:32.269473	\N
8558	3	2817	2014-12-07 16:16:32.272001	\N
8559	3	2818	2014-12-07 16:16:32.274529	\N
8560	3	2819	2014-12-07 16:16:32.277512	\N
8561	3	2820	2014-12-07 16:16:32.279852	\N
8562	3	2821	2014-12-07 16:16:32.282136	\N
8563	3	2822	2014-12-07 16:16:32.284343	\N
8564	3	2823	2014-12-07 16:16:32.286571	\N
8565	3	2824	2014-12-07 16:16:32.289124	\N
8566	3	2825	2014-12-07 16:16:32.29138	\N
8567	3	2826	2014-12-07 16:16:32.293637	\N
8568	3	2827	2014-12-07 16:16:32.295769	\N
8569	3	2828	2014-12-07 16:16:32.297909	\N
8570	3	2829	2014-12-07 16:16:32.300547	\N
8571	3	2830	2014-12-07 16:16:32.302949	\N
8572	3	2831	2014-12-07 16:16:32.305218	\N
8573	3	2832	2014-12-07 16:16:32.307446	\N
8574	3	2833	2014-12-07 16:16:32.309703	\N
8575	3	2834	2014-12-07 16:16:32.312034	\N
8576	3	2835	2014-12-07 16:16:32.314335	\N
8577	3	2836	2014-12-07 16:16:32.316531	\N
8578	3	2837	2014-12-07 16:16:32.319131	\N
8579	3	2838	2014-12-07 16:16:32.321342	\N
8580	3	2839	2014-12-07 16:16:32.323481	\N
8581	4	2840	2014-12-07 16:16:32.390666	\N
8582	4	2841	2014-12-07 16:16:32.393223	\N
8583	4	2842	2014-12-07 16:16:32.395719	\N
8584	4	2843	2014-12-07 16:16:32.398068	\N
8585	5	2844	2014-12-07 16:16:32.44149	\N
8586	5	2845	2014-12-07 16:16:32.444471	\N
8587	6	2846	2014-12-07 16:16:32.48565	\N
8588	7	2847	2014-12-07 16:16:32.559915	\N
8589	7	2848	2014-12-07 16:16:32.56227	\N
8590	7	2849	2014-12-07 16:16:32.564507	\N
8591	7	2850	2014-12-07 16:16:32.566589	\N
8592	8	2851	2014-12-07 16:16:32.65639	\N
8593	8	2852	2014-12-07 16:16:32.659394	\N
8594	8	2853	2014-12-07 16:16:32.662266	\N
8595	8	2854	2014-12-07 16:16:32.664561	\N
8596	8	2855	2014-12-07 16:16:32.666692	\N
8597	8	2856	2014-12-07 16:16:32.668757	\N
8598	9	2857	2014-12-07 16:16:32.720377	\N
8599	9	2858	2014-12-07 16:16:32.722832	\N
8600	10	2859	2014-12-07 16:16:33.061231	\N
8601	10	2860	2014-12-07 16:16:33.063694	\N
8602	10	2861	2014-12-07 16:16:33.065875	\N
8603	10	2862	2014-12-07 16:16:33.0679	\N
8604	10	2863	2014-12-07 16:16:33.069937	\N
8605	10	2864	2014-12-07 16:16:33.071901	\N
8606	10	2865	2014-12-07 16:16:33.073977	\N
8607	10	2866	2014-12-07 16:16:33.07595	\N
8608	10	2867	2014-12-07 16:16:33.077971	\N
8609	10	2868	2014-12-07 16:16:33.080326	\N
8610	10	2869	2014-12-07 16:16:33.082964	\N
8611	10	2870	2014-12-07 16:16:33.085164	\N
8612	10	2871	2014-12-07 16:16:33.087229	\N
8613	10	2872	2014-12-07 16:16:33.089319	\N
8614	10	2873	2014-12-07 16:16:33.09136	\N
8615	10	2874	2014-12-07 16:16:33.093393	\N
8616	10	2875	2014-12-07 16:16:33.095378	\N
8617	10	2876	2014-12-07 16:16:33.097537	\N
8618	10	2877	2014-12-07 16:16:33.100049	\N
8619	10	2878	2014-12-07 16:16:33.102156	\N
8620	10	2879	2014-12-07 16:16:33.104304	\N
8621	10	2880	2014-12-07 16:16:33.106372	\N
8622	10	2881	2014-12-07 16:16:33.108439	\N
8623	10	2882	2014-12-07 16:16:33.110954	\N
8624	10	2883	2014-12-07 16:16:33.113646	\N
8625	10	2884	2014-12-07 16:16:33.115837	\N
8626	10	2885	2014-12-07 16:16:33.117902	\N
8627	10	2886	2014-12-07 16:16:33.12015	\N
8628	11	2887	2014-12-07 16:16:33.352188	\N
8629	11	2888	2014-12-07 16:16:33.354713	\N
8630	11	2889	2014-12-07 16:16:33.356907	\N
8631	11	2890	2014-12-07 16:16:33.359214	\N
8632	11	2891	2014-12-07 16:16:33.36134	\N
8633	11	2892	2014-12-07 16:16:33.363745	\N
8634	11	2893	2014-12-07 16:16:33.366138	\N
8635	11	2894	2014-12-07 16:16:33.368222	\N
8636	11	2895	2014-12-07 16:16:33.3703	\N
8637	11	2896	2014-12-07 16:16:33.372368	\N
8638	11	2897	2014-12-07 16:16:33.374418	\N
8639	11	2898	2014-12-07 16:16:33.376459	\N
8640	11	2899	2014-12-07 16:16:33.3785	\N
8641	11	2900	2014-12-07 16:16:33.381323	\N
8642	11	2901	2014-12-07 16:16:33.383867	\N
8643	11	2902	2014-12-07 16:16:33.386083	\N
8644	12	2903	2014-12-07 16:16:33.540455	\N
8645	12	2904	2014-12-07 16:16:33.543493	\N
8646	12	2905	2014-12-07 16:16:33.545663	\N
8647	12	2906	2014-12-07 16:16:33.548121	\N
8648	12	2907	2014-12-07 16:16:33.550306	\N
8649	12	2908	2014-12-07 16:16:33.552554	\N
8650	13	2909	2014-12-07 16:16:33.648898	\N
8651	13	2910	2014-12-07 16:16:33.651687	\N
8652	13	2911	2014-12-07 16:16:33.654102	\N
8653	13	2912	2014-12-07 16:16:33.656251	\N
8654	13	2913	2014-12-07 16:16:33.658485	\N
8655	14	2914	2014-12-07 16:16:34.069558	\N
8656	14	2915	2014-12-07 16:16:34.072108	\N
8657	14	2916	2014-12-07 16:16:34.074523	\N
8658	14	2917	2014-12-07 16:16:34.076658	\N
8659	14	2918	2014-12-07 16:16:34.078636	\N
8660	14	2919	2014-12-07 16:16:34.080524	\N
8661	14	2920	2014-12-07 16:16:34.0827	\N
8662	14	2921	2014-12-07 16:16:34.084875	\N
8663	14	2922	2014-12-07 16:16:34.086869	\N
8664	14	2923	2014-12-07 16:16:34.088858	\N
8665	14	2924	2014-12-07 16:16:34.090782	\N
8666	14	2925	2014-12-07 16:16:34.092785	\N
8667	14	2926	2014-12-07 16:16:34.094721	\N
8668	14	2927	2014-12-07 16:16:34.096689	\N
8669	14	2928	2014-12-07 16:16:34.098782	\N
8670	14	2929	2014-12-07 16:16:34.101399	\N
8671	14	2930	2014-12-07 16:16:34.103717	\N
8672	14	2931	2014-12-07 16:16:34.105794	\N
8673	14	2932	2014-12-07 16:16:34.108078	\N
8674	14	2933	2014-12-07 16:16:34.110062	\N
8675	14	2934	2014-12-07 16:16:34.112229	\N
8676	14	2935	2014-12-07 16:16:34.11446	\N
8677	14	2936	2014-12-07 16:16:34.116853	\N
8678	14	2937	2014-12-07 16:16:34.118914	\N
8679	14	2938	2014-12-07 16:16:34.12096	\N
8680	14	2939	2014-12-07 16:16:34.122949	\N
8681	14	2940	2014-12-07 16:16:34.124901	\N
8682	14	2941	2014-12-07 16:16:34.126907	\N
8683	14	2942	2014-12-07 16:16:34.128932	\N
8684	14	2943	2014-12-07 16:16:34.131771	\N
8685	14	2944	2014-12-07 16:16:34.134366	\N
8686	14	2945	2014-12-07 16:16:34.136618	\N
8687	15	2946	2014-12-07 16:16:34.203437	\N
8688	15	2947	2014-12-07 16:16:34.205613	\N
8689	16	2948	2014-12-07 16:16:34.510369	\N
8690	16	2949	2014-12-07 16:16:34.513367	\N
8691	16	2950	2014-12-07 16:16:34.515774	\N
8692	16	2951	2014-12-07 16:16:34.518608	\N
8693	16	2952	2014-12-07 16:16:34.521884	\N
8694	16	2953	2014-12-07 16:16:34.524663	\N
8695	16	2954	2014-12-07 16:16:34.527399	\N
8696	16	2955	2014-12-07 16:16:34.530306	\N
8697	16	2956	2014-12-07 16:16:34.534565	\N
8698	16	2957	2014-12-07 16:16:34.538126	\N
8699	16	2958	2014-12-07 16:16:34.542878	\N
8700	16	2959	2014-12-07 16:16:34.545167	\N
8701	16	2960	2014-12-07 16:16:34.54727	\N
8702	16	2961	2014-12-07 16:16:34.549295	\N
8703	16	2962	2014-12-07 16:16:34.552695	\N
8704	16	2963	2014-12-07 16:16:34.555305	\N
8705	16	2964	2014-12-07 16:16:34.557412	\N
8706	16	2965	2014-12-07 16:16:34.559758	\N
8707	16	2966	2014-12-07 16:16:34.562096	\N
8708	16	2967	2014-12-07 16:16:34.564254	\N
8709	16	2968	2014-12-07 16:16:34.566329	\N
8710	17	2969	2014-12-07 16:16:37.973313	\N
8711	17	2970	2014-12-07 16:16:37.975417	\N
8712	17	2971	2014-12-07 16:16:37.97818	\N
8713	17	2972	2014-12-07 16:16:37.980789	\N
8714	17	2973	2014-12-07 16:16:37.983181	\N
8715	17	2974	2014-12-07 16:16:37.985508	\N
8716	17	2975	2014-12-07 16:16:37.98755	\N
8717	17	2976	2014-12-07 16:16:37.989604	\N
8718	17	2977	2014-12-07 16:16:37.992111	\N
8719	17	2978	2014-12-07 16:16:37.994554	\N
8720	17	2979	2014-12-07 16:16:37.996977	\N
8721	17	2980	2014-12-07 16:16:37.999088	\N
8722	17	2981	2014-12-07 16:16:38.001298	\N
8723	17	2982	2014-12-07 16:16:38.003298	\N
8724	17	2983	2014-12-07 16:16:38.005356	\N
8725	17	2984	2014-12-07 16:16:38.007622	\N
8726	17	2985	2014-12-07 16:16:38.010082	\N
8727	17	2986	2014-12-07 16:16:38.012436	\N
8728	17	2987	2014-12-07 16:16:38.01487	\N
8729	17	2988	2014-12-07 16:16:38.016966	\N
8730	17	2989	2014-12-07 16:16:38.019049	\N
8731	17	2990	2014-12-07 16:16:38.021095	\N
8732	17	2991	2014-12-07 16:16:38.02331	\N
8733	17	2992	2014-12-07 16:16:38.025434	\N
8734	17	2993	2014-12-07 16:16:38.027433	\N
8735	17	2994	2014-12-07 16:16:38.029621	\N
8736	17	2995	2014-12-07 16:16:38.031676	\N
8737	17	2996	2014-12-07 16:16:38.0337	\N
8738	17	2997	2014-12-07 16:16:38.035631	\N
8739	17	2998	2014-12-07 16:16:38.038158	\N
8740	17	2999	2014-12-07 16:16:38.040492	\N
8741	17	3000	2014-12-07 16:16:38.042799	\N
8742	17	3001	2014-12-07 16:16:38.045059	\N
8743	17	3002	2014-12-07 16:16:38.047412	\N
8744	17	3003	2014-12-07 16:16:38.04965	\N
8745	17	3004	2014-12-07 16:16:38.052057	\N
8746	17	3005	2014-12-07 16:16:38.054428	\N
8747	17	3006	2014-12-07 16:16:38.056523	\N
8748	17	3007	2014-12-07 16:16:38.058611	\N
8749	17	3008	2014-12-07 16:16:38.060629	\N
8750	17	3009	2014-12-07 16:16:38.062896	\N
8751	17	3010	2014-12-07 16:16:38.065024	\N
8752	17	3011	2014-12-07 16:16:38.067309	\N
8753	17	3012	2014-12-07 16:16:38.070106	\N
8754	17	3013	2014-12-07 16:16:38.072445	\N
8755	17	3014	2014-12-07 16:16:38.074595	\N
8756	17	3015	2014-12-07 16:16:38.076654	\N
8757	17	3016	2014-12-07 16:16:38.078725	\N
8758	17	3017	2014-12-07 16:16:38.080927	\N
8759	17	3018	2014-12-07 16:16:38.083046	\N
8760	17	3019	2014-12-07 16:16:38.085086	\N
8761	17	3020	2014-12-07 16:16:38.087854	\N
8762	17	3021	2014-12-07 16:16:38.092776	\N
8763	17	3022	2014-12-07 16:16:38.095368	\N
8764	17	3023	2014-12-07 16:16:38.098928	\N
8765	17	3024	2014-12-07 16:16:38.101333	\N
8766	17	3025	2014-12-07 16:16:38.103398	\N
8767	17	3026	2014-12-07 16:16:38.105758	\N
8768	17	3027	2014-12-07 16:16:38.108016	\N
8769	17	3028	2014-12-07 16:16:38.110111	\N
8770	17	3029	2014-12-07 16:16:38.112292	\N
8771	17	3030	2014-12-07 16:16:38.114523	\N
8772	17	3031	2014-12-07 16:16:38.116984	\N
8773	17	3032	2014-12-07 16:16:38.119108	\N
8774	17	3033	2014-12-07 16:16:38.121265	\N
8775	17	3034	2014-12-07 16:16:38.123279	\N
8776	17	3035	2014-12-07 16:16:38.125363	\N
8777	17	3036	2014-12-07 16:16:38.127328	\N
8778	17	3037	2014-12-07 16:16:38.130079	\N
8779	17	3038	2014-12-07 16:16:38.132513	\N
8780	17	3039	2014-12-07 16:16:38.134751	\N
8781	17	3040	2014-12-07 16:16:38.136807	\N
8782	17	3041	2014-12-07 16:16:38.138956	\N
8783	17	3042	2014-12-07 16:16:38.140976	\N
8784	17	3043	2014-12-07 16:16:38.143015	\N
8785	17	3044	2014-12-07 16:16:38.145006	\N
8786	17	3045	2014-12-07 16:16:38.147171	\N
8787	17	3046	2014-12-07 16:16:38.149526	\N
8788	17	3047	2014-12-07 16:16:38.15177	\N
8789	17	3048	2014-12-07 16:16:38.153805	\N
8790	17	3049	2014-12-07 16:16:38.155727	\N
8791	17	3050	2014-12-07 16:16:38.157756	\N
8792	17	3051	2014-12-07 16:16:38.160544	\N
8793	17	3052	2014-12-07 16:16:38.163239	\N
8794	17	3053	2014-12-07 16:16:38.165594	\N
8795	17	3054	2014-12-07 16:16:38.167686	\N
8796	17	3055	2014-12-07 16:16:38.169758	\N
8797	17	3056	2014-12-07 16:16:38.171739	\N
8798	17	3057	2014-12-07 16:16:38.173765	\N
8799	17	3058	2014-12-07 16:16:38.175726	\N
8800	17	3059	2014-12-07 16:16:38.17775	\N
8801	17	3060	2014-12-07 16:16:38.179815	\N
8802	17	3061	2014-12-07 16:16:38.182293	\N
8803	17	3062	2014-12-07 16:16:38.184497	\N
8804	17	3063	2014-12-07 16:16:38.186548	\N
8805	17	3064	2014-12-07 16:16:38.188613	\N
8806	17	3065	2014-12-07 16:16:38.191233	\N
8807	17	3066	2014-12-07 16:16:38.193574	\N
8808	17	3067	2014-12-07 16:16:38.195824	\N
8809	17	3068	2014-12-07 16:16:38.1983	\N
8810	17	3069	2014-12-07 16:16:38.200464	\N
8811	17	3070	2014-12-07 16:16:38.202575	\N
8812	17	3071	2014-12-07 16:16:38.204611	\N
8813	17	3072	2014-12-07 16:16:38.20674	\N
8814	17	3073	2014-12-07 16:16:38.208766	\N
8815	17	3074	2014-12-07 16:16:38.210764	\N
8816	17	3075	2014-12-07 16:16:38.212939	\N
8817	17	3076	2014-12-07 16:16:38.215208	\N
8818	17	3077	2014-12-07 16:16:38.217474	\N
8819	17	3078	2014-12-07 16:16:38.220099	\N
8820	17	3079	2014-12-07 16:16:38.222541	\N
8821	17	3080	2014-12-07 16:16:38.22473	\N
8822	17	3081	2014-12-07 16:16:38.226858	\N
8823	17	3082	2014-12-07 16:16:38.228928	\N
8824	17	3083	2014-12-07 16:16:38.231186	\N
8825	17	3084	2014-12-07 16:16:38.233366	\N
8826	17	3085	2014-12-07 16:16:38.235363	\N
8827	17	3086	2014-12-07 16:16:38.237452	\N
8828	17	3087	2014-12-07 16:16:38.239406	\N
8829	17	3088	2014-12-07 16:16:38.241645	\N
8830	17	3089	2014-12-07 16:16:38.243696	\N
8831	17	3090	2014-12-07 16:16:38.245754	\N
8832	17	3091	2014-12-07 16:16:38.247908	\N
8833	17	3092	2014-12-07 16:16:38.250492	\N
8834	17	3093	2014-12-07 16:16:38.252875	\N
8835	17	3094	2014-12-07 16:16:38.255	\N
8836	17	3095	2014-12-07 16:16:38.257377	\N
8837	17	3096	2014-12-07 16:16:38.259488	\N
8838	17	3097	2014-12-07 16:16:38.261686	\N
8839	17	3098	2014-12-07 16:16:38.26417	\N
8840	17	3099	2014-12-07 16:16:38.266623	\N
8841	17	3100	2014-12-07 16:16:38.26871	\N
8842	17	3101	2014-12-07 16:16:38.270823	\N
8843	17	3102	2014-12-07 16:16:38.272871	\N
8844	17	3103	2014-12-07 16:16:38.275006	\N
8845	17	3104	2014-12-07 16:16:38.277189	\N
8846	17	3105	2014-12-07 16:16:38.279381	\N
8847	17	3106	2014-12-07 16:16:38.282059	\N
8848	17	3107	2014-12-07 16:16:38.284357	\N
8849	17	3108	2014-12-07 16:16:38.286691	\N
8850	17	3109	2014-12-07 16:16:38.289012	\N
8851	17	3110	2014-12-07 16:16:38.291953	\N
8852	17	3111	2014-12-07 16:16:38.294493	\N
8853	17	3112	2014-12-07 16:16:38.297056	\N
8854	17	3113	2014-12-07 16:16:38.299485	\N
8855	17	3114	2014-12-07 16:16:38.301985	\N
8856	17	3115	2014-12-07 16:16:38.304262	\N
8857	17	3116	2014-12-07 16:16:38.306515	\N
8858	17	3117	2014-12-07 16:16:38.308667	\N
8859	17	3118	2014-12-07 16:16:38.3112	\N
8860	17	3119	2014-12-07 16:16:38.313769	\N
8861	17	3120	2014-12-07 16:16:38.315968	\N
8862	17	3121	2014-12-07 16:16:38.318198	\N
8863	17	3122	2014-12-07 16:16:38.320477	\N
8864	17	3123	2014-12-07 16:16:38.322788	\N
8865	17	3124	2014-12-07 16:16:38.324851	\N
8866	17	3125	2014-12-07 16:16:38.326966	\N
8867	17	3126	2014-12-07 16:16:38.329072	\N
8868	17	3127	2014-12-07 16:16:38.331282	\N
8869	17	3128	2014-12-07 16:16:38.333436	\N
8870	17	3129	2014-12-07 16:16:38.335515	\N
8871	17	3130	2014-12-07 16:16:38.337688	\N
8872	17	3131	2014-12-07 16:16:38.340247	\N
8873	17	3132	2014-12-07 16:16:38.342685	\N
8874	17	3133	2014-12-07 16:16:38.344847	\N
8875	17	3134	2014-12-07 16:16:38.347036	\N
8876	17	3135	2014-12-07 16:16:38.34983	\N
8877	17	3136	2014-12-07 16:16:38.352024	\N
8878	17	3137	2014-12-07 16:16:38.354197	\N
8879	17	3138	2014-12-07 16:16:38.356396	\N
8880	17	3139	2014-12-07 16:16:38.358485	\N
8881	17	3140	2014-12-07 16:16:38.360547	\N
8882	17	3141	2014-12-07 16:16:38.362828	\N
8883	17	3142	2014-12-07 16:16:38.365118	\N
8884	17	3143	2014-12-07 16:16:38.367209	\N
8885	17	3144	2014-12-07 16:16:38.36944	\N
8886	17	3145	2014-12-07 16:16:38.37201	\N
8887	17	3146	2014-12-07 16:16:38.374179	\N
8888	17	3147	2014-12-07 16:16:38.376507	\N
8889	17	3148	2014-12-07 16:16:38.378671	\N
8890	17	3149	2014-12-07 16:16:38.381126	\N
8891	17	3150	2014-12-07 16:16:38.383296	\N
8892	17	3151	2014-12-07 16:16:38.385375	\N
8893	17	3152	2014-12-07 16:16:38.387528	\N
8894	17	3153	2014-12-07 16:16:38.389561	\N
8895	17	3154	2014-12-07 16:16:38.391618	\N
8896	17	3155	2014-12-07 16:16:38.393604	\N
8897	17	3156	2014-12-07 16:16:38.395683	\N
8898	17	3157	2014-12-07 16:16:38.397867	\N
8899	17	3158	2014-12-07 16:16:38.400733	\N
8900	17	3159	2014-12-07 16:16:38.403084	\N
8901	17	3160	2014-12-07 16:16:38.405213	\N
8902	17	3161	2014-12-07 16:16:38.407363	\N
8903	17	3162	2014-12-07 16:16:38.40946	\N
8904	17	3163	2014-12-07 16:16:38.411675	\N
8905	17	3164	2014-12-07 16:16:38.413878	\N
8906	17	3165	2014-12-07 16:16:38.416115	\N
8907	17	3166	2014-12-07 16:16:38.418226	\N
8908	17	3167	2014-12-07 16:16:38.420264	\N
8909	17	3168	2014-12-07 16:16:38.422484	\N
8910	17	3169	2014-12-07 16:16:38.424517	\N
8911	17	3170	2014-12-07 16:16:38.426782	\N
8912	17	3171	2014-12-07 16:16:38.428859	\N
8913	17	3172	2014-12-07 16:16:38.431814	\N
8914	17	3173	2014-12-07 16:16:38.434187	\N
8915	17	3174	2014-12-07 16:16:38.436367	\N
8916	17	3175	2014-12-07 16:16:38.438466	\N
8917	17	3176	2014-12-07 16:16:38.440575	\N
8918	17	3177	2014-12-07 16:16:38.442875	\N
8919	17	3178	2014-12-07 16:16:38.444986	\N
8920	17	3179	2014-12-07 16:16:38.447032	\N
8921	17	3180	2014-12-07 16:16:38.449288	\N
8922	17	3181	2014-12-07 16:16:38.451559	\N
8923	17	3182	2014-12-07 16:16:38.453632	\N
8924	17	3183	2014-12-07 16:16:38.455745	\N
8925	17	3184	2014-12-07 16:16:38.457893	\N
8926	17	3185	2014-12-07 16:16:38.460973	\N
8927	17	3186	2014-12-07 16:16:38.46423	\N
8928	17	3187	2014-12-07 16:16:38.466653	\N
8929	17	3188	2014-12-07 16:16:38.468858	\N
8930	17	3189	2014-12-07 16:16:38.471547	\N
8931	17	3190	2014-12-07 16:16:38.474218	\N
8932	17	3191	2014-12-07 16:16:38.476722	\N
8933	17	3192	2014-12-07 16:16:38.479002	\N
8934	17	3193	2014-12-07 16:16:38.508845	\N
8935	17	3194	2014-12-07 16:16:38.511182	\N
8936	17	3195	2014-12-07 16:16:38.513508	\N
8937	17	3196	2014-12-07 16:16:38.515669	\N
8938	17	3197	2014-12-07 16:16:38.517923	\N
8939	17	3198	2014-12-07 16:16:38.520827	\N
8940	17	3199	2014-12-07 16:16:38.523355	\N
8941	17	3200	2014-12-07 16:16:38.525811	\N
8942	17	3201	2014-12-07 16:16:38.528322	\N
8943	17	3202	2014-12-07 16:16:38.530498	\N
8944	17	3203	2014-12-07 16:16:38.532788	\N
8945	17	3204	2014-12-07 16:16:38.536068	\N
8946	17	3205	2014-12-07 16:16:38.540924	\N
8947	17	3206	2014-12-07 16:16:38.543267	\N
8948	17	3207	2014-12-07 16:16:38.547002	\N
8949	17	3208	2014-12-07 16:16:38.550174	\N
8950	17	3209	2014-12-07 16:16:38.553224	\N
8951	17	3210	2014-12-07 16:16:38.556218	\N
8952	17	3211	2014-12-07 16:16:38.558612	\N
8953	17	3212	2014-12-07 16:16:38.560775	\N
8954	17	3213	2014-12-07 16:16:38.563249	\N
8955	17	3214	2014-12-07 16:16:38.567007	\N
8956	18	3215	2014-12-07 16:16:39.747924	\N
8957	18	3216	2014-12-07 16:16:39.750628	\N
8958	18	3217	2014-12-07 16:16:39.753011	\N
8959	18	3218	2014-12-07 16:16:39.756189	\N
8960	18	3219	2014-12-07 16:16:39.759327	\N
8961	18	3220	2014-12-07 16:16:39.763362	\N
8962	18	3221	2014-12-07 16:16:39.766077	\N
8963	18	3222	2014-12-07 16:16:39.768305	\N
8964	18	3223	2014-12-07 16:16:39.770681	\N
8965	18	3224	2014-12-07 16:16:39.772923	\N
8966	18	3225	2014-12-07 16:16:39.775232	\N
8967	18	3226	2014-12-07 16:16:39.777642	\N
8968	18	3227	2014-12-07 16:16:39.779732	\N
8969	18	3228	2014-12-07 16:16:39.781877	\N
8970	18	3229	2014-12-07 16:16:39.784503	\N
8971	18	3230	2014-12-07 16:16:39.787172	\N
8972	18	3231	2014-12-07 16:16:39.789519	\N
8973	18	3232	2014-12-07 16:16:39.791677	\N
8974	18	3233	2014-12-07 16:16:39.793805	\N
8975	18	3234	2014-12-07 16:16:39.796141	\N
8976	18	3235	2014-12-07 16:16:39.798335	\N
8977	18	3236	2014-12-07 16:16:39.800425	\N
8978	18	3237	2014-12-07 16:16:39.802819	\N
8979	18	3238	2014-12-07 16:16:39.805248	\N
8980	18	3239	2014-12-07 16:16:39.807411	\N
8981	18	3240	2014-12-07 16:16:39.809579	\N
8982	18	3241	2014-12-07 16:16:39.811652	\N
8983	18	3242	2014-12-07 16:16:39.813705	\N
8984	18	3243	2014-12-07 16:16:39.818456	\N
8985	18	3244	2014-12-07 16:16:39.821411	\N
8986	18	3245	2014-12-07 16:16:39.823469	\N
8987	18	3246	2014-12-07 16:16:39.826258	\N
8988	18	3247	2014-12-07 16:16:39.828534	\N
8989	18	3248	2014-12-07 16:16:39.830777	\N
8990	18	3249	2014-12-07 16:16:39.833053	\N
8991	18	3250	2014-12-07 16:16:39.837806	\N
8992	18	3251	2014-12-07 16:16:39.841172	\N
8993	18	3252	2014-12-07 16:16:39.844687	\N
8994	18	3253	2014-12-07 16:16:39.847864	\N
8995	18	3254	2014-12-07 16:16:39.85056	\N
8996	18	3255	2014-12-07 16:16:39.853105	\N
8997	18	3256	2014-12-07 16:16:39.856492	\N
8998	18	3257	2014-12-07 16:16:39.858677	\N
8999	18	3258	2014-12-07 16:16:39.86164	\N
9000	18	3259	2014-12-07 16:16:39.870396	\N
9001	18	3260	2014-12-07 16:16:39.875063	\N
9002	18	3261	2014-12-07 16:16:39.877811	\N
9003	18	3262	2014-12-07 16:16:39.880368	\N
9004	18	3263	2014-12-07 16:16:39.882644	\N
9005	18	3264	2014-12-07 16:16:39.885557	\N
9006	18	3265	2014-12-07 16:16:39.888554	\N
9007	18	3266	2014-12-07 16:16:39.890687	\N
9008	18	3267	2014-12-07 16:16:39.892883	\N
9009	18	3268	2014-12-07 16:16:39.896033	\N
9010	18	3269	2014-12-07 16:16:39.898243	\N
9011	18	3270	2014-12-07 16:16:39.900642	\N
9012	18	3271	2014-12-07 16:16:39.902897	\N
9013	18	3272	2014-12-07 16:16:39.906675	\N
9014	18	3273	2014-12-07 16:16:39.909185	\N
9015	18	3274	2014-12-07 16:16:39.911315	\N
9016	18	3275	2014-12-07 16:16:39.914634	\N
9017	18	3276	2014-12-07 16:16:39.917229	\N
9018	18	3277	2014-12-07 16:16:39.920257	\N
9019	18	3278	2014-12-07 16:16:39.92256	\N
9020	18	3279	2014-12-07 16:16:39.92521	\N
9021	18	3280	2014-12-07 16:16:39.927415	\N
9022	18	3281	2014-12-07 16:16:39.929853	\N
9023	18	3282	2014-12-07 16:16:39.932165	\N
9024	19	3283	2014-12-07 16:16:40.024849	\N
9025	20	3284	2014-12-07 16:16:40.689603	\N
9026	20	3285	2014-12-07 16:16:40.692865	\N
9027	20	3286	2014-12-07 16:16:40.695582	\N
9028	20	3287	2014-12-07 16:16:40.697964	\N
9029	20	3288	2014-12-07 16:16:40.700149	\N
9030	20	3289	2014-12-07 16:16:40.702341	\N
9031	20	3290	2014-12-07 16:16:40.704454	\N
9032	20	3291	2014-12-07 16:16:40.706906	\N
9033	20	3292	2014-12-07 16:16:40.70911	\N
9034	20	3293	2014-12-07 16:16:40.711438	\N
9035	20	3294	2014-12-07 16:16:40.713643	\N
9036	20	3295	2014-12-07 16:16:40.715748	\N
9037	20	3296	2014-12-07 16:16:40.717907	\N
9038	20	3297	2014-12-07 16:16:40.720202	\N
9039	20	3298	2014-12-07 16:16:40.723007	\N
9040	20	3299	2014-12-07 16:16:40.725378	\N
9041	20	3300	2014-12-07 16:16:40.727885	\N
9042	20	3301	2014-12-07 16:16:40.730364	\N
9043	20	3302	2014-12-07 16:16:40.73262	\N
9044	20	3303	2014-12-07 16:16:40.73474	\N
9045	20	3304	2014-12-07 16:16:40.736955	\N
9046	20	3305	2014-12-07 16:16:40.739444	\N
9047	20	3306	2014-12-07 16:16:40.741992	\N
9048	20	3307	2014-12-07 16:16:40.744164	\N
9049	20	3308	2014-12-07 16:16:40.746263	\N
9050	20	3309	2014-12-07 16:16:40.748415	\N
9051	20	3310	2014-12-07 16:16:40.751125	\N
9052	20	3311	2014-12-07 16:16:40.753625	\N
9053	20	3312	2014-12-07 16:16:40.756382	\N
9054	20	3313	2014-12-07 16:16:40.758865	\N
9055	20	3314	2014-12-07 16:16:40.761505	\N
9056	20	3315	2014-12-07 16:16:40.764047	\N
9057	20	3316	2014-12-07 16:16:40.766853	\N
9058	20	3317	2014-12-07 16:16:40.770153	\N
9059	20	3318	2014-12-07 16:16:40.774102	\N
9060	20	3319	2014-12-07 16:16:40.77819	\N
9061	21	3320	2014-12-07 16:16:40.866966	\N
9062	22	3321	2014-12-07 16:16:40.996206	\N
9063	22	3322	2014-12-07 16:16:40.998838	\N
9064	22	3323	2014-12-07 16:16:41.001129	\N
9065	23	3324	2014-12-07 16:16:41.357016	\N
9066	23	3325	2014-12-07 16:16:41.359899	\N
9067	23	3326	2014-12-07 16:16:41.362372	\N
9068	23	3327	2014-12-07 16:16:41.364791	\N
9069	23	3328	2014-12-07 16:16:41.367307	\N
9070	23	3329	2014-12-07 16:16:41.369535	\N
9071	23	3330	2014-12-07 16:16:41.371765	\N
9072	23	3331	2014-12-07 16:16:41.374567	\N
9073	23	3332	2014-12-07 16:16:41.377679	\N
9074	23	3333	2014-12-07 16:16:41.381069	\N
9075	23	3334	2014-12-07 16:16:41.384123	\N
9076	23	3335	2014-12-07 16:16:41.386642	\N
9077	23	3336	2014-12-07 16:16:41.388868	\N
9078	23	3337	2014-12-07 16:16:41.391189	\N
9079	23	3338	2014-12-07 16:16:41.393773	\N
9080	23	3339	2014-12-07 16:16:41.396095	\N
9081	23	3340	2014-12-07 16:16:41.398298	\N
9082	23	3341	2014-12-07 16:16:41.40075	\N
9083	24	3342	2014-12-07 16:16:42.507383	\N
9084	24	3343	2014-12-07 16:16:42.509941	\N
9085	24	3344	2014-12-07 16:16:42.512431	\N
9086	24	3345	2014-12-07 16:16:42.514749	\N
9087	24	3346	2014-12-07 16:16:42.517039	\N
9088	24	3347	2014-12-07 16:16:42.519068	\N
9089	24	3348	2014-12-07 16:16:42.521165	\N
9090	24	3349	2014-12-07 16:16:42.52321	\N
9091	24	3350	2014-12-07 16:16:42.525216	\N
9092	24	3351	2014-12-07 16:16:42.527199	\N
9093	24	3352	2014-12-07 16:16:42.530037	\N
9094	24	3353	2014-12-07 16:16:42.532415	\N
9095	24	3354	2014-12-07 16:16:42.5347	\N
9096	24	3355	2014-12-07 16:16:42.536798	\N
9097	24	3356	2014-12-07 16:16:42.538905	\N
9098	24	3357	2014-12-07 16:16:42.541021	\N
9099	24	3358	2014-12-07 16:16:42.543027	\N
9100	24	3359	2014-12-07 16:16:42.545287	\N
9101	24	3360	2014-12-07 16:16:42.547375	\N
9102	24	3361	2014-12-07 16:16:42.549467	\N
9103	24	3362	2014-12-07 16:16:42.551641	\N
9104	24	3363	2014-12-07 16:16:42.553821	\N
9105	24	3364	2014-12-07 16:16:42.555946	\N
9106	24	3365	2014-12-07 16:16:42.558326	\N
9107	24	3366	2014-12-07 16:16:42.560737	\N
9108	24	3367	2014-12-07 16:16:42.563236	\N
9109	24	3368	2014-12-07 16:16:42.565618	\N
9110	24	3369	2014-12-07 16:16:42.567721	\N
9111	24	3370	2014-12-07 16:16:42.569855	\N
9112	24	3371	2014-12-07 16:16:42.572119	\N
9113	24	3372	2014-12-07 16:16:42.574261	\N
9114	24	3373	2014-12-07 16:16:42.576298	\N
9115	24	3374	2014-12-07 16:16:42.578964	\N
9116	24	3375	2014-12-07 16:16:42.582507	\N
9117	24	3376	2014-12-07 16:16:42.585834	\N
9118	24	3377	2014-12-07 16:16:42.588474	\N
9119	24	3378	2014-12-07 16:16:42.591276	\N
9120	24	3379	2014-12-07 16:16:42.593495	\N
9121	24	3380	2014-12-07 16:16:42.59596	\N
9122	24	3381	2014-12-07 16:16:42.598377	\N
9123	24	3382	2014-12-07 16:16:42.600741	\N
9124	24	3383	2014-12-07 16:16:42.602977	\N
9125	24	3384	2014-12-07 16:16:42.605101	\N
9126	24	3385	2014-12-07 16:16:42.607114	\N
9127	24	3386	2014-12-07 16:16:42.609186	\N
9128	24	3387	2014-12-07 16:16:42.61121	\N
9129	24	3388	2014-12-07 16:16:42.613357	\N
9130	24	3389	2014-12-07 16:16:42.615395	\N
9131	24	3390	2014-12-07 16:16:42.617486	\N
9132	24	3391	2014-12-07 16:16:42.62013	\N
9133	24	3392	2014-12-07 16:16:42.622511	\N
9134	24	3393	2014-12-07 16:16:42.624687	\N
9135	24	3394	2014-12-07 16:16:42.626783	\N
9136	24	3395	2014-12-07 16:16:42.629172	\N
9137	24	3396	2014-12-07 16:16:42.631537	\N
9138	24	3397	2014-12-07 16:16:42.633696	\N
9139	24	3398	2014-12-07 16:16:42.635734	\N
9140	24	3399	2014-12-07 16:16:42.637821	\N
9141	24	3400	2014-12-07 16:16:42.640009	\N
9142	24	3401	2014-12-07 16:16:42.642304	\N
9143	24	3402	2014-12-07 16:16:42.644397	\N
9144	24	3403	2014-12-07 16:16:42.646786	\N
9145	24	3404	2014-12-07 16:16:42.649368	\N
9146	24	3405	2014-12-07 16:16:42.651703	\N
9147	24	3406	2014-12-07 16:16:42.653898	\N
9148	25	3407	2014-12-07 16:16:43.44344	\N
9149	25	3408	2014-12-07 16:16:43.446295	\N
9150	25	3409	2014-12-07 16:16:43.449096	\N
9151	25	3410	2014-12-07 16:16:43.451425	\N
9152	25	3411	2014-12-07 16:16:43.45359	\N
9153	25	3412	2014-12-07 16:16:43.455677	\N
9154	25	3413	2014-12-07 16:16:43.458041	\N
9155	25	3414	2014-12-07 16:16:43.461716	\N
9156	25	3415	2014-12-07 16:16:43.466282	\N
9157	25	3416	2014-12-07 16:16:43.468635	\N
9158	25	3417	2014-12-07 16:16:43.47118	\N
9159	25	3418	2014-12-07 16:16:43.474187	\N
9160	25	3419	2014-12-07 16:16:43.476705	\N
9161	25	3420	2014-12-07 16:16:43.479027	\N
9162	25	3421	2014-12-07 16:16:43.481464	\N
9163	25	3422	2014-12-07 16:16:43.483653	\N
9164	25	3423	2014-12-07 16:16:43.485982	\N
9165	25	3424	2014-12-07 16:16:43.488117	\N
9166	25	3425	2014-12-07 16:16:43.490636	\N
9167	25	3426	2014-12-07 16:16:43.493196	\N
9168	25	3427	2014-12-07 16:16:43.495417	\N
9169	25	3428	2014-12-07 16:16:43.497559	\N
9170	25	3429	2014-12-07 16:16:43.499618	\N
9171	25	3430	2014-12-07 16:16:43.50174	\N
9172	25	3431	2014-12-07 16:16:43.504082	\N
9173	25	3432	2014-12-07 16:16:43.506176	\N
9174	25	3433	2014-12-07 16:16:43.508241	\N
9175	25	3434	2014-12-07 16:16:43.510529	\N
9176	25	3435	2014-12-07 16:16:43.512623	\N
9177	25	3436	2014-12-07 16:16:43.514702	\N
9178	25	3437	2014-12-07 16:16:43.516841	\N
9179	25	3438	2014-12-07 16:16:43.518894	\N
9180	25	3439	2014-12-07 16:16:43.521561	\N
9181	25	3440	2014-12-07 16:16:43.523821	\N
9182	25	3441	2014-12-07 16:16:43.525995	\N
9183	25	3442	2014-12-07 16:16:43.528072	\N
9184	25	3443	2014-12-07 16:16:43.530386	\N
9185	25	3444	2014-12-07 16:16:43.533037	\N
9186	25	3445	2014-12-07 16:16:43.535184	\N
9187	25	3446	2014-12-07 16:16:43.537262	\N
9188	25	3447	2014-12-07 16:16:43.539268	\N
9189	25	3448	2014-12-07 16:16:43.541413	\N
9190	25	3449	2014-12-07 16:16:43.543545	\N
9191	26	3450	2014-12-07 16:16:44.176993	\N
9192	26	3451	2014-12-07 16:16:44.179587	\N
9193	26	3452	2014-12-07 16:16:44.182282	\N
9194	26	3453	2014-12-07 16:16:44.184839	\N
9195	26	3454	2014-12-07 16:16:44.187098	\N
9196	26	3455	2014-12-07 16:16:44.189335	\N
9197	26	3456	2014-12-07 16:16:44.191582	\N
9198	26	3457	2014-12-07 16:16:44.194071	\N
9199	26	3458	2014-12-07 16:16:44.19619	\N
9200	26	3459	2014-12-07 16:16:44.198245	\N
9201	26	3460	2014-12-07 16:16:44.200285	\N
9202	26	3461	2014-12-07 16:16:44.202506	\N
9203	26	3462	2014-12-07 16:16:44.204548	\N
9204	26	3463	2014-12-07 16:16:44.206602	\N
9205	26	3464	2014-12-07 16:16:44.208607	\N
9206	26	3465	2014-12-07 16:16:44.211331	\N
9207	26	3466	2014-12-07 16:16:44.213822	\N
9208	26	3467	2014-12-07 16:16:44.215964	\N
9209	26	3468	2014-12-07 16:16:44.218261	\N
9210	26	3469	2014-12-07 16:16:44.220481	\N
9211	26	3470	2014-12-07 16:16:44.222557	\N
9212	26	3471	2014-12-07 16:16:44.224807	\N
9213	26	3472	2014-12-07 16:16:44.226932	\N
9214	26	3473	2014-12-07 16:16:44.22895	\N
9215	26	3474	2014-12-07 16:16:44.230976	\N
9216	26	3475	2014-12-07 16:16:44.23314	\N
9217	26	3476	2014-12-07 16:16:44.235229	\N
9218	26	3461	2014-12-07 16:16:44.237308	\N
9219	26	3477	2014-12-07 16:16:44.239287	\N
9220	26	3478	2014-12-07 16:16:44.242036	\N
9221	26	3479	2014-12-07 16:16:44.24455	\N
9222	26	3480	2014-12-07 16:16:44.246786	\N
9223	26	3481	2014-12-07 16:16:44.248913	\N
9224	27	3482	2014-12-07 16:16:44.650726	\N
9225	27	3483	2014-12-07 16:16:44.653439	\N
9226	27	3484	2014-12-07 16:16:44.655586	\N
9227	27	3485	2014-12-07 16:16:44.657648	\N
9228	27	3486	2014-12-07 16:16:44.659712	\N
9229	27	3487	2014-12-07 16:16:44.662309	\N
9230	27	3488	2014-12-07 16:16:44.664619	\N
9231	27	3489	2014-12-07 16:16:44.666673	\N
9232	27	3490	2014-12-07 16:16:44.668944	\N
9233	27	3491	2014-12-07 16:16:44.671318	\N
9234	27	3492	2014-12-07 16:16:44.673457	\N
9235	27	3493	2014-12-07 16:16:44.675476	\N
9236	27	3494	2014-12-07 16:16:44.677528	\N
9237	27	3495	2014-12-07 16:16:44.679742	\N
9238	27	3496	2014-12-07 16:16:44.682159	\N
9239	27	3497	2014-12-07 16:16:44.684302	\N
9240	28	3498	2014-12-07 16:16:44.856617	\N
9241	28	3499	2014-12-07 16:16:44.858971	\N
9242	28	3500	2014-12-07 16:16:44.861077	\N
9243	28	3501	2014-12-07 16:16:44.863141	\N
9244	28	3502	2014-12-07 16:16:44.865285	\N
9245	29	3503	2014-12-07 16:16:45.016582	\N
9246	29	3504	2014-12-07 16:16:45.019149	\N
9247	29	3505	2014-12-07 16:16:45.022713	\N
9248	30	3506	2014-12-07 16:16:45.157202	\N
9249	30	3507	2014-12-07 16:16:45.15986	\N
9250	31	3508	2014-12-07 16:16:45.269481	\N
9251	32	3509	2014-12-07 16:16:45.386977	\N
9252	33	3510	2014-12-07 16:16:45.528268	\N
9253	33	3511	2014-12-07 16:16:45.531024	\N
9254	34	3512	2014-12-07 16:16:45.65409	\N
9255	35	3513	2014-12-07 16:16:53.123877	\N
9256	35	3514	2014-12-07 16:16:53.127373	\N
9257	35	3515	2014-12-07 16:16:53.130439	\N
9258	35	3516	2014-12-07 16:16:53.133089	\N
9259	35	3517	2014-12-07 16:16:53.135377	\N
9260	35	3518	2014-12-07 16:16:53.137749	\N
9261	35	3519	2014-12-07 16:16:53.140439	\N
9262	35	3520	2014-12-07 16:16:53.142702	\N
9263	35	3521	2014-12-07 16:16:53.144751	\N
9264	35	3522	2014-12-07 16:16:53.146837	\N
9265	35	3523	2014-12-07 16:16:53.149043	\N
9266	35	3524	2014-12-07 16:16:53.151305	\N
9267	35	3525	2014-12-07 16:16:53.15348	\N
9268	35	3526	2014-12-07 16:16:53.155504	\N
9269	35	3527	2014-12-07 16:16:53.157501	\N
9270	35	3528	2014-12-07 16:16:53.159479	\N
9271	35	3529	2014-12-07 16:16:53.161612	\N
9272	35	3530	2014-12-07 16:16:53.163675	\N
9273	35	3531	2014-12-07 16:16:53.166298	\N
9274	35	3532	2014-12-07 16:16:53.168466	\N
9275	35	3533	2014-12-07 16:16:53.171187	\N
9276	35	3534	2014-12-07 16:16:53.173592	\N
9277	35	3535	2014-12-07 16:16:53.175827	\N
9278	35	3536	2014-12-07 16:16:53.178164	\N
9279	35	3537	2014-12-07 16:16:53.180402	\N
9280	35	3538	2014-12-07 16:16:53.18286	\N
9281	35	3539	2014-12-07 16:16:53.185045	\N
9282	35	3540	2014-12-07 16:16:53.187118	\N
9283	35	3541	2014-12-07 16:16:53.189192	\N
9284	35	3542	2014-12-07 16:16:53.19116	\N
9285	35	3543	2014-12-07 16:16:53.193185	\N
9286	35	3544	2014-12-07 16:16:53.19516	\N
9287	35	3545	2014-12-07 16:16:53.197456	\N
9288	35	3546	2014-12-07 16:16:53.200442	\N
9289	35	3547	2014-12-07 16:16:53.202859	\N
9290	35	3548	2014-12-07 16:16:53.205004	\N
9291	35	3549	2014-12-07 16:16:53.20707	\N
9292	35	3550	2014-12-07 16:16:53.209234	\N
9293	35	3551	2014-12-07 16:16:53.212743	\N
9294	35	3552	2014-12-07 16:16:53.215347	\N
9295	35	3553	2014-12-07 16:16:53.217723	\N
9296	35	3554	2014-12-07 16:16:53.219818	\N
9297	35	3555	2014-12-07 16:16:53.222069	\N
9298	35	3556	2014-12-07 16:16:53.224102	\N
9299	35	3557	2014-12-07 16:16:53.226309	\N
9300	35	3558	2014-12-07 16:16:53.228772	\N
9301	35	3559	2014-12-07 16:16:53.231682	\N
9302	35	3560	2014-12-07 16:16:53.234209	\N
9303	35	3561	2014-12-07 16:16:53.236456	\N
9304	35	3562	2014-12-07 16:16:53.238767	\N
9305	35	3563	2014-12-07 16:16:53.241001	\N
9306	35	3564	2014-12-07 16:16:53.244879	\N
9307	35	3565	2014-12-07 16:16:53.249607	\N
9308	35	3566	2014-12-07 16:16:53.251975	\N
9309	35	3567	2014-12-07 16:16:53.254095	\N
9310	35	3568	2014-12-07 16:16:53.256178	\N
9311	35	3569	2014-12-07 16:16:53.258419	\N
9312	35	3570	2014-12-07 16:16:53.286539	\N
9313	35	3571	2014-12-07 16:16:53.288972	\N
9314	35	3572	2014-12-07 16:16:53.291576	\N
9315	35	3573	2014-12-07 16:16:53.294026	\N
9316	35	3574	2014-12-07 16:16:53.296175	\N
9317	35	3575	2014-12-07 16:16:53.29838	\N
9318	35	3576	2014-12-07 16:16:53.300563	\N
9319	35	3577	2014-12-07 16:16:53.302758	\N
9320	35	3578	2014-12-07 16:16:53.304957	\N
9321	35	3579	2014-12-07 16:16:53.307127	\N
9322	35	3580	2014-12-07 16:16:53.309153	\N
9323	35	3581	2014-12-07 16:16:53.311162	\N
9324	35	3582	2014-12-07 16:16:53.313412	\N
9325	35	3583	2014-12-07 16:16:53.315512	\N
9326	35	3584	2014-12-07 16:16:53.31775	\N
9327	35	3585	2014-12-07 16:16:53.320256	\N
9328	35	3586	2014-12-07 16:16:53.322732	\N
9329	35	3587	2014-12-07 16:16:53.324896	\N
9330	35	3588	2014-12-07 16:16:53.327012	\N
9331	35	3589	2014-12-07 16:16:53.32911	\N
9332	35	3590	2014-12-07 16:16:53.331218	\N
9333	35	3591	2014-12-07 16:16:53.33335	\N
9334	35	3592	2014-12-07 16:16:53.335308	\N
9335	35	3593	2014-12-07 16:16:53.337807	\N
9336	35	3594	2014-12-07 16:16:53.340066	\N
9337	35	3595	2014-12-07 16:16:53.342121	\N
9338	35	3596	2014-12-07 16:16:53.344172	\N
9339	35	3597	2014-12-07 16:16:53.346199	\N
9340	35	3598	2014-12-07 16:16:53.348263	\N
9341	35	3599	2014-12-07 16:16:53.351218	\N
9342	35	3600	2014-12-07 16:16:53.353546	\N
9343	35	3601	2014-12-07 16:16:53.35581	\N
9344	35	3602	2014-12-07 16:16:53.357884	\N
9345	35	3603	2014-12-07 16:16:53.360055	\N
9346	35	3604	2014-12-07 16:16:53.362089	\N
9347	35	3605	2014-12-07 16:16:53.364286	\N
9348	35	3606	2014-12-07 16:16:53.368119	\N
9349	35	3607	2014-12-07 16:16:53.372274	\N
9350	35	3608	2014-12-07 16:16:53.374607	\N
9351	35	3609	2014-12-07 16:16:53.377318	\N
9352	35	3610	2014-12-07 16:16:53.380138	\N
9353	35	3611	2014-12-07 16:16:53.383287	\N
9354	35	3612	2014-12-07 16:16:53.385613	\N
9355	35	3613	2014-12-07 16:16:53.387807	\N
9356	35	3614	2014-12-07 16:16:53.389927	\N
9357	35	3615	2014-12-07 16:16:53.392505	\N
9358	35	3616	2014-12-07 16:16:53.395421	\N
9359	35	3617	2014-12-07 16:16:53.397928	\N
9360	35	3618	2014-12-07 16:16:53.400187	\N
9361	35	3619	2014-12-07 16:16:53.402316	\N
9362	35	3620	2014-12-07 16:16:53.404377	\N
9363	35	3621	2014-12-07 16:16:53.406419	\N
9364	35	3622	2014-12-07 16:16:53.411338	\N
9365	35	3623	2014-12-07 16:16:53.417691	\N
9366	35	3624	2014-12-07 16:16:53.42069	\N
9367	35	3625	2014-12-07 16:16:53.423603	\N
9368	35	3626	2014-12-07 16:16:53.425961	\N
9369	35	3627	2014-12-07 16:16:53.428336	\N
9370	35	3628	2014-12-07 16:16:53.432462	\N
9371	35	3629	2014-12-07 16:16:53.434828	\N
9372	35	3630	2014-12-07 16:16:53.437019	\N
9373	35	3631	2014-12-07 16:16:53.439201	\N
9374	35	3632	2014-12-07 16:16:53.442039	\N
9375	35	3633	2014-12-07 16:16:53.44456	\N
9376	35	3634	2014-12-07 16:16:53.446793	\N
9377	35	3635	2014-12-07 16:16:53.449228	\N
9378	35	3636	2014-12-07 16:16:53.451508	\N
9379	35	3637	2014-12-07 16:16:53.453695	\N
9380	35	3638	2014-12-07 16:16:53.456013	\N
9381	35	3639	2014-12-07 16:16:53.458247	\N
9382	35	3640	2014-12-07 16:16:53.461045	\N
9383	35	3641	2014-12-07 16:16:53.463988	\N
9384	35	3642	2014-12-07 16:16:53.467195	\N
9385	35	3643	2014-12-07 16:16:53.469681	\N
9386	35	3644	2014-12-07 16:16:53.472674	\N
9387	35	3645	2014-12-07 16:16:53.475372	\N
9388	35	3646	2014-12-07 16:16:53.477705	\N
9389	35	3647	2014-12-07 16:16:53.480035	\N
9390	35	3648	2014-12-07 16:16:53.482187	\N
9391	35	3649	2014-12-07 16:16:53.484494	\N
9392	35	3650	2014-12-07 16:16:53.486582	\N
9393	35	3651	2014-12-07 16:16:53.488693	\N
9394	35	3652	2014-12-07 16:16:53.490808	\N
9395	35	3653	2014-12-07 16:16:53.493103	\N
9396	35	3654	2014-12-07 16:16:53.495139	\N
9397	35	3655	2014-12-07 16:16:53.497253	\N
9398	35	3656	2014-12-07 16:16:53.499367	\N
9399	35	3657	2014-12-07 16:16:53.502064	\N
9400	35	3658	2014-12-07 16:16:53.504625	\N
9401	35	3659	2014-12-07 16:16:53.506871	\N
9402	35	3660	2014-12-07 16:16:53.508959	\N
9403	35	3661	2014-12-07 16:16:53.51108	\N
9404	35	3662	2014-12-07 16:16:53.513153	\N
9405	35	3663	2014-12-07 16:16:53.515193	\N
9406	35	3664	2014-12-07 16:16:53.517312	\N
9407	35	3665	2014-12-07 16:16:53.519298	\N
9408	35	3666	2014-12-07 16:16:53.521352	\N
9409	35	3667	2014-12-07 16:16:53.523424	\N
9410	35	3668	2014-12-07 16:16:53.527511	\N
9411	35	3669	2014-12-07 16:16:53.531187	\N
9412	35	3670	2014-12-07 16:16:53.534131	\N
9413	35	3671	2014-12-07 16:16:53.5364	\N
9414	35	3672	2014-12-07 16:16:53.538551	\N
9415	35	3673	2014-12-07 16:16:53.540696	\N
9416	35	3674	2014-12-07 16:16:53.542801	\N
9417	35	3675	2014-12-07 16:16:53.545521	\N
9418	35	3676	2014-12-07 16:16:53.547862	\N
9419	35	3677	2014-12-07 16:16:53.550432	\N
9420	35	3678	2014-12-07 16:16:53.552878	\N
9421	35	3679	2014-12-07 16:16:53.555023	\N
9422	35	3680	2014-12-07 16:16:53.558195	\N
9423	35	3681	2014-12-07 16:16:53.56036	\N
9424	35	3682	2014-12-07 16:16:53.564202	\N
9425	35	3683	2014-12-07 16:16:53.569495	\N
9426	35	3684	2014-12-07 16:16:53.571831	\N
9427	35	3685	2014-12-07 16:16:53.574147	\N
9428	35	3686	2014-12-07 16:16:53.576383	\N
9429	35	3687	2014-12-07 16:16:53.578573	\N
9430	35	3688	2014-12-07 16:16:53.580701	\N
9431	35	3689	2014-12-07 16:16:53.582994	\N
9432	35	3690	2014-12-07 16:16:53.585783	\N
9433	35	3691	2014-12-07 16:16:53.588059	\N
9434	35	3692	2014-12-07 16:16:53.591294	\N
9435	35	3693	2014-12-07 16:16:53.59459	\N
9436	35	3694	2014-12-07 16:16:53.59684	\N
9437	35	3695	2014-12-07 16:16:53.599169	\N
9438	35	3696	2014-12-07 16:16:53.601468	\N
9439	35	3697	2014-12-07 16:16:53.603468	\N
9440	35	3698	2014-12-07 16:16:53.605489	\N
9441	35	3699	2014-12-07 16:16:53.607504	\N
9442	35	3700	2014-12-07 16:16:53.609589	\N
9443	35	3701	2014-12-07 16:16:53.611881	\N
9444	35	3702	2014-12-07 16:16:53.61399	\N
9445	35	3703	2014-12-07 16:16:53.616259	\N
9446	35	3704	2014-12-07 16:16:53.618447	\N
9447	35	3705	2014-12-07 16:16:53.620575	\N
9448	35	3706	2014-12-07 16:16:53.623232	\N
9449	35	3707	2014-12-07 16:16:53.625515	\N
9450	35	3708	2014-12-07 16:16:53.627533	\N
9451	35	3709	2014-12-07 16:16:53.629756	\N
9452	35	3710	2014-12-07 16:16:53.632231	\N
9453	35	3711	2014-12-07 16:16:53.634443	\N
9454	35	3712	2014-12-07 16:16:53.636524	\N
9455	35	3713	2014-12-07 16:16:53.638617	\N
9456	35	3714	2014-12-07 16:16:53.640674	\N
9457	35	3715	2014-12-07 16:16:53.642726	\N
9458	35	3716	2014-12-07 16:16:53.644778	\N
9459	35	3717	2014-12-07 16:16:53.646984	\N
9460	35	3718	2014-12-07 16:16:53.649622	\N
9461	35	3719	2014-12-07 16:16:53.653275	\N
9462	35	3720	2014-12-07 16:16:53.655533	\N
9463	35	3721	2014-12-07 16:16:53.657688	\N
9464	35	3722	2014-12-07 16:16:53.659948	\N
9465	35	3723	2014-12-07 16:16:53.662776	\N
9466	35	3724	2014-12-07 16:16:53.665338	\N
9467	35	3725	2014-12-07 16:16:53.668251	\N
9468	35	3726	2014-12-07 16:16:53.670614	\N
9469	35	3727	2014-12-07 16:16:53.672775	\N
9470	35	3728	2014-12-07 16:16:53.674867	\N
9471	35	3729	2014-12-07 16:16:53.677211	\N
9472	35	3730	2014-12-07 16:16:53.67968	\N
9473	35	3731	2014-12-07 16:16:53.683063	\N
9474	35	3732	2014-12-07 16:16:53.685762	\N
9475	35	3733	2014-12-07 16:16:53.688087	\N
9476	35	3734	2014-12-07 16:16:53.690381	\N
9477	35	3735	2014-12-07 16:16:53.692959	\N
9478	35	3736	2014-12-07 16:16:53.695349	\N
9479	35	3737	2014-12-07 16:16:53.697773	\N
9480	35	3738	2014-12-07 16:16:53.700552	\N
9481	35	3739	2014-12-07 16:16:53.703014	\N
9482	35	3740	2014-12-07 16:16:53.705701	\N
9483	35	3741	2014-12-07 16:16:53.707865	\N
9484	35	3742	2014-12-07 16:16:53.710555	\N
9485	35	3743	2014-12-07 16:16:53.714715	\N
9486	35	3744	2014-12-07 16:16:53.718772	\N
9487	35	3745	2014-12-07 16:16:53.721065	\N
9488	35	3746	2014-12-07 16:16:53.72315	\N
9489	35	3747	2014-12-07 16:16:53.725434	\N
9490	35	3748	2014-12-07 16:16:53.727716	\N
9491	35	3749	2014-12-07 16:16:53.729864	\N
9492	35	3750	2014-12-07 16:16:53.731889	\N
9493	35	3751	2014-12-07 16:16:53.734821	\N
9494	35	3752	2014-12-07 16:16:53.737271	\N
9495	35	3753	2014-12-07 16:16:53.739318	\N
9496	35	3754	2014-12-07 16:16:53.742278	\N
9497	35	3755	2014-12-07 16:16:53.744791	\N
9498	35	3756	2014-12-07 16:16:53.746973	\N
9499	35	3757	2014-12-07 16:16:53.749122	\N
9500	35	3758	2014-12-07 16:16:53.751879	\N
9501	35	3759	2014-12-07 16:16:53.754656	\N
9502	35	3760	2014-12-07 16:16:53.756904	\N
9503	35	3761	2014-12-07 16:16:53.759068	\N
9504	35	3762	2014-12-07 16:16:53.761404	\N
9505	35	3763	2014-12-07 16:16:53.763711	\N
9506	35	3764	2014-12-07 16:16:53.766059	\N
9507	35	3765	2014-12-07 16:16:53.768261	\N
9508	35	3766	2014-12-07 16:16:53.770453	\N
9509	35	3767	2014-12-07 16:16:53.773252	\N
9510	35	3768	2014-12-07 16:16:53.775486	\N
9511	35	3769	2014-12-07 16:16:53.777805	\N
9512	35	3770	2014-12-07 16:16:53.780126	\N
9513	35	3771	2014-12-07 16:16:53.78226	\N
9514	35	3772	2014-12-07 16:16:53.784597	\N
9515	35	3773	2014-12-07 16:16:53.78699	\N
9516	35	3774	2014-12-07 16:16:53.789145	\N
9517	35	3775	2014-12-07 16:16:53.79127	\N
9518	35	3776	2014-12-07 16:16:53.79338	\N
9519	35	3777	2014-12-07 16:16:53.795496	\N
9520	35	3778	2014-12-07 16:16:53.797577	\N
9521	35	3779	2014-12-07 16:16:53.799477	\N
9522	35	3780	2014-12-07 16:16:53.802405	\N
9523	35	3781	2014-12-07 16:16:53.80479	\N
9524	35	3782	2014-12-07 16:16:53.807229	\N
9525	35	3783	2014-12-07 16:16:53.809505	\N
9526	35	3784	2014-12-07 16:16:53.811561	\N
9527	35	3785	2014-12-07 16:16:53.813612	\N
9528	35	3786	2014-12-07 16:16:53.815601	\N
9529	35	3787	2014-12-07 16:16:53.817744	\N
9530	35	3788	2014-12-07 16:16:53.819792	\N
9531	35	3789	2014-12-07 16:16:53.821988	\N
9532	35	3790	2014-12-07 16:16:53.824195	\N
9533	35	3791	2014-12-07 16:16:53.82636	\N
9534	35	3792	2014-12-07 16:16:53.828409	\N
9535	35	3793	2014-12-07 16:16:53.83048	\N
9536	35	3794	2014-12-07 16:16:53.833289	\N
9537	35	3795	2014-12-07 16:16:53.835707	\N
9538	35	3796	2014-12-07 16:16:53.837871	\N
9539	35	3797	2014-12-07 16:16:53.840213	\N
9540	35	3798	2014-12-07 16:16:53.84232	\N
9541	35	3799	2014-12-07 16:16:53.844421	\N
9542	35	3800	2014-12-07 16:16:53.846467	\N
9543	35	3801	2014-12-07 16:16:53.84887	\N
9544	35	3802	2014-12-07 16:16:53.851734	\N
9545	35	3803	2014-12-07 16:16:53.854212	\N
9546	35	3804	2014-12-07 16:16:53.856408	\N
9547	35	3805	2014-12-07 16:16:53.858522	\N
9548	35	3806	2014-12-07 16:16:53.860626	\N
9549	35	3807	2014-12-07 16:16:53.863954	\N
9550	35	3808	2014-12-07 16:16:53.866982	\N
9551	35	3809	2014-12-07 16:16:53.869353	\N
9552	35	3810	2014-12-07 16:16:53.871453	\N
9553	35	3811	2014-12-07 16:16:53.873616	\N
9554	35	3812	2014-12-07 16:16:53.875626	\N
9555	35	3813	2014-12-07 16:16:53.877819	\N
9556	35	3814	2014-12-07 16:16:53.881089	\N
9557	35	3815	2014-12-07 16:16:53.886354	\N
9558	35	3816	2014-12-07 16:16:53.88881	\N
9559	35	3817	2014-12-07 16:16:53.891273	\N
9560	35	3818	2014-12-07 16:16:53.89391	\N
9561	35	3819	2014-12-07 16:16:53.896251	\N
9562	35	3820	2014-12-07 16:16:53.898409	\N
9563	35	3821	2014-12-07 16:16:53.901375	\N
9564	35	3822	2014-12-07 16:16:53.903746	\N
9565	35	3823	2014-12-07 16:16:53.905997	\N
9566	35	3824	2014-12-07 16:16:53.90817	\N
9567	35	3825	2014-12-07 16:16:53.910487	\N
9568	35	3826	2014-12-07 16:16:53.912815	\N
9569	35	3827	2014-12-07 16:16:53.915318	\N
9570	35	3828	2014-12-07 16:16:53.917639	\N
9571	35	3829	2014-12-07 16:16:53.919696	\N
9572	35	3830	2014-12-07 16:16:53.922343	\N
9573	35	3831	2014-12-07 16:16:53.924737	\N
9574	35	3832	2014-12-07 16:16:53.926877	\N
9575	35	3833	2014-12-07 16:16:53.929343	\N
9576	35	3834	2014-12-07 16:16:53.931422	\N
9577	35	3835	2014-12-07 16:16:53.933658	\N
9578	35	3836	2014-12-07 16:16:53.935934	\N
9579	35	3837	2014-12-07 16:16:53.938052	\N
9580	35	3838	2014-12-07 16:16:53.9402	\N
9581	35	3839	2014-12-07 16:16:53.942255	\N
9582	35	3840	2014-12-07 16:16:53.944368	\N
9583	35	3841	2014-12-07 16:16:53.946416	\N
9584	35	3842	2014-12-07 16:16:53.948745	\N
9585	35	3843	2014-12-07 16:16:53.951233	\N
9586	35	3844	2014-12-07 16:16:53.953805	\N
9587	35	3845	2014-12-07 16:16:53.95612	\N
9588	35	3846	2014-12-07 16:16:53.958302	\N
9589	35	3847	2014-12-07 16:16:53.960429	\N
9590	35	3848	2014-12-07 16:16:53.962732	\N
9591	35	3849	2014-12-07 16:16:53.964851	\N
9592	35	3850	2014-12-07 16:16:53.966984	\N
9593	35	3851	2014-12-07 16:16:53.969287	\N
9594	35	3852	2014-12-07 16:16:53.971337	\N
9595	35	3853	2014-12-07 16:16:53.973418	\N
9596	35	3854	2014-12-07 16:16:53.975438	\N
9597	35	3855	2014-12-07 16:16:53.977697	\N
9598	35	3856	2014-12-07 16:16:53.979683	\N
9599	35	3857	2014-12-07 16:16:53.982281	\N
9600	35	3858	2014-12-07 16:16:53.98475	\N
9601	35	3859	2014-12-07 16:16:53.987011	\N
9602	35	3860	2014-12-07 16:16:53.989215	\N
9603	35	3861	2014-12-07 16:16:53.991308	\N
9604	36	3862	2014-12-07 16:16:55.073694	\N
9605	36	3863	2014-12-07 16:16:55.076497	\N
9606	36	3864	2014-12-07 16:16:55.078985	\N
9607	36	3865	2014-12-07 16:16:55.08141	\N
9608	36	3866	2014-12-07 16:16:55.083517	\N
9609	36	3867	2014-12-07 16:16:55.086044	\N
9610	36	3868	2014-12-07 16:16:55.088506	\N
9611	36	3869	2014-12-07 16:16:55.092062	\N
9612	36	3870	2014-12-07 16:16:55.094911	\N
9613	36	3871	2014-12-07 16:16:55.09764	\N
9614	36	3872	2014-12-07 16:16:55.099794	\N
9615	36	3873	2014-12-07 16:16:55.102082	\N
9616	36	3874	2014-12-07 16:16:55.104451	\N
9617	36	3875	2014-12-07 16:16:55.107037	\N
9618	36	3876	2014-12-07 16:16:55.110677	\N
9619	36	3877	2014-12-07 16:16:55.114167	\N
9620	36	3878	2014-12-07 16:16:55.116555	\N
9621	36	3879	2014-12-07 16:16:55.118767	\N
9622	36	3880	2014-12-07 16:16:55.120947	\N
9623	36	3881	2014-12-07 16:16:55.123776	\N
9624	36	3882	2014-12-07 16:16:55.126383	\N
9625	36	3883	2014-12-07 16:16:55.128587	\N
9626	36	3884	2014-12-07 16:16:55.130747	\N
9627	36	3885	2014-12-07 16:16:55.132915	\N
9628	36	3886	2014-12-07 16:16:55.13504	\N
9629	36	3887	2014-12-07 16:16:55.137372	\N
9630	36	3888	2014-12-07 16:16:55.139631	\N
9631	36	3889	2014-12-07 16:16:55.141788	\N
9632	36	3890	2014-12-07 16:16:55.143957	\N
9633	36	3891	2014-12-07 16:16:55.14609	\N
9634	36	3892	2014-12-07 16:16:55.148238	\N
9635	36	3893	2014-12-07 16:16:55.150523	\N
9636	36	3894	2014-12-07 16:16:55.152658	\N
9637	36	3895	2014-12-07 16:16:55.155368	\N
9638	36	3896	2014-12-07 16:16:55.157784	\N
9639	36	3897	2014-12-07 16:16:55.159975	\N
9640	36	3898	2014-12-07 16:16:55.162189	\N
9641	36	3899	2014-12-07 16:16:55.164448	\N
9642	36	3900	2014-12-07 16:16:55.166711	\N
9643	36	3901	2014-12-07 16:16:55.168779	\N
9644	36	3902	2014-12-07 16:16:55.170845	\N
9645	36	3903	2014-12-07 16:16:55.173018	\N
9646	36	3904	2014-12-07 16:16:55.175264	\N
9647	36	3905	2014-12-07 16:16:55.177477	\N
9648	36	3906	2014-12-07 16:16:55.179498	\N
9649	37	3907	2014-12-07 16:16:57.433911	\N
9650	37	3908	2014-12-07 16:16:57.436521	\N
9651	37	3909	2014-12-07 16:16:57.438818	\N
9652	37	3910	2014-12-07 16:16:57.441073	\N
9653	37	3911	2014-12-07 16:16:57.443906	\N
9654	37	3912	2014-12-07 16:16:57.446552	\N
9655	37	3913	2014-12-07 16:16:57.448894	\N
9656	37	3914	2014-12-07 16:16:57.451177	\N
9657	37	3915	2014-12-07 16:16:57.453251	\N
9658	37	3916	2014-12-07 16:16:57.455286	\N
9659	37	3917	2014-12-07 16:16:57.457263	\N
9660	37	3918	2014-12-07 16:16:57.460236	\N
9661	37	3919	2014-12-07 16:16:57.462694	\N
9662	37	3920	2014-12-07 16:16:57.464969	\N
9663	37	3921	2014-12-07 16:16:57.467144	\N
9664	37	3922	2014-12-07 16:16:57.469356	\N
9665	37	3923	2014-12-07 16:16:57.475	\N
9666	37	3924	2014-12-07 16:16:57.514932	\N
9667	37	3925	2014-12-07 16:16:57.547764	\N
9668	37	3926	2014-12-07 16:16:57.551023	\N
9669	37	3927	2014-12-07 16:16:57.61059	\N
9670	37	3928	2014-12-07 16:16:57.646614	\N
9671	37	3929	2014-12-07 16:16:57.649259	\N
9672	37	3930	2014-12-07 16:16:57.651863	\N
9673	37	3931	2014-12-07 16:16:57.654443	\N
9674	37	3932	2014-12-07 16:16:57.656747	\N
9675	37	3933	2014-12-07 16:16:57.658836	\N
9676	37	3934	2014-12-07 16:16:57.660866	\N
9677	37	3935	2014-12-07 16:16:57.663414	\N
9678	37	3936	2014-12-07 16:16:57.665714	\N
9679	37	3937	2014-12-07 16:16:57.667924	\N
9680	37	3938	2014-12-07 16:16:57.670121	\N
9681	37	3939	2014-12-07 16:16:57.672194	\N
9682	37	3940	2014-12-07 16:16:57.674538	\N
9683	37	3941	2014-12-07 16:16:57.676884	\N
9684	37	3942	2014-12-07 16:16:57.679112	\N
9685	37	3943	2014-12-07 16:16:57.681623	\N
9686	37	3944	2014-12-07 16:16:57.684839	\N
9687	37	3945	2014-12-07 16:16:57.689509	\N
9688	37	3946	2014-12-07 16:16:57.691752	\N
9689	37	3947	2014-12-07 16:16:57.694037	\N
9690	37	3948	2014-12-07 16:16:57.696229	\N
9691	37	3949	2014-12-07 16:16:57.69865	\N
9692	37	3950	2014-12-07 16:16:57.700757	\N
9693	37	3951	2014-12-07 16:16:57.702837	\N
9694	37	3952	2014-12-07 16:16:57.704887	\N
9695	37	3953	2014-12-07 16:16:57.706921	\N
9696	37	3954	2014-12-07 16:16:57.708946	\N
9697	37	3955	2014-12-07 16:16:57.710979	\N
9698	37	3956	2014-12-07 16:16:57.713629	\N
9699	37	3957	2014-12-07 16:16:57.716308	\N
9700	37	3958	2014-12-07 16:16:57.718533	\N
9701	37	3959	2014-12-07 16:16:57.720653	\N
9702	37	3960	2014-12-07 16:16:57.72295	\N
9703	37	3961	2014-12-07 16:16:57.725138	\N
9704	37	3962	2014-12-07 16:16:57.727343	\N
9705	37	3963	2014-12-07 16:16:57.729595	\N
9706	37	3964	2014-12-07 16:16:57.731798	\N
9707	37	3965	2014-12-07 16:16:57.733986	\N
9708	37	3966	2014-12-07 16:16:57.736005	\N
9709	37	3967	2014-12-07 16:16:57.738066	\N
9710	37	3968	2014-12-07 16:16:57.740099	\N
9711	37	3969	2014-12-07 16:16:57.742171	\N
9712	37	3970	2014-12-07 16:16:57.744468	\N
9713	37	3971	2014-12-07 16:16:57.747297	\N
9714	37	3972	2014-12-07 16:16:57.749733	\N
9715	37	3973	2014-12-07 16:16:57.752309	\N
9716	37	3974	2014-12-07 16:16:57.754773	\N
9717	37	3975	2014-12-07 16:16:57.75694	\N
9718	37	3976	2014-12-07 16:16:57.759037	\N
9719	37	3977	2014-12-07 16:16:57.76103	\N
9720	37	3978	2014-12-07 16:16:57.763059	\N
9721	37	3979	2014-12-07 16:16:57.76514	\N
9722	37	3980	2014-12-07 16:16:57.767168	\N
9723	37	3981	2014-12-07 16:16:57.769272	\N
9724	37	3982	2014-12-07 16:16:57.771345	\N
9725	37	3983	2014-12-07 16:16:57.773608	\N
9726	37	3984	2014-12-07 16:16:57.776312	\N
9727	37	3985	2014-12-07 16:16:57.778505	\N
9728	37	3986	2014-12-07 16:16:57.780948	\N
9729	37	3987	2014-12-07 16:16:57.783233	\N
9730	37	3988	2014-12-07 16:16:57.785355	\N
9731	37	3989	2014-12-07 16:16:57.787577	\N
9732	37	3990	2014-12-07 16:16:57.789726	\N
9733	37	3991	2014-12-07 16:16:57.791825	\N
9734	37	3992	2014-12-07 16:16:57.793953	\N
9735	37	3993	2014-12-07 16:16:57.795968	\N
9736	37	3994	2014-12-07 16:16:57.798074	\N
9737	37	3995	2014-12-07 16:16:57.800199	\N
9738	37	3996	2014-12-07 16:16:57.802251	\N
9739	37	3997	2014-12-07 16:16:57.804663	\N
9740	37	3998	2014-12-07 16:16:57.807169	\N
9741	37	3999	2014-12-07 16:16:57.809342	\N
9742	37	4000	2014-12-07 16:16:57.811548	\N
9743	38	4001	2014-12-07 16:16:58.01266	\N
9744	38	4002	2014-12-07 16:16:58.015795	\N
9745	39	4003	2014-12-07 16:16:58.17712	\N
9746	39	4004	2014-12-07 16:16:58.17958	\N
9747	40	4005	2014-12-07 16:16:58.33717	\N
9748	41	4006	2014-12-07 16:16:58.502751	\N
9749	41	4007	2014-12-07 16:16:58.505435	\N
9750	42	4008	2014-12-07 16:16:59.330358	\N
9751	42	4009	2014-12-07 16:16:59.334434	\N
9752	42	4010	2014-12-07 16:16:59.337021	\N
9753	42	4011	2014-12-07 16:16:59.339628	\N
9754	42	4012	2014-12-07 16:16:59.342088	\N
9755	42	4013	2014-12-07 16:16:59.344253	\N
9756	42	4014	2014-12-07 16:16:59.346464	\N
9757	42	4015	2014-12-07 16:16:59.348668	\N
9758	42	4016	2014-12-07 16:16:59.351028	\N
9759	42	4017	2014-12-07 16:16:59.353437	\N
9760	42	4018	2014-12-07 16:16:59.355573	\N
9761	42	4019	2014-12-07 16:16:59.357663	\N
9762	42	4020	2014-12-07 16:16:59.359785	\N
9763	42	4021	2014-12-07 16:16:59.361827	\N
9764	42	4022	2014-12-07 16:16:59.363882	\N
9765	42	4023	2014-12-07 16:16:59.365899	\N
9766	42	4024	2014-12-07 16:16:59.368534	\N
9767	42	4025	2014-12-07 16:16:59.37117	\N
9768	42	4026	2014-12-07 16:16:59.373518	\N
9769	42	4027	2014-12-07 16:16:59.375779	\N
9770	42	4028	2014-12-07 16:16:59.378048	\N
9771	42	4029	2014-12-07 16:16:59.380222	\N
9772	42	4030	2014-12-07 16:16:59.382342	\N
9773	42	4031	2014-12-07 16:16:59.384584	\N
9774	42	4032	2014-12-07 16:16:59.386888	\N
9775	42	4033	2014-12-07 16:16:59.389001	\N
9776	42	4034	2014-12-07 16:16:59.391122	\N
9777	42	4035	2014-12-07 16:16:59.393566	\N
9778	42	4036	2014-12-07 16:16:59.395936	\N
9779	42	4037	2014-12-07 16:16:59.398546	\N
9780	42	4038	2014-12-07 16:16:59.400997	\N
9781	43	4039	2014-12-07 16:16:59.710271	\N
9782	43	4040	2014-12-07 16:16:59.712958	\N
9783	43	4041	2014-12-07 16:16:59.715207	\N
9784	43	4042	2014-12-07 16:16:59.718776	\N
9785	43	4043	2014-12-07 16:16:59.721786	\N
9786	43	4044	2014-12-07 16:16:59.725421	\N
9787	43	4045	2014-12-07 16:16:59.727477	\N
9788	43	4046	2014-12-07 16:16:59.729978	\N
9789	44	4047	2014-12-07 16:16:59.928309	\N
9790	44	4048	2014-12-07 16:16:59.930995	\N
9791	44	4049	2014-12-07 16:16:59.933303	\N
9792	45	4050	2014-12-07 16:17:00.10907	\N
9793	45	4051	2014-12-07 16:17:00.111466	\N
9794	46	4052	2014-12-07 16:17:00.298161	\N
9795	47	4053	2014-12-07 16:17:01.176853	\N
9796	47	4054	2014-12-07 16:17:01.179441	\N
9797	47	4055	2014-12-07 16:17:01.181645	\N
9798	47	4056	2014-12-07 16:17:01.183732	\N
9799	47	4057	2014-12-07 16:17:01.186101	\N
9800	47	4058	2014-12-07 16:17:01.188466	\N
9801	47	4059	2014-12-07 16:17:01.190661	\N
9802	47	4060	2014-12-07 16:17:01.192827	\N
9803	47	4061	2014-12-07 16:17:01.194984	\N
9804	47	4062	2014-12-07 16:17:01.197142	\N
9805	47	4063	2014-12-07 16:17:01.199379	\N
9806	47	4064	2014-12-07 16:17:01.201919	\N
9807	47	4065	2014-12-07 16:17:01.204033	\N
9808	47	4066	2014-12-07 16:17:01.20657	\N
9809	47	4067	2014-12-07 16:17:01.208985	\N
9810	47	4068	2014-12-07 16:17:01.211365	\N
9811	47	4069	2014-12-07 16:17:01.213507	\N
9812	47	4070	2014-12-07 16:17:01.215519	\N
9813	47	4071	2014-12-07 16:17:01.217574	\N
9814	47	4072	2014-12-07 16:17:01.219668	\N
9815	47	4073	2014-12-07 16:17:01.221712	\N
9816	47	4074	2014-12-07 16:17:01.223696	\N
9817	47	4075	2014-12-07 16:17:01.225876	\N
9818	47	4076	2014-12-07 16:17:01.227937	\N
9819	47	4077	2014-12-07 16:17:01.230424	\N
9820	47	4078	2014-12-07 16:17:01.232847	\N
9821	47	4079	2014-12-07 16:17:01.235135	\N
9822	47	4080	2014-12-07 16:17:01.23723	\N
9823	47	4081	2014-12-07 16:17:01.239402	\N
9824	47	4082	2014-12-07 16:17:01.241719	\N
9825	47	4083	2014-12-07 16:17:01.244356	\N
9826	47	4084	2014-12-07 16:17:01.246576	\N
9827	48	4085	2014-12-07 16:17:02.586884	\N
9828	48	4086	2014-12-07 16:17:02.589513	\N
9829	48	4087	2014-12-07 16:17:02.591633	\N
9830	48	4088	2014-12-07 16:17:02.593935	\N
9831	48	4089	2014-12-07 16:17:02.596038	\N
9832	48	4090	2014-12-07 16:17:02.598326	\N
9833	48	4091	2014-12-07 16:17:02.60058	\N
9834	48	4092	2014-12-07 16:17:02.602716	\N
9835	48	4093	2014-12-07 16:17:02.604933	\N
9836	48	4094	2014-12-07 16:17:02.607091	\N
9837	48	4095	2014-12-07 16:17:02.609133	\N
9838	48	4096	2014-12-07 16:17:02.611079	\N
9839	48	4097	2014-12-07 16:17:02.613719	\N
9840	48	4098	2014-12-07 16:17:02.616179	\N
9841	48	4099	2014-12-07 16:17:02.618425	\N
9842	48	4100	2014-12-07 16:17:02.620559	\N
9843	48	4101	2014-12-07 16:17:02.622624	\N
9844	48	4102	2014-12-07 16:17:02.624646	\N
9845	48	4103	2014-12-07 16:17:02.626698	\N
9846	48	4104	2014-12-07 16:17:02.628754	\N
9847	48	4105	2014-12-07 16:17:02.631034	\N
9848	48	4106	2014-12-07 16:17:02.633107	\N
9849	48	4107	2014-12-07 16:17:02.63505	\N
9850	48	4108	2014-12-07 16:17:02.636993	\N
9851	48	4109	2014-12-07 16:17:02.638943	\N
9852	48	4110	2014-12-07 16:17:02.640893	\N
9853	48	4111	2014-12-07 16:17:02.643504	\N
9854	48	4112	2014-12-07 16:17:02.645973	\N
9855	48	4113	2014-12-07 16:17:02.648379	\N
9856	48	4114	2014-12-07 16:17:02.650566	\N
9857	48	4115	2014-12-07 16:17:02.65264	\N
9858	48	4116	2014-12-07 16:17:02.654653	\N
9859	48	4117	2014-12-07 16:17:02.656654	\N
9860	48	4118	2014-12-07 16:17:02.658656	\N
9861	48	4119	2014-12-07 16:17:02.660673	\N
9862	48	4120	2014-12-07 16:17:02.662659	\N
9863	48	4121	2014-12-07 16:17:02.664748	\N
9864	48	4122	2014-12-07 16:17:02.667181	\N
9865	48	4123	2014-12-07 16:17:02.669308	\N
9866	48	4124	2014-12-07 16:17:02.67134	\N
9867	48	4125	2014-12-07 16:17:02.673966	\N
9868	48	4126	2014-12-07 16:17:02.676126	\N
9869	48	4127	2014-12-07 16:17:02.678436	\N
9870	48	4128	2014-12-07 16:17:02.680969	\N
9871	48	4129	2014-12-07 16:17:02.683213	\N
9872	48	4130	2014-12-07 16:17:02.685446	\N
9873	48	4131	2014-12-07 16:17:02.687646	\N
9874	48	4132	2014-12-07 16:17:02.68973	\N
9875	48	4133	2014-12-07 16:17:02.691964	\N
9876	48	4134	2014-12-07 16:17:02.694048	\N
9877	49	4135	2014-12-07 16:17:02.965558	\N
9878	49	4136	2014-12-07 16:17:02.968171	\N
9879	49	4137	2014-12-07 16:17:02.970332	\N
9880	49	4138	2014-12-07 16:17:02.973311	\N
9881	49	4139	2014-12-07 16:17:02.97663	\N
9882	50	4140	2014-12-07 16:17:03.258785	\N
9883	51	4141	2014-12-07 16:17:03.530575	\N
9884	51	4142	2014-12-07 16:17:03.53313	\N
9885	52	4143	2014-12-07 16:17:03.710891	\N
9886	53	4144	2014-12-07 16:17:03.90395	\N
9887	54	4145	2014-12-07 16:17:04.475571	\N
9888	54	4146	2014-12-07 16:17:04.478848	\N
9889	54	4147	2014-12-07 16:17:04.482697	\N
9890	54	4148	2014-12-07 16:17:04.48545	\N
9891	54	4149	2014-12-07 16:17:04.488156	\N
9892	54	4150	2014-12-07 16:17:04.49161	\N
9893	54	4151	2014-12-07 16:17:04.494319	\N
9894	54	4152	2014-12-07 16:17:04.496629	\N
9895	54	4153	2014-12-07 16:17:04.498912	\N
9896	54	4154	2014-12-07 16:17:04.502286	\N
9897	54	4155	2014-12-07 16:17:04.505437	\N
9898	54	4156	2014-12-07 16:17:04.508095	\N
9899	54	4157	2014-12-07 16:17:04.511323	\N
9900	55	4158	2014-12-07 16:17:04.788891	\N
9901	55	4159	2014-12-07 16:17:04.791583	\N
9902	55	4160	2014-12-07 16:17:04.793754	\N
9903	55	4161	2014-12-07 16:17:04.796075	\N
9904	56	4162	2014-12-07 16:17:05.23703	\N
9905	56	4163	2014-12-07 16:17:05.239985	\N
9906	56	4164	2014-12-07 16:17:05.24241	\N
9907	56	4165	2014-12-07 16:17:05.244822	\N
9908	56	4166	2014-12-07 16:17:05.247002	\N
9909	56	4167	2014-12-07 16:17:05.249394	\N
9910	56	4168	2014-12-07 16:17:05.251601	\N
9911	56	4169	2014-12-07 16:17:05.253819	\N
9912	56	4170	2014-12-07 16:17:05.256221	\N
9913	56	4171	2014-12-07 16:17:05.258872	\N
9914	57	4172	2014-12-07 16:17:05.466041	\N
9915	58	4173	2014-12-07 16:17:05.719069	\N
9916	58	4174	2014-12-07 16:17:05.721571	\N
9917	58	4175	2014-12-07 16:17:05.723758	\N
9918	59	4176	2014-12-07 16:17:05.930529	\N
9919	60	4177	2014-12-07 16:17:06.231225	\N
9920	60	4178	2014-12-07 16:17:06.23392	\N
9921	60	4179	2014-12-07 16:17:06.23624	\N
9922	60	4180	2014-12-07 16:17:06.238533	\N
9923	60	4181	2014-12-07 16:17:06.240656	\N
9924	61	4182	2014-12-07 16:17:06.612177	\N
9925	61	4183	2014-12-07 16:17:06.614844	\N
9926	61	4184	2014-12-07 16:17:06.617115	\N
9927	61	4185	2014-12-07 16:17:06.619171	\N
9928	61	4186	2014-12-07 16:17:06.622659	\N
9929	61	4187	2014-12-07 16:17:06.624891	\N
9930	61	4188	2014-12-07 16:17:06.627139	\N
9931	62	4189	2014-12-07 16:17:06.838845	\N
9932	63	4190	2014-12-07 16:17:07.219002	\N
9933	63	4191	2014-12-07 16:17:07.221565	\N
9934	63	4192	2014-12-07 16:17:07.223827	\N
9935	63	4193	2014-12-07 16:17:07.226019	\N
9936	63	4194	2014-12-07 16:17:07.22825	\N
9937	63	4195	2014-12-07 16:17:07.230453	\N
9938	63	4196	2014-12-07 16:17:07.23263	\N
9939	63	4197	2014-12-07 16:17:07.234712	\N
9940	64	4198	2014-12-07 16:17:07.590536	\N
9941	64	4199	2014-12-07 16:17:07.592794	\N
9942	64	4200	2014-12-07 16:17:07.594992	\N
9943	64	4201	2014-12-07 16:17:07.597206	\N
9944	64	4202	2014-12-07 16:17:07.599475	\N
9945	64	4203	2014-12-07 16:17:07.601992	\N
9946	64	4204	2014-12-07 16:17:07.604432	\N
9947	65	4205	2014-12-07 16:17:08.009634	\N
9948	65	4206	2014-12-07 16:17:08.012061	\N
9949	65	4207	2014-12-07 16:17:08.014542	\N
9950	65	4208	2014-12-07 16:17:08.01705	\N
9951	65	4209	2014-12-07 16:17:08.019144	\N
9952	65	4210	2014-12-07 16:17:08.02163	\N
9953	65	4211	2014-12-07 16:17:08.024253	\N
9954	66	4212	2014-12-07 16:17:08.291869	\N
9955	66	4213	2014-12-07 16:17:08.294889	\N
9956	66	4214	2014-12-07 16:17:08.297239	\N
9957	67	4215	2014-12-07 16:17:08.740866	\N
9958	67	4216	2014-12-07 16:17:08.743563	\N
9959	67	4217	2014-12-07 16:17:08.747887	\N
9960	67	4218	2014-12-07 16:17:08.750648	\N
9961	67	4219	2014-12-07 16:17:08.752973	\N
9962	67	4220	2014-12-07 16:17:08.755382	\N
9963	67	4221	2014-12-07 16:17:08.757505	\N
9964	67	4222	2014-12-07 16:17:08.75954	\N
9965	68	4223	2014-12-07 16:17:09.360497	\N
9966	68	4224	2014-12-07 16:17:09.363127	\N
9967	68	4225	2014-12-07 16:17:09.365644	\N
9968	68	4226	2014-12-07 16:17:09.368022	\N
9969	68	4227	2014-12-07 16:17:09.370356	\N
9970	68	4228	2014-12-07 16:17:09.372758	\N
9971	68	4229	2014-12-07 16:17:09.374904	\N
9972	68	4230	2014-12-07 16:17:09.376973	\N
9973	68	4231	2014-12-07 16:17:09.379625	\N
9974	68	4232	2014-12-07 16:17:09.381891	\N
9975	68	4233	2014-12-07 16:17:09.383973	\N
9976	68	4234	2014-12-07 16:17:09.386262	\N
9977	68	4235	2014-12-07 16:17:09.388666	\N
9978	68	4236	2014-12-07 16:17:09.390901	\N
9979	68	4237	2014-12-07 16:17:09.393024	\N
9980	68	4238	2014-12-07 16:17:09.395018	\N
9981	69	4239	2014-12-07 16:17:09.650808	\N
9982	69	4240	2014-12-07 16:17:09.653566	\N
9983	70	4241	2014-12-07 16:17:10.01038	\N
9984	70	4242	2014-12-07 16:17:10.013112	\N
9985	70	4243	2014-12-07 16:17:10.015197	\N
9986	70	4244	2014-12-07 16:17:10.017556	\N
9987	70	4245	2014-12-07 16:17:10.019619	\N
9988	71	4246	2014-12-07 16:17:10.300475	\N
9989	72	4247	2014-12-07 16:17:10.671218	\N
9990	72	4248	2014-12-07 16:17:10.677728	\N
9991	72	4249	2014-12-07 16:17:10.680972	\N
9992	72	4250	2014-12-07 16:17:10.685853	\N
9993	73	4251	2014-12-07 16:17:12.845531	\N
9994	73	4252	2014-12-07 16:17:12.848065	\N
9995	73	4253	2014-12-07 16:17:12.850698	\N
9996	73	4254	2014-12-07 16:17:12.853021	\N
9997	73	4255	2014-12-07 16:17:12.855215	\N
9998	73	4256	2014-12-07 16:17:12.857377	\N
9999	73	4257	2014-12-07 16:17:12.8597	\N
10000	73	4258	2014-12-07 16:17:12.86202	\N
10001	73	4259	2014-12-07 16:17:12.864387	\N
10002	73	4260	2014-12-07 16:17:12.866638	\N
10003	73	4261	2014-12-07 16:17:12.868977	\N
10004	73	4262	2014-12-07 16:17:12.87132	\N
10005	73	4263	2014-12-07 16:17:12.873389	\N
10006	73	4264	2014-12-07 16:17:12.875385	\N
10007	73	4265	2014-12-07 16:17:12.877476	\N
10008	73	4266	2014-12-07 16:17:12.879846	\N
10009	73	4267	2014-12-07 16:17:12.882374	\N
10010	73	4268	2014-12-07 16:17:12.884554	\N
10011	73	4269	2014-12-07 16:17:12.886624	\N
10012	73	4270	2014-12-07 16:17:12.888805	\N
10013	73	4271	2014-12-07 16:17:12.891151	\N
10014	73	4272	2014-12-07 16:17:12.893364	\N
10015	73	4273	2014-12-07 16:17:12.895454	\N
10016	73	4274	2014-12-07 16:17:12.897564	\N
10017	73	4275	2014-12-07 16:17:12.899998	\N
10018	73	4276	2014-12-07 16:17:12.902264	\N
10019	73	4277	2014-12-07 16:17:12.904394	\N
10020	73	4278	2014-12-07 16:17:12.906468	\N
10021	73	4279	2014-12-07 16:17:12.90865	\N
10022	73	4280	2014-12-07 16:17:12.910948	\N
10023	73	4281	2014-12-07 16:17:12.91316	\N
10024	73	4282	2014-12-07 16:17:12.915373	\N
10025	73	4283	2014-12-07 16:17:12.917575	\N
10026	73	4284	2014-12-07 16:17:12.919868	\N
10027	73	4285	2014-12-07 16:17:12.922173	\N
10028	73	4286	2014-12-07 16:17:12.924288	\N
10029	73	4287	2014-12-07 16:17:12.926372	\N
10030	73	4288	2014-12-07 16:17:12.92845	\N
10031	73	4289	2014-12-07 16:17:12.930653	\N
10032	73	4290	2014-12-07 16:17:12.932912	\N
10033	73	4291	2014-12-07 16:17:12.935176	\N
10034	73	4292	2014-12-07 16:17:12.937316	\N
10035	73	4293	2014-12-07 16:17:12.93942	\N
10036	73	4294	2014-12-07 16:17:12.941898	\N
10037	73	4295	2014-12-07 16:17:12.944702	\N
10038	73	4296	2014-12-07 16:17:12.946875	\N
10039	73	4297	2014-12-07 16:17:12.949222	\N
10040	73	4298	2014-12-07 16:17:12.951506	\N
10041	73	4299	2014-12-07 16:17:12.953628	\N
10042	73	4300	2014-12-07 16:17:12.955738	\N
10043	73	4301	2014-12-07 16:17:12.957868	\N
10044	73	4302	2014-12-07 16:17:12.960272	\N
10045	73	4303	2014-12-07 16:17:12.962629	\N
10046	73	4304	2014-12-07 16:17:12.964844	\N
10047	73	4305	2014-12-07 16:17:12.967252	\N
10048	73	4306	2014-12-07 16:17:12.969586	\N
10049	73	4307	2014-12-07 16:17:12.971823	\N
10050	73	4308	2014-12-07 16:17:12.974043	\N
10051	73	4309	2014-12-07 16:17:12.976256	\N
10052	73	4310	2014-12-07 16:17:12.978616	\N
10053	73	4311	2014-12-07 16:17:12.981002	\N
10054	73	4312	2014-12-07 16:17:12.983308	\N
10055	73	4313	2014-12-07 16:17:12.985512	\N
10056	73	4314	2014-12-07 16:17:12.987481	\N
10057	73	4315	2014-12-07 16:17:12.989821	\N
10058	73	4316	2014-12-07 16:17:12.992163	\N
10059	73	4317	2014-12-07 16:17:12.994545	\N
10060	73	4318	2014-12-07 16:17:12.996668	\N
10061	74	4319	2014-12-07 16:17:13.390211	\N
10062	75	4320	2014-12-07 16:17:13.696421	\N
10063	75	4321	2014-12-07 16:17:13.699092	\N
10064	76	4322	2014-12-07 16:17:14.815618	\N
10065	76	4323	2014-12-07 16:17:14.818288	\N
10066	76	4324	2014-12-07 16:17:14.820912	\N
10067	76	4325	2014-12-07 16:17:14.82394	\N
10068	76	4326	2014-12-07 16:17:14.827434	\N
10069	76	4327	2014-12-07 16:17:14.829873	\N
10070	76	4328	2014-12-07 16:17:14.832215	\N
10071	76	4329	2014-12-07 16:17:14.834524	\N
10072	76	4330	2014-12-07 16:17:14.836977	\N
10073	76	4331	2014-12-07 16:17:14.839801	\N
10074	76	4332	2014-12-07 16:17:14.842154	\N
10075	76	4333	2014-12-07 16:17:14.844253	\N
10076	76	4334	2014-12-07 16:17:14.846357	\N
10077	76	4335	2014-12-07 16:17:14.848407	\N
10078	76	4336	2014-12-07 16:17:14.850727	\N
10079	76	4337	2014-12-07 16:17:14.852949	\N
10080	76	4338	2014-12-07 16:17:14.855499	\N
10081	76	4339	2014-12-07 16:17:14.857879	\N
10082	76	4340	2014-12-07 16:17:14.860059	\N
10083	76	4341	2014-12-07 16:17:14.862151	\N
10084	76	4342	2014-12-07 16:17:14.864209	\N
10085	76	4343	2014-12-07 16:17:14.866557	\N
10086	76	4344	2014-12-07 16:17:14.86867	\N
10087	76	4345	2014-12-07 16:17:14.87083	\N
10088	76	4346	2014-12-07 16:17:14.872973	\N
10089	76	4347	2014-12-07 16:17:14.875001	\N
10090	76	4348	2014-12-07 16:17:14.877198	\N
10091	76	4349	2014-12-07 16:17:14.879177	\N
10092	76	4350	2014-12-07 16:17:14.881566	\N
10093	76	4351	2014-12-07 16:17:14.883773	\N
10094	76	4352	2014-12-07 16:17:14.885898	\N
10095	76	4353	2014-12-07 16:17:14.887939	\N
10096	77	4354	2014-12-07 16:17:15.962085	\N
10097	77	4355	2014-12-07 16:17:15.964702	\N
10098	77	4356	2014-12-07 16:17:15.966833	\N
10099	77	4357	2014-12-07 16:17:15.968799	\N
10100	77	4358	2014-12-07 16:17:15.97066	\N
10101	77	4359	2014-12-07 16:17:15.972717	\N
10102	77	4360	2014-12-07 16:17:15.974769	\N
10103	77	4361	2014-12-07 16:17:15.976885	\N
10104	77	4362	2014-12-07 16:17:15.97889	\N
10105	77	4363	2014-12-07 16:17:15.980948	\N
10106	77	4364	2014-12-07 16:17:15.982975	\N
10107	77	4365	2014-12-07 16:17:15.985108	\N
10108	77	4366	2014-12-07 16:17:15.987023	\N
10109	77	4367	2014-12-07 16:17:15.989121	\N
10110	77	4368	2014-12-07 16:17:15.991123	\N
10111	77	4369	2014-12-07 16:17:15.993292	\N
10112	77	4370	2014-12-07 16:17:15.995318	\N
10113	77	4371	2014-12-07 16:17:15.997527	\N
10114	77	4372	2014-12-07 16:17:15.999834	\N
10115	77	4373	2014-12-07 16:17:16.002691	\N
10116	77	4374	2014-12-07 16:17:16.004791	\N
10117	77	4375	2014-12-07 16:17:16.00697	\N
10118	77	4376	2014-12-07 16:17:16.009037	\N
10119	77	4377	2014-12-07 16:17:16.011297	\N
10120	77	4378	2014-12-07 16:17:16.013432	\N
10121	77	4379	2014-12-07 16:17:16.015503	\N
10122	77	4380	2014-12-07 16:17:16.017544	\N
10123	77	4381	2014-12-07 16:17:16.019573	\N
10124	77	4382	2014-12-07 16:17:16.021634	\N
10125	77	4383	2014-12-07 16:17:16.023644	\N
10126	77	4384	2014-12-07 16:17:16.025699	\N
10127	77	4385	2014-12-07 16:17:16.027994	\N
10128	77	4386	2014-12-07 16:17:16.030068	\N
10129	78	4387	2014-12-07 16:17:16.286035	\N
10130	79	4388	2014-12-07 16:17:16.54774	\N
10131	80	4389	2014-12-07 16:17:16.815791	\N
10132	81	4390	2014-12-07 16:17:17.06974	\N
10133	82	4391	2014-12-07 16:17:17.328315	\N
10134	83	4392	2014-12-07 16:17:17.600045	\N
10135	84	4393	2014-12-07 16:17:19.522426	\N
10136	84	4394	2014-12-07 16:17:19.525016	\N
10137	84	4395	2014-12-07 16:17:19.527335	\N
10138	84	4396	2014-12-07 16:17:19.529462	\N
10139	84	4397	2014-12-07 16:17:19.532081	\N
10140	84	4398	2014-12-07 16:17:19.534632	\N
10141	84	4399	2014-12-07 16:17:19.538781	\N
10142	84	4400	2014-12-07 16:17:19.54122	\N
10143	84	4401	2014-12-07 16:17:19.543309	\N
10144	84	4402	2014-12-07 16:17:19.545399	\N
10145	84	4403	2014-12-07 16:17:19.547338	\N
10146	84	4404	2014-12-07 16:17:19.549442	\N
10147	84	4405	2014-12-07 16:17:19.551423	\N
10148	84	4406	2014-12-07 16:17:19.553461	\N
10149	84	4407	2014-12-07 16:17:19.55632	\N
10150	84	4408	2014-12-07 16:17:19.558883	\N
10151	84	4409	2014-12-07 16:17:19.561117	\N
10152	84	4410	2014-12-07 16:17:19.563202	\N
10153	84	4411	2014-12-07 16:17:19.565304	\N
10154	84	4412	2014-12-07 16:17:19.567383	\N
10155	84	4413	2014-12-07 16:17:19.569417	\N
10156	84	4414	2014-12-07 16:17:19.571596	\N
10157	84	4415	2014-12-07 16:17:19.573724	\N
10158	84	4416	2014-12-07 16:17:19.575787	\N
10159	84	4417	2014-12-07 16:17:19.577799	\N
10160	84	4418	2014-12-07 16:17:19.579982	\N
10161	84	4419	2014-12-07 16:17:19.582003	\N
10162	84	4420	2014-12-07 16:17:19.584078	\N
10163	84	4421	2014-12-07 16:17:19.586215	\N
10164	84	4422	2014-12-07 16:17:19.588331	\N
10165	84	4423	2014-12-07 16:17:19.590384	\N
10166	84	4424	2014-12-07 16:17:19.592487	\N
10167	84	4425	2014-12-07 16:17:19.594564	\N
10168	84	4426	2014-12-07 16:17:19.596561	\N
10169	84	4427	2014-12-07 16:17:19.598652	\N
10170	84	4428	2014-12-07 16:17:19.600785	\N
10171	84	4429	2014-12-07 16:17:19.602944	\N
10172	84	4430	2014-12-07 16:17:19.605098	\N
10173	84	4431	2014-12-07 16:17:19.607251	\N
10174	84	4432	2014-12-07 16:17:19.609316	\N
10175	84	4433	2014-12-07 16:17:19.611323	\N
10176	84	4434	2014-12-07 16:17:19.613354	\N
10177	84	4435	2014-12-07 16:17:19.615406	\N
10178	84	4436	2014-12-07 16:17:19.617432	\N
10179	84	4437	2014-12-07 16:17:19.619525	\N
10180	84	4438	2014-12-07 16:17:19.621713	\N
10181	84	4439	2014-12-07 16:17:19.623724	\N
10182	84	4440	2014-12-07 16:17:19.625775	\N
10183	84	4441	2014-12-07 16:17:19.627752	\N
10184	84	4442	2014-12-07 16:17:19.62981	\N
10185	84	4443	2014-12-07 16:17:19.631838	\N
10186	84	4444	2014-12-07 16:17:19.633845	\N
10187	84	4445	2014-12-07 16:17:19.6359	\N
10188	84	4446	2014-12-07 16:17:19.637967	\N
10189	84	4447	2014-12-07 16:17:19.640527	\N
10190	84	4448	2014-12-07 16:17:19.642681	\N
10191	84	4449	2014-12-07 16:17:19.644701	\N
10192	84	4450	2014-12-07 16:17:19.646895	\N
10193	84	4451	2014-12-07 16:17:19.649002	\N
10194	84	4452	2014-12-07 16:17:19.651195	\N
10195	84	4453	2014-12-07 16:17:19.653239	\N
10196	84	4454	2014-12-07 16:17:19.655304	\N
10197	85	4455	2014-12-07 16:17:19.919735	\N
10198	86	4456	2014-12-07 16:17:21.103082	\N
10199	86	4457	2014-12-07 16:17:21.105818	\N
10200	86	4458	2014-12-07 16:17:21.107924	\N
10201	86	4459	2014-12-07 16:17:21.110216	\N
10202	86	4460	2014-12-07 16:17:21.112762	\N
10203	86	4461	2014-12-07 16:17:21.11496	\N
10204	86	4462	2014-12-07 16:17:21.11711	\N
10205	86	4463	2014-12-07 16:17:21.119138	\N
10206	86	4464	2014-12-07 16:17:21.121205	\N
10207	86	4465	2014-12-07 16:17:21.123331	\N
10208	86	4466	2014-12-07 16:17:21.125446	\N
10209	86	4467	2014-12-07 16:17:21.127551	\N
10210	86	4468	2014-12-07 16:17:21.129666	\N
10211	86	4469	2014-12-07 16:17:21.131782	\N
10212	86	4470	2014-12-07 16:17:21.133943	\N
10213	86	4471	2014-12-07 16:17:21.135885	\N
10214	86	4472	2014-12-07 16:17:21.137969	\N
10215	86	4473	2014-12-07 16:17:21.14002	\N
10216	86	4474	2014-12-07 16:17:21.142041	\N
10217	86	4475	2014-12-07 16:17:21.145124	\N
10218	86	4476	2014-12-07 16:17:21.147597	\N
10219	86	4477	2014-12-07 16:17:21.19132	\N
10220	86	4478	2014-12-07 16:17:21.196549	\N
10221	86	4479	2014-12-07 16:17:21.199625	\N
10222	86	4480	2014-12-07 16:17:21.201989	\N
10223	86	4481	2014-12-07 16:17:21.204125	\N
10224	86	4482	2014-12-07 16:17:21.206223	\N
10225	86	4483	2014-12-07 16:17:21.208264	\N
10226	86	4484	2014-12-07 16:17:21.210322	\N
10227	86	4485	2014-12-07 16:17:21.212397	\N
10228	86	4486	2014-12-07 16:17:21.214578	\N
10229	86	4487	2014-12-07 16:17:21.216671	\N
10230	86	4488	2014-12-07 16:17:21.21879	\N
10231	86	4489	2014-12-07 16:17:21.22077	\N
10232	87	4490	2014-12-07 16:17:21.536498	\N
10233	87	4491	2014-12-07 16:17:21.539133	\N
10234	88	4492	2014-12-07 16:17:21.818646	\N
10235	89	4493	2014-12-07 16:17:22.828131	\N
10236	89	4494	2014-12-07 16:17:22.830877	\N
10237	89	4495	2014-12-07 16:17:22.833259	\N
10238	89	4496	2014-12-07 16:17:22.835431	\N
10239	89	4497	2014-12-07 16:17:22.837893	\N
10240	89	4498	2014-12-07 16:17:22.840263	\N
10241	89	4499	2014-12-07 16:17:22.842532	\N
10242	89	4500	2014-12-07 16:17:22.844689	\N
10243	89	4501	2014-12-07 16:17:22.84683	\N
10244	89	4502	2014-12-07 16:17:22.848887	\N
10245	89	4503	2014-12-07 16:17:22.851381	\N
10246	89	4504	2014-12-07 16:17:22.853482	\N
10247	89	4505	2014-12-07 16:17:22.855686	\N
10248	89	4506	2014-12-07 16:17:22.857804	\N
10249	89	4507	2014-12-07 16:17:22.859839	\N
10250	89	4508	2014-12-07 16:17:22.861936	\N
10251	89	4509	2014-12-07 16:17:22.864045	\N
10252	89	4510	2014-12-07 16:17:22.866154	\N
10253	89	4511	2014-12-07 16:17:22.868362	\N
10254	89	4512	2014-12-07 16:17:22.870482	\N
10255	89	4513	2014-12-07 16:17:22.872592	\N
10256	89	4514	2014-12-07 16:17:22.874647	\N
10257	89	4515	2014-12-07 16:17:22.876679	\N
10258	89	4516	2014-12-07 16:17:22.878707	\N
10259	89	4517	2014-12-07 16:17:22.880752	\N
10260	89	4518	2014-12-07 16:17:22.882914	\N
10261	90	4519	2014-12-07 16:17:23.255507	\N
10262	90	4520	2014-12-07 16:17:23.258137	\N
10263	90	4521	2014-12-07 16:17:23.260228	\N
10264	90	4522	2014-12-07 16:17:23.262414	\N
10265	91	4523	2014-12-07 16:17:24.444576	\N
10266	91	4524	2014-12-07 16:17:24.447352	\N
10267	91	4525	2014-12-07 16:17:24.449727	\N
10268	91	4526	2014-12-07 16:17:24.452109	\N
10269	91	4527	2014-12-07 16:17:24.454395	\N
10270	91	4528	2014-12-07 16:17:24.456512	\N
10271	91	4529	2014-12-07 16:17:24.458857	\N
10272	91	4530	2014-12-07 16:17:24.461414	\N
10273	91	4531	2014-12-07 16:17:24.463611	\N
10274	91	4532	2014-12-07 16:17:24.465805	\N
10275	91	4533	2014-12-07 16:17:24.467935	\N
10276	91	4534	2014-12-07 16:17:24.470529	\N
10277	91	4535	2014-12-07 16:17:24.473214	\N
10278	91	4536	2014-12-07 16:17:24.475695	\N
10279	91	4537	2014-12-07 16:17:24.478103	\N
10280	91	4538	2014-12-07 16:17:24.480325	\N
10281	91	4539	2014-12-07 16:17:24.482463	\N
10282	91	4540	2014-12-07 16:17:24.48465	\N
10283	91	4541	2014-12-07 16:17:24.486773	\N
10284	91	4542	2014-12-07 16:17:24.488873	\N
10285	91	4543	2014-12-07 16:17:24.490998	\N
10286	91	4544	2014-12-07 16:17:24.493264	\N
10287	91	4545	2014-12-07 16:17:24.495292	\N
10288	91	4546	2014-12-07 16:17:24.497379	\N
10289	91	4547	2014-12-07 16:17:24.499347	\N
10290	91	4548	2014-12-07 16:17:24.501362	\N
10291	91	4549	2014-12-07 16:17:24.503378	\N
10292	91	4550	2014-12-07 16:17:24.50565	\N
10293	91	4551	2014-12-07 16:17:24.507763	\N
10294	91	4552	2014-12-07 16:17:24.509846	\N
10295	91	4553	2014-12-07 16:17:24.511936	\N
10296	91	4554	2014-12-07 16:17:24.514312	\N
10297	92	4555	2014-12-07 16:17:24.925044	\N
10298	92	4556	2014-12-07 16:17:24.927637	\N
10299	92	4557	2014-12-07 16:17:24.929971	\N
10300	92	4558	2014-12-07 16:17:24.932188	\N
10301	92	4559	2014-12-07 16:17:24.934587	\N
10302	93	4560	2014-12-07 16:17:26.810044	\N
10303	93	4561	2014-12-07 16:17:26.813048	\N
10304	93	4562	2014-12-07 16:17:26.815337	\N
10305	93	4563	2014-12-07 16:17:26.817452	\N
10306	93	4564	2014-12-07 16:17:26.819596	\N
10307	93	4565	2014-12-07 16:17:26.821787	\N
10308	93	4566	2014-12-07 16:17:26.823942	\N
10309	93	4567	2014-12-07 16:17:26.826125	\N
10310	93	4568	2014-12-07 16:17:26.828175	\N
10311	93	4569	2014-12-07 16:17:26.83033	\N
10312	93	4570	2014-12-07 16:17:26.83244	\N
10313	93	4571	2014-12-07 16:17:26.834487	\N
10314	93	4572	2014-12-07 16:17:26.836647	\N
10315	93	4573	2014-12-07 16:17:26.838924	\N
10316	93	4574	2014-12-07 16:17:26.841055	\N
10317	93	4575	2014-12-07 16:17:26.843063	\N
10318	93	4576	2014-12-07 16:17:26.845123	\N
10319	93	4577	2014-12-07 16:17:26.84714	\N
10320	93	4578	2014-12-07 16:17:26.849194	\N
10321	93	4579	2014-12-07 16:17:26.851197	\N
10322	93	4580	2014-12-07 16:17:26.853483	\N
10323	93	4581	2014-12-07 16:17:26.855704	\N
10324	93	4582	2014-12-07 16:17:26.857828	\N
10325	93	4583	2014-12-07 16:17:26.859838	\N
10326	93	4584	2014-12-07 16:17:26.86188	\N
10327	93	4585	2014-12-07 16:17:26.863992	\N
10328	93	4586	2014-12-07 16:17:26.866205	\N
10329	93	4587	2014-12-07 16:17:26.868231	\N
10330	93	4588	2014-12-07 16:17:26.870301	\N
10331	93	4589	2014-12-07 16:17:26.872311	\N
10332	93	4590	2014-12-07 16:17:26.874435	\N
10333	93	4591	2014-12-07 16:17:26.876438	\N
10334	93	4592	2014-12-07 16:17:26.878486	\N
10335	93	4593	2014-12-07 16:17:26.880705	\N
10336	93	4594	2014-12-07 16:17:26.882877	\N
10337	93	4595	2014-12-07 16:17:26.884899	\N
10338	93	4596	2014-12-07 16:17:26.886914	\N
10339	93	4597	2014-12-07 16:17:26.889051	\N
10340	93	4598	2014-12-07 16:17:26.891057	\N
10341	93	4599	2014-12-07 16:17:26.893157	\N
10342	93	4600	2014-12-07 16:17:26.895206	\N
10343	93	4601	2014-12-07 16:17:26.897344	\N
10344	93	4602	2014-12-07 16:17:26.899351	\N
10345	93	4603	2014-12-07 16:17:26.901336	\N
10346	93	4604	2014-12-07 16:17:26.903275	\N
10347	93	4605	2014-12-07 16:17:26.90519	\N
10348	93	4606	2014-12-07 16:17:26.907254	\N
10349	93	4607	2014-12-07 16:17:26.909233	\N
10350	93	4608	2014-12-07 16:17:26.911211	\N
10351	93	4609	2014-12-07 16:17:26.913308	\N
10352	94	4610	2014-12-07 16:17:27.211934	\N
10353	95	4611	2014-12-07 16:17:27.522025	\N
10354	96	4612	2014-12-07 16:17:28.012206	\N
10355	97	4613	2014-12-07 16:17:30.345815	\N
10356	97	4614	2014-12-07 16:17:30.348455	\N
10357	97	4615	2014-12-07 16:17:30.350838	\N
10358	97	4616	2014-12-07 16:17:30.353085	\N
10359	97	4617	2014-12-07 16:17:30.355231	\N
10360	97	4618	2014-12-07 16:17:30.357816	\N
10361	97	4619	2014-12-07 16:17:30.373741	\N
10362	97	4620	2014-12-07 16:17:30.376147	\N
10363	97	4621	2014-12-07 16:17:30.378307	\N
10364	97	4622	2014-12-07 16:17:30.380451	\N
10365	97	4623	2014-12-07 16:17:30.382704	\N
10366	97	4624	2014-12-07 16:17:30.384893	\N
10367	97	4625	2014-12-07 16:17:30.386968	\N
10368	97	4626	2014-12-07 16:17:30.389908	\N
10369	97	4627	2014-12-07 16:17:30.39303	\N
10370	97	4628	2014-12-07 16:17:30.395321	\N
10371	97	4629	2014-12-07 16:17:30.397678	\N
10372	97	4630	2014-12-07 16:17:30.399813	\N
10373	97	4631	2014-12-07 16:17:30.401913	\N
10374	97	4632	2014-12-07 16:17:30.404032	\N
10375	97	4633	2014-12-07 16:17:30.406036	\N
10376	97	4634	2014-12-07 16:17:30.408053	\N
10377	97	4635	2014-12-07 16:17:30.410225	\N
10378	97	4636	2014-12-07 16:17:30.41231	\N
10379	97	4637	2014-12-07 16:17:30.414329	\N
10380	97	4638	2014-12-07 16:17:30.416344	\N
10381	97	4639	2014-12-07 16:17:30.418447	\N
10382	97	4640	2014-12-07 16:17:30.420543	\N
10383	97	4641	2014-12-07 16:17:30.422608	\N
10384	97	4642	2014-12-07 16:17:30.424625	\N
10385	97	4643	2014-12-07 16:17:30.42699	\N
10386	97	4644	2014-12-07 16:17:30.429165	\N
10387	97	4645	2014-12-07 16:17:30.431165	\N
10388	97	4646	2014-12-07 16:17:30.433212	\N
10389	97	4647	2014-12-07 16:17:30.435141	\N
10390	97	4648	2014-12-07 16:17:30.437149	\N
10391	97	4649	2014-12-07 16:17:30.439138	\N
10392	97	4650	2014-12-07 16:17:30.441284	\N
10393	97	4651	2014-12-07 16:17:30.443419	\N
10394	97	4652	2014-12-07 16:17:30.445544	\N
10395	97	4653	2014-12-07 16:17:30.447685	\N
10396	97	4654	2014-12-07 16:17:30.449737	\N
10397	97	4655	2014-12-07 16:17:30.451796	\N
10398	97	4656	2014-12-07 16:17:30.453783	\N
10399	97	4657	2014-12-07 16:17:30.455823	\N
10400	97	4658	2014-12-07 16:17:30.457877	\N
10401	97	4659	2014-12-07 16:17:30.460164	\N
10402	97	4660	2014-12-07 16:17:30.462582	\N
10403	97	4661	2014-12-07 16:17:30.464818	\N
10404	97	4662	2014-12-07 16:17:30.466858	\N
10405	97	4663	2014-12-07 16:17:30.469458	\N
10406	97	4664	2014-12-07 16:17:30.472016	\N
10407	97	4665	2014-12-07 16:17:30.474443	\N
10408	97	4666	2014-12-07 16:17:30.476966	\N
10409	97	4667	2014-12-07 16:17:30.479217	\N
10410	97	4668	2014-12-07 16:17:30.481315	\N
10411	97	4669	2014-12-07 16:17:30.483363	\N
10412	97	4670	2014-12-07 16:17:30.485386	\N
10413	97	4671	2014-12-07 16:17:30.487422	\N
10414	97	4672	2014-12-07 16:17:30.489438	\N
10415	97	4673	2014-12-07 16:17:30.491707	\N
10416	97	4674	2014-12-07 16:17:30.494065	\N
10417	97	4675	2014-12-07 16:17:30.496372	\N
10418	97	4676	2014-12-07 16:17:30.498709	\N
10419	97	4677	2014-12-07 16:17:30.500899	\N
10420	97	4678	2014-12-07 16:17:30.503041	\N
10421	98	4679	2014-12-07 16:17:30.945682	\N
10422	98	4680	2014-12-07 16:17:30.948261	\N
10423	98	4681	2014-12-07 16:17:30.950562	\N
10424	98	4682	2014-12-07 16:17:30.95279	\N
10425	98	4683	2014-12-07 16:17:30.955138	\N
10426	99	4684	2014-12-07 16:17:31.526869	\N
10427	99	4685	2014-12-07 16:17:31.529716	\N
10428	99	4686	2014-12-07 16:17:31.531984	\N
10429	99	4687	2014-12-07 16:17:31.534197	\N
10430	99	4688	2014-12-07 16:17:31.536354	\N
10431	99	4689	2014-12-07 16:17:31.538758	\N
10432	99	4690	2014-12-07 16:17:31.541009	\N
10433	99	4691	2014-12-07 16:17:31.543107	\N
10434	99	4692	2014-12-07 16:17:31.545173	\N
10435	100	4693	2014-12-07 16:17:31.881712	\N
10436	101	4694	2014-12-07 16:17:32.213039	\N
10437	102	4695	2014-12-07 16:17:32.546043	\N
10438	103	4696	2014-12-07 16:17:32.908261	\N
10439	104	4697	2014-12-07 16:17:34.835928	\N
10440	104	4698	2014-12-07 16:17:34.838595	\N
10441	104	4699	2014-12-07 16:17:34.841119	\N
10442	104	4700	2014-12-07 16:17:34.843276	\N
10443	104	4701	2014-12-07 16:17:34.84536	\N
10444	104	4702	2014-12-07 16:17:34.847426	\N
10445	104	4703	2014-12-07 16:17:34.849521	\N
10446	104	4704	2014-12-07 16:17:34.851565	\N
10447	104	4705	2014-12-07 16:17:34.853952	\N
10448	104	4706	2014-12-07 16:17:34.85611	\N
10449	104	4707	2014-12-07 16:17:34.858377	\N
10450	104	4708	2014-12-07 16:17:34.860434	\N
10451	104	4709	2014-12-07 16:17:34.862518	\N
10452	104	4710	2014-12-07 16:17:34.864625	\N
10453	104	4711	2014-12-07 16:17:34.866706	\N
10454	104	4712	2014-12-07 16:17:34.868709	\N
10455	104	4713	2014-12-07 16:17:34.870879	\N
10456	104	4714	2014-12-07 16:17:34.873	\N
10457	104	4715	2014-12-07 16:17:34.875061	\N
10458	104	4716	2014-12-07 16:17:34.877203	\N
10459	104	4717	2014-12-07 16:17:34.879142	\N
10460	104	4718	2014-12-07 16:17:34.881246	\N
10461	104	4719	2014-12-07 16:17:34.883236	\N
10462	104	4720	2014-12-07 16:17:34.885269	\N
10463	104	4721	2014-12-07 16:17:34.88719	\N
10464	104	4722	2014-12-07 16:17:34.889201	\N
10465	104	4723	2014-12-07 16:17:34.891427	\N
10466	104	4724	2014-12-07 16:17:34.893563	\N
10467	104	4725	2014-12-07 16:17:34.895519	\N
10468	104	4726	2014-12-07 16:17:34.897687	\N
10469	104	4727	2014-12-07 16:17:34.899731	\N
10470	104	4728	2014-12-07 16:17:34.90178	\N
10471	104	4729	2014-12-07 16:17:34.903695	\N
10472	104	4730	2014-12-07 16:17:34.905717	\N
10473	104	4731	2014-12-07 16:17:34.907698	\N
10474	104	4732	2014-12-07 16:17:34.909749	\N
10475	104	4733	2014-12-07 16:17:34.911742	\N
10476	104	4734	2014-12-07 16:17:34.913849	\N
10477	104	4735	2014-12-07 16:17:34.915781	\N
10478	104	4736	2014-12-07 16:17:34.917781	\N
10479	104	4737	2014-12-07 16:17:34.919693	\N
10480	104	4738	2014-12-07 16:17:34.921712	\N
10481	104	4739	2014-12-07 16:17:34.923636	\N
10482	104	4740	2014-12-07 16:17:34.925766	\N
10483	104	4741	2014-12-07 16:17:34.927895	\N
10484	104	4742	2014-12-07 16:17:34.929966	\N
10485	104	4743	2014-12-07 16:17:34.931917	\N
10486	104	4744	2014-12-07 16:17:34.933912	\N
10487	104	4745	2014-12-07 16:17:34.935884	\N
10488	105	4746	2014-12-07 16:17:35.719315	\N
10489	105	4747	2014-12-07 16:17:35.722384	\N
10490	105	4748	2014-12-07 16:17:35.724775	\N
10491	105	4749	2014-12-07 16:17:35.72809	\N
10492	105	4750	2014-12-07 16:17:35.730864	\N
10493	105	4751	2014-12-07 16:17:35.733233	\N
10494	105	4752	2014-12-07 16:17:35.735748	\N
10495	105	4753	2014-12-07 16:17:35.738273	\N
10496	105	4754	2014-12-07 16:17:35.741019	\N
10497	105	4755	2014-12-07 16:17:35.743564	\N
10498	105	4756	2014-12-07 16:17:35.746004	\N
10499	105	4757	2014-12-07 16:17:35.748392	\N
10500	105	4758	2014-12-07 16:17:35.750803	\N
10501	106	4759	2014-12-07 16:17:36.162296	\N
10502	107	4760	2014-12-07 16:17:37.94311	\N
10503	107	4761	2014-12-07 16:17:37.945806	\N
10504	107	4762	2014-12-07 16:17:37.948154	\N
10505	107	4763	2014-12-07 16:17:37.950505	\N
10506	107	4764	2014-12-07 16:17:37.952866	\N
10507	107	4765	2014-12-07 16:17:37.955129	\N
10508	107	4766	2014-12-07 16:17:37.957445	\N
10509	107	4767	2014-12-07 16:17:37.959897	\N
10510	107	4768	2014-12-07 16:17:37.962227	\N
10511	107	4769	2014-12-07 16:17:37.964673	\N
10512	107	4770	2014-12-07 16:17:37.9669	\N
10513	107	4771	2014-12-07 16:17:37.969137	\N
10514	107	4772	2014-12-07 16:17:37.971455	\N
10515	107	4773	2014-12-07 16:17:37.973697	\N
10516	107	4774	2014-12-07 16:17:37.975921	\N
10517	107	4775	2014-12-07 16:17:37.978104	\N
10518	107	4776	2014-12-07 16:17:37.980323	\N
10519	107	4777	2014-12-07 16:17:37.98264	\N
10520	107	4778	2014-12-07 16:17:37.985303	\N
10521	107	4779	2014-12-07 16:17:37.987613	\N
10522	107	4780	2014-12-07 16:17:37.990474	\N
10523	107	4781	2014-12-07 16:17:37.993312	\N
10524	107	4782	2014-12-07 16:17:37.995598	\N
10525	107	4783	2014-12-07 16:17:37.997816	\N
10526	107	4784	2014-12-07 16:17:38.000144	\N
10527	107	4785	2014-12-07 16:17:38.002557	\N
10528	107	4786	2014-12-07 16:17:38.004868	\N
10529	107	4787	2014-12-07 16:17:38.007055	\N
10530	107	4788	2014-12-07 16:17:38.010161	\N
10531	107	4789	2014-12-07 16:17:38.013039	\N
10532	107	4790	2014-12-07 16:17:38.015305	\N
10533	107	4791	2014-12-07 16:17:38.017897	\N
10534	108	4792	2014-12-07 16:17:38.368739	\N
10535	109	4793	2014-12-07 16:17:38.727699	\N
10536	110	4794	2014-12-07 16:17:39.081959	\N
10537	111	4795	2014-12-07 16:17:39.436777	\N
10538	112	4796	2014-12-07 16:17:40.081791	\N
10539	113	4797	2014-12-07 16:17:40.678661	\N
10540	113	4798	2014-12-07 16:17:40.681406	\N
10541	113	4799	2014-12-07 16:17:40.683451	\N
10542	113	4800	2014-12-07 16:17:40.685539	\N
10543	113	4801	2014-12-07 16:17:40.687699	\N
10544	113	4802	2014-12-07 16:17:40.68986	\N
10545	113	4803	2014-12-07 16:17:40.692096	\N
10546	113	4804	2014-12-07 16:17:40.694443	\N
10547	114	4805	2014-12-07 16:17:41.231523	\N
10548	115	4806	2014-12-07 16:17:41.61747	\N
10549	116	4807	2014-12-07 16:17:41.996199	\N
10550	117	4808	2014-12-07 16:17:42.374451	\N
10551	118	4809	2014-12-07 16:17:42.762892	\N
10552	119	4810	2014-12-07 16:17:43.305415	\N
10553	119	4811	2014-12-07 16:17:43.308163	\N
10554	119	4812	2014-12-07 16:17:43.310371	\N
10555	119	4813	2014-12-07 16:17:43.312582	\N
10556	119	4814	2014-12-07 16:17:43.31492	\N
10557	120	4815	2014-12-07 16:17:43.709229	\N
10558	121	4816	2014-12-07 16:17:44.104034	\N
10559	122	4817	2014-12-07 16:17:44.510947	\N
10560	123	4818	2014-12-07 16:17:44.991835	\N
10561	123	4819	2014-12-07 16:17:44.994727	\N
10562	123	4820	2014-12-07 16:17:44.997172	\N
\.


--
-- Name: goal_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_project_id_seq', 10562, true);


--
-- Data for Name: goal_secretary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal_secretary (id, goal_id, secretary_id, created_at, update_at) FROM stdin;
7899	1	2	2014-12-07 16:16:31.706193	\N
7900	2	2	2014-12-07 16:16:31.92139	\N
7901	2	2	2014-12-07 16:16:31.923875	\N
7902	3	2	2014-12-07 16:16:32.326927	\N
7903	3	2	2014-12-07 16:16:32.329955	\N
7904	3	2	2014-12-07 16:16:32.333311	\N
7905	4	2	2014-12-07 16:16:32.401244	\N
7906	4	2	2014-12-07 16:16:32.403811	\N
7907	4	2	2014-12-07 16:16:32.405848	\N
7908	4	2	2014-12-07 16:16:32.407806	\N
7909	5	2	2014-12-07 16:16:32.450163	\N
7910	5	2	2014-12-07 16:16:32.4526	\N
7911	5	2	2014-12-07 16:16:32.454717	\N
7912	5	2	2014-12-07 16:16:32.457852	\N
7913	5	5	2014-12-07 16:16:32.461116	\N
7914	6	2	2014-12-07 16:16:32.490171	\N
7915	6	2	2014-12-07 16:16:32.49328	\N
7916	6	2	2014-12-07 16:16:32.49763	\N
7917	6	2	2014-12-07 16:16:32.500908	\N
7918	6	5	2014-12-07 16:16:32.503229	\N
7919	6	5	2014-12-07 16:16:32.505676	\N
7920	7	2	2014-12-07 16:16:32.570486	\N
7921	7	2	2014-12-07 16:16:32.57278	\N
7922	7	2	2014-12-07 16:16:32.574966	\N
7923	7	2	2014-12-07 16:16:32.577071	\N
7924	7	5	2014-12-07 16:16:32.579217	\N
7925	7	5	2014-12-07 16:16:32.581354	\N
7926	7	8	2014-12-07 16:16:32.583316	\N
7927	8	2	2014-12-07 16:16:32.672222	\N
7928	8	2	2014-12-07 16:16:32.674489	\N
7929	8	2	2014-12-07 16:16:32.676573	\N
7930	8	2	2014-12-07 16:16:32.678795	\N
7931	8	5	2014-12-07 16:16:32.680856	\N
7932	8	5	2014-12-07 16:16:32.682903	\N
7933	8	8	2014-12-07 16:16:32.685129	\N
7934	8	2	2014-12-07 16:16:32.687103	\N
7935	9	2	2014-12-07 16:16:32.726344	\N
7936	9	2	2014-12-07 16:16:32.729249	\N
7937	9	2	2014-12-07 16:16:32.731366	\N
7938	9	2	2014-12-07 16:16:32.733484	\N
7939	9	5	2014-12-07 16:16:32.735495	\N
7940	9	5	2014-12-07 16:16:32.737519	\N
7941	9	8	2014-12-07 16:16:32.739684	\N
7942	9	2	2014-12-07 16:16:32.741775	\N
7943	9	2	2014-12-07 16:16:32.743783	\N
7944	10	2	2014-12-07 16:16:33.123726	\N
7945	10	2	2014-12-07 16:16:33.125882	\N
7946	10	2	2014-12-07 16:16:33.127812	\N
7947	10	2	2014-12-07 16:16:33.129941	\N
7948	10	5	2014-12-07 16:16:33.132622	\N
7949	10	5	2014-12-07 16:16:33.134801	\N
7950	10	8	2014-12-07 16:16:33.136878	\N
7951	10	2	2014-12-07 16:16:33.13892	\N
7952	10	2	2014-12-07 16:16:33.141361	\N
7953	10	2	2014-12-07 16:16:33.143668	\N
7954	11	2	2014-12-07 16:16:33.389722	\N
7955	11	2	2014-12-07 16:16:33.391872	\N
7956	11	2	2014-12-07 16:16:33.394072	\N
7957	11	2	2014-12-07 16:16:33.397085	\N
7958	11	5	2014-12-07 16:16:33.400179	\N
7959	11	5	2014-12-07 16:16:33.402373	\N
7960	11	8	2014-12-07 16:16:33.404446	\N
7961	11	2	2014-12-07 16:16:33.40656	\N
7962	11	2	2014-12-07 16:16:33.408988	\N
7963	11	2	2014-12-07 16:16:33.411676	\N
7964	11	18	2014-12-07 16:16:33.414142	\N
7965	12	2	2014-12-07 16:16:33.556549	\N
7966	12	2	2014-12-07 16:16:33.559071	\N
7967	12	2	2014-12-07 16:16:33.561673	\N
7968	12	2	2014-12-07 16:16:33.564359	\N
7969	12	5	2014-12-07 16:16:33.566687	\N
7970	12	5	2014-12-07 16:16:33.568888	\N
7971	12	8	2014-12-07 16:16:33.57113	\N
7972	12	2	2014-12-07 16:16:33.573429	\N
7973	12	2	2014-12-07 16:16:33.575504	\N
7974	12	2	2014-12-07 16:16:33.577523	\N
7975	12	18	2014-12-07 16:16:33.579531	\N
7976	12	7	2014-12-07 16:16:33.581636	\N
7977	13	2	2014-12-07 16:16:33.662362	\N
7978	13	2	2014-12-07 16:16:33.6649	\N
7979	13	2	2014-12-07 16:16:33.667267	\N
7980	13	2	2014-12-07 16:16:33.669388	\N
7981	13	5	2014-12-07 16:16:33.671374	\N
7982	13	5	2014-12-07 16:16:33.673424	\N
7983	13	8	2014-12-07 16:16:33.675408	\N
7984	13	2	2014-12-07 16:16:33.67742	\N
7985	13	2	2014-12-07 16:16:33.679428	\N
7986	13	2	2014-12-07 16:16:33.682363	\N
7987	13	18	2014-12-07 16:16:33.684718	\N
7988	13	7	2014-12-07 16:16:33.686919	\N
7989	13	5	2014-12-07 16:16:33.689008	\N
7990	14	2	2014-12-07 16:16:34.140548	\N
7991	14	2	2014-12-07 16:16:34.142604	\N
7992	14	2	2014-12-07 16:16:34.144682	\N
7993	14	2	2014-12-07 16:16:34.14702	\N
7994	14	5	2014-12-07 16:16:34.149233	\N
7995	14	5	2014-12-07 16:16:34.151322	\N
7996	14	8	2014-12-07 16:16:34.153353	\N
7997	14	2	2014-12-07 16:16:34.15524	\N
7998	14	2	2014-12-07 16:16:34.157259	\N
7999	14	2	2014-12-07 16:16:34.159365	\N
8000	14	18	2014-12-07 16:16:34.162009	\N
8001	14	7	2014-12-07 16:16:34.164426	\N
8002	14	5	2014-12-07 16:16:34.166785	\N
8003	14	8	2014-12-07 16:16:34.168886	\N
8004	15	2	2014-12-07 16:16:34.209508	\N
8005	15	2	2014-12-07 16:16:34.211576	\N
8006	15	2	2014-12-07 16:16:34.213731	\N
8007	15	2	2014-12-07 16:16:34.215705	\N
8008	15	5	2014-12-07 16:16:34.217878	\N
8009	15	5	2014-12-07 16:16:34.219933	\N
8010	15	8	2014-12-07 16:16:34.222536	\N
8011	15	2	2014-12-07 16:16:34.224848	\N
8012	15	2	2014-12-07 16:16:34.226909	\N
8013	15	2	2014-12-07 16:16:34.229129	\N
8014	15	18	2014-12-07 16:16:34.231456	\N
8015	15	7	2014-12-07 16:16:34.233747	\N
8016	15	5	2014-12-07 16:16:34.23585	\N
8017	15	8	2014-12-07 16:16:34.237924	\N
8018	15	8	2014-12-07 16:16:34.240139	\N
8019	16	2	2014-12-07 16:16:34.570768	\N
8020	16	2	2014-12-07 16:16:34.572977	\N
8021	16	2	2014-12-07 16:16:34.575059	\N
8022	16	2	2014-12-07 16:16:34.577064	\N
8023	16	5	2014-12-07 16:16:34.579083	\N
8024	16	5	2014-12-07 16:16:34.581805	\N
8025	16	8	2014-12-07 16:16:34.584153	\N
8026	16	2	2014-12-07 16:16:34.586579	\N
8027	16	2	2014-12-07 16:16:34.588728	\N
8028	16	2	2014-12-07 16:16:34.590883	\N
8029	16	18	2014-12-07 16:16:34.592954	\N
8030	16	7	2014-12-07 16:16:34.595002	\N
8031	16	5	2014-12-07 16:16:34.597006	\N
8032	16	8	2014-12-07 16:16:34.599048	\N
8033	16	8	2014-12-07 16:16:34.601231	\N
8034	16	8	2014-12-07 16:16:34.603262	\N
8035	17	2	2014-12-07 16:16:38.571681	\N
8036	17	2	2014-12-07 16:16:38.574584	\N
8037	17	2	2014-12-07 16:16:38.577219	\N
8038	17	2	2014-12-07 16:16:38.579312	\N
8039	17	5	2014-12-07 16:16:38.582298	\N
8040	17	5	2014-12-07 16:16:38.585786	\N
8041	17	8	2014-12-07 16:16:38.588392	\N
8042	17	2	2014-12-07 16:16:38.590534	\N
8043	17	2	2014-12-07 16:16:38.592757	\N
8044	17	2	2014-12-07 16:16:38.595974	\N
8045	17	18	2014-12-07 16:16:38.598982	\N
8046	17	7	2014-12-07 16:16:38.601477	\N
8047	17	5	2014-12-07 16:16:38.603537	\N
8048	17	8	2014-12-07 16:16:38.606248	\N
8049	17	8	2014-12-07 16:16:38.608499	\N
8050	17	8	2014-12-07 16:16:38.61119	\N
8051	17	8	2014-12-07 16:16:38.613565	\N
8052	18	2	2014-12-07 16:16:39.938706	\N
8053	18	2	2014-12-07 16:16:39.941043	\N
8054	18	2	2014-12-07 16:16:39.944086	\N
8055	18	2	2014-12-07 16:16:39.946893	\N
8056	18	5	2014-12-07 16:16:39.949165	\N
8057	18	5	2014-12-07 16:16:39.95146	\N
8058	18	8	2014-12-07 16:16:39.954938	\N
8059	18	2	2014-12-07 16:16:39.957263	\N
8060	18	2	2014-12-07 16:16:39.959397	\N
8061	18	2	2014-12-07 16:16:39.961518	\N
8062	18	18	2014-12-07 16:16:39.964857	\N
8063	18	7	2014-12-07 16:16:39.967528	\N
8064	18	5	2014-12-07 16:16:39.970389	\N
8065	18	8	2014-12-07 16:16:39.973236	\N
8066	18	8	2014-12-07 16:16:39.975542	\N
8067	18	8	2014-12-07 16:16:39.977509	\N
8068	18	8	2014-12-07 16:16:39.979594	\N
8069	18	8	2014-12-07 16:16:39.981758	\N
8070	19	2	2014-12-07 16:16:40.033182	\N
8071	19	2	2014-12-07 16:16:40.035473	\N
8072	19	2	2014-12-07 16:16:40.038521	\N
8073	19	2	2014-12-07 16:16:40.041364	\N
8074	19	5	2014-12-07 16:16:40.044454	\N
8075	19	5	2014-12-07 16:16:40.047234	\N
8076	19	8	2014-12-07 16:16:40.0495	\N
8077	19	2	2014-12-07 16:16:40.051505	\N
8078	19	2	2014-12-07 16:16:40.054916	\N
8079	19	2	2014-12-07 16:16:40.058505	\N
8080	19	18	2014-12-07 16:16:40.061404	\N
8081	19	7	2014-12-07 16:16:40.064443	\N
8082	19	5	2014-12-07 16:16:40.066792	\N
8083	19	8	2014-12-07 16:16:40.068994	\N
8084	19	8	2014-12-07 16:16:40.073353	\N
8085	19	8	2014-12-07 16:16:40.076244	\N
8086	19	8	2014-12-07 16:16:40.078492	\N
8087	19	8	2014-12-07 16:16:40.080723	\N
8088	19	8	2014-12-07 16:16:40.083239	\N
8089	20	2	2014-12-07 16:16:40.784745	\N
8090	20	2	2014-12-07 16:16:40.787432	\N
8091	20	2	2014-12-07 16:16:40.790158	\N
8092	20	2	2014-12-07 16:16:40.792491	\N
8093	20	5	2014-12-07 16:16:40.794659	\N
8094	20	5	2014-12-07 16:16:40.797699	\N
8095	20	8	2014-12-07 16:16:40.800532	\N
8096	20	2	2014-12-07 16:16:40.802743	\N
8097	20	2	2014-12-07 16:16:40.805944	\N
8098	20	2	2014-12-07 16:16:40.808675	\N
8099	20	18	2014-12-07 16:16:40.811189	\N
8100	20	7	2014-12-07 16:16:40.813725	\N
8101	20	5	2014-12-07 16:16:40.81605	\N
8102	20	8	2014-12-07 16:16:40.818338	\N
8103	20	8	2014-12-07 16:16:40.820614	\N
8104	20	8	2014-12-07 16:16:40.823396	\N
8105	20	8	2014-12-07 16:16:40.825737	\N
8106	20	8	2014-12-07 16:16:40.828113	\N
8107	20	8	2014-12-07 16:16:40.830232	\N
8108	20	18	2014-12-07 16:16:40.832357	\N
8109	21	2	2014-12-07 16:16:40.875908	\N
8110	21	2	2014-12-07 16:16:40.878566	\N
8111	21	2	2014-12-07 16:16:40.882073	\N
8112	21	2	2014-12-07 16:16:40.886035	\N
8113	21	5	2014-12-07 16:16:40.888351	\N
8114	21	5	2014-12-07 16:16:40.891119	\N
8115	21	8	2014-12-07 16:16:40.893754	\N
8116	21	2	2014-12-07 16:16:40.896185	\N
8117	21	2	2014-12-07 16:16:40.898408	\N
8118	21	2	2014-12-07 16:16:40.900636	\N
8119	21	18	2014-12-07 16:16:40.903447	\N
8120	21	7	2014-12-07 16:16:40.905845	\N
8121	21	5	2014-12-07 16:16:40.908204	\N
8122	21	8	2014-12-07 16:16:40.91048	\N
8123	21	8	2014-12-07 16:16:40.912855	\N
8124	21	8	2014-12-07 16:16:40.915154	\N
8125	21	8	2014-12-07 16:16:40.917361	\N
8126	21	8	2014-12-07 16:16:40.919362	\N
8127	21	8	2014-12-07 16:16:40.921578	\N
8128	21	18	2014-12-07 16:16:40.924253	\N
8129	21	18	2014-12-07 16:16:40.926496	\N
8130	22	2	2014-12-07 16:16:41.006826	\N
8131	22	2	2014-12-07 16:16:41.00928	\N
8132	22	2	2014-12-07 16:16:41.011293	\N
8133	22	2	2014-12-07 16:16:41.013552	\N
8134	22	5	2014-12-07 16:16:41.015918	\N
8135	22	5	2014-12-07 16:16:41.018028	\N
8136	22	8	2014-12-07 16:16:41.020364	\N
8137	22	2	2014-12-07 16:16:41.023336	\N
8138	22	2	2014-12-07 16:16:41.025774	\N
8139	22	2	2014-12-07 16:16:41.028047	\N
8140	22	18	2014-12-07 16:16:41.03029	\N
8141	22	7	2014-12-07 16:16:41.032486	\N
8142	22	5	2014-12-07 16:16:41.034783	\N
8143	22	8	2014-12-07 16:16:41.036907	\N
8144	22	8	2014-12-07 16:16:41.039262	\N
8145	22	8	2014-12-07 16:16:41.041676	\N
8146	22	8	2014-12-07 16:16:41.043956	\N
8147	22	8	2014-12-07 16:16:41.046218	\N
8148	22	8	2014-12-07 16:16:41.048316	\N
8149	22	18	2014-12-07 16:16:41.050455	\N
8150	22	18	2014-12-07 16:16:41.05337	\N
8151	22	18	2014-12-07 16:16:41.055712	\N
8152	23	2	2014-12-07 16:16:41.408091	\N
8153	23	2	2014-12-07 16:16:41.411476	\N
8154	23	2	2014-12-07 16:16:41.414617	\N
8155	23	2	2014-12-07 16:16:41.417465	\N
8156	23	5	2014-12-07 16:16:41.420112	\N
8157	23	5	2014-12-07 16:16:41.42247	\N
8158	23	8	2014-12-07 16:16:41.42512	\N
8159	23	2	2014-12-07 16:16:41.427337	\N
8160	23	2	2014-12-07 16:16:41.430087	\N
8161	23	2	2014-12-07 16:16:41.433409	\N
8162	23	18	2014-12-07 16:16:41.435915	\N
8163	23	7	2014-12-07 16:16:41.438434	\N
8164	23	5	2014-12-07 16:16:41.44121	\N
8165	23	8	2014-12-07 16:16:41.443728	\N
8166	23	8	2014-12-07 16:16:41.446913	\N
8167	23	8	2014-12-07 16:16:41.450177	\N
8168	23	8	2014-12-07 16:16:41.452506	\N
8169	23	8	2014-12-07 16:16:41.454735	\N
8170	23	8	2014-12-07 16:16:41.456934	\N
8171	23	18	2014-12-07 16:16:41.460457	\N
8172	23	18	2014-12-07 16:16:41.462884	\N
8173	23	18	2014-12-07 16:16:41.466008	\N
8174	23	18	2014-12-07 16:16:41.468965	\N
8175	24	2	2014-12-07 16:16:42.659593	\N
8176	24	2	2014-12-07 16:16:42.662479	\N
8177	24	2	2014-12-07 16:16:42.664948	\N
8178	24	2	2014-12-07 16:16:42.667243	\N
8179	24	5	2014-12-07 16:16:42.669419	\N
8180	24	5	2014-12-07 16:16:42.671481	\N
8181	24	8	2014-12-07 16:16:42.67354	\N
8182	24	2	2014-12-07 16:16:42.675534	\N
8183	24	2	2014-12-07 16:16:42.677581	\N
8184	24	2	2014-12-07 16:16:42.680326	\N
8185	24	18	2014-12-07 16:16:42.682638	\N
8186	24	7	2014-12-07 16:16:42.684751	\N
8187	24	5	2014-12-07 16:16:42.68681	\N
8188	24	8	2014-12-07 16:16:42.688879	\N
8189	24	8	2014-12-07 16:16:42.690947	\N
8190	24	8	2014-12-07 16:16:42.693156	\N
8191	24	8	2014-12-07 16:16:42.695232	\N
8192	24	8	2014-12-07 16:16:42.697437	\N
8193	24	8	2014-12-07 16:16:42.699437	\N
8194	24	18	2014-12-07 16:16:42.701634	\N
8195	24	18	2014-12-07 16:16:42.703621	\N
8196	24	18	2014-12-07 16:16:42.705722	\N
8197	24	18	2014-12-07 16:16:42.707771	\N
8198	24	18	2014-12-07 16:16:42.710362	\N
8199	25	2	2014-12-07 16:16:43.549798	\N
8200	25	2	2014-12-07 16:16:43.552647	\N
8201	25	2	2014-12-07 16:16:43.555069	\N
8202	25	2	2014-12-07 16:16:43.557269	\N
8203	25	5	2014-12-07 16:16:43.559545	\N
8204	25	5	2014-12-07 16:16:43.561604	\N
8205	25	8	2014-12-07 16:16:43.563517	\N
8206	25	2	2014-12-07 16:16:43.565684	\N
8207	25	2	2014-12-07 16:16:43.568082	\N
8208	25	2	2014-12-07 16:16:43.570308	\N
8209	25	18	2014-12-07 16:16:43.572491	\N
8210	25	7	2014-12-07 16:16:43.574628	\N
8211	25	5	2014-12-07 16:16:43.57667	\N
8212	25	8	2014-12-07 16:16:43.578865	\N
8213	25	8	2014-12-07 16:16:43.581798	\N
8214	25	8	2014-12-07 16:16:43.584995	\N
8215	25	8	2014-12-07 16:16:43.58718	\N
8216	25	8	2014-12-07 16:16:43.589326	\N
8217	25	8	2014-12-07 16:16:43.591337	\N
8218	25	18	2014-12-07 16:16:43.593374	\N
8219	25	18	2014-12-07 16:16:43.595352	\N
8220	25	18	2014-12-07 16:16:43.597378	\N
8221	25	18	2014-12-07 16:16:43.599688	\N
8222	25	18	2014-12-07 16:16:43.601801	\N
8223	25	18	2014-12-07 16:16:43.603905	\N
8224	26	2	2014-12-07 16:16:44.25562	\N
8225	26	2	2014-12-07 16:16:44.258213	\N
8226	26	2	2014-12-07 16:16:44.260624	\N
8227	26	2	2014-12-07 16:16:44.26277	\N
8228	26	5	2014-12-07 16:16:44.26493	\N
8229	26	5	2014-12-07 16:16:44.2671	\N
8230	26	8	2014-12-07 16:16:44.269407	\N
8231	26	2	2014-12-07 16:16:44.272347	\N
8232	26	2	2014-12-07 16:16:44.274626	\N
8233	26	2	2014-12-07 16:16:44.276737	\N
8234	26	18	2014-12-07 16:16:44.278867	\N
8235	26	7	2014-12-07 16:16:44.280976	\N
8236	26	5	2014-12-07 16:16:44.283138	\N
8237	26	8	2014-12-07 16:16:44.285304	\N
8238	26	8	2014-12-07 16:16:44.287333	\N
8239	26	8	2014-12-07 16:16:44.289383	\N
8240	26	8	2014-12-07 16:16:44.291574	\N
8241	26	8	2014-12-07 16:16:44.293661	\N
8242	26	8	2014-12-07 16:16:44.295802	\N
8243	26	18	2014-12-07 16:16:44.298042	\N
8244	26	18	2014-12-07 16:16:44.300708	\N
8245	26	18	2014-12-07 16:16:44.303315	\N
8246	26	18	2014-12-07 16:16:44.305633	\N
8247	26	18	2014-12-07 16:16:44.307761	\N
8248	26	18	2014-12-07 16:16:44.309857	\N
8249	26	18	2014-12-07 16:16:44.311947	\N
8250	27	2	2014-12-07 16:16:44.691091	\N
8251	27	2	2014-12-07 16:16:44.693844	\N
8252	27	2	2014-12-07 16:16:44.696212	\N
8253	27	2	2014-12-07 16:16:44.698347	\N
8254	27	5	2014-12-07 16:16:44.700427	\N
8255	27	5	2014-12-07 16:16:44.702574	\N
8256	27	8	2014-12-07 16:16:44.704741	\N
8257	27	2	2014-12-07 16:16:44.707376	\N
8258	27	2	2014-12-07 16:16:44.709675	\N
8259	27	2	2014-12-07 16:16:44.711763	\N
8260	27	18	2014-12-07 16:16:44.713793	\N
8261	27	7	2014-12-07 16:16:44.715805	\N
8262	27	5	2014-12-07 16:16:44.717843	\N
8263	27	8	2014-12-07 16:16:44.720117	\N
8264	27	8	2014-12-07 16:16:44.722845	\N
8265	27	8	2014-12-07 16:16:44.725094	\N
8266	27	8	2014-12-07 16:16:44.72717	\N
8267	27	8	2014-12-07 16:16:44.729461	\N
8268	27	8	2014-12-07 16:16:44.731546	\N
8269	27	18	2014-12-07 16:16:44.73364	\N
8270	27	18	2014-12-07 16:16:44.735828	\N
8271	27	18	2014-12-07 16:16:44.738272	\N
8272	27	18	2014-12-07 16:16:44.740682	\N
8273	27	18	2014-12-07 16:16:44.742871	\N
8274	27	18	2014-12-07 16:16:44.744993	\N
8275	27	18	2014-12-07 16:16:44.747069	\N
8276	27	4	2014-12-07 16:16:44.749134	\N
8277	28	2	2014-12-07 16:16:44.872855	\N
8278	28	2	2014-12-07 16:16:44.87538	\N
8279	28	2	2014-12-07 16:16:44.877632	\N
8280	28	2	2014-12-07 16:16:44.879752	\N
8281	28	5	2014-12-07 16:16:44.881762	\N
8282	28	5	2014-12-07 16:16:44.883912	\N
8283	28	8	2014-12-07 16:16:44.88641	\N
8284	28	2	2014-12-07 16:16:44.888628	\N
8285	28	2	2014-12-07 16:16:44.890725	\N
8286	28	2	2014-12-07 16:16:44.892755	\N
8287	28	18	2014-12-07 16:16:44.894815	\N
8288	28	7	2014-12-07 16:16:44.899841	\N
8289	28	5	2014-12-07 16:16:44.903152	\N
8290	28	8	2014-12-07 16:16:44.90567	\N
8291	28	8	2014-12-07 16:16:44.907748	\N
8292	28	8	2014-12-07 16:16:44.90985	\N
8293	28	8	2014-12-07 16:16:44.912038	\N
8294	28	8	2014-12-07 16:16:44.914341	\N
8295	28	8	2014-12-07 16:16:44.916415	\N
8296	28	18	2014-12-07 16:16:44.918546	\N
8297	28	18	2014-12-07 16:16:44.920761	\N
8298	28	18	2014-12-07 16:16:44.922848	\N
8299	28	18	2014-12-07 16:16:44.924992	\N
8300	28	18	2014-12-07 16:16:44.927023	\N
8301	28	18	2014-12-07 16:16:44.929325	\N
8302	28	18	2014-12-07 16:16:44.932125	\N
8303	28	4	2014-12-07 16:16:44.934588	\N
8304	28	4	2014-12-07 16:16:44.936951	\N
8305	29	2	2014-12-07 16:16:45.029348	\N
8306	29	2	2014-12-07 16:16:45.031971	\N
8307	29	2	2014-12-07 16:16:45.034832	\N
8308	29	2	2014-12-07 16:16:45.037464	\N
8309	29	5	2014-12-07 16:16:45.039865	\N
8310	29	5	2014-12-07 16:16:45.041885	\N
8311	29	8	2014-12-07 16:16:45.043888	\N
8312	29	2	2014-12-07 16:16:45.045975	\N
8313	29	2	2014-12-07 16:16:45.048045	\N
8314	29	2	2014-12-07 16:16:45.050741	\N
8315	29	18	2014-12-07 16:16:45.053971	\N
8316	29	7	2014-12-07 16:16:45.056923	\N
8317	29	5	2014-12-07 16:16:45.059101	\N
8318	29	8	2014-12-07 16:16:45.061191	\N
8319	29	8	2014-12-07 16:16:45.063259	\N
8320	29	8	2014-12-07 16:16:45.065437	\N
8321	29	8	2014-12-07 16:16:45.067636	\N
8322	29	8	2014-12-07 16:16:45.070086	\N
8323	29	8	2014-12-07 16:16:45.072373	\N
8324	29	18	2014-12-07 16:16:45.074543	\N
8325	29	18	2014-12-07 16:16:45.076611	\N
8326	29	18	2014-12-07 16:16:45.078826	\N
8327	29	18	2014-12-07 16:16:45.081331	\N
8328	29	18	2014-12-07 16:16:45.0838	\N
8329	29	18	2014-12-07 16:16:45.0861	\N
8330	29	18	2014-12-07 16:16:45.088356	\N
8331	29	4	2014-12-07 16:16:45.090547	\N
8332	29	4	2014-12-07 16:16:45.09266	\N
8333	29	4	2014-12-07 16:16:45.094931	\N
8334	30	2	2014-12-07 16:16:45.167196	\N
8335	30	2	2014-12-07 16:16:45.169842	\N
8336	30	2	2014-12-07 16:16:45.172594	\N
8337	30	2	2014-12-07 16:16:45.174957	\N
8338	30	5	2014-12-07 16:16:45.17713	\N
8339	30	5	2014-12-07 16:16:45.179269	\N
8340	30	8	2014-12-07 16:16:45.181386	\N
8341	30	2	2014-12-07 16:16:45.183564	\N
8342	30	2	2014-12-07 16:16:45.185769	\N
8343	30	2	2014-12-07 16:16:45.188005	\N
8344	30	18	2014-12-07 16:16:45.190128	\N
8345	30	7	2014-12-07 16:16:45.192501	\N
8346	30	5	2014-12-07 16:16:45.194677	\N
8347	30	8	2014-12-07 16:16:45.196949	\N
8348	30	8	2014-12-07 16:16:45.198984	\N
8349	30	8	2014-12-07 16:16:45.201375	\N
8350	30	8	2014-12-07 16:16:45.204013	\N
8351	30	8	2014-12-07 16:16:45.206354	\N
8352	30	8	2014-12-07 16:16:45.208644	\N
8353	30	18	2014-12-07 16:16:45.210783	\N
8354	30	18	2014-12-07 16:16:45.213015	\N
8355	30	18	2014-12-07 16:16:45.215178	\N
8356	30	18	2014-12-07 16:16:45.21721	\N
8357	30	18	2014-12-07 16:16:45.219177	\N
8358	30	18	2014-12-07 16:16:45.221381	\N
8359	30	18	2014-12-07 16:16:45.223607	\N
8360	30	4	2014-12-07 16:16:45.225761	\N
8361	30	4	2014-12-07 16:16:45.227806	\N
8362	30	4	2014-12-07 16:16:45.229905	\N
8363	30	4	2014-12-07 16:16:45.232567	\N
8364	31	2	2014-12-07 16:16:45.279718	\N
8365	31	2	2014-12-07 16:16:45.282179	\N
8366	31	2	2014-12-07 16:16:45.284462	\N
8367	31	2	2014-12-07 16:16:45.286694	\N
8368	31	5	2014-12-07 16:16:45.289626	\N
8369	31	5	2014-12-07 16:16:45.292416	\N
8370	31	8	2014-12-07 16:16:45.29494	\N
8371	31	2	2014-12-07 16:16:45.297328	\N
8372	31	2	2014-12-07 16:16:45.299353	\N
8373	31	2	2014-12-07 16:16:45.30148	\N
8374	31	18	2014-12-07 16:16:45.303739	\N
8375	31	7	2014-12-07 16:16:45.305936	\N
8376	31	5	2014-12-07 16:16:45.308196	\N
8377	31	8	2014-12-07 16:16:45.310286	\N
8378	31	8	2014-12-07 16:16:45.312347	\N
8379	31	8	2014-12-07 16:16:45.314408	\N
8380	31	8	2014-12-07 16:16:45.316471	\N
8381	31	8	2014-12-07 16:16:45.318532	\N
8382	31	8	2014-12-07 16:16:45.321254	\N
8383	31	18	2014-12-07 16:16:45.323606	\N
8384	31	18	2014-12-07 16:16:45.325849	\N
8385	31	18	2014-12-07 16:16:45.327979	\N
8386	31	18	2014-12-07 16:16:45.330094	\N
8387	31	18	2014-12-07 16:16:45.332191	\N
8388	31	18	2014-12-07 16:16:45.33448	\N
8389	31	18	2014-12-07 16:16:45.336618	\N
8390	31	4	2014-12-07 16:16:45.338882	\N
8391	31	4	2014-12-07 16:16:45.341019	\N
8392	31	4	2014-12-07 16:16:45.343027	\N
8393	31	4	2014-12-07 16:16:45.345059	\N
8394	31	4	2014-12-07 16:16:45.347053	\N
8395	32	2	2014-12-07 16:16:45.398186	\N
8396	32	2	2014-12-07 16:16:45.400595	\N
8397	32	2	2014-12-07 16:16:45.402911	\N
8398	32	2	2014-12-07 16:16:45.405301	\N
8399	32	5	2014-12-07 16:16:45.408021	\N
8400	32	5	2014-12-07 16:16:45.411133	\N
8401	32	8	2014-12-07 16:16:45.413501	\N
8402	32	2	2014-12-07 16:16:45.41615	\N
8403	32	2	2014-12-07 16:16:45.418274	\N
8404	32	2	2014-12-07 16:16:45.420595	\N
8405	32	18	2014-12-07 16:16:45.422974	\N
8406	32	7	2014-12-07 16:16:45.425206	\N
8407	32	5	2014-12-07 16:16:45.427181	\N
8408	32	8	2014-12-07 16:16:45.42922	\N
8409	32	8	2014-12-07 16:16:45.431168	\N
8410	32	8	2014-12-07 16:16:45.43324	\N
8411	32	8	2014-12-07 16:16:45.43555	\N
8412	32	8	2014-12-07 16:16:45.437711	\N
8413	32	8	2014-12-07 16:16:45.440457	\N
8414	32	18	2014-12-07 16:16:45.442902	\N
8415	32	18	2014-12-07 16:16:45.445402	\N
8416	32	18	2014-12-07 16:16:45.447501	\N
8417	32	18	2014-12-07 16:16:45.44972	\N
8418	32	18	2014-12-07 16:16:45.451905	\N
8419	32	18	2014-12-07 16:16:45.453991	\N
8420	32	18	2014-12-07 16:16:45.456369	\N
8421	32	4	2014-12-07 16:16:45.458807	\N
8422	32	4	2014-12-07 16:16:45.461261	\N
8423	32	4	2014-12-07 16:16:45.463428	\N
8424	32	4	2014-12-07 16:16:45.465625	\N
8425	32	4	2014-12-07 16:16:45.467904	\N
8426	32	4	2014-12-07 16:16:45.471082	\N
8427	33	2	2014-12-07 16:16:45.539316	\N
8428	33	2	2014-12-07 16:16:45.54202	\N
8429	33	2	2014-12-07 16:16:45.544239	\N
8430	33	2	2014-12-07 16:16:45.546507	\N
8431	33	5	2014-12-07 16:16:45.548645	\N
8432	33	5	2014-12-07 16:16:45.550792	\N
8433	33	8	2014-12-07 16:16:45.553	\N
8434	33	2	2014-12-07 16:16:45.555338	\N
8435	33	2	2014-12-07 16:16:45.557505	\N
8436	33	2	2014-12-07 16:16:45.559628	\N
8437	33	18	2014-12-07 16:16:45.562212	\N
8438	33	7	2014-12-07 16:16:45.564462	\N
8439	33	5	2014-12-07 16:16:45.566606	\N
8440	33	8	2014-12-07 16:16:45.568911	\N
8441	33	8	2014-12-07 16:16:45.571056	\N
8442	33	8	2014-12-07 16:16:45.573508	\N
8443	33	8	2014-12-07 16:16:45.575967	\N
8444	33	8	2014-12-07 16:16:45.578051	\N
8445	33	8	2014-12-07 16:16:45.580111	\N
8446	33	18	2014-12-07 16:16:45.582163	\N
8447	33	18	2014-12-07 16:16:45.584259	\N
8448	33	18	2014-12-07 16:16:45.586675	\N
8449	33	18	2014-12-07 16:16:45.591451	\N
8450	33	18	2014-12-07 16:16:45.594248	\N
8451	33	18	2014-12-07 16:16:45.596454	\N
8452	33	18	2014-12-07 16:16:45.598881	\N
8453	33	4	2014-12-07 16:16:45.601054	\N
8454	33	4	2014-12-07 16:16:45.603161	\N
8455	33	4	2014-12-07 16:16:45.605313	\N
8456	33	4	2014-12-07 16:16:45.607854	\N
8457	33	4	2014-12-07 16:16:45.61012	\N
8458	33	4	2014-12-07 16:16:45.612227	\N
8459	33	4	2014-12-07 16:16:45.614499	\N
8460	34	2	2014-12-07 16:16:45.66514	\N
8461	34	2	2014-12-07 16:16:45.667389	\N
8462	34	2	2014-12-07 16:16:45.669634	\N
8463	34	2	2014-12-07 16:16:45.671753	\N
8464	34	5	2014-12-07 16:16:45.674389	\N
8465	34	5	2014-12-07 16:16:45.676621	\N
8466	34	8	2014-12-07 16:16:45.678724	\N
8467	34	2	2014-12-07 16:16:45.681279	\N
8468	34	2	2014-12-07 16:16:45.68359	\N
8469	34	2	2014-12-07 16:16:45.685887	\N
8470	34	18	2014-12-07 16:16:45.688049	\N
8471	34	7	2014-12-07 16:16:45.690404	\N
8472	34	5	2014-12-07 16:16:45.692803	\N
8473	34	8	2014-12-07 16:16:45.694988	\N
8474	34	8	2014-12-07 16:16:45.697095	\N
8475	34	8	2014-12-07 16:16:45.699093	\N
8476	34	8	2014-12-07 16:16:45.701162	\N
8477	34	8	2014-12-07 16:16:45.703162	\N
8478	34	8	2014-12-07 16:16:45.705238	\N
8479	34	18	2014-12-07 16:16:45.707344	\N
8480	34	18	2014-12-07 16:16:45.709504	\N
8481	34	18	2014-12-07 16:16:45.712056	\N
8482	34	18	2014-12-07 16:16:45.714563	\N
8483	34	18	2014-12-07 16:16:45.716747	\N
8484	34	18	2014-12-07 16:16:45.718855	\N
8485	34	18	2014-12-07 16:16:45.720937	\N
8486	34	4	2014-12-07 16:16:45.723408	\N
8487	34	4	2014-12-07 16:16:45.725672	\N
8488	34	4	2014-12-07 16:16:45.727828	\N
8489	34	4	2014-12-07 16:16:45.729952	\N
8490	34	4	2014-12-07 16:16:45.732005	\N
8491	34	4	2014-12-07 16:16:45.734064	\N
8492	34	4	2014-12-07 16:16:45.736115	\N
8493	34	4	2014-12-07 16:16:45.738165	\N
8494	35	2	2014-12-07 16:16:54.000377	\N
8495	35	2	2014-12-07 16:16:54.003569	\N
8496	35	2	2014-12-07 16:16:54.006062	\N
8497	35	2	2014-12-07 16:16:54.008589	\N
8498	35	5	2014-12-07 16:16:54.011418	\N
8499	35	5	2014-12-07 16:16:54.014993	\N
8500	35	8	2014-12-07 16:16:54.018464	\N
8501	35	2	2014-12-07 16:16:54.021126	\N
8502	35	2	2014-12-07 16:16:54.023467	\N
8503	35	2	2014-12-07 16:16:54.025573	\N
8504	35	18	2014-12-07 16:16:54.027576	\N
8505	35	7	2014-12-07 16:16:54.02966	\N
8506	35	5	2014-12-07 16:16:54.031632	\N
8507	35	8	2014-12-07 16:16:54.033728	\N
8508	35	8	2014-12-07 16:16:54.03683	\N
8509	35	8	2014-12-07 16:16:54.041451	\N
8510	35	8	2014-12-07 16:16:54.044018	\N
8511	35	8	2014-12-07 16:16:54.046356	\N
8512	35	8	2014-12-07 16:16:54.04858	\N
8513	35	18	2014-12-07 16:16:54.050976	\N
8514	35	18	2014-12-07 16:16:54.053707	\N
8515	35	18	2014-12-07 16:16:54.055895	\N
8516	35	18	2014-12-07 16:16:54.058084	\N
8517	35	18	2014-12-07 16:16:54.060253	\N
8518	35	18	2014-12-07 16:16:54.062409	\N
8519	35	18	2014-12-07 16:16:54.064701	\N
8520	35	4	2014-12-07 16:16:54.066883	\N
8521	35	4	2014-12-07 16:16:54.069214	\N
8522	35	4	2014-12-07 16:16:54.071738	\N
8523	35	4	2014-12-07 16:16:54.074244	\N
8524	35	4	2014-12-07 16:16:54.076669	\N
8525	35	4	2014-12-07 16:16:54.079001	\N
8526	35	4	2014-12-07 16:16:54.081295	\N
8527	35	4	2014-12-07 16:16:54.08431	\N
8528	35	11	2014-12-07 16:16:54.087926	\N
8529	36	2	2014-12-07 16:16:55.189316	\N
8530	36	2	2014-12-07 16:16:55.191759	\N
8531	36	2	2014-12-07 16:16:55.19391	\N
8532	36	2	2014-12-07 16:16:55.196409	\N
8533	36	5	2014-12-07 16:16:55.198551	\N
8534	36	5	2014-12-07 16:16:55.200614	\N
8535	36	8	2014-12-07 16:16:55.202662	\N
8536	36	2	2014-12-07 16:16:55.204892	\N
8537	36	2	2014-12-07 16:16:55.207057	\N
8538	36	2	2014-12-07 16:16:55.209117	\N
8539	36	18	2014-12-07 16:16:55.211137	\N
8540	36	7	2014-12-07 16:16:55.213237	\N
8541	36	5	2014-12-07 16:16:55.215849	\N
8542	36	8	2014-12-07 16:16:55.218256	\N
8543	36	8	2014-12-07 16:16:55.220399	\N
8544	36	8	2014-12-07 16:16:55.22273	\N
8545	36	8	2014-12-07 16:16:55.224883	\N
8546	36	8	2014-12-07 16:16:55.227213	\N
8547	36	8	2014-12-07 16:16:55.229316	\N
8548	36	18	2014-12-07 16:16:55.23133	\N
8549	36	18	2014-12-07 16:16:55.233366	\N
8550	36	18	2014-12-07 16:16:55.235353	\N
8551	36	18	2014-12-07 16:16:55.23738	\N
8552	36	18	2014-12-07 16:16:55.239559	\N
8553	36	18	2014-12-07 16:16:55.241735	\N
8554	36	18	2014-12-07 16:16:55.243829	\N
8555	36	4	2014-12-07 16:16:55.246409	\N
8556	36	4	2014-12-07 16:16:55.24875	\N
8557	36	4	2014-12-07 16:16:55.250883	\N
8558	36	4	2014-12-07 16:16:55.252984	\N
8559	36	4	2014-12-07 16:16:55.255435	\N
8560	36	4	2014-12-07 16:16:55.257626	\N
8561	36	4	2014-12-07 16:16:55.259605	\N
8562	36	4	2014-12-07 16:16:55.261695	\N
8563	36	11	2014-12-07 16:16:55.263866	\N
8564	36	11	2014-12-07 16:16:55.266026	\N
8565	37	2	2014-12-07 16:16:57.858832	\N
8566	37	2	2014-12-07 16:16:57.861288	\N
8567	37	2	2014-12-07 16:16:57.864422	\N
8568	37	2	2014-12-07 16:16:57.867082	\N
8569	37	5	2014-12-07 16:16:57.869531	\N
8570	37	5	2014-12-07 16:16:57.871639	\N
8571	37	8	2014-12-07 16:16:57.873749	\N
8572	37	2	2014-12-07 16:16:57.87598	\N
8573	37	2	2014-12-07 16:16:57.878041	\N
8574	37	2	2014-12-07 16:16:57.880105	\N
8575	37	18	2014-12-07 16:16:57.882743	\N
8576	37	7	2014-12-07 16:16:57.884885	\N
8577	37	5	2014-12-07 16:16:57.886921	\N
8578	37	8	2014-12-07 16:16:57.888914	\N
8579	37	8	2014-12-07 16:16:57.890901	\N
8580	37	8	2014-12-07 16:16:57.892946	\N
8581	37	8	2014-12-07 16:16:57.895482	\N
8582	37	8	2014-12-07 16:16:57.897922	\N
8583	37	8	2014-12-07 16:16:57.900088	\N
8584	37	18	2014-12-07 16:16:57.902322	\N
8585	37	18	2014-12-07 16:16:57.904577	\N
8586	37	18	2014-12-07 16:16:57.906652	\N
8587	37	18	2014-12-07 16:16:57.908718	\N
8588	37	18	2014-12-07 16:16:57.910778	\N
8589	37	18	2014-12-07 16:16:57.913287	\N
8590	37	18	2014-12-07 16:16:57.916129	\N
8591	37	4	2014-12-07 16:16:57.920547	\N
8592	37	4	2014-12-07 16:16:57.922955	\N
8593	37	4	2014-12-07 16:16:57.925598	\N
8594	37	4	2014-12-07 16:16:57.927906	\N
8595	37	4	2014-12-07 16:16:57.930068	\N
8596	37	4	2014-12-07 16:16:57.933091	\N
8597	37	4	2014-12-07 16:16:57.935362	\N
8598	37	4	2014-12-07 16:16:57.937567	\N
8599	37	11	2014-12-07 16:16:57.939577	\N
8600	37	11	2014-12-07 16:16:57.941635	\N
8601	37	11	2014-12-07 16:16:57.943879	\N
8602	38	2	2014-12-07 16:16:58.025633	\N
8603	38	2	2014-12-07 16:16:58.028026	\N
8604	38	2	2014-12-07 16:16:58.030269	\N
8605	38	2	2014-12-07 16:16:58.032754	\N
8606	38	5	2014-12-07 16:16:58.034961	\N
8607	38	5	2014-12-07 16:16:58.037122	\N
8608	38	8	2014-12-07 16:16:58.039374	\N
8609	38	2	2014-12-07 16:16:58.041624	\N
8610	38	2	2014-12-07 16:16:58.043652	\N
8611	38	2	2014-12-07 16:16:58.046607	\N
8612	38	18	2014-12-07 16:16:58.049301	\N
8613	38	7	2014-12-07 16:16:58.05157	\N
8614	38	5	2014-12-07 16:16:58.053741	\N
8615	38	8	2014-12-07 16:16:58.055799	\N
8616	38	8	2014-12-07 16:16:58.057885	\N
8617	38	8	2014-12-07 16:16:58.060067	\N
8618	38	8	2014-12-07 16:16:58.062182	\N
8619	38	8	2014-12-07 16:16:58.064413	\N
8620	38	8	2014-12-07 16:16:58.066609	\N
8621	38	18	2014-12-07 16:16:58.068807	\N
8622	38	18	2014-12-07 16:16:58.070986	\N
8623	38	18	2014-12-07 16:16:58.073014	\N
8624	38	18	2014-12-07 16:16:58.075217	\N
8625	38	18	2014-12-07 16:16:58.077865	\N
8626	38	18	2014-12-07 16:16:58.080059	\N
8627	38	18	2014-12-07 16:16:58.082539	\N
8628	38	4	2014-12-07 16:16:58.084761	\N
8629	38	4	2014-12-07 16:16:58.086947	\N
8630	38	4	2014-12-07 16:16:58.089299	\N
8631	38	4	2014-12-07 16:16:58.091393	\N
8632	38	4	2014-12-07 16:16:58.093455	\N
8633	38	4	2014-12-07 16:16:58.095517	\N
8634	38	4	2014-12-07 16:16:58.097544	\N
8635	38	4	2014-12-07 16:16:58.099565	\N
8636	38	11	2014-12-07 16:16:58.10201	\N
8637	38	11	2014-12-07 16:16:58.104125	\N
8638	38	11	2014-12-07 16:16:58.106891	\N
8639	38	19	2014-12-07 16:16:58.109264	\N
8640	39	2	2014-12-07 16:16:58.189206	\N
8641	39	2	2014-12-07 16:16:58.191851	\N
8642	39	2	2014-12-07 16:16:58.194191	\N
8643	39	2	2014-12-07 16:16:58.196794	\N
8644	39	5	2014-12-07 16:16:58.199316	\N
8645	39	5	2014-12-07 16:16:58.201639	\N
8646	39	8	2014-12-07 16:16:58.203796	\N
8647	39	2	2014-12-07 16:16:58.205906	\N
8648	39	2	2014-12-07 16:16:58.20825	\N
8649	39	2	2014-12-07 16:16:58.210632	\N
8650	39	18	2014-12-07 16:16:58.212763	\N
8651	39	7	2014-12-07 16:16:58.214811	\N
8652	39	5	2014-12-07 16:16:58.217045	\N
8653	39	8	2014-12-07 16:16:58.219072	\N
8654	39	8	2014-12-07 16:16:58.22115	\N
8655	39	8	2014-12-07 16:16:58.223085	\N
8656	39	8	2014-12-07 16:16:58.225664	\N
8657	39	8	2014-12-07 16:16:58.228296	\N
8658	39	8	2014-12-07 16:16:58.23055	\N
8659	39	18	2014-12-07 16:16:58.232954	\N
8660	39	18	2014-12-07 16:16:58.235204	\N
8661	39	18	2014-12-07 16:16:58.237273	\N
8662	39	18	2014-12-07 16:16:58.239479	\N
8663	39	18	2014-12-07 16:16:58.241835	\N
8664	39	18	2014-12-07 16:16:58.244058	\N
8665	39	18	2014-12-07 16:16:58.246066	\N
8666	39	4	2014-12-07 16:16:58.248079	\N
8667	39	4	2014-12-07 16:16:58.250184	\N
8668	39	4	2014-12-07 16:16:58.25235	\N
8669	39	4	2014-12-07 16:16:58.254419	\N
8670	39	4	2014-12-07 16:16:58.256945	\N
8671	39	4	2014-12-07 16:16:58.259308	\N
8672	39	4	2014-12-07 16:16:58.261561	\N
8673	39	4	2014-12-07 16:16:58.263961	\N
8674	39	11	2014-12-07 16:16:58.266156	\N
8675	39	11	2014-12-07 16:16:58.268372	\N
8676	39	11	2014-12-07 16:16:58.270542	\N
8677	39	19	2014-12-07 16:16:58.272752	\N
8678	39	19	2014-12-07 16:16:58.274825	\N
8679	40	2	2014-12-07 16:16:58.347892	\N
8680	40	2	2014-12-07 16:16:58.35076	\N
8681	40	2	2014-12-07 16:16:58.353346	\N
8682	40	2	2014-12-07 16:16:58.355546	\N
8683	40	5	2014-12-07 16:16:58.357703	\N
8684	40	5	2014-12-07 16:16:58.359766	\N
8685	40	8	2014-12-07 16:16:58.36207	\N
8686	40	2	2014-12-07 16:16:58.364198	\N
8687	40	2	2014-12-07 16:16:58.366439	\N
8688	40	2	2014-12-07 16:16:58.368697	\N
8689	40	18	2014-12-07 16:16:58.370927	\N
8690	40	7	2014-12-07 16:16:58.372971	\N
8691	40	5	2014-12-07 16:16:58.375069	\N
8692	40	8	2014-12-07 16:16:58.377613	\N
8693	40	8	2014-12-07 16:16:58.379954	\N
8694	40	8	2014-12-07 16:16:58.382618	\N
8695	40	8	2014-12-07 16:16:58.385169	\N
8696	40	8	2014-12-07 16:16:58.387284	\N
8697	40	8	2014-12-07 16:16:58.389401	\N
8698	40	18	2014-12-07 16:16:58.391401	\N
8699	40	18	2014-12-07 16:16:58.393479	\N
8700	40	18	2014-12-07 16:16:58.395518	\N
8701	40	18	2014-12-07 16:16:58.397501	\N
8702	40	18	2014-12-07 16:16:58.39966	\N
8703	40	18	2014-12-07 16:16:58.401742	\N
8704	40	18	2014-12-07 16:16:58.403843	\N
8705	40	4	2014-12-07 16:16:58.406291	\N
8706	40	4	2014-12-07 16:16:58.408774	\N
8707	40	4	2014-12-07 16:16:58.410982	\N
8708	40	4	2014-12-07 16:16:58.41309	\N
8709	40	4	2014-12-07 16:16:58.415178	\N
8710	40	4	2014-12-07 16:16:58.417489	\N
8711	40	4	2014-12-07 16:16:58.41953	\N
8712	40	4	2014-12-07 16:16:58.421692	\N
8713	40	11	2014-12-07 16:16:58.423674	\N
8714	40	11	2014-12-07 16:16:58.425747	\N
8715	40	11	2014-12-07 16:16:58.427796	\N
8716	40	19	2014-12-07 16:16:58.430035	\N
8717	40	19	2014-12-07 16:16:58.432125	\N
8718	40	15	2014-12-07 16:16:58.434388	\N
8719	41	2	2014-12-07 16:16:58.515705	\N
8720	41	2	2014-12-07 16:16:58.519372	\N
8721	41	2	2014-12-07 16:16:58.522907	\N
8722	41	2	2014-12-07 16:16:58.525224	\N
8723	41	5	2014-12-07 16:16:58.52774	\N
8724	41	5	2014-12-07 16:16:58.530228	\N
8725	41	8	2014-12-07 16:16:58.532679	\N
8726	41	2	2014-12-07 16:16:58.535482	\N
8727	41	2	2014-12-07 16:16:58.538076	\N
8728	41	2	2014-12-07 16:16:58.540302	\N
8729	41	18	2014-12-07 16:16:58.542465	\N
8730	41	7	2014-12-07 16:16:58.544561	\N
8731	41	5	2014-12-07 16:16:58.546623	\N
8732	41	8	2014-12-07 16:16:58.548712	\N
8733	41	8	2014-12-07 16:16:58.550907	\N
8734	41	8	2014-12-07 16:16:58.55318	\N
8735	41	8	2014-12-07 16:16:58.555143	\N
8736	41	8	2014-12-07 16:16:58.557685	\N
8737	41	8	2014-12-07 16:16:58.559974	\N
8738	41	18	2014-12-07 16:16:58.562162	\N
8739	41	18	2014-12-07 16:16:58.564357	\N
8740	41	18	2014-12-07 16:16:58.566511	\N
8741	41	18	2014-12-07 16:16:58.56885	\N
8742	41	18	2014-12-07 16:16:58.571059	\N
8743	41	18	2014-12-07 16:16:58.573176	\N
8744	41	18	2014-12-07 16:16:58.575159	\N
8745	41	4	2014-12-07 16:16:58.57724	\N
8746	41	4	2014-12-07 16:16:58.579496	\N
8747	41	4	2014-12-07 16:16:58.581686	\N
8748	41	4	2014-12-07 16:16:58.583994	\N
8749	41	4	2014-12-07 16:16:58.586531	\N
8750	41	4	2014-12-07 16:16:58.589257	\N
8751	41	4	2014-12-07 16:16:58.591491	\N
8752	41	4	2014-12-07 16:16:58.593543	\N
8753	41	11	2014-12-07 16:16:58.595619	\N
8754	41	11	2014-12-07 16:16:58.597664	\N
8755	41	11	2014-12-07 16:16:58.599953	\N
8756	41	19	2014-12-07 16:16:58.602314	\N
8757	41	19	2014-12-07 16:16:58.604546	\N
8758	41	15	2014-12-07 16:16:58.606718	\N
8759	41	15	2014-12-07 16:16:58.608853	\N
8760	42	2	2014-12-07 16:16:59.412639	\N
8761	42	2	2014-12-07 16:16:59.415249	\N
8762	42	2	2014-12-07 16:16:59.417396	\N
8763	42	2	2014-12-07 16:16:59.419434	\N
8764	42	5	2014-12-07 16:16:59.421531	\N
8765	42	5	2014-12-07 16:16:59.423503	\N
8766	42	8	2014-12-07 16:16:59.42552	\N
8767	42	2	2014-12-07 16:16:59.427645	\N
8768	42	2	2014-12-07 16:16:59.430188	\N
8769	42	2	2014-12-07 16:16:59.432562	\N
8770	42	18	2014-12-07 16:16:59.434714	\N
8771	42	7	2014-12-07 16:16:59.437429	\N
8772	42	5	2014-12-07 16:16:59.439664	\N
8773	42	8	2014-12-07 16:16:59.442259	\N
8774	42	8	2014-12-07 16:16:59.444587	\N
8775	42	8	2014-12-07 16:16:59.44673	\N
8776	42	8	2014-12-07 16:16:59.448852	\N
8777	42	8	2014-12-07 16:16:59.450936	\N
8778	42	8	2014-12-07 16:16:59.453182	\N
8779	42	18	2014-12-07 16:16:59.455244	\N
8780	42	18	2014-12-07 16:16:59.457355	\N
8781	42	18	2014-12-07 16:16:59.461054	\N
8782	42	18	2014-12-07 16:16:59.463407	\N
8783	42	18	2014-12-07 16:16:59.465578	\N
8784	42	18	2014-12-07 16:16:59.467668	\N
8785	42	18	2014-12-07 16:16:59.469977	\N
8786	42	4	2014-12-07 16:16:59.472784	\N
8787	42	4	2014-12-07 16:16:59.475467	\N
8788	42	4	2014-12-07 16:16:59.478036	\N
8789	42	4	2014-12-07 16:16:59.480192	\N
8790	42	4	2014-12-07 16:16:59.482289	\N
8791	42	4	2014-12-07 16:16:59.48448	\N
8792	42	4	2014-12-07 16:16:59.486656	\N
8793	42	4	2014-12-07 16:16:59.489257	\N
8794	42	11	2014-12-07 16:16:59.491522	\N
8795	42	11	2014-12-07 16:16:59.493617	\N
8796	42	11	2014-12-07 16:16:59.495772	\N
8797	42	19	2014-12-07 16:16:59.49809	\N
8798	42	19	2014-12-07 16:16:59.500188	\N
8799	42	15	2014-12-07 16:16:59.502253	\N
8800	42	15	2014-12-07 16:16:59.504592	\N
8801	42	19	2014-12-07 16:16:59.506863	\N
8802	43	2	2014-12-07 16:16:59.742134	\N
8803	43	2	2014-12-07 16:16:59.744505	\N
8804	43	2	2014-12-07 16:16:59.74661	\N
8805	43	2	2014-12-07 16:16:59.748688	\N
8806	43	5	2014-12-07 16:16:59.751422	\N
8807	43	5	2014-12-07 16:16:59.753775	\N
8808	43	8	2014-12-07 16:16:59.7561	\N
8809	43	2	2014-12-07 16:16:59.758637	\N
8810	43	2	2014-12-07 16:16:59.761169	\N
8811	43	2	2014-12-07 16:16:59.763284	\N
8812	43	18	2014-12-07 16:16:59.765545	\N
8813	43	7	2014-12-07 16:16:59.767603	\N
8814	43	5	2014-12-07 16:16:59.76968	\N
8815	43	8	2014-12-07 16:16:59.771876	\N
8816	43	8	2014-12-07 16:16:59.774025	\N
8817	43	8	2014-12-07 16:16:59.776112	\N
8818	43	8	2014-12-07 16:16:59.77811	\N
8819	43	8	2014-12-07 16:16:59.780151	\N
8820	43	8	2014-12-07 16:16:59.782306	\N
8821	43	18	2014-12-07 16:16:59.784487	\N
8822	43	18	2014-12-07 16:16:59.786579	\N
8823	43	18	2014-12-07 16:16:59.789164	\N
8824	43	18	2014-12-07 16:16:59.791478	\N
8825	43	18	2014-12-07 16:16:59.793634	\N
8826	43	18	2014-12-07 16:16:59.795669	\N
8827	43	18	2014-12-07 16:16:59.79773	\N
8828	43	4	2014-12-07 16:16:59.799678	\N
8829	43	4	2014-12-07 16:16:59.801902	\N
8830	43	4	2014-12-07 16:16:59.804286	\N
8831	43	4	2014-12-07 16:16:59.806531	\N
8832	43	4	2014-12-07 16:16:59.808603	\N
8833	43	4	2014-12-07 16:16:59.810667	\N
8834	43	4	2014-12-07 16:16:59.812645	\N
8835	43	4	2014-12-07 16:16:59.814721	\N
8836	43	11	2014-12-07 16:16:59.816689	\N
8837	43	11	2014-12-07 16:16:59.81906	\N
8838	43	11	2014-12-07 16:16:59.821842	\N
8839	43	19	2014-12-07 16:16:59.823928	\N
8840	43	19	2014-12-07 16:16:59.826053	\N
8841	43	15	2014-12-07 16:16:59.828202	\N
8842	43	15	2014-12-07 16:16:59.830386	\N
8843	43	19	2014-12-07 16:16:59.83239	\N
8844	43	7	2014-12-07 16:16:59.834505	\N
8845	44	2	2014-12-07 16:16:59.945614	\N
8846	44	2	2014-12-07 16:16:59.948089	\N
8847	44	2	2014-12-07 16:16:59.950394	\N
8848	44	2	2014-12-07 16:16:59.952567	\N
8849	44	5	2014-12-07 16:16:59.954902	\N
8850	44	5	2014-12-07 16:16:59.957158	\N
8851	44	8	2014-12-07 16:16:59.959653	\N
8852	44	2	2014-12-07 16:16:59.961628	\N
8853	44	2	2014-12-07 16:16:59.963654	\N
8854	44	2	2014-12-07 16:16:59.965812	\N
8855	44	18	2014-12-07 16:16:59.967737	\N
8856	44	7	2014-12-07 16:16:59.970394	\N
8857	44	5	2014-12-07 16:16:59.972777	\N
8858	44	8	2014-12-07 16:16:59.974946	\N
8859	44	8	2014-12-07 16:16:59.97702	\N
8860	44	8	2014-12-07 16:16:59.979079	\N
8861	44	8	2014-12-07 16:16:59.981106	\N
8862	44	8	2014-12-07 16:16:59.9831	\N
8863	44	8	2014-12-07 16:16:59.985278	\N
8864	44	18	2014-12-07 16:16:59.987249	\N
8865	44	18	2014-12-07 16:16:59.989358	\N
8866	44	18	2014-12-07 16:16:59.991331	\N
8867	44	18	2014-12-07 16:16:59.993335	\N
8868	44	18	2014-12-07 16:16:59.995236	\N
8869	44	18	2014-12-07 16:16:59.99758	\N
8870	44	18	2014-12-07 16:17:00.000167	\N
8871	44	4	2014-12-07 16:17:00.002626	\N
8872	44	4	2014-12-07 16:17:00.004971	\N
8873	44	4	2014-12-07 16:17:00.007308	\N
8874	44	4	2014-12-07 16:17:00.00947	\N
8875	44	4	2014-12-07 16:17:00.011429	\N
8876	44	4	2014-12-07 16:17:00.013464	\N
8877	44	4	2014-12-07 16:17:00.015401	\N
8878	44	4	2014-12-07 16:17:00.017574	\N
8879	44	11	2014-12-07 16:17:00.019508	\N
8880	44	11	2014-12-07 16:17:00.021752	\N
8881	44	11	2014-12-07 16:17:00.023775	\N
8882	44	19	2014-12-07 16:17:00.025859	\N
8883	44	19	2014-12-07 16:17:00.027783	\N
8884	44	15	2014-12-07 16:17:00.03075	\N
8885	44	15	2014-12-07 16:17:00.033041	\N
8886	44	19	2014-12-07 16:17:00.03516	\N
8887	44	7	2014-12-07 16:17:00.037199	\N
8888	44	2	2014-12-07 16:17:00.039664	\N
8889	45	2	2014-12-07 16:17:00.124035	\N
8890	45	2	2014-12-07 16:17:00.12666	\N
8891	45	2	2014-12-07 16:17:00.129046	\N
8892	45	2	2014-12-07 16:17:00.13145	\N
8893	45	5	2014-12-07 16:17:00.133869	\N
8894	45	5	2014-12-07 16:17:00.135891	\N
8895	45	8	2014-12-07 16:17:00.137958	\N
8896	45	2	2014-12-07 16:17:00.140299	\N
8897	45	2	2014-12-07 16:17:00.142411	\N
8898	45	2	2014-12-07 16:17:00.144457	\N
8899	45	18	2014-12-07 16:17:00.146555	\N
8900	45	7	2014-12-07 16:17:00.148577	\N
8901	45	5	2014-12-07 16:17:00.151065	\N
8902	45	8	2014-12-07 16:17:00.15346	\N
8903	45	8	2014-12-07 16:17:00.155934	\N
8904	45	8	2014-12-07 16:17:00.15804	\N
8905	45	8	2014-12-07 16:17:00.160112	\N
8906	45	8	2014-12-07 16:17:00.16218	\N
8907	45	8	2014-12-07 16:17:00.164287	\N
8908	45	18	2014-12-07 16:17:00.166515	\N
8909	45	18	2014-12-07 16:17:00.16863	\N
8910	45	18	2014-12-07 16:17:00.179916	\N
8911	45	18	2014-12-07 16:17:00.183367	\N
8912	45	18	2014-12-07 16:17:00.187426	\N
8913	45	18	2014-12-07 16:17:00.190812	\N
8914	45	18	2014-12-07 16:17:00.196447	\N
8915	45	4	2014-12-07 16:17:00.203208	\N
8916	45	4	2014-12-07 16:17:00.206698	\N
8917	45	4	2014-12-07 16:17:00.209274	\N
8918	45	4	2014-12-07 16:17:00.212283	\N
8919	45	4	2014-12-07 16:17:00.214852	\N
8920	45	4	2014-12-07 16:17:00.220178	\N
8921	45	4	2014-12-07 16:17:00.223454	\N
8922	45	4	2014-12-07 16:17:00.225942	\N
8923	45	11	2014-12-07 16:17:00.228295	\N
8924	45	11	2014-12-07 16:17:00.230599	\N
8925	45	11	2014-12-07 16:17:00.232726	\N
8926	45	19	2014-12-07 16:17:00.234821	\N
8927	45	19	2014-12-07 16:17:00.236935	\N
8928	45	15	2014-12-07 16:17:00.239149	\N
8929	45	15	2014-12-07 16:17:00.241827	\N
8930	45	19	2014-12-07 16:17:00.244087	\N
8931	45	7	2014-12-07 16:17:00.246326	\N
8932	45	2	2014-12-07 16:17:00.248496	\N
8933	45	9	2014-12-07 16:17:00.250643	\N
8934	46	2	2014-12-07 16:17:00.310954	\N
8935	46	2	2014-12-07 16:17:00.313649	\N
8936	46	2	2014-12-07 16:17:00.31592	\N
8937	46	2	2014-12-07 16:17:00.31815	\N
8938	46	5	2014-12-07 16:17:00.320599	\N
8939	46	5	2014-12-07 16:17:00.32358	\N
8940	46	8	2014-12-07 16:17:00.327492	\N
8941	46	2	2014-12-07 16:17:00.330912	\N
8942	46	2	2014-12-07 16:17:00.333892	\N
8943	46	2	2014-12-07 16:17:00.33617	\N
8944	46	18	2014-12-07 16:17:00.338243	\N
8945	46	7	2014-12-07 16:17:00.340968	\N
8946	46	5	2014-12-07 16:17:00.343167	\N
8947	46	8	2014-12-07 16:17:00.345309	\N
8948	46	8	2014-12-07 16:17:00.347294	\N
8949	46	8	2014-12-07 16:17:00.349365	\N
8950	46	8	2014-12-07 16:17:00.351541	\N
8951	46	8	2014-12-07 16:17:00.353952	\N
8952	46	8	2014-12-07 16:17:00.356207	\N
8953	46	18	2014-12-07 16:17:00.358505	\N
8954	46	18	2014-12-07 16:17:00.361147	\N
8955	46	18	2014-12-07 16:17:00.363297	\N
8956	46	18	2014-12-07 16:17:00.365464	\N
8957	46	18	2014-12-07 16:17:00.367653	\N
8958	46	18	2014-12-07 16:17:00.369978	\N
8959	46	18	2014-12-07 16:17:00.372278	\N
8960	46	4	2014-12-07 16:17:00.374649	\N
8961	46	4	2014-12-07 16:17:00.376776	\N
8962	46	4	2014-12-07 16:17:00.378901	\N
8963	46	4	2014-12-07 16:17:00.382226	\N
8964	46	4	2014-12-07 16:17:00.385111	\N
8965	46	4	2014-12-07 16:17:00.387435	\N
8966	46	4	2014-12-07 16:17:00.390237	\N
8967	46	4	2014-12-07 16:17:00.392612	\N
8968	46	11	2014-12-07 16:17:00.394804	\N
8969	46	11	2014-12-07 16:17:00.397168	\N
8970	46	11	2014-12-07 16:17:00.399251	\N
8971	46	19	2014-12-07 16:17:00.401357	\N
8972	46	19	2014-12-07 16:17:00.403398	\N
8973	46	15	2014-12-07 16:17:00.405384	\N
8974	46	15	2014-12-07 16:17:00.407646	\N
8975	46	19	2014-12-07 16:17:00.409864	\N
8976	46	7	2014-12-07 16:17:00.412029	\N
8977	46	2	2014-12-07 16:17:00.414181	\N
8978	46	9	2014-12-07 16:17:00.416277	\N
8979	46	9	2014-12-07 16:17:00.418363	\N
8980	47	2	2014-12-07 16:17:01.262557	\N
8981	47	2	2014-12-07 16:17:01.265371	\N
8982	47	2	2014-12-07 16:17:01.267699	\N
8983	47	2	2014-12-07 16:17:01.270735	\N
8984	47	5	2014-12-07 16:17:01.27331	\N
8985	47	5	2014-12-07 16:17:01.275922	\N
8986	47	8	2014-12-07 16:17:01.278861	\N
8987	47	2	2014-12-07 16:17:01.281234	\N
8988	47	2	2014-12-07 16:17:01.283545	\N
8989	47	2	2014-12-07 16:17:01.286112	\N
8990	47	18	2014-12-07 16:17:01.288582	\N
8991	47	7	2014-12-07 16:17:01.291937	\N
8992	47	5	2014-12-07 16:17:01.297239	\N
8993	47	8	2014-12-07 16:17:01.30035	\N
8994	47	8	2014-12-07 16:17:01.302942	\N
8995	47	8	2014-12-07 16:17:01.305453	\N
8996	47	8	2014-12-07 16:17:01.308351	\N
8997	47	8	2014-12-07 16:17:01.311211	\N
8998	47	8	2014-12-07 16:17:01.316264	\N
8999	47	18	2014-12-07 16:17:01.319047	\N
9000	47	18	2014-12-07 16:17:01.322548	\N
9001	47	18	2014-12-07 16:17:01.32523	\N
9002	47	18	2014-12-07 16:17:01.328	\N
9003	47	18	2014-12-07 16:17:01.330515	\N
9004	47	18	2014-12-07 16:17:01.333088	\N
9005	47	18	2014-12-07 16:17:01.335558	\N
9006	47	4	2014-12-07 16:17:01.337807	\N
9007	47	4	2014-12-07 16:17:01.339949	\N
9008	47	4	2014-12-07 16:17:01.341973	\N
9009	47	4	2014-12-07 16:17:01.344128	\N
9010	47	4	2014-12-07 16:17:01.346377	\N
9011	47	4	2014-12-07 16:17:01.348449	\N
9012	47	4	2014-12-07 16:17:01.351134	\N
9013	47	4	2014-12-07 16:17:01.353472	\N
9014	47	11	2014-12-07 16:17:01.355746	\N
9015	47	11	2014-12-07 16:17:01.357922	\N
9016	47	11	2014-12-07 16:17:01.360387	\N
9017	47	19	2014-12-07 16:17:01.362653	\N
9018	47	19	2014-12-07 16:17:01.364754	\N
9019	47	15	2014-12-07 16:17:01.366911	\N
9020	47	15	2014-12-07 16:17:01.368928	\N
9021	47	19	2014-12-07 16:17:01.371123	\N
9022	47	7	2014-12-07 16:17:01.373266	\N
9023	47	2	2014-12-07 16:17:01.375467	\N
9024	47	9	2014-12-07 16:17:01.377656	\N
9025	47	9	2014-12-07 16:17:01.380307	\N
9026	47	9	2014-12-07 16:17:01.382889	\N
9027	48	2	2014-12-07 16:17:02.707827	\N
9028	48	2	2014-12-07 16:17:02.710501	\N
9029	48	2	2014-12-07 16:17:02.712736	\N
9030	48	2	2014-12-07 16:17:02.715115	\N
9031	48	5	2014-12-07 16:17:02.717209	\N
9032	48	5	2014-12-07 16:17:02.719188	\N
9033	48	8	2014-12-07 16:17:02.721266	\N
9034	48	2	2014-12-07 16:17:02.723204	\N
9035	48	2	2014-12-07 16:17:02.728014	\N
9036	48	2	2014-12-07 16:17:02.732489	\N
9037	48	18	2014-12-07 16:17:02.735434	\N
9038	48	7	2014-12-07 16:17:02.737644	\N
9039	48	5	2014-12-07 16:17:02.739747	\N
9040	48	8	2014-12-07 16:17:02.741785	\N
9041	48	8	2014-12-07 16:17:02.743735	\N
9042	48	8	2014-12-07 16:17:02.745712	\N
9043	48	8	2014-12-07 16:17:02.748304	\N
9044	48	8	2014-12-07 16:17:02.751169	\N
9045	48	8	2014-12-07 16:17:02.753489	\N
9046	48	18	2014-12-07 16:17:02.755527	\N
9047	48	18	2014-12-07 16:17:02.757567	\N
9048	48	18	2014-12-07 16:17:02.759542	\N
9049	48	18	2014-12-07 16:17:02.761728	\N
9050	48	18	2014-12-07 16:17:02.764593	\N
9051	48	18	2014-12-07 16:17:02.766961	\N
9052	48	18	2014-12-07 16:17:02.769041	\N
9053	48	4	2014-12-07 16:17:02.771147	\N
9054	48	4	2014-12-07 16:17:02.773348	\N
9055	48	4	2014-12-07 16:17:02.775581	\N
9056	48	4	2014-12-07 16:17:02.77763	\N
9057	48	4	2014-12-07 16:17:02.779684	\N
9058	48	4	2014-12-07 16:17:02.781772	\N
9059	48	4	2014-12-07 16:17:02.783812	\N
9060	48	4	2014-12-07 16:17:02.785941	\N
9061	48	11	2014-12-07 16:17:02.788008	\N
9062	48	11	2014-12-07 16:17:02.789957	\N
9063	48	11	2014-12-07 16:17:02.791992	\N
9064	48	19	2014-12-07 16:17:02.794586	\N
9065	48	19	2014-12-07 16:17:02.796889	\N
9066	48	15	2014-12-07 16:17:02.79904	\N
9067	48	15	2014-12-07 16:17:02.80111	\N
9068	48	19	2014-12-07 16:17:02.803842	\N
9069	48	7	2014-12-07 16:17:02.805994	\N
9070	48	2	2014-12-07 16:17:02.808037	\N
9071	48	9	2014-12-07 16:17:02.810102	\N
9072	48	9	2014-12-07 16:17:02.81209	\N
9073	48	9	2014-12-07 16:17:02.814167	\N
9074	48	9	2014-12-07 16:17:02.816734	\N
9075	49	2	2014-12-07 16:17:02.990357	\N
9076	49	2	2014-12-07 16:17:02.993004	\N
9077	49	2	2014-12-07 16:17:02.995212	\N
9078	49	2	2014-12-07 16:17:02.997699	\N
9079	49	5	2014-12-07 16:17:03.000416	\N
9080	49	5	2014-12-07 16:17:03.003125	\N
9081	49	8	2014-12-07 16:17:03.005567	\N
9082	49	2	2014-12-07 16:17:03.007698	\N
9083	49	2	2014-12-07 16:17:03.009731	\N
9084	49	2	2014-12-07 16:17:03.011772	\N
9085	49	18	2014-12-07 16:17:03.013863	\N
9086	49	7	2014-12-07 16:17:03.016171	\N
9087	49	5	2014-12-07 16:17:03.018318	\N
9088	49	8	2014-12-07 16:17:03.020407	\N
9089	49	8	2014-12-07 16:17:03.022486	\N
9090	49	8	2014-12-07 16:17:03.024512	\N
9091	49	8	2014-12-07 16:17:03.026776	\N
9092	49	8	2014-12-07 16:17:03.028859	\N
9093	49	8	2014-12-07 16:17:03.030836	\N
9094	49	18	2014-12-07 16:17:03.033434	\N
9095	49	18	2014-12-07 16:17:03.035935	\N
9096	49	18	2014-12-07 16:17:03.038056	\N
9097	49	18	2014-12-07 16:17:03.040206	\N
9098	49	18	2014-12-07 16:17:03.042323	\N
9099	49	18	2014-12-07 16:17:03.044343	\N
9100	49	18	2014-12-07 16:17:03.046359	\N
9101	49	4	2014-12-07 16:17:03.048676	\N
9102	49	4	2014-12-07 16:17:03.051057	\N
9103	49	4	2014-12-07 16:17:03.053133	\N
9104	49	4	2014-12-07 16:17:03.055218	\N
9105	49	4	2014-12-07 16:17:03.057211	\N
9106	49	4	2014-12-07 16:17:03.059104	\N
9107	49	4	2014-12-07 16:17:03.061064	\N
9108	49	4	2014-12-07 16:17:03.063488	\N
9109	49	11	2014-12-07 16:17:03.066094	\N
9110	49	11	2014-12-07 16:17:03.068283	\N
9111	49	11	2014-12-07 16:17:03.070434	\N
9112	49	19	2014-12-07 16:17:03.072623	\N
9113	49	19	2014-12-07 16:17:03.074751	\N
9114	49	15	2014-12-07 16:17:03.076812	\N
9115	49	15	2014-12-07 16:17:03.078813	\N
9116	49	19	2014-12-07 16:17:03.08084	\N
9117	49	7	2014-12-07 16:17:03.082914	\N
9118	49	2	2014-12-07 16:17:03.084933	\N
9119	49	9	2014-12-07 16:17:03.08709	\N
9120	49	9	2014-12-07 16:17:03.089123	\N
9121	49	9	2014-12-07 16:17:03.090994	\N
9122	49	9	2014-12-07 16:17:03.093373	\N
9123	49	9	2014-12-07 16:17:03.095827	\N
9124	50	2	2014-12-07 16:17:03.277309	\N
9125	50	2	2014-12-07 16:17:03.281296	\N
9126	50	2	2014-12-07 16:17:03.283986	\N
9127	50	2	2014-12-07 16:17:03.286532	\N
9128	50	5	2014-12-07 16:17:03.28882	\N
9129	50	5	2014-12-07 16:17:03.292297	\N
9130	50	8	2014-12-07 16:17:03.294863	\N
9131	50	2	2014-12-07 16:17:03.297112	\N
9132	50	2	2014-12-07 16:17:03.299183	\N
9133	50	2	2014-12-07 16:17:03.302805	\N
9134	50	18	2014-12-07 16:17:03.305343	\N
9135	50	7	2014-12-07 16:17:03.307505	\N
9136	50	5	2014-12-07 16:17:03.310846	\N
9137	50	8	2014-12-07 16:17:03.313419	\N
9138	50	8	2014-12-07 16:17:03.315371	\N
9139	50	8	2014-12-07 16:17:03.318161	\N
9140	50	8	2014-12-07 16:17:03.355943	\N
9141	50	8	2014-12-07 16:17:03.358064	\N
9142	50	8	2014-12-07 16:17:03.36142	\N
9143	50	18	2014-12-07 16:17:03.36612	\N
9144	50	18	2014-12-07 16:17:03.368778	\N
9145	50	18	2014-12-07 16:17:03.372409	\N
9146	50	18	2014-12-07 16:17:03.37465	\N
9147	50	18	2014-12-07 16:17:03.376727	\N
9148	50	18	2014-12-07 16:17:03.378806	\N
9149	50	18	2014-12-07 16:17:03.382446	\N
9150	50	4	2014-12-07 16:17:03.386946	\N
9151	50	4	2014-12-07 16:17:03.390305	\N
9152	50	4	2014-12-07 16:17:03.393211	\N
9153	50	4	2014-12-07 16:17:03.395726	\N
9154	50	4	2014-12-07 16:17:03.398005	\N
9155	50	4	2014-12-07 16:17:03.402069	\N
9156	50	4	2014-12-07 16:17:03.404443	\N
9157	50	4	2014-12-07 16:17:03.406443	\N
9158	50	11	2014-12-07 16:17:03.408485	\N
9159	50	11	2014-12-07 16:17:03.412043	\N
9160	50	11	2014-12-07 16:17:03.41432	\N
9161	50	19	2014-12-07 16:17:03.416655	\N
9162	50	19	2014-12-07 16:17:03.420502	\N
9163	50	15	2014-12-07 16:17:03.422707	\N
9164	50	15	2014-12-07 16:17:03.425406	\N
9165	50	19	2014-12-07 16:17:03.427587	\N
9166	50	7	2014-12-07 16:17:03.431316	\N
9167	50	2	2014-12-07 16:17:03.434271	\N
9168	50	9	2014-12-07 16:17:03.436508	\N
9169	50	9	2014-12-07 16:17:03.440215	\N
9170	50	9	2014-12-07 16:17:03.442817	\N
9171	50	9	2014-12-07 16:17:03.445141	\N
9172	50	9	2014-12-07 16:17:03.447196	\N
9173	50	3	2014-12-07 16:17:03.451606	\N
9174	51	2	2014-12-07 16:17:03.548475	\N
9175	51	2	2014-12-07 16:17:03.551341	\N
9176	51	2	2014-12-07 16:17:03.553692	\N
9177	51	2	2014-12-07 16:17:03.555679	\N
9178	51	5	2014-12-07 16:17:03.557815	\N
9179	51	5	2014-12-07 16:17:03.560222	\N
9180	51	8	2014-12-07 16:17:03.562374	\N
9181	51	2	2014-12-07 16:17:03.564502	\N
9182	51	2	2014-12-07 16:17:03.566809	\N
9183	51	2	2014-12-07 16:17:03.569212	\N
9184	51	18	2014-12-07 16:17:03.57123	\N
9185	51	7	2014-12-07 16:17:03.573437	\N
9186	51	5	2014-12-07 16:17:03.57621	\N
9187	51	8	2014-12-07 16:17:03.578763	\N
9188	51	8	2014-12-07 16:17:03.580974	\N
9189	51	8	2014-12-07 16:17:03.583094	\N
9190	51	8	2014-12-07 16:17:03.585499	\N
9191	51	8	2014-12-07 16:17:03.587826	\N
9192	51	8	2014-12-07 16:17:03.590191	\N
9193	51	18	2014-12-07 16:17:03.592272	\N
9194	51	18	2014-12-07 16:17:03.594333	\N
9195	51	18	2014-12-07 16:17:03.596564	\N
9196	51	18	2014-12-07 16:17:03.598831	\N
9197	51	18	2014-12-07 16:17:03.600961	\N
9198	51	18	2014-12-07 16:17:03.603207	\N
9199	51	18	2014-12-07 16:17:03.605847	\N
9200	51	4	2014-12-07 16:17:03.608461	\N
9201	51	4	2014-12-07 16:17:03.610673	\N
9202	51	4	2014-12-07 16:17:03.612743	\N
9203	51	4	2014-12-07 16:17:03.614828	\N
9204	51	4	2014-12-07 16:17:03.617294	\N
9205	51	4	2014-12-07 16:17:03.619687	\N
9206	51	4	2014-12-07 16:17:03.621823	\N
9207	51	4	2014-12-07 16:17:03.623802	\N
9208	51	11	2014-12-07 16:17:03.625867	\N
9209	51	11	2014-12-07 16:17:03.628191	\N
9210	51	11	2014-12-07 16:17:03.630423	\N
9211	51	19	2014-12-07 16:17:03.63248	\N
9212	51	19	2014-12-07 16:17:03.634926	\N
9213	51	15	2014-12-07 16:17:03.637588	\N
9214	51	15	2014-12-07 16:17:03.639875	\N
9215	51	19	2014-12-07 16:17:03.642108	\N
9216	51	7	2014-12-07 16:17:03.64426	\N
9217	51	2	2014-12-07 16:17:03.646303	\N
9218	51	9	2014-12-07 16:17:03.648518	\N
9219	51	9	2014-12-07 16:17:03.651136	\N
9220	51	9	2014-12-07 16:17:03.653388	\N
9221	51	9	2014-12-07 16:17:03.655394	\N
9222	51	9	2014-12-07 16:17:03.657603	\N
9223	51	3	2014-12-07 16:17:03.659711	\N
9224	51	21	2014-12-07 16:17:03.662141	\N
9225	52	2	2014-12-07 16:17:03.726793	\N
9226	52	2	2014-12-07 16:17:03.729524	\N
9227	52	2	2014-12-07 16:17:03.731577	\N
9228	52	2	2014-12-07 16:17:03.73365	\N
9229	52	5	2014-12-07 16:17:03.736621	\N
9230	52	5	2014-12-07 16:17:03.739928	\N
9231	52	8	2014-12-07 16:17:03.742264	\N
9232	52	2	2014-12-07 16:17:03.744332	\N
9233	52	2	2014-12-07 16:17:03.747679	\N
9234	52	2	2014-12-07 16:17:03.751054	\N
9235	52	18	2014-12-07 16:17:03.753668	\N
9236	52	7	2014-12-07 16:17:03.756482	\N
9237	52	5	2014-12-07 16:17:03.75931	\N
9238	52	8	2014-12-07 16:17:03.76148	\N
9239	52	8	2014-12-07 16:17:03.763516	\N
9240	52	8	2014-12-07 16:17:03.765596	\N
9241	52	8	2014-12-07 16:17:03.768746	\N
9242	52	8	2014-12-07 16:17:03.771594	\N
9243	52	8	2014-12-07 16:17:03.773687	\N
9244	52	18	2014-12-07 16:17:03.775651	\N
9245	52	18	2014-12-07 16:17:03.778682	\N
9246	52	18	2014-12-07 16:17:03.780946	\N
9247	52	18	2014-12-07 16:17:03.783092	\N
9248	52	18	2014-12-07 16:17:03.787417	\N
9249	52	18	2014-12-07 16:17:03.789928	\N
9250	52	18	2014-12-07 16:17:03.792115	\N
9251	52	4	2014-12-07 16:17:03.794231	\N
9252	52	4	2014-12-07 16:17:03.797078	\N
9253	52	4	2014-12-07 16:17:03.799376	\N
9254	52	4	2014-12-07 16:17:03.801857	\N
9255	52	4	2014-12-07 16:17:03.804016	\N
9256	52	4	2014-12-07 16:17:03.807544	\N
9257	52	4	2014-12-07 16:17:03.81025	\N
9258	52	4	2014-12-07 16:17:03.812644	\N
9259	52	11	2014-12-07 16:17:03.814862	\N
9260	52	11	2014-12-07 16:17:03.817594	\N
9261	52	11	2014-12-07 16:17:03.820996	\N
9262	52	19	2014-12-07 16:17:03.82301	\N
9263	52	19	2014-12-07 16:17:03.825088	\N
9264	52	15	2014-12-07 16:17:03.827457	\N
9265	52	15	2014-12-07 16:17:03.829649	\N
9266	52	19	2014-12-07 16:17:03.831671	\N
9267	52	7	2014-12-07 16:17:03.833725	\N
9268	52	2	2014-12-07 16:17:03.83648	\N
9269	52	9	2014-12-07 16:17:03.838751	\N
9270	52	9	2014-12-07 16:17:03.840801	\N
9271	52	9	2014-12-07 16:17:03.842932	\N
9272	52	9	2014-12-07 16:17:03.845154	\N
9273	52	9	2014-12-07 16:17:03.848094	\N
9274	52	3	2014-12-07 16:17:03.850458	\N
9275	52	21	2014-12-07 16:17:03.852903	\N
9276	52	8	2014-12-07 16:17:03.855068	\N
9277	53	2	2014-12-07 16:17:03.922289	\N
9278	53	2	2014-12-07 16:17:03.926315	\N
9279	53	2	2014-12-07 16:17:03.929174	\N
9280	53	2	2014-12-07 16:17:03.933478	\N
9281	53	5	2014-12-07 16:17:03.93823	\N
9282	53	5	2014-12-07 16:17:03.94102	\N
9283	53	8	2014-12-07 16:17:03.945766	\N
9284	53	2	2014-12-07 16:17:03.948034	\N
9285	53	2	2014-12-07 16:17:03.95034	\N
9286	53	2	2014-12-07 16:17:03.953144	\N
9287	53	18	2014-12-07 16:17:03.955621	\N
9288	53	7	2014-12-07 16:17:03.957849	\N
9289	53	5	2014-12-07 16:17:03.959794	\N
9290	53	8	2014-12-07 16:17:03.961837	\N
9291	53	8	2014-12-07 16:17:03.963909	\N
9292	53	8	2014-12-07 16:17:03.966431	\N
9293	53	8	2014-12-07 16:17:03.96933	\N
9294	53	8	2014-12-07 16:17:03.97163	\N
9295	53	8	2014-12-07 16:17:03.973807	\N
9296	53	18	2014-12-07 16:17:03.977244	\N
9297	53	18	2014-12-07 16:17:03.980197	\N
9298	53	18	2014-12-07 16:17:03.982467	\N
9299	53	18	2014-12-07 16:17:03.985278	\N
9300	53	18	2014-12-07 16:17:03.988669	\N
9301	53	18	2014-12-07 16:17:03.991015	\N
9302	53	18	2014-12-07 16:17:03.993066	\N
9303	53	4	2014-12-07 16:17:03.995641	\N
9304	53	4	2014-12-07 16:17:03.998385	\N
9305	53	4	2014-12-07 16:17:04.001168	\N
9306	53	4	2014-12-07 16:17:04.004049	\N
9307	53	4	2014-12-07 16:17:04.006671	\N
9308	53	4	2014-12-07 16:17:04.008976	\N
9309	53	4	2014-12-07 16:17:04.011147	\N
9310	53	4	2014-12-07 16:17:04.013173	\N
9311	53	11	2014-12-07 16:17:04.015335	\N
9312	53	11	2014-12-07 16:17:04.017612	\N
9313	53	11	2014-12-07 16:17:04.020095	\N
9314	53	19	2014-12-07 16:17:04.022221	\N
9315	53	19	2014-12-07 16:17:04.024891	\N
9316	53	15	2014-12-07 16:17:04.028205	\N
9317	53	15	2014-12-07 16:17:04.031039	\N
9318	53	19	2014-12-07 16:17:04.033451	\N
9319	53	7	2014-12-07 16:17:04.03675	\N
9320	53	2	2014-12-07 16:17:04.039519	\N
9321	53	9	2014-12-07 16:17:04.041843	\N
9322	53	9	2014-12-07 16:17:04.044079	\N
9323	53	9	2014-12-07 16:17:04.046364	\N
9324	53	9	2014-12-07 16:17:04.048666	\N
9325	53	9	2014-12-07 16:17:04.050775	\N
9326	53	3	2014-12-07 16:17:04.05387	\N
9327	53	21	2014-12-07 16:17:04.057172	\N
9328	53	8	2014-12-07 16:17:04.059634	\N
9329	53	13	2014-12-07 16:17:04.061871	\N
9330	54	2	2014-12-07 16:17:04.528525	\N
9331	54	2	2014-12-07 16:17:04.531432	\N
9332	54	2	2014-12-07 16:17:04.533767	\N
9333	54	2	2014-12-07 16:17:04.536224	\N
9334	54	5	2014-12-07 16:17:04.53925	\N
9335	54	5	2014-12-07 16:17:04.541667	\N
9336	54	8	2014-12-07 16:17:04.543901	\N
9337	54	2	2014-12-07 16:17:04.546069	\N
9338	54	2	2014-12-07 16:17:04.548194	\N
9339	54	2	2014-12-07 16:17:04.550418	\N
9340	54	18	2014-12-07 16:17:04.552682	\N
9341	54	7	2014-12-07 16:17:04.555177	\N
9342	54	5	2014-12-07 16:17:04.557403	\N
9343	54	8	2014-12-07 16:17:04.559606	\N
9344	54	8	2014-12-07 16:17:04.561886	\N
9345	54	8	2014-12-07 16:17:04.564133	\N
9346	54	8	2014-12-07 16:17:04.566378	\N
9347	54	8	2014-12-07 16:17:04.569184	\N
9348	54	8	2014-12-07 16:17:04.571668	\N
9349	54	18	2014-12-07 16:17:04.574011	\N
9350	54	18	2014-12-07 16:17:04.576352	\N
9351	54	18	2014-12-07 16:17:04.578669	\N
9352	54	18	2014-12-07 16:17:04.581085	\N
9353	54	18	2014-12-07 16:17:04.583173	\N
9354	54	18	2014-12-07 16:17:04.585263	\N
9355	54	18	2014-12-07 16:17:04.587699	\N
9356	54	4	2014-12-07 16:17:04.590308	\N
9357	54	4	2014-12-07 16:17:04.592567	\N
9358	54	4	2014-12-07 16:17:04.594769	\N
9359	54	4	2014-12-07 16:17:04.597167	\N
9360	54	4	2014-12-07 16:17:04.600035	\N
9361	54	4	2014-12-07 16:17:04.602419	\N
9362	54	4	2014-12-07 16:17:04.604912	\N
9363	54	4	2014-12-07 16:17:04.607173	\N
9364	54	11	2014-12-07 16:17:04.60947	\N
9365	54	11	2014-12-07 16:17:04.611593	\N
9366	54	11	2014-12-07 16:17:04.613742	\N
9367	54	19	2014-12-07 16:17:04.615956	\N
9368	54	19	2014-12-07 16:17:04.618474	\N
9369	54	15	2014-12-07 16:17:04.620984	\N
9370	54	15	2014-12-07 16:17:04.623251	\N
9371	54	19	2014-12-07 16:17:04.625424	\N
9372	54	7	2014-12-07 16:17:04.628406	\N
9373	54	2	2014-12-07 16:17:04.631523	\N
9374	54	9	2014-12-07 16:17:04.63369	\N
9375	54	9	2014-12-07 16:17:04.636084	\N
9376	54	9	2014-12-07 16:17:04.639503	\N
9377	54	9	2014-12-07 16:17:04.642021	\N
9378	54	9	2014-12-07 16:17:04.644235	\N
9379	54	3	2014-12-07 16:17:04.646358	\N
9380	54	21	2014-12-07 16:17:04.648633	\N
9381	54	8	2014-12-07 16:17:04.650943	\N
9382	54	13	2014-12-07 16:17:04.653076	\N
9383	54	8	2014-12-07 16:17:04.655537	\N
9384	55	2	2014-12-07 16:17:04.813025	\N
9385	55	2	2014-12-07 16:17:04.815607	\N
9386	55	2	2014-12-07 16:17:04.817959	\N
9387	55	2	2014-12-07 16:17:04.820449	\N
9388	55	5	2014-12-07 16:17:04.822732	\N
9389	55	5	2014-12-07 16:17:04.824954	\N
9390	55	8	2014-12-07 16:17:04.827152	\N
9391	55	2	2014-12-07 16:17:04.829568	\N
9392	55	2	2014-12-07 16:17:04.831632	\N
9393	55	2	2014-12-07 16:17:04.833841	\N
9394	55	18	2014-12-07 16:17:04.836181	\N
9395	55	7	2014-12-07 16:17:04.839546	\N
9396	55	5	2014-12-07 16:17:04.84217	\N
9397	55	8	2014-12-07 16:17:04.844322	\N
9398	55	8	2014-12-07 16:17:04.846576	\N
9399	55	8	2014-12-07 16:17:04.848908	\N
9400	55	8	2014-12-07 16:17:04.851442	\N
9401	55	8	2014-12-07 16:17:04.853658	\N
9402	55	8	2014-12-07 16:17:04.855916	\N
9403	55	18	2014-12-07 16:17:04.858517	\N
9404	55	18	2014-12-07 16:17:04.860752	\N
9405	55	18	2014-12-07 16:17:04.863059	\N
9406	55	18	2014-12-07 16:17:04.865409	\N
9407	55	18	2014-12-07 16:17:04.868264	\N
9408	55	18	2014-12-07 16:17:04.872049	\N
9409	55	18	2014-12-07 16:17:04.874631	\N
9410	55	4	2014-12-07 16:17:04.876897	\N
9411	55	4	2014-12-07 16:17:04.879222	\N
9412	55	4	2014-12-07 16:17:04.881474	\N
9413	55	4	2014-12-07 16:17:04.883736	\N
9414	55	4	2014-12-07 16:17:04.885857	\N
9415	55	4	2014-12-07 16:17:04.889505	\N
9416	55	4	2014-12-07 16:17:04.891768	\N
9417	55	4	2014-12-07 16:17:04.893908	\N
9418	55	11	2014-12-07 16:17:04.896137	\N
9419	55	11	2014-12-07 16:17:04.89985	\N
9420	55	11	2014-12-07 16:17:04.902691	\N
9421	55	19	2014-12-07 16:17:04.905011	\N
9422	55	19	2014-12-07 16:17:04.908985	\N
9423	55	15	2014-12-07 16:17:04.911447	\N
9424	55	15	2014-12-07 16:17:04.913656	\N
9425	55	19	2014-12-07 16:17:04.915771	\N
9426	55	7	2014-12-07 16:17:04.91932	\N
9427	55	2	2014-12-07 16:17:04.921908	\N
9428	55	9	2014-12-07 16:17:04.924723	\N
9429	55	9	2014-12-07 16:17:04.928561	\N
9430	55	9	2014-12-07 16:17:04.931299	\N
9431	55	9	2014-12-07 16:17:04.933551	\N
9432	55	9	2014-12-07 16:17:04.935608	\N
9433	55	3	2014-12-07 16:17:04.938776	\N
9434	55	21	2014-12-07 16:17:04.941785	\N
9435	55	8	2014-12-07 16:17:04.94389	\N
9436	55	13	2014-12-07 16:17:04.946456	\N
9437	55	8	2014-12-07 16:17:04.949447	\N
9438	55	2	2014-12-07 16:17:04.951685	\N
9439	56	2	2014-12-07 16:17:05.276144	\N
9440	56	2	2014-12-07 16:17:05.278934	\N
9441	56	2	2014-12-07 16:17:05.281244	\N
9442	56	2	2014-12-07 16:17:05.283423	\N
9443	56	5	2014-12-07 16:17:05.285763	\N
9444	56	5	2014-12-07 16:17:05.288622	\N
9445	56	8	2014-12-07 16:17:05.291161	\N
9446	56	2	2014-12-07 16:17:05.293652	\N
9447	56	2	2014-12-07 16:17:05.295738	\N
9448	56	2	2014-12-07 16:17:05.29789	\N
9449	56	18	2014-12-07 16:17:05.303086	\N
9450	56	7	2014-12-07 16:17:05.307396	\N
9451	56	5	2014-12-07 16:17:05.309778	\N
9452	56	8	2014-12-07 16:17:05.311938	\N
9453	56	8	2014-12-07 16:17:05.314141	\N
9454	56	8	2014-12-07 16:17:05.316388	\N
9455	56	8	2014-12-07 16:17:05.319296	\N
9456	56	8	2014-12-07 16:17:05.32189	\N
9457	56	8	2014-12-07 16:17:05.324983	\N
9458	56	18	2014-12-07 16:17:05.327081	\N
9459	56	18	2014-12-07 16:17:05.329087	\N
9460	56	18	2014-12-07 16:17:05.331026	\N
9461	56	18	2014-12-07 16:17:05.333139	\N
9462	56	18	2014-12-07 16:17:05.335203	\N
9463	56	18	2014-12-07 16:17:05.337461	\N
9464	56	18	2014-12-07 16:17:05.339638	\N
9465	56	4	2014-12-07 16:17:05.342173	\N
9466	56	4	2014-12-07 16:17:05.344688	\N
9467	56	4	2014-12-07 16:17:05.346855	\N
9468	56	4	2014-12-07 16:17:05.350091	\N
9469	56	4	2014-12-07 16:17:05.353035	\N
9470	56	4	2014-12-07 16:17:05.35546	\N
9471	56	4	2014-12-07 16:17:05.357854	\N
9472	56	4	2014-12-07 16:17:05.359936	\N
9473	56	11	2014-12-07 16:17:05.362135	\N
9474	56	11	2014-12-07 16:17:05.364515	\N
9475	56	11	2014-12-07 16:17:05.366615	\N
9476	56	19	2014-12-07 16:17:05.368626	\N
9477	56	19	2014-12-07 16:17:05.370777	\N
9478	56	15	2014-12-07 16:17:05.373145	\N
9479	56	15	2014-12-07 16:17:05.375322	\N
9480	56	19	2014-12-07 16:17:05.377519	\N
9481	56	7	2014-12-07 16:17:05.380317	\N
9482	56	2	2014-12-07 16:17:05.382842	\N
9483	56	9	2014-12-07 16:17:05.385133	\N
9484	56	9	2014-12-07 16:17:05.387089	\N
9485	56	9	2014-12-07 16:17:05.389182	\N
9486	56	9	2014-12-07 16:17:05.391872	\N
9487	56	9	2014-12-07 16:17:05.39417	\N
9488	56	3	2014-12-07 16:17:05.39625	\N
9489	56	21	2014-12-07 16:17:05.398313	\N
9490	56	8	2014-12-07 16:17:05.400492	\N
9491	56	13	2014-12-07 16:17:05.402777	\N
9492	56	8	2014-12-07 16:17:05.404959	\N
9493	56	2	2014-12-07 16:17:05.407158	\N
9494	56	18	2014-12-07 16:17:05.409835	\N
9495	57	2	2014-12-07 16:17:05.483847	\N
9496	57	2	2014-12-07 16:17:05.486362	\N
9497	57	2	2014-12-07 16:17:05.488703	\N
9498	57	2	2014-12-07 16:17:05.491643	\N
9499	57	5	2014-12-07 16:17:05.49391	\N
9500	57	5	2014-12-07 16:17:05.496042	\N
9501	57	8	2014-12-07 16:17:05.498195	\N
9502	57	2	2014-12-07 16:17:05.501089	\N
9503	57	2	2014-12-07 16:17:05.503322	\N
9504	57	2	2014-12-07 16:17:05.505428	\N
9505	57	18	2014-12-07 16:17:05.507826	\N
9506	57	7	2014-12-07 16:17:05.51039	\N
9507	57	5	2014-12-07 16:17:05.512894	\N
9508	57	8	2014-12-07 16:17:05.515001	\N
9509	57	8	2014-12-07 16:17:05.517105	\N
9510	57	8	2014-12-07 16:17:05.519036	\N
9511	57	8	2014-12-07 16:17:05.521277	\N
9512	57	8	2014-12-07 16:17:05.523908	\N
9513	57	8	2014-12-07 16:17:05.526172	\N
9514	57	18	2014-12-07 16:17:05.528515	\N
9515	57	18	2014-12-07 16:17:05.53132	\N
9516	57	18	2014-12-07 16:17:05.533743	\N
9517	57	18	2014-12-07 16:17:05.536181	\N
9518	57	18	2014-12-07 16:17:05.538427	\N
9519	57	18	2014-12-07 16:17:05.54127	\N
9520	57	18	2014-12-07 16:17:05.543829	\N
9521	57	4	2014-12-07 16:17:05.546055	\N
9522	57	4	2014-12-07 16:17:05.548123	\N
9523	57	4	2014-12-07 16:17:05.550347	\N
9524	57	4	2014-12-07 16:17:05.552594	\N
9525	57	4	2014-12-07 16:17:05.554685	\N
9526	57	4	2014-12-07 16:17:05.557003	\N
9527	57	4	2014-12-07 16:17:05.559688	\N
9528	57	4	2014-12-07 16:17:05.56213	\N
9529	57	11	2014-12-07 16:17:05.564243	\N
9530	57	11	2014-12-07 16:17:05.566297	\N
9531	57	11	2014-12-07 16:17:05.568343	\N
9532	57	19	2014-12-07 16:17:05.570597	\N
9533	57	19	2014-12-07 16:17:05.572822	\N
9534	57	15	2014-12-07 16:17:05.575129	\N
9535	57	15	2014-12-07 16:17:05.577417	\N
9536	57	19	2014-12-07 16:17:05.57988	\N
9537	57	7	2014-12-07 16:17:05.582318	\N
9538	57	2	2014-12-07 16:17:05.584557	\N
9539	57	9	2014-12-07 16:17:05.586815	\N
9540	57	9	2014-12-07 16:17:05.589627	\N
9541	57	9	2014-12-07 16:17:05.592201	\N
9542	57	9	2014-12-07 16:17:05.594551	\N
9543	57	9	2014-12-07 16:17:05.596836	\N
9544	57	3	2014-12-07 16:17:05.598918	\N
9545	57	21	2014-12-07 16:17:05.601174	\N
9546	57	8	2014-12-07 16:17:05.603189	\N
9547	57	13	2014-12-07 16:17:05.6053	\N
9548	57	8	2014-12-07 16:17:05.607432	\N
9549	57	2	2014-12-07 16:17:05.60983	\N
9550	57	18	2014-12-07 16:17:05.61216	\N
9551	57	16	2014-12-07 16:17:05.614242	\N
9552	58	2	2014-12-07 16:17:05.742621	\N
9553	58	2	2014-12-07 16:17:05.747129	\N
9554	58	2	2014-12-07 16:17:05.750199	\N
9555	58	2	2014-12-07 16:17:05.752529	\N
9556	58	5	2014-12-07 16:17:05.754845	\N
9557	58	5	2014-12-07 16:17:05.756957	\N
9558	58	8	2014-12-07 16:17:05.759825	\N
9559	58	2	2014-12-07 16:17:05.76223	\N
9560	58	2	2014-12-07 16:17:05.764461	\N
9561	58	2	2014-12-07 16:17:05.766651	\N
9562	58	18	2014-12-07 16:17:05.769477	\N
9563	58	7	2014-12-07 16:17:05.772106	\N
9564	58	5	2014-12-07 16:17:05.774581	\N
9565	58	8	2014-12-07 16:17:05.776883	\N
9566	58	8	2014-12-07 16:17:05.779146	\N
9567	58	8	2014-12-07 16:17:05.781336	\N
9568	58	8	2014-12-07 16:17:05.783459	\N
9569	58	8	2014-12-07 16:17:05.785637	\N
9570	58	8	2014-12-07 16:17:05.788053	\N
9571	58	18	2014-12-07 16:17:05.790367	\N
9572	58	18	2014-12-07 16:17:05.792703	\N
9573	58	18	2014-12-07 16:17:05.795016	\N
9574	58	18	2014-12-07 16:17:05.797266	\N
9575	58	18	2014-12-07 16:17:05.800365	\N
9576	58	18	2014-12-07 16:17:05.805066	\N
9577	58	18	2014-12-07 16:17:05.807144	\N
9578	58	4	2014-12-07 16:17:05.80925	\N
9579	58	4	2014-12-07 16:17:05.811222	\N
9580	58	4	2014-12-07 16:17:05.813215	\N
9581	58	4	2014-12-07 16:17:05.815256	\N
9582	58	4	2014-12-07 16:17:05.817228	\N
9583	58	4	2014-12-07 16:17:05.819173	\N
9584	58	4	2014-12-07 16:17:05.821246	\N
9585	58	4	2014-12-07 16:17:05.823253	\N
9586	58	11	2014-12-07 16:17:05.825591	\N
9587	58	11	2014-12-07 16:17:05.828285	\N
9588	58	11	2014-12-07 16:17:05.830732	\N
9589	58	19	2014-12-07 16:17:05.832938	\N
9590	58	19	2014-12-07 16:17:05.835252	\N
9591	58	15	2014-12-07 16:17:05.837436	\N
9592	58	15	2014-12-07 16:17:05.839421	\N
9593	58	19	2014-12-07 16:17:05.841741	\N
9594	58	7	2014-12-07 16:17:05.844092	\N
9595	58	2	2014-12-07 16:17:05.846185	\N
9596	58	9	2014-12-07 16:17:05.848305	\N
9597	58	9	2014-12-07 16:17:05.850307	\N
9598	58	9	2014-12-07 16:17:05.852518	\N
9599	58	9	2014-12-07 16:17:05.85472	\N
9600	58	9	2014-12-07 16:17:05.856885	\N
9601	58	3	2014-12-07 16:17:05.859625	\N
9602	58	21	2014-12-07 16:17:05.862046	\N
9603	58	8	2014-12-07 16:17:05.864382	\N
9604	58	13	2014-12-07 16:17:05.866538	\N
9605	58	8	2014-12-07 16:17:05.868589	\N
9606	58	2	2014-12-07 16:17:05.870633	\N
9607	58	18	2014-12-07 16:17:05.872616	\N
9608	58	16	2014-12-07 16:17:05.874856	\N
9609	58	16	2014-12-07 16:17:05.877017	\N
9610	59	2	2014-12-07 16:17:05.948553	\N
9611	59	2	2014-12-07 16:17:05.951575	\N
9612	59	2	2014-12-07 16:17:05.954024	\N
9613	59	2	2014-12-07 16:17:05.95631	\N
9614	59	5	2014-12-07 16:17:05.95891	\N
9615	59	5	2014-12-07 16:17:05.961351	\N
9616	59	8	2014-12-07 16:17:05.96349	\N
9617	59	2	2014-12-07 16:17:05.965669	\N
9618	59	2	2014-12-07 16:17:05.967766	\N
9619	59	2	2014-12-07 16:17:05.969882	\N
9620	59	18	2014-12-07 16:17:05.971956	\N
9621	59	7	2014-12-07 16:17:05.97408	\N
9622	59	5	2014-12-07 16:17:05.976374	\N
9623	59	8	2014-12-07 16:17:05.979126	\N
9624	59	8	2014-12-07 16:17:05.981679	\N
9625	59	8	2014-12-07 16:17:05.984024	\N
9626	59	8	2014-12-07 16:17:05.986184	\N
9627	59	8	2014-12-07 16:17:05.98857	\N
9628	59	8	2014-12-07 16:17:05.990646	\N
9629	59	18	2014-12-07 16:17:05.993025	\N
9630	59	18	2014-12-07 16:17:05.995186	\N
9631	59	18	2014-12-07 16:17:05.997281	\N
9632	59	18	2014-12-07 16:17:05.999629	\N
9633	59	18	2014-12-07 16:17:06.00241	\N
9634	59	18	2014-12-07 16:17:06.004509	\N
9635	59	18	2014-12-07 16:17:06.006655	\N
9636	59	4	2014-12-07 16:17:06.009488	\N
9637	59	4	2014-12-07 16:17:06.011949	\N
9638	59	4	2014-12-07 16:17:06.014194	\N
9639	59	4	2014-12-07 16:17:06.016492	\N
9640	59	4	2014-12-07 16:17:06.018588	\N
9641	59	4	2014-12-07 16:17:06.020778	\N
9642	59	4	2014-12-07 16:17:06.02299	\N
9643	59	4	2014-12-07 16:17:06.025256	\N
9644	59	11	2014-12-07 16:17:06.0274	\N
9645	59	11	2014-12-07 16:17:06.029508	\N
9646	59	11	2014-12-07 16:17:06.031486	\N
9647	59	19	2014-12-07 16:17:06.033723	\N
9648	59	19	2014-12-07 16:17:06.035943	\N
9649	59	15	2014-12-07 16:17:06.038087	\N
9650	59	15	2014-12-07 16:17:06.040661	\N
9651	59	19	2014-12-07 16:17:06.043251	\N
9652	59	7	2014-12-07 16:17:06.045543	\N
9653	59	2	2014-12-07 16:17:06.047577	\N
9654	59	9	2014-12-07 16:17:06.049579	\N
9655	59	9	2014-12-07 16:17:06.05164	\N
9656	59	9	2014-12-07 16:17:06.0538	\N
9657	59	9	2014-12-07 16:17:06.055945	\N
9658	59	9	2014-12-07 16:17:06.058026	\N
9659	59	3	2014-12-07 16:17:06.06017	\N
9660	59	21	2014-12-07 16:17:06.062371	\N
9661	59	8	2014-12-07 16:17:06.064453	\N
9662	59	13	2014-12-07 16:17:06.06654	\N
9663	59	8	2014-12-07 16:17:06.069544	\N
9664	59	2	2014-12-07 16:17:06.072726	\N
9665	59	18	2014-12-07 16:17:06.074948	\N
9666	59	16	2014-12-07 16:17:06.077294	\N
9667	59	16	2014-12-07 16:17:06.079501	\N
9668	59	15	2014-12-07 16:17:06.081551	\N
9669	60	2	2014-12-07 16:17:06.260756	\N
9670	60	2	2014-12-07 16:17:06.267218	\N
9671	60	2	2014-12-07 16:17:06.272645	\N
9672	60	2	2014-12-07 16:17:06.276122	\N
9673	60	5	2014-12-07 16:17:06.281368	\N
9674	60	5	2014-12-07 16:17:06.283839	\N
9675	60	8	2014-12-07 16:17:06.287143	\N
9676	60	2	2014-12-07 16:17:06.290112	\N
9677	60	2	2014-12-07 16:17:06.292475	\N
9678	60	2	2014-12-07 16:17:06.294967	\N
9679	60	18	2014-12-07 16:17:06.297889	\N
9680	60	7	2014-12-07 16:17:06.300402	\N
9681	60	5	2014-12-07 16:17:06.302722	\N
9682	60	8	2014-12-07 16:17:06.305579	\N
9683	60	8	2014-12-07 16:17:06.307891	\N
9684	60	8	2014-12-07 16:17:06.310647	\N
9685	60	8	2014-12-07 16:17:06.31311	\N
9686	60	8	2014-12-07 16:17:06.315205	\N
9687	60	8	2014-12-07 16:17:06.317397	\N
9688	60	18	2014-12-07 16:17:06.319487	\N
9689	60	18	2014-12-07 16:17:06.321539	\N
9690	60	18	2014-12-07 16:17:06.323725	\N
9691	60	18	2014-12-07 16:17:06.326216	\N
9692	60	18	2014-12-07 16:17:06.328492	\N
9693	60	18	2014-12-07 16:17:06.330622	\N
9694	60	18	2014-12-07 16:17:06.332702	\N
9695	60	4	2014-12-07 16:17:06.335072	\N
9696	60	4	2014-12-07 16:17:06.337271	\N
9697	60	4	2014-12-07 16:17:06.33965	\N
9698	60	4	2014-12-07 16:17:06.342073	\N
9699	60	4	2014-12-07 16:17:06.344731	\N
9700	60	4	2014-12-07 16:17:06.346938	\N
9701	60	4	2014-12-07 16:17:06.34904	\N
9702	60	4	2014-12-07 16:17:06.351168	\N
9703	60	11	2014-12-07 16:17:06.353566	\N
9704	60	11	2014-12-07 16:17:06.355587	\N
9705	60	11	2014-12-07 16:17:06.357645	\N
9706	60	19	2014-12-07 16:17:06.359701	\N
9707	60	19	2014-12-07 16:17:06.361829	\N
9708	60	15	2014-12-07 16:17:06.363732	\N
9709	60	15	2014-12-07 16:17:06.365756	\N
9710	60	19	2014-12-07 16:17:06.367731	\N
9711	60	7	2014-12-07 16:17:06.370418	\N
9712	60	2	2014-12-07 16:17:06.372849	\N
9713	60	9	2014-12-07 16:17:06.374967	\N
9714	60	9	2014-12-07 16:17:06.377388	\N
9715	60	9	2014-12-07 16:17:06.379729	\N
9716	60	9	2014-12-07 16:17:06.381843	\N
9717	60	9	2014-12-07 16:17:06.383807	\N
9718	60	3	2014-12-07 16:17:06.385874	\N
9719	60	21	2014-12-07 16:17:06.387864	\N
9720	60	8	2014-12-07 16:17:06.389909	\N
9721	60	13	2014-12-07 16:17:06.391997	\N
9722	60	8	2014-12-07 16:17:06.394147	\N
9723	60	2	2014-12-07 16:17:06.396349	\N
9724	60	18	2014-12-07 16:17:06.398456	\N
9725	60	16	2014-12-07 16:17:06.401096	\N
9726	60	16	2014-12-07 16:17:06.403389	\N
9727	60	15	2014-12-07 16:17:06.405542	\N
9728	60	15	2014-12-07 16:17:06.40757	\N
9729	61	2	2014-12-07 16:17:06.649112	\N
9730	61	2	2014-12-07 16:17:06.652088	\N
9731	61	2	2014-12-07 16:17:06.654416	\N
9732	61	2	2014-12-07 16:17:06.656715	\N
9733	61	5	2014-12-07 16:17:06.658871	\N
9734	61	5	2014-12-07 16:17:06.66124	\N
9735	61	8	2014-12-07 16:17:06.663683	\N
9736	61	2	2014-12-07 16:17:06.666008	\N
9737	61	2	2014-12-07 16:17:06.668115	\N
9738	61	2	2014-12-07 16:17:06.670654	\N
9739	61	18	2014-12-07 16:17:06.673037	\N
9740	61	7	2014-12-07 16:17:06.675161	\N
9741	61	5	2014-12-07 16:17:06.677342	\N
9742	61	8	2014-12-07 16:17:06.679804	\N
9743	61	8	2014-12-07 16:17:06.682037	\N
9744	61	8	2014-12-07 16:17:06.684096	\N
9745	61	8	2014-12-07 16:17:06.686134	\N
9746	61	8	2014-12-07 16:17:06.688179	\N
9747	61	8	2014-12-07 16:17:06.690349	\N
9748	61	18	2014-12-07 16:17:06.692464	\N
9749	61	18	2014-12-07 16:17:06.694752	\N
9750	61	18	2014-12-07 16:17:06.696943	\N
9751	61	18	2014-12-07 16:17:06.699171	\N
9752	61	18	2014-12-07 16:17:06.701772	\N
9753	61	18	2014-12-07 16:17:06.704037	\N
9754	61	18	2014-12-07 16:17:06.706099	\N
9755	61	4	2014-12-07 16:17:06.708332	\N
9756	61	4	2014-12-07 16:17:06.710543	\N
9757	61	4	2014-12-07 16:17:06.712962	\N
9758	61	4	2014-12-07 16:17:06.715122	\N
9759	61	4	2014-12-07 16:17:06.717149	\N
9760	61	4	2014-12-07 16:17:06.719288	\N
9761	61	4	2014-12-07 16:17:06.721365	\N
9762	61	4	2014-12-07 16:17:06.723481	\N
9763	61	11	2014-12-07 16:17:06.725612	\N
9764	61	11	2014-12-07 16:17:06.72788	\N
9765	61	11	2014-12-07 16:17:06.730641	\N
9766	61	19	2014-12-07 16:17:06.733023	\N
9767	61	19	2014-12-07 16:17:06.735172	\N
9768	61	15	2014-12-07 16:17:06.737262	\N
9769	61	15	2014-12-07 16:17:06.739476	\N
9770	61	19	2014-12-07 16:17:06.741643	\N
9771	61	7	2014-12-07 16:17:06.74393	\N
9772	61	2	2014-12-07 16:17:06.746331	\N
9773	61	9	2014-12-07 16:17:06.749015	\N
9774	61	9	2014-12-07 16:17:06.751238	\N
9775	61	9	2014-12-07 16:17:06.753366	\N
9776	61	9	2014-12-07 16:17:06.755728	\N
9777	61	9	2014-12-07 16:17:06.757901	\N
9778	61	3	2014-12-07 16:17:06.760967	\N
9779	61	21	2014-12-07 16:17:06.764009	\N
9780	61	8	2014-12-07 16:17:06.766465	\N
9781	61	13	2014-12-07 16:17:06.768784	\N
9782	61	8	2014-12-07 16:17:06.771061	\N
9783	61	2	2014-12-07 16:17:06.773189	\N
9784	61	18	2014-12-07 16:17:06.775437	\N
9785	61	16	2014-12-07 16:17:06.777653	\N
9786	61	16	2014-12-07 16:17:06.77993	\N
9787	61	15	2014-12-07 16:17:06.78201	\N
9788	61	15	2014-12-07 16:17:06.784058	\N
9789	61	7	2014-12-07 16:17:06.786006	\N
9790	62	2	2014-12-07 16:17:06.859604	\N
9791	62	2	2014-12-07 16:17:06.862461	\N
9792	62	2	2014-12-07 16:17:06.864827	\N
9793	62	2	2014-12-07 16:17:06.867034	\N
9794	62	5	2014-12-07 16:17:06.869108	\N
9795	62	5	2014-12-07 16:17:06.871099	\N
9796	62	8	2014-12-07 16:17:06.873338	\N
9797	62	2	2014-12-07 16:17:06.875554	\N
9798	62	2	2014-12-07 16:17:06.877773	\N
9799	62	2	2014-12-07 16:17:06.88073	\N
9800	62	18	2014-12-07 16:17:06.883029	\N
9801	62	7	2014-12-07 16:17:06.885078	\N
9802	62	5	2014-12-07 16:17:06.887093	\N
9803	62	8	2014-12-07 16:17:06.889202	\N
9804	62	8	2014-12-07 16:17:06.891183	\N
9805	62	8	2014-12-07 16:17:06.893187	\N
9806	62	8	2014-12-07 16:17:06.89523	\N
9807	62	8	2014-12-07 16:17:06.8974	\N
9808	62	8	2014-12-07 16:17:06.899581	\N
9809	62	18	2014-12-07 16:17:06.901654	\N
9810	62	18	2014-12-07 16:17:06.903687	\N
9811	62	18	2014-12-07 16:17:06.905616	\N
9812	62	18	2014-12-07 16:17:06.907706	\N
9813	62	18	2014-12-07 16:17:06.910253	\N
9814	62	18	2014-12-07 16:17:06.912748	\N
9815	62	18	2014-12-07 16:17:06.915031	\N
9816	62	4	2014-12-07 16:17:06.917086	\N
9817	62	4	2014-12-07 16:17:06.91911	\N
9818	62	4	2014-12-07 16:17:06.921078	\N
9819	62	4	2014-12-07 16:17:06.923109	\N
9820	62	4	2014-12-07 16:17:06.925119	\N
9821	62	4	2014-12-07 16:17:06.927005	\N
9822	62	4	2014-12-07 16:17:06.929405	\N
9823	62	4	2014-12-07 16:17:06.931575	\N
9824	62	11	2014-12-07 16:17:06.933614	\N
9825	62	11	2014-12-07 16:17:06.935643	\N
9826	62	11	2014-12-07 16:17:06.937678	\N
9827	62	19	2014-12-07 16:17:06.940322	\N
9828	62	19	2014-12-07 16:17:06.942916	\N
9829	62	15	2014-12-07 16:17:06.945446	\N
9830	62	15	2014-12-07 16:17:06.947754	\N
9831	62	19	2014-12-07 16:17:06.949864	\N
9832	62	7	2014-12-07 16:17:06.951934	\N
9833	62	2	2014-12-07 16:17:06.953956	\N
9834	62	9	2014-12-07 16:17:06.955954	\N
9835	62	9	2014-12-07 16:17:06.95801	\N
9836	62	9	2014-12-07 16:17:06.960072	\N
9837	62	9	2014-12-07 16:17:06.962828	\N
9838	62	9	2014-12-07 16:17:06.96513	\N
9839	62	3	2014-12-07 16:17:06.967072	\N
9840	62	21	2014-12-07 16:17:06.969545	\N
9841	62	8	2014-12-07 16:17:06.972071	\N
9842	62	13	2014-12-07 16:17:06.974157	\N
9843	62	8	2014-12-07 16:17:06.976136	\N
9844	62	2	2014-12-07 16:17:06.978234	\N
9845	62	18	2014-12-07 16:17:06.980599	\N
9846	62	16	2014-12-07 16:17:06.983005	\N
9847	62	16	2014-12-07 16:17:06.985181	\N
9848	62	15	2014-12-07 16:17:06.987178	\N
9849	62	15	2014-12-07 16:17:06.989323	\N
9850	62	7	2014-12-07 16:17:06.991253	\N
9851	62	7	2014-12-07 16:17:06.993265	\N
9852	63	2	2014-12-07 16:17:07.255993	\N
9853	63	2	2014-12-07 16:17:07.258688	\N
9854	63	2	2014-12-07 16:17:07.260982	\N
9855	63	2	2014-12-07 16:17:07.263376	\N
9856	63	5	2014-12-07 16:17:07.265517	\N
9857	63	5	2014-12-07 16:17:07.267582	\N
9858	63	8	2014-12-07 16:17:07.27021	\N
9859	63	2	2014-12-07 16:17:07.272529	\N
9860	63	2	2014-12-07 16:17:07.274587	\N
9861	63	2	2014-12-07 16:17:07.276622	\N
9862	63	18	2014-12-07 16:17:07.278683	\N
9863	63	7	2014-12-07 16:17:07.280876	\N
9864	63	5	2014-12-07 16:17:07.282953	\N
9865	63	8	2014-12-07 16:17:07.284973	\N
9866	63	8	2014-12-07 16:17:07.287077	\N
9867	63	8	2014-12-07 16:17:07.289326	\N
9868	63	8	2014-12-07 16:17:07.291414	\N
9869	63	8	2014-12-07 16:17:07.293398	\N
9870	63	8	2014-12-07 16:17:07.29528	\N
9871	63	18	2014-12-07 16:17:07.297384	\N
9872	63	18	2014-12-07 16:17:07.300119	\N
9873	63	18	2014-12-07 16:17:07.30262	\N
9874	63	18	2014-12-07 16:17:07.30486	\N
9875	63	18	2014-12-07 16:17:07.306968	\N
9876	63	18	2014-12-07 16:17:07.309014	\N
9877	63	18	2014-12-07 16:17:07.311096	\N
9878	63	4	2014-12-07 16:17:07.313316	\N
9879	63	4	2014-12-07 16:17:07.315312	\N
9880	63	4	2014-12-07 16:17:07.317271	\N
9881	63	4	2014-12-07 16:17:07.3192	\N
9882	63	4	2014-12-07 16:17:07.321159	\N
9883	63	4	2014-12-07 16:17:07.323252	\N
9884	63	4	2014-12-07 16:17:07.325299	\N
9885	63	4	2014-12-07 16:17:07.327203	\N
9886	63	11	2014-12-07 16:17:07.329817	\N
9887	63	11	2014-12-07 16:17:07.332236	\N
9888	63	11	2014-12-07 16:17:07.334331	\N
9889	63	19	2014-12-07 16:17:07.336457	\N
9890	63	19	2014-12-07 16:17:07.338446	\N
9891	63	15	2014-12-07 16:17:07.34074	\N
9892	63	15	2014-12-07 16:17:07.342998	\N
9893	63	19	2014-12-07 16:17:07.345086	\N
9894	63	7	2014-12-07 16:17:07.347356	\N
9895	63	2	2014-12-07 16:17:07.349581	\N
9896	63	9	2014-12-07 16:17:07.351599	\N
9897	63	9	2014-12-07 16:17:07.353546	\N
9898	63	9	2014-12-07 16:17:07.355428	\N
9899	63	9	2014-12-07 16:17:07.357423	\N
9900	63	9	2014-12-07 16:17:07.359855	\N
9901	63	3	2014-12-07 16:17:07.362207	\N
9902	63	21	2014-12-07 16:17:07.364614	\N
9903	63	8	2014-12-07 16:17:07.366782	\N
9904	63	13	2014-12-07 16:17:07.368855	\N
9905	63	8	2014-12-07 16:17:07.370917	\N
9906	63	2	2014-12-07 16:17:07.372923	\N
9907	63	18	2014-12-07 16:17:07.374907	\N
9908	63	16	2014-12-07 16:17:07.37687	\N
9909	63	16	2014-12-07 16:17:07.378972	\N
9910	63	15	2014-12-07 16:17:07.381247	\N
9911	63	15	2014-12-07 16:17:07.383229	\N
9912	63	7	2014-12-07 16:17:07.385257	\N
9913	63	7	2014-12-07 16:17:07.387476	\N
9914	63	7	2014-12-07 16:17:07.390207	\N
9915	64	2	2014-12-07 16:17:07.625931	\N
9916	64	2	2014-12-07 16:17:07.628521	\N
9917	64	2	2014-12-07 16:17:07.631868	\N
9918	64	2	2014-12-07 16:17:07.634701	\N
9919	64	5	2014-12-07 16:17:07.636829	\N
9920	64	5	2014-12-07 16:17:07.638866	\N
9921	64	8	2014-12-07 16:17:07.640942	\N
9922	64	2	2014-12-07 16:17:07.642962	\N
9923	64	2	2014-12-07 16:17:07.645005	\N
9924	64	2	2014-12-07 16:17:07.647255	\N
9925	64	18	2014-12-07 16:17:07.649459	\N
9926	64	7	2014-12-07 16:17:07.651675	\N
9927	64	5	2014-12-07 16:17:07.653822	\N
9928	64	8	2014-12-07 16:17:07.655829	\N
9929	64	8	2014-12-07 16:17:07.657848	\N
9930	64	8	2014-12-07 16:17:07.659878	\N
9931	64	8	2014-12-07 16:17:07.662494	\N
9932	64	8	2014-12-07 16:17:07.665003	\N
9933	64	8	2014-12-07 16:17:07.667254	\N
9934	64	18	2014-12-07 16:17:07.669338	\N
9935	64	18	2014-12-07 16:17:07.67137	\N
9936	64	18	2014-12-07 16:17:07.67342	\N
9937	64	18	2014-12-07 16:17:07.675392	\N
9938	64	18	2014-12-07 16:17:07.677395	\N
9939	64	18	2014-12-07 16:17:07.679542	\N
9940	64	18	2014-12-07 16:17:07.682071	\N
9941	64	4	2014-12-07 16:17:07.684849	\N
9942	64	4	2014-12-07 16:17:07.687071	\N
9943	64	4	2014-12-07 16:17:07.689295	\N
9944	64	4	2014-12-07 16:17:07.691879	\N
9945	64	4	2014-12-07 16:17:07.69445	\N
9946	64	4	2014-12-07 16:17:07.696559	\N
9947	64	4	2014-12-07 16:17:07.698891	\N
9948	64	4	2014-12-07 16:17:07.701065	\N
9949	64	11	2014-12-07 16:17:07.703108	\N
9950	64	11	2014-12-07 16:17:07.705413	\N
9951	64	11	2014-12-07 16:17:07.707848	\N
9952	64	19	2014-12-07 16:17:07.71219	\N
9953	64	19	2014-12-07 16:17:07.715486	\N
9954	64	15	2014-12-07 16:17:07.717858	\N
9955	64	15	2014-12-07 16:17:07.720077	\N
9956	64	19	2014-12-07 16:17:07.722677	\N
9957	64	7	2014-12-07 16:17:07.725263	\N
9958	64	2	2014-12-07 16:17:07.72742	\N
9959	64	9	2014-12-07 16:17:07.729529	\N
9960	64	9	2014-12-07 16:17:07.731805	\N
9961	64	9	2014-12-07 16:17:07.733955	\N
9962	64	9	2014-12-07 16:17:07.736064	\N
9963	64	9	2014-12-07 16:17:07.738372	\N
9964	64	3	2014-12-07 16:17:07.740442	\N
9965	64	21	2014-12-07 16:17:07.742444	\N
9966	64	8	2014-12-07 16:17:07.744644	\N
9967	64	13	2014-12-07 16:17:07.748738	\N
9968	64	8	2014-12-07 16:17:07.751363	\N
9969	64	2	2014-12-07 16:17:07.75371	\N
9970	64	18	2014-12-07 16:17:07.755828	\N
9971	64	16	2014-12-07 16:17:07.757953	\N
9972	64	16	2014-12-07 16:17:07.760067	\N
9973	64	15	2014-12-07 16:17:07.762089	\N
9974	64	15	2014-12-07 16:17:07.764263	\N
9975	64	7	2014-12-07 16:17:07.766649	\N
9976	64	7	2014-12-07 16:17:07.768708	\N
9977	64	7	2014-12-07 16:17:07.770836	\N
9978	64	7	2014-12-07 16:17:07.77289	\N
9979	65	2	2014-12-07 16:17:08.046245	\N
9980	65	2	2014-12-07 16:17:08.049315	\N
9981	65	2	2014-12-07 16:17:08.052789	\N
9982	65	2	2014-12-07 16:17:08.055426	\N
9983	65	5	2014-12-07 16:17:08.057769	\N
9984	65	5	2014-12-07 16:17:08.059941	\N
9985	65	8	2014-12-07 16:17:08.062088	\N
9986	65	2	2014-12-07 16:17:08.064087	\N
9987	65	2	2014-12-07 16:17:08.066268	\N
9988	65	2	2014-12-07 16:17:08.068432	\N
9989	65	18	2014-12-07 16:17:08.070488	\N
9990	65	7	2014-12-07 16:17:08.072642	\N
9991	65	5	2014-12-07 16:17:08.07468	\N
9992	65	8	2014-12-07 16:17:08.076653	\N
9993	65	8	2014-12-07 16:17:08.078685	\N
9994	65	8	2014-12-07 16:17:08.0807	\N
9995	65	8	2014-12-07 16:17:08.083389	\N
9996	65	8	2014-12-07 16:17:08.08569	\N
9997	65	8	2014-12-07 16:17:08.087698	\N
9998	65	18	2014-12-07 16:17:08.090042	\N
9999	65	18	2014-12-07 16:17:08.092267	\N
10000	65	18	2014-12-07 16:17:08.094415	\N
10001	65	18	2014-12-07 16:17:08.096449	\N
10002	65	18	2014-12-07 16:17:08.098461	\N
10003	65	18	2014-12-07 16:17:08.100524	\N
10004	65	18	2014-12-07 16:17:08.102651	\N
10005	65	4	2014-12-07 16:17:08.104752	\N
10006	65	4	2014-12-07 16:17:08.106784	\N
10007	65	4	2014-12-07 16:17:08.108792	\N
10008	65	4	2014-12-07 16:17:08.110808	\N
10009	65	4	2014-12-07 16:17:08.113329	\N
10010	65	4	2014-12-07 16:17:08.116021	\N
10011	65	4	2014-12-07 16:17:08.118313	\N
10012	65	4	2014-12-07 16:17:08.120446	\N
10013	65	11	2014-12-07 16:17:08.122524	\N
10014	65	11	2014-12-07 16:17:08.124566	\N
10015	65	11	2014-12-07 16:17:08.126592	\N
10016	65	19	2014-12-07 16:17:08.128656	\N
10017	65	19	2014-12-07 16:17:08.130842	\N
10018	65	15	2014-12-07 16:17:08.133108	\N
10019	65	15	2014-12-07 16:17:08.135116	\N
10020	65	19	2014-12-07 16:17:08.137071	\N
10021	65	7	2014-12-07 16:17:08.139	\N
10022	65	2	2014-12-07 16:17:08.141198	\N
10023	65	9	2014-12-07 16:17:08.143886	\N
10024	65	9	2014-12-07 16:17:08.146047	\N
10025	65	9	2014-12-07 16:17:08.148053	\N
10026	65	9	2014-12-07 16:17:08.150368	\N
10027	65	9	2014-12-07 16:17:08.152978	\N
10028	65	3	2014-12-07 16:17:08.155088	\N
10029	65	21	2014-12-07 16:17:08.157106	\N
10030	65	8	2014-12-07 16:17:08.15897	\N
10031	65	13	2014-12-07 16:17:08.16093	\N
10032	65	8	2014-12-07 16:17:08.162921	\N
10033	65	2	2014-12-07 16:17:08.165018	\N
10034	65	18	2014-12-07 16:17:08.167142	\N
10035	65	16	2014-12-07 16:17:08.169175	\N
10036	65	16	2014-12-07 16:17:08.171125	\N
10037	65	15	2014-12-07 16:17:08.173691	\N
10038	65	15	2014-12-07 16:17:08.175864	\N
10039	65	7	2014-12-07 16:17:08.177942	\N
10040	65	7	2014-12-07 16:17:08.18023	\N
10041	65	7	2014-12-07 16:17:08.182447	\N
10042	65	7	2014-12-07 16:17:08.184699	\N
10043	65	7	2014-12-07 16:17:08.186776	\N
10044	66	2	2014-12-07 16:17:08.327556	\N
10045	66	2	2014-12-07 16:17:08.331245	\N
10046	66	2	2014-12-07 16:17:08.334058	\N
10047	66	2	2014-12-07 16:17:08.336301	\N
10048	66	5	2014-12-07 16:17:08.33856	\N
10049	66	5	2014-12-07 16:17:08.340887	\N
10050	66	8	2014-12-07 16:17:08.343333	\N
10051	66	2	2014-12-07 16:17:08.345872	\N
10052	66	2	2014-12-07 16:17:08.348327	\N
10053	66	2	2014-12-07 16:17:08.351145	\N
10054	66	18	2014-12-07 16:17:08.355005	\N
10055	66	7	2014-12-07 16:17:08.358027	\N
10056	66	5	2014-12-07 16:17:08.392934	\N
10057	66	8	2014-12-07 16:17:08.395304	\N
10058	66	8	2014-12-07 16:17:08.397526	\N
10059	66	8	2014-12-07 16:17:08.399578	\N
10060	66	8	2014-12-07 16:17:08.402186	\N
10061	66	8	2014-12-07 16:17:08.404403	\N
10062	66	8	2014-12-07 16:17:08.406471	\N
10063	66	18	2014-12-07 16:17:08.408462	\N
10064	66	18	2014-12-07 16:17:08.410445	\N
10065	66	18	2014-12-07 16:17:08.41244	\N
10066	66	18	2014-12-07 16:17:08.414575	\N
10067	66	18	2014-12-07 16:17:08.417319	\N
10068	66	18	2014-12-07 16:17:08.419567	\N
10069	66	18	2014-12-07 16:17:08.42165	\N
10070	66	4	2014-12-07 16:17:08.423823	\N
10071	66	4	2014-12-07 16:17:08.425902	\N
10072	66	4	2014-12-07 16:17:08.427933	\N
10073	66	4	2014-12-07 16:17:08.429987	\N
10074	66	4	2014-12-07 16:17:08.43208	\N
10075	66	4	2014-12-07 16:17:08.434364	\N
10076	66	4	2014-12-07 16:17:08.436456	\N
10077	66	4	2014-12-07 16:17:08.438562	\N
10078	66	11	2014-12-07 16:17:08.440658	\N
10079	66	11	2014-12-07 16:17:08.443122	\N
10080	66	11	2014-12-07 16:17:08.445326	\N
10081	66	19	2014-12-07 16:17:08.447946	\N
10082	66	19	2014-12-07 16:17:08.450496	\N
10083	66	15	2014-12-07 16:17:08.452693	\N
10084	66	15	2014-12-07 16:17:08.454759	\N
10085	66	19	2014-12-07 16:17:08.456766	\N
10086	66	7	2014-12-07 16:17:08.459536	\N
10087	66	2	2014-12-07 16:17:08.462168	\N
10088	66	9	2014-12-07 16:17:08.464551	\N
10089	66	9	2014-12-07 16:17:08.467003	\N
10090	66	9	2014-12-07 16:17:08.469391	\N
10091	66	9	2014-12-07 16:17:08.471888	\N
10092	66	9	2014-12-07 16:17:08.474251	\N
10093	66	3	2014-12-07 16:17:08.477234	\N
10094	66	21	2014-12-07 16:17:08.479566	\N
10095	66	8	2014-12-07 16:17:08.481641	\N
10096	66	13	2014-12-07 16:17:08.483958	\N
10097	66	8	2014-12-07 16:17:08.486214	\N
10098	66	2	2014-12-07 16:17:08.488362	\N
10099	66	18	2014-12-07 16:17:08.490545	\N
10100	66	16	2014-12-07 16:17:08.492599	\N
10101	66	16	2014-12-07 16:17:08.494914	\N
10102	66	15	2014-12-07 16:17:08.497137	\N
10103	66	15	2014-12-07 16:17:08.499133	\N
10104	66	7	2014-12-07 16:17:08.50122	\N
10105	66	7	2014-12-07 16:17:08.503222	\N
10106	66	7	2014-12-07 16:17:08.505395	\N
10107	66	7	2014-12-07 16:17:08.50823	\N
10108	66	7	2014-12-07 16:17:08.510573	\N
10109	66	7	2014-12-07 16:17:08.512706	\N
10110	67	2	2014-12-07 16:17:08.783291	\N
10111	67	2	2014-12-07 16:17:08.786226	\N
10112	67	2	2014-12-07 16:17:08.78851	\N
10113	67	2	2014-12-07 16:17:08.790786	\N
10114	67	5	2014-12-07 16:17:08.792936	\N
10115	67	5	2014-12-07 16:17:08.795063	\N
10116	67	8	2014-12-07 16:17:08.797172	\N
10117	67	2	2014-12-07 16:17:08.799199	\N
10118	67	2	2014-12-07 16:17:08.801333	\N
10119	67	2	2014-12-07 16:17:08.803684	\N
10120	67	18	2014-12-07 16:17:08.805782	\N
10121	67	7	2014-12-07 16:17:08.808061	\N
10122	67	5	2014-12-07 16:17:08.810896	\N
10123	67	8	2014-12-07 16:17:08.813139	\N
10124	67	8	2014-12-07 16:17:08.815227	\N
10125	67	8	2014-12-07 16:17:08.817333	\N
10126	67	8	2014-12-07 16:17:08.819709	\N
10127	67	8	2014-12-07 16:17:08.821865	\N
10128	67	8	2014-12-07 16:17:08.82379	\N
10129	67	18	2014-12-07 16:17:08.825808	\N
10130	67	18	2014-12-07 16:17:08.827764	\N
10131	67	18	2014-12-07 16:17:08.829787	\N
10132	67	18	2014-12-07 16:17:08.831776	\N
10133	67	18	2014-12-07 16:17:08.833818	\N
10134	67	18	2014-12-07 16:17:08.835937	\N
10135	67	18	2014-12-07 16:17:08.838258	\N
10136	67	4	2014-12-07 16:17:08.840842	\N
10137	67	4	2014-12-07 16:17:08.84316	\N
10138	67	4	2014-12-07 16:17:08.845466	\N
10139	67	4	2014-12-07 16:17:08.847542	\N
10140	67	4	2014-12-07 16:17:08.849635	\N
10141	67	4	2014-12-07 16:17:08.852148	\N
10142	67	4	2014-12-07 16:17:08.854511	\N
10143	67	4	2014-12-07 16:17:08.856746	\N
10144	67	11	2014-12-07 16:17:08.858744	\N
10145	67	11	2014-12-07 16:17:08.860756	\N
10146	67	11	2014-12-07 16:17:08.862776	\N
10147	67	19	2014-12-07 16:17:08.864938	\N
10148	67	19	2014-12-07 16:17:08.866961	\N
10149	67	15	2014-12-07 16:17:08.869432	\N
10150	67	15	2014-12-07 16:17:08.871897	\N
10151	67	19	2014-12-07 16:17:08.874183	\N
10152	67	7	2014-12-07 16:17:08.876413	\N
10153	67	2	2014-12-07 16:17:08.878655	\N
10154	67	9	2014-12-07 16:17:08.881134	\N
10155	67	9	2014-12-07 16:17:08.883239	\N
10156	67	9	2014-12-07 16:17:08.885575	\N
10157	67	9	2014-12-07 16:17:08.887704	\N
10158	67	9	2014-12-07 16:17:08.889791	\N
10159	67	3	2014-12-07 16:17:08.891922	\N
10160	67	21	2014-12-07 16:17:08.893978	\N
10161	67	8	2014-12-07 16:17:08.895949	\N
10162	67	13	2014-12-07 16:17:08.898056	\N
10163	67	8	2014-12-07 16:17:08.900619	\N
10164	67	2	2014-12-07 16:17:08.903091	\N
10165	67	18	2014-12-07 16:17:08.905373	\N
10166	67	16	2014-12-07 16:17:08.907483	\N
10167	67	16	2014-12-07 16:17:08.909892	\N
10168	67	15	2014-12-07 16:17:08.913831	\N
10169	67	15	2014-12-07 16:17:08.917107	\N
10170	67	7	2014-12-07 16:17:08.91979	\N
10171	67	7	2014-12-07 16:17:08.92218	\N
10172	67	7	2014-12-07 16:17:08.92447	\N
10173	67	7	2014-12-07 16:17:08.926655	\N
10174	67	7	2014-12-07 16:17:08.929221	\N
10175	67	7	2014-12-07 16:17:08.931755	\N
10176	67	18	2014-12-07 16:17:08.93414	\N
10177	68	2	2014-12-07 16:17:09.419015	\N
10178	68	2	2014-12-07 16:17:09.422068	\N
10179	68	2	2014-12-07 16:17:09.42433	\N
10180	68	2	2014-12-07 16:17:09.426515	\N
10181	68	5	2014-12-07 16:17:09.428604	\N
10182	68	5	2014-12-07 16:17:09.430833	\N
10183	68	8	2014-12-07 16:17:09.433065	\N
10184	68	2	2014-12-07 16:17:09.435125	\N
10185	68	2	2014-12-07 16:17:09.437321	\N
10186	68	2	2014-12-07 16:17:09.439972	\N
10187	68	18	2014-12-07 16:17:09.442261	\N
10188	68	7	2014-12-07 16:17:09.444299	\N
10189	68	5	2014-12-07 16:17:09.446296	\N
10190	68	8	2014-12-07 16:17:09.448489	\N
10191	68	8	2014-12-07 16:17:09.450581	\N
10192	68	8	2014-12-07 16:17:09.452996	\N
10193	68	8	2014-12-07 16:17:09.455219	\N
10194	68	8	2014-12-07 16:17:09.45726	\N
10195	68	8	2014-12-07 16:17:09.459371	\N
10196	68	18	2014-12-07 16:17:09.461584	\N
10197	68	18	2014-12-07 16:17:09.463876	\N
10198	68	18	2014-12-07 16:17:09.465946	\N
10199	68	18	2014-12-07 16:17:09.46836	\N
10200	68	18	2014-12-07 16:17:09.471481	\N
10201	68	18	2014-12-07 16:17:09.474968	\N
10202	68	18	2014-12-07 16:17:09.477375	\N
10203	68	4	2014-12-07 16:17:09.479493	\N
10204	68	4	2014-12-07 16:17:09.481671	\N
10205	68	4	2014-12-07 16:17:09.483735	\N
10206	68	4	2014-12-07 16:17:09.485797	\N
10207	68	4	2014-12-07 16:17:09.487888	\N
10208	68	4	2014-12-07 16:17:09.490042	\N
10209	68	4	2014-12-07 16:17:09.492215	\N
10210	68	4	2014-12-07 16:17:09.494341	\N
10211	68	11	2014-12-07 16:17:09.496312	\N
10212	68	11	2014-12-07 16:17:09.498714	\N
10213	68	11	2014-12-07 16:17:09.501017	\N
10214	68	19	2014-12-07 16:17:09.503217	\N
10215	68	19	2014-12-07 16:17:09.505337	\N
10216	68	15	2014-12-07 16:17:09.507298	\N
10217	68	15	2014-12-07 16:17:09.50977	\N
10218	68	19	2014-12-07 16:17:09.512319	\N
10219	68	7	2014-12-07 16:17:09.516581	\N
10220	68	2	2014-12-07 16:17:09.519162	\N
10221	68	9	2014-12-07 16:17:09.521995	\N
10222	68	9	2014-12-07 16:17:09.524338	\N
10223	68	9	2014-12-07 16:17:09.526425	\N
10224	68	9	2014-12-07 16:17:09.528919	\N
10225	68	9	2014-12-07 16:17:09.531226	\N
10226	68	3	2014-12-07 16:17:09.533325	\N
10227	68	21	2014-12-07 16:17:09.535244	\N
10228	68	8	2014-12-07 16:17:09.537569	\N
10229	68	13	2014-12-07 16:17:09.539914	\N
10230	68	8	2014-12-07 16:17:09.541965	\N
10231	68	2	2014-12-07 16:17:09.54399	\N
10232	68	18	2014-12-07 16:17:09.54602	\N
10233	68	16	2014-12-07 16:17:09.547982	\N
10234	68	16	2014-12-07 16:17:09.550028	\N
10235	68	15	2014-12-07 16:17:09.552131	\N
10236	68	15	2014-12-07 16:17:09.554358	\N
10237	68	7	2014-12-07 16:17:09.556422	\N
10238	68	7	2014-12-07 16:17:09.558942	\N
10239	68	7	2014-12-07 16:17:09.561226	\N
10240	68	7	2014-12-07 16:17:09.563198	\N
10241	68	7	2014-12-07 16:17:09.565242	\N
10242	68	7	2014-12-07 16:17:09.567144	\N
10243	68	18	2014-12-07 16:17:09.569138	\N
10244	68	2	2014-12-07 16:17:09.571352	\N
10245	69	2	2014-12-07 16:17:09.675475	\N
10246	69	2	2014-12-07 16:17:09.678365	\N
10247	69	2	2014-12-07 16:17:09.681346	\N
10248	69	2	2014-12-07 16:17:09.683561	\N
10249	69	5	2014-12-07 16:17:09.685883	\N
10250	69	5	2014-12-07 16:17:09.688238	\N
10251	69	8	2014-12-07 16:17:09.690578	\N
10252	69	2	2014-12-07 16:17:09.693316	\N
10253	69	2	2014-12-07 16:17:09.695423	\N
10254	69	2	2014-12-07 16:17:09.697482	\N
10255	69	18	2014-12-07 16:17:09.699514	\N
10256	69	7	2014-12-07 16:17:09.70158	\N
10257	69	5	2014-12-07 16:17:09.703664	\N
10258	69	8	2014-12-07 16:17:09.705798	\N
10259	69	8	2014-12-07 16:17:09.707868	\N
10260	69	8	2014-12-07 16:17:09.710379	\N
10261	69	8	2014-12-07 16:17:09.712895	\N
10262	69	8	2014-12-07 16:17:09.715116	\N
10263	69	8	2014-12-07 16:17:09.717173	\N
10264	69	18	2014-12-07 16:17:09.719152	\N
10265	69	18	2014-12-07 16:17:09.72139	\N
10266	69	18	2014-12-07 16:17:09.723462	\N
10267	69	18	2014-12-07 16:17:09.725547	\N
10268	69	18	2014-12-07 16:17:09.72747	\N
10269	69	18	2014-12-07 16:17:09.729451	\N
10270	69	18	2014-12-07 16:17:09.731335	\N
10271	69	4	2014-12-07 16:17:09.733712	\N
10272	69	4	2014-12-07 16:17:09.735853	\N
10273	69	4	2014-12-07 16:17:09.738048	\N
10274	69	4	2014-12-07 16:17:09.740647	\N
10275	69	4	2014-12-07 16:17:09.743274	\N
10276	69	4	2014-12-07 16:17:09.746059	\N
10277	69	4	2014-12-07 16:17:09.748322	\N
10278	69	4	2014-12-07 16:17:09.750383	\N
10279	69	11	2014-12-07 16:17:09.752405	\N
10280	69	11	2014-12-07 16:17:09.754657	\N
10281	69	11	2014-12-07 16:17:09.75698	\N
10282	69	19	2014-12-07 16:17:09.759071	\N
10283	69	19	2014-12-07 16:17:09.761429	\N
10284	69	15	2014-12-07 16:17:09.763748	\N
10285	69	15	2014-12-07 16:17:09.765912	\N
10286	69	19	2014-12-07 16:17:09.767979	\N
10287	69	7	2014-12-07 16:17:09.771402	\N
10288	69	2	2014-12-07 16:17:09.774182	\N
10289	69	9	2014-12-07 16:17:09.776423	\N
10290	69	9	2014-12-07 16:17:09.778635	\N
10291	69	9	2014-12-07 16:17:09.781992	\N
10292	69	9	2014-12-07 16:17:09.784718	\N
10293	69	9	2014-12-07 16:17:09.786917	\N
10294	69	3	2014-12-07 16:17:09.790133	\N
10295	69	21	2014-12-07 16:17:09.793376	\N
10296	69	8	2014-12-07 16:17:09.795442	\N
10297	69	13	2014-12-07 16:17:09.79756	\N
10298	69	8	2014-12-07 16:17:09.800916	\N
10299	69	2	2014-12-07 16:17:09.803642	\N
10300	69	18	2014-12-07 16:17:09.806905	\N
10301	69	16	2014-12-07 16:17:09.811213	\N
10302	69	16	2014-12-07 16:17:09.813804	\N
10303	69	15	2014-12-07 16:17:09.816095	\N
10304	69	15	2014-12-07 16:17:09.818213	\N
10305	69	7	2014-12-07 16:17:09.821095	\N
10306	69	7	2014-12-07 16:17:09.824541	\N
10307	69	7	2014-12-07 16:17:09.826791	\N
10308	69	7	2014-12-07 16:17:09.830778	\N
10309	69	7	2014-12-07 16:17:09.833565	\N
10310	69	7	2014-12-07 16:17:09.835795	\N
10311	69	18	2014-12-07 16:17:09.838025	\N
10312	69	2	2014-12-07 16:17:09.842115	\N
10313	69	7	2014-12-07 16:17:09.844463	\N
10314	70	2	2014-12-07 16:17:10.044679	\N
10315	70	2	2014-12-07 16:17:10.047384	\N
10316	70	2	2014-12-07 16:17:10.049609	\N
10317	70	2	2014-12-07 16:17:10.051573	\N
10318	70	5	2014-12-07 16:17:10.053732	\N
10319	70	5	2014-12-07 16:17:10.056051	\N
10320	70	8	2014-12-07 16:17:10.058484	\N
10321	70	2	2014-12-07 16:17:10.060718	\N
10322	70	2	2014-12-07 16:17:10.062769	\N
10323	70	2	2014-12-07 16:17:10.06497	\N
10324	70	18	2014-12-07 16:17:10.067193	\N
10325	70	7	2014-12-07 16:17:10.070653	\N
10326	70	5	2014-12-07 16:17:10.073919	\N
10327	70	8	2014-12-07 16:17:10.076411	\N
10328	70	8	2014-12-07 16:17:10.080439	\N
10329	70	8	2014-12-07 16:17:10.082887	\N
10330	70	8	2014-12-07 16:17:10.085322	\N
10331	70	8	2014-12-07 16:17:10.088532	\N
10332	70	8	2014-12-07 16:17:10.091725	\N
10333	70	18	2014-12-07 16:17:10.093872	\N
10334	70	18	2014-12-07 16:17:10.095934	\N
10335	70	18	2014-12-07 16:17:10.099338	\N
10336	70	18	2014-12-07 16:17:10.102153	\N
10337	70	18	2014-12-07 16:17:10.104691	\N
10338	70	18	2014-12-07 16:17:10.107482	\N
10339	70	18	2014-12-07 16:17:10.111401	\N
10340	70	4	2014-12-07 16:17:10.114715	\N
10341	70	4	2014-12-07 16:17:10.117737	\N
10342	70	4	2014-12-07 16:17:10.121837	\N
10343	70	4	2014-12-07 16:17:10.124652	\N
10344	70	4	2014-12-07 16:17:10.126762	\N
10345	70	4	2014-12-07 16:17:10.129973	\N
10346	70	4	2014-12-07 16:17:10.13244	\N
10347	70	4	2014-12-07 16:17:10.135137	\N
10348	70	11	2014-12-07 16:17:10.138857	\N
10349	70	11	2014-12-07 16:17:10.141716	\N
10350	70	11	2014-12-07 16:17:10.143821	\N
10351	70	19	2014-12-07 16:17:10.145942	\N
10352	70	19	2014-12-07 16:17:10.149306	\N
10353	70	15	2014-12-07 16:17:10.152052	\N
10354	70	15	2014-12-07 16:17:10.154421	\N
10355	70	19	2014-12-07 16:17:10.157733	\N
10356	70	7	2014-12-07 16:17:10.160722	\N
10357	70	2	2014-12-07 16:17:10.162917	\N
10358	70	9	2014-12-07 16:17:10.164991	\N
10359	70	9	2014-12-07 16:17:10.168489	\N
10360	70	9	2014-12-07 16:17:10.170935	\N
10361	70	9	2014-12-07 16:17:10.173637	\N
10362	70	9	2014-12-07 16:17:10.175825	\N
10363	70	3	2014-12-07 16:17:10.179173	\N
10364	70	21	2014-12-07 16:17:10.18199	\N
10365	70	8	2014-12-07 16:17:10.18414	\N
10366	70	13	2014-12-07 16:17:10.187014	\N
10367	70	8	2014-12-07 16:17:10.192369	\N
10368	70	2	2014-12-07 16:17:10.194578	\N
10369	70	18	2014-12-07 16:17:10.196725	\N
10370	70	16	2014-12-07 16:17:10.198904	\N
10371	70	16	2014-12-07 16:17:10.201034	\N
10372	70	15	2014-12-07 16:17:10.203135	\N
10373	70	15	2014-12-07 16:17:10.205266	\N
10374	70	7	2014-12-07 16:17:10.208327	\N
10375	70	7	2014-12-07 16:17:10.212793	\N
10376	70	7	2014-12-07 16:17:10.214937	\N
10377	70	7	2014-12-07 16:17:10.217322	\N
10378	70	7	2014-12-07 16:17:10.21993	\N
10379	70	7	2014-12-07 16:17:10.222545	\N
10380	70	18	2014-12-07 16:17:10.225162	\N
10381	70	2	2014-12-07 16:17:10.228888	\N
10382	70	7	2014-12-07 16:17:10.231499	\N
10383	70	2	2014-12-07 16:17:10.233729	\N
10384	71	2	2014-12-07 16:17:10.331093	\N
10385	71	2	2014-12-07 16:17:10.333888	\N
10386	71	2	2014-12-07 16:17:10.338612	\N
10387	71	2	2014-12-07 16:17:10.342768	\N
10388	71	5	2014-12-07 16:17:10.345771	\N
10389	71	5	2014-12-07 16:17:10.348141	\N
10390	71	8	2014-12-07 16:17:10.350655	\N
10391	71	2	2014-12-07 16:17:10.352786	\N
10392	71	2	2014-12-07 16:17:10.357363	\N
10393	71	2	2014-12-07 16:17:10.361269	\N
10394	71	18	2014-12-07 16:17:10.364537	\N
10395	71	7	2014-12-07 16:17:10.367701	\N
10396	71	5	2014-12-07 16:17:10.371092	\N
10397	71	8	2014-12-07 16:17:10.376259	\N
10398	71	8	2014-12-07 16:17:10.378609	\N
10399	71	8	2014-12-07 16:17:10.38101	\N
10400	71	8	2014-12-07 16:17:10.384681	\N
10401	71	8	2014-12-07 16:17:10.387085	\N
10402	71	8	2014-12-07 16:17:10.389317	\N
10403	71	18	2014-12-07 16:17:10.392104	\N
10404	71	18	2014-12-07 16:17:10.394472	\N
10405	71	18	2014-12-07 16:17:10.396665	\N
10406	71	18	2014-12-07 16:17:10.398797	\N
10407	71	18	2014-12-07 16:17:10.401471	\N
10408	71	18	2014-12-07 16:17:10.403807	\N
10409	71	18	2014-12-07 16:17:10.406096	\N
10410	71	4	2014-12-07 16:17:10.408407	\N
10411	71	4	2014-12-07 16:17:10.410557	\N
10412	71	4	2014-12-07 16:17:10.412748	\N
10413	71	4	2014-12-07 16:17:10.415056	\N
10414	71	4	2014-12-07 16:17:10.417125	\N
10415	71	4	2014-12-07 16:17:10.419084	\N
10416	71	4	2014-12-07 16:17:10.421124	\N
10417	71	4	2014-12-07 16:17:10.423187	\N
10418	71	11	2014-12-07 16:17:10.425927	\N
10419	71	11	2014-12-07 16:17:10.427987	\N
10420	71	11	2014-12-07 16:17:10.430418	\N
10421	71	19	2014-12-07 16:17:10.432641	\N
10422	71	19	2014-12-07 16:17:10.435094	\N
10423	71	15	2014-12-07 16:17:10.43733	\N
10424	71	15	2014-12-07 16:17:10.43927	\N
10425	71	19	2014-12-07 16:17:10.441681	\N
10426	71	7	2014-12-07 16:17:10.443993	\N
10427	71	2	2014-12-07 16:17:10.44618	\N
10428	71	9	2014-12-07 16:17:10.448302	\N
10429	71	9	2014-12-07 16:17:10.450349	\N
10430	71	9	2014-12-07 16:17:10.452345	\N
10431	71	9	2014-12-07 16:17:10.454512	\N
10432	71	9	2014-12-07 16:17:10.456644	\N
10433	71	3	2014-12-07 16:17:10.459802	\N
10434	71	21	2014-12-07 16:17:10.46305	\N
10435	71	8	2014-12-07 16:17:10.465467	\N
10436	71	13	2014-12-07 16:17:10.467581	\N
10437	71	8	2014-12-07 16:17:10.470409	\N
10438	71	2	2014-12-07 16:17:10.473186	\N
10439	71	18	2014-12-07 16:17:10.476456	\N
10440	71	16	2014-12-07 16:17:10.478842	\N
10441	71	16	2014-12-07 16:17:10.481013	\N
10442	71	15	2014-12-07 16:17:10.483356	\N
10443	71	15	2014-12-07 16:17:10.485583	\N
10444	71	7	2014-12-07 16:17:10.487632	\N
10445	71	7	2014-12-07 16:17:10.490268	\N
10446	71	7	2014-12-07 16:17:10.493022	\N
10447	71	7	2014-12-07 16:17:10.495366	\N
10448	71	7	2014-12-07 16:17:10.497514	\N
10449	71	7	2014-12-07 16:17:10.499562	\N
10450	71	18	2014-12-07 16:17:10.501631	\N
10451	71	2	2014-12-07 16:17:10.503797	\N
10452	71	7	2014-12-07 16:17:10.505986	\N
10453	71	2	2014-12-07 16:17:10.508173	\N
10454	71	7	2014-12-07 16:17:10.510414	\N
10455	72	2	2014-12-07 16:17:10.71947	\N
10456	72	2	2014-12-07 16:17:10.7231	\N
10457	72	2	2014-12-07 16:17:10.727751	\N
10458	72	2	2014-12-07 16:17:10.730415	\N
10459	72	5	2014-12-07 16:17:10.73424	\N
10460	72	5	2014-12-07 16:17:10.736575	\N
10461	72	8	2014-12-07 16:17:10.738809	\N
10462	72	2	2014-12-07 16:17:10.740975	\N
10463	72	2	2014-12-07 16:17:10.746521	\N
10464	72	2	2014-12-07 16:17:10.749004	\N
10465	72	18	2014-12-07 16:17:10.751087	\N
10466	72	7	2014-12-07 16:17:10.754241	\N
10467	72	5	2014-12-07 16:17:10.757011	\N
10468	72	8	2014-12-07 16:17:10.759786	\N
10469	72	8	2014-12-07 16:17:10.763108	\N
10470	72	8	2014-12-07 16:17:10.766048	\N
10471	72	8	2014-12-07 16:17:10.768275	\N
10472	72	8	2014-12-07 16:17:10.770461	\N
10473	72	8	2014-12-07 16:17:10.773951	\N
10474	72	18	2014-12-07 16:17:10.776937	\N
10475	72	18	2014-12-07 16:17:10.779347	\N
10476	72	18	2014-12-07 16:17:10.781886	\N
10477	72	18	2014-12-07 16:17:10.784623	\N
10478	72	18	2014-12-07 16:17:10.786822	\N
10479	72	18	2014-12-07 16:17:10.789251	\N
10480	72	18	2014-12-07 16:17:10.793868	\N
10481	72	4	2014-12-07 16:17:10.796442	\N
10482	72	4	2014-12-07 16:17:10.798724	\N
10483	72	4	2014-12-07 16:17:10.800903	\N
10484	72	4	2014-12-07 16:17:10.803743	\N
10485	72	4	2014-12-07 16:17:10.806114	\N
10486	72	4	2014-12-07 16:17:10.80843	\N
10487	72	4	2014-12-07 16:17:10.811746	\N
10488	72	4	2014-12-07 16:17:10.814159	\N
10489	72	11	2014-12-07 16:17:10.816365	\N
10490	72	11	2014-12-07 16:17:10.818566	\N
10491	72	11	2014-12-07 16:17:10.821931	\N
10492	72	19	2014-12-07 16:17:10.824555	\N
10493	72	19	2014-12-07 16:17:10.827323	\N
10494	72	15	2014-12-07 16:17:10.829659	\N
10495	72	15	2014-12-07 16:17:10.833216	\N
10496	72	19	2014-12-07 16:17:10.835964	\N
10497	72	7	2014-12-07 16:17:10.838264	\N
10498	72	2	2014-12-07 16:17:10.840476	\N
10499	72	9	2014-12-07 16:17:10.84434	\N
10500	72	9	2014-12-07 16:17:10.84681	\N
10501	72	9	2014-12-07 16:17:10.849142	\N
10502	72	9	2014-12-07 16:17:10.852766	\N
10503	72	9	2014-12-07 16:17:10.855482	\N
10504	72	3	2014-12-07 16:17:10.857765	\N
10505	72	21	2014-12-07 16:17:10.860517	\N
10506	72	8	2014-12-07 16:17:10.864255	\N
10507	72	13	2014-12-07 16:17:10.86671	\N
10508	72	8	2014-12-07 16:17:10.868929	\N
10509	72	2	2014-12-07 16:17:10.872272	\N
10510	72	18	2014-12-07 16:17:10.875263	\N
10511	72	16	2014-12-07 16:17:10.877931	\N
10512	72	16	2014-12-07 16:17:10.881037	\N
10513	72	15	2014-12-07 16:17:10.88405	\N
10514	72	15	2014-12-07 16:17:10.886606	\N
10515	72	7	2014-12-07 16:17:10.888764	\N
10516	72	7	2014-12-07 16:17:10.892801	\N
10517	72	7	2014-12-07 16:17:10.895456	\N
10518	72	7	2014-12-07 16:17:10.897881	\N
10519	72	7	2014-12-07 16:17:10.900211	\N
10520	72	7	2014-12-07 16:17:10.904939	\N
10521	72	18	2014-12-07 16:17:10.907842	\N
10522	72	2	2014-12-07 16:17:10.911672	\N
10523	72	7	2014-12-07 16:17:10.914858	\N
10524	72	2	2014-12-07 16:17:10.917729	\N
10525	72	7	2014-12-07 16:17:10.920407	\N
10526	72	6	2014-12-07 16:17:10.923052	\N
10527	73	2	2014-12-07 16:17:13.02567	\N
10528	73	2	2014-12-07 16:17:13.040772	\N
10529	73	2	2014-12-07 16:17:13.042956	\N
10530	73	2	2014-12-07 16:17:13.045205	\N
10531	73	5	2014-12-07 16:17:13.047207	\N
10532	73	5	2014-12-07 16:17:13.049656	\N
10533	73	8	2014-12-07 16:17:13.051875	\N
10534	73	2	2014-12-07 16:17:13.05404	\N
10535	73	2	2014-12-07 16:17:13.056082	\N
10536	73	2	2014-12-07 16:17:13.058403	\N
10537	73	18	2014-12-07 16:17:13.060724	\N
10538	73	7	2014-12-07 16:17:13.062804	\N
10539	73	5	2014-12-07 16:17:13.064905	\N
10540	73	8	2014-12-07 16:17:13.06712	\N
10541	73	8	2014-12-07 16:17:13.069441	\N
10542	73	8	2014-12-07 16:17:13.071753	\N
10543	73	8	2014-12-07 16:17:13.073864	\N
10544	73	8	2014-12-07 16:17:13.075867	\N
10545	73	8	2014-12-07 16:17:13.078047	\N
10546	73	18	2014-12-07 16:17:13.080254	\N
10547	73	18	2014-12-07 16:17:13.082557	\N
10548	73	18	2014-12-07 16:17:13.084875	\N
10549	73	18	2014-12-07 16:17:13.086881	\N
10550	73	18	2014-12-07 16:17:13.089094	\N
10551	73	18	2014-12-07 16:17:13.091223	\N
10552	73	18	2014-12-07 16:17:13.093457	\N
10553	73	4	2014-12-07 16:17:13.095621	\N
10554	73	4	2014-12-07 16:17:13.097788	\N
10555	73	4	2014-12-07 16:17:13.099972	\N
10556	73	4	2014-12-07 16:17:13.102113	\N
10557	73	4	2014-12-07 16:17:13.104233	\N
10558	73	4	2014-12-07 16:17:13.106321	\N
10559	73	4	2014-12-07 16:17:13.108697	\N
10560	73	4	2014-12-07 16:17:13.111047	\N
10561	73	11	2014-12-07 16:17:13.113177	\N
10562	73	11	2014-12-07 16:17:13.115236	\N
10563	73	11	2014-12-07 16:17:13.117562	\N
10564	73	19	2014-12-07 16:17:13.120666	\N
10565	73	19	2014-12-07 16:17:13.127197	\N
10566	73	15	2014-12-07 16:17:13.129745	\N
10567	73	15	2014-12-07 16:17:13.132038	\N
10568	73	19	2014-12-07 16:17:13.135046	\N
10569	73	7	2014-12-07 16:17:13.137407	\N
10570	73	2	2014-12-07 16:17:13.139622	\N
10571	73	9	2014-12-07 16:17:13.141924	\N
10572	73	9	2014-12-07 16:17:13.143938	\N
10573	73	9	2014-12-07 16:17:13.146168	\N
10574	73	9	2014-12-07 16:17:13.148702	\N
10575	73	9	2014-12-07 16:17:13.151305	\N
10576	73	3	2014-12-07 16:17:13.153617	\N
10577	73	21	2014-12-07 16:17:13.155652	\N
10578	73	8	2014-12-07 16:17:13.157938	\N
10579	73	13	2014-12-07 16:17:13.160221	\N
10580	73	8	2014-12-07 16:17:13.162396	\N
10581	73	2	2014-12-07 16:17:13.164529	\N
10582	73	18	2014-12-07 16:17:13.166866	\N
10583	73	16	2014-12-07 16:17:13.169192	\N
10584	73	16	2014-12-07 16:17:13.171674	\N
10585	73	15	2014-12-07 16:17:13.173931	\N
10586	73	15	2014-12-07 16:17:13.176086	\N
10587	73	7	2014-12-07 16:17:13.178424	\N
10588	73	7	2014-12-07 16:17:13.180749	\N
10589	73	7	2014-12-07 16:17:13.182974	\N
10590	73	7	2014-12-07 16:17:13.185067	\N
10591	73	7	2014-12-07 16:17:13.188002	\N
10592	73	7	2014-12-07 16:17:13.19158	\N
10593	73	18	2014-12-07 16:17:13.194303	\N
10594	73	2	2014-12-07 16:17:13.19661	\N
10595	73	7	2014-12-07 16:17:13.199714	\N
10596	73	2	2014-12-07 16:17:13.202545	\N
10597	73	7	2014-12-07 16:17:13.204755	\N
10598	73	6	2014-12-07 16:17:13.207877	\N
10599	73	20	2014-12-07 16:17:13.211111	\N
10600	74	2	2014-12-07 16:17:13.418712	\N
10601	74	2	2014-12-07 16:17:13.421784	\N
10602	74	2	2014-12-07 16:17:13.4241	\N
10603	74	2	2014-12-07 16:17:13.427038	\N
10604	74	5	2014-12-07 16:17:13.429459	\N
10605	74	5	2014-12-07 16:17:13.431617	\N
10606	74	8	2014-12-07 16:17:13.434101	\N
10607	74	2	2014-12-07 16:17:13.436551	\N
10608	74	2	2014-12-07 16:17:13.438736	\N
10609	74	2	2014-12-07 16:17:13.440882	\N
10610	74	18	2014-12-07 16:17:13.443093	\N
10611	74	7	2014-12-07 16:17:13.445525	\N
10612	74	5	2014-12-07 16:17:13.447664	\N
10613	74	8	2014-12-07 16:17:13.449751	\N
10614	74	8	2014-12-07 16:17:13.451976	\N
10615	74	8	2014-12-07 16:17:13.45422	\N
10616	74	8	2014-12-07 16:17:13.456674	\N
10617	74	8	2014-12-07 16:17:13.459155	\N
10618	74	8	2014-12-07 16:17:13.461471	\N
10619	74	18	2014-12-07 16:17:13.463936	\N
10620	74	18	2014-12-07 16:17:13.466228	\N
10621	74	18	2014-12-07 16:17:13.468654	\N
10622	74	18	2014-12-07 16:17:13.471318	\N
10623	74	18	2014-12-07 16:17:13.474096	\N
10624	74	18	2014-12-07 16:17:13.476527	\N
10625	74	18	2014-12-07 16:17:13.47891	\N
10626	74	4	2014-12-07 16:17:13.481426	\N
10627	74	4	2014-12-07 16:17:13.483884	\N
10628	74	4	2014-12-07 16:17:13.486216	\N
10629	74	4	2014-12-07 16:17:13.488392	\N
10630	74	4	2014-12-07 16:17:13.490604	\N
10631	74	4	2014-12-07 16:17:13.492699	\N
10632	74	4	2014-12-07 16:17:13.495244	\N
10633	74	4	2014-12-07 16:17:13.497584	\N
10634	74	11	2014-12-07 16:17:13.499737	\N
10635	74	11	2014-12-07 16:17:13.501943	\N
10636	74	11	2014-12-07 16:17:13.50425	\N
10637	74	19	2014-12-07 16:17:13.506584	\N
10638	74	19	2014-12-07 16:17:13.508712	\N
10639	74	15	2014-12-07 16:17:13.510862	\N
10640	74	15	2014-12-07 16:17:13.512969	\N
10641	74	19	2014-12-07 16:17:13.515195	\N
10642	74	7	2014-12-07 16:17:13.517587	\N
10643	74	2	2014-12-07 16:17:13.519773	\N
10644	74	9	2014-12-07 16:17:13.52218	\N
10645	74	9	2014-12-07 16:17:13.524448	\N
10646	74	9	2014-12-07 16:17:13.526775	\N
10647	74	9	2014-12-07 16:17:13.528876	\N
10648	74	9	2014-12-07 16:17:13.530895	\N
10649	74	3	2014-12-07 16:17:13.533058	\N
10650	74	21	2014-12-07 16:17:13.535353	\N
10651	74	8	2014-12-07 16:17:13.537567	\N
10652	74	13	2014-12-07 16:17:13.539708	\N
10653	74	8	2014-12-07 16:17:13.541813	\N
10654	74	2	2014-12-07 16:17:13.544142	\N
10655	74	18	2014-12-07 16:17:13.54644	\N
10656	74	16	2014-12-07 16:17:13.548507	\N
10657	74	16	2014-12-07 16:17:13.550805	\N
10658	74	15	2014-12-07 16:17:13.553016	\N
10659	74	15	2014-12-07 16:17:13.555197	\N
10660	74	7	2014-12-07 16:17:13.55751	\N
10661	74	7	2014-12-07 16:17:13.559621	\N
10662	74	7	2014-12-07 16:17:13.561779	\N
10663	74	7	2014-12-07 16:17:13.564013	\N
10664	74	7	2014-12-07 16:17:13.566377	\N
10665	74	7	2014-12-07 16:17:13.568679	\N
10666	74	18	2014-12-07 16:17:13.570954	\N
10667	74	2	2014-12-07 16:17:13.573096	\N
10668	74	7	2014-12-07 16:17:13.575415	\N
10669	74	2	2014-12-07 16:17:13.577869	\N
10670	74	7	2014-12-07 16:17:13.579979	\N
10671	74	6	2014-12-07 16:17:13.582161	\N
10672	74	20	2014-12-07 16:17:13.584416	\N
10673	74	20	2014-12-07 16:17:13.586816	\N
10674	75	2	2014-12-07 16:17:13.731128	\N
10675	75	2	2014-12-07 16:17:13.734473	\N
10676	75	2	2014-12-07 16:17:13.7376	\N
10677	75	2	2014-12-07 16:17:13.74018	\N
10678	75	5	2014-12-07 16:17:13.743142	\N
10679	75	5	2014-12-07 16:17:13.747716	\N
10680	75	8	2014-12-07 16:17:13.749941	\N
10681	75	2	2014-12-07 16:17:13.752946	\N
10682	75	2	2014-12-07 16:17:13.756209	\N
10683	75	2	2014-12-07 16:17:13.758538	\N
10684	75	18	2014-12-07 16:17:13.760695	\N
10685	75	7	2014-12-07 16:17:13.763433	\N
10686	75	5	2014-12-07 16:17:13.765833	\N
10687	75	8	2014-12-07 16:17:13.768164	\N
10688	75	8	2014-12-07 16:17:13.770781	\N
10689	75	8	2014-12-07 16:17:13.77425	\N
10690	75	8	2014-12-07 16:17:13.776714	\N
10691	75	8	2014-12-07 16:17:13.778996	\N
10692	75	8	2014-12-07 16:17:13.781253	\N
10693	75	18	2014-12-07 16:17:13.784731	\N
10694	75	18	2014-12-07 16:17:13.787669	\N
10695	75	18	2014-12-07 16:17:13.790117	\N
10696	75	18	2014-12-07 16:17:13.793238	\N
10697	75	18	2014-12-07 16:17:13.796238	\N
10698	75	18	2014-12-07 16:17:13.798532	\N
10699	75	18	2014-12-07 16:17:13.800699	\N
10700	75	4	2014-12-07 16:17:13.804702	\N
10701	75	4	2014-12-07 16:17:13.807298	\N
10702	75	4	2014-12-07 16:17:13.80963	\N
10703	75	4	2014-12-07 16:17:13.812352	\N
10704	75	4	2014-12-07 16:17:13.814772	\N
10705	75	4	2014-12-07 16:17:13.817245	\N
10706	75	4	2014-12-07 16:17:13.819936	\N
10707	75	4	2014-12-07 16:17:13.822493	\N
10708	75	11	2014-12-07 16:17:13.824854	\N
10709	75	11	2014-12-07 16:17:13.827103	\N
10710	75	11	2014-12-07 16:17:13.829302	\N
10711	75	19	2014-12-07 16:17:13.831534	\N
10712	75	19	2014-12-07 16:17:13.83395	\N
10713	75	15	2014-12-07 16:17:13.836957	\N
10714	75	15	2014-12-07 16:17:13.839283	\N
10715	75	19	2014-12-07 16:17:13.841654	\N
10716	75	7	2014-12-07 16:17:13.844001	\N
10717	75	2	2014-12-07 16:17:13.846241	\N
10718	75	9	2014-12-07 16:17:13.848668	\N
10719	75	9	2014-12-07 16:17:13.851288	\N
10720	75	9	2014-12-07 16:17:13.853776	\N
10721	75	9	2014-12-07 16:17:13.855975	\N
10722	75	9	2014-12-07 16:17:13.858167	\N
10723	75	3	2014-12-07 16:17:13.860337	\N
10724	75	21	2014-12-07 16:17:13.862697	\N
10725	75	8	2014-12-07 16:17:13.864949	\N
10726	75	13	2014-12-07 16:17:13.867276	\N
10727	75	8	2014-12-07 16:17:13.869497	\N
10728	75	2	2014-12-07 16:17:13.872049	\N
10729	75	18	2014-12-07 16:17:13.874231	\N
10730	75	16	2014-12-07 16:17:13.876374	\N
10731	75	16	2014-12-07 16:17:13.878507	\N
10732	75	15	2014-12-07 16:17:13.880783	\N
10733	75	15	2014-12-07 16:17:13.883143	\N
10734	75	7	2014-12-07 16:17:13.885355	\N
10735	75	7	2014-12-07 16:17:13.887707	\N
10736	75	7	2014-12-07 16:17:13.89006	\N
10737	75	7	2014-12-07 16:17:13.892427	\N
10738	75	7	2014-12-07 16:17:13.894584	\N
10739	75	7	2014-12-07 16:17:13.897137	\N
10740	75	18	2014-12-07 16:17:13.899227	\N
10741	75	2	2014-12-07 16:17:13.901568	\N
10742	75	7	2014-12-07 16:17:13.904106	\N
10743	75	2	2014-12-07 16:17:13.90629	\N
10744	75	7	2014-12-07 16:17:13.908401	\N
10745	75	6	2014-12-07 16:17:13.910662	\N
10746	75	20	2014-12-07 16:17:13.913153	\N
10747	75	20	2014-12-07 16:17:13.915252	\N
10748	75	12	2014-12-07 16:17:13.917486	\N
10749	76	2	2014-12-07 16:17:14.915726	\N
10750	76	2	2014-12-07 16:17:14.918704	\N
10751	76	2	2014-12-07 16:17:14.921126	\N
10752	76	2	2014-12-07 16:17:14.923241	\N
10753	76	5	2014-12-07 16:17:14.925537	\N
10754	76	5	2014-12-07 16:17:14.927653	\N
10755	76	8	2014-12-07 16:17:14.929786	\N
10756	76	2	2014-12-07 16:17:14.931845	\N
10757	76	2	2014-12-07 16:17:14.934074	\N
10758	76	2	2014-12-07 16:17:14.936214	\N
10759	76	18	2014-12-07 16:17:14.938293	\N
10760	76	7	2014-12-07 16:17:14.940619	\N
10761	76	5	2014-12-07 16:17:14.942739	\N
10762	76	8	2014-12-07 16:17:14.944804	\N
10763	76	8	2014-12-07 16:17:14.946829	\N
10764	76	8	2014-12-07 16:17:14.949179	\N
10765	76	8	2014-12-07 16:17:14.951251	\N
10766	76	8	2014-12-07 16:17:14.953314	\N
10767	76	8	2014-12-07 16:17:14.955674	\N
10768	76	18	2014-12-07 16:17:14.957858	\N
10769	76	18	2014-12-07 16:17:14.959996	\N
10770	76	18	2014-12-07 16:17:14.962	\N
10771	76	18	2014-12-07 16:17:14.964073	\N
10772	76	18	2014-12-07 16:17:14.966253	\N
10773	76	18	2014-12-07 16:17:14.96832	\N
10774	76	18	2014-12-07 16:17:14.970509	\N
10775	76	4	2014-12-07 16:17:14.973187	\N
10776	76	4	2014-12-07 16:17:14.975437	\N
10777	76	4	2014-12-07 16:17:14.977668	\N
10778	76	4	2014-12-07 16:17:14.979822	\N
10779	76	4	2014-12-07 16:17:14.98192	\N
10780	76	4	2014-12-07 16:17:14.98432	\N
10781	76	4	2014-12-07 16:17:14.986737	\N
10782	76	4	2014-12-07 16:17:14.988883	\N
10783	76	11	2014-12-07 16:17:14.991024	\N
10784	76	11	2014-12-07 16:17:14.993064	\N
10785	76	11	2014-12-07 16:17:14.995062	\N
10786	76	19	2014-12-07 16:17:14.997213	\N
10787	76	19	2014-12-07 16:17:15.000014	\N
10788	76	15	2014-12-07 16:17:15.002973	\N
10789	76	15	2014-12-07 16:17:15.007393	\N
10790	76	19	2014-12-07 16:17:15.009803	\N
10791	76	7	2014-12-07 16:17:15.012094	\N
10792	76	2	2014-12-07 16:17:15.014183	\N
10793	76	9	2014-12-07 16:17:15.016321	\N
10794	76	9	2014-12-07 16:17:15.018373	\N
10795	76	9	2014-12-07 16:17:15.02048	\N
10796	76	9	2014-12-07 16:17:15.022707	\N
10797	76	9	2014-12-07 16:17:15.025741	\N
10798	76	3	2014-12-07 16:17:15.029061	\N
10799	76	21	2014-12-07 16:17:15.031718	\N
10800	76	8	2014-12-07 16:17:15.034558	\N
10801	76	13	2014-12-07 16:17:15.036797	\N
10802	76	8	2014-12-07 16:17:15.038847	\N
10803	76	2	2014-12-07 16:17:15.041203	\N
10804	76	18	2014-12-07 16:17:15.043209	\N
10805	76	16	2014-12-07 16:17:15.045205	\N
10806	76	16	2014-12-07 16:17:15.047142	\N
10807	76	15	2014-12-07 16:17:15.049221	\N
10808	76	15	2014-12-07 16:17:15.051118	\N
10809	76	7	2014-12-07 16:17:15.053109	\N
10810	76	7	2014-12-07 16:17:15.05501	\N
10811	76	7	2014-12-07 16:17:15.05734	\N
10812	76	7	2014-12-07 16:17:15.059399	\N
10813	76	7	2014-12-07 16:17:15.061405	\N
10814	76	7	2014-12-07 16:17:15.063441	\N
10815	76	18	2014-12-07 16:17:15.065564	\N
10816	76	2	2014-12-07 16:17:15.067593	\N
10817	76	7	2014-12-07 16:17:15.069547	\N
10818	76	2	2014-12-07 16:17:15.071604	\N
10819	76	7	2014-12-07 16:17:15.073704	\N
10820	76	6	2014-12-07 16:17:15.075726	\N
10821	76	20	2014-12-07 16:17:15.077683	\N
10822	76	20	2014-12-07 16:17:15.079635	\N
10823	76	12	2014-12-07 16:17:15.081624	\N
10824	76	3	2014-12-07 16:17:15.083694	\N
10825	77	2	2014-12-07 16:17:16.058758	\N
10826	77	2	2014-12-07 16:17:16.061885	\N
10827	77	2	2014-12-07 16:17:16.064083	\N
10828	77	2	2014-12-07 16:17:16.066246	\N
10829	77	5	2014-12-07 16:17:16.068497	\N
10830	77	5	2014-12-07 16:17:16.070662	\N
10831	77	8	2014-12-07 16:17:16.072821	\N
10832	77	2	2014-12-07 16:17:16.074899	\N
10833	77	2	2014-12-07 16:17:16.076986	\N
10834	77	2	2014-12-07 16:17:16.079184	\N
10835	77	18	2014-12-07 16:17:16.081343	\N
10836	77	7	2014-12-07 16:17:16.083379	\N
10837	77	5	2014-12-07 16:17:16.085503	\N
10838	77	8	2014-12-07 16:17:16.087605	\N
10839	77	8	2014-12-07 16:17:16.090423	\N
10840	77	8	2014-12-07 16:17:16.092686	\N
10841	77	8	2014-12-07 16:17:16.094953	\N
10842	77	8	2014-12-07 16:17:16.097201	\N
10843	77	8	2014-12-07 16:17:16.099169	\N
10844	77	18	2014-12-07 16:17:16.101235	\N
10845	77	18	2014-12-07 16:17:16.103198	\N
10846	77	18	2014-12-07 16:17:16.105226	\N
10847	77	18	2014-12-07 16:17:16.107581	\N
10848	77	18	2014-12-07 16:17:16.109674	\N
10849	77	18	2014-12-07 16:17:16.111743	\N
10850	77	18	2014-12-07 16:17:16.113937	\N
10851	77	4	2014-12-07 16:17:16.115959	\N
10852	77	4	2014-12-07 16:17:16.118025	\N
10853	77	4	2014-12-07 16:17:16.119998	\N
10854	77	4	2014-12-07 16:17:16.121912	\N
10855	77	4	2014-12-07 16:17:16.123835	\N
10856	77	4	2014-12-07 16:17:16.125857	\N
10857	77	4	2014-12-07 16:17:16.127965	\N
10858	77	4	2014-12-07 16:17:16.130019	\N
10859	77	11	2014-12-07 16:17:16.132357	\N
10860	77	11	2014-12-07 16:17:16.134562	\N
10861	77	11	2014-12-07 16:17:16.136653	\N
10862	77	19	2014-12-07 16:17:16.138715	\N
10863	77	19	2014-12-07 16:17:16.140779	\N
10864	77	15	2014-12-07 16:17:16.142797	\N
10865	77	15	2014-12-07 16:17:16.144953	\N
10866	77	19	2014-12-07 16:17:16.147232	\N
10867	77	7	2014-12-07 16:17:16.14974	\N
10868	77	2	2014-12-07 16:17:16.151814	\N
10869	77	9	2014-12-07 16:17:16.153991	\N
10870	77	9	2014-12-07 16:17:16.155924	\N
10871	77	9	2014-12-07 16:17:16.158005	\N
10872	77	9	2014-12-07 16:17:16.160053	\N
10873	77	9	2014-12-07 16:17:16.162162	\N
10874	77	3	2014-12-07 16:17:16.164298	\N
10875	77	21	2014-12-07 16:17:16.166383	\N
10876	77	8	2014-12-07 16:17:16.168444	\N
10877	77	13	2014-12-07 16:17:16.170604	\N
10878	77	8	2014-12-07 16:17:16.172703	\N
10879	77	2	2014-12-07 16:17:16.175666	\N
10880	77	18	2014-12-07 16:17:16.182242	\N
10881	77	16	2014-12-07 16:17:16.184793	\N
10882	77	16	2014-12-07 16:17:16.186948	\N
10883	77	15	2014-12-07 16:17:16.189315	\N
10884	77	15	2014-12-07 16:17:16.191619	\N
10885	77	7	2014-12-07 16:17:16.194553	\N
10886	77	7	2014-12-07 16:17:16.197052	\N
10887	77	7	2014-12-07 16:17:16.199334	\N
10888	77	7	2014-12-07 16:17:16.201537	\N
10889	77	7	2014-12-07 16:17:16.203526	\N
10890	77	7	2014-12-07 16:17:16.205637	\N
10891	77	18	2014-12-07 16:17:16.207721	\N
10892	77	2	2014-12-07 16:17:16.209849	\N
10893	77	7	2014-12-07 16:17:16.212057	\N
10894	77	2	2014-12-07 16:17:16.214208	\N
10895	77	7	2014-12-07 16:17:16.216297	\N
10896	77	6	2014-12-07 16:17:16.218378	\N
10897	77	20	2014-12-07 16:17:16.22048	\N
10898	77	20	2014-12-07 16:17:16.222557	\N
10899	77	12	2014-12-07 16:17:16.224672	\N
10900	77	3	2014-12-07 16:17:16.226832	\N
10901	77	5	2014-12-07 16:17:16.228951	\N
10902	78	2	2014-12-07 16:17:16.315173	\N
10903	78	2	2014-12-07 16:17:16.318149	\N
10904	78	2	2014-12-07 16:17:16.320525	\N
10905	78	2	2014-12-07 16:17:16.32304	\N
10906	78	5	2014-12-07 16:17:16.32521	\N
10907	78	5	2014-12-07 16:17:16.327332	\N
10908	78	8	2014-12-07 16:17:16.329559	\N
10909	78	2	2014-12-07 16:17:16.331605	\N
10910	78	2	2014-12-07 16:17:16.333692	\N
10911	78	2	2014-12-07 16:17:16.335797	\N
10912	78	18	2014-12-07 16:17:16.337888	\N
10913	78	7	2014-12-07 16:17:16.339916	\N
10914	78	5	2014-12-07 16:17:16.342021	\N
10915	78	8	2014-12-07 16:17:16.344203	\N
10916	78	8	2014-12-07 16:17:16.346295	\N
10917	78	8	2014-12-07 16:17:16.34836	\N
10918	78	8	2014-12-07 16:17:16.350957	\N
10919	78	8	2014-12-07 16:17:16.353261	\N
10920	78	8	2014-12-07 16:17:16.355233	\N
10921	78	18	2014-12-07 16:17:16.357415	\N
10922	78	18	2014-12-07 16:17:16.359558	\N
10923	78	18	2014-12-07 16:17:16.361742	\N
10924	78	18	2014-12-07 16:17:16.363868	\N
10925	78	18	2014-12-07 16:17:16.365898	\N
10926	78	18	2014-12-07 16:17:16.368051	\N
10927	78	18	2014-12-07 16:17:16.370157	\N
10928	78	4	2014-12-07 16:17:16.372213	\N
10929	78	4	2014-12-07 16:17:16.374186	\N
10930	78	4	2014-12-07 16:17:16.376187	\N
10931	78	4	2014-12-07 16:17:16.37826	\N
10932	78	4	2014-12-07 16:17:16.380445	\N
10933	78	4	2014-12-07 16:17:16.382564	\N
10934	78	4	2014-12-07 16:17:16.384701	\N
10935	78	4	2014-12-07 16:17:16.386738	\N
10936	78	11	2014-12-07 16:17:16.388781	\N
10937	78	11	2014-12-07 16:17:16.390797	\N
10938	78	11	2014-12-07 16:17:16.392845	\N
10939	78	19	2014-12-07 16:17:16.394903	\N
10940	78	19	2014-12-07 16:17:16.397121	\N
10941	78	15	2014-12-07 16:17:16.399168	\N
10942	78	15	2014-12-07 16:17:16.401187	\N
10943	78	19	2014-12-07 16:17:16.40313	\N
10944	78	7	2014-12-07 16:17:16.405062	\N
10945	78	2	2014-12-07 16:17:16.40723	\N
10946	78	9	2014-12-07 16:17:16.409294	\N
10947	78	9	2014-12-07 16:17:16.411346	\N
10948	78	9	2014-12-07 16:17:16.413502	\N
10949	78	9	2014-12-07 16:17:16.415615	\N
10950	78	9	2014-12-07 16:17:16.417718	\N
10951	78	3	2014-12-07 16:17:16.419764	\N
10952	78	21	2014-12-07 16:17:16.421814	\N
10953	78	8	2014-12-07 16:17:16.423834	\N
10954	78	13	2014-12-07 16:17:16.425897	\N
10955	78	8	2014-12-07 16:17:16.428031	\N
10956	78	2	2014-12-07 16:17:16.430236	\N
10957	78	18	2014-12-07 16:17:16.432247	\N
10958	78	16	2014-12-07 16:17:16.434198	\N
10959	78	16	2014-12-07 16:17:16.436164	\N
10960	78	15	2014-12-07 16:17:16.438113	\N
10961	78	15	2014-12-07 16:17:16.440115	\N
10962	78	7	2014-12-07 16:17:16.442166	\N
10963	78	7	2014-12-07 16:17:16.444617	\N
10964	78	7	2014-12-07 16:17:16.446801	\N
10965	78	7	2014-12-07 16:17:16.449796	\N
10966	78	7	2014-12-07 16:17:16.452325	\N
10967	78	7	2014-12-07 16:17:16.455249	\N
10968	78	18	2014-12-07 16:17:16.458524	\N
10969	78	2	2014-12-07 16:17:16.461373	\N
10970	78	7	2014-12-07 16:17:16.464819	\N
10971	78	2	2014-12-07 16:17:16.467278	\N
10972	78	7	2014-12-07 16:17:16.470634	\N
10973	78	6	2014-12-07 16:17:16.473547	\N
10974	78	20	2014-12-07 16:17:16.477059	\N
10975	78	20	2014-12-07 16:17:16.479997	\N
10976	78	12	2014-12-07 16:17:16.48258	\N
10977	78	3	2014-12-07 16:17:16.484961	\N
10978	78	5	2014-12-07 16:17:16.487189	\N
10979	78	10	2014-12-07 16:17:16.489268	\N
10980	79	2	2014-12-07 16:17:16.576708	\N
10981	79	2	2014-12-07 16:17:16.579732	\N
10982	79	2	2014-12-07 16:17:16.582166	\N
10983	79	2	2014-12-07 16:17:16.584937	\N
10984	79	5	2014-12-07 16:17:16.587241	\N
10985	79	5	2014-12-07 16:17:16.58944	\N
10986	79	8	2014-12-07 16:17:16.591478	\N
10987	79	2	2014-12-07 16:17:16.59374	\N
10988	79	2	2014-12-07 16:17:16.595865	\N
10989	79	2	2014-12-07 16:17:16.598312	\N
10990	79	18	2014-12-07 16:17:16.600386	\N
10991	79	7	2014-12-07 16:17:16.602422	\N
10992	79	5	2014-12-07 16:17:16.604461	\N
10993	79	8	2014-12-07 16:17:16.606512	\N
10994	79	8	2014-12-07 16:17:16.608536	\N
10995	79	8	2014-12-07 16:17:16.610572	\N
10996	79	8	2014-12-07 16:17:16.612783	\N
10997	79	8	2014-12-07 16:17:16.614859	\N
10998	79	8	2014-12-07 16:17:16.616894	\N
10999	79	18	2014-12-07 16:17:16.619001	\N
11000	79	18	2014-12-07 16:17:16.621086	\N
11001	79	18	2014-12-07 16:17:16.623182	\N
11002	79	18	2014-12-07 16:17:16.625244	\N
11003	79	18	2014-12-07 16:17:16.627122	\N
11004	79	18	2014-12-07 16:17:16.629272	\N
11005	79	18	2014-12-07 16:17:16.631427	\N
11006	79	4	2014-12-07 16:17:16.633583	\N
11007	79	4	2014-12-07 16:17:16.635782	\N
11008	79	4	2014-12-07 16:17:16.637838	\N
11009	79	4	2014-12-07 16:17:16.639948	\N
11010	79	4	2014-12-07 16:17:16.642004	\N
11011	79	4	2014-12-07 16:17:16.644077	\N
11012	79	4	2014-12-07 16:17:16.646435	\N
11013	79	4	2014-12-07 16:17:16.648491	\N
11014	79	11	2014-12-07 16:17:16.650623	\N
11015	79	11	2014-12-07 16:17:16.652761	\N
11016	79	11	2014-12-07 16:17:16.654953	\N
11017	79	19	2014-12-07 16:17:16.657019	\N
11018	79	19	2014-12-07 16:17:16.659821	\N
11019	79	15	2014-12-07 16:17:16.662392	\N
11020	79	15	2014-12-07 16:17:16.664685	\N
11021	79	19	2014-12-07 16:17:16.666856	\N
11022	79	7	2014-12-07 16:17:16.669011	\N
11023	79	2	2014-12-07 16:17:16.671098	\N
11024	79	9	2014-12-07 16:17:16.673427	\N
11025	79	9	2014-12-07 16:17:16.675652	\N
11026	79	9	2014-12-07 16:17:16.677858	\N
11027	79	9	2014-12-07 16:17:16.680188	\N
11028	79	9	2014-12-07 16:17:16.682348	\N
11029	79	3	2014-12-07 16:17:16.684436	\N
11030	79	21	2014-12-07 16:17:16.686527	\N
11031	79	8	2014-12-07 16:17:16.688697	\N
11032	79	13	2014-12-07 16:17:16.69146	\N
11033	79	8	2014-12-07 16:17:16.697817	\N
11034	79	2	2014-12-07 16:17:16.700344	\N
11035	79	18	2014-12-07 16:17:16.702632	\N
11036	79	16	2014-12-07 16:17:16.705044	\N
11037	79	16	2014-12-07 16:17:16.707102	\N
11038	79	15	2014-12-07 16:17:16.709144	\N
11039	79	15	2014-12-07 16:17:16.711244	\N
11040	79	7	2014-12-07 16:17:16.714232	\N
11041	79	7	2014-12-07 16:17:16.716526	\N
11042	79	7	2014-12-07 16:17:16.718622	\N
11043	79	7	2014-12-07 16:17:16.72074	\N
11044	79	7	2014-12-07 16:17:16.722923	\N
11045	79	7	2014-12-07 16:17:16.725014	\N
11046	79	18	2014-12-07 16:17:16.727121	\N
11047	79	2	2014-12-07 16:17:16.729308	\N
11048	79	7	2014-12-07 16:17:16.731362	\N
11049	79	2	2014-12-07 16:17:16.733541	\N
11050	79	7	2014-12-07 16:17:16.735523	\N
11051	79	6	2014-12-07 16:17:16.737564	\N
11052	79	20	2014-12-07 16:17:16.739518	\N
11053	79	20	2014-12-07 16:17:16.74236	\N
11054	79	12	2014-12-07 16:17:16.745866	\N
11055	79	3	2014-12-07 16:17:16.748178	\N
11056	79	5	2014-12-07 16:17:16.750338	\N
11057	79	10	2014-12-07 16:17:16.752517	\N
11058	79	10	2014-12-07 16:17:16.754575	\N
11059	80	2	2014-12-07 16:17:16.845012	\N
11060	80	2	2014-12-07 16:17:16.847836	\N
11061	80	2	2014-12-07 16:17:16.850247	\N
11062	80	2	2014-12-07 16:17:16.852732	\N
11063	80	5	2014-12-07 16:17:16.855122	\N
11064	80	5	2014-12-07 16:17:16.857324	\N
11065	80	8	2014-12-07 16:17:16.85933	\N
11066	80	2	2014-12-07 16:17:16.861393	\N
11067	80	2	2014-12-07 16:17:16.863489	\N
11068	80	2	2014-12-07 16:17:16.865628	\N
11069	80	18	2014-12-07 16:17:16.8676	\N
11070	80	7	2014-12-07 16:17:16.869654	\N
11071	80	5	2014-12-07 16:17:16.871708	\N
11072	80	8	2014-12-07 16:17:16.873776	\N
11073	80	8	2014-12-07 16:17:16.875941	\N
11074	80	8	2014-12-07 16:17:16.878004	\N
11075	80	8	2014-12-07 16:17:16.880206	\N
11076	80	8	2014-12-07 16:17:16.882343	\N
11077	80	8	2014-12-07 16:17:16.884578	\N
11078	80	18	2014-12-07 16:17:16.886714	\N
11079	80	18	2014-12-07 16:17:16.888768	\N
11080	80	18	2014-12-07 16:17:16.890794	\N
11081	80	18	2014-12-07 16:17:16.892939	\N
11082	80	18	2014-12-07 16:17:16.895073	\N
11083	80	18	2014-12-07 16:17:16.897307	\N
11084	80	18	2014-12-07 16:17:16.899384	\N
11085	80	4	2014-12-07 16:17:16.901427	\N
11086	80	4	2014-12-07 16:17:16.903434	\N
11087	80	4	2014-12-07 16:17:16.90551	\N
11088	80	4	2014-12-07 16:17:16.90738	\N
11089	80	4	2014-12-07 16:17:16.909391	\N
11090	80	4	2014-12-07 16:17:16.911377	\N
11091	80	4	2014-12-07 16:17:16.913604	\N
11092	80	4	2014-12-07 16:17:16.915642	\N
11093	80	11	2014-12-07 16:17:16.917733	\N
11094	80	11	2014-12-07 16:17:16.919807	\N
11095	80	11	2014-12-07 16:17:16.921886	\N
11096	80	19	2014-12-07 16:17:16.924004	\N
11097	80	19	2014-12-07 16:17:16.92606	\N
11098	80	15	2014-12-07 16:17:16.928089	\N
11099	80	15	2014-12-07 16:17:16.930253	\N
11100	80	19	2014-12-07 16:17:16.932327	\N
11101	80	7	2014-12-07 16:17:16.934458	\N
11102	80	2	2014-12-07 16:17:16.936486	\N
11103	80	9	2014-12-07 16:17:16.938491	\N
11104	80	9	2014-12-07 16:17:16.94056	\N
11105	80	9	2014-12-07 16:17:16.942587	\N
11106	80	9	2014-12-07 16:17:16.944617	\N
11107	80	9	2014-12-07 16:17:16.946706	\N
11108	80	3	2014-12-07 16:17:16.9488	\N
11109	80	21	2014-12-07 16:17:16.951222	\N
11110	80	8	2014-12-07 16:17:16.953346	\N
11111	80	13	2014-12-07 16:17:16.955482	\N
11112	80	8	2014-12-07 16:17:16.957528	\N
11113	80	2	2014-12-07 16:17:16.959486	\N
11114	80	18	2014-12-07 16:17:16.961622	\N
11115	80	16	2014-12-07 16:17:16.963733	\N
11116	80	16	2014-12-07 16:17:16.965863	\N
11117	80	15	2014-12-07 16:17:16.968032	\N
11118	80	15	2014-12-07 16:17:16.970111	\N
11119	80	7	2014-12-07 16:17:16.972156	\N
11120	80	7	2014-12-07 16:17:16.974266	\N
11121	80	7	2014-12-07 16:17:16.976317	\N
11122	80	7	2014-12-07 16:17:16.978342	\N
11123	80	7	2014-12-07 16:17:16.980419	\N
11124	80	7	2014-12-07 16:17:16.982631	\N
11125	80	18	2014-12-07 16:17:16.984926	\N
11126	80	2	2014-12-07 16:17:16.987035	\N
11127	80	7	2014-12-07 16:17:16.989082	\N
11128	80	2	2014-12-07 16:17:16.991124	\N
11129	80	7	2014-12-07 16:17:16.993186	\N
11130	80	6	2014-12-07 16:17:16.995122	\N
11131	80	20	2014-12-07 16:17:16.99739	\N
11132	80	20	2014-12-07 16:17:16.999465	\N
11133	80	12	2014-12-07 16:17:17.0018	\N
11134	80	3	2014-12-07 16:17:17.004189	\N
11135	80	5	2014-12-07 16:17:17.006449	\N
11136	80	10	2014-12-07 16:17:17.008612	\N
11137	80	10	2014-12-07 16:17:17.010658	\N
11138	80	5	2014-12-07 16:17:17.012699	\N
11139	81	2	2014-12-07 16:17:17.100373	\N
11140	81	2	2014-12-07 16:17:17.103519	\N
11141	81	2	2014-12-07 16:17:17.10659	\N
11142	81	2	2014-12-07 16:17:17.108983	\N
11143	81	5	2014-12-07 16:17:17.111326	\N
11144	81	5	2014-12-07 16:17:17.113622	\N
11145	81	8	2014-12-07 16:17:17.115731	\N
11146	81	2	2014-12-07 16:17:17.117829	\N
11147	81	2	2014-12-07 16:17:17.119746	\N
11148	81	2	2014-12-07 16:17:17.121716	\N
11149	81	18	2014-12-07 16:17:17.123766	\N
11150	81	7	2014-12-07 16:17:17.125862	\N
11151	81	5	2014-12-07 16:17:17.127901	\N
11152	81	8	2014-12-07 16:17:17.130296	\N
11153	81	8	2014-12-07 16:17:17.132471	\N
11154	81	8	2014-12-07 16:17:17.134595	\N
11155	81	8	2014-12-07 16:17:17.136632	\N
11156	81	8	2014-12-07 16:17:17.138657	\N
11157	81	8	2014-12-07 16:17:17.140669	\N
11158	81	18	2014-12-07 16:17:17.142643	\N
11159	81	18	2014-12-07 16:17:17.144635	\N
11160	81	18	2014-12-07 16:17:17.14669	\N
11161	81	18	2014-12-07 16:17:17.148744	\N
11162	81	18	2014-12-07 16:17:17.151104	\N
11163	81	18	2014-12-07 16:17:17.153303	\N
11164	81	18	2014-12-07 16:17:17.155352	\N
11165	81	4	2014-12-07 16:17:17.157416	\N
11166	81	4	2014-12-07 16:17:17.159486	\N
11167	81	4	2014-12-07 16:17:17.161656	\N
11168	81	4	2014-12-07 16:17:17.163719	\N
11169	81	4	2014-12-07 16:17:17.165842	\N
11170	81	4	2014-12-07 16:17:17.167799	\N
11171	81	4	2014-12-07 16:17:17.169761	\N
11172	81	4	2014-12-07 16:17:17.171728	\N
11173	81	11	2014-12-07 16:17:17.173753	\N
11174	81	11	2014-12-07 16:17:17.175715	\N
11175	81	11	2014-12-07 16:17:17.177702	\N
11176	81	19	2014-12-07 16:17:17.180004	\N
11177	81	19	2014-12-07 16:17:17.182572	\N
11178	81	15	2014-12-07 16:17:17.18488	\N
11179	81	15	2014-12-07 16:17:17.18706	\N
11180	81	19	2014-12-07 16:17:17.18921	\N
11181	81	7	2014-12-07 16:17:17.19127	\N
11182	81	2	2014-12-07 16:17:17.193355	\N
11183	81	9	2014-12-07 16:17:17.195426	\N
11184	81	9	2014-12-07 16:17:17.19774	\N
11185	81	9	2014-12-07 16:17:17.199906	\N
11186	81	9	2014-12-07 16:17:17.202022	\N
11187	81	9	2014-12-07 16:17:17.20414	\N
11188	81	3	2014-12-07 16:17:17.206283	\N
11189	81	21	2014-12-07 16:17:17.208458	\N
11190	81	8	2014-12-07 16:17:17.210571	\N
11191	81	13	2014-12-07 16:17:17.212712	\N
11192	81	8	2014-12-07 16:17:17.215239	\N
11193	81	2	2014-12-07 16:17:17.217359	\N
11194	81	18	2014-12-07 16:17:17.219421	\N
11195	81	16	2014-12-07 16:17:17.221474	\N
11196	81	16	2014-12-07 16:17:17.223505	\N
11197	81	15	2014-12-07 16:17:17.225634	\N
11198	81	15	2014-12-07 16:17:17.227672	\N
11199	81	7	2014-12-07 16:17:17.229805	\N
11200	81	7	2014-12-07 16:17:17.232103	\N
11201	81	7	2014-12-07 16:17:17.234183	\N
11202	81	7	2014-12-07 16:17:17.236292	\N
11203	81	7	2014-12-07 16:17:17.238475	\N
11204	81	7	2014-12-07 16:17:17.241035	\N
11205	81	18	2014-12-07 16:17:17.243229	\N
11206	81	2	2014-12-07 16:17:17.245333	\N
11207	81	7	2014-12-07 16:17:17.247493	\N
11208	81	2	2014-12-07 16:17:17.249623	\N
11209	81	7	2014-12-07 16:17:17.251669	\N
11210	81	6	2014-12-07 16:17:17.253875	\N
11211	81	20	2014-12-07 16:17:17.256224	\N
11212	81	20	2014-12-07 16:17:17.258696	\N
11213	81	12	2014-12-07 16:17:17.260829	\N
11214	81	3	2014-12-07 16:17:17.262871	\N
11215	81	5	2014-12-07 16:17:17.265277	\N
11216	81	10	2014-12-07 16:17:17.267302	\N
11217	81	10	2014-12-07 16:17:17.269688	\N
11218	81	5	2014-12-07 16:17:17.271827	\N
11219	81	5	2014-12-07 16:17:17.273895	\N
11220	82	2	2014-12-07 16:17:17.359357	\N
11221	82	2	2014-12-07 16:17:17.362368	\N
11222	82	2	2014-12-07 16:17:17.3648	\N
11223	82	2	2014-12-07 16:17:17.367034	\N
11224	82	5	2014-12-07 16:17:17.369324	\N
11225	82	5	2014-12-07 16:17:17.371507	\N
11226	82	8	2014-12-07 16:17:17.373731	\N
11227	82	2	2014-12-07 16:17:17.375852	\N
11228	82	2	2014-12-07 16:17:17.378012	\N
11229	82	2	2014-12-07 16:17:17.380054	\N
11230	82	18	2014-12-07 16:17:17.382573	\N
11231	82	7	2014-12-07 16:17:17.38482	\N
11232	82	5	2014-12-07 16:17:17.386923	\N
11233	82	8	2014-12-07 16:17:17.388985	\N
11234	82	8	2014-12-07 16:17:17.391126	\N
11235	82	8	2014-12-07 16:17:17.393411	\N
11236	82	8	2014-12-07 16:17:17.395481	\N
11237	82	8	2014-12-07 16:17:17.397725	\N
11238	82	8	2014-12-07 16:17:17.399909	\N
11239	82	18	2014-12-07 16:17:17.401953	\N
11240	82	18	2014-12-07 16:17:17.403921	\N
11241	82	18	2014-12-07 16:17:17.405939	\N
11242	82	18	2014-12-07 16:17:17.407883	\N
11243	82	18	2014-12-07 16:17:17.409852	\N
11244	82	18	2014-12-07 16:17:17.411906	\N
11245	82	18	2014-12-07 16:17:17.41403	\N
11246	82	4	2014-12-07 16:17:17.416133	\N
11247	82	4	2014-12-07 16:17:17.418205	\N
11248	82	4	2014-12-07 16:17:17.42082	\N
11249	82	4	2014-12-07 16:17:17.422907	\N
11250	82	4	2014-12-07 16:17:17.424968	\N
11251	82	4	2014-12-07 16:17:17.426997	\N
11252	82	4	2014-12-07 16:17:17.42906	\N
11253	82	4	2014-12-07 16:17:17.431429	\N
11254	82	11	2014-12-07 16:17:17.433721	\N
11255	82	11	2014-12-07 16:17:17.43581	\N
11256	82	11	2014-12-07 16:17:17.437877	\N
11257	82	19	2014-12-07 16:17:17.440023	\N
11258	82	19	2014-12-07 16:17:17.442239	\N
11259	82	15	2014-12-07 16:17:17.444455	\N
11260	82	15	2014-12-07 16:17:17.446544	\N
11261	82	19	2014-12-07 16:17:17.448735	\N
11262	82	7	2014-12-07 16:17:17.450857	\N
11263	82	2	2014-12-07 16:17:17.452903	\N
11264	82	9	2014-12-07 16:17:17.454906	\N
11265	82	9	2014-12-07 16:17:17.456961	\N
11266	82	9	2014-12-07 16:17:17.459205	\N
11267	82	9	2014-12-07 16:17:17.461596	\N
11268	82	9	2014-12-07 16:17:17.463852	\N
11269	82	3	2014-12-07 16:17:17.466074	\N
11270	82	21	2014-12-07 16:17:17.468189	\N
11271	82	8	2014-12-07 16:17:17.47078	\N
11272	82	13	2014-12-07 16:17:17.473474	\N
11273	82	8	2014-12-07 16:17:17.475841	\N
11274	82	2	2014-12-07 16:17:17.479191	\N
11275	82	18	2014-12-07 16:17:17.482086	\N
11276	82	16	2014-12-07 16:17:17.485567	\N
11277	82	16	2014-12-07 16:17:17.48809	\N
11278	82	15	2014-12-07 16:17:17.490517	\N
11279	82	15	2014-12-07 16:17:17.492726	\N
11280	82	7	2014-12-07 16:17:17.494964	\N
11281	82	7	2014-12-07 16:17:17.49705	\N
11282	82	7	2014-12-07 16:17:17.499395	\N
11283	82	7	2014-12-07 16:17:17.501549	\N
11284	82	7	2014-12-07 16:17:17.503681	\N
11285	82	7	2014-12-07 16:17:17.505753	\N
11286	82	18	2014-12-07 16:17:17.507815	\N
11287	82	2	2014-12-07 16:17:17.509996	\N
11288	82	7	2014-12-07 16:17:17.512099	\N
11289	82	2	2014-12-07 16:17:17.514266	\N
11290	82	7	2014-12-07 16:17:17.516822	\N
11291	82	6	2014-12-07 16:17:17.519252	\N
11292	82	20	2014-12-07 16:17:17.521434	\N
11293	82	20	2014-12-07 16:17:17.524009	\N
11294	82	12	2014-12-07 16:17:17.526119	\N
11295	82	3	2014-12-07 16:17:17.528258	\N
11296	82	5	2014-12-07 16:17:17.531111	\N
11297	82	10	2014-12-07 16:17:17.533371	\N
11298	82	10	2014-12-07 16:17:17.535556	\N
11299	82	5	2014-12-07 16:17:17.537642	\N
11300	82	5	2014-12-07 16:17:17.539718	\N
11301	82	8	2014-12-07 16:17:17.541848	\N
11302	83	2	2014-12-07 16:17:17.630837	\N
11303	83	2	2014-12-07 16:17:17.633914	\N
11304	83	2	2014-12-07 16:17:17.636154	\N
11305	83	2	2014-12-07 16:17:17.638268	\N
11306	83	5	2014-12-07 16:17:17.640416	\N
11307	83	5	2014-12-07 16:17:17.64262	\N
11308	83	8	2014-12-07 16:17:17.644697	\N
11309	83	2	2014-12-07 16:17:17.646752	\N
11310	83	2	2014-12-07 16:17:17.649028	\N
11311	83	2	2014-12-07 16:17:17.651174	\N
11312	83	18	2014-12-07 16:17:17.653248	\N
11313	83	7	2014-12-07 16:17:17.655149	\N
11314	83	5	2014-12-07 16:17:17.657129	\N
11315	83	8	2014-12-07 16:17:17.659075	\N
11316	83	8	2014-12-07 16:17:17.661125	\N
11317	83	8	2014-12-07 16:17:17.663088	\N
11318	83	8	2014-12-07 16:17:17.665166	\N
11319	83	8	2014-12-07 16:17:17.667291	\N
11320	83	8	2014-12-07 16:17:17.669419	\N
11321	83	18	2014-12-07 16:17:17.671661	\N
11322	83	18	2014-12-07 16:17:17.673744	\N
11323	83	18	2014-12-07 16:17:17.675818	\N
11324	83	18	2014-12-07 16:17:17.677896	\N
11325	83	18	2014-12-07 16:17:17.680069	\N
11326	83	18	2014-12-07 16:17:17.682281	\N
11327	83	18	2014-12-07 16:17:17.684434	\N
11328	83	4	2014-12-07 16:17:17.686716	\N
11329	83	4	2014-12-07 16:17:17.689026	\N
11330	83	4	2014-12-07 16:17:17.69139	\N
11331	83	4	2014-12-07 16:17:17.693695	\N
11332	83	4	2014-12-07 16:17:17.695828	\N
11333	83	4	2014-12-07 16:17:17.698025	\N
11334	83	4	2014-12-07 16:17:17.700218	\N
11335	83	4	2014-12-07 16:17:17.702739	\N
11336	83	11	2014-12-07 16:17:17.70491	\N
11337	83	11	2014-12-07 16:17:17.706979	\N
11338	83	11	2014-12-07 16:17:17.709031	\N
11339	83	19	2014-12-07 16:17:17.711156	\N
11340	83	19	2014-12-07 16:17:17.713265	\N
11341	83	15	2014-12-07 16:17:17.715256	\N
11342	83	15	2014-12-07 16:17:17.71734	\N
11343	83	19	2014-12-07 16:17:17.719363	\N
11344	83	7	2014-12-07 16:17:17.7214	\N
11345	83	2	2014-12-07 16:17:17.7236	\N
11346	83	9	2014-12-07 16:17:17.726283	\N
11347	83	9	2014-12-07 16:17:17.728589	\N
11348	83	9	2014-12-07 16:17:17.73086	\N
11349	83	9	2014-12-07 16:17:17.733092	\N
11350	83	9	2014-12-07 16:17:17.735189	\N
11351	83	3	2014-12-07 16:17:17.73727	\N
11352	83	21	2014-12-07 16:17:17.739383	\N
11353	83	8	2014-12-07 16:17:17.742275	\N
11354	83	13	2014-12-07 16:17:17.744874	\N
11355	83	8	2014-12-07 16:17:17.747039	\N
11356	83	2	2014-12-07 16:17:17.749233	\N
11357	83	18	2014-12-07 16:17:17.751308	\N
11358	83	16	2014-12-07 16:17:17.753459	\N
11359	83	16	2014-12-07 16:17:17.756137	\N
11360	83	15	2014-12-07 16:17:17.759475	\N
11361	83	15	2014-12-07 16:17:17.763048	\N
11362	83	7	2014-12-07 16:17:17.765585	\N
11363	83	7	2014-12-07 16:17:17.768295	\N
11364	83	7	2014-12-07 16:17:17.770484	\N
11365	83	7	2014-12-07 16:17:17.772678	\N
11366	83	7	2014-12-07 16:17:17.774825	\N
11367	83	7	2014-12-07 16:17:17.776875	\N
11368	83	18	2014-12-07 16:17:17.77902	\N
11369	83	2	2014-12-07 16:17:17.781109	\N
11370	83	7	2014-12-07 16:17:17.783344	\N
11371	83	2	2014-12-07 16:17:17.785484	\N
11372	83	7	2014-12-07 16:17:17.787634	\N
11373	83	6	2014-12-07 16:17:17.789993	\N
11374	83	20	2014-12-07 16:17:17.792152	\N
11375	83	20	2014-12-07 16:17:17.79435	\N
11376	83	12	2014-12-07 16:17:17.796376	\N
11377	83	3	2014-12-07 16:17:17.798597	\N
11378	83	5	2014-12-07 16:17:17.801573	\N
11379	83	10	2014-12-07 16:17:17.804518	\N
11380	83	10	2014-12-07 16:17:17.806715	\N
11381	83	5	2014-12-07 16:17:17.808868	\N
11382	83	5	2014-12-07 16:17:17.811085	\N
11383	83	8	2014-12-07 16:17:17.813234	\N
11384	83	22	2014-12-07 16:17:17.815226	\N
11385	84	2	2014-12-07 16:17:19.688664	\N
11386	84	2	2014-12-07 16:17:19.691995	\N
11387	84	2	2014-12-07 16:17:19.694923	\N
11388	84	2	2014-12-07 16:17:19.697231	\N
11389	84	5	2014-12-07 16:17:19.699404	\N
11390	84	5	2014-12-07 16:17:19.701586	\N
11391	84	8	2014-12-07 16:17:19.703684	\N
11392	84	2	2014-12-07 16:17:19.705839	\N
11393	84	2	2014-12-07 16:17:19.707847	\N
11394	84	2	2014-12-07 16:17:19.709921	\N
11395	84	18	2014-12-07 16:17:19.712052	\N
11396	84	7	2014-12-07 16:17:19.714303	\N
11397	84	5	2014-12-07 16:17:19.716418	\N
11398	84	8	2014-12-07 16:17:19.718482	\N
11399	84	8	2014-12-07 16:17:19.720542	\N
11400	84	8	2014-12-07 16:17:19.72261	\N
11401	84	8	2014-12-07 16:17:19.72463	\N
11402	84	8	2014-12-07 16:17:19.726769	\N
11403	84	8	2014-12-07 16:17:19.728768	\N
11404	84	18	2014-12-07 16:17:19.730752	\N
11405	84	18	2014-12-07 16:17:19.732763	\N
11406	84	18	2014-12-07 16:17:19.734831	\N
11407	84	18	2014-12-07 16:17:19.736848	\N
11408	84	18	2014-12-07 16:17:19.739561	\N
11409	84	18	2014-12-07 16:17:19.742035	\N
11410	84	18	2014-12-07 16:17:19.744377	\N
11411	84	4	2014-12-07 16:17:19.746462	\N
11412	84	4	2014-12-07 16:17:19.748552	\N
11413	84	4	2014-12-07 16:17:19.750614	\N
11414	84	4	2014-12-07 16:17:19.752715	\N
11415	84	4	2014-12-07 16:17:19.754705	\N
11416	84	4	2014-12-07 16:17:19.756819	\N
11417	84	4	2014-12-07 16:17:19.758947	\N
11418	84	4	2014-12-07 16:17:19.761018	\N
11419	84	11	2014-12-07 16:17:19.763057	\N
11420	84	11	2014-12-07 16:17:19.765115	\N
11421	84	11	2014-12-07 16:17:19.767078	\N
11422	84	19	2014-12-07 16:17:19.769085	\N
11423	84	19	2014-12-07 16:17:19.771154	\N
11424	84	15	2014-12-07 16:17:19.773269	\N
11425	84	15	2014-12-07 16:17:19.7754	\N
11426	84	19	2014-12-07 16:17:19.777486	\N
11427	84	7	2014-12-07 16:17:19.779464	\N
11428	84	2	2014-12-07 16:17:19.781495	\N
11429	84	9	2014-12-07 16:17:19.783451	\N
11430	84	9	2014-12-07 16:17:19.785541	\N
11431	84	9	2014-12-07 16:17:19.787573	\N
11432	84	9	2014-12-07 16:17:19.789663	\N
11433	84	9	2014-12-07 16:17:19.791721	\N
11434	84	3	2014-12-07 16:17:19.793738	\N
11435	84	21	2014-12-07 16:17:19.795661	\N
11436	84	8	2014-12-07 16:17:19.797657	\N
11437	84	13	2014-12-07 16:17:19.799653	\N
11438	84	8	2014-12-07 16:17:19.801702	\N
11439	84	2	2014-12-07 16:17:19.80365	\N
11440	84	18	2014-12-07 16:17:19.805858	\N
11441	84	16	2014-12-07 16:17:19.808001	\N
11442	84	16	2014-12-07 16:17:19.810112	\N
11443	84	15	2014-12-07 16:17:19.812238	\N
11444	84	15	2014-12-07 16:17:19.814298	\N
11445	84	7	2014-12-07 16:17:19.816357	\N
11446	84	7	2014-12-07 16:17:19.818354	\N
11447	84	7	2014-12-07 16:17:19.820417	\N
11448	84	7	2014-12-07 16:17:19.82255	\N
11449	84	7	2014-12-07 16:17:19.824816	\N
11450	84	7	2014-12-07 16:17:19.826855	\N
11451	84	18	2014-12-07 16:17:19.828792	\N
11452	84	2	2014-12-07 16:17:19.830811	\N
11453	84	7	2014-12-07 16:17:19.832813	\N
11454	84	2	2014-12-07 16:17:19.834778	\N
11455	84	7	2014-12-07 16:17:19.836758	\N
11456	84	6	2014-12-07 16:17:19.838824	\N
11457	84	20	2014-12-07 16:17:19.84102	\N
11458	84	20	2014-12-07 16:17:19.843073	\N
11459	84	12	2014-12-07 16:17:19.845251	\N
11460	84	3	2014-12-07 16:17:19.847209	\N
11461	84	5	2014-12-07 16:17:19.849246	\N
11462	84	10	2014-12-07 16:17:19.851286	\N
11463	84	10	2014-12-07 16:17:19.853338	\N
11464	84	5	2014-12-07 16:17:19.855385	\N
11465	84	5	2014-12-07 16:17:19.857483	\N
11466	84	8	2014-12-07 16:17:19.859439	\N
11467	84	22	2014-12-07 16:17:19.861461	\N
11468	84	11	2014-12-07 16:17:19.863481	\N
11469	85	2	2014-12-07 16:17:19.953394	\N
11470	85	2	2014-12-07 16:17:19.956813	\N
11471	85	2	2014-12-07 16:17:19.961478	\N
11472	85	2	2014-12-07 16:17:19.963849	\N
11473	85	5	2014-12-07 16:17:19.966234	\N
11474	85	5	2014-12-07 16:17:19.96845	\N
11475	85	8	2014-12-07 16:17:19.970642	\N
11476	85	2	2014-12-07 16:17:19.972907	\N
11477	85	2	2014-12-07 16:17:19.974979	\N
11478	85	2	2014-12-07 16:17:19.976982	\N
11479	85	18	2014-12-07 16:17:19.979293	\N
11480	85	7	2014-12-07 16:17:19.981378	\N
11481	85	5	2014-12-07 16:17:19.98354	\N
11482	85	8	2014-12-07 16:17:19.985668	\N
11483	85	8	2014-12-07 16:17:19.987775	\N
11484	85	8	2014-12-07 16:17:19.989973	\N
11485	85	8	2014-12-07 16:17:19.992091	\N
11486	85	8	2014-12-07 16:17:19.994116	\N
11487	85	8	2014-12-07 16:17:19.996149	\N
11488	85	18	2014-12-07 16:17:19.998171	\N
11489	85	18	2014-12-07 16:17:20.000475	\N
11490	85	18	2014-12-07 16:17:20.002944	\N
11491	85	18	2014-12-07 16:17:20.005117	\N
11492	85	18	2014-12-07 16:17:20.007166	\N
11493	85	18	2014-12-07 16:17:20.009238	\N
11494	85	18	2014-12-07 16:17:20.011404	\N
11495	85	4	2014-12-07 16:17:20.013611	\N
11496	85	4	2014-12-07 16:17:20.015725	\N
11497	85	4	2014-12-07 16:17:20.017868	\N
11498	85	4	2014-12-07 16:17:20.019932	\N
11499	85	4	2014-12-07 16:17:20.021975	\N
11500	85	4	2014-12-07 16:17:20.024244	\N
11501	85	4	2014-12-07 16:17:20.026313	\N
11502	85	4	2014-12-07 16:17:20.028409	\N
11503	85	11	2014-12-07 16:17:20.030555	\N
11504	85	11	2014-12-07 16:17:20.032656	\N
11505	85	11	2014-12-07 16:17:20.034715	\N
11506	85	19	2014-12-07 16:17:20.036761	\N
11507	85	19	2014-12-07 16:17:20.038791	\N
11508	85	15	2014-12-07 16:17:20.04088	\N
11509	85	15	2014-12-07 16:17:20.043042	\N
11510	85	19	2014-12-07 16:17:20.045125	\N
11511	85	7	2014-12-07 16:17:20.047241	\N
11512	85	2	2014-12-07 16:17:20.049298	\N
11513	85	9	2014-12-07 16:17:20.051398	\N
11514	85	9	2014-12-07 16:17:20.053568	\N
11515	85	9	2014-12-07 16:17:20.055639	\N
11516	85	9	2014-12-07 16:17:20.057784	\N
11517	85	9	2014-12-07 16:17:20.059862	\N
11518	85	3	2014-12-07 16:17:20.061899	\N
11519	85	21	2014-12-07 16:17:20.06395	\N
11520	85	8	2014-12-07 16:17:20.065986	\N
11521	85	13	2014-12-07 16:17:20.068385	\N
11522	85	8	2014-12-07 16:17:20.070561	\N
11523	85	2	2014-12-07 16:17:20.072615	\N
11524	85	18	2014-12-07 16:17:20.074964	\N
11525	85	16	2014-12-07 16:17:20.07714	\N
11526	85	16	2014-12-07 16:17:20.079126	\N
11527	85	15	2014-12-07 16:17:20.081266	\N
11528	85	15	2014-12-07 16:17:20.083247	\N
11529	85	7	2014-12-07 16:17:20.085583	\N
11530	85	7	2014-12-07 16:17:20.08773	\N
11531	85	7	2014-12-07 16:17:20.089826	\N
11532	85	7	2014-12-07 16:17:20.092016	\N
11533	85	7	2014-12-07 16:17:20.094144	\N
11534	85	7	2014-12-07 16:17:20.096081	\N
11535	85	18	2014-12-07 16:17:20.098063	\N
11536	85	2	2014-12-07 16:17:20.100213	\N
11537	85	7	2014-12-07 16:17:20.102294	\N
11538	85	2	2014-12-07 16:17:20.104586	\N
11539	85	7	2014-12-07 16:17:20.106726	\N
11540	85	6	2014-12-07 16:17:20.108866	\N
11541	85	20	2014-12-07 16:17:20.110908	\N
11542	85	20	2014-12-07 16:17:20.112921	\N
11543	85	12	2014-12-07 16:17:20.114993	\N
11544	85	3	2014-12-07 16:17:20.117071	\N
11545	85	5	2014-12-07 16:17:20.119077	\N
11546	85	10	2014-12-07 16:17:20.121096	\N
11547	85	10	2014-12-07 16:17:20.123097	\N
11548	85	5	2014-12-07 16:17:20.12536	\N
11549	85	5	2014-12-07 16:17:20.127557	\N
11550	85	8	2014-12-07 16:17:20.12975	\N
11551	85	22	2014-12-07 16:17:20.131887	\N
11552	85	11	2014-12-07 16:17:20.134773	\N
11553	85	10	2014-12-07 16:17:20.13771	\N
11554	86	2	2014-12-07 16:17:21.2555	\N
11555	86	2	2014-12-07 16:17:21.258732	\N
11556	86	2	2014-12-07 16:17:21.261267	\N
11557	86	2	2014-12-07 16:17:21.263549	\N
11558	86	5	2014-12-07 16:17:21.265927	\N
11559	86	5	2014-12-07 16:17:21.268129	\N
11560	86	8	2014-12-07 16:17:21.270465	\N
11561	86	2	2014-12-07 16:17:21.272634	\N
11562	86	2	2014-12-07 16:17:21.274742	\N
11563	86	2	2014-12-07 16:17:21.276859	\N
11564	86	18	2014-12-07 16:17:21.279155	\N
11565	86	7	2014-12-07 16:17:21.281244	\N
11566	86	5	2014-12-07 16:17:21.283213	\N
11567	86	8	2014-12-07 16:17:21.285254	\N
11568	86	8	2014-12-07 16:17:21.287225	\N
11569	86	8	2014-12-07 16:17:21.289561	\N
11570	86	8	2014-12-07 16:17:21.291546	\N
11571	86	8	2014-12-07 16:17:21.293638	\N
11572	86	8	2014-12-07 16:17:21.295788	\N
11573	86	18	2014-12-07 16:17:21.297984	\N
11574	86	18	2014-12-07 16:17:21.300008	\N
11575	86	18	2014-12-07 16:17:21.302245	\N
11576	86	18	2014-12-07 16:17:21.304337	\N
11577	86	18	2014-12-07 16:17:21.306349	\N
11578	86	18	2014-12-07 16:17:21.308557	\N
11579	86	18	2014-12-07 16:17:21.310798	\N
11580	86	4	2014-12-07 16:17:21.313006	\N
11581	86	4	2014-12-07 16:17:21.315124	\N
11582	86	4	2014-12-07 16:17:21.317249	\N
11583	86	4	2014-12-07 16:17:21.319349	\N
11584	86	4	2014-12-07 16:17:21.321427	\N
11585	86	4	2014-12-07 16:17:21.323346	\N
11586	86	4	2014-12-07 16:17:21.325369	\N
11587	86	4	2014-12-07 16:17:21.32733	\N
11588	86	11	2014-12-07 16:17:21.329493	\N
11589	86	11	2014-12-07 16:17:21.331455	\N
11590	86	11	2014-12-07 16:17:21.333469	\N
11591	86	19	2014-12-07 16:17:21.335394	\N
11592	86	19	2014-12-07 16:17:21.338617	\N
11593	86	15	2014-12-07 16:17:21.342126	\N
11594	86	15	2014-12-07 16:17:21.345789	\N
11595	86	19	2014-12-07 16:17:21.348124	\N
11596	86	7	2014-12-07 16:17:21.350342	\N
11597	86	2	2014-12-07 16:17:21.352439	\N
11598	86	9	2014-12-07 16:17:21.354775	\N
11599	86	9	2014-12-07 16:17:21.357186	\N
11600	86	9	2014-12-07 16:17:21.359297	\N
11601	86	9	2014-12-07 16:17:21.362293	\N
11602	86	9	2014-12-07 16:17:21.364787	\N
11603	86	3	2014-12-07 16:17:21.366959	\N
11604	86	21	2014-12-07 16:17:21.369084	\N
11605	86	8	2014-12-07 16:17:21.371137	\N
11606	86	13	2014-12-07 16:17:21.373336	\N
11607	86	8	2014-12-07 16:17:21.375346	\N
11608	86	2	2014-12-07 16:17:21.37739	\N
11609	86	18	2014-12-07 16:17:21.379725	\N
11610	86	16	2014-12-07 16:17:21.382017	\N
11611	86	16	2014-12-07 16:17:21.384251	\N
11612	86	15	2014-12-07 16:17:21.386401	\N
11613	86	15	2014-12-07 16:17:21.388528	\N
11614	86	7	2014-12-07 16:17:21.390566	\N
11615	86	7	2014-12-07 16:17:21.392521	\N
11616	86	7	2014-12-07 16:17:21.39452	\N
11617	86	7	2014-12-07 16:17:21.396559	\N
11618	86	7	2014-12-07 16:17:21.39904	\N
11619	86	7	2014-12-07 16:17:21.401293	\N
11620	86	18	2014-12-07 16:17:21.403348	\N
11621	86	2	2014-12-07 16:17:21.405457	\N
11622	86	7	2014-12-07 16:17:21.4075	\N
11623	86	2	2014-12-07 16:17:21.409554	\N
11624	86	7	2014-12-07 16:17:21.411508	\N
11625	86	6	2014-12-07 16:17:21.413514	\N
11626	86	20	2014-12-07 16:17:21.415451	\N
11627	86	20	2014-12-07 16:17:21.417541	\N
11628	86	12	2014-12-07 16:17:21.419538	\N
11629	86	3	2014-12-07 16:17:21.421563	\N
11630	86	5	2014-12-07 16:17:21.423501	\N
11631	86	10	2014-12-07 16:17:21.425561	\N
11632	86	10	2014-12-07 16:17:21.427632	\N
11633	86	5	2014-12-07 16:17:21.429786	\N
11634	86	5	2014-12-07 16:17:21.432041	\N
11635	86	8	2014-12-07 16:17:21.434105	\N
11636	86	22	2014-12-07 16:17:21.436125	\N
11637	86	11	2014-12-07 16:17:21.438229	\N
11638	86	10	2014-12-07 16:17:21.440292	\N
11639	86	22	2014-12-07 16:17:21.442334	\N
11640	87	2	2014-12-07 16:17:21.573692	\N
11641	87	2	2014-12-07 16:17:21.576547	\N
11642	87	2	2014-12-07 16:17:21.578935	\N
11643	87	2	2014-12-07 16:17:21.581283	\N
11644	87	5	2014-12-07 16:17:21.583368	\N
11645	87	5	2014-12-07 16:17:21.585645	\N
11646	87	8	2014-12-07 16:17:21.587809	\N
11647	87	2	2014-12-07 16:17:21.590581	\N
11648	87	2	2014-12-07 16:17:21.592618	\N
11649	87	2	2014-12-07 16:17:21.594684	\N
11650	87	18	2014-12-07 16:17:21.596831	\N
11651	87	7	2014-12-07 16:17:21.598886	\N
11652	87	5	2014-12-07 16:17:21.600918	\N
11653	87	8	2014-12-07 16:17:21.603353	\N
11654	87	8	2014-12-07 16:17:21.605511	\N
11655	87	8	2014-12-07 16:17:21.607606	\N
11656	87	8	2014-12-07 16:17:21.609715	\N
11657	87	8	2014-12-07 16:17:21.611678	\N
11658	87	8	2014-12-07 16:17:21.613747	\N
11659	87	18	2014-12-07 16:17:21.615994	\N
11660	87	18	2014-12-07 16:17:21.618166	\N
11661	87	18	2014-12-07 16:17:21.620281	\N
11662	87	18	2014-12-07 16:17:21.622362	\N
11663	87	18	2014-12-07 16:17:21.624413	\N
11664	87	18	2014-12-07 16:17:21.626453	\N
11665	87	18	2014-12-07 16:17:21.62852	\N
11666	87	4	2014-12-07 16:17:21.630634	\N
11667	87	4	2014-12-07 16:17:21.632676	\N
11668	87	4	2014-12-07 16:17:21.634997	\N
11669	87	4	2014-12-07 16:17:21.637214	\N
11670	87	4	2014-12-07 16:17:21.639318	\N
11671	87	4	2014-12-07 16:17:21.641515	\N
11672	87	4	2014-12-07 16:17:21.643545	\N
11673	87	4	2014-12-07 16:17:21.64578	\N
11674	87	11	2014-12-07 16:17:21.647906	\N
11675	87	11	2014-12-07 16:17:21.650019	\N
11676	87	11	2014-12-07 16:17:21.652228	\N
11677	87	19	2014-12-07 16:17:21.654393	\N
11678	87	19	2014-12-07 16:17:21.656518	\N
11679	87	15	2014-12-07 16:17:21.658586	\N
11680	87	15	2014-12-07 16:17:21.66067	\N
11681	87	19	2014-12-07 16:17:21.663029	\N
11682	87	7	2014-12-07 16:17:21.665229	\N
11683	87	2	2014-12-07 16:17:21.667297	\N
11684	87	9	2014-12-07 16:17:21.669374	\N
11685	87	9	2014-12-07 16:17:21.671417	\N
11686	87	9	2014-12-07 16:17:21.673459	\N
11687	87	9	2014-12-07 16:17:21.675451	\N
11688	87	9	2014-12-07 16:17:21.677494	\N
11689	87	3	2014-12-07 16:17:21.679556	\N
11690	87	21	2014-12-07 16:17:21.68162	\N
11691	87	8	2014-12-07 16:17:21.683603	\N
11692	87	13	2014-12-07 16:17:21.685699	\N
11693	87	8	2014-12-07 16:17:21.68767	\N
11694	87	2	2014-12-07 16:17:21.689973	\N
11695	87	18	2014-12-07 16:17:21.691959	\N
11696	87	16	2014-12-07 16:17:21.694042	\N
11697	87	16	2014-12-07 16:17:21.696347	\N
11698	87	15	2014-12-07 16:17:21.698575	\N
11699	87	15	2014-12-07 16:17:21.700642	\N
11700	87	7	2014-12-07 16:17:21.702831	\N
11701	87	7	2014-12-07 16:17:21.704862	\N
11702	87	7	2014-12-07 16:17:21.706881	\N
11703	87	7	2014-12-07 16:17:21.708889	\N
11704	87	7	2014-12-07 16:17:21.71089	\N
11705	87	7	2014-12-07 16:17:21.712961	\N
11706	87	18	2014-12-07 16:17:21.714998	\N
11707	87	2	2014-12-07 16:17:21.717013	\N
11708	87	7	2014-12-07 16:17:21.719145	\N
11709	87	2	2014-12-07 16:17:21.721198	\N
11710	87	7	2014-12-07 16:17:21.723196	\N
11711	87	6	2014-12-07 16:17:21.725222	\N
11712	87	20	2014-12-07 16:17:21.7272	\N
11713	87	20	2014-12-07 16:17:21.729464	\N
11714	87	12	2014-12-07 16:17:21.731611	\N
11715	87	3	2014-12-07 16:17:21.733661	\N
11716	87	5	2014-12-07 16:17:21.735649	\N
11717	87	10	2014-12-07 16:17:21.738201	\N
11718	87	10	2014-12-07 16:17:21.74061	\N
11719	87	5	2014-12-07 16:17:21.742808	\N
11720	87	5	2014-12-07 16:17:21.744918	\N
11721	87	8	2014-12-07 16:17:21.747059	\N
11722	87	22	2014-12-07 16:17:21.74918	\N
11723	87	11	2014-12-07 16:17:21.751239	\N
11724	87	10	2014-12-07 16:17:21.753374	\N
11725	87	22	2014-12-07 16:17:21.755431	\N
11726	87	22	2014-12-07 16:17:21.757535	\N
11727	88	2	2014-12-07 16:17:21.854739	\N
11728	88	2	2014-12-07 16:17:21.857711	\N
11729	88	2	2014-12-07 16:17:21.859813	\N
11730	88	2	2014-12-07 16:17:21.862086	\N
11731	88	5	2014-12-07 16:17:21.864453	\N
11732	88	5	2014-12-07 16:17:21.866674	\N
11733	88	8	2014-12-07 16:17:21.868817	\N
11734	88	2	2014-12-07 16:17:21.871052	\N
11735	88	2	2014-12-07 16:17:21.873175	\N
11736	88	2	2014-12-07 16:17:21.875313	\N
11737	88	18	2014-12-07 16:17:21.877401	\N
11738	88	7	2014-12-07 16:17:21.879528	\N
11739	88	5	2014-12-07 16:17:21.881716	\N
11740	88	8	2014-12-07 16:17:21.883799	\N
11741	88	8	2014-12-07 16:17:21.885836	\N
11742	88	8	2014-12-07 16:17:21.887873	\N
11743	88	8	2014-12-07 16:17:21.889963	\N
11744	88	8	2014-12-07 16:17:21.891932	\N
11745	88	8	2014-12-07 16:17:21.893986	\N
11746	88	18	2014-12-07 16:17:21.895985	\N
11747	88	18	2014-12-07 16:17:21.898161	\N
11748	88	18	2014-12-07 16:17:21.900269	\N
11749	88	18	2014-12-07 16:17:21.9025	\N
11750	88	18	2014-12-07 16:17:21.904645	\N
11751	88	18	2014-12-07 16:17:21.906716	\N
11752	88	18	2014-12-07 16:17:21.908846	\N
11753	88	4	2014-12-07 16:17:21.910893	\N
11754	88	4	2014-12-07 16:17:21.913135	\N
11755	88	4	2014-12-07 16:17:21.915248	\N
11756	88	4	2014-12-07 16:17:21.917348	\N
11757	88	4	2014-12-07 16:17:21.919548	\N
11758	88	4	2014-12-07 16:17:21.921701	\N
11759	88	4	2014-12-07 16:17:21.923756	\N
11760	88	4	2014-12-07 16:17:21.925783	\N
11761	88	11	2014-12-07 16:17:21.928057	\N
11762	88	11	2014-12-07 16:17:21.930277	\N
11763	88	11	2014-12-07 16:17:21.932501	\N
11764	88	19	2014-12-07 16:17:21.934581	\N
11765	88	19	2014-12-07 16:17:21.936658	\N
11766	88	15	2014-12-07 16:17:21.939044	\N
11767	88	15	2014-12-07 16:17:21.94317	\N
11768	88	19	2014-12-07 16:17:21.946741	\N
11769	88	7	2014-12-07 16:17:21.949591	\N
11770	88	2	2014-12-07 16:17:21.951843	\N
11771	88	9	2014-12-07 16:17:21.95397	\N
11772	88	9	2014-12-07 16:17:21.956063	\N
11773	88	9	2014-12-07 16:17:21.958176	\N
11774	88	9	2014-12-07 16:17:21.960529	\N
11775	88	9	2014-12-07 16:17:21.962707	\N
11776	88	3	2014-12-07 16:17:21.964991	\N
11777	88	21	2014-12-07 16:17:21.967116	\N
11778	88	8	2014-12-07 16:17:21.969231	\N
11779	88	13	2014-12-07 16:17:21.971276	\N
11780	88	8	2014-12-07 16:17:21.973455	\N
11781	88	2	2014-12-07 16:17:21.975578	\N
11782	88	18	2014-12-07 16:17:21.977787	\N
11783	88	16	2014-12-07 16:17:21.979933	\N
11784	88	16	2014-12-07 16:17:21.982063	\N
11785	88	15	2014-12-07 16:17:21.984134	\N
11786	88	15	2014-12-07 16:17:21.986238	\N
11787	88	7	2014-12-07 16:17:21.988367	\N
11788	88	7	2014-12-07 16:17:21.990523	\N
11789	88	7	2014-12-07 16:17:21.992624	\N
11790	88	7	2014-12-07 16:17:21.994669	\N
11791	88	7	2014-12-07 16:17:21.996886	\N
11792	88	7	2014-12-07 16:17:21.998992	\N
11793	88	18	2014-12-07 16:17:22.001246	\N
11794	88	2	2014-12-07 16:17:22.003883	\N
11795	88	7	2014-12-07 16:17:22.00618	\N
11796	88	2	2014-12-07 16:17:22.008326	\N
11797	88	7	2014-12-07 16:17:22.010513	\N
11798	88	6	2014-12-07 16:17:22.012595	\N
11799	88	20	2014-12-07 16:17:22.015051	\N
11800	88	20	2014-12-07 16:17:22.017111	\N
11801	88	12	2014-12-07 16:17:22.019059	\N
11802	88	3	2014-12-07 16:17:22.02108	\N
11803	88	5	2014-12-07 16:17:22.023002	\N
11804	88	10	2014-12-07 16:17:22.025061	\N
11805	88	10	2014-12-07 16:17:22.027266	\N
11806	88	5	2014-12-07 16:17:22.029576	\N
11807	88	5	2014-12-07 16:17:22.03181	\N
11808	88	8	2014-12-07 16:17:22.033921	\N
11809	88	22	2014-12-07 16:17:22.035949	\N
11810	88	11	2014-12-07 16:17:22.03812	\N
11811	88	10	2014-12-07 16:17:22.040195	\N
11812	88	22	2014-12-07 16:17:22.04224	\N
11813	88	22	2014-12-07 16:17:22.044297	\N
11814	88	22	2014-12-07 16:17:22.04642	\N
11815	89	2	2014-12-07 16:17:22.919796	\N
11816	89	2	2014-12-07 16:17:22.923018	\N
11817	89	2	2014-12-07 16:17:22.925968	\N
11818	89	2	2014-12-07 16:17:22.928172	\N
11819	89	5	2014-12-07 16:17:22.930683	\N
11820	89	5	2014-12-07 16:17:22.932995	\N
11821	89	8	2014-12-07 16:17:22.93522	\N
11822	89	2	2014-12-07 16:17:22.937307	\N
11823	89	2	2014-12-07 16:17:22.939222	\N
11824	89	2	2014-12-07 16:17:22.941424	\N
11825	89	18	2014-12-07 16:17:22.943732	\N
11826	89	7	2014-12-07 16:17:22.945988	\N
11827	89	5	2014-12-07 16:17:22.948205	\N
11828	89	8	2014-12-07 16:17:22.950452	\N
11829	89	8	2014-12-07 16:17:22.952557	\N
11830	89	8	2014-12-07 16:17:22.954731	\N
11831	89	8	2014-12-07 16:17:22.95676	\N
11832	89	8	2014-12-07 16:17:22.958785	\N
11833	89	8	2014-12-07 16:17:22.96103	\N
11834	89	18	2014-12-07 16:17:22.9632	\N
11835	89	18	2014-12-07 16:17:22.965219	\N
11836	89	18	2014-12-07 16:17:22.967318	\N
11837	89	18	2014-12-07 16:17:22.969468	\N
11838	89	18	2014-12-07 16:17:22.971714	\N
11839	89	18	2014-12-07 16:17:22.973937	\N
11840	89	18	2014-12-07 16:17:22.976085	\N
11841	89	4	2014-12-07 16:17:22.978122	\N
11842	89	4	2014-12-07 16:17:22.980202	\N
11843	89	4	2014-12-07 16:17:22.982272	\N
11844	89	4	2014-12-07 16:17:22.984354	\N
11845	89	4	2014-12-07 16:17:22.986429	\N
11846	89	4	2014-12-07 16:17:22.988496	\N
11847	89	4	2014-12-07 16:17:22.99065	\N
11848	89	4	2014-12-07 16:17:22.992914	\N
11849	89	11	2014-12-07 16:17:22.994979	\N
11850	89	11	2014-12-07 16:17:22.997083	\N
11851	89	11	2014-12-07 16:17:22.999024	\N
11852	89	19	2014-12-07 16:17:23.001241	\N
11853	89	19	2014-12-07 16:17:23.003727	\N
11854	89	15	2014-12-07 16:17:23.00601	\N
11855	89	15	2014-12-07 16:17:23.008128	\N
11856	89	19	2014-12-07 16:17:23.010221	\N
11857	89	7	2014-12-07 16:17:23.012275	\N
11858	89	2	2014-12-07 16:17:23.014338	\N
11859	89	9	2014-12-07 16:17:23.016404	\N
11860	89	9	2014-12-07 16:17:23.018521	\N
11861	89	9	2014-12-07 16:17:23.02059	\N
11862	89	9	2014-12-07 16:17:23.022769	\N
11863	89	9	2014-12-07 16:17:23.02485	\N
11864	89	3	2014-12-07 16:17:23.026935	\N
11865	89	21	2014-12-07 16:17:23.029059	\N
11866	89	8	2014-12-07 16:17:23.0311	\N
11867	89	13	2014-12-07 16:17:23.033135	\N
11868	89	8	2014-12-07 16:17:23.035157	\N
11869	89	2	2014-12-07 16:17:23.037139	\N
11870	89	18	2014-12-07 16:17:23.039269	\N
11871	89	16	2014-12-07 16:17:23.041478	\N
11872	89	16	2014-12-07 16:17:23.043711	\N
11873	89	15	2014-12-07 16:17:23.045847	\N
11874	89	15	2014-12-07 16:17:23.047904	\N
11875	89	7	2014-12-07 16:17:23.050085	\N
11876	89	7	2014-12-07 16:17:23.052282	\N
11877	89	7	2014-12-07 16:17:23.054387	\N
11878	89	7	2014-12-07 16:17:23.056412	\N
11879	89	7	2014-12-07 16:17:23.058457	\N
11880	89	7	2014-12-07 16:17:23.060468	\N
11881	89	18	2014-12-07 16:17:23.062511	\N
11882	89	2	2014-12-07 16:17:23.064635	\N
11883	89	7	2014-12-07 16:17:23.066748	\N
11884	89	2	2014-12-07 16:17:23.068871	\N
11885	89	7	2014-12-07 16:17:23.071102	\N
11886	89	6	2014-12-07 16:17:23.073177	\N
11887	89	20	2014-12-07 16:17:23.075129	\N
11888	89	20	2014-12-07 16:17:23.077251	\N
11889	89	12	2014-12-07 16:17:23.079219	\N
11890	89	3	2014-12-07 16:17:23.081233	\N
11891	89	5	2014-12-07 16:17:23.083188	\N
11892	89	10	2014-12-07 16:17:23.085244	\N
11893	89	10	2014-12-07 16:17:23.087243	\N
11894	89	5	2014-12-07 16:17:23.089388	\N
11895	89	5	2014-12-07 16:17:23.091384	\N
11896	89	8	2014-12-07 16:17:23.093541	\N
11897	89	22	2014-12-07 16:17:23.095614	\N
11898	89	11	2014-12-07 16:17:23.097645	\N
11899	89	10	2014-12-07 16:17:23.099707	\N
11900	89	22	2014-12-07 16:17:23.102053	\N
11901	89	22	2014-12-07 16:17:23.10429	\N
11902	89	22	2014-12-07 16:17:23.106357	\N
11903	89	20	2014-12-07 16:17:23.108424	\N
11904	90	2	2014-12-07 16:17:23.299857	\N
11905	90	2	2014-12-07 16:17:23.303457	\N
11906	90	2	2014-12-07 16:17:23.306031	\N
11907	90	2	2014-12-07 16:17:23.308157	\N
11908	90	5	2014-12-07 16:17:23.310391	\N
11909	90	5	2014-12-07 16:17:23.312548	\N
11910	90	8	2014-12-07 16:17:23.314572	\N
11911	90	2	2014-12-07 16:17:23.316654	\N
11912	90	2	2014-12-07 16:17:23.318764	\N
11913	90	2	2014-12-07 16:17:23.320917	\N
11914	90	18	2014-12-07 16:17:23.322879	\N
11915	90	7	2014-12-07 16:17:23.324996	\N
11916	90	5	2014-12-07 16:17:23.327013	\N
11917	90	8	2014-12-07 16:17:23.329056	\N
11918	90	8	2014-12-07 16:17:23.33111	\N
11919	90	8	2014-12-07 16:17:23.333184	\N
11920	90	8	2014-12-07 16:17:23.335125	\N
11921	90	8	2014-12-07 16:17:23.337327	\N
11922	90	8	2014-12-07 16:17:23.339475	\N
11923	90	18	2014-12-07 16:17:23.341552	\N
11924	90	18	2014-12-07 16:17:23.343604	\N
11925	90	18	2014-12-07 16:17:23.345618	\N
11926	90	18	2014-12-07 16:17:23.347527	\N
11927	90	18	2014-12-07 16:17:23.349738	\N
11928	90	18	2014-12-07 16:17:23.352083	\N
11929	90	18	2014-12-07 16:17:23.354212	\N
11930	90	4	2014-12-07 16:17:23.356272	\N
11931	90	4	2014-12-07 16:17:23.358366	\N
11932	90	4	2014-12-07 16:17:23.36038	\N
11933	90	4	2014-12-07 16:17:23.362456	\N
11934	90	4	2014-12-07 16:17:23.364443	\N
11935	90	4	2014-12-07 16:17:23.366486	\N
11936	90	4	2014-12-07 16:17:23.369097	\N
11937	90	4	2014-12-07 16:17:23.371226	\N
11938	90	11	2014-12-07 16:17:23.373293	\N
11939	90	11	2014-12-07 16:17:23.375317	\N
11940	90	11	2014-12-07 16:17:23.377393	\N
11941	90	19	2014-12-07 16:17:23.379456	\N
11942	90	19	2014-12-07 16:17:23.382155	\N
11943	90	15	2014-12-07 16:17:23.384287	\N
11944	90	15	2014-12-07 16:17:23.386399	\N
11945	90	19	2014-12-07 16:17:23.388406	\N
11946	90	7	2014-12-07 16:17:23.390504	\N
11947	90	2	2014-12-07 16:17:23.392583	\N
11948	90	9	2014-12-07 16:17:23.394656	\N
11949	90	9	2014-12-07 16:17:23.39672	\N
11950	90	9	2014-12-07 16:17:23.398778	\N
11951	90	9	2014-12-07 16:17:23.400861	\N
11952	90	9	2014-12-07 16:17:23.403109	\N
11953	90	3	2014-12-07 16:17:23.405331	\N
11954	90	21	2014-12-07 16:17:23.407313	\N
11955	90	8	2014-12-07 16:17:23.409348	\N
11956	90	13	2014-12-07 16:17:23.411298	\N
11957	90	8	2014-12-07 16:17:23.413461	\N
11958	90	2	2014-12-07 16:17:23.415495	\N
11959	90	18	2014-12-07 16:17:23.417506	\N
11960	90	16	2014-12-07 16:17:23.419679	\N
11961	90	16	2014-12-07 16:17:23.421749	\N
11962	90	15	2014-12-07 16:17:23.423867	\N
11963	90	15	2014-12-07 16:17:23.426235	\N
11964	90	7	2014-12-07 16:17:23.451832	\N
11965	90	7	2014-12-07 16:17:23.454091	\N
11966	90	7	2014-12-07 16:17:23.456128	\N
11967	90	7	2014-12-07 16:17:23.458852	\N
11968	90	7	2014-12-07 16:17:23.461373	\N
11969	90	7	2014-12-07 16:17:23.464679	\N
11970	90	18	2014-12-07 16:17:23.467344	\N
11971	90	2	2014-12-07 16:17:23.469918	\N
11972	90	7	2014-12-07 16:17:23.472299	\N
11973	90	2	2014-12-07 16:17:23.475108	\N
11974	90	7	2014-12-07 16:17:23.477667	\N
11975	90	6	2014-12-07 16:17:23.479755	\N
11976	90	20	2014-12-07 16:17:23.48184	\N
11977	90	20	2014-12-07 16:17:23.483876	\N
11978	90	12	2014-12-07 16:17:23.485952	\N
11979	90	3	2014-12-07 16:17:23.487888	\N
11980	90	5	2014-12-07 16:17:23.48995	\N
11981	90	10	2014-12-07 16:17:23.49198	\N
11982	90	10	2014-12-07 16:17:23.494143	\N
11983	90	5	2014-12-07 16:17:23.496374	\N
11984	90	5	2014-12-07 16:17:23.49847	\N
11985	90	8	2014-12-07 16:17:23.500584	\N
11986	90	22	2014-12-07 16:17:23.502705	\N
11987	90	11	2014-12-07 16:17:23.505027	\N
11988	90	10	2014-12-07 16:17:23.507157	\N
11989	90	22	2014-12-07 16:17:23.509228	\N
11990	90	22	2014-12-07 16:17:23.511387	\N
11991	90	22	2014-12-07 16:17:23.513442	\N
11992	90	20	2014-12-07 16:17:23.51543	\N
11993	90	20	2014-12-07 16:17:23.517479	\N
11994	91	2	2014-12-07 16:17:24.552741	\N
11995	91	2	2014-12-07 16:17:24.55619	\N
11996	91	2	2014-12-07 16:17:24.558854	\N
11997	91	2	2014-12-07 16:17:24.561197	\N
11998	91	5	2014-12-07 16:17:24.563697	\N
11999	91	5	2014-12-07 16:17:24.565939	\N
12000	91	8	2014-12-07 16:17:24.568179	\N
12001	91	2	2014-12-07 16:17:24.570546	\N
12002	91	2	2014-12-07 16:17:24.573208	\N
12003	91	2	2014-12-07 16:17:24.57547	\N
12004	91	18	2014-12-07 16:17:24.577572	\N
12005	91	7	2014-12-07 16:17:24.580442	\N
12006	91	5	2014-12-07 16:17:24.582599	\N
12007	91	8	2014-12-07 16:17:24.584799	\N
12008	91	8	2014-12-07 16:17:24.586959	\N
12009	91	8	2014-12-07 16:17:24.589136	\N
12010	91	8	2014-12-07 16:17:24.591406	\N
12011	91	8	2014-12-07 16:17:24.593563	\N
12012	91	8	2014-12-07 16:17:24.595685	\N
12013	91	18	2014-12-07 16:17:24.597736	\N
12014	91	18	2014-12-07 16:17:24.599859	\N
12015	91	18	2014-12-07 16:17:24.602348	\N
12016	91	18	2014-12-07 16:17:24.604741	\N
12017	91	18	2014-12-07 16:17:24.607045	\N
12018	91	18	2014-12-07 16:17:24.609283	\N
12019	91	18	2014-12-07 16:17:24.611376	\N
12020	91	4	2014-12-07 16:17:24.613501	\N
12021	91	4	2014-12-07 16:17:24.615571	\N
12022	91	4	2014-12-07 16:17:24.617847	\N
12023	91	4	2014-12-07 16:17:24.619898	\N
12024	91	4	2014-12-07 16:17:24.621962	\N
12025	91	4	2014-12-07 16:17:24.624384	\N
12026	91	4	2014-12-07 16:17:24.626508	\N
12027	91	4	2014-12-07 16:17:24.628567	\N
12028	91	11	2014-12-07 16:17:24.630612	\N
12029	91	11	2014-12-07 16:17:24.632713	\N
12030	91	11	2014-12-07 16:17:24.634792	\N
12031	91	19	2014-12-07 16:17:24.636832	\N
12032	91	19	2014-12-07 16:17:24.638883	\N
12033	91	15	2014-12-07 16:17:24.64103	\N
12034	91	15	2014-12-07 16:17:24.643083	\N
12035	91	19	2014-12-07 16:17:24.645164	\N
12036	91	7	2014-12-07 16:17:24.647202	\N
12037	91	2	2014-12-07 16:17:24.64932	\N
12038	91	9	2014-12-07 16:17:24.651361	\N
12039	91	9	2014-12-07 16:17:24.65343	\N
12040	91	9	2014-12-07 16:17:24.655548	\N
12041	91	9	2014-12-07 16:17:24.65768	\N
12042	91	9	2014-12-07 16:17:24.659658	\N
12043	91	3	2014-12-07 16:17:24.661624	\N
12044	91	21	2014-12-07 16:17:24.663622	\N
12045	91	8	2014-12-07 16:17:24.665664	\N
12046	91	13	2014-12-07 16:17:24.667979	\N
12047	91	8	2014-12-07 16:17:24.670097	\N
12048	91	2	2014-12-07 16:17:24.672393	\N
12049	91	18	2014-12-07 16:17:24.674625	\N
12050	91	16	2014-12-07 16:17:24.676661	\N
12051	91	16	2014-12-07 16:17:24.678904	\N
12052	91	15	2014-12-07 16:17:24.681053	\N
12053	91	15	2014-12-07 16:17:24.683098	\N
12054	91	7	2014-12-07 16:17:24.685183	\N
12055	91	7	2014-12-07 16:17:24.68712	\N
12056	91	7	2014-12-07 16:17:24.689227	\N
12057	91	7	2014-12-07 16:17:24.691295	\N
12058	91	7	2014-12-07 16:17:24.693395	\N
12059	91	7	2014-12-07 16:17:24.69539	\N
12060	91	18	2014-12-07 16:17:24.697438	\N
12061	91	2	2014-12-07 16:17:24.699645	\N
12062	91	7	2014-12-07 16:17:24.701756	\N
12063	91	2	2014-12-07 16:17:24.703708	\N
12064	91	7	2014-12-07 16:17:24.70594	\N
12065	91	6	2014-12-07 16:17:24.707956	\N
12066	91	20	2014-12-07 16:17:24.709989	\N
12067	91	20	2014-12-07 16:17:24.712032	\N
12068	91	12	2014-12-07 16:17:24.714127	\N
12069	91	3	2014-12-07 16:17:24.716296	\N
12070	91	5	2014-12-07 16:17:24.718451	\N
12071	91	10	2014-12-07 16:17:24.720531	\N
12072	91	10	2014-12-07 16:17:24.722655	\N
12073	91	5	2014-12-07 16:17:24.724765	\N
12074	91	5	2014-12-07 16:17:24.726784	\N
12075	91	8	2014-12-07 16:17:24.728986	\N
12076	91	22	2014-12-07 16:17:24.731123	\N
12077	91	11	2014-12-07 16:17:24.733227	\N
12078	91	10	2014-12-07 16:17:24.735289	\N
12079	91	22	2014-12-07 16:17:24.737791	\N
12080	91	22	2014-12-07 16:17:24.740083	\N
12081	91	22	2014-12-07 16:17:24.742378	\N
12082	91	20	2014-12-07 16:17:24.744481	\N
12083	91	20	2014-12-07 16:17:24.7466	\N
12084	91	20	2014-12-07 16:17:24.748655	\N
12085	92	2	2014-12-07 16:17:24.979136	\N
12086	92	2	2014-12-07 16:17:24.98257	\N
12087	92	2	2014-12-07 16:17:24.98546	\N
12088	92	2	2014-12-07 16:17:24.987816	\N
12089	92	5	2014-12-07 16:17:24.990084	\N
12090	92	5	2014-12-07 16:17:24.992372	\N
12091	92	8	2014-12-07 16:17:24.994601	\N
12092	92	2	2014-12-07 16:17:24.996708	\N
12093	92	2	2014-12-07 16:17:24.998819	\N
12094	92	2	2014-12-07 16:17:25.000935	\N
12095	92	18	2014-12-07 16:17:25.003308	\N
12096	92	7	2014-12-07 16:17:25.005971	\N
12097	92	5	2014-12-07 16:17:25.008426	\N
12098	92	8	2014-12-07 16:17:25.01063	\N
12099	92	8	2014-12-07 16:17:25.012925	\N
12100	92	8	2014-12-07 16:17:25.014982	\N
12101	92	8	2014-12-07 16:17:25.017013	\N
12102	92	8	2014-12-07 16:17:25.018929	\N
12103	92	8	2014-12-07 16:17:25.020968	\N
12104	92	18	2014-12-07 16:17:25.022979	\N
12105	92	18	2014-12-07 16:17:25.02507	\N
12106	92	18	2014-12-07 16:17:25.027267	\N
12107	92	18	2014-12-07 16:17:25.029497	\N
12108	92	18	2014-12-07 16:17:25.031637	\N
12109	92	18	2014-12-07 16:17:25.033741	\N
12110	92	18	2014-12-07 16:17:25.035796	\N
12111	92	4	2014-12-07 16:17:25.037923	\N
12112	92	4	2014-12-07 16:17:25.039946	\N
12113	92	4	2014-12-07 16:17:25.042095	\N
12114	92	4	2014-12-07 16:17:25.04407	\N
12115	92	4	2014-12-07 16:17:25.046067	\N
12116	92	4	2014-12-07 16:17:25.048018	\N
12117	92	4	2014-12-07 16:17:25.050039	\N
12118	92	4	2014-12-07 16:17:25.052111	\N
12119	92	11	2014-12-07 16:17:25.054101	\N
12120	92	11	2014-12-07 16:17:25.056113	\N
12121	92	11	2014-12-07 16:17:25.058203	\N
12122	92	19	2014-12-07 16:17:25.060327	\N
12123	92	19	2014-12-07 16:17:25.062709	\N
12124	92	15	2014-12-07 16:17:25.064798	\N
12125	92	15	2014-12-07 16:17:25.066916	\N
12126	92	19	2014-12-07 16:17:25.068934	\N
12127	92	7	2014-12-07 16:17:25.071094	\N
12128	92	2	2014-12-07 16:17:25.073152	\N
12129	92	9	2014-12-07 16:17:25.075417	\N
12130	92	9	2014-12-07 16:17:25.077587	\N
12131	92	9	2014-12-07 16:17:25.079757	\N
12132	92	9	2014-12-07 16:17:25.0819	\N
12133	92	9	2014-12-07 16:17:25.083998	\N
12134	92	3	2014-12-07 16:17:25.086078	\N
12135	92	21	2014-12-07 16:17:25.088083	\N
12136	92	8	2014-12-07 16:17:25.090136	\N
12137	92	13	2014-12-07 16:17:25.092203	\N
12138	92	8	2014-12-07 16:17:25.094316	\N
12139	92	2	2014-12-07 16:17:25.096504	\N
12140	92	18	2014-12-07 16:17:25.098567	\N
12141	92	16	2014-12-07 16:17:25.100938	\N
12142	92	16	2014-12-07 16:17:25.103199	\N
12143	92	15	2014-12-07 16:17:25.105388	\N
12144	92	15	2014-12-07 16:17:25.107668	\N
12145	92	7	2014-12-07 16:17:25.109743	\N
12146	92	7	2014-12-07 16:17:25.111859	\N
12147	92	7	2014-12-07 16:17:25.114091	\N
12148	92	7	2014-12-07 16:17:25.116313	\N
12149	92	7	2014-12-07 16:17:25.118584	\N
12150	92	7	2014-12-07 16:17:25.120755	\N
12151	92	18	2014-12-07 16:17:25.122852	\N
12152	92	2	2014-12-07 16:17:25.125006	\N
12153	92	7	2014-12-07 16:17:25.127061	\N
12154	92	2	2014-12-07 16:17:25.129035	\N
12155	92	7	2014-12-07 16:17:25.131014	\N
12156	92	6	2014-12-07 16:17:25.133153	\N
12157	92	20	2014-12-07 16:17:25.135107	\N
12158	92	20	2014-12-07 16:17:25.13718	\N
12159	92	12	2014-12-07 16:17:25.139311	\N
12160	92	3	2014-12-07 16:17:25.141621	\N
12161	92	5	2014-12-07 16:17:25.143716	\N
12162	92	10	2014-12-07 16:17:25.145831	\N
12163	92	10	2014-12-07 16:17:25.148062	\N
12164	92	5	2014-12-07 16:17:25.15018	\N
12165	92	5	2014-12-07 16:17:25.152226	\N
12166	92	8	2014-12-07 16:17:25.154268	\N
12167	92	22	2014-12-07 16:17:25.156248	\N
12168	92	11	2014-12-07 16:17:25.158397	\N
12169	92	10	2014-12-07 16:17:25.160516	\N
12170	92	22	2014-12-07 16:17:25.162571	\N
12171	92	22	2014-12-07 16:17:25.164815	\N
12172	92	22	2014-12-07 16:17:25.166869	\N
12173	92	20	2014-12-07 16:17:25.168998	\N
12174	92	20	2014-12-07 16:17:25.171162	\N
12175	92	20	2014-12-07 16:17:25.173274	\N
12176	92	20	2014-12-07 16:17:25.17528	\N
12177	93	2	2014-12-07 16:17:26.95334	\N
12178	93	2	2014-12-07 16:17:26.956594	\N
12179	93	2	2014-12-07 16:17:26.959488	\N
12180	93	2	2014-12-07 16:17:26.961656	\N
12181	93	5	2014-12-07 16:17:26.964135	\N
12182	93	5	2014-12-07 16:17:26.966461	\N
12183	93	8	2014-12-07 16:17:26.968625	\N
12184	93	2	2014-12-07 16:17:26.970771	\N
12185	93	2	2014-12-07 16:17:26.972837	\N
12186	93	2	2014-12-07 16:17:26.9749	\N
12187	93	18	2014-12-07 16:17:26.977821	\N
12188	93	7	2014-12-07 16:17:26.980243	\N
12189	93	5	2014-12-07 16:17:26.982416	\N
12190	93	8	2014-12-07 16:17:26.984474	\N
12191	93	8	2014-12-07 16:17:26.986511	\N
12192	93	8	2014-12-07 16:17:26.988543	\N
12193	93	8	2014-12-07 16:17:26.990585	\N
12194	93	8	2014-12-07 16:17:26.99283	\N
12195	93	8	2014-12-07 16:17:26.99501	\N
12196	93	18	2014-12-07 16:17:26.997091	\N
12197	93	18	2014-12-07 16:17:26.999128	\N
12198	93	18	2014-12-07 16:17:27.001165	\N
12199	93	18	2014-12-07 16:17:27.003237	\N
12200	93	18	2014-12-07 16:17:27.005617	\N
12201	93	18	2014-12-07 16:17:27.008182	\N
12202	93	18	2014-12-07 16:17:27.010388	\N
12203	93	4	2014-12-07 16:17:27.012573	\N
12204	93	4	2014-12-07 16:17:27.014738	\N
12205	93	4	2014-12-07 16:17:27.016891	\N
12206	93	4	2014-12-07 16:17:27.018945	\N
12207	93	4	2014-12-07 16:17:27.021019	\N
12208	93	4	2014-12-07 16:17:27.023165	\N
12209	93	4	2014-12-07 16:17:27.02528	\N
12210	93	4	2014-12-07 16:17:27.027249	\N
12211	93	11	2014-12-07 16:17:27.029268	\N
12212	93	11	2014-12-07 16:17:27.031495	\N
12213	93	11	2014-12-07 16:17:27.033514	\N
12214	93	19	2014-12-07 16:17:27.03543	\N
12215	93	19	2014-12-07 16:17:27.037542	\N
12216	93	15	2014-12-07 16:17:27.039457	\N
12217	93	15	2014-12-07 16:17:27.041418	\N
12218	93	19	2014-12-07 16:17:27.043321	\N
12219	93	7	2014-12-07 16:17:27.045287	\N
12220	93	2	2014-12-07 16:17:27.04729	\N
12221	93	9	2014-12-07 16:17:27.049378	\N
12222	93	9	2014-12-07 16:17:27.051411	\N
12223	93	9	2014-12-07 16:17:27.053504	\N
12224	93	9	2014-12-07 16:17:27.055525	\N
12225	93	9	2014-12-07 16:17:27.057499	\N
12226	93	3	2014-12-07 16:17:27.059416	\N
12227	93	21	2014-12-07 16:17:27.061416	\N
12228	93	8	2014-12-07 16:17:27.063371	\N
12229	93	13	2014-12-07 16:17:27.065458	\N
12230	93	8	2014-12-07 16:17:27.067457	\N
12231	93	2	2014-12-07 16:17:27.06944	\N
12232	93	18	2014-12-07 16:17:27.071514	\N
12233	93	16	2014-12-07 16:17:27.073538	\N
12234	93	16	2014-12-07 16:17:27.075479	\N
12235	93	15	2014-12-07 16:17:27.077474	\N
12236	93	15	2014-12-07 16:17:27.079659	\N
12237	93	7	2014-12-07 16:17:27.082589	\N
12238	93	7	2014-12-07 16:17:27.084878	\N
12239	93	7	2014-12-07 16:17:27.087065	\N
12240	93	7	2014-12-07 16:17:27.089152	\N
12241	93	7	2014-12-07 16:17:27.091085	\N
12242	93	7	2014-12-07 16:17:27.093238	\N
12243	93	18	2014-12-07 16:17:27.095236	\N
12244	93	2	2014-12-07 16:17:27.097299	\N
12245	93	7	2014-12-07 16:17:27.099279	\N
12246	93	2	2014-12-07 16:17:27.101633	\N
12247	93	7	2014-12-07 16:17:27.103632	\N
12248	93	6	2014-12-07 16:17:27.105688	\N
12249	93	20	2014-12-07 16:17:27.107931	\N
12250	93	20	2014-12-07 16:17:27.110017	\N
12251	93	12	2014-12-07 16:17:27.112081	\N
12252	93	3	2014-12-07 16:17:27.114177	\N
12253	93	5	2014-12-07 16:17:27.116216	\N
12254	93	10	2014-12-07 16:17:27.118228	\N
12255	93	10	2014-12-07 16:17:27.120379	\N
12256	93	5	2014-12-07 16:17:27.122549	\N
12257	93	5	2014-12-07 16:17:27.124584	\N
12258	93	8	2014-12-07 16:17:27.126568	\N
12259	93	22	2014-12-07 16:17:27.128692	\N
12260	93	11	2014-12-07 16:17:27.130777	\N
12261	93	10	2014-12-07 16:17:27.132917	\N
12262	93	22	2014-12-07 16:17:27.134965	\N
12263	93	22	2014-12-07 16:17:27.136976	\N
12264	93	22	2014-12-07 16:17:27.139058	\N
12265	93	20	2014-12-07 16:17:27.141083	\N
12266	93	20	2014-12-07 16:17:27.143097	\N
12267	93	20	2014-12-07 16:17:27.145101	\N
12268	93	20	2014-12-07 16:17:27.147204	\N
12269	93	21	2014-12-07 16:17:27.149392	\N
12270	94	2	2014-12-07 16:17:27.252613	\N
12271	94	2	2014-12-07 16:17:27.255881	\N
12272	94	2	2014-12-07 16:17:27.258827	\N
12273	94	2	2014-12-07 16:17:27.261152	\N
12274	94	5	2014-12-07 16:17:27.26329	\N
12275	94	5	2014-12-07 16:17:27.265575	\N
12276	94	8	2014-12-07 16:17:27.267739	\N
12277	94	2	2014-12-07 16:17:27.270041	\N
12278	94	2	2014-12-07 16:17:27.272166	\N
12279	94	2	2014-12-07 16:17:27.274241	\N
12280	94	18	2014-12-07 16:17:27.276306	\N
12281	94	7	2014-12-07 16:17:27.278467	\N
12282	94	5	2014-12-07 16:17:27.280547	\N
12283	94	8	2014-12-07 16:17:27.28272	\N
12284	94	8	2014-12-07 16:17:27.284804	\N
12285	94	8	2014-12-07 16:17:27.286825	\N
12286	94	8	2014-12-07 16:17:27.288928	\N
12287	94	8	2014-12-07 16:17:27.291063	\N
12288	94	8	2014-12-07 16:17:27.29317	\N
12289	94	18	2014-12-07 16:17:27.295235	\N
12290	94	18	2014-12-07 16:17:27.297269	\N
12291	94	18	2014-12-07 16:17:27.299458	\N
12292	94	18	2014-12-07 16:17:27.30152	\N
12293	94	18	2014-12-07 16:17:27.30348	\N
12294	94	18	2014-12-07 16:17:27.305596	\N
12295	94	18	2014-12-07 16:17:27.307757	\N
12296	94	4	2014-12-07 16:17:27.309975	\N
12297	94	4	2014-12-07 16:17:27.312181	\N
12298	94	4	2014-12-07 16:17:27.314358	\N
12299	94	4	2014-12-07 16:17:27.316533	\N
12300	94	4	2014-12-07 16:17:27.31867	\N
12301	94	4	2014-12-07 16:17:27.320792	\N
12302	94	4	2014-12-07 16:17:27.322882	\N
12303	94	4	2014-12-07 16:17:27.324939	\N
12304	94	11	2014-12-07 16:17:27.327111	\N
12305	94	11	2014-12-07 16:17:27.329155	\N
12306	94	11	2014-12-07 16:17:27.331165	\N
12307	94	19	2014-12-07 16:17:27.333288	\N
12308	94	19	2014-12-07 16:17:27.335406	\N
12309	94	15	2014-12-07 16:17:27.337545	\N
12310	94	15	2014-12-07 16:17:27.339578	\N
12311	94	19	2014-12-07 16:17:27.341655	\N
12312	94	7	2014-12-07 16:17:27.343568	\N
12313	94	2	2014-12-07 16:17:27.345512	\N
12314	94	9	2014-12-07 16:17:27.347438	\N
12315	94	9	2014-12-07 16:17:27.350132	\N
12316	94	9	2014-12-07 16:17:27.352349	\N
12317	94	9	2014-12-07 16:17:27.354421	\N
12318	94	9	2014-12-07 16:17:27.356901	\N
12319	94	3	2014-12-07 16:17:27.360405	\N
12320	94	21	2014-12-07 16:17:27.364407	\N
12321	94	8	2014-12-07 16:17:27.367329	\N
12322	94	13	2014-12-07 16:17:27.369547	\N
12323	94	8	2014-12-07 16:17:27.37158	\N
12324	94	2	2014-12-07 16:17:27.373589	\N
12325	94	18	2014-12-07 16:17:27.375654	\N
12326	94	16	2014-12-07 16:17:27.377714	\N
12327	94	16	2014-12-07 16:17:27.379653	\N
12328	94	15	2014-12-07 16:17:27.381877	\N
12329	94	15	2014-12-07 16:17:27.384153	\N
12330	94	7	2014-12-07 16:17:27.386257	\N
12331	94	7	2014-12-07 16:17:27.388336	\N
12332	94	7	2014-12-07 16:17:27.390385	\N
12333	94	7	2014-12-07 16:17:27.392569	\N
12334	94	7	2014-12-07 16:17:27.394751	\N
12335	94	7	2014-12-07 16:17:27.39674	\N
12336	94	18	2014-12-07 16:17:27.398827	\N
12337	94	2	2014-12-07 16:17:27.40092	\N
12338	94	7	2014-12-07 16:17:27.402944	\N
12339	94	2	2014-12-07 16:17:27.405076	\N
12340	94	7	2014-12-07 16:17:27.407418	\N
12341	94	6	2014-12-07 16:17:27.409463	\N
12342	94	20	2014-12-07 16:17:27.41141	\N
12343	94	20	2014-12-07 16:17:27.41368	\N
12344	94	12	2014-12-07 16:17:27.415792	\N
12345	94	3	2014-12-07 16:17:27.417894	\N
12346	94	5	2014-12-07 16:17:27.419991	\N
12347	94	10	2014-12-07 16:17:27.422156	\N
12348	94	10	2014-12-07 16:17:27.424254	\N
12349	94	5	2014-12-07 16:17:27.426299	\N
12350	94	5	2014-12-07 16:17:27.428367	\N
12351	94	8	2014-12-07 16:17:27.430384	\N
12352	94	22	2014-12-07 16:17:27.432493	\N
12353	94	11	2014-12-07 16:17:27.434701	\N
12354	94	10	2014-12-07 16:17:27.436815	\N
12355	94	22	2014-12-07 16:17:27.438844	\N
12356	94	22	2014-12-07 16:17:27.44088	\N
12357	94	22	2014-12-07 16:17:27.442812	\N
12358	94	20	2014-12-07 16:17:27.444833	\N
12359	94	20	2014-12-07 16:17:27.446875	\N
12360	94	20	2014-12-07 16:17:27.448978	\N
12361	94	20	2014-12-07 16:17:27.451104	\N
12362	94	21	2014-12-07 16:17:27.453197	\N
12363	94	21	2014-12-07 16:17:27.455196	\N
12364	95	2	2014-12-07 16:17:27.564778	\N
12365	95	2	2014-12-07 16:17:27.567786	\N
12366	95	2	2014-12-07 16:17:27.569974	\N
12367	95	2	2014-12-07 16:17:27.572155	\N
12368	95	5	2014-12-07 16:17:27.574347	\N
12369	95	5	2014-12-07 16:17:27.576601	\N
12370	95	8	2014-12-07 16:17:27.578788	\N
12371	95	2	2014-12-07 16:17:27.580914	\N
12372	95	2	2014-12-07 16:17:27.583059	\N
12373	95	2	2014-12-07 16:17:27.585192	\N
12374	95	18	2014-12-07 16:17:27.587264	\N
12375	95	7	2014-12-07 16:17:27.589316	\N
12376	95	5	2014-12-07 16:17:27.591266	\N
12377	95	8	2014-12-07 16:17:27.593596	\N
12378	95	8	2014-12-07 16:17:27.595637	\N
12379	95	8	2014-12-07 16:17:27.597723	\N
12380	95	8	2014-12-07 16:17:27.599816	\N
12381	95	8	2014-12-07 16:17:27.601922	\N
12382	95	8	2014-12-07 16:17:27.603913	\N
12383	95	18	2014-12-07 16:17:27.605898	\N
12384	95	18	2014-12-07 16:17:27.607867	\N
12385	95	18	2014-12-07 16:17:27.609888	\N
12386	95	18	2014-12-07 16:17:27.611851	\N
12387	95	18	2014-12-07 16:17:27.613967	\N
12388	95	18	2014-12-07 16:17:27.615961	\N
12389	95	18	2014-12-07 16:17:27.618239	\N
12390	95	4	2014-12-07 16:17:27.620527	\N
12391	95	4	2014-12-07 16:17:27.622592	\N
12392	95	4	2014-12-07 16:17:27.624721	\N
12393	95	4	2014-12-07 16:17:27.626761	\N
12394	95	4	2014-12-07 16:17:27.628802	\N
12395	95	4	2014-12-07 16:17:27.630813	\N
12396	95	4	2014-12-07 16:17:27.633067	\N
12397	95	4	2014-12-07 16:17:27.635171	\N
12398	95	11	2014-12-07 16:17:27.637228	\N
12399	95	11	2014-12-07 16:17:27.639163	\N
12400	95	11	2014-12-07 16:17:27.641174	\N
12401	95	19	2014-12-07 16:17:27.643126	\N
12402	95	19	2014-12-07 16:17:27.645231	\N
12403	95	15	2014-12-07 16:17:27.647164	\N
12404	95	15	2014-12-07 16:17:27.649276	\N
12405	95	19	2014-12-07 16:17:27.651367	\N
12406	95	7	2014-12-07 16:17:27.653816	\N
12407	95	2	2014-12-07 16:17:27.655914	\N
12408	95	9	2014-12-07 16:17:27.657919	\N
12409	95	9	2014-12-07 16:17:27.659831	\N
12410	95	9	2014-12-07 16:17:27.661771	\N
12411	95	9	2014-12-07 16:17:27.66382	\N
12412	95	9	2014-12-07 16:17:27.665882	\N
12413	95	3	2014-12-07 16:17:27.66809	\N
12414	95	21	2014-12-07 16:17:27.670139	\N
12415	95	8	2014-12-07 16:17:27.672303	\N
12416	95	13	2014-12-07 16:17:27.674339	\N
12417	95	8	2014-12-07 16:17:27.676411	\N
12418	95	2	2014-12-07 16:17:27.6785	\N
12419	95	18	2014-12-07 16:17:27.680626	\N
12420	95	16	2014-12-07 16:17:27.682742	\N
12421	95	16	2014-12-07 16:17:27.685053	\N
12422	95	15	2014-12-07 16:17:27.687169	\N
12423	95	15	2014-12-07 16:17:27.689254	\N
12424	95	7	2014-12-07 16:17:27.691261	\N
12425	95	7	2014-12-07 16:17:27.693337	\N
12426	95	7	2014-12-07 16:17:27.695592	\N
12427	95	7	2014-12-07 16:17:27.697948	\N
12428	95	7	2014-12-07 16:17:27.700197	\N
12429	95	7	2014-12-07 16:17:27.702495	\N
12430	95	18	2014-12-07 16:17:27.704611	\N
12431	95	2	2014-12-07 16:17:27.706803	\N
12432	95	7	2014-12-07 16:17:27.708885	\N
12433	95	2	2014-12-07 16:17:27.711002	\N
12434	95	7	2014-12-07 16:17:27.713064	\N
12435	95	6	2014-12-07 16:17:27.715213	\N
12436	95	20	2014-12-07 16:17:27.717446	\N
12437	95	20	2014-12-07 16:17:27.719597	\N
12438	95	12	2014-12-07 16:17:27.721638	\N
12439	95	3	2014-12-07 16:17:27.723689	\N
12440	95	5	2014-12-07 16:17:27.725883	\N
12441	95	10	2014-12-07 16:17:27.72793	\N
12442	95	10	2014-12-07 16:17:27.729945	\N
12443	95	5	2014-12-07 16:17:27.731878	\N
12444	95	5	2014-12-07 16:17:27.734008	\N
12445	95	8	2014-12-07 16:17:27.737607	\N
12446	95	22	2014-12-07 16:17:27.739834	\N
12447	95	11	2014-12-07 16:17:27.741924	\N
12448	95	10	2014-12-07 16:17:27.74454	\N
12449	95	22	2014-12-07 16:17:27.746728	\N
12450	95	22	2014-12-07 16:17:27.748829	\N
12451	95	22	2014-12-07 16:17:27.751124	\N
12452	95	20	2014-12-07 16:17:27.753254	\N
12453	95	20	2014-12-07 16:17:27.755369	\N
12454	95	20	2014-12-07 16:17:27.757421	\N
12455	95	20	2014-12-07 16:17:27.759469	\N
12456	95	21	2014-12-07 16:17:27.76153	\N
12457	95	21	2014-12-07 16:17:27.763596	\N
12458	95	21	2014-12-07 16:17:27.765664	\N
12459	96	2	2014-12-07 16:17:28.056281	\N
12460	96	2	2014-12-07 16:17:28.059608	\N
12461	96	2	2014-12-07 16:17:28.062242	\N
12462	96	2	2014-12-07 16:17:28.064307	\N
12463	96	5	2014-12-07 16:17:28.066541	\N
12464	96	5	2014-12-07 16:17:28.068943	\N
12465	96	8	2014-12-07 16:17:28.071092	\N
12466	96	2	2014-12-07 16:17:28.073177	\N
12467	96	2	2014-12-07 16:17:28.075177	\N
12468	96	2	2014-12-07 16:17:28.077217	\N
12469	96	18	2014-12-07 16:17:28.07919	\N
12470	96	7	2014-12-07 16:17:28.081429	\N
12471	96	5	2014-12-07 16:17:28.083602	\N
12472	96	8	2014-12-07 16:17:28.085771	\N
12473	96	8	2014-12-07 16:17:28.087902	\N
12474	96	8	2014-12-07 16:17:28.090003	\N
12475	96	8	2014-12-07 16:17:28.092019	\N
12476	96	8	2014-12-07 16:17:28.094121	\N
12477	96	8	2014-12-07 16:17:28.096167	\N
12478	96	18	2014-12-07 16:17:28.098152	\N
12479	96	18	2014-12-07 16:17:28.100205	\N
12480	96	18	2014-12-07 16:17:28.102313	\N
12481	96	18	2014-12-07 16:17:28.104372	\N
12482	96	18	2014-12-07 16:17:28.106466	\N
12483	96	18	2014-12-07 16:17:28.108722	\N
12484	96	18	2014-12-07 16:17:28.110944	\N
12485	96	4	2014-12-07 16:17:28.113032	\N
12486	96	4	2014-12-07 16:17:28.115201	\N
12487	96	4	2014-12-07 16:17:28.117211	\N
12488	96	4	2014-12-07 16:17:28.11928	\N
12489	96	4	2014-12-07 16:17:28.121451	\N
12490	96	4	2014-12-07 16:17:28.123573	\N
12491	96	4	2014-12-07 16:17:28.125645	\N
12492	96	4	2014-12-07 16:17:28.127668	\N
12493	96	11	2014-12-07 16:17:28.129863	\N
12494	96	11	2014-12-07 16:17:28.131891	\N
12495	96	11	2014-12-07 16:17:28.134173	\N
12496	96	19	2014-12-07 16:17:28.136316	\N
12497	96	19	2014-12-07 16:17:28.138354	\N
12498	96	15	2014-12-07 16:17:28.140383	\N
12499	96	15	2014-12-07 16:17:28.142438	\N
12500	96	19	2014-12-07 16:17:28.144452	\N
12501	96	7	2014-12-07 16:17:28.146601	\N
12502	96	2	2014-12-07 16:17:28.148674	\N
12503	96	9	2014-12-07 16:17:28.150823	\N
12504	96	9	2014-12-07 16:17:28.152987	\N
12505	96	9	2014-12-07 16:17:28.155034	\N
12506	96	9	2014-12-07 16:17:28.157094	\N
12507	96	9	2014-12-07 16:17:28.159155	\N
12508	96	3	2014-12-07 16:17:28.16119	\N
12509	96	21	2014-12-07 16:17:28.163181	\N
12510	96	8	2014-12-07 16:17:28.165323	\N
12511	96	13	2014-12-07 16:17:28.167327	\N
12512	96	8	2014-12-07 16:17:28.169426	\N
12513	96	2	2014-12-07 16:17:28.171389	\N
12514	96	18	2014-12-07 16:17:28.173389	\N
12515	96	16	2014-12-07 16:17:28.175329	\N
12516	96	16	2014-12-07 16:17:28.17747	\N
12517	96	15	2014-12-07 16:17:28.179747	\N
12518	96	15	2014-12-07 16:17:28.182004	\N
12519	96	7	2014-12-07 16:17:28.184027	\N
12520	96	7	2014-12-07 16:17:28.186199	\N
12521	96	7	2014-12-07 16:17:28.188199	\N
12522	96	7	2014-12-07 16:17:28.190189	\N
12523	96	7	2014-12-07 16:17:28.192164	\N
12524	96	7	2014-12-07 16:17:28.194397	\N
12525	96	18	2014-12-07 16:17:28.196537	\N
12526	96	2	2014-12-07 16:17:28.198568	\N
12527	96	7	2014-12-07 16:17:28.200604	\N
12528	96	2	2014-12-07 16:17:28.202701	\N
12529	96	7	2014-12-07 16:17:28.204763	\N
12530	96	6	2014-12-07 16:17:28.206901	\N
12531	96	20	2014-12-07 16:17:28.20902	\N
12532	96	20	2014-12-07 16:17:28.211106	\N
12533	96	12	2014-12-07 16:17:28.213151	\N
12534	96	3	2014-12-07 16:17:28.215138	\N
12535	96	5	2014-12-07 16:17:28.217138	\N
12536	96	10	2014-12-07 16:17:28.219355	\N
12537	96	10	2014-12-07 16:17:28.22139	\N
12538	96	5	2014-12-07 16:17:28.223404	\N
12539	96	5	2014-12-07 16:17:28.225494	\N
12540	96	8	2014-12-07 16:17:28.227603	\N
12541	96	22	2014-12-07 16:17:28.229748	\N
12542	96	11	2014-12-07 16:17:28.231784	\N
12543	96	10	2014-12-07 16:17:28.233812	\N
12544	96	22	2014-12-07 16:17:28.236177	\N
12545	96	22	2014-12-07 16:17:28.238221	\N
12546	96	22	2014-12-07 16:17:28.240335	\N
12547	96	20	2014-12-07 16:17:28.242404	\N
12548	96	20	2014-12-07 16:17:28.244422	\N
12549	96	20	2014-12-07 16:17:28.246451	\N
12550	96	20	2014-12-07 16:17:28.248496	\N
12551	96	21	2014-12-07 16:17:28.250639	\N
12552	96	21	2014-12-07 16:17:28.252869	\N
12553	96	21	2014-12-07 16:17:28.254959	\N
12554	96	21	2014-12-07 16:17:28.257116	\N
12555	97	2	2014-12-07 16:17:30.549147	\N
12556	97	2	2014-12-07 16:17:30.552601	\N
12557	97	2	2014-12-07 16:17:30.555338	\N
12558	97	2	2014-12-07 16:17:30.557588	\N
12559	97	5	2014-12-07 16:17:30.559986	\N
12560	97	5	2014-12-07 16:17:30.562222	\N
12561	97	8	2014-12-07 16:17:30.564393	\N
12562	97	2	2014-12-07 16:17:30.566496	\N
12563	97	2	2014-12-07 16:17:30.568615	\N
12564	97	2	2014-12-07 16:17:30.570749	\N
12565	97	18	2014-12-07 16:17:30.5729	\N
12566	97	7	2014-12-07 16:17:30.574981	\N
12567	97	5	2014-12-07 16:17:30.577217	\N
12568	97	8	2014-12-07 16:17:30.579233	\N
12569	97	8	2014-12-07 16:17:30.581261	\N
12570	97	8	2014-12-07 16:17:30.583177	\N
12571	97	8	2014-12-07 16:17:30.585142	\N
12572	97	8	2014-12-07 16:17:30.587337	\N
12573	97	8	2014-12-07 16:17:30.589425	\N
12574	97	18	2014-12-07 16:17:30.591375	\N
12575	97	18	2014-12-07 16:17:30.593411	\N
12576	97	18	2014-12-07 16:17:30.595366	\N
12577	97	18	2014-12-07 16:17:30.597481	\N
12578	97	18	2014-12-07 16:17:30.599484	\N
12579	97	18	2014-12-07 16:17:30.601464	\N
12580	97	18	2014-12-07 16:17:30.603604	\N
12581	97	4	2014-12-07 16:17:30.605976	\N
12582	97	4	2014-12-07 16:17:30.608158	\N
12583	97	4	2014-12-07 16:17:30.610345	\N
12584	97	4	2014-12-07 16:17:30.612394	\N
12585	97	4	2014-12-07 16:17:30.614386	\N
12586	97	4	2014-12-07 16:17:30.616644	\N
12587	97	4	2014-12-07 16:17:30.618725	\N
12588	97	4	2014-12-07 16:17:30.620785	\N
12589	97	11	2014-12-07 16:17:30.622764	\N
12590	97	11	2014-12-07 16:17:30.624779	\N
12591	97	11	2014-12-07 16:17:30.626886	\N
12592	97	19	2014-12-07 16:17:30.628978	\N
12593	97	19	2014-12-07 16:17:30.631018	\N
12594	97	15	2014-12-07 16:17:30.633033	\N
12595	97	15	2014-12-07 16:17:30.63518	\N
12596	97	19	2014-12-07 16:17:30.637475	\N
12597	97	7	2014-12-07 16:17:30.639466	\N
12598	97	2	2014-12-07 16:17:30.641503	\N
12599	97	9	2014-12-07 16:17:30.643539	\N
12600	97	9	2014-12-07 16:17:30.645788	\N
12601	97	9	2014-12-07 16:17:30.647893	\N
12602	97	9	2014-12-07 16:17:30.649973	\N
12603	97	9	2014-12-07 16:17:30.65204	\N
12604	97	3	2014-12-07 16:17:30.654104	\N
12605	97	21	2014-12-07 16:17:30.656322	\N
12606	97	8	2014-12-07 16:17:30.658388	\N
12607	97	13	2014-12-07 16:17:30.661372	\N
12608	97	8	2014-12-07 16:17:30.664225	\N
12609	97	2	2014-12-07 16:17:30.666338	\N
12610	97	18	2014-12-07 16:17:30.668549	\N
12611	97	16	2014-12-07 16:17:30.67089	\N
12612	97	16	2014-12-07 16:17:30.672998	\N
12613	97	15	2014-12-07 16:17:30.67517	\N
12614	97	15	2014-12-07 16:17:30.67736	\N
12615	97	7	2014-12-07 16:17:30.679448	\N
12616	97	7	2014-12-07 16:17:30.681499	\N
12617	97	7	2014-12-07 16:17:30.683539	\N
12618	97	7	2014-12-07 16:17:30.685682	\N
12619	97	7	2014-12-07 16:17:30.688074	\N
12620	97	7	2014-12-07 16:17:30.690298	\N
12621	97	18	2014-12-07 16:17:30.692379	\N
12622	97	2	2014-12-07 16:17:30.6945	\N
12623	97	7	2014-12-07 16:17:30.696616	\N
12624	97	2	2014-12-07 16:17:30.699	\N
12625	97	7	2014-12-07 16:17:30.701113	\N
12626	97	6	2014-12-07 16:17:30.703103	\N
12627	97	20	2014-12-07 16:17:30.705158	\N
12628	97	20	2014-12-07 16:17:30.707107	\N
12629	97	12	2014-12-07 16:17:30.709252	\N
12630	97	3	2014-12-07 16:17:30.711343	\N
12631	97	5	2014-12-07 16:17:30.713449	\N
12632	97	10	2014-12-07 16:17:30.715446	\N
12633	97	10	2014-12-07 16:17:30.717444	\N
12634	97	5	2014-12-07 16:17:30.719359	\N
12635	97	5	2014-12-07 16:17:30.721393	\N
12636	97	8	2014-12-07 16:17:30.723342	\N
12637	97	22	2014-12-07 16:17:30.725364	\N
12638	97	11	2014-12-07 16:17:30.727523	\N
12639	97	10	2014-12-07 16:17:30.729573	\N
12640	97	22	2014-12-07 16:17:30.73157	\N
12641	97	22	2014-12-07 16:17:30.735421	\N
12642	97	22	2014-12-07 16:17:30.737597	\N
12643	97	20	2014-12-07 16:17:30.739644	\N
12644	97	20	2014-12-07 16:17:30.741803	\N
12645	97	20	2014-12-07 16:17:30.744065	\N
12646	97	20	2014-12-07 16:17:30.746287	\N
12647	97	21	2014-12-07 16:17:30.748428	\N
12648	97	21	2014-12-07 16:17:30.750444	\N
12649	97	21	2014-12-07 16:17:30.752565	\N
12650	97	21	2014-12-07 16:17:30.754577	\N
12651	97	21	2014-12-07 16:17:30.756639	\N
12652	98	2	2014-12-07 16:17:30.999583	\N
12653	98	2	2014-12-07 16:17:31.002939	\N
12654	98	2	2014-12-07 16:17:31.005691	\N
12655	98	2	2014-12-07 16:17:31.008102	\N
12656	98	5	2014-12-07 16:17:31.010536	\N
12657	98	5	2014-12-07 16:17:31.012892	\N
12658	98	8	2014-12-07 16:17:31.015178	\N
12659	98	2	2014-12-07 16:17:31.017204	\N
12660	98	2	2014-12-07 16:17:31.01921	\N
12661	98	2	2014-12-07 16:17:31.021275	\N
12662	98	18	2014-12-07 16:17:31.023379	\N
12663	98	7	2014-12-07 16:17:31.025425	\N
12664	98	5	2014-12-07 16:17:31.027488	\N
12665	98	8	2014-12-07 16:17:31.029609	\N
12666	98	8	2014-12-07 16:17:31.031552	\N
12667	98	8	2014-12-07 16:17:31.03348	\N
12668	98	8	2014-12-07 16:17:31.035411	\N
12669	98	8	2014-12-07 16:17:31.037532	\N
12670	98	8	2014-12-07 16:17:31.039519	\N
12671	98	18	2014-12-07 16:17:31.041583	\N
12672	98	18	2014-12-07 16:17:31.043483	\N
12673	98	18	2014-12-07 16:17:31.045593	\N
12674	98	18	2014-12-07 16:17:31.04753	\N
12675	98	18	2014-12-07 16:17:31.049693	\N
12676	98	18	2014-12-07 16:17:31.051575	\N
12677	98	18	2014-12-07 16:17:31.05355	\N
12678	98	4	2014-12-07 16:17:31.055446	\N
12679	98	4	2014-12-07 16:17:31.05757	\N
12680	98	4	2014-12-07 16:17:31.059599	\N
12681	98	4	2014-12-07 16:17:31.061691	\N
12682	98	4	2014-12-07 16:17:31.063648	\N
12683	98	4	2014-12-07 16:17:31.065689	\N
12684	98	4	2014-12-07 16:17:31.067667	\N
12685	98	4	2014-12-07 16:17:31.06962	\N
12686	98	11	2014-12-07 16:17:31.071573	\N
12687	98	11	2014-12-07 16:17:31.073529	\N
12688	98	11	2014-12-07 16:17:31.075518	\N
12689	98	19	2014-12-07 16:17:31.077728	\N
12690	98	19	2014-12-07 16:17:31.079848	\N
12691	98	15	2014-12-07 16:17:31.081812	\N
12692	98	15	2014-12-07 16:17:31.083743	\N
12693	98	19	2014-12-07 16:17:31.085776	\N
12694	98	7	2014-12-07 16:17:31.087882	\N
12695	98	2	2014-12-07 16:17:31.089976	\N
12696	98	9	2014-12-07 16:17:31.092004	\N
12697	98	9	2014-12-07 16:17:31.093988	\N
12698	98	9	2014-12-07 16:17:31.096381	\N
12699	98	9	2014-12-07 16:17:31.098788	\N
12700	98	9	2014-12-07 16:17:31.101703	\N
12701	98	3	2014-12-07 16:17:31.104024	\N
12702	98	21	2014-12-07 16:17:31.107886	\N
12703	98	8	2014-12-07 16:17:31.110655	\N
12704	98	13	2014-12-07 16:17:31.113406	\N
12705	98	8	2014-12-07 16:17:31.115747	\N
12706	98	2	2014-12-07 16:17:31.118354	\N
12707	98	18	2014-12-07 16:17:31.120617	\N
12708	98	16	2014-12-07 16:17:31.122899	\N
12709	98	16	2014-12-07 16:17:31.125229	\N
12710	98	15	2014-12-07 16:17:31.127251	\N
12711	98	15	2014-12-07 16:17:31.12971	\N
12712	98	7	2014-12-07 16:17:31.13205	\N
12713	98	7	2014-12-07 16:17:31.134154	\N
12714	98	7	2014-12-07 16:17:31.136239	\N
12715	98	7	2014-12-07 16:17:31.1383	\N
12716	98	7	2014-12-07 16:17:31.140346	\N
12717	98	7	2014-12-07 16:17:31.142383	\N
12718	98	18	2014-12-07 16:17:31.144576	\N
12719	98	2	2014-12-07 16:17:31.146876	\N
12720	98	7	2014-12-07 16:17:31.149121	\N
12721	98	2	2014-12-07 16:17:31.151241	\N
12722	98	7	2014-12-07 16:17:31.153303	\N
12723	98	6	2014-12-07 16:17:31.155315	\N
12724	98	20	2014-12-07 16:17:31.157382	\N
12725	98	20	2014-12-07 16:17:31.159414	\N
12726	98	12	2014-12-07 16:17:31.161582	\N
12727	98	3	2014-12-07 16:17:31.163676	\N
12728	98	5	2014-12-07 16:17:31.165754	\N
12729	98	10	2014-12-07 16:17:31.167795	\N
12730	98	10	2014-12-07 16:17:31.169865	\N
12731	98	5	2014-12-07 16:17:31.171827	\N
12732	98	5	2014-12-07 16:17:31.173778	\N
12733	98	8	2014-12-07 16:17:31.175736	\N
12734	98	22	2014-12-07 16:17:31.177748	\N
12735	98	11	2014-12-07 16:17:31.179956	\N
12736	98	10	2014-12-07 16:17:31.182068	\N
12737	98	22	2014-12-07 16:17:31.184234	\N
12738	98	22	2014-12-07 16:17:31.186307	\N
12739	98	22	2014-12-07 16:17:31.188394	\N
12740	98	20	2014-12-07 16:17:31.190546	\N
12741	98	20	2014-12-07 16:17:31.192606	\N
12742	98	20	2014-12-07 16:17:31.194948	\N
12743	98	20	2014-12-07 16:17:31.197221	\N
12744	98	21	2014-12-07 16:17:31.199285	\N
12745	98	21	2014-12-07 16:17:31.201445	\N
12746	98	21	2014-12-07 16:17:31.203439	\N
12747	98	21	2014-12-07 16:17:31.20552	\N
12748	98	21	2014-12-07 16:17:31.207499	\N
12749	98	21	2014-12-07 16:17:31.209728	\N
12750	99	2	2014-12-07 16:17:31.592261	\N
12751	99	2	2014-12-07 16:17:31.596023	\N
12752	99	2	2014-12-07 16:17:31.600552	\N
12753	99	2	2014-12-07 16:17:31.602877	\N
12754	99	5	2014-12-07 16:17:31.605088	\N
12755	99	5	2014-12-07 16:17:31.607137	\N
12756	99	8	2014-12-07 16:17:31.60933	\N
12757	99	2	2014-12-07 16:17:31.611727	\N
12758	99	2	2014-12-07 16:17:31.613959	\N
12759	99	2	2014-12-07 16:17:31.616018	\N
12760	99	18	2014-12-07 16:17:31.618163	\N
12761	99	7	2014-12-07 16:17:31.620177	\N
12762	99	5	2014-12-07 16:17:31.622305	\N
12763	99	8	2014-12-07 16:17:31.624352	\N
12764	99	8	2014-12-07 16:17:31.626525	\N
12765	99	8	2014-12-07 16:17:31.628579	\N
12766	99	8	2014-12-07 16:17:31.630746	\N
12767	99	8	2014-12-07 16:17:31.63292	\N
12768	99	8	2014-12-07 16:17:31.634941	\N
12769	99	18	2014-12-07 16:17:31.636949	\N
12770	99	18	2014-12-07 16:17:31.639056	\N
12771	99	18	2014-12-07 16:17:31.641304	\N
12772	99	18	2014-12-07 16:17:31.643279	\N
12773	99	18	2014-12-07 16:17:31.64528	\N
12774	99	18	2014-12-07 16:17:31.647331	\N
12775	99	18	2014-12-07 16:17:31.649831	\N
12776	99	4	2014-12-07 16:17:31.653334	\N
12777	99	4	2014-12-07 16:17:31.656068	\N
12778	99	4	2014-12-07 16:17:31.65836	\N
12779	99	4	2014-12-07 16:17:31.660608	\N
12780	99	4	2014-12-07 16:17:31.663	\N
12781	99	4	2014-12-07 16:17:31.665131	\N
12782	99	4	2014-12-07 16:17:31.66718	\N
12783	99	4	2014-12-07 16:17:31.669216	\N
12784	99	11	2014-12-07 16:17:31.671528	\N
12785	99	11	2014-12-07 16:17:31.673635	\N
12786	99	11	2014-12-07 16:17:31.675738	\N
12787	99	19	2014-12-07 16:17:31.677824	\N
12788	99	19	2014-12-07 16:17:31.680082	\N
12789	99	15	2014-12-07 16:17:31.682238	\N
12790	99	15	2014-12-07 16:17:31.684353	\N
12791	99	19	2014-12-07 16:17:31.686502	\N
12792	99	7	2014-12-07 16:17:31.688653	\N
12793	99	2	2014-12-07 16:17:31.690784	\N
12794	99	9	2014-12-07 16:17:31.693098	\N
12795	99	9	2014-12-07 16:17:31.695126	\N
12796	99	9	2014-12-07 16:17:31.697226	\N
12797	99	9	2014-12-07 16:17:31.69922	\N
12798	99	9	2014-12-07 16:17:31.701252	\N
12799	99	3	2014-12-07 16:17:31.703244	\N
12800	99	21	2014-12-07 16:17:31.705281	\N
12801	99	8	2014-12-07 16:17:31.707167	\N
12802	99	13	2014-12-07 16:17:31.70926	\N
12803	99	8	2014-12-07 16:17:31.711485	\N
12804	99	2	2014-12-07 16:17:31.713809	\N
12805	99	18	2014-12-07 16:17:31.715963	\N
12806	99	16	2014-12-07 16:17:31.718049	\N
12807	99	16	2014-12-07 16:17:31.720087	\N
12808	99	15	2014-12-07 16:17:31.722122	\N
12809	99	15	2014-12-07 16:17:31.724175	\N
12810	99	7	2014-12-07 16:17:31.726158	\N
12811	99	7	2014-12-07 16:17:31.728169	\N
12812	99	7	2014-12-07 16:17:31.730363	\N
12813	99	7	2014-12-07 16:17:31.732956	\N
12814	99	7	2014-12-07 16:17:31.735245	\N
12815	99	7	2014-12-07 16:17:31.737352	\N
12816	99	18	2014-12-07 16:17:31.73935	\N
12817	99	2	2014-12-07 16:17:31.741567	\N
12818	99	7	2014-12-07 16:17:31.743719	\N
12819	99	2	2014-12-07 16:17:31.74588	\N
12820	99	7	2014-12-07 16:17:31.748126	\N
12821	99	6	2014-12-07 16:17:31.750217	\N
12822	99	20	2014-12-07 16:17:31.752283	\N
12823	99	20	2014-12-07 16:17:31.754332	\N
12824	99	12	2014-12-07 16:17:31.756386	\N
12825	99	3	2014-12-07 16:17:31.758416	\N
12826	99	5	2014-12-07 16:17:31.760527	\N
12827	99	10	2014-12-07 16:17:31.762635	\N
12828	99	10	2014-12-07 16:17:31.764981	\N
12829	99	5	2014-12-07 16:17:31.767066	\N
12830	99	5	2014-12-07 16:17:31.769112	\N
12831	99	8	2014-12-07 16:17:31.771374	\N
12832	99	22	2014-12-07 16:17:31.773692	\N
12833	99	11	2014-12-07 16:17:31.775839	\N
12834	99	10	2014-12-07 16:17:31.7779	\N
12835	99	22	2014-12-07 16:17:31.78003	\N
12836	99	22	2014-12-07 16:17:31.7821	\N
12837	99	22	2014-12-07 16:17:31.784143	\N
12838	99	20	2014-12-07 16:17:31.786262	\N
12839	99	20	2014-12-07 16:17:31.788468	\N
12840	99	20	2014-12-07 16:17:31.790589	\N
12841	99	20	2014-12-07 16:17:31.792652	\N
12842	99	21	2014-12-07 16:17:31.794804	\N
12843	99	21	2014-12-07 16:17:31.796913	\N
12844	99	21	2014-12-07 16:17:31.799113	\N
12845	99	21	2014-12-07 16:17:31.801338	\N
12846	99	21	2014-12-07 16:17:31.803447	\N
12847	99	21	2014-12-07 16:17:31.805661	\N
12848	99	12	2014-12-07 16:17:31.807946	\N
12849	100	2	2014-12-07 16:17:31.928829	\N
12850	100	2	2014-12-07 16:17:31.932385	\N
12851	100	2	2014-12-07 16:17:31.934985	\N
12852	100	2	2014-12-07 16:17:31.937377	\N
12853	100	5	2014-12-07 16:17:31.939546	\N
12854	100	5	2014-12-07 16:17:31.941855	\N
12855	100	8	2014-12-07 16:17:31.944178	\N
12856	100	2	2014-12-07 16:17:31.946566	\N
12857	100	2	2014-12-07 16:17:31.948736	\N
12858	100	2	2014-12-07 16:17:31.951154	\N
12859	100	18	2014-12-07 16:17:31.953327	\N
12860	100	7	2014-12-07 16:17:31.955336	\N
12861	100	5	2014-12-07 16:17:31.957387	\N
12862	100	8	2014-12-07 16:17:31.959275	\N
12863	100	8	2014-12-07 16:17:31.961334	\N
12864	100	8	2014-12-07 16:17:31.963295	\N
12865	100	8	2014-12-07 16:17:31.965503	\N
12866	100	8	2014-12-07 16:17:31.967496	\N
12867	100	8	2014-12-07 16:17:31.96947	\N
12868	100	18	2014-12-07 16:17:31.971362	\N
12869	100	18	2014-12-07 16:17:31.973341	\N
12870	100	18	2014-12-07 16:17:31.975464	\N
12871	100	18	2014-12-07 16:17:31.977572	\N
12872	100	18	2014-12-07 16:17:31.979532	\N
12873	100	18	2014-12-07 16:17:31.981653	\N
12874	100	18	2014-12-07 16:17:31.984017	\N
12875	100	4	2014-12-07 16:17:31.986106	\N
12876	100	4	2014-12-07 16:17:31.988266	\N
12877	100	4	2014-12-07 16:17:31.991107	\N
12878	100	4	2014-12-07 16:17:31.99324	\N
12879	100	4	2014-12-07 16:17:31.995434	\N
12880	100	4	2014-12-07 16:17:31.997603	\N
12881	100	4	2014-12-07 16:17:31.999638	\N
12882	100	4	2014-12-07 16:17:32.001701	\N
12883	100	11	2014-12-07 16:17:32.003786	\N
12884	100	11	2014-12-07 16:17:32.006155	\N
12885	100	11	2014-12-07 16:17:32.008572	\N
12886	100	19	2014-12-07 16:17:32.011	\N
12887	100	19	2014-12-07 16:17:32.013211	\N
12888	100	15	2014-12-07 16:17:32.015395	\N
12889	100	15	2014-12-07 16:17:32.017519	\N
12890	100	19	2014-12-07 16:17:32.019507	\N
12891	100	7	2014-12-07 16:17:32.021483	\N
12892	100	2	2014-12-07 16:17:32.023531	\N
12893	100	9	2014-12-07 16:17:32.025528	\N
12894	100	9	2014-12-07 16:17:32.027451	\N
12895	100	9	2014-12-07 16:17:32.029519	\N
12896	100	9	2014-12-07 16:17:32.031686	\N
12897	100	9	2014-12-07 16:17:32.033984	\N
12898	100	3	2014-12-07 16:17:32.036071	\N
12899	100	21	2014-12-07 16:17:32.03816	\N
12900	100	8	2014-12-07 16:17:32.040365	\N
12901	100	13	2014-12-07 16:17:32.042469	\N
12902	100	8	2014-12-07 16:17:32.044504	\N
12903	100	2	2014-12-07 16:17:32.046588	\N
12904	100	18	2014-12-07 16:17:32.048798	\N
12905	100	16	2014-12-07 16:17:32.050902	\N
12906	100	16	2014-12-07 16:17:32.053044	\N
12907	100	15	2014-12-07 16:17:32.055101	\N
12908	100	15	2014-12-07 16:17:32.057125	\N
12909	100	7	2014-12-07 16:17:32.059135	\N
12910	100	7	2014-12-07 16:17:32.06114	\N
12911	100	7	2014-12-07 16:17:32.063087	\N
12912	100	7	2014-12-07 16:17:32.065247	\N
12913	100	7	2014-12-07 16:17:32.067233	\N
12914	100	7	2014-12-07 16:17:32.069336	\N
12915	100	18	2014-12-07 16:17:32.071403	\N
12916	100	2	2014-12-07 16:17:32.073408	\N
12917	100	7	2014-12-07 16:17:32.075489	\N
12918	100	2	2014-12-07 16:17:32.077547	\N
12919	100	7	2014-12-07 16:17:32.079467	\N
12920	100	6	2014-12-07 16:17:32.081579	\N
12921	100	20	2014-12-07 16:17:32.083667	\N
12922	100	20	2014-12-07 16:17:32.085716	\N
12923	100	12	2014-12-07 16:17:32.087705	\N
12924	100	3	2014-12-07 16:17:32.090022	\N
12925	100	5	2014-12-07 16:17:32.092112	\N
12926	100	10	2014-12-07 16:17:32.094167	\N
12927	100	10	2014-12-07 16:17:32.096271	\N
12928	100	5	2014-12-07 16:17:32.098354	\N
12929	100	5	2014-12-07 16:17:32.100475	\N
12930	100	8	2014-12-07 16:17:32.103035	\N
12931	100	22	2014-12-07 16:17:32.105277	\N
12932	100	11	2014-12-07 16:17:32.107308	\N
12933	100	10	2014-12-07 16:17:32.109383	\N
12934	100	22	2014-12-07 16:17:32.111463	\N
12935	100	22	2014-12-07 16:17:32.11356	\N
12936	100	22	2014-12-07 16:17:32.115774	\N
12937	100	20	2014-12-07 16:17:32.117916	\N
12938	100	20	2014-12-07 16:17:32.120055	\N
12939	100	20	2014-12-07 16:17:32.122101	\N
12940	100	20	2014-12-07 16:17:32.12414	\N
12941	100	21	2014-12-07 16:17:32.126168	\N
12942	100	21	2014-12-07 16:17:32.12823	\N
12943	100	21	2014-12-07 16:17:32.130291	\N
12944	100	21	2014-12-07 16:17:32.132504	\N
12945	100	21	2014-12-07 16:17:32.134743	\N
12946	100	21	2014-12-07 16:17:32.136812	\N
12947	100	12	2014-12-07 16:17:32.138865	\N
12948	100	12	2014-12-07 16:17:32.140858	\N
12949	101	2	2014-12-07 16:17:32.259755	\N
12950	101	2	2014-12-07 16:17:32.263085	\N
12951	101	2	2014-12-07 16:17:32.265904	\N
12952	101	2	2014-12-07 16:17:32.268297	\N
12953	101	5	2014-12-07 16:17:32.270506	\N
12954	101	5	2014-12-07 16:17:32.272616	\N
12955	101	8	2014-12-07 16:17:32.274658	\N
12956	101	2	2014-12-07 16:17:32.276757	\N
12957	101	2	2014-12-07 16:17:32.278794	\N
12958	101	2	2014-12-07 16:17:32.280844	\N
12959	101	18	2014-12-07 16:17:32.282875	\N
12960	101	7	2014-12-07 16:17:32.284903	\N
12961	101	5	2014-12-07 16:17:32.287088	\N
12962	101	8	2014-12-07 16:17:32.289208	\N
12963	101	8	2014-12-07 16:17:32.291289	\N
12964	101	8	2014-12-07 16:17:32.29333	\N
12965	101	8	2014-12-07 16:17:32.295617	\N
12966	101	8	2014-12-07 16:17:32.29778	\N
12967	101	8	2014-12-07 16:17:32.299844	\N
12968	101	18	2014-12-07 16:17:32.301881	\N
12969	101	18	2014-12-07 16:17:32.303996	\N
12970	101	18	2014-12-07 16:17:32.306001	\N
12971	101	18	2014-12-07 16:17:32.308129	\N
12972	101	18	2014-12-07 16:17:32.310345	\N
12973	101	18	2014-12-07 16:17:32.312508	\N
12974	101	18	2014-12-07 16:17:32.314619	\N
12975	101	4	2014-12-07 16:17:32.316711	\N
12976	101	4	2014-12-07 16:17:32.318963	\N
12977	101	4	2014-12-07 16:17:32.321114	\N
12978	101	4	2014-12-07 16:17:32.323148	\N
12979	101	4	2014-12-07 16:17:32.32518	\N
12980	101	4	2014-12-07 16:17:32.327161	\N
12981	101	4	2014-12-07 16:17:32.329199	\N
12982	101	4	2014-12-07 16:17:32.331191	\N
12983	101	11	2014-12-07 16:17:32.333486	\N
12984	101	11	2014-12-07 16:17:32.335527	\N
12985	101	11	2014-12-07 16:17:32.337707	\N
12986	101	19	2014-12-07 16:17:32.339693	\N
12987	101	19	2014-12-07 16:17:32.341874	\N
12988	101	15	2014-12-07 16:17:32.343824	\N
12989	101	15	2014-12-07 16:17:32.345915	\N
12990	101	19	2014-12-07 16:17:32.348009	\N
12991	101	7	2014-12-07 16:17:32.350344	\N
12992	101	2	2014-12-07 16:17:32.352487	\N
12993	101	9	2014-12-07 16:17:32.354541	\N
12994	101	9	2014-12-07 16:17:32.356548	\N
12995	101	9	2014-12-07 16:17:32.358603	\N
12996	101	9	2014-12-07 16:17:32.360601	\N
12997	101	9	2014-12-07 16:17:32.362676	\N
12998	101	3	2014-12-07 16:17:32.364687	\N
12999	101	21	2014-12-07 16:17:32.366688	\N
13000	101	8	2014-12-07 16:17:32.368888	\N
13001	101	13	2014-12-07 16:17:32.370971	\N
13002	101	8	2014-12-07 16:17:32.373032	\N
13003	101	2	2014-12-07 16:17:32.375131	\N
13004	101	18	2014-12-07 16:17:32.377155	\N
13005	101	16	2014-12-07 16:17:32.379164	\N
13006	101	16	2014-12-07 16:17:32.381179	\N
13007	101	15	2014-12-07 16:17:32.383498	\N
13008	101	15	2014-12-07 16:17:32.38559	\N
13009	101	7	2014-12-07 16:17:32.387532	\N
13010	101	7	2014-12-07 16:17:32.389721	\N
13011	101	7	2014-12-07 16:17:32.391807	\N
13012	101	7	2014-12-07 16:17:32.393879	\N
13013	101	7	2014-12-07 16:17:32.395854	\N
13014	101	7	2014-12-07 16:17:32.397897	\N
13015	101	18	2014-12-07 16:17:32.399946	\N
13016	101	2	2014-12-07 16:17:32.402096	\N
13017	101	7	2014-12-07 16:17:32.40424	\N
13018	101	2	2014-12-07 16:17:32.406371	\N
13019	101	7	2014-12-07 16:17:32.408442	\N
13020	101	6	2014-12-07 16:17:32.410694	\N
13021	101	20	2014-12-07 16:17:32.412813	\N
13022	101	20	2014-12-07 16:17:32.414831	\N
13023	101	12	2014-12-07 16:17:32.417228	\N
13024	101	3	2014-12-07 16:17:32.419243	\N
13025	101	5	2014-12-07 16:17:32.421271	\N
13026	101	10	2014-12-07 16:17:32.423197	\N
13027	101	10	2014-12-07 16:17:32.425206	\N
13028	101	5	2014-12-07 16:17:32.427375	\N
13029	101	5	2014-12-07 16:17:32.429533	\N
13030	101	8	2014-12-07 16:17:32.431506	\N
13031	101	22	2014-12-07 16:17:32.433743	\N
13032	101	11	2014-12-07 16:17:32.435689	\N
13033	101	10	2014-12-07 16:17:32.437658	\N
13034	101	22	2014-12-07 16:17:32.439629	\N
13035	101	22	2014-12-07 16:17:32.44171	\N
13036	101	22	2014-12-07 16:17:32.443949	\N
13037	101	20	2014-12-07 16:17:32.446123	\N
13038	101	20	2014-12-07 16:17:32.448297	\N
13039	101	20	2014-12-07 16:17:32.450683	\N
13040	101	20	2014-12-07 16:17:32.452758	\N
13041	101	21	2014-12-07 16:17:32.454773	\N
13042	101	21	2014-12-07 16:17:32.45679	\N
13043	101	21	2014-12-07 16:17:32.458989	\N
13044	101	21	2014-12-07 16:17:32.461052	\N
13045	101	21	2014-12-07 16:17:32.463268	\N
13046	101	21	2014-12-07 16:17:32.46542	\N
13047	101	12	2014-12-07 16:17:32.467513	\N
13048	101	12	2014-12-07 16:17:32.469685	\N
13049	101	12	2014-12-07 16:17:32.472166	\N
13050	102	2	2014-12-07 16:17:32.594107	\N
13051	102	2	2014-12-07 16:17:32.597884	\N
13052	102	2	2014-12-07 16:17:32.600134	\N
13053	102	2	2014-12-07 16:17:32.602544	\N
13054	102	5	2014-12-07 16:17:32.604808	\N
13055	102	5	2014-12-07 16:17:32.607396	\N
13056	102	8	2014-12-07 16:17:32.609497	\N
13057	102	2	2014-12-07 16:17:32.611616	\N
13058	102	2	2014-12-07 16:17:32.613794	\N
13059	102	2	2014-12-07 16:17:32.615793	\N
13060	102	18	2014-12-07 16:17:32.617946	\N
13061	102	7	2014-12-07 16:17:32.619977	\N
13062	102	5	2014-12-07 16:17:32.622009	\N
13063	102	8	2014-12-07 16:17:32.623949	\N
13064	102	8	2014-12-07 16:17:32.625953	\N
13065	102	8	2014-12-07 16:17:32.628044	\N
13066	102	8	2014-12-07 16:17:32.630243	\N
13067	102	8	2014-12-07 16:17:32.632438	\N
13068	102	8	2014-12-07 16:17:32.634555	\N
13069	102	18	2014-12-07 16:17:32.63664	\N
13070	102	18	2014-12-07 16:17:32.63873	\N
13071	102	18	2014-12-07 16:17:32.640745	\N
13072	102	18	2014-12-07 16:17:32.642736	\N
13073	102	18	2014-12-07 16:17:32.644916	\N
13074	102	18	2014-12-07 16:17:32.647208	\N
13075	102	18	2014-12-07 16:17:32.649533	\N
13076	102	4	2014-12-07 16:17:32.651707	\N
13077	102	4	2014-12-07 16:17:32.653819	\N
13078	102	4	2014-12-07 16:17:32.655849	\N
13079	102	4	2014-12-07 16:17:32.657866	\N
13080	102	4	2014-12-07 16:17:32.659868	\N
13081	102	4	2014-12-07 16:17:32.671986	\N
13082	102	4	2014-12-07 16:17:32.674518	\N
13083	102	4	2014-12-07 16:17:32.677776	\N
13084	102	11	2014-12-07 16:17:32.681272	\N
13085	102	11	2014-12-07 16:17:32.684002	\N
13086	102	11	2014-12-07 16:17:32.688863	\N
13087	102	19	2014-12-07 16:17:32.691195	\N
13088	102	19	2014-12-07 16:17:32.693398	\N
13089	102	15	2014-12-07 16:17:32.695751	\N
13090	102	15	2014-12-07 16:17:32.698067	\N
13091	102	19	2014-12-07 16:17:32.700988	\N
13092	102	7	2014-12-07 16:17:32.703916	\N
13093	102	2	2014-12-07 16:17:32.706165	\N
13094	102	9	2014-12-07 16:17:32.708672	\N
13095	102	9	2014-12-07 16:17:32.711099	\N
13096	102	9	2014-12-07 16:17:32.714569	\N
13097	102	9	2014-12-07 16:17:32.717556	\N
13098	102	9	2014-12-07 16:17:32.719958	\N
13099	102	3	2014-12-07 16:17:32.722229	\N
13100	102	21	2014-12-07 16:17:32.724454	\N
13101	102	8	2014-12-07 16:17:32.726605	\N
13102	102	13	2014-12-07 16:17:32.728882	\N
13103	102	8	2014-12-07 16:17:32.731823	\N
13104	102	2	2014-12-07 16:17:32.734242	\N
13105	102	18	2014-12-07 16:17:32.736476	\N
13106	102	16	2014-12-07 16:17:32.738668	\N
13107	102	16	2014-12-07 16:17:32.740801	\N
13108	102	15	2014-12-07 16:17:32.742977	\N
13109	102	15	2014-12-07 16:17:32.745115	\N
13110	102	7	2014-12-07 16:17:32.747107	\N
13111	102	7	2014-12-07 16:17:32.749122	\N
13112	102	7	2014-12-07 16:17:32.751211	\N
13113	102	7	2014-12-07 16:17:32.753307	\N
13114	102	7	2014-12-07 16:17:32.75543	\N
13115	102	7	2014-12-07 16:17:32.757519	\N
13116	102	18	2014-12-07 16:17:32.75961	\N
13117	102	2	2014-12-07 16:17:32.761734	\N
13118	102	7	2014-12-07 16:17:32.763862	\N
13119	102	2	2014-12-07 16:17:32.766062	\N
13120	102	7	2014-12-07 16:17:32.768351	\N
13121	102	6	2014-12-07 16:17:32.770886	\N
13122	102	20	2014-12-07 16:17:32.773107	\N
13123	102	20	2014-12-07 16:17:32.775071	\N
13124	102	12	2014-12-07 16:17:32.777086	\N
13125	102	3	2014-12-07 16:17:32.779588	\N
13126	102	5	2014-12-07 16:17:32.781983	\N
13127	102	10	2014-12-07 16:17:32.784738	\N
13128	102	10	2014-12-07 16:17:32.787171	\N
13129	102	5	2014-12-07 16:17:32.789342	\N
13130	102	5	2014-12-07 16:17:32.791564	\N
13131	102	8	2014-12-07 16:17:32.793696	\N
13132	102	22	2014-12-07 16:17:32.795954	\N
13133	102	11	2014-12-07 16:17:32.79815	\N
13134	102	10	2014-12-07 16:17:32.800257	\N
13135	102	22	2014-12-07 16:17:32.80263	\N
13136	102	22	2014-12-07 16:17:32.804812	\N
13137	102	22	2014-12-07 16:17:32.806987	\N
13138	102	20	2014-12-07 16:17:32.809039	\N
13139	102	20	2014-12-07 16:17:32.81116	\N
13140	102	20	2014-12-07 16:17:32.813265	\N
13141	102	20	2014-12-07 16:17:32.815269	\N
13142	102	21	2014-12-07 16:17:32.817403	\N
13143	102	21	2014-12-07 16:17:32.819627	\N
13144	102	21	2014-12-07 16:17:32.821927	\N
13145	102	21	2014-12-07 16:17:32.824019	\N
13146	102	21	2014-12-07 16:17:32.826146	\N
13147	102	21	2014-12-07 16:17:32.828289	\N
13148	102	12	2014-12-07 16:17:32.830342	\N
13149	102	12	2014-12-07 16:17:32.832407	\N
13150	102	12	2014-12-07 16:17:32.83462	\N
13151	102	21	2014-12-07 16:17:32.836764	\N
13152	103	2	2014-12-07 16:17:32.958994	\N
13153	103	2	2014-12-07 16:17:32.964087	\N
13154	103	2	2014-12-07 16:17:32.966353	\N
13155	103	2	2014-12-07 16:17:32.968584	\N
13156	103	5	2014-12-07 16:17:32.970735	\N
13157	103	5	2014-12-07 16:17:32.97287	\N
13158	103	8	2014-12-07 16:17:32.97491	\N
13159	103	2	2014-12-07 16:17:32.976984	\N
13160	103	2	2014-12-07 16:17:32.979053	\N
13161	103	2	2014-12-07 16:17:32.981201	\N
13162	103	18	2014-12-07 16:17:32.983224	\N
13163	103	7	2014-12-07 16:17:32.985513	\N
13164	103	5	2014-12-07 16:17:32.987511	\N
13165	103	8	2014-12-07 16:17:32.98951	\N
13166	103	8	2014-12-07 16:17:32.991488	\N
13167	103	8	2014-12-07 16:17:32.993637	\N
13168	103	8	2014-12-07 16:17:32.995953	\N
13169	103	8	2014-12-07 16:17:32.998113	\N
13170	103	8	2014-12-07 16:17:33.000239	\N
13171	103	18	2014-12-07 16:17:33.002305	\N
13172	103	18	2014-12-07 16:17:33.004369	\N
13173	103	18	2014-12-07 16:17:33.006728	\N
13174	103	18	2014-12-07 16:17:33.009188	\N
13175	103	18	2014-12-07 16:17:33.011382	\N
13176	103	18	2014-12-07 16:17:33.013507	\N
13177	103	18	2014-12-07 16:17:33.01556	\N
13178	103	4	2014-12-07 16:17:33.01761	\N
13179	103	4	2014-12-07 16:17:33.019858	\N
13180	103	4	2014-12-07 16:17:33.021937	\N
13181	103	4	2014-12-07 16:17:33.024051	\N
13182	103	4	2014-12-07 16:17:33.026076	\N
13183	103	4	2014-12-07 16:17:33.028254	\N
13184	103	4	2014-12-07 16:17:33.030366	\N
13185	103	4	2014-12-07 16:17:33.03242	\N
13186	103	11	2014-12-07 16:17:33.034461	\N
13187	103	11	2014-12-07 16:17:33.036776	\N
13188	103	11	2014-12-07 16:17:33.038928	\N
13189	103	19	2014-12-07 16:17:33.040983	\N
13190	103	19	2014-12-07 16:17:33.043021	\N
13191	103	15	2014-12-07 16:17:33.045037	\N
13192	103	15	2014-12-07 16:17:33.047066	\N
13193	103	19	2014-12-07 16:17:33.0491	\N
13194	103	7	2014-12-07 16:17:33.051169	\N
13195	103	2	2014-12-07 16:17:33.053369	\N
13196	103	9	2014-12-07 16:17:33.055344	\N
13197	103	9	2014-12-07 16:17:33.05741	\N
13198	103	9	2014-12-07 16:17:33.059409	\N
13199	103	9	2014-12-07 16:17:33.061459	\N
13200	103	9	2014-12-07 16:17:33.06339	\N
13201	103	3	2014-12-07 16:17:33.065449	\N
13202	103	21	2014-12-07 16:17:33.067358	\N
13203	103	8	2014-12-07 16:17:33.069572	\N
13204	103	13	2014-12-07 16:17:33.071606	\N
13205	103	8	2014-12-07 16:17:33.073644	\N
13206	103	2	2014-12-07 16:17:33.075631	\N
13207	103	18	2014-12-07 16:17:33.077642	\N
13208	103	16	2014-12-07 16:17:33.079634	\N
13209	103	16	2014-12-07 16:17:33.081642	\N
13210	103	15	2014-12-07 16:17:33.083585	\N
13211	103	15	2014-12-07 16:17:33.085725	\N
13212	103	7	2014-12-07 16:17:33.08783	\N
13213	103	7	2014-12-07 16:17:33.089901	\N
13214	103	7	2014-12-07 16:17:33.092003	\N
13215	103	7	2014-12-07 16:17:33.094046	\N
13216	103	7	2014-12-07 16:17:33.096164	\N
13217	103	7	2014-12-07 16:17:33.098292	\N
13218	103	18	2014-12-07 16:17:33.10057	\N
13219	103	2	2014-12-07 16:17:33.103004	\N
13220	103	7	2014-12-07 16:17:33.10555	\N
13221	103	2	2014-12-07 16:17:33.1076	\N
13222	103	7	2014-12-07 16:17:33.109712	\N
13223	103	6	2014-12-07 16:17:33.112192	\N
13224	103	20	2014-12-07 16:17:33.114572	\N
13225	103	20	2014-12-07 16:17:33.11666	\N
13226	103	12	2014-12-07 16:17:33.118816	\N
13227	103	3	2014-12-07 16:17:33.120984	\N
13228	103	5	2014-12-07 16:17:33.123065	\N
13229	103	10	2014-12-07 16:17:33.125108	\N
13230	103	10	2014-12-07 16:17:33.127116	\N
13231	103	5	2014-12-07 16:17:33.129198	\N
13232	103	5	2014-12-07 16:17:33.131276	\N
13233	103	8	2014-12-07 16:17:33.133293	\N
13234	103	22	2014-12-07 16:17:33.135364	\N
13235	103	11	2014-12-07 16:17:33.137526	\N
13236	103	10	2014-12-07 16:17:33.139631	\N
13237	103	22	2014-12-07 16:17:33.141637	\N
13238	103	22	2014-12-07 16:17:33.143881	\N
13239	103	22	2014-12-07 16:17:33.145926	\N
13240	103	20	2014-12-07 16:17:33.148021	\N
13241	103	20	2014-12-07 16:17:33.150179	\N
13242	103	20	2014-12-07 16:17:33.152425	\N
13243	103	20	2014-12-07 16:17:33.154522	\N
13244	103	21	2014-12-07 16:17:33.156578	\N
13245	103	21	2014-12-07 16:17:33.158707	\N
13246	103	21	2014-12-07 16:17:33.160785	\N
13247	103	21	2014-12-07 16:17:33.1629	\N
13248	103	21	2014-12-07 16:17:33.165092	\N
13249	103	21	2014-12-07 16:17:33.167081	\N
13250	103	12	2014-12-07 16:17:33.169255	\N
13251	103	12	2014-12-07 16:17:33.17129	\N
13252	103	12	2014-12-07 16:17:33.173369	\N
13253	103	21	2014-12-07 16:17:33.175315	\N
13254	103	12	2014-12-07 16:17:33.177345	\N
13255	104	2	2014-12-07 16:17:34.985908	\N
13256	104	2	2014-12-07 16:17:34.989435	\N
13257	104	2	2014-12-07 16:17:34.992112	\N
13258	104	2	2014-12-07 16:17:34.994482	\N
13259	104	5	2014-12-07 16:17:34.996645	\N
13260	104	5	2014-12-07 16:17:34.998872	\N
13261	104	8	2014-12-07 16:17:35.000924	\N
13262	104	2	2014-12-07 16:17:35.003019	\N
13263	104	2	2014-12-07 16:17:35.005014	\N
13264	104	2	2014-12-07 16:17:35.007209	\N
13265	104	18	2014-12-07 16:17:35.00971	\N
13266	104	7	2014-12-07 16:17:35.011832	\N
13267	104	5	2014-12-07 16:17:35.014199	\N
13268	104	8	2014-12-07 16:17:35.016527	\N
13269	104	8	2014-12-07 16:17:35.018606	\N
13270	104	8	2014-12-07 16:17:35.020663	\N
13271	104	8	2014-12-07 16:17:35.022661	\N
13272	104	8	2014-12-07 16:17:35.024794	\N
13273	104	8	2014-12-07 16:17:35.026851	\N
13274	104	18	2014-12-07 16:17:35.028931	\N
13275	104	18	2014-12-07 16:17:35.031031	\N
13276	104	18	2014-12-07 16:17:35.033051	\N
13277	104	18	2014-12-07 16:17:35.035011	\N
13278	104	18	2014-12-07 16:17:35.036963	\N
13279	104	18	2014-12-07 16:17:35.039025	\N
13280	104	18	2014-12-07 16:17:35.041045	\N
13281	104	4	2014-12-07 16:17:35.043102	\N
13282	104	4	2014-12-07 16:17:35.045282	\N
13283	104	4	2014-12-07 16:17:35.047477	\N
13284	104	4	2014-12-07 16:17:35.0495	\N
13285	104	4	2014-12-07 16:17:35.051558	\N
13286	104	4	2014-12-07 16:17:35.053633	\N
13287	104	4	2014-12-07 16:17:35.055684	\N
13288	104	4	2014-12-07 16:17:35.057737	\N
13289	104	11	2014-12-07 16:17:35.059867	\N
13290	104	11	2014-12-07 16:17:35.06189	\N
13291	104	11	2014-12-07 16:17:35.063907	\N
13292	104	19	2014-12-07 16:17:35.065895	\N
13293	104	19	2014-12-07 16:17:35.067896	\N
13294	104	15	2014-12-07 16:17:35.069971	\N
13295	104	15	2014-12-07 16:17:35.071984	\N
13296	104	19	2014-12-07 16:17:35.074389	\N
13297	104	7	2014-12-07 16:17:35.076574	\N
13298	104	2	2014-12-07 16:17:35.078636	\N
13299	104	9	2014-12-07 16:17:35.080694	\N
13300	104	9	2014-12-07 16:17:35.08281	\N
13301	104	9	2014-12-07 16:17:35.084873	\N
13302	104	9	2014-12-07 16:17:35.08688	\N
13303	104	9	2014-12-07 16:17:35.088861	\N
13304	104	3	2014-12-07 16:17:35.090909	\N
13305	104	21	2014-12-07 16:17:35.092961	\N
13306	104	8	2014-12-07 16:17:35.094995	\N
13307	104	13	2014-12-07 16:17:35.096946	\N
13308	104	8	2014-12-07 16:17:35.099	\N
13309	104	2	2014-12-07 16:17:35.101172	\N
13310	104	18	2014-12-07 16:17:35.103226	\N
13311	104	16	2014-12-07 16:17:35.105287	\N
13312	104	16	2014-12-07 16:17:35.10737	\N
13313	104	15	2014-12-07 16:17:35.11109	\N
13314	104	15	2014-12-07 16:17:35.114295	\N
13315	104	7	2014-12-07 16:17:35.116596	\N
13316	104	7	2014-12-07 16:17:35.118693	\N
13317	104	7	2014-12-07 16:17:35.120851	\N
13318	104	7	2014-12-07 16:17:35.122984	\N
13319	104	7	2014-12-07 16:17:35.125081	\N
13320	104	7	2014-12-07 16:17:35.127073	\N
13321	104	18	2014-12-07 16:17:35.129229	\N
13322	104	2	2014-12-07 16:17:35.131349	\N
13323	104	7	2014-12-07 16:17:35.133503	\N
13324	104	2	2014-12-07 16:17:35.135591	\N
13325	104	7	2014-12-07 16:17:35.137641	\N
13326	104	6	2014-12-07 16:17:35.139728	\N
13327	104	20	2014-12-07 16:17:35.141891	\N
13328	104	20	2014-12-07 16:17:35.144044	\N
13329	104	12	2014-12-07 16:17:35.146129	\N
13330	104	3	2014-12-07 16:17:35.1482	\N
13331	104	5	2014-12-07 16:17:35.150282	\N
13332	104	10	2014-12-07 16:17:35.152334	\N
13333	104	10	2014-12-07 16:17:35.154403	\N
13334	104	5	2014-12-07 16:17:35.15642	\N
13335	104	5	2014-12-07 16:17:35.158607	\N
13336	104	8	2014-12-07 16:17:35.160716	\N
13337	104	22	2014-12-07 16:17:35.162856	\N
13338	104	11	2014-12-07 16:17:35.164952	\N
13339	104	10	2014-12-07 16:17:35.166982	\N
13340	104	22	2014-12-07 16:17:35.169219	\N
13341	104	22	2014-12-07 16:17:35.171244	\N
13342	104	22	2014-12-07 16:17:35.173236	\N
13343	104	20	2014-12-07 16:17:35.175256	\N
13344	104	20	2014-12-07 16:17:35.177289	\N
13345	104	20	2014-12-07 16:17:35.179352	\N
13346	104	20	2014-12-07 16:17:35.181552	\N
13347	104	21	2014-12-07 16:17:35.183633	\N
13348	104	21	2014-12-07 16:17:35.185629	\N
13349	104	21	2014-12-07 16:17:35.18766	\N
13350	104	21	2014-12-07 16:17:35.189668	\N
13351	104	21	2014-12-07 16:17:35.191845	\N
13352	104	21	2014-12-07 16:17:35.193889	\N
13353	104	12	2014-12-07 16:17:35.195916	\N
13354	104	12	2014-12-07 16:17:35.197929	\N
13355	104	12	2014-12-07 16:17:35.200028	\N
13356	104	21	2014-12-07 16:17:35.20247	\N
13357	104	12	2014-12-07 16:17:35.204646	\N
13358	104	12	2014-12-07 16:17:35.206738	\N
13359	105	2	2014-12-07 16:17:35.811087	\N
13360	105	2	2014-12-07 16:17:35.815599	\N
13361	105	2	2014-12-07 16:17:35.81821	\N
13362	105	2	2014-12-07 16:17:35.820561	\N
13363	105	5	2014-12-07 16:17:35.823233	\N
13364	105	5	2014-12-07 16:17:35.825648	\N
13365	105	8	2014-12-07 16:17:35.82817	\N
13366	105	2	2014-12-07 16:17:35.830557	\N
13367	105	2	2014-12-07 16:17:35.83285	\N
13368	105	2	2014-12-07 16:17:35.835564	\N
13369	105	18	2014-12-07 16:17:35.837966	\N
13370	105	7	2014-12-07 16:17:35.840348	\N
13371	105	5	2014-12-07 16:17:35.842706	\N
13372	105	8	2014-12-07 16:17:35.8459	\N
13373	105	8	2014-12-07 16:17:35.848695	\N
13374	105	8	2014-12-07 16:17:35.851261	\N
13375	105	8	2014-12-07 16:17:35.854177	\N
13376	105	8	2014-12-07 16:17:35.856643	\N
13377	105	8	2014-12-07 16:17:35.858968	\N
13378	105	18	2014-12-07 16:17:35.862029	\N
13379	105	18	2014-12-07 16:17:35.866727	\N
13380	105	18	2014-12-07 16:17:35.869274	\N
13381	105	18	2014-12-07 16:17:35.871631	\N
13382	105	18	2014-12-07 16:17:35.874017	\N
13383	105	18	2014-12-07 16:17:35.876355	\N
13384	105	18	2014-12-07 16:17:35.878714	\N
13385	105	4	2014-12-07 16:17:35.881073	\N
13386	105	4	2014-12-07 16:17:35.883414	\N
13387	105	4	2014-12-07 16:17:35.885718	\N
13388	105	4	2014-12-07 16:17:35.888219	\N
13389	105	4	2014-12-07 16:17:35.890579	\N
13390	105	4	2014-12-07 16:17:35.892857	\N
13391	105	4	2014-12-07 16:17:35.895272	\N
13392	105	4	2014-12-07 16:17:35.897644	\N
13393	105	11	2014-12-07 16:17:35.900128	\N
13394	105	11	2014-12-07 16:17:35.902587	\N
13395	105	11	2014-12-07 16:17:35.905235	\N
13396	105	19	2014-12-07 16:17:35.907618	\N
13397	105	19	2014-12-07 16:17:35.909903	\N
13398	105	15	2014-12-07 16:17:35.912532	\N
13399	105	15	2014-12-07 16:17:35.915568	\N
13400	105	19	2014-12-07 16:17:35.918681	\N
13401	105	7	2014-12-07 16:17:35.921297	\N
13402	105	2	2014-12-07 16:17:35.923647	\N
13403	105	9	2014-12-07 16:17:35.926042	\N
13404	105	9	2014-12-07 16:17:35.928634	\N
13405	105	9	2014-12-07 16:17:35.931159	\N
13406	105	9	2014-12-07 16:17:35.93362	\N
13407	105	9	2014-12-07 16:17:35.936035	\N
13408	105	3	2014-12-07 16:17:35.938398	\N
13409	105	21	2014-12-07 16:17:35.940689	\N
13410	105	8	2014-12-07 16:17:35.943094	\N
13411	105	13	2014-12-07 16:17:35.946153	\N
13412	105	8	2014-12-07 16:17:35.94864	\N
13413	105	2	2014-12-07 16:17:35.95108	\N
13414	105	18	2014-12-07 16:17:35.953435	\N
13415	105	16	2014-12-07 16:17:35.955737	\N
13416	105	16	2014-12-07 16:17:35.958235	\N
13417	105	15	2014-12-07 16:17:35.960623	\N
13418	105	15	2014-12-07 16:17:35.963174	\N
13419	105	7	2014-12-07 16:17:35.965705	\N
13420	105	7	2014-12-07 16:17:35.968044	\N
13421	105	7	2014-12-07 16:17:35.970384	\N
13422	105	7	2014-12-07 16:17:35.972663	\N
13423	105	7	2014-12-07 16:17:35.974947	\N
13424	105	7	2014-12-07 16:17:35.977552	\N
13425	105	18	2014-12-07 16:17:35.979932	\N
13426	105	2	2014-12-07 16:17:35.982358	\N
13427	105	7	2014-12-07 16:17:35.984679	\N
13428	105	2	2014-12-07 16:17:35.986953	\N
13429	105	7	2014-12-07 16:17:35.989323	\N
13430	105	6	2014-12-07 16:17:35.99163	\N
13431	105	20	2014-12-07 16:17:35.99423	\N
13432	105	20	2014-12-07 16:17:35.996574	\N
13433	105	12	2014-12-07 16:17:35.999077	\N
13434	105	3	2014-12-07 16:17:36.001691	\N
13435	105	5	2014-12-07 16:17:36.004189	\N
13436	105	10	2014-12-07 16:17:36.006604	\N
13437	105	10	2014-12-07 16:17:36.009239	\N
13438	105	5	2014-12-07 16:17:36.012122	\N
13439	105	5	2014-12-07 16:17:36.014665	\N
13440	105	8	2014-12-07 16:17:36.01705	\N
13441	105	22	2014-12-07 16:17:36.019409	\N
13442	105	11	2014-12-07 16:17:36.021818	\N
13443	105	10	2014-12-07 16:17:36.024205	\N
13444	105	22	2014-12-07 16:17:36.02656	\N
13445	105	22	2014-12-07 16:17:36.02975	\N
13446	105	22	2014-12-07 16:17:36.032581	\N
13447	105	20	2014-12-07 16:17:36.03498	\N
13448	105	20	2014-12-07 16:17:36.037325	\N
13449	105	20	2014-12-07 16:17:36.039605	\N
13450	105	20	2014-12-07 16:17:36.042161	\N
13451	105	21	2014-12-07 16:17:36.044684	\N
13452	105	21	2014-12-07 16:17:36.04766	\N
13453	105	21	2014-12-07 16:17:36.050115	\N
13454	105	21	2014-12-07 16:17:36.052425	\N
13455	105	21	2014-12-07 16:17:36.055098	\N
13456	105	21	2014-12-07 16:17:36.057499	\N
13457	105	12	2014-12-07 16:17:36.059787	\N
13458	105	12	2014-12-07 16:17:36.062942	\N
13459	105	12	2014-12-07 16:17:36.065809	\N
13460	105	21	2014-12-07 16:17:36.068109	\N
13461	105	12	2014-12-07 16:17:36.070456	\N
13462	105	12	2014-12-07 16:17:36.072815	\N
13463	105	12	2014-12-07 16:17:36.075163	\N
13464	106	2	2014-12-07 16:17:36.229624	\N
13465	106	2	2014-12-07 16:17:36.233285	\N
13466	106	2	2014-12-07 16:17:36.235734	\N
13467	106	2	2014-12-07 16:17:36.238064	\N
13468	106	5	2014-12-07 16:17:36.240638	\N
13469	106	5	2014-12-07 16:17:36.243062	\N
13470	106	8	2014-12-07 16:17:36.245765	\N
13471	106	2	2014-12-07 16:17:36.248232	\N
13472	106	2	2014-12-07 16:17:36.250606	\N
13473	106	2	2014-12-07 16:17:36.25289	\N
13474	106	18	2014-12-07 16:17:36.255162	\N
13475	106	7	2014-12-07 16:17:36.257598	\N
13476	106	5	2014-12-07 16:17:36.260036	\N
13477	106	8	2014-12-07 16:17:36.262927	\N
13478	106	8	2014-12-07 16:17:36.26538	\N
13479	106	8	2014-12-07 16:17:36.267646	\N
13480	106	8	2014-12-07 16:17:36.269902	\N
13481	106	8	2014-12-07 16:17:36.272161	\N
13482	106	8	2014-12-07 16:17:36.27489	\N
13483	106	18	2014-12-07 16:17:36.277387	\N
13484	106	18	2014-12-07 16:17:36.279762	\N
13485	106	18	2014-12-07 16:17:36.282103	\N
13486	106	18	2014-12-07 16:17:36.285141	\N
13487	106	18	2014-12-07 16:17:36.287682	\N
13488	106	18	2014-12-07 16:17:36.290509	\N
13489	106	18	2014-12-07 16:17:36.2928	\N
13490	106	4	2014-12-07 16:17:36.295117	\N
13491	106	4	2014-12-07 16:17:36.297535	\N
13492	106	4	2014-12-07 16:17:36.299945	\N
13493	106	4	2014-12-07 16:17:36.302301	\N
13494	106	4	2014-12-07 16:17:36.304589	\N
13495	106	4	2014-12-07 16:17:36.30683	\N
13496	106	4	2014-12-07 16:17:36.309618	\N
13497	106	4	2014-12-07 16:17:36.312125	\N
13498	106	11	2014-12-07 16:17:36.314739	\N
13499	106	11	2014-12-07 16:17:36.317068	\N
13500	106	11	2014-12-07 16:17:36.319588	\N
13501	106	19	2014-12-07 16:17:36.321903	\N
13502	106	19	2014-12-07 16:17:36.324274	\N
13503	106	15	2014-12-07 16:17:36.326591	\N
13504	106	15	2014-12-07 16:17:36.329154	\N
13505	106	19	2014-12-07 16:17:36.331569	\N
13506	106	7	2014-12-07 16:17:36.333838	\N
13507	106	2	2014-12-07 16:17:36.33607	\N
13508	106	9	2014-12-07 16:17:36.33856	\N
13509	106	9	2014-12-07 16:17:36.340863	\N
13510	106	9	2014-12-07 16:17:36.343144	\N
13511	106	9	2014-12-07 16:17:36.345527	\N
13512	106	9	2014-12-07 16:17:36.34797	\N
13513	106	3	2014-12-07 16:17:36.350365	\N
13514	106	21	2014-12-07 16:17:36.352682	\N
13515	106	8	2014-12-07 16:17:36.354973	\N
13516	106	13	2014-12-07 16:17:36.357388	\N
13517	106	8	2014-12-07 16:17:36.359707	\N
13518	106	2	2014-12-07 16:17:36.36198	\N
13519	106	18	2014-12-07 16:17:36.364657	\N
13520	106	16	2014-12-07 16:17:36.367025	\N
13521	106	16	2014-12-07 16:17:36.369314	\N
13522	106	15	2014-12-07 16:17:36.371553	\N
13523	106	15	2014-12-07 16:17:36.373835	\N
13524	106	7	2014-12-07 16:17:36.376048	\N
13525	106	7	2014-12-07 16:17:36.378376	\N
13526	106	7	2014-12-07 16:17:36.380799	\N
13527	106	7	2014-12-07 16:17:36.383407	\N
13528	106	7	2014-12-07 16:17:36.38579	\N
13529	106	7	2014-12-07 16:17:36.388113	\N
13530	106	18	2014-12-07 16:17:36.390455	\N
13531	106	2	2014-12-07 16:17:36.39273	\N
13532	106	7	2014-12-07 16:17:36.395015	\N
13533	106	2	2014-12-07 16:17:36.398378	\N
13534	106	7	2014-12-07 16:17:36.400988	\N
13535	106	6	2014-12-07 16:17:36.403336	\N
13536	106	20	2014-12-07 16:17:36.405634	\N
13537	106	20	2014-12-07 16:17:36.407915	\N
13538	106	12	2014-12-07 16:17:36.410198	\N
13539	106	3	2014-12-07 16:17:36.412669	\N
13540	106	5	2014-12-07 16:17:36.415448	\N
13541	106	10	2014-12-07 16:17:36.417933	\N
13542	106	10	2014-12-07 16:17:36.420233	\N
13543	106	5	2014-12-07 16:17:36.422586	\N
13544	106	5	2014-12-07 16:17:36.42495	\N
13545	106	8	2014-12-07 16:17:36.427211	\N
13546	106	22	2014-12-07 16:17:36.429745	\N
13547	106	11	2014-12-07 16:17:36.432097	\N
13548	106	10	2014-12-07 16:17:36.434435	\N
13549	106	22	2014-12-07 16:17:36.436696	\N
13550	106	22	2014-12-07 16:17:36.438961	\N
13551	106	22	2014-12-07 16:17:36.441185	\N
13552	106	20	2014-12-07 16:17:36.44354	\N
13553	106	20	2014-12-07 16:17:36.445883	\N
13554	106	20	2014-12-07 16:17:36.448219	\N
13555	106	20	2014-12-07 16:17:36.450852	\N
13556	106	21	2014-12-07 16:17:36.453192	\N
13557	106	21	2014-12-07 16:17:36.455559	\N
13558	106	21	2014-12-07 16:17:36.459077	\N
13559	106	21	2014-12-07 16:17:36.461937	\N
13560	106	21	2014-12-07 16:17:36.465278	\N
13561	106	21	2014-12-07 16:17:36.467859	\N
13562	106	12	2014-12-07 16:17:36.470795	\N
13563	106	12	2014-12-07 16:17:36.473547	\N
13564	106	12	2014-12-07 16:17:36.476114	\N
13565	106	21	2014-12-07 16:17:36.478688	\N
13566	106	12	2014-12-07 16:17:36.482114	\N
13567	106	12	2014-12-07 16:17:36.484695	\N
13568	106	12	2014-12-07 16:17:36.487002	\N
13569	106	6	2014-12-07 16:17:36.489267	\N
13570	107	2	2014-12-07 16:17:38.074335	\N
13571	107	2	2014-12-07 16:17:38.077733	\N
13572	107	2	2014-12-07 16:17:38.080245	\N
13573	107	2	2014-12-07 16:17:38.082332	\N
13574	107	5	2014-12-07 16:17:38.084329	\N
13575	107	5	2014-12-07 16:17:38.086386	\N
13576	107	8	2014-12-07 16:17:38.088521	\N
13577	107	2	2014-12-07 16:17:38.090628	\N
13578	107	2	2014-12-07 16:17:38.092604	\N
13579	107	2	2014-12-07 16:17:38.094614	\N
13580	107	18	2014-12-07 16:17:38.096703	\N
13581	107	7	2014-12-07 16:17:38.09884	\N
13582	107	5	2014-12-07 16:17:38.100965	\N
13583	107	8	2014-12-07 16:17:38.103254	\N
13584	107	8	2014-12-07 16:17:38.10551	\N
13585	107	8	2014-12-07 16:17:38.107607	\N
13586	107	8	2014-12-07 16:17:38.109747	\N
13587	107	8	2014-12-07 16:17:38.111812	\N
13588	107	8	2014-12-07 16:17:38.113949	\N
13589	107	18	2014-12-07 16:17:38.116252	\N
13590	107	18	2014-12-07 16:17:38.118368	\N
13591	107	18	2014-12-07 16:17:38.120604	\N
13592	107	18	2014-12-07 16:17:38.12276	\N
13593	107	18	2014-12-07 16:17:38.124945	\N
13594	107	18	2014-12-07 16:17:38.126926	\N
13595	107	18	2014-12-07 16:17:38.12895	\N
13596	107	4	2014-12-07 16:17:38.131017	\N
13597	107	4	2014-12-07 16:17:38.13315	\N
13598	107	4	2014-12-07 16:17:38.135717	\N
13599	107	4	2014-12-07 16:17:38.137985	\N
13600	107	4	2014-12-07 16:17:38.140028	\N
13601	107	4	2014-12-07 16:17:38.142075	\N
13602	107	4	2014-12-07 16:17:38.144882	\N
13603	107	4	2014-12-07 16:17:38.147156	\N
13604	107	11	2014-12-07 16:17:38.149317	\N
13605	107	11	2014-12-07 16:17:38.15182	\N
13606	107	11	2014-12-07 16:17:38.154227	\N
13607	107	19	2014-12-07 16:17:38.156472	\N
13608	107	19	2014-12-07 16:17:38.158739	\N
13609	107	15	2014-12-07 16:17:38.161037	\N
13610	107	15	2014-12-07 16:17:38.16375	\N
13611	107	19	2014-12-07 16:17:38.166594	\N
13612	107	7	2014-12-07 16:17:38.169091	\N
13613	107	2	2014-12-07 16:17:38.171541	\N
13614	107	9	2014-12-07 16:17:38.173883	\N
13615	107	9	2014-12-07 16:17:38.176027	\N
13616	107	9	2014-12-07 16:17:38.178348	\N
13617	107	9	2014-12-07 16:17:38.180454	\N
13618	107	9	2014-12-07 16:17:38.182654	\N
13619	107	3	2014-12-07 16:17:38.184785	\N
13620	107	21	2014-12-07 16:17:38.186994	\N
13621	107	8	2014-12-07 16:17:38.189087	\N
13622	107	13	2014-12-07 16:17:38.191165	\N
13623	107	8	2014-12-07 16:17:38.193238	\N
13624	107	2	2014-12-07 16:17:38.195313	\N
13625	107	18	2014-12-07 16:17:38.19728	\N
13626	107	16	2014-12-07 16:17:38.199268	\N
13627	107	16	2014-12-07 16:17:38.201317	\N
13628	107	15	2014-12-07 16:17:38.203471	\N
13629	107	15	2014-12-07 16:17:38.205473	\N
13630	107	7	2014-12-07 16:17:38.20762	\N
13631	107	7	2014-12-07 16:17:38.209837	\N
13632	107	7	2014-12-07 16:17:38.212035	\N
13633	107	7	2014-12-07 16:17:38.214131	\N
13634	107	7	2014-12-07 16:17:38.216187	\N
13635	107	7	2014-12-07 16:17:38.218324	\N
13636	107	18	2014-12-07 16:17:38.220426	\N
13637	107	2	2014-12-07 16:17:38.222468	\N
13638	107	7	2014-12-07 16:17:38.22456	\N
13639	107	2	2014-12-07 16:17:38.226568	\N
13640	107	7	2014-12-07 16:17:38.228545	\N
13641	107	6	2014-12-07 16:17:38.230603	\N
13642	107	20	2014-12-07 16:17:38.232704	\N
13643	107	20	2014-12-07 16:17:38.234812	\N
13644	107	12	2014-12-07 16:17:38.236932	\N
13645	107	3	2014-12-07 16:17:38.239005	\N
13646	107	5	2014-12-07 16:17:38.24117	\N
13647	107	10	2014-12-07 16:17:38.243121	\N
13648	107	10	2014-12-07 16:17:38.245134	\N
13649	107	5	2014-12-07 16:17:38.246984	\N
13650	107	5	2014-12-07 16:17:38.249034	\N
13651	107	8	2014-12-07 16:17:38.251129	\N
13652	107	22	2014-12-07 16:17:38.253411	\N
13653	107	11	2014-12-07 16:17:38.255671	\N
13654	107	10	2014-12-07 16:17:38.257789	\N
13655	107	22	2014-12-07 16:17:38.259957	\N
13656	107	22	2014-12-07 16:17:38.261984	\N
13657	107	22	2014-12-07 16:17:38.264133	\N
13658	107	20	2014-12-07 16:17:38.266291	\N
13659	107	20	2014-12-07 16:17:38.268279	\N
13660	107	20	2014-12-07 16:17:38.27019	\N
13661	107	20	2014-12-07 16:17:38.272272	\N
13662	107	21	2014-12-07 16:17:38.274207	\N
13663	107	21	2014-12-07 16:17:38.276175	\N
13664	107	21	2014-12-07 16:17:38.278263	\N
13665	107	21	2014-12-07 16:17:38.280243	\N
13666	107	21	2014-12-07 16:17:38.282343	\N
13667	107	21	2014-12-07 16:17:38.284286	\N
13668	107	12	2014-12-07 16:17:38.286174	\N
13669	107	12	2014-12-07 16:17:38.288254	\N
13670	107	12	2014-12-07 16:17:38.290246	\N
13671	107	21	2014-12-07 16:17:38.292182	\N
13672	107	12	2014-12-07 16:17:38.294196	\N
13673	107	12	2014-12-07 16:17:38.296148	\N
13674	107	12	2014-12-07 16:17:38.298183	\N
13675	107	6	2014-12-07 16:17:38.300329	\N
13676	107	3	2014-12-07 16:17:38.302369	\N
13677	108	2	2014-12-07 16:17:38.427068	\N
13678	108	2	2014-12-07 16:17:38.430379	\N
13679	108	2	2014-12-07 16:17:38.432871	\N
13680	108	2	2014-12-07 16:17:38.435047	\N
13681	108	5	2014-12-07 16:17:38.437232	\N
13682	108	5	2014-12-07 16:17:38.439318	\N
13683	108	8	2014-12-07 16:17:38.441413	\N
13684	108	2	2014-12-07 16:17:38.443651	\N
13685	108	2	2014-12-07 16:17:38.445989	\N
13686	108	2	2014-12-07 16:17:38.448157	\N
13687	108	18	2014-12-07 16:17:38.450368	\N
13688	108	7	2014-12-07 16:17:38.45249	\N
13689	108	5	2014-12-07 16:17:38.454598	\N
13690	108	8	2014-12-07 16:17:38.456774	\N
13691	108	8	2014-12-07 16:17:38.459075	\N
13692	108	8	2014-12-07 16:17:38.461372	\N
13693	108	8	2014-12-07 16:17:38.463641	\N
13694	108	8	2014-12-07 16:17:38.46608	\N
13695	108	8	2014-12-07 16:17:38.468212	\N
13696	108	18	2014-12-07 16:17:38.470721	\N
13697	108	18	2014-12-07 16:17:38.473355	\N
13698	108	18	2014-12-07 16:17:38.475643	\N
13699	108	18	2014-12-07 16:17:38.477995	\N
13700	108	18	2014-12-07 16:17:38.480155	\N
13701	108	18	2014-12-07 16:17:38.48234	\N
13702	108	18	2014-12-07 16:17:38.484465	\N
13703	108	4	2014-12-07 16:17:38.48654	\N
13704	108	4	2014-12-07 16:17:38.488643	\N
13705	108	4	2014-12-07 16:17:38.490727	\N
13706	108	4	2014-12-07 16:17:38.492908	\N
13707	108	4	2014-12-07 16:17:38.495062	\N
13708	108	4	2014-12-07 16:17:38.497121	\N
13709	108	4	2014-12-07 16:17:38.499236	\N
13710	108	4	2014-12-07 16:17:38.501403	\N
13711	108	11	2014-12-07 16:17:38.503435	\N
13712	108	11	2014-12-07 16:17:38.505504	\N
13713	108	11	2014-12-07 16:17:38.507487	\N
13714	108	19	2014-12-07 16:17:38.509525	\N
13715	108	19	2014-12-07 16:17:38.511513	\N
13716	108	15	2014-12-07 16:17:38.513684	\N
13717	108	15	2014-12-07 16:17:38.515932	\N
13718	108	19	2014-12-07 16:17:38.518196	\N
13719	108	7	2014-12-07 16:17:38.520468	\N
13720	108	2	2014-12-07 16:17:38.52266	\N
13721	108	9	2014-12-07 16:17:38.524847	\N
13722	108	9	2014-12-07 16:17:38.526952	\N
13723	108	9	2014-12-07 16:17:38.529037	\N
13724	108	9	2014-12-07 16:17:38.531123	\N
13725	108	9	2014-12-07 16:17:38.533169	\N
13726	108	3	2014-12-07 16:17:38.535207	\N
13727	108	21	2014-12-07 16:17:38.537409	\N
13728	108	8	2014-12-07 16:17:38.53945	\N
13729	108	13	2014-12-07 16:17:38.541536	\N
13730	108	8	2014-12-07 16:17:38.543485	\N
13731	108	2	2014-12-07 16:17:38.545559	\N
13732	108	18	2014-12-07 16:17:38.54751	\N
13733	108	16	2014-12-07 16:17:38.549553	\N
13734	108	16	2014-12-07 16:17:38.551475	\N
13735	108	15	2014-12-07 16:17:38.553589	\N
13736	108	15	2014-12-07 16:17:38.555603	\N
13737	108	7	2014-12-07 16:17:38.557702	\N
13738	108	7	2014-12-07 16:17:38.5599	\N
13739	108	7	2014-12-07 16:17:38.56198	\N
13740	108	7	2014-12-07 16:17:38.564106	\N
13741	108	7	2014-12-07 16:17:38.56619	\N
13742	108	7	2014-12-07 16:17:38.568435	\N
13743	108	18	2014-12-07 16:17:38.570683	\N
13744	108	2	2014-12-07 16:17:38.572828	\N
13745	108	7	2014-12-07 16:17:38.574927	\N
13746	108	2	2014-12-07 16:17:38.576961	\N
13747	108	7	2014-12-07 16:17:38.579003	\N
13748	108	6	2014-12-07 16:17:38.581064	\N
13749	108	20	2014-12-07 16:17:38.583099	\N
13750	108	20	2014-12-07 16:17:38.585145	\N
13751	108	12	2014-12-07 16:17:38.587202	\N
13752	108	3	2014-12-07 16:17:38.589339	\N
13753	108	5	2014-12-07 16:17:38.591379	\N
13754	108	10	2014-12-07 16:17:38.593397	\N
13755	108	10	2014-12-07 16:17:38.595354	\N
13756	108	5	2014-12-07 16:17:38.597377	\N
13757	108	5	2014-12-07 16:17:38.599438	\N
13758	108	8	2014-12-07 16:17:38.601537	\N
13759	108	22	2014-12-07 16:17:38.60355	\N
13760	108	11	2014-12-07 16:17:38.605627	\N
13761	108	10	2014-12-07 16:17:38.607615	\N
13762	108	22	2014-12-07 16:17:38.609664	\N
13763	108	22	2014-12-07 16:17:38.611649	\N
13764	108	22	2014-12-07 16:17:38.613687	\N
13765	108	20	2014-12-07 16:17:38.615807	\N
13766	108	20	2014-12-07 16:17:38.618259	\N
13767	108	20	2014-12-07 16:17:38.62041	\N
13768	108	20	2014-12-07 16:17:38.622487	\N
13769	108	21	2014-12-07 16:17:38.624516	\N
13770	108	21	2014-12-07 16:17:38.626526	\N
13771	108	21	2014-12-07 16:17:38.628562	\N
13772	108	21	2014-12-07 16:17:38.630843	\N
13773	108	21	2014-12-07 16:17:38.633135	\N
13774	108	21	2014-12-07 16:17:38.635155	\N
13775	108	12	2014-12-07 16:17:38.637313	\N
13776	108	12	2014-12-07 16:17:38.639358	\N
13777	108	12	2014-12-07 16:17:38.641408	\N
13778	108	21	2014-12-07 16:17:38.643349	\N
13779	108	12	2014-12-07 16:17:38.645395	\N
13780	108	12	2014-12-07 16:17:38.647495	\N
13781	108	12	2014-12-07 16:17:38.649616	\N
13782	108	6	2014-12-07 16:17:38.651569	\N
13783	108	3	2014-12-07 16:17:38.653617	\N
13784	108	1	2014-12-07 16:17:38.655718	\N
13785	109	2	2014-12-07 16:17:38.783544	\N
13786	109	2	2014-12-07 16:17:38.786933	\N
13787	109	2	2014-12-07 16:17:38.78965	\N
13788	109	2	2014-12-07 16:17:38.79177	\N
13789	109	5	2014-12-07 16:17:38.793732	\N
13790	109	5	2014-12-07 16:17:38.795773	\N
13791	109	8	2014-12-07 16:17:38.797706	\N
13792	109	2	2014-12-07 16:17:38.799677	\N
13793	109	2	2014-12-07 16:17:38.802167	\N
13794	109	2	2014-12-07 16:17:38.804483	\N
13795	109	18	2014-12-07 16:17:38.806653	\N
13796	109	7	2014-12-07 16:17:38.809005	\N
13797	109	5	2014-12-07 16:17:38.811511	\N
13798	109	8	2014-12-07 16:17:38.813692	\N
13799	109	8	2014-12-07 16:17:38.815776	\N
13800	109	8	2014-12-07 16:17:38.817901	\N
13801	109	8	2014-12-07 16:17:38.820034	\N
13802	109	8	2014-12-07 16:17:38.822439	\N
13803	109	8	2014-12-07 16:17:38.824737	\N
13804	109	18	2014-12-07 16:17:38.826951	\N
13805	109	18	2014-12-07 16:17:38.829458	\N
13806	109	18	2014-12-07 16:17:38.831484	\N
13807	109	18	2014-12-07 16:17:38.833657	\N
13808	109	18	2014-12-07 16:17:38.835712	\N
13809	109	18	2014-12-07 16:17:38.837739	\N
13810	109	18	2014-12-07 16:17:38.839851	\N
13811	109	4	2014-12-07 16:17:38.841897	\N
13812	109	4	2014-12-07 16:17:38.843849	\N
13813	109	4	2014-12-07 16:17:38.845888	\N
13814	109	4	2014-12-07 16:17:38.847829	\N
13815	109	4	2014-12-07 16:17:38.850234	\N
13816	109	4	2014-12-07 16:17:38.852459	\N
13817	109	4	2014-12-07 16:17:38.854681	\N
13818	109	4	2014-12-07 16:17:38.856809	\N
13819	109	11	2014-12-07 16:17:38.858846	\N
13820	109	11	2014-12-07 16:17:38.860939	\N
13821	109	11	2014-12-07 16:17:38.86308	\N
13822	109	19	2014-12-07 16:17:38.865356	\N
13823	109	19	2014-12-07 16:17:38.867375	\N
13824	109	15	2014-12-07 16:17:38.8696	\N
13825	109	15	2014-12-07 16:17:38.871729	\N
13826	109	19	2014-12-07 16:17:38.87393	\N
13827	109	7	2014-12-07 16:17:38.875882	\N
13828	109	2	2014-12-07 16:17:38.877897	\N
13829	109	9	2014-12-07 16:17:38.879983	\N
13830	109	9	2014-12-07 16:17:38.882109	\N
13831	109	9	2014-12-07 16:17:38.884158	\N
13832	109	9	2014-12-07 16:17:38.886418	\N
13833	109	9	2014-12-07 16:17:38.88857	\N
13834	109	3	2014-12-07 16:17:38.890693	\N
13835	109	21	2014-12-07 16:17:38.892742	\N
13836	109	8	2014-12-07 16:17:38.894772	\N
13837	109	13	2014-12-07 16:17:38.896748	\N
13838	109	8	2014-12-07 16:17:38.89881	\N
13839	109	2	2014-12-07 16:17:38.90107	\N
13840	109	18	2014-12-07 16:17:38.90306	\N
13841	109	16	2014-12-07 16:17:38.90532	\N
13842	109	16	2014-12-07 16:17:38.907292	\N
13843	109	15	2014-12-07 16:17:38.909224	\N
13844	109	15	2014-12-07 16:17:38.911241	\N
13845	109	7	2014-12-07 16:17:38.913313	\N
13846	109	7	2014-12-07 16:17:38.915404	\N
13847	109	7	2014-12-07 16:17:38.917691	\N
13848	109	7	2014-12-07 16:17:38.919712	\N
13849	109	7	2014-12-07 16:17:38.921854	\N
13850	109	7	2014-12-07 16:17:38.923914	\N
13851	109	18	2014-12-07 16:17:38.925887	\N
13852	109	2	2014-12-07 16:17:38.927901	\N
13853	109	7	2014-12-07 16:17:38.930034	\N
13854	109	2	2014-12-07 16:17:38.93225	\N
13855	109	7	2014-12-07 16:17:38.934498	\N
13856	109	6	2014-12-07 16:17:38.93659	\N
13857	109	20	2014-12-07 16:17:38.93875	\N
13858	109	20	2014-12-07 16:17:38.940856	\N
13859	109	12	2014-12-07 16:17:38.943026	\N
13860	109	3	2014-12-07 16:17:38.94529	\N
13861	109	5	2014-12-07 16:17:38.947389	\N
13862	109	10	2014-12-07 16:17:38.949574	\N
13863	109	10	2014-12-07 16:17:38.9517	\N
13864	109	5	2014-12-07 16:17:38.95377	\N
13865	109	5	2014-12-07 16:17:38.955793	\N
13866	109	8	2014-12-07 16:17:38.958083	\N
13867	109	22	2014-12-07 16:17:38.960155	\N
13868	109	11	2014-12-07 16:17:38.962184	\N
13869	109	10	2014-12-07 16:17:38.964459	\N
13870	109	22	2014-12-07 16:17:38.966584	\N
13871	109	22	2014-12-07 16:17:38.968641	\N
13872	109	22	2014-12-07 16:17:38.970761	\N
13873	109	20	2014-12-07 16:17:38.972921	\N
13874	109	20	2014-12-07 16:17:38.974837	\N
13875	109	20	2014-12-07 16:17:38.976772	\N
13876	109	20	2014-12-07 16:17:38.978783	\N
13877	109	21	2014-12-07 16:17:38.980944	\N
13878	109	21	2014-12-07 16:17:38.98305	\N
13879	109	21	2014-12-07 16:17:38.985026	\N
13880	109	21	2014-12-07 16:17:38.987027	\N
13881	109	21	2014-12-07 16:17:38.989047	\N
13882	109	21	2014-12-07 16:17:38.991146	\N
13883	109	12	2014-12-07 16:17:38.993299	\N
13884	109	12	2014-12-07 16:17:38.995236	\N
13885	109	12	2014-12-07 16:17:38.997249	\N
13886	109	21	2014-12-07 16:17:38.999102	\N
13887	109	12	2014-12-07 16:17:39.001057	\N
13888	109	12	2014-12-07 16:17:39.003053	\N
13889	109	12	2014-12-07 16:17:39.005438	\N
13890	109	6	2014-12-07 16:17:39.007493	\N
13891	109	3	2014-12-07 16:17:39.009804	\N
13892	109	1	2014-12-07 16:17:39.011903	\N
13893	109	3	2014-12-07 16:17:39.014012	\N
13894	110	2	2014-12-07 16:17:39.140335	\N
13895	110	2	2014-12-07 16:17:39.143947	\N
13896	110	2	2014-12-07 16:17:39.146392	\N
13897	110	2	2014-12-07 16:17:39.148701	\N
13898	110	5	2014-12-07 16:17:39.150873	\N
13899	110	5	2014-12-07 16:17:39.152936	\N
13900	110	8	2014-12-07 16:17:39.155012	\N
13901	110	2	2014-12-07 16:17:39.157052	\N
13902	110	2	2014-12-07 16:17:39.159149	\N
13903	110	2	2014-12-07 16:17:39.161163	\N
13904	110	18	2014-12-07 16:17:39.163229	\N
13905	110	7	2014-12-07 16:17:39.165305	\N
13906	110	5	2014-12-07 16:17:39.167656	\N
13907	110	8	2014-12-07 16:17:39.169766	\N
13908	110	8	2014-12-07 16:17:39.171754	\N
13909	110	8	2014-12-07 16:17:39.173756	\N
13910	110	8	2014-12-07 16:17:39.175713	\N
13911	110	8	2014-12-07 16:17:39.177675	\N
13912	110	8	2014-12-07 16:17:39.179588	\N
13913	110	18	2014-12-07 16:17:39.18153	\N
13914	110	18	2014-12-07 16:17:39.183671	\N
13915	110	18	2014-12-07 16:17:39.185708	\N
13916	110	18	2014-12-07 16:17:39.187737	\N
13917	110	18	2014-12-07 16:17:39.189818	\N
13918	110	18	2014-12-07 16:17:39.191974	\N
13919	110	18	2014-12-07 16:17:39.19413	\N
13920	110	4	2014-12-07 16:17:39.196205	\N
13921	110	4	2014-12-07 16:17:39.198262	\N
13922	110	4	2014-12-07 16:17:39.200379	\N
13923	110	4	2014-12-07 16:17:39.202478	\N
13924	110	4	2014-12-07 16:17:39.204571	\N
13925	110	4	2014-12-07 16:17:39.20671	\N
13926	110	4	2014-12-07 16:17:39.208913	\N
13927	110	4	2014-12-07 16:17:39.210955	\N
13928	110	11	2014-12-07 16:17:39.213066	\N
13929	110	11	2014-12-07 16:17:39.215073	\N
13930	110	11	2014-12-07 16:17:39.217133	\N
13931	110	19	2014-12-07 16:17:39.219067	\N
13932	110	19	2014-12-07 16:17:39.220919	\N
13933	110	15	2014-12-07 16:17:39.222971	\N
13934	110	15	2014-12-07 16:17:39.22493	\N
13935	110	19	2014-12-07 16:17:39.226838	\N
13936	110	7	2014-12-07 16:17:39.229054	\N
13937	110	2	2014-12-07 16:17:39.231042	\N
13938	110	9	2014-12-07 16:17:39.233046	\N
13939	110	9	2014-12-07 16:17:39.234952	\N
13940	110	9	2014-12-07 16:17:39.236822	\N
13941	110	9	2014-12-07 16:17:39.238995	\N
13942	110	9	2014-12-07 16:17:39.240958	\N
13943	110	3	2014-12-07 16:17:39.242881	\N
13944	110	21	2014-12-07 16:17:39.244964	\N
13945	110	8	2014-12-07 16:17:39.246969	\N
13946	110	13	2014-12-07 16:17:39.248819	\N
13947	110	8	2014-12-07 16:17:39.250833	\N
13948	110	2	2014-12-07 16:17:39.252754	\N
13949	110	18	2014-12-07 16:17:39.254742	\N
13950	110	16	2014-12-07 16:17:39.256804	\N
13951	110	16	2014-12-07 16:17:39.258854	\N
13952	110	15	2014-12-07 16:17:39.26083	\N
13953	110	15	2014-12-07 16:17:39.262764	\N
13954	110	7	2014-12-07 16:17:39.264764	\N
13955	110	7	2014-12-07 16:17:39.26669	\N
13956	110	7	2014-12-07 16:17:39.268586	\N
13957	110	7	2014-12-07 16:17:39.270507	\N
13958	110	7	2014-12-07 16:17:39.272534	\N
13959	110	7	2014-12-07 16:17:39.274544	\N
13960	110	18	2014-12-07 16:17:39.276557	\N
13961	110	2	2014-12-07 16:17:39.278501	\N
13962	110	7	2014-12-07 16:17:39.280404	\N
13963	110	2	2014-12-07 16:17:39.282316	\N
13964	110	7	2014-12-07 16:17:39.28422	\N
13965	110	6	2014-12-07 16:17:39.286228	\N
13966	110	20	2014-12-07 16:17:39.28811	\N
13967	110	20	2014-12-07 16:17:39.290153	\N
13968	110	12	2014-12-07 16:17:39.292192	\N
13969	110	3	2014-12-07 16:17:39.29417	\N
13970	110	5	2014-12-07 16:17:39.296064	\N
13971	110	10	2014-12-07 16:17:39.297916	\N
13972	110	10	2014-12-07 16:17:39.299888	\N
13973	110	5	2014-12-07 16:17:39.302253	\N
13974	110	5	2014-12-07 16:17:39.304341	\N
13975	110	8	2014-12-07 16:17:39.306419	\N
13976	110	22	2014-12-07 16:17:39.30849	\N
13977	110	11	2014-12-07 16:17:39.310505	\N
13978	110	10	2014-12-07 16:17:39.312461	\N
13979	110	22	2014-12-07 16:17:39.314494	\N
13980	110	22	2014-12-07 16:17:39.316596	\N
13981	110	22	2014-12-07 16:17:39.318755	\N
13982	110	20	2014-12-07 16:17:39.32077	\N
13983	110	20	2014-12-07 16:17:39.32298	\N
13984	110	20	2014-12-07 16:17:39.325177	\N
13985	110	20	2014-12-07 16:17:39.327109	\N
13986	110	21	2014-12-07 16:17:39.329027	\N
13987	110	21	2014-12-07 16:17:39.330961	\N
13988	110	21	2014-12-07 16:17:39.332925	\N
13989	110	21	2014-12-07 16:17:39.335284	\N
13990	110	21	2014-12-07 16:17:39.337454	\N
13991	110	21	2014-12-07 16:17:39.339658	\N
13992	110	12	2014-12-07 16:17:39.341756	\N
13993	110	12	2014-12-07 16:17:39.343758	\N
13994	110	12	2014-12-07 16:17:39.345784	\N
13995	110	21	2014-12-07 16:17:39.347763	\N
13996	110	12	2014-12-07 16:17:39.349811	\N
13997	110	12	2014-12-07 16:17:39.35177	\N
13998	110	12	2014-12-07 16:17:39.354001	\N
13999	110	6	2014-12-07 16:17:39.356156	\N
14000	110	3	2014-12-07 16:17:39.358264	\N
14001	110	1	2014-12-07 16:17:39.360254	\N
14002	110	3	2014-12-07 16:17:39.362267	\N
14003	110	3	2014-12-07 16:17:39.364282	\N
14004	111	2	2014-12-07 16:17:39.501279	\N
14005	111	2	2014-12-07 16:17:39.517296	\N
14006	111	2	2014-12-07 16:17:39.555103	\N
14007	111	2	2014-12-07 16:17:39.594142	\N
14008	111	5	2014-12-07 16:17:39.648717	\N
14009	111	5	2014-12-07 16:17:39.688891	\N
14010	111	8	2014-12-07 16:17:39.692201	\N
14011	111	2	2014-12-07 16:17:39.694912	\N
14012	111	2	2014-12-07 16:17:39.696955	\N
14013	111	2	2014-12-07 16:17:39.698994	\N
14014	111	18	2014-12-07 16:17:39.701272	\N
14015	111	7	2014-12-07 16:17:39.703421	\N
14016	111	5	2014-12-07 16:17:39.705459	\N
14017	111	8	2014-12-07 16:17:39.707587	\N
14018	111	8	2014-12-07 16:17:39.709756	\N
14019	111	8	2014-12-07 16:17:39.711926	\N
14020	111	8	2014-12-07 16:17:39.714012	\N
14021	111	8	2014-12-07 16:17:39.716041	\N
14022	111	8	2014-12-07 16:17:39.718086	\N
14023	111	18	2014-12-07 16:17:39.720174	\N
14024	111	18	2014-12-07 16:17:39.722219	\N
14025	111	18	2014-12-07 16:17:39.725062	\N
14026	111	18	2014-12-07 16:17:39.727223	\N
14027	111	18	2014-12-07 16:17:39.729262	\N
14028	111	18	2014-12-07 16:17:39.731221	\N
14029	111	18	2014-12-07 16:17:39.733296	\N
14030	111	4	2014-12-07 16:17:39.735241	\N
14031	111	4	2014-12-07 16:17:39.737216	\N
14032	111	4	2014-12-07 16:17:39.739115	\N
14033	111	4	2014-12-07 16:17:39.741196	\N
14034	111	4	2014-12-07 16:17:39.74314	\N
14035	111	4	2014-12-07 16:17:39.745343	\N
14036	111	4	2014-12-07 16:17:39.747545	\N
14037	111	4	2014-12-07 16:17:39.74963	\N
14038	111	11	2014-12-07 16:17:39.751756	\N
14039	111	11	2014-12-07 16:17:39.753824	\N
14040	111	11	2014-12-07 16:17:39.755823	\N
14041	111	19	2014-12-07 16:17:39.757927	\N
14042	111	19	2014-12-07 16:17:39.75995	\N
14043	111	15	2014-12-07 16:17:39.762852	\N
14044	111	15	2014-12-07 16:17:39.765216	\N
14045	111	19	2014-12-07 16:17:39.767142	\N
14046	111	7	2014-12-07 16:17:39.769156	\N
14047	111	2	2014-12-07 16:17:39.771157	\N
14048	111	9	2014-12-07 16:17:39.773237	\N
14049	111	9	2014-12-07 16:17:39.775258	\N
14050	111	9	2014-12-07 16:17:39.777492	\N
14051	111	9	2014-12-07 16:17:39.779785	\N
14052	111	9	2014-12-07 16:17:39.781929	\N
14053	111	3	2014-12-07 16:17:39.783894	\N
14054	111	21	2014-12-07 16:17:39.785871	\N
14055	111	8	2014-12-07 16:17:39.787842	\N
14056	111	13	2014-12-07 16:17:39.789837	\N
14057	111	8	2014-12-07 16:17:39.791974	\N
14058	111	2	2014-12-07 16:17:39.793977	\N
14059	111	18	2014-12-07 16:17:39.795983	\N
14060	111	16	2014-12-07 16:17:39.797993	\N
14061	111	16	2014-12-07 16:17:39.800022	\N
14062	111	15	2014-12-07 16:17:39.80205	\N
14063	111	15	2014-12-07 16:17:39.804184	\N
14064	111	7	2014-12-07 16:17:39.806296	\N
14065	111	7	2014-12-07 16:17:39.808365	\N
14066	111	7	2014-12-07 16:17:39.810381	\N
14067	111	7	2014-12-07 16:17:39.812384	\N
14068	111	7	2014-12-07 16:17:39.814431	\N
14069	111	7	2014-12-07 16:17:39.816459	\N
14070	111	18	2014-12-07 16:17:39.818739	\N
14071	111	2	2014-12-07 16:17:39.820806	\N
14072	111	7	2014-12-07 16:17:39.822842	\N
14073	111	2	2014-12-07 16:17:39.824998	\N
14074	111	7	2014-12-07 16:17:39.827049	\N
14075	111	6	2014-12-07 16:17:39.829049	\N
14076	111	20	2014-12-07 16:17:39.831082	\N
14077	111	20	2014-12-07 16:17:39.833029	\N
14078	111	12	2014-12-07 16:17:39.835243	\N
14079	111	3	2014-12-07 16:17:39.83733	\N
14080	111	5	2014-12-07 16:17:39.839238	\N
14081	111	10	2014-12-07 16:17:39.841402	\N
14082	111	10	2014-12-07 16:17:39.843528	\N
14083	111	5	2014-12-07 16:17:39.84555	\N
14084	111	5	2014-12-07 16:17:39.847678	\N
14085	111	8	2014-12-07 16:17:39.849676	\N
14086	111	22	2014-12-07 16:17:39.851924	\N
14087	111	11	2014-12-07 16:17:39.854022	\N
14088	111	10	2014-12-07 16:17:39.856053	\N
14089	111	22	2014-12-07 16:17:39.858117	\N
14090	111	22	2014-12-07 16:17:39.86017	\N
14091	111	22	2014-12-07 16:17:39.862167	\N
14092	111	20	2014-12-07 16:17:39.864131	\N
14093	111	20	2014-12-07 16:17:39.86614	\N
14094	111	20	2014-12-07 16:17:39.868225	\N
14095	111	20	2014-12-07 16:17:39.870219	\N
14096	111	21	2014-12-07 16:17:39.872153	\N
14097	111	21	2014-12-07 16:17:39.874156	\N
14098	111	21	2014-12-07 16:17:39.876133	\N
14099	111	21	2014-12-07 16:17:39.878086	\N
14100	111	21	2014-12-07 16:17:39.880165	\N
14101	111	21	2014-12-07 16:17:39.882167	\N
14102	111	12	2014-12-07 16:17:39.884204	\N
14103	111	12	2014-12-07 16:17:39.886246	\N
14104	111	12	2014-12-07 16:17:39.888275	\N
14105	111	21	2014-12-07 16:17:39.8903	\N
14106	111	12	2014-12-07 16:17:39.892288	\N
14107	111	12	2014-12-07 16:17:39.894249	\N
14108	111	12	2014-12-07 16:17:39.89619	\N
14109	111	6	2014-12-07 16:17:39.898154	\N
14110	111	3	2014-12-07 16:17:39.900272	\N
14111	111	1	2014-12-07 16:17:39.90238	\N
14112	111	3	2014-12-07 16:17:39.904231	\N
14113	111	3	2014-12-07 16:17:39.906173	\N
14114	111	6	2014-12-07 16:17:39.908334	\N
14115	112	2	2014-12-07 16:17:40.141338	\N
14116	112	2	2014-12-07 16:17:40.1449	\N
14117	112	2	2014-12-07 16:17:40.147438	\N
14118	112	2	2014-12-07 16:17:40.149551	\N
14119	112	5	2014-12-07 16:17:40.15167	\N
14120	112	5	2014-12-07 16:17:40.154029	\N
14121	112	8	2014-12-07 16:17:40.156178	\N
14122	112	2	2014-12-07 16:17:40.158251	\N
14123	112	2	2014-12-07 16:17:40.16039	\N
14124	112	2	2014-12-07 16:17:40.162406	\N
14125	112	18	2014-12-07 16:17:40.164663	\N
14126	112	7	2014-12-07 16:17:40.166902	\N
14127	112	5	2014-12-07 16:17:40.16926	\N
14128	112	8	2014-12-07 16:17:40.171295	\N
14129	112	8	2014-12-07 16:17:40.173354	\N
14130	112	8	2014-12-07 16:17:40.175332	\N
14131	112	8	2014-12-07 16:17:40.177525	\N
14132	112	8	2014-12-07 16:17:40.17967	\N
14133	112	8	2014-12-07 16:17:40.181723	\N
14134	112	18	2014-12-07 16:17:40.183807	\N
14135	112	18	2014-12-07 16:17:40.18579	\N
14136	112	18	2014-12-07 16:17:40.187987	\N
14137	112	18	2014-12-07 16:17:40.189975	\N
14138	112	18	2014-12-07 16:17:40.191959	\N
14139	112	18	2014-12-07 16:17:40.193984	\N
14140	112	18	2014-12-07 16:17:40.196048	\N
14141	112	4	2014-12-07 16:17:40.198068	\N
14142	112	4	2014-12-07 16:17:40.200095	\N
14143	112	4	2014-12-07 16:17:40.202322	\N
14144	112	4	2014-12-07 16:17:40.204396	\N
14145	112	4	2014-12-07 16:17:40.206473	\N
14146	112	4	2014-12-07 16:17:40.208498	\N
14147	112	4	2014-12-07 16:17:40.210799	\N
14148	112	4	2014-12-07 16:17:40.213143	\N
14149	112	11	2014-12-07 16:17:40.215173	\N
14150	112	11	2014-12-07 16:17:40.217268	\N
14151	112	11	2014-12-07 16:17:40.219361	\N
14152	112	19	2014-12-07 16:17:40.221462	\N
14153	112	19	2014-12-07 16:17:40.223361	\N
14154	112	15	2014-12-07 16:17:40.225331	\N
14155	112	15	2014-12-07 16:17:40.227439	\N
14156	112	19	2014-12-07 16:17:40.229549	\N
14157	112	7	2014-12-07 16:17:40.231531	\N
14158	112	2	2014-12-07 16:17:40.233536	\N
14159	112	9	2014-12-07 16:17:40.235456	\N
14160	112	9	2014-12-07 16:17:40.237547	\N
14161	112	9	2014-12-07 16:17:40.239521	\N
14162	112	9	2014-12-07 16:17:40.241768	\N
14163	112	9	2014-12-07 16:17:40.244292	\N
14164	112	3	2014-12-07 16:17:40.246423	\N
14165	112	21	2014-12-07 16:17:40.248494	\N
14166	112	8	2014-12-07 16:17:40.250539	\N
14167	112	13	2014-12-07 16:17:40.252563	\N
14168	112	8	2014-12-07 16:17:40.254602	\N
14169	112	2	2014-12-07 16:17:40.25655	\N
14170	112	18	2014-12-07 16:17:40.258565	\N
14171	112	16	2014-12-07 16:17:40.26081	\N
14172	112	16	2014-12-07 16:17:40.262946	\N
14173	112	15	2014-12-07 16:17:40.264986	\N
14174	112	15	2014-12-07 16:17:40.266975	\N
14175	112	7	2014-12-07 16:17:40.268932	\N
14176	112	7	2014-12-07 16:17:40.270983	\N
14177	112	7	2014-12-07 16:17:40.27299	\N
14178	112	7	2014-12-07 16:17:40.274922	\N
14179	112	7	2014-12-07 16:17:40.276937	\N
14180	112	7	2014-12-07 16:17:40.279243	\N
14181	112	18	2014-12-07 16:17:40.282188	\N
14182	112	2	2014-12-07 16:17:40.285114	\N
14183	112	7	2014-12-07 16:17:40.28709	\N
14184	112	2	2014-12-07 16:17:40.289162	\N
14185	112	7	2014-12-07 16:17:40.291178	\N
14186	112	6	2014-12-07 16:17:40.293375	\N
14187	112	20	2014-12-07 16:17:40.295367	\N
14188	112	20	2014-12-07 16:17:40.297393	\N
14189	112	12	2014-12-07 16:17:40.299343	\N
14190	112	3	2014-12-07 16:17:40.301432	\N
14191	112	5	2014-12-07 16:17:40.303447	\N
14192	112	10	2014-12-07 16:17:40.30549	\N
14193	112	10	2014-12-07 16:17:40.307443	\N
14194	112	5	2014-12-07 16:17:40.309438	\N
14195	112	5	2014-12-07 16:17:40.31141	\N
14196	112	8	2014-12-07 16:17:40.313397	\N
14197	112	22	2014-12-07 16:17:40.315403	\N
14198	112	11	2014-12-07 16:17:40.317383	\N
14199	112	10	2014-12-07 16:17:40.319446	\N
14200	112	22	2014-12-07 16:17:40.32172	\N
14201	112	22	2014-12-07 16:17:40.323715	\N
14202	112	22	2014-12-07 16:17:40.325711	\N
14203	112	20	2014-12-07 16:17:40.327743	\N
14204	112	20	2014-12-07 16:17:40.329684	\N
14205	112	20	2014-12-07 16:17:40.331826	\N
14206	112	20	2014-12-07 16:17:40.333845	\N
14207	112	21	2014-12-07 16:17:40.335748	\N
14208	112	21	2014-12-07 16:17:40.337751	\N
14209	112	21	2014-12-07 16:17:40.339626	\N
14210	112	21	2014-12-07 16:17:40.341638	\N
14211	112	21	2014-12-07 16:17:40.343717	\N
14212	112	21	2014-12-07 16:17:40.345746	\N
14213	112	12	2014-12-07 16:17:40.347623	\N
14214	112	12	2014-12-07 16:17:40.350038	\N
14215	112	12	2014-12-07 16:17:40.352183	\N
14216	112	21	2014-12-07 16:17:40.354159	\N
14217	112	12	2014-12-07 16:17:40.356122	\N
14218	112	12	2014-12-07 16:17:40.358108	\N
14219	112	12	2014-12-07 16:17:40.360237	\N
14220	112	6	2014-12-07 16:17:40.362263	\N
14221	112	3	2014-12-07 16:17:40.364265	\N
14222	112	1	2014-12-07 16:17:40.366236	\N
14223	112	3	2014-12-07 16:17:40.368203	\N
14224	112	3	2014-12-07 16:17:40.37027	\N
14225	112	6	2014-12-07 16:17:40.372361	\N
14226	112	3	2014-12-07 16:17:40.374415	\N
14227	113	2	2014-12-07 16:17:40.755472	\N
14228	113	2	2014-12-07 16:17:40.759452	\N
14229	113	2	2014-12-07 16:17:40.762111	\N
14230	113	2	2014-12-07 16:17:40.764423	\N
14231	113	5	2014-12-07 16:17:40.766786	\N
14232	113	5	2014-12-07 16:17:40.769041	\N
14233	113	8	2014-12-07 16:17:40.771331	\N
14234	113	2	2014-12-07 16:17:40.773633	\N
14235	113	2	2014-12-07 16:17:40.775805	\N
14236	113	2	2014-12-07 16:17:40.777948	\N
14237	113	18	2014-12-07 16:17:40.78007	\N
14238	113	7	2014-12-07 16:17:40.78211	\N
14239	113	5	2014-12-07 16:17:40.784157	\N
14240	113	8	2014-12-07 16:17:40.786188	\N
14241	113	8	2014-12-07 16:17:40.788262	\N
14242	113	8	2014-12-07 16:17:40.790305	\N
14243	113	8	2014-12-07 16:17:40.792424	\N
14244	113	8	2014-12-07 16:17:40.794524	\N
14245	113	8	2014-12-07 16:17:40.796547	\N
14246	113	18	2014-12-07 16:17:40.798597	\N
14247	113	18	2014-12-07 16:17:40.800679	\N
14248	113	18	2014-12-07 16:17:40.802739	\N
14249	113	18	2014-12-07 16:17:40.804774	\N
14250	113	18	2014-12-07 16:17:40.80683	\N
14251	113	18	2014-12-07 16:17:40.808904	\N
14252	113	18	2014-12-07 16:17:40.811112	\N
14253	113	4	2014-12-07 16:17:40.813236	\N
14254	113	4	2014-12-07 16:17:40.81534	\N
14255	113	4	2014-12-07 16:17:40.817326	\N
14256	113	4	2014-12-07 16:17:40.819846	\N
14257	113	4	2014-12-07 16:17:40.821937	\N
14258	113	4	2014-12-07 16:17:40.823953	\N
14259	113	4	2014-12-07 16:17:40.825962	\N
14260	113	4	2014-12-07 16:17:40.828098	\N
14261	113	11	2014-12-07 16:17:40.831025	\N
14262	113	11	2014-12-07 16:17:40.833086	\N
14263	113	11	2014-12-07 16:17:40.836064	\N
14264	113	19	2014-12-07 16:17:40.839	\N
14265	113	19	2014-12-07 16:17:40.841139	\N
14266	113	15	2014-12-07 16:17:40.8433	\N
14267	113	15	2014-12-07 16:17:40.845676	\N
14268	113	19	2014-12-07 16:17:40.84786	\N
14269	113	7	2014-12-07 16:17:40.850064	\N
14270	113	2	2014-12-07 16:17:40.852155	\N
14271	113	9	2014-12-07 16:17:40.854217	\N
14272	113	9	2014-12-07 16:17:40.856608	\N
14273	113	9	2014-12-07 16:17:40.858959	\N
14274	113	9	2014-12-07 16:17:40.861181	\N
14275	113	9	2014-12-07 16:17:40.863379	\N
14276	113	3	2014-12-07 16:17:40.865689	\N
14277	113	21	2014-12-07 16:17:40.867823	\N
14278	113	8	2014-12-07 16:17:40.869878	\N
14279	113	13	2014-12-07 16:17:40.871935	\N
14280	113	8	2014-12-07 16:17:40.873932	\N
14281	113	2	2014-12-07 16:17:40.875842	\N
14282	113	18	2014-12-07 16:17:40.877896	\N
14283	113	16	2014-12-07 16:17:40.879878	\N
14284	113	16	2014-12-07 16:17:40.8819	\N
14285	113	15	2014-12-07 16:17:40.883959	\N
14286	113	15	2014-12-07 16:17:40.885996	\N
14287	113	7	2014-12-07 16:17:40.888175	\N
14288	113	7	2014-12-07 16:17:40.890324	\N
14289	113	7	2014-12-07 16:17:40.892436	\N
14290	113	7	2014-12-07 16:17:40.894521	\N
14291	113	7	2014-12-07 16:17:40.896693	\N
14292	113	7	2014-12-07 16:17:40.898781	\N
14293	113	18	2014-12-07 16:17:40.900903	\N
14294	113	2	2014-12-07 16:17:40.902959	\N
14295	113	7	2014-12-07 16:17:40.905038	\N
14296	113	2	2014-12-07 16:17:40.907076	\N
14297	113	7	2014-12-07 16:17:40.909112	\N
14298	113	6	2014-12-07 16:17:40.911099	\N
14299	113	20	2014-12-07 16:17:40.91351	\N
14300	113	20	2014-12-07 16:17:40.915671	\N
14301	113	12	2014-12-07 16:17:40.917752	\N
14302	113	3	2014-12-07 16:17:40.919968	\N
14303	113	5	2014-12-07 16:17:40.922079	\N
14304	113	10	2014-12-07 16:17:40.924203	\N
14305	113	10	2014-12-07 16:17:40.926259	\N
14306	113	5	2014-12-07 16:17:40.928381	\N
14307	113	5	2014-12-07 16:17:40.930588	\N
14308	113	8	2014-12-07 16:17:40.932683	\N
14309	113	22	2014-12-07 16:17:40.934731	\N
14310	113	11	2014-12-07 16:17:40.936848	\N
14311	113	10	2014-12-07 16:17:40.938908	\N
14312	113	22	2014-12-07 16:17:40.940923	\N
14313	113	22	2014-12-07 16:17:40.943177	\N
14314	113	22	2014-12-07 16:17:40.945856	\N
14315	113	20	2014-12-07 16:17:40.992626	\N
14316	113	20	2014-12-07 16:17:40.998056	\N
14317	113	20	2014-12-07 16:17:41.000575	\N
14318	113	20	2014-12-07 16:17:41.002762	\N
14319	113	21	2014-12-07 16:17:41.004907	\N
14320	113	21	2014-12-07 16:17:41.00707	\N
14321	113	21	2014-12-07 16:17:41.009651	\N
14322	113	21	2014-12-07 16:17:41.012051	\N
14323	113	21	2014-12-07 16:17:41.014829	\N
14324	113	21	2014-12-07 16:17:41.017045	\N
14325	113	12	2014-12-07 16:17:41.019175	\N
14326	113	12	2014-12-07 16:17:41.021383	\N
14327	113	12	2014-12-07 16:17:41.023462	\N
14328	113	21	2014-12-07 16:17:41.025564	\N
14329	113	12	2014-12-07 16:17:41.027701	\N
14330	113	12	2014-12-07 16:17:41.029923	\N
14331	113	12	2014-12-07 16:17:41.032126	\N
14332	113	6	2014-12-07 16:17:41.034202	\N
14333	113	3	2014-12-07 16:17:41.036323	\N
14334	113	1	2014-12-07 16:17:41.038406	\N
14335	113	3	2014-12-07 16:17:41.040735	\N
14336	113	3	2014-12-07 16:17:41.042839	\N
14337	113	6	2014-12-07 16:17:41.045284	\N
14338	113	3	2014-12-07 16:17:41.047404	\N
14339	113	7	2014-12-07 16:17:41.049509	\N
14340	114	2	2014-12-07 16:17:41.292038	\N
14341	114	2	2014-12-07 16:17:41.295809	\N
14342	114	2	2014-12-07 16:17:41.298221	\N
14343	114	2	2014-12-07 16:17:41.300513	\N
14344	114	5	2014-12-07 16:17:41.30284	\N
14345	114	5	2014-12-07 16:17:41.305211	\N
14346	114	8	2014-12-07 16:17:41.30742	\N
14347	114	2	2014-12-07 16:17:41.309799	\N
14348	114	2	2014-12-07 16:17:41.311901	\N
14349	114	2	2014-12-07 16:17:41.314117	\N
14350	114	18	2014-12-07 16:17:41.316368	\N
14351	114	7	2014-12-07 16:17:41.318475	\N
14352	114	5	2014-12-07 16:17:41.320704	\N
14353	114	8	2014-12-07 16:17:41.322779	\N
14354	114	8	2014-12-07 16:17:41.324833	\N
14355	114	8	2014-12-07 16:17:41.326956	\N
14356	114	8	2014-12-07 16:17:41.329021	\N
14357	114	8	2014-12-07 16:17:41.331224	\N
14358	114	8	2014-12-07 16:17:41.333298	\N
14359	114	18	2014-12-07 16:17:41.335573	\N
14360	114	18	2014-12-07 16:17:41.337619	\N
14361	114	18	2014-12-07 16:17:41.339834	\N
14362	114	18	2014-12-07 16:17:41.341959	\N
14363	114	18	2014-12-07 16:17:41.343948	\N
14364	114	18	2014-12-07 16:17:41.346104	\N
14365	114	18	2014-12-07 16:17:41.34834	\N
14366	114	4	2014-12-07 16:17:41.35063	\N
14367	114	4	2014-12-07 16:17:41.352858	\N
14368	114	4	2014-12-07 16:17:41.354873	\N
14369	114	4	2014-12-07 16:17:41.356918	\N
14370	114	4	2014-12-07 16:17:41.358859	\N
14371	114	4	2014-12-07 16:17:41.360961	\N
14372	114	4	2014-12-07 16:17:41.363032	\N
14373	114	4	2014-12-07 16:17:41.365157	\N
14374	114	11	2014-12-07 16:17:41.367125	\N
14375	114	11	2014-12-07 16:17:41.369364	\N
14376	114	11	2014-12-07 16:17:41.371411	\N
14377	114	19	2014-12-07 16:17:41.373498	\N
14378	114	19	2014-12-07 16:17:41.375483	\N
14379	114	15	2014-12-07 16:17:41.377505	\N
14380	114	15	2014-12-07 16:17:41.3796	\N
14381	114	19	2014-12-07 16:17:41.38173	\N
14382	114	7	2014-12-07 16:17:41.383713	\N
14383	114	2	2014-12-07 16:17:41.385827	\N
14384	114	9	2014-12-07 16:17:41.387793	\N
14385	114	9	2014-12-07 16:17:41.389833	\N
14386	114	9	2014-12-07 16:17:41.391755	\N
14387	114	9	2014-12-07 16:17:41.39372	\N
14388	114	9	2014-12-07 16:17:41.395663	\N
14389	114	3	2014-12-07 16:17:41.397705	\N
14390	114	21	2014-12-07 16:17:41.399765	\N
14391	114	8	2014-12-07 16:17:41.401856	\N
14392	114	13	2014-12-07 16:17:41.403934	\N
14393	114	8	2014-12-07 16:17:41.405962	\N
14394	114	2	2014-12-07 16:17:41.407957	\N
14395	114	18	2014-12-07 16:17:41.409954	\N
14396	114	16	2014-12-07 16:17:41.41196	\N
14397	114	16	2014-12-07 16:17:41.414124	\N
14398	114	15	2014-12-07 16:17:41.41628	\N
14399	114	15	2014-12-07 16:17:41.418346	\N
14400	114	7	2014-12-07 16:17:41.420504	\N
14401	114	7	2014-12-07 16:17:41.422567	\N
14402	114	7	2014-12-07 16:17:41.424627	\N
14403	114	7	2014-12-07 16:17:41.426662	\N
14404	114	7	2014-12-07 16:17:41.428697	\N
14405	114	7	2014-12-07 16:17:41.430767	\N
14406	114	18	2014-12-07 16:17:41.43297	\N
14407	114	2	2014-12-07 16:17:41.435439	\N
14408	114	7	2014-12-07 16:17:41.43765	\N
14409	114	2	2014-12-07 16:17:41.439775	\N
14410	114	7	2014-12-07 16:17:41.441838	\N
14411	114	6	2014-12-07 16:17:41.444417	\N
14412	114	20	2014-12-07 16:17:41.447601	\N
14413	114	20	2014-12-07 16:17:41.450462	\N
14414	114	12	2014-12-07 16:17:41.452658	\N
14415	114	3	2014-12-07 16:17:41.454848	\N
14416	114	5	2014-12-07 16:17:41.458057	\N
14417	114	10	2014-12-07 16:17:41.461841	\N
14418	114	10	2014-12-07 16:17:41.464536	\N
14419	114	5	2014-12-07 16:17:41.466884	\N
14420	114	5	2014-12-07 16:17:41.470494	\N
14421	114	8	2014-12-07 16:17:41.474333	\N
14422	114	22	2014-12-07 16:17:41.477147	\N
14423	114	11	2014-12-07 16:17:41.479558	\N
14424	114	10	2014-12-07 16:17:41.482587	\N
14425	114	22	2014-12-07 16:17:41.484885	\N
14426	114	22	2014-12-07 16:17:41.487246	\N
14427	114	22	2014-12-07 16:17:41.489545	\N
14428	114	20	2014-12-07 16:17:41.491774	\N
14429	114	20	2014-12-07 16:17:41.494701	\N
14430	114	20	2014-12-07 16:17:41.497428	\N
14431	114	20	2014-12-07 16:17:41.499682	\N
14432	114	21	2014-12-07 16:17:41.502044	\N
14433	114	21	2014-12-07 16:17:41.504379	\N
14434	114	21	2014-12-07 16:17:41.50665	\N
14435	114	21	2014-12-07 16:17:41.508948	\N
14436	114	21	2014-12-07 16:17:41.511224	\N
14437	114	21	2014-12-07 16:17:41.513463	\N
14438	114	12	2014-12-07 16:17:41.515656	\N
14439	114	12	2014-12-07 16:17:41.517808	\N
14440	114	12	2014-12-07 16:17:41.519919	\N
14441	114	21	2014-12-07 16:17:41.522057	\N
14442	114	12	2014-12-07 16:17:41.524079	\N
14443	114	12	2014-12-07 16:17:41.52621	\N
14444	114	12	2014-12-07 16:17:41.528439	\N
14445	114	6	2014-12-07 16:17:41.530597	\N
14446	114	3	2014-12-07 16:17:41.532765	\N
14447	114	1	2014-12-07 16:17:41.534782	\N
14448	114	3	2014-12-07 16:17:41.536822	\N
14449	114	3	2014-12-07 16:17:41.538828	\N
14450	114	6	2014-12-07 16:17:41.540856	\N
14451	114	3	2014-12-07 16:17:41.542826	\N
14452	114	7	2014-12-07 16:17:41.545107	\N
14453	114	17	2014-12-07 16:17:41.547263	\N
14454	115	2	2014-12-07 16:17:41.679596	\N
14455	115	2	2014-12-07 16:17:41.683585	\N
14456	115	2	2014-12-07 16:17:41.686101	\N
14457	115	2	2014-12-07 16:17:41.688393	\N
14458	115	5	2014-12-07 16:17:41.690689	\N
14459	115	5	2014-12-07 16:17:41.693126	\N
14460	115	8	2014-12-07 16:17:41.695245	\N
14461	115	2	2014-12-07 16:17:41.697391	\N
14462	115	2	2014-12-07 16:17:41.699604	\N
14463	115	2	2014-12-07 16:17:41.701742	\N
14464	115	18	2014-12-07 16:17:41.70384	\N
14465	115	7	2014-12-07 16:17:41.705961	\N
14466	115	5	2014-12-07 16:17:41.708076	\N
14467	115	8	2014-12-07 16:17:41.710197	\N
14468	115	8	2014-12-07 16:17:41.712266	\N
14469	115	8	2014-12-07 16:17:41.7144	\N
14470	115	8	2014-12-07 16:17:41.71664	\N
14471	115	8	2014-12-07 16:17:41.71879	\N
14472	115	8	2014-12-07 16:17:41.721117	\N
14473	115	18	2014-12-07 16:17:41.724858	\N
14474	115	18	2014-12-07 16:17:41.727292	\N
14475	115	18	2014-12-07 16:17:41.729528	\N
14476	115	18	2014-12-07 16:17:41.731844	\N
14477	115	18	2014-12-07 16:17:41.73403	\N
14478	115	18	2014-12-07 16:17:41.736104	\N
14479	115	18	2014-12-07 16:17:41.738234	\N
14480	115	4	2014-12-07 16:17:41.740418	\N
14481	115	4	2014-12-07 16:17:41.742655	\N
14482	115	4	2014-12-07 16:17:41.7447	\N
14483	115	4	2014-12-07 16:17:41.746867	\N
14484	115	4	2014-12-07 16:17:41.749026	\N
14485	115	4	2014-12-07 16:17:41.751069	\N
14486	115	4	2014-12-07 16:17:41.75314	\N
14487	115	4	2014-12-07 16:17:41.755069	\N
14488	115	11	2014-12-07 16:17:41.757106	\N
14489	115	11	2014-12-07 16:17:41.759125	\N
14490	115	11	2014-12-07 16:17:41.761533	\N
14491	115	19	2014-12-07 16:17:41.763679	\N
14492	115	19	2014-12-07 16:17:41.765904	\N
14493	115	15	2014-12-07 16:17:41.768008	\N
14494	115	15	2014-12-07 16:17:41.770319	\N
14495	115	19	2014-12-07 16:17:41.772582	\N
14496	115	7	2014-12-07 16:17:41.774702	\N
14497	115	2	2014-12-07 16:17:41.776756	\N
14498	115	9	2014-12-07 16:17:41.77885	\N
14499	115	9	2014-12-07 16:17:41.780948	\N
14500	115	9	2014-12-07 16:17:41.783011	\N
14501	115	9	2014-12-07 16:17:41.784983	\N
14502	115	9	2014-12-07 16:17:41.786959	\N
14503	115	3	2014-12-07 16:17:41.788977	\N
14504	115	21	2014-12-07 16:17:41.790987	\N
14505	115	8	2014-12-07 16:17:41.79309	\N
14506	115	13	2014-12-07 16:17:41.795037	\N
14507	115	8	2014-12-07 16:17:41.797074	\N
14508	115	2	2014-12-07 16:17:41.799124	\N
14509	115	18	2014-12-07 16:17:41.801454	\N
14510	115	16	2014-12-07 16:17:41.804093	\N
14511	115	16	2014-12-07 16:17:41.806423	\N
14512	115	15	2014-12-07 16:17:41.808571	\N
14513	115	15	2014-12-07 16:17:41.810627	\N
14514	115	7	2014-12-07 16:17:41.81271	\N
14515	115	7	2014-12-07 16:17:41.814803	\N
14516	115	7	2014-12-07 16:17:41.816888	\N
14517	115	7	2014-12-07 16:17:41.818889	\N
14518	115	7	2014-12-07 16:17:41.821065	\N
14519	115	7	2014-12-07 16:17:41.823156	\N
14520	115	18	2014-12-07 16:17:41.825399	\N
14521	115	2	2014-12-07 16:17:41.82769	\N
14522	115	7	2014-12-07 16:17:41.829924	\N
14523	115	2	2014-12-07 16:17:41.832084	\N
14524	115	7	2014-12-07 16:17:41.834225	\N
14525	115	6	2014-12-07 16:17:41.836258	\N
14526	115	20	2014-12-07 16:17:41.838368	\N
14527	115	20	2014-12-07 16:17:41.84044	\N
14528	115	12	2014-12-07 16:17:41.842766	\N
14529	115	3	2014-12-07 16:17:41.845081	\N
14530	115	5	2014-12-07 16:17:41.847126	\N
14531	115	10	2014-12-07 16:17:41.849792	\N
14532	115	10	2014-12-07 16:17:41.851905	\N
14533	115	5	2014-12-07 16:17:41.854046	\N
14534	115	5	2014-12-07 16:17:41.85607	\N
14535	115	8	2014-12-07 16:17:41.858125	\N
14536	115	22	2014-12-07 16:17:41.860153	\N
14537	115	11	2014-12-07 16:17:41.862206	\N
14538	115	10	2014-12-07 16:17:41.864227	\N
14539	115	22	2014-12-07 16:17:41.86637	\N
14540	115	22	2014-12-07 16:17:41.868493	\N
14541	115	22	2014-12-07 16:17:41.870776	\N
14542	115	20	2014-12-07 16:17:41.872806	\N
14543	115	20	2014-12-07 16:17:41.874842	\N
14544	115	20	2014-12-07 16:17:41.876849	\N
14545	115	20	2014-12-07 16:17:41.878859	\N
14546	115	21	2014-12-07 16:17:41.880878	\N
14547	115	21	2014-12-07 16:17:41.883191	\N
14548	115	21	2014-12-07 16:17:41.885407	\N
14549	115	21	2014-12-07 16:17:41.887368	\N
14550	115	21	2014-12-07 16:17:41.88939	\N
14551	115	21	2014-12-07 16:17:41.891342	\N
14552	115	12	2014-12-07 16:17:41.893413	\N
14553	115	12	2014-12-07 16:17:41.895409	\N
14554	115	12	2014-12-07 16:17:41.897429	\N
14555	115	21	2014-12-07 16:17:41.89949	\N
14556	115	12	2014-12-07 16:17:41.901616	\N
14557	115	12	2014-12-07 16:17:41.903799	\N
14558	115	12	2014-12-07 16:17:41.90597	\N
14559	115	6	2014-12-07 16:17:41.908024	\N
14560	115	3	2014-12-07 16:17:41.910077	\N
14561	115	1	2014-12-07 16:17:41.912081	\N
14562	115	3	2014-12-07 16:17:41.914214	\N
14563	115	3	2014-12-07 16:17:41.916417	\N
14564	115	6	2014-12-07 16:17:41.918512	\N
14565	115	3	2014-12-07 16:17:41.920912	\N
14566	115	7	2014-12-07 16:17:41.92301	\N
14567	115	17	2014-12-07 16:17:41.925064	\N
14568	115	7	2014-12-07 16:17:41.927069	\N
14569	116	2	2014-12-07 16:17:42.060668	\N
14570	116	2	2014-12-07 16:17:42.064502	\N
14571	116	2	2014-12-07 16:17:42.067135	\N
14572	116	2	2014-12-07 16:17:42.06959	\N
14573	116	5	2014-12-07 16:17:42.072109	\N
14574	116	5	2014-12-07 16:17:42.074261	\N
14575	116	8	2014-12-07 16:17:42.076337	\N
14576	116	2	2014-12-07 16:17:42.078411	\N
14577	116	2	2014-12-07 16:17:42.080452	\N
14578	116	2	2014-12-07 16:17:42.082542	\N
14579	116	18	2014-12-07 16:17:42.084626	\N
14580	116	7	2014-12-07 16:17:42.086714	\N
14581	116	5	2014-12-07 16:17:42.088774	\N
14582	116	8	2014-12-07 16:17:42.090875	\N
14583	116	8	2014-12-07 16:17:42.092966	\N
14584	116	8	2014-12-07 16:17:42.095118	\N
14585	116	8	2014-12-07 16:17:42.097179	\N
14586	116	8	2014-12-07 16:17:42.099452	\N
14587	116	8	2014-12-07 16:17:42.101531	\N
14588	116	18	2014-12-07 16:17:42.103543	\N
14589	116	18	2014-12-07 16:17:42.105641	\N
14590	116	18	2014-12-07 16:17:42.107823	\N
14591	116	18	2014-12-07 16:17:42.109885	\N
14592	116	18	2014-12-07 16:17:42.111947	\N
14593	116	18	2014-12-07 16:17:42.114032	\N
14594	116	18	2014-12-07 16:17:42.116147	\N
14595	116	4	2014-12-07 16:17:42.118339	\N
14596	116	4	2014-12-07 16:17:42.120455	\N
14597	116	4	2014-12-07 16:17:42.122541	\N
14598	116	4	2014-12-07 16:17:42.124635	\N
14599	116	4	2014-12-07 16:17:42.126787	\N
14600	116	4	2014-12-07 16:17:42.128893	\N
14601	116	4	2014-12-07 16:17:42.131105	\N
14602	116	4	2014-12-07 16:17:42.133288	\N
14603	116	11	2014-12-07 16:17:42.135311	\N
14604	116	11	2014-12-07 16:17:42.137356	\N
14605	116	11	2014-12-07 16:17:42.139284	\N
14606	116	19	2014-12-07 16:17:42.141307	\N
14607	116	19	2014-12-07 16:17:42.143302	\N
14608	116	15	2014-12-07 16:17:42.145439	\N
14609	116	15	2014-12-07 16:17:42.147416	\N
14610	116	19	2014-12-07 16:17:42.149625	\N
14611	116	7	2014-12-07 16:17:42.151868	\N
14612	116	2	2014-12-07 16:17:42.153997	\N
14613	116	9	2014-12-07 16:17:42.156068	\N
14614	116	9	2014-12-07 16:17:42.158102	\N
14615	116	9	2014-12-07 16:17:42.160181	\N
14616	116	9	2014-12-07 16:17:42.162305	\N
14617	116	9	2014-12-07 16:17:42.164524	\N
14618	116	3	2014-12-07 16:17:42.166718	\N
14619	116	21	2014-12-07 16:17:42.168875	\N
14620	116	8	2014-12-07 16:17:42.171037	\N
14621	116	13	2014-12-07 16:17:42.173144	\N
14622	116	8	2014-12-07 16:17:42.175115	\N
14623	116	2	2014-12-07 16:17:42.177144	\N
14624	116	18	2014-12-07 16:17:42.179101	\N
14625	116	16	2014-12-07 16:17:42.181172	\N
14626	116	16	2014-12-07 16:17:42.183185	\N
14627	116	15	2014-12-07 16:17:42.185393	\N
14628	116	15	2014-12-07 16:17:42.187494	\N
14629	116	7	2014-12-07 16:17:42.189486	\N
14630	116	7	2014-12-07 16:17:42.191438	\N
14631	116	7	2014-12-07 16:17:42.193723	\N
14632	116	7	2014-12-07 16:17:42.196092	\N
14633	116	7	2014-12-07 16:17:42.198181	\N
14634	116	7	2014-12-07 16:17:42.200468	\N
14635	116	18	2014-12-07 16:17:42.202472	\N
14636	116	2	2014-12-07 16:17:42.204615	\N
14637	116	7	2014-12-07 16:17:42.206707	\N
14638	116	2	2014-12-07 16:17:42.208786	\N
14639	116	7	2014-12-07 16:17:42.210816	\N
14640	116	6	2014-12-07 16:17:42.212908	\N
14641	116	20	2014-12-07 16:17:42.21508	\N
14642	116	20	2014-12-07 16:17:42.217494	\N
14643	116	12	2014-12-07 16:17:42.219592	\N
14644	116	3	2014-12-07 16:17:42.22179	\N
14645	116	5	2014-12-07 16:17:42.223936	\N
14646	116	10	2014-12-07 16:17:42.22617	\N
14647	116	10	2014-12-07 16:17:42.228295	\N
14648	116	5	2014-12-07 16:17:42.230443	\N
14649	116	5	2014-12-07 16:17:42.232538	\N
14650	116	8	2014-12-07 16:17:42.234644	\N
14651	116	22	2014-12-07 16:17:42.236957	\N
14652	116	11	2014-12-07 16:17:42.239028	\N
14653	116	10	2014-12-07 16:17:42.241126	\N
14654	116	22	2014-12-07 16:17:42.243322	\N
14655	116	22	2014-12-07 16:17:42.245427	\N
14656	116	22	2014-12-07 16:17:42.24765	\N
14657	116	20	2014-12-07 16:17:42.249808	\N
14658	116	20	2014-12-07 16:17:42.252051	\N
14659	116	20	2014-12-07 16:17:42.254081	\N
14660	116	20	2014-12-07 16:17:42.256153	\N
14661	116	21	2014-12-07 16:17:42.25816	\N
14662	116	21	2014-12-07 16:17:42.260297	\N
14663	116	21	2014-12-07 16:17:42.262348	\N
14664	116	21	2014-12-07 16:17:42.264392	\N
14665	116	21	2014-12-07 16:17:42.266516	\N
14666	116	21	2014-12-07 16:17:42.268603	\N
14667	116	12	2014-12-07 16:17:42.270646	\N
14668	116	12	2014-12-07 16:17:42.272948	\N
14669	116	12	2014-12-07 16:17:42.275089	\N
14670	116	21	2014-12-07 16:17:42.277139	\N
14671	116	12	2014-12-07 16:17:42.279141	\N
14672	116	12	2014-12-07 16:17:42.281203	\N
14673	116	12	2014-12-07 16:17:42.283259	\N
14674	116	6	2014-12-07 16:17:42.285321	\N
14675	116	3	2014-12-07 16:17:42.287298	\N
14676	116	1	2014-12-07 16:17:42.289328	\N
14677	116	3	2014-12-07 16:17:42.291317	\N
14678	116	3	2014-12-07 16:17:42.293369	\N
14679	116	6	2014-12-07 16:17:42.295345	\N
14680	116	3	2014-12-07 16:17:42.297473	\N
14681	116	7	2014-12-07 16:17:42.299443	\N
14682	116	17	2014-12-07 16:17:42.301571	\N
14683	116	7	2014-12-07 16:17:42.303675	\N
14684	116	14	2014-12-07 16:17:42.305796	\N
14685	117	2	2014-12-07 16:17:42.440183	\N
14686	117	2	2014-12-07 16:17:42.442698	\N
14687	117	2	2014-12-07 16:17:42.444987	\N
14688	117	2	2014-12-07 16:17:42.447364	\N
14689	117	5	2014-12-07 16:17:42.449973	\N
14690	117	5	2014-12-07 16:17:42.45237	\N
14691	117	8	2014-12-07 16:17:42.454552	\N
14692	117	2	2014-12-07 16:17:42.45665	\N
14693	117	2	2014-12-07 16:17:42.458959	\N
14694	117	2	2014-12-07 16:17:42.461702	\N
14695	117	18	2014-12-07 16:17:42.463825	\N
14696	117	7	2014-12-07 16:17:42.466006	\N
14697	117	5	2014-12-07 16:17:42.468324	\N
14698	117	8	2014-12-07 16:17:42.470739	\N
14699	117	8	2014-12-07 16:17:42.473187	\N
14700	117	8	2014-12-07 16:17:42.475726	\N
14701	117	8	2014-12-07 16:17:42.47795	\N
14702	117	8	2014-12-07 16:17:42.480319	\N
14703	117	8	2014-12-07 16:17:42.482486	\N
14704	117	18	2014-12-07 16:17:42.484823	\N
14705	117	18	2014-12-07 16:17:42.48692	\N
14706	117	18	2014-12-07 16:17:42.489097	\N
14707	117	18	2014-12-07 16:17:42.491215	\N
14708	117	18	2014-12-07 16:17:42.493284	\N
14709	117	18	2014-12-07 16:17:42.495268	\N
14710	117	18	2014-12-07 16:17:42.497313	\N
14711	117	4	2014-12-07 16:17:42.499415	\N
14712	117	4	2014-12-07 16:17:42.501513	\N
14713	117	4	2014-12-07 16:17:42.503561	\N
14714	117	4	2014-12-07 16:17:42.505862	\N
14715	117	4	2014-12-07 16:17:42.508017	\N
14716	117	4	2014-12-07 16:17:42.510135	\N
14717	117	4	2014-12-07 16:17:42.51219	\N
14718	117	4	2014-12-07 16:17:42.514365	\N
14719	117	11	2014-12-07 16:17:42.516628	\N
14720	117	11	2014-12-07 16:17:42.518783	\N
14721	117	11	2014-12-07 16:17:42.5208	\N
14722	117	19	2014-12-07 16:17:42.523055	\N
14723	117	19	2014-12-07 16:17:42.525282	\N
14724	117	15	2014-12-07 16:17:42.527375	\N
14725	117	15	2014-12-07 16:17:42.529484	\N
14726	117	19	2014-12-07 16:17:42.531444	\N
14727	117	7	2014-12-07 16:17:42.533608	\N
14728	117	2	2014-12-07 16:17:42.535619	\N
14729	117	9	2014-12-07 16:17:42.537708	\N
14730	117	9	2014-12-07 16:17:42.539649	\N
14731	117	9	2014-12-07 16:17:42.541718	\N
14732	117	9	2014-12-07 16:17:42.543714	\N
14733	117	9	2014-12-07 16:17:42.545938	\N
14734	117	3	2014-12-07 16:17:42.548178	\N
14735	117	21	2014-12-07 16:17:42.550329	\N
14736	117	8	2014-12-07 16:17:42.552577	\N
14737	117	13	2014-12-07 16:17:42.554675	\N
14738	117	8	2014-12-07 16:17:42.556784	\N
14739	117	2	2014-12-07 16:17:42.558816	\N
14740	117	18	2014-12-07 16:17:42.560851	\N
14741	117	16	2014-12-07 16:17:42.562851	\N
14742	117	16	2014-12-07 16:17:42.565059	\N
14743	117	15	2014-12-07 16:17:42.567183	\N
14744	117	15	2014-12-07 16:17:42.5693	\N
14745	117	7	2014-12-07 16:17:42.571332	\N
14746	117	7	2014-12-07 16:17:42.573488	\N
14747	117	7	2014-12-07 16:17:42.575584	\N
14748	117	7	2014-12-07 16:17:42.577664	\N
14749	117	7	2014-12-07 16:17:42.579643	\N
14750	117	7	2014-12-07 16:17:42.581697	\N
14751	117	18	2014-12-07 16:17:42.583887	\N
14752	117	2	2014-12-07 16:17:42.586031	\N
14753	117	7	2014-12-07 16:17:42.588315	\N
14754	117	2	2014-12-07 16:17:42.590709	\N
14755	117	7	2014-12-07 16:17:42.593011	\N
14756	117	6	2014-12-07 16:17:42.595141	\N
14757	117	20	2014-12-07 16:17:42.597277	\N
14758	117	20	2014-12-07 16:17:42.599264	\N
14759	117	12	2014-12-07 16:17:42.601514	\N
14760	117	3	2014-12-07 16:17:42.603647	\N
14761	117	5	2014-12-07 16:17:42.605814	\N
14762	117	10	2014-12-07 16:17:42.607828	\N
14763	117	10	2014-12-07 16:17:42.609886	\N
14764	117	5	2014-12-07 16:17:42.611862	\N
14765	117	5	2014-12-07 16:17:42.613903	\N
14766	117	8	2014-12-07 16:17:42.616384	\N
14767	117	22	2014-12-07 16:17:42.619	\N
14768	117	11	2014-12-07 16:17:42.621349	\N
14769	117	10	2014-12-07 16:17:42.623375	\N
14770	117	22	2014-12-07 16:17:42.625507	\N
14771	117	22	2014-12-07 16:17:42.627568	\N
14772	117	22	2014-12-07 16:17:42.629661	\N
14773	117	20	2014-12-07 16:17:42.631657	\N
14774	117	20	2014-12-07 16:17:42.633715	\N
14775	117	20	2014-12-07 16:17:42.635798	\N
14776	117	20	2014-12-07 16:17:42.638114	\N
14777	117	21	2014-12-07 16:17:42.640413	\N
14778	117	21	2014-12-07 16:17:42.642523	\N
14779	117	21	2014-12-07 16:17:42.644589	\N
14780	117	21	2014-12-07 16:17:42.646638	\N
14781	117	21	2014-12-07 16:17:42.648706	\N
14782	117	21	2014-12-07 16:17:42.650794	\N
14783	117	12	2014-12-07 16:17:42.652914	\N
14784	117	12	2014-12-07 16:17:42.654941	\N
14785	117	12	2014-12-07 16:17:42.657017	\N
14786	117	21	2014-12-07 16:17:42.659053	\N
14787	117	12	2014-12-07 16:17:42.661266	\N
14788	117	12	2014-12-07 16:17:42.663384	\N
14789	117	12	2014-12-07 16:17:42.665469	\N
14790	117	6	2014-12-07 16:17:42.667766	\N
14791	117	3	2014-12-07 16:17:42.669876	\N
14792	117	1	2014-12-07 16:17:42.671867	\N
14793	117	3	2014-12-07 16:17:42.673915	\N
14794	117	3	2014-12-07 16:17:42.675881	\N
14795	117	6	2014-12-07 16:17:42.677894	\N
14796	117	3	2014-12-07 16:17:42.680018	\N
14797	117	7	2014-12-07 16:17:42.682145	\N
14798	117	17	2014-12-07 16:17:42.684292	\N
14799	117	7	2014-12-07 16:17:42.686405	\N
14800	117	14	2014-12-07 16:17:42.68846	\N
14801	117	7	2014-12-07 16:17:42.690502	\N
14802	118	2	2014-12-07 16:17:42.830453	\N
14803	118	2	2014-12-07 16:17:42.834035	\N
14804	118	2	2014-12-07 16:17:42.836553	\N
14805	118	2	2014-12-07 16:17:42.838825	\N
14806	118	5	2014-12-07 16:17:42.841034	\N
14807	118	5	2014-12-07 16:17:42.843179	\N
14808	118	8	2014-12-07 16:17:42.845688	\N
14809	118	2	2014-12-07 16:17:42.847953	\N
14810	118	2	2014-12-07 16:17:42.850117	\N
14811	118	2	2014-12-07 16:17:42.852516	\N
14812	118	18	2014-12-07 16:17:42.854777	\N
14813	118	7	2014-12-07 16:17:42.856889	\N
14814	118	5	2014-12-07 16:17:42.868439	\N
14815	118	8	2014-12-07 16:17:42.871724	\N
14816	118	8	2014-12-07 16:17:42.87506	\N
14817	118	8	2014-12-07 16:17:42.87786	\N
14818	118	8	2014-12-07 16:17:42.879917	\N
14819	118	8	2014-12-07 16:17:42.883263	\N
14820	118	8	2014-12-07 16:17:42.885925	\N
14821	118	18	2014-12-07 16:17:42.888019	\N
14822	118	18	2014-12-07 16:17:42.89012	\N
14823	118	18	2014-12-07 16:17:42.892162	\N
14824	118	18	2014-12-07 16:17:42.894185	\N
14825	118	18	2014-12-07 16:17:42.896214	\N
14826	118	18	2014-12-07 16:17:42.89818	\N
14827	118	18	2014-12-07 16:17:42.900366	\N
14828	118	4	2014-12-07 16:17:42.902686	\N
14829	118	4	2014-12-07 16:17:42.9049	\N
14830	118	4	2014-12-07 16:17:42.907014	\N
14831	118	4	2014-12-07 16:17:42.909074	\N
14832	118	4	2014-12-07 16:17:42.911158	\N
14833	118	4	2014-12-07 16:17:42.913486	\N
14834	118	4	2014-12-07 16:17:42.915475	\N
14835	118	4	2014-12-07 16:17:42.917584	\N
14836	118	11	2014-12-07 16:17:42.91978	\N
14837	118	11	2014-12-07 16:17:42.922069	\N
14838	118	11	2014-12-07 16:17:42.924159	\N
14839	118	19	2014-12-07 16:17:42.926233	\N
14840	118	19	2014-12-07 16:17:42.928425	\N
14841	118	15	2014-12-07 16:17:42.93051	\N
14842	118	15	2014-12-07 16:17:42.93269	\N
14843	118	19	2014-12-07 16:17:42.934916	\N
14844	118	7	2014-12-07 16:17:42.93702	\N
14845	118	2	2014-12-07 16:17:42.939049	\N
14846	118	9	2014-12-07 16:17:42.941128	\N
14847	118	9	2014-12-07 16:17:42.943304	\N
14848	118	9	2014-12-07 16:17:42.945502	\N
14849	118	9	2014-12-07 16:17:42.947513	\N
14850	118	9	2014-12-07 16:17:42.949682	\N
14851	118	3	2014-12-07 16:17:42.95188	\N
14852	118	21	2014-12-07 16:17:42.954038	\N
14853	118	8	2014-12-07 16:17:42.956029	\N
14854	118	13	2014-12-07 16:17:42.958062	\N
14855	118	8	2014-12-07 16:17:42.960018	\N
14856	118	2	2014-12-07 16:17:42.962087	\N
14857	118	18	2014-12-07 16:17:42.964382	\N
14858	118	16	2014-12-07 16:17:42.966482	\N
14859	118	16	2014-12-07 16:17:42.968584	\N
14860	118	15	2014-12-07 16:17:42.97069	\N
14861	118	15	2014-12-07 16:17:42.972756	\N
14862	118	7	2014-12-07 16:17:42.97489	\N
14863	118	7	2014-12-07 16:17:42.976932	\N
14864	118	7	2014-12-07 16:17:42.979014	\N
14865	118	7	2014-12-07 16:17:42.981147	\N
14866	118	7	2014-12-07 16:17:42.98313	\N
14867	118	7	2014-12-07 16:17:42.98521	\N
14868	118	18	2014-12-07 16:17:42.987397	\N
14869	118	2	2014-12-07 16:17:42.989472	\N
14870	118	7	2014-12-07 16:17:42.991576	\N
14871	118	2	2014-12-07 16:17:42.99373	\N
14872	118	7	2014-12-07 16:17:42.995866	\N
14873	118	6	2014-12-07 16:17:42.997906	\N
14874	118	20	2014-12-07 16:17:42.999966	\N
14875	118	20	2014-12-07 16:17:43.002001	\N
14876	118	12	2014-12-07 16:17:43.003997	\N
14877	118	3	2014-12-07 16:17:43.006121	\N
14878	118	5	2014-12-07 16:17:43.00818	\N
14879	118	10	2014-12-07 16:17:43.010764	\N
14880	118	10	2014-12-07 16:17:43.013244	\N
14881	118	5	2014-12-07 16:17:43.015689	\N
14882	118	5	2014-12-07 16:17:43.017804	\N
14883	118	8	2014-12-07 16:17:43.020151	\N
14884	118	22	2014-12-07 16:17:43.02237	\N
14885	118	11	2014-12-07 16:17:43.024542	\N
14886	118	10	2014-12-07 16:17:43.026677	\N
14887	118	22	2014-12-07 16:17:43.028785	\N
14888	118	22	2014-12-07 16:17:43.030979	\N
14889	118	22	2014-12-07 16:17:43.033142	\N
14890	118	20	2014-12-07 16:17:43.035215	\N
14891	118	20	2014-12-07 16:17:43.037478	\N
14892	118	20	2014-12-07 16:17:43.039653	\N
14893	118	20	2014-12-07 16:17:43.041776	\N
14894	118	21	2014-12-07 16:17:43.043889	\N
14895	118	21	2014-12-07 16:17:43.04616	\N
14896	118	21	2014-12-07 16:17:43.048241	\N
14897	118	21	2014-12-07 16:17:43.050357	\N
14898	118	21	2014-12-07 16:17:43.052575	\N
14899	118	21	2014-12-07 16:17:43.054762	\N
14900	118	12	2014-12-07 16:17:43.056849	\N
14901	118	12	2014-12-07 16:17:43.058897	\N
14902	118	12	2014-12-07 16:17:43.060934	\N
14903	118	21	2014-12-07 16:17:43.063156	\N
14904	118	12	2014-12-07 16:17:43.065212	\N
14905	118	12	2014-12-07 16:17:43.067165	\N
14906	118	12	2014-12-07 16:17:43.069333	\N
14907	118	6	2014-12-07 16:17:43.071576	\N
14908	118	3	2014-12-07 16:17:43.073721	\N
14909	118	1	2014-12-07 16:17:43.075796	\N
14910	118	3	2014-12-07 16:17:43.077836	\N
14911	118	3	2014-12-07 16:17:43.079885	\N
14912	118	6	2014-12-07 16:17:43.081952	\N
14913	118	3	2014-12-07 16:17:43.083983	\N
14914	118	7	2014-12-07 16:17:43.086152	\N
14915	118	17	2014-12-07 16:17:43.088243	\N
14916	118	7	2014-12-07 16:17:43.090278	\N
14917	118	14	2014-12-07 16:17:43.092336	\N
14918	118	7	2014-12-07 16:17:43.094445	\N
14919	118	14	2014-12-07 16:17:43.096515	\N
14920	119	2	2014-12-07 16:17:43.38015	\N
14921	119	2	2014-12-07 16:17:43.383776	\N
14922	119	2	2014-12-07 16:17:43.386342	\N
14923	119	2	2014-12-07 16:17:43.388737	\N
14924	119	5	2014-12-07 16:17:43.391236	\N
14925	119	5	2014-12-07 16:17:43.393486	\N
14926	119	8	2014-12-07 16:17:43.395712	\N
14927	119	2	2014-12-07 16:17:43.397895	\N
14928	119	2	2014-12-07 16:17:43.400159	\N
14929	119	2	2014-12-07 16:17:43.402199	\N
14930	119	18	2014-12-07 16:17:43.404383	\N
14931	119	7	2014-12-07 16:17:43.406511	\N
14932	119	5	2014-12-07 16:17:43.408593	\N
14933	119	8	2014-12-07 16:17:43.41056	\N
14934	119	8	2014-12-07 16:17:43.412644	\N
14935	119	8	2014-12-07 16:17:43.414908	\N
14936	119	8	2014-12-07 16:17:43.417011	\N
14937	119	8	2014-12-07 16:17:43.419115	\N
14938	119	8	2014-12-07 16:17:43.421493	\N
14939	119	18	2014-12-07 16:17:43.423797	\N
14940	119	18	2014-12-07 16:17:43.425976	\N
14941	119	18	2014-12-07 16:17:43.428027	\N
14942	119	18	2014-12-07 16:17:43.430098	\N
14943	119	18	2014-12-07 16:17:43.432153	\N
14944	119	18	2014-12-07 16:17:43.434348	\N
14945	119	18	2014-12-07 16:17:43.436435	\N
14946	119	4	2014-12-07 16:17:43.438528	\N
14947	119	4	2014-12-07 16:17:43.440578	\N
14948	119	4	2014-12-07 16:17:43.442724	\N
14949	119	4	2014-12-07 16:17:43.44526	\N
14950	119	4	2014-12-07 16:17:43.44729	\N
14951	119	4	2014-12-07 16:17:43.449372	\N
14952	119	4	2014-12-07 16:17:43.451338	\N
14953	119	4	2014-12-07 16:17:43.453595	\N
14954	119	11	2014-12-07 16:17:43.455878	\N
14955	119	11	2014-12-07 16:17:43.457974	\N
14956	119	11	2014-12-07 16:17:43.460286	\N
14957	119	19	2014-12-07 16:17:43.462486	\N
14958	119	19	2014-12-07 16:17:43.464672	\N
14959	119	15	2014-12-07 16:17:43.466792	\N
14960	119	15	2014-12-07 16:17:43.468855	\N
14961	119	19	2014-12-07 16:17:43.471759	\N
14962	119	7	2014-12-07 16:17:43.474268	\N
14963	119	2	2014-12-07 16:17:43.476627	\N
14964	119	9	2014-12-07 16:17:43.478908	\N
14965	119	9	2014-12-07 16:17:43.481164	\N
14966	119	9	2014-12-07 16:17:43.483288	\N
14967	119	9	2014-12-07 16:17:43.485295	\N
14968	119	9	2014-12-07 16:17:43.487279	\N
14969	119	3	2014-12-07 16:17:43.489327	\N
14970	119	21	2014-12-07 16:17:43.491277	\N
14971	119	8	2014-12-07 16:17:43.493317	\N
14972	119	13	2014-12-07 16:17:43.495253	\N
14973	119	8	2014-12-07 16:17:43.497355	\N
14974	119	2	2014-12-07 16:17:43.49942	\N
14975	119	18	2014-12-07 16:17:43.501512	\N
14976	119	16	2014-12-07 16:17:43.503819	\N
14977	119	16	2014-12-07 16:17:43.506143	\N
14978	119	15	2014-12-07 16:17:43.508266	\N
14979	119	15	2014-12-07 16:17:43.510319	\N
14980	119	7	2014-12-07 16:17:43.512385	\N
14981	119	7	2014-12-07 16:17:43.514528	\N
14982	119	7	2014-12-07 16:17:43.51661	\N
14983	119	7	2014-12-07 16:17:43.518667	\N
14984	119	7	2014-12-07 16:17:43.520809	\N
14985	119	7	2014-12-07 16:17:43.523064	\N
14986	119	18	2014-12-07 16:17:43.525151	\N
14987	119	2	2014-12-07 16:17:43.527222	\N
14988	119	7	2014-12-07 16:17:43.529295	\N
14989	119	2	2014-12-07 16:17:43.531245	\N
14990	119	7	2014-12-07 16:17:43.533244	\N
14991	119	6	2014-12-07 16:17:43.535215	\N
14992	119	20	2014-12-07 16:17:43.537262	\N
14993	119	20	2014-12-07 16:17:43.539522	\N
14994	119	12	2014-12-07 16:17:43.541664	\N
14995	119	3	2014-12-07 16:17:43.54381	\N
14996	119	5	2014-12-07 16:17:43.545879	\N
14997	119	10	2014-12-07 16:17:43.548021	\N
14998	119	10	2014-12-07 16:17:43.550164	\N
14999	119	5	2014-12-07 16:17:43.552222	\N
15000	119	5	2014-12-07 16:17:43.554558	\N
15001	119	8	2014-12-07 16:17:43.556698	\N
15002	119	22	2014-12-07 16:17:43.558745	\N
15003	119	11	2014-12-07 16:17:43.560779	\N
15004	119	10	2014-12-07 16:17:43.562855	\N
15005	119	22	2014-12-07 16:17:43.56495	\N
15006	119	22	2014-12-07 16:17:43.566994	\N
15007	119	22	2014-12-07 16:17:43.569034	\N
15008	119	20	2014-12-07 16:17:43.571279	\N
15009	119	20	2014-12-07 16:17:43.573485	\N
15010	119	20	2014-12-07 16:17:43.575492	\N
15011	119	20	2014-12-07 16:17:43.57753	\N
15012	119	21	2014-12-07 16:17:43.579519	\N
15013	119	21	2014-12-07 16:17:43.581592	\N
15014	119	21	2014-12-07 16:17:43.583587	\N
15015	119	21	2014-12-07 16:17:43.585596	\N
15016	119	21	2014-12-07 16:17:43.587656	\N
15017	119	21	2014-12-07 16:17:43.589767	\N
15018	119	12	2014-12-07 16:17:43.591948	\N
15019	119	12	2014-12-07 16:17:43.593999	\N
15020	119	12	2014-12-07 16:17:43.596079	\N
15021	119	21	2014-12-07 16:17:43.598098	\N
15022	119	12	2014-12-07 16:17:43.600362	\N
15023	119	12	2014-12-07 16:17:43.602443	\N
15024	119	12	2014-12-07 16:17:43.604698	\N
15025	119	6	2014-12-07 16:17:43.60685	\N
15026	119	3	2014-12-07 16:17:43.608926	\N
15027	119	1	2014-12-07 16:17:43.611038	\N
15028	119	3	2014-12-07 16:17:43.613082	\N
15029	119	3	2014-12-07 16:17:43.615154	\N
15030	119	6	2014-12-07 16:17:43.617224	\N
15031	119	3	2014-12-07 16:17:43.619328	\N
15032	119	7	2014-12-07 16:17:43.621548	\N
15033	119	17	2014-12-07 16:17:43.623616	\N
15034	119	7	2014-12-07 16:17:43.625672	\N
15035	119	14	2014-12-07 16:17:43.627774	\N
15036	119	7	2014-12-07 16:17:43.630086	\N
15037	119	14	2014-12-07 16:17:43.632238	\N
15038	119	14	2014-12-07 16:17:43.634343	\N
15039	120	2	2014-12-07 16:17:43.778461	\N
15040	120	2	2014-12-07 16:17:43.780859	\N
15041	120	2	2014-12-07 16:17:43.783332	\N
15042	120	2	2014-12-07 16:17:43.785589	\N
15043	120	5	2014-12-07 16:17:43.787616	\N
15044	120	5	2014-12-07 16:17:43.789923	\N
15045	120	8	2014-12-07 16:17:43.792168	\N
15046	120	2	2014-12-07 16:17:43.794256	\N
15047	120	2	2014-12-07 16:17:43.796324	\N
15048	120	2	2014-12-07 16:17:43.798397	\N
15049	120	18	2014-12-07 16:17:43.800437	\N
15050	120	7	2014-12-07 16:17:43.802458	\N
15051	120	5	2014-12-07 16:17:43.804501	\N
15052	120	8	2014-12-07 16:17:43.806631	\N
15053	120	8	2014-12-07 16:17:43.809418	\N
15054	120	8	2014-12-07 16:17:43.811549	\N
15055	120	8	2014-12-07 16:17:43.813701	\N
15056	120	8	2014-12-07 16:17:43.815743	\N
15057	120	8	2014-12-07 16:17:43.817907	\N
15058	120	18	2014-12-07 16:17:43.820133	\N
15059	120	18	2014-12-07 16:17:43.82247	\N
15060	120	18	2014-12-07 16:17:43.824594	\N
15061	120	18	2014-12-07 16:17:43.826698	\N
15062	120	18	2014-12-07 16:17:43.828872	\N
15063	120	18	2014-12-07 16:17:43.830996	\N
15064	120	18	2014-12-07 16:17:43.833401	\N
15065	120	4	2014-12-07 16:17:43.835756	\N
15066	120	4	2014-12-07 16:17:43.837866	\N
15067	120	4	2014-12-07 16:17:43.840204	\N
15068	120	4	2014-12-07 16:17:43.842333	\N
15069	120	4	2014-12-07 16:17:43.844427	\N
15070	120	4	2014-12-07 16:17:43.846493	\N
15071	120	4	2014-12-07 16:17:43.84862	\N
15072	120	4	2014-12-07 16:17:43.850764	\N
15073	120	11	2014-12-07 16:17:43.853145	\N
15074	120	11	2014-12-07 16:17:43.855296	\N
15075	120	11	2014-12-07 16:17:43.857396	\N
15076	120	19	2014-12-07 16:17:43.859362	\N
15077	120	19	2014-12-07 16:17:43.861455	\N
15078	120	15	2014-12-07 16:17:43.863462	\N
15079	120	15	2014-12-07 16:17:43.865534	\N
15080	120	19	2014-12-07 16:17:43.867504	\N
15081	120	7	2014-12-07 16:17:43.869567	\N
15082	120	2	2014-12-07 16:17:43.87169	\N
15083	120	9	2014-12-07 16:17:43.873801	\N
15084	120	9	2014-12-07 16:17:43.87582	\N
15085	120	9	2014-12-07 16:17:43.877848	\N
15086	120	9	2014-12-07 16:17:43.879937	\N
15087	120	9	2014-12-07 16:17:43.88215	\N
15088	120	3	2014-12-07 16:17:43.884276	\N
15089	120	21	2014-12-07 16:17:43.88645	\N
15090	120	8	2014-12-07 16:17:43.888534	\N
15091	120	13	2014-12-07 16:17:43.890577	\N
15092	120	8	2014-12-07 16:17:43.892585	\N
15093	120	2	2014-12-07 16:17:43.894594	\N
15094	120	18	2014-12-07 16:17:43.896684	\N
15095	120	16	2014-12-07 16:17:43.899109	\N
15096	120	16	2014-12-07 16:17:43.901191	\N
15097	120	15	2014-12-07 16:17:43.90316	\N
15098	120	15	2014-12-07 16:17:43.905384	\N
15099	120	7	2014-12-07 16:17:43.907415	\N
15100	120	7	2014-12-07 16:17:43.909508	\N
15101	120	7	2014-12-07 16:17:43.911461	\N
15102	120	7	2014-12-07 16:17:43.913513	\N
15103	120	7	2014-12-07 16:17:43.915517	\N
15104	120	7	2014-12-07 16:17:43.9176	\N
15105	120	18	2014-12-07 16:17:43.919664	\N
15106	120	2	2014-12-07 16:17:43.92178	\N
15107	120	7	2014-12-07 16:17:43.923957	\N
15108	120	2	2014-12-07 16:17:43.926116	\N
15109	120	7	2014-12-07 16:17:43.928359	\N
15110	120	6	2014-12-07 16:17:43.930488	\N
15111	120	20	2014-12-07 16:17:43.932526	\N
15112	120	20	2014-12-07 16:17:43.934571	\N
15113	120	12	2014-12-07 16:17:43.936775	\N
15114	120	3	2014-12-07 16:17:43.938854	\N
15115	120	5	2014-12-07 16:17:43.94095	\N
15116	120	10	2014-12-07 16:17:43.942989	\N
15117	120	10	2014-12-07 16:17:43.945207	\N
15118	120	5	2014-12-07 16:17:43.94756	\N
15119	120	5	2014-12-07 16:17:43.949836	\N
15120	120	8	2014-12-07 16:17:43.951886	\N
15121	120	22	2014-12-07 16:17:43.953975	\N
15122	120	11	2014-12-07 16:17:43.956344	\N
15123	120	10	2014-12-07 16:17:43.958558	\N
15124	120	22	2014-12-07 16:17:43.960651	\N
15125	120	22	2014-12-07 16:17:43.962674	\N
15126	120	22	2014-12-07 16:17:43.964794	\N
15127	120	20	2014-12-07 16:17:43.96688	\N
15128	120	20	2014-12-07 16:17:43.968911	\N
15129	120	20	2014-12-07 16:17:43.970996	\N
15130	120	20	2014-12-07 16:17:43.973178	\N
15131	120	21	2014-12-07 16:17:43.975192	\N
15132	120	21	2014-12-07 16:17:43.977202	\N
15133	120	21	2014-12-07 16:17:43.979214	\N
15134	120	21	2014-12-07 16:17:43.981255	\N
15135	120	21	2014-12-07 16:17:43.983277	\N
15136	120	21	2014-12-07 16:17:43.985351	\N
15137	120	12	2014-12-07 16:17:43.987522	\N
15138	120	12	2014-12-07 16:17:43.989754	\N
15139	120	12	2014-12-07 16:17:43.991754	\N
15140	120	21	2014-12-07 16:17:43.993792	\N
15141	120	12	2014-12-07 16:17:43.995716	\N
15142	120	12	2014-12-07 16:17:43.997753	\N
15143	120	12	2014-12-07 16:17:43.999694	\N
15144	120	6	2014-12-07 16:17:44.001795	\N
15145	120	3	2014-12-07 16:17:44.003702	\N
15146	120	1	2014-12-07 16:17:44.005746	\N
15147	120	3	2014-12-07 16:17:44.007713	\N
15148	120	3	2014-12-07 16:17:44.010047	\N
15149	120	6	2014-12-07 16:17:44.012457	\N
15150	120	3	2014-12-07 16:17:44.014834	\N
15151	120	7	2014-12-07 16:17:44.016982	\N
15152	120	17	2014-12-07 16:17:44.019097	\N
15153	120	7	2014-12-07 16:17:44.021229	\N
15154	120	14	2014-12-07 16:17:44.023742	\N
15155	120	7	2014-12-07 16:17:44.025907	\N
15156	120	14	2014-12-07 16:17:44.027899	\N
15157	120	14	2014-12-07 16:17:44.02998	\N
15158	120	6	2014-12-07 16:17:44.032079	\N
15159	121	2	2014-12-07 16:17:44.174351	\N
15160	121	2	2014-12-07 16:17:44.176876	\N
15161	121	2	2014-12-07 16:17:44.179043	\N
15162	121	2	2014-12-07 16:17:44.181349	\N
15163	121	5	2014-12-07 16:17:44.183419	\N
15164	121	5	2014-12-07 16:17:44.185519	\N
15165	121	8	2014-12-07 16:17:44.187553	\N
15166	121	2	2014-12-07 16:17:44.189684	\N
15167	121	2	2014-12-07 16:17:44.191712	\N
15168	121	2	2014-12-07 16:17:44.194069	\N
15169	121	18	2014-12-07 16:17:44.196591	\N
15170	121	7	2014-12-07 16:17:44.198861	\N
15171	121	5	2014-12-07 16:17:44.200968	\N
15172	121	8	2014-12-07 16:17:44.202937	\N
15173	121	8	2014-12-07 16:17:44.205091	\N
15174	121	8	2014-12-07 16:17:44.207597	\N
15175	121	8	2014-12-07 16:17:44.209816	\N
15176	121	8	2014-12-07 16:17:44.211841	\N
15177	121	8	2014-12-07 16:17:44.213873	\N
15178	121	18	2014-12-07 16:17:44.216232	\N
15179	121	18	2014-12-07 16:17:44.218761	\N
15180	121	18	2014-12-07 16:17:44.220884	\N
15181	121	18	2014-12-07 16:17:44.223463	\N
15182	121	18	2014-12-07 16:17:44.225733	\N
15183	121	18	2014-12-07 16:17:44.227968	\N
15184	121	18	2014-12-07 16:17:44.230213	\N
15185	121	4	2014-12-07 16:17:44.232454	\N
15186	121	4	2014-12-07 16:17:44.234627	\N
15187	121	4	2014-12-07 16:17:44.236738	\N
15188	121	4	2014-12-07 16:17:44.238795	\N
15189	121	4	2014-12-07 16:17:44.241275	\N
15190	121	4	2014-12-07 16:17:44.243423	\N
15191	121	4	2014-12-07 16:17:44.24554	\N
15192	121	4	2014-12-07 16:17:44.247601	\N
15193	121	11	2014-12-07 16:17:44.249734	\N
15194	121	11	2014-12-07 16:17:44.251818	\N
15195	121	11	2014-12-07 16:17:44.253857	\N
15196	121	19	2014-12-07 16:17:44.255957	\N
15197	121	19	2014-12-07 16:17:44.258109	\N
15198	121	15	2014-12-07 16:17:44.260152	\N
15199	121	15	2014-12-07 16:17:44.262422	\N
15200	121	19	2014-12-07 16:17:44.26461	\N
15201	121	7	2014-12-07 16:17:44.266745	\N
15202	121	2	2014-12-07 16:17:44.26892	\N
15203	121	9	2014-12-07 16:17:44.271009	\N
15204	121	9	2014-12-07 16:17:44.273114	\N
15205	121	9	2014-12-07 16:17:44.275119	\N
15206	121	9	2014-12-07 16:17:44.277177	\N
15207	121	9	2014-12-07 16:17:44.279185	\N
15208	121	3	2014-12-07 16:17:44.281252	\N
15209	121	21	2014-12-07 16:17:44.283261	\N
15210	121	8	2014-12-07 16:17:44.285314	\N
15211	121	13	2014-12-07 16:17:44.28764	\N
15212	121	8	2014-12-07 16:17:44.289781	\N
15213	121	2	2014-12-07 16:17:44.291856	\N
15214	121	18	2014-12-07 16:17:44.29392	\N
15215	121	16	2014-12-07 16:17:44.296554	\N
15216	121	16	2014-12-07 16:17:44.298739	\N
15217	121	15	2014-12-07 16:17:44.301015	\N
15218	121	15	2014-12-07 16:17:44.303196	\N
15219	121	7	2014-12-07 16:17:44.305689	\N
15220	121	7	2014-12-07 16:17:44.307876	\N
15221	121	7	2014-12-07 16:17:44.310045	\N
15222	121	7	2014-12-07 16:17:44.31213	\N
15223	121	7	2014-12-07 16:17:44.314236	\N
15224	121	7	2014-12-07 16:17:44.316351	\N
15225	121	18	2014-12-07 16:17:44.318768	\N
15226	121	2	2014-12-07 16:17:44.320979	\N
15227	121	7	2014-12-07 16:17:44.323119	\N
15228	121	2	2014-12-07 16:17:44.325271	\N
15229	121	7	2014-12-07 16:17:44.327556	\N
15230	121	6	2014-12-07 16:17:44.329704	\N
15231	121	20	2014-12-07 16:17:44.331773	\N
15232	121	20	2014-12-07 16:17:44.333828	\N
15233	121	12	2014-12-07 16:17:44.335825	\N
15234	121	3	2014-12-07 16:17:44.338084	\N
15235	121	5	2014-12-07 16:17:44.340233	\N
15236	121	10	2014-12-07 16:17:44.342421	\N
15237	121	10	2014-12-07 16:17:44.344481	\N
15238	121	5	2014-12-07 16:17:44.346552	\N
15239	121	5	2014-12-07 16:17:44.348782	\N
15240	121	8	2014-12-07 16:17:44.350965	\N
15241	121	22	2014-12-07 16:17:44.35309	\N
15242	121	11	2014-12-07 16:17:44.355113	\N
15243	121	10	2014-12-07 16:17:44.357208	\N
15244	121	22	2014-12-07 16:17:44.359387	\N
15245	121	22	2014-12-07 16:17:44.36154	\N
15246	121	22	2014-12-07 16:17:44.363669	\N
15247	121	20	2014-12-07 16:17:44.365717	\N
15248	121	20	2014-12-07 16:17:44.367783	\N
15249	121	20	2014-12-07 16:17:44.369902	\N
15250	121	20	2014-12-07 16:17:44.37198	\N
15251	121	21	2014-12-07 16:17:44.374163	\N
15252	121	21	2014-12-07 16:17:44.376288	\N
15253	121	21	2014-12-07 16:17:44.378357	\N
15254	121	21	2014-12-07 16:17:44.380432	\N
15255	121	21	2014-12-07 16:17:44.382719	\N
15256	121	21	2014-12-07 16:17:44.384823	\N
15257	121	12	2014-12-07 16:17:44.38685	\N
15258	121	12	2014-12-07 16:17:44.388876	\N
15259	121	12	2014-12-07 16:17:44.391182	\N
15260	121	21	2014-12-07 16:17:44.393633	\N
15261	121	12	2014-12-07 16:17:44.396173	\N
15262	121	12	2014-12-07 16:17:44.39845	\N
15263	121	12	2014-12-07 16:17:44.400589	\N
15264	121	6	2014-12-07 16:17:44.402842	\N
15265	121	3	2014-12-07 16:17:44.405017	\N
15266	121	1	2014-12-07 16:17:44.407236	\N
15267	121	3	2014-12-07 16:17:44.40938	\N
15268	121	3	2014-12-07 16:17:44.411697	\N
15269	121	6	2014-12-07 16:17:44.413876	\N
15270	121	3	2014-12-07 16:17:44.41597	\N
15271	121	7	2014-12-07 16:17:44.418007	\N
15272	121	17	2014-12-07 16:17:44.420161	\N
15273	121	7	2014-12-07 16:17:44.422151	\N
15274	121	14	2014-12-07 16:17:44.42432	\N
15275	121	7	2014-12-07 16:17:44.426463	\N
15276	121	14	2014-12-07 16:17:44.428578	\N
15277	121	14	2014-12-07 16:17:44.430847	\N
15278	121	6	2014-12-07 16:17:44.432946	\N
15279	121	6	2014-12-07 16:17:44.435253	\N
15280	122	2	2014-12-07 16:17:44.586289	\N
15281	122	2	2014-12-07 16:17:44.588863	\N
15282	122	2	2014-12-07 16:17:44.591275	\N
15283	122	2	2014-12-07 16:17:44.593781	\N
15284	122	5	2014-12-07 16:17:44.596006	\N
15285	122	5	2014-12-07 16:17:44.598142	\N
15286	122	8	2014-12-07 16:17:44.600203	\N
15287	122	2	2014-12-07 16:17:44.602282	\N
15288	122	2	2014-12-07 16:17:44.604378	\N
15289	122	2	2014-12-07 16:17:44.606718	\N
15290	122	18	2014-12-07 16:17:44.609024	\N
15291	122	7	2014-12-07 16:17:44.611116	\N
15292	122	5	2014-12-07 16:17:44.613203	\N
15293	122	8	2014-12-07 16:17:44.61524	\N
15294	122	8	2014-12-07 16:17:44.617539	\N
15295	122	8	2014-12-07 16:17:44.619726	\N
15296	122	8	2014-12-07 16:17:44.62186	\N
15297	122	8	2014-12-07 16:17:44.624162	\N
15298	122	8	2014-12-07 16:17:44.62629	\N
15299	122	18	2014-12-07 16:17:44.628416	\N
15300	122	18	2014-12-07 16:17:44.630518	\N
15301	122	18	2014-12-07 16:17:44.632669	\N
15302	122	18	2014-12-07 16:17:44.634713	\N
15303	122	18	2014-12-07 16:17:44.636952	\N
15304	122	18	2014-12-07 16:17:44.639147	\N
15305	122	18	2014-12-07 16:17:44.64123	\N
15306	122	4	2014-12-07 16:17:44.643247	\N
15307	122	4	2014-12-07 16:17:44.645384	\N
15308	122	4	2014-12-07 16:17:44.647335	\N
15309	122	4	2014-12-07 16:17:44.649364	\N
15310	122	4	2014-12-07 16:17:44.651609	\N
15311	122	4	2014-12-07 16:17:44.65383	\N
15312	122	4	2014-12-07 16:17:44.65593	\N
15313	122	4	2014-12-07 16:17:44.658071	\N
15314	122	11	2014-12-07 16:17:44.660161	\N
15315	122	11	2014-12-07 16:17:44.662312	\N
15316	122	11	2014-12-07 16:17:44.664295	\N
15317	122	19	2014-12-07 16:17:44.666268	\N
15318	122	19	2014-12-07 16:17:44.6683	\N
15319	122	15	2014-12-07 16:17:44.670464	\N
15320	122	15	2014-12-07 16:17:44.672624	\N
15321	122	19	2014-12-07 16:17:44.674803	\N
15322	122	7	2014-12-07 16:17:44.676995	\N
15323	122	2	2014-12-07 16:17:44.679098	\N
15324	122	9	2014-12-07 16:17:44.681163	\N
15325	122	9	2014-12-07 16:17:44.68312	\N
15326	122	9	2014-12-07 16:17:44.685155	\N
15327	122	9	2014-12-07 16:17:44.687151	\N
15328	122	9	2014-12-07 16:17:44.68913	\N
15329	122	3	2014-12-07 16:17:44.691179	\N
15330	122	21	2014-12-07 16:17:44.693234	\N
15331	122	8	2014-12-07 16:17:44.695255	\N
15332	122	13	2014-12-07 16:17:44.698289	\N
15333	122	8	2014-12-07 16:17:44.701323	\N
15334	122	2	2014-12-07 16:17:44.703397	\N
15335	122	18	2014-12-07 16:17:44.705461	\N
15336	122	16	2014-12-07 16:17:44.707656	\N
15337	122	16	2014-12-07 16:17:44.710484	\N
15338	122	15	2014-12-07 16:17:44.71292	\N
15339	122	15	2014-12-07 16:17:44.71517	\N
15340	122	7	2014-12-07 16:17:44.71727	\N
15341	122	7	2014-12-07 16:17:44.719295	\N
15342	122	7	2014-12-07 16:17:44.721298	\N
15343	122	7	2014-12-07 16:17:44.725641	\N
15344	122	7	2014-12-07 16:17:44.728033	\N
15345	122	7	2014-12-07 16:17:44.730344	\N
15346	122	18	2014-12-07 16:17:44.732441	\N
15347	122	2	2014-12-07 16:17:44.734524	\N
15348	122	7	2014-12-07 16:17:44.736596	\N
15349	122	2	2014-12-07 16:17:44.738682	\N
15350	122	7	2014-12-07 16:17:44.740953	\N
15351	122	6	2014-12-07 16:17:44.743158	\N
15352	122	20	2014-12-07 16:17:44.745254	\N
15353	122	20	2014-12-07 16:17:44.747257	\N
15354	122	12	2014-12-07 16:17:44.749251	\N
15355	122	3	2014-12-07 16:17:44.751283	\N
15356	122	5	2014-12-07 16:17:44.753302	\N
15357	122	10	2014-12-07 16:17:44.75524	\N
15358	122	10	2014-12-07 16:17:44.75722	\N
15359	122	5	2014-12-07 16:17:44.759485	\N
15360	122	5	2014-12-07 16:17:44.761793	\N
15361	122	8	2014-12-07 16:17:44.763911	\N
15362	122	22	2014-12-07 16:17:44.766111	\N
15363	122	11	2014-12-07 16:17:44.768183	\N
15364	122	10	2014-12-07 16:17:44.770328	\N
15365	122	22	2014-12-07 16:17:44.772708	\N
15366	122	22	2014-12-07 16:17:44.774904	\N
15367	122	22	2014-12-07 16:17:44.777068	\N
15368	122	20	2014-12-07 16:17:44.779128	\N
15369	122	20	2014-12-07 16:17:44.781204	\N
15370	122	20	2014-12-07 16:17:44.783196	\N
15371	122	20	2014-12-07 16:17:44.785214	\N
15372	122	21	2014-12-07 16:17:44.787173	\N
15373	122	21	2014-12-07 16:17:44.789227	\N
15374	122	21	2014-12-07 16:17:44.791308	\N
15375	122	21	2014-12-07 16:17:44.793682	\N
15376	122	21	2014-12-07 16:17:44.795833	\N
15377	122	21	2014-12-07 16:17:44.797905	\N
15378	122	12	2014-12-07 16:17:44.799935	\N
15379	122	12	2014-12-07 16:17:44.802149	\N
15380	122	12	2014-12-07 16:17:44.80424	\N
15381	122	21	2014-12-07 16:17:44.806353	\N
15382	122	12	2014-12-07 16:17:44.808472	\N
15383	122	12	2014-12-07 16:17:44.810593	\N
15384	122	12	2014-12-07 16:17:44.812671	\N
15385	122	6	2014-12-07 16:17:44.814809	\N
15386	122	3	2014-12-07 16:17:44.81696	\N
15387	122	1	2014-12-07 16:17:44.818991	\N
15388	122	3	2014-12-07 16:17:44.821062	\N
15389	122	3	2014-12-07 16:17:44.823236	\N
15390	122	6	2014-12-07 16:17:44.82539	\N
15391	122	3	2014-12-07 16:17:44.827436	\N
15392	122	7	2014-12-07 16:17:44.829497	\N
15393	122	17	2014-12-07 16:17:44.831535	\N
15394	122	7	2014-12-07 16:17:44.833756	\N
15395	122	14	2014-12-07 16:17:44.835987	\N
15396	122	7	2014-12-07 16:17:44.838041	\N
15397	122	14	2014-12-07 16:17:44.840147	\N
15398	122	14	2014-12-07 16:17:44.842251	\N
15399	122	6	2014-12-07 16:17:44.844373	\N
15400	122	6	2014-12-07 16:17:44.84639	\N
15401	122	6	2014-12-07 16:17:44.84847	\N
15402	123	2	2014-12-07 16:17:45.069391	\N
15403	123	2	2014-12-07 16:17:45.071882	\N
15404	123	2	2014-12-07 16:17:45.074213	\N
15405	123	2	2014-12-07 16:17:45.07655	\N
15406	123	5	2014-12-07 16:17:45.078698	\N
15407	123	5	2014-12-07 16:17:45.0808	\N
15408	123	8	2014-12-07 16:17:45.082853	\N
15409	123	2	2014-12-07 16:17:45.085065	\N
15410	123	2	2014-12-07 16:17:45.087096	\N
15411	123	2	2014-12-07 16:17:45.089144	\N
15412	123	18	2014-12-07 16:17:45.091125	\N
15413	123	7	2014-12-07 16:17:45.093296	\N
15414	123	5	2014-12-07 16:17:45.095325	\N
15415	123	8	2014-12-07 16:17:45.097365	\N
15416	123	8	2014-12-07 16:17:45.099534	\N
15417	123	8	2014-12-07 16:17:45.101752	\N
15418	123	8	2014-12-07 16:17:45.103818	\N
15419	123	8	2014-12-07 16:17:45.105915	\N
15420	123	8	2014-12-07 16:17:45.108041	\N
15421	123	18	2014-12-07 16:17:45.110204	\N
15422	123	18	2014-12-07 16:17:45.112286	\N
15423	123	18	2014-12-07 16:17:45.114456	\N
15424	123	18	2014-12-07 16:17:45.116491	\N
15425	123	18	2014-12-07 16:17:45.118565	\N
15426	123	18	2014-12-07 16:17:45.120935	\N
15427	123	18	2014-12-07 16:17:45.123147	\N
15428	123	4	2014-12-07 16:17:45.125289	\N
15429	123	4	2014-12-07 16:17:45.12739	\N
15430	123	4	2014-12-07 16:17:45.12974	\N
15431	123	4	2014-12-07 16:17:45.13189	\N
15432	123	4	2014-12-07 16:17:45.13397	\N
15433	123	4	2014-12-07 16:17:45.13611	\N
15434	123	4	2014-12-07 16:17:45.138221	\N
15435	123	4	2014-12-07 16:17:45.140286	\N
15436	123	11	2014-12-07 16:17:45.142572	\N
15437	123	11	2014-12-07 16:17:45.144635	\N
15438	123	11	2014-12-07 16:17:45.146871	\N
15439	123	19	2014-12-07 16:17:45.149038	\N
15440	123	19	2014-12-07 16:17:45.151102	\N
15441	123	15	2014-12-07 16:17:45.153142	\N
15442	123	15	2014-12-07 16:17:45.155165	\N
15443	123	19	2014-12-07 16:17:45.15734	\N
15444	123	7	2014-12-07 16:17:45.159575	\N
15445	123	2	2014-12-07 16:17:45.161951	\N
15446	123	9	2014-12-07 16:17:45.164268	\N
15447	123	9	2014-12-07 16:17:45.166599	\N
15448	123	9	2014-12-07 16:17:45.168703	\N
15449	123	9	2014-12-07 16:17:45.17078	\N
15450	123	9	2014-12-07 16:17:45.172813	\N
15451	123	3	2014-12-07 16:17:45.174895	\N
15452	123	21	2014-12-07 16:17:45.177001	\N
15453	123	8	2014-12-07 16:17:45.179022	\N
15454	123	13	2014-12-07 16:17:45.181074	\N
15455	123	8	2014-12-07 16:17:45.183093	\N
15456	123	2	2014-12-07 16:17:45.1852	\N
15457	123	18	2014-12-07 16:17:45.187201	\N
15458	123	16	2014-12-07 16:17:45.189309	\N
15459	123	16	2014-12-07 16:17:45.191317	\N
15460	123	15	2014-12-07 16:17:45.1938	\N
15461	123	15	2014-12-07 16:17:45.195903	\N
15462	123	7	2014-12-07 16:17:45.198008	\N
15463	123	7	2014-12-07 16:17:45.200162	\N
15464	123	7	2014-12-07 16:17:45.20235	\N
15465	123	7	2014-12-07 16:17:45.204393	\N
15466	123	7	2014-12-07 16:17:45.206645	\N
15467	123	7	2014-12-07 16:17:45.208667	\N
15468	123	18	2014-12-07 16:17:45.210731	\N
15469	123	2	2014-12-07 16:17:45.212907	\N
15470	123	7	2014-12-07 16:17:45.215055	\N
15471	123	2	2014-12-07 16:17:45.217268	\N
15472	123	7	2014-12-07 16:17:45.219213	\N
15473	123	6	2014-12-07 16:17:45.221204	\N
15474	123	20	2014-12-07 16:17:45.223335	\N
15475	123	20	2014-12-07 16:17:45.225729	\N
15476	123	12	2014-12-07 16:17:45.227795	\N
15477	123	3	2014-12-07 16:17:45.229887	\N
15478	123	5	2014-12-07 16:17:45.232014	\N
15479	123	10	2014-12-07 16:17:45.234053	\N
15480	123	10	2014-12-07 16:17:45.236226	\N
15481	123	5	2014-12-07 16:17:45.238245	\N
15482	123	5	2014-12-07 16:17:45.240325	\N
15483	123	8	2014-12-07 16:17:45.242339	\N
15484	123	22	2014-12-07 16:17:45.244511	\N
15485	123	11	2014-12-07 16:17:45.246677	\N
15486	123	10	2014-12-07 16:17:45.248796	\N
15487	123	22	2014-12-07 16:17:45.250804	\N
15488	123	22	2014-12-07 16:17:45.252798	\N
15489	123	22	2014-12-07 16:17:45.254801	\N
15490	123	20	2014-12-07 16:17:45.256802	\N
15491	123	20	2014-12-07 16:17:45.2588	\N
15492	123	20	2014-12-07 16:17:45.261171	\N
15493	123	20	2014-12-07 16:17:45.263262	\N
15494	123	21	2014-12-07 16:17:45.265371	\N
15495	123	21	2014-12-07 16:17:45.267581	\N
15496	123	21	2014-12-07 16:17:45.26966	\N
15497	123	21	2014-12-07 16:17:45.271634	\N
15498	123	21	2014-12-07 16:17:45.273655	\N
15499	123	21	2014-12-07 16:17:45.275637	\N
15500	123	12	2014-12-07 16:17:45.277725	\N
15501	123	12	2014-12-07 16:17:45.279807	\N
15502	123	12	2014-12-07 16:17:45.28189	\N
15503	123	21	2014-12-07 16:17:45.28388	\N
15504	123	12	2014-12-07 16:17:45.285875	\N
15505	123	12	2014-12-07 16:17:45.287869	\N
15506	123	12	2014-12-07 16:17:45.289884	\N
15507	123	6	2014-12-07 16:17:45.291891	\N
15508	123	3	2014-12-07 16:17:45.294028	\N
15509	123	1	2014-12-07 16:17:45.296254	\N
15510	123	3	2014-12-07 16:17:45.298321	\N
15511	123	3	2014-12-07 16:17:45.300353	\N
15512	123	6	2014-12-07 16:17:45.302373	\N
15513	123	3	2014-12-07 16:17:45.304558	\N
15514	123	7	2014-12-07 16:17:45.30672	\N
15515	123	17	2014-12-07 16:17:45.308747	\N
15516	123	7	2014-12-07 16:17:45.310875	\N
15517	123	14	2014-12-07 16:17:45.312927	\N
15518	123	7	2014-12-07 16:17:45.31499	\N
15519	123	14	2014-12-07 16:17:45.317174	\N
15520	123	14	2014-12-07 16:17:45.319177	\N
15521	123	6	2014-12-07 16:17:45.321189	\N
15522	123	6	2014-12-07 16:17:45.32331	\N
15523	123	6	2014-12-07 16:17:45.325491	\N
15524	123	6	2014-12-07 16:17:45.327678	\N
\.


--
-- Name: goal_secretary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_secretary_id_seq', 15524, true);


--
-- Data for Name: management; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY management (id, name, start_date, expected_end_date, city_id, organization_id, active, created_at) FROM stdin;
2	Asdas	18/08/1991	18/09/2018	1	7	\N	\N
3	Asdasd	asdasd	asDASd	1	5	\N	\N
\.


--
-- Name: management_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('management_id_seq', 3, true);


--
-- Data for Name: objective; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY objective (id, name, created_at, updated_at) FROM stdin;
1	Desenvolvimento Social	2014-12-07 16:16:31.674235	\N
2	Educação	2014-12-07 16:16:34.062838	\N
3	Saúde	2014-12-07 16:16:40.679551	\N
4	Cultura	2014-12-07 16:16:44.639505	\N
5	Habitação	2014-12-07 16:16:53.111086	\N
6	Segurança	2014-12-07 16:16:57.997349	\N
7	Esporte e Lazer	2014-12-07 16:17:00.092793	\N
8	Pessoas com Deficiência	2014-12-07 16:17:03.236981	\N
9	Direitos Humanos e Cidadania	2014-12-07 16:17:05.444071	\N
10	População Idosa	2014-12-07 16:17:08.721627	\N
11	Espaços Públicos	2014-12-07 16:17:10.649394	\N
12	Desenvolvimento Econômico	2014-12-07 16:17:15.942283	\N
13	Tecnologia e Inovação	2014-12-07 16:17:16.793637	\N
14	Meio Ambiente	2014-12-07 16:17:17.576969	\N
15	Resíduos Sólidos	2014-12-07 16:17:22.808426	\N
16	Mobilidade	2014-12-07 16:17:26.780709	\N
17	Drenagem	2014-12-07 16:17:34.812781	\N
18	Atendimento ao Cidadão	2014-12-07 16:17:37.915638	\N
19	Participação e Transparência	2014-12-07 16:17:40.654827	\N
20	Desenvolvimento Urbano	2014-12-07 16:17:43.683645	\N
\.


--
-- Name: objective_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('objective_id_seq', 20, true);


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organization (id, name, address, postal_code, city_id, description, email, website, phone, number, complement) FROM stdin;
5	ONG CMA	martins	12312312	1	Controle de Metas	renan.azevedo.carvalho@gmail.com	www.gogle.com	(12) 21312-3123	1234	asdasdasdasd
7	ONG Controle	rua foo	123131231	1	Controle de Metas	teste@email.com	teste.com.br	(12) 99999-9999	80912	holanda
8	ong3	rua holanda 3	32132-132	1	ong3	on3@gmail.com	ong.com.br	(12) 31231-2312	123	\N
\.


--
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organization_id_seq', 8, true);


--
-- Data for Name: pre_register; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pre_register (id, username, useremail) FROM stdin;
1	renan	123@email.com
2	teste	12345@email.com
3	lol	lol@email.com
4	trying	try@email.com
5	olho	olho@email.com
6	moo	moo@email.com
7	coo	coo@email.com
8	voo	voo@email.com
9	renanzao	renanzao@email.com
\.


--
-- Name: pre_register_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pre_register_id_seq', 9, true);


--
-- Data for Name: prefecture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY prefecture (id, name, acronym, created_at, updated_at, latitude, longitude) FROM stdin;
304	Aricanduva/Formosa/Carrão	AF	2014-12-07 16:10:42.795284	\N	-23.549884	-46.536692
305	Butantã	BT	2014-12-07 16:10:42.861291	\N	-23.588369	-46.738026
306	Campo Limpo	CL	2014-12-07 16:10:42.865733	\N	-23.647178	-46.756453
307	Capela do Socorro	CS	2014-12-07 16:10:42.871208	\N	-23.719853	-46.701631
308	Casa Verde/Cachoeirinha	CV	2014-12-07 16:10:42.876046	\N	-23.518827	-46.667202
309	Cidade Ademar	AD	2014-12-07 16:10:42.881267	\N	-23.667083	-46.675166
310	Cidade Tiradentes	CT	2014-12-07 16:10:42.885229	\N	-23.583831	-46.415072
311	Ermelino Matarazzo	EM	2014-12-07 16:10:42.889047	\N	-23.507539	-46.480006
312	Freguesia/Brasilândia	FO	2014-12-07 16:10:42.892749	\N	-23.476247	-46.664606
313	Guaianases	G	2014-12-07 16:10:42.896815	\N	-23.542702	-46.424817
314	Ipiranga	IP	2014-12-07 16:10:42.90071	\N	-23.587567	-46.603258
315	Itaim Paulista	IT	2014-12-07 16:10:42.904368	\N	-23.49402	-46.416706
316	Itaquera	IQ	2014-12-07 16:10:42.908009	\N	-23.536844	-46.45446
317	Jabaquara	JA 	2014-12-07 16:10:42.911748	\N	-23.49402	-46.416706
318	Jaçanã/Tremembé	JT	2014-12-07 16:10:42.915571	\N	-23.468206	-46.582182
319	Lapa	LA	2014-12-07 16:10:42.919566	\N	-23.52247	-46.695516
320	M'Boi Mirim	MB	2014-12-07 16:10:42.923215	\N	-23.667643	-46.728435
321	Mooca	MO	2014-12-07 16:10:42.9273	\N	-23.551346	-46.597937
322	Parelheiros	PA	2014-12-07 16:10:42.93124	\N	-23.81517	-46.73532
323	Penha	PE	2014-12-07 16:10:42.93502	\N	-23.518688	-46.521483
324	Perus	PR	2014-12-07 16:10:42.938787	\N	-23.518688	-46.521483
325	Pinheiros	PI	2014-12-07 16:10:42.942633	\N	-23.564339	-46.703263
326	Pirituba	PJ	2014-12-07 16:10:42.946398	\N	-23.485963	-46.719397
327	Santana/Tucuruvi	ST	2014-12-07 16:10:42.950232	\N	-23.485963	-46.719397
328	Santo Amaro	SA	2014-12-07 16:10:42.954383	\N	-23.6511	-46.707524
329	São Mateus	SM	2014-12-07 16:10:42.957973	\N	-23.6511	-46.707524
330	São Miguel	MP	2014-12-07 16:10:42.961801	\N	-23.500517	-46.451191
331	Sé	SE	2014-12-07 16:10:42.965482	\N	-23.547886	-46.634732
332	Vila Maria/Vila Guilherme	MG	2014-12-07 16:10:42.969591	\N	-23.501387	-46.591497
333	Vila Mariana	VM	2014-12-07 16:10:42.973145	\N	-23.598524	-46.649488
334	Vila Prudente	VP	2014-12-07 16:10:42.976704	\N	-23.582639	-46.560577
335	Sapopemba	SB	2014-12-07 16:10:42.980248	\N	-23.600263	-46.51282
336	Supra-regional	SR	2014-12-07 16:10:42.984175	\N		
337	Em definição	ED	2014-12-07 16:16:35.411756	\N		
\.


--
-- Name: prefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('prefecture_id_seq', 337, true);


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project (id, name, address, latitude, longitude, budget_executed, created_at, updated_at) FROM stdin;
2805	Famílias inseridas no Cadastro Único	\N	0	0	9421876.52999999933	2014-12-07 16:10:42.991062	\N
2806	Famílias beneficiadas com o Programa Bolsa Família	\N	0	0	0	2014-12-07 16:16:31.801411	\N
2807	Novas famílias beneficiadas com o Programa Bolsa Família - Concessão acumulada	\N	0	0	\N	2014-12-07 16:16:31.896912	\N
2808	CRAS - Artur Alvim	Rua José Balangio, 188	-23.550998	-46.485571	0	2014-12-07 16:16:31.933463	\N
2809	CRAS - Cidade Dutra	Rua Jaime Freitas Moniz, Rua João Goulart	-23.719305	-46.673204	0	2014-12-07 16:16:31.94402	\N
2810	CRAS - Freguesia do ó	Rua Jacutiba, 167	-23.48351	-46.69348	0	2014-12-07 16:16:31.953081	\N
2811	CRAS - Grajaú V	Estrada do Barro Branco, 1500	-23.76656	-46.67575	0	2014-12-07 16:16:31.962575	\N
2812	CRAS - Grajaú II	Estrada da Ligação, Rua Guaracy Torres	-23.756775	-46.664001	0	2014-12-07 16:16:31.972548	\N
2813	CRAS - Grajaú III	Av. Agenor Klaussener	-23.771042	-46.687266	0	2014-12-07 16:16:31.981977	\N
2814	CRAS - Grajaú IV	Av. Vala das Canas, Rua Alexandre Giusti, Rua Nolasco da Cunha e Rua Gregório Viegas	-23.745209	-46.700809	0	2014-12-07 16:16:31.991265	\N
2815	CRAS - Jaraguá I	Estrada de Taipas (Pq. Linear do Fogo)	-23.452511	-46.736285	0	2014-12-07 16:16:32.000931	\N
2816	CRAS - Jd. Ângela I	Rua Citeron, Rua Conde de Silva Monteiro, Rua São Paulo e Rua Pernamabuco	-23.72805	-46.78955	0	2014-12-07 16:16:32.010536	\N
2817	CRAS - Jd. Ângela II	Rua Licínio Felini; Rua Julio Nicati; Rua Francisco Giocondo; Rua Benedito Biscop; Rua Antonio Escotti; Rua Emanuel List; e Rua José Boscoli; Avenida M'Boi Guaçu (Antigo Rua Bandeirantes); Rua Hum; Rua Dois; Rua três; Rua quatro; Rua Cinco e Rua Seis	-23.72671	-46.77275	0	2014-12-07 16:16:32.019605	\N
2818	CRAS - Jd. Ângela III	Rua Manoel Soares da Silva, Rua Albergati Capacelli e Rua Valdeci Araújo Ribeiro	-23.74931	-46.77682	0	2014-12-07 16:16:32.029629	\N
2819	CRAS - Jd. São luiz	Rua Francisco S. da Silva; Rua Pibarra e Rua Huelva	-23.68889	-46.74437	0	2014-12-07 16:16:32.039392	\N
2820	CRAS - José Bonifácio I	Rua Amor de Índio, esquina com Rua Domingos Rufino, s/n	-23.554998	-46.432032	0	2014-12-07 16:16:32.049266	\N
2821	CRAS - José Bonifácio II	Rua Professora Lucila Cerqueira, 194	-23.547342	-46.427786	0	2014-12-07 16:16:32.060154	\N
2822	CRAS - Mooca II	Rua Taquari, 635	-23.550549	-46.597300	0	2014-12-07 16:16:32.070013	\N
2823	CRAS - Parelheiros	Avenida Senador Teotônio Vilela; Avenida Sadamu Inoue; Estrada Colônia e Estrada Vargem Grande	-23.772704	-46.721865	0	2014-12-07 16:16:32.079721	\N
2824	CRAS - Parque do carmo	Av. Afonso Sampaio e Souza, 2001	-23.57519	-46.47700	0	2014-12-07 16:16:32.089509	\N
2825	CRAS - Pedreira	Rua da Saúde; Estrada da Áugua Santa	-23.709669	-46.623672	0	2014-12-07 16:16:32.099395	\N
2826	CRAS - Santo Amaro	Av. Padre José Maria, 555	-23.654821	-46.709598	0	2014-12-07 16:16:32.109153	\N
2827	CRAS - São Miguel	Rua Mario Dallari, 170	-23.49885	-46.42947	0	2014-12-07 16:16:32.118529	\N
2828	CRAS - São Rafael	Estrada da Servidão Sete, S/N	-23.682071	-46.672318	0	2014-12-07 16:16:32.128983	\N
2829	CRAS - Sapopemba	Rua Pedro de Castro Velho, 87	-23.587938	-46.516378	0	2014-12-07 16:16:32.13884	\N
2830	CRAS - Tatuapé	Rua Monte Serrat, 230	-23.53990	-46.56227	0	2014-12-07 16:16:32.148599	\N
2831	CRAS - Tremembé I	Rua Adauto Bezerra Delgado, 94 (CDM Jd. Joamar/Pq. Da Pedra)	-23.450160	-46.596896	0	2014-12-07 16:16:32.158642	\N
2832	CRAS - Vila Maria	Avenida Ernesto Augusto Lopes, 100	-23.520159	-46.575982	0	2014-12-07 16:16:32.168534	\N
2833	CRAS - Vila Prudente	Av. Francisco Falconi, 83	-23.583731	-46.568543	0	2014-12-07 16:16:32.178093	\N
2834	CRAS - Jd Nazaré	Rua Plácido Parreira de Lima, 600 - Jardim Nazaré	-23.521624	-46.407473	0	2014-12-07 16:16:32.18857	\N
2835	CRAS - Itaim Paulista	Rua Padre Virgílio Campello, 150	-23.504036	-46.379552	0	2014-12-07 16:16:32.198353	\N
2836	CRAS  - Tremembé	Rua Ari da Rocha Miranda, 36 	-23.451973	-46.577833	0	2014-12-07 16:16:32.207613	\N
2837	CRAS GRAJAU	Rua Pinheiro Chagas s/nº	0	0	0	2014-12-07 16:16:32.217816	\N
2838	CRAS  - Capão Redondo (Feitiço da Vila)	Estrada de Itapecerica, 8887 	-23.683959	-46.798319	0	2014-12-07 16:16:32.2275	\N
2839	CRAS Cidade Tiradentes	Av. Nascer do Sol esquina com Rua D. Eloá do Vale Quadros	-23.593503	-46.415066	0	2014-12-07 16:16:32.236936	\N
2840	CREAS 1 - em área do Programa de Mananciais	Avenida Senador Teotônio Vilela; Avenida Sadamu Inoue; Estrada Colônia e Estrada Vargem Grande	-23.772704	-46.721865	0	2014-12-07 16:16:32.344313	\N
2841	CREAS 2 - em área do Programa Minha Casa Minha Vida	Rua Davide Perez com a Rua Salvador Dali	-23.709032	-46.656362	0	2014-12-07 16:16:32.355753	\N
2842	CREAS 3- Cidade Tiradentes	R Nascer do Sol X R Eloá do Vale Quadros	-23.593503	-46.415066	0	2014-12-07 16:16:32.366874	\N
2843	CREAS 4- Pinheiros	RUA MOURATO COELHO, 104/106	-23.565957	-46.685844	0	2014-12-07 16:16:32.377546	\N
2844	Matrículas nas vagas do Programa Nacional de Acesso ao Ensino Técnico e Emprego (PRONATEC)	\N	0	0	0	2014-12-07 16:16:32.417717	\N
2845	Vagas do Programa Nacional de Acesso ao Ensino Técnico e Emprego (PRONATEC)	\N	0	0	0	2014-12-07 16:16:32.429141	\N
2846	Microempreendedores individuais formalizados	\N	0	0	2038750	2014-12-07 16:16:32.470662	\N
2847	Centro Integrados (CIEJA) - São Mateus	\N	0	0	0	2014-12-07 16:16:32.51653	\N
2848	Centro Integrado (CIEJA) - Pirituba	\N	0	0	0	2014-12-07 16:16:32.526296	\N
2849	Centro Integrado (CIEJA) - São Miguel	\N	0	0	0	2014-12-07 16:16:32.536102	\N
2850	Vagas para Educação de Jovens e Adultos	\N	0	0	6475598.49000000022	2014-12-07 16:16:32.547677	\N
2851	Centro POP Rua 1	R. Prates, 1101	-23.524375	-46.634439	0	2014-12-07 16:16:32.592298	\N
2852	Centro POP Rua 2	\N	0	0	0	2014-12-07 16:16:32.603585	\N
2853	Centro POP Rua 3	\N	0	0	0	2014-12-07 16:16:32.613778	\N
2854	Centro POP Rua 4	R Promotor Gabriel Netuzzi Peres,	-23.652957	-46.703208	0	2014-12-07 16:16:32.623322	\N
2855	Centro POP Rua 5	\N	0	0	0	2014-12-07 16:16:32.633616	\N
2856	Centro Pop Rua 6	Av Zacki Narchi, 600	-23.510072	-46.618582	0	2014-12-07 16:16:32.643457	\N
2857	Restaurante comunitário - Sé	\N	0	0	0	2014-12-07 16:16:32.697433	\N
2858	Restaurante comunitário - Mooca	\N	0	0	0	2014-12-07 16:16:32.707251	\N
2859	Centro de Acolhida para Adultos I por 16 horas - Zaki Narchi I	Av. Zaki Narchi, 600	-23.510125	-46.618587	0	2014-12-07 16:16:32.753815	\N
2860	Centro de Acolhida para Adultos  por 24 horas  - Zaki Narchi II	Av. Zaki Narchi, 600	-23.510125	-46.618587	0	2014-12-07 16:16:32.764406	\N
2861	Centro de Acolhida para Adultos por 24 horas - Zaki Narchi III	Av. Zaki Narchi, 600	-23.510125	-46.618587	0	2014-12-07 16:16:32.774747	\N
2862	Serviço de Acolhimento Institucional - República I	R Catumbi, 588/626	-23.533195	-46.601105	0	2014-12-07 16:16:32.78549	\N
2863	Serviço de Acolhimento Institucional - República II	R Catumbi, 588/627	-23.533195	-46.601106	0	2014-12-07 16:16:32.79476	\N
2864	Serviço de Acolhimento Institucional - República III	R Catumbi, 588/628	-23.533195	-46.601107	0	2014-12-07 16:16:32.804688	\N
2865	Serviço de Acolhimento para Famílias - Penha	Rua Coronel Meireles, 740	-23.516463	-46.535625	0	2014-12-07 16:16:32.815212	\N
3036	CEI 209	\N	0	0	0	2014-12-07 16:16:35.415971	\N
2866	Serviço de Acolhimento para Famílias - Belém	Rua Julio de Castilho, 620/622 	-23.541412	-46.594863	719455.540000000037	2014-12-07 16:16:32.825353	\N
2867	Serviço de Acolhimento Institucional - Butantã	\N	0	0	0	2014-12-07 16:16:32.836045	\N
2868	Serviço de Acolhimento Institucional - Campo Limpo	\N	0	0	0	2014-12-07 16:16:32.849638	\N
2869	Centro de Acolhida para Adultos I por 16 horas - Grajaú	Rua José do Rio Preto, 190	-23.754299	-46.683189	0	2014-12-07 16:16:32.861636	\N
2870	Serviço de Acolhimento para Família - Casa Verde	Rua Brazelisa Alves de Carvalho, 414	-23.511957	-46.650658	0	2014-12-07 16:16:32.873265	\N
2871	Serviço de Acolhimento Institucional - Ermelino Matarazzo	R. Prof. Antonio Castro Lopes, 1265	-23.495089	-46.479915	0	2014-12-07 16:16:32.884615	\N
2872	Serviço de Acolhimento Institucional - Freguesia	\N	0	0	0	2014-12-07 16:16:32.89834	\N
2873	Serviço de Acolhimento Institucional - Guaianases	\N	0	0	0	2014-12-07 16:16:32.909578	\N
2874	Serviço de Acolhimento Institucional - Guaianases II	\N	0	0	0	2014-12-07 16:16:32.920438	\N
2875	Serviço de Acolhimento Institucional - Jabaquara	\N	0	0	0	2014-12-07 16:16:32.931389	\N
2876	Serviço de Acolhimento Institucional - Lapa	\N	0	0	0	2014-12-07 16:16:32.941707	\N
2877	Serviço de Acolhimento Institucional - Mooca	\N	0	0	0	2014-12-07 16:16:32.952876	\N
2878	Serviço de Acolhimento Institucional - Santana/Tucuruvi	\N	0	0	0	2014-12-07 16:16:32.963674	\N
2879	Centro de Acolhida - Santo Amaro	Rua Carmo do Rio Verde, 553	-23.640102	-46.716554	0	2014-12-07 16:16:32.974072	\N
2880	Serviço de Acolhimento Institucional - Santo Amaro	RUA FRANCISCO DE MORAIS, 134 - CHÁCARA STO. ANTONIO	-23.636127	-46.696540	0	2014-12-07 16:16:32.984678	\N
2881	Serviço de Acolhimento Institucional - São Miguel	\N	0	0	0	2014-12-07 16:16:32.996232	\N
2882	Serviço de Acolhimento Institucional - Imigrantes	R. Japurá, 234	-23.553231	-46.641682	0	2014-12-07 16:16:33.006352	\N
2883	Centro de Acolhida - Prates II	Rua Prates, 1101 - Bom Retiro	-23.524362	-46.634498	0	2014-12-07 16:16:33.016352	\N
2884	Serviço de Acolhimento Institucional - Sé	\N	0	0	0	2014-12-07 16:16:33.027163	\N
2885	Serviço de Acolhimento Institucional - Autonomia em Foco II	Rua dos Estudantes, 505	-23.555204	-46.630341	0	2014-12-07 16:16:33.037797	\N
2886	Serviço de Acolhimento Institucional - Vila Mariana	\N	0	0	0	2014-12-07 16:16:33.047839	\N
2887	Consultório na Rua - Lapa	\N	0	0	502026.840000000026	2014-12-07 16:16:33.153136	\N
2888	Consultório na Rua - Belém	\N	0	0	502026.840000000026	2014-12-07 16:16:33.163691	\N
2889	Consultório na Rua - Brás	\N	0	0	502026.840000000026	2014-12-07 16:16:33.174505	\N
2890	Consultório na Rua - Mooca	\N	0	0	502026.840000000026	2014-12-07 16:16:33.211864	\N
2891	Consultório na Rua - Pari	\N	0	0	502026.840000000026	2014-12-07 16:16:33.22277	\N
2892	Consultório na Rua - Pinheiros	\N	0	0	502026.840000000026	2014-12-07 16:16:33.233804	\N
2893	Consultório na Rua - Bom Retiro	\N	0	0	502026.840000000026	2014-12-07 16:16:33.243805	\N
2894	Consultório na Rua - República	\N	0	0	412329.419999999984	2014-12-07 16:16:33.253953	\N
2895	Consultório na Rua - República 2	\N	0	0	412329.419999999984	2014-12-07 16:16:33.264994	\N
2896	Consultório na Rua - Santa Cecília	\N	0	0	425919.659999999974	2014-12-07 16:16:33.275192	\N
2897	Consultório na Rua - Santa Cecília 2	\N	0	0	425919.659999999974	2014-12-07 16:16:33.285613	\N
2898	Consultório na Rua - Santa Cecília 3	\N	0	0	425919.659999999974	2014-12-07 16:16:33.29644	\N
2899	Consultório na Rua - Santa Cecília/Barra Funda	\N	0	0	425919.659999999974	2014-12-07 16:16:33.307115	\N
2900	Consultório na Rua - Santa Cecília 4	\N	0	0	425919.659999999974	2014-12-07 16:16:33.31695	\N
2901	Consultório na Rua - Sé	\N	0	0	425919.659999999974	2014-12-07 16:16:33.327935	\N
2902	Consultório na Rua - Sé 2	\N	0	0	425919.659999999974	2014-12-07 16:16:33.33857	\N
2903	Núcleo de Convivência para a população em situação de rua	Rua Siqueira Cardoso, 259, 267 e 277	-23.546223	-46.596457	0	2014-12-07 16:16:33.423646	\N
2904	Construção de monumento em respeito e consideração à população em situação de rua	\N	0	0	0	2014-12-07 16:16:33.434357	\N
2905	Campanhas de mobilização - população em situação de rua	\N	0	0	91603.9499999999971	2014-12-07 16:16:33.45198	\N
2906	Projetos de integração e promoção social e econômica da população em situação de rua	\N	0	0	0	2014-12-07 16:16:33.462836	\N
2907	Vagas PRONATEC para população em situação de rua	\N	0	0	4638.40999999999985	2014-12-07 16:16:33.475376	\N
2908	Unidades habitacionais do Programa Minha Casa Minha Vida para população em situação de rua	\N	0	0	0	2014-12-07 16:16:33.486173	\N
2909	Centro de Referência em Segurança Alimentar e Nutricional - M'Boi Mirim	\N	0	0	0	2014-12-07 16:16:33.591763	\N
2910	Centro de Referência em Segurança Alimentar e Nutricional - Santo Amaro	\N	0	0	0	2014-12-07 16:16:33.602942	\N
2911	Centro de Referência em Segurança Alimentar e Nutricional - São Mateus	\N	0	0	0	2014-12-07 16:16:33.613198	\N
2912	Centro de Referência em Segurança Alimentar e Nutricional - Santana/Tucuruvi	\N	0	0	0	2014-12-07 16:16:33.624408	\N
2913	Centro de Referência em Segurança Alimentar e Nutricional - Vila Maria	R. Sobral Junior. 264 CEP 02130-000	0	0	0	2014-12-07 16:16:33.635299	\N
2914	Polo da Universidade Aberta do Brasil (UAB) Aricanduva/Formosa/Carrão	Rua Sarg. Claudiner Evaristo Dias, 10	-23.580991	-46.525376	0	2014-12-07 16:16:33.698636	\N
2915	Polo da Universidade Aberta do Brasil (UAB) Butantã	Av. Eng. Heitor Antonio Eiras Garcia, 1870	-23.582508	-46.749740	140000	2014-12-07 16:16:33.709186	\N
2916	Polo da Universidade Aberta do Brasil (UAB) Campo Limpo I	Av. Carlos Lacerda, 678	-23.637284	-46.779452	140000	2014-12-07 16:16:33.720837	\N
2917	Polo da Universidade Aberta do Brasil (UAB) Campo Limpo II	Rua Dr. José Augusto Souza e Silva	-23.620642	-46.729472	0	2014-12-07 16:16:33.731468	\N
2918	Polo da Universidade Aberta do Brasil (UAB) Campo Limpo III	Rua Daniel Gran	-23.674836	-46.768908	0	2014-12-07 16:16:33.743038	\N
2919	Polo da Universidade Aberta do Brasil (UAB) Capela do Socorro I	Av. Interlagos, 7350	-23.710714	-46.704053	140000	2014-12-07 16:16:33.75484	\N
2920	Polo da Universidade Aberta do Brasil (UAB) Capela do Socorro II	Rua Maria Moassab Barbour	-23.743371	-46.660703	0	2014-12-07 16:16:33.767498	\N
2921	Polo da Universidade Aberta do Brasil (UAB) Capela do Socorro III	Estrada do Barro Branco	-23.771782	-46.680479	0	2014-12-07 16:16:33.779358	\N
2922	Polo da Universidade Aberta do Brasil (UAB) Cidade Ademar	Estrada do Alvarenga, 3752	-23.704435	-46.643902	140000	2014-12-07 16:16:33.790467	\N
2923	Polo da Universidade Aberta do Brasil (UAB) Cidade Tiradentes	Av. dos Metalúrgicos, 1262	-23.593796	-46.406271	140000	2014-12-07 16:16:33.801222	\N
2924	Polo da Universidade Aberta do Brasil (UAB) Freguesia/Brasilândia I	Rua Aparecida do Taboado	-23.459051	-46.708012	140000	2014-12-07 16:16:33.812565	\N
2925	Polo da Universidade Aberta do Brasil (UAB) Freguesia/Brasilândia II	Av. Deputado Emilio Carlos, 3641	-23.476091	-46.670309	0	2014-12-07 16:16:33.823613	\N
2926	Polo da Universidade Aberta do Brasil (UAB) Guaianases	Av. Flores do Jambeiro	-23.535390	-46.426064	140000	2014-12-07 16:16:33.834758	\N
2927	Polo da Universidade Aberta do Brasil (UAB) Ipiranga I	Rua Barbinos	-23.621837	-46.583576	140000	2014-12-07 16:16:33.845408	\N
2928	Polo da Universidade Aberta do Brasil (UAB) Ipiranga II	Rua Professor Arthur Primavesi	-23.643214	-46.608579	0	2014-12-07 16:16:33.855928	\N
3037	CEI 210	\N	0	0	0	2014-12-07 16:16:35.428279	\N
2929	Polo da Universidade Aberta do Brasil (UAB) Itaim Paulista I	Rua Daniel Muller, 347	-23.513229	-46.390376	140000	2014-12-07 16:16:33.867376	\N
2930	Polo da Universidade Aberta do Brasil (UAB) Itaim Paulista II	Av. Marechal Tito, 3400	-23.513229	-46.390376	140000	2014-12-07 16:16:33.878273	\N
2931	Polo da Universidade Aberta do Brasil (UAB) Itaquera I	Rua Olga Fadel Abarca	-23.572936	-46.502802	140000	2014-12-07 16:16:33.888976	\N
2932	Polo da Universidade Aberta do Brasil (UAB) Itaquera II	Rua Ernesto de Souza Cruz, 2171	-23.572936	-46.502802	0	2014-12-07 16:16:33.900728	\N
2933	Polo da Universidade Aberta do Brasil (UAB) Jaçanã/Tremembé	Rua Antonio Cesar Neto, 105	-23.463684	-46.583304	140000	2014-12-07 16:16:33.911308	\N
2934	Polo da Universidade Aberta do Brasil (UAB) M'Boi Mirim I	Rua João Damasceno	-23.646161	-46.744285	140000	2014-12-07 16:16:33.922726	\N
2935	Polo da Universidade Aberta do Brasil (UAB) M'Boi Mirim II	Av. dos Funcionários Públicos, 369	-23.646161	-46.744285	0	2014-12-07 16:16:33.937299	\N
2936	Polo da Universidade Aberta do Brasil (UAB) Parelheiros	Rua José Pedro de Borba, 20	-23.827517	-46.726265	0	2014-12-07 16:16:33.948088	\N
2937	Polo da Universidade Aberta do Brasil (UAB) Penha I	Av. Luiz Imparato, 564	-23.498787	-46.496634	140000	2014-12-07 16:16:33.96153	\N
2938	Polo da Universidade Aberta do Brasil (UAB) Penha II	Av. Condessa Elizabeth Robiano x Rua Kampala, 270	-23.498787	-46.496634	0	2014-12-07 16:16:33.976284	\N
2939	Polo da Universidade Aberta do Brasil (UAB) Perus	Rua Bernardo José de Lorena	-23.406258	-46.750984	0	2014-12-07 16:16:33.98868	\N
2940	Polo da Universidade Aberta do Brasil (UAB) Pirituba I	Rua Pera Marmelo, 226	-23.436967	-46.750762	140000	2014-12-07 16:16:33.999462	\N
2941	Polo da Universidade Aberta do Brasil (UAB) Pirituba II	Rua Cel. José Venâncio Dias, 840	-23.481966	-46.762724	140000	2014-12-07 16:16:34.009762	\N
2942	Polo da Universidade Aberta do Brasil (UAB) São Mateus I	Rua Clara Petrela	-23.621536	-46.501188	140000	2014-12-07 16:16:34.02084	\N
2943	Polo da Universidade Aberta do Brasil (UAB) São Mateus II	Rua Cinira Polônio, 100 Conjunto Promorar Rio Claro	0	0	0	2014-12-07 16:16:34.031258	\N
2944	Polo da Universidade Aberta do Brasil (UAB) São Mateus III	Rua Curumatim, 201	-23.602036	-46.449971	0	2014-12-07 16:16:34.042701	\N
2945	Polo da Universidade Aberta do Brasil (UAB) São Miguel	Rua Clarear, 141	-23.509939	-46.473840	140000	2014-12-07 16:16:34.053872	\N
2946	Vagas para o Programa Mais Educação por quadrimestre	\N	0	0	\N	2014-12-07 16:16:34.178181	\N
2947	Estoque de vagas  do Programa Mais Educação	\N	0	0	\N	2014-12-07 16:16:34.189024	\N
2948	CEU CE Padre Jose de Anchieta	Jose Balangio,188(r)xRaul Valenc	-23.55105	-46.48560	26338.4199999999983	2014-12-07 16:16:34.249884	\N
2949	CEU CE Tatuapé/Carrão (Brig Eduardo Gomes)	Monte Serrat, 230 (r)	-23.53990	-46.56227	26338.4199999999983	2014-12-07 16:16:34.261702	\N
2950	CEU Parque Novo Mundo	Ernesto Augusto Lopes,100 (r)	-23.52016	-46.57597	0	2014-12-07 16:16:34.27284	\N
2951	CEU CE Parque do Carmo (Rumi Ranier)	Av. Afonso Sampaio e Souza, 2001	-23.57519	-46.47700	26338.4199999999983	2014-12-07 16:16:34.284224	\N
2952	CEU CE Freguesia O (Aurelio Campos)	Jacutiba, 167 (r)	-23.48351	-46.69348	26338.4199999999983	2014-12-07 16:16:34.294801	\N
2953	CEU CE V Alpina (Arthur Friedenreich)	Francisco Falconi, 83 (av)	-23.58373	-46.56851	26338.4199999999983	2014-12-07 16:16:34.305748	\N
2954	CEU CE Guaianases (Gerdy Gomes)	Prof Lucila Cerqueira,194(r)	-23.54861	-46.42797	26338.4199999999983	2014-12-07 16:16:34.317512	\N
2955	CEU CE Sao Miguel (CDC Tide Setubal)	Rua Mario Dallari, 170	-23.49885	-46.42947	26338.4199999999983	2014-12-07 16:16:34.328012	\N
2956	CEU Heliópolis	Estrada das Lágrimas, 2385	-23.62250	-46.59160	13726270.1300000008	2014-12-07 16:16:34.338728	\N
2957	CEU CE Santo Amaro (Joerg Bruder)	Pde Jose Maria, 555 (av)	-23.65435	-46.70978	26338.4199999999983	2014-12-07 16:16:34.351001	\N
2958	CEU Sapopemba	Rua Pedro de Castro Velho, nº 87	-23.58799	-46.51631	0	2014-12-07 16:16:34.362926	\N
2959	CEU Campo Limpo	Ruas Lira Cearense e Nossa Senhora do Bom Conselho	-23.645382	-46.758029	0	2014-12-07 16:16:34.37488	\N
2960	CEU Grajaú/Petronita	Av. Antonio Carlos Benjamim dos Santos, 1675	-23.754601	-46.698148	0	2014-12-07 16:16:34.386456	\N
2961	CEU Pinheirinho D'água	Rua Camilo Zanotti, s/nº	-23.438555	-46.731817	0	2014-12-07 16:16:34.396901	\N
2962	CEU Tremembé/Jardim Joamar (Casa da pedra)	Rua Adauto Bezerra Delgado, 94	-23.449771	-46.596727	0	2014-12-07 16:16:34.408947	\N
2963	CEU Cidade Tiradentes	Rua Salvador Vigano, nº 100	-23.587024	-46.390974	0	2014-12-07 16:16:34.420725	\N
2964	CEU Taipas	Rua João Amado Coutinho, s/nº	-23.448016	-46.715044	0	2014-12-07 16:16:34.433354	\N
2965	CEU Parque Raposo Tavares	Rua Telmo Coelho Filho, 200 	-23.587951	-46.756076	0	2014-12-07 16:16:34.445671	\N
2966	CEU Vila Matilde	Rua Lupinópolis s/nº	-23.551292	-46.513883	0	2014-12-07 16:16:34.456896	\N
2967	CEU Água Branca	Av. Marquês de São Vicente X Av. Nicolas Boer	-23.517942	-46.681245	0	2014-12-07 16:16:34.478605	\N
2968	Vagas para Educação Infantil (CEI/EMEI)	\N	0	0	0	2014-12-07 16:16:34.491379	\N
2969	CEMEI Setor 8505 - Distrito  Vila Formosa - SIMEC 016	Rua Manoel Ferreira Pires (Plano A)	-23.578924	-46.525169	0	2014-12-07 16:16:34.613282	\N
2970	CEI Setor 5404 - Distrito Morumbi - SIMEC 005	Rua Barão de Castro Lima (Real Parque) (Plano A)	-23.607476	-46.703482	0	2014-12-07 16:16:34.624923	\N
2971	CEI Setor 6501 - Distrito Raposo Tavares - SIMEC 006	Rua Joaquim Guimaraes,594 (Plano B)	-23.590199	-46.803449	0	2014-12-07 16:16:34.635828	\N
2972	CEI Setor 6505 - Distrito Raposo Tavares - SIMEC  060	Rua Paolo Agostini x Av Marginal	-23.591062	-46.795929	0	2014-12-07 16:16:34.647833	\N
2973	CEI Setor 6702 - Distrito Rio Pequeno - SIMEC 003	Rua Antonio Ramiro da Silva prox. Rua Guarumatuba (Plano C)	-23.580067	-46.773717	0	2014-12-07 16:16:34.659308	\N
2974	CEI Setor 6703 - Distrito Rio Pequeno - SIMEC 001	Av. Mauro Marques x Rua Joao Jose Gomes\n(Plano A	-23.580919	-46.768250	0	2014-12-07 16:16:34.671048	\N
2975	CEI Setor 6704 - Distrito Rio Pequeno - SIMEC 007	Rua Abílio Barbosa Lima X Rua Carivaldina Barbosa Lima e Rua João Plácido Viana  (Plano B)	-23.578912	-46.760797	0	2014-12-07 16:16:34.682487	\N
2976	CEI setor 9401 (Jardim Jaqueline) - VILA SONIA	Rua Bonifacio Veronese x Rua Edvard Camilo	-23.597083	-46.750710	0	2014-12-07 16:16:34.693693	\N
2977	CEI Setor 9403 - Distrito V Sonia - SIMEC 004	Rua Santo Américo e  Rua Dona Vitu Giorgi (Plano E)	-23.605497	-46.726387	0	2014-12-07 16:16:34.705179	\N
2978	CEI Setor 9404 - Distrito Vila Sonia - SIMEC 002	Rua Dr. Martins de Oliveira	-23.607652	-46.740390	0	2014-12-07 16:16:34.715734	\N
2979	CEI - Chacara Jockey - VILA SONIA	R. Santa Eufrásia - Prox. R. Santa Crescencia	-23.597310	-46.745268	0	2014-12-07 16:16:34.726943	\N
2980	CEI - CAMPO LIMPO IV	Rua João Bernardo Vieira, altura do nº 300 (entrada pela Rua Antonio Antunes)	-23.63833	-46.77170	4804043.38999999966	2014-12-07 16:16:34.738319	\N
2981	CEI Setor 1701 - Distrito Campo Limpo - SIMEC 025	Rua Eusebio de Matos	-23.631037	-46.768363	0	2014-12-07 16:16:34.749119	\N
2982	CEI Setor 1702 - Distrito  Campo Limpo - SIMEC 023	Estrada dos Mirandas ao lado do nº 342 ou em frente ao nº 782	-23.616865	-46.753426	0	2014-12-07 16:16:34.760399	\N
2983	CEI Setor 1702 II - Distrito Campo Limpo - SIMEC 044	Estrada do Campo Limpo, 5965 (Plano A)	-23.615527	-46.756685	0	2014-12-07 16:16:34.772568	\N
2984	CEI Setor 1702 III - Distrito Campo Limpo - SIMEC 039	Rua Chapada de Minas (Plano C)	-23.627427	-46.745670	0	2014-12-07 16:16:34.7847	\N
2985	CEI Setor 1703 - Distrito Campo Limpo - SIMEC 010	Rua Alexandre Bening,  x Rua Clisa x Rua Carlos de Magalhães (Plano B) 	-23.630733	-46.748695	0	2014-12-07 16:16:34.796586	\N
2986	CEI Setor 1703 IV - Distrito Campo Limpo - SIMEC 038	Rua Carlos Leite dos Santos	-23.643485	-46.749509	0	2014-12-07 16:16:34.807831	\N
2987	CEI Setor 1706 II - Distrito  Campo Limpo - SIMEC 011	Rua Domingos Sequeira x Rua Jorge Afonso (PlanoB)	-23.645944	-46.782285	0	2014-12-07 16:16:34.822945	\N
2988	CEI - Distrito Campo Limpo Setor 1703-5	Rua Carajuva 38M e Rua Clodomiro de Oliveira 37M	-23.629684	-46.748705	0	2014-12-07 16:16:34.834188	\N
2989	CEI - Distrito Campo Limpo Setor 1704-2	Rua Forte da Barra x Rua Nossa Senhora do Bom Conselho- PLANO B	-23.608564	-46.590487	0	2014-12-07 16:16:34.845256	\N
2990	CEI - Distrito Campo Limpo Setor 1706-3	Rua Cabeceira de Bastos -Jd.Mitsutani	-23.650122	-46.781254	0	2014-12-07 16:16:34.859591	\N
2991	CEI - JARDIM MARIA SAMPAIO - CAMPO LIMPO	Av. Augusto Barbosa Tavares	-23.641653	-46.784959	4832513.44000000041	2014-12-07 16:16:34.871504	\N
2992	CEI - Capao Redondo I	Rua Arroio Tipiaia X Rua Arroio das Caneleiras	-23.66133	-46.77467	4872037.11000000034	2014-12-07 16:16:34.883221	\N
2993	CEI - Capao Redondo II	Rua Com. Sant'Anna, 745	-23.673586	-46.773450	0	2014-12-07 16:16:34.894517	\N
2994	CEI Setor 1906 - Distrito Capão Redondo - SIMEC 036	Estrada de Itapecerica x Rua Abietáceas\n(Plano C)	-23.677931	-46.794792	0	2014-12-07 16:16:34.90587	\N
2995	CEI Setor 1907 II - Distrito Capão Redondo - SIMEC 034	Rua Ciclades x  Nogueira do Cravo x Rua Luar do Sertão (Plano A)	-23.694229	-46.794324	0	2014-12-07 16:16:34.91744	\N
2996	CEI - Maria Sampaio - CAPAO REDONDO	Rua Mouquim 	-23.652520	-46.786299	73788.6300000000047	2014-12-07 16:16:34.928294	\N
2997	CEI - PARQUE RONDOM - CAPAO REDONDO	Rua da Moenda X Rua Nicolo de Pietro (Rua Juliano Aguirre e Rua Jose Tartini)	-23.683225	-46.795767	73788.6300000000047	2014-12-07 16:16:34.940505	\N
2998	CEI Setor 8302 - Distrito V. Andrade - SIMEC 026	Rua Irapará (Plano B)	-23.622759	-46.725212	0	2014-12-07 16:16:34.952012	\N
2999	CEI - Distrito Vila Andrade Setor 8301	Rua Dr. Luiz Migliano COM Rua Antonio Garcia Moya	-23.618089	-46.744142	0	2014-12-07 16:16:34.96341	\N
3000	CEI Setor 2304 - Distrito Cidade Dutra - SIMEC 049	Rua Nova Irlanda (próximo à Rua Forte Nelson)	-23.722142	-46.685409	0	2014-12-07 16:16:34.97515	\N
3001	CEI setor 2306 - CIDADE DUTRA	Rua Alice de Souza Lima	-23.723561	-46.696800	117539.309999999998	2014-12-07 16:16:34.986306	\N
3002	CEI Setor 2307 - Distrito Cidade Dutra - SIMEC 062	Rua Frederico René de Jaegher, 1631	-23.725397	-46.711637	0	2014-12-07 16:16:34.997542	\N
3003	CEMEI Setor 2308 - Distrito Cidade Dutra - SIMEC 015	Rua Orfeo Paravente x Rua Royan (Plano A)	-23.735345	-46.717648	0	2014-12-07 16:16:35.009004	\N
3004	CEI PARQUE NOVO GRAJAU (Setor 3003) - GRAJAU	Rua Cornelio Doper X Av. Ema Livry	-23.75425	-46.69486	6316426.20000000019	2014-12-07 16:16:35.020256	\N
3005	CEI Setor 3001 - Distrito Grajau  - SIMEC 070	Rua Joaquim Napoleao Machado, 2000	-23.731252	-46.674163	0	2014-12-07 16:16:35.032388	\N
3006	CEI Setor 3002 - Distrito Grajaú - SIMEC 046	Rua Pastoral X  Av. Dr. Abrãao Ribeiro e Rua João Mayer (Plano A)	-23.751168	-46.692703	0	2014-12-07 16:16:35.043817	\N
3007	CEI setor 3003 - Distrito Grajaú	Rua Doutor Armando Fajardo	-23.756846	-46.703958	0	2014-12-07 16:16:35.055277	\N
3008	CEI Setor 3004 - Distrito Grajau - SIMEC 066	Rua Constelaçao de Andromeda	-23.770808	-46.709108	0	2014-12-07 16:16:35.067418	\N
3009	CEI Setor 3005 - Distrito Grajau - SIMEC  076	Rua Major Lucio Dias Ramos (Plano A)	-23.767496	-46.688216	0	2014-12-07 16:16:35.078327	\N
3010	CEI setor 3005 II - Distrito Grajaú	Av. Carlos Bastos M. x Rua U. S. Goes	-23.767601	-46.693987	0	2014-12-07 16:16:35.08987	\N
3011	CEI setor 3006 - GRAJAU	Rua José Diogo Abadiano X Rua Adelina Abranches	-23.773605	-46.682428	0	2014-12-07 16:16:35.101814	\N
3012	CEI Setor 3006 II - Distrito Grajaú - SIMEC 037	Rua Tres Coracoes	-23.773876	-46.676369	0	2014-12-07 16:16:35.112899	\N
3013	CEI Setor 3006 III - Distrito Grajaú - SIMEC  058	Rua Professor Marques de Oliveira Junior	-23.770470	-46.684493	0	2014-12-07 16:16:35.125095	\N
3014	CEI Setor 3008 - Distrito Grajaú - SIMEC 057	Rua Cidade do Cabo proximo a Estrada do Barro Branco (Estrada do Jequirituba)	-23.764702	-46.671344	0	2014-12-07 16:16:35.136442	\N
3015	CEI setor 3008 - GRAJAU	Rua Filodemo	-23.762624	-46.675215	0	2014-12-07 16:16:35.147799	\N
3016	CEI setor 3008 II - Distrito Grajaú	Rua Cel. Pacifico Furtado (Plano B)	-23.767504	-46.677851	104514.740000000005	2014-12-07 16:16:35.160133	\N
3017	CEI Setor 3010 - Distrito Grajaú - SIMEC 048	Av. Dona Belmira Marin (Plano A)	-23.754430	-46.673836	0	2014-12-07 16:16:35.171945	\N
3018	CEI Setor 3012 - Distrito Grajaú - SIMEC 032	Rua Genaro Napoli x Rua Sebastião Nasolini (Plano D)	-23.744219	-46.669249	0	2014-12-07 16:16:35.183868	\N
3019	CEI Setor 3013 - Distrito Grajau - SIMEC 065	Rua Charles Rosen x Est. Da Canal da Cocaia	-23.735847	-46.665631	0	2014-12-07 16:16:35.195286	\N
3020	CEI Setor 3014 - Distrito do Grajaú - SIMEC 013	Rua Antonio Burlini (Plano C)	-23.775967	-46.705100	0	2014-12-07 16:16:35.206563	\N
3021	CEI Setor 3015 - Distrito Grajaú - SIMEC 061	Rua Joao Honorio Caixeta x Rua Henrique Muzzio	-23.781284	-46.680316	0	2014-12-07 16:16:35.218222	\N
3022	CEI/EMEI setor 3016 - Distrito Grajaú	Rua Jose Humberto Bronca	-23.820907	-46.677128	0	2014-12-07 16:16:35.229926	\N
3023	CEI - IV Centenário	Rua Rubens Montanaro de Borba	-23.712410	-46.692229	0	2014-12-07 16:16:35.241816	\N
3024	CEI Setor 1302 - Distrito Cachoeirinha - SIMEC 079	Rua Min. Lins de Barros x Rua Gervasio Leite Rebelo x Rua Serrana Fluminense (Plano D )	-23.458026	-46.667939	0	2014-12-07 16:16:35.25371	\N
3025	CEI setor 1302 - CACHOEIRINHA	Rua Joaquim Prudêncio	-23.457126	-46.671404	0	2014-12-07 16:16:35.264623	\N
3026	CEI setor 2101 - CASA VERDE	R. Cesar Pena Ramosx R. Joaquim Afonso de  Souza 	-23.490840	-46.662965	0	2014-12-07 16:16:35.276144	\N
3027	CEI setor 2203 - CIDADE ADEMAR	Rua Tuffi Mattar, próximo a Rua Angelo Dedivites e Rua Carlos Facchinna	-23.681829	-46.650686	180775.920000000013	2014-12-07 16:16:35.288408	\N
3028	CEI setor 2204 - CIDADE ADEMAR	Rua Bastos Tigre	-23.684225	-46.662311	106200	2014-12-07 16:16:35.299822	\N
3029	CEI setor 2205 - CIDADE ADEMAR	Rua Marta Brunet X Rua Lorenzo Marilins	-23.686330	-46.635478	0	2014-12-07 16:16:35.313009	\N
3030	CEI Setor 5802 - Distrito Pedreira - SIMEC 027	Rua Monsenhor José Marinoni (Plano E)	-23.692750	-46.647568	0	2014-12-07 16:16:35.328875	\N
3031	CEMEI Setor 5805 - Distrito  Pedreira - SIMEC 022	Rua Albino Bento (Plano A1)	-23.704647	-46.647067	0	2014-12-07 16:16:35.341805	\N
3032	CEI setor 2504 - CIDADE TIRADENTES	Rua Edson Danillo Dotto	-23.593035	-46.413076	4643490.08000000007	2014-12-07 16:16:35.356818	\N
3033	CEI Setor 2506 - Distrito de Cidade Tiradentes - SIMEC 012	Rua Moises de Corena  X Rua Domênico Allegre (Q 36G Lote 10) (Plano A)	-23.593266	-46.396266	0	2014-12-07 16:16:35.371017	\N
3034	CEI - Conjunto Habitacional Santa Etelvina VI - CIDADE TIRADENTES	Av. dos Texteis - Lote 7 Quad 41G	-23.58313	-46.40923	2946604.20999999996	2014-12-07 16:16:35.385423	\N
3035	CEI setor 2508 - Cidade Tiradentes	Av. Paulo Gracindo x Estrada do Iguatemi	-23.566554	-46.417108	0	2014-12-07 16:16:35.399078	\N
3038	CEI 211	\N	0	0	0	2014-12-07 16:16:35.439954	\N
3039	CEI 212	\N	0	0	0	2014-12-07 16:16:35.452408	\N
3040	CEI 213	\N	0	0	0	2014-12-07 16:16:35.465025	\N
3041	CEI 214	\N	0	0	0	2014-12-07 16:16:35.477297	\N
3042	CEI 215	\N	0	0	0	2014-12-07 16:16:35.489594	\N
3043	CEI 216	\N	0	0	0	2014-12-07 16:16:35.500808	\N
3044	CEI 217	\N	0	0	0	2014-12-07 16:16:35.51334	\N
3045	CEI 218	\N	0	0	0	2014-12-07 16:16:35.525532	\N
3046	CEI 219	\N	0	0	0	2014-12-07 16:16:35.536926	\N
3047	CEI 220	\N	0	0	0	2014-12-07 16:16:35.550482	\N
3048	CEI 221	\N	0	0	0	2014-12-07 16:16:35.564285	\N
3049	CEI 222	\N	0	0	0	2014-12-07 16:16:35.577425	\N
3050	CEI 223	\N	0	0	0	2014-12-07 16:16:35.592713	\N
3051	CEI 224	\N	0	0	0	2014-12-07 16:16:35.605841	\N
3052	CEI 225	\N	0	0	0	2014-12-07 16:16:35.617133	\N
3053	CEI 226	\N	0	0	0	2014-12-07 16:16:35.628637	\N
3054	CEI 227	\N	0	0	0	2014-12-07 16:16:35.641409	\N
3055	CEI 228	\N	0	0	0	2014-12-07 16:16:35.652913	\N
3056	CEI 229	\N	0	0	0	2014-12-07 16:16:35.666479	\N
3057	CEI 230	\N	0	0	0	2014-12-07 16:16:35.678162	\N
3058	CEI 231	\N	0	0	0	2014-12-07 16:16:35.689913	\N
3059	CEI 232	\N	0	0	0	2014-12-07 16:16:35.702579	\N
3060	CEI 233	\N	0	0	0	2014-12-07 16:16:35.714542	\N
3061	CEI 234	\N	0	0	0	2014-12-07 16:16:35.727284	\N
3062	CEI 235	\N	0	0	0	2014-12-07 16:16:35.740322	\N
3063	CEI 236	\N	0	0	0	2014-12-07 16:16:35.753257	\N
3064	CEI 237	\N	0	0	0	2014-12-07 16:16:35.769085	\N
3065	CEI 238	\N	0	0	0	2014-12-07 16:16:35.78771	\N
3066	CEI 239	\N	0	0	0	2014-12-07 16:16:35.800129	\N
3067	CEI 240	\N	0	0	0	2014-12-07 16:16:35.813148	\N
3068	CEI 241	\N	0	0	0	2014-12-07 16:16:35.825169	\N
3069	CEI 242	\N	0	0	0	2014-12-07 16:16:35.836695	\N
3070	CEI 243	\N	0	0	0	2014-12-07 16:16:35.849848	\N
3071	CEI setor 2802 - ERMELINO MATARAZZO	Rua Venceslau Guimaraes, 05 (EE Jornalista Francisco Mesquita)	-23.489366	-46.494052	5183486.09999999963	2014-12-07 16:16:35.862763	\N
3072	CEI - Alfazemas I - PONTE RASA	Rua Itapipinas, 610	-23.52548	-46.48642	0	2014-12-07 16:16:35.87619	\N
3073	CEI Setor 6402 - Distrito  Ponte Rasa - SIMEC 014	Rua Nelson Faria Mendes X Rua Vera Cruz de Minas	-23.515229	-46.494514	0	2014-12-07 16:16:35.890681	\N
3074	CEI setor 1104 (Av. Gen. Penha Brasil) - BRASILANDIA	Av. Gen. Penha Brasil (próximo a Rua Aratum)	-23.449641	-46.681212	164372.25	2014-12-07 16:16:35.903678	\N
3075	CEI setor 1105 BRASILANDIA	R. Santa Cruz da Conceição x R. Itambé do Mato Dentro x R. Júlio de Moura Lacerda x R. José da Costa Pereira (Plano B)	-23.460719	-46.686846	98682.4799999999959	2014-12-07 16:16:35.916217	\N
3076	CEI Setor 1106 II - Distrito Brasilândia - SIMEC 059	Rua Domingos Delgado	-23.466822	-46.676463	0	2014-12-07 16:16:35.928989	\N
3077	CEI - JARDIM DAMASCENO II	Eliseu Reinaldo Moraes Vieira, 296	-23.445990	-46.703651	1133268.37999999989	2014-12-07 16:16:35.942299	\N
3078	CEI setor 2901 - FREGUESIA DO O	Estrada do Sabão (Próximo á Rua Amanituba)	-23.475422	-46.698760	84092.4499999999971	2014-12-07 16:16:35.954319	\N
3079	CEI - Jardim Monte Alegre - FREGUESIA DO O	Antônio Genelle, 175	-23.475831	-46.702619	2882784.4700000002	2014-12-07 16:16:35.967778	\N
3080	CEMEI Setor 9608 (Jambeiro) - Distrito do Lajeado - SIMEC 019	Av. José Pinheiro Borges (Plano A1)	-23.525276	-46.436296	0	2014-12-07 16:16:35.980424	\N
3081	José Pereira da Cruz CDHU Sitio Caraguata - SACOMA	Rua Jose Pereira da Cruz X Rua com Giacomo Cozzarelli (CDHU SITIO CARAGUATA)	-23.654060	-46.602503	14021.75	2014-12-07 16:16:35.994196	\N
3082	CEI Setor 6801 IV - Distrito Sacomã	Av. Almirante Delamare	-23.608287	-46.590817	79077.429999999993	2014-12-07 16:16:36.006402	\N
3083	CEI Setor 6801 II - Distrito Sacoma - SIMEC 072	Rua Leandro de Souza x Rua Tito Olliani (Plano B)	-23.627950	-46.593894	0	2014-12-07 16:16:36.020703	\N
3084	CEI setor 6801 III - Distrito Sacomã	Rua Aurantina	-23.613044	-46.599363	0	2014-12-07 16:16:36.033959	\N
3085	CEI setor 6802 II - Distrito Sacomã	Av. dos Pedrosos- Plano B	-23.644144	-46.610421	0	2014-12-07 16:16:36.05015	\N
3086	CEI Setor 6803 - Distrito Sacoma - SIMEC 078	Rua Manuel Salgado (Plano B)	-23.642289	-46.601527	0	2014-12-07 16:16:36.06492	\N
3087	CEI Setor 6803 - Distrito Sacoma - SIMEC 085	Rua dos Cariris Novos x Rua Joao Jose da Silva	-23.649219	-46.602387	0	2014-12-07 16:16:36.079356	\N
3088	CEI setor 6803 II - Distrito Sacomã	Rua Aurelio Afieri, proximo a Rua Aquiles Jovane, Av. Ourives (Plano B)	-23.655216	-46.608577	0	2014-12-07 16:16:36.093701	\N
3089	CEI - Distrito Sacoma Setor 6802-3	Rua Kurt Engelhart x Rua Judite Anderson	-23.634518	-46.601009	0	2014-12-07 16:16:36.110337	\N
3090	CEI - Distrito Sacoma Setor 6802-4	Pça Henry Laurens esquina com Rua Dom Villares	-23.622432	-46.601827	0	2014-12-07 16:16:36.128817	\N
3091	CEI - Novo Cruzeiro - VILA CURUÇA	Rua Novo Cruzeiro	-23.527661	-46.406395	5516159.25999999978	2014-12-07 16:16:36.14217	\N
3092	CEI Setor 3610 II - Distrito Itaim Paulista - SIMEC 047	Rua Paulo Tapajos, 210	-23.50365	-46.37335	0	2014-12-07 16:16:36.155875	\N
3093	CEI Setor 3610 - Distrito Itaim Paulista - SIMEC 063	Rua Manuel Rodrigues Santiago	-23.516731	-46.384288	0	2014-12-07 16:16:36.169466	\N
3094	C.H. São Miguel D/E-Rua Oito - ITAIM PAULISTA	Rua 8 Conjunto Habitacional Sao Miguel D/E - Encosta Norte (Rua Barão De Almeida Galeão X Rua Des. Breno Caramuru Teixeira)	-23.505594	-46.372454	1329563.10000000009	2014-12-07 16:16:36.183892	\N
3095	CEI - Jardim Miriam I - ITAIM PAULISTA	Rua Antonio Joao de Medeiros	-23.511028	-46.397271	58886.510000000002	2014-12-07 16:16:36.199348	\N
3096	CEI Setor 8403 - Distrito  Vila Curuçá - SIMEC 040	Rua Jorge Jones	-23.505895	-46.420738	0	2014-12-07 16:16:36.21278	\N
3097	CEI Setor 8408 - Distrito V. Curuçá - SIMEC 053	Rua Orminda Pinto X Rua Ocidente	-23.525778	-46.403452	0	2014-12-07 16:16:36.225221	\N
3098	CEI 206	\N	0	0	0	2014-12-07 16:16:36.238279	\N
3099	CEI 207	\N	0	0	0	2014-12-07 16:16:36.251181	\N
3100	CEI Setor 2403 - Distrito Cidade Líder - SIMEC 043	R. Jacinto Ferreira (Plano A)	-23.563619	-46.480343	0	2014-12-07 16:16:36.265124	\N
3101	CEI Setor 2406 - Distrito Cidade Líder - SIMEC 017	 Rua Antonio Lombardo X Rua Meridionais X Rua Nova Conquista (Plano B)	-23.573475	-46.500319	0	2014-12-07 16:16:36.27813	\N
3102	CEI - Jardim Ipanema I	Rua Alfredo de Vasconcelos, 86	-23.56023	-46.50794	1323104.45999999996	2014-12-07 16:16:36.290347	\N
3103	CEI Setor 3703 - Distrito Itaquera - SIMEC 067	Rua Desemboque X Rua Sabado D'Angelo X Av. Jacu Pessego (Nova Trabalhadores)	0	0	0	2014-12-07 16:16:36.30362	\N
3104	CEI Setor 3705 - Distrito Itaquera - SIMEC 068	Av.Pires do Riox Tv.Califa de Bagda	-23.528265	-46.448627	0	2014-12-07 16:16:36.316881	\N
3105	CEI Setor 4703 - Distrito José Bonifácio - SIMEC 052	Rua Jd Tamoio X Rua Domingos Rubino	-23.553546	-46.432345	0	2014-12-07 16:16:36.330545	\N
3106	CEMEI José Bonifácio - Distrito Itaquera - SIMEC 099	Rua Ana Perena, 110 - COHAB 2	-23.547438	-46.436400	0	2014-12-07 16:16:36.344173	\N
3107	CEI Setor 5702 - Distrito  Parque do Carmo - SIMEC 056	Rua Blecaute x Rua Jardel Filho x Rua Kleber Afonso (Plano A)	-23.567426	-46.461822	0	2014-12-07 16:16:36.359626	\N
3108	CEI setor 3706 - ITAQUERA	Rua Raça Humana X Rua Lembrança do Futuro	-23.521244	-46.468816	0	2014-12-07 16:16:36.376008	\N
3109	CEI setor 3806  - JABAQUARA	Rua João Xavier de Matos X Rua das Vitaceas	-23.668574	-46.639678	38200	2014-12-07 16:16:36.388821	\N
3110	CEI setor 3806 II - JABAQUARA	Avenida Euclides	-23.657121	-46.635271	0	2014-12-07 16:16:36.401259	\N
3111	Distrito Jabaquara Setor 3803	Rua Anita Costa X Rua Nelson Fernandes	-23.647153	-46.638725	0	2014-12-07 16:16:36.413599	\N
3112	CEI Setor 3903 - Distrito Jacana - SIMEC  074	Rua Alzira x Rua Dr Azevedo Lima	-23.467850	-46.568092	0	2014-12-07 16:16:36.426497	\N
3113	CEI Setor 8103 - Distrito Tremembe - SIMEC 081	Estrada Corisco frente a Cemitério PQ.da Cantareira 	-23.430229	-46.579915	0	2014-12-07 16:16:36.438509	\N
3114	CEI Setor 8103 - Distrito Tremembe - SIMEC 084	Av Cel. Sezefredo Fagundes 7228 prox a Rua Julião Fagundes	-23.427104	-46.593288	0	2014-12-07 16:16:36.452472	\N
3115	CEI setor 8103 - TREMEMBE	Rua Kotinda X Rua Cachoeira	-23.430098	-46.584300	0	2014-12-07 16:16:36.466049	\N
3116	CEI Setor 8104 - Distrito Tremembe - SIMEC 080	R. Augusto Rodrigues, em frente ao num. 682	-23.434485	-46.578319	0	2014-12-07 16:16:36.480778	\N
3117	CEI setor 8104 - TREMEMBE	Estrada da Cachoeira X Rua Ushikichi Kamiya X Rua Simão de Abreu	-23.438526	-46.585525	0	2014-12-07 16:16:36.49374	\N
3118	CEI Setor 8105 - Distrito Tremembe - SIMEC 083	Travessa Jaime Frazer x Rua Boa Ventura Colleti	-23.443548	-46.588637	0	2014-12-07 16:16:36.507057	\N
3119	CEI setor 8105 - TREMEMBE	R. Ushikichi Kamya x R. Sezefredo Fagundes (Prox R. Nicola Mestrino)	-23.442491	-46.593879	0	2014-12-07 16:16:36.52101	\N
3120	CEI setor 8105 II - TREMEMBE	Rua Avelina Pereira	-23.457607	-46.601418	0	2014-12-07 16:16:36.535673	\N
3121	CEI Setor 8106 - Distrito Tremembe - SIMEC 075	Rua Padre Francisco Amos Connor x Rua Maria Amalia Lopes Azevedo Lima 	-23.458213	-46.612391	0	2014-12-07 16:16:36.552469	\N
3122	CEI Setor 8106 - Distrito Tremembe - SIMEC 082	Rua Vieira de Melo	-23.451645	-46.613833	0	2014-12-07 16:16:36.566139	\N
3123	CEI setor 4301 - JARDIM ANGELA	Rua das Três Marias	-23.699970	-46.788182	25983.1599999999999	2014-12-07 16:16:36.578688	\N
3124	CEI setor 4304 - JARDIM ANGELA	Estrada Guavirituba, 797	-23.684433	-46.762548	0	2014-12-07 16:16:36.590719	\N
3125	CEI Setor 4304 III - Distrito Jardim Angela - SIMEC 050	Rua Carmelo Cali	-23.691036	-46.765998	0	2014-12-07 16:16:36.60411	\N
3126	CEI Setor 4305 - Distrito Jardim Angela - SIMEC 008	Rua Seringal do Rio Verde em frente ao nº 73	-23.699943	-46.777464	0	2014-12-07 16:16:36.617086	\N
3127	CEI setor 4307 - JARDIM ANGELA	Rua Abutuí (Rua Carlo Caproli)	-23.738825	-46.779696	0	2014-12-07 16:16:36.630972	\N
3128	CEI - Distrito Jardim Angela Setor 4303	Rua Itaparoquera 71 a 83	-23.678128	-46.756886	0	2014-12-07 16:16:36.64412	\N
3129	CEI - Distrito Jardim Angela Setor 4307-2	Estrada do Embu Guaçu , altura do 9.000 x Rua Isabel de Oliveira	-23.724825	-46.785869	0	2014-12-07 16:16:36.658409	\N
3130	CEI - Distrito Jardim Angela Setor 4307-3	Rua Isabel de Oliveira	-23.727719	-46.782147	0	2014-12-07 16:16:36.671795	\N
3131	CEI - Distrito Jardim Angela Setor 4307-4	Rua Rene Castera	-23.749176	-46.777083	0	2014-12-07 16:16:36.68539	\N
3132	CEI - Peratuba - JARDIM ANGELA	Av. Peratuba altura do nº 58 X Av. Caporanga	-23.724254	-46.758858	0	2014-12-07 16:16:36.699102	\N
3133	CEI - Tiquira - JARDIM ANGELA	Estrada M'Boi Mirim, Tiquira, Tijuca	-23.691563	-46.775823	5532439.3200000003	2014-12-07 16:16:36.711924	\N
3134	CEI Setor 4601 - Distrito Jd S. Luis	Rua Gregorio Allegre (Plano B)	-23.650395	-46.745777	0	2014-12-07 16:16:36.725535	\N
3135	CEI Setor 4601 - Distrito Jd S. Luis - SIMEC 009	Rua Jose Geniolli X Rua Gregório Allegri(Plano A)	-23.647023	-46.745890	0	2014-12-07 16:16:36.738043	\N
3136	CEI Setor 4602 II - Distrito Jd São Luis - SIMEC 035	Rua Paulo Lemore x Rua Nova Tuparoquera (Plano C)	-23.661620	-46.740144	0	2014-12-07 16:16:36.752295	\N
3137	CEI Setor 4603 - Distrito Jd São Luis - SIMEC 051	Rua Cornélio Zelaia X Rua da Cordialidade X Rua Arq. Roberto Patrão Assis (Plano A)	-23.657915	-46.744125	0	2014-12-07 16:16:36.768378	\N
3138	CEMEI Setor 4603 - Distrito Jd São Luis - SIMEC 054	R José Manuel de Camisa Nova e Rua Nova do Tuparoquera (Plano A)	-23.664348	-46.748007	0	2014-12-07 16:16:36.782215	\N
3139	CEI Setor 8002 - Distrito  Tatuapé - SIMEC 018	Rua Serra do Botucatu e Rua Serra de Bragança (Plano A)	-23.543354	-46.563155	0	2014-12-07 16:16:36.795595	\N
3140	CEI Setor 5505 - Distrito Parelheiros - SIMEC 069	Rua Orlando Pontes x Rua Saverio de Donato (Plano B )	-23.813152	-46.736405	0	2014-12-07 16:16:36.80969	\N
3141	CEI Setor 5506 - Distrito Parelheiros - SIMEC 071	Rua Domenico Lanzetti x Rua Batista Cirri x Rua Luigi Caruso (Plano B)	-23.819939	-46.704171	0	2014-12-07 16:16:36.822052	\N
3142	CEI setor 5507 - PARELHEIROS	Rua Sebastião da Barra X Rua Nacip Haydan	-23.826857	-46.726898	125534.300000000003	2014-12-07 16:16:36.836396	\N
3143	CEI Setor 0505 - Distrito Arthur Alvim - SIMEC 055	Rua Crateus x Rua Bacabal x Rua Catende	-23.535494	-46.480750	0	2014-12-07 16:16:36.85043	\N
3144	CEI - Conjunto Habitacional Padre Manuel de Paiva - ARTHUR ALVIM	Rua Estefano Filippini, 105	-23.55244	-46.48189	5048429.15000000037	2014-12-07 16:16:36.865139	\N
3145	CEI setor 1802 - CANGAIBA	Rua Maria Angélica Franci X Avenida Cangaíba	-23.505108	-46.510123	299899.450000000012	2014-12-07 16:16:36.879085	\N
3146	CEI setor 1802 II - CANGAIBA	Rua Mutuipe X Rua Riacho da Cruz X Rua Canutama	-23.499598	-46.498798	0	2014-12-07 16:16:36.892985	\N
3147	CEI Setor 1802 III - Distrito Penha	Rua São José do Campestre x Rua Pastorial do Itapetinga	-23.501448	-46.507291	0	2014-12-07 16:16:36.906469	\N
3148	CEI - Vila Silvia I - CANGAIBA	Rua Novo Oriente do Piauí, 170	-23.49447	-46.50669	4.58000000000000007	2014-12-07 16:16:36.920254	\N
3149	CEI setor 9101 - Distrito Vila Matilde	Rua Julio Colaço	-23.538358	-46.542828	0	2014-12-07 16:16:36.93465	\N
3150	CEI setor 9105 - Distrito Vila Matilde	Av. Engenheiro Soares de Camargo, em frente Praça Leonildes Ramos Sayago	-23.539435	-46.504731	0	2014-12-07 16:16:36.948056	\N
3151	CEI Setor 0307 - Distrito Anhanguera - SIMEC 031	Rua Bernardino Bertolotti  X Rua Osório A. Castro 238 (plano D)	-23.448528	-46.788742	0	2014-12-07 16:16:36.962592	\N
3152	CEI Setor 0308 - Distrito  Anhanguera - SIMEC 020	Rua Ricardo Dalton X Rua Pompeo Bertini (em frente à EMEF Paulo Prado)	-23.429969	-46.793785	0	2014-12-07 16:16:36.97527	\N
3153	CEI setor 6102 - PERUS	Rua Alagoa Nova X Rua Estevao Ribeiro Rezende	-23.400325	-46.745535	0	2014-12-07 16:16:36.989819	\N
3154	CEI - Setor 6101 II - PERUS	Rua Roque Callage X Rua Joaquim Xavier Pinheiro	-23.413673	-46.755471	0	2014-12-07 16:16:37.003022	\N
3155	CEI Setor 4208 II	Av. Elisio Teixeira Leite X Rua Monte Azul Paulista	-23.439731	-46.717051	0	2014-12-07 16:16:37.017663	\N
3156	Distrito Perus Setor 6101	Rua Martim Lobo de Saldanha	-23.407312	-46.766642	0	2014-12-07 16:16:37.031229	\N
3157	CEI - JARDIM EDITE	Rua Charles Coulomb, 30	-23.61350	-46.69321	0	2014-12-07 16:16:37.04892	\N
3158	CEI setor 4201 - Distrito Jaraguá	Rua Antonio Cardoso Nogueira	-23.449030	-46.755440	0	2014-12-07 16:16:37.063093	\N
3159	CEI Setor 4203 - Distrito Jaraguá - SIMEC 029	Rua Vasco Balboa X Rua Hipolito Vieites (Plano A)	-23.442457	-46.753217	9265.11000000000058	2014-12-07 16:16:37.081648	\N
3160	CEI setor 4205 II - Distrito Jaraguá	Rua Saverio Valente (Plano B)	-23.441336	-46.737991	0	2014-12-07 16:16:37.096097	\N
3161	CEI Setor 4205 III - Distrito Jaragua - SIMEC 073	Rua Saverio Valente	-23.441336	-46.737991	0	2014-12-07 16:16:37.114589	\N
3162	CEI setor 4205 IV - Distrito Jaraguá	Av. Friedrich Von Voith (Plano B)	-23.447540	-46.736870	0	2014-12-07 16:16:37.128617	\N
3163	CEI Setor 4208 II - Distrito Jaraguá - SIMEC  021	Av. Elisio Teixeira Leite x Rua Monte Azul Paulista (Plano E)	-23.439802	-46.717176	0	2014-12-07 16:16:37.147051	\N
3164	CEI - Ilha da Juventude - JARAGUA	Rua Ilha da Juventude, s/nº	-23.446802	-46.712361	5235055.98000000045	2014-12-07 16:16:37.159908	\N
3165	CEI - Parque das Nacoes - JARAGUA	Parque das Nacoes II - Travessa 3 próximo à Rua James Petersen	-23.437241	-46.739946	0	2014-12-07 16:16:37.177636	\N
3166	CEI - Pirituba - JARAGUA	Avenida Elísio Teixeira Leite, s/nº (área remanescente da EMEF Pirituba III)	-23.46775	-46.70916	4598774.63999999966	2014-12-07 16:16:37.18995	\N
3167	CEI Setor 6304 - Distrito Pirituba - SIMEC  033	Av. Menotti Laudisio x Rua Dendê  (Plano C)	-23.482062	-46.726537	0	2014-12-07 16:16:37.207141	\N
3168	CEI setor 6304 II  - PIRITUBA	Av. Menotti Laudisio X Rua Mathilde Carlos Montesanti X Rua Diatomáceas	-23.482289	-46.724562	0	2014-12-07 16:16:37.220434	\N
3169	CEI - VILA CLARICE - PIRITUBA	Rua Desembargador Joaquim Bandeira Melo, Rua Roberto Boyle, Rua Robert Barany	-23.472121	-46.750007	4201258.55999999959	2014-12-07 16:16:37.23785	\N
3170	CEI - Cidade Azul - JABAQUARA	Av. Rodrigues Montemor, 395	-23.663671	-46.648130	46251.739999999998	2014-12-07 16:16:37.252248	\N
3171	CEI setor 3303 - Distrito Iguatemi	Estrada do Palanque	-23.614512	-46.408881	0	2014-12-07 16:16:37.271297	\N
3172	CEI Setor 3304 - Distrito Iguatemi - SIMEC 024	Rua Arraial do Tijuco x Rua Bernardo Antunes Rolim x Rua Mendes Freire	-23.605374	-46.434563	0	2014-12-07 16:16:37.286171	\N
3173	CEI setor 3304 II - Distrito Iguatemi	Rua Luiza Sarazin	-23.601207	-46.431980	0	2014-12-07 16:16:37.304422	\N
3174	CEI setor 3304 III - Distrito Iguatemi	Rua Gonçalves de Mendonça	-23.598932	-46.438985	0	2014-12-07 16:16:37.319038	\N
3175	CEI setor 3304 IV - Distrito Iguatemi	Av. Bento Guelfi	-23.607011	-46.427329	0	2014-12-07 16:16:37.337235	\N
3176	CEI Setor 3305 - Distrito Iguatemi 086	Rua Bernardo Antunes Rolim x Avenida Bento Guelfi	-23.601246	-46.431980	0	2014-12-07 16:16:37.352472	\N
3177	CEI setor 3306 - Distrito Iguatemi	Rua Aguaricó x Rua Cinquenta e Dois	-23.599392	-46.448841	0	2014-12-07 16:16:37.370691	\N
3178	CEI Setor 3307 - Distrito Iguatemi - SIMEC 045	Rua Sessenta e Seis x Rua Sessenta e Tres	-23.602290	-46.449652	0	2014-12-07 16:16:37.387108	\N
3179	CEI setor 3307 II - Distrito Iguatemi	Rua Sessenta e Três	-23.602454	-46.448985	0	2014-12-07 16:16:37.402747	\N
3180	CEI Setor 7301 - SÃO MATEUS	Av. Mateo Bei X Antonio Previato	-23.598453	-46.485946	0	2014-12-07 16:16:37.422742	\N
3181	CEI Setor 7302 - Distrito São Mateus - SIMEC 077	Rua Andre de Almeida prox.Rua Eduardo Celestino (Plano B)	-23.594843	-46.477895	0	2014-12-07 16:16:37.441187	\N
3182	CEI setor 7305 - Distrito São Mateus	Rua Conego Macario de Almeida  Plano B	-23.613565	-46.479908	0	2014-12-07 16:16:37.46087	\N
3183	CEI setor 7501 - Distrito São Rafael	Rua Aldeia de Santo Inácio x Avenida Paulo Nunes Felix	-23.623330	-46.471941	0	2014-12-07 16:16:37.477936	\N
3184	CEI Setor 7504 - Distrito São Rafael - SIMEC 028	RUA BANDEIRA DO GUAIRA X AV.SAPOPEMBA_PLANO B (SETOR 7503)	-23.623260	-46.470373	0	2014-12-07 16:16:37.495701	\N
3185	CEI setor 7505 II - Distrito São Rafael	KM 28,AV SAPOPEMBA-ESTR RIO CLARO	-23.619462	-46.425062	0	2014-12-07 16:16:37.510118	\N
3186	CEI setor 7505 III - Distrito São Rafael	Rua Lima Bonfante	-23.628214	-46.446267	0	2014-12-07 16:16:37.52716	\N
3187	CEI setor 7505 IV - Distrito São Rafael	Rua Três  x Rua IPATIENS	-23.639734	-46.436229	0	2014-12-07 16:16:37.540473	\N
3188	CEI setor 7508 - Distrito São Rafael	Rua Pedro Medeiros (Plano B)	-23.621461	-46.442236	0	2014-12-07 16:16:37.553961	\N
3189	CEI - Pequeninos do Reino - SÃO RAFAEL	Travessa da Dispersão, 20	-23.63411	-46.45619	1941295.18999999994	2014-12-07 16:16:37.56753	\N
3190	CEI - SETOR 7505 - JARDIM SANTO ANDRÉ I	Rua Miguel Ferreira de Mello	-23.631181	-46.443195	0	2014-12-07 16:16:37.580894	\N
3191	CEI setor 4403 (Rua Muniz Falcão X Rua Dr. Francisco Tancredi) - JARDIM HELENA	R. Muniz Falcão x R. Dr. Francisco Tancredi	-23.487975	-46.426455	0	2014-12-07 16:16:37.595611	\N
3192	CEI setor 4406 - JARDIM HELENA	Rua Miguel de Quadros Marinho X Rua Manajos X Rua Capinharos	-23.482698	-46.385738	0	2014-12-07 16:16:37.609459	\N
3193	CEI - Jardim Helena I - JARDIM HELENA	Avenida Kumaki Aoki, 1145	-23.47925	-46.41845	4750333.88999999966	2014-12-07 16:16:37.624087	\N
3194	CEI - JARDIM LAPENA	Rua Dr. Almiro dos Reis, s/nº	-23.489312	-46.447618	4278743.12999999989	2014-12-07 16:16:37.63867	\N
3195	CEI - JARDIM LAPENA I	Rua Serra da Juruoca, s/nº (AREA DO DAEE)	-23.488267	-46.447946	8640887.4299999997	2014-12-07 16:16:37.654957	\N
3196	CEI - CDHU JACUI A	CDHU Jacui A - área institucional 6 e 7	-23.49888	-46.45010	4559179.3200000003	2014-12-07 16:16:37.702518	\N
3197	CEI Setor 8701 - Distrito V. Jacuí - SIMEC 064	Área institucional CDHU Jacuí A (Rua Seis, próxima a Rua Ventura Branco)	-23.484966	-46.466001	0	2014-12-07 16:16:37.717061	\N
3198	CEI Setor 8703 - Distrito  V. Jacuí - SIMEC 041	Rua Henrique Xavier Brito x Av. São Miguel, 7290	-23.49900	-46.46582	0	2014-12-07 16:16:37.730483	\N
3199	CEI Setor 8707 - Distrito  V. Jacuí - SIMEC 042	Rua Faveira do Mato x Rua Baltazar Santana X Rua José Carlos Mastromonico (Plano A)	-23.508717	-46.445825	0	2014-12-07 16:16:37.745228	\N
3200	CEI Setor 7607 - Distrito Sapopemba - SIMEC 030	Avenida Sapopemba, 11100 (prox. a Rua Ubim)	-23.611290	-46.504017	0	2014-12-07 16:16:37.758635	\N
3201	CEI - Conjunto Habitacional Teotônio Vilela I - SAPOPEMBA	Rua Tomás de Santa Maria, 78	-23.60559	-46.50398	5697358.86000000034	2014-12-07 16:16:37.773464	\N
3202	CEI - Mãe Esperança II - SAPOPEMBA	Rua Jose Gabriel Nunes, 41	-23.59366	-46.50960	5184393.95999999996	2014-12-07 16:16:37.786599	\N
3203	Itaquera B-Fazenda da Juta (CDHU) - Setor 7604	Rua Augustin Liberti X Rua 12	-23.617544	-46.487898	0	2014-12-07 16:16:37.800376	\N
3204	CEI setor 4901 - Distrito Liberdade	Rua Glicério, 598,610 , 624 e 642	-23.656947	-46.524050	0	2014-12-07 16:16:37.815305	\N
3205	CEI setor 4901 II - Distrito Liberdade	RUA SÃO PAULO X AV. PREFEITO PASSOS	-23.556853	-46.626792	0	2014-12-07 16:16:37.831946	\N
3206	CEI - Manuel Dutra - BELA VISTA	Rua Manuel Dutra, 613	-23.555774	-46.648863	0	2014-12-07 16:16:37.846117	\N
3207	CEI setor 7801 II - Distrito Sé	Parque Dom Pedro II	-23.545060	-46.631393	0	2014-12-07 16:16:37.860419	\N
3208	CEI setor 7203 - SÃO LUCAS	Rua Cachoeira Sao Benedito	-23.612736	-46.535807	4778359.45999999996	2014-12-07 16:16:37.874272	\N
3209	Distrito Sé Setor 7801	Rua das Carmelitas X Rua Tabatinguera	-23.552121	-46.629173	0	2014-12-07 16:16:37.887581	\N
3210	Distrito Vila Formosa Setor 8501	Av. Guilherme Giorgi x Rua Baquile	-23.554177	-46.545194	0	2014-12-07 16:16:37.900956	\N
3211	Distrito Parelheiros Setor 5507	Av. Sadamu Inoue X Rua Amaro Alves do Rosario	-23.814706	-46.735167	0	2014-12-07 16:16:37.914245	\N
3212	CEI setor 7201 (Vila Ema)	Rua Antonio Pires de Campos, 98	-23.592226	-46.538817	0	2014-12-07 16:16:37.927948	\N
3213	CEI setor 6801 (Rua Barão do Rio da Prata)	Rua Barão do Rio da Prata	-23.605410	-46.595406	0	2014-12-07 16:16:37.941858	\N
3214	Vagas para Educação Infantil (CEI)	\N	0	0	0	2014-12-07 16:16:37.955961	\N
3215	EMEI - ALDO GIANNINI, ENG. - VILA JACUI	Rua Arraial de Santa Barbara, 1080	-23.503376	-46.471410	4135439.62000000011	2014-12-07 16:16:38.623416	\N
3216	EMEI - ALFAZEMAS - PONTE RASA	Rua Itapipinas, 570	-23.525297	-46.486222	8059007.73000000045	2014-12-07 16:16:38.638896	\N
3217	EMEI - CDHU GUAIANAZES B - JOSE BONIFACIO	Hera Canad X Begonia Real (Estrada Sao Simao)	-23.582064	-46.419788	5834992.98000000045	2014-12-07 16:16:38.656003	\N
3218	EMEI - CDHU ITAIM A - ITAIM PAULISTA	área institucional 1 (Rua Roberto Said x Rua 7)	-23.515123	-46.385386	4356517.70000000019	2014-12-07 16:16:38.67146	\N
3219	EMEI - Estrada do Corredor - JARAGUA	Av. Tres Com Estrada Do Corredor - Quadra C - AI 3 - Conj. Hab. Jaragua A2 - CDHU - antiga escola de latinha Roge Ferreira	-23.446945	-46.731950	4359929.25999999978	2014-12-07 16:16:38.688344	\N
3220	EMEI - GEORGE SAVALLA GOMES - CAREQUINHA - CAPAO REDONDO	Rua Luzia Pinhata Andreatti X Rua Abilio Alves de Souza (antiga Rua JOSE CHURRIGUERRA X D RODRIGO SANC)	-23.661347	-46.781299	4188505.99000000022	2014-12-07 16:16:38.706609	\N
3221	EMEI - ISOLINA LEONEL FERREIRA, PROFA. - SACOMA	Estrada das Lagrimas, 603	-23.606744	-46.598230	5319301.00999999978	2014-12-07 16:16:38.721615	\N
3222	EMEI - JARDIM DOS REIS I - JARDIM ANGELA	Rua do Jararau, 89	-23.703050	-46.791365	2917896.9700000002	2014-12-07 16:16:38.73676	\N
3223	EMEI - JARDIM SANTA TEREZA - BRASILANDIA	Rua Expedito Armando C. de Mello X C. Lamarca (Rua Augusto Cesar Sandino)	-23.460751	-46.681057	4077031.89000000013	2014-12-07 16:16:38.750809	\N
3224	EMEI - PARQUE DAS NACOES II - JARAGUA	Parque das Nacoes II - Travessa 3 próximo à Rua James Petersen	-23.437241	-46.739946	13040615.75	2014-12-07 16:16:38.765864	\N
3225	EMEI - Porto Nacional - BRASILANDIA	Rua Porto Nacional	-23.461855	-46.702917	5068917.09999999963	2014-12-07 16:16:38.779497	\N
3226	EMEI - SETOR 7505 - JARDIM SANTO ANDRÉ	Rua Miguel Ferreira de Mello	-23.631181	-46.443195	18701192.1999999993	2014-12-07 16:16:38.794122	\N
3227	EMEI - VILA CALU - JARDIM ANGELA	Rua Humberto Marcal, SN	-23.738425	-46.793691	5402041.21999999974	2014-12-07 16:16:38.808514	\N
3228	EMEI - VILA NATAL - GRAJAU	Rua Lima Natal, 99	-23.760455	-46.710656	4152878.31000000006	2014-12-07 16:16:38.823041	\N
3229	EMEI setor 1604 (Av. Zike Tuma) - CAMPO GRANDE	Av. Zike Tuma, 419 E 632 - Cooperativa Habitacional da APEOESP - Subsede	-23.689520	-46.672528	6006136.20000000019	2014-12-07 16:16:38.837055	\N
3230	EMEI - Campo Limpo VI - Setor 1701 (Rua Domingos de Goes) - CAMPO LIMPO	Rua Domingos de Goes - CDHU	-23.632438	-46.762588	1833907.77000000002	2014-12-07 16:16:38.850655	\N
3231	EMEI - CAPAO REDONDO III - Setor 1904 (Rua Comendador Sant'Anna) - CAPAO REDONDO	Rua Com. Sant'Anna, 745	-23.673586	-46.773450	8572107.98000000045	2014-12-07 16:16:38.86467	\N
3232	EMEI - FIGUEIRA GRANDE - JARDIM SÃO LUIS	Rua Pedro da Costa Faleiro	-23.680779	-46.746661	1195894.6100000001	2014-12-07 16:16:38.879381	\N
3233	EMEI - JARDIM KAGOHARA - JARDIM ANGELA	Rua Fermatas, 120	-23.689976	-46.760548	1643965.53000000003	2014-12-07 16:16:38.895355	\N
3234	EMEI - PARQUE SANTO ANTONIO - JARDIM SÃO LUIS	Rua Rinaldo de Handel	-23.666590	-46.748823	1572169.85000000009	2014-12-07 16:16:38.912516	\N
3235	EMEI - PERATUBA I (Setor 4309) - JARDIM ANGELA	Av. Peratuba altura do nº 58 X Av. Caporanga	-23.724254	-46.758858	20347052.1900000013	2014-12-07 16:16:38.927959	\N
3236	EMEI setor 2505 (Rua dos Texteis X Rua São Valfredo) - CIDADE TIRADENTES	Rua dos Texteis X Rua São Valfredo	-23.587250	-46.406318	4918703.88999999966	2014-12-07 16:16:38.94599	\N
3237	EMEI - PARQUE BOULOGNE - JARDIM ANGELA	Tijuco da Serra X Antipodas	-23.703385	-46.773111	36835.5400000000009	2014-12-07 16:16:38.962018	\N
3238	EMEI - PERIMETRAL II - VILA ANDRADE	Terreno /Educação 2 (Independencia X Ricardo Avenarius - próximo à Rua Itagotinga)	-23.620316	-46.724609	0	2014-12-07 16:16:38.977959	\N
3239	EMEI setor 1905 (Travessa Passareira) - CAPÃO REDONDO	Travessa Passareira, 200	-23.672171	-46.783933	602843.170000000042	2014-12-07 16:16:38.99497	\N
3240	EMEI setor 1906 (Rua Andorinha dos Beirais) - CAPAO REDONDO	Rua Andorinha dos Beirais - Parque Fernanda/ Quadra 16/ Lote 1Rua Andorinha dos Beirais - Parque Fernanda/ Quadra 16/ Lote 1	-23.675056	-46.795818	34419.3499999999985	2014-12-07 16:16:39.010125	\N
3241	EMEI setor 1302 (Rua Luiz Macário de Castro) - CACHOEIRINHA	R. Afonso Lopes Vieira x R. Luis Macario ( em Substiuição a R. A Afonso L Vieirax Gal Penh Brasil) 	-23.464426	-46.664946	126367.720000000001	2014-12-07 16:16:39.023872	\N
3242	EMEI setor 1706 (Estrada Pirajussara) - CAMPO LIMPO	Estrada Pirajussara- Valo Velho, altura do número 450	-23.602058	-46.748473	36553.8600000000006	2014-12-07 16:16:39.03833	\N
3243	EMEI - CONJ HABITACIONAL JACUÍ A - VILA JACUI	C.H.Jacui A - CDHU - Av. 1 X R. 10 (AI 3)	-23.484760	-46.464795	0	2014-12-07 16:16:39.053293	\N
3244	EMEI - JARDIM DIONISIO - JARDIM ANGELA	Rua William Cremer, sn	-23.685313	-46.768073	0	2014-12-07 16:16:39.068615	\N
3245	CEMEI setor 2309 (Av. Orfeu Paravente X Rua Royan) - CIDADE DUTRA	Av. Orfeu Paravente X Rua Royan -Jardim Kioto	-23.735534	-46.717518	3478295.20000000019	2014-12-07 16:16:39.083975	\N
3246	EMEI - ANA MARCHIONE SALLES, PROFA. - PONTE RASA	Rua Amador Bueno da Veiga X Rua das Folhagens	-23.515396	-46.507562	104985.190000000002	2014-12-07 16:16:39.098019	\N
3247	EMEI - CHACARA JOCKEY - VILA SONIA	R. Santa Eufrásia - Prox. R. Santa Crescencia	-23.597310	-46.745268	0	2014-12-07 16:16:39.111911	\N
3248	EMEI - JARDIM JAQUELINE - VILA SONIA	Rua Bonifacio Veronese x Rua Edvard Camilo	-23.597107	-46.750752	0	2014-12-07 16:16:39.126486	\N
3249	EMEI - PARAISOPOLIS - TERRENO 4 - VILA ANDRADE	Terreno 4/ Educação/ SEHAB - Rua Major Jose Marioto Ferreira X Rua das Goiabeiras	-23.612359	-46.727950	0	2014-12-07 16:16:39.140611	\N
3250	EMEI setor 1702 (Estrada do Campo Limpo) - CAMPO LIMPO	Estrada do Campo Limpo, 5.965	-23.615477	-46.756783	0	2014-12-07 16:16:39.155391	\N
3251	EMEI setor 1907 (Rua das Perobeiras) - CAPAO REDONDO	R. das Perobeiras (Plano A)	-23.689407	-46.797455	35216.1600000000035	2014-12-07 16:16:39.169906	\N
3252	EMEI setor 2203 (Rua São João da Boa Vista X Rua Edith Mason X Rua Maria de Rohan) - CIDADE ADEMAR	Rua São João da Boa Vista X Rua Edith Mason X Rua Maria de Rohan	-23.677920	-46.647580	0	2014-12-07 16:16:39.184437	\N
3253	EMEI setor 2205 (Rua Marta Brunet X Rua Lorenzo Marilins) - CIDADE ADEMAR	R. Marta Brunet x R. Lorenzo Mavilis - Plano B	-23.686371	-46.635438	0	2014-12-07 16:16:39.201122	\N
3254	EMEI setor 2205 II (Rua Angelo Cristianini X Rua Estrela Solitária) - CIDADE ADEMAR	Área 4 - Cidade Ademar (Rua Angelo Cristianini X Rua Estrela Solitária)	-23.687705	-46.642494	0	2014-12-07 16:16:39.21611	\N
3255	EMEI setor 2206 (Rua Padre Antônio de Gouveia) - CIDADE ADEMAR	R. Padre Antônio de Gouveia - PLANO B - proximo Al. Dr Silvio de Campos	-23.678290	-46.639072	212502.619999999995	2014-12-07 16:16:39.232783	\N
3256	EMEI setor 2303 (Rua Marly Oliveira Cobra) - CIDADE DUTRA	Rua Marly Oliveira Cobra	-23.716130	-46.696855	115519.529999999999	2014-12-07 16:16:39.251978	\N
3257	EMEI setor 2304 (Rua Nova Irlanda) - CIDADE DUTRA	Rua Nova Irlanda	-23.722259	-46.684577	167771.869999999995	2014-12-07 16:16:39.272261	\N
3258	EMEI setor 2307 (Rua Frederico René de Jaegher) - CIDADE DUTRA	Rua Frederico René de Jaegher, 1631 - Rio Bonito	-23.725480	-46.711607	17681.4000000000015	2014-12-07 16:16:39.29226	\N
3259	EMEI setor 2308 (Jardim das Imbuias) - CIDADE DUTRA	Rua Indochina X Rua Jose Luis Monteiro	-23.730748	-46.707512	16049.2900000000009	2014-12-07 16:16:39.313648	\N
3260	EMEI setor 2403 (Rua Jacinto Ferreira) - CIDADE LIDER	Rua Jacinto Ferreira	-23.563952	-46.480482	146200	2014-12-07 16:16:39.333477	\N
3261	EMEI setor 2502 (Rua Sonata ao Luar) - CIDADE TIRADENTES	R. Sonata ao Luar - Loteamento  dom Angélicox bar Teix Camargo	-23.581934	-46.382748	0	2014-12-07 16:16:39.353661	\N
3262	EMEI setor 2901 (Rua Francisco de Paula Bonilha X Rua Pedro Velasca) - FREGUESIA DO O	Rua Francisco de Paula Bonilha X Rua Pedro Velasca	-23.468017	-46.705136	0	2014-12-07 16:16:39.371323	\N
3263	EMEI setor 3001 (Rua Domingos Rinaldelli) - GRAJAU	Rua Domingos Rinaldelli	-23.744148	-46.683336	0	2014-12-07 16:16:39.387061	\N
3264	EMEI setor 3005 (Rua Dr. Leão de Araújo Novaes x Rua Haroldo Nogueira) - GRAJAU	Rua Dr. Leão de Araújo Novaes (Chácara Cocaia) x Rua Haroldo Nogueira	-23.767619	-46.692729	4039.59000000000015	2014-12-07 16:16:39.404112	\N
3265	EMEI setor 3006 (Rua Tres Coracoes) - GRAJAU	Rua Tres Coraçoes	-23.773814	-46.676347	116290.550000000003	2014-12-07 16:16:39.419451	\N
3266	EMEI setor 3008 (Estrada do Barro Branco com Rua Nelia Andre) - GRAJAU	Estrada do Barro Branco com Rua Nelia Andre	-23.761561	-46.670652	14164.6100000000006	2014-12-07 16:16:39.437137	\N
3267	EMEI setor 3010 (Rua Dona Belmira Marin) - GRAJAU	Rua Dona Belmira Marin (mesmo terreno do CEI Lar Altair Martins)	-23.753088	-46.682584	19929.1699999999983	2014-12-07 16:16:39.45637	\N
3268	EMEI setor 3012 (Travessa Pau Santo X Travessa Jameleiro) - GRAJAU	Travessa Pau Santo X Travessa Jameleiro	-23.741117	-46.669684	117227.220000000001	2014-12-07 16:16:39.482131	\N
3269	EMEI setor 3607 (Rua Jorge dos Santos X Av. Marechal Tito) - ITAIM PAULISTA	Rua Jorge dos Santos X Av. Marechal Tito	-23.489676	-46.385332	158726.109999999986	2014-12-07 16:16:39.500474	\N
3270	EMEI setor 3801 (Rua Alberto Sampaio) - JABAQUARA	Rua Alberto Sampaio	-23.656321	-46.659156	0	2014-12-07 16:16:39.520509	\N
3271	EMEI setor 3806 (Rua João Xavier de Matos X Rua das Vitaceas) - JABAQUARA	Rua João Xavier de Matos X Rua das Vitaceas	-23.669192	-46.639135	112400	2014-12-07 16:16:39.538051	\N
3272	EMEI setor 4304 (Estrada Guavirituba, 797) - JARDIM ANGELA	Estrada Guavirituba, 797	-23.684304	-46.762541	78766.0399999999936	2014-12-07 16:16:39.556958	\N
3273	EMEI setor 4307 (Rua Abutuí) - JARDIM ANGELA	Rua Abutuí (Rua Carlo Caproli)	-23.738805	-46.779704	46453.3600000000006	2014-12-07 16:16:39.582999	\N
3274	EMEI setor 5504 (Rua Sadamu Inoue) - PARELHEIROS	Rua Sadamu Inoue (ao lado da EE Paulino Nunes Esposo, nº 365) X Rua José Nicolau de Lima	-23.777149	-46.722690	79112.5599999999977	2014-12-07 16:16:39.610361	\N
3275	EMEI setor 5803 (Rua dos Abiquaras) - PEDREIRA	R. dos Abiquaras - Plano E	-23.702012	-46.632908	0	2014-12-07 16:16:39.62558	\N
3276	EMEI setor 7601 (Rua Cristovão Jaques) - SAPOPEMBA	Rua Cristovão Jaques	-23.590808	-46.523646	0	2014-12-07 16:16:39.640105	\N
3277	EMEI setor 8103 (Rua Kotinda X Rua Cachoeira) - TREMEMBE	Rua Kotinda X Rua Cachoeira	-23.430129	-46.584405	0	2014-12-07 16:16:39.654504	\N
3278	EMEI setor 8104 (Rua dos Sabias da Cantareira) - TREMEMBE	Rua dos Sabias da Cantareira - plano A (próximo à Rodovia Fernão Dias)Rua dos Sabias da Cantareira - plano A (próximo à Rodovia Fernão Dias)	-23.434984	-46.569848	0	2014-12-07 16:16:39.669729	\N
3279	EMEI setor 9601 (Rua Gaspar Barbosa) - LAJEADO	Rua Gaspar Barbosa (antiga Rua Francisco Nunes Cubas)	-23.547199	-46.394802	0	2014-12-07 16:16:39.683709	\N
3280	EMEI setor 9603 (Rua Tibúrcio de Sousa esquina com Francisco Souto Maior) - LAJEADO	R. Tiburcio de Souza x R. Francisco de Souto Maior	-23.523045	-46.386399	0	2014-12-07 16:16:39.698668	\N
3281	EMEI setor 9605 (Rua Rio Maturaca) - LAJEADO	Rua Rio Maturaca	-23.536298	-46.414905	0	2014-12-07 16:16:39.713398	\N
3282	Vagas para Educação Infantil (EMEI)	\N	0	0	0	2014-12-07 16:16:39.72855	\N
3283	Vagas para Educação Infantil (Rede Conveniada)	\N	0	0	32254400	2014-12-07 16:16:39.993999	\N
3284	Rede Hora Certa / Hospital Dia- Brasilândia/FO	 Rua Rui de Morais Apocalipse, 2 	-23.47362	-46.68433	1594240	2014-12-07 16:16:40.094829	\N
3285	Rede Hora Certa / Hospital Dia -Itaim Paulista	Rua Marechal Tito, 6577	-23.489810	-46.385912	2766713	2014-12-07 16:16:40.109291	\N
3286	Rede Hora Certa / Hospital Dia - Lapa	Rua Catão, 380	-23.524223	-46.700598	1779740	2014-12-07 16:16:40.129042	\N
3287	Rede Hora Certa / Hospital Dia- M' Boi Mirim I	Rua Philipe de Vitry, 802	-23.66516	-46.73581	2385466.20000000019	2014-12-07 16:16:40.144296	\N
3288	Rede Hora Certa / Hospital Dia - M' Boi Mirim II	Rua dos Funcionários Públicos, 379	-23.72373	-46.80819	2599941.2799999998	2014-12-07 16:16:40.159893	\N
3289	Rede Hora Certa / Hospital Dia - Penha	Praça Nossa Senhora da Penha, 55	-23.526578	-46.550294	2962705	2014-12-07 16:16:40.17489	\N
3290	Rede Hora Certa  / Hospital Dia - São Miguel Paulista	Rua Professor Antônio Gama de Cerqueira, 347 	-23.496879	-46.440955	2400000	2014-12-07 16:16:40.191914	\N
3291	Rede Hora Certa / Hospital Dia- Ipiranga	Rua Xavier de Almeida, 210 	-23.587712	-46.608500	1594240	2014-12-07 16:16:40.206287	\N
3292	Rede Hora Certa / Hospital Dia - Butantã	Rua João Guerra, 37	-23.585371	-46.731217	0	2014-12-07 16:16:40.221374	\N
3293	Rede Hora Certa / Hospital Dia- Campo Limpo	Avenida Amadeu da Silva Samelo, 423	-23.630735	-46.765950	0	2014-12-07 16:16:40.23589	\N
3294	Rede Hora Certa / Hospital Dia  - Vila Prudente	Praça Centenário de Vila Prudente, 108	-23.581810	-46.582474	0	2014-12-07 16:16:40.251178	\N
3295	Rede Hora Certa / Hospital Dia- Cidade Ademar	Rua Corrego Azul, 433	-23.696157	-46.660373	0	2014-12-07 16:16:40.26604	\N
3296	Rede Hora Certa / Hospital Dia -Tucuruvi/Santana	\N	0	0	0	2014-12-07 16:16:40.282626	\N
3297	Rede Hora Certa / Hospital Dia- São Mateus	Rua Augusto Ferreira Ramos, 9	-23.589488	-46.492873	0	2014-12-07 16:16:40.29695	\N
3298	Rede Hora Certa - Vila Guilherme /Vila Maria	Rua João Ventura Batista, 615	-23.516125	-46.605462	0	2014-12-07 16:16:40.312555	\N
3299	Rede Hora Certa / Hospital Dia  - Aricanduva/Carrão	\N	0	0	0	2014-12-07 16:16:40.327028	\N
3300	Rede Hora Certa Cidade Dutra	\N	0	0	0	2014-12-07 16:16:40.342499	\N
3301	Rede Hora Certa Casa Verde	\N	0	0	0	2014-12-07 16:16:40.357545	\N
3302	Rede Hora Certa Cidade Tiradentes	\N	0	0	0	2014-12-07 16:16:40.373614	\N
3303	Rede Hora Certa Ermelino Matarazzo	\N	0	0	0	2014-12-07 16:16:40.38991	\N
3304	Rede Hora Certa Guaianases	\N	0	0	0	2014-12-07 16:16:40.40468	\N
3305	Rede Hora Certa Itaquera	\N	0	0	0	2014-12-07 16:16:40.422468	\N
3306	Rede Hora Certa Jabaquara	\N	0	0	0	2014-12-07 16:16:40.440135	\N
3307	Rede Hora Certa Jaçanã/Tremembé	\N	0	0	0	2014-12-07 16:16:40.457794	\N
3308	Rede Hora Certa Mooca	Rua Farol Paulistano, 410	-23.570862	-46.575522	0	2014-12-07 16:16:40.475974	\N
3309	Rede Hora Certa Parelheiros	\N	0	0	0	2014-12-07 16:16:40.493243	\N
3310	Rede Hora Certa Perus	\N	0	0	0	2014-12-07 16:16:40.511834	\N
3311	Rede Hora Certa Pinheiros	\N	0	0	0	2014-12-07 16:16:40.529014	\N
3312	Rede Hora Certa Pirituba	\N	0	0	0	2014-12-07 16:16:40.545289	\N
3313	Rede Hora Certa Sapopemba	\N	0	0	0	2014-12-07 16:16:40.563094	\N
3314	Rede Hora Certa Sé	\N	0	0	0	2014-12-07 16:16:40.580996	\N
3315	Rede Hora Certa  - Saúde	\N	0	0	0	2014-12-07 16:16:40.597191	\N
3316	Rede Hora Certa Móvel - Pirituba/Brasilândia	\N	0	0	0	2014-12-07 16:16:40.612326	\N
3317	Rede Hora Certa Móvel - Capela do Socorro/Santo Amaro	\N	0	0	0	2014-12-07 16:16:40.628983	\N
3318	Rede Hora Certa Móvel - Ermelino Matarazzo/São Mateus	\N	0	0	0	2014-12-07 16:16:40.648874	\N
3319	Rede Hora Certa Móvel - Sé	\N	0	0	0	2014-12-07 16:16:40.666879	\N
3320	Implantação do prontuário Eletrônico integrado ao Sistema Integrado de Gestão e Assistência à Saúde (SIGA)	\N			0	2014-12-07 16:16:40.842736	\N
3321	Hospital Municipal - Brasilândia	Estrada do Sabão, 478	-23.476754	-46.699834	0	2014-12-07 16:16:40.937683	\N
3322	Hospital Municipal - Parelheiros	Rua Eusébio Goghi X Rua Cacual	-23.824524	-46.726585	0	2014-12-07 16:16:40.952998	\N
3323	Novo Hospital Municipal (em substituição ao Hospital Municipal Alexandre Zaio)	Rua Alves Maldonado, 128	-23.542717	-46.501714	0	2014-12-07 16:16:40.972338	\N
3324	Hospital Municipal Alípio Correa Neto	Alameda rodrigo de Brum, 1989	-23.50055	-46.47252	0	2014-12-07 16:16:41.066181	\N
3325	Hospital Municipal Cidade Tiradentes - Carmen Prudente	Avenida dos Metalúrgicos, 2100	-23.599600	-46.401852	0	2014-12-07 16:16:41.081025	\N
3326	Hospital Municipal Dr. Arthur Ribeiro de Saboya	Avenida Francisco Paula Quintanilha Ribeiro, 860	-23.653599	-46.644980	0	2014-12-07 16:16:41.102629	\N
3327	Hospital Municipal Dr. Benedicto Montenegro	Rua Antonio Lázaro, 226	-23.587425	-46.514276	0	2014-12-07 16:16:41.118142	\N
3328	Hospital Municipal Dr. Carmino Caricchio	R. Santo Elias, 41	-23.533643	-46.566906	2938036.27000000002	2014-12-07 16:16:41.134011	\N
3329	Hospital Municipal Dr. Fernando Mauro Pires da Rocha	Rua Tereza Mouco de Oliveira, s/n	-23.64861	-46.74976	0	2014-12-07 16:16:41.15031	\N
3330	Hospital Municipal Dr. Ignácio Proença de Gouveia	Rua Juventus, 562	-23.57172	-46.58991	1492243.05000000005	2014-12-07 16:16:41.165575	\N
3331	Hospital Municipal Dr. Mario Degni	Rua Lucas de Leyde, 257	-23.57812	-46.76543	0	2014-12-07 16:16:41.181053	\N
3332	Hospital Municipal Dr. Moysés Deustch - M`Boi Mirim	Estrada M' Boi Mirim, 5203	-23.688530	-46.772595	0	2014-12-07 16:16:41.19579	\N
3333	Hospital Municipal Infantil Menino Jesus	Rua dos Ingleses, 258	-23.560069	-46.647084	0	2014-12-07 16:16:41.211384	\N
3334	Hospital Municipal José Soares Hungria	Avenida Menotti Laudísio, 100	-23.484347	-46.728655	0	2014-12-07 16:16:41.2261	\N
3335	Hospital Municipal Maternidade Escola Dr. Mario de Moraes Altenfelder Silva	Avenida Deputado Emílio Carlos, 3100	-23.47963	-46.67278	0	2014-12-07 16:16:41.242323	\N
3336	Hospital Municipal Prof. Waldomiro de Paula	Rua Augusto Carlos Baumann, 1074	-23.53084	-46.44509	0	2014-12-07 16:16:41.257009	\N
3337	Hospital Municipal São Luiz Gonzaga	Rua Michel Ouchana, 94	-23.460131	-46.582196	0	2014-12-07 16:16:41.272673	\N
3338	Hospital Municipal Sorocabana	Rua Catão, 380	-23.524223	-46.700598	0	2014-12-07 16:16:41.287716	\N
3339	Hospital Municipal Tide Setubal	Rua Dr. Guilherme Eiras, 123 	-23.497283	-46.440097	479106.840000000026	2014-12-07 16:16:41.303187	\N
3340	Hospital Municipal Vereador José Storopoli	Rua Francisco Fanganiello, 127	-23.522389	-46.561833	0	2014-12-07 16:16:41.318572	\N
3341	Leitos ativados em hospitais existentes	\N	0	0	0	2014-12-07 16:16:41.334065	\N
3342	UBS Integral Jardim Edith	Rua Charles Coulomb, 80	-23.613357	-46.693766	263696.010000000009	2014-12-07 16:16:41.481608	\N
3343	UBS Integral Jardim Mirian II	Av. Cupecê, 5185	-23.679314	-46.640035	806199.300000000047	2014-12-07 16:16:41.498234	\N
3344	UBS Integral Jardim Vera Cruz	Avenida dos Funcionários Públicos, 379	-23.733420	-46.783361	1340000	2014-12-07 16:16:41.517945	\N
3345	UBS Integral Maringá/Talarico	Rua Muaná, 214	-23.552981	-46.515050	167475.459999999992	2014-12-07 16:16:41.533353	\N
3346	UBS Integral São Vicente de Paula	Rua Vicente da Costa, 289	-23.591029	-46.609071	2963396.16000000015	2014-12-07 16:16:41.54877	\N
3347	UBS Integral Brasilandia III	Av. Interativa /R. Vale do Luar (COHAB Brasilandia B)	-23.446539	-46.710986	0	2014-12-07 16:16:41.563762	\N
3348	UBS Integral Cidade Nova São Miguel / Sacolão PÚBLICA	R. Rosaria x Av.Mohamad Ibraim Saleh	-23.504121	-46.432309	0	2014-12-07 16:16:41.579433	\N
3349	UBS Integral Encosta II	R. Renata Agondi, s/n x R. Carlos Aguiar	-23.502838	-46.380054	0	2014-12-07 16:16:41.59441	\N
3350	UBS Integral Jardim Eliane II	R. Maria Pape, s/n	-23.761591	-46.673675	0	2014-12-07 16:16:41.6098	\N
3351	UBS Integral Jardim Fontalis	R. Ushikichi Kamiya, 1383	-23.438511	-46.583632	0	2014-12-07 16:16:41.624022	\N
3352	UBS Integral Jardim Helena	R. Capachos x R. Catulé 	-23.480340	-46.380592	0	2014-12-07 16:16:41.639377	\N
3353	UBS Integral Primavera / Colorado	R. Chiquinha Gonzaga, 349	-23.590118	-46.526140	0	2014-12-07 16:16:41.654476	\N
3354	UBS Integral Jardim São Carlos Cesar Augusto Romano	R. Cel Cesar Augusto Romano, 250	-23.508132	-46.474717	0	2014-12-07 16:16:41.670411	\N
3355	UBS Integral Jova Rural	R. Alfeu Alcântara Monteiro x R. Nilda C. Cunha	-23.454764	-46.579540	0	2014-12-07 16:16:41.685323	\N
3356	UBS Integral Parque das Nações Unidas	Av. 4 x R. 3 x R. 8 (prox. R. Friedrich von Voith)	-23.437676	-46.740039	0	2014-12-07 16:16:41.700467	\N
3357	UBS Integral Vila Sonia II (Jd. Colombo)	R. José Capobianco, 232	-23.601385	-46.730062	0	2014-12-07 16:16:41.714895	\N
3358	UBS Integral Arlindo Bettio	R. ARLINDO BETTIO, s/n	-23.499088	-46.491920	0	2014-12-07 16:16:41.730193	\N
3359	UBS Integral Jardim Orion	R. João Goulart, 2400	-23.723922	-46.678376	0	2014-12-07 16:16:41.745467	\N
3360	UBS Integral Jardim São Bernardo	R. Antonio Carlos Beijamim dos Santos, 836	-23.747766	-46.697196	0	2014-12-07 16:16:41.761712	\N
3361	UBS Integral Nascer do Sol	R. Senador Nelson Carneiro x R. Nascer do Sol	-23.591645	-46.408846	0	2014-12-07 16:16:41.776518	\N
3362	UBS Integral Sepetiba	Av. Sepetiba, 660	-23.535205	-46.701033	0	2014-12-07 16:16:41.792653	\N
3363	UBS Integral Vila Ema	R. Margarida Stach - R. Gustavo Stach	-23.581161	-46.546316	0	2014-12-07 16:16:41.808704	\N
3364	UBS Integral Vila Rubi	R. Archote do Peru, s/n	-23.729280	-46.693317	0	2014-12-07 16:16:41.823565	\N
3365	UBS Integral Cel. Bento Bicudo	R. Cel Bento Bicudo, 350	-23.512004	-46.708673	0	2014-12-07 16:16:41.839151	\N
3366	UBS Integral Engenheiro Alberto Meyer	R. Eng. Alberto Meyer, 318	-23.479894	-46.689254	0	2014-12-07 16:16:41.854217	\N
3367	UBS Integral Estrada das Cachoeiras	Av. Escola Politécnica, 192	-23.562710	-46.749880	0	2014-12-07 16:16:41.870134	\N
3368	UBS Integral Jardim Seckler II	R. Cosme de Souza, 408	-23.623936	-46.586568	0	2014-12-07 16:16:41.8861	\N
3369	UBS Integral Manoel Fernandes Leão	R. Manoel Fernandes Leão, 500	-23.440271	-46.710698	0	2014-12-07 16:16:41.903542	\N
3370	UBS Integral Cantinho do Céu "Mananciais"	R. Rodrigues Alves x R. dos Acordes	-23.745107	-46.661714	0	2014-12-07 16:16:41.918272	\N
3371	UBS Integral Pro Morar	R. Giovanni Nasco x R. Daniel da Anunciação	-23.605389	-46.498712	0	2014-12-07 16:16:41.933724	\N
3372	UBS Integral Vila da Paz "Mananciais"	Av. Jair Ribeiro da Silva, alt. no 680 	-23.704405	-46.686714	0	2014-12-07 16:16:41.948919	\N
3373	UBS Integral Bom Retiro	R. Gen. Flores, 28	-23.525928	-46.642071	0	2014-12-07 16:16:41.964145	\N
3374	UBS Integral Jardim Antártica	R. Solar X R. Lembrança x R. Francisco Machado da Silva	-23.454663	-46.656828	0	2014-12-07 16:16:41.979897	\N
3375	UBS Integral Jardim Apuanã	R. Filhos da Terra, 801	-23.451002	-46.585303	0	2014-12-07 16:16:41.997929	\N
3376	UBS Integral Jardim São Nicolau	R. Brook Taylor X R. Pierre Jansen	-23.529566	-46.476379	0	2014-12-07 16:16:42.01315	\N
3377	UBS Integral Jardim Cabuçú	R. Miguel Arrojado Lisboa, 299	-23.468076	-46.566498	0	2014-12-07 16:16:42.029645	\N
3378	UBS Integral Brasilandia IV	\N	0	0	0	2014-12-07 16:16:42.044612	\N
3379	UBS Integral Complexo Prates	\N	0	0	0	2014-12-07 16:16:42.060398	\N
3380	UBS Integral Ebanos	\N	0	0	0	2014-12-07 16:16:42.075524	\N
3381	UBS Integral Jardim Helian	\N	0	0	0	2014-12-07 16:16:42.090962	\N
3382	UBS Integral Jardim Julieta	\N	0	0	0	2014-12-07 16:16:42.105798	\N
3383	UBS Integral Malta Cardoso II	\N	0	0	0	2014-12-07 16:16:42.121416	\N
3384	UBS Integral Morada do Sol II	\N	0	0	0	2014-12-07 16:16:42.136692	\N
3385	UBS Integral Palanque	\N	0	0	0	2014-12-07 16:16:42.152789	\N
3386	UBS Integral Parque das Flores	\N	0	0	0	2014-12-07 16:16:42.168702	\N
3387	UBS Integral Vila Esperança	\N	0	0	0	2014-12-07 16:16:42.183639	\N
3388	UBS Integral Vila Guarani II	\N	0	0	0	2014-12-07 16:16:42.198898	\N
3389	UBS Integral Sacomã II	\N	0	0	0	2014-12-07 16:16:42.214509	\N
3390	UBS Integral Limoeiro	\N	0	0	0	2014-12-07 16:16:42.230603	\N
3391	UBS Integral Cambucí	Av. Lacerda Franco, 791/795	-23.569327	-46.623594	0	2014-12-07 16:16:42.246216	\N
3392	UBS Integral Jardim Cibele	\N	0	0	0	2014-12-07 16:16:42.261873	\N
3393	UBS Integral Jardim dos Álamos	\N	0	0	0	2014-12-07 16:16:42.276826	\N
3394	UBS Integral Jardim Elisa Maria	\N	0	0	0	2014-12-07 16:16:42.292233	\N
3395	UBS Integral Kioto	Av. Orfeo Paravento x R. Royan	-23.735321	-46.717772	0	2014-12-07 16:16:42.307349	\N
3396	UBS Integral Sacolão das Artes	Av. Cândido José Xavier, 577	-23.661701	-46.756406	0	2014-12-07 16:16:42.323095	\N
3397	UBS Integral Conjunto Faria Lima	\N	0	0	0	2014-12-07 16:16:42.338727	\N
3398	UBS Integral Jardim Guanhembu	\N	0	0	0	2014-12-07 16:16:42.354486	\N
3399	UBS Integral Jardim Reimberg	\N	0	0	0	2014-12-07 16:16:42.370089	\N
3400	UBS Integral Jardim São Paulo	\N	0	0	0	2014-12-07 16:16:42.385867	\N
3401	UBS Integral Vila Sonia III (Jaqueline)	\N	0	0	0	2014-12-07 16:16:42.400622	\N
3402	UBS Integral Jardim Popular	\N	0	0	0	2014-12-07 16:16:42.416856	\N
3403	UBS Integral Jardim Vitória	\N	0	0	0	2014-12-07 16:16:42.431715	\N
3404	UBS Integral Pateo do Pari	\N	0	0	0	2014-12-07 16:16:42.448489	\N
3405	UBS Integral Vila Jaguaré	\N	0	0	0	2014-12-07 16:16:42.464034	\N
3406	UBS Integral Vila Mariana	\N	0	0	0	2014-12-07 16:16:42.483787	\N
3407	UPA Vila Santa Catarina (Santa Marina)	Rua Cidade de Bagdá,539	-23.656607	-46.652904	0	2014-12-07 16:16:42.719826	\N
3408	UPA AMA Capão Redondo (serviço existente - construção nova)	Rua Comendador Santana, 774	-23.673958	-46.773553	0	2014-12-07 16:16:42.737591	\N
3409	UPA AMA Dr. Carmino Caricchio - Tatuapé (serviço existente - construção nova)	Avenida Condessa Elisabeth de Rubiano	-23.534833	-46.569133	0	2014-12-07 16:16:42.763999	\N
3410	UPA AMA Dr. Ignácio Proença de Golveia - Mooca (serviço existente - construção nova)	Rua Dr. Fomn, s/n	-23.545543	-46.595454	0	2014-12-07 16:16:42.781136	\N
3411	UPA AMA Ermelino Matarazzo (serviço existente - construção nova)	Rua Rodrigo de Brum, 1989	-23.500552	-46.472520	0	2014-12-07 16:16:42.796161	\N
3412	UPA AMA José Soares Hungria - Pirituba (serviço existente - construção nova)	Rua Menotti Laudisio, 100	-23.484332	-46.728665	0	2014-12-07 16:16:42.812066	\N
3413	UPA AMA Parelheiros (serviço existente - construção nova)	Rua Sadamu Inoue, s/n	-23.799302	-46.731492	0	2014-12-07 16:16:42.827095	\N
3414	UPA AMA Pires do Rio (Tito Lopes) (serviço existente - construção nova)	Avenida Pires do Rio, 294	-23.498945	-46.442331	0	2014-12-07 16:16:42.842811	\N
3415	UPA AMA Sacomã (serviço existente - construção nova)	Estrada das Lágrimas, 1403	-23.613587	-46.594109	0	2014-12-07 16:16:42.857932	\N
3416	UPA Hospital São Paulo  - Vila Mariana (construção nova)	Rua Diogo de Faria, 609	-23.595681	-46.642581	0	2014-12-07 16:16:42.873808	\N
3417	UPA PA Municipal Gloria Rodrigues dos Santos Bonfim (serviço existente - construção nova)	Rua Cachoeira Morena, s/n	-23.571434	-46.403352	0	2014-12-07 16:16:42.890485	\N
3418	UPA Prof. Waldomiro de Paula - Itaquera (serviço existente - construção nova)	Rua Miguel Inacio Curi, s/n	-23.544599	-46.466503	0	2014-12-07 16:16:42.906084	\N
3419	UPA PS Municipal José Silvio de Camargo / Santo Amaro (serviço existente - construção nova)	Avenida Adolfo Pinheiros, 805	-23.646188	-46.701534	0	2014-12-07 16:16:42.922257	\N
3420	UPA São Luiz Gonzaga (construção nova)	Rua Michel Ouchana, 94	-23.460136	-46.582185	0	2014-12-07 16:16:42.937941	\N
3421	UPA AMA Eng. Goulart José Pires - Cangaíba (serviço existente - construção nova)	\N	0	0	0	2014-12-07 16:16:42.954029	\N
3422	UPA AMA Parque Anhanguera (serviço existente - construção nova)	\N	0	0	0	2014-12-07 16:16:42.971778	\N
3423	UPA Hospital das Clínicas - Pinheiros (construção nova)	\N	0	0	0	2014-12-07 16:16:42.987891	\N
3424	UPA Hospital do Servidor Público Municipal - HSPM (construção nova)	\N	0	0	0	2014-12-07 16:16:43.003935	\N
3425	UPA PA Municipal Dr. Atualpa Girão Rabelo (serviço existente - construção nova)	\N	0	0	0	2014-12-07 16:16:43.019986	\N
3426	UPA São Jorge (construção nova)	\N	0	0	0	2014-12-07 16:16:43.035298	\N
3427	UPA Vila Nhocuné - Alexandre Zaio (serviço existente - construção nova)	\N	0	0	0	2014-12-07 16:16:43.051039	\N
3428	UPA AMA Dr. Arthur Ribeiro Saboya -Jabaquara (serviço existente - construção nova)	Avenida Francisco P. Q. Ribeiro, 860	-23.652601	-46.644797	0	2014-12-07 16:16:43.066592	\N
3429	UPA City Jaraguá (construção nova)	Estrada de Taipas, 1648	-23.442221	-46.734635	0	2014-12-07 16:16:43.08283	\N
3430	UPA Pedreira (construção nova)	Rua Antonio do Campo, 1	-23.695244	-46.676499	0	2014-12-07 16:16:43.097983	\N
3431	UPA PS Municipal Perus (contrução nova)	Rua Fiorelli Peccicacco, s/n	-23.404197	-46.751140	0	2014-12-07 16:16:43.114052	\N
3432	UPA PS Municipal Prof. João Catarin Mezomo - Lapa (serviço existente - construção nova)	Avenida Queiroz Filho, 313	-23.537037	-46.723437	0	2014-12-07 16:16:43.129978	\N
3433	UPA Santa Casa de São Paulo	\N	0	0	0	2014-12-07 16:16:43.14528	\N
3434	UPA AMA Dr. Fernando Mauro Pires da Rocha - Campo Limpo (serviço existente - ampliação)	Rua Thereza Mouco Oliveira, 71	-23.649029	-46.749404	8206231.99000000022	2014-12-07 16:16:43.161862	\N
3435	UPA AMA Complexo Prates (serviço existente - ampliação)	Rua Prates, 1107	-23.52437	-46.63435	0	2014-12-07 16:16:43.177102	\N
3436	UPA AMA Paraisópolis (serviço existente - ampliação)	Rua Silveira Sampaio, 660	-23.61710	-46.71817	0	2014-12-07 16:16:43.194507	\N
3437	UPA AMA Sé (serviço existente - ampliação)	Rua Frederico Alvarenga, 303	-23.551330	-46.628201	0	2014-12-07 16:16:43.210672	\N
3438	UPA AMA Sorocabana (serviço existente - ampliação)	Rua Clélia, 1914	-23.524802	-46.701235	0	2014-12-07 16:16:43.242054	\N
3439	UPA PA Municipal Jardim Macedônia (serviço existente - ampliação)	Rua Louis Boulogne, 133	-23.65370	-46.79063	0	2014-12-07 16:16:43.258073	\N
3440	UPA PA Municipal São Mateus II (serviço existente - ampliação)	Rua Dr. Carlos Julio Spera, 139	-23.61000	-46.47962	0	2014-12-07 16:16:43.27379	\N
3441	UPA PS Municipal 21 de Junho / Freguesia do Ó (serviço existente - reforma)	Avenida João Paulo I, 421	-23.489781	-46.688443	0	2014-12-07 16:16:43.29027	\N
3442	UPA PS Municipal Augusto Gomes de Matos (serviço existente - ampliação)	Rua Julio Felipe Guedes, 200	-23.63393	-46.60672	0	2014-12-07 16:16:43.305702	\N
3443	UPA PS Municipal Balneário São José (serviço existente - reforma)	Rua Gaspar Leme, s/n	-23.77092	-46.72390	0	2014-12-07 16:16:43.322318	\N
3444	UPA PS Municipal Dona Maria Antonieta F de Barros (serviço existente - ampliação)	Rua Antonio Felipe Filho, 180	-23.74988	-46.68966	0	2014-12-07 16:16:43.33793	\N
3445	UPA PS Municipal Dr. Caetano Virgilio Netto (serviço existente - ampliação)	Rua Augusto Farinha, 1125	-23.580070	-46.741990	0	2014-12-07 16:16:43.354396	\N
3446	UPA PS Municipal Júlio Tupy (serviço existente - reforma)	Rua Serra da Queimada, 800	-23.527710	-46.410975	0	2014-12-07 16:16:43.370585	\N
3447	UPA PS Municipal Lauro Ribas Braga - Santana (serviço existente - reForma)	Rua Voluntários da Pátria, 943	-23.512542	-46.626268	0	2014-12-07 16:16:43.38761	\N
3448	UPA PS Municipal Vila Maria Baixa (serviço existente - ampliação)	Praça Engenheiro Hugo Brandi, 15	-23.516851	-46.578374	0	2014-12-07 16:16:43.403963	\N
3449	UPA PS Municipal Dr. Álvaro Dino de Almeida (serviço existente - ampliação)	R. Vitorino Carmilo, 717	-23.531227	-46.652773	0	2014-12-07 16:16:43.419454	\N
3450	CAPS AD III JD NELIA / Itaim UA Adulto	Estrada Dom João Neri, 4531	-23.531231	-46.397078	0	2014-12-07 16:16:43.613912	\N
3451	CAPS AD III BRASILANDIA / UA Infanto-juvenil	Av. Otaviano Alves de Lima, s/n	-23.507923	-46.706364	0	2014-12-07 16:16:43.630408	\N
3452	CAPS AD III CIDADE ADEMAR / UA Infanto-juvenil	Rua Prof. Cardoso de Melo, 1000	-23.698294	-46.638688	0	2014-12-07 16:16:43.654529	\N
3453	CAPS AD III JD HELENA / UA Adulto S. Miguel	Rua das Violetas, s/nº	-23.480452	-46.419175	0	2014-12-07 16:16:43.671896	\N
3454	CAPS AD III PARELHEIROS / UA Adulto	Rua Terezinha Prado de Oliveira, 100	-23.828585	-46.723266	0	2014-12-07 16:16:43.687703	\N
3455	CAPS AD III PERUS	Av. Fiorelli Peccicacco, 500	-23.404355	-46.750954	0	2014-12-07 16:16:43.703684	\N
3456	CAPS AD III VILA MARIANA	Rua Pedro de Toledo (próx. Rua Lenadro Dupré)	-23.598019	-46.646926	0	2014-12-07 16:16:43.719319	\N
3457	CAPS AD III VILA MARIA	Av. do Poeta, 740	-23.486083	-46.565705	0	2014-12-07 16:16:43.736111	\N
3458	CAPS AD III VILA SONIA	Rua José Capobianco, 232	-23.601416	-46.730135	0	2014-12-07 16:16:43.752555	\N
3459	CAPS AD III CIDADE TIRADENTES / UA Adulto	Plano A - Rua Moises Corena Plano B - Rua Moisés de Corena x Rua Varzea Nova	-23.594295	-46.397064	0	2014-12-07 16:16:43.771017	\N
3460	CAPS ADULTO III GRAJAU	Rua Três Corações	-23.772903	-46.676862	0	2014-12-07 16:16:43.789463	\N
3461	CAPS Adulto III SÃO MATEUS	Rua Maria Luiza do Val Penteado	-23.607830	-46.482924	0	2014-12-07 16:16:43.805865	\N
3462	CAPS INFANTIL CIDADE TIRADENTES / UA Infanto-juvenil	Plano A - Rua dos Texteis Plano B - Rua Moisés de Corena         	-23.597016	-46.397132	0	2014-12-07 16:16:43.82183	\N
3463	CAPS INFANTIL GRAJAU	Rua Professor Alfredo Attie	-23.740837	-46.686166	0	2014-12-07 16:16:43.837576	\N
3464	CAPS ADULTO III ITAIM PAULISTA	Rua Georgina Diniz Braghiroli	-23.509348	-46.423109	0	2014-12-07 16:16:43.85393	\N
3465	CAPS ADULTO III JD HELENA	Praça Craveiro do Campo	-23.478687	-46.420400	0	2014-12-07 16:16:43.869994	\N
3466	CAPS INFANTIL JD HELENA	Praça Craveiro do Campo	-23.478687	-46.420400	0	2014-12-07 16:16:43.886105	\N
3467	CAPS ADULTO III PERUS	Av. Fiorelli Peccicacco, 500	-23.404355	-46.750954	0	2014-12-07 16:16:43.90234	\N
3468	CAPS INFANTIL PIRITUBA	Rua General Lauro Cavalcanti de Farias, 171	-23.492671	-46.747072	0	2014-12-07 16:16:43.924915	\N
3469	CAPS INFANTIL SÃO MATEUS	Rua Julio Cesar Moreira, 50	-23.621408	-46.466783	0	2014-12-07 16:16:43.943293	\N
3470	CAPS ADULTO III SÃO MIGUEL PAULISTA	Rua Cardon, 1242	-23.520036	-46.441226	0	2014-12-07 16:16:43.959264	\N
3471	CAPS INFANTIL SÃO MIGUEL PAULISTA	Av. São Miguel x Rua Pau D'Arc Roxo x Rua Henrique Xavier de Brito	-23.499062	-46.466021	0	2014-12-07 16:16:43.975467	\N
3472	CAPS ADULTO III VILA MARIANA / UA Adulto	Rua Pedro de Toledo (próx. Rua Leandro Dupré)	-23.598019	-46.646926	0	2014-12-07 16:16:43.992049	\N
3473	CAPS ADULTO III VILA MARIA	Av. do Poeta, 740	-23.486083	-46.565705	0	2014-12-07 16:16:44.008219	\N
3474	CAPS ADULTO III BUTANTA / UA Adulto	Rua Domingos Portela	-23.593944	-46.745262	0	2014-12-07 16:16:44.024154	\N
3475	CAPS ADULTO III RIO PEQUENO	Rua Joaquim Celidonio Gomes dos Reis, 336	-23.577911	-46.763326	0	2014-12-07 16:16:44.041126	\N
3476	CAPS INFANTIL BUTANTA / UA Infanto-juvenil	Rua Domingos Portela	-23.593944	-46.745262	0	2014-12-07 16:16:44.05762	\N
3477	CAPS AD III Campo Limpo	Rua Domingos Bicudo, 385	-23.635755	-46.774030	0	2014-12-07 16:16:44.086923	\N
3478	CAPS Infantil Campo Limpo	Rua Aroldo Azevedo, 38	-23.632918	-46.775579	0	2014-12-07 16:16:44.103174	\N
3479	CAPS AD III SÃO MATEUS	R. Maria Luiza do Val Penteado	-23.607767	-46.482773	0	2014-12-07 16:16:44.119465	\N
3480	CAPS AD III ITAQUERA	Rua Gondaren - Cidade Lider	-23.560223	-46.497305	0	2014-12-07 16:16:44.136304	\N
3481	CAPS AD III GRAJAU / UA Adulto	Av. Dona Belmira Marin, 4821	-23.75609	-46.67071	0	2014-12-07 16:16:44.153321	\N
3482	Casa de Cultura Casarão Celso Garcia	Avenida Celso Garcia, 849	-23.53864	-46.60428	0	2014-12-07 16:16:44.321387	\N
3483	Biblioteca Camila Cerqueira César	Rua Waldemar Sanches, 41	0	0	0	2014-12-07 16:16:44.33927	\N
3484	Equipamento cultural - Sacolão das Artes	Avenida Cândido José Xavier, 577	-23.66187	-46.75642	0	2014-12-07 16:16:44.360724	\N
3485	Casa de Cultura de Ermelino Matarazzo	Avenida Paranaguá, altura do 1.600	-23.49160	-46.47869	0	2014-12-07 16:16:44.377481	\N
3486	Biblioteca Cora Coralina	Rua Otelo Augusto Ribeiro, 113	0	0	0	2014-12-07 16:16:44.441643	\N
3487	Casa de Cultura de Jabaquara	Rua Arsênio Tavolieri, 45	-23.65128	-46.64522	0	2014-12-07 16:16:44.45994	\N
3488	Equipamento cultural - Edifício da Antiga Sociedade Philarmônica Alemã Lyra	Rua São Joaquim, 329	-23.56140	-46.63539	0	2014-12-07 16:16:44.477462	\N
3489	Casa de Cultura de Parelheiros	Rua Nazle Mauad Lufti, 200	-23.83133	-46.73040	0	2014-12-07 16:16:44.493833	\N
3490	Casa de Cultura de Pirituba	Av. Mutinga, 1425	-23.48611	-46.73924	0	2014-12-07 16:16:44.509929	\N
3491	Casa de Cultura de São Mateus	Rua Quaresma Delgado, 376	-23.62491	-46.46813	0	2014-12-07 16:16:44.526732	\N
3492	Casa de Cultura da Vila Guilherme	Praça Oscar Silva, s/nº	-23.507476	-46.601089	0	2014-12-07 16:16:44.543395	\N
3493	Casa de Cultura do Sítio Mirim	Av. Dr. Assis Ribeiro	-23.53675	-46.45407	0	2014-12-07 16:16:44.559558	\N
3494	Equipamento cultural 13	\N	0	0	0	2014-12-07 16:16:44.575873	\N
3495	Equipamento cultural 14	\N	0	0	0	2014-12-07 16:16:44.591854	\N
3496	Equipamento cultural 15	\N	0	0	0	2014-12-07 16:16:44.608436	\N
3497	Equipamento cultural 16	\N	0	0	0	2014-12-07 16:16:44.624128	\N
3498	Calendário Cultural - Viradas Culturais no Centro	\N	0	0	11500000	2014-12-07 16:16:44.759572	\N
3499	Calendário Cultural - Festas de São João	\N	0	0	1000000	2014-12-07 16:16:44.777668	\N
3500	Calendário Cultural - Viradas Culturais em novas centralidades	\N	0	0	50000	2014-12-07 16:16:44.798977	\N
3501	Calendário Cultural - Festivais dos povos do mundo	\N	0	0	0	2014-12-07 16:16:44.816186	\N
3502	Outras atividades do Calendário Anual Cultural	\N	0	0	1500000	2014-12-07 16:16:44.831891	\N
3503	Centro Cultural do M' Boi Mirim	Av. Inácio Dias da Silva, s/nº	-23.67381	-46.74280	0	2014-12-07 16:16:44.94721	\N
3504	Centro Cultural de Itaquera	Rua Vitório Santim, 44	-23.53675	-46.45407	0	2014-12-07 16:16:44.965208	\N
3505	Centro de Formação Cultural de Cidade Tiradentes	Av. Inácio Monteiro, 6900	-23.58039	-46.38925	3502954	2014-12-07 16:16:44.989773	\N
3506	Criação de Normativa para Novos Pontos de Cultura	\N	0	0	0	2014-12-07 16:16:45.104464	\N
3507	Pontos de Cultura ativados	\N	0	0	0	2014-12-07 16:16:45.122383	\N
3508	Fundo Municipal de Cultura	\N			0	2014-12-07 16:16:45.242406	\N
3509	Bolsas Cultura	\N	0	0	0	2014-12-07 16:16:45.357982	\N
3510	Criação da SP Cine - fomento ao cinema	\N	0	0	25000000	2014-12-07 16:16:45.481187	\N
3511	Projetos de fomento às linguagens artísticas apoiados	\N	0	0	27200000	2014-12-07 16:16:45.498044	\N
3512	Projetos fomentados pelo Programa para a Valorização de Iniciativas Culturais - VAI (Modalidades 1 e 2)	\N	0	0	4000000	2014-12-07 16:16:45.625198	\N
3513	Unidades Habitacionais - Iguape A - COHAB / MCMV	Av. Itaquera alt. Av. Waldemar Tietz	-23.553396	-46.490743	0	2014-12-07 16:16:45.748317	\N
3514	Unidades Habitacionais - Leme - COHAB / MCMV	R. Alfonso Asturaro s/nº x R. Ricardo da Costa	-23.586230	-46.394790	0	2014-12-07 16:16:45.766435	\N
3515	Unidades Habitacionais - Barra Bonita	R. Peixoto Werneck x R. Pe. Tomás de Vilanova	-23.542714	-46.487029	0	2014-12-07 16:16:45.792195	\N
3516	Unidades Habitacionais - Campos do Jordão	R. Peixoto Werneck x R. Pe. Miguel de Campos	-23.542101	-46.486871	0	2014-12-07 16:16:45.809295	\N
3517	Unidades Habitacionais - Paranapiacaba	R. Flor da Madrugada próx. A R. Lírio do Vale	-23.599970	-46.499094	0	2014-12-07 16:16:45.825299	\N
3518	Unidades Habitacionais - Caçapava	R. Isidoro de Lara x R. Imburana	-23.545958	-46.441792	0	2014-12-07 16:16:45.842286	\N
3519	Unidades Habitacionais - Peruíbe	R. Aviadora Anésia Pinheiro Machado x Rua Ubiratan Pereira Maciel	-23.678134	-46.792209	0	2014-12-07 16:16:45.85865	\N
3520	Unidades Habitacionais - Santa Adélia	R. Fascinação alt. R. Neve na Bahia	-23.552587	-46.429158	0	2014-12-07 16:16:45.875409	\N
3521	Unidades Habitacionais - Brotas	Acesso a R. Tomás Feliciano	0	0	0	2014-12-07 16:16:45.892144	\N
3522	Unidades Habitacionais - Jacareí	Av. Itaquera x R. Nerval Ferreira Braga	-23.554229	-46.485054	0	2014-12-07 16:16:45.908793	\N
3523	Unidades Habitacionais - Vale das Flores (Entidades)	\N	0	0	0	2014-12-07 16:16:45.92646	\N
3524	Unidades Habitacionais - Heliópolis H / Sabesp 2	Gleba H:  Localizada entre as vias Rua Coronel Silva Castro, Rua Conego Xavier e Rua Barão do Rio da Pedra.  Área da Sabesp 2: Localizada dentro da ETE-ABC, entre a Av. Almirante Delamare e Córrego dos Meninos.	-23.606489	-46.595472	0	2014-12-07 16:16:45.944316	\N
3525	Unidades Habitacionais - Heliópolis G / Condominio A	Gleba G:  entre as vias Av. das Juntas Provisórias, Rua Comandante Taylor e Rua Maciel Parente. Rocinha: Ruas Dr. João Pedro de Carvalho, Santo Amaro e Ingá.	-23.600423	-46.596117	0	2014-12-07 16:16:45.965495	\N
3526	Unidades Habitacionais - Cidade Azul	Entre as Ruas Manuel Alves Mesquita,  Manuel Monteiro, Bras de Melo Moniz - próximo a Av. Cupecê.	-23.663704	-46.648162	0	2014-12-07 16:16:45.98317	\N
3527	Unidades Habitacionais - Jardim São Francisco	\N	0	0	0	2014-12-07 16:16:46.001118	\N
3528	Unidades Habitacionais - Tiro ao Pombo / lote 13	\N	0	0	0	2014-12-07 16:16:46.020808	\N
3529	Unidades Habitacionais - Vila Andrade B - CDHU/HABI	\N	0	0	0	2014-12-07 16:16:46.03711	\N
3530	Unidades Habitacionais - Vila Andrade G	\N	0	0	0	2014-12-07 16:16:46.054177	\N
3531	Minas Gás (Execução SEHAB)	\N	-23.505219	-46.684072	0	2014-12-07 16:16:46.071649	\N
3532	Unidades Habitacionais - Gutemberg	Gutemberg: Rua Gutember x Casemiro de Abreu.  	-23.630133	-46.671147	0	2014-12-07 16:16:46.088214	\N
3533	Unidades Habitacionais - Jardim Edite / lote 09	\N	0	0	0	2014-12-07 16:16:46.105061	\N
3534	Unidades Habitacionais - Corruíras	Corruíras: Localizado entre a Av. Gen. Daltro Filho, Rua das Corruíras e Rua dos Cisnes.	-23.654540	-46.645471	0	2014-12-07 16:16:46.120918	\N
3535	Unidades Habitacionais - Real Parque 1ª Etapa	Real Parque: Localizada entre os limites das vias Rua Paulo Bourroul,  Rua César Vallejo,  Barão  de  Castro  Lima,  Rua  Conde  de  Itaguaí,  e  lotes particulares, próximo a Marginal Pinheiros. 	-23.605472	-46.702069	0	2014-12-07 16:16:46.138084	\N
3536	Unidades Habitacionais - Heliópolis Sabesp 1 / Gaivotas	 Sabesp 1: dentro da ETE-ABC, próximo a Av. Almirante Delamare, Córrego dos Meninos e Av. Guido Aliberti. 	-23.613558	-46.582495	0	2014-12-07 16:16:46.154676	\N
3537	Unidades Habitacionais - Heliópolis / Estrada das Lágrimas	Estrada das Lágrimas: entre a Estrada das Lágrimas, Rua Pelegrino Varani, Rua Pantaleão Dantas e Rua Francisco Maria Caropreso.	-23.629171	-46.588735	0	2014-12-07 16:16:46.172059	\N
3538	Unidades Habitacionais - Paraisópolis	Paraisópolis: Localiza-se à esquerda da Av. Giovanni Gronchi (tendo-se como referência o sentido centro-bairro), estendendo-se até as proximidades do Cemitério Morumbi.	-23.621242	-46.727810	0	2014-12-07 16:16:46.193514	\N
3539	Unidades Habitacionais - Sapé A	Sapé A:  Localizada entre os limites da Avenida Waldemar Roberto, Avenida do Rio Pequeno, Rua Tomé de Lara Falcão, Rua General Syzeno Sarmento. 	-23.572934	-46.760514	0	2014-12-07 16:16:46.212649	\N
3540	Unidades Habitacionais - Sapé B	Sapé B:  Localizada entre os limites da Avenida Waldemar Roberto, Rua General Syzeno Sarmento, Rua Calixto Garcia e Rua Maria Rita Balbino. 	-23.580389	-46.756717	0	2014-12-07 16:16:46.229912	\N
3541	Unidades Habitacionais - Diogo Pires / lote 15	Localizada entre os limites da Via Avenida Dracena e Alexandre Mackenzie e vizinho aos empreendimentos da Favela Nova Jaguaré e a Área de Provisão Alexandre Mackenzie.	-23.539448	-46.746692	0	2014-12-07 16:16:46.245773	\N
3542	Unidades Habitacionais - Ponte dos Remédios	Localizada entre os limites das Vias Avenida Embaixador Macedo Soares (marginal esquerda do Rio Tietê), e pelas Ruas Major Paladino, Rua Tenente João Salustiano Lira e Rua Ministro Silva Maia, próximo à Ponte dos Remédios.	-23.520809	-46.744338	0	2014-12-07 16:16:46.26325	\N
3543	Unidades Habitacionais - Vitotoma Mastroroza / lote 03	Localizado entre os limites das Vias Avenida Arq. Vilanova Artigas, Faixas de Transmissão da Eletropaulo, CTEEP  e Rua Vitotoma Mastroroza.	-23.591718	-46.494748	0	2014-12-07 16:16:46.279995	\N
3544	Unidades Habitacionais - Lidiane / lote 14	Localizada entre os limites das Vias Rua Sampaio Corrêa, Rua Eulálio da Costa Carvalho.	-23.510100	-46.676680	0	2014-12-07 16:16:46.296941	\N
3545	Unidades Habitacionais - Bamburral / lote 14	Localizada entre os limites das Vias Rua Bamburral, Rua Silveirânia e Rua Árvore de São Tomás.	-23.411346	-46.760511	0	2014-12-07 16:16:46.314392	\N
3546	Unidades Habitacionais - Viela da Paz - Condominio B C e E	Viela da Paz: Limites - Ruas Sebastião Falconi, Diogo Pereira, Faustino da Silva, Dr. Rabelo do Amaral, Av. João Caiaffa, Francisco Fernandes. 	-23.613014	-46.748753	0	2014-12-07 16:16:46.330955	\N
3547	Unidades Habitacioansi - Heliópolis / Sabesp 2 / 1ª Etapa	Área da Sabesp 2: Localizada dentro da ETE-ABC, entre a Av. Almirante Delamare e Córrego dos Meninos.	-23.598417	-46.583053	0	2014-12-07 16:16:46.348135	\N
3548	Heliópolis G / Condominio B	Gleba G:  entre as Ruas Comandante Taylor e Rua Maciel Parente. 	-23.600403	-46.596085	0	2014-12-07 16:16:46.365111	\N
3549	Unidades Habitacionais - Real Parque 2ª Etapa	Real Parque: Localizada entre os limites das vias Rua Paulo Bourroul,  Rua César Vallejo,  Barão  de  Castro  Lima,  Rua  Conde  de  Itaguaí,  e  lotes particulares, próximo a Marginal Pinheiros.	-23.608370	-46.701991	0	2014-12-07 16:16:46.382248	\N
3550	Mirassol	R. Coração de Maçã s/nº x R. Conto de Areia	-23.581829	-46.401213	0	2014-12-07 16:16:46.399051	\N
3551	Caraguatatuba	R. Amor de Índio x R. Domingos Rubino	-23.553650	-46.431849	0	2014-12-07 16:16:46.416147	\N
3552	Ribeirão Preto	R. Ferreirópolis, 07	-23.670825	-46.760354	0	2014-12-07 16:16:46.433553	\N
3553	Pirassununga	R. Conj. Sítio Conceição, 01 x R. Pequeno Romance	-23.579062	-46.395294	0	2014-12-07 16:16:46.450425	\N
3554	Atibaia I, II e III	R. Antonio de França e Silva x R. Alberto Lazari x R. Clara Petrela	-23.622565	-46.502973	0	2014-12-07 16:16:46.469693	\N
3555	Itariri	R. Aviadora Anésia Pinheiro Machado x Rua Osni Pereira Duarte	-23.677877	-46.792182	0	2014-12-07 16:16:46.486783	\N
3556	Lorena	R. Aviadora Anésia Pinheiro Machado x Rua Osni Pereira Duarte	-23.677877	-46.792182	0	2014-12-07 16:16:46.503778	\N
3557	Franca	Av. Eng. Antonio Eiras Garcia x R. Pe. Marçal Rodrigues	-23.604489	-46.789435	0	2014-12-07 16:16:46.520553	\N
3558	Araraquara	R. Gingadinho x R. Tajal x R. Nicolo di Pietro	-23.680862	-46.792162	0	2014-12-07 16:16:46.537304	\N
3559	Botucatu	Rua Pedro de Campos Tourinho 	-23.520492	-46.425943	0	2014-12-07 16:16:46.554311	\N
3560	São Sebastião	R. Francesco Calegari x R. Frei Antonio Faggiano, alt. R. Cole Porter	-23.552330	-46.433097	0	2014-12-07 16:16:46.5711	\N
3561	Estevão Baião	Estevão Baião: Rua Estevão Baião x Viaza. Próximo a Av. Jornalista Roberto Marinho.	-23.630300	-46.669286	0	2014-12-07 16:16:46.588749	\N
3562	São Francisco Lageado	\N	0	0	0	2014-12-07 16:16:46.605717	\N
3563	Dom José 1	\N	0	0	0	2014-12-07 16:16:46.623112	\N
3564	Emccamp - America do Sul	Rua Estrada do Barro Branco, s/n	0	0	0	2014-12-07 16:16:46.640036	\N
3565	Cury - Parque São Rafael I	Rua José de Assis Alvarenga	0	0	0	2014-12-07 16:16:46.656767	\N
3566	Cury - Parque São Rafael II	\N	0	0	0	2014-12-07 16:16:46.674178	\N
3567	Sugoi - Bento Guelfi	Avenida Bento Guelfi, 1800 	-23.610781	-46.425722	0	2014-12-07 16:16:46.69043	\N
3568	El Global - Badra DERSA	Rua Ilha do Frade, Rua Argentina e Rua Argélia, bairro de Perus	-23.406192	-46.746733	0	2014-12-07 16:16:46.707571	\N
3569	Emccamp - Espanha	Rua Salvador Dali, 235	-23.709327	-46.652963	0	2014-12-07 16:16:46.724218	\N
3570	Tech Casa - Alexandre Archipenko	Rua Alexandre Archipenko, 18 	-23.634863	-46.737211	0	2014-12-07 16:16:46.743114	\N
3571	ATUA - Jardim Imperador	\N	0	0	0	2014-12-07 16:16:46.761256	\N
3572	Tenda - Jardim Angela	Rua Comendador Antunes dos Santos e Rua Joaquim Monteiro do Rego	-23.673217	-46.760554	0	2014-12-07 16:16:46.779082	\N
3573	ATUA - Belenzinho	Rua Intendência, 177 	-23.535707	-46.595112	0	2014-12-07 16:16:46.798923	\N
3574	ATUA - In São Paulo Vila Prudente	Rua Ibitirama x Av Dr Francisco Mesquita 	-23.598630	-46.577630	0	2014-12-07 16:16:46.815817	\N
3575	Econ - Futura 2 e Futura 3	Rua Nebulosas, 750 	-23.611783	-46.464502	0	2014-12-07 16:16:46.833899	\N
3576	Econ - Pirituba	Rua Brigadeiro Godinho dos Santos s/n - Vila Boaçava 	-23.479408	-46.744221	0	2014-12-07 16:16:46.850859	\N
3577	Econ - Radial	Estrada de Itaquera s/n	0	0	0	2014-12-07 16:16:46.868385	\N
3578	Bueno Netto - Jardins da Barra 2	Avenida Marques de São Vicente 	0	0	0	2014-12-07 16:16:46.885436	\N
3579	Bueno Netto - Telefônica	\N	0	0	0	2014-12-07 16:16:46.903351	\N
3580	Cury - Parque São Rafael III	\N	0	0	0	2014-12-07 16:16:46.924026	\N
3581	Cury - Candido Sampaio	Avenida Deputado Cantídio Sampaio 	-23.454720	-46.695453	0	2014-12-07 16:16:46.941088	\N
3582	Cury - Penha	Rua Henrique Casela 	-23.558196	-46.569783	0	2014-12-07 16:16:46.958317	\N
3583	Tenda - Cruz do Espírito Santo	\N	0	0	0	2014-12-07 16:16:46.975723	\N
3584	UNO - Parque São Rafael	Av. Sapopemba, 23.000	-23.622834	-46.443822	0	2014-12-07 16:16:46.992777	\N
3585	UNO - Nova Perus	Rua Mogeiro	-23.403675	-46.761433	0	2014-12-07 16:16:47.010746	\N
3586	Antonia Maria Nigro - Bella Vista	\N	0	0	0	2014-12-07 16:16:47.027153	\N
3587	Parque Raposo - Reserva Raposo	Rodovia Raposo Tavares km 18,5 	0	0	0	2014-12-07 16:16:47.045283	\N
3588	Americana	Rua Alfredo Ricci, c/ Av. Nagib Farah Maluf	-23.542707	-46.434910	0	2014-12-07 16:16:47.062772	\N
3589	Amparo	Av. Atlântico Meridional	0	0	0	2014-12-07 16:16:47.080035	\N
3590	Catanduva	Rua João Batista Conti x Rua Guilherme Valença	-23.551151	-46.441388	0	2014-12-07 16:16:47.098007	\N
3591	Porto Feliz A	Rua Nova do tuparoquera, s/nº	-23.661312	-46.740048	0	2014-12-07 16:16:47.115059	\N
3592	Porto Feliz B	Rua Nova do tuparoquera, s/nº	-23.661312	-46.740048	0	2014-12-07 16:16:47.133054	\N
3593	Tupã	Rua Raulino Galdino da Silva,s/nº 	-23.473387	-46.701097	0	2014-12-07 16:16:47.149606	\N
3594	Bauru A e B	Rua Jeronimo Pedroso Barros fundos com a atual Rua Francisco de Souto Maior Lotes A e B e parte do lote 330 da Quadra C	-23.525206	-46.392315	0	2014-12-07 16:16:47.167614	\N
3595	Lageado A, B e C	Rua Jeronimo Pedroso Barros fundos com a atual Rua Francisco de Souto Maior Lotes A e B e parte do lote 330 da Quadra C	-23.525206	-46.392316	0	2014-12-07 16:16:47.18519	\N
3596	Sumaré - Elza Guimarães	Rua Elza Guimarães, 277	-23.468527	-46.651372	0	2014-12-07 16:16:47.202431	\N
3597	São Carlos A e B	Av. Nordestina e Sansão Castelo Branco e R. DomingosD'lorio e Pascoal D'lorio  	-23.538781	-46.414471	0	2014-12-07 16:16:47.220155	\N
3598	Heliópolis / Sabesp 2 / 2ª Etapa	Área da Sabesp 2: Localizada dentro da ETE-ABC, entre a Av. Almirante Delamare e Córrego dos Meninos.	-23.615083	-46.583053	0	2014-12-07 16:16:47.237406	\N
3599	Santa Sofia II	\N	0	0	0	2014-12-07 16:16:47.254999	\N
3600	Dom José 2	\N	0	0	0	2014-12-07 16:16:47.272811	\N
3601	Alexius Jafet - Lote A	\N	0	0	0	2014-12-07 16:16:47.289844	\N
3602	Alexius Jafet - Lote B	\N	0	0	0	2014-12-07 16:16:47.30768	\N
3603	Alexius Jafet - Lote C	\N	0	0	0	2014-12-07 16:16:47.32464	\N
3604	Cidade Tiradentes 1 CHIS - Residencial Lote 1	\N	0	0	0	2014-12-07 16:16:47.342525	\N
3605	Cidade Tiradentes 1 CHIS - Residencial Lote 2	\N	0	0	0	2014-12-07 16:16:47.359762	\N
3606	Cidade Tiradentes 1 CHIS - Residencial Lote 3	\N	0	0	0	2014-12-07 16:16:47.37735	\N
3607	Cidade Tiradentes 1 CHIS - Residencial Lote 4	\N	0	0	0	2014-12-07 16:16:47.397425	\N
3608	Barra do Jacaré - Lote 1	\N	0	0	0	2014-12-07 16:16:47.415105	\N
3609	Barra do Jacaré - Lote 2	\N	0	0	0	2014-12-07 16:16:47.433187	\N
3610	Jabuticabeiras, Condomínio Residencial	\N	0	0	0	2014-12-07 16:16:47.450228	\N
3611	Wzarzur - Movimento pelo Direito a Moradia	\N	0	0	0	2014-12-07 16:16:47.46953	\N
3612	Avenida Presidente Wilson/Vila Carioca	Av. Presidente Wilson, 5.330	-23.597060	-46.587604	0	2014-12-07 16:16:47.512047	\N
3613	Agudos A e B	Rua Serra Verde	0	0	0	2014-12-07 16:16:47.5779	\N
3614	Chafariz de Pedra - Jd da Conquista	Rua Chafariz de Pedra X Rua Pedro Leme X Rua Antonio Pavâo	-23.602837	-46.453550	0	2014-12-07 16:16:47.625168	\N
3615	Augusto Amaral	R. Dr. Augusto Amaral, 94	-23.475279	-46.691160	0	2014-12-07 16:16:47.646957	\N
3616	Arujá - Vila Curuçá II - Lote 16	Rua Osório Franco Vilhena s/n	-23.507991	-46.418723	0	2014-12-07 16:16:47.66889	\N
3617	Santa Isabel - Vila Curuçá III Lotes 27 e 28	Rua Osório Franco Vilhena s/n	-23.507991	-46.418723	0	2014-12-07 16:16:47.689186	\N
3618	Bresser XIV	Rua Visconde de Parnaíba	-23.544633	-46.605628	0	2014-12-07 16:16:47.709763	\N
3619	Bresser VI	Rua Visconde de Parnaíba	-23.544633	-46.605628	0	2014-12-07 16:16:47.730793	\N
3620	Lord Hotel - R. das Palmeiras 58	R. das Palmeiras 58	-23.538278	-46.649856	0	2014-12-07 16:16:47.750583	\N
3621	Área 26	Rua Australia 02	-23.673099	-46.609237	0	2014-12-07 16:16:47.769676	\N
3622	Área 27	Rua Hildebrando Siqueira s/n e Rua Cinco de Outubro s/n	-23.661227	-46.639471	0	2014-12-07 16:16:47.78829	\N
3623	Área 33	Av. Eng. Armando de Arruda Pereira 3284 x Rua Astrolabio\nAv. Eng. Armando de Arruda Pereira s/n	-23.653615	-46.637052	0	2014-12-07 16:16:47.805975	\N
3624	Área 34	Av. Eng. Armando de Arruda Perreira s/n (junto ao 3744)\nAv. Eng. Armando de Arruda Pereira s/n (junto ao 3796)	-23.657604	-46.636132	0	2014-12-07 16:16:47.824507	\N
3625	Área 36	Av. Muzambinho s/n x Rua Onofre Silveira	-23.660800	-46.639172	0	2014-12-07 16:16:47.843024	\N
3626	Área 37	Rua Onofre Silveira s/n	-23.659570	-46.639487	0	2014-12-07 16:16:47.861122	\N
3627	Área 38	Rua Hildebranco Siqueira 455	-23.660595	-46.640091	0	2014-12-07 16:16:47.879675	\N
3628	Área 41	Rua Hildebrando Siqueira 488 e s/n\nRua Hildebrando Siqueira 454	-23.660530	-46.639997	0	2014-12-07 16:16:47.897206	\N
3629	Área 43	Rua Agapito Jose da Silva s/n x Rua Natalino Amaro Teixeira	-23.661586	-46.636784	0	2014-12-07 16:16:47.915315	\N
3630	Área 44	Rua Déborah Paschoal s/n x Rua Wilson Kawani\nAv. Eng. Armando de Arruda Pereira s/n e 4665	-23.665775	-46.636573	0	2014-12-07 16:16:47.933992	\N
3631	Área 45	Rua Hildebrando Siqueira 523/537/541/s/n X Av. Muzambinho	-23.661174	-46.639517	0	2014-12-07 16:16:47.952282	\N
3632	João Cabanas - Cantazaro (Área SVMA)	\N	0	0	0	2014-12-07 16:16:47.981353	\N
3633	João Caiafa / Viela da Paz - Condominio D	Rua João Caiaffa com Rua Francisco Fernandes	-23.611889	-46.748930	0	2014-12-07 16:16:48.004748	\N
3634	Diogo Pereira / Viela da Paz - Condominio A	Rua Diogo Pereira com Rua Faustino da Silva	-23.613756	-46.748988	0	2014-12-07 16:16:48.026837	\N
3635	Água Podre	Ruas Dr. Laudelino de Abreu, Francisco da Mata, Laudelino Gonçalves, por lotes particulares e pela própria favela. 	-23.572106	-46.756280	0	2014-12-07 16:16:48.046888	\N
3636	Domenico Martinelli	Limites: Ruas Irineu Salvador Pinto, Av. Domênico Martinelli e Rua Maria C. Vivone (projetada). 	-23.579171	-46.762171	0	2014-12-07 16:16:48.067443	\N
3637	Luiz Migliano/ Viela da Paz (desapropriação)	Avenida Doutor Luiz Migliano	-23.614249	-46.742461	0	2014-12-07 16:16:48.087279	\N
3638	Bambural / lote 14	Rua do Bamburral	-23.409937	-46.760569	0	2014-12-07 16:16:48.106852	\N
3639	Osório Franco Vilhena Lotes 17	R. Osório Franco Vilhena x Av. Dama Entre Verdes	-23.509173	-46.418318	0	2014-12-07 16:16:48.128633	\N
3640	Osório Franco Vilhena Lotes 18	R. Osório Franco Vilhena, próx. Av. Dama Entre Verdes	-23.509173	-46.418319	0	2014-12-07 16:16:48.149589	\N
3641	Parque Savoy lt 53	Av. Osvaldo Valle Cordeiro, s/nº, próx. Av. Alziro Zarur	-23.560607	-46.483114	0	2014-12-07 16:16:48.170166	\N
3642	Parque Savoy lt 54	Av. Osvaldo Valle Cordeiro, s/nº, próx. Av. Alziro Zarur	-23.560607	-46.483115	0	2014-12-07 16:16:48.191195	\N
3643	Araçarana	R. Tibúrcio de Souza, 1.104 e 1.106	-23.506766	-46.395923	0	2014-12-07 16:16:48.211614	\N
3644	Antonio Sampaio	Av. Comte Antônio Paiva Sampaio x R. Manuel de Moura	-23.474563	-46.595491	0	2014-12-07 16:16:48.232937	\N
3645	Itaim Utupiru	Av. Itaim x R. Cachoeira Utupiru x R. Cachoeira Escaramuça	-23.491298	-46.391708	0	2014-12-07 16:16:48.278429	\N
3646	Igarapé Mirim	R. Igarapé Mirim x R. Prof. Wilson Reis Santos 	-23.536168	-46.407457	0	2014-12-07 16:16:48.300558	\N
3647	Pedro Brasil (Cohab) (Cabuçu de Baixo 12)	R. Ver. Pedro Brasil Bandecchi e Av. Parada Pinto	-23.470560	-46.653529	0	2014-12-07 16:16:48.324308	\N
3648	Rosária	Av. Rosária x Pça. José C. da Silva Caxambu	-23.503767	-46.432967	0	2014-12-07 16:16:48.344544	\N
3649	Rio Grande	Av. Visconde do Rio Grande, 480	-23.680636	-46.774776	0	2014-12-07 16:16:48.364974	\N
3650	Floriza	Av. Cipriano Rodrigues x R. Cândido Rodrigues x R. Floriza	-23.576140	-46.523771	0	2014-12-07 16:16:48.384636	\N
3651	Pinheirinho - Bento Guelfi (Gleba) LOTE 5	Av. Bento Guelfi, 2860	-23.617925	-46.423427	0	2014-12-07 16:16:48.403344	\N
3652	João Gomes	Av. Raimundo Pereira de Magalhães, 13.255	-23.426823	-46.724435	0	2014-12-07 16:16:48.422661	\N
3653	Rosa Mendes	Av. São Miguel x R. Rosa Mendes	-23.505556	-46.491733	0	2014-12-07 16:16:48.440424	\N
3654	Abrahão Calux	Av. Presidente Tancredo Neves 1.100	-23.612141	-46.607781	0	2014-12-07 16:16:48.460084	\N
3655	Itapecerica 23.850	Estrada de Itapecerica da Serra, 23.850	-23.667440	-46.657767	0	2014-12-07 16:16:48.481652	\N
3656	Forte do Ribeira	R. Forte da Ribeira e Av. Forte do Leme	-23.603578	-46.467783	0	2014-12-07 16:16:48.500493	\N
3657	Phobus - Forte do Rio Branco	R. Forte do Rio Branco x R. Titânia	-23.607348	-46.465940	0	2014-12-07 16:16:48.519178	\N
3658	André de Almeida	R. André de Almeida, 2.091	-23.596172	-46.475360	0	2014-12-07 16:16:48.540878	\N
3659	Isidoro Dias	\N	0	0	0	2014-12-07 16:16:48.574263	\N
3660	Vemag	Rua Guamiranga X Rua Vemag	-23.596540	-46.584738	0	2014-12-07 16:16:48.595738	\N
3661	Guamiranga /Metro	Rua Guamiranga, 522	-23.591885	-46.588398	0	2014-12-07 16:16:48.614761	\N
3662	Marechal Tito / Manuel Bueno (Água Vermelha 2)	R. Manuel Bueno da Fonseca, s/nº, próx. Av. Mal. Tito	-23.493426	-46.389301	0	2014-12-07 16:16:48.635422	\N
3663	Direitos Humanos	Av. Dr. Francisco Ranieri, 681	-23.478102	-46.644350	0	2014-12-07 16:16:48.661215	\N
3664	Ed. Mauá	R. Mauá 342	-23.535085	-46.636492	0	2014-12-07 16:16:48.684177	\N
3665	Ed. Prestes Maia	R. Prestes Maia x Brigadeiro Tobias	-23.538864	-46.634973	0	2014-12-07 16:16:48.703233	\N
3666	Canal Cocaia	ESTRADA CANAL COCAIA COM RUA SANTA CLARA	0	0	0	2014-12-07 16:16:48.723108	\N
3667	Ed. Plinio Salgado	R. da Mooca 416-418-424	0	0	0	2014-12-07 16:16:48.74411	\N
3668	Ed. Santa Leonor	R. Sete de Abril 176	0	0	0	2014-12-07 16:16:48.767993	\N
3669	Ed. Paulo Autran	Praça da República 242	0	0	0	2014-12-07 16:16:48.788753	\N
3670	Ed. Gregori Warchavchik	R. Quintino Bocaiuva 307	0	0	0	2014-12-07 16:16:48.809826	\N
3671	Ed. Luiz Aranha	R. Sete de Abril 351-353-355-361-365	0	0	0	2014-12-07 16:16:48.830045	\N
3672	Ed. Di Cavalcanti	Av. São João 587-597-601	0	0	0	2014-12-07 16:16:48.852347	\N
3673	Ed. Menotti Del Picchia	R. José Bonifácio 367-379-383	0	0	0	2014-12-07 16:16:48.87265	\N
3674	Ed. Paes de Barros	 R. Cel. Xavier de Toledo 150-156	0	0	0	2014-12-07 16:16:48.893408	\N
3675	Ed. Grão Pará	Praça da Bandeira 31-39-47	0	0	0	2014-12-07 16:16:48.912273	\N
3676	Ed. Palacete Martins Costa	Av. Ipiranga 1064	0	0	0	2014-12-07 16:16:48.93393	\N
3677	Arte Palácio	Av. São João 407	0	0	0	2014-12-07 16:16:48.952859	\N
3678	Ed. Sérgio Milliet	R. Capitão Salomão 49-55-59	0	0	0	2014-12-07 16:16:48.973045	\N
3679	Ed. Herrerias	Av. São João 1492	0	0	0	2014-12-07 16:16:48.992389	\N
3680	Ed. Virginio Pasini	Praça Princesa Isabel 87	0	0	0	2014-12-07 16:16:49.012384	\N
3681	Ed. Tácito de Almeida	R. Assunção 104-112-116-120	0	0	0	2014-12-07 16:16:49.031124	\N
3682	Ed. John Graz	R. Dom José de Barros 329-333-337	0	0	0	2014-12-07 16:16:49.05037	\N
3683	Ed. Manoel Bandeira	R. Dona Maria Paula 177-181	0	0	0	2014-12-07 16:16:49.068637	\N
3684	Ed. Lasar Segall	R. Santa Ifigênia 73-75	0	0	0	2014-12-07 16:16:49.088172	\N
3685	Ed. Ferrignac	Av. São João 247-253	0	0	0	2014-12-07 16:16:49.10709	\N
3686	Ed. Salomone	Av. Duque de Caxias 401	0	0	0	2014-12-07 16:16:49.12522	\N
3687	Ed. Vilanova Artigas	 R. Cons. Furtado 90-96	0	0	0	2014-12-07 16:16:49.148712	\N
3688	Ed. República	Praça da República 250	0	0	0	2014-12-07 16:16:49.168733	\N
3689	Ed. Arcangelo Ianelli	R. Doutor Penaforte Mendes 30	0	0	0	2014-12-07 16:16:49.187709	\N
3690	Ed. Oswald de Andrade	R. Cons. Carrão 202	0	0	0	2014-12-07 16:16:49.20747	\N
3691	Ed. Roberto Burle Marx	R. Cons. Crispiniano 140	0	0	0	2014-12-07 16:16:49.227258	\N
3692	Ed. Garcia	R. dos Franceses 230	0	0	0	2014-12-07 16:16:49.246431	\N
3693	Ed. Adoniran Barbosa	R. São Francisco 77-81-85	0	0	0	2014-12-07 16:16:49.265893	\N
3694	Ed. Paulo Vanzolini	R. Aurora 519	0	0	0	2014-12-07 16:16:49.285076	\N
3695	Ed. da Misericordia	Largo da Misericórdia 34-36	0	0	0	2014-12-07 16:16:49.304211	\N
3696	Ed. Demônios da Garoa	R. Aurora 424	0	0	0	2014-12-07 16:16:49.323249	\N
3697	Ed. Almeida Junior	R. Conselheiro Nebias 314	0	0	0	2014-12-07 16:16:49.341104	\N
3698	Ed. Anita Malfati	 Av. Ipiranga 908	0	0	0	2014-12-07 16:16:49.361268	\N
3699	Ed. São Manoel	R. Marconi 138	0	0	0	2014-12-07 16:16:49.380208	\N
3700	Ed. Noite Ilustrada	R. dos Lavapés 879	0	0	0	2014-12-07 16:16:49.399176	\N
3701	Joaquim Leal II	\N	0	0	0	2014-12-07 16:16:49.421363	\N
3702	Sacomã E	\N	0	0	0	2014-12-07 16:16:49.442412	\N
3703	Campo Belo A B C	\N	0	0	0	2014-12-07 16:16:49.466317	\N
3704	Área 4	Av.Tulio Teodoro de Campos s/n e Rua Tito Livio	0	0	0	2014-12-07 16:16:49.488313	\N
3705	Área 5	Rua Durval Fontoura de Castro s/n\nRua Durval Fontoura de Castro 285	0	0	0	2014-12-07 16:16:49.507627	\N
3706	Área 6	Rua Ipaobi 68	0	0	0	2014-12-07 16:16:49.526946	\N
3707	Área 8	Rua Rishin Matsuda 235\nAv.Estevao Mendonça s/n\nRua dos Democratas 975 ap.61\nRua Rishin Matsuda 201 x Rua Prof. Francisco Emydio da Fonseca Telles	0	0	0	2014-12-07 16:16:49.547119	\N
3708	Área 9	Rua Nelson Washington Pereira 410 x Av. Estevão Mendonça 118	0	0	0	2014-12-07 16:16:49.56666	\N
3709	Área 11	Av. João Barreto de Menezes 593	0	0	0	2014-12-07 16:16:49.586772	\N
3710	Área 14	Rua Navarra 105\nRua Navarra 62, 87, 91\nRua Navarra 36\nRua Franklin Magalhaes 51	0	0	0	2014-12-07 16:16:49.605901	\N
3711	Área 17	Rua Tenente Cel. Antonio Braga 14, 18, 22, 44	0	0	0	2014-12-07 16:16:49.627894	\N
3712	Área 19	Rua Cidade de Bagda 427 Vl Mira\nRua Cidade de Bagda 449 Vl Mira	0	0	0	2014-12-07 16:16:49.65162	\N
3713	Área 20	Rua Brasilina Fonseca 320 x Rua Afonso XIII	0	0	0	2014-12-07 16:16:49.67071	\N
3714	Área 21	Rua Luiza Alvares 347 - Pça do Retorno cs.6\nRua Luiza Alvares 344 - Pça do Retorno cs.4\nRua Luiza Alvares 346 (atual 357)\nRua Luiza Alvares 347	0	0	0	2014-12-07 16:16:49.690533	\N
3715	Área 25	Rua das Cruzadas 8/8A\nRua das Cruzadas 43/45\nRua das Cruzadas 07\nRua Australia 210 x Rua dos Guassatungas 16A/26\nRua das Cruzadas 06	0	0	0	2014-12-07 16:16:49.709327	\N
3716	Área 28	Rua das Rolinhas 319 x Rua do Céu	0	0	0	2014-12-07 16:16:49.727713	\N
3717	Área 29	Rua do Ceu 124\nRua do Ceu s/n	0	0	0	2014-12-07 16:16:49.746837	\N
3718	Área 30	Rua do Ceu 269/271/275/277\nRua do Ceu 266\nRua do Ceu 250/259\nRua do Ceu 291	0	0	0	2014-12-07 16:16:49.802204	\N
3719	Área 31	Av. Barro Branco 770 x Rua Lagoa dos Salqueiros\nRua das Joias s/n (junto ao 256F)	0	0	0	2014-12-07 16:16:49.821044	\N
3720	Área 35	Av. Eng. Armando de Arruda Perreira s/n x Rua Astrolabio\nAv. Eng. Armando de Arruda Pereira s/n/3960/3950/3928/3924 e Rua Henrique da Silva Fontes 7/9 e Rua Euterpe 13F/86	0	0	0	2014-12-07 16:16:49.840996	\N
3721	Área 39	Rua Hildebranco Siqueira 344\nRua Hildebranco Siqueira 260\nRua Hildebranco Siqueira 284	0	0	0	2014-12-07 16:16:49.860001	\N
3722	Área 40	Rua Charles Hoyt 155 x Rua Hildebrando Siqueira\nRua Charles Hoyt s/n	0	0	0	2014-12-07 16:16:49.878785	\N
3723	Área 47	Rua Conception Arenal s/n Vl Sta Catarina	0	0	0	2014-12-07 16:16:49.897764	\N
3724	Área 48	Rua Conception Arenal 164 Vl Sta Catarina	0	0	0	2014-12-07 16:16:49.91713	\N
3725	Área 60 (CDHU)	Rua Cidade de Bagda 131, 155, 908, 141, 137, 121, 125\nRua Conception Arenal 903/903FDS/903B	0	0	0	2014-12-07 16:16:49.938601	\N
3726	Área 61 (CDHU)	Rua Cidade de Bagda  s/n, 162, 192, 126, 198, 140\nRua Conception Arenal 49, 57	0	0	0	2014-12-07 16:16:49.961419	\N
3727	Área 62 (CDHU)	Rua Conception Arenal 93, 360, 352\nRua Brasilina Fonseca 182, 202, 192, 178	0	0	0	2014-12-07 16:16:49.981035	\N
3728	Área 64 (CDHU)	Rua Dr Deodoro de Campos 232, 209, 226, 250, 242\nRua Alcides de Campos 96, 100, 78, 86, 98	0	0	0	2014-12-07 16:16:50.001586	\N
3729	Área 65 (CDHU)	Av Eng Armando de Arruda Pereira 4555	0	0	0	2014-12-07 16:16:50.027415	\N
3730	Área 66 (CDHU)	Rua Guaipeva 35, 21, 59, 43, 49, 53\nRua Simao Rocha 103, 115, 123, 89\nRua Rodolfo Garcia 68, 72, 74\nRua Elmano Sadino 32, 152, 30, 1	0	0	0	2014-12-07 16:16:50.047098	\N
3731	Terreno A - Itaim Paulista (Água Vermelha 2)	Avenida Academia de São Paulo	0	0	0	2014-12-07 16:16:50.066216	\N
3732	Terreno B - Itaim Paulista (Água Vermelha 2)	Rua Antonio João de Medeiros	0	0	0	2014-12-07 16:16:50.089175	\N
3733	Terreno D - Itaim Paulista (Água Vermelha 2)	Rua Osório Franco Vilhena	0	0	0	2014-12-07 16:16:50.113357	\N
3734	Baixada Santista (Tiquatira 2)	Rua Baixada Santista	0	0	0	2014-12-07 16:16:50.133942	\N
3735	França Velho (Tiquatira 2)	Rua São Teodoro	0	0	0	2014-12-07 16:16:50.152806	\N
3736	Campo das Pitangueiras (Tiquatira 2)	Rua Campo das Pitangueiras	0	0	0	2014-12-07 16:16:50.172477	\N
3737	Nelson de Senna (Cordeiro 1)	Rua Nelson de Senna	0	0	0	2014-12-07 16:16:50.191296	\N
3738	Adelino da Fontoura (Cordeiro 1)	Rua Adelino da Fontoura	0	0	0	2014-12-07 16:16:50.209758	\N
3739	Contos Gauchescos (Cordeiro 1)	Rua Adelino da Fontoura	0	0	0	2014-12-07 16:16:50.229696	\N
3740	Clenio Wanderley (Oratório 1)	Rua Clenio Wanderley	0	0	0	2014-12-07 16:16:50.250233	\N
3741	Rosas de Maio (Oratório 1)	Rua Rosas de Maio	0	0	0	2014-12-07 16:16:50.271164	\N
3742	Reynaldo S. Furlanetto (Morro do S4)	Rua Reynaldo Schwindt Furlanetto	0	0	0	2014-12-07 16:16:50.294151	\N
3743	Gregório Allegri (Morro do S4)	Rua Gregório Allegri	0	0	0	2014-12-07 16:16:50.312958	\N
3744	Caboclinho (Pirajussara 7)	Estrada dos Mirandas	0	0	0	2014-12-07 16:16:50.332088	\N
3745	Estrada dos Mirandas I (Pirajussara 7)	Estrada dos Mirandas	0	0	0	2014-12-07 16:16:50.352044	\N
3746	Boris Davidoff (Pirajussara 5)	Rua Boris Davidoff	0	0	0	2014-12-07 16:16:50.371126	\N
3747	Januário Zingaro (Pirajussara 5)	Rua Januário Zíngaro	0	0	0	2014-12-07 16:16:50.393812	\N
3748	Conrado de Deo (Pirajussara 5)	Rua Professor Conrado de Deo	0	0	0	2014-12-07 16:16:50.413148	\N
3749	Afonso Lopes (Cabuçu de Baixo 5)	Rua Afonso Lopes Vieira	0	0	0	2014-12-07 16:16:50.432086	\N
3750	Penha Brasil (Cabuçu de Baixo 5)	Avenida General Penha Brasil	0	0	0	2014-12-07 16:16:50.451148	\N
3942	CIDADE KEMEL - PARTE DA GLEBA II	\N	0	0	0	2014-12-07 16:16:56.140988	\N
3751	Encruzilhada do Sul (Cabuçu de Baixo 5)	Rua Encruzilhada do Sul	0	0	0	2014-12-07 16:16:50.475101	\N
3752	Abel Marciano (Jardim Japão 1)	Rua Abel Marciano de Oliveira	0	0	0	2014-12-07 16:16:50.498169	\N
3753	Taiaçupeba (Oratório 1)	Rua Taiaçupeba	0	0	0	2014-12-07 16:16:50.517795	\N
3754	Anchieta (Meninos 1)	Rua Rizieri Negrini	0	0	0	2014-12-07 16:16:50.53662	\N
3755	Francisco Rossano (Oratório 1)	Avenida do Estado	0	0	0	2014-12-07 16:16:50.556225	\N
3756	Aurea Lejeune (Água Espraiada 2+5)	Rua Aurea Lejeune	0	0	0	2014-12-07 16:16:50.574995	\N
3757	Virginia Torezin Forte	Rua Virginia Torezin Forte	0	0	0	2014-12-07 16:16:50.594175	\N
3758	Henri Martin (Morro do S4)	Rua Henri Martin	0	0	0	2014-12-07 16:16:50.613176	\N
3759	Hebert Smith (processo em atl)	Rua Herbert Smith	0	0	0	2014-12-07 16:16:50.63164	\N
3760	Antonio de França (processo em atl)	Rua Antonio de França e Silva	0	0	0	2014-12-07 16:16:50.651224	\N
3761	Raul dos Santos (Pirajussara 5)	Rua Januário Zíngaro	0	0	0	2014-12-07 16:16:50.670748	\N
3762	Cavalo Branco (desap.) / MCMV	EHIS - Cavalo Branco - Área A - AV. DOS FUNCIONÁRIOS PÚLICOS, RUA MARIA TREVISANI	0	0	0	2014-12-07 16:16:50.691635	\N
3763	Vargem Grande (desap.) / MCMV	EHIS - VARGEM GRANDE - ESTRADA DA COLÔNIA COM A RUA DOIS 	0	0	0	2014-12-07 16:16:50.716752	\N
3764	Maria de Barros Teixeira	RUA MARIA DE BARROS CARVALHO, RUA ARMANDO RODRIGUES TAVARES, AVENIDA PROFESSOR MÁRIO MAZAGÃO E RUA LUÍS TEIXEIRA DE OLIVEIRA 	0	0	0	2014-12-07 16:16:50.736229	\N
3765	Três Marias	RUA DAS TRÊS MARIAS COM RUA DOUTOR RENATO LOCCHI	0	0	0	2014-12-07 16:16:50.754894	\N
3766	Luís Rota	RUA LUIZ ROTTA COM A RUA NARCISIO GUERRA	0	0	0	2014-12-07 16:16:50.776559	\N
3767	Sen.Teotônio Vilela	AVENIDA SENADOR TEOTÔNIO VILELA, ALTURA 9670	0	0	0	2014-12-07 16:16:50.795759	\N
3768	Pastoral	RUA PASTORAL COM RUA SARGENTO SÉRGIO VITOR BULLA	0	0	0	2014-12-07 16:16:50.814626	\N
3769	Adelina Abranches	RUA ADELINA ABRANCHES COM RUA FERNANDO ABASCAL E RUA CESARE MARTINENGO	0	0	0	2014-12-07 16:16:50.835386	\N
3770	Agenor Klaussner	\N	0	0	0	2014-12-07 16:16:50.858556	\N
3771	Cisma do Destino	RUA CISMA DO DESTINO COM A RUA PEQUENA CANÇÃO	0	0	0	2014-12-07 16:16:50.877923	\N
3772	Morro dos Macacos	EHIS - MORRO DOS MACACOS	0	0	0	2014-12-07 16:16:50.89721	\N
3773	Alziro Pinheiro Magalhães	\N	0	0	0	2014-12-07 16:16:50.916876	\N
3774	Paulo Guilguer Reimberg	AVENIDA PAULO GUILGUER REIMBERG COM RUA SEM DENOMINAÇÃO 	0	0	0	2014-12-07 16:16:50.944937	\N
3775	João Cabanas - Rua Alziro Pinheiro Magalhães	RUA ALZIRO PINHEIRO MAGALHÃES 	0	0	0	2014-12-07 16:16:50.970037	\N
3776	Cachoeira de Paulo Afonso	Rua Cachoeira de Paulo Afonso	0	0	0	2014-12-07 16:16:50.990545	\N
3777	Ponte Baixa	\N	0	0	0	2014-12-07 16:16:51.012929	\N
3778	Zavuvus	\N	0	0	0	2014-12-07 16:16:51.037115	\N
3779	Aricanduva	\N	0	0	0	2014-12-07 16:16:51.061126	\N
3780	Córrego Cordeiro	\N	0	0	0	2014-12-07 16:16:51.082904	\N
3781	Radial Leste - Prolongamento	\N	0	0	0	2014-12-07 16:16:51.108352	\N
3782	Córrego Paciência	\N	0	0	0	2014-12-07 16:16:51.136913	\N
3783	Córrego Morro do S (PAC Cidades Fase 1)	\N	0	0	0	2014-12-07 16:16:51.194705	\N
3784	Ribeirão dos Perus - Parque Linear	\N	0	0	0	2014-12-07 16:16:51.262543	\N
3785	Tunel Sena Madureira	\N	0	0	0	2014-12-07 16:16:51.414576	\N
3786	Córrego Rapadura	\N	0	0	0	2014-12-07 16:16:51.476895	\N
3787	Córrego Morro do S (PAC Cidades Fase 2)	\N	0	0	0	2014-12-07 16:16:51.501706	\N
3788	Córrego Mirassol	\N	0	0	0	2014-12-07 16:16:51.521913	\N
3789	Vila Clarice	Av. Dr Felipe Pinel	0	0	0	2014-12-07 16:16:51.540695	\N
3790	RFFSA - Capitão Mor Gonçalo Monteiro/Barra Funda	Rua Capitão Mor Gonçalo Monteiro X Rua do Bosque	0	0	0	2014-12-07 16:16:51.560459	\N
3791	Areião Presidente Wilson	Av Presidente Wilson 551-1099	0	0	0	2014-12-07 16:16:51.580175	\N
3792	Vila Matilde	Rua Joaquim Marra	0	0	0	2014-12-07 16:16:51.599785	\N
3793	Favela Panorama	\N	0	0	0	2014-12-07 16:16:51.619888	\N
3794	RENOVA SP / Áreas Públicas - PAC	-	0	0	0	2014-12-07 16:16:51.63958	\N
3795	Itapecerica (Pirajussara 5)	Estrada de Itapecerica	0	0	0	2014-12-07 16:16:51.658832	\N
3796	Armando de Arruda Pereira (Água Espraiada 2+5)	Avenida Engenheiro Armando\n de Arruda Pereira	0	0	0	2014-12-07 16:16:51.680579	\N
3797	Jurupari II  (Água Espraiada 2+5)	Rua Jurupari	0	0	0	2014-12-07 16:16:51.700831	\N
3798	Couto de Calvão (processo em atl)	Rua Professora Eunice Bechara\n de Oliveira	0	0	0	2014-12-07 16:16:51.721211	\N
3799	Calipso	\N	0	0	0	2014-12-07 16:16:51.741178	\N
3800	Manacás	Rua Gregorio Viegas	0	0	0	2014-12-07 16:16:51.763536	\N
3801	São José	Rua Paramaribo, Rua Samana	0	0	0	2014-12-07 16:16:51.783236	\N
3802	Mananciais - Áreas Públicas - PAC (diversas)	\N	0	0	0	2014-12-07 16:16:51.802886	\N
3803	Mendes da Rocha	Av. Mendes da Rocha X Rua Areia do Rosário	0	0	0	2014-12-07 16:16:51.822986	\N
3804	Estrada do Campo Limpo	Estrada do Campo Limpo, 5.913	0	0	0	2014-12-07 16:16:51.842571	\N
3805	Cícero Canuto	Av. Pastor Cícero Canuto de Lima, 960	0	0	0	2014-12-07 16:16:51.864592	\N
3806	Guido Caloi (Ponte Baixa / SP Trans)	Av. Guido Caloi, 1200	0	0	0	2014-12-07 16:16:51.885167	\N
3807	Pq Boa Esperança	Rua Aguarico e Rua Aclamado	0	0	0	2014-12-07 16:16:51.905101	\N
3808	Forte do Rio Branco III	Rua Forte do Rio Branco	0	0	0	2014-12-07 16:16:51.924576	\N
3809	Forte do Rio Branco I	Rua Forte do Rio Branco	0	0	0	2014-12-07 16:16:51.949047	\N
3810	Forte do Rio Branco IV	Rua Forte do Rio Branco	0	0	0	2014-12-07 16:16:51.970284	\N
3811	Takao Minami / Anecy Rocha	Rua Anecy Rocha	0	0	0	2014-12-07 16:16:51.994691	\N
3812	Forte do Rio Branco V	Rua Forte do Rio Branco	0	0	0	2014-12-07 16:16:52.018948	\N
3813	Favela Coliseu	Rua Coliseu e Rua Funchal	0	0	0	2014-12-07 16:16:52.042296	\N
3814	Conjunto Habitacional Palanque	\N	0	0	0	2014-12-07 16:16:52.078444	\N
3815	Setor Privado / Estado - Conv. Assinado	\N	0	0	0	2014-12-07 16:16:52.101309	\N
3816	Área 49	Rua Dr. Alcides de Campos 101, 95\nRua Romana de Oliveira Salles Cunha, 2\nAvenida Muzambinho 484, 494, 496	0	0	0	2014-12-07 16:16:52.126163	\N
3817	Área 50	Avenida Muzambinho 452/456, 442\nRua Romana de Oliveira Salles Cunha 4, 5, 7\nRua Dr. Alcides de Campos 73, 65, 61, 40, 12, 35, 31	0	0	0	2014-12-07 16:16:52.151107	\N
3818	Área 51	Rua Sepins s/n, 84/90, 16/20/22, 40/42, 50/58, 64/68,  62/66\nRua Francesco Solimena 119, 105/111	0	0	0	2014-12-07 16:16:52.174347	\N
3819	Área 53	Rua Hildebrando Siqueira 58, 76, 86, 126A/126B, 128/98, 130\nRua Cinco de Outubro 170, 16	0	0	0	2014-12-07 16:16:52.194814	\N
3820	Área 54A	Rua Rosália de Castro 51/55/105, 93, 85, 81, 69, 37, 53, 47, 45, 41/41A\nRua Guian 68/66	0	0	0	2014-12-07 16:16:52.218497	\N
3821	Área 55A	Rua Franklin Magalhães 77, 65, 89, 97, 105, 397, 395, 123, 127/125, 137\nRua Embiara 130, 122, 118/126/114A/114B/114C, 180	0	0	0	2014-12-07 16:16:52.242513	\N
3822	Área 56A	Rua Atos Damasceno 61, 69, 77, 87, 43/37B\nRua Gal. Aldevio Barbosa de Lemos 153, 155, 157, 165, 175, 108, 93	0	0	0	2014-12-07 16:16:52.263351	\N
3823	Área 58	Praça Teotônio de Brito 12, 10, 14\nRua Botuvera 190	0	0	0	2014-12-07 16:16:52.288535	\N
3824	Área 63	Rua Ruy de Azevedo Sodré 1547, 600, 15, 212, 212A\nRua Gustavo da Silveira 12	0	0	0	2014-12-07 16:16:52.311319	\N
3825	Petrobrás/Heliópolis - CDHU	Rua Almirante Delamare x Maciel Parente	-23.606689	-46.590397	0	2014-12-07 16:16:52.332262	\N
3826	Ipiranga, Ed	\N	0	0	0	2014-12-07 16:16:52.351321	\N
3827	Curuça I, Conjunto Habitacional	\N	0	0	0	2014-12-07 16:16:52.372657	\N
3828	Juá Mirim	\N	0	0	0	2014-12-07 16:16:52.392405	\N
3829	Aratimbó (Sacomã G)	\N	0	0	0	2014-12-07 16:16:52.412188	\N
3830	Parque São Lucas	\N	0	0	0	2014-12-07 16:16:52.432488	\N
3831	João Paulo II, Res	\N	0	0	0	2014-12-07 16:16:52.452211	\N
3832	Maria Domitilia	\N	0	0	0	2014-12-07 16:16:52.474553	\N
3833	Projeto Marinheiro 184	\N	0	0	0	2014-12-07 16:16:52.494546	\N
3834	Casper Libero	\N	0	0	0	2014-12-07 16:16:52.517824	\N
3835	Minas do Rio Verde	\N	0	0	0	2014-12-07 16:16:52.540914	\N
3836	Baronesa	\N	0	0	0	2014-12-07 16:16:52.561588	\N
3837	San Raymond, Res	\N	0	0	0	2014-12-07 16:16:52.582713	\N
3838	Tiradentes V - CDHU	\N	0	0	0	2014-12-07 16:16:52.603436	\N
3839	São Judas Tadeu - Condominio	\N	0	0	0	2014-12-07 16:16:52.624493	\N
3840	Nuno Guerner	\N	0	0	0	2014-12-07 16:16:52.644375	\N
3841	Sitio Fazendinha	\N	0	0	0	2014-12-07 16:16:52.66475	\N
3842	Novo Grajau (Frederick Delius)	\N	0	0	0	2014-12-07 16:16:52.685089	\N
3843	Edmundo de Carvalho	\N	0	0	0	2014-12-07 16:16:52.705572	\N
3844	Santa Maria Residencial	\N	0	0	0	2014-12-07 16:16:52.725621	\N
3845	Darci Ribeiro	\N	0	0	0	2014-12-07 16:16:52.745056	\N
3846	Go Sugaya	\N	0	0	0	2014-12-07 16:16:52.766916	\N
3847	Arroio Sarandi	\N	0	0	0	2014-12-07 16:16:52.787467	\N
3848	Sítio Paiolzinho	\N	0	0	0	2014-12-07 16:16:52.807026	\N
3849	Estrada da Lagoa	\N	0	0	0	2014-12-07 16:16:52.827337	\N
3850	Duque de Caxias	\N	0	0	0	2014-12-07 16:16:52.849233	\N
3851	Grajau Conjunto Habitacional	\N	0	0	0	2014-12-07 16:16:52.869999	\N
3852	Sinfonia Italiana	\N	0	0	0	2014-12-07 16:16:52.890237	\N
3853	Oscar Niemeyer Conjunto	\N	0	0	0	2014-12-07 16:16:52.912899	\N
3854	Jacu Pessego	\N	0	0	0	2014-12-07 16:16:52.937792	\N
3855	Parque Regatas Residencial	\N	0	0	0	2014-12-07 16:16:52.95979	\N
3856	Felix Bogado	\N	0	0	0	2014-12-07 16:16:52.97971	\N
3857	Nigro Gava	\N	0	0	0	2014-12-07 16:16:53.001134	\N
3858	Go Sugaya II	\N	0	0	0	2014-12-07 16:16:53.021999	\N
3859	Projeto Interlagos	\N	0	0	0	2014-12-07 16:16:53.042496	\N
3860	Residencial das Rosas I	\N	0	0	0	2014-12-07 16:16:53.066032	\N
3861	M'Boi Mirim	\N	0	0	0	2014-12-07 16:16:53.090971	\N
3862	Programa de urbanização de favelas - São Francisco	R. Cinira Polônio x R. Bandeira do Aracambi	-23.627459	-46.452221	159180645.060000002	2014-12-07 16:16:54.098911	\N
3863	Programa de urbanização de favelas - Minas Gás / Jd. Das Graças	Rua Francisco de Paula Candido	-23.506281	-46.687356	7854335.28000000026	2014-12-07 16:16:54.121056	\N
3864	Programa de urbanização de favelas - Jd. Edite	Av. Corn. Roberto Marinho	-23.613503	-46.694085	55274135.0799999982	2014-12-07 16:16:54.1418	\N
3865	Programa de urbanização de favelas - Sitio Itaberaba	Estrada da Ligação, Rua Uberlândia	-23.437550	-46.772233	33135752.2600000016	2014-12-07 16:16:54.162433	\N
3866	Programa de urbanização de favelas - Cinco de Julho	Rua André de Almeida x Rua Eorda do Campo	-23.594448	-46.481001	9008207.1799999997	2014-12-07 16:16:54.184623	\N
3867	Programa de urbanização de favelas - Nove de Julho	Rua Bartolomeu de Brito	-23.592409	-46.482797	2192339.79000000004	2014-12-07 16:16:54.205677	\N
3868	Programa de urbanização de favelas - Dois de Maio	Av. Aricanduva	-23.591575	-46.483187	18518381.9699999988	2014-12-07 16:16:54.229523	\N
3869	Programa de urbanização de favelas - Vitotoma	Avenida Engenho Novo	-23.588326	-46.493317	6283188.29000000004	2014-12-07 16:16:54.250551	\N
3870	Programa de urbanização de favelas - Corrego da Mina	Avenida da Mina	-23.421136	-46.750424	34298054.0399999991	2014-12-07 16:16:54.270555	\N
3871	Programa de urbanização de favelas - Bambural	Rua Bamburral x Rua Silverânia	-23.409895	-46.760064	63776471.6700000018	2014-12-07 16:16:54.291254	\N
3872	Programa de urbanização de favelas - Lidiane	R. Sampaio Correia x R. Eulálio C. Carvalho	-23.510799	-46.677694	49203936.1000000015	2014-12-07 16:16:54.311191	\N
3873	Programa de urbanização de favelas - Carina Ari	Rua Cavalo Marinho x Rua Ernesto Bottoni	-23.452805	-46.752250	262932.760000000009	2014-12-07 16:16:54.331038	\N
3874	Programa de urbanização de favelas - Gabi	Rua Joaquim Francisco de Assis	-23.490385	-46.669612	1496439.80000000005	2014-12-07 16:16:54.353926	\N
3875	Programa de urbanização de favelas - Parque das Flores	Av. Adutora do Rio Claro	-23.639544	-46.443962	102013005.739999995	2014-12-07 16:16:54.378811	\N
3876	Programa de urbanização de favelas - Ponte dos Remédios	Av. Embaixador Macedo Soares	-23.514602	-46.724301	58827140.2899999991	2014-12-07 16:16:54.402476	\N
3877	Programa de urbanização de favelas - Diogo Pires	Av. Dracena x Av. Alexandre Mackenzie	-23.539668	-46.746620	7854335.28000000026	2014-12-07 16:16:54.422701	\N
3878	Programa de urbanização de favelas - Barão de Antonina	Marginal x Rua Guapó	-23.539112	-46.743747	0	2014-12-07 16:16:54.444592	\N
3879	Programa de urbanização de favelas - Tiro ao Pombo	Av. José da Natividade Saldanha	-23.470518	-46.686778	24784771.2699999996	2014-12-07 16:16:54.465958	\N
3880	Programa de urbanização de favelas - Jd. Guarani	Rua També do Mato Dentro	-23.515304	-46.459216	22461658.5	2014-12-07 16:16:54.487091	\N
3881	Programa de urbanização de favelas - Tolstoi	Tolstoi: entre as Ruas Pedro Híspano, Avenida Prof. Luiz Ignácio Anhaia Mello (altura do nº 8.000).	0	0	1598012.98999999999	2014-12-07 16:16:54.507859	\N
3882	Programa de urbanização de favelas - Heliópolis H / Sabesp 2 -	 Gleba H:  Localizada entre as vias Rua Coronel Silva Castro, Rua Conego Xavier e Rua Barão do Rio da Pedra.  \nÁrea da Sabesp 2: Localizada dentro da ETE-ABC, entre a Av. Almirante Delamare e Córrego dos Meninos. 	-23.606799	-46.595316	182248148.180000007	2014-12-07 16:16:54.530241	\N
3883	Heliópolis K/Estrada das Lágrimas/Sabesp 1 - Lote 06	Gleba K: principais vias do perímetro - Av. Estrada das Lágrimas, Rua Conego Xavier, Dr. João Pedro de Carvalho Neto, Almirante Delamare, divisa com a área da ETE Sabesp, Luigi Alamanni e Projetada 1. Gaivotas: próximo a Rua João Lanhoso.   Sabesp 1: dent	-23.609116	-46.596252	88499581.4300000072	2014-12-07 16:16:54.555587	\N
3884	Programa de urbanização de favelas - Jardim Clímax	Jardim Clímax: Localizado entre as Ruas Buturuna, Rua Francisco Mateus, Rua José Pereira Barreto, fundo dos lotes da Av. Padre Arlindo Vieira e Rua Estevan Pedroso.	0	0	2715342.41999999993	2014-12-07 16:16:54.576784	\N
3885	Programa de urbanização de favelas - Chácara São Judas	São Judas: localizado na Estrada M’Boi Mirim com a Rua Carlos Severo e fundos com Rua Custódia Maria de Jesus. 	0	0	367939.400000000023	2014-12-07 16:16:54.597704	\N
3886	Programa de urbanização de favelas - Viela da Paz	Viela da Paz - Limites: Ruas Sebastião Falconi, Diogo Pereira, Faustino da Silva, Dr. Rabelo do Amaral, Av. João Caiaffa, Francisco Fernandes. 	0	0	104461174.260000005	2014-12-07 16:16:54.61785	\N
3887	Programa de urbanização de favelas - Paraisópolis	Paraisópolis: Localiza-se à esquerda da Av. Giovanni Gronchi (tendo-se como referência o sentido centro-bairro), estendendo-se até as proximidades do Cemitério Morumbi.	-23.615053	-46.725403	222674554.25	2014-12-07 16:16:54.638796	\N
3943	S/D AC.R.JOAQUIMLEAL	\N	0	0	\N	2014-12-07 16:16:56.162615	\N
3944	S/D PAIOLZINHO - REP. ÁREA MAIOR QD. C	\N	0	0	\N	2014-12-07 16:16:56.183875	\N
3888	Programa de urbanização de favelas - Sapé A	Sapé A:  Localizada entre os limites da Avenida Waldemar Roberto, Avenida do Rio Pequeno, Rua Tomé de Lara Falcão, Rua General Syzeno Sarmento.  	0	0	91747258.0199999958	2014-12-07 16:16:54.662234	\N
3889	Programa de urbanização de favelas - Sapé B	Sapé B:  Localizada entre os limites da Avenida Waldemar Roberto, Rua General Syzeno Sarmento, Rua Calixto Garcia e Rua Maria Rita Balbino. 	0	0	68620536.7300000042	2014-12-07 16:16:54.683079	\N
3890	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Água Espraiada 2+5	Perímetro próximo as Av. Pedro Bueno, Av. Eng. George Corbisier, Av. Eng. Armando de Arruda Pereira.	0	0	1365786.46999999997	2014-12-07 16:16:54.703573	\N
3891	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Oratório 1	Perímetro próximo as Av. Custódio de Sá Faria e Av. Sapopemba.	0	0	5679931.34999999963	2014-12-07 16:16:54.723972	\N
3892	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Meninos 1	Perímetro entre as Av. Cursino e Rodovia Anchieta.	-23.647075	-46.607919	2272880.4700000002	2014-12-07 16:16:54.745433	\N
3893	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Cordeiro 1	Perímetro próximo as Av. Cupecê e Av. Eng. Armando de Arruda Pereira.	0	0	1400457.02000000002	2014-12-07 16:16:54.766684	\N
3894	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Pirajussara 5	Perímetro próximo a Estrada de Itapecerica, Estrada do Campo Limpo e Av. Carlos Lacerda.	-23.622344	-46.765714	3677526.10000000009	2014-12-07 16:16:54.78707	\N
3895	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Pirajussara 7	Perímetro próximo as Av. Prof. Francisco Moratto, Rodovia Regis Bittencourt e Estrada do Campo Limpo.	-23.604622	-46.746531	2360257.10000000009	2014-12-07 16:16:54.810804	\N
3896	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Ponte Baixa 4	Perímetro próximo as Av. Guarapiranga, Av. Guido Caloi e Rio Pinheiros.	-23.644700	-46.727019	2596297.70999999996	2014-12-07 16:16:54.834648	\N
3897	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Morro do S 4	Perímetro entre as Estrada de Itapecerica, Estrada do M'Boi Mirim e Av. Fim de Semana.	-23.643536	-46.747497	7963174.79999999981	2014-12-07 16:16:54.858143	\N
3898	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Jd. Japão 1	O Perímetro de Ação Integrada Jardim Japão 1, situa-se no distrito Vila Maria, na sub-bacia hidrográfica do Jardim Japão, região Norte da cidade de São Paulo.	-23.518056	-46.575278	2422771.12999999989	2014-12-07 16:16:54.878316	\N
3899	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Cabuçu de Baixo 4	O Perímetro de Ação Integrada Cabuçu de Baixo 4, situa-se no distrito de Brasilândia, na sub-bacia hidrográfica do Cabuçu de Baixo, região Norte da cidade de São Paulo.	-23.449722	-46.700278	2293106.4700000002	2014-12-07 16:16:54.898851	\N
3900	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Cabuçu de Baixo 5	O Perímetro de Ação Integrada Cabuçu de Baixo 5, situa-se no distrito de Brasilândia, na sub-bacia hidrográfica do Cabuçu de Baixo, região Norte da cidade de São Paulo.	-23.450000	-46.687222	3691031.39000000013	2014-12-07 16:16:54.919716	\N
3901	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Cabuçu de Baixo 12	O Perímetro de Ação Integrada Cabuçu de Baixo 12, situa-se no distrito Cachoeirinha, na sub-bacia hidrográfica do Cabuçu de Baixo, região Norte da cidade de São Paulo.	-23.457500	-46.652778	1907725.37999999989	2014-12-07 16:16:54.940139	\N
3902	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Cabuçu de Cima 7	O Perímetro de Ação Integrada Cabuçu de Cima 7, situa-se no distrito de Tremembé, na sub-bacia hidrográfica do Cabuçu de Cima, região Norte da cidade de São Paulo.	-23.778889	-46.580833	1518868.81000000006	2014-12-07 16:16:54.961536	\N
3903	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Cabuçu de Cima 8	O Perímetro de Ação Integrada Cabuçu de Cima 8, situa-se no distrito de Tremembé, na sub-bacia hidrográfica do Cabuçu de Cima, região Norte da cidade de São Paulo.	-23.446944	-46.584167	2858635.95999999996	2014-12-07 16:16:54.982331	\N
3904	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Cabuçu de Cima 10	O Perímetro de Ação Integrada Cabuçu de Cima 10, situa-se no distrito de Tremembé, na sub-bacia hidrográfica do Cabuçu de Cima, região Norte da cidade de São Paulo.	-23.456944	-46.577222	1985403.1399999999	2014-12-07 16:16:55.002371	\N
3905	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Agua Vermelha 2	O Perímetro de Ação Integrada Água Vermelha 2, situa-se na região leste da cidade, nas sub-bacias Água Vermelha e Lageado.	-23.480556	-46.410833	4261301.63999999966	2014-12-07 16:16:55.022372	\N
3906	Programa de urbanização de favelas Renova SP - Perimetro de Ação Integrada Tiquatira 2	O Perímetro de Ação Integrada Tiquatira 2 situa-se na região leste da cidade, entre as subprefeituras de Ermelino Matarazzo e Penha.	-23.524167	-46.475833	640164.819999999949	2014-12-07 16:16:55.042599	\N
3907	CHÁCARA BELENZINHO - LOTE 12 E 13 - QD N	\N	0	0	\N	2014-12-07 16:16:55.27647	\N
3908	JD BRASILINA	\N	0	0	0	2014-12-07 16:16:55.297927	\N
3909	JD PRESTES MAIA	\N	0	0	0	2014-12-07 16:16:55.319373	\N
3910	SD AC RUA ESTRADA VELHA DE ITAPECERICA	\N	0	0	0	2014-12-07 16:16:55.340785	\N
3911	CJ.HAB.STO.AMAROA	\N	0	0	\N	2014-12-07 16:16:55.361454	\N
3912	JD COLONIAL	\N	0	0	0	2014-12-07 16:16:55.382681	\N
3913	PQ RESIDENCIAL CIDADE DUTRA - GL. 3	\N	0	0	0	2014-12-07 16:16:55.403048	\N
3914	PQ DAS NAÇÕES - GL. 4	\N	0	0	0	2014-12-07 16:16:55.42345	\N
3915	JD SÃO JUDAS TADEU	\N	0	0	0	2014-12-07 16:16:55.444174	\N
3916	JD.EDILENE	\N	0	0	0	2014-12-07 16:16:55.472161	\N
3917	S/D/ AC. ESTR. CLUBE DE CAMPO	\N	0	0	0	2014-12-07 16:16:55.495403	\N
3918	PQ ALTO RIO BONITO	\N	0	0	0	2014-12-07 16:16:55.538888	\N
3919	JD MYRNA	\N	0	0	0	2014-12-07 16:16:55.562498	\N
3920	PQ COCAIA - GL 2	\N	0	0	0	2014-12-07 16:16:55.584318	\N
3921	V.WANDA	Av. Afonso Sampaio de Souza 2001 - Itaquera	0	0	0	2014-12-07 16:16:55.609961	\N
3922	V.PRADO	\N	0	0	0	2014-12-07 16:16:55.633964	\N
3923	AC.R.DR.SEBASTIAOLIMA	\N	0	0	0	2014-12-07 16:16:55.659192	\N
3924	AC.R.CARLOSFACCHINA	\N	0	0	67596	2014-12-07 16:16:55.684889	\N
3925	SÍTIOELDORADO	\N	0	0	0	2014-12-07 16:16:55.710591	\N
3926	AC.ESTR.RUST-ELDORADO	\N	0	0	\N	2014-12-07 16:16:55.734713	\N
3927	AC R. ANALIA MARIA DE JESUS	\N	0	0	\N	2014-12-07 16:16:55.758235	\N
3928	JD BRANCO	\N	0	0	0	2014-12-07 16:16:55.782847	\N
3929	CONJ.RES.DOM ANGÉLICO	\N	0	0	\N	2014-12-07 16:16:55.808145	\N
3930	JD.LISBOA	\N	0	0	0	2014-12-07 16:16:55.832086	\N
3931	S/D RUA FIGUEIRA DA POLINÉSIA	\N	0	0	\N	2014-12-07 16:16:55.854898	\N
3932	JD. SÃO BENTO	\N	0	0	163488	2014-12-07 16:16:55.87984	\N
3933	V.SÃO LUIZ/TEREZINHA	\N	0	0	\N	2014-12-07 16:16:55.905977	\N
3934	JD.VISTA ALEGRE/LINDEIRA	\N	0	0	\N	2014-12-07 16:16:55.932236	\N
3935	VILA NOVA ESPERANÇA	\N	0	0	\N	2014-12-07 16:16:55.956343	\N
3936	TIRO AO POMBO	\N	0	0	\N	2014-12-07 16:16:55.985249	\N
3937	V.1°OUTUBRO	\N	0	0	0	2014-12-07 16:16:56.009315	\N
3938	S/D AC. RUA EUGÊNIO RADIANTE	\N	0	0	\N	2014-12-07 16:16:56.034838	\N
3939	S/D AC. RUA SÃO JOSÉ DE MOSSAMEDES	\N	0	0	\N	2014-12-07 16:16:56.062015	\N
3940	JD. SANTO ANTONIO	Rua Gerônimo Furtado, 751	0	0	0	2014-12-07 16:16:56.088009	\N
3941	S/D AC. R. GEORGINA DINIZ BRAGHIROLI	\N	0	0	0	2014-12-07 16:16:56.11489	\N
3945	AC R. PARÁBOLAS MUSICAIS	\N	0	0	\N	2014-12-07 16:16:56.204861	\N
3946	JD.SUZANA_AC.RUA PEDRO XARA RAVESCO	\N	0	0	\N	2014-12-07 16:16:56.226395	\N
3947	JD JORDÃO	\N	0	0	0	2014-12-07 16:16:56.246487	\N
3948	S/D/ AC. R. DAVI DOMINGUES FERREIRA	\N	0	0	0	2014-12-07 16:16:56.267032	\N
3949	V.CARMOSINA-DESDOBRO_Q.108	\N	0	0	\N	2014-12-07 16:16:56.288511	\N
3950	S/D AC. R. ESTAQUIO DA COSTA	\N	0	0	0	2014-12-07 16:16:56.310649	\N
3951	S/D AC.RUAAPERIBE	\N	0	0	0	2014-12-07 16:16:56.331775	\N
3952	JD.JOÃO E JACINTHA	\N	0	0	225582	2014-12-07 16:16:56.353373	\N
3953	S/D AC.R.MARCIANOCARNEIRO	\N	0	0	\N	2014-12-07 16:16:56.374514	\N
3954	S/D AC.R.AMORIM_ASSOC.SOBRADINHO	\N	0	0	\N	2014-12-07 16:16:56.395538	\N
3955	S/D ASSOC DE MULHERES SORRISO NEGRO	\N	0	0	\N	2014-12-07 16:16:56.416165	\N
3956	JOANADARCIV-AC.R.ANASACRAMENTO	\N	0	0	\N	2014-12-07 16:16:56.437695	\N
3957	JD JOANA D´ARC	\N	0	0	\N	2014-12-07 16:16:56.461663	\N
3958	JD RECREIO	\N	0	0	0	2014-12-07 16:16:56.484641	\N
3959	PQ AMÉLIA	\N	0	0	0	2014-12-07 16:16:56.505995	\N
3960	CHÁCARA ARMOND	\N	0	0	0	2014-12-07 16:16:56.527614	\N
3961	JD RANIERI	\N	0	0	0	2014-12-07 16:16:56.549498	\N
3962	JD JUSSARA	\N	0	0	528192	2014-12-07 16:16:56.569742	\N
3963	VILA PAULISTÂNIA	Praça Jânio da Silva Quadros, 150	0	0	0	2014-12-07 16:16:56.590545	\N
3964	JD PENHA	\N	0	0	0	2014-12-07 16:16:56.612622	\N
3965	CONJ.RESID.MORADA DO SOL	\N	0	0	\N	2014-12-07 16:16:56.633807	\N
3966	CONJ.RESID.PQ.ESPERANÇA	\N	0	0	\N	2014-12-07 16:16:56.657148	\N
3967	AC. RUA NHATUMANI_LT 14 E 15_QD 48	\N	0	0	\N	2014-12-07 16:16:56.678669	\N
3968	CONJ.HAB.CANGAÍBAA5,A6EA7	\N	0	0	\N	2014-12-07 16:16:56.699541	\N
3969	VILA SULINA	\N	0	0	0	2014-12-07 16:16:56.724098	\N
3970	MORRO DOCE - SÍTIO ROSINHA	\N	0	0	\N	2014-12-07 16:16:56.745744	\N
3971	S/D MORRO DOCE REPARCEL LOTE 68 QD. A	\N	0	0	\N	2014-12-07 16:16:56.767654	\N
3972	JD. ITABERABA 2 / JD. SILVESTRE	\N	0	0	\N	2014-12-07 16:16:56.78959	\N
3973	V.RENATO	\N	0	0	0	2014-12-07 16:16:56.811219	\N
3974	JD. GOMES DE MORAES	\N	0	0	0	2014-12-07 16:16:56.832017	\N
3975	JARDIM NOVA PARADA	\N	0	0	0	2014-12-07 16:16:56.855992	\N
3976	PARADA DE TAIPAS / SÍTIO PEDRO VELHO	\N	0	0	\N	2014-12-07 16:16:56.877553	\N
3977	CIDADE DABRIL GLEBA 02	\N	0	0	\N	2014-12-07 16:16:56.898017	\N
3978	CIDADE D ABRIL_GLEBA 03	\N	0	0	\N	2014-12-07 16:16:56.922139	\N
3979	JD DAS JABOTICABEIRAS / ESTR DO ALAMBIQUE	\N	0	0	\N	2014-12-07 16:16:56.944696	\N
3980	CJ.RESID.NOVO HORIZONTE	\N	0	0	\N	2014-12-07 16:16:56.966775	\N
3981	S/D AC. AV. ELÍSIO TEIXEIRA LEITE	\N	0	0	\N	2014-12-07 16:16:56.987979	\N
3982	COND.PARAÍSO	\N	0	0	\N	2014-12-07 16:16:57.009756	\N
3983	CONJ. HAB. TURÍSTICA	\N	0	0	\N	2014-12-07 16:16:57.031546	\N
3984	PARADA DE TAIPAS	\N	0	0	\N	2014-12-07 16:16:57.052616	\N
3985	JD.DONÁRIA	\N	0	0	\N	2014-12-07 16:16:57.074587	\N
3986	V BELA	\N	0	0	0	2014-12-07 16:16:57.096964	\N
3987	V.BELA-REPARC.QD.165	\N	0	0	\N	2014-12-07 16:16:57.118818	\N
3988	JD.MARIA LÍDIA-LINDEIRO	\N	0	0	\N	2014-12-07 16:16:57.140655	\N
3989	CHÁCARA ALE/CHALÉ_JD.IMPERADOR	\N	0	0	\N	2014-12-07 16:16:57.162247	\N
3990	V - RELOT. Q.A-1. JACUÍ	\N	0	0	0	2014-12-07 16:16:57.183942	\N
3991	JD MAIA - QUADRA 27 / QUADRAS A E B	\N	0	0	0	2014-12-07 16:16:57.205552	\N
3992	V. MARGARIDA	\N	0	0	\N	2014-12-07 16:16:57.226597	\N
3993	JD ROMANO	\N	0	0	\N	2014-12-07 16:16:57.248381	\N
3994	AC R. CIRI-POA	\N	0	0	\N	2014-12-07 16:16:57.270147	\N
3995	S/D AC.RUA CARDON	\N	0	0	\N	2014-12-07 16:16:57.290752	\N
3996	PQ. PAULISTANO NITRO III	\N	0	0	\N	2014-12-07 16:16:57.31246	\N
3997	FAZENDA DA JUTA	\N	0	0	\N	2014-12-07 16:16:57.336376	\N
3998	VÁRZEA DO CARMO	\N	0	0	\N	2014-12-07 16:16:57.35773	\N
3999	AC AV. MENDES DA ROCHA L25 - QD 48	\N	0	0	\N	2014-12-07 16:16:57.379115	\N
4000	AC NICOLAU MARTINS	\N	0	0	0	2014-12-07 16:16:57.400271	\N
4001	Ampliação do efetivo da Guarda Civil Metropolitana em 2.000 novos integrantes	\N	0	0	0	2014-12-07 16:16:57.954861	\N
4002	Novos guardas contratados para a Guarda Civil Metropolitana	\N	0	0	0	2014-12-07 16:16:57.976838	\N
4003	Agentes da Guarda Civil Metropolitana capacitados em Direitos Humanos	\N	0	0	0	2014-12-07 16:16:58.119152	\N
4004	Agentes da Guarda Civil Metropolitana capacitados em mediação de conflitos	\N	0	0	0	2014-12-07 16:16:58.141283	\N
4005	Casa da Mulher Brasileira	Rua Vieira Ravasco, nº 26 -  Cambuci	-23.556538	-46.622742	0	2014-12-07 16:16:58.284352	\N
4006	Casa de Passagem	Rua Dr. Bacelar, 20	-23.594361	-46.647887	0	2014-12-07 16:16:58.444692	\N
4007	Casa Abrigo	O endereço da Casa Abrigo não pode ser divulgado por motivos de segurança das beneficiárias	0	0	0	2014-12-07 16:16:58.4677	\N
4008	Reestruturação da Casa de Mediação - Aricanduva/Formosa/Carrão	Praça Aroldo Daltro	-23.548452	-46.532352	0	2014-12-07 16:16:58.619608	\N
4009	Reestruturação da Casa de Mediação - Butantã	Praça João Pisani, nº. 449	-23.575728	-46.723448	0	2014-12-07 16:16:58.642432	\N
4010	Reestruturação da Casa de Mediação - Campo Limpo	Rua Manoel José Pereira, nº. 300	-23.666239	-46.768456	0	2014-12-07 16:16:58.664629	\N
4011	Reestruturação da Casa de Mediação - Capela do Socorro	Avenida Atlântica, nº: 2.450	-23.686201	-46.714613	0	2014-12-07 16:16:58.687376	\N
4012	Reestruturação da Casa de Mediação - Casa Verde/Cachoeirinha	Rua Xiró, nº. 266	-23.507487	-46.664143	0	2014-12-07 16:16:58.709459	\N
4013	Reestruturação da Casa de Mediação - Cidade Ademar	Rua Sebastião Afonso, nº 828	-23.679855	-46.636549	0	2014-12-07 16:16:58.730694	\N
4014	Reestruturação da Casa de Mediação - Cidade Tiradentes	\N	0	0	0	2014-12-07 16:16:58.753897	\N
4015	Reestruturação da Casa de Mediação - Ermelino Matarazzo	Estrada de Mogi das Cruzes, 1860	-23.516824	-46.482854	0	2014-12-07 16:16:58.77632	\N
4016	Reestruturação da Casa de Mediação - Freguesia do Ó	Rua João Luís Calheiros, nº. 40	-23.473523	-46.689115	0	2014-12-07 16:16:58.798445	\N
4017	Reestruturação da Casa de Mediação - Guaianases	Rua Fernandes Palero, nº. 301	-23.567114	-46.400606	0	2014-12-07 16:16:58.819488	\N
4018	Reestruturação da Casa de Mediação - Ipiranga	Rua Breno Ferraz do Amaral, nº. 415	-23.596784	-46.621407	0	2014-12-07 16:16:58.842022	\N
4019	Reestruturação da Casa de Mediação - Itaim Paulista	Avenida Marechal Tito, nº. 3012 	-23.494067	-46.416717	0	2014-12-07 16:16:58.863331	\N
4020	Reestruturação da Casa de Mediação - Itaquera	Avenida Prof. João Batista Contil, nº. 285	-23.551972	-46.432985	0	2014-12-07 16:16:58.88502	\N
4021	Reestruturação da Casa de Mediação - Jabaquara	Rua Lussanvira, 178 	-23.641255	-46.637674	0	2014-12-07 16:16:58.906807	\N
4022	Reestruturação da Casa de Mediação - Jaçanã	Rua Adauto Bezerra Delgado, n°. 210	-23.449320	-46.596510	0	2014-12-07 16:16:58.931198	\N
4023	Reestruturação da Casa de Mediação - Lapa	Rua Major Paladino, nº: 180 	-23.522958	-46.739658	0	2014-12-07 16:16:58.953863	\N
4024	Reestruturação da Casa de Mediação - M'Boi Mirim	Rua Tuparoquera, nº. 2220	-23.666272	-46.743483	0	2014-12-07 16:16:58.978669	\N
4025	Reestruturação da Casa de Mediação - Mooca	Rua Taquari, nº. 635	-23.550377	-46.597237	0	2014-12-07 16:16:59.000183	\N
4026	Reestruturação da Casa de Mediação - Parelheiros	Avenida Sadamu Inoue, nº. 5252	-23.815165	-46.735311	0	2014-12-07 16:16:59.023171	\N
4141	Porcentagem da frota de ônibus acessível	\N	0	0	0	2014-12-07 16:17:03.463968	\N
4027	Reestruturação da Casa de Mediação - Penha	Rua das Províncias, 218	-23.518264	-46.521024	0	2014-12-07 16:16:59.045553	\N
4028	Reestruturação da Casa de Mediação - Perus	R. Ylídio Figueiredo, 492	-23.406631	-46.754018	0	2014-12-07 16:16:59.067484	\N
4029	Reestruturação da Casa de Mediação - Pinheiros	Rua Dr. Frederico Hermann Júnior, nº. 653 	-23.562649	-46.703502	0	2014-12-07 16:16:59.090832	\N
4030	Reestruturação da Casa de Mediação - Pirituba	Avenida Raimundo Pereira de Magalhães, nº. 5093	-23.485332	-46.724396	0	2014-12-07 16:16:59.113695	\N
4031	Reestruturação da Casa de Mediação - Santana/Tucuruvi	Praça Heróis da FEB	-23.504743	-46.627999	0	2014-12-07 16:16:59.139746	\N
4032	Reestruturação da Casa de Mediação - Santo Amaro	Rua Darwin, nº. 221	-23.654923	-46.699720	0	2014-12-07 16:16:59.162528	\N
4033	Reestruturação da Casa de Mediação - São Mateus	Praça Tanque do Zunega, 31	-23.596340	-46.436145	0	2014-12-07 16:16:59.184177	\N
4034	Reestruturação da Casa de Mediação - São Miguel	Avenida Pires do Rio, nº. 1349	-23.508387	-46.443309	0	2014-12-07 16:16:59.206849	\N
4035	Reestruturação da Casa de Mediação - Sé	Praça da Sé (Próximo Metrô Sé)	-23.549510	-46.633299	0	2014-12-07 16:16:59.229247	\N
4036	Reestruturação da Casa de Mediação - Vila Maria	Travessa Simis, nº. 09	-23.513410	-46.620946	0	2014-12-07 16:16:59.251334	\N
4037	Reestruturação da Casa de Mediação - Vila Mariana	Rua Capitão Macedo, nº. 553	-23.592947	-46.645123	0	2014-12-07 16:16:59.272856	\N
4038	Reestruturação da Casa de Mediação - Vila Prudente	Rua Iamacaru, nº. 131	-23.610339	-46.513050	0	2014-12-07 16:16:59.295741	\N
4039	Estação da Juventude Complementar	\N	0	0	0	2014-12-07 16:16:59.516861	\N
4040	Estação da Juventude Itinerante	\N	0	0	0	2014-12-07 16:16:59.539773	\N
4041	Projetos Locais de Prevenção à Violência em Territórios Prioritários apoiados	\N	0	0	288275	2014-12-07 16:16:59.564445	\N
4042	Campanhas de Mobilização do Plano Juventude Viva	\N	0	0	162808.01999999999	2014-12-07 16:16:59.587225	\N
4043	Campanha Publicitária do Plano Juventude Viva	\N	0	0	0	2014-12-07 16:16:59.609057	\N
4044	Guia de Políticas Públicas de Juventude	\N	0	0	0	2014-12-07 16:16:59.631264	\N
4045	Mapa da Juventude Paulistana	\N	0	0	0	2014-12-07 16:16:59.654074	\N
4046	Portal da Juventude	\N	0	0	0	2014-12-07 16:16:59.675924	\N
4047	Serviço de proteção social a crianças e adolescentes vítimas de violência - São Mateus	Avenida Claudio Augusto Fernando, 640. CEP:03962-120	-23.610654	-46.480612	0	2014-12-07 16:16:59.844447	\N
4048	Serviço de proteção social a crianças e adolescentes vítimas de violência - Jaçanã/Tremembé	R Tomaz Cyro Pozi, 628 	-23.464235	-46.577640	0	2014-12-07 16:16:59.868627	\N
4049	Serviço de proteção social a crianças e adolescentes vítimas de violência - Guaianases	\N	0	0	0	2014-12-07 16:16:59.892375	\N
4050	Centro Olimpico de Iniciação e Formação (Zona Leste)	Rua Forte dos Franceses, 195	-23.603682	-46.465303	0	2014-12-07 16:17:00.048935	\N
4051	Centro Olímpico de Treinamento e Pesquisa (Zona Sul)	Av. Ibirapuera, 1315	-23.597735	-46.656472	0	2014-12-07 16:17:00.072356	\N
4052	Parque de Esportes Radicais	Avenida Zaki Narchi com a Oto Baumgart	-23.509058	-46.616402	0	2014-12-07 16:17:00.260363	\N
4053	Esporte 24h - Aricanduva/Formosa/Carrão	\N	0	0	0	2014-12-07 16:17:00.428347	\N
4054	Esporte 24h - CEE Solange Nunes Bibas	R. Hernani da Gama Correia, 367 - Butantã	-23.574431	-46.723289	263374.739999999991	2014-12-07 16:17:00.454792	\N
4055	Esporte 24h - Mini Balneário Ministro Sinésio Rocha	Rua Cibauma, 54 - Campo Limpo	-23.620162	-46.754218	263374.739999999991	2014-12-07 16:17:00.47797	\N
4056	Esporte 24h - Capela do Socorro	\N	0	0	0	2014-12-07 16:17:00.500034	\N
4057	Esporte 24h - Mini Balneário Comandante Garcia D´ávila	Rua Armando Coelho e Silva, 775 – Parque Peruche	-23.492235	-46.655039	0	2014-12-07 16:17:00.523965	\N
4058	Esporte 24h - Cidade Ademar	\N	0	0	0	2014-12-07 16:17:00.545822	\N
4059	Esporte 24h - Cidade Tiradentes	\N	0	0	0	2014-12-07 16:17:00.567287	\N
4060	Esporte 24h - Ermelino Matarazzo	\N	0	0	0	2014-12-07 16:17:00.589203	\N
4061	Esporte 24h - CEE Aurélio Campos	Rua Jacutiba, 167 -  -Freguesia do Ó 	23.483498	-46.693494	263374.739999999991	2014-12-07 16:17:00.61207	\N
4062	Esporte 24h - Guaianases	\N	0	0	0	2014-12-07 16:17:00.634317	\N
4063	Esporte 24h - Balneário Princesa Isabel	Rua Campante, 100 – Ipiranga	-23.595303	-46.594862	263374.739999999991	2014-12-07 16:17:00.655358	\N
4064	Esporte 24h - Itaim Paulista	\N	0	0	0	2014-12-07 16:17:00.677391	\N
4065	Esporte 24h - CEE Rumi Ranieri	Av. Afonso Sampaio de Souza 2001 - Itaquera	-23.575162	-46.477008	263374.739999999991	2014-12-07 16:17:00.699547	\N
4066	Esporte 24h - Balneário Jalisco	Rua Rodes, 112 – Vila Santa Catarina	-23.642191	-46.667000	263374.739999999991	2014-12-07 16:17:00.721815	\N
4067	Esporte 24h - Mini Balneário Irmãos Paolillo	Rua Gerônimo Furtado, 751Rua Gerônimo Furtado, 751Rua Gerônimo Furtado, 751Rua Gerônimo Furtado, 751Rua Gerônimo Furtado, 751Rua Gerônimo Furtado, 751Rua Gerônimo Furtado, 751	-23.464188	-46.569025	0	2014-12-07 16:17:00.743403	\N
4068	Esporte 24h - CEE Edson Arantes do Nascimento	Rua Belmonte, 957 – Alto da Lapa	-23.52623	-46.72090	0	2014-12-07 16:17:00.767236	\N
4069	Esporte 24h - M Boi Mirim	\N	0	0	0	2014-12-07 16:17:00.789852	\N
4070	Esporte 24h - CEE Salim Farah Maluf	R. Taquari, 635	-23.55084	-46.59729	0	2014-12-07 16:17:00.812135	\N
4071	Esporte 24h - Parelheiros	\N	0	0	0	2014-12-07 16:17:00.834061	\N
4072	Esporte 24h - CEE Luiz Marinez	Av. Governador Carvalho Pinto, 02 - Tiquatira	-23.51448	-46.54893	0	2014-12-07 16:17:00.856816	\N
4073	Esporte 24h - CEE Perus	\N	0	0	0	2014-12-07 16:17:00.87964	\N
4074	Esporte 24h - Pinheiros	\N	0	0	0	2014-12-07 16:17:00.903746	\N
4075	Esporte 24h - CEE Geraldo José de Almeida	Av. Agenor Couto Magalhães, 32	-23.48430	-46.74059	0	2014-12-07 16:17:00.928101	\N
4076	Esporte 24h - CEE Alfredo Ignacio Trindade	Rua Viri, 425 – Santana	-23.493963	-46.612047	263374.739999999991	2014-12-07 16:17:00.951817	\N
4077	Esporte 24h - CEE Joerg Bruder	Av. Padre José Maria, 555	-23.65481	-46.70961	0	2014-12-07 16:17:00.979719	\N
4078	Esporte 24h - Mini Balneário José Maria Withaker	Avenida Satélite, 756	-23.610812	-46.464761	0	2014-12-07 16:17:01.003237	\N
4079	Esporte 24h - Mini Balneário Almirante Pedro de Frontim	Rua Sargento Luis Batista, 83 - São Miguel	-23.500215	-46.429164	263374.739999999991	2014-12-07 16:17:01.025191	\N
4080	Esporte 24h - Sapopemba	\N	0	0	0	2014-12-07 16:17:01.047147	\N
4081	Esporte 24h - CEE Rubens Pecce Lordello	Av. Lins de Vanconcelos, 804 - Cambuci	-23.570421	-46.622391	263374.739999999991	2014-12-07 16:17:01.070635	\N
4082	Esporte 24h - CEE Thomas Mazoni	Praça Jânio da Silva Quadros, 150	-23.50078	-46.58335	0	2014-12-07 16:17:01.094747	\N
4083	Esporte 24h - Parque do Ibirapuera	Avenida Pedro Álvares Cabral, s/n - Parque Ibirapuera	-23.587441	-46.657666	263374.739999999991	2014-12-07 16:17:01.119346	\N
4084	Esporte 24h - CEL Teotônio Vilela	Rua Carlo Clausette,19 - Sapopemba	-23.605955	-46.502793	263374.739999999991	2014-12-07 16:17:01.142788	\N
4085	Equipamento esportivo - CEE Vicente Italo Feola	Pça Aroldo Dautro, s/n	-23.548534	-46.532341	383865.890000000014	2014-12-07 16:17:01.392686	\N
4086	Equipamento esportivo - Solange Nunes Bibas	R. Hernani da Gama Correia, 367	-23.574431	-46.723375	603001.459999999963	2014-12-07 16:17:01.417268	\N
4087	Equipamento esportivo - Balneário Mário Moraes	Rua Edward Carmilo, 840	-23.597911	-46.754353	526904.400000000023	2014-12-07 16:17:01.438876	\N
4088	Equipamento esportivo - Mini Balneário Sinésio Rocha	R. Sibaúma, 54	-23.620207	-46.754166	919978.949999999953	2014-12-07 16:17:01.462867	\N
4089	Equipamento esportivo - Mini Balneário Comandante Garcia D´ávila	Rua Armando Coelho e Silva, 775	-23.492284	-46.654953	0	2014-12-07 16:17:01.48688	\N
4090	Equipamento esportivo - CEL Cidade Tiradentes	Av. dos Metalúrgicos, 2255	-23.581678	-46.410468	517979.700000000012	2014-12-07 16:17:01.510154	\N
4091	Equipamento esportivo - CEL Juscelino Kubitschek	Rua Inácio Monteiro, 55	-23.564213	-46.413043	0	2014-12-07 16:17:01.534992	\N
4092	Equipamento esportivo - C.E.E Ermelino Matarazzo	R. Reverendo João Euclides Pereira, 8	0	0	0	2014-12-07 16:17:01.55776	\N
4093	Equipamento esportivo - CEE Oswaldo Brandão	Rua Michihisa Murata, 120	-23.475764	-46.697658	1496111.29000000004	2014-12-07 16:17:01.580303	\N
4094	Equipamento esportivo - CEE Aurélio Campos	Rua Jacutiba, 167	-23.48343	-46.693377	0	2014-12-07 16:17:01.603874	\N
4095	Equipamento esportivo - Balneário Carlos Joel Nelli	Pça Nami Jafet, 45	-23.580331	-46.605952	528707.010000000009	2014-12-07 16:17:01.626304	\N
4096	Equipamento esportivo - Balneário Princesa Isabel	Rua Campante, 100	-23.595345	-46.594811	0	2014-12-07 16:17:01.648085	\N
4097	Equipamento esportivo - CEE Flávio Calabrese Conti	Rua das Municipalidades, 10	-23.587902	-46.596807	0	2014-12-07 16:17:01.671276	\N
4098	Equipamento esportivo - CEE José Ermírio de Moraes	Rua Grapira, 537	-23.498032	-46.418558	225000	2014-12-07 16:17:01.695089	\N
4099	Equipamento esportivo - CEE Gerdy Gomes	Rua Professora Lucila Cerqueira, 194	-23.547327	-46.427774	0	2014-12-07 16:17:01.717538	\N
4100	Equipamento esportivo - CEE Rumi de Ranieri	Av. Afonso Sampaio e Souza, 2001	-23.575188	-46.477008	0	2014-12-07 16:17:01.740338	\N
4101	Equipamento esportivo - CEE José Bonifácio	Rua Ana Perena, 110	-23.547415	-46.436335	0	2014-12-07 16:17:01.764513	\N
4102	Equipamento esportivo - Balneário Jalisco	Rua Rodes, 112	-23.642323	-46.66757	465919.830000000016	2014-12-07 16:17:01.787524	\N
4103	Equipamento esportivo - C.E.E RYUSO OGAWA	Rua Lussanvira, 178	-23.641414	-46.63772	25992528	2014-12-07 16:17:01.811484	\N
4104	Equipamento esportivo - Balneário Irmãos Paolillo	Rua General Jerônimo Furtado, 751	-23.46424	-46.56904	430334.599999999977	2014-12-07 16:17:01.834491	\N
4105	Equipamento esportivo - CDC Ovideo Belo	Rua Capitão José Aguirre Camargo, 101	-23.445796	-46.612449	0	2014-12-07 16:17:01.856812	\N
4106	Equipamento esportivo - C.E.E Raul Tabajara	Rua Anhanguera, 484	-23.523562	-46.652833	1041980.58999999997	2014-12-07 16:17:01.879489	\N
4107	Equipamento esportivo - Estádio Municipal Jack Marin	Rua Muniz de Souza, 1119	-23.572425	-46.628982	0	2014-12-07 16:17:01.902731	\N
4108	Equipamento esportivo - CDC Jaguaré	Av. Presidente Altino, s/n	-23.531137	-46.757471	0	2014-12-07 16:17:01.92508	\N
4109	Equipamento esportivo - Mini Balneário Marechal Esperidião Rosas	Rua General Mac Arthur, 1304	-23.553749	-46.752836	519612.840000000026	2014-12-07 16:17:01.94841	\N
4110	Equipamento esportivo - CEE Edson Arantes do Nascimento	Rua Belmonte, 957	-23.525992	-46.720971	264780.799999999988	2014-12-07 16:17:01.972882	\N
4111	Equipamento esportivo - CDC União Brasiliense de Esportes	Rua Amâncio Pedro de Oliveira, 385	-23.651148	-46.747375	0	2014-12-07 16:17:01.997949	\N
4112	Equipamento esportivo - CEE Moóca Salim Farah Maluf	Rua Taquari, 635	-23.550818	-46.597289	0	2014-12-07 16:17:02.021376	\N
4113	Equipamento esportivo - CDC Vigor	Av. Carlos de Campos, 935	-23.525195	-46.610303	0	2014-12-07 16:17:02.0442	\N
4114	Equipamento esportivo - CEE Brigadeiro Eduardo Gomes	Rua Monte Serrat, 230	-23.539891	-46.562281	0	2014-12-07 16:17:02.066665	\N
4115	Equipamento esportivo - CEL José de Anchieta	Rua José Balanguio, 118	-23.551645	-46.485624	0	2014-12-07 16:17:02.089821	\N
4116	Equipamento esportivo - C.E.E. Luiz Martinez - Tiquatira	Av. Governador Carvalho Pinto, 2	-23.514512	-46.548816	310899.179999999993	2014-12-07 16:17:02.112923	\N
4117	Equipamento esportivo - CEL Brigadeiro Eduardo Gomes	R. João Amado Coutinho, 240	-23.447528	-46.714899	312352.159999999974	2014-12-07 16:17:02.140522	\N
4118	Equipamento esportivo - C.E.E Geraldo José de Almeida	Av. Agenor Couto de Magalhães, 32	-23.484286	-46.740702	249994.760000000009	2014-12-07 16:17:02.16372	\N
4119	Equipamento esportivo - Balneário Geraldo Alonso	R. Santos Dumont, 1318	-23.516735	-46.629594	272535.400000000023	2014-12-07 16:17:02.185892	\N
4120	Equipamento esportivo - Mini Balneário Gastão Moutinho	R. Coronel João da Silva Feijó, 80	-23.468639	-46.639067	545646.930000000051	2014-12-07 16:17:02.218547	\N
4121	Equipamento esportivo - CEE Alfredo Inácio Trindade	Rua Viri, 425	-23.493988	-46.612117	901626.939999999944	2014-12-07 16:17:02.242948	\N
4122	Equipamento esportivo - CEE Joerg Bruder	Av. Padre José Maria, 555	-23.654873	-46.70961	0	2014-12-07 16:17:02.266755	\N
4123	Equipamento esportivo - Mini Balneário Antonio Carlos de Abreu Sodré	R. Curiá, 149	-23.685658	-46.682219	526905.300000000047	2014-12-07 16:17:02.289701	\N
4124	Equipamento esportivo - Mini Balneário José Maria Withaker	Av. Satélite, 756	-23.61078	-46.46481	370904.5	2014-12-07 16:17:02.313331	\N
4125	Equipamento esportivo - Mini Balneário Pedro de Frontim	Rua Sargento Luis Batista, 83	-23.500217	-46.429158	307754.049999999988	2014-12-07 16:17:02.337884	\N
4126	Equipamento esportivo - CEE Tietê	Av. Santos Dumont, 843	-23.5213	-46.630549	0	2014-12-07 16:17:02.360907	\N
4127	Equipamento esportivo - Estádio Municipal de Baseball Mie Nishi	Av. Presidente Castello Branco, 5446	-23.520867	-46.642168	0	2014-12-07 16:17:02.384731	\N
4128	Equipamento esportivo - CEE Rubens Pecci Lordello	Av. Lins de Vanconcelos, 804	-23.57031	-46.62238	523245.190000000002	2014-12-07 16:17:02.407258	\N
4129	Equipamento esportivo - Estádio Municipal Paulo Machado de Carvalho - Pacaembu	Praça Charles Miller, s/n	-23.544842	-46.66548	1452610.40999999992	2014-12-07 16:17:02.429677	\N
4130	Equipamento esportivo - Ginásio Esportivo Darcy Reis	Av. Guilherme, 1819	-23.507851	-46.599789	0	2014-12-07 16:17:02.452864	\N
4131	Equipamento esportivo - C.E.E. Thomas Mazzoni	Praça Jânio da Silva Quadros, 150	-23.500768	-46.583331	130977.380000000005	2014-12-07 16:17:02.482285	\N
4132	Equipamento esportivo - CEE Modelódromo	Rua Curitiba, 290	-23.582297	-46.653187	0	2014-12-07 16:17:02.505554	\N
4133	Equipamento esportivo - C.E.E Mané Garrincha	R.Pedro de Toledo,1651	-23.598629	-46.652820	0	2014-12-07 16:17:02.527746	\N
4134	Equipamento esportivo - C.E.L Teotônio Vilela	R. Carlo Clausette, 19	-23.605953	-46.502865	259884.609999999986	2014-12-07 16:17:02.549985	\N
4135	Centro de Iniciação Esportiva - Freguesia/Brasilândia	Rua Reverendo Carlos Wesly, 336	-23.474041	-46.681898	0	2014-12-07 16:17:02.82729	\N
4136	Centro de Iniciação Esportiva - Campo Limpo	Estrada do Campo Limpo (terreno da unidade de transportes internos da subprefeitura)	-23.627330	-46.766791	0	2014-12-07 16:17:02.854193	\N
4137	Centro de Iniciação Esportiva - Guaianases	Estrada de Itaquera - Guaianases, s/n	-23.539857	-46.426247	0	2014-12-07 16:17:02.877615	\N
4138	Centro de Iniciação Esportiva - Jaguaré	Av. Presidente Altino, 1309	-23.544629	-46.751407	0	2014-12-07 16:17:02.904967	\N
4139	Centro de Iniciação Esportiva - Vila Prudente	Rua Tocuchica MiKi	-23.603649	-46.554344	0	2014-12-07 16:17:02.928418	\N
4140	Reforma e acessibilidade em passeios públicos	\N	0	0	17463684.4100000001	2014-12-07 16:17:03.144443	\N
4142	Aumento percentual da frota de ônibus acessível	\N	0	0	0	2014-12-07 16:17:03.493364	\N
4143	Vagas a crianças beneficiárias do Benefício de Prestação Continuada da Assistência Social (BPC)	\N	0	0	0	2014-12-07 16:17:03.673165	\N
4144	Operação e Manutenção da Central de Interpretação de Libras, intérpretes e guias-intérpretes	\N	0	0	0	2014-12-07 16:17:03.864482	\N
4145	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Butantã	Rua Manuel Jacinto, 249 – Vila Morse	-23.591033	-46.728145	0	2014-12-07 16:17:04.072747	\N
4146	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Campo Limpo	Rua Nossa Senhora do Bom Conselho, 65 – Jardim Laranjal	-23.647815	-46.756528	0	2014-12-07 16:17:04.104481	\N
4147	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Capela do Socorro	Rua Deputado Adib Chammas, 105 – Veleiros	-23.683208	-46.710839	0	2014-12-07 16:17:04.144786	\N
4148	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Freguesia/Brasilândia	Rua Léo Ribeiro de Moraes, 66 – Freguesia do Ó	-23.506467	-46.698032	0	2014-12-07 16:17:04.168245	\N
4149	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Guaianases	Rua Comandante Carlos Ruhl, 134 – Vila Princesa Isabel	-23.545899	-46.417315	\N	2014-12-07 16:17:04.192478	\N
4150	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Itaquera	Avenida Itaquera, 241 – Parque Maria Luiza	-23.557239	-46.519733	0	2014-12-07 16:17:04.216853	\N
4151	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Lapa	Rua Aurélia, 996.– Vila Romana	-23.530675	-46.698027	0	2014-12-07 16:17:04.251451	\N
4152	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Tatuapé	Rua Apucarana nº 215 – Tatuapé	-23.540179	-46.564886	\N	2014-12-07 16:17:04.278522	\N
4153	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Santana/Tucuruvi	Avenida Tucuruvi, 808 – Tucuruvi	-23.481243	-46.604257	0	2014-12-07 16:17:04.304808	\N
4154	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Santo Amaro	Rua Dr. Abelardo Vergueiro César, 370 – Vila Alexandria	-23.638597	-46.671182	0	2014-12-07 16:17:04.328903	\N
4155	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - São Mateus	Avenida Ragueb Chohfi, 1550 – São Mateus	-23.598702	-46.467973	\N	2014-12-07 16:17:04.356733	\N
4156	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - São Miguel	 Rua Daniel Bernardo, 95	-23.494143	-46.442232	\N	2014-12-07 16:17:04.388067	\N
4157	Revitalização do Centro de Formação e Acompanhamento à Inclusão (CEFAI) - Vila Mariana	Rua Leandro Dupret, 525 – Vila Clementino	-23.598875	-46.646754	\N	2014-12-07 16:17:04.423447	\N
4158	Residências inclusivas para pessoas com deficiência - Santo Amaro 1	Rua Conde de Itu, 503	-23.648163	-46.700763	280000	2014-12-07 16:17:04.66646	\N
4159	Residências inclusivas para pessoas com deficiência - Santo Amaro 2	Rua Comendador Elias Zarzur, 1151	-23.643092	-46.696226	280000	2014-12-07 16:17:04.695406	\N
4160	Residências inclusivas para pessoas com deficiência - Bela Vista 1	Rua dos Ingleses, 160	-23.559142	-46.647142	280000	2014-12-07 16:17:04.722438	\N
4161	Residências inclusivas para pessoas com deficiência - Bela Vista 2	Rua Baronesa de Porto Carreiro, 247	0	0	280000	2014-12-07 16:17:04.751559	\N
4162	Centro Especializado de Reabilitação 1 (CER IV Santo Amaro com Ofina Ortopédica)	Av. Yervant Kissajkian, 400	-23.667006	-46.675183	0	2014-12-07 16:17:04.964038	\N
4163	Centro Especializado de Reabilitação 3 (CER IV Casa Verde com Oficina Ortopédica)	Rua Gabriel Covelli x Rua Anísio Moreira	-23.496344	-46.655980	0	2014-12-07 16:17:04.998717	\N
4164	Centro Especializado de Reabilitação 9 (CER IV Itaquera com Oficina Ortopédica)	Rua Charles Manguim, s/n	-23.562787	-46.496580	0	2014-12-07 16:17:05.026833	\N
4165	Centro Especializado de Reabilitação 5 (CER IV Cidade Tiradentes)	Av. dos Metalúrgicos, 999, Lt 14, AD 5C	-23.591394	-46.407461	0	2014-12-07 16:17:05.050679	\N
4166	Centro Especializado de Reabilitação 8 (CER IV Ermelino Matarazzo)	Rua Danilo Fellipe, s/n	-23.486694	-46.471765	0	2014-12-07 16:17:05.075457	\N
4167	Centro Especializado de Reabilitação 6 (CER IV Mooca com Oficina Ortopédica)	Rua Jaibarás, 299	-23.548095	-46.597129	0	2014-12-07 16:17:05.099766	\N
4168	Centro Especializado de Reabilitação 2 (CER IV Pirituba)	Rua General Lauro Cavalcanti de Farias, 171	-23.492661	-46.747040	0	2014-12-07 16:17:05.125033	\N
4169	Centro Especializado de Reabilitação 7 (CER IV São Mateus)	Rua Pascoal Dias, s/n	-23.616929	-46.478815	0	2014-12-07 16:17:05.149956	\N
4170	Centro Especializado de Reabilitação 4 (CER IV Vila Mariana)	Rua Loefren, 1125	-23.599650	-46.636618	0	2014-12-07 16:17:05.174143	\N
4171	Centro Especializado de Reabilitação 10 (CER IV Butantã com Oficina Ortopédica)	Av. Eliseu de Almeida, 4000 V. Sônia	-23.590795	-46.737768	0	2014-12-07 16:17:05.198979	\N
4172	Criação e efetivação da Secretaria Municipal de Promoção da Igualdade Racial	\N	0	0	0	2014-12-07 16:17:05.419762	\N
4173	Capacitação de professores para ensino de História  e Cultura Afro-Brasileira e Indígena nas escoals	\N	0	0	75000	2014-12-07 16:17:05.625826	\N
4174	Outras formações para o ensino de História e Cultura Afro-Brasileira e Indígena	\N	0	0	0	2014-12-07 16:17:05.653369	\N
4175	Publicação dos 2 volumes sobre História Geral da África	\N	0	0	0	2014-12-07 16:17:05.680752	\N
4176	Criação e efetivação da Secretaria Municipal de Políticas para as Mulheres	\N	0	0	0	2014-12-07 16:17:05.886555	\N
4177	Reestruturação do Centro de Cidadania da Mulher - Capela do Socorro	Rua Professor Oscar Barreto Filho, 350 - Parque América – Grajaú	-23.735138	-46.691135	0	2014-12-07 16:17:06.091143	\N
4178	Reestruturação do Centro de Cidadania da Mulher - Itaquera	Rua Ibiajara, 495 – Itaquera	-23.529907	-46.434898	0	2014-12-07 16:17:06.119199	\N
4179	Reestruturação do Centro de Cidadania da Mulher - Parelheiros	Rua Terezinha do Prado Oliveira, 119 – Parelheiros	-23.828437	-46.723096	0	2014-12-07 16:17:06.145179	\N
4180	Reestruturação do Centro de Cidadania da Mulher - Perus	Rua Joaquim Antonio Arruda, 74 – Perus	-23.405768	-46.754853	0	2014-12-07 16:17:06.169165	\N
4181	Reestruturação do Centro de Cidadania da Mulher - Santo Amaro	Rua Mário Lopes Leão, 240 – Santo Amaro	-23.650627	-46.708569	0	2014-12-07 16:17:06.194631	\N
4182	Implantação de Centro de Referência e Combate à Homofobia	\N	0	0	0	2014-12-07 16:17:06.417386	\N
4183	Implantação de Unidades móveis de Atendimento ao público LGBT	\N	0	0	0	2014-12-07 16:17:06.445151	\N
4184	Promoção de atividades de combate à homofobia em espaços públicos: Largo do Arouche e Republica	\N	0	0	0	2014-12-07 16:17:06.472837	\N
4185	Paradas do Orgulho LGBT	\N	0	0	1850000	2014-12-07 16:17:06.497255	\N
4186	Atividades de formação continuada na rede municipal de ensino pela convivência pacífica com as diferenças	\N	0	0	0	2014-12-07 16:17:06.52391	\N
4187	Campanhas contra a homofobia	\N	0	0	0	2014-12-07 16:17:06.54916	\N
4188	Programa Transcidadania	\N	0	0	0	2014-12-07 16:17:06.572821	\N
4189	Implantação da Ouvidoria Municipal de Direitos Humanos	\N	0	0	0	2014-12-07 16:17:06.796652	\N
4190	Centro de Educação em Direitos Humanos - Zona Sul	Rua João Damasceno, 85	-23.646610	-46.743985	0	2014-12-07 16:17:07.005732	\N
4191	Centro de Educação em Direitos Humanos - Zona Norte	Rua Aparecida do Taboado, S/N	-23.461580	-46.711012	0	2014-12-07 16:17:07.03293	\N
4192	Centro de Educação em Direitos Humanos - Zona Oeste	Rua Pêra Marmelo, 226	-23.437181	-46.750754	0	2014-12-07 16:17:07.059192	\N
4193	Centro de Educação em Direitos Humanos - Zona Leste	Rua Cinira Polonio, 100	-23.620552	-46.456240	0	2014-12-07 16:17:07.082999	\N
4194	Prêmio Municipal de Educação em Direitos Humanos	\N	0	0	33915.1399999999994	2014-12-07 16:17:07.109037	\N
4195	Formação em questões de Direitos Humanos para os profissionais da Rede Municipal de Ensino	\N	0	0	0	2014-12-07 16:17:07.134037	\N
4196	Produção de Material Didático (Direitos Humanos)	\N	0	0	300000	2014-12-07 16:17:07.157903	\N
4197	Reformulação de Projetos Político Pedagógicos (Educação em Direitos Humanos)	\N	0	0	0	2014-12-07 16:17:07.181573	\N
4198	Criação e funcionamento da Comissão Municipal da Verdade (CMV-PMSP)	\N	0	0	0	2014-12-07 16:17:07.399974	\N
4199	Memorial Cemitério de Vila Formosa	Cemitério de Vila Formosa	-23.565246	-46.525751	0	2014-12-07 16:17:07.426675	\N
4200	Memorial Cemitério de Perus	Cemitério de Perus	-23.640183	-46.642972	0	2014-12-07 16:17:07.453016	\N
4201	Memorial Cemitério do Araçá	Cemitério do Araçá	-23.553267	-46.668711	0	2014-12-07 16:17:07.478982	\N
4202	Apoio à retomada da identificação de mortos e desaparecidos políticos da ditadura militar	\N	0	0	0	2014-12-07 16:17:07.502367	\N
4203	Educação e cultura pelo direito à memória e à verdade	\N	0	0	0	2014-12-07 16:17:07.526547	\N
4204	Memorial Parque do Ibirapuera	Parque do Ibirapuera	-23.586486	-46.657698	0	2014-12-07 16:17:07.551256	\N
4205	Ocupação do Espaço Público: Regularização e Apoio a feiras culturais de migrantes	\N	0	0	0	2014-12-07 16:17:07.788629	\N
4206	Ocupação do Espaço Público: Valorização de Festividades Migrantes	\N	0	0	41290.8499999999985	2014-12-07 16:17:07.83456	\N
4207	Campanha de Conscientização e Prevenção à xenofobia	\N	0	0	7748.86999999999989	2014-12-07 16:17:07.869815	\N
4208	Mapeamento da População Migrante	\N	0	0	0	2014-12-07 16:17:07.89508	\N
4209	Qualificação da atenção aos migrantes por agentes públicos	\N	0	0	0	2014-12-07 16:17:07.919851	\N
4210	Regularização migratória e promoção ao trabalho decente	\N	0	0	0	2014-12-07 16:17:07.945606	\N
4211	PRONATEC Imigrantes - Curso de Português	\N	0	0	0	2014-12-07 16:17:07.970661	\N
4212	Conselho Tutelar Modelo em Itaquera	\N	0	0	0	2014-12-07 16:17:08.196104	\N
4213	Política permanente de formação dos Conselhos Tutelares	\N	0	0	0	2014-12-07 16:17:08.225086	\N
4214	Melhoria da infraestrutura dos Conselhos Tutelares	\N	0	0	0	2014-12-07 16:17:08.253656	\N
4215	Unidade de Referência à Saúde do Idoso - URSI Capela do Socorro	\N	0	0	0	2014-12-07 16:17:08.522373	\N
4216	Unidade de Referência à Saúde do Idoso - URSI Itaquera	\N	0	0	0	2014-12-07 16:17:08.549319	\N
4217	Unidade de Referência à Saúde do Idoso - URSI Campo Limpo	Rua Antonio Antunes, s/n	-23.637891	-46.772725	0	2014-12-07 16:17:08.578501	\N
4218	Unidade de Referência à Saúde do Idoso - URSI Itaim Paulista	Rua Ambaré, s/n	-23.506769	-46.396482	0	2014-12-07 16:17:08.602516	\N
4219	Unidade de Referência à Saúde do Idoso - URSI Butantã	Rua Antonino de Camargo X Rodovia Raposo Tavares	-23.586170	-46.749313	0	2014-12-07 16:17:08.626005	\N
4220	Unidade de Referência à Saúde do Idoso - URSI Pirituba	Rua General Lauro Cavalcanti de Farias, 171	-23.492681	-46.747008	0	2014-12-07 16:17:08.650296	\N
4221	Unidade de Referência à Saúde do Idoso - URSI São Mateus	Rua Ângelo Candia, 1058	-23.599290	-46.483309	0	2014-12-07 16:17:08.67438	\N
4222	Unidade de Referência à Saúde do Idoso - URSI Vila Prudente	Av. Francisco Falconi, 83 (2ª opção Rua Lisa Ansorge, 614)	-23.583672	-46.568532	0	2014-12-07 16:17:08.698674	\N
4223	Implantação de Centro Dia para Idosos - Raposo Tavares	R Antonio de CamargoXRaposo Tavares	0	0	0	2014-12-07 16:17:08.944716	\N
4224	Implantação de Centro Dia para Idosos - Mooca I	R Catumbi, 588/626	-23.533195	-46.601105	0	2014-12-07 16:17:08.972832	\N
4225	Implantação de Centro Dia para Idosos - Capão Redondo	\N	0	0	0	2014-12-07 16:17:09.00035	\N
4226	Implantação de Centro Dia para Idosos - Grajau	\N	0	0	0	2014-12-07 16:17:09.030011	\N
4227	Implantação de Centro Dia para Idosos - Cidade Ademar	\N	0	0	0	2014-12-07 16:17:09.054231	\N
4228	Implantação de Centro Dia para Idosos - Brasilândia	\N	0	0	0	2014-12-07 16:17:09.078465	\N
4229	Implantação de Centro Dia para Idosos - Lajeado	\N	0	0	0	2014-12-07 16:17:09.102496	\N
4230	Implantação de Centro Dia para Idosos - Sacomã	\N	0	0	0	2014-12-07 16:17:09.126568	\N
4231	Implantação de Centro Dia para Idosos - Itaim Paulista	\N	0	0	0	2014-12-07 16:17:09.152618	\N
4232	Implantação de Centro Dia para Idosos - Itaquera	\N	0	0	0	2014-12-07 16:17:09.177365	\N
4233	Implantação de Centro Dia para Idosos - Tremembé	\N	0	0	0	2014-12-07 16:17:09.201905	\N
4234	Implantação de Centro Dia para Idosos - Jardim Ângela	\N	0	0	0	2014-12-07 16:17:09.225038	\N
4235	Implantação de Centro Dia para Idosos - Jaraguá	\N	0	0	0	2014-12-07 16:17:09.249337	\N
4236	Implantação de Centro Dia para Idosos - São Mateus	\N	0	0	0	2014-12-07 16:17:09.273855	\N
4237	Implantação de Centro Dia para Idosos - Jardim Helena	\N	0	0	0	2014-12-07 16:17:09.298384	\N
4238	Implantação de Centro Dia para Idosos - Sapopemba	\N	0	0	0	2014-12-07 16:17:09.322456	\N
4239	Campanha de conscientização sobre a violência contra a pessoa idosa	\N	0	0	100000	2014-12-07 16:17:09.580971	\N
4240	Seminários anuais de conscientização sobre a violência contra a pessoa idosa	\N	0	0	32105.630000000001	2014-12-07 16:17:09.609511	\N
4241	Instituição de Longa Permanência para Idosos - ILPI Parelheiros	Avenida Senador Teotônio Vilela; Avenida Sadamu Inoue; Estrada Colônia e Estrada Vargem Grande	-23.772704	-46.721865	0	2014-12-07 16:17:09.855279	\N
4242	Instituição de Longa Permanência para Idosos - ILPI Vila Mariana	\N	0	0	0	2014-12-07 16:17:09.894501	\N
4243	Instituição de Longa Permanência para Idosos - ILPI Vila Prudente	\N	0	0	0	2014-12-07 16:17:09.920346	\N
4244	Instituição de Longa Permanência para Idosos - ILPI Ermelino Matarazzo	\N	0	0	0	2014-12-07 16:17:09.945637	\N
4245	Instituição de Longa Permanência para Idosos - ILPI Ipiranga	\N	0	0	0	2014-12-07 16:17:09.970562	\N
4246	Criação da Universidade Aberta da Pessoa Idosa (UAPI)	Rua Teixeira Mendes, 262	-23.559491	-46.624443	70862.1399999999994	2014-12-07 16:17:10.247493	\N
4247	Requalificação do Pátio do Pari	Pátio do Pari	-23.537878	-46.624705	0	2014-12-07 16:17:10.521058	\N
4248	Requalificação do Anhangabaú e calçadões do centro	Vale do Anhangabaú	-23.544587	-46.636282	0	2014-12-07 16:17:10.556548	\N
4249	Requalificação do Mercado Municipal	Rua Da Cantareira, 306 - Luz - São Paulo -SP	-23.541958	-46.629406	0	2014-12-07 16:17:10.5825	\N
4250	Requalificação do Parque Dom Pedro II	Parque Dom Pedro II	-23.546158	-46.628618	0	2014-12-07 16:17:10.616183	\N
4251	PRAÇA SAMPAIO VIDAL	Avenida Doutor Eduardo Cotching, 2294	0	0	0	2014-12-07 16:17:10.93409	\N
4252	PARQUE ALFREDO VOLPI	Av. Eng. Oscar Americano, 480	0	0	0	2014-12-07 16:17:10.965445	\N
4253	PRAÇA ELIS REGINA	Praça Elis Regina	0	0	0	2014-12-07 16:17:10.99626	\N
4254	PRAÇA JOÃO TADEU PRIOLLI (PRAÇA DO CAMPO LIMPO)	Praça João Tadeu Priolli	-23.633683	-46.776161	0	2014-12-07 16:17:11.025103	\N
4255	PARQUE SANTO DIAS	Rua Arroio das Caneleiras, s/n - Conjunto Habitacional Instituto Adventista	0	0	0	2014-12-07 16:17:11.05228	\N
4256	PRAÇA ESCOLAR	Praça Escolar, Cidade Dutra	0	0	0	2014-12-07 16:17:11.079351	\N
4257	LARGO DO JAPONES	Largo do Japones	-23.473973	-46.667265	0	2014-12-07 16:17:11.106716	\N
4258	PRAÇA DAS MONÇÕES (TERMINAL CASA VERDE)	Av. Eng. Caetano Álvares	0	0	0	2014-12-07 16:17:11.13409	\N
4259	PRAÇA MARCO ANTONIO PRIMON MAESTRE	Praça Marco Antônio Primon Maestre	0	0	0	2014-12-07 16:17:11.170561	\N
4260	PRAÇA BACHAREL FERNADO BRAGA PEREIRA DA ROCHA	Praça Bacharel Fernando Braga Pereira da Rocha	-23.541799	-46.716442	0	2014-12-07 16:17:11.197772	\N
4261	PRAÇA DO 65	Avenida dos Metalúrgicos, 2249	0	0	0	2014-12-07 16:17:11.222912	\N
4262	PRAÇA NA RUA DAS IMBIRAIARAS ALT. Nº 400	Rua Ibiraiaras, 400	0	0	0	2014-12-07 16:17:11.249606	\N
4263	LARGO DA MATRIZ	Largo da Matriz de Nossa Senhora do Ó, 177	0	0	0	2014-12-07 16:17:11.274967	\N
4264	PRAÇA CECÍLIA MARQUES DE ARAÚJO	Rua Gonçalves de Oliveira, 13	0	0	0	2014-12-07 16:17:11.302355	\N
4265	PRAÇA JAGUAMITANGA	Rua Guaxima, 163, Vila Curuçá	0	0	0	2014-12-07 16:17:11.332971	\N
4266	PARQUE CHICO MENDES	Parque Chico Mendes - Rua Cembira, Vila Curuçá	0	0	0	2014-12-07 16:17:11.359614	\N
4267	PARQUE SANTA AMÉLIA	Rua Rio Contagem, 72	0	0	0	2014-12-07 16:17:11.385188	\N
4268	PRAÇA PROFESSORAS	Avenida das Alamandas, 12	0	0	0	2014-12-07 16:17:11.410862	\N
4269	PARQUE RAUL SEIXAS	Rua Murmúrios da Tarde, 190 - Jardim Bonifacio, SP	0	0	0	2014-12-07 16:17:11.437601	\N
4270	PARQUE DO NABUCO	Parque do Nabuco	-23.663314	-46.660422	0	2014-12-07 16:17:11.464789	\N
4271	PRAÇA ALFREDO EGYDIO DE SOUZA ARANHA	Praça Alfredo Egydio de Souza Aranha	-23.638043	-46.642778	0	2014-12-07 16:17:11.492196	\N
4272	PRAÇA MARIQUINHA SCIASCIA	Praça Dona Mariquinha Sciascia - Tremembé	-23.57112	-46.640227	0	2014-12-07 16:17:11.51793	\N
4273	PRAÇA DOUTOR JOÃO BATISTA VASQUES	Rua Benjamin Pereira, 762	-23.465785	-46.58452	0	2014-12-07 16:17:11.544506	\N
4274	PRAÇA ZILDA NATEL	Av. Dr. Arnaldo, 1250 - Perdizes	0	0	0	2014-12-07 16:17:11.570094	\N
4275	PARQUE ORLANDO VILLAS BÔAS	Av. Embaixador Macedo Soares, 6715	0	0	0	2014-12-07 16:17:11.596145	\N
4276	PRAÇA GEN. PORTO CARREIRO	Praça General Porto Carreiro	0	0	0	2014-12-07 16:17:11.622049	\N
4277	PRAÇA GENERAL GUIMARÃES	Praça General Guimarães	0	0	0	2014-12-07 16:17:11.648581	\N
4278	PRAÇA CONDE FRANCISCO MATARAZZO	Praça Conde Francisco Matarazzo Junior	0	0	0	2014-12-07 16:17:11.675369	\N
4279	PRAÇA CORNÉLIA	R. Crasso, 289 - Lapa São Paulo, 05043-010	0	0	0	2014-12-07 16:17:11.70173	\N
4280	PRAÇA DO LARGO DE PIRAPORINHA	Estrada do M’Boi Mirim, 1.000	0	0	0	2014-12-07 16:17:11.727037	\N
4281	PRAÇA GENERAL HUMBERTO DE SOUSA MELLO	Rua Catumbi,190	0	0	0	2014-12-07 16:17:11.754337	\N
4282	LARGO DA CONCÓRDIA	Largo da Concórdia, 91	0	0	0	2014-12-07 16:17:11.779616	\N
4283	PRAÇA SÃO LUIS DO CURU	Rua Capitão Lorena, 84	0	0	0	2014-12-07 16:17:11.805813	\N
4284	PRAÇA CIRO PONTES / AO LADO DO SENAI	Rua Bresser, 2800	0	0	0	2014-12-07 16:17:11.830804	\N
4285	PRAÇA DILVA GOMES MARTINS (COHAB 1)	Praça Dilva Gomes Martins	-23.545675	-46.482643	0	2014-12-07 16:17:11.856275	\N
4286	PARQUE LINEAR TIQUATIRA	Avenida Governador Carvalho Pinto, 1759	0	0	0	2014-12-07 16:17:11.882438	\N
4287	PRAÇA DA CONQUISTA	Rua Dona Matilde, 479	0	0	0	2014-12-07 16:17:11.907213	\N
4288	LARGO DO ROSÁRIO	Largo do Rosário, 15, São Paulo, Brasil	0	0	0	2014-12-07 16:17:11.934668	\N
4289	PRAÇA VIGÁRIO JOÃO G. DE LIMA (PRAÇA DO SAMBA)	Praça Vigário João Gonçalves de Lima	-23.410208	-46.757485	0	2014-12-07 16:17:11.960783	\N
4290	PRAÇA BENEDITO CALIXTO	Praça Benedito Calixto	-23.55789	-46.680719	0	2014-12-07 16:17:11.985727	\N
4291	PRAÇA ARLINDO ROSSI	R. Araçaíba, 38 - Brooklin, Itaim Bibi	0	0	0	2014-12-07 16:17:12.011727	\N
4292	PRAÇA FLORIANO PEIXOTO	Praça Floriano Peixoto	-23.651355	-46.707646	0	2014-12-07 16:17:12.037592	\N
4293	CDC CAMPO BELO	Rua Sapoti, 20	0	0	0	2014-12-07 16:17:12.06421	\N
4294	PRAÇA TUNEY ARANTES	Praça Tuney Arantes‎, Jardim Anhanguera	0	0	0	2014-12-07 16:17:12.090735	\N
4295	PRAÇA OSVALDO LUÍS DA SILVEIRA	Rua Ponte do Guaré, 88, São Paulo, Brasil	0	0	0	2014-12-07 16:17:12.134192	\N
4296	PRAÇA OSLEI FRANCISCO BORGES	Rua Tauro, 58 - Recanto Verde do Sol, São Paulo	0	0	0	2014-12-07 16:17:12.167276	\N
4297	PRAÇA PADRE ALEIXO MONTEIRO MAFRA (DO FORRÓ)	Praça Padre Aleixo Monteiro Mafra	0	0	0	2014-12-07 16:17:12.193705	\N
4298	PRAÇA CRAVEIRO DO CAMPO	Rua Kumaki Aoki, 1074, Jardim Helena	0	0	0	2014-12-07 16:17:12.219239	\N
4299	MERCADO MUNICIPAL	Mercado Municipal	-23.541307	-46.629392	0	2014-12-07 16:17:12.245089	\N
4300	PATEO DO COLÉGIO	Pateo do Colégio	-23.547779	-46.632589	0	2014-12-07 16:17:12.270803	\N
4301	CENTRO CULTURAL SÃO PAULO	Rua Vergueiro, 1000 - Paraíso	-23.57112	-46.640227	0	2014-12-07 16:17:12.29666	\N
4302	PRAÇA ROOSEVELT	Praça Franklin Roosevelt, S/N	0	0	0	2014-12-07 16:17:12.322447	\N
4303	PRAÇA DOM JOSÉ GASPAR	Rua Doutor Bráulio Gomes, 49	0	0	0	2014-12-07 16:17:12.348684	\N
4304	PRAÇA DON ORIONE	Viaduto Armando Puglisi	0	0	0	2014-12-07 16:17:12.374452	\N
4305	PARQUE DA ACLIMAÇÃO	R. Muniz de Sousa, 1119	0	0	0	2014-12-07 16:17:12.411476	\N
4306	LARGO DO CAMBUCI	Rua da Independência, 94	0	0	0	2014-12-07 16:17:12.437079	\N
4307	PRAÇA ROTARY	Rua Major Sertório, 561	0	0	0	2014-12-07 16:17:12.465101	\N
4308	LARGO DO AROUCHE	Largo do Arouche, 394	0	0	0	2014-12-07 16:17:12.50095	\N
4309	PRAÇA DA LIBERDADE	Praça da Liberdade, 264	-19.932016	-43.938031	0	2014-12-07 16:17:12.537759	\N
4310	PARQUE DOM PEDRO II	Rua Jorge Azem, 21	0	0	0	2014-12-07 16:17:12.573129	\N
4311	PRAÇA DA BANDEIRA	Passarela dos Piques / Praça da Bandeira	0	0	0	2014-12-07 16:17:12.608277	\N
4312	LARGO SÃO BENTO	Rua Líbero Badaró, 641	0	0	0	2014-12-07 16:17:12.638781	\N
4313	PRAÇA RAMOS DE AZEVEDO	Rua Coronel Xavier de Toledo, 254	-23.545242	-46.639012	0	2014-12-07 16:17:12.669644	\N
4314	PRAÇA DO PATRIARCA	Praça do Patriarca	0	0	0	2014-12-07 16:17:12.698219	\N
4315	PRAÇA OSCAR DA SILVA	Praça Oscar da Silva - Vila Guilherme	0	0	0	2014-12-07 16:17:12.724622	\N
4316	LARGO DE MOEMA	Largo de Moema	-23.603102	-46.661201	0	2014-12-07 16:17:12.753027	\N
4317	LARGO DONA ANA ROSA	Rua Vergueiro, 2.100 , São Paulo, 04106-090	0	0	0	2014-12-07 16:17:12.780111	\N
4318	PARQUE ECOLÓGICO VILA PRUDENTE	Parque Ecológico Vila Prudente, São Paulo, SP	0	0	0	2014-12-07 16:17:12.80637	\N
4319	Implantação de Pontos de Iluminação Pública	\N	0	0	42213760	2014-12-07 16:17:13.274795	\N
4320	Pontes Laguna / Itapaiuna	\N	0	0	356784611.170000017	2014-12-07 16:17:13.601057	\N
4321	Demais obras previstas no âmbito da Operação Urbana Consorciada Água Espraiada (OUCAE)	\N	0	0	356784611.170000017	2014-12-07 16:17:13.643974	\N
4322	Programas de requalificação do espaço público - Aricanduva/Formosa/Carrão	\N	0	0	0	2014-12-07 16:17:13.927612	\N
4323	Programas de requalificação do espaço público - Butantã	\N	0	0	0	2014-12-07 16:17:13.958093	\N
4324	Programas de requalificação do espaço público - Campo Limpo	\N	0	0	0	2014-12-07 16:17:13.992507	\N
4325	Programas de requalificação do espaço público - Capela do Socorro	\N	0	0	0	2014-12-07 16:17:14.026139	\N
4326	Programas de requalificação do espaço público - Casa Verde/Cachoeirinha	\N	0	0	0	2014-12-07 16:17:14.053657	\N
4327	Programas de requalificação do espaço público - Cidade Ademar	\N	0	0	0	2014-12-07 16:17:14.079628	\N
4328	Programas de requalificação do espaço público - Cidade Tiradentes	\N	0	0	0	2014-12-07 16:17:14.105667	\N
4329	Programas de requalificação do espaço público - Ermelino Matarazzo	\N	0	0	0	2014-12-07 16:17:14.131486	\N
4330	Programas de requalificação do espaço público - Freguesia do Ó	\N	0	0	0	2014-12-07 16:17:14.158206	\N
4331	Programas de requalificação do espaço público - Guaianases	\N	0	0	0	2014-12-07 16:17:14.184133	\N
4332	Programas de requalificação do espaço público - Ipiranga	\N	0	0	0	2014-12-07 16:17:14.210387	\N
4333	Programas de requalificação do espaço público - Itaim Paulista	\N	0	0	0	2014-12-07 16:17:14.235509	\N
4334	Programas de requalificação do espaço público - Itaquera	\N	0	0	0	2014-12-07 16:17:14.261193	\N
4335	Programas de requalificação do espaço público - Jabaquara	\N	0	0	0	2014-12-07 16:17:14.287833	\N
4336	Programas de requalificação do espaço público - Jaçanã	\N	0	0	0	2014-12-07 16:17:14.314766	\N
4337	Programas de requalificação do espaço público - Lapa	\N	0	0	0	2014-12-07 16:17:14.343557	\N
4338	Programas de requalificação do espaço público - M Boi Mirim	\N	0	0	0	2014-12-07 16:17:14.369392	\N
4339	Programas de requalificação do espaço público - Mooca	\N	0	0	0	2014-12-07 16:17:14.396437	\N
4340	Programas de requalificação do espaço público - Parelheiros	\N	0	0	0	2014-12-07 16:17:14.428266	\N
4341	Programas de requalificação do espaço público - Penha	\N	0	0	0	2014-12-07 16:17:14.460197	\N
4342	Programas de requalificação do espaço público - Perus	\N	0	0	0	2014-12-07 16:17:14.489377	\N
4343	Programas de requalificação do espaço público - Pinheiros	\N	0	0	0	2014-12-07 16:17:14.516119	\N
4344	Programas de requalificação do espaço público - Pirituba	\N	0	0	0	2014-12-07 16:17:14.542288	\N
4345	Programas de requalificação do espaço público - Santana/Tucuruvi	\N	0	0	0	2014-12-07 16:17:14.568525	\N
4346	Programas de requalificação do espaço público - Santo Amaro	\N	0	0	0	2014-12-07 16:17:14.594974	\N
4347	Programas de requalificação do espaço público - Sapopemba	\N	0	0	0	2014-12-07 16:17:14.621054	\N
4348	Programas de requalificação do espaço público - São Mateus	\N	0	0	0	2014-12-07 16:17:14.64674	\N
4349	Programas de requalificação do espaço público - São Miguel	\N	0	0	0	2014-12-07 16:17:14.67212	\N
4350	Programas de requalificação do espaço público - Sé	\N	0	0	0	2014-12-07 16:17:14.697932	\N
4351	Programas de requalificação do espaço público - Vila Maria	\N	0	0	0	2014-12-07 16:17:14.722811	\N
4352	Programas de requalificação do espaço público - Vila Mariana	\N	0	0	0	2014-12-07 16:17:14.748556	\N
4353	Programas de requalificação do espaço público - Vila Prudente	\N	0	0	0	2014-12-07 16:17:14.773838	\N
4354	Implantação da ADESAMPA - Aricanduva/Formosa/Carrão	Rua Atucuri, 699 - CEP 03411-000	0	0	20778.2599999999984	2014-12-07 16:17:15.093251	\N
4355	Implantação da ADESAMPA - Butantã	Rua Ulpiano da Costa Manso, 201 - CEP 05538-000	0	0	22631.9300000000003	2014-12-07 16:17:15.123802	\N
4356	Implantação da ADESAMPA - Campo Limpo	Rua Nossa Senhora do Bom Conselho, 59 - CEP 05763-470	0	0	21084.0499999999993	2014-12-07 16:17:15.152414	\N
4357	Implantação da ADESAMPA - Capela do Socorro	Rua Cassiano dos Santos, 499 - CEP 04827-000	0	0	22631.9300000000003	2014-12-07 16:17:15.177323	\N
4358	Implantação da ADESAMPA - Casa Verde/Cachoeirinha	Rua Av. Ordem e Progresso, 1001 - CEP 02518-130	0	0	18714.4199999999983	2014-12-07 16:17:15.20246	\N
4359	Implantação da ADESAMPA - Cidade Ademar	Av. Yervant Kissajikain, 416 - CEP 04657-000	0	0	21600.0099999999984	2014-12-07 16:17:15.227296	\N
4360	Implantação da ADESAMPA - Cidade Tiradentes	Estrada do Iguatemi, 2751 - CEP 08375-000	0	0	22631.9300000000003	2014-12-07 16:17:15.252331	\N
4361	Implantação da ADESAMPA - Ermelino Matarazzo	Av. São Miguel, 5550 - CEP 03871-100	0	0	20568.9000000000015	2014-12-07 16:17:15.277215	\N
4362	Implantação da ADESAMPA - Freguesia/Brasilândia	Av. João Marcelino Branco, 95 - CEP 02610-000	0	0	22115.9700000000012	2014-12-07 16:17:15.302359	\N
4363	Implantação da ADESAMPA - Guaianases	\N	0	0	0	2014-12-07 16:17:15.326691	\N
4364	Implantação da ADESAMPA - Ipiranga	R. Lino Coutinho, 444 - CEP 04207 000	0	0	16344.7900000000009	2014-12-07 16:17:15.35121	\N
4365	Implantação da ADESAMPA - Itaim Paulista	Av. Marechal Tito, 3012 - CEP 08115-000	0	0	22631.9300000000003	2014-12-07 16:17:15.376344	\N
4366	Implantação da ADESAMPA - Itaquera	R. Augusto Carlos Bauman, 851 - CEP 08210-590	0	0	16860.75	2014-12-07 16:17:15.401774	\N
4367	Implantação da ADESAMPA - Jabaquara	Av. Engº Armando de Arruda Pereira, 2314 - CEP 04309-011	0	0	16344.7900000000009	2014-12-07 16:17:15.426209	\N
4368	Implantação da ADESAMPA - Jaçanã/Tremembé	Av. Luis Stamatis, 300 - CEP 02260-000	0	0	22631.9300000000003	2014-12-07 16:17:15.45097	\N
4369	Implantação da ADESAMPA - Lapa	Rua Guaicurus, 1000 - CEP 05033-002	0	0	24179.8100000000013	2014-12-07 16:17:15.478402	\N
4370	Implantação da ADESAMPA - M'Boi Mirim	Av. Guarapiranga, 1265 - CEP 04902-903	0	0	21084.0499999999993	2014-12-07 16:17:15.507632	\N
4371	Implantação da ADESAMPA - Mooca	R. Taquari, 549 - CEP 03166-000	0	0	24179.8100000000013	2014-12-07 16:17:15.533305	\N
4372	Implantação da ADESAMPA - Parelheiros	Av. Sadamu Inoue, 5252 - CEP 04825-000	0	0	21600.0099999999984	2014-12-07 16:17:15.558658	\N
4373	Implantação da ADESAMPA - Penha	R. Candapuí, 492 - CEP 03621-000	0	0	23147.8899999999994	2014-12-07 16:17:15.586557	\N
4374	Implantação da ADESAMPA - Perus	R. Ylídio Figueiredo, 349 - CEP 05204-020	0	0	22115.9700000000012	2014-12-07 16:17:15.612612	\N
4375	Implantação da ADESAMPA - Pinheiros	Av. Nações Unidas, 7123 - CEP 05425-070	0	0	22631.9300000000003	2014-12-07 16:17:15.637617	\N
4376	Implantação da ADESAMPA - Pirituba	R. Luiz Carneiro, 192 - 02936-110	0	0	21084.0499999999993	2014-12-07 16:17:15.662884	\N
4377	Implantação da ADESAMPA - Santana/Tucuruvi	Av. Tucuruvi, 808 - CEP 02304-002	0	0	22631.9300000000003	2014-12-07 16:17:15.690945	\N
4378	Implantação da ADESAMPA - Santo Amaro	Praça Floriano Peixoto, 54 - CEP 04751-030	0	0	22115.9700000000012	2014-12-07 16:17:15.717149	\N
4379	Implantação da ADESAMPA - Sapopemba	Avenida Sapopemba, 9064	-23.600188	-46.512823	0	2014-12-07 16:17:15.742246	\N
4380	Implantação da ADESAMPA - São Mateus	R. Ragueb Chohfi, 1.400 -  CEP 08375-000	0	0	22631.9300000000003	2014-12-07 16:17:15.767569	\N
4381	Implantação da ADESAMPA - São Miguel	R. Ana Flora Pinheiro de Sousa, 76 - CEP 08060-150	0	0	22631.9300000000003	2014-12-07 16:17:15.792652	\N
4382	Implantação da ADESAMPA - Sé	R. Álvares Penteado, 49	0	0	22631.9300000000003	2014-12-07 16:17:15.818825	\N
4383	Implantação da ADESAMPA - Vila Maria/Vila Guilherme	R. General Mendes, 111 - CEP 02127-020	0	0	22631.9300000000003	2014-12-07 16:17:15.84358	\N
4384	Implantação da ADESAMPA - Vila Mariana	R. José de Magalhães, 500 - CEP 04026-090	0	0	24179.8100000000013	2014-12-07 16:17:15.868658	\N
4385	Implantação da ADESAMPA - Vila Prudente	Avenida do Oratório, 172 - CEP 03220-000	0	0	22631.9300000000003	2014-12-07 16:17:15.894188	\N
4386	Criação e efetivação da Agência São Paulo de Desenvolvimento	\N	0	0	649681.719999999972	2014-12-07 16:17:15.918857	\N
4387	Criação de uma agência de promoção de investimentos para a cidade de São Paulo a partir da expansão da atuação da Companhia São Paulo de Parcerias - SPP	\N	0	0	0	2014-12-07 16:17:16.23879	\N
4388	Criação e efetivação do Programa de Incentivos Fiscais nas Regiões Leste e extremo Sul	\N			648311.670000000042	2014-12-07 16:17:16.49911	\N
4389	Parque Técnológico da Zona Leste	Rua Doutor Luís Aires, altura do no.3.900	-23.543129	-46.467921	1122082.82000000007	2014-12-07 16:17:16.764374	\N
4390	Operação e Manutenção do VAI TEC	\N	0	0	0	2014-12-07 16:17:17.022094	\N
4391	Apoio à implantação da UNIFESP e do IFSP	\N			0	2014-12-07 16:17:17.283399	\N
4392	Criação de um sistema de contrapartida para fins de implantação de áreas verdes e financiamento de terrenos para parques	\N			0	2014-12-07 16:17:17.551325	\N
4393	Programa de Mananciais - Fase 02 -Lote 01 - Pabreu	Avenida Belmira Marin; Rua Pedro Escobar e a Estrada da Ligação	-23.754070	-46.666577	21176300.5399999991	2014-12-07 16:17:17.824743	\N
4394	Programa de Mananciais - Fase 03 -Lote 04 - Jardim dos Lagos / Ipanema	Avenida Robert Kennedy, e a Avenida Rio Bonito	-23.685867	-46.711415	719579.780000000028	2014-12-07 16:17:17.854488	\N
4395	Programa de Mananciais - Fase 03 -Lote 04 - CEU Cidade Dutra	Avenida Robert Kennedy, Rua Gomes Pedrosa, Rua Doutor Mario Ottobrini Costa e Rua Cristina de V. Ceccato	-23.711897	-46.706531	415576.130000000005	2014-12-07 16:17:17.883374	\N
4396	Programa de Mananciais - Fase 03 -Lote 04 - Alcindo Ferreira / Jardim Cruzeiro	Rua Alcindo Ferreira, Rua Josias Mota de Oliveira,	-23.715480	-46.711732	406832.880000000005	2014-12-07 16:17:17.909399	\N
4397	Programa de Mananciais - Fase 03 -Lote 04 - Jardim Satélite I e II / Maria AA II	Rua Maria Aparecida Anacleto, Rua Manuel Caldeira e Av.Rubens Montanaro de Barbosa	-23.715075	-46.691527	479252.969999999972	2014-12-07 16:17:17.935089	\N
4398	Programa de Mananciais - Fase 03 -Lote 04 - Ipojuca Lins de Araújo	Ipojuca Lins de Araújo, Rynaldo Borgianni e Coronel Arlindo de Oliveiras,	-23.724622	-46.696427	449115.369999999995	2014-12-07 16:17:17.960591	\N
4399	Programa de Mananciais - Fase 03 -Lote 04 - Jardim Manacás	Av. Vale das Canas, Rua Alexandre Giusti, Rua Nolasco da Cunha e Rua Gregório Viegas	-23.745345	-46.700769	509977.090000000026	2014-12-07 16:17:17.986743	\N
4400	Programa de Mananciais - Fase 03 -Lote 04 - Pq. são José VII / Três Cânticos e Entorno	Ruas Nova Zelândia, Lister, Orville, Av. Paramaribo, Três Cânticos, Coentral	-23.744175	-46.696360	562631.890000000014	2014-12-07 16:17:18.013451	\N
4401	Programa de Mananciais - Fase 03 -Lote 04 - Jardim Pouso Alegre	Ruas Frederic Mistral, Julien Benda, Pedro Correia Garção, Rua Acácio Fontoura	-23.735067	-46.714742	783831.640000000014	2014-12-07 16:17:18.038829	\N
4402	Programa de Mananciais - Fase 03 -Lote 04 - Pq. São José VI	Avenida Senador Teotônio Vilela e as ruas Açor, Discípulos de Emaus e Pinheiro Chagas.	-23.741225	-46.702769	1626721.56000000006	2014-12-07 16:17:18.064651	\N
4403	Programa de Mananciais - Fase 03 -Lote 04 - Anthero Gomes do Nascimento/Império I/Jd. São Judas Tadeu/ Jardim São Vicente	Rua Fernão Alvares do Oriente, Rua Luiz Bras, Rua Anthero Gomes do Nascimento, Alvaro Viana, Luiz Cabral Mesquita, Antonio Correa da Silva, Gaspar Maciel Aranha, Nova Delhi	-23.717065	-46.683304	2699711.97999999998	2014-12-07 16:17:18.090658	\N
4404	Programa de Mananciais - Fase 03 -Lote 04 - Alto da Alegria	Rua Pelágia Starbulov, Ezequiel Lopes Cardoso, Joaquim de Vasconcelos, Justiniano da Rocha, Irina Milchev Starbulov, Av. Prefeito Paulo Lauro, Rua Clarindo Santiago e Av. Dona Belmira Marin	-23.744240	-46.692026	8496596.49000000022	2014-12-07 16:17:18.117172	\N
4405	Programa de Mananciais - Fase 03 -Lote 05 - Pq. São José I e II	Puerto de Paz, Sai Guaçu, Prof. Cardoso Rangel, Pedro Marcineiro	-23.742040	-46.694431	1850783.75	2014-12-07 16:17:18.142671	\N
4406	Programa de Mananciais - Fase 03 -Lote 05 - Jardim Orion/ORION / Jardim IMPERIO - INVASÃO	Rua Edelvais, Rua Ricardo Juliao Ferraz, Rua Gaspar Jose Raposo, Rua Ventuari	-23.718730	-46.679369	1553027.60000000009	2014-12-07 16:17:18.168966	\N
4407	Programa de Mananciais - Fase 03 -Lote 05 - 3M / CLUBE DE PESCA STA. BARBARA	Rua Jaime Freitas Moniz, Rua Joao Goulart	-23.718466	-46.673172	778608.880000000005	2014-12-07 16:17:18.195718	\N
4408	Programa de Mananciais - Fase 03 -Lote 06 - Nova Grajaú II	Rua Olímpio Soares de Carvalho, Rua Manoel Guilherme dos Reis, Rua José Carlos Heffner, Rua Carlos Sgarbi Filho e Rua Sabino Romariz	-23.747287	-46.683204	4055655.04000000004	2014-12-07 16:17:18.221556	\N
4409	Programa de Mananciais - Fase 03 -Lote 06 - Cocaia I	Rua Dr. Nuno Guerner de Almeida	-23.749357	-46.677097	9696432.25999999978	2014-12-07 16:17:18.247107	\N
4410	Programa de Mananciais - Fase 03 -Lote 06 - ERUNDINA	Rua Charles Rosen, Rua Bartolomeu Bezzi, Rua Guilherme Role, Rua Claudio Artaria	-23.734299	-46.664512	833590.489999999991	2014-12-07 16:17:18.273364	\N
4411	Programa de Mananciais - Fase 03 -Lote 06 - Próximo ao loteamento Gaivotas - Sem nome	Rua Guilherme Role	-23.726636	-46.663540	58418.8300000000017	2014-12-07 16:17:18.299081	\N
4412	Programa de Mananciais - Fase 03 -Lote 07 - Cantinho do Céu	Rua Pedro Escobar, Estrada Canal da Cocaia, Rua Claudio Artaria, Rua Charles Rosen, Rua Bartolomeu Bezzi, Rua Guilherme Rule	-23.744262	-46.661192	7056136.49000000022	2014-12-07 16:17:18.325073	\N
4413	Programa de Mananciais - Fase 03 -Lote 07 - VALE VERDE ou MONTE VERDE/CARIOBA / SITIO CASCAVEL	Estrada da Ligação, Rua Guaracy Torres	-23.755967	-46.665546	4777870.78000000026	2014-12-07 16:17:18.35432	\N
4414	Programa de Mananciais - Fase 03 -Lote 07 - Jardim Rodrigo	Estrada do Barro Branco, Estrada Jequirituba	-23.765667	-46.672109	619071.050000000047	2014-12-07 16:17:18.389996	\N
4415	Programa de Mananciais - Fase 03 -Lote 07 - Jardim Nova Varginha / Estrada do Barro Branco	Estrada do Barro Branco, Rua Solar dos Pássaros	-23.783780	-46.687777	461213.039999999979	2014-12-07 16:17:18.429885	\N
4416	Programa de Mananciais - Fase 03 -Lote 07 - Jardim Almeida Prado	Rua Breno Bersa, Rua Agenor Klausner, Rua Dante Ambrosio	-23.776903	-46.688389	360343.359999999986	2014-12-07 16:17:18.455566	\N
4417	Programa de Mananciais - Fase 03 -Lote 05 - Jardim Eldorado / Mata Virgem	Estrada Água Santa, Estrada do Alvarenga, Rua da Represa, Rua Riese, Rua Vicente Fioravante, Rua dos Chorões, Av.Massaranduba, Rua Josephina Gianini Elias Dona Bimba, Rua Rust, Rua Doutor José Silvio de Camargo e Av.Alda	-23.709808	-46.619464	4588124.1799999997	2014-12-07 16:17:18.486294	\N
4418	Programa de Mananciais - Fase 03 -Lote 05 - Ângelo Remazotti / Missionária V/ Papa Gregório Magno	Rua Angelo Remazotti, Rua Bento XV, Rua Alexandre Kipnis, Rua Gregorio Magno	-23.689111	-46.648014	5826813.99000000022	2014-12-07 16:17:18.519109	\N
4419	Programa de Mananciais - Fase 03 -Lote 05 - Balneário / Mar Paulista/Ingai	Rua Angelo Montecili, Rua Rodrigues Medeiros, Estrada do Alvarenga	-23.698084	-46.654650	1165995.69999999995	2014-12-07 16:17:18.544971	\N
4420	Programa de Mananciais - Fase 03 -Lote 05 - BANDEIRANTES/Dois/Jardim Apurá/Paulistas/ REP LOTES // QD BAIRRO APURA	Rua Paulistas, Rua Manoel Gutierrez Najera, Rua Voluntarios	-23.710727	-46.658676	761533.520000000019	2014-12-07 16:17:18.571199	\N
4421	Programa de Mananciais - Fase 03 -Lote 05 - Paulino Alves Escudeiro	Rua Paulino Alves Escudeiro, Rua Rodolfo Lassala Freire	-23.699553	-46.634678	609135.920000000042	2014-12-07 16:17:18.596791	\N
4422	Programa de Mananciais - Fase 03 - Lote 01 - Boulevard da Paz	Rua Cíclades, Rua Fernades Trancoso, Rua Berthelot, Rua João de Almada e Rua Francisca Queiroz	-23.698338	-46.790024	10828690.5099999998	2014-12-07 16:17:18.622814	\N
4423	Programa de Mananciais - Fase 03 -Lote 02- Jardim Arnaldo	Rua Francisco S. da Silva, Rua Pilbarra e Rua Huelva	-23.688480	-46.744750	12488036.4000000004	2014-12-07 16:17:18.650054	\N
4424	Programa de Mananciais - Fase 03 -Lote 02 - Parque São Francisco	Rua Parvati, Rua Brigadeiro Freire de Rezende Rua Ivirapema	-23.692502	-46.745095	452890.400000000023	2014-12-07 16:17:18.675823	\N
4425	Programa de Mananciais - Fase 03 -Lote 02 - Santa Margarida V	Rua Cataldo Parrilha e Rua Doutor Artur Moreira de Almeida	-23.680231	-46.753332	0	2014-12-07 16:17:18.703318	\N
4426	Programa de Mananciais - Fase 03 -Lote 02 - Jardim Ângela II	Estrada Guavirituba, Rua da Gaita de Foles, Rua Santa Zélia e Rua Alois Habas	-23.683600	-46.761809	1006864.47999999998	2014-12-07 16:17:18.729196	\N
4427	Programa de Mananciais - Fase 03 -Lote 02 - Vila Santa Zélia	Rua dos Violoncelos, Rua Santa Zélia, Rua das Galhardas e Rua das Flautas Transversais	-23.682375	-46.766219	0	2014-12-07 16:17:18.75636	\N
4428	Programa de Mananciais - Fase 03 -Lote 02 - João Manuel Vaz	Rua João Manoel Vaz, Rua Tom Maior, Rua Guilherme de Poitiers	-23.685062	-46.754659	664562.260000000009	2014-12-07 16:17:18.783059	\N
4429	Programa de Mananciais - Fase 03 -Lote 02 - Jardim Guanguará	Estrada da Baronesa, Rua Alexandrina Malisano de Lima	-23.693567	-46.762005	0	2014-12-07 16:17:18.809528	\N
4430	Programa de Mananciais - Fase 03 -Lote 02 - Jardim Fujihara I, III e Jardim Nakamura II	Estrada da Baronesa, Rua Alcino de Souza Prado, Rua Valentim Correa Pais, Rua Bonifácio Pasquali e Rua Padre Nelson Antonino	-23.699956	-46.771287	0	2014-12-07 16:17:18.835537	\N
4431	Programa de Mananciais - Fase 03 -Lote 02 - Pq. Novo Santo Amaro I e II	Rua José Alves da Silva, Rua Barbosa de Freitas e Rua Álvaro Ferreira	-23.697427	-46.781166	0	2014-12-07 16:17:18.861979	\N
4432	Programa de Mananciais - Fase 03 -Lote 02 - Pq. Novo Santo Amaro III	Rua Paolo Pórpora, Rua Carneiro Vilela, Rua Padre Marcelino Duarte e Rua Carneiro Lousada	-23.694912	-46.782217	0	2014-12-07 16:17:18.888661	\N
4433	Programa de Mananciais - Fase 03 -Lote 02 - Jardim Solange	Ruas Afeganistão, Diriamba, Tacuarembo e Peloponeso	-23.701462	-46.780892	0	2014-12-07 16:17:18.915032	\N
4434	Programa de Mananciais - Fase 03 -Lote 02 - Costa do Valado	Rua das Três Marias e Rua Clamecy	-23.704591	-46.785616	0	2014-12-07 16:17:18.946522	\N
4435	Programa de Mananciais - Fase 03 -Lote 02 - São Lourenço	Estrada do Jararaú, Rua Manuel de Azevedo e Rua Macieira do Sul	-23.703528	-46.789919	0	2014-12-07 16:17:18.97355	\N
4436	Programa de Mananciais - Fase 03 -Lote 02 - Renato Locchi	Rua José Alves da Silva, Rua Doutor Renato Locchi, Rua Antonio de Melo Freitas e Estrada M´Boi Mirim	-23.700283	-46.783887	0	2014-12-07 16:17:19.001402	\N
4437	Programa de Mananciais - Fase 03 -Lote 02 - Jararaú II	Rua Estado do Jararaú e pela Rua Macedônia do Couto	-23.703161	-46.791579	0	2014-12-07 16:17:19.028301	\N
4438	Programa de Mananciais - Fase 03 -Lote 02 - Pq. Novo Santo Amaro IV	Rua Marcelino Duarte, Rua Coelho Lousada, Rua Luiz Soriano	-23.696899	-46.782816	0	2014-12-07 16:17:19.057587	\N
4439	Programa de Mananciais - Fase 03 -Lote 02 - Xamborés I e II	Rua Umbelíferas, Rua Xambores	-23.711380	-46.775848	0	2014-12-07 16:17:19.083386	\N
4440	Programa de Mananciais - Fase 03 -Lote 03 -Chácara Flórida / Bandeirante	Rua Licínio Felini; Rua Julio Nicati; Rua Francisco Giocondo; Rua Benedito Biscop; Rua Antonio Escotti; Rua Emanuel List; e Rua José Boscoli. Avenida M”Boi Guaçu ( antiga Rua Bandeirantes); Rua Hum; Rua Dois; Rua Três; Rua Quatro; Rua Cinco; e Rua Seis.	-23.726135	-46.772838	439298.169999999984	2014-12-07 16:17:19.109842	\N
4441	Programa de Mananciais - Fase 03 -Lote 03-Jardim Capela / Santa Bárbara	Rua Citeron, Rua Conde de Silva Monteiro, Rua São Paulo e Rua Pernamabuco	-23.728973	-46.789693	14844576.7799999993	2014-12-07 16:17:19.135742	\N
4442	Programa de Mananciais - Fase 03 -Lote 03-Enlevo	Ruas Escaravelho de Ouro e Espuma do Mar, ao sudoeste pela Rua Enlevo	-23.734622	-46.790339	2967988.62000000011	2014-12-07 16:17:19.162954	\N
4443	Programa de Mananciais - Fase 03 -Lote 03-Jardim Calú	Estrada do Embu-Guaçu, Travessa Águas Duras, Travessa Pêra dos Anjos, Travessa Cartum, Maria do Carmo e Rua Sinfonia Heróica	-23.737649	-46.793411	600963.829999999958	2014-12-07 16:17:19.189078	\N
4444	Programa de Mananciais - Fase 03 -Lote 03-Angelo Tarsini	Rua Ângelo Tarchi	-23.737737	-46.775628	569664.670000000042	2014-12-07 16:17:19.215599	\N
4445	Programa de Mananciais - Fase 03 -Lote 03-Cavalo Branco / Batista Bassano	Av. dos Funcionários Publico e ruas Anatoli Liadov, Ângelo Tarchi e Maria Trevisan	-23.674799	-46.632799	452605.469999999972	2014-12-07 16:17:19.242394	\N
4446	Programa de Mananciais - Fase 03 -Lote 03-Arizona	Estrada do Embu-Guaçu, Avenida dos Funcionários Públicos	-23.732587	-46.785599	7023624.34999999963	2014-12-07 16:17:19.267491	\N
4447	Programa de Mananciais - Fase 03 -Lote 03-Chácara Sonho Azul	Rua da Mina e a Rua do Carvoeiro	-23.738778	-46.788767	2848608.83999999985	2014-12-07 16:17:19.293936	\N
4448	Programa de Mananciais - Fase 03 -Lote 03-Buraco do Sapo	Avenida dos Funcionários Públicos	-23.738298	-46.782175	18865.5999999999985	2014-12-07 16:17:19.320317	\N
4449	Programa de Mananciais - Fase 03 -Lote 03-Jardim Tancredo	Estrada dos Funcionários Públicos, Rua Américo Turini	-23.743116	-46.782742	291424.760000000009	2014-12-07 16:17:19.346368	\N
4450	Programa de Mananciais - Fase 03 -Lote 03-Jardim Horizonte Azul / Sapato Branco	Rua Manoel Soares da Silva, Rua Albergati Capacelli e Rua Valdeci Araújo Ribeiro	-23.751637	-46.775001	392359.289999999979	2014-12-07 16:17:19.373596	\N
4451	Programa de Mananciais - Fase 03 -Lote 03-Jardim Colorado	Rua Francisco, Rua Acre, Rua Mato Grosso	-23.746840	-46.783149	460018.780000000028	2014-12-07 16:17:19.399647	\N
4452	Programa de Mananciais - Fase 03 -Lote 04 - Pq. Maria Fernanda I e II	Av. Paulo Guilguer Reimberg, Rua Arcelina Teixeira da Silva, Rua Samuel Laurence e Rua Roberto Reno	-23.770264	-46.715701	469383.400000000023	2014-12-07 16:17:19.426125	\N
4453	Programa de Mananciais - Fase 03 -Lote 04 - Jardim Roschel	Rua Andre Pernet, Rua Alfonso Elias, Rua da Fonte	-23.820800	-46.728283	438272.299999999988	2014-12-07 16:17:19.45274	\N
4454	Programa de Mananciais - Fase 03 -Lote 08 - UNIFAG - COND. VARGEM GRANDE e NOVO SILVEIRA/ CHAC. BOA ESPERANÇA	Avenida Senador Teotônio Vilela, Avenida Sadamu Inoue, Estrada Colônia e Estrada Vargem Grande.	-23.861738	-46.711465	9984274.74000000022	2014-12-07 16:17:19.481193	\N
4455	Criação e efetivação de um programa de incentivos fiscais para prédios verdes	\N			0	2014-12-07 16:17:19.873891	\N
4456	Parque Cohab Raposo Tavares I - Juliana de Carvalho Torres (SPBT)	Travessa Córrego da Independência	0	0	0	2014-12-07 16:17:20.149389	\N
4457	Parque Linear Itararé - Sérgio Vieira de Mello (SPBT)	R. Martin Chambiges; Av. Gethsemani; Av. Frei Macario de Sao Paulo	0	0	0	2014-12-07 16:17:20.183035	\N
4458	Parque Linear Sapé (SPBT)	Rod. Raposo Tavares; Av. Politecnica	0	0	0	2014-12-07 16:17:20.211678	\N
4459	Parque Horto do Ipê (SPCL)	Rua Francisco da Cruz Mellão	0	0	0	2014-12-07 16:17:20.238739	\N
4460	Parque Morumbi Sul (SPCL)	R. Lira Cearense x R NSra. do Bom Conselho	0	0	0	2014-12-07 16:17:20.265267	\N
4461	Parque Paraisópolis (SPCL)	R. Italegre	0	0	0	2014-12-07 16:17:20.2915	\N
4462	Readequação do Parque CEU 3 Lagos (SPSO)	R. Tres Coracoes	0	0	0	2014-12-07 16:17:20.318829	\N
4463	Parque Jacques Cousteau (SPSO)	Rua Catanumi, 60	0	0	0	2014-12-07 16:17:20.345925	\N
4464	Parque Natural Varginha (SPSO)	Av Paulo Guilguer Reimberg, 6200	0	0	0	2014-12-07 16:17:20.372651	\N
4465	Parque do Bispo - Borda da Cantareira (SPCV)	Longo da Estrada da Sede; Av. Francisco Machado da Silva; R. Taquaracu de Minas	0	0	0	2014-12-07 16:17:20.402544	\N
4466	Parque Independência (SPIP)	Av. Nazare, s/nº.	0	0	0	2014-12-07 16:17:20.431578	\N
4467	Parque Chácara das Flores (SPIT)	Estrada Dom Joao Nery, 3.551	0	0	0	2014-12-07 16:17:20.459139	\N
4468	Parque Chico Mendes (SPIT)	R. Cembira, 1201	0	0	0	2014-12-07 16:17:20.488164	\N
4469	Parque Linear Água Vermelha (SPIT)	Av Euclides Fonseca (perpendicular a Av. Marechal Tito, altura do nº 1200)	0	0	0	2014-12-07 16:17:20.515494	\N
4470	Parque Linear Itaim (SPIT)	Avenida Itamerendiba, 30	0	0	0	2014-12-07 16:17:20.549776	\N
4471	Parque do Carmo - Olavo Egydio Setúbal (SPIQ)	Av. Afonso de Sampaio e Souza, 951	0	0	0	2014-12-07 16:17:20.575775	\N
4472	Parque Linear Rio Verde (SPIQ)	R. Tomazo Ferrara; R. Castelo do Piaui; Av. Itaquera	0	0	0	2014-12-07 16:17:20.602875	\N
4473	Parque Raul Seixas (SPIQ)	R. Murmurios da Tarde, 211. Cohab 2	0	0	0	2014-12-07 16:17:20.629303	\N
4474	Parque Leopoldina - Orlando Villas-Boas (SPLA)	Avenida Embaixador Macedo Soares, 6715	0	0	0	2014-12-07 16:17:20.655746	\N
4475	Parque Guarapiranga (SPMB)	Estrada de Guarapiranga, 575	0	0	0	2014-12-07 16:17:20.682159	\N
4476	Parque Piqueri (SPMO)	R. Tuiuti, 515	0	0	163248.260000000009	2014-12-07 16:17:20.708982	\N
4477	Parque Natural Itaim (SPPA)	Estrada de Servidão, s/nº, vicinal da Av. Prof. Hermogenes de Freitas Leitão Filho	0	0	0	2014-12-07 16:17:20.73641	\N
4478	Readequação do Parque Anhanguera (SPPR)	Estrada de Perus, 124-144 - Vila Jaguara, SP	0	0	211920.279999999999	2014-12-07 16:17:20.76559	\N
4479	Parque Tenente Siqueira Campos - Trianon (SPPI)	R. Peixoto Gomide, 949. (Altura do nº 1700 da Av. Paulista)	0	0	0	2014-12-07 16:17:20.791808	\N
4480	Parque Cidade de Toronto (SPPJ)	Av. Cardeal Mota, 84	0	0	0	2014-12-07 16:17:20.818686	\N
4481	Parque Jardim Felicidade (SPPJ)	R. Laudelino Vieira de Campos, 265	0	0	0	2014-12-07 16:17:20.845726	\N
4482	Parque Linear Córrego do Fogo (SPPJ)	R.Camilo Zanotti; Estrada de Taipas	0	0	0	2014-12-07 16:17:20.872692	\N
4483	Parque Pinheirinho DÁgua (SPPJ)	Estrada de Taipas, s/nº	0	0	0	2014-12-07 16:17:20.899457	\N
4484	Parque Rodrigo de Gásperi (SPPJ)	Av. Miguel de Castro, 312	0	0	0	2014-12-07 16:17:20.926689	\N
4485	Parque São Domingos (SPPJ)	R. Pedro Sernagiotti, 125	0	0	0	2014-12-07 16:17:20.953643	\N
4486	Readequação do Parque Aterro Sapopemba (SPSM)	Estrada do Rio Claro	0	0	0	2014-12-07 16:17:20.980046	\N
4487	Parque da Luz (SPSE)	Praça da Luz, s/nº	0	0	0	2014-12-07 16:17:21.006519	\N
4488	Parque do Trote (SPMG)	Av. Nadir Dias de Figueiredo, s/nº. Portaria 1	0	0	0	2014-12-07 16:17:21.033	\N
4489	Parque Ibirapuera (SPVM)	Av. Pedro Alvares Cabral, s/nº. Portão 10	0	0	0	2014-12-07 16:17:21.060434	\N
4490	Capacitação e sensibilização de cidadãos em educação ambiental e cultura de paz	\N	0	0	330221.270000000019	2014-12-07 16:17:21.452524	\N
4491	Implantação dos Polos de Educação Ambiental (um por subprefeitura)	\N	0	0	960000	2014-12-07 16:17:21.493358	\N
4492	Plantio de Árvores	\N	0	0	500593.580000000016	2014-12-07 16:17:21.767527	\N
4493	Elaboração do Plano Municipal de Gestão Integrada de Resíduos Sólidos e Coleta Seletiva	\N			0	2014-12-07 16:17:22.056725	\N
4494	Ampliação da coleta seletiva municipal - Distrito Anhanguera	\N	0	0	0	2014-12-07 16:17:22.090268	\N
4495	Ampliação da coleta seletiva municipal - Distrito Brasilândia	\N	0	0	0	2014-12-07 16:17:22.140269	\N
4496	Ampliação da coleta seletiva municipal - Distrito Cachoeirinha	\N	0	0	0	2014-12-07 16:17:22.167869	\N
4497	Ampliação da coleta seletiva municipal - Distrito Campo Limpo	\N	0	0	0	2014-12-07 16:17:22.194873	\N
4498	Ampliação da coleta seletiva municipal - Distrito Capão Redondo	\N	0	0	0	2014-12-07 16:17:22.224848	\N
4499	Ampliação da coleta seletiva municipal - Distrito Cidade Ademar	\N	0	0	0	2014-12-07 16:17:22.252601	\N
4500	Ampliação da coleta seletiva municipal - Distrito Cidade Dutra	\N	0	0	0	2014-12-07 16:17:22.279331	\N
4501	Ampliação da coleta seletiva municipal - Distrito Ermelino Matarazzo	\N	0	0	0	2014-12-07 16:17:22.30648	\N
4502	Ampliação da coleta seletiva municipal - Distrito Grajaú	\N	0	0	0	2014-12-07 16:17:22.333337	\N
4503	Ampliação da coleta seletiva municipal - Distrito Guaianases	\N	0	0	0	2014-12-07 16:17:22.360925	\N
4504	Ampliação da coleta seletiva municipal - Distrito Jardim Ângela	\N	0	0	0	2014-12-07 16:17:22.38782	\N
4505	Ampliação da coleta seletiva municipal - Distrito Jardim Helena	\N	0	0	0	2014-12-07 16:17:22.415218	\N
4506	Ampliação da coleta seletiva municipal - Distrito Jardim São Luis	\N	0	0	0	2014-12-07 16:17:22.441658	\N
4507	Ampliação da coleta seletiva municipal - Distrito Lajeado	\N	0	0	0	2014-12-07 16:17:22.470716	\N
4508	Ampliação da coleta seletiva municipal - Distrito Marsilac	\N	0	0	0	2014-12-07 16:17:22.499506	\N
4509	Ampliação da coleta seletiva municipal - Distrito Parelheiros	\N	0	0	0	2014-12-07 16:17:22.526414	\N
4510	Ampliação da coleta seletiva municipal - Distrito Perus	\N	0	0	0	2014-12-07 16:17:22.560496	\N
4511	Ampliação da coleta seletiva municipal - Distrito Ponte Rasa	\N	0	0	0	2014-12-07 16:17:22.588548	\N
4512	Ampliação da coleta seletiva municipal - Distrito Raposo Tavares	\N	0	0	0	2014-12-07 16:17:22.615766	\N
4513	Ampliação da coleta seletiva municipal - Distrito Rio Pequeno	\N	0	0	0	2014-12-07 16:17:22.643197	\N
4514	Ampliação da coleta seletiva municipal - Distrito Vila Jacuí	\N	0	0	0	2014-12-07 16:17:22.671109	\N
4515	Ampliação da coleta seletiva municipal - Distrito Vila Matilde	\N	0	0	0	2014-12-07 16:17:22.699037	\N
4516	Ampliação da coleta seletiva municipal - Distrito Socorro	\N	0	0	0	2014-12-07 16:17:22.727405	\N
4517	Ampliação da coleta seletiva municipal - Distrito Tucuruvi	\N	0	0	0	2014-12-07 16:17:22.755565	\N
4518	Ampliação da coleta seletiva municipal - Distrito Pedreira	\N	0	0	0	2014-12-07 16:17:22.783248	\N
4519	Central de Triagem Automatizada - Santo Amaro	Av. Miguel Yunes, s/n	-23.69057	-46.68642	0	2014-12-07 16:17:23.118203	\N
4520	Central de Triagem Automatizada - Bom Retiro	Av. do Estado, nº 300	-23.54163	-46.62865	0	2014-12-07 16:17:23.152411	\N
4521	Central de Triagem Automatizada - São Mateus	Av. Sapopemba nº 23.325	-23.631623	-46.424216	0	2014-12-07 16:17:23.185306	\N
4522	Central de Triagem Autmatizada - Vila Maria/Vila Guilherme	\N	0	0	0	2014-12-07 16:17:23.212265	\N
4523	Ecoponto  Vila Luisa	Rua Recife	-23.528864	-46.550375	142915.100000000006	2014-12-07 16:17:23.526921	\N
4524	Ecoponto Água Rasa	Av. Salim Farah Maluf, 1500	-23.556476	-46.577297	157992.350000000006	2014-12-07 16:17:23.559827	\N
4525	Ecoponto Alto de Pinheiros	Praça Arcipreste Anselmo de Oliveira	-23.557278	-46.710573	172633.279999999999	2014-12-07 16:17:23.589363	\N
4526	Ecoponto Belém	Baixo do Viad. Guadalajara	-23.543294	-46.593798	237090.059999999998	2014-12-07 16:17:23.617354	\N
4527	Ecoponto Beleza	Rua Campo Novo do Sul	-23.637541	-46.740404	146912.399999999994	2014-12-07 16:17:23.644924	\N
4528	Ecoponto Caraguata	Rua Jose Pereira Cruz	-23.652356	-46.605292	0	2014-12-07 16:17:23.672674	\N
4529	Ecoponto Cavalcanti	R.Beleza Pura 	-23.527734	-46.459278	0	2014-12-07 16:17:23.700891	\N
4530	Ecoponto Cidade Saudável	Rua Pitolomeu	-23.662286	-46.722417	126303.300000000003	2014-12-07 16:17:23.727745	\N
4531	Ecoponto Comandante Taylor	R.Com. Taylor X Av.Juntas Pro	-23.600128	-46.598138	0	2014-12-07 16:17:23.759805	\N
4532	Ecoponto Franquinho	R.Carlos Maria Stamberg	-23.531763	-46.487852	119791.899999999994	2014-12-07 16:17:23.787814	\N
4533	Ecoponto Freguesia do Ó	Rua Souza Filho	-23.503156	-46.704403	106490.539999999994	2014-12-07 16:17:23.815841	\N
4534	Ecoponto Giovani Gronchi	Av. Giovanni Gronch,3413	0	0	141556.470000000001	2014-12-07 16:17:23.843387	\N
4535	Ecoponto Guaiaponto	Rua da Passagem Funda	-23.562714	-46.416620	47326	2014-12-07 16:17:23.871086	\N
4536	Ecoponto Itaqueruna	Rua Domitilia D`Abril	-23.509233	-46.433024	118013.850000000006	2014-12-07 16:17:23.898666	\N
4537	Ecoponto Jardim Antártica	Av. francisco Machado da Silva	-23.453802	-46.661073	0	2014-12-07 16:17:23.926324	\N
4538	Ecoponto Jardim Jaqueline	Rua Walter Brito Beletti	-23.588830	-46.753712	141025.630000000005	2014-12-07 16:17:23.954758	\N
4539	Ecoponto Jardim Santa Fé	Rua Salvador Albano	-23.434015	-46.792334	254061.399999999994	2014-12-07 16:17:23.981995	\N
4540	Ecoponto Mãe Preta	Praça Mae Preta com av. Fernando Figueiredo lins  	-23.508733	-46.416930	0	2014-12-07 16:17:24.009362	\N
4541	Ecoponto Montalvania	Rua Montalvania	-23.579141	-46.496972	0	2014-12-07 16:17:24.036788	\N
4542	Ecoponto Nova York	Rua Amelia Vanso Magnoli	-23.585230	-46.506246	179163.779999999999	2014-12-07 16:17:24.064497	\N
4543	Ecoponto Olinda	Av. Padre Adolfo Kolping	-23.634232	-46.760093	143472.640000000014	2014-12-07 16:17:24.092114	\N
4544	Ecoponto Oswaldo Valle Cordeiro	Av. Osvaldo Valle Cordeiro, 420	-23.557591	-46.491495	119268.009999999995	2014-12-07 16:17:24.119614	\N
4545	Ecoponto Parque do Carmo	Av. Afonso de Sampaio e Souza	-23.579574	-46.484620	0	2014-12-07 16:17:24.147515	\N
4546	Ecoponto Politécnica	Praca Nilton Vieira de Almeida	-23.576376	-46.764105	177473.450000000012	2014-12-07 16:17:24.175451	\N
4547	Ecoponto Saioa	Gomes Cardim	-23.594442	-46.622492	0	2014-12-07 16:17:24.202903	\N
4548	Ecoponto Santana	Av.Zachi Narchi	-23.509914	-46.618494	0	2014-12-07 16:17:24.230872	\N
4549	Ecoponto Tucuruvi	Rua Eduardo Vicente Nasser, 51	-23.466354	-46.609765	123920.899999999994	2014-12-07 16:17:24.25868	\N
4550	Ecoponto Vila das  Mercês	rua Italva	-23.623765	-46.605548	0	2014-12-07 16:17:24.28601	\N
4551	Ecoponto Vila Jaguará	Rua Agrestina	-23.515409	-46.741058	130316.410000000003	2014-12-07 16:17:24.31425	\N
4552	Ecoponto Vila Maria	Av. Curuca, 1700	-23.519999	-46.580687	152464.630000000005	2014-12-07 16:17:24.341759	\N
4553	Ecoponto Vila Mariana	rua Afonso Celso	-23.593062	-46.635090	0	2014-12-07 16:17:24.372446	\N
4554	Ecoponto Vila Rica	Rua Jorge Mamede da Silva,  201	-23.469707	-46.673803	0	2014-12-07 16:17:24.399754	\N
4555	Central de Compostagem - Aterro Bandeirantes	Av. Mogeiro nº 1580	-23.418563	-46.755817	0	2014-12-07 16:17:24.758812	\N
4556	Central de Compostagem - Aterro São João	Av. Sapopemba nº 23.325	-23.631623	-46.424216	0	2014-12-07 16:17:24.794093	\N
4557	Central de Compostagem III	\N	0	0	0	2014-12-07 16:17:24.822987	\N
4558	Central de Compostagem IV	\N	0	0	0	2014-12-07 16:17:24.851055	\N
4559	Implantação de Feiras Sustentáveis	\N	0	0	0	2014-12-07 16:17:24.879217	\N
4560	Ampliação do Terminal Itaquera	Terminal de ônibus - Itaquera	-23.542091	-46.472099	24722326.379999999	2014-12-07 16:17:25.185124	\N
4561	TERMINAL NOVO JARDIM ÂNGELA	Estrada M Boi Mirim	0	0	340523.919999999984	2014-12-07 16:17:25.220043	\N
4562	TERMINAL NOVO PARELHEIROS	\N	0	0	0	2014-12-07 16:17:25.248807	\N
4563	TERMINAL PERUS	\N	0	0	0	2014-12-07 16:17:25.276897	\N
4564	Novos corredores de ônibus - ARICANDUVA - (Extensão Total - 14 Km) - SPObras	Avenida Aricanduva	-23.566820	-46.506288	0	2014-12-07 16:17:25.305274	\N
4565	NOVO TERMINAL ITAQUERA	\N	0	0	0	2014-12-07 16:17:25.332471	\N
4566	Novos corredores de ônibus - BELMIRA MARIN - TRECHO 2 (Extensão Total - 3,9 km)	Av. Belmira Marin	-23.754430	-46.673421	1241558.97999999998	2014-12-07 16:17:25.360745	\N
4567	Novos corredores de ônibus - BERRINI T1 - (Extensão Total de 3,3 km) - (SPObras)	Av. Berrini	-23.610753	-46.694769	1482410.10000000009	2014-12-07 16:17:25.388733	\N
4568	Novos corredores de ônibus - CANAL COCAIA T1 - (Extensão Total - 3,5 km)	Av. Cocaia	-23.748228	-46.672831	1731033.72999999998	2014-12-07 16:17:25.416339	\N
4569	Novos corredores de ônibus - CANAL COCAIA T2- (Extensão Total - 3 km)	Av. Cocaia	-23.748228	-46.672831	1483743.18999999994	2014-12-07 16:17:25.444041	\N
4570	Novos corredores de ônibus - CANAL COCAIA T3- (Extensão Total - 2 km)	Av. Cocaia	-23.748228	-46.672831	989162.130000000005	2014-12-07 16:17:25.475826	\N
4571	Novos corredores de ônibus - CAPÃO REDONDO / CAMPO LIMPO / VILA SÔNIA TRECHO 1 - (Extensão - 3,7 km) - (SPObras)	Av. Francisco Mourato	-23.646000	-46.779564	1674569.66999999993	2014-12-07 16:17:25.509093	\N
4572	Novos corredores de ônibus - CAPÃO REDONDO / CAMPO LIMPO / VILA SÔNIA TRECHO 3 - (Extensão - 3,6 km) - (SPObras)	\N	0	0	0	2014-12-07 16:17:25.543243	\N
4573	Novos corredores de ônibus - CAPÃO REDONDO / CAMPO LIMPO / VILA SÔNIA TRECHO 2 - (Extensão - 4,7 km) - (SPObras)	\N	0	0	0	2014-12-07 16:17:25.578643	\N
4574	Novos corredores de ônibus - LESTE ITAQUERA Trecho 1 - (Extensão Total - 6,1 km) - (SPObras)	Av. Itaquera	-23.555730	-46.525926	651632.630000000005	2014-12-07 16:17:25.609754	\N
4575	Novos corredores de ônibus - LESTE ITAQUERA Trecho 2 - (Extensão Total - 8 km) - (SPObras)	\N	0	0	0	2014-12-07 16:17:25.638792	\N
4576	Novos corredores de ônibus - LESTE RADIAL - Trecho 1  (Extensão Total - 12 km) - SPObras	Radial Leste	-23.540455	-46.574719	1898467.62000000011	2014-12-07 16:17:25.668806	\N
4577	Novos corredores de ônibus - LESTE RADIAL - Trecho 2 (Extensão Total - 5 km)	Radial Leste	-23.535090	-46.495959	137626.160000000003	2014-12-07 16:17:25.701077	\N
4578	Novos corredores de ônibus - LESTE RADIAL - Trecho 3 (Extensão Total - 9,5km)	Radial Leste	-23.525578	-46.440276	2260362.18000000017	2014-12-07 16:17:25.73226	\N
4579	Novos corredores de ônibus - MIGUEL YUNES - (Extensão - 4,9 km) - (SPTrans)	Miguel Yunes	-23.688623	-46.688121	1199555.70999999996	2014-12-07 16:17:25.766735	\N
4580	Novos corredores de ônibus - PERIMETRAL ITAIM PAULISTA / SÃO MATEUS  T1- (Extensão Total - 7,6 km) - (METRO)	Perimetral Itaim Paulista/São Mateus	-23.592545	-46.540633	1508129.19999999995	2014-12-07 16:17:25.795395	\N
4581	Novos corredores de ônibus - PERIMETRAL ITAIM PAULISTA / SÃO MATEUS T2 - (Extensão Total - 6,6 km) - (SPTrans)	Perimetral Itaim Paulista/São Mateus	-23.592545	-46.540633	1309691.14999999991	2014-12-07 16:17:25.827966	\N
4582	Novos corredores de ônibus - PERIMETRAL ITAIM PAULISTA / SÃO MATEUS  T3- (Extensão Total - 11,6 km) - (SPTrans)	Perimetral Itaim Paulista/São Mateus	-23.592545	-46.540633	2301881.41999999993	2014-12-07 16:17:25.864357	\N
4583	Novos corredores de ônibus - REQUALIFICAÇÃO INAJAR DE SOUZA/RIO BRANCO - (Extensão - 16,4 km)	Inajar de Souza	-23.461480	-46.672935	14434884.2799999993	2014-12-07 16:17:25.898916	\N
4584	Novos corredores de ônibus - VILA NATAL T1 - (Extensão Total - 4,3 km) - (SPTrans)	Vila Natal	-23.764716	-46.716546	1482919	2014-12-07 16:17:25.933121	\N
4585	Novos corredores de ônibus - VILA NATAL T2 - (Extensão Total - 2 km) - (SPTrans)	Vila Natal	-23.764716	-46.716546	689729.770000000019	2014-12-07 16:17:25.962749	\N
4586	Novos corredores de ônibus - M'BOI MIRIM (Requalificação) - 8 km	M'Boi Mirim	-23.721731	-46.785120	2271726.91000000015	2014-12-07 16:17:25.993153	\N
4587	Novos corredores de ônibus - BINÁRIO SANTO AMARO - 8 km	Binário Santo Amaro	-23.652717	-46.705987	999928.380000000005	2014-12-07 16:17:26.024416	\N
4588	Novos corredores de ônibus - CELSO GARCIA T1 -(Extensão Total 5,4 km)	Av. Celso Garcia	-23.534009	-46.566648	1882492.43999999994	2014-12-07 16:17:26.056072	\N
4589	Novos corredores de ônibus - CELSO GARCIA T2 -(Extensão Total 12,7 km)	Av. Celso Garcia	-23.508353	-46.494123	4427343.3200000003	2014-12-07 16:17:26.091772	\N
4590	Novos corredores de ônibus - CELSO GARCIA T3 -(Extensão Total 8,4 km)	Av. Celso Garcia	-23.495228	-46.432239	2928321.56999999983	2014-12-07 16:17:26.131328	\N
4591	Novos corredores de ônibus - PERIMETRAL BANDEIRANTES / SALIM FARAH MALUF (Extensão total 16,6 km)	Perimetral Bandeirantes / Salim Farah Maluf	-23.578974	-46.572035	4713422.9299999997	2014-12-07 16:17:26.173751	\N
4592	Novos corredores de ônibus - NORTE SUL T1 - (Extensão total 5,2 km)	Corredor Norte sul	-23.531924	-46.632463	2111966.95999999996	2014-12-07 16:17:26.213111	\N
4593	Novos corredores de ônibus - NORTE SUL T2 - (Extensão total 9 km)	Corredor Norte sul	-23.56737	-46.640574	3655327.43000000017	2014-12-07 16:17:26.247129	\N
4594	Novos corredores de ônibus - NORTE SUL T3 - (Extensão total 13 km)	Corredor Norte sul	-23.638627	-46.672461	5279917.40000000037	2014-12-07 16:17:26.281019	\N
4595	TERMINAL PONTE RASA (5.760 m2)	\N	-23.507579	-46.491269	1643190.54000000004	2014-12-07 16:17:26.314062	\N
4596	TERMINAL CONCÓRDIA (3.496,0 m2)	\N	-23.542322	-46.616716	1076207.58000000007	2014-12-07 16:17:26.343851	\N
4597	TERMINAL ARICANDUVA (10.568 m2)	\N	-23.528525	-46.554408	44722.2799999999988	2014-12-07 16:17:26.373954	\N
4598	TERMINAL SÃO MIGUEL (8.000 m2)	\N	-23.490594	-46.434812	40014.6699999999983	2014-12-07 16:17:26.403255	\N
4599	NOVO TERMINAL SÃO MATEUS (25.608 m2)	\N	-23.614140	-46.476544	2096823.73999999999	2014-12-07 16:17:26.434039	\N
4600	TERMINAL ITAIM PAULISTA (29.682 m2)	\N	-23.495251	-46.403817	2197889.58999999985	2014-12-07 16:17:26.464517	\N
4601	TERMINAL VILA MARA (6.318 m2)	\N	-23.492722	-46.420413	290202.619999999995	2014-12-07 16:17:26.495387	\N
4602	TERMINAL JARDIM AEROPORTO (9.180 m2)	\N	-23.627939	-46.662329	1705394.03000000003	2014-12-07 16:17:26.526355	\N
4603	TERMINAL JARDIM MIRIAM (9.390 m2)	\N	-23.680175	-46.638837	1705394.03000000003	2014-12-07 16:17:26.556692	\N
4604	TERMINAL BARONESA (9.733 m2)	\N	-23.732755	-46.781776	1591460.25	2014-12-07 16:17:26.586665	\N
4605	TERMINAL SANTANA	\N	-23.516811	-46.623340	303265.799999999988	2014-12-07 16:17:26.618015	\N
4606	TERMINAL JARDIM ELIANA (8.305 m2)	\N	-23.756694	-46.669606	1636126.77000000002	2014-12-07 16:17:26.649092	\N
4607	TERMINAL PEDREIRA  (12.400 m2)	\N	-23.692472	-46.660523	1963856.98999999999	2014-12-07 16:17:26.678259	\N
4608	TERMINAL VARGINHA (11.180 m2)	\N	-23.766975	-46.716551	1636126.77000000002	2014-12-07 16:17:26.707758	\N
4609	TERMINAL ANHANGUERA (13.880 m2)	\N	-23.430938	-46.792601	0	2014-12-07 16:17:26.744257	\N
4610	Implantação das Modalidades Temporais de Bilhete Único	\N			17500000	2014-12-07 16:17:27.158728	\N
4611	Implantação de horário de funcionamento 24h no transporte público municipal	\N	0	0	0	2014-12-07 16:17:27.465779	\N
4612	Implantação de Faixas Exclusivas de ônibus	Av. Aricanduva	0	0	45000000	2014-12-07 16:17:27.846984	\N
4613	Ampliação da Rede Cicloviária da Região Leste - 35 km	\N	0	0	0	2014-12-07 16:17:28.270182	\N
4614	Ampliação da Rede Cicloviária da Região Oeste - 11,5 km	\N	0	0	0	2014-12-07 16:17:28.313088	\N
4615	Ampliação da Rede Sul - 16 km	\N	0	0	0	2014-12-07 16:17:28.344464	\N
4616	Ampliação da Rede Zona Norte - 29 km	\N	0	0	0	2014-12-07 16:17:28.376513	\N
4617	Ciclovia na Avenida Escola Politécnica - Trecho 1 com 1,6 km	\N	-23.562245	-46.749149	0	2014-12-07 16:17:28.415055	\N
4618	Ciclovia Cruzeiro do Sul – 0,7 km	Av. Cruzeiro do Sul, São Paulo, SP	-23.504949	-46.624681	1038058.93999999994	2014-12-07 16:17:28.444216	\N
4619	Ciclovia Eixo Eliseu de Almeida / Metrô Butantã - 1,4 km	Av. Eliseu de Almeida, São Paulo, SP	-23.588441	-46.732667	1349821.68999999994	2014-12-07 16:17:28.477571	\N
4620	Ciclovia Jabaquara (Metrô - Centro de Exposições) - 1,8 km	\N	0	0	116289.039999999994	2014-12-07 16:17:28.505815	\N
4621	Ciclovia Operação Urbana Faria Lima - 12 km	\N	0	0	116289.039999999994	2014-12-07 16:17:28.536322	\N
4622	Ciclovia Polo de Parelheiros - Fase 1 com 4 km	\N	0	0	116289.039999999994	2014-12-07 16:17:28.569682	\N
4623	Ciclovia Conjunto José Bonifácio - 2,4 km	\N	0	0	116289.039999999994	2014-12-07 16:17:28.598768	\N
4624	Ciclovia Ligação Jardim Helena/Itaquera - Fase 1 com 14,9 km	\N	0	0	116289.039999999994	2014-12-07 16:17:28.62763	\N
4625	Ciclovia Polo de Parelheiros - Fase 2 - 23 km	\N	0	0	0	2014-12-07 16:17:28.658661	\N
4626	Rede Cicloviária Polo Turístico Parelheiros - Fase 3 com 33 km	\N	0	0	0	2014-12-07 16:17:28.68927	\N
4627	Rede Cicloviária do Centro Expandido - 24 km	\N	0	0	0	2014-12-07 16:17:28.723601	\N
4628	Rede Cicloviária da Zona Norte - Fase 1 (Jaçanã, Vila Medeiros, Tucuruvi) - 16 km	\N	0	0	116289.039999999994	2014-12-07 16:17:28.760903	\N
4629	Rede Cicloviária Zona Sul - Fase 1 (Grajaú) - 9 km	\N	0	0	116289.039999999994	2014-12-07 16:17:28.794283	\N
4630	Ciclovia Ligação Jardim Helena/Itaquera - Complemento Fase 1 com 3,5 km	\N	0	0	116289.039999999994	2014-12-07 16:17:28.825134	\N
4631	Ciclovia Av. Abel Ferreira (Trecho II)	\N	0	0	0	2014-12-07 16:17:28.854069	\N
4632	Ciclovia Eliseu de Almeida	Rua Santa Albina - Rua Camargo	0	0	0	2014-12-07 16:17:28.883106	\N
4633	Ciclovia Escola Politécnica I	Av. Prof. Luciano Mello Morais (USP) - Av. Corifeu de Azevedo Marques	0	0	0	2014-12-07 16:17:28.911947	\N
4634	Ciclovia Av. de Pinedo	Lgo. do Socorro/ Av. de Pinedo/ R. N. Sra. Do Socorro/ R. Dr. Mauro P.Almeida	0	0	0	2014-12-07 16:17:28.943937	\N
4635	Ciclovia Interlagos	Av. Atlântica/ Av. Berta Waitman/ Av. Luís Romero Sanson	0	0	0	2014-12-07 16:17:28.973482	\N
4636	Ciclovia Av. Dr. Assis Ribeiro I	R. Rio Soturno -Av. Paranagua	0	0	0	2014-12-07 16:17:29.003461	\N
4637	Ciclovia Av. Dr. Assis Ribeiro II	\N	0	0	0	2014-12-07 16:17:29.033699	\N
4638	Ciclovia Av. Dr. Assis Ribeiro III	\N	0	0	0	2014-12-07 16:17:29.063601	\N
4639	Ciclovia Av. Sumaré I / Av. Paulo VI	Rua Turiassu até praça Caetano Fracaroli	0	0	0	2014-12-07 16:17:29.095471	\N
4640	Ciclovia Av. Sumaré II / Av. Paulo VI	\N	0	0	0	2014-12-07 16:17:29.125344	\N
4641	Ciclovia CENTRO VI	Lateral Viaduto/ R. do Bosque/ R. Cap. Mor Gonçalo/ R. Sólon/ R. Lopes Trovão/ R. Silva Pinto	0	0	0	2014-12-07 16:17:29.156053	\N
4642	Ciclovia Abel Ferreira I	 Av. Salim F. Maluf e Av. Regente Feijó 	0	0	0	2014-12-07 16:17:29.188598	\N
4643	Ciclovia Pque. Da Móoca	\N	0	0	0	2014-12-07 16:17:29.219322	\N
4644	Ciclorrotas - BikeSampa	\N	0	0	0	2014-12-07 16:17:29.249799	\N
4645	Ciclovia Cruzeiro do Sul	 R. Cel. Antonio de Carvalho - Av. Gal Ataliba Leonel	0	0	0	2014-12-07 16:17:29.2798	\N
4646	Ciclovia CENTRO I	Rua Antôno de Godói à Sala São Paulo	0	0	0	2014-12-07 16:17:29.311038	\N
4647	Ciclovia CENTRO II	Rua Mauá - Largo do Arouche	0	0	0	2014-12-07 16:17:29.342213	\N
4648	Ciclovia CENTRO III	 Al. Nothman, entre a Rua Júlio Marcondes Salgado e a Al. Cleveland; Al. Cleveland, entre a Al. Nothmann e a Pça. Júlio Prestes; Rua Guaianases, entre a Av. Duque de Caxias e a Al. Eduardo Prado;	0	0	0	2014-12-07 16:17:29.372938	\N
4649	Ciclovia CENTRO IV	\N	0	0	0	2014-12-07 16:17:29.404006	\N
4650	Ciclovia CENTRO VII	\N	0	0	0	2014-12-07 16:17:29.434918	\N
4651	Ciclovia CENTRO VIII	\N	0	0	0	2014-12-07 16:17:29.465703	\N
4652	Ciclovia CENTRO IX	\N	0	0	0	2014-12-07 16:17:29.497306	\N
4653	Ciclovia Cândido Espinheira	\N	0	0	0	2014-12-07 16:17:29.527219	\N
4654	Ciclovia da Região da Luz	\N	0	0	0	2014-12-07 16:17:29.55793	\N
4655	Ciclovia Pari Canindé I	\N	0	0	0	2014-12-07 16:17:29.587814	\N
4656	Ciclovia Pari Canindé II	\N	0	0	0	2014-12-07 16:17:29.618837	\N
4657	Ciclovia Rangel Pestana	\N	0	0	0	2014-12-07 16:17:29.649454	\N
4658	Coclovia Tatuapé	\N	0	0	0	2014-12-07 16:17:29.680202	\N
4659	Ciclovia Vilanova Artigas  (Sapopemba)	\N	0	0	0	2014-12-07 16:17:29.711088	\N
4660	Ciclovia Jd. Helena I	\N	0	0	0	2014-12-07 16:17:29.742535	\N
4661	Ciclovia Jd. Helena II	\N	0	0	0	2014-12-07 16:17:29.772967	\N
4662	Ciclovia Pires de Oliveira (Chácara Sto. Anônio)	\N	0	0	0	2014-12-07 16:17:29.802914	\N
4663	Ciclovia Cambuci	\N	0	0	0	2014-12-07 16:17:29.83433	\N
4664	Ciclovia Interl Faria Lima Ciclopassarela	\N	0	0	0	2014-12-07 16:17:29.865266	\N
4665	Ciclovia Av. Luiz Gushiken	\N	0	0	0	2014-12-07 16:17:29.896145	\N
4666	Ciclovia Cidade Dutra	\N	0	0	0	2014-12-07 16:17:29.927033	\N
4667	Ciclovia Jd Cordeiro/Rubens Gomes de Souza	\N	0	0	0	2014-12-07 16:17:29.958193	\N
4668	Ciclovia Jaraguá / Pque Pinheirinho d´Água	\N	0	0	0	2014-12-07 16:17:29.989199	\N
4669	Ciclovia Jaguaré	\N	0	0	0	2014-12-07 16:17:30.020047	\N
4670	Ciclovia Cunha Gago	\N	0	0	0	2014-12-07 16:17:30.050603	\N
4671	Ciclovia Pacaembú	Al. Eduardo Prado À Rua Dr. Elias Chaves/ Rua Guaianazes à Rua Cons. Nébias/ Rua Dr. Elias Chaves à Rua Capistrano de Abreu/ Rua Cons. Nébias à Rua Souza Lima/ Rua Capistrano de Abreu à Rua Barra Funda/ Pça Olavo Bilac à Av. Pacaembú/ Pça Olavo Bilac/ Pça	0	0	0	2014-12-07 16:17:30.081134	\N
4672	Ciclovia R. Vergueiro/Av. Liberdade	Pça. João Mendes	0	0	0	2014-12-07 16:17:30.112156	\N
4673	Ciclovia CENTRO V	Páteo do Colégio/ Rua São Bento/ Rua Xavier de Toledo/ Praça Ramos de Azevedo/ Rua Líbero Badaró/ Largo  São Francisco/ Praça João Mendes/ Praça da Sé/ R. 7 de abril/ R. Braulio Gomes/ Av. Regente Feijó 	0	0	0	2014-12-07 16:17:30.143516	\N
4674	Vias cicláveis lindeiras aos corredores	\N	0	0	0	2014-12-07 16:17:30.174588	\N
4675	Ciclovia Av. Guilherme Cotching	toda extensão	0	0	0	2014-12-07 16:17:30.205447	\N
4676	Ciclovia Vila Mariana	Av. Lins de Vasconcelos/ Pça. Monteiro dos Santos	0	0	0	2014-12-07 16:17:30.235268	\N
4677	Ciclovia Vila Prudente	Av. Prof. Luiz I. A. Mello	0	0	0	2014-12-07 16:17:30.266275	\N
4678	Ciclovia Av. Prof. Luís Ignácio de Anhaia Melo - sob Monotrilho	Estação Vila Prudente - Rua Salvador Fernandes Lopes	0	0	0	2014-12-07 16:17:30.296384	\N
4679	Projeto DNA Semafórico	\N	0	0	0	2014-12-07 16:17:30.766538	\N
4680	Reforma de 4.800 cruzamentos (semáforos)	\N	0	0	15440787	2014-12-07 16:17:30.80394	\N
4681	Instalação de 1400 nobreaks	\N	0	0	0	2014-12-07 16:17:30.835141	\N
4682	Instalação de 300 controladores	\N	0	0	0	2014-12-07 16:17:30.865275	\N
4683	GPRS	\N	0	0	\N	2014-12-07 16:17:30.894858	\N
4684	Plano Viário Sul - 1º Pontilhão do Rio Embu-Guaçu	Estrada do M'Boi Mirim	-23.721003	-46.785179	10946571.3599999994	2014-12-07 16:17:31.219165	\N
4685	Plano Viário Sul - 2º Pontilhão do Rio Embu-Guaçu	Estrada do M'Boi Mirim	-23.721003	-46.785179	10946571.3599999994	2014-12-07 16:17:31.257662	\N
4686	Plano Viário Sul - BELMIRA MARIN - TRECHO 1 - 3,1 km (Corredor de ônibus, melhoramento e duplicação)	Av. Dona Belmira Marin, São Paulo, SP	-23.753446	-46.680991	507588.320000000007	2014-12-07 16:17:31.287354	\N
4687	Plano Viário Sul - GUARAPIRANGA / GUAVIRUTUBA - 5,7 km (Corredor de ônibus, melhoramento e duplicação)	Av. Guarapiranga, São Paulo, SP	-23.676036	-46.734310	933307.550000000047	2014-12-07 16:17:31.317858	\N
4688	Plano Viário Sul - AGAMENON - BARONESA - 7,5 km (Corredor de ônibus, melhoramento e duplicação)	Estrada da Baronesa, São Paulo, SP	-23.702776	-46.772252	1228036.26000000001	2014-12-07 16:17:31.347454	\N
4689	Plano Viário Sul - AV. CARLOS CALDEIRA FILHO - 3,3 km (Prolongamento com corredor de ônibus e canalização do córrego Água dos Brancos)	Av. Carlos Caldeira Filho, São Paulo, SP	-23.644119	-46.748496	540335.949999999953	2014-12-07 16:17:31.377666	\N
4690	Plano Viário Sul - M'BOI MIRIM / CACHOEIRINHA - 5,5 km (Corredor de ônibus, prolongamento e duplicação)	Estrada do M'Boi mirim, São Paulo, SP	-23.698783	-46.779614	900559.920000000042	2014-12-07 16:17:31.408431	\N
4691	Plano Viário Sul - ESTRADA DE ITAPECIRICA - 4,9 km (Melhoramento e alargamento)	Estrada de Itapecirica, São Paulo, SP	-23.682528	-46.797314	802317.020000000019	2014-12-07 16:17:31.438647	\N
4692	Plano Viário Sul - ESTRADA DO ALVARENGA - 6,3 km (Corredor de ônibus com alargamento e melhoramento)	Estrada do Alvarenga, São Paulo, SP	-23.713615	-46.635096	1031550.45999999996	2014-12-07 16:17:31.470526	\N
4693	Execução das obras do Prolongamento da Radial Leste, incluindo viaduto Guaianazes, Pontilhões, Interligações Viárias e Canalização de Córregos, desde Artur Alvim até Guaianazes	Radial Leste	-23.540643	-46.484639	17341379.9899999984	2014-12-07 16:17:31.819978	\N
4694	Construção da Ponte Raimundo Pereira de Magalhães	Avenida Raimundo Pereira de Magalhães sobre o Rio Tietê	-23.508068	-46.715558	11870.0900000000001	2014-12-07 16:17:32.152079	\N
4695	Ampliação do Programa de Proteção ao Pedestre (novas áreas de circulação de pedestres atendidas)	Regiões Centro, Norte, Sul, Leste e Oeste.	0	0	2000000	2014-12-07 16:17:32.485718	\N
4696	Construção da Alça do Aricanduva	Ponte Aricanduva	-23.523500	-46.557896	13139.6499999999996	2014-12-07 16:17:32.84739	\N
4697	PRA - Avenida Cipriano Rodrigues	Avenida Cipriano Rodrigues	-23.575984	-46.52043	0	2014-12-07 16:17:33.186905	\N
4698	PRA - Rua Almir Alves de Souza	Rua Almir Alves de Souza	-23.582041	-46.521393	0	2014-12-07 16:17:33.225668	\N
4699	PRA - Rua Anjo Custodio	Rua Anjo Custodio	-23.563928	-46.552917	0	2014-12-07 16:17:33.260735	\N
4700	PRA - Rua Estanislau Bonk Filho	Rua Estanislau Bonk Filho	-23.577459	-46.522511	0	2014-12-07 16:17:33.292645	\N
4701	PRA - Rua Euclides Pacheco	Rua Euclides Pacheco	-23.545163	-46.554032	0	2014-12-07 16:17:33.324753	\N
4702	PRA - Travessa Mario Mendes	Travessa Mario Mendes	-23.542011	-46.541123	0	2014-12-07 16:17:33.356982	\N
4703	PRA - Leonel Ferreira	Leonel Ferreira	-23.511619	-46.479058	9939096.61999999918	2014-12-07 16:17:33.388755	\N
4704	PRA - Reverendo Izac Silvério	Reverendo Izac Silvério	-23.485428	-46.472824	9939096.61999999918	2014-12-07 16:17:33.420966	\N
4705	PRA - Rua Heráclito Patriarca dos Santos	Rua Heráclito Patriarca dos Santos	-23.523533	-46.484587	9939096.61999999918	2014-12-07 16:17:33.453773	\N
4706	PRA - Rua Julieta Algores	Rua Julieta Algores	-23.515023	-46.477772	0	2014-12-07 16:17:33.510294	\N
4707	PRA - Rua Sancho Junqueira	Rua Sancho Junqueira	-23.513548	-46.498884	9939096.61999999918	2014-12-07 16:17:33.542651	\N
4708	PRA - João Delgado	João Delgado	-23.485329	-46.690399	9939096.61999999918	2014-12-07 16:17:33.574951	\N
4709	PRA - R. Monte Alegre do Sul	R. Monte Alegre do Sul	-23.439378	-46.709867	9939096.61999999918	2014-12-07 16:17:33.605896	\N
4710	PRA - Raulino Gaudino	R. Raulino Gaudino da Silva	-23.476237	-46.70057	9939096.61999999918	2014-12-07 16:17:33.636528	\N
4711	PRA - Rodolfo Bardela	Rodolfo Bardela	-23.469269	-46.692971	9939096.61999999918	2014-12-07 16:17:33.668797	\N
4712	PRA - Rua Maestro Batista Julião	Rua Maestro Batista Julião	-23.597753	-46.621815	9939096.61999999918	2014-12-07 16:17:33.700646	\N
4713	PRA - Rua Santa Cruz	Rua Santa Cruz	-23.598975	-46.624544	0	2014-12-07 16:17:33.732687	\N
4714	PRA - Rua Afuá	Rua Afuá	-23.506169	-46.387852	9939096.61999999918	2014-12-07 16:17:33.763527	\N
4715	PRA - Rua Chacuru	Rua Chacuru	-23.496743	-46.426638	0	2014-12-07 16:17:33.795278	\N
4716	PRA - Rua Desembargador Fausto Whitaker Machado Alvim	Rua Desembargador Fausto Whitaker Machado Alvim	-23.504674	-46.370309	9939096.61999999918	2014-12-07 16:17:33.828001	\N
4717	PRA - Rua Paulo Martin Garro	Rua Paulo Martin Garro	-23.496724	-46.386157	9939096.61999999918	2014-12-07 16:17:33.86035	\N
4718	PRA - Rua Francisco Rodrigues Sekler	Rua Francisco Rodrigues Sekler	-23.526425	-46.455443	0	2014-12-07 16:17:33.891923	\N
4719	PRA - Rua São Teodoro/Fontana Xavier	Rua São Teodoro/Fontana Xavier	-23.555392	-46.446517	0	2014-12-07 16:17:33.925247	\N
4720	PRA - Av. Água Funda	Av. Água Funda	-23.63733	-46.634606	0	2014-12-07 16:17:33.961659	\N
4721	PRA - Rua Paulino Arena	Rua Paulino Arena	-23.484212	-46.563883	0	2014-12-07 16:17:33.993347	\N
4722	PRA - Acesso a Polícia Federal	Acesso a Polícia Federal (Rua Ricardo Cavatton)	-23.511068	-46.702845	0	2014-12-07 16:17:34.026111	\N
4723	PRA - Av. Presidente Altino	Av. Presidente Altino	-23.529996	-46.75842	0	2014-12-07 16:17:34.058169	\N
4724	PRA - Rua  Miguel Motta	Rua  Miguel Motta	-23.566672	-46.570521	9939096.61999999918	2014-12-07 16:17:34.090417	\N
4725	PRA - Rua Canuto Saraiva	Rua Canuto Saraiva	-23.560329	-46.603453	0	2014-12-07 16:17:34.123699	\N
4726	PRA - Rua João Teodoro	Rua João Teodoro	-23.535091	-46.621687	9939096.61999999918	2014-12-07 16:17:34.156311	\N
4727	PRA - Rua Orville Derby	Rua Orville Derby	-23.556847	-46.602613	0	2014-12-07 16:17:34.188338	\N
4728	PRA - Rua Visconde de Cairu	Rua Visconde de Cairu	-23.563554	-46.602981	0	2014-12-07 16:17:34.22097	\N
4729	PRA - Rua Armando Cardoso Alves/Clube Desportivo	Rua Armando Cardoso Alves/Clube Desportivo	-23.524526	-46.555945	0	2014-12-07 16:17:34.253386	\N
4730	PRA - Rua Coatimirim	Rua Coatimirim	-23.516971	-46.526801	0	2014-12-07 16:17:34.284746	\N
4731	PRA - Rua Tapendi e Rua Tacoativa	Rua Tapendi e Rua Tacoativa	-23.492473	-46.712603	9939096.61999999918	2014-12-07 16:17:34.317334	\N
4732	PRA - Rua Coronel Joaquim Ferreira de Souza	Rua Coronel Joaquim Ferreira de Souza	-23.478441	-46.641368	9939096.61999999918	2014-12-07 16:17:34.349392	\N
4733	PRA - Rua Helena Sacramento	Rua Helena Sacramento	-23.483125	-46.636215	9939096.61999999918	2014-12-07 16:17:34.381113	\N
4734	PRA - Rua Jardimirim	Rua Jardimirim	-23.486038	-46.637975	9939096.61999999918	2014-12-07 16:17:34.413503	\N
4735	PRA - Rua Jardinésia	Rua Jardinésia	-23.483971	-46.635293	9939096.61999999918	2014-12-07 16:17:34.44549	\N
4736	PRA - Rua Pataiba	Rua Pataiba	-23.474938	-46.610748	0	2014-12-07 16:17:34.480606	\N
4737	PRA - Travessa Neco	Travessa Neco	-23.481521	-46.65073	9939096.61999999918	2014-12-07 16:17:34.512816	\N
4738	PRA - Rua Ministro Álvaro de Souza Lima	Rua Ministro Álvaro de Souza Lima	-23.657379	-46.683275	0	2014-12-07 16:17:34.546433	\N
4739	PRA - Córrego Sitio Casa Pintada	Córrego Sitio Casa Pintada	-23.50912	-46.453525	9939096.61999999918	2014-12-07 16:17:34.579193	\N
4740	PRA - Rua Galvão Bueno	Rua Galvão Bueno 	-23.563426	-46.634448	0	2014-12-07 16:17:34.611478	\N
4741	PRA - Rua Eugenio Freitas	Rua Eugenio Freitas	-23.519559	-46.602176	9939096.61999999918	2014-12-07 16:17:34.644066	\N
4742	PRA - Rua Leandro Ferreira	Rua Leandro Ferreira	-23.509199	-46.60186	9939096.61999999918	2014-12-07 16:17:34.676476	\N
4743	PRA - Rua Maria Quedas	Rua Maria Quedas	-23.514505	-46.573443	9939096.61999999918	2014-12-07 16:17:34.70875	\N
4744	PRA - Travessa Emabaúba	Travessa Emabaúba	-23.508378	-46.602594	9939096.61999999918	2014-12-07 16:17:34.751304	\N
4745	PRA - Córrego Afluente J	Córrego Afluente J	-23.602094	-46.497784	0	2014-12-07 16:17:34.783558	\N
4746	Intervenções de controle de cheias da Bacia do Córrego Anhangabaú / Praça das Bandeiras	Córrego Anhangabaú / Praça das Bandeiras	-23.548254	-46.638435	600000	2014-12-07 16:17:35.216656	\N
4747	Intervenções de controle de cheias da Bacia do Córrego Aricanduva	Córrego Aricanduva	-23.550345	-46.523288	0	2014-12-07 16:17:35.259915	\N
4748	Intervenções de controle de cheias da Bacia do Córrego Córrego Sumaré / Água Preta	Córrego Córrego Sumaré / Água Preta	-23.525548	-46.676434	5273430.54000000004	2014-12-07 16:17:35.291409	\N
4749	Intervenções de controle de cheias da Bacia do Córrego do Cordeiro	Córrego do Cordeiro	-23.627735	-46.685621	15560364.9299999997	2014-12-07 16:17:35.324966	\N
4750	Intervenções de controle de cheias da Bacia do Córrego Morro do S (Freitas / Capão Redondo)	Córrego Morro do S (Freitas / Capão Redondo)	-23.638414	-46.741474	224021.869999999995	2014-12-07 16:17:35.355431	\N
4751	Intervenções de controle de cheias da Bacia do Córrego Paciência	Córrego Paciência	-23.472967	-46.572718	0	2014-12-07 16:17:35.387551	\N
4752	Intervenções de controle de cheias da Bacia do Córrego Ponte Baixa	Córrego Ponte Baixa	-23.667400	-46.728719	124267520	2014-12-07 16:17:35.421785	\N
4753	Intervenções de controle de cheias da Bacia do Córrego Tremembé	Córrego Tremembé	-23.464921	-46.592770	0	2014-12-07 16:17:35.455632	\N
4754	Intervenções de controle de cheias da Bacia do Córrego Uberaba (Paraguai/ Éguas)	Córrego Uberaba (Paraguai/ Éguas)	-23.597301	-46.650515	0	2014-12-07 16:17:35.498133	\N
4755	Intervenções de controle de cheias da Bacia do Córrego Zavuvus	Córrego Zavuvus	-23.682343	-46.689791	0	2014-12-07 16:17:35.537006	\N
4756	Intervenções de controle de cheias da Bacia do Riacho do Ipiranga	Riacho do Ipiranga	-23.651492	-46.617011	0	2014-12-07 16:17:35.580789	\N
4757	Intervenções de controle de cheias da Bacia do Ribeirão Perus	Ribeirão Perus	-23.497544	-46.725464	0	2014-12-07 16:17:35.617471	\N
4758	Elaboração de projeto básico e viabilização do inicio da intervenção de controle de cheias em bacias dos córregos: Ribeirão Água Vermelha, Ribeirão Lajeado, Córrego Itaim, Córrego Tijuco Preto e afluentes	Itaim Paulista	-23.495235	-46.417958	0	2014-12-07 16:17:35.657205	\N
4759	Criação da Instância Municipal de Drenagem	\N	0	0	0	2014-12-07 16:17:36.090165	\N
4760	Readequação do Centro de Atendimento ao Cidadão (CAC) - Aricanduva	R. Atucuri, 699	-23.550798	-46.547983	0	2014-12-07 16:17:36.501591	\N
4761	Readequação do Centro de Atendimento ao Cidadão (CAC) - Butantã	R. Ulpiano da Costa Manso, 201	-23.588330	-46.737970	0	2014-12-07 16:17:36.552097	\N
4762	Readequação do Centro de Atendimento ao Cidadão (CAC) - Campo Limpo	R. Nossa Senhora do Bom Conselho, 59	-23.647206	-46.756516	0	2014-12-07 16:17:36.593212	\N
4763	Readequação do Centro de Atendimento ao Cidadão (CAC) - Capela do Socorro	R. Cassiano dos Santos, 499	-23.719792	-46.701655	0	2014-12-07 16:17:36.633564	\N
4764	Readequação do Centro de Atendimento ao Cidadão (CAC) - Casa Verde/Cachoeirinha	Av. Ordem e Progresso, 1001	-23.511814	-46.666410	0	2014-12-07 16:17:36.673198	\N
4765	Readequação do Centro de Atendimento ao Cidadão (CAC) - Cidade Ademar	Av. Yervant Kissajikain, 416	-23.667095	-46.675156	0	2014-12-07 16:17:36.717235	\N
4766	Readequação do Centro de Atendimento ao Cidadão (CAC) - Cidade Tiradentes	Estrada do Iguatemi, 2751	-23.583722	-46.415037	0	2014-12-07 16:17:36.779615	\N
4767	Readequação do Centro de Atendimento ao Cidadão (CAC) - Ermelino Matarazzo	Av. São Miguel, 5550	-23.507549	-46.480027	0	2014-12-07 16:17:36.821919	\N
4768	Readequação do Centro de Atendimento ao Cidadão (CAC) - Freguesia/Brasilândia	Av. João Marcelino Branco, 95	-23.476254	-46.664980	0	2014-12-07 16:17:36.864709	\N
4769	Readequação do Centro de Atendimento ao Cidadão (CAC) - Guaianases	Estrada Itaquera-Guaianases, 2565	-23.542740	-46.424741	0	2014-12-07 16:17:36.911781	\N
4770	Readequação do Centro de Atendimento ao Cidadão (CAC) - Ipiranga	R. Lino Coutinho, 444	-23.587359	-46.603036	0	2014-12-07 16:17:36.951773	\N
4771	Readequação do Centro de Atendimento ao Cidadão (CAC) - Itaim Paulista	Av. Marechal Tito, 3012	-23.494031	-46.416711	0	2014-12-07 16:17:36.995948	\N
4772	Readequação do Centro de Atendimento ao Cidadão (CAC) - Itaquera	R.Augusto Carlos Bauman, 851	-23.532007	-46.447028	0	2014-12-07 16:17:37.036355	\N
4773	Readequação do Centro de Atendimento ao Cidadão (CAC) - Jabaquara	Av. Engº Armando de Arruda Pereira, 2314	-23.647653	-46.640204	0	2014-12-07 16:17:37.078082	\N
4774	Readequação do Centro de Atendimento ao Cidadão (CAC) - Jaçanã/Tremembé	Av. Luis Stamatis, 300	-23.468164	-46.582175	0	2014-12-07 16:17:37.123821	\N
4775	Readequação do Centro de Atendimento ao Cidadão (CAC) - Lapa	Rua Guaicurus, 1000	-23.522546	-46.695496	0	2014-12-07 16:17:37.168346	\N
4776	Readequação do Centro de Atendimento ao Cidadão (CAC) - M'Boi Mirim	Av. Guarapiranga, 1265 	-23.680784	-46.734864	0	2014-12-07 16:17:37.208182	\N
4777	Readequação do Centro de Atendimento ao Cidadão (CAC) - Mooca	R. Taquari, 549	-23.551362	-46.597852	0	2014-12-07 16:17:37.248214	\N
4778	Readequação do Centro de Atendimento ao Cidadão (CAC) - Parelheiros	Av. Sadamu Inoue, 5252	-23.815128	-46.735315	0	2014-12-07 16:17:37.286715	\N
4779	Readequação do Centro de Atendimento ao Cidadão (CAC) - Penha	R. Candapuí, 492 	-23.518634	-46.521410	0	2014-12-07 16:17:37.325973	\N
4780	Readequação do Centro de Atendimento ao Cidadão (CAC) - Perus	R. Ylídio Figueiredo, 349	-23.407298	-46.753125	0	2014-12-07 16:17:37.36789	\N
4781	Readequação do Centro de Atendimento ao Cidadão (CAC) - Pinheiros	Av. Nações Unidas, 7123	-23.679163	-46.696099	0	2014-12-07 16:17:37.414434	\N
4782	Readequação do Centro de Atendimento ao Cidadão (CAC) - Pirituba	Av. Dr. Felipe Pinel, 12	-23.487228	-46.726914	0	2014-12-07 16:17:37.453106	\N
4783	Readequação do Centro de Atendimento ao Cidadão (CAC) - Santana/Tucuruvi	Av. Tucuruvi, 808	-23.481286	-46.604271	0	2014-12-07 16:17:37.5033	\N
4784	Readequação do Centro de Atendimento ao Cidadão (CAC) - Santo Amaro	Praça Floriano Peixoto, 54	-23.651517	-46.707269	0	2014-12-07 16:17:37.579741	\N
4785	Readequação do Centro de Atendimento ao Cidadão (CAC) - Sapopemba	\N	0	0	0	2014-12-07 16:17:37.645145	\N
4786	Readequação do Centro de Atendimento ao Cidadão (CAC) - São Mateus	R. Ragueb Chohfi, 1.400	-23.599709	-46.469238	0	2014-12-07 16:17:37.683758	\N
4787	Readequação do Centro de Atendimento ao Cidadão (CAC) - São Miguel	R. Ana Flora Pinheiro de Sousa, 76	-23.500749	-46.451069	0	2014-12-07 16:17:37.722352	\N
4788	Readequação do Centro de Atendimento ao Cidadão (CAC) - Sé	R. Álvares Penteado, 49	-23.547780	-46.634672	0	2014-12-07 16:17:37.764559	\N
4789	Readequação do Centro de Atendimento ao Cidadão (CAC) - Vila Maria/Vila Guilherme	R.General Mendes, 111	-23.501297	-46.591352	0	2014-12-07 16:17:37.799286	\N
4790	Readequação do Centro de Atendimento ao Cidadão (CAC) - Vila Mariana	R. José de Magalhães, 500	-23.598725	-46.649309	0	2014-12-07 16:17:37.839445	\N
4791	Readequação do Centro de Atendimento ao Cidadão (CAC) - Vila Prudente	Avenida do Oratório, 172	-23.582700	-46.560589	0	2014-12-07 16:17:37.875289	\N
4792	Modernizar o 156	\N			0	2014-12-07 16:17:38.312111	\N
4793	Criação da Subprefeitura de Sapopemba	Avenida Sapopemba, 9064	-23.600188	-46.512823	0	2014-12-07 16:17:38.665709	\N
4794	Implantação da Central de Operações da Defesa Civil	\N			0	2014-12-07 16:17:39.023975	\N
4795	Desenvolvimento do Sistema de Informações Geográficas do Município de São Paulo - SIGSP	\N			213337	2014-12-07 16:17:39.373987	\N
4796	Núcleos de Defesa Civil	\N	0	0	0	2014-12-07 16:17:39.964157	\N
4797	Criação do Conselho da Cidade	\N	0	0	0	2014-12-07 16:17:40.384303	\N
4798	Criação do Conselho Municipal de Transportes	\N	0	0	0	2014-12-07 16:17:40.427742	\N
4799	Criação do Conselho Municipal da Igualdade Racial	\N	0	0	0	2014-12-07 16:17:40.460987	\N
4800	Criação do Conselho Municipal do Esporte, Lazer e Recreação	\N	0	0	0	2014-12-07 16:17:40.494131	\N
4801	Criação do Conselho Municipal de Políticas para as Mulheres	\N	0	0	0	2014-12-07 16:17:40.527805	\N
4802	Criação do Conselho Municipal de Defesa do Consumidor	\N	0	0	0	2014-12-07 16:17:40.559657	\N
4803	Criação do Conselho Municipal de Transparência Pública e Combate à corrupção	\N	0	0	0	2014-12-07 16:17:40.591503	\N
4804	Criação do Conselho Municipal de Comunicação	\N	0	0	0	2014-12-07 16:17:40.623703	\N
4805	Criação de Conselhos Participativos	\N	0	0	0	2014-12-07 16:17:41.107594	\N
4806	Realização de Conferências Municipais Temáticas	\N	0	0	225226.119999999995	2014-12-07 16:17:41.55724	\N
4807	Implantação do Gabinete Digital	\N			0	2014-12-07 16:17:41.936786	\N
4808	Fortalecimento dos órgãos colegiados municipais	\N	0	0	0	2014-12-07 16:17:42.315336	\N
4809	Criação do Observatório de Indicadores da Cidade	\N			0	2014-12-07 16:17:42.700146	\N
4810	Criação do Conselho Participativo de Planejamento e Orçamento	\N	0	0	0	2014-12-07 16:17:43.106552	\N
4811	Criação do Portal PlanejaSampa	\N			0	2014-12-07 16:17:43.155604	\N
4812	Realização de Audiências Públicas do Ciclo de Planejamento e Orçamento Participativos	\N	0	0	0	2014-12-07 16:17:43.188621	\N
4813	Realização de Cafés Hacker do Ciclo de Planejamento e Orçamento Participativos	\N	0	0	0	2014-12-07 16:17:43.221125	\N
4814	Realização de Eventos de Formação e Seminários sobre o Ciclo de Planejamento e Orçamento Participativos	\N	0	0	0	2014-12-07 16:17:43.254239	\N
4815	Aprovação do novo Plano Diretor Estratégico	\N			0	2014-12-07 16:17:43.643903	\N
4816	Desenvolvimento de ações participativas para a revisão do marco regulatório - Lei de Uso e Ocupação do Solo	\N			0	2014-12-07 16:17:44.041755	\N
4817	Desenvolvimento de ações participativas para a revisão do marco regulatório - Planos Regionalis Estratégicos	\N			0	2014-12-07 16:17:44.445702	\N
4818	Operação Urbana Água Branca	\N			0	2014-12-07 16:17:44.858842	\N
4819	Operação Urbana Mooca - Vila Carioca	\N			0	2014-12-07 16:17:44.902731	\N
4820	Arco Tietê	\N			0	2014-12-07 16:17:44.939074	\N
\.


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_id_seq', 4820, true);


--
-- Data for Name: project_prefecture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_prefecture (id, project_id, prefecture_id, created_at, update_at) FROM stdin;
305767	2805	304	2014-12-07 16:10:43.045824	\N
305768	2805	305	2014-12-07 16:10:43.080005	\N
305769	2805	306	2014-12-07 16:10:43.082599	\N
305770	2805	307	2014-12-07 16:10:43.085018	\N
305771	2805	308	2014-12-07 16:10:43.087479	\N
305772	2805	309	2014-12-07 16:10:43.08991	\N
305773	2805	310	2014-12-07 16:10:43.092344	\N
305774	2805	311	2014-12-07 16:10:43.094604	\N
305775	2805	312	2014-12-07 16:10:43.096819	\N
305776	2805	313	2014-12-07 16:10:43.09919	\N
305777	2805	314	2014-12-07 16:10:43.10167	\N
305778	2805	315	2014-12-07 16:10:43.103924	\N
305779	2805	316	2014-12-07 16:10:43.106104	\N
305780	2805	317	2014-12-07 16:10:43.108379	\N
305781	2805	318	2014-12-07 16:10:43.110569	\N
305782	2805	319	2014-12-07 16:10:43.112831	\N
305783	2805	320	2014-12-07 16:10:43.115062	\N
305784	2805	321	2014-12-07 16:10:43.117505	\N
305785	2805	322	2014-12-07 16:10:43.119749	\N
305786	2805	323	2014-12-07 16:10:43.121954	\N
305787	2805	324	2014-12-07 16:10:43.124205	\N
305788	2805	325	2014-12-07 16:10:43.126261	\N
305789	2805	326	2014-12-07 16:10:43.128426	\N
305790	2805	327	2014-12-07 16:10:43.130696	\N
305791	2805	328	2014-12-07 16:10:43.133384	\N
305792	2805	329	2014-12-07 16:10:43.135606	\N
305793	2805	330	2014-12-07 16:10:43.138084	\N
305794	2805	331	2014-12-07 16:10:43.140208	\N
305795	2805	332	2014-12-07 16:10:43.142322	\N
305796	2805	333	2014-12-07 16:10:43.144386	\N
305797	2805	334	2014-12-07 16:10:43.146438	\N
305798	2805	335	2014-12-07 16:10:43.148626	\N
305799	2805	336	2014-12-07 16:10:43.150809	\N
305800	2805	304	2014-12-07 16:12:57.716892	\N
305801	2805	305	2014-12-07 16:12:57.720681	\N
305802	2805	306	2014-12-07 16:12:57.723106	\N
305803	2805	307	2014-12-07 16:12:57.72575	\N
305804	2805	308	2014-12-07 16:12:57.72833	\N
305805	2805	309	2014-12-07 16:12:57.730755	\N
305806	2805	310	2014-12-07 16:12:57.733177	\N
305807	2805	311	2014-12-07 16:12:57.735545	\N
305808	2805	312	2014-12-07 16:12:57.738222	\N
305809	2805	313	2014-12-07 16:12:57.740656	\N
305810	2805	314	2014-12-07 16:12:57.74313	\N
305811	2805	315	2014-12-07 16:12:57.745498	\N
305812	2805	316	2014-12-07 16:12:57.747845	\N
305813	2805	317	2014-12-07 16:12:57.750134	\N
305814	2805	318	2014-12-07 16:12:57.752299	\N
305815	2805	319	2014-12-07 16:12:57.754467	\N
305816	2805	320	2014-12-07 16:12:57.760821	\N
305817	2805	321	2014-12-07 16:12:57.763101	\N
305818	2805	322	2014-12-07 16:12:57.765268	\N
305819	2805	323	2014-12-07 16:12:57.767963	\N
305820	2805	324	2014-12-07 16:12:57.770342	\N
305821	2805	325	2014-12-07 16:12:57.772631	\N
305822	2805	326	2014-12-07 16:12:57.774733	\N
305823	2805	327	2014-12-07 16:12:57.77708	\N
305824	2805	328	2014-12-07 16:12:57.779235	\N
305825	2805	329	2014-12-07 16:12:57.781282	\N
305826	2805	330	2014-12-07 16:12:57.783247	\N
305827	2805	331	2014-12-07 16:12:57.785302	\N
305828	2805	332	2014-12-07 16:12:57.787237	\N
305829	2805	333	2014-12-07 16:12:57.789476	\N
305830	2805	334	2014-12-07 16:12:57.791697	\N
305831	2805	335	2014-12-07 16:12:57.79394	\N
305832	2805	336	2014-12-07 16:12:57.796395	\N
305833	2805	304	2014-12-07 16:16:31.482313	\N
305834	2805	305	2014-12-07 16:16:31.498212	\N
305835	2805	306	2014-12-07 16:16:31.52689	\N
305836	2805	307	2014-12-07 16:16:31.576294	\N
305837	2805	308	2014-12-07 16:16:31.604362	\N
305838	2805	309	2014-12-07 16:16:31.606883	\N
305839	2805	310	2014-12-07 16:16:31.609662	\N
305840	2805	311	2014-12-07 16:16:31.61216	\N
305841	2805	312	2014-12-07 16:16:31.614345	\N
305842	2805	313	2014-12-07 16:16:31.616495	\N
305843	2805	314	2014-12-07 16:16:31.618602	\N
305844	2805	315	2014-12-07 16:16:31.620699	\N
305845	2805	316	2014-12-07 16:16:31.62286	\N
305846	2805	317	2014-12-07 16:16:31.625307	\N
305847	2805	318	2014-12-07 16:16:31.627366	\N
305848	2805	319	2014-12-07 16:16:31.629477	\N
305849	2805	320	2014-12-07 16:16:31.631512	\N
305850	2805	321	2014-12-07 16:16:31.633656	\N
305851	2805	322	2014-12-07 16:16:31.63584	\N
305852	2805	323	2014-12-07 16:16:31.637965	\N
305853	2805	324	2014-12-07 16:16:31.640725	\N
305854	2805	325	2014-12-07 16:16:31.643157	\N
305855	2805	326	2014-12-07 16:16:31.645481	\N
305856	2805	327	2014-12-07 16:16:31.647742	\N
305857	2805	328	2014-12-07 16:16:31.649861	\N
305858	2805	329	2014-12-07 16:16:31.652001	\N
305859	2805	330	2014-12-07 16:16:31.654069	\N
305860	2805	331	2014-12-07 16:16:31.656436	\N
305861	2805	332	2014-12-07 16:16:31.65876	\N
305862	2805	333	2014-12-07 16:16:31.660888	\N
305863	2805	334	2014-12-07 16:16:31.663191	\N
305864	2805	335	2014-12-07 16:16:31.66549	\N
305865	2805	336	2014-12-07 16:16:31.667534	\N
305866	2806	304	2014-12-07 16:16:31.80635	\N
305867	2806	305	2014-12-07 16:16:31.808867	\N
305868	2806	306	2014-12-07 16:16:31.811137	\N
305869	2806	307	2014-12-07 16:16:31.813315	\N
305870	2806	308	2014-12-07 16:16:31.815519	\N
305871	2806	309	2014-12-07 16:16:31.817702	\N
305872	2806	310	2014-12-07 16:16:31.82027	\N
305873	2806	311	2014-12-07 16:16:31.822728	\N
305874	2806	312	2014-12-07 16:16:31.825313	\N
305875	2806	313	2014-12-07 16:16:31.827654	\N
305876	2806	314	2014-12-07 16:16:31.829948	\N
305877	2806	315	2014-12-07 16:16:31.832145	\N
305878	2806	316	2014-12-07 16:16:31.834779	\N
305879	2806	317	2014-12-07 16:16:31.837038	\N
305880	2806	318	2014-12-07 16:16:31.839218	\N
305881	2806	319	2014-12-07 16:16:31.84153	\N
305882	2806	320	2014-12-07 16:16:31.843957	\N
305883	2806	321	2014-12-07 16:16:31.846181	\N
305884	2806	322	2014-12-07 16:16:31.848309	\N
305885	2806	323	2014-12-07 16:16:31.85141	\N
305886	2806	324	2014-12-07 16:16:31.853988	\N
305887	2806	325	2014-12-07 16:16:31.856379	\N
305888	2806	326	2014-12-07 16:16:31.858927	\N
305889	2806	327	2014-12-07 16:16:31.861228	\N
305890	2806	328	2014-12-07 16:16:31.863423	\N
305891	2806	329	2014-12-07 16:16:31.865681	\N
305892	2806	330	2014-12-07 16:16:31.869014	\N
305893	2806	331	2014-12-07 16:16:31.875564	\N
305894	2806	332	2014-12-07 16:16:31.881631	\N
305895	2806	333	2014-12-07 16:16:31.884626	\N
305896	2806	334	2014-12-07 16:16:31.886862	\N
305897	2806	335	2014-12-07 16:16:31.888949	\N
305898	2806	336	2014-12-07 16:16:31.891142	\N
305899	2807	336	2014-12-07 16:16:31.901246	\N
305900	2808	323	2014-12-07 16:16:31.937406	\N
305901	2809	307	2014-12-07 16:16:31.948328	\N
305902	2810	312	2014-12-07 16:16:31.957192	\N
305903	2811	307	2014-12-07 16:16:31.96687	\N
305904	2812	307	2014-12-07 16:16:31.977087	\N
305905	2813	307	2014-12-07 16:16:31.986237	\N
305906	2814	307	2014-12-07 16:16:31.995511	\N
305907	2815	326	2014-12-07 16:16:32.005134	\N
305908	2816	320	2014-12-07 16:16:32.014706	\N
305909	2817	320	2014-12-07 16:16:32.023708	\N
305910	2818	320	2014-12-07 16:16:32.034311	\N
305911	2819	320	2014-12-07 16:16:32.044007	\N
305912	2820	316	2014-12-07 16:16:32.053989	\N
305913	2821	316	2014-12-07 16:16:32.064746	\N
305914	2822	321	2014-12-07 16:16:32.074413	\N
305915	2823	322	2014-12-07 16:16:32.084034	\N
305916	2824	316	2014-12-07 16:16:32.094172	\N
305917	2825	309	2014-12-07 16:16:32.103987	\N
305918	2826	328	2014-12-07 16:16:32.113544	\N
305919	2827	330	2014-12-07 16:16:32.123508	\N
305920	2828	329	2014-12-07 16:16:32.133671	\N
305921	2829	335	2014-12-07 16:16:32.143309	\N
305922	2830	321	2014-12-07 16:16:32.153563	\N
305923	2831	318	2014-12-07 16:16:32.163465	\N
305924	2832	332	2014-12-07 16:16:32.172647	\N
305925	2833	334	2014-12-07 16:16:32.183225	\N
305926	2834	315	2014-12-07 16:16:32.193186	\N
305927	2835	315	2014-12-07 16:16:32.202644	\N
305928	2836	318	2014-12-07 16:16:32.212607	\N
305929	2837	307	2014-12-07 16:16:32.22223	\N
305930	2838	306	2014-12-07 16:16:32.231986	\N
305931	2839	310	2014-12-07 16:16:32.241816	\N
305932	2840	322	2014-12-07 16:16:32.350214	\N
305933	2841	309	2014-12-07 16:16:32.361179	\N
305934	2842	310	2014-12-07 16:16:32.37176	\N
305935	2843	325	2014-12-07 16:16:32.382286	\N
305936	2844	336	2014-12-07 16:16:32.423489	\N
305937	2845	336	2014-12-07 16:16:32.433947	\N
305938	2846	336	2014-12-07 16:16:32.476853	\N
305939	2847	329	2014-12-07 16:16:32.520895	\N
305940	2848	326	2014-12-07 16:16:32.531003	\N
305941	2849	330	2014-12-07 16:16:32.541853	\N
305942	2850	336	2014-12-07 16:16:32.552378	\N
305943	2851	331	2014-12-07 16:16:32.596988	\N
305944	2852	321	2014-12-07 16:16:32.608475	\N
305945	2853	327	2014-12-07 16:16:32.618294	\N
305946	2854	328	2014-12-07 16:16:32.62782	\N
305947	2855	317	2014-12-07 16:16:32.638306	\N
305948	2856	332	2014-12-07 16:16:32.648334	\N
305949	2857	331	2014-12-07 16:16:32.701985	\N
305950	2858	321	2014-12-07 16:16:32.712191	\N
305951	2859	332	2014-12-07 16:16:32.758507	\N
305952	2860	332	2014-12-07 16:16:32.769535	\N
305953	2861	332	2014-12-07 16:16:32.779955	\N
305954	2862	321	2014-12-07 16:16:32.789869	\N
305955	2863	321	2014-12-07 16:16:32.799501	\N
305956	2864	321	2014-12-07 16:16:32.809568	\N
305957	2865	323	2014-12-07 16:16:32.819896	\N
305958	2866	321	2014-12-07 16:16:32.830445	\N
305959	2867	305	2014-12-07 16:16:32.842822	\N
305960	2868	306	2014-12-07 16:16:32.855841	\N
305961	2869	307	2014-12-07 16:16:32.866668	\N
305962	2870	308	2014-12-07 16:16:32.877887	\N
305963	2871	311	2014-12-07 16:16:32.892312	\N
305964	2872	312	2014-12-07 16:16:32.904083	\N
305965	2873	313	2014-12-07 16:16:32.915025	\N
305966	2874	313	2014-12-07 16:16:32.925205	\N
305967	2875	317	2014-12-07 16:16:32.936526	\N
305968	2876	319	2014-12-07 16:16:32.947575	\N
305969	2877	321	2014-12-07 16:16:32.957756	\N
305970	2878	327	2014-12-07 16:16:32.968762	\N
305971	2879	328	2014-12-07 16:16:32.97961	\N
305972	2880	328	2014-12-07 16:16:32.99042	\N
305973	2881	330	2014-12-07 16:16:33.001211	\N
305974	2882	331	2014-12-07 16:16:33.011129	\N
305975	2883	331	2014-12-07 16:16:33.021683	\N
305976	2884	331	2014-12-07 16:16:33.032369	\N
305977	2885	331	2014-12-07 16:16:33.042456	\N
305978	2886	333	2014-12-07 16:16:33.053646	\N
305979	2887	319	2014-12-07 16:16:33.158056	\N
305980	2888	321	2014-12-07 16:16:33.168564	\N
305981	2889	321	2014-12-07 16:16:33.179611	\N
305982	2890	321	2014-12-07 16:16:33.217613	\N
305983	2891	321	2014-12-07 16:16:33.227607	\N
305984	2892	325	2014-12-07 16:16:33.2387	\N
305985	2893	331	2014-12-07 16:16:33.248961	\N
305986	2894	331	2014-12-07 16:16:33.258908	\N
305987	2895	331	2014-12-07 16:16:33.27	\N
305988	2896	331	2014-12-07 16:16:33.280333	\N
305989	2897	331	2014-12-07 16:16:33.290754	\N
305990	2898	331	2014-12-07 16:16:33.301663	\N
305991	2899	331	2014-12-07 16:16:33.311996	\N
305992	2900	331	2014-12-07 16:16:33.322334	\N
305993	2901	331	2014-12-07 16:16:33.333202	\N
305994	2902	331	2014-12-07 16:16:33.343547	\N
305995	2903	321	2014-12-07 16:16:33.428745	\N
305996	2904	331	2014-12-07 16:16:33.44515	\N
305997	2905	336	2014-12-07 16:16:33.457039	\N
305998	2906	336	2014-12-07 16:16:33.46864	\N
305999	2907	336	2014-12-07 16:16:33.481117	\N
306000	2908	336	2014-12-07 16:16:33.491192	\N
306001	2909	320	2014-12-07 16:16:33.597234	\N
306002	2910	328	2014-12-07 16:16:33.608056	\N
306003	2911	329	2014-12-07 16:16:33.618489	\N
306004	2912	327	2014-12-07 16:16:33.629311	\N
306005	2913	332	2014-12-07 16:16:33.640364	\N
306006	2914	304	2014-12-07 16:16:33.703956	\N
306007	2915	305	2014-12-07 16:16:33.715407	\N
306008	2916	306	2014-12-07 16:16:33.72613	\N
306009	2917	306	2014-12-07 16:16:33.736599	\N
306010	2918	306	2014-12-07 16:16:33.749047	\N
306011	2919	307	2014-12-07 16:16:33.7605	\N
306012	2920	307	2014-12-07 16:16:33.773786	\N
306013	2921	307	2014-12-07 16:16:33.78478	\N
306014	2922	309	2014-12-07 16:16:33.795597	\N
306015	2923	310	2014-12-07 16:16:33.807048	\N
306016	2924	312	2014-12-07 16:16:33.817859	\N
306017	2925	312	2014-12-07 16:16:33.82862	\N
306018	2926	313	2014-12-07 16:16:33.840019	\N
306019	2927	314	2014-12-07 16:16:33.850724	\N
306020	2928	314	2014-12-07 16:16:33.861767	\N
306021	2929	315	2014-12-07 16:16:33.872839	\N
306022	2930	315	2014-12-07 16:16:33.883776	\N
306023	2931	316	2014-12-07 16:16:33.895137	\N
306024	2932	316	2014-12-07 16:16:33.906072	\N
306025	2933	318	2014-12-07 16:16:33.916781	\N
306026	2934	320	2014-12-07 16:16:33.931428	\N
306027	2935	320	2014-12-07 16:16:33.942894	\N
306028	2936	322	2014-12-07 16:16:33.954277	\N
306029	2937	323	2014-12-07 16:16:33.970894	\N
306030	2938	323	2014-12-07 16:16:33.982736	\N
306031	2939	324	2014-12-07 16:16:33.994153	\N
306032	2940	326	2014-12-07 16:16:34.004633	\N
306033	2941	326	2014-12-07 16:16:34.015626	\N
306034	2942	329	2014-12-07 16:16:34.026405	\N
306035	2943	329	2014-12-07 16:16:34.036746	\N
306036	2944	329	2014-12-07 16:16:34.048249	\N
306037	2945	330	2014-12-07 16:16:34.059021	\N
306038	2946	336	2014-12-07 16:16:34.183839	\N
306039	2947	336	2014-12-07 16:16:34.194978	\N
306040	2948	323	2014-12-07 16:16:34.256084	\N
306041	2949	321	2014-12-07 16:16:34.267317	\N
306042	2950	332	2014-12-07 16:16:34.278159	\N
306043	2951	316	2014-12-07 16:16:34.289803	\N
306044	2952	312	2014-12-07 16:16:34.300653	\N
306045	2953	334	2014-12-07 16:16:34.311539	\N
306046	2954	316	2014-12-07 16:16:34.322868	\N
306047	2955	330	2014-12-07 16:16:34.333647	\N
306048	2956	314	2014-12-07 16:16:34.344932	\N
306049	2957	328	2014-12-07 16:16:34.35714	\N
306050	2958	335	2014-12-07 16:16:34.368657	\N
306051	2959	306	2014-12-07 16:16:34.380529	\N
306052	2960	307	2014-12-07 16:16:34.391965	\N
306053	2961	326	2014-12-07 16:16:34.403466	\N
306054	2962	318	2014-12-07 16:16:34.414754	\N
306055	2963	310	2014-12-07 16:16:34.426238	\N
306056	2964	326	2014-12-07 16:16:34.439496	\N
306057	2965	305	2014-12-07 16:16:34.451666	\N
306058	2966	323	2014-12-07 16:16:34.46864	\N
306059	2967	319	2014-12-07 16:16:34.484955	\N
306060	2968	336	2014-12-07 16:16:34.497228	\N
306061	2969	304	2014-12-07 16:16:34.619306	\N
306062	2970	305	2014-12-07 16:16:34.630473	\N
306063	2971	305	2014-12-07 16:16:34.642009	\N
306064	2972	305	2014-12-07 16:16:34.653875	\N
306065	2973	305	2014-12-07 16:16:34.665202	\N
306066	2974	305	2014-12-07 16:16:34.677025	\N
306067	2975	305	2014-12-07 16:16:34.688316	\N
306068	2976	305	2014-12-07 16:16:34.699443	\N
306069	2977	305	2014-12-07 16:16:34.710547	\N
306070	2978	305	2014-12-07 16:16:34.721458	\N
306071	2979	305	2014-12-07 16:16:34.733079	\N
306072	2980	306	2014-12-07 16:16:34.744103	\N
306073	2981	306	2014-12-07 16:16:34.754681	\N
306074	2982	306	2014-12-07 16:16:34.766688	\N
306075	2983	306	2014-12-07 16:16:34.778406	\N
306076	2984	306	2014-12-07 16:16:34.791134	\N
306077	2985	306	2014-12-07 16:16:34.80265	\N
306078	2986	306	2014-12-07 16:16:34.815592	\N
306079	2987	306	2014-12-07 16:16:34.828816	\N
306080	2988	306	2014-12-07 16:16:34.840124	\N
306081	2989	306	2014-12-07 16:16:34.851501	\N
306082	2990	306	2014-12-07 16:16:34.86588	\N
306083	2991	306	2014-12-07 16:16:34.877309	\N
306084	2992	306	2014-12-07 16:16:34.889297	\N
306085	2993	306	2014-12-07 16:16:34.900547	\N
306086	2994	306	2014-12-07 16:16:34.912194	\N
306087	2995	306	2014-12-07 16:16:34.923172	\N
306088	2996	306	2014-12-07 16:16:34.934752	\N
306089	2997	306	2014-12-07 16:16:34.946497	\N
306090	2998	306	2014-12-07 16:16:34.958045	\N
306091	2999	306	2014-12-07 16:16:34.96954	\N
306092	3000	307	2014-12-07 16:16:34.980941	\N
306093	3001	307	2014-12-07 16:16:34.99248	\N
306094	3002	307	2014-12-07 16:16:35.003764	\N
306095	3003	307	2014-12-07 16:16:35.014977	\N
306096	3004	307	2014-12-07 16:16:35.026271	\N
306097	3005	307	2014-12-07 16:16:35.038647	\N
306098	3006	307	2014-12-07 16:16:35.049803	\N
306099	3007	307	2014-12-07 16:16:35.061778	\N
306100	3008	307	2014-12-07 16:16:35.073513	\N
306101	3009	307	2014-12-07 16:16:35.084172	\N
306102	3010	307	2014-12-07 16:16:35.096148	\N
306103	3011	307	2014-12-07 16:16:35.107785	\N
306104	3012	307	2014-12-07 16:16:35.119239	\N
306105	3013	307	2014-12-07 16:16:35.130783	\N
306106	3014	307	2014-12-07 16:16:35.142474	\N
306107	3015	307	2014-12-07 16:16:35.154672	\N
306108	3016	307	2014-12-07 16:16:35.166417	\N
306109	3017	307	2014-12-07 16:16:35.177897	\N
306110	3018	307	2014-12-07 16:16:35.189938	\N
306111	3019	307	2014-12-07 16:16:35.201401	\N
306112	3020	307	2014-12-07 16:16:35.21308	\N
306113	3021	307	2014-12-07 16:16:35.224424	\N
306114	3022	307	2014-12-07 16:16:35.235986	\N
306115	3023	307	2014-12-07 16:16:35.24827	\N
306116	3024	308	2014-12-07 16:16:35.259527	\N
306117	3025	308	2014-12-07 16:16:35.27075	\N
306118	3026	308	2014-12-07 16:16:35.282609	\N
306119	3027	309	2014-12-07 16:16:35.294498	\N
306120	3028	309	2014-12-07 16:16:35.307305	\N
306121	3029	309	2014-12-07 16:16:35.321326	\N
306122	3030	309	2014-12-07 16:16:35.335952	\N
306123	3031	309	2014-12-07 16:16:35.349141	\N
306124	3032	310	2014-12-07 16:16:35.365283	\N
306125	3033	310	2014-12-07 16:16:35.379067	\N
306126	3034	310	2014-12-07 16:16:35.393911	\N
306127	3035	310	2014-12-07 16:16:35.405799	\N
306128	3036	337	2014-12-07 16:16:35.423045	\N
306129	3037	337	2014-12-07 16:16:35.43464	\N
306130	3038	337	2014-12-07 16:16:35.44664	\N
306131	3039	337	2014-12-07 16:16:35.459716	\N
306132	3040	337	2014-12-07 16:16:35.47179	\N
306133	3041	337	2014-12-07 16:16:35.483892	\N
306134	3042	337	2014-12-07 16:16:35.495513	\N
306135	3043	337	2014-12-07 16:16:35.507104	\N
306136	3044	337	2014-12-07 16:16:35.519836	\N
306137	3045	337	2014-12-07 16:16:35.53156	\N
306138	3046	337	2014-12-07 16:16:35.544516	\N
306139	3047	337	2014-12-07 16:16:35.557727	\N
306140	3048	337	2014-12-07 16:16:35.57139	\N
306141	3049	337	2014-12-07 16:16:35.583515	\N
306142	3050	337	2014-12-07 16:16:35.599114	\N
306143	3051	337	2014-12-07 16:16:35.611825	\N
306144	3052	337	2014-12-07 16:16:35.623335	\N
306145	3053	337	2014-12-07 16:16:35.635605	\N
306146	3054	337	2014-12-07 16:16:35.647646	\N
306147	3055	337	2014-12-07 16:16:35.659664	\N
306148	3056	337	2014-12-07 16:16:35.673076	\N
306149	3057	337	2014-12-07 16:16:35.684608	\N
306150	3058	337	2014-12-07 16:16:35.69694	\N
306151	3059	337	2014-12-07 16:16:35.709157	\N
306152	3060	337	2014-12-07 16:16:35.72115	\N
306153	3061	337	2014-12-07 16:16:35.733907	\N
306154	3062	337	2014-12-07 16:16:35.74703	\N
306155	3063	337	2014-12-07 16:16:35.763141	\N
306156	3064	337	2014-12-07 16:16:35.779254	\N
306157	3065	337	2014-12-07 16:16:35.794576	\N
306158	3066	337	2014-12-07 16:16:35.807125	\N
306159	3067	337	2014-12-07 16:16:35.819356	\N
306160	3068	337	2014-12-07 16:16:35.831241	\N
306161	3069	337	2014-12-07 16:16:35.843928	\N
306162	3070	337	2014-12-07 16:16:35.856784	\N
306163	3071	311	2014-12-07 16:16:35.869308	\N
306164	3072	311	2014-12-07 16:16:35.884971	\N
306165	3073	311	2014-12-07 16:16:35.897256	\N
306166	3074	312	2014-12-07 16:16:35.910427	\N
306167	3075	312	2014-12-07 16:16:35.923364	\N
306168	3076	312	2014-12-07 16:16:35.936185	\N
306169	3077	312	2014-12-07 16:16:35.948949	\N
306170	3078	312	2014-12-07 16:16:35.961573	\N
306171	3079	312	2014-12-07 16:16:35.974868	\N
306172	3080	313	2014-12-07 16:16:35.987177	\N
306173	3081	314	2014-12-07 16:16:36.000943	\N
306174	3082	314	2014-12-07 16:16:36.014382	\N
306175	3083	314	2014-12-07 16:16:36.028394	\N
306176	3084	314	2014-12-07 16:16:36.041848	\N
306177	3085	314	2014-12-07 16:16:36.058808	\N
306178	3086	314	2014-12-07 16:16:36.072313	\N
306179	3087	314	2014-12-07 16:16:36.087159	\N
306180	3088	314	2014-12-07 16:16:36.104108	\N
306181	3089	314	2014-12-07 16:16:36.122211	\N
306182	3090	314	2014-12-07 16:16:36.135768	\N
306183	3091	315	2014-12-07 16:16:36.149515	\N
306184	3092	315	2014-12-07 16:16:36.163665	\N
306185	3093	315	2014-12-07 16:16:36.177402	\N
306186	3094	315	2014-12-07 16:16:36.193465	\N
306187	3095	315	2014-12-07 16:16:36.206712	\N
306188	3096	315	2014-12-07 16:16:36.219594	\N
306189	3097	315	2014-12-07 16:16:36.232466	\N
306190	3098	337	2014-12-07 16:16:36.24556	\N
306191	3099	337	2014-12-07 16:16:36.258454	\N
306192	3100	316	2014-12-07 16:16:36.272087	\N
306193	3101	316	2014-12-07 16:16:36.285044	\N
306194	3102	316	2014-12-07 16:16:36.297967	\N
306195	3103	316	2014-12-07 16:16:36.31129	\N
306196	3104	316	2014-12-07 16:16:36.325018	\N
306197	3105	316	2014-12-07 16:16:36.338298	\N
306198	3106	316	2014-12-07 16:16:36.353095	\N
306199	3107	316	2014-12-07 16:16:36.367479	\N
306200	3108	316	2014-12-07 16:16:36.383343	\N
306201	3109	317	2014-12-07 16:16:36.395878	\N
306202	3110	317	2014-12-07 16:16:36.407755	\N
306203	3111	317	2014-12-07 16:16:36.420575	\N
306204	3112	318	2014-12-07 16:16:36.433365	\N
306205	3113	318	2014-12-07 16:16:36.44634	\N
306206	3114	318	2014-12-07 16:16:36.460472	\N
306207	3115	318	2014-12-07 16:16:36.475103	\N
306208	3116	318	2014-12-07 16:16:36.487808	\N
306209	3117	318	2014-12-07 16:16:36.500751	\N
306210	3118	318	2014-12-07 16:16:36.514907	\N
306211	3119	318	2014-12-07 16:16:36.528595	\N
306212	3120	318	2014-12-07 16:16:36.545764	\N
306213	3121	318	2014-12-07 16:16:36.559806	\N
306214	3122	318	2014-12-07 16:16:36.573302	\N
306215	3123	320	2014-12-07 16:16:36.58561	\N
306216	3124	320	2014-12-07 16:16:36.59843	\N
306217	3125	320	2014-12-07 16:16:36.611376	\N
306218	3126	320	2014-12-07 16:16:36.625139	\N
306219	3127	320	2014-12-07 16:16:36.638335	\N
306220	3128	320	2014-12-07 16:16:36.651993	\N
306221	3129	320	2014-12-07 16:16:36.66617	\N
306222	3130	320	2014-12-07 16:16:36.679147	\N
306223	3131	320	2014-12-07 16:16:36.692868	\N
306224	3132	320	2014-12-07 16:16:36.706364	\N
306225	3133	320	2014-12-07 16:16:36.71968	\N
306226	3134	320	2014-12-07 16:16:36.73254	\N
306227	3135	320	2014-12-07 16:16:36.746465	\N
306228	3136	320	2014-12-07 16:16:36.760475	\N
306229	3137	320	2014-12-07 16:16:36.776627	\N
306230	3138	320	2014-12-07 16:16:36.789592	\N
306231	3139	321	2014-12-07 16:16:36.803705	\N
306232	3140	322	2014-12-07 16:16:36.816791	\N
306233	3141	322	2014-12-07 16:16:36.829972	\N
306234	3142	322	2014-12-07 16:16:36.844292	\N
306235	3143	323	2014-12-07 16:16:36.857942	\N
306236	3144	323	2014-12-07 16:16:36.87351	\N
306237	3145	323	2014-12-07 16:16:36.886802	\N
306238	3146	323	2014-12-07 16:16:36.900797	\N
306239	3147	323	2014-12-07 16:16:36.914287	\N
306240	3148	323	2014-12-07 16:16:36.928755	\N
306241	3149	323	2014-12-07 16:16:36.941987	\N
306242	3150	323	2014-12-07 16:16:36.956123	\N
306243	3151	324	2014-12-07 16:16:36.969959	\N
306244	3152	324	2014-12-07 16:16:36.983671	\N
306245	3153	324	2014-12-07 16:16:36.997528	\N
306246	3154	324	2014-12-07 16:16:37.011514	\N
306247	3155	326	2014-12-07 16:16:37.025162	\N
306248	3156	324	2014-12-07 16:16:37.039518	\N
306249	3157	325	2014-12-07 16:16:37.056303	\N
306250	3158	326	2014-12-07 16:16:37.071649	\N
306251	3159	326	2014-12-07 16:16:37.089895	\N
306252	3160	326	2014-12-07 16:16:37.107137	\N
306253	3161	326	2014-12-07 16:16:37.12232	\N
306254	3162	326	2014-12-07 16:16:37.139919	\N
306255	3163	326	2014-12-07 16:16:37.154263	\N
306256	3164	326	2014-12-07 16:16:37.16988	\N
306257	3165	326	2014-12-07 16:16:37.185018	\N
306258	3166	326	2014-12-07 16:16:37.199827	\N
306259	3167	326	2014-12-07 16:16:37.215083	\N
306260	3168	326	2014-12-07 16:16:37.22967	\N
306261	3169	326	2014-12-07 16:16:37.24671	\N
306262	3170	328	2014-12-07 16:16:37.26469	\N
306263	3171	329	2014-12-07 16:16:37.279768	\N
306264	3172	329	2014-12-07 16:16:37.298214	\N
306265	3173	329	2014-12-07 16:16:37.312916	\N
306266	3174	329	2014-12-07 16:16:37.33097	\N
306267	3175	329	2014-12-07 16:16:37.345785	\N
306268	3176	329	2014-12-07 16:16:37.365209	\N
306269	3177	329	2014-12-07 16:16:37.379538	\N
306270	3178	329	2014-12-07 16:16:37.397608	\N
306271	3179	329	2014-12-07 16:16:37.411319	\N
306272	3180	329	2014-12-07 16:16:37.432444	\N
306273	3180	329	2014-12-07 16:16:37.435298	\N
306274	3181	329	2014-12-07 16:16:37.451429	\N
306275	3182	329	2014-12-07 16:16:37.469997	\N
306276	3183	329	2014-12-07 16:16:37.488906	\N
306277	3184	329	2014-12-07 16:16:37.503541	\N
306278	3185	329	2014-12-07 16:16:37.520819	\N
306279	3186	329	2014-12-07 16:16:37.535228	\N
306280	3187	329	2014-12-07 16:16:37.548217	\N
306281	3188	329	2014-12-07 16:16:37.562097	\N
306282	3189	329	2014-12-07 16:16:37.575273	\N
306283	3190	329	2014-12-07 16:16:37.589526	\N
306284	3191	330	2014-12-07 16:16:37.603865	\N
306285	3192	330	2014-12-07 16:16:37.618107	\N
306286	3193	330	2014-12-07 16:16:37.632725	\N
306287	3194	330	2014-12-07 16:16:37.64861	\N
306288	3195	330	2014-12-07 16:16:37.697458	\N
306289	3196	330	2014-12-07 16:16:37.711245	\N
306290	3197	330	2014-12-07 16:16:37.724753	\N
306291	3198	330	2014-12-07 16:16:37.738963	\N
306292	3199	330	2014-12-07 16:16:37.753127	\N
306293	3200	335	2014-12-07 16:16:37.767794	\N
306294	3201	335	2014-12-07 16:16:37.781377	\N
306295	3202	335	2014-12-07 16:16:37.794242	\N
306296	3203	335	2014-12-07 16:16:37.808826	\N
306297	3204	331	2014-12-07 16:16:37.824227	\N
306298	3205	331	2014-12-07 16:16:37.840482	\N
306299	3206	331	2014-12-07 16:16:37.854281	\N
306300	3207	331	2014-12-07 16:16:37.869123	\N
306301	3208	334	2014-12-07 16:16:37.882081	\N
306302	3209	331	2014-12-07 16:16:37.895198	\N
306303	3210	304	2014-12-07 16:16:37.908676	\N
306304	3211	322	2014-12-07 16:16:37.92259	\N
306305	3212	334	2014-12-07 16:16:37.936157	\N
306306	3213	314	2014-12-07 16:16:37.950606	\N
306307	3214	336	2014-12-07 16:16:37.964515	\N
306308	3215	330	2014-12-07 16:16:38.632201	\N
306309	3216	311	2014-12-07 16:16:38.648905	\N
306310	3217	316	2014-12-07 16:16:38.664971	\N
306311	3218	315	2014-12-07 16:16:38.68047	\N
306312	3219	326	2014-12-07 16:16:38.697229	\N
306313	3220	306	2014-12-07 16:16:38.71606	\N
306314	3221	314	2014-12-07 16:16:38.730014	\N
306315	3222	320	2014-12-07 16:16:38.745024	\N
306316	3223	312	2014-12-07 16:16:38.758648	\N
306317	3224	326	2014-12-07 16:16:38.773962	\N
306318	3225	312	2014-12-07 16:16:38.787715	\N
306319	3226	329	2014-12-07 16:16:38.802778	\N
306320	3227	320	2014-12-07 16:16:38.816546	\N
306321	3228	307	2014-12-07 16:16:38.831026	\N
306322	3229	328	2014-12-07 16:16:38.845055	\N
306323	3230	306	2014-12-07 16:16:38.85871	\N
306324	3231	306	2014-12-07 16:16:38.873449	\N
306325	3232	320	2014-12-07 16:16:38.889111	\N
306326	3233	320	2014-12-07 16:16:38.905811	\N
306327	3234	320	2014-12-07 16:16:38.921773	\N
306328	3235	320	2014-12-07 16:16:38.938129	\N
306329	3236	310	2014-12-07 16:16:38.955411	\N
306330	3237	320	2014-12-07 16:16:38.971335	\N
306331	3238	306	2014-12-07 16:16:38.98701	\N
306332	3239	306	2014-12-07 16:16:39.004132	\N
306333	3240	306	2014-12-07 16:16:39.018518	\N
306334	3241	308	2014-12-07 16:16:39.033021	\N
306335	3242	306	2014-12-07 16:16:39.046464	\N
306336	3243	330	2014-12-07 16:16:39.06233	\N
306337	3244	320	2014-12-07 16:16:39.078555	\N
306338	3245	307	2014-12-07 16:16:39.092519	\N
306339	3246	311	2014-12-07 16:16:39.106101	\N
306340	3247	305	2014-12-07 16:16:39.120382	\N
306341	3248	305	2014-12-07 16:16:39.134946	\N
306342	3249	306	2014-12-07 16:16:39.149098	\N
306343	3250	306	2014-12-07 16:16:39.163842	\N
306344	3251	306	2014-12-07 16:16:39.177721	\N
306345	3252	309	2014-12-07 16:16:39.193616	\N
306346	3253	309	2014-12-07 16:16:39.210146	\N
306347	3254	309	2014-12-07 16:16:39.225942	\N
306348	3255	309	2014-12-07 16:16:39.24371	\N
306349	3256	307	2014-12-07 16:16:39.264101	\N
306350	3257	307	2014-12-07 16:16:39.284676	\N
306351	3258	307	2014-12-07 16:16:39.303752	\N
306352	3259	307	2014-12-07 16:16:39.324568	\N
306353	3260	316	2014-12-07 16:16:39.343128	\N
306354	3261	310	2014-12-07 16:16:39.363579	\N
306355	3262	312	2014-12-07 16:16:39.380184	\N
306356	3263	307	2014-12-07 16:16:39.396591	\N
306357	3264	307	2014-12-07 16:16:39.413185	\N
306358	3265	307	2014-12-07 16:16:39.429409	\N
306359	3266	307	2014-12-07 16:16:39.445599	\N
306360	3267	307	2014-12-07 16:16:39.473103	\N
306361	3268	307	2014-12-07 16:16:39.492573	\N
306362	3269	315	2014-12-07 16:16:39.510729	\N
306363	3270	317	2014-12-07 16:16:39.529945	\N
306364	3271	317	2014-12-07 16:16:39.549426	\N
306365	3272	320	2014-12-07 16:16:39.568917	\N
306366	3273	320	2014-12-07 16:16:39.600235	\N
306367	3274	322	2014-12-07 16:16:39.619881	\N
306368	3275	309	2014-12-07 16:16:39.633428	\N
306369	3276	335	2014-12-07 16:16:39.648497	\N
306370	3277	318	2014-12-07 16:16:39.662779	\N
306371	3278	318	2014-12-07 16:16:39.67833	\N
306372	3279	313	2014-12-07 16:16:39.692358	\N
306373	3280	313	2014-12-07 16:16:39.707248	\N
306374	3281	313	2014-12-07 16:16:39.72161	\N
306375	3282	336	2014-12-07 16:16:39.737399	\N
306376	3283	336	2014-12-07 16:16:40.004855	\N
306377	3284	312	2014-12-07 16:16:40.103335	\N
306378	3285	315	2014-12-07 16:16:40.12131	\N
306379	3286	319	2014-12-07 16:16:40.138806	\N
306380	3287	320	2014-12-07 16:16:40.154199	\N
306381	3288	320	2014-12-07 16:16:40.168599	\N
306382	3289	323	2014-12-07 16:16:40.185715	\N
306383	3290	330	2014-12-07 16:16:40.200315	\N
306384	3291	314	2014-12-07 16:16:40.215522	\N
306385	3292	305	2014-12-07 16:16:40.230035	\N
306386	3293	306	2014-12-07 16:16:40.245277	\N
306387	3294	334	2014-12-07 16:16:40.260371	\N
306388	3295	309	2014-12-07 16:16:40.275495	\N
306389	3296	327	2014-12-07 16:16:40.29128	\N
306390	3297	329	2014-12-07 16:16:40.306479	\N
306391	3298	332	2014-12-07 16:16:40.321176	\N
306392	3299	304	2014-12-07 16:16:40.336505	\N
306393	3300	307	2014-12-07 16:16:40.351313	\N
306394	3301	308	2014-12-07 16:16:40.366953	\N
306395	3302	310	2014-12-07 16:16:40.382938	\N
306396	3303	311	2014-12-07 16:16:40.398596	\N
306397	3304	313	2014-12-07 16:16:40.414752	\N
306398	3305	316	2014-12-07 16:16:40.432794	\N
306399	3306	317	2014-12-07 16:16:40.451066	\N
306400	3307	318	2014-12-07 16:16:40.467647	\N
306401	3308	321	2014-12-07 16:16:40.486361	\N
306402	3309	322	2014-12-07 16:16:40.503366	\N
306403	3310	324	2014-12-07 16:16:40.522162	\N
306404	3311	325	2014-12-07 16:16:40.537587	\N
306405	3312	326	2014-12-07 16:16:40.555065	\N
306406	3313	335	2014-12-07 16:16:40.573985	\N
306407	3314	331	2014-12-07 16:16:40.591355	\N
306408	3315	333	2014-12-07 16:16:40.606877	\N
306409	3316	326	2014-12-07 16:16:40.621728	\N
306410	3317	307	2014-12-07 16:16:40.639281	\N
306411	3317	328	2014-12-07 16:16:40.641845	\N
306412	3318	311	2014-12-07 16:16:40.658099	\N
306413	3318	329	2014-12-07 16:16:40.660644	\N
306414	3319	331	2014-12-07 16:16:40.675452	\N
306415	3320	336	2014-12-07 16:16:40.852093	\N
306416	3321	312	2014-12-07 16:16:40.947388	\N
306417	3322	322	2014-12-07 16:16:40.964288	\N
306418	3323	323	2014-12-07 16:16:40.982166	\N
306419	3324	311	2014-12-07 16:16:41.075591	\N
306420	3325	310	2014-12-07 16:16:41.094015	\N
306421	3326	317	2014-12-07 16:16:41.11241	\N
306422	3327	335	2014-12-07 16:16:41.127373	\N
306423	3328	321	2014-12-07 16:16:41.143947	\N
306424	3329	320	2014-12-07 16:16:41.159637	\N
306425	3330	321	2014-12-07 16:16:41.17543	\N
306426	3331	305	2014-12-07 16:16:41.189598	\N
306427	3332	320	2014-12-07 16:16:41.205466	\N
306428	3333	331	2014-12-07 16:16:41.219975	\N
306429	3334	326	2014-12-07 16:16:41.23589	\N
306430	3335	308	2014-12-07 16:16:41.251136	\N
306431	3336	316	2014-12-07 16:16:41.266768	\N
306432	3337	318	2014-12-07 16:16:41.282136	\N
306433	3338	319	2014-12-07 16:16:41.297544	\N
306434	3339	330	2014-12-07 16:16:41.312691	\N
306435	3340	332	2014-12-07 16:16:41.328214	\N
306436	3341	336	2014-12-07 16:16:41.343515	\N
306437	3342	325	2014-12-07 16:16:41.490407	\N
306438	3343	309	2014-12-07 16:16:41.511998	\N
306439	3344	320	2014-12-07 16:16:41.527531	\N
306440	3345	323	2014-12-07 16:16:41.543041	\N
306441	3346	314	2014-12-07 16:16:41.557631	\N
306442	3347	326	2014-12-07 16:16:41.573646	\N
306443	3348	330	2014-12-07 16:16:41.58859	\N
306444	3349	315	2014-12-07 16:16:41.60394	\N
306445	3350	307	2014-12-07 16:16:41.618669	\N
306446	3351	318	2014-12-07 16:16:41.633818	\N
306447	3352	330	2014-12-07 16:16:41.648555	\N
306448	3353	335	2014-12-07 16:16:41.664724	\N
306449	3354	330	2014-12-07 16:16:41.679644	\N
306450	3355	318	2014-12-07 16:16:41.694908	\N
306451	3356	326	2014-12-07 16:16:41.709447	\N
306452	3357	305	2014-12-07 16:16:41.724379	\N
306453	3358	311	2014-12-07 16:16:41.739232	\N
306454	3359	307	2014-12-07 16:16:41.754841	\N
306455	3360	307	2014-12-07 16:16:41.770613	\N
306456	3361	310	2014-12-07 16:16:41.786245	\N
306457	3362	319	2014-12-07 16:16:41.802087	\N
306458	3363	334	2014-12-07 16:16:41.817988	\N
306459	3364	307	2014-12-07 16:16:41.832857	\N
306460	3365	319	2014-12-07 16:16:41.848548	\N
306461	3366	312	2014-12-07 16:16:41.863953	\N
306462	3367	305	2014-12-07 16:16:41.880016	\N
306463	3368	314	2014-12-07 16:16:41.895826	\N
306464	3369	312	2014-12-07 16:16:41.913018	\N
306465	3370	307	2014-12-07 16:16:41.927313	\N
306466	3371	335	2014-12-07 16:16:41.943074	\N
306467	3372	307	2014-12-07 16:16:41.958028	\N
306468	3373	331	2014-12-07 16:16:41.972886	\N
306469	3374	308	2014-12-07 16:16:41.991531	\N
306470	3375	318	2014-12-07 16:16:42.006987	\N
306471	3376	323	2014-12-07 16:16:42.023474	\N
306472	3377	318	2014-12-07 16:16:42.038744	\N
306473	3378	312	2014-12-07 16:16:42.054186	\N
306474	3379	331	2014-12-07 16:16:42.070053	\N
306475	3380	307	2014-12-07 16:16:42.085322	\N
306476	3381	316	2014-12-07 16:16:42.100178	\N
306477	3382	332	2014-12-07 16:16:42.115451	\N
306478	3383	305	2014-12-07 16:16:42.13079	\N
306479	3384	324	2014-12-07 16:16:42.147042	\N
306480	3385	329	2014-12-07 16:16:42.162272	\N
306481	3386	329	2014-12-07 16:16:42.178094	\N
306482	3387	323	2014-12-07 16:16:42.192867	\N
306483	3388	317	2014-12-07 16:16:42.208336	\N
306484	3389	314	2014-12-07 16:16:42.223782	\N
306485	3390	329	2014-12-07 16:16:42.24002	\N
306486	3391	331	2014-12-07 16:16:42.255301	\N
306487	3392	316	2014-12-07 16:16:42.271268	\N
306488	3393	322	2014-12-07 16:16:42.286162	\N
306489	3394	312	2014-12-07 16:16:42.301491	\N
306490	3395	307	2014-12-07 16:16:42.316719	\N
306491	3396	306	2014-12-07 16:16:42.332578	\N
306492	3397	307	2014-12-07 16:16:42.348365	\N
306493	3398	307	2014-12-07 16:16:42.363955	\N
306494	3399	307	2014-12-07 16:16:42.380299	\N
306495	3400	313	2014-12-07 16:16:42.39533	\N
306496	3401	305	2014-12-07 16:16:42.410666	\N
306497	3402	329	2014-12-07 16:16:42.426276	\N
306498	3403	310	2014-12-07 16:16:42.441722	\N
306499	3404	304	2014-12-07 16:16:42.457729	\N
306500	3405	319	2014-12-07 16:16:42.475993	\N
306501	3406	333	2014-12-07 16:16:42.494469	\N
306502	3407	333	2014-12-07 16:16:42.730286	\N
306503	3408	306	2014-12-07 16:16:42.754049	\N
306504	3409	321	2014-12-07 16:16:42.774948	\N
306505	3410	321	2014-12-07 16:16:42.790462	\N
306506	3411	311	2014-12-07 16:16:42.806199	\N
306507	3412	326	2014-12-07 16:16:42.82165	\N
306508	3413	322	2014-12-07 16:16:42.837359	\N
306509	3414	330	2014-12-07 16:16:42.852633	\N
306510	3415	314	2014-12-07 16:16:42.868081	\N
306511	3416	333	2014-12-07 16:16:42.883437	\N
306512	3417	310	2014-12-07 16:16:42.900461	\N
306513	3418	316	2014-12-07 16:16:42.915878	\N
306514	3419	328	2014-12-07 16:16:42.93205	\N
306515	3420	318	2014-12-07 16:16:42.947423	\N
306516	3421	323	2014-12-07 16:16:42.966024	\N
306517	3422	324	2014-12-07 16:16:42.981966	\N
306518	3423	325	2014-12-07 16:16:42.99835	\N
306519	3424	331	2014-12-07 16:16:43.014342	\N
306520	3425	315	2014-12-07 16:16:43.029834	\N
306521	3426	305	2014-12-07 16:16:43.045052	\N
306522	3427	323	2014-12-07 16:16:43.060564	\N
306523	3428	317	2014-12-07 16:16:43.076773	\N
306524	3429	326	2014-12-07 16:16:43.09237	\N
306525	3430	328	2014-12-07 16:16:43.108222	\N
306526	3431	324	2014-12-07 16:16:43.123857	\N
306527	3432	319	2014-12-07 16:16:43.139647	\N
306528	3433	331	2014-12-07 16:16:43.155411	\N
306529	3434	320	2014-12-07 16:16:43.171468	\N
306530	3435	331	2014-12-07 16:16:43.18825	\N
306531	3436	306	2014-12-07 16:16:43.204554	\N
306532	3437	331	2014-12-07 16:16:43.236311	\N
306533	3438	319	2014-12-07 16:16:43.252471	\N
306534	3439	306	2014-12-07 16:16:43.267999	\N
306535	3440	329	2014-12-07 16:16:43.284393	\N
306536	3441	312	2014-12-07 16:16:43.299877	\N
306537	3442	314	2014-12-07 16:16:43.316369	\N
306538	3443	322	2014-12-07 16:16:43.332007	\N
306539	3444	307	2014-12-07 16:16:43.348363	\N
306540	3445	305	2014-12-07 16:16:43.363687	\N
306541	3446	313	2014-12-07 16:16:43.381714	\N
306542	3447	327	2014-12-07 16:16:43.397207	\N
306543	3448	332	2014-12-07 16:16:43.413667	\N
306544	3449	331	2014-12-07 16:16:43.430164	\N
306545	3450	315	2014-12-07 16:16:43.624555	\N
306546	3451	312	2014-12-07 16:16:43.646095	\N
306547	3452	309	2014-12-07 16:16:43.664787	\N
306548	3453	330	2014-12-07 16:16:43.681676	\N
306549	3454	322	2014-12-07 16:16:43.697394	\N
306550	3455	324	2014-12-07 16:16:43.713598	\N
306551	3456	333	2014-12-07 16:16:43.729637	\N
306552	3457	332	2014-12-07 16:16:43.745955	\N
306553	3458	305	2014-12-07 16:16:43.764159	\N
306554	3459	310	2014-12-07 16:16:43.78089	\N
306555	3460	307	2014-12-07 16:16:43.799577	\N
306556	3461	329	2014-12-07 16:16:43.815456	\N
306557	3462	310	2014-12-07 16:16:43.831621	\N
306558	3463	307	2014-12-07 16:16:43.846865	\N
306559	3464	315	2014-12-07 16:16:43.863422	\N
306560	3465	330	2014-12-07 16:16:43.879367	\N
306561	3466	330	2014-12-07 16:16:43.8964	\N
306562	3467	324	2014-12-07 16:16:43.917726	\N
306563	3468	326	2014-12-07 16:16:43.93663	\N
306564	3469	329	2014-12-07 16:16:43.953748	\N
306565	3470	330	2014-12-07 16:16:43.969456	\N
306566	3471	330	2014-12-07 16:16:43.985564	\N
306567	3472	333	2014-12-07 16:16:44.002587	\N
306568	3473	332	2014-12-07 16:16:44.018581	\N
306569	3474	305	2014-12-07 16:16:44.035212	\N
306570	3475	305	2014-12-07 16:16:44.051939	\N
306571	3476	305	2014-12-07 16:16:44.06825	\N
306572	3461	329	2014-12-07 16:16:44.081151	\N
306573	3477	306	2014-12-07 16:16:44.097074	\N
306574	3478	306	2014-12-07 16:16:44.113165	\N
306575	3479	329	2014-12-07 16:16:44.130136	\N
306576	3480	316	2014-12-07 16:16:44.146181	\N
306577	3481	307	2014-12-07 16:16:44.163603	\N
306578	3482	321	2014-12-07 16:16:44.332965	\N
306579	3483	305	2014-12-07 16:16:44.354431	\N
306580	3484	306	2014-12-07 16:16:44.371438	\N
306581	3485	311	2014-12-07 16:16:44.436045	\N
306582	3486	313	2014-12-07 16:16:44.45361	\N
306583	3487	317	2014-12-07 16:16:44.470561	\N
306584	3488	331	2014-12-07 16:16:44.488024	\N
306585	3489	322	2014-12-07 16:16:44.504028	\N
306586	3490	326	2014-12-07 16:16:44.520767	\N
306587	3491	329	2014-12-07 16:16:44.536792	\N
306588	3492	332	2014-12-07 16:16:44.55364	\N
306589	3493	330	2014-12-07 16:16:44.56957	\N
306590	3494	337	2014-12-07 16:16:44.586111	\N
306591	3495	337	2014-12-07 16:16:44.602639	\N
306592	3496	337	2014-12-07 16:16:44.618262	\N
306593	3497	337	2014-12-07 16:16:44.635498	\N
306594	3498	331	2014-12-07 16:16:44.771629	\N
306595	3499	331	2014-12-07 16:16:44.793391	\N
306596	3500	336	2014-12-07 16:16:44.810091	\N
306597	3501	336	2014-12-07 16:16:44.826245	\N
306598	3502	336	2014-12-07 16:16:44.842906	\N
306599	3503	320	2014-12-07 16:16:44.958251	\N
306600	3504	316	2014-12-07 16:16:44.983332	\N
306601	3505	310	2014-12-07 16:16:45.000507	\N
306602	3506	336	2014-12-07 16:16:45.115951	\N
306603	3507	336	2014-12-07 16:16:45.141518	\N
306604	3508	336	2014-12-07 16:16:45.253341	\N
306605	3509	336	2014-12-07 16:16:45.369537	\N
306606	3510	336	2014-12-07 16:16:45.49201	\N
306607	3511	336	2014-12-07 16:16:45.514088	\N
306608	3512	336	2014-12-07 16:16:45.636694	\N
306609	3513	316	2014-12-07 16:16:45.760557	\N
306610	3514	310	2014-12-07 16:16:45.784026	\N
306611	3515	323	2014-12-07 16:16:45.80298	\N
306612	3516	323	2014-12-07 16:16:45.819399	\N
306613	3517	305	2014-12-07 16:16:45.836249	\N
306614	3518	316	2014-12-07 16:16:45.852514	\N
306615	3519	306	2014-12-07 16:16:45.869128	\N
306616	3520	316	2014-12-07 16:16:45.885513	\N
306617	3521	323	2014-12-07 16:16:45.902589	\N
306618	3522	323	2014-12-07 16:16:45.919082	\N
306619	3523	326	2014-12-07 16:16:45.936741	\N
306620	3524	314	2014-12-07 16:16:45.956574	\N
306621	3525	314	2014-12-07 16:16:45.976647	\N
306622	3526	317	2014-12-07 16:16:45.994253	\N
306623	3527	329	2014-12-07 16:16:46.012536	\N
306624	3527	329	2014-12-07 16:16:46.015201	\N
306625	3528	312	2014-12-07 16:16:46.031388	\N
306626	3529	310	2014-12-07 16:16:46.047948	\N
306627	3530	306	2014-12-07 16:16:46.065261	\N
306628	3531	312	2014-12-07 16:16:46.082512	\N
306629	3532	328	2014-12-07 16:16:46.098494	\N
306630	3533	325	2014-12-07 16:16:46.115234	\N
306631	3534	317	2014-12-07 16:16:46.132471	\N
306632	3535	305	2014-12-07 16:16:46.148941	\N
306633	3536	314	2014-12-07 16:16:46.166056	\N
306634	3537	314	2014-12-07 16:16:46.182793	\N
306635	3538	305	2014-12-07 16:16:46.20407	\N
306636	3538	306	2014-12-07 16:16:46.206716	\N
306637	3539	305	2014-12-07 16:16:46.223967	\N
306638	3540	305	2014-12-07 16:16:46.240039	\N
306639	3541	319	2014-12-07 16:16:46.257527	\N
306640	3542	319	2014-12-07 16:16:46.273772	\N
306641	3543	329	2014-12-07 16:16:46.291098	\N
306642	3544	308	2014-12-07 16:16:46.307807	\N
306643	3545	324	2014-12-07 16:16:46.325485	\N
306644	3546	305	2014-12-07 16:16:46.342232	\N
306645	3547	314	2014-12-07 16:16:46.359207	\N
306646	3548	314	2014-12-07 16:16:46.376511	\N
306647	3549	305	2014-12-07 16:16:46.393371	\N
306648	3550	310	2014-12-07 16:16:46.410112	\N
306649	3551	316	2014-12-07 16:16:46.427032	\N
306650	3552	320	2014-12-07 16:16:46.444513	\N
306651	3553	310	2014-12-07 16:16:46.463589	\N
306652	3554	334	2014-12-07 16:16:46.480955	\N
306653	3555	306	2014-12-07 16:16:46.498027	\N
306654	3556	306	2014-12-07 16:16:46.514559	\N
306655	3557	305	2014-12-07 16:16:46.531639	\N
306656	3558	306	2014-12-07 16:16:46.547957	\N
306657	3559	313	2014-12-07 16:16:46.565175	\N
306658	3560	316	2014-12-07 16:16:46.582519	\N
306659	3561	328	2014-12-07 16:16:46.599814	\N
306660	3562	315	2014-12-07 16:16:46.61719	\N
306661	3563	306	2014-12-07 16:16:46.633917	\N
306662	3564	307	2014-12-07 16:16:46.650977	\N
306663	3565	329	2014-12-07 16:16:46.667713	\N
306664	3566	329	2014-12-07 16:16:46.685078	\N
306665	3567	329	2014-12-07 16:16:46.701731	\N
306666	3568	324	2014-12-07 16:16:46.718562	\N
306667	3569	309	2014-12-07 16:16:46.736362	\N
306668	3570	306	2014-12-07 16:16:46.75407	\N
306669	3571	334	2014-12-07 16:16:46.773081	\N
306670	3572	320	2014-12-07 16:16:46.791145	\N
306671	3573	321	2014-12-07 16:16:46.809814	\N
306672	3574	334	2014-12-07 16:16:46.827895	\N
306673	3575	329	2014-12-07 16:16:46.844968	\N
306674	3576	326	2014-12-07 16:16:46.862433	\N
306675	3577	316	2014-12-07 16:16:46.879299	\N
306676	3578	319	2014-12-07 16:16:46.897502	\N
306677	3579	319	2014-12-07 16:16:46.918138	\N
306678	3580	329	2014-12-07 16:16:46.935122	\N
306679	3581	326	2014-12-07 16:16:46.952382	\N
306680	3582	323	2014-12-07 16:16:46.96927	\N
306681	3583	313	2014-12-07 16:16:46.986883	\N
306682	3584	329	2014-12-07 16:16:47.004535	\N
306683	3585	324	2014-12-07 16:16:47.021421	\N
306684	3586	313	2014-12-07 16:16:47.03857	\N
306685	3587	305	2014-12-07 16:16:47.056207	\N
306686	3588	316	2014-12-07 16:16:47.073855	\N
306687	3589	308	2014-12-07 16:16:47.091606	\N
306688	3590	316	2014-12-07 16:16:47.109203	\N
306689	3591	320	2014-12-07 16:16:47.126732	\N
306690	3592	320	2014-12-07 16:16:47.143896	\N
306691	3593	312	2014-12-07 16:16:47.161641	\N
306692	3594	313	2014-12-07 16:16:47.178793	\N
306693	3595	313	2014-12-07 16:16:47.196704	\N
306694	3596	308	2014-12-07 16:16:47.214377	\N
306695	3597	313	2014-12-07 16:16:47.231539	\N
306696	3598	314	2014-12-07 16:16:47.249114	\N
306697	3599	320	2014-12-07 16:16:47.266126	\N
306698	3600	306	2014-12-07 16:16:47.283978	\N
306699	3601	326	2014-12-07 16:16:47.301672	\N
306700	3602	326	2014-12-07 16:16:47.318811	\N
306701	3603	326	2014-12-07 16:16:47.336697	\N
306702	3604	310	2014-12-07 16:16:47.35389	\N
306703	3605	310	2014-12-07 16:16:47.371615	\N
306704	3606	310	2014-12-07 16:16:47.388538	\N
306705	3607	310	2014-12-07 16:16:47.408502	\N
306706	3608	326	2014-12-07 16:16:47.426853	\N
306707	3609	326	2014-12-07 16:16:47.444173	\N
306708	3610	313	2014-12-07 16:16:47.462985	\N
306709	3611	313	2014-12-07 16:16:47.481764	\N
306710	3612	314	2014-12-07 16:16:47.550905	\N
306711	3613	323	2014-12-07 16:16:47.618025	\N
306712	3614	329	2014-12-07 16:16:47.639464	\N
306713	3615	312	2014-12-07 16:16:47.659255	\N
306714	3616	315	2014-12-07 16:16:47.682948	\N
306715	3617	315	2014-12-07 16:16:47.703519	\N
306716	3618	321	2014-12-07 16:16:47.724036	\N
306717	3619	321	2014-12-07 16:16:47.743597	\N
306718	3620	331	2014-12-07 16:16:47.763522	\N
306719	3621	317	2014-12-07 16:16:47.782377	\N
306720	3622	317	2014-12-07 16:16:47.799911	\N
306721	3623	317	2014-12-07 16:16:47.818646	\N
306722	3624	317	2014-12-07 16:16:47.836316	\N
306723	3625	317	2014-12-07 16:16:47.855028	\N
306724	3626	317	2014-12-07 16:16:47.873439	\N
306725	3627	317	2014-12-07 16:16:47.89145	\N
306726	3628	317	2014-12-07 16:16:47.909077	\N
306727	3629	317	2014-12-07 16:16:47.92673	\N
306728	3630	317	2014-12-07 16:16:47.945663	\N
306729	3631	317	2014-12-07 16:16:47.965095	\N
306730	3632	307	2014-12-07 16:16:47.997282	\N
306731	3633	305	2014-12-07 16:16:48.020563	\N
306732	3634	305	2014-12-07 16:16:48.041017	\N
306733	3635	305	2014-12-07 16:16:48.060778	\N
306734	3636	305	2014-12-07 16:16:48.081134	\N
306735	3637	305	2014-12-07 16:16:48.101	\N
306736	3638	324	2014-12-07 16:16:48.121772	\N
306737	3639	315	2014-12-07 16:16:48.142404	\N
306738	3640	315	2014-12-07 16:16:48.162559	\N
306739	3641	316	2014-12-07 16:16:48.184453	\N
306740	3642	316	2014-12-07 16:16:48.204634	\N
306741	3643	315	2014-12-07 16:16:48.224382	\N
306742	3644	327	2014-12-07 16:16:48.271662	\N
306743	3645	315	2014-12-07 16:16:48.292707	\N
306744	3646	313	2014-12-07 16:16:48.316764	\N
306745	3647	308	2014-12-07 16:16:48.338177	\N
306746	3648	330	2014-12-07 16:16:48.358598	\N
306747	3649	320	2014-12-07 16:16:48.377493	\N
306748	3650	304	2014-12-07 16:16:48.396976	\N
306749	3651	329	2014-12-07 16:16:48.41686	\N
306750	3652	326	2014-12-07 16:16:48.434618	\N
306751	3653	311	2014-12-07 16:16:48.453143	\N
306752	3654	314	2014-12-07 16:16:48.475453	\N
306753	3655	309	2014-12-07 16:16:48.494558	\N
306754	3656	329	2014-12-07 16:16:48.512957	\N
306755	3657	329	2014-12-07 16:16:48.530901	\N
306756	3658	329	2014-12-07 16:16:48.562295	\N
306757	3659	308	2014-12-07 16:16:48.588835	\N
306758	3660	334	2014-12-07 16:16:48.608113	\N
306759	3661	334	2014-12-07 16:16:48.628387	\N
306760	3662	315	2014-12-07 16:16:48.654858	\N
306761	3663	327	2014-12-07 16:16:48.676478	\N
306762	3664	331	2014-12-07 16:16:48.697306	\N
306763	3665	331	2014-12-07 16:16:48.716566	\N
306764	3666	307	2014-12-07 16:16:48.736928	\N
306765	3667	331	2014-12-07 16:16:48.758476	\N
306766	3668	331	2014-12-07 16:16:48.78226	\N
306767	3669	331	2014-12-07 16:16:48.803327	\N
306768	3670	331	2014-12-07 16:16:48.823806	\N
306769	3671	331	2014-12-07 16:16:48.844863	\N
306770	3672	331	2014-12-07 16:16:48.865567	\N
306771	3673	331	2014-12-07 16:16:48.88677	\N
306772	3674	331	2014-12-07 16:16:48.905797	\N
306773	3675	331	2014-12-07 16:16:48.926919	\N
306774	3676	331	2014-12-07 16:16:48.946271	\N
306775	3677	331	2014-12-07 16:16:48.965521	\N
306776	3678	331	2014-12-07 16:16:48.986112	\N
306777	3679	331	2014-12-07 16:16:49.004669	\N
306778	3680	331	2014-12-07 16:16:49.02509	\N
306779	3681	321	2014-12-07 16:16:49.043824	\N
306780	3682	331	2014-12-07 16:16:49.062458	\N
306781	3683	331	2014-12-07 16:16:49.08163	\N
306782	3684	331	2014-12-07 16:16:49.100489	\N
306783	3685	331	2014-12-07 16:16:49.119396	\N
306784	3686	331	2014-12-07 16:16:49.13961	\N
306785	3687	331	2014-12-07 16:16:49.161483	\N
306786	3688	331	2014-12-07 16:16:49.18155	\N
306787	3689	331	2014-12-07 16:16:49.201472	\N
306788	3690	331	2014-12-07 16:16:49.220495	\N
306789	3691	331	2014-12-07 16:16:49.240417	\N
306790	3692	331	2014-12-07 16:16:49.259723	\N
306791	3693	331	2014-12-07 16:16:49.278354	\N
306792	3694	331	2014-12-07 16:16:49.297604	\N
306793	3695	331	2014-12-07 16:16:49.317334	\N
306794	3696	331	2014-12-07 16:16:49.335197	\N
306795	3697	331	2014-12-07 16:16:49.354484	\N
306796	3698	331	2014-12-07 16:16:49.373963	\N
306797	3699	331	2014-12-07 16:16:49.392977	\N
306798	3700	331	2014-12-07 16:16:49.412115	\N
306799	3701	315	2014-12-07 16:16:49.436409	\N
306800	3702	314	2014-12-07 16:16:49.459574	\N
306801	3703	328	2014-12-07 16:16:49.481451	\N
306802	3704	317	2014-12-07 16:16:49.501307	\N
306803	3705	317	2014-12-07 16:16:49.520053	\N
306804	3706	317	2014-12-07 16:16:49.540915	\N
306805	3707	317	2014-12-07 16:16:49.560372	\N
306806	3708	317	2014-12-07 16:16:49.57949	\N
306807	3709	317	2014-12-07 16:16:49.599318	\N
306808	3710	317	2014-12-07 16:16:49.620524	\N
306809	3711	317	2014-12-07 16:16:49.640596	\N
306810	3712	317	2014-12-07 16:16:49.664674	\N
306811	3713	317	2014-12-07 16:16:49.684462	\N
306812	3714	317	2014-12-07 16:16:49.702715	\N
306813	3715	317	2014-12-07 16:16:49.721752	\N
306814	3716	317	2014-12-07 16:16:49.740869	\N
306815	3717	317	2014-12-07 16:16:49.764657	\N
306816	3718	317	2014-12-07 16:16:49.814818	\N
306817	3719	317	2014-12-07 16:16:49.834917	\N
306818	3720	317	2014-12-07 16:16:49.853129	\N
306819	3721	317	2014-12-07 16:16:49.873099	\N
306820	3722	317	2014-12-07 16:16:49.891653	\N
306821	3723	317	2014-12-07 16:16:49.910667	\N
306822	3724	317	2014-12-07 16:16:49.931268	\N
306823	3725	317	2014-12-07 16:16:49.952749	\N
306824	3726	317	2014-12-07 16:16:49.974429	\N
306825	3727	317	2014-12-07 16:16:49.995431	\N
306826	3728	317	2014-12-07 16:16:50.021242	\N
306827	3729	317	2014-12-07 16:16:50.04087	\N
306828	3730	317	2014-12-07 16:16:50.059771	\N
306829	3731	315	2014-12-07 16:16:50.081669	\N
306830	3732	315	2014-12-07 16:16:50.102413	\N
306831	3733	315	2014-12-07 16:16:50.127017	\N
306832	3734	316	2014-12-07 16:16:50.146472	\N
306833	3735	316	2014-12-07 16:16:50.166124	\N
306834	3736	311	2014-12-07 16:16:50.184829	\N
306835	3737	317	2014-12-07 16:16:50.20373	\N
306836	3738	317	2014-12-07 16:16:50.223604	\N
306837	3739	317	2014-12-07 16:16:50.242204	\N
306838	3740	334	2014-12-07 16:16:50.264819	\N
306839	3741	334	2014-12-07 16:16:50.288	\N
306840	3742	306	2014-12-07 16:16:50.306669	\N
306841	3743	320	2014-12-07 16:16:50.326149	\N
306842	3744	306	2014-12-07 16:16:50.345527	\N
306843	3745	306	2014-12-07 16:16:50.364398	\N
306844	3746	306	2014-12-07 16:16:50.387609	\N
306845	3747	306	2014-12-07 16:16:50.407	\N
306846	3748	306	2014-12-07 16:16:50.425662	\N
306847	3749	308	2014-12-07 16:16:50.445369	\N
306848	3750	308	2014-12-07 16:16:50.466772	\N
306849	3751	312	2014-12-07 16:16:50.49173	\N
306850	3752	332	2014-12-07 16:16:50.511377	\N
306851	3753	334	2014-12-07 16:16:50.530683	\N
306852	3754	314	2014-12-07 16:16:50.549783	\N
306853	3755	334	2014-12-07 16:16:50.568454	\N
306854	3756	317	2014-12-07 16:16:50.587927	\N
306855	3757	320	2014-12-07 16:16:50.606929	\N
306856	3758	320	2014-12-07 16:16:50.625634	\N
306857	3759	305	2014-12-07 16:16:50.645211	\N
306858	3760	334	2014-12-07 16:16:50.663834	\N
306859	3761	306	2014-12-07 16:16:50.683419	\N
306860	3762	320	2014-12-07 16:16:50.705696	\N
306861	3762	320	2014-12-07 16:16:50.708765	\N
306862	3762	320	2014-12-07 16:16:50.711102	\N
306863	3763	322	2014-12-07 16:16:50.730089	\N
306864	3764	320	2014-12-07 16:16:50.749135	\N
306865	3765	320	2014-12-07 16:16:50.769755	\N
306866	3766	307	2014-12-07 16:16:50.789361	\N
306867	3767	307	2014-12-07 16:16:50.808628	\N
306868	3768	307	2014-12-07 16:16:50.827833	\N
306869	3769	307	2014-12-07 16:16:50.848214	\N
306870	3769	307	2014-12-07 16:16:50.852489	\N
306871	3770	307	2014-12-07 16:16:50.871326	\N
306872	3771	307	2014-12-07 16:16:50.890829	\N
306873	3772	309	2014-12-07 16:16:50.910737	\N
306874	3773	307	2014-12-07 16:16:50.935277	\N
306875	3774	307	2014-12-07 16:16:50.958261	\N
306876	3774	307	2014-12-07 16:16:50.961015	\N
306877	3774	307	2014-12-07 16:16:50.963299	\N
306878	3775	307	2014-12-07 16:16:50.983187	\N
306879	3776	310	2014-12-07 16:16:51.005954	\N
306880	3777	337	2014-12-07 16:16:51.030829	\N
306881	3778	337	2014-12-07 16:16:51.050688	\N
306882	3779	337	2014-12-07 16:16:51.076207	\N
306883	3780	337	2014-12-07 16:16:51.101884	\N
306884	3781	337	2014-12-07 16:16:51.127947	\N
306885	3782	337	2014-12-07 16:16:51.177122	\N
306886	3783	337	2014-12-07 16:16:51.216467	\N
306887	3784	337	2014-12-07 16:16:51.285211	\N
306888	3785	337	2014-12-07 16:16:51.467569	\N
306889	3786	337	2014-12-07 16:16:51.495033	\N
306890	3787	337	2014-12-07 16:16:51.515673	\N
306891	3788	337	2014-12-07 16:16:51.534267	\N
306892	3789	326	2014-12-07 16:16:51.554061	\N
306893	3790	319	2014-12-07 16:16:51.57337	\N
306894	3791	314	2014-12-07 16:16:51.593667	\N
306895	3792	323	2014-12-07 16:16:51.613373	\N
306896	3793	337	2014-12-07 16:16:51.632884	\N
306897	3794	337	2014-12-07 16:16:51.652817	\N
306898	3795	317	2014-12-07 16:16:51.674122	\N
306899	3796	317	2014-12-07 16:16:51.694372	\N
306900	3797	317	2014-12-07 16:16:51.714786	\N
306901	3798	306	2014-12-07 16:16:51.735178	\N
306902	3799	307	2014-12-07 16:16:51.754584	\N
306903	3800	337	2014-12-07 16:16:51.776588	\N
306904	3801	307	2014-12-07 16:16:51.797075	\N
306905	3802	337	2014-12-07 16:16:51.817136	\N
306906	3803	318	2014-12-07 16:16:51.836378	\N
306907	3804	306	2014-12-07 16:16:51.857548	\N
306908	3805	304	2014-12-07 16:16:51.878738	\N
306909	3806	320	2014-12-07 16:16:51.897952	\N
306910	3807	329	2014-12-07 16:16:51.918542	\N
306911	3808	329	2014-12-07 16:16:51.938984	\N
306912	3809	329	2014-12-07 16:16:51.963425	\N
306913	3810	329	2014-12-07 16:16:51.986965	\N
306914	3811	329	2014-12-07 16:16:52.008865	\N
306915	3812	329	2014-12-07 16:16:52.03364	\N
306916	3813	325	2014-12-07 16:16:52.062813	\N
306917	3814	310	2014-12-07 16:16:52.094327	\N
306918	3815	337	2014-12-07 16:16:52.120169	\N
306919	3816	317	2014-12-07 16:16:52.144399	\N
306920	3817	317	2014-12-07 16:16:52.164788	\N
306921	3818	317	2014-12-07 16:16:52.188286	\N
306922	3819	317	2014-12-07 16:16:52.212501	\N
306923	3820	317	2014-12-07 16:16:52.233221	\N
306924	3821	317	2014-12-07 16:16:52.255818	\N
306925	3822	317	2014-12-07 16:16:52.282271	\N
306926	3823	317	2014-12-07 16:16:52.305477	\N
306927	3824	317	2014-12-07 16:16:52.325379	\N
306928	3825	314	2014-12-07 16:16:52.345544	\N
306929	3826	337	2014-12-07 16:16:52.366608	\N
306930	3827	337	2014-12-07 16:16:52.386053	\N
306931	3828	337	2014-12-07 16:16:52.406084	\N
306932	3829	337	2014-12-07 16:16:52.425774	\N
306933	3830	337	2014-12-07 16:16:52.445606	\N
306934	3831	337	2014-12-07 16:16:52.467006	\N
306935	3832	337	2014-12-07 16:16:52.488552	\N
306936	3833	337	2014-12-07 16:16:52.510301	\N
306937	3834	337	2014-12-07 16:16:52.531298	\N
306938	3835	337	2014-12-07 16:16:52.555589	\N
306939	3836	337	2014-12-07 16:16:52.576475	\N
306940	3837	337	2014-12-07 16:16:52.595621	\N
306941	3838	337	2014-12-07 16:16:52.618193	\N
306942	3839	337	2014-12-07 16:16:52.638436	\N
306943	3840	337	2014-12-07 16:16:52.657938	\N
306944	3841	337	2014-12-07 16:16:52.678824	\N
306945	3842	337	2014-12-07 16:16:52.699783	\N
306946	3843	337	2014-12-07 16:16:52.719477	\N
306947	3844	337	2014-12-07 16:16:52.738863	\N
306948	3845	337	2014-12-07 16:16:52.760433	\N
306949	3846	337	2014-12-07 16:16:52.781258	\N
306950	3847	337	2014-12-07 16:16:52.800935	\N
306951	3848	337	2014-12-07 16:16:52.821512	\N
306952	3849	337	2014-12-07 16:16:52.842791	\N
306953	3850	337	2014-12-07 16:16:52.863098	\N
306954	3851	337	2014-12-07 16:16:52.884129	\N
306955	3852	337	2014-12-07 16:16:52.905891	\N
306956	3853	337	2014-12-07 16:16:52.926793	\N
306957	3854	337	2014-12-07 16:16:52.952853	\N
306958	3855	337	2014-12-07 16:16:52.97341	\N
306959	3856	337	2014-12-07 16:16:52.994636	\N
306960	3857	337	2014-12-07 16:16:53.015165	\N
306961	3858	337	2014-12-07 16:16:53.036185	\N
306962	3859	337	2014-12-07 16:16:53.059618	\N
306963	3860	337	2014-12-07 16:16:53.080646	\N
306964	3861	337	2014-12-07 16:16:53.105823	\N
306965	3862	329	2014-12-07 16:16:54.11463	\N
306966	3863	308	2014-12-07 16:16:54.13568	\N
306967	3864	325	2014-12-07 16:16:54.155202	\N
306968	3865	324	2014-12-07 16:16:54.178169	\N
306969	3866	329	2014-12-07 16:16:54.199654	\N
306970	3867	329	2014-12-07 16:16:54.223443	\N
306971	3868	329	2014-12-07 16:16:54.244497	\N
306972	3869	329	2014-12-07 16:16:54.26416	\N
306973	3870	324	2014-12-07 16:16:54.284942	\N
306974	3871	308	2014-12-07 16:16:54.304981	\N
306975	3872	308	2014-12-07 16:16:54.325297	\N
306976	3873	326	2014-12-07 16:16:54.34702	\N
306977	3874	326	2014-12-07 16:16:54.368105	\N
306978	3875	329	2014-12-07 16:16:54.394917	\N
306979	3876	319	2014-12-07 16:16:54.416172	\N
306980	3877	319	2014-12-07 16:16:54.438073	\N
306981	3878	319	2014-12-07 16:16:54.45881	\N
306982	3879	312	2014-12-07 16:16:54.480899	\N
306983	3880	312	2014-12-07 16:16:54.501683	\N
306984	3881	335	2014-12-07 16:16:54.523844	\N
306985	3882	314	2014-12-07 16:16:54.547939	\N
306986	3883	314	2014-12-07 16:16:54.570376	\N
306987	3884	314	2014-12-07 16:16:54.591267	\N
306988	3885	320	2014-12-07 16:16:54.611173	\N
306989	3886	305	2014-12-07 16:16:54.631214	\N
306990	3887	305	2014-12-07 16:16:54.653658	\N
306991	3887	306	2014-12-07 16:16:54.656416	\N
306992	3888	305	2014-12-07 16:16:54.67697	\N
306993	3889	305	2014-12-07 16:16:54.697047	\N
306994	3890	317	2014-12-07 16:16:54.717408	\N
306995	3891	335	2014-12-07 16:16:54.738922	\N
306996	3892	314	2014-12-07 16:16:54.759813	\N
306997	3893	317	2014-12-07 16:16:54.780805	\N
306998	3894	306	2014-12-07 16:16:54.801599	\N
306999	3895	305	2014-12-07 16:16:54.825985	\N
307000	3895	306	2014-12-07 16:16:54.828614	\N
307001	3896	320	2014-12-07 16:16:54.851103	\N
307002	3897	317	2014-12-07 16:16:54.871991	\N
307003	3898	332	2014-12-07 16:16:54.892576	\N
307004	3899	312	2014-12-07 16:16:54.913482	\N
307005	3900	312	2014-12-07 16:16:54.933603	\N
307006	3901	308	2014-12-07 16:16:54.955297	\N
307007	3902	318	2014-12-07 16:16:54.976338	\N
307008	3903	318	2014-12-07 16:16:54.995806	\N
307009	3904	318	2014-12-07 16:16:55.016115	\N
307010	3905	330	2014-12-07 16:16:55.036592	\N
307011	3906	311	2014-12-07 16:16:55.05633	\N
307012	3907	304	2014-12-07 16:16:55.291641	\N
307013	3908	305	2014-12-07 16:16:55.313585	\N
307014	3909	306	2014-12-07 16:16:55.333731	\N
307015	3910	306	2014-12-07 16:16:55.354797	\N
307016	3911	306	2014-12-07 16:16:55.376189	\N
307017	3912	307	2014-12-07 16:16:55.39672	\N
307018	3913	307	2014-12-07 16:16:55.417024	\N
307019	3914	307	2014-12-07 16:16:55.43815	\N
307020	3915	307	2014-12-07 16:16:55.464745	\N
307021	3916	307	2014-12-07 16:16:55.489062	\N
307022	3917	307	2014-12-07 16:16:55.527108	\N
307023	3918	307	2014-12-07 16:16:55.556679	\N
307024	3919	307	2014-12-07 16:16:55.577268	\N
307025	3920	307	2014-12-07 16:16:55.601087	\N
307026	3921	308	2014-12-07 16:16:55.627257	\N
307027	3922	308	2014-12-07 16:16:55.652302	\N
307028	3923	308	2014-12-07 16:16:55.678741	\N
307029	3924	309	2014-12-07 16:16:55.700561	\N
307030	3925	309	2014-12-07 16:16:55.72601	\N
307031	3926	309	2014-12-07 16:16:55.751055	\N
307032	3927	309	2014-12-07 16:16:55.777033	\N
307033	3928	310	2014-12-07 16:16:55.800148	\N
307034	3929	310	2014-12-07 16:16:55.822935	\N
307035	3930	311	2014-12-07 16:16:55.848241	\N
307036	3931	311	2014-12-07 16:16:55.87217	\N
307037	3932	312	2014-12-07 16:16:55.899533	\N
307038	3933	312	2014-12-07 16:16:55.925714	\N
307039	3934	312	2014-12-07 16:16:55.948627	\N
307040	3935	312	2014-12-07 16:16:55.97436	\N
307041	3936	312	2014-12-07 16:16:56.002733	\N
307042	3937	313	2014-12-07 16:16:56.028015	\N
307043	3938	313	2014-12-07 16:16:56.054504	\N
307044	3939	313	2014-12-07 16:16:56.0808	\N
307045	3940	315	2014-12-07 16:16:56.103567	\N
307046	3941	315	2014-12-07 16:16:56.133756	\N
307047	3942	315	2014-12-07 16:16:56.156224	\N
307048	3943	315	2014-12-07 16:16:56.17685	\N
307049	3944	315	2014-12-07 16:16:56.198688	\N
307050	3945	315	2014-12-07 16:16:56.219488	\N
307051	3946	315	2014-12-07 16:16:56.240396	\N
307052	3947	316	2014-12-07 16:16:56.260696	\N
307053	3948	316	2014-12-07 16:16:56.282189	\N
307054	3949	316	2014-12-07 16:16:56.303598	\N
307055	3950	317	2014-12-07 16:16:56.324768	\N
307056	3951	318	2014-12-07 16:16:56.346703	\N
307057	3952	318	2014-12-07 16:16:56.368258	\N
307058	3953	318	2014-12-07 16:16:56.388953	\N
307059	3954	318	2014-12-07 16:16:56.40979	\N
307060	3955	318	2014-12-07 16:16:56.431471	\N
307061	3956	318	2014-12-07 16:16:56.453433	\N
307062	3957	318	2014-12-07 16:16:56.477873	\N
307063	3958	320	2014-12-07 16:16:56.498988	\N
307064	3959	320	2014-12-07 16:16:56.520892	\N
307065	3960	320	2014-12-07 16:16:56.543239	\N
307066	3961	320	2014-12-07 16:16:56.563512	\N
307067	3962	320	2014-12-07 16:16:56.584448	\N
307068	3963	323	2014-12-07 16:16:56.606089	\N
307069	3964	323	2014-12-07 16:16:56.626767	\N
307070	3965	323	2014-12-07 16:16:56.650808	\N
307071	3966	323	2014-12-07 16:16:56.672052	\N
307072	3967	323	2014-12-07 16:16:56.693567	\N
307073	3968	323	2014-12-07 16:16:56.717336	\N
307074	3969	324	2014-12-07 16:16:56.738994	\N
307075	3970	324	2014-12-07 16:16:56.761329	\N
307076	3971	324	2014-12-07 16:16:56.783241	\N
307077	3972	324	2014-12-07 16:16:56.804318	\N
307078	3973	326	2014-12-07 16:16:56.825799	\N
307079	3974	326	2014-12-07 16:16:56.849154	\N
307080	3975	326	2014-12-07 16:16:56.870938	\N
307081	3976	326	2014-12-07 16:16:56.891763	\N
307082	3977	326	2014-12-07 16:16:56.91511	\N
307083	3978	326	2014-12-07 16:16:56.937902	\N
307084	3979	326	2014-12-07 16:16:56.95976	\N
307085	3980	326	2014-12-07 16:16:56.981909	\N
307086	3981	326	2014-12-07 16:16:57.003619	\N
307087	3982	326	2014-12-07 16:16:57.025087	\N
307088	3983	326	2014-12-07 16:16:57.045649	\N
307089	3984	326	2014-12-07 16:16:57.068251	\N
307090	3985	326	2014-12-07 16:16:57.090369	\N
307091	3986	329	2014-12-07 16:16:57.112208	\N
307092	3987	329	2014-12-07 16:16:57.134441	\N
307093	3988	329	2014-12-07 16:16:57.155676	\N
307094	3989	329	2014-12-07 16:16:57.177561	\N
307095	3990	330	2014-12-07 16:16:57.19875	\N
307096	3991	330	2014-12-07 16:16:57.220314	\N
307097	3992	330	2014-12-07 16:16:57.241696	\N
307098	3993	330	2014-12-07 16:16:57.263991	\N
307099	3994	330	2014-12-07 16:16:57.284608	\N
307100	3995	330	2014-12-07 16:16:57.305702	\N
307101	3996	330	2014-12-07 16:16:57.329905	\N
307102	3997	335	2014-12-07 16:16:57.351287	\N
307103	3998	331	2014-12-07 16:16:57.372587	\N
307104	3999	332	2014-12-07 16:16:57.394006	\N
307105	4000	334	2014-12-07 16:16:57.416064	\N
307106	4001	336	2014-12-07 16:16:57.970536	\N
307107	4002	336	2014-12-07 16:16:57.992768	\N
307108	4003	336	2014-12-07 16:16:58.134846	\N
307109	4004	336	2014-12-07 16:16:58.157885	\N
307110	4005	331	2014-12-07 16:16:58.301777	\N
307111	4006	333	2014-12-07 16:16:58.460489	\N
307112	4007	336	2014-12-07 16:16:58.483432	\N
307113	4008	304	2014-12-07 16:16:58.63626	\N
307114	4009	305	2014-12-07 16:16:58.658258	\N
307115	4010	306	2014-12-07 16:16:58.680375	\N
307116	4011	307	2014-12-07 16:16:58.702149	\N
307117	4012	308	2014-12-07 16:16:58.724478	\N
307118	4013	309	2014-12-07 16:16:58.746368	\N
307119	4014	310	2014-12-07 16:16:58.769838	\N
307120	4015	311	2014-12-07 16:16:58.791866	\N
307121	4016	312	2014-12-07 16:16:58.813351	\N
307122	4017	313	2014-12-07 16:16:58.835657	\N
307123	4018	314	2014-12-07 16:16:58.857037	\N
307124	4019	315	2014-12-07 16:16:58.878371	\N
307125	4020	316	2014-12-07 16:16:58.900433	\N
307126	4021	317	2014-12-07 16:16:58.924971	\N
307127	4022	318	2014-12-07 16:16:58.946157	\N
307128	4023	319	2014-12-07 16:16:58.971581	\N
307129	4024	320	2014-12-07 16:16:58.993613	\N
307130	4025	321	2014-12-07 16:16:59.016205	\N
307131	4026	322	2014-12-07 16:16:59.038957	\N
307132	4027	323	2014-12-07 16:16:59.060799	\N
307133	4028	324	2014-12-07 16:16:59.083889	\N
307134	4029	325	2014-12-07 16:16:59.107376	\N
307135	4030	326	2014-12-07 16:16:59.132638	\N
307136	4031	327	2014-12-07 16:16:59.15524	\N
307137	4032	328	2014-12-07 16:16:59.177585	\N
307138	4033	329	2014-12-07 16:16:59.200399	\N
307139	4034	330	2014-12-07 16:16:59.223003	\N
307140	4035	331	2014-12-07 16:16:59.244316	\N
307141	4036	332	2014-12-07 16:16:59.266299	\N
307142	4037	333	2014-12-07 16:16:59.28917	\N
307143	4038	334	2014-12-07 16:16:59.312034	\N
307144	4039	312	2014-12-07 16:16:59.533326	\N
307145	4040	336	2014-12-07 16:16:59.555937	\N
307146	4041	306	2014-12-07 16:16:59.580508	\N
307147	4042	336	2014-12-07 16:16:59.601912	\N
307148	4043	336	2014-12-07 16:16:59.624693	\N
307149	4044	336	2014-12-07 16:16:59.647702	\N
307150	4045	336	2014-12-07 16:16:59.669564	\N
307151	4046	336	2014-12-07 16:16:59.691315	\N
307152	4047	329	2014-12-07 16:16:59.861832	\N
307153	4048	318	2014-12-07 16:16:59.885051	\N
307154	4049	313	2014-12-07 16:16:59.90751	\N
307155	4049	334	2014-12-07 16:16:59.910519	\N
307156	4050	329	2014-12-07 16:17:00.065751	\N
307157	4051	333	2014-12-07 16:17:00.088078	\N
307158	4052	332	2014-12-07 16:17:00.278216	\N
307159	4053	304	2014-12-07 16:17:00.446077	\N
307160	4054	305	2014-12-07 16:17:00.47106	\N
307161	4055	306	2014-12-07 16:17:00.493788	\N
307162	4056	307	2014-12-07 16:17:00.516431	\N
307163	4057	308	2014-12-07 16:17:00.539124	\N
307164	4058	309	2014-12-07 16:17:00.561293	\N
307165	4059	310	2014-12-07 16:17:00.582886	\N
307166	4060	311	2014-12-07 16:17:00.605901	\N
307167	4061	312	2014-12-07 16:17:00.627662	\N
307168	4062	313	2014-12-07 16:17:00.649394	\N
307169	4063	314	2014-12-07 16:17:00.671026	\N
307170	4064	315	2014-12-07 16:17:00.693416	\N
307171	4065	316	2014-12-07 16:17:00.714952	\N
307172	4066	317	2014-12-07 16:17:00.73678	\N
307173	4067	318	2014-12-07 16:17:00.761024	\N
307174	4068	319	2014-12-07 16:17:00.783561	\N
307175	4069	320	2014-12-07 16:17:00.805058	\N
307176	4070	321	2014-12-07 16:17:00.827698	\N
307177	4071	322	2014-12-07 16:17:00.850379	\N
307178	4072	323	2014-12-07 16:17:00.87327	\N
307179	4073	324	2014-12-07 16:17:00.896826	\N
307180	4074	325	2014-12-07 16:17:00.9192	\N
307181	4075	326	2014-12-07 16:17:00.945627	\N
307182	4076	327	2014-12-07 16:17:00.972864	\N
307183	4077	328	2014-12-07 16:17:00.996882	\N
307184	4078	329	2014-12-07 16:17:01.018299	\N
307185	4079	330	2014-12-07 16:17:01.040499	\N
307186	4080	335	2014-12-07 16:17:01.063856	\N
307187	4081	331	2014-12-07 16:17:01.088054	\N
307188	4082	332	2014-12-07 16:17:01.113202	\N
307189	4083	333	2014-12-07 16:17:01.135504	\N
307190	4084	334	2014-12-07 16:17:01.157762	\N
307191	4085	304	2014-12-07 16:17:01.41048	\N
307192	4086	305	2014-12-07 16:17:01.432937	\N
307193	4087	305	2014-12-07 16:17:01.455331	\N
307194	4088	306	2014-12-07 16:17:01.480496	\N
307195	4089	308	2014-12-07 16:17:01.503613	\N
307196	4090	310	2014-12-07 16:17:01.527194	\N
307197	4091	310	2014-12-07 16:17:01.551254	\N
307198	4092	311	2014-12-07 16:17:01.573758	\N
307199	4093	312	2014-12-07 16:17:01.59708	\N
307200	4094	312	2014-12-07 16:17:01.619882	\N
307201	4095	314	2014-12-07 16:17:01.641543	\N
307202	4096	314	2014-12-07 16:17:01.66482	\N
307203	4097	314	2014-12-07 16:17:01.688253	\N
307204	4098	315	2014-12-07 16:17:01.711242	\N
307205	4099	316	2014-12-07 16:17:01.733483	\N
307206	4100	316	2014-12-07 16:17:01.757613	\N
307207	4101	316	2014-12-07 16:17:01.780916	\N
307208	4102	317	2014-12-07 16:17:01.804731	\N
307209	4103	317	2014-12-07 16:17:01.827553	\N
307210	4104	318	2014-12-07 16:17:01.850504	\N
307211	4105	318	2014-12-07 16:17:01.873322	\N
307212	4106	319	2014-12-07 16:17:01.89638	\N
307213	4107	319	2014-12-07 16:17:01.918213	\N
307214	4108	319	2014-12-07 16:17:01.941547	\N
307215	4109	319	2014-12-07 16:17:01.966012	\N
307216	4110	319	2014-12-07 16:17:01.99048	\N
307217	4111	320	2014-12-07 16:17:02.015074	\N
307218	4112	321	2014-12-07 16:17:02.036726	\N
307219	4113	321	2014-12-07 16:17:02.059966	\N
307220	4114	321	2014-12-07 16:17:02.083362	\N
307221	4115	323	2014-12-07 16:17:02.106569	\N
307222	4116	323	2014-12-07 16:17:02.133831	\N
307223	4117	326	2014-12-07 16:17:02.15649	\N
307224	4118	326	2014-12-07 16:17:02.179572	\N
307225	4119	327	2014-12-07 16:17:02.202692	\N
307226	4120	327	2014-12-07 16:17:02.237063	\N
307227	4121	327	2014-12-07 16:17:02.259996	\N
307228	4122	328	2014-12-07 16:17:02.28308	\N
307229	4123	328	2014-12-07 16:17:02.305254	\N
307230	4124	329	2014-12-07 16:17:02.33146	\N
307231	4125	330	2014-12-07 16:17:02.354602	\N
307232	4126	331	2014-12-07 16:17:02.378013	\N
307233	4127	331	2014-12-07 16:17:02.400745	\N
307234	4128	331	2014-12-07 16:17:02.423132	\N
307235	4129	331	2014-12-07 16:17:02.446623	\N
307236	4130	332	2014-12-07 16:17:02.475786	\N
307237	4131	332	2014-12-07 16:17:02.49921	\N
307238	4132	333	2014-12-07 16:17:02.521055	\N
307239	4133	333	2014-12-07 16:17:02.543337	\N
307240	4134	334	2014-12-07 16:17:02.566157	\N
307241	4135	312	2014-12-07 16:17:02.846393	\N
307242	4136	306	2014-12-07 16:17:02.871532	\N
307243	4137	313	2014-12-07 16:17:02.898252	\N
307244	4138	319	2014-12-07 16:17:02.922215	\N
307245	4139	334	2014-12-07 16:17:02.945462	\N
307246	4140	304	2014-12-07 16:17:03.161357	\N
307247	4140	305	2014-12-07 16:17:03.164235	\N
307248	4140	306	2014-12-07 16:17:03.166787	\N
307249	4140	307	2014-12-07 16:17:03.169173	\N
307250	4140	308	2014-12-07 16:17:03.171391	\N
307251	4140	309	2014-12-07 16:17:03.173677	\N
307252	4140	310	2014-12-07 16:17:03.175832	\N
307253	4140	311	2014-12-07 16:17:03.177908	\N
307254	4140	312	2014-12-07 16:17:03.179938	\N
307255	4140	313	2014-12-07 16:17:03.182484	\N
307256	4140	314	2014-12-07 16:17:03.185163	\N
307257	4140	315	2014-12-07 16:17:03.187578	\N
307258	4140	316	2014-12-07 16:17:03.189797	\N
307259	4140	317	2014-12-07 16:17:03.19245	\N
307260	4140	318	2014-12-07 16:17:03.194709	\N
307261	4140	319	2014-12-07 16:17:03.196727	\N
307262	4140	320	2014-12-07 16:17:03.198772	\N
307263	4140	321	2014-12-07 16:17:03.201077	\N
307264	4140	322	2014-12-07 16:17:03.203268	\N
307265	4140	323	2014-12-07 16:17:03.205429	\N
307266	4140	324	2014-12-07 16:17:03.207396	\N
307267	4140	325	2014-12-07 16:17:03.209399	\N
307268	4140	326	2014-12-07 16:17:03.211494	\N
307269	4140	327	2014-12-07 16:17:03.214071	\N
307270	4140	328	2014-12-07 16:17:03.216771	\N
307271	4140	329	2014-12-07 16:17:03.219101	\N
307272	4140	330	2014-12-07 16:17:03.221379	\N
307273	4140	331	2014-12-07 16:17:03.223679	\N
307274	4140	332	2014-12-07 16:17:03.225714	\N
307275	4140	333	2014-12-07 16:17:03.228019	\N
307276	4140	334	2014-12-07 16:17:03.230333	\N
307277	4140	335	2014-12-07 16:17:03.232659	\N
307278	4141	336	2014-12-07 16:17:03.486113	\N
307279	4142	336	2014-12-07 16:17:03.510252	\N
307280	4143	336	2014-12-07 16:17:03.690622	\N
307281	4144	336	2014-12-07 16:17:03.883429	\N
307282	4145	305	2014-12-07 16:17:04.091382	\N
307283	4146	306	2014-12-07 16:17:04.136966	\N
307284	4147	307	2014-12-07 16:17:04.162089	\N
307285	4148	312	2014-12-07 16:17:04.186079	\N
307286	4149	313	2014-12-07 16:17:04.210673	\N
307287	4150	316	2014-12-07 16:17:04.241518	\N
307288	4151	319	2014-12-07 16:17:04.272107	\N
307289	4152	321	2014-12-07 16:17:04.297744	\N
307290	4153	327	2014-12-07 16:17:04.321781	\N
307291	4154	328	2014-12-07 16:17:04.347506	\N
307292	4155	329	2014-12-07 16:17:04.378934	\N
307293	4156	330	2014-12-07 16:17:04.410917	\N
307294	4157	333	2014-12-07 16:17:04.445206	\N
307295	4158	328	2014-12-07 16:17:04.684433	\N
307296	4159	328	2014-12-07 16:17:04.71496	\N
307297	4160	331	2014-12-07 16:17:04.743516	\N
307298	4161	331	2014-12-07 16:17:04.768384	\N
307299	4162	328	2014-12-07 16:17:04.989027	\N
307300	4163	308	2014-12-07 16:17:05.019088	\N
307301	4164	316	2014-12-07 16:17:05.043681	\N
307302	4165	310	2014-12-07 16:17:05.068302	\N
307303	4166	311	2014-12-07 16:17:05.093598	\N
307304	4167	321	2014-12-07 16:17:05.117854	\N
307305	4168	326	2014-12-07 16:17:05.14323	\N
307306	4169	329	2014-12-07 16:17:05.166979	\N
307307	4170	333	2014-12-07 16:17:05.191215	\N
307308	4171	305	2014-12-07 16:17:05.216613	\N
307309	4172	336	2014-12-07 16:17:05.437141	\N
307310	4173	336	2014-12-07 16:17:05.643079	\N
307311	4174	336	2014-12-07 16:17:05.672373	\N
307312	4175	336	2014-12-07 16:17:05.69864	\N
307313	4176	336	2014-12-07 16:17:05.90462	\N
307314	4177	307	2014-12-07 16:17:06.110663	\N
307315	4178	316	2014-12-07 16:17:06.138479	\N
307316	4179	322	2014-12-07 16:17:06.162699	\N
307317	4180	324	2014-12-07 16:17:06.186399	\N
307318	4181	328	2014-12-07 16:17:06.210594	\N
307319	4182	331	2014-12-07 16:17:06.436209	\N
307320	4183	336	2014-12-07 16:17:06.465547	\N
307321	4184	331	2014-12-07 16:17:06.490683	\N
307322	4185	331	2014-12-07 16:17:06.516954	\N
307323	4186	336	2014-12-07 16:17:06.540825	\N
307324	4187	336	2014-12-07 16:17:06.566391	\N
307325	4188	336	2014-12-07 16:17:06.590662	\N
307326	4189	336	2014-12-07 16:17:06.814322	\N
307327	4190	306	2014-12-07 16:17:07.023949	\N
307328	4191	312	2014-12-07 16:17:07.052213	\N
307329	4192	326	2014-12-07 16:17:07.076644	\N
307330	4193	329	2014-12-07 16:17:07.100891	\N
307331	4194	336	2014-12-07 16:17:07.127031	\N
307332	4195	336	2014-12-07 16:17:07.151633	\N
307333	4196	336	2014-12-07 16:17:07.17411	\N
307334	4197	336	2014-12-07 16:17:07.198417	\N
307335	4198	336	2014-12-07 16:17:07.41808	\N
307336	4199	304	2014-12-07 16:17:07.445563	\N
307337	4200	324	2014-12-07 16:17:07.471958	\N
307338	4201	331	2014-12-07 16:17:07.495975	\N
307339	4202	336	2014-12-07 16:17:07.520008	\N
307340	4203	336	2014-12-07 16:17:07.544134	\N
307341	4204	333	2014-12-07 16:17:07.568302	\N
307342	4205	321	2014-12-07 16:17:07.807588	\N
307343	4205	323	2014-12-07 16:17:07.812646	\N
307344	4205	329	2014-12-07 16:17:07.816676	\N
307345	4205	331	2014-12-07 16:17:07.819707	\N
307346	4205	334	2014-12-07 16:17:07.821967	\N
307347	4206	319	2014-12-07 16:17:07.852758	\N
307348	4206	321	2014-12-07 16:17:07.855313	\N
307349	4206	323	2014-12-07 16:17:07.857455	\N
307350	4206	329	2014-12-07 16:17:07.859416	\N
307351	4206	331	2014-12-07 16:17:07.861535	\N
307352	4206	334	2014-12-07 16:17:07.863495	\N
307353	4207	336	2014-12-07 16:17:07.888176	\N
307354	4208	336	2014-12-07 16:17:07.913222	\N
307355	4209	336	2014-12-07 16:17:07.9386	\N
307356	4210	336	2014-12-07 16:17:07.96393	\N
307357	4211	336	2014-12-07 16:17:07.987992	\N
307358	4212	316	2014-12-07 16:17:08.215577	\N
307359	4213	336	2014-12-07 16:17:08.247079	\N
307360	4214	336	2014-12-07 16:17:08.271496	\N
307361	4215	307	2014-12-07 16:17:08.541301	\N
307362	4216	316	2014-12-07 16:17:08.571829	\N
307363	4217	306	2014-12-07 16:17:08.595131	\N
307364	4218	315	2014-12-07 16:17:08.619631	\N
307365	4219	305	2014-12-07 16:17:08.643656	\N
307366	4220	326	2014-12-07 16:17:08.667868	\N
307367	4221	329	2014-12-07 16:17:08.692111	\N
307368	4222	334	2014-12-07 16:17:08.716202	\N
307369	4223	305	2014-12-07 16:17:08.964239	\N
307370	4224	321	2014-12-07 16:17:08.992931	\N
307371	4225	306	2014-12-07 16:17:09.02363	\N
307372	4226	307	2014-12-07 16:17:09.047051	\N
307373	4227	309	2014-12-07 16:17:09.071772	\N
307374	4228	312	2014-12-07 16:17:09.095753	\N
307375	4229	313	2014-12-07 16:17:09.120006	\N
307376	4230	314	2014-12-07 16:17:09.145634	\N
307377	4231	315	2014-12-07 16:17:09.170919	\N
307378	4232	316	2014-12-07 16:17:09.194905	\N
307379	4233	318	2014-12-07 16:17:09.218614	\N
307380	4234	320	2014-12-07 16:17:09.24314	\N
307381	4235	326	2014-12-07 16:17:09.267107	\N
307382	4236	329	2014-12-07 16:17:09.291788	\N
307383	4237	330	2014-12-07 16:17:09.315145	\N
307384	4238	335	2014-12-07 16:17:09.339856	\N
307385	4239	336	2014-12-07 16:17:09.600546	\N
307386	4240	336	2014-12-07 16:17:09.629631	\N
307387	4241	322	2014-12-07 16:17:09.882856	\N
307388	4242	333	2014-12-07 16:17:09.913389	\N
307389	4243	334	2014-12-07 16:17:09.938904	\N
307390	4244	311	2014-12-07 16:17:09.963989	\N
307391	4245	314	2014-12-07 16:17:09.989254	\N
307392	4246	331	2014-12-07 16:17:10.269821	\N
307393	4247	321	2014-12-07 16:17:10.545888	\N
307394	4248	331	2014-12-07 16:17:10.57528	\N
307395	4249	331	2014-12-07 16:17:10.606157	\N
307396	4250	331	2014-12-07 16:17:10.642506	\N
307397	4251	304	2014-12-07 16:17:10.95515	\N
307398	4252	305	2014-12-07 16:17:10.987499	\N
307399	4253	305	2014-12-07 16:17:11.01855	\N
307400	4254	306	2014-12-07 16:17:11.045228	\N
307401	4255	306	2014-12-07 16:17:11.071768	\N
307402	4256	307	2014-12-07 16:17:11.1001	\N
307403	4257	308	2014-12-07 16:17:11.127575	\N
307404	4258	308	2014-12-07 16:17:11.163508	\N
307405	4259	308	2014-12-07 16:17:11.190009	\N
307406	4260	309	2014-12-07 16:17:11.216544	\N
307407	4261	310	2014-12-07 16:17:11.242622	\N
307408	4262	312	2014-12-07 16:17:11.267815	\N
307409	4263	312	2014-12-07 16:17:11.294502	\N
307410	4264	313	2014-12-07 16:17:11.324684	\N
307411	4265	315	2014-12-07 16:17:11.352774	\N
307412	4266	315	2014-12-07 16:17:11.378657	\N
307413	4267	315	2014-12-07 16:17:11.403899	\N
307414	4268	316	2014-12-07 16:17:11.4308	\N
307415	4269	316	2014-12-07 16:17:11.457413	\N
307416	4270	317	2014-12-07 16:17:11.485624	\N
307417	4271	317	2014-12-07 16:17:11.510922	\N
307418	4272	318	2014-12-07 16:17:11.536762	\N
307419	4273	318	2014-12-07 16:17:11.563482	\N
307420	4274	319	2014-12-07 16:17:11.588748	\N
307421	4275	319	2014-12-07 16:17:11.615173	\N
307422	4276	319	2014-12-07 16:17:11.641297	\N
307423	4277	319	2014-12-07 16:17:11.668434	\N
307424	4278	319	2014-12-07 16:17:11.695028	\N
307425	4279	319	2014-12-07 16:17:11.719935	\N
307426	4280	320	2014-12-07 16:17:11.746411	\N
307427	4281	321	2014-12-07 16:17:11.772969	\N
307428	4282	321	2014-12-07 16:17:11.799054	\N
307429	4283	321	2014-12-07 16:17:11.82387	\N
307430	4284	321	2014-12-07 16:17:11.849949	\N
307431	4285	323	2014-12-07 16:17:11.875065	\N
307432	4286	323	2014-12-07 16:17:11.900413	\N
307433	4287	323	2014-12-07 16:17:11.927499	\N
307434	4288	323	2014-12-07 16:17:11.953971	\N
307435	4289	324	2014-12-07 16:17:11.979161	\N
307436	4290	325	2014-12-07 16:17:12.005015	\N
307437	4291	325	2014-12-07 16:17:12.030966	\N
307438	4292	328	2014-12-07 16:17:12.057457	\N
307439	4293	328	2014-12-07 16:17:12.084181	\N
307440	4294	328	2014-12-07 16:17:12.124888	\N
307441	4295	329	2014-12-07 16:17:12.158401	\N
307442	4296	329	2014-12-07 16:17:12.187082	\N
307443	4297	330	2014-12-07 16:17:12.211965	\N
307444	4298	330	2014-12-07 16:17:12.238571	\N
307445	4299	331	2014-12-07 16:17:12.263782	\N
307446	4300	331	2014-12-07 16:17:12.289683	\N
307447	4301	331	2014-12-07 16:17:12.315383	\N
307448	4302	331	2014-12-07 16:17:12.341149	\N
307449	4303	331	2014-12-07 16:17:12.368093	\N
307450	4304	331	2014-12-07 16:17:12.403112	\N
307451	4305	331	2014-12-07 16:17:12.430318	\N
307452	4306	331	2014-12-07 16:17:12.456964	\N
307453	4307	331	2014-12-07 16:17:12.491141	\N
307454	4308	331	2014-12-07 16:17:12.52674	\N
307455	4309	331	2014-12-07 16:17:12.561446	\N
307456	4310	331	2014-12-07 16:17:12.59943	\N
307457	4311	331	2014-12-07 16:17:12.630634	\N
307458	4312	331	2014-12-07 16:17:12.661304	\N
307459	4313	331	2014-12-07 16:17:12.69121	\N
307460	4314	331	2014-12-07 16:17:12.718018	\N
307461	4315	332	2014-12-07 16:17:12.743608	\N
307462	4316	333	2014-12-07 16:17:12.773203	\N
307463	4317	333	2014-12-07 16:17:12.799553	\N
307464	4318	334	2014-12-07 16:17:12.825321	\N
307465	4319	304	2014-12-07 16:17:13.295568	\N
307466	4319	305	2014-12-07 16:17:13.298541	\N
307467	4319	306	2014-12-07 16:17:13.301267	\N
307468	4319	307	2014-12-07 16:17:13.303909	\N
307469	4319	308	2014-12-07 16:17:13.306807	\N
307470	4319	309	2014-12-07 16:17:13.309089	\N
307471	4319	310	2014-12-07 16:17:13.311272	\N
307472	4319	311	2014-12-07 16:17:13.313532	\N
307473	4319	312	2014-12-07 16:17:13.315754	\N
307474	4319	313	2014-12-07 16:17:13.31852	\N
307475	4319	314	2014-12-07 16:17:13.320728	\N
307476	4319	315	2014-12-07 16:17:13.322916	\N
307477	4319	316	2014-12-07 16:17:13.32512	\N
307478	4319	317	2014-12-07 16:17:13.327312	\N
307479	4319	318	2014-12-07 16:17:13.329355	\N
307480	4319	319	2014-12-07 16:17:13.33146	\N
307481	4319	320	2014-12-07 16:17:13.333635	\N
307482	4319	321	2014-12-07 16:17:13.335881	\N
307483	4319	322	2014-12-07 16:17:13.338092	\N
307484	4319	323	2014-12-07 16:17:13.340205	\N
307485	4319	324	2014-12-07 16:17:13.34232	\N
307486	4319	325	2014-12-07 16:17:13.34447	\N
307487	4319	326	2014-12-07 16:17:13.346819	\N
307488	4319	327	2014-12-07 16:17:13.348935	\N
307489	4319	328	2014-12-07 16:17:13.35116	\N
307490	4319	329	2014-12-07 16:17:13.353222	\N
307491	4319	330	2014-12-07 16:17:13.355926	\N
307492	4319	331	2014-12-07 16:17:13.358155	\N
307493	4319	332	2014-12-07 16:17:13.360397	\N
307494	4319	333	2014-12-07 16:17:13.362495	\N
307495	4319	334	2014-12-07 16:17:13.364945	\N
307496	4319	335	2014-12-07 16:17:13.367457	\N
307497	4320	305	2014-12-07 16:17:13.621134	\N
307498	4320	306	2014-12-07 16:17:13.624782	\N
307499	4320	325	2014-12-07 16:17:13.62888	\N
307500	4320	328	2014-12-07 16:17:13.631529	\N
307501	4321	305	2014-12-07 16:17:13.663249	\N
307502	4321	306	2014-12-07 16:17:13.666164	\N
307503	4321	317	2014-12-07 16:17:13.668669	\N
307504	4321	325	2014-12-07 16:17:13.671031	\N
307505	4321	328	2014-12-07 16:17:13.673659	\N
307506	4322	304	2014-12-07 16:17:13.947145	\N
307507	4323	305	2014-12-07 16:17:13.984682	\N
307508	4324	306	2014-12-07 16:17:14.018235	\N
307509	4325	307	2014-12-07 16:17:14.046535	\N
307510	4326	308	2014-12-07 16:17:14.072854	\N
307511	4327	309	2014-12-07 16:17:14.098727	\N
307512	4328	310	2014-12-07 16:17:14.124624	\N
307513	4329	311	2014-12-07 16:17:14.151432	\N
307514	4330	312	2014-12-07 16:17:14.177065	\N
307515	4331	313	2014-12-07 16:17:14.203073	\N
307516	4332	314	2014-12-07 16:17:14.228808	\N
307517	4333	315	2014-12-07 16:17:14.254438	\N
307518	4334	316	2014-12-07 16:17:14.280684	\N
307519	4335	317	2014-12-07 16:17:14.307892	\N
307520	4336	318	2014-12-07 16:17:14.336211	\N
307521	4337	319	2014-12-07 16:17:14.362584	\N
307522	4338	320	2014-12-07 16:17:14.388799	\N
307523	4339	321	2014-12-07 16:17:14.418544	\N
307524	4340	322	2014-12-07 16:17:14.452194	\N
307525	4341	323	2014-12-07 16:17:14.482541	\N
307526	4342	324	2014-12-07 16:17:14.509249	\N
307527	4343	325	2014-12-07 16:17:14.535395	\N
307528	4344	326	2014-12-07 16:17:14.561355	\N
307529	4345	327	2014-12-07 16:17:14.587966	\N
307530	4346	328	2014-12-07 16:17:14.614338	\N
307531	4347	335	2014-12-07 16:17:14.639845	\N
307532	4348	329	2014-12-07 16:17:14.665708	\N
307533	4349	330	2014-12-07 16:17:14.691112	\N
307534	4350	331	2014-12-07 16:17:14.716091	\N
307535	4351	332	2014-12-07 16:17:14.741678	\N
307536	4352	333	2014-12-07 16:17:14.767136	\N
307537	4353	334	2014-12-07 16:17:14.793628	\N
307538	4354	304	2014-12-07 16:17:15.114749	\N
307539	4355	305	2014-12-07 16:17:15.145584	\N
307540	4356	306	2014-12-07 16:17:15.170994	\N
307541	4357	307	2014-12-07 16:17:15.195805	\N
307542	4358	308	2014-12-07 16:17:15.220989	\N
307543	4359	309	2014-12-07 16:17:15.245864	\N
307544	4360	310	2014-12-07 16:17:15.270466	\N
307545	4361	311	2014-12-07 16:17:15.295878	\N
307546	4362	312	2014-12-07 16:17:15.320163	\N
307547	4363	313	2014-12-07 16:17:15.345079	\N
307548	4364	314	2014-12-07 16:17:15.369548	\N
307549	4365	315	2014-12-07 16:17:15.395353	\N
307550	4366	316	2014-12-07 16:17:15.419657	\N
307551	4367	317	2014-12-07 16:17:15.444205	\N
307552	4368	318	2014-12-07 16:17:15.470718	\N
307553	4369	319	2014-12-07 16:17:15.500875	\N
307554	4370	320	2014-12-07 16:17:15.526783	\N
307555	4371	321	2014-12-07 16:17:15.552171	\N
307556	4372	322	2014-12-07 16:17:15.579542	\N
307557	4373	323	2014-12-07 16:17:15.605738	\N
307558	4374	324	2014-12-07 16:17:15.631339	\N
307559	4375	325	2014-12-07 16:17:15.656242	\N
307560	4376	326	2014-12-07 16:17:15.681581	\N
307561	4377	327	2014-12-07 16:17:15.710606	\N
307562	4378	328	2014-12-07 16:17:15.735655	\N
307563	4379	335	2014-12-07 16:17:15.761368	\N
307564	4380	329	2014-12-07 16:17:15.786221	\N
307565	4381	330	2014-12-07 16:17:15.811913	\N
307566	4382	331	2014-12-07 16:17:15.837169	\N
307567	4383	332	2014-12-07 16:17:15.862231	\N
307568	4384	333	2014-12-07 16:17:15.887598	\N
307569	4385	334	2014-12-07 16:17:15.912533	\N
307570	4386	336	2014-12-07 16:17:15.937584	\N
307571	4387	336	2014-12-07 16:17:16.261531	\N
307572	4388	336	2014-12-07 16:17:16.519335	\N
307573	4389	316	2014-12-07 16:17:16.78775	\N
307574	4390	336	2014-12-07 16:17:17.04149	\N
307575	4391	336	2014-12-07 16:17:17.306458	\N
307576	4392	336	2014-12-07 16:17:17.571345	\N
307577	4393	307	2014-12-07 16:17:17.845441	\N
307578	4394	307	2014-12-07 16:17:17.876095	\N
307579	4395	307	2014-12-07 16:17:17.902955	\N
307580	4396	307	2014-12-07 16:17:17.92825	\N
307581	4397	307	2014-12-07 16:17:17.953939	\N
307582	4398	307	2014-12-07 16:17:17.979933	\N
307583	4399	307	2014-12-07 16:17:18.006665	\N
307584	4400	307	2014-12-07 16:17:18.032151	\N
307585	4401	307	2014-12-07 16:17:18.05802	\N
307586	4402	307	2014-12-07 16:17:18.084043	\N
307587	4403	307	2014-12-07 16:17:18.110178	\N
307588	4404	307	2014-12-07 16:17:18.1361	\N
307589	4405	307	2014-12-07 16:17:18.162405	\N
307590	4406	307	2014-12-07 16:17:18.188695	\N
307591	4407	307	2014-12-07 16:17:18.214821	\N
307592	4408	307	2014-12-07 16:17:18.240454	\N
307593	4409	307	2014-12-07 16:17:18.266054	\N
307594	4410	307	2014-12-07 16:17:18.292244	\N
307595	4411	307	2014-12-07 16:17:18.31845	\N
307596	4412	307	2014-12-07 16:17:18.346764	\N
307597	4413	307	2014-12-07 16:17:18.383202	\N
307598	4414	307	2014-12-07 16:17:18.409711	\N
307599	4415	307	2014-12-07 16:17:18.448802	\N
307600	4416	307	2014-12-07 16:17:18.478235	\N
307601	4417	309	2014-12-07 16:17:18.512491	\N
307602	4418	309	2014-12-07 16:17:18.538342	\N
307603	4419	309	2014-12-07 16:17:18.56462	\N
307604	4420	309	2014-12-07 16:17:18.590313	\N
307605	4421	309	2014-12-07 16:17:18.615885	\N
307606	4422	320	2014-12-07 16:17:18.643374	\N
307607	4423	320	2014-12-07 16:17:18.669305	\N
307608	4424	320	2014-12-07 16:17:18.69616	\N
307609	4425	320	2014-12-07 16:17:18.722751	\N
307610	4426	320	2014-12-07 16:17:18.749479	\N
307611	4427	320	2014-12-07 16:17:18.776448	\N
307612	4428	320	2014-12-07 16:17:18.802519	\N
307613	4429	320	2014-12-07 16:17:18.828921	\N
307614	4430	320	2014-12-07 16:17:18.855311	\N
307615	4431	320	2014-12-07 16:17:18.881803	\N
307616	4432	320	2014-12-07 16:17:18.908204	\N
307617	4433	320	2014-12-07 16:17:18.939526	\N
307618	4434	320	2014-12-07 16:17:18.966529	\N
307619	4435	320	2014-12-07 16:17:18.994321	\N
307620	4436	320	2014-12-07 16:17:19.021592	\N
307621	4437	320	2014-12-07 16:17:19.050552	\N
307622	4438	320	2014-12-07 16:17:19.077032	\N
307623	4439	320	2014-12-07 16:17:19.103271	\N
307624	4440	320	2014-12-07 16:17:19.128849	\N
307625	4441	320	2014-12-07 16:17:19.156295	\N
307626	4442	320	2014-12-07 16:17:19.182375	\N
307627	4443	320	2014-12-07 16:17:19.209111	\N
307628	4444	320	2014-12-07 16:17:19.235619	\N
307629	4445	320	2014-12-07 16:17:19.261139	\N
307630	4446	320	2014-12-07 16:17:19.287389	\N
307631	4447	320	2014-12-07 16:17:19.313636	\N
307632	4448	320	2014-12-07 16:17:19.339767	\N
307633	4449	320	2014-12-07 16:17:19.366506	\N
307634	4450	320	2014-12-07 16:17:19.392743	\N
307635	4451	320	2014-12-07 16:17:19.419456	\N
307636	4452	322	2014-12-07 16:17:19.445684	\N
307637	4453	322	2014-12-07 16:17:19.474258	\N
307638	4454	322	2014-12-07 16:17:19.500733	\N
307639	4455	336	2014-12-07 16:17:19.894486	\N
307640	4456	305	2014-12-07 16:17:20.171805	\N
307641	4457	305	2014-12-07 16:17:20.204588	\N
307642	4458	305	2014-12-07 16:17:20.231926	\N
307643	4459	306	2014-12-07 16:17:20.258438	\N
307644	4460	306	2014-12-07 16:17:20.284636	\N
307645	4461	306	2014-12-07 16:17:20.311733	\N
307646	4462	307	2014-12-07 16:17:20.33903	\N
307647	4463	307	2014-12-07 16:17:20.365846	\N
307648	4464	307	2014-12-07 16:17:20.395531	\N
307649	4465	308	2014-12-07 16:17:20.422649	\N
307650	4466	314	2014-12-07 16:17:20.451945	\N
307651	4467	315	2014-12-07 16:17:20.481477	\N
307652	4468	315	2014-12-07 16:17:20.508493	\N
307653	4469	315	2014-12-07 16:17:20.543065	\N
307654	4470	315	2014-12-07 16:17:20.569164	\N
307655	4471	316	2014-12-07 16:17:20.59624	\N
307656	4472	316	2014-12-07 16:17:20.622638	\N
307657	4473	316	2014-12-07 16:17:20.649318	\N
307658	4474	319	2014-12-07 16:17:20.675702	\N
307659	4475	320	2014-12-07 16:17:20.701855	\N
307660	4476	321	2014-12-07 16:17:20.728772	\N
307661	4477	322	2014-12-07 16:17:20.758605	\N
307662	4478	324	2014-12-07 16:17:20.784915	\N
307663	4479	325	2014-12-07 16:17:20.811957	\N
307664	4480	326	2014-12-07 16:17:20.83888	\N
307665	4481	326	2014-12-07 16:17:20.865866	\N
307666	4482	326	2014-12-07 16:17:20.892687	\N
307667	4483	326	2014-12-07 16:17:20.919841	\N
307668	4484	326	2014-12-07 16:17:20.94691	\N
307669	4485	326	2014-12-07 16:17:20.973281	\N
307670	4486	329	2014-12-07 16:17:20.999754	\N
307671	4487	331	2014-12-07 16:17:21.026291	\N
307672	4488	332	2014-12-07 16:17:21.053134	\N
307673	4489	333	2014-12-07 16:17:21.080634	\N
307674	4490	336	2014-12-07 16:17:21.485747	\N
307675	4491	336	2014-12-07 16:17:21.513933	\N
307676	4492	336	2014-12-07 16:17:21.790135	\N
307677	4493	336	2014-12-07 16:17:22.079353	\N
307678	4494	324	2014-12-07 16:17:22.112551	\N
307679	4495	312	2014-12-07 16:17:22.160697	\N
307680	4496	308	2014-12-07 16:17:22.188144	\N
307681	4497	306	2014-12-07 16:17:22.217975	\N
307682	4498	306	2014-12-07 16:17:22.245499	\N
307683	4499	309	2014-12-07 16:17:22.272728	\N
307684	4500	307	2014-12-07 16:17:22.299526	\N
307685	4501	311	2014-12-07 16:17:22.32667	\N
307686	4502	307	2014-12-07 16:17:22.354136	\N
307687	4503	313	2014-12-07 16:17:22.380951	\N
307688	4504	320	2014-12-07 16:17:22.408314	\N
307689	4505	330	2014-12-07 16:17:22.43493	\N
307690	4506	320	2014-12-07 16:17:22.46337	\N
307691	4507	313	2014-12-07 16:17:22.491876	\N
307692	4508	322	2014-12-07 16:17:22.520064	\N
307693	4509	322	2014-12-07 16:17:22.550801	\N
307694	4510	324	2014-12-07 16:17:22.581984	\N
307695	4511	311	2014-12-07 16:17:22.609098	\N
307696	4512	305	2014-12-07 16:17:22.636564	\N
307697	4513	305	2014-12-07 16:17:22.66419	\N
307698	4514	330	2014-12-07 16:17:22.69192	\N
307699	4515	323	2014-12-07 16:17:22.720719	\N
307700	4516	307	2014-12-07 16:17:22.748885	\N
307701	4517	327	2014-12-07 16:17:22.77625	\N
307702	4518	309	2014-12-07 16:17:22.803506	\N
307703	4519	328	2014-12-07 16:17:23.140689	\N
307704	4520	331	2014-12-07 16:17:23.174182	\N
307705	4521	329	2014-12-07 16:17:23.205718	\N
307706	4522	332	2014-12-07 16:17:23.232657	\N
307707	4523	323	2014-12-07 16:17:23.550246	\N
307708	4524	321	2014-12-07 16:17:23.581848	\N
307709	4525	325	2014-12-07 16:17:23.610494	\N
307710	4526	321	2014-12-07 16:17:23.637857	\N
307711	4527	306	2014-12-07 16:17:23.665747	\N
307712	4528	314	2014-12-07 16:17:23.694179	\N
307713	4529	316	2014-12-07 16:17:23.721112	\N
307714	4530	307	2014-12-07 16:17:23.751837	\N
307715	4531	314	2014-12-07 16:17:23.781207	\N
307716	4532	323	2014-12-07 16:17:23.809204	\N
307717	4533	312	2014-12-07 16:17:23.836616	\N
307718	4534	305	2014-12-07 16:17:23.864234	\N
307719	4535	313	2014-12-07 16:17:23.891939	\N
307720	4536	330	2014-12-07 16:17:23.919437	\N
307721	4537	308	2014-12-07 16:17:23.947532	\N
307722	4538	305	2014-12-07 16:17:23.975159	\N
307723	4539	324	2014-12-07 16:17:24.002218	\N
307724	4540	315	2014-12-07 16:17:24.029853	\N
307725	4541	329	2014-12-07 16:17:24.05763	\N
307726	4542	335	2014-12-07 16:17:24.085075	\N
307727	4543	306	2014-12-07 16:17:24.113194	\N
307728	4544	316	2014-12-07 16:17:24.140825	\N
307729	4545	316	2014-12-07 16:17:24.168485	\N
307730	4546	305	2014-12-07 16:17:24.196233	\N
307731	4547	333	2014-12-07 16:17:24.223865	\N
307732	4548	327	2014-12-07 16:17:24.251703	\N
307733	4549	327	2014-12-07 16:17:24.279242	\N
307734	4550	314	2014-12-07 16:17:24.307279	\N
307735	4551	319	2014-12-07 16:17:24.334863	\N
307736	4552	332	2014-12-07 16:17:24.365352	\N
307737	4553	333	2014-12-07 16:17:24.393149	\N
307738	4554	312	2014-12-07 16:17:24.420879	\N
307739	4555	324	2014-12-07 16:17:24.781837	\N
307740	4556	329	2014-12-07 16:17:24.815921	\N
307741	4557	337	2014-12-07 16:17:24.843904	\N
307742	4558	337	2014-12-07 16:17:24.872297	\N
307743	4559	336	2014-12-07 16:17:24.900987	\N
307744	4560	316	2014-12-07 16:17:25.208965	\N
307745	4561	320	2014-12-07 16:17:25.24186	\N
307746	4562	322	2014-12-07 16:17:25.269853	\N
307747	4563	324	2014-12-07 16:17:25.297942	\N
307748	4564	304	2014-12-07 16:17:25.325554	\N
307749	4565	316	2014-12-07 16:17:25.353743	\N
307750	4566	307	2014-12-07 16:17:25.381717	\N
307751	4567	325	2014-12-07 16:17:25.409532	\N
307752	4568	307	2014-12-07 16:17:25.437389	\N
307753	4569	307	2014-12-07 16:17:25.46696	\N
307754	4570	307	2014-12-07 16:17:25.498862	\N
307755	4571	305	2014-12-07 16:17:25.5324	\N
307756	4571	306	2014-12-07 16:17:25.535346	\N
307757	4572	305	2014-12-07 16:17:25.567786	\N
307758	4572	306	2014-12-07 16:17:25.570799	\N
307759	4573	305	2014-12-07 16:17:25.600033	\N
307760	4573	306	2014-12-07 16:17:25.603163	\N
307761	4574	304	2014-12-07 16:17:25.631756	\N
307762	4575	336	2014-12-07 16:17:25.660459	\N
307763	4576	321	2014-12-07 16:17:25.690919	\N
307764	4576	323	2014-12-07 16:17:25.694124	\N
307765	4577	316	2014-12-07 16:17:25.72247	\N
307766	4578	313	2014-12-07 16:17:25.754547	\N
307767	4578	316	2014-12-07 16:17:25.757596	\N
307768	4578	323	2014-12-07 16:17:25.760097	\N
307769	4579	328	2014-12-07 16:17:25.788224	\N
307770	4580	329	2014-12-07 16:17:25.817712	\N
307771	4581	310	2014-12-07 16:17:25.851064	\N
307772	4581	313	2014-12-07 16:17:25.854102	\N
307773	4581	316	2014-12-07 16:17:25.856482	\N
307774	4582	313	2014-12-07 16:17:25.886768	\N
307775	4582	315	2014-12-07 16:17:25.889785	\N
307776	4583	308	2014-12-07 16:17:25.921419	\N
307777	4583	319	2014-12-07 16:17:25.924218	\N
307778	4583	331	2014-12-07 16:17:25.926592	\N
307779	4584	307	2014-12-07 16:17:25.955509	\N
307780	4585	307	2014-12-07 16:17:25.985739	\N
307781	4586	320	2014-12-07 16:17:26.017184	\N
307782	4587	328	2014-12-07 16:17:26.047373	\N
307783	4588	321	2014-12-07 16:17:26.078681	\N
307784	4588	323	2014-12-07 16:17:26.081597	\N
307785	4589	311	2014-12-07 16:17:26.115698	\N
307786	4589	321	2014-12-07 16:17:26.118813	\N
307787	4589	323	2014-12-07 16:17:26.12115	\N
307788	4589	330	2014-12-07 16:17:26.123353	\N
307789	4590	315	2014-12-07 16:17:26.156754	\N
307790	4590	330	2014-12-07 16:17:26.162007	\N
307791	4591	314	2014-12-07 16:17:26.195543	\N
307792	4591	325	2014-12-07 16:17:26.19838	\N
307793	4591	328	2014-12-07 16:17:26.2007	\N
307794	4591	333	2014-12-07 16:17:26.202943	\N
307795	4591	334	2014-12-07 16:17:26.205052	\N
307796	4592	327	2014-12-07 16:17:26.235981	\N
307797	4592	331	2014-12-07 16:17:26.239064	\N
307798	4593	331	2014-12-07 16:17:26.269831	\N
307799	4593	333	2014-12-07 16:17:26.27327	\N
307800	4594	307	2014-12-07 16:17:26.30384	\N
307801	4594	328	2014-12-07 16:17:26.306977	\N
307802	4595	311	2014-12-07 16:17:26.336898	\N
307803	4596	321	2014-12-07 16:17:26.36671	\N
307804	4597	304	2014-12-07 16:17:26.396056	\N
307805	4598	330	2014-12-07 16:17:26.426269	\N
307806	4599	329	2014-12-07 16:17:26.456785	\N
307807	4600	315	2014-12-07 16:17:26.488145	\N
307808	4601	330	2014-12-07 16:17:26.518884	\N
307809	4602	328	2014-12-07 16:17:26.549424	\N
307810	4603	309	2014-12-07 16:17:26.579342	\N
307811	4604	320	2014-12-07 16:17:26.610346	\N
307812	4605	327	2014-12-07 16:17:26.641502	\N
307813	4606	307	2014-12-07 16:17:26.67107	\N
307814	4607	309	2014-12-07 16:17:26.700646	\N
307815	4608	307	2014-12-07 16:17:26.73499	\N
307816	4609	324	2014-12-07 16:17:26.775047	\N
307817	4610	336	2014-12-07 16:17:27.183032	\N
307818	4611	336	2014-12-07 16:17:27.491616	\N
307819	4612	304	2014-12-07 16:17:27.868585	\N
307820	4612	304	2014-12-07 16:17:27.871436	\N
307821	4612	305	2014-12-07 16:17:27.873632	\N
307822	4612	305	2014-12-07 16:17:27.8758	\N
307823	4612	306	2014-12-07 16:17:27.877771	\N
307824	4612	307	2014-12-07 16:17:27.87986	\N
307825	4612	307	2014-12-07 16:17:27.881932	\N
307826	4612	307	2014-12-07 16:17:27.884089	\N
307827	4612	307	2014-12-07 16:17:27.886075	\N
307828	4612	308	2014-12-07 16:17:27.888111	\N
307829	4612	308	2014-12-07 16:17:27.890088	\N
307830	4612	310	2014-12-07 16:17:27.892119	\N
307831	4612	311	2014-12-07 16:17:27.894053	\N
307832	4612	312	2014-12-07 16:17:27.896129	\N
307833	4612	312	2014-12-07 16:17:27.898132	\N
307834	4612	312	2014-12-07 16:17:27.900142	\N
307835	4612	313	2014-12-07 16:17:27.902028	\N
307836	4612	314	2014-12-07 16:17:27.904034	\N
307837	4612	314	2014-12-07 16:17:27.905991	\N
307838	4612	315	2014-12-07 16:17:27.908046	\N
307839	4612	316	2014-12-07 16:17:27.910029	\N
307840	4612	316	2014-12-07 16:17:27.911988	\N
307841	4612	317	2014-12-07 16:17:27.91411	\N
307842	4612	318	2014-12-07 16:17:27.916072	\N
307843	4612	318	2014-12-07 16:17:27.918254	\N
307844	4612	319	2014-12-07 16:17:27.920455	\N
307845	4612	319	2014-12-07 16:17:27.922385	\N
307846	4612	319	2014-12-07 16:17:27.924436	\N
307847	4612	320	2014-12-07 16:17:27.926364	\N
307848	4612	321	2014-12-07 16:17:27.928493	\N
307849	4612	323	2014-12-07 16:17:27.930509	\N
307850	4612	325	2014-12-07 16:17:27.932514	\N
307851	4612	325	2014-12-07 16:17:27.934582	\N
307852	4612	325	2014-12-07 16:17:27.936657	\N
307853	4612	325	2014-12-07 16:17:27.938637	\N
307854	4612	326	2014-12-07 16:17:27.940623	\N
307855	4612	326	2014-12-07 16:17:27.942913	\N
307856	4612	327	2014-12-07 16:17:27.945013	\N
307857	4612	327	2014-12-07 16:17:27.946937	\N
307858	4612	327	2014-12-07 16:17:27.948913	\N
307859	4612	328	2014-12-07 16:17:27.951081	\N
307860	4612	328	2014-12-07 16:17:27.953059	\N
307861	4612	329	2014-12-07 16:17:27.955068	\N
307862	4612	330	2014-12-07 16:17:27.957368	\N
307863	4612	331	2014-12-07 16:17:27.959944	\N
307864	4612	331	2014-12-07 16:17:27.967204	\N
307865	4612	331	2014-12-07 16:17:27.973839	\N
307866	4612	332	2014-12-07 16:17:27.976248	\N
307867	4612	332	2014-12-07 16:17:27.978356	\N
307868	4612	333	2014-12-07 16:17:27.980588	\N
307869	4612	334	2014-12-07 16:17:27.98352	\N
307870	4612	334	2014-12-07 16:17:27.986246	\N
307871	4613	311	2014-12-07 16:17:28.295073	\N
307872	4613	315	2014-12-07 16:17:28.300238	\N
307873	4613	316	2014-12-07 16:17:28.303053	\N
307874	4613	330	2014-12-07 16:17:28.305397	\N
307875	4614	305	2014-12-07 16:17:28.335116	\N
307876	4614	319	2014-12-07 16:17:28.338145	\N
307877	4615	307	2014-12-07 16:17:28.367121	\N
307878	4616	308	2014-12-07 16:17:28.403329	\N
307879	4616	327	2014-12-07 16:17:28.406371	\N
307880	4616	332	2014-12-07 16:17:28.408724	\N
307881	4617	319	2014-12-07 16:17:28.437429	\N
307882	4618	327	2014-12-07 16:17:28.469721	\N
307883	4619	305	2014-12-07 16:17:28.498826	\N
307884	4620	317	2014-12-07 16:17:28.528485	\N
307885	4621	325	2014-12-07 16:17:28.558337	\N
307886	4621	328	2014-12-07 16:17:28.561164	\N
307887	4622	322	2014-12-07 16:17:28.591833	\N
307888	4623	316	2014-12-07 16:17:28.621065	\N
307889	4624	316	2014-12-07 16:17:28.651588	\N
307890	4625	322	2014-12-07 16:17:28.681073	\N
307891	4626	307	2014-12-07 16:17:28.711	\N
307892	4626	322	2014-12-07 16:17:28.71417	\N
307893	4627	314	2014-12-07 16:17:28.746746	\N
307894	4627	319	2014-12-07 16:17:28.74969	\N
307895	4627	333	2014-12-07 16:17:28.75182	\N
307896	4628	318	2014-12-07 16:17:28.782983	\N
307897	4628	327	2014-12-07 16:17:28.785787	\N
307898	4628	332	2014-12-07 16:17:28.787965	\N
307899	4629	307	2014-12-07 16:17:28.81821	\N
307900	4630	330	2014-12-07 16:17:28.846985	\N
307901	4631	304	2014-12-07 16:17:28.876349	\N
307902	4632	305	2014-12-07 16:17:28.905046	\N
307903	4633	305	2014-12-07 16:17:28.934096	\N
307904	4634	307	2014-12-07 16:17:28.966528	\N
307905	4635	307	2014-12-07 16:17:28.996406	\N
307906	4636	311	2014-12-07 16:17:29.026729	\N
307907	4637	311	2014-12-07 16:17:29.056217	\N
307908	4638	311	2014-12-07 16:17:29.086596	\N
307909	4639	319	2014-12-07 16:17:29.118451	\N
307910	4640	319	2014-12-07 16:17:29.147367	\N
307911	4641	319	2014-12-07 16:17:29.179211	\N
307912	4641	331	2014-12-07 16:17:29.182167	\N
307913	4642	321	2014-12-07 16:17:29.212273	\N
307914	4643	321	2014-12-07 16:17:29.242567	\N
307915	4644	325	2014-12-07 16:17:29.272513	\N
307916	4645	327	2014-12-07 16:17:29.30353	\N
307917	4646	331	2014-12-07 16:17:29.334833	\N
307918	4647	331	2014-12-07 16:17:29.365352	\N
307919	4648	331	2014-12-07 16:17:29.396993	\N
307920	4649	331	2014-12-07 16:17:29.427268	\N
307921	4650	331	2014-12-07 16:17:29.458369	\N
307922	4651	331	2014-12-07 16:17:29.49019	\N
307923	4652	331	2014-12-07 16:17:29.51995	\N
307924	4653	336	2014-12-07 16:17:29.550596	\N
307925	4654	336	2014-12-07 16:17:29.58109	\N
307926	4655	336	2014-12-07 16:17:29.611577	\N
307927	4656	336	2014-12-07 16:17:29.642341	\N
307928	4657	336	2014-12-07 16:17:29.672563	\N
307929	4658	336	2014-12-07 16:17:29.703799	\N
307930	4659	335	2014-12-07 16:17:29.735146	\N
307931	4660	336	2014-12-07 16:17:29.765628	\N
307932	4661	336	2014-12-07 16:17:29.79553	\N
307933	4662	336	2014-12-07 16:17:29.8271	\N
307934	4663	336	2014-12-07 16:17:29.858329	\N
307935	4664	336	2014-12-07 16:17:29.889181	\N
307936	4665	336	2014-12-07 16:17:29.919845	\N
307937	4666	336	2014-12-07 16:17:29.951031	\N
307938	4667	336	2014-12-07 16:17:29.981468	\N
307939	4668	336	2014-12-07 16:17:30.013221	\N
307940	4669	336	2014-12-07 16:17:30.043628	\N
307941	4670	336	2014-12-07 16:17:30.073699	\N
307942	4671	331	2014-12-07 16:17:30.104625	\N
307943	4672	331	2014-12-07 16:17:30.136332	\N
307944	4673	331	2014-12-07 16:17:30.167347	\N
307945	4674	336	2014-12-07 16:17:30.198365	\N
307946	4675	332	2014-12-07 16:17:30.228242	\N
307947	4676	333	2014-12-07 16:17:30.259189	\N
307948	4677	334	2014-12-07 16:17:30.289249	\N
307949	4678	334	2014-12-07 16:17:30.320617	\N
307950	4679	336	2014-12-07 16:17:30.791594	\N
307951	4680	336	2014-12-07 16:17:30.82794	\N
307952	4681	336	2014-12-07 16:17:30.858275	\N
307953	4682	336	2014-12-07 16:17:30.887691	\N
307954	4683	336	2014-12-07 16:17:30.918402	\N
307955	4684	320	2014-12-07 16:17:31.245627	\N
307956	4685	320	2014-12-07 16:17:31.280417	\N
307957	4686	307	2014-12-07 16:17:31.310951	\N
307958	4687	320	2014-12-07 16:17:31.34019	\N
307959	4688	320	2014-12-07 16:17:31.370627	\N
307960	4689	320	2014-12-07 16:17:31.401097	\N
307961	4690	320	2014-12-07 16:17:31.431602	\N
307962	4691	320	2014-12-07 16:17:31.46303	\N
307963	4692	309	2014-12-07 16:17:31.500664	\N
307964	4693	313	2014-12-07 16:17:31.848191	\N
307965	4693	316	2014-12-07 16:17:31.852488	\N
307966	4693	323	2014-12-07 16:17:31.855546	\N
307967	4694	319	2014-12-07 16:17:32.181906	\N
307968	4694	326	2014-12-07 16:17:32.187264	\N
307969	4695	336	2014-12-07 16:17:32.518395	\N
307970	4696	321	2014-12-07 16:17:32.874957	\N
307971	4696	323	2014-12-07 16:17:32.880532	\N
307972	4697	304	2014-12-07 16:17:33.215704	\N
307973	4698	304	2014-12-07 16:17:33.253149	\N
307974	4699	304	2014-12-07 16:17:33.285486	\N
307975	4700	304	2014-12-07 16:17:33.317262	\N
307976	4701	304	2014-12-07 16:17:33.349059	\N
307977	4702	304	2014-12-07 16:17:33.381374	\N
307978	4703	311	2014-12-07 16:17:33.413498	\N
307979	4704	311	2014-12-07 16:17:33.445829	\N
307980	4705	311	2014-12-07 16:17:33.503074	\N
307981	4706	311	2014-12-07 16:17:33.535083	\N
307982	4707	311	2014-12-07 16:17:33.567561	\N
307983	4708	312	2014-12-07 16:17:33.598264	\N
307984	4709	312	2014-12-07 16:17:33.6294	\N
307985	4710	312	2014-12-07 16:17:33.66106	\N
307986	4711	312	2014-12-07 16:17:33.693301	\N
307987	4712	314	2014-12-07 16:17:33.724659	\N
307988	4713	314	2014-12-07 16:17:33.756078	\N
307989	4714	315	2014-12-07 16:17:33.787958	\N
307990	4715	315	2014-12-07 16:17:33.82098	\N
307991	4716	315	2014-12-07 16:17:33.852728	\N
307992	4717	315	2014-12-07 16:17:33.884847	\N
307993	4718	316	2014-12-07 16:17:33.917432	\N
307994	4719	316	2014-12-07 16:17:33.95418	\N
307995	4720	317	2014-12-07 16:17:33.986107	\N
307996	4721	318	2014-12-07 16:17:34.01866	\N
307997	4722	319	2014-12-07 16:17:34.051004	\N
307998	4723	319	2014-12-07 16:17:34.083093	\N
307999	4724	321	2014-12-07 16:17:34.116073	\N
308000	4725	321	2014-12-07 16:17:34.149089	\N
308001	4726	321	2014-12-07 16:17:34.18105	\N
308002	4727	321	2014-12-07 16:17:34.213585	\N
308003	4728	321	2014-12-07 16:17:34.24618	\N
308004	4729	323	2014-12-07 16:17:34.277358	\N
308005	4730	323	2014-12-07 16:17:34.309616	\N
308006	4731	326	2014-12-07 16:17:34.342231	\N
308007	4732	327	2014-12-07 16:17:34.373591	\N
308008	4733	327	2014-12-07 16:17:34.40596	\N
308009	4734	327	2014-12-07 16:17:34.437683	\N
308010	4735	327	2014-12-07 16:17:34.472595	\N
308011	4736	327	2014-12-07 16:17:34.505143	\N
308012	4737	327	2014-12-07 16:17:34.538585	\N
308013	4738	328	2014-12-07 16:17:34.571478	\N
308014	4739	330	2014-12-07 16:17:34.604127	\N
308015	4740	331	2014-12-07 16:17:34.636701	\N
308016	4741	332	2014-12-07 16:17:34.669169	\N
308017	4742	332	2014-12-07 16:17:34.701751	\N
308018	4743	332	2014-12-07 16:17:34.742743	\N
308019	4744	332	2014-12-07 16:17:34.776412	\N
308020	4745	334	2014-12-07 16:17:34.807489	\N
308021	4746	331	2014-12-07 16:17:35.251928	\N
308022	4747	304	2014-12-07 16:17:35.283947	\N
308023	4748	319	2014-12-07 16:17:35.317857	\N
308024	4749	328	2014-12-07 16:17:35.348361	\N
308025	4750	306	2014-12-07 16:17:35.379313	\N
308026	4751	318	2014-12-07 16:17:35.411356	\N
308027	4751	332	2014-12-07 16:17:35.414699	\N
308028	4752	320	2014-12-07 16:17:35.44799	\N
308029	4753	318	2014-12-07 16:17:35.489088	\N
308030	4754	333	2014-12-07 16:17:35.527247	\N
308031	4755	306	2014-12-07 16:17:35.569458	\N
308032	4755	309	2014-12-07 16:17:35.573007	\N
308033	4756	314	2014-12-07 16:17:35.608889	\N
308034	4757	324	2014-12-07 16:17:35.649114	\N
308035	4758	315	2014-12-07 16:17:35.688158	\N
308036	4759	336	2014-12-07 16:17:36.131712	\N
308037	4760	304	2014-12-07 16:17:36.542673	\N
308038	4761	305	2014-12-07 16:17:36.584925	\N
308039	4762	306	2014-12-07 16:17:36.623939	\N
308040	4763	307	2014-12-07 16:17:36.664865	\N
308041	4764	308	2014-12-07 16:17:36.707598	\N
308042	4765	309	2014-12-07 16:17:36.76312	\N
308043	4766	310	2014-12-07 16:17:36.812352	\N
308044	4767	311	2014-12-07 16:17:36.856381	\N
308045	4768	312	2014-12-07 16:17:36.900727	\N
308046	4769	313	2014-12-07 16:17:36.942629	\N
308047	4770	314	2014-12-07 16:17:36.985974	\N
308048	4771	315	2014-12-07 16:17:37.025872	\N
308049	4772	316	2014-12-07 16:17:37.069985	\N
308050	4773	317	2014-12-07 16:17:37.111601	\N
308051	4774	318	2014-12-07 16:17:37.159629	\N
308052	4775	319	2014-12-07 16:17:37.199634	\N
308053	4776	320	2014-12-07 16:17:37.237198	\N
308054	4777	321	2014-12-07 16:17:37.27843	\N
308055	4778	322	2014-12-07 16:17:37.315225	\N
308056	4779	323	2014-12-07 16:17:37.357725	\N
308057	4780	324	2014-12-07 16:17:37.40604	\N
308058	4781	325	2014-12-07 16:17:37.44501	\N
308059	4782	326	2014-12-07 16:17:37.485194	\N
308060	4783	327	2014-12-07 16:17:37.558779	\N
308061	4784	328	2014-12-07 16:17:37.637533	\N
308062	4785	335	2014-12-07 16:17:37.675375	\N
308063	4786	329	2014-12-07 16:17:37.714722	\N
308064	4787	330	2014-12-07 16:17:37.756199	\N
308065	4788	331	2014-12-07 16:17:37.791775	\N
308066	4789	332	2014-12-07 16:17:37.830042	\N
308067	4790	333	2014-12-07 16:17:37.867717	\N
308068	4791	334	2014-12-07 16:17:37.909652	\N
308069	4792	336	2014-12-07 16:17:38.339932	\N
308070	4793	335	2014-12-07 16:17:38.694971	\N
308071	4794	336	2014-12-07 16:17:39.051147	\N
308072	4795	336	2014-12-07 16:17:39.407936	\N
308073	4796	304	2014-12-07 16:17:39.988813	\N
308074	4796	305	2014-12-07 16:17:39.991793	\N
308075	4796	306	2014-12-07 16:17:39.994091	\N
308076	4796	307	2014-12-07 16:17:39.996216	\N
308077	4796	308	2014-12-07 16:17:39.998348	\N
308078	4796	309	2014-12-07 16:17:40.000466	\N
308079	4796	310	2014-12-07 16:17:40.002571	\N
308080	4796	311	2014-12-07 16:17:40.004773	\N
308081	4796	312	2014-12-07 16:17:40.007203	\N
308082	4796	313	2014-12-07 16:17:40.009933	\N
308083	4796	314	2014-12-07 16:17:40.012429	\N
308084	4796	315	2014-12-07 16:17:40.014568	\N
308085	4796	316	2014-12-07 16:17:40.016692	\N
308086	4796	317	2014-12-07 16:17:40.018985	\N
308087	4796	318	2014-12-07 16:17:40.021098	\N
308088	4796	319	2014-12-07 16:17:40.023104	\N
308089	4796	320	2014-12-07 16:17:40.025171	\N
308090	4796	321	2014-12-07 16:17:40.027208	\N
308091	4796	322	2014-12-07 16:17:40.029204	\N
308092	4796	323	2014-12-07 16:17:40.031148	\N
308093	4796	324	2014-12-07 16:17:40.033122	\N
308094	4796	325	2014-12-07 16:17:40.035076	\N
308095	4796	326	2014-12-07 16:17:40.037038	\N
308096	4796	327	2014-12-07 16:17:40.038984	\N
308097	4796	328	2014-12-07 16:17:40.040997	\N
308098	4796	329	2014-12-07 16:17:40.043046	\N
308099	4796	330	2014-12-07 16:17:40.045195	\N
308100	4796	331	2014-12-07 16:17:40.04717	\N
308101	4796	332	2014-12-07 16:17:40.049246	\N
308102	4796	333	2014-12-07 16:17:40.051161	\N
308103	4796	334	2014-12-07 16:17:40.053115	\N
308104	4796	335	2014-12-07 16:17:40.055077	\N
308105	4797	336	2014-12-07 16:17:40.416894	\N
308106	4798	336	2014-12-07 16:17:40.452523	\N
308107	4799	336	2014-12-07 16:17:40.486874	\N
308108	4800	336	2014-12-07 16:17:40.518983	\N
308109	4801	336	2014-12-07 16:17:40.552928	\N
308110	4802	336	2014-12-07 16:17:40.584525	\N
308111	4803	336	2014-12-07 16:17:40.616471	\N
308112	4804	336	2014-12-07 16:17:40.649595	\N
308113	4805	304	2014-12-07 16:17:41.13377	\N
308114	4805	305	2014-12-07 16:17:41.136524	\N
308115	4805	306	2014-12-07 16:17:41.138698	\N
308116	4805	307	2014-12-07 16:17:41.143655	\N
308117	4805	308	2014-12-07 16:17:41.147103	\N
308118	4805	309	2014-12-07 16:17:41.14937	\N
308119	4805	310	2014-12-07 16:17:41.151622	\N
308120	4805	311	2014-12-07 16:17:41.153775	\N
308121	4805	312	2014-12-07 16:17:41.155822	\N
308122	4805	313	2014-12-07 16:17:41.157827	\N
308123	4805	314	2014-12-07 16:17:41.160132	\N
308124	4805	315	2014-12-07 16:17:41.162328	\N
308125	4805	316	2014-12-07 16:17:41.164523	\N
308126	4805	317	2014-12-07 16:17:41.166597	\N
308127	4805	318	2014-12-07 16:17:41.168666	\N
308128	4805	319	2014-12-07 16:17:41.170764	\N
308129	4805	320	2014-12-07 16:17:41.172847	\N
308130	4805	321	2014-12-07 16:17:41.174864	\N
308131	4805	322	2014-12-07 16:17:41.17692	\N
308132	4805	323	2014-12-07 16:17:41.179042	\N
308133	4805	324	2014-12-07 16:17:41.181274	\N
308134	4805	325	2014-12-07 16:17:41.183226	\N
308135	4805	326	2014-12-07 16:17:41.185304	\N
308136	4805	327	2014-12-07 16:17:41.187246	\N
308137	4805	328	2014-12-07 16:17:41.189257	\N
308138	4805	329	2014-12-07 16:17:41.191274	\N
308139	4805	330	2014-12-07 16:17:41.193317	\N
308140	4805	331	2014-12-07 16:17:41.19535	\N
308141	4805	332	2014-12-07 16:17:41.19742	\N
308142	4805	333	2014-12-07 16:17:41.199671	\N
308143	4805	334	2014-12-07 16:17:41.201939	\N
308144	4805	335	2014-12-07 16:17:41.204144	\N
308145	4806	336	2014-12-07 16:17:41.588501	\N
308146	4807	336	2014-12-07 16:17:41.965222	\N
308147	4808	336	2014-12-07 16:17:42.34436	\N
308148	4809	336	2014-12-07 16:17:42.732531	\N
308149	4810	336	2014-12-07 16:17:43.14308	\N
308150	4811	336	2014-12-07 16:17:43.18146	\N
308151	4812	336	2014-12-07 16:17:43.213622	\N
308152	4813	336	2014-12-07 16:17:43.24697	\N
308153	4814	336	2014-12-07 16:17:43.279057	\N
308154	4815	336	2014-12-07 16:17:43.678043	\N
308155	4816	336	2014-12-07 16:17:44.072949	\N
308156	4817	336	2014-12-07 16:17:44.479636	\N
308157	4818	336	2014-12-07 16:17:44.895076	\N
308158	4819	336	2014-12-07 16:17:44.932024	\N
308159	4820	336	2014-12-07 16:17:44.964874	\N
\.


--
-- Name: project_prefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_prefecture_id_seq', 308159, true);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY role (id, name) FROM stdin;
0	superadmin
1	admin
2	organization
3	user
4	webapi
5	lol
6	management
\.


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_id_seq', 10, true);


--
-- Data for Name: secretary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY secretary (id, acronym, name, created_at) FROM stdin;
2	SMADS	Secretaria Municipal de Assistência Social	2014-11-11 13:44:39.729246
5	SDTE	Secretaria Municipal de Desenvolvimento, Trabalho e Empreendedorismo	2014-11-11 13:45:14.281534
8	SME	Secretaria Municipal de Educação	2014-11-11 13:45:14.380841
18	SMS	Secretaria Municipal de Saúde	2014-11-11 13:45:15.12473
7	SMDHC	Secretaria Municipal de Direitos Humanos e Cidadania	2014-11-11 13:45:15.415422
4	SMC	Secretaria Municipal de Cultura	2014-11-11 13:45:27.577292
11	SEHAB	Secretaria Municipal de Habitação	2014-11-11 13:45:29.187315
19	SMSU	Secretaria Municipal de Segurança Urbana	2014-11-11 13:45:42.575695
15	SMPM	Secretaria Municipal de Políticas para as Mulheres	2014-11-11 13:45:42.980484
9	SEME	Secretaria Municipal de Esportes	2014-11-11 13:45:45.156671
3	SMSP	Secretaria Municipal de Coordenação das Subprefeituras	2014-11-11 13:45:48.934286
21	SMT	Secretaria Municipal de Tranportes	2014-11-11 13:45:49.627964
13	SMPED	Secretaria Municipal da Pessoa com Deficiência e Mobilidade Reduzida	2014-11-11 13:45:50.09778
16	SMPIR	Secretaria Municipal de Promoção de Igualdade Racial	2014-11-11 13:45:51.886861
6	SMDU	Secretaria Municipal de Desenvolvimento Urbano	2014-11-11 13:45:58.179702
20	SES	Secretaria Municipal de Serviços	2014-11-11 13:45:58.579875
12	SIURB	Secretaria Municipal de Infraestrutura e Obras	2014-11-11 13:46:01.54725
10	SF	Secretaria Municipal de Finanças e Desenvolvimento Econômico	2014-11-11 13:46:04.628656
22	SVMA	Secretaria Municipal do Verde e Meio Ambiente	2014-11-11 13:46:06.135279
1	SECOM	Secretaria Executiva de Comunicação	2014-11-11 13:46:32.9737
17	SMRG	Secretaria Municipal de Relações Governamentais	2014-11-11 13:46:36.342845
14	SEMPLA	Secretaria Municipal de Planejamento, Orçamento e Gestão	2014-11-11 13:46:37.45189
\.


--
-- Name: secretary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('secretary_id_seq', 1, true);


--
-- Data for Name: state; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY state (id, name, uf, country_id, created_by) FROM stdin;
1	Acre	AC	1	1
2	Alagoas	AL	1	1
3	Amapá	AP	1	1
4	Amazonas	AM	1	1
5	Bahia	BA	1	1
6	Ceará	CE	1	1
7	Distrito Federal	DF	1	1
8	Espírito Santo	ES	1	1
9	Goiás	GO	1	1
10	Maranhão	MA	1	1
11	Mato Grosso	MT	1	1
12	Mato Grosso do Sul	MS	1	1
13	Minas Gerais	MG	1	1
14	Pará	PA	1	1
15	Paraíba	PB	1	1
16	Paraná	PR	1	1
17	Pernambuco	PE	1	1
18	Piauí	PI	1	1
19	Rio de Janeiro	RJ	1	1
20	Rio Grande do Norte	RN	1	1
21	Rio Grande do Sul	RS	1	1
22	Rondônia	RO	1	1
23	Roraima	RR	1	1
24	Santa Catarina	SC	1	1
25	São Paulo	SP	1	1
26	Sergipe	SE	1	1
27	Tocantins	TO	1	1
\.


--
-- Name: state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('state_id_seq', 2, false);


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY status (id, description) FROM stdin;
\.


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('status_id_seq', 1, false);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "user" (id, name, email, active, created_at, password, created_by, type, organization_id) FROM stdin;
1	superadmin	superadmin@email.com	t	2014-08-23 22:51:58.771539	$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW	\N	\N	\N
2	webapi-1	no email	t	2014-08-23 22:51:58.817223	no password	\N	\N	\N
3	admin	admin@email.com	t	2014-08-23 22:51:58.818241	$2a$08$Hys9hzza605zZVKNJvdiBe9bHfdB4JKFnG8douGv53IW4e9M5cKrW	\N	\N	\N
11	renan	renan.azevedo.carvalho@gmail.com	t	2014-08-27 13:08:29.718783	$2a$08$X2F4cDsihstyK.9SZEpE.OJ2bS7Q9.lzSCqxT3G6hGTnqu/QhXNIe	\N	\N	5
15	ONG Controle	teste@email.com	t	2014-08-31 11:37:35.669426	$2a$08$fInPrclNwK00oJ6hAg1l3.BFkfs/910zyAx2aUCe5.tdRnLWdw6EC	\N	\N	\N
16	foo	bar@email.com	t	2014-08-31 11:57:33.817972	$2a$08$XiNcMMQZyDKfFGHdg3s1kuBDw6hYAwedsnZ58lshbEUXtBor5IXXK	\N	\N	\N
17	foobar	rag@email.com	t	2014-08-31 11:58:25.711156	$2a$08$4n9sOr7tkHkM2An5gTj7tuXjbhhqLtv8JwMKm6heGOGqSTG40tHN.	\N	\N	\N
23	foo	foo@email.com	t	2014-10-21 12:32:50.627036	$2a$08$Ug1551XWLpfqC5HdiM8LwePnA4vrxoNcbcRxqW7zyB6k2HFPCf63i	\N	\N	\N
24	teste	lol@email.com	t	2014-10-21 12:38:43.502126	$2a$08$jAKMdjSy3aEG/Z8iCR5i5eIIYJ2UtIOugGQisEskaZJ0hlDGJw3Py	\N	\N	\N
25	asas	kkk@email.com	t	2014-10-21 12:44:42.506097	$2a$08$ViXm8cViGSBaoKo3KVYAKO3iZ0S2Eya.rbECF.uuMxUMKRCF4xfAq	\N	\N	\N
26	asasas	11111@email.com	t	2014-10-21 14:02:26.418448	$2a$08$mHStZepVqGKy0.utmUIsu.hCkaeS6YDzWgW0X7Cf5sWThbwmJMFZm	\N	\N	\N
27	fffff	fff@email.com	t	2014-10-21 14:03:57.496803	$2a$08$kvOcvRJtrb/7py3rDDj2Ge5Y9r00lX3xhXvI/kCBYalsFlJ/080dq	\N	\N	\N
28	renan	email@email.com	t	2014-11-12 05:48:38.809886	$2a$08$8dZY78w52mwJakkZygU9n.u5.5/X0dIKflZzcLbjztX7Y.yuPEwwK	\N	\N	\N
29	ong3	on3@gmail.com	t	2014-11-12 06:04:45.148842	$2a$08$/llzghgUwJMVfd8CZRjAC.e4QQUHaS3mxrGu.zizMmVTS/.mKZ4a.	\N	\N	\N
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_id_seq', 29, true);


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_role (id, user_id, role_id) FROM stdin;
34	1	0
35	2	4
36	3	1
37	11	2
41	15	2
42	16	1
43	17	1
49	23	1
50	24	1
51	25	1
53	27	1
54	28	1
55	29	2
\.


--
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_role_id_seq', 55, true);


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_session (id, user_id, api_key, valid_for_ip, valid_until, ts_created) FROM stdin;
25	3	9b5e76692fcb6fe606f29846e7099d29a70c71f4	127.0.0.1	2014-08-24 22:59:00.382768	2014-08-23 22:59:00.382768
24	2	p01IpoDpNjPAzB8azQVTcK7v450u1EAjlnFu0J0DPbDz6uuMVgSsFst8wDRF17v9qOcGP8mK6wJfAOMwnRDMhHmsnK84Tma20kdC	127.0.0.1	2020-01-01 00:00:00	2014-08-23 22:51:58.824226
26	1	43da392972b79de6a474fd91058854a83fb1e6f9	127.0.0.1	2014-08-24 23:35:57.97692	2014-08-23 23:35:57.97692
27	3	984e118d5b2d3ea1eae0485eda8038aa16e70ad0	127.0.0.1	2014-08-24 23:36:14.08784	2014-08-23 23:36:14.08784
28	3	c4ce324b89911d72f0afea72a806532a19ac10d4	127.0.0.1	2014-08-26 10:08:56.708042	2014-08-25 10:08:56.708042
29	3	ed028afb029162d9305a41736e67ade5d9188795	127.0.0.1	2014-08-26 15:01:27.409688	2014-08-25 15:01:27.409688
30	3	ea711f752e58f20ff9b34926e1567fd617ed5fdb	127.0.0.1	2014-08-26 15:06:55.272432	2014-08-25 15:06:55.272432
31	3	ea2d1456f19f110b566b7ec9f2067bd4b4c678fd	127.0.0.1	2014-08-26 23:06:09.577781	2014-08-25 23:06:09.577781
32	3	27b7982b9042b9a8e0383ccaaa41c087b5bc59ce	127.0.0.1	2014-08-26 23:56:21.787461	2014-08-25 23:56:21.787461
33	3	87d5961ad00495cddf479366090dcb5c0036f8c3	127.0.0.1	2014-08-28 11:48:13.099505	2014-08-27 11:48:13.099505
34	3	c7248ed83c90cecdf3e8a18d941a2d1f35aa4ccc	127.0.0.1	2014-08-28 12:56:52.093631	2014-08-27 12:56:52.093631
35	1	0b3c162c4f079a371705736ff3f13def7e230910	127.0.0.1	2014-08-28 14:48:47.036065	2014-08-27 14:48:47.036065
36	1	2262561fc52fa92154c817345d5026ea7f4e920f	127.0.0.1	2014-08-28 14:50:13.538088	2014-08-27 14:50:13.538088
37	1	76e8c306bcfa13d75d3f72ce68eefabf1e188bc9	127.0.0.1	2014-08-28 14:52:59.626352	2014-08-27 14:52:59.626352
38	1	f19b240e3c2234f107ec46b8b747b636ac275338	127.0.0.1	2014-08-28 14:54:23.677253	2014-08-27 14:54:23.677253
39	3	ff98ed27c9d91f7579b5a3126a1a7815db3c12ec	127.0.0.1	2014-08-28 14:56:29.926056	2014-08-27 14:56:29.926056
40	3	eabcfb1d21c2af09d56c9c07ca58cb9f694b3aa4	127.0.0.1	2014-08-28 15:38:15.700445	2014-08-27 15:38:15.700445
41	3	c9503e8324fab7e54dd607e0f5ad73821df823e2	127.0.0.1	2014-08-30 00:26:28.865034	2014-08-29 00:26:28.865034
42	3	c13ed18fbc91aff7506f59cfb1a0e79247094c67	127.0.0.1	2014-08-30 00:27:59.341919	2014-08-29 00:27:59.341919
43	3	b45be57d9ac8ff8b1a364c1bfe2391f204a717af	127.0.0.1	2014-08-30 00:28:39.752271	2014-08-29 00:28:39.752271
44	3	d17194e533fdd5693e17473344fb493bd906d3a6	127.0.0.1	2014-08-30 01:33:47.329458	2014-08-29 01:33:47.329458
45	3	b28b530cc2036bf44873f78741bc6478479bc983	127.0.0.1	2014-08-31 10:17:24.326068	2014-08-30 10:17:24.326068
46	3	d69137a10f5ebc84159a19050037b05de97e47d2	127.0.0.1	2014-08-31 11:51:44.051031	2014-08-30 11:51:44.051031
47	3	eb9686d45c126f3e64b9b01924d2605425e0adf4	127.0.0.1	2014-08-31 14:59:07.649974	2014-08-30 14:59:07.649974
48	3	4c7e1cc5d4c30ad2ca53a7a98ddf8362460252f1	127.0.0.1	2014-08-31 16:26:01.473212	2014-08-30 16:26:01.473212
49	3	8af47dae178e2295b6ecabfe9ec9997f79f6ab4c	127.0.0.1	2014-09-01 11:34:46.815637	2014-08-31 11:34:46.815637
50	3	0453596c71f22a8a4b99b32d02aa41ac0965d8ea	127.0.0.1	2014-09-01 18:25:23.482799	2014-08-31 18:25:23.482799
51	3	8637281da77e58e581f8ad45b0727b12e2abbefc	127.0.0.1	2014-09-01 20:43:25.608471	2014-08-31 20:43:25.608471
52	3	3688a141164349f37f842cbf4600bc7a90b308b4	127.0.0.1	2014-09-02 04:38:02.538035	2014-09-01 04:38:02.538035
53	3	fefd6c46b2b5b818c79f9446a30b7aea7ed9a8d2	127.0.0.1	2014-09-02 10:34:55.813094	2014-09-01 10:34:55.813094
54	3	ba96b55a90cf9700cd684b38cd09e0302564d1b7	127.0.0.1	2014-09-02 14:10:51.149058	2014-09-01 14:10:51.149058
55	3	545ef96463c0ce2df58bbad9dfacc4134899ed82	127.0.0.1	2014-09-02 16:11:22.197867	2014-09-01 16:11:22.197867
56	3	4b83c326cbf1060f31fb6627a301288e0bf19c32	127.0.0.1	2014-09-23 12:23:23.244977	2014-09-22 12:23:23.244977
57	3	ca43eab6087e739c4fd0ea5d122508a396319651	127.0.0.1	2014-10-07 12:12:08.447701	2014-10-06 12:12:08.447701
58	3	59093e29c4ba6c583574ad76f3e1c4d8c82343ac	127.0.0.1	2014-10-08 09:43:33.174989	2014-10-07 09:43:33.174989
59	3	a5c26152365e4ca2750c0f55714c1bd3c635d24d	127.0.0.1	2014-10-09 06:55:55.870656	2014-10-08 06:55:55.870656
60	3	e9bcc04382dc122c1ac6b2b51a2e7dd3c4164f13	127.0.0.1	2014-10-09 21:30:56.142532	2014-10-08 21:30:56.142532
61	3	ebcca932b80310744281171fa9a6b341355f556b	127.0.0.1	2014-10-10 12:14:05.453298	2014-10-09 12:14:05.453298
62	3	cf86e072957651af73ebe565f812a86456ef4e22	127.0.0.1	2014-10-10 12:29:54.893658	2014-10-09 12:29:54.893658
63	3	4e5e355d47566c9d6fba02c96ed75cc9b6a4a568	127.0.0.1	2014-10-10 12:39:01.296084	2014-10-09 12:39:01.296084
64	3	22e7a20c8f0e53535a0afb79bca9c9c384bef80a	127.0.0.1	2014-10-16 13:04:10.648298	2014-10-15 13:04:10.648298
65	3	f7d5ad8f968adcdf8e3a00a130f31f92bd48f786	127.0.0.1	2014-10-22 10:55:26.447113	2014-10-21 10:55:26.447113
66	3	74c06aaed869afd174fb14ebf9ad7e6e87b8bd75	127.0.0.1	2014-10-22 12:32:31.44967	2014-10-21 12:32:31.44967
67	3	cd4c92c0c7128cb243905bb345b56ed59aef67d4	127.0.0.1	2014-10-22 14:02:07.56777	2014-10-21 14:02:07.56777
68	3	e1cc6de6b35ae735711bd69698131350c78db2d6	127.0.0.1	2014-10-22 14:14:01.38208	2014-10-21 14:14:01.38208
69	3	40c309b0775747f7f1542355179c06394f4d2f2c	127.0.0.1	2014-10-24 09:32:59.491918	2014-10-23 09:32:59.491918
70	3	6dd1a6b343195a84f5eb27ea80bd48832e43be08	127.0.0.1	2014-10-24 09:41:26.080386	2014-10-23 09:41:26.080386
71	3	2f587dc905908f86274ede7ea1a328bab8732ccd	127.0.0.1	2014-10-24 10:06:19.571224	2014-10-23 10:06:19.571224
72	3	1de4746e3b09214ab5d1573284329296a221a7d2	127.0.0.1	2014-10-24 10:08:39.307687	2014-10-23 10:08:39.307687
73	3	374e41337d3d5f2968092e57828b2531e0313e39	127.0.0.1	2014-10-24 10:45:57.688382	2014-10-23 10:45:57.688382
74	3	2b0fbbf66cbf390e55afd49d1451480162583166	127.0.0.1	2014-10-29 08:15:08.993574	2014-10-28 08:15:08.993574
75	3	a6998b3540f788acf5804a7d437a3945194dba12	127.0.0.1	2014-10-30 08:48:49.771297	2014-10-29 08:48:49.771297
76	3	21093059d2f5368502fba55a2f3b1a87b42b364c	127.0.0.1	2014-11-04 05:30:05.660746	2014-11-03 05:30:05.660746
77	3	4d2d029cfdc61557239e5a11ea22654240fb24b1	127.0.0.1	2014-11-04 10:01:55.082892	2014-11-03 10:01:55.082892
78	3	d0d8277bfbfb4e64bf98fbaa9ab2ad61490cd615	127.0.0.1	2014-11-12 06:00:34.196272	2014-11-11 06:00:34.196272
79	3	e3868ad7ea323fb10069acb96877b97ea41857ee	127.0.0.1	2014-11-12 07:40:29.663824	2014-11-11 07:40:29.663824
80	3	f85f4c8d28bc4f2a3f3a913755738867c69c2775	127.0.0.1	2014-11-12 09:07:00.359983	2014-11-11 09:07:00.359983
81	3	a0509ede593640f735dadfaa525759ed0817fd0a	127.0.0.1	2014-11-13 04:35:08.233398	2014-11-12 04:35:08.233398
82	3	2bb0e91f5fdf59a9041c05fbec5974e5685b4521	127.0.0.1	2014-11-13 05:57:18.902663	2014-11-12 05:57:18.902663
83	3	ce7bf6a8829ee7d6c1618a5f439de79566d93fce	127.0.0.1	2014-11-13 06:03:53.130738	2014-11-12 06:03:53.130738
84	3	ea0fbc860e372cd018a58167972bc2d2543957ac	127.0.0.1	2014-12-08 17:30:39.719536	2014-12-07 17:30:39.719536
\.


--
-- Name: user_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_session_id_seq', 84, true);


SET search_path = sqitch, pg_catalog;

--
-- Data for Name: changes; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY changes (change_id, change, project, note, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
d860568345fbd99a34a93bd0673eb783ec8a6001	appschema	smm	schema tables, types and views	2014-08-22 13:06:10.628744-07	development,,,	renan@ubuntu	2013-09-18 09:45:46-07	cron	renato.cron@gmail.com
\.


--
-- Data for Name: dependencies; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY dependencies (change_id, type, dependency, dependency_id) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY events (event, change_id, change, project, note, requires, conflicts, tags, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
deploy	d860568345fbd99a34a93bd0673eb783ec8a6001	appschema	smm	schema tables, types and views	{}	{}	{}	2014-08-22 13:06:10.665016-07	development,,,	renan@ubuntu	2013-09-18 09:45:46-07	cron	renato.cron@gmail.com
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY projects (project, uri, created_at, creator_name, creator_email) FROM stdin;
smm	https://github.com/AwareTI/SMM	2014-08-22 13:06:10.163631-07	development,,,	renan@ubuntu
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: sqitch; Owner: postgres
--

COPY tags (tag_id, tag, project, change_id, note, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- Name: city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


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
-- Name: goal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_pkey PRIMARY KEY (id);


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
-- Name: management_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY management
    ADD CONSTRAINT management_pkey PRIMARY KEY (id);


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
-- Name: user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


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
-- Name: city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


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
-- Name: goal_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


--
-- Name: goal_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(id);


--
-- Name: goal_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_district_id_fkey FOREIGN KEY (district_id) REFERENCES district(id);


--
-- Name: goal_management_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_management_id_fkey FOREIGN KEY (management_id) REFERENCES management(id);


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
-- Name: goal_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_state_id_fkey FOREIGN KEY (state_id) REFERENCES state(id);


--
-- Name: goal_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_status_id_fkey FOREIGN KEY (status_id) REFERENCES status(id);


--
-- Name: goal_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY goal
    ADD CONSTRAINT goal_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: management_fk_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY management
    ADD CONSTRAINT management_fk_city_id FOREIGN KEY (city_id) REFERENCES city(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


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


--
-- PostgreSQL database dump complete
--

