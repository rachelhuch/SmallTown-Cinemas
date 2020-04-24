declare @movieId int = 1
declare @date nvarchar(50) = '2020-04-15'
declare @startTime nvarchar(10) = '10:00'
select concat(@date,' ',@startTime)

select * 
from tickets t 
join showings s on t.ShowingId = s.ShowingId
where s.MovieId = @movieId
and s.StartTime = concat(@date,' ',@startTime)

select * from Purchases
select * from tickets
select * from Showings
select * from users




insert into Purchases
(UserId,DateTime,Total_Price)
values
(1,GETDATE(),10)
select @@identity

declare @newPurchId int = (select max(purchaseId) from Purchases)
declare @showId int = 261

insert into tickets
(ShowingId, SeatName, PurchaseId, Price)
values(@showId, 'B1', @newPurchId,5)
,(@showId, 'B2', @newPurchId,5)
,(@showId, 'B3', @newPurchId,5)
,(@showId, 'F11', @newPurchId,5)
,(@showId, 'F12', @newPurchId,5)
,(@showId, 'C14', @newPurchId,5)
,(@showId, 'C15', @newPurchId,5)

select * from tickets
select * from Showings where ShowingId = 268