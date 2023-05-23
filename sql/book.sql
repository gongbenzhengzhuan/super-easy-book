/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : book

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 17/04/2023 19:04:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `picture` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书本名称',
  `introduce` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '介绍',
  `publish` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `auth` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `price` double NULL DEFAULT NULL COMMENT '价格',
  `is_deleted` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '书本信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (5, 'http://localhost:8569/images/2023/04/16/2f599293a2c94a47bf6a375170c4ab8f.jpg', '如何学习mybatis', '教你怎么学mybatis', '清华大学出版社', 'Smhg', 8.5, 1, '2023-04-16 12:04:50', '2023-04-17 18:16:05');
INSERT INTO `book` VALUES (6, 'http://localhost:8569/images/2023/04/17/aab3b6a7fb9a41df9489459ff85b64cb.jpg', '非人哉', '这是一部非常好看的动漫', '华东出版社', '一汪空气', 9.9, 0, '2023-04-17 17:16:37', '2023-04-17 17:16:37');
INSERT INTO `book` VALUES (7, 'http://localhost:8569/images/2023/04/17/8d04f3448b414b49af225381f63edbc8.jpg', 'SpringMVC怎么学习', '教会您如何快速学会SpringMVC', '花呗竖版社', 'Spring', 993.98, 0, '2023-04-17 17:18:13', '2023-04-17 18:13:42');

SET FOREIGN_KEY_CHECKS = 1;
