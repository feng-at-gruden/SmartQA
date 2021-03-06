/*
Navicat SQL Server Data Transfer

Source Server         : 103.254.77.30
Source Server Version : 110000
Source Host           : 103.254.77.30:1433
Source Database       : SmartCMS
Source Schema         : dbo

Target Server Type    : SQL Server
Target Server Version : 110000
File Encoding         : 65001

Date: 2017-07-11 12:18:23
*/


-- ----------------------------
-- Table structure for Articles
-- ----------------------------
DROP TABLE [dbo].[Articles]
GO
CREATE TABLE [dbo].[Articles] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Question] varchar(255) NOT NULL ,
[Answer] varchar(255) NOT NULL ,
[Keywords] varchar(255) NULL ,
[Category] int NULL ,
[Hits] int NULL DEFAULT ((0)) ,
[CreatedAt] datetime NULL ,
[CreatedBy] int NULL ,
[Attachment] varchar(255) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[Articles]', RESEED, 29)
GO

-- ----------------------------
-- Records of Articles
-- ----------------------------
SET IDENTITY_INSERT [dbo].[Articles] ON
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'3', N'暑假到哪里游玩比较好', N'这么专业的问题请咨询：

途牛旅游网 
去哪网
蚂蜂窝
驴妈妈', N'旅游', N'1', N'42', N'2017-06-24 17:35:23.457', N'10', N'/Upload/Attachment/201707/20170711113719.docx')
GO
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'6', N'什么情况下的违章一次性扣12分', N'1.酒后驾驶
2.涂抹车盘
3.肇事逃逸
4.', N'扣分 12分', N'1', N'76', N'2017-06-26 11:42:13.217', N'10', null)
GO
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'7', N'交强险理赔标准', N'这里是内容回答
内容

答案', N'保险 交强险', N'20', N'8', N'2017-06-29 15:00:02.277', N'10', null)
GO
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'8', N'闯红灯扣多少分', N'扣2分 罚款200元', N'闯红灯 违法', N'2', N'37', N'2017-06-29 15:01:28.720', N'10', null)
GO
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'12', N'混道同向电车追尾谁责任大', N'你好，建议及时报警解决，事故责任的划分以交警部门出具的事故责任认定书为准。', N'追尾 混道同向', N'2', N'14', N'2017-07-02 11:42:26.523', N'10', null)
GO
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'17', N'乱使用转向灯属于违章吗', N'在省道上一个分岔路口前方车辆停在路边准备左转弯打着左转向灯，当我的电动车靠近时突然前方车辆突然起步打了右转向灯向左转弯，导致后方的我看见这种突然的举动引起侧翻摔在了地上，后我便起来鸣笛，前方车辆没停就开走了！', N'转向', N'2', N'11', N'2017-07-02 15:38:55.047', N'10', null)
GO
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'19', N'2017节假日', N'节假日安排', N'节日 免费 假日', N'16', N'8', N'2017-07-05 06:47:07.887', N'10', null)
GO
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'20', N'酒驾的危害和处罚', N'一次12分，  终生禁驾，
看他还敢不敢喝

不行就进去关1年！', N'酒驾', N'8', N'3', N'2017-07-08 14:56:46.297', N'10', null)
GO
GO
INSERT INTO [dbo].[Articles] ([Id], [Question], [Answer], [Keywords], [Category], [Hits], [CreatedAt], [CreatedBy], [Attachment]) VALUES (N'29', N'测试', N'测试123', N'测试', N'1', N'0', N'2017-07-11 11:06:41.700', N'10', N'/Upload/Attachment/201707/20170711113258.docx')
GO
GO
SET IDENTITY_INSERT [dbo].[Articles] OFF
GO

-- ----------------------------
-- Table structure for Categories
-- ----------------------------
DROP TABLE [dbo].[Categories]
GO
CREATE TABLE [dbo].[Categories] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Name] varchar(255) NOT NULL ,
[Comment] varchar(255) NULL ,
[Icon] varchar(255) NULL ,
[ParentCategory] int NOT NULL DEFAULT ((0)) ,
[CreatedAt] datetime NULL ,
[CreatedBy] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[Categories]', RESEED, 23)
GO

