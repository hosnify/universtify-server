--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Ubuntu 13.3-1.pgdg20.04+1)
-- Dumped by pg_dump version 13.3 (Ubuntu 13.3-1.pgdg20.04+1)

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
-- Name: Gender; Type: TYPE; Schema: public; Owner: abosamra
--

CREATE TYPE public."Gender" AS ENUM (
    'MALE',
    'FEMALE'
);


ALTER TYPE public."Gender" OWNER TO abosamra;

--
-- Name: Semester; Type: TYPE; Schema: public; Owner: abosamra
--

CREATE TYPE public."Semester" AS ENUM (
    'FALL',
    'SPRING',
    'SUMMER'
);


ALTER TYPE public."Semester" OWNER TO abosamra;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Course; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public."Course" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    discreption text,
    credit integer,
    available boolean DEFAULT true NOT NULL,
    "courseCode" text,
    name text NOT NULL,
    level integer,
    "majorId" integer,
    "minorId" integer
);


ALTER TABLE public."Course" OWNER TO abosamra;

--
-- Name: Course_id_seq; Type: SEQUENCE; Schema: public; Owner: abosamra
--

CREATE SEQUENCE public."Course_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Course_id_seq" OWNER TO abosamra;

--
-- Name: Course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abosamra
--

ALTER SEQUENCE public."Course_id_seq" OWNED BY public."Course".id;


--
-- Name: Enrollment; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public."Enrollment" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "supervisorId" integer,
    "studentID" integer,
    "courseID" integer,
    "isAproved" boolean DEFAULT false NOT NULL,
    status text DEFAULT 'in review'::text NOT NULL
);


ALTER TABLE public."Enrollment" OWNER TO abosamra;

--
-- Name: Enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: abosamra
--

CREATE SEQUENCE public."Enrollment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Enrollment_id_seq" OWNER TO abosamra;

--
-- Name: Enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abosamra
--

ALTER SEQUENCE public."Enrollment_id_seq" OWNED BY public."Enrollment".id;


--
-- Name: FinishedCourses; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public."FinishedCourses" (
    "courseId" integer NOT NULL,
    "studentID" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    grade double precision,
    semester public."Semester",
    "instructorName" text,
    id integer NOT NULL
);


ALTER TABLE public."FinishedCourses" OWNER TO abosamra;

--
-- Name: FinishedCourses_id_seq; Type: SEQUENCE; Schema: public; Owner: abosamra
--

CREATE SEQUENCE public."FinishedCourses_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."FinishedCourses_id_seq" OWNER TO abosamra;

--
-- Name: FinishedCourses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abosamra
--

ALTER SEQUENCE public."FinishedCourses_id_seq" OWNED BY public."FinishedCourses".id;


--
-- Name: Major; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public."Major" (
    id integer NOT NULL,
    code text NOT NULL,
    name text
);


ALTER TABLE public."Major" OWNER TO abosamra;

--
-- Name: Major_id_seq; Type: SEQUENCE; Schema: public; Owner: abosamra
--

CREATE SEQUENCE public."Major_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Major_id_seq" OWNER TO abosamra;

--
-- Name: Major_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abosamra
--

ALTER SEQUENCE public."Major_id_seq" OWNED BY public."Major".id;


--
-- Name: Notifications; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public."Notifications" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "supervisorId" integer,
    "studentID" integer,
    status integer DEFAULT 0,
    data jsonb NOT NULL
);


ALTER TABLE public."Notifications" OWNER TO abosamra;

--
-- Name: Notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: abosamra
--

CREATE SEQUENCE public."Notifications_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Notifications_id_seq" OWNER TO abosamra;

--
-- Name: Notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abosamra
--

ALTER SEQUENCE public."Notifications_id_seq" OWNED BY public."Notifications".id;


--
-- Name: Student; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public."Student" (
    id integer NOT NULL,
    "uniCode" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    fname character varying(255) NOT NULL,
    lname character varying(255) NOT NULL,
    gender public."Gender",
    password text,
    email text NOT NULL,
    level integer,
    semester public."Semester",
    "creditDone" integer,
    "creditHave" integer,
    "supervisorId" integer,
    "GPA" double precision,
    "lastTermGPA" double precision,
    avatar text,
    "majorId" integer,
    "minorId" integer
);


ALTER TABLE public."Student" OWNER TO abosamra;

--
-- Name: Student_id_seq; Type: SEQUENCE; Schema: public; Owner: abosamra
--

CREATE SEQUENCE public."Student_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Student_id_seq" OWNER TO abosamra;

--
-- Name: Student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abosamra
--

ALTER SEQUENCE public."Student_id_seq" OWNED BY public."Student".id;


--
-- Name: Supervisor; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public."Supervisor" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    fname character varying(255) NOT NULL,
    lname character varying(255) NOT NULL,
    gender public."Gender",
    password text,
    email text NOT NULL,
    phone text,
    avatar text
);


ALTER TABLE public."Supervisor" OWNER TO abosamra;

--
-- Name: Supervisor_id_seq; Type: SEQUENCE; Schema: public; Owner: abosamra
--

CREATE SEQUENCE public."Supervisor_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Supervisor_id_seq" OWNER TO abosamra;

--
-- Name: Supervisor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abosamra
--

ALTER SEQUENCE public."Supervisor_id_seq" OWNED BY public."Supervisor".id;


--
-- Name: _CoursePrerequisites; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public."_CoursePrerequisites" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_CoursePrerequisites" OWNER TO abosamra;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: abosamra
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO abosamra;

--
-- Name: Course id; Type: DEFAULT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Course" ALTER COLUMN id SET DEFAULT nextval('public."Course_id_seq"'::regclass);


--
-- Name: Enrollment id; Type: DEFAULT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Enrollment" ALTER COLUMN id SET DEFAULT nextval('public."Enrollment_id_seq"'::regclass);


--
-- Name: FinishedCourses id; Type: DEFAULT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."FinishedCourses" ALTER COLUMN id SET DEFAULT nextval('public."FinishedCourses_id_seq"'::regclass);


--
-- Name: Major id; Type: DEFAULT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Major" ALTER COLUMN id SET DEFAULT nextval('public."Major_id_seq"'::regclass);


--
-- Name: Notifications id; Type: DEFAULT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Notifications" ALTER COLUMN id SET DEFAULT nextval('public."Notifications_id_seq"'::regclass);


--
-- Name: Student id; Type: DEFAULT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Student" ALTER COLUMN id SET DEFAULT nextval('public."Student_id_seq"'::regclass);


--
-- Name: Supervisor id; Type: DEFAULT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Supervisor" ALTER COLUMN id SET DEFAULT nextval('public."Supervisor_id_seq"'::regclass);


