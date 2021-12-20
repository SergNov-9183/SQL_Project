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
    rooms_count integer,
    total_area double precision,
    living_area double precision,
    kitchen_area double precision,
    water_pipes boolean,
    gas boolean,
    sewerage boolean,
    bathroom_type integer,
    type integer,
    ads_text text,
    price double precision,
    publication_or_update_time text,
    addition_information text,
    house_type integer,
    square_meter_price double precision
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
    password text
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
-- Name: settlements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settlements (
    id integer NOT NULL,
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

SET client_encoding = 'UTF8';


COPY public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, house_type, square_meter_price) FROM stdin;
\.


--
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.houses (id, street_id, type, number, housing_number, land_area) FROM stdin;
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.people (id, surname, name, patronymic, phone, email, password) FROM stdin;
60	Кошелев	Владислав	Романович	+79156541225	koschvr@gmail.com	easy_password
61	Иванова	Мирослава	Владимировна	+78856555425	mirosl@gmail.com	easy_password
62	Кондратьев	Святозар	Миронович	2222222	mirosl@gmail.com	pass
\.


--
-- Data for Name: settlements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settlements (id, type, name) FROM stdin;
23	2	Пестяки
24	2	Зелёное
25	6	Первомайский
22	6	Дубровское
\.


--
-- Data for Name: streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.streets (id, settlement_id, name) FROM stdin;
31	22	Всесоюзная
32	24	Британская
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
-- Name: Settlement_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Settlement_ID_seq"', 1, false);


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
-- Name: ads_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ads_id_idx ON public.ads USING btree (id);


--
-- Name: houses_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX houses_id_idx ON public.houses USING btree (id);


--
-- Name: people_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX people_id_idx ON public.people USING btree (id);


--
-- Name: settlements_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX settlements_id_idx ON public.settlements USING btree (id);


--
-- Name: settlements_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX settlements_name_idx ON public.settlements USING btree (name);


--
-- Name: streets_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX streets_id_idx ON public.streets USING btree (id);


--
-- Name: ads ads_house_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_house_id_fkey FOREIGN KEY (house_id) REFERENCES public.houses(id) ON DELETE CASCADE;


--
-- Name: ads ads_people_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_people_id_fkey FOREIGN KEY (people_id) REFERENCES public.people(id) ON DELETE CASCADE;


--
-- Name: ads ads_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_settlement_id_fkey FOREIGN KEY (settlement_id) REFERENCES public.settlements(id) ON DELETE CASCADE;


--
-- Name: houses houses_street_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.streets(id) ON DELETE CASCADE;


--
-- Name: streets streets_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_settlement_id_fkey FOREIGN KEY (settlement_id) REFERENCES public.settlements(id) ON DELETE CASCADE;


CREATE FUNCTION public.add_ad(id integer, people_id integer, house_id integer, settlement_id integer, type integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price double precision, publication_or_update_time text, addition_information text, house_type integer) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO ads(id, people_id, house_id, settlement_id, type, rooms_count,
					total_area, living_area, kitchen_area, water_pipes, gas, 
					sewerage, bathroom_type, ads_text, price, 
					publication_or_update_time, addition_information, house_type) 
		VALUES (add_ad.id, add_ad.people_id, add_ad.house_id, add_ad.settlement_id, add_ad.type, add_ad.rooms_count,
					add_ad.total_area, add_ad.living_area, add_ad.kitchen_area, add_ad.water_pipes, add_ad.gas, 
					add_ad.sewerage, add_ad.bathroom_type, add_ad.ads_text, add_ad.price, 
					add_ad.publication_or_update_time, add_ad.addition_information, add_ad.house_type) 
$$;


ALTER FUNCTION public.add_ad(id integer, people_id integer, house_id integer, settlement_id integer, type integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price double precision, publication_or_update_time text, addition_information text, house_type integer) OWNER TO postgres;

