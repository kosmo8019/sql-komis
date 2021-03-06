USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[p_wyszukiwanie_klienta]    Script Date: 05.06.2018 09:12:19 ******/
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
