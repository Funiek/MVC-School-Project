﻿
CREATE TABLE [dbo].[Category] (
    [Id]       INT          IDENTITY (1, 1) NOT NULL,
    [ParentId] INT          NULL,
    [Name]     VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[Product] (
    [Id]            INT             IDENTITY (1, 1) NOT NULL,
    [CategoryId]    INT             NOT NULL,
    [DescriptionId] INT             NULL,
    [DateOfAdding]  DATE            NULL,
    [ForPromo]      BIT             NULL,
    [Visible]       BIT             NULL,
    [SKU]           VARCHAR (100)   NULL,
    [Name]          VARCHAR (100)   NULL,
    [Price]         DECIMAL (20, 2) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[User] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Login]        VARCHAR (30)  NOT NULL,
    [PasswordHash] BINARY (32)   NOT NULL,
    [Permission]   BIT           NULL,
    [Email]        VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[StoreData] (
    [Id]              INT          IDENTITY (1, 1) NOT NULL,
    [AttribiuteName]  VARCHAR (30) NOT NULL,
    [AttribiuteValue] VARCHAR (30) NOT NULL
);


CREATE PROCEDURE [dbo].[CreateUser]
@login varchar(30),
@password varchar(64),
@email varchar(100)
AS 
INSERT INTO [User] (Login, PasswordHash, Permission, Email) VALUES (@login,HASHBYTES('SHA2_256',@password),0,@email);

CREATE PROCEDURE GetUser
@login VARCHAR(100),
@password VARCHAR(64)
AS
SELECT TOP 1 * FROM dbo.[User]
WHERE Login=@login AND PasswordHash=@password;

CREATE PROCEDURE SelectAllCategories
AS
SELECT * FROM [Category];

CREATE PROCEDURE SelectAllProducts
AS
SELECT * FROM Product;

CREATE PROCEDURE SelectAllUsers
AS
SELECT * FROM [User];

CREATE PROCEDURE SelectLastCategory
AS
SELECT TOP 1 * FROM [Category]
ORDER BY Id DESC;

CREATE PROCEDURE SelectLastProduct
AS
SELECT TOP 1 * FROM [Product]
ORDER BY Id DESC;

CREATE PROCEDURE SelectLastUser
AS
SELECT TOP 1 * FROM [User]
ORDER BY Id DESC;

CREATE PROCEDURE SelectPromoProducts
@count int
AS
SELECT TOP (@count) * FROM Product
ORDER BY Id ASC;

CREATE PROCEDURE GetCounter
@counter VARCHAR(30) OUTPUT
AS
SELECT @counter=AttribiuteValue FROM StoreData WHERE AttribiuteName LIKE 'COUNTER';

CREATE PROCEDURE UpdateCounter
@counter VARCHAR(30)
AS
UPDATE StoreData SET AttribiuteValue=@counter WHERE AttribiuteName LIKE 'COUNTER';

SET IDENTITY_INSERT [dbo].[StoreData] ON;
INSERT INTO [dbo].[StoreData] ([Id], [AttribiuteName], [AttribiuteValue]) VALUES (1, N'COUNTER', N'7');
SET IDENTITY_INSERT [dbo].[StoreData] OFF;
SET IDENTITY_INSERT [dbo].[Product] ON;
INSERT INTO [dbo].[Product] ([Id], [CategoryId], [DescriptionId], [DateOfAdding], [ForPromo], [Visible], [SKU], [Name], [Price]) VALUES (1, 1, 1, N'2021-11-13', 1, 1, N'INTEL-I5-10600K', N'Intel I5 10600k', CAST(1299.00 AS Decimal(20, 2)));
INSERT INTO [dbo].[Product] ([Id], [CategoryId], [DescriptionId], [DateOfAdding], [ForPromo], [Visible], [SKU], [Name], [Price]) VALUES (2, 1, 2, N'2021-11-13', 1, 1, N'INTEL-I7-10700K', N'Intel I7 10700k', CAST(1699.99 AS Decimal(20, 2)));
INSERT INTO [dbo].[Product] ([Id], [CategoryId], [DescriptionId], [DateOfAdding], [ForPromo], [Visible], [SKU], [Name], [Price]) VALUES (3, 1, 3, N'2021-11-13', 1, 1, N'AMD-R7-3700X', N'AMD Ryzen 7 3700X', CAST(1899.99 AS Decimal(20, 2)));
INSERT INTO [dbo].[Product] ([Id], [CategoryId], [DescriptionId], [DateOfAdding], [ForPromo], [Visible], [SKU], [Name], [Price]) VALUES (4, 1, 4, N'2021-11-13', 1, 1, N'AMD-R9-5950X', N'AMD Ryzen 9 5950X', CAST(3213.33 AS Decimal(20, 2)));
INSERT INTO [dbo].[Product] ([Id], [CategoryId], [DescriptionId], [DateOfAdding], [ForPromo], [Visible], [SKU], [Name], [Price]) VALUES (5, 1, 5, N'2021-11-10', 1, 1, N'AMD-R5-1600', N'AMD Ryzen 5 1600', CAST(521.00 AS Decimal(20, 2)));
INSERT INTO [dbo].[Product] ([Id], [CategoryId], [DescriptionId], [DateOfAdding], [ForPromo], [Visible], [SKU], [Name], [Price]) VALUES (6, 1, 6, N'2013-12-05', 1, 1, N'INTEL-C2-Q6600', N'Intel Core 2 QUAD Q6600', CAST(55.00 AS Decimal(20, 2)));
SET IDENTITY_INSERT [dbo].[Product] OFF;
SET IDENTITY_INSERT [dbo].[User] ON;
INSERT INTO [dbo].[User] ([Id], [Login], [PasswordHash], [Permission], [Email]) VALUES (1, N'Krzysiek', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3, 1, N'funkowski.krzysztof@gmail.com');
INSERT INTO [dbo].[User] ([Id], [Login], [PasswordHash], [Permission], [Email]) VALUES (2, N'Maciek', 0x8D23CF6C86E834A7AA6EDED54C26CE2BB2E74903538C61BDD5D2197997AB2F72, 1, N'maciej@int.com');
INSERT INTO [dbo].[User] ([Id], [Login], [PasswordHash], [Permission], [Email]) VALUES (3, N'User', 0x04F8996DA763B7A969B1028EE3007569EAF3A635486DDAB211D512C85B9DF8FB, 0, N'majonez@wp.pl');
INSERT INTO [dbo].[User] ([Id], [Login], [PasswordHash], [Permission], [Email]) VALUES (4, N'Kacper', 0x5DB1FEE4B5703808C48078A76768B155B421B210C0761CD6A5D223F4D99F1EAA, 0, N'pis@onet.pl');
SET IDENTITY_INSERT [dbo].[User] OFF;