-- ----------------------------
-- Records of Categories
-- ----------------------------
SET IDENTITY_INSERT [dbo].[Categories] ON
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'1', N'交通法规', N'交通法规要知道', null, N'0', N'2017-06-24 14:02:58.000', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'2', N'违章相关', N'违章记录 抓拍 资料等等', null, N'0', N'2017-06-24 14:02:55.000', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'4', N'节假日通知', N'hehe', null, N'0', N'2017-06-24 14:03:00.000', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'7', N'道路交通安全法', N'道路交通安全法相关知识', null, N'1', N'2017-06-22 22:39:06.530', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'8', N'机动车暂行管理办法', null, null, N'1', N'2017-06-22 22:45:28.483', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'14', N'2017节假日高速免费通知', null, null, N'4', N'2017-06-24 17:05:06.000', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'16', N'2016节假日高速免费通知', N'ok', null, N'4', N'2017-06-24 17:10:57.277', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'17', N'2018节假日高速免费通知', N'OKK', null, N'4', N'2017-06-24 17:14:58.650', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'18', N'保险理赔', null, null, N'0', N'2017-06-28 22:06:00.737', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'19', N'交强险', N'llll', null, N'18', N'2017-06-28 22:06:25.787', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'20', N'第三者责任险', null, null, N'18', N'2017-06-28 22:06:43.177', N'10')
GO
GO
INSERT INTO [dbo].[Categories] ([Id], [Name], [Comment], [Icon], [ParentCategory], [CreatedAt], [CreatedBy]) VALUES (N'21', N'其他问题', N'未分类问题', null, N'0', N'2017-07-02 14:50:13.000', N'10')
GO
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO

-- ----------------------------
-- Table structure for Configurations
-- ----------------------------
DROP TABLE [dbo].[Configurations]
GO
CREATE TABLE [dbo].[Configurations] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Name] varchar(255) NOT NULL ,
[Key] varchar(255) NOT NULL ,
[Value] varchar(255) NOT NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[Configurations]', RESEED, 4)
GO

-- ----------------------------
-- Records of Configurations
-- ----------------------------
SET IDENTITY_INSERT [dbo].[Configurations] ON
GO
SET IDENTITY_INSERT [dbo].[Configurations] OFF
GO

-- ----------------------------
-- Table structure for HotWords
-- ----------------------------
DROP TABLE [dbo].[HotWords]
GO
CREATE TABLE [dbo].[HotWords] (
[Id] int NOT NULL IDENTITY(1,1) ,
[KeyWord] varchar(255) NULL ,
[Hits] int NULL DEFAULT ((0)) ,
[CreatedAt] datetime NULL ,
[CreatedBy] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[HotWords]', RESEED, 20)
GO

-- ----------------------------
-- Records of HotWords
-- ----------------------------
SET IDENTITY_INSERT [dbo].[HotWords] ON
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'1', N'追尾', N'0', N'2017-07-02 11:42:28.883', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'2', N'混道同向', N'0', N'2017-07-02 11:42:30.253', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'4', N'保险', N'0', N'2017-07-02 15:37:00.737', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'5', N'交强险', N'0', N'2017-07-02 15:37:01.127', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'6', N'转向', N'0', N'2017-07-02 15:38:55.263', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'7', N'闯红灯', N'0', N'2017-07-04 00:13:40.670', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'8', N'违法', N'0', N'2017-07-04 00:13:41.007', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'10', N'节日', N'0', N'2017-07-05 06:47:07.890', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'12', N'假日', N'0', N'2017-07-05 06:47:07.893', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'13', N'酒驾', N'0', N'2017-07-08 14:56:46.443', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'14', N'扣分', N'0', N'2017-07-08 15:02:59.597', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'15', N'12分', N'0', N'2017-07-08 15:02:59.930', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'19', N'测试', N'0', N'2017-07-11 11:06:41.723', N'10')
GO
GO
INSERT INTO [dbo].[HotWords] ([Id], [KeyWord], [Hits], [CreatedAt], [CreatedBy]) VALUES (N'20', N'旅游', N'0', N'2017-07-11 11:34:12.963', N'10')
GO
GO
SET IDENTITY_INSERT [dbo].[HotWords] OFF
GO

