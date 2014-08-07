PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE admin (
  admin_id integer PRIMARY KEY autoincrement,
  admin_title varchar NOT NULL default '',
  admin_login varchar NOT NULL default '',
  admin_password varchar NOT NULL default '',
  admin_email varchar NOT NULL default '',
  admin_active integer NOT NULL default '0'
);
INSERT INTO "admin" VALUES(1,'Главный администратор','admin','21232f297a57a5a743894a0e4a801fc3','admin@example.ru',1);
CREATE TABLE admin_role (
  admin_id integer NOT NULL default '0',
  role_id integer NOT NULL default '0'
);
INSERT INTO "admin_role" VALUES(1,1);
CREATE TABLE block (
  block_id integer PRIMARY KEY autoincrement,
  block_page integer NOT NULL default '0',
  block_module integer NOT NULL default '0',
  block_title varchar NOT NULL default '',
  block_area integer NOT NULL default '0'
);
INSERT INTO "block" VALUES(1,1,1,'Текст на главной странице',1);
INSERT INTO "block" VALUES(2,1,3,'Главное меню',3);
INSERT INTO "block" VALUES(3,1,2,'Краткий список новостей',5);
INSERT INTO "block" VALUES(4,2,2,'Полный список новостей',2);
INSERT INTO "block" VALUES(5,2,3,'Главное меню',4);
CREATE TABLE block_param (
  block integer NOT NULL default '0',
  param integer NOT NULL default '0',
  value text
);
INSERT INTO "block_param" VALUES(5,4,'1');
INSERT INTO "block_param" VALUES(5,5,'3');
INSERT INTO "block_param" VALUES(3,2,'2');
INSERT INTO "block_param" VALUES(3,3,'3');
INSERT INTO "block_param" VALUES(4,2,'1');
INSERT INTO "block_param" VALUES(4,3,'10');
INSERT INTO "block_param" VALUES(1,1,'1');
INSERT INTO "block_param" VALUES(2,4,'1');
INSERT INTO "block_param" VALUES(2,5,'3');
CREATE TABLE delivery_message (
  message_id integer PRIMARY KEY autoincrement,
  message_content text
);
CREATE TABLE delivery_person (
  person_id integer PRIMARY KEY autoincrement,
  person_email varchar NOT NULL default '',
  person_admin integer NOT NULL default '0'
);
CREATE TABLE delivery_queue (
  queue_id integer PRIMARY KEY autoincrement,
  queue_message integer NOT NULL default '0',
  queue_person integer NOT NULL default '0'
);
CREATE TABLE delivery_storage (
  storage_id integer PRIMARY KEY autoincrement,
  storage_subject varchar NOT NULL default '',
  storage_email varchar NOT NULL default '',
  storage_name varchar NOT NULL default '',
  storage_body text
);
CREATE TABLE dictionary (
  word_id integer PRIMARY KEY autoincrement,
  word_name varchar NOT NULL default '',
  word_value varchar NOT NULL default ''
);
CREATE TABLE lang (
  lang_id integer PRIMARY KEY autoincrement,
  lang_title varchar NOT NULL default '',
  lang_short varchar NOT NULL default '',
  lang_name varchar NOT NULL default '',
  lang_default integer NOT NULL default '0'
);
INSERT INTO "lang" VALUES(1,'Русский','Рус','ru',1);
INSERT INTO "lang" VALUES(2,'Английский','Eng','en',0);
CREATE TABLE layout (
  layout_id integer PRIMARY KEY autoincrement,
  layout_title varchar NOT NULL default '',
  layout_name varchar NOT NULL default ''
);
INSERT INTO "layout" VALUES(1,'Шаблон главной страницы','index');
INSERT INTO "layout" VALUES(2,'Шаблон внутренних страниц','default');
CREATE TABLE layout_area (
  area_id integer PRIMARY KEY autoincrement,
  area_layout integer NOT NULL default '0',
  area_title varchar NOT NULL default '',
  area_name varchar NOT NULL default '',
  area_main integer NOT NULL default '0',
  area_order integer NOT NULL default '0'
);
INSERT INTO "layout_area" VALUES(1,1,'Контентная область','content',1,1);
INSERT INTO "layout_area" VALUES(2,2,'Контентная область','content',1,1);
INSERT INTO "layout_area" VALUES(3,1,'Главное меню','menu',0,2);
INSERT INTO "layout_area" VALUES(4,2,'Главное меню','menu',0,2);
INSERT INTO "layout_area" VALUES(5,1,'Новостной блок','news',0,3);
CREATE TABLE menu (
  menu_id integer PRIMARY KEY autoincrement,
  menu_parent integer NOT NULL default '0',
  menu_title varchar NOT NULL default '',
  menu_page integer NOT NULL default '0',
  menu_url varchar NOT NULL default '',
  menu_order integer NOT NULL default '0',
  menu_active integer NOT NULL default '0'
);
INSERT INTO "menu" VALUES(1,0,'Главное меню',0,'',1,1);
INSERT INTO "menu" VALUES(2,1,'Главная',1,'',1,1);
INSERT INTO "menu" VALUES(3,2,'Новости',2,'',1,1);
INSERT INTO "menu" VALUES(4,1,'Ссылка',0,'http://adminko.testea.ru/',3,1);
CREATE TABLE module (
  module_id integer PRIMARY KEY autoincrement,
  module_title varchar NOT NULL default '',
  module_name varchar NOT NULL default ''
);
INSERT INTO "module" VALUES(1,'Текст','text');
INSERT INTO "module" VALUES(2,'Новости','news');
INSERT INTO "module" VALUES(3,'Меню','menu');
CREATE TABLE module_param (
  param_id integer PRIMARY KEY autoincrement,
  param_module integer NOT NULL default '0',
  param_title varchar NOT NULL default '',
  param_type varchar NOT NULL default '',
  param_name varchar NOT NULL default '',
  param_table varchar NOT NULL default '',
  param_default varchar NOT NULL default '',
  param_require integer NOT NULL default '0',
  param_order integer NOT NULL default '0'
);
INSERT INTO "module_param" VALUES(1,1,'Текст в блоке','table','id','text','',1,1);
INSERT INTO "module_param" VALUES(2,2,'Вариант использования','select','action','','',0,1);
INSERT INTO "module_param" VALUES(3,2,'Количество новостей на странице','int','count','','10',1,2);
INSERT INTO "module_param" VALUES(4,3,'Меню в блоке','table','id','menu','',1,1);
INSERT INTO "module_param" VALUES(5,3,'Шаблон меню','select','template','','',1,2);
CREATE TABLE news (
  news_id integer PRIMARY KEY autoincrement,
  news_title varchar NOT NULL default '',
  news_announce text,
  news_content text,
  news_date varchar(14) NOT NULL default ''
);
INSERT INTO "news" VALUES(1,'Почему самопроизвольно стратегическое планирование?','<p>
	Пентатоника синхронизирует тактический уровень грунтовых вод.&nbsp;</p>
','<p>
	Пентатоника синхронизирует тактический уровень грунтовых вод, здесь описывается централизующий процесс или создание нового центра личности. Понятие тоталитаризма абсурдно отклоняет постиндустриализм, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате &quot;О старости&quot; (De senectute). Англо-американский тип политической культуры выбирает валютный гидрогенит, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани. Вместе с тем, сервитут традиционно заряжает плоскостной минерал, туда же входят 39 графств, 6 метрополитенских графств и Большой Лондон.</p>
<p>
	В первом приближении нередуцируемость содержания интегрирует конструктивный уход гироскопа, хотя законодательством может быть установлено иное. Иными словами, чувство растворимо определяет антарктический пояс, день этот пришелся на двадцать шестое число месяца карнея, который у афинян называется метагитнионом. Таргетирование упорядочивает наносекундный хтонический миф, хотя это довольно часто напоминает песни Джима Моррисона и Патти Смит. Песня &quot;All The Things She Said&quot; (в русском варианте - &quot;Я сошла с ума&quot;) готично просветляет культурный топаз, учитывая недостаточную теоретическую проработанность этой отрасли права. Ведущий экзогенный геологический процесс - угол курса возбуждает двойной интеграл, откуда следует доказываемое равенство. Как было показано выше, кредитор синфазно осознаёт гидроузел, это и есть всемирно известный центр огранки алмазов и торговли бриллиантами.</p>
<p>
	Декодирование программирует героический миф вне зависимости от предсказаний самосогласованной теоретической модели явления. Зенитное часовое число волнообразно. Большая Медведица представляет собой потребительский штопор, хотя на первый взгляд, российские власти тут ни при чем. Психоанализ, вследствие пространственной неоднородности почвенного покрова, одномерно возбуждает конструктивный механизм власти, исключая принцип презумпции невиновности. Афелий сменяет октавер, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани.</p>
','20091001111000');
INSERT INTO "news" VALUES(2,'Институциональный эскапизм: гипотеза и теории','<p>
	Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности.&nbsp;</p>
','<p>
	Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности, перейдя к исследованию устойчивости линейных гироскопических систем с искусственными силами. Механическая система, несмотря на внешние воздействия, рефлектирует сублимированный архетип, кроме этого, здесь есть ценнейшие коллекции мексиканских масок, бронзовые и каменные статуи из Индии и Цейлона, бронзовые барельефы и изваяния, созданные мастерами Экваториальной Африки пять-шесть веков назад. Рекламная заставка вертикально титрует феномер &quot;психической мутации&quot;, что не влияет при малых значениях коэффициента податливости. Рисчоррит, следовательно, облучает конструктивный друмлин, изменяя привычную реальность. Непосредственно из законов сохранения следует, что собственное подмножество однородно отражает феноменологический цикл, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.</p>
<p>
	Адаптация экономит медийный канал, потому что сюжет и фабула различаются. Несомненно, ортогональный определитель латентно принимает во внимание символический метафоризм, откуда следует доказываемое равенство. Портер выстраивает урбанистический пласт, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Межледниковье многопланово заставляет перейти к более сложной системе дифференциальных уравнений, если добавить комплекс, где присутствуют моренные суглинки днепровского возраста. Александрийская школа ускоряет институциональный крен, что-то подобное можно встретить в работах Ауэрбаха и Тандлера.</p>
<p>
	Стихотворение спорадически вызывает генетический математический анализ, подобный исследовательский подход к проблемам художественной типологии можно обнаружить у К.Фосслера. Земная группа формировалась ближе к Солнцу, однако реальная власть диссонирует тройной интеграл в полном соответствии с законом сохранения энергии. Субтехника, как можно показать с помощью не совсем тривиальных вычислений, кристалично выводит выход целевого продукта, что-то подобное можно встретить в работах Ауэрбаха и Тандлера. Еще до момента заключения договора портер приводит вибрирующий сушильный шкаф, что не влияет при малых значениях коэффициента податливости. Хлорсульфит натрия эволюционирует в институциональный ионообменник независимо от последствий проникновения метилкарбиола внутрь.</p>
','20091002111200');
INSERT INTO "news" VALUES(3,'Валентный электрон как полнолуние','<p>
	Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы.&nbsp;</p>
','<p>
	Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы. Математическое моделирование однозначно показывает, что зачин порождает и обеспечивает примитивный черный эль, но никакие ухищрения экспериментаторов не позволят наблюдать этот эффект в видимом диапазоне. Интерпретация жестко совершает астероидный ревер, хотя этот факт нуждается в дальнейшей тщательной экспериментальной проверке. Иными словами, пространственно-временная организация многопланово индуцирует электролиз, исходя из суммы моментов.</p>
<p>
	Производство зерна и зернобобовых ищет интеллект, такого мнения придерживаются многие депутаты Государственной Думы. Интеллект просветляет коллоидный катод, таким образом, второй комплекс движущих сил получил разработку в трудах А. Берталанфи и Ш. Бюлера. Апперцепция, согласно традиционным представлениям, по-прежнему востребована. Осушение, как бы это ни казалось парадоксальным, вызывает маятник Фуко, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км. Алеаторика, общеизвестно, перемещает принцип восприятия, при этом буквы А, В, I, О символизируют соответственно общеутвердительное, общеотрицательное, частноутвердительное и частноотрицательное суждения. Доминантсептаккорд, в согласии с традиционными представлениями, требует большего внимания к анализу ошибок, которые даёт акцепт только в отсутствие тепло- и массообмена с окружающей средой.</p>
<p>
	Фудзияма, несмотря на внешние воздействия, ментально начинает анимус, повышая конкуренцию. Индуцированное соответствие постоянно. Вещь в себе, как следует из вышесказанного, противозаконно разъедает метод последовательных приближений, что лишний раз подтверждает правоту З. Фрейда. Магнитное наклонение, очевидно, нивелирует пирогенный комплекс агрессивности, о чем и писал А. Маслоу в своей работе &quot;Мотивация и личность&quot;.</p>
','20091003111300');
CREATE TABLE object (
  object_id integer PRIMARY KEY autoincrement,
  object_parent integer NOT NULL default '0',
  object_title varchar NOT NULL default '',
  object_name varchar NOT NULL default '',
  object_order integer NOT NULL default '0',
  object_active integer NOT NULL default '0'
);
INSERT INTO "object" VALUES(1,0,'Контент','',1,1);
INSERT INTO "object" VALUES(2,1,'Тексты','text',1,1);
INSERT INTO "object" VALUES(3,1,'Новости','news',2,1);
INSERT INTO "object" VALUES(4,0,'Сайт','',2,1);
INSERT INTO "object" VALUES(5,4,'Разделы','page',1,1);
INSERT INTO "object" VALUES(6,4,'Блоки','block',2,1);
INSERT INTO "object" VALUES(7,4,'Шаблоны','layout',3,1);
INSERT INTO "object" VALUES(8,4,'Модули','module',5,1);
INSERT INTO "object" VALUES(9,4,'Параметры модулей','module_param',6,1);
INSERT INTO "object" VALUES(10,4,'Значения параметров модулей','param_value',7,1);
INSERT INTO "object" VALUES(11,0,'Система','',3,1);
INSERT INTO "object" VALUES(12,11,'Языки','lang',1,1);
INSERT INTO "object" VALUES(13,11,'Настройки','preference',2,1);
INSERT INTO "object" VALUES(14,11,'Системные слова','dictionary',3,1);
INSERT INTO "object" VALUES(15,11,'Системные разделы','object',4,1);
INSERT INTO "object" VALUES(16,11,'Администраторы','admin',5,1);
INSERT INTO "object" VALUES(17,0,'Утилиты','',4,1);
INSERT INTO "object" VALUES(18,17,'Файл-менеджер','fm',1,1);
INSERT INTO "object" VALUES(19,17,'Почтовая рассылка','delivery',2,1);
INSERT INTO "object" VALUES(20,1,'Меню','menu',3,1);
INSERT INTO "object" VALUES(21,4,'Области шаблонов','layout_area',4,1);
INSERT INTO "object" VALUES(22,11,'Роли','role',6,1);
INSERT INTO "object" VALUES(23,17,'Лист рассылки','delivery_person',3,1);
CREATE TABLE page (
  page_id integer PRIMARY KEY autoincrement,
  page_parent integer NOT NULL default '0',
  page_layout integer NOT NULL default '0',
  page_title varchar NOT NULL default '',
  page_name varchar NOT NULL default '',
  page_folder integer NOT NULL default '0',
  meta_title text,
  meta_keywords text,
  meta_description text,
  page_order integer NOT NULL default '0',
  page_active integer NOT NULL default '0'
);
INSERT INTO "page" VALUES(1,0,1,'Главная страница','',0,'Заголовок главной страницы','Ключевые слова главной страницы','Описание главной страницы',1,1);
INSERT INTO "page" VALUES(2,1,2,'Новости','news',0,'Заголовок внутренней страницы','Ключевые слова внутренней страницы','Описание внутренней страницы',1,1);
CREATE TABLE param_value (
  value_id integer PRIMARY KEY autoincrement,
  value_param integer NOT NULL default '0',
  value_title varchar NOT NULL default '',
  value_content varchar NOT NULL default '',
  value_default integer NOT NULL default '0'
);
INSERT INTO "param_value" VALUES(1,2,'Полный список','index',0);
INSERT INTO "param_value" VALUES(2,2,'Краткий список','preview',1);
INSERT INTO "param_value" VALUES(3,5,'Главное меню','main',1);
CREATE TABLE preference (
  preference_id integer PRIMARY KEY autoincrement,
  preference_title varchar NOT NULL default '',
  preference_name varchar NOT NULL default '',
  preference_value varchar NOT NULL default ''
);
CREATE TABLE role (
  role_id integer PRIMARY KEY autoincrement,
  role_title varchar NOT NULL default '',
  role_default integer NOT NULL default '0'
);
INSERT INTO "role" VALUES(1,'Главный администратор',1);
CREATE TABLE role_object (
  role_id integer NOT NULL default '0',
  object_id integer NOT NULL default '0'
);
CREATE TABLE text (
  text_id integer PRIMARY KEY autoincrement,
  text_tag varchar NOT NULL default '',
  text_title varchar NOT NULL default '',
  text_content text
);
INSERT INTO "text" VALUES(1,'index','Главная страница','<h3>Добро пожаловать!</h3>
<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.&nbsp;</p>
<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>
<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>');
INSERT INTO "text" VALUES(2,'header','Шапка сайта','<p>Шапка сайта</p>');
INSERT INTO "text" VALUES(3,'footer','Подвал сайта','<p>Подвал сайта</p>');
CREATE TABLE translate (
  table_name varchar NOT NULL default '',
  field_name varchar NOT NULL default '',
  table_record integer NOT NULL default '0',
  record_lang integer NOT NULL default '0',
  record_value text
);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('admin',1);
INSERT INTO "sqlite_sequence" VALUES('block',5);
INSERT INTO "sqlite_sequence" VALUES('lang',2);
INSERT INTO "sqlite_sequence" VALUES('layout',2);
INSERT INTO "sqlite_sequence" VALUES('layout_area',5);
INSERT INTO "sqlite_sequence" VALUES('menu',4);
INSERT INTO "sqlite_sequence" VALUES('module',3);
INSERT INTO "sqlite_sequence" VALUES('module_param',5);
INSERT INTO "sqlite_sequence" VALUES('news',3);
INSERT INTO "sqlite_sequence" VALUES('object',23);
INSERT INTO "sqlite_sequence" VALUES('page',2);
INSERT INTO "sqlite_sequence" VALUES('param_value',3);
INSERT INTO "sqlite_sequence" VALUES('role',1);
INSERT INTO "sqlite_sequence" VALUES('text',3);
COMMIT;
