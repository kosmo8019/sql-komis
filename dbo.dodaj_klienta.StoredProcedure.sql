USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[dodaj_klienta]    Script Date: 05.06.2018 09:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[dodaj_klienta] 

@imie varchar(15),@nazw varchar(20) ,@email varchar(20) , @kontakt  varchar (20)
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
		values (@imie,@nazw,@email,@kontakt,@login,@output,'S')
		BEGIN
       
		print ' twój login ' + @login + ' i hasło ' + @output

		end
end
GO
