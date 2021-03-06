USE [master]
GO
/****** Object:  Database [komis]    Script Date: 06.06.2018 23:56:55 ******/
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
/****** Object:  Table [dbo].[klient]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[klient_dane]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_klient_dane]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[klient_preferencje]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[samochod_wyposazenie]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[typ_nadwozia]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_klienci_preferencje]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_preferencje_popularni_producenci]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[model]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[samochody_na_sprzedaz]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_samochody_do_sprzedania]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_samochody_sprzedane]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[rezerwacje]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_rezerwacje_klient_samochod]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[sprzedane]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_raport_sprzedaz]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[wyniki_sprzedawcy]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_raport_typu_platnosci]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  View [dbo].[v_marki_na_stanie]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[log_table]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Table [dbo].[powiazanie_wyposazenie_samochod]    Script Date: 06.06.2018 23:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[powiazanie_wyposazenie_samochod](
	[id_samochod] [int] NOT NULL,
	[id_wyposazenie] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[klient_dane]  WITH NOCHECK ADD  CONSTRAINT [FK_klient_dane_klient] FOREIGN KEY([id_klient])
REFERENCES [dbo].[klient] ([id_klienta])
GO
ALTER TABLE [dbo].[klient_dane] CHECK CONSTRAINT [FK_klient_dane_klient]
GO
ALTER TABLE [dbo].[klient_preferencje]  WITH NOCHECK ADD  CONSTRAINT [FK_klient_preferencje_klient] FOREIGN KEY([id_klient])
REFERENCES [dbo].[klient] ([id_klienta])
GO
ALTER TABLE [dbo].[klient_preferencje] CHECK CONSTRAINT [FK_klient_preferencje_klient]
GO
ALTER TABLE [dbo].[powiazanie_wyposazenie_samochod]  WITH NOCHECK ADD  CONSTRAINT [FK_powiazanie_wyposazenie_samochod_samochod_wyposazenie] FOREIGN KEY([id_wyposazenie])
REFERENCES [dbo].[samochod_wyposazenie] ([id_wyposazenie])
GO
ALTER TABLE [dbo].[powiazanie_wyposazenie_samochod] CHECK CONSTRAINT [FK_powiazanie_wyposazenie_samochod_samochod_wyposazenie]
GO
ALTER TABLE [dbo].[powiazanie_wyposazenie_samochod]  WITH NOCHECK ADD  CONSTRAINT [FK_powiazanie_wyposazenie_samochod_samochody_na_sprzedaz] FOREIGN KEY([id_samochod])
REFERENCES [dbo].[samochody_na_sprzedaz] ([id_samochod])
GO
ALTER TABLE [dbo].[powiazanie_wyposazenie_samochod] CHECK CONSTRAINT [FK_powiazanie_wyposazenie_samochod_samochody_na_sprzedaz]
GO
ALTER TABLE [dbo].[rezerwacje]  WITH NOCHECK ADD  CONSTRAINT [FK_rezerwacje_samochody_na_sprzedaz] FOREIGN KEY([id_samochodu])
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
/****** Object:  StoredProcedure [dbo].[dodaj_klienta]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  StoredProcedure [dbo].[dodaj_samochod]    Script Date: 06.06.2018 23:56:56 ******/
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
		print 'dodano nowy samochod do bazy - nr. ' + str (@id_model)

		end
	

end
GO
/****** Object:  StoredProcedure [dbo].[gen_haslo_login]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  StoredProcedure [dbo].[p_sprzedaz]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  StoredProcedure [dbo].[p_szukaj_marki]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  StoredProcedure [dbo].[p_usun_klienta]    Script Date: 06.06.2018 23:56:56 ******/
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

	alter table klient nocheck constraint all
	alter table klient_dane nocheck constraint all
	alter table klient_preferencje nocheck constraint all

	delete from klient where nazwisko=@nazwisko
	

	

	
END
GO
/****** Object:  StoredProcedure [dbo].[p_usun_samochod]    Script Date: 06.06.2018 23:56:56 ******/
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
	
	alter table rezerwacje nocheck constraint all
	alter table powiazanie_wyposazenie_samochod nocheck constraint all
	delete from samochody_na_sprzedaz where vin = @vin or id_samochod = @id


