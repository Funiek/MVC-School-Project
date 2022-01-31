USE [master]
GO
/****** Object:  Database [StoreDb]    Script Date: 31.01.2022 08:31:30 ******/
CREATE DATABASE [StoreDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StoreDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\StoreDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StoreDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\StoreDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [StoreDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StoreDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StoreDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StoreDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StoreDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StoreDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StoreDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [StoreDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StoreDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StoreDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StoreDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StoreDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StoreDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StoreDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StoreDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StoreDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StoreDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StoreDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StoreDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StoreDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StoreDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StoreDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StoreDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StoreDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StoreDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StoreDb] SET  MULTI_USER 
GO
ALTER DATABASE [StoreDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StoreDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StoreDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StoreDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StoreDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StoreDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [StoreDb] SET QUERY_STORE = OFF
GO
USE [StoreDb]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Comment] [varchar](2000) NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Description]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Description](
	[DescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [text] NOT NULL,
 CONSTRAINT [PK_Description] PRIMARY KEY CLUSTERED 
(
	[DescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountID] [int] NOT NULL,
	[UserGroupID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Amount] [int] NOT NULL,
	[ExpirationDate] [date] NOT NULL,
	[StartDate] [date] NOT NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Subject] [varchar](100) NOT NULL,
	[Text] [text] NOT NULL,
 CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FavouriteProduct]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FavouriteProduct](
	[FavouriteID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_FavouriteProducts] PRIMARY KEY CLUSTERED 
(
	[FavouriteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[CompanyName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[PriceDescription] [varchar](100) NOT NULL,
	[PaymentMethod] [varchar](50) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[OrderDate] [date] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[UserSurname] [varchar](50) NOT NULL,
	[Shipping] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[DescriptionID] [int] NULL,
	[AddDate] [date] NULL,
	[HavePromoPrice] [bit] NULL,
	[Visible] [bit] NULL,
	[SKU] [varchar](100) NULL,
	[Name] [varchar](100) NULL,
 CONSTRAINT [PK__Product__3214EC07B83F3872] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Order]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Order](
	[Product_OrderID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[Qty] [int] NOT NULL,
 CONSTRAINT [PK_Product_Order] PRIMARY KEY CLUSTERED 
(
	[Product_OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductPrice]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPrice](
	[ProductPriceID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ProductPrice] PRIMARY KEY CLUSTERED 
(
	[ProductPriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductPrice_Discount]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPrice_Discount](
	[ProductPrice_DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[ProductPriceID] [int] NOT NULL,
	[DiscountID] [int] NOT NULL,
	[PromoPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_ProductPrice_Discount] PRIMARY KEY CLUSTERED 
(
	[ProductPrice_DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PromoCode]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromoCode](
	[PromoCodeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Amount] [int] NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Usage] [int] NOT NULL,
	[ExpirationDate] [date] NOT NULL,
	[StartDate] [date] NOT NULL,
 CONSTRAINT [PK_PromoCode] PRIMARY KEY CLUSTERED 
(
	[PromoCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StoreData]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreData](
	[StoreDataID] [int] IDENTITY(1,1) NOT NULL,
	[AttribiuteName] [varchar](30) NOT NULL,
	[AttribiuteValue] [varchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](30) NOT NULL,
	[PasswordHash] [binary](32) NOT NULL,
	[Permission] [bit] NULL,
	[Email] [varchar](100) NULL,
	[Name] [varchar](100) NOT NULL,
	[Surname] [varchar](100) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[Phone] [varchar](13) NULL,
 CONSTRAINT [PK__User__3214EC07A59CF4B4] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_UserGroup]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_UserGroup](
	[User_UserGroupID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[UserGroupID] [int] NOT NULL,
 CONSTRAINT [PK_User_UserGroup] PRIMARY KEY CLUSTERED 
(
	[User_UserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGroup]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroup](
	[UserGroupID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[WarehouseID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Address] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse_Product]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse_Product](
	[Warehouse_ProductID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Qty] [int] NOT NULL,
 CONSTRAINT [PK_Warehouse_Product] PRIMARY KEY CLUSTERED 
(
	[Warehouse_ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [ParentID], [Name]) VALUES (4, NULL, N'Podzespoły komputerowe')
INSERT [dbo].[Category] ([CategoryID], [ParentID], [Name]) VALUES (5, 4, N'Procesory')
INSERT [dbo].[Category] ([CategoryID], [ParentID], [Name]) VALUES (6, 4, N'Karty graficzne')
INSERT [dbo].[Category] ([CategoryID], [ParentID], [Name]) VALUES (7, 4, N'Płyty główne')
INSERT [dbo].[Category] ([CategoryID], [ParentID], [Name]) VALUES (8, NULL, N'Telewizja')
INSERT [dbo].[Category] ([CategoryID], [ParentID], [Name]) VALUES (9, 8, N'Kino domowe')
INSERT [dbo].[Category] ([CategoryID], [ParentID], [Name]) VALUES (10, NULL, N'Wewnętrzne')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Description] ON 

INSERT [dbo].[Description] ([DescriptionID], [Description]) VALUES (1, N'Opis procesora')
INSERT [dbo].[Description] ([DescriptionID], [Description]) VALUES (2, N'Opis karty graficznej')
INSERT [dbo].[Description] ([DescriptionID], [Description]) VALUES (3, N'Opis płyty głównej')
INSERT [dbo].[Description] ([DescriptionID], [Description]) VALUES (4, N'Opis telewizora')
INSERT [dbo].[Description] ([DescriptionID], [Description]) VALUES (5, N'Opis testowy')
SET IDENTITY_INSERT [dbo].[Description] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [UserID], [Price], [PriceDescription], [PaymentMethod], [Address], [OrderDate], [Status], [UserName], [UserSurname], [Shipping]) VALUES (5, 2, CAST(120.00 AS Decimal(18, 2)), N'PLN', N'BLIK', N'Kuczkowska 2/3', CAST(N'2021-01-15' AS Date), N'Potwierdzone', N'Krzysiek', N'Funkowski', N'Odbior')
INSERT [dbo].[Order] ([OrderID], [UserID], [Price], [PriceDescription], [PaymentMethod], [Address], [OrderDate], [Status], [UserName], [UserSurname], [Shipping]) VALUES (6, NULL, CAST(179.99 AS Decimal(18, 2)), N'PLN', N'BLIK', N'Sienkiewicza 6/26', CAST(N'2021-01-16' AS Date), N'Potwierdzone', N'Maciej', N'Fender', N'Kurier')
INSERT [dbo].[Order] ([OrderID], [UserID], [Price], [PriceDescription], [PaymentMethod], [Address], [OrderDate], [Status], [UserName], [UserSurname], [Shipping]) VALUES (7, NULL, CAST(199.99 AS Decimal(18, 2)), N'PLN', N'BLIK', N'Majonezowa 3', CAST(N'2022-01-31' AS Date), N'Potwierdzone', N'Krzysiek', N'Funio', N'Kurier')
INSERT [dbo].[Order] ([OrderID], [UserID], [Price], [PriceDescription], [PaymentMethod], [Address], [OrderDate], [Status], [UserName], [UserSurname], [Shipping]) VALUES (8, NULL, CAST(199.99 AS Decimal(18, 2)), N'PLN', N'Karta', N'Chlebowa 3', CAST(N'2022-01-31' AS Date), N'Potwierdzone', N'Krzysiek', N'Kunkowski', N'Inpost')
INSERT [dbo].[Order] ([OrderID], [UserID], [Price], [PriceDescription], [PaymentMethod], [Address], [OrderDate], [Status], [UserName], [UserSurname], [Shipping]) VALUES (9, NULL, CAST(199.99 AS Decimal(18, 2)), N'PLN', N'Odbior', N'Buczkowska 2', CAST(N'2022-01-31' AS Date), N'Potwierdzone', N'Maciek', N'Fender', N'Punkt odbioru')
INSERT [dbo].[Order] ([OrderID], [UserID], [Price], [PriceDescription], [PaymentMethod], [Address], [OrderDate], [Status], [UserName], [UserSurname], [Shipping]) VALUES (10, NULL, CAST(199.99 AS Decimal(18, 2)), N'PLN', N'Karta', N'Majonezowa 3/2', CAST(N'2022-01-31' AS Date), N'Potwierdzone', N'Krzysiek', N'Funio', N'Osobisty')
INSERT [dbo].[Order] ([OrderID], [UserID], [Price], [PriceDescription], [PaymentMethod], [Address], [OrderDate], [Status], [UserName], [UserSurname], [Shipping]) VALUES (11, NULL, CAST(199.99 AS Decimal(18, 2)), N'PLN', N'Odbior', N'2', CAST(N'2022-01-31' AS Date), N'Potwierdzone', N'Harry', N'Potter', N'Osobisty')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1, 5, 1, CAST(N'2015-02-13' AS Date), 0, 1, N'INTEL-I5-10600K', N'Intel I5 10600k')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (2, 5, 1, CAST(N'2017-03-23' AS Date), 0, 1, N'INTEL-I7-10700K', N'Intel I7 10700k')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (3, 5, 1, CAST(N'2000-12-23' AS Date), 0, 1, N'INTEL-C2-Q6600', N'Intel Dual Quad Core Q6600')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (5, 5, 1, CAST(N'2017-05-17' AS Date), 0, 1, N'AMD-R5-1600', N'Amd Ryzen 1600')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (6, 5, 1, CAST(N'2021-08-13' AS Date), 0, 1, N'AMD-R7-3700X', N'Amd Ryzen 3700X')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (7, 5, 1, CAST(N'2021-11-15' AS Date), 0, 1, N'AMD-R9-5950X', N'Amd Ryzen 5950X')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1010, 6, 1, CAST(N'2021-11-16' AS Date), 0, 1, N'GB-GTX-1660-TI', N'Gigabyte GTX 1660Ti')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1011, 6, 1, CAST(N'2021-11-17' AS Date), 0, 1, N'GB-RTX-3060-TI', N'Gigabyte RTX 3060Ti')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1012, 6, 1, CAST(N'2021-11-18' AS Date), 0, 1, N'GB-RTX-3060', N'Gigabyte RTX 3060')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1013, 6, 1, CAST(N'2021-11-19' AS Date), 0, 1, N'GB-RX-6500XT', N'Gigabyte Radeon RX 6500XT')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1014, 7, 1, CAST(N'2021-11-20' AS Date), 0, 1, N'GB-Z590-AORUS-ULTRA', N'Gigabyte Z590 Aorus Ultra')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1015, 5, 1, CAST(N'2021-11-21' AS Date), 0, 1, N'INTEL-I5-12400F', N'Intel I5 12400F')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1016, 5, 1, CAST(N'2021-11-22' AS Date), 0, 1, N'INTEL-I7-12700K', N'Intel I5 12700k')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [DescriptionID], [AddDate], [HavePromoPrice], [Visible], [SKU], [Name]) VALUES (1017, 6, 1, CAST(N'2021-11-23' AS Date), 0, 1, N'MSI-RX-6700XT', N'MSI Radeon RX 6700XT')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Order] ON 

INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (1, 1, 6, 1)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (2, 3, 6, 2)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (3, 2, 6, 2)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (4, 3, 5, 0)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (5, 3, 5, 6)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (6, 2, 5, 1)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (7, 2, 7, 5)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (8, 3, 8, 1)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (9, 3, 9, 3)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (10, 2, 10, 1)
INSERT [dbo].[Product_Order] ([Product_OrderID], [ProductID], [OrderID], [Qty]) VALUES (11, 7, 11, 6)
SET IDENTITY_INSERT [dbo].[Product_Order] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductPrice] ON 

INSERT [dbo].[ProductPrice] ([ProductPriceID], [ProductID], [Price], [Description]) VALUES (1, 1, CAST(899.99 AS Decimal(18, 2)), N'PLN')
INSERT [dbo].[ProductPrice] ([ProductPriceID], [ProductID], [Price], [Description]) VALUES (2, 2, CAST(1399.99 AS Decimal(18, 2)), N'PLN')
INSERT [dbo].[ProductPrice] ([ProductPriceID], [ProductID], [Price], [Description]) VALUES (3, 3, CAST(199.99 AS Decimal(18, 2)), N'PLN')
INSERT [dbo].[ProductPrice] ([ProductPriceID], [ProductID], [Price], [Description]) VALUES (5, 5, CAST(279.99 AS Decimal(18, 2)), N'PLN')
INSERT [dbo].[ProductPrice] ([ProductPriceID], [ProductID], [Price], [Description]) VALUES (6, 6, CAST(1299.99 AS Decimal(18, 2)), N'PLN')
INSERT [dbo].[ProductPrice] ([ProductPriceID], [ProductID], [Price], [Description]) VALUES (7, 7, CAST(3299.99 AS Decimal(18, 2)), N'PLN')
INSERT [dbo].[ProductPrice] ([ProductPriceID], [ProductID], [Price], [Description]) VALUES (8, 7, CAST(165.52 AS Decimal(18, 2)), N'GBP')
INSERT [dbo].[ProductPrice] ([ProductPriceID], [ProductID], [Price], [Description]) VALUES (9, 1, CAST(165.52 AS Decimal(18, 2)), N'GBP')
SET IDENTITY_INSERT [dbo].[ProductPrice] OFF
GO
SET IDENTITY_INSERT [dbo].[StoreData] ON 

