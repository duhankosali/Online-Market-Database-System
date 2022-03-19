-- VIEW OLUÞTURMA

use DbProjectOnlineMagaza



CREATE VIEW GetUserAddress
AS
SELECT PersonName, City, Country, PersonAddress
FROM PersonDetail
INNER JOIN City ON PersonDetail.PersonCityId = City.CityId
INNER JOIN Country ON PersonDetail.PersonCountryId = Country.CountryId
INNER JOIN Person ON PersonDetail.PersonId = Person.PersonId

CREATE VIEW GetComment
AS
SELECT Comment , PersonName, PersonType
FROM Comment
INNER JOIN Person ON Comment.PersonId = Person.PersonId 
INNER JOIN PersonType ON Person.PersonTypeId = PersonType.PersonTypeId

CREATE VIEW GetProducts
AS
SELECT ProductName, ProductPrice, CategoryName
FROM Product 
INNER JOIN Category ON Product.CategoryId = Category.CategoryId
INNER JOIN ProductDetail ON ProductDetail.ProductId = Product.ProductId 


CREATE VIEW GetProductsCategory
AS
SELECT ProductName, ProductPrice, CategoryName, SubCategoryName
FROM Product 
INNER JOIN Category ON Product.CategoryId = Category.CategoryId
INNER JOIN ProductDetail ON ProductDetail.ProductId = Product.ProductId 
INNER JOIN SubCategory ON Product.SubCategoryId = SubCategory.SubCategoryId

CREATE VIEW GetSalesDate
AS
SELECT ProductName, ProductPrice, SalesDate
FROM Product
INNER JOIN Sales ON Product.ProductId = Sales.ProductId
INNER JOIN ProductDetail ON Product.ProductId = ProductDetail.ProductId

SELECT * FROM GetSalesDate