--
-- Data for Name: Course; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public."Course" (id, "createdAt", "updatedAt", discreption, credit, available, "courseCode", name, level, "majorId", "minorId") FROM stdin;
1	2021-06-03 11:40:26.473	2021-06-03 11:40:26.488	Voluptatem et earum repellat aut eius autem nobis. Dolores ut sequi sit rerum sunt. Dolor consectetur modi facere placeat inventore sed dolorum quis vel. Voluptates et occaecati recusandae nihil qui sit modi atque eos. Quam repellat rerum sint temporibus culpa aperiam quos assumenda. Consequatur perspiciatis et atque. Et quo hic cupiditate. Sunt aut dolorem.	4	t	MIS37	Refined Granite Bacon	3	1	\N
2	2021-06-03 11:40:26.473	2021-06-03 11:40:26.488	Corporis saepe maxime sunt amet voluptatem in et molestiae. Minus harum id voluptas consequatur qui esse molestiae quos. Dolores quae earum. Aut omnis quisquam et nostrum. Sit pariatur necessitatibus aut animi facere officiis tempore qui. Magni itaque et nam error quam quibusdam maiores occaecati quod.	2	t	MIS3	Small Concrete Salad	2	1	1
3	2021-06-03 11:40:26.473	2021-06-03 11:40:26.488	Unde corporis delectus eum voluptates rerum. Soluta quas quod facilis velit saepe. Velit nesciunt vitae et maxime laboriosam esse autem autem explicabo. Quia vero nihil similique sit error culpa eos inventore. Veniam quaerat doloremque qui rem quisquam recusandae minus enim neque. Quia consequuntur unde totam excepturi dolores dolor.	3	t	MIS35	Fantastic Plastic Cheese	3	1	\N
4	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Necessitatibus maiores incidunt repellat dolores qui ab. Perferendis praesentium quod in ex id eos earum molestiae. Eum deserunt eius nulla aut dolorem non. Aut maiores optio sint earum odit corrupti illum. Optio molestiae veniam. Nisi libero harum rerum quo in quia. Voluptas aperiam minus ipsum cum ea impedit.	3	t	MIS15	Sleek Cotton Bike	4	1	\N
5	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Qui aut vel dolorum excepturi. Voluptas quam eaque. Ea libero et molestiae incidunt dolorem et error. Aut veritatis et ad magni quia totam quia atque magni. Ad molestiae in. Et maxime est voluptatem inventore sed non.	2	t	MIS63	Fantastic Granite Keyboard	2	1	1
6	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Hic enim cum vero odit. Cupiditate et aut id temporibus molestiae aut dolores. Voluptatem ex repellat sit ipsa voluptatem praesentium. Adipisci quia in veniam aut qui enim molestiae ut. Sit eos soluta eligendi. Nihil maiores provident corrupti aliquid enim quia.	4	t	MIS67	Tasty Wooden Computer	1	1	1
7	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Mollitia harum est minus. Quidem neque quia voluptatem ducimus quibusdam eveniet quae corporis omnis. Suscipit quasi non dignissimos quas sapiente eos quas. Sed quasi blanditiis vel corrupti enim. Expedita necessitatibus expedita voluptatibus tempora quasi aut quas voluptas veniam.	1	t	MIS52	Handcrafted Cotton Towels	1	1	1
8	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Sapiente deserunt voluptatibus similique amet. Inventore commodi voluptatem totam quos. At totam omnis delectus ea in. Neque cumque occaecati at sapiente nulla laboriosam aliquid nobis. Libero molestias sit non. Perspiciatis repudiandae magnam est nisi mollitia tempora unde aut ea.	4	t	MIS17	Handmade Soft Bike	1	1	1
9	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Molestiae voluptate molestiae amet. Suscipit culpa ut dolor voluptatem assumenda. Velit nihil dolore doloribus aspernatur. Sed consequatur enim reiciendis et iste consequatur. Suscipit rerum deleniti. Omnis aliquam nihil pariatur dolorem ex voluptate minima nam. Provident eaque culpa.	4	t	MIS76	Tasty Rubber Keyboard	1	1	1
10	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Vitae enim amet quia quo est eum dolor itaque. Eum accusamus sint fugit commodi est. Laborum ipsam ea dolore aperiam iste. Quia consequatur fugiat et et numquam. Ut suscipit eos suscipit assumenda est. Et aut dignissimos voluptatem rerum deserunt molestiae illo.	4	t	MIS17	Generic Metal Tuna	4	1	1
11	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Nostrum voluptates ut harum accusamus ut ducimus autem id ut. Porro dicta dolorum. Iusto dicta doloribus placeat sit. Ex omnis et velit. Veniam error asperiores beatae temporibus dolor soluta iste reprehenderit est.	4	t	MIS75	Generic Plastic Keyboard	3	1	1
12	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Aut consectetur autem ut facere temporibus est voluptatibus quis. Aut voluptatem sint eius vel sed velit commodi non. Veniam laboriosam consequatur ut deleniti ut sequi explicabo ducimus repudiandae. Eos voluptatem et et officia magnam molestiae mollitia. Aut enim et tempore fugiat vero nihil qui atque.	1	t	MIS87	Refined Steel Salad	5	1	\N
13	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Eum dolor praesentium molestiae sunt dolor iste sit atque. Et est numquam eius eaque qui voluptatem eius beatae repellat. Eos soluta neque sed. Corporis ut sunt beatae eos vel perferendis. Sunt et molestiae architecto.	2	t	MIS0	Fantastic Frozen Hat	1	1	1
14	2021-06-03 11:40:26.474	2021-06-03 11:40:26.488	Occaecati velit qui et facilis perferendis. Et ipsum id labore cumque qui temporibus quia maxime sit. Et sed quaerat quo culpa cumque ut natus. Eaque nesciunt aut. Quia enim illum ut rerum aut temporibus aperiam aut blanditiis.	2	t	MIS59	Rustic Wooden Chips	1	1	\N
15	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Voluptas sit laboriosam architecto. Dicta voluptatem dignissimos accusantium sequi est qui tempora. Placeat exercitationem quod sit ullam reprehenderit dignissimos vel. Aliquid a vero. Aperiam sit repellat qui numquam incidunt est. Explicabo quia exercitationem. In alias dolor totam ex fuga.	2	t	MIS54	Licensed Plastic Chair	4	1	\N
16	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Minima et aut facilis est. Totam in aut. Perspiciatis quia ex quidem nihil omnis est. Et dolores aut. Quia omnis fugit excepturi. Molestiae voluptatibus rerum. Harum quia neque ullam modi qui eum excepturi ducimus qui.	4	t	MIS14	Ergonomic Frozen Salad	3	1	\N
17	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Sunt amet ipsam qui aspernatur. Suscipit consequatur sed ut dolorem earum ipsa. Incidunt delectus fugiat sunt nesciunt ullam quia ea qui qui. Nihil rerum et enim et expedita non soluta dolorem. Voluptatem nemo nihil atque non velit mollitia nemo et ipsa. Provident quia rerum dolor illum maxime voluptas suscipit ducimus.	3	t	MIS40	Intelligent Wooden Sausages	1	1	\N
18	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Corrupti nemo est ullam. Iste laborum delectus voluptatem molestiae architecto quia aut voluptas pariatur. Dignissimos id facilis libero ut. Soluta ratione ut dolorem quo nobis. Magnam sunt qui aut et natus id optio optio cupiditate.	3	t	MIS69	Sleek Soft Car	4	1	1
19	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Distinctio facilis nihil est. Et qui porro dignissimos praesentium vel. Et sed id consectetur earum quis. Est earum ut illo sit iure molestiae molestiae. Aperiam consequuntur unde in sed odio et quia. Dolorum odio et eum sint omnis error ipsa molestiae.	2	t	MIS47	Fantastic Rubber Chair	5	1	\N
20	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Est sed autem voluptate fuga pariatur quaerat recusandae soluta error. Velit atque dolore quia quo unde totam voluptas perspiciatis. Ea sint voluptas quasi ut quia harum et quisquam et. Iusto sunt est esse ea qui. Laboriosam mollitia error. Voluptates dolorem ducimus recusandae modi amet id.	2	t	MIS49	Awesome Granite Bacon	2	1	1
21	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Harum debitis reiciendis officia facere aperiam et. Alias nisi quos beatae maiores. Consequatur qui voluptas eos dolor ex unde eius corrupti cumque. Voluptatem numquam accusantium quia consequuntur amet. Et accusantium corrupti pariatur occaecati accusamus.	2	t	MIS0	Generic Frozen Computer	1	1	\N
22	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Quidem voluptas cumque magnam doloremque tempora in. Maiores est blanditiis. Dolorum aperiam molestiae alias. Facere fugiat facere nobis sint perferendis. Ipsa voluptatem dignissimos commodi nihil cumque sunt ad voluptates laudantium.	1	t	MIS25	Small Granite Keyboard	5	1	\N
23	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Dolor nesciunt voluptates ut iste et natus vel officia quam. Laborum nam eveniet id voluptate voluptas beatae voluptatem adipisci qui. Similique aspernatur tenetur commodi impedit. Non voluptatem cumque in dolorem commodi assumenda veniam est. Laboriosam eos modi delectus occaecati praesentium maiores esse.	1	t	MIS16	Gorgeous Frozen Fish	2	1	\N
24	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Voluptatem ut non quaerat qui placeat sint. Non sit rerum quas occaecati autem cum et quasi. Nobis est nobis optio rerum quis quae sapiente. Aliquid et dolores. Vel blanditiis iure vel soluta et dolorem ea et. Fugiat quos sint eos ipsam nisi.	1	t	MIS53	Ergonomic Frozen Pants	1	1	\N
25	2021-06-03 11:40:26.475	2021-06-03 11:40:26.488	Provident quo quia sit dolores facere. Sunt corrupti perferendis quasi. Explicabo provident sunt. Quo aut eius deleniti dicta. Quia aut ea atque ea dolor et eos.	4	t	MIS24	Gorgeous Granite Computer	4	1	\N
26	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Rerum eaque ipsum qui exercitationem. Consequatur similique tempora optio et cumque corporis. Et laboriosam quasi qui. Itaque et eius ut adipisci qui perferendis sit ea tempora. Culpa aut excepturi sint modi sed nulla.	4	t	MIS71	Gorgeous Cotton Cheese	4	1	\N
27	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Voluptatibus aut voluptatem ipsum molestias qui. Consequatur non minus veritatis harum cumque quia voluptates placeat sapiente. Nisi animi totam sed ullam dolorum. Praesentium aspernatur facere. Repellendus atque quas dicta. Unde rerum vel ea quaerat est fugiat itaque. Possimus vero quis mollitia laudantium sit repellat placeat officiis et.	3	t	MIS56	Handmade Fresh Tuna	2	1	1
28	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Aliquam tempora voluptatum est vitae voluptas iure enim. Est ut reiciendis consequatur non itaque illo sequi. Vitae natus voluptas voluptatem delectus et. Consequatur omnis placeat cupiditate sit quia incidunt et enim. Necessitatibus dolorem et possimus est. Cum id dolor. Dolor incidunt reprehenderit earum sit ut non. Est impedit reiciendis ab.	1	t	MIS92	Unbranded Fresh Shirt	5	1	\N
29	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Non qui eos numquam vero officia repellat et. Sed enim et quaerat ab ipsum aut. Accusamus quaerat voluptatem blanditiis ut quasi quis earum. Et qui iure explicabo. Unde vitae minus consequatur occaecati nulla.	4	t	MIS45	Incredible Cotton Cheese	1	1	1
30	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Iste odit consequatur ex nesciunt mollitia impedit accusamus. Quod aspernatur molestiae qui molestiae ut. Unde qui ad quam repellat. Voluptatem error ab blanditiis est aut illum sit et perferendis. Eius nostrum distinctio saepe sed voluptatem labore autem aliquam illo.	3	t	MIS22	Small Concrete Pizza	4	1	1
31	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Voluptatem asperiores excepturi culpa iure dolores omnis. Minus consequatur id dolor officia. Consequatur laudantium ut quia. Assumenda sequi ipsam sint. Voluptas ut odit qui enim alias facilis ex.	4	t	MIS1	Generic Concrete Car	2	1	1
32	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Ut repudiandae aut voluptatem sed ipsam error dolorem qui. Qui voluptates recusandae et occaecati cum quia non voluptas. Architecto ut eos debitis hic. Ullam sed dolor aut. Eum aliquid exercitationem. Quae porro nulla aliquam maxime facere voluptates ab. Repellat ab mollitia nam. Iure occaecati voluptate dolore voluptatem porro et natus laborum.	4	t	MIS50	Unbranded Granite Bike	3	1	\N
33	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Voluptatibus ratione libero sed laborum veritatis voluptate. Voluptas voluptas a consequatur qui et ullam consequatur fugit autem. Facere velit eaque ut unde mollitia deleniti ad. Perspiciatis quasi tenetur. Provident quia dolorum vero. Consectetur ratione sint deserunt perferendis. Ut distinctio omnis laudantium eos aliquid iusto id laborum non.	1	t	MIS41	Rustic Cotton Sausages	5	1	\N
34	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Odit ex eos labore dolore qui non cum perspiciatis. Illo qui facere laboriosam voluptatibus sapiente ipsam alias nihil explicabo. Sit beatae occaecati quis. Et esse neque fugiat cum consectetur similique. Expedita dolores omnis ab nisi voluptatem qui. Officia molestias voluptate. Nihil voluptatem aut aut et. Voluptatem voluptas veniam vero.	1	t	MIS27	Refined Steel Gloves	3	1	\N
35	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Qui assumenda est dolor vitae fugit reprehenderit sequi atque est. Hic et architecto consectetur aut et est. Voluptate hic dolorum veritatis libero quia eos tenetur unde consectetur. Qui quasi ut est. Aut repellendus aut velit et totam laudantium exercitationem voluptatum nihil. Ut aliquid repellendus in delectus dolores nam quisquam.	2	t	MIS59	Tasty Granite Pants	1	1	\N
36	2021-06-03 11:40:26.476	2021-06-03 11:40:26.488	Illum aut non impedit. Eos in quasi ut excepturi et praesentium sint. Voluptatem aspernatur et qui. Qui provident consequuntur molestias laboriosam molestiae ut. Hic eaque minima rerum. Cupiditate reiciendis quis ex voluptatum dolor ipsam magnam. Dolorem ut vel.	2	t	MIS87	Fantastic Steel Shirt	2	1	\N
37	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Modi commodi maiores. Eum consequatur ipsum deserunt sint ut ea non ipsam inventore. Quo porro inventore est pariatur deleniti rerum eius a. Veniam vitae accusamus temporibus necessitatibus quos quis. Eius quod rerum.	3	t	MIS64	Handmade Metal Pants	3	1	1
38	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Sed repudiandae officia. Perferendis sint minima tempora sit sed alias. Quam corrupti saepe consequatur tempora quia repellat sunt ipsam. Autem sint nostrum quo et consequuntur. Et dolor itaque perspiciatis assumenda quaerat tenetur aut nihil qui.	1	t	MIS24	Incredible Steel Bike	1	1	\N
39	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Odit autem a. Nostrum et fugit vero expedita eum quidem adipisci. Corrupti sed sit assumenda voluptatem accusantium non quo. Omnis ea rerum dignissimos qui eveniet harum modi. Eos veniam in pariatur quibusdam quae et omnis aut.	4	t	MIS53	Small Fresh Cheese	3	1	\N
40	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Enim ad qui necessitatibus voluptatem laboriosam quo. Cum rerum at ut. Et quas qui magnam odit ut atque molestias nesciunt. Labore velit incidunt deleniti non et ut doloremque nemo aliquam. Commodi ut sed. Assumenda officiis odio quia. Aperiam mollitia pariatur error veritatis officia doloremque.	1	t	MIS70	Sleek Soft Mouse	4	1	\N
41	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Ut qui rerum nam omnis vel sed molestiae quis. Reiciendis rem error porro. Ratione dolore dolorem eaque velit eos. Quam autem quos accusantium et dolor at et. Soluta magnam praesentium qui veniam sint tempora eius beatae. Fugiat aut autem neque quia similique quia accusamus. Dolorum harum nihil est recusandae qui.	3	t	MIS37	Fantastic Fresh Car	2	1	\N
42	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Consequuntur ullam sed ex ut qui quam. Et dolorem in nulla. Reprehenderit animi facere corporis voluptate aspernatur sed ullam qui recusandae. Inventore est qui veniam sequi esse consectetur. Voluptatum consectetur libero. Aut animi fugiat provident tempora et libero et.	4	t	MIS36	Ergonomic Metal Cheese	2	1	\N
43	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Alias earum sed similique a dolorem eaque ut aut. Aut eligendi necessitatibus qui voluptatem rerum hic minus et. Doloribus sit alias voluptatibus blanditiis et. Quaerat cum ratione iusto alias molestiae. Quia quae dolorum optio voluptas.	2	t	MIS47	Fantastic Wooden Gloves	4	1	\N
44	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Molestias id natus eos natus quis qui quia optio. Et molestiae delectus quis voluptatem aut atque minima laborum. Neque et qui deleniti. Earum nobis dolor quia sed. Autem non ipsa. Quae aut magnam quam in atque et et. Dolores laudantium nobis quo cum quia corporis et voluptatem.	3	t	MIS44	Gorgeous Steel Soap	2	1	\N
45	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Aut recusandae reiciendis reiciendis officia est eius sed pariatur tempora. Quo tempore tempora esse consequuntur laborum voluptatibus recusandae. Ea quasi totam. Hic adipisci ullam suscipit totam. Atque fuga sint quo qui non aut. Et veniam qui consequuntur suscipit. Nemo dolor officia.	3	t	MIS84	Gorgeous Steel Chicken	1	1	\N
46	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Saepe vel id iure nam et similique odit accusamus. Sunt velit qui. Corporis et perspiciatis. Sequi nam voluptatem saepe. Sapiente libero repellendus omnis.	4	t	MIS37	Sleek Steel Bacon	4	1	1
47	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Delectus qui ut odio et aut maxime sed. Ullam deserunt deleniti et ut vel id illum necessitatibus quidem. Cumque necessitatibus quam vitae eum facilis exercitationem error id tempora. Est porro dolor cumque molestiae et iste nisi tenetur sint. Perferendis quam cumque sed vitae adipisci possimus. Sint velit soluta. Autem hic molestias aut delectus. Quod sed ut qui consequatur dignissimos aspernatur ab.	1	t	MIS10	Practical Granite Pizza	2	1	1
48	2021-06-03 11:40:26.477	2021-06-03 11:40:26.488	Sunt reprehenderit rem numquam cupiditate. Fugit animi quaerat ratione veniam error totam. Suscipit est iste illo. Quis error aut voluptatem. Quaerat qui voluptas quaerat sapiente enim et veniam voluptatem.	1	t	MIS1	Incredible Steel Keyboard	4	1	1
49	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Ipsum eius fugit aut ut saepe. Facere ipsum voluptas. Quam et et aliquid sint et aut fuga et facilis. Ut voluptates non blanditiis ab laboriosam et qui. Suscipit beatae nemo sunt iure illo repellendus aperiam qui. Iste doloremque consectetur iste eaque molestias labore iusto amet nisi. Tenetur vel id non harum placeat sit. Quaerat quos aut non ullam voluptatem nesciunt voluptatibus.	3	t	MIS23	Unbranded Fresh Towels	5	1	\N
50	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Architecto fugit accusantium quibusdam error et quae. Occaecati at quo harum. Ut magni sequi nam rerum. Quasi incidunt soluta debitis ut illum quis quis quia eveniet. Voluptatum maiores voluptatem blanditiis sed eius labore ut numquam iste.	1	t	MIS82	Unbranded Frozen Cheese	2	1	1
51	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Nihil molestiae eos eligendi placeat aut voluptas cumque ex. Quas perferendis dolor debitis molestiae. Voluptatem reprehenderit nesciunt excepturi quasi at recusandae beatae. Corrupti dolore rerum suscipit impedit odio voluptatibus qui. Quo tenetur praesentium consequatur. Soluta facere iste eum. Et consequatur officia et quidem voluptate quod consequatur fugiat porro. Ipsa illo et.	2	t	MIS37	Handmade Granite Keyboard	3	1	1
52	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Ex a aliquam dolores ut ab a iste. Et optio temporibus voluptatem. Ut ut quia consequatur nulla alias deserunt. Ullam occaecati distinctio sequi voluptatem magnam. Provident qui rem voluptatum eaque ratione ullam eos voluptas. Animi nesciunt voluptatem rem ab molestias amet magnam id molestiae. Quod rerum consequatur quos dolorem nihil.	1	t	MIS37	Tasty Metal Bacon	1	1	\N
53	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Sint recusandae autem qui ab nisi animi nisi. Soluta dolores corporis rerum blanditiis. Ut similique saepe et autem commodi esse. Consectetur et quia quidem natus. Nemo possimus iusto vel suscipit provident necessitatibus omnis.	2	t	MIS61	Incredible Concrete Table	4	1	\N
54	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Voluptatem mollitia eos ipsam. Et aut illum. Magni architecto fuga est eius quae suscipit perferendis. Ut pariatur possimus dolorem dolor officiis soluta. Sunt soluta aut nobis repellat qui.	4	t	MIS16	Generic Rubber Shirt	4	1	1
55	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Nam velit assumenda temporibus nisi sed. Et non dolore voluptatem. Quia dolorem est asperiores explicabo nesciunt. Cum quibusdam qui recusandae. Officiis adipisci eos nam eum fugit qui harum. Suscipit nostrum perferendis est. Ut et et ipsam quas mollitia dolores qui omnis. Dolorem hic inventore reprehenderit qui doloribus incidunt autem beatae.	3	t	MIS12	Sleek Plastic Fish	3	1	1
56	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Quis deserunt beatae. Est eos molestiae rerum quae quaerat. A aliquam earum magnam est corrupti aut ullam sit pariatur. Ut ad quaerat ea id omnis. Dolorem in inventore et exercitationem. Ducimus autem molestiae et asperiores consequatur.	2	t	MIS76	Rustic Cotton Hat	5	1	\N
57	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Beatae fugit dolor nostrum. Libero asperiores quos alias dolor labore inventore magnam dignissimos beatae. Cum non ut inventore dolor asperiores voluptatem quisquam reiciendis deleniti. Facilis a quia dolor ratione nihil eos. Laudantium omnis eius rerum labore est tempora aut. Assumenda illum qui et qui. Quo libero libero qui amet est sit veritatis consequuntur.	3	t	MIS23	Ergonomic Wooden Keyboard	2	1	\N
58	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Recusandae ducimus earum assumenda illum quidem voluptatem. Reprehenderit eos reiciendis itaque magnam. Omnis nemo id beatae rerum eveniet similique commodi. Incidunt non fugit sed voluptatem inventore quia molestiae dolores est. Ut ratione odit magni reiciendis rem. Voluptas voluptatem ea sed tempora distinctio quo.	1	t	MIS23	Generic Metal Chips	4	1	1
59	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Dignissimos voluptates doloribus quaerat quod ut sunt sint voluptas. Quae ut dolorem iure velit. Et illo beatae voluptatibus aut. Corrupti eligendi dolorem non. Nobis tempore laboriosam incidunt necessitatibus sint quia optio quibusdam. Molestiae iure dicta voluptas ut modi voluptas quia et. Et labore ut.	2	t	MIS10	Ergonomic Plastic Towels	3	1	1
60	2021-06-03 11:40:26.478	2021-06-03 11:40:26.488	Delectus incidunt voluptatum ut et quidem nemo expedita non in. Qui et illum omnis consequatur iusto repellendus consectetur. Quibusdam quaerat molestias eos est perspiciatis laborum tempora. Voluptate iure non occaecati et saepe autem quis. Accusantium et error tenetur deserunt. Illum ex autem. Ut esse doloremque consequuntur vitae.	3	t	MIS77	Fantastic Wooden Salad	2	1	1
61	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Id et dolor sint asperiores dolorem quia aut. Adipisci accusamus ipsa laborum ex quod. Quas consequatur itaque dolorum. Illo cumque in suscipit quia magnam id tenetur. Expedita error aut possimus. Sunt sed maxime repellat. Minus tenetur aspernatur quis consequatur. Velit omnis optio et inventore qui numquam earum placeat quasi.	2	t	MIS25	Tasty Granite Mouse	4	1	\N
62	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Non incidunt magni doloribus architecto debitis error. Neque adipisci nihil cumque qui impedit praesentium dolor quae et. Et asperiores reprehenderit sit temporibus voluptatem est aperiam tempora. Error et iure temporibus. Nesciunt rem blanditiis molestiae possimus ex.	1	t	MIS23	Ergonomic Plastic Gloves	5	1	1
63	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Amet blanditiis delectus provident iure aspernatur quia quo unde quia. Recusandae magni sed consequatur reprehenderit cum autem voluptas optio. Esse corporis error corporis consectetur porro. Ut velit hic eum. Exercitationem et placeat aut. Beatae animi ut eius quia et est est labore recusandae. Officiis debitis ducimus fuga aut.	1	t	MIS100	Incredible Plastic Towels	4	1	1
64	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Dolores ea fugit non corrupti voluptates hic deleniti. Delectus iure deleniti quos non necessitatibus et impedit. Ex iure necessitatibus quia eum voluptatem molestiae quisquam. Minus distinctio libero labore quia incidunt quam necessitatibus voluptatibus aut. Aut recusandae nesciunt quia dolore iste qui nemo nesciunt nostrum. Eum dolor voluptatem ea autem exercitationem. Voluptas corrupti magnam.	4	t	MIS7	Rustic Wooden Soap	1	1	1
65	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Et assumenda rem. Aspernatur porro harum ea distinctio. Voluptatem voluptatem laborum. Nihil aliquam nemo voluptas nesciunt illo eos ex maxime qui. Veniam tempore expedita. Est labore laudantium et.	2	t	MIS30	Handmade Wooden Shoes	5	1	\N
66	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Natus voluptate et quibusdam eius temporibus dolor voluptates vel. Natus exercitationem quo dignissimos possimus asperiores eligendi. Omnis placeat aliquid repellendus magni in enim optio. Deserunt provident corrupti facere nihil. Et nostrum incidunt. Sed quisquam ad. Quidem in deleniti. Occaecati nihil quod magnam veritatis.	4	t	MIS81	Incredible Concrete Chicken	5	1	\N
67	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Aliquid alias voluptates et ipsam illo dicta. Quod delectus tenetur ipsa ipsam et est laborum dolores. Debitis reiciendis maxime ut beatae et distinctio. Accusamus odio id exercitationem vitae harum ea quidem accusantium. Dolores fuga sed doloremque. Ex eos placeat inventore quas exercitationem optio sunt error. Iure optio eum totam consectetur.	3	t	MIS42	Rustic Cotton Car	2	1	\N
68	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Animi rerum unde repudiandae deserunt reiciendis fugiat sapiente. Ratione at sapiente in. Cum voluptatem minus a id. Rerum quia est id consequatur asperiores qui magnam qui. Ad est nam corporis. Possimus accusantium rerum facere accusamus illum et maxime eos asperiores. Minus dolores quidem ratione in quod voluptas eius.	2	t	MIS1	Refined Metal Bike	1	1	\N
69	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Voluptate omnis cumque et doloribus molestiae id repudiandae consequatur tempore. In voluptatum commodi optio ipsa. Sint vel laboriosam provident voluptas. Temporibus quod labore quo itaque cupiditate qui minus illo. Quia nihil qui explicabo magnam. Qui quo numquam. Eius aut debitis ut sed optio repellat. Eveniet iusto quo sunt ut ad consequuntur et omnis.	3	t	MIS41	Intelligent Granite Tuna	4	1	1
70	2021-06-03 11:40:26.479	2021-06-03 11:40:26.488	Voluptatem ut atque ipsa quo voluptatem placeat est qui porro. Atque illo accusantium et dolorem laudantium dolores quidem nihil. Tempore doloribus repellendus non. Voluptates aut dolores commodi placeat. Qui cupiditate cum numquam esse saepe earum nobis.	2	t	MIS98	Licensed Rubber Sausages	5	1	\N
71	2021-06-03 11:40:26.48	2021-06-03 11:40:26.488	Sit fugiat ut ipsum at quae aspernatur tenetur ea praesentium. Sed aliquid recusandae dolores ut dolores ut at a minus. Debitis excepturi dolor suscipit doloribus. Consectetur commodi delectus tempore et rerum. Sunt saepe dolor exercitationem iste exercitationem vero.	2	t	MIS87	Rustic Steel Ball	5	1	1
72	2021-06-03 11:40:26.48	2021-06-03 11:40:26.488	Repellat pariatur facere eius rerum et aliquam fugiat. Qui nesciunt rerum molestiae placeat culpa magni incidunt consequatur omnis. Debitis facilis aut consequatur earum eum numquam expedita. Laboriosam mollitia sequi doloribus commodi. Impedit blanditiis eligendi magni. Labore est vero vero dolorem. Harum mollitia necessitatibus quidem cumque error nam nulla commodi. At asperiores odio mollitia in.	2	t	MIS10	Handcrafted Cotton Cheese	5	1	\N
73	2021-06-03 11:40:26.48	2021-06-03 11:40:26.488	Optio aut atque numquam ullam vel dolorum est. Qui labore quo perferendis neque id. Assumenda facere eos qui. Quos nobis doloribus natus impedit occaecati incidunt quae. Voluptatem quia optio est porro.	1	t	MIS56	Tasty Frozen Pizza	1	1	\N
74	2021-06-03 11:40:26.48	2021-06-03 11:40:26.488	Blanditiis harum quae sunt delectus reprehenderit quae ad officiis. Mollitia eos consequatur est enim. Quis id explicabo autem voluptatem. Officia impedit ullam ad consectetur explicabo. Id aut laudantium illum. Eum voluptas aperiam. Porro reiciendis voluptatum eos ut voluptatum qui inventore rem.	1	t	MIS73	Tasty Metal Mouse	5	1	\N
75	2021-06-03 11:40:26.48	2021-06-03 11:40:26.489	Modi quaerat sint eos. Veritatis saepe atque esse veniam omnis. Velit voluptas omnis iste optio quia non unde. Ut vero quo eligendi labore aut perspiciatis. Omnis molestiae unde repudiandae commodi in quo numquam. Quasi dolorem et enim et repellat minus officiis recusandae. Libero eum quo veritatis est. Quia quaerat nihil autem voluptas omnis placeat qui.	2	t	MIS69	Awesome Plastic Table	4	1	1
76	2021-06-03 11:40:26.48	2021-06-03 11:40:26.489	Id facere sequi corporis asperiores ipsa. Et non exercitationem. Itaque ut officia dolores. Ullam quibusdam ipsam optio molestiae ut aut. Rerum atque velit similique omnis aut veritatis ipsum. In quis laboriosam asperiores magnam itaque exercitationem aut.	2	t	MIS9	Unbranded Rubber Chips	4	1	1
77	2021-06-03 11:40:26.48	2021-06-03 11:40:26.489	Sit consequatur maiores similique expedita repellendus saepe. Quae voluptatem deserunt itaque officiis aut. Optio commodi quasi non tenetur. Quo eveniet sint blanditiis accusamus aut laudantium dolorem facilis. Distinctio nesciunt temporibus et adipisci labore. Impedit autem nihil amet ipsa. Dolore voluptatem officia a animi repellendus distinctio enim ullam. Magnam similique explicabo et illum voluptatem optio quasi.	4	t	MIS4	Tasty Metal Keyboard	5	1	1
78	2021-06-03 11:40:26.48	2021-06-03 11:40:26.489	Dolorem est est nemo quia ut rem. Odit quia quia magni ut similique. Distinctio veniam illo. Reprehenderit dolorem facilis animi vel enim rerum repudiandae alias velit. Assumenda earum et aut est iusto culpa temporibus dolores.	2	t	MIS64	Generic Metal Mouse	4	1	\N
79	2021-06-03 11:40:26.48	2021-06-03 11:40:26.489	Esse voluptatibus assumenda nobis repudiandae natus aspernatur nisi. Perferendis ad saepe veritatis aut ea dolor quibusdam. Facilis facere alias sapiente qui tenetur ab voluptatum. Ducimus voluptatem dolorem ipsam ipsum occaecati at sunt. Voluptatem aliquam eum facilis et adipisci est sapiente atque dolores. Dolores ipsa voluptatem consequatur ducimus et voluptates. Sunt laudantium occaecati debitis iure possimus. Quia voluptatibus beatae saepe animi et dolore atque.	2	t	MIS78	Rustic Steel Fish	4	1	1
80	2021-06-03 11:40:26.48	2021-06-03 11:40:26.489	Et dolorem illum fugit magni impedit commodi. Et rerum voluptatem. Quaerat voluptate rem aut. Ab ab repellendus totam. Aut consequuntur magni quo officia ad cumque. Adipisci ut id vel voluptas sed animi sint. Quasi itaque debitis ipsum atque a est nam.	2	t	MIS25	Licensed Fresh Gloves	1	1	1
100	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Labore eos autem itaque non animi velit repudiandae eum. Ea sint neque earum soluta aliquid architecto eligendi omnis. Dicta sed autem reiciendis laboriosam repellendus dolor. Rerum minus odio. Sed delectus voluptates nesciunt dignissimos reiciendis totam praesentium aut. A id nisi distinctio sunt. Unde libero doloremque non ut natus est.	2	t	MIS26	Generic Soft Towels	5	1	1
81	2021-06-03 11:40:26.48	2021-06-03 11:40:26.489	Totam ut voluptas modi maxime sit aut aut. Dolorem porro cum rem repellendus voluptatem molestiae et. Inventore qui a saepe consectetur aperiam esse. Ipsam quia qui maiores similique natus delectus. Omnis ratione rerum et et blanditiis culpa sapiente. Mollitia enim mollitia rerum iusto voluptates voluptate perspiciatis. Est repellat vel eveniet aut. Saepe quisquam quas sit.	3	t	MIS24	Handmade Rubber Bike	4	1	\N
82	2021-06-03 11:40:26.48	2021-06-03 11:40:26.489	Maxime molestiae voluptates cupiditate sit dolorem rerum aut et. Et molestias vel laborum et. Quia repellat repellendus et aut voluptatem aperiam accusamus voluptate omnis. Consequatur quisquam quia. Unde eos dolores. Doloribus numquam autem voluptatem in eaque ducimus. Quibusdam magnam et eum non recusandae.	2	t	MIS13	Refined Frozen Tuna	5	1	1
83	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Placeat quia aut voluptatem possimus cum eos id consectetur repudiandae. Eum eum unde. Aut voluptatibus eius architecto dolor. Inventore harum distinctio similique qui velit sint ullam. Accusantium asperiores soluta.	4	t	MIS9	Licensed Plastic Chair	1	1	1
84	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Labore mollitia dolor velit eos ipsum. Dolorem amet distinctio dolorem non dicta. Laborum vel repudiandae nihil ea voluptas sit voluptas. Atque unde quibusdam cumque amet soluta placeat. Minus eos cum.	1	t	MIS38	Rustic Steel Ball	2	1	\N
85	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Ipsam qui et nihil rerum eos illo assumenda quasi. Eos totam voluptatem. Voluptas quo fugiat voluptas nam et. Quas delectus distinctio nam. Eum non modi. Ut hic nobis ipsa unde ipsum in iste et architecto. Veritatis vitae consectetur magnam aut enim. Cupiditate magnam et ipsa amet non voluptatem.	2	t	MIS49	Handcrafted Steel Computer	1	1	1
86	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Quae molestiae dolorem deleniti quisquam delectus reiciendis. Animi ipsam maxime ab voluptates necessitatibus ex minus minima. Amet eius delectus in animi et. Qui est excepturi illum vel magni qui et fuga. Dolores adipisci sunt ea dolorem sed. Delectus aliquam provident quasi libero. Aut dolores quidem illum qui. Temporibus quia quibusdam.	2	t	MIS50	Handcrafted Rubber Cheese	5	1	1
87	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Veritatis numquam qui ipsum at eos quia ut. Suscipit iure ut. Nemo repellendus quos repellendus molestiae doloribus ea debitis. Temporibus repellendus est soluta. Ad impedit laboriosam aspernatur ea optio sint atque. Illo laudantium accusantium nulla quaerat voluptatibus. Tempora a inventore voluptatem ea iusto et harum.	3	t	MIS57	Intelligent Fresh Tuna	3	1	1
88	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Et id omnis. Ipsam est soluta tenetur est. Repellat quo corporis deleniti voluptatem repudiandae deserunt. Alias dignissimos adipisci quis nihil aut qui perspiciatis hic. Eligendi ea earum aspernatur eum hic esse sit. Sed et voluptatem maiores molestiae.	3	t	MIS45	Incredible Concrete Car	1	1	\N
89	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Voluptatem omnis corrupti quos. Non accusamus libero voluptate a soluta. Quam excepturi quo. At molestiae aut necessitatibus aut porro iusto. Laboriosam magnam velit voluptatem vel.	1	t	MIS7	Refined Metal Sausages	2	1	1
90	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Quasi ullam possimus. Aut nihil voluptatem et blanditiis. Harum eum sit itaque autem ullam blanditiis libero in. Officia sed ex ea dignissimos aspernatur sapiente. Ut ipsum quae ab aut harum est in laborum. Quia asperiores expedita. Nulla ea est fugiat temporibus. Maxime at aut earum voluptatem.	2	t	MIS4	Handmade Concrete Chair	1	1	1
91	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Qui sunt laborum aut in est quo minus earum soluta. Numquam ducimus facere dignissimos. Fugit pariatur blanditiis neque optio vel. Esse nam mollitia quae sed quo est sit. Enim ducimus sed doloremque quia sed maiores. Quo dolorum ea. Quis consequuntur dolorem veniam veritatis hic. Aut amet ea est est.	1	t	MIS86	Tasty Rubber Bike	1	1	1
92	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Voluptatem corporis earum vel. Perspiciatis magni officia alias facilis veniam unde non. Qui cupiditate a laborum placeat quia qui est nulla. Nihil ut consequatur ratione. Cupiditate ut voluptatem reiciendis. Aliquam voluptas labore dolore modi dolorum.	2	t	MIS82	Intelligent Fresh Chair	1	1	1
93	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Sunt atque voluptatibus porro est aut deleniti aut. Accusamus voluptatum iusto aut doloremque. Dolore recusandae a rerum voluptatum quo tempora voluptates enim. Sequi reprehenderit est soluta dolorem dolores reprehenderit rem nisi. Repellat tempore ducimus.	4	t	MIS52	Unbranded Steel Pizza	2	1	1
94	2021-06-03 11:40:26.481	2021-06-03 11:40:26.489	Numquam dolores commodi neque est et corrupti. Maxime consequatur quos non. Consequatur neque similique cum omnis beatae minima cumque. Aut culpa sed illum error voluptatem molestiae ipsa reiciendis quia. Ducimus quas dolores in. Nulla quas natus ut omnis iure odio porro ab repellendus. Placeat a minus at sit repudiandae.	1	t	MIS45	Handcrafted Cotton Cheese	4	1	\N
95	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	A consequuntur ut quis non laboriosam excepturi ipsam. Delectus velit et magnam exercitationem ullam voluptatibus a quia mollitia. Consequatur ipsam laboriosam cum magni. Cupiditate ut quas non eos cumque tempore rerum aperiam sapiente. Quam quos quia et facilis ut. Et culpa excepturi delectus et et vel. Modi quisquam magni dignissimos eum vel. Nostrum architecto blanditiis atque quae vel itaque.	2	t	MIS68	Rustic Cotton Soap	1	1	\N
96	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Eaque eos quam dolores quam. Id unde rem aut molestiae. Reprehenderit illo illo quo delectus nostrum. Minima quo excepturi qui id consequatur et voluptas. Et pariatur et voluptas ipsa provident ipsum delectus voluptas. Labore officiis nemo sequi illo quod minus libero vitae non. Praesentium quas excepturi eos vero ut suscipit repellendus quas explicabo. Veritatis nihil dolorum maxime at sint.	4	t	MIS23	Sleek Granite Shirt	1	1	1
97	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Omnis minima aliquid. Accusamus iste totam aspernatur. Dolor temporibus culpa doloribus et dolor quia unde occaecati. Dolor vel iure. Doloribus fugit voluptatem dolorem quia eveniet explicabo sed accusantium voluptatum. Natus cum voluptatem modi. Quia soluta animi eum dolorem dignissimos beatae animi qui repellat. Dolorem eaque corporis libero.	1	t	MIS66	Refined Concrete Gloves	4	1	1
98	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Quis iste distinctio autem voluptas impedit voluptatem id sed. Asperiores repellat eos quo rem nihil repudiandae placeat aut ea. Consequatur aliquid ut esse doloribus maxime ea sit. Repudiandae omnis non fuga. Vel quia libero ut dolor repellendus omnis veritatis temporibus sit. Dolores cum non eum quisquam distinctio consectetur. Hic nisi magni quia autem accusantium molestiae quibusdam ut quia.	1	t	MIS96	Handmade Metal Shoes	3	1	1
99	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Id vitae consequatur et voluptatem aliquam aut et repudiandae. Qui magni inventore quae. Consequatur officia nisi exercitationem eius. Aut delectus magnam aut molestiae ipsa temporibus qui labore. Et facere libero.	2	t	MIS31	Practical Granite Cheese	1	1	1
101	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Iusto aliquid ducimus voluptatem magni voluptas eius quis exercitationem sit. Id mollitia nemo. Ut autem ut sed. Dolorum ipsum et. Dignissimos numquam tempore dolores rerum sunt illo. Sint atque et.	3	t	MIS64	Gorgeous Granite Shoes	3	1	\N
102	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Aspernatur quia nostrum qui vero. Eligendi autem est. Quis esse pariatur vitae natus alias. Temporibus temporibus dicta libero maiores molestiae. Corporis amet commodi corrupti in itaque inventore illum. Doloremque ea odit rerum. Quae doloribus libero nihil et cumque qui pariatur facere.	2	t	MIS29	Intelligent Rubber Pants	3	1	\N
103	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	A qui quae aut ab molestiae non blanditiis molestiae. Quod voluptatem voluptatem at facere quis consequatur ipsum non ea. Rerum error molestiae harum error. Pariatur voluptates consequatur perferendis debitis eaque. Quia ab sit nostrum accusamus expedita voluptatem optio vero. Possimus sit iste fugit et alias eos aut dolorem.	1	t	MIS63	Intelligent Metal Chicken	3	1	\N
104	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Laudantium neque dolorum enim deserunt quo iusto voluptas. Velit ea aut voluptatem velit tenetur recusandae magnam amet. Aut occaecati soluta eos molestiae eum omnis corrupti voluptatem aut. Quidem eius minus. Non illum voluptas repellendus mollitia sapiente quae repellendus voluptates. Vel eaque ut natus exercitationem.	1	t	MIS22	Incredible Wooden Shoes	4	1	\N
105	2021-06-03 11:40:26.482	2021-06-03 11:40:26.489	Consequatur quam asperiores et sapiente. Rerum magnam quis earum necessitatibus id quia. Quia dolores sit id ab magni. Et repellat magnam aspernatur quis quia qui. In et vel suscipit ullam velit aut. Aspernatur voluptas repellat deserunt aspernatur et alias vel. Quae enim reiciendis quo sunt maxime. Ipsa accusamus sapiente quibusdam amet sunt sequi voluptatem sunt.	1	t	MIS6	Incredible Concrete Bike	2	1	1
106	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Consectetur et quia. Consequatur quia sed cupiditate eaque aspernatur labore accusantium sint. Molestiae rerum corporis reprehenderit. Autem repellendus aut cumque maxime est et est repellendus dolores. Nihil praesentium nisi nobis libero dignissimos consequatur et sit earum.	1	t	MIS68	Fantastic Fresh Sausages	5	1	1
107	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Explicabo minus quisquam tempore qui occaecati iusto sunt. Fugit esse temporibus eum sunt. Magnam eveniet sed in veniam non non odit labore. In repudiandae reprehenderit voluptate odio dicta quibusdam dolorem voluptatem. Ipsum enim provident voluptas illo placeat perspiciatis animi consequatur asperiores.	1	t	MIS66	Incredible Wooden Table	5	1	1
108	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Voluptas quidem voluptate ea dolores nulla quia sit quibusdam. Asperiores assumenda iusto libero repudiandae. Labore deserunt dolores placeat ipsa et fugiat minus doloribus. Voluptas aut officiis autem sapiente facilis et perferendis. Est voluptas quia tempore hic deserunt deserunt corrupti occaecati. A minus in libero ratione aut maiores et. Accusamus voluptatem magnam saepe deserunt minima commodi.	4	t	MIS2	Awesome Metal Chicken	1	1	\N
109	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Magni dicta sint et nihil dicta qui harum velit quia. Vitae placeat vitae et id ut eum iure omnis. Rerum explicabo fugiat corrupti quisquam temporibus voluptate error eveniet. Voluptate qui consequatur in beatae praesentium sint. Nemo est cumque corporis. Voluptatem vitae maxime natus iste dolore assumenda quaerat. Eos non voluptatibus qui id nemo.	4	t	MIS53	Unbranded Soft Car	1	1	1
110	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Nisi molestiae occaecati. Laboriosam inventore ea praesentium sapiente vel cum. Exercitationem labore aut quo. Reiciendis sed molestiae vitae est nobis ratione et. Omnis molestiae quae. Deserunt adipisci blanditiis consequatur sed nostrum voluptas. Eligendi illo veritatis fuga et qui odio facere.	2	t	MIS2	Small Granite Sausages	2	1	1
111	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Non nam rerum aut animi aliquam quidem qui. Suscipit et impedit et rerum porro recusandae. Sapiente cum doloremque ut voluptas sit. Animi dicta exercitationem earum provident qui iste ab ut. Dolore reprehenderit nisi velit eos nulla unde. Et dignissimos quos.	2	t	MIS83	Sleek Soft Table	3	1	\N
112	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Optio accusantium quia rem sapiente dolorum. Enim ullam rem ea nisi voluptas consequuntur. Et rerum culpa reiciendis officiis quaerat. Omnis deserunt quos pariatur quia ut magni sed. Explicabo quam earum sit temporibus neque. Dolores deserunt corporis et animi. Dolore quisquam assumenda libero.	4	t	MIS7	Handcrafted Fresh Gloves	4	1	1
113	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Repellendus veritatis nostrum. Voluptatum magni qui quas. Vitae quia aut quidem rerum ea vel architecto vitae. Consequatur pariatur pariatur eaque ut. Soluta explicabo eos aut modi non dolor repellat dolorem. Placeat nemo aliquid dolores hic velit consequatur illum quae. Deserunt et ut. Nihil nisi autem illo vitae temporibus mollitia ducimus consequuntur.	2	t	MIS86	Practical Plastic Chicken	1	1	1
114	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Tenetur debitis totam odit. Sed rem quisquam aut qui odio dolorum qui. Facilis consequatur veniam fugiat aliquam nobis vel at autem quis. Est dicta qui perferendis amet quo sint. Enim animi error dicta.	4	t	MIS14	Small Frozen Tuna	5	1	1
115	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Doloremque assumenda provident autem et laudantium quia. Vitae et sint ratione qui et et non eos. Porro architecto velit non dolorum fuga reprehenderit nostrum. Sunt recusandae quia aut saepe voluptatem. Fuga sit libero id nulla aut sed ex voluptates.	2	t	MIS22	Gorgeous Metal Chips	1	1	\N
116	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Natus at natus impedit. Qui quis aperiam culpa. Laudantium sunt ea ut omnis nam illum et rerum et. Est ipsam porro quia. Ullam quia quae impedit aut dolore placeat. Natus ab tenetur fuga. Velit placeat doloribus consectetur ut est eius.	1	t	MIS39	Licensed Wooden Table	4	1	1
117	2021-06-03 11:40:26.483	2021-06-03 11:40:26.489	Qui dignissimos non sed explicabo aperiam libero aperiam et doloremque. Totam qui eius ea sint. Delectus ut distinctio architecto sequi labore repellendus. Atque ex sunt aut quis maxime enim consectetur. Velit consectetur rem illo provident ad sed.	3	t	MIS97	Unbranded Steel Computer	5	1	\N
118	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Est ea aut ut et sint. Voluptatem in sit. In consectetur neque aut dolores placeat rerum porro inventore. Excepturi repellendus pariatur quia non ipsam et quia. Eaque ea eum. Nam hic voluptas et magnam quos id qui voluptatum sequi. Blanditiis animi quisquam repudiandae soluta eaque aut reprehenderit quis. Cum et laboriosam est omnis recusandae.	3	t	MIS62	Small Granite Gloves	4	1	\N
119	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Sit aspernatur nihil aliquam voluptatem officiis quia fuga quis sit. Quia totam accusamus. Quaerat praesentium et quidem quo qui. Quia fugiat corrupti sed vel deleniti iusto doloribus. Et tenetur quia autem soluta a excepturi quis. Est ipsam omnis expedita natus accusantium debitis in. Dolor recusandae facere quo ea et sed. Officiis quis repudiandae sunt.	3	t	MIS11	Refined Granite Bike	5	1	\N
120	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Occaecati sed quaerat. Nisi ut ea omnis impedit quos est fuga perspiciatis molestiae. Unde quisquam dolorem. Nemo recusandae placeat minus est quia quas omnis atque. Earum earum expedita ratione.	2	t	MIS10	Awesome Frozen Chair	2	1	1
121	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Enim voluptatum qui autem blanditiis quia hic modi. Aut voluptatum ullam voluptas et minima illo enim optio ea. Ut quisquam perspiciatis commodi aut commodi aliquam quo qui est. Pariatur voluptatem repudiandae inventore sed aut eos dolor. Quibusdam qui pariatur ipsum quibusdam.	2	t	MIS18	Unbranded Steel Car	5	1	1
122	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Eius temporibus consequatur dignissimos. Ea ex doloribus repellendus ipsum qui et et. Adipisci consectetur magnam. Et distinctio accusamus. Tempore ipsam harum tempora minima molestias et atque aut.	1	t	MIS67	Refined Fresh Sausages	3	1	1
123	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Magni incidunt aut sint soluta possimus impedit officia necessitatibus. Consequatur sequi aut eveniet quas eligendi ut labore voluptatem. Sunt et iste mollitia qui et vel pariatur sequi eos. Explicabo vitae optio est. Et ipsum illum. Est et eum sint quo nobis quos voluptatem nihil.	1	t	MIS56	Fantastic Concrete Chicken	1	1	\N
124	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Eaque provident doloribus maiores deserunt aut deleniti. Ut assumenda omnis. Incidunt aut qui natus et et rerum vel officia. Odit itaque rem illum. Ut debitis cumque consectetur. Vel illo facere. Dolor iure sit vel rerum ab.	1	t	MIS57	Fantastic Soft Keyboard	1	1	\N
125	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Esse itaque suscipit tempore quas dignissimos quo accusantium maxime. Exercitationem accusamus ex molestiae doloremque cupiditate maiores ut quasi. Est at libero ut autem doloribus sit et non eum. Sunt cumque ut. Voluptatem error veritatis. Quas et sunt. Reprehenderit dolore aut natus vel voluptas alias vel iusto. Alias aliquam rerum magnam omnis.	4	t	MIS74	Small Rubber Sausages	4	1	1
126	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Necessitatibus velit laborum. Omnis eaque consequuntur excepturi. Numquam qui neque praesentium enim cumque laboriosam numquam. Et quia ipsum perferendis. Aperiam velit et eum doloribus odit qui voluptatibus.	1	t	MIS39	Gorgeous Metal Keyboard	3	1	1
127	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Accusantium velit possimus tempore. Et sit id non at maiores aut modi et qui. Omnis atque repellendus maiores voluptatem. Nisi ullam eos facere accusamus necessitatibus. Corporis modi voluptas rem cupiditate alias vel dolores. Odio quo doloremque qui magnam.	1	t	MIS97	Intelligent Frozen Bacon	5	1	\N
128	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Quisquam at dicta ut enim dolore. Quis praesentium accusamus. Asperiores fugiat magnam repellat sit culpa cum quia qui ratione. Nulla sapiente non saepe. Sed natus non iure est.	2	t	MIS81	Practical Frozen Bike	5	1	\N
129	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Porro qui vel. Eos alias illo vitae necessitatibus deleniti. Vitae optio aliquid tenetur ut animi eos. Est facere quia illo ipsam earum est. Possimus natus enim ut aut rerum quis. Voluptate molestias dolor illum. Qui omnis minima natus error.	2	t	MIS10	Generic Steel Chicken	2	1	1
130	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Animi modi et. Sed rem in praesentium quia nesciunt libero voluptas. Magnam voluptas saepe. Rem totam facere at dolore. In cum porro ut sed.	4	t	MIS89	Gorgeous Wooden Fish	4	1	\N
131	2021-06-03 11:40:26.484	2021-06-03 11:40:26.489	Earum earum eum. Possimus consequatur et aspernatur alias. Iusto quo est accusantium. Sunt quisquam a qui asperiores. Repellat error eos ut ex laborum quia voluptas. Dolore dolor molestias nisi assumenda dolorum doloremque animi voluptas. Sapiente doloribus modi. Ipsam voluptas ipsum non aut placeat corporis consequatur ullam.	2	t	MIS59	Handcrafted Wooden Chips	2	1	1
132	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Perferendis consequatur praesentium commodi quod perspiciatis. Iure magni ut aut qui blanditiis soluta sit nobis. Occaecati est explicabo. Qui eveniet vel. Enim ad deserunt maiores.	3	t	MIS68	Handmade Cotton Table	3	1	\N
133	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Eos sint iure porro et in cum qui libero. Officia et pariatur aliquid suscipit pariatur. Natus porro soluta neque et. Officia quisquam molestiae esse quos. Aut animi sequi occaecati sed voluptatem consectetur. Pariatur dolorem tenetur enim illum veniam commodi excepturi dignissimos amet. Et quisquam sit suscipit repellendus.	1	t	MIS55	Fantastic Metal Shoes	1	1	1
134	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Inventore nesciunt provident nulla asperiores ut. Et dolorem odit. Esse totam ullam ut aperiam fugit id consequatur. Dolor earum nostrum assumenda commodi quia. Ratione et debitis aut. Cumque voluptas quo ut voluptatum. Et ipsum corporis iusto. Sequi ea dolorem amet exercitationem sunt porro.	3	t	MIS75	Small Granite Mouse	2	1	1
135	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Voluptatum facere et quia sunt repudiandae dolor. Animi est numquam corrupti laboriosam ut totam laudantium. Atque est perferendis qui qui ab est libero dolor. Et aut eum voluptas doloribus dolores exercitationem non. Voluptas similique temporibus. Est corporis porro nesciunt non eius dignissimos atque omnis quos.	3	t	MIS8	Intelligent Frozen Pizza	2	1	\N
136	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Quisquam ullam velit et esse voluptatibus. Iure quia eius nobis enim. Ab nostrum molestias repudiandae quaerat impedit asperiores. Quam ea rerum enim quod repellat maxime est. Officiis ut qui. Quo non quos. Et illum quis et temporibus.	2	t	MIS30	Awesome Plastic Towels	1	1	\N
137	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Dolores eos expedita odit. Eveniet ab exercitationem voluptatem minima in hic ut. Tempora cum sit mollitia ducimus eos quam aut nam. Non eligendi nostrum asperiores cupiditate vel consequuntur et. Sit doloremque magnam id voluptas. Similique totam ut sed est quidem rerum.	1	t	MIS80	Gorgeous Concrete Pizza	4	1	1
138	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Saepe voluptatem optio culpa itaque harum ratione mollitia nisi. Iusto blanditiis expedita minus ab dolor. Et sed molestiae ut tenetur eveniet eius ut explicabo non. Quod ipsam laudantium necessitatibus. Fugiat laboriosam ut nemo velit eum aut sit qui voluptatem. Accusantium omnis dicta dicta unde pariatur quas. Voluptatem sed consequatur porro modi voluptates quia.	1	t	MIS42	Intelligent Metal Shirt	3	1	1
139	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Qui consequatur enim animi est recusandae enim. Deleniti quia animi consequuntur et voluptatem omnis quas perferendis sequi. Omnis commodi quasi eaque tempora. Voluptatem ipsam nobis fugiat excepturi. Optio corrupti suscipit culpa totam est voluptas qui. Animi voluptas itaque magnam vel quia neque qui. Mollitia voluptatem voluptatem dolorem ratione omnis.	1	t	MIS70	Small Wooden Keyboard	5	1	\N
140	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Qui consequatur sunt ea neque voluptas aut atque. Qui provident natus esse atque reprehenderit non accusamus sunt explicabo. Voluptatem enim doloribus neque aut est odio deserunt dolor nemo. Nam distinctio nemo voluptatibus sit totam omnis. Ut dignissimos aut quod. Fuga ut adipisci reiciendis. Quis quis ab dolor quia quis pariatur ut quia. Aliquid quidem officiis.	2	t	MIS91	Gorgeous Granite Chips	1	1	1
141	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Eum et consequatur eligendi quam ex est sunt rerum qui. Cupiditate quos ex impedit est. Eius aspernatur error eos eaque voluptatibus tempora. Praesentium enim et enim dolore ipsum. Maiores non voluptates odio iusto ut officia.	4	t	MIS71	Rustic Metal Cheese	2	1	1
142	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Placeat vel temporibus accusantium corporis magnam doloribus. Id officia id beatae quisquam. Deserunt quas velit consequatur fugit unde. Ut tempora suscipit dignissimos qui quis. Sed rerum omnis quibusdam. Provident omnis minus vitae eligendi quas quis at. Qui et labore. Tempora dolor ullam ea enim rerum iusto nobis.	4	t	MIS22	Awesome Cotton Shirt	2	1	\N
143	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Consequuntur illum esse repellendus quia provident deleniti non aut natus. Consequatur et est. Accusantium corporis ad magnam delectus odit sed. Aut qui eum rem adipisci ipsum accusamus accusamus dolore. Mollitia ea ex non sed officia. Consequatur accusamus libero corporis voluptatem consequatur. Placeat culpa tempora id et hic.	4	t	MIS0	Licensed Fresh Chicken	5	1	1
144	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Vel dolores quis. Aspernatur est veritatis nihil est dolore. Officiis accusamus unde et iure quia vel. Sed ratione repudiandae. Voluptate fugit cumque nisi delectus maxime omnis dolore et voluptas. Deserunt voluptatem totam. Quia ipsam et vel ut adipisci et.	1	t	MIS39	Incredible Granite Ball	1	1	\N
145	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Et incidunt sed. Facere quis voluptate quia aut placeat repellendus. Sunt enim voluptas ut quo praesentium. Quo voluptatem qui. Perferendis ea praesentium recusandae voluptate.	4	t	MIS80	Gorgeous Concrete Sausages	2	1	1
146	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Molestiae magnam sed numquam aliquam aut tempore qui. Voluptatem possimus qui. At ex rerum. Tenetur dolores qui et aliquid cum amet. Temporibus quos cum eos tempora et quam.	1	t	MIS38	Handcrafted Wooden Bacon	3	1	1
147	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Impedit nisi quis et. Ipsa suscipit eligendi vero. Porro aperiam occaecati exercitationem. Ut recusandae officiis. Repudiandae tenetur porro expedita ex. Maxime repudiandae rerum eum est quia temporibus fuga sed.	4	t	MIS86	Awesome Wooden Computer	2	1	1
148	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	At nobis et voluptates. Provident repellat sequi labore qui neque commodi. Corrupti rerum cumque reprehenderit sed modi ex. Excepturi omnis excepturi animi. Sint quod a non in. Perspiciatis molestias ipsam. Odit nesciunt placeat enim voluptatem. Aspernatur voluptatem eaque.	1	t	MIS70	Handcrafted Concrete Chips	5	1	\N
149	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Eum non voluptas aut soluta. Facilis voluptate ipsa est. Qui fugiat omnis vero expedita porro veniam temporibus reprehenderit. Sit tempore modi ad suscipit expedita. Iusto et qui eligendi eaque sunt eos cumque rerum. Nulla quod est fugit sed commodi totam.	2	t	MIS85	Tasty Fresh Ball	5	1	\N
150	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Dignissimos accusamus dolorem aut. Laboriosam itaque quae et exercitationem adipisci quia eveniet ratione. A repudiandae atque minima aut autem cumque est qui. Accusamus hic ullam. Consectetur consequatur sunt soluta fuga dignissimos et doloribus. Odit nostrum fugiat minus eius unde.	3	t	MIS90	Ergonomic Rubber Salad	3	1	1
151	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Quos consequatur ut esse sit eligendi nam nam dolorem a. Ipsam ullam explicabo corrupti dolorum aspernatur totam quia. Quaerat odio fugit unde repellendus quo. Non doloribus voluptate. Saepe magni numquam ut sint. Ipsam autem id dolor et pariatur eaque rerum. Dolorum exercitationem sed porro quisquam itaque natus. Voluptatum incidunt sunt voluptatem voluptates provident et non et.	4	t	MIS34	Rustic Cotton Chips	5	1	1
152	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Laborum culpa architecto. Non rerum nemo id aut explicabo mollitia dolorem ullam iusto. Dolorem dolor consectetur dolorem incidunt omnis consequatur officiis temporibus et. Aut consequatur deserunt consequatur. Odio molestiae voluptates repellendus temporibus error quasi laudantium molestiae.	1	t	MIS45	Fantastic Cotton Hat	5	1	1
153	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Dolore dolor tempore fugit sequi et eos beatae. Quia aut est reiciendis est omnis. Nulla vel non similique error aliquid omnis. Dicta atque quia quia earum iure dolores nihil nam. Sapiente dolore distinctio rerum inventore omnis. Cum eligendi ducimus dolor magnam natus sit ducimus veniam eveniet.	4	t	MIS34	Awesome Plastic Chicken	4	1	1
154	2021-06-03 11:40:26.485	2021-06-03 11:40:26.489	Aut nihil omnis tempore facere quis voluptas dolor expedita id. Iusto molestiae voluptatem aut occaecati voluptas. Ipsam sapiente deleniti doloremque eos tenetur est qui. Sapiente rerum sed et voluptate nemo ullam ut eum iste. Dolore iusto adipisci nisi non aut impedit. Commodi suscipit sit eaque nobis impedit. Fugit cumque eos in est mollitia eveniet iste. Tempora et vitae optio voluptas et dolor deleniti et.	4	t	MIS51	Fantastic Plastic Mouse	2	1	1
155	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Quis facere odio voluptas voluptas consequatur placeat impedit voluptates ipsa. Quis harum et. Facilis perspiciatis distinctio aliquid quod. Qui ipsa corporis delectus quis autem iusto nam sapiente tempore. Ad quasi repellendus voluptates. Qui qui voluptas voluptas eveniet cum.	1	t	MIS34	Tasty Plastic Pants	3	1	\N
156	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Fugiat voluptates veniam sequi eligendi magnam. Adipisci deleniti et et ipsam recusandae sint. Minus consectetur debitis provident error dolores commodi explicabo. Omnis perferendis ex maxime tempora voluptatem quidem. Ipsam fugiat rerum et odio. Aliquam qui molestiae in dolores minus aut. Expedita ex sunt quas maiores praesentium amet et animi. Minima aliquid quo voluptatem assumenda minus voluptas officiis quasi vero.	1	t	MIS12	Unbranded Steel Bike	2	1	\N
157	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Accusamus neque iure accusantium fuga magnam. In explicabo eos asperiores ducimus consequatur. Et ipsam qui maxime. Tenetur explicabo est et placeat temporibus eos rerum. Impedit dolorem accusamus fugit est. Dolor consequatur occaecati distinctio alias. Ipsam culpa voluptatem dolores ipsum consequatur necessitatibus ut sed.	2	t	MIS4	Gorgeous Rubber Sausages	4	1	\N
158	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Maxime quia et cupiditate voluptas corrupti accusantium. Doloremque qui rerum aut ullam voluptas. Quis accusamus et dolores explicabo non ut nostrum alias. Vel earum cum et est occaecati. Repudiandae laudantium aut veritatis consectetur.	1	t	MIS64	Intelligent Concrete Soap	3	1	\N
159	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Et quos impedit sed eum voluptas. Eum sed itaque eum et ad voluptatibus. Nostrum nihil occaecati et. Et nulla tempora esse suscipit nihil vel et. Praesentium alias corporis beatae est. Quasi et illo maiores qui.	4	t	MIS82	Tasty Rubber Shirt	5	1	\N
160	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Hic dolor sequi adipisci nostrum excepturi. Vel id impedit eaque aut aliquid fugiat non odio quasi. Veniam aliquam dolorem enim consectetur quo. Nesciunt quo aspernatur labore perferendis quaerat. Natus autem sapiente. Doloremque sed consequatur in consequuntur ipsa. Consequatur optio laboriosam eius quasi corrupti nobis omnis.	2	t	MIS79	Practical Rubber Shirt	5	1	\N
161	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Sunt est dolorem distinctio delectus voluptatem sint. Odio voluptatem porro sit modi dolorum vero veritatis. Distinctio ea nisi illum repudiandae et et quia. Delectus rerum est quis reiciendis ut. Ipsam nisi accusamus quis perspiciatis et quibusdam. Dicta delectus molestiae quod corrupti et qui aliquid. Illo possimus officia dolor qui sapiente quidem atque nemo impedit.	4	t	MIS42	Intelligent Frozen Shirt	4	1	1
162	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Labore quidem autem nulla sit laboriosam totam cupiditate. Dicta voluptatibus eos sapiente voluptate. Dolorem molestiae doloremque suscipit incidunt ab quia dolor. Ut voluptas officia a ut dolor earum et pariatur. Facilis maxime officia occaecati laudantium odio rerum autem sit. Fugit repudiandae quisquam quae debitis omnis. Officiis nihil quas animi sapiente. Repellendus possimus ipsum rerum asperiores quibusdam fugiat enim.	1	t	MIS100	Gorgeous Soft Shoes	2	1	1
163	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Ipsum ipsum voluptatem maiores et totam laudantium commodi quas velit. Expedita placeat minima. Aut dolores ullam. Vel exercitationem voluptate nihil natus dignissimos. Nostrum quis sunt et deserunt aut quae asperiores. Amet ipsa vel amet neque. Quas ut rerum possimus sit unde.	1	t	MIS88	Tasty Concrete Ball	3	1	1
164	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	A quia ea repudiandae. Numquam fuga consequuntur. Quae labore recusandae totam id architecto. Dolores aut adipisci saepe. Laborum architecto consequatur perspiciatis.	4	t	MIS73	Refined Soft Car	4	1	1
165	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Eum aut saepe veritatis voluptas maiores provident necessitatibus. Nihil omnis quae nostrum molestiae officia aut distinctio. Sunt ut reprehenderit tempore maxime incidunt quam excepturi perferendis tenetur. Nobis sunt adipisci perferendis iure consequuntur facere sit distinctio dolores. Qui aut dignissimos. Quia et aut ad aliquam.	3	t	MIS60	Intelligent Concrete Chicken	5	1	1
166	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Molestiae fugiat impedit sint perferendis repellendus eos non dolores voluptatibus. Repudiandae ut cum. Velit deleniti et. Atque incidunt sit qui enim. Quia eos et. Amet est esse.	2	t	MIS95	Incredible Steel Towels	2	1	\N
167	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Qui autem quia. Commodi ut sunt quam incidunt ab deleniti quam. Doloremque fugiat eos voluptas dicta similique excepturi ratione. Sed quaerat vel et qui hic sit facere. Inventore cupiditate excepturi aspernatur et ut totam ex. Mollitia sed iusto beatae deleniti ipsa et perspiciatis. Quis earum quia at.	4	t	MIS55	Intelligent Wooden Towels	5	1	1
168	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Qui ut ea quia nihil accusamus. Sint dolor consequatur quasi laudantium quis maxime. Eos et ratione est voluptatem. Impedit voluptates aut. Qui occaecati nam omnis neque veniam ex autem animi. Rerum nihil perspiciatis. Illum sint officiis consequatur. Dolores omnis ipsa magni provident ipsam quis minima.	2	t	MIS88	Rustic Fresh Table	4	1	1
169	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Nihil magni animi possimus quis. Earum assumenda tempore maxime voluptatibus laudantium. Aspernatur culpa molestias eligendi vero corporis animi voluptates et sit. Atque ad quia saepe consectetur dolor voluptatem est consequatur quos. Eaque fugit eligendi vel eligendi. Quasi pariatur amet voluptatem unde. Occaecati et qui at in omnis voluptatum mollitia et repudiandae. Non voluptatem veniam ut voluptas.	2	t	MIS34	Licensed Concrete Chicken	4	1	1
170	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Harum repellendus vel autem. Dolores non eos dolor qui ipsum qui quod enim qui. Aliquam minus natus alias aliquid neque. Veniam ullam modi vel eum dolore. Cumque pariatur est error voluptatum debitis quia aut fugiat. Et cum possimus sed quia nisi occaecati sequi tempore.	2	t	MIS96	Handcrafted Steel Shoes	1	1	1
171	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Cumque rem sapiente molestiae aliquid. Sed error itaque quas eligendi. Cumque provident iste nostrum corporis maxime voluptate dolore consectetur reiciendis. Ad doloribus quam. Perferendis et non voluptates.	4	t	MIS66	Sleek Granite Ball	2	1	1
172	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Earum cum aut illum hic praesentium sequi adipisci ipsam. Fuga suscipit occaecati. Est aut quis corporis. Ipsam rem quaerat quia saepe doloribus. Tenetur labore molestias fugiat ut numquam. Dolore optio nihil aut beatae.	2	t	MIS89	Awesome Rubber Sausages	5	1	1
173	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Deleniti delectus qui et nam reprehenderit eum ea dignissimos accusantium. Quis animi nihil et consectetur incidunt consequatur quis. Voluptatem rerum ipsam saepe dignissimos quo laudantium qui sunt. Ipsa deserunt nostrum sed dignissimos quibusdam dolorem minima. Id dolores corrupti consequatur in suscipit. Delectus omnis deserunt voluptas veritatis iure nostrum et similique nesciunt. Praesentium quaerat quam voluptates ut expedita et et. Voluptatibus sint quia delectus quibusdam atque ut et repudiandae fugiat.	2	t	MIS23	Rustic Wooden Ball	3	1	1
174	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Modi quos quaerat ut qui quos illum. At fugit explicabo a voluptatem officiis voluptatem aut culpa officiis. Enim rerum perspiciatis ab adipisci incidunt et. Voluptatem deleniti dolores porro quae quis sit voluptatem. Qui sed nesciunt nihil culpa ut voluptatem. Consequuntur autem quae vel error sint cum dolorum iste. Velit voluptatem ea nam quae. Voluptatem numquam necessitatibus ut deserunt omnis nesciunt consequatur nulla.	3	t	MIS11	Intelligent Plastic Salad	2	1	1
175	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Libero sint maiores et fugit. Enim facere omnis provident quaerat facilis velit. Quidem aliquam assumenda error alias inventore. Ut repellat vel minus non temporibus quis in a. Neque in et libero. Quo rerum libero ut adipisci. Minima distinctio minus. Illum voluptates fugiat voluptatem officia saepe accusantium molestiae magnam.	3	t	MIS17	Refined Cotton Mouse	1	1	1
176	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Quis reiciendis vel consectetur. Facilis ipsa eum neque. Voluptas quia placeat ipsum numquam voluptate consequuntur facilis est. Accusamus mollitia ex et accusantium. Ut numquam architecto qui. Sit nesciunt dicta itaque. Cumque dolorum consequatur et.	3	t	MIS22	Fantastic Frozen Car	4	1	\N
177	2021-06-03 11:40:26.486	2021-06-03 11:40:26.489	Pariatur id quod esse natus impedit. Sed corrupti et adipisci veniam delectus necessitatibus ea. Occaecati id et. Reiciendis eaque illo facere animi dolor a. Voluptatem ratione expedita odit qui ab.	4	t	MIS28	Awesome Soft Hat	5	1	\N
178	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Similique aut minus ut debitis quasi qui accusamus rerum. Quae est distinctio dolor occaecati qui omnis iure. Inventore suscipit quia rerum dicta voluptatem qui facere. Asperiores placeat aspernatur aut. Et dolor totam. Enim est ex nulla consequatur sint consequuntur amet iure fugit. Voluptatibus autem quia corrupti aliquam quo ullam odio.	2	t	MIS72	Ergonomic Wooden Keyboard	2	1	\N
179	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Qui qui incidunt distinctio. Consequatur pariatur ex dolorem non qui. Recusandae soluta molestiae sunt voluptatem. Autem dolores facere quo. Voluptatem autem at ipsam ut doloribus mollitia velit.	1	t	MIS31	Licensed Metal Chicken	2	1	1
180	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Dicta quam expedita sed. Autem sit at doloremque aut. Sit ut quidem quae facilis. Est consequatur maiores doloremque mollitia quia repudiandae maxime at. Est molestiae non voluptas fuga. Numquam odit aliquid laudantium enim sed dolorem dolorem. Tempore qui assumenda voluptatem voluptatem doloremque ipsam dolorem.	3	t	MIS78	Incredible Metal Soap	1	1	1
181	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Labore repudiandae tenetur illum ex. Deleniti omnis accusantium voluptatem molestiae dolorem mollitia laborum. Et voluptatem et excepturi id fugit et a sed. Ratione quas sit est aut quo molestiae. Ut nam omnis dolores odio.	1	t	MIS92	Refined Cotton Car	2	1	\N
182	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Ut qui quia aut dicta. Incidunt odit assumenda omnis corporis omnis nisi recusandae. Aut dolore quisquam quia eos. Repellendus expedita et illum dignissimos et tempora iusto sit in. Et nobis temporibus sed voluptatum. Facere earum laudantium deserunt quas laborum consectetur voluptatem omnis. Molestiae ipsam illum nisi magnam.	1	t	MIS32	Tasty Plastic Bike	3	1	\N
183	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Fuga fuga eveniet aut saepe recusandae pariatur ut quibusdam. Dolores officia commodi doloremque quae. Facilis corporis porro non quas. Vel sunt est quam sit. Excepturi eius inventore. Laudantium recusandae aperiam sunt quis consequatur itaque iusto est soluta.	2	t	MIS19	Sleek Plastic Salad	1	1	1
184	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Recusandae ut earum. Quasi quia animi aperiam ullam. Non et voluptatem eveniet eum illum quas quibusdam aspernatur. Quidem inventore dolores optio iusto sapiente consequuntur. Aperiam eaque est velit illo.	1	t	MIS59	Unbranded Fresh Soap	1	1	\N
185	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Id optio voluptatem. Repellendus facere adipisci sed aut dolorem in. Voluptatum eum sunt. Voluptatem quod itaque corporis maiores est tempora totam iusto. Labore facere cumque consequatur quas corrupti voluptas.	1	t	MIS48	Intelligent Rubber Fish	4	1	1
186	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Veniam laudantium eius expedita voluptate voluptatibus qui corrupti est aliquam. Doloremque harum enim dolorem totam et aliquid et natus a. Quaerat id ipsum voluptatem vel est rerum. Iure nam omnis dolore. Aut unde ut eius tenetur laborum.	1	t	MIS6	Small Metal Hat	1	1	1
187	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Ex sit dolores quasi quis accusamus quibusdam libero. Mollitia voluptatem repellendus omnis. Qui dignissimos ex ex doloremque ab enim nisi. Molestiae dolor unde non facilis ut. Veniam et nihil eos molestiae et repudiandae esse dolores dignissimos.	3	t	MIS91	Practical Rubber Shoes	4	1	\N
188	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Ea corrupti consequatur porro sunt quod ratione labore qui. Omnis alias necessitatibus enim. Voluptates illo natus qui. Sed voluptas minima. Repudiandae ipsum repellendus corrupti est quae nostrum officiis sint et. Aspernatur et deleniti et sed ipsam. Repellendus sunt nulla tempore blanditiis quia mollitia. In soluta molestias sint sunt aliquam explicabo ut nobis ea.	3	t	MIS42	Gorgeous Metal Salad	5	1	\N
189	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Non voluptatem ratione laboriosam explicabo exercitationem eaque. Consequatur doloribus placeat voluptate asperiores dicta qui architecto sit sunt. Voluptatum qui eos ut praesentium iure in dolor enim. Id quia ipsa mollitia nesciunt sapiente maiores vel deleniti. Eligendi reprehenderit sit sint id et sed.	1	t	MIS95	Licensed Metal Fish	1	1	\N
190	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Rem ea odit modi ut dolores est aliquid itaque nisi. Voluptas est cum omnis nam ullam iste et vel. Sit cum ratione dicta quisquam non sequi ipsa omnis occaecati. Minima praesentium nihil labore quis quidem incidunt eum et. Corrupti ipsum ipsam commodi omnis reprehenderit error consequuntur nihil.	4	t	MIS64	Intelligent Steel Tuna	1	1	\N
191	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Molestiae harum nulla sunt aut omnis. Et sit ut quo ut. Ut dolores adipisci libero est. Rerum dolorem maiores nihil. Culpa nesciunt quis autem.	4	t	MIS60	Fantastic Steel Salad	4	1	\N
192	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Sit et minima ipsum voluptatem veritatis temporibus pariatur. Enim labore corrupti qui odio est. Deserunt corporis neque omnis hic laboriosam rerum enim aut ipsum. Molestiae aperiam ipsum itaque. Id blanditiis magni ipsum libero veniam dolor blanditiis ut deleniti. Et eum possimus aperiam sint voluptas voluptatum magni. Accusantium non et veritatis aut dolorem aut ipsam.	4	t	MIS24	Handcrafted Fresh Gloves	2	1	1
193	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Voluptatem enim natus perspiciatis dicta molestias. Magni quis delectus dicta adipisci. Reprehenderit ullam vero ut. Labore molestias nulla reprehenderit amet doloremque perferendis. Qui itaque omnis nostrum soluta dolores voluptatem autem magni nihil. Enim libero aut voluptatem ex. Enim minima saepe quia aspernatur. Corrupti dolorem ut nesciunt in omnis sit corporis voluptatem voluptatem.	1	t	MIS16	Intelligent Fresh Pizza	5	1	1
194	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Aliquam vel corrupti esse velit nam. Qui sint sit aut repudiandae et impedit praesentium impedit rerum. Amet fugiat assumenda fugiat id. Totam facilis in. Sit ratione ullam sequi eos rerum deserunt error.	2	t	MIS33	Licensed Frozen Hat	4	1	\N
195	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Fugit odio et. Molestiae non impedit laudantium expedita error fuga quo. Saepe blanditiis voluptatum vel. Fugiat voluptatum ratione est ullam non optio id dignissimos eos. Magni cumque reprehenderit qui. Deserunt omnis sed repellat qui est rerum facere. Id a iusto. Corrupti officia earum id ut est.	2	t	MIS76	Fantastic Plastic Car	2	1	1
196	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Ex natus eveniet dolore consequuntur architecto quod iure quis voluptas. Velit in iure nemo iure numquam quae. Asperiores neque id sunt autem. Minima iure voluptatem. Natus nemo quisquam ipsum. Magnam ea sequi nostrum debitis minima quia tempore. Velit asperiores minima sint qui facilis exercitationem ullam.	2	t	MIS25	Generic Fresh Pants	3	1	1
197	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Laudantium sit fuga sint quia laudantium quaerat et. Sint nihil voluptatibus expedita possimus sint. Et molestiae omnis maxime. Ipsum autem dignissimos vel quod repudiandae nisi. Ea aliquid recusandae possimus ut ab dolores. Ex quasi facere odit.	1	t	MIS55	Fantastic Soft Fish	5	1	\N
198	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Maiores aut et non. Illo et optio illo recusandae laborum debitis inventore pariatur hic. Deleniti quas soluta sed minima fugiat laboriosam. Rerum aut enim officiis repellendus deleniti. Minus voluptatem recusandae sed voluptatem vero.	1	t	MIS43	Sleek Concrete Table	4	1	1
199	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Quod soluta suscipit dolorem porro qui. Consequatur maiores dolore nulla dolorum porro nostrum error sit qui. Eos rerum rerum vel odit suscipit repudiandae sed. Ut voluptatem unde earum assumenda harum voluptas. Corporis repellendus omnis animi et. Consequatur quam eligendi non dolorem omnis beatae. Dignissimos corrupti rerum sed ducimus mollitia repellat ut.	3	t	MIS31	Generic Steel Pizza	1	1	\N
200	2021-06-03 11:40:26.487	2021-06-03 11:40:26.489	Adipisci et est voluptatem consequatur est id. Fugiat ut nemo quia aperiam. Minima quam reprehenderit reiciendis quam tempora quia. Reiciendis culpa quaerat quo aut quas aut sequi non. Non temporibus aut voluptatem.	4	t	MIS61	Sleek Soft Hat	3	1	\N
\.


