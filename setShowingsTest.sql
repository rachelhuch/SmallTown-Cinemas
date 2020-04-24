begin tran

select * from showings
delete from showings

DECLARE @todaysDate datetime = CONVERT(date, getdate());
DECLARE @allStart datetime = (DATEADD(hour, 10, @todaysDate));
declare @todayPlusTen datetime = dateadd(day, 10, @todaysDate);

while ( @allStart < @todayPlusTen )
begin




insert into Showings
(MovieId, StartTime, EndTime, TheaterId)
values
(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

if (convert(time, @allStart)) > 

end
select * from showings
rollback tran

