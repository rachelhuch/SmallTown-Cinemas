begin tran


insert into users
(email, password)
values
('a@b.com', 'password')
declare @uid int = (select @@IDENTITY)

insert into Purchases
(UserId, DateTime, Total_Price)
values
(@uid,GETDATE(),10)
declare @pid int = (select @@IDENTITY)

insert into tickets
(ShowingId, SeatName, PurchaseId, price) --this showing is Apr 15 at 10AM
values
(@pid, 'A1', 1, 10),
(@pid, 'A2', 1, 10),
(@pid, 'A3', 1, 10),
(@pid, 'A4', 1, 10)

insert into Purchases
(UserId,DateTime,Total_Price)
values
(@uid,GETDATE(),10)

--select @@identity

declare @newPurchId int = (select max(purchaseId) from Purchases)
declare @showId int = 15

insert into tickets
(ShowingId, SeatName, PurchaseId, Price)
values(@showId, 'B1', @newPurchId,5)
,(@showId, 'B2', @newPurchId,5)
,(@showId, 'B3', @newPurchId,5)
,(@showId, 'F11', @newPurchId,5)
,(@showId, 'F12', @newPurchId,5)
,(@showId, 'C14', @newPurchId,5)
,(@showId, 'C15', @newPurchId,5)


commit tran

select * from users
select * from Purchases
select * from tickets
