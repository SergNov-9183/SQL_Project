--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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

DROP DATABASE real_estate_app_database_v2;
--
-- Name: real_estate_app_database_v2; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE real_estate_app_database_v2;


\connect real_estate_app_database_v2

--
-- Name: add_advert(integer, integer, integer, text, integer, double precision, double precision, double precision, boolean, boolean, boolean, boolean, text, text, text, double precision, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_advert(human_id integer, house_id integer, settlement_id integer, apartment_number text, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, electricity boolean, sewerage boolean, bathroom_type text, category text, ads_text text, price double precision, publication_or_update_time text, additional_info text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO ads (people_id, house_id, settlement_id, apartment_number, rooms_count, total_area, living_area, kitchen_area, 
						   water_pipes, gas, electricity, sewerage, bathroom_type, category, ads_text, price, publication_or_update_time, addition_information)
		VALUES (Human_id, House_id, Settlement_id, Apartment_number, 
				Rooms_count, Total_area, Living_area, 
				Kitchen_area, Water_pipes, Gas, Electricity, 
				Sewerage, Bathroom_type, Category, Ads_text, Price, 
				Publication_or_update_time, Additional_info);
$$;


ALTER FUNCTION public.add_advert(human_id integer, house_id integer, settlement_id integer, apartment_number text, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, electricity boolean, sewerage boolean, bathroom_type text, category text, ads_text text, price double precision, publication_or_update_time text, additional_info text) OWNER TO postgres;

--
-- Name: add_advert(integer, integer, integer, text, integer, double precision, double precision, double precision, boolean, boolean, boolean, boolean, text, text, text, double precision, timestamp without time zone, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_advert(human_id integer, house_id integer, settlement_id integer, apartment_number text, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, electricity boolean, sewerage boolean, bathroom_type text, category text, ads_text text, price double precision, publication_or_update_time timestamp without time zone, additional_info text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO ads (people_id, house_id, settlement_id, apartment_number, rooms_count, total_area, living_area, kitchen_area, 
						   water_pipes, gas, electricity, sewerage, bathroom_type, category, ads_text, price, publication_or_update_time, addition_information)
		VALUES (Human_id, House_id, Settlement_id, Apartment_number, 
				Rooms_count, Total_area, Living_area, 
				Kitchen_area, Water_pipes, Gas, Electricity, 
				Sewerage, Bathroom_type, Category, Ads_text, Price, 
				Publication_or_update_time, Additional_info);
$$;


ALTER FUNCTION public.add_advert(human_id integer, house_id integer, settlement_id integer, apartment_number text, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, electricity boolean, sewerage boolean, bathroom_type text, category text, ads_text text, price double precision, publication_or_update_time timestamp without time zone, additional_info text) OWNER TO postgres;

--
-- Name: add_advert(integer, integer, text, text, integer, double precision, double precision, double precision, boolean, boolean, boolean, boolean, text, text, text, double precision, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_advert(human_id integer, house_id integer, settlement_name text, apartment_number text, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, electricity boolean, sewerage boolean, bathroom_type text, category text, ads_text text, price double precision, publication_or_update_time text, additional_info text) RETURNS TABLE(people_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY EXECUTE
        format('INSERT INTO ads (people_id, house_id, settlement_id, apartment_number, rooms_count, total_area, living_area, kitchen_area, 
						   water_pipes, gas, electricity, sewerage, bathroom_type, category, ads_text, price, publication_or_update_time, addition_information)
		VALUES (Human_id, House_id, (SELECT get_id_by_name(''settlements'', %L)), Apartment_number, 
				Rooms_count, Total_area, Living_area, 
				Kitchen_area, Water_pipes, Gas, Electricity, 
				Sewerage, Bathroom_type, Category, Ads_text, Price, 
				TIMESTAMP %L, Additional_info); SELECT 1;', Settlement_name, Publication_or_update_time);
END;		
$$;


ALTER FUNCTION public.add_advert(human_id integer, house_id integer, settlement_name text, apartment_number text, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, electricity boolean, sewerage boolean, bathroom_type text, category text, ads_text text, price double precision, publication_or_update_time text, additional_info text) OWNER TO postgres;

--
-- Name: add_district(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_district(name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO districts(name) VALUES (name)
	$$;


ALTER FUNCTION public.add_district(name text) OWNER TO postgres;

--
-- Name: add_house(text, text, text, text, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_house(street_name text, type text, number text, housing_number text, land_area double precision) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF Type = 'private' THEN
		INSERT INTO houses(street_id, type, number, housing_number, land_area) 
			VALUES ((SELECT get_id_by_name('streets', Street_name)), Type, Number, Null, Land_area);
	ELSE
		IF Housing_number IS NOT Null THEN
			INSERT INTO houses(street_id, type, number, housing_number, land_area) 
				VALUES ((SELECT get_id_by_name('streets', Street_name)), Type, Number, Housing_number, Null);
		END IF;
	END IF;
END
$$;


ALTER FUNCTION public.add_house(street_name text, type text, number text, housing_number text, land_area double precision) OWNER TO postgres;

--
-- Name: add_human(text, text, text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_human(surname text, name text, patronymic text, phone text, email text, password text, realtor_firm_id integer) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO people (surname, name, patronymic, phone, email, password, realtor_firm_id) 
		VALUES (Surname, Name, Patronymic, Phone, Email, Password, Realtor_firm_id);
$$;


ALTER FUNCTION public.add_human(surname text, name text, patronymic text, phone text, email text, password text, realtor_firm_id integer) OWNER TO postgres;

--
-- Name: add_human(text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_human(surname text, name text, patronymic text, phone text, email text, password text, realtor_firm_name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO people (surname, name, patronymic, phone, email, password, realtor_firm_id) 
		VALUES (Surname, Name, Patronymic, Phone, Email, Password, (SELECT get_id_by_name('realtor_firms', format('%s', Realtor_firm_name))));
$$;


ALTER FUNCTION public.add_human(surname text, name text, patronymic text, phone text, email text, password text, realtor_firm_name text) OWNER TO postgres;

--
-- Name: add_person(integer, text, text, text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_person(id integer, surnm text, name text, patronymic text, phone text, email text, passwd text, r_firm_id integer) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO people (surname, name, patronymic, phone, email, password, realtor_firm_id)
		   VALUES (surnm, name, patronymic, phone, email, passwd, r_firm_id)
	$$;


ALTER FUNCTION public.add_person(id integer, surnm text, name text, patronymic text, phone text, email text, passwd text, r_firm_id integer) OWNER TO postgres;

--
-- Name: add_realtor_firm(integer, double precision, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_realtor_firm(house_id integer, rating double precision, phone text, email text, description text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO realtor_firms (house_id, rating, phone, email, description) 
		VALUES (House_id, Rating, Phone, Email, Description);
$$;


ALTER FUNCTION public.add_realtor_firm(house_id integer, rating double precision, phone text, email text, description text) OWNER TO postgres;

--
-- Name: add_realtor_firm(integer, text, double precision, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_realtor_firm(house_id integer, name text, rating double precision, phone text, email text, description text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO realtor_firms (house_id, name, rating, phone, email, description) 
		VALUES (House_id, Name, Rating, Phone, Email, Description);
$$;


ALTER FUNCTION public.add_realtor_firm(house_id integer, name text, rating double precision, phone text, email text, description text) OWNER TO postgres;

--
-- Name: add_region(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_region(name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO districts(name) VALUES (name)
	$$;


ALTER FUNCTION public.add_region(name text) OWNER TO postgres;

--
-- Name: add_settlement(integer, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_settlement(distr_id integer, type text, name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO settlements(district_id, type, name) 
		VALUES (distr_id, type, (SELECT get_id_by_name('districts', format('%L', name))))
	$$;


ALTER FUNCTION public.add_settlement(distr_id integer, type text, name text) OWNER TO postgres;

--
-- Name: add_settlement(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_settlement(distr_name text, type text, name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO settlements(district_id, type, name) 
		VALUES ((SELECT get_id_by_name('districts', format('%s', distr_name))), type, name)
	$$;


ALTER FUNCTION public.add_settlement(distr_name text, type text, name text) OWNER TO postgres;

--
-- Name: add_street(integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_street(settlement_id integer, name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO streets(settlement_id, name) VALUES (settlement_id, name)
$$;


ALTER FUNCTION public.add_street(settlement_id integer, name text) OWNER TO postgres;

--
-- Name: add_street(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_street(settlement_name text, name text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO streets(settlement_id, name) 
		VALUES ((SELECT get_id_by_name('settlements', format('%s', settlement_name))), name);
END
$$;


ALTER FUNCTION public.add_street(settlement_name text, name text) OWNER TO postgres;

--
-- Name: get_district_id_by_name(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_district_id_by_name(name text) RETURNS integer
    LANGUAGE sql
    AS $$
		SELECT id 
		FROM districts d
		WHERE d.name = name
	$$;


ALTER FUNCTION public.get_district_id_by_name(name text) OWNER TO postgres;

--
-- Name: get_id_by_name(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_id_by_name(input_table text, name_obj text) RETURNS TABLE(id integer)
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY EXECUTE
        format('SELECT d.id FROM %I d WHERE d.name = %L', input_table, name_obj);	
	END
	$$;


ALTER FUNCTION public.get_id_by_name(input_table text, name_obj text) OWNER TO postgres;

--
-- Name: get_login_data(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_login_data() RETURNS TABLE(email text, password text)
    LANGUAGE sql
    AS $$
	SELECT email, password
	FROM people;
$$;


ALTER FUNCTION public.get_login_data() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ads (
    id integer NOT NULL,
    people_id integer NOT NULL,
    house_id integer NOT NULL,
    settlement_id integer NOT NULL,
    apartment_number text,
    rooms_count integer,
    total_area double precision,
    living_area double precision,
    kitchen_area double precision,
    water_pipes boolean,
    gas boolean,
    electricity boolean,
    sewerage boolean,
    bathroom_type text,
    category text,
    ads_text text,
    price double precision,
    addition_information text,
    publication_or_update_time timestamp without time zone
);


ALTER TABLE public.ads OWNER TO postgres;

--
-- Name: Ads_House_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ads_House_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ads_House_ID_seq" OWNER TO postgres;

--
-- Name: Ads_House_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ads_House_ID_seq" OWNED BY public.ads.house_id;


--
-- Name: Ads_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ads_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ads_ID_seq" OWNER TO postgres;

--
-- Name: Ads_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ads_ID_seq" OWNED BY public.ads.id;


--
-- Name: Ads_People_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ads_People_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ads_People_ID_seq" OWNER TO postgres;

--
-- Name: Ads_People_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ads_People_ID_seq" OWNED BY public.ads.people_id;


--
-- Name: Ads_Settlement_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ads_Settlement_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ads_Settlement_ID_seq" OWNER TO postgres;

--
-- Name: Ads_Settlement_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ads_Settlement_ID_seq" OWNED BY public.ads.settlement_id;


--
-- Name: districts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.districts (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.districts OWNER TO postgres;

--
-- Name: Districts_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Districts_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Districts_ID_seq" OWNER TO postgres;

--
-- Name: Districts_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Districts_ID_seq" OWNED BY public.districts.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id integer NOT NULL,
    tittle text,
    description text,
    sample text
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- Name: Documents_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Documents_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Documents_ID_seq" OWNER TO postgres;

--
-- Name: Documents_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Documents_ID_seq" OWNED BY public.documents.id;


--
-- Name: houses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.houses (
    id integer NOT NULL,
    street_id integer NOT NULL,
    type text,
    number text,
    housing_number text,
    land_area double precision
);


ALTER TABLE public.houses OWNER TO postgres;

--
-- Name: Houses_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Houses_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Houses_ID_seq" OWNER TO postgres;

--
-- Name: Houses_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Houses_ID_seq" OWNED BY public.houses.id;


--
-- Name: Houses_Street_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Houses_Street_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Houses_Street_ID_seq" OWNER TO postgres;

--
-- Name: Houses_Street_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Houses_Street_ID_seq" OWNED BY public.houses.street_id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.people (
    id integer NOT NULL,
    surname text,
    name text,
    patronymic text,
    phone text,
    email text,
    password text,
    realtor_firm_id integer NOT NULL
);


ALTER TABLE public.people OWNER TO postgres;

--
-- Name: People_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."People_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."People_ID_seq" OWNER TO postgres;

--
-- Name: People_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."People_ID_seq" OWNED BY public.people.id;


--
-- Name: People_Realtor_firm_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."People_Realtor_firm_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."People_Realtor_firm_ID_seq" OWNER TO postgres;

--
-- Name: People_Realtor_firm_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."People_Realtor_firm_ID_seq" OWNED BY public.people.realtor_firm_id;


--
-- Name: realtor_firms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realtor_firms (
    id integer NOT NULL,
    house_id integer NOT NULL,
    rating double precision,
    phone text,
    email text,
    description text,
    name text
);


ALTER TABLE public.realtor_firms OWNER TO postgres;

--
-- Name: Realtor_firms_House_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Realtor_firms_House_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Realtor_firms_House_ID_seq" OWNER TO postgres;

--
-- Name: Realtor_firms_House_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Realtor_firms_House_ID_seq" OWNED BY public.realtor_firms.house_id;


--
-- Name: Realtor_firms_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Realtor_firms_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Realtor_firms_ID_seq" OWNER TO postgres;

--
-- Name: Realtor_firms_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Realtor_firms_ID_seq" OWNED BY public.realtor_firms.id;


--
-- Name: settlements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settlements (
    id integer NOT NULL,
    district_id integer NOT NULL,
    type text,
    name text
);


ALTER TABLE public.settlements OWNER TO postgres;

--
-- Name: Settlement_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Settlement_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Settlement_ID_seq" OWNER TO postgres;

--
-- Name: Settlement_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Settlement_ID_seq" OWNED BY public.settlements.id;


--
-- Name: Settlement_district_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Settlement_district_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Settlement_district_ID_seq" OWNER TO postgres;

--
-- Name: Settlement_district_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Settlement_district_ID_seq" OWNED BY public.settlements.district_id;


--
-- Name: streets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.streets (
    id integer NOT NULL,
    settlement_id integer NOT NULL,
    name text
);


ALTER TABLE public.streets OWNER TO postgres;

--
-- Name: Streets_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Streets_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Streets_ID_seq" OWNER TO postgres;

--
-- Name: Streets_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Streets_ID_seq" OWNED BY public.streets.id;


--
-- Name: Streets_Settlement_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Streets_Settlement_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Streets_Settlement_ID_seq" OWNER TO postgres;

--
-- Name: Streets_Settlement_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Streets_Settlement_ID_seq" OWNED BY public.streets.settlement_id;


--
-- Name: ads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads ALTER COLUMN id SET DEFAULT nextval('public."Ads_ID_seq"'::regclass);


--
-- Name: ads people_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads ALTER COLUMN people_id SET DEFAULT nextval('public."Ads_People_ID_seq"'::regclass);


--
-- Name: ads house_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads ALTER COLUMN house_id SET DEFAULT nextval('public."Ads_House_ID_seq"'::regclass);


--
-- Name: ads settlement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads ALTER COLUMN settlement_id SET DEFAULT nextval('public."Ads_Settlement_ID_seq"'::regclass);


--
-- Name: districts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.districts ALTER COLUMN id SET DEFAULT nextval('public."Districts_ID_seq"'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public."Documents_ID_seq"'::regclass);


--
-- Name: houses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses ALTER COLUMN id SET DEFAULT nextval('public."Houses_ID_seq"'::regclass);


--
-- Name: houses street_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses ALTER COLUMN street_id SET DEFAULT nextval('public."Houses_Street_ID_seq"'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public."People_ID_seq"'::regclass);


--
-- Name: people realtor_firm_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people ALTER COLUMN realtor_firm_id SET DEFAULT nextval('public."People_Realtor_firm_ID_seq"'::regclass);


--
-- Name: realtor_firms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realtor_firms ALTER COLUMN id SET DEFAULT nextval('public."Realtor_firms_ID_seq"'::regclass);


--
-- Name: realtor_firms house_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realtor_firms ALTER COLUMN house_id SET DEFAULT nextval('public."Realtor_firms_House_ID_seq"'::regclass);


--
-- Name: settlements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlements ALTER COLUMN id SET DEFAULT nextval('public."Settlement_ID_seq"'::regclass);


--
-- Name: settlements district_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlements ALTER COLUMN district_id SET DEFAULT nextval('public."Settlement_district_ID_seq"'::regclass);


--
-- Name: streets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets ALTER COLUMN id SET DEFAULT nextval('public."Streets_ID_seq"'::regclass);


--
-- Name: streets settlement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets ALTER COLUMN settlement_id SET DEFAULT nextval('public."Streets_Settlement_ID_seq"'::regclass);


--
-- Data for Name: ads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ads (id, people_id, house_id, settlement_id, apartment_number, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, electricity, sewerage, bathroom_type, category, ads_text, price, addition_information, publication_or_update_time) FROM stdin;
1	8	15	6	58	3	56.2	40.5	5	t	t	t	t	совмещённый	продажа	Самая лучшая квартира	500000	\N	2021-05-02 08:00:54
2	8	15	5	58	3	56.2	40.5	4	f	f	t	t	раздельный	продажа	Самая лучшая квартира	500000	\N	2021-05-02 08:00:54
\.


--
-- Data for Name: districts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.districts (id, name) FROM stdin;
9	Кстовский
10	Арзамасский
11	Чкаловский
12	Богородский
13	Городецкий
15	zero
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, tittle, description, sample) FROM stdin;
\.


--
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.houses (id, street_id, type, number, housing_number, land_area) FROM stdin;
15	5	multiroom	75	2	\N
16	4	private	12	\N	45
17	5	multiroom	26Г	6	\N
18	19	private	1	\N	\N
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.people (id, surname, name, patronymic, phone, email, password, realtor_firm_id) FROM stdin;
8	Мазаева	Антонина	Петровна	2566565	antonina@gmail.com	THeY_Call_It_STeaM	5
14	Грибоедова	Наталья	Ивановна	89038652995	hey.natasha@gmail.com	Is_42_The_Answer?	5
15	zero	zero	zero	+70000000000	o@o.o	zero	10
\.


--
-- Data for Name: realtor_firms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realtor_firms (id, house_id, rating, phone, email, description, name) FROM stdin;
5	16	4.3	297-89-22	top_realtors.here@inbox.ru	Top of the top company ever!	TopTopCompany
6	15	7.3	+7253297-89-22	top_realtors_nowhere@tambox.ru	Почти что банкроты...	GoodRealtors
10	18	0	+70000000000	o@o.o	zero	zero
\.


--
-- Data for Name: settlements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settlements (id, district_id, type, name) FROM stdin;
5	9	село	Федяково
6	11	село	Пурех
7	12	село	Новинки
8	13	город	Заволжье
10	11	село	Катунки
12	15	zero	zero
\.


--
-- Data for Name: streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.streets (id, settlement_id, name) FROM stdin;
1	5	Дубравная
2	5	Молодёжная
3	5	Советская
4	6	Центральная
5	7	Прекрасная
6	8	Пушкина
15	6	Ровная
19	12	zero
\.


--
-- Name: Ads_House_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_House_ID_seq"', 1, false);


--
-- Name: Ads_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_ID_seq"', 2, true);


--
-- Name: Ads_People_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_People_ID_seq"', 1, false);


--
-- Name: Ads_Settlement_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_Settlement_ID_seq"', 1, false);


--
-- Name: Districts_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Districts_ID_seq"', 15, true);


--
-- Name: Documents_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Documents_ID_seq"', 1, false);


--
-- Name: Houses_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Houses_ID_seq"', 18, true);


--
-- Name: Houses_Street_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Houses_Street_ID_seq"', 1, false);


--
-- Name: People_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."People_ID_seq"', 15, true);


--
-- Name: People_Realtor_firm_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."People_Realtor_firm_ID_seq"', 1, false);


--
-- Name: Realtor_firms_House_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Realtor_firms_House_ID_seq"', 1, false);


--
-- Name: Realtor_firms_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Realtor_firms_ID_seq"', 10, true);


--
-- Name: Settlement_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Settlement_ID_seq"', 12, true);


--
-- Name: Settlement_district_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Settlement_district_ID_seq"', 1, false);


--
-- Name: Streets_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Streets_ID_seq"', 19, true);


--
-- Name: Streets_Settlement_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Streets_Settlement_ID_seq"', 1, false);


--
-- Name: ads Ads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT "Ads_pkey" PRIMARY KEY (id);


--
-- Name: districts Districts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT "Districts_pkey" PRIMARY KEY (id);


--
-- Name: documents Documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT "Documents_pkey" PRIMARY KEY (id);


--
-- Name: houses Houses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT "Houses_pkey" PRIMARY KEY (id);


--
-- Name: people People_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT "People_pkey" PRIMARY KEY (id);


--
-- Name: realtor_firms Realtor_firms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realtor_firms
    ADD CONSTRAINT "Realtor_firms_pkey" PRIMARY KEY (id);


--
-- Name: settlements Settlement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT "Settlement_pkey" PRIMARY KEY (id);


--
-- Name: streets Streets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT "Streets_pkey" PRIMARY KEY (id);


--
-- Name: ads Ads_House_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT "Ads_House_ID_fkey" FOREIGN KEY (house_id) REFERENCES public.houses(id) NOT VALID;


--
-- Name: ads Ads_People_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT "Ads_People_ID_fkey" FOREIGN KEY (people_id) REFERENCES public.people(id) NOT VALID;


--
-- Name: ads Ads_Settlement_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT "Ads_Settlement_ID_fkey" FOREIGN KEY (settlement_id) REFERENCES public.settlements(id) NOT VALID;


--
-- Name: houses Houses_Street_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT "Houses_Street_ID_fkey" FOREIGN KEY (street_id) REFERENCES public.streets(id) NOT VALID;


--
-- Name: people People_Realtor_firm_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT "People_Realtor_firm_ID_fkey" FOREIGN KEY (realtor_firm_id) REFERENCES public.realtor_firms(id) NOT VALID;


--
-- Name: realtor_firms Realtor_firms_House_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realtor_firms
    ADD CONSTRAINT "Realtor_firms_House_ID_fkey" FOREIGN KEY (house_id) REFERENCES public.houses(id) NOT VALID;


--
-- Name: settlements Settlement_district_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT "Settlement_district_ID_fkey" FOREIGN KEY (district_id) REFERENCES public.districts(id) NOT VALID;


--
-- Name: streets Streets_Settlement_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT "Streets_Settlement_ID_fkey" FOREIGN KEY (settlement_id) REFERENCES public.settlements(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

