


CREATE TRIGGER [dbo].[typ_klient]
ON [dbo].[klient]
for INSERT
AS
BEGIN
	DECLARE @operacja CHAR(1)
		SET @operacja =( select typ from inserted)
				
		
	IF @operacja = 'D' 
			raiserror ( 'nie mo�esz doda� nowego dealera',16,1)
			rollback transaction
	

	IF @operacja = 'A' 
			raiserror ( 'nie mo�esz doda� nowego administratora',16,1)
			rollback transaction
	

	IF @operacja = 'S'
			print ('dodano klienta')
			else 
			raiserror ('b�edny typ klienta',16,1)
			rollback transaction
end
