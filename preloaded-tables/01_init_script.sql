--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.2

-- Started on 2024-11-28 13:11:16 WET

-- Check if the PostGIS extension exists before attempting to create it
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'postgis') THEN
    CREATE EXTENSION postgis;
  END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'postgis_raster') THEN
    CREATE EXTENSION postgis_raster;
  END IF;
END $$;

CREATE USER viewer_user WITH PASSWORD 'viewer_user';
CREATE USER viewer WITH PASSWORD 'viewer';

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 9 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: cloudsqlsuperuser
--

-- CREATE SCHEMA public;


-- ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 6477 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: cloudsqlsuperuser
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 253 (class 1259 OID 111629)
-- Name: records_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.records_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.records_record_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 254 (class 1259 OID 111630)
-- Name: records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.records (
    record_id integer DEFAULT nextval('public.records_record_id_seq'::regclass) NOT NULL,
    spatial_object_period_id integer NOT NULL,
    protocol_id integer,
    monitorization_id integer,
    record_externalid integer NOT NULL,
    record_name text,
    record_notes text,
    record_start_time timestamp without time zone,
    record_end_time timestamp without time zone,
    record_cleanliness text,
    record_is_fuel_break_clear boolean,
    record_limits public.geometry,
    record_properties json,
    record_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.records OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 111636)
-- Name: spatial_objects_periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spatial_objects_periods (
    spatial_object_period_id integer NOT NULL,
    spatial_object_id integer NOT NULL,
    period_id integer NOT NULL,
    spatial_object_period_properties json,
    spatial_object_period_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.spatial_objects_periods OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 111641)
-- Name: waypoints; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.waypoints (
    waypoint_id integer NOT NULL,
    record_id integer NOT NULL,
    waypoint_location public.geometry NOT NULL,
    waypoint_arrival_time timestamp without time zone,
    waypoint_departure_time timestamp without time zone,
    waypoint_properties json,
    waypoint_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.waypoints OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 111653)
-- Name: spatial_objects_spatial_object_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spatial_objects_spatial_object_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spatial_objects_spatial_object_id_seq OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 111654)
-- Name: spatial_objects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spatial_objects (
    spatial_object_id integer DEFAULT nextval('public.spatial_objects_spatial_object_id_seq'::regclass) NOT NULL,
    spatial_object_type_id integer NOT NULL,
    spatial_object_area double precision,
    spatial_object_coverage text,
    spatial_object_observations text,
    spatial_object_limits public.geometry NOT NULL,
    spatial_object_bounding_box public.geometry,
    spatial_object_properties json,
    spatial_object_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    segmentation_id integer
);


ALTER TABLE public.spatial_objects OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 111660)
-- Name: spatial_objects_administrative_divisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spatial_objects_administrative_divisions (
    spatial_object_administrative_division_id integer NOT NULL,
    spatial_object_id integer NOT NULL,
    administrative_division_id integer NOT NULL,
    spatial_object_adminstrative_division_properties json,
    spatial_object_adminstrative_division_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.spatial_objects_administrative_divisions OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 111670)
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    account_id integer NOT NULL,
    entity_id integer,
    account_username text NOT NULL,
    account_password text NOT NULL,
    account_email text NOT NULL,
    account_accepted boolean NOT NULL,
    account_blocked boolean NOT NULL,
    account_active boolean NOT NULL,
    account_last_login timestamp without time zone,
    account_expires_at timestamp without time zone,
    account_blocked_time timestamp without time zone,
    account_failed_attempts integer,
    account_properties json,
    account_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    account_location public.geometry
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 111675)
-- Name: accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_account_id_seq OWNER TO postgres;

--
-- TOC entry 6487 (class 0 OID 0)
-- Dependencies: 263
-- Name: accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_account_id_seq OWNED BY public.accounts.account_id;


--
-- TOC entry 264 (class 1259 OID 111676)
-- Name: accounts_devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_devices (
    account_device_id integer NOT NULL,
    account_id integer NOT NULL,
    device_id integer NOT NULL,
    account_device_last_login timestamp without time zone NOT NULL,
    account_device_properties json,
    account_device_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.accounts_devices OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 111681)
-- Name: accounts_devices_account_device_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_devices_account_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_devices_account_device_id_seq OWNER TO postgres;

--
-- TOC entry 6490 (class 0 OID 0)
-- Dependencies: 265
-- Name: accounts_devices_account_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_devices_account_device_id_seq OWNED BY public.accounts_devices.account_device_id;


--
-- TOC entry 266 (class 1259 OID 111682)
-- Name: accounts_divisions_of_interest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_divisions_of_interest (
    account_division_of_interest_id integer NOT NULL,
    administrative_division_id integer NOT NULL,
    account_id integer NOT NULL,
    account_division_of_interest_properties json,
    account_division_of_interest_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.accounts_divisions_of_interest OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 111687)
-- Name: accounts_divisions_of_interes_account_division_of_interess__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_divisions_of_interes_account_division_of_interess__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_divisions_of_interes_account_division_of_interess__seq OWNER TO postgres;

--
-- TOC entry 6493 (class 0 OID 0)
-- Dependencies: 267
-- Name: accounts_divisions_of_interes_account_division_of_interess__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_divisions_of_interes_account_division_of_interess__seq OWNED BY public.accounts_divisions_of_interest.account_division_of_interest_id;


--
-- TOC entry 268 (class 1259 OID 111688)
-- Name: accounts_objects_of_interest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_objects_of_interest (
    account_object_of_interest_id integer NOT NULL,
    spatial_object_id integer NOT NULL,
    account_id integer NOT NULL,
    account_object_of_interest_properties json,
    account_object_of_interest_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.accounts_objects_of_interest OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 111693)
-- Name: accounts_objects_of_interess_account_object_of_interess_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_objects_of_interess_account_object_of_interess_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_objects_of_interess_account_object_of_interess_id_seq OWNER TO postgres;

--
-- TOC entry 6496 (class 0 OID 0)
-- Dependencies: 269
-- Name: accounts_objects_of_interess_account_object_of_interess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_objects_of_interess_account_object_of_interess_id_seq OWNED BY public.accounts_objects_of_interest.account_object_of_interest_id;


--
-- TOC entry 270 (class 1259 OID 111694)
-- Name: accounts_prohibitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_prohibitions (
    account_prohibition_id integer NOT NULL,
    account_id integer NOT NULL,
    prohibition_id integer NOT NULL,
    account_prohibition_infractions integer,
    account_prohibition_properties json,
    account_prohibition_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.accounts_prohibitions OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 111699)
-- Name: accounts_prohibitions_account_prohibition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_prohibitions_account_prohibition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_prohibitions_account_prohibition_id_seq OWNER TO postgres;

--
-- TOC entry 6499 (class 0 OID 0)
-- Dependencies: 271
-- Name: accounts_prohibitions_account_prohibition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_prohibitions_account_prohibition_id_seq OWNED BY public.accounts_prohibitions.account_prohibition_id;


--
-- TOC entry 272 (class 1259 OID 111700)
-- Name: accounts_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_roles (
    account_role_id integer NOT NULL,
    account_id integer NOT NULL,
    role_id integer NOT NULL,
    account_role_properties json,
    account_role_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.accounts_roles OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 111705)
-- Name: accounts_roles_account_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_roles_account_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_roles_account_role_id_seq OWNER TO postgres;

--
-- TOC entry 6502 (class 0 OID 0)
-- Dependencies: 273
-- Name: accounts_roles_account_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_roles_account_role_id_seq OWNED BY public.accounts_roles.account_role_id;


--
-- TOC entry 274 (class 1259 OID 111706)
-- Name: administrative_divisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrative_divisions (
    administrative_division_id integer NOT NULL,
    administrative_division_code text NOT NULL,
    administrative_division_district text NOT NULL,
    administrative_division_municipality text NOT NULL,
    administrative_division_parish text NOT NULL,
    administrative_division_limits public.geometry NOT NULL,
    administrative_division_area real NOT NULL,
    administrative_division_type_area text NOT NULL,
    administrative_division_properties json,
    administrative_division_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.administrative_divisions OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 111711)
-- Name: administrative_divisions_administrative_division_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administrative_divisions_administrative_division_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.administrative_divisions_administrative_division_id_seq OWNER TO postgres;

--
-- TOC entry 6505 (class 0 OID 0)
-- Dependencies: 275
-- Name: administrative_divisions_administrative_division_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administrative_divisions_administrative_division_id_seq OWNED BY public.administrative_divisions.administrative_division_id;


--
-- TOC entry 276 (class 1259 OID 111712)
-- Name: alerts_alert_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alerts_alert_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alerts_alert_id_seq OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 111713)
-- Name: alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerts (
    alert_id integer DEFAULT nextval('public.alerts_alert_id_seq'::regclass) NOT NULL,
    event_id integer,
    spatial_object_period_id integer,
    alert_message text NOT NULL,
    alert_properties json,
    alert_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.alerts OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 111719)
-- Name: answers_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answers_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_answer_id_seq OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 111720)
-- Name: answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answers (
    answer_id integer DEFAULT nextval('public.answers_answer_id_seq'::regclass) NOT NULL,
    question_id integer NOT NULL,
    record_id integer NOT NULL,
    answer_option_id integer,
    answer_externalid integer NOT NULL,
    answer_value text,
    answer_skipped boolean NOT NULL,
    answer_properties json,
    answer_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.answers OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 111726)
-- Name: answers_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answers_options (
    answer_option_id integer NOT NULL,
    answer_option_value text NOT NULL,
    answer_option_properties json,
    answer_option_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    media_id integer
);


ALTER TABLE public.answers_options OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 111731)
-- Name: answers_options_answer_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answers_options_answer_option_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_options_answer_option_id_seq OWNER TO postgres;

--
-- TOC entry 6512 (class 0 OID 0)
-- Dependencies: 281
-- Name: answers_options_answer_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answers_options_answer_option_id_seq OWNED BY public.answers_options.answer_option_id;


--
-- TOC entry 282 (class 1259 OID 111732)
-- Name: app_configurations_app_configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_configurations_app_configuration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_configurations_app_configuration_id_seq OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 111733)
-- Name: app_configurations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_configurations (
    app_configuration_id integer DEFAULT nextval('public.app_configurations_app_configuration_id_seq'::regclass) NOT NULL,
    app_configuration_value json NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.app_configurations OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 111739)
-- Name: area_of_interest_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.area_of_interest_types (
    area_of_interest_type_id integer NOT NULL,
    area_of_interest_type_name text NOT NULL,
    area_of_interest_type_description text,
    area_of_interest_type_properties json,
    area_of_interest_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.area_of_interest_types OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 111744)
-- Name: area_of_interest_types_area_of_interest_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.area_of_interest_types_area_of_interest_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.area_of_interest_types_area_of_interest_type_id_seq OWNER TO postgres;

--
-- TOC entry 6517 (class 0 OID 0)
-- Dependencies: 285
-- Name: area_of_interest_types_area_of_interest_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.area_of_interest_types_area_of_interest_type_id_seq OWNED BY public.area_of_interest_types.area_of_interest_type_id;


--
-- TOC entry 286 (class 1259 OID 111745)
-- Name: area_of_interest_types_protocols; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.area_of_interest_types_protocols (
    area_of_interest_type_protocol_id integer NOT NULL,
    area_of_interest_type__id integer NOT NULL,
    protocol_id integer NOT NULL,
    area_of_interest_type_protocol_properties json,
    area_of_interest_type_protocol_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.area_of_interest_types_protocols OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 111750)
-- Name: area_of_interest_types_protoc_area_of_interest_type_protoco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.area_of_interest_types_protoc_area_of_interest_type_protoco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.area_of_interest_types_protoc_area_of_interest_type_protoco_seq OWNER TO postgres;

--
-- TOC entry 6520 (class 0 OID 0)
-- Dependencies: 287
-- Name: area_of_interest_types_protoc_area_of_interest_type_protoco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.area_of_interest_types_protoc_area_of_interest_type_protoco_seq OWNED BY public.area_of_interest_types_protocols.area_of_interest_type_protocol_id;


--
-- TOC entry 288 (class 1259 OID 111751)
-- Name: areas_of_interest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.areas_of_interest (
    spatial_object_id integer NOT NULL,
    area_of_interest_type_id integer NOT NULL,
    area_of_interest_description text,
    area_of_interest_properties json,
    area_of_interest_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.areas_of_interest OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 111756)
-- Name: augmented_reality_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.augmented_reality_types (
    augmented_reality_type_id integer NOT NULL,
    augmented_reality_type_label character varying,
    augmented_reality_type_name text NOT NULL,
    augmented_reality_type_description text,
    augmented_reality_type_properties json,
    augmented_reality_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.augmented_reality_types OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 111761)
-- Name: augmented_reality_types_augmented_reality_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.augmented_reality_types_augmented_reality_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.augmented_reality_types_augmented_reality_type_id_seq OWNER TO postgres;

--
-- TOC entry 6524 (class 0 OID 0)
-- Dependencies: 290
-- Name: augmented_reality_types_augmented_reality_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.augmented_reality_types_augmented_reality_type_id_seq OWNED BY public.augmented_reality_types.augmented_reality_type_id;


--
-- TOC entry 291 (class 1259 OID 111762)
-- Name: classification_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classification_model (
    classification_model_id integer NOT NULL,
    classification_model_label character varying,
    classification_model_name text NOT NULL,
    classification_model_path text NOT NULL,
    classification_model_description text,
    classification_model_parameters json,
    classification_model_properties json,
    classification_model_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.classification_model OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 111767)
-- Name: classification_model_classification_model_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classification_model_classification_model_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classification_model_classification_model_id_seq OWNER TO postgres;

--
-- TOC entry 6527 (class 0 OID 0)
-- Dependencies: 292
-- Name: classification_model_classification_model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classification_model_classification_model_id_seq OWNED BY public.classification_model.classification_model_id;


--
-- TOC entry 293 (class 1259 OID 111768)
-- Name: confirmation_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.confirmation_tokens (
    confirmation_token_id integer NOT NULL,
    account_id integer NOT NULL,
    confirmation_token text NOT NULL,
    confirmation_token_properties json,
    confirmation_token_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.confirmation_tokens OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 111773)
-- Name: confirmation_tokens_confirmation_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.confirmation_tokens_confirmation_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirmation_tokens_confirmation_token_id_seq OWNER TO postgres;

--
-- TOC entry 6530 (class 0 OID 0)
-- Dependencies: 294
-- Name: confirmation_tokens_confirmation_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.confirmation_tokens_confirmation_token_id_seq OWNED BY public.confirmation_tokens.confirmation_token_id;


--
-- TOC entry 295 (class 1259 OID 111774)
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    contact_id integer NOT NULL,
    administrative_division_id integer NOT NULL,
    entity_id integer NOT NULL,
    contact_name text NOT NULL,
    contact_description text NOT NULL,
    contact_phone numeric(9,0),
    contact_email text,
    contact_properties json,
    contact_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 111779)
-- Name: contacts_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacts_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_contact_id_seq OWNER TO postgres;

--
-- TOC entry 6533 (class 0 OID 0)
-- Dependencies: 296
-- Name: contacts_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacts_contact_id_seq OWNED BY public.contacts.contact_id;


--
-- TOC entry 297 (class 1259 OID 111780)
-- Name: data_derived; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_derived (
    serial_vectorial_data_id integer NOT NULL,
    data_derived_delta real,
    data_derived_ddelta real,
    data_derived_roll_delta real,
    data_derived_rise real,
    data_derived_properties json,
    data_derived_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.data_derived OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 111785)
-- Name: data_derived_serial_vectorial_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_derived_serial_vectorial_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_derived_serial_vectorial_data_id_seq OWNER TO postgres;

--
-- TOC entry 6536 (class 0 OID 0)
-- Dependencies: 298
-- Name: data_derived_serial_vectorial_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_derived_serial_vectorial_data_id_seq OWNED BY public.data_derived.serial_vectorial_data_id;


--
-- TOC entry 299 (class 1259 OID 111786)
-- Name: data_groundtruth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_groundtruth (
    serial_vectorial_data_id integer NOT NULL,
    data_groundtruth_isintervened bytea NOT NULL,
    data_groundtruth_reliable bytea NOT NULL,
    data_groundtruth_description text,
    data_groundtruth_properties json,
    data_groundtruth_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.data_groundtruth OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 111791)
-- Name: data_groundtruth_serial_vectorial_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_groundtruth_serial_vectorial_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_groundtruth_serial_vectorial_data_id_seq OWNER TO postgres;

--
-- TOC entry 6539 (class 0 OID 0)
-- Dependencies: 300
-- Name: data_groundtruth_serial_vectorial_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_groundtruth_serial_vectorial_data_id_seq OWNED BY public.data_groundtruth.serial_vectorial_data_id;


--
-- TOC entry 301 (class 1259 OID 111792)
-- Name: data_provider_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_provider_types (
    data_provider_type_id integer NOT NULL,
    data_provider_type_label character varying,
    data_provider_type_name text NOT NULL,
    data_provider_type_description text,
    data_provider_type_propertyschema json,
    data_provider_type_properties json,
    data_provider_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.data_provider_types OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 111797)
-- Name: data_provider_types_data_provider_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_provider_types_data_provider_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_provider_types_data_provider_type_id_seq OWNER TO postgres;

--
-- TOC entry 6542 (class 0 OID 0)
-- Dependencies: 302
-- Name: data_provider_types_data_provider_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_provider_types_data_provider_type_id_seq OWNED BY public.data_provider_types.data_provider_type_id;


--
-- TOC entry 303 (class 1259 OID 111798)
-- Name: data_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_providers (
    data_provider_id integer NOT NULL,
    entity_id integer,
    data_provider_type_id integer NOT NULL,
    data_provider_label character varying,
    data_provider_name text NOT NULL,
    data_provider_description text,
    data_provider_properties json,
    data_provider_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.data_providers OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 111803)
-- Name: data_providers_data_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_providers_data_provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_providers_data_provider_id_seq OWNER TO postgres;

--
-- TOC entry 6545 (class 0 OID 0)
-- Dependencies: 304
-- Name: data_providers_data_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_providers_data_provider_id_seq OWNED BY public.data_providers.data_provider_id;


--
-- TOC entry 305 (class 1259 OID 111804)
-- Name: data_sources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_sources (
    data_source_id integer NOT NULL,
    data_source_type_id integer NOT NULL,
    data_provider_id integer NOT NULL,
    data_source_name text NOT NULL,
    data_source_filepath text,
    data_source_format text NOT NULL,
    data_source_limits public.geometry,
    data_source_properties json,
    data_source_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.data_sources OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 111809)
-- Name: data_sources_data_source_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_sources_data_source_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_sources_data_source_id_seq OWNER TO postgres;

--
-- TOC entry 6548 (class 0 OID 0)
-- Dependencies: 306
-- Name: data_sources_data_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_sources_data_source_id_seq OWNED BY public.data_sources.data_source_id;


--
-- TOC entry 307 (class 1259 OID 111810)
-- Name: data_sources_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_sources_types (
    data_source_type_id integer NOT NULL,
    data_source_type_label character varying,
    data_source_type_name text NOT NULL,
    data_source_type_description text,
    data_source_type_propertyschema json,
    data_source_type_properties json,
    data_source_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.data_sources_types OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 111815)
-- Name: data_sources_types_data_source_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_sources_types_data_source_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_sources_types_data_source_type_id_seq OWNER TO postgres;

--
-- TOC entry 6551 (class 0 OID 0)
-- Dependencies: 308
-- Name: data_sources_types_data_source_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_sources_types_data_source_type_id_seq OWNED BY public.data_sources_types.data_source_type_id;


--
-- TOC entry 309 (class 1259 OID 111816)
-- Name: data_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_types (
    data_type_id integer NOT NULL,
    data_type_abbreviation text NOT NULL,
    data_type_isnumerical boolean NOT NULL,
    data_type_designation json,
    data_type_description text,
    data_type_notes json,
    data_type_properties json,
    data_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.data_types OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 111821)
-- Name: data_types_data_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_types_data_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_types_data_type_id_seq OWNER TO postgres;

--
-- TOC entry 6554 (class 0 OID 0)
-- Dependencies: 310
-- Name: data_types_data_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_types_data_type_id_seq OWNED BY public.data_types.data_type_id;


--
-- TOC entry 311 (class 1259 OID 111822)
-- Name: device_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device_types (
    device_type_id integer NOT NULL,
    device_type_label character varying,
    device_type_name text NOT NULL,
    device_type_description text,
    device_type_properties json,
    device_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.device_types OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 111827)
-- Name: device_types_device_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.device_types_device_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_types_device_type_id_seq OWNER TO postgres;

--
-- TOC entry 6557 (class 0 OID 0)
-- Dependencies: 312
-- Name: device_types_device_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.device_types_device_type_id_seq OWNED BY public.device_types.device_type_id;


--
-- TOC entry 313 (class 1259 OID 111828)
-- Name: devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devices (
    device_id integer NOT NULL,
    device_type_id integer NOT NULL,
    device_name text NOT NULL,
    device_model text NOT NULL,
    device_characteristics text NOT NULL,
    device_properties json,
    device_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.devices OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 111833)
-- Name: devices_device_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.devices_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.devices_device_id_seq OWNER TO postgres;

--
-- TOC entry 6560 (class 0 OID 0)
-- Dependencies: 314
-- Name: devices_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.devices_device_id_seq OWNED BY public.devices.device_id;


--
-- TOC entry 315 (class 1259 OID 111834)
-- Name: entities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entities (
    entity_id integer NOT NULL,
    entity_name text NOT NULL,
    entity_email text NOT NULL,
    entity_address text NOT NULL,
    entity_properties json,
    entity_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.entities OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 111839)
-- Name: entities_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entities_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entities_entity_id_seq OWNER TO postgres;

--
-- TOC entry 6563 (class 0 OID 0)
-- Dependencies: 316
-- Name: entities_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entities_entity_id_seq OWNED BY public.entities.entity_id;


--
-- TOC entry 317 (class 1259 OID 111840)
-- Name: event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_types (
    event_type_id integer NOT NULL,
    event_type_label character varying,
    event_type_name text NOT NULL,
    event_type_description text,
    event_type_importance integer NOT NULL,
    event_type_properties json,
    event_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.event_types OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 111845)
-- Name: event_types_event_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_types_event_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_types_event_type_id_seq OWNER TO postgres;

--
-- TOC entry 6566 (class 0 OID 0)
-- Dependencies: 318
-- Name: event_types_event_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_types_event_type_id_seq OWNED BY public.event_types.event_type_id;


--
-- TOC entry 319 (class 1259 OID 111846)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    event_id integer NOT NULL,
    event_type_id integer NOT NULL,
    spatial_object_period_id integer,
    event_name text NOT NULL,
    event_description text,
    event_notes text,
    event_gravity integer NOT NULL,
    event_starttime timestamp without time zone NOT NULL,
    event_endtime timestamp without time zone,
    event_location public.geometry,
    event_properties json,
    event_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);

ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 111851)
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_event_id_seq OWNER TO postgres;

--
-- TOC entry 6569 (class 0 OID 0)
-- Dependencies: 320
-- Name: events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_event_id_seq OWNED BY public.events.event_id;


