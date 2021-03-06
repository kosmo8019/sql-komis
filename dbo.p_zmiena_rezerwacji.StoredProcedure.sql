USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[p_zmiena_rezerwacji]    Script Date: 05.06.2018 09:12:19 ******/
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
