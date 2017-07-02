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

Date: 2017-07-02 15:03:23
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
[CreatedBy] int NULL 
)


GO
DBCC CHECKIDENT(N'[dbo].[Articles]', RESEED, 16)
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
DBCC CHECKIDENT(N'[dbo].[Categories]', RESEED, 21)
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
DBCC CHECKIDENT(N'[dbo].[HotWords]', RESEED, 3)
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
DBCC CHECKIDENT(N'[dbo].[Logs]', RESEED, 192)
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
DBCC CHECKIDENT(N'[dbo].[PendingQuestions]', RESEED, 4)
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