-- ----------------------------
-- Table structure for Logs
-- ----------------------------
DROP TABLE [dbo].[Logs]
GO
CREATE TABLE [dbo].[Logs] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Action] varchar(255) NOT NULL ,
[ActionTime] datetime NOT NULL ,
[UserId] int NULL ,
[IP] varchar(50) NULL ,
[Client] varchar(255) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[Logs]', RESEED, 248)
GO

-- ----------------------------
-- Records of Logs
-- ----------------------------
SET IDENTITY_INSERT [dbo].[Logs] ON
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'94', N'登录系统', N'2017-06-21 15:02:04.583', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'95', N'退出系统', N'2017-06-21 15:03:55.677', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'96', N'登录系统', N'2017-06-21 15:04:10.960', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'97', N'退出系统', N'2017-06-21 15:04:53.180', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'98', N'登录系统', N'2017-06-21 15:06:11.540', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'99', N'添加用户:Editor1', N'2017-06-21 15:14:16.877', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'100', N'退出系统', N'2017-06-21 15:14:43.180', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'101', N'登录系统', N'2017-06-21 15:15:03.693', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'102', N'退出系统', N'2017-06-21 15:15:03.817', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'103', N'登录系统', N'2017-06-21 15:15:10.817', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'104', N'锁定用户:Editor1', N'2017-06-21 15:15:22.047', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'105', N'退出系统', N'2017-06-21 15:15:25.927', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'106', N'登录系统', N'2017-06-21 15:15:37.857', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'107', N'解锁用户:Editor1', N'2017-06-21 15:15:50.580', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'108', N'修改个人登录密码', N'2017-06-21 15:18:01.217', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'109', N'添加用户:TestUser1', N'2017-06-21 15:47:12.573', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'110', N'修改用户信息:Editor1', N'2017-06-21 15:47:35.743', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'111', N'修改用户信息:Admin', N'2017-06-21 15:47:50.900', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'112', N'登录系统', N'2017-06-22 13:15:07.453', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'113', N'退出系统', N'2017-06-22 13:19:11.107', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'114', N'登录系统', N'2017-06-22 05:26:29.503', N'10', N'39.89.196.5', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'115', N'登录系统', N'2017-06-22 05:32:17.200', N'10', N'39.89.196.5', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'116', N'登录系统', N'2017-06-22 20:01:46.747', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'117', N'登录系统', N'2017-06-22 21:21:15.383', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'118', N'添加分类:暑假优惠大酬宾', N'2017-06-22 22:32:10.347', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'119', N'添加分类:道路安全法', N'2017-06-22 22:34:19.043', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'120', N'添加分类:道路安全法', N'2017-06-22 22:39:07.883', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'121', N'添加分类:机动车暂行管理办法', N'2017-06-22 22:45:30.200', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'122', N'退出系统', N'2017-06-22 22:45:44.473', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'123', N'登录系统', N'2017-06-22 22:45:58.853', null, N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'124', N'退出系统', N'2017-06-22 22:46:01.083', null, N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'125', N'登录系统', N'2017-06-22 22:46:10.177', null, N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'126', N'退出系统', N'2017-06-22 22:46:24.817', null, N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'127', N'登录系统', N'2017-06-22 22:46:34.640', N'11', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'128', N'退出系统', N'2017-06-22 22:46:42.920', N'11', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'129', N'登录系统', N'2017-06-22 22:46:51.327', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'130', N'添加分类:保险理赔   ', N'2017-06-22 22:49:36.360', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'131', N'登录系统', N'2017-06-22 22:54:50.303', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'132', N'修改分类:违章记录', N'2017-06-24 15:02:00.793', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'133', N'修改分类:保险理赔', N'2017-06-24 15:03:05.817', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'134', N'修改分类:交通法规', N'2017-06-24 15:03:18.990', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'135', N'添加分类:2017节假日高速免费通知', N'2017-06-24 15:48:59.057', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'136', N'添加分类:2107公共节日高速收费通知', N'2017-06-24 16:02:32.637', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'137', N'删除分类:2017节假日高速免费通知', N'2017-06-24 16:28:53.407', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'138', N'删除分类:2107公共节日高速收费通知', N'2017-06-24 16:35:53.927', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'139', N'删除用户:TestUser1', N'2017-06-24 16:39:25.647', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'140', N'删除分类:处罚标准', N'2017-06-24 16:55:48.557', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'141', N'修改分类:节假日通知', N'2017-06-24 16:56:11.260', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'142', N'修改分类:节假日通知', N'2017-06-24 16:56:35.520', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'143', N'添加分类:zifenlei', N'2017-06-24 16:56:54.423', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'144', N'删除分类:zifenlei', N'2017-06-24 16:57:15.703', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'145', N'修改分类:节假日通知', N'2017-06-24 17:00:04.537', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'146', N'修改分类:节假日通知', N'2017-06-24 17:00:08.503', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'147', N'添加分类:12312312', N'2017-06-24 17:00:24.633', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'148', N'删除分类:12312312', N'2017-06-24 17:04:43.407', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'149', N'添加分类:2017节假日高速免费通知', N'2017-06-24 17:05:06.347', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'150', N'添加分类:123', N'2017-06-24 17:06:05.460', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'151', N'删除分类:123', N'2017-06-24 17:06:13.457', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'152', N'修改分类:节假日通知', N'2017-06-24 17:10:32.053', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'153', N'添加分类:2016节假日高速免费通', N'2017-06-24 17:10:57.607', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'154', N'修改分类:2016节假日高速免费通知', N'2017-06-24 17:12:00.863', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'155', N'添加分类:2018节假日高速免费通知', N'2017-06-24 17:14:59.387', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'156', N'删除分类:交通法规', N'2017-06-24 17:27:48.360', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'157', N'添加问答', N'2017-06-24 17:30:49.903', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'158', N'添加问答', N'2017-06-24 17:35:24.263', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'159', N'删除问答', N'2017-06-24 17:49:24.770', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'160', N'添加问答', N'2017-06-24 17:49:50.873', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'161', N'删除问答', N'2017-06-24 17:51:03.880', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'162', N'修改分类:交通法规', N'2017-06-24 18:01:44.527', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'163', N'添加问答', N'2017-06-24 18:02:36.200', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'164', N'删除问答', N'2017-06-24 18:02:54.643', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'165', N'修改分类:节假日通知', N'2017-06-25 07:14:20.837', N'10', N'59.53.67.254', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'166', N'修改问答', N'2017-06-25 15:18:49.940', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'167', N'修改问答', N'2017-06-25 15:25:47.483', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'168', N'修改问答', N'2017-06-25 19:42:08.483', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'169', N'添加问答', N'2017-06-26 11:42:13.390', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'170', N'修改分类:交通法规', N'2017-06-26 11:42:42.477', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'171', N'添加分类:保险理赔', N'2017-06-28 22:06:01.560', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'172', N'添加分类:交强险', N'2017-06-28 22:06:26.123', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'173', N'添加分类:第三者责任险', N'2017-06-28 22:06:43.510', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'174', N'修改问答', N'2017-06-29 21:52:23.513', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'175', N'删除分类:暑假优惠大酬宾', N'2017-06-29 14:59:14.800', N'10', N'59.53.67.254', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'176', N'添加问答', N'2017-06-29 15:00:02.287', N'10', N'59.53.67.254', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'177', N'修改分类:违章相关', N'2017-06-29 15:00:55.637', N'10', N'59.53.67.254', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'178', N'添加问答', N'2017-06-29 15:01:28.727', N'10', N'59.53.67.254', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'179', N'添加用户:test', N'2017-06-29 15:02:59.113', N'10', N'59.53.67.254', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'180', N'修改分类:交强险', N'2017-07-01 05:11:33.700', N'10', N'112.5.77.50', N'Firefox 54.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'181', N'修改分类:交强险', N'2017-07-01 05:11:40.490', N'10', N'112.5.77.50', N'Firefox 54.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'182', N'添加问答', N'2017-07-01 10:10:56.480', N'10', N'112.5.77.50', N'Chrome 55.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'183', N'修改问答', N'2017-07-01 10:12:19.613', N'10', N'112.5.77.50', N'Chrome 55.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'184', N'修改问答', N'2017-07-01 10:12:24.480', N'10', N'112.5.77.50', N'Chrome 55.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'185', N'添加问答', N'2017-07-02 11:42:31.680', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'186', N'添加问答', N'2017-07-02 11:43:03.963', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'187', N'删除问答', N'2017-07-02 11:43:19.503', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'188', N'添加问答', N'2017-07-02 14:19:42.157', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'189', N'删除问答', N'2017-07-02 14:27:53.307', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'190', N'添加问答', N'2017-07-02 14:28:01.460', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'191', N'添加问答', N'2017-07-02 14:54:46.543', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'192', N'删除未答条目', N'2017-07-02 14:58:31.010', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'193', N'删除问答', N'2017-07-02 15:32:55.777', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'194', N'修改问答', N'2017-07-02 15:37:00.223', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'195', N'添加问答', N'2017-07-02 15:38:55.880', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'196', N'修改问答', N'2017-07-02 15:39:57.243', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'197', N'删除问答', N'2017-07-02 15:40:20.110', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'198', N'删除问答', N'2017-07-02 15:42:43.853', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'199', N'删除问答', N'2017-07-02 15:43:08.163', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'200', N'删除未答条目', N'2017-07-02 07:56:45.060', N'10', N'59.53.67.252', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'201', N'修改问答', N'2017-07-02 07:56:58.437', N'10', N'59.53.67.252', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'202', N'删除未答条目', N'2017-07-03 17:41:10.583', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'203', N'删除未答条目', N'2017-07-03 17:41:16.043', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'204', N'删除未答条目', N'2017-07-03 17:41:19.407', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'205', N'删除未答条目', N'2017-07-03 17:41:23.100', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'206', N'修改问答', N'2017-07-04 00:11:12.077', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'207', N'修改问答', N'2017-07-04 00:13:40.403', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'208', N'修改问答', N'2017-07-04 00:14:06.427', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'209', N'删除未答条目', N'2017-07-04 09:29:01.957', N'10', N'39.89.196.5', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'210', N'添加问答', N'2017-07-04 09:29:24.017', N'10', N'39.89.196.5', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'211', N'删除未答条目', N'2017-07-04 09:29:31.843', N'10', N'39.89.196.5', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'212', N'删除未答条目', N'2017-07-04 09:30:00.273', N'10', N'39.89.196.5', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'213', N'添加问答', N'2017-07-05 06:47:07.947', N'10', N'112.5.77.50', N'IE 9.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'214', N'删除未答条目', N'2017-07-06 23:48:35.340', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'215', N'修改用户信息:Admin', N'2017-07-08 13:53:17.130', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'216', N'修改用户信息:test', N'2017-07-08 13:54:49.617', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'217', N'修改分类:道路交通安全法', N'2017-07-08 14:29:26.330', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'218', N'添加分类:测试分类', N'2017-07-08 14:39:22.307', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'219', N'删除分类:测试分类', N'2017-07-08 14:40:05.537', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'220', N'添加问答', N'2017-07-08 14:56:47.007', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'221', N'修改问答', N'2017-07-08 15:02:58.933', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'222', N'修改分类:交通法规', N'2017-07-08 07:40:22.750', N'10', N'59.45.152.129', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'223', N'修改分类:交通法规', N'2017-07-08 07:40:30.527', N'10', N'59.45.152.129', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'224', N'删除分类:道路交通法', N'2017-07-08 07:40:37.643', N'10', N'59.45.152.129', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'225', N'添加分类:Test', N'2017-07-09 09:56:51.897', N'10', N'192.168.31.22', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'226', N'删除分类:Test', N'2017-07-09 11:47:30.540', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'227', N'添加问答', N'2017-07-09 13:40:39.973', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'228', N'删除问答', N'2017-07-09 13:55:12.463', N'10', N'192.168.32.167', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'229', N'删除问答', N'2017-07-09 06:57:58.410', N'10', N'59.45.152.129', N'Chrome 57.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'230', N'添加问答', N'2017-07-10 16:52:44.357', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'231', N'添加问答', N'2017-07-10 16:55:13.407', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'232', N'添加问答', N'2017-07-10 17:09:46.150', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'233', N'添加问答', N'2017-07-10 17:12:45.047', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'234', N'添加问答', N'2017-07-11 10:29:46.017', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'235', N'添加问答', N'2017-07-11 10:33:12.610', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'236', N'删除问答', N'2017-07-11 10:55:20.280', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'237', N'删除问答', N'2017-07-11 10:55:25.837', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'238', N'删除问答', N'2017-07-11 10:55:31.373', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'239', N'删除问答', N'2017-07-11 10:55:36.737', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'240', N'删除问答', N'2017-07-11 11:02:00.063', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'241', N'删除问答', N'2017-07-11 11:02:14.977', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'242', N'添加问答', N'2017-07-11 11:02:56.240', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'243', N'删除问答', N'2017-07-11 11:05:14.277', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'244', N'添加问答', N'2017-07-11 11:06:41.807', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'245', N'修改问答', N'2017-07-11 11:31:05.357', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'246', N'修改问答', N'2017-07-11 11:32:58.533', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'247', N'修改问答', N'2017-07-11 11:34:12.927', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
INSERT INTO [dbo].[Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'248', N'修改问答', N'2017-07-11 11:37:19.820', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
SET IDENTITY_INSERT [dbo].[Logs] OFF
GO

-- ----------------------------
-- Table structure for PendingQuestions
-- ----------------------------
DROP TABLE [dbo].[PendingQuestions]
GO
CREATE TABLE [dbo].[PendingQuestions] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Question] varchar(255) NOT NULL ,
[Hits] int NOT NULL DEFAULT ((1)) ,
[LastAskedAt] datetime NOT NULL ,
[CreatedBy] int NULL ,
[CategoryId] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[PendingQuestions]', RESEED, 17)
GO

