create database Task

use Task

create table Authors
(
Id int primary key identity,
[Name] varchar(30),
Surname varchar(40)
)

create table Books
(
Id int primary key identity,
[Name] varchar(100) check(LEN([Name])between 2 and 100),
[PageCount] tinyint check([PageCount] >= 10),
AuthorId int foreign key references Authors(Id)
)

insert into Authors values
('James','Joyce'),
('Leo','Tolstoy'),
('William','Shakespeare'),
('Homer','Simpson'),
('Gustave','Flaubert')

insert into Books values
('Ulysses',60,1),
('War and Peace',75,2),
('Hamlet',80,3), 
('The Odyssey',100,4),
('Madame Bovary',90,5)

create view datas
as
select b.Id as 'book id', b.[Name] as 'book name', b.PageCount as 'book pageCount',CONCAT(a.[Name], '', a.Surname) as AuthorFullName from Books as b
join Authors as a
on b.AuthorId = a.Id

select * from datas


execute search 'War and Peace'

create procedure search
@Search varchar(30)
as
begin
select * from datas
where 'book name' like CONCAT('%', @Search, '%') or AuthorFullName like CONCAT('%', @Search, '%')
end


create procedure insertAuthors
@AuthorsName varchar(30),
@AuthorsSurname varchar(30)
as
begin
insert into Authors ([Name], Surname) values
(@AuthorsName, @AuthorsSurname)
end


create procedure updateAuthors
@NewAuthorsId int,
@NewAuthorsName varchar(30),
@NewAuthorsSurname varchar(30)
as
begin
update Authors SET [Name] = @NewAuthorsName,
Surname = @NewAuthorsSurname
where Id = @NewAuthorsId
end


create procedure deleteAuthors
@NewAuthorsId int
as
begin
delete from Authors where Id = @NewAuthorsId
end


create view authors_datas
as
select a.Id as 'author id', CONCAT(a.[Name], '', a.Surname) as AuthorFullName, Count(b.Id) as 'book count', Max(b.PageCount) as 'max page count'
from Authors as a
left join Books as b
on b.authorId = a.Id
group by a.Id, a.[Name], a.Surname

select * from authors_datas