--
-- Data for Name: Enrollment; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public."Enrollment" (id, "createdAt", "updatedAt", "supervisorId", "studentID", "courseID", "isAproved", status) FROM stdin;
\.


--
-- Data for Name: FinishedCourses; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public."FinishedCourses" ("courseId", "studentID", "createdAt", "updatedAt", grade, semester, "instructorName", id) FROM stdin;
41	13	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	1.6	SUMMER	DR. Sameh Abdelrahman	1
53	59	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	4	FALL	DR. Mohamed Omar	2
55	1	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	1	FALL	DR. Omar Sameh	3
9	20	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	0.2	SUMMER	DR. Mahmoud Hosni	4
44	20	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	3.2	SPRING	DR. Abdelrahman Mahmoud	5
61	36	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	3.8	FALL	DR. Ali Mahmoud	6
15	10	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	0.2	FALL	DR. Hussin Mohamed	7
41	14	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	3	SUMMER	DR. Omar Hosni	8
86	75	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	2.8	FALL	DR. Kamal Omar	9
89	99	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	2	SUMMER	DR. Ahmed Karim	10
71	58	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	1	SUMMER	DR. Mahmoud Omar	11
54	39	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	3.6	SPRING	DR. Abdelrahman Omar	12
63	49	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	1.6	FALL	DR. Ahmed Kamal	13
84	38	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	0.8	SUMMER	DR. Karim Abdelrahman	14
73	56	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	1.6	SUMMER	DR. Hosni Omar	15
90	68	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	3.2	SPRING	DR. Ali Mahmoud	16
61	30	2021-06-03 11:40:26.601	2021-06-03 11:40:26.607	1.2	SPRING	DR. Hosni Ahmed	17
96	60	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	2.2	SPRING	DR. Mohamed Ali	18
23	74	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	2.2	SPRING	DR. Omar Ahmed	19
45	97	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	4	SPRING	DR. Mahmoud Omar	20
63	52	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	3.8	FALL	DR. Mahmoud Mahmoud	21
13	86	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	3.6	SPRING	DR. Ali Mahmoud	22
17	2	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	3.6	SPRING	DR. Ahmed Hosni	23
82	48	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	0.6	SUMMER	DR. Sameh Omar	24
2	6	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	2	SUMMER	DR. Karim Mahmoud	25
65	32	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	1.8	FALL	DR. Ahmed Omar	26
23	90	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	3.2	SUMMER	DR. Hussin Abdelrahman	27
56	48	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	1	SPRING	DR. Omar Mohamed	28
29	91	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	3	SUMMER	DR. Hosni Hosni	29
5	5	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	0	SUMMER	DR. Mohamed Abdelrahman	30
87	87	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	3	SUMMER	DR. Omar Hosni	31
90	53	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	1.4	FALL	DR. Hussin Omar	32
98	68	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	1.8	SUMMER	DR. Kamal Kamal	33
66	83	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	3	FALL	DR. Ali Sameh	34
23	75	2021-06-03 11:40:26.602	2021-06-03 11:40:26.607	0.6	SPRING	DR. Kamal Abdelrahman	35
21	29	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	1.8	SPRING	DR. Ali Karim	36
26	100	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	1.8	SPRING	DR. Mohamed Mahmoud	37
98	58	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	0.8	FALL	DR. Hosni Hussin	38
59	81	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	2.6	SUMMER	DR. Omar Abdelrahman	39
8	87	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	1	SPRING	DR. Ali Ali	40
2	27	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	3.4	FALL	DR. Kamal Sameh	41
53	10	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	2	FALL	DR. Karim Kamal	42
41	95	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	0.4	FALL	DR. Sameh Abdelrahman	43
37	47	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	3.8	SUMMER	DR. Hosni Kamal	44
41	16	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	3.8	SPRING	DR. Hussin Omar	45
29	16	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	1.2	SUMMER	DR. Abdelrahman Mahmoud	46
11	23	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	4	SPRING	DR. Hosni Abdelrahman	47
90	33	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	3.4	FALL	DR. Hosni Hussin	48
30	55	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	0.2	SPRING	DR. Sameh Hosni	49
42	71	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	0.2	SPRING	DR. Kamal Karim	50
60	38	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	1.2	FALL	DR. Ahmed Omar	51
97	76	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	3.2	SPRING	DR. Mohamed Ahmed	52
30	58	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	3.2	FALL	DR. Sameh Mahmoud	53
85	21	2021-06-03 11:40:26.603	2021-06-03 11:40:26.607	0.2	SPRING	DR. Abdelrahman Hosni	54
86	67	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	1	SPRING	DR. Omar Sameh	55
13	98	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	0.2	FALL	DR. Mohamed Mohamed	56
41	35	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2	SUMMER	DR. Ahmed Kamal	57
71	77	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	3.2	SUMMER	DR. Mohamed Sameh	58
45	24	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2.8	SUMMER	DR. Hosni Abdelrahman	59
14	63	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2.6	SPRING	DR. Mahmoud Ahmed	60
22	41	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2.4	SUMMER	DR. Sameh Karim	61
43	70	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	3.2	FALL	DR. Omar Ali	62
88	91	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	1	SPRING	DR. Mahmoud Karim	63
8	17	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2.2	SPRING	DR. Kamal Ahmed	64
73	20	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	0.8	FALL	DR. Hosni Sameh	65
97	83	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	1.2	FALL	DR. Mohamed Omar	66
23	76	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2.8	SUMMER	DR. Ahmed Mahmoud	67
22	33	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2	SUMMER	DR. Ahmed Hosni	68
99	94	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	1.8	FALL	DR. Hussin Hussin	69
27	56	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2.4	SUMMER	DR. Omar Ali	70
23	70	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	2.6	SPRING	DR. Hussin Ahmed	71
81	60	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	1.2	SUMMER	DR. Hosni Karim	72
74	11	2021-06-03 11:40:26.604	2021-06-03 11:40:26.607	1.4	SPRING	DR. Kamal Hussin	73
92	40	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	2.2	SUMMER	DR. Karim Mohamed	74
83	92	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	2.2	FALL	DR. Omar Hosni	75
48	48	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	2.6	FALL	DR. Mahmoud Hussin	76
29	75	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	4	FALL	DR. Mohamed Omar	77
96	63	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	2.2	SUMMER	DR. Sameh Mohamed	78
16	46	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	0.8	SPRING	DR. Ali Abdelrahman	79
13	53	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	3	SUMMER	DR. Abdelrahman Ali	80
41	89	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	2.4	FALL	DR. Kamal Omar	81
1	43	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	2.4	SPRING	DR. Hussin Karim	82
72	90	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	3.4	SPRING	DR. Mohamed Hosni	83
12	1	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	3.8	SPRING	DR. Kamal Omar	84
35	100	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	2.6	FALL	DR. Sameh Kamal	85
35	74	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	4	SUMMER	DR. Mahmoud Mohamed	86
43	50	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	3.4	FALL	DR. Ali Ali	87
14	3	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	0	SPRING	DR. Hussin Kamal	88
96	11	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	0.6	SPRING	DR. Mahmoud Ali	89
72	9	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	2.2	FALL	DR. Ahmed Hussin	90
43	7	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	3.8	SUMMER	DR. Abdelrahman Hussin	91
82	18	2021-06-03 11:40:26.605	2021-06-03 11:40:26.607	4	SUMMER	DR. Omar Hosni	92
93	4	2021-06-03 11:40:26.606	2021-06-03 11:40:26.607	3.2	SUMMER	DR. Mahmoud Hosni	93
87	62	2021-06-03 11:40:26.606	2021-06-03 11:40:26.607	0.2	SPRING	DR. Karim Kamal	94
35	31	2021-06-03 11:40:26.606	2021-06-03 11:40:26.607	3.6	SPRING	DR. Hussin Karim	95
15	83	2021-06-03 11:40:26.606	2021-06-03 11:40:26.607	2.4	SUMMER	DR. Sameh Sameh	96
59	83	2021-06-03 11:40:26.606	2021-06-03 11:40:26.607	3.4	SPRING	DR. Mahmoud Ali	97
11	60	2021-06-03 11:40:26.606	2021-06-03 11:40:26.607	0.6	SUMMER	DR. Kamal Mohamed	98
5	76	2021-06-03 11:40:26.606	2021-06-03 11:40:26.607	2	FALL	DR. Sameh Hosni	99
24	49	2021-06-03 11:40:26.606	2021-06-03 11:40:26.607	3	FALL	DR. Karim Mohamed	100
41	13	2021-06-03 11:40:26.627	2021-06-03 11:40:26.634	1.6	SUMMER	DR. Sameh Abdelrahman	101
53	59	2021-06-03 11:40:26.627	2021-06-03 11:40:26.634	4	FALL	DR. Mohamed Omar	102
55	1	2021-06-03 11:40:26.627	2021-06-03 11:40:26.634	1	FALL	DR. Omar Sameh	103
9	20	2021-06-03 11:40:26.627	2021-06-03 11:40:26.634	0.2	SUMMER	DR. Mahmoud Hosni	104
44	20	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	3.2	SPRING	DR. Abdelrahman Mahmoud	105
61	36	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	3.8	FALL	DR. Ali Mahmoud	106
15	10	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	0.2	FALL	DR. Hussin Mohamed	107
41	14	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	3	SUMMER	DR. Omar Hosni	108
86	75	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	2.8	FALL	DR. Kamal Omar	109
89	99	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	2	SUMMER	DR. Ahmed Karim	110
71	58	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	1	SUMMER	DR. Mahmoud Omar	111
54	39	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	3.6	SPRING	DR. Abdelrahman Omar	112
63	49	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	1.6	FALL	DR. Ahmed Kamal	113
84	38	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	0.8	SUMMER	DR. Karim Abdelrahman	114
73	56	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	1.6	SUMMER	DR. Hosni Omar	115
90	68	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	3.2	SPRING	DR. Ali Mahmoud	116
61	30	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	1.2	SPRING	DR. Hosni Ahmed	117
96	60	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	2.2	SPRING	DR. Mohamed Ali	118
23	74	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	2.2	SPRING	DR. Omar Ahmed	119
45	97	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	4	SPRING	DR. Mahmoud Omar	120
63	52	2021-06-03 11:40:26.628	2021-06-03 11:40:26.634	3.8	FALL	DR. Mahmoud Mahmoud	121
13	86	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	3.6	SPRING	DR. Ali Mahmoud	122
17	2	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	3.6	SPRING	DR. Ahmed Hosni	123
82	48	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	0.6	SUMMER	DR. Sameh Omar	124
2	6	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	2	SUMMER	DR. Karim Mahmoud	125
65	32	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	1.8	FALL	DR. Ahmed Omar	126
23	90	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	3.2	SUMMER	DR. Hussin Abdelrahman	127
56	48	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	1	SPRING	DR. Omar Mohamed	128
29	91	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	3	SUMMER	DR. Hosni Hosni	129
5	5	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	0	SUMMER	DR. Mohamed Abdelrahman	130
87	87	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	3	SUMMER	DR. Omar Hosni	131
90	53	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	1.4	FALL	DR. Hussin Omar	132
98	68	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	1.8	SUMMER	DR. Kamal Kamal	133
66	83	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	3	FALL	DR. Ali Sameh	134
23	75	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	0.6	SPRING	DR. Kamal Abdelrahman	135
21	29	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	1.8	SPRING	DR. Ali Karim	136
26	100	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	1.8	SPRING	DR. Mohamed Mahmoud	137
98	58	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	0.8	FALL	DR. Hosni Hussin	138
59	81	2021-06-03 11:40:26.629	2021-06-03 11:40:26.634	2.6	SUMMER	DR. Omar Abdelrahman	139
8	87	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	1	SPRING	DR. Ali Ali	140
2	27	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	3.4	FALL	DR. Kamal Sameh	141
53	10	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	2	FALL	DR. Karim Kamal	142
41	95	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	0.4	FALL	DR. Sameh Abdelrahman	143
37	47	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	3.8	SUMMER	DR. Hosni Kamal	144
41	16	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	3.8	SPRING	DR. Hussin Omar	145
29	16	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	1.2	SUMMER	DR. Abdelrahman Mahmoud	146
11	23	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	4	SPRING	DR. Hosni Abdelrahman	147
90	33	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	3.4	FALL	DR. Hosni Hussin	148
30	55	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	0.2	SPRING	DR. Sameh Hosni	149
42	71	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	0.2	SPRING	DR. Kamal Karim	150
60	38	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	1.2	FALL	DR. Ahmed Omar	151
97	76	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	3.2	SPRING	DR. Mohamed Ahmed	152
30	58	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	3.2	FALL	DR. Sameh Mahmoud	153
85	21	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	0.2	SPRING	DR. Abdelrahman Hosni	154
86	67	2021-06-03 11:40:26.63	2021-06-03 11:40:26.634	1	SPRING	DR. Omar Sameh	155
13	98	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	0.2	FALL	DR. Mohamed Mohamed	156
41	35	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2	SUMMER	DR. Ahmed Kamal	157
71	77	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	3.2	SUMMER	DR. Mohamed Sameh	158
45	24	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2.8	SUMMER	DR. Hosni Abdelrahman	159
14	63	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2.6	SPRING	DR. Mahmoud Ahmed	160
22	41	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2.4	SUMMER	DR. Sameh Karim	161
43	70	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	3.2	FALL	DR. Omar Ali	162
88	91	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	1	SPRING	DR. Mahmoud Karim	163
8	17	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2.2	SPRING	DR. Kamal Ahmed	164
73	20	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	0.8	FALL	DR. Hosni Sameh	165
97	83	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	1.2	FALL	DR. Mohamed Omar	166
23	76	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2.8	SUMMER	DR. Ahmed Mahmoud	167
22	33	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2	SUMMER	DR. Ahmed Hosni	168
99	94	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	1.8	FALL	DR. Hussin Hussin	169
27	56	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2.4	SUMMER	DR. Omar Ali	170
23	70	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	2.6	SPRING	DR. Hussin Ahmed	171
81	60	2021-06-03 11:40:26.631	2021-06-03 11:40:26.634	1.2	SUMMER	DR. Hosni Karim	172
74	11	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	1.4	SPRING	DR. Kamal Hussin	173
92	40	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	2.2	SUMMER	DR. Karim Mohamed	174
83	92	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	2.2	FALL	DR. Omar Hosni	175
48	48	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	2.6	FALL	DR. Mahmoud Hussin	176
29	75	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	4	FALL	DR. Mohamed Omar	177
96	63	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	2.2	SUMMER	DR. Sameh Mohamed	178
16	46	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	0.8	SPRING	DR. Ali Abdelrahman	179
13	53	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	3	SUMMER	DR. Abdelrahman Ali	180
41	89	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	2.4	FALL	DR. Kamal Omar	181
1	43	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	2.4	SPRING	DR. Hussin Karim	182
72	90	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	3.4	SPRING	DR. Mohamed Hosni	183
12	1	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	3.8	SPRING	DR. Kamal Omar	184
35	100	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	2.6	FALL	DR. Sameh Kamal	185
35	74	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	4	SUMMER	DR. Mahmoud Mohamed	186
43	50	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	3.4	FALL	DR. Ali Ali	187
14	3	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	0	SPRING	DR. Hussin Kamal	188
96	11	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	0.6	SPRING	DR. Mahmoud Ali	189
72	9	2021-06-03 11:40:26.632	2021-06-03 11:40:26.634	2.2	FALL	DR. Ahmed Hussin	190
43	7	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	3.8	SUMMER	DR. Abdelrahman Hussin	191
82	18	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	4	SUMMER	DR. Omar Hosni	192
93	4	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	3.2	SUMMER	DR. Mahmoud Hosni	193
87	62	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	0.2	SPRING	DR. Karim Kamal	194
35	31	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	3.6	SPRING	DR. Hussin Karim	195
15	83	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	2.4	SUMMER	DR. Sameh Sameh	196
59	83	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	3.4	SPRING	DR. Mahmoud Ali	197
11	60	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	0.6	SUMMER	DR. Kamal Mohamed	198
5	76	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	2	FALL	DR. Sameh Hosni	199
24	49	2021-06-03 11:40:26.633	2021-06-03 11:40:26.634	3	FALL	DR. Karim Mohamed	200
\.


