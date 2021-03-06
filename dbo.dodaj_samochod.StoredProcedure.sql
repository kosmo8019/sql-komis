USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[dodaj_samochod]    Script Date: 05.06.2018 09:12:19 ******/
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
