/*
Navicat MySQL Data Transfer

Source Server         : 120.24.2.27
Source Server Version : 50621
Source Host           : 120.24.2.27:3306
Source Database       : duothink-501

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2016-10-26 09:24:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `think_article`
-- ----------------------------
DROP TABLE IF EXISTS `think_article`;
CREATE TABLE `think_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `openid` char(64) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL COMMENT '作者',
  `catid` int(11) NOT NULL COMMENT '分类',
  `subject` char(200) NOT NULL COMMENT '文章标题',
  `keywords` char(255) DEFAULT NULL COMMENT '关键字',
  `description` char(200) DEFAULT NULL COMMENT '描述',
  `message` longtext,
  `thumb` char(255) DEFAULT NULL COMMENT '缩略图',
  `ip` char(50) DEFAULT NULL COMMENT 'ip',
  `dateline` int(11) DEFAULT NULL COMMENT '发布时间',
  `views` int(11) DEFAULT '0',
  `reply` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_article_id_openid_uindex` (`id`,`openid`),
  KEY `think_article_uid_catid_subject_keywords_status_index` (`uid`,`catid`,`subject`,`keywords`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_article
-- ----------------------------
INSERT INTO `think_article` VALUES ('2', '66ce0e01010388d246bd47fc12515ec3', null, '6', '文章发布测试', '文章,大发', '放大发大发爱抚地方啊短发', '&lt;p&gt;放大发大发爱抚地方啊短发&lt;/p&gt;', null, null, '1476548976', '0', '0', '1');
INSERT INTO `think_article` VALUES ('3', '95df0f15f8bdc579078761b9a98c7143', null, '25', '发布测试第二弹', '', 'hggfhgfh', '&lt;p&gt;&lt;img src=&quot;/attach/db\\12fd793e442f17c430265b04ac306ba38ec0c4.jpeg&quot; style=&quot;max-width:100%;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;hggfhgfh&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', './attach/thumb/4540d11aa52102dd8f12772453df485a326e573c.jpg', null, '1476549603', '0', '0', '1');
INSERT INTO `think_article` VALUES ('4', 'ac2b0569fd64dc54a5d4d3b60b534ff7', null, '28', '正确测试文章内容发布', '分公司,文章,风格', '分公司的风格', '&lt;p&gt;分公司的风格&lt;img src=&quot;/attach/db\\12fd793e442f17c430265b04ac306ba38ec0c4.jpeg&quot; style=&quot;font-size: 1.4rem; max-width: 100%;&quot;&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', './attach/thumb/2875aaaef5c997bafcd0d47a0c03419698b6500c.jpg', null, '1476549865', '0', '0', '1');

-- ----------------------------
-- Table structure for `think_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `think_auth_rule`;
CREATE TABLE `think_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `pid` tinyint(8) DEFAULT '0',
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) DEFAULT '1',
  `icon` varchar(125) DEFAULT NULL,
  `condition` char(100) NOT NULL DEFAULT '',
  `sort` int(5) unsigned DEFAULT '0',
  `nav` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `think_auth_rule_id_name_pid_title_index` (`id`,`name`,`pid`,`title`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of think_auth_rule
-- ----------------------------
INSERT INTO `think_auth_rule` VALUES ('1', '0', 'mp/index/index', '管理首页', '1', 'dashboard', '', '0', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('2', '0', 'mp/content/index', '内容列表', '1', 'file-text-o', '', '2', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('6', '0', 'mp/user/index', '用户管理', '1', 'users', '', '5', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('9', '0', 'mp/config/index', '站点设置', '1', 'cog', '', '7', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('11', '0', 'mp/posts/index', '新增内容', '1', 'plus', '', '4', '0', '1');
INSERT INTO `think_auth_rule` VALUES ('19', '6', 'mp/user/adduser', '添加用户', '1', 'plus', '', '1', null, '0');
INSERT INTO `think_auth_rule` VALUES ('31', '9', 'mp/config/menus', '功能菜单', '1', 'th', '', '1', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('57', '56', 'mp/content/ed_document', '编辑文档模型', '1', 'pencil', '', '1', null, '1');
INSERT INTO `think_auth_rule` VALUES ('64', '0', 'mp/wechat/index', '微信公众号', '1', 'weixin', '', '3', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('68', '31', 'mp/config/ed_auth_rule', '编辑菜单', '1', 'pencil', '', '1', '0', '1');
INSERT INTO `think_auth_rule` VALUES ('69', '31', 'mp/config/add_menus', '添加菜单', '1', 'plus', '', '0', '0', '1');
INSERT INTO `think_auth_rule` VALUES ('77', '6', 'mp/user/groups', '用户组', '1', 'th-large', '', '2', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('79', '64', 'mp/wechat/keywords', '关键字回复', '1', 'tag', '', '3', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('80', '64', 'mp/wechat/media', '素材管理', '1', 'photo', '', '7', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('82', '64', 'mp/wechat/weixin_menus', '自定义菜单', '1', 'bars', '', '5', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('85', '0', 'mp/shop/index', '商城管理', '1', 'shopping-cart', '', '3', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('87', '85', 'mp/shop/add_goods', '添加商品', '1', 'plus', '', '2', '1', '1');
INSERT INTO `think_auth_rule` VALUES ('88', '6', 'mp/user/myprofile', '个人设置', '1', 'cog', '', '4', null, '0');
INSERT INTO `think_auth_rule` VALUES ('89', '6', 'mp/user/repass', '修改密码', '1', 'lock', '', '5', null, '0');
INSERT INTO `think_auth_rule` VALUES ('94', '85', 'mp/shop/merchants', '商家列表', '1', 'home', '', '2', null, '1');
INSERT INTO `think_auth_rule` VALUES ('95', '85', 'mp/shop/goods', '商品列表', '1', 'list', '', '4', null, '1');
INSERT INTO `think_auth_rule` VALUES ('100', '94', 'mp/shop/add_merchants', '添加商家', '1', 'plus', '', '0', null, '1');
INSERT INTO `think_auth_rule` VALUES ('101', '85', 'mp/shop/category', '分类管理', '1', 'th', '', '6', null, '1');
INSERT INTO `think_auth_rule` VALUES ('102', '11', 'mp/posts/products', '发布产品', '1', 'plus', '', '1', null, '1');
INSERT INTO `think_auth_rule` VALUES ('103', '11', 'mp/posts/goods', '发布商品', '1', 'shopping-bag', '', '2', null, '1');
INSERT INTO `think_auth_rule` VALUES ('104', '2', 'mp/content/products', '产品列表', '1', 'th-large', '', '1', null, '1');
INSERT INTO `think_auth_rule` VALUES ('105', '2', 'mp/content/goods', '商品列表', '1', 'bars', '', '2', null, '1');
INSERT INTO `think_auth_rule` VALUES ('106', '0', 'mp/channel/index', '栏目管理', '1', 'bars', '', '0', null, '1');
INSERT INTO `think_auth_rule` VALUES ('107', '106', 'mp/channel/add_channel', '添加栏目', '1', 'plus', '', '2', null, '1');
INSERT INTO `think_auth_rule` VALUES ('108', '106', 'mp/channel/ed_channel', '编辑栏目', '1', 'pencil', '', '2', null, '0');
INSERT INTO `think_auth_rule` VALUES ('109', '64', 'mp/wechat/api', '接口配置', '1', '', '', '8', null, '1');
INSERT INTO `think_auth_rule` VALUES ('110', '0', 'mp/category/index', '分类列表', '1', 'th', '', '0', null, '1');
INSERT INTO `think_auth_rule` VALUES ('111', '9', 'mp/config/routes', '路由设置', '1', 'link', '', '3', null, '1');
INSERT INTO `think_auth_rule` VALUES ('112', '0', 'mp/document/index', '文档模型', '1', 'folder', '', '0', null, '1');
INSERT INTO `think_auth_rule` VALUES ('113', '0', 'mp/recycle/index', '回收站', '1', 'recycle', '', '0', null, '1');
INSERT INTO `think_auth_rule` VALUES ('114', '0', 'mp/message/index', '消息提示', '1', 'bell-o', '', '6', null, '1');
INSERT INTO `think_auth_rule` VALUES ('115', '9', 'mp/config/login_auth', '第三方登录', '1', '', '', '5', null, '1');
INSERT INTO `think_auth_rule` VALUES ('116', '9', 'mp/config/navigation', '站点导航', '1', 'bars', '', '1', null, '1');

-- ----------------------------
-- Table structure for `think_category`
-- ----------------------------
DROP TABLE IF EXISTS `think_category`;
CREATE TABLE `think_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0',
  `title` char(50) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `type` char(50) DEFAULT NULL,
  `thumb` char(255) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `think_category_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_category
-- ----------------------------
INSERT INTO `think_category` VALUES ('1', '0', '快餐订单', '1', 'shop', null, '1');
INSERT INTO `think_category` VALUES ('2', '0', '特色菜系', '2', 'shop', null, '1');
INSERT INTO `think_category` VALUES ('3', '0', '异国料理', '3', 'shop', null, '1');
INSERT INTO `think_category` VALUES ('4', '0', '小吃夜宵', '4', 'shop', null, '1');
INSERT INTO `think_category` VALUES ('5', '0', '甜品饮品', '6', 'shop', null, '1');
INSERT INTO `think_category` VALUES ('6', '0', '果蔬生鲜', '7', 'shop', null, '1');
INSERT INTO `think_category` VALUES ('7', '0', '鲜花蛋糕', '8', 'shop', null, '1');

-- ----------------------------
-- Table structure for `think_channel`
-- ----------------------------
DROP TABLE IF EXISTS `think_channel`;
CREATE TABLE `think_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0',
  `title` char(50) DEFAULT NULL,
  `openid` char(64) DEFAULT NULL,
  `keywords` char(255) DEFAULT NULL,
  `description` char(200) DEFAULT NULL,
  `document` char(50) DEFAULT NULL,
  `template` char(100) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `allow` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_channel_id_alias_uindex` (`id`,`openid`),
  KEY `think_channel_title_index` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_channel
-- ----------------------------
INSERT INTO `think_channel` VALUES ('6', '0', '设计团队', '9b1b51465317535d21ec609acc1ca397', '著标装饰设计师', '著标装饰设计师', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('7', '0', '经典案例', 'b46dc7e4e079cab29267079f192497c0', '著标装饰案例', '著标装饰案例', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('8', '0', '装饰工艺', 'ab358699c073c03c5cf243b09feb6ee7', '著标装饰,著标装饰工艺,著标装饰材料', '著标装饰,著标装饰工艺,著标装饰材料', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('9', '0', '最新优惠', '56592cff763912bf7b5f594adce9556f', '著标装饰优惠活动,贵阳装修优惠,贵州装修活动', '著标装饰优惠活动,贵阳装修优惠,贵州装修活动', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('10', '0', '家装百科', '1eec6d832db1a4b0ccb98e9f13c6f136', '装饰常识,装修常识,装修需要注意些什么,著标装饰', '装饰常识,装修常识,装修需要注意些什么,著标装饰', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('11', '0', '在线预约', '6fc4cad6b57acf9ce4d2f3415c2cfff0', '预约贵阳装修,贵州装修电话,贵阳哪家装修好？', '预约贵阳装修,贵州装修电话,贵阳哪家装修好？', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('12', '0', '走进著标', 'c04673d03443c4316f669841355fc47f', '贵州著标装饰,贵阳装修,贵阳装饰公司', '贵州著标装饰,贵阳装修,贵阳装饰公司', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('13', '12', '关于我们', '3fd5b823c950c9f34000431a3a68b77c', '著标装饰,著标装修,贵阳装修公司介绍', '著标装饰,著标装修,贵阳装修公司介绍', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('14', '12', '客户见证', 'ad07d463bfe124d511a169f5c034a3ce', '客户见证', '客户见证', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('15', '12', '著标历程', '4ad45619ac352fcc2f19e0b37994c5e4', '著标历程,著标装饰成长经历', '著标历程,著标装饰成长经历', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('16', '12', '荣誉展示', '722ca7137e8a59a5c0cbf9110a159235', '著标装饰资质,著标装饰荣誉', '著标装饰资质,著标装饰荣誉', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('17', '12', '员工风采', 'ef889942a3d9271042f82c4cc4ad3e28', '员工风采', '员工风采', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('18', '12', '诚聘英才', '2c60b6dadbfb070c1c287a6a3ca72795', '著标装饰招聘,贵阳装修工作,贵阳装修公司招聘', '著标装饰招聘,贵阳装修工作,贵阳装修公司招聘', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('19', '8', '环保材料', '3a8e128e2faf02088dac82205dad0b71', '环保材料,贵阳装修公司环保材料', '环保材料', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('20', '8', '工艺标准', 'f4df51c19d78f3314a2693e7858566dc', '工艺标准', '工艺标准', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('21', '8', '施工管理', '629c465e2ffb3c33b3638c828739ceb5', '施工管理', '施工管理', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('22', '7', '视频中心', '4ceccd24c768a6cf2f9f041c2e5bf81b', '贵州著标装饰视频,装修视频,贵阳装修案例', '贵州著标装饰视频,装修视频,贵阳装修案例', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('23', '7', '热装小区', '21d24189d5657c5a23e863cfbb93cb84', '贵州装修小区,著标装饰装修小区', '贵州装修小区,著标装饰装修小区', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('24', '7', '在建工地', 'eee0a5651811f4ac3360f077954d7ae4', '贵州著标装饰,贵阳装修公司', '贵州著标装饰,贵阳装修公司', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('25', '6', '首席设计师', '8d635e126f83e56d963bc9ac842e1620', '贵阳装修设计师', '贵阳装修设计师', 'article', 'index', '0', '1', '1');
INSERT INTO `think_channel` VALUES ('26', '6', '主任设计师', 'a3f1b6cac54e16e64d5e8f7b3e6d86a7', '主任设计师,贵阳装修设计师', '主任设计师,贵阳设计师', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('27', '6', '金牌工长', 'a44b336f52ae3214e7a7f864ea406308', '金牌工长', '金牌工长', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('28', '9', '专题活动', '0c317df4ad495f76e1a0a79a28ef6953', '贵阳装修活动,贵阳装修优惠', '贵阳装修活动,贵阳装修优惠', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('29', '9', '最新活动', '4522ece254c794ec9648db16b8364341', '贵阳装修活动,贵阳装修优惠', '贵阳装修活动,贵阳装修优惠', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('30', '10', '家装贴士', '5b1f7e11cfc54d87128f390a5f11fe4e', '', '', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('31', '10', '环保知识', '38f22630fb82c89e4be149582f6da857', '', '', 'article', 'index', '0', '0', '1');
INSERT INTO `think_channel` VALUES ('32', '10', '家装风水', 'ecd41544502460e9d9b219a52ab2c516', '', '', 'article', 'index', '0', '0', '1');

-- ----------------------------
-- Table structure for `think_config`
-- ----------------------------
DROP TABLE IF EXISTS `think_config`;
CREATE TABLE `think_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sitename` char(120) DEFAULT NULL,
  `shortname` char(20) DEFAULT NULL,
  `thumb` char(255) DEFAULT NULL,
  `keywords` char(200) DEFAULT NULL,
  `description` char(120) DEFAULT NULL,
  `icp` char(50) DEFAULT NULL,
  `wcp` char(120) DEFAULT NULL,
  `linkman` char(50) DEFAULT '1',
  `mobile` char(50) DEFAULT NULL,
  `tell` char(120) DEFAULT NULL,
  `qq` char(20) DEFAULT NULL,
  `weixin` char(50) DEFAULT NULL,
  `email` char(120) DEFAULT NULL,
  `address` char(255) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_config_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_config
-- ----------------------------
INSERT INTO `think_config` VALUES ('1', 'duothink - 普洱轻社区', 'Duothink', null, '', '', '', '', '', '', '', '', '', '', '', '1');

-- ----------------------------
-- Table structure for `think_content`
-- ----------------------------
DROP TABLE IF EXISTS `think_content`;
CREATE TABLE `think_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_content
-- ----------------------------

-- ----------------------------
-- Table structure for `think_document`
-- ----------------------------
DROP TABLE IF EXISTS `think_document`;
CREATE TABLE `think_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(50) DEFAULT NULL,
  `alias` char(50) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_document_id_uindex` (`id`),
  UNIQUE KEY `id` (`id`,`alias`),
  KEY `think_document_title_index` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_document
-- ----------------------------
INSERT INTO `think_document` VALUES ('1', '文章模型', 'article', '1');
INSERT INTO `think_document` VALUES ('2', '单页模型', 'page', '1');
INSERT INTO `think_document` VALUES ('3', '产品模型', 'product', '1');
INSERT INTO `think_document` VALUES ('4', '商品模型', 'shop', '1');

-- ----------------------------
-- Table structure for `think_document_fileds`
-- ----------------------------
DROP TABLE IF EXISTS `think_document_fileds`;
CREATE TABLE `think_document_fileds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` int(11) DEFAULT NULL,
  `title` char(50) DEFAULT NULL,
  `type` char(50) DEFAULT NULL,
  `name` char(50) DEFAULT NULL,
  `placeholder` char(200) DEFAULT NULL,
  `idclass` char(200) DEFAULT NULL,
  `class` char(200) DEFAULT NULL,
  `required` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_document_fileds_document_id_pk` (`document_id`),
  KEY `think_document_fileds_id_title_type_index` (`id`,`title`,`type`),
  KEY `think_document_fileds_document_id_index` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_document_fileds
-- ----------------------------

-- ----------------------------
-- Table structure for `think_merchants`
-- ----------------------------
DROP TABLE IF EXISTS `think_merchants`;
CREATE TABLE `think_merchants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `openid` char(64) DEFAULT NULL,
  `subject` char(120) DEFAULT NULL,
  `catid` int(11) DEFAULT NULL,
  `thumb` char(255) DEFAULT NULL,
  `mobile` char(50) DEFAULT NULL,
  `tell` char(50) DEFAULT NULL,
  `address` char(200) DEFAULT NULL,
  `remarks` text,
  `dateline` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_merchants
-- ----------------------------
INSERT INTO `think_merchants` VALUES ('1', '1e4d849cdd1059bf79adb651f1383b6d', '测试商家', '8', '/attach/d8\\f6884470e56e5b14454e5957c6784ec78ce2f1.png', '18087990440', '08792828288', '中心商务区', '&lt;p&gt;代付电费&lt;/p&gt;', null, '1');

-- ----------------------------
-- Table structure for `think_navigation`
-- ----------------------------
DROP TABLE IF EXISTS `think_navigation`;
CREATE TABLE `think_navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0',
  `title` char(50) NOT NULL,
  `value` char(255) NOT NULL,
  `order` int(11) DEFAULT '0',
  `type` int(11) DEFAULT '1',
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_navigation_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='站点导航';

-- ----------------------------
-- Records of think_navigation
-- ----------------------------
INSERT INTO `think_navigation` VALUES ('1', '0', '主导航', '22222', '0', '1', '1');
INSERT INTO `think_navigation` VALUES ('2', '0', '主导航2', '34567', '22', '1', '1');
INSERT INTO `think_navigation` VALUES ('3', '0', '主导航3', 'http://tp.com/lists/0c317df4ad495f76e1a0a79a28ef6953.html', '666', '1', '1');
INSERT INTO `think_navigation` VALUES ('4', '3', '二级导航', 'http://tp.com/lists/0c317df4ad495f76e1a0a79a28ef6953.html', '0', '1', '1');
INSERT INTO `think_navigation` VALUES ('5', '3', '主导航333', 'javascript', '0', '1', '1');
INSERT INTO `think_navigation` VALUES ('6', '0', '首页', '/', '999', '1', '1');

-- ----------------------------
-- Table structure for `think_page`
-- ----------------------------
DROP TABLE IF EXISTS `think_page`;
CREATE TABLE `think_page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` char(64) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL COMMENT '作者',
  `catid` int(11) DEFAULT NULL COMMENT '分类',
  `ip` char(50) DEFAULT NULL COMMENT 'ip',
  `dateline` int(11) DEFAULT NULL COMMENT '发布时间',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_page_id_openid_uindex` (`id`,`openid`),
  KEY `think_page_catid_uid_index` (`catid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_page
-- ----------------------------

-- ----------------------------
-- Table structure for `think_product`
-- ----------------------------
DROP TABLE IF EXISTS `think_product`;
CREATE TABLE `think_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` char(64) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL COMMENT '作者',
  `catid` int(11) DEFAULT NULL COMMENT '分类',
  `ip` char(50) DEFAULT NULL COMMENT 'ip',
  `dateline` int(11) DEFAULT NULL COMMENT '发布时间',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_product_id_openid_uindex` (`id`,`openid`),
  KEY `think_product_catid_uid_index` (`catid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_product
-- ----------------------------

-- ----------------------------
-- Table structure for `think_shop`
-- ----------------------------
DROP TABLE IF EXISTS `think_shop`;
CREATE TABLE `think_shop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` char(64) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL COMMENT '作者',
  `catid` int(11) DEFAULT NULL COMMENT '分类',
  `subject` char(120) DEFAULT NULL,
  `price` float(50,0) DEFAULT NULL,
  `thumb` char(255) DEFAULT NULL,
  `ip` char(50) DEFAULT NULL COMMENT 'ip',
  `dateline` int(11) DEFAULT NULL COMMENT '发布时间',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_shop_id_openid_uindex` (`id`,`openid`),
  KEY `think_shop_catid_uid_index` (`catid`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_shop
-- ----------------------------
INSERT INTO `think_shop` VALUES ('1', '363fd5ef771136fc5d0a0dbd6ae49e30', '1', '1', '9', '发布测试', '200', '/attach/d8\\f6884470e56e5b14454e5957c6784ec78ce2f1.png', null, '1476077285', '1');

-- ----------------------------
-- Table structure for `think_user`
-- ----------------------------
DROP TABLE IF EXISTS `think_user`;
CREATE TABLE `think_user` (
  `uid` int(11) NOT NULL,
  `openid` char(64) DEFAULT NULL,
  `username` char(50) NOT NULL,
  `mobile` char(50) DEFAULT NULL,
  `password` char(64) DEFAULT NULL,
  `reg_time` int(11) DEFAULT NULL,
  `reg_ip` char(20) DEFAULT NULL,
  `last_login_time` int(11) DEFAULT NULL,
  `last_login_ip` char(20) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `think_user_uid_openid_uindex` (`uid`,`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_user
-- ----------------------------
INSERT INTO `think_user` VALUES ('1', '6440abe399f8cece728ff8f7f8fbba1c', 'admin', '18087990440', '57736c32c18a61e6b7fd80e45b88eb4c42b9584c', '1473672824', '127.0.0.1', '1477441546', '127.0.0.1', '1');

-- ----------------------------
-- Table structure for `think_user_avatar`
-- ----------------------------
DROP TABLE IF EXISTS `think_user_avatar`;
CREATE TABLE `think_user_avatar` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `avatar` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `think_user_avatar_id_uid_uindex` (`id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_user_avatar
-- ----------------------------

-- ----------------------------
-- Table structure for `think_user_score`
-- ----------------------------
DROP TABLE IF EXISTS `think_user_score`;
CREATE TABLE `think_user_score` (
  `id` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  UNIQUE KEY `think_user_score_id_uid_uindex` (`id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_user_score
-- ----------------------------

-- ----------------------------
-- Table structure for `think_weixin_config`
-- ----------------------------
DROP TABLE IF EXISTS `think_weixin_config`;
CREATE TABLE `think_weixin_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `title` char(50) DEFAULT NULL,
  `wechat_no` char(64) DEFAULT NULL,
  `url` char(255) DEFAULT NULL,
  `token` char(64) DEFAULT NULL,
  `appid` char(100) DEFAULT NULL,
  `appsecret` char(64) DEFAULT NULL,
  `encodingaeskey` char(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_weixin_config
-- ----------------------------
INSERT INTO `think_weixin_config` VALUES ('1', '1', '微信公众号测试平台', 'd70f64c87402efa', 'http://tp.com/common/weixin/api/uid/1.html', 'duothink', 'wx5b7d5ce9c21c5191', '5e98bf1e17397621ed70f64c87402efa', '5e98bf1e17397621ed70f64c87402efa');

-- ----------------------------
-- Table structure for `think_weixin_menus`
-- ----------------------------
DROP TABLE IF EXISTS `think_weixin_menus`;
CREATE TABLE `think_weixin_menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(255) DEFAULT '0',
  `title` char(50) DEFAULT NULL,
  `type` char(50) DEFAULT '0',
  `value` char(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `status` int(2) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_weixin_menus
-- ----------------------------
INSERT INTO `think_weixin_menus` VALUES ('9', '0', '公司播报', 'view', 'http://wx.puerxt.com/thread/23.html', '1', '1');
INSERT INTO `think_weixin_menus` VALUES ('10', '9', '公司简介', 'view', 'http://wx.puerxt.com/forum/72.html', '1', '1');
INSERT INTO `think_weixin_menus` VALUES ('11', '9', '安全生产', 'view', 'http://wx.puerxt.com/forum/73.html', '2', '1');
INSERT INTO `think_weixin_menus` VALUES ('12', '9', '经营管理', 'view', 'http://wx.puerxt.com/forum/74.html', '3', '1');
INSERT INTO `think_weixin_menus` VALUES ('13', '9', '党工团', 'view', 'http://wx.puerxt.com/forum/75.html', '4', '1');
INSERT INTO `think_weixin_menus` VALUES ('15', '0', '公司通告', 'view', 'http://wx.puerxt.com/forum/70.html', '2', '1');
INSERT INTO `think_weixin_menus` VALUES ('16', '0', '实用功能', 'view', 'http://wx.puerxt.com/forum/71.html', '3', '1');
INSERT INTO `think_weixin_menus` VALUES ('17', '15', '公司发文通知', 'view', 'http://wx.puerxt.com/forum/83.html', '1', '1');
INSERT INTO `think_weixin_menus` VALUES ('18', '15', '公司公告', 'view', 'http://wx.puerxt.com/forum/84.html', '2', '1');
INSERT INTO `think_weixin_menus` VALUES ('19', '15', ' 任务处理通知', 'view', 'http://wx.puerxt.com/forum/85.html', '3', '1');
INSERT INTO `think_weixin_menus` VALUES ('21', '16', '一键导航', 'view', 'http://wx.puerxt.com/forum/80.html', '3', '1');
INSERT INTO `think_weixin_menus` VALUES ('22', '16', '职工之家', 'view', 'http://wx.puerxt.com/forum/81.html', '4', '1');
INSERT INTO `think_weixin_menus` VALUES ('23', '16', '我的主页', 'view', 'http://wx.puerxt.com/user.html', '2', '1');
INSERT INTO `think_weixin_menus` VALUES ('24', '16', '通讯录', 'view', 'http://wx.puerxt.com/user/index/user_mail.html', '1', '1');
