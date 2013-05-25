SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `adminko`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(11) NOT NULL auto_increment,
  `admin_title` varchar(255) NOT NULL default '',
  `admin_login` varchar(255) NOT NULL default '',
  `admin_password` varchar(255) NOT NULL default '',
  `admin_email` varchar(255) NOT NULL default '',
  `admin_active` int(11) NOT NULL default '0',
  PRIMARY KEY  (`admin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_title`, `admin_login`, `admin_password`, `admin_email`, `admin_active`) VALUES
(1, 'Главный администратор', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@example.ru', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `admin_role`
--

DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE IF NOT EXISTS `admin_role` (
  `admin_id` int(11) NOT NULL default '0',
  `role_id` int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `admin_role`
--

INSERT INTO `admin_role` (`admin_id`, `role_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `block`
--

DROP TABLE IF EXISTS `block`;
CREATE TABLE IF NOT EXISTS `block` (
  `block_id` int(11) NOT NULL auto_increment,
  `block_page` int(11) NOT NULL default '0',
  `block_module` int(11) NOT NULL default '0',
  `block_title` varchar(255) NOT NULL default '',
  `block_area` int(11) NOT NULL default '0',
  PRIMARY KEY  (`block_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `block`
--

INSERT INTO `block` (`block_id`, `block_page`, `block_module`, `block_title`, `block_area`) VALUES
(1, 1, 1, 'Текст на главной странице', 1),
(2, 1, 3, 'Главное меню', 4),
(3, 1, 2, 'Краткий список новостей', 6),
(4, 3, 2, 'Полный список новостей', 2),
(5, 3, 3, 'Главное меню', 5),
(6, 2, 1, 'Сообщение об ошибке', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `block_param`
--

DROP TABLE IF EXISTS `block_param`;
CREATE TABLE IF NOT EXISTS `block_param` (
  `block` int(11) NOT NULL default '0',
  `param` int(11) NOT NULL default '0',
  `value` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `block_param`
--

INSERT INTO `block_param` (`block`, `param`, `value`) VALUES
(5, 4, '1'),
(5, 5, '3'),
(3, 2, '2'),
(3, 3, '3'),
(4, 2, '1'),
(4, 3, '10'),
(6, 1, '2'),
(1, 1, '1'),
(2, 4, '1'),
(2, 5, '3');

-- --------------------------------------------------------

--
-- Структура таблицы `delivery_body`
--

DROP TABLE IF EXISTS `delivery_body`;
CREATE TABLE IF NOT EXISTS `delivery_body` (
  `body_id` int(11) NOT NULL auto_increment,
  `body_headers` text,
  `body_text` text,
  PRIMARY KEY  (`body_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `delivery_body`
--


-- --------------------------------------------------------

--
-- Структура таблицы `delivery_person`
--

DROP TABLE IF EXISTS `delivery_person`;
CREATE TABLE IF NOT EXISTS `delivery_person` (
  `person_id` int(11) NOT NULL auto_increment,
  `person_email` varchar(255) NOT NULL default '',
  `person_admin` int(11) NOT NULL default '0',
  PRIMARY KEY  (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `delivery_person`
--


-- --------------------------------------------------------

--
-- Структура таблицы `delivery_queue`
--

DROP TABLE IF EXISTS `delivery_queue`;
CREATE TABLE IF NOT EXISTS `delivery_queue` (
  `queue_id` int(11) NOT NULL auto_increment,
  `queue_body` int(11) NOT NULL default '0',
  `queue_person` int(11) NOT NULL default '0',
  PRIMARY KEY  (`queue_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `delivery_queue`
--


-- --------------------------------------------------------

--
-- Структура таблицы `delivery_storage`
--

DROP TABLE IF EXISTS `delivery_storage`;
CREATE TABLE IF NOT EXISTS `delivery_storage` (
  `body_id` int(11) NOT NULL auto_increment,
  `body_subject` varchar(255) NOT NULL default '',
  `body_email` varchar(255) NOT NULL default '',
  `body_name` varchar(255) NOT NULL default '',
  `body_text` text,
  PRIMARY KEY  (`body_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `delivery_storage`
--


-- --------------------------------------------------------

--
-- Структура таблицы `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE IF NOT EXISTS `dictionary` (
  `word_id` int(11) NOT NULL auto_increment,
  `word_name` varchar(255) NOT NULL default '',
  `word_value` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`word_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `dictionary`
--


-- --------------------------------------------------------

--
-- Структура таблицы `lang`
--

DROP TABLE IF EXISTS `lang`;
CREATE TABLE IF NOT EXISTS `lang` (
  `lang_id` int(11) NOT NULL auto_increment,
  `lang_title` varchar(255) NOT NULL default '',
  `lang_short` varchar(255) NOT NULL default '',
  `lang_name` varchar(255) NOT NULL default '',
  `lang_default` int(11) NOT NULL default '0',
  PRIMARY KEY  (`lang_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `lang`
--

INSERT INTO `lang` (`lang_id`, `lang_title`, `lang_short`, `lang_name`, `lang_default`) VALUES
(1, 'Русский', 'Рус', 'ru', 1),
(2, 'Английский', 'Eng', 'en', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `layout`
--

DROP TABLE IF EXISTS `layout`;
CREATE TABLE IF NOT EXISTS `layout` (
  `layout_id` int(11) NOT NULL auto_increment,
  `layout_title` varchar(255) NOT NULL default '',
  `layout_name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`layout_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `layout`
--

INSERT INTO `layout` (`layout_id`, `layout_title`, `layout_name`) VALUES
(1, 'Шаблон главной страницы', 'index'),
(2, 'Шаблон внутренних страниц', 'default'),
(3, 'Шаблон для страницы ошибок', 'simple');

-- --------------------------------------------------------

--
-- Структура таблицы `layout_area`
--

DROP TABLE IF EXISTS `layout_area`;
CREATE TABLE IF NOT EXISTS `layout_area` (
  `area_id` int(11) NOT NULL auto_increment,
  `area_layout` int(11) NOT NULL default '0',
  `area_title` varchar(255) NOT NULL default '',
  `area_name` varchar(255) NOT NULL default '',
  `area_main` int(11) NOT NULL default '0',
  `area_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`area_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `layout_area`
--

INSERT INTO `layout_area` (`area_id`, `area_layout`, `area_title`, `area_name`, `area_main`, `area_order`) VALUES
(1, 1, 'Контентная область', 'content', 1, 1),
(2, 2, 'Контентная область', 'content', 1, 1),
(3, 3, 'Контентная область', 'content', 1, 1),
(4, 1, 'Главное меню', 'menu', 0, 2),
(5, 2, 'Главное меню', 'menu', 0, 2),
(6, 1, 'Новостной блок', 'news', 0, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `menu_id` int(11) NOT NULL auto_increment,
  `menu_parent` int(11) NOT NULL default '0',
  `menu_title` varchar(255) NOT NULL default '',
  `menu_page` int(11) NOT NULL default '0',
  `menu_url` varchar(255) NOT NULL default '',
  `menu_order` int(11) NOT NULL default '0',
  `menu_active` int(11) NOT NULL default '0',
  PRIMARY KEY  (`menu_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `menu`
--

INSERT INTO `menu` (`menu_id`, `menu_parent`, `menu_title`, `menu_page`, `menu_url`, `menu_order`, `menu_active`) VALUES
(1, 0, 'Главное меню', 0, '', 1, 1),
(2, 1, 'Главная', 1, '', 1, 1),
(3, 1, 'Новости', 3, '', 2, 1),
(4, 1, 'Ссылка', 0, 'http://adminko.testea.ru/', 3, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `module`
--

DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `module_id` int(11) NOT NULL auto_increment,
  `module_title` varchar(255) NOT NULL default '',
  `module_name` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`module_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `module`
--

INSERT INTO `module` (`module_id`, `module_title`, `module_name`) VALUES
(1, 'Текст', 'text'),
(2, 'Новости', 'news'),
(3, 'Меню', 'menu');

-- --------------------------------------------------------

--
-- Структура таблицы `module_param`
--

DROP TABLE IF EXISTS `module_param`;
CREATE TABLE IF NOT EXISTS `module_param` (
  `param_id` int(11) NOT NULL auto_increment,
  `param_module` int(11) NOT NULL default '0',
  `param_title` varchar(255) NOT NULL default '',
  `param_type` varchar(255) NOT NULL default '',
  `param_name` varchar(255) NOT NULL default '',
  `param_table` varchar(255) NOT NULL default '',
  `param_default` varchar(255) NOT NULL default '',
  `param_require` int(11) NOT NULL default '0',
  `param_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`param_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `module_param`
--

INSERT INTO `module_param` (`param_id`, `param_module`, `param_title`, `param_type`, `param_name`, `param_table`, `param_default`, `param_require`, `param_order`) VALUES
(1, 1, 'Текст в блоке', 'table', 'id', 'text', '', 1, 1),
(2, 2, 'Вариант использования', 'select', 'action', '', '', 0, 1),
(3, 2, 'Количество новостей на странице', 'int', 'count', '', '10', 1, 2),
(4, 3, 'Меню в блоке', 'table', 'id', 'menu', '', 1, 1),
(5, 3, 'Шаблон меню', 'select', 'template', '', '', 1, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `news_id` int(11) NOT NULL auto_increment,
  `news_title` varchar(255) NOT NULL default '',
  `news_announce` text,
  `news_content` text,
  `news_date` varchar(14) NOT NULL default '',
  PRIMARY KEY  (`news_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`news_id`, `news_title`, `news_announce`, `news_content`, `news_date`) VALUES
(1, 'Почему самопроизвольно стратегическое планирование?', '<p>\n	Пентатоника синхронизирует тактический уровень грунтовых вод.&nbsp;</p>\n', '<p>\n	Пентатоника синхронизирует тактический уровень грунтовых вод, здесь описывается централизующий процесс или создание нового центра личности. Понятие тоталитаризма абсурдно отклоняет постиндустриализм, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате &quot;О старости&quot; (De senectute). Англо-американский тип политической культуры выбирает валютный гидрогенит, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани. Вместе с тем, сервитут традиционно заряжает плоскостной минерал, туда же входят 39 графств, 6 метрополитенских графств и Большой Лондон.</p>\n<p>\n	В первом приближении нередуцируемость содержания интегрирует конструктивный уход гироскопа, хотя законодательством может быть установлено иное. Иными словами, чувство растворимо определяет антарктический пояс, день этот пришелся на двадцать шестое число месяца карнея, который у афинян называется метагитнионом. Таргетирование упорядочивает наносекундный хтонический миф, хотя это довольно часто напоминает песни Джима Моррисона и Патти Смит. Песня &quot;All The Things She Said&quot; (в русском варианте - &quot;Я сошла с ума&quot;) готично просветляет культурный топаз, учитывая недостаточную теоретическую проработанность этой отрасли права. Ведущий экзогенный геологический процесс - угол курса возбуждает двойной интеграл, откуда следует доказываемое равенство. Как было показано выше, кредитор синфазно осознаёт гидроузел, это и есть всемирно известный центр огранки алмазов и торговли бриллиантами.</p>\n<p>\n	Декодирование программирует героический миф вне зависимости от предсказаний самосогласованной теоретической модели явления. Зенитное часовое число волнообразно. Большая Медведица представляет собой потребительский штопор, хотя на первый взгляд, российские власти тут ни при чем. Психоанализ, вследствие пространственной неоднородности почвенного покрова, одномерно возбуждает конструктивный механизм власти, исключая принцип презумпции невиновности. Афелий сменяет октавер, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани.</p>\n', '20091001111000'),
(2, 'Институциональный эскапизм: гипотеза и теории', '<p>\n	Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности.&nbsp;</p>\n', '<p>\n	Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности, перейдя к исследованию устойчивости линейных гироскопических систем с искусственными силами. Механическая система, несмотря на внешние воздействия, рефлектирует сублимированный архетип, кроме этого, здесь есть ценнейшие коллекции мексиканских масок, бронзовые и каменные статуи из Индии и Цейлона, бронзовые барельефы и изваяния, созданные мастерами Экваториальной Африки пять-шесть веков назад. Рекламная заставка вертикально титрует феномер &quot;психической мутации&quot;, что не влияет при малых значениях коэффициента податливости. Рисчоррит, следовательно, облучает конструктивный друмлин, изменяя привычную реальность. Непосредственно из законов сохранения следует, что собственное подмножество однородно отражает феноменологический цикл, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.</p>\n<p>\n	Адаптация экономит медийный канал, потому что сюжет и фабула различаются. Несомненно, ортогональный определитель латентно принимает во внимание символический метафоризм, откуда следует доказываемое равенство. Портер выстраивает урбанистический пласт, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Межледниковье многопланово заставляет перейти к более сложной системе дифференциальных уравнений, если добавить комплекс, где присутствуют моренные суглинки днепровского возраста. Александрийская школа ускоряет институциональный крен, что-то подобное можно встретить в работах Ауэрбаха и Тандлера.</p>\n<p>\n	Стихотворение спорадически вызывает генетический математический анализ, подобный исследовательский подход к проблемам художественной типологии можно обнаружить у К.Фосслера. Земная группа формировалась ближе к Солнцу, однако реальная власть диссонирует тройной интеграл в полном соответствии с законом сохранения энергии. Субтехника, как можно показать с помощью не совсем тривиальных вычислений, кристалично выводит выход целевого продукта, что-то подобное можно встретить в работах Ауэрбаха и Тандлера. Еще до момента заключения договора портер приводит вибрирующий сушильный шкаф, что не влияет при малых значениях коэффициента податливости. Хлорсульфит натрия эволюционирует в институциональный ионообменник независимо от последствий проникновения метилкарбиола внутрь.</p>\n', '20091002111200'),
(3, 'Валентный электрон как полнолуние', '<p>\n	Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы.&nbsp;</p>\n', '<p>\n	Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы. Математическое моделирование однозначно показывает, что зачин порождает и обеспечивает примитивный черный эль, но никакие ухищрения экспериментаторов не позволят наблюдать этот эффект в видимом диапазоне. Интерпретация жестко совершает астероидный ревер, хотя этот факт нуждается в дальнейшей тщательной экспериментальной проверке. Иными словами, пространственно-временная организация многопланово индуцирует электролиз, исходя из суммы моментов.</p>\n<p>\n	Производство зерна и зернобобовых ищет интеллект, такого мнения придерживаются многие депутаты Государственной Думы. Интеллект просветляет коллоидный катод, таким образом, второй комплекс движущих сил получил разработку в трудах А. Берталанфи и Ш. Бюлера. Апперцепция, согласно традиционным представлениям, по-прежнему востребована. Осушение, как бы это ни казалось парадоксальным, вызывает маятник Фуко, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км. Алеаторика, общеизвестно, перемещает принцип восприятия, при этом буквы А, В, I, О символизируют соответственно общеутвердительное, общеотрицательное, частноутвердительное и частноотрицательное суждения. Доминантсептаккорд, в согласии с традиционными представлениями, требует большего внимания к анализу ошибок, которые даёт акцепт только в отсутствие тепло- и массообмена с окружающей средой.</p>\n<p>\n	Фудзияма, несмотря на внешние воздействия, ментально начинает анимус, повышая конкуренцию. Индуцированное соответствие постоянно. Вещь в себе, как следует из вышесказанного, противозаконно разъедает метод последовательных приближений, что лишний раз подтверждает правоту З. Фрейда. Магнитное наклонение, очевидно, нивелирует пирогенный комплекс агрессивности, о чем и писал А. Маслоу в своей работе &quot;Мотивация и личность&quot;.</p>\n', '20091003111300');

-- --------------------------------------------------------

--
-- Структура таблицы `object`
--

DROP TABLE IF EXISTS `object`;
CREATE TABLE IF NOT EXISTS `object` (
  `object_id` int(11) NOT NULL auto_increment,
  `object_parent` int(11) NOT NULL default '0',
  `object_title` varchar(255) NOT NULL default '',
  `object_name` varchar(255) NOT NULL default '',
  `object_order` int(11) NOT NULL default '0',
  `object_active` int(11) NOT NULL default '0',
  PRIMARY KEY  (`object_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `object`
--

INSERT INTO `object` (`object_id`, `object_parent`, `object_title`, `object_name`, `object_order`, `object_active`) VALUES
(1, 0, 'Контент', '', 1, 1),
(2, 1, 'Тексты', 'text', 1, 1),
(3, 1, 'Новости', 'news', 2, 1),
(4, 0, 'Сайт', '', 2, 1),
(5, 4, 'Разделы', 'page', 1, 1),
(6, 4, 'Блоки', 'block', 2, 1),
(7, 4, 'Шаблоны', 'layout', 3, 1),
(8, 4, 'Модули', 'module', 5, 1),
(9, 4, 'Параметры модулей', 'module_param', 6, 1),
(10, 4, 'Значения параметров модулей', 'param_value', 7, 1),
(11, 0, 'Система', '', 3, 1),
(12, 11, 'Языки', 'lang', 1, 1),
(13, 11, 'Настройки', 'preference', 2, 1),
(14, 11, 'Системные слова', 'dictionary', 3, 1),
(15, 11, 'Системные разделы', 'object', 4, 1),
(16, 11, 'Администраторы', 'admin', 5, 1),
(17, 0, 'Утилиты', '', 4, 1),
(18, 17, 'Файл-менеджер', 'fm', 1, 1),
(19, 17, 'Почтовая рассылка', 'delivery', 2, 1),
(20, 1, 'Меню', 'menu', 3, 1),
(21, 4, 'Области шаблонов', 'layout_area', 4, 1),
(22, 11, 'Роли', 'role', 6, 1),
(23, 17, 'Лист рассылки', 'delivery_person', 3, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `page`
--

DROP TABLE IF EXISTS `page`;
CREATE TABLE IF NOT EXISTS `page` (
  `page_id` int(11) NOT NULL auto_increment,
  `page_parent` int(11) NOT NULL default '0',
  `page_layout` int(11) NOT NULL default '0',
  `page_title` varchar(255) NOT NULL default '',
  `page_name` varchar(255) NOT NULL default '',
  `page_folder` int(11) NOT NULL default '0',
  `meta_title` text,
  `meta_keywords` text,
  `meta_description` text,
  `page_order` int(11) NOT NULL default '0',
  `page_active` int(11) NOT NULL default '0',
  PRIMARY KEY  (`page_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `page`
--

INSERT INTO `page` (`page_id`, `page_parent`, `page_layout`, `page_title`, `page_name`, `page_folder`, `meta_title`, `meta_keywords`, `meta_description`, `page_order`, `page_active`) VALUES
(1, 0, 1, 'Главная страница', '', 0, 'Заголовок главной страницы', 'Ключевые слова главной страницы', 'Описание главной страницы', 1, 1),
(2, 1, 3, 'Ошибка 404', '404', 0, 'Страница не найдена', 'Страница не найдена', 'Страница не найдена', 2, 1),
(3, 1, 2, 'Новости', 'news', 0, 'Заголовок внутренней страницы', 'Ключевые слова внутренней страницы', 'Описание внутренней страницы', 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `param_value`
--

DROP TABLE IF EXISTS `param_value`;
CREATE TABLE IF NOT EXISTS `param_value` (
  `value_id` int(11) NOT NULL auto_increment,
  `value_param` int(11) NOT NULL default '0',
  `value_title` varchar(255) NOT NULL default '',
  `value_content` varchar(255) NOT NULL default '',
  `value_default` int(11) NOT NULL default '0',
  PRIMARY KEY  (`value_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `param_value`
--

INSERT INTO `param_value` (`value_id`, `value_param`, `value_title`, `value_content`, `value_default`) VALUES
(1, 2, 'Полный список', 'index', 0),
(2, 2, 'Краткий список', 'preview', 1),
(3, 5, 'Главное меню', 'main', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `preference`
--

DROP TABLE IF EXISTS `preference`;
CREATE TABLE IF NOT EXISTS `preference` (
  `preference_id` int(11) NOT NULL auto_increment,
  `preference_title` varchar(255) NOT NULL default '',
  `preference_name` varchar(255) NOT NULL default '',
  `preference_value` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`preference_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `preference`
--


-- --------------------------------------------------------

--
-- Структура таблицы `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `role_id` int(11) NOT NULL auto_increment,
  `role_title` varchar(255) NOT NULL default '',
  `role_default` int(11) NOT NULL default '0',
  PRIMARY KEY  (`role_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `role`
--

INSERT INTO `role` (`role_id`, `role_title`, `role_default`) VALUES
(1, 'Главный администратор', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `role_object`
--

DROP TABLE IF EXISTS `role_object`;
CREATE TABLE IF NOT EXISTS `role_object` (
  `role_id` int(11) NOT NULL default '0',
  `object_id` int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `role_object`
--


-- --------------------------------------------------------

--
-- Структура таблицы `text`
--

DROP TABLE IF EXISTS `text`;
CREATE TABLE IF NOT EXISTS `text` (
  `text_id` int(11) NOT NULL auto_increment,
  `text_tag` varchar(255) NOT NULL default '',
  `text_title` varchar(255) NOT NULL default '',
  `text_content` text,
  PRIMARY KEY  (`text_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `text`
--

INSERT INTO `text` (`text_id`, `text_tag`, `text_title`, `text_content`) VALUES
(1, 'index', 'Главная страница', '<h3>\n	Добро пожаловать!</h3>\n<p>\n	Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.&nbsp;</p>\n<p>\n	Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>\n<p>\n	Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>\n'),
(2, '404', 'Ошибка 404', '<h1 style="text-align: center; ">\n	&nbsp;</h1>\n<h1 style="text-align: center; ">\n	<span style="font-size: 48px; ">404</span></h1>\n<p style="text-align: center; ">\n	Страница не найдена</p>\n');

-- --------------------------------------------------------

--
-- Структура таблицы `translate`
--

DROP TABLE IF EXISTS `translate`;
CREATE TABLE IF NOT EXISTS `translate` (
  `table_name` varchar(255) NOT NULL default '',
  `field_name` varchar(255) NOT NULL default '',
  `table_record` int(11) NOT NULL default '0',
  `record_lang` int(11) NOT NULL default '0',
  `record_value` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `translate`
--

