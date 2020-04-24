
USE master
GO


-- Delete the db if it already exists
DROP DATABASE IF Exists SmallTownCinema

-- Create a new database
CREATE Database SmallTownCinema;
GO
-- Change to the new DB
USE SmallTownCinema
GO

begin tran

CREATE TABLE [dbo].[Theaters]
(
	[TheaterId] INT NOT NULL identity PRIMARY KEY,
	[TheaterName] NVARCHAR(50) NULL
)



CREATE TABLE [dbo].[Movies]
(
	[MovieId] INT NOT NULL identity PRIMARY KEY, 
    [Title] NVARCHAR(50) NOT NULL, 
    [PosterURL] NVARCHAR(MAX) NULL,
	[IMDBId] NVARCHAR(50) NULL,
	[Rating] NVARCHAR(10) NULL,
	[Runtime] INT NULL,
	[Cast] NVARCHAR(MAX) NULL,
	[Plot] NVARCHAR(MAX) NULL,
	[Genre] NVARCHAR(25) NOT NULL

)

CREATE TABLE [dbo].[Showings]
(
	[ShowingId] INT NOT NULL identity PRIMARY KEY, 
    [MovieId] INT NOT NULL, 
    [StartTime] DATETIME NOT NULL, 
    [EndTime] DATETIME NOT NULL, 
    [TheaterId] INT NOT NULL

	constraint fk_showing_theater foreign key (TheaterId) references theaters (TheaterId),
	constraint fk_showing_movie foreign key (MovieId) references Movies (MovieId)
)

CREATE TABLE [dbo].[Users]
(
	[UserId] INT NOT NULL identity PRIMARY KEY, 
    [email] NVARCHAR(50) NOT NULL, 
    [password] NVARCHAR(MAX) NOT NULL
)

CREATE TABLE [dbo].[Purchases]
(
	[PurchaseId] INT NOT NULL identity PRIMARY KEY, 
    [UserId] INT NOT NULL, 
    [DateTime] DATETIME NOT NULL, 
    [Total_Price] MONEY NOT NULL

	constraint fk_purchase_user foreign key (UserId) references Users (UserId)
)

CREATE TABLE [dbo].[Seats]
(
	[SeatId] INT NOT NULL identity PRIMARY KEY,
	[TheaterId] INT NOT NULL

	constraint fk_seat_theater foreign key (TheaterId) references Theaters (TheaterId)
)

CREATE TABLE [dbo].[Tickets]
(
	[TicketId] INT NOT NULL identity PRIMARY KEY, 
    [ShowingId] INT NOT NULL, 
    [SeatName] NVARCHAR(5) NOT NULL, 
    [PurchaseId] INT NOT NULL, 
    [Price] MONEY NOT NULL

	constraint fk_ticket_showing foreign key (ShowingId) references Showings (ShowingId),
	constraint fk_ticket_purchase foreign key (PurchaseId) references Purchases (PurchaseId),
	--constraint fk_ticket_seat foreign key (SeatId) references Seats (SeatId)

)

insert into Movies
(Title, IMDBId, Rating, Runtime, Plot, Cast, PosterURL, Genre)
values
('Forrest Gump','tt0109830','PG-13', 142,'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold through the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.','Tom Hanks, Rebecca Williams, Sally Field, Michael Conner Humphreys','https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg', 'Comedy-Drama')
,('Bee Movie','tt0389790','PG', 124,'Barry B. Benson, a bee just graduated from college, is disillusioned at his lone career choice: making honey. On a special trip outside the hive, Barrys life is saved by Vanessa, a florist in New York City. As their relationship blossoms, he discovers humans actually eat honey, and subsequently decides to sue them.', 'Jerry Seinfeld, Renée Zellweger, Matthew Broderick, Patrick Warburton', 'https://m.media-amazon.com/images/M/MV5BMjE1MDYxOTA4MF5BMl5BanBnXkFtZTcwMDE0MDUzMw@@._V1_SX300.jpg', 'Comedy')
,('Catch Me If You Can','tt0264464','PG-13', 141,'A seasoned FBI agent pursues Frank Abagnale Jr. who, before his 19th birthday, successfully forged millions of dollars worth of checks while posing as a Pan Am pilot, a doctor, and a legal prosecutor.','Leonardo DiCaprio, Tom Hanks, Christopher Walken, Martin Sheen','https://m.media-amazon.com/images/M/MV5BMTY5MzYzNjc5NV5BMl5BanBnXkFtZTYwNTUyNTc2._V1_SX300.jpg', 'Crime')

insert into Theaters
(TheaterName)
values
('1')
,('2')
,('3')
,('4')
,('5')
,('6')
,('7')

--DECLARE @todaysDate datetime = CONVERT(date, getdate());
--DECLARE @allStart datetime = (DATEADD(hour, 10, @todaysDate));
--DECLARE @SecondStart datetime = (DATEADD(hour, 10, DATEADD(Minute, 15, @todaysDate)));
--DECLARE @thirdStart datetime = (DATEADD(hour, 10, DATEADD(Minute, 30, @todaysDate)));


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @SecondStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @SecondStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @SecondStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @thirdStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

----(select MAX(EndTime) from Showings)

--SET @allStart = DATEADD(minute, datediff(minute,0,(select MAX(EndTime) from Showings)) / 10 * 10, 0)

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

----SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--SET @todaysDate = DATEADD(DAY, 1, @todaysDate)
--SET @allStart = DATEADD(HOUR, 10, @todaysDate)


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

----SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--SET @todaysDate = DATEADD(DAY, 1, @todaysDate)
--SET @allStart = DATEADD(HOUR, 10, @todaysDate)


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

----SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--SET @todaysDate = DATEADD(DAY, 1, @todaysDate)
--SET @allStart = DATEADD(HOUR, 10, @todaysDate)


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

----SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--SET @todaysDate = DATEADD(DAY, 1, @todaysDate)
--SET @allStart = DATEADD(HOUR, 10, @todaysDate)


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

----SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--SET @todaysDate = DATEADD(DAY, 1, @todaysDate)
--SET @allStart = DATEADD(HOUR, 10, @todaysDate)


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

----SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--SET @todaysDate = DATEADD(DAY, 1, @todaysDate)
--SET @allStart = DATEADD(HOUR, 10, @todaysDate)


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

--SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));


--insert into Showings
--(MovieId, StartTime, EndTime, TheaterId)
--values
--(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)), 1)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  2)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  3)
--,(1, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 1),@allStart)),  4)
--,(2, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 2),@allStart)),  5)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  6)
--,(3, @allStart, (DATEADD(MINUTE,(Select Runtime from Movies where MovieId = 3),@allStart)),  7)

----SET @allStart = DATEADD(minute, 15, (select MAX(EndTime) from Showings));

--SET @todaysDate = DATEADD(DAY, 1, @todaysDate)
--SET @allStart = DATEADD(HOUR, 10, @todaysDate)




commit tran