--
-- TOC entry 321 (class 1259 OID 111852)
-- Name: fuel_break_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fuel_break_types (
    fuel_break_type_id integer NOT NULL,
    fuel_break_type_network text NOT NULL,
    fuel_break_type_fuel text,
    fuel_break_type_structure text NOT NULL,
    fuel_break_type_properties json,
    fuel_break_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.fuel_break_types OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 111857)
-- Name: fuel_break_types_fuel_break_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fuel_break_types_fuel_break_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fuel_break_types_fuel_break_type_id_seq OWNER TO postgres;

--
-- TOC entry 6572 (class 0 OID 0)
-- Dependencies: 322
-- Name: fuel_break_types_fuel_break_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fuel_break_types_fuel_break_type_id_seq OWNED BY public.fuel_break_types.fuel_break_type_id;


--
-- TOC entry 323 (class 1259 OID 111858)
-- Name: fuel_break_types_protocols; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fuel_break_types_protocols (
    fuel_break_type_protocol_id integer NOT NULL,
    fuel_break_type_id integer NOT NULL,
    protocol_id integer NOT NULL,
    fuel_break_type_protocol_properties json,
    fuel_break_type_protocol_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.fuel_break_types_protocols OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 111863)
-- Name: fuel_break_types_protocols_fuel_break_type_protocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fuel_break_types_protocols_fuel_break_type_protocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fuel_break_types_protocols_fuel_break_type_protocol_id_seq OWNER TO postgres;

--
-- TOC entry 6575 (class 0 OID 0)
-- Dependencies: 324
-- Name: fuel_break_types_protocols_fuel_break_type_protocol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fuel_break_types_protocols_fuel_break_type_protocol_id_seq OWNED BY public.fuel_break_types_protocols.fuel_break_type_protocol_id;


--
-- TOC entry 325 (class 1259 OID 111864)
-- Name: fuel_break_types_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fuel_break_types_rules (
    fuel_break_type_rule_id integer NOT NULL,
    fuel_break_type_id integer NOT NULL,
    rule_id integer NOT NULL,
    fuel_break_type_rule_properties json,
    fuel_break_type_rule_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.fuel_break_types_rules OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 111869)
-- Name: fuel_break_types_rules_fuel_break_type_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fuel_break_types_rules_fuel_break_type_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fuel_break_types_rules_fuel_break_type_rule_id_seq OWNER TO postgres;

--
-- TOC entry 6578 (class 0 OID 0)
-- Dependencies: 326
-- Name: fuel_break_types_rules_fuel_break_type_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fuel_break_types_rules_fuel_break_type_rule_id_seq OWNED BY public.fuel_break_types_rules.fuel_break_type_rule_id;


--
-- TOC entry 327 (class 1259 OID 111870)
-- Name: fuel_breaks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fuel_breaks (
    spatial_object_id integer NOT NULL,
    fuel_break_type_id integer,
    fuel_break_code integer NOT NULL,
    fuel_break_section_code integer,
    fuel_break_properties json,
    fuel_break_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.fuel_breaks OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 111875)
-- Name: intervention_need_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.intervention_need_types (
    intervention_need_type_id integer NOT NULL,
    intervention_need_type_label character varying,
    intervention_need_type_name text NOT NULL,
    intervention_need_type_description text,
    intervention_need_type_properties json,
    intervention_need_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.intervention_need_types OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 111880)
-- Name: intervention_need_types_intervention_need_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.intervention_need_types_intervention_need_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intervention_need_types_intervention_need_type_id_seq OWNER TO postgres;

--
-- TOC entry 6582 (class 0 OID 0)
-- Dependencies: 329
-- Name: intervention_need_types_intervention_need_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.intervention_need_types_intervention_need_type_id_seq OWNED BY public.intervention_need_types.intervention_need_type_id;


--
-- TOC entry 330 (class 1259 OID 111881)
-- Name: intervention_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.intervention_types (
    intervention_type_id integer NOT NULL,
    intervention_type_label character varying,
    intervention_type_name text NOT NULL,
    intervention_type_description text,
    intervention_type_properties json,
    intervention_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.intervention_types OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 111886)
-- Name: intervention_types_intervention_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.intervention_types_intervention_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intervention_types_intervention_type_id_seq OWNER TO postgres;

--
-- TOC entry 6585 (class 0 OID 0)
-- Dependencies: 331
-- Name: intervention_types_intervention_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.intervention_types_intervention_type_id_seq OWNED BY public.intervention_types.intervention_type_id;


--
-- TOC entry 332 (class 1259 OID 111887)
-- Name: interventions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interventions (
    intervention_id integer NOT NULL,
    intervention_type_id integer NOT NULL,
    intervention_description text,
    intervention_starttime timestamp without time zone,
    intervention_endtime timestamp without time zone NOT NULL,
    intervention_comm_time timestamp without time zone NOT NULL,
    intervention_comm_entity text NOT NULL,
    intervention_exec_entity text NOT NULL,
    intervention_limits public.geometry NOT NULL,
    intervention_properties json,
    intervention_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.interventions OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 111892)
-- Name: interventions_intervention_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.interventions_intervention_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interventions_intervention_id_seq OWNER TO postgres;

--
-- TOC entry 6588 (class 0 OID 0)
-- Dependencies: 333
-- Name: interventions_intervention_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.interventions_intervention_id_seq OWNED BY public.interventions.intervention_id;


--
-- TOC entry 334 (class 1259 OID 111893)
-- Name: interventions_needs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interventions_needs (
    intervention_need_id integer NOT NULL,
    intervention_need_type_id integer NOT NULL,
    spatial_object_period_id integer NOT NULL,
    intervention_need_starttime timestamp without time zone,
    intervention_need_endtime timestamp without time zone NOT NULL,
    intervention_need_comm_time timestamp without time zone NOT NULL,
    intervention_need_comm_entity text NOT NULL,
    intervention_need_exec_entity text NOT NULL,
    intervention_need_properties json,
    intervention_need_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.interventions_needs OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 111898)
-- Name: interventions_needs_intervention_need_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.interventions_needs_intervention_need_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interventions_needs_intervention_need_id_seq OWNER TO postgres;

--
-- TOC entry 6591 (class 0 OID 0)
-- Dependencies: 335
-- Name: interventions_needs_intervention_need_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.interventions_needs_intervention_need_id_seq OWNED BY public.interventions_needs.intervention_need_id;


--
-- TOC entry 336 (class 1259 OID 111899)
-- Name: media_media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.media_media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.media_media_id_seq OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 111900)
-- Name: media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media (
    media_id integer DEFAULT nextval('public.media_media_id_seq'::regclass) NOT NULL,
    media_type_id integer NOT NULL,
    record_id integer,
    event_id integer,
    question_id integer,
    media_name text,
    media_path text NOT NULL,
    media_description text,
    media_time timestamp without time zone NOT NULL,
    media_limits public.geometry,
    media_orientation double precision[],
    media_properties json,
    media_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.media OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 111906)
-- Name: media_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media_answers (
    media_answer_id integer NOT NULL,
    media_id integer NOT NULL,
    answer_id integer NOT NULL,
    media_answer_properties json,
    media_answer_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.media_answers OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 111911)
-- Name: media_answers_media_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.media_answers_media_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.media_answers_media_answer_id_seq OWNER TO postgres;

--
-- TOC entry 6596 (class 0 OID 0)
-- Dependencies: 339
-- Name: media_answers_media_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.media_answers_media_answer_id_seq OWNED BY public.media_answers.media_answer_id;


--
-- TOC entry 340 (class 1259 OID 111912)
-- Name: media_questions_media_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.media_questions_media_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.media_questions_media_question_id_seq OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 111913)
-- Name: media_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media_questions (
    media_question_id integer DEFAULT nextval('public.media_questions_media_question_id_seq'::regclass) NOT NULL,
    media_id integer NOT NULL,
    question_id integer NOT NULL,
    media_question_properties json,
    media_question_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    record_id integer
);


ALTER TABLE public.media_questions OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 111919)
-- Name: media_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media_types (
    media_type_id integer NOT NULL,
    media_type_label character varying,
    media_type_name text NOT NULL,
    media_type_description text,
    media_type_properties json,
    media_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.media_types OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 111924)
-- Name: media_types_media_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.media_types_media_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.media_types_media_type_id_seq OWNER TO postgres;

--
-- TOC entry 6601 (class 0 OID 0)
-- Dependencies: 343
-- Name: media_types_media_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.media_types_media_type_id_seq OWNED BY public.media_types.media_type_id;


--
-- TOC entry 344 (class 1259 OID 111925)
-- Name: member_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.member_types (
    member_type_id integer NOT NULL,
    member_type_label character varying,
    member_type_name text NOT NULL,
    member_type_description text,
    member_type_properties json,
    member_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.member_types OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 111930)
-- Name: member_types_member_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.member_types_member_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.member_types_member_type_id_seq OWNER TO postgres;

--
-- TOC entry 6604 (class 0 OID 0)
-- Dependencies: 345
-- Name: member_types_member_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.member_types_member_type_id_seq OWNED BY public.member_types.member_type_id;


--
-- TOC entry 346 (class 1259 OID 111931)
-- Name: metadata_schemas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metadata_schemas (
    table_name text NOT NULL,
    metadata_schema json
);


ALTER TABLE public.metadata_schemas OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 111936)
-- Name: model_output; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_output (
    model_output_id integer NOT NULL,
    classification_model_id integer NOT NULL,
    spatial_object_period_id integer NOT NULL,
    model_output_results json NOT NULL,
    model_output_description text,
    model_output_properties json,
    model_output_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.model_output OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 111941)
-- Name: model_output_model_output_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.model_output_model_output_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.model_output_model_output_id_seq OWNER TO postgres;

--
-- TOC entry 6608 (class 0 OID 0)
-- Dependencies: 348
-- Name: model_output_model_output_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.model_output_model_output_id_seq OWNED BY public.model_output.model_output_id;


--
-- TOC entry 349 (class 1259 OID 111942)
-- Name: monitorizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.monitorizations (
    monitorization_id integer NOT NULL,
    monitorization_name text NOT NULL,
    monitorization_description text,
    monitorization_date date NOT NULL,
    monitorization_properties json,
    monitorization_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.monitorizations OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 111947)
-- Name: monitorizations_monitorization_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.monitorizations_monitorization_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.monitorizations_monitorization_id_seq OWNER TO postgres;

--
-- TOC entry 6611 (class 0 OID 0)
-- Dependencies: 350
-- Name: monitorizations_monitorization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.monitorizations_monitorization_id_seq OWNED BY public.monitorizations.monitorization_id;


--
-- TOC entry 351 (class 1259 OID 111948)
-- Name: news_news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_news_id_seq OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 111949)
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news (
    news_id integer DEFAULT nextval('public.news_news_id_seq'::regclass) NOT NULL,
    administrative_division_id integer,
    news_title text NOT NULL,
    news_abstract text NOT NULL,
    news_author text NOT NULL,
    news_source text NOT NULL,
    news_date timestamp without time zone NOT NULL,
    news_subject text NOT NULL,
    news_hyperlink text NOT NULL,
    news_keywords text[] NOT NULL,
    news_location public.geometry,
    news_properties json,
    news_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.news OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 111955)
-- Name: operations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operations (
    operation_id integer NOT NULL,
    operation_endpoint text NOT NULL,
    operation_method text NOT NULL,
    operation_description text,
    operation_properties json,
    operation_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.operations OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 111960)
-- Name: operations_operation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operations_operation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operations_operation_id_seq OWNER TO postgres;

--
-- TOC entry 6616 (class 0 OID 0)
-- Dependencies: 354
-- Name: operations_operation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operations_operation_id_seq OWNED BY public.operations.operation_id;


--
-- TOC entry 355 (class 1259 OID 111961)
-- Name: organizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizations (
    organization_id integer NOT NULL,
    organization_nif numeric(9,0) NOT NULL,
    organization_fundation date,
    organization_url text,
    organization_properties json,
    organization_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.organizations OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 111966)
-- Name: organizations_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizations_members (
    organization_member_id integer NOT NULL,
    person_id integer NOT NULL,
    organization_id integer NOT NULL,
    member_type_id integer NOT NULL,
    organization_member_accepted boolean,
    organization_member_properties json,
    organization_member_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.organizations_members OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 111971)
-- Name: organizations_members_organization_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organizations_members_organization_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_members_organization_member_id_seq OWNER TO postgres;

--
-- TOC entry 6620 (class 0 OID 0)
-- Dependencies: 357
-- Name: organizations_members_organization_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organizations_members_organization_member_id_seq OWNED BY public.organizations_members.organization_member_id;


--
-- TOC entry 358 (class 1259 OID 111972)
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.people (
    person_id integer NOT NULL,
    person_gender text,
    person_birthdaydate date,
    person_biography text,
    person_properties json,
    person_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.people OWNER TO postgres;

--
-- TOC entry 359 (class 1259 OID 111977)
-- Name: period_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.period_types (
    period_type_id integer NOT NULL,
    period_type_label character varying,
    period_type_name text NOT NULL,
    period_type_description text,
    period_type_properties json,
    period_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.period_types OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 111982)
-- Name: period_types_period_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.period_types_period_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.period_types_period_type_id_seq OWNER TO postgres;

--
-- TOC entry 6624 (class 0 OID 0)
-- Dependencies: 360
-- Name: period_types_period_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.period_types_period_type_id_seq OWNED BY public.period_types.period_type_id;


--
-- TOC entry 361 (class 1259 OID 111983)
-- Name: periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.periods (
    period_id integer NOT NULL,
    period_type_id integer NOT NULL,
    period_label character varying NOT NULL,
    period_name text NOT NULL,
    period_description text,
    period_start_date timestamp without time zone NOT NULL,
    period_end_date timestamp without time zone NOT NULL,
    period_properties json,
    period_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.periods OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 111988)
-- Name: periods_period_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.periods_period_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.periods_period_id_seq OWNER TO postgres;

--
-- TOC entry 6627 (class 0 OID 0)
-- Dependencies: 362
-- Name: periods_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.periods_period_id_seq OWNED BY public.periods.period_id;


--
-- TOC entry 363 (class 1259 OID 111989)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    data_source_id integer NOT NULL,
    product_filename text,
    product_filepath text NOT NULL,
    product_description text,
    product_properties json,
    product_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 111994)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 6630 (class 0 OID 0)