INSERT [dbo].[StoreData] ([StoreDataID], [AttribiuteName], [AttribiuteValue]) VALUES (2, N'COUNTER', N'146')
SET IDENTITY_INSERT [dbo].[StoreData] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [Login], [PasswordHash], [Permission], [Email], [Name], [Surname], [Address], [Phone]) VALUES (1, N'admin', 0x8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918, 1, N'admin@komp.pl', N'Master', N'Master', N'ul. Kawowa 2/3', N'123321123')
INSERT [dbo].[User] ([UserID], [Login], [PasswordHash], [Permission], [Email], [Name], [Surname], [Address], [Phone]) VALUES (2, N'kfunkowski', 0x5FAB5175C47906CF9521BC1C238C10D296DFE28BA8EB730859BDFF8A2BF714B8, 1, N'krzysztof.funkowki@komp.pl', N'Krzysztof', N'Funkowski', N'ul. Kuczkowska 2', N'321123321')
INSERT [dbo].[User] ([UserID], [Login], [PasswordHash], [Permission], [Email], [Name], [Surname], [Address], [Phone]) VALUES (3, N'mfender', 0x27EFB1707A9F34BA3C48559BADD64C71920516FA117FF70D0B16CB8BC103FFEB, 1, N'maciej.fender@komp.pl', N'Maciej', N'Fender', N'ul. Blubowa 51', N'321123623')
INSERT [dbo].[User] ([UserID], [Login], [PasswordHash], [Permission], [Email], [Name], [Surname], [Address], [Phone]) VALUES (4, N'krutkapilka', 0x9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08, 0, N'krutkapilka@gmail.com', N'Grzesio', N'Papulski', N'ul. Arka Gdynia 2', N'987654321')
INSERT [dbo].[User] ([UserID], [Login], [PasswordHash], [Permission], [Email], [Name], [Surname], [Address], [Phone]) VALUES (5, N'gofrowacegla', 0x9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08, 0, N'gol@wp.pl', N'Karolina', N'Zębacka', N'ul. Trójki Dla Studenta 3', N'123456789')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[User_UserGroup] ON 

