--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clicks; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE clicks (
    _id bigint NOT NULL,
    high_score double precision,
    date timestamp with time zone
);


ALTER TABLE clicks OWNER TO mircs;

--
-- Name: clicks__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE clicks__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clicks__id_seq OWNER TO mircs;

--
-- Name: clicks__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE clicks__id_seq OWNED BY clicks._id;


--
-- Name: cnn; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE cnn (
    _id bigint NOT NULL,
    sixteen_baseline_accuracy double precision,
    nineteen_baseline_accuracy double precision,
    sixteen_attention_accuracy double precision,
    nineteen_attention_accuracy double precision,
    epochs bigint,
    date character varying
);


ALTER TABLE cnn OWNER TO mircs;

--
-- Name: cnn__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE cnn__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cnn__id_seq OWNER TO mircs;

--
-- Name: cnn__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE cnn__id_seq OWNED BY cnn._id;


--
-- Name: image_count; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE image_count (
    _id bigint NOT NULL,
    num_images bigint,
    current_generation bigint,
    iteration_generation bigint,
    generations_per_epoch bigint
);


ALTER TABLE image_count OWNER TO mircs;

--
-- Name: image_count__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE image_count__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE image_count__id_seq OWNER TO mircs;

--
-- Name: image_count__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE image_count__id_seq OWNED BY image_count._id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE images (
    _id bigint NOT NULL,
    image_path character varying,
    syn_name character varying,
    click_path json,
    answers json,
    generations bigint
);


ALTER TABLE images OWNER TO mircs;

--
-- Name: images__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE images__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE images__id_seq OWNER TO mircs;

--
-- Name: images__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE images__id_seq OWNED BY images._id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE session OWNER TO mircs;

--
-- Name: users; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE users (
    _id bigint NOT NULL,
    cookie character varying,
    name character varying,
    score double precision,
    email character varying,
    last_click_time timestamp with time zone
);


ALTER TABLE users OWNER TO mircs;

--
-- Name: users__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE users__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users__id_seq OWNER TO mircs;

--
-- Name: users__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE users__id_seq OWNED BY users._id;


--
-- Name: _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY clicks ALTER COLUMN _id SET DEFAULT nextval('clicks__id_seq'::regclass);


--
-- Name: _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY cnn ALTER COLUMN _id SET DEFAULT nextval('cnn__id_seq'::regclass);


--
-- Name: _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY image_count ALTER COLUMN _id SET DEFAULT nextval('image_count__id_seq'::regclass);


--
-- Name: _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY images ALTER COLUMN _id SET DEFAULT nextval('images__id_seq'::regclass);


--
-- Name: _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY users ALTER COLUMN _id SET DEFAULT nextval('users__id_seq'::regclass);


--
-- Data for Name: clicks; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY clicks (_id, high_score, date) FROM stdin;
1	2474.19323900000063	\N
\.


--
-- Name: clicks__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('clicks__id_seq', 1, true);


--
-- Data for Name: cnn; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY cnn (_id, sixteen_baseline_accuracy, nineteen_baseline_accuracy, sixteen_attention_accuracy, nineteen_attention_accuracy, epochs, date) FROM stdin;
1	65.6400000000000006	\N	\N	\N	\N	2016-11-30
2	65.6400000000000006	\N	\N	\N	\N	2016-12-2
3	65.6400000000000006	\N	\N	\N	\N	2016-12-2
4	65.6400000000000006	\N	\N	\N	\N	2016-12-3
5	65.6400000000000006	\N	\N	\N	\N	2016-12-4
6	65.6400000000000006	\N	\N	\N	\N	2016-12-5
7	65.6400000000000006	\N	\N	\N	\N	2016-12-6
8	65.6400000000000006	\N	\N	\N	\N	2016-12-7
\.


--
-- Name: cnn__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('cnn__id_seq', 8, true);


--
-- Data for Name: image_count; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY image_count (_id, num_images, current_generation, iteration_generation, generations_per_epoch) FROM stdin;
1	2500	0	0	4
\.


