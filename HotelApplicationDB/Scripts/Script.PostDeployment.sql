/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
if not exists(select 1 from dbo.RoomTypes)
begin
        insert into dbo.RoomTypes(Title, Description, Price)
            values ('King Size Bed', 'A Room with King size bed',100),
                   ('Queen Size Bed', 'A room with 2 queen size beds',250) ,
                   ('Dormituroul Executiv', 'Doua camere, fiecare cu pat mare si fereastrae',550)
end
if not exists(select 1 from dbo.Rooms)
begin
    declare @roomId1 int;
    declare @roomId2 int;
    declare @roomId3 int;

    select @roomId1 = Id From dbo.RoomTypes where Title='King Size Bed';
    select @roomId2 = Id From dbo.RoomTypes where Title='Queen Size Bed';
    select @roomId3 = Id From dbo.RoomTypes where Title='Dormituroul Executiv';
        insert into dbo.Rooms(RoomNumber, RoomTypeId)
            values ('101', @roomId1),
                   ('102', @roomId1),
                   ('103', @roomId1),
                   ('104', @roomId1),
                   ('200', @roomId2),
                   ('300', @roomId3),
                   ('700', @roomId2),
                   ('900', @roomId3);
end