INSERT [dbo].[User_UserGroup] ([User_UserGroupID], [UserID], [UserGroupID]) VALUES (1, 1, 5)
INSERT [dbo].[User_UserGroup] ([User_UserGroupID], [UserID], [UserGroupID]) VALUES (2, 2, 5)
INSERT [dbo].[User_UserGroup] ([User_UserGroupID], [UserID], [UserGroupID]) VALUES (3, 3, 5)
INSERT [dbo].[User_UserGroup] ([User_UserGroupID], [UserID], [UserGroupID]) VALUES (4, 4, 1)
INSERT [dbo].[User_UserGroup] ([User_UserGroupID], [UserID], [UserGroupID]) VALUES (5, 5, 2)
SET IDENTITY_INSERT [dbo].[User_UserGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[UserGroup] ON 

INSERT [dbo].[UserGroup] ([UserGroupID], [Name]) VALUES (1, N'Klienci')
INSERT [dbo].[UserGroup] ([UserGroupID], [Name]) VALUES (2, N'Hurtownia')
INSERT [dbo].[UserGroup] ([UserGroupID], [Name]) VALUES (3, N'Sklepy')
INSERT [dbo].[UserGroup] ([UserGroupID], [Name]) VALUES (4, N'Newsletter')
INSERT [dbo].[UserGroup] ([UserGroupID], [Name]) VALUES (5, N'Pracownicy')
SET IDENTITY_INSERT [dbo].[UserGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouse] ON 

INSERT [dbo].[Warehouse] ([WarehouseID], [Name], [Address]) VALUES (1, N'Magazyn Wyrobów Gotowych', N'ul. Czujkowskiego 2/3')
INSERT [dbo].[Warehouse] ([WarehouseID], [Name], [Address]) VALUES (2, N'Magazyn Techniczny', N'ul. Czujkowskie 2/4')
INSERT [dbo].[Warehouse] ([WarehouseID], [Name], [Address]) VALUES (3, N'Magzyn Półfabrykatów', N'ul. Czujkowskiego 2/5')
SET IDENTITY_INSERT [dbo].[Warehouse] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouse_Product] ON 

