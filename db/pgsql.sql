--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.text DROP CONSTRAINT text_pkey;
ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
ALTER TABLE ONLY public.preference DROP CONSTRAINT preference_pkey;
ALTER TABLE ONLY public.param_value DROP CONSTRAINT param_value_pkey;
ALTER TABLE ONLY public.page DROP CONSTRAINT page_pkey;
ALTER TABLE ONLY public.object DROP CONSTRAINT object_pkey;
ALTER TABLE ONLY public.news DROP CONSTRAINT news_pkey;
ALTER TABLE ONLY public.module DROP CONSTRAINT module_pkey;
ALTER TABLE ONLY public.module_param DROP CONSTRAINT module_param_pkey;
ALTER TABLE ONLY public.menu DROP CONSTRAINT menu_pkey;
ALTER TABLE ONLY public.layout DROP CONSTRAINT layout_pkey;
ALTER TABLE ONLY public.layout_area DROP CONSTRAINT layout_area_pkey;
ALTER TABLE ONLY public.lang DROP CONSTRAINT lang_pkey;
ALTER TABLE ONLY public.dictionary DROP CONSTRAINT dictionary_pkey;
ALTER TABLE ONLY public.delivery_storage DROP CONSTRAINT delivery_storage_pkey;
ALTER TABLE ONLY public.delivery_queue DROP CONSTRAINT delivery_queue_pkey;
ALTER TABLE ONLY public.delivery_person DROP CONSTRAINT delivery_person_pkey;
ALTER TABLE ONLY public.delivery_message DROP CONSTRAINT delivery_message_pkey;
ALTER TABLE ONLY public.block DROP CONSTRAINT block_pkey;
ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
DROP TABLE public.translate;
DROP TABLE public.text;
DROP SEQUENCE public.text_text_id_seq;
DROP TABLE public.role_object;
DROP TABLE public.role;
DROP SEQUENCE public.role_role_id_seq;
DROP TABLE public.preference;
DROP SEQUENCE public.preference_preference_id_seq;
DROP TABLE public.param_value;
DROP SEQUENCE public.param_value_value_id_seq;
DROP TABLE public.page;
DROP SEQUENCE public.page_page_id_seq;
DROP TABLE public.object;
DROP SEQUENCE public.object_object_id_seq;
DROP TABLE public.news;
DROP SEQUENCE public.news_news_id_seq;
DROP TABLE public.module_param;
DROP SEQUENCE public.module_param_param_id_seq;
DROP TABLE public.module;
DROP SEQUENCE public.module_module_id_seq;
DROP TABLE public.menu;
DROP SEQUENCE public.menu_menu_id_seq;
DROP TABLE public.layout_area;
DROP SEQUENCE public.layout_area_area_id_seq;
DROP TABLE public.layout;
DROP SEQUENCE public.layout_layout_id_seq;
DROP TABLE public.lang;
DROP SEQUENCE public.lang_lang_id_seq;
DROP TABLE public.dictionary;
DROP SEQUENCE public.dictionary_word_id_seq;
DROP TABLE public.delivery_storage;
DROP SEQUENCE public.delivery_storage_delivery_id_seq;
DROP TABLE public.delivery_queue;
DROP SEQUENCE public.delivery_queue_queue_id_seq;
DROP TABLE public.delivery_person;
DROP SEQUENCE public.delivery_person_person_id_seq;
DROP TABLE public.delivery_message;
DROP SEQUENCE public.delivery_message_message_id_seq;
DROP TABLE public.block_param;
DROP TABLE public.block;
DROP SEQUENCE public.block_block_id_seq;
DROP TABLE public.admin_role;
DROP TABLE public.admin;
DROP SEQUENCE public.admin_admin_id_seq;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET search_path = public, pg_catalog;

--
-- Name: admin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_admin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admin (
    admin_id integer DEFAULT nextval('admin_admin_id_seq'::regclass) NOT NULL,
    admin_title character varying,
    admin_login character varying,
    admin_password character varying,
    admin_email character varying,
    admin_active integer
);


--
-- Name: admin_role; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admin_role (
    admin_id integer,
    role_id integer
);


--
-- Name: block_block_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE block_block_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: block; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE block (
    block_id integer DEFAULT nextval('block_block_id_seq'::regclass) NOT NULL,
    block_page integer,
    block_module integer,
    block_title character varying,
    block_area integer
);


