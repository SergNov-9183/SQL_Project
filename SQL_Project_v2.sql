--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Ads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ads" (
    "ID" integer NOT NULL,
    "People_ID" integer NOT NULL,
    "House_ID" integer NOT NULL,
    "Settlement_ID" integer NOT NULL,
    "Apartment_number" text,
    "Rooms_count" integer,
    "Total_area" double precision,
    "Living_areaa" double precision,
    "Kitchen_area" double precision,
    "Water_pipes" boolean,
    "Gas" boolean,
    "Electricity" boolean,
    "Sewerage" boolean,
    "Bathroom_type" text,
    "Category" text,
    "Ads_text" text,
    "Price" double precision,
    "Publication_or_update_time" text,
    "Addition_information" text
);


ALTER TABLE public."Ads" OWNER TO postgres;

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

ALTER SEQUENCE public."Ads_House_ID_seq" OWNED BY public."Ads"."House_ID";


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

ALTER SEQUENCE public."Ads_ID_seq" OWNED BY public."Ads"."ID";


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

ALTER SEQUENCE public."Ads_People_ID_seq" OWNED BY public."Ads"."People_ID";


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

ALTER SEQUENCE public."Ads_Settlement_ID_seq" OWNED BY public."Ads"."Settlement_ID";


--
-- Name: Districts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Districts" (
    "ID" integer NOT NULL,
    "Name" text
);


ALTER TABLE public."Districts" OWNER TO postgres;

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

ALTER SEQUENCE public."Districts_ID_seq" OWNED BY public."Districts"."ID";


--
-- Name: Documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Documents" (
    "ID" integer NOT NULL,
    "Tittle" text,
    "Description" text,
    "Sample" text
);


ALTER TABLE public."Documents" OWNER TO postgres;

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

ALTER SEQUENCE public."Documents_ID_seq" OWNED BY public."Documents"."ID";


--
-- Name: Houses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Houses" (
    "ID" integer NOT NULL,
    "Street_ID" integer NOT NULL,
    "Type" text,
    "Number" text,
    "Housing_number" text,
    "Land_area" double precision
);


ALTER TABLE public."Houses" OWNER TO postgres;

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

ALTER SEQUENCE public."Houses_ID_seq" OWNED BY public."Houses"."ID";


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

ALTER SEQUENCE public."Houses_Street_ID_seq" OWNED BY public."Houses"."Street_ID";


--
-- Name: People; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."People" (
    "ID" integer NOT NULL,
    "Surname" text,
    "Name" text,
    "Patronymic" text,
    "Phone" text,
    "E-mail" text,
    "Password" text,
    "Realtor_firm_ID" integer NOT NULL
);


ALTER TABLE public."People" OWNER TO postgres;

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

ALTER SEQUENCE public."People_ID_seq" OWNED BY public."People"."ID";


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

ALTER SEQUENCE public."People_Realtor_firm_ID_seq" OWNED BY public."People"."Realtor_firm_ID";


--
-- Name: Realtor_firms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Realtor_firms" (
    "ID" integer NOT NULL,
    "House_ID" integer NOT NULL,
    "Raiting" double precision,
    "Phone" text,
    "Mail" text,
    "Description" text
);


ALTER TABLE public."Realtor_firms" OWNER TO postgres;

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

ALTER SEQUENCE public."Realtor_firms_House_ID_seq" OWNED BY public."Realtor_firms"."House_ID";


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

ALTER SEQUENCE public."Realtor_firms_ID_seq" OWNED BY public."Realtor_firms"."ID";


--
-- Name: Settlement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Settlement" (
    "ID" integer NOT NULL,
    "district_ID" integer NOT NULL,
    "Type" text,
    "Name" text
);


ALTER TABLE public."Settlement" OWNER TO postgres;

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

ALTER SEQUENCE public."Settlement_ID_seq" OWNED BY public."Settlement"."ID";


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