-- Dependencies: 364
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- TOC entry 365 (class 1259 OID 111995)
-- Name: professionals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professionals (
    professional_id integer NOT NULL,
    professional_specialty text,
    professional_properties json,
    professional_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.professionals OWNER TO postgres;

--
-- TOC entry 366 (class 1259 OID 112000)
-- Name: professionals_monitorizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professionals_monitorizations (
    professional_monitorization_id integer NOT NULL,
    professional_id integer NOT NULL,
    monitorization_id integer NOT NULL,
    professional_monitorization_properties json,
    professional_monitorization_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.professionals_monitorizations OWNER TO postgres;

--
-- TOC entry 367 (class 1259 OID 112005)
-- Name: professionals_monitorizations_professional_monitorization_i_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.professionals_monitorizations_professional_monitorization_i_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.professionals_monitorizations_professional_monitorization_i_seq OWNER TO postgres;

--
-- TOC entry 6634 (class 0 OID 0)
-- Dependencies: 367
-- Name: professionals_monitorizations_professional_monitorization_i_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.professionals_monitorizations_professional_monitorization_i_seq OWNED BY public.professionals_monitorizations.professional_monitorization_id;


--
-- TOC entry 368 (class 1259 OID 112006)
-- Name: professionals_professional_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.professionals_professional_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.professionals_professional_id_seq OWNER TO postgres;

--
-- TOC entry 6636 (class 0 OID 0)
-- Dependencies: 368
-- Name: professionals_professional_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.professionals_professional_id_seq OWNED BY public.professionals.professional_id;


--
-- TOC entry 369 (class 1259 OID 112007)
-- Name: prohibitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prohibitions (
    prohibition_id integer NOT NULL,
    operation_id integer,
    prohibition_name text NOT NULL,
    prohibition_description text,
    prohibition_reason text,
    prohibition_requirements text,
    prohibition_max_infractions integer,
    prohibition_properties json,
    prohibition_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    prohibition_longname text
);


ALTER TABLE public.prohibitions OWNER TO postgres;

--
-- TOC entry 370 (class 1259 OID 112012)
-- Name: prohibitions_prohibition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prohibitions_prohibition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prohibitions_prohibition_id_seq OWNER TO postgres;

--
-- TOC entry 6639 (class 0 OID 0)
-- Dependencies: 370
-- Name: prohibitions_prohibition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prohibitions_prohibition_id_seq OWNED BY public.prohibitions.prohibition_id;


--
-- TOC entry 371 (class 1259 OID 112013)
-- Name: properties_schemas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.properties_schemas (
    table_name text NOT NULL,
    properties_value json
);


ALTER TABLE public.properties_schemas OWNER TO postgres;

--
-- TOC entry 372 (class 1259 OID 112018)
-- Name: protocols_protocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.protocols_protocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.protocols_protocol_id_seq OWNER TO postgres;

--
-- TOC entry 373 (class 1259 OID 112019)
-- Name: protocols; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocols (
    protocol_id integer DEFAULT nextval('public.protocols_protocol_id_seq'::regclass) NOT NULL,
    protocol_label character varying,
    protocol_name text NOT NULL,
    protocol_description text NOT NULL,
    protocol_transitions json,
    protocol_properties json,
    protocol_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    protocol_version integer NOT NULL,
    protocol_active boolean NOT NULL
);


ALTER TABLE public.protocols OWNER TO postgres;

--
-- TOC entry 374 (class 1259 OID 112025)
-- Name: question_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_types (
    question_type_id integer NOT NULL,
    question_type_label character varying,
    question_type_name text NOT NULL,
    question_type_description text,
    question_type_properties json,
    question_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.question_types OWNER TO postgres;

--
-- TOC entry 375 (class 1259 OID 112030)
-- Name: question_types_question_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_types_question_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_types_question_type_id_seq OWNER TO postgres;

--
-- TOC entry 6645 (class 0 OID 0)
-- Dependencies: 375
-- Name: question_types_question_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_types_question_type_id_seq OWNED BY public.question_types.question_type_id;


--
-- TOC entry 376 (class 1259 OID 112031)
-- Name: questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_question_id_seq OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 112032)
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    question_id integer DEFAULT nextval('public.questions_question_id_seq'::regclass) NOT NULL,
    question_type_id integer NOT NULL,
    rule_id integer,
    augmented_reality_type_id integer,
    question_value text NOT NULL,
    question_help text,
    question_skip_if_answer json,
    question_properties json,
    question_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 112038)
-- Name: questions_answers_options_question_answer_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_answers_options_question_answer_option_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_answers_options_question_answer_option_id_seq OWNER TO postgres;

--
-- TOC entry 379 (class 1259 OID 112039)
-- Name: questions_answers_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions_answers_options (
    question_answer_option_id integer DEFAULT nextval('public.questions_answers_options_question_answer_option_id_seq'::regclass) NOT NULL,
    question_id integer NOT NULL,
    answer_option_id integer NOT NULL,
    question_answer_option_properties json,
    question_answer_option_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.questions_answers_options OWNER TO postgres;

--
-- TOC entry 380 (class 1259 OID 112045)
-- Name: questions_protocols_question_protocol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_protocols_question_protocol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_protocols_question_protocol_id_seq OWNER TO postgres;

--
-- TOC entry 381 (class 1259 OID 112046)
-- Name: questions_protocols; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions_protocols (
    question_protocol_id integer DEFAULT nextval('public.questions_protocols_question_protocol_id_seq'::regclass) NOT NULL,
    question_id integer NOT NULL,
    protocol_id integer NOT NULL,
    question_protocol_properties json,
    question_protocol_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.questions_protocols OWNER TO postgres;

--
-- TOC entry 382 (class 1259 OID 112052)
-- Name: reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reset_tokens (
    reset_token_id integer NOT NULL,
    account_email text NOT NULL,
    reset_token text NOT NULL,
    reset_token_expires_at timestamp without time zone NOT NULL,
    reset_token_properties json,
    reset_token_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.reset_tokens OWNER TO postgres;

--
-- TOC entry 383 (class 1259 OID 112057)
-- Name: reset_tokens_reset_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reset_tokens_reset_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reset_tokens_reset_token_id_seq OWNER TO postgres;

--
-- TOC entry 6654 (class 0 OID 0)
-- Dependencies: 383
-- Name: reset_tokens_reset_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reset_tokens_reset_token_id_seq OWNED BY public.reset_tokens.reset_token_id;


--
-- TOC entry 384 (class 1259 OID 112058)
-- Name: rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rewards (
    reward_id integer NOT NULL,
    volunteer_id integer NOT NULL,
    reward_properties json,
    reward_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.rewards OWNER TO postgres;

--
-- TOC entry 385 (class 1259 OID 112063)
-- Name: rewards_reward_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rewards_reward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rewards_reward_id_seq OWNER TO postgres;

--
-- TOC entry 6657 (class 0 OID 0)
-- Dependencies: 385
-- Name: rewards_reward_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rewards_reward_id_seq OWNED BY public.rewards.reward_id;


--
-- TOC entry 386 (class 1259 OID 112064)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name text NOT NULL,
    role_label character varying NOT NULL,
    role_description text NOT NULL,
    role_properties json,
    role_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 387 (class 1259 OID 112069)
-- Name: roles_operations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_operations (
    role_operation_id integer NOT NULL,
    role_id integer NOT NULL,
    operation_id integer NOT NULL,
    role_operation_properties json,
    role_operation_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.roles_operations OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 112074)
-- Name: roles_operations_role_operation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_operations_role_operation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_operations_role_operation_id_seq OWNER TO postgres;

--
-- TOC entry 6661 (class 0 OID 0)
-- Dependencies: 388
-- Name: roles_operations_role_operation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_operations_role_operation_id_seq OWNED BY public.roles_operations.role_operation_id;


--
-- TOC entry 389 (class 1259 OID 112075)
-- Name: roles_prohibitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_prohibitions (
    role_prohibition_id integer NOT NULL,
    role_id integer NOT NULL,
    prohibition_id integer NOT NULL,
    role_prohibition_properties json,
    role_prohibition_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.roles_prohibitions OWNER TO postgres;

--
-- TOC entry 390 (class 1259 OID 112080)
-- Name: roles_prohibitions_role_prohibition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_prohibitions_role_prohibition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_prohibitions_role_prohibition_id_seq OWNER TO postgres;

--
-- TOC entry 6664 (class 0 OID 0)
-- Dependencies: 390
-- Name: roles_prohibitions_role_prohibition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_prohibitions_role_prohibition_id_seq OWNED BY public.roles_prohibitions.role_prohibition_id;


--
-- TOC entry 391 (class 1259 OID 112081)
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO postgres;

--
-- TOC entry 6666 (class 0 OID 0)
-- Dependencies: 391
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- TOC entry 392 (class 1259 OID 112082)
-- Name: rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rules (
    rule_id integer NOT NULL,
    rule_label character varying,
    rule_name text NOT NULL,
    rule_description text NOT NULL,
    rule_properties json,
    rule_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.rules OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 112087)
-- Name: rules_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rules_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rules_rule_id_seq OWNER TO postgres;

--
-- TOC entry 6669 (class 0 OID 0)
-- Dependencies: 393
-- Name: rules_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rules_rule_id_seq OWNED BY public.rules.rule_id;


--
-- TOC entry 394 (class 1259 OID 112088)
-- Name: segmentations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.segmentations (
    segmentation_id integer NOT NULL,
    segmentation_name text NOT NULL,
    segmentation_description text,
    segmentation_properties json,
    segmentation_metadata json,
    segmentation_time timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.segmentations OWNER TO postgres;

--
-- TOC entry 395 (class 1259 OID 112093)
-- Name: segmentations_segmentation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.segmentations_segmentation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.segmentations_segmentation_id_seq OWNER TO postgres;

--
-- TOC entry 6672 (class 0 OID 0)
-- Dependencies: 395
-- Name: segmentations_segmentation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.segmentations_segmentation_id_seq OWNED BY public.segmentations.segmentation_id;


--
-- TOC entry 396 (class 1259 OID 112094)
-- Name: segments; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.segments AS
 SELECT spatial_objects.spatial_object_id,
    public.st_transform(spatial_objects.spatial_object_limits, 3763) AS spatial_object_limits
   FROM public.spatial_objects
  WHERE (spatial_objects.spatial_object_type_id = 5)
  WITH NO DATA;


ALTER TABLE public.segments OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 112100)
-- Name: segments_interventions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.segments_interventions (
    segment_intervention_id integer NOT NULL,
    intervention_need_id integer NOT NULL,
    intervention_id integer NOT NULL,
    segment_intervention_area double precision NOT NULL,
    segment_intervention_percentage_intersection numeric NOT NULL,
    segment_intervention_properties json,
    segment_intervention_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.segments_interventions OWNER TO postgres;

--
-- TOC entry 398 (class 1259 OID 112105)
-- Name: segments_interventions_segment_intervention_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.segments_interventions_segment_intervention_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.segments_interventions_segment_intervention_id_seq OWNER TO postgres;

--
-- TOC entry 6675 (class 0 OID 0)
-- Dependencies: 398
-- Name: segments_interventions_segment_intervention_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.segments_interventions_segment_intervention_id_seq OWNED BY public.segments_interventions.segment_intervention_id;


--
-- TOC entry 399 (class 1259 OID 112106)
-- Name: series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series (
    series_id integer NOT NULL,
    series_variable_id integer NOT NULL,
    series_type_id integer NOT NULL,
    data_source_id integer NOT NULL,
    series_limits public.geometry,
    series_properties json,
    series_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.series OWNER TO postgres;

--
-- TOC entry 400 (class 1259 OID 112111)
-- Name: series_periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series_periods (
    series_period_id integer NOT NULL,
    series_period_label character varying(16),
    series_period_name text NOT NULL,
    series_period_description text,
    series_period_properties jsonb,
    series_period_metadata jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.series_periods OWNER TO postgres;

--
-- TOC entry 401 (class 1259 OID 112116)
-- Name: series_periods_series_period_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_periods_series_period_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_periods_series_period_id_seq OWNER TO postgres;

--
-- TOC entry 6679 (class 0 OID 0)
-- Dependencies: 401
-- Name: series_periods_series_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_periods_series_period_id_seq OWNED BY public.series_periods.series_period_id;


--
-- TOC entry 402 (class 1259 OID 112117)
-- Name: series_raster_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series_raster_data (
    series_id integer NOT NULL,
    series_raster_data_id integer NOT NULL,
    product_id integer NOT NULL,
    series_raster_data_timestamp timestamp without time zone,
    series_raster_data_filename text,
    series_raster_data_filepath text,
    series_raster_data_bands text NOT NULL,
    series_raster_data_format text NOT NULL,
    series_raster_data_resolution text,
    series_raster_data_raster public.raster,
    series_raster_data_limits public.geometry,
    series_raster_data_description text,
    series_raster_data_properties json,
    series_raster_data_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.series_raster_data OWNER TO postgres;

--
-- TOC entry 403 (class 1259 OID 112122)
-- Name: series_raster_data_series_raster_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_raster_data_series_raster_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_raster_data_series_raster_data_id_seq OWNER TO postgres;

--
-- TOC entry 6682 (class 0 OID 0)
-- Dependencies: 403
-- Name: series_raster_data_series_raster_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_raster_data_series_raster_data_id_seq OWNED BY public.series_raster_data.series_raster_data_id;


--
-- TOC entry 404 (class 1259 OID 112123)
-- Name: series_relation_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series_relation_types (
    series_relation_type_id integer NOT NULL,
    series_relation_type_label character varying,
    series_relation_type_name text NOT NULL,
    series_relation_type_description text,
    series_relation_type_propertyschema json,
    series_relation_type_properties json,
    series_relation_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.series_relation_types OWNER TO postgres;

--
-- TOC entry 405 (class 1259 OID 112128)
-- Name: series_relation_types_series_relation_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_relation_types_series_relation_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_relation_types_series_relation_type_id_seq OWNER TO postgres;

--
-- TOC entry 6685 (class 0 OID 0)
-- Dependencies: 405
-- Name: series_relation_types_series_relation_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_relation_types_series_relation_type_id_seq OWNED BY public.series_relation_types.series_relation_type_id;


--
-- TOC entry 406 (class 1259 OID 112129)
-- Name: series_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series_relations (
    series_relation_id integer NOT NULL,
    series_id integer NOT NULL,
    related_series_id integer NOT NULL,
    series_relation_type_id integer NOT NULL,
    series_relation_properties json,
    series_relation_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.series_relations OWNER TO postgres;

--
-- TOC entry 407 (class 1259 OID 112134)
-- Name: series_relations_series_relation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_relations_series_relation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_relations_series_relation_id_seq OWNER TO postgres;

--
-- TOC entry 6688 (class 0 OID 0)
-- Dependencies: 407
-- Name: series_relations_series_relation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_relations_series_relation_id_seq OWNED BY public.series_relations.series_relation_id;


--
-- TOC entry 408 (class 1259 OID 112135)
-- Name: series_series_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_series_id_seq OWNER TO postgres;

--
-- TOC entry 6690 (class 0 OID 0)
-- Dependencies: 408
-- Name: series_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_series_id_seq OWNED BY public.series.series_id;


--
-- TOC entry 409 (class 1259 OID 112136)
-- Name: series_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series_types (
    series_type_id integer NOT NULL,
    series_type_label character varying,
    series_type_name text NOT NULL,
    series_type_description text,
    series_type_properties json,
    series_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.series_types OWNER TO postgres;

--
-- TOC entry 410 (class 1259 OID 112141)
-- Name: series_types_series_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_types_series_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_types_series_type_id_seq OWNER TO postgres;

--
-- TOC entry 6693 (class 0 OID 0)
-- Dependencies: 410
-- Name: series_types_series_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_types_series_type_id_seq OWNED BY public.series_types.series_type_id;


--
-- TOC entry 411 (class 1259 OID 112142)
-- Name: series_variables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series_variables (
    series_variable_id integer NOT NULL,
    data_type_id integer NOT NULL,
    series_period_id integer,
    unit_symbol character varying(16),
    series_variable_label character varying,
    series_variable_shortname text NOT NULL,
    series_variable_longname text NOT NULL,
    series_variable_description text,
    series_variable_minvalue character varying,
    series_variable_maxvalue character varying,
    series_variable_properties json,
    series_variable_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.series_variables OWNER TO postgres;

--
-- TOC entry 412 (class 1259 OID 112147)
-- Name: series_variables_series_variable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_variables_series_variable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_variables_series_variable_id_seq OWNER TO postgres;

--
-- TOC entry 6696 (class 0 OID 0)
-- Dependencies: 412
-- Name: series_variables_series_variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_variables_series_variable_id_seq OWNED BY public.series_variables.series_variable_id;


--
-- TOC entry 413 (class 1259 OID 112148)
-- Name: series_vectorial_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series_vectorial_data (
    series_id integer NOT NULL,
    series_vectorial_data_id integer NOT NULL,
    product_id integer NOT NULL,
    series_vectorial_data_timestamp timestamp without time zone,
    series_vectorial_data_value text,
    series_vectorial_data_realvalue real,
    series_vectorial_data_location public.geometry,
    series_vectorial_data_properties json,
    series_vectorial_data_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.series_vectorial_data OWNER TO postgres;

--
-- TOC entry 414 (class 1259 OID 112153)
-- Name: series_vectorial_data_series_vectorial_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_vectorial_data_series_vectorial_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_vectorial_data_series_vectorial_data_id_seq OWNER TO postgres;

--
-- TOC entry 6699 (class 0 OID 0)
-- Dependencies: 414
-- Name: series_vectorial_data_series_vectorial_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_vectorial_data_series_vectorial_data_id_seq OWNED BY public.series_vectorial_data.series_vectorial_data_id;


--
-- TOC entry 415 (class 1259 OID 112154)
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    setting_name text NOT NULL,
    setting_value text NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- TOC entry 416 (class 1259 OID 112159)
-- Name: spatial_object_entity_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spatial_object_entity_types (
    spatial_object_entity_type_id integer NOT NULL,
    spatial_object_entity_type_label character varying,
    spatial_object_entity_type_name text NOT NULL,
    spatial_object_entity_type_description text,
    spatial_object_entity_type_properties json,
    spatial_object_entity_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.spatial_object_entity_types OWNER TO postgres;

--
-- TOC entry 417 (class 1259 OID 112164)
-- Name: spatial_object_entity_types_spatial_object_entity_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spatial_object_entity_types_spatial_object_entity_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spatial_object_entity_types_spatial_object_entity_type_id_seq OWNER TO postgres;

--
-- TOC entry 6703 (class 0 OID 0)
-- Dependencies: 417
-- Name: spatial_object_entity_types_spatial_object_entity_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spatial_object_entity_types_spatial_object_entity_type_id_seq OWNED BY public.spatial_object_entity_types.spatial_object_entity_type_id;


--
-- TOC entry 418 (class 1259 OID 112165)
-- Name: spatial_object_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spatial_object_types (
    spatial_object_type_id integer NOT NULL,
    spatial_object_type_name text NOT NULL,
    spatial_object_type_description text,
    spatial_object_type_properties json,
    spatial_object_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.spatial_object_types OWNER TO postgres;

--
-- TOC entry 419 (class 1259 OID 112170)
-- Name: spatial_object_types_spatial_object_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spatial_object_types_spatial_object_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spatial_object_types_spatial_object_type_id_seq OWNER TO postgres;

--
-- TOC entry 6706 (class 0 OID 0)
-- Dependencies: 419
-- Name: spatial_object_types_spatial_object_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spatial_object_types_spatial_object_type_id_seq OWNED BY public.spatial_object_types.spatial_object_type_id;


--
-- TOC entry 420 (class 1259 OID 112171)
-- Name: spatial_objects_administrativ_spatial_object_administrative_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spatial_objects_administrativ_spatial_object_administrative_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spatial_objects_administrativ_spatial_object_administrative_seq OWNER TO postgres;

--
-- TOC entry 6708 (class 0 OID 0)
-- Dependencies: 420
-- Name: spatial_objects_administrativ_spatial_object_administrative_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spatial_objects_administrativ_spatial_object_administrative_seq OWNED BY public.spatial_objects_administrative_divisions.spatial_object_administrative_division_id;


--
-- TOC entry 421 (class 1259 OID 112172)
-- Name: spatial_objects_periods_entities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spatial_objects_periods_entities (
    spatial_object_period_entity_id integer NOT NULL,
    spatial_object_entity_type_id integer NOT NULL,
    spatial_object_period_id integer NOT NULL,
    entity_id integer NOT NULL,
    spatial_object_period_entity_startdate date NOT NULL,
    spatial_object_period_entity_enddate date,
    spatial_object_period_entity_properties json,
    spatial_object_period_entity_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.spatial_objects_periods_entities OWNER TO postgres;

--
-- TOC entry 422 (class 1259 OID 112177)
-- Name: spatial_objects_periods_entit_spatial_object_period_entity__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spatial_objects_periods_entit_spatial_object_period_entity__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spatial_objects_periods_entit_spatial_object_period_entity__seq OWNER TO postgres;

--
-- TOC entry 6711 (class 0 OID 0)
-- Dependencies: 422
-- Name: spatial_objects_periods_entit_spatial_object_period_entity__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spatial_objects_periods_entit_spatial_object_period_entity__seq OWNED BY public.spatial_objects_periods_entities.spatial_object_period_entity_id;


--
-- TOC entry 423 (class 1259 OID 112178)
-- Name: spatial_objects_periods_series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spatial_objects_periods_series (
    spatial_object_period_series_id integer NOT NULL,
    spatial_object_period_id integer NOT NULL,
    series_id integer NOT NULL,
    spatial_object_period_series_reliable bytea,
    spatial_object_period_series_isintervened bytea,
    spatial_object_period_series_properties json,
    spatial_object_period_series_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.spatial_objects_periods_series OWNER TO postgres;

--
-- TOC entry 424 (class 1259 OID 112183)
-- Name: spatial_objects_periods_serie_spatial_object_period_series__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spatial_objects_periods_serie_spatial_object_period_series__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spatial_objects_periods_serie_spatial_object_period_series__seq OWNER TO postgres;

--
-- TOC entry 6714 (class 0 OID 0)
-- Dependencies: 424
-- Name: spatial_objects_periods_serie_spatial_object_period_series__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spatial_objects_periods_serie_spatial_object_period_series__seq OWNED BY public.spatial_objects_periods_series.spatial_object_period_series_id;


--
-- TOC entry 425 (class 1259 OID 112184)
-- Name: spatial_objects_periods_spatial_object_period_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spatial_objects_periods_spatial_object_period_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spatial_objects_periods_spatial_object_period_id_seq OWNER TO postgres;

--
-- TOC entry 6716 (class 0 OID 0)
-- Dependencies: 425
-- Name: spatial_objects_periods_spatial_object_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spatial_objects_periods_spatial_object_period_id_seq OWNED BY public.spatial_objects_periods.spatial_object_period_id;


--
-- TOC entry 426 (class 1259 OID 112185)
-- Name: spatial_objects_v_4326; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.spatial_objects_v_4326 AS
 SELECT so.spatial_object_id,
    so.spatial_object_type_id,
    so.spatial_object_area,
    so.spatial_object_coverage,
    so.spatial_object_observations,
    public.st_transform(so.spatial_object_limits, 4326) AS spatial_object_limits,
    so.spatial_object_properties,
    so.spatial_object_metadata,
    fb.fuel_break_type_id,
    fb.fuel_break_code,
    fb.fuel_break_section_code,
    fbt.fuel_break_type_network,
    fbt.fuel_break_type_fuel,
    fbt.fuel_break_type_structure
   FROM ((public.spatial_objects so
     JOIN public.fuel_breaks fb ON ((fb.spatial_object_id = so.spatial_object_id)))
     JOIN public.fuel_break_types fbt ON ((fbt.fuel_break_type_id = fb.fuel_break_type_id)))
  WHERE (so.spatial_object_type_id = 1);


ALTER TABLE public.spatial_objects_v_4326 OWNER TO postgres;

--
-- TOC entry 427 (class 1259 OID 112190)
-- Name: states; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.states (
    state_id integer NOT NULL,
    spatial_object_period_id integer NOT NULL,
    summary_id integer NOT NULL,
    state_predicted text,
    state_observed text,
    state_vegetation integer,
    state_start_time timestamp without time zone NOT NULL,
    state_end_time timestamp without time zone NOT NULL,
    state_properties json,
    state_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.states OWNER TO postgres;

--
-- TOC entry 428 (class 1259 OID 112195)
-- Name: states_state_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.states_state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.states_state_id_seq OWNER TO postgres;

--
-- TOC entry 6720 (class 0 OID 0)
-- Dependencies: 428
-- Name: states_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.states_state_id_seq OWNED BY public.states.state_id;


--
-- TOC entry 429 (class 1259 OID 112196)
-- Name: summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.summary (
    summary_id integer NOT NULL,
    summary_predicted_clean text NOT NULL,
    summary_predicted_not_clean integer NOT NULL,
    summary_predicted_not_known integer NOT NULL,
    summary_observed_clean integer NOT NULL,
    summary_observed_not_clean integer NOT NULL,
    summary_observed_not_known integer NOT NULL,
    summary_vegetation integer NOT NULL,
    summary_start_time timestamp without time zone NOT NULL,
    summary_end_time timestamp without time zone NOT NULL,
    summary_properties json,
    summary_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.summary OWNER TO postgres;

--
-- TOC entry 430 (class 1259 OID 112201)
-- Name: summary_summary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.summary_summary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.summary_summary_id_seq OWNER TO postgres;

--
-- TOC entry 6722 (class 0 OID 0)
-- Dependencies: 430
-- Name: summary_summary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.summary_summary_id_seq OWNED BY public.summary.summary_id;


--
-- TOC entry 431 (class 1259 OID 112202)
-- Name: topological_relation_types_topological_relation_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topological_relation_types_topological_relation_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topological_relation_types_topological_relation_type_id_seq OWNER TO postgres;

--
-- TOC entry 432 (class 1259 OID 112203)
-- Name: topological_relation_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topological_relation_types (
    topological_relation_type_id integer DEFAULT nextval('public.topological_relation_types_topological_relation_type_id_seq'::regclass) NOT NULL,
    topological_relation_type_label character varying,
    topological_relation_type_name text NOT NULL,
    topological_relation_type_description text,
    topological_relation_type_min_cardinality integer NOT NULL,
    topological_relation_type_max_cardinality integer NOT NULL,
    topological_relation_type_properties json,
    topological_relation_type_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.topological_relation_types OWNER TO postgres;

--
-- TOC entry 434 (class 1259 OID 112214)
-- Name: topological_relations_topological_relation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topological_relations_topological_relation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topological_relations_topological_relation_id_seq OWNER TO postgres;

--
-- TOC entry 433 (class 1259 OID 112209)
-- Name: topological_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topological_relations (
    topological_relation_id integer DEFAULT nextval('public.topological_relations_topological_relation_id_seq'::regclass) NOT NULL,
    spatial_object_id integer NOT NULL,
    related_spatial_object_id integer NOT NULL,
    topological_relation_type_id integer NOT NULL,
    topological_relation_properties json,
    topological_relation_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.topological_relations OWNER TO postgres;

--
-- TOC entry 435 (class 1259 OID 112215)
-- Name: training_data_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.training_data_model (
    training_data_model_id integer NOT NULL,
    series_vectorial_data_id integer,
    classification_model_id integer NOT NULL,
    training_data_model_properties json,
    training_data_model_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.training_data_model OWNER TO postgres;

--
-- TOC entry 436 (class 1259 OID 112220)
-- Name: training_data_model_training_data_model_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.training_data_model_training_data_model_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_data_model_training_data_model_id_seq OWNER TO postgres;

--
-- TOC entry 6728 (class 0 OID 0)
-- Dependencies: 436
-- Name: training_data_model_training_data_model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.training_data_model_training_data_model_id_seq OWNED BY public.training_data_model.training_data_model_id;


--
-- TOC entry 437 (class 1259 OID 112221)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    unit_symbol character varying(16) NOT NULL,
    unit_name text NOT NULL,
    unit_def text NOT NULL,
    unit_alias_of character varying(16),
    unit_designation json,
    unit_description json,
    unit_notes json,
    unit_allow_prefixes boolean,
    unit_allowed_prefixes json,
    unit_properties json,
    unit_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 438 (class 1259 OID 112226)
-- Name: volunteers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volunteers (
    volunteer_id integer NOT NULL,
    volunteer_level numeric,
    volunteer_quality numeric,
    volunteer_reliable boolean,
    volunteer_ranking integer,
    volunteer_properties json,
    volunteer_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.volunteers OWNER TO postgres;

--
-- TOC entry 439 (class 1259 OID 112231)
-- Name: volunteers_records_volunteer_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.volunteers_records_volunteer_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_records_volunteer_record_id_seq OWNER TO postgres;

--
-- TOC entry 440 (class 1259 OID 112232)
-- Name: volunteers_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volunteers_records (
    volunteer_record_id integer DEFAULT nextval('public.volunteers_records_volunteer_record_id_seq'::regclass) NOT NULL,
    record_id integer NOT NULL,
    volunteer_id integer NOT NULL,
    volunteer_record_quality integer,
    volunteer_record_properties json,
    volunteer_record_metadata json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.volunteers_records OWNER TO postgres;

--
-- TOC entry 441 (class 1259 OID 112238)
-- Name: volunteers_volunteer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.volunteers_volunteer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_volunteer_id_seq OWNER TO postgres;

--
-- TOC entry 6734 (class 0 OID 0)
-- Dependencies: 441
-- Name: volunteers_volunteer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.volunteers_volunteer_id_seq OWNED BY public.volunteers.volunteer_id;


--
-- TOC entry 442 (class 1259 OID 112239)
-- Name: waypoints_waypoint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.waypoints_waypoint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.waypoints_waypoint_id_seq OWNER TO postgres;

--
-- TOC entry 6736 (class 0 OID 0)
-- Dependencies: 442
-- Name: waypoints_waypoint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.waypoints_waypoint_id_seq OWNED BY public.waypoints.waypoint_id;


--
-- TOC entry 5798 (class 2604 OID 112249)
-- Name: accounts account_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN account_id SET DEFAULT nextval('public.accounts_account_id_seq'::regclass);


--
-- TOC entry 5799 (class 2604 OID 112250)
-- Name: accounts_devices account_device_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_devices ALTER COLUMN account_device_id SET DEFAULT nextval('public.accounts_devices_account_device_id_seq'::regclass);


--
-- TOC entry 5800 (class 2604 OID 112251)
-- Name: accounts_divisions_of_interest account_division_of_interest_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_divisions_of_interest ALTER COLUMN account_division_of_interest_id SET DEFAULT nextval('public.accounts_divisions_of_interes_account_division_of_interess__seq'::regclass);


--
-- TOC entry 5801 (class 2604 OID 112252)
-- Name: accounts_objects_of_interest account_object_of_interest_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_objects_of_interest ALTER COLUMN account_object_of_interest_id SET DEFAULT nextval('public.accounts_objects_of_interess_account_object_of_interess_id_seq'::regclass);


--
-- TOC entry 5802 (class 2604 OID 112253)
-- Name: accounts_prohibitions account_prohibition_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_prohibitions ALTER COLUMN account_prohibition_id SET DEFAULT nextval('public.accounts_prohibitions_account_prohibition_id_seq'::regclass);


--
-- TOC entry 5803 (class 2604 OID 112254)
-- Name: accounts_roles account_role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_roles ALTER COLUMN account_role_id SET DEFAULT nextval('public.accounts_roles_account_role_id_seq'::regclass);


--
-- TOC entry 5804 (class 2604 OID 112255)
-- Name: administrative_divisions administrative_division_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrative_divisions ALTER COLUMN administrative_division_id SET DEFAULT nextval('public.administrative_divisions_administrative_division_id_seq'::regclass);


--
-- TOC entry 5807 (class 2604 OID 112256)
-- Name: answers_options answer_option_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers_options ALTER COLUMN answer_option_id SET DEFAULT nextval('public.answers_options_answer_option_id_seq'::regclass);


--
-- TOC entry 5809 (class 2604 OID 112257)
-- Name: area_of_interest_types area_of_interest_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_of_interest_types ALTER COLUMN area_of_interest_type_id SET DEFAULT nextval('public.area_of_interest_types_area_of_interest_type_id_seq'::regclass);


--
-- TOC entry 5810 (class 2604 OID 112258)
-- Name: area_of_interest_types_protocols area_of_interest_type_protocol_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_of_interest_types_protocols ALTER COLUMN area_of_interest_type_protocol_id SET DEFAULT nextval('public.area_of_interest_types_protoc_area_of_interest_type_protoco_seq'::regclass);


--
-- TOC entry 5811 (class 2604 OID 112259)
-- Name: augmented_reality_types augmented_reality_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.augmented_reality_types ALTER COLUMN augmented_reality_type_id SET DEFAULT nextval('public.augmented_reality_types_augmented_reality_type_id_seq'::regclass);


--
-- TOC entry 5812 (class 2604 OID 112260)
-- Name: classification_model classification_model_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classification_model ALTER COLUMN classification_model_id SET DEFAULT nextval('public.classification_model_classification_model_id_seq'::regclass);


--
-- TOC entry 5813 (class 2604 OID 112261)
-- Name: confirmation_tokens confirmation_token_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmation_tokens ALTER COLUMN confirmation_token_id SET DEFAULT nextval('public.confirmation_tokens_confirmation_token_id_seq'::regclass);


--
-- TOC entry 5814 (class 2604 OID 112262)
-- Name: contacts contact_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts ALTER COLUMN contact_id SET DEFAULT nextval('public.contacts_contact_id_seq'::regclass);


--
-- TOC entry 5815 (class 2604 OID 112263)
-- Name: data_derived serial_vectorial_data_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_derived ALTER COLUMN serial_vectorial_data_id SET DEFAULT nextval('public.data_derived_serial_vectorial_data_id_seq'::regclass);


--
-- TOC entry 5816 (class 2604 OID 112264)
-- Name: data_groundtruth serial_vectorial_data_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_groundtruth ALTER COLUMN serial_vectorial_data_id SET DEFAULT nextval('public.data_groundtruth_serial_vectorial_data_id_seq'::regclass);


--
-- TOC entry 5817 (class 2604 OID 112265)
-- Name: data_provider_types data_provider_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_provider_types ALTER COLUMN data_provider_type_id SET DEFAULT nextval('public.data_provider_types_data_provider_type_id_seq'::regclass);


--
-- TOC entry 5818 (class 2604 OID 112266)
-- Name: data_providers data_provider_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_providers ALTER COLUMN data_provider_id SET DEFAULT nextval('public.data_providers_data_provider_id_seq'::regclass);


--
-- TOC entry 5819 (class 2604 OID 112267)
-- Name: data_sources data_source_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources ALTER COLUMN data_source_id SET DEFAULT nextval('public.data_sources_data_source_id_seq'::regclass);


--
-- TOC entry 5820 (class 2604 OID 112268)
-- Name: data_sources_types data_source_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources_types ALTER COLUMN data_source_type_id SET DEFAULT nextval('public.data_sources_types_data_source_type_id_seq'::regclass);


--
-- TOC entry 5821 (class 2604 OID 112269)
-- Name: data_types data_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_types ALTER COLUMN data_type_id SET DEFAULT nextval('public.data_types_data_type_id_seq'::regclass);


--
-- TOC entry 5822 (class 2604 OID 112270)
-- Name: device_types device_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_types ALTER COLUMN device_type_id SET DEFAULT nextval('public.device_types_device_type_id_seq'::regclass);


--
-- TOC entry 5823 (class 2604 OID 112271)
-- Name: devices device_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices ALTER COLUMN device_id SET DEFAULT nextval('public.devices_device_id_seq'::regclass);


--
-- TOC entry 5824 (class 2604 OID 112272)
-- Name: entities entity_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entities ALTER COLUMN entity_id SET DEFAULT nextval('public.entities_entity_id_seq'::regclass);


--
-- TOC entry 5825 (class 2604 OID 112273)
-- Name: event_types event_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_types ALTER COLUMN event_type_id SET DEFAULT nextval('public.event_types_event_type_id_seq'::regclass);


--
-- TOC entry 5826 (class 2604 OID 112274)
-- Name: events event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN event_id SET DEFAULT nextval('public.events_event_id_seq'::regclass);


--
-- TOC entry 5827 (class 2604 OID 112275)
-- Name: fuel_break_types fuel_break_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types ALTER COLUMN fuel_break_type_id SET DEFAULT nextval('public.fuel_break_types_fuel_break_type_id_seq'::regclass);


--
-- TOC entry 5828 (class 2604 OID 112276)
-- Name: fuel_break_types_protocols fuel_break_type_protocol_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_protocols ALTER COLUMN fuel_break_type_protocol_id SET DEFAULT nextval('public.fuel_break_types_protocols_fuel_break_type_protocol_id_seq'::regclass);


--
-- TOC entry 5829 (class 2604 OID 112277)
-- Name: fuel_break_types_rules fuel_break_type_rule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_rules ALTER COLUMN fuel_break_type_rule_id SET DEFAULT nextval('public.fuel_break_types_rules_fuel_break_type_rule_id_seq'::regclass);


--
-- TOC entry 5830 (class 2604 OID 112278)
-- Name: intervention_need_types intervention_need_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intervention_need_types ALTER COLUMN intervention_need_type_id SET DEFAULT nextval('public.intervention_need_types_intervention_need_type_id_seq'::regclass);


--
-- TOC entry 5831 (class 2604 OID 112279)
-- Name: intervention_types intervention_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intervention_types ALTER COLUMN intervention_type_id SET DEFAULT nextval('public.intervention_types_intervention_type_id_seq'::regclass);


--
-- TOC entry 5832 (class 2604 OID 112280)
-- Name: interventions intervention_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventions ALTER COLUMN intervention_id SET DEFAULT nextval('public.interventions_intervention_id_seq'::regclass);


--
-- TOC entry 5833 (class 2604 OID 112281)
-- Name: interventions_needs intervention_need_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventions_needs ALTER COLUMN intervention_need_id SET DEFAULT nextval('public.interventions_needs_intervention_need_id_seq'::regclass);


--
-- TOC entry 5835 (class 2604 OID 112282)
-- Name: media_answers media_answer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_answers ALTER COLUMN media_answer_id SET DEFAULT nextval('public.media_answers_media_answer_id_seq'::regclass);


--
-- TOC entry 5837 (class 2604 OID 112283)
-- Name: media_types media_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_types ALTER COLUMN media_type_id SET DEFAULT nextval('public.media_types_media_type_id_seq'::regclass);


--
-- TOC entry 5838 (class 2604 OID 112284)
-- Name: member_types member_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_types ALTER COLUMN member_type_id SET DEFAULT nextval('public.member_types_member_type_id_seq'::regclass);


--
-- TOC entry 5839 (class 2604 OID 112285)
-- Name: model_output model_output_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_output ALTER COLUMN model_output_id SET DEFAULT nextval('public.model_output_model_output_id_seq'::regclass);


--
-- TOC entry 5840 (class 2604 OID 112286)
-- Name: monitorizations monitorization_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monitorizations ALTER COLUMN monitorization_id SET DEFAULT nextval('public.monitorizations_monitorization_id_seq'::regclass);


--
-- TOC entry 5842 (class 2604 OID 112287)
-- Name: operations operation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations ALTER COLUMN operation_id SET DEFAULT nextval('public.operations_operation_id_seq'::regclass);


--
-- TOC entry 5843 (class 2604 OID 112288)
-- Name: organizations_members organization_member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations_members ALTER COLUMN organization_member_id SET DEFAULT nextval('public.organizations_members_organization_member_id_seq'::regclass);


--
-- TOC entry 5844 (class 2604 OID 112289)
-- Name: period_types period_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.period_types ALTER COLUMN period_type_id SET DEFAULT nextval('public.period_types_period_type_id_seq'::regclass);


--
-- TOC entry 5845 (class 2604 OID 112290)
-- Name: periods period_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods ALTER COLUMN period_id SET DEFAULT nextval('public.periods_period_id_seq'::regclass);


--
-- TOC entry 5846 (class 2604 OID 112291)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 5847 (class 2604 OID 112292)
-- Name: professionals professional_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionals ALTER COLUMN professional_id SET DEFAULT nextval('public.professionals_professional_id_seq'::regclass);


--
-- TOC entry 5848 (class 2604 OID 112293)
-- Name: professionals_monitorizations professional_monitorization_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionals_monitorizations ALTER COLUMN professional_monitorization_id SET DEFAULT nextval('public.professionals_monitorizations_professional_monitorization_i_seq'::regclass);


--
-- TOC entry 5849 (class 2604 OID 112294)
-- Name: prohibitions prohibition_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prohibitions ALTER COLUMN prohibition_id SET DEFAULT nextval('public.prohibitions_prohibition_id_seq'::regclass);


--
-- TOC entry 5851 (class 2604 OID 112295)
-- Name: question_types question_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_types ALTER COLUMN question_type_id SET DEFAULT nextval('public.question_types_question_type_id_seq'::regclass);


--
-- TOC entry 5855 (class 2604 OID 112296)
-- Name: reset_tokens reset_token_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_tokens ALTER COLUMN reset_token_id SET DEFAULT nextval('public.reset_tokens_reset_token_id_seq'::regclass);


--
-- TOC entry 5856 (class 2604 OID 112297)
-- Name: rewards reward_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rewards ALTER COLUMN reward_id SET DEFAULT nextval('public.rewards_reward_id_seq'::regclass);


--
-- TOC entry 5857 (class 2604 OID 112298)
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- TOC entry 5858 (class 2604 OID 112299)
-- Name: roles_operations role_operation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_operations ALTER COLUMN role_operation_id SET DEFAULT nextval('public.roles_operations_role_operation_id_seq'::regclass);


--
-- TOC entry 5859 (class 2604 OID 112300)
-- Name: roles_prohibitions role_prohibition_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_prohibitions ALTER COLUMN role_prohibition_id SET DEFAULT nextval('public.roles_prohibitions_role_prohibition_id_seq'::regclass);


--
-- TOC entry 5860 (class 2604 OID 112301)
-- Name: rules rule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rules ALTER COLUMN rule_id SET DEFAULT nextval('public.rules_rule_id_seq'::regclass);


--
-- TOC entry 5861 (class 2604 OID 112302)
-- Name: segmentations segmentation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segmentations ALTER COLUMN segmentation_id SET DEFAULT nextval('public.segmentations_segmentation_id_seq'::regclass);


--
-- TOC entry 5862 (class 2604 OID 112303)
-- Name: segments_interventions segment_intervention_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segments_interventions ALTER COLUMN segment_intervention_id SET DEFAULT nextval('public.segments_interventions_segment_intervention_id_seq'::regclass);


--
-- TOC entry 5863 (class 2604 OID 112304)
-- Name: series series_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series ALTER COLUMN series_id SET DEFAULT nextval('public.series_series_id_seq'::regclass);


--
-- TOC entry 5864 (class 2604 OID 112305)
-- Name: series_periods series_period_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_periods ALTER COLUMN series_period_id SET DEFAULT nextval('public.series_periods_series_period_id_seq'::regclass);


--
-- TOC entry 5865 (class 2604 OID 112306)
-- Name: series_raster_data series_raster_data_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_raster_data ALTER COLUMN series_raster_data_id SET DEFAULT nextval('public.series_raster_data_series_raster_data_id_seq'::regclass);


--
-- TOC entry 5866 (class 2604 OID 112307)
-- Name: series_relation_types series_relation_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_relation_types ALTER COLUMN series_relation_type_id SET DEFAULT nextval('public.series_relation_types_series_relation_type_id_seq'::regclass);


--
-- TOC entry 5867 (class 2604 OID 112308)
-- Name: series_relations series_relation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_relations ALTER COLUMN series_relation_id SET DEFAULT nextval('public.series_relations_series_relation_id_seq'::regclass);


--
-- TOC entry 5868 (class 2604 OID 112309)
-- Name: series_types series_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_types ALTER COLUMN series_type_id SET DEFAULT nextval('public.series_types_series_type_id_seq'::regclass);


--
-- TOC entry 5869 (class 2604 OID 112310)
-- Name: series_variables series_variable_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_variables ALTER COLUMN series_variable_id SET DEFAULT nextval('public.series_variables_series_variable_id_seq'::regclass);


--
-- TOC entry 5870 (class 2604 OID 112311)
-- Name: series_vectorial_data series_vectorial_data_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_vectorial_data ALTER COLUMN series_vectorial_data_id SET DEFAULT nextval('public.series_vectorial_data_series_vectorial_data_id_seq'::regclass);


--
-- TOC entry 5871 (class 2604 OID 112312)
-- Name: spatial_object_entity_types spatial_object_entity_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_object_entity_types ALTER COLUMN spatial_object_entity_type_id SET DEFAULT nextval('public.spatial_object_entity_types_spatial_object_entity_type_id_seq'::regclass);


--
-- TOC entry 5872 (class 2604 OID 112313)
-- Name: spatial_object_types spatial_object_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_object_types ALTER COLUMN spatial_object_type_id SET DEFAULT nextval('public.spatial_object_types_spatial_object_type_id_seq'::regclass);


--
-- TOC entry 5797 (class 2604 OID 112314)
-- Name: spatial_objects_administrative_divisions spatial_object_administrative_division_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_administrative_divisions ALTER COLUMN spatial_object_administrative_division_id SET DEFAULT nextval('public.spatial_objects_administrativ_spatial_object_administrative_seq'::regclass);


--
-- TOC entry 5794 (class 2604 OID 112315)
-- Name: spatial_objects_periods spatial_object_period_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods ALTER COLUMN spatial_object_period_id SET DEFAULT nextval('public.spatial_objects_periods_spatial_object_period_id_seq'::regclass);


--
-- TOC entry 5873 (class 2604 OID 112316)
-- Name: spatial_objects_periods_entities spatial_object_period_entity_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_entities ALTER COLUMN spatial_object_period_entity_id SET DEFAULT nextval('public.spatial_objects_periods_entit_spatial_object_period_entity__seq'::regclass);


--
-- TOC entry 5874 (class 2604 OID 112317)
-- Name: spatial_objects_periods_series spatial_object_period_series_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_series ALTER COLUMN spatial_object_period_series_id SET DEFAULT nextval('public.spatial_objects_periods_serie_spatial_object_period_series__seq'::regclass);


--
-- TOC entry 5875 (class 2604 OID 112318)
-- Name: states state_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.states ALTER COLUMN state_id SET DEFAULT nextval('public.states_state_id_seq'::regclass);


--
-- TOC entry 5876 (class 2604 OID 112319)
-- Name: summary summary_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.summary ALTER COLUMN summary_id SET DEFAULT nextval('public.summary_summary_id_seq'::regclass);


--
-- TOC entry 5879 (class 2604 OID 112321)
-- Name: training_data_model training_data_model_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_data_model ALTER COLUMN training_data_model_id SET DEFAULT nextval('public.training_data_model_training_data_model_id_seq'::regclass);


--
-- TOC entry 5880 (class 2604 OID 112322)
-- Name: volunteers volunteer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN volunteer_id SET DEFAULT nextval('public.volunteers_volunteer_id_seq'::regclass);


--
-- TOC entry 5795 (class 2604 OID 112323)
-- Name: waypoints waypoint_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.waypoints ALTER COLUMN waypoint_id SET DEFAULT nextval('public.waypoints_waypoint_id_seq'::regclass);


--
-- TOC entry 5895 (class 2606 OID 139339)
-- Name: waypoints waypoints_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.waypoints
    ADD CONSTRAINT waypoints_pkey PRIMARY KEY (waypoint_id);


--
-- TOC entry 5906 (class 2606 OID 139366)
-- Name: accounts accounts_account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_account_email_key UNIQUE (account_email);


--
-- TOC entry 5909 (class 2606 OID 139368)
-- Name: accounts accounts_account_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_account_username_key UNIQUE (account_username);


--
-- TOC entry 5914 (class 2606 OID 139370)
-- Name: accounts_devices accounts_devices_account_id_device_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_devices
    ADD CONSTRAINT accounts_devices_account_id_device_id_key UNIQUE (account_id, device_id);


--
-- TOC entry 5916 (class 2606 OID 139372)
-- Name: accounts_devices accounts_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_devices
    ADD CONSTRAINT accounts_devices_pkey PRIMARY KEY (account_device_id);


--
-- TOC entry 5918 (class 2606 OID 139374)
-- Name: accounts_divisions_of_interest accounts_divisions_of_interes_administrative_division_id_ac_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_divisions_of_interest
    ADD CONSTRAINT accounts_divisions_of_interes_administrative_division_id_ac_key UNIQUE (administrative_division_id, account_id);


--
-- TOC entry 5920 (class 2606 OID 139376)
-- Name: accounts_divisions_of_interest accounts_divisions_of_interess_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_divisions_of_interest
    ADD CONSTRAINT accounts_divisions_of_interess_pkey PRIMARY KEY (account_division_of_interest_id);


--
-- TOC entry 5922 (class 2606 OID 139378)
-- Name: accounts_objects_of_interest accounts_objects_of_interess_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_objects_of_interest
    ADD CONSTRAINT accounts_objects_of_interess_pkey PRIMARY KEY (account_object_of_interest_id);


--
-- TOC entry 5924 (class 2606 OID 139380)
-- Name: accounts_objects_of_interest accounts_objects_of_interess_spatial_object_id_account_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_objects_of_interest
    ADD CONSTRAINT accounts_objects_of_interess_spatial_object_id_account_id_key UNIQUE (spatial_object_id, account_id);


--
-- TOC entry 5912 (class 2606 OID 139382)
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);


--
-- TOC entry 5926 (class 2606 OID 139384)
-- Name: accounts_prohibitions accounts_prohibitions_account_id_prohibition_id_deleted_at_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_prohibitions
    ADD CONSTRAINT accounts_prohibitions_account_id_prohibition_id_deleted_at_key UNIQUE (account_id, prohibition_id, deleted_at);


--
-- TOC entry 5928 (class 2606 OID 139386)
-- Name: accounts_prohibitions accounts_prohibitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_prohibitions
    ADD CONSTRAINT accounts_prohibitions_pkey PRIMARY KEY (account_prohibition_id);


--
-- TOC entry 5930 (class 2606 OID 139388)
-- Name: accounts_roles accounts_roles_account_id_role_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_roles
    ADD CONSTRAINT accounts_roles_account_id_role_id_key UNIQUE (account_id, role_id);


--
-- TOC entry 5932 (class 2606 OID 139390)
-- Name: accounts_roles accounts_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_roles
    ADD CONSTRAINT accounts_roles_pkey PRIMARY KEY (account_role_id);


--
-- TOC entry 5935 (class 2606 OID 139392)
-- Name: administrative_divisions administrative_divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrative_divisions
    ADD CONSTRAINT administrative_divisions_pkey PRIMARY KEY (administrative_division_id);


--
-- TOC entry 5938 (class 2606 OID 139394)
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (alert_id);


--
-- TOC entry 5946 (class 2606 OID 139396)
-- Name: answers_options answers_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers_options
    ADD CONSTRAINT answers_options_pkey PRIMARY KEY (answer_option_id);


--
-- TOC entry 5942 (class 2606 OID 139398)
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (answer_id);


--
-- TOC entry 5948 (class 2606 OID 139400)
-- Name: app_configurations app_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_configurations
    ADD CONSTRAINT app_configurations_pkey PRIMARY KEY (app_configuration_id);


--
-- TOC entry 5950 (class 2606 OID 139402)
-- Name: area_of_interest_types area_of_interest_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_of_interest_types
    ADD CONSTRAINT area_of_interest_types_pkey PRIMARY KEY (area_of_interest_type_id);


--
-- TOC entry 5952 (class 2606 OID 139404)
-- Name: area_of_interest_types_protocols area_of_interest_types_protoc_area_of_interest_type__id_pro_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_of_interest_types_protocols
    ADD CONSTRAINT area_of_interest_types_protoc_area_of_interest_type__id_pro_key UNIQUE (area_of_interest_type__id, protocol_id);


--
-- TOC entry 5954 (class 2606 OID 139406)
-- Name: area_of_interest_types_protocols area_of_interest_types_protocols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_of_interest_types_protocols
    ADD CONSTRAINT area_of_interest_types_protocols_pkey PRIMARY KEY (area_of_interest_type_protocol_id);


--
-- TOC entry 5957 (class 2606 OID 139408)
-- Name: areas_of_interest areas_of_interest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas_of_interest
    ADD CONSTRAINT areas_of_interest_pkey PRIMARY KEY (spatial_object_id);


--
-- TOC entry 5959 (class 2606 OID 139410)
-- Name: augmented_reality_types augmented_reality_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.augmented_reality_types
    ADD CONSTRAINT augmented_reality_types_pkey PRIMARY KEY (augmented_reality_type_id);


--
-- TOC entry 5961 (class 2606 OID 139412)
-- Name: classification_model classification_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classification_model
    ADD CONSTRAINT classification_model_pkey PRIMARY KEY (classification_model_id);


--
-- TOC entry 5964 (class 2606 OID 139414)
-- Name: confirmation_tokens confirmation_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmation_tokens
    ADD CONSTRAINT confirmation_tokens_pkey PRIMARY KEY (confirmation_token_id);


--
-- TOC entry 5966 (class 2606 OID 139416)
-- Name: contacts contacts_administrative_division_id_entity_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_administrative_division_id_entity_id_key UNIQUE (administrative_division_id, entity_id);


--
-- TOC entry 5968 (class 2606 OID 139418)
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (contact_id);


--
-- TOC entry 5970 (class 2606 OID 139420)
-- Name: data_derived data_derived_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_derived
    ADD CONSTRAINT data_derived_pkey PRIMARY KEY (serial_vectorial_data_id);


--
-- TOC entry 5972 (class 2606 OID 139422)
-- Name: data_groundtruth data_groundtruth_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_groundtruth
    ADD CONSTRAINT data_groundtruth_pkey PRIMARY KEY (serial_vectorial_data_id);


--
-- TOC entry 5974 (class 2606 OID 139424)
-- Name: data_provider_types data_provider_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_provider_types
    ADD CONSTRAINT data_provider_types_pkey PRIMARY KEY (data_provider_type_id);


--
-- TOC entry 5978 (class 2606 OID 139426)
-- Name: data_providers data_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_providers
    ADD CONSTRAINT data_providers_pkey PRIMARY KEY (data_provider_id);


--
-- TOC entry 5982 (class 2606 OID 139428)
-- Name: data_sources data_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources
    ADD CONSTRAINT data_sources_pkey PRIMARY KEY (data_source_id);


--
-- TOC entry 5984 (class 2606 OID 139430)
-- Name: data_sources_types data_sources_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources_types
    ADD CONSTRAINT data_sources_types_pkey PRIMARY KEY (data_source_type_id);


--
-- TOC entry 5986 (class 2606 OID 139432)
-- Name: data_types data_types_data_type_abbreviation_deleted_at_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_types
    ADD CONSTRAINT data_types_data_type_abbreviation_deleted_at_key UNIQUE (data_type_abbreviation, deleted_at);


--
-- TOC entry 5988 (class 2606 OID 139434)
-- Name: data_types data_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_types
    ADD CONSTRAINT data_types_pkey PRIMARY KEY (data_type_id);


--
-- TOC entry 5990 (class 2606 OID 139436)
-- Name: device_types device_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_types
    ADD CONSTRAINT device_types_pkey PRIMARY KEY (device_type_id);


--
-- TOC entry 5993 (class 2606 OID 139438)
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (device_id);


--
-- TOC entry 5995 (class 2606 OID 139440)
-- Name: entities entities_entity_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_entity_email_key UNIQUE (entity_email);


--
-- TOC entry 5997 (class 2606 OID 139442)
-- Name: entities entities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (entity_id);


--
-- TOC entry 5999 (class 2606 OID 139444)
-- Name: event_types event_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (event_type_id);


--
-- TOC entry 6003 (class 2606 OID 139446)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- TOC entry 6006 (class 2606 OID 139448)
-- Name: fuel_break_types fuel_break_types_fuel_break_type_network_fuel_break_type_fu_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types
    ADD CONSTRAINT fuel_break_types_fuel_break_type_network_fuel_break_type_fu_key UNIQUE (fuel_break_type_network, fuel_break_type_fuel, fuel_break_type_structure);


--
-- TOC entry 6008 (class 2606 OID 139450)
-- Name: fuel_break_types fuel_break_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types
    ADD CONSTRAINT fuel_break_types_pkey PRIMARY KEY (fuel_break_type_id);


--
-- TOC entry 6010 (class 2606 OID 139452)
-- Name: fuel_break_types_protocols fuel_break_types_protocols_fuel_break_type_id_protocol_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_protocols
    ADD CONSTRAINT fuel_break_types_protocols_fuel_break_type_id_protocol_id_key UNIQUE (fuel_break_type_id, protocol_id);


--
-- TOC entry 6012 (class 2606 OID 139454)
-- Name: fuel_break_types_protocols fuel_break_types_protocols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_protocols
    ADD CONSTRAINT fuel_break_types_protocols_pkey PRIMARY KEY (fuel_break_type_protocol_id);


--
-- TOC entry 6014 (class 2606 OID 139456)
-- Name: fuel_break_types_rules fuel_break_types_rules_fuel_break_type_id_rule_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_rules
    ADD CONSTRAINT fuel_break_types_rules_fuel_break_type_id_rule_id_key UNIQUE (fuel_break_type_id, rule_id);


--
-- TOC entry 6016 (class 2606 OID 139458)
-- Name: fuel_break_types_rules fuel_break_types_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_rules
    ADD CONSTRAINT fuel_break_types_rules_pkey PRIMARY KEY (fuel_break_type_rule_id);


--
-- TOC entry 6019 (class 2606 OID 139460)
-- Name: fuel_breaks fuel_breaks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_breaks
    ADD CONSTRAINT fuel_breaks_pkey PRIMARY KEY (spatial_object_id);


--
-- TOC entry 6021 (class 2606 OID 139462)
-- Name: intervention_need_types intervention_need_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intervention_need_types
    ADD CONSTRAINT intervention_need_types_pkey PRIMARY KEY (intervention_need_type_id);


--
-- TOC entry 6023 (class 2606 OID 139464)
-- Name: intervention_types intervention_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intervention_types
    ADD CONSTRAINT intervention_types_pkey PRIMARY KEY (intervention_type_id);


--
-- TOC entry 6029 (class 2606 OID 139466)
-- Name: interventions_needs interventions_needs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventions_needs
    ADD CONSTRAINT interventions_needs_pkey PRIMARY KEY (intervention_need_id);


--
-- TOC entry 6026 (class 2606 OID 139468)
-- Name: interventions interventions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventions
    ADD CONSTRAINT interventions_pkey PRIMARY KEY (intervention_id);


--
-- TOC entry 6038 (class 2606 OID 139470)
-- Name: media_answers media_answers_media_id_answer_id_deleted_at_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_answers
    ADD CONSTRAINT media_answers_media_id_answer_id_deleted_at_key UNIQUE (media_id, answer_id, deleted_at);


--
-- TOC entry 6040 (class 2606 OID 139472)
-- Name: media_answers media_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_answers
    ADD CONSTRAINT media_answers_pkey PRIMARY KEY (media_answer_id);


--
-- TOC entry 6034 (class 2606 OID 139474)
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (media_id);


--
-- TOC entry 6042 (class 2606 OID 139476)
-- Name: media_questions media_questions_media_id_question_id_deleted_at_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_questions
    ADD CONSTRAINT media_questions_media_id_question_id_deleted_at_key UNIQUE (media_id, question_id, deleted_at);


--
-- TOC entry 6044 (class 2606 OID 139478)
-- Name: media_questions media_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_questions
    ADD CONSTRAINT media_questions_pkey PRIMARY KEY (media_question_id);


--
-- TOC entry 6046 (class 2606 OID 139480)
-- Name: media_types media_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_types
    ADD CONSTRAINT media_types_pkey PRIMARY KEY (media_type_id);


--
-- TOC entry 6048 (class 2606 OID 139482)
-- Name: member_types member_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_types
    ADD CONSTRAINT member_types_pkey PRIMARY KEY (member_type_id);


--
-- TOC entry 6050 (class 2606 OID 139484)
-- Name: metadata_schemas metadata_schemas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metadata_schemas
    ADD CONSTRAINT metadata_schemas_pkey PRIMARY KEY (table_name);


--
-- TOC entry 6053 (class 2606 OID 139486)
-- Name: model_output model_output_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_output
    ADD CONSTRAINT model_output_pkey PRIMARY KEY (model_output_id);


--
-- TOC entry 6056 (class 2606 OID 139488)
-- Name: monitorizations monitorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monitorizations
    ADD CONSTRAINT monitorizations_pkey PRIMARY KEY (monitorization_id);


--
-- TOC entry 6058 (class 2606 OID 139490)
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (news_id);


--
-- TOC entry 6060 (class 2606 OID 139492)
-- Name: operations operations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations
    ADD CONSTRAINT operations_pkey PRIMARY KEY (operation_id);


--
-- TOC entry 6065 (class 2606 OID 139494)
-- Name: organizations_members organizations_members_person_id_organization_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations_members
    ADD CONSTRAINT organizations_members_person_id_organization_id_key UNIQUE (person_id, organization_id);


--
-- TOC entry 6067 (class 2606 OID 139496)
-- Name: organizations_members organizations_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations_members
    ADD CONSTRAINT organizations_members_pkey PRIMARY KEY (organization_member_id);


--
-- TOC entry 6062 (class 2606 OID 139498)
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (organization_id);


--
-- TOC entry 6069 (class 2606 OID 139500)
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (person_id);


--
-- TOC entry 6071 (class 2606 OID 139502)
-- Name: period_types period_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.period_types
    ADD CONSTRAINT period_types_pkey PRIMARY KEY (period_type_id);


--
-- TOC entry 6074 (class 2606 OID 139504)
-- Name: periods periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT periods_pkey PRIMARY KEY (period_id);


--
-- TOC entry 6077 (class 2606 OID 139506)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 6081 (class 2606 OID 139508)
-- Name: professionals_monitorizations professionals_monitorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionals_monitorizations
    ADD CONSTRAINT professionals_monitorizations_pkey PRIMARY KEY (professional_monitorization_id);


--
-- TOC entry 6083 (class 2606 OID 139510)
-- Name: professionals_monitorizations professionals_monitorizations_professional_id_monitorizatio_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionals_monitorizations
    ADD CONSTRAINT professionals_monitorizations_professional_id_monitorizatio_key UNIQUE (professional_id, monitorization_id);


--
-- TOC entry 6079 (class 2606 OID 139512)
-- Name: professionals professionals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionals
    ADD CONSTRAINT professionals_pkey PRIMARY KEY (professional_id);


--
-- TOC entry 6086 (class 2606 OID 139514)
-- Name: prohibitions prohibitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prohibitions
    ADD CONSTRAINT prohibitions_pkey PRIMARY KEY (prohibition_id);


--
-- TOC entry 6088 (class 2606 OID 139516)
-- Name: properties_schemas properties_schemas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.properties_schemas
    ADD CONSTRAINT properties_schemas_pkey PRIMARY KEY (table_name);


--
-- TOC entry 6090 (class 2606 OID 139518)
-- Name: protocols protocols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocols
    ADD CONSTRAINT protocols_pkey PRIMARY KEY (protocol_id);


--
-- TOC entry 6092 (class 2606 OID 139520)
-- Name: question_types question_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_types
    ADD CONSTRAINT question_types_pkey PRIMARY KEY (question_type_id);


--
-- TOC entry 6099 (class 2606 OID 139522)
-- Name: questions_answers_options questions_answers_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions_answers_options
    ADD CONSTRAINT questions_answers_options_pkey PRIMARY KEY (question_answer_option_id);


--
-- TOC entry 6101 (class 2606 OID 139524)
-- Name: questions_answers_options questions_answers_options_question_id_answer_option_id_dele_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions_answers_options
    ADD CONSTRAINT questions_answers_options_question_id_answer_option_id_dele_key UNIQUE (question_id, answer_option_id, deleted_at);


--
-- TOC entry 6095 (class 2606 OID 139526)
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (question_id);


--
-- TOC entry 6103 (class 2606 OID 139528)
-- Name: questions_protocols questions_protocols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions_protocols
    ADD CONSTRAINT questions_protocols_pkey PRIMARY KEY (question_protocol_id);


--
-- TOC entry 6105 (class 2606 OID 139530)
-- Name: questions_protocols questions_protocols_question_id_protocol_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions_protocols
    ADD CONSTRAINT questions_protocols_question_id_protocol_id_key UNIQUE (question_id, protocol_id);


--
-- TOC entry 5887 (class 2606 OID 139532)
-- Name: records records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT records_pkey PRIMARY KEY (record_id);


--
-- TOC entry 6108 (class 2606 OID 139534)
-- Name: reset_tokens reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_tokens
    ADD CONSTRAINT reset_tokens_pkey PRIMARY KEY (reset_token_id);


--
-- TOC entry 6110 (class 2606 OID 139536)
-- Name: rewards rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rewards
    ADD CONSTRAINT rewards_pkey PRIMARY KEY (reward_id);


--
-- TOC entry 6115 (class 2606 OID 139538)
-- Name: roles_operations roles_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_operations
    ADD CONSTRAINT roles_operations_pkey PRIMARY KEY (role_operation_id);


--
-- TOC entry 6117 (class 2606 OID 139540)
-- Name: roles_operations roles_operations_role_id_operation_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_operations
    ADD CONSTRAINT roles_operations_role_id_operation_id_key UNIQUE (role_id, operation_id);


--
-- TOC entry 6113 (class 2606 OID 139542)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- TOC entry 6119 (class 2606 OID 139544)
-- Name: roles_prohibitions roles_prohibitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_prohibitions
    ADD CONSTRAINT roles_prohibitions_pkey PRIMARY KEY (role_prohibition_id);


--
-- TOC entry 6121 (class 2606 OID 139546)
-- Name: roles_prohibitions roles_prohibitions_role_id_prohibition_id_deleted_at_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_prohibitions
    ADD CONSTRAINT roles_prohibitions_role_id_prohibition_id_deleted_at_key UNIQUE (role_id, prohibition_id, deleted_at);


--
-- TOC entry 6123 (class 2606 OID 139548)
-- Name: rules rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (rule_id);


--
-- TOC entry 6125 (class 2606 OID 139550)
-- Name: segmentations segmentations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segmentations
    ADD CONSTRAINT segmentations_pkey PRIMARY KEY (segmentation_id);


--
-- TOC entry 6127 (class 2606 OID 139552)
-- Name: segments_interventions segments_interventions_intervention_need_id_intervention_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segments_interventions
    ADD CONSTRAINT segments_interventions_intervention_need_id_intervention_id_key UNIQUE (intervention_need_id, intervention_id);


--
-- TOC entry 6129 (class 2606 OID 139554)
-- Name: segments_interventions segments_interventions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segments_interventions
    ADD CONSTRAINT segments_interventions_pkey PRIMARY KEY (segment_intervention_id);


--
-- TOC entry 6136 (class 2606 OID 139556)
-- Name: series_periods series_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_periods
    ADD CONSTRAINT series_periods_pkey PRIMARY KEY (series_period_id);


--
-- TOC entry 6138 (class 2606 OID 139558)
-- Name: series_periods series_periods_series_period_name_deleted_at_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_periods
    ADD CONSTRAINT series_periods_series_period_name_deleted_at_key UNIQUE (series_period_name, deleted_at);


--
-- TOC entry 6132 (class 2606 OID 139560)
-- Name: series series_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (series_id);


--
-- TOC entry 6140 (class 2606 OID 139562)
-- Name: series_raster_data series_raster_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_raster_data
    ADD CONSTRAINT series_raster_data_pkey PRIMARY KEY (series_id, series_raster_data_id);


--
-- TOC entry 6143 (class 2606 OID 139564)
-- Name: series_relation_types series_relation_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_relation_types
    ADD CONSTRAINT series_relation_types_pkey PRIMARY KEY (series_relation_type_id);


--
-- TOC entry 6145 (class 2606 OID 139566)
-- Name: series_relations series_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_relations
    ADD CONSTRAINT series_relations_pkey PRIMARY KEY (series_relation_id);


--
-- TOC entry 6147 (class 2606 OID 139568)
-- Name: series_relations series_relations_series_id_related_series_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_relations
    ADD CONSTRAINT series_relations_series_id_related_series_id_key UNIQUE (series_id, related_series_id);


--
-- TOC entry 6150 (class 2606 OID 139570)
-- Name: series_types series_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_types
    ADD CONSTRAINT series_types_pkey PRIMARY KEY (series_type_id);


--
-- TOC entry 6153 (class 2606 OID 139572)
-- Name: series_variables series_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_variables
    ADD CONSTRAINT series_variables_pkey PRIMARY KEY (series_variable_id);


--
-- TOC entry 6156 (class 2606 OID 139574)
-- Name: series_variables series_variables_series_variable_shortname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_variables
    ADD CONSTRAINT series_variables_series_variable_shortname_key UNIQUE (series_variable_shortname);


--
-- TOC entry 6159 (class 2606 OID 139576)
-- Name: series_vectorial_data series_vectorial_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_vectorial_data
    ADD CONSTRAINT series_vectorial_data_pkey PRIMARY KEY (series_id, series_vectorial_data_id);


--
-- TOC entry 6162 (class 2606 OID 139578)
-- Name: series_vectorial_data series_vectorial_data_series_vectorial_data_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_vectorial_data
    ADD CONSTRAINT series_vectorial_data_series_vectorial_data_id_key UNIQUE (series_vectorial_data_id);


--
-- TOC entry 6164 (class 2606 OID 139580)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (setting_name);


--
-- TOC entry 6166 (class 2606 OID 139582)
-- Name: spatial_object_entity_types spatial_object_entity_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_object_entity_types
    ADD CONSTRAINT spatial_object_entity_types_pkey PRIMARY KEY (spatial_object_entity_type_id);


--
-- TOC entry 6168 (class 2606 OID 139584)
-- Name: spatial_object_types spatial_object_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_object_types
    ADD CONSTRAINT spatial_object_types_pkey PRIMARY KEY (spatial_object_type_id);


--
-- TOC entry 5903 (class 2606 OID 139586)
-- Name: spatial_objects_administrative_divisions spatial_objects_administrative_divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_administrative_divisions
    ADD CONSTRAINT spatial_objects_administrative_divisions_pkey PRIMARY KEY (spatial_object_administrative_division_id);


--
-- TOC entry 6170 (class 2606 OID 139588)
-- Name: spatial_objects_periods_entities spatial_objects_periods_entit_spatial_object_entity_type_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_entities
    ADD CONSTRAINT spatial_objects_periods_entit_spatial_object_entity_type_id_key UNIQUE (spatial_object_entity_type_id, spatial_object_period_id);


--
-- TOC entry 6173 (class 2606 OID 139590)
-- Name: spatial_objects_periods_entities spatial_objects_periods_entities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_entities
    ADD CONSTRAINT spatial_objects_periods_entities_pkey PRIMARY KEY (spatial_object_period_entity_id);


--
-- TOC entry 5891 (class 2606 OID 139592)
-- Name: spatial_objects_periods spatial_objects_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods
    ADD CONSTRAINT spatial_objects_periods_pkey PRIMARY KEY (spatial_object_period_id);


--
-- TOC entry 6175 (class 2606 OID 139594)
-- Name: spatial_objects_periods_series spatial_objects_periods_serie_spatial_object_period_id_seri_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_series
    ADD CONSTRAINT spatial_objects_periods_serie_spatial_object_period_id_seri_key UNIQUE (spatial_object_period_id, series_id);


--
-- TOC entry 6177 (class 2606 OID 139596)
-- Name: spatial_objects_periods_series spatial_objects_periods_series_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_series
    ADD CONSTRAINT spatial_objects_periods_series_pkey PRIMARY KEY (spatial_object_period_series_id);


--
-- TOC entry 5893 (class 2606 OID 139598)
-- Name: spatial_objects_periods spatial_objects_periods_spatial_object_id_period_id_deleted_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods
    ADD CONSTRAINT spatial_objects_periods_spatial_object_id_period_id_deleted_key UNIQUE (spatial_object_id, period_id, deleted_at);


--
-- TOC entry 5898 (class 2606 OID 139600)
-- Name: spatial_objects spatial_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects
    ADD CONSTRAINT spatial_objects_pkey PRIMARY KEY (spatial_object_id);


--
-- TOC entry 6179 (class 2606 OID 139602)
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (state_id);


--
-- TOC entry 6183 (class 2606 OID 139604)
-- Name: summary summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.summary
    ADD CONSTRAINT summary_pkey PRIMARY KEY (summary_id);


--
-- TOC entry 6185 (class 2606 OID 139606)
-- Name: topological_relation_types topological_relation_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topological_relation_types
    ADD CONSTRAINT topological_relation_types_pkey PRIMARY KEY (topological_relation_type_id);


--
-- TOC entry 6187 (class 2606 OID 139608)
-- Name: topological_relations topological_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topological_relations
    ADD CONSTRAINT topological_relations_pkey PRIMARY KEY (topological_relation_id);


--
-- TOC entry 6189 (class 2606 OID 139610)
-- Name: topological_relations topological_relations_spatial_object_id_related_spatial_obj_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topological_relations
    ADD CONSTRAINT topological_relations_spatial_object_id_related_spatial_obj_key UNIQUE (spatial_object_id, related_spatial_object_id, topological_relation_type_id);


--
-- TOC entry 6193 (class 2606 OID 139612)
-- Name: training_data_model training_data_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_data_model
    ADD CONSTRAINT training_data_model_pkey PRIMARY KEY (training_data_model_id);


--
-- TOC entry 6196 (class 2606 OID 139614)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (unit_symbol);


--
-- TOC entry 6198 (class 2606 OID 139616)
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (volunteer_id);


--
-- TOC entry 6200 (class 2606 OID 139618)
-- Name: volunteers_records volunteers_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers_records
    ADD CONSTRAINT volunteers_records_pkey PRIMARY KEY (volunteer_record_id);


--
-- TOC entry 6202 (class 2606 OID 139620)
-- Name: volunteers_records volunteers_records_record_id_volunteer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers_records
    ADD CONSTRAINT volunteers_records_record_id_volunteer_id_key UNIQUE (record_id, volunteer_id);


--
-- TOC entry 5907 (class 1259 OID 139624)
-- Name: accounts_account_location_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_account_location_idx ON public.accounts USING gist (account_location);


--
-- TOC entry 5910 (class 1259 OID 139625)
-- Name: accounts_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_entity_id_idx ON public.accounts USING btree (entity_id);


--
-- TOC entry 5933 (class 1259 OID 139626)
-- Name: administrative_division_administrative_division_limits_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX administrative_division_administrative_division_limits_idx ON public.administrative_divisions USING gist (administrative_division_limits);


--
-- TOC entry 5936 (class 1259 OID 139627)
-- Name: alerts_event_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX alerts_event_id_idx ON public.alerts USING btree (event_id);


--
-- TOC entry 5939 (class 1259 OID 139628)
-- Name: alerts_spatial_object_period_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX alerts_spatial_object_period_id_idx ON public.alerts USING btree (spatial_object_period_id);


--
-- TOC entry 5940 (class 1259 OID 139629)
-- Name: answers_answer_option_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX answers_answer_option_id_idx ON public.answers USING btree (answer_option_id);


--
-- TOC entry 5943 (class 1259 OID 139630)
-- Name: answers_question_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX answers_question_id_idx ON public.answers USING btree (question_id);


--
-- TOC entry 5944 (class 1259 OID 139631)
-- Name: answers_record_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX answers_record_id_idx ON public.answers USING btree (record_id);


--
-- TOC entry 5955 (class 1259 OID 139632)
-- Name: areas_of_interest_area_of_interest_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX areas_of_interest_area_of_interest_type_id_idx ON public.areas_of_interest USING btree (area_of_interest_type_id);


--
-- TOC entry 5962 (class 1259 OID 139633)
-- Name: confirmation_tokens_account_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX confirmation_tokens_account_id_idx ON public.confirmation_tokens USING btree (account_id);


--
-- TOC entry 5975 (class 1259 OID 139634)
-- Name: data_providers_data_provider_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_providers_data_provider_type_id_idx ON public.data_providers USING btree (data_provider_type_id);


--
-- TOC entry 5976 (class 1259 OID 139635)
-- Name: data_providers_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_providers_entity_id_idx ON public.data_providers USING btree (entity_id);


--
-- TOC entry 5979 (class 1259 OID 139636)
-- Name: data_sources_data_provider_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_sources_data_provider_id_idx ON public.data_sources USING btree (data_provider_id);


--
-- TOC entry 5980 (class 1259 OID 139637)
-- Name: data_sources_data_source_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_sources_data_source_type_id_idx ON public.data_sources USING btree (data_source_type_id);


--
-- TOC entry 5991 (class 1259 OID 139638)
-- Name: devices_device_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX devices_device_type_id_idx ON public.devices USING btree (device_type_id);


--
-- TOC entry 6000 (class 1259 OID 139639)
-- Name: events_event_location_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX events_event_location_idx ON public.events USING gist (event_location);


--
-- TOC entry 6001 (class 1259 OID 139640)
-- Name: events_event_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX events_event_type_id_idx ON public.events USING btree (event_type_id);


--
-- TOC entry 6004 (class 1259 OID 139641)
-- Name: events_spatial_object_period_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX events_spatial_object_period_id_idx ON public.events USING btree (spatial_object_period_id);


--
-- TOC entry 6017 (class 1259 OID 139642)
-- Name: fuel_breaks_fuel_break_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fuel_breaks_fuel_break_type_id_idx ON public.fuel_breaks USING btree (fuel_break_type_id);


--
-- TOC entry 6024 (class 1259 OID 139643)
-- Name: interventions_intervention_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX interventions_intervention_type_id_idx ON public.interventions USING btree (intervention_type_id);


--
-- TOC entry 6027 (class 1259 OID 139644)
-- Name: interventions_needs_intervention_need_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX interventions_needs_intervention_need_type_id_idx ON public.interventions_needs USING btree (intervention_need_type_id);


--
-- TOC entry 6030 (class 1259 OID 139645)
-- Name: interventions_needs_spatial_object_period_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX interventions_needs_spatial_object_period_id_idx ON public.interventions_needs USING btree (spatial_object_period_id);


--
-- TOC entry 6031 (class 1259 OID 139646)
-- Name: media_event_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX media_event_id_idx ON public.media USING btree (event_id);


--
-- TOC entry 6032 (class 1259 OID 139647)
-- Name: media_media_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX media_media_type_id_idx ON public.media USING btree (media_type_id);


--
-- TOC entry 6035 (class 1259 OID 139648)
-- Name: media_question_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX media_question_id_idx ON public.media USING btree (question_id);


--
-- TOC entry 6036 (class 1259 OID 139649)
-- Name: media_record_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX media_record_id_idx ON public.media USING btree (record_id);


--
-- TOC entry 6051 (class 1259 OID 139650)
-- Name: model_output_classification_model_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_output_classification_model_id_idx ON public.model_output USING btree (classification_model_id);


--
-- TOC entry 6054 (class 1259 OID 139651)
-- Name: model_output_spatial_object_period_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_output_spatial_object_period_id_idx ON public.model_output USING btree (spatial_object_period_id);


--
-- TOC entry 6063 (class 1259 OID 139652)
-- Name: organizations_members_member_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX organizations_members_member_type_id_idx ON public.organizations_members USING btree (member_type_id);


--
-- TOC entry 6072 (class 1259 OID 139653)
-- Name: periods_period_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX periods_period_type_id_idx ON public.periods USING btree (period_type_id);


--
-- TOC entry 6075 (class 1259 OID 139654)
-- Name: products_data_source_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_data_source_id_idx ON public.products USING btree (data_source_id);


--
-- TOC entry 6084 (class 1259 OID 139655)
-- Name: prohibitions_operation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX prohibitions_operation_id_idx ON public.prohibitions USING btree (operation_id);


--
-- TOC entry 6093 (class 1259 OID 139656)
-- Name: questions_augmented_reality_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX questions_augmented_reality_type_id_idx ON public.questions USING btree (augmented_reality_type_id);


--
-- TOC entry 6096 (class 1259 OID 139657)
-- Name: questions_question_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX questions_question_type_id_idx ON public.questions USING btree (question_type_id);


--
-- TOC entry 6097 (class 1259 OID 139658)
-- Name: questions_rule_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX questions_rule_id_idx ON public.questions USING btree (rule_id);


--
-- TOC entry 5885 (class 1259 OID 139659)
-- Name: records_monitorization_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX records_monitorization_id_idx ON public.records USING btree (monitorization_id);


--
-- TOC entry 5888 (class 1259 OID 139660)
-- Name: records_protocol_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX records_protocol_id_idx ON public.records USING btree (protocol_id);


--
-- TOC entry 5889 (class 1259 OID 139661)
-- Name: records_spatial_object_period_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX records_spatial_object_period_id_idx ON public.records USING btree (spatial_object_period_id);


--
-- TOC entry 6106 (class 1259 OID 139662)
-- Name: reset_tokens_account_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reset_tokens_account_email_idx ON public.reset_tokens USING btree (account_email);


--
-- TOC entry 6111 (class 1259 OID 139663)
-- Name: rewards_volunteer_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rewards_volunteer_id_idx ON public.rewards USING btree (volunteer_id);


--
-- TOC entry 6130 (class 1259 OID 139664)
-- Name: series_data_source_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_data_source_id_idx ON public.series USING btree (data_source_id);


--
-- TOC entry 6141 (class 1259 OID 139665)
-- Name: series_raster_data_product_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_raster_data_product_id_idx ON public.series_raster_data USING btree (product_id);


--
-- TOC entry 6148 (class 1259 OID 139666)
-- Name: series_relations_series_relation_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_relations_series_relation_type_id_idx ON public.series_relations USING btree (series_relation_type_id);


--
-- TOC entry 6133 (class 1259 OID 139667)
-- Name: series_series_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_series_type_id_idx ON public.series USING btree (series_type_id);


--
-- TOC entry 6134 (class 1259 OID 139668)
-- Name: series_series_variable_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_series_variable_id_idx ON public.series USING btree (series_variable_id);


--
-- TOC entry 6151 (class 1259 OID 139669)
-- Name: series_variables_data_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_variables_data_type_id_idx ON public.series_variables USING btree (data_type_id);


--
-- TOC entry 6154 (class 1259 OID 139670)
-- Name: series_variables_series_period_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_variables_series_period_id_idx ON public.series_variables USING btree (series_period_id);


--
-- TOC entry 6157 (class 1259 OID 139671)
-- Name: series_variables_unit_symbol_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_variables_unit_symbol_idx ON public.series_variables USING btree (unit_symbol);


--
-- TOC entry 6160 (class 1259 OID 139672)
-- Name: series_vectorial_data_product_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX series_vectorial_data_product_id_idx ON public.series_vectorial_data USING btree (product_id);


--
-- TOC entry 5901 (class 1259 OID 139673)
-- Name: spatial_objects_administrative_d_administrative_division_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX spatial_objects_administrative_d_administrative_division_id_idx ON public.spatial_objects_administrative_divisions USING btree (administrative_division_id);


--
-- TOC entry 5904 (class 1259 OID 139674)
-- Name: spatial_objects_administrative_divisions_spatial_object_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX spatial_objects_administrative_divisions_spatial_object_id_idx ON public.spatial_objects_administrative_divisions USING btree (spatial_object_id);


--
-- TOC entry 6171 (class 1259 OID 139675)
-- Name: spatial_objects_periods_entities_entity_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX spatial_objects_periods_entities_entity_id_idx ON public.spatial_objects_periods_entities USING btree (entity_id);


--
-- TOC entry 5899 (class 1259 OID 139676)
-- Name: spatial_objects_spatial_object_limits_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX spatial_objects_spatial_object_limits_idx ON public.spatial_objects USING gist (spatial_object_limits);


--
-- TOC entry 5900 (class 1259 OID 139677)
-- Name: spatial_objects_spatial_object_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX spatial_objects_spatial_object_type_id_idx ON public.spatial_objects USING btree (spatial_object_type_id);


--
-- TOC entry 6180 (class 1259 OID 139678)
-- Name: states_spatial_object_period_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX states_spatial_object_period_id_idx ON public.states USING btree (spatial_object_period_id);


--
-- TOC entry 6181 (class 1259 OID 139679)
-- Name: states_summary_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX states_summary_id_idx ON public.states USING btree (summary_id);


--
-- TOC entry 6190 (class 1259 OID 139680)
-- Name: topological_relations_topological_relation_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topological_relations_topological_relation_type_id_idx ON public.topological_relations USING btree (topological_relation_type_id);


--
-- TOC entry 6191 (class 1259 OID 139681)
-- Name: training_data_model_classification_model_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_data_model_classification_model_id_idx ON public.training_data_model USING btree (classification_model_id);


--
-- TOC entry 6194 (class 1259 OID 139682)
-- Name: training_data_model_series_vectorial_data_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX training_data_model_series_vectorial_data_id_idx ON public.training_data_model USING btree (series_vectorial_data_id);


--
-- TOC entry 5896 (class 1259 OID 139683)
-- Name: waypoints_record_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX waypoints_record_id_idx ON public.waypoints USING btree (record_id);


--
-- TOC entry 6213 (class 2606 OID 139684)
-- Name: accounts fk_accounts__entity_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT fk_accounts__entity_id FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- TOC entry 6214 (class 2606 OID 139689)
-- Name: accounts_devices fk_accounts_devices__account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_devices
    ADD CONSTRAINT fk_accounts_devices__account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- TOC entry 6215 (class 2606 OID 139694)
-- Name: accounts_devices fk_accounts_devices__device_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_devices
    ADD CONSTRAINT fk_accounts_devices__device_id FOREIGN KEY (device_id) REFERENCES public.devices(device_id);


--
-- TOC entry 6216 (class 2606 OID 139699)
-- Name: accounts_divisions_of_interest fk_accounts_divisions_of_interess__account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_divisions_of_interest
    ADD CONSTRAINT fk_accounts_divisions_of_interess__account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- TOC entry 6217 (class 2606 OID 139704)
-- Name: accounts_divisions_of_interest fk_accounts_divisions_of_interess__administrative_division_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_divisions_of_interest
    ADD CONSTRAINT fk_accounts_divisions_of_interess__administrative_division_id FOREIGN KEY (administrative_division_id) REFERENCES public.administrative_divisions(administrative_division_id);


--
-- TOC entry 6218 (class 2606 OID 139709)
-- Name: accounts_objects_of_interest fk_accounts_objects_of_interess__account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_objects_of_interest
    ADD CONSTRAINT fk_accounts_objects_of_interess__account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- TOC entry 6219 (class 2606 OID 139714)
-- Name: accounts_objects_of_interest fk_accounts_objects_of_interess__spatial_object_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_objects_of_interest
    ADD CONSTRAINT fk_accounts_objects_of_interess__spatial_object_id FOREIGN KEY (spatial_object_id) REFERENCES public.spatial_objects(spatial_object_id);


--
-- TOC entry 6220 (class 2606 OID 139719)
-- Name: accounts_prohibitions fk_accounts_prohibitions__account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_prohibitions
    ADD CONSTRAINT fk_accounts_prohibitions__account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- TOC entry 6221 (class 2606 OID 139724)
-- Name: accounts_prohibitions fk_accounts_prohibitions__prohibition_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_prohibitions
    ADD CONSTRAINT fk_accounts_prohibitions__prohibition_id FOREIGN KEY (prohibition_id) REFERENCES public.prohibitions(prohibition_id);


--
-- TOC entry 6222 (class 2606 OID 139729)
-- Name: accounts_roles fk_accounts_roles__account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_roles
    ADD CONSTRAINT fk_accounts_roles__account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- TOC entry 6223 (class 2606 OID 139734)
-- Name: accounts_roles fk_accounts_roles__account_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_roles
    ADD CONSTRAINT fk_accounts_roles__account_role_id FOREIGN KEY (account_role_id) REFERENCES public.accounts_roles(account_role_id);


--
-- TOC entry 6224 (class 2606 OID 139739)
-- Name: accounts_roles fk_accounts_roles__role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_roles
    ADD CONSTRAINT fk_accounts_roles__role_id FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- TOC entry 6265 (class 2606 OID 139744)
-- Name: news fk_administrative_divisions__administrative_division_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT fk_administrative_divisions__administrative_division_id FOREIGN KEY (administrative_division_id) REFERENCES public.administrative_divisions(administrative_division_id);


--
-- TOC entry 6225 (class 2606 OID 139749)
-- Name: alerts fk_alerts__event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT fk_alerts__event_id FOREIGN KEY (event_id) REFERENCES public.events(event_id);


--
-- TOC entry 6226 (class 2606 OID 139754)
-- Name: alerts fk_alerts__spatial_object_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT fk_alerts__spatial_object_period_id FOREIGN KEY (spatial_object_period_id) REFERENCES public.spatial_objects_periods(spatial_object_period_id);


--
-- TOC entry 6227 (class 2606 OID 139759)
-- Name: answers fk_answers__answer_option_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_answers__answer_option_id FOREIGN KEY (answer_option_id) REFERENCES public.answers_options(answer_option_id);


--
-- TOC entry 6228 (class 2606 OID 139764)
-- Name: answers fk_answers__question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_answers__question_id FOREIGN KEY (question_id) REFERENCES public.questions(question_id);


--
-- TOC entry 6229 (class 2606 OID 139769)
-- Name: answers fk_answers__record_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_answers__record_id FOREIGN KEY (record_id) REFERENCES public.records(record_id);


--
-- TOC entry 6230 (class 2606 OID 139774)
-- Name: answers_options fk_answers_options__media_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers_options
    ADD CONSTRAINT fk_answers_options__media_id FOREIGN KEY (media_id) REFERENCES public.media(media_id);


--
-- TOC entry 6231 (class 2606 OID 139779)
-- Name: area_of_interest_types_protocols fk_area_of_interest_types_protocols__area_of_interest_type__id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_of_interest_types_protocols
    ADD CONSTRAINT fk_area_of_interest_types_protocols__area_of_interest_type__id FOREIGN KEY (area_of_interest_type__id) REFERENCES public.area_of_interest_types(area_of_interest_type_id);


--
-- TOC entry 6232 (class 2606 OID 139784)
-- Name: area_of_interest_types_protocols fk_area_of_interest_types_protocols__protocol_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area_of_interest_types_protocols
    ADD CONSTRAINT fk_area_of_interest_types_protocols__protocol_id FOREIGN KEY (protocol_id) REFERENCES public.protocols(protocol_id);


--
-- TOC entry 6233 (class 2606 OID 139789)
-- Name: areas_of_interest fk_areas_of_interest__area_of_interest_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas_of_interest
    ADD CONSTRAINT fk_areas_of_interest__area_of_interest_type_id FOREIGN KEY (area_of_interest_type_id) REFERENCES public.area_of_interest_types(area_of_interest_type_id);


--
-- TOC entry 6234 (class 2606 OID 139794)
-- Name: areas_of_interest fk_areas_of_interest__spatial_object_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas_of_interest
    ADD CONSTRAINT fk_areas_of_interest__spatial_object_id FOREIGN KEY (spatial_object_id) REFERENCES public.spatial_objects(spatial_object_id);


--
-- TOC entry 6235 (class 2606 OID 139799)
-- Name: confirmation_tokens fk_confirmation_tokens__account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirmation_tokens
    ADD CONSTRAINT fk_confirmation_tokens__account_id FOREIGN KEY (account_id) REFERENCES public.accounts(account_id);


--
-- TOC entry 6236 (class 2606 OID 139804)
-- Name: contacts fk_contacts__administrative_division_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT fk_contacts__administrative_division_id FOREIGN KEY (administrative_division_id) REFERENCES public.administrative_divisions(administrative_division_id);


--
-- TOC entry 6237 (class 2606 OID 139809)
-- Name: contacts fk_contacts__entity_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT fk_contacts__entity_id FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- TOC entry 6238 (class 2606 OID 139814)
-- Name: data_derived fk_data_derived__serial_vectorial_data_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_derived
    ADD CONSTRAINT fk_data_derived__serial_vectorial_data_id FOREIGN KEY (serial_vectorial_data_id) REFERENCES public.series_vectorial_data(series_vectorial_data_id);


--
-- TOC entry 6239 (class 2606 OID 139819)
-- Name: data_groundtruth fk_data_groundtruth__serial_vectorial_data_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_groundtruth
    ADD CONSTRAINT fk_data_groundtruth__serial_vectorial_data_id FOREIGN KEY (serial_vectorial_data_id) REFERENCES public.series_vectorial_data(series_vectorial_data_id);


--
-- TOC entry 6240 (class 2606 OID 139824)
-- Name: data_providers fk_data_providers__data_provider_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_providers
    ADD CONSTRAINT fk_data_providers__data_provider_type_id FOREIGN KEY (data_provider_type_id) REFERENCES public.data_provider_types(data_provider_type_id);


--
-- TOC entry 6241 (class 2606 OID 139829)
-- Name: data_providers fk_data_providers__entity_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_providers
    ADD CONSTRAINT fk_data_providers__entity_id FOREIGN KEY (entity_id) REFERENCES public.entities(entity_id);


--
-- TOC entry 6242 (class 2606 OID 139834)
-- Name: data_sources fk_data_sources__data_provider_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources
    ADD CONSTRAINT fk_data_sources__data_provider_id FOREIGN KEY (data_provider_id) REFERENCES public.data_providers(data_provider_id);


--
-- TOC entry 6243 (class 2606 OID 139839)
-- Name: data_sources fk_data_sources__data_source_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_sources
    ADD CONSTRAINT fk_data_sources__data_source_type_id FOREIGN KEY (data_source_type_id) REFERENCES public.data_sources_types(data_source_type_id);


--
-- TOC entry 6244 (class 2606 OID 139844)
-- Name: devices fk_devices__device_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT fk_devices__device_type_id FOREIGN KEY (device_type_id) REFERENCES public.device_types(device_type_id);


--
-- TOC entry 6245 (class 2606 OID 139849)
-- Name: fuel_break_types_protocols fk_fuel_break_types_protocols__fuel_break_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_protocols
    ADD CONSTRAINT fk_fuel_break_types_protocols__fuel_break_type_id FOREIGN KEY (fuel_break_type_id) REFERENCES public.fuel_break_types(fuel_break_type_id);


--
-- TOC entry 6246 (class 2606 OID 139854)
-- Name: fuel_break_types_protocols fk_fuel_break_types_protocols__protocol_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_protocols
    ADD CONSTRAINT fk_fuel_break_types_protocols__protocol_id FOREIGN KEY (protocol_id) REFERENCES public.protocols(protocol_id);


--
-- TOC entry 6247 (class 2606 OID 139859)
-- Name: fuel_break_types_rules fk_fuel_break_types_rules__fuel_break_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_rules
    ADD CONSTRAINT fk_fuel_break_types_rules__fuel_break_type_id FOREIGN KEY (fuel_break_type_id) REFERENCES public.fuel_break_types(fuel_break_type_id);


--
-- TOC entry 6248 (class 2606 OID 139864)
-- Name: fuel_break_types_rules fk_fuel_break_types_rules__rule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_break_types_rules
    ADD CONSTRAINT fk_fuel_break_types_rules__rule_id FOREIGN KEY (rule_id) REFERENCES public.rules(rule_id);


--
-- TOC entry 6249 (class 2606 OID 139869)
-- Name: fuel_breaks fk_fuel_breaks__fuel_break_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_breaks
    ADD CONSTRAINT fk_fuel_breaks__fuel_break_type_id FOREIGN KEY (fuel_break_type_id) REFERENCES public.fuel_break_types(fuel_break_type_id);


--
-- TOC entry 6250 (class 2606 OID 139874)
-- Name: fuel_breaks fk_fuel_breaks__spatial_object_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fuel_breaks
    ADD CONSTRAINT fk_fuel_breaks__spatial_object_id FOREIGN KEY (spatial_object_id) REFERENCES public.spatial_objects(spatial_object_id);


--
-- TOC entry 6251 (class 2606 OID 139879)
-- Name: interventions fk_interventions__intervention_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventions
    ADD CONSTRAINT fk_interventions__intervention_type_id FOREIGN KEY (intervention_type_id) REFERENCES public.intervention_types(intervention_type_id);


--
-- TOC entry 6252 (class 2606 OID 139884)
-- Name: interventions_needs fk_interventions_needs__intervention_need_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventions_needs
    ADD CONSTRAINT fk_interventions_needs__intervention_need_type_id FOREIGN KEY (intervention_need_type_id) REFERENCES public.intervention_need_types(intervention_need_type_id);


--
-- TOC entry 6253 (class 2606 OID 139889)
-- Name: interventions_needs fk_interventions_needs__spatial_object_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventions_needs
    ADD CONSTRAINT fk_interventions_needs__spatial_object_period_id FOREIGN KEY (spatial_object_period_id) REFERENCES public.spatial_objects_periods(spatial_object_period_id);


--
-- TOC entry 6254 (class 2606 OID 139894)
-- Name: media fk_media__event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT fk_media__event_id FOREIGN KEY (event_id) REFERENCES public.events(event_id);


--
-- TOC entry 6255 (class 2606 OID 139899)
-- Name: media fk_media__media_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT fk_media__media_type_id FOREIGN KEY (media_type_id) REFERENCES public.media_types(media_type_id);


--
-- TOC entry 6256 (class 2606 OID 139904)
-- Name: media fk_media__question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT fk_media__question_id FOREIGN KEY (question_id) REFERENCES public.questions(question_id);


--
-- TOC entry 6257 (class 2606 OID 139909)
-- Name: media fk_media__record_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT fk_media__record_id FOREIGN KEY (record_id) REFERENCES public.records(record_id);


--
-- TOC entry 6258 (class 2606 OID 139914)
-- Name: media_answers fk_media_answers__answer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_answers
    ADD CONSTRAINT fk_media_answers__answer_id FOREIGN KEY (answer_id) REFERENCES public.answers(answer_id);


--
-- TOC entry 6259 (class 2606 OID 139919)
-- Name: media_answers fk_media_answers__media_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_answers
    ADD CONSTRAINT fk_media_answers__media_id FOREIGN KEY (media_id) REFERENCES public.media(media_id);


--
-- TOC entry 6260 (class 2606 OID 139924)
-- Name: media_questions fk_media_questions__media_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_questions
    ADD CONSTRAINT fk_media_questions__media_id FOREIGN KEY (media_id) REFERENCES public.media(media_id);


--
-- TOC entry 6261 (class 2606 OID 139929)
-- Name: media_questions fk_media_questions__question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_questions
    ADD CONSTRAINT fk_media_questions__question_id FOREIGN KEY (question_id) REFERENCES public.questions(question_id);


--
-- TOC entry 6263 (class 2606 OID 139934)
-- Name: model_output fk_model_output__classification_model_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_output
    ADD CONSTRAINT fk_model_output__classification_model_id FOREIGN KEY (classification_model_id) REFERENCES public.classification_model(classification_model_id);


--
-- TOC entry 6264 (class 2606 OID 139939)
-- Name: model_output fk_model_output__spatial_object_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_output
    ADD CONSTRAINT fk_model_output__spatial_object_period_id FOREIGN KEY (spatial_object_period_id) REFERENCES public.spatial_objects_periods(spatial_object_period_id);


--
-- TOC entry 6266 (class 2606 OID 139944)
-- Name: operations fk_operations__operation_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operations
    ADD CONSTRAINT fk_operations__operation_id FOREIGN KEY (operation_id) REFERENCES public.operations(operation_id);


--
-- TOC entry 6267 (class 2606 OID 139949)
-- Name: organizations fk_organizations__organization_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT fk_organizations__organization_id FOREIGN KEY (organization_id) REFERENCES public.entities(entity_id);


--
-- TOC entry 6268 (class 2606 OID 139954)
-- Name: organizations_members fk_organizations_members__organization_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations_members
    ADD CONSTRAINT fk_organizations_members__organization_id FOREIGN KEY (organization_id) REFERENCES public.organizations(organization_id);


--
-- TOC entry 6269 (class 2606 OID 139959)
-- Name: organizations_members fk_organizations_members__person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations_members
    ADD CONSTRAINT fk_organizations_members__person_id FOREIGN KEY (person_id) REFERENCES public.people(person_id);


--
-- TOC entry 6270 (class 2606 OID 139964)
-- Name: people fk_people__person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_people__person_id FOREIGN KEY (person_id) REFERENCES public.entities(entity_id);


--
-- TOC entry 6271 (class 2606 OID 139969)
-- Name: periods fk_periods__period_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT fk_periods__period_type_id FOREIGN KEY (period_type_id) REFERENCES public.period_types(period_type_id);


--
-- TOC entry 6272 (class 2606 OID 139974)
-- Name: products fk_products__data_source_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_products__data_source_id FOREIGN KEY (data_source_id) REFERENCES public.data_sources(data_source_id);


--
-- TOC entry 6273 (class 2606 OID 139979)
-- Name: professionals fk_professionals__professional_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionals
    ADD CONSTRAINT fk_professionals__professional_id FOREIGN KEY (professional_id) REFERENCES public.people(person_id);


--
-- TOC entry 6274 (class 2606 OID 139984)
-- Name: professionals_monitorizations fk_professionals_monitorizations__monitorization_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionals_monitorizations
    ADD CONSTRAINT fk_professionals_monitorizations__monitorization_id FOREIGN KEY (monitorization_id) REFERENCES public.monitorizations(monitorization_id);


--
-- TOC entry 6275 (class 2606 OID 139989)
-- Name: professionals_monitorizations fk_professionals_monitorizations__professional_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionals_monitorizations
    ADD CONSTRAINT fk_professionals_monitorizations__professional_id FOREIGN KEY (professional_id) REFERENCES public.professionals(professional_id);


--
-- TOC entry 6276 (class 2606 OID 139994)
-- Name: prohibitions fk_prohibitions__operation_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prohibitions
    ADD CONSTRAINT fk_prohibitions__operation_id FOREIGN KEY (operation_id) REFERENCES public.operations(operation_id);


--
-- TOC entry 6277 (class 2606 OID 139999)
-- Name: questions fk_questions__augmented_reality_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_questions__augmented_reality_type_id FOREIGN KEY (augmented_reality_type_id) REFERENCES public.augmented_reality_types(augmented_reality_type_id);


--
-- TOC entry 6278 (class 2606 OID 140004)
-- Name: questions fk_questions__question_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_questions__question_type_id FOREIGN KEY (question_type_id) REFERENCES public.question_types(question_type_id);


--
-- TOC entry 6279 (class 2606 OID 140009)
-- Name: questions fk_questions__rule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_questions__rule_id FOREIGN KEY (rule_id) REFERENCES public.rules(rule_id);


--
-- TOC entry 6280 (class 2606 OID 140014)
-- Name: questions_answers_options fk_questions_answers_options__answer_option_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions_answers_options
    ADD CONSTRAINT fk_questions_answers_options__answer_option_id FOREIGN KEY (answer_option_id) REFERENCES public.answers_options(answer_option_id);


--
-- TOC entry 6281 (class 2606 OID 140019)
-- Name: questions_answers_options fk_questions_answers_options__question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions_answers_options
    ADD CONSTRAINT fk_questions_answers_options__question_id FOREIGN KEY (question_id) REFERENCES public.questions(question_id);


--
-- TOC entry 6282 (class 2606 OID 140024)
-- Name: questions_protocols fk_questions_protocols__protocol_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions_protocols
    ADD CONSTRAINT fk_questions_protocols__protocol_id FOREIGN KEY (protocol_id) REFERENCES public.protocols(protocol_id);


--
-- TOC entry 6283 (class 2606 OID 140029)
-- Name: questions_protocols fk_questions_protocols__question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions_protocols
    ADD CONSTRAINT fk_questions_protocols__question_id FOREIGN KEY (question_id) REFERENCES public.questions(question_id);


--
-- TOC entry 6203 (class 2606 OID 140034)
-- Name: records fk_records__monitorization_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_records__monitorization_id FOREIGN KEY (monitorization_id) REFERENCES public.monitorizations(monitorization_id);


--
-- TOC entry 6204 (class 2606 OID 140039)
-- Name: records fk_records__protocol_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_records__protocol_id FOREIGN KEY (protocol_id) REFERENCES public.protocols(protocol_id);


--
-- TOC entry 6205 (class 2606 OID 140044)
-- Name: records fk_records__spatial_object_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_records__spatial_object_period_id FOREIGN KEY (spatial_object_period_id) REFERENCES public.spatial_objects_periods(spatial_object_period_id);


--
-- TOC entry 6284 (class 2606 OID 140049)
-- Name: reset_tokens fk_reset_tokens__account_email; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_tokens
    ADD CONSTRAINT fk_reset_tokens__account_email FOREIGN KEY (account_email) REFERENCES public.accounts(account_email);


--
-- TOC entry 6285 (class 2606 OID 140054)
-- Name: rewards fk_rewards__volunteer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rewards
    ADD CONSTRAINT fk_rewards__volunteer_id FOREIGN KEY (volunteer_id) REFERENCES public.volunteers(volunteer_id);


--
-- TOC entry 6286 (class 2606 OID 140059)
-- Name: roles fk_roles__role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT fk_roles__role_id FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- TOC entry 6287 (class 2606 OID 140064)
-- Name: roles_operations fk_roles_operations__operation_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_operations
    ADD CONSTRAINT fk_roles_operations__operation_id FOREIGN KEY (operation_id) REFERENCES public.operations(operation_id);


--
-- TOC entry 6288 (class 2606 OID 140069)
-- Name: roles_operations fk_roles_operations__role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_operations
    ADD CONSTRAINT fk_roles_operations__role_id FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- TOC entry 6289 (class 2606 OID 140074)
-- Name: roles_operations fk_roles_operations__role_operation_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_operations
    ADD CONSTRAINT fk_roles_operations__role_operation_id FOREIGN KEY (role_operation_id) REFERENCES public.roles_operations(role_operation_id);


--
-- TOC entry 6290 (class 2606 OID 140079)
-- Name: roles_prohibitions fk_roles_prohibitions__prohibition_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_prohibitions
    ADD CONSTRAINT fk_roles_prohibitions__prohibition_id FOREIGN KEY (prohibition_id) REFERENCES public.prohibitions(prohibition_id);


--
-- TOC entry 6291 (class 2606 OID 140084)
-- Name: roles_prohibitions fk_roles_prohibitions__role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_prohibitions
    ADD CONSTRAINT fk_roles_prohibitions__role_id FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- TOC entry 6292 (class 2606 OID 140089)
-- Name: segments_interventions fk_segments_interventions__intervention_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segments_interventions
    ADD CONSTRAINT fk_segments_interventions__intervention_id FOREIGN KEY (intervention_id) REFERENCES public.interventions(intervention_id);


--
-- TOC entry 6293 (class 2606 OID 140094)
-- Name: segments_interventions fk_segments_interventions__intervention_need_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segments_interventions
    ADD CONSTRAINT fk_segments_interventions__intervention_need_id FOREIGN KEY (intervention_need_id) REFERENCES public.interventions_needs(intervention_need_id);


--
-- TOC entry 6294 (class 2606 OID 140099)
-- Name: series fk_series__data_source_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT fk_series__data_source_id FOREIGN KEY (data_source_id) REFERENCES public.data_sources(data_source_id);


--
-- TOC entry 6295 (class 2606 OID 140104)
-- Name: series fk_series__series_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT fk_series__series_type_id FOREIGN KEY (series_type_id) REFERENCES public.series_types(series_type_id);


--
-- TOC entry 6296 (class 2606 OID 140109)
-- Name: series fk_series__series_variable_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT fk_series__series_variable_id FOREIGN KEY (series_variable_id) REFERENCES public.series_variables(series_variable_id);


--
-- TOC entry 6297 (class 2606 OID 140114)
-- Name: series_raster_data fk_series_raster_data__product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_raster_data
    ADD CONSTRAINT fk_series_raster_data__product_id FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 6298 (class 2606 OID 140119)
-- Name: series_raster_data fk_series_raster_data__series_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_raster_data
    ADD CONSTRAINT fk_series_raster_data__series_id FOREIGN KEY (series_id) REFERENCES public.series(series_id);


--
-- TOC entry 6299 (class 2606 OID 140124)
-- Name: series_variables fk_series_variables__data_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_variables
    ADD CONSTRAINT fk_series_variables__data_type_id FOREIGN KEY (data_type_id) REFERENCES public.data_types(data_type_id);


--
-- TOC entry 6300 (class 2606 OID 140129)
-- Name: series_variables fk_series_variables__series_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_variables
    ADD CONSTRAINT fk_series_variables__series_period_id FOREIGN KEY (series_period_id) REFERENCES public.series_periods(series_period_id);


--
-- TOC entry 6301 (class 2606 OID 140134)
-- Name: series_variables fk_series_variables__unit_symbol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_variables
    ADD CONSTRAINT fk_series_variables__unit_symbol FOREIGN KEY (unit_symbol) REFERENCES public.units(unit_symbol);


--
-- TOC entry 6302 (class 2606 OID 140139)
-- Name: series_vectorial_data fk_series_vectorial_data__product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_vectorial_data
    ADD CONSTRAINT fk_series_vectorial_data__product_id FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 6303 (class 2606 OID 140144)
-- Name: series_vectorial_data fk_series_vectorial_data__series_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_vectorial_data
    ADD CONSTRAINT fk_series_vectorial_data__series_id FOREIGN KEY (series_id) REFERENCES public.series(series_id);


--
-- TOC entry 6209 (class 2606 OID 140149)
-- Name: spatial_objects fk_spatial_objects__segmentation_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects
    ADD CONSTRAINT fk_spatial_objects__segmentation_id FOREIGN KEY (segmentation_id) REFERENCES public.segmentations(segmentation_id);


--
-- TOC entry 6210 (class 2606 OID 140154)
-- Name: spatial_objects fk_spatial_objects__spatial_object_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects
    ADD CONSTRAINT fk_spatial_objects__spatial_object_type_id FOREIGN KEY (spatial_object_type_id) REFERENCES public.spatial_object_types(spatial_object_type_id);


--
-- TOC entry 6211 (class 2606 OID 140159)
-- Name: spatial_objects_administrative_divisions fk_spatial_objects_administrative_divisions__administrative_div; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_administrative_divisions
    ADD CONSTRAINT fk_spatial_objects_administrative_divisions__administrative_div FOREIGN KEY (administrative_division_id) REFERENCES public.administrative_divisions(administrative_division_id);


--
-- TOC entry 6212 (class 2606 OID 140164)
-- Name: spatial_objects_administrative_divisions fk_spatial_objects_administrative_divisions__spatial_object_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_administrative_divisions
    ADD CONSTRAINT fk_spatial_objects_administrative_divisions__spatial_object_id FOREIGN KEY (spatial_object_id) REFERENCES public.spatial_objects(spatial_object_id);


--
-- TOC entry 6206 (class 2606 OID 140169)
-- Name: spatial_objects_periods fk_spatial_objects_periods__period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods
    ADD CONSTRAINT fk_spatial_objects_periods__period_id FOREIGN KEY (period_id) REFERENCES public.periods(period_id);


--
-- TOC entry 6207 (class 2606 OID 140174)
-- Name: spatial_objects_periods fk_spatial_objects_periods__spatial_object_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods
    ADD CONSTRAINT fk_spatial_objects_periods__spatial_object_id FOREIGN KEY (spatial_object_id) REFERENCES public.spatial_objects(spatial_object_id);


--
-- TOC entry 6304 (class 2606 OID 140179)
-- Name: spatial_objects_periods_entities fk_spatial_objects_periods_entities__spatial_object_entity_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_entities
    ADD CONSTRAINT fk_spatial_objects_periods_entities__spatial_object_entity_type FOREIGN KEY (spatial_object_entity_type_id) REFERENCES public.spatial_object_entity_types(spatial_object_entity_type_id);


--
-- TOC entry 6305 (class 2606 OID 140184)
-- Name: spatial_objects_periods_entities fk_spatial_objects_periods_entities__spatial_object_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_entities
    ADD CONSTRAINT fk_spatial_objects_periods_entities__spatial_object_period_id FOREIGN KEY (spatial_object_period_id) REFERENCES public.spatial_objects_periods(spatial_object_period_id);


--
-- TOC entry 6306 (class 2606 OID 140189)
-- Name: spatial_objects_periods_series fk_spatial_objects_periods_series__series_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_series
    ADD CONSTRAINT fk_spatial_objects_periods_series__series_id FOREIGN KEY (series_id) REFERENCES public.series(series_id);


--
-- TOC entry 6307 (class 2606 OID 140194)
-- Name: spatial_objects_periods_series fk_spatial_objects_periods_series__spatial_object_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spatial_objects_periods_series
    ADD CONSTRAINT fk_spatial_objects_periods_series__spatial_object_period_id FOREIGN KEY (spatial_object_period_id) REFERENCES public.spatial_objects_periods(spatial_object_period_id);


--
-- TOC entry 6308 (class 2606 OID 140199)
-- Name: states fk_states__spatial_object_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT fk_states__spatial_object_period_id FOREIGN KEY (spatial_object_period_id) REFERENCES public.spatial_objects_periods(spatial_object_period_id);


--
-- TOC entry 6309 (class 2606 OID 140204)
-- Name: states fk_states__summary_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT fk_states__summary_id FOREIGN KEY (summary_id) REFERENCES public.summary(summary_id);


--
-- TOC entry 6310 (class 2606 OID 140209)
-- Name: topological_relations fk_topological_relations__related_spatial_object_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topological_relations
    ADD CONSTRAINT fk_topological_relations__related_spatial_object_id FOREIGN KEY (related_spatial_object_id) REFERENCES public.spatial_objects(spatial_object_id) NOT VALID;


--
-- TOC entry 6311 (class 2606 OID 140214)
-- Name: topological_relations fk_topological_relations__spatial_object_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topological_relations
    ADD CONSTRAINT fk_topological_relations__spatial_object_id FOREIGN KEY (spatial_object_id) REFERENCES public.spatial_objects(spatial_object_id) NOT VALID;


--
-- TOC entry 6312 (class 2606 OID 140219)
-- Name: topological_relations fk_topological_relations__topological_relation_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topological_relations
    ADD CONSTRAINT fk_topological_relations__topological_relation_type_id FOREIGN KEY (topological_relation_type_id) REFERENCES public.topological_relation_types(topological_relation_type_id) NOT VALID;


--
-- TOC entry 6313 (class 2606 OID 140224)
-- Name: training_data_model fk_training_data_model__classification_model_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_data_model
    ADD CONSTRAINT fk_training_data_model__classification_model_id FOREIGN KEY (classification_model_id) REFERENCES public.classification_model(classification_model_id);


--
-- TOC entry 6314 (class 2606 OID 140229)
-- Name: training_data_model fk_training_data_model__series_vectorial_data_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.training_data_model
    ADD CONSTRAINT fk_training_data_model__series_vectorial_data_id FOREIGN KEY (series_vectorial_data_id) REFERENCES public.series_vectorial_data(series_vectorial_data_id);


--
-- TOC entry 6315 (class 2606 OID 140234)
-- Name: volunteers fk_volunteers__volunteer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT fk_volunteers__volunteer_id FOREIGN KEY (volunteer_id) REFERENCES public.people(person_id);


--
-- TOC entry 6316 (class 2606 OID 140239)
-- Name: volunteers_records fk_volunteers_records__record_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers_records
    ADD CONSTRAINT fk_volunteers_records__record_id FOREIGN KEY (record_id) REFERENCES public.records(record_id);


--
-- TOC entry 6317 (class 2606 OID 140244)
-- Name: volunteers_records fk_volunteers_records__volunteer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteers_records
    ADD CONSTRAINT fk_volunteers_records__volunteer_id FOREIGN KEY (volunteer_id) REFERENCES public.volunteers(volunteer_id);


--
-- TOC entry 6208 (class 2606 OID 140249)
-- Name: waypoints fk_waypoints__record_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.waypoints
    ADD CONSTRAINT fk_waypoints__record_id FOREIGN KEY (record_id) REFERENCES public.records(record_id);


--
-- TOC entry 6262 (class 2606 OID 140254)
-- Name: media_questions media_questions_record_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media_questions
    ADD CONSTRAINT media_questions_record_id_fkey FOREIGN KEY (record_id) REFERENCES public.records(record_id) NOT VALID;


--
-- TOC entry 6478 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: cloudsqlsuperuser
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT USAGE ON SCHEMA public TO viewer_user;


--
-- TOC entry 6479 (class 0 OID 0)
-- Dependencies: 253
-- Name: SEQUENCE records_record_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.records_record_id_seq TO viewer_user;


--
-- TOC entry 6480 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE records; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.records TO viewer_user;


--
-- TOC entry 6481 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE spatial_objects_periods; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_objects_periods TO viewer_user;


--
-- TOC entry 6482 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE waypoints; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.waypoints TO viewer_user;


--
-- TOC entry 6483 (class 0 OID 0)
-- Dependencies: 258
-- Name: SEQUENCE spatial_objects_spatial_object_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.spatial_objects_spatial_object_id_seq TO viewer_user;


--
-- TOC entry 6484 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE spatial_objects; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_objects TO viewer_user;
GRANT SELECT ON TABLE public.spatial_objects TO viewer;


--
-- TOC entry 6485 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE spatial_objects_administrative_divisions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_objects_administrative_divisions TO viewer_user;


--
-- TOC entry 6486 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE accounts; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.accounts TO viewer_user;


--
-- TOC entry 6488 (class 0 OID 0)
-- Dependencies: 263
-- Name: SEQUENCE accounts_account_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.accounts_account_id_seq TO viewer_user;


--
-- TOC entry 6489 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE accounts_devices; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.accounts_devices TO viewer_user;


--
-- TOC entry 6491 (class 0 OID 0)
-- Dependencies: 265
-- Name: SEQUENCE accounts_devices_account_device_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.accounts_devices_account_device_id_seq TO viewer_user;


--
-- TOC entry 6492 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE accounts_divisions_of_interest; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.accounts_divisions_of_interest TO viewer_user;


--
-- TOC entry 6494 (class 0 OID 0)
-- Dependencies: 267
-- Name: SEQUENCE accounts_divisions_of_interes_account_division_of_interess__seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.accounts_divisions_of_interes_account_division_of_interess__seq TO viewer_user;


--
-- TOC entry 6495 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE accounts_objects_of_interest; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.accounts_objects_of_interest TO viewer_user;


--
-- TOC entry 6497 (class 0 OID 0)
-- Dependencies: 269
-- Name: SEQUENCE accounts_objects_of_interess_account_object_of_interess_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.accounts_objects_of_interess_account_object_of_interess_id_seq TO viewer_user;


--
-- TOC entry 6498 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE accounts_prohibitions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.accounts_prohibitions TO viewer_user;


--
-- TOC entry 6500 (class 0 OID 0)
-- Dependencies: 271
-- Name: SEQUENCE accounts_prohibitions_account_prohibition_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.accounts_prohibitions_account_prohibition_id_seq TO viewer_user;


--
-- TOC entry 6501 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE accounts_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.accounts_roles TO viewer_user;


--
-- TOC entry 6503 (class 0 OID 0)
-- Dependencies: 273
-- Name: SEQUENCE accounts_roles_account_role_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.accounts_roles_account_role_id_seq TO viewer_user;


--
-- TOC entry 6504 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE administrative_divisions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.administrative_divisions TO viewer_user;


--
-- TOC entry 6506 (class 0 OID 0)
-- Dependencies: 275
-- Name: SEQUENCE administrative_divisions_administrative_division_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.administrative_divisions_administrative_division_id_seq TO viewer_user;


--
-- TOC entry 6507 (class 0 OID 0)
-- Dependencies: 276
-- Name: SEQUENCE alerts_alert_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.alerts_alert_id_seq TO viewer_user;


--
-- TOC entry 6508 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE alerts; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.alerts TO viewer_user;


--
-- TOC entry 6509 (class 0 OID 0)
-- Dependencies: 278
-- Name: SEQUENCE answers_answer_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.answers_answer_id_seq TO viewer_user;


--
-- TOC entry 6510 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE answers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.answers TO viewer_user;


--
-- TOC entry 6511 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE answers_options; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.answers_options TO viewer_user;


--
-- TOC entry 6513 (class 0 OID 0)
-- Dependencies: 281
-- Name: SEQUENCE answers_options_answer_option_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.answers_options_answer_option_id_seq TO viewer_user;


--
-- TOC entry 6514 (class 0 OID 0)
-- Dependencies: 282
-- Name: SEQUENCE app_configurations_app_configuration_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.app_configurations_app_configuration_id_seq TO viewer_user;


--
-- TOC entry 6515 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE app_configurations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.app_configurations TO viewer_user;


--
-- TOC entry 6516 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE area_of_interest_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.area_of_interest_types TO viewer_user;


--
-- TOC entry 6518 (class 0 OID 0)
-- Dependencies: 285
-- Name: SEQUENCE area_of_interest_types_area_of_interest_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.area_of_interest_types_area_of_interest_type_id_seq TO viewer_user;


--
-- TOC entry 6519 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE area_of_interest_types_protocols; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.area_of_interest_types_protocols TO viewer_user;


--
-- TOC entry 6521 (class 0 OID 0)
-- Dependencies: 287
-- Name: SEQUENCE area_of_interest_types_protoc_area_of_interest_type_protoco_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.area_of_interest_types_protoc_area_of_interest_type_protoco_seq TO viewer_user;


--
-- TOC entry 6522 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE areas_of_interest; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.areas_of_interest TO viewer_user;


--
-- TOC entry 6523 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE augmented_reality_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.augmented_reality_types TO viewer_user;


--
-- TOC entry 6525 (class 0 OID 0)
-- Dependencies: 290
-- Name: SEQUENCE augmented_reality_types_augmented_reality_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.augmented_reality_types_augmented_reality_type_id_seq TO viewer_user;


--
-- TOC entry 6526 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE classification_model; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.classification_model TO viewer_user;


--
-- TOC entry 6528 (class 0 OID 0)
-- Dependencies: 292
-- Name: SEQUENCE classification_model_classification_model_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.classification_model_classification_model_id_seq TO viewer_user;


--
-- TOC entry 6529 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE confirmation_tokens; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.confirmation_tokens TO viewer_user;


--
-- TOC entry 6531 (class 0 OID 0)
-- Dependencies: 294
-- Name: SEQUENCE confirmation_tokens_confirmation_token_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.confirmation_tokens_confirmation_token_id_seq TO viewer_user;


--
-- TOC entry 6532 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE contacts; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.contacts TO viewer_user;


--
-- TOC entry 6534 (class 0 OID 0)
-- Dependencies: 296
-- Name: SEQUENCE contacts_contact_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.contacts_contact_id_seq TO viewer_user;


--
-- TOC entry 6535 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE data_derived; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.data_derived TO viewer_user;


--
-- TOC entry 6537 (class 0 OID 0)
-- Dependencies: 298
-- Name: SEQUENCE data_derived_serial_vectorial_data_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.data_derived_serial_vectorial_data_id_seq TO viewer_user;


--
-- TOC entry 6538 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE data_groundtruth; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.data_groundtruth TO viewer_user;


--
-- TOC entry 6540 (class 0 OID 0)
-- Dependencies: 300
-- Name: SEQUENCE data_groundtruth_serial_vectorial_data_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.data_groundtruth_serial_vectorial_data_id_seq TO viewer_user;


--
-- TOC entry 6541 (class 0 OID 0)
-- Dependencies: 301
-- Name: TABLE data_provider_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.data_provider_types TO viewer_user;


--
-- TOC entry 6543 (class 0 OID 0)
-- Dependencies: 302
-- Name: SEQUENCE data_provider_types_data_provider_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.data_provider_types_data_provider_type_id_seq TO viewer_user;


--
-- TOC entry 6544 (class 0 OID 0)
-- Dependencies: 303
-- Name: TABLE data_providers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.data_providers TO viewer_user;


--
-- TOC entry 6546 (class 0 OID 0)
-- Dependencies: 304
-- Name: SEQUENCE data_providers_data_provider_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.data_providers_data_provider_id_seq TO viewer_user;


--
-- TOC entry 6547 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE data_sources; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.data_sources TO viewer_user;


--
-- TOC entry 6549 (class 0 OID 0)
-- Dependencies: 306
-- Name: SEQUENCE data_sources_data_source_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.data_sources_data_source_id_seq TO viewer_user;


--
-- TOC entry 6550 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE data_sources_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.data_sources_types TO viewer_user;


--
-- TOC entry 6552 (class 0 OID 0)
-- Dependencies: 308
-- Name: SEQUENCE data_sources_types_data_source_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.data_sources_types_data_source_type_id_seq TO viewer_user;


--
-- TOC entry 6553 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE data_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.data_types TO viewer_user;


--
-- TOC entry 6555 (class 0 OID 0)
-- Dependencies: 310
-- Name: SEQUENCE data_types_data_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.data_types_data_type_id_seq TO viewer_user;


--
-- TOC entry 6556 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE device_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.device_types TO viewer_user;


--
-- TOC entry 6558 (class 0 OID 0)
-- Dependencies: 312
-- Name: SEQUENCE device_types_device_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.device_types_device_type_id_seq TO viewer_user;


--
-- TOC entry 6559 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE devices; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.devices TO viewer_user;


--
-- TOC entry 6561 (class 0 OID 0)
-- Dependencies: 314
-- Name: SEQUENCE devices_device_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.devices_device_id_seq TO viewer_user;


--
-- TOC entry 6562 (class 0 OID 0)
-- Dependencies: 315
-- Name: TABLE entities; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.entities TO viewer_user;


--
-- TOC entry 6564 (class 0 OID 0)
-- Dependencies: 316
-- Name: SEQUENCE entities_entity_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.entities_entity_id_seq TO viewer_user;


--
-- TOC entry 6565 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE event_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.event_types TO viewer_user;


--
-- TOC entry 6567 (class 0 OID 0)
-- Dependencies: 318
-- Name: SEQUENCE event_types_event_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.event_types_event_type_id_seq TO viewer_user;


--
-- TOC entry 6568 (class 0 OID 0)
-- Dependencies: 319
-- Name: TABLE events; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.events TO viewer_user;


--
-- TOC entry 6570 (class 0 OID 0)
-- Dependencies: 320
-- Name: SEQUENCE events_event_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.events_event_id_seq TO viewer_user;


--
-- TOC entry 6571 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE fuel_break_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.fuel_break_types TO viewer_user;


--
-- TOC entry 6573 (class 0 OID 0)
-- Dependencies: 322
-- Name: SEQUENCE fuel_break_types_fuel_break_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.fuel_break_types_fuel_break_type_id_seq TO viewer_user;


--
-- TOC entry 6574 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE fuel_break_types_protocols; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.fuel_break_types_protocols TO viewer_user;


--
-- TOC entry 6576 (class 0 OID 0)
-- Dependencies: 324
-- Name: SEQUENCE fuel_break_types_protocols_fuel_break_type_protocol_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.fuel_break_types_protocols_fuel_break_type_protocol_id_seq TO viewer_user;


--
-- TOC entry 6577 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE fuel_break_types_rules; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.fuel_break_types_rules TO viewer_user;


--
-- TOC entry 6579 (class 0 OID 0)
-- Dependencies: 326
-- Name: SEQUENCE fuel_break_types_rules_fuel_break_type_rule_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.fuel_break_types_rules_fuel_break_type_rule_id_seq TO viewer_user;


--
-- TOC entry 6580 (class 0 OID 0)
-- Dependencies: 327
-- Name: TABLE fuel_breaks; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.fuel_breaks TO viewer_user;


--
-- TOC entry 6581 (class 0 OID 0)
-- Dependencies: 328
-- Name: TABLE intervention_need_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.intervention_need_types TO viewer_user;


--
-- TOC entry 6583 (class 0 OID 0)
-- Dependencies: 329
-- Name: SEQUENCE intervention_need_types_intervention_need_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.intervention_need_types_intervention_need_type_id_seq TO viewer_user;


--
-- TOC entry 6584 (class 0 OID 0)
-- Dependencies: 330
-- Name: TABLE intervention_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.intervention_types TO viewer_user;


--
-- TOC entry 6586 (class 0 OID 0)
-- Dependencies: 331
-- Name: SEQUENCE intervention_types_intervention_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.intervention_types_intervention_type_id_seq TO viewer_user;


--
-- TOC entry 6587 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE interventions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.interventions TO viewer_user;


--
-- TOC entry 6589 (class 0 OID 0)
-- Dependencies: 333
-- Name: SEQUENCE interventions_intervention_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.interventions_intervention_id_seq TO viewer_user;


--
-- TOC entry 6590 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE interventions_needs; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.interventions_needs TO viewer_user;


--
-- TOC entry 6592 (class 0 OID 0)
-- Dependencies: 335
-- Name: SEQUENCE interventions_needs_intervention_need_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.interventions_needs_intervention_need_id_seq TO viewer_user;


--
-- TOC entry 6593 (class 0 OID 0)
-- Dependencies: 336
-- Name: SEQUENCE media_media_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.media_media_id_seq TO viewer_user;


--
-- TOC entry 6594 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE media; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.media TO viewer_user;


--
-- TOC entry 6595 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE media_answers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.media_answers TO viewer_user;


--
-- TOC entry 6597 (class 0 OID 0)
-- Dependencies: 339
-- Name: SEQUENCE media_answers_media_answer_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.media_answers_media_answer_id_seq TO viewer_user;


--
-- TOC entry 6598 (class 0 OID 0)
-- Dependencies: 340
-- Name: SEQUENCE media_questions_media_question_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.media_questions_media_question_id_seq TO viewer_user;


--
-- TOC entry 6599 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE media_questions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.media_questions TO viewer_user;


--
-- TOC entry 6600 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE media_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.media_types TO viewer_user;


--
-- TOC entry 6602 (class 0 OID 0)
-- Dependencies: 343
-- Name: SEQUENCE media_types_media_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.media_types_media_type_id_seq TO viewer_user;


--
-- TOC entry 6603 (class 0 OID 0)
-- Dependencies: 344
-- Name: TABLE member_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.member_types TO viewer_user;


--
-- TOC entry 6605 (class 0 OID 0)
-- Dependencies: 345
-- Name: SEQUENCE member_types_member_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.member_types_member_type_id_seq TO viewer_user;


--
-- TOC entry 6606 (class 0 OID 0)
-- Dependencies: 346
-- Name: TABLE metadata_schemas; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.metadata_schemas TO viewer_user;


--
-- TOC entry 6607 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE model_output; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.model_output TO viewer_user;


--
-- TOC entry 6609 (class 0 OID 0)
-- Dependencies: 348
-- Name: SEQUENCE model_output_model_output_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.model_output_model_output_id_seq TO viewer_user;


--
-- TOC entry 6610 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE monitorizations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.monitorizations TO viewer_user;


--
-- TOC entry 6612 (class 0 OID 0)
-- Dependencies: 350
-- Name: SEQUENCE monitorizations_monitorization_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.monitorizations_monitorization_id_seq TO viewer_user;


--
-- TOC entry 6613 (class 0 OID 0)
-- Dependencies: 351
-- Name: SEQUENCE news_news_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.news_news_id_seq TO viewer_user;


--
-- TOC entry 6614 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE news; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.news TO viewer_user;


--
-- TOC entry 6615 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE operations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.operations TO viewer_user;


--
-- TOC entry 6617 (class 0 OID 0)
-- Dependencies: 354
-- Name: SEQUENCE operations_operation_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.operations_operation_id_seq TO viewer_user;


--
-- TOC entry 6618 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE organizations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.organizations TO viewer_user;


--
-- TOC entry 6619 (class 0 OID 0)
-- Dependencies: 356
-- Name: TABLE organizations_members; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.organizations_members TO viewer_user;


--
-- TOC entry 6621 (class 0 OID 0)
-- Dependencies: 357
-- Name: SEQUENCE organizations_members_organization_member_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.organizations_members_organization_member_id_seq TO viewer_user;


--
-- TOC entry 6622 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE people; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.people TO viewer_user;


--
-- TOC entry 6623 (class 0 OID 0)
-- Dependencies: 359
-- Name: TABLE period_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.period_types TO viewer_user;


--
-- TOC entry 6625 (class 0 OID 0)
-- Dependencies: 360
-- Name: SEQUENCE period_types_period_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.period_types_period_type_id_seq TO viewer_user;


--
-- TOC entry 6626 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE periods; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.periods TO viewer_user;


--
-- TOC entry 6628 (class 0 OID 0)
-- Dependencies: 362
-- Name: SEQUENCE periods_period_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.periods_period_id_seq TO viewer_user;


--
-- TOC entry 6629 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE products; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.products TO viewer_user;


--
-- TOC entry 6631 (class 0 OID 0)
-- Dependencies: 364
-- Name: SEQUENCE products_product_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.products_product_id_seq TO viewer_user;


--
-- TOC entry 6632 (class 0 OID 0)
-- Dependencies: 365
-- Name: TABLE professionals; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.professionals TO viewer_user;


--
-- TOC entry 6633 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE professionals_monitorizations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.professionals_monitorizations TO viewer_user;


--
-- TOC entry 6635 (class 0 OID 0)
-- Dependencies: 367
-- Name: SEQUENCE professionals_monitorizations_professional_monitorization_i_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.professionals_monitorizations_professional_monitorization_i_seq TO viewer_user;


--
-- TOC entry 6637 (class 0 OID 0)
-- Dependencies: 368
-- Name: SEQUENCE professionals_professional_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.professionals_professional_id_seq TO viewer_user;


--
-- TOC entry 6638 (class 0 OID 0)
-- Dependencies: 369
-- Name: TABLE prohibitions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.prohibitions TO viewer_user;


--
-- TOC entry 6640 (class 0 OID 0)
-- Dependencies: 370
-- Name: SEQUENCE prohibitions_prohibition_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.prohibitions_prohibition_id_seq TO viewer_user;


--
-- TOC entry 6641 (class 0 OID 0)
-- Dependencies: 371
-- Name: TABLE properties_schemas; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.properties_schemas TO viewer_user;


--
-- TOC entry 6642 (class 0 OID 0)
-- Dependencies: 372
-- Name: SEQUENCE protocols_protocol_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.protocols_protocol_id_seq TO viewer_user;


--
-- TOC entry 6643 (class 0 OID 0)
-- Dependencies: 373
-- Name: TABLE protocols; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.protocols TO viewer_user;


--
-- TOC entry 6644 (class 0 OID 0)
-- Dependencies: 374
-- Name: TABLE question_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.question_types TO viewer_user;


--
-- TOC entry 6646 (class 0 OID 0)
-- Dependencies: 375
-- Name: SEQUENCE question_types_question_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.question_types_question_type_id_seq TO viewer_user;


--
-- TOC entry 6647 (class 0 OID 0)
-- Dependencies: 376
-- Name: SEQUENCE questions_question_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.questions_question_id_seq TO viewer_user;


--
-- TOC entry 6648 (class 0 OID 0)
-- Dependencies: 377
-- Name: TABLE questions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.questions TO viewer_user;


--
-- TOC entry 6649 (class 0 OID 0)
-- Dependencies: 378
-- Name: SEQUENCE questions_answers_options_question_answer_option_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.questions_answers_options_question_answer_option_id_seq TO viewer_user;


--
-- TOC entry 6650 (class 0 OID 0)
-- Dependencies: 379
-- Name: TABLE questions_answers_options; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.questions_answers_options TO viewer_user;


--
-- TOC entry 6651 (class 0 OID 0)
-- Dependencies: 380
-- Name: SEQUENCE questions_protocols_question_protocol_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.questions_protocols_question_protocol_id_seq TO viewer_user;


--
-- TOC entry 6652 (class 0 OID 0)
-- Dependencies: 381
-- Name: TABLE questions_protocols; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.questions_protocols TO viewer_user;


--
-- TOC entry 6653 (class 0 OID 0)
-- Dependencies: 382
-- Name: TABLE reset_tokens; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.reset_tokens TO viewer_user;


--
-- TOC entry 6655 (class 0 OID 0)
-- Dependencies: 383
-- Name: SEQUENCE reset_tokens_reset_token_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.reset_tokens_reset_token_id_seq TO viewer_user;


--
-- TOC entry 6656 (class 0 OID 0)
-- Dependencies: 384
-- Name: TABLE rewards; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.rewards TO viewer_user;


--
-- TOC entry 6658 (class 0 OID 0)
-- Dependencies: 385
-- Name: SEQUENCE rewards_reward_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.rewards_reward_id_seq TO viewer_user;


--
-- TOC entry 6659 (class 0 OID 0)
-- Dependencies: 386
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.roles TO viewer_user;


--
-- TOC entry 6660 (class 0 OID 0)
-- Dependencies: 387
-- Name: TABLE roles_operations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.roles_operations TO viewer_user;


--
-- TOC entry 6662 (class 0 OID 0)
-- Dependencies: 388
-- Name: SEQUENCE roles_operations_role_operation_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.roles_operations_role_operation_id_seq TO viewer_user;


--
-- TOC entry 6663 (class 0 OID 0)
-- Dependencies: 389
-- Name: TABLE roles_prohibitions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.roles_prohibitions TO viewer_user;


--
-- TOC entry 6665 (class 0 OID 0)
-- Dependencies: 390
-- Name: SEQUENCE roles_prohibitions_role_prohibition_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.roles_prohibitions_role_prohibition_id_seq TO viewer_user;


--
-- TOC entry 6667 (class 0 OID 0)
-- Dependencies: 391
-- Name: SEQUENCE roles_role_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.roles_role_id_seq TO viewer_user;


--
-- TOC entry 6668 (class 0 OID 0)
-- Dependencies: 392
-- Name: TABLE rules; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.rules TO viewer_user;


--
-- TOC entry 6670 (class 0 OID 0)
-- Dependencies: 393
-- Name: SEQUENCE rules_rule_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.rules_rule_id_seq TO viewer_user;


--
-- TOC entry 6671 (class 0 OID 0)
-- Dependencies: 394
-- Name: TABLE segmentations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.segmentations TO viewer_user;


--
-- TOC entry 6673 (class 0 OID 0)
-- Dependencies: 396
-- Name: TABLE segments; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.segments TO viewer_user;


--
-- TOC entry 6674 (class 0 OID 0)
-- Dependencies: 397
-- Name: TABLE segments_interventions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.segments_interventions TO viewer_user;


--
-- TOC entry 6676 (class 0 OID 0)
-- Dependencies: 398
-- Name: SEQUENCE segments_interventions_segment_intervention_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.segments_interventions_segment_intervention_id_seq TO viewer_user;


--
-- TOC entry 6677 (class 0 OID 0)
-- Dependencies: 399
-- Name: TABLE series; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.series TO viewer_user;


--
-- TOC entry 6678 (class 0 OID 0)
-- Dependencies: 400
-- Name: TABLE series_periods; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.series_periods TO viewer_user;


--
-- TOC entry 6680 (class 0 OID 0)
-- Dependencies: 401
-- Name: SEQUENCE series_periods_series_period_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.series_periods_series_period_id_seq TO viewer_user;


--
-- TOC entry 6681 (class 0 OID 0)
-- Dependencies: 402
-- Name: TABLE series_raster_data; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.series_raster_data TO viewer_user;


--
-- TOC entry 6683 (class 0 OID 0)
-- Dependencies: 403
-- Name: SEQUENCE series_raster_data_series_raster_data_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.series_raster_data_series_raster_data_id_seq TO viewer_user;


--
-- TOC entry 6684 (class 0 OID 0)
-- Dependencies: 404
-- Name: TABLE series_relation_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.series_relation_types TO viewer_user;


--
-- TOC entry 6686 (class 0 OID 0)
-- Dependencies: 405
-- Name: SEQUENCE series_relation_types_series_relation_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.series_relation_types_series_relation_type_id_seq TO viewer_user;


--
-- TOC entry 6687 (class 0 OID 0)
-- Dependencies: 406
-- Name: TABLE series_relations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.series_relations TO viewer_user;


--
-- TOC entry 6689 (class 0 OID 0)
-- Dependencies: 407
-- Name: SEQUENCE series_relations_series_relation_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.series_relations_series_relation_id_seq TO viewer_user;


--
-- TOC entry 6691 (class 0 OID 0)
-- Dependencies: 408
-- Name: SEQUENCE series_series_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.series_series_id_seq TO viewer_user;


--
-- TOC entry 6692 (class 0 OID 0)
-- Dependencies: 409
-- Name: TABLE series_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.series_types TO viewer_user;


--
-- TOC entry 6694 (class 0 OID 0)
-- Dependencies: 410
-- Name: SEQUENCE series_types_series_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.series_types_series_type_id_seq TO viewer_user;


--
-- TOC entry 6695 (class 0 OID 0)
-- Dependencies: 411
-- Name: TABLE series_variables; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.series_variables TO viewer_user;


--
-- TOC entry 6697 (class 0 OID 0)
-- Dependencies: 412
-- Name: SEQUENCE series_variables_series_variable_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.series_variables_series_variable_id_seq TO viewer_user;


--
-- TOC entry 6698 (class 0 OID 0)
-- Dependencies: 413
-- Name: TABLE series_vectorial_data; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.series_vectorial_data TO viewer_user;


--
-- TOC entry 6700 (class 0 OID 0)
-- Dependencies: 414
-- Name: SEQUENCE series_vectorial_data_series_vectorial_data_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.series_vectorial_data_series_vectorial_data_id_seq TO viewer_user;


--
-- TOC entry 6701 (class 0 OID 0)
-- Dependencies: 415
-- Name: TABLE settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.settings TO viewer_user;


--
-- TOC entry 6702 (class 0 OID 0)
-- Dependencies: 416
-- Name: TABLE spatial_object_entity_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_object_entity_types TO viewer_user;


--
-- TOC entry 6704 (class 0 OID 0)
-- Dependencies: 417
-- Name: SEQUENCE spatial_object_entity_types_spatial_object_entity_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.spatial_object_entity_types_spatial_object_entity_type_id_seq TO viewer_user;


--
-- TOC entry 6705 (class 0 OID 0)
-- Dependencies: 418
-- Name: TABLE spatial_object_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_object_types TO viewer_user;


--
-- TOC entry 6707 (class 0 OID 0)
-- Dependencies: 419
-- Name: SEQUENCE spatial_object_types_spatial_object_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.spatial_object_types_spatial_object_type_id_seq TO viewer_user;


--
-- TOC entry 6709 (class 0 OID 0)
-- Dependencies: 420
-- Name: SEQUENCE spatial_objects_administrativ_spatial_object_administrative_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.spatial_objects_administrativ_spatial_object_administrative_seq TO viewer_user;


--
-- TOC entry 6710 (class 0 OID 0)
-- Dependencies: 421
-- Name: TABLE spatial_objects_periods_entities; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_objects_periods_entities TO viewer_user;


--
-- TOC entry 6712 (class 0 OID 0)
-- Dependencies: 422
-- Name: SEQUENCE spatial_objects_periods_entit_spatial_object_period_entity__seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.spatial_objects_periods_entit_spatial_object_period_entity__seq TO viewer_user;


--
-- TOC entry 6713 (class 0 OID 0)
-- Dependencies: 423
-- Name: TABLE spatial_objects_periods_series; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_objects_periods_series TO viewer_user;


--
-- TOC entry 6715 (class 0 OID 0)
-- Dependencies: 424
-- Name: SEQUENCE spatial_objects_periods_serie_spatial_object_period_series__seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.spatial_objects_periods_serie_spatial_object_period_series__seq TO viewer_user;


--
-- TOC entry 6717 (class 0 OID 0)
-- Dependencies: 425
-- Name: SEQUENCE spatial_objects_periods_spatial_object_period_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.spatial_objects_periods_spatial_object_period_id_seq TO viewer_user;


--
-- TOC entry 6718 (class 0 OID 0)
-- Dependencies: 426
-- Name: TABLE spatial_objects_v_4326; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_objects_v_4326 TO viewer_user;


--
-- TOC entry 6719 (class 0 OID 0)
-- Dependencies: 427
-- Name: TABLE states; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.states TO viewer_user;


--
-- TOC entry 6721 (class 0 OID 0)
-- Dependencies: 429
-- Name: TABLE summary; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.summary TO viewer_user;


--
-- TOC entry 6723 (class 0 OID 0)
-- Dependencies: 431
-- Name: SEQUENCE topological_relation_types_topological_relation_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.topological_relation_types_topological_relation_type_id_seq TO viewer_user;


--
-- TOC entry 6724 (class 0 OID 0)
-- Dependencies: 432
-- Name: TABLE topological_relation_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.topological_relation_types TO viewer_user;


--
-- TOC entry 6725 (class 0 OID 0)
-- Dependencies: 434
-- Name: SEQUENCE topological_relations_topological_relation_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.topological_relations_topological_relation_id_seq TO viewer_user;


--
-- TOC entry 6726 (class 0 OID 0)
-- Dependencies: 433
-- Name: TABLE topological_relations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.topological_relations TO viewer_user;


--
-- TOC entry 6727 (class 0 OID 0)
-- Dependencies: 435
-- Name: TABLE training_data_model; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.training_data_model TO viewer_user;


--
-- TOC entry 6729 (class 0 OID 0)
-- Dependencies: 436
-- Name: SEQUENCE training_data_model_training_data_model_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.training_data_model_training_data_model_id_seq TO viewer_user;


--
-- TOC entry 6730 (class 0 OID 0)
-- Dependencies: 437
-- Name: TABLE units; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.units TO viewer_user;


--
-- TOC entry 6731 (class 0 OID 0)
-- Dependencies: 438
-- Name: TABLE volunteers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.volunteers TO viewer_user;


--
-- TOC entry 6732 (class 0 OID 0)
-- Dependencies: 439
-- Name: SEQUENCE volunteers_records_volunteer_record_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.volunteers_records_volunteer_record_id_seq TO viewer_user;


--
-- TOC entry 6733 (class 0 OID 0)
-- Dependencies: 440
-- Name: TABLE volunteers_records; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.volunteers_records TO viewer_user;


--
-- TOC entry 6735 (class 0 OID 0)
-- Dependencies: 441
-- Name: SEQUENCE volunteers_volunteer_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.volunteers_volunteer_id_seq TO viewer_user;


--
-- TOC entry 6737 (class 0 OID 0)
-- Dependencies: 442
-- Name: SEQUENCE waypoints_waypoint_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON SEQUENCE public.waypoints_waypoint_id_seq TO viewer_user;


--
-- TOC entry 4012 (class 826 OID 140259)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT ON TABLES  TO viewer_user;


-- Completed on 2024-11-28 13:11:21 WET

--
-- PostgreSQL database dump complete
--


-- Run table check test
\i /docker-entrypoint-initdb.d/02_check_tables.sql;