INSERT [dbo].[Warehouse_Product] ([Warehouse_ProductID], [WarehouseID], [ProductID], [Qty]) VALUES (1, 1, 1, 12)
INSERT [dbo].[Warehouse_Product] ([Warehouse_ProductID], [WarehouseID], [ProductID], [Qty]) VALUES (3, 1, 2, 262)
INSERT [dbo].[Warehouse_Product] ([Warehouse_ProductID], [WarehouseID], [ProductID], [Qty]) VALUES (4, 1, 3, 643)
INSERT [dbo].[Warehouse_Product] ([Warehouse_ProductID], [WarehouseID], [ProductID], [Qty]) VALUES (11, 1, 5, 523)
SET IDENTITY_INSERT [dbo].[Warehouse_Product] OFF
GO
ALTER TABLE [dbo].[Product_Order] ADD  CONSTRAINT [DF_Product_Order_Qty]  DEFAULT ((0)) FOR [Qty]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Product]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD  CONSTRAINT [FK_Discount_UserGroup] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[UserGroup] ([UserGroupID])
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [FK_Discount_UserGroup]
GO
ALTER TABLE [dbo].[Email]  WITH CHECK ADD  CONSTRAINT [FK_Email_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Email] CHECK CONSTRAINT [FK_Email_User]
GO
ALTER TABLE [dbo].[FavouriteProduct]  WITH CHECK ADD  CONSTRAINT [FK_FavouriteProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FavouriteProduct] CHECK CONSTRAINT [FK_FavouriteProduct_Product]
GO
ALTER TABLE [dbo].[FavouriteProduct]  WITH CHECK ADD  CONSTRAINT [FK_FavouriteProduct_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[FavouriteProduct] CHECK CONSTRAINT [FK_FavouriteProduct_User]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Order]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_User]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Description] FOREIGN KEY([DescriptionID])
REFERENCES [dbo].[Description] ([DescriptionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Description]
GO
ALTER TABLE [dbo].[Product_Order]  WITH CHECK ADD  CONSTRAINT [FK_Product_Order_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Order] CHECK CONSTRAINT [FK_Product_Order_Order]
GO
ALTER TABLE [dbo].[Product_Order]  WITH CHECK ADD  CONSTRAINT [FK_Product_Order_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Product_Order] CHECK CONSTRAINT [FK_Product_Order_Product]
GO
ALTER TABLE [dbo].[ProductPrice]  WITH CHECK ADD  CONSTRAINT [FK_ProductPrice_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductPrice] CHECK CONSTRAINT [FK_ProductPrice_Product]
GO
ALTER TABLE [dbo].[ProductPrice_Discount]  WITH CHECK ADD  CONSTRAINT [FK_ProductPrice_Discount_Discount] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[Discount] ([DiscountID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductPrice_Discount] CHECK CONSTRAINT [FK_ProductPrice_Discount_Discount]
GO
ALTER TABLE [dbo].[ProductPrice_Discount]  WITH CHECK ADD  CONSTRAINT [FK_ProductPrice_Discount_ProductPrice] FOREIGN KEY([ProductPriceID])
REFERENCES [dbo].[ProductPrice] ([ProductPriceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductPrice_Discount] CHECK CONSTRAINT [FK_ProductPrice_Discount_ProductPrice]
GO
ALTER TABLE [dbo].[User_UserGroup]  WITH CHECK ADD  CONSTRAINT [FK_User_UserGroup_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_UserGroup] CHECK CONSTRAINT [FK_User_UserGroup_User]
GO
ALTER TABLE [dbo].[User_UserGroup]  WITH CHECK ADD  CONSTRAINT [FK_UserGroup_User_UserGroup] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[UserGroup] ([UserGroupID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[User_UserGroup] CHECK CONSTRAINT [FK_UserGroup_User_UserGroup]
GO
ALTER TABLE [dbo].[Warehouse_Product]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_Product_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Warehouse_Product] CHECK CONSTRAINT [FK_Warehouse_Product_Product]
GO
ALTER TABLE [dbo].[Warehouse_Product]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_Product_Warehouse] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouse] ([WarehouseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Warehouse_Product] CHECK CONSTRAINT [FK_Warehouse_Product_Warehouse]
GO
/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateUser]
@login varchar(30),
@password varchar(64),
@email varchar(100),
@name varchar(100),
@surname varchar(100),
@address varchar(100),
@phone varchar(13)
AS 
INSERT INTO [User] (Login, PasswordHash, Permission, Email, Name, Surname, Address, Phone) VALUES (@login,HASHBYTES('SHA2_256',@password),0,@email,@name,@surname,@address,@phone)

GO
/****** Object:  StoredProcedure [dbo].[GetCounter]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCounter]
@counter VARCHAR(30) OUTPUT
AS
SELECT @counter=AttribiuteValue FROM StoreData WHERE AttribiuteName LIKE 'COUNTER'
GO
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUser]
@login VARCHAR(100),
@password VARCHAR(64)
AS
SELECT TOP 1 * FROM dbo.[User]
WHERE Login=@login AND PasswordHash=HASHBYTES('SHA2_256',@password)
GO
/****** Object:  StoredProcedure [dbo].[SelectAllCategories]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAllCategories]
AS
SELECT * FROM [Category]
GO
/****** Object:  StoredProcedure [dbo].[SelectAllProducts]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectAllProducts]
AS
SELECT * FROM Product
GO
/****** Object:  StoredProcedure [dbo].[SelectAllUsers]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectAllUsers]
AS
SELECT * FROM [User]
GO
/****** Object:  StoredProcedure [dbo].[SelectLastCategory]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectLastCategory]
AS
SELECT TOP 1 * FROM [Category]
ORDER BY Id DESC
GO
/****** Object:  StoredProcedure [dbo].[SelectLastProduct]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectLastProduct]
AS
SELECT TOP 1 * FROM [Product]
ORDER BY Id DESC
GO
/****** Object:  StoredProcedure [dbo].[SelectLastUser]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectLastUser]
AS
SELECT TOP 1 * FROM [User]
ORDER BY Id DESC
GO
/****** Object:  StoredProcedure [dbo].[SelectPromoProducts]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SelectPromoProducts]
@count int
AS
SELECT TOP (@count) * FROM Product
ORDER BY ProductID ASC
GO
/****** Object:  StoredProcedure [dbo].[UpdateCounter]    Script Date: 31.01.2022 08:31:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCounter]
@counter VARCHAR(30)
AS
UPDATE StoreData SET AttribiuteValue=@counter WHERE AttribiuteName LIKE 'COUNTER'
GO
USE [master]
GO
ALTER DATABASE [StoreDb] SET  READ_WRITE 
GO