ALTER SEQUENCE public."Settlement_district_ID_seq" OWNED BY public."Settlement"."district_ID";


--
-- Name: Streets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Streets" (
    "ID" integer NOT NULL,
    "Settlement_ID" integer NOT NULL,
    "Name" text
);


ALTER TABLE public."Streets" OWNER TO postgres;

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

ALTER SEQUENCE public."Streets_ID_seq" OWNED BY public."Streets"."ID";


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

ALTER SEQUENCE public."Streets_Settlement_ID_seq" OWNED BY public."Streets"."Settlement_ID";


--
-- Name: Ads ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads" ALTER COLUMN "ID" SET DEFAULT nextval('public."Ads_ID_seq"'::regclass);


--
-- Name: Ads People_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads" ALTER COLUMN "People_ID" SET DEFAULT nextval('public."Ads_People_ID_seq"'::regclass);


--
-- Name: Ads House_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads" ALTER COLUMN "House_ID" SET DEFAULT nextval('public."Ads_House_ID_seq"'::regclass);


--
-- Name: Ads Settlement_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads" ALTER COLUMN "Settlement_ID" SET DEFAULT nextval('public."Ads_Settlement_ID_seq"'::regclass);


--
-- Name: Districts ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Districts" ALTER COLUMN "ID" SET DEFAULT nextval('public."Districts_ID_seq"'::regclass);


--
-- Name: Documents ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Documents" ALTER COLUMN "ID" SET DEFAULT nextval('public."Documents_ID_seq"'::regclass);


--
-- Name: Houses ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Houses" ALTER COLUMN "ID" SET DEFAULT nextval('public."Houses_ID_seq"'::regclass);


--
-- Name: Houses Street_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Houses" ALTER COLUMN "Street_ID" SET DEFAULT nextval('public."Houses_Street_ID_seq"'::regclass);


--
-- Name: People ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."People" ALTER COLUMN "ID" SET DEFAULT nextval('public."People_ID_seq"'::regclass);


--
-- Name: People Realtor_firm_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."People" ALTER COLUMN "Realtor_firm_ID" SET DEFAULT nextval('public."People_Realtor_firm_ID_seq"'::regclass);


--
-- Name: Realtor_firms ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Realtor_firms" ALTER COLUMN "ID" SET DEFAULT nextval('public."Realtor_firms_ID_seq"'::regclass);


--
-- Name: Realtor_firms House_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Realtor_firms" ALTER COLUMN "House_ID" SET DEFAULT nextval('public."Realtor_firms_House_ID_seq"'::regclass);


--
-- Name: Settlement ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Settlement" ALTER COLUMN "ID" SET DEFAULT nextval('public."Settlement_ID_seq"'::regclass);


--
-- Name: Settlement district_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Settlement" ALTER COLUMN "district_ID" SET DEFAULT nextval('public."Settlement_district_ID_seq"'::regclass);


--
-- Name: Streets ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets" ALTER COLUMN "ID" SET DEFAULT nextval('public."Streets_ID_seq"'::regclass);


--
-- Name: Streets Settlement_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets" ALTER COLUMN "Settlement_ID" SET DEFAULT nextval('public."Streets_Settlement_ID_seq"'::regclass);


--
-- Data for Name: Ads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Ads" ("ID", "People_ID", "House_ID", "Settlement_ID", "Apartment_number", "Rooms_count", "Total_area", "Living_areaa", "Kitchen_area", "Water_pipes", "Gas", "Electricity", "Sewerage", "Bathroom_type", "Category", "Ads_text", "Price", "Publication_or_update_time", "Addition_information") FROM stdin;
\.


--
-- Data for Name: Districts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Districts" ("ID", "Name") FROM stdin;
\.


--
-- Data for Name: Documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Documents" ("ID", "Tittle", "Description", "Sample") FROM stdin;
\.


