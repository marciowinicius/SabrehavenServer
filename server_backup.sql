/*
 Navicat Premium Data Transfer

 Source Server         : UbuntuLocal18
 Source Server Type    : MySQL
 Source Server Version : 50739
 Source Host           : localhost:3306
 Source Schema         : marcioold

 Target Server Type    : MySQL
 Target Server Version : 50739
 File Encoding         : 65001

 Date: 23/01/2023 22:58:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_ban_history
-- ----------------------------
DROP TABLE IF EXISTS `account_ban_history`;
CREATE TABLE `account_ban_history`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account_id`(`account_id`) USING BTREE,
  INDEX `banned_by`(`banned_by`) USING BTREE,
  CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account_ban_history
-- ----------------------------

-- ----------------------------
-- Table structure for account_bans
-- ----------------------------
DROP TABLE IF EXISTS `account_bans`;
CREATE TABLE `account_bans`  (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`account_id`) USING BTREE,
  INDEX `banned_by`(`banned_by`) USING BTREE,
  CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account_bans
-- ----------------------------

-- ----------------------------
-- Table structure for account_viplist
-- ----------------------------
DROP TABLE IF EXISTS `account_viplist`;
CREATE TABLE `account_viplist`  (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `notify` tinyint(1) NOT NULL DEFAULT 0,
  UNIQUE INDEX `account_player_index`(`account_id`, `player_id`) USING BTREE,
  INDEX `player_id`(`player_id`) USING BTREE,
  CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account_viplist
-- ----------------------------

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` int(11) NOT NULL,
  `password` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `premdays` int(11) NOT NULL DEFAULT 0,
  `lastday` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `creation` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES (1, 120795, '36bfd7932196fd065cbda31c92e49d16d652085a', 6, 0, 0, 'marciowinicius.mw@hotmail.com', 1674525416);

-- ----------------------------
-- Table structure for global_storage
-- ----------------------------
DROP TABLE IF EXISTS `global_storage`;
CREATE TABLE `global_storage`  (
  `key` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of global_storage
-- ----------------------------
INSERT INTO `global_storage` VALUES (1, 0);

-- ----------------------------
-- Table structure for guild_invites
-- ----------------------------
DROP TABLE IF EXISTS `guild_invites`;
CREATE TABLE `guild_invites`  (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`, `guild_id`) USING BTREE,
  INDEX `guild_id`(`guild_id`) USING BTREE,
  CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guild_invites
-- ----------------------------

-- ----------------------------
-- Table structure for guild_membership
-- ----------------------------
DROP TABLE IF EXISTS `guild_membership`;
CREATE TABLE `guild_membership`  (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`player_id`) USING BTREE,
  INDEX `guild_id`(`guild_id`) USING BTREE,
  INDEX `rank_id`(`rank_id`) USING BTREE,
  CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guild_membership
-- ----------------------------

-- ----------------------------
-- Table structure for guild_ranks
-- ----------------------------
DROP TABLE IF EXISTS `guild_ranks`;
CREATE TABLE `guild_ranks`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `guild_id`(`guild_id`) USING BTREE,
  CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guild_ranks
-- ----------------------------

-- ----------------------------
-- Table structure for guild_wars
-- ----------------------------
DROP TABLE IF EXISTS `guild_wars`;
CREATE TABLE `guild_wars`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild1` int(11) NOT NULL DEFAULT 0,
  `guild2` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `frag_limit` int(11) NOT NULL DEFAULT 0,
  `declaration_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `bounty` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `guild1`(`guild1`) USING BTREE,
  INDEX `guild2`(`guild2`) USING BTREE,
  CONSTRAINT `guild1_ibfk_1` FOREIGN KEY (`guild1`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `guild2_ibfk_1` FOREIGN KEY (`guild2`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guild_wars
-- ----------------------------

-- ----------------------------
-- Table structure for guilds
-- ----------------------------
DROP TABLE IF EXISTS `guilds`;
CREATE TABLE `guilds`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `motd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `ownerid`(`ownerid`) USING BTREE,
  CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guilds
-- ----------------------------

-- ----------------------------
-- Table structure for guildwar_kills
-- ----------------------------
DROP TABLE IF EXISTS `guildwar_kills`;
CREATE TABLE `guildwar_kills`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `killer` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `target` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT 0,
  `targetguild` int(11) NOT NULL DEFAULT 0,
  `warid` int(11) NOT NULL DEFAULT 0,
  `time` bigint(15) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `warid`(`warid`) USING BTREE,
  CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guildwar_kills
-- ----------------------------

-- ----------------------------
-- Table structure for house_lists
-- ----------------------------
DROP TABLE IF EXISTS `house_lists`;
CREATE TABLE `house_lists`  (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `house_id`(`house_id`) USING BTREE,
  CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house_lists
-- ----------------------------

-- ----------------------------
-- Table structure for houses
-- ----------------------------
DROP TABLE IF EXISTS `houses`;
CREATE TABLE `houses`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` int(11) NOT NULL,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `warnings` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rent` int(11) NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 0,
  `bid` int(11) NOT NULL DEFAULT 0,
  `bid_end` int(11) NOT NULL DEFAULT 0,
  `last_bid` int(11) NOT NULL DEFAULT 0,
  `highest_bidder` int(11) NOT NULL DEFAULT 0,
  `size` int(11) NOT NULL DEFAULT 0,
  `beds` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `owner`(`owner`) USING BTREE,
  INDEX `town_id`(`town_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 862 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of houses
-- ----------------------------
INSERT INTO `houses` VALUES (1, 0, 0, 0, 'Spiritkeep', 36220, 1, 0, 0, 0, 0, 378, 23);
INSERT INTO `houses` VALUES (2, 0, 0, 0, 'Snake Tower', 57440, 1, 0, 0, 0, 0, 616, 21);
INSERT INTO `houses` VALUES (3, 0, 0, 0, 'Halls of the Adventurers', 29060, 1, 0, 0, 0, 0, 304, 18);
INSERT INTO `houses` VALUES (4, 0, 0, 0, 'Dark Mansion', 34090, 1, 0, 0, 0, 0, 361, 17);
INSERT INTO `houses` VALUES (5, 0, 0, 0, 'Bloodhall', 29040, 1, 0, 0, 0, 0, 306, 16);
INSERT INTO `houses` VALUES (6, 0, 0, 0, 'Sunset Homes, Flat 01', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (7, 0, 0, 0, 'Sunset Homes, Flat 02', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (8, 0, 0, 0, 'Sunset Homes, Flat 03', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (9, 0, 0, 0, 'Sunset Homes, Flat 11', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (10, 0, 0, 0, 'Sunset Homes, Flat 12', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (11, 0, 0, 0, 'Sunset Homes, Flat 13', 1620, 1, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (12, 0, 0, 0, 'Sunset Homes, Flat 14', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (13, 0, 0, 0, 'Sunset Homes, Flat 21', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (14, 0, 0, 0, 'Sunset Homes, Flat 22', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (15, 0, 0, 0, 'Sunset Homes, Flat 23', 1620, 1, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (16, 0, 0, 0, 'Sunset Homes, Flat 24', 1040, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (17, 0, 0, 0, 'Beach Home Apartments, Flat 01', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (18, 0, 0, 0, 'Beach Home Apartments, Flat 02', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (19, 0, 0, 0, 'Beach Home Apartments, Flat 03', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (20, 0, 0, 0, 'Beach Home Apartments, Flat 04', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (21, 0, 0, 0, 'Beach Home Apartments, Flat 05', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (22, 0, 0, 0, 'Beach Home Apartments, Flat 06', 2190, 1, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (23, 0, 0, 0, 'Beach Home Apartments, Flat 11', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (24, 0, 0, 0, 'Beach Home Apartments, Flat 12', 1760, 1, 0, 0, 0, 0, 16, 1);
INSERT INTO `houses` VALUES (25, 0, 0, 0, 'Beach Home Apartments, Flat 13', 1760, 1, 0, 0, 0, 0, 16, 1);
INSERT INTO `houses` VALUES (26, 0, 0, 0, 'Beach Home Apartments, Flat 14', 770, 1, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (27, 0, 0, 0, 'Beach Home Apartments, Flat 15', 770, 1, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (28, 0, 0, 0, 'Beach Home Apartments, Flat 16', 2190, 1, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (29, 0, 0, 0, 'Alai Flats, Flat 01', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (30, 0, 0, 0, 'Alai Flats, Flat 02', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (31, 0, 0, 0, 'Alai Flats, Flat 03', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (32, 0, 0, 0, 'Alai Flats, Flat 04', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (33, 0, 0, 0, 'Alai Flats, Flat 05', 2350, 1, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (34, 0, 0, 0, 'Alai Flats, Flat 06', 2350, 1, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (35, 0, 0, 0, 'Alai Flats, Flat 07', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (36, 0, 0, 0, 'Alai Flats, Flat 08', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (37, 0, 0, 0, 'Alai Flats, Flat 11', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (38, 0, 0, 0, 'Alai Flats, Flat 12', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (39, 0, 0, 0, 'Alai Flats, Flat 13', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (40, 0, 0, 0, 'Alai Flats, Flat 14', 1800, 1, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` VALUES (41, 0, 0, 0, 'Alai Flats, Flat 15', 2800, 1, 0, 0, 0, 0, 30, 2);
INSERT INTO `houses` VALUES (42, 0, 0, 0, 'Alai Flats, Flat 16', 2800, 1, 0, 0, 0, 0, 30, 2);
INSERT INTO `houses` VALUES (43, 0, 0, 0, 'Alai Flats, Flat 17', 1800, 1, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` VALUES (44, 0, 0, 0, 'Alai Flats, Flat 18', 1800, 1, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` VALUES (45, 0, 0, 0, 'Alai Flats, Flat 22', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (46, 0, 0, 0, 'Alai Flats, Flat 21', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (47, 0, 0, 0, 'Alai Flats, Flat 23', 1530, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (48, 0, 0, 0, 'Alai Flats, Flat 24', 1800, 1, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` VALUES (49, 0, 0, 0, 'Alai Flats, Flat 25', 2800, 1, 0, 0, 0, 0, 30, 2);
INSERT INTO `houses` VALUES (50, 0, 0, 0, 'Alai Flats, Flat 26', 2800, 1, 0, 0, 0, 0, 30, 2);
INSERT INTO `houses` VALUES (51, 0, 0, 0, 'Alai Flats, Flat 27', 1800, 1, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` VALUES (52, 0, 0, 0, 'Alai Flats, Flat 28', 1800, 1, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` VALUES (53, 0, 0, 0, 'Upper Swamp Lane 2', 9180, 1, 0, 0, 0, 0, 74, 4);
INSERT INTO `houses` VALUES (54, 0, 0, 0, 'Upper Swamp Lane 4', 9180, 1, 0, 0, 0, 0, 74, 4);
INSERT INTO `houses` VALUES (55, 0, 0, 0, 'Lower Swamp Lane 1', 9180, 1, 0, 0, 0, 0, 74, 4);
INSERT INTO `houses` VALUES (56, 0, 0, 0, 'Lower Swamp Lane 3', 9180, 1, 0, 0, 0, 0, 74, 4);
INSERT INTO `houses` VALUES (57, 0, 0, 0, 'Upper Swamp Lane 8', 16040, 1, 0, 0, 0, 0, 132, 3);
INSERT INTO `houses` VALUES (58, 0, 0, 0, 'Southern Thais Guildhall', 43020, 1, 0, 0, 0, 0, 346, 16);
INSERT INTO `houses` VALUES (59, 0, 0, 0, 'Upper Swamp Lane 10', 3920, 1, 0, 0, 0, 0, 31, 3);
INSERT INTO `houses` VALUES (60, 0, 0, 0, 'Upper Swamp Lane 12', 7400, 1, 0, 0, 0, 0, 60, 3);
INSERT INTO `houses` VALUES (61, 0, 0, 0, 'Sorcerer\'s Avenue 1a', 2410, 1, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (62, 0, 0, 0, 'Sorcerer\'s Avenue 1b', 1970, 1, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (63, 0, 0, 0, 'Sorcerer\'s Avenue 1c', 2410, 1, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (64, 0, 0, 0, 'Sorcerer\'s Avenue 5', 5390, 1, 0, 0, 0, 0, 49, 1);
INSERT INTO `houses` VALUES (65, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2a', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (66, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2b', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (67, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2c', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (68, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2d', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (69, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2e', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (70, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2f', 1430, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (71, 0, 0, 0, 'Thais Clanhall', 15940, 1, 0, 0, 0, 0, 188, 10);
INSERT INTO `houses` VALUES (72, 0, 0, 0, 'Harbour Street 4', 1870, 1, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (73, 0, 0, 0, 'Thais Hostel', 11660, 1, 0, 0, 0, 0, 117, 24);
INSERT INTO `houses` VALUES (74, 0, 0, 0, 'Farm Lane, Basement (Shop)', 1890, 1, 0, 0, 0, 0, 21, 0);
INSERT INTO `houses` VALUES (75, 0, 0, 0, 'Farm Lane, 1st floor (Shop)', 1890, 1, 0, 0, 0, 0, 21, 0);
INSERT INTO `houses` VALUES (76, 0, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 1890, 1, 0, 0, 0, 0, 21, 0);
INSERT INTO `houses` VALUES (77, 0, 0, 0, 'Warriors Guildhall', 28450, 1, 0, 0, 0, 0, 305, 11);
INSERT INTO `houses` VALUES (78, 0, 0, 0, 'Main Street 9, 1st floor (Shop)', 2880, 1, 0, 0, 0, 0, 32, 0);
INSERT INTO `houses` VALUES (79, 0, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 1530, 1, 0, 0, 0, 0, 17, 0);
INSERT INTO `houses` VALUES (80, 0, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 2520, 1, 0, 0, 0, 0, 28, 0);
INSERT INTO `houses` VALUES (81, 0, 0, 0, 'Mill Avenue 1 (Shop)', 2600, 1, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (82, 0, 0, 0, 'Mill Avenue 2 (Shop)', 4600, 1, 0, 0, 0, 0, 45, 2);
INSERT INTO `houses` VALUES (83, 0, 0, 0, 'Mill Avenue 3', 2700, 1, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (84, 0, 0, 0, 'Mill Avenue 4', 2700, 1, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (85, 0, 0, 0, 'Mill Avenue 5', 6200, 1, 0, 0, 0, 0, 59, 4);
INSERT INTO `houses` VALUES (86, 0, 0, 0, 'The City Wall 5a', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (87, 0, 0, 0, 'The City Wall 5b', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (88, 0, 0, 0, 'The City Wall 5c', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (89, 0, 0, 0, 'The City Wall 5d', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (90, 0, 0, 0, 'The City Wall 5e', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (91, 0, 0, 0, 'The City Wall 5f', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (92, 0, 0, 0, 'The City Wall 7a', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (93, 0, 0, 0, 'The City Wall 7b', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (94, 0, 0, 0, 'The City Wall 7c', 1630, 1, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (95, 0, 0, 0, 'The City Wall 7d', 1630, 1, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (96, 0, 0, 0, 'The City Wall 7e', 1630, 1, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (97, 0, 0, 0, 'The City Wall 7f', 1630, 1, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (98, 0, 0, 0, 'The City Wall 7g', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (99, 0, 0, 0, 'The City Wall 7h', 1170, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (100, 0, 0, 0, 'The City Wall 9', 1810, 1, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (101, 0, 0, 0, 'The City Wall 3a', 1990, 1, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (102, 0, 0, 0, 'The City Wall 3b', 1990, 1, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (103, 0, 0, 0, 'The City Wall 3c', 1990, 1, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (104, 0, 0, 0, 'The City Wall 3d', 1990, 1, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (105, 0, 0, 0, 'The City Wall 3e', 1990, 1, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (106, 0, 0, 0, 'The City Wall 3f', 1990, 1, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (107, 0, 0, 0, 'The City Wall 1a', 2440, 1, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (108, 0, 0, 0, 'The City Wall 1b', 2440, 1, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (109, 0, 0, 0, 'Harbour Place 2 (Shop)', 2600, 1, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (110, 0, 0, 0, 'Harbour Place 1 (Shop)', 2200, 1, 0, 0, 0, 0, 22, 0);
INSERT INTO `houses` VALUES (111, 0, 0, 0, 'Mercenary Tower', 81410, 1, 0, 0, 0, 0, 607, 26);
INSERT INTO `houses` VALUES (112, 0, 0, 0, 'Guildhall of the Red Rose', 54050, 1, 0, 0, 0, 0, 405, 15);
INSERT INTO `houses` VALUES (113, 0, 0, 0, 'Fibula Village 1', 1690, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (114, 0, 0, 0, 'Fibula Village 2', 1690, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (115, 0, 0, 0, 'Fibula Village 3', 7320, 1, 0, 0, 0, 0, 54, 4);
INSERT INTO `houses` VALUES (116, 0, 0, 0, 'Fibula Village 4', 3480, 1, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (117, 0, 0, 0, 'Fibula Village 5', 3480, 1, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (118, 0, 0, 0, 'Fibula Village, Tower Flat', 10110, 1, 0, 0, 0, 0, 77, 2);
INSERT INTO `houses` VALUES (119, 0, 0, 0, 'Fibula Village, Bar', 10370, 1, 0, 0, 0, 0, 79, 2);
INSERT INTO `houses` VALUES (120, 0, 0, 0, 'Fibula Clanhall', 21960, 1, 0, 0, 0, 0, 162, 10);
INSERT INTO `houses` VALUES (121, 0, 0, 0, 'Fibula Village, Villa', 22380, 1, 0, 0, 0, 0, 242, 7);
INSERT INTO `houses` VALUES (122, 0, 0, 0, 'The Tibianic', 66900, 1, 0, 0, 0, 0, 540, 22);
INSERT INTO `houses` VALUES (123, 0, 0, 0, 'Castle of Greenshore', 36380, 1, 0, 0, 0, 0, 294, 12);
INSERT INTO `houses` VALUES (124, 0, 0, 0, 'Greenshore Village, Villa', 20580, 1, 0, 0, 0, 0, 169, 4);
INSERT INTO `houses` VALUES (125, 0, 0, 0, 'Greenshore Village, Shop', 3600, 1, 0, 0, 0, 0, 30, 1);
INSERT INTO `houses` VALUES (126, 0, 0, 0, 'Greenshore Village 1', 4640, 1, 0, 0, 0, 0, 37, 3);
INSERT INTO `houses` VALUES (127, 0, 0, 0, 'Greenshore Village 2', 1560, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (128, 0, 0, 0, 'Greenshore Village 3', 1560, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (129, 0, 0, 0, 'Greenshore Village 4', 1560, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (130, 0, 0, 0, 'Greenshore Village 5', 1560, 1, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (131, 0, 0, 0, 'Greenshore Village 6', 8620, 1, 0, 0, 0, 0, 71, 2);
INSERT INTO `houses` VALUES (132, 0, 0, 0, 'Greenshore Village 7', 2520, 1, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (133, 0, 0, 0, 'Greenshore Clanhall', 20700, 1, 0, 0, 0, 0, 165, 10);
INSERT INTO `houses` VALUES (134, 0, 0, 0, 'Moonkeep', 24540, 2, 0, 0, 0, 0, 288, 16);
INSERT INTO `houses` VALUES (135, 0, 0, 0, 'House of Recreation', 39460, 2, 0, 0, 0, 0, 412, 16);
INSERT INTO `houses` VALUES (136, 0, 0, 0, 'Nordic Stronghold', 34700, 2, 0, 0, 0, 0, 410, 21);
INSERT INTO `houses` VALUES (137, 0, 0, 0, 'Druids Retreat A', 2580, 2, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (138, 0, 0, 0, 'Druids Retreat B', 2420, 2, 0, 0, 0, 0, 29, 2);
INSERT INTO `houses` VALUES (139, 0, 0, 0, 'Druids Retreat C', 1860, 2, 0, 0, 0, 0, 22, 2);
INSERT INTO `houses` VALUES (140, 0, 0, 0, 'Druids Retreat D', 2260, 2, 0, 0, 0, 0, 27, 2);
INSERT INTO `houses` VALUES (141, 0, 0, 0, 'Central Plaza 3', 1200, 2, 0, 0, 0, 0, 12, 0);
INSERT INTO `houses` VALUES (142, 0, 0, 0, 'Central Plaza 2', 1200, 2, 0, 0, 0, 0, 12, 0);
INSERT INTO `houses` VALUES (143, 0, 0, 0, 'Central Plaza 1', 1200, 2, 0, 0, 0, 0, 12, 0);
INSERT INTO `houses` VALUES (144, 0, 0, 0, 'Park Lane 1a', 2340, 2, 0, 0, 0, 0, 28, 2);
INSERT INTO `houses` VALUES (145, 0, 0, 0, 'Park Lane 1b', 2660, 2, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (146, 0, 0, 0, 'Park Lane 3b', 2100, 2, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (147, 0, 0, 0, 'Park Lane 3a', 2340, 2, 0, 0, 0, 0, 28, 2);
INSERT INTO `houses` VALUES (148, 0, 0, 0, 'Park Lane 4', 1860, 2, 0, 0, 0, 0, 22, 2);
INSERT INTO `houses` VALUES (149, 0, 0, 0, 'Park Lane 2', 1860, 2, 0, 0, 0, 0, 22, 2);
INSERT INTO `houses` VALUES (150, 0, 0, 0, 'Theater Avenue 6a', 1540, 2, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (151, 0, 0, 0, 'Theater Avenue 6b', 1540, 2, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (152, 0, 0, 0, 'Theater Avenue 6c', 450, 2, 0, 0, 0, 0, 5, 1);
INSERT INTO `houses` VALUES (153, 0, 0, 0, 'Theater Avenue 6d', 450, 2, 0, 0, 0, 0, 5, 1);
INSERT INTO `houses` VALUES (154, 0, 0, 0, 'Theater Avenue 6e', 1540, 2, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (155, 0, 0, 0, 'Theater Avenue 6f', 1540, 2, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (156, 0, 0, 0, 'Theater Avenue 5a', 900, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (157, 0, 0, 0, 'Theater Avenue 5b', 900, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (158, 0, 0, 0, 'Theater Avenue 5c', 900, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (159, 0, 0, 0, 'Theater Avenue 5d', 900, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (160, 0, 0, 0, 'Theater Avenue 8a', 2440, 2, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (161, 0, 0, 0, 'Theater Avenue 8b', 2540, 2, 0, 0, 0, 0, 26, 3);
INSERT INTO `houses` VALUES (162, 0, 0, 0, 'Theater Avenue 7, Flat 01', 630, 2, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (163, 0, 0, 0, 'Theater Avenue 7, Flat 02', 810, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (164, 0, 0, 0, 'Theater Avenue 7, Flat 03', 810, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (165, 0, 0, 0, 'Theater Avenue 7, Flat 04', 990, 2, 0, 0, 0, 0, 11, 1);
INSERT INTO `houses` VALUES (166, 0, 0, 0, 'Theater Avenue 7, Flat 05', 810, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (167, 0, 0, 0, 'Theater Avenue 7, Flat 06', 630, 2, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (168, 0, 0, 0, 'Theater Avenue 7, Flat 11', 990, 2, 0, 0, 0, 0, 11, 1);
INSERT INTO `houses` VALUES (169, 0, 0, 0, 'Theater Avenue 7, Flat 12', 810, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (170, 0, 0, 0, 'Theater Avenue 7, Flat 13', 810, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (171, 0, 0, 0, 'Theater Avenue 7, Flat 14', 990, 2, 0, 0, 0, 0, 11, 1);
INSERT INTO `houses` VALUES (172, 0, 0, 0, 'Theater Avenue 7, Flat 15', 810, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (173, 0, 0, 0, 'Theater Avenue 7, Flat 16', 810, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (174, 0, 0, 0, 'Theater Avenue 10', 2080, 2, 0, 0, 0, 0, 22, 2);
INSERT INTO `houses` VALUES (175, 0, 0, 0, 'Theater Avenue 12', 1810, 2, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (176, 0, 0, 0, 'Theater Avenue 14 (Shop)', 4230, 2, 0, 0, 0, 0, 47, 1);
INSERT INTO `houses` VALUES (177, 0, 0, 0, 'Theater Avenue 11a', 2710, 2, 0, 0, 0, 0, 29, 2);
INSERT INTO `houses` VALUES (178, 0, 0, 0, 'Theater Avenue 11b', 1170, 2, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (179, 0, 0, 0, 'Theater Avenue 11c', 1170, 2, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (180, 0, 0, 0, 'Magician\'s Alley 1', 2000, 2, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (181, 0, 0, 0, 'Magician\'s Alley 1a', 1300, 2, 0, 0, 0, 0, 12, 2);
INSERT INTO `houses` VALUES (182, 0, 0, 0, 'Magician\'s Alley 1b', 1400, 2, 0, 0, 0, 0, 13, 2);
INSERT INTO `houses` VALUES (183, 0, 0, 0, 'Magician\'s Alley 1c', 1000, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (184, 0, 0, 0, 'Magician\'s Alley 1d', 900, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (185, 0, 0, 0, 'Magician\'s Alley 5a', 700, 2, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (186, 0, 0, 0, 'Magician\'s Alley 5b', 1000, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (187, 0, 0, 0, 'Magician\'s Alley 5c', 2200, 2, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (188, 0, 0, 0, 'Magician\'s Alley 5d', 1000, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (189, 0, 0, 0, 'Magician\'s Alley 5e', 1000, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (190, 0, 0, 0, 'Magician\'s Alley 5f', 2200, 2, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (191, 0, 0, 0, 'Magician\'s Alley 4', 5200, 2, 0, 0, 0, 0, 49, 4);
INSERT INTO `houses` VALUES (192, 0, 0, 0, 'Magician\'s Alley 8', 2700, 2, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (193, 0, 0, 0, 'Carlin Clanhall', 22700, 2, 0, 0, 0, 0, 218, 10);
INSERT INTO `houses` VALUES (194, 0, 0, 0, 'Northern Street 1a', 1780, 2, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (195, 0, 0, 0, 'Northern Street 1b', 1780, 2, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (196, 0, 0, 0, 'Northern Street 1c', 1380, 2, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (197, 0, 0, 0, 'Northern Street 3a', 1380, 2, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (198, 0, 0, 0, 'Northern Street 3b', 1460, 2, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (199, 0, 0, 0, 'Northern Street 5', 3860, 2, 0, 0, 0, 0, 47, 2);
INSERT INTO `houses` VALUES (200, 0, 0, 0, 'Northern Street 7', 3300, 2, 0, 0, 0, 0, 40, 2);
INSERT INTO `houses` VALUES (201, 0, 0, 0, 'Harbour Lane 1 (Shop)', 2080, 2, 0, 0, 0, 0, 26, 0);
INSERT INTO `houses` VALUES (202, 0, 0, 0, 'Harbour Lane 3', 6920, 2, 0, 0, 0, 0, 84, 3);
INSERT INTO `houses` VALUES (203, 0, 0, 0, 'Harbour Lane 2a (Shop)', 1360, 2, 0, 0, 0, 0, 17, 0);
INSERT INTO `houses` VALUES (204, 0, 0, 0, 'Harbour Lane 2b (Shop)', 1360, 2, 0, 0, 0, 0, 17, 0);
INSERT INTO `houses` VALUES (205, 0, 0, 0, 'Harbour Flats, Flat 11', 1040, 2, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (206, 0, 0, 0, 'Harbour Flats, Flat 12', 800, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (207, 0, 0, 0, 'Harbour Flats, Flat 13', 1040, 2, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (208, 0, 0, 0, 'Harbour Flats, Flat 14', 800, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (209, 0, 0, 0, 'Harbour Flats, Flat 15', 720, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (210, 0, 0, 0, 'Harbour Flats, Flat 16', 800, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (211, 0, 0, 0, 'Harbour Flats, Flat 17', 720, 2, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (212, 0, 0, 0, 'Harbour Flats, Flat 18', 800, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (213, 0, 0, 0, 'Harbour Flats, Flat 21', 1620, 2, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (214, 0, 0, 0, 'Harbour Flats, Flat 22', 1860, 2, 0, 0, 0, 0, 22, 2);
INSERT INTO `houses` VALUES (215, 0, 0, 0, 'Harbour Flats, Flat 23', 800, 2, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (216, 0, 0, 0, 'East Lane 1a', 4420, 2, 0, 0, 0, 0, 54, 2);
INSERT INTO `houses` VALUES (217, 0, 0, 0, 'East Lane 1b', 3300, 2, 0, 0, 0, 0, 40, 2);
INSERT INTO `houses` VALUES (218, 0, 0, 0, 'East Lane 2', 9060, 2, 0, 0, 0, 0, 112, 2);
INSERT INTO `houses` VALUES (219, 0, 0, 0, 'Suntower', 19360, 2, 0, 0, 0, 0, 232, 9);
INSERT INTO `houses` VALUES (220, 0, 0, 0, 'Lonely Sea Side Hostel', 23660, 2, 0, 0, 0, 0, 287, 8);
INSERT INTO `houses` VALUES (221, 0, 0, 0, 'Northport Village 1', 2850, 2, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (222, 0, 0, 0, 'Northport Village 2', 2850, 2, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (223, 0, 0, 0, 'Northport Village 3', 10770, 2, 0, 0, 0, 0, 97, 2);
INSERT INTO `houses` VALUES (224, 0, 0, 0, 'Northport Village 4', 5160, 2, 0, 0, 0, 0, 46, 2);
INSERT INTO `houses` VALUES (225, 0, 0, 0, 'Seawatch', 48220, 2, 0, 0, 0, 0, 422, 19);
INSERT INTO `houses` VALUES (226, 0, 0, 0, 'Northport Village 5', 3510, 2, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (227, 0, 0, 0, 'Northport Village 6', 4170, 2, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (228, 0, 0, 0, 'Northport Clanhall', 18720, 2, 0, 0, 0, 0, 162, 10);
INSERT INTO `houses` VALUES (229, 0, 0, 0, 'Senja Village 1a', 1530, 2, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (230, 0, 0, 0, 'Senja Village 1b', 3160, 2, 0, 0, 0, 0, 34, 2);
INSERT INTO `houses` VALUES (231, 0, 0, 0, 'Senja Village 2', 1530, 2, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (232, 0, 0, 0, 'Senja Village 3', 3430, 2, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (233, 0, 0, 0, 'Senja Village 4', 1530, 2, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (234, 0, 0, 0, 'Senja Village 5', 2350, 2, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (235, 0, 0, 0, 'Senja Village 6a', 1530, 2, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (236, 0, 0, 0, 'Senja Village 6b', 1530, 2, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (237, 0, 0, 0, 'Senja Village 7', 1630, 2, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (238, 0, 0, 0, 'Senja Village 8', 3250, 2, 0, 0, 0, 0, 35, 2);
INSERT INTO `houses` VALUES (239, 0, 0, 0, 'Senja Village 9', 5050, 2, 0, 0, 0, 0, 55, 2);
INSERT INTO `houses` VALUES (240, 0, 0, 0, 'Senja Village 10', 2970, 2, 0, 0, 0, 0, 33, 1);
INSERT INTO `houses` VALUES (241, 0, 0, 0, 'Senja Village 11', 5140, 2, 0, 0, 0, 0, 56, 2);
INSERT INTO `houses` VALUES (242, 0, 0, 0, 'Senja Clanhall', 20250, 2, 0, 0, 0, 0, 215, 10);
INSERT INTO `houses` VALUES (243, 0, 0, 0, 'Wolftower', 40900, 3, 0, 0, 0, 0, 387, 23);
INSERT INTO `houses` VALUES (244, 0, 0, 0, 'Hill Hideout', 26500, 3, 0, 0, 0, 0, 251, 15);
INSERT INTO `houses` VALUES (245, 0, 0, 0, 'Riverspring', 37100, 3, 0, 0, 0, 0, 353, 19);
INSERT INTO `houses` VALUES (246, 0, 0, 0, 'The Farms 1', 4820, 3, 0, 0, 0, 0, 42, 3);
INSERT INTO `houses` VALUES (247, 0, 0, 0, 'The Farms 2', 2960, 3, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (248, 0, 0, 0, 'The Farms 3', 2960, 3, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (249, 0, 0, 0, 'The Farms 4', 2960, 3, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (250, 0, 0, 0, 'The Farms 5', 2960, 3, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (251, 0, 0, 0, 'The Farms 6, Fishing Hut', 2410, 3, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (252, 0, 0, 0, 'Nobility Quarter 1', 3530, 3, 0, 0, 0, 0, 37, 3);
INSERT INTO `houses` VALUES (253, 0, 0, 0, 'Nobility Quarter 2', 3530, 3, 0, 0, 0, 0, 37, 3);
INSERT INTO `houses` VALUES (254, 0, 0, 0, 'Nobility Quarter 3', 3530, 3, 0, 0, 0, 0, 37, 3);
INSERT INTO `houses` VALUES (255, 0, 0, 0, 'Nobility Quarter 4', 1530, 3, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (256, 0, 0, 0, 'Nobility Quarter 5', 1530, 3, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (257, 0, 0, 0, 'Nobility Quarter 6', 1530, 3, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (258, 0, 0, 0, 'Nobility Quarter 7', 1530, 3, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (259, 0, 0, 0, 'Nobility Quarter 8', 1530, 3, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (260, 0, 0, 0, 'Nobility Quarter 9', 1530, 3, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (261, 0, 0, 0, 'Upper Barracks 1', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (262, 0, 0, 0, 'Upper Barracks 2', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (263, 0, 0, 0, 'Upper Barracks 3', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (264, 0, 0, 0, 'Upper Barracks 4', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (265, 0, 0, 0, 'Upper Barracks 5', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (266, 0, 0, 0, 'Upper Barracks 6', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (267, 0, 0, 0, 'Upper Barracks 7', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (268, 0, 0, 0, 'Upper Barracks 8', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (269, 0, 0, 0, 'Upper Barracks 9', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (270, 0, 0, 0, 'Upper Barracks 10', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (271, 0, 0, 0, 'Upper Barracks 11', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (272, 0, 0, 0, 'Upper Barracks 12', 420, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (273, 0, 0, 0, 'Upper Barracks 13', 1060, 3, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (274, 0, 0, 0, 'The Market 1 (Shop)', 1300, 3, 0, 0, 0, 0, 13, 0);
INSERT INTO `houses` VALUES (275, 0, 0, 0, 'The Market 2 (Shop)', 2200, 3, 0, 0, 0, 0, 22, 0);
INSERT INTO `houses` VALUES (276, 0, 0, 0, 'The Market 3 (Shop)', 2900, 3, 0, 0, 0, 0, 29, 0);
INSERT INTO `houses` VALUES (277, 0, 0, 0, 'The Market 4 (Shop)', 3600, 3, 0, 0, 0, 0, 36, 0);
INSERT INTO `houses` VALUES (278, 0, 0, 0, 'Lower Barracks 1', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (279, 0, 0, 0, 'Lower Barracks 2', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (280, 0, 0, 0, 'Lower Barracks 3', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (281, 0, 0, 0, 'Lower Barracks 4', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (282, 0, 0, 0, 'Lower Barracks 5', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (283, 0, 0, 0, 'Lower Barracks 6', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (284, 0, 0, 0, 'Lower Barracks 7', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (285, 0, 0, 0, 'Lower Barracks 8', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (286, 0, 0, 0, 'Lower Barracks 9', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (287, 0, 0, 0, 'Lower Barracks 10', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (288, 0, 0, 0, 'Lower Barracks 11', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (289, 0, 0, 0, 'Lower Barracks 12', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (290, 0, 0, 0, 'Lower Barracks 13', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (291, 0, 0, 0, 'Lower Barracks 14', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (292, 0, 0, 0, 'Lower Barracks 15', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (293, 0, 0, 0, 'Lower Barracks 16', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (294, 0, 0, 0, 'Lower Barracks 17', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (295, 0, 0, 0, 'Lower Barracks 18', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (296, 0, 0, 0, 'Lower Barracks 19', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (297, 0, 0, 0, 'Lower Barracks 20', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (298, 0, 0, 0, 'Lower Barracks 21', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (299, 0, 0, 0, 'Lower Barracks 22', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (300, 0, 0, 0, 'Lower Barracks 23', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (301, 0, 0, 0, 'Lower Barracks 24', 600, 3, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (302, 0, 0, 0, 'Tunnel Gardens 1', 3440, 3, 0, 0, 0, 0, 27, 3);
INSERT INTO `houses` VALUES (303, 0, 0, 0, 'Tunnel Gardens 2 ', 3440, 3, 0, 0, 0, 0, 27, 3);
INSERT INTO `houses` VALUES (304, 0, 0, 0, 'Tunnel Gardens 3', 3800, 3, 0, 0, 0, 0, 30, 3);
INSERT INTO `houses` VALUES (305, 0, 0, 0, 'Tunnel Gardens 4', 3800, 3, 0, 0, 0, 0, 30, 3);
INSERT INTO `houses` VALUES (306, 0, 0, 0, 'Tunnel Gardens 5', 2620, 3, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (307, 0, 0, 0, 'Tunnel Gardens 6', 2620, 3, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (308, 0, 0, 0, 'Tunnel Gardens 7', 2620, 3, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (309, 0, 0, 0, 'Tunnel Gardens 8', 2620, 3, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (310, 0, 0, 0, 'Tunnel Gardens 9', 1900, 3, 0, 0, 0, 0, 15, 2);
INSERT INTO `houses` VALUES (311, 0, 0, 0, 'Tunnel Gardens 10', 1900, 3, 0, 0, 0, 0, 15, 2);
INSERT INTO `houses` VALUES (312, 0, 0, 0, 'Tunnel Gardens 11', 2020, 3, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (313, 0, 0, 0, 'Tunnel Gardens 12', 2020, 3, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (314, 0, 0, 0, 'Marble Guildhall', 32020, 3, 0, 0, 0, 0, 338, 17);
INSERT INTO `houses` VALUES (315, 0, 0, 0, 'Iron Guildhall', 29420, 3, 0, 0, 0, 0, 308, 18);
INSERT INTO `houses` VALUES (316, 0, 0, 0, 'Granite Guildhall', 34090, 3, 0, 0, 0, 0, 361, 17);
INSERT INTO `houses` VALUES (317, 0, 0, 0, 'Outlaw Camp 1', 3220, 3, 0, 0, 0, 0, 39, 2);
INSERT INTO `houses` VALUES (318, 0, 0, 0, 'Outlaw Camp 2', 560, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (319, 0, 0, 0, 'Outlaw Camp 3', 1380, 3, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (320, 0, 0, 0, 'Outlaw Camp 4', 400, 3, 0, 0, 0, 0, 5, 1);
INSERT INTO `houses` VALUES (321, 0, 0, 0, 'Outlaw Camp 5', 400, 3, 0, 0, 0, 0, 5, 1);
INSERT INTO `houses` VALUES (322, 0, 0, 0, 'Outlaw Camp 6', 400, 3, 0, 0, 0, 0, 5, 1);
INSERT INTO `houses` VALUES (323, 0, 0, 0, 'Outlaw Camp 7', 1460, 3, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (324, 0, 0, 0, 'Outlaw Camp 8', 560, 3, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (325, 0, 0, 0, 'Outlaw Camp 9', 400, 3, 0, 0, 0, 0, 5, 1);
INSERT INTO `houses` VALUES (326, 0, 0, 0, 'Outlaw Camp 10', 400, 3, 0, 0, 0, 0, 5, 1);
INSERT INTO `houses` VALUES (327, 0, 0, 0, 'Outlaw Camp 11', 400, 3, 0, 0, 0, 0, 5, 1);
INSERT INTO `houses` VALUES (328, 0, 0, 0, 'Outlaw Camp 12 (Shop)', 560, 3, 0, 0, 0, 0, 7, 0);
INSERT INTO `houses` VALUES (329, 0, 0, 0, 'Outlaw Camp 13 (Shop)', 560, 3, 0, 0, 0, 0, 7, 0);
INSERT INTO `houses` VALUES (330, 0, 0, 0, 'Outlaw Camp 14 (Shop)', 1280, 3, 0, 0, 0, 0, 16, 0);
INSERT INTO `houses` VALUES (331, 0, 0, 0, 'Outlaw Castle', 15200, 3, 0, 0, 0, 0, 180, 9);
INSERT INTO `houses` VALUES (332, 0, 0, 0, 'Blessed Shield Guildhall', 15380, 7, 0, 0, 0, 0, 162, 9);
INSERT INTO `houses` VALUES (333, 0, 0, 0, 'Steel Home', 26490, 7, 0, 0, 0, 0, 281, 13);
INSERT INTO `houses` VALUES (334, 0, 0, 0, 'Swamp Watch', 21080, 7, 0, 0, 0, 0, 222, 12);
INSERT INTO `houses` VALUES (335, 0, 0, 0, 'Golden Axe Guildhall', 20070, 7, 0, 0, 0, 0, 213, 10);
INSERT INTO `houses` VALUES (336, 0, 0, 0, 'Valorous Venore', 28070, 7, 0, 0, 0, 0, 303, 9);
INSERT INTO `houses` VALUES (337, 0, 0, 0, 'Dagger Alley 1', 5230, 7, 0, 0, 0, 0, 57, 2);
INSERT INTO `houses` VALUES (338, 0, 0, 0, 'Iron Alley 1', 6600, 7, 0, 0, 0, 0, 70, 4);
INSERT INTO `houses` VALUES (339, 0, 0, 0, 'Iron Alley 2', 6600, 7, 0, 0, 0, 0, 70, 4);
INSERT INTO `houses` VALUES (340, 0, 0, 0, 'Dream Street 1 (Shop)', 8560, 7, 0, 0, 0, 0, 94, 2);
INSERT INTO `houses` VALUES (341, 0, 0, 0, 'Dream Street 2', 6580, 7, 0, 0, 0, 0, 72, 2);
INSERT INTO `houses` VALUES (342, 0, 0, 0, 'Dream Street 3', 5320, 7, 0, 0, 0, 0, 58, 2);
INSERT INTO `houses` VALUES (343, 0, 0, 0, 'Dream Street 4', 7230, 7, 0, 0, 0, 0, 77, 4);
INSERT INTO `houses` VALUES (344, 0, 0, 0, 'Elm Street 1', 5320, 7, 0, 0, 0, 0, 58, 2);
INSERT INTO `houses` VALUES (345, 0, 0, 0, 'Elm Street 2', 5230, 7, 0, 0, 0, 0, 57, 2);
INSERT INTO `houses` VALUES (346, 0, 0, 0, 'Elm Street 3', 5510, 7, 0, 0, 0, 0, 59, 3);
INSERT INTO `houses` VALUES (347, 0, 0, 0, 'Elm Street 4', 5140, 7, 0, 0, 0, 0, 56, 2);
INSERT INTO `houses` VALUES (348, 0, 0, 0, 'Seagull Walk 1', 10090, 7, 0, 0, 0, 0, 111, 2);
INSERT INTO `houses` VALUES (349, 0, 0, 0, 'Seagull Walk 2', 5330, 7, 0, 0, 0, 0, 57, 3);
INSERT INTO `houses` VALUES (350, 0, 0, 0, 'Lucky Lane 1 (Shop)', 13620, 7, 0, 0, 0, 0, 148, 4);
INSERT INTO `houses` VALUES (351, 0, 0, 0, 'Paupers Palace, Flat 01', 810, 7, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (352, 0, 0, 0, 'Paupers Palace, Flat 02', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (353, 0, 0, 0, 'Paupers Palace, Flat 03', 810, 7, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (354, 0, 0, 0, 'Paupers Palace, Flat 04', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (355, 0, 0, 0, 'Paupers Palace, Flat 05', 630, 7, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (356, 0, 0, 0, 'Paupers Palace, Flat 06', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (357, 0, 0, 0, 'Paupers Palace, Flat 07', 1270, 7, 0, 0, 0, 0, 13, 2);
INSERT INTO `houses` VALUES (358, 0, 0, 0, 'Paupers Palace, Flat 11', 630, 7, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (359, 0, 0, 0, 'Paupers Palace, Flat 12', 1270, 7, 0, 0, 0, 0, 13, 2);
INSERT INTO `houses` VALUES (360, 0, 0, 0, 'Paupers Palace, Flat 13', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (361, 0, 0, 0, 'Paupers Palace, Flat 14', 1170, 7, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (362, 0, 0, 0, 'Paupers Palace, Flat 15', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (363, 0, 0, 0, 'Paupers Palace, Flat 16', 1170, 7, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (364, 0, 0, 0, 'Paupers Palace, Flat 17', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (365, 0, 0, 0, 'Paupers Palace, Flat 18', 630, 7, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (366, 0, 0, 0, 'Paupers Palace, Flat 21', 630, 7, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (367, 0, 0, 0, 'Paupers Palace, Flat 22', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (368, 0, 0, 0, 'Paupers Palace, Flat 23', 1170, 7, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (369, 0, 0, 0, 'Paupers Palace, Flat 24', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (370, 0, 0, 0, 'Paupers Palace, Flat 25', 1170, 7, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (371, 0, 0, 0, 'Paupers Palace, Flat 26', 900, 7, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (372, 0, 0, 0, 'Paupers Palace, Flat 27', 1270, 7, 0, 0, 0, 0, 13, 2);
INSERT INTO `houses` VALUES (373, 0, 0, 0, 'Paupers Palace, Flat 28', 630, 7, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (374, 0, 0, 0, 'Paupers Palace, Flat 31', 1710, 7, 0, 0, 0, 0, 19, 1);
INSERT INTO `houses` VALUES (375, 0, 0, 0, 'Paupers Palace, Flat 32', 2170, 7, 0, 0, 0, 0, 23, 2);
INSERT INTO `houses` VALUES (376, 0, 0, 0, 'Paupers Palace, Flat 33', 1530, 7, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (377, 0, 0, 0, 'Paupers Palace, Flat 34', 3250, 7, 0, 0, 0, 0, 35, 2);
INSERT INTO `houses` VALUES (378, 0, 0, 0, 'Salvation Street 1 (Shop)', 12180, 7, 0, 0, 0, 0, 132, 4);
INSERT INTO `houses` VALUES (379, 0, 0, 0, 'Salvation Street 2', 7480, 7, 0, 0, 0, 0, 82, 2);
INSERT INTO `houses` VALUES (380, 0, 0, 0, 'Salvation Street 3', 7480, 7, 0, 0, 0, 0, 82, 2);
INSERT INTO `houses` VALUES (381, 0, 0, 0, 'Mystic Lane 1', 5690, 7, 0, 0, 0, 0, 61, 3);
INSERT INTO `houses` VALUES (382, 0, 0, 0, 'Mystic Lane 2', 5860, 7, 0, 0, 0, 0, 64, 2);
INSERT INTO `houses` VALUES (383, 0, 0, 0, 'Silver Street 1', 5130, 7, 0, 0, 0, 0, 57, 1);
INSERT INTO `houses` VALUES (384, 0, 0, 0, 'Silver Street 2', 3960, 7, 0, 0, 0, 0, 44, 1);
INSERT INTO `houses` VALUES (385, 0, 0, 0, 'Silver Street 3', 3960, 7, 0, 0, 0, 0, 44, 1);
INSERT INTO `houses` VALUES (386, 0, 0, 0, 'Silver Street 4', 6490, 7, 0, 0, 0, 0, 71, 2);
INSERT INTO `houses` VALUES (387, 0, 0, 0, 'Loot Lane 1 (Shop)', 8930, 7, 0, 0, 0, 0, 97, 3);
INSERT INTO `houses` VALUES (388, 0, 0, 0, 'Old Lighthouse', 7120, 7, 0, 0, 0, 0, 78, 2);
INSERT INTO `houses` VALUES (389, 0, 0, 0, 'Market Street 1', 13160, 7, 0, 0, 0, 0, 144, 3);
INSERT INTO `houses` VALUES (390, 0, 0, 0, 'Market Street 2', 9650, 7, 0, 0, 0, 0, 105, 3);
INSERT INTO `houses` VALUES (391, 0, 0, 0, 'Market Street 3', 6850, 7, 0, 0, 0, 0, 75, 2);
INSERT INTO `houses` VALUES (392, 0, 0, 0, 'Market Street 4 (Shop)', 10010, 7, 0, 0, 0, 0, 109, 3);
INSERT INTO `houses` VALUES (393, 0, 0, 0, 'Market Street 5 (Shop)', 12450, 7, 0, 0, 0, 0, 135, 4);
INSERT INTO `houses` VALUES (394, 0, 0, 0, 'Market Street 6', 10570, 7, 0, 0, 0, 0, 113, 5);
INSERT INTO `houses` VALUES (395, 0, 0, 0, 'Market Street 7', 4510, 7, 0, 0, 0, 0, 49, 2);
INSERT INTO `houses` VALUES (396, 0, 0, 0, 'Shadow Towers', 41900, 4, 0, 0, 0, 0, 402, 18);
INSERT INTO `houses` VALUES (397, 0, 0, 0, 'The Hideout', 39700, 4, 0, 0, 0, 0, 378, 20);
INSERT INTO `houses` VALUES (398, 0, 0, 0, 'Underwood 1', 2890, 4, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (399, 0, 0, 0, 'Underwood 2', 2890, 4, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (400, 0, 0, 0, 'Underwood 3', 3170, 4, 0, 0, 0, 0, 33, 3);
INSERT INTO `houses` VALUES (401, 0, 0, 0, 'Underwood 4', 4170, 4, 0, 0, 0, 0, 43, 4);
INSERT INTO `houses` VALUES (402, 0, 0, 0, 'Underwood 5', 2540, 4, 0, 0, 0, 0, 26, 3);
INSERT INTO `houses` VALUES (403, 0, 0, 0, 'Underwood 6', 2990, 4, 0, 0, 0, 0, 31, 3);
INSERT INTO `houses` VALUES (404, 0, 0, 0, 'Underwood 7', 2720, 4, 0, 0, 0, 0, 28, 3);
INSERT INTO `houses` VALUES (405, 0, 0, 0, 'Underwood 8', 1630, 4, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (406, 0, 0, 0, 'Underwood 9', 1170, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (407, 0, 0, 0, 'Underwood 10', 1170, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (408, 0, 0, 0, 'Ab\'Dendriel Clanhall', 28800, 4, 0, 0, 0, 0, 310, 10);
INSERT INTO `houses` VALUES (409, 0, 0, 0, 'Castle of the Winds', 46070, 4, 0, 0, 0, 0, 493, 18);
INSERT INTO `houses` VALUES (410, 0, 0, 0, 'Great Willow 1a', 1000, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (411, 0, 0, 0, 'Great Willow 1b', 1300, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (412, 0, 0, 0, 'Great Willow 1c', 1300, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (413, 0, 0, 0, 'Great Willow 2a', 1300, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (414, 0, 0, 0, 'Great Willow 2b', 900, 4, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (415, 0, 0, 0, 'Great Willow 2c', 1300, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (416, 0, 0, 0, 'Great Willow 2d', 900, 4, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (417, 0, 0, 0, 'Great Willow 3a', 1300, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (418, 0, 0, 0, 'Great Willow 3b', 900, 4, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (419, 0, 0, 0, 'Great Willow 3c', 1300, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (420, 0, 0, 0, 'Great Willow 3d', 900, 4, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (421, 0, 0, 0, 'Great Willow 4a', 1800, 4, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (422, 0, 0, 0, 'Great Willow 4b', 1800, 4, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (423, 0, 0, 0, 'Great Willow 4c', 1800, 4, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (424, 0, 0, 0, 'Great Willow 4d', 1500, 4, 0, 0, 0, 0, 15, 1);
INSERT INTO `houses` VALUES (425, 0, 0, 0, 'Mangrove 1', 3300, 4, 0, 0, 0, 0, 31, 3);
INSERT INTO `houses` VALUES (426, 0, 0, 0, 'Mangrove 2', 2600, 4, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (427, 0, 0, 0, 'Mangrove 3', 2200, 4, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (428, 0, 0, 0, 'Mangrove 4', 1800, 4, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (429, 0, 0, 0, 'Treetop 1', 1300, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (430, 0, 0, 0, 'Treetop 2', 1300, 4, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (431, 0, 0, 0, 'Treetop 3 (Shop)', 2500, 4, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (432, 0, 0, 0, 'Treetop 4 (Shop)', 2500, 4, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (433, 0, 0, 0, 'Treetop 5 (Shop)', 2700, 4, 0, 0, 0, 0, 27, 1);
INSERT INTO `houses` VALUES (434, 0, 0, 0, 'Treetop 6', 900, 4, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (435, 0, 0, 0, 'Treetop 7', 1600, 4, 0, 0, 0, 0, 16, 1);
INSERT INTO `houses` VALUES (436, 0, 0, 0, 'Treetop 8', 1600, 4, 0, 0, 0, 0, 16, 1);
INSERT INTO `houses` VALUES (437, 0, 0, 0, 'Treetop 9', 2200, 4, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (438, 0, 0, 0, 'Treetop 10', 2200, 4, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (439, 0, 0, 0, 'Treetop 11', 1700, 4, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (440, 0, 0, 0, 'Treetop 12 (Shop)', 2700, 4, 0, 0, 0, 0, 27, 1);
INSERT INTO `houses` VALUES (441, 0, 0, 0, 'Treetop 13', 2700, 4, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (442, 0, 0, 0, 'Coastwood 1', 1860, 4, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (443, 0, 0, 0, 'Coastwood 2', 1860, 4, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (444, 0, 0, 0, 'Coastwood 3', 2520, 4, 0, 0, 0, 0, 22, 2);
INSERT INTO `houses` VALUES (445, 0, 0, 0, 'Coastwood 4', 2190, 4, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (446, 0, 0, 0, 'Coastwood 5', 2960, 4, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (447, 0, 0, 0, 'Coastwood 6 (Shop)', 3190, 4, 0, 0, 0, 0, 29, 1);
INSERT INTO `houses` VALUES (448, 0, 0, 0, 'Coastwood 7', 1320, 4, 0, 0, 0, 0, 12, 1);
INSERT INTO `houses` VALUES (449, 0, 0, 0, 'Coastwood 8', 2410, 4, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (450, 0, 0, 0, 'Coastwood 9', 1870, 4, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (451, 0, 0, 0, 'Coastwood 10', 3060, 4, 0, 0, 0, 0, 26, 3);
INSERT INTO `houses` VALUES (452, 0, 0, 0, 'Shadow Caves 1', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (453, 0, 0, 0, 'Shadow Caves 2', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (454, 0, 0, 0, 'Shadow Caves 3', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (455, 0, 0, 0, 'Shadow Caves 4', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (456, 0, 0, 0, 'Shadow Caves 11', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (457, 0, 0, 0, 'Shadow Caves 12', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (458, 0, 0, 0, 'Shadow Caves 13', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (459, 0, 0, 0, 'Shadow Caves 14', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (460, 0, 0, 0, 'Shadow Caves 15', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (461, 0, 0, 0, 'Shadow Caves 16', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (462, 0, 0, 0, 'Shadow Caves 17', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (463, 0, 0, 0, 'Shadow Caves 18', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (464, 0, 0, 0, 'Shadow Caves 21', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (465, 0, 0, 0, 'Shadow Caves 22', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (466, 0, 0, 0, 'Shadow Caves 23', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (467, 0, 0, 0, 'Shadow Caves 24', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (468, 0, 0, 0, 'Shadow Caves 25', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (469, 0, 0, 0, 'Shadow Caves 26', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (470, 0, 0, 0, 'Shadow Caves 27', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (471, 0, 0, 0, 'Shadow Caves 28', 600, 4, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (472, 0, 0, 0, 'Haggler\'s Hangout 1', 2700, 9, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (473, 0, 0, 0, 'Haggler\'s Hangout 2', 2600, 9, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (474, 0, 0, 0, 'Haggler\'s Hangout 3', 14800, 9, 0, 0, 0, 0, 145, 4);
INSERT INTO `houses` VALUES (475, 0, 0, 0, 'Haggler\'s Hangout 4a', 3700, 9, 0, 0, 0, 0, 37, 1);
INSERT INTO `houses` VALUES (476, 0, 0, 0, 'Haggler\'s Hangout 4b', 3100, 9, 0, 0, 0, 0, 31, 1);
INSERT INTO `houses` VALUES (477, 0, 0, 0, 'Haggler\'s Hangout 5', 3100, 9, 0, 0, 0, 0, 31, 1);
INSERT INTO `houses` VALUES (478, 0, 0, 0, 'Haggler\'s Hangout 6', 12600, 9, 0, 0, 0, 0, 123, 4);
INSERT INTO `houses` VALUES (479, 0, 0, 0, 'Banana Bay 1', 900, 9, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (480, 0, 0, 0, 'Banana Bay 2', 1530, 9, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (481, 0, 0, 0, 'Banana Bay 3', 900, 9, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (482, 0, 0, 0, 'Banana Bay 4', 900, 9, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (483, 0, 0, 0, 'Crocodile Bridge 1', 1990, 9, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (484, 0, 0, 0, 'Crocodile Bridge 2', 1630, 9, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (485, 0, 0, 0, 'Crocodile Bridge 3', 2440, 9, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (486, 0, 0, 0, 'Crocodile Bridge 4', 9210, 9, 0, 0, 0, 0, 99, 4);
INSERT INTO `houses` VALUES (487, 0, 0, 0, 'Crocodile Bridge 5', 7840, 9, 0, 0, 0, 0, 86, 2);
INSERT INTO `houses` VALUES (488, 0, 0, 0, 'Woodway 1', 1530, 9, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (489, 0, 0, 0, 'Woodway 2', 1170, 9, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (490, 0, 0, 0, 'Woodway 3', 2980, 9, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (491, 0, 0, 0, 'Woodway 4', 810, 9, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (492, 0, 0, 0, 'Flamingo Flats 1', 1270, 9, 0, 0, 0, 0, 13, 2);
INSERT INTO `houses` VALUES (493, 0, 0, 0, 'Flamingo Flats 2', 1990, 9, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (494, 0, 0, 0, 'Flamingo Flats 3', 1270, 9, 0, 0, 0, 0, 13, 2);
INSERT INTO `houses` VALUES (495, 0, 0, 0, 'Flamingo Flats 4', 1630, 9, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (496, 0, 0, 0, 'Flamingo Flats 5', 3690, 9, 0, 0, 0, 0, 41, 1);
INSERT INTO `houses` VALUES (497, 0, 0, 0, 'Bamboo Garden 1', 3080, 9, 0, 0, 0, 0, 32, 3);
INSERT INTO `houses` VALUES (498, 0, 0, 0, 'Bamboo Garden 2', 1990, 9, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (499, 0, 0, 0, 'Bamboo Garden 3', 2980, 9, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (500, 0, 0, 0, 'Coconut Quay 1', 3430, 9, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (501, 0, 0, 0, 'Coconut Quay 2', 1990, 9, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (502, 0, 0, 0, 'Coconut Quay 3', 3990, 9, 0, 0, 0, 0, 41, 4);
INSERT INTO `houses` VALUES (503, 0, 0, 0, 'Coconut Quay 4', 4070, 9, 0, 0, 0, 0, 43, 3);
INSERT INTO `houses` VALUES (504, 0, 0, 0, 'River Homes 1', 6770, 9, 0, 0, 0, 0, 73, 3);
INSERT INTO `houses` VALUES (505, 0, 0, 0, 'River Homes 2a', 2440, 9, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (506, 0, 0, 0, 'River Homes 2b', 2990, 9, 0, 0, 0, 0, 31, 3);
INSERT INTO `houses` VALUES (507, 0, 0, 0, 'River Homes 3', 9510, 9, 0, 0, 0, 0, 99, 7);
INSERT INTO `houses` VALUES (508, 0, 0, 0, 'Jungle Edge 1', 4790, 9, 0, 0, 0, 0, 51, 3);
INSERT INTO `houses` VALUES (509, 0, 0, 0, 'Jungle Edge 2', 6140, 9, 0, 0, 0, 0, 66, 3);
INSERT INTO `houses` VALUES (510, 0, 0, 0, 'Jungle Edge 3', 1630, 9, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (511, 0, 0, 0, 'Jungle Edge 4', 1630, 9, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (512, 0, 0, 0, 'Jungle Edge 5', 1630, 9, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (513, 0, 0, 0, 'Jungle Edge 6', 900, 9, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (514, 0, 0, 0, 'Shark Manor', 16160, 9, 0, 0, 0, 0, 164, 15);
INSERT INTO `houses` VALUES (515, 0, 0, 0, 'Bamboo Fortress', 42040, 9, 0, 0, 0, 0, 446, 20);
INSERT INTO `houses` VALUES (516, 0, 0, 0, 'The Treehouse', 46040, 9, 0, 0, 0, 0, 548, 23);
INSERT INTO `houses` VALUES (517, 0, 0, 0, 'Castle Shop 1', 3780, 5, 0, 0, 0, 0, 42, 1);
INSERT INTO `houses` VALUES (518, 0, 0, 0, 'Castle Shop 2', 3780, 5, 0, 0, 0, 0, 42, 1);
INSERT INTO `houses` VALUES (519, 0, 0, 0, 'Castle Shop 3', 3780, 5, 0, 0, 0, 0, 42, 1);
INSERT INTO `houses` VALUES (520, 0, 0, 0, 'Castle, 3rd Floor, Flat 01', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (521, 0, 0, 0, 'Castle, 3rd Floor, Flat 02', 1530, 5, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (522, 0, 0, 0, 'Castle, 3rd Floor, Flat 03', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (523, 0, 0, 0, 'Castle, 3rd Floor, Flat 04', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (524, 0, 0, 0, 'Castle, 3rd Floor, Flat 05', 1530, 5, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (525, 0, 0, 0, 'Castle, 3rd Floor, Flat 06', 1990, 5, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (526, 0, 0, 0, 'Castle, 3rd Floor, Flat 07', 1440, 5, 0, 0, 0, 0, 16, 1);
INSERT INTO `houses` VALUES (527, 0, 0, 0, 'Castle, 4th Floor, Flat 01', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (528, 0, 0, 0, 'Castle, 4th Floor, Flat 02', 1530, 5, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (529, 0, 0, 0, 'Castle, 4th Floor, Flat 03', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (530, 0, 0, 0, 'Castle, 4th Floor, Flat 04', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (531, 0, 0, 0, 'Castle, 4th Floor, Flat 05', 1530, 5, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (532, 0, 0, 0, 'Castle, 4th Floor, Flat 06', 1890, 5, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (533, 0, 0, 0, 'Castle, 4th Floor, Flat 07', 1440, 5, 0, 0, 0, 0, 16, 1);
INSERT INTO `houses` VALUES (534, 0, 0, 0, 'Castle, 4th Floor, Flat 08', 1890, 5, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (535, 0, 0, 0, 'Castle, 4th Floor, Flat 09', 1440, 5, 0, 0, 0, 0, 16, 1);
INSERT INTO `houses` VALUES (536, 0, 0, 0, 'Castle, Basement, Flat 01', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (537, 0, 0, 0, 'Castle, Basement, Flat 02', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (538, 0, 0, 0, 'Castle, Basement, Flat 03', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (539, 0, 0, 0, 'Castle, Basement, Flat 04', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (540, 0, 0, 0, 'Castle, Basement, Flat 05', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (541, 0, 0, 0, 'Castle, Basement, Flat 06', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (542, 0, 0, 0, 'Castle, Basement, Flat 07', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (543, 0, 0, 0, 'Castle, Basement, Flat 08', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (544, 0, 0, 0, 'Castle, Basement, Flat 09', 1170, 5, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (545, 0, 0, 0, 'Castle Street 1', 5600, 5, 0, 0, 0, 0, 60, 3);
INSERT INTO `houses` VALUES (546, 0, 0, 0, 'Castle Street 2', 2890, 5, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (547, 0, 0, 0, 'Castle Street 3', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (548, 0, 0, 0, 'Castle Street 4', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (549, 0, 0, 0, 'Castle Street 5', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (550, 0, 0, 0, 'Edron Flats, Flat 01', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (551, 0, 0, 0, 'Edron Flats, Flat 02', 1620, 5, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (552, 0, 0, 0, 'Edron Flats, Flat 03', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (553, 0, 0, 0, 'Edron Flats, Flat 04', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (554, 0, 0, 0, 'Edron Flats, Flat 05', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (555, 0, 0, 0, 'Edron Flats, Flat 06', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (556, 0, 0, 0, 'Edron Flats, Flat 07', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (557, 0, 0, 0, 'Edron Flats, Flat 08', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (558, 0, 0, 0, 'Edron Flats, Flat 11', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (559, 0, 0, 0, 'Edron Flats, Flat 12', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (560, 0, 0, 0, 'Edron Flats, Flat 13', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (561, 0, 0, 0, 'Edron Flats, Flat 14', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (562, 0, 0, 0, 'Edron Flats, Flat 15', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (563, 0, 0, 0, 'Edron Flats, Flat 16', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (564, 0, 0, 0, 'Edron Flats, Flat 17', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (565, 0, 0, 0, 'Edron Flats, Flat 18', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (566, 0, 0, 0, 'Edron Flats, Flat 21', 1620, 5, 0, 0, 0, 0, 19, 2);
INSERT INTO `houses` VALUES (567, 0, 0, 0, 'Edron Flats, Flat 22', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (568, 0, 0, 0, 'Edron Flats, Flat 23', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (569, 0, 0, 0, 'Edron Flats, Flat 24', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (570, 0, 0, 0, 'Edron Flats, Flat 25', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (571, 0, 0, 0, 'Edron Flats, Flat 26', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (572, 0, 0, 0, 'Edron Flats, Flat 27', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (573, 0, 0, 0, 'Edron Flats, Flat 28', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (574, 0, 0, 0, 'Edron Flats, Basement Flat 1', 2980, 5, 0, 0, 0, 0, 36, 2);
INSERT INTO `houses` VALUES (575, 0, 0, 0, 'Edron Flats, Basement Flat 2', 2980, 5, 0, 0, 0, 0, 36, 2);
INSERT INTO `houses` VALUES (576, 0, 0, 0, 'Central Circle 1', 5940, 5, 0, 0, 0, 0, 73, 2);
INSERT INTO `houses` VALUES (577, 0, 0, 0, 'Central Circle 2', 6500, 5, 0, 0, 0, 0, 80, 2);
INSERT INTO `houses` VALUES (578, 0, 0, 0, 'Central Circle 3', 7920, 5, 0, 0, 0, 0, 94, 5);
INSERT INTO `houses` VALUES (579, 0, 0, 0, 'Central Circle 4', 7920, 5, 0, 0, 0, 0, 94, 5);
INSERT INTO `houses` VALUES (580, 0, 0, 0, 'Central Circle 5', 7920, 5, 0, 0, 0, 0, 94, 5);
INSERT INTO `houses` VALUES (581, 0, 0, 0, 'Central Circle 6 (Shop)', 7860, 5, 0, 0, 0, 0, 97, 2);
INSERT INTO `houses` VALUES (582, 0, 0, 0, 'Central Circle 7 (Shop)', 7860, 5, 0, 0, 0, 0, 97, 2);
INSERT INTO `houses` VALUES (583, 0, 0, 0, 'Central Circle 8 (Shop)', 7860, 5, 0, 0, 0, 0, 97, 2);
INSERT INTO `houses` VALUES (584, 0, 0, 0, 'Central Circle 9a', 1780, 5, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (585, 0, 0, 0, 'Central Circle 9b', 1780, 5, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (586, 0, 0, 0, 'Wood Avenue 1', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (587, 0, 0, 0, 'Wood Avenue 2', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (588, 0, 0, 0, 'Wood Avenue 3', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (589, 0, 0, 0, 'Wood Avenue 4', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (590, 0, 0, 0, 'Wood Avenue 5', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (591, 0, 0, 0, 'Wood Avenue 6a', 2800, 5, 0, 0, 0, 0, 30, 2);
INSERT INTO `houses` VALUES (592, 0, 0, 0, 'Wood Avenue 6b', 2800, 5, 0, 0, 0, 0, 30, 2);
INSERT INTO `houses` VALUES (593, 0, 0, 0, 'Wood Avenue 7', 11720, 5, 0, 0, 0, 0, 128, 3);
INSERT INTO `houses` VALUES (594, 0, 0, 0, 'Wood Avenue 8', 11720, 5, 0, 0, 0, 0, 128, 3);
INSERT INTO `houses` VALUES (595, 0, 0, 0, 'Wood Avenue 9a', 2980, 5, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (596, 0, 0, 0, 'Wood Avenue 9b', 2890, 5, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (597, 0, 0, 0, 'Wood Avenue 10a', 2980, 5, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (598, 0, 0, 0, 'Wood Avenue 10b', 2990, 5, 0, 0, 0, 0, 31, 3);
INSERT INTO `houses` VALUES (599, 0, 0, 0, 'Wood Avenue 11', 13910, 5, 0, 0, 0, 0, 149, 6);
INSERT INTO `houses` VALUES (600, 0, 0, 0, 'Wood Avenue 4a', 2890, 5, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (601, 0, 0, 0, 'Wood Avenue 4b', 2890, 5, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (602, 0, 0, 0, 'Wood Avenue 4c', 3430, 5, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (603, 0, 0, 0, 'Sky Lane, Guild 1', 40090, 5, 0, 0, 0, 0, 421, 23);
INSERT INTO `houses` VALUES (604, 0, 0, 0, 'Sky Lane, Guild 2', 37300, 5, 0, 0, 0, 0, 400, 14);
INSERT INTO `houses` VALUES (605, 0, 0, 0, 'Sky Lane, Guild 3', 32930, 5, 0, 0, 0, 0, 347, 18);
INSERT INTO `houses` VALUES (606, 0, 0, 0, 'Sky Lane, Sea Tower', 9050, 5, 0, 0, 0, 0, 95, 6);
INSERT INTO `houses` VALUES (607, 0, 0, 0, 'Magic Academy, Guild', 22750, 5, 0, 0, 0, 0, 195, 14);
INSERT INTO `houses` VALUES (608, 0, 0, 0, 'Magic Academy, Shop', 3190, 5, 0, 0, 0, 0, 29, 1);
INSERT INTO `houses` VALUES (609, 0, 0, 0, 'Magic Academy, Flat 1', 2730, 5, 0, 0, 0, 0, 23, 3);
INSERT INTO `houses` VALUES (610, 0, 0, 0, 'Magic Academy, Flat 2', 2960, 5, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (611, 0, 0, 0, 'Magic Academy, Flat 3', 2860, 5, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (612, 0, 0, 0, 'Magic Academy, Flat 4', 2960, 5, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (613, 0, 0, 0, 'Magic Academy, Flat 5', 2860, 5, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (614, 0, 0, 0, 'Stonehome Village 1', 3460, 5, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (615, 0, 0, 0, 'Stonehome Village 2', 1280, 5, 0, 0, 0, 0, 16, 1);
INSERT INTO `houses` VALUES (616, 0, 0, 0, 'Stonehome Village 3', 1360, 5, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (617, 0, 0, 0, 'Stonehome Village 4', 1780, 5, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (618, 0, 0, 0, 'Stonehome Village 5', 2180, 5, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (619, 0, 0, 0, 'Stonehome Village 6', 2500, 5, 0, 0, 0, 0, 30, 2);
INSERT INTO `houses` VALUES (620, 0, 0, 0, 'Stonehome Village 7', 2180, 5, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (621, 0, 0, 0, 'Stonehome Village 8', 1360, 5, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (622, 0, 0, 0, 'Stonehome Village 9', 1360, 5, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (623, 0, 0, 0, 'Stonehome Flats, Flat 01', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (624, 0, 0, 0, 'Stonehome Flats, Flat 02', 1380, 5, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (625, 0, 0, 0, 'Stonehome Flats, Flat 03', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (626, 0, 0, 0, 'Stonehome Flats, Flat 04', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (627, 0, 0, 0, 'Stonehome Flats, Flat 05', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (628, 0, 0, 0, 'Stonehome Flats, Flat 06', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (629, 0, 0, 0, 'Stonehome Flats, Flat 11', 1380, 5, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (630, 0, 0, 0, 'Stonehome Flats, Flat 12', 1380, 5, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (631, 0, 0, 0, 'Stonehome Flats, Flat 13', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (632, 0, 0, 0, 'Stonehome Flats, Flat 14', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (633, 0, 0, 0, 'Stonehome Flats, Flat 15', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (634, 0, 0, 0, 'Stonehome Flats, Flat 16', 800, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (635, 0, 0, 0, 'Stonehome Clanhall', 16260, 5, 0, 0, 0, 0, 192, 10);
INSERT INTO `houses` VALUES (636, 0, 0, 0, 'Cormaya Flats, Flat 01', 900, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (637, 0, 0, 0, 'Cormaya Flats, Flat 02', 900, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (638, 0, 0, 0, 'Cormaya Flats, Flat 03', 1540, 5, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (639, 0, 0, 0, 'Cormaya Flats, Flat 04', 1540, 5, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (640, 0, 0, 0, 'Cormaya Flats, Flat 05', 900, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (641, 0, 0, 0, 'Cormaya Flats, Flat 06', 900, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (642, 0, 0, 0, 'Cormaya Flats, Flat 11', 900, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (643, 0, 0, 0, 'Cormaya Flats, Flat 12', 900, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (644, 0, 0, 0, 'Cormaya Flats, Flat 13', 1540, 5, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (645, 0, 0, 0, 'Cormaya Flats, Flat 14', 1540, 5, 0, 0, 0, 0, 16, 2);
INSERT INTO `houses` VALUES (646, 0, 0, 0, 'Cormaya Flats, Flat 15', 900, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (647, 0, 0, 0, 'Cormaya Flats, Flat 16', 900, 5, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (648, 0, 0, 0, 'Cormaya 1', 2440, 5, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (649, 0, 0, 0, 'Cormaya 2', 7220, 5, 0, 0, 0, 0, 78, 3);
INSERT INTO `houses` VALUES (650, 0, 0, 0, 'Cormaya 3', 3970, 5, 0, 0, 0, 0, 43, 2);
INSERT INTO `houses` VALUES (651, 0, 0, 0, 'Cormaya 4', 3340, 5, 0, 0, 0, 0, 36, 2);
INSERT INTO `houses` VALUES (652, 0, 0, 0, 'Cormaya 5', 11000, 5, 0, 0, 0, 0, 120, 3);
INSERT INTO `houses` VALUES (653, 0, 0, 0, 'Cormaya 6', 4690, 5, 0, 0, 0, 0, 51, 2);
INSERT INTO `houses` VALUES (654, 0, 0, 0, 'Cormaya 7', 4690, 5, 0, 0, 0, 0, 51, 2);
INSERT INTO `houses` VALUES (655, 0, 0, 0, 'Cormaya 8', 5320, 5, 0, 0, 0, 0, 58, 2);
INSERT INTO `houses` VALUES (656, 0, 0, 0, 'Cormaya 9a', 2350, 5, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (657, 0, 0, 0, 'Cormaya 9b', 5140, 5, 0, 0, 0, 0, 56, 2);
INSERT INTO `houses` VALUES (658, 0, 0, 0, 'Cormaya 9c', 2350, 5, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (659, 0, 0, 0, 'Cormaya 9d', 5140, 5, 0, 0, 0, 0, 56, 2);
INSERT INTO `houses` VALUES (660, 0, 0, 0, 'Cormaya 10', 7400, 5, 0, 0, 0, 0, 80, 3);
INSERT INTO `houses` VALUES (661, 0, 0, 0, 'Cormaya 11', 3970, 5, 0, 0, 0, 0, 43, 2);
INSERT INTO `houses` VALUES (662, 0, 0, 0, 'Castle of the White Dragon', 48150, 5, 0, 0, 0, 0, 515, 19);
INSERT INTO `houses` VALUES (663, 0, 0, 0, 'Chameken I', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (664, 0, 0, 0, 'Chameken II', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (665, 0, 0, 0, 'Thanah I a', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (666, 0, 0, 0, 'Thanah I b', 5800, 8, 0, 0, 0, 0, 56, 3);
INSERT INTO `houses` VALUES (667, 0, 0, 0, 'Thanah I c', 6300, 8, 0, 0, 0, 0, 61, 3);
INSERT INTO `houses` VALUES (668, 0, 0, 0, 'Thanah I d', 5500, 8, 0, 0, 0, 0, 52, 4);
INSERT INTO `houses` VALUES (669, 0, 0, 0, 'Thanah II a', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (670, 0, 0, 0, 'Thanah II b', 900, 8, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (671, 0, 0, 0, 'Thanah II c', 900, 8, 0, 0, 0, 0, 9, 1);
INSERT INTO `houses` VALUES (672, 0, 0, 0, 'Thanah II d', 700, 8, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (673, 0, 0, 0, 'Thanah II e', 700, 8, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (674, 0, 0, 0, 'Thanah II f', 5500, 8, 0, 0, 0, 0, 53, 3);
INSERT INTO `houses` VALUES (675, 0, 0, 0, 'Thanah II g', 3200, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (676, 0, 0, 0, 'Thanah II h', 2700, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (677, 0, 0, 0, 'Thrarhor I a (Shop)', 2100, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (678, 0, 0, 0, 'Thrarhor I b (Shop)', 2100, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (679, 0, 0, 0, 'Thrarhor I c (Shop)', 2100, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (680, 0, 0, 0, 'Thrarhor I d (Shop)', 2100, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (681, 0, 0, 0, 'Botham I a', 1900, 8, 0, 0, 0, 0, 19, 1);
INSERT INTO `houses` VALUES (682, 0, 0, 0, 'Botham I b', 5800, 8, 0, 0, 0, 0, 56, 3);
INSERT INTO `houses` VALUES (683, 0, 0, 0, 'Botham I c', 3300, 8, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (684, 0, 0, 0, 'Botham I d', 5900, 8, 0, 0, 0, 0, 57, 3);
INSERT INTO `houses` VALUES (685, 0, 0, 0, 'Botham I e', 3200, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (686, 0, 0, 0, 'Botham II a', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (687, 0, 0, 0, 'Botham II b', 3100, 8, 0, 0, 0, 0, 30, 2);
INSERT INTO `houses` VALUES (688, 0, 0, 0, 'Botham II c', 2400, 8, 0, 0, 0, 0, 23, 2);
INSERT INTO `houses` VALUES (689, 0, 0, 0, 'Botham II d', 3800, 8, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (690, 0, 0, 0, 'Botham II e', 3200, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (691, 0, 0, 0, 'Botham II f', 3200, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (692, 0, 0, 0, 'Botham II g', 2700, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (693, 0, 0, 0, 'Botham III a', 2700, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (694, 0, 0, 0, 'Botham III b', 1800, 8, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (695, 0, 0, 0, 'Botham III c', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (696, 0, 0, 0, 'Botham III d', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (697, 0, 0, 0, 'Botham III e', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (698, 0, 0, 0, 'Botham III f', 4500, 8, 0, 0, 0, 0, 43, 3);
INSERT INTO `houses` VALUES (699, 0, 0, 0, 'Botham III g', 3200, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (700, 0, 0, 0, 'Botham III h', 7300, 8, 0, 0, 0, 0, 71, 3);
INSERT INTO `houses` VALUES (701, 0, 0, 0, 'Botham IV a', 2700, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (702, 0, 0, 0, 'Botham IV b', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (703, 0, 0, 0, 'Botham IV c', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (704, 0, 0, 0, 'Botham IV d', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (705, 0, 0, 0, 'Botham IV e', 1700, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (706, 0, 0, 0, 'Botham IV f', 3300, 8, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (707, 0, 0, 0, 'Botham IV g', 3200, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (708, 0, 0, 0, 'Botham IV h', 3700, 8, 0, 0, 0, 0, 37, 1);
INSERT INTO `houses` VALUES (709, 0, 0, 0, 'Botham IV i', 3400, 8, 0, 0, 0, 0, 32, 3);
INSERT INTO `houses` VALUES (710, 0, 0, 0, 'Ramen Tah', 13800, 8, 0, 0, 0, 0, 123, 16);
INSERT INTO `houses` VALUES (711, 0, 0, 0, 'Charsirakh I a', 560, 8, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (712, 0, 0, 0, 'Charsirakh I b', 3060, 8, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (713, 0, 0, 0, 'Charsirakh II', 2180, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (714, 0, 0, 0, 'Charsirakh III', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (715, 0, 0, 0, 'Othehothep I a', 560, 8, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (716, 0, 0, 0, 'Othehothep I b', 2660, 8, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (717, 0, 0, 0, 'Othehothep I c', 3240, 8, 0, 0, 0, 0, 38, 3);
INSERT INTO `houses` VALUES (718, 0, 0, 0, 'Othehothep I d', 3740, 8, 0, 0, 0, 0, 43, 4);
INSERT INTO `houses` VALUES (719, 0, 0, 0, 'Othehothep II a', 800, 8, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (720, 0, 0, 0, 'Othehothep II b', 3640, 8, 0, 0, 0, 0, 43, 3);
INSERT INTO `houses` VALUES (721, 0, 0, 0, 'Othehothep II c', 1680, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (722, 0, 0, 0, 'Othehothep II d', 1680, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (723, 0, 0, 0, 'Othehothep II e', 2580, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (724, 0, 0, 0, 'Othehothep II f', 2580, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (725, 0, 0, 0, 'Othehothep III a', 560, 8, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (726, 0, 0, 0, 'Othehothep III b', 2580, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (727, 0, 0, 0, 'Othehothep III c', 1780, 8, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (728, 0, 0, 0, 'Othehothep III d', 2080, 8, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (729, 0, 0, 0, 'Othehothep III e', 1680, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (730, 0, 0, 0, 'Othehothep III f', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (731, 0, 0, 0, 'Harrah I', 10580, 8, 0, 0, 0, 0, 121, 10);
INSERT INTO `houses` VALUES (732, 0, 0, 0, 'Murkhol I a', 880, 8, 0, 0, 0, 0, 11, 1);
INSERT INTO `houses` VALUES (733, 0, 0, 0, 'Murkhol I b', 880, 8, 0, 0, 0, 0, 11, 1);
INSERT INTO `houses` VALUES (734, 0, 0, 0, 'Murkhol I c', 880, 8, 0, 0, 0, 0, 11, 1);
INSERT INTO `houses` VALUES (735, 0, 0, 0, 'Murkhol I d', 880, 8, 0, 0, 0, 0, 11, 1);
INSERT INTO `houses` VALUES (736, 0, 0, 0, 'Oskahl I a', 3060, 8, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (737, 0, 0, 0, 'Oskahl I b', 1680, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (738, 0, 0, 0, 'Oskahl I c', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (739, 0, 0, 0, 'Oskahl I d', 2180, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (740, 0, 0, 0, 'Oskahl I e', 1680, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (741, 0, 0, 0, 'Oskahl I f', 1680, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (742, 0, 0, 0, 'Oskahl I g', 2180, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (743, 0, 0, 0, 'Oskahl I h', 3320, 8, 0, 0, 0, 0, 39, 3);
INSERT INTO `houses` VALUES (744, 0, 0, 0, 'Oskahl I i', 1680, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (745, 0, 0, 0, 'Oskahl I j', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (746, 0, 0, 0, 'Mothrem I', 2180, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (747, 0, 0, 0, 'Arakmehn I', 2440, 8, 0, 0, 0, 0, 28, 3);
INSERT INTO `houses` VALUES (748, 0, 0, 0, 'Arakmehn II', 2080, 8, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (749, 0, 0, 0, 'Arakmehn III', 2180, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (750, 0, 0, 0, 'Arakmehn IV', 2340, 8, 0, 0, 0, 0, 28, 2);
INSERT INTO `houses` VALUES (751, 0, 0, 0, 'Unklath I a', 2180, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (752, 0, 0, 0, 'Unklath I b', 2820, 8, 0, 0, 0, 0, 34, 2);
INSERT INTO `houses` VALUES (753, 0, 0, 0, 'Unklath I c', 2820, 8, 0, 0, 0, 0, 34, 2);
INSERT INTO `houses` VALUES (754, 0, 0, 0, 'Unklath I d', 3160, 8, 0, 0, 0, 0, 37, 3);
INSERT INTO `houses` VALUES (755, 0, 0, 0, 'Unklath I e', 3060, 8, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (756, 0, 0, 0, 'Unklath I f', 3060, 8, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (757, 0, 0, 0, 'Unklath I g', 2960, 8, 0, 0, 0, 0, 37, 1);
INSERT INTO `houses` VALUES (758, 0, 0, 0, 'Unklath II a', 2080, 8, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (759, 0, 0, 0, 'Unklath II b', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (760, 0, 0, 0, 'Unklath II c', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (761, 0, 0, 0, 'Unklath II d', 3060, 8, 0, 0, 0, 0, 37, 2);
INSERT INTO `houses` VALUES (762, 0, 0, 0, 'Rathal I a', 2180, 8, 0, 0, 0, 0, 26, 2);
INSERT INTO `houses` VALUES (763, 0, 0, 0, 'Rathal I b', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (764, 0, 0, 0, 'Rathal I c', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (765, 0, 0, 0, 'Rathal I d', 1460, 8, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (766, 0, 0, 0, 'Rathal I e', 1460, 8, 0, 0, 0, 0, 17, 2);
INSERT INTO `houses` VALUES (767, 0, 0, 0, 'Rathal II a', 2080, 8, 0, 0, 0, 0, 26, 1);
INSERT INTO `houses` VALUES (768, 0, 0, 0, 'Rathal II b', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (769, 0, 0, 0, 'Rathal II c', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (770, 0, 0, 0, 'Rathal II d', 2820, 8, 0, 0, 0, 0, 34, 2);
INSERT INTO `houses` VALUES (771, 0, 0, 0, 'Uthemath I a', 800, 8, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (772, 0, 0, 0, 'Uthemath I b', 1600, 8, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` VALUES (773, 0, 0, 0, 'Uthemath I c', 1700, 8, 0, 0, 0, 0, 20, 2);
INSERT INTO `houses` VALUES (774, 0, 0, 0, 'Uthemath I d', 1680, 8, 0, 0, 0, 0, 21, 1);
INSERT INTO `houses` VALUES (775, 0, 0, 0, 'Uthemath I e', 1780, 8, 0, 0, 0, 0, 21, 2);
INSERT INTO `houses` VALUES (776, 0, 0, 0, 'Uthemath I f', 4680, 8, 0, 0, 0, 0, 56, 3);
INSERT INTO `houses` VALUES (777, 0, 0, 0, 'Uthemath II', 8220, 8, 0, 0, 0, 0, 94, 8);
INSERT INTO `houses` VALUES (778, 0, 0, 0, 'Esuph I', 1360, 8, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (779, 0, 0, 0, 'Esuph II a', 560, 8, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (780, 0, 0, 0, 'Esuph II b', 2660, 8, 0, 0, 0, 0, 32, 2);
INSERT INTO `houses` VALUES (781, 0, 0, 0, 'Esuph III a', 560, 8, 0, 0, 0, 0, 7, 1);
INSERT INTO `houses` VALUES (782, 0, 0, 0, 'Esuph III b', 2580, 8, 0, 0, 0, 0, 31, 2);
INSERT INTO `houses` VALUES (783, 0, 0, 0, 'Esuph IV a', 800, 8, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (784, 0, 0, 0, 'Esuph IV b', 800, 8, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (785, 0, 0, 0, 'Esuph IV c', 800, 8, 0, 0, 0, 0, 10, 1);
INSERT INTO `houses` VALUES (786, 0, 0, 0, 'Esuph IV d', 1600, 8, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` VALUES (787, 0, 0, 0, 'Horakhal', 17540, 8, 0, 0, 0, 0, 203, 14);
INSERT INTO `houses` VALUES (788, 0, 0, 0, 'Darashia 1, Flat 01', 2100, 6, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (789, 0, 0, 0, 'Darashia 1, Flat 02', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (790, 0, 0, 0, 'Darashia 1, Flat 03', 5020, 6, 0, 0, 0, 0, 59, 4);
INSERT INTO `houses` VALUES (791, 0, 0, 0, 'Darashia 1, Flat 04', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (792, 0, 0, 0, 'Darashia 1, Flat 05', 2100, 6, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (793, 0, 0, 0, 'Darashia 1, Flat 11', 2100, 6, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (794, 0, 0, 0, 'Darashia 1, Flat 12', 3460, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (795, 0, 0, 0, 'Darashia 1, Flat 13', 3460, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (796, 0, 0, 0, 'Darashia 1, Flat 14', 5120, 6, 0, 0, 0, 0, 59, 5);
INSERT INTO `houses` VALUES (797, 0, 0, 0, 'Darashia 2, Flat 01', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (798, 0, 0, 0, 'Darashia 2, Flat 02', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (799, 0, 0, 0, 'Darashia 2, Flat 03', 2320, 6, 0, 0, 0, 0, 29, 1);
INSERT INTO `houses` VALUES (800, 0, 0, 0, 'Darashia 2, Flat 04', 1040, 6, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (801, 0, 0, 0, 'Darashia 2, Flat 05', 2420, 6, 0, 0, 0, 0, 29, 2);
INSERT INTO `houses` VALUES (802, 0, 0, 0, 'Darashia 2, Flat 06', 1040, 6, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (803, 0, 0, 0, 'Darashia 2, Flat 07', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (804, 0, 0, 0, 'Darashia 2, Flat 11', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (805, 0, 0, 0, 'Darashia 2, Flat 12', 1040, 6, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (806, 0, 0, 0, 'Darashia 2, Flat 13', 2320, 6, 0, 0, 0, 0, 29, 1);
INSERT INTO `houses` VALUES (807, 0, 0, 0, 'Darashia 2, Flat 14', 1040, 6, 0, 0, 0, 0, 13, 1);
INSERT INTO `houses` VALUES (808, 0, 0, 0, 'Darashia 2, Flat 15', 2420, 6, 0, 0, 0, 0, 29, 2);
INSERT INTO `houses` VALUES (809, 0, 0, 0, 'Darashia 2, Flat 16', 1360, 6, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (810, 0, 0, 0, 'Darashia 2, Flat 17', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (811, 0, 0, 0, 'Darashia 2, Flat 18', 1360, 6, 0, 0, 0, 0, 17, 1);
INSERT INTO `houses` VALUES (812, 0, 0, 0, 'Darashia 3, Flat 01', 2100, 6, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (813, 0, 0, 0, 'Darashia 3, Flat 02', 3140, 6, 0, 0, 0, 0, 38, 2);
INSERT INTO `houses` VALUES (814, 0, 0, 0, 'Darashia 3, Flat 03', 2100, 6, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (815, 0, 0, 0, 'Darashia 3, Flat 04', 3140, 6, 0, 0, 0, 0, 38, 2);
INSERT INTO `houses` VALUES (816, 0, 0, 0, 'Darashia 3, Flat 05', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (817, 0, 0, 0, 'Darashia 3, Flat 11', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (818, 0, 0, 0, 'Darashia 3, Flat 12', 4800, 6, 0, 0, 0, 0, 55, 5);
INSERT INTO `houses` VALUES (819, 0, 0, 0, 'Darashia 3, Flat 13', 2100, 6, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (820, 0, 0, 0, 'Darashia 3, Flat 14', 4600, 6, 0, 0, 0, 0, 55, 3);
INSERT INTO `houses` VALUES (821, 0, 0, 0, 'Darashia 4, Flat 01', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (822, 0, 0, 0, 'Darashia 4, Flat 02', 3460, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (823, 0, 0, 0, 'Darashia 4, Flat 03', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (824, 0, 0, 0, 'Darashia 4, Flat 04', 3460, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (825, 0, 0, 0, 'Darashia 4, Flat 05', 2100, 6, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (826, 0, 0, 0, 'Darashia 4, Flat 11', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (827, 0, 0, 0, 'Darashia 4, Flat 12', 4920, 6, 0, 0, 0, 0, 59, 3);
INSERT INTO `houses` VALUES (828, 0, 0, 0, 'Darashia 4, Flat 13', 3460, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (829, 0, 0, 0, 'Darashia 4, Flat 14', 3460, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (830, 0, 0, 0, 'Darashia 5, Flat 01', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (831, 0, 0, 0, 'Darashia 5, Flat 02', 3140, 6, 0, 0, 0, 0, 38, 2);
INSERT INTO `houses` VALUES (832, 0, 0, 0, 'Darashia 5, Flat 03', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (833, 0, 0, 0, 'Darashia 5, Flat 04', 3140, 6, 0, 0, 0, 0, 38, 2);
INSERT INTO `houses` VALUES (834, 0, 0, 0, 'Darashia 5, Flat 05', 2000, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (835, 0, 0, 0, 'Darashia 5, Flat 11', 3460, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (836, 0, 0, 0, 'Darashia 5, Flat 12', 3140, 6, 0, 0, 0, 0, 38, 2);
INSERT INTO `houses` VALUES (837, 0, 0, 0, 'Darashia 5, Flat 13', 3460, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (838, 0, 0, 0, 'Darashia 5, Flat 14', 3140, 6, 0, 0, 0, 0, 38, 2);
INSERT INTO `houses` VALUES (839, 0, 0, 0, 'Darashia 6a', 6130, 6, 0, 0, 0, 0, 67, 2);
INSERT INTO `houses` VALUES (840, 0, 0, 0, 'Darashia 6b', 6760, 6, 0, 0, 0, 0, 74, 2);
INSERT INTO `houses` VALUES (841, 0, 0, 0, 'Darashia 7, Flat 01', 2250, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (842, 0, 0, 0, 'Darashia 7, Flat 02', 2250, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (843, 0, 0, 0, 'Darashia 7, Flat 03', 5610, 6, 0, 0, 0, 0, 59, 4);
INSERT INTO `houses` VALUES (844, 0, 0, 0, 'Darashia 7, Flat 04', 2250, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (845, 0, 0, 0, 'Darashia 7, Flat 05', 2350, 6, 0, 0, 0, 0, 25, 2);
INSERT INTO `houses` VALUES (846, 0, 0, 0, 'Darashia 7, Flat 11', 2250, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (847, 0, 0, 0, 'Darashia 7, Flat 12', 5610, 6, 0, 0, 0, 0, 59, 4);
INSERT INTO `houses` VALUES (848, 0, 0, 0, 'Darashia 7, Flat 13', 2250, 6, 0, 0, 0, 0, 25, 1);
INSERT INTO `houses` VALUES (849, 0, 0, 0, 'Darashia 7, Flat 14', 5610, 6, 0, 0, 0, 0, 59, 4);
INSERT INTO `houses` VALUES (850, 0, 0, 0, 'Darashia 8, Flat 01', 4870, 6, 0, 0, 0, 0, 53, 2);
INSERT INTO `houses` VALUES (851, 0, 0, 0, 'Darashia 8, Flat 02', 6670, 6, 0, 0, 0, 0, 73, 2);
INSERT INTO `houses` VALUES (852, 0, 0, 0, 'Darashia 8, Flat 03', 9200, 6, 0, 0, 0, 0, 100, 3);
INSERT INTO `houses` VALUES (853, 0, 0, 0, 'Darashia 8, Flat 04', 5590, 6, 0, 0, 0, 0, 61, 2);
INSERT INTO `houses` VALUES (854, 0, 0, 0, 'Darashia 8, Flat 05', 5230, 6, 0, 0, 0, 0, 57, 2);
INSERT INTO `houses` VALUES (855, 0, 0, 0, 'Darashia, Villa', 10470, 6, 0, 0, 0, 0, 113, 4);
INSERT INTO `houses` VALUES (856, 0, 0, 0, 'Darashia, Western Guildhall', 19570, 6, 0, 0, 0, 0, 203, 14);
INSERT INTO `houses` VALUES (857, 0, 0, 0, 'Darashia, Eastern Guildhall', 23820, 6, 0, 0, 0, 0, 248, 16);
INSERT INTO `houses` VALUES (858, 0, 0, 0, 'Darashia 8, Flat 11', 3880, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (859, 0, 0, 0, 'Darashia 8, Flat 12', 3520, 6, 0, 0, 0, 0, 38, 2);
INSERT INTO `houses` VALUES (860, 0, 0, 0, 'Darashia 8, Flat 13', 3880, 6, 0, 0, 0, 0, 42, 2);
INSERT INTO `houses` VALUES (861, 0, 0, 0, 'Darashia 8, Flat 14', 3520, 6, 0, 0, 0, 0, 38, 2);

-- ----------------------------
-- Table structure for ip_bans
-- ----------------------------
DROP TABLE IF EXISTS `ip_bans`;
CREATE TABLE `ip_bans`  (
  `ip` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`ip`) USING BTREE,
  INDEX `banned_by`(`banned_by`) USING BTREE,
  CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ip_bans
-- ----------------------------

-- ----------------------------
-- Table structure for market_history
-- ----------------------------
DROP TABLE IF EXISTS `market_history`;
CREATE TABLE `market_history`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(4) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `inserted` bigint(20) UNSIGNED NOT NULL,
  `state` tinyint(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `player_id`(`player_id`, `sale`) USING BTREE,
  CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of market_history
-- ----------------------------

-- ----------------------------
-- Table structure for market_offers
-- ----------------------------
DROP TABLE IF EXISTS `market_offers`;
CREATE TABLE `market_offers`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(4) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `created` bigint(20) UNSIGNED NOT NULL,
  `anonymous` tinyint(4) NOT NULL DEFAULT 0,
  `price` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sale`(`sale`, `itemtype`) USING BTREE,
  INDEX `created`(`created`) USING BTREE,
  INDEX `player_id`(`player_id`) USING BTREE,
  CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of market_offers
-- ----------------------------

-- ----------------------------
-- Table structure for player_deaths
-- ----------------------------
DROP TABLE IF EXISTS `player_deaths`;
CREATE TABLE `player_deaths`  (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `killed_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT 1,
  `mostdamage_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT 0,
  `unjustified` tinyint(1) NOT NULL DEFAULT 0,
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT 0,
  INDEX `player_id`(`player_id`) USING BTREE,
  INDEX `killed_by`(`killed_by`) USING BTREE,
  INDEX `mostdamage_by`(`mostdamage_by`) USING BTREE,
  CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of player_deaths
-- ----------------------------

-- ----------------------------
-- Table structure for player_depotitems
-- ----------------------------
DROP TABLE IF EXISTS `player_depotitems`;
CREATE TABLE `player_depotitems`  (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL,
  UNIQUE INDEX `player_id_2`(`player_id`, `sid`) USING BTREE,
  CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of player_depotitems
-- ----------------------------

-- ----------------------------
-- Table structure for player_items
-- ----------------------------
DROP TABLE IF EXISTS `player_items`;
CREATE TABLE `player_items`  (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `pid` int(11) NOT NULL DEFAULT 0,
  `sid` int(11) NOT NULL DEFAULT 0,
  `itemtype` smallint(6) NOT NULL DEFAULT 0,
  `count` smallint(5) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL,
  INDEX `player_id`(`player_id`) USING BTREE,
  INDEX `sid`(`sid`) USING BTREE,
  CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of player_items
-- ----------------------------

-- ----------------------------
-- Table structure for player_murders
-- ----------------------------
DROP TABLE IF EXISTS `player_murders`;
CREATE TABLE `player_murders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `date` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of player_murders
-- ----------------------------

-- ----------------------------
-- Table structure for player_namelocks
-- ----------------------------
DROP TABLE IF EXISTS `player_namelocks`;
CREATE TABLE `player_namelocks`  (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL,
  PRIMARY KEY (`player_id`) USING BTREE,
  INDEX `namelocked_by`(`namelocked_by`) USING BTREE,
  CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of player_namelocks
-- ----------------------------

-- ----------------------------
-- Table structure for player_spells
-- ----------------------------
DROP TABLE IF EXISTS `player_spells`;
CREATE TABLE `player_spells`  (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `player_id`(`player_id`) USING BTREE,
  CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of player_spells
-- ----------------------------

-- ----------------------------
-- Table structure for player_storage
-- ----------------------------
DROP TABLE IF EXISTS `player_storage`;
CREATE TABLE `player_storage`  (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `key` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`, `key`) USING BTREE,
  CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of player_storage
-- ----------------------------

-- ----------------------------
-- Table structure for players
-- ----------------------------
DROP TABLE IF EXISTS `players`;
CREATE TABLE `players`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 1,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `vocation` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 150,
  `healthmax` int(11) NOT NULL DEFAULT 150,
  `experience` bigint(20) NOT NULL DEFAULT 0,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `looktype` int(11) NOT NULL DEFAULT 136,
  `lookaddons` int(11) NOT NULL DEFAULT 0,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `mana` int(11) NOT NULL DEFAULT 0,
  `manamax` int(11) NOT NULL DEFAULT 0,
  `manaspent` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `soul` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 0,
  `posx` int(11) NOT NULL DEFAULT 0,
  `posy` int(11) NOT NULL DEFAULT 0,
  `posz` int(11) NOT NULL DEFAULT 0,
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT 0,
  `sex` int(11) NOT NULL DEFAULT 0,
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `save` tinyint(1) NOT NULL DEFAULT 1,
  `skull` tinyint(1) NOT NULL DEFAULT 0,
  `skulltime` int(11) NOT NULL DEFAULT 0,
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `blessings` tinyint(2) NOT NULL DEFAULT 0,
  `onlinetime` int(11) NOT NULL DEFAULT 0,
  `deletion` bigint(15) NOT NULL DEFAULT 0,
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `offlinetraining_time` smallint(5) UNSIGNED NOT NULL DEFAULT 43200,
  `offlinetraining_skill` int(11) NOT NULL DEFAULT -1,
  `stamina` smallint(5) NOT NULL DEFAULT 3360,
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `fake_player` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `account_id`(`account_id`) USING BTREE,
  INDEX `vocation`(`vocation`) USING BTREE,
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of players
-- ----------------------------
INSERT INTO `players` VALUES (4, 'Adm Dragonas', 3, 1, 8, 1, 185, 185, 4200, 68, 76, 78, 58, 128, 0, 0, 90, 90, 0, 100, 6, 5, 5, 2, '', 470, 1, 0, 2130706433, 1, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 3360, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0);

-- ----------------------------
-- Table structure for players_online
-- ----------------------------
DROP TABLE IF EXISTS `players_online`;
CREATE TABLE `players_online`  (
  `player_id` int(11) NOT NULL,
  PRIMARY KEY (`player_id`) USING HASH
) ENGINE = MEMORY CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of players_online
-- ----------------------------

-- ----------------------------
-- Table structure for server_config
-- ----------------------------
DROP TABLE IF EXISTS `server_config`;
CREATE TABLE `server_config`  (
  `config` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`config`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of server_config
-- ----------------------------
INSERT INTO `server_config` VALUES ('motd_hash', '591d7fcbec26bc2982bdf5b0f13fd6bcbbd3aa0c');
INSERT INTO `server_config` VALUES ('motd_num', '1');
INSERT INTO `server_config` VALUES ('players_record', '2');

-- ----------------------------
-- Table structure for tile_store
-- ----------------------------
DROP TABLE IF EXISTS `tile_store`;
CREATE TABLE `tile_store`  (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL,
  INDEX `house_id`(`house_id`) USING BTREE,
  CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tile_store
-- ----------------------------

-- ----------------------------
-- Table structure for znote
-- ----------------------------
DROP TABLE IF EXISTS `znote`;
CREATE TABLE `znote`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Znote AAC version',
  `installed` int(11) NOT NULL,
  `cached` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote
-- ----------------------------
INSERT INTO `znote` VALUES (1, '1.6', 1674518400, NULL);

-- ----------------------------
-- Table structure for znote_accounts
-- ----------------------------
DROP TABLE IF EXISTS `znote_accounts`;
CREATE TABLE `znote_accounts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `ip` bigint(20) UNSIGNED NOT NULL,
  `created` int(11) NOT NULL,
  `points` int(11) NULL DEFAULT 0,
  `cooldown` int(11) NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `active_email` tinyint(4) NOT NULL DEFAULT 0,
  `activekey` int(11) NOT NULL DEFAULT 0,
  `flag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `secret` char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_accounts
-- ----------------------------
INSERT INTO `znote_accounts` VALUES (1, 1, 2130706433, 1674525416, 0, 0, 1, 0, 747733978, 'br', NULL);

-- ----------------------------
-- Table structure for znote_auction_player
-- ----------------------------
DROP TABLE IF EXISTS `znote_auction_player`;
CREATE TABLE `znote_auction_player`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `original_account_id` int(11) NOT NULL,
  `bidder_account_id` int(11) NOT NULL,
  `time_begin` int(11) NOT NULL,
  `time_end` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `deposit` int(11) NOT NULL,
  `sold` tinyint(4) NOT NULL,
  `claimed` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_auction_player
-- ----------------------------

-- ----------------------------
-- Table structure for znote_changelog
-- ----------------------------
DROP TABLE IF EXISTS `znote_changelog`;
CREATE TABLE `znote_changelog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_changelog
-- ----------------------------

-- ----------------------------
-- Table structure for znote_deleted_characters
-- ----------------------------
DROP TABLE IF EXISTS `znote_deleted_characters`;
CREATE TABLE `znote_deleted_characters`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `original_account_id` int(11) NOT NULL,
  `character_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` datetime(0) NOT NULL,
  `done` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_deleted_characters
-- ----------------------------

-- ----------------------------
-- Table structure for znote_forum
-- ----------------------------
DROP TABLE IF EXISTS `znote_forum`;
CREATE TABLE `znote_forum`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `access` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `guild_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_forum
-- ----------------------------
INSERT INTO `znote_forum` VALUES (1, 'Staff Board', 4, 0, 0, 0);
INSERT INTO `znote_forum` VALUES (2, 'Tutors Board', 2, 0, 0, 0);
INSERT INTO `znote_forum` VALUES (3, 'Discussion', 1, 0, 0, 0);
INSERT INTO `znote_forum` VALUES (4, 'Feedback', 1, 0, 1, 0);

-- ----------------------------
-- Table structure for znote_forum_posts
-- ----------------------------
DROP TABLE IF EXISTS `znote_forum_posts`;
CREATE TABLE `znote_forum_posts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_forum_posts
-- ----------------------------

-- ----------------------------
-- Table structure for znote_forum_threads
-- ----------------------------
DROP TABLE IF EXISTS `znote_forum_threads`;
CREATE TABLE `znote_forum_threads`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `sticky` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_forum_threads
-- ----------------------------

-- ----------------------------
-- Table structure for znote_global_storage
-- ----------------------------
DROP TABLE IF EXISTS `znote_global_storage`;
CREATE TABLE `znote_global_storage`  (
  `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE INDEX `key`(`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_global_storage
-- ----------------------------

-- ----------------------------
-- Table structure for znote_guild_wars
-- ----------------------------
DROP TABLE IF EXISTS `znote_guild_wars`;
CREATE TABLE `znote_guild_wars`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `limit` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_guild_wars
-- ----------------------------

-- ----------------------------
-- Table structure for znote_images
-- ----------------------------
DROP TABLE IF EXISTS `znote_images`;
CREATE TABLE `znote_images`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `image` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `delhash` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_images
-- ----------------------------

-- ----------------------------
-- Table structure for znote_news
-- ----------------------------
DROP TABLE IF EXISTS `znote_news`;
CREATE TABLE `znote_news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_news
-- ----------------------------

-- ----------------------------
-- Table structure for znote_paygol
-- ----------------------------
DROP TABLE IF EXISTS `znote_paygol`;
CREATE TABLE `znote_paygol`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `message_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `service_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `shortcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `operator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `currency` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_paygol
-- ----------------------------

-- ----------------------------
-- Table structure for znote_paypal
-- ----------------------------
DROP TABLE IF EXISTS `znote_paypal`;
CREATE TABLE `znote_paypal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `txn_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `accid` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_paypal
-- ----------------------------

-- ----------------------------
-- Table structure for znote_player_reports
-- ----------------------------
DROP TABLE IF EXISTS `znote_player_reports`;
CREATE TABLE `znote_player_reports`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `posx` int(11) NOT NULL,
  `posy` int(11) NOT NULL,
  `posz` int(11) NOT NULL,
  `report_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_player_reports
-- ----------------------------

-- ----------------------------
-- Table structure for znote_players
-- ----------------------------
DROP TABLE IF EXISTS `znote_players`;
CREATE TABLE `znote_players`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `hide_char` tinyint(4) NOT NULL,
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `exphist_lastexp` bigint(255) NOT NULL DEFAULT 0,
  `exphist1` bigint(255) NOT NULL DEFAULT 0,
  `exphist2` bigint(255) NOT NULL DEFAULT 0,
  `exphist3` bigint(255) NOT NULL DEFAULT 0,
  `exphist4` bigint(255) NOT NULL DEFAULT 0,
  `exphist5` bigint(255) NOT NULL DEFAULT 0,
  `exphist6` bigint(255) NOT NULL DEFAULT 0,
  `exphist7` bigint(255) NOT NULL DEFAULT 0,
  `onlinetimetoday` bigint(20) NOT NULL DEFAULT 0,
  `onlinetime1` bigint(20) NOT NULL DEFAULT 0,
  `onlinetime2` bigint(20) NOT NULL DEFAULT 0,
  `onlinetime3` bigint(20) NOT NULL DEFAULT 0,
  `onlinetime4` bigint(20) NOT NULL DEFAULT 0,
  `onlinetime5` bigint(20) NOT NULL DEFAULT 0,
  `onlinetime6` bigint(20) NOT NULL DEFAULT 0,
  `onlinetime7` bigint(20) NOT NULL DEFAULT 0,
  `onlinetimeall` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_players
-- ----------------------------
INSERT INTO `znote_players` VALUES (1, 4, 1674525432, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for znote_shop
-- ----------------------------
DROP TABLE IF EXISTS `znote_shop`;
CREATE TABLE `znote_shop`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `itemid` int(11) NULL DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT 1,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `points` int(11) NOT NULL DEFAULT 10,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_shop
-- ----------------------------

-- ----------------------------
-- Table structure for znote_shop_logs
-- ----------------------------
DROP TABLE IF EXISTS `znote_shop_logs`;
CREATE TABLE `znote_shop_logs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_shop_logs
-- ----------------------------

-- ----------------------------
-- Table structure for znote_shop_orders
-- ----------------------------
DROP TABLE IF EXISTS `znote_shop_orders`;
CREATE TABLE `znote_shop_orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_shop_orders
-- ----------------------------

-- ----------------------------
-- Table structure for znote_tickets
-- ----------------------------
DROP TABLE IF EXISTS `znote_tickets`;
CREATE TABLE `znote_tickets`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` int(11) NOT NULL,
  `username` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `subject` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `message` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ip` bigint(20) NOT NULL,
  `creation` int(11) NOT NULL,
  `status` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_tickets
-- ----------------------------

-- ----------------------------
-- Table structure for znote_tickets_replies
-- ----------------------------
DROP TABLE IF EXISTS `znote_tickets_replies`;
CREATE TABLE `znote_tickets_replies`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `username` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `message` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_tickets_replies
-- ----------------------------

-- ----------------------------
-- Table structure for znote_visitors
-- ----------------------------
DROP TABLE IF EXISTS `znote_visitors`;
CREATE TABLE `znote_visitors`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` bigint(20) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_visitors
-- ----------------------------

-- ----------------------------
-- Table structure for znote_visitors_details
-- ----------------------------
DROP TABLE IF EXISTS `znote_visitors_details`;
CREATE TABLE `znote_visitors_details`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` bigint(20) NOT NULL,
  `time` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znote_visitors_details
-- ----------------------------

-- ----------------------------
-- Triggers structure for table guilds
-- ----------------------------
DROP TRIGGER IF EXISTS `oncreate_guilds`;
delimiter ;;
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table players
-- ----------------------------
DROP TRIGGER IF EXISTS `ondelete_players`;
delimiter ;;
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
