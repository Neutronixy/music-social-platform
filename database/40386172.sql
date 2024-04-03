-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2023 at 06:51 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stacksofwax`
--

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE `album` (
  `album_id` int(11) NOT NULL,
  `album_name` varchar(255) NOT NULL,
  `album_description` text DEFAULT NULL,
  `album_release_date` date DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`album_id`, `album_name`, `album_description`, `album_release_date`, `image_id`) VALUES
(65, 'Dark Side of the Moon', 'A classic album by Pink Floyd', '1973-03-01', 1),
(66, 'Rumours', 'An iconic album by Fleetwood Mac', '1977-02-04', 2),
(70, 'Moonkid Mondays', 'An album by Deko', '2020-03-02', 6),
(71, 'Oracular Spectacular', 'debut studio album by American rock band MGMT, released in 2007. The album features a mix of psychedelic, indie, and pop-rock sounds, and includes hit singles such as \"Electric Feel\" and \"Kids\". The album received critical acclaim for its catchy hooks, clever lyrics, and innovative production, and helped establish MGMT as one of the leading indie bands of the late 2000s. Oracular Spectacular has since become a cult classic and is considered a landmark album of the indie rock genre.', '2008-01-22', 7),
(72, '21', 'The album features a mix of soul, pop, and R&B sounds, and is characterized by Adele\'s powerful vocals and confessional songwriting. The album includes hit singles such as \"Rolling in the Deep\", \"Someone Like You\", and \"Set Fire to the Rain\", and has received critical acclaim for its emotional depth, musical craftsmanship, and universal appeal. 21 has become one of the best-selling albums of all time, and helped establish Adele as one of the most successful and beloved artists of the 2010s.', '2011-01-24', 13);

--
-- Triggers `album`
--
DELIMITER $$
CREATE TRIGGER `trg_album_delete` AFTER DELETE ON `album` FOR EACH ROW BEGIN 
    -- Delete the associated image row 
    DELETE FROM image WHERE image_id = OLD.image_id; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_album_update` AFTER UPDATE ON `album` FOR EACH ROW BEGIN  
    -- Delete the associated image row  
    DELETE FROM image WHERE image_id = OLD.image_id;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `artist`
--

