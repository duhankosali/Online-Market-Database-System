-- INDEXES

SELECT * FROM Access
CREATE NONCLUSTERED INDEX IAccessPage
ON [dbo].[Access] ([AccessPage])

SELECT * FROM Category
CREATE NONCLUSTERED INDEX ICategoryName
ON [dbo].[Category] ([CategoryName])

SELECT * FROM Comment
CREATE NONCLUSTERED INDEX IComment
ON [dbo].[Comment] ([Comment])

SELECT * FROM Person
CREATE NONCLUSTERED INDEX IPerson
ON [dbo].[Person] ([PersonName])

SELECT * FROM Product
CREATE NONCLUSTERED INDEX IProduct
ON [dbo].[Product] ([ProductName])