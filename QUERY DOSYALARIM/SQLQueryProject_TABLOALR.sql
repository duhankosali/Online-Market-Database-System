-- TABLOLARIN OLUÞTURULMASI ÝÇÝN YAZILAN QUERY

use DbProjectOnlineMagaza
CREATE TABLE Person (
PersonId int primary key not null, /* PRIMARY KEY OLACAK */
PersonName nvarchar(50), 
PersonMail nvarchar (200), 
PersonNumber nvarchar(30),
PersonTypeId nvarchar(10), 
PersonActive int DEFAULT 1,

)

ALTER TABLE Person
ADD PersonCreateDate date;

ALTER TABLE Person
DROP COLUMN PersonCreateDate;

ALTER TABLE Person
ADD PersonCreateDate date;

ALTER TABLE Person
ALTER COLUMN PersonTypeId int;

ALTER TABLE Person
DROP COLUMN PersonType;

ALTER TABLE Person
ADD FOREIGN KEY (PersonTypeId) REFERENCES PersonType(PersonTypeId);


CREATE TABLE PersonType (
PersonTypeId int primary key not null, /* PRIMARY KEY OLACAK */
PersonTypeActive int DEFAULT 1, 
)

ALTER TABLE PersonType
ADD PersonType nvarchar(50);

ALTER TABLE PersonType
ADD PersonCode nvarchar(50);

ALTER TABLE PersonType
ALTER COLUMN PersonCode int;

ALTER TABLE PersonType
ALTER COLUMN PersonCode tinyint;

ALTER TABLE PersonType
DROP COLUMN PersonCode;



CREATE TABLE PersonDetail (
PersonDetailId int primary key not null, /* PRIMARY KEY OLACAK */
PersonCityId nvarchar(50),
PersonInfo int,
PersonAddress nvarchar(100),
PersonId int,
PersonGender nvarchar(50),
)

ALTER TABLE PersonDetail
ADD PersonCountryId int;

ALTER TABLE PersonDetail
ADD PersonComment int;

ALTER TABLE PersonDetail
DROP COLUMN PersonInfo;

ALTER TABLE PersonDetail
ALTER COLUMN PersonCityId int;

ALTER TABLE PersonDetail
ADD FOREIGN KEY (PersonId) REFERENCES Person(PersonId);

ALTER TABLE PersonDetail
ADD FOREIGN KEY (PersonCityId) REFERENCES City(CityId);




CREATE TABLE City (
CityId int primary key not null,
City int,
)

ALTER TABLE City
ADD CityActive int;

ALTER TABLE City
ALTER COLUMN City nvarchar(50);



CREATE TABLE Country (
CountryId int primary key not null,
CityId tinyint,
CountryActive int DEFAULT 1, 
)

ALTER TABLE Country
ADD Country nvarchar(50);

ALTER TABLE Country
ALTER COLUMN CityId int;

ALTER TABLE Country
ADD FOREIGN KEY (CityId) REFERENCES City(CityId);


/* ÜRÜNLER ÝLE ÝLGÝLÝ TABLOLAR */

CREATE TABLE Category ( -- KATEGORÝLER TABLOMUZ
CategoryId int primary key not null,
CategoryType int,
CategoryActive int DEFAULT 1, 
)

ALTER TABLE Category
ADD CategoryName tinyint;

ALTER TABLE Category
ALTER COLUMN CategoryName nvarchar(50);

ALTER TABLE Category
DROP COLUMN CategoryType;

ALTER TABLE Category
ADD CategoryMarka tinyint;

ALTER TABLE Category
ALTER COLUMN CategoryMarka nvarchar(50);

ALTER TABLE Category
DROP COLUMN CategoryMarka;



CREATE TABLE SubCategory ( -- ALT KATEGORÝLER TABLOMUZ
SubCategoryId int primary key not null,
SubCategoryName int,
CategoryId int,
SubCategoryType int,
)

ALTER TABLE SubCategory
ALTER COLUMN SubCategoryName nvarchar(50);

ALTER TABLE SubCategory
DROP COLUMN SubCategoryType;

ALTER TABLE SubCategory
ADD SubCategoryActive int;

ALTER TABLE SubCategory
ADD FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId);

ALTER TABLE SubCategory
ALTER COLUMN SubCategoryName int not null;


CREATE TABLE Product ( -- ÜRÜNLER TABLOMUZ
ProductId int primary key not null,
ProductName int,
SubCategoryId int,
CategoryId int,
ProductType int,
)

