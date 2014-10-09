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
    transversality text NOT NULL,
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
    origin text
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
    city_id integer NOT NULL
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

ALTER TABLE ONLY organization ALTER COLUMN id SET DEFAULT nextval('organization_id_seq'::regclass);


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

COPY goal (id, name, will_be_delivered, description, technically, transversality, expected_start_date, expected_end_date, start_date, end_date, porcentage, management_id, user_id, created_at, update_at, country_id, state_id, city_id, district_id, lat_lng, status_id, original_link, keywords, expected_budget, real_value_expended, origin) FROM stdin;
1	Inserir aproximadamente 280 mil famílias com renda de até meio salário mínimo no Cadastro Único para atingir 773 mil famílias cadastradas	280 mil famílias inscritas no Cadastro Único	Prioridade para implementação das ações nas Subprefeituras com maior concentração de famílias em situação de extrema pobreza e pobreza. Busca Ativa apoiada pelas áreas de interface e sociedade civil. Disponibilização de espaços públicos e equipamentos municipais para ações cadastrais.	Cadastro Único para Programas Sociais do Governo Federal (Cadastro Único): é um instrumento que identifica e caracteriza as famílias de baixa renda (renda mensal de até meio salário mínimo por pessoa ou renda mensal total de até três salários mínimos). Ele é utilizado por mais de 15 programas sociais do Governo Federal, como o Bolsa Família, Minha Casa Minha Vida, PRONATEC, Tarifa Social de Energia Elétrica, Brasil Carinhoso, etc. Busca Ativa: estratégia do Plano Brasil Sem Miséria que tem como objetivo levar o Estado ao cidadão, sem esperar que as pessoas mais pobres cheguem até o poder público. Um dos grandes desafios do Brasil Sem Miséria é alcançar aqueles que não acessam os serviços públicos e vivem fora de qualquer rede de proteção social.	juventude-viva                                                                sp-carinhosa                                   pop rua	\N	\N	\N	\N	\N	\N	\N	2014-10-06 23:47:57.455511	\N	\N	\N	\N	\N	\N	\N	\N	\N	103305927	\N	\N
\.


--
-- Name: goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_id_seq', 1, false);


--
-- Data for Name: goal_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal_project (id, goal_id, project_id, created_at, updated_at) FROM stdin;
1	1	1669	2014-10-06 23:47:57.461412	\N
\.


--
-- Name: goal_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_project_id_seq', 1, true);


--
-- Data for Name: goal_secretary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY goal_secretary (id, goal_id, secretary_id, created_at, update_at) FROM stdin;
\.


--
-- Name: goal_secretary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('goal_secretary_id_seq', 1, false);


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
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organization (id, name, address, postal_code, city_id, description, email, website, phone, number, complement) FROM stdin;
5	ONG CMA	martins	12312312	1	Controle de Metas	renan.azevedo.carvalho@gmail.com	www.gogle.com	(12) 21312-3123	1234	asdasdasdasd
7	ONG Controle	rua foo	123131231	1	Controle de Metas	teste@email.com	teste.com.br	(12) 99999-9999	80912	holanda
\.


--
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organization_id_seq', 7, true);


--
-- Data for Name: prefecture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY prefecture (id, name, acronym, created_at, updated_at, latitude, longitude) FROM stdin;
1	Aricanduva/Formosa/Carrão	AF	2014-10-06 23:47:57.06133	\N	-23.549884	-46.536692
2	Butantã	BT	2014-10-06 23:47:57.074573	\N	-23.588369	-46.738026
3	Campo Limpo	CL	2014-10-06 23:47:57.085299	\N	-23.647178	-46.756453
4	Capela do Socorro	CS	2014-10-06 23:47:57.095261	\N	-23.719853	-46.701631
5	Casa Verde/Cachoeirinha	CV	2014-10-06 23:47:57.103359	\N	-23.518827	-46.667202
6	Cidade Ademar	AD	2014-10-06 23:47:57.111513	\N	-23.667083	-46.675166
7	Cidade Tiradentes	CT	2014-10-06 23:47:57.120603	\N	-23.583831	-46.415072
8	Ermelino Matarazzo	EM	2014-10-06 23:47:57.128242	\N	-23.507539	-46.480006
9	Freguesia/Brasilândia	FO	2014-10-06 23:47:57.135107	\N	-23.476247	-46.664606
10	Guaianases	G	2014-10-06 23:47:57.141473	\N	-23.542702	-46.424817
11	Ipiranga	IP	2014-10-06 23:47:57.150034	\N	-23.587567	-46.603258
12	Itaim Paulista	IT	2014-10-06 23:47:57.156738	\N	-23.49402	-46.416706
13	Itaquera	IQ	2014-10-06 23:47:57.164895	\N	-23.536844	-46.45446
14	Jabaquara	JA 	2014-10-06 23:47:57.173984	\N	-23.49402	-46.416706
15	Jaçanã/Tremembé	JT	2014-10-06 23:47:57.181587	\N	-23.468206	-46.582182
16	Lapa	LA	2014-10-06 23:47:57.188267	\N	-23.52247	-46.695516
17	M'Boi Mirim	MB	2014-10-06 23:47:57.1973	\N	-23.667643	-46.728435
18	Mooca	MO	2014-10-06 23:47:57.204228	\N	-23.551346	-46.597937
19	Parelheiros	PA	2014-10-06 23:47:57.213097	\N	-23.81517	-46.73532
20	Penha	PE	2014-10-06 23:47:57.222713	\N	-23.518688	-46.521483
21	Perus	PR	2014-10-06 23:47:57.230325	\N	-23.518688	-46.521483
22	Pinheiros	PI	2014-10-06 23:47:57.237017	\N	-23.564339	-46.703263
23	Pirituba	PJ	2014-10-06 23:47:57.244328	\N	-23.485963	-46.719397
24	Santana/Tucuruvi	ST	2014-10-06 23:47:57.251609	\N	-23.485963	-46.719397
25	Santo Amaro	SA	2014-10-06 23:47:57.258808	\N	-23.6511	-46.707524
26	São Mateus	SM	2014-10-06 23:47:57.266389	\N	-23.6511	-46.707524
27	São Miguel	MP	2014-10-06 23:47:57.275271	\N	-23.500517	-46.451191
28	Sé	SE	2014-10-06 23:47:57.283567	\N	-23.547886	-46.634732
29	Vila Maria/Vila Guilherme	MG	2014-10-06 23:47:57.290218	\N	-23.501387	-46.591497
30	Vila Mariana	VM	2014-10-06 23:47:57.298647	\N	-23.598524	-46.649488
31	Vila Prudente	VP	2014-10-06 23:47:57.305536	\N	-23.582639	-46.560577
32	Sapopemba	SB	2014-10-06 23:47:57.313335	\N	-23.600263	-46.51282
33	Supra-regional	SR	2014-10-06 23:47:57.323615	\N		
\.


