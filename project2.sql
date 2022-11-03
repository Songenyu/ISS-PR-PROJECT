/*
 Navicat Premium Data Transfer

 Source Server         : project2
 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Host           : localhost:3307
 Source Schema         : project2

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 03/11/2022 14:04:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for audithistory
-- ----------------------------
DROP TABLE IF EXISTS `audithistory`;
CREATE TABLE `audithistory`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NULL DEFAULT NULL,
  `contentId` bigint(20) NULL DEFAULT NULL,
  `method` int(1) NULL DEFAULT NULL COMMENT '审核方式 0人工 1model',
  `pass` int(1) NULL DEFAULT NULL COMMENT '是否通过审核 -1未通过 1通过',
  `reason` int(1) NULL DEFAULT NULL COMMENT '0,没有(通过)\r\n1 porn，\r\n2 face \r\n3 porn & face  \r\n4 sensitive',
  `createTime` datetime(0) NULL DEFAULT NULL,
  `updateTime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_Reference_4`(`contentId`) USING BTREE,
  INDEX `FK_Reference_5`(`userId`) USING BTREE,
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`contentId`) REFERENCES `content` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of audithistory
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(254) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for content
-- ----------------------------
DROP TABLE IF EXISTS `content`;
CREATE TABLE `content`  (
  `id` bigint(20) NOT NULL,
  `typeId` int(11) NOT NULL COMMENT '0文字，1图片，2视频',
  `userId` bigint(20) NOT NULL,
  `fromResource` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '内容来源：eg爱奇艺媒体',
  `mediaTitle` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '内容标题',
  `checkResult` int(11) NOT NULL COMMENT '最终检查结果 0未检查/需人工 -1不通过 1通过\r\n',
  `lableFromModel` int(11) NULL DEFAULT NULL COMMENT '#表示整体的是否符合要求\r\n-2 为既没有人工审核也没有model审核\r\n-1  model审核结果为需要人工审核\r\n0   model审核不通过 \r\n1 model审核通过\r\n',
  `url` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '整个内容的存储url',
  `frameUrl` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '视频对应展示帧的url',
  `strings` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '对应文本',
  `createTime` datetime(0) NULL DEFAULT NULL,
  `updateTime` datetime(0) NULL DEFAULT NULL,
  `is_deleted` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_Reference_2`(`userId`) USING BTREE,
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of content
-- ----------------------------
INSERT INTO `content` VALUES (1, 1, 2, 'Netfilx', 'good good study', 0, -2, 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/1.png', 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/1.png', NULL, '2022-10-19 15:21:02', '2022-11-03 13:59:06', 0);
INSERT INTO `content` VALUES (2, 1, 2, 'self photo', 'TQY', 0, -2, 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/TQY.png', 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/TQY.png', NULL, '2022-10-20 14:48:45', '2022-11-03 13:59:14', 0);
INSERT INTO `content` VALUES (3, 1, 2, 'machine', 'tools', 0, -2, 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/1.jfif', 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/1.jfif', NULL, '2022-10-21 19:20:24', '2022-11-03 13:59:19', 0);
INSERT INTO `content` VALUES (4, 1, 2, 'Alifex', 'Se Se', 0, -2, 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/FfQosW8agAARD8T.jpg', 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/FfQosW8agAARD8T.jpg', NULL, '2022-10-22 01:25:37', '2022-11-03 14:01:56', 0);
INSERT INTO `content` VALUES (5, 1, 2, 'Twitter', 'Ha Ha', 0, -2, 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/FfnAmflXEAMIEm8.jpg', 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/FfnAmflXEAMIEm8.jpg', NULL, '2022-10-22 01:27:27', '2022-11-03 14:01:36', 0);
INSERT INTO `content` VALUES (6, 0, 2, 'hhh', 'hhh', 0, -2, NULL, NULL, 'fuck offfuck offfuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off fuck off', '2022-10-23 22:26:48', '2022-11-03 14:00:42', 0);
INSERT INTO `content` VALUES (7, 0, 2, 'yes', 'yew', 0, -2, NULL, NULL, 'how are you ', '2022-10-25 11:05:51', '2022-11-02 15:28:29', 0);
INSERT INTO `content` VALUES (8, 2, 2, 'lyf', 'lyf', 0, -2, 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/1.mp4', 'https://backet-iss-project2.obs.cn-north-9.myhuaweicloud.com/1-lyf.jpg', NULL, '2022-10-25 11:14:53', '2022-10-25 13:51:37', 0);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `object_repr` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `model` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2022-10-19 04:22:42.133641');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2022-10-19 04:22:42.688902');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2022-10-19 04:22:42.816313');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2022-10-19 04:22:42.824218');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2022-10-19 04:22:42.831226');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2022-10-19 04:22:42.920802');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2022-10-19 04:22:42.937746');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2022-10-19 04:22:42.953903');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2022-10-19 04:22:42.961902');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2022-10-19 04:22:43.015773');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2022-10-19 04:22:43.018817');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2022-10-19 04:22:43.026817');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2022-10-19 04:22:43.043251');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2022-10-19 04:22:43.061368');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2022-10-19 04:22:43.077529');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2022-10-19 04:22:43.084529');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2022-10-19 04:22:43.100528');
INSERT INTO `django_migrations` VALUES (18, 'sessions', '0001_initial', '2022-10-19 04:22:43.146964');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `session_data` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('1hx0rf6w6ms2b64b1habjkhztz9kpft5', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1olSGS:JYPBQmqtMu7TV1zvIu8m-IQBHf-O58LeIxgAkGdwHGg', '2022-10-20 10:25:00.843595');
INSERT INTO `django_session` VALUES ('2ht83wvjat70i4qjisjs16txzse3o3db', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1on04M:G4-gP5uuWv55r5obVmDY2Vbj5v14mgRRlRN5ss_gKPM', '2022-10-24 16:42:54.913205');
INSERT INTO `django_session` VALUES ('2tshpklcyf959i2kmetdtv2fb4jy5nou', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1onDsE:-tR0Z6V_BgiEtA1ZdHG9erM0v7v7mqQqSW5wCqX5tDs', '2022-10-25 07:27:18.950321');
INSERT INTO `django_session` VALUES ('3ae3tve3f2fw4959ev0ikme7t7y2o3og', '.eJyFjcsKwjAQRX8lzNpCHkgxfyCIq0I3AxLMgAOpLUm6Kv13SUp10YWzu-de5iwwJ4pgYUFgj2CFOgms8O4GKgBB1UMozeRS6sfojw0NjsOONxTHQNc6NSXyu39xphun_DVxengKlOknf0ZymTre9Vpq3SjZqIuQ0kpjzXl7P0_-z7BFWGH9AAEoPvA:1ol1L7:YV-v05bh5Jfc8r-aTaMnKBkM-FVVHvRk0yU9FZGsNJY', '2022-10-19 05:40:01.754897');
INSERT INTO `django_session` VALUES ('5a81go9v4064jrcwn8586h7gyy7h9o5p', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1olpnA:iSx0QMSwvGGsa7PTkfjVRyBxFhs7CDOfpJHneHiSrDs', '2022-10-21 11:32:20.042378');
INSERT INTO `django_session` VALUES ('799zrvhp9lyff8q81z3nx0pf1sgr9awn', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1ol3Jx:Nl0RNwHYykx6tHUm5Zvr3lAzgl8hm0j1STw3mCT_BJA', '2022-10-19 07:46:57.608590');
INSERT INTO `django_session` VALUES ('8go3dh1b55t87iec9ccyvblxcy0csewe', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1onAyv:gHaQ_h3JTidtZxjTs22zRuU0HnXTxD6Ll-DBKcRTDzw', '2022-10-25 04:22:01.228984');
INSERT INTO `django_session` VALUES ('9eoee7a33u65ljny1x68u7jvrotyywhm', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1oq7Pc:_tcb6h38yYBt0ObFJY7EIybNpXRspUEH0Asbt9Q1tpc', '2022-11-02 07:09:44.712468');
INSERT INTO `django_session` VALUES ('9v69khlab37vuxjt8cw6hfqwsoxvsw4n', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omY27:qR7ToqOrZZJVEEunCoBjplaM3LM3nSOqAwR4Tb-Cn7g', '2022-10-23 10:46:43.330904');
INSERT INTO `django_session` VALUES ('a6dj1wr2td1llkfiywqnyjyt63hfwzm9', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omZBo:rKtSgsRWK6F6b2huOFCZjmBpHz72q-ovO_aNrlxqgcs', '2022-10-23 12:00:48.850765');
INSERT INTO `django_session` VALUES ('aj89beqfbqlczw5uzjlxg98t37xinwvd', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1olaJo:fK5fAmLupBwKJqTn2IlZlbifCkNiCnRhn9lLqEFSE4k', '2022-10-20 19:01:00.222486');
INSERT INTO `django_session` VALUES ('b3m0yvo89f3w61k2h5kjoe2f5rrunbro', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1olB7j:Ix2gbp9iQyR80nKIZohUkaDCfd98xGRn3ulGNpfUXpI', '2022-10-19 16:06:51.527592');
INSERT INTO `django_session` VALUES ('bohmvzxu69k7aq2d8iriael0e1ffgd3t', '.eJyFjcsKwjAQRX8lzNpCHkgxfyCIq0I3AxLMgAOpLUm6Kv13SUp10YWzu-de5iwwJ4pgYUFgj2CFOgms8O4GKgBB1UMozeRS6sfojw0NjsOONxTHQNc6NSXyu39xphun_DVxengKlOknf0ZymTre9Vpq3SjZqIuQ0kpjzXl7P0_-z7BFWGH9AAEoPvA:1ol1IP:T66ea_yscRr6moqRZjY08YgIAxJvkE_CUQbq1IbNDZ0', '2022-10-19 05:37:13.448004');
INSERT INTO `django_session` VALUES ('c33z9fhej78x1yqycs2ivvyjul7ab5hf', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omHkz:cJ6zJuM85oVf7zAVv_f_POeYuS2PUABir3mW0GVvQV8', '2022-10-22 17:23:57.396254');
INSERT INTO `django_session` VALUES ('c5sri3imevjbhe40505bh7xq7ny1hbxa', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omX3Y:T09PziE1nV51tRErb2QzCdMe5dR0AfD86OwKNKxQ9UQ', '2022-10-23 09:44:08.298499');
INSERT INTO `django_session` VALUES ('d8u32pq2qo6vwhpcppgv5xt82klisq5n', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1onCyB:AsMAfL3xThLrXvDPxu7bkRcdG4YaqVISyUQef572f3c', '2022-10-25 06:29:23.629498');
INSERT INTO `django_session` VALUES ('e8dofpfpcenajxdew2v8d5j1gbl84msm', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1ol8FF:WjSDWKTiC-i7Wioy8MHv0YEcy6hviBT2w3bAe6aA_Rk', '2022-10-19 13:02:25.383348');
INSERT INTO `django_session` VALUES ('f02fpw1ta4zms3s1dfte3p8fbxsztxys', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omG4p:WNncgwIaPu3XsnA2ZleiyGtXzllONF15ALMIuL-leQ0', '2022-10-22 15:36:19.674948');
INSERT INTO `django_session` VALUES ('f9p3s1kai6zydjwhlzdvaqko75xdm9tu', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omSzS:uZ37wY9clU2c0KsdU8UgyLPr8i-iGds_Y727KrgCi3A', '2022-10-23 05:23:38.590053');
INSERT INTO `django_session` VALUES ('faywduaok3etnw0s3h200ie5r11upviw', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omV1k:3jyz3LMpea2P_lCwKCDYaVK5DYdJEM8OyS1Q-ortD0I', '2022-10-23 07:34:08.549142');
INSERT INTO `django_session` VALUES ('g4qgc9d7w8mx5xf2ukletqiglwumni0a', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1olP3R:_lH5_NwVbRLlnLe3IoWeBe53ulTqGP9SDlPrCiaj9wQ', '2022-10-20 06:59:21.929677');
INSERT INTO `django_session` VALUES ('gmngly8zqnz727aums0m9hl8dhvkqhta', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1ol6ID:DZVhdnCHGT2mNGh-eKIcy16brQQ8jniAfblUDQDR3A8', '2022-10-19 10:57:21.313394');
INSERT INTO `django_session` VALUES ('h8j71km5ffuwhqe9cl8m2p0mylqqazy1', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1ol810:aJsQWkN3GqBIW8F4DCW1eKxDJc3bVZotMdHlYA0KFQ8', '2022-10-19 12:47:42.221025');
INSERT INTO `django_session` VALUES ('hg69uxj7uesdcm7k7wvrckl7sulxus66', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omdtb:MUQm92eq7LAYbWALfSqngxIVuXFVYOH6PCMDhVV2xnE', '2022-10-23 17:02:19.824616');
INSERT INTO `django_session` VALUES ('hovseubm0n84mtl46lpiwu3690q3wsh4', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1olZlU:baUgZHGESaGMklU1IxM2KE1IihqrsJRfQ8JBbbwp-WI', '2022-10-20 18:25:32.825461');
INSERT INTO `django_session` VALUES ('ib3m5se9z5srupzfkt9n03um2ty95n8m', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1op9GB:PFvuLB3CgOLFBYhvWaXOkUguYVu73kU31ZZiqqpjMEU', '2022-10-30 14:55:59.774585');
INSERT INTO `django_session` VALUES ('j62qrhvek31muwfpxx9e67yljt6ssw47', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1olvqm:WFcrReFVnaBmWpeEGyUKuLztoV1ZmLmA5awZls2cA9U', '2022-10-21 18:00:28.775833');
INSERT INTO `django_session` VALUES ('jobicutht8hojtfklnyr0uw3hcrqil0b', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omy1K:doh3nSVVCh1tnhi8kCT3lphgu5dlVx5TU2M5gFKAKbY', '2022-10-24 14:31:38.252203');
INSERT INTO `django_session` VALUES ('l34pgn1dhwfwkuduyt42esrjxz3end2x', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omQWG:DuA4Su0lw7o2KRlri64ZMxR-O0f9BI49_QbrWY3QrsU', '2022-10-23 02:45:20.378376');
INSERT INTO `django_session` VALUES ('lwl843e4l12pcfixmi01igp5ngzs5b2g', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1oq8H0:V33OTP22kTZlu9Z_482reF4DS1y0r0uxcR58i7m6u-E', '2022-11-02 08:04:54.307513');
INSERT INTO `django_session` VALUES ('oy1z1l9w2opy4zw53hl9b0k4pkb1fsu3', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1oqTAY:gQNxUjVCHWj_SbabwX1UZKI0oeOZ-iUMpwMc3xCJ4oM', '2022-11-03 06:23:38.883557');
INSERT INTO `django_session` VALUES ('ptvq0p91rxvnch72ptvo6vns7hw6dkuo', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1ol58C:ZleRaXKaasf58k7pYGt6_PkhkmkVLeVJP1ZR1Hajeow', '2022-10-19 09:42:56.553282');
INSERT INTO `django_session` VALUES ('qd7g6rvkixdqkpcvq7yb3ye2jcm45qn7', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1olj4a:MEYCNnyAjH5HVd5b-3nZD0m_RlbGudx1j4FA2tcRMRU', '2022-10-21 04:21:52.066887');
INSERT INTO `django_session` VALUES ('qlfbhmjcrgpcjm44tlti95wp9dvzpmr0', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1olSBu:dVUmCNihLUcSLO0R8QiIXSMHcjvUePYTCfDI5v0cmhc', '2022-10-20 10:20:18.252207');
INSERT INTO `django_session` VALUES ('qyriww7b1k2vpyjr1c4cq191pplad2g0', '.eJyFjcsKwjAQRX8lzNpCHkgxfyCIq0I3AxLMgAOpLUm6Kv13SUp10YWzu-de5iwwJ4pgYUFgj2CFOgms8O4GKgBB1UMozeRS6sfojw0NjsOONxTHQNc6NSXyu39xphun_DVxengKlOknf0ZymTre9Vpq3SjZqIuQ0kpjzXl7P0_-z7BFWGH9AAEoPvA:1ol1I8:CXcM2zpiuptJ2SWrxMCvKAKanZXzO92_iLusehSha7k', '2022-10-19 05:36:56.904685');
INSERT INTO `django_session` VALUES ('rl6f0jyilj5dyv1lghs7pb26wsjc041q', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1onEOM:yiEVNHJ1IgPq6BTRfxHyiPJqsJgyGjd3EfkIChUriJM', '2022-10-25 08:00:30.497058');
INSERT INTO `django_session` VALUES ('skqwhy5x0ra3ffrr2a9hmx6idafafjah', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1om3tK:Ioe7AgMCCv_UakccoOHzzwP0Wf5fxjn92ZuT7ETJb94', '2022-10-22 02:35:38.371880');
INSERT INTO `django_session` VALUES ('tuipz8oeqfq9gsyxsdd2lvii0oqbvcj5', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1ol7GB:d4C4viVzMSO9ty7IEXBgW7LDrZnRSNqLhEDGM_uj-wY', '2022-10-19 11:59:19.250010');
INSERT INTO `django_session` VALUES ('u1o01fjgz2mi4zhbf7anmt99u4drfu2c', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omSMV:AOvYr6DQggIwwpjCGlEujuTZypZt7dRYe6frDHmp_f0', '2022-10-23 04:43:23.310666');
INSERT INTO `django_session` VALUES ('udm8u4lo6rkvyfiajwbka2b69nndloym', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1olOTI:dxLAoy0kx_BDMpQhw7sw1CgY7vGQO4We5cuTeRydVQg', '2022-10-20 06:22:00.977396');
INSERT INTO `django_session` VALUES ('ukmuskw3ihdq3nrzuxqr5t5a6652jzxa', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omRfv:FvVdSQ3FtPdMhNseOiwpK_zPsmH7vwDAFSiJc3i-qYY', '2022-10-23 03:59:23.986016');
INSERT INTO `django_session` VALUES ('ulyq047qluvukrqza5o0can4nk6fyqnf', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omXXA:7lNap8w17QrxLjuOlnlCNH9m3o96WrpMMw_6C9IidLQ', '2022-10-23 10:14:44.102745');
INSERT INTO `django_session` VALUES ('xkmisgq4nh1stxq8ysi31elmz3qc7jjd', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1olQgT:nj9ClhnjnQKVhuy_BWONhqos3HvHf98o1gGUSpsEa6U', '2022-10-20 08:43:45.204078');
INSERT INTO `django_session` VALUES ('y2zxq61cbl4qz3hgl6hfvw288008ax1c', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omBR0:yrxUX5MurVE2SrrN5qHFziEd6CRZO51AXjhYwf7e60g', '2022-10-22 10:38:54.781514');
INSERT INTO `django_session` VALUES ('y87lsbh7ndvpde9oyauy8j85sd4k4de4', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omc0l:IHpFAgnFNs9bycAC93D8c7XtlHAiplsDinJQ2WkRBOc', '2022-10-23 15:01:35.273972');
INSERT INTO `django_session` VALUES ('yjybvfzoyl7tqg67gttbc0g7ixrldhcc', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1omCXu:HTkqHkn4Z_bWDvwuLaL63vutKX1G9IGFiPveWL_UZ5E', '2022-10-22 11:50:06.343727');
INSERT INTO `django_session` VALUES ('yt7zrua0gw8bjke0true7juw0pnt5wwo', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1onAMQ:8Kj62h6zNyP4AI68uy00POoeOEDjC1eQNisw8NqJiNM', '2022-10-25 03:42:14.597770');
INSERT INTO `django_session` VALUES ('z97qd8gjn3zleytsgae6j9krnw2zae27', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1oq6mE:Nk462RcE3JfBw-uZrMmKVuoy5_RB6UL2SmmeGmffMwQ', '2022-11-02 06:29:02.453469');
INSERT INTO `django_session` VALUES ('zcm1q1ujlgerx5w0x2a929qzgbrciq9u', '.eJyFzUsKwzAMBNCrGK0bkB1Kqc8iKKYWVOB8sByyCLl7sUNooYtq-WYYbbAoZ_CwEUgk8MZeDDUcw8AVCGw7gprMQXWdcvxNeAiSTj4oT4m_VmVcX1I4iZaP6SNy4sKthpWemUPhIud7h851Fjt7N4gee99fj_lljn-KN4Id9jdp-D_N:1oljl2:iYJZ5MlaeBFyjbvKTm440c60g51xrJJcw8OYe0TckY8', '2022-10-21 05:05:44.963979');
INSERT INTO `django_session` VALUES ('zj1l5s15vs8hzpekslakvv4k1lml8mnn', '.eJyFzTEKwzAMBdCrGM0NyA6l1DcolE6BLIJiakEFThNsZwq5e7FDyNChGt__fC0wJ45gYSEQT2CVPimq-HADFyDQ9QhKMrmU-jH634QHJ2HnjeIY-Hasyqd_S-a7pHxYenoOnLnWsNArssvcyf7eoDGNxkZfFaLF1rbnbX6e_J_ihWCF9Qv_yT7t:1olBvP:NKqPW3kCA7J0_ki91XB-Eul3rCR1GBgc6eJxlaqMTD4', '2022-10-19 16:58:11.033405');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL,
  `userName` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `passWord` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `roleId` int(1) NULL DEFAULT NULL COMMENT '0超管，1管理，3上传者',
  `inWhiteList` int(1) NOT NULL COMMENT '0不在白名单，1在白名单',
  `is_deleted` int(1) NULL DEFAULT NULL COMMENT '0没有删除，1已删除',
  `createTime` datetime(0) NULL DEFAULT NULL,
  `updateTime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '111111', '111111', '11', 1, 1, 0, '2022-10-19 00:03:35', '2022-10-19 00:03:37');
INSERT INTO `user` VALUES (2, 'uploader1', 'uploader1', '1', 3, 1, 0, '2022-10-19 15:09:20', '2022-10-19 15:09:26');

-- ----------------------------
-- Triggers structure for table audithistory
-- ----------------------------
DROP TRIGGER IF EXISTS `updateWhiteList`;
delimiter ;;
CREATE TRIGGER `updateWhiteList` AFTER UPDATE ON `audithistory` FOR EACH ROW BEGIN

create temporary table demo
select count(*) as a, `user.id` as userId
from audithistory,content,`user`
where audithistory.contentId=content.id and `user`.id=content.userId
and audithistory.`pass`=-1
GROUP BY content.userId;

IF demo.a >5 THEN
UPDATE `user` SET inWhiteList=0 WHERE `user`.id=demo.userId;
END IF;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
