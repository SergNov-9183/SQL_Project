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

DROP DATABASE real_estate_app_database;
--
-- Name: real_estate_app_database; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE real_estate_app_database;


\connect real_estate_app_database

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Ads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ads" (
    "ID" integer NOT NULL,
    "Object_ID" integer NOT NULL,
    "Person_ID" integer NOT NULL,
    category text,
    "Announcement_text" text,
    "Price" double precision,
    "Time of publication_or_update" text,
    "Additional_information" text
);


ALTER TABLE public."Ads" OWNER TO postgres;

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
-- Name: Ads_Object_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ads_Object_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ads_Object_ID_seq" OWNER TO postgres;

--
-- Name: Ads_Object_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ads_Object_ID_seq" OWNED BY public."Ads"."Object_ID";


--
-- Name: Ads_Person_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ads_Person_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ads_Person_ID_seq" OWNER TO postgres;

--
-- Name: Ads_Person_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ads_Person_ID_seq" OWNED BY public."Ads"."Person_ID";


--
-- Name: Apartment_houses ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Apartment_houses " (
    "ID" integer NOT NULL,
    "Street_ID" integer NOT NULL,
    "Number" text,
    housing text,
    "Metro_station" text,
    "Number_of_floors" integer,
    "Building_material" text,
    "Year_built" integer
);


ALTER TABLE public."Apartment_houses " OWNER TO postgres;

--
-- Name: Apartment_houses _ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Apartment_houses _ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Apartment_houses _ID_seq" OWNER TO postgres;

--
-- Name: Apartment_houses _ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Apartment_houses _ID_seq" OWNED BY public."Apartment_houses "."ID";


--
-- Name: Apartment_houses _Street_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Apartment_houses _Street_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Apartment_houses _Street_ID_seq" OWNER TO postgres;

--
-- Name: Apartment_houses _Street_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Apartment_houses _Street_ID_seq" OWNED BY public."Apartment_houses "."Street_ID";


--
-- Name: Apartments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Apartments" (
    "ID" integer NOT NULL,
    "House_ID" integer NOT NULL,
    "Number" integer NOT NULL,
    "Price" double precision,
    "ID_of_person" integer NOT NULL,
    "Type" text,
    "Total_area" double precision,
    "Living_space" double precision,
    "Area_kitchen" double precision,
    "Bathroom_type" text
);


ALTER TABLE public."Apartments" OWNER TO postgres;

--
-- Name: Apartments_House_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Apartments_House_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Apartments_House_ID_seq" OWNER TO postgres;

--
-- Name: Apartments_House_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Apartments_House_ID_seq" OWNED BY public."Apartments"."House_ID";


--
-- Name: Apartments_ID_of_person_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Apartments_ID_of_person_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Apartments_ID_of_person_seq" OWNER TO postgres;

--
-- Name: Apartments_ID_of_person_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Apartments_ID_of_person_seq" OWNED BY public."Apartments"."ID_of_person";


--
-- Name: Apartments_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Apartments_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Apartments_ID_seq" OWNER TO postgres;

--
-- Name: Apartments_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Apartments_ID_seq" OWNED BY public."Apartments"."ID";


--
-- Name: Apartments_Number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Apartments_Number_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Apartments_Number_seq" OWNER TO postgres;

--
-- Name: Apartments_Number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Apartments_Number_seq" OWNED BY public."Apartments"."Number";


--
-- Name: Locality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Locality" (
    "ID" integer NOT NULL,
    "Type" text
);


ALTER TABLE public."Locality" OWNER TO postgres;

--
-- Name: Locality_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Locality_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Locality_ID_seq" OWNER TO postgres;

--
-- Name: Locality_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Locality_ID_seq" OWNED BY public."Locality"."ID";


--
-- Name: Object; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Object" (
    "ID" integer NOT NULL,
    "Type" text
);


ALTER TABLE public."Object" OWNER TO postgres;

--
-- Name: Object_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Object_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Object_ID_seq" OWNER TO postgres;

--
-- Name: Object_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Object_ID_seq" OWNED BY public."Object"."ID";