ALTER TABLE Product
ALTER COLUMN ProductName nvarchar(50);

ALTER TABLE Product
ADD ProductActive int;

ALTER TABLE Product
DROP COLUMN ProductType;

ALTER TABLE Product
ADD FOREIGN KEY (SubCategoryId) REFERENCES SubCategory(SubCategoryId);

ALTER TABLE Product
ADD FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId);


CREATE TABLE ProductDetail ( -- ÜRÜN ÖZELLÝKLERÝ TABLOMUZ
ProductDetailId int primary key not null,
ProductId tinyint,
ProductTax int,
ProductNumber nvarchar(50),
)

ALTER TABLE ProductDetail
ADD ProductCount int;

ALTER TABLE ProductDetail
ADD ProductComment int;

ALTER TABLE ProductDetail
ADD ProductPrice int;

ALTER TABLE ProductDetail
ALTER COLUMN ProductPrice money;

ALTER TABLE ProductDetail
ALTER COLUMN ProductTax money;

ALTER TABLE ProductDetail
ALTER COLUMN ProductId int;

ALTER TABLE ProductDetail
DROP COLUMN ProductNumber;

ALTER TABLE ProductDetail
ADD FOREIGN KEY (ProductId) REFERENCES Product(ProductId);



CREATE TABLE Sales ( -- Satýþlar Tablosu
SalesId int primary key not null,
ProductId int,
ProductCount tinyint,
PersonId int,
SalesDetail int,

)

ALTER TABLE Sales
DROP COLUMN SalesDetail;

ALTER TABLE Sales
ALTER COLUMN ProductCount int;

ALTER TABLE Sales
ADD SalesDate datetime;

ALTER TABLE Sales
ADD FOREIGN KEY (ProductId) REFERENCES Product(ProductId);

ALTER TABLE Sales
ADD FOREIGN KEY (PersonId) REFERENCES Person(PersonId);



CREATE TABLE Comment ( -- Ürün Yorumlarý
CommentId int primary key not null,
Comment int,
CommentLikes int,
ProductId int,
PersonId int,
CommentActive int DEFAULT 0, -- Yorum küfür, hakeret vs. içeriyor olabilir. Bu nedenle ilk olarak 0 döner eðer biz onay verirsek 1 e çeviririz.
)

ALTER TABLE Comment
ADD CommentDate datetime;

ALTER TABLE Comment
DROP COLUMN CommentLikes;

ALTER TABLE Comment
ALTER COLUMN Comment nvarchar(500);

ALTER TABLE Comment
ADD FOREIGN KEY (ProductId) REFERENCES Product(ProductId);

ALTER TABLE Comment
ADD FOREIGN KEY (PersonId) REFERENCES Person(PersonId);


CREATE TABLE Basket ( -- Ürün Sepeti
BasketId int primary key not null,
ProductId int,
PersonId int,
BasketPosition int DEFAULT 1, -- Basket Position yani Ürünler sepette mi? sorgusu
BasketActive int,
)

ALTER TABLE Basket
DROP COLUMN BasketActive;

ALTER TABLE Basket
ADD BasketDate datetime;

ALTER TABLE Basket
ADD FOREIGN KEY (ProductId) REFERENCES Product(ProductId);

ALTER TABLE Basket
ADD FOREIGN KEY (PersonId) REFERENCES Person(PersonId);

ALTER TABLE Basket
ADD BasketLastDate datetime;

ALTER TABLE Basket
DROP COLUMN BasketLastDate;



CREATE TABLE Access ( -- Kullanýcýlarýn eriþim izni olduðu sayfalarý kýsýtlayacaðýz.
Id int primary key not null,
AccessPage int, -- Eriþilebilecek sayfa adý
PersonTypeId int, -- Eriþebildiði sayfalar kullanýcýnýn yetki durumuna göre sýnýrlandýrýlacak.
BasketPosition int DEFAULT 1, -- Son ikisini yanlýslýkla eklemiþim tablodan çýkaracaðým
BasketActive int,
)

ALTER TABLE Access
DROP COLUMN BasketActive;

ALTER TABLE Access
DROP COLUMN BasketPosition;
 
ALTER TABLE Access
ADD Active int;

ALTER TABLE Access
ALTER COLUMN AccessPage nvarchar(50);

ALTER TABLE Access
ADD FOREIGN KEY (PersonTypeId) REFERENCES PersonType(PersonTypeId);