--
-- Data for Name: Major; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public."Major" (id, code, name) FROM stdin;
1	MIS	management information system
2	HR	human resource
\.


--
-- Data for Name: Notifications; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public."Notifications" (id, "createdAt", "updatedAt", "supervisorId", "studentID", status, data) FROM stdin;
\.


--
-- Data for Name: Student; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public."Student" (id, "uniCode", "createdAt", "updatedAt", fname, lname, gender, password, email, level, semester, "creditDone", "creditHave", "supervisorId", "GPA", "lastTermGPA", avatar, "majorId", "minorId") FROM stdin;
1	6e943fcb-87fc-4f58-8112-673214f7e8b4	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Hosni	Hosni	MALE	8hYeZqMA9BEoCNo	Vallie.Lowe@yahoo.com	5	SUMMER	40	13	41	2.4	4	/static/images/avatars/avatar_1.png	1	2
2	a8094763-04c7-4f03-960c-a41408ebbe47	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Abdelrahman	Ali	MALE	gAiGHYLDOWtUUlm	Liam0@hotmail.com	4	SUMMER	107	12	58	0.8	1.4	/static/images/avatars/avatar_2.png	1	2
3	d5f15954-97f1-4e51-b6bd-3c2be3caf38a	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Abdelrahman	Hussin	MALE	JmU6sr9nqv0Rre3	Maverick.Weber@gmail.com	2	SUMMER	153	17	22	3.6	1.6	/static/images/avatars/avatar_0.png	1	2
4	6981cb90-ce08-4fdc-b292-81e353fbd466	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Ali	Mahmoud	MALE	xRYDPKwZwxG171G	Kellie.Gleichner@yahoo.com	4	SUMMER	178	18	83	2.2	3	/static/images/avatars/avatar_3.png	1	2
5	6ac20c7e-ef98-490c-9842-df81cb1b8e1f	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Abdelrahman	Karim	MALE	0uaqhv_VsvVp7aN	Shawna49@gmail.com	3	SUMMER	180	14	65	1.4	1.4	/static/images/avatars/avatar_3.png	1	2
6	6c5c95f4-00eb-470b-9d66-881746069a44	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Abdelrahman	Abdelrahman	MALE	3hDHX9CcwojmCg5	Lois.Jones52@gmail.com	1	SUMMER	69	18	4	3.2	3.4	/static/images/avatars/avatar_5.png	1	2
7	a3041330-df99-4fbf-acba-7c569a92f4b6	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Abdelrahman	Omar	MALE	xVnaqUN_0927quu	Nicholas_Bogisich@hotmail.com	2	SUMMER	98	12	30	3	3.4	/static/images/avatars/avatar_6.png	1	2
8	b41b496b-46e4-4150-b291-13dbbe7ea17e	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Mohamed	Karim	MALE	Ye_1f3Y2QYPSfn9	Carolyn.Ward28@yahoo.com	3	SUMMER	148	12	46	0	3	/static/images/avatars/avatar_6.png	1	2
9	b7f0c45c-ff9d-4693-9c09-d5295fa6ba16	2021-06-03 11:40:26.522	2021-06-03 11:40:26.532	Ahmed	Sameh	MALE	OKwpu_HKGKUk_8H	Ignacio_Weissnat47@gmail.com	1	SUMMER	151	18	5	1.2	0.6	/static/images/avatars/avatar_2.png	1	2
10	9945bee8-3b63-4c84-ad46-d4f9c0c05bfe	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Ali	Ali	MALE	FiTZJE_BiyuA8uM	Eloy_Trantow34@yahoo.com	5	SUMMER	31	14	13	3.4	0	/static/images/avatars/avatar_0.png	1	2
11	e144ad3e-81aa-4280-ad91-cf78070a2673	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Mohamed	Mahmoud	MALE	3d9gfHevo4Irui0	Roselyn_Witting17@hotmail.com	5	SUMMER	178	13	23	3.6	3	/static/images/avatars/avatar_1.png	1	2
12	83ed5454-752a-4e73-ac66-9818d1fc3463	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Ahmed	Abdelrahman	MALE	Ai0SZtSzDK4hIqY	Ephraim13@gmail.com	1	SUMMER	133	19	23	0	1.8	/static/images/avatars/avatar_4.png	1	2
13	cfb79716-11fc-452f-8f33-3cde8743c9a8	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Sameh	Abdelrahman	MALE	apZYNdE_DlBltDu	Erik_Pagac@yahoo.com	2	SUMMER	72	15	31	1.8	0.4	/static/images/avatars/avatar_0.png	1	2
14	846c1dfe-6aa7-4974-acee-ba3c29df28bf	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Ahmed	Sameh	MALE	hmvH8sRmDbhrHAV	Kennedy_Gibson60@hotmail.com	2	SUMMER	151	12	99	0.4	2.2	/static/images/avatars/avatar_5.png	1	2
15	5447c0e8-d2aa-4c94-aef7-d2670c5ee78f	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Mahmoud	Karim	MALE	GVpg1wPZ3yFsTpW	Deron1@hotmail.com	3	SUMMER	104	12	40	0.4	3.6	/static/images/avatars/avatar_1.png	1	2
16	6b940e3a-f9cb-416e-9b87-f049e44bc2af	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Sameh	Mohamed	MALE	Phir0OicJy1aXqG	Orval_Pagac93@yahoo.com	4	SUMMER	36	17	60	3.4	0.2	/static/images/avatars/avatar_2.png	1	2
17	48e66cc6-50b7-4ed0-8b1d-a4f12d956c24	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Hussin	Karim	MALE	TGNVXISI6atPyeQ	Branson_Jaskolski@hotmail.com	5	SUMMER	171	14	37	1.4	4	/static/images/avatars/avatar_5.png	1	2
18	3a5376e5-ad9b-4e08-a57a-a0990af523f5	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Ali	Kamal	MALE	BfalI7iAQJ95aEh	Fidel.Stanton@yahoo.com	3	SUMMER	21	17	87	2.2	3.4	/static/images/avatars/avatar_1.png	1	2
19	a5b81173-1075-416f-9c94-5e7ab4987ea4	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Kamal	Abdelrahman	MALE	MGQ6lnpn6qzhUSv	Noemi.Auer15@yahoo.com	4	SUMMER	122	14	86	2.8	3.2	/static/images/avatars/avatar_5.png	1	2
20	36e5e6bd-ba98-4c49-ac2c-a55bd18c574b	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Karim	Sameh	MALE	cm01oi9r9iCx7CT	Joshua51@hotmail.com	2	SUMMER	92	20	72	1	3.6	/static/images/avatars/avatar_6.png	1	2
21	fb55cb20-6a7c-4f7a-8f60-41541bd515a4	2021-06-03 11:40:26.523	2021-06-03 11:40:26.532	Hussin	Kamal	MALE	oN5YLHFv1M_26kY	Melany44@gmail.com	5	SUMMER	78	12	95	2.2	1.6	/static/images/avatars/avatar_2.png	1	2
22	20298318-932e-47c1-9808-4133d293b008	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Ahmed	Kamal	MALE	Ej6hByMegam1eg4	Maryam59@gmail.com	2	SUMMER	193	19	86	2.8	1.6	/static/images/avatars/avatar_0.png	1	2
23	ddf0dc7e-516d-4318-b52b-fa32207a8998	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Hussin	Ahmed	MALE	26gS8Ma1prbtV1G	Julie6@gmail.com	4	SUMMER	108	17	19	3.8	3.6	/static/images/avatars/avatar_4.png	1	2
24	a5ded3b9-4f16-4bb8-8d79-84cee77e679c	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Mahmoud	Sameh	MALE	PYHxdVvLSbR_iG8	Halle.Schulist@gmail.com	2	SUMMER	139	19	65	4	3.2	/static/images/avatars/avatar_6.png	1	2
25	eb3a43d1-4495-4753-834c-822fa809dec6	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Abdelrahman	Abdelrahman	MALE	vbGPY9NcMwllOYg	Virgie_Hagenes64@hotmail.com	4	SUMMER	86	18	57	0.2	2.4	/static/images/avatars/avatar_2.png	1	2
26	47306c57-408d-4a80-8b8a-01d8990d6ad0	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Mahmoud	Hussin	MALE	l3YdJHlsFxr_l1e	Olen83@gmail.com	2	SUMMER	135	20	14	3.6	3.6	/static/images/avatars/avatar_2.png	1	2
27	92a6a2d8-e97c-4064-a903-30c2b278d7a1	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Kamal	Kamal	MALE	O6NkG1VbTPpWp27	Amara.Fay36@gmail.com	2	SUMMER	182	17	40	3.4	3.2	/static/images/avatars/avatar_1.png	1	2
28	76bb1c0c-395d-4085-a0b4-9e3c58835458	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Omar	Ali	MALE	cT3JYkImbNCjNkK	Linnie.Bernhard33@hotmail.com	4	SUMMER	189	13	71	0.8	0.6	/static/images/avatars/avatar_3.png	1	2
29	aa9f8ae9-883f-4b26-9c77-927da00a21dc	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Omar	Ali	MALE	9WxISKkUO0qSXGU	Ada39@gmail.com	2	SUMMER	159	15	45	0.2	1.2	/static/images/avatars/avatar_0.png	1	2
30	59b93185-84eb-4a37-aed6-c0b3eaf3b962	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Kamal	Abdelrahman	MALE	jMMNQoI22cPK1Fh	Kaycee_Dach21@yahoo.com	2	SUMMER	196	20	82	0.2	1.6	/static/images/avatars/avatar_0.png	1	2
31	a09100a3-6512-4985-a01b-c948eca71e5c	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Kamal	Karim	MALE	K3TEUjHdgKqq6Hk	Melyna29@gmail.com	3	SUMMER	35	12	78	3.2	2.2	/static/images/avatars/avatar_4.png	1	2
32	26c21115-8d23-4902-98e7-391dbdedcc35	2021-06-03 11:40:26.524	2021-06-03 11:40:26.532	Mahmoud	Sameh	MALE	d5c7dlLNCZpi_yO	Larue55@hotmail.com	1	SUMMER	143	18	56	0	2.6	/static/images/avatars/avatar_4.png	1	2
33	7f8a07d4-06ba-477d-b785-d96662d1296c	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Ali	Omar	MALE	7Kw7YUN3ngEh8PH	Marley_Bahringer91@gmail.com	3	SUMMER	141	19	55	1.4	3.4	/static/images/avatars/avatar_2.png	1	2
34	aaab4f70-2949-4050-9075-5db1f39ff594	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Ali	Omar	MALE	vyaV7Nf6MB8QISD	Maeve91@yahoo.com	3	SUMMER	141	15	15	2	1.6	/static/images/avatars/avatar_5.png	1	2
35	21f94f11-7a61-45e0-9f6e-3c7200ba7979	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Omar	Hosni	MALE	TepLLEbrN7_6N22	Bryana_Trantow@hotmail.com	2	SUMMER	146	17	40	3	1.2	/static/images/avatars/avatar_6.png	1	2
36	e4fb302c-637b-47a4-8534-1b82619c8849	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Mahmoud	Karim	MALE	uQfIY413p3E_tWB	Aidan45@gmail.com	2	SUMMER	171	16	12	0.8	0.2	/static/images/avatars/avatar_2.png	1	2
37	7d8ca0af-2b45-438d-a382-7c1b7646a565	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Sameh	Hussin	MALE	8zsiu3pmWT1Ydhm	Gaylord32@yahoo.com	2	SUMMER	79	15	78	2.4	1.4	/static/images/avatars/avatar_6.png	1	2
38	c3c546e9-3ba9-4f6c-814d-c5f8cec36adc	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Ahmed	Hussin	MALE	QaH0EQAywLPYV60	Kane97@gmail.com	3	SUMMER	184	15	1	2	3	/static/images/avatars/avatar_2.png	1	2
39	ba857897-bb9d-44ba-9e2c-b5e0f33f3ff2	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Sameh	Hosni	MALE	P5Ha8UlRKEtdj54	Addie.Abbott64@yahoo.com	2	SUMMER	35	13	95	2.4	2.8	/static/images/avatars/avatar_4.png	1	2
40	720ef15e-370c-40a7-a2a7-13b6ca0fc966	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Abdelrahman	Abdelrahman	MALE	cfv64q4e54A7VbA	Art_Schimmel@yahoo.com	3	SUMMER	170	18	54	1.4	3.6	/static/images/avatars/avatar_2.png	1	2
41	019d45d2-c235-48f9-839c-2c648c062a17	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Omar	Kamal	MALE	f00jEOMjRkv793m	Angus.Gleichner@hotmail.com	3	SUMMER	117	12	5	1.6	0.2	/static/images/avatars/avatar_6.png	1	2
42	470466ca-ea06-4b20-953b-42846ed5a3f2	2021-06-03 11:40:26.525	2021-06-03 11:40:26.532	Omar	Karim	MALE	8vQW5q9z3Q8J75S	Therese_Trantow1@yahoo.com	1	SUMMER	198	17	88	0	4	/static/images/avatars/avatar_4.png	1	2
43	6906fdce-9b74-4ce8-b93f-882ecc529f3c	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Kamal	Abdelrahman	MALE	WHUBYwGbLb3GGCr	Helena_Ullrich75@gmail.com	3	SUMMER	22	13	58	2	0.2	/static/images/avatars/avatar_3.png	1	2
44	d4872f07-2e46-4301-b7d7-8d948859fd59	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Mohamed	Karim	MALE	jgwx1ciNrb2P624	Amie65@yahoo.com	1	SUMMER	187	17	49	2.2	2.8	/static/images/avatars/avatar_0.png	1	2
45	7c787d77-3100-4644-a782-cb76936d3669	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Omar	Karim	MALE	onNHoYv2DTaGOM4	Durward.Rogahn@hotmail.com	1	SUMMER	123	19	8	1.6	0	/static/images/avatars/avatar_0.png	1	2
46	e1e09028-3804-4ff4-a445-67956e215105	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Mahmoud	Hussin	MALE	_yuiQiuj17uVfXV	Alexys89@gmail.com	1	SUMMER	152	19	73	2.4	2.6	/static/images/avatars/avatar_0.png	1	2
47	a8cf69b0-3dd3-4ce1-8586-68947710cd03	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Kamal	Mohamed	MALE	pDyzOVGOpV9oqYw	Alexa.Rosenbaum@hotmail.com	4	SUMMER	194	18	33	2.2	0.8	/static/images/avatars/avatar_0.png	1	2
48	d5a5720a-8215-4dde-ae01-c21a751ea28e	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Ahmed	Sameh	MALE	DErAItXdpMgnbnY	Karley_Lynch@hotmail.com	3	SUMMER	146	12	18	2.8	1	/static/images/avatars/avatar_2.png	1	2
49	7e2138e4-f822-4179-9f37-404f26ef575f	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Sameh	Hussin	MALE	hxb1hNpZfzv0YnX	Haven47@hotmail.com	3	SUMMER	189	19	77	4	1.8	/static/images/avatars/avatar_6.png	1	2
50	6e0febf8-b50d-4082-a8a3-e5d1ea9b1622	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Karim	Hussin	MALE	yPuCALE8kyesidW	Nicolette32@hotmail.com	1	SUMMER	93	13	68	1.2	3.4	/static/images/avatars/avatar_4.png	1	2
51	f8cd6438-87f2-44eb-9f71-f11f23b30c1b	2021-06-03 11:40:26.526	2021-06-03 11:40:26.532	Hosni	Sameh	MALE	y70OAzDBZ3bp9pd	Eloise30@hotmail.com	5	SUMMER	66	15	59	3	2.6	/static/images/avatars/avatar_2.png	1	2
52	cbad7d50-3ac0-4ccc-b20f-62d82f50bcbd	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Kamal	Kamal	MALE	FhKTOJ5CHpRIvgW	Raven_Steuber21@gmail.com	4	SUMMER	177	17	12	1.4	3.6	/static/images/avatars/avatar_2.png	1	2
53	e1f3d187-7066-496c-aa6b-476fe920cb16	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Ahmed	Hussin	MALE	CYeFBzM8WP1uI87	Araceli20@hotmail.com	2	SUMMER	105	19	80	1.6	1.2	/static/images/avatars/avatar_1.png	1	2
54	ef471575-ccf9-4328-b40e-288ba65d464c	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Ahmed	Abdelrahman	MALE	K6LFCUnbDNPT7Aw	Brady_Klocko@yahoo.com	5	SUMMER	159	12	65	2.2	2	/static/images/avatars/avatar_6.png	1	2
55	971ef552-fd50-4d08-b239-7e64d9bfb8d0	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Hussin	Omar	MALE	Ar5rcd3k25zXMVS	Lulu_Ernser@gmail.com	1	SUMMER	75	20	89	4	1.8	/static/images/avatars/avatar_0.png	1	2
56	716d6ed4-a8fa-49ee-b997-afb2ef5f06da	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Ali	Ahmed	MALE	WDsZQxvgAPPwPW3	Eva90@gmail.com	2	SUMMER	141	15	18	0.4	2.8	/static/images/avatars/avatar_5.png	1	2
57	422696dd-6e6c-4308-aad6-2bd32e554293	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Karim	Ali	MALE	D6Rppbh4CLGHd0p	Garret_McLaughlin@hotmail.com	2	SUMMER	118	14	77	1.2	2	/static/images/avatars/avatar_5.png	1	2
58	b9b603c5-29db-4d0e-933a-481d1191ed23	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Abdelrahman	Mahmoud	MALE	ihx2vmXxA4cxIg1	Cassie.Sauer@gmail.com	1	SUMMER	36	17	33	1.8	2.4	/static/images/avatars/avatar_1.png	1	2
59	06c8ad75-90ca-4735-b33d-f2696d02904f	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Ali	Ali	MALE	61TF2p9wUtGGoE7	Orie_Torphy@yahoo.com	5	SUMMER	175	18	35	0.8	3.6	/static/images/avatars/avatar_5.png	1	2
60	39434f3b-ddc3-4acb-8569-fa60b0b6c46e	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Omar	Abdelrahman	MALE	KjuLHeqDigOm_uo	Kaci80@hotmail.com	4	SUMMER	82	13	92	2.2	1	/static/images/avatars/avatar_3.png	1	2
61	a0964dfe-eec1-4d3b-85b6-21d94a9e61e6	2021-06-03 11:40:26.527	2021-06-03 11:40:26.532	Kamal	Ahmed	MALE	MRK1hSkiQB7jSqZ	Nyasia_Boehm@gmail.com	3	SUMMER	54	20	93	1.2	2.4	/static/images/avatars/avatar_4.png	1	2
62	8b2422dc-5c7b-4c38-9345-81c8e263a69d	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Karim	Karim	MALE	Sz4FVu7WrTm4Kjb	Raquel_Hilpert92@yahoo.com	2	SUMMER	38	17	69	0.2	3.4	/static/images/avatars/avatar_2.png	1	2
63	b8d7028a-8478-43eb-96c9-13e6d24185bc	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Omar	Mohamed	MALE	bI5hdJe4U0ihowj	Derek.Macejkovic@gmail.com	3	SUMMER	171	17	29	3.6	0.4	/static/images/avatars/avatar_3.png	1	2
64	3b8e7984-7af1-48dd-8308-00b6605fddfb	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Mohamed	Hussin	MALE	isdyqmbaHR89qJv	Leo8@yahoo.com	5	SUMMER	29	17	96	1.8	3.8	/static/images/avatars/avatar_4.png	1	2
65	4723e569-4505-4614-90ba-b4c0fe9c195b	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Mohamed	Kamal	MALE	4UTiSfSfQrWm3Gr	Jammie.Hilll@hotmail.com	2	SUMMER	102	13	65	3.8	2	/static/images/avatars/avatar_1.png	1	2
66	0da4f479-6eb3-495a-a849-e996ce823096	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Mohamed	Abdelrahman	MALE	qSnB1NAInBeZDjK	Daisha.Farrell@hotmail.com	1	SUMMER	143	19	32	3.6	0	/static/images/avatars/avatar_2.png	1	2
67	bc58423f-8a48-4839-844a-8c47f10e9692	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Sameh	Ali	MALE	l7MVAyFfUmz11hy	Hadley.Abshire@gmail.com	5	SUMMER	131	15	59	2.2	3.6	/static/images/avatars/avatar_2.png	1	2
68	4f53c8d3-639a-4216-9aff-ff3833f74b7d	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Omar	Hosni	MALE	pV5UwOu3FD9tcFe	Alberta_Kunde@yahoo.com	5	SUMMER	116	20	49	1.4	1.2	/static/images/avatars/avatar_2.png	1	2
69	d9638202-424f-4d51-bde8-c586b7944ec8	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Sameh	Ahmed	MALE	BqV1f484D2IQFmP	Ezequiel12@gmail.com	4	SUMMER	74	12	82	1.2	0.6	/static/images/avatars/avatar_1.png	1	2
70	d3952e8a-29d6-42ca-a3c7-49901595a582	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Kamal	Ahmed	MALE	Z9iN2VzJwOnYW1G	Alycia83@gmail.com	1	SUMMER	149	16	99	2.4	3.4	/static/images/avatars/avatar_5.png	1	2
71	3b7c2884-9041-4b4f-a2d1-f6472841cd28	2021-06-03 11:40:26.528	2021-06-03 11:40:26.532	Hosni	Ali	MALE	qG7c0QeNjeHpU3Q	Gail.Rath30@yahoo.com	1	SUMMER	26	14	10	3.8	2	/static/images/avatars/avatar_1.png	1	2
72	3109853f-2f22-48d6-b0c4-086125336b0e	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Mahmoud	Hosni	MALE	CMjizoRxlwbefDa	Kayli50@gmail.com	1	SUMMER	159	14	2	3.4	2.8	/static/images/avatars/avatar_2.png	1	2
73	d42d53c3-211d-4aa4-9a50-8068cd21b83d	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Hosni	Karim	MALE	wi3TNjlOwK_zqHp	Kaden33@hotmail.com	4	SUMMER	171	15	12	1	2.8	/static/images/avatars/avatar_6.png	1	2
74	25583d96-5857-4324-8603-b061c9e74329	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Hussin	Omar	MALE	F8oxtMhZFR_fO0j	Phoebe.Ziemann40@yahoo.com	4	SUMMER	180	14	29	0.8	3.4	/static/images/avatars/avatar_0.png	1	2
75	cff916e4-eb8e-4d0b-8c8f-c3dab26dffe3	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Karim	Mohamed	MALE	zFlcaeGl8h39D6d	Charley.Haley@hotmail.com	1	SUMMER	76	16	10	0.6	2	/static/images/avatars/avatar_3.png	1	2
76	0da0aea6-7766-417d-ba96-e0b61ffc5675	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Mohamed	Mahmoud	MALE	y0uRlTbqaN0nhRk	Sylvan90@gmail.com	4	SUMMER	45	17	60	3.4	0.6	/static/images/avatars/avatar_2.png	1	2
77	187fe305-5ce4-4341-b50d-627aa0c8acd1	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Ali	Hussin	MALE	hAhjhyD5necSiBv	Mazie39@yahoo.com	3	SUMMER	159	19	33	0.2	1.2	/static/images/avatars/avatar_0.png	1	2
78	f007fde0-8955-4f60-a3de-894596fd81dc	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Kamal	Ali	MALE	Ac42XdHytjBTDqZ	Janis.Hartmann@hotmail.com	3	SUMMER	94	18	58	0	3.8	/static/images/avatars/avatar_1.png	1	2
79	35fa83c9-a3f1-40b7-9b59-a08ba1945de9	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Ali	Abdelrahman	MALE	O8T_Klij_c9PnbG	Zella73@yahoo.com	4	SUMMER	157	18	1	0	3	/static/images/avatars/avatar_5.png	1	2
80	70d93752-f4ff-409d-9aa2-093ff5c3994a	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Ahmed	Mahmoud	MALE	Rk12Fq6xsK7ZEfU	Antonina_Dare@yahoo.com	4	SUMMER	45	14	49	3.4	1.2	/static/images/avatars/avatar_1.png	1	2
81	38c5a60a-5939-47c9-9b2d-50dce0c07149	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Mohamed	Mohamed	MALE	H5ipepCVVXPHCWf	Will.Spencer@gmail.com	2	SUMMER	192	18	10	3.8	1.8	/static/images/avatars/avatar_3.png	1	2
82	771224e8-8c04-42c4-9ef3-7a77bb5f3ab9	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Omar	Kamal	MALE	eIFcRPH_c32yJOz	Mona_Bartoletti17@yahoo.com	4	SUMMER	133	14	82	0.4	0.8	/static/images/avatars/avatar_1.png	1	2
83	e6062ca5-ecec-4dd4-8d3c-90e2a1011d49	2021-06-03 11:40:26.529	2021-06-03 11:40:26.532	Hussin	Sameh	MALE	tmpR94LeaHulLwv	Kelton85@gmail.com	1	SUMMER	185	12	62	1.8	3.8	/static/images/avatars/avatar_0.png	1	2
84	5f899e2e-05c3-4131-b202-d021cd906be1	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Mahmoud	Hosni	MALE	T7gymT7craFnWnT	Jaron.Langosh3@hotmail.com	3	SUMMER	111	13	46	1.2	2.2	/static/images/avatars/avatar_6.png	1	2
85	e2fc6c3d-b3f1-4fc7-b358-253a820e716c	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Mohamed	Omar	MALE	5yelY88QioQkyrv	Erling41@yahoo.com	2	SUMMER	29	12	50	3.4	4	/static/images/avatars/avatar_1.png	1	2
86	c3ea0359-60b2-4eec-9b5e-cf6a93fb8b3f	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Hosni	Kamal	MALE	9KoBOftlMurqqtF	Hector_Stiedemann23@gmail.com	4	SUMMER	143	12	8	0	3.6	/static/images/avatars/avatar_3.png	1	2
87	2054a9c3-88d2-4236-81f8-9740991817cf	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Mohamed	Omar	MALE	QTTIOJgLzo9JWXM	Gwendolyn.Frami76@hotmail.com	2	SUMMER	100	13	50	0.8	2.8	/static/images/avatars/avatar_0.png	1	2
88	1c378d66-bc3a-45da-8aad-731c58924daf	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Ahmed	Mahmoud	MALE	DxaLghctmG7MxtD	Ayla_Ortiz@gmail.com	3	SUMMER	158	20	23	1.8	0.8	/static/images/avatars/avatar_5.png	1	2
89	2d4ed065-7f0a-4a8f-8d5c-0f994957ce6c	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Mahmoud	Sameh	MALE	2CxlH20FwXlupEQ	Korey.Bartoletti@yahoo.com	5	SUMMER	180	18	16	3.2	0.6	/static/images/avatars/avatar_5.png	1	2
90	6b9c7408-bc54-4dde-a4f0-7cb01c3bbcfe	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Ali	Mahmoud	MALE	ugM5iE7m8MjZ6jO	Lavon.Aufderhar66@yahoo.com	5	SUMMER	84	20	7	1.4	3.2	/static/images/avatars/avatar_1.png	1	2
91	e973993f-5c41-4661-be6d-b92a9477ca95	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Karim	Ahmed	MALE	pvYOdSgnxEkuG87	Clarissa.Streich@yahoo.com	1	SUMMER	124	16	53	0	2	/static/images/avatars/avatar_1.png	1	2
92	4fa98757-5f7b-4b96-94e9-0b5d82726968	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Kamal	Abdelrahman	MALE	1CFgQZRBolLSx4z	Enoch30@yahoo.com	2	SUMMER	149	20	21	3	0.8	/static/images/avatars/avatar_1.png	1	2
93	583f6257-008f-4359-8d8f-11ce33e07c15	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Sameh	Karim	MALE	wmRmM769dJ2ccvo	Bill29@yahoo.com	3	SUMMER	89	15	4	0.2	0	/static/images/avatars/avatar_5.png	1	2
94	b2ce94fc-b24d-4471-b858-992cab7bf0d3	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Kamal	Kamal	MALE	iND6xFacqvPboPo	Monserrate_Padberg64@gmail.com	5	SUMMER	128	18	45	2	3.6	/static/images/avatars/avatar_6.png	1	2
95	c8110cf8-51ea-425f-a260-0d2c9194e24c	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Karim	Omar	MALE	Jzge3A_c7knibvo	River.Daniel@gmail.com	1	SUMMER	129	20	80	1.4	0	/static/images/avatars/avatar_4.png	1	2
96	97e08138-99d7-4440-8317-88cdaa80ddab	2021-06-03 11:40:26.53	2021-06-03 11:40:26.532	Karim	Hussin	MALE	NisjFee38HbI7Sv	Lavada4@hotmail.com	5	SUMMER	166	19	16	4	3.4	/static/images/avatars/avatar_4.png	1	2
97	297d5a47-3a9f-4deb-ae07-c317678a7629	2021-06-03 11:40:26.531	2021-06-03 11:40:26.532	Kamal	Hosni	MALE	r0yHfQ0DaKQHwet	Amanda.Keebler@gmail.com	5	SUMMER	161	12	87	2.2	2.4	/static/images/avatars/avatar_2.png	1	2
98	06840a4c-77ea-4ab7-b609-025426fe954c	2021-06-03 11:40:26.531	2021-06-03 11:40:26.532	Ali	Sameh	MALE	r13DzUuSRsWkTDc	Lonny_Upton@hotmail.com	5	SUMMER	183	14	3	0	0.4	/static/images/avatars/avatar_0.png	1	2
99	dbe23b0d-629f-415c-8240-014d6ed33885	2021-06-03 11:40:26.531	2021-06-03 11:40:26.532	Omar	Kamal	MALE	8m9lIkc6gbwBg6u	Tyrel_Quitzon@yahoo.com	2	SUMMER	78	19	56	3	3.8	/static/images/avatars/avatar_1.png	1	2
100	efcf32a0-c5ec-4c47-80ae-8aaa7c4717b1	2021-06-03 11:40:26.531	2021-06-03 11:40:26.532	Abdelrahman	Kamal	MALE	bJf2JqOUkLdH_Kk	Willa_Lynch@yahoo.com	3	SUMMER	83	14	24	1.8	2.2	/static/images/avatars/avatar_1.png	1	2
\.