--
-- Name: People; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."People" (
    "ID" integer NOT NULL,
    "Surname" text,
    "Name" text,
    "Middle_name" text,
    "Telephone" text,
    "E-mail" text,
    "Type" text,
    "Passport_Series" text,
    "Passport_ID" text,
    "Date_of_issue_of_passport" text
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
-- Name: Private_houses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Private_houses" (
    "ID" integer NOT NULL,
    "Street_ID" integer NOT NULL,
    "Person_ID" integer NOT NULL,
    "Land_area" double precision,
    "Water_pipes" boolean,
    "Gas" boolean,
    "Electricity" boolean,
    "Sewerage" boolean,
    "Number_of_floors" text,
    "Building_material" text,
    "Year_built" integer
);


ALTER TABLE public."Private_houses" OWNER TO postgres;

--
-- Name: Private_houses_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Private_houses_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Private_houses_ID_seq" OWNER TO postgres;

--
-- Name: Private_houses_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Private_houses_ID_seq" OWNED BY public."Private_houses"."ID";


--
-- Name: Private_houses_Person_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Private_houses_Person_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Private_houses_Person_ID_seq" OWNER TO postgres;

--
-- Name: Private_houses_Person_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Private_houses_Person_ID_seq" OWNED BY public."Private_houses"."Person_ID";


--
-- Name: Private_houses_Street_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Private_houses_Street_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Private_houses_Street_ID_seq" OWNER TO postgres;

--
-- Name: Private_houses_Street_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Private_houses_Street_ID_seq" OWNED BY public."Private_houses"."Street_ID";


--
-- Name: Realtor_office ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Realtor_office " (
    "ID" integer NOT NULL,
    "Work_experience" text,
    "Rating" double precision,
    "Mobile_phone" text,
    "Education" text,
    "Confirmed specialist" boolean
);


ALTER TABLE public."Realtor_office " OWNER TO postgres;

--
-- Name: Realtor_office _ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Realtor_office _ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Realtor_office _ID_seq" OWNER TO postgres;

--
-- Name: Realtor_office _ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Realtor_office _ID_seq" OWNED BY public."Realtor_office "."ID";


--
-- Name: Securities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Securities" (
    "ID" integer NOT NULL,
    "Title" text,
    "Content" text
);


ALTER TABLE public."Securities" OWNER TO postgres;

--
-- Name: Securities_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Securities_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Securities_ID_seq" OWNER TO postgres;

--
-- Name: Securities_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Securities_ID_seq" OWNED BY public."Securities"."ID";


--
-- Name: Streets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Streets" (
    "ID" integer NOT NULL,
    "Locality_ID" integer NOT NULL,
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
-- Name: Streets_Locality_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Streets_Locality_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Streets_Locality_ID_seq" OWNER TO postgres;

--
-- Name: Streets_Locality_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Streets_Locality_ID_seq" OWNED BY public."Streets"."Locality_ID";


--
-- Name: Ads ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads" ALTER COLUMN "ID" SET DEFAULT nextval('public."Ads_ID_seq"'::regclass);


--
-- Name: Ads Object_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads" ALTER COLUMN "Object_ID" SET DEFAULT nextval('public."Ads_Object_ID_seq"'::regclass);


--
-- Name: Ads Person_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads" ALTER COLUMN "Person_ID" SET DEFAULT nextval('public."Ads_Person_ID_seq"'::regclass);


--
-- Name: Apartment_houses  ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartment_houses " ALTER COLUMN "ID" SET DEFAULT nextval('public."Apartment_houses _ID_seq"'::regclass);


--
-- Name: Apartment_houses  Street_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartment_houses " ALTER COLUMN "Street_ID" SET DEFAULT nextval('public."Apartment_houses _Street_ID_seq"'::regclass);


--
-- Name: Apartments ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartments" ALTER COLUMN "ID" SET DEFAULT nextval('public."Apartments_ID_seq"'::regclass);


--
-- Name: Apartments House_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartments" ALTER COLUMN "House_ID" SET DEFAULT nextval('public."Apartments_House_ID_seq"'::regclass);


--
-- Name: Apartments Number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartments" ALTER COLUMN "Number" SET DEFAULT nextval('public."Apartments_Number_seq"'::regclass);


--
-- Name: Apartments ID_of_person; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartments" ALTER COLUMN "ID_of_person" SET DEFAULT nextval('public."Apartments_ID_of_person_seq"'::regclass);


