create database TourAgency;
alter database TourAgency collate Cyrillic_General_CI_AS;
use TourAgency;

create table Employees
(
Id int identity primary key,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
Position nvarchar(50),
Email nvarchar(100) unique check (Email !=''),
Phone nvarchar(15) unique check (Phone !=''),
HiringDate date default getdate()
);
go
create table Clients
(
Id int identity primary key,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
Email nvarchar(100) unique check (Email !=''),
Phone nvarchar(15) unique check (Phone !=''),
BirthDate date check (BirthDate < getdate()) not null
);
go
create table Tours
(
Id int identity primary key,
TourName nvarchar(100) unique,
TourPrice money,
StartDate date, 
FinishDate date,
CountClients int,
IsFinished bit default 0
);
go
create table EmployeeTour
(
Id int identity primary key,
EmployeeId int references Employees (Id),
TourId int references Tours (Id)
);
go
create table ClientTour
(
Id int identity primary key,
ClientId int references Clients (Id),
TourId int references Tours (Id),
IsRevised bit default 0,
IsOrdered bit default 0,
IsPaid bit default 0
);
go
create table Transport
(
Id int identity primary key,
TransportType nvarchar(50) unique check (TransportType != ''),
Number nvarchar(20),
SeatsCount int check (SeatsCount < 0)
);
go
create table TourTransport
(
Id int identity primary key,
TourId int references Tours (Id),
TransportId int references Transport (Id)
);
go
create table Countries
(
Id int identity primary key,
Country nvarchar(50) unique check (Country !=''),
);
go
create table Cities
(
Id int identity primary key,
City nvarchar(50) check (City !=''),
CountryId int references Countries (Id)
);
go
create table ShowPlaces
(
Id int identity primary key,
PlaceName nvarchar(200) check (PlaceName != ''),
PlacePrice money,
Address nvarchar(200),
Info nvarchar(max),
CityId int references Cities (Id)
);
go
create table PlaceImages
(
Id int identity primary key,
PlaceImage nvarchar(max),
PlaceId int references ShowPlaces (Id)
);
go
create table Hotels
(
Id int identity primary key,
Hotel nvarchar(100) check (Hotel != ''),
Address nvarchar(200),
Info nvarchar(max),
CityId int references Cities (Id)
);
create table HotelImages
(
Id int identity primary key,
HotelImage nvarchar(max),
HotelId int references Hotels (Id)
);
go
create table TourPlaces
(
Id int identity primary key,
TourId int references Tours (Id),
PlaceId int references ShowPlaces (Id),
VisitDate date
);
