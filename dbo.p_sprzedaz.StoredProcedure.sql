USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[p_sprzedaz]    Script Date: 05.06.2018 09:12:19 ******/
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
