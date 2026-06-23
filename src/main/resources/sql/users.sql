USE topupservicesystem;

-- ==================== DROP ====================
DROP TABLE IF EXISTS users;

-- ==================== CLEANUP ====================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM users;
ALTER TABLE users AUTO_INCREMENT = 1;
SET SQL_SAFE_UPDATES = 1;

-- ==================== INSERT ====================
INSERT INTO users (name, email, password, role, status, created_at) VALUES
('specter2353', 'specter2353299@gmail.com', '$2a$10$dummyhashGen1215xyz', 'USER', 'ACTIVE', '2022-01-03 10:19:21'),
('RogueWarrior28', 'roguewarrior28808@gmail.com', '$2a$10$dummyhashGen1157xyz', 'USER', 'ACTIVE', '2022-01-05 09:43:01'),
('StormSamurai7823', 'stormsamurai7823332@yahoo.com', '$2a$10$dummyhashGen1285xyz', 'USER', 'ACTIVE', '2022-01-11 14:38:43'),
('RogueTiger47', 'roguetiger47336@gmail.com', '$2a$10$dummyhashGen1179xyz', 'USER', 'ACTIVE', '2022-01-13 00:11:30'),
('BlazeHawk50', 'blazehawk50952@gmail.com', '$2a$10$dummyhashGen1039xyz', 'USER', 'ACTIVE', '2022-01-15 11:18:19'),
('GoldenTitan84', 'goldentitan84741@gmail.com', '$2a$10$dummyhashGen1286xyz', 'USER', 'ACTIVE', '2022-01-18 18:21:18'),
('WildSpirit23', 'wildspirit23995@gmail.com', '$2a$10$dummyhashGen1015xyz', 'USER', 'ACTIVE', '2022-01-18 20:02:36'),
('LuckyMaverick45', 'luckymaverick45533@gmail.com', '$2a$10$dummyhashGen1471xyz', 'USER', 'ACTIVE', '2022-01-20 04:57:20'),
('goblin274', 'goblin274602@gmail.com', '$2a$10$dummyhashGen1400xyz', 'USER', 'ACTIVE', '2022-01-22 10:15:22'),
('BurningSpecter7', 'burningspecter7184@outlook.com', '$2a$10$dummyhashGen1331xyz', 'USER', 'ACTIVE', '2022-01-25 07:46:33');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('SneakyCobra7917', 'sneakycobra7917676@gmail.com', '$2a$10$dummyhashGen1323xyz', 'USER', 'SUSPENDED', '2022-01-25 10:31:22'),
('crusader6938', 'crusader6938521@outlook.com', '$2a$10$dummyhashGen1199xyz', 'USER', 'ACTIVE', '2022-01-29 07:41:01'),
('iron_legend', 'iron_legend44@gmail.com', '$2a$10$dummyhashGen1181xyz', 'USER', 'ACTIVE', '2022-01-30 02:44:06'),
('reckless_blade', 'reckless_blade928@gmail.com', '$2a$10$dummyhashGen1212xyz', 'USER', 'ACTIVE', '2022-01-30 12:30:58'),
('xShadowMarauderx', 'xshadowmarauderx332@gmail.com', '$2a$10$dummyhashGen1019xyz', 'USER', 'ACTIVE', '2022-01-31 06:08:44'),
('hunter44', 'hunter44919@outlook.com', '$2a$10$dummyhashGen1476xyz', 'USER', 'ACTIVE', '2022-02-01 10:20:12'),
('Phoenix2684PH', 'phoenix2684ph111@gmail.com', '$2a$10$dummyhashGen1083xyz', 'USER', 'ACTIVE', '2022-02-09 21:21:39'),
('outlaw9675', 'outlaw9675433@gmail.com', '$2a$10$dummyhashGen1001xyz', 'USER', 'ACTIVE', '2022-02-16 06:55:15'),
('Gamer6858Live', 'gamer6858live398@hotmail.com', '$2a$10$dummyhashGen1494xyz', 'USER', 'ACTIVE', '2022-02-24 20:47:16'),
('xMysticRiderx', 'xmysticriderx904@yahoo.com', '$2a$10$dummyhashGen1279xyz', 'USER', 'ACTIVE', '2022-02-26 10:50:51');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('FatalSamurai888', 'fatalsamurai888949@outlook.com', '$2a$10$dummyhashGen1280xyz', 'USER', 'INACTIVE', '2022-02-28 04:50:25'),
('Raptor8883PH', 'raptor8883ph180@gmail.com', '$2a$10$dummyhashGen1442xyz', 'USER', 'ACTIVE', '2022-02-28 23:23:27'),
('Ranger3674Gaming', 'ranger3674gaming800@hotmail.com', '$2a$10$dummyhashGen1080xyz', 'USER', 'ACTIVE', '2022-03-04 12:55:55'),
('SinisterViper9915', 'sinisterviper9915346@gmail.com', '$2a$10$dummyhashGen1245xyz', 'USER', 'ACTIVE', '2022-03-05 23:50:05'),
('Ninja4808TV', 'ninja4808tv45@yahoo.com', '$2a$10$dummyhashGen1221xyz', 'USER', 'ACTIVE', '2022-03-07 02:22:00'),
('striker7273', 'striker7273360@gmail.com', '$2a$10$dummyhashGen1227xyz', 'USER', 'ACTIVE', '2022-03-07 19:06:53'),
('ChaoticBandit7', 'chaoticbandit7400@gmail.com', '$2a$10$dummyhashGen1217xyz', 'USER', 'ACTIVE', '2022-03-09 15:04:51'),
('SilverHunter6940', 'silverhunter6940850@outlook.com', '$2a$10$dummyhashGen1045xyz', 'USER', 'INACTIVE', '2022-03-10 11:40:25'),
('ChaoticPhoenix83', 'chaoticphoenix83195@outlook.com', '$2a$10$dummyhashGen1056xyz', 'USER', 'ACTIVE', '2022-03-10 22:50:59'),
('MysticCobra57', 'mysticcobra57192@gmail.com', '$2a$10$dummyhashGen1463xyz', 'USER', 'ACTIVE', '2022-03-11 07:26:22');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('solar_cobra', 'solar_cobra722@gmail.com', '$2a$10$dummyhashGen1006xyz', 'USER', 'ACTIVE', '2022-03-13 04:27:24'),
('gladiator7000', 'gladiator7000570@gmail.com', '$2a$10$dummyhashGen1307xyz', 'USER', 'ACTIVE', '2022-03-14 19:57:56'),
('BlazeReaper25', 'blazereaper2544@gmail.com', '$2a$10$dummyhashGen1431xyz', 'USER', 'ACTIVE', '2022-03-20 15:54:37'),
('tiger9615', 'tiger9615246@yahoo.com', '$2a$10$dummyhashGen1274xyz', 'USER', 'ACTIVE', '2022-03-20 20:40:20'),
('AlphaRanger62', 'alpharanger62479@hotmail.com', '$2a$10$dummyhashGen1027xyz', 'USER', 'ACTIVE', '2022-03-26 03:38:53'),
('xNightSpiritx', 'xnightspiritx627@gmail.com', '$2a$10$dummyhashGen1405xyz', 'USER', 'ACTIVE', '2022-03-27 11:36:56'),
('DemonicSlayer68', 'demonicslayer68524@outlook.com', '$2a$10$dummyhashGen1409xyz', 'USER', 'ACTIVE', '2022-03-28 02:55:11'),
('Hawk3087TV', 'hawk3087tv530@yahoo.com', '$2a$10$dummyhashGen1492xyz', 'USER', 'ACTIVE', '2022-03-30 04:42:47'),
('iron_hawk', 'iron_hawk748@yahoo.com', '$2a$10$dummyhashGen1404xyz', 'USER', 'ACTIVE', '2022-03-31 22:53:24'),
('NeonWizard9490', 'neonwizard9490754@gmail.com', '$2a$10$dummyhashGen1034xyz', 'USER', 'ACTIVE', '2022-04-05 16:39:46');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('outlaw85', 'outlaw85233@gmail.com', '$2a$10$dummyhashGen1465xyz', 'USER', 'ACTIVE', '2022-04-05 17:38:19'),
('spirit90', 'spirit90187@yahoo.com', '$2a$10$dummyhashGen1220xyz', 'USER', 'ACTIVE', '2022-04-09 00:33:30'),
('FatalCrusader17', 'fatalcrusader17528@yahoo.com', '$2a$10$dummyhashGen1480xyz', 'USER', 'ACTIVE', '2022-04-12 22:22:40'),
('OmegaSlayer5278', 'omegaslayer5278623@yahoo.com', '$2a$10$dummyhashGen1163xyz', 'USER', 'ACTIVE', '2022-04-13 00:48:40'),
('xFatalOutlawx', 'xfataloutlawx37@gmail.com', '$2a$10$dummyhashGen1131xyz', 'USER', 'ACTIVE', '2022-04-17 06:54:37'),
('SilentSamurai8451', 'silentsamurai845148@gmail.com', '$2a$10$dummyhashGen1414xyz', 'USER', 'ACTIVE', '2022-04-18 01:45:49'),
('xDemonicGoblinx', 'xdemonicgoblinx278@gmail.com', '$2a$10$dummyhashGen1330xyz', 'USER', 'ACTIVE', '2022-04-26 11:53:47'),
('CosmicAssassin3947', 'cosmicassassin3947900@gmail.com', '$2a$10$dummyhashGen1020xyz', 'USER', 'ACTIVE', '2022-05-03 08:16:32'),
('CrimsonSpirit11', 'crimsonspirit11997@gmail.com', '$2a$10$dummyhashGen1005xyz', 'USER', 'ACTIVE', '2022-05-03 09:53:03'),
('BrutalViper15', 'brutalviper15295@hotmail.com', '$2a$10$dummyhashGen1272xyz', 'USER', 'ACTIVE', '2022-05-03 18:25:51');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('Knight3405TV', 'knight3405tv271@hotmail.com', '$2a$10$dummyhashGen1104xyz', 'USER', 'ACTIVE', '2022-05-07 02:53:17'),
('ElectricGoblin155', 'electricgoblin155720@yahoo.com', '$2a$10$dummyhashGen1328xyz', 'USER', 'ACTIVE', '2022-05-09 10:45:43'),
('xSinisterSpecterx', 'xsinisterspecterx679@gmail.com', '$2a$10$dummyhashGen1077xyz', 'USER', 'ACTIVE', '2022-05-11 09:47:17'),
('RogueBlade69', 'rogueblade69272@gmail.com', '$2a$10$dummyhashGen1425xyz', 'USER', 'ACTIVE', '2022-05-21 11:08:06'),
('GoldenSamurai77', 'goldensamurai77651@gmail.com', '$2a$10$dummyhashGen1113xyz', 'USER', 'ACTIVE', '2022-05-22 17:45:48'),
('PhantomHawk7', 'phantomhawk7566@gmail.com', '$2a$10$dummyhashGen1119xyz', 'USER', 'ACTIVE', '2022-05-25 19:05:27'),
('ElectricSniper4962', 'electricsniper4962630@gmail.com', '$2a$10$dummyhashGen1244xyz', 'USER', 'ACTIVE', '2022-05-26 03:15:48'),
('LuckyBlade420', 'luckyblade420564@yahoo.com', '$2a$10$dummyhashGen1428xyz', 'USER', 'ACTIVE', '2022-05-28 03:36:51'),
('BlazeNinja4987', 'blazeninja4987505@gmail.com', '$2a$10$dummyhashGen1150xyz', 'USER', 'ACTIVE', '2022-05-31 23:34:49'),
('xIronBladex', 'xironbladex828@gmail.com', '$2a$10$dummyhashGen1030xyz', 'USER', 'INACTIVE', '2022-06-02 02:18:07');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('bandit5652', 'bandit565226@gmail.com', '$2a$10$dummyhashGen1356xyz', 'USER', 'ACTIVE', '2022-06-12 09:52:57'),
('assassin30', 'assassin30807@hotmail.com', '$2a$10$dummyhashGen1051xyz', 'USER', 'ACTIVE', '2022-06-17 22:05:49'),
('goblin6036', 'goblin6036340@hotmail.com', '$2a$10$dummyhashGen1262xyz', 'USER', 'ACTIVE', '2022-06-20 06:21:18'),
('Tiger8851PH', 'tiger8851ph818@yahoo.com', '$2a$10$dummyhashGen1158xyz', 'USER', 'ACTIVE', '2022-06-20 18:21:04'),
('Pirate334YT', 'pirate334yt157@yahoo.com', '$2a$10$dummyhashGen1081xyz', 'USER', 'ACTIVE', '2022-07-16 01:51:32'),
('Crusader8475PH', 'crusader8475ph171@outlook.com', '$2a$10$dummyhashGen1407xyz', 'USER', 'ACTIVE', '2022-07-17 04:18:57'),
('ElectricSniper123', 'electricsniper123626@gmail.com', '$2a$10$dummyhashGen1257xyz', 'USER', 'ACTIVE', '2022-07-19 20:55:07'),
('RoyalHunter93', 'royalhunter93130@hotmail.com', '$2a$10$dummyhashGen1380xyz', 'USER', 'ACTIVE', '2022-07-26 03:04:25'),
('FrostKnight3497', 'frostknight3497489@gmail.com', '$2a$10$dummyhashGen1390xyz', 'USER', 'ACTIVE', '2022-07-26 03:24:24'),
('FatalMarauder21', 'fatalmarauder21469@gmail.com', '$2a$10$dummyhashGen1344xyz', 'USER', 'ACTIVE', '2022-07-30 11:24:56');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('venom_demon39', 'venom_demon3977@yahoo.com', '$2a$10$dummyhashGen1423xyz', 'USER', 'ACTIVE', '2022-07-31 10:37:02'),
('ElectricGoblin1438', 'electricgoblin1438287@gmail.com', '$2a$10$dummyhashGen1434xyz', 'USER', 'ACTIVE', '2022-08-02 04:31:46'),
('FrozenRider3272', 'frozenrider3272821@gmail.com', '$2a$10$dummyhashGen1206xyz', 'USER', 'ACTIVE', '2022-08-03 23:52:16'),
('Samurai9092TV', 'samurai9092tv502@outlook.com', '$2a$10$dummyhashGen1369xyz', 'USER', 'ACTIVE', '2022-08-06 22:38:02'),
('solar_warrior', 'solar_warrior107@gmail.com', '$2a$10$dummyhashGen1450xyz', 'USER', 'ACTIVE', '2022-08-07 11:33:53'),
('xFrostPhoenixx', 'xfrostphoenixx852@hotmail.com', '$2a$10$dummyhashGen1357xyz', 'USER', 'ACTIVE', '2022-08-09 02:02:00'),
('beast8154', 'beast8154935@gmail.com', '$2a$10$dummyhashGen1135xyz', 'USER', 'ACTIVE', '2022-08-11 07:48:55'),
('GoldenHawk54', 'goldenhawk547@yahoo.com', '$2a$10$dummyhashGen1173xyz', 'USER', 'ACTIVE', '2022-08-11 12:48:09'),
('BurningGoblin3693', 'burninggoblin3693308@hotmail.com', '$2a$10$dummyhashGen1309xyz', 'USER', 'ACTIVE', '2022-08-13 05:49:23'),
('FrostFalcon67', 'frostfalcon67928@gmail.com', '$2a$10$dummyhashGen1208xyz', 'USER', 'ACTIVE', '2022-08-17 21:33:21');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('pirate73', 'pirate73410@yahoo.com', '$2a$10$dummyhashGen1065xyz', 'USER', 'ACTIVE', '2022-08-18 05:51:30'),
('ToxicOutlaw6050', 'toxicoutlaw6050597@gmail.com', '$2a$10$dummyhashGen1047xyz', 'USER', 'ACTIVE', '2022-08-19 01:20:11'),
('crusader24', 'crusader24425@yahoo.com', '$2a$10$dummyhashGen1472xyz', 'USER', 'ACTIVE', '2022-08-19 05:17:12'),
('marauder3523', 'marauder3523856@outlook.com', '$2a$10$dummyhashGen1426xyz', 'USER', 'ACTIVE', '2022-08-19 09:54:43'),
('GoldenTitan79', 'goldentitan7983@yahoo.com', '$2a$10$dummyhashGen1071xyz', 'USER', 'ACTIVE', '2022-08-23 07:22:28'),
('ElectricGladiator420', 'electricgladiator420428@outlook.com', '$2a$10$dummyhashGen1318xyz', 'USER', 'ACTIVE', '2022-08-25 18:18:33'),
('LuckyReaper99', 'luckyreaper99551@gmail.com', '$2a$10$dummyhashGen1402xyz', 'USER', 'ACTIVE', '2022-08-26 04:20:22'),
('SolarPanther1205', 'solarpanther120585@outlook.com', '$2a$10$dummyhashGen1337xyz', 'USER', 'ACTIVE', '2022-08-28 13:46:27'),
('xSolarTigerx', 'xsolartigerx612@gmail.com', '$2a$10$dummyhashGen1202xyz', 'USER', 'ACTIVE', '2022-08-28 14:57:35'),
('RogueTitan34', 'roguetitan34232@yahoo.com', '$2a$10$dummyhashGen1200xyz', 'USER', 'ACTIVE', '2022-08-29 16:46:29');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('CosmicDemon111', 'cosmicdemon11187@gmail.com', '$2a$10$dummyhashGen1175xyz', 'USER', 'ACTIVE', '2022-08-30 16:26:21'),
('SinisterGoblin999', 'sinistergoblin999874@gmail.com', '$2a$10$dummyhashGen1035xyz', 'USER', 'INACTIVE', '2022-09-02 13:31:03'),
('silent_ninja68', 'silent_ninja6817@gmail.com', '$2a$10$dummyhashGen1386xyz', 'USER', 'ACTIVE', '2022-09-03 10:03:08'),
('SilentPanther88', 'silentpanther88429@yahoo.com', '$2a$10$dummyhashGen1251xyz', 'USER', 'ACTIVE', '2022-09-06 02:02:05'),
('LethalHunter11', 'lethalhunter11477@outlook.com', '$2a$10$dummyhashGen1287xyz', 'USER', 'ACTIVE', '2022-09-06 02:40:29'),
('LuckyCobra777', 'luckycobra777768@hotmail.com', '$2a$10$dummyhashGen1229xyz', 'USER', 'ACTIVE', '2022-09-06 12:44:14'),
('Slayer5601TV', 'slayer5601tv910@gmail.com', '$2a$10$dummyhashGen1456xyz', 'USER', 'ACTIVE', '2022-09-07 22:57:15'),
('royal_berserker', 'royal_berserker948@yahoo.com', '$2a$10$dummyhashGen1049xyz', 'USER', 'ACTIVE', '2022-09-10 10:30:17'),
('reaper13', 'reaper13396@gmail.com', '$2a$10$dummyhashGen1485xyz', 'USER', 'ACTIVE', '2022-09-11 01:37:41'),
('ChaoticHunter8489', 'chaotichunter8489157@outlook.com', '$2a$10$dummyhashGen1242xyz', 'USER', 'ACTIVE', '2022-09-13 18:51:39');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('SinisterRanger111', 'sinisterranger111648@gmail.com', '$2a$10$dummyhashGen1377xyz', 'USER', 'ACTIVE', '2022-09-15 20:14:35'),
('RogueSpirit23', 'roguespirit23786@outlook.com', '$2a$10$dummyhashGen1082xyz', 'USER', 'ACTIVE', '2022-09-18 15:37:57'),
('LethalCrusader82', 'lethalcrusader82699@yahoo.com', '$2a$10$dummyhashGen1134xyz', 'USER', 'ACTIVE', '2022-09-22 01:26:59'),
('berserker1971', 'berserker1971973@gmail.com', '$2a$10$dummyhashGen1468xyz', 'USER', 'ACTIVE', '2022-09-26 13:23:42'),
('ShadowRanger9648', 'shadowranger9648332@gmail.com', '$2a$10$dummyhashGen1159xyz', 'USER', 'ACTIVE', '2022-09-28 16:22:09'),
('legend13', 'legend13119@outlook.com', '$2a$10$dummyhashGen1054xyz', 'USER', 'ACTIVE', '2022-10-05 09:29:26'),
('NeonKnight4854', 'neonknight4854233@outlook.com', '$2a$10$dummyhashGen1097xyz', 'USER', 'ACTIVE', '2022-10-06 18:03:56'),
('Slayer7735Gaming', 'slayer7735gaming294@gmail.com', '$2a$10$dummyhashGen1297xyz', 'USER', 'ACTIVE', '2022-10-07 14:11:24'),
('beast13', 'beast13507@outlook.com', '$2a$10$dummyhashGen1090xyz', 'USER', 'ACTIVE', '2022-10-10 11:28:52'),
('FrozenRanger9033', 'frozenranger9033656@gmail.com', '$2a$10$dummyhashGen1241xyz', 'USER', 'ACTIVE', '2022-10-10 16:04:38');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('CrazyAssassin54', 'crazyassassin54159@outlook.com', '$2a$10$dummyhashGen1301xyz', 'USER', 'ACTIVE', '2022-10-20 19:03:37'),
('outlaw68', 'outlaw68956@outlook.com', '$2a$10$dummyhashGen1125xyz', 'USER', 'ACTIVE', '2022-10-21 01:28:12'),
('LuckyOutlaw42', 'luckyoutlaw4238@hotmail.com', '$2a$10$dummyhashGen1222xyz', 'USER', 'ACTIVE', '2022-10-24 20:51:08'),
('MysticKnight8592', 'mysticknight8592153@yahoo.com', '$2a$10$dummyhashGen1325xyz', 'USER', 'ACTIVE', '2022-10-26 03:44:44'),
('xBlazeBanditx', 'xblazebanditx480@outlook.com', '$2a$10$dummyhashGen1282xyz', 'USER', 'ACTIVE', '2022-10-27 12:31:47'),
('reaper19', 'reaper1923@gmail.com', '$2a$10$dummyhashGen1430xyz', 'USER', 'ACTIVE', '2022-11-04 04:40:00'),
('samurai75', 'samurai75230@gmail.com', '$2a$10$dummyhashGen1237xyz', 'USER', 'ACTIVE', '2022-11-09 05:05:28'),
('WickedBerserker90', 'wickedberserker90453@gmail.com', '$2a$10$dummyhashGen1117xyz', 'USER', 'ACTIVE', '2022-11-13 05:12:04'),
('PhantomDemon88', 'phantomdemon88120@hotmail.com', '$2a$10$dummyhashGen1293xyz', 'USER', 'ACTIVE', '2022-11-16 01:55:20'),
('striker878', 'striker878104@outlook.com', '$2a$10$dummyhashGen1458xyz', 'USER', 'ACTIVE', '2022-11-16 07:28:37');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('SinisterStriker10', 'sinisterstriker10722@yahoo.com', '$2a$10$dummyhashGen1362xyz', 'USER', 'ACTIVE', '2022-11-16 16:12:05'),
('RoyalMarauder11', 'royalmarauder11193@gmail.com', '$2a$10$dummyhashGen1479xyz', 'USER', 'ACTIVE', '2022-11-25 09:12:32'),
('SneakySamurai4263', 'sneakysamurai4263389@outlook.com', '$2a$10$dummyhashGen1078xyz', 'USER', 'ACTIVE', '2022-11-25 19:16:02'),
('Assassin2725Live', 'assassin2725live498@gmail.com', '$2a$10$dummyhashGen1031xyz', 'USER', 'ACTIVE', '2022-11-29 01:04:36'),
('DarkReaper74', 'darkreaper74469@yahoo.com', '$2a$10$dummyhashGen1253xyz', 'USER', 'ACTIVE', '2022-12-01 05:09:55'),
('RogueViper88', 'rogueviper88704@gmail.com', '$2a$10$dummyhashGen1394xyz', 'USER', 'ACTIVE', '2022-12-04 11:28:07'),
('RogueCobra62', 'roguecobra6247@gmail.com', '$2a$10$dummyhashGen1317xyz', 'USER', 'ACTIVE', '2022-12-10 17:41:46'),
('ShadowGoblin2838', 'shadowgoblin2838616@gmail.com', '$2a$10$dummyhashGen1487xyz', 'USER', 'ACTIVE', '2022-12-14 14:45:05'),
('titan3849', 'titan3849689@outlook.com', '$2a$10$dummyhashGen1063xyz', 'USER', 'ACTIVE', '2022-12-15 23:12:39'),
('WickedBlade88', 'wickedblade88124@yahoo.com', '$2a$10$dummyhashGen1023xyz', 'USER', 'ACTIVE', '2022-12-16 01:19:26');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('ElectricRider111', 'electricrider111810@gmail.com', '$2a$10$dummyhashGen1102xyz', 'USER', 'ACTIVE', '2022-12-17 14:13:34'),
('maverick5314', 'maverick5314864@gmail.com', '$2a$10$dummyhashGen1010xyz', 'USER', 'ACTIVE', '2022-12-22 19:31:51'),
('GhostSpecter8654', 'ghostspecter8654942@gmail.com', '$2a$10$dummyhashGen1329xyz', 'USER', 'ACTIVE', '2022-12-23 22:18:57'),
('xIronMarauderx', 'xironmarauderx70@hotmail.com', '$2a$10$dummyhashGen1036xyz', 'USER', 'ACTIVE', '2023-01-01 09:02:12'),
('Ninja6071TV', 'ninja6071tv455@gmail.com', '$2a$10$dummyhashGen1153xyz', 'USER', 'ACTIVE', '2023-01-02 18:55:01'),
('BrutalRanger888', 'brutalranger888661@yahoo.com', '$2a$10$dummyhashGen1186xyz', 'USER', 'ACTIVE', '2023-01-03 00:44:28'),
('ElectricOutlaw94', 'electricoutlaw94289@outlook.com', '$2a$10$dummyhashGen1459xyz', 'USER', 'ACTIVE', '2023-01-05 00:26:31'),
('electric_marauder', 'electric_marauder114@outlook.com', '$2a$10$dummyhashGen1213xyz', 'USER', 'ACTIVE', '2023-01-05 03:52:11'),
('OmegaBerserker67', 'omegaberserker67240@gmail.com', '$2a$10$dummyhashGen1204xyz', 'USER', 'ACTIVE', '2023-01-07 12:50:52'),
('legend4904', 'legend4904167@gmail.com', '$2a$10$dummyhashGen1332xyz', 'USER', 'ACTIVE', '2023-01-09 13:27:11');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('phoenix6869', 'phoenix6869630@gmail.com', '$2a$10$dummyhashGen1302xyz', 'USER', 'ACTIVE', '2023-01-09 20:41:23'),
('warrior1641', 'warrior1641254@hotmail.com', '$2a$10$dummyhashGen1438xyz', 'USER', 'ACTIVE', '2023-01-10 14:49:40'),
('NeonRider20', 'neonrider20743@gmail.com', '$2a$10$dummyhashGen1341xyz', 'USER', 'ACTIVE', '2023-01-13 02:05:49'),
('DarkReaper38', 'darkreaper38415@hotmail.com', '$2a$10$dummyhashGen1093xyz', 'USER', 'ACTIVE', '2023-01-13 23:04:26'),
('xFrostSniperx', 'xfrostsniperx903@gmail.com', '$2a$10$dummyhashGen1089xyz', 'USER', 'ACTIVE', '2023-01-14 19:53:16'),
('CrimsonBlade123', 'crimsonblade123721@gmail.com', '$2a$10$dummyhashGen1303xyz', 'USER', 'ACTIVE', '2023-01-16 04:21:01'),
('xCrimsonBerserkerx', 'xcrimsonberserkerx635@gmail.com', '$2a$10$dummyhashGen1433xyz', 'USER', 'ACTIVE', '2023-01-17 19:31:14'),
('xOmegaWolfx', 'xomegawolfx272@yahoo.com', '$2a$10$dummyhashGen1452xyz', 'USER', 'ACTIVE', '2023-01-23 15:33:27'),
('Maverick602Live', 'maverick602live91@outlook.com', '$2a$10$dummyhashGen1115xyz', 'USER', 'ACTIVE', '2023-01-28 02:06:40'),
('panther7714', 'panther7714132@hotmail.com', '$2a$10$dummyhashGen1497xyz', 'USER', 'ACTIVE', '2023-02-06 19:14:23');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('Titan7053Gaming', 'titan7053gaming11@gmail.com', '$2a$10$dummyhashGen1354xyz', 'USER', 'ACTIVE', '2023-02-06 22:27:56'),
('BrutalLegend7', 'brutallegend7694@outlook.com', '$2a$10$dummyhashGen1427xyz', 'USER', 'ACTIVE', '2023-02-09 03:43:15'),
('GhostSniper69', 'ghostsniper69883@outlook.com', '$2a$10$dummyhashGen1491xyz', 'USER', 'ACTIVE', '2023-02-10 16:15:44'),
('NightHawk70', 'nighthawk70501@hotmail.com', '$2a$10$dummyhashGen1462xyz', 'USER', 'ACTIVE', '2023-02-16 16:04:48'),
('Knight1201YT', 'knight1201yt219@gmail.com', '$2a$10$dummyhashGen1040xyz', 'USER', 'ACTIVE', '2023-02-16 23:23:17'),
('xPhantomBeastx', 'xphantombeastx3@gmail.com', '$2a$10$dummyhashGen1032xyz', 'USER', 'ACTIVE', '2023-02-16 23:29:11'),
('ElectricKnight40', 'electricknight40478@gmail.com', '$2a$10$dummyhashGen1250xyz', 'USER', 'ACTIVE', '2023-02-20 12:04:00'),
('rogue_warrior', 'rogue_warrior694@yahoo.com', '$2a$10$dummyhashGen1486xyz', 'USER', 'ACTIVE', '2023-02-23 00:09:46'),
('outlaw2678', 'outlaw2678474@gmail.com', '$2a$10$dummyhashGen1009xyz', 'USER', 'ACTIVE', '2023-02-24 08:23:03'),
('SilverGoblin3311', 'silvergoblin3311848@gmail.com', '$2a$10$dummyhashGen1273xyz', 'USER', 'ACTIVE', '2023-02-26 04:33:37');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('xNightDragonx', 'xnightdragonx344@gmail.com', '$2a$10$dummyhashGen1408xyz', 'USER', 'ACTIVE', '2023-02-27 12:10:17'),
('berserker51', 'berserker5131@hotmail.com', '$2a$10$dummyhashGen1335xyz', 'USER', 'ACTIVE', '2023-03-01 14:22:12'),
('CrimsonSpirit5905', 'crimsonspirit5905722@yahoo.com', '$2a$10$dummyhashGen1482xyz', 'USER', 'ACTIVE', '2023-03-02 14:37:17'),
('AlphaSamurai37', 'alphasamurai37931@yahoo.com', '$2a$10$dummyhashGen1432xyz', 'USER', 'ACTIVE', '2023-03-04 04:03:48'),
('WickedOutlaw69', 'wickedoutlaw6963@gmail.com', '$2a$10$dummyhashGen1154xyz', 'USER', 'ACTIVE', '2023-03-05 13:36:20'),
('WildBandit999', 'wildbandit999140@gmail.com', '$2a$10$dummyhashGen1122xyz', 'USER', 'ACTIVE', '2023-03-06 03:14:58'),
('SavageOutlaw27', 'savageoutlaw27433@yahoo.com', '$2a$10$dummyhashGen1029xyz', 'USER', 'ACTIVE', '2023-03-09 16:54:56'),
('BrutalGamer88', 'brutalgamer88197@yahoo.com', '$2a$10$dummyhashGen1269xyz', 'USER', 'ACTIVE', '2023-03-10 10:06:44'),
('xGhostBanditx', 'xghostbanditx274@gmail.com', '$2a$10$dummyhashGen1123xyz', 'USER', 'ACTIVE', '2023-03-16 09:00:05'),
('RogueBandit5656', 'roguebandit5656441@gmail.com', '$2a$10$dummyhashGen1177xyz', 'USER', 'ACTIVE', '2023-03-17 00:11:37');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('bandit31', 'bandit31675@gmail.com', '$2a$10$dummyhashGen1062xyz', 'USER', 'ACTIVE', '2023-03-17 20:19:26'),
('spirit95', 'spirit9510@gmail.com', '$2a$10$dummyhashGen1136xyz', 'USER', 'ACTIVE', '2023-03-23 19:41:08'),
('SilentSpecter21', 'silentspecter21372@gmail.com', '$2a$10$dummyhashGen1256xyz', 'USER', 'ACTIVE', '2023-03-25 07:51:04'),
('CrazyOutlaw925', 'crazyoutlaw925144@gmail.com', '$2a$10$dummyhashGen1304xyz', 'USER', 'ACTIVE', '2023-03-26 08:31:23'),
('fatal_falcon13', 'fatal_falcon13815@yahoo.com', '$2a$10$dummyhashGen1372xyz', 'USER', 'INACTIVE', '2023-03-30 17:54:04'),
('dragon5315', 'dragon5315816@gmail.com', '$2a$10$dummyhashGen1133xyz', 'USER', 'ACTIVE', '2023-04-01 17:32:36'),
('samurai49', 'samurai49752@hotmail.com', '$2a$10$dummyhashGen1448xyz', 'USER', 'ACTIVE', '2023-04-03 12:23:58'),
('gladiator58', 'gladiator58612@gmail.com', '$2a$10$dummyhashGen1164xyz', 'USER', 'ACTIVE', '2023-04-04 02:35:05'),
('DemonicWarrior7394', 'demonicwarrior739476@gmail.com', '$2a$10$dummyhashGen1455xyz', 'USER', 'SUSPENDED', '2023-04-04 02:59:24'),
('NeonDemon1312', 'neondemon1312336@hotmail.com', '$2a$10$dummyhashGen1226xyz', 'USER', 'ACTIVE', '2023-04-05 06:15:22');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('AlphaKnight888', 'alphaknight888670@yahoo.com', '$2a$10$dummyhashGen1375xyz', 'USER', 'ACTIVE', '2023-04-08 11:23:36'),
('Cobra9199YT', 'cobra9199yt624@outlook.com', '$2a$10$dummyhashGen1490xyz', 'USER', 'ACTIVE', '2023-04-09 15:59:20'),
('CosmicViper99', 'cosmicviper99227@gmail.com', '$2a$10$dummyhashGen1306xyz', 'USER', 'ACTIVE', '2023-04-12 19:29:15'),
('AlphaPirate999', 'alphapirate999136@hotmail.com', '$2a$10$dummyhashGen1387xyz', 'USER', 'ACTIVE', '2023-04-14 22:21:42'),
('SinisterMaverick7855', 'sinistermaverick7855214@outlook.com', '$2a$10$dummyhashGen1313xyz', 'USER', 'ACTIVE', '2023-04-16 23:40:07'),
('hunter2445', 'hunter2445831@gmail.com', '$2a$10$dummyhashGen1101xyz', 'USER', 'ACTIVE', '2023-04-17 23:48:32'),
('panther25', 'panther25480@hotmail.com', '$2a$10$dummyhashGen1109xyz', 'USER', 'ACTIVE', '2023-04-18 09:20:28'),
('toxic_beast23', 'toxic_beast2394@gmail.com', '$2a$10$dummyhashGen1338xyz', 'USER', 'ACTIVE', '2023-04-24 21:02:37'),
('blaze_knight', 'blaze_knight662@gmail.com', '$2a$10$dummyhashGen1142xyz', 'USER', 'ACTIVE', '2023-04-25 21:51:09'),
('GhostSpirit63', 'ghostspirit63748@gmail.com', '$2a$10$dummyhashGen1166xyz', 'USER', 'ACTIVE', '2023-05-01 12:38:49');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('xSinisterReaperx', 'xsinisterreaperx689@yahoo.com', '$2a$10$dummyhashGen1366xyz', 'USER', 'ACTIVE', '2023-05-02 12:24:39'),
('viper2694', 'viper2694461@gmail.com', '$2a$10$dummyhashGen1424xyz', 'USER', 'ACTIVE', '2023-05-03 20:00:34'),
('NightGladiator77', 'nightgladiator77360@gmail.com', '$2a$10$dummyhashGen1395xyz', 'USER', 'ACTIVE', '2023-05-04 13:32:47'),
('lucky_sniper82', 'lucky_sniper82898@hotmail.com', '$2a$10$dummyhashGen1011xyz', 'USER', 'ACTIVE', '2023-05-04 20:02:30'),
('CosmicGamer1977', 'cosmicgamer1977739@yahoo.com', '$2a$10$dummyhashGen1095xyz', 'USER', 'ACTIVE', '2023-05-06 04:28:48'),
('FrostTitan888', 'frosttitan888547@gmail.com', '$2a$10$dummyhashGen1130xyz', 'USER', 'ACTIVE', '2023-05-07 21:59:00'),
('bandit5374', 'bandit5374954@gmail.com', '$2a$10$dummyhashGen1260xyz', 'USER', 'ACTIVE', '2023-05-10 19:39:37'),
('xRecklessPiratex', 'xrecklesspiratex775@outlook.com', '$2a$10$dummyhashGen1277xyz', 'USER', 'ACTIVE', '2023-05-14 21:59:59'),
('Ninja7369YT', 'ninja7369yt668@yahoo.com', '$2a$10$dummyhashGen1192xyz', 'USER', 'ACTIVE', '2023-05-15 11:23:11'),
('slayer8797', 'slayer8797192@outlook.com', '$2a$10$dummyhashGen1363xyz', 'USER', 'ACTIVE', '2023-05-22 09:35:54');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('BurningPirate65', 'burningpirate6572@hotmail.com', '$2a$10$dummyhashGen1057xyz', 'USER', 'ACTIVE', '2023-05-28 22:44:58'),
('goblin64', 'goblin64764@gmail.com', '$2a$10$dummyhashGen1094xyz', 'USER', 'ACTIVE', '2023-05-29 20:47:36'),
('SneakyGamer13', 'sneakygamer1315@hotmail.com', '$2a$10$dummyhashGen1283xyz', 'USER', 'ACTIVE', '2023-06-08 16:27:10'),
('DemonicAssassin80', 'demonicassassin80671@hotmail.com', '$2a$10$dummyhashGen1319xyz', 'USER', 'ACTIVE', '2023-06-09 09:18:31'),
('xToxicSlayerx', 'xtoxicslayerx481@outlook.com', '$2a$10$dummyhashGen1129xyz', 'USER', 'ACTIVE', '2023-06-10 22:28:39'),
('SinisterSniper2616', 'sinistersniper2616715@gmail.com', '$2a$10$dummyhashGen1003xyz', 'USER', 'ACTIVE', '2023-06-13 13:27:31'),
('Gamer267PH', 'gamer267ph808@gmail.com', '$2a$10$dummyhashGen1218xyz', 'USER', 'ACTIVE', '2023-06-20 15:10:07'),
('CosmicMarauder9273', 'cosmicmarauder9273802@gmail.com', '$2a$10$dummyhashGen1085xyz', 'USER', 'ACTIVE', '2023-06-24 08:41:40'),
('ChaoticWizard7901', 'chaoticwizard7901230@gmail.com', '$2a$10$dummyhashGen1170xyz', 'USER', 'ACTIVE', '2023-06-28 21:11:44'),
('silent_warrior', 'silent_warrior817@gmail.com', '$2a$10$dummyhashGen1439xyz', 'USER', 'ACTIVE', '2023-07-06 04:04:31');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('samurai93', 'samurai9392@yahoo.com', '$2a$10$dummyhashGen1498xyz', 'USER', 'ACTIVE', '2023-07-06 21:55:30'),
('RoyalSamurai123', 'royalsamurai12388@gmail.com', '$2a$10$dummyhashGen1216xyz', 'USER', 'ACTIVE', '2023-07-15 04:16:57'),
('GoldenRider71', 'goldenrider71802@gmail.com', '$2a$10$dummyhashGen1343xyz', 'USER', 'ACTIVE', '2023-07-15 23:42:45'),
('DarkDemon7539', 'darkdemon7539852@hotmail.com', '$2a$10$dummyhashGen1183xyz', 'USER', 'ACTIVE', '2023-07-17 02:50:46'),
('OmegaBlade99', 'omegablade99625@yahoo.com', '$2a$10$dummyhashGen1194xyz', 'USER', 'ACTIVE', '2023-07-20 07:05:57'),
('solar_falcon', 'solar_falcon45@gmail.com', '$2a$10$dummyhashGen1203xyz', 'USER', 'ACTIVE', '2023-07-20 22:03:59'),
('Assassin5340Live', 'assassin5340live288@gmail.com', '$2a$10$dummyhashGen1348xyz', 'USER', 'ACTIVE', '2023-07-22 00:45:56'),
('Viper3697Live', 'viper3697live991@gmail.com', '$2a$10$dummyhashGen1146xyz', 'USER', 'ACTIVE', '2023-07-23 05:04:56'),
('CosmicPhoenix999', 'cosmicphoenix999964@outlook.com', '$2a$10$dummyhashGen1288xyz', 'USER', 'ACTIVE', '2023-07-25 23:01:47'),
('CrazyBeast1679', 'crazybeast1679106@outlook.com', '$2a$10$dummyhashGen1392xyz', 'USER', 'ACTIVE', '2023-07-25 23:41:34');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('DemonicNinja13', 'demonicninja13696@gmail.com', '$2a$10$dummyhashGen1231xyz', 'USER', 'ACTIVE', '2023-07-31 06:33:33'),
('Sniper1530PH', 'sniper1530ph257@gmail.com', '$2a$10$dummyhashGen1388xyz', 'USER', 'ACTIVE', '2023-08-01 15:20:25'),
('BlazeGoblin7455', 'blazegoblin7455766@gmail.com', '$2a$10$dummyhashGen1289xyz', 'USER', 'ACTIVE', '2023-08-04 09:44:37'),
('xFatalBeastx', 'xfatalbeastx360@gmail.com', '$2a$10$dummyhashGen1454xyz', 'USER', 'ACTIVE', '2023-08-07 01:58:18'),
('royal_cobra', 'royal_cobra392@gmail.com', '$2a$10$dummyhashGen1298xyz', 'USER', 'ACTIVE', '2023-08-10 10:05:02'),
('maverick3144', 'maverick3144431@hotmail.com', '$2a$10$dummyhashGen1059xyz', 'USER', 'ACTIVE', '2023-08-12 23:33:37'),
('GoldenPanther9396', 'goldenpanther9396693@gmail.com', '$2a$10$dummyhashGen1271xyz', 'USER', 'ACTIVE', '2023-08-13 20:01:30'),
('RoyalBeast420', 'royalbeast42021@gmail.com', '$2a$10$dummyhashGen1073xyz', 'USER', 'ACTIVE', '2023-08-14 21:37:57'),
('savage_beast', 'savage_beast110@yahoo.com', '$2a$10$dummyhashGen1138xyz', 'USER', 'ACTIVE', '2023-08-16 10:17:29'),
('crusader8908', 'crusader8908814@gmail.com', '$2a$10$dummyhashGen1435xyz', 'USER', 'ACTIVE', '2023-08-18 04:33:43');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('BurningRaptor82', 'burningraptor82515@outlook.com', '$2a$10$dummyhashGen1436xyz', 'USER', 'ACTIVE', '2023-08-27 07:54:12'),
('lethal_striker', 'lethal_striker537@gmail.com', '$2a$10$dummyhashGen1184xyz', 'USER', 'ACTIVE', '2023-09-07 19:15:06'),
('CrazyBlade13', 'crazyblade13425@gmail.com', '$2a$10$dummyhashGen1209xyz', 'USER', 'ACTIVE', '2023-09-08 20:52:30'),
('WildViper50', 'wildviper50752@outlook.com', '$2a$10$dummyhashGen1249xyz', 'USER', 'ACTIVE', '2023-09-12 09:13:57'),
('SilentGamer24', 'silentgamer24842@gmail.com', '$2a$10$dummyhashGen1100xyz', 'USER', 'ACTIVE', '2023-09-15 11:27:22'),
('GoldenLegend9973', 'goldenlegend9973698@hotmail.com', '$2a$10$dummyhashGen1475xyz', 'USER', 'SUSPENDED', '2023-09-17 01:12:12'),
('OmegaSlayer777', 'omegaslayer777902@gmail.com', '$2a$10$dummyhashGen1382xyz', 'USER', 'ACTIVE', '2023-09-18 19:21:55'),
('Beast8593PH', 'beast8593ph714@gmail.com', '$2a$10$dummyhashGen1308xyz', 'USER', 'ACTIVE', '2023-09-27 05:00:19'),
('phoenix74', 'phoenix74317@hotmail.com', '$2a$10$dummyhashGen1058xyz', 'USER', 'ACTIVE', '2023-09-27 09:59:28'),
('VenomRider6766', 'venomrider6766708@yahoo.com', '$2a$10$dummyhashGen1266xyz', 'USER', 'ACTIVE', '2023-09-30 11:58:43');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('ChaoticBlade7430', 'chaoticblade7430136@gmail.com', '$2a$10$dummyhashGen1294xyz', 'USER', 'ACTIVE', '2023-10-08 08:09:02'),
('WickedTiger4836', 'wickedtiger4836335@hotmail.com', '$2a$10$dummyhashGen1143xyz', 'USER', 'ACTIVE', '2023-10-08 11:04:41'),
('SneakySlayer7', 'sneakyslayer7162@gmail.com', '$2a$10$dummyhashGen1248xyz', 'USER', 'ACTIVE', '2023-10-08 15:30:06'),
('CrimsonSpecter93', 'crimsonspecter93216@gmail.com', '$2a$10$dummyhashGen1246xyz', 'USER', 'ACTIVE', '2023-10-10 03:28:51'),
('MysticCobra13', 'mysticcobra13524@gmail.com', '$2a$10$dummyhashGen1367xyz', 'USER', 'ACTIVE', '2023-10-12 17:05:02'),
('StormWolf6324', 'stormwolf6324449@hotmail.com', '$2a$10$dummyhashGen1453xyz', 'USER', 'ACTIVE', '2023-10-14 21:48:22'),
('ToxicDragon8692', 'toxicdragon8692221@gmail.com', '$2a$10$dummyhashGen1174xyz', 'USER', 'ACTIVE', '2023-10-15 04:29:23'),
('ShadowCobra26', 'shadowcobra26397@gmail.com', '$2a$10$dummyhashGen1399xyz', 'USER', 'ACTIVE', '2023-10-16 18:55:47'),
('night_viper', 'night_viper812@hotmail.com', '$2a$10$dummyhashGen1014xyz', 'USER', 'ACTIVE', '2023-10-18 19:15:51'),
('OmegaWolf5630', 'omegawolf5630837@gmail.com', '$2a$10$dummyhashGen1391xyz', 'USER', 'ACTIVE', '2023-10-19 01:00:16');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('dragon7848', 'dragon7848868@gmail.com', '$2a$10$dummyhashGen1162xyz', 'USER', 'ACTIVE', '2023-10-25 04:37:56'),
('lethal_crusader30', 'lethal_crusader30339@gmail.com', '$2a$10$dummyhashGen1360xyz', 'USER', 'ACTIVE', '2023-10-25 08:12:09'),
('ElectricRaptor894', 'electricraptor894370@gmail.com', '$2a$10$dummyhashGen1460xyz', 'USER', 'ACTIVE', '2023-10-27 06:18:20'),
('gamer7240', 'gamer7240565@hotmail.com', '$2a$10$dummyhashGen1046xyz', 'USER', 'ACTIVE', '2023-10-27 09:19:26'),
('SneakyRanger8757', 'sneakyranger8757408@yahoo.com', '$2a$10$dummyhashGen1384xyz', 'USER', 'ACTIVE', '2023-10-30 10:15:20'),
('knight9034', 'knight9034739@yahoo.com', '$2a$10$dummyhashGen1165xyz', 'USER', 'ACTIVE', '2023-10-31 02:10:10'),
('Titan6225PH', 'titan6225ph451@outlook.com', '$2a$10$dummyhashGen1345xyz', 'USER', 'ACTIVE', '2023-10-31 22:32:10'),
('BurningSniper69', 'burningsniper69115@outlook.com', '$2a$10$dummyhashGen1016xyz', 'USER', 'ACTIVE', '2023-11-07 09:13:24'),
('RogueCrusader54', 'roguecrusader54488@gmail.com', '$2a$10$dummyhashGen1358xyz', 'USER', 'ACTIVE', '2023-11-12 16:00:36'),
('GoldenCrusader90', 'goldencrusader90245@outlook.com', '$2a$10$dummyhashGen1070xyz', 'USER', 'ACTIVE', '2023-11-15 07:38:20');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('demon7206', 'demon720670@gmail.com', '$2a$10$dummyhashGen1189xyz', 'USER', 'ACTIVE', '2023-11-18 22:42:41'),
('xBlazeHawkx', 'xblazehawkx998@hotmail.com', '$2a$10$dummyhashGen1478xyz', 'USER', 'ACTIVE', '2023-11-20 08:21:39'),
('xOmegaFalconx', 'xomegafalconx762@gmail.com', '$2a$10$dummyhashGen1069xyz', 'USER', 'ACTIVE', '2023-12-01 03:49:00'),
('sinister_hunter19', 'sinister_hunter19318@gmail.com', '$2a$10$dummyhashGen1190xyz', 'USER', 'SUSPENDED', '2023-12-04 00:34:12'),
('frost_warrior', 'frost_warrior390@outlook.com', '$2a$10$dummyhashGen1007xyz', 'USER', 'ACTIVE', '2023-12-06 08:21:40'),
('CrimsonAssassin88', 'crimsonassassin88871@gmail.com', '$2a$10$dummyhashGen1064xyz', 'USER', 'ACTIVE', '2023-12-09 11:08:43'),
('xCosmicDemonx', 'xcosmicdemonx89@gmail.com', '$2a$10$dummyhashGen1415xyz', 'USER', 'INACTIVE', '2023-12-11 12:43:54'),
('CrazyCrusader99', 'crazycrusader99918@outlook.com', '$2a$10$dummyhashGen1420xyz', 'USER', 'ACTIVE', '2023-12-14 04:33:14'),
('BrutalSniper20', 'brutalsniper20383@gmail.com', '$2a$10$dummyhashGen1326xyz', 'USER', 'ACTIVE', '2023-12-15 00:40:34'),
('cosmic_sniper58', 'cosmic_sniper58873@outlook.com', '$2a$10$dummyhashGen1488xyz', 'USER', 'ACTIVE', '2023-12-15 00:41:11');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('crusader50', 'crusader50980@yahoo.com', '$2a$10$dummyhashGen1268xyz', 'USER', 'ACTIVE', '2023-12-16 01:29:54'),
('gladiator9013', 'gladiator901328@hotmail.com', '$2a$10$dummyhashGen1349xyz', 'USER', 'ACTIVE', '2023-12-19 02:31:25'),
('Legend8432Gaming', 'legend8432gaming674@gmail.com', '$2a$10$dummyhashGen1116xyz', 'USER', 'ACTIVE', '2023-12-19 15:43:35'),
('iron_reaper', 'iron_reaper520@gmail.com', '$2a$10$dummyhashGen1191xyz', 'USER', 'ACTIVE', '2023-12-20 19:08:27'),
('maverick7304', 'maverick7304384@gmail.com', '$2a$10$dummyhashGen1355xyz', 'USER', 'ACTIVE', '2023-12-21 08:14:51'),
('RogueStriker111', 'roguestriker111671@outlook.com', '$2a$10$dummyhashGen1061xyz', 'USER', 'ACTIVE', '2023-12-24 08:00:58'),
('Demon3111TV', 'demon3111tv511@gmail.com', '$2a$10$dummyhashGen1252xyz', 'USER', 'ACTIVE', '2023-12-27 04:07:44'),
('FatalDragon80', 'fataldragon80587@outlook.com', '$2a$10$dummyhashGen1238xyz', 'USER', 'ACTIVE', '2023-12-28 02:09:09'),
('Raptor1681Gaming', 'raptor1681gaming588@outlook.com', '$2a$10$dummyhashGen1099xyz', 'USER', 'ACTIVE', '2023-12-31 04:23:11'),
('WickedBandit69', 'wickedbandit69101@hotmail.com', '$2a$10$dummyhashGen1316xyz', 'USER', 'ACTIVE', '2023-12-31 07:52:17');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('FierceSniper42', 'fiercesniper42855@gmail.com', '$2a$10$dummyhashGen1079xyz', 'USER', 'INACTIVE', '2024-01-01 14:18:35'),
('dragon83', 'dragon8342@yahoo.com', '$2a$10$dummyhashGen1112xyz', 'USER', 'ACTIVE', '2024-01-01 21:32:31'),
('ChaoticWolf202', 'chaoticwolf202251@gmail.com', '$2a$10$dummyhashGen1411xyz', 'USER', 'ACTIVE', '2024-01-03 20:39:31'),
('CrazyHunter6772', 'crazyhunter6772339@hotmail.com', '$2a$10$dummyhashGen1275xyz', 'USER', 'ACTIVE', '2024-01-04 20:29:39'),
('FierceWarrior15', 'fiercewarrior15326@hotmail.com', '$2a$10$dummyhashGen1126xyz', 'USER', 'ACTIVE', '2024-01-05 17:49:57'),
('RoyalRaptor777', 'royalraptor777247@hotmail.com', '$2a$10$dummyhashGen1092xyz', 'USER', 'ACTIVE', '2024-01-10 14:02:15'),
('ToxicStriker19', 'toxicstriker19460@gmail.com', '$2a$10$dummyhashGen1351xyz', 'USER', 'ACTIVE', '2024-01-15 11:09:52'),
('sinister_raptor', 'sinister_raptor458@gmail.com', '$2a$10$dummyhashGen1124xyz', 'USER', 'ACTIVE', '2024-01-23 09:33:20'),
('solar_hunter', 'solar_hunter975@gmail.com', '$2a$10$dummyhashGen1370xyz', 'USER', 'ACTIVE', '2024-01-23 19:31:48'),
('warrior38', 'warrior38280@gmail.com', '$2a$10$dummyhashGen1075xyz', 'USER', 'SUSPENDED', '2024-01-25 10:02:45');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('reaper66', 'reaper66678@gmail.com', '$2a$10$dummyhashGen1176xyz', 'USER', 'ACTIVE', '2024-01-25 10:46:50'),
('LuckyPhoenix7', 'luckyphoenix7248@outlook.com', '$2a$10$dummyhashGen1483xyz', 'USER', 'ACTIVE', '2024-01-30 07:17:25'),
('CosmicPanther21', 'cosmicpanther21707@hotmail.com', '$2a$10$dummyhashGen1270xyz', 'USER', 'ACTIVE', '2024-01-30 15:21:22'),
('omega_wizard', 'omega_wizard293@hotmail.com', '$2a$10$dummyhashGen1234xyz', 'USER', 'ACTIVE', '2024-02-03 01:16:14'),
('electric_bandit', 'electric_bandit419@hotmail.com', '$2a$10$dummyhashGen1371xyz', 'USER', 'ACTIVE', '2024-02-03 20:52:10'),
('FierceFalcon4406', 'fiercefalcon4406309@outlook.com', '$2a$10$dummyhashGen1342xyz', 'USER', 'ACTIVE', '2024-02-06 00:59:35'),
('CosmicBerserker7601', 'cosmicberserker7601378@gmail.com', '$2a$10$dummyhashGen1416xyz', 'USER', 'ACTIVE', '2024-02-06 09:49:08'),
('MysticMarauder1235', 'mysticmarauder1235182@hotmail.com', '$2a$10$dummyhashGen1187xyz', 'USER', 'ACTIVE', '2024-02-07 14:01:04'),
('VenomKnight5404', 'venomknight5404422@hotmail.com', '$2a$10$dummyhashGen1114xyz', 'USER', 'ACTIVE', '2024-02-09 16:25:26'),
('xOmegaBeastx', 'xomegabeastx348@yahoo.com', '$2a$10$dummyhashGen1224xyz', 'USER', 'ACTIVE', '2024-02-10 19:47:49');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('night_spirit', 'night_spirit664@yahoo.com', '$2a$10$dummyhashGen1120xyz', 'USER', 'ACTIVE', '2024-02-14 04:47:07'),
('SilentAssassin59', 'silentassassin59116@yahoo.com', '$2a$10$dummyhashGen1398xyz', 'USER', 'ACTIVE', '2024-02-16 01:47:13'),
('SilentLegend23', 'silentlegend23644@hotmail.com', '$2a$10$dummyhashGen1401xyz', 'USER', 'ACTIVE', '2024-02-18 08:27:33'),
('SilentBlade5627', 'silentblade5627732@gmail.com', '$2a$10$dummyhashGen1193xyz', 'USER', 'ACTIVE', '2024-02-23 18:57:00'),
('demon88', 'demon88835@hotmail.com', '$2a$10$dummyhashGen1068xyz', 'USER', 'ACTIVE', '2024-02-24 03:29:38'),
('xNightHunterx', 'xnighthunterx849@gmail.com', '$2a$10$dummyhashGen1292xyz', 'USER', 'ACTIVE', '2024-02-25 05:55:24'),
('GhostMaverick28', 'ghostmaverick28204@gmail.com', '$2a$10$dummyhashGen1258xyz', 'USER', 'ACTIVE', '2024-03-01 21:27:47'),
('Dragon4943TV', 'dragon4943tv531@gmail.com', '$2a$10$dummyhashGen1397xyz', 'USER', 'ACTIVE', '2024-03-02 12:22:41'),
('striker56', 'striker56225@yahoo.com', '$2a$10$dummyhashGen1013xyz', 'USER', 'ACTIVE', '2024-03-02 12:31:01'),
('FrozenBerserker84', 'frozenberserker84105@gmail.com', '$2a$10$dummyhashGen1489xyz', 'USER', 'ACTIVE', '2024-03-05 14:36:48');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('pirate6644', 'pirate6644847@gmail.com', '$2a$10$dummyhashGen1284xyz', 'USER', 'ACTIVE', '2024-03-11 11:03:19'),
('FrostLegend7', 'frostlegend7515@gmail.com', '$2a$10$dummyhashGen1467xyz', 'USER', 'ACTIVE', '2024-03-13 20:20:56'),
('StormStriker2882', 'stormstriker2882824@hotmail.com', '$2a$10$dummyhashGen1066xyz', 'USER', 'ACTIVE', '2024-03-15 14:51:52'),
('CrimsonTiger69', 'crimsontiger69824@gmail.com', '$2a$10$dummyhashGen1259xyz', 'USER', 'ACTIVE', '2024-03-17 18:07:36'),
('blade711', 'blade711745@hotmail.com', '$2a$10$dummyhashGen1161xyz', 'USER', 'ACTIVE', '2024-03-21 01:06:37'),
('warrior9561', 'warrior9561492@yahoo.com', '$2a$10$dummyhashGen1264xyz', 'USER', 'ACTIVE', '2024-03-25 08:47:52'),
('storm_bandit', 'storm_bandit856@hotmail.com', '$2a$10$dummyhashGen1201xyz', 'USER', 'SUSPENDED', '2024-03-28 22:31:19'),
('WildWarrior4603', 'wildwarrior460360@gmail.com', '$2a$10$dummyhashGen1437xyz', 'USER', 'ACTIVE', '2024-04-02 10:39:59'),
('Hawk9728PH', 'hawk9728ph520@gmail.com', '$2a$10$dummyhashGen1261xyz', 'USER', 'ACTIVE', '2024-04-06 23:04:02'),
('LethalMaverick46', 'lethalmaverick46390@gmail.com', '$2a$10$dummyhashGen1315xyz', 'USER', 'ACTIVE', '2024-04-08 23:55:07');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('outlaw5698', 'outlaw5698122@yahoo.com', '$2a$10$dummyhashGen1299xyz', 'USER', 'ACTIVE', '2024-04-14 14:26:53'),
('marauder2505', 'marauder2505383@yahoo.com', '$2a$10$dummyhashGen1018xyz', 'USER', 'ACTIVE', '2024-04-17 21:30:27'),
('ninja54', 'ninja54718@gmail.com', '$2a$10$dummyhashGen1296xyz', 'USER', 'ACTIVE', '2024-04-20 16:02:15'),
('burning_assassin62', 'burning_assassin6225@yahoo.com', '$2a$10$dummyhashGen1417xyz', 'USER', 'ACTIVE', '2024-04-21 06:16:06'),
('wizard6798', 'wizard6798418@outlook.com', '$2a$10$dummyhashGen1072xyz', 'USER', 'ACTIVE', '2024-04-22 22:00:34'),
('xGhostPantherx', 'xghostpantherx466@hotmail.com', '$2a$10$dummyhashGen1281xyz', 'USER', 'ACTIVE', '2024-04-23 23:42:36'),
('knight27', 'knight2746@outlook.com', '$2a$10$dummyhashGen1219xyz', 'USER', 'ACTIVE', '2024-04-28 04:52:04'),
('xSolarSpecterx', 'xsolarspecterx309@gmail.com', '$2a$10$dummyhashGen1060xyz', 'USER', 'ACTIVE', '2024-05-01 04:34:47'),
('PhantomSpirit420', 'phantomspirit420792@gmail.com', '$2a$10$dummyhashGen1373xyz', 'USER', 'ACTIVE', '2024-05-03 23:16:39'),
('IronOutlaw2104', 'ironoutlaw2104676@gmail.com', '$2a$10$dummyhashGen1021xyz', 'USER', 'ACTIVE', '2024-05-04 02:09:49');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('GoldenRider70', 'goldenrider70250@gmail.com', '$2a$10$dummyhashGen1121xyz', 'USER', 'ACTIVE', '2024-05-06 08:39:06'),
('tiger15', 'tiger15998@gmail.com', '$2a$10$dummyhashGen1098xyz', 'USER', 'ACTIVE', '2024-05-09 14:43:03'),
('storm_tiger65', 'storm_tiger65460@gmail.com', '$2a$10$dummyhashGen1339xyz', 'USER', 'ACTIVE', '2024-05-11 18:12:22'),
('SilverTitan86', 'silvertitan86719@outlook.com', '$2a$10$dummyhashGen1091xyz', 'USER', 'INACTIVE', '2024-05-13 09:23:29'),
('xElectricRiderx', 'xelectricriderx992@gmail.com', '$2a$10$dummyhashGen1310xyz', 'USER', 'ACTIVE', '2024-05-15 17:09:22'),
('BlazeBeast420', 'blazebeast420236@gmail.com', '$2a$10$dummyhashGen1180xyz', 'USER', 'ACTIVE', '2024-05-17 22:43:27'),
('goblin2263', 'goblin2263532@yahoo.com', '$2a$10$dummyhashGen1267xyz', 'USER', 'ACTIVE', '2024-05-21 07:22:28'),
('SneakyViper27', 'sneakyviper27253@hotmail.com', '$2a$10$dummyhashGen1012xyz', 'USER', 'ACTIVE', '2024-05-22 01:19:15'),
('Dragon3049Live', 'dragon3049live531@gmail.com', '$2a$10$dummyhashGen1233xyz', 'USER', 'ACTIVE', '2024-05-22 12:40:35'),
('WickedTiger7', 'wickedtiger7601@gmail.com', '$2a$10$dummyhashGen1168xyz', 'USER', 'ACTIVE', '2024-05-22 13:04:27');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('SinisterDragon420', 'sinisterdragon420361@gmail.com', '$2a$10$dummyhashGen1441xyz', 'USER', 'ACTIVE', '2024-05-25 12:46:22'),
('panther6485', 'panther6485282@gmail.com', '$2a$10$dummyhashGen1139xyz', 'USER', 'ACTIVE', '2024-05-29 03:21:46'),
('VenomPanther80', 'venompanther80592@yahoo.com', '$2a$10$dummyhashGen1385xyz', 'USER', 'ACTIVE', '2024-05-29 11:18:27'),
('StormBandit6462', 'stormbandit646277@gmail.com', '$2a$10$dummyhashGen1421xyz', 'USER', 'ACTIVE', '2024-06-01 01:53:28'),
('LethalRider69', 'lethalrider69278@gmail.com', '$2a$10$dummyhashGen1413xyz', 'USER', 'ACTIVE', '2024-06-06 20:24:18'),
('BrutalRider59', 'brutalrider59671@gmail.com', '$2a$10$dummyhashGen1474xyz', 'USER', 'ACTIVE', '2024-06-07 14:34:19'),
('royal_outlaw', 'royal_outlaw959@gmail.com', '$2a$10$dummyhashGen1466xyz', 'USER', 'ACTIVE', '2024-06-08 16:20:10'),
('cobra4180', 'cobra4180792@gmail.com', '$2a$10$dummyhashGen1410xyz', 'USER', 'ACTIVE', '2024-06-10 13:00:05'),
('xRoyalTitanx', 'xroyaltitanx381@outlook.com', '$2a$10$dummyhashGen1499xyz', 'USER', 'ACTIVE', '2024-06-28 15:39:28'),
('ChaoticWizard8789', 'chaoticwizard8789335@gmail.com', '$2a$10$dummyhashGen1403xyz', 'USER', 'ACTIVE', '2024-06-29 23:57:43');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('MysticPirate7934', 'mysticpirate7934284@hotmail.com', '$2a$10$dummyhashGen1096xyz', 'USER', 'ACTIVE', '2024-07-04 21:23:34'),
('fierce_viper14', 'fierce_viper14130@gmail.com', '$2a$10$dummyhashGen1127xyz', 'USER', 'ACTIVE', '2024-07-05 19:31:16'),
('berserker69', 'berserker69447@hotmail.com', '$2a$10$dummyhashGen1088xyz', 'USER', 'ACTIVE', '2024-07-09 09:03:17'),
('IronFalcon6694', 'ironfalcon6694462@hotmail.com', '$2a$10$dummyhashGen1105xyz', 'USER', 'ACTIVE', '2024-07-11 10:53:09'),
('RoyalOutlaw5891', 'royaloutlaw5891719@gmail.com', '$2a$10$dummyhashGen1352xyz', 'USER', 'ACTIVE', '2024-07-11 11:12:43'),
('ToxicSlayer2719', 'toxicslayer2719812@outlook.com', '$2a$10$dummyhashGen1108xyz', 'USER', 'ACTIVE', '2024-07-13 08:50:58'),
('RoyalBerserker18', 'royalberserker18114@gmail.com', '$2a$10$dummyhashGen1214xyz', 'USER', 'ACTIVE', '2024-07-16 00:02:38'),
('rogue_hunter', 'rogue_hunter546@outlook.com', '$2a$10$dummyhashGen1378xyz', 'USER', 'ACTIVE', '2024-07-16 04:28:02'),
('SneakyReaper21', 'sneakyreaper21658@hotmail.com', '$2a$10$dummyhashGen1155xyz', 'USER', 'ACTIVE', '2024-07-16 15:12:53'),
('Bandit8848Live', 'bandit8848live449@gmail.com', '$2a$10$dummyhashGen1110xyz', 'USER', 'SUSPENDED', '2024-07-18 00:25:22');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('crusader15', 'crusader15226@gmail.com', '$2a$10$dummyhashGen1178xyz', 'USER', 'INACTIVE', '2024-07-20 00:27:14'),
('BrutalStriker7', 'brutalstriker7992@outlook.com', '$2a$10$dummyhashGen1169xyz', 'USER', 'ACTIVE', '2024-07-21 16:54:38'),
('specter82', 'specter8234@yahoo.com', '$2a$10$dummyhashGen1449xyz', 'USER', 'ACTIVE', '2024-07-24 18:40:38'),
('FrozenSniper6956', 'frozensniper695681@gmail.com', '$2a$10$dummyhashGen1225xyz', 'USER', 'ACTIVE', '2024-07-24 21:05:12'),
('ElectricBeast42', 'electricbeast42742@hotmail.com', '$2a$10$dummyhashGen1196xyz', 'USER', 'ACTIVE', '2024-07-25 06:18:53'),
('SavageHunter58', 'savagehunter58690@gmail.com', '$2a$10$dummyhashGen1312xyz', 'USER', 'INACTIVE', '2024-07-25 14:33:47'),
('xWildTigerx', 'xwildtigerx308@outlook.com', '$2a$10$dummyhashGen1346xyz', 'USER', 'ACTIVE', '2024-07-26 01:20:45'),
('FrostAssassin111', 'frostassassin111615@hotmail.com', '$2a$10$dummyhashGen1396xyz', 'USER', 'ACTIVE', '2024-08-01 20:42:45'),
('BlazeViper8692', 'blazeviper8692577@gmail.com', '$2a$10$dummyhashGen1393xyz', 'USER', 'ACTIVE', '2024-08-06 02:21:01'),
('FatalCrusader69', 'fatalcrusader69612@gmail.com', '$2a$10$dummyhashGen1364xyz', 'USER', 'ACTIVE', '2024-08-07 15:13:47');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('CrazyDragon88', 'crazydragon881@outlook.com', '$2a$10$dummyhashGen1443xyz', 'USER', 'ACTIVE', '2024-08-12 00:36:13'),
('ToxicRider11', 'toxicrider11854@gmail.com', '$2a$10$dummyhashGen1152xyz', 'USER', 'ACTIVE', '2024-08-14 09:10:41'),
('Specter4034YT', 'specter4034yt609@gmail.com', '$2a$10$dummyhashGen1037xyz', 'USER', 'ACTIVE', '2024-08-20 04:12:59'),
('cobra3831', 'cobra3831483@gmail.com', '$2a$10$dummyhashGen1148xyz', 'USER', 'ACTIVE', '2024-08-20 10:22:52'),
('OmegaHawk77', 'omegahawk77313@gmail.com', '$2a$10$dummyhashGen1103xyz', 'USER', 'ACTIVE', '2024-08-22 17:34:36'),
('legend7658', 'legend7658942@yahoo.com', '$2a$10$dummyhashGen1076xyz', 'USER', 'ACTIVE', '2024-08-24 15:25:15'),
('SilverBandit8318', 'silverbandit8318935@gmail.com', '$2a$10$dummyhashGen1017xyz', 'USER', 'ACTIVE', '2024-08-29 08:52:51'),
('NeonBlade88', 'neonblade88125@gmail.com', '$2a$10$dummyhashGen1118xyz', 'USER', 'ACTIVE', '2024-09-05 16:55:58'),
('assassin72', 'assassin72146@gmail.com', '$2a$10$dummyhashGen1381xyz', 'USER', 'ACTIVE', '2024-09-09 09:39:17'),
('warrior31', 'warrior3179@gmail.com', '$2a$10$dummyhashGen1185xyz', 'USER', 'ACTIVE', '2024-09-10 16:19:36');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('NeonSlayer96', 'neonslayer96512@yahoo.com', '$2a$10$dummyhashGen1350xyz', 'USER', 'ACTIVE', '2024-09-10 20:28:44'),
('WildWizard69', 'wildwizard69209@hotmail.com', '$2a$10$dummyhashGen1044xyz', 'USER', 'ACTIVE', '2024-09-12 06:06:17'),
('wild_goblin13', 'wild_goblin13212@yahoo.com', '$2a$10$dummyhashGen1461xyz', 'USER', 'ACTIVE', '2024-09-18 09:28:20'),
('Pirate5623TV', 'pirate5623tv703@gmail.com', '$2a$10$dummyhashGen1495xyz', 'USER', 'ACTIVE', '2024-09-18 14:03:19'),
('VenomSpecter83', 'venomspecter83415@hotmail.com', '$2a$10$dummyhashGen1182xyz', 'USER', 'ACTIVE', '2024-09-21 10:12:40'),
('RoyalSpecter2054', 'royalspecter2054996@outlook.com', '$2a$10$dummyhashGen1240xyz', 'USER', 'ACTIVE', '2024-09-24 20:07:06'),
('gladiator97', 'gladiator97947@gmail.com', '$2a$10$dummyhashGen1188xyz', 'USER', 'ACTIVE', '2024-09-25 20:28:22'),
('RoyalTitan111', 'royaltitan11154@hotmail.com', '$2a$10$dummyhashGen1195xyz', 'USER', 'ACTIVE', '2024-10-02 13:17:34'),
('SinisterPirate24', 'sinisterpirate24558@yahoo.com', '$2a$10$dummyhashGen1107xyz', 'USER', 'ACTIVE', '2024-10-03 01:34:21'),
('IronHawk1886', 'ironhawk188624@outlook.com', '$2a$10$dummyhashGen1359xyz', 'USER', 'ACTIVE', '2024-10-03 14:04:10');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('WickedRanger4375', 'wickedranger4375719@hotmail.com', '$2a$10$dummyhashGen1008xyz', 'USER', 'ACTIVE', '2024-10-03 16:30:37'),
('demonic_tiger', 'demonic_tiger408@outlook.com', '$2a$10$dummyhashGen1232xyz', 'USER', 'ACTIVE', '2024-10-06 01:22:46'),
('shadow_maverick', 'shadow_maverick162@gmail.com', '$2a$10$dummyhashGen1276xyz', 'USER', 'ACTIVE', '2024-10-11 05:36:27'),
('neon_striker', 'neon_striker749@gmail.com', '$2a$10$dummyhashGen1033xyz', 'USER', 'ACTIVE', '2024-10-25 04:21:03'),
('frozen_cobra', 'frozen_cobra383@hotmail.com', '$2a$10$dummyhashGen1445xyz', 'USER', 'ACTIVE', '2024-10-25 14:21:06'),
('FrozenWolf888', 'frozenwolf888568@outlook.com', '$2a$10$dummyhashGen1042xyz', 'USER', 'ACTIVE', '2024-10-27 12:55:26'),
('WickedNinja36', 'wickedninja36699@yahoo.com', '$2a$10$dummyhashGen1048xyz', 'USER', 'ACTIVE', '2024-11-02 01:04:47'),
('CrazySniper7', 'crazysniper7155@hotmail.com', '$2a$10$dummyhashGen1464xyz', 'USER', 'ACTIVE', '2024-11-02 21:01:40'),
('phoenix27', 'phoenix27821@gmail.com', '$2a$10$dummyhashGen1067xyz', 'USER', 'ACTIVE', '2024-11-03 01:06:06'),
('CrimsonTitan8424', 'crimsontitan8424244@outlook.com', '$2a$10$dummyhashGen1025xyz', 'USER', 'ACTIVE', '2024-11-05 05:17:57');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('BrutalDemon1454', 'brutaldemon1454842@hotmail.com', '$2a$10$dummyhashGen1451xyz', 'USER', 'ACTIVE', '2024-11-06 20:19:35'),
('NeonRaptor999', 'neonraptor999864@hotmail.com', '$2a$10$dummyhashGen1254xyz', 'USER', 'ACTIVE', '2024-11-10 17:23:07'),
('marauder13', 'marauder1394@yahoo.com', '$2a$10$dummyhashGen1111xyz', 'USER', 'ACTIVE', '2024-11-13 11:39:54'),
('LethalRanger726', 'lethalranger726577@hotmail.com', '$2a$10$dummyhashGen1353xyz', 'USER', 'ACTIVE', '2024-11-18 09:58:58'),
('ranger3116', 'ranger3116636@outlook.com', '$2a$10$dummyhashGen1141xyz', 'USER', 'ACTIVE', '2024-11-18 20:53:25'),
('NeonPanther23', 'neonpanther23976@gmail.com', '$2a$10$dummyhashGen1379xyz', 'USER', 'ACTIVE', '2024-11-21 06:06:50'),
('CrazyRanger77', 'crazyranger77443@yahoo.com', '$2a$10$dummyhashGen1336xyz', 'USER', 'ACTIVE', '2024-11-21 20:51:39'),
('RecklessOutlaw888', 'recklessoutlaw888224@yahoo.com', '$2a$10$dummyhashGen1290xyz', 'USER', 'ACTIVE', '2024-11-22 20:59:06'),
('RoguePirate700', 'roguepirate700434@gmail.com', '$2a$10$dummyhashGen1469xyz', 'USER', 'ACTIVE', '2024-11-27 04:45:48'),
('cosmic_sniper', 'cosmic_sniper879@hotmail.com', '$2a$10$dummyhashGen1477xyz', 'USER', 'ACTIVE', '2024-11-29 21:08:03');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('NeonPanther888', 'neonpanther888465@gmail.com', '$2a$10$dummyhashGen1106xyz', 'USER', 'ACTIVE', '2024-12-03 19:34:02'),
('WildStriker8836', 'wildstriker8836774@hotmail.com', '$2a$10$dummyhashGen1022xyz', 'USER', 'ACTIVE', '2024-12-07 16:07:46'),
('OmegaRanger23', 'omegaranger23655@gmail.com', '$2a$10$dummyhashGen1137xyz', 'USER', 'ACTIVE', '2024-12-08 08:45:11'),
('beast35', 'beast3578@gmail.com', '$2a$10$dummyhashGen1084xyz', 'USER', 'ACTIVE', '2024-12-08 19:58:17'),
('striker7974', 'striker7974651@gmail.com', '$2a$10$dummyhashGen1368xyz', 'USER', 'ACTIVE', '2024-12-13 05:03:11'),
('VenomSamurai50', 'venomsamurai50299@hotmail.com', '$2a$10$dummyhashGen1347xyz', 'USER', 'ACTIVE', '2024-12-15 13:54:12'),
('SavagePhoenix777', 'savagephoenix777491@yahoo.com', '$2a$10$dummyhashGen1314xyz', 'USER', 'ACTIVE', '2024-12-16 14:49:39'),
('ToxicTiger4701', 'toxictiger4701940@gmail.com', '$2a$10$dummyhashGen1211xyz', 'USER', 'ACTIVE', '2024-12-17 07:26:40'),
('FierceSpirit95', 'fiercespirit95973@hotmail.com', '$2a$10$dummyhashGen1151xyz', 'USER', 'ACTIVE', '2024-12-17 22:48:18'),
('SinisterViper49', 'sinisterviper49991@hotmail.com', '$2a$10$dummyhashGen1197xyz', 'USER', 'ACTIVE', '2024-12-21 01:13:13');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('hunter90', 'hunter90313@hotmail.com', '$2a$10$dummyhashGen1389xyz', 'USER', 'ACTIVE', '2024-12-22 13:03:51'),
('beast3969', 'beast396933@gmail.com', '$2a$10$dummyhashGen1265xyz', 'USER', 'ACTIVE', '2024-12-24 05:18:45'),
('berserker1036', 'berserker1036651@gmail.com', '$2a$10$dummyhashGen1149xyz', 'USER', 'ACTIVE', '2024-12-25 02:03:04'),
('WildDragon21', 'wilddragon21734@hotmail.com', '$2a$10$dummyhashGen1002xyz', 'USER', 'ACTIVE', '2024-12-25 11:17:24'),
('samurai208', 'samurai208725@yahoo.com', '$2a$10$dummyhashGen1406xyz', 'USER', 'SUSPENDED', '2024-12-25 17:48:04'),
('xFrostCrusaderx', 'xfrostcrusaderx458@gmail.com', '$2a$10$dummyhashGen1291xyz', 'USER', 'ACTIVE', '2024-12-29 06:18:10'),
('FrostTitan111', 'frosttitan111915@gmail.com', '$2a$10$dummyhashGen1457xyz', 'USER', 'INACTIVE', '2024-12-30 09:50:13'),
('MysticDemon360', 'mysticdemon360152@gmail.com', '$2a$10$dummyhashGen1444xyz', 'USER', 'ACTIVE', '2024-12-30 16:59:01'),
('BrutalSpirit13', 'brutalspirit13834@hotmail.com', '$2a$10$dummyhashGen1365xyz', 'USER', 'ACTIVE', '2025-01-01 17:09:13'),
('royal_tiger', 'royal_tiger237@gmail.com', '$2a$10$dummyhashGen1322xyz', 'USER', 'ACTIVE', '2025-01-03 13:11:32');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('ElectricWarrior21', 'electricwarrior218@gmail.com', '$2a$10$dummyhashGen1024xyz', 'USER', 'ACTIVE', '2025-01-04 14:13:23'),
('LethalRider17', 'lethalrider17996@yahoo.com', '$2a$10$dummyhashGen1419xyz', 'USER', 'ACTIVE', '2025-01-10 12:19:38'),
('slayer48', 'slayer48872@yahoo.com', '$2a$10$dummyhashGen1236xyz', 'USER', 'ACTIVE', '2025-01-10 18:10:00'),
('specter43', 'specter43210@hotmail.com', '$2a$10$dummyhashGen1038xyz', 'USER', 'ACTIVE', '2025-01-17 13:33:56'),
('berserker1078', 'berserker1078317@gmail.com', '$2a$10$dummyhashGen1239xyz', 'USER', 'ACTIVE', '2025-01-18 17:13:18'),
('CrazyWolf4889', 'crazywolf4889475@hotmail.com', '$2a$10$dummyhashGen1300xyz', 'USER', 'ACTIVE', '2025-01-22 01:45:59'),
('fatal_spirit55', 'fatal_spirit55174@yahoo.com', '$2a$10$dummyhashGen1320xyz', 'USER', 'ACTIVE', '2025-01-23 23:14:05'),
('wild_legend', 'wild_legend698@yahoo.com', '$2a$10$dummyhashGen1493xyz', 'USER', 'SUSPENDED', '2025-01-25 11:23:12'),
('OmegaKnight999', 'omegaknight999468@gmail.com', '$2a$10$dummyhashGen1128xyz', 'USER', 'ACTIVE', '2025-01-27 06:39:29'),
('burning_titan27', 'burning_titan27810@hotmail.com', '$2a$10$dummyhashGen1333xyz', 'USER', 'ACTIVE', '2025-01-29 22:46:29');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('shadow_titan94', 'shadow_titan94386@hotmail.com', '$2a$10$dummyhashGen1418xyz', 'USER', 'ACTIVE', '2025-02-03 16:32:30'),
('Ninja1777YT', 'ninja1777yt445@outlook.com', '$2a$10$dummyhashGen1055xyz', 'USER', 'ACTIVE', '2025-02-05 18:07:42'),
('WickedSpirit13', 'wickedspirit13446@yahoo.com', '$2a$10$dummyhashGen1087xyz', 'USER', 'ACTIVE', '2025-02-13 21:52:18'),
('Hawk6390Live', 'hawk6390live552@hotmail.com', '$2a$10$dummyhashGen1074xyz', 'USER', 'ACTIVE', '2025-02-15 05:08:34'),
('dragon41', 'dragon41229@yahoo.com', '$2a$10$dummyhashGen1000xyz', 'USER', 'ACTIVE', '2025-02-18 01:38:13'),
('LuckySamurai7081', 'luckysamurai7081406@gmail.com', '$2a$10$dummyhashGen1361xyz', 'USER', 'ACTIVE', '2025-02-19 11:49:51'),
('xMysticNinjax', 'xmysticninjax567@hotmail.com', '$2a$10$dummyhashGen1412xyz', 'USER', 'ACTIVE', '2025-02-24 14:01:24'),
('xSilverPhoenixx', 'xsilverphoenixx912@gmail.com', '$2a$10$dummyhashGen1043xyz', 'USER', 'ACTIVE', '2025-02-27 07:18:00'),
('SilverOutlaw7452', 'silveroutlaw7452378@hotmail.com', '$2a$10$dummyhashGen1147xyz', 'USER', 'ACTIVE', '2025-03-09 13:10:35'),
('Warrior4915Gaming', 'warrior4915gaming670@hotmail.com', '$2a$10$dummyhashGen1327xyz', 'USER', 'SUSPENDED', '2025-03-25 23:24:47');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('sniper79', 'sniper79843@gmail.com', '$2a$10$dummyhashGen1374xyz', 'USER', 'ACTIVE', '2025-03-26 15:00:27'),
('panther1481', 'panther1481445@gmail.com', '$2a$10$dummyhashGen1132xyz', 'USER', 'ACTIVE', '2025-03-27 04:38:12'),
('StormStriker4334', 'stormstriker4334745@outlook.com', '$2a$10$dummyhashGen1255xyz', 'USER', 'ACTIVE', '2025-04-01 14:38:39'),
('GoldenSpecter7031', 'goldenspecter7031866@gmail.com', '$2a$10$dummyhashGen1171xyz', 'USER', 'ACTIVE', '2025-04-07 03:57:30'),
('reckless_pirate83', 'reckless_pirate83452@gmail.com', '$2a$10$dummyhashGen1205xyz', 'USER', 'ACTIVE', '2025-04-10 06:44:54'),
('xDemonicDemonx', 'xdemonicdemonx592@gmail.com', '$2a$10$dummyhashGen1305xyz', 'USER', 'ACTIVE', '2025-04-15 02:18:43'),
('DarkPirate52', 'darkpirate52286@gmail.com', '$2a$10$dummyhashGen1053xyz', 'USER', 'ACTIVE', '2025-04-16 07:42:24'),
('WickedSpirit51', 'wickedspirit51596@gmail.com', '$2a$10$dummyhashGen1383xyz', 'USER', 'ACTIVE', '2025-04-17 13:51:19'),
('SilverRanger7194', 'silverranger7194887@gmail.com', '$2a$10$dummyhashGen1376xyz', 'USER', 'ACTIVE', '2025-04-19 21:38:37'),
('silent_marauder', 'silent_marauder853@outlook.com', '$2a$10$dummyhashGen1140xyz', 'USER', 'ACTIVE', '2025-04-20 01:43:11');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('RoyalCrusader1042', 'royalcrusader1042488@gmail.com', '$2a$10$dummyhashGen1160xyz', 'USER', 'ACTIVE', '2025-04-23 14:34:39'),
('WildBlade2069', 'wildblade206969@yahoo.com', '$2a$10$dummyhashGen1230xyz', 'USER', 'ACTIVE', '2025-04-24 09:09:24'),
('dragon43', 'dragon43991@hotmail.com', '$2a$10$dummyhashGen1263xyz', 'USER', 'ACTIVE', '2025-05-01 04:46:34'),
('FrostRanger11', 'frostranger11612@gmail.com', '$2a$10$dummyhashGen1340xyz', 'USER', 'ACTIVE', '2025-05-03 13:59:43'),
('knight9220', 'knight9220799@gmail.com', '$2a$10$dummyhashGen1473xyz', 'USER', 'ACTIVE', '2025-05-05 14:43:13'),
('VenomSamurai99', 'venomsamurai99711@gmail.com', '$2a$10$dummyhashGen1447xyz', 'USER', 'ACTIVE', '2025-05-07 13:10:50'),
('xSolarStrikerx', 'xsolarstrikerx282@hotmail.com', '$2a$10$dummyhashGen1228xyz', 'USER', 'ACTIVE', '2025-05-14 12:25:55'),
('CosmicDemon2581', 'cosmicdemon2581750@gmail.com', '$2a$10$dummyhashGen1446xyz', 'USER', 'ACTIVE', '2025-05-15 02:01:44'),
('xSilentTitanx', 'xsilenttitanx280@gmail.com', '$2a$10$dummyhashGen1223xyz', 'USER', 'ACTIVE', '2025-05-26 17:38:42'),
('Knight994Live', 'knight994live746@outlook.com', '$2a$10$dummyhashGen1028xyz', 'USER', 'ACTIVE', '2025-05-28 16:15:07');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('tiger4779', 'tiger4779268@outlook.com', '$2a$10$dummyhashGen1422xyz', 'USER', 'ACTIVE', '2025-05-29 00:36:54'),
('royal_dragon52', 'royal_dragon52802@gmail.com', '$2a$10$dummyhashGen1050xyz', 'USER', 'ACTIVE', '2025-05-31 05:29:37'),
('xRecklessPantherx', 'xrecklesspantherx765@outlook.com', '$2a$10$dummyhashGen1145xyz', 'USER', 'ACTIVE', '2025-06-03 07:57:44'),
('BurningPanther23', 'burningpanther23495@yahoo.com', '$2a$10$dummyhashGen1247xyz', 'USER', 'ACTIVE', '2025-06-04 00:56:55'),
('Samurai2886TV', 'samurai2886tv607@outlook.com', '$2a$10$dummyhashGen1440xyz', 'USER', 'ACTIVE', '2025-06-06 09:41:44'),
('Viper9750PH', 'viper9750ph328@hotmail.com', '$2a$10$dummyhashGen1470xyz', 'USER', 'ACTIVE', '2025-06-08 03:57:13'),
('DemonicSpecter41', 'demonicspecter41804@gmail.com', '$2a$10$dummyhashGen1026xyz', 'USER', 'ACTIVE', '2025-06-08 09:40:12'),
('FrozenSniper23', 'frozensniper2318@gmail.com', '$2a$10$dummyhashGen1324xyz', 'USER', 'ACTIVE', '2025-06-17 04:41:54'),
('FrostHawk77', 'frosthawk77659@outlook.com', '$2a$10$dummyhashGen1198xyz', 'USER', 'ACTIVE', '2025-06-17 05:43:34'),
('SneakyHawk7', 'sneakyhawk7406@outlook.com', '$2a$10$dummyhashGen1295xyz', 'USER', 'INACTIVE', '2025-06-22 07:34:57');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('BurningHunter7', 'burninghunter7860@gmail.com', '$2a$10$dummyhashGen1321xyz', 'USER', 'ACTIVE', '2025-06-24 17:05:52'),
('RecklessWarrior7542', 'recklesswarrior7542359@outlook.com', '$2a$10$dummyhashGen1052xyz', 'USER', 'ACTIVE', '2025-06-28 15:48:48'),
('slayer11', 'slayer11870@gmail.com', '$2a$10$dummyhashGen1086xyz', 'USER', 'ACTIVE', '2025-07-01 10:43:07'),
('blaze_phoenix38', 'blaze_phoenix38134@yahoo.com', '$2a$10$dummyhashGen1429xyz', 'USER', 'ACTIVE', '2025-07-03 12:46:14'),
('maverick9978', 'maverick9978952@hotmail.com', '$2a$10$dummyhashGen1172xyz', 'USER', 'ACTIVE', '2025-07-12 12:32:22'),
('GhostAssassin9251', 'ghostassassin9251211@gmail.com', '$2a$10$dummyhashGen1156xyz', 'USER', 'ACTIVE', '2025-07-13 01:51:04'),
('BurningCobra99', 'burningcobra99936@outlook.com', '$2a$10$dummyhashGen1144xyz', 'USER', 'ACTIVE', '2025-07-14 02:15:48'),
('cobra7771', 'cobra777169@gmail.com', '$2a$10$dummyhashGen1167xyz', 'USER', 'ACTIVE', '2025-07-16 02:42:13'),
('BlazeCrusader7', 'blazecrusader7178@yahoo.com', '$2a$10$dummyhashGen1481xyz', 'USER', 'ACTIVE', '2025-07-17 21:52:43'),
('IronAssassin46', 'ironassassin46162@gmail.com', '$2a$10$dummyhashGen1041xyz', 'USER', 'ACTIVE', '2025-07-19 04:15:53');

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('RecklessGladiator69', 'recklessgladiator69353@yahoo.com', '$2a$10$dummyhashGen1484xyz', 'USER', 'ACTIVE', '2025-07-25 05:59:45'),
('ranger1601', 'ranger1601448@yahoo.com', '$2a$10$dummyhashGen1334xyz', 'USER', 'ACTIVE', '2025-07-26 20:03:27'),
('FrostCobra462', 'frostcobra462327@gmail.com', '$2a$10$dummyhashGen1210xyz', 'USER', 'ACTIVE', '2025-07-27 14:45:34'),
('xBrutalBanditx', 'xbrutalbanditx308@yahoo.com', '$2a$10$dummyhashGen1496xyz', 'USER', 'ACTIVE', '2025-07-29 21:16:55'),
('IronBlade7293', 'ironblade729390@hotmail.com', '$2a$10$dummyhashGen1235xyz', 'USER', 'ACTIVE', '2025-08-06 11:18:56'),
('RecklessCobra999', 'recklesscobra999106@hotmail.com', '$2a$10$dummyhashGen1207xyz', 'USER', 'ACTIVE', '2025-08-07 01:08:59'),
('Warrior5670YT', 'warrior5670yt917@outlook.com', '$2a$10$dummyhashGen1243xyz', 'USER', 'ACTIVE', '2025-08-07 02:41:40'),
('SilverWizard92', 'silverwizard9281@gmail.com', '$2a$10$dummyhashGen1311xyz', 'USER', 'ACTIVE', '2025-08-08 23:25:18'),
('GhostKnight6225', 'ghostknight6225100@outlook.com', '$2a$10$dummyhashGen1004xyz', 'USER', 'ACTIVE', '2025-08-09 12:52:48'),
('FrostSpecter8768', 'frostspecter8768757@hotmail.com', '$2a$10$dummyhashGen1278xyz', 'USER', 'ACTIVE', '2025-08-13 22:42:56');