--
-- Name: Locality ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Locality" ALTER COLUMN "ID" SET DEFAULT nextval('public."Locality_ID_seq"'::regclass);


--
-- Name: Object ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Object" ALTER COLUMN "ID" SET DEFAULT nextval('public."Object_ID_seq"'::regclass);


--
-- Name: People ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."People" ALTER COLUMN "ID" SET DEFAULT nextval('public."People_ID_seq"'::regclass);


--
-- Name: Private_houses ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Private_houses" ALTER COLUMN "ID" SET DEFAULT nextval('public."Private_houses_ID_seq"'::regclass);


--
-- Name: Private_houses Street_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Private_houses" ALTER COLUMN "Street_ID" SET DEFAULT nextval('public."Private_houses_Street_ID_seq"'::regclass);


--
-- Name: Private_houses Person_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Private_houses" ALTER COLUMN "Person_ID" SET DEFAULT nextval('public."Private_houses_Person_ID_seq"'::regclass);


--
-- Name: Realtor_office  ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Realtor_office " ALTER COLUMN "ID" SET DEFAULT nextval('public."Realtor_office _ID_seq"'::regclass);


--
-- Name: Securities ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Securities" ALTER COLUMN "ID" SET DEFAULT nextval('public."Securities_ID_seq"'::regclass);


--
-- Name: Streets ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets" ALTER COLUMN "ID" SET DEFAULT nextval('public."Streets_ID_seq"'::regclass);


--
-- Name: Streets Locality_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets" ALTER COLUMN "Locality_ID" SET DEFAULT nextval('public."Streets_Locality_ID_seq"'::regclass);


--
-- Data for Name: Ads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Ads" ("ID", "Object_ID", "Person_ID", category, "Announcement_text", "Price", "Time of publication_or_update", "Additional_information") FROM stdin;
\.


--
-- Data for Name: Apartment_houses ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Apartment_houses " ("ID", "Street_ID", "Number", housing, "Metro_station", "Number_of_floors", "Building_material", "Year_built") FROM stdin;
\.


--
-- Data for Name: Apartments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Apartments" ("ID", "House_ID", "Number", "Price", "ID_of_person", "Type", "Total_area", "Living_space", "Area_kitchen", "Bathroom_type") FROM stdin;
\.


--
-- Data for Name: Locality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Locality" ("ID", "Type") FROM stdin;
\.


--
-- Data for Name: Object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Object" ("ID", "Type") FROM stdin;
\.


--
-- Data for Name: People; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."People" ("ID", "Surname", "Name", "Middle_name", "Telephone", "E-mail", "Type", "Passport_Series", "Passport_ID", "Date_of_issue_of_passport") FROM stdin;
\.


--
-- Data for Name: Private_houses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Private_houses" ("ID", "Street_ID", "Person_ID", "Land_area", "Water_pipes", "Gas", "Electricity", "Sewerage", "Number_of_floors", "Building_material", "Year_built") FROM stdin;
\.


--
-- Data for Name: Realtor_office ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Realtor_office " ("ID", "Work_experience", "Rating", "Mobile_phone", "Education", "Confirmed specialist") FROM stdin;
\.


--
-- Data for Name: Securities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Securities" ("ID", "Title", "Content") FROM stdin;
\.


--
-- Data for Name: Streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Streets" ("ID", "Locality_ID", "Name") FROM stdin;
\.


--
-- Name: Ads_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_ID_seq"', 1, false);


--
-- Name: Ads_Object_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_Object_ID_seq"', 1, false);


--
-- Name: Ads_Person_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ads_Person_ID_seq"', 1, false);


--
-- Name: Apartment_houses _ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Apartment_houses _ID_seq"', 1, false);


--
-- Name: Apartment_houses _Street_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Apartment_houses _Street_ID_seq"', 1, false);


--
-- Name: Apartments_House_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Apartments_House_ID_seq"', 1, false);


--
-- Name: Apartments_ID_of_person_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Apartments_ID_of_person_seq"', 1, false);


--
-- Name: Apartments_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Apartments_ID_seq"', 1, false);


--
-- Name: Apartments_Number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Apartments_Number_seq"', 1, false);


--
-- Name: Locality_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Locality_ID_seq"', 1, false);


--
-- Name: Object_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Object_ID_seq"', 1, false);