--
-- Data for Name: Supervisor; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public."Supervisor" (id, "createdAt", "updatedAt", fname, lname, gender, password, email, phone, avatar) FROM stdin;
1	2021-06-03 11:40:26.416	2021-06-03 11:40:26.423	Kamal	Hosni	MALE	Uz8Bnc1z_lukcnI	Letha.Feil98@yahoo.com	1-562-367-2198 x7338	/static/images/avatars/avatar_5.png
2	2021-06-03 11:40:26.416	2021-06-03 11:40:26.423	Omar	Mahmoud	MALE	yWlP5_r5HP19Mg9	Bernita_Hoeger10@gmail.com	228.343.8020 x935	/static/images/avatars/avatar_3.png
3	2021-06-03 11:40:26.417	2021-06-03 11:40:26.423	Ali	Mahmoud	MALE	GnsJPwbKU4C1HZX	Gussie_Krajcik@hotmail.com	(562) 515-4408 x513	/static/images/avatars/avatar_2.png
4	2021-06-03 11:40:26.417	2021-06-03 11:40:26.423	Omar	Abdelrahman	MALE	BN4XrsnrQGqp0Vv	Giovani.Hoppe@yahoo.com	1-625-240-1011	/static/images/avatars/avatar_3.png
5	2021-06-03 11:40:26.417	2021-06-03 11:40:26.423	Karim	Hosni	MALE	BZK1LEhGvcPVuMh	Garrison.Crooks@yahoo.com	642.473.8421 x69435	/static/images/avatars/avatar_6.png
6	2021-06-03 11:40:26.417	2021-06-03 11:40:26.423	Karim	Kamal	MALE	Qmo6hpWyGmDZ7os	Imogene49@hotmail.com	493-866-9352 x8776	/static/images/avatars/avatar_3.png
7	2021-06-03 11:40:26.417	2021-06-03 11:40:26.423	Karim	Kamal	MALE	xki0yMIZIL5uGXs	Rae99@hotmail.com	(458) 697-9410	/static/images/avatars/avatar_0.png
8	2021-06-03 11:40:26.417	2021-06-03 11:40:26.423	Hussin	Karim	MALE	VOum9zATM0DOeCo	Darrell89@hotmail.com	1-582-564-4855 x532	/static/images/avatars/avatar_0.png
9	2021-06-03 11:40:26.417	2021-06-03 11:40:26.423	Sameh	Mahmoud	MALE	1SxITNfbfltVZkr	Jess79@gmail.com	1-318-273-2318	/static/images/avatars/avatar_0.png
10	2021-06-03 11:40:26.417	2021-06-03 11:40:26.424	Mahmoud	Karim	MALE	dPt1yk_Uq8TI5K_	Agnes.Jakubowski@yahoo.com	1-872-788-5931	/static/images/avatars/avatar_0.png
11	2021-06-03 11:40:26.417	2021-06-03 11:40:26.424	Kamal	Hosni	MALE	tlk50iBy15DOH0h	Orin10@gmail.com	1-665-218-5960 x3130	/static/images/avatars/avatar_3.png
12	2021-06-03 11:40:26.417	2021-06-03 11:40:26.424	Karim	Hosni	MALE	PGAzP_K5PtXK3XF	Pink_Hagenes71@gmail.com	1-627-987-8514 x46521	/static/images/avatars/avatar_2.png
13	2021-06-03 11:40:26.417	2021-06-03 11:40:26.424	Mahmoud	Karim	MALE	AA0XEoME0LcZKHl	Dashawn_Casper5@yahoo.com	794-211-4097 x4019	/static/images/avatars/avatar_5.png
14	2021-06-03 11:40:26.417	2021-06-03 11:40:26.424	Ahmed	Mohamed	MALE	nBQ8iaCkRoGSTOx	Hank.Predovic5@gmail.com	566-236-5222 x76119	/static/images/avatars/avatar_6.png
15	2021-06-03 11:40:26.417	2021-06-03 11:40:26.424	Abdelrahman	Hosni	MALE	J83v46hkzhGI8Gx	Esta_Steuber@gmail.com	798.698.8863	/static/images/avatars/avatar_1.png
16	2021-06-03 11:40:26.417	2021-06-03 11:40:26.424	Mohamed	Hosni	MALE	Q4H4eL5yg6a0Hpj	Emmanuel6@yahoo.com	504.357.1749	/static/images/avatars/avatar_3.png
17	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Mahmoud	Ahmed	MALE	34b8m1x46eegwCk	Chandler92@gmail.com	(339) 678-2367 x1560	/static/images/avatars/avatar_2.png
18	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Omar	Kamal	MALE	nKnq2FuT8ljbk9v	Kory_Hane78@hotmail.com	380-228-2362 x14146	/static/images/avatars/avatar_5.png
19	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Karim	Omar	MALE	SYfJ1jkRRbC3vgE	Alessandro66@yahoo.com	879-913-3304 x635	/static/images/avatars/avatar_4.png
20	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Ahmed	Sameh	MALE	5fA68bbE2fPCZj4	Hollie.Hauck@gmail.com	547.687.2809 x94508	/static/images/avatars/avatar_2.png
21	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Mahmoud	Abdelrahman	MALE	TFpVNlj_jqfxVj1	Braulio.Yost@gmail.com	(747) 430-3728 x9106	/static/images/avatars/avatar_2.png
22	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Karim	Kamal	MALE	nv0lZYrvtxP4mhV	Georgianna34@hotmail.com	1-934-253-5118 x83512	/static/images/avatars/avatar_2.png
23	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Mahmoud	Abdelrahman	MALE	Igwdt1ogOnvkwMk	Quincy.Pacocha@hotmail.com	1-438-969-2376 x46964	/static/images/avatars/avatar_5.png
24	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Hosni	Mahmoud	MALE	Gmw0Y6ncRTGfrYa	Conner_Beier@yahoo.com	829.535.9269	/static/images/avatars/avatar_5.png
25	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Abdelrahman	Mahmoud	MALE	uk4x8WuezX5eTVD	Alexandria_Windler68@yahoo.com	1-615-739-5647 x15949	/static/images/avatars/avatar_0.png
26	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Kamal	Abdelrahman	MALE	ZTUirGZozq4ibmF	Laura_Bergstrom@yahoo.com	1-324-205-7642	/static/images/avatars/avatar_1.png
27	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Mahmoud	Kamal	MALE	kKilvCcu3dCrAVv	Reed91@hotmail.com	(612) 204-3522 x183	/static/images/avatars/avatar_3.png
28	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Sameh	Hosni	MALE	gZkObCl3Im0a6Tp	Emile22@gmail.com	(940) 401-8976	/static/images/avatars/avatar_0.png
29	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Sameh	Kamal	MALE	yY7oCM4ltu0KdLR	Carlotta.Zulauf43@gmail.com	1-620-269-6543 x0726	/static/images/avatars/avatar_0.png
30	2021-06-03 11:40:26.418	2021-06-03 11:40:26.424	Kamal	Karim	MALE	2JxrhFMAie7X_l7	Kristopher_Wehner62@yahoo.com	247.431.5770 x490	/static/images/avatars/avatar_1.png
31	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Hosni	Mohamed	MALE	poBlVmrkf8vWn6c	Daphne65@hotmail.com	(229) 312-8275 x22595	/static/images/avatars/avatar_5.png
32	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Karim	Sameh	MALE	x3vNFRZoDRHaLMt	Merritt.Moore@hotmail.com	601.623.5716	/static/images/avatars/avatar_4.png
33	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Hussin	Hosni	MALE	UzQywiM_SQ6O2jD	Esther75@gmail.com	(939) 703-2139 x5142	/static/images/avatars/avatar_3.png
34	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Mohamed	Mahmoud	MALE	9zwVRhuKiZRQkRz	Mallie.Klein41@yahoo.com	1-817-334-8480 x5856	/static/images/avatars/avatar_3.png
35	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Abdelrahman	Karim	MALE	IbjEehueIDAi9lD	Rick37@yahoo.com	343-786-1794	/static/images/avatars/avatar_1.png
36	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Omar	Ali	MALE	O_qx3Xp0eEqnIpK	Johanna96@yahoo.com	1-247-400-0601	/static/images/avatars/avatar_5.png
37	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Ali	Abdelrahman	MALE	b0LnMX0tnKbo04F	Kianna_Mueller@yahoo.com	790.623.7304 x839	/static/images/avatars/avatar_5.png
38	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Mohamed	Abdelrahman	MALE	2dUApdlWutZ4oju	Jayde_Becker@yahoo.com	836-561-8695 x06594	/static/images/avatars/avatar_3.png
39	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Hussin	Mohamed	MALE	dshsyXJ8lBhCn0h	Syble_Marquardt2@yahoo.com	220-879-9503 x549	/static/images/avatars/avatar_3.png
40	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Ali	Abdelrahman	MALE	9cDuKzmUtRYEuIO	Russ_Nikolaus78@yahoo.com	1-774-778-5768	/static/images/avatars/avatar_3.png
41	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Karim	Abdelrahman	MALE	V0aLi1nlzTiGkmO	Delphine.Gaylord23@yahoo.com	223-486-4266 x404	/static/images/avatars/avatar_4.png
42	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Hosni	Kamal	MALE	c2yOhVp5pvKHsiF	Laurine19@gmail.com	(970) 690-8163 x5909	/static/images/avatars/avatar_5.png
43	2021-06-03 11:40:26.419	2021-06-03 11:40:26.424	Abdelrahman	Sameh	MALE	x6q78uZFdSLuSGB	Connie_Cummings@gmail.com	(385) 222-8090	/static/images/avatars/avatar_3.png
44	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Omar	Omar	MALE	lyWZceYUNR2cYw8	Roel97@hotmail.com	284-214-1995 x221	/static/images/avatars/avatar_5.png
45	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Sameh	Ali	MALE	FtWb4S2jOePXuz3	Bailee11@yahoo.com	(267) 439-3118 x17005	/static/images/avatars/avatar_0.png
46	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Mohamed	Hussin	MALE	MeImkA22RtXCcNx	Courtney9@gmail.com	1-414-970-8342	/static/images/avatars/avatar_1.png
47	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Hosni	Kamal	MALE	KKG5Y3fiOK8majZ	Blanca79@gmail.com	(842) 754-9710 x0428	/static/images/avatars/avatar_5.png
48	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Ahmed	Hosni	MALE	8VHsy5KIxMx2RKD	Frank.Considine@hotmail.com	(999) 941-8678	/static/images/avatars/avatar_5.png
49	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Karim	Abdelrahman	MALE	6rRXrwG1pWe2Xy9	Winston.Vandervort@gmail.com	910-204-4852	/static/images/avatars/avatar_1.png
50	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Sameh	Karim	MALE	TJSB5Bt0CQXVCx1	Waino_Jaskolski@hotmail.com	790-800-8174 x558	/static/images/avatars/avatar_6.png
51	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Ali	Omar	MALE	wZSrJTwXNTxyCN7	Zackary.Marvin@yahoo.com	559.778.6425 x0620	/static/images/avatars/avatar_0.png
52	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Omar	Ahmed	MALE	RODC7KtxtHgzHI4	Hannah84@yahoo.com	(980) 343-4943	/static/images/avatars/avatar_2.png
53	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Ahmed	Abdelrahman	MALE	Z_rQqepqVczqOez	Rae.Rau63@gmail.com	1-831-928-4466 x991	/static/images/avatars/avatar_6.png
54	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Hosni	Abdelrahman	MALE	0mNwCXDb1_5cWg6	Missouri_Fisher36@hotmail.com	1-654-971-9501	/static/images/avatars/avatar_2.png
55	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Sameh	Omar	MALE	eM9tJZrUe7KDq_e	Walton.Jacobi20@gmail.com	1-385-642-2695	/static/images/avatars/avatar_2.png
56	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Karim	Ali	MALE	wk_KUpsarm2FpO7	Kim.Schoen@yahoo.com	576.387.4615 x0385	/static/images/avatars/avatar_2.png
57	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Ali	Karim	MALE	1qrVKDv_GqOdVCh	Alana5@hotmail.com	1-681-624-9142 x556	/static/images/avatars/avatar_2.png
58	2021-06-03 11:40:26.42	2021-06-03 11:40:26.424	Hussin	Karim	MALE	MgP5P5AY3ubOYa3	Chauncey.Welch36@gmail.com	973.496.3006 x353	/static/images/avatars/avatar_6.png
59	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Ali	Ali	MALE	G8rjEpTJKINEl4b	Arthur.Wilkinson@hotmail.com	(259) 789-3431 x5574	/static/images/avatars/avatar_2.png
60	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Ahmed	Ali	MALE	nC3Q5VTvp9ce2Kz	Harold_Gislason@yahoo.com	864-463-6561	/static/images/avatars/avatar_6.png
61	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Omar	Kamal	MALE	suubkMJrGH6zUvU	Jaylan76@hotmail.com	886-968-0458	/static/images/avatars/avatar_0.png
62	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Hosni	Mahmoud	MALE	XNZxUtjXGvegIHJ	Alexandrea_Parker@hotmail.com	1-537-811-2719	/static/images/avatars/avatar_5.png
63	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Sameh	Ahmed	MALE	DAWR_OD3oJ47XrX	Gideon51@yahoo.com	1-870-310-0431 x755	/static/images/avatars/avatar_5.png
64	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Hussin	Omar	MALE	Db2tv6R7RJfoZ1z	Berniece.Wunsch55@hotmail.com	873-952-9998	/static/images/avatars/avatar_4.png
65	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Hosni	Hosni	MALE	xrBw5qmNLgte5s9	Felipa98@gmail.com	509-233-4311 x080	/static/images/avatars/avatar_6.png
66	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Karim	Karim	MALE	5pzMzttj8gv8enr	Alexys_Bogisich96@hotmail.com	503.412.3047 x26357	/static/images/avatars/avatar_1.png
67	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Mohamed	Sameh	MALE	ZW2tu_1WN8Ay5qx	Ike37@hotmail.com	707-490-8094 x3648	/static/images/avatars/avatar_2.png
68	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Hussin	Mahmoud	MALE	tftSR8AhLYXsalM	Filiberto_Mitchell@yahoo.com	(701) 808-2671 x9622	/static/images/avatars/avatar_2.png
69	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Kamal	Mohamed	MALE	J46xlx8b6CLZr3x	Harold17@gmail.com	1-607-496-2660 x850	/static/images/avatars/avatar_0.png
70	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Abdelrahman	Abdelrahman	MALE	FQSbkc8OWiplvpN	Martin46@gmail.com	(298) 208-8414 x54139	/static/images/avatars/avatar_4.png
71	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Mohamed	Sameh	MALE	37fr2LNhJSPxN_C	Estrella48@yahoo.com	(321) 870-2264	/static/images/avatars/avatar_0.png
72	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Ahmed	Mahmoud	MALE	I5WfD5VJfxxQXSS	Brycen.OReilly72@gmail.com	(347) 523-0347 x21793	/static/images/avatars/avatar_1.png
73	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Kamal	Sameh	MALE	EDkKppQxNidhXai	Dustin_Barton@yahoo.com	730.692.0434 x091	/static/images/avatars/avatar_0.png
74	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Hussin	Hosni	MALE	uN5VXS5JJTCu28p	Mossie_Stamm58@yahoo.com	730-993-1079	/static/images/avatars/avatar_4.png
75	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Abdelrahman	Ali	MALE	CCL5BxiBOqJpGGs	Jovanny_Orn94@gmail.com	1-530-277-7634 x8036	/static/images/avatars/avatar_2.png
76	2021-06-03 11:40:26.421	2021-06-03 11:40:26.424	Karim	Omar	MALE	cAxe7lFIYQMQfaD	Vincenza74@yahoo.com	(904) 628-6796	/static/images/avatars/avatar_4.png
77	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Hussin	Ali	MALE	0B_K67KRjDWS42Z	Ansley_Gorczany82@gmail.com	(842) 508-2849 x9433	/static/images/avatars/avatar_2.png
78	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Ahmed	Hussin	MALE	keoSnzP8D9qTnrc	Zakary4@gmail.com	1-999-213-2022	/static/images/avatars/avatar_1.png
79	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Mohamed	Mohamed	MALE	ivi_wL0qgYlhfpt	Savanah97@gmail.com	236.560.8397	/static/images/avatars/avatar_6.png
80	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Mahmoud	Sameh	MALE	IbbBqyBWC3W9eBv	Dorthy_Goyette@yahoo.com	436-521-1294 x8721	/static/images/avatars/avatar_0.png
81	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Abdelrahman	Omar	MALE	WSidhZk10iLKKES	Marques_Balistreri76@yahoo.com	359-630-8320 x1782	/static/images/avatars/avatar_6.png
82	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Mahmoud	Ali	MALE	g9iMd8JcVi91_yx	Micaela96@gmail.com	(344) 735-8066	/static/images/avatars/avatar_4.png
83	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Hosni	Abdelrahman	MALE	vCdE_YWRvenVrRg	Winifred_Goyette@yahoo.com	1-865-873-3583	/static/images/avatars/avatar_4.png
84	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Sameh	Kamal	MALE	hNhFrCY1Gfb35BV	Mandy77@yahoo.com	(393) 676-3405 x723	/static/images/avatars/avatar_2.png
85	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Abdelrahman	Mahmoud	MALE	SShMP7jMyi1V2Fy	Glennie_Collins@hotmail.com	(501) 507-9373 x1977	/static/images/avatars/avatar_6.png
86	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Omar	Hussin	MALE	lzloPuAFZVFImqz	Harold_Cormier27@hotmail.com	869-469-2220	/static/images/avatars/avatar_3.png
87	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Ali	Sameh	MALE	HrHdQEiEt01QZFr	Izaiah_Wintheiser@gmail.com	952.362.5497 x63655	/static/images/avatars/avatar_5.png
88	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Ali	Mahmoud	MALE	84s3QLheadqTIGY	Ryleigh.Torphy@yahoo.com	1-833-981-5108	/static/images/avatars/avatar_0.png
89	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Hussin	Ahmed	MALE	CnFwWk2MGcFPTEY	Cruz62@hotmail.com	870.671.2594 x340	/static/images/avatars/avatar_0.png
90	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Hussin	Sameh	MALE	SVUqQJvq1IVB3mA	Bella_Conroy39@gmail.com	(257) 650-8287 x4832	/static/images/avatars/avatar_1.png
91	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Hussin	Sameh	MALE	LbH6A0vIEDWJRZs	Keith_Quitzon28@yahoo.com	(395) 401-4352	/static/images/avatars/avatar_5.png
92	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Hussin	Omar	MALE	aqF0oAbLN7Am2BI	Ursula35@gmail.com	397.385.9181 x330	/static/images/avatars/avatar_4.png
93	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Omar	Hussin	MALE	mNXugblcLepGkzS	Tristian_Bergnaum71@yahoo.com	644-278-3586	/static/images/avatars/avatar_5.png
94	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Ali	Hussin	MALE	_PXFyk3XX0oNWN9	Bradford.Marquardt@hotmail.com	(794) 318-1211	/static/images/avatars/avatar_1.png
95	2021-06-03 11:40:26.422	2021-06-03 11:40:26.424	Sameh	Karim	MALE	oo_tuAuvcd0doQM	Bryana.Howell@hotmail.com	1-797-912-8767	/static/images/avatars/avatar_3.png
96	2021-06-03 11:40:26.423	2021-06-03 11:40:26.424	Kamal	Sameh	MALE	9yXPCOB72ruAH0f	Ila.Turner13@hotmail.com	(535) 587-0179	/static/images/avatars/avatar_2.png
97	2021-06-03 11:40:26.423	2021-06-03 11:40:26.424	Kamal	Kamal	MALE	mlv8sKSIWt4WB_H	Garland.Mraz94@yahoo.com	458-454-1501	/static/images/avatars/avatar_6.png
98	2021-06-03 11:40:26.423	2021-06-03 11:40:26.424	Ali	Ahmed	MALE	LKq0x9EB2OLtzpx	Alta14@yahoo.com	1-434-713-5262 x3872	/static/images/avatars/avatar_4.png
99	2021-06-03 11:40:26.423	2021-06-03 11:40:26.424	Mohamed	Hussin	MALE	_7QEFDaUGjDPzys	Cornelius_Jerde@gmail.com	1-997-817-3421 x169	/static/images/avatars/avatar_4.png
100	2021-06-03 11:40:26.423	2021-06-03 11:40:26.424	Omar	Kamal	MALE	aUvTisH5WL0k3jr	Ernie4@yahoo.com	305-367-9226 x2318	/static/images/avatars/avatar_3.png
\.


