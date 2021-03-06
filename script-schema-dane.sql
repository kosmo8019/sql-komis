USE [master]
GO
/****** Object:  Database [komis]    Script Date: 05.06.2018 11:24:26 ******/
CREATE DATABASE [komis]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'komis', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\komis.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'komis_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\komis_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [komis] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [komis].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [komis] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [komis] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [komis] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [komis] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [komis] SET ARITHABORT OFF 
GO
ALTER DATABASE [komis] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [komis] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [komis] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [komis] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [komis] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [komis] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [komis] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [komis] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [komis] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [komis] SET  DISABLE_BROKER 
GO
ALTER DATABASE [komis] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [komis] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [komis] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [komis] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [komis] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [komis] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [komis] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [komis] SET RECOVERY FULL 
GO
ALTER DATABASE [komis] SET  MULTI_USER 
GO
ALTER DATABASE [komis] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [komis] SET DB_CHAINING OFF 
GO
ALTER DATABASE [komis] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [komis] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [komis] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'komis', N'ON'
GO
ALTER DATABASE [komis] SET QUERY_STORE = OFF
GO
USE [komis]
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
USE [komis]
GO
/****** Object:  Table [dbo].[klient]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[klient](
	[id_klienta] [int] IDENTITY(1,1) NOT NULL,
	[imie] [varchar](30) NOT NULL,
	[nazwisko] [varchar](50) NOT NULL,
	[email] [varchar](50) NULL,
	[kontakt] [varchar](20) NOT NULL,
	[login] [varchar](15) NOT NULL,
	[haslo] [varchar](15) NOT NULL,
	[typ] [char](1) NOT NULL,
 CONSTRAINT [PK_klient] PRIMARY KEY CLUSTERED 
(
	[id_klienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[klient_dane]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[klient_dane](
	[id_adres] [int] IDENTITY(1,1) NOT NULL,
	[id_klient] [int] NOT NULL,
	[adres_linia_1] [varchar](50) NULL,
	[adres_linia_2] [varchar](50) NULL,
	[miasto] [varchar](40) NULL,
	[kraj] [varchar](25) NULL,
	[kod_pocztowy] [varchar](15) NULL,
	[klie_informacje_dodatkowe] [varchar](50) NULL,
 CONSTRAINT [PK_klient_dane] PRIMARY KEY CLUSTERED 
(
	[id_adres] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_klient_dane]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_klient_dane]
AS
SELECT        dbo.klient.imie, dbo.klient.nazwisko, dbo.klient.email, dbo.klient.kontakt, dbo.klient_dane.adres_linia_1, dbo.klient_dane.adres_linia_2, dbo.klient_dane.miasto, dbo.klient_dane.kod_pocztowy, dbo.klient.typ, 
                         dbo.klient.id_klienta
FROM            dbo.klient LEFT OUTER JOIN
                         dbo.klient_dane ON dbo.klient.id_klienta = dbo.klient_dane.id_klient
WHERE        (dbo.klient.typ = 'S')
GO
/****** Object:  Table [dbo].[klient_preferencje]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[klient_preferencje](
	[id_klient_preferencje] [int] IDENTITY(1,1) NOT NULL,
	[id_klient] [int] NOT NULL,
	[producent] [varchar](50) NULL,
	[model] [varchar](50) NULL,
	[rok_produkcji] [int] NULL,
	[paliwo] [char](1) NULL,
	[nadwozie] [int] NULL,
	[pole_preferencji_1] [int] NULL,
	[pole_preferencji_2] [int] NULL,
	[pole_preferencji_3] [int] NULL,
 CONSTRAINT [PK_klient_preferencje] PRIMARY KEY CLUSTERED 
(
	[id_klient_preferencje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[samochod_wyposazenie]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[samochod_wyposazenie](
	[id_wyposazenie] [int] IDENTITY(1,1) NOT NULL,
	[informacje_opis] [varchar](50) NOT NULL,
 CONSTRAINT [PK_samochod_wyposazenie] PRIMARY KEY CLUSTERED 
(
	[id_wyposazenie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[typ_nadwozia]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[typ_nadwozia](
	[id_nadwozie] [int] IDENTITY(1,1) NOT NULL,
	[nadwozie_typ] [char](20) NOT NULL,
	[nadw_informacje_dodatkowe] [varchar](50) NULL,
 CONSTRAINT [PK_typ_nadwozia] PRIMARY KEY CLUSTERED 
(
	[id_nadwozie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_klienci_preferencje]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_klienci_preferencje]
AS
SELECT        dbo.klient.imie, dbo.klient.nazwisko, dbo.klient_preferencje.producent, dbo.klient_preferencje.model, dbo.klient_preferencje.rok_produkcji, dbo.klient_preferencje.paliwo,
                             (SELECT        nadwozie_typ
                               FROM            dbo.typ_nadwozia
                               WHERE        (dbo.klient_preferencje.nadwozie = id_nadwozie)) AS Expr1,
                             (SELECT        informacje_opis
                               FROM            dbo.samochod_wyposazenie
                               WHERE        (dbo.klient_preferencje.pole_preferencji_1 = id_wyposazenie)) AS Pref_1,
                             (SELECT        informacje_opis
                               FROM            dbo.samochod_wyposazenie AS samochod_wyposazenie_2
                               WHERE        (dbo.klient_preferencje.pole_preferencji_2 = id_wyposazenie)) AS Pref_2,
                             (SELECT        informacje_opis
                               FROM            dbo.samochod_wyposazenie AS samochod_wyposazenie_1
                               WHERE        (dbo.klient_preferencje.pole_preferencji_3 = id_wyposazenie)) AS Pref_3
FROM            dbo.klient INNER JOIN
                         dbo.klient_preferencje ON dbo.klient.id_klienta = dbo.klient_preferencje.id_klient
GO
/****** Object:  View [dbo].[v_preferencje_popularni_producenci]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_preferencje_popularni_producenci]
AS
select top 10 count(producent) as sztuk,producent
from v_klienci_preferencje
group by producent
order by sztuk desc
GO
/****** Object:  Table [dbo].[model]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[model](
	[id_model] [int] IDENTITY(1,1) NOT NULL,
	[prod_nazwa] [varchar](50) NOT NULL,
	[model_nazwa] [char](50) NOT NULL,
	[model_informacje_dodatkowe] [varchar](200) NULL,
 CONSTRAINT [PK_model] PRIMARY KEY CLUSTERED 
(
	[id_model] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[samochody_na_sprzedaz]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[samochody_na_sprzedaz](
	[id_samochod] [int] IDENTITY(1,1) NOT NULL,
	[id_model] [int] NOT NULL,
	[id_nadwozie] [int] NOT NULL,
	[cena] [int] NOT NULL,
	[vin] [varchar](30) NOT NULL,
	[przebieg] [int] NOT NULL,
	[data_produkcji] [int] NULL,
	[status] [char](1) NOT NULL,
	[kraj_pochodzenia] [char](3) NULL,
	[ksiazka_serwisowa] [char](1) NULL,
	[pojemnosc] [int] NULL,
	[paliwo] [char](1) NULL,
	[sam_informacje_dodatkowe] [varchar](50) NULL,
 CONSTRAINT [PK_samochody_na_sprzedaz] PRIMARY KEY CLUSTERED 
(
	[id_samochod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_samochody_do_sprzedania]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_samochody_do_sprzedania]
AS
SELECT        dbo.model.prod_nazwa, dbo.model.model_nazwa, dbo.samochody_na_sprzedaz.cena, dbo.samochody_na_sprzedaz.przebieg, dbo.samochody_na_sprzedaz.data_produkcji, dbo.samochody_na_sprzedaz.ksiazka_serwisowa, 
                         dbo.samochody_na_sprzedaz.pojemnosc, dbo.samochody_na_sprzedaz.paliwo, dbo.typ_nadwozia.nadwozie_typ, dbo.samochody_na_sprzedaz.status, dbo.samochody_na_sprzedaz.id_samochod
FROM            dbo.model LEFT OUTER JOIN
                         dbo.samochody_na_sprzedaz ON dbo.model.id_model = dbo.samochody_na_sprzedaz.id_model LEFT OUTER JOIN
                         dbo.typ_nadwozia ON dbo.samochody_na_sprzedaz.id_nadwozie = dbo.typ_nadwozia.id_nadwozie
WHERE        (dbo.samochody_na_sprzedaz.status = 'W')
GO
/****** Object:  View [dbo].[v_samochody_sprzedane]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_samochody_sprzedane]
AS
SELECT        dbo.model.prod_nazwa, dbo.model.model_nazwa, dbo.samochody_na_sprzedaz.id_model, dbo.samochody_na_sprzedaz.cena, dbo.samochody_na_sprzedaz.przebieg, dbo.samochody_na_sprzedaz.data_produkcji, 
                         dbo.samochody_na_sprzedaz.ksiazka_serwisowa, dbo.samochody_na_sprzedaz.pojemnosc, dbo.samochody_na_sprzedaz.paliwo, dbo.typ_nadwozia.nadwozie_typ, dbo.samochody_na_sprzedaz.id_samochod
FROM            dbo.model INNER JOIN
                         dbo.samochody_na_sprzedaz ON dbo.model.id_model = dbo.samochody_na_sprzedaz.id_model INNER JOIN
                         dbo.typ_nadwozia ON dbo.samochody_na_sprzedaz.id_nadwozie = dbo.typ_nadwozia.id_nadwozie
WHERE        (dbo.samochody_na_sprzedaz.status = 'S')
GO
/****** Object:  Table [dbo].[rezerwacje]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rezerwacje](
	[id_rezerwacji] [int] IDENTITY(1,1) NOT NULL,
	[id_klienta] [int] NOT NULL,
	[id_samochodu] [int] NOT NULL,
	[data_do] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_rezerwacje_klient_samochod]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_rezerwacje_klient_samochod]
AS
SELECT        dbo.klient.imie, dbo.klient.nazwisko, dbo.klient.kontakt, dbo.rezerwacje.id_samochodu, dbo.rezerwacje.id_klienta, dbo.rezerwacje.data_do, dbo.samochody_na_sprzedaz.vin, dbo.samochody_na_sprzedaz.status, 
                         dbo.model.prod_nazwa, dbo.model.model_nazwa
FROM            dbo.klient INNER JOIN
                         dbo.rezerwacje ON dbo.klient.id_klienta = dbo.rezerwacje.id_klienta INNER JOIN
                         dbo.samochody_na_sprzedaz ON dbo.rezerwacje.id_samochodu = dbo.samochody_na_sprzedaz.id_samochod INNER JOIN
                         dbo.model ON dbo.samochody_na_sprzedaz.id_model = dbo.model.id_model
GO
/****** Object:  Table [dbo].[sprzedane]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sprzedane](
	[id_sprzedazy] [int] IDENTITY(1,1) NOT NULL,
	[id_samochod] [int] NOT NULL,
	[id_klient] [int] NOT NULL,
	[cena] [int] NOT NULL,
	[typ_platnosci] [char](1) NOT NULL,
	[data] [date] NOT NULL,
	[status] [char](1) NOT NULL,
	[id_sprzedawcy] [int] NOT NULL,
 CONSTRAINT [PK_sprzedane] PRIMARY KEY CLUSTERED 
(
	[id_sprzedazy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_raport_sprzedaz]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_raport_sprzedaz]
AS
SELECT        dbo.model.prod_nazwa, dbo.model.model_nazwa, dbo.samochody_na_sprzedaz.vin, dbo.sprzedane.cena, dbo.sprzedane.data, dbo.sprzedane.status, dbo.sprzedane.id_sprzedawcy, dbo.sprzedane.typ_platnosci, 
                         dbo.klient.imie, dbo.klient.nazwisko
FROM            dbo.samochody_na_sprzedaz INNER JOIN
                         dbo.sprzedane ON dbo.samochody_na_sprzedaz.id_samochod = dbo.sprzedane.id_samochod INNER JOIN
                         dbo.model ON dbo.samochody_na_sprzedaz.id_model = dbo.model.id_model INNER JOIN
                         dbo.klient ON dbo.sprzedane.id_sprzedawcy = dbo.klient.id_klienta
GO
/****** Object:  View [dbo].[wyniki_sprzedawcy]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[wyniki_sprzedawcy]
AS
SELECT        imie + ' ' + nazwisko AS Sprzedawca, SUM(cena) AS suma_sprzedazy
FROM            dbo.v_raport_sprzedaz
GROUP BY nazwisko, imie
GO
/****** Object:  View [dbo].[v_raport_typu_platnosci]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_raport_typu_platnosci]
AS
SELECT        SUM(cena) AS Suma, typ_platnosci, COUNT(prod_nazwa) AS ilość_sprzedanych_samochodów
FROM            dbo.v_raport_sprzedaz
GROUP BY typ_platnosci
GO
/****** Object:  View [dbo].[v_marki_na_stanie]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_marki_na_stanie]
AS
SELECT        prod_nazwa AS marka, COUNT(*) AS ilość_na_stanie
FROM            dbo.v_samochody_do_sprzedania
GROUP BY prod_nazwa, status
GO
/****** Object:  Table [dbo].[log_table]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_table](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[log_1] [varchar](50) NULL,
	[log_2] [varchar](50) NULL,
	[log_3] [varchar](50) NULL,
	[log_4] [varchar](50) NULL,
	[tabela] [varchar](50) NULL,
	[operacjaA] [varchar](20) NULL,
	[operacjaB] [varchar](20) NULL,
	[czas] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_log_table] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[powiazanie_wyposazenie_samochod]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[powiazanie_wyposazenie_samochod](
	[id_samochod] [int] NOT NULL,
	[id_wyposazenie] [int] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[klient] ON 

INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (1, N'Drew', N'Sidwick', N'dsidwick0@sbwire.com', N'2185024143', N'OTYC7Z0UQw', N'7Kuopc', N'D')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (2, N'Esteban', N'Abraham', N'eabraham1@wsj.com', N'6013127101', N'ia7qh1rwol', N'zPCpXkR', N'D')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (3, N'Blakeley', N'Chinery', N'bchinery2@behance.net', N'9415205375', N'0DGI40ciugx', N'LoFFarZX8kT', N'D')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (4, N'Doralyn', N'Jackson', N'djackson3@businessweek.com', N'5938278713', N'5DlAwRpnD', N'wdKnkYJtlM0F', N'D')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (5, N'Barbara-anne', N'Bushrod', N'bbushrod4@tinyurl.com', N'4089284409', N'cOLynY', N'Fx9Shv', N'D')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (6, N'Thane', N'Wince', N'twince5@upenn.edu', N'2719864227', N'BvIWNO3S6A', N'xji2WWLi', N'D')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (7, N'Dalis', N'Boss', N'dboss6@utexas.edu', N'9338599513', N'I5Mv9caBe', N'nxB0LwUHH', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (8, N'Cornall', N'Carlon', N'ccarlon7@ox.ac.uk', N'5419016710', N'qCRydyTbN', N'fhmPPsGAR9o', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (9, N'Grier', N'Gascoyne', N'ggascoyne8@linkedin.com', N'6738059972', N'GYA40hVjA', N'fOEPMnIW', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (10, N'Alberto', N'Triggle', N'atriggle9@apache.org', N'7663688025', N'fNaFFjwIA', N'TOruyTDqe', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (11, N'Noe', N'More', N'nmorea@g.co', N'7874578645', N'LEb7kYzN', N'Y2OWzdREyb3', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (12, N'Violette', N'Fowley', N'vfowleyb@admin.ch', N'7104757715', N'Wfu8Lg3', N'XnLyPBJEHRB', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (13, N'Luciana', N'Louch', N'llouchc@typepad.com', N'9914435405', N'91EFeUJY', N'zeplON897apk', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (14, N'Sib', N'Renner', N'srennerd@multiply.com', N'4568444217', N'YJXI1Ip', N'DBaplk6', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (15, N'Elmore', N'Dougherty', N'edoughertye@fda.gov', N'3371109001', N'cc3nVh', N'2K7gbOt', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (16, N'Adolpho', N'Colleer', N'acolleerf@bloomberg.com', N'9646583469', N'RaNjCQ', N'l19yk7cRXi', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (17, N'Gilbert', N'Joice', N'gjoiceg@quantcast.com', N'4489604831', N'd803ZcK5A2y', N'DQstZhIk3Tp', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (18, N'Jonathon', N'Eldridge', N'jeldridgeh@themeforest.net', N'6076122647', N't9EjvEYK', N'5OEQnMiG', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (19, N'Carolus', N'Arnholtz', N'carnholtzi@qq.com', N'4176711616', N'cowSbU', N'yhHBpg6', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (20, N'Mead', N'Quade', N'mquadej@netvibes.com', N'9299539986', N'h9QRqd5AgtT', N'IWw3nPgw', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (21, N'Cookie', N'McShane', N'cmcshanek@blogspot.com', N'7427118281', N'4wiUWW', N'bCrhfY', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (22, N'Catherine', N'Slater', N'cslaterl@w3.org', N'2076748597', N'bgBfsp7q8', N'pQ7hvCc8ts', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (23, N'Normie', N'Sandells', N'nsandellsm@disqus.com', N'3804483919', N'ZE91AQ', N'pfPX3u', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (24, N'Odele', N'Twycross', N'otwycrossn@theatlantic.com', N'4964013447', N'syFIDE8WkSZo', N'rpdZFM2Mi', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (25, N'Isiahi', N'Pizzey', N'ipizzeyo@princeton.edu', N'4025398435', N'5N5csfaE0', N'uIqYR4QSs', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (26, N'Doe', N'Stiegars', N'dstiegarsp@cbc.ca', N'1858875640', N'PFNRcrE93gYx', N'kD2v3Fc', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (27, N'Darrel', N'Barabisch', N'dbarabischq@trellian.com', N'1973325868', N'hr9QywbB0u', N'QwyWOCkhkYbx', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (28, N'Wilton', N'Bridewell', N'wbridewellr@nydailynews.com', N'3528833665', N'5W7ToSSsQU2Y', N'Eh3GoAev', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (29, N'Esta', N'Gallant', N'egallants@foxnews.com', N'9564540442', N'vPafA207NLc', N'iR9pHkzf2', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (30, N'Julieta', N'Cud', N'jcudt@jigsy.com', N'8397252152', N'7hKnY9', N'sxrAkkwjnz', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (31, N'Hurley', N'Warrick', N'hwarricku@latimes.com', N'1622597835', N'SciQNWyV', N'efUFwtFLk', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (32, N'Karrie', N'Profit', N'kprofitv@noaa.gov', N'3693754299', N'4n9uOABDyYt', N'r9R2HqjOoH', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (33, N'Gerek', N'Djekic', N'gdjekicw@theatlantic.com', N'7041229265', N'BeDk88PG', N'HL5Xe12', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (34, N'Stillmann', N'Schiell', N'sschiellx@yelp.com', N'9089001332', N'sWjHRxg', N'J9TnzF4', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (35, N'Barby', N'Fronek', N'bfroneky@ovh.net', N'5884596546', N'QSRHGLx', N'PBcHfvIcyGf', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (36, N'Atlante', N'Heditch', N'aheditchz@google.co.jp', N'9278104309', N'bSl2FeiLY', N'LAQ1QziJB', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (37, N'Suzi', N'Camus', N'scamus10@delicious.com', N'5175731043', N'wfJLfDdx', N'72IMna', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (38, N'Bentley', N'McKerley', N'bmckerley11@wired.com', N'5338102425', N'qHYT9t22aDYs', N'nCXpxx0sW', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (39, N'Putnam', N'Toogood', N'ptoogood12@dedecms.com', N'7226066254', N'yhkgPGwx', N'sqGx9s8TxG', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (40, N'Sharai', N'Meo', N'smeo13@pen.io', N'2487638273', N'BLxKMC', N'SKMJtTP5', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (41, N'Matthaeus', N'Snow', N'msnow14@csmonitor.com', N'7192385505', N'sGtYABlNRo52', N'LLcLs3pK83', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (42, N'Honey', N'Shannon', N'hshannon15@dot.gov', N'9316735792', N'xV98z4r', N'nuw3qn7rzD', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (43, N'Simmonds', N'Limpenny', N'slimpenny16@youtu.be', N'2765079472', N'w60TpiJ6', N'GN5HzR0LF', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (44, N'Jdavie', N'Gair', N'jgair17@pcworld.com', N'6536472276', N'r3xJEdabs', N'JNYB75bc', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (45, N'Martica', N'Knevit', N'mknevit18@odnoklassniki.ru', N'9351963385', N'SzcPPtOL', N'ZbPjRGkXOnmH', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (46, N'Jerrylee', N'Beringer', N'jberinger19@gov.uk', N'8524158967', N'GIDHISD', N'sedDv7', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (47, N'Franklyn', N'Minghella', N'fminghella1a@prnewswire.com', N'2546634275', N'14NUYQY', N'CTVmV9zu7b', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (48, N'Isidore', N'Janaway', N'ijanaway1b@wikipedia.org', N'3849495916', N'3sAEUQ2', N'3UlZ9kn', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (49, N'Camala', N'Gravenell', N'cgravenell1c@infoseek.co.jp', N'4635970065', N'CW0LRP7or2', N'Og3f9Q2x', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (50, N'Peggie', N'Beauly', N'pbeauly1d@digg.com', N'6051255864', N'k8DOTXAA9s', N'3LZRcNcTjKEG', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (51, N'Cynthia', N'Eager', N'ceager1e@1688.com', N'5708989081', N'pjLats7r10Uk', N'JUiDm0vn', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (52, N'Brennen', N'Eastup', N'beastup1f@blogspot.com', N'7774784614', N'yXz3gRBg1YzG', N'mnZ5Od', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (53, N'Atlante', N'Spilsburie', N'aspilsburie1g@google.co.uk', N'2393046889', N'xCQQIy', N'qn5y2wKT7', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (54, N'Gunter', N'Sibyllina', N'gsibyllina1h@springer.com', N'7509366422', N'6h8mQG3Lw', N'uMbDookI', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (55, N'Glory', N'Buxsy', N'gbuxsy1i@hud.gov', N'8711075015', N'p8BXSvefYCbx', N'iTGwLMzzs1dM', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (56, N'Timi', N'Heino', N'theino1j@uiuc.edu', N'1836334799', N'SaZnNgOdTo0', N'TCbESaEq', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (57, N'Isahella', N'Tinghill', N'itinghill1k@statcounter.com', N'2407474555', N'HUTlMJ', N'TaxgAAbqDQv', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (58, N'Fran', N'De Santos', N'fdesantos1l@go.com', N'2106701647', N'Xp2IVIFehaP', N'0ChWPWD', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (59, N'Daniele', N'de''-Ancy Willis', N'ddeancywillis1m@de.vu', N'2089714566', N'MqbQBD0', N'xpAZkd', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (60, N'Betty', N'Cushworth', N'bcushworth1n@hao123.com', N'1999152794', N'FNRjGxxtM', N'h8uy9rWtla', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (61, N'Edee', N'Barthelemy', N'ebarthelemy1o@microsoft.com', N'3336587176', N'ltdl2f', N'tZRKnPeNX', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (62, N'Shadow', N'Struthers', N'sstruthers1p@deviantart.com', N'8391801933', N'tqUP6cJj0d', N'5oFJtXwK', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (63, N'Emili', N'Heinrici', N'eheinrici1q@fema.gov', N'7727750946', N'81O5Ihwa5', N'DEz09TUB38Iq', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (64, N'Peggie', N'Brodley', N'pbrodley1r@uiuc.edu', N'3093247901', N'E6LiG8', N'yVpXcx', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (65, N'Burg', N'Cabrales', N'bcabrales1s@microsoft.com', N'9578412669', N'stwJDiY9C7Y', N'BQYOQuFCRP8T', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (66, N'Bonita', N'Obeney', N'bobeney1t@wikipedia.org', N'2164150583', N'FjXCk9', N'rseRX3aNVy4', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (67, N'Jacquetta', N'McCartney', N'jmccartney1u@seattletimes.com', N'7309127085', N'wqL7iuDCC', N'ytqpMRfc', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (68, N'Aurthur', N'Salzburger', N'asalzburger1v@constantcontact.com', N'1266674301', N'vmS0qL9s', N'dGqobbJozER', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (69, N'Sallyanne', N'Lidgate', N'slidgate1w@pen.io', N'3809877287', N'rTYb009Ds', N'dkgNjmMDv8Ks', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (70, N'Tirrell', N'Law', N'tlaw1x@bigcartel.com', N'9437273597', N'L8bG9tAq', N'9U781Cg3ZvB', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (71, N'Petr', N'Collop', N'pcollop1y@nyu.edu', N'7861243009', N'H7P3wQY', N'N2i5GhRJ3tps', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (72, N'Mirna', N'Bould', N'mbould1z@cloudflare.com', N'8033892971', N'YigOuuo4Hi', N'yiAqoYOj', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (73, N'Kathie', N'Thorbon', N'kthorbon20@comcast.net', N'1031778894', N'hlCfGx', N'kPjvY7FUyk', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (74, N'Raina', N'McMinn', N'rmcminn21@google.co.uk', N'6663238863', N'0Tkl4MR', N'4MfUd8vQ8', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (75, N'Ashlin', N'Rennie', N'arennie22@parallels.com', N'1656097430', N'JFJKnjRpVD', N'PGvzaCcfC', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (76, N'Laurene', N'Brankley', N'lbrankley23@cyberchimps.com', N'5477468051', N'Yb8iBKiWJ0M', N'NGcPjmBkMbY', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (77, N'Wilfred', N'Shillinglaw', N'wshillinglaw24@indiatimes.com', N'1964176930', N'vKVuY1LVR', N'NF5aOp', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (78, N'Cyb', N'Escritt', N'cescritt25@blinklist.com', N'2817334603', N'Rxsbitnh5', N'ZMgORo', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (79, N'Dawna', N'McAleese', N'dmcaleese26@merriam-webster.com', N'6436780331', N'J8ajo4ljM', N'md9AbkAzEz', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (80, N'Lena', N'Kubes', N'lkubes27@go.com', N'2894396214', N'PC6T49qz', N'Pk49Qh5vwj', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (81, N'Sherilyn', N'Revill', N'srevill28@edublogs.org', N'2624914086', N'Lir9WDZ', N'KBADOapO2', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (82, N'Kassia', N'Rupert', N'krupert29@craigslist.org', N'9312653112', N'KCr5R4Nuw2i', N'gcEfR4QN', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (83, N'Rurik', N'Sargent', N'rsargent2a@usda.gov', N'3797117730', N'cT7luNJ', N'xUiiGg0jG', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (84, N'Bessy', N'Priestland', N'bpriestland2b@apache.org', N'7166756619', N'lB5VT8', N'JJHXv3WP5', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (85, N'Mendy', N'Jepp', N'mjepp2c@mac.com', N'3617106700', N'ds24AXNs', N'vhEVKT2TTj9d', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (86, N'Carlynn', N'Rieme', N'crieme2d@printfriendly.com', N'5531791169', N'byHZ08O', N'u3tgOSMNhCfs', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (87, N'Emilee', N'Telfer', N'etelfer2e@webnode.com', N'7983761973', N'0PgiELTVWtx', N'rOPvD4U', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (88, N'Tuesday', N'Snowling', N'tsnowling2f@qq.com', N'9306494104', N'K4Wclq8Igjz', N'Ur0EswAMuM', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (89, N'Maighdiln', N'Dransfield', N'mdransfield2g@boston.com', N'6145171306', N'P48bR3TPj8V', N'EOz1uXeGvpGy', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (90, N'Felicle', N'Larking', N'flarking2h@bravesites.com', N'3589675708', N'AVpeEYYQVXQ', N'3STjN6fN', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (91, N'Nikkie', N'Luthwood', N'nluthwood2i@flavors.me', N'3516884896', N'CDT0TJ0CBb', N'heTHFKc', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (92, N'Obed', N'McTurk', N'omcturk2j@360.cn', N'6788572740', N'WAnGLy', N'n37zJITu', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (93, N'Gael', N'Tottman', N'gtottman2k@pen.io', N'8439275059', N'FJMvzjlCFgd', N'TThaFBcFBM8', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (94, N'Juliet', N'Yearsley', N'jyearsley2l@homestead.com', N'8884916934', N'ANKOzzmVnR0J', N'k6fhiL2', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (95, N'Florence', N'Shoulders', N'fshoulders2m@cisco.com', N'7992391013', N'Jnx5bLmb', N'8YOPA0YK', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (96, N'Merrily', N'Momford', N'mmomford2n@tinypic.com', N'3644395828', N'SEMk2pK4rE', N'Rqn0652', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (97, N'Cecilia', N'Klemt', N'cklemt2o@comcast.net', N'4213844190', N'qobtAxgVb', N'duZ75Jw', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (98, N'Minette', N'Speers', N'mspeers2p@comsenz.com', N'3818532437', N'6UinZ0bjfQ2', N'K9itLyZP', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (99, N'Cassondra', N'Reavell', N'creavell2q@mozilla.org', N'7466110075', N'EaP0zow', N'DxSBkmbi', N'S')
GO
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (100, N'Creigh', N'Hedditeh', N'chedditeh2r@wikimedia.org', N'3081903645', N'TeIxKKcKLS', N'2G3XRHlHGT', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (101, N'Fidela', N'Patrono', N'fpatrono2s@usgs.gov', N'1232343462', N'1mdETLQdVCuX', N'p80TDn', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (102, N'Abeu', N'Howe', N'ahowe2t@cafepress.com', N'4834073132', N'B6JzcQ', N'ZhEjbZeMYB', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (103, N'Delora', N'Ounsworth', N'dounsworth2u@zdnet.com', N'4098990398', N'YLHQVr7kxBRp', N'b56j2UK', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (104, N'Rickert', N'Willingam', N'rwillingam2v@gmpg.org', N'5017028811', N'NA56t0', N'UTsuHpr', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (105, N'Kinnie', N'Harriot', N'kharriot2w@posterous.com', N'4826203234', N'BCtK1v2u', N'J04hS9YahSF', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (106, N'Coretta', N'Giamelli', N'cgiamelli2x@seesaa.net', N'5437543000', N'8pXaVnrAM', N'8pixNfC', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (107, N'Rolfe', N'Neiland', N'rneiland2y@salon.com', N'4392351307', N'x8VhqwxMof', N'kmu984', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (108, N'Trace', N'Spoor', N'tspoor2z@wp.com', N'3174468976', N'oEsdZ3w6I9Au', N'OrkxNR', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (109, N'Lester', N'Cantos', N'lcantos30@dion.ne.jp', N'9543501218', N'w5AiRHZX', N'gHt56v2', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (110, N'Renie', N'Nerne', N'rnerne31@home.pl', N'2914585491', N'ONX6cx', N'OTjQHdmYG3', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (111, N'Annabal', N'Vickarman', N'avickarman32@irs.gov', N'9337035580', N'mdjGe3', N'cZ0Kt298Y02w', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (112, N'Benedict', N'Cord', N'bcord33@dot.gov', N'4314005569', N'A36dgDx', N'KQJMfBkAKLR7', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (113, N'Jan', N'Raikes', N'jraikes34@salon.com', N'2271013775', N'sxgGwmyNT', N'yaefoCa', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (114, N'Quinn', N'Songust', N'qsongust35@ed.gov', N'7286174377', N'18qERXFfMMfz', N'9M7NRMw', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (115, N'Robenia', N'Johansen', N'rjohansen36@aol.com', N'3281489018', N'ghc6xg3Zf', N'0WoAKm9iE0', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (116, N'Faye', N'Di Nisco', N'fdinisco37@g.co', N'9166103807', N'RyH7NdR', N'GNtpfS5eQ', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (117, N'Corilla', N'Mangion', N'cmangion38@wikia.com', N'6976325720', N'aBfC6xXj', N'bYtWPtEjqYpq', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (118, N'Husein', N'Attree', N'hattree39@bbb.org', N'1601680910', N'MVc62tUMRBCu', N'Nc8ebvAS', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (119, N'Cecilius', N'Dance', N'cdance3a@google.com.au', N'9879383999', N'MkXUXF0aH1', N'zagqiz', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (120, N'Felicdad', N'Peeke', N'fpeeke3b@weibo.com', N'2081337780', N'nYApSCBj', N'ir4UEHwxmDC', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (121, N'Catharina', N'De Metz', N'cdemetz3c@jalbum.net', N'5394355244', N'BWOz5B65JsR', N'WbKDe4U3AuQ0', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (122, N'Henrie', N'Rostern', N'hrostern3d@symantec.com', N'3666775266', N'8hiho64', N'WiXn8suz', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (123, N'Gloria', N'Whickman', N'gwhickman3e@geocities.com', N'5548541189', N'K0IIVno7mYfh', N'kQRWgeEgnc', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (124, N'Renell', N'Brighouse', N'rbrighouse3f@flavors.me', N'6767294515', N'ExH4jGXCc', N'othpzn', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (125, N'Maegan', N'Siggin', N'msiggin3g@joomla.org', N'1471815895', N'Z84crsBpey', N'jSyd9J', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (126, N'Tamiko', N'Caress', N'tcaress3h@altervista.org', N'6447408070', N'7XkWLKb00d', N'AVGsOOqunGB', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (127, N'Allyson', N'Channing', N'achanning3i@fc2.com', N'5175802502', N'u2wyu0a', N'Vz2XNvLnP', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (128, N'Kandace', N'Shale', N'kshale3j@goo.ne.jp', N'6009077812', N'VIBvCYLmhrI', N'Gje8jDQffw', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (129, N'Griffin', N'Glavin', N'gglavin3k@shareasale.com', N'8922203213', N'KuME8FwEMQwG', N'kJO3R36ijY', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (130, N'Efren', N'Scramage', N'escramage3l@sciencedaily.com', N'7459974299', N'EzF820WX', N'oAK7ppYVkWZ', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (131, N'Taite', N'Abramsky', N'tabramsky3m@deliciousdays.com', N'9489411006', N'f0fsKS9q2F0', N'JNOfUt1Gn69', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (132, N'Arnie', N'Oseland', N'aoseland3n@fotki.com', N'9104376485', N'M60CAg3Woc', N'O5Yi691nS', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (133, N'Simone', N'Leatt', N'sleatt3o@canalblog.com', N'8965794824', N'tdcCfH', N'ZELtk5yH', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (134, N'Velma', N'Carruth', N'vcarruth3p@icio.us', N'4247059986', N'wdwhaB', N'Zk0bURoh1gX', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (135, N'Dacy', N'Kosel', N'dkosel3q@skyrock.com', N'8587440866', N'y0HjChWSZj', N'PlOLbqWB', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (136, N'Bonnie', N'Caddy', N'bcaddy3r@xinhuanet.com', N'9823309662', N'Tb3UDvh', N'rsdCSEpxmZ', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (137, N'Cheslie', N'Hallihan', N'challihan3s@google.com.au', N'3762379054', N'pqeAOWLkBDn4', N'RHbMOXVJyN', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (138, N'Myer', N'Beddoe', N'mbeddoe3t@hibu.com', N'5432104896', N'0vJepgmKg0O', N'fSAtxTZKuxpj', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (139, N'Theodore', N'Nuss', N'tnuss3u@devhub.com', N'5185256804', N'XTewyN6', N'H4LGgZymqyT4', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (140, N'Loria', N'Kehri', N'lkehri3v@craigslist.org', N'6906798401', N'MSMMs4Nm4TM', N'5FnH8NI', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (141, N'Katha', N'Bilovus', N'kbilovus3w@artisteer.com', N'9077855145', N'yvJvgVVEBL', N'hdAY1f7T43F', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (142, N'Viva', N'Larne', N'vlarne3x@pen.io', N'6633625213', N'4GpOJ5pf', N'BW8B7P', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (143, N'Germaine', N'Humberston', N'ghumberston3y@gnu.org', N'4259166792', N'xpYlQ0sXxOW', N'7Cnh8AQls0r', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (144, N'Marge', N'Knottley', N'mknottley3z@spiegel.de', N'2336799383', N'vztv2SH4s2', N'm2jk9vj', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (145, N'Timothy', N'Hugonneau', N'thugonneau40@pbs.org', N'6091577609', N'K9gjJSLKlBo', N'5eY5maA', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (146, N'Alden', N'Cordero', N'acordero41@sciencedirect.com', N'1858966463', N'xARhSP', N'6K9ZhW0', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (147, N'Fredericka', N'Goodsal', N'fgoodsal42@people.com.cn', N'9285189197', N'K8FiQUaIt1r8', N'ibhNh5wC1O', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (148, N'Cullin', N'Faivre', N'cfaivre43@nytimes.com', N'4564507832', N'4TRyxl0SoC2', N'baH24xz', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (149, N'Bili', N'Gulley', N'bgulley44@cdbaby.com', N'7722580663', N'RL2Ctjtz', N'gsI5XFBL', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (150, N'Doe', N'Vasentsov', N'dvasentsov45@sourceforge.net', N'7819774030', N'4khP5zxfz', N'Hkb4CaPzMY', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (151, N'Carin', N'Mahon', N'cmahon46@webeden.co.uk', N'8878532617', N'UoFhyRvvAH', N'z0Y3VUXB7Hc', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (152, N'Brose', N'Emanuele', N'bemanuele47@ca.gov', N'3154616238', N'WgvcNGK1c9wM', N'YvGa44', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (153, N'Paige', N'Siege', N'psiege48@berkeley.edu', N'2784606760', N'93ppNXiE', N'accIDwzRtq', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (154, N'Kim', N'Clemoes', N'kclemoes49@globo.com', N'7969064870', N'ibZoHyoAPIBo', N'iQ4g7YQav9', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (155, N'Cynthia', N'Baert', N'cbaert4a@kickstarter.com', N'8397298502', N'jYfJQQr7NhV', N'tDygGslQVM6i', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (156, N'Meg', N'Bengall', N'mbengall4b@elpais.com', N'4644018420', N'IEU0O2', N'OQCoHietpG9', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (157, N'Kaia', N'Kernaghan', N'kkernaghan4c@squidoo.com', N'9383067043', N'r6ACicJb0AF', N'8MalEfFw9UP', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (158, N'Eunice', N'Neiland', N'eneiland4d@cnet.com', N'5486059811', N'HLiReoeDD2S', N'A28wfV8k4U3W', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (159, N'Tyrone', N'Coveney', N'tcoveney4e@rakuten.co.jp', N'4337375713', N'A62xjET', N'sqZmDOx6uRX', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (160, N'Bernardina', N'Spratt', N'bspratt4f@devhub.com', N'9112501674', N'rwZgb78hQ', N'yY6GVBsnp8', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (161, N'Wilmer', N'Luipold', N'wluipold4g@yellowbook.com', N'6472701841', N'1LifVQxPnXJ', N'My11zCairg9', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (162, N'Anderea', N'Reid', N'areid4h@google.it', N'4966693321', N'02nMj9OdpN', N'Kcrcr6PNPC', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (163, N'Katlin', N'Van Oort', N'kvanoort4i@nytimes.com', N'4854366436', N'ocJOX2', N'Aw1k4t6isY', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (164, N'Karena', N'Van der Baaren', N'kvanderbaaren4j@goo.gl', N'9309853881', N'9Tbo2LJs936I', N'WiMNuwrz2P', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (165, N'Nevsa', N'Sutherby', N'nsutherby4k@aol.com', N'3794805069', N'AivMcO5pe98l', N'1y8bhSbzKeAE', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (166, N'Beckie', N'Gillean', N'bgillean4l@linkedin.com', N'6425797772', N'Xr5tjGFK2', N'JkTchMryvM', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (167, N'Odele', N'Castanie', N'ocastanie4m@mayoclinic.com', N'1339060450', N'keYiAm8t', N'qSJgf88', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (168, N'Cthrine', N'Henken', N'chenken4n@ycombinator.com', N'7223681663', N't9p30Ze', N'XmRdNtk64uXR', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (169, N'Chrissy', N'Schott', N'cschott4o@zdnet.com', N'5875365766', N'zyRiVxguX2q', N'W0DDds8jV22', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (170, N'Niall', N'MacAne', N'nmacane4p@soup.io', N'9105342892', N'k98QoJil', N'Q7pM7W7j6', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (171, N'Duncan', N'Ghidotti', N'dghidotti4q@google.ca', N'2918719659', N'Suzaok', N'z9btaS', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (172, N'Deck', N'Stickells', N'dstickells4r@fda.gov', N'6064879217', N'UTAww3eJY3nq', N'qBTJxiZH4b', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (173, N'Ravid', N'Lawdham', N'rlawdham4s@topsy.com', N'4658324872', N'EHdfQM9', N'2e8GZ1', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (174, N'Carrol', N'Dowry', N'cdowry4t@sciencedaily.com', N'5443233587', N'FVRDYSi4Q', N'nzZTD2U8ZPXS', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (175, N'Russ', N'Kinforth', N'rkinforth4u@google.de', N'2634478583', N'rTp3wA98', N'a2L4YbeeIpCW', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (176, N'Raynell', N'Arnatt', N'rarnatt4v@cloudflare.com', N'9582502121', N'1goEyBSI', N'dS0h2lPexB', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (177, N'Ailene', N'Wysome', N'awysome4w@tiny.cc', N'6801938100', N'tOb9SqGu', N'tqw68Kut', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (178, N'Bridget', N'Philimore', N'bphilimore4x@freewebs.com', N'8194319485', N'Ky9dY3cLE', N'Ob6Z0YgJir', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (179, N'Audi', N'Folling', N'afolling4y@blogs.com', N'9438063551', N'vlZTGOW34', N'pTqZ0FYAQNZ', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (180, N'Hugh', N'Ranklin', N'hranklin4z@apache.org', N'7452981617', N'8P6QJg', N'qUd8vI8x', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (181, N'Laurie', N'Scatcher', N'lscatcher50@twitpic.com', N'2181724188', N'heSOw3UrVM', N'VwPr6EgqPl', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (182, N'Kiel', N'Topliss', N'ktopliss51@google.it', N'2499148731', N'eYoF0orXkxLi', N'VfkkAhCPmBU', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (183, N'Madalena', N'Taleworth', N'mtaleworth52@blogs.com', N'7072289358', N'9U3aXF', N'17MfobOdvv', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (184, N'Kessia', N'Ventura', N'kventura53@bloglovin.com', N'2035544631', N'Ioo694HB1kG', N'zLQ6Ko', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (185, N'Elise', N'Fellnee', N'efellnee54@patch.com', N'4224351617', N'tWk6zmf1Q3AH', N'Aka4SJlM3VR', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (186, N'Wendi', N'Dartan', N'wdartan55@netlog.com', N'5786274165', N'5pKPOZag8I', N'ZB2tAhS', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (187, N'Miriam', N'Keyzman', N'mkeyzman56@google.nl', N'4813059339', N'uiuzouAldAGM', N'YGkS4QObX1Vi', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (188, N'Meryl', N'Pasterfield', N'mpasterfield57@creativecommons.org', N'5223203282', N'kQ5dxnzyzkNp', N'SvhVlkE', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (189, N'Elise', N'Dockray', N'edockray58@scientificamerican.com', N'2807795824', N'JlHUv55zr', N'pJcg94xFOotf', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (190, N'Vassili', N'Suero', N'vsuero59@addtoany.com', N'6986355457', N'4s1aXvG', N'1ZjD7BU', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (191, N'Erek', N'Ivchenko', N'eivchenko5a@yahoo.com', N'3071110765', N'MtfI5qTFMTu', N'gCcZDjK', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (192, N'Karola', N'Bartolomucci', N'kbartolomucci5b@spiegel.de', N'3554374679', N'MmCW9Ggj', N'FyVvJkay', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (193, N'Quinn', N'Kilpatrick', N'qkilpatrick5c@flavors.me', N'3774329555', N'vO4gvKN', N'jec4bYqK3', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (194, N'Lilyan', N'Waddilow', N'lwaddilow5d@is.gd', N'4019794025', N'SXEytcnZIzIL', N'Y7p43o5I', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (195, N'Siward', N'Gallahue', N'sgallahue5e@redcross.org', N'4993875214', N'dP5ikdA0x', N'K0jwDIVpI3d', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (196, N'Artie', N'Hibbart', N'ahibbart5f@ucoz.com', N'1993414679', N'g6j1oiwFNa', N'IzrP1piyC0', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (197, N'Cordell', N'Andrewartha', N'candrewartha5g@state.gov', N'1668906219', N'zfXpigE', N'NYvwOJ7D8RXh', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (198, N'Dario', N'Lumm', N'dlumm5h@jiathis.com', N'1224525180', N'xxTeDXZY1ez', N'1bV70Z2Io4', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (199, N'Mommy', N'Steel', N'msteel5i@arstechnica.com', N'7541776674', N'lSgyTNg3TUzW', N'h0U4aDNc1m', N'S')
GO
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (200, N'Daven', N'Waite', N'dwaite5j@ft.com', N'8523141648', N'TY97nJ', N'dnjU3lgxuX2', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (201, N'Adam', N'Kowalski', NULL, N'666666666', N'admin', N'haslo', N'A')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (202, N'Pawel', N'adamek', N'adamek@wp.pl', N'123432345', N'q8fU;@j', N'2MddOTD', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (207, N'adam', N'kos', N'kosam@wq.pl', N'123456789', N'>NV4cOj', N':xGO_5b', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (208, N'waclaw', N'pętelka', N'wq@ww.pl', N'123456789', N'<lEJhf5', N'l][w?7z', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (212, N'marcin', N'sas', N'we@wq.pl', N'12345654', N'Z37dW^\', N'oMC<Dff', N'S')
INSERT [dbo].[klient] ([id_klienta], [imie], [nazwisko], [email], [kontakt], [login], [haslo], [typ]) VALUES (215, N'marcinek', N'sasek', N'wwe@wq.pl', N'12345654', N'aWEnYZ=', N'frtozg`', N'S')
SET IDENTITY_INSERT [dbo].[klient] OFF
SET IDENTITY_INSERT [dbo].[klient_dane] ON 

INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (71, 7, N'85 Merchant Lane', NULL, N'Campamento', N'Honduras', NULL, N'tristique in')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (72, 9, N'5179 Victoria Drive', NULL, N'Fushun', N'China', NULL, N'eget eros')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (73, 11, N'6938 Dawn Lane', NULL, N'Dahongmen', N'China', NULL, N'facilisi cras non')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (74, 13, N'0285 Esker Circle', NULL, N'Chernigovka', N'Russia', N'692385', N'orci mauris lacinia')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (75, 15, N'80665 Paget Junction', NULL, N'Igarapé', N'Brazil', N'32900-000', N'cursus urna')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (76, 17, N'539 Pepper Wood Circle', NULL, N'Pomahan', N'Indonesia', NULL, N'porttitor id consequat in')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (77, 19, N'27890 Anzinger Street', NULL, N'Sabana Grande de Palenque', N'Dominican Republic', N'11704', N'sapien non mi')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (78, 21, N'0580 Raven Plaza', NULL, N'Huilong', N'China', NULL, N'vestibulum eget vulputate ut')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (79, 23, N'53546 Eastwood Drive', NULL, N'Riolândia', N'Brazil', N'15495-000', N'faucibus orci')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (80, 25, N'77419 Fuller Place', NULL, N'Şurman', N'Libya', NULL, N'semper porta volutpat')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (81, 27, N'87 Welch Terrace', NULL, N'Potet', N'Indonesia', NULL, N'venenatis lacinia aenean')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (82, 29, N'489 Starling Point', NULL, N'Osoyoos', N'Canada', N'N9V', N'malesuada in imperdiet')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (83, 31, N'03255 Fisk Point', NULL, N'Sevilla', N'Colombia', N'762538', N'vehicula condimentum curabitur in')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (84, 33, N'82 Brentwood Alley', NULL, N'Black River', N'Jamaica', NULL, N'aliquam sit amet')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (85, 35, N'7775 Fairview Avenue', NULL, N'Nova Iguaçu', N'Brazil', N'26000-000', N'vehicula consequat morbi')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (86, 37, N'0074 Brickson Park Crossing', NULL, N'La Reforma', N'Guatemala', N'12021', N'vel augue vestibulum')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (87, 39, N'85 Susan Road', NULL, N'San Lorenzo', N'Argentina', N'2200', N'purus aliquet at feugiat')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (88, 41, N'67117 Corry Court', NULL, N'Xinpu', N'China', NULL, N'suspendisse potenti in eleifend')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (89, 43, N'3 Oxford Alley', NULL, N'Xianghu', N'China', NULL, N'ultrices posuere cubilia curae')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (90, 45, N'8978 Cherokee Drive', NULL, N'Wuyun', N'China', NULL, N'morbi a')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (91, 47, N'5869 Talisman Lane', NULL, N'Colonia Aurora', N'Argentina', N'3363', N'lacus morbi')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (92, 49, N'26 Tennyson Park', NULL, N'Chapultepec', N'Mexico', N'25050', N'sapien varius ut blandit')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (93, 51, N'6895 Truax Street', NULL, N'Barueri', N'Brazil', N'06400-000', N'ante ipsum primis in')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (94, 53, N'036 Anhalt Drive', NULL, N'Tsibulev', N'Ukraine', NULL, N'tellus nisi eu')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (95, 55, N'7 Oakridge Parkway', NULL, N'El Tejocote', N'Mexico', N'50625', N'ut mauris eget')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (96, 57, N'20 Butterfield Crossing', NULL, N'Cértegui', N'Colombia', N'272027', N'eu est')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (97, 59, N'7 Memorial Crossing', NULL, N'Chicago', N'United States', N'60663', N'nisl ut volutpat')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (98, 61, N'710 American Ash Parkway', NULL, N'Yuanshanzi', N'China', NULL, N'nulla ultrices aliquet maecenas')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (99, 63, N'2 Fieldstone Point', NULL, N'Berendeyevo', N'Russia', N'152000', N'nibh in lectus')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (100, 65, N'99723 Kingsford Way', NULL, N'El Retén', N'Colombia', N'478067', N'eleifend pede libero')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (101, 67, N'68 Merry Plaza', NULL, N'Asarum', N'Sweden', N'374 53', N'potenti in eleifend')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (102, 69, N'85 Birchwood Trail', NULL, N'Iset’', N'Russia', N'624082', N'semper interdum')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (103, 71, N'9070 Norway Maple Center', NULL, N'Agen', N'France', N'47912 CEDEX 9', N'sapien non mi integer')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (104, 73, N'8 Hoard Trail', NULL, N'Fukuoka-shi', N'Japan', N'816-0097', N'ac consequat metus sapien')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (105, 75, N'303 Manufacturers Pass', NULL, N'Radomir', N'Bulgaria', N'2453', N'morbi porttitor')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (106, 77, N'3819 Algoma Lane', NULL, N'Lamía', N'Greece', NULL, N'nulla suspendisse potenti')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (107, 79, N'9935 Cody Pass', NULL, N'Tanzhesi', N'China', NULL, N'suspendisse ornare')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (108, 81, N'03 Sheridan Crossing', NULL, N'Mbanga', N'Cameroon', NULL, N'aliquet pulvinar')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (109, 83, N'46323 Service Point', NULL, N'Ksawerów', N'Poland', N'95-054', N'nascetur ridiculus mus etiam')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (110, 85, N'315 Independence Lane', NULL, N'Várzea da Palma', N'Brazil', N'39260-000', N'mauris eget massa tempor')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (111, 87, N'90 Anniversary Pass', NULL, N'Saltsjöbaden', N'Sweden', N'133 34', N'nisl ut volutpat')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (112, 89, N'5911 Hallows Alley', NULL, N'Cuihuangkou', N'China', NULL, N'ultrices enim lorem ipsum')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (113, 91, N'03372 South Trail', NULL, N'Gaotian', N'China', NULL, N'augue vel accumsan')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (114, 93, N'6 Green Center', NULL, N'Puerres', N'Colombia', N'523548', N'nisi eu orci mauris')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (115, 95, N'94 Spohn Plaza', NULL, N'Bayt Wazan', N'Palestinian Territory', NULL, N'in congue etiam')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (116, 97, N'35362 Mitchell Point', NULL, N'Tsushima', N'Japan', N'979-1757', N'tincidunt ante')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (117, 99, N'2 Fordem Hill', NULL, N'Gualaceo', N'Ecuador', NULL, N'quisque erat eros viverra')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (118, 101, N'6 David Avenue', NULL, N'Rabah', N'Nigeria', NULL, N'dolor morbi vel')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (119, 103, N'03231 Bowman Point', NULL, N'Conceiçao da Barra', N'Brazil', N'29960-000', N'pellentesque volutpat dui maecenas')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (120, 105, N'0 8th Point', NULL, N'Jonkowo', N'Poland', N'11-042', N'morbi a')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (121, 107, N'8045 Washington Circle', NULL, N'Xiluo', N'China', NULL, N'et magnis dis')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (122, 109, N'8 Melrose Parkway', NULL, N'Negararatu', N'Indonesia', NULL, N'nulla nisl nunc')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (123, 111, N'68 Maryland Point', NULL, N'Krueng Luak', N'Indonesia', NULL, N'justo in hac habitasse')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (124, 113, N'6785 Blaine Junction', NULL, N'Paicol', N'Colombia', N'415047', N'quis libero')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (125, 115, N'38 Esker Lane', NULL, N'Kotabesi', N'Indonesia', NULL, N'nibh ligula')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (126, 117, N'15 Almo Terrace', NULL, N'Conceiçao do Jacuípe', N'Brazil', N'44245-000', N'vitae nisl aenean lectus')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (127, 119, N'4011 Village Green Point', NULL, N'Gurra e Vogël', N'Albania', NULL, N'vivamus tortor')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (128, 121, N'55 Fulton Avenue', NULL, N'Vřesina', N'Czech Republic', N'747 20', N'faucibus orci luctus')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (129, 123, N'6555 Mosinee Junction', NULL, N'Ketian', N'China', NULL, N'sit amet justo morbi')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (130, 125, N'1175 Northport Crossing', NULL, N'Rustaq', N'Afghanistan', NULL, N'faucibus orci')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (131, 127, N'32 Memorial Trail', NULL, N'Nuevo Amanecer', N'Nicaragua', NULL, N'cras pellentesque')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (132, 129, N'0939 Holmberg Lane', NULL, N'Sarmanovo', N'Russia', N'423371', N'pede libero quis')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (133, 131, N'3 Saint Paul Trail', NULL, N'Mangaldan', N'Philippines', N'2432', N'luctus et')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (134, 133, N'34 Leroy Street', NULL, N'Sastöbe', N'Kazakhstan', NULL, N'quisque arcu libero')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (135, 135, N'06 Cordelia Lane', NULL, N'Huanglong', N'China', NULL, N'interdum in ante')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (136, 137, N'419 Waubesa Center', NULL, N'Ramos', N'Philippines', N'2311', N'suspendisse potenti')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (137, 139, N'5880 Oakridge Hill', NULL, N'Pergan', N'Indonesia', NULL, N'potenti nullam')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (138, 141, N'7071 Butternut Park', NULL, N'Bizhou', N'China', NULL, N'lorem ipsum')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (139, 143, N'26 Lawn Park', NULL, N'Wates', N'Indonesia', NULL, N'rhoncus mauris enim')
INSERT [dbo].[klient_dane] ([id_adres], [id_klient], [adres_linia_1], [adres_linia_2], [miasto], [kraj], [kod_pocztowy], [klie_informacje_dodatkowe]) VALUES (140, 145, N'3527 Ludington Terrace', NULL, N'Elefsína', N'Greece', NULL, N'blandit non interdum')
SET IDENTITY_INSERT [dbo].[klient_dane] OFF
SET IDENTITY_INSERT [dbo].[klient_preferencje] ON 

INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (1, 26, N'Mitsubishi', N'Challenger', 2003, N'O', 6, 1, 19, 37)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (2, 28, N'Dodge', N'D350 Club', 1993, N'O', 5, 2, NULL, 38)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (3, 30, N'Mitsubishi', N'Chariot', 1992, N'B', 1, 3, NULL, 39)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (4, 32, N'Hummer', N'H2', 2009, N'G', 2, 4, NULL, 40)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (5, 34, N'Toyota', N'Solara', 2006, N'B', 1, 5, NULL, 41)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (6, 36, N'Toyota', N'Tundra', 2004, N'O', 2, 6, NULL, 42)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (7, 38, N'Ford', N'Explorer', 2006, N'O', 4, 7, NULL, 43)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (8, 40, N'Subaru', N'B9 Tribeca', 2006, N'O', 2, 8, NULL, 44)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (9, 42, N'Dodge', N'Avenger', 2000, N'B', 4, 9, NULL, 45)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (10, 44, N'Hyundai', N'Accent', 1998, N'B', 2, 10, 28, 46)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (11, 46, N'Mazda', N'MPV', 2004, N'O', 6, 11, 29, 47)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (12, 48, N'Toyota', N'T100', 1995, N'G', 1, 12, NULL, 48)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (13, 50, N'Ford', N'Edge', 2013, N'O', 2, 13, 31, 49)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (14, 52, N'Kia', N'Amanti', 2006, N'B', 6, 14, NULL, 50)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (15, 54, N'Oldsmobile', N'Achieva', 1997, N'O', 1, 15, NULL, 51)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (16, 56, N'Ford', N'Mustang', 2006, N'B', 3, 16, NULL, 52)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (17, 58, N'Honda', N'CR-V', 2005, N'O', 3, 17, 35, 53)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (18, 60, N'Chevrolet', N'Malibu', 1998, N'O', 5, 18, 36, 54)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (19, 62, N'Chrysler', N'Crossfire', 2006, N'B', 6, 1, NULL, 55)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (20, 64, N'Hummer', N'H1', 2000, N'G', 1, 2, NULL, 56)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (21, 66, N'Ford', N'F250', 1999, N'G', 4, 3, 21, 57)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (22, 68, N'Cadillac', N'STS-V', 2009, N'O', 6, 4, NULL, 58)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (23, 70, N'Lexus', N'IS F', 2008, N'G', 3, 5, NULL, 59)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (24, 72, N'Subaru', N'SVX', 1996, N'B', 2, 6, NULL, 60)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (25, 74, N'Ford', N'E150', 2007, N'B', 5, 7, NULL, 61)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (26, 76, N'Infiniti', N'EX', 2011, NULL, 3, NULL, NULL, 62)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (27, 78, N'Buick', N'Lucerne', 2011, N'O', 4, 9, NULL, 63)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (28, 80, N'Nissan', N'350Z', 2007, N'B', 3, 10, NULL, 64)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (29, 82, N'Mazda', N'B-Series', 2004, N'O', 5, 11, 29, 37)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (30, 84, N'Suzuki', N'Esteem', 2002, N'B', 2, 12, NULL, 38)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (31, 86, N'Scion', N'xD', 2008, N'B', 2, 13, 31, 39)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (32, 88, N'Bentley', N'Continental', 2009, N'O', 6, 14, 32, 40)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (33, 90, N'Mercury', N'Sable', 1992, N'B', 2, 15, 33, 41)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (34, 92, N'Chevrolet', N'Express 1500', 2008, N'B', 4, 16, 34, 42)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (35, 94, N'BMW', N'M3', 2006, N'B', 5, 17, NULL, 43)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (36, 96, N'Volvo', N'XC90', 2008, N'O', 5, 18, NULL, 44)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (37, 98, N'Isuzu', N'i-370', 2008, NULL, 2, NULL, 19, 45)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (38, 100, N'Mitsubishi', N'Mirage', 1987, N'B', 6, 2, NULL, 46)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (39, 102, N'Lexus', N'HS', 2011, N'B', 6, 3, NULL, 47)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (40, 104, N'Mitsubishi', N'Outlander Sport', 2012, N'O', 1, 4, 22, 48)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (41, 106, N'Ford', N'Tempo', 1988, N'O', 2, 5, NULL, 49)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (42, 108, N'Dodge', N'Viper', 2009, N'B', 6, 6, 24, 50)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (43, 110, N'Buick', N'Century', 2000, N'B', 6, 7, 25, 51)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (44, 112, N'Pontiac', N'Grand Prix', 1986, N'B', 6, 8, NULL, 52)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (45, 114, N'BMW', N'3 Series', 1992, N'O', 1, 9, NULL, 53)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (46, 116, N'Ford', N'E350', 2010, N'O', 3, 10, NULL, 54)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (47, 118, N'Dodge', N'Ram Van B250', 1993, N'O', 1, 11, NULL, 55)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (48, 120, N'Hyundai', N'Sonata', 1999, NULL, 6, NULL, NULL, 56)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (49, 122, N'Suzuki', N'SJ 410', 1984, N'O', 1, 13, NULL, 57)
INSERT [dbo].[klient_preferencje] ([id_klient_preferencje], [id_klient], [producent], [model], [rok_produkcji], [paliwo], [nadwozie], [pole_preferencji_1], [pole_preferencji_2], [pole_preferencji_3]) VALUES (50, 124, N'Porsche', N'Cayman', 2008, N'G', 2, 14, 32, 58)
SET IDENTITY_INSERT [dbo].[klient_preferencje] OFF
SET IDENTITY_INSERT [dbo].[log_table] ON 

INSERT [dbo].[log_table] ([id], [log_1], [log_2], [log_3], [log_4], [tabela], [operacjaA], [operacjaB], [czas]) VALUES (1, N'206', N'kos adam', NULL, NULL, N'klient', N'x', N'Insert', CAST(N'2018-06-04T20:33:00' AS SmallDateTime))
INSERT [dbo].[log_table] ([id], [log_1], [log_2], [log_3], [log_4], [tabela], [operacjaA], [operacjaB], [czas]) VALUES (2, N'206', N'kos adam', NULL, NULL, N'klient', N'Delete', N'x', CAST(N'2018-06-04T20:34:00' AS SmallDateTime))
INSERT [dbo].[log_table] ([id], [log_1], [log_2], [log_3], [log_4], [tabela], [operacjaA], [operacjaB], [czas]) VALUES (3, N'207', N'kos adam', NULL, NULL, N'klient', N'x', N'Insert', CAST(N'2018-06-04T20:34:00' AS SmallDateTime))
INSERT [dbo].[log_table] ([id], [log_1], [log_2], [log_3], [log_4], [tabela], [operacjaA], [operacjaB], [czas]) VALUES (4, N'208', N'pętelka waclaw', NULL, NULL, N'klient', N'Insert', N'dbo', CAST(N'2018-06-04T20:39:00' AS SmallDateTime))
INSERT [dbo].[log_table] ([id], [log_1], [log_2], [log_3], [log_4], [tabela], [operacjaA], [operacjaB], [czas]) VALUES (8, N'212', N'sas marcin', NULL, NULL, N'klient', N'Insert', N'dbo', CAST(N'2018-06-05T11:21:00' AS SmallDateTime))
INSERT [dbo].[log_table] ([id], [log_1], [log_2], [log_3], [log_4], [tabela], [operacjaA], [operacjaB], [czas]) VALUES (11, N'215', N'sasek marcinek', NULL, NULL, N'klient', N'Insert', N'dbo', CAST(N'2018-06-05T11:23:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[log_table] OFF
SET IDENTITY_INSERT [dbo].[model] ON 

INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (1, N'Mazda', N'Mazda3                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (2, N'Volkswagen', N'Tiguan                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (3, N'Buick', N'Century                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (4, N'Acura', N'TL                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (5, N'Lexus', N'IS                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (6, N'Mercury', N'Cougar                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (7, N'Mazda', N'CX-7                                              ', N'integer tincidunt ante vel ipsum')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (8, N'Ford', N'Thunderbird                                       ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (9, N'Pontiac', N'Sunbird                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (10, N'Lexus', N'SC                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (11, N'Mitsubishi', N'Galant                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (12, N'Nissan', N'Maxima                                            ', N'lobortis vel dapibus at diam nam')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (13, N'Subaru', N'Loyale                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (14, N'Ford', N'Expedition                                        ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (15, N'Honda', N'Element                                           ', N'bibendum felis sed interdum venenatis turpis')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (16, N'Lotus', N'Esprit Turbo                                      ', N'accumsan odio curabitur convallis duis consequat')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (17, N'Suzuki', N'SJ                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (18, N'Infiniti', N'QX                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (19, N'Lexus', N'SC                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (20, N'Pontiac', N'Parisienne                                        ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (21, N'Chevrolet', N'Express 1500                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (22, N'Geo', N'Tracker                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (23, N'Dodge', N'Caravan                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (24, N'Chrysler', N'Crossfire                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (25, N'GMC', N'Sierra 3500                                       ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (26, N'Pontiac', N'Fiero                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (27, N'GMC', N'Vandura 3500                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (28, N'Toyota', N'Corolla                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (29, N'Hyundai', N'Veloster                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (30, N'Chrysler', N'Imperial                                          ', N'vulputate elementum nullam varius nulla facilisi')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (31, N'Mitsubishi', N'Truck                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (32, N'Chevrolet', N'Avalanche                                         ', N'id massa id nisl venenatis')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (33, N'Lotus', N'Elise                                             ', N'interdum venenatis turpis enim blandit mi')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (34, N'Dodge', N'Dakota                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (35, N'Mercedes-Benz', N'CLK-Class                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (36, N'Honda', N'Pilot                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (37, N'GMC', N'2500                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (38, N'Dodge', N'Charger                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (39, N'Mazda', N'Protege                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (40, N'Suzuki', N'XL-7                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (41, N'Infiniti', N'FX                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (42, N'Audi', N'RS 6                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (43, N'Volkswagen', N'Touareg 2                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (44, N'Nissan', N'350Z Roadster                                     ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (45, N'Mercedes-Benz', N'CL-Class                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (46, N'Mazda', N'MX-5                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (47, N'Porsche', N'911                                               ', N'morbi sem mauris laoreet ut')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (48, N'Audi', N'A4                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (49, N'Oldsmobile', N'Ciera                                             ', N'venenatis non sodales sed tincidunt eu')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (50, N'Ford', N'GT500                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (51, N'Mercedes-Benz', N'GL-Class                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (52, N'Buick', N'Electra                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (53, N'Chrysler', N'300                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (54, N'Toyota', N'Venza                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (55, N'Lexus', N'LS                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (56, N'Chrysler', N'300                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (57, N'Ford', N'Econoline E250                                    ', N'at dolor quis odio consequat varius')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (58, N'Volvo', N'XC60                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (59, N'Pontiac', N'Trans Sport                                       ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (60, N'Saab', N'9000                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (61, N'Honda', N'Civic                                             ', N'sed accumsan felis ut at dolor')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (62, N'Ford', N'E-Series                                          ', N'arcu adipiscing molestie hendrerit at')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (63, N'Honda', N'Passport                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (64, N'Mitsubishi', N'Galant                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (65, N'Mitsubishi', N'Truck                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (66, N'Ford', N'F250                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (67, N'BMW', N'Z3                                                ', N'urna pretium nisl ut volutpat sapien')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (68, N'GMC', N'1500                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (69, N'BMW', N'X5                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (70, N'Pontiac', N'Grand Prix                                        ', N'sollicitudin ut suscipit a feugiat et')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (71, N'Volvo', N'S70                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (72, N'Audi', N'A4                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (73, N'Dodge', N'Ram Van 3500                                      ', N'cubilia curae donec pharetra magna vestibulum')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (74, N'Suzuki', N'Verona                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (75, N'Volvo', N'XC90                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (76, N'Chevrolet', N'Express 1500                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (77, N'Chevrolet', N'Express 1500                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (78, N'Ford', N'Ranger                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (79, N'Lotus', N'Exige                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (80, N'Toyota', N'Truck Xtracab SR5                                 ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (81, N'GMC', N'Yukon XL 1500                                     ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (82, N'Infiniti', N'Q                                                 ', N'in felis donec semper sapien')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (83, N'Nissan', N'Sentra                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (84, N'Mercedes-Benz', N'W201                                              ', N'in purus eu magna vulputate')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (85, N'Honda', N'CR-Z                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (86, N'Lexus', N'ES                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (87, N'Mercedes-Benz', N'E-Class                                           ', N'lorem ipsum dolor sit amet')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (88, N'Volkswagen', N'New Beetle                                        ', N'interdum mauris non ligula pellentesque ultrices')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (89, N'Bentley', N'Continental GT                                    ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (90, N'Volvo', N'S80                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (91, N'Infiniti', N'M                                                 ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (92, N'Aston Martin', N'V8 Vantage                                        ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (93, N'Dodge', N'Caravan                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (94, N'Mercedes-Benz', N'C-Class                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (95, N'Subaru', N'Outback                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (96, N'Mazda', N'Mazda2                                            ', N'aenean fermentum donec ut mauris')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (97, N'Ford', N'Mustang                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (98, N'Infiniti', N'G                                                 ', N'in purus eu magna vulputate luctus')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (99, N'Volkswagen', N'riolet                                            ', NULL)
GO
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (100, N'Mazda', N'626                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (101, N'Cadillac', N'Escalade ESV                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (102, N'Hyundai', N'Scoupe                                            ', N'at turpis donec posuere metus vitae')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (103, N'Toyota', N'T100 Xtra                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (104, N'Volvo', N'240                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (105, N'Maybach', N'57                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (106, N'Mercedes-Benz', N'600SEC                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (107, N'Dodge', N'Dakota                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (108, N'Ford', N'F250                                              ', N'eros elementum pellentesque quisque porta')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (109, N'Dodge', N'Ram 50                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (110, N'Honda', N'Civic                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (111, N'Cadillac', N'DTS                                               ', N'laoreet ut rhoncus aliquet pulvinar')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (112, N'Mercedes-Benz', N'GL-Class                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (113, N'Chevrolet', N'Suburban 2500                                     ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (114, N'Chevrolet', N'Cobalt SS                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (115, N'Panoz', N'Esperante                                         ', N'placerat praesent blandit nam nulla')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (116, N'Mercury', N'Mariner                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (117, N'Jeep', N'Commander                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (118, N'Buick', N'Regal                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (119, N'Volvo', N'C30                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (120, N'Pontiac', N'Bonneville                                        ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (121, N'Suzuki', N'Daewoo Lacetti                                    ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (122, N'Mazda', N'MX-6                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (123, N'Ford', N'F-Series                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (124, N'Chevrolet', N'Beretta                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (125, N'Chevrolet', N'2500                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (126, N'Mitsubishi', N'Diamante                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (127, N'Mitsubishi', N'Mirage                                            ', N'dignissim vestibulum vestibulum ante ipsum primis')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (128, N'Toyota', N'Land Cruiser                                      ', N'dictumst maecenas ut massa quis augue')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (129, N'Suzuki', N'X-90                                              ', N'pulvinar sed nisl nunc rhoncus')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (130, N'Toyota', N'Prius                                             ', N'lacinia eget tincidunt eget tempus')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (131, N'Nissan', N'Armada                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (132, N'Ford', N'E-Series                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (133, N'Hyundai', N'Azera                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (134, N'Dodge', N'Ram Wagon B250                                    ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (135, N'Honda', N'S2000                                             ', N'cursus vestibulum proin eu mi nulla')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (136, N'Toyota', N'RAV4                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (137, N'Mazda', N'B-Series                                          ', N'eu orci mauris lacinia sapien')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (138, N'Toyota', N'Land Cruiser                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (139, N'Austin', N'Mini                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (140, N'Hyundai', N'Tucson                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (141, N'Hyundai', N'Entourage                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (142, N'BMW', N'X3                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (143, N'Mercury', N'Mystique                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (144, N'Honda', N'Accord                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (145, N'Chrysler', N'Concorde                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (146, N'Hyundai', N'Scoupe                                            ', N'justo morbi ut odio cras mi')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (147, N'Cadillac', N'Escalade                                          ', N'et ultrices posuere cubilia curae')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (148, N'Pontiac', N'Grand Prix                                        ', N'eu tincidunt in leo maecenas pulvinar')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (149, N'Toyota', N'Camry                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (150, N'Nissan', N'Quest                                             ', N'est phasellus sit amet erat nulla')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (151, N'Audi', N'90                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (152, N'Dodge', N'Dakota                                            ', N'sodales scelerisque mauris sit amet')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (153, N'Acura', N'NSX                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (154, N'Audi', N'A3                                                ', N'venenatis tristique fusce congue diam id')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (155, N'Dodge', N'Dakota                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (156, N'Mitsubishi', N'Eclipse                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (157, N'Honda', N'Passport                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (158, N'GMC', N'Savana 3500                                       ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (159, N'Lexus', N'GS                                                ', N'bibendum felis sed interdum venenatis')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (160, N'Volvo', N'XC70                                              ', N'nisl nunc rhoncus dui vel sem')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (161, N'Hyundai', N'Elantra                                           ', N'nisi at nibh in hac')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (162, N'BMW', N'Z8                                                ', N'nam tristique tortor eu pede')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (163, N'Mazda', N'B-Series                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (164, N'Lotus', N'Esprit                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (165, N'Dodge', N'Grand Caravan                                     ', N'augue luctus tincidunt nulla mollis molestie')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (166, N'Buick', N'Regal                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (167, N'Acura', N'CL                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (168, N'Honda', N'Passport                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (169, N'Infiniti', N'JX                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (170, N'Mitsubishi', N'Truck                                             ', N'lobortis ligula sit amet eleifend')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (171, N'Acura', N'Legend                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (172, N'Toyota', N'Prius                                             ', N'pede lobortis ligula sit amet')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (173, N'BMW', N'M3                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (174, N'Buick', N'Reatta                                            ', N'interdum mauris ullamcorper purus sit')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (175, N'Mercedes-Benz', N'190E                                              ', N'non velit nec nisi vulputate nonummy')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (176, N'Honda', N'S2000                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (177, N'Acura', N'RL                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (178, N'Volkswagen', N'Jetta                                             ', N'aliquam erat volutpat in congue etiam')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (179, N'Mercedes-Benz', N'SLK-Class                                         ', N'eros vestibulum ac est lacinia nisi')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (180, N'Toyota', N'4Runner                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (181, N'Mercury', N'Grand Marquis                                     ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (182, N'Dodge', N'Ram 2500                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (183, N'Jeep', N'Wrangler                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (184, N'Dodge', N'D150                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (185, N'GMC', N'Savana 1500                                       ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (186, N'Chevrolet', N'Bel Air                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (187, N'Cadillac', N'Escalade EXT                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (188, N'Cadillac', N'Catera                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (189, N'Honda', N'Odyssey                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (190, N'Mitsubishi', N'3000GT                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (191, N'GMC', N'Yukon                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (192, N'Saab', N'9-3                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (193, N'Maserati', N'Coupe                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (194, N'Dodge', N'Ram Van B150                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (195, N'Kia', N'Sedona                                            ', N'vulputate justo in blandit ultrices enim')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (196, N'Bentley', N'Continental GTC                                   ', N'purus eu magna vulputate luctus')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (197, N'Mitsubishi', N'Galant                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (198, N'Chevrolet', N'Silverado                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (199, N'Hyundai', N'Azera                                             ', NULL)
GO
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (200, N'Mercedes-Benz', N'S-Class                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (201, N'Ram', N'Dakota                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (202, N'Acura', N'NSX                                               ', N'diam id ornare imperdiet sapien')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (203, N'Plymouth', N'Breeze                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (204, N'GMC', N'Rally Wagon G3500                                 ', N'vulputate justo in blandit ultrices enim')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (205, N'GMC', N'Envoy XL                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (206, N'Lexus', N'LS                                                ', N'vestibulum ante ipsum primis in')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (207, N'Ford', N'Explorer Sport Trac                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (208, N'Mitsubishi', N'L300                                              ', N'ultrices erat tortor sollicitudin mi sit')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (209, N'Nissan', N'Frontier                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (210, N'GMC', N'Rally Wagon 1500                                  ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (211, N'GMC', N'Safari                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (212, N'Acura', N'RL                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (213, N'Jaguar', N'XJ Series                                         ', N'magna ac consequat metus sapien')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (214, N'Ford', N'Focus                                             ', N'at velit vivamus vel nulla')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (215, N'Saab', N'9-4X                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (216, N'Mercury', N'Capri                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (217, N'Lotus', N'Esprit                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (218, N'Mitsubishi', N'Mirage                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (219, N'Volkswagen', N'Fox                                               ', N'id massa id nisl venenatis lacinia')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (220, N'Ford', N'E250                                              ', N'felis ut at dolor quis odio')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (221, N'Cadillac', N'Fleetwood                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (222, N'Chevrolet', N'S10 Blazer                                        ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (223, N'Mazda', N'MX-6                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (224, N'Hyundai', N'Accent                                            ', N'a pede posuere nonummy integer non')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (225, N'Volkswagen', N'GLI                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (226, N'Ford', N'Explorer                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (227, N'GMC', N'Yukon                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (228, N'Suzuki', N'XL-7                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (229, N'Mazda', N'Mazdaspeed 3                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (230, N'Cadillac', N'DeVille                                           ', N'pulvinar lobortis est phasellus sit')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (231, N'Suzuki', N'Grand Vitara                                      ', N'diam neque vestibulum eget vulputate')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (232, N'Kia', N'Sephia                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (233, N'Suzuki', N'Grand Vitara                                      ', N'vulputate vitae nisl aenean lectus')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (234, N'Dodge', N'Viper                                             ', N'morbi a ipsum integer a nibh')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (235, N'Plymouth', N'Laser                                             ', N'pretium nisl ut volutpat sapien')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (236, N'Land Rover', N'Discovery                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (237, N'Ford', N'Explorer                                          ', N'donec quis orci eget orci vehicula')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (238, N'Ford', N'Econoline E150                                    ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (239, N'Audi', N'100                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (240, N'Saturn', N'VUE                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (241, N'Mercedes-Benz', N'CLK-Class                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (242, N'Ford', N'Th!nk                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (243, N'Acura', N'CL                                                ', N'platea dictumst aliquam augue quam sollicitudin')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (244, N'Rolls-Royce', N'Phantom                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (245, N'BMW', N'6 Series                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (246, N'Hyundai', N'Azera                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (247, N'Lexus', N'RX Hybrid                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (248, N'Pontiac', N'Bonneville                                        ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (249, N'Audi', N'R8                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (250, N'Chevrolet', N'Sportvan G30                                      ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (251, N'Dodge', N'Durango                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (252, N'Chevrolet', N'HHR                                               ', N'in hac habitasse platea dictumst etiam')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (253, N'Hyundai', N'Elantra                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (254, N'Chevrolet', N'Corvette                                          ', N'dapibus duis at velit eu')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (255, N'Ford', N'Expedition                                        ', N'volutpat in congue etiam justo')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (256, N'Land Rover', N'Range Rover                                       ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (257, N'Lexus', N'SC                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (258, N'Lexus', N'LS                                                ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (259, N'Eagle', N'Summit                                            ', N'ante ipsum primis in faucibus orci')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (260, N'Honda', N'Civic                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (261, N'Eagle', N'Vision                                            ', N'etiam faucibus cursus urna ut tellus')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (262, N'Ford', N'Thunderbird                                       ', N'faucibus orci luctus et ultrices')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (263, N'Suzuki', N'Samurai                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (264, N'Dodge', N'Charger                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (265, N'Mitsubishi', N'Chariot                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (266, N'Toyota', N'Solara                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (267, N'Mitsubishi', N'Pajero                                            ', N'sed accumsan felis ut at')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (268, N'Volkswagen', N'Corrado                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (269, N'Geo', N'Metro                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (270, N'BMW', N'X5                                                ', N'sit amet sapien dignissim vestibulum vestibulum')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (271, N'Lincoln', N'Town Car                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (272, N'Toyota', N'Corolla                                           ', N'in sapien iaculis congue vivamus metus')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (273, N'Toyota', N'Avalon                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (274, N'Pontiac', N'LeMans                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (275, N'Volkswagen', N'Beetle                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (276, N'Nissan', N'Sentra                                            ', N'iaculis congue vivamus metus arcu')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (277, N'Toyota', N'MR2                                               ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (278, N'Subaru', N'Tribeca                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (279, N'Mercury', N'Lynx                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (280, N'Volkswagen', N'Jetta                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (281, N'Ford', N'Taurus                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (282, N'Toyota', N'Supra                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (283, N'Nissan', N'Altima                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (284, N'Mazda', N'MX-6                                              ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (285, N'Chevrolet', N'Corvette                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (286, N'Ford', N'Mustang                                           ', N'nam ultrices libero non mattis')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (287, N'Pontiac', N'Grand Prix                                        ', N'lacus at velit vivamus vel nulla')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (288, N'Chevrolet', N'Malibu                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (289, N'Buick', N'LaCrosse                                          ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (290, N'GMC', N'Suburban 2500                                     ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (291, N'Chevrolet', N'Venture                                           ', N'posuere nonummy integer non velit')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (292, N'GMC', N'Sierra 2500                                       ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (293, N'Chrysler', N'Crossfire                                         ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (294, N'Ford', N'Taurus                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (295, N'Audi', N'4000s                                             ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (296, N'Chrysler', N'LeBaron                                           ', N'sapien quis libero nullam sit')
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (297, N'Buick', N'Skylark                                           ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (298, N'Cadillac', N'Catera                                            ', NULL)
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (299, N'Ford', N'Expedition                                        ', NULL)
GO
INSERT [dbo].[model] ([id_model], [prod_nazwa], [model_nazwa], [model_informacje_dodatkowe]) VALUES (300, N'Toyota', N'Land Cruiser                                      ', NULL)
SET IDENTITY_INSERT [dbo].[model] OFF
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (223, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (224, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (225, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (223, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (224, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (225, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (226, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (227, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (228, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (229, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (230, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (231, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (232, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (233, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (234, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (235, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (236, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (237, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (238, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (239, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (240, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (241, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (242, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (243, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (244, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (245, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (246, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (247, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (248, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (249, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (250, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (251, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (252, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (253, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (254, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (255, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (256, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (257, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (258, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (259, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (260, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (261, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (262, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (263, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (264, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (265, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (266, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (267, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (268, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (269, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (270, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (271, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (272, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (273, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (274, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (275, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (276, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (277, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (278, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (279, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (280, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (281, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (282, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (283, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (284, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (285, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (286, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (287, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (288, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (289, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (290, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (291, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (292, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (293, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (294, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (295, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (296, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (297, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (298, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (299, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (300, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (301, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (302, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (303, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (304, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (305, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (306, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (307, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (308, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (309, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (310, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (311, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (312, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (313, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (314, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (315, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (316, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (317, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (318, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (319, 3)
GO
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (320, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (321, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (322, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (323, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (324, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (325, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (326, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (327, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (328, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (329, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (330, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (331, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (332, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (333, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (334, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (335, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (336, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (337, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (338, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (339, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (340, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (341, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (342, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (343, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (344, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (345, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (346, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (347, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (348, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (349, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (350, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (351, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (352, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (353, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (354, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (355, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (356, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (357, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (358, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (359, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (360, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (361, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (362, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (363, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (364, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (365, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (366, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (367, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (368, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (369, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (370, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (371, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (372, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (373, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (374, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (375, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (376, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (377, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (378, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (379, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (380, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (381, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (382, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (383, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (384, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (385, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (386, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (387, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (388, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (389, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (390, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (391, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (392, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (393, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (394, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (395, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (396, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (397, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (398, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (399, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (400, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (401, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (402, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (403, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (404, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (405, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (406, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (407, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (408, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (409, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (410, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (411, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (412, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (413, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (414, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (415, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (416, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (417, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (418, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (419, 1)
GO
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (420, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (421, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (422, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (423, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (424, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (425, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (426, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (427, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (428, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (429, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (430, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (431, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (432, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (433, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (434, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (435, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (436, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (437, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (438, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (439, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (440, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (441, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (442, 1)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (443, 2)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (444, 3)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (226, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (227, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (228, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (229, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (230, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (231, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (232, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (233, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (234, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (235, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (236, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (237, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (238, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (239, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (240, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (241, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (242, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (243, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (244, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (245, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (246, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (247, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (248, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (249, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (250, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (251, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (252, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (253, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (254, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (255, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (256, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (257, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (258, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (259, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (260, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (261, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (262, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (263, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (264, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (265, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (266, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (267, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (268, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (269, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (270, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (271, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (272, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (273, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (274, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (275, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (276, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (277, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (278, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (279, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (280, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (281, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (282, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (283, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (284, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (285, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (286, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (287, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (288, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (289, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (290, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (291, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (292, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (293, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (294, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (295, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (296, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (297, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (298, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (299, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (300, 60)
GO
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (301, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (302, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (303, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (304, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (305, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (306, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (307, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (308, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (309, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (310, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (311, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (312, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (313, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (314, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (315, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (316, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (317, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (318, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (319, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (320, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (321, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (322, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (323, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (324, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (325, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (326, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (327, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (328, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (329, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (330, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (331, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (332, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (333, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (334, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (335, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (336, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (337, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (338, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (339, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (340, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (341, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (342, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (343, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (344, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (345, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (346, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (347, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (348, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (349, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (350, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (351, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (352, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (353, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (354, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (355, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (356, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (357, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (358, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (359, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (360, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (361, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (362, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (363, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (364, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (365, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (366, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (367, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (368, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (369, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (370, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (371, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (372, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (373, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (374, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (375, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (376, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (377, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (378, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (379, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (380, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (381, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (382, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (383, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (384, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (385, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (386, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (387, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (388, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (389, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (390, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (391, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (392, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (393, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (394, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (395, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (396, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (397, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (398, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (399, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (400, 64)
GO
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (401, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (402, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (403, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (404, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (405, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (406, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (407, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (408, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (409, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (410, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (411, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (412, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (413, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (414, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (415, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (416, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (417, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (418, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (419, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (420, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (421, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (422, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (423, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (424, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (425, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (426, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (427, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (428, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (429, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (430, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (431, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (432, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (433, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (434, 64)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (435, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (436, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (437, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (438, 61)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (439, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (440, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (441, 62)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (442, 59)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (443, 60)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (444, 63)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (223, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (224, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (225, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (226, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (227, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (228, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (229, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (230, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (231, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (232, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (233, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (234, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (235, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (236, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (237, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (238, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (239, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (240, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (241, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (242, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (243, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (244, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (245, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (246, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (247, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (248, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (249, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (250, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (251, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (252, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (253, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (254, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (255, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (256, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (257, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (258, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (259, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (260, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (261, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (262, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (263, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (264, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (265, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (266, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (267, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (268, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (269, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (270, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (271, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (272, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (273, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (274, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (275, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (276, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (277, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (278, 4)
GO
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (279, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (280, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (281, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (282, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (283, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (284, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (285, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (286, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (287, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (288, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (289, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (290, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (291, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (292, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (293, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (294, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (295, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (296, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (297, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (298, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (299, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (300, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (301, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (302, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (303, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (304, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (305, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (306, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (307, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (308, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (309, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (310, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (311, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (312, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (313, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (314, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (315, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (316, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (317, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (318, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (319, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (320, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (321, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (322, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (323, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (324, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (325, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (326, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (327, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (328, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (329, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (330, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (331, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (332, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (333, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (334, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (335, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (336, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (337, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (338, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (339, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (340, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (341, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (342, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (343, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (344, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (345, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (346, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (347, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (348, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (349, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (350, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (351, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (352, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (353, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (354, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (355, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (356, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (357, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (358, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (359, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (360, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (361, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (362, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (363, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (364, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (365, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (366, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (367, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (368, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (369, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (370, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (371, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (372, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (373, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (374, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (375, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (376, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (377, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (378, 6)
GO
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (379, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (380, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (381, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (382, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (383, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (384, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (385, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (386, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (387, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (388, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (389, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (390, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (391, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (392, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (393, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (394, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (395, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (396, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (397, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (398, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (399, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (400, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (401, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (402, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (403, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (404, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (405, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (406, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (407, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (408, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (409, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (410, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (411, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (412, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (413, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (414, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (415, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (416, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (417, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (418, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (419, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (420, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (421, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (422, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (423, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (424, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (425, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (426, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (427, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (428, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (429, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (430, 4)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (431, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (432, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (433, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (434, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (435, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (436, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (437, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (438, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (439, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (440, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (441, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (442, 6)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (443, 5)
INSERT [dbo].[powiazanie_wyposazenie_samochod] ([id_samochod], [id_wyposazenie]) VALUES (444, 5)
SET IDENTITY_INSERT [dbo].[rezerwacje] ON 

INSERT [dbo].[rezerwacje] ([id_rezerwacji], [id_klienta], [id_samochodu], [data_do]) VALUES (2, 199, 417, CAST(N'2018-06-09T00:00:00' AS SmallDateTime))
INSERT [dbo].[rezerwacje] ([id_rezerwacji], [id_klienta], [id_samochodu], [data_do]) VALUES (3, 198, 418, CAST(N'2018-06-05T00:00:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[rezerwacje] OFF
SET IDENTITY_INSERT [dbo].[samochod_wyposazenie] ON 

INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (1, N'2 drzwi')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (2, N'3 drzwi')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (3, N'4/5 drzwi')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (4, N'2 miejsca')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (5, N'5 miejsc')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (6, N'7 miejsc')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (7, N'na koła przednie')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (8, N'na koła tylne')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (9, N'4x4')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (10, N'manualna')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (11, N'automatyczna')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (12, N'klimatyzacja manualna')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (13, N'brak klimatyzacji')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (14, N'klimatyzacja automatyczna')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (15, N'oświetlenie do jazdy dziennej')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (16, N'światła led')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (17, N'światła przeciwmgłowe')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (18, N'światła ksenonowe')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (19, N'ABS')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (20, N'ESP')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (21, N'kontrola trakcji')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (22, N'asystent parkowania')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (23, N'czujniki parkowania')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (24, N'czujnik deszczu')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (25, N'immobilizer')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (26, N'poduszka pasażera')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (27, N'poduszka boczna')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (28, N'kamera cofania')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (29, N'elektryczne szyby przednie')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (30, N'elektryczne szyby tylne')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (31, N'elektryczne lusterka')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (32, N'podgrzewane lusterka')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (33, N'kierownica wielofunkcyjna')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (34, N'podgrzewane siedzenia')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (35, N'wspomaganie kierownicy')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (36, N'przyciemniane szyby')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (37, N'radio fabryczne')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (38, N'radio niefabryczne')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (39, N'mp3')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (40, N'zmieniarka CD')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (41, N'nawigacja GPS')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (42, N'bluetooth')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (43, N'alufelgi')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (44, N'centralny zamek')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (45, N'panpramiczny dach')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (46, N'hak')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (47, N'komputer pokładowy')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (48, N'tempomat')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (49, N'metalik')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (50, N'akryl')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (51, N'matowy')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (52, N'perłowy')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (53, N'krajowe')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (54, N'importowany')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (55, N'bezwypadkowy')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (56, N'pierwszy właściciel')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (57, N'serwisowany w aso')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (58, N'zarejestrowany w polsce')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (59, N'czarny')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (60, N'czerwony')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (61, N'zielony')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (62, N'biały')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (63, N'srebrny')
INSERT [dbo].[samochod_wyposazenie] ([id_wyposazenie], [informacje_opis]) VALUES (64, N'niebieski')
SET IDENTITY_INSERT [dbo].[samochod_wyposazenie] OFF
SET IDENTITY_INSERT [dbo].[samochody_na_sprzedaz] ON 

INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (223, 237, 1, 117652, N'1C4RJEAG2EC129439', 30000, 1989, N'S', N'pl ', N'N', 1600, N'B', N'orci mauris')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (224, 124, 5, 86477, N'1G4GC5EG4AF154472', 200000, 2002, N'W', N'de ', N'T', 1600, N'O', N'nisi nam ultrices')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (225, 183, 5, 114141, N'1G6AH5RX9F0144149', 80000, 1991, N'W', N'us ', N'N', 1500, N'B', N'faucibus orci luctus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (226, 96, 4, 67802, N'JN1CV6AP5AM122850', 12000, 2006, N'W', N'us ', N'T', 1100, N'G', N'sit amet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (227, 185, 1, 30084, N'WBASP4C53BC331883', 300000, 2012, N'S', N'de ', N'T', 1800, N'B', N'laoreet ut')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (228, 287, 4, 39429, N'1GKS1KE00ER064458', 100000, 2009, N'W', N'gb ', N'N', 1300, N'B', N'orci luctus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (229, 178, 5, 84091, N'WBA6B8C5XED981543', 300000, 1993, N'W', N'de ', N'N', 1800, N'G', N'cubilia curae duis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (230, 147, 5, 101738, N'1N4AA5AP5DC056665', 12000, 1994, N'W', N'de ', N'T', 1800, N'B', N'justo in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (231, 160, 1, 141668, N'WA1TFAFL4EA748720', 30000, 2004, N'S', N'de ', N'T', 1000, N'O', N'turpis eget elit')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (232, 137, 4, 22453, N'WBAYP1C57DD022973', 80000, 1986, N'W', N'us ', N'T', 2000, N'G', N'justo sit amet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (233, 292, 3, 62867, N'5J8TB18518A976969', 300000, 1995, N'W', N'pl ', N'N', 1800, N'B', N'augue vestibulum rutrum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (234, 108, 3, 64414, N'1GD22ZCGXCZ758844', 200000, 1998, N'W', N'gb ', N'T', 1500, N'B', N'amet justo')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (235, 175, 2, 62445, N'YV1612FH2D2307643', 200000, 1998, N'S', N'de ', N'T', 1600, N'O', N'vestibulum ac')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (236, 262, 2, 117433, N'WBSDE93412C260018', 12000, 2001, N'W', N'us ', N'T', 1600, N'O', N'lorem id')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (237, 259, 3, 69022, N'1FTSW2B53AE161794', 100000, 2011, N'W', N'pl ', N'T', 1600, N'B', N'nisi venenatis tristique')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (238, 286, 4, 19384, N'1FTEW1E85AK708093', 130000, 1998, N'W', N'de ', N'N', 1100, N'B', N'consectetuer adipiscing')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (239, 253, 5, 96268, N'WBALM73569E994331', 200000, 1998, N'S', N'us ', N'N', 1600, N'O', N'interdum eu tincidunt')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (240, 2, 2, 43165, N'5GADT13S962788173', 12000, 2002, N'S', N'us ', N'T', 4000, N'O', N'fusce consequat nulla')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (241, 233, 1, 36492, N'JN8AZ1FY1EW716766', 200000, 1997, N'W', N'pl ', N'T', 4000, N'B', N'et ultrices')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (242, 23, 3, 44314, N'3N1AB7AP4FL656896', 130000, 2001, N'W', N'pl ', N'N', 3000, N'G', N'pellentesque viverra pede')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (243, 11, 4, 44974, N'1FTEX1CM5DK826713', 100000, 2012, N'S', N'us ', N'N', 2000, N'G', N'curae mauris viverra')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (244, 135, 3, 78794, N'JH4DC538X6S380953', 200000, 1994, N'W', N'de ', N'N', 2000, N'G', N'ultrices libero non')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (245, 247, 4, 98785, N'1G6AH5R30E0658919', 30000, 1988, N'W', N'de ', N'N', 4000, N'G', N'dolor vel est')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (246, 57, 1, 97765, N'2FMDK3KC2AB357080', 12000, 1986, N'W', N'pl ', N'T', 1300, N'B', N'libero quis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (247, 232, 4, 55483, N'WDDGF5EB7AR165387', 30000, 2006, N'S', N'pl ', N'T', 1500, N'B', N'amet diam')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (248, 120, 1, 23725, N'KMHGH4JH6EU350974', 130000, 2009, N'W', N'de ', N'N', 2000, N'B', N'amet diam in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (249, 132, 3, 136703, N'WAUEFAFL4CN366463', 130000, 2001, N'W', N'gb ', N'N', 1500, N'B', N'sociis natoque penatibus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (250, 123, 2, 39449, N'5UXFG835X9L433654', 200000, 1998, N'W', N'gb ', N'T', 1300, N'O', N'feugiat non pretium')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (251, 124, 2, 41701, N'1FTFW1E86AK104556', 60000, 2002, N'S', N'us ', N'T', 1200, N'G', N'orci luctus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (252, 41, 2, 106147, N'1G6AV5S80F0344638', 30000, 2002, N'W', N'de ', N'T', 1600, N'O', N'commodo vulputate')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (253, 208, 4, 125172, N'1C3CDZAB1CN165525', 100000, 2006, N'W', N'pl ', N'N', 1800, N'B', N'adipiscing elit proin')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (254, 30, 3, 59562, N'3D7JV1EP8AG038550', 80000, 1970, N'W', N'pl ', N'N', 1200, N'B', N'integer a nibh')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (255, 176, 3, 128616, N'WBADX7C5XCE184283', 12000, 1992, N'S', N'gb ', N'N', 1000, N'G', N'ipsum ac tellus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (256, 201, 5, 80134, N'2C4RDGDGXDR964497', 60000, 1991, N'W', N'pl ', N'T', 1800, N'O', N'praesent blandit nam')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (257, 197, 2, 108108, N'TRUVD38J391562013', 200000, 1999, N'W', N'pl ', N'T', 4000, N'B', N'enim leo rhoncus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (258, 25, 2, 89580, N'2B3CA9CV6AH965367', 100000, 2012, N'W', N'us ', N'T', 1300, N'G', N'enim lorem ipsum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (259, 148, 1, 96504, N'1LNHL9DK8EG745079', 100000, 2002, N'S', N'de ', N'T', 1500, N'G', N'in tempus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (260, 153, 5, 124139, N'4T3BA3BB6BU397377', 200000, 2000, N'W', N'gb ', N'N', 1000, N'O', N'ipsum ac')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (261, 136, 4, 97309, N'1G6AR5SX3E0033246', 12000, 2001, N'W', N'gb ', N'N', 1100, N'G', N'et ultrices')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (262, 36, 5, 68241, N'1GYUKHEF3AR534818', 130000, 2008, N'W', N'gb ', N'T', 1800, N'G', N'nascetur ridiculus mus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (263, 160, 4, 59073, N'WAUSGAFB1AN211065', 300000, 2000, N'S', N'gb ', N'T', 1600, N'O', N'consequat metus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (264, 147, 5, 110886, N'5GALRBED0AJ821672', 100000, 2008, N'W', N'pl ', N'N', 1200, N'B', N'praesent blandit')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (265, 161, 3, 29929, N'WBALW3C57EC975652', 12000, 1993, N'W', N'de ', N'N', 1300, N'B', N'justo aliquam')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (266, 62, 3, 136095, N'JHMZF1D49CS807424', 30000, 2011, N'W', N'us ', N'N', 1200, N'B', N'tristique est')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (267, 199, 5, 12103, N'WAULT58E22A970640', 130000, 2008, N'S', N'pl ', N'N', 2000, N'B', N'convallis eget')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (268, 285, 1, 147964, N'JN1AZ4EH5AM866208', 12000, 2010, N'W', N'gb ', N'N', 1300, N'B', N'mi integer ac')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (269, 21, 1, 16565, N'2C3CCAJT6CH946904', 80000, 2001, N'W', N'pl ', N'T', 3000, N'B', N'pede venenatis non')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (270, 147, 5, 102818, N'WA1WMBFE5BD104616', 130000, 2003, N'W', N'de ', N'T', 1500, N'B', N'tellus semper')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (271, 73, 4, 64309, N'3N6CM0KN1DK946193', 100000, 2001, N'S', N'us ', N'N', 4000, N'B', N'duis at')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (272, 150, 4, 105626, N'SAJWA4DCXAM070426', 200000, 2009, N'W', N'pl ', N'N', 3000, N'O', N'pretium nisl ut')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (273, 203, 4, 115868, N'5UXWX7C57CL190550', 60000, 2004, N'W', N'de ', N'T', 1600, N'O', N'sed tristique')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (274, 171, 1, 13909, N'JTDZN3EU0FJ214334', 200000, 2003, N'W', N'gb ', N'N', 1800, N'B', N'vestibulum eget')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (275, 225, 5, 92914, N'WAUKF78E96A756796', 30000, 1998, N'S', N'us ', N'T', 3000, N'O', N'ut odio')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (276, 88, 4, 120990, N'SALSF2D40CA063946', 130000, 2006, N'W', N'de ', N'N', 1600, N'O', N'augue luctus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (277, 94, 1, 110019, N'3C4PDDDG6FT312028', 100000, 1993, N'W', N'de ', N'T', 1100, N'G', N'eget orci')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (278, 61, 3, 87617, N'YV1902AH0B1509083', 300000, 1993, N'W', N'us ', N'N', 2000, N'B', N'cursus id')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (279, 4, 3, 29375, N'WBANF33527B556125', 30000, 1967, N'S', N'gb ', N'T', 1200, N'B', N'elit proin interdum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (280, 109, 3, 146965, N'1N6AD0CU2CN443469', 12000, 2007, N'W', N'gb ', N'T', 1200, N'O', N'at nulla')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (281, 282, 5, 14488, N'1G6KD57Y59U195480', 130000, 2007, N'W', N'pl ', N'N', 1300, N'G', N'ante vestibulum ante')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (282, 16, 1, 93422, N'WBA3A5C52FP609487', 300000, 1986, N'W', N'us ', N'N', 4000, N'G', N'sed vestibulum sit')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (283, 62, 3, 112000, N'1GYUCHEFXAR032529', 300000, 2005, N'S', N'us ', N'N', 1800, N'B', N'tempus semper est')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (284, 177, 2, 69515, N'5TDDK4CC3AS766697', 100000, 1986, N'W', N'gb ', N'T', 1300, N'G', N'lectus pellentesque')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (285, 155, 4, 50944, N'19XFA1E57AE251835', 300000, 2012, N'W', N'pl ', N'T', 1200, N'O', N'non sodales sed')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (286, 119, 3, 13274, N'3C4PDCDG7DT327533', 60000, 2010, N'W', N'gb ', N'T', 1200, N'B', N'mattis egestas metus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (287, 110, 1, 30870, N'5N1AR2MMXDC343210', 30000, 2011, N'S', N'de ', N'N', 1200, N'G', N'proin eu')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (288, 202, 1, 7238, N'3FADP4AJ3BM778035', 130000, 2011, N'W', N'gb ', N'N', 1300, N'O', N'platea dictumst maecenas')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (289, 141, 1, 73156, N'19XFA1E81AE579343', 100000, 2007, N'W', N'de ', N'N', 1100, N'B', N'dolor vel')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (290, 137, 5, 134338, N'JTHBE1D25E5976957', 130000, 1999, N'W', N'de ', N'T', 1800, N'G', N'non ligula')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (291, 273, 3, 26308, N'SCBBR93W79C573480', 200000, 2012, N'S', N'us ', N'N', 1500, N'B', N'vulputate nonummy maecenas')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (292, 22, 5, 73115, N'WDDHH8HB2BA675089', 80000, 1999, N'W', N'gb ', N'T', 1000, N'O', N'mus etiam')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (293, 265, 2, 110134, N'4T1BK1EB0FU821437', 30000, 2012, N'W', N'us ', N'N', 1800, N'B', N'dis parturient montes')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (294, 110, 4, 122822, N'3FAHP0DC7AR520450', 80000, 1992, N'W', N'us ', N'N', 1200, N'B', N'in faucibus orci')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (295, 186, 4, 57979, N'JN1CV6EK1BM470869', 80000, 1999, N'S', N'us ', N'N', 2000, N'B', N'sit amet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (296, 106, 2, 131893, N'19UUA65666A439884', 100000, 1993, N'W', N'de ', N'T', 3000, N'O', N'aenean fermentum donec')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (297, 234, 2, 14215, N'WAUKG94F06N912806', 100000, 2007, N'W', N'gb ', N'N', 1200, N'B', N'est donec')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (298, 196, 2, 78565, N'1G6KE54Y35U731595', 60000, 1996, N'W', N'gb ', N'N', 2000, N'B', N'morbi non lectus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (299, 39, 3, 140065, N'JH4KC1F53EC935543', 300000, 2001, N'S', N'us ', N'N', 1000, N'O', N'sit amet turpis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (300, 172, 5, 72836, N'5TDBKRFH9ES682708', 200000, 1991, N'W', N'gb ', N'T', 4000, N'B', N'purus sit amet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (301, 74, 5, 130411, N'WBAYF8C51DD025816', 130000, 2006, N'W', N'us ', N'N', 4000, N'G', N'tellus semper interdum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (302, 160, 3, 51457, N'KM8NU4CC7CU186958', 200000, 1985, N'W', N'pl ', N'N', 1300, N'G', N'nisi eu orci')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (303, 194, 1, 100382, N'3VW4A7AT5DM869662', 12000, 2006, N'S', N'gb ', N'N', 1200, N'G', N'mus vivamus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (304, 117, 3, 94872, N'4JGBB9FB9AA579772', 12000, 2007, N'W', N'us ', N'T', 2000, N'B', N'sagittis sapien')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (305, 240, 1, 128102, N'WBANB33595B445841', 30000, 2006, N'W', N'gb ', N'T', 3000, N'B', N'aenean auctor gravida')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (306, 25, 4, 56268, N'3GYFNAEY8BS296973', 80000, 2012, N'W', N'gb ', N'T', 2000, N'O', N'sociis natoque penatibus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (307, 1, 1, 87484, N'1G4GF5G39FF424837', 12000, 2002, N'S', N'de ', N'N', 1000, N'G', N'velit nec')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (308, 92, 1, 138326, N'JTJBARBZ2F2371144', 130000, 2001, N'W', N'pl ', N'N', 1800, N'O', N'tortor sollicitudin mi')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (309, 115, 3, 73422, N'JH4NA21695S169364', 300000, 2005, N'W', N'pl ', N'N', 2000, N'G', N'nisi venenatis tristique')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (310, 205, 2, 24720, N'5GAKRCKD3DJ262306', 100000, 2002, N'W', N'gb ', N'N', 3000, N'B', N'augue quam sollicitudin')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (311, 193, 1, 91760, N'1N6AF0LY2FN628431', 200000, 2011, N'S', N'de ', N'N', 3000, N'O', N'venenatis lacinia')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (312, 66, 4, 26957, N'3D73M4EL0BG947250', 80000, 2009, N'W', N'pl ', N'N', 4000, N'B', N'adipiscing elit proin')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (313, 58, 3, 28204, N'1N6BF0KX4FN583764', 80000, 1996, N'W', N'gb ', N'T', 3000, N'O', N'in blandit ultrices')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (314, 152, 2, 97904, N'2G61R5S35F9201005', 200000, 2001, N'W', N'gb ', N'T', 2000, N'G', N'ullamcorper augue a')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (315, 9, 3, 78782, N'WBAPK73529A922184', 100000, 2004, N'S', N'de ', N'T', 3000, N'B', N'id nisl')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (316, 276, 1, 64625, N'2C3CCAKG0EH799452', 12000, 2002, N'W', N'de ', N'N', 1600, N'G', N'viverra pede')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (317, 72, 3, 130948, N'1GYUCKEF0AR181013', 200000, 2000, N'W', N'us ', N'T', 1100, N'G', N'nisi eu orci')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (318, 264, 1, 107086, N'WAU3GAFD2FN177683', 80000, 2009, N'W', N'gb ', N'N', 1100, N'G', N'nulla neque libero')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (319, 5, 3, 129188, N'3C3CFFCR8DT602196', 80000, 2000, N'S', N'us ', N'N', 1800, N'G', N'curae nulla dapibus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (320, 124, 5, 16496, N'JM3TB2BA5B0970672', 80000, 2010, N'W', N'pl ', N'T', 1800, N'B', N'posuere metus vitae')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (321, 109, 3, 140555, N'1GYS4RKJ0FR000652', 300000, 1988, N'W', N'gb ', N'N', 3000, N'G', N'est congue elementum')
GO
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (322, 124, 4, 123743, N'2G4WE537951027044', 12000, 2008, N'W', N'de ', N'N', 1800, N'B', N'nam ultrices libero')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (323, 216, 1, 77631, N'WAUR4AFDXCN440937', 80000, 2002, N'S', N'gb ', N'T', 1100, N'O', N'egestas metus aenean')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (324, 90, 1, 95644, N'5TDBK3EH1BS126743', 30000, 2009, N'W', N'us ', N'N', 1200, N'O', N'donec pharetra')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (325, 276, 2, 73865, N'1GYFC13249R948022', 130000, 1988, N'W', N'gb ', N'T', 1800, N'O', N'condimentum curabitur')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (326, 104, 3, 126476, N'JH4CU2F43EC272053', 30000, 1998, N'W', N'gb ', N'N', 4000, N'G', N'nec condimentum neque')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (327, 137, 2, 70688, N'19XFB4F23FE015001', 80000, 1994, N'S', N'pl ', N'T', 1100, N'B', N'at nibh in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (328, 7, 1, 30196, N'5UXZV4C54CL255601', 60000, 1989, N'W', N'pl ', N'N', 1600, N'G', N'eleifend donec ut')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (329, 123, 2, 78194, N'JTHBE5C29A2641320', 60000, 1985, N'W', N'us ', N'N', 3000, N'O', N'nunc viverra dapibus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (330, 61, 5, 53539, N'3D7LT2ET3BG890520', 12000, 2003, N'W', N'gb ', N'N', 1300, N'B', N'curae nulla')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (331, 242, 1, 36301, N'1C4RDJDG2DC441061', 12000, 2002, N'S', N'gb ', N'N', 1200, N'B', N'integer aliquet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (332, 133, 5, 112234, N'KNADM4A33D6128576', 30000, 1995, N'W', N'de ', N'T', 2000, N'B', N'commodo placerat praesent')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (333, 93, 2, 54780, N'1FTSW2A50AE438175', 80000, 2006, N'W', N'us ', N'N', 2000, N'O', N'primis in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (334, 124, 3, 114055, N'WAUMR94E38N961320', 200000, 1963, N'W', N'pl ', N'T', 1000, N'B', N'morbi vestibulum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (335, 266, 2, 18007, N'5N1AN0NU2AC844182', 100000, 2011, N'S', N'de ', N'T', 3000, N'G', N'ultrices posuere cubilia')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (336, 45, 3, 76865, N'JH4CU26609C835857', 300000, 2008, N'W', N'us ', N'T', 1100, N'O', N'erat fermentum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (337, 222, 4, 47721, N'SALSF2D47DA280685', 30000, 2009, N'W', N'de ', N'T', 2000, N'O', N'tellus semper')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (338, 84, 3, 68698, N'KNADN5A35F6138001', 12000, 2000, N'W', N'us ', N'N', 1000, N'O', N'morbi vel')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (339, 199, 3, 105654, N'WAU3GAFD7FN753879', 30000, 1999, N'S', N'gb ', N'T', 1600, N'B', N'feugiat non')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (340, 265, 3, 102174, N'WBAEW53433P780195', 130000, 2012, N'W', N'de ', N'N', 1500, N'G', N'molestie nibh in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (341, 31, 5, 101880, N'5YMGY0C54BL860345', 130000, 1999, N'W', N'pl ', N'N', 1500, N'B', N'pede justo eu')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (342, 127, 5, 148196, N'WAU2MAFC0EN412981', 30000, 1984, N'W', N'pl ', N'T', 3000, N'B', N'donec ut mauris')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (343, 68, 2, 59155, N'5J8TB4H54GL320284', 60000, 2011, N'S', N'pl ', N'T', 3000, N'B', N'quisque erat eros')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (344, 4, 2, 76869, N'SCFAD22393K856726', 200000, 1986, N'W', N'us ', N'T', 3000, N'G', N'auctor sed tristique')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (345, 109, 4, 29853, N'JN8BS1MW0EM256991', 100000, 2011, N'W', N'de ', N'T', 1600, N'B', N'quis justo')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (346, 113, 1, 27011, N'WBSDX9C52BE954174', 60000, 2003, N'W', N'us ', N'N', 1100, N'O', N'tortor quis turpis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (347, 95, 5, 22447, N'1G6DF8EY7B0298517', 300000, 1994, N'S', N'de ', N'T', 1600, N'O', N'sem praesent id')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (348, 279, 1, 33932, N'WAUZL64B31N515931', 30000, 1999, N'W', N'pl ', N'N', 1200, N'B', N'vivamus tortor duis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (349, 32, 1, 135747, N'WBAEH73494B636087', 100000, 1996, N'W', N'us ', N'N', 1200, N'B', N'bibendum felis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (350, 249, 4, 107739, N'WBAEN33445E809760', 12000, 2012, N'S', N'de ', N'T', 1600, N'G', N'integer aliquet massa')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (351, 62, 5, 129067, N'JM1GJ1T66E1178580', 60000, 1998, N'W', N'us ', N'T', 1200, N'B', N'sed ante')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (352, 269, 5, 19024, N'1G6DM57N830788151', 12000, 1986, N'W', N'gb ', N'T', 2000, N'B', N'primis in faucibus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (353, 74, 2, 55222, N'WA1LGBFE5CD040332', 100000, 2003, N'W', N'de ', N'N', 1100, N'B', N'vulputate vitae')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (354, 71, 2, 131173, N'2B3CA3CV2AH331180', 30000, 2003, N'S', N'de ', N'N', 4000, N'G', N'vestibulum velit id')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (355, 140, 1, 39750, N'3VWJX7AJ4AM906647', 60000, 1999, N'W', N'pl ', N'T', 1200, N'G', N'at nunc')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (356, 242, 4, 118586, N'2GKALMEK3C6972141', 60000, 1957, N'W', N'de ', N'T', 1800, N'O', N'ipsum dolor sit')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (357, 165, 3, 39973, N'SCBLC43F96C783809', 200000, 2010, N'W', N'de ', N'N', 3000, N'B', N'nam tristique tortor')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (358, 191, 3, 114047, N'3D7TP2CT3BG061518', 60000, 1999, N'S', N'gb ', N'N', 1800, N'O', N'rhoncus aliquam lacus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (359, 102, 1, 78825, N'WAUCD54B24N519678', 80000, 2013, N'W', N'de ', N'T', 1200, N'G', N'vel augue vestibulum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (360, 295, 5, 121395, N'SCFAB42352K290046', 130000, 1989, N'W', N'pl ', N'N', 1500, N'O', N'scelerisque mauris sit')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (361, 142, 4, 68588, N'WAUDK78T58A053914', 300000, 2007, N'W', N'us ', N'N', 1100, N'G', N'cursus id')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (362, 48, 5, 140444, N'WAUJC68E25A141178', 200000, 2008, N'S', N'pl ', N'N', 1300, N'O', N'in hac')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (363, 64, 1, 22530, N'SCFHDDAJ0BA341340', 200000, 2005, N'W', N'de ', N'T', 4000, N'O', N'vehicula condimentum curabitur')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (364, 162, 1, 33498, N'SAJWA4DC2FM763126', 80000, 1992, N'W', N'gb ', N'N', 3000, N'B', N'mus vivamus vestibulum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (365, 168, 4, 116674, N'1G4GD5GR5CF103481', 80000, 1984, N'W', N'gb ', N'N', 1200, N'B', N'bibendum felis sed')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (366, 207, 4, 109843, N'1FTEX1CM2DK418525', 80000, 1998, N'S', N'gb ', N'T', 1300, N'B', N'vehicula consequat morbi')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (367, 203, 1, 110481, N'KMHHT6KD1BU393480', 80000, 2003, N'W', N'de ', N'T', 4000, N'B', N'convallis nulla neque')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (368, 146, 1, 62940, N'1D7RB1CT2AS786120', 100000, 2001, N'W', N'de ', N'N', 1000, N'B', N'ipsum primis in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (369, 158, 4, 93963, N'WBAEV33432K698650', 30000, 2003, N'W', N'gb ', N'N', 3000, N'O', N'tincidunt in leo')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (370, 85, 1, 67975, N'3C4PDDEG5DT634672', 80000, 1992, N'S', N'de ', N'T', 1600, N'O', N'ligula suspendisse')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (371, 88, 2, 66701, N'WAUAF78E98A802562', 30000, 1971, N'W', N'de ', N'N', 1200, N'B', N'vestibulum ante ipsum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (372, 292, 5, 28226, N'JN1AZ4EH7FM087934', 100000, 2003, N'W', N'de ', N'N', 1500, N'B', N'sit amet eleifend')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (373, 160, 4, 149626, N'KMHGC4DD0DU830224', 60000, 2008, N'W', N'de ', N'T', 1500, N'G', N'aliquam convallis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (374, 175, 5, 117476, N'1G6KS54YX3U091424', 80000, 2013, N'S', N'pl ', N'T', 2000, N'O', N'ipsum primis in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (375, 126, 2, 130558, N'2T2BK1BA6BC181432', 200000, 2003, N'W', N'gb ', N'N', 4000, N'B', N'pede ullamcorper')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (376, 114, 3, 82287, N'1GD312CG7CF082868', 130000, 2008, N'W', N'us ', N'N', 1800, N'G', N'ultrices erat tortor')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (377, 219, 4, 39306, N'WDDEJ7EB6CA017122', 300000, 1995, N'W', N'us ', N'T', 4000, N'B', N'sed augue')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (378, 268, 4, 54800, N'JHMFA3F23BS909664', 60000, 1993, N'S', N'gb ', N'T', 1100, N'G', N'nec sem')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (379, 214, 1, 129992, N'WP0AB2A88CU744733', 100000, 2010, N'W', N'us ', N'T', 1800, N'B', N'sapien cursus vestibulum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (380, 33, 5, 81064, N'2T1KE4EE1AC802358', 100000, 2011, N'W', N'pl ', N'N', 1800, N'G', N'orci pede')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (381, 200, 4, 58720, N'KNDJT2A21D7820138', 130000, 1994, N'W', N'us ', N'N', 1800, N'B', N'cubilia curae nulla')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (382, 104, 4, 120389, N'1G6DN8EV9A0639472', 80000, 2003, N'S', N'gb ', N'T', 4000, N'G', N'amet lobortis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (383, 177, 3, 7656, N'WBAGL635X5D044438', 200000, 1996, N'W', N'us ', N'N', 3000, N'G', N'adipiscing lorem vitae')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (384, 202, 4, 48655, N'YV4960DL6A2348754', 300000, 2007, N'W', N'pl ', N'N', 1300, N'O', N'ut blandit')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (385, 137, 5, 119663, N'1FTEW1C87AF131871', 60000, 2008, N'W', N'de ', N'T', 1300, N'B', N'nec molestie')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (386, 71, 2, 29811, N'YV126MECXF1337435', 200000, 2007, N'S', N'de ', N'T', 4000, N'G', N'duis at')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (387, 266, 4, 37909, N'WAULFAFHXEN389512', 200000, 2001, N'W', N'us ', N'N', 1600, N'B', N'dui vel nisl')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (388, 125, 5, 24718, N'JN1CV6EL1FM816062', 100000, 1995, N'W', N'pl ', N'T', 1500, N'B', N'sit amet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (389, 160, 5, 114393, N'5TDBK3EH1CS026658', 300000, 2007, N'S', N'pl ', N'T', 1000, N'G', N'mauris laoreet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (390, 279, 3, 24306, N'WUAW2AFC4EN718773', 80000, 2013, N'W', N'gb ', N'T', 4000, N'B', N'donec quis orci')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (391, 35, 5, 16501, N'SAJWA4GB2EL320658', 60000, 2008, N'W', N'gb ', N'T', 1100, N'B', N'neque libero convallis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (392, 119, 1, 109074, N'WBAWR3C54AP495883', 300000, 2004, N'S', N'de ', N'N', 1000, N'G', N'nam nulla')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (393, 25, 3, 108325, N'2G61V5S37D9554743', 30000, 2000, N'W', N'de ', N'T', 1000, N'G', N'consequat lectus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (394, 82, 4, 26567, N'WBAFU7C55DD727032', 130000, 1992, N'W', N'de ', N'N', 1300, N'O', N'porttitor lorem')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (395, 187, 2, 142420, N'1FTEX1E81AK663831', 130000, 2001, N'S', N'de ', N'N', 1200, N'O', N'ornare imperdiet sapien')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (396, 26, 1, 42433, N'JTHBB1BA4A2386585', 12000, 1996, N'W', N'pl ', N'T', 1000, N'O', N'vestibulum aliquet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (397, 250, 1, 139088, N'JN8AF5MR3ET711842', 300000, 1999, N'W', N'us ', N'N', 2000, N'O', N'in faucibus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (398, 65, 2, 130971, N'4T1BK1EB6FU861327', 30000, 1999, N'W', N'de ', N'T', 1100, N'O', N'accumsan felis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (399, 208, 3, 11332, N'WAUEFAFL8FN460916', 130000, 2011, N'W', N'de ', N'N', 1500, N'O', N'convallis nunc')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (400, 140, 3, 21466, N'WDBWK5JA1BF817825', 30000, 2011, N'W', N'us ', N'N', 1600, N'B', N'non sodales sed')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (401, 199, 3, 22674, N'KNAFT4A24A5065573', 300000, 2011, N'W', N'us ', N'N', 1100, N'G', N'pellentesque ultrices')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (402, 131, 3, 140017, N'4T3BA3BB7AU345948', 300000, 1984, N'W', N'us ', N'T', 1100, N'B', N'vestibulum quam sapien')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (403, 178, 1, 29822, N'1N6AA0CA5DN994592', 130000, 1963, N'W', N'gb ', N'N', 4000, N'B', N'cubilia curae')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (404, 125, 3, 137003, N'3GTU1YEJ6BG832990', 80000, 1991, N'W', N'pl ', N'T', 2000, N'G', N'ridiculus mus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (405, 252, 1, 132360, N'JN8CS1MU2EM158869', 30000, 1988, N'W', N'pl ', N'T', 3000, N'G', N'adipiscing elit')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (406, 226, 2, 71193, N'WBSDX9C5XDE985353', 12000, 1995, N'W', N'us ', N'T', 1800, N'O', N'lacinia erat vestibulum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (407, 74, 1, 50487, N'2HNYD18744H207808', 12000, 2013, N'W', N'pl ', N'T', 4000, N'B', N'pretium nisl ut')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (408, 156, 3, 142991, N'WBAET37463N315249', 100000, 1992, N'W', N'us ', N'N', 1800, N'G', N'vestibulum sit amet')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (409, 277, 4, 90238, N'WA1EY74L37D903977', 200000, 1995, N'W', N'de ', N'T', 1300, N'G', N'sem sed sagittis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (410, 183, 2, 102842, N'WAUGU44D53N353216', 80000, 1992, N'W', N'pl ', N'N', 1600, N'B', N'ante vel')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (411, 4, 1, 54678, N'JH4CU25699C929348', 12000, 1995, N'W', N'de ', N'T', 1000, N'B', N'enim leo')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (412, 59, 4, 16484, N'2G4GN5EX8F9833316', 130000, 1993, N'W', N'pl ', N'N', 1200, N'B', N'velit nec')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (413, 52, 5, 32327, N'WAUBF98E47A409910', 12000, 1999, N'W', N'us ', N'N', 1500, N'O', N'in felis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (414, 17, 5, 46655, N'5UXWZ7C57F0577518', 130000, 2012, N'W', N'de ', N'T', 1800, N'B', N'aliquet maecenas')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (415, 289, 4, 130596, N'WAUBFCFL2CA767354', 12000, 1988, N'W', N'pl ', N'T', 1300, N'B', N'faucibus orci')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (416, 72, 4, 82132, N'2LMHJ5AT6CB618822', 130000, 2003, N'W', N'gb ', N'T', 2000, N'O', N'lorem ipsum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (417, 37, 4, 149611, N'19UYA42712A960170', 200000, 1998, N'R', N'gb ', N'N', 2000, N'G', N'vel lectus in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (418, 99, 3, 67789, N'3N1CN7AP6EK903193', 12000, 2004, N'R', N'pl ', N'N', 2000, N'O', N'quis turpis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (419, 177, 3, 95890, N'WA1WYBFE9AD902250', 300000, 1995, N'W', N'gb ', N'N', 1600, N'G', N'amet erat nulla')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (420, 300, 3, 55993, N'WBA3V5C55EJ292763', 60000, 2004, N'W', N'gb ', N'N', 1200, N'G', N'vel enim')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (421, 21, 2, 97403, N'3N1AB7AP0FL269987', 80000, 1995, N'W', N'de ', N'T', 4000, N'O', N'nisl nunc rhoncus')
GO
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (422, 190, 3, 106238, N'WUAGNAFG3CN898050', 30000, 2008, N'W', N'gb ', N'N', 2000, N'O', N'sem sed sagittis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (423, 238, 5, 74830, N'1HGCP2E39CA869154', 200000, 2007, N'W', N'gb ', N'N', 1000, N'O', N'mi nulla')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (424, 212, 1, 115497, N'WAUVT68E23A441561', 80000, 1993, N'W', N'pl ', N'N', 1500, N'G', N'purus eu')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (425, 99, 1, 103198, N'WBAGG834X1D912052', 130000, 1994, N'W', N'pl ', N'T', 1300, N'O', N'pellentesque volutpat')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (426, 19, 3, 125490, N'1D4PU7GX3BW673950', 300000, 2008, N'W', N'pl ', N'T', 1600, N'O', N'pellentesque eget')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (427, 231, 4, 120231, N'SCBLC37FX3C125187', 30000, 2004, N'W', N'de ', N'T', 1500, N'O', N'sem praesent id')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (428, 13, 2, 96786, N'TRUUT28N941465080', 30000, 1984, N'W', N'pl ', N'N', 1300, N'G', N'faucibus orci luctus')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (429, 66, 5, 98574, N'VNKJTUD33FA885683', 300000, 1976, N'W', N'de ', N'N', 1200, N'G', N'interdum venenatis turpis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (430, 39, 3, 95254, N'1FTWX3B54AE243571', 12000, 1990, N'W', N'us ', N'N', 1100, N'O', N'amet nulla')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (431, 86, 3, 43882, N'WVGFG9BP5CD233952', 100000, 2004, N'W', N'us ', N'N', 1000, N'B', N'adipiscing molestie hendrerit')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (432, 17, 5, 138887, N'YV1952AS5E1805993', 12000, 2001, N'W', N'pl ', N'T', 1500, N'B', N'hac habitasse')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (433, 138, 4, 39376, N'1GYS3AEF3BR429113', 30000, 1994, N'W', N'gb ', N'N', 1300, N'G', N'sapien ut')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (434, 122, 2, 120855, N'2T1KE4EEXCC844577', 60000, 2009, N'W', N'gb ', N'N', 1000, N'B', N'eu tincidunt in')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (435, 24, 4, 79856, N'5GAER13D59J933448', 200000, 2007, N'W', N'us ', N'T', 1600, N'B', N'aliquam erat volutpat')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (436, 125, 5, 82083, N'WVWED7AJ8CW320887', 200000, 2001, N'W', N'pl ', N'T', 1100, N'B', N'diam erat')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (437, 135, 2, 137147, N'5FNRL5H26CB105813', 100000, 2004, N'W', N'de ', N'T', 1300, N'G', N'pede lobortis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (438, 250, 3, 10801, N'1FTKR1AD2AP168752', 60000, 1986, N'W', N'us ', N'N', 2000, N'G', N'lectus in est')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (439, 230, 2, 114494, N'WAULT58E42A258078', 60000, 1994, N'W', N'us ', N'T', 1200, N'B', N'in hac habitasse')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (440, 156, 3, 39162, N'WVWEU9AN9AE506679', 100000, 1995, N'W', N'gb ', N'N', 1500, N'B', N'magnis dis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (441, 293, 4, 92349, N'JH4DC54856S751869', 12000, 1993, N'W', N'us ', N'T', 4000, N'O', N'pretium iaculis')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (442, 159, 1, 58009, N'1C6RD7LP2CS803549', 30000, 2007, N'W', N'us ', N'T', 4000, N'O', N'erat fermentum')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (443, 206, 1, 63473, N'JA4AP3AU4CZ161593', 60000, 2012, N'W', N'gb ', N'T', 1100, N'O', N'venenatis turpis enim')
INSERT [dbo].[samochody_na_sprzedaz] ([id_samochod], [id_model], [id_nadwozie], [cena], [vin], [przebieg], [data_produkcji], [status], [kraj_pochodzenia], [ksiazka_serwisowa], [pojemnosc], [paliwo], [sam_informacje_dodatkowe]) VALUES (444, 263, 3, 39638, N'5GAKVBKD1EJ073662', 12000, 2012, N'W', N'de ', N'T', 1800, N'O', N'accumsan tortor')
SET IDENTITY_INSERT [dbo].[samochody_na_sprzedaz] OFF
SET IDENTITY_INSERT [dbo].[sprzedane] ON 

INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (1, 223, 26, 50000, N'L', CAST(N'2018-04-02' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (2, 227, 29, 100000, N'L', CAST(N'2017-10-20' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (3, 231, 32, 45000, N'L', CAST(N'2017-05-10' AS Date), N'T', 1)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (4, 235, 35, 15000, N'L', CAST(N'2017-05-28' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (5, 239, 38, 140000, N'L', CAST(N'2017-10-07' AS Date), N'T', 1)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (6, 243, 41, 80000, N'L', CAST(N'2017-11-02' AS Date), N'T', 3)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (7, 247, 44, 50000, N'G', CAST(N'2017-07-03' AS Date), N'T', 1)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (8, 251, 47, 50000, N'L', CAST(N'2017-10-21' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (9, 255, 50, 50000, N'L', CAST(N'2018-04-04' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (10, 259, 53, 45000, N'K', CAST(N'2018-02-14' AS Date), N'T', 6)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (11, 263, 56, 100000, N'G', CAST(N'2017-04-26' AS Date), N'T', 6)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (12, 267, 59, 100000, N'G', CAST(N'2017-11-04' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (13, 271, 62, 50000, N'G', CAST(N'2017-12-09' AS Date), N'T', 6)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (14, 275, 65, 140000, N'K', CAST(N'2018-02-09' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (15, 279, 68, 80000, N'K', CAST(N'2017-10-14' AS Date), N'T', 2)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (16, 283, 71, 50000, N'K', CAST(N'2018-03-08' AS Date), N'T', 3)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (17, 287, 74, 20000, N'K', CAST(N'2017-09-08' AS Date), N'T', 6)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (18, 291, 77, 140000, N'L', CAST(N'2017-06-29' AS Date), N'T', 6)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (19, 295, 80, 100000, N'K', CAST(N'2017-11-06' AS Date), N'T', 3)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (20, 299, 83, 100000, N'L', CAST(N'2017-07-15' AS Date), N'T', 6)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (21, 303, 86, 30000, N'K', CAST(N'2017-07-09' AS Date), N'T', 1)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (22, 307, 89, 15000, N'L', CAST(N'2018-03-11' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (23, 311, 92, 140000, N'K', CAST(N'2017-12-27' AS Date), N'T', 6)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (24, 315, 95, 20000, N'G', CAST(N'2017-09-25' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (25, 319, 98, 80000, N'K', CAST(N'2018-02-01' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (26, 323, 101, 80000, N'G', CAST(N'2017-08-01' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (27, 327, 104, 20000, N'G', CAST(N'2018-04-11' AS Date), N'T', 2)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (28, 331, 107, 100000, N'L', CAST(N'2017-10-21' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (29, 335, 110, 140000, N'K', CAST(N'2018-02-12' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (30, 339, 113, 50000, N'K', CAST(N'2017-07-03' AS Date), N'T', 1)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (31, 343, 116, 30000, N'G', CAST(N'2018-04-10' AS Date), N'T', 2)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (32, 347, 119, 10000, N'K', CAST(N'2017-09-27' AS Date), N'T', 2)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (33, 351, 122, 50000, N'G', CAST(N'2017-09-01' AS Date), N'T', 3)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (34, 355, 125, 50000, N'K', CAST(N'2017-08-22' AS Date), N'T', 1)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (35, 359, 128, 15000, N'G', CAST(N'2017-05-04' AS Date), N'T', 2)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (36, 363, 131, 50000, N'K', CAST(N'2017-12-05' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (37, 367, 134, 45000, N'L', CAST(N'2017-06-25' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (38, 371, 137, 50000, N'G', CAST(N'2017-09-21' AS Date), N'T', 1)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (39, 375, 140, 100000, N'L', CAST(N'2017-08-07' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (40, 379, 143, 10000, N'K', CAST(N'2018-02-25' AS Date), N'T', 1)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (41, 383, 146, 50000, N'K', CAST(N'2018-03-26' AS Date), N'T', 5)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (42, 387, 149, 45000, N'G', CAST(N'2017-08-02' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (43, 391, 152, 80000, N'K', CAST(N'2017-10-22' AS Date), N'T', 4)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (44, 395, 155, 20000, N'K', CAST(N'2017-04-13' AS Date), N'T', 3)
INSERT [dbo].[sprzedane] ([id_sprzedazy], [id_samochod], [id_klient], [cena], [typ_platnosci], [data], [status], [id_sprzedawcy]) VALUES (45, 240, 199, 99000, N't', CAST(N'2018-06-06' AS Date), N'S', 1)
SET IDENTITY_INSERT [dbo].[sprzedane] OFF
SET IDENTITY_INSERT [dbo].[typ_nadwozia] ON 

INSERT [dbo].[typ_nadwozia] ([id_nadwozie], [nadwozie_typ], [nadw_informacje_dodatkowe]) VALUES (1, N'sedan               ', NULL)
INSERT [dbo].[typ_nadwozia] ([id_nadwozie], [nadwozie_typ], [nadw_informacje_dodatkowe]) VALUES (2, N'kombi               ', NULL)
INSERT [dbo].[typ_nadwozia] ([id_nadwozie], [nadwozie_typ], [nadw_informacje_dodatkowe]) VALUES (3, N'kabriolet           ', NULL)
INSERT [dbo].[typ_nadwozia] ([id_nadwozie], [nadwozie_typ], [nadw_informacje_dodatkowe]) VALUES (4, N'terenowy            ', NULL)
INSERT [dbo].[typ_nadwozia] ([id_nadwozie], [nadwozie_typ], [nadw_informacje_dodatkowe]) VALUES (5, N'suv                 ', NULL)
INSERT [dbo].[typ_nadwozia] ([id_nadwozie], [nadwozie_typ], [nadw_informacje_dodatkowe]) VALUES (6, N'limuzyna            ', NULL)
SET IDENTITY_INSERT [dbo].[typ_nadwozia] OFF
ALTER TABLE [dbo].[klient_dane]  WITH CHECK ADD  CONSTRAINT [FK_klient_dane_klient] FOREIGN KEY([id_klient])
REFERENCES [dbo].[klient] ([id_klienta])
GO
ALTER TABLE [dbo].[klient_dane] CHECK CONSTRAINT [FK_klient_dane_klient]
GO
ALTER TABLE [dbo].[klient_preferencje]  WITH CHECK ADD  CONSTRAINT [FK_klient_preferencje_klient] FOREIGN KEY([id_klient])
REFERENCES [dbo].[klient] ([id_klienta])
GO
ALTER TABLE [dbo].[klient_preferencje] CHECK CONSTRAINT [FK_klient_preferencje_klient]
GO
ALTER TABLE [dbo].[powiazanie_wyposazenie_samochod]  WITH CHECK ADD  CONSTRAINT [FK_powiazanie_wyposazenie_samochod_samochod_wyposazenie] FOREIGN KEY([id_wyposazenie])
REFERENCES [dbo].[samochod_wyposazenie] ([id_wyposazenie])
GO
ALTER TABLE [dbo].[powiazanie_wyposazenie_samochod] CHECK CONSTRAINT [FK_powiazanie_wyposazenie_samochod_samochod_wyposazenie]
GO
ALTER TABLE [dbo].[powiazanie_wyposazenie_samochod]  WITH CHECK ADD  CONSTRAINT [FK_powiazanie_wyposazenie_samochod_samochody_na_sprzedaz] FOREIGN KEY([id_samochod])
REFERENCES [dbo].[samochody_na_sprzedaz] ([id_samochod])
GO
ALTER TABLE [dbo].[powiazanie_wyposazenie_samochod] CHECK CONSTRAINT [FK_powiazanie_wyposazenie_samochod_samochody_na_sprzedaz]
GO
ALTER TABLE [dbo].[rezerwacje]  WITH CHECK ADD  CONSTRAINT [FK_rezerwacje_samochody_na_sprzedaz] FOREIGN KEY([id_samochodu])
REFERENCES [dbo].[samochody_na_sprzedaz] ([id_samochod])
GO
ALTER TABLE [dbo].[rezerwacje] CHECK CONSTRAINT [FK_rezerwacje_samochody_na_sprzedaz]
GO
ALTER TABLE [dbo].[samochody_na_sprzedaz]  WITH CHECK ADD  CONSTRAINT [FK_samochody_na_sprzedaz_model] FOREIGN KEY([id_model])
REFERENCES [dbo].[model] ([id_model])
GO
ALTER TABLE [dbo].[samochody_na_sprzedaz] CHECK CONSTRAINT [FK_samochody_na_sprzedaz_model]
GO
ALTER TABLE [dbo].[samochody_na_sprzedaz]  WITH CHECK ADD  CONSTRAINT [FK_samochody_na_sprzedaz_typ_nadwozia] FOREIGN KEY([id_nadwozie])
REFERENCES [dbo].[typ_nadwozia] ([id_nadwozie])
GO
ALTER TABLE [dbo].[samochody_na_sprzedaz] CHECK CONSTRAINT [FK_samochody_na_sprzedaz_typ_nadwozia]
GO
ALTER TABLE [dbo].[sprzedane]  WITH CHECK ADD  CONSTRAINT [FK_sprzedane_klient] FOREIGN KEY([id_klient])
REFERENCES [dbo].[klient] ([id_klienta])
GO
ALTER TABLE [dbo].[sprzedane] CHECK CONSTRAINT [FK_sprzedane_klient]
GO
ALTER TABLE [dbo].[sprzedane]  WITH CHECK ADD  CONSTRAINT [FK_sprzedane_samochody_na_sprzedaz] FOREIGN KEY([id_samochod])
REFERENCES [dbo].[samochody_na_sprzedaz] ([id_samochod])
GO
ALTER TABLE [dbo].[sprzedane] CHECK CONSTRAINT [FK_sprzedane_samochody_na_sprzedaz]
GO
/****** Object:  StoredProcedure [dbo].[dodaj_klienta]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[dodaj_klienta] 

@imie varchar(15),@nazw varchar(20) ,@email varchar(20) , @kontakt  varchar (20),@typ char(1)
AS
BEGIN

declare 

	@output varchar(10),
	@login varchar(10),
	@haslo varchar(10)

exec gen_haslo_login @output output
set @login = @output
exec gen_haslo_login @output output


  IF @imie  is null or @nazw is null or @kontakt is null
    BEGIN
        PRINT 'BRAK ARGUMENTU'
        RETURN
    END

 IF exists (select * from klient where imie = @imie and nazwisko = @nazw)
    BEGIN
        PRINT 'uzytkownik' + @imie + @nazw + 'jest już w systemie'
        RETURN
    END


	IF exists (select * from klient where email = @email)
    BEGIN
        PRINT 'adres mejlowy ' + @email + 'jest już w systemie'
        RETURN
    END


	insert into klient (imie,nazwisko,email,kontakt,login,haslo,typ)
		values (@imie,@nazw,@email,@kontakt,@login,@output,@typ)
		BEGIN
       
		print ' twój login ' + @login + ' i hasło ' + @output

		end
end
GO
/****** Object:  StoredProcedure [dbo].[dodaj_samochod]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[dodaj_samochod] 

@id_model int,@id_nadwozie int ,@cena int , @vin varchar (30),@przebieg int ,@data_prod int ,@kraj_p char(3) , @ks char (1) , @pojemnosc int ,@paliwo char (1),@info varchar (50)
AS
BEGIN



  IF @id_model is null or @id_nadwozie is null or @cena is null or @vin is null 
  
    BEGIN
        PRINT 'BRAK ARGUMENTU'
        RETURN
    END

 IF exists (select id_samochod from samochody_na_sprzedaz where vin = @vin)
    BEGIN
        PRINT 'samochod' + @vin + 'jest już w systemie'
        RETURN
		
		END



	insert into samochody_na_sprzedaz (id_model,id_nadwozie,cena,vin,przebieg,data_produkcji,status,kraj_pochodzenia,ksiazka_serwisowa,pojemnosc,paliwo,sam_informacje_dodatkowe )
		values (@id_model,@id_nadwozie,@cena,@vin,@przebieg,@data_prod,'W',@kraj_p,@ks,@pojemnosc,@paliwo,@info)
		BEGIN
       
		set @id_model = (select id_samochod from samochody_na_sprzedaz where vin=@vin)
		print 'dodano nowy samochod do bazy - nr. ' + @id_model

		end
	

end
GO
/****** Object:  StoredProcedure [dbo].[gen_haslo_login]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[gen_haslo_login] 

@output varchar(10) output

as


declare @zakres int = 74
declare @min int = 48
declare @char char
declare @dlug int = 7


set @output = ''


while @dlug > 0 begin

	select @char = char(round(rand()*@zakres+@min,0))
	
	set @output += @char
	set @dlug =@dlug-1

	end
return 
GO
/****** Object:  StoredProcedure [dbo].[p_sprzedaz]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_sprzedaz] @id_s int , @id_k int,@cena int , @typ char (1), @data date, @status char(1),@id_sp int

as
begin



 IF exists (select * from samochody_na_sprzedaz where id_samochod=@id_s)

    BEGIN

		IF exists (select * from klient where id_klienta=@id_k)
    
			BEGIN
				

			  IF  (select status from samochody_na_sprzedaz where id_samochod=@id_s) = 'W' 

				BEGIN

					insert into sprzedane (id_samochod,id_klient,cena,typ_platnosci,data,status,id_sprzedawcy)
						values (@id_s,@id_k,@cena,@typ,@data,@status,@id_sp)

					
					update samochody_na_sprzedaz 
						set status = 'S'
						where id_samochod = @id_s

						
						
						 
						select (prod_nazwa + ' ' + model_nazwa) as sprzedany_model from [dbo].[v_samochody_sprzedane] where id_samochod=@id_s
						
						select (imie +' '+ nazwisko) as kupujący from [dbo].[v_klient_dane] where id_klienta=@id_k
						 
						select (imie +' '+ nazwisko) as sprzedawca from [dbo].[v_klient_dane] where id_klienta=@id_sp
       	
				END

				
			END
        		
	END

END
GO
/****** Object:  StoredProcedure [dbo].[p_szukaj_marki]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[p_szukaj_marki] @producent_samochod varchar(50)
AS
BEGIN
    IF @producent_samochod is null 
    BEGIN
            PRINT 'BRAK ARGUMENTU'
        RETURN
    END

    IF not exists (select * from v_samochody_do_sprzedania where  prod_nazwa = @producent_samochod)
		BEGIN
				PRINT 'BRAK TEGO MODELU ' + @producent_samochod
			RETURN
		END

   
    select * from v_samochody_do_sprzedania
    where prod_nazwa = @producent_samochod
END
GO
/****** Object:  StoredProcedure [dbo].[p_usun_klienta]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_usun_klienta] @nazwisko varchar(50)
AS
BEGIN

declare
@id_k int

	if @nazwisko is null
	 BEGIN
            PRINT 'BRAK ARGUMENTU'
            RETURN
    END

	
	set @id_k=(select id_klienta from klient where nazwisko=@nazwisko)

	if @id_k is null 
	begin 
	print 'nie ma takiego klienta'
	end


	delete from klient where nazwisko=@nazwisko
	delete from klient_dane where id_adres=@id_k

	

	
END
GO
/****** Object:  StoredProcedure [dbo].[p_usun_samochod]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_usun_samochod] @id int , @vin varchar (30)
AS
BEGIN


 IF @id is null and @vin is null  
  
    BEGIN
        PRINT 'BRAK ARGUMENTU'
        RETURN
    END
	
	
 IF not exists (select id_samochod from samochody_na_sprzedaz where vin = @vin or id_samochod = @id)
    BEGIN
        PRINT 'brak samochodu w bazie'
        RETURN
		
		END
	
	delete from samochody_na_sprzedaz where vin = @vin or id_samochod = @id


END
GO
/****** Object:  StoredProcedure [dbo].[p_wyszukiwanie_klienta]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[p_wyszukiwanie_klienta] @klient varchar(50)
AS
BEGIN
    IF @klient is null
    BEGIN
        PRINT 'BRAK ARGUMENTU'
        RETURN
    END
    
    IF not exists (select * from v_klient_dane where nazwisko = @klient)
    BEGIN
        PRINT 'klient ---' + str( @klient) + '--- NIE ISTNIEJE'
        RETURN
    END

    select * from v_klient_dane
    where nazwisko = @klient
END
GO
/****** Object:  StoredProcedure [dbo].[p_zmiena_rezerwacji]    Script Date: 05.06.2018 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_zmiena_rezerwacji] @id_samochod int , @status char(1),@id_klient int,@data date
AS
BEGIN
Declare
         @stary_status char(1)

IF @id_klient is null or @status is null
    BEGIN
            PRINT 'BRAK ARGUMENTU'
            RETURN
    END
    

	if @status='R'

		begin

		
			IF @data is null or @id_samochod is null or @data <= getdate()
				BEGIN
						PRINT 'BRAK ARGUMENTU'
						RETURN
				END


			 IF not exists (select * from v_samochody_do_sprzedania where id_samochod = @id_samochod)
				 BEGIN
				   PRINT 'BRAK samochodu ' + str( @id_samochod)
				 RETURN
				END

			 
			 IF not exists (select * from [dbo].[v_klient_dane] where id_klienta = @id_klient)
				 BEGIN
				   PRINT 'BRAK klienta o numerze ' + str( @id_samochod)
				 RETURN
				END

		
		insert into rezerwacje( id_klienta,id_samochodu,data_do)
				values (@id_klient,@id_samochod,@data)

		update samochody_na_sprzedaz 
			set status = @status
			where id_samochod = @id_samochod

	end

	else if @status='W'

	begin

	set @id_samochod = (select  id_samochodu from rezerwacje where id_klienta=@id_klient)

		update samochody_na_sprzedaz 
			set status = @status
			where id_samochod = @id_samochod


		delete from rezerwacje where id_klienta=@id_klient


	end


	else

	begin

	print 'W - usuwanie rezerwacji / R - dodanie rezerwacji '

    end

	end

 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "klient_preferencje"
            Begin Extent = 
               Top = 0
               Left = 291
               Bottom = 253
               Right = 590
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "klient"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 234
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_klienci_preferencje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_klienci_preferencje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "klient"
            Begin Extent = 
               Top = 13
               Left = 10
               Bottom = 234
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "klient_dane"
            Begin Extent = 
               Top = 7
               Left = 370
               Bottom = 223
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1995
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_klient_dane'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_klient_dane'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "v_samochody_do_sprzedania"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 255
               Right = 324
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_marki_na_stanie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_marki_na_stanie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "samochody_na_sprzedaz"
            Begin Extent = 
               Top = 55
               Left = 18
               Bottom = 259
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sprzedane"
            Begin Extent = 
               Top = 11
               Left = 404
               Bottom = 141
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "model"
            Begin Extent = 
               Top = 147
               Left = 489
               Bottom = 277
               Right = 738
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "klient"
            Begin Extent = 
               Top = 16
               Left = 757
               Bottom = 146
               Right = 927
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1785
         Width = 1500
         Width = 1950
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_raport_sprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_raport_sprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_raport_sprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "v_raport_sprzedaz"
            Begin Extent = 
               Top = 7
               Left = 160
               Bottom = 259
               Right = 385
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1845
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_raport_typu_platnosci'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_raport_typu_platnosci'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "klient"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "model"
            Begin Extent = 
               Top = 141
               Left = 561
               Bottom = 271
               Right = 810
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rezerwacje"
            Begin Extent = 
               Top = 6
               Left = 533
               Bottom = 136
               Right = 703
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "samochody_na_sprzedaz"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 9
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1725
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_rezerwacje_klient_samochod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_rezerwacje_klient_samochod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_rezerwacje_klient_samochod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "model"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 235
               Right = 287
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "samochody_na_sprzedaz"
            Begin Extent = 
               Top = 6
               Left = 325
               Bottom = 245
               Right = 562
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "typ_nadwozia"
            Begin Extent = 
               Top = 6
               Left = 600
               Bottom = 119
               Right = 844
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_samochody_do_sprzedania'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_samochody_do_sprzedania'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "model"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 287
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "samochody_na_sprzedaz"
            Begin Extent = 
               Top = 23
               Left = 329
               Bottom = 257
               Right = 566
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "typ_nadwozia"
            Begin Extent = 
               Top = 6
               Left = 600
               Bottom = 222
               Right = 844
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_samochody_sprzedane'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_samochody_sprzedane'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "v_raport_sprzedaz"
            Begin Extent = 
               Top = 9
               Left = 83
               Bottom = 258
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'wyniki_sprzedawcy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'wyniki_sprzedawcy'
GO
USE [master]
GO
ALTER DATABASE [komis] SET  READ_WRITE 
GO
