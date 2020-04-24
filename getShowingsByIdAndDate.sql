--select * from showings
declare @id int = 1
declare @currentTime datetime = getdate()
declare @selectedDate datetime = convert(date, '2020-04-19')


select * from Showings where MovieId = @id and starttime > @currentTime and ( convert(date,starttime) = @selectedDate )

select @selectedDate