--
-- Data for Name: _CoursePrerequisites; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public."_CoursePrerequisites" ("A", "B") FROM stdin;
6	2
7	2
6	23
7	23
6	27
7	27
6	20
7	20
6	36
7	36
6	31
7	31
6	42
7	42
6	44
7	44
6	41
7	41
6	50
7	50
6	47
7	47
6	67
7	67
6	60
7	60
6	84
7	84
6	89
7	89
6	57
7	57
6	93
7	93
6	105
7	105
6	131
7	131
6	120
7	120
6	141
7	141
6	129
7	129
6	134
6	135
7	134
7	135
6	110
7	110
6	147
7	147
6	145
7	145
6	142
7	142
6	178
7	178
6	166
7	166
6	156
7	156
6	171
7	171
6	162
6	179
6	174
6	192
7	162
7	174
6	181
7	181
7	179
7	192
6	154
7	154
6	5
7	5
6	195
7	195
2	32
5	32
2	11
2	37
5	37
5	11
2	51
5	51
2	102
2	1
5	102
5	1
2	126
5	126
2	150
2	111
5	111
5	150
2	98
5	98
2	138
5	138
2	59
5	59
2	158
5	158
2	132
5	132
2	39
5	39
2	163
5	163
2	101
5	101
2	55
5	55
2	103
5	103
2	34
5	34
2	155
5	155
2	16
5	16
2	146
2	196
5	196
5	146
2	173
5	173
2	3
5	3
2	122
5	122
2	87
5	87
2	200
5	200
2	182
5	182
1	4
1	30
1	43
3	4
3	30
3	43
1	25
3	25
1	48
3	48
1	15
3	15
1	54
3	54
1	69
3	69
1	94
3	94
1	61
3	61
1	76
1	104
3	76
3	104
1	116
3	116
1	125
3	125
1	137
1	79
3	137
3	79
1	157
3	157
1	185
3	185
1	40
1	169
1	191
3	40
1	164
3	169
3	191
3	164
1	198
3	198
1	153
3	153
1	58
3	58
1	26
3	26
1	161
3	161
1	18
3	18
1	130
3	130
1	118
3	118
1	75
3	75
1	53
3	53
1	63
3	63
1	78
3	78
1	46
3	46
1	10
3	10
1	81
3	81
1	97
1	112
1	187
3	97
3	112
3	187
1	194
3	194
1	176
3	176
1	168
3	168
4	33
10	33
4	165
10	165
4	149
10	149
4	70
10	70
4	197
10	197
4	193
10	193
4	22
10	22
4	107
10	107
4	12
10	12
4	49
10	49
4	74
10	74
4	72
10	72
4	143
10	143
4	77
10	77
4	66
10	66
4	119
10	119
4	86
10	86
4	56
10	56
4	188
10	188
4	19
10	19
4	65
10	65
4	159
10	159
4	28
10	28
4	128
10	128
4	106
10	106
4	160
10	160
4	151
10	151
4	152
10	152
4	139
10	139
4	62
10	62
4	127
10	127
4	121
10	121
4	117
10	117
4	82
10	82
4	177
10	177
4	167
10	167
4	172
10	172
4	114
10	114
4	100
10	100
4	148
10	148
4	71
10	71
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: abosamra
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
102c4b44-142a-40cf-907f-8b6d2de35497	039872cf54c0651259532e26484c72f1db89bdf9480d9380f238f17496575658	2021-06-03 13:40:22.64951+02	20210529130750_fixnotifications	\N	\N	2021-06-03 13:40:22.562481+02	1
20c986b5-8c29-445a-adc4-bc8e659099c8	5d0a1dbe3c7f8dee91c412286bad3a0a434fab62f6e3571f2b6b96f5bb0671e1	2021-06-03 13:40:21.139355+02	20210415233134_init	\N	\N	2021-06-03 13:40:20.872572+02	1
465ba4cd-f39c-4fb7-9fbd-dfe16510ffa9	4a31511c4dc25ac8d32f234b454ac08b9c2dbe75cb5fd23c99a8c3cbd34f6b39	2021-06-03 13:40:21.665287+02	20210418005159_first	\N	\N	2021-06-03 13:40:21.158754+02	1
eb3ea551-d4d0-4ed8-870b-4b116f4575e0	adb9e45c3fb68efc83ab56ec3fd2958c99accbb416ec196df5158a2606d47ed8	2021-06-03 13:40:21.715394+02	20210418024452_second	\N	\N	2021-06-03 13:40:21.689126+02	1
165b4990-93d6-49ca-9eb1-04ba8858316f	ab94903ba2bbb1671e930f6f98a29652621f9cdb8d1f89d81236934674430359	2021-06-03 13:40:22.783065+02	20210601084916_add_major	\N	\N	2021-06-03 13:40:22.667277+02	1
d2515edd-d5be-40e8-87fa-802a4d2c39af	f94dbd675f3fe87ddb40688c50b4f4273c3d434251f63b8d928b79bf39d843c5	2021-06-03 13:40:21.798678+02	20210503052956_add_gpa	\N	\N	2021-06-03 13:40:21.741026+02	1
9346764d-0cfa-49fb-8354-a2cd5b73723c	6073ce0556e320dbcd27ad751d2ed5e50838cfd1ee9ffdbd37d378c1fbd6dcd2	2021-06-03 13:40:21.83202+02	20210503053431_add_mis	\N	\N	2021-06-03 13:40:21.807343+02	1
ac2113b1-eb1b-40ea-be07-0fdf43049074	cb720737207a1084b8acd3df87de5d952c5fd43857622e8694cdbcaa9fba7fac	2021-06-03 13:40:21.882012+02	20210503055655_add_level	\N	\N	2021-06-03 13:40:21.848531+02	1
6812d870-43df-405f-bd2b-bae28cc5d7a6	ac3e1dd7c3758b7e80b2955f3aeb76630bd57b9e369d46c3845f353de6d1e9c4	2021-06-03 13:40:22.032186+02	20210503055802_addgpafloat	\N	\N	2021-06-03 13:40:21.900343+02	1
1c016068-b3d3-45b5-af2b-7a5f8ecf51ef	5f385757cf338bbfe98374eff6fd2e9903f1524c2c05d4943b045ad21ec6c45a	2021-06-03 13:40:22.132332+02	20210504025726_addfinishedcourses	\N	\N	2021-06-03 13:40:22.053914+02	1
59412a77-5d34-4183-af6e-6297aa09938c	0ba7aaa4b4b9f2a058450247ba6119b2a9e6dfa0c9efd0bcb1fd7330de768b82	2021-06-03 13:40:22.182332+02	20210504231028_adddefaultpassword	\N	\N	2021-06-03 13:40:22.153086+02	1
99642ee4-5460-4f17-af0e-4f225e9a87fc	64cc4b3ebfc65c9205acc03da7a662c88f68f9fed1d6bf46aa5265135d7fb651	2021-06-03 13:40:22.240697+02	20210505031559_optionalpassword	\N	\N	2021-06-03 13:40:22.210447+02	1
a49a74bf-5c7f-4a84-939f-2c638bd13067	61c609d51929becff204aa98543acf8e055023d8f3529d8be30bd2d1b723730a	2021-06-03 13:40:22.324003+02	20210511163132_coursecodeunique	\N	\N	2021-06-03 13:40:22.265331+02	1
8221915d-a233-4bdb-b0c0-9f076fd5fa60	b1830e1f9afb69ea7a61d8dd4af8ce3a587c0a12cdde7608254677f9e9439434	2021-06-03 13:40:22.432462+02	20210520032319_idforfinishedcourses	\N	\N	2021-06-03 13:40:22.352621+02	1
156c06b8-ed56-468d-a114-922b63403733	5d3783e2256b0dcf3969151bb11a6261311ad21b272d95e54936d55520f7bc02	2021-06-03 13:40:22.541012+02	20210529121638_addnotifications	\N	\N	2021-06-03 13:40:22.456831+02	1
\.


