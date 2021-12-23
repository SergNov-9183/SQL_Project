--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2021-12-23 09:07:51

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

DROP DATABASE test1;
--
-- TOC entry 3416 (class 1262 OID 42346)
-- Name: test1; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE test1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


\connect test1

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
-- TOC entry 221 (class 1255 OID 42347)
-- Name: add_user(integer, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_user(id integer, surname text, name text, patronymic text, phone text, email text, password text) RETURNS void
    LANGUAGE sql
    AS $$ insert into people (id, surname, name, patronymic, phone, email, password) values (add_user.id, add_user.surname, add_user.name, add_user.patronymic, add_user.phone, add_user.email, add_user.password) $$;


--
-- TOC entry 223 (class 1255 OID 42348)
-- Name: ads_history_after(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ads_history_after() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ begin   if (new.type = 0 or new.type = 2) then     insert into ads_history     select new.id, TG_OP, P.surname, P.name, P.patronymic, P.phone, new.type, new.publication_or_update_time, H.settlements_name, H.street_name, H.number, H.housing_number, new.price       from get_house_info(new.house_id) H     left join people P on P.id=new.people_id;   else     insert into ads_history     select new.id, TG_OP, P.surname, P.name, P.patronymic, P.phone, new.type, new.publication_or_update_time, L.name, null, null, null, new.price     from get_settlement_info(new.settlement_id) L     left join people P on P.id=new.people_id;   end if;   return new; end; $$;


--
-- TOC entry 224 (class 1255 OID 42349)
-- Name: ads_history_before(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ads_history_before() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ begin   if (old.type = 0 or old.type = 2) then     insert into ads_history     select old.id, TG_OP, P.surname, P.name, P.patronymic, P.phone, old.type, old.publication_or_update_time, H.settlements_name, H.street_name, H.number, H.housing_number, old.price      from get_house_info(old.house_id) H     left join people P on P.id=old.people_id;   else     insert into ads_history     select old.id, TG_OP, P.surname, P.name, P.patronymic, P.phone, old.type, old.publication_or_update_time, L.name, null, null, null, old.price      from get_settlement_info(old.settlement_id) L     left join people P on P.id=old.people_id;   end if;   return old; end; $$;


--
-- TOC entry 220 (class 1255 OID 42480)
-- Name: calculate_sq_m_price_ins(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.calculate_sq_m_price_ins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 	UPDATE ads SET price_per_sq_m = round((NEW.price / NEW.total_area)::numeric, 1)
 		WHERE id = NEW.id;
	RETURN NEW;
END;
$$;


--
-- TOC entry 222 (class 1255 OID 42481)
-- Name: calculate_sq_m_price_upd(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.calculate_sq_m_price_upd() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 	IF (NEW.id = OLD.id) THEN
		NEW.price_per_sq_m = round((NEW.price / NEW.total_area)::numeric, 1);
 	END IF;
	RETURN NEW;
END;
$$;


--
-- TOC entry 228 (class 1255 OID 42350)
-- Name: get_house_info(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_house_info(id integer) RETURNS TABLE(type integer, number text, housing_number text, land_area integer, street_name text, settlements_name text, settlements_type integer)
    LANGUAGE sql
    AS $$ select H.type, H.number, H.housing_number, H.land_area,         S.name as street_name, L.name as settlements_name, L.type as settlements_type  from houses H  left join streets S on S.id=H.street_id  left join settlements L on L.id=S.settlement_id  where H.id=get_house_info.id $$;


--
-- TOC entry 229 (class 1255 OID 42351)
-- Name: get_settlement_info(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_settlement_info(id integer) RETURNS TABLE(id integer, type integer, name text)
    LANGUAGE sql
    AS $$ select id, type, name from settlements where id=get_settlement_info.id $$;


--
-- TOC entry 230 (class 1255 OID 42352)
-- Name: get_user(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_user(phone text) RETURNS TABLE(id integer, surname text, name text, patronymic text, phone text, email text, password text)
    LANGUAGE sql
    AS $$select * from people where phone=get_user.phone$$;


--
-- TOC entry 239 (class 1255 OID 42353)
-- Name: insert_ads(integer, integer, integer, integer, integer, integer, double precision, double precision, double precision, boolean, boolean, boolean, integer, text, integer, text, text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_ads(id integer, people_id integer, house_id integer, settlement_id integer, type integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price integer, publication_or_update_time text, addition_information text, settlement_house_type integer) RETURNS void
    LANGUAGE sql
    AS $$ insert into ads (id, people_id, house_id, settlement_id, type, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas,                   sewerage, bathroom_type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type)          values (insert_ads.id, insert_ads.people_id, case when insert_ads.house_id < 1 then null else insert_ads.house_id end,                  case when insert_ads.settlement_id < 1 then null else insert_ads.settlement_id end, insert_ads.type, insert_ads.rooms_count,                  insert_ads.total_area, insert_ads.living_area, insert_ads.kitchen_area, insert_ads.water_pipes, insert_ads.gas, insert_ads.sewerage,                  insert_ads.bathroom_type, insert_ads.ads_text, insert_ads.price, insert_ads.publication_or_update_time, insert_ads.addition_information,                  insert_ads.settlement_house_type) $$;


--
-- TOC entry 240 (class 1255 OID 42354)
-- Name: insert_houses(integer, integer, integer, text, text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_houses(id integer, street_id integer, type integer, number text, housing_number text, land_area integer) RETURNS void
    LANGUAGE sql
    AS $$ insert into houses (id, street_id, type, number, housing_number, land_area) values (insert_houses.id, insert_houses.street_id, insert_houses.type, insert_houses.number, insert_houses.housing_number, insert_houses.land_area) $$;


--
-- TOC entry 241 (class 1255 OID 42355)
-- Name: insert_settlements(integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_settlements(id integer, type integer, name text) RETURNS void
    LANGUAGE sql
    AS $$ insert into settlements (id, type, name) values (insert_settlements.id, insert_settlements.type, insert_settlements.name) $$;


--
-- TOC entry 242 (class 1255 OID 42356)
-- Name: insert_streets(integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_streets(id integer, settlement_id integer, name text) RETURNS void
    LANGUAGE sql
    AS $$ insert into streets (id, settlement_id, name) values (insert_streets.id, insert_streets.settlement_id, insert_streets.name) $$;


--
-- TOC entry 243 (class 1255 OID 42357)
-- Name: min_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.min_user() RETURNS TABLE(adminid integer)
    LANGUAGE sql
    AS $$ select min(id) as adminId from people $$;


--
-- TOC entry 244 (class 1255 OID 42358)
-- Name: remove_ads(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.remove_ads(id integer) RETURNS void
    LANGUAGE sql
    AS $$ delete from ads where id=remove_ads.id $$;


--
-- TOC entry 245 (class 1255 OID 42359)
-- Name: remove_houses(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.remove_houses(id integer) RETURNS void
    LANGUAGE sql
    AS $$ delete from houses where id=remove_houses.id $$;


--
-- TOC entry 246 (class 1255 OID 42360)
-- Name: remove_settlements(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.remove_settlements(id integer) RETURNS void
    LANGUAGE sql
    AS $$ delete from settlements where id=remove_settlements.id $$;


--
-- TOC entry 247 (class 1255 OID 42361)
-- Name: remove_streets(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.remove_streets(id integer) RETURNS void
    LANGUAGE sql
    AS $$ delete from streets where id=remove_streets.id $$;


--
-- TOC entry 248 (class 1255 OID 42362)
-- Name: select_ads(text, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_ads(name_filter text, type integer, user_id integer) RETURNS TABLE(id integer, people_id integer, house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, type integer, ads_text text, price double precision, publication_or_update_time text, addition_information text, settlement_house_type integer, price_per_sq_m double precision, user_name text, phone text, email text, house_type integer, number text, housing_number text, land_area integer, settlements_type_buy integer, settlements_name_buy text, streets_name text, settlements_type integer, settlements_name text)
    LANGUAGE sql
    AS $$ select A.*,     B.name as user_name, B.phone, B.email,     C.type as house_type, C.number, C.housing_number, C.land_area,     D.type as settlements_type_buy, D.name as settlements_name_buy,     E.name as streets_name,     F.type as settlements_type, F.name as settlements_name from ads A left join people B on B.id=A.people_id left join houses C on C.id=A.house_id left join settlements D on D.id=A.settlement_id left join streets E on E.id=C.street_id left join settlements F on F.id=E.settlement_id where (F.name like select_ads.name_filter || '%' or D.name like select_ads.name_filter || '%') and A.type=select_ads.type and (select_ads.user_id<1 or select_ads.user_id=A.people_id or select_ads.user_id=(select min(id) as adminId from people)) order by F.name, D.name $$;


--
-- TOC entry 249 (class 1255 OID 42363)
-- Name: select_houses(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_houses(name_filter text, street_id integer) RETURNS TABLE(id integer, street_id integer, type integer, number text, housing_number text, land_area integer)
    LANGUAGE sql
    AS $$ select id, street_id, type, number, housing_number, land_area  from houses  where number like select_houses.name_filter and street_id=select_houses.street_id order by number $$;


--
-- TOC entry 250 (class 1255 OID 42364)
-- Name: select_settlements(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_settlements(name_filter text) RETURNS TABLE(id integer, type integer, name text)
    LANGUAGE sql
    AS $$ select id, type, name  from settlements  where name like select_settlements.name_filter order by name $$;


--
-- TOC entry 251 (class 1255 OID 42365)
-- Name: select_streets(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.select_streets(name_filter text, settlement_id integer) RETURNS TABLE(id integer, settlement_id integer, name text)
    LANGUAGE sql
    AS $$ select id, settlement_id, name  from streets  where name like  select_streets.name_filter and settlement_id=select_streets.settlement_id order by name $$;


--
-- TOC entry 252 (class 1255 OID 42366)
-- Name: update_ads(integer, integer, integer, double precision, double precision, double precision, boolean, boolean, boolean, integer, text, integer, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_ads(house_id integer, settlement_id integer, rooms_count integer, total_area double precision, living_area double precision, kitchen_area double precision, water_pipes boolean, gas boolean, sewerage boolean, bathroom_type integer, ads_text text, price integer, publication_or_update_time text, addition_information text, settlement_house_type integer, id integer) RETURNS void
    LANGUAGE sql
    AS $$ update ads set house_id=case when update_ads.house_id < 1 then null else update_ads.house_id end,                 settlement_id=case when update_ads.settlement_id < 1 then null else update_ads.settlement_id end,                 rooms_count=update_ads.rooms_count,                 total_area=update_ads.total_area,                 living_area=update_ads.living_area,                 kitchen_area=update_ads.kitchen_area,                 water_pipes=update_ads.water_pipes,                 gas=update_ads.gas,                 sewerage=update_ads.sewerage,                 bathroom_type=update_ads.bathroom_type,                 ads_text=update_ads.ads_text,                 price=update_ads.price,                 publication_or_update_time=update_ads.publication_or_update_time,                 addition_information=update_ads.addition_information,                 settlement_house_type=update_ads.settlement_house_type  where id=id $$;


--
-- TOC entry 253 (class 1255 OID 42367)
-- Name: update_houses(integer, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_houses(type integer, number text, housing_number text, land_area integer, id integer) RETURNS void
    LANGUAGE sql
    AS $$ update houses set type=update_houses.type, number=update_houses.number, housing_number=update_houses.housing_number, land_area=update_houses.land_area where id=update_houses.id $$;


--
-- TOC entry 254 (class 1255 OID 42368)
-- Name: update_settlements(integer, text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_settlements(type integer, name text, id integer) RETURNS void
    LANGUAGE sql
    AS $$ update settlements set type=update_settlements.type, name=update_settlements.name where id=update_settlements.id $$;


--
-- TOC entry 255 (class 1255 OID 42369)
-- Name: update_streets(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_streets(name text, id integer) RETURNS void
    LANGUAGE sql
    AS $$ update streets set name=update_streets.name where id=update_streets.id $$;


SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 42370)
-- Name: ads; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 210 (class 1259 OID 42387)
-- Name: ads_history; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 211 (class 1259 OID 42392)
-- Name: ads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 211
-- Name: ads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ads_id_seq OWNED BY public.ads.id;


--
-- TOC entry 212 (class 1259 OID 42393)
-- Name: houses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.houses (
    id integer NOT NULL,
    street_id integer NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    number text DEFAULT 1 NOT NULL,
    housing_number text,
    land_area double precision DEFAULT 0 NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 42401)
-- Name: houses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.houses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 213
-- Name: houses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.houses_id_seq OWNED BY public.houses.id;


--
-- TOC entry 214 (class 1259 OID 42402)
-- Name: people; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 215 (class 1259 OID 42407)
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 215
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- TOC entry 216 (class 1259 OID 42408)
-- Name: settlements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settlements (
    id integer NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 42414)
-- Name: settlements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settlements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 217
-- Name: settlements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settlements_id_seq OWNED BY public.settlements.id;


--
-- TOC entry 218 (class 1259 OID 42415)
-- Name: streets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.streets (
    id integer NOT NULL,
    settlement_id integer NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 42420)
-- Name: streets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.streets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 219
-- Name: streets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.streets_id_seq OWNED BY public.streets.id;


--
-- TOC entry 3225 (class 2604 OID 42421)
-- Name: ads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads ALTER COLUMN id SET DEFAULT nextval('public.ads_id_seq'::regclass);


--
-- TOC entry 3229 (class 2604 OID 42422)
-- Name: houses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.houses ALTER COLUMN id SET DEFAULT nextval('public.houses_id_seq'::regclass);


--
-- TOC entry 3230 (class 2604 OID 42423)
-- Name: people id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- TOC entry 3232 (class 2604 OID 42424)
-- Name: settlements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlements ALTER COLUMN id SET DEFAULT nextval('public.settlements_id_seq'::regclass);


--
-- TOC entry 3233 (class 2604 OID 42425)
-- Name: streets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streets ALTER COLUMN id SET DEFAULT nextval('public.streets_id_seq'::regclass);


--
-- TOC entry 3400 (class 0 OID 42370)
-- Dependencies: 209
-- Data for Name: ads; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) VALUES (20, 6, 29, NULL, 2, 46, 32, 9, true, false, false, 1, 2, 'Надёжный частный дом в Нижнем Новгороде. Удобный подъезд. Развитая инфраструктура. ', 4800000, '23 декабря 2021 г. - 8:11:59', '', 0, 104347.8);
INSERT INTO public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) VALUES (21, 6, 29, NULL, 2, 46, 32, 9, true, false, false, 1, 2, 'Надёжный частный дом в Нижнем Новгороде. Удобный подъезд. Развитая инфраструктура. ', 4800000, '23 декабря 2021 г. - 8:11:59', '', 0, 104347.8);
INSERT INTO public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) VALUES (22, 7, 29, NULL, 2, 46, 32, 9, true, false, false, 1, 0, 'Надёжный частный дом в Нижнем Новгороде. Удобный подъезд. Развитая инфраструктура. ', 4800000, '23 декабря 2021 г. - 8:11:59', '', 0, 104347.8);
INSERT INTO public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) VALUES (7, 3, 29, NULL, 2, 46, 32, 9, true, false, false, 1, 2, 'Надёжный частный дом в Нижнем Новгороде. Удобный подъезд. Развитая инфраструктура. ', 4800000, '23 декабря 2021 г. - 8:11:59', '', 0, 104347.8);
INSERT INTO public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) VALUES (8, 3, 29, NULL, 2, 46, 32, 9, true, false, false, 1, 2, 'Надёжный частный дом в Нижнем Новгороде. Удобный подъезд. Развитая инфраструктура. ', 4800000, '23 декабря 2021 г. - 8:11:59', '', 0, 104347.8);
INSERT INTO public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) VALUES (9, 3, 29, NULL, 2, 46, 32, 9, true, false, false, 1, 0, 'Надёжный частный дом в Нижнем Новгороде. Удобный подъезд. Развитая инфраструктура. ', 4800000, '23 декабря 2021 г. - 8:11:59', '', 0, 104347.8);
INSERT INTO public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) VALUES (18, 5, 29, NULL, 2, 46, 32, 9, true, false, false, 1, 2, 'Надёжный частный дом в Нижнем Новгороде. Удобный подъезд. Развитая инфраструктура. ', 4800000, '23 декабря 2021 г. - 8:11:59', '', 0, 104347.8);
INSERT INTO public.ads (id, people_id, house_id, settlement_id, rooms_count, total_area, living_area, kitchen_area, water_pipes, gas, sewerage, bathroom_type, type, ads_text, price, publication_or_update_time, addition_information, settlement_house_type, price_per_sq_m) VALUES (19, 6, 29, NULL, 2, 46, 32, 9, true, false, false, 1, 0, 'Надёжный частный дом в Нижнем Новгороде. Удобный подъезд. Развитая инфраструктура. ', 4800000, '23 декабря 2021 г. - 8:11:59', '', 0, 104347.8);


--
-- TOC entry 3401 (class 0 OID 42387)
-- Dependencies: 210
-- Data for Name: ads_history; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (2, 'INSERT', '', 'user1', '', 'user1', 0, '22 декабря 2021 г. - 21:31:38', 'Нижний Новгород', 'Генерала Ивлеева', '3', '', 3200000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (2, 'UPDATE', '', 'user1', '', 'user1', 0, '22 декабря 2021 г. - 21:32:32', 'Нижний Новгород', 'Генерала Ивлеева', '3', '', 3200000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (2, 'DELETE', '', 'user1', '', 'user1', 0, '22 декабря 2021 г. - 21:32:32', 'Нижний Новгород', 'Генерала Ивлеева', '3', '', 3200000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (3, 'INSERT', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:36:06', 'Нижний Новгород', 'Генерала Ивлеева', '3', '', 6000000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (3, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:37:26', 'Нижний Новгород', 'Генерала Ивлеева', '3', '', 6000000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (4, 'INSERT', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:39:48', 'Нижний Новгород', 'Гоголя', '45', '', 1500000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (5, 'INSERT', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:47:18', 'Нижний Новгород', 'Генерала Ивлеева', '5', '', 2356000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (3, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:47:58', 'Нижний Новгород', 'Генерала Ивлеева', '5', '', 2356000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (4, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:47:58', 'Нижний Новгород', 'Генерала Ивлеева', '5', '', 2356000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (5, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:47:58', 'Нижний Новгород', 'Генерала Ивлеева', '5', '', 2356000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (6, 'INSERT', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:54:57', 'Нижний Новгород', 'Генерала Ивлеева', '4', '', 1000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (3, 'DELETE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:47:58', 'Нижний Новгород', 'Генерала Ивлеева', '5', '', 2356000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (4, 'DELETE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:47:58', 'Нижний Новгород', 'Генерала Ивлеева', '5', '', 2356000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (5, 'DELETE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 21:47:58', 'Нижний Новгород', 'Генерала Ивлеева', '5', '', 2356000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (6, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 22:01:22', 'Нижний Новгород', 'Генерала Ивлеева', '4', '', 10500000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (6, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 22:01:46', 'Нижний Новгород', 'Генерала Ивлеева', '4', '', 10500000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (6, 'DELETE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '22 декабря 2021 г. - 22:01:46', 'Нижний Новгород', 'Генерала Ивлеева', '4', '', 10500000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (7, 'INSERT', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 2, '23 декабря 2021 г. - 0:23:09', 'Нижний Новгород', 'Политехническая', '10', '', 4000000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (7, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 2, '23 декабря 2021 г. - 0:23:09', 'Нижний Новгород', 'Политехническая', '10', '', 4000000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (7, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 2, '23 декабря 2021 г. - 0:27:11', 'Нижний Новгород', 'Политехническая', '10', '', 3500000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (8, 'INSERT', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 2, '23 декабря 2021 г. - 7:38:32', 'Нижний Новгород', 'Терешковой', '226', '3', 2750000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (8, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 2, '23 декабря 2021 г. - 7:38:32', 'Нижний Новгород', 'Терешковой', '226', '3', 2750000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (9, 'INSERT', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '23 декабря 2021 г. - 7:41:13', 'Нижний Новгород', 'Генкиной', '31А', '', 16450000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (9, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '23 декабря 2021 г. - 7:41:13', 'Нижний Новгород', 'Генкиной', '31А', '', 16450000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (18, 'INSERT', 'Лазков', 'Игорь', 'Иосифович', '+71511511552', 2, '23 декабря 2021 г. - 7:56:10', 'Нижний Новгород', 'Генкиной', '80', '', 3200000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (18, 'UPDATE', 'Лазков', 'Игорь', 'Иосифович', '+71511511552', 2, '23 декабря 2021 г. - 7:56:10', 'Нижний Новгород', 'Генкиной', '80', '', 3200000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (19, 'INSERT', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 0, '23 декабря 2021 г. - 8:02:12', 'Нижний Новгород', 'Деловая', '78', '3', 9580000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (19, 'UPDATE', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 0, '23 декабря 2021 г. - 8:02:12', 'Нижний Новгород', 'Деловая', '78', '3', 9580000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (20, 'INSERT', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 2, '23 декабря 2021 г. - 8:05:53', 'Нижний Новгород', 'Варварская', '12', '', 7200000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (20, 'UPDATE', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 2, '23 декабря 2021 г. - 8:05:53', 'Нижний Новгород', 'Варварская', '12', '', 7200000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (21, 'INSERT', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 2, '23 декабря 2021 г. - 8:07:44', 'Нижний Новгород', 'Генкиной', '59', '', 5700000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (21, 'UPDATE', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 2, '23 декабря 2021 г. - 8:07:44', 'Нижний Новгород', 'Генкиной', '59', '', 5700000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (22, 'INSERT', 'Калинин ', 'Владислав', 'Дмитриевич', '+78888888888', 0, '23 декабря 2021 г. - 8:11:39', 'Нижний Новгород', 'Политехническая', '10', '', 4600000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (22, 'UPDATE', 'Калинин ', 'Владислав', 'Дмитриевич', '+78888888888', 0, '23 декабря 2021 г. - 8:11:39', 'Нижний Новгород', 'Политехническая', '10', '', 4600000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (20, 'UPDATE', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 2, '23 декабря 2021 г. - 8:11:59', 'Нижний Новгород', 'Политехническая', '10', '', 4800000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (21, 'UPDATE', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 2, '23 декабря 2021 г. - 8:11:59', 'Нижний Новгород', 'Политехническая', '10', '', 4800000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (22, 'UPDATE', 'Калинин ', 'Владислав', 'Дмитриевич', '+78888888888', 0, '23 декабря 2021 г. - 8:11:59', 'Нижний Новгород', 'Политехническая', '10', '', 4800000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (7, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 2, '23 декабря 2021 г. - 8:11:59', 'Нижний Новгород', 'Политехническая', '10', '', 4800000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (8, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 2, '23 декабря 2021 г. - 8:11:59', 'Нижний Новгород', 'Политехническая', '10', '', 4800000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (9, 'UPDATE', 'Краеведов', 'Роман', 'Александрович', '+79200545698', 0, '23 декабря 2021 г. - 8:11:59', 'Нижний Новгород', 'Политехническая', '10', '', 4800000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (18, 'UPDATE', 'Лазков', 'Игорь', 'Иосифович', '+71511511552', 2, '23 декабря 2021 г. - 8:11:59', 'Нижний Новгород', 'Политехническая', '10', '', 4800000);
INSERT INTO public.ads_history (id, action, surname, name, patronymic, phone, ads_type, date_time, settlements_name, street_name, house_number, housing_number, price) VALUES (19, 'UPDATE', 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 0, '23 декабря 2021 г. - 8:11:59', 'Нижний Новгород', 'Политехническая', '10', '', 4800000);


--
-- TOC entry 3403 (class 0 OID 42393)
-- Dependencies: 212
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (1, 195, 0, '26', '', 800);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (2, 195, 1, '45', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (3, 218, 1, '78', '3', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (4, 217, 0, '1', '', 700);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (5, 217, 0, '2', '', 760);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (6, 217, 0, '3', '', 752);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (7, 217, 0, '4', '', 920);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (8, 217, 0, '5', '', 910);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (9, 213, 1, '29', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (12, 213, 1, '6', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (11, 213, 1, '12', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (10, 213, 1, '3', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (13, 191, 1, '37', '3', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (14, 191, 1, '31А', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (15, 191, 1, '80', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (16, 191, 1, '44', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (17, 191, 0, '22', '', 563);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (18, 191, 1, '57', '6', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (19, 191, 1, '59', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (20, 195, 0, '73', '', 964);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (21, 204, 1, '24', '', 0);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (22, 204, 0, '30', '', 780);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (23, 204, 0, '51', '', 481);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (24, 204, 0, '35А', '', 790);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (25, 219, 0, '57', '', 730);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (26, 219, 0, '62А', '', 810);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (27, 219, 0, '67', '', 530);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (28, 219, 0, '19', '', 965);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (29, 219, 0, '10', '', 520);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (30, 219, 0, '37', '', 610);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (31, 219, 0, '23', '', 640);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (32, 219, 0, '99', '', 735);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (33, 219, 0, '61А', '', 900);
INSERT INTO public.houses (id, street_id, type, number, housing_number, land_area) VALUES (34, 199, 1, '226', '3', 0);


--
-- TOC entry 3405 (class 0 OID 42402)
-- Dependencies: 214
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.people (id, surname, name, patronymic, phone, email, password) VALUES (1, '', 'user1', '', 'user1', '', '3E30343972');
INSERT INTO public.people (id, surname, name, patronymic, phone, email, password) VALUES (2, 'Присталов', 'Ярослав', 'Алексеевич', '+79456595448', 'yp@yandex.ru', '3A3434393728');
INSERT INTO public.people (id, surname, name, patronymic, phone, email, password) VALUES (3, 'Краеведов', 'Роман', 'Александрович', '+79200545698', 'roman.al@gmail.com', '3A3434393728');
INSERT INTO public.people (id, surname, name, patronymic, phone, email, password) VALUES (4, 'Ванятов', 'Станислав', 'Владимирович', '+71511511551', 'stan@stan.ru', '3837302530252A2D');
INSERT INTO public.people (id, surname, name, patronymic, phone, email, password) VALUES (5, 'Лазков', 'Игорь', 'Иосифович', '+71511511552', 'no@no.igor', '22243E39');
INSERT INTO public.people (id, surname, name, patronymic, phone, email, password) VALUES (6, 'Кунаев', 'Антон', 'Павлочич', '+78007456556', 'anton@gmail.com', '2A2D25242D');
INSERT INTO public.people (id, surname, name, patronymic, phone, email, password) VALUES (7, 'Калинин ', 'Владислав', 'Дмитриевич', '+78888888888', 'kalinin@yandex.ru', '20223D222D3825');


--
-- TOC entry 3407 (class 0 OID 42408)
-- Dependencies: 216
-- Data for Name: settlements; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.settlements (id, type, name) VALUES (2, 2, 'Заволжье');
INSERT INTO public.settlements (id, type, name) VALUES (3, 2, 'Балахна');
INSERT INTO public.settlements (id, type, name) VALUES (4, 2, 'Арзамас');
INSERT INTO public.settlements (id, type, name) VALUES (5, 2, 'Дзержинск');
INSERT INTO public.settlements (id, type, name) VALUES (7, 2, 'Бор');
INSERT INTO public.settlements (id, type, name) VALUES (8, 3, 'Афонино');
INSERT INTO public.settlements (id, type, name) VALUES (9, 1, 'Дальнее Константиново');
INSERT INTO public.settlements (id, type, name) VALUES (10, 1, 'Вад');
INSERT INTO public.settlements (id, type, name) VALUES (11, 1, 'Городец');
INSERT INTO public.settlements (id, type, name) VALUES (1, 0, 'Нижний Новгород');
INSERT INTO public.settlements (id, type, name) VALUES (12, 3, 'Шёлокша');
INSERT INTO public.settlements (id, type, name) VALUES (13, 4, 'Крутой Майдан');
INSERT INTO public.settlements (id, type, name) VALUES (6, 1, 'Кстово');
INSERT INTO public.settlements (id, type, name) VALUES (16, 1, 'Чкаловск');
INSERT INTO public.settlements (id, type, name) VALUES (17, 3, 'Катунки');
INSERT INTO public.settlements (id, type, name) VALUES (18, 5, 'Трофаново');
INSERT INTO public.settlements (id, type, name) VALUES (20, 1, 'Перевоз');
INSERT INTO public.settlements (id, type, name) VALUES (21, 5, 'Чувахлей');
INSERT INTO public.settlements (id, type, name) VALUES (22, 4, 'Кирилловка');
INSERT INTO public.settlements (id, type, name) VALUES (19, 4, 'Большие Бакалды');
INSERT INTO public.settlements (id, type, name) VALUES (15, 4, 'Пурех');


--
-- TOC entry 3409 (class 0 OID 42415)
-- Dependencies: 218
-- Data for Name: streets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.streets (id, settlement_id, name) VALUES (1, 4, 'Советская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (2, 4, 'Октябрьская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (3, 4, 'Коммунистов');
INSERT INTO public.streets (id, settlement_id, name) VALUES (4, 4, 'Пролетарская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (6, 4, 'Строительная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (7, 4, 'Солнечная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (8, 4, '50 лет ВЛКСМ');
INSERT INTO public.streets (id, settlement_id, name) VALUES (9, 4, 'Чкалова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (10, 4, 'Чехова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (11, 4, 'Короленко');
INSERT INTO public.streets (id, settlement_id, name) VALUES (12, 4, 'Победы');
INSERT INTO public.streets (id, settlement_id, name) VALUES (13, 4, 'Нижегородская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (14, 4, 'Локомотивная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (15, 8, 'Парковая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (16, 8, 'Магистральная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (17, 8, 'Центральная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (18, 8, 'Абрикосовая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (19, 8, 'Яблоневая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (20, 8, 'Серверная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (21, 8, 'Нижняя');
INSERT INTO public.streets (id, settlement_id, name) VALUES (22, 8, 'Горная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (23, 8, 'Лесная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (24, 3, 'Дзержинского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (25, 3, 'Строителей');
INSERT INTO public.streets (id, settlement_id, name) VALUES (26, 3, 'Энгельса');
INSERT INTO public.streets (id, settlement_id, name) VALUES (27, 3, 'Челюскинцев');
INSERT INTO public.streets (id, settlement_id, name) VALUES (28, 3, 'Пушкина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (29, 3, 'Главная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (30, 3, 'Некрасова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (31, 3, 'Ленина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (32, 3, 'Алексеевская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (33, 3, 'Сосновая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (34, 3, 'Свердлова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (35, 3, 'Заречная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (36, 3, 'Чапаева');
INSERT INTO public.streets (id, settlement_id, name) VALUES (37, 3, 'Юбилейная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (38, 3, 'Кирова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (39, 3, '1 мая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (40, 19, 'Первомайская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (41, 19, 'Калинина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (42, 19, 'Центральная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (43, 19, 'Садовая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (44, 19, 'Новая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (45, 7, 'Набережная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (46, 7, 'Интернациональная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (47, 7, 'Васильковая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (48, 7, 'Студеная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (49, 7, 'Первомайская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (50, 7, 'Кулибина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (51, 7, 'Куйбышева');
INSERT INTO public.streets (id, settlement_id, name) VALUES (52, 7, 'Мусоргского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (55, 7, 'Московцева');
INSERT INTO public.streets (id, settlement_id, name) VALUES (56, 7, 'Степана Разина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (57, 7, 'Чернышевского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (58, 7, 'Парижской Коммуны');
INSERT INTO public.streets (id, settlement_id, name) VALUES (59, 7, 'Степана Разина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (60, 7, 'Теплоходская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (61, 10, '1 Мая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (62, 10, 'Кирпичная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (63, 10, 'Молодежная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (64, 10, '40 лет Октября');
INSERT INTO public.streets (id, settlement_id, name) VALUES (65, 10, 'Привокзальная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (66, 10, '40 лет Победы');
INSERT INTO public.streets (id, settlement_id, name) VALUES (67, 10, 'Южная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (68, 10, 'Почтовая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (69, 10, 'Москвичева');
INSERT INTO public.streets (id, settlement_id, name) VALUES (70, 10, 'Привокзальная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (71, 10, 'Больничная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (72, 11, 'Березовая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (73, 11, 'Мебельная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (74, 11, 'Ростовская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (75, 11, 'Ворожейкина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (76, 11, 'Кооперативный съезд');
INSERT INTO public.streets (id, settlement_id, name) VALUES (77, 11, 'Суворова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (78, 11, 'Спартака');
INSERT INTO public.streets (id, settlement_id, name) VALUES (79, 11, 'Осоавиахимовский Съезд');
INSERT INTO public.streets (id, settlement_id, name) VALUES (80, 11, 'Малая Долинка');
INSERT INTO public.streets (id, settlement_id, name) VALUES (81, 11, 'Красногвардейская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (82, 11, 'Рождественская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (83, 9, 'Березовская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (84, 9, 'Ветеринарная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (85, 9, 'Спортивная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (86, 9, 'Студеная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (89, 9, 'Олимпийская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (90, 9, 'Автомобилистов');
INSERT INTO public.streets (id, settlement_id, name) VALUES (91, 9, '40 лет Победы');
INSERT INTO public.streets (id, settlement_id, name) VALUES (92, 9, 'Фильченкова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (93, 5, 'Автомобильная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (94, 5, '9 Января');
INSERT INTO public.streets (id, settlement_id, name) VALUES (95, 5, 'Кирова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (96, 5, 'Народная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (97, 5, 'Марковникова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (98, 5, 'Черняховского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (99, 5, 'Сухаренко');
INSERT INTO public.streets (id, settlement_id, name) VALUES (100, 5, 'Маяковского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (101, 5, 'Революции');
INSERT INTO public.streets (id, settlement_id, name) VALUES (102, 5, 'Водозаборная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (103, 5, 'Попова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (104, 5, 'Лермонтова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (105, 5, 'Индустриальная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (106, 2, 'Береговая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (107, 2, 'Генераторная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (108, 2, 'Железнодорожная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (109, 2, 'Трансформаторная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (110, 2, 'Строительная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (111, 2, 'Привокзальная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (112, 2, 'Лесозаводская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (114, 2, 'Комсомольская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (115, 2, 'Турбинная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (116, 2, 'Гидростроительная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (118, 2, 'Коллекторная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (119, 2, 'Луначарского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (120, 17, 'Кирова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (121, 17, 'Советская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (122, 17, 'Садовая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (123, 17, 'Набережная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (124, 22, 'Ленина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (125, 22, 'Полевая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (126, 22, 'Садовая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (127, 22, 'Заречная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (128, 22, '9 мая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (129, 22, 'Суханова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (130, 22, 'Молодёжная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (131, 13, 'Заовражная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (132, 13, 'Красная Горка');
INSERT INTO public.streets (id, settlement_id, name) VALUES (133, 13, 'Микрорайон');
INSERT INTO public.streets (id, settlement_id, name) VALUES (134, 13, 'Новая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (135, 13, 'Сельская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (136, 6, '40 лет Октября');
INSERT INTO public.streets (id, settlement_id, name) VALUES (137, 6, 'Магистральная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (138, 6, 'Медицинская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (139, 6, 'Комсомольская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (140, 6, 'Вишенская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (141, 6, 'Пионерская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (142, 6, 'Краснодонцев');
INSERT INTO public.streets (id, settlement_id, name) VALUES (143, 6, 'Мичурина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (144, 6, '8 Марта');
INSERT INTO public.streets (id, settlement_id, name) VALUES (145, 6, 'Сосновская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (146, 6, 'Западная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (147, 6, 'Столбищенская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (148, 6, 'Невзорова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (149, 6, 'Талалушкина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (150, 6, 'Коминтерна');
INSERT INTO public.streets (id, settlement_id, name) VALUES (151, 6, 'Октябрьская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (152, 6, 'Герцена');
INSERT INTO public.streets (id, settlement_id, name) VALUES (153, 20, 'Кирова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (154, 20, 'Советская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (155, 20, 'Горького');
INSERT INTO public.streets (id, settlement_id, name) VALUES (156, 20, 'Нагорная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (157, 20, 'Станционная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (158, 20, 'Победы');
INSERT INTO public.streets (id, settlement_id, name) VALUES (159, 20, 'Чкалова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (160, 20, 'Северная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (161, 20, 'Коммунальная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (162, 20, 'Молодёжная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (163, 20, 'Сельхозтехника');
INSERT INTO public.streets (id, settlement_id, name) VALUES (164, 20, 'Чугунова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (165, 20, 'Южная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (166, 15, 'Ленина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (167, 15, 'Полевая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (168, 15, 'Луговая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (169, 15, 'Северная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (170, 18, 'Главная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (171, 16, 'Пушкина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (172, 16, 'Матросова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (173, 16, 'Ломоносова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (174, 16, 'Суворова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (175, 16, 'Жуковского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (176, 16, 'Краснофлотская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (177, 16, 'Лесная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (178, 16, 'Белинского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (179, 16, 'Космонавтов');
INSERT INTO public.streets (id, settlement_id, name) VALUES (180, 16, 'Крупской');
INSERT INTO public.streets (id, settlement_id, name) VALUES (181, 16, 'Чкалова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (182, 16, 'Ленина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (183, 16, 'Кооперативная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (184, 16, 'Водопьянова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (185, 16, 'Куйбышева');
INSERT INTO public.streets (id, settlement_id, name) VALUES (186, 21, 'Главная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (187, 12, 'Центральная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (188, 12, 'Тепличная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (189, 12, 'Новая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (190, 12, 'Берёзовая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (191, 1, 'Генкиной');
INSERT INTO public.streets (id, settlement_id, name) VALUES (192, 1, 'Рождественская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (193, 1, 'Глеба Успенского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (194, 1, 'Надежды Сусловой');
INSERT INTO public.streets (id, settlement_id, name) VALUES (195, 1, 'Гоголя');
INSERT INTO public.streets (id, settlement_id, name) VALUES (196, 1, 'Минина');
INSERT INTO public.streets (id, settlement_id, name) VALUES (197, 1, 'Родионова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (198, 1, 'Баумана');
INSERT INTO public.streets (id, settlement_id, name) VALUES (199, 1, 'Терешковой');
INSERT INTO public.streets (id, settlement_id, name) VALUES (200, 1, 'Белинского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (201, 1, 'Ильинская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (202, 1, 'Снежная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (203, 1, 'Янки Купалы');
INSERT INTO public.streets (id, settlement_id, name) VALUES (204, 1, 'Салганская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (205, 1, 'Революционная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (206, 1, 'Чаадаева');
INSERT INTO public.streets (id, settlement_id, name) VALUES (207, 1, 'Пролетарская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (208, 1, 'Почаинская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (209, 1, 'Заломова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (210, 1, 'Звездинка');
INSERT INTO public.streets (id, settlement_id, name) VALUES (211, 1, 'Октябрьская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (212, 1, 'Пискунова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (213, 1, 'Варварская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (214, 1, 'Ульянова');
INSERT INTO public.streets (id, settlement_id, name) VALUES (215, 1, 'Ковалихинская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (216, 1, 'Бринского');
INSERT INTO public.streets (id, settlement_id, name) VALUES (217, 1, 'Генерала Ивлеева');
INSERT INTO public.streets (id, settlement_id, name) VALUES (218, 1, 'Деловая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (219, 1, 'Политехническая');
INSERT INTO public.streets (id, settlement_id, name) VALUES (220, 1, 'Львовская');
INSERT INTO public.streets (id, settlement_id, name) VALUES (221, 1, 'Школьная');
INSERT INTO public.streets (id, settlement_id, name) VALUES (222, 1, 'Ванеева');


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 211
-- Name: ads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ads_id_seq', 22, true);


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 213
-- Name: houses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.houses_id_seq', 34, true);


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 215
-- Name: people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.people_id_seq', 7, true);


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 217
-- Name: settlements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.settlements_id_seq', 22, true);


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 219
-- Name: streets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.streets_id_seq', 222, true);


--
-- TOC entry 3236 (class 2606 OID 42427)
-- Name: ads ads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 42429)
-- Name: houses houses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_pkey PRIMARY KEY (id);


--
-- TOC entry 3243 (class 2606 OID 42431)
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- TOC entry 3247 (class 2606 OID 42433)
-- Name: settlements settlements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settlements
    ADD CONSTRAINT settlements_pkey PRIMARY KEY (id);


--
-- TOC entry 3251 (class 2606 OID 42435)
-- Name: streets streets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 1259 OID 42436)
-- Name: ads_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ads_id ON public.ads USING btree (id);


--
-- TOC entry 3237 (class 1259 OID 42437)
-- Name: houses_find; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX houses_find ON public.houses USING btree (number);


--
-- TOC entry 3238 (class 1259 OID 42438)
-- Name: houses_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX houses_id ON public.houses USING btree (id);


--
-- TOC entry 3241 (class 1259 OID 42439)
-- Name: people_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_id ON public.people USING btree (id);


--
-- TOC entry 3244 (class 1259 OID 42440)
-- Name: settlements_find; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX settlements_find ON public.settlements USING btree (name);


--
-- TOC entry 3245 (class 1259 OID 42441)
-- Name: settlements_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX settlements_id ON public.settlements USING btree (id);


--
-- TOC entry 3248 (class 1259 OID 42442)
-- Name: streets_find; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX streets_find ON public.streets USING btree (name);


--
-- TOC entry 3249 (class 1259 OID 42443)
-- Name: streets_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX streets_id ON public.streets USING btree (id);


--
-- TOC entry 3260 (class 2620 OID 42444)
-- Name: ads ads_history_after_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ads_history_after_trigger AFTER INSERT OR UPDATE ON public.ads FOR EACH ROW EXECUTE FUNCTION public.ads_history_after();


--
-- TOC entry 3259 (class 2620 OID 42445)
-- Name: ads ads_history_before_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ads_history_before_trigger BEFORE DELETE ON public.ads FOR EACH ROW EXECUTE FUNCTION public.ads_history_before();


--
-- TOC entry 3258 (class 2620 OID 42482)
-- Name: ads tr_sq_m_price_ins; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_sq_m_price_ins AFTER INSERT ON public.ads FOR EACH ROW EXECUTE FUNCTION public.calculate_sq_m_price_ins();


--
-- TOC entry 3257 (class 2620 OID 42483)
-- Name: ads tr_sq_m_price_upd; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_sq_m_price_upd BEFORE UPDATE ON public.ads FOR EACH ROW EXECUTE FUNCTION public.calculate_sq_m_price_upd();


--
-- TOC entry 3252 (class 2606 OID 42446)
-- Name: ads ads_house_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_house_id_fkey FOREIGN KEY (house_id) REFERENCES public.houses(id) ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3253 (class 2606 OID 42451)
-- Name: ads ads_people_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_people_id_fkey FOREIGN KEY (people_id) REFERENCES public.people(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3254 (class 2606 OID 42456)
-- Name: ads ads_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_settlement_id_fkey FOREIGN KEY (settlement_id) REFERENCES public.settlements(id) ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3255 (class 2606 OID 42461)
-- Name: houses houses_street_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.streets(id) ON DELETE CASCADE;


--
-- TOC entry 3256 (class 2606 OID 42466)
-- Name: streets streets_settlement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_settlement_id_fkey FOREIGN KEY (settlement_id) REFERENCES public.settlements(id) ON DELETE CASCADE;


-- Completed on 2021-12-23 09:07:51

--
-- PostgreSQL database dump complete
--

