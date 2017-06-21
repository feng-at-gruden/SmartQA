/*
Navicat SQL Server Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 110000
Source Host           : SC-201705201527\SQLEXPRESS:1433
Source Database       : SmartCMS
Source Schema         : dbo

Target Server Type    : SQL Server
Target Server Version : 110000
File Encoding         : 65001

Date: 2017-06-21 15:52:00
*/


-- ----------------------------
-- Table structure for Articles
-- ----------------------------
DROP TABLE [Articles]
GO
CREATE TABLE [Articles] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Question] varchar(255) NOT NULL ,
[Answer] varchar(255) NOT NULL ,
[Keywords] varchar(255) NULL ,
[Category] int NULL ,
[Hits] int NULL DEFAULT ((0)) ,
[CreatedAt] datetime NULL ,
[CreatedBy] int NULL 
)


GO

-- ----------------------------
-- Records of Articles
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [Articles] ON
GO
SET IDENTITY_INSERT [Articles] OFF
GO
COMMIT TRANSACTION
GO

-- ----------------------------
-- Table structure for Categories
-- ----------------------------
DROP TABLE [Categories]
GO
CREATE TABLE [Categories] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Name] varchar(255) NOT NULL ,
[Comment] varchar(255) NULL ,
[Icon] varchar(255) NULL ,
[ParentCategory] int NOT NULL DEFAULT ((0)) ,
[CreatedAt] datetime NULL ,
[CreatedBy] int NULL 
)


GO

-- ----------------------------
-- Records of Categories
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [Categories] ON
GO
SET IDENTITY_INSERT [Categories] OFF
GO
COMMIT TRANSACTION
GO

-- ----------------------------
-- Table structure for Configurations
-- ----------------------------
DROP TABLE [Configurations]
GO
CREATE TABLE [Configurations] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Name] varchar(255) NOT NULL ,
[Key] varchar(255) NOT NULL ,
[Value] varchar(255) NOT NULL 
)


GO
DBCC CHECKIDENT(N'[Configurations]', RESEED, 4)
GO

-- ----------------------------
-- Records of Configurations
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [Configurations] ON
GO
SET IDENTITY_INSERT [Configurations] OFF
GO
COMMIT TRANSACTION
GO

-- ----------------------------
-- Table structure for Logs
-- ----------------------------
DROP TABLE [Logs]
GO
CREATE TABLE [Logs] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Action] varchar(255) NOT NULL ,
[ActionTime] datetime NOT NULL ,
[UserId] int NULL ,
[IP] varchar(50) NULL ,
[Client] varchar(255) NULL 
)


GO
DBCC CHECKIDENT(N'[Logs]', RESEED, 111)
GO

-- ----------------------------
-- Records of Logs
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [Logs] ON
GO
INSERT INTO [Logs] ([Id], [Action], [ActionTime], [UserId], [IP], [Client]) VALUES (N'94', N'登录系统', N'2017-06-21 15:02:04.583', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'95', N'退出系统', N'2017-06-21 15:03:55.677', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'96', N'登录系统', N'2017-06-21 15:04:10.960', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'97', N'退出系统', N'2017-06-21 15:04:53.180', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'98', N'登录系统', N'2017-06-21 15:06:11.540', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'99', N'添加用户:Editor1', N'2017-06-21 15:14:16.877', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'100', N'退出系统', N'2017-06-21 15:14:43.180', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'101', N'登录系统', N'2017-06-21 15:15:03.693', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'102', N'退出系统', N'2017-06-21 15:15:03.817', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'103', N'登录系统', N'2017-06-21 15:15:10.817', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'104', N'锁定用户:Editor1', N'2017-06-21 15:15:22.047', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'105', N'退出系统', N'2017-06-21 15:15:25.927', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'106', N'登录系统', N'2017-06-21 15:15:37.857', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'107', N'解锁用户:Editor1', N'2017-06-21 15:15:50.580', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'108', N'修改个人登录密码', N'2017-06-21 15:18:01.217', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'109', N'添加用户:TestUser1', N'2017-06-21 15:47:12.573', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'110', N'修改用户信息:Editor1', N'2017-06-21 15:47:35.743', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)'), (N'111', N'修改用户信息:Admin', N'2017-06-21 15:47:50.900', N'10', N'172.23.0.33', N'Chrome 58.0 (WinNT)')
GO
GO
SET IDENTITY_INSERT [Logs] OFF
GO
COMMIT TRANSACTION
GO

-- ----------------------------
-- Table structure for UserRoles
-- ----------------------------
DROP TABLE [UserRoles]
GO
CREATE TABLE [UserRoles] (
[Id] int NOT NULL ,
[Role] varchar(255) NOT NULL 
)


GO

-- ----------------------------
-- Records of UserRoles
-- ----------------------------
BEGIN TRANSACTION
GO
INSERT INTO [UserRoles] ([Id], [Role]) VALUES (N'1', N'管理员'), (N'2', N'编辑'), (N'3', N'客服')
GO
GO
COMMIT TRANSACTION
GO

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE [Users]
GO
CREATE TABLE [Users] (
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
DBCC CHECKIDENT(N'[Users]', RESEED, 12)
GO

-- ----------------------------
-- Records of Users
-- ----------------------------
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [Users] ON
GO
INSERT INTO [Users] ([Id], [UserName], [Password], [RoleId], [RegisterTime], [LastLoginTime], [RealName], [Locked], [Email]) VALUES (N'10', N'Admin', N'123456', N'1', null, N'2017-06-21 15:15:37.853', N'BOSS管理员', N'0', N'691427@qq.com'), (N'11', N'Editor1', N'123456', N'2', N'2017-06-21 15:14:16.427', null, N'编辑小张', N'0', null), (N'12', N'TestUser1', N'123456', N'3', N'2017-06-21 15:47:11.973', null, N'客服小李', N'0', null)
GO
GO
SET IDENTITY_INSERT [Users] OFF
GO
COMMIT TRANSACTION
GO

-- ----------------------------
-- Indexes structure for table Articles
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Articles
-- ----------------------------
ALTER TABLE [Articles] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Categories
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Categories
-- ----------------------------
ALTER TABLE [Categories] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Configurations
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Configurations
-- ----------------------------
ALTER TABLE [Configurations] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Logs
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Logs
-- ----------------------------
ALTER TABLE [Logs] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table UserRoles
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table UserRoles
-- ----------------------------
ALTER TABLE [UserRoles] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Indexes structure for table Users
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table Users
-- ----------------------------
ALTER TABLE [Users] ADD PRIMARY KEY ([Id])
GO

-- ----------------------------
-- Foreign Key structure for table [Articles]
-- ----------------------------
ALTER TABLE [Articles] ADD FOREIGN KEY ([Category]) REFERENCES [Categories] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO
ALTER TABLE [Articles] ADD FOREIGN KEY ([CreatedBy]) REFERENCES [Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [Categories]
-- ----------------------------
ALTER TABLE [Categories] ADD FOREIGN KEY ([CreatedBy]) REFERENCES [Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [Logs]
-- ----------------------------
ALTER TABLE [Logs] ADD FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO

-- ----------------------------
-- Foreign Key structure for table [Users]
-- ----------------------------
ALTER TABLE [Users] ADD FOREIGN KEY ([RoleId]) REFERENCES [UserRoles] ([Id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO
