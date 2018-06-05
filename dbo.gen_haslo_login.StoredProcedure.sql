USE [komis]
GO
/****** Object:  StoredProcedure [dbo].[gen_haslo_login]    Script Date: 05.06.2018 09:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[gen_haslo_login] 

@output varchar(10) output

as


declare @zakres int = 74
declare @min int = 48
declare @char char
declare @dlug int = 7


set @output = ''


while @dlug > 0 begin

	select @char = char(round(rand()*@zakres+@min,0))
	
	set @output += @char
	set @dlug =@dlug-1

	end
return 
GO
