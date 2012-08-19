SET search_path = public, pg_catalog;
DROP TABLE IF EXISTS public.delivery_storage;
DROP SEQUENCE IF EXISTS public.delivery_storage_body_id_seq;
DROP TABLE IF EXISTS public.delivery_queue;
DROP SEQUENCE IF EXISTS public.delivery_queue_queue_id_seq;
DROP TABLE IF EXISTS public.delivery_body;
DROP SEQUENCE IF EXISTS public.delivery_body_body_id_seq;
DROP TABLE IF EXISTS public.delivery_person;
DROP SEQUENCE IF EXISTS public.delivery_person_person_id_seq;
DROP TABLE IF EXISTS public.dictionary;
DROP SEQUENCE IF EXISTS public.dictionary_word_id_seq;
DROP TABLE IF EXISTS public.translate;
DROP TABLE IF EXISTS public.lang;
DROP SEQUENCE IF EXISTS public.lang_lang_id_seq;
DROP TABLE IF EXISTS public.object;
DROP SEQUENCE IF EXISTS public.object_object_id_seq;
DROP TABLE IF EXISTS public.role_object;
DROP TABLE IF EXISTS public.role;
DROP SEQUENCE IF EXISTS public.role_role_id_seq;
DROP TABLE IF EXISTS public.admin_role;
DROP TABLE IF EXISTS public.admin;
DROP SEQUENCE IF EXISTS public.admin_admin_id_seq;
DROP TABLE IF EXISTS public.block_param;
DROP TABLE IF EXISTS public.param_value;
DROP SEQUENCE IF EXISTS public.param_value_value_id_seq;
DROP TABLE IF EXISTS public.module_param;
DROP SEQUENCE IF EXISTS public.module_param_param_id_seq;
DROP TABLE IF EXISTS public.module;
DROP SEQUENCE IF EXISTS public.module_module_id_seq;
DROP TABLE IF EXISTS public.layout_area;
DROP SEQUENCE IF EXISTS public.layout_area_area_id_seq;
DROP TABLE IF EXISTS public.layout;
DROP SEQUENCE IF EXISTS public.layout_layout_id_seq;
DROP TABLE IF EXISTS public.block;
DROP SEQUENCE IF EXISTS public.block_block_id_seq;
DROP TABLE IF EXISTS public.page;
DROP SEQUENCE IF EXISTS public.page_page_id_seq;
DROP TABLE IF EXISTS public.preference;
DROP SEQUENCE IF EXISTS public.preference_preference_id_seq;
DROP TABLE IF EXISTS public.menu;
DROP SEQUENCE IF EXISTS public.menu_menu_id_seq;
DROP TABLE IF EXISTS public.news;
DROP SEQUENCE IF EXISTS public.news_news_id_seq;
DROP TABLE IF EXISTS public.text;
DROP SEQUENCE IF EXISTS public.text_text_id_seq;
SET check_function_bodies = false;
--
-- Definition for sequence text_text_id_seq (OID = 24663) : 
--
CREATE SEQUENCE public.text_text_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table text (OID = 24665) : 
--
CREATE TABLE public.text (
    text_id integer DEFAULT nextval('text_text_id_seq'::regclass) NOT NULL,
    text_tag varchar,
    text_title varchar,
    text_content pg_catalog.text
) WITHOUT OIDS;
--
-- Definition for sequence news_news_id_seq (OID = 24674) : 
--
CREATE SEQUENCE public.news_news_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table news (OID = 24676) : 
--
CREATE TABLE public.news (
    news_id integer DEFAULT nextval('news_news_id_seq'::regclass) NOT NULL,
    news_title varchar,
    news_announce pg_catalog.text,
    news_content pg_catalog.text,
    news_date varchar(14)
) WITHOUT OIDS;
--
-- Definition for sequence menu_menu_id_seq (OID = 24685) : 
--
CREATE SEQUENCE public.menu_menu_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table menu (OID = 24687) : 
--
CREATE TABLE public.menu (
    menu_id integer DEFAULT nextval('menu_menu_id_seq'::regclass) NOT NULL,
    menu_parent integer,
    menu_title varchar,
    menu_page integer,
    menu_url varchar,
    menu_order integer,
    menu_active integer
) WITHOUT OIDS;
--
-- Definition for sequence preference_preference_id_seq (OID = 24696) : 
--
CREATE SEQUENCE public.preference_preference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table preference (OID = 24698) : 
--
CREATE TABLE public.preference (
    preference_id integer DEFAULT nextval('preference_preference_id_seq'::regclass) NOT NULL,
    preference_title varchar,
    preference_name varchar,
    preference_value varchar
) WITHOUT OIDS;
--
-- Definition for sequence page_page_id_seq (OID = 24707) : 
--
CREATE SEQUENCE public.page_page_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table page (OID = 24709) : 
--
CREATE TABLE public.page (
    page_id integer DEFAULT nextval('page_page_id_seq'::regclass) NOT NULL,
    page_parent integer,
    page_layout integer,
    page_title varchar,
    page_name varchar,
    page_folder integer,
    meta_title pg_catalog.text,
    meta_keywords pg_catalog.text,
    meta_description pg_catalog.text,
    page_order integer,
    page_active integer
) WITHOUT OIDS;
--
-- Definition for sequence block_block_id_seq (OID = 24718) : 
--
CREATE SEQUENCE public.block_block_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table block (OID = 24720) : 
--
CREATE TABLE public.block (
    block_id integer DEFAULT nextval('block_block_id_seq'::regclass) NOT NULL,
    block_page integer,
    block_module integer,
    block_title varchar,
    block_area integer
) WITHOUT OIDS;
--
-- Definition for sequence layout_layout_id_seq (OID = 24729) : 
--
CREATE SEQUENCE public.layout_layout_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table layout (OID = 24731) : 
--
CREATE TABLE public.layout (
    layout_id integer DEFAULT nextval('layout_layout_id_seq'::regclass) NOT NULL,
    layout_title varchar,
    layout_name varchar
) WITHOUT OIDS;
--
-- Definition for sequence layout_area_area_id_seq (OID = 24740) : 
--
CREATE SEQUENCE public.layout_area_area_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table layout_area (OID = 24742) : 
--
CREATE TABLE public.layout_area (
    area_id integer DEFAULT nextval('layout_area_area_id_seq'::regclass) NOT NULL,
    area_layout integer,
    area_title varchar,
    area_name varchar,
    area_main integer,
    area_order integer
) WITHOUT OIDS;
--
-- Definition for sequence module_module_id_seq (OID = 24751) : 
--
CREATE SEQUENCE public.module_module_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table module (OID = 24753) : 
--
CREATE TABLE public.module (
    module_id integer DEFAULT nextval('module_module_id_seq'::regclass) NOT NULL,
    module_title varchar,
    module_name varchar
) WITHOUT OIDS;
--
-- Definition for sequence module_param_param_id_seq (OID = 24762) : 
--
CREATE SEQUENCE public.module_param_param_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table module_param (OID = 24764) : 
--
CREATE TABLE public.module_param (
    param_id integer DEFAULT nextval('module_param_param_id_seq'::regclass) NOT NULL,
    param_module integer,
    param_title varchar,
    param_type varchar,
    param_name varchar,
    param_table varchar,
    param_default varchar,
    param_require integer,
    param_order integer
) WITHOUT OIDS;
--
-- Definition for sequence param_value_value_id_seq (OID = 24773) : 
--
CREATE SEQUENCE public.param_value_value_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table param_value (OID = 24775) : 
--
CREATE TABLE public.param_value (
    value_id integer DEFAULT nextval('param_value_value_id_seq'::regclass) NOT NULL,
    value_param integer,
    value_title varchar,
    value_content varchar,
    value_default integer
) WITHOUT OIDS;
--
-- Structure for table block_param (OID = 24784) : 
--
CREATE TABLE public.block_param (
    block integer,
    param integer,
    value pg_catalog.text
) WITHOUT OIDS;
--
-- Definition for sequence admin_admin_id_seq (OID = 24790) : 
--
CREATE SEQUENCE public.admin_admin_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table admin (OID = 24792) : 
--
CREATE TABLE public.admin (
    admin_id integer DEFAULT nextval('admin_admin_id_seq'::regclass) NOT NULL,
    admin_title varchar,
    admin_login varchar,
    admin_password varchar,
    admin_email varchar,
    admin_active integer
) WITHOUT OIDS;
--
-- Structure for table admin_role (OID = 24801) : 
--
CREATE TABLE public.admin_role (
    admin_id integer,
    role_id integer
) WITHOUT OIDS;
--
-- Definition for sequence role_role_id_seq (OID = 24804) : 
--
CREATE SEQUENCE public.role_role_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table role (OID = 24806) : 
--
CREATE TABLE public.role (
    role_id integer DEFAULT nextval('role_role_id_seq'::regclass) NOT NULL,
    role_title varchar,
    role_default integer
) WITHOUT OIDS;
--
-- Structure for table role_object (OID = 24815) : 
--
CREATE TABLE public.role_object (
    role_id integer,
    object_id integer
) WITHOUT OIDS;
--
-- Definition for sequence object_object_id_seq (OID = 24818) : 
--
CREATE SEQUENCE public.object_object_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table object (OID = 24820) : 
--
CREATE TABLE public.object (
    object_id integer DEFAULT nextval('object_object_id_seq'::regclass) NOT NULL,
    object_parent integer,
    object_title varchar,
    object_name varchar,
    object_order integer,
    object_active integer
) WITHOUT OIDS;
--
-- Definition for sequence lang_lang_id_seq (OID = 24829) : 
--
CREATE SEQUENCE public.lang_lang_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table lang (OID = 24831) : 
--
CREATE TABLE public.lang (
    lang_id integer DEFAULT nextval('lang_lang_id_seq'::regclass) NOT NULL,
    lang_title varchar,
    lang_short varchar,
    lang_name varchar,
    lang_default integer
) WITHOUT OIDS;
--
-- Structure for table translate (OID = 24840) : 
--
CREATE TABLE public.translate (
    table_name varchar,
    field_name varchar,
    table_record integer,
    record_lang integer,
    record_value pg_catalog.text
) WITHOUT OIDS;
--
-- Definition for sequence dictionary_word_id_seq (OID = 24846) : 
--
CREATE SEQUENCE public.dictionary_word_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table dictionary (OID = 24848) : 
--
CREATE TABLE public.dictionary (
    word_id integer DEFAULT nextval('dictionary_word_id_seq'::regclass) NOT NULL,
    word_name varchar,
    word_value varchar
) WITHOUT OIDS;
--
-- Definition for sequence delivery_person_person_id_seq (OID = 24857) : 
--
CREATE SEQUENCE public.delivery_person_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table delivery_person (OID = 24859) : 
--
CREATE TABLE public.delivery_person (
    person_id integer DEFAULT nextval('delivery_person_person_id_seq'::regclass) NOT NULL,
    person_email varchar,
    person_admin integer
) WITHOUT OIDS;
--
-- Definition for sequence delivery_body_body_id_seq (OID = 24868) : 
--
CREATE SEQUENCE public.delivery_body_body_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table delivery_body (OID = 24870) : 
--
CREATE TABLE public.delivery_body (
    body_id integer DEFAULT nextval('delivery_body_body_id_seq'::regclass) NOT NULL,
    body_headers pg_catalog.text,
    body_text pg_catalog.text
) WITHOUT OIDS;
--
-- Definition for sequence delivery_queue_queue_id_seq (OID = 24879) : 
--
CREATE SEQUENCE public.delivery_queue_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table delivery_queue (OID = 24881) : 
--
CREATE TABLE public.delivery_queue (
    queue_id integer DEFAULT nextval('delivery_queue_queue_id_seq'::regclass) NOT NULL,
    queue_body integer,
    queue_person integer
) WITHOUT OIDS;
--
-- Definition for sequence delivery_storage_body_id_seq (OID = 24887) : 
--
CREATE SEQUENCE public.delivery_storage_body_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table delivery_storage (OID = 24889) : 
--
CREATE TABLE public.delivery_storage (
    body_id integer DEFAULT nextval('delivery_storage_body_id_seq'::regclass) NOT NULL,
    body_subject varchar,
    body_email varchar,
    body_name varchar,
    body_text pg_catalog.text
) WITHOUT OIDS;
--
-- Data for table public.text (OID = 24665) (LIMIT 0,2)
--
INSERT INTO text (text_id, text_tag, text_title, text_content)
VALUES (1, 'index', 'Главная страница', '<h3>
	Добро пожаловать!</h3>
<p>
	Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.&nbsp;</p>
<p>
	Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>
<p>
	Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>
');

INSERT INTO text (text_id, text_tag, text_title, text_content)
VALUES (2, '404', 'Ошибка 404', '<h1 style="text-align: center; ">
	&nbsp;</h1>
<h1 style="text-align: center; ">
	<span style="font-size: 48px; ">404</span></h1>
<p style="text-align: center; ">
	Страница не найдена</p>
');

--
-- Data for table public.news (OID = 24676) (LIMIT 0,3)
--
INSERT INTO news (news_id, news_title, news_announce, news_content, news_date)
VALUES (1, 'Почему самопроизвольно стратегическое планирование?', '<p>
	Пентатоника синхронизирует тактический уровень грунтовых вод.&nbsp;</p>
', '<p>
	Пентатоника синхронизирует тактический уровень грунтовых вод, здесь описывается централизующий процесс или создание нового центра личности. Понятие тоталитаризма абсурдно отклоняет постиндустриализм, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате &quot;О старости&quot; (De senectute). Англо-американский тип политической культуры выбирает валютный гидрогенит, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани. Вместе с тем, сервитут традиционно заряжает плоскостной минерал, туда же входят 39 графств, 6 метрополитенских графств и Большой Лондон.</p>
<p>
	В первом приближении нередуцируемость содержания интегрирует конструктивный уход гироскопа, хотя законодательством может быть установлено иное. Иными словами, чувство растворимо определяет антарктический пояс, день этот пришелся на двадцать шестое число месяца карнея, который у афинян называется метагитнионом. Таргетирование упорядочивает наносекундный хтонический миф, хотя это довольно часто напоминает песни Джима Моррисона и Патти Смит. Песня &quot;All The Things She Said&quot; (в русском варианте - &quot;Я сошла с ума&quot;) готично просветляет культурный топаз, учитывая недостаточную теоретическую проработанность этой отрасли права. Ведущий экзогенный геологический процесс - угол курса возбуждает двойной интеграл, откуда следует доказываемое равенство. Как было показано выше, кредитор синфазно осознаёт гидроузел, это и есть всемирно известный центр огранки алмазов и торговли бриллиантами.</p>
<p>
	Декодирование программирует героический миф вне зависимости от предсказаний самосогласованной теоретической модели явления. Зенитное часовое число волнообразно. Большая Медведица представляет собой потребительский штопор, хотя на первый взгляд, российские власти тут ни при чем. Психоанализ, вследствие пространственной неоднородности почвенного покрова, одномерно возбуждает конструктивный механизм власти, исключая принцип презумпции невиновности. Афелий сменяет октавер, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани.</p>
', '20091001111000');

INSERT INTO news (news_id, news_title, news_announce, news_content, news_date)
VALUES (2, 'Институциональный эскапизм: гипотеза и теории', '<p>
	Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности.&nbsp;</p>
', '<p>
	Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности, перейдя к исследованию устойчивости линейных гироскопических систем с искусственными силами. Механическая система, несмотря на внешние воздействия, рефлектирует сублимированный архетип, кроме этого, здесь есть ценнейшие коллекции мексиканских масок, бронзовые и каменные статуи из Индии и Цейлона, бронзовые барельефы и изваяния, созданные мастерами Экваториальной Африки пять-шесть веков назад. Рекламная заставка вертикально титрует феномер &quot;психической мутации&quot;, что не влияет при малых значениях коэффициента податливости. Рисчоррит, следовательно, облучает конструктивный друмлин, изменяя привычную реальность. Непосредственно из законов сохранения следует, что собственное подмножество однородно отражает феноменологический цикл, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.</p>
<p>
	Адаптация экономит медийный канал, потому что сюжет и фабула различаются. Несомненно, ортогональный определитель латентно принимает во внимание символический метафоризм, откуда следует доказываемое равенство. Портер выстраивает урбанистический пласт, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Межледниковье многопланово заставляет перейти к более сложной системе дифференциальных уравнений, если добавить комплекс, где присутствуют моренные суглинки днепровского возраста. Александрийская школа ускоряет институциональный крен, что-то подобное можно встретить в работах Ауэрбаха и Тандлера.</p>
<p>
	Стихотворение спорадически вызывает генетический математический анализ, подобный исследовательский подход к проблемам художественной типологии можно обнаружить у К.Фосслера. Земная группа формировалась ближе к Солнцу, однако реальная власть диссонирует тройной интеграл в полном соответствии с законом сохранения энергии. Субтехника, как можно показать с помощью не совсем тривиальных вычислений, кристалично выводит выход целевого продукта, что-то подобное можно встретить в работах Ауэрбаха и Тандлера. Еще до момента заключения договора портер приводит вибрирующий сушильный шкаф, что не влияет при малых значениях коэффициента податливости. Хлорсульфит натрия эволюционирует в институциональный ионообменник независимо от последствий проникновения метилкарбиола внутрь.</p>
', '20091002111200');

INSERT INTO news (news_id, news_title, news_announce, news_content, news_date)
VALUES (3, 'Валентный электрон как полнолуние', '<p>
	Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы.&nbsp;</p>
', '<p>
	Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы. Математическое моделирование однозначно показывает, что зачин порождает и обеспечивает примитивный черный эль, но никакие ухищрения экспериментаторов не позволят наблюдать этот эффект в видимом диапазоне. Интерпретация жестко совершает астероидный ревер, хотя этот факт нуждается в дальнейшей тщательной экспериментальной проверке. Иными словами, пространственно-временная организация многопланово индуцирует электролиз, исходя из суммы моментов.</p>
<p>
	Производство зерна и зернобобовых ищет интеллект, такого мнения придерживаются многие депутаты Государственной Думы. Интеллект просветляет коллоидный катод, таким образом, второй комплекс движущих сил получил разработку в трудах А. Берталанфи и Ш. Бюлера. Апперцепция, согласно традиционным представлениям, по-прежнему востребована. Осушение, как бы это ни казалось парадоксальным, вызывает маятник Фуко, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км. Алеаторика, общеизвестно, перемещает принцип восприятия, при этом буквы А, В, I, О символизируют соответственно общеутвердительное, общеотрицательное, частноутвердительное и частноотрицательное суждения. Доминантсептаккорд, в согласии с традиционными представлениями, требует большего внимания к анализу ошибок, которые даёт акцепт только в отсутствие тепло- и массообмена с окружающей средой.</p>
<p>
	Фудзияма, несмотря на внешние воздействия, ментально начинает анимус, повышая конкуренцию. Индуцированное соответствие постоянно. Вещь в себе, как следует из вышесказанного, противозаконно разъедает метод последовательных приближений, что лишний раз подтверждает правоту З. Фрейда. Магнитное наклонение, очевидно, нивелирует пирогенный комплекс агрессивности, о чем и писал А. Маслоу в своей работе &quot;Мотивация и личность&quot;.</p>
', '20091003111300');

--
-- Data for table public.menu (OID = 24687) (LIMIT 0,4)
--
INSERT INTO menu (menu_id, menu_parent, menu_title, menu_page, menu_url, menu_order, menu_active)
VALUES (1, 0, 'Главное меню', 0, '', 1, 1);

INSERT INTO menu (menu_id, menu_parent, menu_title, menu_page, menu_url, menu_order, menu_active)
VALUES (2, 1, 'Главная', 1, '', 1, 1);

INSERT INTO menu (menu_id, menu_parent, menu_title, menu_page, menu_url, menu_order, menu_active)
VALUES (3, 1, 'Новости', 3, '', 2, 1);

INSERT INTO menu (menu_id, menu_parent, menu_title, menu_page, menu_url, menu_order, menu_active)
VALUES (4, 1, 'Ссылка', 0, 'http://adminko.testea.ru/', 3, 1);

--
-- Data for table public.page (OID = 24709) (LIMIT 0,3)
--
INSERT INTO page (page_id, page_parent, page_layout, page_title, page_name, page_folder, meta_title, meta_keywords, meta_description, page_order, page_active)
VALUES (1, 0, 1, 'Главная страница', '', 0, 'Заголовок главной страницы', 'Ключевые слова главной страницы', 'Описание главной страницы', 1, 1);

INSERT INTO page (page_id, page_parent, page_layout, page_title, page_name, page_folder, meta_title, meta_keywords, meta_description, page_order, page_active)
VALUES (2, 1, 3, 'Ошибка 404', '404', 0, 'Страница не найдена', 'Страница не найдена', 'Страница не найдена', 2, 1);

INSERT INTO page (page_id, page_parent, page_layout, page_title, page_name, page_folder, meta_title, meta_keywords, meta_description, page_order, page_active)
VALUES (3, 1, 2, 'Новости', 'news', 0, 'Заголовок внутренней страницы', 'Ключевые слова внутренней страницы', 'Описание внутренней страницы', 1, 1);

--
-- Data for table public.block (OID = 24720) (LIMIT 0,6)
--
INSERT INTO block (block_id, block_page, block_module, block_title, block_area)
VALUES (1, 1, 1, 'Текст на главной странице', 1);

INSERT INTO block (block_id, block_page, block_module, block_title, block_area)
VALUES (2, 1, 3, 'Главное меню', 4);

INSERT INTO block (block_id, block_page, block_module, block_title, block_area)
VALUES (3, 1, 2, 'Краткий список новостей', 6);

INSERT INTO block (block_id, block_page, block_module, block_title, block_area)
VALUES (4, 3, 2, 'Полный список новостей', 2);

INSERT INTO block (block_id, block_page, block_module, block_title, block_area)
VALUES (5, 3, 3, 'Главное меню', 5);

INSERT INTO block (block_id, block_page, block_module, block_title, block_area)
VALUES (6, 2, 1, 'Сообщение об ошибке', 3);

--
-- Data for table public.layout (OID = 24731) (LIMIT 0,3)
--
INSERT INTO layout (layout_id, layout_title, layout_name)
VALUES (1, 'Шаблон главной страницы', 'index');

INSERT INTO layout (layout_id, layout_title, layout_name)
VALUES (2, 'Шаблон внутренних страниц', 'default');

INSERT INTO layout (layout_id, layout_title, layout_name)
VALUES (3, 'Шаблон для страницы ошибок', 'simple');

--
-- Data for table public.layout_area (OID = 24742) (LIMIT 0,6)
--
INSERT INTO layout_area (area_id, area_layout, area_title, area_name, area_main, area_order)
VALUES (1, 1, 'Контентная область', 'content', 1, 1);

INSERT INTO layout_area (area_id, area_layout, area_title, area_name, area_main, area_order)
VALUES (2, 2, 'Контентная область', 'content', 1, 1);

INSERT INTO layout_area (area_id, area_layout, area_title, area_name, area_main, area_order)
VALUES (3, 3, 'Контентная область', 'content', 1, 1);

INSERT INTO layout_area (area_id, area_layout, area_title, area_name, area_main, area_order)
VALUES (4, 1, 'Главное меню', 'menu', 0, 2);

INSERT INTO layout_area (area_id, area_layout, area_title, area_name, area_main, area_order)
VALUES (5, 2, 'Главное меню', 'menu', 0, 2);

INSERT INTO layout_area (area_id, area_layout, area_title, area_name, area_main, area_order)
VALUES (6, 1, 'Новостной блок', 'news', 0, 3);

--
-- Data for table public.module (OID = 24753) (LIMIT 0,3)
--
INSERT INTO module (module_id, module_title, module_name)
VALUES (1, 'Текст', 'text');

INSERT INTO module (module_id, module_title, module_name)
VALUES (2, 'Новости', 'news');

INSERT INTO module (module_id, module_title, module_name)
VALUES (3, 'Меню', 'menu');

--
-- Data for table public.module_param (OID = 24764) (LIMIT 0,5)
--
INSERT INTO module_param (param_id, param_module, param_title, param_type, param_name, param_table, param_default, param_require, param_order)
VALUES (1, 1, 'Текст в блоке', 'table', 'id', 'text', '', 1, 1);

INSERT INTO module_param (param_id, param_module, param_title, param_type, param_name, param_table, param_default, param_require, param_order)
VALUES (2, 2, 'Вариант использования', 'select', 'action', '', '', 0, 1);

INSERT INTO module_param (param_id, param_module, param_title, param_type, param_name, param_table, param_default, param_require, param_order)
VALUES (3, 2, 'Количество новостей на странице', 'int', 'count', '', '10', 1, 2);

INSERT INTO module_param (param_id, param_module, param_title, param_type, param_name, param_table, param_default, param_require, param_order)
VALUES (4, 3, 'Меню в блоке', 'table', 'id', 'menu', '', 1, 1);

INSERT INTO module_param (param_id, param_module, param_title, param_type, param_name, param_table, param_default, param_require, param_order)
VALUES (5, 3, 'Шаблон меню', 'select', 'template', '', '', 1, 2);

--
-- Data for table public.param_value (OID = 24775) (LIMIT 0,3)
--
INSERT INTO param_value (value_id, value_param, value_title, value_content, value_default)
VALUES (1, 2, 'Полный список', 'index', 0);

INSERT INTO param_value (value_id, value_param, value_title, value_content, value_default)
VALUES (2, 2, 'Краткий список', 'preview', 1);

INSERT INTO param_value (value_id, value_param, value_title, value_content, value_default)
VALUES (3, 5, 'Главное меню', 'main', 1);

--
-- Data for table public.block_param (OID = 24784) (LIMIT 0,10)
--
INSERT INTO block_param (block, param, value)
VALUES (5, 4, '1');

INSERT INTO block_param (block, param, value)
VALUES (5, 5, '3');

INSERT INTO block_param (block, param, value)
VALUES (3, 2, '2');

INSERT INTO block_param (block, param, value)
VALUES (3, 3, '3');

INSERT INTO block_param (block, param, value)
VALUES (4, 2, '1');

INSERT INTO block_param (block, param, value)
VALUES (4, 3, '10');

INSERT INTO block_param (block, param, value)
VALUES (6, 1, '2');

INSERT INTO block_param (block, param, value)
VALUES (1, 1, '1');

INSERT INTO block_param (block, param, value)
VALUES (2, 4, '1');

INSERT INTO block_param (block, param, value)
VALUES (2, 5, '3');

--
-- Data for table public.admin (OID = 24792) (LIMIT 0,1)
--
INSERT INTO admin (admin_id, admin_title, admin_login, admin_password, admin_email, admin_active)
VALUES (1, 'Главный администратор', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@example.ru', 1);

--
-- Data for table public.admin_role (OID = 24801) (LIMIT 0,1)
--
INSERT INTO admin_role (admin_id, role_id)
VALUES (1, 1);

--
-- Data for table public.role (OID = 24806) (LIMIT 0,1)
--
INSERT INTO role (role_id, role_title, role_default)
VALUES (1, 'Главный администратор', 1);

--
-- Data for table public.object (OID = 24820) (LIMIT 0,23)
--
INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (1, 0, 'Контент', '', 1, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (2, 1, 'Тексты', 'text', 1, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (3, 1, 'Новости', 'news', 2, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (4, 0, 'Сайт', '', 2, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (5, 4, 'Разделы', 'page', 1, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (6, 4, 'Блоки', 'block', 2, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (7, 4, 'Шаблоны', 'layout', 3, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (8, 4, 'Модули', 'module', 5, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (9, 4, 'Параметры модулей', 'module_param', 6, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (10, 4, 'Значения параметров модулей', 'param_value', 7, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (11, 0, 'Система', '', 3, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (12, 11, 'Языки', 'lang', 1, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (13, 11, 'Настройки', 'preference', 2, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (14, 11, 'Системные слова', 'dictionary', 3, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (15, 11, 'Системные разделы', 'object', 4, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (16, 11, 'Администраторы', 'admin', 5, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (17, 0, 'Утилиты', '', 4, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (18, 17, 'Файл-менеджер', 'fm', 1, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (19, 17, 'Почтовая рассылка', 'delivery', 2, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (20, 1, 'Меню', 'menu', 3, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (21, 4, 'Области шаблонов', 'layout_area', 4, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (22, 11, 'Роли', 'role', 6, 1);

INSERT INTO object (object_id, object_parent, object_title, object_name, object_order, object_active)
VALUES (23, 17, 'Лист рассылки', 'delivery_person', 3, 1);

--
-- Data for table public.lang (OID = 24831) (LIMIT 0,2)
--
INSERT INTO lang (lang_id, lang_title, lang_short, lang_name, lang_default)
VALUES (1, 'Русский', 'Рус', 'ru', 1);

INSERT INTO lang (lang_id, lang_title, lang_short, lang_name, lang_default)
VALUES (2, 'Английский', 'Eng', 'en', 0);

--
-- Definition for index text_pkey (OID = 24672) : 
--
ALTER TABLE ONLY text
    ADD CONSTRAINT text_pkey PRIMARY KEY (text_id);
--
-- Definition for index news_pkey (OID = 24683) : 
--
ALTER TABLE ONLY news
    ADD CONSTRAINT news_pkey PRIMARY KEY (news_id);
--
-- Definition for index menu_pkey (OID = 24694) : 
--
ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (menu_id);
--
-- Definition for index preference_pkey (OID = 24705) : 
--
ALTER TABLE ONLY preference
    ADD CONSTRAINT preference_pkey PRIMARY KEY (preference_id);
--
-- Definition for index page_pkey (OID = 24716) : 
--
ALTER TABLE ONLY page
    ADD CONSTRAINT page_pkey PRIMARY KEY (page_id);
--
-- Definition for index block_pkey (OID = 24727) : 
--
ALTER TABLE ONLY block
    ADD CONSTRAINT block_pkey PRIMARY KEY (block_id);
--
-- Definition for index layout_pkey (OID = 24738) : 
--
ALTER TABLE ONLY layout
    ADD CONSTRAINT layout_pkey PRIMARY KEY (layout_id);
--
-- Definition for index layout_area_pkey (OID = 24749) : 
--
ALTER TABLE ONLY layout_area
    ADD CONSTRAINT layout_area_pkey PRIMARY KEY (area_id);
--
-- Definition for index module_pkey (OID = 24760) : 
--
ALTER TABLE ONLY module
    ADD CONSTRAINT module_pkey PRIMARY KEY (module_id);
--
-- Definition for index module_param_pkey (OID = 24771) : 
--
ALTER TABLE ONLY module_param
    ADD CONSTRAINT module_param_pkey PRIMARY KEY (param_id);
--
-- Definition for index param_value_pkey (OID = 24782) : 
--
ALTER TABLE ONLY param_value
    ADD CONSTRAINT param_value_pkey PRIMARY KEY (value_id);
--
-- Definition for index admin_pkey (OID = 24799) : 
--
ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);
--
-- Definition for index role_pkey (OID = 24813) : 
--
ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);
--
-- Definition for index object_pkey (OID = 24827) : 
--
ALTER TABLE ONLY object
    ADD CONSTRAINT object_pkey PRIMARY KEY (object_id);
--
-- Definition for index lang_pkey (OID = 24838) : 
--
ALTER TABLE ONLY lang
    ADD CONSTRAINT lang_pkey PRIMARY KEY (lang_id);
--
-- Definition for index dictionary_pkey (OID = 24855) : 
--
ALTER TABLE ONLY dictionary
    ADD CONSTRAINT dictionary_pkey PRIMARY KEY (word_id);
--
-- Definition for index delivery_person_pkey (OID = 24866) : 
--
ALTER TABLE ONLY delivery_person
    ADD CONSTRAINT delivery_person_pkey PRIMARY KEY (person_id);
--
-- Definition for index delivery_body_pkey (OID = 24877) : 
--
ALTER TABLE ONLY delivery_body
    ADD CONSTRAINT delivery_body_pkey PRIMARY KEY (body_id);
--
-- Definition for index delivery_queue_pkey (OID = 24885) : 
--
ALTER TABLE ONLY delivery_queue
    ADD CONSTRAINT delivery_queue_pkey PRIMARY KEY (queue_id);
--
-- Definition for index delivery_storage_pkey (OID = 24896) : 
--
ALTER TABLE ONLY delivery_storage
    ADD CONSTRAINT delivery_storage_pkey PRIMARY KEY (body_id);
--
-- Data for sequence public.text_text_id_seq (OID = 24663)
--
SELECT pg_catalog.setval('text_text_id_seq', 3, true);
--
-- Data for sequence public.news_news_id_seq (OID = 24674)
--
SELECT pg_catalog.setval('news_news_id_seq', 4, true);
--
-- Data for sequence public.menu_menu_id_seq (OID = 24685)
--
SELECT pg_catalog.setval('menu_menu_id_seq', 5, true);
--
-- Data for sequence public.preference_preference_id_seq (OID = 24696)
--
SELECT pg_catalog.setval('preference_preference_id_seq', 1, false);
--
-- Data for sequence public.page_page_id_seq (OID = 24707)
--
SELECT pg_catalog.setval('page_page_id_seq', 4, true);
--
-- Data for sequence public.block_block_id_seq (OID = 24718)
--
SELECT pg_catalog.setval('block_block_id_seq', 7, true);
--
-- Data for sequence public.layout_layout_id_seq (OID = 24729)
--
SELECT pg_catalog.setval('layout_layout_id_seq', 4, true);
--
-- Data for sequence public.layout_area_area_id_seq (OID = 24740)
--
SELECT pg_catalog.setval('layout_area_area_id_seq', 7, true);
--
-- Data for sequence public.module_module_id_seq (OID = 24751)
--
SELECT pg_catalog.setval('module_module_id_seq', 4, true);
--
-- Data for sequence public.module_param_param_id_seq (OID = 24762)
--
SELECT pg_catalog.setval('module_param_param_id_seq', 6, true);
--
-- Data for sequence public.param_value_value_id_seq (OID = 24773)
--
SELECT pg_catalog.setval('param_value_value_id_seq', 6, true);
--
-- Data for sequence public.admin_admin_id_seq (OID = 24790)
--
SELECT pg_catalog.setval('admin_admin_id_seq', 2, true);
--
-- Data for sequence public.role_role_id_seq (OID = 24804)
--
SELECT pg_catalog.setval('role_role_id_seq', 2, true);
--
-- Data for sequence public.object_object_id_seq (OID = 24818)
--
SELECT pg_catalog.setval('object_object_id_seq', 24, true);
--
-- Data for sequence public.lang_lang_id_seq (OID = 24829)
--
SELECT pg_catalog.setval('lang_lang_id_seq', 3, true);
--
-- Data for sequence public.dictionary_word_id_seq (OID = 24846)
--
SELECT pg_catalog.setval('dictionary_word_id_seq', 1, false);
--
-- Data for sequence public.delivery_person_person_id_seq (OID = 24857)
--
SELECT pg_catalog.setval('delivery_person_person_id_seq', 1, false);
--
-- Data for sequence public.delivery_body_body_id_seq (OID = 24868)
--
SELECT pg_catalog.setval('delivery_body_body_id_seq', 1, false);
--
-- Data for sequence public.delivery_queue_queue_id_seq (OID = 24879)
--
SELECT pg_catalog.setval('delivery_queue_queue_id_seq', 1, false);
--
-- Data for sequence public.delivery_storage_body_id_seq (OID = 24887)
--
SELECT pg_catalog.setval('delivery_storage_body_id_seq', 1, false);
