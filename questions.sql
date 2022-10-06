/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : questions

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 19/05/2020 16:58:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version`  (
  `version_num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`version_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
INSERT INTO `alembic_version` VALUES ('f2110a8828d7');

-- ----------------------------
-- Table structure for examination
-- ----------------------------
DROP TABLE IF EXISTS `examination`;
CREATE TABLE `examination`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_user` int(11) NULL DEFAULT NULL,
  `from_user` int(11) NULL DEFAULT NULL,
  `test_id` int(11) NULL DEFAULT NULL,
  `time` int(11) NULL DEFAULT NULL,
  `startTime` datetime(0) NULL DEFAULT NULL,
  `endTime` datetime(0) NULL DEFAULT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `is_join` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `from_user`(`from_user`) USING BTREE,
  INDEX `test_id`(`test_id`) USING BTREE,
  INDEX `to_user`(`to_user`) USING BTREE,
  INDEX `ix_examination_endTime`(`endTime`) USING BTREE,
  INDEX `ix_examination_startTime`(`startTime`) USING BTREE,
  CONSTRAINT `examination_ibfk_1` FOREIGN KEY (`from_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_ibfk_3` FOREIGN KEY (`to_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examination
-- ----------------------------
INSERT INTO `examination` VALUES (1, 1, 1, 1, 10, '2020-04-16 00:00:00', '2020-04-21 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (2, 2, 1, 1, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 0);
INSERT INTO `examination` VALUES (3, 3, 1, 1, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 0);
INSERT INTO `examination` VALUES (4, 4, 1, 1, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (5, 2, 2, 2, 10, '2020-04-16 00:00:00', '2020-05-05 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (6, 1, 2, 2, 10, '2020-04-16 00:00:00', '2020-05-16 23:00:00', 20, 1);
INSERT INTO `examination` VALUES (7, 3, 2, 2, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (8, 4, 2, 2, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (9, 1, 1, 3, 10, '2020-04-16 00:00:00', '2020-05-17 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (10, 2, 1, 3, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (11, 3, 1, 3, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (12, 4, 1, 3, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (13, 2, 2, 1, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (14, 1, 2, 1, 10, '2020-05-01 00:00:00', '2020-05-20 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (15, 3, 2, 1, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 0);
INSERT INTO `examination` VALUES (16, 4, 2, 1, 10, '2020-04-16 00:00:00', '2020-04-30 00:00:00', 20, 1);
INSERT INTO `examination` VALUES (18, 4, 4, 4, 10, '2020-05-13 00:09:00', '2020-05-31 23:55:00', 10, 1);
INSERT INTO `examination` VALUES (19, 3, 4, 4, 10, '2020-05-13 00:09:00', '2020-05-31 23:55:00', 10, 0);
INSERT INTO `examination` VALUES (20, 2, 4, 4, 10, '2020-05-13 00:09:00', '2020-05-31 23:55:00', 10, 0);
INSERT INTO `examination` VALUES (21, 1, 4, 4, 10, '2020-05-13 00:09:00', '2020-05-31 23:55:00', 10, 0);
INSERT INTO `examination` VALUES (22, 7, 7, 5, 10, '2020-05-15 07:36:00', '2020-05-31 07:35:00', 20, 1);
INSERT INTO `examination` VALUES (23, 2, 7, 5, 10, '2020-05-15 07:36:00', '2020-05-31 07:35:00', 20, 0);
INSERT INTO `examination` VALUES (24, 5, 7, 5, 10, '2020-05-15 07:36:00', '2020-05-31 07:35:00', 20, 1);
INSERT INTO `examination` VALUES (25, 8, 8, 6, 10, '2020-05-15 16:44:00', '2020-05-31 19:50:00', 5, 1);
INSERT INTO `examination` VALUES (26, 5, 8, 6, 10, '2020-05-15 16:44:00', '2020-05-31 19:50:00', 5, 0);
INSERT INTO `examination` VALUES (27, 2, 8, 6, 10, '2020-05-15 16:44:00', '2020-05-31 19:50:00', 5, 0);
INSERT INTO `examination` VALUES (28, 4, 8, 6, 10, '2020-05-15 16:44:00', '2020-05-31 19:50:00', 5, 0);
INSERT INTO `examination` VALUES (29, 9, 9, 7, 10, '2020-05-15 17:55:00', '2020-05-31 22:55:00', 5, 1);
INSERT INTO `examination` VALUES (30, 5, 9, 7, 10, '2020-05-15 17:55:00', '2020-05-31 22:55:00', 5, 0);
INSERT INTO `examination` VALUES (31, 2, 9, 7, 10, '2020-05-15 17:55:00', '2020-05-31 22:55:00', 5, 1);

-- ----------------------------
-- Table structure for examination_result
-- ----------------------------
DROP TABLE IF EXISTS `examination_result`;
CREATE TABLE `examination_result`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `to_user` int(11) NULL DEFAULT NULL,
  `from_user` int(11) NULL DEFAULT NULL,
  `test_name` int(11) NULL DEFAULT NULL,
  `time` int(11) NULL DEFAULT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `from_user`(`from_user`) USING BTREE,
  INDEX `test_name`(`test_name`) USING BTREE,
  INDEX `to_user`(`to_user`) USING BTREE,
  CONSTRAINT `examination_result_ibfk_1` FOREIGN KEY (`from_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_result_ibfk_2` FOREIGN KEY (`test_name`) REFERENCES `test` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examination_result_ibfk_3` FOREIGN KEY (`to_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examination_result
-- ----------------------------
INSERT INTO `examination_result` VALUES (1, '1587048633841', 4, 1, 1, 4, 4, 35);
INSERT INTO `examination_result` VALUES (2, '1587049840219', 1, 2, 2, 6, 6, 35);
INSERT INTO `examination_result` VALUES (3, '1587350528938', 2, 1, 3, 10, 10, 10);
INSERT INTO `examination_result` VALUES (4, '1587395170420', 3, 1, 3, 11, 11, 45);
INSERT INTO `examination_result` VALUES (5, '1587395509647', 4, 1, 3, 12, 12, 50);
INSERT INTO `examination_result` VALUES (6, '1587797164097', 4, 1, 1, 4, 4, 25);
INSERT INTO `examination_result` VALUES (18, '1588149073817', 1, 2, 2, 6, 6, 0);
INSERT INTO `examination_result` VALUES (19, '1588148189199', 2, 2, 2, 5, 5, 0);
INSERT INTO `examination_result` VALUES (20, '1588228183497', 1, 1, 3, 9, 9, 0);
INSERT INTO `examination_result` VALUES (21, '1588228200201', 1, 1, 3, 9, 9, 0);
INSERT INTO `examination_result` VALUES (22, '1588238376153', 1, 2, 2, 6, 6, 0);
INSERT INTO `examination_result` VALUES (23, '1588518102294', 1, 2, 2, 6, 6, 15);
INSERT INTO `examination_result` VALUES (26, '1589299796725', 4, 4, 4, 18, 10, 50);
INSERT INTO `examination_result` VALUES (27, '1589300369772', 4, 4, 4, 170, 10, 80);
INSERT INTO `examination_result` VALUES (28, '1589532285257', 8, 8, 6, 66, 5, 3);
INSERT INTO `examination_result` VALUES (29, '1589532560420', 8, 8, 6, 43, 5, 80);
INSERT INTO `examination_result` VALUES (30, '1589536582404', 2, 9, 7, 29, 5, 20);

-- ----------------------------
-- Table structure for examinationdetail
-- ----------------------------
DROP TABLE IF EXISTS `examinationdetail`;
CREATE TABLE `examinationdetail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `test_id` int(11) NULL DEFAULT NULL,
  `question_id` int(11) NULL DEFAULT NULL,
  `answer` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `answer_post` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL,
  `is_true` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `question_id`(`question_id`) USING BTREE,
  INDEX `test_id`(`test_id`) USING BTREE,
  CONSTRAINT `examinationdetail_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `examinationdetail_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 544 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examinationdetail
-- ----------------------------
INSERT INTO `examinationdetail` VALUES (10, '1587048633841', 1, 62, ' 数据的运算', '运算', 0, 0);
INSERT INTO `examinationdetail` VALUES (11, '1587048633841', 1, 29, 'AB', 'AB', 5, 1);
INSERT INTO `examinationdetail` VALUES (12, '1587048633841', 1, 47, '1', '0', 0, 0);
INSERT INTO `examinationdetail` VALUES (13, '1587048633841', 1, 95, '线性表具有两种存储结构即顺序存储结构和链接存储结构。线性表的顺序存储结构可以直接存取数据元素，方便灵活、效率高，但插入、删除操作时将会引起元素的大量移动，因而降低效率：而在链接存储结构中内存采用动态分配，利用率高，但需增设指示结点之间关系的指针域，存取数据元素不如顺序存储方便，但结点的插入、删除操作较简单。', '无', 0, 0);
INSERT INTO `examinationdetail` VALUES (14, '1587048633841', 1, 66, '非线性', '非线性', 5, 1);
INSERT INTO `examinationdetail` VALUES (15, '1587048633841', 1, 96, '应选用链接存储结构，因为链式存储结构是用一组任意的存储单元依次存储线性表中的各元素，这里存储单元可以是连续的，也可以是不连续的：这种存储结构对于元素的删除或插入运算是不需要移动元素的，只需修改指针即可，所以很容易实现表的容量的扩充。', '链式存储', 0, 0);
INSERT INTO `examinationdetail` VALUES (16, '1587048633841', 1, 45, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (17, '1587048633841', 1, 18, 'A', 'A', 5, 1);
INSERT INTO `examinationdetail` VALUES (18, '1587048633841', 1, 5, 'B', 'B', 5, 1);
INSERT INTO `examinationdetail` VALUES (19, '1587048633841', 1, 11, 'A', 'A', 5, 1);
INSERT INTO `examinationdetail` VALUES (20, '1587048633841', 1, 42, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (21, '1587048633841', 1, 32, 'ABC', 'ABC', 5, 1);
INSERT INTO `examinationdetail` VALUES (22, '1587048633841', 1, 77, ' 数据项', '数据项', 5, 1);
INSERT INTO `examinationdetail` VALUES (23, '1587048633841', 1, 3, 'A', 'A', 5, 1);
INSERT INTO `examinationdetail` VALUES (24, '1587048633841', 1, 92, '循环链表的特点是表中尾节点的指针域不再是空，而是指向头节点，整个链表形成一个环。因此，从表中任一节点出发，均可找到链表中其他节点。', '插入删除方便', 0, 0);
INSERT INTO `examinationdetail` VALUES (25, '1587048633841', 1, 97, '应选用顺序存储结构，因为每个数据元素的存储位置和线性表的起始位置相差一个和数据元素在线性表中的序号成正比的常数。因此，只要确定了其起始位置，线性表中的任一个数据元素都可随机存取，因此，线性表的顺序存储结构是一种随机存取的存储结构，而链表则是一种顺序存取的存储结构。', '顺序存储', 0, 0);
INSERT INTO `examinationdetail` VALUES (26, '1587048633841', 1, 70, '非线性结构 ', '非线性结构', 0, 0);
INSERT INTO `examinationdetail` VALUES (27, '1587048633841', 1, 79, '所消耗的时间', '完成计算的时间', 0, 0);
INSERT INTO `examinationdetail` VALUES (28, '1587048633841', 1, 12, 'A', 'D', 0, 0);
INSERT INTO `examinationdetail` VALUES (29, '1587048633841', 1, 7, 'D', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (30, '1587049840219', 2, 92, '循环链表的特点是表中尾节点的指针域不再是空，而是指向头节点，整个链表形成一个环。因此，从表中任一节点出发，均可找到链表中其他节点。', '插入删除方便', 0, 0);
INSERT INTO `examinationdetail` VALUES (31, '1587049840219', 2, 4, 'D', 'D', 5, 1);
INSERT INTO `examinationdetail` VALUES (32, '1587049840219', 2, 29, 'AB', 'AB', 5, 1);
INSERT INTO `examinationdetail` VALUES (33, '1587049840219', 2, 21, 'D', 'D', 5, 1);
INSERT INTO `examinationdetail` VALUES (34, '1587049840219', 2, 26, 'AD', 'AD', 5, 1);
INSERT INTO `examinationdetail` VALUES (35, '1587049840219', 2, 62, ' 数据的运算', '数据运算', 0, 0);
INSERT INTO `examinationdetail` VALUES (36, '1587049840219', 2, 100, '第一，采用计数器来判断，空时，计数器为0，满时，计数器为maxsize；第二，另设一个布尔变量以匹别队列的空和满；第三，少用一个元素的空间，约定入队前，测试尾指针在循环意义下加1后是否等于头指针，若相等则认为队满（注意：rear所指的单元始终为空）；', '（rear+font）/M', 0, 0);
INSERT INTO `examinationdetail` VALUES (37, '1587049840219', 2, 90, '顺序表把线性表中所有元素按照其逻辑顺序依次存储到从计算机存储器中指定存储位置开始的一块连续的存储空间中。', '一个接一个', 0, 0);
INSERT INTO `examinationdetail` VALUES (38, '1587049840219', 2, 14, 'A', 'C', 0, 0);
INSERT INTO `examinationdetail` VALUES (39, '1587049840219', 2, 13, 'B', 'C', 0, 0);
INSERT INTO `examinationdetail` VALUES (40, '1587049840219', 2, 102, 'C', 'C', 5, 1);
INSERT INTO `examinationdetail` VALUES (41, '1587049840219', 2, 72, '任意', '相邻', 0, 0);
INSERT INTO `examinationdetail` VALUES (42, '1587049840219', 2, 6, 'C', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (43, '1587049840219', 2, 64, ' Data Structure =（D，S）', '数据项', 0, 0);
INSERT INTO `examinationdetail` VALUES (44, '1587049840219', 2, 22, 'A', 'A', 5, 1);
INSERT INTO `examinationdetail` VALUES (45, '1587049840219', 2, 79, '所消耗的时间', '完成计算的时间', 0, 0);
INSERT INTO `examinationdetail` VALUES (46, '1587049840219', 2, 97, '应选用顺序存储结构，因为每个数据元素的存储位置和线性表的起始位置相差一个和数据元素在线性表中的序号成正比的常数。因此，只要确定了其起始位置，线性表中的任一个数据元素都可随机存取，因此，线性表的顺序存储结构是一种随机存取的存储结构，而链表则是一种顺序存取的存储结构。', '顺序表', 0, 0);
INSERT INTO `examinationdetail` VALUES (47, '1587049840219', 2, 71, '连续 ', '相邻', 0, 0);
INSERT INTO `examinationdetail` VALUES (48, '1587049840219', 2, 42, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (49, '1587049840219', 2, 88, '算法分析从两方面考虑：时间复杂度与空间复杂度。', '时间复杂度和空间复杂度', 0, 0);
INSERT INTO `examinationdetail` VALUES (50, '1587350528938', 3, 42, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (51, '1587350528938', 3, 65, '存储结构', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (52, '1587350528938', 3, 84, '顺序存储结构是，把逻辑上相邻的节点存储在物理位置上相邻的存储单元里，节点间的逻辑关系由存储单元的邻接关系来体现。其存储地址一定连续；', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (53, '1587350528938', 3, 86, '逻辑结构与计算机实体无关，存储结构与计算机实体有关。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (54, '1587350528938', 3, 38, 'AD', 'ABC', 0, 0);
INSERT INTO `examinationdetail` VALUES (55, '1587350528938', 3, 23, 'AD', 'ABC', 0, 0);
INSERT INTO `examinationdetail` VALUES (56, '1587350528938', 3, 16, 'B', 'B', 5, 1);
INSERT INTO `examinationdetail` VALUES (57, '1587350528938', 3, 25, 'ABCD', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (58, '1587350528938', 3, 79, '所消耗的时间', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (59, '1587350528938', 3, 60, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (60, '1587350528938', 3, 56, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (61, '1587350528938', 3, 46, '1', '1', 5, 1);
INSERT INTO `examinationdetail` VALUES (62, '1587350528938', 3, 15, 'D', 'A', 0, 0);
INSERT INTO `examinationdetail` VALUES (63, '1587350528938', 3, 74, ' 一对多或多对多', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (64, '1587350528938', 3, 51, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (65, '1587350528938', 3, 83, '数据的逻辑结构是从逻辑关系上描述数据的，可以看作是从具体问题抽象出来的数学模型；数据的存储结构是逻辑结构用计算机语言的实现或在计算机中的表示，是逻辑结构在计算机中的存储方式。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (66, '1587350528938', 3, 8, 'C', 'A', 0, 0);
INSERT INTO `examinationdetail` VALUES (67, '1587350528938', 3, 99, '共有14种可能的出栈序列，即为:ABCD, ABDC，ACBD, ACDB，BACD，ADCB，BADC，BCAD, BCDA，BDCA,CBAD, CBDA，CDBA, DCBA', '测', 0, 0);
INSERT INTO `examinationdetail` VALUES (68, '1587350528938', 3, 95, '线性表具有两种存储结构即顺序存储结构和链接存储结构。线性表的顺序存储结构可以直接存取数据元素，方便灵活、效率高，但插入、删除操作时将会引起元素的大量移动，因而降低效率：而在链接存储结构中内存采用动态分配，利用率高，但需增设指示结点之间关系的指针域，存取数据元素不如顺序存储方便，但结点的插入、删除操作较简单。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (69, '1587350528938', 3, 20, 'B', 'A', 0, 0);
INSERT INTO `examinationdetail` VALUES (70, '1587395170420', 3, 42, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (71, '1587395170420', 3, 65, '存储结构', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (72, '1587395170420', 3, 84, '顺序存储结构是，把逻辑上相邻的节点存储在物理位置上相邻的存储单元里，节点间的逻辑关系由存储单元的邻接关系来体现。其存储地址一定连续；', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (73, '1587395170420', 3, 86, '逻辑结构与计算机实体无关，存储结构与计算机实体有关。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (74, '1587395170420', 3, 38, 'AD', 'AD', 5, 1);
INSERT INTO `examinationdetail` VALUES (75, '1587395170420', 3, 23, 'AD', 'AD', 5, 1);
INSERT INTO `examinationdetail` VALUES (76, '1587395170420', 3, 16, 'B', 'B', 5, 1);
INSERT INTO `examinationdetail` VALUES (77, '1587395170420', 3, 25, 'ABCD', 'BD', 0, 0);
INSERT INTO `examinationdetail` VALUES (78, '1587395170420', 3, 79, '所消耗的时间', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (79, '1587395170420', 3, 60, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (80, '1587395170420', 3, 56, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (81, '1587395170420', 3, 46, '1', '0', 0, 0);
INSERT INTO `examinationdetail` VALUES (82, '1587395170420', 3, 15, 'D', 'D', 5, 1);
INSERT INTO `examinationdetail` VALUES (83, '1587395170420', 3, 74, ' 一对多或多对多', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (84, '1587395170420', 3, 51, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (85, '1587395170420', 3, 83, '数据的逻辑结构是从逻辑关系上描述数据的，可以看作是从具体问题抽象出来的数学模型；数据的存储结构是逻辑结构用计算机语言的实现或在计算机中的表示，是逻辑结构在计算机中的存储方式。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (86, '1587395170420', 3, 8, 'C', 'C', 5, 1);
INSERT INTO `examinationdetail` VALUES (87, '1587395170420', 3, 99, '共有14种可能的出栈序列，即为:ABCD, ABDC，ACBD, ACDB，BACD，ADCB，BADC，BCAD, BCDA，BDCA,CBAD, CBDA，CDBA, DCBA', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (88, '1587395170420', 3, 95, '线性表具有两种存储结构即顺序存储结构和链接存储结构。线性表的顺序存储结构可以直接存取数据元素，方便灵活、效率高，但插入、删除操作时将会引起元素的大量移动，因而降低效率：而在链接存储结构中内存采用动态分配，利用率高，但需增设指示结点之间关系的指针域，存取数据元素不如顺序存储方便，但结点的插入、删除操作较简单。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (89, '1587395170420', 3, 20, 'B', 'C', 0, 0);
INSERT INTO `examinationdetail` VALUES (90, '1587395509647', 3, 42, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (91, '1587395509647', 3, 65, '存储结构', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (92, '1587395509647', 3, 84, '顺序存储结构是，把逻辑上相邻的节点存储在物理位置上相邻的存储单元里，节点间的逻辑关系由存储单元的邻接关系来体现。其存储地址一定连续；', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (93, '1587395509647', 3, 86, '逻辑结构与计算机实体无关，存储结构与计算机实体有关。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (94, '1587395509647', 3, 38, 'AD', 'AD', 5, 1);
INSERT INTO `examinationdetail` VALUES (95, '1587395509647', 3, 23, 'AD', 'AD', 5, 1);
INSERT INTO `examinationdetail` VALUES (96, '1587395509647', 3, 16, 'B', 'B', 5, 1);
INSERT INTO `examinationdetail` VALUES (97, '1587395509647', 3, 25, 'ABCD', 'ABCD', 5, 1);
INSERT INTO `examinationdetail` VALUES (98, '1587395509647', 3, 79, '所消耗的时间', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (99, '1587395509647', 3, 60, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (100, '1587395509647', 3, 56, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (101, '1587395509647', 3, 46, '1', '1', 5, 1);
INSERT INTO `examinationdetail` VALUES (102, '1587395509647', 3, 15, 'D', 'D', 5, 1);
INSERT INTO `examinationdetail` VALUES (103, '1587395509647', 3, 74, ' 一对多或多对多', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (104, '1587395509647', 3, 51, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (105, '1587395509647', 3, 83, '数据的逻辑结构是从逻辑关系上描述数据的，可以看作是从具体问题抽象出来的数学模型；数据的存储结构是逻辑结构用计算机语言的实现或在计算机中的表示，是逻辑结构在计算机中的存储方式。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (106, '1587395509647', 3, 8, 'C', 'C', 5, 1);
INSERT INTO `examinationdetail` VALUES (107, '1587395509647', 3, 99, '共有14种可能的出栈序列，即为:ABCD, ABDC，ACBD, ACDB，BACD，ADCB，BADC，BCAD, BCDA，BDCA,CBAD, CBDA，CDBA, DCBA', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (108, '1587395509647', 3, 95, '线性表具有两种存储结构即顺序存储结构和链接存储结构。线性表的顺序存储结构可以直接存取数据元素，方便灵活、效率高，但插入、删除操作时将会引起元素的大量移动，因而降低效率：而在链接存储结构中内存采用动态分配，利用率高，但需增设指示结点之间关系的指针域，存取数据元素不如顺序存储方便，但结点的插入、删除操作较简单。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (109, '1587395509647', 3, 20, 'B', 'C', 0, 0);
INSERT INTO `examinationdetail` VALUES (110, '1587797164097', 1, 62, ' 数据的运算', '数据的运算', 0, 0);
INSERT INTO `examinationdetail` VALUES (111, '1587797164097', 1, 29, 'AB', 'AB', 5, 1);
INSERT INTO `examinationdetail` VALUES (112, '1587797164097', 1, 47, '1', '0', 0, 0);
INSERT INTO `examinationdetail` VALUES (113, '1587797164097', 1, 95, '线性表具有两种存储结构即顺序存储结构和链接存储结构。线性表的顺序存储结构可以直接存取数据元素，方便灵活、效率高，但插入、删除操作时将会引起元素的大量移动，因而降低效率：而在链接存储结构中内存采用动态分配，利用率高，但需增设指示结点之间关系的指针域，存取数据元素不如顺序存储方便，但结点的插入、删除操作较简单。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (114, '1587797164097', 1, 66, '非线性', '非线性结构', 0, 0);
INSERT INTO `examinationdetail` VALUES (115, '1587797164097', 1, 96, '应选用链接存储结构，因为链式存储结构是用一组任意的存储单元依次存储线性表中的各元素，这里存储单元可以是连续的，也可以是不连续的：这种存储结构对于元素的删除或插入运算是不需要移动元素的，只需修改指针即可，所以很容易实现表的容量的扩充。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (116, '1587797164097', 1, 45, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (117, '1587797164097', 1, 18, 'A', 'A', 5, 1);
INSERT INTO `examinationdetail` VALUES (118, '1587797164097', 1, 5, 'B', 'B', 5, 1);
INSERT INTO `examinationdetail` VALUES (119, '1587797164097', 1, 11, 'A', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (120, '1587797164097', 1, 42, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (121, '1587797164097', 1, 32, 'ABC', 'ABCD', 0, 0);
INSERT INTO `examinationdetail` VALUES (122, '1587797164097', 1, 77, ' 数据项', '数据项', 0, 0);
INSERT INTO `examinationdetail` VALUES (123, '1587797164097', 1, 3, 'A', 'A', 5, 1);
INSERT INTO `examinationdetail` VALUES (124, '1587797164097', 1, 92, '循环链表的特点是表中尾节点的指针域不再是空，而是指向头节点，整个链表形成一个环。因此，从表中任一节点出发，均可找到链表中其他节点。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (125, '1587797164097', 1, 97, '应选用顺序存储结构，因为每个数据元素的存储位置和线性表的起始位置相差一个和数据元素在线性表中的序号成正比的常数。因此，只要确定了其起始位置，线性表中的任一个数据元素都可随机存取，因此，线性表的顺序存储结构是一种随机存取的存储结构，而链表则是一种顺序存取的存储结构。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (126, '1587797164097', 1, 70, '非线性结构 ', '非线性结构', 0, 0);
INSERT INTO `examinationdetail` VALUES (127, '1587797164097', 1, 79, '所消耗的时间', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (128, '1587797164097', 1, 12, 'A', 'C', 0, 0);
INSERT INTO `examinationdetail` VALUES (129, '1587797164097', 1, 7, 'D', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (350, '1588149073817', 2, 92, '循环链表的特点是表中尾节点的指针域不再是空，而是指向头节点，整个链表形成一个环。因此，从表中任一节点出发，均可找到链表中其他节点。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (351, '1588149073817', 2, 4, 'D', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (352, '1588149073817', 2, 29, 'AB', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (353, '1588149073817', 2, 21, 'D', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (354, '1588149073817', 2, 26, 'AD', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (355, '1588149073817', 2, 62, ' 数据的运算', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (356, '1588149073817', 2, 100, '第一，采用计数器来判断，空时，计数器为0，满时，计数器为maxsize；第二，另设一个布尔变量以匹别队列的空和满；第三，少用一个元素的空间，约定入队前，测试尾指针在循环意义下加1后是否等于头指针，若相等则认为队满（注意：rear所指的单元始终为空）；', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (357, '1588149073817', 2, 90, '顺序表把线性表中所有元素按照其逻辑顺序依次存储到从计算机存储器中指定存储位置开始的一块连续的存储空间中。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (358, '1588149073817', 2, 14, 'A', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (359, '1588149073817', 2, 13, 'B', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (360, '1588149073817', 2, 102, 'C', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (361, '1588149073817', 2, 72, '任意', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (362, '1588149073817', 2, 6, 'C', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (363, '1588149073817', 2, 64, ' Data Structure =（D，S）', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (364, '1588149073817', 2, 22, 'A', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (365, '1588149073817', 2, 79, '所消耗的时间', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (366, '1588149073817', 2, 97, '应选用顺序存储结构，因为每个数据元素的存储位置和线性表的起始位置相差一个和数据元素在线性表中的序号成正比的常数。因此，只要确定了其起始位置，线性表中的任一个数据元素都可随机存取，因此，线性表的顺序存储结构是一种随机存取的存储结构，而链表则是一种顺序存取的存储结构。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (367, '1588149073817', 2, 71, '连续 ', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (368, '1588149073817', 2, 42, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (369, '1588149073817', 2, 88, '算法分析从两方面考虑：时间复杂度与空间复杂度。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (370, '1588148189199', 2, 92, '循环链表的特点是表中尾节点的指针域不再是空，而是指向头节点，整个链表形成一个环。因此，从表中任一节点出发，均可找到链表中其他节点。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (371, '1588148189199', 2, 4, 'D', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (372, '1588148189199', 2, 29, 'AB', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (373, '1588148189199', 2, 21, 'D', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (374, '1588148189199', 2, 26, 'AD', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (375, '1588148189199', 2, 62, ' 数据的运算', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (376, '1588148189199', 2, 100, '第一，采用计数器来判断，空时，计数器为0，满时，计数器为maxsize；第二，另设一个布尔变量以匹别队列的空和满；第三，少用一个元素的空间，约定入队前，测试尾指针在循环意义下加1后是否等于头指针，若相等则认为队满（注意：rear所指的单元始终为空）；', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (377, '1588148189199', 2, 90, '顺序表把线性表中所有元素按照其逻辑顺序依次存储到从计算机存储器中指定存储位置开始的一块连续的存储空间中。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (378, '1588148189199', 2, 14, 'A', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (379, '1588148189199', 2, 13, 'B', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (380, '1588148189199', 2, 102, 'C', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (381, '1588148189199', 2, 72, '任意', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (382, '1588148189199', 2, 6, 'C', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (383, '1588148189199', 2, 64, ' Data Structure =（D，S）', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (384, '1588148189199', 2, 22, 'A', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (385, '1588148189199', 2, 79, '所消耗的时间', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (386, '1588148189199', 2, 97, '应选用顺序存储结构，因为每个数据元素的存储位置和线性表的起始位置相差一个和数据元素在线性表中的序号成正比的常数。因此，只要确定了其起始位置，线性表中的任一个数据元素都可随机存取，因此，线性表的顺序存储结构是一种随机存取的存储结构，而链表则是一种顺序存取的存储结构。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (387, '1588148189199', 2, 71, '连续 ', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (388, '1588148189199', 2, 42, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (389, '1588148189199', 2, 88, '算法分析从两方面考虑：时间复杂度与空间复杂度。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (390, '1588228183497', 3, 42, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (391, '1588228183497', 3, 65, '存储结构', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (392, '1588228183497', 3, 84, '顺序存储结构是，把逻辑上相邻的节点存储在物理位置上相邻的存储单元里，节点间的逻辑关系由存储单元的邻接关系来体现。其存储地址一定连续；', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (393, '1588228183497', 3, 86, '逻辑结构与计算机实体无关，存储结构与计算机实体有关。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (394, '1588228183497', 3, 38, 'AD', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (395, '1588228183497', 3, 23, 'AD', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (396, '1588228183497', 3, 16, 'B', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (397, '1588228183497', 3, 25, 'ABCD', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (398, '1588228183497', 3, 79, '所消耗的时间', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (399, '1588228183497', 3, 60, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (400, '1588228183497', 3, 56, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (401, '1588228183497', 3, 46, '1', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (402, '1588228183497', 3, 15, 'D', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (403, '1588228183497', 3, 74, ' 一对多或多对多', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (404, '1588228183497', 3, 51, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (405, '1588228183497', 3, 83, '数据的逻辑结构是从逻辑关系上描述数据的，可以看作是从具体问题抽象出来的数学模型；数据的存储结构是逻辑结构用计算机语言的实现或在计算机中的表示，是逻辑结构在计算机中的存储方式。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (406, '1588228183497', 3, 8, 'C', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (407, '1588228183497', 3, 99, '共有14种可能的出栈序列，即为:ABCD, ABDC，ACBD, ACDB，BACD，ADCB，BADC，BCAD, BCDA，BDCA,CBAD, CBDA，CDBA, DCBA', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (408, '1588228183497', 3, 95, '线性表具有两种存储结构即顺序存储结构和链接存储结构。线性表的顺序存储结构可以直接存取数据元素，方便灵活、效率高，但插入、删除操作时将会引起元素的大量移动，因而降低效率：而在链接存储结构中内存采用动态分配，利用率高，但需增设指示结点之间关系的指针域，存取数据元素不如顺序存储方便，但结点的插入、删除操作较简单。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (409, '1588228183497', 3, 20, 'B', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (410, '1588228200201', 3, 42, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (411, '1588228200201', 3, 65, '存储结构', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (412, '1588228200201', 3, 84, '顺序存储结构是，把逻辑上相邻的节点存储在物理位置上相邻的存储单元里，节点间的逻辑关系由存储单元的邻接关系来体现。其存储地址一定连续；', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (413, '1588228200201', 3, 86, '逻辑结构与计算机实体无关，存储结构与计算机实体有关。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (414, '1588228200201', 3, 38, 'AD', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (415, '1588228200201', 3, 23, 'AD', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (416, '1588228200201', 3, 16, 'B', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (417, '1588228200201', 3, 25, 'ABCD', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (418, '1588228200201', 3, 79, '所消耗的时间', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (419, '1588228200201', 3, 60, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (420, '1588228200201', 3, 56, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (421, '1588228200201', 3, 46, '1', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (422, '1588228200201', 3, 15, 'D', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (423, '1588228200201', 3, 74, ' 一对多或多对多', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (424, '1588228200201', 3, 51, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (425, '1588228200201', 3, 83, '数据的逻辑结构是从逻辑关系上描述数据的，可以看作是从具体问题抽象出来的数学模型；数据的存储结构是逻辑结构用计算机语言的实现或在计算机中的表示，是逻辑结构在计算机中的存储方式。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (426, '1588228200201', 3, 8, 'C', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (427, '1588228200201', 3, 99, '共有14种可能的出栈序列，即为:ABCD, ABDC，ACBD, ACDB，BACD，ADCB，BADC，BCAD, BCDA，BDCA,CBAD, CBDA，CDBA, DCBA', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (428, '1588228200201', 3, 95, '线性表具有两种存储结构即顺序存储结构和链接存储结构。线性表的顺序存储结构可以直接存取数据元素，方便灵活、效率高，但插入、删除操作时将会引起元素的大量移动，因而降低效率：而在链接存储结构中内存采用动态分配，利用率高，但需增设指示结点之间关系的指针域，存取数据元素不如顺序存储方便，但结点的插入、删除操作较简单。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (429, '1588228200201', 3, 20, 'B', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (430, '1588238376153', 2, 92, '循环链表的特点是表中尾节点的指针域不再是空，而是指向头节点，整个链表形成一个环。因此，从表中任一节点出发，均可找到链表中其他节点。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (431, '1588238376153', 2, 4, 'D', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (432, '1588238376153', 2, 29, 'AB', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (433, '1588238376153', 2, 21, 'D', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (434, '1588238376153', 2, 26, 'AD', 'C', 0, 0);
INSERT INTO `examinationdetail` VALUES (435, '1588238376153', 2, 62, ' 数据的运算', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (436, '1588238376153', 2, 100, '第一，采用计数器来判断，空时，计数器为0，满时，计数器为maxsize；第二，另设一个布尔变量以匹别队列的空和满；第三，少用一个元素的空间，约定入队前，测试尾指针在循环意义下加1后是否等于头指针，若相等则认为队满（注意：rear所指的单元始终为空）；', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (437, '1588238376153', 2, 90, '顺序表把线性表中所有元素按照其逻辑顺序依次存储到从计算机存储器中指定存储位置开始的一块连续的存储空间中。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (438, '1588238376153', 2, 14, 'A', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (439, '1588238376153', 2, 13, 'B', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (440, '1588238376153', 2, 102, 'C', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (441, '1588238376153', 2, 72, '任意', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (442, '1588238376153', 2, 6, 'C', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (443, '1588238376153', 2, 64, ' Data Structure =（D，S）', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (444, '1588238376153', 2, 22, 'A', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (445, '1588238376153', 2, 79, '所消耗的时间', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (446, '1588238376153', 2, 97, '应选用顺序存储结构，因为每个数据元素的存储位置和线性表的起始位置相差一个和数据元素在线性表中的序号成正比的常数。因此，只要确定了其起始位置，线性表中的任一个数据元素都可随机存取，因此，线性表的顺序存储结构是一种随机存取的存储结构，而链表则是一种顺序存取的存储结构。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (447, '1588238376153', 2, 71, '连续 ', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (448, '1588238376153', 2, 42, '0', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (449, '1588238376153', 2, 88, '算法分析从两方面考虑：时间复杂度与空间复杂度。', '', 0, 0);
INSERT INTO `examinationdetail` VALUES (450, '1588518102294', 2, 92, '循环链表的特点是表中尾节点的指针域不再是空，而是指向头节点，整个链表形成一个环。因此，从表中任一节点出发，均可找到链表中其他节点。', '十大', 0, 0);
INSERT INTO `examinationdetail` VALUES (451, '1588518102294', 2, 4, 'D', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (452, '1588518102294', 2, 29, 'AB', 'A', 0, 0);
INSERT INTO `examinationdetail` VALUES (453, '1588518102294', 2, 21, 'D', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (454, '1588518102294', 2, 26, 'AD', 'BC', 0, 0);
INSERT INTO `examinationdetail` VALUES (455, '1588518102294', 2, 62, ' 数据的运算', '数据的运算', 0, 0);
INSERT INTO `examinationdetail` VALUES (456, '1588518102294', 2, 100, '第一，采用计数器来判断，空时，计数器为0，满时，计数器为maxsize；第二，另设一个布尔变量以匹别队列的空和满；第三，少用一个元素的空间，约定入队前，测试尾指针在循环意义下加1后是否等于头指针，若相等则认为队满（注意：rear所指的单元始终为空）；', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (457, '1588518102294', 2, 90, '顺序表把线性表中所有元素按照其逻辑顺序依次存储到从计算机存储器中指定存储位置开始的一块连续的存储空间中。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (458, '1588518102294', 2, 14, 'A', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (459, '1588518102294', 2, 13, 'B', 'B', 5, 1);
INSERT INTO `examinationdetail` VALUES (460, '1588518102294', 2, 102, 'C', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (461, '1588518102294', 2, 72, '任意', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (462, '1588518102294', 2, 6, 'C', 'C', 5, 1);
INSERT INTO `examinationdetail` VALUES (463, '1588518102294', 2, 64, ' Data Structure =（D，S）', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (464, '1588518102294', 2, 22, 'A', 'B', 0, 0);
INSERT INTO `examinationdetail` VALUES (465, '1588518102294', 2, 79, '所消耗的时间', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (466, '1588518102294', 2, 97, '应选用顺序存储结构，因为每个数据元素的存储位置和线性表的起始位置相差一个和数据元素在线性表中的序号成正比的常数。因此，只要确定了其起始位置，线性表中的任一个数据元素都可随机存取，因此，线性表的顺序存储结构是一种随机存取的存储结构，而链表则是一种顺序存取的存储结构。', '测', 0, 0);
INSERT INTO `examinationdetail` VALUES (467, '1588518102294', 2, 71, '连续 ', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (468, '1588518102294', 2, 42, '0', '0', 5, 1);
INSERT INTO `examinationdetail` VALUES (469, '1588518102294', 2, 88, '算法分析从两方面考虑：时间复杂度与空间复杂度。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (510, '1589299796725', 4, 4, 'D', 'D', 10, 1);
INSERT INTO `examinationdetail` VALUES (511, '1589299796725', 4, 5, 'B', 'B', 10, 1);
INSERT INTO `examinationdetail` VALUES (512, '1589299796725', 4, 24, 'ABCD', 'ABCD', 10, 1);
INSERT INTO `examinationdetail` VALUES (513, '1589299796725', 4, 31, 'AC', 'AD', 0, 0);
INSERT INTO `examinationdetail` VALUES (514, '1589299796725', 4, 48, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (515, '1589299796725', 4, 63, '算法', '数据运算', 0, 0);
INSERT INTO `examinationdetail` VALUES (516, '1589299796725', 4, 66, '非线性', '非线性结构', 0, 0);
INSERT INTO `examinationdetail` VALUES (517, '1589299796725', 4, 82, '数据的逻辑结构、数据的存储结构、数据的运算。', '数据的逻辑结构，存储结构，运算，', 10, 1);
INSERT INTO `examinationdetail` VALUES (518, '1589299796725', 4, 88, '时间复杂度与空间复杂度。', '时间复杂度和空间复杂度', 10, 1);
INSERT INTO `examinationdetail` VALUES (519, '1589299796725', 4, 58, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (520, '1589300369772', 4, 4, 'D', 'D', 10, 1);
INSERT INTO `examinationdetail` VALUES (521, '1589300369772', 4, 5, 'B', 'B', 10, 1);
INSERT INTO `examinationdetail` VALUES (522, '1589300369772', 4, 24, 'ABCD', 'ABCD', 10, 1);
INSERT INTO `examinationdetail` VALUES (523, '1589300369772', 4, 31, 'AC', 'AC', 10, 1);
INSERT INTO `examinationdetail` VALUES (524, '1589300369772', 4, 48, '0', '0', 10, 1);
INSERT INTO `examinationdetail` VALUES (525, '1589300369772', 4, 63, '算法', '运算', 0, 0);
INSERT INTO `examinationdetail` VALUES (526, '1589300369772', 4, 66, '非线性', '非线性', 10, 1);
INSERT INTO `examinationdetail` VALUES (527, '1589300369772', 4, 82, '数据的逻辑结构、数据的存储结构、数据的运算。', '数据的逻辑结构，存储结构，运算', 10, 1);
INSERT INTO `examinationdetail` VALUES (528, '1589300369772', 4, 88, '时间复杂度与空间复杂度。', '时间复杂度和空间复杂度', 10, 1);
INSERT INTO `examinationdetail` VALUES (529, '1589300369772', 4, 58, '0', '1', 0, 0);
INSERT INTO `examinationdetail` VALUES (530, '1589532285257', 6, 83, '数据的逻辑结构是从逻辑关系上描述数据的，可以看作是从具体问题抽象出来的数学模型；数据的存储结构是逻辑结构用计算机语言的实现或在计算机中的表示，是逻辑结构在计算机中的存储方式。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (531, '1589532285257', 6, 2, 'D', 'C', 0, 0);
INSERT INTO `examinationdetail` VALUES (532, '1589532285257', 6, 80, '确定性', '确定性', 1, 1);
INSERT INTO `examinationdetail` VALUES (533, '1589532285257', 6, 3, 'A', 'A', 1, 1);
INSERT INTO `examinationdetail` VALUES (534, '1589532285257', 6, 4, 'D', 'D', 1, 1);
INSERT INTO `examinationdetail` VALUES (535, '1589532560420', 6, 83, '数据的逻辑结构是从逻辑关系上描述数据的，可以看作是从具体问题抽象出来的数学模型；数据的存储结构是逻辑结构用计算机语言的实现或在计算机中的表示，是逻辑结构在计算机中的存储方式。', '测试', 0, 0);
INSERT INTO `examinationdetail` VALUES (536, '1589532560420', 6, 2, 'D', 'D', 20, 1);
INSERT INTO `examinationdetail` VALUES (537, '1589532560420', 6, 80, '确定性', '确定性', 20, 1);
INSERT INTO `examinationdetail` VALUES (538, '1589532560420', 6, 3, 'A', 'A', 20, 1);
INSERT INTO `examinationdetail` VALUES (539, '1589532560420', 6, 4, 'D', 'D', 20, 1);
INSERT INTO `examinationdetail` VALUES (540, '1589536582404', 7, 2, 'D', 'C', 0, 0);
INSERT INTO `examinationdetail` VALUES (541, '1589536582404', 7, 15, 'D', 'D', 20, 1);
INSERT INTO `examinationdetail` VALUES (542, '1589536582404', 7, 30, 'BC', 'ABD', 0, 0);
INSERT INTO `examinationdetail` VALUES (543, '1589536582404', 7, 39, 'ABD', 'BC', 0, 0);
INSERT INTO `examinationdetail` VALUES (544, '1589536582404', 7, 48, '0', '1', 0, 0);

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `self_id` int(11) NULL DEFAULT NULL,
  `friend_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `friend_id`(`friend_id`) USING BTREE,
  INDEX `self_id`(`self_id`) USING BTREE,
  CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`friend_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`self_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friends
-- ----------------------------
INSERT INTO `friends` VALUES (1, 2, 1);
INSERT INTO `friends` VALUES (2, 1, 2);
INSERT INTO `friends` VALUES (3, 3, 2);
INSERT INTO `friends` VALUES (4, 2, 3);
INSERT INTO `friends` VALUES (5, 3, 1);
INSERT INTO `friends` VALUES (6, 1, 3);
INSERT INTO `friends` VALUES (9, 3, 4);
INSERT INTO `friends` VALUES (10, 4, 3);
INSERT INTO `friends` VALUES (11, 2, 4);
INSERT INTO `friends` VALUES (12, 4, 2);
INSERT INTO `friends` VALUES (13, 1, 5);
INSERT INTO `friends` VALUES (14, 5, 1);
INSERT INTO `friends` VALUES (17, 4, 1);
INSERT INTO `friends` VALUES (18, 1, 4);
INSERT INTO `friends` VALUES (19, 7, 2);
INSERT INTO `friends` VALUES (20, 2, 7);
INSERT INTO `friends` VALUES (21, 7, 5);
INSERT INTO `friends` VALUES (22, 5, 7);
INSERT INTO `friends` VALUES (23, 8, 5);
INSERT INTO `friends` VALUES (24, 5, 8);
INSERT INTO `friends` VALUES (25, 8, 2);
INSERT INTO `friends` VALUES (26, 2, 8);
INSERT INTO `friends` VALUES (27, 8, 4);
INSERT INTO `friends` VALUES (28, 4, 8);
INSERT INTO `friends` VALUES (29, 9, 5);
INSERT INTO `friends` VALUES (30, 5, 9);
INSERT INTO `friends` VALUES (31, 9, 2);
INSERT INTO `friends` VALUES (32, 2, 9);

-- ----------------------------
-- Table structure for loginlog
-- ----------------------------
DROP TABLE IF EXISTS `loginlog`;
CREATE TABLE `loginlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_loginlog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `loginlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of loginlog
-- ----------------------------
INSERT INTO `loginlog` VALUES (1, 1, '127.0.0.1', '2020-04-16 18:17:49');
INSERT INTO `loginlog` VALUES (2, 1, '127.0.0.1', '2020-04-16 18:26:15');
INSERT INTO `loginlog` VALUES (3, 2, '127.0.0.1', '2020-04-16 18:32:55');
INSERT INTO `loginlog` VALUES (4, 2, '127.0.0.1', '2020-04-16 18:34:14');
INSERT INTO `loginlog` VALUES (5, 1, '127.0.0.1', '2020-04-16 18:43:12');
INSERT INTO `loginlog` VALUES (6, 1, '127.0.0.1', '2020-04-16 21:19:34');
INSERT INTO `loginlog` VALUES (7, 2, '127.0.0.1', '2020-04-16 22:19:52');
INSERT INTO `loginlog` VALUES (8, 1, '127.0.0.1', '2020-04-16 22:28:53');
INSERT INTO `loginlog` VALUES (9, 3, '127.0.0.1', '2020-04-16 22:32:45');
INSERT INTO `loginlog` VALUES (10, 1, '127.0.0.1', '2020-04-16 22:34:14');
INSERT INTO `loginlog` VALUES (11, 2, '127.0.0.1', '2020-04-16 22:37:43');
INSERT INTO `loginlog` VALUES (12, 3, '127.0.0.1', '2020-04-16 22:39:20');
INSERT INTO `loginlog` VALUES (13, 4, '127.0.0.1', '2020-04-16 22:39:52');
INSERT INTO `loginlog` VALUES (14, 2, '127.0.0.1', '2020-04-16 23:07:53');
INSERT INTO `loginlog` VALUES (15, 1, '127.0.0.1', '2020-04-16 23:10:30');
INSERT INTO `loginlog` VALUES (16, 1, '127.0.0.1', '2020-04-20 10:35:59');
INSERT INTO `loginlog` VALUES (17, 2, '127.0.0.1', '2020-04-20 10:41:57');
INSERT INTO `loginlog` VALUES (18, 1, '127.0.0.1', '2020-04-20 10:44:09');
INSERT INTO `loginlog` VALUES (19, 1, '127.0.0.1', '2020-04-20 22:57:33');
INSERT INTO `loginlog` VALUES (20, 3, '127.0.0.1', '2020-04-20 23:05:54');
INSERT INTO `loginlog` VALUES (21, 4, '127.0.0.1', '2020-04-20 23:11:23');
INSERT INTO `loginlog` VALUES (22, 1, '127.0.0.1', '2020-04-20 23:19:12');
INSERT INTO `loginlog` VALUES (23, 1, '127.0.0.1', '2020-04-23 19:43:32');
INSERT INTO `loginlog` VALUES (24, 1, '127.0.0.1', '2020-04-23 23:06:34');
INSERT INTO `loginlog` VALUES (25, 1, '127.0.0.1', '2020-04-24 21:00:36');
INSERT INTO `loginlog` VALUES (26, 2, '127.0.0.1', '2020-04-24 21:01:00');
INSERT INTO `loginlog` VALUES (27, 3, '127.0.0.1', '2020-04-24 21:13:11');
INSERT INTO `loginlog` VALUES (28, 4, '127.0.0.1', '2020-04-24 21:13:24');
INSERT INTO `loginlog` VALUES (29, 1, '127.0.0.1', '2020-04-24 21:13:36');
INSERT INTO `loginlog` VALUES (30, 4, '127.0.0.1', '2020-04-24 21:13:54');
INSERT INTO `loginlog` VALUES (31, 1, '127.0.0.1', '2020-04-24 22:54:11');
INSERT INTO `loginlog` VALUES (32, 1, '127.0.0.1', '2020-04-24 22:54:58');
INSERT INTO `loginlog` VALUES (33, 1, '127.0.0.1', '2020-04-24 23:13:17');
INSERT INTO `loginlog` VALUES (34, 1, '127.0.0.1', '2020-04-24 23:18:22');
INSERT INTO `loginlog` VALUES (35, 2, '127.0.0.1', '2020-04-25 00:14:33');
INSERT INTO `loginlog` VALUES (36, 1, '127.0.0.1', '2020-04-25 00:16:06');
INSERT INTO `loginlog` VALUES (37, 4, '127.0.0.1', '2020-04-25 10:42:03');
INSERT INTO `loginlog` VALUES (38, 1, '127.0.0.1', '2020-04-25 10:47:26');
INSERT INTO `loginlog` VALUES (39, 4, '127.0.0.1', '2020-04-25 11:12:08');
INSERT INTO `loginlog` VALUES (40, 1, '127.0.0.1', '2020-04-25 12:06:51');
INSERT INTO `loginlog` VALUES (41, 4, '127.0.0.1', '2020-04-25 14:15:50');
INSERT INTO `loginlog` VALUES (42, 2, '127.0.0.1', '2020-04-25 14:22:59');
INSERT INTO `loginlog` VALUES (43, 4, '127.0.0.1', '2020-04-25 14:32:53');
INSERT INTO `loginlog` VALUES (44, 1, '127.0.0.1', '2020-04-26 15:47:11');
INSERT INTO `loginlog` VALUES (45, 1, '127.0.0.1', '2020-04-27 16:30:06');
INSERT INTO `loginlog` VALUES (46, 6, '127.0.0.1', '2020-04-27 16:32:19');
INSERT INTO `loginlog` VALUES (47, 1, '127.0.0.1', '2020-04-29 09:17:10');
INSERT INTO `loginlog` VALUES (48, 1, '127.0.0.1', '2020-04-29 09:34:53');
INSERT INTO `loginlog` VALUES (49, 1, '127.0.0.1', '2020-04-29 13:53:21');
INSERT INTO `loginlog` VALUES (50, 2, '127.0.0.1', '2020-04-29 16:16:12');
INSERT INTO `loginlog` VALUES (51, 2, '127.0.0.1', '2020-04-29 16:36:54');
INSERT INTO `loginlog` VALUES (52, 1, '127.0.0.1', '2020-04-30 09:32:55');
INSERT INTO `loginlog` VALUES (53, 1, '127.0.0.1', '2020-04-30 10:23:23');
INSERT INTO `loginlog` VALUES (54, 3, '127.0.0.1', '2020-04-30 10:24:08');
INSERT INTO `loginlog` VALUES (55, 1, '127.0.0.1', '2020-04-30 10:27:58');
INSERT INTO `loginlog` VALUES (56, 5, '127.0.0.1', '2020-04-30 10:28:20');
INSERT INTO `loginlog` VALUES (57, 3, '127.0.0.1', '2020-04-30 10:28:32');
INSERT INTO `loginlog` VALUES (58, 1, '127.0.0.1', '2020-04-30 10:41:46');
INSERT INTO `loginlog` VALUES (59, 3, '127.0.0.1', '2020-04-30 10:42:15');
INSERT INTO `loginlog` VALUES (60, 1, '127.0.0.1', '2020-04-30 11:10:00');
INSERT INTO `loginlog` VALUES (61, 3, '127.0.0.1', '2020-04-30 11:22:00');
INSERT INTO `loginlog` VALUES (62, 1, '127.0.0.1', '2020-04-30 11:42:27');
INSERT INTO `loginlog` VALUES (63, 3, '127.0.0.1', '2020-04-30 11:48:27');
INSERT INTO `loginlog` VALUES (64, 1, '127.0.0.1', '2020-04-30 11:56:20');
INSERT INTO `loginlog` VALUES (65, 1, '127.0.0.1', '2020-05-03 22:44:41');
INSERT INTO `loginlog` VALUES (66, 2, '127.0.0.1', '2020-05-03 23:55:08');
INSERT INTO `loginlog` VALUES (67, 5, '127.0.0.1', '2020-05-12 18:48:09');
INSERT INTO `loginlog` VALUES (68, 1, '127.0.0.1', '2020-05-12 19:10:16');
INSERT INTO `loginlog` VALUES (69, 5, '127.0.0.1', '2020-05-12 20:36:30');
INSERT INTO `loginlog` VALUES (70, 1, '127.0.0.1', '2020-05-12 21:09:47');
INSERT INTO `loginlog` VALUES (71, 2, '127.0.0.1', '2020-05-12 21:13:19');
INSERT INTO `loginlog` VALUES (72, 4, '127.0.0.1', '2020-05-12 21:14:13');
INSERT INTO `loginlog` VALUES (73, 1, '127.0.0.1', '2020-05-15 07:27:58');
INSERT INTO `loginlog` VALUES (74, 7, '127.0.0.1', '2020-05-15 07:33:04');
INSERT INTO `loginlog` VALUES (75, 5, '127.0.0.1', '2020-05-15 07:37:12');
INSERT INTO `loginlog` VALUES (76, 1, '127.0.0.1', '2020-05-15 07:49:47');
INSERT INTO `loginlog` VALUES (77, 8, '127.0.0.1', '2020-05-15 16:40:22');
INSERT INTO `loginlog` VALUES (78, 9, '127.0.0.1', '2020-05-15 17:53:12');
INSERT INTO `loginlog` VALUES (79, 1, '127.0.0.1', '2020-05-15 17:55:55');
INSERT INTO `loginlog` VALUES (80, 2, '127.0.0.1', '2020-05-15 17:56:10');

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mid`(`mid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `sysmenu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES (1, 1, 1);
INSERT INTO `menu_role` VALUES (2, 2, 1);
INSERT INTO `menu_role` VALUES (3, 3, 1);
INSERT INTO `menu_role` VALUES (4, 4, 1);
INSERT INTO `menu_role` VALUES (5, 5, 1);
INSERT INTO `menu_role` VALUES (6, 6, 1);
INSERT INTO `menu_role` VALUES (7, 7, 1);
INSERT INTO `menu_role` VALUES (8, 8, 1);
INSERT INTO `menu_role` VALUES (9, 9, 1);
INSERT INTO `menu_role` VALUES (10, 10, 1);
INSERT INTO `menu_role` VALUES (11, 11, 1);
INSERT INTO `menu_role` VALUES (12, 12, 1);
INSERT INTO `menu_role` VALUES (13, 13, 1);
INSERT INTO `menu_role` VALUES (14, 14, 1);
INSERT INTO `menu_role` VALUES (15, 15, 1);
INSERT INTO `menu_role` VALUES (16, 16, 1);
INSERT INTO `menu_role` VALUES (17, 17, 1);
INSERT INTO `menu_role` VALUES (18, 19, 1);
INSERT INTO `menu_role` VALUES (19, 18, 1);
INSERT INTO `menu_role` VALUES (20, 20, 1);
INSERT INTO `menu_role` VALUES (21, 21, 1);
INSERT INTO `menu_role` VALUES (22, 22, 1);
INSERT INTO `menu_role` VALUES (23, 5, 2);
INSERT INTO `menu_role` VALUES (24, 6, 2);
INSERT INTO `menu_role` VALUES (25, 7, 2);
INSERT INTO `menu_role` VALUES (26, 8, 2);
INSERT INTO `menu_role` VALUES (27, 9, 2);
INSERT INTO `menu_role` VALUES (28, 10, 2);
INSERT INTO `menu_role` VALUES (29, 11, 2);
INSERT INTO `menu_role` VALUES (30, 12, 2);
INSERT INTO `menu_role` VALUES (31, 13, 2);
INSERT INTO `menu_role` VALUES (32, 14, 2);
INSERT INTO `menu_role` VALUES (33, 15, 2);
INSERT INTO `menu_role` VALUES (34, 16, 2);
INSERT INTO `menu_role` VALUES (35, 17, 2);
INSERT INTO `menu_role` VALUES (36, 18, 2);
INSERT INTO `menu_role` VALUES (37, 19, 2);
INSERT INTO `menu_role` VALUES (38, 20, 2);
INSERT INTO `menu_role` VALUES (39, 21, 2);
INSERT INTO `menu_role` VALUES (40, 22, 2);
INSERT INTO `menu_role` VALUES (74, 5, 3);
INSERT INTO `menu_role` VALUES (75, 6, 3);
INSERT INTO `menu_role` VALUES (76, 7, 3);
INSERT INTO `menu_role` VALUES (77, 8, 3);
INSERT INTO `menu_role` VALUES (78, 9, 3);
INSERT INTO `menu_role` VALUES (79, 10, 3);
INSERT INTO `menu_role` VALUES (80, 11, 3);
INSERT INTO `menu_role` VALUES (81, 12, 3);
INSERT INTO `menu_role` VALUES (82, 13, 3);
INSERT INTO `menu_role` VALUES (83, 14, 3);
INSERT INTO `menu_role` VALUES (84, 15, 3);
INSERT INTO `menu_role` VALUES (85, 16, 3);
INSERT INTO `menu_role` VALUES (86, 17, 3);
INSERT INTO `menu_role` VALUES (87, 18, 3);
INSERT INTO `menu_role` VALUES (88, 19, 3);
INSERT INTO `menu_role` VALUES (89, 20, 3);
INSERT INTO `menu_role` VALUES (90, 21, 3);
INSERT INTO `menu_role` VALUES (91, 22, 3);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_user` int(11) NULL DEFAULT NULL,
  `from_user` int(11) NULL DEFAULT NULL,
  `context` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_read` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `from_user`(`from_user`) USING BTREE,
  INDEX `to_user`(`to_user`) USING BTREE,
  INDEX `ix_message_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`from_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`to_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 4, 1, 'admin邀您参加<a class=\"err\" href=\"/join_exam/4\">第一次考试</a>，点击考试参加', 1, '2020-04-16 22:37:20');
INSERT INTO `message` VALUES (2, 1, 2, 'agoni邀您参加<a class=\"err\" href=\"/join_exam/6\">第二次考试</a>，点击考试参加', 1, '2020-04-16 23:09:56');
INSERT INTO `message` VALUES (3, 3, 2, 'agoni邀您参加<a class=\"err\" href=\"/join_exam/7\">第二次考试</a>，点击考试参加', 1, '2020-04-16 23:09:56');
INSERT INTO `message` VALUES (4, 4, 2, 'agoni邀您参加<a class=\"err\" href=\"/join_exam/8\">第二次考试</a>，点击考试参加', 1, '2020-04-16 23:09:56');
INSERT INTO `message` VALUES (5, 2, 1, 'admin邀您参加<a class=\"err\" href=\"/join_exam/10\">第三次考试</a>，点击考试参加', 1, '2020-04-20 10:41:42');
INSERT INTO `message` VALUES (6, 3, 1, 'admin邀您参加<a class=\"err\" href=\"/join_exam/11\">第三次考试</a>，点击考试参加', 1, '2020-04-20 10:41:42');
INSERT INTO `message` VALUES (7, 4, 1, 'admin邀您参加<a class=\"err\" href=\"/join_exam/12\">第三次考试</a>，点击考试参加', 1, '2020-04-20 10:41:42');
INSERT INTO `message` VALUES (8, 1, 2, 'agoni邀您参加<a class=\"err\" href=\"/join_exam/14\">第一次考试</a>，点击考试参加', 1, '2020-04-25 00:15:55');
INSERT INTO `message` VALUES (9, 3, 2, 'agoni邀您参加<a class=\"err\" href=\"/join_exam/15\">第一次考试</a>，点击考试参加', 0, '2020-04-25 00:15:55');
INSERT INTO `message` VALUES (10, 4, 2, 'agoni邀您参加<a class=\"err\" href=\"/join_exam/16\">第一次考试</a>，点击考试参加', 1, '2020-04-25 00:15:55');
INSERT INTO `message` VALUES (11, 3, 4, 'mike邀您参加<a class=\"err\" href=\"/join_exam/19\">第四次考试</a>，点击考试参加', 0, '2020-05-13 00:09:40');
INSERT INTO `message` VALUES (12, 2, 4, 'mike邀您参加<a class=\"err\" href=\"/join_exam/20\">第四次考试</a>，点击考试参加', 0, '2020-05-13 00:09:40');
INSERT INTO `message` VALUES (13, 1, 4, 'mike邀您参加<a class=\"err\" href=\"/join_exam/21\">第四次考试</a>，点击考试参加', 1, '2020-05-13 00:09:40');
INSERT INTO `message` VALUES (14, 2, 7, 'test邀您参加<a class=\"err\" href=\"/join_exam/23\">测试试卷</a>，点击考试参加', 0, '2020-05-15 07:36:47');
INSERT INTO `message` VALUES (15, 5, 7, 'test邀您参加<a class=\"err\" href=\"/join_exam/24\">测试试卷</a>，点击考试参加', 1, '2020-05-15 07:36:47');
INSERT INTO `message` VALUES (16, 5, 8, 'test1邀您参加<a class=\"err\" href=\"/join_exam/26\">测试试卷2</a>，点击考试参加', 0, '2020-05-15 16:44:38');
INSERT INTO `message` VALUES (17, 2, 8, 'test1邀您参加<a class=\"err\" href=\"/join_exam/27\">测试试卷2</a>，点击考试参加', 0, '2020-05-15 16:44:38');
INSERT INTO `message` VALUES (18, 4, 8, 'test1邀您参加<a class=\"err\" href=\"/join_exam/28\">测试试卷2</a>，点击考试参加', 0, '2020-05-15 16:44:38');
INSERT INTO `message` VALUES (19, 5, 9, 'lisi邀您参加<a class=\"err\" href=\"/join_exam/30\">测试试卷3</a>，点击考试参加', 0, '2020-05-15 17:55:44');
INSERT INTO `message` VALUES (20, 2, 9, 'lisi邀您参加<a class=\"err\" href=\"/join_exam/31\">测试试卷3</a>，点击考试参加', 1, '2020-05-15 17:55:44');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reason` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_oplog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oplog
-- ----------------------------
INSERT INTO `oplog` VALUES (1, 1, '127.0.0.1', '添加权限', '2020-04-16 18:26:52');
INSERT INTO `oplog` VALUES (2, 1, '127.0.0.1', '添加权限', '2020-04-16 18:27:30');
INSERT INTO `oplog` VALUES (3, 1, '127.0.0.1', '添加试题', '2020-04-16 21:29:22');
INSERT INTO `oplog` VALUES (4, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 21:35:13');
INSERT INTO `oplog` VALUES (5, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 21:38:21');
INSERT INTO `oplog` VALUES (6, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 21:46:42');
INSERT INTO `oplog` VALUES (7, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 22:05:19');
INSERT INTO `oplog` VALUES (8, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 22:06:09');
INSERT INTO `oplog` VALUES (9, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 22:08:06');
INSERT INTO `oplog` VALUES (10, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 22:09:30');
INSERT INTO `oplog` VALUES (11, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 22:09:48');
INSERT INTO `oplog` VALUES (12, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 22:10:28');
INSERT INTO `oplog` VALUES (13, 1, '127.0.0.1', '修改试题信息成功', '2020-04-16 22:13:00');
INSERT INTO `oplog` VALUES (14, 1, '127.0.0.1', '创建[第一次考试]试题', '2020-04-16 22:19:15');
INSERT INTO `oplog` VALUES (15, 2, '127.0.0.1', '创建[第二次考试]试题', '2020-04-16 22:28:07');
INSERT INTO `oplog` VALUES (16, 1, '127.0.0.1', '添加[Jack]用户', '2020-04-16 22:32:26');
INSERT INTO `oplog` VALUES (17, 1, '127.0.0.1', '添加[mike]用户', '2020-04-16 22:35:48');
INSERT INTO `oplog` VALUES (18, 1, '127.0.0.1', '添加考试', '2020-04-16 22:37:20');
INSERT INTO `oplog` VALUES (19, 2, '127.0.0.1', '添加考试', '2020-04-16 23:09:56');
INSERT INTO `oplog` VALUES (20, 1, '127.0.0.1', '创建[第三次考试]试题', '2020-04-20 10:41:11');
INSERT INTO `oplog` VALUES (21, 1, '127.0.0.1', '添加考试', '2020-04-20 10:41:42');
INSERT INTO `oplog` VALUES (22, 1, '127.0.0.1', '添加权限', '2020-04-24 21:13:45');
INSERT INTO `oplog` VALUES (23, 2, '127.0.0.1', '添加考试', '2020-04-25 00:15:56');
INSERT INTO `oplog` VALUES (24, 1, '127.0.0.1', '添加权限', '2020-05-12 19:10:31');
INSERT INTO `oplog` VALUES (25, 4, '127.0.0.1', '创建[第四次考试]试题', '2020-05-12 21:21:55');
INSERT INTO `oplog` VALUES (26, 4, '127.0.0.1', '添加考试', '2020-05-13 00:09:40');
INSERT INTO `oplog` VALUES (27, 7, '127.0.0.1', '创建[测试试卷]试题', '2020-05-15 07:36:20');
INSERT INTO `oplog` VALUES (28, 7, '127.0.0.1', '添加考试', '2020-05-15 07:36:47');
INSERT INTO `oplog` VALUES (29, 8, '127.0.0.1', '创建[测试试卷2]试题', '2020-05-15 16:43:30');
INSERT INTO `oplog` VALUES (30, 8, '127.0.0.1', '添加考试', '2020-05-15 16:44:38');
INSERT INTO `oplog` VALUES (31, 9, '127.0.0.1', '创建[测试试卷3]试题', '2020-05-15 17:54:51');
INSERT INTO `oplog` VALUES (32, 9, '127.0.0.1', '添加考试', '2020-05-15 17:55:44');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `context` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `op_a` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `op_b` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `op_c` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `op_d` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `answer` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(11) NULL DEFAULT NULL,
  `is_public` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `analysis` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `difficult` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  CONSTRAINT `question_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `question_ibfk_3` FOREIGN KEY (`type`) REFERENCES `question_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (2, '研究数据结构就是研究（   ）。', ' 数据的逻辑结构', ' 数据的存储结构', ' 数据的逻辑结构和存储结构', ' 数据的逻辑结构、存储结构及其基本操作', 'D', 1, 1, 1, 1, '', '');
INSERT INTO `question` VALUES (3, '算法分析的两个主要方面是（   ）。', ' 空间复杂度和时间复杂度', ' 正确性和简单性', ' 可读性和文档性', ' 数据复杂性和程序复杂性', 'A', 1, 1, 1, 1, '', '');
INSERT INTO `question` VALUES (4, '具有线性结构的数据结构是（   ）。', ' 图', ' 树', ' 广义表', ' 栈', 'D', 1, 1, 1, 1, '', '');
INSERT INTO `question` VALUES (5, '计算机中的算法指的是解决某一个问题的有限运算序列，它必须具备输入、输出、（   ）等5个特性。', ' 可执行性、可移植性和可扩充性', ' 可执行性、有穷性和确定性', ' 确定性、有穷性和稳定性', ' 易读性、稳定性和确定性', 'B', 1, 1, 1, 1, '', '');
INSERT INTO `question` VALUES (6, '下面程序段的时间复杂度是（   ）。 ', ' O(m2)', ' O(n2)', ' O(m*n)', ' O(m+n)', 'C', 1, 1, 1, 1, '', '');
INSERT INTO `question` VALUES (7, '算法是（   ）。', ' 计算机程序', ' 解决问题的计算方法', ' 排序算法', ' 解决问题的有限运算序列', 'D', 1, 1, 1, 1, '', '');
INSERT INTO `question` VALUES (8, '某算法的语句执行频度为（3n+nlog2n+n2+8）,其时间复杂度表示（   ）。', ' O(n)', ' O(nlog2n)', ' O(n2)', ' O(log2n)', 'C', 1, 1, 1, 1, '', '');
INSERT INTO `question` VALUES (9, '下面程序段的时间复杂度为（   ）。', ' O(n)', ' O(3n)', ' O(log3n)', ' O(n3)    ', 'C', 1, 1, 3, 1, '', '');
INSERT INTO `question` VALUES (10, '数据结构是一门研究非数值计算的程序设计问题中计算机的数据元素以及它们之间的（   ）和运算等的学科。', ' 结构', ' 关系', ' 运算', ' 算法', 'B', 1, 1, 3, 1, '', '');
INSERT INTO `question` VALUES (11, '下面程序段的时间复杂度是（   ）。', ' O(n)', ' O(n2)', ' O(log2n)', ' O(n3)', 'A', 1, 1, 3, 1, '', '');
INSERT INTO `question` VALUES (12, '抽象数据类型的三个组成部分分别为（  ）。', ' 数据对象、数据关系和基本操作', ' 数据元素、逻辑结构和存储结构', ' 数据项、数据元素和数据类型', ' 数据元素、数据结构和数据类型', 'A', 1, 0, 3, 1, '', '');
INSERT INTO `question` VALUES (13, '若长度为n的线性表采用顺序存储结构，在其第i个位置插入一个新元素算法的时间复杂度（   ）。', ' O(log2n)', 'O(1)', ' O(n)', 'O(n2)', 'B', 0, 0, 3, 1, '', '');
INSERT INTO `question` VALUES (14, '若一个线性表中最常用的操作是取第i个元素和找第i个元素的前趋元素，则采用（   ）存储方式最节省时间。', ' 顺序表', ' 单链表', '  双链表', ' 单循环链表', 'A', 0, 0, 3, 1, '', '');
INSERT INTO `question` VALUES (15, '具有线性结构的数据结构是（   ）。', ' 图', ' 树', ' 广义表', ' 栈', 'D', 1, 0, 1, 1, '', '');
INSERT INTO `question` VALUES (16, '在一个长度为n的顺序表中，在第i个元素之前插入一个新元素时，需向后移动（   ）个元素。', ' n-i', ' n-i+1', ' n-i-1', ' i', 'B', 1, 0, 1, 1, '', '');
INSERT INTO `question` VALUES (17, '非空的循环单链表head的尾结点p满足（   ）。', ' p->next==head', ' p->next==NULL', '  p==NULL', ' p==head', 'A', 1, 0, 1, 1, '', '');
INSERT INTO `question` VALUES (18, '链表不具有的特点是（   ）。', ' 可随机访问任一元素', ' 插入删除不需要移动元素', ' 不必事先估计存储空间', ' 所需空间与线性表长度成正比', 'A', 1, 0, 1, 1, '', '');
INSERT INTO `question` VALUES (19, '在双向循环链表中，在p指针所指的结点后插入一个指针q所指向的新结点，修改指针的操作是（   ）。', ' p->next=q;q->prior=p;p->next->prior=q;q->next=q;', ' p->next=q;p->next->prior=q;q->prior=p;q->next=p->next;', ' q->prior=p;q->next=p->next;p->;next->prior=q;p->next=q;', ' q->next=p->next;q->prior=p;p->next=q;p->next=q;', 'C', 1, 0, 1, 1, '', '');
INSERT INTO `question` VALUES (20, '线性表采用链式存储时，结点C的存储地址（   ）。', ' 必须是连续的', ' 必须是不连续的', ' 连续与否均可', ' 和头结点的存储地址相连续', 'B', 1, 0, 1, 1, '', '');
INSERT INTO `question` VALUES (21, '通常从正确性、易读性、健壮性、高效性等4个方面评价算法的质量，以下解释错误的是（   ）。', ' 正确性算法应能正确地实现预定的功能', ' 易读性算法应易于阅读和理解，以便调试、修改和扩充', ' 健壮性当环境发生变化时，算法能适当地做出反应或进行处理，不会产生不需要的运行结果', ' 高效性即达到所需要的时间性能', 'D', 1, 0, 1, 1, '', '');
INSERT INTO `question` VALUES (22, '在一个长度为n的顺序表中删除第i个元素，需要向前移动（   ）个元素。', ' n-i', ' n-i+1', ' n-i-1', ' i+1', 'A', 1, 1, 1, 1, '', '');
INSERT INTO `question` VALUES (23, '以下说法正确的是（)', '二叉树的特点是每个结点至多只有两棵子树。', '二叉树的子树无左右之分。', '二叉树只能进行链式存储。', '树的结点包含一个数据元素及若干指向其子树的分支。', 'AD', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (24, '下列属于算法的重要特征的是：', '有穷性', '确定性', '可行性', '输入和输出', 'ABCD', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (25, '图的四中存储结构', '邻接矩阵', '邻接表', '邻接多重表', '十字链表', 'ABCD', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (26, '依据所有数据成员之间的逻辑关系的不同，数据结构分为（）', '非线性结构', '逻辑结构', '物理结构', '线性结构', 'AD', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (27, '图的应用算法有（）', '克鲁斯卡尔算法', '哈弗曼算法', '迪杰斯特拉算法', '拓扑排序算法', 'ACD', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (28, '计算机算法必须具备________________等特性。', '可行性、确定性', '可行性、可移植性', '输入、输出', '有穷性', 'ACD', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (29, '下列数据结构中，属于线性数据结构的是____', '栈', '队列', '树', '图', 'AB', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (30, '下列说法正确的有：', '算法和程序原则上没有区别，在讨论数据结构时二者通用', '从逻辑关系上讲，数据结构分为两大类：线性结构和非线性结构', '所谓数据的逻辑结构是指数据元素之间的逻辑关系', '同一数据逻辑结构中的所有数据元素都具有相同的特性是指数据元素所包含的数据项的个数相等', 'BC', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (31, '线性表的特点正确的（ ） 。', '存在唯一的一个被称作”第一个“的数据元素。', '不存在唯一的一个被称作”第一个“的数据元素。', '存在唯一的一个被称作”最后一个“的数据元素。', '不存在唯一的一个被称作”最后一个“的数据元素。', 'AC', 1, 1, 1, 2, '', '');
INSERT INTO `question` VALUES (32, '下面关于线性表的叙述正确的是（ ）。', '线性表采用顺序存储必须占用一片连续的存储空间', '线性表采用链式存储不必占用一片连续的存储空间', '线性表采用链式存储便于插入和删除操作的实现', '线性表采用顺序存储便于插入和删除操作的实现', 'ABC', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (33, '下列哪一条不是顺序存储结构的优点？', '存储密度大', '插入运算方便', '可方便的用于各种逻辑结构的存储表示', '删除运算方便', 'BCD', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (34, '线性表的顺序存储结构是一种（）的存储结构', '随机存取', '顺序存取', '索引存取', '散列存取', 'AB', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (35, '树的表示方法有以下哪几种？（）', '直观表示法', '嵌套集合表示法', '凹入表示法', '广义表表示法', 'ABCD', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (36, '串是一种特殊的线性表，下列不能体现其特殊性的是（ ）', '可以顺序存储', '数据元素是一个字符', '可以链接存储', '数据元素可以是多个字符', 'ACD', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (37, '下列存储形式中,( ) 是树的存储形式', '双亲表示法', '左子女右兄弟表示法', '广义表表示法', '顺序表示法', 'ABD', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (38, '下列说法正确的是 （）', '当队列中无数据元素时，称为空队列。', '队列被称为“先进后出”表。', '栈是一种操作不受限的线性表。', '栈是一种只允许在一端进行插入和删除的线性表', 'AD', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (39, '便于插入和删除操作的是（）', '静态链表', '单链表', '顺序表', '双链表', 'ABD', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (40, '以下哪些是线性表？', '集合', '栈', '队列', '二叉树', 'BC', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (41, '下列不属于数组的主要操作的是（ ）', '存取', '修改', '插入', '删除', 'CD', 1, 0, 1, 2, '', '');
INSERT INTO `question` VALUES (42, ' 线性表的逻辑顺序总是与其物理顺序一致。（  ）', '', '', '', '', '0', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (43, ' 线性表的顺序存储优于链式存储。（  ）', '', '', '', '', '0', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (44, ' 在长度为n的顺序表中，求第i个元素的直接前驱算法的时间复杂度为0（1）。（  ）', '', '', '', '', '1', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (45, ' 若一棵二叉树中的结点均无右孩子，则该二叉树的中根遍历和后根遍历序列正好相反。（  ）', '', '', '', '', '0', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (46, ' 顺序表和一维数组一样，都可以按下标随机（或直接）访问。（  ）', '', '', '', '', '1', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (47, ' 内部排序是指排序过程在内存中进行的排序。（  ）', '', '', '', '', '1', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (48, ' 当待排序序列初始有序时，简单选择排序的时间复杂性为O(n)。（   ）', '', '', '', '', '0', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (49, ' 用邻接矩阵存储一个图时，在不考虑压缩存储的情况下，所占用的存储空间大小只与图中的顶点个数有关，而与图的边数无关。(  )', '', '', '', '', '1', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (50, ' 任何一棵二叉树的叶结点在三种遍历中的相对次序是不变的。（  　）', '', '', '', '', '1', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (51, ' 若将一批杂乱无章的数据按堆结构组织起来, 则堆中数据必然按从小到大的顺序线性排列。(  )', '', '', '', '', '0', 1, 1, 1, 3, '', '');
INSERT INTO `question` VALUES (52, ' 如果采用如下方法定义一维字符数组：则这种数组在程序执行过程中不能扩充。（  ）', '', '', '', '', '0', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (53, ' 使用三元组表示稀疏矩阵中的非零元素能节省存储空间。（  ）', '', '', '', '', '1', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (54, ' 对稀疏矩阵进行压缩存储是为了节省存储空间。（  ）', '', '', '', '', '1', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (55, ' 当向一个最小堆插入一个具有最小值的元素时，该元素需要逐层向上调整，直到被调整到堆顶位置为止。(  )', '', '', '', '', '1', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (56, ' 哈希查找法中解决冲突问题的常用方法是除留余数法。（  ）', '', '', '', '', '0', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (57, ' 对具有n个结点的堆进行插入一个元素运算的时间复杂度为O(n)。(  )', '', '', '', '', '0', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (58, ' 堆排序是一种稳定的排序算法。(  )', '', '', '', '', '0', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (59, ' 如果有向图中各个顶点的度都大于2，则该图中必有回路。(  )', '', '', '', '', '0', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (60, ' 在一个顺序存储的循环队列中, 队头指针指向队头元素的后一个位置。（  ）', '', '', '', '', '0', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (61, ' 对平衡二叉树进行中根遍历，可得到结点的有序排列。（  ）', '', '', '', '', '1', 1, 0, 1, 3, '', '');
INSERT INTO `question` VALUES (62, '数据结构包括数据的逻辑结构、数据的存储结构和（ ）三方面的内容。', '', '', '', '', ' 数据的运算', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (63, '程序包括两个内容：数据结构和 （）   。', '', '', '', '', '算法', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (64, ' 数据结构的形式定义为：数据结构是一个二元组：（）  。', '', '', '', '', ' Data Structure =（D，S）', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (65, ' 数据的逻辑结构在计算机存储器内的表示，称为数据的（）  。', '', '', '', '', '存储结构', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (66, ' 数据的逻辑结构可以分类为线性结构和（）结构两大类。', '', '', '', '', '非线性', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (67, ' 在图状结构中，每个结点的前驱结点数和后继结点数可以（）。', '', '', '', '', '有多个', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (68, ' 在树形结构中，数据元素之间存在（）的关系。', '', '', '', '', '一对多 ', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (69, ' 数据的物理结构，指数据元素在计算机中的标识（映象），也即（） 。', '', '', '', '', '存储结构', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (70, ' 数据的逻辑结构包括线性结构、树形结构和图形结构  3种类型，树型结构和有向图结构合称为（）  。', '', '', '', '', '非线性结构 ', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (71, ' 顺序存储结构是把逻辑上相邻的结点存储在物理上（）的存储单元里，结点之间的逻辑关系由存储单元位置的邻接关系来体现。', '', '', '', '', '连续 ', 1, 1, 1, 4, '', '');
INSERT INTO `question` VALUES (72, ' 链式存储结构是把逻辑上相邻的结点存储在物理上（） 的存储单元里，节点之间的逻辑关系由附加的指针域来体现。', '', '', '', '', '任意', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (73, ' 数据的存储结构可用4种基本的存储方法表示，它们分别是顺序存储、链式存储、索引存储和（）  。', '', '', '', '', '散列存储', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (74, ' 线性结构反映结点间的逻辑关系是一对一的，非线性结构反映结点间的逻辑关系是（）  。', '', '', '', '', ' 一对多或多对多', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (75, ' 数据结构在物理上可分为顺序存储结构和（）存储结构。', '', '', '', '', '链式', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (76, ' 我们把每种数据结构均视为抽象类型，它不但定义了数据的表示方式，还给出了处理数据的（） 。', '', '', '', '', '实现方法 ', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (77, ' 数据元素可由若干个（）组成。', '', '', '', '', ' 数据项', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (78, ' 算法分析的两个主要方面是时间复杂度和（）复杂度。', '', '', '', '', '空间', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (79, ' 一个算法的时间复杂度是用该算法（）的多少来度量的，一个算法的空间复杂度是用该算法在运行过程中所占用的存储空间的大小来度量的。', '', '', '', '', '所消耗的时间', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (80, ' 算法具有如下特点：有穷性、（）、可行性、输入、输出。', '', '', '', '', '确定性', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (81, ' 对于某一类特定的问题，算法给出了解决问题的一系列操作，每一操作都有它的确切的定义，并在（）内计算出结果。', '', '', '', '', '有穷时间', 1, 0, 1, 4, '', '');
INSERT INTO `question` VALUES (82, '数据结构主要包括哪三方面内容？', '', '', '', '', '数据的逻辑结构、数据的存储结构、数据的运算。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (83, '什么是逻辑结构？什么是存储结构？两者有何关系？', '', '', '', '', '数据的逻辑结构是从逻辑关系上描述数据的，可以看作是从具体问题抽象出来的数学模型；数据的存储结构是逻辑结构用计算机语言的实现或在计算机中的表示，是逻辑结构在计算机中的存储方式。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (84, ' 顺序存储方式是如何表示数据元素之间的关系？其存储地址一定连续吗？', '', '', '', '', '顺序存储结构是，把逻辑上相邻的节点存储在物理位置上相邻的存储单元里，节点间的逻辑关系由存储单元的邻接关系来体现。其存储地址一定连续；', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (85, ' 链式存储方式是如何表示数据元素之间的关系？其存储地址一定连续吗？', '', '', '', '', '链式存储结构，不要求逻辑上相邻的节点在物理位置上也相邻，节点间的逻辑关系由附加的指针字段表示。其存储地址不一定连续。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (86, ' 逻辑结构与具体计算机有关吗？存储结构呢？', '', '', '', '', '逻辑结构与计算机实体无关，存储结构与计算机实体有关。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (87, ' 算法与程序有何关联 ？', '', '', '', '', '算法+数据结构=程序，算法是解题的方法，由程序设计语言描述的算法就是计算机程序。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (88, ' 算法分析主要从哪些方面考虑？', '', '', '', '', '时间复杂度与空间复杂度。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (89, ' 线性结构的逻辑关系是什么？', '', '', '', '', '节点之间存在一对一的关系，开始节点和终端节点都是唯一的，除了开始节点和终端节点以外，其余节点都有且仅有一个前驱，一个后继。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (90, ' 顺序表是如何表示数据元素的逻辑关系的？', '', '', '', '', '顺序表把线性表中所有元素按照其逻辑顺序依次存储到从计算机存储器中指定存储位置开始的一块连续的存储空间中。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (91, '单链表的操作特点是什么？', '', '', '', '', '单链表每个节点除数据域外，只设置一个指针域，用以指向其后继节点。由于每个节点只包含有一个指向后继节点的指针，所以当访问过一个节点后，只能接着访问它的后继节点，而无法访问它的前驱结点。', 1, 1, 1, 5, '', '');
INSERT INTO `question` VALUES (92, '链表的操作特点是什么？', '', '', '', '', '循环链表的特点是表中尾节点的指针域不再是空，而是指向头节点，整个链表形成一个环。因此，从表中任一节点出发，均可找到链表中其他节点。', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (93, '表与链表比较各自的优缺点是什么？', '', '', '', '', '顺序表：存储密度大、存储空间利用率高；可以通过序号直接访问任何数据元素，可以随机存取；但插入和删除操作会引起大量元素的移动； 链表：比顺序表存储密度小、存储空间利用率低；在逻辑上相邻的节点在物理上不必相邻，因此不可以随机存取，只能顺序存取；插入和删除操作方便灵活，不必移动节点，只需修改节点中的指针域即可。', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (94, '带头结点的单链表有什么优点？举例说明。', '', '', '', '', '对带头结点的链表，在表的任何结点之前插入结点或删除表中任何结点，所要做的都是修改前一结点的指针域，因为任何元素结点都有前驱结点。若链表没有头结点，则首元素结点没有前驱结点，在其前插入结点或删除该结点时操作会复杂些。', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (95, '线性表的两种存储结构各有哪些优缺点？', '', '', '', '', '线性表具有两种存储结构即顺序存储结构和链接存储结构。线性表的顺序存储结构可以直接存取数据元素，方便灵活、效率高，但插入、删除操作时将会引起元素的大量移动，因而降低效率：而在链接存储结构中内存采用动态分配，利用率高，但需增设指示结点之间关系的指针域，存取数据元素不如顺序存储方便，但结点的插入、删除操作较简单。', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (96, '对于线性表的两种存储结构，如果有n个线性表同时并存，而且在处理过程中各表的长度会动态发生变化，线性表的总数也会自动改变，在此情况下，应选用哪一种存储结构？为什么？', '', '', '', '', '应选用链接存储结构，因为链式存储结构是用一组任意的存储单元依次存储线性表中的各元素，这里存储单元可以是连续的，也可以是不连续的：这种存储结构对于元素的删除或插入运算是不需要移动元素的，只需修改指针即可，所以很容易实现表的容量的扩充。', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (97, '对于线性表的两种存储结构，若线性表的总数基本稳定，且很少进行插入和删除操作，但要求以最快的速度存取线性表中的元素，应选用何种存储结构？试说明理由。', '', '', '', '', '应选用顺序存储结构，因为每个数据元素的存储位置和线性表的起始位置相差一个和数据元素在线性表中的序号成正比的常数。因此，只要确定了其起始位置，线性表中的任一个数据元素都可随机存取，因此，线性表的顺序存储结构是一种随机存取的存储结构，而链表则是一种顺序存取的存储结构。', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (98, '在单循环链表中设置尾指针比设置头指针好吗？为什么?', '', '', '', '', '设尾指针比设头指针好。尾指针是指向终端结点的指针，用它来表示单循环链表可以使得查找链表的开始结点和终端结点都很方便，设一带头结点的单循环链表，其尾指针为Rear，则开始结点和终端结点的位置分别是rear->next->next 和 rear, 查找时间都是O(1)。若用头指针来表示该链表，则查找终端结点的时间为O(n)。', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (99, '假定有四个元素A,B,C, D依次进栈，进栈过程中允许出栈，试写出所有可能的出栈序列。', '', '', '', '', '共有14种可能的出栈序列，即为:ABCD, ABDC，ACBD, ACDB，BACD，ADCB，BADC，BCAD, BCDA，BDCA,CBAD, CBDA，CDBA, DCBA', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (100, '如何知道循环队列是空还是满?', '', '', '', '', '第一，采用计数器来判断，空时，计数器为0，满时，计数器为maxsize；第二，另设一个布尔变量以匹别队列的空和满；第三，少用一个元素的空间，约定入队前，测试尾指针在循环意义下加1后是否等于头指针，若相等则认为队满（注意：rear所指的单元始终为空）；', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (101, '当你为解决某一问题而选择数据结构时,应从哪些方面考虑?', '', '', '', '', '通常从两方面考虑：第一是算法所需的存储空间量；第二是算法所需的时间。对算法所需的时间又涉及以下三点：（1）程序运行时所需输入的数据总量。（2）计算机执行每条指令所需的时间。（3）程序中指令重复执行的次数', 1, 0, 1, 5, '', '');
INSERT INTO `question` VALUES (102, '将长度为n的单链表连接在长度为m的单链表之后的算法的时间复杂度为（   ）。\r\n', 'O(1)', 'O(n)', 'O(m)', 'O(m+n)', 'C', 1, 0, 1, 1, NULL, NULL);
INSERT INTO `question` VALUES (103, '四大名著是？', '', '', '', '', '水浒传，西游记，三国演义，红楼梦', 1, 0, 7, 5, '', '');
INSERT INTO `question` VALUES (104, '以下属于物理层的设备是()', '中继器', '以太网交换机', '桥', '网关', 'A', 1, 0, 8, 1, '', '');
INSERT INTO `question` VALUES (105, '在以太网中,是根据地址来区分不同的设备的()', 'LLC地址', 'MAC地址', 'IP地址', 'IPX地址', 'B', 1, 0, 8, 1, '', '');
INSERT INTO `question` VALUES (106, 'EEE802.3u标准是指()', '以太网', '快速以太网', '令牌环网', 'FDDI网', 'B', 1, 0, 8, 1, '', '');
INSERT INTO `question` VALUES (107, '11.以下属于物理层的设备是()', '中继器', '以太网交换机', '桥', '网关', 'A', 1, 0, 9, 1, '', '');
INSERT INTO `question` VALUES (108, '22.在以太网中,是根据地址来区分不同的设备的()', 'LLC地址', 'MAC地址', 'IP地址', 'IPX地址', 'B', 1, 0, 9, 1, '', '');
INSERT INTO `question` VALUES (109, 'EEE802.3u标准是指()', '以太网', '快速以太网', '令牌环网', 'FDDI网', 'B', 1, 0, 9, 1, '', '');

-- ----------------------------
-- Table structure for question_type
-- ----------------------------
DROP TABLE IF EXISTS `question_type`;
CREATE TABLE `question_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `desc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_public` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `question_type_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question_type
-- ----------------------------
INSERT INTO `question_type` VALUES (1, '单选题', '只能选一个答案', 1, 1);
INSERT INTO `question_type` VALUES (2, '多选题', '至少又两个以上的答案', 1, 1);
INSERT INTO `question_type` VALUES (3, '判断题', '对错二选一', 1, 1);
INSERT INTO `question_type` VALUES (4, '填空题', '填空', 1, 1);
INSERT INTO `question_type` VALUES (5, '简答题', '用简单的话回答问题', 1, 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(11) NULL DEFAULT NULL,
  `detail` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', 1, '全部权限');
INSERT INTO `role` VALUES (2, '普通管理员', 1, '部分权限');
INSERT INTO `role` VALUES (3, '普通用户', 1, '部分权限');

-- ----------------------------
-- Table structure for sysmenu
-- ----------------------------
DROP TABLE IF EXISTS `sysmenu`;
CREATE TABLE `sysmenu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menustr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(11) NULL DEFAULT NULL,
  `path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` int(11) NULL DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rank` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sysmenu
-- ----------------------------
INSERT INTO `sysmenu` VALUES (1, '系统管理', 1, NULL, 0, 'fa fa-cog', 1);
INSERT INTO `sysmenu` VALUES (2, '系统菜单', 1, '/menu_list/', 1, 'fa fa_list_alt', 1);
INSERT INTO `sysmenu` VALUES (3, '角色管理', 1, '/role_list/', 1, 'fa', 2);
INSERT INTO `sysmenu` VALUES (4, '权限管理', 1, '/authority_list/', 1, 'fa', 3);
INSERT INTO `sysmenu` VALUES (5, '用户管理', 1, NULL, 0, 'fa fa-user-o', 2);
INSERT INTO `sysmenu` VALUES (6, '用户列表', 1, '/user_list/', 5, 'fa', 1);
INSERT INTO `sysmenu` VALUES (7, '好友列表', 1, '/friend_list/', 5, 'fa', 2);
INSERT INTO `sysmenu` VALUES (8, '消息通知', 1, '/message/', 5, 'fa', 3);
INSERT INTO `sysmenu` VALUES (9, '题库管理', 1, NULL, 0, 'fa fa-book', 3);
INSERT INTO `sysmenu` VALUES (10, '题目类型', 1, '/qt_list/', 9, 'fa', 1);
INSERT INTO `sysmenu` VALUES (11, '添加题目', 1, '/question_add_html/', 9, 'fa', 2);
INSERT INTO `sysmenu` VALUES (12, '题目管理', 1, '/question_list/', 9, 'fa', 3);
INSERT INTO `sysmenu` VALUES (13, '试卷管理', 1, NULL, 0, 'fa fa-pencil', 4);
INSERT INTO `sysmenu` VALUES (14, '添加试卷', 1, '/test_add_html/', 13, 'fa', 1);
INSERT INTO `sysmenu` VALUES (15, '试卷列表', 1, '/test_list/', 13, 'fa', 2);
INSERT INTO `sysmenu` VALUES (16, '考试管理', 1, NULL, 0, 'fa fa-edit', 5);
INSERT INTO `sysmenu` VALUES (17, '考试列表', 1, '/exam_list/', 16, 'fa', 1);
INSERT INTO `sysmenu` VALUES (18, '考试结果', 1, '/examResult_list/', 16, 'fa', 2);
INSERT INTO `sysmenu` VALUES (19, '考试报表', 1, '/statement/', 16, 'fa', 3);
INSERT INTO `sysmenu` VALUES (20, '日志管理', 1, NULL, 0, 'fa fa-file-text-o', 6);
INSERT INTO `sysmenu` VALUES (21, '登录日志', 1, '/loginlog_list/', 20, 'fa', 1);
INSERT INTO `sysmenu` VALUES (22, '操作日志', 1, '/oplog_list/', 20, 'fa', 2);

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `state` int(11) NULL DEFAULT NULL,
  `is_public` int(11) NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_test_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `test_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (1, '第一次考试', 20, 1, 1, 100, 1, '2020-04-16 22:19:15');
INSERT INTO `test` VALUES (2, '第二次考试', 20, 1, 1, 100, 2, '2020-04-16 22:28:07');
INSERT INTO `test` VALUES (3, '第三次考试', 20, 1, 1, 100, 1, '2020-04-20 10:41:11');
INSERT INTO `test` VALUES (4, '第四次考试', 10, 1, 1, 100, 4, '2020-05-12 21:21:55');
INSERT INTO `test` VALUES (5, '测试试卷', 20, 1, 0, 100, 7, '2020-05-15 07:36:20');
INSERT INTO `test` VALUES (6, '测试试卷2', 5, 1, 1, 100, 8, '2020-05-15 16:43:30');
INSERT INTO `test` VALUES (7, '测试试卷3', 5, 1, 0, 100, 9, '2020-05-15 17:54:51');

-- ----------------------------
-- Table structure for test_detail
-- ----------------------------
DROP TABLE IF EXISTS `test_detail`;
CREATE TABLE `test_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_id` int(11) NULL DEFAULT NULL,
  `question_id` int(11) NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `question_id`(`question_id`) USING BTREE,
  INDEX `test_id`(`test_id`) USING BTREE,
  CONSTRAINT `test_detail_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `test_detail_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_detail
-- ----------------------------
INSERT INTO `test_detail` VALUES (1, 1, 62, 5);
INSERT INTO `test_detail` VALUES (2, 1, 29, 5);
INSERT INTO `test_detail` VALUES (3, 1, 47, 5);
INSERT INTO `test_detail` VALUES (4, 1, 95, 5);
INSERT INTO `test_detail` VALUES (5, 1, 66, 5);
INSERT INTO `test_detail` VALUES (6, 1, 96, 5);
INSERT INTO `test_detail` VALUES (7, 1, 45, 5);
INSERT INTO `test_detail` VALUES (8, 1, 18, 5);
INSERT INTO `test_detail` VALUES (9, 1, 5, 5);
INSERT INTO `test_detail` VALUES (10, 1, 11, 5);
INSERT INTO `test_detail` VALUES (11, 1, 42, 5);
INSERT INTO `test_detail` VALUES (12, 1, 32, 5);
INSERT INTO `test_detail` VALUES (13, 1, 77, 5);
INSERT INTO `test_detail` VALUES (14, 1, 3, 5);
INSERT INTO `test_detail` VALUES (15, 1, 92, 5);
INSERT INTO `test_detail` VALUES (16, 1, 97, 5);
INSERT INTO `test_detail` VALUES (17, 1, 70, 5);
INSERT INTO `test_detail` VALUES (18, 1, 79, 5);
INSERT INTO `test_detail` VALUES (19, 1, 12, 5);
INSERT INTO `test_detail` VALUES (20, 1, 7, 5);
INSERT INTO `test_detail` VALUES (21, 2, 92, 5);
INSERT INTO `test_detail` VALUES (22, 2, 4, 5);
INSERT INTO `test_detail` VALUES (23, 2, 29, 5);
INSERT INTO `test_detail` VALUES (24, 2, 21, 5);
INSERT INTO `test_detail` VALUES (25, 2, 26, 5);
INSERT INTO `test_detail` VALUES (26, 2, 62, 5);
INSERT INTO `test_detail` VALUES (27, 2, 100, 5);
INSERT INTO `test_detail` VALUES (28, 2, 90, 5);
INSERT INTO `test_detail` VALUES (29, 2, 14, 5);
INSERT INTO `test_detail` VALUES (30, 2, 13, 5);
INSERT INTO `test_detail` VALUES (31, 2, 102, 5);
INSERT INTO `test_detail` VALUES (32, 2, 72, 5);
INSERT INTO `test_detail` VALUES (33, 2, 6, 5);
INSERT INTO `test_detail` VALUES (34, 2, 64, 5);
INSERT INTO `test_detail` VALUES (35, 2, 22, 5);
INSERT INTO `test_detail` VALUES (36, 2, 79, 5);
INSERT INTO `test_detail` VALUES (37, 2, 97, 5);
INSERT INTO `test_detail` VALUES (38, 2, 71, 5);
INSERT INTO `test_detail` VALUES (39, 2, 42, 5);
INSERT INTO `test_detail` VALUES (40, 2, 88, 5);
INSERT INTO `test_detail` VALUES (41, 3, 42, 5);
INSERT INTO `test_detail` VALUES (42, 3, 65, 5);
INSERT INTO `test_detail` VALUES (43, 3, 84, 5);
INSERT INTO `test_detail` VALUES (44, 3, 86, 5);
INSERT INTO `test_detail` VALUES (45, 3, 38, 5);
INSERT INTO `test_detail` VALUES (46, 3, 23, 5);
INSERT INTO `test_detail` VALUES (47, 3, 16, 5);
INSERT INTO `test_detail` VALUES (48, 3, 25, 5);
INSERT INTO `test_detail` VALUES (49, 3, 79, 5);
INSERT INTO `test_detail` VALUES (50, 3, 60, 5);
INSERT INTO `test_detail` VALUES (51, 3, 56, 5);
INSERT INTO `test_detail` VALUES (52, 3, 46, 5);
INSERT INTO `test_detail` VALUES (53, 3, 15, 5);
INSERT INTO `test_detail` VALUES (54, 3, 74, 5);
INSERT INTO `test_detail` VALUES (55, 3, 51, 5);
INSERT INTO `test_detail` VALUES (56, 3, 83, 5);
INSERT INTO `test_detail` VALUES (57, 3, 8, 5);
INSERT INTO `test_detail` VALUES (58, 3, 99, 5);
INSERT INTO `test_detail` VALUES (59, 3, 95, 5);
INSERT INTO `test_detail` VALUES (60, 3, 20, 5);
INSERT INTO `test_detail` VALUES (61, 4, 4, 10);
INSERT INTO `test_detail` VALUES (62, 4, 5, 10);
INSERT INTO `test_detail` VALUES (63, 4, 24, 10);
INSERT INTO `test_detail` VALUES (64, 4, 31, 10);
INSERT INTO `test_detail` VALUES (65, 4, 48, 10);
INSERT INTO `test_detail` VALUES (66, 4, 63, 10);
INSERT INTO `test_detail` VALUES (67, 4, 66, 10);
INSERT INTO `test_detail` VALUES (68, 4, 82, 10);
INSERT INTO `test_detail` VALUES (69, 4, 88, 10);
INSERT INTO `test_detail` VALUES (70, 4, 58, 10);
INSERT INTO `test_detail` VALUES (71, 5, 4, 5);
INSERT INTO `test_detail` VALUES (72, 5, 87, 5);
INSERT INTO `test_detail` VALUES (73, 5, 99, 5);
INSERT INTO `test_detail` VALUES (74, 5, 83, 5);
INSERT INTO `test_detail` VALUES (75, 5, 70, 5);
INSERT INTO `test_detail` VALUES (76, 5, 100, 5);
INSERT INTO `test_detail` VALUES (77, 5, 89, 5);
INSERT INTO `test_detail` VALUES (78, 5, 86, 5);
INSERT INTO `test_detail` VALUES (79, 5, 7, 5);
INSERT INTO `test_detail` VALUES (80, 5, 73, 5);
INSERT INTO `test_detail` VALUES (81, 5, 16, 5);
INSERT INTO `test_detail` VALUES (82, 5, 18, 5);
INSERT INTO `test_detail` VALUES (83, 5, 39, 5);
INSERT INTO `test_detail` VALUES (84, 5, 63, 5);
INSERT INTO `test_detail` VALUES (85, 5, 10, 5);
INSERT INTO `test_detail` VALUES (86, 5, 56, 5);
INSERT INTO `test_detail` VALUES (87, 5, 25, 5);
INSERT INTO `test_detail` VALUES (88, 5, 59, 5);
INSERT INTO `test_detail` VALUES (89, 5, 29, 5);
INSERT INTO `test_detail` VALUES (90, 5, 43, 5);
INSERT INTO `test_detail` VALUES (96, 6, 83, 20);
INSERT INTO `test_detail` VALUES (97, 6, 2, 20);
INSERT INTO `test_detail` VALUES (98, 6, 80, 20);
INSERT INTO `test_detail` VALUES (99, 6, 3, 20);
INSERT INTO `test_detail` VALUES (100, 6, 4, 20);
INSERT INTO `test_detail` VALUES (101, 7, 2, 20);
INSERT INTO `test_detail` VALUES (102, 7, 15, 20);
INSERT INTO `test_detail` VALUES (103, 7, 30, 20);
INSERT INTO `test_detail` VALUES (104, 7, 39, 20);
INSERT INTO `test_detail` VALUES (105, 7, 48, 20);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `face` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `ix_user_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'pbkdf2:sha256:150000$MI7fIXqJ$a284f8f8dd42d9fc915aa67239609bc0e3d3f600f4ac971059487f767b576ca9', '15179751893@163.com', 1, '15179751893', '管理员', 'admin_logo.jpg', '2020-04-16 18:17:41');
INSERT INTO `user` VALUES (2, 'agoni', 'pbkdf2:sha256:150000$0AtcBRoy$8922de82e87f24b94a0307b095f9a5d940ada9580d6ae75a2c3033969b175bd6', '1093214473@qq.com', 1, '18811658930', '管理员', 'agoni_logo.jpg', '2020-04-16 18:32:42');
INSERT INTO `user` VALUES (3, 'Jack', 'pbkdf2:sha256:150000$4uz1M3m3$e52b0e27995673fb64e8fc401c082f339711ce2b8a57332dab9d7dcd6c1bf4f9', '123456789@163.com', 2, '15112345678', '测试', '202004162232262734f59b0f604ca294f9d0bf8021d087.png', '2020-04-16 22:32:26');
INSERT INTO `user` VALUES (4, 'mike', 'pbkdf2:sha256:150000$kqNpOrhV$747bf38bef7a9ec46721ab6db9310e2bafd354e8d35300cbac43040752f6a456', 'mike@163.com', 3, '1881234567', '测试', '20200416223547f625c0ef08444f1ebaaf0a0f5283248b.jpeg', '2020-04-16 22:35:48');
INSERT INTO `user` VALUES (5, 'andy', 'pbkdf2:sha256:150000$99NqUIdO$56b94bac751021a82e7c01d8870445cca94645194f6b10177d737680ca55c988', 'andy@163.com', 3, NULL, NULL, 'default.jpg', '2020-04-24 22:25:44');
INSERT INTO `user` VALUES (6, 'shabi', 'pbkdf2:sha256:150000$w9pjLJxy$21229e21f501d0110527ada49537691005a91ff57cc9ba94b5745e8cf61a07aa', '12456789@163.com', 3, NULL, NULL, 'default.jpg', '2020-04-27 16:31:27');
INSERT INTO `user` VALUES (7, 'test', 'pbkdf2:sha256:150000$SzahxU9B$1eb01b263270cd3d3abbcbcfbe615964935cfc1319ff8a7abd2818299926f254', 'test@163.com', 3, NULL, NULL, 'default.jpg', '2020-05-15 07:32:49');
INSERT INTO `user` VALUES (8, 'test1', 'pbkdf2:sha256:150000$KL71DLJG$cf832f07de0fd6fd842733eb50ed749794614d2c8c6e1ee753f6acfd8a9ca584', 'test1@163.com', 3, NULL, NULL, 'default.jpg', '2020-05-15 16:40:06');
INSERT INTO `user` VALUES (9, 'lisi', 'pbkdf2:sha256:150000$QXTt5so6$0c724ee2078864dd5f9b8d344a08e12f5ed81561c80dcaa32f195e6225e3bc85', 'lisi@163.com', 3, NULL, NULL, 'default.jpg', '2020-05-15 17:52:55');

SET FOREIGN_KEY_CHECKS = 1;