--
-- Name: Course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abosamra
--

SELECT pg_catalog.setval('public."Course_id_seq"', 200, true);


--
-- Name: Enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abosamra
--

SELECT pg_catalog.setval('public."Enrollment_id_seq"', 1, false);


--
-- Name: FinishedCourses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abosamra
--

SELECT pg_catalog.setval('public."FinishedCourses_id_seq"', 200, true);


--
-- Name: Major_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abosamra
--

SELECT pg_catalog.setval('public."Major_id_seq"', 2, true);


--
-- Name: Notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abosamra
--

SELECT pg_catalog.setval('public."Notifications_id_seq"', 1, false);


--
-- Name: Student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abosamra
--

SELECT pg_catalog.setval('public."Student_id_seq"', 100, true);


--
-- Name: Supervisor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abosamra
--

SELECT pg_catalog.setval('public."Supervisor_id_seq"', 100, true);


--
-- Name: Course Course_pkey; Type: CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_pkey" PRIMARY KEY (id);


--
-- Name: Enrollment Enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Enrollment"
    ADD CONSTRAINT "Enrollment_pkey" PRIMARY KEY (id);


--
-- Name: FinishedCourses FinishedCourses_pkey; Type: CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."FinishedCourses"
    ADD CONSTRAINT "FinishedCourses_pkey" PRIMARY KEY (id);


