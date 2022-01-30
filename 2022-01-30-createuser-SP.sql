CREATE PROCEDURE [dbo].[CreateUser]
@login varchar(30),
@password varchar(64),
@email varchar(100),
@name varchar(100),
@surname varchar(100),
@address varchar(100),
@phone varchar(13)
AS 
INSERT INTO [User] (Login, PasswordHash, Permission, Email, Name, Surname, Address, Phone) VALUES (@login,HASHBYTES('SHA2_256',@password),0,@email,@name,@surname,@address,@phone)

