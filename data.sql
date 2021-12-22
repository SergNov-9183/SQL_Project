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

--
-- Name: add_user(integer, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.add_user(id integer, surname text, name text, patronymic text, phone text, email text, password text) RETURNS void
    LANGUAGE sql
    AS $$ insert into people (id, surname, name, patronymic, phone, email, password) values (add_user.id, add_user.surname, add_user.name, add_user.patronymic, add_user.phone, add_user.email, add_user.password) $$;


ALTER FUNCTION public.add_user(id integer, surname text, name text, patronymic text, phone text, email text, password text) OWNER TO user1;

--
-- Name: ads_history_after(); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.ads_history_after() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ begin   if (new.type = 0 or new.type = 2) then     insert into ads_history     select new.id, TG_OP, P.surname, P.name, P.patronymic, P.phone, new.type, new.publication_or_update_time, H.settlements_name, H.street_name, H.number, H.housing_number, new.price       from get_house_info(new.house_id) H     left join people P on P.id=new.people_id;   else     insert into ads_history     select new.id, TG_OP, P.surname, P.name, P.patronymic, P.phone, new.type, new.publication_or_update_time, L.name, null, null, null, new.price     from get_settlement_info(new.settlement_id) L     left join people P on P.id=new.people_id;   end if;   return new; end; $$;


ALTER FUNCTION public.ads_history_after() OWNER TO user1;

--
-- Name: ads_history_before(); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.ads_history_before() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ begin   if (old.type = 0 or old.type = 2) then     insert into ads_history     select old.id, TG_OP, P.surname, P.name, P.patronymic, P.phone, old.type, old.publication_or_update_time, H.settlements_name, H.street_name, H.number, H.housing_number, old.price      from get_house_info(old.house_id) H     left join people P on P.id=old.people_id;   else     insert into ads_history     select old.id, TG_OP, P.surname, P.name, P.patronymic, P.phone, old.type, old.publication_or_update_time, L.name, null, null, null, old.price      from get_settlement_info(old.settlement_id) L     left join people P on P.id=old.people_id;   end if;   return old; end; $$;


ALTER FUNCTION public.ads_history_before() OWNER TO user1;

--
-- Name: get_house_info(integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.get_house_info(id integer) RETURNS TABLE(type integer, number text, housing_number text, land_area integer, street_name text, settlements_name text, settlements_type integer)
    LANGUAGE sql
    AS $$ select H.type, H.number, H.housing_number, H.land_area,         S.name as street_name, L.name as settlements_name, L.type as settlements_type  from houses H  left join streets S on S.id=H.street_id  left join settlements L on L.id=S.settlement_id  where H.id=get_house_info.id $$;


ALTER FUNCTION public.get_house_info(id integer) OWNER TO user1;

--
-- Name: get_settlement_info(integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.get_settlement_info(id integer) RETURNS TABLE(id integer, type integer, name text)
    LANGUAGE sql
    AS $$ select id, type, name from settlements where id=get_settlement_info.id $$;


ALTER FUNCTION public.get_settlement_info(id integer) OWNER TO user1;

--
-- Name: get_user(text); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.get_user(phone text) RETURNS TABLE(id integer, surname text, name text, patronymic text, phone text, email text, password text)
    LANGUAGE sql
    AS $$select * from people where phone=get_user.phone$$;


ALTER FUNCTION public.get_user(phone text) OWNER TO user1;

--
-- Name: insert_ads(integer, integer, integer, integer, integer, integer, double precision, double precision, double precision, boolean, boolean, boolean, integer, text, integer, text, text, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.insert_ads(id integer, people_id integer, house_id integer, settlement_id integer, type integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price integer, publication_or_update_time text, addition_information text, settlement_house_type integer) RETURNS void
    LANGUAGE sql
    AS $$ insert into ads (id, people_id, house_id, settlement_id, type, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas,                   sewerage, bathroom_type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type)          values (insert_ads.id, insert_ads.people_id, case when insert_ads.house_id < 1 then null else insert_ads.house_id end,                  case when insert_ads.settlement_id < 1 then null else insert_ads.settlement_id end, insert_ads.type, insert_ads.rooms_count,                  insert_ads.total_area, insert_ads.living_area, insert_ads.kitchen_area, insert_ads.water_pipes, insert_ads.gas, insert_ads.sewerage,                  insert_ads.bathroom_type, insert_ads.ads_text, insert_ads.price, insert_ads.publication_or_update_time, insert_ads.addition_information,                  insert_ads.settlement_house_type) $$;


ALTER FUNCTION public.insert_ads(id integer, people_id integer, house_id integer, settlement_id integer, type integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price integer, publication_or_update_time text, addition_information text, settlement_house_type integer) OWNER TO user1;

--
-- Name: insert_houses(integer, integer, integer, text, text, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.insert_houses(id integer, street_id integer, type integer, number text, housing_number text, land_area integer) RETURNS void
    LANGUAGE sql
    AS $$ insert into houses (id, street_id, type, number, housing_number, land_area) values (insert_houses.id, insert_houses.street_id, insert_houses.type, insert_houses.number, insert_houses.housing_number, insert_houses.land_area) $$;


ALTER FUNCTION public.insert_houses(id integer, street_id integer, type integer, number text, housing_number text, land_area integer) OWNER TO user1;

--
-- Name: insert_settlements(integer, integer, text); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.insert_settlements(id integer, type integer, name text) RETURNS void
    LANGUAGE sql
    AS $$ insert into settlements (id, type, name) values (insert_settlements.id, insert_settlements.type, insert_settlements.name) $$;


ALTER FUNCTION public.insert_settlements(id integer, type integer, name text) OWNER TO user1;

--
-- Name: insert_streets(integer, integer, text); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.insert_streets(id integer, settlement_id integer, name text) RETURNS void
    LANGUAGE sql
    AS $$ insert into streets (id, settlement_id, name) values (insert_streets.id, insert_streets.settlement_id, insert_streets.name) $$;


ALTER FUNCTION public.insert_streets(id integer, settlement_id integer, name text) OWNER TO user1;

--
-- Name: min_user(); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.min_user() RETURNS TABLE(adminid integer)
    LANGUAGE sql
    AS $$ select min(id) as adminId from people $$;


ALTER FUNCTION public.min_user() OWNER TO user1;

--
-- Name: remove_ads(integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.remove_ads(id integer) RETURNS void
    LANGUAGE sql
    AS $$ delete from ads where id=remove_ads.id $$;


ALTER FUNCTION public.remove_ads(id integer) OWNER TO user1;

--
-- Name: remove_houses(integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.remove_houses(id integer) RETURNS void
    LANGUAGE sql
    AS $$ delete from houses where id=remove_houses.id $$;


ALTER FUNCTION public.remove_houses(id integer) OWNER TO user1;

--
-- Name: remove_settlements(integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.remove_settlements(id integer) RETURNS void
    LANGUAGE sql
    AS $$ delete from settlements where id=remove_settlements.id $$;


ALTER FUNCTION public.remove_settlements(id integer) OWNER TO user1;

--
-- Name: remove_streets(integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.remove_streets(id integer) RETURNS void
    LANGUAGE sql
    AS $$ delete from streets where id=remove_streets.id $$;


ALTER FUNCTION public.remove_streets(id integer) OWNER TO user1;

--
-- Name: select_ads(text, integer, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.select_ads(name_filter text, type integer, user_id integer) RETURNS TABLE(id integer, people_id integer, house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, type integer, ads_text text, price double precision, publication_or_update_time text, addition_information text, settlement_house_type integer, price_per_sq_m double precision, user_name text, phone text, email text, house_type integer, number text, housing_number text, land_area integer, settlements_type_buy integer, settlements_name_buy text, streets_name text, settlements_type integer, settlements_name text)
    LANGUAGE sql
    AS $$ select A.*,     B.name as user_name, B.phone, B.email,     C.type as house_type, C.number, C.housing_number, C.land_area,     D.type as settlements_type_buy, D.name as settlements_name_buy,     E.name as streets_name,     F.type as settlements_type, F.name as settlements_name from ads A left join people B on B.id=A.people_id left join houses C on C.id=A.house_id left join settlements D on D.id=A.settlement_id left join streets E on E.id=C.street_id left join settlements F on F.id=E.settlement_id where (F.name like select_ads.name_filter || '%' or D.name like select_ads.name_filter || '%') and A.type=select_ads.type and (select_ads.user_id<1 or select_ads.user_id=A.people_id or select_ads.user_id=(select min(id) as adminId from people)) order by F.name, D.name $$;


ALTER FUNCTION public.select_ads(name_filter text, type integer, user_id integer) OWNER TO user1;

--
-- Name: select_houses(text, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.select_houses(name_filter text, street_id integer) RETURNS TABLE(id integer, street_id integer, type integer, number text, housing_number text, land_area integer)
    LANGUAGE sql
    AS $$ select id, street_id, type, number, housing_number, land_area  from houses  where number like select_houses.name_filter and street_id=select_houses.street_id order by number $$;


ALTER FUNCTION public.select_houses(name_filter text, street_id integer) OWNER TO user1;

--
-- Name: select_settlements(text); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.select_settlements(name_filter text) RETURNS TABLE(id integer, type integer, name text)
    LANGUAGE sql
    AS $$ select id, type, name  from settlements  where name like select_settlements.name_filter order by name $$;


ALTER FUNCTION public.select_settlements(name_filter text) OWNER TO user1;

--
-- Name: select_streets(text, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.select_streets(name_filter text, settlement_id integer) RETURNS TABLE(id integer, settlement_id integer, name text)
    LANGUAGE sql
    AS $$ select id, settlement_id, name  from streets  where name like  select_streets.name_filter and settlement_id=select_streets.settlement_id order by name $$;


ALTER FUNCTION public.select_streets(name_filter text, settlement_id integer) OWNER TO user1;

--
-- Name: update_ads(integer, integer, integer, double precision, double precision, double precision, boolean, boolean, boolean, integer, text, integer, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.update_ads(house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price integer, publication_or_update_time text, addition_information text, settlement_house_type integer, id integer) RETURNS void
    LANGUAGE sql
    AS $$ update ads set house_id=case when update_ads.house_id < 1 then null else update_ads.house_id end,                 settlement_id=case when update_ads.settlement_id < 1 then null else update_ads.settlement_id end,                 rooms_count=update_ads.rooms_count,                 total_area=update_ads.total_area,                 living_area=update_ads.living_area,                 kitchen_area=update_ads.kitchen_area,                 water_pipes=update_ads.water_pipes,                 gas=update_ads.gas,                 sewerage=update_ads.sewerage,                 bathroom_type=update_ads.bathroom_type,                 ads_text=update_ads.ads_text,                 price=update_ads.price,                 publication_or_update_time=update_ads.publication_or_update_time,                 addition_information=update_ads.addition_information,                 settlement_house_type=update_ads.settlement_house_type  where id=id $$;


ALTER FUNCTION public.update_ads(house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price integer, publication_or_update_time text, addition_information text, settlement_house_type integer, id integer) OWNER TO user1;

--
-- Name: update_houses(integer, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.update_houses(type integer, number text, housing_number text, land_area integer, id integer) RETURNS void
    LANGUAGE sql
    AS $$ update houses set type=update_houses.type, number=update_houses.number, housing_number=update_houses.housing_number, land_area=update_houses.land_area where id=update_houses.id $$;


ALTER FUNCTION public.update_houses(type integer, number text, housing_number text, land_area integer, id integer) OWNER TO user1;

--
-- Name: update_settlements(integer, text, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.update_settlements(type integer, name text, id integer) RETURNS void
    LANGUAGE sql
    AS $$ update settlements set type=update_settlements.type, name=update_settlements.name where id=update_settlements.id $$;


ALTER FUNCTION public.update_settlements(type integer, name text, id integer) OWNER TO user1;

--
-- Name: update_streets(text, integer); Type: FUNCTION; Schema: public; Owner: user1
--

CREATE FUNCTION public.update_streets(name text, id integer) RETURNS void
    LANGUAGE sql
    AS $$ update streets set name=update_streets.name where id=update_streets.id $$;


ALTER FUNCTION public.update_streets(name text, id integer) OWNER TO user1;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ads; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.ads (
    id integer NOT NULL,
    people_id integer NOT NULL,
    house_id integer,
    settlement_id integer,
    rooms_count integer DEFAULT 1 NOT NULL,
    total_area double precision DEFAULT 0 NOT NULL,
    living_area double precision DEFAULT 0 NOT NULL,
    kitchen_area double precision DEFAULT 0 NOT NULL,
    water_pipes boolean DEFAULT true NOT NULL,
    gas boolean DEFAULT true NOT NULL,
    sewerage boolean DEFAULT true NOT NULL,
    bathroom_type integer DEFAULT 0 NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    ads_text text,
    price integer DEFAULT 0 NOT NULL,
    publication_or_update_time text,
    addition_information text,
    settlement_house_type integer DEFAULT 0 NOT NULL,
    price_per_sq_m double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public.ads OWNER TO user1;

--
-- Name: ads_history; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.ads_history (
    id integer NOT NULL,
    action text NOT NULL,
    surname text,
    name text,
    patronymic text,
    phone text,
    ads_type integer,
    date_time text NOT NULL,
    settlements_name text,
    street_name text,
    house_number text,
    housing_number text,
    price integer
);


ALTER TABLE public.ads_history OWNER TO user1;

--
-- Name: ads_id_seq; Type: SEQUENCE; Schema: public; Owner: user1
--

CREATE SEQUENCE public.ads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ads_id_seq OWNER TO user1;

--
-- Name: ads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user1
--

ALTER SEQUENCE public.ads_id_seq OWNED BY public.ads.id;


--
-- Name: houses; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.houses (
    id integer NOT NULL,
    street_id integer NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    number text DEFAULT 1 NOT NULL,
    housing_number text,
    land_area double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public.houses OWNER TO user1;

--
-- Name: houses_id_seq; Type: SEQUENCE; Schema: public; Owner: user1
--

CREATE SEQUENCE public.houses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.houses_id_seq OWNER TO user1;

--
-- Name: houses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user1
--

ALTER SEQUENCE public.houses_id_seq OWNED BY public.houses.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.people (
    id integer NOT NULL,
    surname text,
    name text,
    patronymic text,
    phone text NOT NULL,
    email text,
    password text
);


ALTER TABLE public.people OWNER TO user1;

--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: user1
--

CREATE SEQUENCE public.people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_id_seq OWNER TO user1;

--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user1
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- Name: settlements; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.settlements (
    id integer NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.settlements OWNER TO user1;

--
-- Name: settlements_id_seq; Type: SEQUENCE; Schema: public; Owner: user1
--

CREATE SEQUENCE public.settlements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settlements_id_seq OWNER TO user1;

--
-- Name: settlements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user1
--

ALTER SEQUENCE public.settlements_id_seq OWNED BY public.settlements.id;


--
-- Name: streets; Type: TABLE; Schema: public; Owner: user1
--

CREATE TABLE public.streets (
    id integer NOT NULL,
    settlement_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.streets OWNER TO user1;

--
-- Name: streets_id_seq; Type: SEQUENCE; Schema: public; Owner: user1
--

CREATE SEQUENCE public.streets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.streets_id_seq OWNER TO user1;

--
-- Name: streets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user1
--

ALTER SEQUENCE public.streets_id_seq OWNED BY public.streets.id;


--
-- Name: ads id; Type: DEFAULT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.ads ALTER COLUMN id SET DEFAULT nextval('public.ads_id_seq'::regclass);


--
-- Name: houses id; Type: DEFAULT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.houses ALTER COLUMN id SET DEFAULT nextval('public.houses_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- Name: settlements id; Type: DEFAULT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.settlements ALTER COLUMN id SET DEFAULT nextval('public.settlements_id_seq'::regclass);


--
-- Name: streets id; Type: DEFAULT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.streets ALTER COLUMN id SET DEFAULT nextval('public.streets_id_seq'::regclass);


--
-- Data for Name: ads; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) FROM stdin;
\.


--
-- Data for Name: ads_history; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) FROM stdin;
2	INSERT		user1		user1	0	22 декабря 2021 г. - 21:31:38	Нижний Новгород	Генерала Ивлеева	3		3200000
2	UPDATE		user1		user1	0	22 декабря 2021 г. - 21:32:32	Нижний Новгород	Генерала Ивлеева	3		3200000
2	DELETE		user1		user1	0	22 декабря 2021 г. - 21:32:32	Нижний Новгород	Генерала Ивлеева	3		3200000
3	INSERT	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:36:06	Нижний Новгород	Генерала Ивлеева	3		6000000
3	UPDATE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:37:26	Нижний Новгород	Генерала Ивлеева	3		6000000
4	INSERT	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:39:48	Нижний Новгород	Гоголя	45		1500000
5	INSERT	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:47:18	Нижний Новгород	Генерала Ивлеева	5		2356000
3	UPDATE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:47:58	Нижний Новгород	Генерала Ивлеева	5		2356000
4	UPDATE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:47:58	Нижний Новгород	Генерала Ивлеева	5		2356000
5	UPDATE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:47:58	Нижний Новгород	Генерала Ивлеева	5		2356000
6	INSERT	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:54:57	Нижний Новгород	Генерала Ивлеева	4		1000
3	DELETE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:47:58	Нижний Новгород	Генерала Ивлеева	5		2356000
4	DELETE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:47:58	Нижний Новгород	Генерала Ивлеева	5		2356000
5	DELETE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 21:47:58	Нижний Новгород	Генерала Ивлеева	5		2356000
6	UPDATE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 22:01:22	Нижний Новгород	Генерала Ивлеева	4		10500000
6	UPDATE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 22:01:46	Нижний Новгород	Генерала Ивлеева	4		10500000
6	DELETE	Краеведов	Роман	Александрович	+79200545698	0	22 декабря 2021 г. - 22:01:46	Нижний Новгород	Генерала Ивлеева	4		10500000
\.


--
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.houses (id, street_id, type, number, housing_number, land_area) FROM stdin;
1	195	0	26		800
2	195	1	45		0
3	218	1	78	3	0
4	217	0	1		700
5	217	0	2		760
6	217	0	3		752
7	217	0	4		920
8	217	0	5		910
9	213	1	29		0
12	213	1	6		0
11	213	1	12		0
10	213	1	3		0
13	191	1	37	3	0
14	191	1	31А		0
15	191	1	80		0
16	191	1	44		0
17	191	0	22		563
18	191	1	57	6	0
19	191	1	59		0
20	195	0	73		964
21	204	1	24		0
22	204	0	30		780
23	204	0	51		481
24	204	0	35А		790
25	219	0	57		730
26	219	0	62А		810
27	219	0	67		530
28	219	0	19		965
29	219	0	10		520
30	219	0	37		610
31	219	0	23		640
32	219	0	99		735
33	219	0	61А		900
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.people (id, surname, name, patronymic, phone, email, password) FROM stdin;
1		user1		user1		3E30343972
2	Присталов	Ярослав	Алексеевич	+79456595448	yp@yandex.ru	3A3434393728
3	Краеведов	Роман	Александрович	+79200545698	roman.al@gmail.com	3A3434393728
4	Ванятов	Станислав	Владимирович	+71511511551	stan@stan.ru	3837302530252A2D
5	Лазков	Игорь	Иосифович	+71511511552	no@no.igor	22243E39
\.


--
-- Data for Name: settlements; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.settlements (id, type, name) FROM stdin;
2	2	Заволжье
3	2	Балахна
4	2	Арзамас
5	2	Дзержинск
7	2	Бор
8	3	Афонино
9	1	Дальнее Константиново
10	1	Вад
11	1	Городец
1	0	Нижний Новгород
12	3	Шёлокша
13	4	Крутой Майдан
6	1	Кстово
16	1	Чкаловск
17	3	Катунки
18	5	Трофаново
20	1	Перевоз
21	5	Чувахлей
22	4	Кирилловка
19	4	Большие Бакалды
15	4	Пурех
\.


--
-- Data for Name: streets; Type: TABLE DATA; Schema: public; Owner: user1
--

COPY public.streets (id, settlement_id, name) FROM stdin;
1	4	Советская
2	4	Октябрьская
3	4	Коммунистов
4	4	Пролетарская
6	4	Строительная
7	4	Солнечная
8	4	50 лет ВЛКСМ
9	4	Чкалова
10	4	Чехова
11	4	Короленко
12	4	Победы
13	4	Нижегородская
14	4	Локомотивная
15	8	Парковая
16	8	Магистральная
17	8	Центральная
18	8	Абрикосовая
19	8	Яблоневая
20	8	Серверная
21	8	Нижняя
22	8	Горная
23	8	Лесная
24	3	Дзержинского
25	3	Строителей
26	3	Энгельса
27	3	Челюскинцев
28	3	Пушкина
29	3	Главная
30	3	Некрасова
31	3	Ленина
32	3	Алексеевская
33	3	Сосновая
34	3	Свердлова
35	3	Заречная
36	3	Чапаева
37	3	Юбилейная
38	3	Кирова
39	3	1 мая
40	19	Первомайская
41	19	Калинина
42	19	Центральная
43	19	Садовая
44	19	Новая
45	7	Набережная
46	7	Интернациональная
47	7	Васильковая
48	7	Студеная
49	7	Первомайская
50	7	Кулибина
51	7	Куйбышева
52	7	Мусоргского
55	7	Московцева
56	7	Степана Разина
57	7	Чернышевского
58	7	Парижской Коммуны
59	7	Степана Разина
60	7	Теплоходская
61	10	1 Мая
62	10	Кирпичная
63	10	Молодежная
64	10	40 лет Октября
65	10	Привокзальная
66	10	40 лет Победы
67	10	Южная
68	10	Почтовая
69	10	Москвичева
70	10	Привокзальная
71	10	Больничная
72	11	Березовая
73	11	Мебельная
74	11	Ростовская
75	11	Ворожейкина
76	11	Кооперативный съезд
77	11	Суворова
78	11	Спартака
79	11	Осоавиахимовский Съезд
80	11	Малая Долинка
81	11	Красногвардейская
82	11	Рождественская
83	9	Березовская
84	9	Ветеринарная
85	9	Спортивная
86	9	Студеная
89	9	Олимпийская
90	9	Автомобилистов
91	9	40 лет Победы
92	9	Фильченкова
93	5	Автомобильная
94	5	9 Января
95	5	Кирова
96	5	Народная
97	5	Марковникова
98	5	Черняховского
99	5	Сухаренко
100	5	Маяковского
101	5	Революции
102	5	Водозаборная
103	5	Попова
104	5	Лермонтова
105	5	Индустриальная
106	2	Береговая
107	2	Генераторная
108	2	Железнодорожная
109	2	Трансформаторная
110	2	Строительная
111	2	Привокзальная
112	2	Лесозаводская
114	2	Комсомольская
115	2	Турбинная
116	2	Гидростроительная
118	2	Коллекторная
119	2	Луначарского
120	17	Кирова
121	17	Советская
122	17	Садовая
123	17	Набережная
124	22	Ленина
125	22	Полевая
126	22	Садовая
127	22	Заречная
128	22	9 мая
129	22	Суханова
130	22	Молодёжная
131	13	Заовражная
132	13	Красная Горка
133	13	Микрорайон
134	13	Новая
135	13	Сельская
136	6	40 лет Октября
137	6	Магистральная
138	6	Медицинская
139	6	Комсомольская
140	6	Вишенская
141	6	Пионерская
142	6	Краснодонцев
143	6	Мичурина
144	6	8 Марта
145	6	Сосновская
146	6	Западная
147	6	Столбищенская
148	6	Невзорова
149	6	Талалушкина
150	6	Коминтерна
151	6	Октябрьская
152	6	Герцена
153	20	Кирова
154	20	Советская
155	20	Горького
156	20	Нагорная
157	20	Станционная
158	20	Победы
159	20	Чкалова
160	20	Северная
161	20	Коммунальная
162	20	Молодёжная
163	20	Сельхозтехника
164	20	Чугунова
165	20	Южная
166	15	Ленина
167	15	Полевая
168	15	Луговая
169	15	Северная
170	18	Главная
171	16	Пушкина
172	16	Матросова
173	16	Ломоносова
174	16	Суворова
175	16	Жуковского
176	16	Краснофлотская
177	16	Лесная
178	16	Белинского
179	16	Космонавтов
180	16	Крупской
181	16	Чкалова
182	16	Ленина
183	16	Кооперативная
184	16	Водопьянова
185	16	Куйбышева
186	21	Главная
187	12	Центральная
188	12	Тепличная
189	12	Новая
190	12	Берёзовая
191	1	Генкиной
192	1	Рождественская
193	1	Глеба Успенского
194	1	Надежды Сусловой
195	1	Гоголя
196	1	Минина
197	1	Родионова
198	1	Баумана
199	1	Терешковой
200	1	Белинского
201	1	Ильинская
202	1	Снежная
203	1	Янки Купалы
204	1	Салганская
205	1	Революционная
206	1	Чаадаева
207	1	Пролетарская
208	1	Почаинская
209	1	Заломова
210	1	Звездинка
211	1	Октябрьская
212	1	Пискунова
213	1	Варварская
214	1	Ульянова
215	1	Ковалихинская
216	1	Бринского
217	1	Генерала Ивлеева
218	1	Деловая
219	1	Политехническая
220	1	Львовская
221	1	Школьная
222	1	Ванеева
\.


--
-- Name: ads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user1
--

SELECT pg_catalog.setval('public.ads_id_seq', 6, true);


--
-- Name: houses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user1
--

SELECT pg_catalog.setval('public.houses_id_seq', 33, true);


--
-- Name: people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user1
--

SELECT pg_catalog.setval('public.people_id_seq', 5, true);


--
-- Name: settlements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user1
--

SELECT pg_catalog.setval('public.settlements_id_seq', 22, true);


--
-- Name: streets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user1
--

SELECT pg_catalog.setval('public.streets_id_seq', 222, true);


--
-- Name: ads ads_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (id);


--
-- Name: houses houses_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: settlements settlements_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT settlements_pkey PRIMARY KEY (id);


--
-- Name: streets streets_pkey; Type: CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (id);


--
-- Name: ads_id; Type: INDEX; Schema: public; Owner: user1
--

CREATE INDEX ads_id ON public.ads USING btree (id);


--
-- Name: houses_find; Type: INDEX; Schema: public; Owner: user1
--

CREATE INDEX houses_find ON public.houses USING btree (number);


--
-- Name: houses_id; Type: INDEX; Schema: public; Owner: user1
--

CREATE INDEX houses_id ON public.houses USING btree (id);


--
-- Name: people_id; Type: INDEX; Schema: public; Owner: user1
--

CREATE INDEX people_id ON public.people USING btree (id);


--
-- Name: settlements_find; Type: INDEX; Schema: public; Owner: user1
--

CREATE INDEX settlements_find ON public.settlements USING btree (name);


--
-- Name: settlements_id; Type: INDEX; Schema: public; Owner: user1
--

CREATE INDEX settlements_id ON public.settlements USING btree (id);


--
-- Name: streets_find; Type: INDEX; Schema: public; Owner: user1
--

CREATE INDEX streets_find ON public.streets USING btree (name);


--
-- Name: streets_id; Type: INDEX; Schema: public; Owner: user1
--

CREATE INDEX streets_id ON public.streets USING btree (id);


--
-- Name: ads ads_history_after_trigger; Type: TRIGGER; Schema: public; Owner: user1
--

CREATE TRIGGER ads_history_after_trigger AFTER INSERT OR UPDATE ON public.ads FOR EACH ROW EXECUTE FUNCTION public.ads_history_after();


--
-- Name: ads ads_history_before_trigger; Type: TRIGGER; Schema: public; Owner: user1
--

CREATE TRIGGER ads_history_before_trigger BEFORE DELETE ON public.ads FOR EACH ROW EXECUTE FUNCTION public.ads_history_before();


--
-- Name: ads ads_house_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_house_id_fkey FOREIGN KEY (house_id) REFERENCES public.houses(id) ON DELETE SET NULL NOT VALID;


--
-- Name: ads ads_people_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_people_id_fkey FOREIGN KEY (people_id) REFERENCES public.people(id) ON DELETE CASCADE NOT VALID;


--
-- Name: ads ads_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_settlement_id_fkey FOREIGN KEY (settlement_id) REFERENCES public.settlements(id) ON DELETE SET NULL NOT VALID;


--
-- Name: houses houses_street_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.streets(id) ON DELETE CASCADE;


--
-- Name: streets streets_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user1
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_settlement_id_fkey FOREIGN KEY (settlement_id) REFERENCES public.settlements(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

