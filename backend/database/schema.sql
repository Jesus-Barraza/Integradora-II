--
-- PostgreSQL database dump
--

\restrict 9rJgRwVuxvNldQzfreOCyhXrJJVDsxG5SVnPhVP7OxabSyBzaqxoy1BcYkmD8Pe

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: alumno(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.alumno(v_id integer) RETURNS TABLE(id integer, correo character varying, contrasena character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT alumnos.id_alumno, alumnos.correo, alumnos.contrasena
    FROM alumnos WHERE alumnos.id_alumno = v_id;
END;
$$;


ALTER FUNCTION public.alumno(v_id integer) OWNER TO postgres;

--
-- Name: delete_acc(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.delete_acc(IN v_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM alumnos
    WHERE alumnos.id_alumno = v_id;
END;
$$;


ALTER PROCEDURE public.delete_acc(IN v_id integer) OWNER TO postgres;

--
-- Name: general_insert(integer, character varying, character varying, integer, boolean, boolean, boolean, boolean, boolean, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.general_insert(v_edad integer, v_sexo character varying, v_carrera character varying, v_cuatrimestre integer, v_burnout_previo boolean, v_actividad_f boolean, v_tratamiento_psiquia boolean, v_tratamiento_psico boolean, v_trabajo boolean, v_id_alumno integer) RETURNS TABLE(edad integer, sexo character varying, carrera character varying, cuatrimestre integer, burnout_previo boolean, actividad_f boolean, tratamiento_psiquia boolean, tratamiento_psico boolean, trabajo boolean, id_alumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    INSERT INTO encuesta_general (edad, sexo, carrera, cuatrimestre, burnout_previo, actividad_f, tratamiento_psiquia, tratamiento_psico, trabajo, id_alumno)
    VALUES (v_edad, v_sexo, v_carrera, v_cuatrimestre, v_burnout_previo, v_actividad_f, v_tratamiento_psiquia, v_tratamiento_psico, v_trabajo, v_id_alumno )
    RETURNING encuesta_general.edad, encuesta_general.sexo, encuesta_general.carrera, encuesta_general.cuatrimestre, encuesta_general.burnout_previo, encuesta_general.actividad_f, encuesta_general.tratamiento_psiquia, encuesta_general.tratamiento_psico, encuesta_general.trabajo, encuesta_general.id_alumno;
END;
$$;


ALTER FUNCTION public.general_insert(v_edad integer, v_sexo character varying, v_carrera character varying, v_cuatrimestre integer, v_burnout_previo boolean, v_actividad_f boolean, v_tratamiento_psiquia boolean, v_tratamiento_psico boolean, v_trabajo boolean, v_id_alumno integer) OWNER TO postgres;

--
-- Name: login_cred(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.login_cred(v_correo character varying) RETURNS TABLE(id_alumno integer, nombre character varying, apellidos character varying, correo character varying, contrasena character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT alumnos.id_alumno, alumnos.nombre, alumnos.apellidos, alumnos.correo, alumnos.contrasena
    FROM alumnos WHERE alumnos.correo = v_correo;
END;
$$;


ALTER FUNCTION public.login_cred(v_correo character varying) OWNER TO postgres;

--
-- Name: pass_change(integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.pass_change(IN v_id integer, IN v_contrasena character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE alumnos SET contrasena = v_contrasena
    WHERE id_alumno = v_id;
END;
$$;


ALTER PROCEDURE public.pass_change(IN v_id integer, IN v_contrasena character varying) OWNER TO postgres;

--
-- Name: register(character varying, character varying, character varying, character varying, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.register(v_nombre character varying, v_apellidos character varying, v_correo character varying, v_contrasena character varying, v_fecha date) RETURNS TABLE(id_alumno integer, nombre character varying, apellidos character varying, correo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    INSERT INTO alumnos(nombre, apellidos, correo, contrasena, fecha)
    VALUES (v_nombre, v_apellidos, v_correo, v_contrasena, v_fecha)
    RETURNING alumnos.id_alumno, alumnos.nombre, alumnos.apellidos, alumnos.correo;
END;
$$;


ALTER FUNCTION public.register(v_nombre character varying, v_apellidos character varying, v_correo character varying, v_contrasena character varying, v_fecha date) OWNER TO postgres;

--
-- Name: register_insert(date, real, integer, integer, integer, real, integer, boolean, character varying, real, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.register_insert(IN v_fecha date, IN v_h_sueno real, IN v_cal_sueno integer, IN v_n_comidas integer, IN v_cal_consumo integer, IN v_h_osio real, IN v_cal_consumo_tec integer, IN v_uso_ia boolean, IN v_aplicacion character varying, IN v_pregunta_objetivo real, IN v_id_alumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO registro_diario (fecha, h_sueno, cal_sueno, n_comidas, cal_consumo, h_osio, cal_consumo_tec, uso_ia, aplicacion, pregunta_objetivo, id_alumno)
    VALUES (v_fecha, v_h_sueno, v_cal_sueno, v_n_comidas, v_cal_consumo, v_h_osio, v_cal_consumo_tec, v_uso_ia, v_aplicacion, v_pregunta_objetivo, v_id_alumno);
END;
$$;


ALTER PROCEDURE public.register_insert(IN v_fecha date, IN v_h_sueno real, IN v_cal_sueno integer, IN v_n_comidas integer, IN v_cal_consumo integer, IN v_h_osio real, IN v_cal_consumo_tec integer, IN v_uso_ia boolean, IN v_aplicacion character varying, IN v_pregunta_objetivo real, IN v_id_alumno integer) OWNER TO postgres;

--
-- Name: registro_vista(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.registro_vista(v_id integer) RETURNS TABLE(id_general integer, edad integer, sexo character varying, carrera character varying, cuatrimestre integer, burnout_previo boolean, actividad_f boolean, tratamiento_psiquia boolean, tratamiento_psico boolean, trabajo boolean, id_alumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT encuesta_general.id_general, encuesta_general.edad, encuesta_general.sexo, encuesta_general.carrera, encuesta_general.cuatrimestre, encuesta_general.burnout_previo, encuesta_general.actividad_f, encuesta_general.tratamiento_psiquia, encuesta_general.tratamiento_psico, encuesta_general.trabajo, encuesta_general.id_alumno
    FROM encuesta_general WHERE encuesta_general.id_alumno = v_id;
END;
$$;


ALTER FUNCTION public.registro_vista(v_id integer) OWNER TO postgres;

--
-- Name: registros_spec(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.registros_spec(v_id integer) RETURNS TABLE(id_registro integer, fecha date, h_sueno real, cal_sueno integer, n_comidas integer, cal_consumo integer, h_osio real, cal_consumo_tec integer, uso_ia boolean, aplicacion character varying, pregunta_objetivo real, id_alumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT registro_diario.id_registro, registro_diario.fecha, registro_diario.h_sueno, registro_diario.cal_sueno, registro_diario.n_comidas, registro_diario.cal_consumo, registro_diario.h_osio, registro_diario.cal_consumo_tec, registro_diario.uso_ia, registro_diario.aplicacion, registro_diario.pregunta_objetivo, registro_diario.id_alumno
    FROM registro_diario WHERE registro_diario.id_alumno = v_id;
END;
$$;


ALTER FUNCTION public.registros_spec(v_id integer) OWNER TO postgres;

--
-- Name: registros_vista(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.registros_vista() RETURNS TABLE(id_registro integer, fecha date, h_sueno real, cal_sueno integer, n_comidas integer, cal_consumo integer, h_osio real, cal_consumo_tec integer, uso_ia boolean, aplicacion character varying, pregunta_objetivo real, id_alumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT registro_diario.id_registro, registro_diario.fecha, registro_diario.h_sueno, registro_diario.cal_sueno, registro_diario.n_comidas, registro_diario.cal_consumo, registro_diario.h_osio, registro_diario.cal_consumo_tec, registro_diario.uso_ia, registro_diario.aplicacion, registro_diario.pregunta_objetivo, registro_diario.id_alumno
    FROM registro_diario;
END;
$$;


ALTER FUNCTION public.registros_vista() OWNER TO postgres;

--
-- Name: verified(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.verified(v_id integer) RETURNS TABLE(id_registro integer, fecha date, h_sueno real, cal_sueno integer, n_comidas integer, cal_consumo integer, h_osio real, cal_consumo_tec integer, uso_ia boolean, aplicacion character varying, pregunta_objetivo real, id_alumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT registro_diario.id_registro, registro_diario.fecha, registro_diario.h_sueno, registro_diario.cal_sueno, registro_diario.n_comidas, registro_diario.cal_consumo, registro_diario.h_osio, registro_diario.cal_consumo_tec, registro_diario.uso_ia, registro_diario.aplicacion, registro_diario.pregunta_objetivo, registro_diario.id_alumno
    FROM registro_diario WHERE registro_diario.id_alumno = v_id AND registro_diario.fecha = CURRENT_DATE;
END;
$$;


ALTER FUNCTION public.verified(v_id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alumnos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumnos (
    id_alumno integer NOT NULL,
    nombre character varying(20) NOT NULL,
    apellidos character varying(40) NOT NULL,
    correo character varying(50) NOT NULL,
    contrasena character varying(255) CONSTRAINT alumnos_contrsaena_not_null NOT NULL,
    fecha date NOT NULL
);


ALTER TABLE public.alumnos OWNER TO postgres;

--
-- Name: alumnos_id_alumno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alumnos_id_alumno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alumnos_id_alumno_seq OWNER TO postgres;

--
-- Name: alumnos_id_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alumnos_id_alumno_seq OWNED BY public.alumnos.id_alumno;


--
-- Name: encuesta_general; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encuesta_general (
    id_general integer NOT NULL,
    edad integer NOT NULL,
    sexo character varying(25) NOT NULL,
    carrera character varying(100) NOT NULL,
    cuatrimestre integer NOT NULL,
    burnout_previo boolean NOT NULL,
    actividad_f boolean NOT NULL,
    tratamiento_psiquia boolean NOT NULL,
    tratamiento_psico boolean NOT NULL,
    trabajo boolean NOT NULL,
    id_alumno integer NOT NULL
);


ALTER TABLE public.encuesta_general OWNER TO postgres;

--
-- Name: encuesta_general_id_general_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.encuesta_general_id_general_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.encuesta_general_id_general_seq OWNER TO postgres;

--
-- Name: encuesta_general_id_general_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.encuesta_general_id_general_seq OWNED BY public.encuesta_general.id_general;


--
-- Name: predicciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.predicciones (
    id_prediccion integer NOT NULL,
    id_alumno integer
);


ALTER TABLE public.predicciones OWNER TO postgres;

--
-- Name: predicciones_id_prediccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.predicciones_id_prediccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.predicciones_id_prediccion_seq OWNER TO postgres;

--
-- Name: predicciones_id_prediccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.predicciones_id_prediccion_seq OWNED BY public.predicciones.id_prediccion;


--
-- Name: registro_diario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registro_diario (
    id_registro integer NOT NULL,
    fecha date NOT NULL,
    h_sueno real NOT NULL,
    cal_sueno integer NOT NULL,
    n_comidas integer NOT NULL,
    cal_consumo integer NOT NULL,
    h_osio real NOT NULL,
    cal_consumo_tec integer NOT NULL,
    uso_ia boolean NOT NULL,
    aplicacion character varying(20),
    pregunta_objetivo real NOT NULL,
    id_alumno integer
);


ALTER TABLE public.registro_diario OWNER TO postgres;

--
-- Name: registro_diario_id_registro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_diario_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.registro_diario_id_registro_seq OWNER TO postgres;

--
-- Name: registro_diario_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_diario_id_registro_seq OWNED BY public.registro_diario.id_registro;


--
-- Name: alumnos id_alumno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumnos ALTER COLUMN id_alumno SET DEFAULT nextval('public.alumnos_id_alumno_seq'::regclass);


--
-- Name: encuesta_general id_general; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta_general ALTER COLUMN id_general SET DEFAULT nextval('public.encuesta_general_id_general_seq'::regclass);


--
-- Name: predicciones id_prediccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predicciones ALTER COLUMN id_prediccion SET DEFAULT nextval('public.predicciones_id_prediccion_seq'::regclass);


--
-- Name: registro_diario id_registro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_diario ALTER COLUMN id_registro SET DEFAULT nextval('public.registro_diario_id_registro_seq'::regclass);


--
-- Data for Name: alumnos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alumnos (id_alumno, nombre, apellidos, correo, contrasena, fecha) FROM stdin;
2	hssss	leyva	qwe@gmail.com	$2b$10$GMUa2BkrfwPIa.gjwyYzw.1/WqoOB7Miie34fcaYKcVL5igLXSCvi	2026-07-03
1	Jesus	Barraza	jesus_3141240166@utd.edu.mx	Verde_08635023	2026-07-03
\.


--
-- Data for Name: encuesta_general; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encuesta_general (id_general, edad, sexo, carrera, cuatrimestre, burnout_previo, actividad_f, tratamiento_psiquia, tratamiento_psico, trabajo, id_alumno) FROM stdin;
1	20	Masculino	TI	6	t	t	t	t	t	1
2	20	Masculino	TI	6	f	t	f	t	t	2
\.


--
-- Data for Name: predicciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.predicciones (id_prediccion, id_alumno) FROM stdin;
\.


--
-- Data for Name: registro_diario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registro_diario (id_registro, fecha, h_sueno, cal_sueno, n_comidas, cal_consumo, h_osio, cal_consumo_tec, uso_ia, aplicacion, pregunta_objetivo, id_alumno) FROM stdin;
1	2026-07-03	2	6	4	6	0	0	f		6	1
2	2026-07-03	2	6	4	6	0	0	f		6	1
3	2026-07-04	4	6	4	6	0	0	f		6	1
\.


--
-- Name: alumnos_id_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alumnos_id_alumno_seq', 2, true);


--
-- Name: encuesta_general_id_general_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.encuesta_general_id_general_seq', 2, true);


--
-- Name: predicciones_id_prediccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.predicciones_id_prediccion_seq', 1, false);


--
-- Name: registro_diario_id_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_diario_id_registro_seq', 3, true);


--
-- Name: alumnos alumnos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumnos
    ADD CONSTRAINT alumnos_pkey PRIMARY KEY (id_alumno);


--
-- Name: encuesta_general encuesta_general_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta_general
    ADD CONSTRAINT encuesta_general_pkey PRIMARY KEY (id_general);


--
-- Name: predicciones predicciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predicciones
    ADD CONSTRAINT predicciones_pkey PRIMARY KEY (id_prediccion);


--
-- Name: registro_diario registro_diario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_diario
    ADD CONSTRAINT registro_diario_pkey PRIMARY KEY (id_registro);


--
-- Name: alumnos uc_correo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumnos
    ADD CONSTRAINT uc_correo UNIQUE (correo);


--
-- Name: encuesta_general encuesta_general_id_alumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta_general
    ADD CONSTRAINT encuesta_general_id_alumno_fkey FOREIGN KEY (id_alumno) REFERENCES public.alumnos(id_alumno);


--
-- Name: predicciones predicciones_id_alumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predicciones
    ADD CONSTRAINT predicciones_id_alumno_fkey FOREIGN KEY (id_alumno) REFERENCES public.alumnos(id_alumno);


--
-- Name: registro_diario registro_diario_id_alumno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_diario
    ADD CONSTRAINT registro_diario_id_alumno_fkey FOREIGN KEY (id_alumno) REFERENCES public.alumnos(id_alumno);


--
-- PostgreSQL database dump complete
--

\unrestrict 9rJgRwVuxvNldQzfreOCyhXrJJVDsxG5SVnPhVP7OxabSyBzaqxoy1BcYkmD8Pe

