USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[p_szukaj_marki]    Script Date: 05.06.2018 09:12:19 ******/
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
