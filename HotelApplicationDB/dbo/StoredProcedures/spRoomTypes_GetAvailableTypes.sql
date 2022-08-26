CREATE PROCEDURE [dbo].[spRoomTypes_GetAvailableTypes]
	@startDate date,
	@endDate date
AS
	begin
		set nocount on;

		Select ab.Id, ab.Title, ab.Description, ab.Price
		from dbo.Rooms aa
		inner join dbo.RoomTypes ab on ab.Id = aa.RoomTypeId
		where aa.Id not in (
		select b.RoomId
		from dbo.Bookings b
		where (@startDate<b.StartDate and @endDate>b.EndDate)
		   or (b.StartDate<=@endDate and @endDate< b.EndDate)
		   or (b.StartDate<=@startDate and @startDate<b.EndDate)
		)
		group by ab.Id, ab.Title, ab.Description, ab.Price

	end
