--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    has_earth boolean,
    galaxy_type character varying(100),
    age_in_millions_of_years integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    has_life boolean,
    has_water boolean,
    diameter numeric,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    has_life boolean,
    n_moon integer,
    mass numeric,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: probe; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.probe (
    probe_id integer NOT NULL,
    name character varying(100) NOT NULL,
    launch_date date,
    is_active boolean,
    mission_type text,
    planet_id integer NOT NULL
);


ALTER TABLE public.probe OWNER TO freecodecamp;

--
-- Name: probe_probe_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.probe_probe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.probe_probe_id_seq OWNER TO freecodecamp;

--
-- Name: probe_probe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.probe_probe_id_seq OWNED BY public.probe.probe_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(100) NOT NULL,
    n_planet integer,
    star_type character varying(100),
    age_in_millions_of_years integer,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: probe probe_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.probe ALTER COLUMN probe_id SET DEFAULT nextval('public.probe_probe_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', true, 'Barred Spiral', 13600);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', false, 'Spiral', 10000);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', false, 'Spiral', 12000);
INSERT INTO public.galaxy VALUES (4, 'Messier 87', false, 'Elliptical', 13000);
INSERT INTO public.galaxy VALUES (5, 'Whirlpool', false, 'Spiral', 400);
INSERT INTO public.galaxy VALUES (6, 'Sombrero', false, 'Unbarred Spiral', 10000);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', false, true, 3474.8, 3);
INSERT INTO public.moon VALUES (2, 'Phobos', false, false, 22.4, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', false, false, 12.4, 4);
INSERT INTO public.moon VALUES (4, 'Io', false, false, 3642.0, 5);
INSERT INTO public.moon VALUES (5, 'Europa', false, true, 3121.6, 5);
INSERT INTO public.moon VALUES (6, 'Ganymede', false, false, 5268.2, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', false, false, 4820.6, 5);
INSERT INTO public.moon VALUES (8, 'Titan', false, true, 5150.0, 6);
INSERT INTO public.moon VALUES (9, 'Enceladus', false, true, 504.2, 6);
INSERT INTO public.moon VALUES (10, 'Mimas', false, false, 396.4, 6);
INSERT INTO public.moon VALUES (11, 'Tethys', false, false, 1062.0, 6);
INSERT INTO public.moon VALUES (12, 'Dione', false, false, 1122.8, 6);
INSERT INTO public.moon VALUES (13, 'Rhea', false, false, 1527.6, 6);
INSERT INTO public.moon VALUES (14, 'Miranda', false, false, 471.6, 7);
INSERT INTO public.moon VALUES (15, 'Ariel', false, false, 1158.8, 7);
INSERT INTO public.moon VALUES (16, 'Umbriel', false, false, 1169.4, 7);
INSERT INTO public.moon VALUES (17, 'Titania', false, false, 1578.4, 7);
INSERT INTO public.moon VALUES (18, 'Oberon', false, false, 1522.4, 7);
INSERT INTO public.moon VALUES (19, 'Triton', false, false, 2706.8, 8);
INSERT INTO public.moon VALUES (20, 'Nereid', false, false, 340.0, 8);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 'Small rocky planet closest to the Sun', false, 0, 0.33, 1);
INSERT INTO public.planet VALUES (2, 'Venus', 'Earth''s “twin” with a thick CO₂ atmosphere', false, 0, 4.87, 1);
INSERT INTO public.planet VALUES (3, 'Earth', 'Our home planet with abundant life', true, 1, 5.97, 1);
INSERT INTO public.planet VALUES (4, 'Mars', 'Red planet with polar ice caps', false, 2, 0.642, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', 'Gas giant, largest planet in the Solar System', false, 79, 1898, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', 'Gas giant famous for its rings', false, 82, 568, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', 'Ice giant with extreme axial tilt', false, 27, 86.8, 1);
INSERT INTO public.planet VALUES (8, 'Neptune', 'Ice giant with strong winds', false, 14, 102, 1);
INSERT INTO public.planet VALUES (9, 'Proxima b', 'Terrestrial exoplanet in the habitable zone', false, 0, 1.27, 2);
INSERT INTO public.planet VALUES (10, 'Proxima c', 'Super-Earth or mini-Neptune candidate', false, 0, 7.00, 2);
INSERT INTO public.planet VALUES (11, 'Sirius b', 'Hypothetical gas giant orbiting Sirius A', false, 0, 318.0, 4);
INSERT INTO public.planet VALUES (12, 'Sirius c', 'Hypothetical ice giant beyond Sirius b', false, 0, 5.0, 4);


--
-- Data for Name: probe; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.probe VALUES (1, 'Voyager 1', '1977-09-05', true, 'Interstellar probe', 5);
INSERT INTO public.probe VALUES (2, 'Cassini-Huygens', '1997-10-15', false, 'Saturn system orbiter', 6);
INSERT INTO public.probe VALUES (3, 'New Horizons', '2006-01-19', true, 'Kuiper Belt flyby', 8);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 8, 'G-type main-sequence', 4600, 1);
INSERT INTO public.star VALUES (2, 'Proxima Centauri', 3, 'Red dwarf', 4850, 1);
INSERT INTO public.star VALUES (3, 'Betelguese', 0, 'Red supergiant', 8000, 1);
INSERT INTO public.star VALUES (4, 'Sirius', 2, 'A-type main-sequence', 240, 1);
INSERT INTO public.star VALUES (5, 'Vega', 0, 'A-type main-sequence', 455, 1);
INSERT INTO public.star VALUES (6, 'Alpha Centauri A', 0, 'G-type main-sequence', 6000, 1);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: probe_probe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.probe_probe_id_seq', 3, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: probe probe_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.probe
    ADD CONSTRAINT probe_name_key UNIQUE (name);


--
-- Name: probe probe_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.probe
    ADD CONSTRAINT probe_pkey PRIMARY KEY (probe_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: probe probe_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.probe
    ADD CONSTRAINT probe_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

