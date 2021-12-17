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

DROP DATABASE real_estate_app_database_v3;
--
-- Name: real_estate_app_database_v3; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE real_estate_app_database_v3;


\connect real_estate_app_database_v3



SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ads (
    id integer NOT NULL,
    people_id integer NOT NULL,
    house_id integer,
    settlement_id integer,
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
    category integer,
    ads_text text,
    price double precision,
    publication_or_update_time text,
    addition_information text
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
    name text
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
    type integer,
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
    realtor_firm_id integer
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
    house_id integer,
    rating double precision,
    phone text,
    email text,
    description text
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
    district_id integer,
    type integer,
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
    settlement_id integer,
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
-- Data for Name: ads; Type: TABLE DATA; Schema: public; Owner: postgres
--

SET client_encoding TO 'UTF8';

COPY public.ads (id, people_id, house_id, settlement_id, apartment_number, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, electricity, sewerage, bathroom_type, category, ads_text, price, publication_or_update_time, addition_information) FROM stdin;
\.


--
-- Data for Name: districts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.districts (id, name) FROM stdin;
10	Кстовский
11	Борский
12	Городецкий
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
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.people (id, surname, name, patronymic, phone, email, password, realtor_firm_id) FROM stdin;
\.


--
-- Data for Name: realtor_firms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realtor_firms (id, house_id, rating, phone, email, description) FROM stdin;
\.


--
-- Data for Name: settlements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settlements (id, district_id, type, name) FROM stdin;
\.


--
-- Data for Name: streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.streets (id, settlement_id, name) FROM stdin;
\.


--
-- Name: Ads_House_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_House_ID_seq"', 1, false);


--
-- Name: Ads_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_ID_seq"', 1, false);


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

SELECT pg_catalog.setval('public."Districts_ID_seq"', 7, true);


--
-- Name: Documents_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Documents_ID_seq"', 1, false);


--
-- Name: Houses_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Houses_ID_seq"', 1, false);


--
-- Name: Houses_Street_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Houses_Street_ID_seq"', 1, false);


--
-- Name: People_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."People_ID_seq"', 1, false);


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

SELECT pg_catalog.setval('public."Realtor_firms_ID_seq"', 1, false);


--
-- Name: Settlement_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Settlement_ID_seq"', 1, false);


--
-- Name: Settlement_district_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Settlement_district_ID_seq"', 1, false);


--
-- Name: Streets_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Streets_ID_seq"', 1, false);


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


CREATE FUNCTION public.add_district(p_id integer, p_name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO public.districts(id, name) VALUES (p_id, p_name)
$$;


ALTER FUNCTION public.add_district(p_id integer, p_name text) OWNER TO postgres;

--
-- Name: add_house(integer, integer, integer, text, text, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_house(p_id integer, p_street_id integer, p_type integer, p_number text, p_housing_number text, p_land_area double precision) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO houses(id, street_id, type, number, housing_number, land_area) 
		VALUES (p_id, p_street_id, p_type, p_number, p_housing_number, p_land_area)
$$;


ALTER FUNCTION public.add_house(p_id integer, p_street_id integer, p_type integer, p_number text, p_housing_number text, p_land_area double precision) OWNER TO postgres;

--
-- Name: add_settlement(integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_settlement(id integer, type integer, name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO settlements(id, type, name) VALUES (id, type, name)
$$;


ALTER FUNCTION public.add_settlement(id integer, type integer, name text) OWNER TO postgres;

--
-- Name: add_street(integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_street(id integer, settle_id integer, name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO streets(id, settlement_id, name) VALUES (id, settle_id, name)
$$;


ALTER FUNCTION public.add_street(id integer, settle_id integer, name text) OWNER TO postgres;

--
-- Name: delete_house(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_house(p_id integer) RETURNS void
    LANGUAGE sql
    AS $$
	DELETE FROM houses WHERE id = p_id;
$$;


ALTER FUNCTION public.delete_house(p_id integer) OWNER TO postgres;

--
-- Name: get_houses(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_houses() RETURNS TABLE(id integer, street_id integer, type integer, number text, housing_number text, land_area double precision)
    LANGUAGE sql
    AS $$
	SELECT * FROM houses;
$$;


ALTER FUNCTION public.get_houses() OWNER TO postgres;

--
-- Name: get_settlements(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_settlements() RETURNS TABLE(id integer, district_id integer, type integer, name text)
    LANGUAGE sql
    AS $$
	SELECT * FROM settlements;
$$;


ALTER FUNCTION public.get_settlements() OWNER TO postgres;

--
-- Name: get_streets(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_streets() RETURNS TABLE(id integer, settlement_id integer, name text)
    LANGUAGE sql
    AS $$
	SELECT * FROM streets;
$$;


ALTER FUNCTION public.get_streets() OWNER TO postgres;

--
-- Name: remove_settlement(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.remove_settlement(id integer) RETURNS void
    LANGUAGE sql
    AS $$
	DELETE FROM settlements WHERE settlements.id = remove_settlement.id;
$$;


ALTER FUNCTION public.remove_settlement(id integer) OWNER TO postgres;

--
-- Name: remove_street(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.remove_street(id integer) RETURNS void
    LANGUAGE sql
    AS $$
	DELETE FROM streets WHERE streets.id = remove_street.id;
$$;


ALTER FUNCTION public.remove_street(id integer) OWNER TO postgres;

--
-- Name: update_houses(integer, integer, integer, text, text, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_houses(p_id integer, p_street_id integer, p_type integer, p_number text, p_housing_number text, p_land_area double precision) RETURNS void
    LANGUAGE sql
    AS $$
	
	UPDATE houses SET (street_id, type, number, housing_number, land_area) = 
					  (p_street_id, p_type, p_number, p_housing_number, p_land_area)
		WHERE id = p_id;
$$;


ALTER FUNCTION public.update_houses(p_id integer, p_street_id integer, p_type integer, p_number text, p_housing_number text, p_land_area double precision) OWNER TO postgres;

--
-- Name: update_settlements(integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_settlements(p_id integer, p_type integer, p_name text) RETURNS void
    LANGUAGE sql
    AS $$
	UPDATE settlements SET (type, name) = (p_type, p_name) WHERE id = p_id;
$$;


ALTER FUNCTION public.update_settlements(p_id integer, p_type integer, p_name text) OWNER TO postgres;

--
-- Name: update_streets(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_streets(p_name text, p_id integer) RETURNS void
    LANGUAGE sql
    AS $$
	UPDATE streets SET name = p_name WHERE id = p_id;
$$;


ALTER FUNCTION public.update_streets(p_name text, p_id integer) OWNER TO postgres;



--
-- PostgreSQL database dump complete
--