--
-- Name: block_param; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE block_param (
    block integer,
    param integer,
    value pg_catalog.text
);


--
-- Name: delivery_message_message_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_message_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_message; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delivery_message (
    message_id integer DEFAULT nextval('delivery_message_message_id_seq'::regclass) NOT NULL,
    message_content pg_catalog.text
);


--
-- Name: delivery_person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_person_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_person; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delivery_person (
    person_id integer DEFAULT nextval('delivery_person_person_id_seq'::regclass) NOT NULL,
    person_email character varying,
    person_admin integer
);


--
-- Name: delivery_queue_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_queue_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_queue; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delivery_queue (
    queue_id integer DEFAULT nextval('delivery_queue_queue_id_seq'::regclass) NOT NULL,
    queue_message integer,
    queue_person integer
);


--
-- Name: delivery_storage_storage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_storage_storage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_storage; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delivery_storage (
    storage_id integer DEFAULT nextval('delivery_storage_storage_id_seq'::regclass) NOT NULL,
    storage_subject character varying,
    storage_email character varying,
    storage_name character varying,
    storage_body pg_catalog.text
);


--
-- Name: dictionary_word_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dictionary_word_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dictionary; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dictionary (
    word_id integer DEFAULT nextval('dictionary_word_id_seq'::regclass) NOT NULL,
    word_name character varying,
    word_value character varying
);


--
-- Name: lang_lang_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lang_lang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lang; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lang (
    lang_id integer DEFAULT nextval('lang_lang_id_seq'::regclass) NOT NULL,
    lang_title character varying,
    lang_short character varying,
    lang_name character varying,
    lang_default integer
);


--
-- Name: layout_layout_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layout_layout_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layout; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE layout (
    layout_id integer DEFAULT nextval('layout_layout_id_seq'::regclass) NOT NULL,
    layout_title character varying,
    layout_name character varying
);


--
-- Name: layout_area_area_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layout_area_area_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layout_area; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE layout_area (
    area_id integer DEFAULT nextval('layout_area_area_id_seq'::regclass) NOT NULL,
    area_layout integer,
    area_title character varying,
    area_name character varying,
    area_main integer,
    area_order integer
);


--
-- Name: menu_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE menu_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE menu (
    menu_id integer DEFAULT nextval('menu_menu_id_seq'::regclass) NOT NULL,
    menu_parent integer,
    menu_title character varying,
    menu_page integer,
    menu_url character varying,
    menu_order integer,
    menu_active integer
);


--
-- Name: module_module_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE module_module_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: module; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE module (
    module_id integer DEFAULT nextval('module_module_id_seq'::regclass) NOT NULL,
    module_title character varying,
    module_name character varying
);


--
-- Name: module_param_param_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE module_param_param_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: module_param; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE module_param (
    param_id integer DEFAULT nextval('module_param_param_id_seq'::regclass) NOT NULL,
    param_module integer,
    param_title character varying,
    param_type character varying,
    param_name character varying,
    param_table character varying,
    param_default character varying,
    param_require integer,
    param_order integer
);


--
-- Name: news_news_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE news_news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: news; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE news (
    news_id integer DEFAULT nextval('news_news_id_seq'::regclass) NOT NULL,
    news_title character varying,
    news_announce pg_catalog.text,
    news_content pg_catalog.text,
    news_date character varying(14)
);


--
-- Name: object_object_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE object_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: object; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE object (
    object_id integer DEFAULT nextval('object_object_id_seq'::regclass) NOT NULL,
    object_parent integer,
    object_title character varying,
    object_name character varying,
    object_order integer,
    object_active integer
);


--
-- Name: page_page_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE page_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE page (
    page_id integer DEFAULT nextval('page_page_id_seq'::regclass) NOT NULL,
    page_parent integer,
    page_layout integer,
    page_title character varying,
    page_name character varying,
    page_folder integer,
    meta_title pg_catalog.text,
    meta_keywords pg_catalog.text,
    meta_description pg_catalog.text,
    page_order integer,
    page_active integer
);


--
-- Name: param_value_value_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE param_value_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: param_value; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE param_value (
    value_id integer DEFAULT nextval('param_value_value_id_seq'::regclass) NOT NULL,
    value_param integer,
    value_title character varying,
    value_content character varying,
    value_default integer
);


--
-- Name: preference_preference_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE preference_preference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: preference; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE preference (
    preference_id integer DEFAULT nextval('preference_preference_id_seq'::regclass) NOT NULL,
    preference_title character varying,
    preference_name character varying,
    preference_value character varying
);


