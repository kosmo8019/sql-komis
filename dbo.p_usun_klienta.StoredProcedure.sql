USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[p_usun_klienta]    Script Date: 05.06.2018 09:12:19 ******/
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
