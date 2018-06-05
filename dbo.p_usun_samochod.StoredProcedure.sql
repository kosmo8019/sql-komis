USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[p_usun_samochod]    Script Date: 05.06.2018 09:12:19 ******/
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
