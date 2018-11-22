/*
Navicat MySQL Data Transfer

Source Server         : bro2
Source Server Version : 50720
Source Host           : rm-m5eblhc9o3515i25neo.mysql.rds.aliyuncs.com:3306
Source Database       : fqzy

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-10-22 18:10:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cmf_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `cmf_admin_menu`;
CREATE TABLE `cmf_admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '菜单类型;1:有界面可访问菜单,2:无界面可访问菜单,0:只作为菜单',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;1:显示,0:不显示',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `app` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '应用名',
  `controller` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '控制器名',
  `action` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '操作名称',
  `param` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '额外参数',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parent_id` (`parent_id`),
  KEY `controller` (`controller`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COMMENT='后台菜单表';

-- ----------------------------
-- Records of cmf_admin_menu
-- ----------------------------
INSERT INTO `cmf_admin_menu` VALUES ('1', '0', '0', '0', '20', 'admin', 'Plugin', 'default', '', '插件中心', 'cloud', '插件中心');
INSERT INTO `cmf_admin_menu` VALUES ('2', '1', '1', '1', '10000', 'admin', 'Hook', 'index', '', '钩子管理', '', '钩子管理');
INSERT INTO `cmf_admin_menu` VALUES ('3', '2', '1', '0', '10000', 'admin', 'Hook', 'plugins', '', '钩子插件管理', '', '钩子插件管理');
INSERT INTO `cmf_admin_menu` VALUES ('4', '2', '2', '0', '10000', 'admin', 'Hook', 'pluginListOrder', '', '钩子插件排序', '', '钩子插件排序');
INSERT INTO `cmf_admin_menu` VALUES ('5', '2', '1', '0', '10000', 'admin', 'Hook', 'sync', '', '同步钩子', '', '同步钩子');
INSERT INTO `cmf_admin_menu` VALUES ('6', '0', '0', '1', '0', 'admin', 'Setting', 'default', '', '设置', 'cogs', '系统设置入口');
INSERT INTO `cmf_admin_menu` VALUES ('7', '6', '1', '1', '50', 'admin', 'Link', 'index', '', '友情链接', '', '友情链接管理');
INSERT INTO `cmf_admin_menu` VALUES ('8', '7', '1', '0', '10000', 'admin', 'Link', 'add', '', '添加友情链接', '', '添加友情链接');
INSERT INTO `cmf_admin_menu` VALUES ('9', '7', '2', '0', '10000', 'admin', 'Link', 'addPost', '', '添加友情链接提交保存', '', '添加友情链接提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('10', '7', '1', '0', '10000', 'admin', 'Link', 'edit', '', '编辑友情链接', '', '编辑友情链接');
INSERT INTO `cmf_admin_menu` VALUES ('11', '7', '2', '0', '10000', 'admin', 'Link', 'editPost', '', '编辑友情链接提交保存', '', '编辑友情链接提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('12', '7', '2', '0', '10000', 'admin', 'Link', 'delete', '', '删除友情链接', '', '删除友情链接');
INSERT INTO `cmf_admin_menu` VALUES ('13', '7', '2', '0', '10000', 'admin', 'Link', 'listOrder', '', '友情链接排序', '', '友情链接排序');
INSERT INTO `cmf_admin_menu` VALUES ('14', '7', '2', '0', '10000', 'admin', 'Link', 'toggle', '', '友情链接显示隐藏', '', '友情链接显示隐藏');
INSERT INTO `cmf_admin_menu` VALUES ('15', '6', '1', '1', '10', 'admin', 'Mailer', 'index', '', '邮箱配置', '', '邮箱配置');
INSERT INTO `cmf_admin_menu` VALUES ('16', '15', '2', '0', '10000', 'admin', 'Mailer', 'indexPost', '', '邮箱配置提交保存', '', '邮箱配置提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('17', '15', '1', '0', '10000', 'admin', 'Mailer', 'template', '', '邮件模板', '', '邮件模板');
INSERT INTO `cmf_admin_menu` VALUES ('18', '15', '2', '0', '10000', 'admin', 'Mailer', 'templatePost', '', '邮件模板提交', '', '邮件模板提交');
INSERT INTO `cmf_admin_menu` VALUES ('19', '15', '1', '0', '10000', 'admin', 'Mailer', 'test', '', '邮件发送测试', '', '邮件发送测试');
INSERT INTO `cmf_admin_menu` VALUES ('20', '6', '1', '0', '10000', 'admin', 'Menu', 'index', '', '后台菜单', '', '后台菜单管理');
INSERT INTO `cmf_admin_menu` VALUES ('21', '20', '1', '0', '10000', 'admin', 'Menu', 'lists', '', '所有菜单', '', '后台所有菜单列表');
INSERT INTO `cmf_admin_menu` VALUES ('22', '20', '1', '0', '10000', 'admin', 'Menu', 'add', '', '后台菜单添加', '', '后台菜单添加');
INSERT INTO `cmf_admin_menu` VALUES ('23', '20', '2', '0', '10000', 'admin', 'Menu', 'addPost', '', '后台菜单添加提交保存', '', '后台菜单添加提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('24', '20', '1', '0', '10000', 'admin', 'Menu', 'edit', '', '后台菜单编辑', '', '后台菜单编辑');
INSERT INTO `cmf_admin_menu` VALUES ('25', '20', '2', '0', '10000', 'admin', 'Menu', 'editPost', '', '后台菜单编辑提交保存', '', '后台菜单编辑提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('26', '20', '2', '0', '10000', 'admin', 'Menu', 'delete', '', '后台菜单删除', '', '后台菜单删除');
INSERT INTO `cmf_admin_menu` VALUES ('27', '20', '2', '0', '10000', 'admin', 'Menu', 'listOrder', '', '后台菜单排序', '', '后台菜单排序');
INSERT INTO `cmf_admin_menu` VALUES ('28', '20', '1', '0', '10000', 'admin', 'Menu', 'getActions', '', '导入新后台菜单', '', '导入新后台菜单');
INSERT INTO `cmf_admin_menu` VALUES ('29', '6', '1', '1', '30', 'admin', 'Nav', 'index', '', '导航管理', '', '导航管理');
INSERT INTO `cmf_admin_menu` VALUES ('30', '29', '1', '0', '10000', 'admin', 'Nav', 'add', '', '添加导航', '', '添加导航');
INSERT INTO `cmf_admin_menu` VALUES ('31', '29', '2', '0', '10000', 'admin', 'Nav', 'addPost', '', '添加导航提交保存', '', '添加导航提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('32', '29', '1', '0', '10000', 'admin', 'Nav', 'edit', '', '编辑导航', '', '编辑导航');
INSERT INTO `cmf_admin_menu` VALUES ('33', '29', '2', '0', '10000', 'admin', 'Nav', 'editPost', '', '编辑导航提交保存', '', '编辑导航提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('34', '29', '2', '0', '10000', 'admin', 'Nav', 'delete', '', '删除导航', '', '删除导航');
INSERT INTO `cmf_admin_menu` VALUES ('35', '29', '1', '0', '10000', 'admin', 'NavMenu', 'index', '', '导航菜单', '', '导航菜单');
INSERT INTO `cmf_admin_menu` VALUES ('36', '35', '1', '0', '10000', 'admin', 'NavMenu', 'add', '', '添加导航菜单', '', '添加导航菜单');
INSERT INTO `cmf_admin_menu` VALUES ('37', '35', '2', '0', '10000', 'admin', 'NavMenu', 'addPost', '', '添加导航菜单提交保存', '', '添加导航菜单提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('38', '35', '1', '0', '10000', 'admin', 'NavMenu', 'edit', '', '编辑导航菜单', '', '编辑导航菜单');
INSERT INTO `cmf_admin_menu` VALUES ('39', '35', '2', '0', '10000', 'admin', 'NavMenu', 'editPost', '', '编辑导航菜单提交保存', '', '编辑导航菜单提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('40', '35', '2', '0', '10000', 'admin', 'NavMenu', 'delete', '', '删除导航菜单', '', '删除导航菜单');
INSERT INTO `cmf_admin_menu` VALUES ('41', '35', '2', '0', '10000', 'admin', 'NavMenu', 'listOrder', '', '导航菜单排序', '', '导航菜单排序');
INSERT INTO `cmf_admin_menu` VALUES ('42', '1', '1', '1', '10000', 'admin', 'Plugin', 'index', '', '插件列表', '', '插件列表');
INSERT INTO `cmf_admin_menu` VALUES ('43', '42', '2', '0', '10000', 'admin', 'Plugin', 'toggle', '', '插件启用禁用', '', '插件启用禁用');
INSERT INTO `cmf_admin_menu` VALUES ('44', '42', '1', '0', '10000', 'admin', 'Plugin', 'setting', '', '插件设置', '', '插件设置');
INSERT INTO `cmf_admin_menu` VALUES ('45', '42', '2', '0', '10000', 'admin', 'Plugin', 'settingPost', '', '插件设置提交', '', '插件设置提交');
INSERT INTO `cmf_admin_menu` VALUES ('46', '42', '2', '0', '10000', 'admin', 'Plugin', 'install', '', '插件安装', '', '插件安装');
INSERT INTO `cmf_admin_menu` VALUES ('47', '42', '2', '0', '10000', 'admin', 'Plugin', 'update', '', '插件更新', '', '插件更新');
INSERT INTO `cmf_admin_menu` VALUES ('48', '42', '2', '0', '10000', 'admin', 'Plugin', 'uninstall', '', '卸载插件', '', '卸载插件');
INSERT INTO `cmf_admin_menu` VALUES ('49', '109', '0', '1', '10000', 'admin', 'User', 'default', '', '管理组', '', '管理组');
INSERT INTO `cmf_admin_menu` VALUES ('50', '49', '1', '1', '10000', 'admin', 'Rbac', 'index', '', '角色管理', '', '角色管理');
INSERT INTO `cmf_admin_menu` VALUES ('51', '50', '1', '0', '10000', 'admin', 'Rbac', 'roleAdd', '', '添加角色', '', '添加角色');
INSERT INTO `cmf_admin_menu` VALUES ('52', '50', '2', '0', '10000', 'admin', 'Rbac', 'roleAddPost', '', '添加角色提交', '', '添加角色提交');
INSERT INTO `cmf_admin_menu` VALUES ('53', '50', '1', '0', '10000', 'admin', 'Rbac', 'roleEdit', '', '编辑角色', '', '编辑角色');
INSERT INTO `cmf_admin_menu` VALUES ('54', '50', '2', '0', '10000', 'admin', 'Rbac', 'roleEditPost', '', '编辑角色提交', '', '编辑角色提交');
INSERT INTO `cmf_admin_menu` VALUES ('55', '50', '2', '0', '10000', 'admin', 'Rbac', 'roleDelete', '', '删除角色', '', '删除角色');
INSERT INTO `cmf_admin_menu` VALUES ('56', '50', '1', '0', '10000', 'admin', 'Rbac', 'authorize', '', '设置角色权限', '', '设置角色权限');
INSERT INTO `cmf_admin_menu` VALUES ('57', '50', '2', '0', '10000', 'admin', 'Rbac', 'authorizePost', '', '角色授权提交', '', '角色授权提交');
INSERT INTO `cmf_admin_menu` VALUES ('58', '0', '1', '0', '10000', 'admin', 'RecycleBin', 'index', '', '回收站', '', '回收站');
INSERT INTO `cmf_admin_menu` VALUES ('59', '58', '2', '0', '10000', 'admin', 'RecycleBin', 'restore', '', '回收站还原', '', '回收站还原');
INSERT INTO `cmf_admin_menu` VALUES ('60', '58', '2', '0', '10000', 'admin', 'RecycleBin', 'delete', '', '回收站彻底删除', '', '回收站彻底删除');
INSERT INTO `cmf_admin_menu` VALUES ('61', '6', '1', '1', '10000', 'admin', 'Route', 'index', '', 'URL美化', '', 'URL规则管理');
INSERT INTO `cmf_admin_menu` VALUES ('62', '61', '1', '0', '10000', 'admin', 'Route', 'add', '', '添加路由规则', '', '添加路由规则');
INSERT INTO `cmf_admin_menu` VALUES ('63', '61', '2', '0', '10000', 'admin', 'Route', 'addPost', '', '添加路由规则提交', '', '添加路由规则提交');
INSERT INTO `cmf_admin_menu` VALUES ('64', '61', '1', '0', '10000', 'admin', 'Route', 'edit', '', '路由规则编辑', '', '路由规则编辑');
INSERT INTO `cmf_admin_menu` VALUES ('65', '61', '2', '0', '10000', 'admin', 'Route', 'editPost', '', '路由规则编辑提交', '', '路由规则编辑提交');
INSERT INTO `cmf_admin_menu` VALUES ('66', '61', '2', '0', '10000', 'admin', 'Route', 'delete', '', '路由规则删除', '', '路由规则删除');
INSERT INTO `cmf_admin_menu` VALUES ('67', '61', '2', '0', '10000', 'admin', 'Route', 'ban', '', '路由规则禁用', '', '路由规则禁用');
INSERT INTO `cmf_admin_menu` VALUES ('68', '61', '2', '0', '10000', 'admin', 'Route', 'open', '', '路由规则启用', '', '路由规则启用');
INSERT INTO `cmf_admin_menu` VALUES ('69', '61', '2', '0', '10000', 'admin', 'Route', 'listOrder', '', '路由规则排序', '', '路由规则排序');
INSERT INTO `cmf_admin_menu` VALUES ('70', '61', '1', '0', '10000', 'admin', 'Route', 'select', '', '选择URL', '', '选择URL');
INSERT INTO `cmf_admin_menu` VALUES ('71', '6', '1', '1', '0', 'admin', 'Setting', 'site', '', '网站信息', '', '网站信息');
INSERT INTO `cmf_admin_menu` VALUES ('72', '71', '2', '0', '10000', 'admin', 'Setting', 'sitePost', '', '网站信息设置提交', '', '网站信息设置提交');
INSERT INTO `cmf_admin_menu` VALUES ('73', '6', '1', '0', '10000', 'admin', 'Setting', 'password', '', '密码修改', '', '密码修改');
INSERT INTO `cmf_admin_menu` VALUES ('74', '73', '2', '0', '10000', 'admin', 'Setting', 'passwordPost', '', '密码修改提交', '', '密码修改提交');
INSERT INTO `cmf_admin_menu` VALUES ('75', '6', '1', '1', '10000', 'admin', 'Setting', 'upload', '', '上传设置', '', '上传设置');
INSERT INTO `cmf_admin_menu` VALUES ('76', '75', '2', '0', '10000', 'admin', 'Setting', 'uploadPost', '', '上传设置提交', '', '上传设置提交');
INSERT INTO `cmf_admin_menu` VALUES ('77', '6', '1', '0', '10000', 'admin', 'Setting', 'clearCache', '', '清除缓存', '', '清除缓存');
INSERT INTO `cmf_admin_menu` VALUES ('78', '166', '1', '1', '40', 'admin', 'Slide', 'index', '', '幻灯片管理', '', '幻灯片管理');
INSERT INTO `cmf_admin_menu` VALUES ('79', '78', '1', '0', '10000', 'admin', 'Slide', 'add', '', '添加幻灯片', '', '添加幻灯片');
INSERT INTO `cmf_admin_menu` VALUES ('80', '78', '2', '0', '10000', 'admin', 'Slide', 'addPost', '', '添加幻灯片提交', '', '添加幻灯片提交');
INSERT INTO `cmf_admin_menu` VALUES ('81', '78', '1', '0', '10000', 'admin', 'Slide', 'edit', '', '编辑幻灯片', '', '编辑幻灯片');
INSERT INTO `cmf_admin_menu` VALUES ('82', '78', '2', '0', '10000', 'admin', 'Slide', 'editPost', '', '编辑幻灯片提交', '', '编辑幻灯片提交');
INSERT INTO `cmf_admin_menu` VALUES ('83', '78', '2', '0', '10000', 'admin', 'Slide', 'delete', '', '删除幻灯片', '', '删除幻灯片');
INSERT INTO `cmf_admin_menu` VALUES ('84', '78', '1', '0', '10000', 'admin', 'SlideItem', 'index', '', '幻灯片页面列表', '', '幻灯片页面列表');
INSERT INTO `cmf_admin_menu` VALUES ('85', '84', '1', '0', '10000', 'admin', 'SlideItem', 'add', '', '幻灯片页面添加', '', '幻灯片页面添加');
INSERT INTO `cmf_admin_menu` VALUES ('86', '84', '2', '0', '10000', 'admin', 'SlideItem', 'addPost', '', '幻灯片页面添加提交', '', '幻灯片页面添加提交');
INSERT INTO `cmf_admin_menu` VALUES ('87', '84', '1', '0', '10000', 'admin', 'SlideItem', 'edit', '', '幻灯片页面编辑', '', '幻灯片页面编辑');
INSERT INTO `cmf_admin_menu` VALUES ('88', '84', '2', '0', '10000', 'admin', 'SlideItem', 'editPost', '', '幻灯片页面编辑提交', '', '幻灯片页面编辑提交');
INSERT INTO `cmf_admin_menu` VALUES ('89', '84', '2', '0', '10000', 'admin', 'SlideItem', 'delete', '', '幻灯片页面删除', '', '幻灯片页面删除');
INSERT INTO `cmf_admin_menu` VALUES ('90', '84', '2', '0', '10000', 'admin', 'SlideItem', 'ban', '', '幻灯片页面隐藏', '', '幻灯片页面隐藏');
INSERT INTO `cmf_admin_menu` VALUES ('91', '84', '2', '0', '10000', 'admin', 'SlideItem', 'cancelBan', '', '幻灯片页面显示', '', '幻灯片页面显示');
INSERT INTO `cmf_admin_menu` VALUES ('92', '84', '2', '0', '10000', 'admin', 'SlideItem', 'listOrder', '', '幻灯片页面排序', '', '幻灯片页面排序');
INSERT INTO `cmf_admin_menu` VALUES ('93', '6', '1', '1', '10000', 'admin', 'Storage', 'index', '', '文件存储', '', '文件存储');
INSERT INTO `cmf_admin_menu` VALUES ('94', '93', '2', '0', '10000', 'admin', 'Storage', 'settingPost', '', '文件存储设置提交', '', '文件存储设置提交');
INSERT INTO `cmf_admin_menu` VALUES ('95', '6', '1', '1', '20', 'admin', 'Theme', 'index', '', '模板管理', '', '模板管理');
INSERT INTO `cmf_admin_menu` VALUES ('96', '95', '1', '0', '10000', 'admin', 'Theme', 'install', '', '安装模板', '', '安装模板');
INSERT INTO `cmf_admin_menu` VALUES ('97', '95', '2', '0', '10000', 'admin', 'Theme', 'uninstall', '', '卸载模板', '', '卸载模板');
INSERT INTO `cmf_admin_menu` VALUES ('98', '95', '2', '0', '10000', 'admin', 'Theme', 'installTheme', '', '模板安装', '', '模板安装');
INSERT INTO `cmf_admin_menu` VALUES ('99', '95', '2', '0', '10000', 'admin', 'Theme', 'update', '', '模板更新', '', '模板更新');
INSERT INTO `cmf_admin_menu` VALUES ('100', '95', '2', '0', '10000', 'admin', 'Theme', 'active', '', '启用模板', '', '启用模板');
INSERT INTO `cmf_admin_menu` VALUES ('101', '95', '1', '0', '10000', 'admin', 'Theme', 'files', '', '模板文件列表', '', '启用模板');
INSERT INTO `cmf_admin_menu` VALUES ('102', '95', '1', '0', '10000', 'admin', 'Theme', 'fileSetting', '', '模板文件设置', '', '模板文件设置');
INSERT INTO `cmf_admin_menu` VALUES ('103', '95', '1', '0', '10000', 'admin', 'Theme', 'fileArrayData', '', '模板文件数组数据列表', '', '模板文件数组数据列表');
INSERT INTO `cmf_admin_menu` VALUES ('104', '95', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataEdit', '', '模板文件数组数据添加编辑', '', '模板文件数组数据添加编辑');
INSERT INTO `cmf_admin_menu` VALUES ('105', '95', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataEditPost', '', '模板文件数组数据添加编辑提交保存', '', '模板文件数组数据添加编辑提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('106', '95', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataDelete', '', '模板文件数组数据删除', '', '模板文件数组数据删除');
INSERT INTO `cmf_admin_menu` VALUES ('107', '95', '2', '0', '10000', 'admin', 'Theme', 'settingPost', '', '模板文件编辑提交保存', '', '模板文件编辑提交保存');
INSERT INTO `cmf_admin_menu` VALUES ('108', '95', '1', '0', '10000', 'admin', 'Theme', 'dataSource', '', '模板文件设置数据源', '', '模板文件设置数据源');
INSERT INTO `cmf_admin_menu` VALUES ('109', '0', '0', '0', '10', 'user', 'AdminIndex', 'default', '', '用户管理', 'group', '用户管理');
INSERT INTO `cmf_admin_menu` VALUES ('110', '49', '1', '1', '10000', 'admin', 'User', 'index', '', '管理员', '', '管理员管理');
INSERT INTO `cmf_admin_menu` VALUES ('111', '110', '1', '0', '10000', 'admin', 'User', 'add', '', '管理员添加', '', '管理员添加');
INSERT INTO `cmf_admin_menu` VALUES ('112', '110', '2', '0', '10000', 'admin', 'User', 'addPost', '', '管理员添加提交', '', '管理员添加提交');
INSERT INTO `cmf_admin_menu` VALUES ('113', '110', '1', '0', '10000', 'admin', 'User', 'edit', '', '管理员编辑', '', '管理员编辑');
INSERT INTO `cmf_admin_menu` VALUES ('114', '110', '2', '0', '10000', 'admin', 'User', 'editPost', '', '管理员编辑提交', '', '管理员编辑提交');
INSERT INTO `cmf_admin_menu` VALUES ('115', '110', '1', '0', '10000', 'admin', 'User', 'userInfo', '', '个人信息', '', '管理员个人信息修改');
INSERT INTO `cmf_admin_menu` VALUES ('116', '110', '2', '0', '10000', 'admin', 'User', 'userInfoPost', '', '管理员个人信息修改提交', '', '管理员个人信息修改提交');
INSERT INTO `cmf_admin_menu` VALUES ('117', '110', '2', '0', '10000', 'admin', 'User', 'delete', '', '管理员删除', '', '管理员删除');
INSERT INTO `cmf_admin_menu` VALUES ('118', '110', '2', '0', '10000', 'admin', 'User', 'ban', '', '停用管理员', '', '停用管理员');
INSERT INTO `cmf_admin_menu` VALUES ('119', '110', '2', '0', '10000', 'admin', 'User', 'cancelBan', '', '启用管理员', '', '启用管理员');
INSERT INTO `cmf_admin_menu` VALUES ('120', '0', '0', '0', '30', 'portal', 'AdminIndex', 'default', '', '门户管理', 'th', '门户管理');
INSERT INTO `cmf_admin_menu` VALUES ('121', '120', '1', '1', '10000', 'portal', 'AdminArticle', 'index', '', '文章管理', '', '文章列表');
INSERT INTO `cmf_admin_menu` VALUES ('122', '121', '1', '0', '10000', 'portal', 'AdminArticle', 'add', '', '添加文章', '', '添加文章');
INSERT INTO `cmf_admin_menu` VALUES ('123', '121', '2', '0', '10000', 'portal', 'AdminArticle', 'addPost', '', '添加文章提交', '', '添加文章提交');
INSERT INTO `cmf_admin_menu` VALUES ('124', '121', '1', '0', '10000', 'portal', 'AdminArticle', 'edit', '', '编辑文章', '', '编辑文章');
INSERT INTO `cmf_admin_menu` VALUES ('125', '121', '2', '0', '10000', 'portal', 'AdminArticle', 'editPost', '', '编辑文章提交', '', '编辑文章提交');
INSERT INTO `cmf_admin_menu` VALUES ('126', '121', '2', '0', '10000', 'portal', 'AdminArticle', 'delete', '', '文章删除', '', '文章删除');
INSERT INTO `cmf_admin_menu` VALUES ('127', '121', '2', '0', '10000', 'portal', 'AdminArticle', 'publish', '', '文章发布', '', '文章发布');
INSERT INTO `cmf_admin_menu` VALUES ('128', '121', '2', '0', '10000', 'portal', 'AdminArticle', 'top', '', '文章置顶', '', '文章置顶');
INSERT INTO `cmf_admin_menu` VALUES ('129', '121', '2', '0', '10000', 'portal', 'AdminArticle', 'recommend', '', '文章推荐', '', '文章推荐');
INSERT INTO `cmf_admin_menu` VALUES ('130', '121', '2', '0', '10000', 'portal', 'AdminArticle', 'listOrder', '', '文章排序', '', '文章排序');
INSERT INTO `cmf_admin_menu` VALUES ('131', '164', '1', '1', '10000', 'portal', 'AdminCategory', 'index', '', '分类管理', '', '文章分类列表');
INSERT INTO `cmf_admin_menu` VALUES ('132', '131', '1', '0', '10000', 'portal', 'AdminCategory', 'add', '', '添加文章分类', '', '添加文章分类');
INSERT INTO `cmf_admin_menu` VALUES ('133', '131', '2', '0', '10000', 'portal', 'AdminCategory', 'addPost', '', '添加文章分类提交', '', '添加文章分类提交');
INSERT INTO `cmf_admin_menu` VALUES ('134', '131', '1', '0', '10000', 'portal', 'AdminCategory', 'edit', '', '编辑文章分类', '', '编辑文章分类');
INSERT INTO `cmf_admin_menu` VALUES ('135', '131', '2', '0', '10000', 'portal', 'AdminCategory', 'editPost', '', '编辑文章分类提交', '', '编辑文章分类提交');
INSERT INTO `cmf_admin_menu` VALUES ('136', '131', '1', '0', '10000', 'portal', 'AdminCategory', 'select', '', '文章分类选择对话框', '', '文章分类选择对话框');
INSERT INTO `cmf_admin_menu` VALUES ('137', '131', '2', '0', '10000', 'portal', 'AdminCategory', 'listOrder', '', '文章分类排序', '', '文章分类排序');
INSERT INTO `cmf_admin_menu` VALUES ('138', '131', '2', '0', '10000', 'portal', 'AdminCategory', 'delete', '', '删除文章分类', '', '删除文章分类');
INSERT INTO `cmf_admin_menu` VALUES ('139', '120', '1', '1', '10000', 'portal', 'AdminPage', 'index', '', '页面管理', '', '页面管理');
INSERT INTO `cmf_admin_menu` VALUES ('140', '139', '1', '0', '10000', 'portal', 'AdminPage', 'add', '', '添加页面', '', '添加页面');
INSERT INTO `cmf_admin_menu` VALUES ('141', '139', '2', '0', '10000', 'portal', 'AdminPage', 'addPost', '', '添加页面提交', '', '添加页面提交');
INSERT INTO `cmf_admin_menu` VALUES ('142', '139', '1', '0', '10000', 'portal', 'AdminPage', 'edit', '', '编辑页面', '', '编辑页面');
INSERT INTO `cmf_admin_menu` VALUES ('143', '139', '2', '0', '10000', 'portal', 'AdminPage', 'editPost', '', '编辑页面提交', '', '编辑页面提交');
INSERT INTO `cmf_admin_menu` VALUES ('144', '139', '2', '0', '10000', 'portal', 'AdminPage', 'delete', '', '删除页面', '', '删除页面');
INSERT INTO `cmf_admin_menu` VALUES ('145', '120', '1', '1', '10000', 'portal', 'AdminTag', 'index', '', '文章标签', '', '文章标签');
INSERT INTO `cmf_admin_menu` VALUES ('146', '145', '1', '0', '10000', 'portal', 'AdminTag', 'add', '', '添加文章标签', '', '添加文章标签');
INSERT INTO `cmf_admin_menu` VALUES ('147', '145', '2', '0', '10000', 'portal', 'AdminTag', 'addPost', '', '添加文章标签提交', '', '添加文章标签提交');
INSERT INTO `cmf_admin_menu` VALUES ('148', '145', '2', '0', '10000', 'portal', 'AdminTag', 'upStatus', '', '更新标签状态', '', '更新标签状态');
INSERT INTO `cmf_admin_menu` VALUES ('149', '145', '2', '0', '10000', 'portal', 'AdminTag', 'delete', '', '删除文章标签', '', '删除文章标签');
INSERT INTO `cmf_admin_menu` VALUES ('150', '0', '1', '0', '10000', 'user', 'AdminAsset', 'index', '', '资源管理', 'file', '资源管理列表');
INSERT INTO `cmf_admin_menu` VALUES ('151', '150', '2', '0', '10000', 'user', 'AdminAsset', 'delete', '', '删除文件', '', '删除文件');
INSERT INTO `cmf_admin_menu` VALUES ('152', '109', '0', '1', '10000', 'user', 'AdminIndex', 'default1', '', '用户组', '', '用户组');
INSERT INTO `cmf_admin_menu` VALUES ('153', '152', '1', '1', '10000', 'user', 'AdminIndex', 'index', '', '本站用户', '', '本站用户');
INSERT INTO `cmf_admin_menu` VALUES ('154', '153', '2', '0', '10000', 'user', 'AdminIndex', 'ban', '', '本站用户拉黑', '', '本站用户拉黑');
INSERT INTO `cmf_admin_menu` VALUES ('155', '153', '2', '0', '10000', 'user', 'AdminIndex', 'cancelBan', '', '本站用户启用', '', '本站用户启用');
INSERT INTO `cmf_admin_menu` VALUES ('156', '152', '1', '1', '10000', 'user', 'AdminOauth', 'index', '', '第三方用户', '', '第三方用户');
INSERT INTO `cmf_admin_menu` VALUES ('157', '156', '2', '0', '10000', 'user', 'AdminOauth', 'delete', '', '删除第三方用户绑定', '', '删除第三方用户绑定');
INSERT INTO `cmf_admin_menu` VALUES ('158', '6', '1', '1', '10000', 'user', 'AdminUserAction', 'index', '', '用户操作管理', '', '用户操作管理');
INSERT INTO `cmf_admin_menu` VALUES ('159', '158', '1', '0', '10000', 'user', 'AdminUserAction', 'edit', '', '编辑用户操作', '', '编辑用户操作');
INSERT INTO `cmf_admin_menu` VALUES ('160', '158', '2', '0', '10000', 'user', 'AdminUserAction', 'editPost', '', '编辑用户操作提交', '', '编辑用户操作提交');
INSERT INTO `cmf_admin_menu` VALUES ('161', '158', '1', '0', '10000', 'user', 'AdminUserAction', 'sync', '', '同步用户操作', '', '同步用户操作');
INSERT INTO `cmf_admin_menu` VALUES ('162', '0', '1', '1', '10000', 'Portal', 'AdminUser', 'default', '', '会员中心', 'user', '');
INSERT INTO `cmf_admin_menu` VALUES ('163', '162', '1', '1', '10000', 'Portal', 'AdminUser', 'index', '', '会员管理', '', '');
INSERT INTO `cmf_admin_menu` VALUES ('164', '0', '1', '1', '10000', 'Portal', 'AdminAsk', 'default', '', '考题管理', 'grav', '');
INSERT INTO `cmf_admin_menu` VALUES ('165', '164', '1', '0', '10000', 'Portal', 'AdminCate', 'index', '', '分类管理(self)', '', '');
INSERT INTO `cmf_admin_menu` VALUES ('166', '0', '1', '1', '10000', 'Portal', 'AdminZa', 'default', '', '杂项', 'heartbeat', '');
INSERT INTO `cmf_admin_menu` VALUES ('167', '164', '1', '1', '10000', 'Portal', 'AdminAsk', 'index', '', '题目管理', '', '');
INSERT INTO `cmf_admin_menu` VALUES ('168', '162', '1', '1', '10000', 'portal', 'AdminAdvice', 'index', '', '用户留言', '', '全部留言');
INSERT INTO `cmf_admin_menu` VALUES ('169', '168', '1', '0', '10000', 'portal', 'AdminAdvice', 'reply', '', '留言回复', '', '留言回复');
INSERT INTO `cmf_admin_menu` VALUES ('170', '168', '2', '0', '10000', 'portal', 'AdminAdvice', 'replyPost', '', '留言回复提交', '', '留言回复提交');
INSERT INTO `cmf_admin_menu` VALUES ('171', '162', '1', '1', '10000', 'portal', 'AdminOrder', 'index', '', '订单管理', '', '订单管理');
INSERT INTO `cmf_admin_menu` VALUES ('172', '162', '1', '1', '10000', 'portal', 'AdminUask', 'index', '', '反馈管理', '', '反馈管理');
INSERT INTO `cmf_admin_menu` VALUES ('173', '162', '1', '1', '10000', 'portal', 'AdminEask', 'index', '', '用户纠错', '', '用户纠错');
INSERT INTO `cmf_admin_menu` VALUES ('174', '164', '1', '1', '10000', 'portal', 'AdminExamintro', 'index', '', '考试介绍', '', '考试介绍');
INSERT INTO `cmf_admin_menu` VALUES ('175', '164', '1', '1', '10000', 'portal', 'AdminExampoint', 'index', '', '考点提炼', '', '考点提炼');
INSERT INTO `cmf_admin_menu` VALUES ('176', '166', '1', '1', '10000', 'Portal', 'AdminOnepage', 'regart', '', '用户注册协议及免责声明', '', '');
INSERT INTO `cmf_admin_menu` VALUES ('177', '166', '1', '1', '10000', 'Portal', 'AdminNews', 'index', '', '新闻资讯', '', '');
INSERT INTO `cmf_admin_menu` VALUES ('178', '166', '1', '0', '10000', 'Portal', 'AdminTest', 'index', '', '测试', '', '');

-- ----------------------------
-- Table structure for cmf_advice
-- ----------------------------
DROP TABLE IF EXISTS `cmf_advice`;
CREATE TABLE `cmf_advice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `content` varchar(255) NOT NULL COMMENT '留言内容',
  `create_time` datetime NOT NULL COMMENT '留言时间',
  `reply_content` varchar(255) DEFAULT NULL COMMENT '回复内容',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='留言表';

-- ----------------------------
-- Records of cmf_advice
-- ----------------------------
INSERT INTO `cmf_advice` VALUES ('1', '2', '这是测试的第一条留言', '2018-07-18 17:13:39', '嗯嗯嗯，知道了！', '2018-07-18 18:04:44');
INSERT INTO `cmf_advice` VALUES ('2', '2', '我为什么这么可爱呢？', '2018-08-16 14:20:35', '臭不要脸！', '2018-08-16 14:21:07');
INSERT INTO `cmf_advice` VALUES ('3', '45', '飞行员APP课程模块好复杂', '2018-10-12 15:51:37', null, null);

-- ----------------------------
-- Table structure for cmf_allask
-- ----------------------------
DROP TABLE IF EXISTS `cmf_allask`;
CREATE TABLE `cmf_allask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `cate_id` int(11) NOT NULL COMMENT '一级分类id',
  `if_end` tinyint(1) NOT NULL COMMENT '0未结束，1已结束',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='答全部题目功能表';

-- ----------------------------
-- Records of cmf_allask
-- ----------------------------
INSERT INTO `cmf_allask` VALUES ('1', '46', '6', '0', '2018-10-22 16:36:00');

-- ----------------------------
-- Table structure for cmf_allask_detail
-- ----------------------------
DROP TABLE IF EXISTS `cmf_allask_detail`;
CREATE TABLE `cmf_allask_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `allask_id` int(11) NOT NULL,
  `ask_id` int(11) NOT NULL,
  `right_option_id` int(11) NOT NULL,
  `user_option_id` int(11) NOT NULL,
  `is_right` tinyint(4) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmf_allask_detail
-- ----------------------------
INSERT INTO `cmf_allask_detail` VALUES ('1', '1', '19', '78', '78', '1', '2018-10-22 17:29:25');

-- ----------------------------
-- Table structure for cmf_ask
-- ----------------------------
DROP TABLE IF EXISTS `cmf_ask`;
CREATE TABLE `cmf_ask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) NOT NULL COMMENT '分类id',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `title_text` varchar(255) NOT NULL COMMENT '文字题目',
  `title_pic` varchar(255) DEFAULT NULL COMMENT '图片题目(json)',
  `option_id` int(11) NOT NULL COMMENT '正确答案',
  `option_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '选项是图片还是文字(0文字，1图片)',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='题目表';

-- ----------------------------
-- Records of cmf_ask
-- ----------------------------
INSERT INTO `cmf_ask` VALUES ('19', '18', '1', '选项为文字的题？？', '[\"portal\\/20180718\\/dfdf57071e41f2a13e0c64548d331a50.png\",\"portal\\/20180816\\/1bc55c0de96f933a620aa3c180d5cfdf.jpeg\"]', '78', '0', '2018-09-29 10:16:40');
INSERT INTO `cmf_ask` VALUES ('20', '18', '2', '选项为图片的题？？', '[\"portal\\/20180717\\/630a64ef7e3eb4fba2c94d3cd4396285.png\"]', '87', '1', '2018-09-29 10:17:17');
INSERT INTO `cmf_ask` VALUES ('21', '18', '3', '选项为文字的题2？？', '', '89', '0', '2018-09-29 10:23:24');
INSERT INTO `cmf_ask` VALUES ('22', '28', '1', '测试题目1', '', '93', '0', '2018-10-22 11:49:49');
INSERT INTO `cmf_ask` VALUES ('23', '28', '2', '测试题目2', '', '98', '0', '2018-10-22 11:50:22');
INSERT INTO `cmf_ask` VALUES ('24', '28', '3', '测试题目3', '', '103', '0', '2018-10-22 11:51:13');

-- ----------------------------
-- Table structure for cmf_ask_analysis
-- ----------------------------
DROP TABLE IF EXISTS `cmf_ask_analysis`;
CREATE TABLE `cmf_ask_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ask_id` int(11) NOT NULL COMMENT '题目表id',
  `analysis_content` varchar(255) NOT NULL COMMENT '解析内容',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='解析表';

-- ----------------------------
-- Records of cmf_ask_analysis
-- ----------------------------
INSERT INTO `cmf_ask_analysis` VALUES ('13', '19', '啦啦啦啦啦啦啦啦', '2018-09-29 10:16:40');
INSERT INTO `cmf_ask_analysis` VALUES ('14', '20', '少时诵诗书所所', '2018-09-29 10:17:17');
INSERT INTO `cmf_ask_analysis` VALUES ('15', '21', '哈哈哈哈', null);
INSERT INTO `cmf_ask_analysis` VALUES ('16', '22', '111111111111111', null);
INSERT INTO `cmf_ask_analysis` VALUES ('17', '23', '22222222222', null);
INSERT INTO `cmf_ask_analysis` VALUES ('18', '24', '33333333333333', null);

-- ----------------------------
-- Table structure for cmf_ask_option
-- ----------------------------
DROP TABLE IF EXISTS `cmf_ask_option`;
CREATE TABLE `cmf_ask_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ask_id` int(11) NOT NULL COMMENT '题目表id',
  `option_content` varchar(255) NOT NULL COMMENT '选项内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='选项表';

-- ----------------------------
-- Records of cmf_ask_option
-- ----------------------------
INSERT INTO `cmf_ask_option` VALUES ('77', '19', '哈哈哈');
INSERT INTO `cmf_ask_option` VALUES ('78', '19', '快快快');
INSERT INTO `cmf_ask_option` VALUES ('79', '19', '啊啊啊');
INSERT INTO `cmf_ask_option` VALUES ('80', '19', '嗯嗯嗯');
INSERT INTO `cmf_ask_option` VALUES ('85', '20', 'portal/20180717/630a64ef7e3eb4fba2c94d3cd4396285.png');
INSERT INTO `cmf_ask_option` VALUES ('86', '20', 'portal/20180718/7d94e641a2971759efd6555325d26b3f.png');
INSERT INTO `cmf_ask_option` VALUES ('87', '20', 'portal/20180717/1787a52044d01c8312dce29dbb26e91c.png');
INSERT INTO `cmf_ask_option` VALUES ('88', '20', 'portal/20180717/88bb7259dd15870fa27e630c7d9319da.png');
INSERT INTO `cmf_ask_option` VALUES ('89', '21', '啦啦啦');
INSERT INTO `cmf_ask_option` VALUES ('90', '21', '大大大大');
INSERT INTO `cmf_ask_option` VALUES ('91', '21', '额鹅鹅鹅');
INSERT INTO `cmf_ask_option` VALUES ('92', '21', '嘎嘎嘎嘎');
INSERT INTO `cmf_ask_option` VALUES ('93', '22', 'AAAAAAA');
INSERT INTO `cmf_ask_option` VALUES ('94', '22', 'BBBBBBBB');
INSERT INTO `cmf_ask_option` VALUES ('95', '22', 'CCCCCCCC');
INSERT INTO `cmf_ask_option` VALUES ('96', '22', 'DDDDDDD');
INSERT INTO `cmf_ask_option` VALUES ('97', '23', 'AAAAAAAA');
INSERT INTO `cmf_ask_option` VALUES ('98', '23', 'BBBBBBBB');
INSERT INTO `cmf_ask_option` VALUES ('99', '23', 'CCCCCCC');
INSERT INTO `cmf_ask_option` VALUES ('100', '23', 'DDDDDDD');
INSERT INTO `cmf_ask_option` VALUES ('101', '24', 'AAAAAAA');
INSERT INTO `cmf_ask_option` VALUES ('102', '24', 'BBBBBBB');
INSERT INTO `cmf_ask_option` VALUES ('103', '24', 'CCCCCCCC');
INSERT INTO `cmf_ask_option` VALUES ('104', '24', 'DDDDDD');

-- ----------------------------
-- Table structure for cmf_ask_status
-- ----------------------------
DROP TABLE IF EXISTS `cmf_ask_status`;
CREATE TABLE `cmf_ask_status` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0->关闭，1->答对自动下一题，2->只显示正确答案',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='答题状态表';

-- ----------------------------
-- Records of cmf_ask_status
-- ----------------------------
INSERT INTO `cmf_ask_status` VALUES ('0', '45', '1');

-- ----------------------------
-- Table structure for cmf_asset
-- ----------------------------
DROP TABLE IF EXISTS `cmf_asset`;
CREATE TABLE `cmf_asset` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小,单位B',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `file_key` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `file_path` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件路径,相对于upload目录,可以为url',
  `file_md5` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `more` text COMMENT '其它详细信息,JSON格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

-- ----------------------------
-- Records of cmf_asset
-- ----------------------------
INSERT INTO `cmf_asset` VALUES ('1', '1', '765873', '1530768138', '1', '0', '46d4f1a3908f8c7767bff58996b38cac5f43b3a6596dc307b456a99d5030b851', '5017a4f0f1ca4.jpg', 'admin/20180705/d6ed09ff50239ac28462597bfb71ea5b.jpg', '46d4f1a3908f8c7767bff58996b38cac', '731b22d04b8b9fe7ab202a5475c2bc23807a0140', 'jpg', null);
INSERT INTO `cmf_asset` VALUES ('2', '1', '558696', '1530768178', '1', '0', '1b2a898450d911ab04ea7bdb232db5bf58a2c3c1001a76132675c519e3d45c4a', 'ChMkJlnF0vKIPFlaANd0cSO7qRUAAguMgJ2LX4A13SJ836.jpg', 'admin/20180705/fe2d42121c3ad245fd2d14315a37a7dc.jpg', '1b2a898450d911ab04ea7bdb232db5bf', '29b870054df97b25362a253f2d599ddeace2d147', 'jpg', null);
INSERT INTO `cmf_asset` VALUES ('3', '1', '1736414', '1530768218', '1', '0', '67c62295531783268f95b6225e04998bfadac195804836cfb00e88d821a13dc5', '26294dc90dc615dccaa998c84f82c1d7.jpeg', 'admin/20180705/7dd6ed8c02f72d13400dce60f012aaf1.jpeg', '67c62295531783268f95b6225e04998b', '76c39ea022938e7c32036cb41f6b1f69440c777d', 'jpeg', null);
INSERT INTO `cmf_asset` VALUES ('4', '1', '5974', '1531821885', '1', '0', '0e94df00f6567f37ee55f5a1bc373ef9d82a0593b8f9efaa7b9048a302a2bee5', 'icon (3).png', 'portal/20180717/630a64ef7e3eb4fba2c94d3cd4396285.png', '0e94df00f6567f37ee55f5a1bc373ef9', '0cfd2c439295a9d822bae17e2d35895d0d22a601', 'png', null);
INSERT INTO `cmf_asset` VALUES ('5', '1', '1371', '1531821885', '1', '0', 'a550834bfd956ef84ec623f873e0da29cb8bae54011a5953e6443e39b9173108', 'menu_icon1_select@2x.png', 'portal/20180717/c32cdfc637153783cd6fd6217e2135e3.png', 'a550834bfd956ef84ec623f873e0da29', 'f3c13dcc4358479bbf208d3333232c20b673ce02', 'png', null);
INSERT INTO `cmf_asset` VALUES ('6', '1', '1737', '1531821928', '1', '0', 'eda4fe85c97161a7de5329ab3796cfe1217adfae35b9b0cad0e166c394cbe818', 'menu_icon3_normal@2x.png', 'portal/20180717/ec9333ad74999da64f6562bfdc55ad88.png', 'eda4fe85c97161a7de5329ab3796cfe1', '3f8d495d41c895fcfccbd0564bd0352e6eb4dd32', 'png', null);
INSERT INTO `cmf_asset` VALUES ('7', '1', '1413', '1531821928', '1', '0', '2d722e41802de2879b9992d2a58d56699bffe155ef613c3c3de5b4b1f280c913', 'menu_icon3_select@2x.png', 'portal/20180717/88bb7259dd15870fa27e630c7d9319da.png', '2d722e41802de2879b9992d2a58d5669', '034549f83c1d2178fdafdde416024e2677bdaa53', 'png', null);
INSERT INTO `cmf_asset` VALUES ('8', '1', '1714', '1531822063', '1', '0', 'dd59e0a4012c5014585db8a77172914dc4118b54186f15a480f0ebf6e34e2cef', 'menu_icon2_select@2x.png', 'portal/20180717/ebe16e7ad34c0155a4c068af8a1249cb.png', 'dd59e0a4012c5014585db8a77172914d', '06142da34a9b0a5d499ae29a88d6e992661e9330', 'png', null);
INSERT INTO `cmf_asset` VALUES ('9', '1', '1941', '1531824425', '1', '0', 'd55136c64371f25515518eb5aca0ac6657d7f5a99e7f15d2e3ed84ecb36296d7', 'menu_icon2_normal@2x.png', 'portal/20180717/1787a52044d01c8312dce29dbb26e91c.png', 'd55136c64371f25515518eb5aca0ac66', '49ff4d25fbae6e8daeda0e1ca8f76f346da756b8', 'png', null);
INSERT INTO `cmf_asset` VALUES ('10', '1', '6223', '1531877933', '1', '0', 'ba9028db274925b51fdfbaa972db583d29c04c6b817d31788252fa15ee914d48', 'icon (4).png', 'portal/20180718/7d94e641a2971759efd6555325d26b3f.png', 'ba9028db274925b51fdfbaa972db583d', '49e42ad996448e2e792d87de21514a30e256f04a', 'png', null);
INSERT INTO `cmf_asset` VALUES ('11', '1', '6049', '1531877933', '1', '0', '08acfd65ff0a427c7827f102532ebeb61927854d30ef1a138e3fdb8de8888e44', 'icon (5).png', 'portal/20180718/dfdf57071e41f2a13e0c64548d331a50.png', '08acfd65ff0a427c7827f102532ebeb6', '6aa244fe018f1f59a90c4fe5c9b2d8e2a52ab9c4', 'png', null);
INSERT INTO `cmf_asset` VALUES ('12', '1', '281146', '1531896966', '1', '0', '125f22ef4f39477209204b945e9097ed4339165f9902079056424bc9ae5718d9', 'icon (2).png', 'portal/20180718/73a587696a28a8ccfc34856571ad1ec2.png', '125f22ef4f39477209204b945e9097ed', '5c533b8787db2f45c097d8a4b98cb27ea57fc6a5', 'png', null);
INSERT INTO `cmf_asset` VALUES ('13', '1', '3515', '1531897299', '1', '0', '80bd6e2cbbe44941bb84bf1af90004305ee99edfb5009d15a4dadc9dcc283a4a', 'icon (7).png', 'portal/20180718/770d4abeee4e08e6aef5fe6a23ac38e3.png', '80bd6e2cbbe44941bb84bf1af9000430', '0f9aed1967b66425e9c8394a4b40b29909de74c3', 'png', null);
INSERT INTO `cmf_asset` VALUES ('14', '1', '2576', '1531897320', '1', '0', '364c5f24e84b5a0935100125f021c75b0d2e9f61cda896712ae517fab5265507', 'icon (6).png', 'portal/20180718/12903a5bfbb90b0ac042e78c3aa971ff.png', '364c5f24e84b5a0935100125f021c75b', 'c39dd33398a89eae284c62e00277e8938389424a', 'png', null);
INSERT INTO `cmf_asset` VALUES ('15', '1', '7540', '1531897487', '1', '0', '582720cadc2fa8c3ac6f0b44a0ee909d034eebb5adf658d1901ab4622998bad1', 'avatar.jpg', 'portal/20180718/c4fc3e2b2d5222b56a0d62e58b34f866.jpg', '582720cadc2fa8c3ac6f0b44a0ee909d', '696aba725f5ef220fafa4559e2a09b0b6cc83c36', 'jpg', null);
INSERT INTO `cmf_asset` VALUES ('16', '1', '188568', '1534323471', '1', '0', '02bbb3450efcc9e72e41afee30f7664e31440aad8d420b7567a40a53a334e35c', 'QQ截图20180801164827.png', 'portal/20180815/e552017a67be25b0f5244f22052f02f2.png', '02bbb3450efcc9e72e41afee30f7664e', '5dc69576106c2b0a51e3324c9791c863f6430dc2', 'png', null);
INSERT INTO `cmf_asset` VALUES ('17', '1', '222131', '1534324204', '1', '0', 'f87e5663ec64024aeff41e0ca10c561218124df74706e40d4ec546f10647e06e', 'QQ截图20180801164859.png', 'portal/20180815/e5b735e73500390ab4b1d83ac3250853.png', 'f87e5663ec64024aeff41e0ca10c5612', '697904e1a2af50e58b5bbc7e0804cd2fe7e12e04', 'png', null);
INSERT INTO `cmf_asset` VALUES ('18', '1', '95116', '1534324570', '1', '0', '3dad874cf45db865862f274ee9690ca51b4d8106f483830984b2e0f31f25f272', '180717_49a5lga51581i9507fk6a364dg7ic_768x440.jpg', 'portal/20180815/649bd3dedc70df85488d0b1c7d413f81.jpg', '3dad874cf45db865862f274ee9690ca5', '466ef27d954e68d4de63df77b943a9c5270dd765', 'jpg', null);
INSERT INTO `cmf_asset` VALUES ('19', '0', '7540', '1534390201', '1', '0', '582720cadc2fa8c3ac6f0b44a0ee909d034eebb5adf658d1901ab4622998bad1', 'avatar.jpg', 'default/20180816/49f2948d0134f52e4e6cfc0a4df7b25e.jpg', '582720cadc2fa8c3ac6f0b44a0ee909d', '696aba725f5ef220fafa4559e2a09b0b6cc83c36', 'jpg', null);
INSERT INTO `cmf_asset` VALUES ('20', '0', '178537', '1534390820', '1', '0', 'fbb8c539e7fc1dacdd83546f3558e7d5e9440322e10914ed85036c314d30c67e', 'a58efcbf1d5a073e5260d19bd262a538.jpeg', 'default/20180816/7d16c9de4d8043037892161feda6d003.jpeg', 'fbb8c539e7fc1dacdd83546f3558e7d5', 'e9eb9fd74f3fe9aec4cebbac93c9d8db6ec219ad', 'jpeg', null);
INSERT INTO `cmf_asset` VALUES ('21', '1', '178537', '1534409314', '1', '0', 'fbb8c539e7fc1dacdd83546f3558e7d5e9440322e10914ed85036c314d30c67e', 'a58efcbf1d5a073e5260d19bd262a538.jpeg', 'portal/20180816/1bc55c0de96f933a620aa3c180d5cfdf.jpeg', 'fbb8c539e7fc1dacdd83546f3558e7d5', 'e9eb9fd74f3fe9aec4cebbac93c9d8db6ec219ad', 'jpeg', null);
INSERT INTO `cmf_asset` VALUES ('22', '1', '5975', '1538205995', '1', '0', 'bafbd5cfb8caa1bf868330ce9a2c9be71491e61f14881f4aaf6c8d1bcba61a8c', 'aicon10@2x.png', 'portal/20180929/f4e070a7a3b6176f62ef392f5f59b645.png', 'bafbd5cfb8caa1bf868330ce9a2c9be7', '1bfe07d3fbaa5e8974a864e344bc993fd4ea961c', 'png', null);
INSERT INTO `cmf_asset` VALUES ('23', '1', '6653', '1538206134', '1', '0', '937bf4df0b9d8537e25a5921eb2e3c326a7cc58ed58631eb2c953c196f32a08f', 'aicon01@2x.png', 'portal/20180929/c7c1c3edcc54a8bf6b84890b11bc2a8a.png', '937bf4df0b9d8537e25a5921eb2e3c32', '7b81f9aa2aa7ecd4317cd7d91995c3fda66883b3', 'png', null);
INSERT INTO `cmf_asset` VALUES ('24', '1', '7612', '1538206154', '1', '0', 'd8324e9da1a106036f4b951282345afcbae8f3c63f6c64d40cc48119566f3980', 'aicon02@2x.png', 'portal/20180929/cdcdb99a07838b6bc8bfb178d5b9a4f3.png', 'd8324e9da1a106036f4b951282345afc', 'ab37c2ea155262291942e3477e11dfc44d15c631', 'png', null);
INSERT INTO `cmf_asset` VALUES ('25', '1', '8620', '1538206174', '1', '0', '546e9b08b49ce941b4c0c1c44f83575f34b48dd79e5d7b764fd7ba2412a66cec', 'aicon04@2x.png', 'portal/20180929/e676e5b131e5b00087c8836283439e27.png', '546e9b08b49ce941b4c0c1c44f83575f', '9e375dc85562a543cf01ce1b5cc3a944e6d6c97f', 'png', null);
INSERT INTO `cmf_asset` VALUES ('26', '1', '7561', '1538206190', '1', '0', '22fd9d2821f2d500bc8c343b50c78e2f4c7cd3bd37dc27edd3513ed92f0c8860', 'aicon03@2x.png', 'portal/20180929/f8ff6378fe01e896f6b432d08c21d3da.png', '22fd9d2821f2d500bc8c343b50c78e2f', 'cd24b52c3cdcdccab14bba3d83edd85925abe93e', 'png', null);
INSERT INTO `cmf_asset` VALUES ('27', '1', '8755', '1538206207', '1', '0', '59702e3077084b74d8bba1ab48d1004456ce85b0c20d9d8ae5ca59713efabca8', 'aicon05@2x.png', 'portal/20180929/296a3f0cc94318d19ca022578bfacd08.png', '59702e3077084b74d8bba1ab48d10044', 'ec259cdcab9dc4427817186d08167f847564e462', 'png', null);
INSERT INTO `cmf_asset` VALUES ('28', '1', '7774', '1538206224', '1', '0', 'de18b9178a6fb7b8a99534c407c2afadc92f68f72f52897359d17c81f37cb6ce', 'aicon06@2x.png', 'portal/20180929/bdaeeba24ad81eeb3b8a5bb51774cd43.png', 'de18b9178a6fb7b8a99534c407c2afad', '67a5acc2fc4c678f540ecce158bc9de76e5d7795', 'png', null);
INSERT INTO `cmf_asset` VALUES ('29', '1', '8216', '1538206246', '1', '0', 'bb87272629ba8b89f5acc2aeece029423add4cb57033063f4b1cf909fda594ac', 'aicon07@2x.png', 'portal/20180929/26c86a4f02df831b388bee1df0b838b7.png', 'bb87272629ba8b89f5acc2aeece02942', '5a84352172ff176a7072ee963a94e0917ebe1add', 'png', null);
INSERT INTO `cmf_asset` VALUES ('30', '1', '6783', '1538206267', '1', '0', '669732d85122e9fcc606dac3c0e8a0173f85aa642a95e4ab1af66affb9cd1191', 'aicon09@2x.png', 'portal/20180929/4d6193ced0f91825f6a26cc77e4fa86c.png', '669732d85122e9fcc606dac3c0e8a017', 'efd284acadc3c85f55991307446f3bcfaf2b8287', 'png', null);
INSERT INTO `cmf_asset` VALUES ('31', '1', '23040', '1539148082', '1', '0', 'f2fa993405bef5955808145ad04f925bb39b348beb463cd3d41e4c06a1132193', 'studio19.jpg', 'default/20181010/0730a61e79e70420409fc31b981b2908.jpg', 'f2fa993405bef5955808145ad04f925b', '762b0ccf263d6b0796372a33a65a155dbdcf4a99', 'jpg', null);

-- ----------------------------
-- Table structure for cmf_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `cmf_auth_access`;
CREATE TABLE `cmf_auth_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类,请加应用前缀,如admin_',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Records of cmf_auth_access
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `cmf_auth_rule`;
CREATE TABLE `cmf_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `app` varchar(15) NOT NULL COMMENT '规则所属module',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) NOT NULL DEFAULT '' COMMENT '额外url参数',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则描述',
  `condition` varchar(200) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `module` (`app`,`status`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COMMENT='权限规则表';

-- ----------------------------
-- Records of cmf_auth_rule
-- ----------------------------
INSERT INTO `cmf_auth_rule` VALUES ('1', '1', 'admin', 'admin_url', 'admin/Hook/index', '', '钩子管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('2', '1', 'admin', 'admin_url', 'admin/Hook/plugins', '', '钩子插件管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('3', '1', 'admin', 'admin_url', 'admin/Hook/pluginListOrder', '', '钩子插件排序', '');
INSERT INTO `cmf_auth_rule` VALUES ('4', '1', 'admin', 'admin_url', 'admin/Hook/sync', '', '同步钩子', '');
INSERT INTO `cmf_auth_rule` VALUES ('5', '1', 'admin', 'admin_url', 'admin/Link/index', '', '友情链接', '');
INSERT INTO `cmf_auth_rule` VALUES ('6', '1', 'admin', 'admin_url', 'admin/Link/add', '', '添加友情链接', '');
INSERT INTO `cmf_auth_rule` VALUES ('7', '1', 'admin', 'admin_url', 'admin/Link/addPost', '', '添加友情链接提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('8', '1', 'admin', 'admin_url', 'admin/Link/edit', '', '编辑友情链接', '');
INSERT INTO `cmf_auth_rule` VALUES ('9', '1', 'admin', 'admin_url', 'admin/Link/editPost', '', '编辑友情链接提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('10', '1', 'admin', 'admin_url', 'admin/Link/delete', '', '删除友情链接', '');
INSERT INTO `cmf_auth_rule` VALUES ('11', '1', 'admin', 'admin_url', 'admin/Link/listOrder', '', '友情链接排序', '');
INSERT INTO `cmf_auth_rule` VALUES ('12', '1', 'admin', 'admin_url', 'admin/Link/toggle', '', '友情链接显示隐藏', '');
INSERT INTO `cmf_auth_rule` VALUES ('13', '1', 'admin', 'admin_url', 'admin/Mailer/index', '', '邮箱配置', '');
INSERT INTO `cmf_auth_rule` VALUES ('14', '1', 'admin', 'admin_url', 'admin/Mailer/indexPost', '', '邮箱配置提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('15', '1', 'admin', 'admin_url', 'admin/Mailer/template', '', '邮件模板', '');
INSERT INTO `cmf_auth_rule` VALUES ('16', '1', 'admin', 'admin_url', 'admin/Mailer/templatePost', '', '邮件模板提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('17', '1', 'admin', 'admin_url', 'admin/Mailer/test', '', '邮件发送测试', '');
INSERT INTO `cmf_auth_rule` VALUES ('18', '1', 'admin', 'admin_url', 'admin/Menu/index', '', '后台菜单', '');
INSERT INTO `cmf_auth_rule` VALUES ('19', '1', 'admin', 'admin_url', 'admin/Menu/lists', '', '所有菜单', '');
INSERT INTO `cmf_auth_rule` VALUES ('20', '1', 'admin', 'admin_url', 'admin/Menu/add', '', '后台菜单添加', '');
INSERT INTO `cmf_auth_rule` VALUES ('21', '1', 'admin', 'admin_url', 'admin/Menu/addPost', '', '后台菜单添加提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('22', '1', 'admin', 'admin_url', 'admin/Menu/edit', '', '后台菜单编辑', '');
INSERT INTO `cmf_auth_rule` VALUES ('23', '1', 'admin', 'admin_url', 'admin/Menu/editPost', '', '后台菜单编辑提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('24', '1', 'admin', 'admin_url', 'admin/Menu/delete', '', '后台菜单删除', '');
INSERT INTO `cmf_auth_rule` VALUES ('25', '1', 'admin', 'admin_url', 'admin/Menu/listOrder', '', '后台菜单排序', '');
INSERT INTO `cmf_auth_rule` VALUES ('26', '1', 'admin', 'admin_url', 'admin/Menu/getActions', '', '导入新后台菜单', '');
INSERT INTO `cmf_auth_rule` VALUES ('27', '1', 'admin', 'admin_url', 'admin/Nav/index', '', '导航管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('28', '1', 'admin', 'admin_url', 'admin/Nav/add', '', '添加导航', '');
INSERT INTO `cmf_auth_rule` VALUES ('29', '1', 'admin', 'admin_url', 'admin/Nav/addPost', '', '添加导航提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('30', '1', 'admin', 'admin_url', 'admin/Nav/edit', '', '编辑导航', '');
INSERT INTO `cmf_auth_rule` VALUES ('31', '1', 'admin', 'admin_url', 'admin/Nav/editPost', '', '编辑导航提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('32', '1', 'admin', 'admin_url', 'admin/Nav/delete', '', '删除导航', '');
INSERT INTO `cmf_auth_rule` VALUES ('33', '1', 'admin', 'admin_url', 'admin/NavMenu/index', '', '导航菜单', '');
INSERT INTO `cmf_auth_rule` VALUES ('34', '1', 'admin', 'admin_url', 'admin/NavMenu/add', '', '添加导航菜单', '');
INSERT INTO `cmf_auth_rule` VALUES ('35', '1', 'admin', 'admin_url', 'admin/NavMenu/addPost', '', '添加导航菜单提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('36', '1', 'admin', 'admin_url', 'admin/NavMenu/edit', '', '编辑导航菜单', '');
INSERT INTO `cmf_auth_rule` VALUES ('37', '1', 'admin', 'admin_url', 'admin/NavMenu/editPost', '', '编辑导航菜单提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('38', '1', 'admin', 'admin_url', 'admin/NavMenu/delete', '', '删除导航菜单', '');
INSERT INTO `cmf_auth_rule` VALUES ('39', '1', 'admin', 'admin_url', 'admin/NavMenu/listOrder', '', '导航菜单排序', '');
INSERT INTO `cmf_auth_rule` VALUES ('40', '1', 'admin', 'admin_url', 'admin/Plugin/default', '', '插件中心', '');
INSERT INTO `cmf_auth_rule` VALUES ('41', '1', 'admin', 'admin_url', 'admin/Plugin/index', '', '插件列表', '');
INSERT INTO `cmf_auth_rule` VALUES ('42', '1', 'admin', 'admin_url', 'admin/Plugin/toggle', '', '插件启用禁用', '');
INSERT INTO `cmf_auth_rule` VALUES ('43', '1', 'admin', 'admin_url', 'admin/Plugin/setting', '', '插件设置', '');
INSERT INTO `cmf_auth_rule` VALUES ('44', '1', 'admin', 'admin_url', 'admin/Plugin/settingPost', '', '插件设置提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('45', '1', 'admin', 'admin_url', 'admin/Plugin/install', '', '插件安装', '');
INSERT INTO `cmf_auth_rule` VALUES ('46', '1', 'admin', 'admin_url', 'admin/Plugin/update', '', '插件更新', '');
INSERT INTO `cmf_auth_rule` VALUES ('47', '1', 'admin', 'admin_url', 'admin/Plugin/uninstall', '', '卸载插件', '');
INSERT INTO `cmf_auth_rule` VALUES ('48', '1', 'admin', 'admin_url', 'admin/Rbac/index', '', '角色管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('49', '1', 'admin', 'admin_url', 'admin/Rbac/roleAdd', '', '添加角色', '');
INSERT INTO `cmf_auth_rule` VALUES ('50', '1', 'admin', 'admin_url', 'admin/Rbac/roleAddPost', '', '添加角色提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('51', '1', 'admin', 'admin_url', 'admin/Rbac/roleEdit', '', '编辑角色', '');
INSERT INTO `cmf_auth_rule` VALUES ('52', '1', 'admin', 'admin_url', 'admin/Rbac/roleEditPost', '', '编辑角色提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('53', '1', 'admin', 'admin_url', 'admin/Rbac/roleDelete', '', '删除角色', '');
INSERT INTO `cmf_auth_rule` VALUES ('54', '1', 'admin', 'admin_url', 'admin/Rbac/authorize', '', '设置角色权限', '');
INSERT INTO `cmf_auth_rule` VALUES ('55', '1', 'admin', 'admin_url', 'admin/Rbac/authorizePost', '', '角色授权提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('56', '1', 'admin', 'admin_url', 'admin/RecycleBin/index', '', '回收站', '');
INSERT INTO `cmf_auth_rule` VALUES ('57', '1', 'admin', 'admin_url', 'admin/RecycleBin/restore', '', '回收站还原', '');
INSERT INTO `cmf_auth_rule` VALUES ('58', '1', 'admin', 'admin_url', 'admin/RecycleBin/delete', '', '回收站彻底删除', '');
INSERT INTO `cmf_auth_rule` VALUES ('59', '1', 'admin', 'admin_url', 'admin/Route/index', '', 'URL美化', '');
INSERT INTO `cmf_auth_rule` VALUES ('60', '1', 'admin', 'admin_url', 'admin/Route/add', '', '添加路由规则', '');
INSERT INTO `cmf_auth_rule` VALUES ('61', '1', 'admin', 'admin_url', 'admin/Route/addPost', '', '添加路由规则提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('62', '1', 'admin', 'admin_url', 'admin/Route/edit', '', '路由规则编辑', '');
INSERT INTO `cmf_auth_rule` VALUES ('63', '1', 'admin', 'admin_url', 'admin/Route/editPost', '', '路由规则编辑提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('64', '1', 'admin', 'admin_url', 'admin/Route/delete', '', '路由规则删除', '');
INSERT INTO `cmf_auth_rule` VALUES ('65', '1', 'admin', 'admin_url', 'admin/Route/ban', '', '路由规则禁用', '');
INSERT INTO `cmf_auth_rule` VALUES ('66', '1', 'admin', 'admin_url', 'admin/Route/open', '', '路由规则启用', '');
INSERT INTO `cmf_auth_rule` VALUES ('67', '1', 'admin', 'admin_url', 'admin/Route/listOrder', '', '路由规则排序', '');
INSERT INTO `cmf_auth_rule` VALUES ('68', '1', 'admin', 'admin_url', 'admin/Route/select', '', '选择URL', '');
INSERT INTO `cmf_auth_rule` VALUES ('69', '1', 'admin', 'admin_url', 'admin/Setting/default', '', '设置', '');
INSERT INTO `cmf_auth_rule` VALUES ('70', '1', 'admin', 'admin_url', 'admin/Setting/site', '', '网站信息', '');
INSERT INTO `cmf_auth_rule` VALUES ('71', '1', 'admin', 'admin_url', 'admin/Setting/sitePost', '', '网站信息设置提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('72', '1', 'admin', 'admin_url', 'admin/Setting/password', '', '密码修改', '');
INSERT INTO `cmf_auth_rule` VALUES ('73', '1', 'admin', 'admin_url', 'admin/Setting/passwordPost', '', '密码修改提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('74', '1', 'admin', 'admin_url', 'admin/Setting/upload', '', '上传设置', '');
INSERT INTO `cmf_auth_rule` VALUES ('75', '1', 'admin', 'admin_url', 'admin/Setting/uploadPost', '', '上传设置提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('76', '1', 'admin', 'admin_url', 'admin/Setting/clearCache', '', '清除缓存', '');
INSERT INTO `cmf_auth_rule` VALUES ('77', '1', 'admin', 'admin_url', 'admin/Slide/index', '', '幻灯片管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('78', '1', 'admin', 'admin_url', 'admin/Slide/add', '', '添加幻灯片', '');
INSERT INTO `cmf_auth_rule` VALUES ('79', '1', 'admin', 'admin_url', 'admin/Slide/addPost', '', '添加幻灯片提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('80', '1', 'admin', 'admin_url', 'admin/Slide/edit', '', '编辑幻灯片', '');
INSERT INTO `cmf_auth_rule` VALUES ('81', '1', 'admin', 'admin_url', 'admin/Slide/editPost', '', '编辑幻灯片提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('82', '1', 'admin', 'admin_url', 'admin/Slide/delete', '', '删除幻灯片', '');
INSERT INTO `cmf_auth_rule` VALUES ('83', '1', 'admin', 'admin_url', 'admin/SlideItem/index', '', '幻灯片页面列表', '');
INSERT INTO `cmf_auth_rule` VALUES ('84', '1', 'admin', 'admin_url', 'admin/SlideItem/add', '', '幻灯片页面添加', '');
INSERT INTO `cmf_auth_rule` VALUES ('85', '1', 'admin', 'admin_url', 'admin/SlideItem/addPost', '', '幻灯片页面添加提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('86', '1', 'admin', 'admin_url', 'admin/SlideItem/edit', '', '幻灯片页面编辑', '');
INSERT INTO `cmf_auth_rule` VALUES ('87', '1', 'admin', 'admin_url', 'admin/SlideItem/editPost', '', '幻灯片页面编辑提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('88', '1', 'admin', 'admin_url', 'admin/SlideItem/delete', '', '幻灯片页面删除', '');
INSERT INTO `cmf_auth_rule` VALUES ('89', '1', 'admin', 'admin_url', 'admin/SlideItem/ban', '', '幻灯片页面隐藏', '');
INSERT INTO `cmf_auth_rule` VALUES ('90', '1', 'admin', 'admin_url', 'admin/SlideItem/cancelBan', '', '幻灯片页面显示', '');
INSERT INTO `cmf_auth_rule` VALUES ('91', '1', 'admin', 'admin_url', 'admin/SlideItem/listOrder', '', '幻灯片页面排序', '');
INSERT INTO `cmf_auth_rule` VALUES ('92', '1', 'admin', 'admin_url', 'admin/Storage/index', '', '文件存储', '');
INSERT INTO `cmf_auth_rule` VALUES ('93', '1', 'admin', 'admin_url', 'admin/Storage/settingPost', '', '文件存储设置提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('94', '1', 'admin', 'admin_url', 'admin/Theme/index', '', '模板管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('95', '1', 'admin', 'admin_url', 'admin/Theme/install', '', '安装模板', '');
INSERT INTO `cmf_auth_rule` VALUES ('96', '1', 'admin', 'admin_url', 'admin/Theme/uninstall', '', '卸载模板', '');
INSERT INTO `cmf_auth_rule` VALUES ('97', '1', 'admin', 'admin_url', 'admin/Theme/installTheme', '', '模板安装', '');
INSERT INTO `cmf_auth_rule` VALUES ('98', '1', 'admin', 'admin_url', 'admin/Theme/update', '', '模板更新', '');
INSERT INTO `cmf_auth_rule` VALUES ('99', '1', 'admin', 'admin_url', 'admin/Theme/active', '', '启用模板', '');
INSERT INTO `cmf_auth_rule` VALUES ('100', '1', 'admin', 'admin_url', 'admin/Theme/files', '', '模板文件列表', '');
INSERT INTO `cmf_auth_rule` VALUES ('101', '1', 'admin', 'admin_url', 'admin/Theme/fileSetting', '', '模板文件设置', '');
INSERT INTO `cmf_auth_rule` VALUES ('102', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayData', '', '模板文件数组数据列表', '');
INSERT INTO `cmf_auth_rule` VALUES ('103', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataEdit', '', '模板文件数组数据添加编辑', '');
INSERT INTO `cmf_auth_rule` VALUES ('104', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataEditPost', '', '模板文件数组数据添加编辑提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('105', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataDelete', '', '模板文件数组数据删除', '');
INSERT INTO `cmf_auth_rule` VALUES ('106', '1', 'admin', 'admin_url', 'admin/Theme/settingPost', '', '模板文件编辑提交保存', '');
INSERT INTO `cmf_auth_rule` VALUES ('107', '1', 'admin', 'admin_url', 'admin/Theme/dataSource', '', '模板文件设置数据源', '');
INSERT INTO `cmf_auth_rule` VALUES ('108', '1', 'admin', 'admin_url', 'admin/User/default', '', '管理组', '');
INSERT INTO `cmf_auth_rule` VALUES ('109', '1', 'admin', 'admin_url', 'admin/User/index', '', '管理员', '');
INSERT INTO `cmf_auth_rule` VALUES ('110', '1', 'admin', 'admin_url', 'admin/User/add', '', '管理员添加', '');
INSERT INTO `cmf_auth_rule` VALUES ('111', '1', 'admin', 'admin_url', 'admin/User/addPost', '', '管理员添加提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('112', '1', 'admin', 'admin_url', 'admin/User/edit', '', '管理员编辑', '');
INSERT INTO `cmf_auth_rule` VALUES ('113', '1', 'admin', 'admin_url', 'admin/User/editPost', '', '管理员编辑提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('114', '1', 'admin', 'admin_url', 'admin/User/userInfo', '', '个人信息', '');
INSERT INTO `cmf_auth_rule` VALUES ('115', '1', 'admin', 'admin_url', 'admin/User/userInfoPost', '', '管理员个人信息修改提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('116', '1', 'admin', 'admin_url', 'admin/User/delete', '', '管理员删除', '');
INSERT INTO `cmf_auth_rule` VALUES ('117', '1', 'admin', 'admin_url', 'admin/User/ban', '', '停用管理员', '');
INSERT INTO `cmf_auth_rule` VALUES ('118', '1', 'admin', 'admin_url', 'admin/User/cancelBan', '', '启用管理员', '');
INSERT INTO `cmf_auth_rule` VALUES ('119', '1', 'portal', 'admin_url', 'portal/AdminArticle/index', '', '文章管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('120', '1', 'portal', 'admin_url', 'portal/AdminArticle/add', '', '添加文章', '');
INSERT INTO `cmf_auth_rule` VALUES ('121', '1', 'portal', 'admin_url', 'portal/AdminArticle/addPost', '', '添加文章提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('122', '1', 'portal', 'admin_url', 'portal/AdminArticle/edit', '', '编辑文章', '');
INSERT INTO `cmf_auth_rule` VALUES ('123', '1', 'portal', 'admin_url', 'portal/AdminArticle/editPost', '', '编辑文章提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('124', '1', 'portal', 'admin_url', 'portal/AdminArticle/delete', '', '文章删除', '');
INSERT INTO `cmf_auth_rule` VALUES ('125', '1', 'portal', 'admin_url', 'portal/AdminArticle/publish', '', '文章发布', '');
INSERT INTO `cmf_auth_rule` VALUES ('126', '1', 'portal', 'admin_url', 'portal/AdminArticle/top', '', '文章置顶', '');
INSERT INTO `cmf_auth_rule` VALUES ('127', '1', 'portal', 'admin_url', 'portal/AdminArticle/recommend', '', '文章推荐', '');
INSERT INTO `cmf_auth_rule` VALUES ('128', '1', 'portal', 'admin_url', 'portal/AdminArticle/listOrder', '', '文章排序', '');
INSERT INTO `cmf_auth_rule` VALUES ('129', '1', 'portal', 'admin_url', 'portal/AdminCategory/index', '', '分类管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('130', '1', 'portal', 'admin_url', 'portal/AdminCategory/add', '', '添加文章分类', '');
INSERT INTO `cmf_auth_rule` VALUES ('131', '1', 'portal', 'admin_url', 'portal/AdminCategory/addPost', '', '添加文章分类提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('132', '1', 'portal', 'admin_url', 'portal/AdminCategory/edit', '', '编辑文章分类', '');
INSERT INTO `cmf_auth_rule` VALUES ('133', '1', 'portal', 'admin_url', 'portal/AdminCategory/editPost', '', '编辑文章分类提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('134', '1', 'portal', 'admin_url', 'portal/AdminCategory/select', '', '文章分类选择对话框', '');
INSERT INTO `cmf_auth_rule` VALUES ('135', '1', 'portal', 'admin_url', 'portal/AdminCategory/listOrder', '', '文章分类排序', '');
INSERT INTO `cmf_auth_rule` VALUES ('136', '1', 'portal', 'admin_url', 'portal/AdminCategory/delete', '', '删除文章分类', '');
INSERT INTO `cmf_auth_rule` VALUES ('137', '1', 'portal', 'admin_url', 'portal/AdminIndex/default', '', '门户管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('138', '1', 'portal', 'admin_url', 'portal/AdminPage/index', '', '页面管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('139', '1', 'portal', 'admin_url', 'portal/AdminPage/add', '', '添加页面', '');
INSERT INTO `cmf_auth_rule` VALUES ('140', '1', 'portal', 'admin_url', 'portal/AdminPage/addPost', '', '添加页面提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('141', '1', 'portal', 'admin_url', 'portal/AdminPage/edit', '', '编辑页面', '');
INSERT INTO `cmf_auth_rule` VALUES ('142', '1', 'portal', 'admin_url', 'portal/AdminPage/editPost', '', '编辑页面提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('143', '1', 'portal', 'admin_url', 'portal/AdminPage/delete', '', '删除页面', '');
INSERT INTO `cmf_auth_rule` VALUES ('144', '1', 'portal', 'admin_url', 'portal/AdminTag/index', '', '文章标签', '');
INSERT INTO `cmf_auth_rule` VALUES ('145', '1', 'portal', 'admin_url', 'portal/AdminTag/add', '', '添加文章标签', '');
INSERT INTO `cmf_auth_rule` VALUES ('146', '1', 'portal', 'admin_url', 'portal/AdminTag/addPost', '', '添加文章标签提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('147', '1', 'portal', 'admin_url', 'portal/AdminTag/upStatus', '', '更新标签状态', '');
INSERT INTO `cmf_auth_rule` VALUES ('148', '1', 'portal', 'admin_url', 'portal/AdminTag/delete', '', '删除文章标签', '');
INSERT INTO `cmf_auth_rule` VALUES ('149', '1', 'user', 'admin_url', 'user/AdminAsset/index', '', '资源管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('150', '1', 'user', 'admin_url', 'user/AdminAsset/delete', '', '删除文件', '');
INSERT INTO `cmf_auth_rule` VALUES ('151', '1', 'user', 'admin_url', 'user/AdminIndex/default', '', '用户管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('152', '1', 'user', 'admin_url', 'user/AdminIndex/default1', '', '用户组', '');
INSERT INTO `cmf_auth_rule` VALUES ('153', '1', 'user', 'admin_url', 'user/AdminIndex/index', '', '本站用户', '');
INSERT INTO `cmf_auth_rule` VALUES ('154', '1', 'user', 'admin_url', 'user/AdminIndex/ban', '', '本站用户拉黑', '');
INSERT INTO `cmf_auth_rule` VALUES ('155', '1', 'user', 'admin_url', 'user/AdminIndex/cancelBan', '', '本站用户启用', '');
INSERT INTO `cmf_auth_rule` VALUES ('156', '1', 'user', 'admin_url', 'user/AdminOauth/index', '', '第三方用户', '');
INSERT INTO `cmf_auth_rule` VALUES ('157', '1', 'user', 'admin_url', 'user/AdminOauth/delete', '', '删除第三方用户绑定', '');
INSERT INTO `cmf_auth_rule` VALUES ('158', '1', 'user', 'admin_url', 'user/AdminUserAction/index', '', '用户操作管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('159', '1', 'user', 'admin_url', 'user/AdminUserAction/edit', '', '编辑用户操作', '');
INSERT INTO `cmf_auth_rule` VALUES ('160', '1', 'user', 'admin_url', 'user/AdminUserAction/editPost', '', '编辑用户操作提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('161', '1', 'user', 'admin_url', 'user/AdminUserAction/sync', '', '同步用户操作', '');
INSERT INTO `cmf_auth_rule` VALUES ('162', '1', 'Portal', 'admin_url', 'Portal/AdminUser/default', '', '会员中心', '');
INSERT INTO `cmf_auth_rule` VALUES ('163', '1', 'Portal', 'admin_url', 'Portal/AdminUser/index', '', '会员管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('164', '1', 'Portal', 'admin_url', 'Portal/AdminAsk/default', '', '考题管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('165', '1', 'Portal', 'admin_url', 'Portal/AdminCate/index', '', '分类管理(self)', '');
INSERT INTO `cmf_auth_rule` VALUES ('166', '1', 'Portal', 'admin_url', 'Portal/AdminZa/default', '', '杂项', '');
INSERT INTO `cmf_auth_rule` VALUES ('167', '1', 'Portal', 'admin_url', 'Portal/AdminAsk/index', '', '题目管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('168', '1', 'portal', 'admin_url', 'portal/AdminAdvice/index', '', '用户留言', '');
INSERT INTO `cmf_auth_rule` VALUES ('169', '1', 'portal', 'admin_url', 'portal/AdminAdvice/reply', '', '留言回复', '');
INSERT INTO `cmf_auth_rule` VALUES ('170', '1', 'portal', 'admin_url', 'portal/AdminAdvice/replyPost', '', '留言回复提交', '');
INSERT INTO `cmf_auth_rule` VALUES ('171', '1', 'portal', 'admin_url', 'portal/AdminOrder/index', '', '订单管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('172', '1', 'portal', 'admin_url', 'portal/AdminUask/index', '', '反馈管理', '');
INSERT INTO `cmf_auth_rule` VALUES ('173', '1', 'portal', 'admin_url', 'portal/AdminEask/index', '', '用户纠错', '');
INSERT INTO `cmf_auth_rule` VALUES ('174', '1', 'portal', 'admin_url', 'portal/AdminExamintro/index', '', '考试介绍', '');
INSERT INTO `cmf_auth_rule` VALUES ('175', '1', 'portal', 'admin_url', 'portal/AdminExampoint/index', '', '考点提炼', '');
INSERT INTO `cmf_auth_rule` VALUES ('176', '1', 'Portal', 'admin_url', 'Portal/AdminOnepage/regart', '', '用户注册协议及免责声明', '');
INSERT INTO `cmf_auth_rule` VALUES ('177', '1', 'Portal', 'admin_url', 'Portal/AdminNews/index', '', '新闻资讯', '');
INSERT INTO `cmf_auth_rule` VALUES ('178', '1', 'Portal', 'admin_url', 'Portal/AdminTest/index', '', '测试', '');

-- ----------------------------
-- Table structure for cmf_cate
-- ----------------------------
DROP TABLE IF EXISTS `cmf_cate`;
CREATE TABLE `cmf_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(50) NOT NULL COMMENT '分类名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='分类表';

-- ----------------------------
-- Records of cmf_cate
-- ----------------------------
INSERT INTO `cmf_cate` VALUES ('1', '私照飞机', null, '0');
INSERT INTO `cmf_cate` VALUES ('2', '商照飞机', null, '0');
INSERT INTO `cmf_cate` VALUES ('3', '航线飞机', null, '0');
INSERT INTO `cmf_cate` VALUES ('4', '仪表飞机', null, '0');
INSERT INTO `cmf_cate` VALUES ('5', 'FAA IRA', null, '0');
INSERT INTO `cmf_cate` VALUES ('6', '签派', null, '0');
INSERT INTO `cmf_cate` VALUES ('7', '测试', null, '0');

-- ----------------------------
-- Table structure for cmf_comment
-- ----------------------------
DROP TABLE IF EXISTS `cmf_comment`;
CREATE TABLE `cmf_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `dislike_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '不喜欢数',
  `floor` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼层数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:已审核,0:未审核',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '评论内容所在表，不带表前缀',
  `full_name` varchar(50) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  `url` text COMMENT '原文地址',
  `content` text CHARACTER SET utf8mb4 COMMENT '评论内容',
  `more` text CHARACTER SET utf8mb4 COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `table_id_status` (`table_name`,`object_id`,`status`),
  KEY `object_id` (`object_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of cmf_comment
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_company
-- ----------------------------
DROP TABLE IF EXISTS `cmf_company`;
CREATE TABLE `cmf_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='公司表';

-- ----------------------------
-- Records of cmf_company
-- ----------------------------
INSERT INTO `cmf_company` VALUES ('1', '百荣科技有限公司', '2018-10-10 18:50:39');
INSERT INTO `cmf_company` VALUES ('2', '中国石油天然气集团有限公司', '2018-10-10 18:52:03');

-- ----------------------------
-- Table structure for cmf_error_ask
-- ----------------------------
DROP TABLE IF EXISTS `cmf_error_ask`;
CREATE TABLE `cmf_error_ask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `ask_id` int(11) NOT NULL COMMENT '题目id',
  `error_content` varchar(255) NOT NULL COMMENT '内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='纠错表';

-- ----------------------------
-- Records of cmf_error_ask
-- ----------------------------
INSERT INTO `cmf_error_ask` VALUES ('1', '1', '19', '这题好像错了吧！', '2018-07-19 16:19:42');
INSERT INTO `cmf_error_ask` VALUES ('2', '2', '20', '这道题好像也错了吧！', '2018-08-22 17:35:40');
INSERT INTO `cmf_error_ask` VALUES ('3', '45', '19', '纠错测试', '2018-10-16 16:05:57');
INSERT INTO `cmf_error_ask` VALUES ('4', '45', '19', '纠错纠错', '2018-10-16 16:07:36');
INSERT INTO `cmf_error_ask` VALUES ('5', '45', '19', '纠错队出发！！！！', '2018-10-16 16:11:06');
INSERT INTO `cmf_error_ask` VALUES ('6', '45', '19', '纠错队来啦！！！？', '2018-10-16 16:14:21');
INSERT INTO `cmf_error_ask` VALUES ('7', '45', '19', '纠错对纠错队！！！', '2018-10-16 16:19:26');
INSERT INTO `cmf_error_ask` VALUES ('8', '45', '19', '纠错对纠错队！！！', '2018-10-16 16:19:39');
INSERT INTO `cmf_error_ask` VALUES ('9', '45', '19', '绿植', '2018-10-16 16:20:27');

-- ----------------------------
-- Table structure for cmf_examination
-- ----------------------------
DROP TABLE IF EXISTS `cmf_examination`;
CREATE TABLE `cmf_examination` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) NOT NULL COMMENT '分类id',
  `content` text NOT NULL COMMENT '内容',
  `create_time` datetime NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型（0考试介绍,1考点提炼）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='考试介绍和考点提炼表';

-- ----------------------------
-- Records of cmf_examination
-- ----------------------------
INSERT INTO `cmf_examination` VALUES ('1', '1', '&lt;p&gt;私照飞机的考试介绍&lt;/p&gt;', '2018-09-28 16:14:07', '0');
INSERT INTO `cmf_examination` VALUES ('2', '2', '&lt;p&gt;商照飞机的考试介绍&lt;/p&gt;', '2018-09-28 16:14:22', '0');
INSERT INTO `cmf_examination` VALUES ('3', '1', '&lt;p&gt;私照飞机的考点提炼&lt;/p&gt;', '2018-09-28 16:11:56', '1');
INSERT INTO `cmf_examination` VALUES ('4', '2', '&lt;p&gt;商照飞机的考点提炼&lt;/p&gt;', '2018-09-28 16:11:40', '1');
INSERT INTO `cmf_examination` VALUES ('5', '3', '&lt;p style=&quot;white-space: normal;&quot;&gt;私人飞行执照，取得执照所需的条件由国际民航组织（ICAO）规定。根据ICAO规定，申请者必须顺利完成在空中至少40小时（英国和西班牙规定为45小时）的飞行培训，通过笔试， 完成长时间的单人飞行（最低时间要求为10小时）等。不过在实际的执行过程中，各国间的要求有很大不同。&lt;/p&gt;&lt;p style=&quot;white-space: normal;&quot;&gt;&lt;br/&gt;&lt;/p&gt;&lt;p style=&quot;white-space: normal;&quot;&gt;飞行驾驶员执照培训是一项理论性、技术性和综合性很高的工作，培训单位必须经过民航总局或者民航地区管理局严格的合格审定。&lt;/p&gt;&lt;p style=&quot;white-space: normal;&quot;&gt;&lt;br/&gt;&lt;/p&gt;&lt;p style=&quot;white-space: normal;&quot;&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&amp;nbsp;The conditions for obtaining a licence for a private flying licence are stipulated by the International Civil Aviation Organization (ICAO). According to ICAO, the applicant must successfully complete the flight training for at least 40 hours in the air (45 hours in the UK and Spain), through a written test, to complete a long single flight (the minimum time required for&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;white-space: normal;&quot;&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&lt;br/&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;white-space: normal;&quot;&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&amp;nbsp;The conditions for obtaining a licence for a private flying licence are stipulated by the International Civil Aviation Organization (ICAO). According to ICAO, the applicant must successfully complete the flight training for at least 40 hours in the air (45 hours in the UK and Spain), through a written test, to complete a long single flight (the minimum time required for&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&lt;br/&gt;&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '2018-10-15 09:58:28', '1');
INSERT INTO `cmf_examination` VALUES ('6', '4', '&lt;p&gt;仪表飞机的考点提炼&lt;/p&gt;', '2018-09-28 16:12:42', '1');
INSERT INTO `cmf_examination` VALUES ('7', '5', '&lt;p&gt;FAA IRA的考点提炼&lt;/p&gt;', '2018-09-28 16:13:03', '1');
INSERT INTO `cmf_examination` VALUES ('8', '6', '&lt;p&gt;签派的考点提炼&lt;/p&gt;', '2018-09-28 16:13:21', '1');
INSERT INTO `cmf_examination` VALUES ('9', '7', '&lt;p&gt;测试的考点提炼&lt;/p&gt;', '2018-09-28 16:13:35', '1');
INSERT INTO `cmf_examination` VALUES ('10', '3', '&lt;p&gt;私人飞行执照，取得执照所需的条件由国际民航组织（ICAO）规定。根据ICAO规定，申请者必须顺利完成在空中至少40小时（英国和西班牙规定为45小时）的飞行培训，通过笔试， 完成长时间的单人飞行（最低时间要求为10小时）等。不过在实际的执行过程中，各国间的要求有很大不同。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;飞行驾驶员执照培训是一项理论性、技术性和综合性很高的工作，培训单位必须经过民航总局或者民航地区管理局严格的合格审定。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&amp;nbsp;The conditions for obtaining a licence for a private flying licence are stipulated by the International Civil Aviation Organization (ICAO). According to ICAO, the applicant must successfully complete the flight training for at least 40 hours in the air (45 hours in the UK and Spain), through a written test, to complete a long single flight (the minimum time required for&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&lt;br/&gt;&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&amp;nbsp;The conditions for obtaining a licence for a private flying licence are stipulated by the International Civil Aviation Organization (ICAO). According to ICAO, the applicant must successfully complete the flight training for at least 40 hours in the air (45 hours in the UK and Spain), through a written test, to complete a long single flight (the minimum time required for&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&lt;span style=&quot;color: rgb(14, 23, 38); font-family: &amp;quot;PingFang SC&amp;quot;, -apple-system, BlinkMacSystemFont, Roboto, &amp;quot;Helvetica Neue&amp;quot;, Helvetica, Arial, &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Source Han Sans&amp;quot;, &amp;quot;Noto Sans CJK Sc&amp;quot;, &amp;quot;Microsoft YaHei&amp;quot;, &amp;quot;Microsoft Jhenghei&amp;quot;, sans-serif; font-size: 14px; background-color: rgb(244, 247, 253);&quot;&gt;&lt;br/&gt;&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;', '2018-10-15 09:57:51', '0');
INSERT INTO `cmf_examination` VALUES ('11', '4', '&lt;p&gt;仪表飞机的考试介绍&lt;/p&gt;', '2018-09-28 16:15:00', '0');
INSERT INTO `cmf_examination` VALUES ('12', '5', '&lt;p&gt;FAA IRA的考试介绍&lt;/p&gt;', '2018-09-28 16:15:19', '0');
INSERT INTO `cmf_examination` VALUES ('13', '6', '&lt;p&gt;签派的考试介绍&lt;/p&gt;', '2018-09-28 16:15:33', '0');
INSERT INTO `cmf_examination` VALUES ('14', '7', '&lt;p&gt;测试的考试介绍&lt;/p&gt;', '2018-09-28 16:15:46', '0');

-- ----------------------------
-- Table structure for cmf_hook
-- ----------------------------
DROP TABLE IF EXISTS `cmf_hook`;
CREATE TABLE `cmf_hook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '钩子类型(1:系统钩子;2:应用钩子;3:模板钩子;4:后台模板钩子)',
  `once` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否只允许一个插件运行(0:多个;1:一个)',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子',
  `app` varchar(15) NOT NULL DEFAULT '' COMMENT '应用名(只有应用钩子才用)',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子表';

-- ----------------------------
-- Records of cmf_hook
-- ----------------------------
INSERT INTO `cmf_hook` VALUES ('1', '1', '0', '应用初始化', 'app_init', 'cmf', '应用初始化');
INSERT INTO `cmf_hook` VALUES ('2', '1', '0', '应用开始', 'app_begin', 'cmf', '应用开始');
INSERT INTO `cmf_hook` VALUES ('3', '1', '0', '模块初始化', 'module_init', 'cmf', '模块初始化');
INSERT INTO `cmf_hook` VALUES ('4', '1', '0', '控制器开始', 'action_begin', 'cmf', '控制器开始');
INSERT INTO `cmf_hook` VALUES ('5', '1', '0', '视图输出过滤', 'view_filter', 'cmf', '视图输出过滤');
INSERT INTO `cmf_hook` VALUES ('6', '1', '0', '应用结束', 'app_end', 'cmf', '应用结束');
INSERT INTO `cmf_hook` VALUES ('7', '1', '0', '日志write方法', 'log_write', 'cmf', '日志write方法');
INSERT INTO `cmf_hook` VALUES ('8', '1', '0', '输出结束', 'response_end', 'cmf', '输出结束');
INSERT INTO `cmf_hook` VALUES ('9', '1', '0', '后台控制器初始化', 'admin_init', 'cmf', '后台控制器初始化');
INSERT INTO `cmf_hook` VALUES ('10', '1', '0', '前台控制器初始化', 'home_init', 'cmf', '前台控制器初始化');
INSERT INTO `cmf_hook` VALUES ('11', '1', '1', '发送手机验证码', 'send_mobile_verification_code', 'cmf', '发送手机验证码');
INSERT INTO `cmf_hook` VALUES ('12', '3', '0', '模板 body标签开始', 'body_start', '', '模板 body标签开始');
INSERT INTO `cmf_hook` VALUES ('13', '3', '0', '模板 head标签结束前', 'before_head_end', '', '模板 head标签结束前');
INSERT INTO `cmf_hook` VALUES ('14', '3', '0', '模板底部开始', 'footer_start', '', '模板底部开始');
INSERT INTO `cmf_hook` VALUES ('15', '3', '0', '模板底部开始之前', 'before_footer', '', '模板底部开始之前');
INSERT INTO `cmf_hook` VALUES ('16', '3', '0', '模板底部结束之前', 'before_footer_end', '', '模板底部结束之前');
INSERT INTO `cmf_hook` VALUES ('17', '3', '0', '模板 body 标签结束之前', 'before_body_end', '', '模板 body 标签结束之前');
INSERT INTO `cmf_hook` VALUES ('18', '3', '0', '模板左边栏开始', 'left_sidebar_start', '', '模板左边栏开始');
INSERT INTO `cmf_hook` VALUES ('19', '3', '0', '模板左边栏结束之前', 'before_left_sidebar_end', '', '模板左边栏结束之前');
INSERT INTO `cmf_hook` VALUES ('20', '3', '0', '模板右边栏开始', 'right_sidebar_start', '', '模板右边栏开始');
INSERT INTO `cmf_hook` VALUES ('21', '3', '0', '模板右边栏结束之前', 'before_right_sidebar_end', '', '模板右边栏结束之前');
INSERT INTO `cmf_hook` VALUES ('22', '3', '1', '评论区', 'comment', '', '评论区');
INSERT INTO `cmf_hook` VALUES ('23', '3', '1', '留言区', 'guestbook', '', '留言区');
INSERT INTO `cmf_hook` VALUES ('24', '2', '0', '后台首页仪表盘', 'admin_dashboard', 'admin', '后台首页仪表盘');
INSERT INTO `cmf_hook` VALUES ('25', '4', '0', '后台模板 head标签结束前', 'admin_before_head_end', '', '后台模板 head标签结束前');
INSERT INTO `cmf_hook` VALUES ('26', '4', '0', '后台模板 body 标签结束之前', 'admin_before_body_end', '', '后台模板 body 标签结束之前');
INSERT INTO `cmf_hook` VALUES ('27', '2', '0', '后台登录页面', 'admin_login', 'admin', '后台登录页面');
INSERT INTO `cmf_hook` VALUES ('28', '1', '1', '前台模板切换', 'switch_theme', 'cmf', '前台模板切换');
INSERT INTO `cmf_hook` VALUES ('29', '3', '0', '主要内容之后', 'after_content', '', '主要内容之后');
INSERT INTO `cmf_hook` VALUES ('30', '2', '0', '文章显示之前', 'portal_before_assign_article', 'portal', '文章显示之前');
INSERT INTO `cmf_hook` VALUES ('31', '2', '0', '后台文章保存之后', 'portal_admin_after_save_article', 'portal', '后台文章保存之后');
INSERT INTO `cmf_hook` VALUES ('32', '2', '1', '获取上传界面', 'fetch_upload_view', 'user', '获取上传界面');
INSERT INTO `cmf_hook` VALUES ('33', '3', '0', '主要内容之前', 'before_content', 'cmf', '主要内容之前');
INSERT INTO `cmf_hook` VALUES ('34', '1', '0', '日志写入完成', 'log_write_done', 'cmf', '日志写入完成');
INSERT INTO `cmf_hook` VALUES ('35', '1', '1', '后台模板切换', 'switch_admin_theme', 'cmf', '后台模板切换');

-- ----------------------------
-- Table structure for cmf_hook_plugin
-- ----------------------------
DROP TABLE IF EXISTS `cmf_hook_plugin`;
CREATE TABLE `cmf_hook_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(50) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子插件表';

-- ----------------------------
-- Records of cmf_hook_plugin
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_link
-- ----------------------------
DROP TABLE IF EXISTS `cmf_link`;
CREATE TABLE `cmf_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:不显示',
  `rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) NOT NULL DEFAULT '' COMMENT '链接与网站的关系',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='友情链接表';

-- ----------------------------
-- Records of cmf_link
-- ----------------------------
INSERT INTO `cmf_link` VALUES ('1', '1', '1', '8', 'thinkcmf官网', 'http://www.thinkcmf.com', 'ThinkCMF', '', '_blank', '');

-- ----------------------------
-- Table structure for cmf_mobile_code
-- ----------------------------
DROP TABLE IF EXISTS `cmf_mobile_code`;
CREATE TABLE `cmf_mobile_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(255) NOT NULL COMMENT '手机号',
  `mobile_code` varchar(255) NOT NULL COMMENT '验证码',
  `expire_time` int(11) NOT NULL COMMENT '过期时间',
  `is_use` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已用(0未使用，1已使用)',
  `count` int(11) DEFAULT '0' COMMENT '发送总次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='手机验证码表';

-- ----------------------------
-- Records of cmf_mobile_code
-- ----------------------------
INSERT INTO `cmf_mobile_code` VALUES ('14', '13102112093', '447884', '1539758586', '1', '2');
INSERT INTO `cmf_mobile_code` VALUES ('16', '18211132493', '296133', '1539317353', '1', '0');
INSERT INTO `cmf_mobile_code` VALUES ('18', '18722495722', '683373', '1540187455', '1', '18');
INSERT INTO `cmf_mobile_code` VALUES ('19', '15822438465', '787619', '1539329953', '1', '0');
INSERT INTO `cmf_mobile_code` VALUES ('20', '18722496722', '314999', '1539913699', '1', '0');

-- ----------------------------
-- Table structure for cmf_nav
-- ----------------------------
DROP TABLE IF EXISTS `cmf_nav`;
CREATE TABLE `cmf_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_main` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否为主导航;1:是;0:不是',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '导航位置名称',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航位置表';

-- ----------------------------
-- Records of cmf_nav
-- ----------------------------
INSERT INTO `cmf_nav` VALUES ('1', '1', '主导航', '主导航');
INSERT INTO `cmf_nav` VALUES ('2', '0', '底部导航', '');

-- ----------------------------
-- Table structure for cmf_nav_menu
-- ----------------------------
DROP TABLE IF EXISTS `cmf_nav_menu`;
CREATE TABLE `cmf_nav_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_id` int(11) NOT NULL COMMENT '导航 id',
  `parent_id` int(11) NOT NULL COMMENT '父 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '打开方式',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航菜单表';

-- ----------------------------
-- Records of cmf_nav_menu
-- ----------------------------
INSERT INTO `cmf_nav_menu` VALUES ('1', '1', '0', '1', '0', '首页', '', 'home', '', '0-1');

-- ----------------------------
-- Table structure for cmf_news
-- ----------------------------
DROP TABLE IF EXISTS `cmf_news`;
CREATE TABLE `cmf_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '题目',
  `short_content` varchar(255) NOT NULL COMMENT '简介',
  `thumb` varchar(255) DEFAULT NULL COMMENT '缩略图',
  `content` longtext NOT NULL COMMENT '内容',
  `update_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='新闻资讯表';

-- ----------------------------
-- Records of cmf_news
-- ----------------------------
INSERT INTO `cmf_news` VALUES ('2', '什么是“私照”？', '私照是指私人来学习飞机驾驶，只能开自己的飞机，不能去驾驶获得报酬的运营飞机......', 'http://fqzy.w.bronet.cn/upload/portal/20180815/649bd3dedc70df85488d0b1c7d413f81.jpg', '&lt;p style=&quot;font-family: Simsun; font-size: 14px; white-space: normal;&quot;&gt;&amp;nbsp; &amp;nbsp;&lt;/p&gt;&lt;p&gt;&amp;nbsp; &amp;nbsp;&amp;nbsp;&lt;/p&gt;&lt;p&gt;&amp;nbsp; &amp;nbsp; 别再说，地铁太挤工作不易，你可曾见过火车上肩扛手提，许多我们叫爸爸的人拖着比自己都高的行李奔赴生计！&lt;/p&gt;&lt;p&gt;　　别再说，压力太大生活艰辛，你可曾知道有人已经年逾古稀依然起早贪黑，只为解决一家温饱！&lt;/p&gt;&lt;p&gt;　　别再说，灯红酒绿索然无味，你可曾想过穿梭城市的民工也许连一瓶矿泉水都狠不下心来买！&lt;/p&gt;&lt;p&gt;　　别再说，写不完的作业背不完的公式让你身心疲惫，你可曾听过遥远的山村有赤脚的孩子趴在窗前偷听老师讲课！&lt;/p&gt;&lt;p&gt;　　别再说，世界那么大我想去看看，你可曾知道多少人即使行将就木，依然没有出过方圆十里的村落！&lt;/p&gt;&lt;p&gt;　　别再说，昨夜王者精神不振，你可知道有个母亲孤灯夜下穿针引线为千里之外的孩子添补衣裳，只因一句天冷了！&lt;/p&gt;&lt;p&gt;　　别再说，空调房的你都吼不住炎炎夏日，那是你没见过烫人的黄土混合眼泪的汗流浃背，有个父亲顶着烈日给他的孩子挣学费！&lt;/p&gt;&lt;p&gt;　　别再说，衣服太少柜子空空，你可曾记得母亲身上穿的那件外套，不正是你几年前淘汰的垃圾！&lt;/p&gt;&lt;p&gt;　　别再说，老爸老妈明年我一定回家，什么都可以等待，尽孝麻烦请趁快……&lt;/p&gt;&lt;p&gt;　　别再说，物欲横流真爱难觅，家中那张泛黄的老照片明明见证了爷爷奶奶相濡以沫坐着摇椅变老的爱情。&lt;/p&gt;&lt;p&gt;　　好了，别再说……&lt;/p&gt;&lt;p&gt;　　如果你没见过请别再说，如果你不知道请别再说，如果你已忘记请别再说！&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '2018-08-15 17:13:43');

-- ----------------------------
-- Table structure for cmf_onepage
-- ----------------------------
DROP TABLE IF EXISTS `cmf_onepage`;
CREATE TABLE `cmf_onepage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL COMMENT '内容',
  `update_time` datetime NOT NULL,
  `remark` varchar(255) NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='单页面表';

-- ----------------------------
-- Records of cmf_onepage
-- ----------------------------
INSERT INTO `cmf_onepage` VALUES ('1', '&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; &amp;nbsp;世人，谁不喜欢桃花十里的灿烂？谁不眷恋春风十里的柔情？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　如果你的一生，有一人静静陪着你走，从花开到花谢，从青丝到暮年，一路走来，可以隔着时光，隔着风云，隔着距离，一直默然相陪，不离不弃，让你明白什么叫不语亦深情，&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　无声也懂得，那该是怎样的一种幸福和幸运？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　为什么红尘很多故事的开头，总是流光旖旎，花开花落皆成诗？为什么世间很多故事的结尾，总是一篙独去，潮来潮往无处寻？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　在年年岁岁中，究竟有多少缘湮灭在红尘渡口？在来来去去中，到底有多少情散落在天涯彼岸？蹉跎岁月里，谁遇见了谁？谁离开了谁？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　假如相遇后不与寂寞有染，离别后不与孤苦相依，一生只道你若安好便是晴天，一世只念时光不老我们不散，那该是怎样的一种欣然和欣喜？&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　只要心是近的，那么，无论来与不来，见或不见，牵念将一直在路上，如春风般在你身边轻舞飞扬；&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　只要情是真的，那么，无论聚与不聚，走或不走，美丽将一直在路上，如星月般在你身旁地久天长。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　如果心是远的，那么无论怎样的辗转相思，怎样的你侬我侬，到最后还是孤星独吟，花事寂寞；&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　如果情是虚的，那么，无论怎样的琴瑟共鸣，一纸情长，到最后还是烟花易冷，人事易分。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　倘若一生有人静静陪你走，那一定是日子清幽也温馨，路途崎岖也心安。不管眼前车水马龙，还是寂寞无声，相信你的心中始终安暖。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　哪怕一路无景无色，你也能感受到时光温良；哪怕一路无韵无律，你也能聆听到清风悠扬；哪怕一路无花无草，你也能染得满衣幽香。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　其实，爱不需要承诺，最纯的爱，应是毫无索取的耕耘；最深的爱，应是无怨无悔的付出；最美的爱，应是永不抛弃的相守。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　若是前世有善修，那总有一份情会经过轮回的等待，出尘入世，为你纤尘不染，总有一个人会为你穿越时光的山山水水，越过岁月的沟沟壑壑抵达你身边。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　他不一定在花开里与你相逢，但他一定愿意路过你的全世界，用行动告诉你什么叫最长情的告白。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　时光薄情亦深情，只要你心存善良和大爱，请相信，无论此时彼时，总有一份温暖会安抚你落寞的情怀。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　不管你有没有临水照花的心情，不管你有没有曲高和寡的心境，不管你有没有知音难寻的喟叹，或许总有一天你会遇见这样一个人，愿意一生静静陪你走，不语也情深，无言也温暖。&lt;/p&gt;&lt;p style=&quot;box-sizing: border-box; margin-top: 0px; margin-bottom: 18px; word-wrap: break-word; font-family: &amp;quot;Microsoft Yahei&amp;quot;; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;　　你若成风，他愿化雨；你若不眠，他便无梦。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '2018-08-15 14:11:30', '用户注册协议及免责声明');

-- ----------------------------
-- Table structure for cmf_option
-- ----------------------------
DROP TABLE IF EXISTS `cmf_option`;
CREATE TABLE `cmf_option` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoload` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否自动加载;1:自动加载;0:不自动加载',
  `option_name` varchar(64) NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='全站配置表';

-- ----------------------------
-- Records of cmf_option
-- ----------------------------
INSERT INTO `cmf_option` VALUES ('1', '1', 'site_info', '{\"site_name\":\"\\u98de\\u7b7e\\u4e4b\\u97f3\",\"site_seo_title\":\"\\u98de\\u7b7e\\u4e4b\\u97f3\",\"site_seo_keywords\":\"\\u98de\\u7b7e\\u4e4b\\u97f3\",\"site_seo_description\":\"\\u98de\\u7b7e\\u4e4b\\u97f3\"}');

-- ----------------------------
-- Table structure for cmf_order
-- ----------------------------
DROP TABLE IF EXISTS `cmf_order`;
CREATE TABLE `cmf_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `order_sn` varchar(50) NOT NULL COMMENT '订单编号',
  `cate_id` int(11) NOT NULL COMMENT '分类id',
  `order_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态（0未支付，1已支付）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `price` decimal(10,2) NOT NULL COMMENT '金额',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='购买课程订单表';

-- ----------------------------
-- Records of cmf_order
-- ----------------------------
INSERT INTO `cmf_order` VALUES ('2', '2', '2018092951985055', '6', '1', '2018-09-29 14:16:35', '2018-09-29 14:16:53', '1.00', '2018-10-06 14:16:35');
INSERT INTO `cmf_order` VALUES ('3', '45', '2018101310052994', '2', '0', '2018-10-13 14:45:17', '2018-10-13 16:00:45', '1.00', '2018-10-20 14:45:17');
INSERT INTO `cmf_order` VALUES ('4', '45', '2018101397549799', '3', '1', '2018-10-13 15:02:02', '2018-10-13 15:32:04', '1.00', '2018-10-20 15:02:02');
INSERT INTO `cmf_order` VALUES ('8', '45', '2018101550535652', '6', '1', '2018-10-15 09:04:02', '2018-10-15 09:17:54', '12.00', '2019-10-15 09:04:02');

-- ----------------------------
-- Table structure for cmf_plugin
-- ----------------------------
DROP TABLE IF EXISTS `cmf_plugin`;
CREATE TABLE `cmf_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) NOT NULL COMMENT '插件描述',
  `config` text COMMENT '插件配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='插件表';

-- ----------------------------
-- Records of cmf_plugin
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_portal_category
-- ----------------------------
DROP TABLE IF EXISTS `cmf_portal_category`;
CREATE TABLE `cmf_portal_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类文章数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(255) NOT NULL DEFAULT '',
  `list_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类文章页模板',
  `more` text COMMENT '扩展属性',
  `weekprice` decimal(10,2) NOT NULL COMMENT '两周的价格',
  `yearprice` decimal(10,2) NOT NULL COMMENT '一年的价格',
  `exam_time` int(11) NOT NULL COMMENT '考试时间（分钟）',
  `low_score` int(255) NOT NULL COMMENT '合格标准（分）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章分类表';

-- ----------------------------
-- Records of cmf_portal_category
-- ----------------------------
INSERT INTO `cmf_portal_category` VALUES ('1', '0', '0', '1', '0', '10000', '私照飞机', '这是私照飞机的描述', '0-1', '', '', '', 'list', 'article', '{\"thumbnail\":\"portal\\/20180929\\/c7c1c3edcc54a8bf6b84890b11bc2a8a.png\"}', '1.00', '12.00', '120', '80');
INSERT INTO `cmf_portal_category` VALUES ('2', '0', '0', '1', '0', '10000', '商照飞机', '', '0-2', '', '', '', 'list', 'article', '{\"thumbnail\":\"portal\\/20180929\\/cdcdb99a07838b6bc8bfb178d5b9a4f3.png\"}', '1.00', '12.00', '120', '80');
INSERT INTO `cmf_portal_category` VALUES ('3', '0', '0', '1', '0', '10000', '航线飞机', '', '0-3', '', '', '', 'list', 'article', '{\"thumbnail\":\"portal\\/20180929\\/e676e5b131e5b00087c8836283439e27.png\"}', '1.00', '12.00', '120', '80');
INSERT INTO `cmf_portal_category` VALUES ('4', '0', '0', '1', '0', '10000', '仪表飞机', '', '0-4', '', '', '', 'list', 'article', '{\"thumbnail\":\"portal\\/20180929\\/f8ff6378fe01e896f6b432d08c21d3da.png\"}', '1.00', '12.00', '120', '80');
INSERT INTO `cmf_portal_category` VALUES ('5', '0', '0', '1', '0', '10000', 'FAA IRA', '', '0-5', '', '', '', 'list', 'article', '{\"thumbnail\":\"portal\\/20180929\\/296a3f0cc94318d19ca022578bfacd08.png\"}', '1.00', '12.00', '120', '80');
INSERT INTO `cmf_portal_category` VALUES ('6', '0', '0', '1', '0', '10000', '签派员', '', '0-6', '', '', '', 'list', 'article', '{\"thumbnail\":\"portal\\/20180929\\/bdaeeba24ad81eeb3b8a5bb51774cd43.png\"}', '1.00', '12.00', '120', '80');
INSERT INTO `cmf_portal_category` VALUES ('7', '0', '0', '1', '0', '10000', '管制员', '', '0-7', '', '', '', 'list', 'article', '{\"thumbnail\":\"portal\\/20180929\\/26c86a4f02df831b388bee1df0b838b7.png\"}', '0.00', '0.00', '120', '80');
INSERT INTO `cmf_portal_category` VALUES ('8', '1', '0', '1', '0', '10000', '私照飞机题库1', '', '0-1-8', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('9', '1', '0', '1', '0', '10000', '私照飞机题库2', '', '0-1-9', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('10', '2', '0', '1', '0', '10000', '商照飞机题库1', '', '0-2-10', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('11', '2', '0', '1', '0', '10000', '商照飞机题库2', '', '0-2-11', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('12', '3', '0', '1', '0', '10000', '航线飞机题库1', '', '0-3-12', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('13', '3', '0', '1', '0', '10000', '航线飞机题库2', '', '0-3-13', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('14', '4', '0', '1', '0', '10000', '仪表飞机题库1', '', '0-4-14', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('15', '4', '0', '1', '0', '10000', '仪表飞机题库2', '', '0-4-15', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('16', '5', '0', '1', '0', '10000', 'FAA IRA题库1', '', '0-5-16', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('17', '5', '0', '1', '0', '10000', 'FAA IRA题库2', '', '0-5-17', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('18', '6', '0', '1', '0', '10000', '签派题库1', '', '0-6-18', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('19', '6', '0', '1', '0', '10000', '签派题库2', '', '0-6-19', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('20', '7', '0', '1', '0', '10000', '管制员题库', '', '0-7-20', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('23', '0', '0', '1', '0', '10000', '艺不压身', '', '0-23', '', '', '', 'list', 'article', '{\"thumbnail\":\"portal\\/20180929\\/f4e070a7a3b6176f62ef392f5f59b645.png\"}', '0.00', '0.00', '120', '80');
INSERT INTO `cmf_portal_category` VALUES ('24', '23', '0', '1', '0', '10000', '艺不压身题库', '', '0-23-24', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('27', '0', '0', '1', '0', '10000', '测试', '', '0-27', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');
INSERT INTO `cmf_portal_category` VALUES ('28', '27', '0', '1', '0', '10000', '测试题库1', '', '0-27-28', '', '', '', 'list', 'article', '{\"thumbnail\":\"\"}', '0.00', '0.00', '0', '0');

-- ----------------------------
-- Table structure for cmf_portal_category_post
-- ----------------------------
DROP TABLE IF EXISTS `cmf_portal_category_post`;
CREATE TABLE `cmf_portal_category_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `term_taxonomy_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='portal应用 分类文章对应表';

-- ----------------------------
-- Records of cmf_portal_category_post
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_portal_post
-- ----------------------------
DROP TABLE IF EXISTS `cmf_portal_post`;
CREATE TABLE `cmf_portal_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:已发布;0:未发布;',
  `comment_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_hits` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_like` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `published_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `post_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `post_content` text COMMENT '文章内容',
  `post_content_filtered` text COMMENT '处理过的文章内容',
  `more` text COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`),
  KEY `parent_id` (`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='portal应用 文章表';

-- ----------------------------
-- Records of cmf_portal_post
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_portal_tag
-- ----------------------------
DROP TABLE IF EXISTS `cmf_portal_tag`;
CREATE TABLE `cmf_portal_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签文章数',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章标签表';

-- ----------------------------
-- Records of cmf_portal_tag
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_portal_tag_post
-- ----------------------------
DROP TABLE IF EXISTS `cmf_portal_tag_post`;
CREATE TABLE `cmf_portal_tag_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签 id',
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 标签文章对应表';

-- ----------------------------
-- Records of cmf_portal_tag_post
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_recycle_bin
-- ----------------------------
DROP TABLE IF EXISTS `cmf_recycle_bin`;
CREATE TABLE `cmf_recycle_bin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) DEFAULT '0' COMMENT '删除内容 id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(60) DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) DEFAULT '' COMMENT '删除内容名称',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT=' 回收站';

-- ----------------------------
-- Records of cmf_recycle_bin
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_reply
-- ----------------------------
DROP TABLE IF EXISTS `cmf_reply`;
CREATE TABLE `cmf_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `toid` int(11) NOT NULL COMMENT '留言表id或纠错表id或用户反馈新题表id',
  `table_name` varchar(255) NOT NULL COMMENT '表名（advice,error_ask,user_ask）',
  `reply_title` varchar(255) NOT NULL COMMENT '回复标题',
  `reply_content` text NOT NULL COMMENT '回复内容',
  `is_look` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户是否查看（0未查看，1已查看）',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '回复时间',
  `look_time` int(11) NOT NULL DEFAULT '0' COMMENT '查看时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='用户回复表';

-- ----------------------------
-- Records of cmf_reply
-- ----------------------------
INSERT INTO `cmf_reply` VALUES ('1', '3', 'advice', '针对您的留言进行了回复', '这是回复内容，这是回复内容，这是回复内容，这是回复内容，这是回复内容，这是回复内容，这是回复内容，这是回复内容。', '1', '45', '0', '1539396364');
INSERT INTO `cmf_reply` VALUES ('2', '2', 'advice', '针对您反馈的新题进行了回复', '这是回复内容，这是回复内容，这是回复内容，这是回复内容，这是回复内容，这是回复内容，这是回复内容，这是回复内容。', '1', '45', '0', '1540192487');

-- ----------------------------
-- Table structure for cmf_role
-- ----------------------------
DROP TABLE IF EXISTS `cmf_role`;
CREATE TABLE `cmf_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父角色ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- Records of cmf_role
-- ----------------------------
INSERT INTO `cmf_role` VALUES ('1', '0', '1', '1329633709', '1329633709', '0', '超级管理员', '拥有网站最高管理员权限！');
INSERT INTO `cmf_role` VALUES ('2', '0', '1', '1329633709', '1329633709', '0', '普通管理员', '权限由最高管理员分配！');

-- ----------------------------
-- Table structure for cmf_role_user
-- ----------------------------
DROP TABLE IF EXISTS `cmf_role_user`;
CREATE TABLE `cmf_role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色 id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

-- ----------------------------
-- Records of cmf_role_user
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_route
-- ----------------------------
DROP TABLE IF EXISTS `cmf_route`;
CREATE TABLE `cmf_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态;1:启用,0:不启用',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'URL规则类型;1:用户自定义;2:别名添加',
  `full_url` varchar(255) NOT NULL DEFAULT '' COMMENT '完整url',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '实际显示的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='url路由表';

-- ----------------------------
-- Records of cmf_route
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_slide
-- ----------------------------
DROP TABLE IF EXISTS `cmf_slide`;
CREATE TABLE `cmf_slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示,0不显示',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片分类',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分类备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';

-- ----------------------------
-- Records of cmf_slide
-- ----------------------------
INSERT INTO `cmf_slide` VALUES ('1', '1', '0', '首页幻灯片', '');

-- ----------------------------
-- Table structure for cmf_slide_item
-- ----------------------------
DROP TABLE IF EXISTS `cmf_slide_item`;
CREATE TABLE `cmf_slide_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) NOT NULL DEFAULT '0' COMMENT '幻灯片id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '幻灯片名称',
  `image` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片图片',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片链接',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '幻灯片描述',
  `content` text CHARACTER SET utf8 COMMENT '幻灯片内容',
  `more` text COMMENT '链接打开方式',
  PRIMARY KEY (`id`),
  KEY `slide_id` (`slide_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片子项表';

-- ----------------------------
-- Records of cmf_slide_item
-- ----------------------------
INSERT INTO `cmf_slide_item` VALUES ('1', '1', '1', '10000', '幻灯1', 'admin/20180705/d6ed09ff50239ac28462597bfb71ea5b.jpg', 'http://www.baidu.com', '', '', '', null);
INSERT INTO `cmf_slide_item` VALUES ('2', '1', '1', '10000', '幻灯2', 'admin/20180705/fe2d42121c3ad245fd2d14315a37a7dc.jpg', 'http://www.baidu.com', '', '', '', null);
INSERT INTO `cmf_slide_item` VALUES ('3', '1', '1', '10000', '幻灯3', 'admin/20180705/7dd6ed8c02f72d13400dce60f012aaf1.jpeg', 'http://www.baidu.com', '', '', '', null);

-- ----------------------------
-- Table structure for cmf_test
-- ----------------------------
DROP TABLE IF EXISTS `cmf_test`;
CREATE TABLE `cmf_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `cate_id` int(11) NOT NULL COMMENT '二级分类id',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='测试记录表';

-- ----------------------------
-- Records of cmf_test
-- ----------------------------
INSERT INTO `cmf_test` VALUES ('1', '46', '28', '2018-10-22 13:29:59');
INSERT INTO `cmf_test` VALUES ('2', '45', '28', '2018-10-22 14:47:43');

-- ----------------------------
-- Table structure for cmf_test_detail
-- ----------------------------
DROP TABLE IF EXISTS `cmf_test_detail`;
CREATE TABLE `cmf_test_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_id` int(11) NOT NULL,
  `ask_id` int(11) NOT NULL,
  `right_option_id` int(11) NOT NULL,
  `user_option_id` int(11) NOT NULL,
  `is_right` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='测试详情表';

-- ----------------------------
-- Records of cmf_test_detail
-- ----------------------------
INSERT INTO `cmf_test_detail` VALUES ('1', '1', '22', '93', '93', '1', '2018-10-22 13:57:39');

-- ----------------------------
-- Table structure for cmf_theme
-- ----------------------------
DROP TABLE IF EXISTS `cmf_theme`;
CREATE TABLE `cmf_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后升级时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模板状态,1:正在使用;0:未使用',
  `is_compiled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为已编译模板',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '主题目录名，用于主题的维一标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '主题版本号',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `author` varchar(20) NOT NULL DEFAULT '' COMMENT '主题作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT '支持语言',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '主题关键字',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '主题描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_theme
-- ----------------------------
INSERT INTO `cmf_theme` VALUES ('1', '0', '0', '0', '0', 'simpleboot3', 'simpleboot3', '1.0.2', 'http://demo.thinkcmf.com', '', 'ThinkCMF', 'http://www.thinkcmf.com', 'zh-cn', 'ThinkCMF模板', 'ThinkCMF默认模板');

-- ----------------------------
-- Table structure for cmf_theme_file
-- ----------------------------
DROP TABLE IF EXISTS `cmf_theme_file`;
CREATE TABLE `cmf_theme_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_public` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否公共的模板文件',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '模板名称',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '模板文件名',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作',
  `file` varchar(50) NOT NULL DEFAULT '' COMMENT '模板文件，相对于模板根目录，如Portal/index.html',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '模板文件描述',
  `more` text COMMENT '模板更多配置,用户自己后台设置的',
  `config_more` text COMMENT '模板更多配置,来源模板的配置文件',
  `draft_more` text COMMENT '模板更多配置,用户临时保存的配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_theme_file
-- ----------------------------
INSERT INTO `cmf_theme_file` VALUES ('1', '0', '10', 'simpleboot3', '文章页', 'portal/Article/index', 'portal/article', '文章页模板文件', '{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', '{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', null);
INSERT INTO `cmf_theme_file` VALUES ('2', '0', '10', 'simpleboot3', '联系我们页', 'portal/Page/index', 'portal/contact', '联系我们页模板文件', '{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}', '{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}', null);
INSERT INTO `cmf_theme_file` VALUES ('3', '0', '5', 'simpleboot3', '首页', 'portal/Index/index', 'portal/index', '首页模板文件', '{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `cmf_theme_file` VALUES ('4', '0', '10', 'simpleboot3', '文章列表页', 'portal/List/index', 'portal/list', '文章列表模板文件', '{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `cmf_theme_file` VALUES ('5', '0', '10', 'simpleboot3', '单页面', 'portal/Page/index', 'portal/page', '单页面模板文件', '{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `cmf_theme_file` VALUES ('6', '0', '10', 'simpleboot3', '搜索页面', 'portal/search/index', 'portal/search', '搜索模板文件', '{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}', '{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}', null);
INSERT INTO `cmf_theme_file` VALUES ('7', '1', '0', 'simpleboot3', '模板全局配置', 'public/Config', 'public/config', '模板全局配置文件', '{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}', '{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}', null);
INSERT INTO `cmf_theme_file` VALUES ('8', '1', '1', 'simpleboot3', '导航条', 'public/Nav', 'public/nav', '导航条模板文件', '{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', '{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', null);

-- ----------------------------
-- Table structure for cmf_third_party_user
-- ----------------------------
DROP TABLE IF EXISTS `cmf_third_party_user`;
CREATE TABLE `cmf_third_party_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '本站用户id',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `login_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方惟一码',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='第三方用户表';

-- ----------------------------
-- Records of cmf_third_party_user
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_useing_test
-- ----------------------------
DROP TABLE IF EXISTS `cmf_useing_test`;
CREATE TABLE `cmf_useing_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) NOT NULL COMMENT '测试分类的二级id',
  `code` varchar(255) NOT NULL COMMENT '邀请码',
  `is_use` tinyint(1) NOT NULL COMMENT '0未使用，1已使用',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='记录正在使用的测试题库';

-- ----------------------------
-- Records of cmf_useing_test
-- ----------------------------
INSERT INTO `cmf_useing_test` VALUES ('1', '28', '123456', '1', '2018-10-22 11:00:59');

-- ----------------------------
-- Table structure for cmf_user
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user`;
CREATE TABLE `cmf_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型;1:admin;2:会员',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `coin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '用户手机号',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `user_login` (`user_login`),
  KEY `user_nickname` (`user_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Records of cmf_user
-- ----------------------------
INSERT INTO `cmf_user` VALUES ('1', '1', '0', '-28800', '1540180112', '0', '0', '0.00', '1530688677', '1', 'admin', '###a11e46e2a576215a9b52269bb229a71e', 'admin', '2490795520@qq.com', '', '', '', '111.164.191.186', '', '', null);

-- ----------------------------
-- Table structure for cmf_users
-- ----------------------------
DROP TABLE IF EXISTS `cmf_users`;
CREATE TABLE `cmf_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(150) DEFAULT NULL COMMENT 'avatar',
  `username` varchar(50) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `company` varchar(100) DEFAULT NULL COMMENT '公司',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '上次登录ip',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of cmf_users
-- ----------------------------
INSERT INTO `cmf_users` VALUES ('45', 'http://fqzy.w.bronet.cn/upload/header.png', '飞签之音', '18722495722', '中国石油天然气集团有限公司', '2018-10-11 18:00:05', '2018-10-11 18:00:05', null, '2018-10-13 10:06:19');
INSERT INTO `cmf_users` VALUES ('46', 'http://fqzy.w.bronet.cn/upload/header.png', '宋世杰', '13102112093', '百荣科技有限公司', '2018-10-17 14:38:11', '2018-10-17 14:38:11', null, null);

-- ----------------------------
-- Table structure for cmf_user_action
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_action`;
CREATE TABLE `cmf_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  `reward_number` int(11) NOT NULL DEFAULT '0' COMMENT '奖励次数',
  `cycle_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '周期时间值',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COMMENT '执行操作的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户操作表';

-- ----------------------------
-- Records of cmf_user_action
-- ----------------------------
INSERT INTO `cmf_user_action` VALUES ('1', '1', '1', '1', '2', '1', '用户登录', 'login', 'user', '');

-- ----------------------------
-- Table structure for cmf_user_action_log
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_action_log`;
CREATE TABLE `cmf_user_action_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `object` varchar(100) NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user_id`,`object`,`action`),
  KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访问记录表';

-- ----------------------------
-- Records of cmf_user_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_user_ask
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_ask`;
CREATE TABLE `cmf_user_ask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `cate_id` int(11) NOT NULL COMMENT '分类id',
  `ask_content` varchar(255) NOT NULL COMMENT '问题',
  `right_option` varchar(255) NOT NULL COMMENT '正确答案',
  `one_option` varchar(255) NOT NULL COMMENT '答案1',
  `two_option` varchar(255) NOT NULL COMMENT '答案2',
  `analysis_content` varchar(255) NOT NULL COMMENT '解析',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户反馈新题表';

-- ----------------------------
-- Records of cmf_user_ask
-- ----------------------------
INSERT INTO `cmf_user_ask` VALUES ('1', '2', '1', '这是一个问题？', '这是正确答案。', '这是答案1', '这是答案2', '这是一条解析。', '2018-07-19 14:39:44');
INSERT INTO `cmf_user_ask` VALUES ('4', '45', '1', '1', '2', '3', '4', '5', '2018-10-13 10:41:58');
INSERT INTO `cmf_user_ask` VALUES ('5', '45', '1', '问题', '正确答案', '1', '2', '答案解析', '2018-10-13 10:42:09');
INSERT INTO `cmf_user_ask` VALUES ('6', '45', '1', '问题', '正确答案', '1', '2', '答案解析', '2018-10-13 10:42:29');
INSERT INTO `cmf_user_ask` VALUES ('7', '45', '2', '11', '22', '33', '55', '我现在', '2018-10-13 10:45:58');

-- ----------------------------
-- Table structure for cmf_user_balance_log
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_balance_log`;
CREATE TABLE `cmf_user_balance_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `change` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改余额',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改后余额',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户余额变更日志表';

-- ----------------------------
-- Records of cmf_user_balance_log
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_user_collection
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_collection`;
CREATE TABLE `cmf_user_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `cate_id` int(11) NOT NULL COMMENT '分类id',
  `ask_id` int(11) NOT NULL COMMENT '题目id',
  `create_time` datetime NOT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户收藏表';

-- ----------------------------
-- Records of cmf_user_collection
-- ----------------------------
INSERT INTO `cmf_user_collection` VALUES ('18', '45', '18', '21', '2018-10-16 14:37:31');
INSERT INTO `cmf_user_collection` VALUES ('28', '45', '18', '20', '2018-10-18 15:58:24');
INSERT INTO `cmf_user_collection` VALUES ('34', '45', '6', '21', '2018-10-18 19:18:20');

-- ----------------------------
-- Table structure for cmf_user_doask
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_doask`;
CREATE TABLE `cmf_user_doask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `cate_id` int(11) NOT NULL COMMENT '题库id（二级分类id）',
  `is_end` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否结束（0未结束，1已结束）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户答题记录表';

-- ----------------------------
-- Records of cmf_user_doask
-- ----------------------------
INSERT INTO `cmf_user_doask` VALUES ('145', '45', '18', '0', '2018-10-22 18:06:05', null);

-- ----------------------------
-- Table structure for cmf_user_doask_detail
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_doask_detail`;
CREATE TABLE `cmf_user_doask_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doask_id` int(11) NOT NULL COMMENT '答题记录表id',
  `ask_id` int(11) NOT NULL COMMENT '题目id',
  `right_option_id` int(11) NOT NULL COMMENT '正确答案',
  `user_option_id` int(11) NOT NULL COMMENT '用户答案',
  `is_right` tinyint(4) NOT NULL COMMENT '是否正确（0不正确，1正确）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户答题记录详情表';

-- ----------------------------
-- Records of cmf_user_doask_detail
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_user_exam
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_exam`;
CREATE TABLE `cmf_user_exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `cate_id` int(11) NOT NULL COMMENT '题库id（二级分类id）',
  `is_end` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否结束（0未结束，1已结束）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `all_time` int(10) unsigned NOT NULL COMMENT '总时间(分钟)',
  `use_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用时（分钟）',
  `force_end_time` datetime NOT NULL COMMENT '强制结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户考试记录表';

-- ----------------------------
-- Records of cmf_user_exam
-- ----------------------------
INSERT INTO `cmf_user_exam` VALUES ('88', '45', '6', '1', '2018-10-22 16:18:24', '2018-10-22 16:18:36', '120', '0', '2018-10-22 16:20:24');
INSERT INTO `cmf_user_exam` VALUES ('89', '45', '6', '1', '2018-10-22 16:33:06', '2018-10-22 16:33:12', '120', '0', '2018-10-22 16:35:06');
INSERT INTO `cmf_user_exam` VALUES ('90', '45', '6', '1', '2018-10-22 16:37:08', '2018-10-22 16:37:13', '120', '0', '2018-10-22 16:39:08');
INSERT INTO `cmf_user_exam` VALUES ('91', '45', '6', '1', '2018-10-22 16:53:19', '2018-10-22 16:53:25', '120', '0', '2018-10-22 16:55:19');
INSERT INTO `cmf_user_exam` VALUES ('95', '45', '6', '1', '2018-10-22 17:55:47', '2018-10-22 17:56:05', '120', '0', '2018-10-22 17:57:47');

-- ----------------------------
-- Table structure for cmf_user_exam_detail
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_exam_detail`;
CREATE TABLE `cmf_user_exam_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) NOT NULL COMMENT '考试记录表id',
  `ask_id` int(11) NOT NULL COMMENT '题目id',
  `right_option_id` int(11) NOT NULL COMMENT '正确答案',
  `user_option_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户答案',
  `is_right` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否正确（0不正确，1正确）',
  `exam_num` int(11) NOT NULL COMMENT '题号',
  `do_time` datetime DEFAULT NULL COMMENT '做题时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户考试记录详情表';

-- ----------------------------
-- Records of cmf_user_exam_detail
-- ----------------------------
INSERT INTO `cmf_user_exam_detail` VALUES ('249', '86', '19', '78', '78', '1', '1', '2018-10-22 16:15:13');
INSERT INTO `cmf_user_exam_detail` VALUES ('250', '86', '21', '89', '91', '0', '2', '2018-10-22 16:15:19');
INSERT INTO `cmf_user_exam_detail` VALUES ('251', '86', '20', '87', '88', '0', '3', '2018-10-22 16:15:27');
INSERT INTO `cmf_user_exam_detail` VALUES ('252', '87', '19', '78', '79', '0', '1', '2018-10-22 16:16:03');
INSERT INTO `cmf_user_exam_detail` VALUES ('253', '87', '21', '89', '0', '0', '2', null);
INSERT INTO `cmf_user_exam_detail` VALUES ('254', '87', '20', '87', '0', '0', '3', null);
INSERT INTO `cmf_user_exam_detail` VALUES ('255', '88', '21', '89', '91', '0', '1', '2018-10-22 16:18:25');
INSERT INTO `cmf_user_exam_detail` VALUES ('256', '88', '19', '78', '79', '0', '2', '2018-10-22 16:18:27');
INSERT INTO `cmf_user_exam_detail` VALUES ('257', '88', '20', '87', '87', '1', '3', '2018-10-22 16:18:34');
INSERT INTO `cmf_user_exam_detail` VALUES ('258', '89', '20', '87', '86', '0', '1', '2018-10-22 16:33:08');
INSERT INTO `cmf_user_exam_detail` VALUES ('259', '89', '19', '78', '78', '1', '2', '2018-10-22 16:33:09');
INSERT INTO `cmf_user_exam_detail` VALUES ('260', '89', '21', '89', '91', '0', '3', '2018-10-22 16:33:10');
INSERT INTO `cmf_user_exam_detail` VALUES ('261', '90', '20', '87', '86', '0', '1', '2018-10-22 16:37:09');
INSERT INTO `cmf_user_exam_detail` VALUES ('262', '90', '19', '78', '79', '0', '2', '2018-10-22 16:37:10');
INSERT INTO `cmf_user_exam_detail` VALUES ('263', '90', '21', '89', '92', '0', '3', '2018-10-22 16:37:11');
INSERT INTO `cmf_user_exam_detail` VALUES ('264', '91', '20', '87', '87', '1', '1', '2018-10-22 16:53:21');
INSERT INTO `cmf_user_exam_detail` VALUES ('265', '91', '21', '89', '92', '0', '2', '2018-10-22 16:53:22');
INSERT INTO `cmf_user_exam_detail` VALUES ('266', '91', '19', '78', '78', '1', '3', '2018-10-22 16:53:23');
INSERT INTO `cmf_user_exam_detail` VALUES ('267', '92', '21', '89', '0', '0', '1', null);
INSERT INTO `cmf_user_exam_detail` VALUES ('268', '92', '20', '87', '0', '0', '2', null);
INSERT INTO `cmf_user_exam_detail` VALUES ('269', '92', '19', '78', '0', '0', '3', null);
INSERT INTO `cmf_user_exam_detail` VALUES ('270', '93', '19', '78', '78', '1', '1', '2018-10-22 17:30:07');
INSERT INTO `cmf_user_exam_detail` VALUES ('271', '93', '20', '87', '86', '0', '2', '2018-10-22 17:40:33');
INSERT INTO `cmf_user_exam_detail` VALUES ('272', '93', '21', '89', '92', '0', '3', '2018-10-22 17:40:04');
INSERT INTO `cmf_user_exam_detail` VALUES ('273', '94', '19', '78', '0', '0', '1', null);
INSERT INTO `cmf_user_exam_detail` VALUES ('274', '94', '21', '89', '0', '0', '2', null);
INSERT INTO `cmf_user_exam_detail` VALUES ('275', '94', '20', '87', '0', '0', '3', null);
INSERT INTO `cmf_user_exam_detail` VALUES ('276', '95', '20', '87', '86', '0', '1', '2018-10-22 17:56:02');
INSERT INTO `cmf_user_exam_detail` VALUES ('277', '95', '19', '78', '79', '0', '2', '2018-10-22 17:56:03');
INSERT INTO `cmf_user_exam_detail` VALUES ('278', '95', '21', '89', '91', '0', '3', '2018-10-22 17:56:05');

-- ----------------------------
-- Table structure for cmf_user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_favorite`;
CREATE TABLE `cmf_user_favorite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '收藏内容的原文地址，不带域名',
  `description` varchar(500) CHARACTER SET utf8 DEFAULT '' COMMENT '收藏内容的描述',
  `table_name` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int(10) unsigned DEFAULT '0' COMMENT '收藏内容原来的主键id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户收藏表';

-- ----------------------------
-- Records of cmf_user_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_user_login_attempt
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_login_attempt`;
CREATE TABLE `cmf_user_login_attempt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login_attempts` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试次数',
  `attempt_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试登录时间',
  `locked_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户登录尝试表';

-- ----------------------------
-- Records of cmf_user_login_attempt
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_score_log`;
CREATE TABLE `cmf_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作积分等奖励日志表';

-- ----------------------------
-- Records of cmf_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_user_token
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_token`;
CREATE TABLE `cmf_user_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT ' 过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='用户客户端登录 token 表';

-- ----------------------------
-- Records of cmf_user_token
-- ----------------------------
INSERT INTO `cmf_user_token` VALUES ('1', '1', '1546249219', '1530697219', 'bfb7bd32b721d1e20c3b42bffa92c8709d83c1a459478ab64ae13dc41ee7cc81', 'web');
INSERT INTO `cmf_user_token` VALUES ('7', '45', '1554804005', '1539252005', '321939b8890ccd22145a8ed9933c4ae12710afffe50d89e21af3e900afaaded7', 'app');
INSERT INTO `cmf_user_token` VALUES ('8', '46', '1555310291', '1539758291', '0875f7da239ab57c604d450703a943f702d7d6c69ba35447f515f6e5aedcabb9', 'app');

-- ----------------------------
-- Table structure for cmf_verification_code
-- ----------------------------
DROP TABLE IF EXISTS `cmf_verification_code`;
CREATE TABLE `cmf_verification_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='手机邮箱数字验证码表';

-- ----------------------------
-- Records of cmf_verification_code
-- ----------------------------