--
-- Name: image_count__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('image_count__id_seq', 1, true);


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY images (_id, image_path, syn_name, click_path, answers, generations) FROM stdin;
705	images/389_1683.JPEG	 barracouta	{"x":[["52","94"]],"y":[["54","94"]]}	{"answers":[null]}	1
2	images/903_32435.JPEG	 wig	\N	\N	0
3	images/903_9964.JPEG	 wig	\N	\N	0
6	images/903_12374.JPEG	 wig	\N	\N	0
7	images/903_45572.JPEG	 wig	\N	\N	0
96	images/260_27749.JPEG	 chow	{"x":[["38","100.80000305175781"]],"y":[["45","100.80000305175781"]]}	{"answers":[null]}	1
88	images/260_22904.JPEG	 chow	{"x":[["52","96.80000305175781"]],"y":[["48","96.80000305175781"]]}	{"answers":[null]}	1
92	images/260_30225.JPEG	 chow	\N	{"answers":[null]}	1
76	images/260_21008.JPEG	 chow	{"x":[["135","98.20000076293945"]],"y":[["131.29000741997774","104.13598889097507"]]}	{"answers":[null]}	1
18	images/903_6850.JPEG	 wig	\N	\N	0
16	images/903_33674.JPEG	 wig	{"x":[["34","47.79999923706055"]],"y":[["34","54.79999923706055"]]}	{"answers":[null]}	1
38	images/669_40558.JPEG	 mosquito net	{"x":[["59","91.19999694824219"]],"y":[["66","91.19999694824219"]]}	{"answers":[null]}	1
26	images/669_41323.JPEG	 mosquito net	\N	\N	0
31	images/669_32345.JPEG	 mosquito net	\N	\N	0
34	images/669_39270.JPEG	 mosquito net	\N	\N	0
35	images/669_26150.JPEG	 mosquito net	\N	\N	0
36	images/669_36011.JPEG	 mosquito net	\N	\N	0
40	images/669_25454.JPEG	 mosquito net	\N	\N	0
49	images/669_44905.JPEG	 mosquito net	\N	\N	0
50	images/669_9464.JPEG	 mosquito net	\N	\N	0
52	images/147_23047.JPEG	 grey whale	\N	\N	0
53	images/147_6403.JPEG	 grey whale	\N	\N	0
55	images/147_27114.JPEG	 grey whale	\N	\N	0
56	images/147_5337.JPEG	 grey whale	\N	\N	0
59	images/147_44999.JPEG	 grey whale	\N	\N	0
60	images/147_15679.JPEG	 grey whale	\N	\N	0
61	images/147_12724.JPEG	 grey whale	\N	\N	0
62	images/147_33269.JPEG	 grey whale	\N	\N	0
63	images/147_3458.JPEG	 grey whale	\N	\N	0
65	images/147_16200.JPEG	 grey whale	\N	\N	0
66	images/147_44485.JPEG	 grey whale	\N	\N	0
69	images/147_37524.JPEG	 grey whale	\N	\N	0
70	images/147_46487.JPEG	 grey whale	\N	\N	0
71	images/147_45499.JPEG	 grey whale	\N	\N	0
73	images/147_44017.JPEG	 grey whale	\N	\N	0
74	images/147_49745.JPEG	 grey whale	\N	\N	0
77	images/260_21694.JPEG	 chow	\N	\N	0
78	images/260_12992.JPEG	 chow	\N	\N	0
79	images/260_6839.JPEG	 chow	\N	\N	0
81	images/260_48936.JPEG	 chow	\N	\N	0
82	images/260_45445.JPEG	 chow	\N	\N	0
83	images/260_8333.JPEG	 chow	\N	\N	0
85	images/260_253.JPEG	 chow	\N	\N	0
89	images/260_13352.JPEG	 chow	\N	\N	0
94	images/260_34435.JPEG	 chow	\N	\N	0
98	images/260_27815.JPEG	 chow	\N	\N	0
99	images/260_32219.JPEG	 chow	\N	\N	0
100	images/260_44259.JPEG	 chow	\N	\N	0
86	images/260_30980.JPEG	 chow	{"x":[["126","58.19999694824219"]],"y":[["125","58.19999694824219"]]}	{"answers":[null]}	1
14	images/903_24132.JPEG	 wig	{"x":[["184","213"]],"y":[["184","214"]]}	{"answers":[null]}	1
44	images/669_3460.JPEG	 mosquito net	{"x":[["117","4"]],"y":[["117","6"]]}	{"answers":[null]}	1
27	images/669_46468.JPEG	 mosquito net	\N	{"answers":[null]}	1
54	images/147_44321.JPEG	 grey whale	{"x":[["143.60000610351562","176.5999984741211"]],"y":[["147.25525229799666","178.2245523383349"]]}	{"answers":[null]}	1
68	images/147_7709.JPEG	 grey whale	{"x":[["83","105"]],"y":[["83","104"]]}	{"answers":[null]}	1
93	images/260_47652.JPEG	 chow	{"x":[["89","88"]],"y":[["91","88"]]}	{"answers":[null]}	1
32	images/669_8780.JPEG	 mosquito net	{"x":[["109","155"]],"y":[["109","156"]]}	{"answers":[null]}	1
64	images/147_22813.JPEG	 grey whale	{"x":[["51","108"]],"y":[["52","107"]]}	{"answers":[null]}	1
102	images/440_20800.JPEG	 beer bottle	{"x":[["92","9"]],"y":[["92","16"]]}	{"answers":[null]}	1
67	images/147_24319.JPEG	 grey whale	{"x":[["8","116"]],"y":[["9","116"]]}	{"answers":[null]}	1
21	images/903_2839.JPEG	 wig	{"x":[["132.5","76"]],"y":[["126.5","76"]]}	{"answers":[null]}	1
58	images/147_21419.JPEG	 grey whale	{"x":[["214.5","90"]],"y":[["217.5","90"]]}	{"answers":[null]}	1
5	images/903_7786.JPEG	 wig	{"x":[["97","6"]],"y":[["93.39852971200732","12.002450479987811"]]}	{"answers":[null]}	1
28	images/669_16316.JPEG	 mosquito net	{"x":[["43","7"]],"y":[["45.84296926237413","13.3966808403418"]]}	{"answers":[null]}	1
39	images/669_36389.JPEG	 mosquito net	{"x":[["31","48"]],"y":[["31","46"]]}	{"answers":[null]}	1
24	images/903_22725.JPEG	 wig	{"x":[["29","146"]],"y":[["29","147"]]}	{"answers":[null]}	1
45	images/669_2537.JPEG	 mosquito net	{"x":[["69","14"]],"y":[["69","21"]]}	{"answers":[null]}	1
46	images/669_24250.JPEG	 mosquito net	{"x":[["77","79"]],"y":[["77","81"]]}	{"answers":[null]}	1
20	images/903_22467.JPEG	 wig	{"x":[["110","7"]],"y":[["108","7"]]}	{"answers":[null]}	1
13	images/903_49445.JPEG	 wig	{"x":[["241","179"]],"y":[["239","179"]]}	{"answers":[null]}	1
43	images/669_1088.JPEG	 mosquito net	{"x":[["143","27"]],"y":[["143.98994949366116","33.929646455628166"]]}	{"answers":[null]}	1
8	images/903_43153.JPEG	 wig	{"x":[["32","89"]],"y":[["34","89"]]}	{"answers":[null]}	1
1260	images/465_33365.JPEG	 bulletproof vest	{"x":[["154","68"]],"y":[["154","65"]]}	{"answers":[null]}	1
122	images/440_22474.JPEG	 beer bottle	{"x":[["175","33"]],"y":[["175","32"]]}	{"answers":[null]}	1
105	images/440_16035.JPEG	 beer bottle	\N	\N	0
128	images/934_10574.JPEG	 hotdog	{"x":[["112","102"]],"y":[["110","104"]]}	{"answers":[null]}	1
108	images/440_4016.JPEG	 beer bottle	\N	\N	0
110	images/440_3213.JPEG	 beer bottle	\N	\N	0
111	images/440_782.JPEG	 beer bottle	\N	\N	0
139	images/934_45612.JPEG	 hotdog	{"x":[["NaN","NaN"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
117	images/440_21568.JPEG	 beer bottle	\N	\N	0
147	images/934_4162.JPEG	 hotdog	\N	{"answers":[null]}	1
126	images/934_18298.JPEG	 hotdog	\N	\N	0
127	images/934_641.JPEG	 hotdog	{"x":[["21.599990844726562","240.5999984741211"]],"y":[["21.599990844726562","237.5999984741211"]]}	{"answers":[null]}	1
131	images/934_42196.JPEG	 hotdog	\N	\N	0
134	images/934_5990.JPEG	 hotdog	\N	\N	0
136	images/934_15325.JPEG	 hotdog	\N	\N	0
140	images/934_37894.JPEG	 hotdog	\N	\N	0
138	images/934_16911.JPEG	 hotdog	{"x":[["47.59999084472656","69"]],"y":[["54.59999084472656","69"]]}	{"answers":[null]}	1
150	images/934_9343.JPEG	 hotdog	{"x":[["45.79998779296875","199.8000030517578"]],"y":[["45.79998779296875","195.8000030517578"]]}	{"answers":[null]}	1
144	images/934_37464.JPEG	 hotdog	\N	\N	0
192	images/254_31377.JPEG	 pug	{"x":[["200.5","93"]],"y":[["200.5","92"]]}	{"answers":[null]}	1
153	images/947_12174.JPEG	 mushroom	{"x":[["63","71.79999542236328"]],"y":[["64","71.79999542236328"]]}	{"answers":[null]}	1
148	images/934_31096.JPEG	 hotdog	\N	\N	0
137	images/934_11212.JPEG	 hotdog	\N	{"answers":[null]}	1
181	images/254_8765.JPEG	 pug	{"x":[["234","110.80000305175781"]],"y":[["234","111.80000305175781"]]}	{"answers":[null]}	1
152	images/947_23989.JPEG	 mushroom	\N	\N	0
154	images/947_24433.JPEG	 mushroom	\N	\N	0
188	images/254_28180.JPEG	 pug	{"x":[["64","104.79999923706055"]],"y":[["64","103.79999923706055"]]}	{"answers":[null]}	1
157	images/947_16899.JPEG	 mushroom	\N	\N	0
187	images/254_38381.JPEG	 pug	{"x":[["24","149.1999969482422"]],"y":[["24","151.1999969482422"]]}	{"answers":[null]}	1
162	images/947_47903.JPEG	 mushroom	\N	\N	0
167	images/947_30856.JPEG	 mushroom	\N	\N	0
168	images/947_24680.JPEG	 mushroom	\N	\N	0
171	images/947_30181.JPEG	 mushroom	\N	\N	0
172	images/947_7981.JPEG	 mushroom	\N	\N	0
174	images/947_47005.JPEG	 mushroom	\N	\N	0
179	images/254_30148.JPEG	 pug	\N	\N	0
182	images/254_35216.JPEG	 pug	\N	\N	0
183	images/254_25052.JPEG	 pug	\N	\N	0
184	images/254_28628.JPEG	 pug	\N	\N	0
185	images/254_42741.JPEG	 pug	\N	\N	0
186	images/254_2071.JPEG	 pug	\N	\N	0
200	images/254_37744.JPEG	 pug	\N	\N	0
203	images/865_40527.JPEG	 toyshop	\N	\N	0
204	images/865_27717.JPEG	 toyshop	\N	\N	0
205	images/865_28520.JPEG	 toyshop	\N	\N	0
198	images/254_39025.JPEG	 pug	{"x":[["230","122"]],"y":[["231","121"]]}	{"answers":[null]}	1
170	images/947_6217.JPEG	 mushroom	{"x":[["178","157"]],"y":[["179","156"]]}	{"answers":[null]}	1
160	images/947_28572.JPEG	 mushroom	{"x":[["53.600006103515625","94.19999694824219"]],"y":[["56.000006103515624","90.99999694824218"]]}	{"answers":[null]}	1
118	images/440_40592.JPEG	 beer bottle	{"x":[["146","20"]],"y":[["147","19"]]}	{"answers":[null]}	1
115	images/440_21058.JPEG	 beer bottle	{"x":[["155","103"]],"y":[["153.01544424657266","106.47297256849784"]]}	{"answers":[null]}	1
133	images/934_32363.JPEG	 hotdog	{"x":[["87","187"]],"y":[["87","189"]]}	{"answers":[null]}	1
107	images/440_15511.JPEG	 beer bottle	{"x":[["24","195"]],"y":[["22","195"]]}	{"answers":[null]}	1
197	images/254_37899.JPEG	 pug	{"x":[["138","167"]],"y":[["138","168"]]}	{"answers":[null]}	1
123	images/440_34643.JPEG	 beer bottle	{"x":[["32","58"]],"y":[["32","59"]]}	{"answers":[null]}	1
112	images/440_6093.JPEG	 beer bottle	{"x":[["12","50"]],"y":[["12","51"]]}	{"answers":[null]}	1
196	images/254_31571.JPEG	 pug	{"x":[["70","111"]],"y":[["68","111"]]}	{"answers":[null]}	1
175	images/947_38560.JPEG	 mushroom	{"x":[["120","91"]],"y":[["120","92"]]}	{"answers":[null]}	1
178	images/254_23677.JPEG	 pug	{"x":[["85","72"]],"y":[["85","78"]]}	{"answers":[null]}	1
113	images/440_18211.JPEG	 beer bottle	{"x":[["70","45"]],"y":[["70","46"]]}	{"answers":[null]}	1
132	images/934_16001.JPEG	 hotdog	{"x":[["253","108"]],"y":[["253","112"]]}	{"answers":[null]}	1
143	images/934_27459.JPEG	 hotdog	{"x":[["61","166"]],"y":[["61","160"]]}	{"answers":[null]}	1
193	images/254_28319.JPEG	 pug	{"x":[["235.5","119"]],"y":[["242.5","119"]]}	{"answers":[null]}	1
121	images/440_26043.JPEG	 beer bottle	{"x":[["124.5","84"]],"y":[["126.5","84"]]}	{"answers":[null]}	1
206	images/865_30545.JPEG	 toyshop	{"x":[["102","173"]],"y":[["102","172"]]}	{"answers":[null]}	1
129	images/934_29137.JPEG	 hotdog	{"x":[["128","115"]],"y":[["128","116"]]}	{"answers":[null]}	1
161	images/947_28345.JPEG	 mushroom	{"x":[["44","40"]],"y":[["44","47"]]}	{"answers":[null]}	1
194	images/254_30822.JPEG	 pug	{"x":[["39","62"]],"y":[["39","59"]]}	{"answers":[null]}	1
166	images/947_22013.JPEG	 mushroom	{"x":[["4","102"]],"y":[["6","102"]]}	{"answers":[null]}	1
2429	images/95_15232.JPEG	 jacamar	{"x":[["55","76"]],"y":[["57","76"]]}	{"answers":[null]}	1
210	images/865_43856.JPEG	 toyshop	\N	\N	0
214	images/865_28898.JPEG	 toyshop	\N	\N	0
215	images/865_10821.JPEG	 toyshop	\N	\N	0
223	images/865_18962.JPEG	 toyshop	{"x":[["33.59999084472656","45.599998474121094"]],"y":[["33.59999084472656","50.599998474121094"]]}	{"answers":[null]}	1
217	images/865_3399.JPEG	 toyshop	\N	\N	0
220	images/865_28956.JPEG	 toyshop	\N	\N	0
219	images/865_49539.JPEG	 toyshop	{"x":[["76.5","151"]],"y":[["82.5","154"]]}	{"answers":[null]}	1
229	images/482_25544.JPEG	 cassette player	\N	\N	0
230	images/482_30133.JPEG	 cassette player	\N	\N	0
305	images/101_34647.JPEG	 tusker	{"x":[["94.79998779296875","146.1999969482422"]],"y":[["92.79998779296875","146.1999969482422"]]}	{"answers":[null]}	1
285	images/448_32957.JPEG	 birdhouse	{"x":[["100","122.80000305175781"]],"y":[["102","118.80000305175781"]]}	{"answers":[null]}	1
233	images/482_22970.JPEG	 cassette player	\N	\N	0
237	images/482_40213.JPEG	 cassette player	\N	\N	0
289	images/448_10990.JPEG	 birdhouse	\N	{"answers":[null]}	1
239	images/482_7687.JPEG	 cassette player	\N	\N	0
241	images/482_40680.JPEG	 cassette player	\N	\N	0
242	images/482_10675.JPEG	 cassette player	\N	\N	0
235	images/482_12003.JPEG	 cassette player	{"x":[["17","133.8000030517578"]],"y":[["15","133.8000030517578"]]}	{"answers":[null]}	1
252	images/381_1487.JPEG	 spider monkey	{"x":[["90","80.20000076293945"]],"y":[["89","80.20000076293945"]]}	{"answers":[null]}	1
248	images/482_9980.JPEG	 cassette player	\N	\N	0
250	images/482_18808.JPEG	 cassette player	\N	\N	0
255	images/381_28780.JPEG	 spider monkey	\N	\N	0
259	images/381_45062.JPEG	 spider monkey	\N	\N	0
260	images/381_28398.JPEG	 spider monkey	\N	\N	0
261	images/381_38439.JPEG	 spider monkey	\N	\N	0
264	images/381_48905.JPEG	 spider monkey	\N	\N	0
266	images/381_38686.JPEG	 spider monkey	\N	\N	0
267	images/381_42324.JPEG	 spider monkey	\N	\N	0
268	images/381_27963.JPEG	 spider monkey	\N	\N	0
270	images/381_3146.JPEG	 spider monkey	\N	\N	0
271	images/381_49750.JPEG	 spider monkey	\N	\N	0
272	images/381_38575.JPEG	 spider monkey	\N	\N	0
274	images/381_37709.JPEG	 spider monkey	\N	\N	0
284	images/448_31611.JPEG	 birdhouse	\N	\N	0
290	images/448_26707.JPEG	 birdhouse	\N	\N	0
291	images/448_34454.JPEG	 birdhouse	\N	\N	0
292	images/448_77.JPEG	 birdhouse	\N	\N	0
294	images/448_22716.JPEG	 birdhouse	\N	\N	0
295	images/448_11932.JPEG	 birdhouse	\N	\N	0
297	images/448_23810.JPEG	 birdhouse	\N	\N	0
298	images/448_743.JPEG	 birdhouse	\N	\N	0
304	images/101_13199.JPEG	 tusker	\N	\N	0
302	images/101_3972.JPEG	 tusker	{"x":[["29","204.1999969482422"]],"y":[["29","206.1999969482422"]]}	{"answers":[null]}	1
282	images/448_33689.JPEG	 birdhouse	{"x":[["91","227"]],"y":[["95","227"]]}	{"answers":[null]}	1
236	images/482_26131.JPEG	 cassette player	{"x":[["12","241"]],"y":[["12","239"]]}	{"answers":[null]}	1
209	images/865_37985.JPEG	 toyshop	{"x":[["77","201"]],"y":[["74","203"]]}	{"answers":[null]}	1
221	images/865_42193.JPEG	 toyshop	\N	{"answers":[null]}	1
306	images/101_33875.JPEG	 tusker	{"x":[["34","69"]],"y":[["33","70"]]}	{"answers":[null]}	1
234	images/482_4096.JPEG	 cassette player	\N	{"answers":[null]}	1
227	images/482_16454.JPEG	 cassette player	\N	{"answers":[null]}	1
301	images/101_33544.JPEG	 tusker	{"x":[["148","158"]],"y":[["148","161"]]}	{"answers":[null]}	1
286	images/448_48981.JPEG	 birdhouse	{"x":[["119","122"]],"y":[["119","123"]]}	{"answers":[null]}	1
240	images/482_48066.JPEG	 cassette player	{"x":[["78","128"]],"y":[["79","128"]]}	{"answers":[null]}	1
307	images/101_47783.JPEG	 tusker	{"x":[["136","141"]],"y":[["135","143"]]}	{"answers":[null]}	1
213	images/865_3409.JPEG	 toyshop	{"x":[["215","66"]],"y":[["214","66"]]}	{"answers":[null]}	1
262	images/381_14438.JPEG	 spider monkey	{"x":[["152","195"]],"y":[["151","194"]]}	{"answers":[null]}	1
265	images/381_30.JPEG	 spider monkey	\N	{"answers":[null]}	1
275	images/381_35076.JPEG	 spider monkey	{"x":[["104","17"]],"y":[["106","17"]]}	{"answers":[null]}	1
263	images/381_22160.JPEG	 spider monkey	{"x":[["106","111"]],"y":[["106","105"]]}	{"answers":[null]}	1
246	images/482_6490.JPEG	 cassette player	\N	{"answers":[null]}	1
224	images/865_24831.JPEG	 toyshop	{"x":[["108","22"]],"y":[["108","23"]]}	{"answers":[null]}	1
222	images/865_17675.JPEG	 toyshop	{"x":[["127","141"]],"y":[["127","143"]]}	{"answers":[null]}	1
247	images/482_26974.JPEG	 cassette player	{"x":[["88.5","159"]],"y":[["95.5","159"]]}	{"answers":[null]}	1
303	images/101_44515.JPEG	 tusker	{"x":[["46.5","131"]],"y":[["42.5","131"]]}	{"answers":[null]}	1
281	images/448_1326.JPEG	 birdhouse	{"x":[["105.5","112"]],"y":[["104.5","112"]]}	{"answers":[null]}	1
211	images/865_38799.JPEG	 toyshop	{"x":[["19","135"]],"y":[["25","135"]]}	{"answers":[null]}	1
228	images/482_10365.JPEG	 cassette player	{"x":[["3","95"]],"y":[["8","95"]]}	{"answers":[null]}	1
218	images/865_15231.JPEG	 toyshop	{"x":[["133","85"]],"y":[["133","86"]]}	{"answers":[null]}	1
245	images/482_34724.JPEG	 cassette player	\N	{"answers":[null]}	1
308	images/101_22973.JPEG	 tusker	\N	\N	0
309	images/101_10941.JPEG	 tusker	\N	\N	0
311	images/101_25402.JPEG	 tusker	\N	\N	0
312	images/101_26757.JPEG	 tusker	\N	\N	0
313	images/101_11415.JPEG	 tusker	\N	\N	0
314	images/101_32520.JPEG	 tusker	\N	\N	0
396	images/697_31238.JPEG	 pajama	{"x":[["58.59999084472656","8.599998474121094"]],"y":[["62.59999084472656","8.599998474121094"]]}	{"answers":[null]}	1
310	images/101_42216.JPEG	 tusker	{"x":[["175.59999084472656","119.19999694824219"]],"y":[["175.59999084472656","112.19999694824219"]]}	{"answers":[null]}	1
315	images/101_9435.JPEG	 tusker	{"x":[["130.5","131"]],"y":[["130.5","134"]]}	{"answers":[null]}	1
412	images/425_398.JPEG	 barn	{"x":[["4.79998779296875","113.80000305175781"]],"y":[["9.482740914325898","108.59694402802765"]]}	{"answers":[null]}	1
316	images/101_43360.JPEG	 tusker	{"x":[["165","130.8000030517578"]],"y":[["165","131.8000030517578"]]}	{"answers":[null]}	1
382	images/697_10075.JPEG	 pajama	\N	{"answers":[null]}	1
329	images/959_21784.JPEG	 carbonara	\N	\N	0
386	images/697_46756.JPEG	 pajama	\N	{"answers":[null]}	1
334	images/959_39678.JPEG	 carbonara	\N	\N	0
335	images/959_37224.JPEG	 carbonara	\N	\N	0
392	images/697_37022.JPEG	 pajama	{"x":[["114","183.8000030517578"]],"y":[["114","182.8000030517578"]]}	{"answers":[null]}	1
339	images/959_8990.JPEG	 carbonara	\N	\N	0
341	images/959_46916.JPEG	 carbonara	\N	\N	0
322	images/101_39435.JPEG	 tusker	{"x":[["144","181.8000030517578"]],"y":[["144","180.8000030517578"]]}	{"answers":[null]}	1
380	images/697_15439.JPEG	 pajama	{"x":[["156","7.400001525878906"]],"y":[["155","7.400001525878906"]]}	{"answers":[null]}	1
348	images/959_9755.JPEG	 carbonara	\N	\N	0
354	images/558_12057.JPEG	 flute	\N	\N	0
355	images/558_37451.JPEG	 flute	\N	\N	0
356	images/558_48609.JPEG	 flute	\N	\N	0
357	images/558_5195.JPEG	 flute	\N	\N	0
371	images/558_25570.JPEG	 flute	\N	\N	0
372	images/558_16658.JPEG	 flute	\N	\N	0
374	images/558_8934.JPEG	 flute	\N	\N	0
379	images/697_28561.JPEG	 pajama	\N	\N	0
381	images/697_42999.JPEG	 pajama	\N	\N	0
394	images/697_25310.JPEG	 pajama	\N	\N	0
397	images/697_20226.JPEG	 pajama	\N	\N	0
398	images/697_34674.JPEG	 pajama	\N	\N	0
400	images/697_38052.JPEG	 pajama	\N	\N	0
401	images/425_10620.JPEG	 barn	\N	\N	0
402	images/425_33382.JPEG	 barn	\N	\N	0
403	images/425_9142.JPEG	 barn	\N	\N	0
407	images/425_42968.JPEG	 barn	\N	\N	0
408	images/425_10326.JPEG	 barn	\N	\N	0
411	images/425_49160.JPEG	 barn	\N	\N	0
327	images/959_19589.JPEG	 carbonara	{"x":[["162","196.1999969482422"]],"y":[["158","196.1999969482422"]]}	{"answers":[null]}	1
351	images/558_6017.JPEG	 flute	{"x":[["2","166"]],"y":[["5.975534938694476","166.4417261042994"]]}	{"answers":[null]}	1
391	images/697_8479.JPEG	 pajama	{"x":[["157","70"]],"y":[["157","72"]]}	{"answers":[null]}	1
336	images/959_34524.JPEG	 carbonara	{"x":[["166","180"]],"y":[["162","180"]]}	{"answers":[null]}	1
393	images/697_32738.JPEG	 pajama	{"x":[["12","53"]],"y":[["13","52"]]}	{"answers":[null]}	1
366	images/558_45815.JPEG	 flute	{"x":[["36","42"]],"y":[["37","43"]]}	{"answers":[null]}	1
387	images/697_21086.JPEG	 pajama	\N	{"answers":[null]}	1
337	images/959_9150.JPEG	 carbonara	\N	{"answers":[null]}	1
369	images/558_35399.JPEG	 flute	\N	{"answers":[null]}	1
324	images/101_36667.JPEG	 tusker	{"x":[["103.60000610351562","219.5999984741211"]],"y":[["104.60000610351562","219.5999984741211"]]}	{"answers":[null]}	1
353	images/558_42293.JPEG	 flute	{"x":[["197","106"]],"y":[["201","106"]]}	{"answers":[null]}	1
406	images/425_16081.JPEG	 barn	{"x":[["98","199"]],"y":[["97","196"]]}	{"answers":[null]}	1
342	images/959_46193.JPEG	 carbonara	{"x":[["47","165"]],"y":[["46.34240405077857","161.05442430467141"]]}	{"answers":[null]}	1
389	images/697_35905.JPEG	 pajama	{"x":[["135","13"]],"y":[["135","14"]]}	{"answers":[null]}	1
365	images/558_39792.JPEG	 flute	{"x":[["153","40"]],"y":[["151","46"]]}	{"answers":[null]}	1
320	images/101_6827.JPEG	 tusker	{"x":[["104","198"]],"y":[["104","195"]]}	{"answers":[null]}	1
358	images/558_19994.JPEG	 flute	{"x":[["89","141"]],"y":[["88","143"]]}	{"answers":[null]}	1
409	images/425_29570.JPEG	 barn	{"x":[["63","155"]],"y":[["64","155"]]}	{"answers":[null]}	1
373	images/558_14086.JPEG	 flute	{"x":[["64","30"]],"y":[["64","31"]]}	{"answers":[null]}	1
326	images/959_28532.JPEG	 carbonara	{"x":[["110.5","87"]],"y":[["110.5","88"]]}	{"answers":[null]}	1
330	images/959_14906.JPEG	 carbonara	{"x":[["160.5","79"]],"y":[["156.5","79"]]}	{"answers":[null]}	1
378	images/697_20906.JPEG	 pajama	{"x":[["75.5","83"]],"y":[["75.5","88"]]}	{"answers":[null]}	1
377	images/697_34173.JPEG	 pajama	{"x":[["109.5","122"]],"y":[["111.5","122"]]}	{"answers":[null]}	1
349	images/959_45944.JPEG	 carbonara	{"x":[["82","27"]],"y":[["78","26"]]}	{"answers":[null]}	1
368	images/558_25699.JPEG	 flute	{"x":[["10","27"]],"y":[["11","28"]]}	{"answers":[null]}	1
340	images/959_29447.JPEG	 carbonara	{"x":[["169","109"]],"y":[["166","109"]]}	{"answers":[null]}	1
388	images/697_36412.JPEG	 pajama	{"x":[["121","49"]],"y":[["118","49"]]}	{"answers":[null]}	1
343	images/959_8293.JPEG	 carbonara	{"x":[["43","75"]],"y":[["43","74"]]}	{"answers":[null]}	1
415	images/425_4952.JPEG	 barn	\N	\N	0
502	images/724_18022.JPEG	 pirate	{"x":[["122","9"]],"y":[["123","9"]]}	{"answers":[null]}	1
420	images/425_43109.JPEG	 barn	\N	\N	0
158	images/947_33640.JPEG	 mushroom	{"x":[["106","11"]],"y":[["106","16"]]}	{"answers":[null]}	1
424	images/425_41608.JPEG	 barn	\N	\N	0
425	images/425_26475.JPEG	 barn	\N	\N	0
434	images/833_22661.JPEG	 submarine	{"x":[["2.5999908447265625","81.5999984741211"]],"y":[["5.5999908447265625","77.5999984741211"]]}	{"answers":[null]}	1
467	images/750_5790.JPEG	 quilt	{"x":[["152.59999084472656","234.4000015258789"]],"y":[["152.59999084472656","227.4000015258789"]]}	{"answers":[null]}	1
417	images/425_8651.JPEG	 barn	{"x":[["54","149.79999542236328"]],"y":[["54","151.79999542236328"]]}	{"answers":[null]}	1
494	images/485_5101.JPEG	 CD player	{"x":[["16","136.8000030517578"]],"y":[["17","136.8000030517578"]]}	{"answers":[null]}	1
432	images/833_38324.JPEG	 submarine	\N	\N	0
486	images/485_25957.JPEG	 CD player	{"x":[["41","128.8000030517578"]],"y":[["40","129.8000030517578"]]}	{"answers":[null]}	1
481	images/485_42537.JPEG	 CD player	{"x":[["123","220.1999969482422"]],"y":[["116.03473966853008","219.5034709150952"]]}	{"answers":[null]}	1
439	images/833_49395.JPEG	 submarine	\N	\N	0
480	images/485_19477.JPEG	 CD player	{"x":[["24","102.19999694824219"]],"y":[["24","105.19999694824219"]]}	{"answers":[null]}	1
441	images/833_29017.JPEG	 submarine	\N	\N	0
443	images/833_49994.JPEG	 submarine	\N	\N	0
446	images/833_30756.JPEG	 submarine	\N	\N	0
447	images/833_3775.JPEG	 submarine	\N	\N	0
458	images/750_16540.JPEG	 quilt	\N	\N	0
459	images/750_49110.JPEG	 quilt	\N	\N	0
460	images/750_9563.JPEG	 quilt	\N	\N	0
461	images/750_17883.JPEG	 quilt	\N	\N	0
462	images/750_48603.JPEG	 quilt	\N	\N	0
464	images/750_22605.JPEG	 quilt	\N	\N	0
465	images/750_1250.JPEG	 quilt	\N	\N	0
466	images/750_39987.JPEG	 quilt	\N	\N	0
471	images/750_36784.JPEG	 quilt	\N	\N	0
472	images/750_5580.JPEG	 quilt	\N	\N	0
474	images/750_36247.JPEG	 quilt	\N	\N	0
478	images/485_28416.JPEG	 CD player	\N	\N	0
479	images/485_17393.JPEG	 CD player	\N	\N	0
482	images/485_6873.JPEG	 CD player	\N	\N	0
484	images/485_48437.JPEG	 CD player	\N	\N	0
485	images/485_24925.JPEG	 CD player	\N	\N	0
491	images/485_6466.JPEG	 CD player	\N	\N	0
492	images/485_48934.JPEG	 CD player	\N	\N	0
495	images/485_37807.JPEG	 CD player	\N	\N	0
497	images/485_21550.JPEG	 CD player	\N	\N	0
500	images/485_29276.JPEG	 CD player	\N	\N	0
505	images/724_26927.JPEG	 pirate	\N	\N	0
507	images/724_40405.JPEG	 pirate	\N	\N	0
514	images/724_25037.JPEG	 pirate	\N	\N	0
504	images/724_27387.JPEG	 pirate	{"x":[["175","84"]],"y":[["175.65759594922142","87.94557569532857"]]}	{"answers":[null]}	1
475	images/750_27646.JPEG	 quilt	{"x":[["205","236"]],"y":[["207","233"]]}	{"answers":[null]}	1
506	images/724_37281.JPEG	 pirate	{"x":[["38.600006103515625","164"]],"y":[["38.600006103515625","167"]]}	{"answers":[null]}	1
515	images/724_38589.JPEG	 pirate	{"x":[["36","175"]],"y":[["36","179"]]}	{"answers":[null]}	1
449	images/833_5640.JPEG	 submarine	{"x":[["132","166"]],"y":[["132","167"]]}	{"answers":[null]}	1
437	images/833_29702.JPEG	 submarine	{"x":[["181","48"]],"y":[["180","48"]]}	{"answers":[null]}	1
413	images/425_49614.JPEG	 barn	{"x":[["63","115"]],"y":[["62","115"]]}	{"answers":[null]}	1
444	images/833_48199.JPEG	 submarine	{"x":[["171","2"]],"y":[["171","3"]]}	{"answers":[null]}	1
483	images/485_22680.JPEG	 CD player	{"x":[["91","100"]],"y":[["92","105"]]}	{"answers":[null]}	1
451	images/750_21885.JPEG	 quilt	{"x":[["127","198"]],"y":[["127","200"]]}	{"answers":[null]}	1
452	images/750_27757.JPEG	 quilt	{"x":[["75","161"]],"y":[["75","163"]]}	{"answers":[null]}	1
496	images/485_26246.JPEG	 CD player	{"x":[["114","89"]],"y":[["116","89"]]}	{"answers":[null]}	1
448	images/833_2125.JPEG	 submarine	{"x":[["185","93"]],"y":[["185","100"]]}	{"answers":[null]}	1
510	images/724_35368.JPEG	 pirate	{"x":[["119","4"]],"y":[["119","11"]]}	{"answers":[null]}	1
438	images/833_27059.JPEG	 submarine	{"x":[["115","30"]],"y":[["115","35"]]}	{"answers":[null]}	1
428	images/833_2754.JPEG	 submarine	{"x":[["103","103"]],"y":[["103","104"]]}	{"answers":[null]}	1
469	images/750_47185.JPEG	 quilt	{"x":[["153","103"]],"y":[["154","104"]]}	{"answers":[null]}	1
476	images/485_11013.JPEG	 CD player	{"x":[["216.5","74"]],"y":[["212.5","74"]]}	{"answers":[null]}	1
499	images/485_23888.JPEG	 CD player	\N	{"answers":[null]}	1
455	images/750_30675.JPEG	 quilt	{"x":[["136.5","81"]],"y":[["133.5","81"]]}	{"answers":[null]}	1
493	images/485_41707.JPEG	 CD player	{"x":[["33.5","93"]],"y":[["34.5","93"]]}	{"answers":[null]}	1
423	images/425_29519.JPEG	 barn	{"x":[["17.5","117"]],"y":[["24.5","117"]]}	{"answers":[null]}	1
453	images/750_43179.JPEG	 quilt	{"x":[["17","113"]],"y":[["23.681359846245208","110.91207504804838"]]}	{"answers":[null]}	1
501	images/724_19717.JPEG	 pirate	{"x":[["76.5","95"]],"y":[["82.1","90.8"]]}	{"answers":[null]}	1
422	images/425_10981.JPEG	 barn	{"x":[["5","62"]],"y":[["5","63"]]}	{"answers":[null]}	1
414	images/425_34925.JPEG	 barn	{"x":[["166","63"]],"y":[["172","64"]]}	{"answers":[null]}	1
546	images/944_19955.JPEG	 artichoke	{"x":[["141","66"]],"y":[["142.21649733736334","72.89348491172555"]]}	{"answers":[null]}	1
2032	images/12_2093.JPEG	 house finch	{"x":[["163","53"]],"y":[["164","53"]]}	{"answers":[null]}	1
520	images/724_44329.JPEG	 pirate	\N	\N	0
521	images/724_36110.JPEG	 pirate	\N	\N	0
523	images/724_32937.JPEG	 pirate	\N	\N	0
536	images/944_39109.JPEG	 artichoke	{"x":[["60.59999084472656","40.599998474121094"]],"y":[["60.59999084472656","47.599998474121094"]]}	{"answers":[null]}	1
598	images/631_49155.JPEG	 lotion	{"x":[["132.59999084472656","60"]],"y":[["129.59999084472656","60"]]}	{"answers":[null]}	1
602	images/563_29116.JPEG	 fountain pen	{"x":[["100.59999084472656","72"]],"y":[["100.59999084472656","74"]]}	{"answers":[null]}	1
585	images/631_26022.JPEG	 lotion	{"x":[["95.5","90"]],"y":[["94.5","90"]]}	{"answers":[null]}	1
567	images/171_21370.JPEG	 Italian greyhound	{"x":[["208","181.79999542236328"]],"y":[["204","177.79999542236328"]]}	{"answers":[null]}	1
539	images/944_27793.JPEG	 artichoke	\N	\N	0
541	images/944_31343.JPEG	 artichoke	\N	\N	0
542	images/944_47827.JPEG	 artichoke	\N	\N	0
557	images/171_29286.JPEG	 Italian greyhound	{"x":[["67.5","131"]],"y":[["68.5","131"]]}	{"answers":[null]}	1
544	images/944_18339.JPEG	 artichoke	\N	\N	0
550	images/944_16056.JPEG	 artichoke	\N	\N	0
591	images/631_2672.JPEG	 lotion	{"x":[["111","113.80000305175781"]],"y":[["116","113.80000305175781"]]}	{"answers":[null]}	1
588	images/631_34967.JPEG	 lotion	\N	{"answers":[null]}	1
555	images/171_49765.JPEG	 Italian greyhound	\N	\N	0
516	images/724_3637.JPEG	 pirate	{"x":[["82","75.80000305175781"]],"y":[["84","75.80000305175781"]]}	{"answers":[null]}	1
519	images/724_23298.JPEG	 pirate	{"x":[["115","90.80000305175781"]],"y":[["115","91.80000305175781"]]}	{"answers":[null]}	1
571	images/171_48847.JPEG	 Italian greyhound	{"x":[["102","81.20000076293945"]],"y":[["101","81.20000076293945"]]}	{"answers":[null]}	1
565	images/171_10155.JPEG	 Italian greyhound	\N	\N	0
568	images/171_17040.JPEG	 Italian greyhound	\N	\N	0
570	images/171_4099.JPEG	 Italian greyhound	\N	\N	0
576	images/631_26643.JPEG	 lotion	\N	\N	0
579	images/631_37369.JPEG	 lotion	\N	\N	0
580	images/631_15960.JPEG	 lotion	\N	\N	0
581	images/631_40365.JPEG	 lotion	\N	\N	0
586	images/631_40566.JPEG	 lotion	\N	\N	0
589	images/631_46858.JPEG	 lotion	\N	\N	0
594	images/631_20597.JPEG	 lotion	\N	\N	0
596	images/631_17464.JPEG	 lotion	\N	\N	0
597	images/631_48060.JPEG	 lotion	\N	\N	0
599	images/631_24419.JPEG	 lotion	\N	\N	0
600	images/631_6551.JPEG	 lotion	\N	\N	0
603	images/563_29889.JPEG	 fountain pen	\N	\N	0
605	images/563_3498.JPEG	 fountain pen	\N	\N	0
608	images/563_13941.JPEG	 fountain pen	\N	\N	0
610	images/563_18646.JPEG	 fountain pen	\N	\N	0
611	images/563_36096.JPEG	 fountain pen	\N	\N	0
612	images/563_22443.JPEG	 fountain pen	\N	\N	0
593	images/631_41960.JPEG	 lotion	{"x":[["178","209"]],"y":[["178","207"]]}	{"answers":[null]}	1
525	images/724_829.JPEG	 pirate	{"x":[["70","35"]],"y":[["73.42997170285018","32.94201697828989"]]}	{"answers":[null]}	1
527	images/944_3815.JPEG	 artichoke	{"x":[["105","35"]],"y":[["106","35"]]}	{"answers":[null]}	1
584	images/631_25520.JPEG	 lotion	{"x":[["39","195"]],"y":[["38.02985749985467","191.11942999941868"]]}	{"answers":[null]}	1
577	images/631_30436.JPEG	 lotion	{"x":[["69","217"]],"y":[["72.89756478277847","216.10056197320498"]]}	{"answers":[null]}	1
537	images/944_28980.JPEG	 artichoke	\N	{"answers":[null]}	1
529	images/944_26499.JPEG	 artichoke	{"x":[["150","17"]],"y":[["149","18"]]}	{"answers":[null]}	1
522	images/724_13260.JPEG	 pirate	{"x":[["132","36"]],"y":[["133","40"]]}	{"answers":[null]}	1
575	images/171_28138.JPEG	 Italian greyhound	{"x":[["137","145"]],"y":[["139","144"]]}	{"answers":[null]}	1
561	images/171_3413.JPEG	 Italian greyhound	{"x":[["94","62"]],"y":[["99","62"]]}	{"answers":[null]}	1
587	images/631_1608.JPEG	 lotion	{"x":[["123","27"]],"y":[["123","32"]]}	{"answers":[null]}	1
538	images/944_14169.JPEG	 artichoke	{"x":[["166","32"]],"y":[["168","36"]]}	{"answers":[null]}	1
609	images/563_35818.JPEG	 fountain pen	{"x":[["102","8"]],"y":[["102","11"]]}	{"answers":[null]}	1
604	images/563_41408.JPEG	 fountain pen	{"x":[["52","196"]],"y":[["56","196"]]}	{"answers":[null]}	1
562	images/171_25757.JPEG	 Italian greyhound	{"x":[["60","19"]],"y":[["60","26"]]}	{"answers":[null]}	1
601	images/563_17208.JPEG	 fountain pen	{"x":[["94","64"]],"y":[["99.37754895718163","68.48129079765135"]]}	{"answers":[null]}	1
613	images/563_12549.JPEG	 fountain pen	{"x":[["182.5","101"]],"y":[["188.19613429844713","105.06866735603367"]]}	{"answers":[null]}	1
554	images/171_41544.JPEG	 Italian greyhound	{"x":[["61.5","82"]],"y":[["64.5","82"]]}	{"answers":[null]}	1
549	images/944_18974.JPEG	 artichoke	{"x":[["52","44"]],"y":[["50","45"]]}	{"answers":[null]}	1
556	images/171_26581.JPEG	 Italian greyhound	{"x":[["79","27"]],"y":[["82","29"]]}	{"answers":[null]}	1
564	images/171_2649.JPEG	 Italian greyhound	{"x":[["51","115"]],"y":[["51","114"]]}	{"answers":[null]}	1
578	images/631_32675.JPEG	 lotion	{"x":[["1","63"]],"y":[["7","63"]]}	{"answers":[null]}	1
526	images/944_31442.JPEG	 artichoke	{"x":[["126","120"]],"y":[["126","118"]]}	{"answers":[null]}	1
615	images/563_17287.JPEG	 fountain pen	\N	\N	0
616	images/563_4978.JPEG	 fountain pen	\N	\N	0
617	images/563_6043.JPEG	 fountain pen	\N	\N	0
618	images/563_42822.JPEG	 fountain pen	\N	\N	0
695	images/663_18729.JPEG	 monastery	{"x":[["164","35"]],"y":[["169","35"]]}	{"answers":[null]}	1
669	images/781_40988.JPEG	 scoreboard	{"x":[["113","164"]],"y":[["111","166"]]}	{"answers":[null]}	1
622	images/563_44315.JPEG	 fountain pen	\N	\N	0
633	images/604_42327.JPEG	 hourglass	{"x":[["117.59999084472656","143.20000076293945"]],"y":[["111.52228884985534","139.72702819444163"]]}	{"answers":[null]}	1
665	images/781_31441.JPEG	 scoreboard	\N	{"answers":[null]}	1
627	images/604_43165.JPEG	 hourglass	\N	\N	0
629	images/604_28523.JPEG	 hourglass	\N	\N	0
634	images/604_23725.JPEG	 hourglass	\N	\N	0
638	images/604_36351.JPEG	 hourglass	\N	\N	0
639	images/604_21533.JPEG	 hourglass	\N	\N	0
642	images/604_9927.JPEG	 hourglass	\N	\N	0
692	images/663_28036.JPEG	 monastery	{"x":[["67","212.1999969482422"]],"y":[["66.76935607001988","205.20379773884545"]]}	{"answers":[null]}	1
625	images/563_44622.JPEG	 fountain pen	\N	{"answers":[null]}	1
702	images/389_2886.JPEG	 barracouta	\N	{"answers":[null]}	1
656	images/781_48574.JPEG	 scoreboard	{"x":[["13","147.8000030517578"]],"y":[["20","147.8000030517578"]]}	{"answers":[null]}	1
649	images/604_9003.JPEG	 hourglass	\N	\N	0
693	images/663_21724.JPEG	 monastery	{"x":[["NaN","NaN"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
654	images/781_27312.JPEG	 scoreboard	\N	\N	0
655	images/781_42887.JPEG	 scoreboard	\N	\N	0
657	images/781_32636.JPEG	 scoreboard	\N	\N	0
660	images/781_35008.JPEG	 scoreboard	\N	\N	0
662	images/781_16119.JPEG	 scoreboard	\N	\N	0
663	images/781_27137.JPEG	 scoreboard	\N	\N	0
667	images/781_9365.JPEG	 scoreboard	\N	\N	0
670	images/781_2770.JPEG	 scoreboard	\N	\N	0
671	images/781_44913.JPEG	 scoreboard	\N	\N	0
676	images/663_7592.JPEG	 monastery	\N	\N	0
677	images/663_4304.JPEG	 monastery	\N	\N	0
682	images/663_9470.JPEG	 monastery	\N	\N	0
684	images/663_12158.JPEG	 monastery	\N	\N	0
685	images/663_33497.JPEG	 monastery	\N	\N	0
687	images/663_13554.JPEG	 monastery	\N	\N	0
688	images/663_27870.JPEG	 monastery	\N	\N	0
691	images/663_11743.JPEG	 monastery	\N	\N	0
697	images/663_41156.JPEG	 monastery	\N	\N	0
699	images/663_14849.JPEG	 monastery	\N	\N	0
700	images/663_21505.JPEG	 monastery	\N	\N	0
704	images/389_28722.JPEG	 barracouta	\N	\N	0
710	images/389_3380.JPEG	 barracouta	\N	\N	0
711	images/389_13909.JPEG	 barracouta	\N	\N	0
621	images/563_2929.JPEG	 fountain pen	{"x":[["235","211.1999969482422"]],"y":[["235","209.1999969482422"]]}	{"answers":[null]}	1
707	images/389_32163.JPEG	 barracouta	{"x":[["254","118"]],"y":[["250","118"]]}	{"answers":[null]}	1
640	images/604_8357.JPEG	 hourglass	{"x":[["77","8"]],"y":[["77","9"]]}	{"answers":[null]}	1
645	images/604_26638.JPEG	 hourglass	{"x":[["57","11"]],"y":[["57","12"]]}	{"answers":[null]}	1
636	images/604_4126.JPEG	 hourglass	{"x":[["108.60000610351562","126.19999694824219"]],"y":[["105.77157897876944","129.02842407298837"]]}	{"answers":[null]}	1
674	images/781_28947.JPEG	 scoreboard	{"x":[["217","103"]],"y":[["218.32525087403502","106.77408401083885"]]}	{"answers":[null]}	1
653	images/781_12516.JPEG	 scoreboard	{"x":[["37","123"]],"y":[["40.99309749269998","122.76511191219412"]]}	{"answers":[null]}	1
690	images/663_8706.JPEG	 monastery	{"x":[["93","156"]],"y":[["91","156"]]}	{"answers":[null]}	1
672	images/781_19710.JPEG	 scoreboard	{"x":[["112","66"]],"y":[["112","68"]]}	{"answers":[null]}	1
651	images/781_22220.JPEG	 scoreboard	{"x":[["172","103"]],"y":[["172","106"]]}	{"answers":[null]}	1
686	images/663_37624.JPEG	 monastery	{"x":[["83","242"]],"y":[["85","242"]]}	{"answers":[null]}	1
647	images/604_33942.JPEG	 hourglass	{"x":[["4","108"]],"y":[["4","114"]]}	{"answers":[null]}	1
635	images/604_9070.JPEG	 hourglass	{"x":[["104","48"]],"y":[["104","41"]]}	{"answers":[null]}	1
679	images/663_551.JPEG	 monastery	{"x":[["99","106"]],"y":[["99","107"]]}	{"answers":[null]}	1
632	images/604_4502.JPEG	 hourglass	{"x":[["134","127"]],"y":[["135","131"]]}	{"answers":[null]}	1
709	images/389_4660.JPEG	 barracouta	{"x":[["44","77"]],"y":[["40","77"]]}	{"answers":[null]}	1
630	images/604_40744.JPEG	 hourglass	{"x":[["110","230"]],"y":[["110","231"]]}	{"answers":[null]}	1
637	images/604_41654.JPEG	 hourglass	{"x":[["99.5","55"]],"y":[["99.5","59"]]}	{"answers":[null]}	1
708	images/389_26135.JPEG	 barracouta	{"x":[["70.5","148"]],"y":[["72.5","154"]]}	{"answers":[null]}	1
698	images/663_26624.JPEG	 monastery	{"x":[["184","6"]],"y":[["183","5"]]}	{"answers":[null]}	1
668	images/781_1216.JPEG	 scoreboard	{"x":[["247","135"]],"y":[["246","135"]]}	{"answers":[null]}	1
628	images/604_38231.JPEG	 hourglass	{"x":[["110","108"]],"y":[["110","110"]]}	{"answers":[null]}	1
689	images/663_16249.JPEG	 monastery	{"x":[["99","130"]],"y":[["100","130"]]}	{"answers":[null]}	1
664	images/781_34394.JPEG	 scoreboard	{"x":[["93","70"]],"y":[["93","73"]]}	{"answers":[null]}	1
631	images/604_9925.JPEG	 hourglass	{"x":[["121","71"]],"y":[["121","72"]]}	{"answers":[null]}	1
712	images/389_40606.JPEG	 barracouta	\N	\N	0
729	images/344_45570.JPEG	 hippopotamus	{"x":[["53","122"]],"y":[["52","126"]]}	{"answers":[null]}	1
2413	images/690_38133.JPEG	 oxcart	{"x":[["NaN","NaN"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
715	images/389_37373.JPEG	 barracouta	\N	\N	0
716	images/389_11819.JPEG	 barracouta	\N	\N	0
718	images/389_4452.JPEG	 barracouta	\N	\N	0
719	images/389_34276.JPEG	 barracouta	\N	\N	0
723	images/389_15163.JPEG	 barracouta	\N	\N	0
724	images/389_13682.JPEG	 barracouta	\N	\N	0
766	images/501_46379.JPEG	 cloak	{"x":[["135.59999084472656","107"]],"y":[["134.59999084472656","107"]]}	{"answers":[null]}	1
727	images/344_12023.JPEG	 hippopotamus	\N	\N	0
756	images/501_44912.JPEG	 cloak	{"x":[["103.79998779296875","108.19999694824219"]],"y":[["102.79998779296875","109.19999694824219"]]}	{"answers":[null]}	1
730	images/344_4433.JPEG	 hippopotamus	\N	\N	0
779	images/825_23484.JPEG	 stone wall	{"x":[["23.5","91"]],"y":[["23.5","93"]]}	{"answers":[null]}	1
759	images/501_13497.JPEG	 cloak	{"x":[["63.5","241"]],"y":[["56.5","241"]]}	{"answers":[null]}	1
739	images/344_16348.JPEG	 hippopotamus	\N	\N	0
741	images/344_22939.JPEG	 hippopotamus	{"x":[["198","173.79999542236328"]],"y":[["198","180.79999542236328"]]}	{"answers":[null]}	1
742	images/344_34421.JPEG	 hippopotamus	\N	\N	0
743	images/344_38064.JPEG	 hippopotamus	\N	\N	0
774	images/501_42297.JPEG	 cloak	{"x":[["117.5","32"]],"y":[["117.5","39"]]}	{"answers":[null]}	1
717	images/389_36479.JPEG	 barracouta	\N	{"answers":[null]}	1
731	images/344_46170.JPEG	 hippopotamus	{"x":[["174","97.80000305175781"]],"y":[["173","95.80000305175781"]]}	{"answers":[null]}	1
720	images/389_41890.JPEG	 barracouta	{"x":[["202","138.1999969482422"]],"y":[["200","138.1999969482422"]]}	{"answers":[null]}	1
735	images/344_14669.JPEG	 hippopotamus	{"x":[["55","59.19999694824219"]],"y":[["55","60.19999694824219"]]}	{"answers":[null]}	1
760	images/501_26393.JPEG	 cloak	\N	\N	0
762	images/501_18973.JPEG	 cloak	\N	\N	0
763	images/501_2579.JPEG	 cloak	\N	\N	0
764	images/501_14109.JPEG	 cloak	\N	\N	0
768	images/501_24761.JPEG	 cloak	\N	\N	0
773	images/501_20624.JPEG	 cloak	\N	\N	0
784	images/825_14605.JPEG	 stone wall	\N	\N	0
791	images/825_8880.JPEG	 stone wall	\N	\N	0
794	images/825_41649.JPEG	 stone wall	\N	\N	0
795	images/825_10426.JPEG	 stone wall	\N	\N	0
800	images/825_29866.JPEG	 stone wall	\N	\N	0
802	images/921_19436.JPEG	 book jacket	\N	\N	0
803	images/921_23068.JPEG	 book jacket	\N	\N	0
807	images/921_12269.JPEG	 book jacket	\N	\N	0
808	images/921_6633.JPEG	 book jacket	\N	\N	0
809	images/921_27943.JPEG	 book jacket	\N	\N	0
799	images/825_47423.JPEG	 stone wall	{"x":[["16","61"]],"y":[["20","61"]]}	{"answers":[null]}	1
806	images/921_16646.JPEG	 book jacket	{"x":[["32","5"]],"y":[["32","9"]]}	{"answers":[null]}	1
801	images/921_10766.JPEG	 book jacket	\N	{"answers":[null]}	1
767	images/501_34286.JPEG	 cloak	{"x":[["37","234"]],"y":[["37","233"]]}	{"answers":[null]}	1
772	images/501_28021.JPEG	 cloak	{"x":[["32","3"]],"y":[["31","6"]]}	{"answers":[null]}	1
738	images/344_48883.JPEG	 hippopotamus	\N	{"answers":[null]}	1
757	images/501_42111.JPEG	 cloak	{"x":[["64","131"]],"y":[["66.82842712474618","128.17157287525382"]]}	{"answers":[null]}	1
765	images/501_20115.JPEG	 cloak	{"x":[["197.60000610351562","74.19999694824219"]],"y":[["198.60000610351562","76.19999694824219"]]}	{"answers":[null]}	1
770	images/501_39217.JPEG	 cloak	\N	{"answers":[null]}	1
758	images/501_8262.JPEG	 cloak	{"x":[["132","57"]],"y":[["136","57"]]}	{"answers":[null]}	1
789	images/825_32654.JPEG	 stone wall	{"x":[["237","66"]],"y":[["233.01642717412918","65.63785701582992"]]}	{"answers":[null]}	1
754	images/501_28859.JPEG	 cloak	{"x":[["95","9"]],"y":[["92","11"]]}	{"answers":[null]}	1
797	images/825_40894.JPEG	 stone wall	{"x":[["72","118"]],"y":[["75.1304951684997","124.26099033699941"]]}	{"answers":[null]}	1
793	images/825_45831.JPEG	 stone wall	{"x":[["2","67"]],"y":[["2","72"]]}	{"answers":[null]}	1
753	images/501_20389.JPEG	 cloak	{"x":[["67","131"]],"y":[["67","133"]]}	{"answers":[null]}	1
805	images/921_12436.JPEG	 book jacket	{"x":[["20","4"]],"y":[["24","0"]]}	{"answers":[null]}	1
780	images/825_37086.JPEG	 stone wall	{"x":[["81","79"]],"y":[["84","82"]]}	{"answers":[null]}	1
732	images/344_7950.JPEG	 hippopotamus	{"x":[["101","120"]],"y":[["101","113"]]}	{"answers":[null]}	1
790	images/825_33258.JPEG	 stone wall	{"x":[["185","75"]],"y":[["181.8695048315003","81.26099033699941"]]}	{"answers":[null]}	1
804	images/921_24266.JPEG	 book jacket	{"x":[["126.5","60"]],"y":[["125.5","60"]]}	{"answers":[null]}	1
721	images/389_14504.JPEG	 barracouta	{"x":[["175.5","97"]],"y":[["174.5","97"]]}	{"answers":[null]}	1
747	images/344_43959.JPEG	 hippopotamus	{"x":[["153.5","97"]],"y":[["146.5","97"]]}	{"answers":[null]}	1
798	images/825_38214.JPEG	 stone wall	{"x":[["8","110"]],"y":[["9","110"]]}	{"answers":[null]}	1
737	images/344_30132.JPEG	 hippopotamus	{"x":[["44","80"]],"y":[["43","79"]]}	{"answers":[null]}	1
771	images/501_7535.JPEG	 cloak	{"x":[["178","129"]],"y":[["178","123"]]}	{"answers":[null]}	1
761	images/501_40474.JPEG	 cloak	\N	{"answers":[null]}	1
811	images/921_6693.JPEG	 book jacket	\N	\N	0
812	images/921_14470.JPEG	 book jacket	\N	\N	0
816	images/921_9029.JPEG	 book jacket	\N	\N	0
814	images/921_11936.JPEG	 book jacket	{"x":[["66","27"]],"y":[["72","27"]]}	{"answers":[null]}	1
820	images/921_47554.JPEG	 book jacket	\N	\N	0
844	images/826_40519.JPEG	 stopwatch	{"x":[["NaN","NaN"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
824	images/921_33039.JPEG	 book jacket	\N	\N	0
825	images/921_42608.JPEG	 book jacket	\N	\N	0
826	images/826_25253.JPEG	 stopwatch	\N	\N	0
854	images/806_47500.JPEG	 sock	{"x":[["202.79998779296875","161.8000030517578"]],"y":[["202.79998779296875","162.8000030517578"]]}	{"answers":[null]}	1
831	images/826_40335.JPEG	 stopwatch	\N	\N	0
845	images/826_6271.JPEG	 stopwatch	\N	{"answers":[null]}	1
834	images/826_15149.JPEG	 stopwatch	{"x":[["122","134.8000030517578"]],"y":[["121","134.8000030517578"]]}	{"answers":[null]}	1
838	images/826_17281.JPEG	 stopwatch	\N	\N	0
842	images/826_42555.JPEG	 stopwatch	\N	\N	0
847	images/826_24505.JPEG	 stopwatch	\N	\N	0
855	images/806_47138.JPEG	 sock	\N	\N	0
857	images/806_40982.JPEG	 sock	\N	\N	0
858	images/806_38591.JPEG	 sock	\N	\N	0
859	images/806_46280.JPEG	 sock	\N	\N	0
861	images/806_11675.JPEG	 sock	\N	\N	0
863	images/806_16114.JPEG	 sock	\N	\N	0
865	images/806_3300.JPEG	 sock	\N	\N	0
866	images/806_26738.JPEG	 sock	\N	\N	0
869	images/806_30898.JPEG	 sock	\N	\N	0
872	images/806_24291.JPEG	 sock	\N	\N	0
877	images/545_6872.JPEG	 electric fan	\N	\N	0
878	images/545_41046.JPEG	 electric fan	\N	\N	0
879	images/545_31712.JPEG	 electric fan	\N	\N	0
883	images/545_9987.JPEG	 electric fan	\N	\N	0
885	images/545_2180.JPEG	 electric fan	\N	\N	0
886	images/545_32870.JPEG	 electric fan	\N	\N	0
887	images/545_9659.JPEG	 electric fan	\N	\N	0
888	images/545_15115.JPEG	 electric fan	\N	\N	0
889	images/545_48972.JPEG	 electric fan	\N	\N	0
892	images/545_5377.JPEG	 electric fan	\N	\N	0
893	images/545_12391.JPEG	 electric fan	\N	\N	0
899	images/545_33044.JPEG	 electric fan	\N	\N	0
903	images/277_1043.JPEG	 red fox	\N	\N	0
904	images/277_14024.JPEG	 red fox	\N	\N	0
905	images/277_43049.JPEG	 red fox	\N	\N	0
906	images/277_47962.JPEG	 red fox	\N	\N	0
907	images/277_28220.JPEG	 red fox	\N	\N	0
908	images/277_46645.JPEG	 red fox	\N	\N	0
910	images/277_22312.JPEG	 red fox	\N	\N	0
849	images/826_49121.JPEG	 stopwatch	{"x":[["146","99"]],"y":[["149","98"]]}	{"answers":[null]}	1
835	images/826_34802.JPEG	 stopwatch	{"x":[["126","77.80000305175781"]],"y":[["126","78.80000305175781"]]}	{"answers":[null]}	1
871	images/806_41972.JPEG	 sock	{"x":[["135","11"]],"y":[["133","11"]]}	{"answers":[null]}	1
828	images/826_19726.JPEG	 stopwatch	{"x":[["189","83"]],"y":[["187","83"]]}	{"answers":[null]}	1
822	images/921_6381.JPEG	 book jacket	\N	{"answers":[null]}	1
848	images/826_43026.JPEG	 stopwatch	{"x":[["182.60000610351562","68.5999984741211"]],"y":[["181.60000610351562","68.5999984741211"]]}	{"answers":[null]}	1
813	images/921_17278.JPEG	 book jacket	\N	{"answers":[null]}	1
819	images/921_49939.JPEG	 book jacket	{"x":[["16","250"]],"y":[["20","250"]]}	{"answers":[null]}	1
850	images/826_38669.JPEG	 stopwatch	{"x":[["107","52"]],"y":[["105","51"]]}	{"answers":[null]}	1
864	images/806_13608.JPEG	 sock	{"x":[["218","22"]],"y":[["219","21"]]}	{"answers":[null]}	1
900	images/545_14525.JPEG	 electric fan	{"x":[["87","42"]],"y":[["88","45"]]}	{"answers":[null]}	1
846	images/826_35977.JPEG	 stopwatch	{"x":[["116","76"]],"y":[["115","76"]]}	{"answers":[null]}	1
890	images/545_39269.JPEG	 electric fan	{"x":[["133","71"]],"y":[["131","71"]]}	{"answers":[null]}	1
911	images/277_30854.JPEG	 red fox	{"x":[["161","122"]],"y":[["160","122"]]}	{"answers":[null]}	1
868	images/806_2532.JPEG	 sock	{"x":[["124","57"]],"y":[["124","58"]]}	{"answers":[null]}	1
841	images/826_4879.JPEG	 stopwatch	{"x":[["99","133"]],"y":[["101.01143519896442","126.29521600345194"]]}	{"answers":[null]}	1
853	images/806_11972.JPEG	 sock	{"x":[["10","57"]],"y":[["12","57"]]}	{"answers":[null]}	1
827	images/826_3620.JPEG	 stopwatch	{"x":[["101","71"]],"y":[["98","72"]]}	{"answers":[null]}	1
897	images/545_1616.JPEG	 electric fan	{"x":[["117.5","49"]],"y":[["112.5","49"]]}	{"answers":[null]}	1
901	images/277_32811.JPEG	 red fox	{"x":[["162.5","125"]],"y":[["160.5","126"]]}	{"answers":[null]}	1
875	images/806_47898.JPEG	 sock	{"x":[["74","107"]],"y":[["78","107"]]}	{"answers":[null]}	1
896	images/545_13585.JPEG	 electric fan	{"x":[["96","133"]],"y":[["98","133"]]}	{"answers":[null]}	1
815	images/921_42434.JPEG	 book jacket	{"x":[["16","22"]],"y":[["16","27"]]}	{"answers":[null]}	1
817	images/921_44785.JPEG	 book jacket	{"x":[["44","4"]],"y":[["44","9"]]}	{"answers":[null]}	1
843	images/826_7425.JPEG	 stopwatch	{"x":[["189","59"]],"y":[["189","62"]]}	{"answers":[null]}	1
851	images/806_37627.JPEG	 sock	{"x":[["109","90"]],"y":[["114","88"]]}	{"answers":[null]}	1
830	images/826_15927.JPEG	 stopwatch	{"x":[["74","100"]],"y":[["75","101"]]}	{"answers":[null]}	1
912	images/277_17682.JPEG	 red fox	\N	\N	0
913	images/277_15276.JPEG	 red fox	\N	\N	0
914	images/277_34917.JPEG	 red fox	\N	\N	0
988	images/22_15520.JPEG	 bald eagle	{"x":[["166","15"]],"y":[["168","15"]]}	{"answers":[null]}	1
916	images/277_2063.JPEG	 red fox	\N	\N	0
1014	images/729_28017.JPEG	 plate rack	{"x":[["94","38"]],"y":[["87","38"]]}	{"answers":[null]}	1
919	images/277_14692.JPEG	 red fox	\N	\N	0
922	images/277_26849.JPEG	 red fox	\N	\N	0
1011	images/729_33498.JPEG	 plate rack	{"x":[["84.59999084472656","69"]],"y":[["84.59999084472656","70"]]}	{"answers":[null]}	1
926	images/498_20303.JPEG	 cinema	\N	\N	0
953	images/963_17244.JPEG	 pizza	{"x":[["146.59999084472656","51"]],"y":[["146.59999084472656","58"]]}	{"answers":[null]}	1
933	images/498_19617.JPEG	 cinema	{"x":[["11.5","58"]],"y":[["13.5","58"]]}	{"answers":[null]}	1
932	images/498_26158.JPEG	 cinema	\N	\N	0
950	images/498_35142.JPEG	 cinema	{"x":[["93.79998779296875","6.8000030517578125"]],"y":[["93.79998779296875","10.800003051757812"]]}	{"answers":[null]}	1
937	images/498_25466.JPEG	 cinema	\N	\N	0
961	images/963_38941.JPEG	 pizza	{"x":[["22","201.8000030517578"]],"y":[["29","201.8000030517578"]]}	{"answers":[null]}	1
943	images/498_37651.JPEG	 cinema	\N	\N	0
945	images/498_17001.JPEG	 cinema	\N	\N	0
924	images/277_16228.JPEG	 red fox	\N	{"answers":[null]}	1
947	images/498_21486.JPEG	 cinema	\N	\N	0
949	images/498_24757.JPEG	 cinema	\N	\N	0
951	images/963_29990.JPEG	 pizza	\N	\N	0
970	images/963_29599.JPEG	 pizza	\N	{"answers":[null]}	1
956	images/963_42369.JPEG	 pizza	\N	\N	0
958	images/963_2252.JPEG	 pizza	\N	\N	0
960	images/963_49170.JPEG	 pizza	\N	\N	0
962	images/963_47502.JPEG	 pizza	\N	\N	0
1001	images/729_24135.JPEG	 plate rack	\N	{"answers":[null]}	1
959	images/963_8776.JPEG	 pizza	{"x":[["224","67"]],"y":[["217.53846153846155","64.3076923076923"]]}	{"answers":[null]}	1
965	images/963_20760.JPEG	 pizza	\N	\N	0
969	images/963_39901.JPEG	 pizza	\N	\N	0
972	images/963_33812.JPEG	 pizza	\N	\N	0
974	images/963_17412.JPEG	 pizza	\N	\N	0
978	images/22_33763.JPEG	 bald eagle	\N	\N	0
979	images/22_20980.JPEG	 bald eagle	\N	\N	0
981	images/22_45037.JPEG	 bald eagle	\N	\N	0
983	images/22_5516.JPEG	 bald eagle	\N	\N	0
986	images/22_28111.JPEG	 bald eagle	\N	\N	0
987	images/22_39942.JPEG	 bald eagle	\N	\N	0
990	images/22_6049.JPEG	 bald eagle	\N	\N	0
993	images/22_5987.JPEG	 bald eagle	\N	\N	0
994	images/22_1231.JPEG	 bald eagle	\N	\N	0
995	images/22_43483.JPEG	 bald eagle	\N	\N	0
998	images/22_31830.JPEG	 bald eagle	\N	\N	0
1003	images/729_6755.JPEG	 plate rack	\N	\N	0
1004	images/729_38121.JPEG	 plate rack	\N	\N	0
1005	images/729_31742.JPEG	 plate rack	\N	\N	0
1007	images/729_14497.JPEG	 plate rack	\N	\N	0
1010	images/729_35657.JPEG	 plate rack	\N	\N	0
999	images/22_20278.JPEG	 bald eagle	{"x":[["114","91"]],"y":[["114","93"]]}	{"answers":[null]}	1
939	images/498_1667.JPEG	 cinema	{"x":[["123","3"]],"y":[["123","7"]]}	{"answers":[null]}	1
936	images/498_16880.JPEG	 cinema	{"x":[["6","68"]],"y":[["10","68"]]}	{"answers":[null]}	1
954	images/963_39268.JPEG	 pizza	{"x":[["57.5","110"]],"y":[["57.941726104299384","106.02446506130552"]]}	{"answers":[null]}	1
928	images/498_18692.JPEG	 cinema	{"x":[["22","156"]],"y":[["23","156"]]}	{"answers":[null]}	1
934	images/498_20050.JPEG	 cinema	{"x":[["149","112"]],"y":[["150","112"]]}	{"answers":[null]}	1
971	images/963_17333.JPEG	 pizza	{"x":[["93","82"]],"y":[["93","84"]]}	{"answers":[null]}	1
918	images/277_35562.JPEG	 red fox	{"x":[["86","103"]],"y":[["86","106"]]}	{"answers":[null]}	1
991	images/22_16445.JPEG	 bald eagle	{"x":[["20","76"]],"y":[["20","73"]]}	{"answers":[null]}	1
1008	images/729_8522.JPEG	 plate rack	{"x":[["35","143"]],"y":[["40","142"]]}	{"answers":[null]}	1
923	images/277_731.JPEG	 red fox	{"x":[["188","47"]],"y":[["188","49"]]}	{"answers":[null]}	1
921	images/277_23001.JPEG	 red fox	{"x":[["111","72"]],"y":[["116","70"]]}	{"answers":[null]}	1
973	images/963_40354.JPEG	 pizza	{"x":[["134","46"]],"y":[["134","47"]]}	{"answers":[null]}	1
996	images/22_36288.JPEG	 bald eagle	{"x":[["113","86"]],"y":[["116","86"]]}	{"answers":[null]}	1
977	images/22_18179.JPEG	 bald eagle	{"x":[["183","153"]],"y":[["189","153"]]}	{"answers":[null]}	1
942	images/498_44326.JPEG	 cinema	{"x":[["146.5","31"]],"y":[["146.5","38"]]}	{"answers":[null]}	1
927	images/498_12160.JPEG	 cinema	{"x":[["179.5","50"]],"y":[["179.5","51"]]}	{"answers":[null]}	1
955	images/963_24508.JPEG	 pizza	{"x":[["76.5","61"]],"y":[["74.5","61"]]}	{"answers":[null]}	1
920	images/277_36491.JPEG	 red fox	{"x":[["158.5","131"]],"y":[["157.5","133"]]}	{"answers":[null]}	1
980	images/22_16185.JPEG	 bald eagle	{"x":[["61","125"]],"y":[["60","125"]]}	{"answers":[null]}	1
967	images/963_41341.JPEG	 pizza	{"x":[["155","26"]],"y":[["155","27"]]}	{"answers":[null]}	1
948	images/498_27394.JPEG	 cinema	{"x":[["52","74"]],"y":[["59","74"]]}	{"answers":[null]}	1
929	images/498_29187.JPEG	 cinema	{"x":[["74","73"]],"y":[["75","73"]]}	{"answers":[null]}	1
1113	images/379_33369.JPEG	 howler monkey	{"x":[["92","137"]],"y":[["91","137"]]}	{"answers":[null]}	1
1016	images/729_11687.JPEG	 plate rack	\N	\N	0
1053	images/721_46717.JPEG	 pillow	{"x":[["105.59999084472656","36"]],"y":[["112.59999084472656","36"]]}	{"answers":[null]}	1
1021	images/729_27495.JPEG	 plate rack	\N	\N	0
1023	images/729_24463.JPEG	 plate rack	\N	\N	0
1059	images/721_49111.JPEG	 pillow	{"x":[["14.5","34"]],"y":[["16.5","34"]]}	{"answers":[null]}	1
1025	images/729_18768.JPEG	 plate rack	\N	\N	0
1080	images/801_20383.JPEG	 snorkel	{"x":[["222","149.79999542236328"]],"y":[["224","146.79999542236328"]]}	{"answers":[null]}	1
1027	images/634_22861.JPEG	 lumbermill	\N	\N	0
1109	images/379_13940.JPEG	 howler monkey	{"x":[["100","109.80000305175781"]],"y":[["106.79099750101733","111.49775242701214"]]}	{"answers":[null]}	1
1029	images/634_14561.JPEG	 lumbermill	\N	\N	0
1031	images/634_20984.JPEG	 lumbermill	\N	\N	0
1033	images/634_29591.JPEG	 lumbermill	\N	\N	0
1034	images/634_34468.JPEG	 lumbermill	\N	\N	0
1036	images/634_18240.JPEG	 lumbermill	\N	\N	0
1038	images/634_8234.JPEG	 lumbermill	\N	\N	0
1041	images/634_46264.JPEG	 lumbermill	\N	\N	0
1044	images/634_36216.JPEG	 lumbermill	\N	\N	0
1061	images/721_31818.JPEG	 pillow	\N	{"answers":[null]}	1
1046	images/634_24240.JPEG	 lumbermill	\N	\N	0
1079	images/801_26060.JPEG	 snorkel	{"x":[["121","94.5999984741211"]],"y":[["120.303473966853","101.56525880559101"]]}	{"answers":[null]}	1
1043	images/634_14133.JPEG	 lumbermill	{"x":[["68","67.20000076293945"]],"y":[["72","67.20000076293945"]]}	{"answers":[null]}	1
1052	images/721_13236.JPEG	 pillow	\N	\N	0
1030	images/634_13419.JPEG	 lumbermill	{"x":[["81","146.79999923706055"]],"y":[["81","153.79999923706055"]]}	{"answers":[null]}	1
1055	images/721_7113.JPEG	 pillow	\N	\N	0
1056	images/721_22806.JPEG	 pillow	\N	\N	0
1035	images/634_15009.JPEG	 lumbermill	{"x":[["17","150.79999923706055"]],"y":[["23","150.79999923706055"]]}	{"answers":[null]}	1
1042	images/634_19800.JPEG	 lumbermill	{"x":[["131","122.19999694824219"]],"y":[["131","124.19999694824219"]]}	{"answers":[null]}	1
1063	images/721_29665.JPEG	 pillow	\N	\N	0
1066	images/721_16430.JPEG	 pillow	\N	\N	0
1068	images/721_21163.JPEG	 pillow	\N	\N	0
1073	images/721_24219.JPEG	 pillow	\N	\N	0
1074	images/721_19610.JPEG	 pillow	\N	\N	0
1075	images/721_49075.JPEG	 pillow	\N	\N	0
1076	images/801_7130.JPEG	 snorkel	\N	\N	0
1077	images/801_43998.JPEG	 snorkel	\N	\N	0
1078	images/801_46763.JPEG	 snorkel	\N	\N	0
1081	images/801_29422.JPEG	 snorkel	\N	\N	0
1082	images/801_36321.JPEG	 snorkel	\N	\N	0
1083	images/801_9137.JPEG	 snorkel	\N	\N	0
1084	images/801_15271.JPEG	 snorkel	\N	\N	0
1089	images/801_18837.JPEG	 snorkel	\N	\N	0
1093	images/801_16907.JPEG	 snorkel	\N	\N	0
1094	images/801_26779.JPEG	 snorkel	\N	\N	0
1095	images/801_38638.JPEG	 snorkel	\N	\N	0
1097	images/801_13208.JPEG	 snorkel	\N	\N	0
1098	images/801_93.JPEG	 snorkel	\N	\N	0
1100	images/801_41922.JPEG	 snorkel	\N	\N	0
1107	images/379_26629.JPEG	 howler monkey	\N	\N	0
1116	images/379_7499.JPEG	 howler monkey	\N	\N	0
1071	images/721_44015.JPEG	 pillow	{"x":[["222","26"]],"y":[["218.0776772972363","26.784464540552737"]]}	{"answers":[null]}	1
1112	images/379_22477.JPEG	 howler monkey	{"x":[["125","55"]],"y":[["122","56"]]}	{"answers":[null]}	1
1114	images/379_147.JPEG	 howler monkey	{"x":[["147","19"]],"y":[["147","21"]]}	{"answers":[null]}	1
1022	images/729_13457.JPEG	 plate rack	{"x":[["154","107"]],"y":[["157","107"]]}	{"answers":[null]}	1
1115	images/379_40239.JPEG	 howler monkey	{"x":[["166","94"]],"y":[["162","94"]]}	{"answers":[null]}	1
1018	images/729_2339.JPEG	 plate rack	{"x":[["29","47"]],"y":[["29","49"]]}	{"answers":[null]}	1
1111	images/379_28527.JPEG	 howler monkey	{"x":[["76","52"]],"y":[["75","52"]]}	{"answers":[null]}	1
1099	images/801_11778.JPEG	 snorkel	{"x":[["84","4"]],"y":[["85","3"]]}	{"answers":[null]}	1
1106	images/379_19233.JPEG	 howler monkey	{"x":[["69","75"]],"y":[["69","76"]]}	{"answers":[null]}	1
1090	images/801_48352.JPEG	 snorkel	{"x":[["122","57"]],"y":[["122","58"]]}	{"answers":[null]}	1
1065	images/721_33502.JPEG	 pillow	{"x":[["23","41"]],"y":[["23","48"]]}	{"answers":[null]}	1
1051	images/721_4231.JPEG	 pillow	{"x":[["222","14"]],"y":[["219","16"]]}	{"answers":[null]}	1
1085	images/801_26186.JPEG	 snorkel	{"x":[["105","14"]],"y":[["105","19"]]}	{"answers":[null]}	1
1096	images/801_14584.JPEG	 snorkel	{"x":[["112.5","103"]],"y":[["112.5","104"]]}	{"answers":[null]}	1
1069	images/721_31018.JPEG	 pillow	{"x":[["237","16"]],"y":[["236","15"]]}	{"answers":[null]}	1
1067	images/721_39220.JPEG	 pillow	{"x":[["250","17"]],"y":[["248","18"]]}	{"answers":[null]}	1
1040	images/634_38868.JPEG	 lumbermill	{"x":[["149","157"]],"y":[["149","161"]]}	{"answers":[null]}	1
1108	images/379_39510.JPEG	 howler monkey	{"x":[["125","94"]],"y":[["124","93"]]}	{"answers":[null]}	1
1092	images/801_28283.JPEG	 snorkel	{"x":[["121","80"]],"y":[["120","80"]]}	{"answers":[null]}	1
1037	images/634_5842.JPEG	 lumbermill	\N	{"answers":[null]}	1
1070	images/721_40829.JPEG	 pillow	{"x":[["207","10"]],"y":[["208","16"]]}	{"answers":[null]}	1
1117	images/379_47886.JPEG	 howler monkey	\N	\N	0
1175	images/876_32751.JPEG	 tub	{"x":[["244","111"]],"y":[["244","113"]]}	{"answers":[null]}	1
487	images/485_31710.JPEG	 CD player	{"x":[["NaN","NaN"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
1121	images/379_41853.JPEG	 howler monkey	\N	\N	0
1194	images/470_32200.JPEG	 candle	{"x":[["100.59999084472656","182.5999984741211"]],"y":[["100.59999084472656","175.5999984741211"]]}	{"answers":[null]}	1
1213	images/819_2441.JPEG	 stage	{"x":[["7.5999908447265625","247"]],"y":[["13.599990844726562","247"]]}	{"answers":[null]}	1
1127	images/667_2620.JPEG	 mortarboard	\N	\N	0
1128	images/667_30381.JPEG	 mortarboard	\N	\N	0
1129	images/667_11120.JPEG	 mortarboard	\N	\N	0
1134	images/667_26470.JPEG	 mortarboard	{"x":[["137.59999084472656","4"]],"y":[["138.59999084472656","4"]]}	{"answers":[null]}	1
1196	images/470_11320.JPEG	 candle	{"x":[["54","123.79999542236328"]],"y":[["53","125.79999542236328"]]}	{"answers":[null]}	1
1138	images/667_12914.JPEG	 mortarboard	\N	\N	0
1167	images/876_28957.JPEG	 tub	{"x":[["22","137.8000030517578"]],"y":[["22","144.8000030517578"]]}	{"answers":[null]}	1
1188	images/470_8803.JPEG	 candle	{"x":[["158","169.8000030517578"]],"y":[["157","171.8000030517578"]]}	{"answers":[null]}	1
1141	images/667_9516.JPEG	 mortarboard	\N	\N	0
1143	images/667_42272.JPEG	 mortarboard	\N	\N	0
1152	images/876_32566.JPEG	 tub	{"x":[["56","156.1999969482422"]],"y":[["57","156.1999969482422"]]}	{"answers":[null]}	1
1145	images/667_46604.JPEG	 mortarboard	\N	\N	0
1146	images/667_23980.JPEG	 mortarboard	\N	\N	0
1153	images/876_23591.JPEG	 tub	\N	\N	0
1155	images/876_12819.JPEG	 tub	\N	\N	0
1157	images/876_30477.JPEG	 tub	\N	\N	0
1158	images/876_18801.JPEG	 tub	\N	\N	0
1168	images/876_12663.JPEG	 tub	\N	\N	0
1171	images/876_46642.JPEG	 tub	\N	\N	0
1172	images/876_43320.JPEG	 tub	\N	\N	0
1173	images/876_45224.JPEG	 tub	\N	\N	0
1180	images/470_33125.JPEG	 candle	\N	\N	0
1191	images/470_19805.JPEG	 candle	\N	\N	0
1192	images/470_20620.JPEG	 candle	\N	\N	0
1198	images/470_41681.JPEG	 candle	\N	\N	0
1200	images/470_46589.JPEG	 candle	\N	\N	0
1204	images/819_18640.JPEG	 stage	\N	\N	0
1207	images/819_14759.JPEG	 stage	\N	\N	0
1215	images/819_29607.JPEG	 stage	\N	\N	0
1216	images/819_45509.JPEG	 stage	\N	\N	0
1220	images/819_7756.JPEG	 stage	\N	\N	0
1166	images/876_26027.JPEG	 tub	{"x":[["252","193"]],"y":[["248.00615858717836","192.7781199215099"]]}	{"answers":[null]}	1
1131	images/667_13951.JPEG	 mortarboard	{"x":[["87","6"]],"y":[["86","6"]]}	{"answers":[null]}	1
1183	images/470_40101.JPEG	 candle	{"x":[["117","157"]],"y":[["117","156"]]}	{"answers":[null]}	1
1211	images/819_45388.JPEG	 stage	{"x":[["76","249"]],"y":[["76","248"]]}	{"answers":[null]}	1
1160	images/876_45.JPEG	 tub	\N	{"answers":[null]}	1
1130	images/667_33830.JPEG	 mortarboard	{"x":[["161","63"]],"y":[["160","62"]]}	{"answers":[null]}	1
1209	images/819_22750.JPEG	 stage	\N	{"answers":[null]}	1
1174	images/876_21578.JPEG	 tub	{"x":[["4","79"]],"y":[["5","79"]]}	{"answers":[null]}	1
1181	images/470_48518.JPEG	 candle	{"x":[["46","84"]],"y":[["48.82842712474619","86.82842712474618"]]}	{"answers":[null]}	1
1214	images/819_16630.JPEG	 stage	\N	{"answers":[null]}	1
1201	images/819_10595.JPEG	 stage	\N	{"answers":[null]}	1
1203	images/819_17680.JPEG	 stage	{"x":[["45","251"]],"y":[["46","250"]]}	{"answers":[null]}	1
1197	images/470_39694.JPEG	 candle	{"x":[["128","110"]],"y":[["128","114"]]}	{"answers":[null]}	1
1164	images/876_45548.JPEG	 tub	{"x":[["131","99"]],"y":[["133","99"]]}	{"answers":[null]}	1
1162	images/876_9665.JPEG	 tub	{"x":[["223","138"]],"y":[["225","138"]]}	{"answers":[null]}	1
1132	images/667_47310.JPEG	 mortarboard	\N	{"answers":[null]}	1
1163	images/876_12455.JPEG	 tub	{"x":[["11","26"]],"y":[["14","26"]]}	{"answers":[null]}	1
1142	images/667_11363.JPEG	 mortarboard	{"x":[["46","135"]],"y":[["49","136"]]}	{"answers":[null]}	1
1135	images/667_39085.JPEG	 mortarboard	{"x":[["194","53"]],"y":[["195","53"]]}	{"answers":[null]}	1
1179	images/470_9128.JPEG	 candle	{"x":[["126","159"]],"y":[["126","164"]]}	{"answers":[null]}	1
1148	images/667_38775.JPEG	 mortarboard	{"x":[["5","14"]],"y":[["5","15"]]}	{"answers":[null]}	1
1154	images/876_19324.JPEG	 tub	{"x":[["122","197"]],"y":[["122","198"]]}	{"answers":[null]}	1
1210	images/819_8678.JPEG	 stage	{"x":[["28","164"]],"y":[["35","164"]]}	{"answers":[null]}	1
1187	images/470_4301.JPEG	 candle	{"x":[["108","80"]],"y":[["107","86"]]}	{"answers":[null]}	1
1199	images/470_40651.JPEG	 candle	{"x":[["28","80"]],"y":[["29","80"]]}	{"answers":[null]}	1
1165	images/876_15899.JPEG	 tub	{"x":[["90.5","127"]],"y":[["95.5","127"]]}	{"answers":[null]}	1
1125	images/379_1808.JPEG	 howler monkey	{"x":[["114.5","87"]],"y":[["115.5","87"]]}	{"answers":[null]}	1
1205	images/819_1727.JPEG	 stage	{"x":[["32.5","43"]],"y":[["37.5","43"]]}	{"answers":[null]}	1
1178	images/470_49860.JPEG	 candle	{"x":[["165.5","80"]],"y":[["167.5","80"]]}	{"answers":[null]}	1
1190	images/470_19202.JPEG	 candle	{"x":[["127","17"]],"y":[["127","24"]]}	{"answers":[null]}	1
1212	images/819_38269.JPEG	 stage	{"x":[["33","6"]],"y":[["34","6"]]}	{"answers":[null]}	1
1276	images/143_27297.JPEG	 oystercatcher	{"x":[["110","107"]],"y":[["110","105"]]}	{"answers":[null]}	1
1223	images/819_39996.JPEG	 stage	\N	\N	0
1224	images/819_2439.JPEG	 stage	\N	\N	0
1275	images/465_31701.JPEG	 bulletproof vest	{"x":[["160","196"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
1307	images/896_5298.JPEG	 washbasin	{"x":[["76.5","109"]],"y":[["76.5","112"]]}	{"answers":[null]}	1
1228	images/206_12537.JPEG	 curly-coated retriever	\N	\N	0
1229	images/206_28009.JPEG	 curly-coated retriever	\N	\N	0
1230	images/206_18033.JPEG	 curly-coated retriever	\N	\N	0
1284	images/143_48507.JPEG	 oystercatcher	{"x":[["126.79998779296875","66.19999694824219"]],"y":[["119.79998779296875","66.19999694824219"]]}	{"answers":[null]}	1
1233	images/206_4078.JPEG	 curly-coated retriever	\N	\N	0
1235	images/206_49975.JPEG	 curly-coated retriever	\N	\N	0
1239	images/206_5029.JPEG	 curly-coated retriever	\N	{"answers":[null]}	1
1296	images/143_5995.JPEG	 oystercatcher	{"x":[["139","157.8000030517578"]],"y":[["138","157.8000030517578"]]}	{"answers":[null]}	1
1240	images/206_9717.JPEG	 curly-coated retriever	\N	\N	0
1241	images/206_17819.JPEG	 curly-coated retriever	\N	\N	0
1242	images/206_41604.JPEG	 curly-coated retriever	\N	\N	0
1245	images/206_34963.JPEG	 curly-coated retriever	\N	\N	0
1246	images/206_626.JPEG	 curly-coated retriever	\N	\N	0
1221	images/819_7408.JPEG	 stage	{"x":[["20","196.20000076293945"]],"y":[["27","196.20000076293945"]]}	{"answers":[null]}	1
1249	images/206_10963.JPEG	 curly-coated retriever	\N	\N	0
1250	images/206_12521.JPEG	 curly-coated retriever	\N	\N	0
1255	images/465_46338.JPEG	 bulletproof vest	\N	\N	0
1256	images/465_49549.JPEG	 bulletproof vest	\N	\N	0
1257	images/465_19806.JPEG	 bulletproof vest	\N	\N	0
1258	images/465_8893.JPEG	 bulletproof vest	\N	\N	0
1261	images/465_7261.JPEG	 bulletproof vest	\N	\N	0
1263	images/465_43680.JPEG	 bulletproof vest	\N	\N	0
1265	images/465_35629.JPEG	 bulletproof vest	\N	\N	0
1267	images/465_14786.JPEG	 bulletproof vest	\N	\N	0
1268	images/465_21480.JPEG	 bulletproof vest	\N	\N	0
1278	images/143_20452.JPEG	 oystercatcher	\N	\N	0
1282	images/143_47687.JPEG	 oystercatcher	\N	\N	0
1286	images/143_44453.JPEG	 oystercatcher	\N	\N	0
1291	images/143_37596.JPEG	 oystercatcher	\N	\N	0
1293	images/143_24036.JPEG	 oystercatcher	\N	\N	0
1297	images/143_5943.JPEG	 oystercatcher	\N	\N	0
1300	images/143_21445.JPEG	 oystercatcher	\N	\N	0
1301	images/896_34769.JPEG	 washbasin	\N	\N	0
1302	images/896_17440.JPEG	 washbasin	\N	\N	0
1303	images/896_21818.JPEG	 washbasin	\N	\N	0
1304	images/896_40699.JPEG	 washbasin	\N	\N	0
1305	images/896_9214.JPEG	 washbasin	\N	\N	0
1306	images/896_37188.JPEG	 washbasin	\N	\N	0
1308	images/896_23738.JPEG	 washbasin	\N	\N	0
1310	images/896_10192.JPEG	 washbasin	\N	\N	0
1315	images/896_1843.JPEG	 washbasin	\N	\N	0
1311	images/896_8077.JPEG	 washbasin	{"x":[["108","228"]],"y":[["109","227"]]}	{"answers":[null]}	1
1285	images/143_29390.JPEG	 oystercatcher	{"x":[["141.60000610351562","87"]],"y":[["142.69889061510514","83.1539042094367"]]}	{"answers":[null]}	1
1279	images/143_36043.JPEG	 oystercatcher	{"x":[["231","83"]],"y":[["227.0776772972363","82.21553545944727"]]}	{"answers":[null]}	1
1266	images/465_26680.JPEG	 bulletproof vest	{"x":[["27","28"]],"y":[["26","28"]]}	{"answers":[null]}	1
1313	images/896_27019.JPEG	 washbasin	{"x":[["38","73"]],"y":[["39","73"]]}	{"answers":[null]}	1
1283	images/143_25661.JPEG	 oystercatcher	{"x":[["183","160"]],"y":[["183","156"]]}	{"answers":[null]}	1
1262	images/465_40274.JPEG	 bulletproof vest	{"x":[["56","23"]],"y":[["56","26"]]}	{"answers":[null]}	1
1236	images/206_31342.JPEG	 curly-coated retriever	{"x":[["174","44"]],"y":[["175","44"]]}	{"answers":[null]}	1
1274	images/465_37828.JPEG	 bulletproof vest	{"x":[["110","79"]],"y":[["109.01005050633883","85.92964645562816"]]}	{"answers":[null]}	1
1281	images/143_39266.JPEG	 oystercatcher	{"x":[["64","155"]],"y":[["64","150"]]}	{"answers":[null]}	1
1232	images/206_24037.JPEG	 curly-coated retriever	{"x":[["70","76"]],"y":[["73","76"]]}	{"answers":[null]}	1
1294	images/143_6596.JPEG	 oystercatcher	{"x":[["111","123"]],"y":[["111.30406056993415","116.00660689151458"]]}	{"answers":[null]}	1
1264	images/465_5379.JPEG	 bulletproof vest	{"x":[["52","122"]],"y":[["58","122"]]}	{"answers":[null]}	1
1277	images/143_41537.JPEG	 oystercatcher	{"x":[["59.5","109"]],"y":[["57.5","109"]]}	{"answers":[null]}	1
1244	images/206_38014.JPEG	 curly-coated retriever	{"x":[["140.5","63"]],"y":[["140.5","62"]]}	{"answers":[null]}	1
1254	images/465_29098.JPEG	 bulletproof vest	{"x":[["105","70"]],"y":[["105","72"]]}	{"answers":[null]}	1
1271	images/465_39341.JPEG	 bulletproof vest	{"x":[["8","130"]],"y":[["12","130"]]}	{"answers":[null]}	1
1259	images/465_34778.JPEG	 bulletproof vest	{"x":[["177","14"]],"y":[["174","17"]]}	{"answers":[null]}	1
1312	images/896_7141.JPEG	 washbasin	{"x":[["121","117"]],"y":[["121","119"]]}	{"answers":[null]}	1
1287	images/143_24641.JPEG	 oystercatcher	{"x":[["144","125"]],"y":[["143","125"]]}	{"answers":[null]}	1
1292	images/143_32766.JPEG	 oystercatcher	{"x":[["193","94"]],"y":[["199","96"]]}	{"answers":[null]}	1
1225	images/819_26508.JPEG	 stage	{"x":[["39","41"]],"y":[["44","41"]]}	{"answers":[null]}	1
1383	images/759_16320.JPEG	 reflex camera	{"x":[["89","56"]],"y":[["88","56"]]}	{"answers":[null]}	1
1394	images/759_33336.JPEG	 reflex camera	{"x":[["68","93"]],"y":[["68","92"]]}	{"answers":[null]}	1
1367	images/910_38136.JPEG	 wooden spoon	{"x":[["157.59999084472656","149"]],"y":[["157.59999084472656","156"]]}	{"answers":[null]}	1
1322	images/896_46780.JPEG	 washbasin	{"x":[["158.5","74"]],"y":[["157.5","74"]]}	{"answers":[null]}	1
1403	images/890_25823.JPEG	 volleyball	{"x":[["29.79998779296875","90.19999694824219"]],"y":[["32.79998779296875","94.19999694824219"]]}	{"answers":[null]}	1
1327	images/853_8208.JPEG	 thatch	\N	\N	0
1349	images/853_508.JPEG	 thatch	{"x":[["130","82.79999542236328"]],"y":[["131","82.79999542236328"]]}	{"answers":[null]}	1
1334	images/853_10597.JPEG	 thatch	\N	\N	0
1339	images/853_29212.JPEG	 thatch	{"x":[["79","177.8000030517578"]],"y":[["86","177.8000030517578"]]}	{"answers":[null]}	1
1337	images/853_11195.JPEG	 thatch	\N	\N	0
1338	images/853_482.JPEG	 thatch	\N	\N	0
1340	images/853_46827.JPEG	 thatch	\N	\N	0
1347	images/853_395.JPEG	 thatch	{"x":[["99","57.80000305175781"]],"y":[["100","59.80000305175781"]]}	{"answers":[null]}	1
1343	images/853_46121.JPEG	 thatch	\N	\N	0
1361	images/910_36151.JPEG	 wooden spoon	{"x":[["220","7.400001525878906"]],"y":[["215.8","13.000001525878908"]]}	{"answers":[null]}	1
1351	images/910_43938.JPEG	 wooden spoon	\N	\N	0
1358	images/910_2764.JPEG	 wooden spoon	\N	\N	0
1362	images/910_7110.JPEG	 wooden spoon	\N	\N	0
1364	images/910_41079.JPEG	 wooden spoon	\N	\N	0
1366	images/910_39052.JPEG	 wooden spoon	\N	\N	0
1368	images/910_20213.JPEG	 wooden spoon	\N	\N	0
1369	images/910_16342.JPEG	 wooden spoon	\N	\N	0
1370	images/910_37592.JPEG	 wooden spoon	\N	\N	0
1374	images/910_30479.JPEG	 wooden spoon	\N	\N	0
1377	images/759_6647.JPEG	 reflex camera	\N	\N	0
1378	images/759_10782.JPEG	 reflex camera	\N	\N	0
1380	images/759_29789.JPEG	 reflex camera	\N	\N	0
1384	images/759_19313.JPEG	 reflex camera	\N	\N	0
1389	images/759_14400.JPEG	 reflex camera	\N	\N	0
1391	images/759_46067.JPEG	 reflex camera	\N	\N	0
1392	images/759_16999.JPEG	 reflex camera	\N	\N	0
1396	images/759_136.JPEG	 reflex camera	\N	\N	0
1404	images/890_11831.JPEG	 volleyball	\N	\N	0
1406	images/890_35095.JPEG	 volleyball	\N	\N	0
1407	images/890_35702.JPEG	 volleyball	\N	\N	0
1412	images/890_7673.JPEG	 volleyball	\N	\N	0
1414	images/890_45239.JPEG	 volleyball	\N	\N	0
1317	images/896_37703.JPEG	 washbasin	{"x":[["194","94.19999694824219"]],"y":[["193","95.19999694824219"]]}	{"answers":[null]}	1
1325	images/896_35678.JPEG	 washbasin	{"x":[["151","102"]],"y":[["151","103"]]}	{"answers":[null]}	1
1385	images/759_18050.JPEG	 reflex camera	{"x":[["44","113"]],"y":[["47","112"]]}	{"answers":[null]}	1
1350	images/853_9919.JPEG	 thatch	{"x":[["220","173"]],"y":[["216","173"]]}	{"answers":[null]}	1
1352	images/910_44698.JPEG	 wooden spoon	{"x":[["139","147"]],"y":[["140","147"]]}	{"answers":[null]}	1
1353	images/910_7777.JPEG	 wooden spoon	{"x":[["249","58"]],"y":[["246","57"]]}	{"answers":[null]}	1
1328	images/853_16513.JPEG	 thatch	{"x":[["4","210"]],"y":[["4","209"]]}	{"answers":[null]}	1
1344	images/853_39387.JPEG	 thatch	\N	{"answers":[null]}	1
1387	images/759_45627.JPEG	 reflex camera	\N	{"answers":[null]}	1
1342	images/853_5637.JPEG	 thatch	{"x":[["74","193"]],"y":[["74","191"]]}	{"answers":[null]}	1
1381	images/759_9117.JPEG	 reflex camera	{"x":[["82","93"]],"y":[["85.95979797464467","92.43431457505076"]]}	{"answers":[null]}	1
1335	images/853_7991.JPEG	 thatch	{"x":[["131","81"]],"y":[["129","82"]]}	{"answers":[null]}	1
1390	images/759_14679.JPEG	 reflex camera	{"x":[["128","79"]],"y":[["128","78"]]}	{"answers":[null]}	1
1320	images/896_33204.JPEG	 washbasin	{"x":[["130","59"]],"y":[["131.69774937525432","65.79099750101733"]]}	{"answers":[null]}	1
1410	images/890_16683.JPEG	 volleyball	{"x":[["26","23"]],"y":[["26","24"]]}	{"answers":[null]}	1
1379	images/759_43361.JPEG	 reflex camera	{"x":[["79","5"]],"y":[["79","10"]]}	{"answers":[null]}	1
1348	images/853_1136.JPEG	 thatch	{"x":[["101.5","131"]],"y":[["101.5","138"]]}	{"answers":[null]}	1
1399	images/759_47358.JPEG	 reflex camera	{"x":[["96.5","35"]],"y":[["96.5","38"]]}	{"answers":[null]}	1
1346	images/853_45857.JPEG	 thatch	{"x":[["122.5","21"]],"y":[["119.5","21"]]}	{"answers":[null]}	1
1388	images/759_19165.JPEG	 reflex camera	{"x":[["79.5","110"]],"y":[["82.5","110"]]}	{"answers":[null]}	1
1354	images/910_7450.JPEG	 wooden spoon	{"x":[["7.5","43"]],"y":[["8.273020682523926","49.95718614271533"]]}	{"answers":[null]}	1
1375	images/910_38858.JPEG	 wooden spoon	{"x":[["6","68"]],"y":[["8","71"]]}	{"answers":[null]}	1
1363	images/910_12952.JPEG	 wooden spoon	\N	{"answers":[null]}	1
1405	images/890_29183.JPEG	 volleyball	{"x":[["120","173"]],"y":[["119","173"]]}	{"answers":[null]}	1
1324	images/896_41194.JPEG	 washbasin	{"x":[["24","59"]],"y":[["24","58"]]}	{"answers":[null]}	1
1395	images/759_2616.JPEG	 reflex camera	\N	{"answers":[null]}	1
1326	images/853_49311.JPEG	 thatch	{"x":[["228","144"]],"y":[["228","149"]]}	{"answers":[null]}	1
1332	images/853_35517.JPEG	 thatch	{"x":[["23","95"]],"y":[["23","99"]]}	{"answers":[null]}	1
1386	images/759_44919.JPEG	 reflex camera	{"x":[["25","26"]],"y":[["25","29"]]}	{"answers":[null]}	1
1427	images/472_14139.JPEG	 canoe	{"x":[["17","214"]],"y":[["14","216"]]}	{"answers":[null]}	1
1468	images/931_47204.JPEG	 bagel	{"x":[["149.59999084472656","47.599998474121094"]],"y":[["149.59999084472656","42.599998474121094"]]}	{"answers":[null]}	1
1462	images/931_12782.JPEG	 bagel	{"x":[["4.79998779296875","211.8000030517578"]],"y":[["10.068024655916894","216.40953530683743"]]}	{"answers":[null]}	1
1513	images/684_1927.JPEG	 ocarina	{"x":[["106","228.1999969482422"]],"y":[["106","226.1999969482422"]]}	{"answers":[null]}	1
1420	images/890_26600.JPEG	 volleyball	\N	\N	0
1421	images/890_32106.JPEG	 volleyball	\N	\N	0
1422	images/890_24822.JPEG	 volleyball	\N	\N	0
1424	images/890_14420.JPEG	 volleyball	\N	\N	0
1425	images/890_26797.JPEG	 volleyball	\N	\N	0
1426	images/472_19763.JPEG	 canoe	\N	\N	0
1428	images/472_46817.JPEG	 canoe	\N	\N	0
1450	images/472_49568.JPEG	 canoe	\N	{"answers":[null]}	1
1430	images/472_1697.JPEG	 canoe	\N	\N	0
1434	images/472_48569.JPEG	 canoe	\N	\N	0
1443	images/472_9064.JPEG	 canoe	{"x":[["41","152.8000030517578"]],"y":[["46","153.8000030517578"]]}	{"answers":[null]}	1
1500	images/813_19882.JPEG	 spatula	{"x":[["177","173.8000030517578"]],"y":[["170.20900249898267","175.49775242701213"]]}	{"answers":[null]}	1
1439	images/472_20087.JPEG	 canoe	\N	\N	0
1446	images/472_27672.JPEG	 canoe	{"x":[["3","183.79999923706055"]],"y":[["6.882901373576604","189.62435129742545"]]}	{"answers":[null]}	1
1447	images/472_39062.JPEG	 canoe	\N	\N	0
1449	images/472_41283.JPEG	 canoe	\N	\N	0
1452	images/931_39882.JPEG	 bagel	\N	\N	0
1456	images/931_13548.JPEG	 bagel	\N	\N	0
1458	images/931_31987.JPEG	 bagel	\N	\N	0
1461	images/931_15241.JPEG	 bagel	\N	\N	0
1470	images/931_11301.JPEG	 bagel	\N	\N	0
1472	images/931_22182.JPEG	 bagel	\N	\N	0
1476	images/813_24514.JPEG	 spatula	\N	\N	0
1477	images/813_32103.JPEG	 spatula	\N	\N	0
1478	images/813_10428.JPEG	 spatula	\N	\N	0
1479	images/813_7154.JPEG	 spatula	\N	\N	0
1481	images/813_47822.JPEG	 spatula	\N	\N	0
1482	images/813_3703.JPEG	 spatula	\N	\N	0
1485	images/813_31638.JPEG	 spatula	\N	\N	0
1487	images/813_6977.JPEG	 spatula	\N	\N	0
1495	images/813_41405.JPEG	 spatula	\N	\N	0
1496	images/813_9878.JPEG	 spatula	\N	\N	0
1505	images/684_33011.JPEG	 ocarina	\N	\N	0
1508	images/684_45832.JPEG	 ocarina	\N	\N	0
1512	images/684_29515.JPEG	 ocarina	\N	\N	0
1517	images/684_31870.JPEG	 ocarina	\N	\N	0
1518	images/684_8275.JPEG	 ocarina	\N	\N	0
1520	images/684_21925.JPEG	 ocarina	\N	\N	0
1506	images/684_25062.JPEG	 ocarina	{"x":[["114","221"]],"y":[["110","221"]]}	{"answers":[null]}	1
1483	images/813_24366.JPEG	 spatula	{"x":[["130","249"]],"y":[["130.12493900951088","245.00195169565168"]]}	{"answers":[null]}	1
1519	images/684_35913.JPEG	 ocarina	{"x":[["200","55"]],"y":[["202","56"]]}	{"answers":[null]}	1
1431	images/472_21913.JPEG	 canoe	{"x":[["245","190"]],"y":[["246","190"]]}	{"answers":[null]}	1
1490	images/813_48225.JPEG	 spatula	{"x":[["9","105"]],"y":[["11","105"]]}	{"answers":[null]}	1
1473	images/931_37525.JPEG	 bagel	{"x":[["93.60000610351562","77.19999694824219"]],"y":[["92.60000610351562","77.19999694824219"]]}	{"answers":[null]}	1
1455	images/931_3666.JPEG	 bagel	\N	{"answers":[null]}	1
1465	images/931_36517.JPEG	 bagel	{"x":[["127","44"]],"y":[["127","48"]]}	{"answers":[null]}	1
1442	images/472_29095.JPEG	 canoe	{"x":[["154","164"]],"y":[["154","166"]]}	{"answers":[null]}	1
1515	images/684_9574.JPEG	 ocarina	{"x":[["209","62"]],"y":[["209","60"]]}	{"answers":[null]}	1
1467	images/931_33040.JPEG	 bagel	{"x":[["69","70"]],"y":[["68","69"]]}	{"answers":[null]}	1
1489	images/813_26938.JPEG	 spatula	{"x":[["162","3"]],"y":[["166","8"]]}	{"answers":[null]}	1
1516	images/684_19894.JPEG	 ocarina	\N	{"answers":[null]}	1
1501	images/684_45227.JPEG	 ocarina	{"x":[["19","86"]],"y":[["15","91"]]}	{"answers":[null]}	1
1469	images/931_10271.JPEG	 bagel	{"x":[["139","23"]],"y":[["139","27"]]}	{"answers":[null]}	1
1480	images/813_28510.JPEG	 spatula	{"x":[["64","99"]],"y":[["64","106"]]}	{"answers":[null]}	1
1438	images/472_22825.JPEG	 canoe	{"x":[["110","168"]],"y":[["106","168"]]}	{"answers":[null]}	1
1418	images/890_30949.JPEG	 volleyball	{"x":[["165","162"]],"y":[["165","169"]]}	{"answers":[null]}	1
1453	images/931_12730.JPEG	 bagel	{"x":[["163","30"]],"y":[["163","31"]]}	{"answers":[null]}	1
1423	images/890_25733.JPEG	 volleyball	{"x":[["114","86"]],"y":[["113.50127065008463","92.98221089881514"]]}	{"answers":[null]}	1
1466	images/931_13022.JPEG	 bagel	{"x":[["120.5","197"]],"y":[["122.5","196"]]}	{"answers":[null]}	1
1444	images/472_17722.JPEG	 canoe	{"x":[["126","142"]],"y":[["132.94594513699568","142.86824314212447"]]}	{"answers":[null]}	1
1471	images/931_37783.JPEG	 bagel	{"x":[["19","107"]],"y":[["23","107"]]}	{"answers":[null]}	1
1441	images/472_88.JPEG	 canoe	{"x":[["86","126"]],"y":[["87","127"]]}	{"answers":[null]}	1
1451	images/931_38134.JPEG	 bagel	{"x":[["166","19"]],"y":[["170","19"]]}	{"answers":[null]}	1
1436	images/472_35256.JPEG	 canoe	{"x":[["130","153"]],"y":[["136","154"]]}	{"answers":[null]}	1
1497	images/813_28222.JPEG	 spatula	{"x":[["4","18"]],"y":[["10.14526901040069","21.35196491476401"]]}	{"answers":[null]}	1
1524	images/684_26642.JPEG	 ocarina	{"x":[["135","76"]],"y":[["135","77"]]}	{"answers":[null]}	1
1522	images/684_42958.JPEG	 ocarina	\N	\N	0
1525	images/684_12741.JPEG	 ocarina	\N	\N	0
1609	images/325_40418.JPEG	 sulphur butterfly	{"x":[["161.59999084472656","91.5999984741211"]],"y":[["159.59999084472656","91.5999984741211"]]}	{"answers":[null]}	1
1531	images/293_17944.JPEG	 cheetah	\N	\N	0
1533	images/293_31440.JPEG	 cheetah	\N	\N	0
1535	images/293_40644.JPEG	 cheetah	\N	\N	0
1537	images/293_33543.JPEG	 cheetah	\N	\N	0
1552	images/770_13543.JPEG	 running shoe	{"x":[["97.59999084472656","215.39999961853027"]],"y":[["104.59999084472656","215.39999961853027"]]}	{"answers":[null]}	1
1532	images/293_33751.JPEG	 cheetah	{"x":[["68","93.79999542236328"]],"y":[["70","96.79999542236328"]]}	{"answers":[null]}	1
1541	images/293_12546.JPEG	 cheetah	\N	\N	0
1542	images/293_38022.JPEG	 cheetah	\N	\N	0
1605	images/325_43830.JPEG	 sulphur butterfly	{"x":[["158","59.80000305175781"]],"y":[["158","61.80000305175781"]]}	{"answers":[null]}	1
1545	images/293_5239.JPEG	 cheetah	\N	\N	0
1557	images/770_38260.JPEG	 running shoe	{"x":[["14","226.8000030517578"]],"y":[["16","226.8000030517578"]]}	{"answers":[null]}	1
1550	images/293_10024.JPEG	 cheetah	\N	\N	0
1555	images/770_7150.JPEG	 running shoe	\N	\N	0
1558	images/770_23735.JPEG	 running shoe	\N	\N	0
1551	images/770_31490.JPEG	 running shoe	{"x":[["122","40.79999923706055"]],"y":[["117.05025253169417","45.74974670536638"]]}	{"answers":[null]}	1
1563	images/770_15643.JPEG	 running shoe	\N	\N	0
1564	images/770_48411.JPEG	 running shoe	\N	\N	0
1566	images/770_49230.JPEG	 running shoe	\N	\N	0
1568	images/770_47283.JPEG	 running shoe	\N	\N	0
1571	images/770_3570.JPEG	 running shoe	\N	\N	0
1572	images/770_46004.JPEG	 running shoe	\N	\N	0
1574	images/770_4580.JPEG	 running shoe	\N	\N	0
1575	images/770_24959.JPEG	 running shoe	\N	\N	0
1576	images/871_1706.JPEG	 trimaran	\N	\N	0
1580	images/871_9607.JPEG	 trimaran	\N	\N	0
1582	images/871_46358.JPEG	 trimaran	\N	\N	0
1588	images/871_31647.JPEG	 trimaran	\N	\N	0
1591	images/871_44558.JPEG	 trimaran	\N	\N	0
1594	images/871_2869.JPEG	 trimaran	\N	\N	0
1596	images/871_8374.JPEG	 trimaran	\N	\N	0
1597	images/871_5992.JPEG	 trimaran	\N	\N	0
1598	images/871_28473.JPEG	 trimaran	\N	\N	0
1599	images/871_5544.JPEG	 trimaran	\N	\N	0
1603	images/325_45251.JPEG	 sulphur butterfly	\N	\N	0
1607	images/325_47112.JPEG	 sulphur butterfly	\N	\N	0
1608	images/325_31245.JPEG	 sulphur butterfly	\N	\N	0
1613	images/325_44792.JPEG	 sulphur butterfly	\N	\N	0
1614	images/325_9197.JPEG	 sulphur butterfly	\N	\N	0
1615	images/325_20998.JPEG	 sulphur butterfly	\N	\N	0
1619	images/325_5176.JPEG	 sulphur butterfly	\N	\N	0
1621	images/325_24527.JPEG	 sulphur butterfly	\N	\N	0
1547	images/293_25123.JPEG	 cheetah	{"x":[["46","48"]],"y":[["48.11999576001272","51.39199321602035"]]}	{"answers":[null]}	1
1590	images/871_41335.JPEG	 trimaran	{"x":[["86","185"]],"y":[["87","185"]]}	{"answers":[null]}	1
1579	images/871_703.JPEG	 trimaran	{"x":[["98","180"]],"y":[["100.4987801902177","183.1234752377721"]]}	{"answers":[null]}	1
1583	images/871_42138.JPEG	 trimaran	{"x":[["97.60000610351562","202.1999969482422"]],"y":[["97.60000610351562","203.1999969482422"]]}	{"answers":[null]}	1
1610	images/325_38535.JPEG	 sulphur butterfly	{"x":[["78.60000610351562","149.1999969482422"]],"y":[["78.60000610351562","146.1999969482422"]]}	{"answers":[null]}	1
1617	images/325_9768.JPEG	 sulphur butterfly	{"x":[["53","10"]],"y":[["50","11"]]}	{"answers":[null]}	1
1589	images/871_28521.JPEG	 trimaran	{"x":[["14","161"]],"y":[["14","168"]]}	{"answers":[null]}	1
1534	images/293_34116.JPEG	 cheetah	{"x":[["94","79"]],"y":[["94","82"]]}	{"answers":[null]}	1
1527	images/293_30323.JPEG	 cheetah	{"x":[["72","83"]],"y":[["74","88"]]}	{"answers":[null]}	1
1553	images/770_39212.JPEG	 running shoe	{"x":[["120","80"]],"y":[["120","79"]]}	{"answers":[null]}	1
1554	images/770_15113.JPEG	 running shoe	{"x":[["122","94"]],"y":[["122","98"]]}	{"answers":[null]}	1
1523	images/684_12417.JPEG	 ocarina	{"x":[["23","65"]],"y":[["23","68"]]}	{"answers":[null]}	1
1606	images/325_1852.JPEG	 sulphur butterfly	{"x":[["175","124"]],"y":[["175","128"]]}	{"answers":[null]}	1
1528	images/293_22438.JPEG	 cheetah	{"x":[["36","31"]],"y":[["36","33"]]}	{"answers":[null]}	1
1604	images/325_31448.JPEG	 sulphur butterfly	{"x":[["101","96"]],"y":[["101","95"]]}	{"answers":[null]}	1
1538	images/293_19660.JPEG	 cheetah	{"x":[["141.5","93"]],"y":[["140.5","93"]]}	{"answers":[null]}	1
1530	images/293_30640.JPEG	 cheetah	{"x":[["171.5","176"]],"y":[["175.5","176"]]}	{"answers":[null]}	1
1562	images/770_45587.JPEG	 running shoe	{"x":[["8","69"]],"y":[["13.37754895718163","64.51870920234865"]]}	{"answers":[null]}	1
1548	images/293_3465.JPEG	 cheetah	{"x":[["149","92"]],"y":[["146","92"]]}	{"answers":[null]}	1
1565	images/770_13099.JPEG	 running shoe	{"x":[["66","54"]],"y":[["67","54"]]}	{"answers":[null]}	1
1549	images/293_1471.JPEG	 cheetah	{"x":[["18","29"]],"y":[["18","30"]]}	{"answers":[null]}	1
1536	images/293_9799.JPEG	 cheetah	{"x":[["80","12"]],"y":[["80","14"]]}	{"answers":[null]}	1
1556	images/770_37333.JPEG	 running shoe	{"x":[["109","65"]],"y":[["108","68"]]}	{"answers":[null]}	1
1622	images/325_30267.JPEG	 sulphur butterfly	\N	\N	0
1625	images/325_39845.JPEG	 sulphur butterfly	\N	\N	0
1626	images/906_17510.JPEG	 Windsor tie	\N	\N	0
1671	images/590_30362.JPEG	 hand-held computer	{"x":[["46.59999084472656","186.5999984741211"]],"y":[["53.59999084472656","186.5999984741211"]]}	{"answers":[null]}	1
1640	images/906_45173.JPEG	 Windsor tie	{"x":[["150.59999084472656","1"]],"y":[["150.59999084472656","5"]]}	{"answers":[null]}	1
1631	images/906_28443.JPEG	 Windsor tie	\N	\N	0
1632	images/906_46672.JPEG	 Windsor tie	\N	\N	0
1633	images/906_5849.JPEG	 Windsor tie	\N	\N	0
1634	images/906_40373.JPEG	 Windsor tie	\N	\N	0
1639	images/906_41702.JPEG	 Windsor tie	\N	\N	0
1641	images/906_20326.JPEG	 Windsor tie	\N	\N	0
1642	images/906_39761.JPEG	 Windsor tie	\N	\N	0
1637	images/906_7266.JPEG	 Windsor tie	{"x":[["69.5","102"]],"y":[["65.5","102"]]}	{"answers":[null]}	1
1646	images/906_39796.JPEG	 Windsor tie	\N	\N	0
1648	images/906_8305.JPEG	 Windsor tie	\N	\N	0
1649	images/906_3177.JPEG	 Windsor tie	\N	\N	0
1714	images/970_8542.JPEG	 alp	{"x":[["251","65.80000305175781"]],"y":[["247","65.80000305175781"]]}	{"answers":[null]}	1
1636	images/906_39166.JPEG	 Windsor tie	{"x":[["194","12.800003051757812"]],"y":[["194","19.800003051757812"]]}	{"answers":[null]}	1
1624	images/325_25649.JPEG	 sulphur butterfly	\N	{"answers":[null]}	1
1654	images/590_11445.JPEG	 hand-held computer	\N	\N	0
1655	images/590_45768.JPEG	 hand-held computer	\N	\N	0
1656	images/590_49018.JPEG	 hand-held computer	\N	\N	0
1678	images/597_31176.JPEG	 holster	\N	{"answers":[null]}	1
1697	images/597_42100.JPEG	 holster	{"x":[["181","7.8000030517578125"]],"y":[["178","7.8000030517578125"]]}	{"answers":[null]}	1
1627	images/906_21671.JPEG	 Windsor tie	{"x":[["116","44.79999923706055"]],"y":[["120","44.79999923706055"]]}	{"answers":[null]}	1
1664	images/590_12485.JPEG	 hand-held computer	\N	\N	0
1665	images/590_48754.JPEG	 hand-held computer	\N	\N	0
1670	images/590_16811.JPEG	 hand-held computer	\N	\N	0
1672	images/590_13324.JPEG	 hand-held computer	\N	\N	0
1675	images/590_30735.JPEG	 hand-held computer	\N	\N	0
1676	images/597_42956.JPEG	 holster	\N	\N	0
1680	images/597_4735.JPEG	 holster	\N	\N	0
1681	images/597_40822.JPEG	 holster	\N	\N	0
1682	images/597_7517.JPEG	 holster	\N	\N	0
1685	images/597_34477.JPEG	 holster	\N	\N	0
1689	images/597_2241.JPEG	 holster	\N	\N	0
1692	images/597_20871.JPEG	 holster	\N	\N	0
1694	images/597_9807.JPEG	 holster	\N	\N	0
1695	images/597_4375.JPEG	 holster	\N	\N	0
1698	images/597_17003.JPEG	 holster	\N	\N	0
1701	images/970_7046.JPEG	 alp	\N	\N	0
1705	images/970_42214.JPEG	 alp	\N	\N	0
1708	images/970_3942.JPEG	 alp	\N	\N	0
1709	images/970_38107.JPEG	 alp	\N	\N	0
1711	images/970_31112.JPEG	 alp	\N	\N	0
1718	images/970_3749.JPEG	 alp	\N	\N	0
1715	images/970_24718.JPEG	 alp	{"x":[["252","71"]],"y":[["251","70"]]}	{"answers":[null]}	1
1679	images/597_40228.JPEG	 holster	{"x":[["5","83"]],"y":[["9","83"]]}	{"answers":[null]}	1
1713	images/970_28747.JPEG	 alp	{"x":[["7","103"]],"y":[["10","103"]]}	{"answers":[null]}	1
1690	images/597_10295.JPEG	 holster	{"x":[["62","228"]],"y":[["63.48556270541641","231.71390676354105"]]}	{"answers":[null]}	1
1635	images/906_23928.JPEG	 Windsor tie	{"x":[["157","100"]],"y":[["160.2","102.4"]]}	{"answers":[null]}	1
1696	images/597_34311.JPEG	 holster	{"x":[["151","79"]],"y":[["151","80"]]}	{"answers":[null]}	1
1657	images/590_30253.JPEG	 hand-held computer	{"x":[["27","191"]],"y":[["29","189"]]}	{"answers":[null]}	1
1712	images/970_33294.JPEG	 alp	{"x":[["9","96"]],"y":[["12","97"]]}	{"answers":[null]}	1
1623	images/325_29497.JPEG	 sulphur butterfly	{"x":[["70","45"]],"y":[["70","46"]]}	{"answers":[null]}	1
1674	images/590_36846.JPEG	 hand-held computer	{"x":[["60","144"]],"y":[["60","148"]]}	{"answers":[null]}	1
1693	images/597_30526.JPEG	 holster	{"x":[["45","169"]],"y":[["45","174"]]}	{"answers":[null]}	1
1645	images/906_43249.JPEG	 Windsor tie	{"x":[["67","155"]],"y":[["67","156"]]}	{"answers":[null]}	1
1700	images/597_42984.JPEG	 holster	{"x":[["66","137"]],"y":[["68","137"]]}	{"answers":[null]}	1
1667	images/590_14719.JPEG	 hand-held computer	{"x":[["88","95"]],"y":[["88","100"]]}	{"answers":[null]}	1
1684	images/597_14349.JPEG	 holster	{"x":[["106.5","55"]],"y":[["106.5","57"]]}	{"answers":[null]}	1
1659	images/590_14631.JPEG	 hand-held computer	{"x":[["83.5","40"]],"y":[["84.5","40"]]}	{"answers":[null]}	1
1699	images/597_49776.JPEG	 holster	{"x":[["4","162"]],"y":[["8.37286533288097","167.46608166610122"]]}	{"answers":[null]}	1
1704	images/970_36578.JPEG	 alp	{"x":[["7","39"]],"y":[["14","39"]]}	{"answers":[null]}	1
1629	images/906_41975.JPEG	 Windsor tie	\N	{"answers":[null]}	1
1643	images/906_42431.JPEG	 Windsor tie	{"x":[["153","39"]],"y":[["153","40"]]}	{"answers":[null]}	1
1647	images/906_10778.JPEG	 Windsor tie	{"x":[["122","223"]],"y":[["122","230"]]}	{"answers":[null]}	1
1702	images/970_572.JPEG	 alp	{"x":[["5","73"]],"y":[["6","73"]]}	{"answers":[null]}	1
1717	images/970_14361.JPEG	 alp	{"x":[["237","34"]],"y":[["237","38"]]}	{"answers":[null]}	1
1638	images/906_23829.JPEG	 Windsor tie	{"x":[["35","88"]],"y":[["35","91"]]}	{"answers":[null]}	1
1720	images/970_49817.JPEG	 alp	\N	\N	0
1723	images/970_17340.JPEG	 alp	\N	\N	0
1725	images/970_7174.JPEG	 alp	\N	\N	0
1726	images/678_24391.JPEG	 neck brace	\N	\N	0
1727	images/678_27434.JPEG	 neck brace	\N	\N	0
1812	images/548_26498.JPEG	 entertainment center	{"x":[["45","66"]],"y":[["51","66"]]}	{"answers":[null]}	1
1730	images/678_20373.JPEG	 neck brace	\N	\N	0
199	images/254_32986.JPEG	 pug	{"x":[["NaN","NaN"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
1733	images/678_3653.JPEG	 neck brace	\N	\N	0
1758	images/626_23493.JPEG	 lighter	{"x":[["94.79998779296875","118.19999694824219"]],"y":[["96.26669141408486","125.04461384678406"]]}	{"answers":[null]}	1
1738	images/678_21113.JPEG	 neck brace	\N	\N	0
1769	images/626_3957.JPEG	 lighter	{"x":[["24.599990844726562","101"]],"y":[["30.066072510827773","105.37286533288096"]]}	{"answers":[null]}	1
1740	images/678_27383.JPEG	 neck brace	\N	\N	0
1772	images/626_41849.JPEG	 lighter	\N	{"answers":[null]}	1
1760	images/626_28982.JPEG	 lighter	{"x":[["119.5","9"]],"y":[["119.5","16"]]}	{"answers":[null]}	1
1745	images/678_31432.JPEG	 neck brace	\N	\N	0
1747	images/678_44276.JPEG	 neck brace	\N	\N	0
1765	images/626_42848.JPEG	 lighter	{"x":[["157.5","140"]],"y":[["162.44974746830584","144.94974746830584"]]}	{"answers":[null]}	1
1750	images/678_20208.JPEG	 neck brace	\N	\N	0
1809	images/548_20553.JPEG	 entertainment center	{"x":[["16","114.80000305175781"]],"y":[["17","114.80000305175781"]]}	{"answers":[null]}	1
1757	images/626_15078.JPEG	 lighter	\N	\N	0
1759	images/626_34213.JPEG	 lighter	\N	\N	0
1761	images/626_22195.JPEG	 lighter	\N	\N	0
1736	images/678_39256.JPEG	 neck brace	{"x":[["95","85.80000305175781"]],"y":[["98","90.80000305175781"]]}	{"answers":[null]}	1
1766	images/626_47278.JPEG	 lighter	\N	\N	0
1771	images/626_34369.JPEG	 lighter	\N	\N	0
1770	images/626_30193.JPEG	 lighter	\N	{"answers":[null]}	1
1790	images/905_11935.JPEG	 window shade	{"x":[["118","16.800003051757812"]],"y":[["123","17.800003051757812"]]}	{"answers":[null]}	1
1780	images/905_27427.JPEG	 window shade	\N	\N	0
1782	images/905_43234.JPEG	 window shade	\N	\N	0
1783	images/905_18274.JPEG	 window shade	\N	\N	0
1784	images/905_43914.JPEG	 window shade	\N	\N	0
1785	images/905_32512.JPEG	 window shade	\N	\N	0
1786	images/905_15409.JPEG	 window shade	\N	\N	0
1788	images/905_18309.JPEG	 window shade	\N	\N	0
1792	images/905_29473.JPEG	 window shade	\N	\N	0
1795	images/905_22856.JPEG	 window shade	\N	\N	0
1796	images/905_48279.JPEG	 window shade	\N	\N	0
1798	images/905_30729.JPEG	 window shade	\N	\N	0
1799	images/905_33378.JPEG	 window shade	\N	\N	0
1804	images/548_29063.JPEG	 entertainment center	\N	\N	0
1806	images/548_16476.JPEG	 entertainment center	\N	\N	0
1813	images/548_10528.JPEG	 entertainment center	\N	\N	0
1816	images/548_30514.JPEG	 entertainment center	\N	\N	0
1817	images/548_16673.JPEG	 entertainment center	\N	\N	0
1779	images/905_44399.JPEG	 window shade	\N	{"answers":[null]}	1
1743	images/678_6334.JPEG	 neck brace	{"x":[["169","171"]],"y":[["171.2938493774533","174.27692768207615"]]}	{"answers":[null]}	1
1722	images/970_691.JPEG	 alp	{"x":[["123","102"]],"y":[["125","102"]]}	{"answers":[null]}	1
1767	images/626_26566.JPEG	 lighter	\N	{"answers":[null]}	1
1721	images/970_37263.JPEG	 alp	{"x":[["44","150"]],"y":[["45.78885438199983","146.42229123600035"]]}	{"answers":[null]}	1
1773	images/626_21040.JPEG	 lighter	{"x":[["105","34"]],"y":[["105","38"]]}	{"answers":[null]}	1
1781	images/905_17109.JPEG	 window shade	{"x":[["23","121"]],"y":[["23","122"]]}	{"answers":[null]}	1
1768	images/626_16568.JPEG	 lighter	{"x":[["5","75"]],"y":[["5","82"]]}	{"answers":[null]}	1
1762	images/626_34555.JPEG	 lighter	{"x":[["116","61"]],"y":[["116","62"]]}	{"answers":[null]}	1
1774	images/626_14082.JPEG	 lighter	{"x":[["67","81"]],"y":[["65","81"]]}	{"answers":[null]}	1
1800	images/905_44922.JPEG	 window shade	{"x":[["229","86"]],"y":[["230","91"]]}	{"answers":[null]}	1
1787	images/905_5764.JPEG	 window shade	{"x":[["90","27"]],"y":[["90","28"]]}	{"answers":[null]}	1
1810	images/548_9152.JPEG	 entertainment center	{"x":[["42","122"]],"y":[["42","126"]]}	{"answers":[null]}	1
1724	images/970_49593.JPEG	 alp	{"x":[["166","134"]],"y":[["167","134"]]}	{"answers":[null]}	1
1794	images/905_39739.JPEG	 window shade	\N	{"answers":[null]}	1
1756	images/626_12593.JPEG	 lighter	{"x":[["133","142"]],"y":[["134","142"]]}	{"answers":[null]}	1
1753	images/626_35045.JPEG	 lighter	{"x":[["93","119"]],"y":[["93","117"]]}	{"answers":[null]}	1
1731	images/678_29081.JPEG	 neck brace	{"x":[["74","108"]],"y":[["71","108"]]}	{"answers":[null]}	1
1811	images/548_14531.JPEG	 entertainment center	{"x":[["76","117"]],"y":[["75","117"]]}	{"answers":[null]}	1
1735	images/678_28968.JPEG	 neck brace	{"x":[["100","177"]],"y":[["105.93598812803562","180.70999258002226"]]}	{"answers":[null]}	1
1749	images/678_27753.JPEG	 neck brace	{"x":[["128","121"]],"y":[["129","120"]]}	{"answers":[null]}	1
1815	images/548_29279.JPEG	 entertainment center	{"x":[["88","81"]],"y":[["88","83"]]}	{"answers":[null]}	1
1814	images/548_29352.JPEG	 entertainment center	{"x":[["95","90"]],"y":[["95","91"]]}	{"answers":[null]}	1
1818	images/548_46146.JPEG	 entertainment center	\N	\N	0
1819	images/548_6298.JPEG	 entertainment center	\N	\N	0
1821	images/548_45245.JPEG	 entertainment center	\N	\N	0
1822	images/548_20589.JPEG	 entertainment center	\N	\N	0
1831	images/278_19885.JPEG	 kit fox	{"x":[["36.79998779296875","205.8000030517578"]],"y":[["38.79998779296875","202.8000030517578"]]}	{"answers":[null]}	1
1853	images/47_7776.JPEG	 African chameleon	{"x":[["24.5","61"]],"y":[["25.5","61"]]}	{"answers":[null]}	1
1825	images/548_17298.JPEG	 entertainment center	\N	\N	0
1856	images/47_5523.JPEG	 African chameleon	{"x":[["106.5","118"]],"y":[["99.70900249898267","119.69774937525433"]]}	{"answers":[null]}	1
1833	images/278_23228.JPEG	 kit fox	\N	\N	0
1834	images/278_21449.JPEG	 kit fox	\N	\N	0
1835	images/278_3078.JPEG	 kit fox	\N	\N	0
1909	images/664_7624.JPEG	 monitor	\N	{"answers":[null]}	1
1840	images/278_37489.JPEG	 kit fox	{"x":[["131","132.8000030517578"]],"y":[["130","132.8000030517578"]]}	{"answers":[null]}	1
1841	images/278_40505.JPEG	 kit fox	\N	\N	0
1846	images/278_38662.JPEG	 kit fox	{"x":[["124","55.80000305175781"]],"y":[["124","57.80000305175781"]]}	{"answers":[null]}	1
1844	images/278_27334.JPEG	 kit fox	\N	\N	0
1845	images/278_26207.JPEG	 kit fox	\N	\N	0
1847	images/278_5022.JPEG	 kit fox	\N	\N	0
1863	images/47_5959.JPEG	 African chameleon	{"x":[["63","131.20000076293945"]],"y":[["63","132.20000076293945"]]}	{"answers":[null]}	1
1850	images/278_21442.JPEG	 kit fox	\N	\N	0
1851	images/47_48529.JPEG	 African chameleon	\N	\N	0
1852	images/47_4720.JPEG	 African chameleon	\N	\N	0
1854	images/47_12336.JPEG	 African chameleon	\N	\N	0
1855	images/47_39369.JPEG	 African chameleon	\N	\N	0
1873	images/47_44283.JPEG	 African chameleon	{"x":[["245","37.19999694824219"]],"y":[["244","39.19999694824219"]]}	{"answers":[null]}	1
1858	images/47_32513.JPEG	 African chameleon	\N	\N	0
1862	images/47_37322.JPEG	 African chameleon	\N	\N	0
1869	images/47_9870.JPEG	 African chameleon	\N	\N	0
1870	images/47_22899.JPEG	 African chameleon	\N	\N	0
1874	images/47_36303.JPEG	 African chameleon	\N	\N	0
1878	images/279_16405.JPEG	 Arctic fox	\N	\N	0
1879	images/279_10616.JPEG	 Arctic fox	\N	\N	0
1880	images/279_25838.JPEG	 Arctic fox	\N	\N	0
1881	images/279_26618.JPEG	 Arctic fox	\N	\N	0
1885	images/279_43014.JPEG	 Arctic fox	\N	\N	0
1893	images/279_8877.JPEG	 Arctic fox	\N	\N	0
1894	images/279_49118.JPEG	 Arctic fox	\N	\N	0
1895	images/279_3325.JPEG	 Arctic fox	\N	\N	0
1897	images/279_10631.JPEG	 Arctic fox	\N	\N	0
1898	images/279_7947.JPEG	 Arctic fox	\N	\N	0
1899	images/279_28548.JPEG	 Arctic fox	\N	\N	0
1902	images/664_49751.JPEG	 monitor	\N	\N	0
1905	images/664_13323.JPEG	 monitor	\N	\N	0
1906	images/664_15452.JPEG	 monitor	\N	\N	0
1910	images/664_33303.JPEG	 monitor	\N	\N	0
1911	images/664_45524.JPEG	 monitor	\N	\N	0
1912	images/664_27544.JPEG	 monitor	\N	\N	0
1913	images/664_13547.JPEG	 monitor	\N	\N	0
1916	images/664_3292.JPEG	 monitor	\N	\N	0
1838	images/278_12857.JPEG	 kit fox	{"x":[["166","146.1999969482422"]],"y":[["165","143.1999969482422"]]}	{"answers":[null]}	1
1903	images/664_40975.JPEG	 monitor	{"x":[["0","104"]],"y":[["-1","104"]]}	{"answers":[null]}	1
1864	images/47_7528.JPEG	 African chameleon	{"x":[["33","74"]],"y":[["34","75"]]}	{"answers":[null]}	1
1914	images/664_22059.JPEG	 monitor	{"x":[["170.60000610351562","104.5999984741211"]],"y":[["173.60000610351562","102.5999984741211"]]}	{"answers":[null]}	1
1820	images/548_47660.JPEG	 entertainment center	\N	{"answers":[null]}	1
1860	images/47_744.JPEG	 African chameleon	{"x":[["141","43"]],"y":[["142.78885438199984","46.57770876399967"]]}	{"answers":[null]}	1
1876	images/279_7729.JPEG	 Arctic fox	{"x":[["66","135"]],"y":[["70","135"]]}	{"answers":[null]}	1
1859	images/47_45559.JPEG	 African chameleon	{"x":[["197","53"]],"y":[["193","56"]]}	{"answers":[null]}	1
1868	images/47_32302.JPEG	 African chameleon	{"x":[["44","150"]],"y":[["44","151"]]}	{"answers":[null]}	1
1828	images/278_13245.JPEG	 kit fox	{"x":[["87","76"]],"y":[["87","77"]]}	{"answers":[null]}	1
1908	images/664_46556.JPEG	 monitor	{"x":[["20","185"]],"y":[["21","185"]]}	{"answers":[null]}	1
1888	images/279_44948.JPEG	 Arctic fox	{"x":[["207.5","125"]],"y":[["201.80386570155287","120.93133264396633"]]}	{"answers":[null]}	1
1848	images/278_36764.JPEG	 kit fox	{"x":[["199","79"]],"y":[["199","78"]]}	{"answers":[null]}	1
1839	images/278_22277.JPEG	 kit fox	{"x":[["64","96"]],"y":[["64","97"]]}	{"answers":[null]}	1
1882	images/279_15935.JPEG	 Arctic fox	{"x":[["157.5","76"]],"y":[["160.5","79"]]}	{"answers":[null]}	1
1842	images/278_33315.JPEG	 kit fox	{"x":[["203.5","119"]],"y":[["203.5","116"]]}	{"answers":[null]}	1
1875	images/47_39300.JPEG	 African chameleon	{"x":[["90.5","38"]],"y":[["90.5","37"]]}	{"answers":[null]}	1
1917	images/664_22539.JPEG	 monitor	{"x":[["158","62"]],"y":[["157","63"]]}	{"answers":[null]}	1
1832	images/278_8528.JPEG	 kit fox	{"x":[["133","148"]],"y":[["137","148"]]}	{"answers":[null]}	1
1866	images/47_45182.JPEG	 African chameleon	{"x":[["62","55"]],"y":[["63","55"]]}	{"answers":[null]}	1
1829	images/278_42066.JPEG	 kit fox	{"x":[["80","163"]],"y":[["81","163"]]}	{"answers":[null]}	1
1865	images/47_3821.JPEG	 African chameleon	\N	{"answers":[null]}	1
1984	images/864_28699.JPEG	 tow truck	{"x":[["112","198"]],"y":[["117","201"]]}	{"answers":[null]}	1
1997	images/864_39795.JPEG	 tow truck	{"x":[["65.59999084472656","123.5999984741211"]],"y":[["65.59999084472656","130.5999984741211"]]}	{"answers":[null]}	1
1923	images/664_45320.JPEG	 monitor	\N	\N	0
1924	images/664_5071.JPEG	 monitor	\N	\N	0
1956	images/179_12503.JPEG	 Staffordshire bullterrier	{"x":[["54","60.79999542236328"]],"y":[["53","60.79999542236328"]]}	{"answers":[null]}	1
1920	images/664_44911.JPEG	 monitor	\N	{"answers":[null]}	1
1929	images/224_44504.JPEG	 groenendael	\N	\N	0
1930	images/224_15703.JPEG	 groenendael	\N	\N	0
1947	images/224_4883.JPEG	 groenendael	{"x":[["98","19.800003051757812"]],"y":[["98","20.800003051757812"]]}	{"answers":[null]}	1
1934	images/224_20715.JPEG	 groenendael	\N	\N	0
1939	images/224_26371.JPEG	 groenendael	{"x":[["11","29.800003051757812"]],"y":[["11","30.800003051757812"]]}	{"answers":[null]}	1
1940	images/224_8756.JPEG	 groenendael	\N	\N	0
1941	images/224_8062.JPEG	 groenendael	\N	\N	0
1942	images/224_7228.JPEG	 groenendael	\N	\N	0
1944	images/224_37865.JPEG	 groenendael	\N	\N	0
1965	images/179_28039.JPEG	 Staffordshire bullterrier	{"x":[["134","199.20000076293945"]],"y":[["131","199.20000076293945"]]}	{"answers":[null]}	1
1977	images/864_3307.JPEG	 tow truck	{"x":[["252","75.80000305175781"]],"y":[["251","75.80000305175781"]]}	{"answers":[null]}	1
1949	images/224_29346.JPEG	 groenendael	\N	\N	0
1951	images/179_7370.JPEG	 Staffordshire bullterrier	\N	\N	0
1954	images/179_47170.JPEG	 Staffordshire bullterrier	\N	\N	0
1957	images/179_42547.JPEG	 Staffordshire bullterrier	\N	\N	0
1959	images/179_4608.JPEG	 Staffordshire bullterrier	\N	\N	0
1960	images/179_27147.JPEG	 Staffordshire bullterrier	\N	\N	0
1961	images/179_8513.JPEG	 Staffordshire bullterrier	\N	\N	0
1963	images/179_38036.JPEG	 Staffordshire bullterrier	\N	\N	0
1966	images/179_26799.JPEG	 Staffordshire bullterrier	\N	\N	0
1970	images/179_37134.JPEG	 Staffordshire bullterrier	\N	\N	0
1974	images/179_18675.JPEG	 Staffordshire bullterrier	\N	\N	0
1975	images/179_15144.JPEG	 Staffordshire bullterrier	\N	\N	0
1976	images/864_31704.JPEG	 tow truck	\N	\N	0
1979	images/864_7911.JPEG	 tow truck	\N	\N	0
1983	images/864_24050.JPEG	 tow truck	\N	\N	0
1986	images/864_30684.JPEG	 tow truck	\N	\N	0
1987	images/864_9035.JPEG	 tow truck	\N	\N	0
1989	images/864_28445.JPEG	 tow truck	\N	\N	0
1990	images/864_28637.JPEG	 tow truck	\N	\N	0
1991	images/864_4170.JPEG	 tow truck	\N	\N	0
1992	images/864_41364.JPEG	 tow truck	\N	\N	0
1993	images/864_1774.JPEG	 tow truck	\N	\N	0
1994	images/864_12218.JPEG	 tow truck	\N	\N	0
1995	images/864_12657.JPEG	 tow truck	\N	\N	0
1998	images/864_39733.JPEG	 tow truck	\N	\N	0
1999	images/864_2221.JPEG	 tow truck	\N	\N	0
2000	images/864_36194.JPEG	 tow truck	\N	\N	0
2003	images/756_2810.JPEG	 rain barrel	\N	\N	0
2008	images/756_48665.JPEG	 rain barrel	\N	\N	0
2009	images/756_41144.JPEG	 rain barrel	\N	\N	0
2010	images/756_16755.JPEG	 rain barrel	\N	\N	0
2011	images/756_30286.JPEG	 rain barrel	\N	\N	0
2004	images/756_35130.JPEG	 rain barrel	{"x":[["68","106.19999694824219"]],"y":[["66","106.19999694824219"]]}	{"answers":[null]}	1
1925	images/664_26721.JPEG	 monitor	\N	{"answers":[null]}	1
1968	images/179_18302.JPEG	 Staffordshire bullterrier	{"x":[["172","181"]],"y":[["173","180"]]}	{"answers":[null]}	1
1973	images/179_2782.JPEG	 Staffordshire bullterrier	{"x":[["99","113"]],"y":[["101","113"]]}	{"answers":[null]}	1
1955	images/179_32034.JPEG	 Staffordshire bullterrier	{"x":[["175","118"]],"y":[["174","118"]]}	{"answers":[null]}	1
1953	images/179_21061.JPEG	 Staffordshire bullterrier	{"x":[["119.60000610351562","74.19999694824219"]],"y":[["121.60000610351562","74.19999694824219"]]}	{"answers":[null]}	1
1937	images/224_47724.JPEG	 groenendael	{"x":[["152","81"]],"y":[["152","77"]]}	{"answers":[null]}	1
1936	images/224_28594.JPEG	 groenendael	{"x":[["99","35"]],"y":[["97.30225062474567","41.79099750101732"]]}	{"answers":[null]}	1
1943	images/224_40768.JPEG	 groenendael	{"x":[["101","68"]],"y":[["101","69"]]}	{"answers":[null]}	1
1931	images/224_14179.JPEG	 groenendael	{"x":[["85","63"]],"y":[["85","62"]]}	{"answers":[null]}	1
1921	images/664_28342.JPEG	 monitor	{"x":[["25","9"]],"y":[["25","16"]]}	{"answers":[null]}	1
1922	images/664_15754.JPEG	 monitor	{"x":[["89.5","174"]],"y":[["89.5","176"]]}	{"answers":[null]}	1
1962	images/179_2936.JPEG	 Staffordshire bullterrier	{"x":[["92.5","116"]],"y":[["94.5","116"]]}	{"answers":[null]}	1
1978	images/864_19203.JPEG	 tow truck	{"x":[["7.5","141"]],"y":[["11.5","141"]]}	{"answers":[null]}	1
1938	images/224_9499.JPEG	 groenendael	{"x":[["56","80"]],"y":[["56","83"]]}	{"answers":[null]}	1
1971	images/179_16181.JPEG	 Staffordshire bullterrier	{"x":[["74","90"]],"y":[["72","90"]]}	{"answers":[null]}	1
1980	images/864_38635.JPEG	 tow truck	{"x":[["238","77"]],"y":[["237","78"]]}	{"answers":[null]}	1
1952	images/179_37273.JPEG	 Staffordshire bullterrier	{"x":[["148","48"]],"y":[["147","48"]]}	{"answers":[null]}	1
1982	images/864_25938.JPEG	 tow truck	{"x":[["248","13"]],"y":[["248","16"]]}	{"answers":[null]}	1
1932	images/224_13655.JPEG	 groenendael	{"x":[["39","15"]],"y":[["39","18"]]}	{"answers":[null]}	1
2012	images/756_6656.JPEG	 rain barrel	\N	\N	0
2189	images/773_35118.JPEG	 saltshaker	{"x":[["117","32"]],"y":[["117.63375022229764","38.971252445273926"]]}	{"answers":[null]}	1
2021	images/756_1955.JPEG	 rain barrel	\N	\N	0
2022	images/756_26645.JPEG	 rain barrel	\N	\N	0
2069	images/502_6740.JPEG	 clog	{"x":[["45.59999084472656","54.599998474121094"]],"y":[["45.59999084472656","61.599998474121094"]]}	{"answers":[null]}	1
2024	images/756_18297.JPEG	 rain barrel	\N	\N	0
2028	images/12_35160.JPEG	 house finch	\N	\N	0
2029	images/12_47940.JPEG	 house finch	\N	\N	0
2030	images/12_7330.JPEG	 house finch	\N	\N	0
2088	images/170_4524.JPEG	 Irish wolfhound	{"x":[["37.79998779296875","45.80000305175781"]],"y":[["37.103461759821755","52.76526338322773"]]}	{"answers":[null]}	1
2034	images/12_1857.JPEG	 house finch	\N	\N	0
2035	images/12_18305.JPEG	 house finch	\N	\N	0
2036	images/12_41763.JPEG	 house finch	\N	\N	0
2079	images/170_38702.JPEG	 Irish wolfhound	\N	{"answers":[null]}	1
2040	images/12_13235.JPEG	 house finch	\N	\N	0
2105	images/537_23087.JPEG	 dogsled	{"x":[["158","89.80000305175781"]],"y":[["156","93.80000305175781"]]}	{"answers":[null]}	1
2042	images/12_41078.JPEG	 house finch	\N	\N	0
2043	images/12_10370.JPEG	 house finch	\N	\N	0
2044	images/12_14684.JPEG	 house finch	\N	\N	0
2046	images/12_5310.JPEG	 house finch	\N	\N	0
2026	images/12_47743.JPEG	 house finch	{"x":[["90","32.80000305175781"]],"y":[["90","33.80000305175781"]]}	{"answers":[null]}	1
2050	images/12_39444.JPEG	 house finch	\N	\N	0
2110	images/537_288.JPEG	 dogsled	{"x":[["97","248.20000076293945"]],"y":[["96","247.20000076293945"]]}	{"answers":[null]}	1
2053	images/502_21653.JPEG	 clog	\N	\N	0
2070	images/502_43898.JPEG	 clog	{"x":[["50","152.20000076293945"]],"y":[["50","145.20000076293945"]]}	{"answers":[null]}	1
2045	images/12_9787.JPEG	 house finch	{"x":[["178","75"]],"y":[["175","75"]]}	{"answers":[null]}	1
2056	images/502_24173.JPEG	 clog	\N	\N	0
2057	images/502_4235.JPEG	 clog	\N	\N	0
2061	images/502_25343.JPEG	 clog	\N	\N	0
2064	images/502_46792.JPEG	 clog	\N	\N	0
2066	images/502_34665.JPEG	 clog	\N	\N	0
2071	images/502_8495.JPEG	 clog	\N	\N	0
2073	images/502_43257.JPEG	 clog	\N	\N	0
2075	images/502_26312.JPEG	 clog	\N	\N	0
2077	images/170_39888.JPEG	 Irish wolfhound	\N	\N	0
2078	images/170_46364.JPEG	 Irish wolfhound	\N	\N	0
2080	images/170_17022.JPEG	 Irish wolfhound	\N	\N	0
2081	images/170_18389.JPEG	 Irish wolfhound	\N	\N	0
2092	images/170_13565.JPEG	 Irish wolfhound	\N	\N	0
2098	images/170_18606.JPEG	 Irish wolfhound	\N	\N	0
2099	images/170_45075.JPEG	 Irish wolfhound	\N	\N	0
2100	images/170_26964.JPEG	 Irish wolfhound	\N	\N	0
2101	images/537_24772.JPEG	 dogsled	\N	\N	0
2102	images/537_8489.JPEG	 dogsled	\N	\N	0
2108	images/537_36921.JPEG	 dogsled	\N	\N	0
2039	images/12_5944.JPEG	 house finch	{"x":[["142","44"]],"y":[["143","44"]]}	{"answers":[null]}	1
2027	images/12_6917.JPEG	 house finch	{"x":[["92","91"]],"y":[["91","92"]]}	{"answers":[null]}	1
2093	images/170_35405.JPEG	 Irish wolfhound	{"x":[["212","50"]],"y":[["215","49"]]}	{"answers":[null]}	1
2017	images/756_24616.JPEG	 rain barrel	{"x":[["155","167"]],"y":[["155","166"]]}	{"answers":[null]}	1
2091	images/170_2783.JPEG	 Irish wolfhound	{"x":[["33","44"]],"y":[["33","45"]]}	{"answers":[null]}	1
2097	images/170_12178.JPEG	 Irish wolfhound	{"x":[["64","77"]],"y":[["60.11942999941867","76.02985749985467"]]}	{"answers":[null]}	1
2106	images/537_2238.JPEG	 dogsled	{"x":[["254","137"]],"y":[["251","137"]]}	{"answers":[null]}	1
2094	images/170_44969.JPEG	 Irish wolfhound	{"x":[["134","10"]],"y":[["131","12"]]}	{"answers":[null]}	1
2059	images/502_28061.JPEG	 clog	{"x":[["133","170"]],"y":[["133","163"]]}	{"answers":[null]}	1
2016	images/756_30871.JPEG	 rain barrel	{"x":[["71.5","195"]],"y":[["71.83295604590815","188.00792303592894"]]}	{"answers":[null]}	1
2084	images/170_29885.JPEG	 Irish wolfhound	{"x":[["61","75"]],"y":[["61","76"]]}	{"answers":[null]}	1
2020	images/756_23516.JPEG	 rain barrel	{"x":[["136","108"]],"y":[["136","112"]]}	{"answers":[null]}	1
2048	images/12_33990.JPEG	 house finch	{"x":[["132","75"]],"y":[["132","73"]]}	{"answers":[null]}	1
2013	images/756_31694.JPEG	 rain barrel	{"x":[["118","98"]],"y":[["118","99"]]}	{"answers":[null]}	1
2033	images/12_7057.JPEG	 house finch	{"x":[["141.5","87"]],"y":[["138.5","87"]]}	{"answers":[null]}	1
2068	images/502_7604.JPEG	 clog	{"x":[["117.5","226"]],"y":[["117.5","227"]]}	{"answers":[null]}	1
2107	images/537_37401.JPEG	 dogsled	{"x":[["148","142"]],"y":[["145","142"]]}	{"answers":[null]}	1
2111	images/537_18000.JPEG	 dogsled	\N	{"answers":[null]}	1
2047	images/12_49719.JPEG	 house finch	{"x":[["89","137"]],"y":[["92","140"]]}	{"answers":[null]}	1
2037	images/12_40761.JPEG	 house finch	{"x":[["37","164"]],"y":[["36","163"]]}	{"answers":[null]}	1
2082	images/170_40459.JPEG	 Irish wolfhound	{"x":[["207","32"]],"y":[["211.48129079765135","37.37754895718163"]]}	{"answers":[null]}	1
2051	images/502_44587.JPEG	 clog	{"x":[["245","82"]],"y":[["238","82"]]}	{"answers":[null]}	1
2090	images/170_32491.JPEG	 Irish wolfhound	{"x":[["38","82"]],"y":[["39.92304789528165","75.26933236651423"]]}	{"answers":[null]}	1
2112	images/537_9891.JPEG	 dogsled	\N	\N	0
2113	images/537_23065.JPEG	 dogsled	\N	\N	0
860	images/806_38759.JPEG	 sock	{"x":[["193","5"]],"y":[["193","10"]]}	{"answers":[null]}	1
2207	images/330_45543.JPEG	 wood rabbit	{"x":[["149","66"]],"y":[["149","67"]]}	{"answers":[null]}	1
2134	images/32_7845.JPEG	 tailed frog	{"x":[["154.59999084472656","123.5999984741211"]],"y":[["153.59999084472656","123.5999984741211"]]}	{"answers":[null]}	1
2119	images/537_35622.JPEG	 dogsled	\N	\N	0
2144	images/32_45085.JPEG	 tailed frog	{"x":[["67.5","155"]],"y":[["74.31392017833502","153.39672466392116"]]}	{"answers":[null]}	1
2160	images/810_28501.JPEG	 space bar	{"x":[["14","122.79999542236328"]],"y":[["17","125.79999542236328"]]}	{"answers":[null]}	1
2195	images/773_23021.JPEG	 saltshaker	\N	{"answers":[null]}	1
2165	images/810_23803.JPEG	 space bar	\N	{"answers":[null]}	1
2135	images/32_21605.JPEG	 tailed frog	\N	{"answers":[null]}	1
2126	images/32_8148.JPEG	 tailed frog	\N	\N	0
2128	images/32_39191.JPEG	 tailed frog	\N	\N	0
2129	images/32_8809.JPEG	 tailed frog	\N	\N	0
2130	images/32_21795.JPEG	 tailed frog	\N	\N	0
2133	images/32_36002.JPEG	 tailed frog	\N	\N	0
2136	images/32_1413.JPEG	 tailed frog	\N	\N	0
2201	images/330_43426.JPEG	 wood rabbit	{"x":[["146","81.80000305175781"]],"y":[["146","80.80000305175781"]]}	{"answers":[null]}	1
2138	images/32_8120.JPEG	 tailed frog	\N	\N	0
2139	images/32_32539.JPEG	 tailed frog	\N	\N	0
2187	images/773_47912.JPEG	 saltshaker	{"x":[["31","47.19999694824219"]],"y":[["37.99126637214491","47.54956026684943"]]}	{"answers":[null]}	1
2185	images/773_21035.JPEG	 saltshaker	{"x":[["55","5.200000762939453"]],"y":[["56","5.200000762939453"]]}	{"answers":[null]}	1
2208	images/330_7836.JPEG	 wood rabbit	{"x":[["152","89.20000076293945"]],"y":[["152","91.20000076293945"]]}	{"answers":[null]}	1
2146	images/32_49397.JPEG	 tailed frog	\N	\N	0
2148	images/32_36529.JPEG	 tailed frog	\N	\N	0
2149	images/32_41318.JPEG	 tailed frog	\N	\N	0
2152	images/810_48201.JPEG	 space bar	\N	\N	0
2156	images/810_2443.JPEG	 space bar	\N	\N	0
2158	images/810_42773.JPEG	 space bar	\N	\N	0
2159	images/810_35888.JPEG	 space bar	\N	\N	0
2163	images/810_39939.JPEG	 space bar	\N	\N	0
2164	images/810_44579.JPEG	 space bar	\N	\N	0
2167	images/810_22187.JPEG	 space bar	\N	\N	0
2168	images/810_13265.JPEG	 space bar	\N	\N	0
2169	images/810_7700.JPEG	 space bar	\N	\N	0
2172	images/810_15412.JPEG	 space bar	\N	\N	0
2176	images/773_25772.JPEG	 saltshaker	\N	\N	0
2179	images/773_17108.JPEG	 saltshaker	\N	\N	0
2182	images/773_3550.JPEG	 saltshaker	\N	\N	0
2183	images/773_2523.JPEG	 saltshaker	\N	\N	0
2191	images/773_43705.JPEG	 saltshaker	\N	\N	0
2192	images/773_20575.JPEG	 saltshaker	\N	\N	0
2196	images/773_45366.JPEG	 saltshaker	\N	\N	0
2197	images/773_3696.JPEG	 saltshaker	\N	\N	0
2202	images/330_10533.JPEG	 wood rabbit	\N	\N	0
2209	images/330_49002.JPEG	 wood rabbit	\N	\N	0
2181	images/773_2158.JPEG	 saltshaker	{"x":[["88","121"]],"y":[["89","121"]]}	{"answers":[null]}	1
2157	images/810_7939.JPEG	 space bar	{"x":[["24","203"]],"y":[["28","203"]]}	{"answers":[null]}	1
2170	images/810_3226.JPEG	 space bar	{"x":[["166","230"]],"y":[["165","230"]]}	{"answers":[null]}	1
2171	images/810_10589.JPEG	 space bar	{"x":[["11","155"]],"y":[["14","156"]]}	{"answers":[null]}	1
2120	images/537_9121.JPEG	 dogsled	{"x":[["2","87"]],"y":[["0","85"]]}	{"answers":[null]}	1
2150	images/32_46047.JPEG	 tailed frog	{"x":[["110","87"]],"y":[["110","88"]]}	{"answers":[null]}	1
2188	images/773_14222.JPEG	 saltshaker	{"x":[["19","60"]],"y":[["22","61"]]}	{"answers":[null]}	1
2199	images/773_40026.JPEG	 saltshaker	{"x":[["204","194"]],"y":[["197.67383512774524","196.99660441317332"]]}	{"answers":[null]}	1
2204	images/330_44342.JPEG	 wood rabbit	\N	{"answers":[null]}	1
2210	images/330_39682.JPEG	 wood rabbit	{"x":[["95","98"]],"y":[["95","104"]]}	{"answers":[null]}	1
2175	images/810_26895.JPEG	 space bar	{"x":[["147","200"]],"y":[["151","198"]]}	{"answers":[null]}	1
2141	images/32_34872.JPEG	 tailed frog	{"x":[["197","141"]],"y":[["197","140"]]}	{"answers":[null]}	1
2206	images/330_16691.JPEG	 wood rabbit	{"x":[["134","113"]],"y":[["133","115"]]}	{"answers":[null]}	1
2200	images/773_13528.JPEG	 saltshaker	{"x":[["25","66"]],"y":[["23","66"]]}	{"answers":[null]}	1
2186	images/773_32819.JPEG	 saltshaker	{"x":[["64","18"]],"y":[["65","18"]]}	{"answers":[null]}	1
2177	images/773_5296.JPEG	 saltshaker	{"x":[["96.5","62"]],"y":[["97.5","62"]]}	{"answers":[null]}	1
2178	images/773_47406.JPEG	 saltshaker	{"x":[["68.5","68"]],"y":[["70.5","69"]]}	{"answers":[null]}	1
2161	images/810_45335.JPEG	 space bar	{"x":[["102","87"]],"y":[["103","87"]]}	{"answers":[null]}	1
2153	images/810_17144.JPEG	 space bar	{"x":[["40","38"]],"y":[["40","39"]]}	{"answers":[null]}	1
2174	images/810_28091.JPEG	 space bar	{"x":[["70","213"]],"y":[["71","214"]]}	{"answers":[null]}	1
2155	images/810_35825.JPEG	 space bar	{"x":[["66","220"]],"y":[["66","223"]]}	{"answers":[null]}	1
2151	images/810_32410.JPEG	 space bar	{"x":[["23","157"]],"y":[["24","157"]]}	{"answers":[null]}	1
2127	images/32_8703.JPEG	 tailed frog	{"x":[["97","133"]],"y":[["98","133"]]}	{"answers":[null]}	1
2211	images/330_43839.JPEG	 wood rabbit	\N	\N	0
433	images/833_20648.JPEG	 submarine	{"x":[["30","118"]],"y":[["34","118"]]}	{"answers":[null]}	1
2214	images/330_48119.JPEG	 wood rabbit	\N	\N	0
2215	images/330_22140.JPEG	 wood rabbit	\N	\N	0
2216	images/330_30242.JPEG	 wood rabbit	\N	\N	0
2289	images/280_21874.JPEG	 grey fox	{"x":[["79.59999084472656","60"]],"y":[["79.59999084472656","61"]]}	{"answers":[null]}	1
2288	images/280_40208.JPEG	 grey fox	{"x":[["159.59999084472656","107.5999984741211"]],"y":[["157.59999084472656","107.5999984741211"]]}	{"answers":[null]}	1
2220	images/330_19333.JPEG	 wood rabbit	\N	\N	0
2306	images/354_3935.JPEG	 Arabian camel	{"x":[["11.5","90"]],"y":[["12.5","90"]]}	{"answers":[null]}	1
2272	images/642_23133.JPEG	 marimba	{"x":[["28","183.79999542236328"]],"y":[["30","183.79999542236328"]]}	{"answers":[null]}	1
2223	images/330_39333.JPEG	 wood rabbit	\N	\N	0
2224	images/330_33953.JPEG	 wood rabbit	\N	\N	0
2225	images/330_34649.JPEG	 wood rabbit	\N	\N	0
2226	images/547_13382.JPEG	 electric locomotive	\N	\N	0
2228	images/547_11636.JPEG	 electric locomotive	\N	\N	0
2230	images/547_19162.JPEG	 electric locomotive	\N	{"answers":[null]}	1
2234	images/547_10332.JPEG	 electric locomotive	\N	\N	0
2236	images/547_46151.JPEG	 electric locomotive	\N	\N	0
2279	images/280_27039.JPEG	 grey fox	{"x":[["90","96.79999542236328"]],"y":[["90","97.79999542236328"]]}	{"answers":[null]}	1
2238	images/547_49521.JPEG	 electric locomotive	\N	\N	0
2239	images/547_13531.JPEG	 electric locomotive	\N	\N	0
2267	images/642_8759.JPEG	 marimba	{"x":[["11","202.8000030517578"]],"y":[["17","202.8000030517578"]]}	{"answers":[null]}	1
2213	images/330_16566.JPEG	 wood rabbit	{"x":[["92","55.20000076293945"]],"y":[["92","62.20000076293945"]]}	{"answers":[null]}	1
2242	images/547_2477.JPEG	 electric locomotive	\N	\N	0
2243	images/547_14250.JPEG	 electric locomotive	\N	\N	0
2244	images/547_42654.JPEG	 electric locomotive	\N	\N	0
2246	images/547_48605.JPEG	 electric locomotive	\N	\N	0
2252	images/642_40293.JPEG	 marimba	\N	\N	0
2255	images/642_17398.JPEG	 marimba	\N	\N	0
2256	images/642_26001.JPEG	 marimba	\N	\N	0
2257	images/642_35654.JPEG	 marimba	\N	\N	0
2258	images/642_24258.JPEG	 marimba	\N	\N	0
2259	images/642_40343.JPEG	 marimba	\N	\N	0
2261	images/642_12543.JPEG	 marimba	\N	\N	0
2264	images/642_32048.JPEG	 marimba	\N	\N	0
2275	images/642_47736.JPEG	 marimba	\N	\N	0
2276	images/280_32006.JPEG	 grey fox	\N	\N	0
2278	images/280_15485.JPEG	 grey fox	\N	\N	0
2284	images/280_36490.JPEG	 grey fox	\N	\N	0
2285	images/280_26240.JPEG	 grey fox	\N	\N	0
2287	images/280_14954.JPEG	 grey fox	\N	\N	0
2291	images/280_37853.JPEG	 grey fox	\N	\N	0
2292	images/280_7942.JPEG	 grey fox	\N	\N	0
2296	images/280_40190.JPEG	 grey fox	\N	\N	0
2298	images/280_43958.JPEG	 grey fox	\N	\N	0
2299	images/280_46024.JPEG	 grey fox	\N	\N	0
2303	images/354_2773.JPEG	 Arabian camel	\N	\N	0
2307	images/354_3572.JPEG	 Arabian camel	\N	\N	0
2308	images/354_21844.JPEG	 Arabian camel	\N	\N	0
2262	images/642_48266.JPEG	 marimba	{"x":[["86","209"]],"y":[["83","207"]]}	{"answers":[null]}	1
2232	images/547_4919.JPEG	 electric locomotive	{"x":[["254","134"]],"y":[["252","134"]]}	{"answers":[null]}	1
2300	images/280_4356.JPEG	 grey fox	{"x":[["75","91"]],"y":[["72","91"]]}	{"answers":[null]}	1
2233	images/547_48576.JPEG	 electric locomotive	{"x":[["24","13"]],"y":[["28","13"]]}	{"answers":[null]}	1
2227	images/547_43452.JPEG	 electric locomotive	{"x":[["122","160"]],"y":[["120.0096539003432","156.53034261005774"]]}	{"answers":[null]}	1
2229	images/547_13815.JPEG	 electric locomotive	\N	{"answers":[null]}	1
2269	images/642_42756.JPEG	 marimba	\N	{"answers":[null]}	1
2304	images/354_30777.JPEG	 Arabian camel	{"x":[["217","79"]],"y":[["216","80"]]}	{"answers":[null]}	1
2290	images/280_10196.JPEG	 grey fox	{"x":[["34","97"]],"y":[["34.78446454055273","93.07767729723632"]]}	{"answers":[null]}	1
2265	images/642_2023.JPEG	 marimba	{"x":[["80","184"]],"y":[["83","183"]]}	{"answers":[null]}	1
2253	images/642_46931.JPEG	 marimba	{"x":[["163","214"]],"y":[["163","211"]]}	{"answers":[null]}	1
2260	images/642_47805.JPEG	 marimba	{"x":[["43","78"]],"y":[["50","78"]]}	{"answers":[null]}	1
2281	images/280_8761.JPEG	 grey fox	{"x":[["94","98"]],"y":[["94","94"]]}	{"answers":[null]}	1
2250	images/547_34233.JPEG	 electric locomotive	{"x":[["3","90"]],"y":[["6","90"]]}	{"answers":[null]}	1
2297	images/280_11311.JPEG	 grey fox	{"x":[["239","113"]],"y":[["239","114"]]}	{"answers":[null]}	1
2247	images/547_46005.JPEG	 electric locomotive	{"x":[["221","117"]],"y":[["221","122"]]}	{"answers":[null]}	1
2309	images/354_43160.JPEG	 Arabian camel	{"x":[["73","109"]],"y":[["73","111"]]}	{"answers":[null]}	1
2268	images/642_5681.JPEG	 marimba	{"x":[["114.5","70"]],"y":[["115.5","70"]]}	{"answers":[null]}	1
2274	images/642_23209.JPEG	 marimba	{"x":[["169.5","147"]],"y":[["174.5","147"]]}	{"answers":[null]}	1
2273	images/642_25115.JPEG	 marimba	{"x":[["77","140"]],"y":[["76","139"]]}	{"answers":[null]}	1
2295	images/280_37284.JPEG	 grey fox	{"x":[["117","100"]],"y":[["118","96"]]}	{"answers":[null]}	1
2277	images/280_24669.JPEG	 grey fox	{"x":[["125","63"]],"y":[["125","65"]]}	{"answers":[null]}	1
2398	images/561_42666.JPEG	 forklift	{"x":[["112","98"]],"y":[["112","101"]]}	{"answers":[null]}	1
2315	images/354_25311.JPEG	 Arabian camel	\N	\N	0
2317	images/354_8866.JPEG	 Arabian camel	\N	\N	0
2370	images/451_14866.JPEG	 bolo tie	{"x":[["102.59999084472656","39.20000076293945"]],"y":[["102.59999084472656","46.20000076293945"]]}	{"answers":[null]}	1
2339	images/391_22375.JPEG	 coho	{"x":[["57.79998779296875","159.1999969482422"]],"y":[["56.79998779296875","160.1999969482422"]]}	{"answers":[null]}	1
2395	images/561_20409.JPEG	 forklift	{"x":[["71.5","167"]],"y":[["71.5","160"]]}	{"answers":[null]}	1
2324	images/354_34251.JPEG	 Arabian camel	\N	\N	0
2326	images/391_14314.JPEG	 coho	\N	\N	0
2325	images/354_28381.JPEG	 Arabian camel	\N	{"answers":[null]}	1
2330	images/391_33055.JPEG	 coho	\N	\N	0
2310	images/354_48885.JPEG	 Arabian camel	{"x":[["211","93.80000305175781"]],"y":[["207","93.80000305175781"]]}	{"answers":[null]}	1
2380	images/561_49234.JPEG	 forklift	{"x":[["138","83.20000076293945"]],"y":[["138","84.20000076293945"]]}	{"answers":[null]}	1
2329	images/391_13776.JPEG	 coho	{"x":[["239","140.79999923706055"]],"y":[["239","147.79999923706055"]]}	{"answers":[null]}	1
2344	images/391_10411.JPEG	 coho	\N	\N	0
2345	images/391_35726.JPEG	 coho	\N	\N	0
2347	images/391_44351.JPEG	 coho	\N	\N	0
2407	images/690_5812.JPEG	 oxcart	{"x":[["132","147.1999969482422"]],"y":[["136","147.1999969482422"]]}	{"answers":[null]}	1
2349	images/391_25645.JPEG	 coho	\N	\N	0
2350	images/391_23613.JPEG	 coho	\N	\N	0
2351	images/451_32415.JPEG	 bolo tie	\N	\N	0
2353	images/451_31187.JPEG	 bolo tie	\N	\N	0
2356	images/451_20324.JPEG	 bolo tie	\N	\N	0
2359	images/451_22946.JPEG	 bolo tie	\N	\N	0
2360	images/451_34245.JPEG	 bolo tie	\N	\N	0
2364	images/451_12163.JPEG	 bolo tie	\N	\N	0
2366	images/451_28038.JPEG	 bolo tie	\N	\N	0
2371	images/451_20745.JPEG	 bolo tie	\N	\N	0
2378	images/561_46975.JPEG	 forklift	\N	\N	0
2379	images/561_32063.JPEG	 forklift	\N	\N	0
2387	images/561_1596.JPEG	 forklift	\N	\N	0
2388	images/561_8060.JPEG	 forklift	\N	\N	0
2392	images/561_7905.JPEG	 forklift	\N	\N	0
2397	images/561_47315.JPEG	 forklift	\N	\N	0
2399	images/561_6894.JPEG	 forklift	\N	\N	0
2401	images/690_21082.JPEG	 oxcart	\N	\N	0
2402	images/690_561.JPEG	 oxcart	\N	\N	0
2406	images/690_5131.JPEG	 oxcart	\N	\N	0
2412	images/690_331.JPEG	 oxcart	\N	\N	0
2414	images/690_22867.JPEG	 oxcart	\N	\N	0
2355	images/451_35710.JPEG	 bolo tie	{"x":[["102","230"]],"y":[["102","228"]]}	{"answers":[null]}	1
2409	images/690_29432.JPEG	 oxcart	{"x":[["248","98"]],"y":[["247","99"]]}	{"answers":[null]}	1
2391	images/561_23896.JPEG	 forklift	{"x":[["76","6"]],"y":[["77","6"]]}	{"answers":[null]}	1
2400	images/561_2864.JPEG	 forklift	\N	{"answers":[null]}	1
2346	images/391_49223.JPEG	 coho	{"x":[["32","96"]],"y":[["30","98"]]}	{"answers":[null]}	1
2311	images/354_49792.JPEG	 Arabian camel	{"x":[["146","105"]],"y":[["145","105"]]}	{"answers":[null]}	1
2362	images/451_45623.JPEG	 bolo tie	\N	{"answers":[null]}	1
2316	images/354_45246.JPEG	 Arabian camel	{"x":[["176","101"]],"y":[["177","102"]]}	{"answers":[null]}	1
2393	images/561_46803.JPEG	 forklift	{"x":[["202","142"]],"y":[["201","142"]]}	{"answers":[null]}	1
2337	images/391_20515.JPEG	 coho	{"x":[["177","113"]],"y":[["173","113"]]}	{"answers":[null]}	1
2335	images/391_22175.JPEG	 coho	{"x":[["65","121"]],"y":[["66","121"]]}	{"answers":[null]}	1
2321	images/354_15052.JPEG	 Arabian camel	{"x":[["197","103"]],"y":[["197","104"]]}	{"answers":[null]}	1
2319	images/354_24886.JPEG	 Arabian camel	\N	{"answers":[null]}	1
2340	images/391_29501.JPEG	 coho	{"x":[["47","188"]],"y":[["46","188"]]}	{"answers":[null]}	1
2313	images/354_46585.JPEG	 Arabian camel	{"x":[["114","87"]],"y":[["114","89"]]}	{"answers":[null]}	1
2338	images/391_37449.JPEG	 coho	{"x":[["132","77"]],"y":[["132","71"]]}	{"answers":[null]}	1
2361	images/451_41628.JPEG	 bolo tie	{"x":[["53","66"]],"y":[["53","73"]]}	{"answers":[null]}	1
2369	images/451_26483.JPEG	 bolo tie	{"x":[["73","7"]],"y":[["74","7"]]}	{"answers":[null]}	1
2411	images/690_21579.JPEG	 oxcart	{"x":[["89","162"]],"y":[["87","162"]]}	{"answers":[null]}	1
2410	images/690_18059.JPEG	 oxcart	{"x":[["112","138"]],"y":[["112","137"]]}	{"answers":[null]}	1
2334	images/391_441.JPEG	 coho	{"x":[["124","129"]],"y":[["124","131"]]}	{"answers":[null]}	1
2331	images/391_27569.JPEG	 coho	{"x":[["77.5","48"]],"y":[["83.9340152101264","50.75743509005417"]]}	{"answers":[null]}	1
2376	images/561_41590.JPEG	 forklift	{"x":[["97.5","71"]],"y":[["97.5","74"]]}	{"answers":[null]}	1
2385	images/561_27502.JPEG	 forklift	{"x":[["115","202"]],"y":[["111","202"]]}	{"answers":[null]}	1
2408	images/690_31499.JPEG	 oxcart	\N	{"answers":[null]}	1
2312	images/354_39047.JPEG	 Arabian camel	{"x":[["72","105"]],"y":[["79","105"]]}	{"answers":[null]}	1
2396	images/561_6950.JPEG	 forklift	{"x":[["138","38"]],"y":[["136","43"]]}	{"answers":[null]}	1
2318	images/354_10949.JPEG	 Arabian camel	{"x":[["7","67"]],"y":[["9","67"]]}	{"answers":[null]}	1
2403	images/690_40620.JPEG	 oxcart	\N	{"answers":[null]}	1
2358	images/451_26095.JPEG	 bolo tie	{"x":[["89","39"]],"y":[["91","39"]]}	{"answers":[null]}	1
2415	images/690_6860.JPEG	 oxcart	\N	\N	0
2417	images/690_2396.JPEG	 oxcart	\N	\N	0
2418	images/690_29310.JPEG	 oxcart	\N	\N	0
2492	images/978_38888.JPEG	 seashore	{"x":[["3","120"]],"y":[["7","120"]]}	{"answers":[null]}	1
2500	images/978_9425.JPEG	 seashore	{"x":[["184.59999084472656","207"]],"y":[["184.59999084472656","206"]]}	{"answers":[null]}	1
2439	images/95_15588.JPEG	 jacamar	{"x":[["150.59999084472656","85.5999984741211"]],"y":[["143.59999084472656","85.5999984741211"]]}	{"answers":[null]}	1
2430	images/95_28387.JPEG	 jacamar	\N	\N	0
2445	images/95_5792.JPEG	 jacamar	{"x":[["4.79998779296875","16.800003051757812"]],"y":[["11.78635584234897","17.236651054844078"]]}	{"answers":[null]}	1
2432	images/95_10107.JPEG	 jacamar	\N	\N	0
2488	images/978_2016.JPEG	 seashore	\N	{"answers":[null]}	1
2452	images/691_33810.JPEG	 oxygen mask	\N	{"answers":[null]}	1
2489	images/978_3379.JPEG	 seashore	{"x":[["78","194.20000076293945"]],"y":[["85","194.20000076293945"]]}	{"answers":[null]}	1
2437	images/95_43433.JPEG	 jacamar	\N	\N	0
2438	images/95_26047.JPEG	 jacamar	\N	\N	0
2444	images/95_21916.JPEG	 jacamar	\N	\N	0
2450	images/95_18841.JPEG	 jacamar	\N	\N	0
2453	images/691_44953.JPEG	 oxygen mask	\N	\N	0
2454	images/691_23559.JPEG	 oxygen mask	\N	\N	0
2465	images/691_2512.JPEG	 oxygen mask	\N	\N	0
2467	images/691_38914.JPEG	 oxygen mask	\N	\N	0
2472	images/691_39347.JPEG	 oxygen mask	\N	\N	0
2473	images/691_16424.JPEG	 oxygen mask	\N	\N	0
2475	images/691_16248.JPEG	 oxygen mask	\N	\N	0
2476	images/978_6692.JPEG	 seashore	\N	\N	0
2481	images/978_33229.JPEG	 seashore	\N	\N	0
2486	images/978_3760.JPEG	 seashore	\N	\N	0
2487	images/978_20821.JPEG	 seashore	\N	\N	0
2490	images/978_37153.JPEG	 seashore	\N	\N	0
2491	images/978_32876.JPEG	 seashore	\N	\N	0
2494	images/978_14053.JPEG	 seashore	\N	\N	0
431	images/833_38847.JPEG	 submarine	{"x":[["108","140"]],"y":[["109.26491106406735","136.20526680779795"]]}	{"answers":[null]}	1
1927	images/224_5059.JPEG	 groenendael	{"x":[["104","70"]],"y":[["105","70"]]}	{"answers":[null]}	1
362	images/558_40294.JPEG	 flute	\N	{"answers":[null]}	1
1102	images/379_19781.JPEG	 howler monkey	{"x":[["206.79998779296875","96.19999694824219"]],"y":[["208.7291739812262","99.70402900446494"]]}	{"answers":[null]}	1
477	images/485_28001.JPEG	 CD player	{"x":[["121","153"]],"y":[["123","152"]]}	{"answers":[null]}	1
2058	images/502_43921.JPEG	 clog	{"x":[["121","155"]],"y":[["121","154"]]}	{"answers":[null]}	1
558	images/171_19496.JPEG	 Italian greyhound	{"x":[["118","173"]],"y":[["118","171"]]}	{"answers":[null]}	1
874	images/806_15164.JPEG	 sock	{"x":[["177","213"]],"y":[["177","212"]]}	{"answers":[null]}	1
1904	images/664_24073.JPEG	 monitor	{"x":[["223","167"]],"y":[["222","167"]]}	{"answers":[null]}	1
2469	images/691_19948.JPEG	 oxygen mask	{"x":[["143","74.19999694824219"]],"y":[["141.21114561800016","77.77770571224185"]]}	{"answers":[null]}	1
2498	images/978_26198.JPEG	 seashore	{"x":[["1","241"]],"y":[["5","241"]]}	{"answers":[null]}	1
2470	images/691_43730.JPEG	 oxygen mask	\N	{"answers":[null]}	1
2480	images/978_48921.JPEG	 seashore	{"x":[["75","99"]],"y":[["77","99"]]}	{"answers":[null]}	1
2461	images/691_28599.JPEG	 oxygen mask	{"x":[["153.60000610351562","63"]],"y":[["149.60000610351562","63"]]}	{"answers":[null]}	1
2448	images/95_21124.JPEG	 jacamar	{"x":[["208.60000610351562","130.1999969482422"]],"y":[["205.60000610351562","129.1999969482422"]]}	{"answers":[null]}	1
2451	images/691_33905.JPEG	 oxygen mask	\N	{"answers":[null]}	1
2447	images/95_2279.JPEG	 jacamar	{"x":[["176","43"]],"y":[["178","43"]]}	{"answers":[null]}	1
2420	images/690_33152.JPEG	 oxcart	{"x":[["188","92"]],"y":[["188","93"]]}	{"answers":[null]}	1
2424	images/690_6736.JPEG	 oxcart	{"x":[["68","116"]],"y":[["69","120"]]}	{"answers":[null]}	1
2446	images/95_34700.JPEG	 jacamar	{"x":[["183","106"]],"y":[["182","106"]]}	{"answers":[null]}	1
2478	images/978_10889.JPEG	 seashore	{"x":[["7","101"]],"y":[["9","101"]]}	{"answers":[null]}	1
2440	images/95_40249.JPEG	 jacamar	{"x":[["127","51"]],"y":[["133.82073836986234","49.42598345310869"]]}	{"answers":[null]}	1
2493	images/978_48563.JPEG	 seashore	{"x":[["4","159"]],"y":[["10.971252445273926","158.36624977770236"]]}	{"answers":[null]}	1
2483	images/978_32009.JPEG	 seashore	{"x":[["6","136"]],"y":[["11","136"]]}	{"answers":[null]}	1
2463	images/691_753.JPEG	 oxygen mask	{"x":[["62","122"]],"y":[["62","128"]]}	{"answers":[null]}	1
2458	images/691_38612.JPEG	 oxygen mask	{"x":[["193","165"]],"y":[["186.04281385728467","164.22697931747607"]]}	{"answers":[null]}	1
2460	images/691_18455.JPEG	 oxygen mask	{"x":[["155.5","68"]],"y":[["155.5","61"]]}	{"answers":[null]}	1
2427	images/95_25827.JPEG	 jacamar	{"x":[["141.5","46"]],"y":[["142.5","46"]]}	{"answers":[null]}	1
2422	images/690_36198.JPEG	 oxcart	{"x":[["54","130"]],"y":[["55","130"]]}	{"answers":[null]}	1
2442	images/95_31871.JPEG	 jacamar	{"x":[["120","68"]],"y":[["121","68"]]}	{"answers":[null]}	1
2468	images/691_18066.JPEG	 oxygen mask	{"x":[["95","92"]],"y":[["95","85"]]}	{"answers":[null]}	1
2428	images/95_44290.JPEG	 jacamar	{"x":[["142","26"]],"y":[["141.56335199691372","32.98636804938022"]]}	{"answers":[null]}	1
2495	images/978_43900.JPEG	 seashore	{"x":[["4","189"]],"y":[["9","189"]]}	{"answers":[null]}	1
254	images/381_38489.JPEG	 spider monkey	{"x":[["100","72"]],"y":[["101","72"]]}	{"answers":[null]}	1
1628	images/906_7671.JPEG	 Windsor tie	{"x":[["84","71"]],"y":[["83","71"]]}	{"answers":[null]}	1
1872	images/47_36762.JPEG	 African chameleon	{"x":[["190","76"]],"y":[["191","75"]]}	{"answers":[null]}	1
1464	images/931_5850.JPEG	 bagel	{"x":[["145","129"]],"y":[["145","130"]]}	{"answers":[null]}	1
788	images/825_6874.JPEG	 stone wall	{"x":[["26","190"]],"y":[["26","189"]]}	{"answers":[null]}	1
2217	images/330_13715.JPEG	 wood rabbit	{"x":[["166","162"]],"y":[["166","163"]]}	{"answers":[null]}	1
41	images/669_7286.JPEG	 mosquito net	{"x":[["181","133"]],"y":[["181","129"]]}	{"answers":[null]}	1
1413	images/890_12903.JPEG	 volleyball	{"x":[["98","106"]],"y":[["99","106"]]}	{"answers":[null]}	1
75	images/147_6023.JPEG	 grey whale	{"x":[["103","113"]],"y":[["104","114"]]}	{"answers":[null]}	1
1437	images/472_24484.JPEG	 canoe	{"x":[["184","86"]],"y":[["186","88"]]}	{"answers":[null]}	1
884	images/545_40591.JPEG	 electric fan	{"x":[["125","119"]],"y":[["125","118"]]}	{"answers":[null]}	1
1601	images/325_26203.JPEG	 sulphur butterfly	{"x":[["96","94"]],"y":[["97","96"]]}	{"answers":[null]}	1
619	images/563_33293.JPEG	 fountain pen	{"x":[["11","206"]],"y":[["10","206"]]}	{"answers":[null]}	1
2302	images/354_19904.JPEG	 Arabian camel	{"x":[["163","166"]],"y":[["161","166"]]}	{"answers":[null]}	1
22	images/903_18529.JPEG	 wig	{"x":[["194","85.19999694824219"]],"y":[["192.98202680288142","81.3316987991916"]]}	{"answers":[null]}	1
2449	images/95_7608.JPEG	 jacamar	{"x":[["109","115.19999694824219"]],"y":[["109","114.19999694824219"]]}	{"answers":[null]}	1
1237	images/206_6326.JPEG	 curly-coated retriever	{"x":[["122","22.199996948242188"]],"y":[["119.29710148593061","25.148613509045152"]]}	{"answers":[null]}	1
566	images/171_36771.JPEG	 Italian greyhound	{"x":[["179","131.1999969482422"]],"y":[["176","131.1999969482422"]]}	{"answers":[null]}	1
1050	images/634_48865.JPEG	 lumbermill	{"x":[["133","191.1999969482422"]],"y":[["133","187.1999969482422"]]}	{"answers":[null]}	1
1801	images/548_18004.JPEG	 entertainment center	{"x":[["100","134"]],"y":[["99","133"]]}	{"answers":[null]}	1
287	images/448_23890.JPEG	 birdhouse	{"x":[["122","94.19999694824219"]],"y":[["122","90.19999694824219"]]}	{"answers":[null]}	1
624	images/563_38268.JPEG	 fountain pen	{"x":[["198","252.1999969482422"]],"y":[["198","250.1999969482422"]]}	{"answers":[null]}	1
1593	images/871_5690.JPEG	 trimaran	{"x":[["125","182.1999969482422"]],"y":[["121","182.1999969482422"]]}	{"answers":[null]}	1
319	images/101_28580.JPEG	 tusker	{"x":[["80","48.19999694824219"]],"y":[["80","50.19999694824219"]]}	{"answers":[null]}	1
839	images/826_38447.JPEG	 stopwatch	{"x":[["24","169.1999969482422"]],"y":[["27.76591462229934","170.54828736857158"]]}	{"answers":[null]}	1
2363	images/451_49758.JPEG	 bolo tie	{"x":[["97","252.1999969482422"]],"y":[["97","248.1999969482422"]]}	{"answers":[null]}	1
1716	images/970_46802.JPEG	 alp	{"x":[["7","137.1999969482422"]],"y":[["10","137.1999969482422"]]}	{"answers":[null]}	1
2419	images/690_7304.JPEG	 oxcart	{"x":[["110","124.19999694824219"]],"y":[["113.98357282587081","124.56213993241226"]]}	{"answers":[null]}	1
1969	images/179_1421.JPEG	 Staffordshire bullterrier	{"x":[["49","63.19999694824219"]],"y":[["49","59.19999694824219"]]}	{"answers":[null]}	1
1319	images/896_399.JPEG	 washbasin	{"x":[["120","70.19999694824219"]],"y":[["116","70.19999694824219"]]}	{"answers":[null]}	1
1101	images/379_42256.JPEG	 howler monkey	{"x":[["151","33.19999694824219"]],"y":[["151","37.19999694824219"]]}	{"answers":[null]}	1
1397	images/759_3762.JPEG	 reflex camera	{"x":[["164","170.8000030517578"]],"y":[["168","170.8000030517578"]]}	{"answers":[null]}	1
243	images/482_12743.JPEG	 cassette player	{"x":[["198","93.80000305175781"]],"y":[["198","95.80000305175781"]]}	{"answers":[null]}	1
823	images/921_16713.JPEG	 book jacket	{"x":[["198","16.800003051757812"]],"y":[["196","15.800003051757812"]]}	{"answers":[null]}	1
1118	images/379_2327.JPEG	 howler monkey	{"x":[["69","176.1999969482422"]],"y":[["69","175.1999969482422"]]}	{"answers":[null]}	1
1156	images/876_2789.JPEG	 tub	{"x":[["256","202.1999969482422"]],"y":[["255","202.1999969482422"]]}	{"answers":[null]}	1
1133	images/667_32676.JPEG	 mortarboard	{"x":[["78","26.199996948242188"]],"y":[["74.8","28.599996948242186"]]}	{"answers":[null]}	1
2375	images/451_10511.JPEG	 bolo tie	{"x":[["256","86"]],"y":[["255","87"]]}	{"answers":[null]}	1
1620	images/325_27456.JPEG	 sulphur butterfly	{"x":[["128","190"]],"y":[["128.78446454055273","186.0776772972363"]]}	{"answers":[null]}	1
2041	images/12_43509.JPEG	 house finch	{"x":[["176","71"]],"y":[["173.54423754594032","67.8425911304947"]]}	{"answers":[null]}	1
2162	images/810_4816.JPEG	 space bar	{"x":[["152","245"]],"y":[["155.51158229165753","243.0845914772777"]]}	{"answers":[null]}	1
2125	images/537_1356.JPEG	 dogsled	{"x":[["141","181"]],"y":[["142","182"]]}	{"answers":[null]}	1
17	images/903_2848.JPEG	 wig	{"x":[["49","0"]],"y":[["50","0"]]}	{"answers":[null]}	1
1000	images/22_9401.JPEG	 bald eagle	{"x":[["147","60"]],"y":[["150.42997170285017","57.94201697828989"]]}	{"answers":[null]}	1
344	images/959_40254.JPEG	 carbonara	{"x":[["211","131"]],"y":[["212","131"]]}	{"answers":[null]}	1
2482	images/978_36557.JPEG	 seashore	{"x":[["8","215"]],"y":[["11.959797974644665","214.43431457505076"]]}	{"answers":[null]}	1
159	images/947_14237.JPEG	 mushroom	{"x":[["59","150"]],"y":[["62.97553493869447","149.5582738957006"]]}	{"answers":[null]}	1
1499	images/813_40356.JPEG	 spatula	{"x":[["37","3"]],"y":[["36","3"]]}	{"answers":[null]}	1
736	images/344_35712.JPEG	 hippopotamus	{"x":[["44","47"]],"y":[["47.98618303297952","47.33218191941496"]]}	{"answers":[null]}	1
1321	images/896_13454.JPEG	 washbasin	\N	{"answers":[null]}	1
231	images/482_49493.JPEG	 cassette player	{"x":[["250","65"]],"y":[["248","65"]]}	{"answers":[null]}	1
1918	images/664_13103.JPEG	 monitor	\N	{"answers":[null]}	1
2117	images/537_30507.JPEG	 dogsled	{"x":[["119","135"]],"y":[["119","133"]]}	{"answers":[null]}	1
701	images/389_16230.JPEG	 barracouta	{"x":[["38","74"]],"y":[["38","77"]]}	{"answers":[null]}	1
253	images/381_13556.JPEG	 spider monkey	{"x":[["125","116"]],"y":[["128.42997170285017","113.9420169782899"]]}	{"answers":[null]}	1
2241	images/547_22371.JPEG	 electric locomotive	{"x":[["31","101"]],"y":[["33","101"]]}	{"answers":[null]}	1
2322	images/354_25438.JPEG	 Arabian camel	{"x":[["7","110"]],"y":[["11","110"]]}	{"answers":[null]}	1
169	images/947_35315.JPEG	 mushroom	{"x":[["4","158"]],"y":[["8","158"]]}	{"answers":[null]}	1
1867	images/47_28630.JPEG	 African chameleon	{"x":[["134","171"]],"y":[["135","171"]]}	{"answers":[null]}	1
867	images/806_36186.JPEG	 sock	{"x":[["64","29"]],"y":[["64","28"]]}	{"answers":[null]}	1
1314	images/896_21114.JPEG	 washbasin	{"x":[["82","158"]],"y":[["81","158"]]}	{"answers":[null]}	1
1290	images/143_13308.JPEG	 oystercatcher	{"x":[["190","43"]],"y":[["189.02985749985467","39.11942999941867"]]}	{"answers":[null]}	1
201	images/865_46210.JPEG	 toyshop	\N	{"answers":[null]}	1
678	images/663_40795.JPEG	 monastery	{"x":[["80","11"]],"y":[["80.56568542494924","14.959797974644665"]]}	{"answers":[null]}	1
1120	images/379_13553.JPEG	 howler monkey	{"x":[["256","113"]],"y":[["252.11942999941868","112.02985749985467"]]}	{"answers":[null]}	1
106	images/440_19579.JPEG	 beer bottle	{"x":[["75","6"]],"y":[["74","6"]]}	{"answers":[null]}	1
1409	images/890_15554.JPEG	 volleyball	{"x":[["137","180"]],"y":[["136.43431457505076","176.04020202535534"]]}	{"answers":[null]}	1
1919	images/664_16138.JPEG	 monitor	{"x":[["110","97"]],"y":[["111","97"]]}	{"answers":[null]}	1
1732	images/678_21910.JPEG	 neck brace	{"x":[["81","105"]],"y":[["82","108"]]}	{"answers":[null]}	1
2499	images/978_45558.JPEG	 seashore	{"x":[["9","148"]],"y":[["12.98983479932294","147.71501180004836"]]}	{"answers":[null]}	1
1136	images/667_25800.JPEG	 mortarboard	{"x":[["2","53"]],"y":[["4.989637274734639","50.34254464468032"]]}	{"answers":[null]}	1
512	images/724_9699.JPEG	 pirate	{"x":[["78","90"]],"y":[["79","91"]]}	{"answers":[null]}	1
1561	images/770_34125.JPEG	 running shoe	{"x":[["154","70"]],"y":[["153","70"]]}	{"answers":[null]}	1
385	images/697_44065.JPEG	 pajama	{"x":[["57","116"]],"y":[["57","115"]]}	{"answers":[null]}	1
1475	images/931_41200.JPEG	 bagel	{"x":[["122.60000610351562","18.199996948242188"]],"y":[["121.60000610351562","17.199996948242188"]]}	{"answers":[null]}	1
2457	images/691_21569.JPEG	 oxygen mask	{"x":[["185.60000610351562","22"]],"y":[["185.60000610351562","24"]]}	{"answers":[null]}	1
1457	images/931_12185.JPEG	 bagel	{"x":[["82.60000610351562","131.8000030517578"]],"y":[["79.60000610351562","131.8000030517578"]]}	{"answers":[null]}	1
2212	images/330_31891.JPEG	 wood rabbit	{"x":[["19.600006103515625","121.80000305175781"]],"y":[["22.600006103515625","119.80000305175781"]]}	{"answers":[null]}	1
2474	images/691_16073.JPEG	 oxygen mask	{"x":[["113.60000610351562","84.79999542236328"]],"y":[["110.40000610351562","87.19999542236329"]]}	{"answers":[null]}	1
1013	images/729_27976.JPEG	 plate rack	{"x":[["117.60000610351562","83.79999542236328"]],"y":[["116.60000610351562","83.79999542236328"]]}	{"answers":[null]}	1
376	images/697_24976.JPEG	 pajama	{"x":[["17","138"]],"y":[["20.713906763541036","139.4855627054164"]]}	{"answers":[null]}	1
1744	images/678_6716.JPEG	 neck brace	{"x":[["166","153"]],"y":[["166","154"]]}	{"answers":[null]}	1
503	images/724_13435.JPEG	 pirate	{"x":[["249","133"]],"y":[["250","134"]]}	{"answers":[null]}	1
1218	images/819_29686.JPEG	 stage	{"x":[["26.600006103515625","174.1999969482422"]],"y":[["26.600006103515625","175.1999969482422"]]}	{"answers":[null]}	1
149	images/934_28841.JPEG	 hotdog	{"x":[["137.60000610351562","200.1999969482422"]],"y":[["136.60000610351562","200.1999969482422"]]}	{"answers":[null]}	1
750	images/344_11015.JPEG	 hippopotamus	{"x":[["85.60000610351562","119.19999694824219"]],"y":[["81.60000610351562","119.19999694824219"]]}	{"answers":[null]}	1
1356	images/910_21898.JPEG	 wooden spoon	{"x":[["73.60000610351562","3.7999954223632812"]],"y":[["73.60000610351562","4.799995422363281"]]}	{"answers":[null]}	1
595	images/631_36976.JPEG	 lotion	{"x":[["57","50"]],"y":[["56","51"]]}	{"answers":[null]}	1
1280	images/143_4297.JPEG	 oystercatcher	{"x":[["10","98"]],"y":[["11.485562705416415","94.28609323645897"]]}	{"answers":[null]}	1
190	images/254_21725.JPEG	 pug	{"x":[["193","130"]],"y":[["192","131"]]}	{"answers":[null]}	1
2145	images/32_32832.JPEG	 tailed frog	{"x":[["232","128"]],"y":[["234","129"]]}	{"answers":[null]}	1
1687	images/597_48019.JPEG	 holster	{"x":[["131","140"]],"y":[["133.82842712474618","142.82842712474618"]]}	{"answers":[null]}	1
1653	images/590_4159.JPEG	 hand-held computer	{"x":[["4","101"]],"y":[["7.157408869505305","103.45576245405968"]]}	{"answers":[null]}	1
1122	images/379_47477.JPEG	 howler monkey	{"x":[["171","45"]],"y":[["167","45"]]}	{"answers":[null]}	1
1026	images/634_49559.JPEG	 lumbermill	{"x":[["79","161"]],"y":[["79","165"]]}	{"answers":[null]}	1
1578	images/871_47464.JPEG	 trimaran	{"x":[["74","158"]],"y":[["74","157"]]}	{"answers":[null]}	1
359	images/558_9750.JPEG	 flute	{"x":[["126","5"]],"y":[["124.21114561800017","8.577708763999663"]]}	{"answers":[null]}	1
1901	images/664_23404.JPEG	 monitor	{"x":[["206","7"]],"y":[["205.71501180004836","10.98983479932294"]]}	{"answers":[null]}	1
445	images/833_49348.JPEG	 submarine	{"x":[["6","88"]],"y":[["6","89"]]}	{"answers":[null]}	1
2323	images/354_5732.JPEG	 Arabian camel	{"x":[["5","74"]],"y":[["6","75"]]}	{"answers":[null]}	1
1269	images/465_10836.JPEG	 bulletproof vest	{"x":[["90","55"]],"y":[["92","55"]]}	{"answers":[null]}	1
543	images/944_32351.JPEG	 artichoke	{"x":[["11","192"]],"y":[["11.970142500145332","188.11942999941868"]]}	{"answers":[null]}	1
778	images/825_15077.JPEG	 stone wall	{"x":[["0","66"]],"y":[["0","65"]]}	{"answers":[null]}	1
251	images/381_15536.JPEG	 spider monkey	{"x":[["67","202"]],"y":[["64","203"]]}	{"answers":[null]}	1
2002	images/756_47163.JPEG	 rain barrel	{"x":[["149","14"]],"y":[["149","13"]]}	{"answers":[null]}	1
1161	images/876_14299.JPEG	 tub	{"x":[["45","205"]],"y":[["46","205"]]}	{"answers":[null]}	1
1002	images/729_33551.JPEG	 plate rack	{"x":[["54","178"]],"y":[["54","176"]]}	{"answers":[null]}	1
1755	images/626_8076.JPEG	 lighter	{"x":[["111","230"]],"y":[["112","229"]]}	{"answers":[null]}	1
2052	images/502_47340.JPEG	 clog	{"x":[["21","150"]],"y":[["20","151"]]}	{"answers":[null]}	1
769	images/501_49953.JPEG	 cloak	{"x":[["98","20"]],"y":[["99","18"]]}	{"answers":[null]}	1
1484	images/813_45734.JPEG	 spatula	\N	{"answers":[null]}	1
163	images/947_26462.JPEG	 mushroom	{"x":[["12","155"]],"y":[["12","152"]]}	{"answers":[null]}	1
1600	images/871_33436.JPEG	 trimaran	{"x":[["9","175"]],"y":[["12.794733192202056","176.26491106406735"]]}	{"answers":[null]}	1
891	images/545_3356.JPEG	 electric fan	{"x":[["112","115"]],"y":[["115.8460957905633","113.90111548841048"]]}	{"answers":[null]}	1
666	images/781_29214.JPEG	 scoreboard	{"x":[["29","168"]],"y":[["32","168"]]}	{"answers":[null]}	1
1650	images/906_36073.JPEG	 Windsor tie	{"x":[["126","109"]],"y":[["123","111"]]}	{"answers":[null]}	1
2123	images/537_35310.JPEG	 dogsled	{"x":[["117","253"]],"y":[["115.42432280568333","249.32341987992777"]]}	{"answers":[null]}	1
964	images/963_9361.JPEG	 pizza	{"x":[["81","12"]],"y":[["78.78119921509908","15.328201177351374"]]}	{"answers":[null]}	1
350	images/959_37843.JPEG	 carbonara	{"x":[["6","165"]],"y":[["8","167"]]}	{"answers":[null]}	1
2173	images/810_8811.JPEG	 space bar	{"x":[["9","134"]],"y":[["12.959797974644665","134.56568542494924"]]}	{"answers":[null]}	1
1843	images/278_27758.JPEG	 kit fox	{"x":[["87","65"]],"y":[["86","65"]]}	{"answers":[null]}	1
2263	images/642_24002.JPEG	 marimba	{"x":[["49","168"]],"y":[["50","168"]]}	{"answers":[null]}	1
2320	images/354_21344.JPEG	 Arabian camel	{"x":[["14","33"]],"y":[["17","31"]]}	{"answers":[null]}	1
278	images/448_29901.JPEG	 birdhouse	{"x":[["134","132"]],"y":[["133","131"]]}	{"answers":[null]}	1
1775	images/626_24979.JPEG	 lighter	{"x":[["3.5","56"]],"y":[["6.03295116102905","52.904170803186716"]]}	{"answers":[null]}	1
1981	images/864_41760.JPEG	 tow truck	{"x":[["29","121"]],"y":[["26","121"]]}	{"answers":[null]}	1
1445	images/472_12530.JPEG	 canoe	{"x":[["4","155"]],"y":[["7","155"]]}	{"answers":[null]}	1
1341	images/853_33025.JPEG	 thatch	{"x":[["97","32"]],"y":[["95.85060845773462","35.83130514088461"]]}	{"answers":[null]}	1
623	images/563_39445.JPEG	 fountain pen	{"x":[["102.60000610351562","76.19999694824219"]],"y":[["101.60000610351562","76.19999694824219"]]}	{"answers":[null]}	1
1585	images/871_27218.JPEG	 trimaran	{"x":[["119.60000610351562","122.19999694824219"]],"y":[["120.60000610351562","122.19999694824219"]]}	{"answers":[null]}	1
2005	images/756_25633.JPEG	 rain barrel	{"x":[["137.60000610351562","198.1999969482422"]],"y":[["135.20000610351562","201.39999694824218"]]}	{"answers":[null]}	1
2372	images/451_4145.JPEG	 bolo tie	{"x":[["104.60000610351562","7.1999969482421875"]],"y":[["104.60000610351562","9.199996948242188"]]}	{"answers":[null]}	1
2154	images/810_7526.JPEG	 space bar	{"x":[["125.60000610351562","243.1999969482422"]],"y":[["125.60000610351562","246.1999969482422"]]}	{"answers":[null]}	1
517	images/724_30759.JPEG	 pirate	{"x":[["109.60000610351562","46.19999694824219"]],"y":[["109.60000610351562","45.19999694824219"]]}	{"answers":[null]}	1
2231	images/547_9232.JPEG	 electric locomotive	{"x":[["17.600006103515625","184.1999969482422"]],"y":[["18.600006103515625","185.1999969482422"]]}	{"answers":[null]}	1
2456	images/691_4593.JPEG	 oxygen mask	{"x":[["139.60000610351562","114.19999694824219"]],"y":[["141.08556880893204","117.91390371178322"]]}	{"answers":[null]}	1
2085	images/170_17230.JPEG	 Irish wolfhound	{"x":[["51.600006103515625","49.19999694824219"]],"y":[["49.600006103515625","49.19999694824219"]]}	{"answers":[null]}	1
1584	images/871_31762.JPEG	 trimaran	{"x":[["54.600006103515625","93.19999694824219"]],"y":[["54.600006103515625","92.19999694824219"]]}	{"answers":[null]}	1
364	images/558_39752.JPEG	 flute	{"x":[["121.60000610351562","19.199996948242188"]],"y":[["120.60000610351562","19.199996948242188"]]}	{"answers":[null]}	1
72	images/147_8932.JPEG	 grey whale	{"x":[["45.600006103515625","127.19999694824219"]],"y":[["44.600006103515625","128.1999969482422"]]}	{"answers":[null]}	1
968	images/963_37585.JPEG	 pizza	{"x":[["65.60000610351562","181.1999969482422"]],"y":[["67.60000610351562","181.1999969482422"]]}	{"answers":[null]}	1
1159	images/876_40834.JPEG	 tub	{"x":[["18.600006103515625","79.19999694824219"]],"y":[["18.600006103515625","82.19999694824219"]]}	{"answers":[null]}	1
745	images/344_46054.JPEG	 hippopotamus	{"x":[["124.60000610351562","86.19999694824219"]],"y":[["123.60000610351562","86.19999694824219"]]}	{"answers":[null]}	1
1861	images/47_47826.JPEG	 African chameleon	{"x":[["58.600006103515625","5.1999969482421875"]],"y":[["54.600006103515625","5.1999969482421875"]]}	{"answers":[null]}	1
2074	images/502_33270.JPEG	 clog	{"x":[["240.60000610351562","115.19999694824219"]],"y":[["242.60000610351562","117.19999694824219"]]}	{"answers":[null]}	1
2459	images/691_44472.JPEG	 oxygen mask	{"x":[["117.60000610351562","10.199996948242188"]],"y":[["118.60000610351562","10.199996948242188"]]}	{"answers":[null]}	1
714	images/389_18603.JPEG	 barracouta	{"x":[["138.60000610351562","170.1999969482422"]],"y":[["139.60000610351562","170.1999969482422"]]}	{"answers":[null]}	1
1488	images/813_12304.JPEG	 spatula	{"x":[["81.60000610351562","164.8000030517578"]],"y":[["82.60000610351562","165.8000030517578"]]}	{"answers":[null]}	1
300	images/448_46766.JPEG	 birdhouse	{"x":[["123.60000610351562","25.199996948242188"]],"y":[["123.60000610351562","26.199996948242188"]]}	{"answers":[null]}	1
658	images/781_24702.JPEG	 scoreboard	{"x":[["60.600006103515625","59.599998474121094"]],"y":[["61.600006103515625","60.599998474121094"]]}	{"answers":[null]}	1
881	images/545_12314.JPEG	 electric fan	{"x":[["73.60000610351562","78.5999984741211"]],"y":[["73.60000610351562","79.5999984741211"]]}	{"answers":[null]}	1
25	images/903_28064.JPEG	 wig	{"x":[["25.600006103515625","104.5999984741211"]],"y":[["28.600006103515625","104.5999984741211"]]}	{"answers":[null]}	1
1318	images/896_44887.JPEG	 washbasin	{"x":[["185.60000610351562","50.599998474121094"]],"y":[["185.60000610351562","52.599998474121094"]]}	{"answers":[null]}	1
189	images/254_6999.JPEG	 pug	{"x":[["138.60000610351562","85.5999984741211"]],"y":[["140.60000610351562","85.5999984741211"]]}	{"answers":[null]}	1
873	images/806_17077.JPEG	 sock	{"x":[["149.60000610351562","3.5999984741210938"]],"y":[["148.60000610351562","4.599998474121094"]]}	{"answers":[null]}	1
367	images/558_12680.JPEG	 flute	{"x":[["125.60000610351562","74.5999984741211"]],"y":[["124.9424101542942","78.54557416944967"]]}	{"answers":[null]}	1
1417	images/890_17870.JPEG	 volleyball	{"x":[["106.60000610351562","106.5999984741211"]],"y":[["110.17771486751529","108.38885285612092"]]}	{"answers":[null]}	1
410	images/425_30511.JPEG	 barn	\N	{"answers":[null]}	1
1661	images/590_49347.JPEG	 hand-held computer	{"x":[["119","132"]],"y":[["122.72631047794025","133.45416994261083"]]}	{"answers":[null]}	1
2270	images/642_12699.JPEG	 marimba	{"x":[["167","118"]],"y":[["166.22901878387628","121.92499528208435"]]}	{"answers":[null]}	1
1087	images/801_30933.JPEG	 snorkel	{"x":[["202","202"]],"y":[["202.52865488036406","198.03508839726945"]]}	{"answers":[null]}	1
582	images/631_7418.JPEG	 lotion	{"x":[["150","190"]],"y":[["149.8974695968298","186.00131427636208"]]}	{"answers":[null]}	1
33	images/669_15564.JPEG	 mosquito net	{"x":[["81","61"]],"y":[["81","65"]]}	{"answers":[null]}	1
1448	images/472_15090.JPEG	 canoe	{"x":[["162","178"]],"y":[["164","178"]]}	{"answers":[null]}	1
511	images/724_4942.JPEG	 pirate	{"x":[["67","66"]],"y":[["68","66"]]}	{"answers":[null]}	1
1595	images/871_443.JPEG	 trimaran	{"x":[["223","146"]],"y":[["220","146"]]}	{"answers":[null]}	1
191	images/254_44914.JPEG	 pug	{"x":[["71","83"]],"y":[["71","82"]]}	{"answers":[null]}	1
1091	images/801_8925.JPEG	 snorkel	{"x":[["180","44"]],"y":[["180","46"]]}	{"answers":[null]}	1
740	images/344_15578.JPEG	 hippopotamus	{"x":[["162","123"]],"y":[["162","126"]]}	{"answers":[null]}	1
2251	images/642_15698.JPEG	 marimba	{"x":[["166","92"]],"y":[["167","94"]]}	{"answers":[null]}	1
1182	images/470_41387.JPEG	 candle	{"x":[["143","23"]],"y":[["142","23"]]}	{"answers":[null]}	1
652	images/781_3174.JPEG	 scoreboard	{"x":[["153","77"]],"y":[["154","77"]]}	{"answers":[null]}	1
2365	images/451_1781.JPEG	 bolo tie	{"x":[["84","215"]],"y":[["82.73508893593265","211.20526680779795"]]}	{"answers":[null]}	1
232	images/482_34.JPEG	 cassette player	{"x":[["66","132"]],"y":[["67","133"]]}	{"answers":[null]}	1
332	images/959_20071.JPEG	 carbonara	{"x":[["197","131"]],"y":[["198","131"]]}	{"answers":[null]}	1
1857	images/47_17030.JPEG	 African chameleon	{"x":[["2","125"]],"y":[["6","125"]]}	{"answers":[null]}	1
786	images/825_15067.JPEG	 stone wall	{"x":[["127","150"]],"y":[["127","151"]]}	{"answers":[null]}	1
370	images/558_5357.JPEG	 flute	{"x":[["59","54"]],"y":[["58","55"]]}	{"answers":[null]}	1
1238	images/206_3360.JPEG	 curly-coated retriever	{"x":[["192","134"]],"y":[["192","133"]]}	{"answers":[null]}	1
1797	images/905_49697.JPEG	 window shade	{"x":[["9","40"]],"y":[["13","40"]]}	{"answers":[null]}	1
427	images/833_38651.JPEG	 submarine	{"x":[["152","208"]],"y":[["152","206"]]}	{"answers":[null]}	1
2394	images/561_5874.JPEG	 forklift	{"x":[["24","249"]],"y":[["27.745316710276178","247.59550623364643"]]}	{"answers":[null]}	1
1398	images/759_45389.JPEG	 reflex camera	{"x":[["84","185"]],"y":[["80.87652476222787","182.5012198097823"]]}	{"answers":[null]}	1
1062	images/721_35800.JPEG	 pillow	{"x":[["48","243"]],"y":[["51.97553493869447","242.5582738957006"]]}	{"answers":[null]}	1
2245	images/547_9105.JPEG	 electric locomotive	{"x":[["84","175"]],"y":[["87","175"]]}	{"answers":[null]}	1
288	images/448_20834.JPEG	 birdhouse	{"x":[["135","52"]],"y":[["133.01544424657266","55.47297256849784"]]}	{"answers":[null]}	1
1630	images/906_35742.JPEG	 Windsor tie	{"x":[["114","4"]],"y":[["114","5"]]}	{"answers":[null]}	1
2049	images/12_6511.JPEG	 house finch	{"x":[["148","50"]],"y":[["147","50"]]}	{"answers":[null]}	1
47	images/669_25229.JPEG	 mosquito net	{"x":[["54","35"]],"y":[["56.05798302171011","38.429971702850175"]]}	{"answers":[null]}	1
1336	images/853_39179.JPEG	 thatch	{"x":[["28","57"]],"y":[["29","58"]]}	{"answers":[null]}	1
238	images/482_42973.JPEG	 cassette player	{"x":[["62","103"]],"y":[["63","101"]]}	{"answers":[null]}	1
870	images/806_39471.JPEG	 sock	{"x":[["99","65"]],"y":[["98","66"]]}	{"answers":[null]}	1
1900	images/279_25196.JPEG	 Arctic fox	{"x":[["88","131"]],"y":[["92","131"]]}	{"answers":[null]}	1
1176	images/470_5972.JPEG	 candle	{"x":[["114","12"]],"y":[["111.9420169782899","15.429971702850178"]]}	{"answers":[null]}	1
2203	images/330_17903.JPEG	 wood rabbit	{"x":[["102","99"]],"y":[["102","100"]]}	{"answers":[null]}	1
751	images/501_10710.JPEG	 cloak	{"x":[["92","10"]],"y":[["92","11"]]}	{"answers":[null]}	1
216	images/865_36820.JPEG	 toyshop	{"x":[["74","96"]],"y":[["74","98"]]}	{"answers":[null]}	1
283	images/448_35845.JPEG	 birdhouse	{"x":[["97","35"]],"y":[["95","35"]]}	{"answers":[null]}	1
2038	images/12_11761.JPEG	 house finch	{"x":[["189","56"]],"y":[["187","56"]]}	{"answers":[null]}	1
2122	images/537_24954.JPEG	 dogsled	{"x":[["107","124"]],"y":[["107","121"]]}	{"answers":[null]}	1
2121	images/537_14832.JPEG	 dogsled	{"x":[["233","95"]],"y":[["231.30225062474568","101.79099750101733"]]}	{"answers":[null]}	1
1185	images/470_17425.JPEG	 candle	{"x":[["111","25"]],"y":[["111","26"]]}	{"answers":[null]}	1
1577	images/871_33146.JPEG	 trimaran	{"x":[["247","246"]],"y":[["245","246"]]}	{"answers":[null]}	1
833	images/826_1588.JPEG	 stopwatch	{"x":[["78","135"]],"y":[["78","137"]]}	{"answers":[null]}	1
1222	images/819_23437.JPEG	 stage	{"x":[["36","136"]],"y":[["40","136"]]}	{"answers":[null]}	1
925	images/277_44681.JPEG	 red fox	{"x":[["162","85"]],"y":[["165","85"]]}	{"answers":[null]}	1
2435	images/95_22095.JPEG	 jacamar	{"x":[["124","91"]],"y":[["121","91"]]}	{"answers":[null]}	1
399	images/697_41623.JPEG	 pajama	{"x":[["120","89"]],"y":[["121","89"]]}	{"answers":[null]}	1
2336	images/391_32154.JPEG	 coho	{"x":[["4","115"]],"y":[["3","115"]]}	{"answers":[null]}	1
418	images/425_27090.JPEG	 barn	{"x":[["12","88"]],"y":[["11","86"]]}	{"answers":[null]}	1
1331	images/853_402.JPEG	 thatch	{"x":[["14","63"]],"y":[["14","60"]]}	{"answers":[null]}	1
952	images/963_40973.JPEG	 pizza	{"x":[["95","72"]],"y":[["95","73"]]}	{"answers":[null]}	1
130	images/934_43233.JPEG	 hotdog	{"x":[["3","140"]],"y":[["3","141"]]}	{"answers":[null]}	1
1226	images/206_20414.JPEG	 curly-coated retriever	{"x":[["172","179"]],"y":[["172","177"]]}	{"answers":[null]}	1
2431	images/95_4114.JPEG	 jacamar	{"x":[["187","43"]],"y":[["183","43"]]}	{"answers":[null]}	1
1509	images/684_30726.JPEG	 ocarina	{"x":[["5","86"]],"y":[["5","87"]]}	{"answers":[null]}	1
646	images/604_43619.JPEG	 hourglass	{"x":[["112","8"]],"y":[["114","7"]]}	{"answers":[null]}	1
1802	images/548_22291.JPEG	 entertainment center	{"x":[["69","67"]],"y":[["69","73"]]}	{"answers":[null]}	1
2327	images/391_41331.JPEG	 coho	{"x":[["163","80"]],"y":[["162.01005050633884","86.92964645562816"]]}	{"answers":[null]}	1
1824	images/548_16800.JPEG	 entertainment center	{"x":[["55","138"]],"y":[["61","138"]]}	{"answers":[null]}	1
1219	images/819_19066.JPEG	 stage	{"x":[["74","149"]],"y":[["76","149"]]}	{"answers":[null]}	1
1057	images/721_12367.JPEG	 pillow	{"x":[["16","6"]],"y":[["22.929646455628166","6.989949493661166"]]}	{"answers":[null]}	1
590	images/631_39626.JPEG	 lotion	{"x":[["46","65"]],"y":[["46","62"]]}	{"answers":[null]}	1
755	images/501_8205.JPEG	 cloak	{"x":[["190","79"]],"y":[["188","80"]]}	{"answers":[null]}	1
1009	images/729_27348.JPEG	 plate rack	{"x":[["51","59"]],"y":[["51","60"]]}	{"answers":[null]}	1
1139	images/667_40532.JPEG	 mortarboard	{"x":[["66","139"]],"y":[["66","137"]]}	{"answers":[null]}	1
1706	images/970_2959.JPEG	 alp	{"x":[["15","74"]],"y":[["14","73"]]}	{"answers":[null]}	1
1836	images/278_45154.JPEG	 kit fox	{"x":[["64","97"]],"y":[["66","98"]]}	{"answers":[null]}	1
1288	images/143_5610.JPEG	 oystercatcher	{"x":[["154","108"]],"y":[["154","105"]]}	{"answers":[null]}	1
321	images/101_5659.JPEG	 tusker	{"x":[["61","237"]],"y":[["61","236"]]}	{"answers":[null]}	1
2218	images/330_46502.JPEG	 wood rabbit	{"x":[["153","57"]],"y":[["153","61"]]}	{"answers":[null]}	1
1985	images/864_32964.JPEG	 tow truck	{"x":[["29","114"]],"y":[["32","114"]]}	{"answers":[null]}	1
997	images/22_44026.JPEG	 bald eagle	{"x":[["104","51"]],"y":[["104","52"]]}	{"answers":[null]}	1
2060	images/502_30646.JPEG	 clog	{"x":[["249","234"]],"y":[["245","234"]]}	{"answers":[null]}	1
498	images/485_43255.JPEG	 CD player	{"x":[["76","191"]],"y":[["80","191"]]}	{"answers":[null]}	1
141	images/934_42858.JPEG	 hotdog	{"x":[["94","34"]],"y":[["99.31479621655707","29.44446038580822"]]}	{"answers":[null]}	1
1915	images/664_17181.JPEG	 monitor	{"x":[["54","13"]],"y":[["60.95718614271533","12.226979317476074"]]}	{"answers":[null]}	1
390	images/697_38791.JPEG	 pajama	{"x":[["119","151"]],"y":[["121","151"]]}	{"answers":[null]}	1
552	images/171_46615.JPEG	 Italian greyhound	{"x":[["110","41"]],"y":[["112","41"]]}	{"answers":[null]}	1
2065	images/502_19204.JPEG	 clog	{"x":[["11","66"]],"y":[["15.949747468305834","70.94974746830583"]]}	{"answers":[null]}	1
1299	images/143_33772.JPEG	 oystercatcher	{"x":[["72","120"]],"y":[["73","120"]]}	{"answers":[null]}	1
2140	images/32_3094.JPEG	 tailed frog	{"x":[["133","88"]],"y":[["133.30406056993414","94.99339310848542"]]}	{"answers":[null]}	1
1045	images/634_15796.JPEG	 lumbermill	{"x":[["89","46"]],"y":[["93","49"]]}	{"answers":[null]}	1
1435	images/472_21339.JPEG	 canoe	{"x":[["87","209"]],"y":[["91","211"]]}	{"answers":[null]}	1
1827	images/278_6061.JPEG	 kit fox	{"x":[["148","28"]],"y":[["147","31"]]}	{"answers":[null]}	1
1808	images/548_44432.JPEG	 entertainment center	{"x":[["47","42"]],"y":[["48","43"]]}	{"answers":[null]}	1
1611	images/325_2337.JPEG	 sulphur butterfly	{"x":[["22","182"]],"y":[["22","186"]]}	{"answers":[null]}	1
1950	images/224_9602.JPEG	 groenendael	{"x":[["53","106"]],"y":[["54","106"]]}	{"answers":[null]}	1
1463	images/931_14224.JPEG	 bagel	{"x":[["87","86"]],"y":[["86","87"]]}	{"answers":[null]}	1
840	images/826_27423.JPEG	 stopwatch	{"x":[["112","80"]],"y":[["114","77"]]}	{"answers":[null]}	1
2373	images/451_29382.JPEG	 bolo tie	{"x":[["159","173"]],"y":[["160","173"]]}	{"answers":[null]}	1
534	images/944_35345.JPEG	 artichoke	{"x":[["176","51"]],"y":[["177","51"]]}	{"answers":[null]}	1
508	images/724_7459.JPEG	 pirate	{"x":[["186","99"]],"y":[["179.62743465776177","96.10337938989171"]]}	{"answers":[null]}	1
145	images/934_41811.JPEG	 hotdog	{"x":[["202","64"]],"y":[["197.8","69.6"]]}	{"answers":[null]}	1
894	images/545_44909.JPEG	 electric fan	{"x":[["39","178"]],"y":[["37.93559971022241","184.91860188355432"]]}	{"answers":[null]}	1
2118	images/537_21530.JPEG	 dogsled	{"x":[["121","4"]],"y":[["125","4"]]}	{"answers":[null]}	1
2471	images/691_2433.JPEG	 oxygen mask	{"x":[["73","30"]],"y":[["71","31"]]}	{"answers":[null]}	1
643	images/604_30800.JPEG	 hourglass	{"x":[["62","16"]],"y":[["65.47297256849784","22.077701994871216"]]}	{"answers":[null]}	1
560	images/171_19561.JPEG	 Italian greyhound	{"x":[["186","145"]],"y":[["189.39950051825042","151.11910093285076"]]}	{"answers":[null]}	1
2087	images/170_8462.JPEG	 Irish wolfhound	{"x":[["84","26"]],"y":[["84","33"]]}	{"answers":[null]}	1
2198	images/773_5401.JPEG	 saltshaker	{"x":[["159","43"]],"y":[["159","49"]]}	{"answers":[null]}	1
2383	images/561_17857.JPEG	 forklift	{"x":[["111","64"]],"y":[["106.88279811627467","69.66115259012233"]]}	{"answers":[null]}	1
1807	images/548_40452.JPEG	 entertainment center	{"x":[["77","149"]],"y":[["77","148"]]}	{"answers":[null]}	1
97	images/260_17488.JPEG	 chow	{"x":[["230.5","118"]],"y":[["229.5","119"]]}	{"answers":[null]}	1
1123	images/379_48655.JPEG	 howler monkey	{"x":[["116.5","85"]],"y":[["118.5","85"]]}	{"answers":[null]}	1
346	images/959_13353.JPEG	 carbonara	{"x":[["97","111"]],"y":[["93.52702743150216","117.07770199487122"]]}	{"answers":[null]}	1
426	images/833_23666.JPEG	 submarine	{"x":[["73","8"]],"y":[["73","11"]]}	{"answers":[null]}	1
1569	images/770_36786.JPEG	 running shoe	{"x":[["11","19"]],"y":[["15.40438760067575","24.440714094952398"]]}	{"answers":[null]}	1
752	images/501_44421.JPEG	 cloak	{"x":[["172","33"]],"y":[["171","33"]]}	{"answers":[null]}	1
1502	images/684_42586.JPEG	 ocarina	{"x":[["162","46"]],"y":[["163","46"]]}	{"answers":[null]}	1
2240	images/547_37126.JPEG	 electric locomotive	{"x":[["8","61"]],"y":[["4","60"]]}	{"answers":[null]}	1
1764	images/626_39493.JPEG	 lighter	{"x":[["117","106"]],"y":[["122","103"]]}	{"answers":[null]}	1
156	images/947_13730.JPEG	 mushroom	{"x":[["134","120"]],"y":[["134","116"]]}	{"answers":[null]}	1
1546	images/293_25361.JPEG	 cheetah	{"x":[["52","95"]],"y":[["51","95"]]}	{"answers":[null]}	1
2055	images/502_38204.JPEG	 clog	{"x":[["146","90"]],"y":[["148","93"]]}	{"answers":[null]}	1
703	images/389_33723.JPEG	 barracouta	{"x":[["252","79"]],"y":[["252","86"]]}	{"answers":[null]}	1
225	images/865_13952.JPEG	 toyshop	{"x":[["7","166"]],"y":[["7","161"]]}	{"answers":[null]}	1
421	images/425_27613.JPEG	 barn	{"x":[["119","113"]],"y":[["119","119"]]}	{"answers":[null]}	1
1323	images/896_4059.JPEG	 washbasin	{"x":[["81","175"]],"y":[["81","171"]]}	{"answers":[null]}	1
87	images/260_35794.JPEG	 chow	{"x":[["87","111"]],"y":[["87","107"]]}	{"answers":[null]}	1
2423	images/690_46185.JPEG	 oxcart	{"x":[["24","131"]],"y":[["24","129"]]}	{"answers":[null]}	1
915	images/277_28083.JPEG	 red fox	{"x":[["166","42"]],"y":[["166","45"]]}	{"answers":[null]}	1
1871	images/47_20739.JPEG	 African chameleon	{"x":[["250","68"]],"y":[["249.13175685787553","61.054054863004325"]]}	{"answers":[null]}	1
2237	images/547_18789.JPEG	 electric locomotive	{"x":[["38","82"]],"y":[["38","86"]]}	{"answers":[null]}	1
1024	images/729_24672.JPEG	 plate rack	{"x":[["76","212"]],"y":[["76","216"]]}	{"answers":[null]}	1
989	images/22_16433.JPEG	 bald eagle	{"x":[["162","23"]],"y":[["162","25"]]}	{"answers":[null]}	1
1703	images/970_22221.JPEG	 alp	{"x":[["8","117"]],"y":[["8","121"]]}	{"answers":[null]}	1
728	images/344_18888.JPEG	 hippopotamus	{"x":[["15","131"]],"y":[["15","138"]]}	{"answers":[null]}	1
442	images/833_31355.JPEG	 submarine	{"x":[["135","127"]],"y":[["136","127"]]}	{"answers":[null]}	1
2384	images/561_8800.JPEG	 forklift	{"x":[["0","79"]],"y":[["4","79"]]}	{"answers":[null]}	1
1742	images/678_13935.JPEG	 neck brace	{"x":[["116","130"]],"y":[["116","135"]]}	{"answers":[null]}	1
165	images/947_41894.JPEG	 mushroom	{"x":[["42","62"]],"y":[["42","67"]]}	{"answers":[null]}	1
1416	images/890_6608.JPEG	 volleyball	{"x":[["101","144"]],"y":[["106.37754895718163","139.51870920234865"]]}	{"answers":[null]}	1
706	images/389_49298.JPEG	 barracouta	{"x":[["138","81"]],"y":[["140.75743509005417","87.4340152101264"]]}	{"answers":[null]}	1
103	images/440_19267.JPEG	 beer bottle	{"x":[["141","133"]],"y":[["141","134"]]}	{"answers":[null]}	1
2368	images/451_14210.JPEG	 bolo tie	{"x":[["113","18"]],"y":[["112","18"]]}	{"answers":[null]}	1
1967	images/179_6000.JPEG	 Staffordshire bullterrier	{"x":[["142","27"]],"y":[["142","29"]]}	{"answers":[null]}	1
456	images/750_4658.JPEG	 quilt	{"x":[["190","88"]],"y":[["190","90"]]}	{"answers":[null]}	1
2103	images/537_33940.JPEG	 dogsled	{"x":[["74","158"]],"y":[["80","158"]]}	{"answers":[null]}	1
810	images/921_33925.JPEG	 book jacket	{"x":[["5","69"]],"y":[["5","73"]]}	{"answers":[null]}	1
559	images/171_20406.JPEG	 Italian greyhound	{"x":[["12","148"]],"y":[["14","150"]]}	{"answers":[null]}	1
1086	images/801_18317.JPEG	 snorkel	{"x":[["110","97"]],"y":[["109","98"]]}	{"answers":[null]}	1
2433	images/95_26713.JPEG	 jacamar	{"x":[["175","14"]],"y":[["174","14"]]}	{"answers":[null]}	1
930	images/498_14548.JPEG	 cinema	{"x":[["9","112"]],"y":[["13","112"]]}	{"answers":[null]}	1
1493	images/813_15152.JPEG	 spatula	{"x":[["55","51"]],"y":[["55","53"]]}	{"answers":[null]}	1
829	images/826_17602.JPEG	 stopwatch	\N	{"answers":[null]}	1
1543	images/293_16280.JPEG	 cheetah	{"x":[["100","59"]],"y":[["100","60"]]}	{"answers":[null]}	1
1151	images/876_16794.JPEG	 tub	{"x":[["75","52"]],"y":[["75.98994949366117","45.070353544371834"]]}	{"answers":[null]}	1
1688	images/597_25535.JPEG	 holster	{"x":[["74","37"]],"y":[["74","38"]]}	{"answers":[null]}	1
1208	images/819_38066.JPEG	 stage	{"x":[["72","246"]],"y":[["75","244"]]}	{"answers":[null]}	1
473	images/750_21865.JPEG	 quilt	{"x":[["184","19"]],"y":[["185","25"]]}	{"answers":[null]}	1
384	images/697_15741.JPEG	 pajama	{"x":[["106","36"]],"y":[["106","43"]]}	{"answers":[null]}	1
244	images/482_24410.JPEG	 cassette player	{"x":[["178","133"]],"y":[["178","134"]]}	{"answers":[null]}	1
985	images/22_32699.JPEG	 bald eagle	{"x":[["76","21"]],"y":[["76","27"]]}	{"answers":[null]}	1
1507	images/684_45883.JPEG	 ocarina	{"x":[["39","102"]],"y":[["41","102"]]}	{"answers":[null]}	1
146	images/934_4317.JPEG	 hotdog	{"x":[["195","135"]],"y":[["197","135"]]}	{"answers":[null]}	1
1376	images/759_39205.JPEG	 reflex camera	{"x":[["57","207"]],"y":[["58","207"]]}	{"answers":[null]}	1
1252	images/465_6332.JPEG	 bulletproof vest	{"x":[["205","105"]],"y":[["205","107"]]}	{"answers":[null]}	1
659	images/781_15880.JPEG	 scoreboard	{"x":[["68","46"]],"y":[["68","53"]]}	{"answers":[null]}	1
2462	images/691_23593.JPEG	 oxygen mask	{"x":[["67","135"]],"y":[["65","135"]]}	{"answers":[null]}	1
2301	images/354_26431.JPEG	 Arabian camel	{"x":[["135","151"]],"y":[["135","155"]]}	{"answers":[null]}	1
2348	images/391_15424.JPEG	 coho	{"x":[["179","69"]],"y":[["179","75"]]}	{"answers":[null]}	1
1149	images/667_3445.JPEG	 mortarboard	{"x":[["140","48"]],"y":[["140","49"]]}	{"answers":[null]}	1
1616	images/325_4746.JPEG	 sulphur butterfly	{"x":[["127","57"]],"y":[["121","57"]]}	{"answers":[null]}	1
1419	images/890_15640.JPEG	 volleyball	{"x":[["69","21"]],"y":[["69","25"]]}	{"answers":[null]}	1
880	images/545_43913.JPEG	 electric fan	{"x":[["38","228"]],"y":[["39","228"]]}	{"answers":[null]}	1
436	images/833_5614.JPEG	 submarine	{"x":[["100","49"]],"y":[["98.30225062474567","55.79099750101732"]]}	{"answers":[null]}	1
648	images/604_47742.JPEG	 hourglass	{"x":[["134","98"]],"y":[["134","103"]]}	{"answers":[null]}	1
1298	images/143_37096.JPEG	 oystercatcher	{"x":[["102","112"]],"y":[["107","110"]]}	{"answers":[null]}	1
882	images/545_27251.JPEG	 electric fan	{"x":[["108","81"]],"y":[["108","83"]]}	{"answers":[null]}	1
276	images/448_30637.JPEG	 birdhouse	{"x":[["39","73"]],"y":[["39","71"]]}	{"answers":[null]}	1
2381	images/561_15017.JPEG	 forklift	{"x":[["249","192"]],"y":[["243","192"]]}	{"answers":[null]}	1
95	images/260_38955.JPEG	 chow	{"x":[["78","78"]],"y":[["78","79"]]}	{"answers":[null]}	1
1058	images/721_10433.JPEG	 pillow	{"x":[["25","45"]],"y":[["22.786405637882133","51.64078308635359"]]}	{"answers":[null]}	1
2104	images/537_4954.JPEG	 dogsled	{"x":[["77","202"]],"y":[["77","207"]]}	{"answers":[null]}	1
2342	images/391_8296.JPEG	 coho	{"x":[["142","112"]],"y":[["142","119"]]}	{"answers":[null]}	1
1270	images/465_1559.JPEG	 bulletproof vest	{"x":[["49","37"]],"y":[["45.60049948174958","43.11910093285076"]]}	{"answers":[null]}	1
2254	images/642_31666.JPEG	 marimba	{"x":[["171","69"]],"y":[["170","69"]]}	{"answers":[null]}	1
1147	images/667_35061.JPEG	 mortarboard	{"x":[["186","43"]],"y":[["187","43"]]}	{"answers":[null]}	1
1373	images/910_11494.JPEG	 wooden spoon	{"x":[["129","106"]],"y":[["132","106"]]}	{"answers":[null]}	1
1521	images/684_28464.JPEG	 ocarina	{"x":[["47","91"]],"y":[["47","97"]]}	{"answers":[null]}	1
1150	images/667_32905.JPEG	 mortarboard	{"x":[["65","42"]],"y":[["71.82073836986234","43.57401654689131"]]}	{"answers":[null]}	1
673	images/781_13179.JPEG	 scoreboard	{"x":[["91","56"]],"y":[["91","57"]]}	{"answers":[null]}	1
563	images/171_29250.JPEG	 Italian greyhound	{"x":[["62","47"]],"y":[["63","47"]]}	{"answers":[null]}	1
1739	images/678_39330.JPEG	 neck brace	{"x":[["121","152"]],"y":[["125.94974746830583","147.05025253169416"]]}	{"answers":[null]}	1
2374	images/451_48390.JPEG	 bolo tie	{"x":[["89","28"]],"y":[["89","35"]]}	{"answers":[null]}	1
607	images/563_1297.JPEG	 fountain pen	{"x":[["137","103"]],"y":[["137","105"]]}	{"answers":[null]}	1
352	images/558_15530.JPEG	 flute	{"x":[["80","136"]],"y":[["80","134"]]}	{"answers":[null]}	1
1652	images/590_32143.JPEG	 hand-held computer	{"x":[["51","179"]],"y":[["56","175"]]}	{"answers":[null]}	1
125	images/440_5752.JPEG	 beer bottle	{"x":[["186","53"]],"y":[["185.36624977770236","59.971252445273926"]]}	{"answers":[null]}	1
856	images/806_34611.JPEG	 sock	{"x":[["97","99"]],"y":[["100","99"]]}	{"answers":[null]}	1
2485	images/978_8778.JPEG	 seashore	{"x":[["4","106"]],"y":[["9","108"]]}	{"answers":[null]}	1
1202	images/819_23747.JPEG	 stage	{"x":[["11","169"]],"y":[["11","170"]]}	{"answers":[null]}	1
1658	images/590_30142.JPEG	 hand-held computer	{"x":[["171","75"]],"y":[["171","77"]]}	{"answers":[null]}	1
2023	images/756_17351.JPEG	 rain barrel	{"x":[["91","187"]],"y":[["91","189"]]}	{"answers":[null]}	1
2007	images/756_25638.JPEG	 rain barrel	{"x":[["95","72"]],"y":[["99","72"]]}	{"answers":[null]}	1
748	images/344_31752.JPEG	 hippopotamus	{"x":[["56","91"]],"y":[["58","91"]]}	{"answers":[null]}	1
1887	images/279_34329.JPEG	 Arctic fox	{"x":[["133","18"]],"y":[["136","18"]]}	{"answers":[null]}	1
963	images/963_38562.JPEG	 pizza	{"x":[["68","42"]],"y":[["70","42"]]}	{"answers":[null]}	1
725	images/389_4655.JPEG	 barracouta	{"x":[["20","198"]],"y":[["19","202"]]}	{"answers":[null]}	1
1429	images/472_36406.JPEG	 canoe	{"x":[["7","152"]],"y":[["7","155"]]}	{"answers":[null]}	1
1789	images/905_22094.JPEG	 window shade	{"x":[["102","99"]],"y":[["102","103"]]}	{"answers":[null]}	1
681	images/663_28700.JPEG	 monastery	{"x":[["53","73"]],"y":[["53","68"]]}	{"answers":[null]}	1
440	images/833_499.JPEG	 submarine	{"x":[["84","103"]],"y":[["84","107"]]}	{"answers":[null]}	1
1104	images/379_40724.JPEG	 howler monkey	{"x":[["103","120"]],"y":[["103","122"]]}	{"answers":[null]}	1
2443	images/95_25853.JPEG	 jacamar	{"x":[["121","49"]],"y":[["126.37754895718163","53.48129079765136"]]}	{"answers":[null]}	1
299	images/448_5738.JPEG	 birdhouse	{"x":[["123","61"]],"y":[["123","62"]]}	{"answers":[null]}	1
528	images/944_28372.JPEG	 artichoke	{"x":[["179","130"]],"y":[["172.55322924252008","132.72747993585688"]]}	{"answers":[null]}	1
1474	images/931_44684.JPEG	 bagel	{"x":[["121","208"]],"y":[["118.88014804465634","214.67129880064036"]]}	{"answers":[null]}	1
787	images/825_10359.JPEG	 stone wall	{"x":[["164.5","99"]],"y":[["162.28640563788213","105.6407830863536"]]}	{"answers":[null]}	1
2496	images/978_6963.JPEG	 seashore	{"x":[["162.5","140"]],"y":[["155.50151860290322","139.85419830422714"]]}	{"answers":[null]}	1
9	images/903_35190.JPEG	 wig	{"x":[["139.5","88"]],"y":[["139.5","81"]]}	{"answers":[null]}	1
1355	images/910_28324.JPEG	 wooden spoon	{"x":[["247.5","100"]],"y":[["242.18520378344292","104.55553961419179"]]}	{"answers":[null]}	1
661	images/781_21785.JPEG	 scoreboard	{"x":[["174.5","123"]],"y":[["173.5","123"]]}	{"answers":[null]}	1
531	images/944_19102.JPEG	 artichoke	{"x":[["239.5","79"]],"y":[["239.5","72"]]}	{"answers":[null]}	1
2477	images/978_38934.JPEG	 seashore	{"x":[["9.5","107"]],"y":[["10.5","107"]]}	{"answers":[null]}	1
1823	images/548_46173.JPEG	 entertainment center	{"x":[["26.5","61"]],"y":[["26.5","62"]]}	{"answers":[null]}	1
435	images/833_5334.JPEG	 submarine	{"x":[["102.5","70"]],"y":[["96.9","74.2"]]}	{"answers":[null]}	1
1540	images/293_44226.JPEG	 cheetah	{"x":[["23.5","28"]],"y":[["23.5","29"]]}	{"answers":[null]}	1
852	images/806_26084.JPEG	 sock	{"x":[["24.5","24"]],"y":[["24.5","28"]]}	{"answers":[null]}	1
1933	images/224_1309.JPEG	 groenendael	{"x":[["75.5","19"]],"y":[["75.5","20"]]}	{"answers":[null]}	1
317	images/101_30139.JPEG	 tusker	{"x":[["55.5","115"]],"y":[["55.5","116"]]}	{"answers":[null]}	1
1400	images/759_29264.JPEG	 reflex camera	{"x":[["151.5","49"]],"y":[["144.5","49"]]}	{"answers":[null]}	1
1662	images/590_15610.JPEG	 hand-held computer	{"x":[["42.5","54"]],"y":[["43.5","54"]]}	{"answers":[null]}	1
2390	images/561_15823.JPEG	 forklift	{"x":[["133.5","41"]],"y":[["128.55025253169416","45.94974746830583"]]}	{"answers":[null]}	1
1140	images/667_15775.JPEG	 mortarboard	{"x":[["62.5","56"]],"y":[["64.5","55"]]}	{"answers":[null]}	1
57	images/147_20632.JPEG	 grey whale	{"x":[["89.5","78"]],"y":[["89.5","83"]]}	{"answers":[null]}	1
2293	images/280_14406.JPEG	 grey fox	{"x":[["23.5","18"]],"y":[["24.5","18"]]}	{"answers":[null]}	1
776	images/825_8085.JPEG	 stone wall	{"x":[["66.5","75"]],"y":[["68.5","75"]]}	{"answers":[null]}	1
1360	images/910_11292.JPEG	 wooden spoon	{"x":[["131.5","29"]],"y":[["131.5","32"]]}	{"answers":[null]}	1
177	images/254_43989.JPEG	 pug	{"x":[["88.5","65"]],"y":[["87.5","65"]]}	{"answers":[null]}	1
946	images/498_7381.JPEG	 cinema	{"x":[["62.5","197"]],"y":[["62.5","192"]]}	{"answers":[null]}	1
2086	images/170_26577.JPEG	 Irish wolfhound	{"x":[["118.5","95"]],"y":[["124.02546552163429","90.70241570539555"]]}	{"answers":[null]}	1
1273	images/465_46382.JPEG	 bulletproof vest	{"x":[["132.5","181"]],"y":[["133.5","181"]]}	{"answers":[null]}	1
818	images/921_38523.JPEG	 book jacket	{"x":[["140.5","77"]],"y":[["138.5","77"]]}	{"answers":[null]}	1
1644	images/906_42495.JPEG	 Windsor tie	{"x":[["152.5","91"]],"y":[["154.5","91"]]}	{"answers":[null]}	1
2190	images/773_47775.JPEG	 saltshaker	{"x":[["51.5","32"]],"y":[["52.5","32"]]}	{"answers":[null]}	1
1345	images/853_9033.JPEG	 thatch	{"x":[["70.5","138"]],"y":[["72.5","138"]]}	{"answers":[null]}	1
535	images/944_36726.JPEG	 artichoke	{"x":[["117.5","55"]],"y":[["113.5","60"]]}	{"answers":[null]}	1
2386	images/561_47422.JPEG	 forklift	{"x":[["29.5","118"]],"y":[["30.5","118"]]}	{"answers":[null]}	1
256	images/381_8007.JPEG	 spider monkey	{"x":[["161.5","73"]],"y":[["161.5","77"]]}	{"answers":[null]}	1
489	images/485_30079.JPEG	 CD player	{"x":[["44.5","146"]],"y":[["45.5","146"]]}	{"answers":[null]}	1
1567	images/770_30504.JPEG	 running shoe	{"x":[["124.5","102"]],"y":[["126.5","102"]]}	{"answers":[null]}	1
620	images/563_49908.JPEG	 fountain pen	{"x":[["66.5","38"]],"y":[["68.5","38"]]}	{"answers":[null]}	1
2137	images/32_18384.JPEG	 tailed frog	{"x":[["105.5","106"]],"y":[["108.6304951684997","112.26099033699941"]]}	{"answers":[null]}	1
1886	images/279_23922.JPEG	 Arctic fox	{"x":[["100.5","132"]],"y":[["103.5","132"]]}	{"answers":[null]}	1
277	images/448_25675.JPEG	 birdhouse	{"x":[["150.5","46"]],"y":[["147.5","46"]]}	{"answers":[null]}	1
1777	images/905_43181.JPEG	 window shade	{"x":[["39.5","96"]],"y":[["42.5","96"]]}	{"answers":[null]}	1
592	images/631_23078.JPEG	 lotion	{"x":[["134.5","56"]],"y":[["133.5","56"]]}	{"answers":[null]}	1
713	images/389_43031.JPEG	 barracouta	{"x":[["80.5","114"]],"y":[["79.5","114"]]}	{"answers":[null]}	1
116	images/440_18988.JPEG	 beer bottle	{"x":[["77.5","159"]],"y":[["78.5","160"]]}	{"answers":[null]}	1
1217	images/819_40066.JPEG	 stage	{"x":[["33.5","72"]],"y":[["34.5","72"]]}	{"answers":[null]}	1
966	images/963_27634.JPEG	 pizza	{"x":[["132.5","42"]],"y":[["132.5","49"]]}	{"answers":[null]}	1
323	images/101_17187.JPEG	 tusker	{"x":[["111.5","106"]],"y":[["111.5","108"]]}	{"answers":[null]}	1
2389	images/561_42807.JPEG	 forklift	{"x":[["92.5","72"]],"y":[["93.5","72"]]}	{"answers":[null]}	1
2283	images/280_29902.JPEG	 grey fox	{"x":[["130.5","171"]],"y":[["125.55025253169417","175.94974746830584"]]}	{"answers":[null]}	1
2067	images/502_1212.JPEG	 clog	{"x":[["20.5","93"]],"y":[["22.5","94"]]}	{"answers":[null]}	1
1883	images/279_6498.JPEG	 Arctic fox	{"x":[["189.5","182"]],"y":[["192.5","184"]]}	{"answers":[null]}	1
395	images/697_29200.JPEG	 pajama	{"x":[["150.5","97"]],"y":[["152.5","97"]]}	{"answers":[null]}	1
1935	images/224_34321.JPEG	 groenendael	{"x":[["44.5","50"]],"y":[["43.5","50"]]}	{"answers":[null]}	1
1459	images/931_35385.JPEG	 bagel	{"x":[["167.5","98"]],"y":[["168.5","98"]]}	{"answers":[null]}	1
1669	images/590_44024.JPEG	 hand-held computer	{"x":[["132.5","201"]],"y":[["134.5","201"]]}	{"answers":[null]}	1
1559	images/770_18700.JPEG	 running shoe	{"x":[["53","118"]],"y":[["55","118"]]}	{"answers":[null]}	1
450	images/833_8984.JPEG	 submarine	{"x":[["109","104"]],"y":[["108","102"]]}	{"answers":[null]}	1
2142	images/32_23373.JPEG	 tailed frog	{"x":[["128","58"]],"y":[["128","65"]]}	{"answers":[null]}	1
675	images/781_2654.JPEG	 scoreboard	{"x":[["209","167"]],"y":[["206","167"]]}	{"answers":[null]}	1
935	images/498_18557.JPEG	 cinema	{"x":[["161.5","66"]],"y":[["157.5","67"]]}	{"answers":[null]}	1
2479	images/978_19725.JPEG	 seashore	{"x":[["12.5","167"]],"y":[["14.5","167"]]}	{"answers":[null]}	1
1618	images/325_18234.JPEG	 sulphur butterfly	{"x":[["26.5","23"]],"y":[["26.5","25"]]}	{"answers":[null]}	1
898	images/545_6847.JPEG	 electric fan	{"x":[["155.5","103"]],"y":[["148.70900249898267","101.30225062474567"]]}	{"answers":[null]}	1
1028	images/634_11397.JPEG	 lumbermill	{"x":[["173.5","33"]],"y":[["171.5","33"]]}	{"answers":[null]}	1
101	images/440_16693.JPEG	 beer bottle	{"x":[["28.5","209"]],"y":[["33.81479621655708","213.5555396141918"]]}	{"answers":[null]}	1
1393	images/759_9170.JPEG	 reflex camera	{"x":[["214","142"]],"y":[["215","141"]]}	{"answers":[null]}	1
1729	images/678_1691.JPEG	 neck brace	{"x":[["78","130"]],"y":[["78","133"]]}	{"answers":[null]}	1
1227	images/206_32924.JPEG	 curly-coated retriever	{"x":[["6","73"]],"y":[["6.63375022229763","79.97125244527393"]]}	{"answers":[null]}	1
2014	images/756_33493.JPEG	 rain barrel	{"x":[["158","89"]],"y":[["158","86"]]}	{"answers":[null]}	1
1737	images/678_48081.JPEG	 neck brace	{"x":[["89","67"]],"y":[["90","68"]]}	{"answers":[null]}	1
463	images/750_36627.JPEG	 quilt	{"x":[["254","130"]],"y":[["250","131"]]}	{"answers":[null]}	1
361	images/558_49252.JPEG	 flute	{"x":[["42","77"]],"y":[["48.3070116883137","80.0367093314103"]]}	{"answers":[null]}	1
2441	images/95_22213.JPEG	 jacamar	{"x":[["89","37"]],"y":[["90","38"]]}	{"answers":[null]}	1
1928	images/224_28827.JPEG	 groenendael	{"x":[["149","32"]],"y":[["150","33"]]}	{"answers":[null]}	1
29	images/669_18175.JPEG	 mosquito net	{"x":[["12","75"]],"y":[["10","75"]]}	{"answers":[null]}	1
931	images/498_28115.JPEG	 cinema	{"x":[["52","27"]],"y":[["52","34"]]}	{"answers":[null]}	1
644	images/604_35819.JPEG	 hourglass	{"x":[["66","5"]],"y":[["71.20305902373016","9.682753121357148"]]}	{"answers":[null]}	1
1498	images/813_49303.JPEG	 spatula	{"x":[["180","215"]],"y":[["173","215"]]}	{"answers":[null]}	1
1382	images/759_24021.JPEG	 reflex camera	{"x":[["85","1"]],"y":[["85","5"]]}	{"answers":[null]}	1
1015	images/729_31028.JPEG	 plate rack	{"x":[["155","180"]],"y":[["150","179"]]}	{"answers":[null]}	1
1837	images/278_31370.JPEG	 kit fox	{"x":[["155","162"]],"y":[["151","159"]]}	{"answers":[null]}	1
1189	images/470_629.JPEG	 candle	{"x":[["75","180"]],"y":[["74","180"]]}	{"answers":[null]}	1
2054	images/502_20367.JPEG	 clog	{"x":[["77","52"]],"y":[["77","55"]]}	{"answers":[null]}	1
328	images/959_21259.JPEG	 carbonara	{"x":[["148","96"]],"y":[["141.3592169136464","93.78640563788214"]]}	{"answers":[null]}	1
90	images/260_26277.JPEG	 chow	{"x":[["86","23"]],"y":[["85","22"]]}	{"answers":[null]}	1
792	images/825_42716.JPEG	 stone wall	{"x":[["24","31"]],"y":[["25","30"]]}	{"answers":[null]}	1
1529	images/293_35369.JPEG	 cheetah	{"x":[["101","128"]],"y":[["104","128"]]}	{"answers":[null]}	1
1371	images/910_15904.JPEG	 wooden spoon	{"x":[["90","60"]],"y":[["90","59"]]}	{"answers":[null]}	1
1663	images/590_28514.JPEG	 hand-held computer	{"x":[["55","99"]],"y":[["55","101"]]}	{"answers":[null]}	1
1247	images/206_8244.JPEG	 curly-coated retriever	{"x":[["97","108"]],"y":[["99","108"]]}	{"answers":[null]}	1
1054	images/721_1888.JPEG	 pillow	{"x":[["8","21"]],"y":[["8","23"]]}	{"answers":[null]}	1
429	images/833_43997.JPEG	 submarine	{"x":[["101","40"]],"y":[["101","44"]]}	{"answers":[null]}	1
51	images/147_311.JPEG	 grey whale	{"x":[["177","74"]],"y":[["178","78"]]}	{"answers":[null]}	1
2166	images/810_14915.JPEG	 space bar	\N	{"answers":[null]}	1
551	images/171_16159.JPEG	 Italian greyhound	{"x":[["172","40"]],"y":[["175","40"]]}	{"answers":[null]}	1
2382	images/561_41170.JPEG	 forklift	{"x":[["191","102"]],"y":[["192","102"]]}	{"answers":[null]}	1
1849	images/278_8901.JPEG	 kit fox	{"x":[["68","62"]],"y":[["68","64"]]}	{"answers":[null]}	1
2434	images/95_1431.JPEG	 jacamar	{"x":[["242","143"]],"y":[["237","143"]]}	{"answers":[null]}	1
249	images/482_12531.JPEG	 cassette player	{"x":[["89","161"]],"y":[["93","161"]]}	{"answers":[null]}	1
2116	images/537_24830.JPEG	 dogsled	{"x":[["27","149"]],"y":[["27","154"]]}	{"answers":[null]}	1
293	images/448_35449.JPEG	 birdhouse	{"x":[["32","85"]],"y":[["32","84"]]}	{"answers":[null]}	1
1896	images/279_16533.JPEG	 Arctic fox	{"x":[["69","125"]],"y":[["70","124"]]}	{"answers":[null]}	1
1415	images/890_27294.JPEG	 volleyball	{"x":[["105","140"]],"y":[["105","138"]]}	{"answers":[null]}	1
518	images/724_32070.JPEG	 pirate	{"x":[["81","19"]],"y":[["88","19"]]}	{"answers":[null]}	1
683	images/663_10162.JPEG	 monastery	{"x":[["42","162"]],"y":[["45","162"]]}	{"answers":[null]}	1
2426	images/95_41548.JPEG	 jacamar	{"x":[["251","8"]],"y":[["249","8"]]}	{"answers":[null]}	1
338	images/959_8841.JPEG	 carbonara	{"x":[["128","65"]],"y":[["126","65"]]}	{"answers":[null]}	1
15	images/903_33131.JPEG	 wig	{"x":[["44","5"]],"y":[["44","7"]]}	{"answers":[null]}	1
1677	images/597_17656.JPEG	 holster	{"x":[["69","18"]],"y":[["73.65054687180944","23.231865230785615"]]}	{"answers":[null]}	1
1231	images/206_10341.JPEG	 curly-coated retriever	{"x":[["36","144"]],"y":[["35","150"]]}	{"answers":[null]}	1
1049	images/634_39074.JPEG	 lumbermill	{"x":[["149","116"]],"y":[["149","120"]]}	{"answers":[null]}	1
176	images/254_33256.JPEG	 pug	{"x":[["26","53"]],"y":[["20","55"]]}	{"answers":[null]}	1
2222	images/330_426.JPEG	 wood rabbit	{"x":[["182","42"]],"y":[["184","42"]]}	{"answers":[null]}	1
1803	images/548_12958.JPEG	 entertainment center	{"x":[["6","57"]],"y":[["6","59"]]}	{"answers":[null]}	1
142	images/934_8567.JPEG	 hotdog	{"x":[["6","156"]],"y":[["6","155"]]}	{"answers":[null]}	1
1948	images/224_3376.JPEG	 groenendael	{"x":[["214","34"]],"y":[["214","35"]]}	{"answers":[null]}	1
1	images/903_23161.JPEG	 wig	{"x":[["66","182"]],"y":[["64","182"]]}	{"answers":[null]}	1
862	images/806_105.JPEG	 sock	{"x":[["108","69"]],"y":[["108","71"]]}	{"answers":[null]}	1
1019	images/729_7118.JPEG	 plate rack	{"x":[["37","150"]],"y":[["44","150"]]}	{"answers":[null]}	1
1666	images/590_39895.JPEG	 hand-held computer	{"x":[["151","25"]],"y":[["151","32"]]}	{"answers":[null]}	1
1316	images/896_12344.JPEG	 washbasin	{"x":[["68","170"]],"y":[["68","175"]]}	{"answers":[null]}	1
733	images/344_14467.JPEG	 hippopotamus	{"x":[["20","86"]],"y":[["23","87"]]}	{"answers":[null]}	1
325	images/101_20304.JPEG	 tusker	{"x":[["55","115"]],"y":[["56.92304789528165","121.73066763348577"]]}	{"answers":[null]}	1
1890	images/279_39231.JPEG	 Arctic fox	{"x":[["95","111"]],"y":[["95","104"]]}	{"answers":[null]}	1
19	images/903_36439.JPEG	 wig	{"x":[["86","92"]],"y":[["90","94"]]}	{"answers":[null]}	1
2076	images/170_28718.JPEG	 Irish wolfhound	{"x":[["98","187"]],"y":[["98","186"]]}	{"answers":[null]}	1
2405	images/690_29196.JPEG	 oxcart	{"x":[["30","150"]],"y":[["30","152"]]}	{"answers":[null]}	1
2205	images/330_32534.JPEG	 wood rabbit	{"x":[["217","109"]],"y":[["218","109"]]}	{"answers":[null]}	1
2006	images/756_2334.JPEG	 rain barrel	{"x":[["53","71"]],"y":[["55","73"]]}	{"answers":[null]}	1
208	images/865_26402.JPEG	 toyshop	{"x":[["56","75"]],"y":[["55","76"]]}	{"answers":[null]}	1
680	images/663_24141.JPEG	 monastery	{"x":[["86","109"]],"y":[["87","109"]]}	{"answers":[null]}	1
202	images/865_8228.JPEG	 toyshop	{"x":[["62","7"]],"y":[["63","8"]]}	{"answers":[null]}	1
2062	images/502_8793.JPEG	 clog	{"x":[["136.5","91"]],"y":[["142.44748116338684","94.691540032447"]]}	{"answers":[null]}	1
909	images/277_4768.JPEG	 red fox	{"x":[["175","90"]],"y":[["181.0777019948712","93.47297256849784"]]}	{"answers":[null]}	1
2314	images/354_19010.JPEG	 Arabian camel	{"x":[["110","59"]],"y":[["112","59"]]}	{"answers":[null]}	1
524	images/724_43872.JPEG	 pirate	{"x":[["17","32"]],"y":[["20","32"]]}	{"answers":[null]}	1
151	images/947_9326.JPEG	 mushroom	{"x":[["73","80"]],"y":[["72","80"]]}	{"answers":[null]}	1
836	images/826_1882.JPEG	 stopwatch	{"x":[["25","60"]],"y":[["24","60"]]}	{"answers":[null]}	1
1460	images/931_187.JPEG	 bagel	{"x":[["98","60"]],"y":[["97","64"]]}	{"answers":[null]}	1
468	images/750_42491.JPEG	 quilt	{"x":[["100","104"]],"y":[["98","106"]]}	{"answers":[null]}	1
832	images/826_6975.JPEG	 stopwatch	{"x":[["105","21"]],"y":[["108","21"]]}	{"answers":[null]}	1
1248	images/206_34100.JPEG	 curly-coated retriever	{"x":[["188","72"]],"y":[["185","72"]]}	{"answers":[null]}	1
1587	images/871_36017.JPEG	 trimaran	{"x":[["9","217"]],"y":[["10","217"]]}	{"answers":[null]}	1
2124	images/537_10513.JPEG	 dogsled	{"x":[["171","28"]],"y":[["171","35"]]}	{"answers":[null]}	1
796	images/825_33613.JPEG	 stone wall	{"x":[["120","29"]],"y":[["122","29"]]}	{"answers":[null]}	1
1748	images/678_34804.JPEG	 neck brace	{"x":[["56","148"]],"y":[["57","150"]]}	{"answers":[null]}	1
1454	images/931_48822.JPEG	 bagel	{"x":[["124","17"]],"y":[["124","18"]]}	{"answers":[null]}	1
509	images/724_16171.JPEG	 pirate	{"x":[["108","91"]],"y":[["110","91"]]}	{"answers":[null]}	1
2464	images/691_6757.JPEG	 oxygen mask	{"x":[["161","135"]],"y":[["162","135"]]}	{"answers":[null]}	1
91	images/260_15723.JPEG	 chow	{"x":[["112","23"]],"y":[["112","26"]]}	{"answers":[null]}	1
2266	images/642_49889.JPEG	 marimba	{"x":[["18","142"]],"y":[["18","141"]]}	{"answers":[null]}	1
1411	images/890_9597.JPEG	 volleyball	{"x":[["74","9"]],"y":[["74","10"]]}	{"answers":[null]}	1
2352	images/451_7454.JPEG	 bolo tie	{"x":[["6","125"]],"y":[["10","125"]]}	{"answers":[null]}	1
1683	images/597_29229.JPEG	 holster	{"x":[["217","171"]],"y":[["217","172"]]}	{"answers":[null]}	1
917	images/277_10241.JPEG	 red fox	{"x":[["48","10"]],"y":[["48","11"]]}	{"answers":[null]}	1
1251	images/465_6366.JPEG	 bulletproof vest	{"x":[["144","141"]],"y":[["146","141"]]}	{"answers":[null]}	1
1539	images/293_4347.JPEG	 cheetah	{"x":[["106","65"]],"y":[["106","69"]]}	{"answers":[null]}	1
583	images/631_35549.JPEG	 lotion	{"x":[["85","56"]],"y":[["85","55"]]}	{"answers":[null]}	1
1946	images/224_29414.JPEG	 groenendael	{"x":[["145","71"]],"y":[["146","66"]]}	{"answers":[null]}	1
2031	images/12_13481.JPEG	 house finch	{"x":[["105","87"]],"y":[["105","89"]]}	{"answers":[null]}	1
941	images/498_24842.JPEG	 cinema	{"x":[["47","81"]],"y":[["54","81"]]}	{"answers":[null]}	1
375	images/558_25777.JPEG	 flute	{"x":[["125","7"]],"y":[["125","11"]]}	{"answers":[null]}	1
1253	images/465_17133.JPEG	 bulletproof vest	{"x":[["188","12"]],"y":[["188","13"]]}	{"answers":[null]}	1
1144	images/667_15842.JPEG	 mortarboard	{"x":[["29","128"]],"y":[["30","128"]]}	{"answers":[null]}	1
2072	images/502_38973.JPEG	 clog	{"x":[["156","129"]],"y":[["160","126"]]}	{"answers":[null]}	1
2221	images/330_5206.JPEG	 wood rabbit	{"x":[["122","12"]],"y":[["120","12"]]}	{"answers":[null]}	1
1612	images/325_29838.JPEG	 sulphur butterfly	{"x":[["223","5"]],"y":[["223","12"]]}	{"answers":[null]}	1
12	images/903_31703.JPEG	 wig	{"x":[["75","49"]],"y":[["75","56"]]}	{"answers":[null]}	1
1491	images/813_27595.JPEG	 spatula	{"x":[["62","76"]],"y":[["63","76"]]}	{"answers":[null]}	1
104	images/440_7095.JPEG	 beer bottle	{"x":[["207","165"]],"y":[["201","165"]]}	{"answers":[null]}	1
2341	images/391_10210.JPEG	 coho	{"x":[["80","141"]],"y":[["84","141"]]}	{"answers":[null]}	1
513	images/724_39680.JPEG	 pirate	{"x":[["105","49"]],"y":[["105","50"]]}	{"answers":[null]}	1
976	images/22_28828.JPEG	 bald eagle	{"x":[["143","24"]],"y":[["141","23"]]}	{"answers":[null]}	1
1791	images/905_41846.JPEG	 window shade	{"x":[["180","23"]],"y":[["176","23"]]}	{"answers":[null]}	1
902	images/277_9667.JPEG	 red fox	{"x":[["73","97"]],"y":[["73.86824314212446","90.05405486300432"]]}	{"answers":[null]}	1
23	images/903_23277.JPEG	 wig	{"x":[["68","108"]],"y":[["75","108"]]}	{"answers":[null]}	1
1372	images/910_34756.JPEG	 wooden spoon	{"x":[["22","167"]],"y":[["28","165"]]}	{"answers":[null]}	1
1184	images/470_18227.JPEG	 candle	{"x":[["149","15"]],"y":[["149","21"]]}	{"answers":[null]}	1
1060	images/721_17421.JPEG	 pillow	{"x":[["234","9"]],"y":[["232","10"]]}	{"answers":[null]}	1
650	images/604_2767.JPEG	 hourglass	{"x":[["98","119"]],"y":[["101","119"]]}	{"answers":[null]}	1
1006	images/729_18540.JPEG	 plate rack	{"x":[["7","229"]],"y":[["12","229"]]}	{"answers":[null]}	1
1206	images/819_27285.JPEG	 stage	{"x":[["159","173"]],"y":[["156","172"]]}	{"answers":[null]}	1
532	images/944_10950.JPEG	 artichoke	{"x":[["108","136"]],"y":[["108","132"]]}	{"answers":[null]}	1
1964	images/179_49972.JPEG	 Staffordshire bullterrier	{"x":[["120","31"]],"y":[["122","27"]]}	{"answers":[null]}	1
109	images/440_34796.JPEG	 beer bottle	{"x":[["89","183"]],"y":[["89","182"]]}	{"answers":[null]}	1
1330	images/853_17743.JPEG	 thatch	{"x":[["161","172"]],"y":[["161","170"]]}	{"answers":[null]}	1
1510	images/684_8510.JPEG	 ocarina	{"x":[["48","101"]],"y":[["48","100"]]}	{"answers":[null]}	1
2114	images/537_31363.JPEG	 dogsled	{"x":[["13","252"]],"y":[["6.739009663000589","248.8695048315003"]]}	{"answers":[null]}	1
2219	images/330_3044.JPEG	 wood rabbit	{"x":[["179","83"]],"y":[["180","83"]]}	{"answers":[null]}	1
696	images/663_35932.JPEG	 monastery	{"x":[["78","81"]],"y":[["75","82"]]}	{"answers":[null]}	1
2132	images/32_1465.JPEG	 tailed frog	{"x":[["76","155"]],"y":[["79","155"]]}	{"answers":[null]}	1
722	images/389_938.JPEG	 barracouta	{"x":[["165","49"]],"y":[["163","55"]]}	{"answers":[null]}	1
876	images/545_34238.JPEG	 electric fan	{"x":[["158.59999084472656","187"]],"y":[["157.59999084472656","187"]]}	{"answers":[null]}	1
992	images/22_47869.JPEG	 bald eagle	{"x":[["59.59999084472656","116"]],"y":[["63.201461132719245","122.00245047998781"]]}	{"answers":[null]}	1
1402	images/890_29572.JPEG	 volleyball	{"x":[["153.59999084472656","96"]],"y":[["149.59999084472656","96"]]}	{"answers":[null]}	1
1776	images/905_40962.JPEG	 window shade	{"x":[["169.59999084472656","22"]],"y":[null]}	{"answers":[null]}	1
540	images/944_17573.JPEG	 artichoke	{"x":[["169.59999084472656","22"]],"y":[null]}	{"answers":[null]}	1
2305	images/354_13060.JPEG	 Arabian camel	{"x":[["51.59999084472656","40.59999942779541"]],"y":[["50.59999084472656","40.59999942779541"]]}	{"answers":[null]}	1
1958	images/179_44535.JPEG	 Staffordshire bullterrier	{"x":[["125.59999084472656","119.20000076293945"]],"y":[["125.59999084472656","120.20000076293945"]]}	{"answers":[null]}	1
547	images/944_21355.JPEG	 artichoke	{"x":[["88.59999084472656","101"]],"y":[["85.59999084472656","101"]]}	{"answers":[null]}	1
1243	images/206_39770.JPEG	 curly-coated retriever	{"x":[["54.59999084472656","93.20000076293945"]],"y":[["54.59999084472656","94.20000076293945"]]}	{"answers":[null]}	1
2282	images/280_35617.JPEG	 grey fox	{"x":[["115.59999084472656","64.20000076293945"]],"y":[["115.59999084472656","65.20000076293945"]]}	{"answers":[null]}	1
1433	images/472_6227.JPEG	 canoe	{"x":[["161.59999084472656","156.20000076293945"]],"y":[["154.59999084472656","156.20000076293945"]]}	{"answers":[null]}	1
2286	images/280_20924.JPEG	 grey fox	{"x":[["189.59999084472656","119.20000076293945"]],"y":[["189.59999084472656","121.20000076293945"]]}	{"answers":[null]}	1
1486	images/813_24894.JPEG	 spatula	{"x":[["92.59999084472656","61.20000076293945"]],"y":[["92.59999084472656","67.20000076293945"]]}	{"answers":[null]}	1
1032	images/634_14193.JPEG	 lumbermill	{"x":[["24.599990844726562","52.20000076293945"]],"y":[["23.599990844726562","52.20000076293945"]]}	{"answers":[null]}	1
1186	images/470_21648.JPEG	 candle	{"x":[["96.59999084472656","83.5999984741211"]],"y":[["96.59999084472656","82.5999984741211"]]}	{"answers":[null]}	1
1581	images/871_15266.JPEG	 trimaran	{"x":[["171.59999084472656","21.599998474121094"]],"y":[["171.59999084472656","25.599998474121094"]]}	{"answers":[null]}	1
2343	images/391_9192.JPEG	 coho	{"x":[["145.59999084472656","48.599998474121094"]],"y":[["140.59999084472656","50.599998474121094"]]}	{"answers":[null]}	1
207	images/865_23638.JPEG	 toyshop	{"x":[["117.59999084472656","64.5999984741211"]],"y":[["117.59999084472656","65.5999984741211"]]}	{"answers":[null]}	1
42	images/669_10440.JPEG	 mosquito net	{"x":[["45.59999084472656","9.599998474121094"]],"y":[["45.59999084472656","16.599998474121094"]]}	{"answers":[null]}	1
318	images/101_29165.JPEG	 tusker	{"x":[["171.59999084472656","64.5999984741211"]],"y":[["170.59999084472656","64.5999984741211"]]}	{"answers":[null]}	1
2180	images/773_40495.JPEG	 saltshaker	{"x":[["73.59999084472656","47.599998474121094"]],"y":[["73.59999084472656","49.599998474121094"]]}	{"answers":[null]}	1
257	images/381_9143.JPEG	 spider monkey	{"x":[["186.59999084472656","25.599998474121094"]],"y":[["179.59999084472656","25.599998474121094"]]}	{"answers":[null]}	1
2455	images/691_15989.JPEG	 oxygen mask	{"x":[["182.59999084472656","70.5999984741211"]],"y":[["182.59999084472656","68.5999984741211"]]}	{"answers":[null]}	1
1169	images/876_11588.JPEG	 tub	{"x":[["146.59999084472656","21.599998474121094"]],"y":[["144.59999084472656","21.599998474121094"]]}	{"answers":[null]}	1
180	images/254_7990.JPEG	 pug	{"x":[["114.59999084472656","118.5999984741211"]],"y":[["114.59999084472656","125.5999984741211"]]}	{"answers":[null]}	1
269	images/381_42779.JPEG	 spider monkey	{"x":[["96.59999084472656","37.599998474121094"]],"y":[["96.59999084472656","40.599998474121094"]]}	{"answers":[null]}	1
2015	images/756_8391.JPEG	 rain barrel	{"x":[["160.59999084472656","174.5999984741211"]],"y":[["167.59999084472656","174.5999984741211"]]}	{"answers":[null]}	1
212	images/865_34985.JPEG	 toyshop	{"x":[["5.5999908447265625","51.599998474121094"]],"y":[["5.5999908447265625","53.599998474121094"]]}	{"answers":[null]}	1
1504	images/684_30697.JPEG	 ocarina	{"x":[["108.59999084472656","24.599998474121094"]],"y":[["103.59999084472656","28.599998474121094"]]}	{"answers":[null]}	1
430	images/833_15791.JPEG	 submarine	{"x":[["9.599990844726562","172.5999984741211"]],"y":[["16.599990844726562","172.5999984741211"]]}	{"answers":[null]}	1
2354	images/451_38821.JPEG	 bolo tie	{"x":[["86.59999084472656","103.5999984741211"]],"y":[["93.59999084472656","103.5999984741211"]]}	{"answers":[null]}	1
957	images/963_16972.JPEG	 pizza	{"x":[["101.59999084472656","69.5999984741211"]],"y":[["100.59999084472656","69.5999984741211"]]}	{"answers":[null]}	1
1602	images/325_34250.JPEG	 sulphur butterfly	{"x":[["87.59999084472656","42.599998474121094"]],"y":[["90.27645339381066","49.068116301074326"]]}	{"answers":[null]}	1
1719	images/970_38420.JPEG	 alp	{"x":[["37.59999084472656","49.599998474121094"]],"y":[["43.996671685068364","52.44296773649523"]]}	{"answers":[null]}	1
626	images/604_40949.JPEG	 hourglass	{"x":[["12.599990844726562","6.599998474121094"]],"y":[["17.184504613651455","11.889822053649816"]]}	{"answers":[null]}	1
2497	images/978_45783.JPEG	 seashore	{"x":[["84.59999084472656","114.5999984741211"]],"y":[["83.59999084472656","114.5999984741211"]]}	{"answers":[null]}	1
1668	images/590_46261.JPEG	 hand-held computer	{"x":[["37.59999084472656","5.599998474121094"]],"y":[["37.59999084472656","9.599998474121094"]]}	{"answers":[null]}	1
1751	images/626_37638.JPEG	 lighter	{"x":[["176.59999084472656","145.5999984741211"]],"y":[["176.59999084472656","146.5999984741211"]]}	{"answers":[null]}	1
975	images/963_2398.JPEG	 pizza	{"x":[["8.599990844726562","60.599998474121094"]],"y":[["9.599990844726562","60.599998474121094"]]}	{"answers":[null]}	1
734	images/344_47594.JPEG	 hippopotamus	{"x":[["200.59999084472656","125.5999984741211"]],"y":[["194.0214368803075","123.20779703251416"]]}	{"answers":[null]}	1
2025	images/756_41578.JPEG	 rain barrel	{"x":[["94.59999084472656","58.599998474121094"]],"y":[["98.66865820076023","64.29613277256824"]]}	{"answers":[null]}	1
1892	images/279_27408.JPEG	 Arctic fox	{"x":[["107.59999084472656","113.5999984741211"]],"y":[["107.59999084472656","106.5999984741211"]]}	{"answers":[null]}	1
574	images/171_49360.JPEG	 Italian greyhound	{"x":[["99.59999084472656","173.5999984741211"]],"y":[["96.59999084472656","172.5999984741211"]]}	{"answers":[null]}	1
1137	images/667_11018.JPEG	 mortarboard	\N	{"answers":[null]}	1
749	images/344_19135.JPEG	 hippopotamus	{"x":[["189.59999084472656","160"]],"y":[["187.30034647013764","166.61147757694312"]]}	{"answers":[null]}	1
569	images/171_39891.JPEG	 Italian greyhound	{"x":[["251.59999084472656","49"]],"y":[["251.59999084472656","48"]]}	{"answers":[null]}	1
135	images/934_17847.JPEG	 hotdog	{"x":[["17.599990844726562","114.79999923706055"]],"y":[["17.599990844726562","115.79999923706055"]]}	{"answers":[null]}	1
195	images/254_3799.JPEG	 pug	{"x":[["73.59999084472656","113.79999923706055"]],"y":[["68.59999084472656","113.79999923706055"]]}	{"answers":[null]}	1
821	images/921_44818.JPEG	 book jacket	{"x":[["1.5999908447265625","4.799999237060547"]],"y":[["2.296516877873554","11.765259568530471"]]}	{"answers":[null]}	1
1195	images/470_42250.JPEG	 candle	{"x":[["13.599990844726562","101"]],"y":[["20.599990844726562","101"]]}	{"answers":[null]}	1
746	images/344_47999.JPEG	 hippopotamus	{"x":[["73.59999084472656","119"]],"y":[["74.59999084472656","119"]]}	{"answers":[null]}	1
1741	images/678_35059.JPEG	 neck brace	{"x":[["105.59999084472656","125"]],"y":[["100.59999084472656","126"]]}	{"answers":[null]}	1
1103	images/379_35739.JPEG	 howler monkey	{"x":[["150.59999084472656","93"]],"y":[["150.59999084472656","92"]]}	{"answers":[null]}	1
2194	images/773_11962.JPEG	 saltshaker	{"x":[["86.59999084472656","151"]],"y":[["93.59999084472656","151"]]}	{"answers":[null]}	1
363	images/558_34049.JPEG	 flute	{"x":[["101.59999084472656","86"]],"y":[["101.59999084472656","87"]]}	{"answers":[null]}	1
1660	images/590_1786.JPEG	 hand-held computer	{"x":[["77.59999084472656","12"]],"y":[["77.59999084472656","19"]]}	{"answers":[null]}	1
2294	images/280_9974.JPEG	 grey fox	{"x":[["29.599990844726562","70"]],"y":[["29.599990844726562","71"]]}	{"answers":[null]}	1
2484	images/978_41881.JPEG	 seashore	{"x":[["78.59999084472656","190"]],"y":[["85.59999084472656","190"]]}	{"answers":[null]}	1
331	images/959_5382.JPEG	 carbonara	{"x":[["81.59999084472656","103.79999542236328"]],"y":[["81.59999084472656","104.79999542236328"]]}	{"answers":[null]}	1
1126	images/667_36484.JPEG	 mortarboard	{"x":[["5.5999908447265625","106.79999542236328"]],"y":[["9.599990844726562","106.79999542236328"]]}	{"answers":[null]}	1
124	images/440_34429.JPEG	 beer bottle	{"x":[["84.59999084472656","64.79999542236328"]],"y":[["90.59999084472656","64.79999542236328"]]}	{"answers":[null]}	1
454	images/750_34626.JPEG	 quilt	{"x":[["9.599990844726562","113.4000015258789"]],"y":[["14.599990844726562","116.4000015258789"]]}	{"answers":[null]}	1
530	images/944_19299.JPEG	 artichoke	{"x":[["133.59999084472656","113.5999984741211"]],"y":[["127.59999084472656","113.5999984741211"]]}	{"answers":[null]}	1
1234	images/206_9984.JPEG	 curly-coated retriever	{"x":[["188.59999084472656","76.5999984741211"]],"y":[["189.59999084472656","76.5999984741211"]]}	{"answers":[null]}	1
1570	images/770_24601.JPEG	 running shoe	{"x":[["73.59999084472656","133.5999984741211"]],"y":[["67.99999084472657","137.79999847412108"]]}	{"answers":[null]}	1
2095	images/170_24688.JPEG	 Irish wolfhound	{"x":[["27.599990844726562","45.599998474121094"]],"y":[["32.59999084472656","45.599998474121094"]]}	{"answers":[null]}	1
2421	images/690_4741.JPEG	 oxcart	{"x":[["63.59999084472656","126.19999694824219"]],"y":[["63.59999084472656","125.19999694824219"]]}	{"answers":[null]}	1
944	images/498_44717.JPEG	 cinema	{"x":[["64.79998779296875","193.1999969482422"]],"y":[["64.79998779296875","192.1999969482422"]]}	{"answers":[null]}	1
2425	images/690_11448.JPEG	 oxcart	{"x":[["250.79998779296875","161.1999969482422"]],"y":[["250.79998779296875","160.1999969482422"]]}	{"answers":[null]}	1
1707	images/970_38160.JPEG	 alp	{"x":[["6.79998779296875","37.19999694824219"]],"y":[["8.79998779296875","37.19999694824219"]]}	{"answers":[null]}	1
783	images/825_8189.JPEG	 stone wall	{"x":[["2.79998779296875","81.80000305175781"]],"y":[["2.79998779296875","87.80000305175781"]]}	{"answers":[null]}	1
333	images/959_34150.JPEG	 carbonara	{"x":[["183.79998779296875","20.800003051757812"]],"y":[["183.79998779296875","21.800003051757812"]]}	{"answers":[null]}	1
1826	images/278_36483.JPEG	 kit fox	{"x":[["212","95.20000076293945"]],"y":[["215","95.20000076293945"]]}	{"answers":[null]}	1
470	images/750_42971.JPEG	 quilt	{"x":[["4.79998779296875","147.8000030517578"]],"y":[["6.79998779296875","147.8000030517578"]]}	{"answers":[null]}	1
2248	images/547_10967.JPEG	 electric locomotive	{"x":[["132.79998779296875","177.8000030517578"]],"y":[["130.79998779296875","177.8000030517578"]]}	{"answers":[null]}	1
726	images/344_10474.JPEG	 hippopotamus	{"x":[["181.79998779296875","197.8000030517578"]],"y":[["181.79998779296875","193.8000030517578"]]}	{"answers":[null]}	1
279	images/448_24528.JPEG	 birdhouse	{"x":[["122.79998779296875","68.80000305175781"]],"y":[["121.79998779296875","68.80000305175781"]]}	{"answers":[null]}	1
572	images/171_4595.JPEG	 Italian greyhound	{"x":[["170.79998779296875","37.80000305175781"]],"y":[["170.79998779296875","38.80000305175781"]]}	{"answers":[null]}	1
120	images/440_21744.JPEG	 beer bottle	{"x":[["4.79998779296875","14.800003051757812"]],"y":[["11.79998779296875","14.800003051757812"]]}	{"answers":[null]}	1
10	images/903_3411.JPEG	 wig	{"x":[["114.5","144"]],"y":[["113.51005050633883","137.07035354437184"]]}	{"answers":[null]}	1
1830	images/278_8613.JPEG	 kit fox	{"x":[["170.5","80"]],"y":[["170.5","83"]]}	{"answers":[null]}	1
1333	images/853_11203.JPEG	 thatch	{"x":[["157.5","49"]],"y":[["152.5","49"]]}	{"answers":[null]}	1
457	images/750_11228.JPEG	 quilt	{"x":[["24.5","109"]],"y":[["25.489949493661165","115.92964645562816"]]}	{"answers":[null]}	1
405	images/425_6241.JPEG	 barn	{"x":[["103.79998779296875","156.8000030517578"]],"y":[["103.79998779296875","155.8000030517578"]]}	{"answers":[null]}	1
1357	images/910_48083.JPEG	 wooden spoon	{"x":[["40.79998779296875","5.8000030517578125"]],"y":[["40.79998779296875","12.800003051757812"]]}	{"answers":[null]}	1
938	images/498_35120.JPEG	 cinema	{"x":[["11.79998779296875","135.1999969482422"]],"y":[["13.79998779296875","135.1999969482422"]]}	{"answers":[null]}	1
280	images/448_19729.JPEG	 birdhouse	{"x":[["2.79998779296875","78.19999694824219"]],"y":[["6.79998779296875","75.19999694824219"]]}	{"answers":[null]}	1
155	images/947_31847.JPEG	 mushroom	{"x":[["12.79998779296875","118.80000305175781"]],"y":[["19.79998779296875","118.80000305175781"]]}	{"answers":[null]}	1
1877	images/279_6176.JPEG	 Arctic fox	{"x":[["112.79998779296875","41.80000305175781"]],"y":[["112.79998779296875","46.80000305175781"]]}	{"answers":[null]}	1
1686	images/597_4535.JPEG	 holster	{"x":[["85.79998779296875","17.800003051757812"]],"y":[["85.79998779296875","18.800003051757812"]]}	{"answers":[null]}	1
2001	images/756_39908.JPEG	 rain barrel	{"x":[["180.79998779296875","130.1999969482422"]],"y":[["187.79998779296875","130.1999969482422"]]}	{"answers":[null]}	1
1734	images/678_29461.JPEG	 neck brace	{"x":[["1.5","182"]],"y":[["7.324352060364906","185.8829013735766"]]}	{"answers":[null]}	1
2328	images/391_34968.JPEG	 coho	{"x":[["125.5","145"]],"y":[["118.5","145"]]}	{"answers":[null]}	1
1728	images/678_39249.JPEG	 neck brace	{"x":[["109.59999084472656","131"]],"y":[["110.59999084472656","132"]]}	{"answers":[null]}	1
1544	images/293_43427.JPEG	 cheetah	{"x":[["29.599990844726562","34.599998474121094"]],"y":[["31.29774021998089","41.390995975138416"]]}	{"answers":[null]}	1
2131	images/32_12681.JPEG	 tailed frog	{"x":[["226","101.79999542236328"]],"y":[["228","101.79999542236328"]]}	{"answers":[null]}	1
1170	images/876_36393.JPEG	 tub	{"x":[["102","45.79999542236328"]],"y":[["102","47.79999542236328"]]}	{"answers":[null]}	1
1401	images/890_19182.JPEG	 volleyball	{"x":[["84","18.79999542236328"]],"y":[["85","18.79999542236328"]]}	{"answers":[null]}	1
614	images/563_42036.JPEG	 fountain pen	{"x":[["113","135.79999542236328"]],"y":[["114","135.79999542236328"]]}	{"answers":[null]}	1
1064	images/721_34433.JPEG	 pillow	{"x":[["37","46.79999542236328"]],"y":[["39","46.79999542236328"]]}	{"answers":[null]}	1
782	images/825_14829.JPEG	 stone wall	{"x":[["94","94.79999542236328"]],"y":[["95","94.79999542236328"]]}	{"answers":[null]}	1
1295	images/143_47945.JPEG	 oystercatcher	{"x":[["178","121.79999542236328"]],"y":[["178","120.79999542236328"]]}	{"answers":[null]}	1
984	images/22_13916.JPEG	 bald eagle	{"x":[["89","77.79999542236328"]],"y":[["90","77.79999542236328"]]}	{"answers":[null]}	1
1432	images/472_18517.JPEG	 canoe	{"x":[["17","152.79999542236328"]],"y":[["24","152.79999542236328"]]}	{"answers":[null]}	1
1805	images/548_48410.JPEG	 entertainment center	{"x":[["133","157.79999542236328"]],"y":[["132","157.79999542236328"]]}	{"answers":[null]}	1
1514	images/684_30588.JPEG	 ocarina	{"x":[["105","141.79999542236328"]],"y":[["104","141.79999542236328"]]}	{"answers":[null]}	1
2280	images/280_49113.JPEG	 grey fox	{"x":[["152","84.79999542236328"]],"y":[["152","85.79999542236328"]]}	{"answers":[null]}	1
296	images/448_36684.JPEG	 birdhouse	{"x":[["56","16.79999542236328"]],"y":[["54","17.79999542236328"]]}	{"answers":[null]}	1
1408	images/890_15371.JPEG	 volleyball	{"x":[["123","37.79999542236328"]],"y":[["122","36.79999542236328"]]}	{"answers":[null]}	1
488	images/485_23458.JPEG	 CD player	{"x":[["128.5","120"]],"y":[["135.5","120"]]}	{"answers":[null]}	1
744	images/344_33920.JPEG	 hippopotamus	{"x":[["142.5","149"]],"y":[["135.5","149"]]}	{"answers":[null]}	1
2249	images/547_1245.JPEG	 electric locomotive	{"x":[["13.5","33"]],"y":[["20.5","33"]]}	{"answers":[null]}	1
1017	images/729_1069.JPEG	 plate rack	{"x":[["12.5","142"]],"y":[["13.5","142"]]}	{"answers":[null]}	1
606	images/563_35661.JPEG	 fountain pen	{"x":[["203.5","9"]],"y":[["202.51005050633884","15.929646455628166"]]}	{"answers":[null]}	1
2367	images/451_28340.JPEG	 bolo tie	{"x":[["223.5","160"]],"y":[["219.21986749246963","165.53899500974518"]]}	{"answers":[null]}	1
1526	images/293_32020.JPEG	 cheetah	{"x":[["114.5","145"]],"y":[["118.5","145"]]}	{"answers":[null]}	1
1754	images/626_1864.JPEG	 lighter	\N	{"answers":[null]}	1
1119	images/379_36565.JPEG	 howler monkey	{"x":[["105","121.19999694824219"]],"y":[["106","116.19999694824219"]]}	{"answers":[null]}	1
1763	images/626_9860.JPEG	 lighter	{"x":[["85","136.1999969482422"]],"y":[["85","143.1999969482422"]]}	{"answers":[null]}	1
1020	images/729_29031.JPEG	 plate rack	{"x":[["132","39.80000305175781"]],"y":[["132","40.80000305175781"]]}	{"answers":[null]}	1
1793	images/905_26167.JPEG	 window shade	{"x":[["95","34.80000305175781"]],"y":[["96","34.80000305175781"]]}	{"answers":[null]}	1
895	images/545_49265.JPEG	 electric fan	{"x":[["230","73.80000305175781"]],"y":[["230","71.80000305175781"]]}	{"answers":[null]}	1
345	images/959_48367.JPEG	 carbonara	{"x":[["140","212.8000030517578"]],"y":[["133","212.8000030517578"]]}	{"answers":[null]}	1
548	images/944_1681.JPEG	 artichoke	{"x":[["64","141.8000030517578"]],"y":[["64","134.8000030517578"]]}	{"answers":[null]}	1
1988	images/864_33583.JPEG	 tow truck	{"x":[["144","21.800003051757812"]],"y":[["143","21.800003051757812"]]}	{"answers":[null]}	1
84	images/260_49470.JPEG	 chow	{"x":[["168","78.80000305175781"]],"y":[["161","78.80000305175781"]]}	{"answers":[null]}	1
1673	images/590_1417.JPEG	 hand-held computer	{"x":[["20","130.8000030517578"]],"y":[["27","130.8000030517578"]]}	{"answers":[null]}	1
30	images/669_12524.JPEG	 mosquito net	{"x":[["98","1.8000030517578125"]],"y":[["98","7.8000030517578125"]]}	{"answers":[null]}	1
1511	images/684_48265.JPEG	 ocarina	{"x":[["70","109.80000305175781"]],"y":[["68","109.80000305175781"]]}	{"answers":[null]}	1
641	images/604_13847.JPEG	 hourglass	{"x":[["109","14.800003051757812"]],"y":[["114.71877504285334","18.8367854349484"]]}	{"answers":[null]}	1
173	images/947_42194.JPEG	 mushroom	{"x":[["196","173.8000030517578"]],"y":[["192.1170986264234","179.62435511212271"]]}	{"answers":[null]}	1
2143	images/32_27267.JPEG	 tailed frog	{"x":[["244","49.80000305175781"]],"y":[["237","49.80000305175781"]]}	{"answers":[null]}	1
383	images/697_29211.JPEG	 pajama	\N	{"answers":[null]}	1
573	images/171_16562.JPEG	 Italian greyhound	\N	{"answers":[null]}	1
2083	images/170_8186.JPEG	 Irish wolfhound	\N	{"answers":[null]}	1
940	images/498_45426.JPEG	 cinema	\N	{"answers":[null]}	1
258	images/381_40831.JPEG	 spider monkey	{"x":[["-28","347.1999969482422"]],"y":[["-25.68539922707911","340.5937405755305"]]}	{"answers":[null]}	1
1365	images/910_38406.JPEG	 wooden spoon	{"x":[["5","129.8000030517578"]],"y":[["5","131.8000030517578"]]}	{"answers":[null]}	1
1691	images/597_3001.JPEG	 holster	{"x":[["133","93.80000305175781"]],"y":[["127","93.80000305175781"]]}	{"answers":[null]}	1
1710	images/970_3813.JPEG	 alp	{"x":[["13","109.80000305175781"]],"y":[["19.957186142715333","109.02698236923389"]]}	{"answers":[null]}	1
2018	images/756_11826.JPEG	 rain barrel	{"x":[["114","84.80000305175781"]],"y":[["113","84.80000305175781"]]}	{"answers":[null]}	1
775	images/501_21659.JPEG	 cloak	{"x":[["119","189.8000030517578"]],"y":[["117","190.8000030517578"]]}	{"answers":[null]}	1
404	images/425_14001.JPEG	 barn	{"x":[["114","143.8000030517578"]],"y":[["113","144.8000030517578"]]}	{"answers":[null]}	1
1752	images/626_17535.JPEG	 lighter	{"x":[["222","148.8000030517578"]],"y":[["217","146.8000030517578"]]}	{"answers":[null]}	1
1193	images/470_3229.JPEG	 candle	{"x":[["89","44.80000305175781"]],"y":[["88","45.80000305175781"]]}	{"answers":[null]}	1
1907	images/664_2859.JPEG	 monitor	{"x":[["102","36.80000305175781"]],"y":[["101","36.80000305175781"]]}	{"answers":[null]}	1
1494	images/813_341.JPEG	 spatula	{"x":[["125","14.800003051757812"]],"y":[["125","17.800003051757812"]]}	{"answers":[null]}	1
273	images/381_49841.JPEG	 spider monkey	{"x":[["173","45.80000305175781"]],"y":[["172","45.80000305175781"]]}	{"answers":[null]}	1
1889	images/279_23644.JPEG	 Arctic fox	{"x":[["140","124.80000305175781"]],"y":[["140","123.80000305175781"]]}	{"answers":[null]}	1
2404	images/690_16871.JPEG	 oxcart	{"x":[["208","116.80000305175781"]],"y":[["206","116.80000305175781"]]}	{"answers":[null]}	1
1492	images/813_6901.JPEG	 spatula	{"x":[["25","123.80000305175781"]],"y":[["26","123.80000305175781"]]}	{"answers":[null]}	1
1124	images/379_16502.JPEG	 howler monkey	{"x":[["125","117.80000305175781"]],"y":[["128.8829013735766","123.62435511212271"]]}	{"answers":[null]}	1
2096	images/170_20379.JPEG	 Irish wolfhound	{"x":[["126","138.8000030517578"]],"y":[["120","135.8000030517578"]]}	{"answers":[null]}	1
1440	images/472_33644.JPEG	 canoe	{"x":[["201","185.8000030517578"]],"y":[["198","187.8000030517578"]]}	{"answers":[null]}	1
226	images/482_48088.JPEG	 cassette player	{"x":[["110","12.800003051757812"]],"y":[["115","13.800003051757812"]]}	{"answers":[null]}	1
553	images/171_46025.JPEG	 Italian greyhound	{"x":[["175","84.80000305175781"]],"y":[["174","83.80000305175781"]]}	{"answers":[null]}	1
1272	images/465_30515.JPEG	 bulletproof vest	{"x":[["23","175.8000030517578"]],"y":[["23","176.8000030517578"]]}	{"answers":[null]}	1
360	images/558_41355.JPEG	 flute	{"x":[["126","17.800003051757812"]],"y":[["125","20.800003051757812"]]}	{"answers":[null]}	1
1945	images/224_36312.JPEG	 groenendael	{"x":[["137","13.800003051757812"]],"y":[["137","14.800003051757812"]]}	{"answers":[null]}	1
1996	images/864_9206.JPEG	 tow truck	{"x":[["156","121.80000305175781"]],"y":[["155","121.80000305175781"]]}	{"answers":[null]}	1
2377	images/561_47708.JPEG	 forklift	{"x":[["17","157.8000030517578"]],"y":[["16","157.8000030517578"]]}	{"answers":[null]}	1
490	images/485_45080.JPEG	 CD player	{"x":[["21","101.80000305175781"]],"y":[["22","97.80000305175781"]]}	{"answers":[null]}	1
1891	images/279_27380.JPEG	 Arctic fox	{"x":[["163","66.80000305175781"]],"y":[["166","71.80000305175781"]]}	{"answers":[null]}	1
781	images/825_16359.JPEG	 stone wall	{"x":[["245","119.80000305175781"]],"y":[["243","119.80000305175781"]]}	{"answers":[null]}	1
1586	images/871_29089.JPEG	 trimaran	{"x":[["4","173.8000030517578"]],"y":[["6","174.8000030517578"]]}	{"answers":[null]}	1
2019	images/756_14743.JPEG	 rain barrel	{"x":[["182","32.80000305175781"]],"y":[["182","33.80000305175781"]]}	{"answers":[null]}	1
2193	images/773_47118.JPEG	 saltshaker	{"x":[["154","20.800003051757812"]],"y":[["156","20.800003051757812"]]}	{"answers":[null]}	1
1072	images/721_29120.JPEG	 pillow	{"x":[["164","8.800003051757812"]],"y":[["164","9.800003051757812"]]}	{"answers":[null]}	1
2184	images/773_41102.JPEG	 saltshaker	{"x":[["61","6.1999969482421875"]],"y":[["56.05025253169417","11.149744416548021"]]}	{"answers":[null]}	1
419	images/425_11119.JPEG	 barn	{"x":[["98","117.20000076293945"]],"y":[["103.93598812803562","113.4900081829172"]]}	{"answers":[null]}	1
2147	images/32_24470.JPEG	 tailed frog	{"x":[["127","66.20000076293945"]],"y":[["126","66.20000076293945"]]}	{"answers":[null]}	1
1048	images/634_49239.JPEG	 lumbermill	{"x":[["100","8.200000762939453"]],"y":[["100","15.200000762939453"]]}	{"answers":[null]}	1
785	images/825_28263.JPEG	 stone wall	{"x":[["20","87.20000076293945"]],"y":[["27","87.20000076293945"]]}	{"answers":[null]}	1
4	images/903_20518.JPEG	 wig	{"x":[["143","102.20000076293945"]],"y":[["142","102.20000076293945"]]}	{"answers":[null]}	1
1972	images/179_35586.JPEG	 Staffordshire bullterrier	{"x":[["105","94.20000076293945"]],"y":[["106","94.20000076293945"]]}	{"answers":[null]}	1
1592	images/871_48470.JPEG	 trimaran	{"x":[["126","128.20000076293945"]],"y":[["125","128.20000076293945"]]}	{"answers":[null]}	1
533	images/944_19021.JPEG	 artichoke	{"x":[["52","137.20000076293945"]],"y":[["52","139.20000076293945"]]}	{"answers":[null]}	1
164	images/947_38041.JPEG	 mushroom	{"x":[["118","227.20000076293945"]],"y":[["119","227.20000076293945"]]}	{"answers":[null]}	1
1110	images/379_2064.JPEG	 howler monkey	{"x":[["98","143.20000076293945"]],"y":[["104.99207696407106","143.5329568088476"]]}	{"answers":[null]}	1
1289	images/143_48359.JPEG	 oystercatcher	{"x":[["196","56.20000076293945"]],"y":[["192","56.20000076293945"]]}	{"answers":[null]}	1
1359	images/910_35312.JPEG	 wooden spoon	{"x":[["12","68.20000076293945"]],"y":[["13","68.20000076293945"]]}	{"answers":[null]}	1
11	images/903_42900.JPEG	 wig	{"x":[["116","66.20000076293945"]],"y":[["122.73066763348577","68.1230486582211"]]}	{"answers":[null]}	1
2416	images/690_11947.JPEG	 oxcart	{"x":[["6","128.20000076293945"]],"y":[["12.35571569150316","131.13340800517167"]]}	{"answers":[null]}	1
2115	images/537_15169.JPEG	 dogsled	{"x":[["60","124.20000076293945"]],"y":[null]}	{"answers":[null]}	1
1039	images/634_45569.JPEG	 lumbermill	{"x":[["18","135.20000076293945"]],"y":[["24.730667633485762","133.2769528676578"]]}	{"answers":[null]}	1
1651	images/590_16334.JPEG	 hand-held computer	{"x":[["196","21.200000762939453"]],"y":[["190.1756479396351","25.082902136516058"]]}	{"answers":[null]}	1
694	images/663_38831.JPEG	 monastery	{"x":[["210","26.200000762939453"]],"y":[["210","32.20000076293945"]]}	{"answers":[null]}	1
2063	images/502_10930.JPEG	 clog	{"x":[["226","115.79999923706055"]],"y":[["226","122.79999923706055"]]}	{"answers":[null]}	1
777	images/825_7247.JPEG	 stone wall	{"x":[["12","125.20000076293945"]],"y":[["14.457864091118742","118.64569651995615"]]}	{"answers":[null]}	1
2436	images/95_28045.JPEG	 jacamar	{"x":[["60","8.200000762939453"]],"y":[["60","9.200000762939453"]]}	{"answers":[null]}	1
545	images/944_14272.JPEG	 artichoke	{"x":[["114","46.20000076293945"]],"y":[["114","48.20000076293945"]]}	{"answers":[null]}	1
1560	images/770_8233.JPEG	 running shoe	{"x":[["156","241.79999923706055"]],"y":[["156","239.79999923706055"]]}	{"answers":[null]}	1
1926	images/224_20439.JPEG	 groenendael	{"x":[["214","115.79999923706055"]],"y":[["214","108.79999923706055"]]}	{"answers":[null]}	1
119	images/440_21340.JPEG	 beer bottle	{"x":[["53","4.799999237060547"]],"y":[["53","5.799999237060547"]]}	{"answers":[null]}	1
1573	images/770_13672.JPEG	 running shoe	{"x":[["36","83.79999923706055"]],"y":[["36","90.79999923706055"]]}	{"answers":[null]}	1
1105	images/379_29994.JPEG	 howler monkey	{"x":[["249","56.79999923706055"]],"y":[["242.40780661883613","54.44564445807345"]]}	{"answers":[null]}	1
1329	images/853_25105.JPEG	 thatch	{"x":[["164","65.79999923706055"]],"y":[["160","69.79999923706055"]]}	{"answers":[null]}	1
114	images/440_12544.JPEG	 beer bottle	{"x":[["80","6.799999237060547"]],"y":[["80","8.799999237060547"]]}	{"answers":[null]}	1
37	images/669_31255.JPEG	 mosquito net	{"x":[["16","13.799999237060547"]],"y":[["17","13.799999237060547"]]}	{"answers":[null]}	1
2332	images/391_4421.JPEG	 coho	{"x":[["118","60.20000076293945"]],"y":[["124.26099033699941","63.33049593143916"]]}	{"answers":[null]}	1
2271	images/642_15984.JPEG	 marimba	{"x":[["183","212.20000076293945"]],"y":[["180","212.20000076293945"]]}	{"answers":[null]}	1
1778	images/905_8100.JPEG	 window shade	\N	{"answers":[null]}	1
1012	images/729_3273.JPEG	 plate rack	{"x":[["71","176.20000076293945"]],"y":[["77","176.20000076293945"]]}	{"answers":[null]}	1
1088	images/801_12570.JPEG	 snorkel	{"x":[["205","178.20000076293945"]],"y":[["198","178.20000076293945"]]}	{"answers":[null]}	1
2466	images/691_31912.JPEG	 oxygen mask	{"x":[["224","119.20000076293945"]],"y":[["229.9359881280356","115.4900081829172"]]}	{"answers":[null]}	1
837	images/826_49148.JPEG	 stopwatch	{"x":[["168","206.79999923706055"]],"y":[["164","206.79999923706055"]]}	{"answers":[null]}	1
347	images/959_13105.JPEG	 carbonara	{"x":[["34","229.79999923706055"]],"y":[["39.82435206036491","225.91709786348395"]]}	{"answers":[null]}	1
1884	images/279_3233.JPEG	 Arctic fox	{"x":[["172","86.19999694824219"]],"y":[["166.8204194862284","90.90870650621638"]]}	{"answers":[null]}	1
2357	images/451_34470.JPEG	 bolo tie	{"x":[["82","116.4000015258789"]],"y":[["77.05025253169417","121.34974899418474"]]}	{"answers":[null]}	1
2235	images/547_46283.JPEG	 electric locomotive	{"x":[["12","117.4000015258789"]],"y":[["17.224068041279576","122.05930545458772"]]}	{"answers":[null]}	1
2089	images/170_5936.JPEG	 Irish wolfhound	{"x":[["174","204.4000015258789"]],"y":[["174","201.4000015258789"]]}	{"answers":[null]}	1
1503	images/684_11530.JPEG	 ocarina	{"x":[["224","83.4000015258789"]],"y":[["219","83.4000015258789"]]}	{"answers":[null]}	1
416	images/425_10784.JPEG	 barn	{"x":[["NaN","NaN"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
48	images/669_11874.JPEG	 mosquito net	{"x":[["156","50.19999694824219"]],"y":[["149","50.19999694824219"]]}	{"answers":[null]}	1
1177	images/470_38937.JPEG	 candle	{"x":[["76.79998779296875","160.1999969482422"]],"y":[["80.79998779296875","160.1999969482422"]]}	{"answers":[null]}	1
1309	images/896_29860.JPEG	 washbasin	{"x":[["54.79998779296875","155.1999969482422"]],"y":[["55.79998779296875","155.1999969482422"]]}	{"answers":[null]}	1
982	images/22_47676.JPEG	 bald eagle	{"x":[["34.79998779296875","163.1999969482422"]],"y":[["33.79998779296875","168.1999969482422"]]}	{"answers":[null]}	1
80	images/260_45039.JPEG	 chow	{"x":[["192.19998168945312","16.199996948242188"]],"y":[["192.19998168945312","9.199996948242188"]]}	{"answers":[null]}	1
1047	images/634_1724.JPEG	 lumbermill	{"x":[["238","89"]],"y":[["NaN","NaN"]]}	{"answers":[null]}	1
2109	images/537_39366.JPEG	 dogsled	{"x":[["100","114.19999694824219"]],"y":[["93","114.19999694824219"]]}	{"answers":[null]}	1
1746	images/678_22479.JPEG	 neck brace	{"x":[["164","174.8000030517578"]],"y":[["170","174.8000030517578"]]}	{"answers":[null]}	1
2333	images/391_20082.JPEG	 coho	{"x":[["208","44.80000305175781"]],"y":[["208","41.80000305175781"]]}	{"answers":[null]}	1
\.


--
-- Name: images__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('images__id_seq', 2500, true);


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY session (sid, sess, expire) FROM stdin;
90EEOYB2iRU23S38uqMAyTC3ME6iCmKK	{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"user_data":{"click_count":260,"score":2433.1310298571425,"name":"excited feed","userid":"B1WOKzzmg","app_version":2,"email":""}}	2016-12-08 12:42:28
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY users (_id, cookie, name, score, email, last_click_time) FROM stdin;
15	HJAg2kCfg	bewildered reception	0	\N	\N
2	ByPBD1aGx	homely department	0	asdasd@sadasd.com	\N
12	BkXwTiaGe	amused tradition	0	\N	\N
7	ry_uhx6Me	angry can	0	sadas@asdasd	\N
10	SJQX_JTGx	mysterious breakfast	0	\N	\N
11	HkhAH9pMx	splendid task	0	\N	\N
19	rJ_3l-JXl	fine resident	833.376125000000229	annie.hartnett@gmail.com	\N
26	B1WOKzzmg	excited feed	2433.13102985714249	drewlinsley@gmail.com	\N
21	rJwffwyQg	fine quality	0	\N	\N
22	rk2EzDJme	nice regular	0	\N	\N
1	rJInQAhGe	witty increase	59.5	drewlinsley@gmail.com	\N
4	SkK7dl6Ml	terrible interaction	2.36834999999999996	drew_linsley@brown.edu	\N
3	HyaA1e6fg	ill train	2474.19323900000063	tserre@gmail.com	\N
16	Hk8Qjb0Gl	witty south	4.42761999999999922	\N	\N
18	H1av3w0Me	defeated female	0	\N	\N
17	rkKQLSRGg	gorgeous article	53.1571600000000046	\N	\N
23	H1Ii7rg7e	quaint promotion	22.7561800000000005	\N	\N
28	BJzhVMmXe	rich soft	13.0904199999999982	\N	\N
29	ryCvvMmml	light jury	586.618739999999889	\N	\N
24	r1gEj8g7l	better motor	301.176780000000008	\N	\N
13	SJv7xppGl	bored patient	8	\N	\N
20	ByhUnXJXx	glamorous site	372.999359999999967	\N	\N
25	S1QRSzGXg	thankful try	0	\N	\N
27	BJeV5xMXQg	grumpy view	145.161749999999984	\N	\N
30	r1o4KDXXx	mushy command	0	\N	\N
\.


--
-- Name: users__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('users__id_seq', 30, true);


--
-- Name: clicks_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY clicks
    ADD CONSTRAINT clicks_pkey PRIMARY KEY (_id);


--
-- Name: cnn_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY cnn
    ADD CONSTRAINT cnn_pkey PRIMARY KEY (_id);


--
-- Name: image_count_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY image_count
    ADD CONSTRAINT image_count_pkey PRIMARY KEY (_id);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (_id);


--
-- Name: session_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: users_cookie_key; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_cookie_key UNIQUE (cookie);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