--
-- Name: Major Major_pkey; Type: CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Major"
    ADD CONSTRAINT "Major_pkey" PRIMARY KEY (id);


--
-- Name: Notifications Notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Notifications"
    ADD CONSTRAINT "Notifications_pkey" PRIMARY KEY (id);


--
-- Name: Student Student_pkey; Type: CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (id);


--
-- Name: Supervisor Supervisor_pkey; Type: CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Supervisor"
    ADD CONSTRAINT "Supervisor_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Major.code_unique; Type: INDEX; Schema: public; Owner: abosamra
--

CREATE UNIQUE INDEX "Major.code_unique" ON public."Major" USING btree (code);


--
-- Name: Student.email_unique; Type: INDEX; Schema: public; Owner: abosamra
--

CREATE UNIQUE INDEX "Student.email_unique" ON public."Student" USING btree (email);


--
-- Name: Student.uniCode_unique; Type: INDEX; Schema: public; Owner: abosamra
--

CREATE UNIQUE INDEX "Student.uniCode_unique" ON public."Student" USING btree ("uniCode");


--
-- Name: Supervisor.email_unique; Type: INDEX; Schema: public; Owner: abosamra
--

CREATE UNIQUE INDEX "Supervisor.email_unique" ON public."Supervisor" USING btree (email);


--
-- Name: _CoursePrerequisites_AB_unique; Type: INDEX; Schema: public; Owner: abosamra
--

CREATE UNIQUE INDEX "_CoursePrerequisites_AB_unique" ON public."_CoursePrerequisites" USING btree ("A", "B");


--
-- Name: _CoursePrerequisites_B_index; Type: INDEX; Schema: public; Owner: abosamra
--

CREATE INDEX "_CoursePrerequisites_B_index" ON public."_CoursePrerequisites" USING btree ("B");


--
-- Name: Course Course_majorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_majorId_fkey" FOREIGN KEY ("majorId") REFERENCES public."Major"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Course Course_minorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_minorId_fkey" FOREIGN KEY ("minorId") REFERENCES public."Major"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Enrollment Enrollment_courseID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Enrollment"
    ADD CONSTRAINT "Enrollment_courseID_fkey" FOREIGN KEY ("courseID") REFERENCES public."Course"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Enrollment Enrollment_studentID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Enrollment"
    ADD CONSTRAINT "Enrollment_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Enrollment Enrollment_supervisorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Enrollment"
    ADD CONSTRAINT "Enrollment_supervisorId_fkey" FOREIGN KEY ("supervisorId") REFERENCES public."Supervisor"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: FinishedCourses FinishedCourses_courseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."FinishedCourses"
    ADD CONSTRAINT "FinishedCourses_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES public."Course"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FinishedCourses FinishedCourses_studentID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."FinishedCourses"
    ADD CONSTRAINT "FinishedCourses_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notifications Notifications_studentID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Notifications"
    ADD CONSTRAINT "Notifications_studentID_fkey" FOREIGN KEY ("studentID") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Notifications Notifications_supervisorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Notifications"
    ADD CONSTRAINT "Notifications_supervisorId_fkey" FOREIGN KEY ("supervisorId") REFERENCES public."Supervisor"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Student Student_majorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_majorId_fkey" FOREIGN KEY ("majorId") REFERENCES public."Major"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Student Student_minorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_minorId_fkey" FOREIGN KEY ("minorId") REFERENCES public."Major"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Student Student_supervisorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_supervisorId_fkey" FOREIGN KEY ("supervisorId") REFERENCES public."Supervisor"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: _CoursePrerequisites _CoursePrerequisites_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."_CoursePrerequisites"
    ADD CONSTRAINT "_CoursePrerequisites_A_fkey" FOREIGN KEY ("A") REFERENCES public."Course"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CoursePrerequisites _CoursePrerequisites_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abosamra
--

ALTER TABLE ONLY public."_CoursePrerequisites"
    ADD CONSTRAINT "_CoursePrerequisites_B_fkey" FOREIGN KEY ("B") REFERENCES public."Course"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

