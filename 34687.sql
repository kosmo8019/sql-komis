
/****** Object:  Database [z_34687]    Script Date: 05.06.2018 12:44:25 ******/
CREATE DATABASE [z_34687]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'z_34687', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\z_34687.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'z_34687_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\z_34687_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [z_34687] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [z_34687].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [z_34687] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [z_34687] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [z_34687] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [z_34687] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [z_34687] SET ARITHABORT OFF 
GO
ALTER DATABASE [z_34687] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [z_34687] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [z_34687] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [z_34687] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [z_34687] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [z_34687] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [z_34687] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [z_34687] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [z_34687] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [z_34687] SET  DISABLE_BROKER 
GO
ALTER DATABASE [z_34687] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [z_34687] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [z_34687] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [z_34687] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [z_34687] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [z_34687] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [z_34687] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [z_34687] SET RECOVERY FULL 
GO
ALTER DATABASE [z_34687] SET  MULTI_USER 
GO
ALTER DATABASE [z_34687] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [z_34687] SET DB_CHAINING OFF 
GO
ALTER DATABASE [z_34687] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [z_34687] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [z_34687] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'z_34687', N'ON'
GO
ALTER DATABASE [z_34687] SET QUERY_STORE = OFF
GO
USE [z_34687]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [z_34687]
GO
/****** Object:  Table [dbo].[rezerwacje]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rezerwacje](
	[nr_rezerwacji] [int] IDENTITY(1,1) NOT NULL,
	[id_wycieczki] [int] NULL,
	[id_osoby] [int] NULL,
	[status] [char](1) NULL,
 CONSTRAINT [PK_rezerwacje] PRIMARY KEY CLUSTERED 
(
	[nr_rezerwacji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wycieczki]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wycieczki](
	[id_wycieczki] [int] IDENTITY(1,1) NOT NULL,
	[nazwa] [varchar](100) NULL,
	[kraj] [varchar](50) NULL,
	[data] [date] NULL,
	[opis] [varchar](200) NULL,
	[liczba_miejsc] [int] NULL,
	[liczba_wolnych_miejsc] [int] NULL,
 CONSTRAINT [PK_wycieczki] PRIMARY KEY CLUSTERED 
(
	[id_wycieczki] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_dostępne_wycieczki]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_dostępne_wycieczki]  as
SELECT wycieczki.kraj, wycieczki.data, wycieczki.nazwa, wycieczki.liczba_miejsc, wycieczki.liczba_miejsc -(SELECT COUNT(rezerwacje.id_osoby) 
 FROM rezerwacje
 WHERE rezerwacje.id_wycieczki = wycieczki.id_wycieczki) AS wolne_miejsca
 FROM wycieczki
 WHERE wycieczki.liczba_miejsc - (SELECT COUNT(rezerwacje.id_osoby)
 FROM rezerwacje
 WHERE rezerwacje.id_wycieczki = wycieczki.id_wycieczki) > 0 AND wycieczki.data >= GETDATE();
GO
/****** Object:  Table [dbo].[osoby]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[osoby](
	[id_osoby] [int] IDENTITY(1,1) NOT NULL,
	[imie] [varchar](50) NULL,
	[nazwisko] [varchar](50) NULL,
	[pesel] [varchar](11) NULL,
	[kontakt] [varchar](100) NULL,
 CONSTRAINT [PK_osoby] PRIMARY KEY CLUSTERED 
(
	[id_osoby] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_rezerwacje_do_ anulowania]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_rezerwacje_do_ anulowania] as
SELECT rezerwacje.status, wycieczki.nazwa, wycieczki.kraj, wycieczki.data, osoby.imie, osoby.nazwisko
FROM rezerwacje INNER JOIN wycieczki ON rezerwacje.id_wycieczki = wycieczki.id_wycieczki 
INNER JOIN osoby ON rezerwacje.id_osoby = osoby.id_osoby
WHERE (rezerwacje.status = 'A' OR rezerwacje.status = 'N') and wycieczki.data>GETDATE() and wycieczki.data<DATEADD(day,7,GETDATE())
GO
/****** Object:  View [dbo].[v_wycieczki_miejsca]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_wycieczki_miejsca]
AS
select kraj, data, nazwa, liczba_miejsc, liczba_miejsc -  (select count(*)    
from rezerwacje
where wycieczki.id_wycieczki = rezerwacje.id_wycieczki and status <> 'A') as liczba_wolnych_miejsc
from wycieczki
GO
/****** Object:  View [dbo].[v_wycieczki_miejsca_II]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_wycieczki_miejsca_II]
AS
select id_wycieczki, kraj, data, nazwa, liczba_miejsc, liczba_miejsc -  (select count(*)    
from rezerwacje
where wycieczki.id_wycieczki = rezerwacje.id_wycieczki and status <> 'A') as liczba_wolnych_miejsc
from wycieczki
GO
/****** Object:  View [dbo].[v_wycieczki_osoby]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_wycieczki_osoby]
AS
SELECT dbo.wycieczki.id_wycieczki, dbo.wycieczki.nazwa,
dbo.wycieczki.kraj, dbo.wycieczki.data, dbo.osoby.imie,
dbo.osoby.nazwisko, dbo.osoby.id_osoby, dbo.rezerwacje.status
FROM dbo.osoby
INNER JOIN
dbo.rezerwacje ON dbo.osoby.id_osoby = dbo.rezerwacje.id_osoby
INNER JOIN
dbo.wycieczki ON dbo.rezerwacje.id_wycieczki = dbo.wycieczki.id_wycieczki


GO
/****** Object:  View [dbo].[v_wycieczki_osoby_potwierdzone]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[v_wycieczki_osoby_potwierdzone]

	as

	select wycieczki.kraj,wycieczki.data,wycieczki.nazwa,osoby.imie,osoby.nazwisko,rezerwacje.status

	from


	osoby inner join 
	rezerwacje on osoby.id_osoby=rezerwacje.id_osoby
	inner join
	wycieczki on rezerwacje.id_wycieczki=wycieczki.id_wycieczki


	where rezerwacje.status='P' or rezerwacje.status='Z'
GO
/****** Object:  View [dbo].[v_wycieczki_przyszle]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_wycieczki_przyszle]

as

select  wycieczki.kraj,wycieczki.data,wycieczki.nazwa,osoby.imie,osoby.nazwisko,rezerwacje.status 

from  osoby
	inner join 
	rezerwacje on rezerwacje.id_osoby=osoby.id_osoby
	inner join 
	wycieczki on wycieczki.id_wycieczki=rezerwacje.id_wycieczki

	
where wycieczki.data > CURRENT_TIMESTAMP
GO
/****** Object:  Table [dbo].[rez_log]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rez_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_rezerwacji] [int] NOT NULL,
	[data] [date] NOT NULL,
	[status] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t](
	[id] [int] NOT NULL,
	[nr] [int] NULL,
	[nr2] [int] NULL,
	[tekst] [nchar](50) NULL,
 CONSTRAINT [PK_t] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_log]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_log](
	[id] [int] NULL,
	[id_t] [int] NULL,
	[nr2] [int] NULL,
	[kiedy] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zabronione]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zabronione](
	[nr2] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[osoby] ON 

INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (1, N'Jan', N'Nowak', N'12345678', N'tel: 2312, dzwonić po 18.00')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (2, N'Adam', N'Kowalski', N'87654321', N'tel: 6623')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (3, N'Maciej', N'Nowak', N'45214565678', N'tel: 12563565, dzwonić po 14.00')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (4, N'Anna', N'Zychowna', N'87654321', N'tel: 66231254')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (5, N'Taylor', N'Clements', N'11', N'391-4733')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (6, N'Jada', N'Rodriquez', N'11', N'387-5192')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (7, N'Yeo', N'Madden', N'11', N'1-893-441-2089')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (8, N'Chancellor', N'Strickland', N'11', N'1-455-158-0337')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (9, N'Cheyenne', N'Cochran', N'11', N'505-3070')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (10, N'Rigel', N'Riggs', N'11', N'1-182-785-8765')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (11, N'Reed', N'Gill', N'11', N'1-571-732-4782')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (12, N'Gwendolyn', N'Jennings', N'11', N'1-381-725-4096')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (13, N'Adrienne', N'Bryant', N'11', N'572-0008')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (14, N'Savannah', N'Lambert', N'11', N'1-207-895-3862')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (15, N'Warren', N'Wood', N'11', N'1-732-588-6382')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (16, N'Griffith', N'Dale', N'11', N'626-5607')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (17, N'Zelenia', N'Chan', N'11', N'111-2103')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (18, N'Eve', N'Garza', N'11', N'1-887-137-6776')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (19, N'Bruce', N'Matthews', N'11', N'1-827-925-2872')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (20, N'Bo', N'Bush', N'11', N'193-6938')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (21, N'Yen', N'Hickman', N'11', N'156-7121')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (22, N'Kyra', N'Fulton', N'11', N'208-3613')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (23, N'Stacey', N'Best', N'11', N'595-0603')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (24, N'Stacy', N'Caldwell', N'11', N'832-6572')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (25, N'Baxter', N'Case', N'11', N'1-810-901-3586')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (26, N'TaShya', N'Morgan', N'11', N'1-224-666-9542')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (27, N'Davis', N'Oneil', N'11', N'900-2795')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (28, N'Gil', N'Flores', N'11', N'1-126-405-8435')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (29, N'Emma', N'Pennington', N'11', N'1-966-721-1544')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (30, N'Aquila', N'Hicks', N'11', N'659-8782')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (31, N'Tallulah', N'Conrad', N'11', N'1-107-758-0044')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (32, N'Dustin', N'Mills', N'11', N'801-3779')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (33, N'Boris', N'Holder', N'11', N'1-157-676-6167')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (34, N'Karyn', N'Anderson', N'11', N'646-0368')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (35, N'Channing', N'Lawson', N'11', N'151-3206')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (36, N'Damian', N'Ayers', N'11', N'458-4026')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (37, N'Eagan', N'Cline', N'11', N'1-411-195-8245')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (38, N'Ocean', N'Gutierrez', N'11', N'556-0181')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (39, N'Carl', N'Herman', N'11', N'257-3302')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (40, N'Medge', N'Wheeler', N'11', N'1-226-830-9267')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (41, N'Luke', N'Parrish', N'11', N'1-589-133-1914')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (42, N'Benjamin', N'Macdonald', N'11', N'652-7966')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (43, N'Kathleen', N'Welch', N'11', N'1-791-181-1824')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (44, N'Pamela', N'Townsend', N'11', N'626-2178')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (45, N'Steven', N'Fitzpatrick', N'11', N'1-627-842-6149')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (46, N'Sandra', N'Brennan', N'11', N'929-8687')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (47, N'Jackson', N'Rocha', N'11', N'1-604-687-4943')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (48, N'Shellie', N'Leonard', N'11', N'1-428-653-3853')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (49, N'Kamal', N'Parsons', N'11', N'973-6155')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (50, N'Rose', N'Morrow', N'11', N'1-633-640-1936')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (51, N'Jescie', N'Hoover', N'11', N'1-133-661-6710')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (52, N'Martha', N'Day', N'11', N'689-7881')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (53, N'Galvin', N'Conley', N'11', N'1-561-163-2771')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (54, N'Mira', N'Simpson', N'11', N'870-8478')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (55, N'Grady', N'Calderon', N'11', N'1-631-698-3024')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (56, N'Rae', N'Keith', N'11', N'1-950-616-5500')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (57, N'Mason', N'Wilkins', N'11', N'1-397-486-1049')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (58, N'Dawn', N'Dale', N'11', N'1-714-148-3811')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (59, N'Alice', N'Aguilar', N'11', N'1-437-708-3586')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (60, N'Dennis', N'Hunt', N'11', N'792-4329')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (61, N'Maggy', N'Griffith', N'11', N'225-6539')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (62, N'Honorato', N'Nixon', N'11', N'1-143-886-4170')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (63, N'Amal', N'Gross', N'11', N'1-877-623-2197')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (64, N'Daphne', N'Abbott', N'11', N'1-909-597-8433')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (65, N'Brenden', N'Flynn', N'11', N'830-4047')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (66, N'Ciara', N'Kirkland', N'11', N'1-683-354-3793')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (67, N'Glenna', N'Vargas', N'11', N'1-450-281-8824')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (68, N'Wesley', N'Avila', N'11', N'829-7427')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (69, N'Camden', N'Lee', N'11', N'1-866-896-5661')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (70, N'Darius', N'Leon', N'11', N'1-181-202-0986')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (71, N'Zoe', N'Hawkins', N'11', N'1-923-482-3352')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (72, N'Kyra', N'Hunter', N'11', N'714-3080')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (73, N'Tanya', N'Fernandez', N'11', N'154-9673')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (74, N'Lara', N'Cooley', N'11', N'1-108-669-6531')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (75, N'Ayanna', N'Goodman', N'11', N'691-1792')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (76, N'Graiden', N'Watson', N'11', N'873-5092')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (77, N'Wing', N'Mcguire', N'11', N'921-1755')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (78, N'Libby', N'Gay', N'11', N'345-0571')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (79, N'Cailin', N'Hernandez', N'11', N'1-571-979-3575')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (80, N'Melvin', N'Serrano', N'11', N'1-844-117-8898')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (81, N'Coby', N'Holcomb', N'11', N'1-282-207-5301')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (82, N'Benjamin', N'Nixon', N'11', N'355-6665')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (83, N'Griffith', N'Beard', N'11', N'1-747-671-6277')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (84, N'Ulric', N'Leach', N'11', N'1-338-618-6105')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (85, N'Carson', N'Morgan', N'11', N'708-0301')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (86, N'Garth', N'Klein', N'11', N'1-574-737-6294')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (87, N'Tana', N'Dunlap', N'11', N'1-335-700-6946')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (88, N'Lana', N'Hammond', N'11', N'473-7536')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (89, N'Haviva', N'Jarvis', N'11', N'1-409-338-4220')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (90, N'Alexander', N'Cain', N'11', N'920-6826')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (91, N'Thomas', N'Gross', N'11', N'699-0359')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (92, N'Stephen', N'Fry', N'11', N'491-9794')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (93, N'Lamar', N'Glass', N'11', N'1-932-891-5330')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (94, N'Martin', N'Rose', N'11', N'793-3959')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (95, N'Wayne', N'Jacobs', N'11', N'761-7560')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (96, N'Lenore', N'Mcclain', N'11', N'1-403-833-9633')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (97, N'Clarke', N'Callahan', N'11', N'1-164-323-3793')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (98, N'Arsenio', N'Fox', N'11', N'810-2576')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (99, N'Lenore', N'Lyons', N'11', N'1-335-390-4614')
GO
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (100, N'Alma', N'Dalton', N'11', N'517-6303')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (101, N'Wyatt', N'Powell', N'11', N'854-0417')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (102, N'Quamar', N'Payne', N'11', N'432-9256')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (103, N'Cassandra', N'Cochran', N'11', N'1-549-265-5105')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (104, N'Ima', N'Petty', N'11', N'1-721-963-0828')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (105, N'Desiree', N'Preston', N'80010109123', N'1-849-560-5264')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (106, N'Marcia', N'Forbes', N'80010109126', N'389-1586')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (107, N'Vincent', N'Stout', N'80010109129', N'647-3137')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (108, N'Emily', N'Fowler', N'80010109132', N'1-537-711-3457')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (109, N'Hiram', N'Quinn', N'80010109135', N'1-675-131-9821')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (110, N'Lars', N'Griffin', N'80010109138', N'1-330-256-4656')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (111, N'Xanthus', N'Valencia', N'80010109141', N'1-356-270-2087')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (112, N'Hyacinth', N'Knight', N'80010109144', N'1-179-807-6722')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (113, N'Lani', N'Sullivan', N'80010109147', N'268-3841')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (114, N'Davis', N'Boyer', N'80010109150', N'851-6520')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (115, N'Hermione', N'Doyle', N'80010109153', N'756-3329')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (116, N'Bert', N'Castillo', N'80010109156', N'577-4054')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (117, N'Zahir', N'Brennan', N'80010109159', N'198-5560')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (118, N'Inga', N'Walter', N'80010109162', N'122-0040')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (119, N'Oprah', N'Duran', N'80010109165', N'1-174-808-1725')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (120, N'Maggy', N'Ortega', N'80010109168', N'1-651-636-2564')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (121, N'Knox', N'Giles', N'80010109171', N'1-499-334-7540')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (122, N'Hadley', N'Beach', N'80010109174', N'592-2019')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (123, N'Dexter', N'Luna', N'80010109177', N'1-698-143-5768')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (124, N'Yvette', N'Clark', N'80010109180', N'1-325-170-8041')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (125, N'Katell', N'Frank', N'80010109183', N'566-2279')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (126, N'Aubrey', N'Jefferson', N'80010109186', N'489-1646')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (127, N'Aquila', N'Chandler', N'80010109189', N'1-374-436-1760')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (128, N'Olympia', N'Noble', N'80010109192', N'1-815-220-7803')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (129, N'Hedy', N'Potter', N'80010109195', N'292-2853')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (130, N'Daniel', N'Gallegos', N'80010109198', N'1-296-211-3909')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (131, N'Sawyer', N'Hogan', N'80010109201', N'1-898-725-5026')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (132, N'Rina', N'Rivers', N'80010109204', N'1-883-994-0949')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (133, N'Kermit', N'Solomon', N'80010109207', N'909-3638')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (134, N'Frances', N'Bishop', N'80010109210', N'647-8566')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (135, N'Heather', N'Mcgee', N'80010109213', N'921-1477')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (136, N'Nerea', N'Whitaker', N'80010109216', N'785-3368')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (137, N'Jackson', N'Contreras', N'80010109219', N'1-228-421-0630')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (138, N'Francis', N'Mills', N'80010109222', N'838-8041')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (139, N'Charlotte', N'Logan', N'80010109225', N'1-980-784-4760')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (140, N'Brian', N'Stuart', N'80010109228', N'950-1645')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (141, N'Holly', N'Downs', N'80010109231', N'1-769-284-8289')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (142, N'Kristen', N'Vaughan', N'80010109234', N'884-8812')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (143, N'Amena', N'Mccormick', N'80010109237', N'525-8150')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (144, N'Dennis', N'Aguirre', N'80010109240', N'750-1933')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (145, N'Jonas', N'Mayo', N'80010109243', N'1-854-741-8213')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (146, N'Lucas', N'Flynn', N'80010109246', N'635-7748')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (147, N'Richard', N'Cardenas', N'80010109249', N'1-749-789-6185')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (148, N'Octavia', N'Sanchez', N'80010109252', N'362-0054')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (149, N'Valentine', N'Navarro', N'80010109255', N'1-217-122-3694')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (150, N'Jared', N'Leonard', N'80010109258', N'709-0145')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (151, N'Lee', N'Valenzuela', N'80010109261', N'912-0824')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (152, N'Chiquita', N'Bruce', N'80010109264', N'1-604-848-9141')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (153, N'Joelle', N'Bright', N'80010109267', N'596-9512')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (154, N'Barclay', N'Finch', N'80010109270', N'1-262-147-1563')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (155, N'Lawrence', N'Doyle', N'80010109273', N'1-199-985-8782')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (156, N'Dahlia', N'Frazier', N'80010109276', N'379-6921')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (157, N'George', N'Whitfield', N'80010109279', N'1-477-104-2687')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (158, N'Whilemina', N'Barrera', N'80010109282', N'174-8142')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (159, N'Kirestin', N'Barron', N'80010109285', N'1-909-465-7874')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (160, N'Pearl', N'Wallace', N'80010109288', N'708-0247')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (161, N'Bree', N'Holland', N'80010109291', N'469-5506')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (162, N'Nora', N'Park', N'80010109294', N'1-642-191-8181')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (163, N'Josiah', N'Knapp', N'80010109297', N'1-763-532-8075')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (164, N'Orlando', N'Wilkins', N'80010109300', N'1-451-954-0424')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (165, N'Branden', N'Haley', N'80010109303', N'1-918-811-9742')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (166, N'Alika', N'Hale', N'80010109306', N'197-9947')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (167, N'Jorden', N'Odonnell', N'80010109309', N'162-0353')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (168, N'Quinn', N'Harvey', N'80010109312', N'536-3935')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (169, N'Elvis', N'Dodson', N'80010109315', N'1-479-466-9662')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (170, N'Kellie', N'Frazier', N'80010109318', N'489-0647')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (171, N'Sharon', N'Walker', N'80010109321', N'284-1871')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (172, N'Steven', N'Travis', N'80010109324', N'717-2193')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (173, N'Marah', N'Richardson', N'80010109327', N'857-0936')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (174, N'Uriel', N'Snider', N'80010109330', N'1-151-564-6005')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (175, N'Harriet', N'Donaldson', N'80010109333', N'1-484-587-2095')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (176, N'August', N'Crane', N'80010109336', N'1-107-392-8730')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (177, N'Wallace', N'Levine', N'80010109339', N'1-686-270-3760')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (178, N'Zachary', N'Johnson', N'80010109342', N'706-1969')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (179, N'Maggie', N'Chandler', N'80010109345', N'888-8406')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (180, N'Macey', N'Juarez', N'80010109348', N'197-6799')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (181, N'Isaac', N'Larson', N'80010109351', N'1-575-657-3553')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (182, N'Hu', N'Kelley', N'80010109354', N'857-7055')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (183, N'Oleg', N'Goff', N'80010109357', N'845-7676')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (184, N'Nola', N'Orr', N'80010109360', N'1-522-857-5005')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (185, N'Otto', N'Meadows', N'80010109363', N'1-268-847-6368')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (186, N'Jenette', N'Wooten', N'80010109366', N'1-547-529-3149')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (187, N'Dane', N'Spence', N'80010109369', N'966-5871')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (188, N'Anthony', N'Olsen', N'80010109372', N'899-9850')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (189, N'Fatima', N'Sawyer', N'80010109375', N'277-5577')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (190, N'Barbara', N'Moore', N'80010109378', N'490-6027')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (191, N'Richard', N'Baker', N'80010109381', N'299-3224')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (192, N'Petra', N'Lott', N'80010109384', N'973-6214')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (193, N'Kibo', N'Bond', N'80010109387', N'216-8058')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (194, N'Connor', N'Nieves', N'80010109390', N'1-448-947-9343')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (195, N'Isadora', N'Heath', N'80010109393', N'1-550-906-7851')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (196, N'Craig', N'Haynes', N'80010109396', N'999-4365')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (197, N'Derek', N'Bullock', N'80010109399', N'1-742-701-7827')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (198, N'Chase', N'Tanner', N'80010109402', N'1-526-151-0587')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (199, N'Daniel', N'Maddox', N'80010109405', N'418-8585')
GO
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (200, N'Hedda', N'Johns', N'80010109408', N'1-629-566-3995')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (201, N'Armando', N'Ware', N'80010109411', N'269-3085')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (202, N'Blaze', N'Good', N'80010109414', N'1-944-682-8823')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (203, N'Igor', N'Warner', N'80010109417', N'224-8528')
INSERT [dbo].[osoby] ([id_osoby], [imie], [nazwisko], [pesel], [kontakt]) VALUES (204, N'Chaim', N'Warner', N'80010109420', N'1-684-709-8457')
SET IDENTITY_INSERT [dbo].[osoby] OFF
SET IDENTITY_INSERT [dbo].[rez_log] ON 

INSERT [dbo].[rez_log] ([id], [id_rezerwacji], [data], [status]) VALUES (7, 122, CAST(N'2018-06-04' AS Date), N'N')
INSERT [dbo].[rez_log] ([id], [id_rezerwacji], [data], [status]) VALUES (8, 122, CAST(N'2018-06-04' AS Date), N'N')
INSERT [dbo].[rez_log] ([id], [id_rezerwacji], [data], [status]) VALUES (9, 122, CAST(N'2018-06-04' AS Date), N'N')
INSERT [dbo].[rez_log] ([id], [id_rezerwacji], [data], [status]) VALUES (10, 121, CAST(N'2018-06-04' AS Date), N'a')
SET IDENTITY_INSERT [dbo].[rez_log] OFF
SET IDENTITY_INSERT [dbo].[rezerwacje] ON 

INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (1, 1, 1, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (2, 2, 2, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (3, 1, 1, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (4, 2, 2, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (5, 3, 1, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (6, 6, 2, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (7, 77, 189, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (8, 62, 124, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (9, 76, 58, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (10, 93, 100, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (11, 43, 56, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (12, 1, 171, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (13, 26, 81, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (14, 20, 187, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (15, 36, 177, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (16, 56, 190, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (17, 44, 80, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (18, 54, 114, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (19, 1, 132, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (20, 12, 80, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (21, 2, 104, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (22, 65, 134, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (23, 89, 50, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (24, 36, 7, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (25, 41, 134, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (26, 16, 97, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (27, 48, 109, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (28, 47, 17, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (29, 43, 197, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (30, 26, 192, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (31, 83, 135, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (32, 84, 111, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (33, 65, 90, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (34, 91, 12, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (35, 33, 62, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (36, 89, 27, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (37, 88, 22, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (38, 80, 133, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (39, 13, 21, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (40, 38, 93, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (41, 32, 170, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (42, 19, 77, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (43, 99, 157, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (44, 44, 168, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (45, 54, 62, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (46, 81, 138, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (47, 45, 84, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (48, 89, 162, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (49, 92, 92, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (50, 56, 48, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (51, 78, 156, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (52, 84, 47, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (53, 9, 179, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (54, 92, 170, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (55, 45, 189, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (56, 21, 164, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (57, 85, 158, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (58, 49, 121, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (59, 92, 8, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (60, 73, 70, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (61, 70, 122, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (62, 92, 4, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (63, 34, 124, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (64, 59, 31, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (65, 85, 17, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (66, 82, 185, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (67, 26, 67, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (68, 88, 114, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (69, 46, 123, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (70, 80, 150, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (71, 12, 72, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (72, 35, 69, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (73, 52, 93, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (74, 19, 108, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (75, 89, 175, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (76, 27, 169, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (77, 39, 43, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (78, 70, 132, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (79, 94, 47, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (80, 25, 70, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (81, 14, 163, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (82, 22, 92, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (83, 55, 123, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (84, 76, 152, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (85, 89, 126, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (86, 97, 108, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (87, 91, 89, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (88, 92, 153, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (89, 56, 119, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (90, 69, 151, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (91, 24, 142, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (92, 49, 90, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (93, 23, 43, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (94, 13, 44, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (95, 48, 98, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (96, 52, 168, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (97, 67, 119, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (98, 29, 132, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (99, 11, 135, N'P')
GO
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (100, 75, 107, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (101, 56, 143, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (102, 54, 131, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (103, 68, 169, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (104, 100, 139, N'P')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (105, 84, 88, N'A')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (106, 61, 179, N'Z')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (107, 107, 55, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (108, 14, 11, NULL)
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (109, 14, 10, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (110, 3, 10, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (111, 49, 26, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (112, 49, 26, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (113, 21, 5, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (114, 21, 5, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (115, 21, 5, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (116, 21, 5, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (117, 21, 5, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (118, 21, 5, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (119, 21, 5, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (120, 21, 5, N'N')
INSERT [dbo].[rezerwacje] ([nr_rezerwacji], [id_wycieczki], [id_osoby], [status]) VALUES (121, 21, 5, N'a')
SET IDENTITY_INSERT [dbo].[rezerwacje] OFF
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (1, 12, 5, N'asd                                               ')
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (2, 1, 2, N'asds                                              ')
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (3, 4, 10, N'wer                                               ')
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (4, 11, 11, N'asds                                              ')
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (5, 14, 16, N'wer                                               ')
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (6, 11, 11, N'asds                                              ')
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (15, 14, 16, N'wer                                               ')
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (18, 14, 16, N'wer                                               ')
INSERT [dbo].[t] ([id], [nr], [nr2], [tekst]) VALUES (20, 14, 16, N'wer                                               ')
INSERT [dbo].[t_log] ([id], [id_t], [nr2], [kiedy]) VALUES (NULL, 18, 16, CAST(N'2018-05-26T18:52:45.020' AS DateTime))
INSERT [dbo].[t_log] ([id], [id_t], [nr2], [kiedy]) VALUES (NULL, 20, 16, CAST(N'2018-05-26T18:53:48.627' AS DateTime))
INSERT [dbo].[t_log] ([id], [id_t], [nr2], [kiedy]) VALUES (NULL, 18, 16, CAST(N'2018-05-26T18:52:45.020' AS DateTime))
INSERT [dbo].[t_log] ([id], [id_t], [nr2], [kiedy]) VALUES (NULL, 20, 16, CAST(N'2018-05-26T18:53:48.627' AS DateTime))
SET IDENTITY_INSERT [dbo].[wycieczki] ON 

INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (1, N'Wycieczka do Paryza', N'Francja', CAST(N'2012-01-01' AS Date), N'Ciekawa wycieczka ...', 3, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (2, N'Piękny Kraków', N'Polska', CAST(N'2013-02-03' AS Date), N'Najciekawa wycieczka ...', 3, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (3, N'Wycieczka do Pekinu', N'Chiny', CAST(N'2019-02-01' AS Date), N'Ciekawa wycieczka ...', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (4, N'Piękny Wąchock', N'Polska', CAST(N'2013-02-03' AS Date), N'katastrofa ...', 12, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (5, N'Wycieczka do Berlina', N'Niemcy', CAST(N'2018-04-01' AS Date), N'Ciekawa wycieczka ...', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (6, N'Londyn', N'Anglia', CAST(N'2018-06-09' AS Date), N'Najciekawa wycieczka ...', 12, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (7, N'Savannah', N'Venezuela', CAST(N'2017-07-24' AS Date), N'ipsum primis in faucibus orci', 7, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (8, N'Boise', N'Guinea', CAST(N'2018-04-22' AS Date), N'In nec orci. Donec nibh.', 21, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (9, N'Candela', N'Indonesia', CAST(N'2018-01-23' AS Date), N'Cras dolor dolor, tempus non,', 29, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (10, N'Viranşehir', N'Afghanistan', CAST(N'2017-09-28' AS Date), N'Vivamus nisi. Mauris nulla. Integer', 23, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (11, N'Adelaide', N'Czech Republic', CAST(N'2017-07-08' AS Date), N'neque. Nullam ut nisi a', 5, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (12, N'Priolo Gargallo', N'Northern Mariana Islands', CAST(N'2017-11-24' AS Date), N'Nam ligula elit, pretium et,', 6, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (13, N'Lang', N'Finland', CAST(N'2017-10-02' AS Date), N'aliquam, enim nec tempus scelerisque,', 5, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (14, N'Milwaukee', N'Chile', CAST(N'2019-02-05' AS Date), N'dictum. Proin eget odio. Aliquam', 20, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (15, N'Rennes', N'Georgia', CAST(N'2018-10-12' AS Date), N'libero. Proin sed turpis nec', 29, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (16, N'Imphal', N'Tuvalu', CAST(N'2017-09-23' AS Date), N'Cras dolor dolor, tempus non,', 13, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (17, N'Ede', N'Falkland Islands', CAST(N'2017-08-23' AS Date), N'Nulla eu neque pellentesque massa', 18, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (18, N'Wagga Wagga', N'Micronesia', CAST(N'2018-04-21' AS Date), N'Nullam lobortis quam a felis', 5, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (19, N'Murcia', N'Tonga', CAST(N'2017-08-01' AS Date), N'lectus pede, ultrices a, auctor', 24, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (20, N'Lleida', N'Zambia', CAST(N'2019-01-26' AS Date), N'iaculis quis, pede. Praesent eu', 21, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (21, N'Long Eaton', N'Philippines', CAST(N'2019-03-03' AS Date), N'accumsan laoreet ipsum. Curabitur consequat,', 27, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (22, N'San Maurizio Canavese', N'Peru', CAST(N'2017-09-11' AS Date), N'sociis natoque penatibus et magnis', 4, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (23, N'Castelseprio', N'American Samoa', CAST(N'2017-12-06' AS Date), N'Sed id risus quis diam', 29, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (24, N'Grande Prairie', N'Jamaica', CAST(N'2018-07-08' AS Date), N'felis. Donec tempor, est ac', 29, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (25, N'Jefferson City', N'Saint Pierre and Miquelon', CAST(N'2018-09-10' AS Date), N'eget odio. Aliquam vulputate ullamcorper', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (26, N'Morro d''Alba', N'Ecuador', CAST(N'2018-03-11' AS Date), N'est, mollis non, cursus non,', 11, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (27, N'Mazy', N'Virgin Islands, British', CAST(N'2018-02-27' AS Date), N'scelerisque mollis. Phasellus libero mauris,', 4, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (28, N'Oldenzaal', N'Korea, North', CAST(N'2017-12-08' AS Date), N'mauris sagittis placerat. Cras dictum', 28, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (29, N'Giardinello', N'South Africa', CAST(N'2019-02-17' AS Date), N'libero. Proin sed turpis nec', 15, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (30, N'Motta Sant''Anastasia', N'Honduras', CAST(N'2017-06-27' AS Date), N'lectus. Nullam suscipit, est ac', 16, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (31, N'Tarbes', N'Cape Verde', CAST(N'2018-03-08' AS Date), N'Nam tempor diam dictum sapien.', 26, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (32, N'Eisenstadt', N'Haiti', CAST(N'2017-07-28' AS Date), N'ornare, elit elit fermentum risus,', 14, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (33, N'Lidingo', N'Tokelau', CAST(N'2019-03-01' AS Date), N'Sed molestie. Sed id risus', 29, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (34, N'Upplands Väsby', N'Jersey', CAST(N'2018-04-24' AS Date), N'sagittis. Nullam vitae diam. Proin', 14, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (35, N'Bavikhove', N'Guadeloupe', CAST(N'2017-06-12' AS Date), N'orci sem eget massa. Suspendisse', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (36, N'Coalhurst', N'Comoros', CAST(N'2019-01-14' AS Date), N'ac arcu. Nunc mauris. Morbi', 5, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (37, N'Sparwood', N'New Caledonia', CAST(N'2018-07-11' AS Date), N'et, commodo at, libero. Morbi', 22, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (38, N'Vitacura', N'Malta', CAST(N'2018-07-30' AS Date), N'ultrices, mauris ipsum porta elit,', 5, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (39, N'Lennik', N'Chad', CAST(N'2017-11-15' AS Date), N'dolor sit amet, consectetuer adipiscing', 17, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (40, N'Sedgewick', N'Oman', CAST(N'2018-01-31' AS Date), N'Curabitur vel lectus. Cum sociis', 11, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (41, N'Bon Accord', N'Tajikistan', CAST(N'2017-07-20' AS Date), N'tincidunt. Donec vitae erat vel', 28, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (42, N'Candela', N'Maldives', CAST(N'2017-05-14' AS Date), N'massa lobortis ultrices. Vivamus rhoncus.', 12, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (43, N'Feldkirchen in Kärnten', N'French Southern Territories', CAST(N'2017-05-06' AS Date), N'risus a ultricies adipiscing, enim', 10, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (44, N'Napoli', N'New Caledonia', CAST(N'2017-07-07' AS Date), N'in felis. Nulla tempor augue', 23, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (45, N'High Wycombe', N'Bolivia', CAST(N'2017-08-07' AS Date), N'enim diam vel arcu. Curabitur', 4, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (46, N'Couthuin', N'Korea, North', CAST(N'2018-06-12' AS Date), N'quam, elementum at, egestas a,', 7, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (47, N'Saint-Denis', N'Cameroon', CAST(N'2018-05-03' AS Date), N'velit. Sed malesuada augue ut', 23, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (48, N'Denny', N'Uganda', CAST(N'2018-08-23' AS Date), N'ut, molestie in, tempus eu,', 16, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (49, N'Habra', N'South Africa', CAST(N'2018-09-30' AS Date), N'ligula. Nullam enim. Sed nulla', 4, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (50, N'Broxburn', N'Brazil', CAST(N'2018-02-15' AS Date), N'sapien. Nunc pulvinar arcu et', 17, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (51, N'Presles', N'Cape Verde', CAST(N'2017-09-02' AS Date), N'ut eros non enim commodo', 10, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (52, N'Quarona', N'Turkmenistan', CAST(N'2018-06-27' AS Date), N'feugiat non, lobortis quis, pede.', 9, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (53, N'Alma', N'South Sudan', CAST(N'2017-07-07' AS Date), N'feugiat placerat velit. Quisque varius.', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (54, N'Mezzana', N'Switzerland', CAST(N'2018-08-12' AS Date), N'In scelerisque scelerisque dui. Suspendisse', 21, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (55, N'Acciano', N'Saint Helena, Ascension and Tristan da Cunha', CAST(N'2019-01-10' AS Date), N'libero. Proin mi. Aliquam gravida', 15, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (56, N'Kozan', N'El Salvador', CAST(N'2017-12-02' AS Date), N'euismod enim. Etiam gravida molestie', 8, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (57, N'Caprauna', N'Tokelau', CAST(N'2018-10-14' AS Date), N'blandit enim consequat purus. Maecenas', 24, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (58, N'Weiterstadt', N'Malawi', CAST(N'2018-01-26' AS Date), N'velit. Quisque varius. Nam porttitor', 27, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (59, N'Hasselt', N'Romania', CAST(N'2018-01-27' AS Date), N'tellus lorem eu metus. In', 8, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (60, N'Wibrin', N'Bouvet Island', CAST(N'2019-03-08' AS Date), N'nibh. Phasellus nulla. Integer vulputate,', 7, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (61, N'Blind River', N'Lesotho', CAST(N'2017-09-10' AS Date), N'tellus justo sit amet nulla.', 16, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (62, N'Beauvechain', N'Dominica', CAST(N'2018-05-17' AS Date), N'nisl sem, consequat nec, mollis', 12, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (63, N'Canora', N'Bangladesh', CAST(N'2017-08-18' AS Date), N'lacus vestibulum lorem, sit amet', 18, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (64, N'Vico nel Lazio', N'Latvia', CAST(N'2018-03-22' AS Date), N'gravida sagittis. Duis gravida. Praesent', 22, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (65, N'Colli a Volturno', N'Singapore', CAST(N'2018-11-05' AS Date), N'ante bibendum ullamcorper. Duis cursus,', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (66, N'Autre-Eglise', N'Montenegro', CAST(N'2018-09-26' AS Date), N'lectus. Nullam suscipit, est ac', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (67, N'Louvain-la-Neuve', N'Liechtenstein', CAST(N'2017-07-30' AS Date), N'a, magna. Lorem ipsum dolor', 11, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (68, N'Wanzele', N'Italy', CAST(N'2018-08-09' AS Date), N'metus. Vivamus euismod urna. Nullam', 8, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (69, N'Cardiff', N'Togo', CAST(N'2018-11-26' AS Date), N'Duis ac arcu. Nunc mauris.', 24, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (70, N'Toulouse', N'Czech Republic', CAST(N'2017-11-27' AS Date), N'a nunc. In at pede.', 28, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (71, N'Collines-de-l''Outaouais', N'Luxembourg', CAST(N'2017-08-19' AS Date), N'lectus quis massa. Mauris vestibulum,', 18, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (72, N'Hope', N'Malaysia', CAST(N'2017-09-03' AS Date), N'ac mattis velit justo nec', 20, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (73, N'Cedar Rapids', N'Greece', CAST(N'2017-11-10' AS Date), N'convallis, ante lectus convallis est,', 4, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (74, N'San Valentino in Abruzzo Citeriore', N'Japan', CAST(N'2017-10-22' AS Date), N'Proin eget odio. Aliquam vulputate', 14, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (75, N'Ciplet', N'Djibouti', CAST(N'2018-11-09' AS Date), N'pellentesque. Sed dictum. Proin eget', 12, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (76, N'Rezé', N'Sierra Leone', CAST(N'2018-08-26' AS Date), N'posuere cubilia Curae; Donec tincidunt.', 14, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (77, N'Padre Hurtado', N'Cook Islands', CAST(N'2018-12-20' AS Date), N'Nunc sollicitudin commodo ipsum. Suspendisse', 22, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (78, N'Dehri', N'Chad', CAST(N'2018-04-02' AS Date), N'Nulla tincidunt, neque vitae semper', 10, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (79, N'Osimo', N'Ireland', CAST(N'2018-05-18' AS Date), N'ante blandit viverra. Donec tempus,', 24, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (80, N'Pelluhue', N'American Samoa', CAST(N'2017-12-11' AS Date), N'Fusce diam nunc, ullamcorper eu,', 9, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (81, N'Bischofshofen', N'Afghanistan', CAST(N'2019-02-26' AS Date), N'fringilla. Donec feugiat metus sit', 12, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (82, N'Dessel', N'Comoros', CAST(N'2018-02-18' AS Date), N'erat, in consectetuer ipsum nunc', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (83, N'Bloomington', N'Ghana', CAST(N'2017-05-15' AS Date), N'mollis. Duis sit amet diam', 30, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (84, N'New Quay', N'Côte D''Ivoire (Ivory Coast)', CAST(N'2017-04-16' AS Date), N'lorem eu metus. In lorem.', 15, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (85, N'San Demetrio Corone', N'Micronesia', CAST(N'2017-07-30' AS Date), N'Nullam enim. Sed nulla ante,', 21, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (86, N'San Leucio del Sannio', N'Costa Rica', CAST(N'2017-06-16' AS Date), N'a, magna. Lorem ipsum dolor', 17, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (87, N'Massemen', N'Mozambique', CAST(N'2018-06-04' AS Date), N'sagittis. Duis gravida. Praesent eu', 9, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (88, N'Merthyr Tydfil', N'Lesotho', CAST(N'2018-06-18' AS Date), N'a sollicitudin orci sem eget', 12, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (89, N'Nil-Saint-Vincent-Saint-Martin', N'Eritrea', CAST(N'2018-06-29' AS Date), N'scelerisque, lorem ipsum sodales purus,', 5, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (90, N'Liévin', N'Ireland', CAST(N'2018-10-09' AS Date), N'in, hendrerit consectetuer, cursus et,', 10, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (91, N'Quickborn', N'Solomon Islands', CAST(N'2018-09-12' AS Date), N'bibendum. Donec felis orci, adipiscing', 12, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (92, N'Penhold', N'Turkey', CAST(N'2019-01-23' AS Date), N'commodo ipsum. Suspendisse non leo.', 23, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (93, N'Montpelier', N'Nepal', CAST(N'2018-01-23' AS Date), N'blandit at, nisi. Cum sociis', 24, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (94, N'Helmond', N'Guyana', CAST(N'2017-08-22' AS Date), N'orci. Phasellus dapibus quam quis', 21, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (95, N'Bostaniçi', N'Myanmar', CAST(N'2017-11-25' AS Date), N'euismod in, dolor. Fusce feugiat.', 19, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (96, N'Ankara', N'Kiribati', CAST(N'2018-09-24' AS Date), N'Curabitur massa. Vestibulum accumsan neque', 9, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (97, N'Augsburg', N'Togo', CAST(N'2018-07-04' AS Date), N'accumsan sed, facilisis vitae, orci.', 22, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (98, N'San Rafael', N'Korea, South', CAST(N'2018-04-03' AS Date), N'at sem molestie sodales. Mauris', 24, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (99, N'Picture Butte', N'Comoros', CAST(N'2018-12-27' AS Date), N'nibh. Aliquam ornare, libero at', 28, NULL)
GO
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (100, N'Stamford', N'Lithuania', CAST(N'2017-05-19' AS Date), N'sem molestie sodales. Mauris blandit', 5, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (101, N'Guadalupe', N'Czech Republic', CAST(N'2018-04-30' AS Date), N'nec, mollis vitae, posuere at,', 22, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (102, N'Argenteuil', N'Central African Republic', CAST(N'2017-11-05' AS Date), N'sit amet, consectetuer adipiscing elit.', 13, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (103, N'Aix-en-Provence', N'South Georgia and The South Sandwich Islands', CAST(N'2018-06-25' AS Date), N'vulputate ullamcorper magna. Sed eu', 10, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (104, N'Quinta Normal', N'Palestine, State of', CAST(N'2019-01-08' AS Date), N'ullamcorper eu, euismod ac, fermentum', 19, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (105, N'Provost', N'Croatia', CAST(N'2017-08-31' AS Date), N'amet lorem semper auctor. Mauris', 20, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (106, N'Isla de Maipo', N'Afghanistan', CAST(N'2018-02-20' AS Date), N'ornare egestas ligula. Nullam feugiat', 24, NULL)
INSERT [dbo].[wycieczki] ([id_wycieczki], [nazwa], [kraj], [data], [opis], [liczba_miejsc], [liczba_wolnych_miejsc]) VALUES (107, N'koala_II', N'australia', CAST(N'2018-04-16' AS Date), N'gorąca wycieczka', 5, NULL)
SET IDENTITY_INSERT [dbo].[wycieczki] OFF
INSERT [dbo].[zabronione] ([nr2]) VALUES (12)
INSERT [dbo].[zabronione] ([nr2]) VALUES (15)
INSERT [dbo].[zabronione] ([nr2]) VALUES (12)
INSERT [dbo].[zabronione] ([nr2]) VALUES (15)
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD  CONSTRAINT [FK_rezerwacje_osoby] FOREIGN KEY([id_osoby])
REFERENCES [dbo].[osoby] ([id_osoby])
GO
ALTER TABLE [dbo].[rezerwacje] CHECK CONSTRAINT [FK_rezerwacje_osoby]
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD  CONSTRAINT [FK_rezerwacje_wycieczki] FOREIGN KEY([id_wycieczki])
REFERENCES [dbo].[wycieczki] ([id_wycieczki])
GO
ALTER TABLE [dbo].[rezerwacje] CHECK CONSTRAINT [FK_rezerwacje_wycieczki]
GO
ALTER TABLE [dbo].[rez_log]  WITH CHECK ADD CHECK  (([status]='A' OR [status]='Z' OR [status]='P' OR [status]='N'))
GO
ALTER TABLE [dbo].[rez_log]  WITH CHECK ADD CHECK  (([status]='A' OR [status]='Z' OR [status]='P' OR [status]='N'))
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD  CONSTRAINT [CK_rezerwacje] CHECK  (([status]='A' OR [status]='Z' OR [status]='P' OR [status]='N'))
GO
ALTER TABLE [dbo].[rezerwacje] CHECK CONSTRAINT [CK_rezerwacje]
GO
/****** Object:  StoredProcedure [dbo].[p_dodaj_rezerwacje]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_dodaj_rezerwacje] @id_wycieczki int, @id_osoby int
AS
BEGIN
    IF @id_wycieczki is null or @id_osoby is null
    BEGIN
        PRINT  'BRAK ARGUMENTU'
        RETURN
    END
    
    IF not exists (select * from wycieczki where id_wycieczki = @id_wycieczki)
    BEGIN
        PRINT 'WYCIECZKA ---' + str( @id_wycieczki) + '--- NIE ISTNIEJE'
       RETURN
    END
    
    IF not exists (select * from osoby where id_osoby = @id_osoby)
    BEGIN
        PRINT 'OSOBA Z ID---' + str( @id_osoby)+'---NIE ISTNIEJE'
       RETURN
    END
    
    IF not exists (select * from wycieczki where id_wycieczki = @id_wycieczki and data >  GETDATE ())
    BEGIN
        PRINT 'TERMIN WYCIECZKI MINĄŁ'
       RETURN
    END

    IF  	(  select liczba_wolnych_miejsc from v_wycieczki_miejsca INNER JOIN wycieczki ON wycieczki.kraj=v_wycieczki_miejsca.kraj AND wycieczki.data=v_wycieczki_miejsca.data
						WHERE wycieczki.id_wycieczki = @id_wycieczki)=0
    BEGIN
        PRINT 'BRAK WOLNYVH MIEJSC NA WYCIECZKĘ :' + str(@id_wycieczki)
       RETURN
    END

    INSERT INTO rezerwacje(id_wycieczki, id_osoby,status)
    VALUES (@id_wycieczki,@id_osoby,'N')
END
GO
/****** Object:  StoredProcedure [dbo].[p_dodaj_rezerwacje_2]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_dodaj_rezerwacje_2] @id_wycieczki int, @id_osoby int
AS
BEGIN

	declare @numer int

    IF @id_wycieczki is null or @id_osoby is null
    BEGIN
        PRINT  'BRAK ARGUMENTU'
        RETURN
    END
    
    IF not exists (select * from wycieczki where id_wycieczki = @id_wycieczki)
    BEGIN
        PRINT 'WYCIECZKA ---' + str( @id_wycieczki) + '--- NIE ISTNIEJE'
       RETURN
    END
    
    IF not exists (select * from osoby where id_osoby = @id_osoby)
    BEGIN
        PRINT 'OSOBA Z ID---' + str( @id_osoby)+'---NIE ISTNIEJE'
       RETURN
    END
    
    IF not exists (select * from wycieczki where id_wycieczki = @id_wycieczki and data >  GETDATE ())
    BEGIN
        PRINT 'TERMIN WYCIECZKI MINĄŁ'
       RETURN
    END

    IF  	(  select v_wycieczki_miejsca_II.liczba_wolnych_miejsc from v_wycieczki_miejsca_II INNER JOIN wycieczki ON wycieczki.kraj=v_wycieczki_miejsca_II.kraj AND wycieczki.data=v_wycieczki_miejsca_II.data
						WHERE wycieczki.id_wycieczki = @id_wycieczki)=0
    BEGIN
        PRINT 'BRAK WOLNYCH MIEJSC NA WYCIECZKĘ :' + str(@id_wycieczki)
       RETURN
    END

    INSERT INTO rezerwacje(id_wycieczki, id_osoby,status)
    VALUES (@id_wycieczki,@id_osoby,'N')

	set @numer =(select max(nr_rezerwacji) from rezerwacje where id_wycieczki = @id_wycieczki)
	
	iNSERT INTO rez_log(id_rezerwacji, data,status)
    VALUES (@numer,GETDATE(),'N')
END
GO
/****** Object:  StoredProcedure [dbo].[p_dostepne_wycieczki]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[p_dostepne_wycieczki] @kraj varchar(50), @data_od date, @data_do date
AS
BEGIN
    IF @kraj is null or @data_od is null or @data_do is null
    BEGIN
            PRINT 'BRAK ARGUMENTU'
        RETURN
    END

    IF not exists (select * from wycieczki where kraj = @kraj)
		BEGIN
				PRINT 'BRAK WYCIECZKI DO KRAJU: ' + @kraj
			RETURN
		END

    IF @data_od > @data_do
		BEGIN
				PRINT 'BŁĘDNE DATY'
			RETURN
		END

    select * from v_dostępne_wycieczki
    where kraj = @kraj and data >= @data_od and data <= @data_do
END
GO
/****** Object:  StoredProcedure [dbo].[p_przyszle_rezerwacje_osoby]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_przyszle_rezerwacje_osoby] @id_osoby INT
AS
BEGIN
    IF @id_osoby is null
    BEGIN
            PRINT 'BRAK ARGUMENTU'
        RETURN
    END

    IF not exists (select * from osoby where id_osoby = @id_osoby)
    BEGIN
            PRINT 'OSOBA Z ID---' + str( @id_osoby)+'---NIE ISTNIEJE'
        RETURN
    END

	IF not exists (  select [kraj],[data],[nazwa],v_wycieczki_przyszle.[imie],v_wycieczki_przyszle.[nazwisko],[status] from v_wycieczki_przyszle 
					INNER JOIN osoby ON 
						osoby.imie=v_wycieczki_przyszle.imie AND osoby.nazwisko=v_wycieczki_przyszle.nazwisko 
						WHERE osoby.id_osoby = @id_osoby)
    BEGIN
        PRINT 'OSOBA Z ID---' + str(@id_osoby)+'---NIE JEST PRZYPISANA DO ŻADNEJ WYCIECZKI'
        RETURN
    END

    select * from v_wycieczki_osoby
    where id_osoby = @id_osoby and data > GETDATE ()
END
GO
/****** Object:  StoredProcedure [dbo].[p_rezerwacje_osoby]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_rezerwacje_osoby] @id_osoby INT
AS
BEGIN
    IF @id_osoby is null
    BEGIN
        PRINT 'BRAK ARGUMENTU'
        RETURN
    END

    IF not exists (select * from osoby where id_osoby = @id_osoby)
    BEGIN
        PRINT 'OSOBA Z ID---' + str( @id_osoby)+'---NIE ISTNIEJE'
        RETURN
    END

	IF not exists (select * from v_wycieczki_osoby where id_osoby = @id_osoby)
    BEGIN
        PRINT 'OSOBA Z ID---' + str( @id_osoby)+'---NIE JEST PRZYPISANA DO ŻADNEJ WYCIECZKI'
        RETURN
    END

    select * from v_wycieczki_osoby
    where id_osoby = @id_osoby
END
GO
/****** Object:  StoredProcedure [dbo].[p_uczestnicy_wycieczki]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_uczestnicy_wycieczki] @id_wycieczki INT
AS
BEGIN
    IF @id_wycieczki is null
    BEGIN
        PRINT 'BRAK ARGUMENTU'
        RETURN
    END
    
    IF not exists (select * from wycieczki where id_wycieczki = @id_wycieczki)
    BEGIN
        PRINT 'WYCIECZKA ---' + str( @id_wycieczki) + '--- NIE ISTNIEJE'
        RETURN
    END

    select * from v_wycieczki_osoby
    where id_wycieczki = @id_wycieczki
END
GO
/****** Object:  StoredProcedure [dbo].[p_usun_rezerwacje]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_usun_rezerwacje] @id_rezerwacji int
AS
BEGIN
    IF @id_rezerwacji is null 
    BEGIN
        PRINT  'BRAK ARGUMENTU'
        RETURN
    END
    
    IF not exists (select * from rezerwacje where nr_rezerwacji = @id_rezerwacji)
    BEGIN
        PRINT 'REZERWACJA ---' + str( @id_rezerwacji) + '--- NIE ISTNIEJE'
       RETURN
    END
    
	delete from rezerwacje where nr_rezerwacji = @id_rezerwacji

	iNSERT INTO rez_log(id_rezerwacji, data,status)
    VALUES (@id_rezerwacji,GETDATE(),'A')
   
END
GO
/****** Object:  StoredProcedure [dbo].[p_zmien_liczbe_miejsc]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_zmien_liczbe_miejsc] @id_wycieczki int, @liczba_miejsc int
AS
BEGIN
Declare
    @zarezerowowane_miejsca int

    IF @id_wycieczki is null or @liczba_miejsc is null
    BEGIN
        PRINT 'BRAK ARGUMENTU'
        RETURN
    END

    IF @liczba_miejsc < 0
    BEGIN
        PRINT 'LICZBA MIEJSC MNIEJSZA OD ZERA'
        RETURN
    END
    
    IF not exists (select * from wycieczki where id_wycieczki = @id_wycieczki)
    BEGIN
       PRINT 'WYCIECZKA ---' + str( @id_wycieczki) + '--- NIE ISTNIEJE'
       RETURN
    END

    select @zarezerowowane_miejsca = count(*) from rezerwacje where id_wycieczki = @id_wycieczki and status <> 'A'
    IF @liczba_miejsc < @zarezerowowane_miejsca
    BEGIN
        PRINT 'ODMOWA !!!  ILOŚĆ REZERWACJI  '+str(@zarezerowowane_miejsca)+' JEST WIĘKSZA NIŻ ILOŚĆ MIEJSC '+str(@liczba_miejsc)+''
       RETURN
    END

    Update wycieczki
    set liczba_miejsc = @liczba_miejsc
    where id_wycieczki = @id_wycieczki
END
GO
/****** Object:  StoredProcedure [dbo].[p_zmien_status_rezerwacji]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_zmien_status_rezerwacji] @nr_rezerwacji int, @status char(1)
AS
BEGIN
Declare
        @id_wycieczki int, @stary_status char(1)

IF @nr_rezerwacji is null or @status is null
    BEGIN
            PRINT 'BRAK ARGUMENTU'
            RETURN
    END
    
    IF not exists (select * from rezerwacje where nr_rezerwacji = @nr_rezerwacji)
    BEGIN
           PRINT 'BRAK REZERWACJI' + str( @nr_rezerwacji)
           RETURN
    END
    
    IF (select status from rezerwacje where nr_rezerwacji = @nr_rezerwacji) = @status
    BEGIN
            PRINT 'BRAK ZMIAN'
           RETURN
    END

    select @id_wycieczki = id_wycieczki, @stary_status = status from rezerwacje where nr_rezerwacji = @nr_rezerwacji

    IF @stary_status = 'A' and (select liczba_wolnych_miejsc from v_wycieczki_miejsca_II where @id_wycieczki = id_wycieczki) < 1
    BEGIN
            PRINT 'BRAK WOLNYCH MIEJSC' + str( @id_wycieczki)
           RETURN
    END

    Update rezerwacje
        set status = @status
        where nr_rezerwacji = @nr_rezerwacji
END
GO
/****** Object:  StoredProcedure [dbo].[p_zmien_status_rezerwacji_2]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_zmien_status_rezerwacji_2] @nr_rezerwacji int, @status char(1)
AS
BEGIN
Declare
        @id_wycieczki int, @stary_status char(1)

IF @nr_rezerwacji is null or @status is null
    BEGIN
            PRINT 'BRAK ARGUMENTU'
            RETURN
    END
    
    IF not exists (select * from rezerwacje where nr_rezerwacji = @nr_rezerwacji)
    BEGIN
           PRINT 'BRAK REZERWACJI' + str( @nr_rezerwacji)
           RETURN
    END
    
    IF (select status from rezerwacje where nr_rezerwacji = @nr_rezerwacji) = @status
    BEGIN
            PRINT 'BRAK ZMIAN'
           RETURN
    END

    select @id_wycieczki = id_wycieczki, @stary_status = status from rezerwacje where nr_rezerwacji = @nr_rezerwacji

    IF @stary_status = 'A' and (select liczba_wolnych_miejsc from v_wycieczki_miejsca_II where @id_wycieczki = id_wycieczki) < 1
    BEGIN
            PRINT 'BRAK WOLNYCH MIEJSC' + str( @id_wycieczki)
           RETURN
    END

    Update rezerwacje
        set status = @status
        where nr_rezerwacji = @nr_rezerwacji

		
	
		iNSERT INTO rez_log(id_rezerwacji, data,status)
		VALUES (@nr_rezerwacji,GETDATE(),@status)

END
GO
/****** Object:  Trigger [dbo].[rez_Delete]    Script Date: 05.06.2018 12:44:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[rez_Delete] ON [dbo].[rezerwacje] 
after insert
AS 

BEGIN   



		INSERT INTO rez_log (id_rezerwacji,data,status)
			SELECT   i.nr_rezerwacji,GETDATE(),i.status
			FROM inserted i


	

END
GO
ALTER TABLE [dbo].[rezerwacje] ENABLE TRIGGER [rez_Delete]
GO
USE [master]
GO
ALTER DATABASE [z_34687] SET  READ_WRITE 
GO