END
GO
/****** Object:  StoredProcedure [dbo].[p_wyszukiwanie_klienta]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  StoredProcedure [dbo].[p_zmiena_rezerwacji]    Script Date: 06.06.2018 23:56:56 ******/
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
/****** Object:  Trigger [dbo].[klient_delete_all]    Script Date: 06.06.2018 23:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [dbo].[klient_delete_all]
ON [dbo].[klient]
AFTER DELETE
AS
BEGIN
	DECLARE @operacja int
		SET @operacja = (SELECT id_klienta FROM deleted)
				
		
	IF exists (select * from  klient_dane where id_klient = @operacja) 
		begin
			delete from klient_dane where id_klient =@operacja
	end

	IF exists (select * from  klient_preferencje where id_klient = @operacja) 
				begin
			delete from klient_preferencje where id_klient =@operacja
	end

	alter table klient  check constraint all
	alter table klient_dane check constraint all
	alter table klient_preferencje  check constraint all

	end

GO
ALTER TABLE [dbo].[klient] ENABLE TRIGGER [klient_delete_all]
GO
/****** Object:  Trigger [dbo].[log_klient]    Script Date: 06.06.2018 23:56:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[log_klient]
ON [dbo].[klient]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operacja CHAR(6)
		SET @operacja = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operacja = 'Delete'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klienta, d.nazwisko + ' ' + d.imie,'klient', @operacja,USER_NAME(),GETDATE()
			FROM deleted d

	IF @operacja = 'Insert'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_klienta, i.nazwisko + ' ' + i.imie ,'klient', @operacja,USER_NAME(),GETDATE()
			FROM inserted i

	IF @operacja = 'Update'
			
			INSERT INTO log_table (log_1,log_2,log_3,log_4,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klienta, d.email + ' ' + d.kontakt + ' ' + d.login , i.email + ' ' + i.kontakt, i.login ,'klient', @operacja,USER_NAME(),GETDATE()

			FROM deleted d, inserted i
END
GO
ALTER TABLE [dbo].[klient] ENABLE TRIGGER [log_klient]
GO
/****** Object:  Trigger [dbo].[typ_klient]    Script Date: 06.06.2018 23:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[typ_klient] ON [dbo].[klient]
FOR INSERT
AS
     BEGIN
         DECLARE @operacja CHAR(1);
         SET @operacja =
(
    SELECT typ
    FROM inserted
);
         IF @operacja = 'D'
             BEGIN
                 RAISERROR('nie możesz dodać nowego dealera', 16, 1);
                 ROLLBACK TRANSACTION;
             END;
         IF @operacja = 'A'
             BEGIN
                 RAISERROR('nie możesz dodać nowego administratora', 16, 1);
                 ROLLBACK TRANSACTION;
             END;
         IF @operacja = 'S'
             BEGIN
                 PRINT('dodano klienta');
             END;
             ELSE
             BEGIN
                 RAISERROR('błedny typ klienta', 16, 1);
                 ROLLBACK TRANSACTION;
             END;
     END;
GO
ALTER TABLE [dbo].[klient] ENABLE TRIGGER [typ_klient]
GO
/****** Object:  Trigger [dbo].[log_klient_dane]    Script Date: 06.06.2018 23:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create TRIGGER [dbo].[log_klient_dane]
ON [dbo].[klient_dane]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operacja CHAR(6)
		SET @operacja = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operacja = 'Delete'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klient, d.id_adres ,'klient_dane', @operacja,USER_NAME(),GETDATE()
			FROM deleted d

	IF @operacja = 'Insert'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_klient, i.id_adres ,'klient_dane', @operacja,USER_NAME(),GETDATE()
			FROM inserted i

	IF @operacja = 'Update'
			
			INSERT INTO log_table (log_1,log_2,log_3,log_4,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klient, i.id_adres ,i.adres_linia_1 ,d.adres_linia_1, 'klient_dane', @operacja,USER_NAME(),GETDATE()

			FROM deleted d, inserted i
END
GO
ALTER TABLE [dbo].[klient_dane] ENABLE TRIGGER [log_klient_dane]
GO
/****** Object:  Trigger [dbo].[log_klient_preferencje]    Script Date: 06.06.2018 23:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create TRIGGER [dbo].[log_klient_preferencje]
ON [dbo].[klient_preferencje]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operacja CHAR(6)
		SET @operacja = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operacja = 'Delete'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klient,d.id_klient_preferencje,'klient_preferencje', @operacja,USER_NAME(),GETDATE()
			FROM deleted d

	IF @operacja = 'Insert'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_klient,i.id_klient_preferencje,'klient_preferencje', @operacja,USER_NAME(),GETDATE()
			FROM inserted i

	IF @operacja = 'Update'
			
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_klient,d.id_klient_preferencje,'klient_preferencje', @operacja,USER_NAME(),GETDATE()

			FROM deleted d, inserted i
END
GO
ALTER TABLE [dbo].[klient_preferencje] ENABLE TRIGGER [log_klient_preferencje]
GO
/****** Object:  Trigger [dbo].[log_rezerwacje]    Script Date: 06.06.2018 23:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create TRIGGER [dbo].[log_rezerwacje]
ON [dbo].[rezerwacje]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operacja CHAR(6)
		SET @operacja = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operacja = 'Delete'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klienta,d.id_rezerwacji, 'rezerwacje', @operacja,USER_NAME(),GETDATE()
			FROM deleted d

	IF @operacja = 'Insert'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_klienta, i.id_rezerwacji ,'rezerwacje', @operacja,USER_NAME(),GETDATE()
			FROM inserted i

	IF @operacja = 'Update'
			
			INSERT INTO log_table (log_1,log_2,log_3,log_4,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klienta,i.id_klienta,d.id_samochodu,i.id_samochodu,'rezerwacje', @operacja,USER_NAME(),GETDATE()

			FROM deleted d, inserted i
END
GO
ALTER TABLE [dbo].[rezerwacje] ENABLE TRIGGER [log_rezerwacje]
GO
/****** Object:  Trigger [dbo].[del_wyposazenie]    Script Date: 06.06.2018 23:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create TRIGGER [dbo].[del_wyposazenie]
ON [dbo].[samochody_na_sprzedaz]
AFTER DELETE
AS
BEGIN
	DECLARE @operacja int
		SET @operacja = (SELECT id_samochod FROM deleted)
				
		
	IF exists (select * from  rezerwacje where id_samochodu = @operacja) 
		begin
			delete from rezerwacje where id_samochodu =@operacja
	end

	IF exists (select * from powiazanie_wyposazenie_samochod where id_samochod = @operacja) 
				begin
			delete from powiazanie_wyposazenie_samochod where id_samochod = @operacja
	end

	alter table rezerwacje  check constraint all
	alter table powiazanie_wyposazenie_samochod check constraint all
	




END
GO
ALTER TABLE [dbo].[samochody_na_sprzedaz] ENABLE TRIGGER [del_wyposazenie]
GO
/****** Object:  Trigger [dbo].[log_sam_sprzedaz]    Script Date: 06.06.2018 23:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create TRIGGER [dbo].[log_sam_sprzedaz]
ON [dbo].[samochody_na_sprzedaz]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operacja CHAR(6)
		SET @operacja = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operacja = 'Delete'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_samochod,d.vin, 'samochody', @operacja,USER_NAME(),GETDATE()
			FROM deleted d

	IF @operacja = 'Insert'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_samochod, i.vin ,'samochody', @operacja,USER_NAME(),GETDATE()
			FROM inserted i

	IF @operacja = 'Update'
			
			INSERT INTO log_table (log_1,log_2,log_3,log_4,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_samochod,d.cena + ' ' + d.przebieg,i.cena,i.przebieg,'samochody', @operacja,USER_NAME(),GETDATE()

			FROM deleted d, inserted i
END
GO
ALTER TABLE [dbo].[samochody_na_sprzedaz] ENABLE TRIGGER [log_sam_sprzedaz]
GO
/****** Object:  Trigger [dbo].[log_sprzedaz]    Script Date: 06.06.2018 23:56:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create TRIGGER [dbo].[log_sprzedaz]
ON [dbo].[sprzedane]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operacja CHAR(6)
		SET @operacja = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operacja = 'Delete'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_sprzedazy,d.id_sprzedawcy, 'sprzedane', @operacja,USER_NAME(),GETDATE()
			FROM deleted d

	IF @operacja = 'Insert'
			INSERT INTO log_table (log_1,log_2,log_3,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_sprzedazy, i.id_samochod,i.id_sprzedawcy ,'sprzedane', @operacja,USER_NAME(),GETDATE()
			FROM inserted i

	IF @operacja = 'Update'
			
			INSERT INTO log_table (log_1,log_2,log_3,log_4,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_samochod,d.cena + '/' + i.cena, d.status + '/'+ i.status,i.id_sprzedawcy,'sprzedane', @operacja,USER_NAME(),GETDATE()

			FROM deleted d, inserted i
END
GO
ALTER TABLE [dbo].[sprzedane] ENABLE TRIGGER [log_sprzedaz]
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
