--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3 (Debian 10.3-1.pgdg90+1)
-- Dumped by pg_dump version 11.5

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
-- Name: sql_load_test; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sql_load_test;


ALTER SCHEMA sql_load_test OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Comment; Type: TABLE; Schema: sql_load_test; Owner: postgres
--

CREATE TABLE sql_load_test."Comment" (
    content text,
    id integer NOT NULL,
    author integer,
    post integer,
    "createdAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE sql_load_test."Comment" OWNER TO postgres;

--
-- Name: Comment_id_seq; Type: SEQUENCE; Schema: sql_load_test; Owner: postgres
--

CREATE SEQUENCE sql_load_test."Comment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sql_load_test."Comment_id_seq" OWNER TO postgres;

--
-- Name: Comment_id_seq; Type: SEQUENCE OWNED BY; Schema: sql_load_test; Owner: postgres
--

ALTER SEQUENCE sql_load_test."Comment_id_seq" OWNED BY sql_load_test."Comment".id;


--
-- Name: Group; Type: TABLE; Schema: sql_load_test; Owner: postgres
--

CREATE TABLE sql_load_test."Group" (
    description text,
    id integer NOT NULL,
    topic text DEFAULT ''::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE sql_load_test."Group" OWNER TO postgres;

--
-- Name: Group_id_seq; Type: SEQUENCE; Schema: sql_load_test; Owner: postgres
--

CREATE SEQUENCE sql_load_test."Group_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sql_load_test."Group_id_seq" OWNER TO postgres;

--
-- Name: Group_id_seq; Type: SEQUENCE OWNED BY; Schema: sql_load_test; Owner: postgres
--

ALTER SEQUENCE sql_load_test."Group_id_seq" OWNED BY sql_load_test."Group".id;


--
-- Name: Like; Type: TABLE; Schema: sql_load_test; Owner: postgres
--

CREATE TABLE sql_load_test."Like" (
    id integer NOT NULL,
    comment integer,
    post integer,
    "user" integer,
    "createdAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE sql_load_test."Like" OWNER TO postgres;

--
-- Name: Like_id_seq; Type: SEQUENCE; Schema: sql_load_test; Owner: postgres
--

CREATE SEQUENCE sql_load_test."Like_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sql_load_test."Like_id_seq" OWNER TO postgres;

--
-- Name: Like_id_seq; Type: SEQUENCE OWNED BY; Schema: sql_load_test; Owner: postgres
--

ALTER SEQUENCE sql_load_test."Like_id_seq" OWNED BY sql_load_test."Like".id;


--
-- Name: Post; Type: TABLE; Schema: sql_load_test; Owner: postgres
--

CREATE TABLE sql_load_test."Post" (
    content text,
    "createdAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    id integer NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    author integer
);


ALTER TABLE sql_load_test."Post" OWNER TO postgres;

--
-- Name: Post_id_seq; Type: SEQUENCE; Schema: sql_load_test; Owner: postgres
--

CREATE SEQUENCE sql_load_test."Post_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sql_load_test."Post_id_seq" OWNER TO postgres;

--
-- Name: Post_id_seq; Type: SEQUENCE OWNED BY; Schema: sql_load_test; Owner: postgres
--

ALTER SEQUENCE sql_load_test."Post_id_seq" OWNED BY sql_load_test."Post".id;


--
-- Name: User; Type: TABLE; Schema: sql_load_test; Owner: postgres
--

CREATE TABLE sql_load_test."User" (
    age integer,
    "createdAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    email text,
    "firstName" text DEFAULT ''::text NOT NULL,
    id integer NOT NULL,
    "lastName" text DEFAULT ''::text NOT NULL,
    password text,
    "updatedAt" timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE sql_load_test."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: sql_load_test; Owner: postgres
--

CREATE SEQUENCE sql_load_test."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sql_load_test."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: sql_load_test; Owner: postgres
--

ALTER SEQUENCE sql_load_test."User_id_seq" OWNED BY sql_load_test."User".id;


--
-- Name: _FriendShip; Type: TABLE; Schema: sql_load_test; Owner: postgres
--

CREATE TABLE sql_load_test."_FriendShip" (
    "A" integer,
    "B" integer
);


ALTER TABLE sql_load_test."_FriendShip" OWNER TO postgres;

--
-- Name: _GroupToUser; Type: TABLE; Schema: sql_load_test; Owner: postgres
--

CREATE TABLE sql_load_test."_GroupToUser" (
    "A" integer,
    "B" integer
);


ALTER TABLE sql_load_test."_GroupToUser" OWNER TO postgres;

--
-- Name: _Migration; Type: TABLE; Schema: sql_load_test; Owner: postgres
--

CREATE TABLE sql_load_test."_Migration" (
    revision integer NOT NULL,
    name text NOT NULL,
    datamodel text NOT NULL,
    status text NOT NULL,
    applied integer NOT NULL,
    rolled_back integer NOT NULL,
    datamodel_steps text NOT NULL,
    database_migration text NOT NULL,
    errors text NOT NULL,
    started_at timestamp(3) without time zone NOT NULL,
    finished_at timestamp(3) without time zone
);


ALTER TABLE sql_load_test."_Migration" OWNER TO postgres;

--
-- Name: _Migration_revision_seq; Type: SEQUENCE; Schema: sql_load_test; Owner: postgres
--

CREATE SEQUENCE sql_load_test."_Migration_revision_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sql_load_test."_Migration_revision_seq" OWNER TO postgres;

--
-- Name: _Migration_revision_seq; Type: SEQUENCE OWNED BY; Schema: sql_load_test; Owner: postgres
--

ALTER SEQUENCE sql_load_test."_Migration_revision_seq" OWNED BY sql_load_test."_Migration".revision;


--
-- Name: Comment id; Type: DEFAULT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Comment" ALTER COLUMN id SET DEFAULT nextval('sql_load_test."Comment_id_seq"'::regclass);


--
-- Name: Group id; Type: DEFAULT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Group" ALTER COLUMN id SET DEFAULT nextval('sql_load_test."Group_id_seq"'::regclass);


--
-- Name: Like id; Type: DEFAULT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Like" ALTER COLUMN id SET DEFAULT nextval('sql_load_test."Like_id_seq"'::regclass);


--
-- Name: Post id; Type: DEFAULT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Post" ALTER COLUMN id SET DEFAULT nextval('sql_load_test."Post_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."User" ALTER COLUMN id SET DEFAULT nextval('sql_load_test."User_id_seq"'::regclass);


--
-- Name: _Migration revision; Type: DEFAULT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."_Migration" ALTER COLUMN revision SET DEFAULT nextval('sql_load_test."_Migration_revision_seq"'::regclass);


--
-- Data for Name: Comment; Type: TABLE DATA; Schema: sql_load_test; Owner: postgres
--

COPY sql_load_test."Comment" (content, id, author, post, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Group; Type: TABLE DATA; Schema: sql_load_test; Owner: postgres
--

COPY sql_load_test."Group" (description, id, topic, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Like; Type: TABLE DATA; Schema: sql_load_test; Owner: postgres
--

COPY sql_load_test."Like" (id, comment, post, "user", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Post; Type: TABLE DATA; Schema: sql_load_test; Owner: postgres
--

COPY sql_load_test."Post" (content, "createdAt", id, "updatedAt", author) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: sql_load_test; Owner: postgres
--

COPY sql_load_test."User" (age, "createdAt", email, "firstName", id, "lastName", password, "updatedAt") FROM stdin;
\.


--
-- Data for Name: _FriendShip; Type: TABLE DATA; Schema: sql_load_test; Owner: postgres
--

COPY sql_load_test."_FriendShip" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _GroupToUser; Type: TABLE DATA; Schema: sql_load_test; Owner: postgres
--

COPY sql_load_test."_GroupToUser" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _Migration; Type: TABLE DATA; Schema: sql_load_test; Owner: postgres
--

COPY sql_load_test."_Migration" (revision, name, datamodel, status, applied, rolled_back, datamodel_steps, database_migration, errors, started_at, finished_at) FROM stdin;
1	20191023130149-init	model User {\n  id         Int       @id @unique\n  firstName  String\n  lastName   String\n  age        Int?\n  email      String?\n  password   String?\n  posts      Post[]\n  comments   Comment[]\n  likes      Like[]\n  friendWith User[]    @relation("FriendShip")\n  friendOf   User[]    @relation("FriendShip")\n  groups     Group[]\n  createdAt  DateTime  @default(now())\n  updatedAt  DateTime\n}\n\nmodel Post {\n  id        Int       @id @unique\n  content   String?\n  author    User\n  comments  Comment[]\n  likes     Like[]\n  createdAt DateTime  @default(now())\n  updatedAt DateTime\n}\n\nmodel Comment {\n  id      Int     @id @unique\n  content String?\n  author  User\n  post    Post\n  likes   Like[]\n}\n\nmodel Like {\n  id      Int     @id @unique\n  user    User\n  post    Post\n  comment Comment\n}\n\nmodel Group {\n  id          Int     @id @unique\n  topic       String\n  description String?\n  members     User[]\n}	MigrationSuccess	16	0	[{"stepType":"CreateModel","name":"User","embedded":false},{"stepType":"CreateModel","name":"Post","embedded":false},{"stepType":"CreateModel","name":"Comment","embedded":false},{"stepType":"CreateModel","name":"Like","embedded":false},{"stepType":"CreateModel","name":"Group","embedded":false},{"stepType":"CreateField","model":"User","name":"id","type":{"Base":"Int"},"arity":"required","isUnique":true,"id":{"strategy":"Auto","sequence":null}},{"stepType":"CreateField","model":"User","name":"firstName","type":{"Base":"String"},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"User","name":"lastName","type":{"Base":"String"},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"User","name":"age","type":{"Base":"Int"},"arity":"optional","isUnique":false},{"stepType":"CreateField","model":"User","name":"email","type":{"Base":"String"},"arity":"optional","isUnique":false},{"stepType":"CreateField","model":"User","name":"password","type":{"Base":"String"},"arity":"optional","isUnique":false},{"stepType":"CreateField","model":"User","name":"posts","type":{"Relation":{"to":"Post","to_fields":[],"name":"PostToUser","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"User","name":"comments","type":{"Relation":{"to":"Comment","to_fields":[],"name":"CommentToUser","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"User","name":"likes","type":{"Relation":{"to":"Like","to_fields":[],"name":"LikeToUser","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"User","name":"friendWith","type":{"Relation":{"to":"User","to_fields":["id"],"name":"FriendShip","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"User","name":"friendOf","type":{"Relation":{"to":"User","to_fields":["id"],"name":"FriendShip","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"User","name":"groups","type":{"Relation":{"to":"Group","to_fields":["id"],"name":"GroupToUser","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"User","name":"createdAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false,"default":{"Expression":["now","DateTime",[]]}},{"stepType":"CreateField","model":"User","name":"updatedAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Post","name":"id","type":{"Base":"Int"},"arity":"required","isUnique":true,"id":{"strategy":"Auto","sequence":null}},{"stepType":"CreateField","model":"Post","name":"content","type":{"Base":"String"},"arity":"optional","isUnique":false},{"stepType":"CreateField","model":"Post","name":"author","type":{"Relation":{"to":"User","to_fields":["id"],"name":"PostToUser","on_delete":"None"}},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Post","name":"comments","type":{"Relation":{"to":"Comment","to_fields":[],"name":"CommentToPost","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"Post","name":"likes","type":{"Relation":{"to":"Like","to_fields":[],"name":"LikeToPost","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"Post","name":"createdAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false,"default":{"Expression":["now","DateTime",[]]}},{"stepType":"CreateField","model":"Post","name":"updatedAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Comment","name":"id","type":{"Base":"Int"},"arity":"required","isUnique":true,"id":{"strategy":"Auto","sequence":null}},{"stepType":"CreateField","model":"Comment","name":"content","type":{"Base":"String"},"arity":"optional","isUnique":false},{"stepType":"CreateField","model":"Comment","name":"author","type":{"Relation":{"to":"User","to_fields":["id"],"name":"CommentToUser","on_delete":"None"}},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Comment","name":"post","type":{"Relation":{"to":"Post","to_fields":["id"],"name":"CommentToPost","on_delete":"None"}},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Comment","name":"likes","type":{"Relation":{"to":"Like","to_fields":[],"name":"CommentToLike","on_delete":"None"}},"arity":"list","isUnique":false},{"stepType":"CreateField","model":"Like","name":"id","type":{"Base":"Int"},"arity":"required","isUnique":true,"id":{"strategy":"Auto","sequence":null}},{"stepType":"CreateField","model":"Like","name":"user","type":{"Relation":{"to":"User","to_fields":["id"],"name":"LikeToUser","on_delete":"None"}},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Like","name":"post","type":{"Relation":{"to":"Post","to_fields":["id"],"name":"LikeToPost","on_delete":"None"}},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Like","name":"comment","type":{"Relation":{"to":"Comment","to_fields":["id"],"name":"CommentToLike","on_delete":"None"}},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Group","name":"id","type":{"Base":"Int"},"arity":"required","isUnique":true,"id":{"strategy":"Auto","sequence":null}},{"stepType":"CreateField","model":"Group","name":"topic","type":{"Base":"String"},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Group","name":"description","type":{"Base":"String"},"arity":"optional","isUnique":false},{"stepType":"CreateField","model":"Group","name":"members","type":{"Relation":{"to":"User","to_fields":["id"],"name":"GroupToUser","on_delete":"None"}},"arity":"list","isUnique":false}]	{"before":{"tables":[{"name":"_Migration","columns":[{"name":"applied","tpe":{"raw":"int4","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"database_migration","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"datamodel","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"datamodel_steps","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"errors","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"finished_at","tpe":{"raw":"timestamp","family":"dateTime"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"name","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"revision","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"_Migration_revision_seq\\"'::regclass)","autoIncrement":false},{"name":"rolled_back","tpe":{"raw":"int4","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"started_at","tpe":{"raw":"timestamp","family":"dateTime"},"arity":"required","default":null,"autoIncrement":false},{"name":"status","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false}],"indices":[],"primaryKey":{"columns":["revision"],"sequence":{"name":"_Migration_revision_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[]}],"enums":[],"sequences":[{"name":"_Migration_revision_seq","initialValue":1,"allocationSize":1}]},"after":{"tables":[{"name":"User","columns":[{"name":"age","tpe":{"raw":"","family":"int"},"arity":"nullable","default":"0","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"email","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"firstName","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"lastName","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"password","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"User.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]},{"name":"Post","columns":[{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Post.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"Comment","columns":[{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"Like","columns":[{"name":"comment","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"user","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"Group","columns":[{"name":"description","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"topic","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false}],"indices":[{"name":"Group.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]},{"name":"_FriendShip","columns":[{"name":"A","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"_FriendShip_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":null,"columns":["A"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":null,"columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]},{"name":"_GroupToUser","columns":[{"name":"A","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"_GroupToUser_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":null,"columns":["A"],"referencedTable":"Group","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":null,"columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]}],"enums":[],"sequences":[]},"original_steps":[{"CreateTable":{"table":{"name":"User","columns":[{"name":"age","tpe":{"raw":"","family":"int"},"arity":"nullable","default":"0","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"email","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"firstName","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"lastName","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"password","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"User.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]}}},{"CreateTable":{"table":{"name":"Post","columns":[{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Post.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"}]}}},{"CreateTable":{"table":{"name":"Comment","columns":[{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]}}},{"CreateTable":{"table":{"name":"Like","columns":[{"name":"comment","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"user","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"}]}}},{"CreateTable":{"table":{"name":"Group","columns":[{"name":"description","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"topic","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false}],"indices":[{"name":"Group.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]}}},{"CreateTable":{"table":{"name":"_FriendShip","columns":[{"name":"A","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"_FriendShip_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":null,"columns":["A"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":null,"columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]}}},{"CreateTable":{"table":{"name":"_GroupToUser","columns":[{"name":"A","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"_GroupToUser_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":null,"columns":["A"],"referencedTable":"Group","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":null,"columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]}}},{"CreateIndex":{"table":"User","index":{"name":"User.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"Post","index":{"name":"Post.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"Comment","index":{"name":"Comment.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"Like","index":{"name":"Like.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"Group","index":{"name":"Group.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"_FriendShip","index":{"name":"_FriendShip_AB_unique","columns":["A","B"],"tpe":"unique"}}},{"CreateIndex":{"table":"_GroupToUser","index":{"name":"_GroupToUser_AB_unique","columns":["A","B"],"tpe":"unique"}}}],"corrected_steps":[{"CreateTable":{"table":{"name":"User","columns":[{"name":"age","tpe":{"raw":"","family":"int"},"arity":"nullable","default":"0","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"email","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"firstName","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"lastName","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"password","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"User.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]}}},{"CreateTable":{"table":{"name":"Post","columns":[{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Post.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"}]}}},{"CreateTable":{"table":{"name":"Comment","columns":[{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]}}},{"CreateTable":{"table":{"name":"Like","columns":[{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"}]}}},{"CreateTable":{"table":{"name":"Group","columns":[{"name":"description","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"topic","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false}],"indices":[{"name":"Group.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]}}},{"CreateTable":{"table":{"name":"_FriendShip","columns":[{"name":"A","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"_FriendShip_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":null,"columns":["A"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":null,"columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]}}},{"CreateTable":{"table":{"name":"_GroupToUser","columns":[{"name":"A","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"_GroupToUser_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":null,"columns":["A"],"referencedTable":"Group","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":null,"columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]}}},{"AlterTable":{"table":{"name":"Post","columns":[{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Post.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"AddColumn":{"column":{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}}}]}},{"AlterTable":{"table":{"name":"Comment","columns":[{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"AddColumn":{"column":{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}}},{"AddColumn":{"column":{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}}}]}},{"AlterTable":{"table":{"name":"Like","columns":[{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"AddColumn":{"column":{"name":"comment","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}}},{"AddColumn":{"column":{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}}},{"AddColumn":{"column":{"name":"user","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}}}]}},{"CreateIndex":{"table":"User","index":{"name":"User.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"Post","index":{"name":"Post.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"Comment","index":{"name":"Comment.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"Like","index":{"name":"Like.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"Group","index":{"name":"Group.id","columns":["id"],"tpe":"unique"}}},{"CreateIndex":{"table":"_FriendShip","index":{"name":"_FriendShip_AB_unique","columns":["A","B"],"tpe":"unique"}}},{"CreateIndex":{"table":"_GroupToUser","index":{"name":"_GroupToUser_AB_unique","columns":["A","B"],"tpe":"unique"}}}],"rollback":[{"DropIndex":{"table":"_FriendShip","name":"_FriendShip_AB_unique"}},{"DropIndex":{"table":"_GroupToUser","name":"_GroupToUser_AB_unique"}},{"DropTable":{"name":"User"}},{"DropTable":{"name":"Post"}},{"DropTable":{"name":"Comment"}},{"DropTable":{"name":"Like"}},{"DropTable":{"name":"Group"}},{"DropTable":{"name":"_FriendShip"}},{"DropTable":{"name":"_GroupToUser"}}]}	[]	2019-10-23 11:02:08.786	2019-10-23 11:02:08.938
2	20191023133905-add_dates	model User {\n  id         Int       @id @unique\n  firstName  String\n  lastName   String\n  age        Int?\n  email      String?\n  password   String?\n  posts      Post[]\n  comments   Comment[]\n  likes      Like[]\n  friendWith User[]    @relation("FriendShip")\n  friendOf   User[]    @relation("FriendShip")\n  groups     Group[]\n  createdAt  DateTime  @default(now())\n  updatedAt  DateTime\n}\n\nmodel Post {\n  id        Int       @id @unique\n  content   String?\n  author    User\n  comments  Comment[]\n  likes     Like[]\n  createdAt DateTime  @default(now())\n  updatedAt DateTime\n}\n\nmodel Comment {\n  id        Int      @id @unique\n  content   String?\n  author    User\n  post      Post\n  likes     Like[]\n  createdAt DateTime @default(now())\n  updatedAt DateTime\n}\n\nmodel Like {\n  id        Int      @id @unique\n  user      User\n  post      Post\n  comment   Comment\n  createdAt DateTime @default(now())\n  updatedAt DateTime\n}\n\nmodel Group {\n  id          Int      @id @unique\n  topic       String\n  description String?\n  members     User[]\n  createdAt   DateTime @default(now())\n  updatedAt   DateTime\n}	MigrationSuccess	2	0	[{"stepType":"CreateField","model":"Comment","name":"createdAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false,"default":{"Expression":["now","DateTime",[]]}},{"stepType":"CreateField","model":"Comment","name":"updatedAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Like","name":"createdAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false,"default":{"Expression":["now","DateTime",[]]}},{"stepType":"CreateField","model":"Like","name":"updatedAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false},{"stepType":"CreateField","model":"Group","name":"createdAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false,"default":{"Expression":["now","DateTime",[]]}},{"stepType":"CreateField","model":"Group","name":"updatedAt","type":{"Base":"DateTime"},"arity":"required","isUnique":false}]	{"before":{"tables":[{"name":"Comment","columns":[{"name":"author","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"text","family":"string"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"id","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"Comment_id_seq\\"'::regclass)","autoIncrement":false},{"name":"post","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":{"name":"Comment_id_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[{"constraintName":"Comment_author_fkey","columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":"Comment_post_fkey","columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"_FriendShip","columns":[{"name":"A","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false}],"indices":[{"name":"_FriendShip_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":"_FriendShip_A_fkey","columns":["A"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":"_FriendShip_B_fkey","columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]},{"name":"Group","columns":[{"name":"description","tpe":{"raw":"text","family":"string"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"id","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"Group_id_seq\\"'::regclass)","autoIncrement":false},{"name":"topic","tpe":{"raw":"text","family":"string"},"arity":"required","default":"''::text","autoIncrement":false}],"indices":[{"name":"Group.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":{"name":"Group_id_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[]},{"name":"_GroupToUser","columns":[{"name":"A","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false}],"indices":[{"name":"_GroupToUser_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":"_GroupToUser_A_fkey","columns":["A"],"referencedTable":"Group","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":"_GroupToUser_B_fkey","columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]},{"name":"Like","columns":[{"name":"comment","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"id","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"Like_id_seq\\"'::regclass)","autoIncrement":false},{"name":"post","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"user","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":{"name":"Like_id_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[{"constraintName":"Like_comment_fkey","columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":"Like_post_fkey","columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":"Like_user_fkey","columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"_Migration","columns":[{"name":"applied","tpe":{"raw":"int4","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"database_migration","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"datamodel","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"datamodel_steps","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"errors","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"finished_at","tpe":{"raw":"timestamp","family":"dateTime"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"name","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false},{"name":"revision","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"_Migration_revision_seq\\"'::regclass)","autoIncrement":false},{"name":"rolled_back","tpe":{"raw":"int4","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"started_at","tpe":{"raw":"timestamp","family":"dateTime"},"arity":"required","default":null,"autoIncrement":false},{"name":"status","tpe":{"raw":"text","family":"string"},"arity":"required","default":null,"autoIncrement":false}],"indices":[],"primaryKey":{"columns":["revision"],"sequence":{"name":"_Migration_revision_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[]},{"name":"Post","columns":[{"name":"author","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"text","family":"string"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"createdAt","tpe":{"raw":"timestamp","family":"dateTime"},"arity":"required","default":"'1970-01-01 00:00:00'::timestamp without time zone","autoIncrement":false},{"name":"id","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"Post_id_seq\\"'::regclass)","autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"timestamp","family":"dateTime"},"arity":"required","default":"'1970-01-01 00:00:00'::timestamp without time zone","autoIncrement":false}],"indices":[{"name":"Post.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":{"name":"Post_id_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[{"constraintName":"Post_author_fkey","columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"User","columns":[{"name":"age","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"createdAt","tpe":{"raw":"timestamp","family":"dateTime"},"arity":"required","default":"'1970-01-01 00:00:00'::timestamp without time zone","autoIncrement":false},{"name":"email","tpe":{"raw":"text","family":"string"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"firstName","tpe":{"raw":"text","family":"string"},"arity":"required","default":"''::text","autoIncrement":false},{"name":"id","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"User_id_seq\\"'::regclass)","autoIncrement":false},{"name":"lastName","tpe":{"raw":"text","family":"string"},"arity":"required","default":"''::text","autoIncrement":false},{"name":"password","tpe":{"raw":"text","family":"string"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"timestamp","family":"dateTime"},"arity":"required","default":"'1970-01-01 00:00:00'::timestamp without time zone","autoIncrement":false}],"indices":[{"name":"User.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":{"name":"User_id_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[]}],"enums":[],"sequences":[{"name":"_Migration_revision_seq","initialValue":1,"allocationSize":1},{"name":"User_id_seq","initialValue":1,"allocationSize":1},{"name":"Post_id_seq","initialValue":1,"allocationSize":1},{"name":"Comment_id_seq","initialValue":1,"allocationSize":1},{"name":"Like_id_seq","initialValue":1,"allocationSize":1},{"name":"Group_id_seq","initialValue":1,"allocationSize":1}]},"after":{"tables":[{"name":"User","columns":[{"name":"age","tpe":{"raw":"","family":"int"},"arity":"nullable","default":"0","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"email","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"firstName","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"lastName","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"password","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"User.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]},{"name":"Post","columns":[{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Post.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"Comment","columns":[{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"Like","columns":[{"name":"comment","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"user","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"}]},{"name":"Group","columns":[{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"description","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"topic","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Group.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]},{"name":"_FriendShip","columns":[{"name":"A","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"_FriendShip_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":null,"columns":["A"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":null,"columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]},{"name":"_GroupToUser","columns":[{"name":"A","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"B","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"_GroupToUser_AB_unique","columns":["A","B"],"tpe":"unique"}],"primaryKey":null,"foreignKeys":[{"constraintName":null,"columns":["A"],"referencedTable":"Group","referencedColumns":["id"],"onDeleteAction":"cascade"},{"constraintName":null,"columns":["B"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"cascade"}]}],"enums":[],"sequences":[]},"original_steps":[{"AlterTable":{"table":{"name":"Comment","columns":[{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"AddColumn":{"column":{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}},{"AddColumn":{"column":{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}}]}},{"AlterTable":{"table":{"name":"Group","columns":[{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"description","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"topic","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Group.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]},"changes":[{"AddColumn":{"column":{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}},{"AddColumn":{"column":{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}}]}},{"AlterTable":{"table":{"name":"Like","columns":[{"name":"comment","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"user","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"AddColumn":{"column":{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}},{"AddColumn":{"column":{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}}]}}],"corrected_steps":[{"AlterTable":{"table":{"name":"Comment","columns":[{"name":"author","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"AddColumn":{"column":{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}},{"AddColumn":{"column":{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}}]}},{"AlterTable":{"table":{"name":"Group","columns":[{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"description","tpe":{"raw":"","family":"string"},"arity":"nullable","default":"","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"topic","tpe":{"raw":"","family":"string"},"arity":"required","default":"","autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}],"indices":[{"name":"Group.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[]},"changes":[{"AddColumn":{"column":{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}},{"AddColumn":{"column":{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}}]}},{"AlterTable":{"table":{"name":"Like","columns":[{"name":"comment","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"id","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":true},{"name":"post","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false},{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false},{"name":"user","tpe":{"raw":"","family":"int"},"arity":"required","default":null,"autoIncrement":false}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":null},"foreignKeys":[{"constraintName":null,"columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":null,"columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"AddColumn":{"column":{"name":"createdAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}},{"AddColumn":{"column":{"name":"updatedAt","tpe":{"raw":"","family":"dateTime"},"arity":"required","default":"1970-01-01 00:00:00","autoIncrement":false}}}]}}],"rollback":[{"AlterTable":{"table":{"name":"Comment","columns":[{"name":"author","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"content","tpe":{"raw":"text","family":"string"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"id","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"Comment_id_seq\\"'::regclass)","autoIncrement":false},{"name":"post","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false}],"indices":[{"name":"Comment.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":{"name":"Comment_id_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[{"constraintName":"Comment_author_fkey","columns":["author"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":"Comment_post_fkey","columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"DropColumn":{"name":"createdAt"}},{"DropColumn":{"name":"updatedAt"}}]}},{"AlterTable":{"table":{"name":"Like","columns":[{"name":"comment","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"id","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"Like_id_seq\\"'::regclass)","autoIncrement":false},{"name":"post","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"user","tpe":{"raw":"int4","family":"int"},"arity":"nullable","default":null,"autoIncrement":false}],"indices":[{"name":"Like.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":{"name":"Like_id_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[{"constraintName":"Like_comment_fkey","columns":["comment"],"referencedTable":"Comment","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":"Like_post_fkey","columns":["post"],"referencedTable":"Post","referencedColumns":["id"],"onDeleteAction":"setNull"},{"constraintName":"Like_user_fkey","columns":["user"],"referencedTable":"User","referencedColumns":["id"],"onDeleteAction":"setNull"}]},"changes":[{"DropColumn":{"name":"createdAt"}},{"DropColumn":{"name":"updatedAt"}}]}},{"AlterTable":{"table":{"name":"Group","columns":[{"name":"description","tpe":{"raw":"text","family":"string"},"arity":"nullable","default":null,"autoIncrement":false},{"name":"id","tpe":{"raw":"int4","family":"int"},"arity":"required","default":"nextval('\\"Group_id_seq\\"'::regclass)","autoIncrement":false},{"name":"topic","tpe":{"raw":"text","family":"string"},"arity":"required","default":"''::text","autoIncrement":false}],"indices":[{"name":"Group.id","columns":["id"],"tpe":"unique"}],"primaryKey":{"columns":["id"],"sequence":{"name":"Group_id_seq","initialValue":1,"allocationSize":1}},"foreignKeys":[]},"changes":[{"DropColumn":{"name":"createdAt"}},{"DropColumn":{"name":"updatedAt"}}]}}]}	[]	2019-10-23 11:39:18.01	2019-10-23 11:39:18.065
\.


--
-- Name: Comment_id_seq; Type: SEQUENCE SET; Schema: sql_load_test; Owner: postgres
--

SELECT pg_catalog.setval('sql_load_test."Comment_id_seq"', 1, false);


--
-- Name: Group_id_seq; Type: SEQUENCE SET; Schema: sql_load_test; Owner: postgres
--

SELECT pg_catalog.setval('sql_load_test."Group_id_seq"', 1, false);


--
-- Name: Like_id_seq; Type: SEQUENCE SET; Schema: sql_load_test; Owner: postgres
--

SELECT pg_catalog.setval('sql_load_test."Like_id_seq"', 1, false);


--
-- Name: Post_id_seq; Type: SEQUENCE SET; Schema: sql_load_test; Owner: postgres
--

SELECT pg_catalog.setval('sql_load_test."Post_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: sql_load_test; Owner: postgres
--

SELECT pg_catalog.setval('sql_load_test."User_id_seq"', 1, false);


--
-- Name: _Migration_revision_seq; Type: SEQUENCE SET; Schema: sql_load_test; Owner: postgres
--

SELECT pg_catalog.setval('sql_load_test."_Migration_revision_seq"', 2, true);


--
-- Name: Comment Comment_pkey; Type: CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Comment"
    ADD CONSTRAINT "Comment_pkey" PRIMARY KEY (id);


--
-- Name: Group Group_pkey; Type: CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Group"
    ADD CONSTRAINT "Group_pkey" PRIMARY KEY (id);


--
-- Name: Like Like_pkey; Type: CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Like"
    ADD CONSTRAINT "Like_pkey" PRIMARY KEY (id);


--
-- Name: Post Post_pkey; Type: CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Post"
    ADD CONSTRAINT "Post_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _Migration _Migration_pkey; Type: CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."_Migration"
    ADD CONSTRAINT "_Migration_pkey" PRIMARY KEY (revision);


--
-- Name: Comment.id; Type: INDEX; Schema: sql_load_test; Owner: postgres
--

CREATE UNIQUE INDEX "Comment.id" ON sql_load_test."Comment" USING btree (id);


--
-- Name: Group.id; Type: INDEX; Schema: sql_load_test; Owner: postgres
--

CREATE UNIQUE INDEX "Group.id" ON sql_load_test."Group" USING btree (id);


--
-- Name: Like.id; Type: INDEX; Schema: sql_load_test; Owner: postgres
--

CREATE UNIQUE INDEX "Like.id" ON sql_load_test."Like" USING btree (id);


--
-- Name: Post.id; Type: INDEX; Schema: sql_load_test; Owner: postgres
--

CREATE UNIQUE INDEX "Post.id" ON sql_load_test."Post" USING btree (id);


--
-- Name: User.id; Type: INDEX; Schema: sql_load_test; Owner: postgres
--

CREATE UNIQUE INDEX "User.id" ON sql_load_test."User" USING btree (id);


--
-- Name: _FriendShip_AB_unique; Type: INDEX; Schema: sql_load_test; Owner: postgres
--

CREATE UNIQUE INDEX "_FriendShip_AB_unique" ON sql_load_test."_FriendShip" USING btree ("A", "B");


--
-- Name: _GroupToUser_AB_unique; Type: INDEX; Schema: sql_load_test; Owner: postgres
--

CREATE UNIQUE INDEX "_GroupToUser_AB_unique" ON sql_load_test."_GroupToUser" USING btree ("A", "B");


--
-- Name: Comment Comment_author_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Comment"
    ADD CONSTRAINT "Comment_author_fkey" FOREIGN KEY (author) REFERENCES sql_load_test."User"(id) ON DELETE SET NULL;


--
-- Name: Comment Comment_post_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Comment"
    ADD CONSTRAINT "Comment_post_fkey" FOREIGN KEY (post) REFERENCES sql_load_test."Post"(id) ON DELETE SET NULL;


--
-- Name: Like Like_comment_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Like"
    ADD CONSTRAINT "Like_comment_fkey" FOREIGN KEY (comment) REFERENCES sql_load_test."Comment"(id) ON DELETE SET NULL;


--
-- Name: Like Like_post_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Like"
    ADD CONSTRAINT "Like_post_fkey" FOREIGN KEY (post) REFERENCES sql_load_test."Post"(id) ON DELETE SET NULL;


--
-- Name: Like Like_user_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Like"
    ADD CONSTRAINT "Like_user_fkey" FOREIGN KEY ("user") REFERENCES sql_load_test."User"(id) ON DELETE SET NULL;


--
-- Name: Post Post_author_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."Post"
    ADD CONSTRAINT "Post_author_fkey" FOREIGN KEY (author) REFERENCES sql_load_test."User"(id) ON DELETE SET NULL;


--
-- Name: _FriendShip _FriendShip_A_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."_FriendShip"
    ADD CONSTRAINT "_FriendShip_A_fkey" FOREIGN KEY ("A") REFERENCES sql_load_test."User"(id) ON DELETE CASCADE;


--
-- Name: _FriendShip _FriendShip_B_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."_FriendShip"
    ADD CONSTRAINT "_FriendShip_B_fkey" FOREIGN KEY ("B") REFERENCES sql_load_test."User"(id) ON DELETE CASCADE;


--
-- Name: _GroupToUser _GroupToUser_A_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."_GroupToUser"
    ADD CONSTRAINT "_GroupToUser_A_fkey" FOREIGN KEY ("A") REFERENCES sql_load_test."Group"(id) ON DELETE CASCADE;


--
-- Name: _GroupToUser _GroupToUser_B_fkey; Type: FK CONSTRAINT; Schema: sql_load_test; Owner: postgres
--

ALTER TABLE ONLY sql_load_test."_GroupToUser"
    ADD CONSTRAINT "_GroupToUser_B_fkey" FOREIGN KEY ("B") REFERENCES sql_load_test."User"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