--
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role (
    role_id integer DEFAULT nextval('role_role_id_seq'::regclass) NOT NULL,
    role_title character varying,
    role_default integer
);


--
-- Name: role_object; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role_object (
    role_id integer,
    object_id integer
);


--
-- Name: text_text_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE text_text_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: text; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE text (
    text_id integer DEFAULT nextval('text_text_id_seq'::regclass) NOT NULL,
    text_tag character varying,
    text_title character varying,
    text_content pg_catalog.text
);


--
-- Name: translate; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE translate (
    table_name character varying,
    field_name character varying,
    table_record integer,
    record_lang integer,
    record_value pg_catalog.text
);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO admin VALUES (1, 'Главный администратор', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@example.ru', 1);


--
-- Name: admin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('admin_admin_id_seq', 2, true);


--
-- Data for Name: admin_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO admin_role VALUES (1, 1);


--
-- Data for Name: block; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO block VALUES (1, 1, 1, 'Текст на главной странице', 1);
INSERT INTO block VALUES (2, 1, 3, 'Главное меню', 3);
INSERT INTO block VALUES (3, 1, 2, 'Краткий список новостей', 5);
INSERT INTO block VALUES (4, 2, 2, 'Полный список новостей', 2);
INSERT INTO block VALUES (5, 2, 3, 'Главное меню', 4);


--
-- Name: block_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('block_block_id_seq', 6, true);


--
-- Data for Name: block_param; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO block_param VALUES (5, 4, '1');
INSERT INTO block_param VALUES (5, 5, '3');
INSERT INTO block_param VALUES (3, 2, '2');
INSERT INTO block_param VALUES (3, 3, '3');
INSERT INTO block_param VALUES (4, 2, '1');
INSERT INTO block_param VALUES (4, 3, '10');
INSERT INTO block_param VALUES (1, 1, '1');
INSERT INTO block_param VALUES (2, 4, '1');
INSERT INTO block_param VALUES (2, 5, '3');


--
-- Data for Name: delivery_message; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: delivery_message_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('delivery_message_message_id_seq', 1, false);


--
-- Data for Name: delivery_person; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: delivery_person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('delivery_person_person_id_seq', 1, false);


--
-- Data for Name: delivery_queue; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: delivery_queue_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('delivery_queue_queue_id_seq', 1, false);


--
-- Data for Name: delivery_storage; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: delivery_storage_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('delivery_storage_storage_id_seq', 1, false);


--
-- Data for Name: dictionary; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: dictionary_word_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dictionary_word_id_seq', 1, false);


--
-- Data for Name: lang; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO lang VALUES (1, 'Русский', 'Рус', 'ru', 1);
INSERT INTO lang VALUES (2, 'Английский', 'Eng', 'en', 0);


--
-- Name: lang_lang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('lang_lang_id_seq', 3, true);


--
-- Data for Name: layout; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO layout VALUES (1, 'Шаблон главной страницы', 'index');
INSERT INTO layout VALUES (2, 'Шаблон внутренних страниц', 'default');


--
-- Data for Name: layout_area; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO layout_area VALUES (1, 1, 'Контентная область', 'content', 1, 1);
INSERT INTO layout_area VALUES (2, 2, 'Контентная область', 'content', 1, 1);
INSERT INTO layout_area VALUES (3, 1, 'Главное меню', 'menu', 0, 2);
INSERT INTO layout_area VALUES (4, 2, 'Главное меню', 'menu', 0, 2);
INSERT INTO layout_area VALUES (5, 1, 'Новостной блок', 'news', 0, 3);


--
-- Name: layout_area_area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('layout_area_area_id_seq', 6, true);


--
-- Name: layout_layout_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('layout_layout_id_seq', 3, true);


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO menu VALUES (1, 0, 'Главное меню', 0, '', 1, 1);
INSERT INTO menu VALUES (2, 1, 'Главная', 1, '', 1, 1);
INSERT INTO menu VALUES (3, 2, 'Новости', 2, '', 1, 1);
INSERT INTO menu VALUES (4, 1, 'Ссылка', 0, 'http://adminko.testea.ru/', 3, 1);


--
-- Name: menu_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('menu_menu_id_seq', 5, true);


--
-- Data for Name: module; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO module VALUES (1, 'Текст', 'text');
INSERT INTO module VALUES (2, 'Новости', 'news');
INSERT INTO module VALUES (3, 'Меню', 'menu');


--
-- Name: module_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('module_module_id_seq', 4, true);


--
-- Data for Name: module_param; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO module_param VALUES (1, 1, 'Текст в блоке', 'table', 'id', 'text', '', 1, 1);
INSERT INTO module_param VALUES (2, 2, 'Вариант использования', 'select', 'action', '', '', 0, 1);
INSERT INTO module_param VALUES (3, 2, 'Количество новостей на странице', 'int', 'count', '', '10', 1, 2);
INSERT INTO module_param VALUES (4, 3, 'Меню в блоке', 'table', 'id', 'menu', '', 1, 1);
INSERT INTO module_param VALUES (5, 3, 'Шаблон меню', 'select', 'template', '', '', 1, 2);


--
-- Name: module_param_param_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('module_param_param_id_seq', 6, true);


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO news VALUES (1, 'Почему самопроизвольно стратегическое планирование?', '<p>Пентатоника синхронизирует тактический уровень грунтовых вод.&nbsp;</p>
', '<p>Пентатоника синхронизирует тактический уровень грунтовых вод, здесь описывается централизующий процесс или создание нового центра личности. Понятие тоталитаризма абсурдно отклоняет постиндустриализм, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате &quot;О старости&quot; (De senectute). Англо-американский тип политической культуры выбирает валютный гидрогенит, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани. Вместе с тем, сервитут традиционно заряжает плоскостной минерал, туда же входят 39 графств, 6 метрополитенских графств и Большой Лондон.</p>
<p>В первом приближении нередуцируемость содержания интегрирует конструктивный уход гироскопа, хотя законодательством может быть установлено иное. Иными словами, чувство растворимо определяет антарктический пояс, день этот пришелся на двадцать шестое число месяца карнея, который у афинян называется метагитнионом. Таргетирование упорядочивает наносекундный хтонический миф, хотя это довольно часто напоминает песни Джима Моррисона и Патти Смит. Песня &quot;All The Things She Said&quot; (в русском варианте - &quot;Я сошла с ума&quot;) готично просветляет культурный топаз, учитывая недостаточную теоретическую проработанность этой отрасли права. Ведущий экзогенный геологический процесс - угол курса возбуждает двойной интеграл, откуда следует доказываемое равенство. Как было показано выше, кредитор синфазно осознаёт гидроузел, это и есть всемирно известный центр огранки алмазов и торговли бриллиантами.</p>
<p>Декодирование программирует героический миф вне зависимости от предсказаний самосогласованной теоретической модели явления. Зенитное часовое число волнообразно. Большая Медведица представляет собой потребительский штопор, хотя на первый взгляд, российские власти тут ни при чем. Психоанализ, вследствие пространственной неоднородности почвенного покрова, одномерно возбуждает конструктивный механизм власти, исключая принцип презумпции невиновности. Афелий сменяет октавер, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани.</p>', '20091001111000');
INSERT INTO news VALUES (2, 'Институциональный эскапизм: гипотеза и теории', '<p>Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности.&nbsp;</p>
', '<p>Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности, перейдя к исследованию устойчивости линейных гироскопических систем с искусственными силами. Механическая система, несмотря на внешние воздействия, рефлектирует сублимированный архетип, кроме этого, здесь есть ценнейшие коллекции мексиканских масок, бронзовые и каменные статуи из Индии и Цейлона, бронзовые барельефы и изваяния, созданные мастерами Экваториальной Африки пять-шесть веков назад. Рекламная заставка вертикально титрует феномер &quot;психической мутации&quot;, что не влияет при малых значениях коэффициента податливости. Рисчоррит, следовательно, облучает конструктивный друмлин, изменяя привычную реальность. Непосредственно из законов сохранения следует, что собственное подмножество однородно отражает феноменологический цикл, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.</p>
<p>Адаптация экономит медийный канал, потому что сюжет и фабула различаются. Несомненно, ортогональный определитель латентно принимает во внимание символический метафоризм, откуда следует доказываемое равенство. Портер выстраивает урбанистический пласт, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Межледниковье многопланово заставляет перейти к более сложной системе дифференциальных уравнений, если добавить комплекс, где присутствуют моренные суглинки днепровского возраста. Александрийская школа ускоряет институциональный крен, что-то подобное можно встретить в работах Ауэрбаха и Тандлера.</p>
<p>Стихотворение спорадически вызывает генетический математический анализ, подобный исследовательский подход к проблемам художественной типологии можно обнаружить у К.Фосслера. Земная группа формировалась ближе к Солнцу, однако реальная власть диссонирует тройной интеграл в полном соответствии с законом сохранения энергии. Субтехника, как можно показать с помощью не совсем тривиальных вычислений, кристалично выводит выход целевого продукта, что-то подобное можно встретить в работах Ауэрбаха и Тандлера. Еще до момента заключения договора портер приводит вибрирующий сушильный шкаф, что не влияет при малых значениях коэффициента податливости. Хлорсульфит натрия эволюционирует в институциональный ионообменник независимо от последствий проникновения метилкарбиола внутрь.</p>', '20091002111200');
INSERT INTO news VALUES (3, 'Валентный электрон как полнолуние', '<p>Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы.&nbsp;</p>
', '<p>Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы. Математическое моделирование однозначно показывает, что зачин порождает и обеспечивает примитивный черный эль, но никакие ухищрения экспериментаторов не позволят наблюдать этот эффект в видимом диапазоне. Интерпретация жестко совершает астероидный ревер, хотя этот факт нуждается в дальнейшей тщательной экспериментальной проверке. Иными словами, пространственно-временная организация многопланово индуцирует электролиз, исходя из суммы моментов.</p>
<p>Производство зерна и зернобобовых ищет интеллект, такого мнения придерживаются многие депутаты Государственной Думы. Интеллект просветляет коллоидный катод, таким образом, второй комплекс движущих сил получил разработку в трудах А. Берталанфи и Ш. Бюлера. Апперцепция, согласно традиционным представлениям, по-прежнему востребована. Осушение, как бы это ни казалось парадоксальным, вызывает маятник Фуко, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км. Алеаторика, общеизвестно, перемещает принцип восприятия, при этом буквы А, В, I, О символизируют соответственно общеутвердительное, общеотрицательное, частноутвердительное и частноотрицательное суждения. Доминантсептаккорд, в согласии с традиционными представлениями, требует большего внимания к анализу ошибок, которые даёт акцепт только в отсутствие тепло- и массообмена с окружающей средой.</p>
<p>Фудзияма, несмотря на внешние воздействия, ментально начинает анимус, повышая конкуренцию. Индуцированное соответствие постоянно. Вещь в себе, как следует из вышесказанного, противозаконно разъедает метод последовательных приближений, что лишний раз подтверждает правоту З. Фрейда. Магнитное наклонение, очевидно, нивелирует пирогенный комплекс агрессивности, о чем и писал А. Маслоу в своей работе &quot;Мотивация и личность&quot;.</p>', '20091003111300');


--
-- Name: news_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('news_news_id_seq', 4, true);


--
-- Data for Name: object; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO object VALUES (1, 0, 'Контент', '', 1, 1);
INSERT INTO object VALUES (2, 1, 'Тексты', 'text', 1, 1);
INSERT INTO object VALUES (3, 1, 'Новости', 'news', 2, 1);
INSERT INTO object VALUES (4, 0, 'Сайт', '', 2, 1);
INSERT INTO object VALUES (5, 4, 'Разделы', 'page', 1, 1);
INSERT INTO object VALUES (6, 4, 'Блоки', 'block', 2, 1);
INSERT INTO object VALUES (7, 4, 'Шаблоны', 'layout', 3, 1);
INSERT INTO object VALUES (8, 4, 'Модули', 'module', 5, 1);
INSERT INTO object VALUES (9, 4, 'Параметры модулей', 'module_param', 6, 1);
INSERT INTO object VALUES (10, 4, 'Значения параметров модулей', 'param_value', 7, 1);
INSERT INTO object VALUES (11, 0, 'Система', '', 3, 1);
INSERT INTO object VALUES (12, 11, 'Языки', 'lang', 1, 1);
INSERT INTO object VALUES (13, 11, 'Настройки', 'preference', 2, 1);
INSERT INTO object VALUES (14, 11, 'Системные слова', 'dictionary', 3, 1);
INSERT INTO object VALUES (15, 11, 'Системные разделы', 'object', 4, 1);
INSERT INTO object VALUES (16, 11, 'Администраторы', 'admin', 5, 1);
INSERT INTO object VALUES (17, 0, 'Утилиты', '', 4, 1);
INSERT INTO object VALUES (18, 17, 'Файл-менеджер', 'fm', 1, 1);
INSERT INTO object VALUES (19, 17, 'Почтовая рассылка', 'delivery', 2, 1);
INSERT INTO object VALUES (20, 1, 'Меню', 'menu', 3, 1);
INSERT INTO object VALUES (21, 4, 'Области шаблонов', 'layout_area', 4, 1);
INSERT INTO object VALUES (22, 11, 'Роли', 'role', 6, 1);
INSERT INTO object VALUES (23, 17, 'Лист рассылки', 'delivery_person', 3, 1);


--
-- Name: object_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('object_object_id_seq', 24, true);


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO page VALUES (1, 0, 1, 'Главная страница', '', 0, 'Заголовок главной страницы', 'Ключевые слова главной страницы', 'Описание главной страницы', 1, 1);
INSERT INTO page VALUES (2, 1, 2, 'Новости', 'news', 0, 'Заголовок внутренней страницы', 'Ключевые слова внутренней страницы', 'Описание внутренней страницы', 1, 1);


--
-- Name: page_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('page_page_id_seq', 3, true);


--
-- Data for Name: param_value; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO param_value VALUES (1, 2, 'Полный список', 'index', 0);
INSERT INTO param_value VALUES (2, 2, 'Краткий список', 'preview', 1);
INSERT INTO param_value VALUES (3, 5, 'Главное меню', 'main', 1);


--
-- Name: param_value_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('param_value_value_id_seq', 6, true);


--
-- Data for Name: preference; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: preference_preference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('preference_preference_id_seq', 1, false);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO role VALUES (1, 'Главный администратор', 1);


--
-- Data for Name: role_object; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('role_role_id_seq', 2, true);


--
-- Data for Name: text; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO text VALUES (1, 'index', 'Главная страница', '<h3>Добро пожаловать!</h3>
<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.&nbsp;</p>
<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>
<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>');
INSERT INTO text VALUES (2, 'header', 'Шапка сайта', '<p>Шапка сайта</p>');
INSERT INTO text VALUES (3, 'footer', 'Подвал сайта', '<p>Подвал сайта</p>');


--
-- Name: text_text_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('text_text_id_seq', 4, true);


--
-- Data for Name: translate; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);


--
-- Name: block_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY block
    ADD CONSTRAINT block_pkey PRIMARY KEY (block_id);


--
-- Name: delivery_message_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delivery_message
    ADD CONSTRAINT delivery_message_pkey PRIMARY KEY (message_id);


--
-- Name: delivery_person_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delivery_person
    ADD CONSTRAINT delivery_person_pkey PRIMARY KEY (person_id);


--
-- Name: delivery_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delivery_queue
    ADD CONSTRAINT delivery_queue_pkey PRIMARY KEY (queue_id);


--
-- Name: delivery_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delivery_storage
    ADD CONSTRAINT delivery_storage_pkey PRIMARY KEY (storage_id);


--
-- Name: dictionary_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dictionary
    ADD CONSTRAINT dictionary_pkey PRIMARY KEY (word_id);


--
-- Name: lang_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lang
    ADD CONSTRAINT lang_pkey PRIMARY KEY (lang_id);


--
-- Name: layout_area_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY layout_area
    ADD CONSTRAINT layout_area_pkey PRIMARY KEY (area_id);


--
-- Name: layout_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY layout
    ADD CONSTRAINT layout_pkey PRIMARY KEY (layout_id);


--
-- Name: menu_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (menu_id);


--
-- Name: module_param_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY module_param
    ADD CONSTRAINT module_param_pkey PRIMARY KEY (param_id);


--
-- Name: module_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY module
    ADD CONSTRAINT module_pkey PRIMARY KEY (module_id);


--
-- Name: news_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_pkey PRIMARY KEY (news_id);


--
-- Name: object_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY object
    ADD CONSTRAINT object_pkey PRIMARY KEY (object_id);


--
-- Name: page_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page_pkey PRIMARY KEY (page_id);


--
-- Name: param_value_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY param_value
    ADD CONSTRAINT param_value_pkey PRIMARY KEY (value_id);


--
-- Name: preference_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY preference
    ADD CONSTRAINT preference_pkey PRIMARY KEY (preference_id);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- Name: text_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY text
    ADD CONSTRAINT text_pkey PRIMARY KEY (text_id);


--
-- PostgreSQL database dump complete
--