-- ----------------------------
-- Records of PendingQuestions
-- ----------------------------
SET IDENTITY_INSERT [dbo].[PendingQuestions] ON
GO
INSERT INTO [dbo].[PendingQuestions] ([Id], [Question], [Hits], [LastAskedAt], [CreatedBy], [CategoryId]) VALUES (N'12', N'我一次被扣了12分', N'2', N'2017-07-03 17:41:02.317', N'10', N'2')
GO
GO
INSERT INTO [dbo].[PendingQuestions] ([Id], [Question], [Hits], [LastAskedAt], [CreatedBy], [CategoryId]) VALUES (N'13', N'闯红灯扣多少分', N'1', N'2017-07-03 17:50:16.700', N'10', N'2')
GO
GO
SET IDENTITY_INSERT [dbo].[PendingQuestions] OFF
GO

-- ----------------------------
-- Table structure for UserRoles
-- ----------------------------
DROP TABLE [dbo].[UserRoles]
GO
CREATE TABLE [dbo].[UserRoles] (
[Id] int NOT NULL ,
[Role] varchar(255) NOT NULL 
)


GO

-- ----------------------------
-- Records of UserRoles
-- ----------------------------
INSERT INTO [dbo].[UserRoles] ([Id], [Role]) VALUES (N'1', N'管理员')
GO
GO
INSERT INTO [dbo].[UserRoles] ([Id], [Role]) VALUES (N'2', N'编辑')
GO
GO
INSERT INTO [dbo].[UserRoles] ([Id], [Role]) VALUES (N'3', N'客服')
GO
GO

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE [dbo].[Users]
GO
CREATE TABLE [dbo].[Users] (
[Id] int NOT NULL IDENTITY(1,1) ,
[UserName] varchar(255) NOT NULL ,
[Password] varchar(255) NOT NULL ,
[RoleId] int NULL ,
[RegisterTime] datetime NULL ,
[LastLoginTime] datetime NULL ,
[RealName] varchar(255) NULL ,
[Locked] bit NOT NULL DEFAULT ((0)) ,
[Email] varchar(255) NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[Users]', RESEED, 13)
GO

-- ----------------------------
-- Records of Users
-- ----------------------------
SET IDENTITY_INSERT [dbo].[Users] ON
GO
INSERT INTO [dbo].[Users] ([Id], [UserName], [Password], [RoleId], [RegisterTime], [LastLoginTime], [RealName], [Locked], [Email]) VALUES (N'10', N'Admin', N'123456', N'1', null, N'2017-07-11 10:05:23.920', N'张三丰', N'0', N'691427@qq.com')
GO
GO
INSERT INTO [dbo].[Users] ([Id], [UserName], [Password], [RoleId], [RegisterTime], [LastLoginTime], [RealName], [Locked], [Email]) VALUES (N'11', N'Editor1', N'123456', N'2', N'2017-06-21 15:14:16.427', N'2017-06-22 22:46:34.637', N'编辑小张', N'0', null)
GO
GO
INSERT INTO [dbo].[Users] ([Id], [UserName], [Password], [RoleId], [RegisterTime], [LastLoginTime], [RealName], [Locked], [Email]) VALUES (N'13', N'test', N'123456', N'3', N'2017-06-29 15:02:59.093', N'2017-07-08 07:39:19.667', N'客服小李', N'0', null)
GO
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO

-- ----------------------------
-- Indexes structure for table Articles
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Articles
-- ----------------------------
ALTER TABLE [dbo].[Articles] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Categories
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Categories
-- ----------------------------
ALTER TABLE [dbo].[Categories] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Configurations
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Configurations
-- ----------------------------
ALTER TABLE [dbo].[Configurations] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table HotWords
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table HotWords
-- ----------------------------
ALTER TABLE [dbo].[HotWords] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Logs
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Logs
-- ----------------------------
ALTER TABLE [dbo].[Logs] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table PendingQuestions
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table PendingQuestions
-- ----------------------------
ALTER TABLE [dbo].[PendingQuestions] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserRoles
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UserRoles
-- ----------------------------
ALTER TABLE [dbo].[UserRoles] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Users
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Users
-- ----------------------------
ALTER TABLE [dbo].[Users] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[Articles]
-- ----------------------------
ALTER TABLE [dbo].[Articles] ADD FOREIGN KEY ([Category]) REFERENCES [dbo].[Categories] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Articles] ADD FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[Categories]
-- ----------------------------
ALTER TABLE [dbo].[Categories] ADD FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[HotWords]
-- ----------------------------
ALTER TABLE [dbo].[HotWords] ADD FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[Logs]
-- ----------------------------
ALTER TABLE [dbo].[Logs] ADD FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[PendingQuestions]
-- ----------------------------
ALTER TABLE [dbo].[PendingQuestions] ADD FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[PendingQuestions] ADD FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [dbo].[Users]
-- ----------------------------
ALTER TABLE [dbo].[Users] ADD FOREIGN KEY ([RoleId]) REFERENCES [dbo].[UserRoles] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO
