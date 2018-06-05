USE [komis]
GO

/****** Object:  Trigger [dbo].[typ_klient]    Script Date: 05.06.2018 11:07:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [dbo].[typ_klient]
ON [dbo].[klient]
for INSERT
AS
BEGIN
	DECLARE @operacja CHAR(1)
		SET @operacja =( select typ from inserted)
				
		
	IF @operacja = 'D' 
			raiserror ( 'nie mo¿esz dodaæ nowego dealera',16,1)
			rollback transaction
	

	IF @operacja = 'A' 
			raiserror ( 'nie mo¿esz dodaæ nowego administratora',16,1)
			rollback transaction
	

	IF @operacja = 'S'
			print ('dodano klienta')
			else 
			raiserror ('b³edny typ klienta',16,1)
			rollback transaction
end
GO

ALTER TABLE [dbo].[klient] ENABLE TRIGGER [typ_klient]
GO


