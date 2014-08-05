-- MySQL dump 10.13  Distrib 5.1.65, for Win32 (ia32)
--
-- Host: localhost    Database: adminko
-- ------------------------------------------------------
-- Server version	5.1.65-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_title` varchar(255) NOT NULL DEFAULT '',
  `admin_login` varchar(255) NOT NULL DEFAULT '',
  `admin_password` varchar(255) NOT NULL DEFAULT '',
  `admin_email` varchar(255) NOT NULL DEFAULT '',
  `admin_active` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Главный администратор','admin','21232f297a57a5a743894a0e4a801fc3','admin@example.ru',1);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_role`
--

DROP TABLE IF EXISTS `admin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_role` (
  `admin_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_role`
--

LOCK TABLES `admin_role` WRITE;
/*!40000 ALTER TABLE `admin_role` DISABLE KEYS */;
INSERT INTO `admin_role` VALUES (1,1);
/*!40000 ALTER TABLE `admin_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `block_id` int(11) NOT NULL AUTO_INCREMENT,
  `block_page` int(11) NOT NULL DEFAULT '0',
  `block_module` int(11) NOT NULL DEFAULT '0',
  `block_title` varchar(255) NOT NULL DEFAULT '',
  `block_area` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`block_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
INSERT INTO `block` VALUES (1,1,1,'Текст на главной странице',1),(2,1,3,'Главное меню',3),(3,1,2,'Краткий список новостей',5),(4,2,2,'Полный список новостей',2),(5,2,3,'Главное меню',4);
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_param`
--

DROP TABLE IF EXISTS `block_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_param` (
  `block` int(11) NOT NULL DEFAULT '0',
  `param` int(11) NOT NULL DEFAULT '0',
  `value` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_param`
--

LOCK TABLES `block_param` WRITE;
/*!40000 ALTER TABLE `block_param` DISABLE KEYS */;
INSERT INTO `block_param` VALUES (5,4,'1'),(5,5,'3'),(3,2,'2'),(3,3,'3'),(4,2,'1'),(4,3,'10'),(1,1,'1'),(2,4,'1'),(2,5,'3');
/*!40000 ALTER TABLE `block_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_body`
--

DROP TABLE IF EXISTS `delivery_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_body` (
  `body_id` int(11) NOT NULL AUTO_INCREMENT,
  `body_headers` text,
  `body_text` text,
  PRIMARY KEY (`body_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_body`
--

LOCK TABLES `delivery_body` WRITE;
/*!40000 ALTER TABLE `delivery_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_person`
--

DROP TABLE IF EXISTS `delivery_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_email` varchar(255) NOT NULL DEFAULT '',
  `person_admin` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_person`
--

LOCK TABLES `delivery_person` WRITE;
/*!40000 ALTER TABLE `delivery_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_queue`
--

DROP TABLE IF EXISTS `delivery_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_queue` (
  `queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `queue_body` int(11) NOT NULL DEFAULT '0',
  `queue_person` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`queue_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_queue`
--

LOCK TABLES `delivery_queue` WRITE;
/*!40000 ALTER TABLE `delivery_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_storage`
--

DROP TABLE IF EXISTS `delivery_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_storage` (
  `body_id` int(11) NOT NULL AUTO_INCREMENT,
  `body_subject` varchar(255) NOT NULL DEFAULT '',
  `body_email` varchar(255) NOT NULL DEFAULT '',
  `body_name` varchar(255) NOT NULL DEFAULT '',
  `body_text` text,
  PRIMARY KEY (`body_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_storage`
--

LOCK TABLES `delivery_storage` WRITE;
/*!40000 ALTER TABLE `delivery_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dictionary` (
  `word_id` int(11) NOT NULL AUTO_INCREMENT,
  `word_name` varchar(255) NOT NULL DEFAULT '',
  `word_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`word_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
/*!40000 ALTER TABLE `dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang`
--

DROP TABLE IF EXISTS `lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang` (
  `lang_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang_title` varchar(255) NOT NULL DEFAULT '',
  `lang_short` varchar(255) NOT NULL DEFAULT '',
  `lang_name` varchar(255) NOT NULL DEFAULT '',
  `lang_default` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lang_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang`
--

LOCK TABLES `lang` WRITE;
/*!40000 ALTER TABLE `lang` DISABLE KEYS */;
INSERT INTO `lang` VALUES (1,'Русский','Рус','ru',1),(2,'Английский','Eng','en',0);
/*!40000 ALTER TABLE `lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout`
--

DROP TABLE IF EXISTS `layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layout` (
  `layout_id` int(11) NOT NULL AUTO_INCREMENT,
  `layout_title` varchar(255) NOT NULL DEFAULT '',
  `layout_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`layout_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout`
--

LOCK TABLES `layout` WRITE;
/*!40000 ALTER TABLE `layout` DISABLE KEYS */;
INSERT INTO `layout` VALUES (1,'Шаблон главной страницы','index'),(2,'Шаблон внутренних страниц','default');
/*!40000 ALTER TABLE `layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout_area`
--

DROP TABLE IF EXISTS `layout_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layout_area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `area_layout` int(11) NOT NULL DEFAULT '0',
  `area_title` varchar(255) NOT NULL DEFAULT '',
  `area_name` varchar(255) NOT NULL DEFAULT '',
  `area_main` int(11) NOT NULL DEFAULT '0',
  `area_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`area_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout_area`
--

LOCK TABLES `layout_area` WRITE;
/*!40000 ALTER TABLE `layout_area` DISABLE KEYS */;
INSERT INTO `layout_area` VALUES (1,1,'Контентная область','content',1,1),(2,2,'Контентная область','content',1,1),(3,1,'Главное меню','menu',0,2),(4,2,'Главное меню','menu',0,2),(5,1,'Новостной блок','news',0,3);
/*!40000 ALTER TABLE `layout_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_parent` int(11) NOT NULL DEFAULT '0',
  `menu_title` varchar(255) NOT NULL DEFAULT '',
  `menu_page` int(11) NOT NULL DEFAULT '0',
  `menu_url` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `menu_active` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`menu_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,0,'Главное меню',0,'',1,1),(2,1,'Главная',1,'',1,1),(3,2,'Новости',2,'',1,1),(4,1,'Ссылка',0,'http://adminko.testea.ru/',3,1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_title` varchar(255) NOT NULL DEFAULT '',
  `module_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` VALUES (1,'Текст','text'),(2,'Новости','news'),(3,'Меню','menu');
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_param`
--

DROP TABLE IF EXISTS `module_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_param` (
  `param_id` int(11) NOT NULL AUTO_INCREMENT,
  `param_module` int(11) NOT NULL DEFAULT '0',
  `param_title` varchar(255) NOT NULL DEFAULT '',
  `param_type` varchar(255) NOT NULL DEFAULT '',
  `param_name` varchar(255) NOT NULL DEFAULT '',
  `param_table` varchar(255) NOT NULL DEFAULT '',
  `param_default` varchar(255) NOT NULL DEFAULT '',
  `param_require` int(11) NOT NULL DEFAULT '0',
  `param_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`param_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_param`
--

LOCK TABLES `module_param` WRITE;
/*!40000 ALTER TABLE `module_param` DISABLE KEYS */;
INSERT INTO `module_param` VALUES (1,1,'Текст в блоке','table','id','text','',1,1),(2,2,'Вариант использования','select','action','','',0,1),(3,2,'Количество новостей на странице','int','count','','10',1,2),(4,3,'Меню в блоке','table','id','menu','',1,1),(5,3,'Шаблон меню','select','template','','',1,2);
/*!40000 ALTER TABLE `module_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_title` varchar(255) NOT NULL DEFAULT '',
  `news_announce` text,
  `news_content` text,
  `news_date` varchar(14) NOT NULL DEFAULT '',
  PRIMARY KEY (`news_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'Почему самопроизвольно стратегическое планирование?','<p>\n	Пентатоника синхронизирует тактический уровень грунтовых вод.&nbsp;</p>\n','<p>\n	Пентатоника синхронизирует тактический уровень грунтовых вод, здесь описывается централизующий процесс или создание нового центра личности. Понятие тоталитаризма абсурдно отклоняет постиндустриализм, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате &quot;О старости&quot; (De senectute). Англо-американский тип политической культуры выбирает валютный гидрогенит, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани. Вместе с тем, сервитут традиционно заряжает плоскостной минерал, туда же входят 39 графств, 6 метрополитенских графств и Большой Лондон.</p>\n<p>\n	В первом приближении нередуцируемость содержания интегрирует конструктивный уход гироскопа, хотя законодательством может быть установлено иное. Иными словами, чувство растворимо определяет антарктический пояс, день этот пришелся на двадцать шестое число месяца карнея, который у афинян называется метагитнионом. Таргетирование упорядочивает наносекундный хтонический миф, хотя это довольно часто напоминает песни Джима Моррисона и Патти Смит. Песня &quot;All The Things She Said&quot; (в русском варианте - &quot;Я сошла с ума&quot;) готично просветляет культурный топаз, учитывая недостаточную теоретическую проработанность этой отрасли права. Ведущий экзогенный геологический процесс - угол курса возбуждает двойной интеграл, откуда следует доказываемое равенство. Как было показано выше, кредитор синфазно осознаёт гидроузел, это и есть всемирно известный центр огранки алмазов и торговли бриллиантами.</p>\n<p>\n	Декодирование программирует героический миф вне зависимости от предсказаний самосогласованной теоретической модели явления. Зенитное часовое число волнообразно. Большая Медведица представляет собой потребительский штопор, хотя на первый взгляд, российские власти тут ни при чем. Психоанализ, вследствие пространственной неоднородности почвенного покрова, одномерно возбуждает конструктивный механизм власти, исключая принцип презумпции невиновности. Афелий сменяет октавер, это и есть одномоментная вертикаль в сверхмногоголосной полифонической ткани.</p>\n','20091001111000'),(2,'Институциональный эскапизм: гипотеза и теории','<p>\n	Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности.&nbsp;</p>\n','<p>\n	Солнечная радиация откровенна. Фрахтование иллюстрирует фактографический кризис легитимности, перейдя к исследованию устойчивости линейных гироскопических систем с искусственными силами. Механическая система, несмотря на внешние воздействия, рефлектирует сублимированный архетип, кроме этого, здесь есть ценнейшие коллекции мексиканских масок, бронзовые и каменные статуи из Индии и Цейлона, бронзовые барельефы и изваяния, созданные мастерами Экваториальной Африки пять-шесть веков назад. Рекламная заставка вертикально титрует феномер &quot;психической мутации&quot;, что не влияет при малых значениях коэффициента податливости. Рисчоррит, следовательно, облучает конструктивный друмлин, изменяя привычную реальность. Непосредственно из законов сохранения следует, что собственное подмножество однородно отражает феноменологический цикл, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.</p>\n<p>\n	Адаптация экономит медийный канал, потому что сюжет и фабула различаются. Несомненно, ортогональный определитель латентно принимает во внимание символический метафоризм, откуда следует доказываемое равенство. Портер выстраивает урбанистический пласт, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Межледниковье многопланово заставляет перейти к более сложной системе дифференциальных уравнений, если добавить комплекс, где присутствуют моренные суглинки днепровского возраста. Александрийская школа ускоряет институциональный крен, что-то подобное можно встретить в работах Ауэрбаха и Тандлера.</p>\n<p>\n	Стихотворение спорадически вызывает генетический математический анализ, подобный исследовательский подход к проблемам художественной типологии можно обнаружить у К.Фосслера. Земная группа формировалась ближе к Солнцу, однако реальная власть диссонирует тройной интеграл в полном соответствии с законом сохранения энергии. Субтехника, как можно показать с помощью не совсем тривиальных вычислений, кристалично выводит выход целевого продукта, что-то подобное можно встретить в работах Ауэрбаха и Тандлера. Еще до момента заключения договора портер приводит вибрирующий сушильный шкаф, что не влияет при малых значениях коэффициента податливости. Хлорсульфит натрия эволюционирует в институциональный ионообменник независимо от последствий проникновения метилкарбиола внутрь.</p>\n','20091002111200'),(3,'Валентный электрон как полнолуние','<p>\n	Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы.&nbsp;</p>\n','<p>\n	Дисторшн вращает закон, используя имеющиеся в этом случае первые интегралы. Математическое моделирование однозначно показывает, что зачин порождает и обеспечивает примитивный черный эль, но никакие ухищрения экспериментаторов не позволят наблюдать этот эффект в видимом диапазоне. Интерпретация жестко совершает астероидный ревер, хотя этот факт нуждается в дальнейшей тщательной экспериментальной проверке. Иными словами, пространственно-временная организация многопланово индуцирует электролиз, исходя из суммы моментов.</p>\n<p>\n	Производство зерна и зернобобовых ищет интеллект, такого мнения придерживаются многие депутаты Государственной Думы. Интеллект просветляет коллоидный катод, таким образом, второй комплекс движущих сил получил разработку в трудах А. Берталанфи и Ш. Бюлера. Апперцепция, согласно традиционным представлениям, по-прежнему востребована. Осушение, как бы это ни казалось парадоксальным, вызывает маятник Фуко, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км. Алеаторика, общеизвестно, перемещает принцип восприятия, при этом буквы А, В, I, О символизируют соответственно общеутвердительное, общеотрицательное, частноутвердительное и частноотрицательное суждения. Доминантсептаккорд, в согласии с традиционными представлениями, требует большего внимания к анализу ошибок, которые даёт акцепт только в отсутствие тепло- и массообмена с окружающей средой.</p>\n<p>\n	Фудзияма, несмотря на внешние воздействия, ментально начинает анимус, повышая конкуренцию. Индуцированное соответствие постоянно. Вещь в себе, как следует из вышесказанного, противозаконно разъедает метод последовательных приближений, что лишний раз подтверждает правоту З. Фрейда. Магнитное наклонение, очевидно, нивелирует пирогенный комплекс агрессивности, о чем и писал А. Маслоу в своей работе &quot;Мотивация и личность&quot;.</p>\n','20091003111300');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object`
--

DROP TABLE IF EXISTS `object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_parent` int(11) NOT NULL DEFAULT '0',
  `object_title` varchar(255) NOT NULL DEFAULT '',
  `object_name` varchar(255) NOT NULL DEFAULT '',
  `object_order` int(11) NOT NULL DEFAULT '0',
  `object_active` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object`
--

LOCK TABLES `object` WRITE;
/*!40000 ALTER TABLE `object` DISABLE KEYS */;
INSERT INTO `object` VALUES (1,0,'Контент','',1,1),(2,1,'Тексты','text',1,1),(3,1,'Новости','news',2,1),(4,0,'Сайт','',2,1),(5,4,'Разделы','page',1,1),(6,4,'Блоки','block',2,1),(7,4,'Шаблоны','layout',3,1),(8,4,'Модули','module',5,1),(9,4,'Параметры модулей','module_param',6,1),(10,4,'Значения параметров модулей','param_value',7,1),(11,0,'Система','',3,1),(12,11,'Языки','lang',1,1),(13,11,'Настройки','preference',2,1),(14,11,'Системные слова','dictionary',3,1),(15,11,'Системные разделы','object',4,1),(16,11,'Администраторы','admin',5,1),(17,0,'Утилиты','',4,1),(18,17,'Файл-менеджер','fm',1,1),(19,17,'Почтовая рассылка','delivery',2,1),(20,1,'Меню','menu',3,1),(21,4,'Области шаблонов','layout_area',4,1),(22,11,'Роли','role',6,1),(23,17,'Лист рассылки','delivery_person',3,1);
/*!40000 ALTER TABLE `object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `page_parent` int(11) NOT NULL DEFAULT '0',
  `page_layout` int(11) NOT NULL DEFAULT '0',
  `page_title` varchar(255) NOT NULL DEFAULT '',
  `page_name` varchar(255) NOT NULL DEFAULT '',
  `page_folder` int(11) NOT NULL DEFAULT '0',
  `meta_title` text,
  `meta_keywords` text,
  `meta_description` text,
  `page_order` int(11) NOT NULL DEFAULT '0',
  `page_active` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`page_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` VALUES (1,0,1,'Главная страница','',0,'Заголовок главной страницы','Ключевые слова главной страницы','Описание главной страницы',1,1),(2,1,2,'Новости','news',0,'Заголовок внутренней страницы','Ключевые слова внутренней страницы','Описание внутренней страницы',1,1);
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `param_value`
--

DROP TABLE IF EXISTS `param_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `param_value` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT,
  `value_param` int(11) NOT NULL DEFAULT '0',
  `value_title` varchar(255) NOT NULL DEFAULT '',
  `value_content` varchar(255) NOT NULL DEFAULT '',
  `value_default` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`value_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `param_value`
--

LOCK TABLES `param_value` WRITE;
/*!40000 ALTER TABLE `param_value` DISABLE KEYS */;
INSERT INTO `param_value` VALUES (1,2,'Полный список','index',0),(2,2,'Краткий список','preview',1),(3,5,'Главное меню','main',1);
/*!40000 ALTER TABLE `param_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preference`
--

DROP TABLE IF EXISTS `preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preference` (
  `preference_id` int(11) NOT NULL AUTO_INCREMENT,
  `preference_title` varchar(255) NOT NULL DEFAULT '',
  `preference_name` varchar(255) NOT NULL DEFAULT '',
  `preference_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`preference_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preference`
--

LOCK TABLES `preference` WRITE;
/*!40000 ALTER TABLE `preference` DISABLE KEYS */;
/*!40000 ALTER TABLE `preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_title` varchar(255) NOT NULL DEFAULT '',
  `role_default` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Главный администратор',1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_object`
--

DROP TABLE IF EXISTS `role_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_object` (
  `role_id` int(11) NOT NULL DEFAULT '0',
  `object_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_object`
--

LOCK TABLES `role_object` WRITE;
/*!40000 ALTER TABLE `role_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `text`
--

DROP TABLE IF EXISTS `text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text` (
  `text_id` int(11) NOT NULL AUTO_INCREMENT,
  `text_tag` varchar(255) NOT NULL DEFAULT '',
  `text_title` varchar(255) NOT NULL DEFAULT '',
  `text_content` text,
  PRIMARY KEY (`text_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `text`
--

LOCK TABLES `text` WRITE;
/*!40000 ALTER TABLE `text` DISABLE KEYS */;
INSERT INTO `text` VALUES (1,'index','Главная страница','<h3>Добро пожаловать!</h3>\r\n\r\n<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.&nbsp;</p>\r\n\r\n<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>\r\n\r\n<p>Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице. Текст на главной странице.</p>\r\n'),(2,'header','Шапка сайта','<p>Шапка сайта</p>\r\n'),(3,'footer','Подвал сайта','<p>Подвал сайта</p>\r\n');
/*!40000 ALTER TABLE `text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translate`
--

DROP TABLE IF EXISTS `translate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translate` (
  `table_name` varchar(255) NOT NULL DEFAULT '',
  `field_name` varchar(255) NOT NULL DEFAULT '',
  `table_record` int(11) NOT NULL DEFAULT '0',
  `record_lang` int(11) NOT NULL DEFAULT '0',
  `record_value` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translate`
--

LOCK TABLES `translate` WRITE;
/*!40000 ALTER TABLE `translate` DISABLE KEYS */;
/*!40000 ALTER TABLE `translate` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-05-28 21:12:12