--
-- Data for Name: Houses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Houses" ("ID", "Street_ID", "Type", "Number", "Housing_number", "Land_area") FROM stdin;
\.


--
-- Data for Name: People; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."People" ("ID", "Surname", "Name", "Patronymic", "Phone", "E-mail", "Password", "Realtor_firm_ID") FROM stdin;
\.


--
-- Data for Name: Realtor_firms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Realtor_firms" ("ID", "House_ID", "Raiting", "Phone", "Mail", "Description") FROM stdin;
\.


--
-- Data for Name: Settlement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Settlement" ("ID", "district_ID", "Type", "Name") FROM stdin;
\.


--
-- Data for Name: Streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Streets" ("ID", "Settlement_ID", "Name") FROM stdin;
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

SELECT pg_catalog.setval('public."Districts_ID_seq"', 1, false);


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
-- Name: Ads Ads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads"
    ADD CONSTRAINT "Ads_pkey" PRIMARY KEY ("ID");


--
-- Name: Districts Districts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Districts"
    ADD CONSTRAINT "Districts_pkey" PRIMARY KEY ("ID");


--
-- Name: Documents Documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Documents"
    ADD CONSTRAINT "Documents_pkey" PRIMARY KEY ("ID");


--
-- Name: Houses Houses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Houses"
    ADD CONSTRAINT "Houses_pkey" PRIMARY KEY ("ID");


--
-- Name: People People_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."People"
    ADD CONSTRAINT "People_pkey" PRIMARY KEY ("ID");


--
-- Name: Realtor_firms Realtor_firms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Realtor_firms"
    ADD CONSTRAINT "Realtor_firms_pkey" PRIMARY KEY ("ID");


--
-- Name: Settlement Settlement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Settlement"
    ADD CONSTRAINT "Settlement_pkey" PRIMARY KEY ("ID");


--
-- Name: Streets Streets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets"
    ADD CONSTRAINT "Streets_pkey" PRIMARY KEY ("ID");


--
-- Name: Ads Ads_House_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads"
    ADD CONSTRAINT "Ads_House_ID_fkey" FOREIGN KEY ("House_ID") REFERENCES public."Houses"("ID") NOT VALID;


--
-- Name: Ads Ads_People_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads"
    ADD CONSTRAINT "Ads_People_ID_fkey" FOREIGN KEY ("People_ID") REFERENCES public."People"("ID") NOT VALID;


--
-- Name: Ads Ads_Settlement_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads"
    ADD CONSTRAINT "Ads_Settlement_ID_fkey" FOREIGN KEY ("Settlement_ID") REFERENCES public."Settlement"("ID") NOT VALID;


--
-- Name: Houses Houses_Street_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Houses"
    ADD CONSTRAINT "Houses_Street_ID_fkey" FOREIGN KEY ("Street_ID") REFERENCES public."Streets"("ID") NOT VALID;


--
-- Name: People People_Realtor_firm_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."People"
    ADD CONSTRAINT "People_Realtor_firm_ID_fkey" FOREIGN KEY ("Realtor_firm_ID") REFERENCES public."Realtor_firms"("ID") NOT VALID;


--
-- Name: Realtor_firms Realtor_firms_House_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Realtor_firms"
    ADD CONSTRAINT "Realtor_firms_House_ID_fkey" FOREIGN KEY ("House_ID") REFERENCES public."Houses"("ID") NOT VALID;


--
-- Name: Settlement Settlement_district_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Settlement"
    ADD CONSTRAINT "Settlement_district_ID_fkey" FOREIGN KEY ("district_ID") REFERENCES public."Districts"("ID") NOT VALID;


--
-- Name: Streets Streets_Settlement_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets"
    ADD CONSTRAINT "Streets_Settlement_ID_fkey" FOREIGN KEY ("Settlement_ID") REFERENCES public."Settlement"("ID") NOT VALID;


--
-- PostgreSQL database dump complete
--

