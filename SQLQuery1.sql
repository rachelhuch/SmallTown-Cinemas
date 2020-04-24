select * from showings
select * from purchases
select * from tickets
select * from users
select * from seats
select * from theaters

begin tran
declare @tid int = 1
declare @sid int = 1
while @tid < 8
begin
while @sid < 151
begin

insert into seats
(TheaterId)
values
(@tid)
set @sid = @sid + 1

end
set @tid = @tid + 1
set @sid = 1
end
select * from seats
rollback tran