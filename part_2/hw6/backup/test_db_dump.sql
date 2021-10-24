--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8 (Debian 12.8-1.pgdg110+1)
-- Dumped by pg_dump version 12.8 (Debian 12.8-1.pgdg110+1)

-- Started on 2021-10-24 19:11:02 UTC

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
-- TOC entry 2973 (class 1262 OID 16384)
-- Name: test-db; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "test-db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


\connect -reuse-previous=on "dbname='test-db'"

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 205 (class 1259 OID 16395)
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    second_name character varying(50),
    country character varying(100),
    order_id integer
);


--
-- TOC entry 204 (class 1259 OID 16393)
-- Name: clients_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clients_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 202 (class 1259 OID 16386)
-- Name: order_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 203 (class 1259 OID 16388)
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    name character varying(100),
    price integer
);


--
-- TOC entry 2967 (class 0 OID 16395)
-- Dependencies: 205
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.clients (id, second_name, country, order_id) FROM stdin;
10	Ritchie Blackmore	Russia	\N
9	Ронни Джеймс Дио	Russia	\N
6	Иванов Иван Иванович	USA	3
7	Петров Петр Петрович	Canada	4
8	Иоганн Себастьян Бах	Japan	5
\.


--
-- TOC entry 2965 (class 0 OID 16388)
-- Dependencies: 203
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, name, price) FROM stdin;
5	Гитара	4000
4	Монитор	7000
2	Принтер	3000
3	Книга	500
1	Шоколад	10
\.


--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 204
-- Name: clients_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.clients_seq', 10, true);


--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 202
-- Name: order_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_seq', 5, true);


--
-- TOC entry 2836 (class 2606 OID 16399)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- TOC entry 2834 (class 2606 OID 16392)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 2837 (class 2606 OID 16400)
-- Name: clients clients_order_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_order_fk FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 2973
-- Name: DATABASE "test-db"; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON DATABASE "test-db" TO "test-admin-user";


-- Completed on 2021-10-24 19:11:03 UTC

--
-- PostgreSQL database dump complete
--

