USE [komis]
GO

/****** Object:  Trigger [dbo].[log_klient]    Script Date: 05.06.2018 09:14:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[log_klient]
ON [dbo].[klient]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operacja CHAR(6)
		SET @operacja = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operacja = 'Delete'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klienta, d.nazwisko + ' ' + d.imie,'klient', @operacja,USER_NAME(),GETDATE()
			FROM deleted d

	IF @operacja = 'Insert'
			INSERT INTO log_table (log_1,log_2,tabela,operacjaA,operacjaB,czas)
			SELECT    i.id_klienta, i.nazwisko + ' ' + i.imie ,'klient', @operacja,USER_NAME(),GETDATE()
			FROM inserted i

	IF @operacja = 'Update'
			
			INSERT INTO log_table (log_1,log_2,log_3,log_4,tabela,operacjaA,operacjaB,czas)
			SELECT    d.id_klienta, d.email + ' ' + d.kontakt + ' ' + d.login , i.email + ' ' + i.kontakt, i.login ,'klient', @operacja,USER_NAME(),GETDATE()

			FROM deleted d, inserted i
END
GO

ALTER TABLE [dbo].[klient] ENABLE TRIGGER [log_klient]
GO