CREATE TABLE `artist` (
  `artist_id` int(11) NOT NULL,
  `artist_name` varchar(255) NOT NULL,
  `artist_description` text DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artist`
--

INSERT INTO `artist` (`artist_id`, `artist_name`, `artist_description`, `image_id`) VALUES
(1, 'Skrillex', 'Skrillex is an American DJ, record producer, musician, and singer-songwriter. He is known for his production of dubstep music, and has won multiple Grammy Awards for his work.', 14),
(2, 'Freestylers', 'Freestylers are a British electronic music group, consisting of producers Matt Cantor and Aston Harvey. They are known for their use of breakbeat and other genres in their music.', 15),
(3, 'Flux Pavilion', 'Flux Pavilion is an English dubstep producer and DJ. He is known for his unique blend of heavy, melodic dubstep and has worked with numerous other artists in the genre.', 16),
(4, 'Doctor P', 'Doctor P is the stage name of English dubstep producer and DJ Shaun Brockhurst. He is known for his energetic, bass-heavy tracks and has been active in the genre since the late 2000s.', 17),
(5, 'Flume', 'Flume is the stage name of Australian electronic music producer Harley Edward Streten. He is known for his unique blend of downtempo, future garage, and other genres in his music.', 18),
(6, 'Pink Floyd', 'Pink Floyd were an English rock band formed in London in 1965. They are considered one of the most influential and successful bands in the history of music, known for their innovative approach to songwriting and live performances.', 19),
(7, 'Fleetwood Mac', 'Fleetwood Mac are a British-American rock band, formed in London in 1967. They are known for their unique blend of blues, rock, and pop music, and are one of the best-selling bands of all time.', 20),
(8, 'MGMT', 'MGMT is an American rock band formed in 2002. They are known for their eclectic mix of psychedelic, indie, and pop music, and have released several critically acclaimed albums.', 21),
(9, 'Adele', 'Adele is an English singer-songwriter known for her powerful vocals and emotional songwriting. She has won multiple Grammy Awards and is one of the best-selling music artists of all time.', 22),
(10, 'Deko', 'Grant Andrew Decouto (b. March 24, 1995), better known by his stage name Deko, is a Grammy nominated record producer and rapper. He has established himself as a force in Atlanta and around the south while working with acts such as Migos, Drake, Gucci Mane, and others. Having one of the most unique sounds you will find in music today, Deko is always testing limits by constantly fusing elements from all genres of music in his production. With his career just now beginning, Deko is on a mission to become one of the most versatile producers in the industry and a household name. Outside of producing, Deko makes his own music. He has released multiple albums, the most notable being Iridescent, and has seen success with songs like \"Phantasy Star Online,\" featuring his very own vocaloid creation, Yameii Online.', 23);

--
-- Triggers `artist`
--
DELIMITER $$
CREATE TRIGGER `trg_artist_delete` AFTER DELETE ON `artist` FOR EACH ROW BEGIN 
    -- Delete the associated image row 
    DELETE FROM image WHERE image_id = OLD.image_id; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_artist_update` AFTER UPDATE ON `artist` FOR EACH ROW BEGIN  
    -- Delete the associated image row  
    DELETE FROM image WHERE image_id = OLD.image_id;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL,
  `comment_content` text NOT NULL,
  `comment_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `comment_reply_id` int(11) DEFAULT NULL,
  `reaction_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `comment`
--
DELIMITER $$
CREATE TRIGGER `CK_comment_id_comment_reply_id_different_insert` BEFORE INSERT ON `comment` FOR EACH ROW BEGIN
  IF NEW.comment_id = NEW.comment_reply_id THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'comment_id and comment_reply_id cannot be the same';
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `CK_comment_id_comment_reply_id_different_update` BEFORE UPDATE ON `comment` FOR EACH ROW BEGIN
  IF NEW.comment_id = NEW.comment_reply_id THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'comment_id and comment_reply_id cannot be the same';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `favourite_id` int(11) NOT NULL,
  `favourite_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reaction_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genre_subgenre`
--

CREATE TABLE `genre_subgenre` (
  `genre_subgenre_id` int(11) NOT NULL,
  `genre_subgenre_name` varchar(255) NOT NULL,
  `genre_subgenre_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `genre_subgenre`
--

INSERT INTO `genre_subgenre` (`genre_subgenre_id`, `genre_subgenre_name`, `genre_subgenre_description`) VALUES
(2, 'Progressive Rock', 'A subgenre of rock music that originated in the late 1960s and early 1970s, characterized by complex and elaborate arrangements, unconventional song structures, and the use of experimental sounds and textures.'),
(3, 'Psychedelic Rock', 'A subgenre of rock music that emerged in the mid-1960s, characterized by the use of psychedelic drugs, surreal lyrics, and an emphasis on extended instrumental solos and improvisation.'),
(4, 'Pop Rock', 'A subgenre of rock music that combines catchy pop melodies with rock instrumentation.'),
(5, 'Soft Rock', 'A subgenre of rock music that emphasizes acoustic instruments, mellow vocals, and sentimental lyrics.'),
(6, 'Pop', 'A genre of popular music that originated in the 1950s, characterized by catchy melodies, upbeat rhythms, and a focus on vocals and songwriting.'),
(7, 'Rock', 'A genre of popular music that originated in the 1950s, characterized by a strong backbeat, electric guitars, and often, rebellious lyrics.'),
(8, 'Psychedelic Pop', 'A subgenre of pop music that emerged in the 1960s, characterized by the use of psychedelic drugs, surreal lyrics, and an emphasis on melody and harmony.'),
(9, 'Soul', 'A genre of African American music that originated in the 1950s and 1960s, characterized by its gospel-influenced vocals, rhythmic instrumentation, and emotional intensity.'),
(10, 'Soft piano', 'A subgenre of piano music that is often characterized by gentle, soothing melodies and a relaxed, contemplative mood.'),
(11, 'Dubstep', 'A genre of electronic dance music characterized by heavy bass, syncopated rhythms, and sparse, wobbly production'),
(12, 'Brostep', 'A subgenre of dubstep characterized by aggressive and intense sounds, typically using distorted and heavy bass'),
(13, 'Riddim', 'A subgenre of dubstep that is focused on rhythm and percussion, with repetitive and syncopated drum patterns'),
(14, 'Future Garage', 'A genre of electronic dance music that blends elements of garage, dubstep, and ambient music, characterized by atmospheric and melancholic soundscapes'),
(15, 'Hyperpop', 'Hyperpop is a genre of music characterized by high-pitched vocals, sugary melodies, and playful electronic beats.');

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image_id` int(11) NOT NULL,
  `image_alt` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`image_id`, `image_alt`) VALUES
(1, 'Pink Floyd - Dark Side of the Moon - album cover'),
(2, 'Fleetwood Mac - Rumours - album cover'),
(6, 'deko - Moonkid Mondays - album cover'),
(7, ' MGMT - Oracular Spectacular - album cover'),
(8, 'Cover art for \"Scary Monsters and Nice Sprites\" song by Skrillex'),
(9, 'Cover art for \"Cracks (Flux Pavilion Remix)\" song by Freestylers (remixed by Flux Pavilion)'),
(10, 'Cover art for \"Tetris\" song by Doctor P'),
(11, 'Cover art for \"Bass Cannon\" song by Flux Pavilion'),
(12, 'Cover art for \"Holdin On\" song by Flume'),
(13, ' Adele - 21 - album cover'),
(14, 'Skrillex image'),
(15, 'Freestylers image'),
(16, 'Doctor P image'),
(17, 'Flux Pavilion image'),
(18, 'Flume image'),
(19, 'Pink Floyd image'),
(20, 'Fleetwood Mac image'),
(21, 'MGMT image'),
(22, 'Adele image'),
(23, 'Deko artist'),
(24, 'Harvest'),
(25, 'Capitol'),
(26, 'Warner Bros.'),
(27, 'Columbia'),
(28, 'XL'),
(29, 'user neutronix image');

-- --------------------------------------------------------

--
-- Table structure for table `licensing`
--

CREATE TABLE `licensing` (
  `licensing_id` int(11) NOT NULL,
  `licensing_name` varchar(255) NOT NULL,
  `licensing_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `licensing`
--

INSERT INTO `licensing` (`licensing_id`, `licensing_name`, `licensing_description`) VALUES
(1, 'Standard License', 'Allows non-commercial use of the song in personal projects'),
(2, 'Commercial License', 'Allows commercial use of the song in projects for profit'),
(3, 'Exclusive License', 'Grants exclusive rights to the licensee to use the song in their projects'),
(4, 'Limited Use License', 'Restricts the use of the song to a specific project or type of project'),
(5, 'Creative Commons License', 'Allows for free distribution, remixing, and use of the song as long as proper attribution is given');

-- --------------------------------------------------------

--
-- Table structure for table `playlist`
--

CREATE TABLE `playlist` (
  `playlist_id` int(11) NOT NULL,
  `playlist_name` varchar(255) NOT NULL,
  `playlist_description` text DEFAULT NULL,
  `playlist_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(11) NOT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `playlist`
--
DELIMITER $$
CREATE TRIGGER `trg_playlist_delete` AFTER DELETE ON `playlist` FOR EACH ROW BEGIN  
    -- Delete the associated image row  
    DELETE FROM image WHERE image_id = OLD.image_id;  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_playlist_update` AFTER UPDATE ON `playlist` FOR EACH ROW BEGIN  
    -- Delete the associated image row  
    DELETE FROM image WHERE image_id = OLD.image_id;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL,
  `rating_level` enum('1','2','3','4','5') NOT NULL,
  `rating_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reaction_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`rating_id`, `rating_level`, `rating_created`, `reaction_id`) VALUES
(3, '5', '2023-05-03 16:21:44', 6),
(4, '3', '2023-05-03 16:21:44', 7);

-- --------------------------------------------------------

--
-- Table structure for table `reaction`
--

CREATE TABLE `reaction` (
  `reaction_id` int(11) NOT NULL,
  `artist_id` int(11) DEFAULT NULL,
  `track_id` int(11) DEFAULT NULL,
  `album_id` int(11) DEFAULT NULL,
  `playlist_id` int(11) DEFAULT NULL,
  `user_receiver_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ;

--
-- Dumping data for table `reaction`
--

INSERT INTO `reaction` (`reaction_id`, `artist_id`, `track_id`, `album_id`, `playlist_id`, `user_receiver_id`, `user_id`) VALUES
(7, NULL, 139, NULL, NULL, NULL, 64),
(6, NULL, 139, NULL, NULL, NULL, 65);

-- --------------------------------------------------------

--
-- Table structure for table `record_company`
--

CREATE TABLE `record_company` (
  `record_company_id` int(11) NOT NULL,
  `record_company_name` varchar(255) NOT NULL,
  `record_company_description` text DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `record_company`
--

INSERT INTO `record_company` (`record_company_id`, `record_company_name`, `record_company_description`, `image_id`) VALUES
(1, 'Harvest', 'British record label, distributed by Capitol Records in the US', 24),
(2, 'Capitol', 'American record label, owned by Universal Music Group', 25),
(3, 'Warner Bros', 'American record label, owned by Warner Music Group', 26),
(4, 'Columbia', 'American record label, owned by Sony Music', 27),
(5, 'XL', 'British independent record label', 28);

--
-- Triggers `record_company`
--
DELIMITER $$
CREATE TRIGGER `trg_record_company_delete` AFTER DELETE ON `record_company` FOR EACH ROW BEGIN 
    -- Delete the associated image row 
    DELETE FROM image WHERE image_id = OLD.image_id; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_record_company_update` AFTER UPDATE ON `record_company` FOR EACH ROW BEGIN  
    -- Delete the associated image row  
    DELETE FROM image WHERE image_id = OLD.image_id;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `report_track`
--

CREATE TABLE `report_track` (
  `report_track_id` int(11) NOT NULL,
  `report_track_content` text NOT NULL,
  `report_track_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `track_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_user`
--

CREATE TABLE `report_user` (
  `report_user_id` int(11) NOT NULL,
  `report_user_content` text DEFAULT NULL,
  `report_user_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(11) NOT NULL,
  `user_reported_id` int(11) NOT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `report_user_reason_id` int(11) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `report_user_reason`
--

CREATE TABLE `report_user_reason` (
  `report_reason_id` int(11) NOT NULL,
  `report_user_reason_title` varchar(255) NOT NULL,
  `report_user_reason_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `terms_of_service`
--

CREATE TABLE `terms_of_service` (
  `terms_of_service_id` int(11) NOT NULL,
  `terms_of_service_content` text NOT NULL,
  `terms_of_service_version` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `terms_of_service`
--

INSERT INTO `terms_of_service` (`terms_of_service_id`, `terms_of_service_content`, `terms_of_service_version`) VALUES
(2, 'Welcome to our website. By using our site, you agree to the following terms of service:\n\n1. Account Registration\nYou may be required to register for an account in order to use certain features of the site. When you register for an account, you agree to provide accurate and complete information about yourself.\n\n2. User Content\nYou are solely responsible for any content you post or upload to the site. You agree not to post or upload any content that is unlawful, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, libelous, invasive of another’s privacy, or otherwise objectionable.\n\n3. Intellectual Property\nAll content and materials on the site, including but not limited to music, images, videos, and software, are the property of the site or its licensors and are protected by copyright, trademark, and other intellectual property laws. You may not use any content or materials on the site for commercial purposes without the site’s prior written consent.\n\n4. Termination\nThe site reserves the right to terminate your account or restrict your access to the site at any time, with or without notice, for any reason or no reason.\n\n5. Changes to the Terms of Service\nThe site reserves the right to change these terms of service at any time, with or without notice. By continuing to use the site after the changes have been made, you agree to be bound by the revised terms of service.\n\nIf you have any questions or concerns about these terms of service, please contact us at rloduca01@qub.ac.uk', '2023-04-28 23:19:54');

-- --------------------------------------------------------

--
-- Table structure for table `track`
--

CREATE TABLE `track` (
  `track_id` int(11) NOT NULL,
  `track_name` varchar(255) NOT NULL,
  `track_description` text DEFAULT NULL,
  `track_length` time DEFAULT NULL,
  `track_release_date` date DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `track`
--

INSERT INTO `track` (`track_id`, `track_name`, `track_description`, `track_length`, `track_release_date`, `image_id`) VALUES
(104, 'Speak to Me', 'Intro track for the album', '00:01:13', NULL, 1),
(105, 'Breathe', 'Opening track for the album', '00:02:43', NULL, 1),
(106, 'On the Run', 'Electronic instrumental track', '00:03:31', NULL, 1),
(107, 'Time', 'Song about the passage of time', '00:07:05', NULL, 1),
(108, 'The Great Gig in the Sky', 'Song featuring vocals by Clare Torry', '00:04:47', NULL, 1),
(109, 'Money', 'Song about greed and consumerism', '00:06:22', NULL, 1),
(110, 'Us and Them', 'Song about conflict and division', '00:07:49', NULL, 1),
(111, 'Any Colour You Like', 'Instrumental track with a psychedelic sound', '00:03:25', NULL, 1),
(112, 'Brain Damage', 'Song about insanity and the dark side of human nature', '00:03:50', NULL, 1),
(113, 'Eclipse', 'Closing track for the album', '00:02:03', NULL, 1),
(114, 'Second Hand News', 'Opening track on Rumours album', '00:02:43', NULL, 2),
(115, 'Dreams', 'Written by Stevie Nicks, became Fleetwood Mac\'s only No. 1 hit single', '00:04:18', NULL, 2),
(116, 'Never Going Back Again', 'Fingerpicking guitar style by Lindsey Buckingham', '00:02:02', NULL, 2),
(117, 'Don\'t Stop', 'Written by Christine McVie, became the band\'s first top 10 hit', '00:03:11', NULL, 2),
(118, 'Go Your Own Way', 'Written by Lindsey Buckingham, one of the band\'s most famous songs', '00:03:38', NULL, 2),
(119, 'Songbird', 'Only Christine McVie song on the album', '00:03:20', NULL, 2),
(120, 'The Chain', 'Made up of various sections of different songs', '00:04:30', NULL, 2),
(121, 'You Make Loving Fun', 'Written by Christine McVie about her affair with the band\'s lighting director', '00:03:33', NULL, 2),
(122, 'I Don\'t Want to Know', 'Written by Stevie Nicks and inspired by her breakup with Lindsey Buckingham', '00:03:11', NULL, 2),
(123, 'Oh Daddy', 'Written by Christine McVie about her and John McVie\'s divorce', '00:03:56', NULL, 2),
(124, 'Gold Dust Woman', 'Written by Stevie Nicks and is one of the album\'s darker songs', '00:05:02', NULL, 2),
(125, 'Valentine Nebula 777 (featuring Yameii Online)', NULL, '00:02:04', '2020-03-02', 6),
(126, 'Sabertooth (featuring Cone)', NULL, '00:02:33', '2020-03-02', 6),
(127, 'Aurora Beam Palace', NULL, '00:02:41', NULL, 6),
(128, 'Where\'s My Mind', NULL, '00:01:38', NULL, 6),
(129, 'I\'ve Played Too Much Mario Kart', NULL, '00:04:43', NULL, 6),
(130, 'Fuck Your Feelings', NULL, '00:04:37', NULL, 6),
(131, 'Illusion Spell', NULL, '00:01:52', NULL, 6),
(132, 'Time to Pretend', 'Debut single from MGMT\'s Oracular Spectacular album. A nostalgic and dreamy track about the band\'s aspirations and struggles with fame.', '00:04:21', '2008-03-03', 7),
(133, 'Weekend Wars', 'Second track on Oracular Spectacular album, featuring psychedelic synths and lyrics about escapism and the search for meaning.', '00:04:12', '2008-01-01', 7),
(134, 'The Youth', 'Third track on Oracular Spectacular album, with a catchy chorus and themes of youthful rebellion and angst.', '00:03:48', '2007-01-22', 7),
(135, 'Electric Feel', 'Fourth track on Oracular Spectacular album, an upbeat and funky song about a strong attraction to someone.', '00:03:49', '2008-06-16', 7),
(136, 'Kids', 'Fifth track on Oracular Spectacular album, with its iconic opening riff and lyrics about childhood innocence and nostalgia.', '00:05:03', '2008-09-22', 7),
(137, '4th Dimensional Transition', 'Sixth track on Oracular Spectacular album, with psychedelic and experimental elements, distorted vocals, electronic beats, and a melodic guitar riff. The lyrics touch on themes of spirituality, transcendence, and the search for meaning in life.', '03:58:00', '2007-10-02', 7),
(138, 'Scary Monsters and Nice Sprites', 'One of the most famous dubstep tracks, known for its iconic drop and heavy bassline. Created by Skrillex.', '00:04:03', '2010-10-22', 8),
(139, 'Cracks', 'A popular dubstep remix of the Freestylers\' track, featuring the haunting vocals of Belle Humble. Created by Flux Pavilion.', '00:05:01', '2010-11-21', 9),
(140, 'Tetris', 'A high-energy and nostalgic dubstep track with a catchy melody and video game-inspired sounds. Created by Doctor P.', '00:04:22', '2011-01-03', 10),
(141, 'Bass Cannon', 'A classic dubstep track with a powerful bassline and aggressive drops. Created by Flux Pavilion.', '00:04:49', '2011-02-28', 11),
(142, 'Holdin On', 'A melodic and uplifting dubstep track with soulful vocals and a bouncy beat. Created by Flume.', '00:02:36', '2012-11-09', 12),
(143, 'Rolling in the Deep', 'First single from the album. A soulful, energetic track with a catchy chorus.', '00:03:48', '2010-11-29', 13),
(144, 'Rumour Has It', 'A bluesy and sassy track with a driving beat and powerful vocals.', '00:03:43', '2011-01-14', 13),
(145, 'Turning Tables', 'A ballad showcasing Adele\'s soulful voice and piano skills.', '00:04:10', '2011-02-22', 13),
(146, 'Don\'t You Remember', 'A nostalgic ballad with a soft melody and emotional lyrics.', '00:04:03', '2011-01-04', 13),
(147, 'Set Fire to the Rain', 'A powerful ballad with a dramatic chorus and strong vocals.', '00:04:02', '2011-07-03', 13),
(148, 'He Won\'t Go', 'A soulful track with a driving beat and retro sound.', '00:04:38', '2011-01-21', 13),
(149, 'Take It All', 'A ballad with a soft melody and vulnerable lyrics.', '00:03:48', '2011-01-24', 13),
(150, 'I\'ll Be Waiting', 'A soulful track with a retro sound and catchy chorus.', '00:04:01', '2011-01-24', 13),
(151, 'One and Only', 'A ballad with a strong melody and powerful vocals.', '00:05:49', '2011-01-16', 13),
(152, 'Lovesong', 'A cover of The Cure\'s classic song, with Adele\'s signature soulful sound.', '00:05:16', '2011-01-17', 13),
(153, 'Someone Like You', 'A ballad with a simple piano melody and emotional lyrics. Became one of Adele\'s most popular songs.', '00:04:45', '2011-01-24', 13);

--
-- Triggers `track`
--
DELIMITER $$
CREATE TRIGGER `trg_track_delete` AFTER DELETE ON `track` FOR EACH ROW BEGIN
    -- Delete the associated image row
    DELETE FROM image WHERE image_id = OLD.image_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_track_update` AFTER UPDATE ON `track` FOR EACH ROW BEGIN  
    -- Delete the associated image row  
    DELETE FROM image WHERE image_id = OLD.image_id;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tracklist`
--

CREATE TABLE `tracklist` (
  `tracklist_id` int(11) NOT NULL,
  `tracklist_track_position` smallint(6) DEFAULT NULL,
  `tracklist_track_added` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `track_id` int(11) NOT NULL,
  `playlist_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `track_album`
--

CREATE TABLE `track_album` (
  `track_album_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  `album_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `track_album`
--

INSERT INTO `track_album` (`track_album_id`, `track_id`, `album_id`) VALUES
(1, 104, 65),
(2, 105, 65),
(3, 106, 65),
(4, 107, 65),
(5, 108, 65),
(6, 109, 65),
(7, 110, 65),
(8, 111, 65),
(9, 112, 65),
(10, 113, 65),
(11, 114, 66),
(12, 115, 66),
(13, 116, 66),
(14, 117, 66),
(15, 118, 66),
(16, 119, 66),
(17, 120, 66),
(18, 121, 66),
(19, 122, 66),
(20, 123, 66),
(21, 124, 66),
(31, 125, 70),
(32, 126, 70),
(33, 127, 70),
(34, 128, 70),
(35, 129, 70),
(36, 130, 70),
(37, 131, 70),
(38, 132, 71),
(39, 133, 71),
(40, 134, 71),
(41, 135, 71),
(42, 136, 71),
(43, 137, 71),
(44, 143, 72),
(45, 144, 72),
(46, 145, 72),
(47, 146, 72),
(48, 147, 72),
(49, 148, 72),
(50, 149, 72),
(51, 150, 72),
(52, 151, 72),
(53, 152, 72),
(54, 153, 72);

-- --------------------------------------------------------

--
-- Table structure for table `track_artist`
--

CREATE TABLE `track_artist` (
  `track_artist_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `track_artist`
--

INSERT INTO `track_artist` (`track_artist_id`, `track_id`, `artist_id`) VALUES
(1, 104, 6),
(2, 105, 6),
(3, 106, 6),
(4, 107, 6),
(5, 108, 6),
(6, 109, 6),
(7, 110, 6),
(8, 111, 6),
(9, 112, 6),
(10, 113, 6),
(16, 114, 7),
(17, 115, 7),
(18, 116, 7),
(19, 117, 7),
(20, 118, 7),
(21, 119, 7),
(22, 120, 7),
(23, 121, 7),
(24, 122, 7),
(25, 123, 7),
(26, 124, 7),
(53, 125, 10),
(54, 126, 10),
(55, 127, 10),
(56, 128, 10),
(57, 129, 10),
(58, 130, 10),
(59, 131, 10),
(31, 132, 8),
(32, 133, 8),
(33, 134, 8),
(34, 135, 8),
(35, 136, 8),
(36, 137, 8),
(61, 138, 1),
(60, 139, 2),
(62, 140, 4),
(63, 141, 3),
(64, 142, 5),
(38, 143, 9),
(39, 144, 9),
(40, 145, 9),
(41, 146, 9),
(42, 147, 9),
(43, 148, 9),
(44, 149, 9),
(45, 150, 9),
(46, 151, 9),
(47, 152, 9),
(48, 153, 9);

-- --------------------------------------------------------

--
-- Table structure for table `track_genre_subgenre`
--

CREATE TABLE `track_genre_subgenre` (
  `track_genre_subgenre_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  `genre_subgenre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `track_genre_subgenre`
--

INSERT INTO `track_genre_subgenre` (`track_genre_subgenre_id`, `track_id`, `genre_subgenre_id`) VALUES
(1, 104, 2),
(16, 104, 3),
(31, 104, 5),
(2, 105, 2),
(17, 105, 3),
(32, 105, 5),
(3, 106, 2),
(18, 106, 3),
(33, 106, 5),
(4, 107, 2),
(19, 107, 3),
(34, 107, 5),
(5, 108, 2),
(20, 108, 3),
(35, 108, 5),
(6, 109, 2),
(21, 109, 3),
(36, 109, 5),
(7, 110, 2),
(22, 110, 3),
(37, 110, 5),
(8, 111, 2),
(23, 111, 3),
(38, 111, 5),
(9, 112, 2),
(24, 112, 3),
(39, 112, 5),
(10, 113, 2),
(25, 113, 3),
(40, 113, 5),
(46, 114, 4),
(61, 114, 5),
(76, 114, 6),
(47, 115, 4),
(62, 115, 5),
(77, 115, 6),
(48, 116, 4),
(63, 116, 5),
(78, 116, 6),
(49, 117, 4),
(64, 117, 5),
(79, 117, 6),
(50, 118, 4),
(65, 118, 5),
(80, 118, 6),
(51, 119, 4),
(66, 119, 5),
(81, 119, 6),
(52, 120, 4),
(67, 120, 5),
(82, 120, 6),
(53, 121, 4),
(68, 121, 5),
(83, 121, 6),
(54, 122, 4),
(69, 122, 5),
(84, 122, 6),
(55, 123, 4),
(70, 123, 5),
(85, 123, 6),
(56, 124, 4),
(71, 124, 5),
(86, 124, 6),
(91, 125, 15),
(92, 126, 15),
(93, 127, 15),
(94, 128, 15),
(95, 129, 15),
(96, 130, 15),
(97, 131, 15),
(98, 132, 7),
(105, 132, 8),
(99, 133, 7),
(106, 133, 8),
(100, 134, 7),
(107, 134, 8),
(101, 135, 7),
(108, 135, 8),
(102, 136, 7),
(109, 136, 8),
(103, 137, 7),
(110, 137, 8),
(157, 138, 11),
(158, 138, 12),
(159, 139, 11),
(160, 139, 12),
(161, 140, 11),
(162, 140, 13),
(163, 141, 11),
(164, 141, 12),
(165, 142, 11),
(166, 142, 14),
(112, 143, 6),
(127, 143, 9),
(142, 143, 10),
(113, 144, 6),
(128, 144, 9),
(143, 144, 10),
(114, 145, 6),
(129, 145, 9),
(144, 145, 10),
(115, 146, 6),
(130, 146, 9),
(145, 146, 10),
(116, 147, 6),
(131, 147, 9),
(146, 147, 10),
(117, 148, 6),
(132, 148, 9),
(147, 148, 10),
(118, 149, 6),
(133, 149, 9),
(148, 149, 10),
(119, 150, 6),
(134, 150, 9),
(149, 150, 10),
(120, 151, 6),
(135, 151, 9),
(150, 151, 10),
(121, 152, 6),
(136, 152, 9),
(151, 152, 10),
(122, 153, 6),
(137, 153, 9),
(152, 153, 10);

-- --------------------------------------------------------

--
-- Table structure for table `track_licensing`
--

CREATE TABLE `track_licensing` (
  `track_licensing_id` int(11) NOT NULL,
  `licensing_note` text DEFAULT NULL,
  `track_id` int(11) NOT NULL,
  `licensing_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `track_licensing`
--

INSERT INTO `track_licensing` (`track_licensing_id`, `licensing_note`, `track_id`, `licensing_id`) VALUES
(65, 'licensed under regular commercial licenses', 104, 1),
(66, 'licensed under regular commercial licenses', 105, 1),
(67, 'licensed under regular commercial licenses', 106, 1),
(68, 'licensed under regular commercial licenses', 107, 1),
(69, 'licensed under regular commercial licenses', 108, 1),
(70, 'licensed under regular commercial licenses', 109, 1),
(71, 'licensed under regular commercial licenses', 110, 1),
(72, 'licensed under regular commercial licenses', 111, 1),
(73, 'licensed under regular commercial licenses', 112, 1),
(74, 'licensed under regular commercial licenses', 113, 1),
(75, 'licensed under regular commercial licenses', 114, 1),
(76, 'licensed under regular commercial licenses', 115, 1),
(77, 'licensed under regular commercial licenses', 116, 1),
(78, 'licensed under regular commercial licenses', 117, 1),
(79, 'licensed under regular commercial licenses', 118, 1),
(80, 'licensed under regular commercial licenses', 119, 1),
(81, 'licensed under regular commercial licenses', 120, 1),
(82, 'licensed under regular commercial licenses', 121, 1),
(83, 'licensed under regular commercial licenses', 122, 1),
(84, 'licensed under regular commercial licenses', 123, 1),
(85, 'licensed under regular commercial licenses', 124, 1),
(86, 'licensed under regular commercial licenses', 125, 1),
(87, 'licensed under regular commercial licenses', 126, 1),
(88, 'licensed under regular commercial licenses', 127, 1),
(89, 'licensed under regular commercial licenses', 128, 1),
(90, 'licensed under regular commercial licenses', 129, 1),
(91, 'licensed under regular commercial licenses', 130, 1),
(92, 'licensed under regular commercial licenses', 131, 1),
(93, 'licensed under regular commercial licenses', 132, 1),
(94, 'licensed under regular commercial licenses', 133, 1),
(95, 'licensed under regular commercial licenses', 134, 1),
(96, 'licensed under regular commercial licenses', 135, 1),
(97, 'licensed under regular commercial licenses', 136, 1),
(98, 'licensed under regular commercial licenses', 137, 1),
(99, 'licensed under regular commercial licenses', 138, 1),
(100, 'licensed under regular commercial licenses', 139, 1),
(101, 'licensed under regular commercial licenses', 140, 1),
(102, 'licensed under regular commercial licenses', 141, 1),
(103, 'licensed under regular commercial licenses', 142, 1),
(104, 'licensed under regular commercial licenses', 143, 1),
(105, 'licensed under regular commercial licenses', 144, 1),
(106, 'licensed under regular commercial licenses', 145, 1),
(107, 'licensed under regular commercial licenses', 146, 1),
(108, 'licensed under regular commercial licenses', 147, 1),
(109, 'licensed under regular commercial licenses', 148, 1),
(110, 'licensed under regular commercial licenses', 149, 1),
(111, 'licensed under regular commercial licenses', 150, 1),
(112, 'licensed under regular commercial licenses', 151, 1),
(113, 'licensed under regular commercial licenses', 152, 1),
(114, 'licensed under regular commercial licenses', 153, 1);

-- --------------------------------------------------------

--
-- Table structure for table `track_record_company`
--

CREATE TABLE `track_record_company` (
  `track_record_company_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  `record_company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `track_record_company`
--

INSERT INTO `track_record_company` (`track_record_company_id`, `track_id`, `record_company_id`) VALUES
(1, 104, 1),
(16, 104, 2),
(2, 105, 1),
(17, 105, 2),
(3, 106, 1),
(18, 106, 2),
(4, 107, 1),
(19, 107, 2),
(5, 108, 1),
(20, 108, 2),
(6, 109, 1),
(21, 109, 2),
(7, 110, 1),
(22, 110, 2),
(8, 111, 1),
(23, 111, 2),
(9, 112, 1),
(24, 112, 2),
(10, 113, 1),
(25, 113, 2),
(31, 114, 3),
(32, 115, 3),
(33, 116, 3),
(34, 117, 3),
(35, 118, 3),
(36, 119, 3),
(37, 120, 3),
(38, 121, 3),
(39, 122, 3),
(40, 123, 3),
(41, 124, 3),
(46, 132, 4),
(47, 133, 4),
(48, 134, 4),
(49, 135, 4),
(50, 136, 4),
(51, 137, 4),
(53, 143, 5),
(54, 144, 5),
(55, 145, 5),
(56, 146, 5),
(57, 147, 5),
(58, 148, 5),
(59, 149, 5),
(60, 150, 5),
(61, 151, 5),
(62, 152, 5),
(63, 153, 5);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_identifier` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_password` varbinary(255) DEFAULT NULL,
  `user_google_token` varbinary(255) DEFAULT NULL,
  `user_2fa_enabled` tinyint(1) DEFAULT NULL,
  `user_2fa_token` varbinary(255) DEFAULT NULL,
  `user_api_key` varbinary(255) DEFAULT NULL,
  `user_secret_key` varbinary(255) DEFAULT NULL,
  `user_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_identifier`, `user_email`, `user_password`, `user_google_token`, `user_2fa_enabled`, `user_2fa_token`, `user_api_key`, `user_secret_key`, `user_created`) VALUES
(64, '@neutronix', 'robertoloduca@hotmail.it', 0x24326224313024304e557a7330466d66726a35374c37466461434b382e386e65464d3575437a5a69554c42734f634452483662526245412e6e6c6575, NULL, NULL, NULL, NULL, NULL, '2023-05-03 12:45:58'),
(65, '@alice', 'aliceloduca@hotmail.it', 0x243262243130245537454f74767345387865756759302f2f43727439654f5a55614d72657934482e77784337303959374d44735277562f6456324257, NULL, NULL, NULL, NULL, NULL, '2023-05-03 13:25:15');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `trg_user_delete` AFTER DELETE ON `user` FOR EACH ROW BEGIN
    -- Delete the associated user profile image row
    DELETE FROM image WHERE image_id = (
        SELECT user_profile.image_id FROM user_profile WHERE user_profile.user_id = OLD.user_id
    );
    
    -- Delete any playlist images associated with the user
    DELETE FROM image WHERE image_id IN (
        SELECT playlist.image_id FROM playlist WHERE playlist.user_id = OLD.user_id
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_user_profile_add` AFTER INSERT ON `user` FOR EACH ROW BEGIN
  INSERT INTO user_profile (user_id) VALUES (NEW.user_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `user_profile_id` int(11) NOT NULL,
  `user_profile_name` varchar(255) DEFAULT NULL,
  `user_profile_birthday` date DEFAULT NULL,
  `user_profile_bio` text DEFAULT NULL,
  `user_profile_description` text DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`user_profile_id`, `user_profile_name`, `user_profile_birthday`, `user_profile_bio`, `user_profile_description`, `user_id`, `image_id`) VALUES
(3, NULL, NULL, NULL, NULL, 64, 29),
(4, NULL, NULL, NULL, NULL, 65, NULL);

--
-- Triggers `user_profile`
--
DELIMITER $$
CREATE TRIGGER `trg_user_profile_delete` AFTER DELETE ON `user_profile` FOR EACH ROW BEGIN 
    -- Delete the associated image row 
    DELETE FROM image WHERE image_id = OLD.image_id; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_user_profile_update` AFTER UPDATE ON `user_profile` FOR EACH ROW BEGIN 
    -- Delete the associated image row 
    DELETE FROM image WHERE image_id = OLD.image_id; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_terms_of_service`
--

CREATE TABLE `user_terms_of_service` (
  `user_terms_of_service_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `terms_of_service_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`album_id`),
  ADD KEY `image_id` (`image_id`) USING BTREE;

--
-- Indexes for table `artist`
--
ALTER TABLE `artist`
  ADD PRIMARY KEY (`artist_id`),
  ADD UNIQUE KEY `image_id` (`image_id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `FK_comment_id_comment` (`comment_reply_id`),
  ADD KEY `FK_reaction_id_comment` (`reaction_id`);

--
-- Indexes for table `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`favourite_id`),
  ADD UNIQUE KEY `reaction_id` (`reaction_id`);

--
-- Indexes for table `genre_subgenre`
--
ALTER TABLE `genre_subgenre`
  ADD PRIMARY KEY (`genre_subgenre_id`),
  ADD UNIQUE KEY `genre_subgenre_name` (`genre_subgenre_name`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `licensing`
--
ALTER TABLE `licensing`
  ADD PRIMARY KEY (`licensing_id`),
  ADD UNIQUE KEY `licensing_name` (`licensing_name`);

--
-- Indexes for table `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`playlist_id`),
  ADD UNIQUE KEY `image_id` (`image_id`),
  ADD KEY `FK_user_id_playlist` (`user_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`rating_id`),
  ADD UNIQUE KEY `reaction_id` (`reaction_id`);

--
-- Indexes for table `reaction`
--
ALTER TABLE `reaction`
  ADD PRIMARY KEY (`reaction_id`),
  ADD UNIQUE KEY `UK_all_keys` (`artist_id`,`track_id`,`album_id`,`playlist_id`,`user_receiver_id`,`user_id`),
  ADD KEY `FK_track_id_reaction` (`track_id`),
  ADD KEY `FK_album_id_reaction` (`album_id`),
  ADD KEY `FK_playlist_id_reaction` (`playlist_id`),
  ADD KEY `FK_user_receiver_id_reaction` (`user_receiver_id`),
  ADD KEY `FK_user_id_reaction` (`user_id`);

--
-- Indexes for table `record_company`
--
ALTER TABLE `record_company`
  ADD PRIMARY KEY (`record_company_id`),
  ADD UNIQUE KEY `record_company_name` (`record_company_name`),
  ADD UNIQUE KEY `image_id` (`image_id`);

--
-- Indexes for table `report_track`
--
ALTER TABLE `report_track`
  ADD PRIMARY KEY (`report_track_id`),
  ADD KEY `FK_track_id_report_track` (`track_id`),
  ADD KEY `FK_user_id_report_track` (`user_id`);

--
-- Indexes for table `report_user`
--
ALTER TABLE `report_user`
  ADD PRIMARY KEY (`report_user_id`),
  ADD KEY `FK_user_id_report_user` (`user_id`),
  ADD KEY `FK_user_reported_id_report_user` (`user_reported_id`),
  ADD KEY `FK_comment_id_report_user` (`comment_id`),
  ADD KEY `FK_report_user_reason_id_report_user` (`report_user_reason_id`);

--
-- Indexes for table `report_user_reason`
--
ALTER TABLE `report_user_reason`
  ADD PRIMARY KEY (`report_reason_id`),
  ADD UNIQUE KEY `report_user_reason_title` (`report_user_reason_title`);

--
-- Indexes for table `terms_of_service`
--
ALTER TABLE `terms_of_service`
  ADD PRIMARY KEY (`terms_of_service_id`);

--
-- Indexes for table `track`
--
ALTER TABLE `track`
  ADD PRIMARY KEY (`track_id`),
  ADD KEY `image_id` (`image_id`) USING BTREE;

--
-- Indexes for table `tracklist`
--
ALTER TABLE `tracklist`
  ADD PRIMARY KEY (`tracklist_id`),
  ADD UNIQUE KEY `UK_track_id_playlist_id` (`track_id`,`playlist_id`),
  ADD KEY `FK_playlist_id_tracklist` (`playlist_id`);

--
-- Indexes for table `track_album`
--
ALTER TABLE `track_album`
  ADD PRIMARY KEY (`track_album_id`),
  ADD UNIQUE KEY `UK_track_id_album_id` (`track_id`,`album_id`) USING BTREE,
  ADD KEY `FK_album_id_track_album` (`album_id`);

--
-- Indexes for table `track_artist`
--
ALTER TABLE `track_artist`
  ADD PRIMARY KEY (`track_artist_id`),
  ADD UNIQUE KEY `UK_track_id_artist_id` (`track_id`,`artist_id`) USING BTREE,
  ADD KEY `FK_artist_id_track_artist` (`artist_id`);

--
-- Indexes for table `track_genre_subgenre`
--
ALTER TABLE `track_genre_subgenre`
  ADD PRIMARY KEY (`track_genre_subgenre_id`),
  ADD UNIQUE KEY `UK_track_id_genre_subgenre_id` (`track_id`,`genre_subgenre_id`),
  ADD KEY `FK_genre_subgenre_id_track_genre_subgenre` (`genre_subgenre_id`);

--
-- Indexes for table `track_licensing`
--
ALTER TABLE `track_licensing`
  ADD PRIMARY KEY (`track_licensing_id`),
  ADD UNIQUE KEY `UK_track_id_licensing_id` (`track_id`,`licensing_id`),
  ADD KEY `FK_licensing_id_track_licensing` (`licensing_id`);

--
-- Indexes for table `track_record_company`
--
ALTER TABLE `track_record_company`
  ADD PRIMARY KEY (`track_record_company_id`),
  ADD UNIQUE KEY `UK_track_id_record_company_id` (`track_id`,`record_company_id`),
  ADD KEY `FK_record_company_id_track_record_company` (`record_company_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD UNIQUE KEY `user_identifier` (`user_identifier`) USING BTREE,
  ADD UNIQUE KEY `user_google_token` (`user_google_token`),
  ADD UNIQUE KEY `user_2fa_token` (`user_2fa_token`),
  ADD UNIQUE KEY `user_api_key` (`user_api_key`),
  ADD UNIQUE KEY `user_secret_key` (`user_secret_key`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`user_profile_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `image_id` (`image_id`);

--
-- Indexes for table `user_terms_of_service`
--
ALTER TABLE `user_terms_of_service`
  ADD PRIMARY KEY (`user_terms_of_service_id`),
  ADD UNIQUE KEY `UK_user_id_terms_of_service_id` (`user_id`,`terms_of_service_id`) USING BTREE,
  ADD KEY `FK_terms_of_service_id_user_terms_of_service` (`terms_of_service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `album`
--
ALTER TABLE `album`
  MODIFY `album_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `artist`
--
ALTER TABLE `artist`
  MODIFY `artist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `favourite`
--
ALTER TABLE `favourite`
  MODIFY `favourite_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genre_subgenre`
--
ALTER TABLE `genre_subgenre`
  MODIFY `genre_subgenre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `licensing`
--
ALTER TABLE `licensing`
  MODIFY `licensing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `playlist`
--
ALTER TABLE `playlist`
  MODIFY `playlist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reaction`
--
ALTER TABLE `reaction`
  MODIFY `reaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `record_company`
--
ALTER TABLE `record_company`
  MODIFY `record_company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `report_track`
--
ALTER TABLE `report_track`
  MODIFY `report_track_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_user`
--
ALTER TABLE `report_user`
  MODIFY `report_user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_user_reason`
--
ALTER TABLE `report_user_reason`
  MODIFY `report_reason_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `terms_of_service`
--
ALTER TABLE `terms_of_service`
  MODIFY `terms_of_service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `track`
--
ALTER TABLE `track`
  MODIFY `track_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT for table `tracklist`
--
ALTER TABLE `tracklist`
  MODIFY `tracklist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `track_album`
--
ALTER TABLE `track_album`
  MODIFY `track_album_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `track_artist`
--
ALTER TABLE `track_artist`
  MODIFY `track_artist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `track_genre_subgenre`
--
ALTER TABLE `track_genre_subgenre`
  MODIFY `track_genre_subgenre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- AUTO_INCREMENT for table `track_licensing`
--
ALTER TABLE `track_licensing`
  MODIFY `track_licensing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `track_record_company`
--
ALTER TABLE `track_record_company`
  MODIFY `track_record_company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_profile`
--
ALTER TABLE `user_profile`
  MODIFY `user_profile_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_terms_of_service`
--
ALTER TABLE `user_terms_of_service`
  MODIFY `user_terms_of_service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `album`
--
ALTER TABLE `album`
  ADD CONSTRAINT `FK_image_id_album` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`) ON DELETE SET NULL;

--
-- Constraints for table `artist`
--
ALTER TABLE `artist`
  ADD CONSTRAINT `FK_image_id_artist` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`) ON DELETE SET NULL;

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FK_comment_id_comment` FOREIGN KEY (`comment_reply_id`) REFERENCES `comment` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_reaction_id_comment` FOREIGN KEY (`reaction_id`) REFERENCES `reaction` (`reaction_id`);

--
-- Constraints for table `favourite`
--
ALTER TABLE `favourite`
  ADD CONSTRAINT `FK_reaction_id_favourite` FOREIGN KEY (`reaction_id`) REFERENCES `reaction` (`reaction_id`) ON DELETE CASCADE;

--
-- Constraints for table `playlist`
--
ALTER TABLE `playlist`
  ADD CONSTRAINT `FK_image_id_playlist` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_user_id_playlist` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `FK_reaction_id_rating` FOREIGN KEY (`reaction_id`) REFERENCES `reaction` (`reaction_id`) ON DELETE CASCADE;

--
-- Constraints for table `reaction`
--
ALTER TABLE `reaction`
  ADD CONSTRAINT `FK_album_id_reaction` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_artist_id_reaction` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_playlist_id_reaction` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`playlist_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_track_id_reaction` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_user_id_reaction` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_user_receiver_id_reaction` FOREIGN KEY (`user_receiver_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `record_company`
--
ALTER TABLE `record_company`
  ADD CONSTRAINT `FK_image_id_record_company` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`) ON DELETE SET NULL;

--
-- Constraints for table `report_track`
--
ALTER TABLE `report_track`
  ADD CONSTRAINT `FK_track_id_report_track` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_user_id_report_track` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `report_user`
--
ALTER TABLE `report_user`
  ADD CONSTRAINT `FK_comment_id_report_user` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_report_user_reason_id_report_user` FOREIGN KEY (`report_user_reason_id`) REFERENCES `report_user_reason` (`report_reason_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_user_id_report_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_user_reported_id_report_user` FOREIGN KEY (`user_reported_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `track`
--
ALTER TABLE `track`
  ADD CONSTRAINT `FK_image_id_track` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`) ON DELETE SET NULL;

--
-- Constraints for table `tracklist`
--
ALTER TABLE `tracklist`
  ADD CONSTRAINT `FK_playlist_id_tracklist` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`playlist_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_track_id_tracklist` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`) ON DELETE CASCADE;

--
-- Constraints for table `track_album`
--
ALTER TABLE `track_album`
  ADD CONSTRAINT `FK_album_id_track_album` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_track_id_track_album` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`) ON DELETE CASCADE;

--
-- Constraints for table `track_artist`
--
ALTER TABLE `track_artist`
  ADD CONSTRAINT `FK_artist_id_track_artist` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_track_id_track_artist` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`) ON DELETE CASCADE;

--
-- Constraints for table `track_genre_subgenre`
--
ALTER TABLE `track_genre_subgenre`
  ADD CONSTRAINT `FK_genre_subgenre_id_track_genre_subgenre` FOREIGN KEY (`genre_subgenre_id`) REFERENCES `genre_subgenre` (`genre_subgenre_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_track_id_track_genre_subgenre` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`) ON DELETE CASCADE;

--
-- Constraints for table `track_licensing`
--
ALTER TABLE `track_licensing`
  ADD CONSTRAINT `FK_licensing_id_track_licensing` FOREIGN KEY (`licensing_id`) REFERENCES `licensing` (`licensing_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_track_id_track_licensing` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`) ON DELETE CASCADE;

--
-- Constraints for table `track_record_company`
--
ALTER TABLE `track_record_company`
  ADD CONSTRAINT `FK_record_company_id_track_record_company` FOREIGN KEY (`record_company_id`) REFERENCES `record_company` (`record_company_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_track_id_track_record_company` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `FK_image_id_user_profile` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_user_id_user_profile` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_terms_of_service`
--
ALTER TABLE `user_terms_of_service`
  ADD CONSTRAINT `FK_terms_of_service_id_user_terms_of_service` FOREIGN KEY (`terms_of_service_id`) REFERENCES `terms_of_service` (`terms_of_service_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_user_id_user_terms_of_service` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