--
-- Name: add_house(integer, integer, integer, text, text, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_house(id integer, street_id integer, type integer, number text, housing_number text, land_area double precision) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO houses(id, street_id, type, number, housing_number, land_area) 
		VALUES (add_house.id, add_house.street_id, add_house.type, 
				add_house.number, add_house.housing_number, add_house.land_area);
$$;


ALTER FUNCTION public.add_house(id integer, street_id integer, type integer, number text, housing_number text, land_area double precision) OWNER TO postgres;

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

CREATE FUNCTION public.add_street(id integer, settlement_id integer, name text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO streets(id, settlement_id, name) VALUES (add_street.id, add_street.settlement_id, add_street.name)
$$;


ALTER FUNCTION public.add_street(id integer, settlement_id integer, name text) OWNER TO postgres;

--
-- Name: add_user(integer, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_user(id integer, surname text, name text, patronymic text, phone text, email text, password text) RETURNS void
    LANGUAGE sql
    AS $$
	INSERT INTO people (id, surname, name, patronymic, phone, email, password)
			    VALUES (add_user.id, add_user.surname, add_user.name, add_user.patronymic, 
						add_user.phone, add_user.email, add_user.password);
$$;


ALTER FUNCTION public.add_user(id integer, surname text, name text, patronymic text, phone text, email text, password text) OWNER TO postgres;

--
-- Name: get_ads(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_ads() RETURNS TABLE(id integer, people_id integer, house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, type integer, ads_text text, price double precision, publication_or_update_time text, addition_information text, house_type integer, square_meter_price double precision)
    LANGUAGE sql
    AS $$
				SELECT * FROM ads;					
$$;


ALTER FUNCTION public.get_ads() OWNER TO postgres;

--
-- Name: get_all(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all() RETURNS TABLE(id integer, people_id integer, house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, type integer, ads_text text, price double precision, square_meter_price double precision, publication_or_update_time text, addition_information text, house_type_ads integer, surname text, user_name text, patronymic text, phone text, email text, house_type text, number text, housing_number text, land_area double precision, settlements_type_buy integer, settlements_name_buy text, streets_name text, settlements_type integer, settlements_name text)
    LANGUAGE sql
    AS $$
	SELECT A.id, A.people_id, A.house_id, A.settlement_id, A.rooms_count, A.total_area, 
		   A.living_area, A.kitchen_area, A.water_pipes, A.gas, A.sewerage, A.bathroom_type, 
		   A.type, A.ads_text, A.price, A.square_meter_price, A.publication_or_update_time,
		   A.addition_information, A.house_type, B.surname, B.name as user_name, B.patronymic, B.phone, B.email,
		   C.type as house_type, C.number, C.housing_number, C.land_area,
		   D.type as settlements_type_buy, D.name as settlements_name_buy,
		   E.name as streets_name, F.type as settlements_type, F.name as settlements_name
	FROM ads A
		LEFT JOIN people B ON B.id=A.people_id
		LEFT JOIN houses C ON C.id=A.house_id
		LEFT JOIN settlements D ON D.id=A.settlement_id
		LEFT JOIN streets E ON E.id=C.street_id
		LEFT JOIN settlements F ON F.id=E.settlement_id
	WHERE A.type=0;
$$;


ALTER FUNCTION public.get_all() OWNER TO postgres;

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

CREATE FUNCTION public.get_settlements() RETURNS TABLE(id integer, type integer, name text)
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
-- Name: get_user(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user(phone text) RETURNS TABLE(id integer, surname text, name text, patronymic text, phone text, email text, password text)
    LANGUAGE sql
    AS $$
	SELECT * FROM people p WHERE p.phone = get_user.phone; 			   
$$;


ALTER FUNCTION public.get_user(phone text) OWNER TO postgres;

--
-- Name: remove_ad(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.remove_ad(id integer) RETURNS void
    LANGUAGE sql
    AS $$
	DELETE FROM ads WHERE ads.id = remove_ad.id;
$$;


ALTER FUNCTION public.remove_ad(id integer) OWNER TO postgres;

--
-- Name: remove_house(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.remove_house(id integer) RETURNS void
    LANGUAGE sql
    AS $$
	DELETE FROM houses WHERE houses.id = remove_house.id;
$$;


ALTER FUNCTION public.remove_house(id integer) OWNER TO postgres;

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
-- Name: select_ads(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.select_ads(type integer) RETURNS TABLE(id integer, people_id integer, house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, type integer, ads_text text, price double precision, square_meter_price double precision, publication_or_update_time text, addition_information text, house_type integer)
    LANGUAGE sql
    AS $$
				SELECT 	A.id, A.people_id, A.house_id, A.settlement_id, A.rooms_count, A.total_area, 
		  				A.living_area, A.kitchen_area, A.water_pipes, A.gas, A.sewerage, A.bathroom_type, 
		   				A.type, A.ads_text, A.price, A.square_meter_price, A.publication_or_update_time,
		   				A.addition_information, A.house_type 
				FROM ads A WHERE A.type = select_ads.type;					
$$;


ALTER FUNCTION public.select_ads(type integer) OWNER TO postgres;

--
-- Name: select_settlements(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

--
-- Name: select_streets(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.select_streets(settlement_id integer) RETURNS TABLE(id integer, settlement_id integer, name text)
    LANGUAGE sql
    AS $$
	SELECT * FROM streets WHERE streets.settlement_id = select_streets.settlement_id;
$$;


ALTER FUNCTION public.select_streets(settlement_id integer) OWNER TO postgres;

--
-- Name: update_ad(integer, integer, integer, double precision, double precision, double precision, boolean, boolean, boolean, integer, text, double precision, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_ad(house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price double precision, publication_or_update_time text, addition_information text, house_type integer, id integer) RETURNS void
    LANGUAGE sql
    AS $$
	UPDATE ads SET (house_id, settlement_id, rooms_count,
					total_area, living_area, kitchen_area, water_pipes, gas, 
					sewerage, bathroom_type, ads_text, price, 
					publication_or_update_time, addition_information, house_type) =
				  (update_ad.house_id, update_ad.settlement_id, update_ad.rooms_count,
					update_ad.total_area, update_ad.living_area, update_ad.kitchen_area, update_ad.water_pipes, update_ad.gas, 
					update_ad.sewerage, update_ad.bathroom_type, update_ad.ads_text, update_ad.price, 
					update_ad.publication_or_update_time, update_ad.addition_information, update_ad.house_type) 
			WHERE ads.id = update_ad.id;
$$;


ALTER FUNCTION public.update_ad(house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price double precision, publication_or_update_time text, addition_information text, house_type integer, id integer) OWNER TO postgres;

--
-- Name: update_houses(integer, text, text, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_houses(type integer, number text, housing_number text, land_area double precision, id integer) RETURNS void
    LANGUAGE sql
    AS $$	
	UPDATE houses SET (type, number, housing_number, land_area) = 
					  (update_houses.type, update_houses.number, 
					   update_houses.housing_number, update_houses.land_area)
		WHERE houses.id = update_houses.id;
$$;


ALTER FUNCTION public.update_houses(type integer, number text, housing_number text, land_area double precision, id integer) OWNER TO postgres;

--
-- Name: update_settlements(integer, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_settlements(type integer, name text, id integer) RETURNS void
    LANGUAGE sql
    AS $$
	UPDATE settlements SET (type, name) = (update_settlements.type, update_settlements.name) WHERE id = update_settlements.id;
$$;


ALTER FUNCTION public.update_settlements(type integer, name text, id integer) OWNER TO postgres;

--
-- Name: update_streets(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_streets(name text, id integer) RETURNS void
    LANGUAGE sql
    AS $$
	UPDATE streets SET name = update_streets.name WHERE streets.id = update_streets.id;
$$;


ALTER FUNCTION public.update_streets(name text, id integer) OWNER TO postgres;


--
-- PostgreSQL database dump complete
--