--
-- Name: prefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('prefecture_id_seq', 1, false);


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project (id, name, address, latitude, longitude, budget_executed, created_at, updated_at) FROM stdin;
1669	Famílias inseridas no Cadastro Único	\N	0	0	9421876.52999999933	2014-10-06 23:47:57.33236	\N
\.


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_id_seq', 1, false);


--
-- Data for Name: project_prefecture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY project_prefecture (id, project_id, prefecture_id, created_at, update_at) FROM stdin;
100	1669	1	2014-10-06 23:47:57.347858	\N
101	1669	2	2014-10-06 23:47:57.352269	\N
102	1669	3	2014-10-06 23:47:57.355606	\N
103	1669	4	2014-10-06 23:47:57.358089	\N
104	1669	5	2014-10-06 23:47:57.372617	\N
105	1669	6	2014-10-06 23:47:57.377849	\N
106	1669	7	2014-10-06 23:47:57.380988	\N
107	1669	8	2014-10-06 23:47:57.383379	\N
108	1669	9	2014-10-06 23:47:57.385724	\N
109	1669	10	2014-10-06 23:47:57.388169	\N
110	1669	11	2014-10-06 23:47:57.390379	\N
111	1669	12	2014-10-06 23:47:57.393021	\N
112	1669	13	2014-10-06 23:47:57.395557	\N
113	1669	14	2014-10-06 23:47:57.397993	\N
114	1669	15	2014-10-06 23:47:57.400381	\N
115	1669	16	2014-10-06 23:47:57.402827	\N
116	1669	17	2014-10-06 23:47:57.405205	\N
117	1669	18	2014-10-06 23:47:57.408039	\N
118	1669	19	2014-10-06 23:47:57.410946	\N
119	1669	20	2014-10-06 23:47:57.414122	\N
120	1669	21	2014-10-06 23:47:57.419441	\N
121	1669	22	2014-10-06 23:47:57.422103	\N
122	1669	23	2014-10-06 23:47:57.424482	\N
123	1669	24	2014-10-06 23:47:57.426966	\N
124	1669	25	2014-10-06 23:47:57.430107	\N
125	1669	26	2014-10-06 23:47:57.433082	\N
126	1669	27	2014-10-06 23:47:57.435415	\N
127	1669	28	2014-10-06 23:47:57.437762	\N
128	1669	29	2014-10-06 23:47:57.44035	\N
129	1669	30	2014-10-06 23:47:57.442745	\N
130	1669	31	2014-10-06 23:47:57.445295	\N
131	1669	32	2014-10-06 23:47:57.44783	\N
132	1669	33	2014-10-06 23:47:57.450231	\N
\.


--
-- Name: project_prefecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('project_prefecture_id_seq', 132, true);


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

COPY secretary (id, acronym, name, city_id) FROM stdin;
\.


--
-- Name: secretary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('secretary_id_seq', 1, false);


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
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_id_seq', 22, true);


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
\.


--
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_role_id_seq', 48, true);


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
\.


--
-- Name: user_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_session_id_seq', 59, true);


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
-- Name: organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


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
-- Name: secretary_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY secretary
    ADD CONSTRAINT secretary_city_id_fkey FOREIGN KEY (city_id) REFERENCES city(id);


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