--
-- Name: People_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."People_ID_seq"', 1, false);


--
-- Name: Private_houses_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Private_houses_ID_seq"', 1, false);


--
-- Name: Private_houses_Person_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Private_houses_Person_ID_seq"', 1, false);


--
-- Name: Private_houses_Street_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Private_houses_Street_ID_seq"', 1, false);


--
-- Name: Realtor_office _ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Realtor_office _ID_seq"', 1, false);


--
-- Name: Securities_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Securities_ID_seq"', 1, false);


--
-- Name: Streets_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Streets_ID_seq"', 1, false);


--
-- Name: Streets_Locality_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Streets_Locality_ID_seq"', 1, false);


--
-- Name: Ads Ads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads"
    ADD CONSTRAINT "Ads_pkey" PRIMARY KEY ("ID");


--
-- Name: Apartment_houses  Apartment_houses _pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartment_houses "
    ADD CONSTRAINT "Apartment_houses _pkey" PRIMARY KEY ("ID");


--
-- Name: Apartments Apartments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartments"
    ADD CONSTRAINT "Apartments_pkey" PRIMARY KEY ("ID");


--
-- Name: Locality Locality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Locality"
    ADD CONSTRAINT "Locality_pkey" PRIMARY KEY ("ID");


--
-- Name: Object Object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Object"
    ADD CONSTRAINT "Object_pkey" PRIMARY KEY ("ID");


--
-- Name: People People_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."People"
    ADD CONSTRAINT "People_pkey" PRIMARY KEY ("ID");


--
-- Name: Private_houses Private_houses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Private_houses"
    ADD CONSTRAINT "Private_houses_pkey" PRIMARY KEY ("ID");


--
-- Name: Realtor_office  Realtor_office _pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Realtor_office "
    ADD CONSTRAINT "Realtor_office _pkey" PRIMARY KEY ("ID");


--
-- Name: Securities Securities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Securities"
    ADD CONSTRAINT "Securities_pkey" PRIMARY KEY ("ID");


--
-- Name: Streets Streets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets"
    ADD CONSTRAINT "Streets_pkey" PRIMARY KEY ("ID");


--
-- Name: Ads Ads_Object_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads"
    ADD CONSTRAINT "Ads_Object_ID_fkey" FOREIGN KEY ("Object_ID") REFERENCES public."Object"("ID") NOT VALID;


--
-- Name: Ads Ads_Person_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ads"
    ADD CONSTRAINT "Ads_Person_ID_fkey" FOREIGN KEY ("Person_ID") REFERENCES public."People"("ID") NOT VALID;


--
-- Name: Apartment_houses  Apartment_houses _ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartment_houses "
    ADD CONSTRAINT "Apartment_houses _ID_fkey" FOREIGN KEY ("ID") REFERENCES public."Object"("ID") NOT VALID;


--
-- Name: Apartment_houses  Apartment_houses _Street_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartment_houses "
    ADD CONSTRAINT "Apartment_houses _Street_ID_fkey" FOREIGN KEY ("Street_ID") REFERENCES public."Streets"("ID") NOT VALID;


--
-- Name: Apartments Apartments_House_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Apartments"
    ADD CONSTRAINT "Apartments_House_ID_fkey" FOREIGN KEY ("House_ID") REFERENCES public."Apartment_houses "("ID") NOT VALID;


--
-- Name: Streets Locality_ID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets"
    ADD CONSTRAINT "Locality_ID" FOREIGN KEY ("Locality_ID") REFERENCES public."Locality"("ID") NOT VALID;


--
-- Name: Private_houses Private_houses_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Private_houses"
    ADD CONSTRAINT "Private_houses_ID_fkey" FOREIGN KEY ("ID") REFERENCES public."Object"("ID") NOT VALID;


--
-- Name: Private_houses Private_houses_Street_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Private_houses"
    ADD CONSTRAINT "Private_houses_Street_ID_fkey" FOREIGN KEY ("Street_ID") REFERENCES public."Streets"("ID") NOT VALID;


--
-- Name: Realtor_office  Realtor_office _ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Realtor_office "
    ADD CONSTRAINT "Realtor_office _ID_fkey" FOREIGN KEY ("ID") REFERENCES public."People"("ID") NOT VALID;


--
-- PostgreSQL database dump complete
--

