-- 20 ADET SQL SORGUMUZ (En az 5 tanesi Join içeriyor)

use DbProjectOnlineMagaza

SELECT TOP 5 * FROM Product -- En üstteki 5 
ürün
SELECT 20+4 AS 'TOPLAM', 20-4 AS 'FARK'
SELECT COUNT(*) FROM Product -- Ürünler tablosundaki veri sayýsý
SELECT SUM(ProductId) FROM Product;
SELECT MAX(ProductId) FROM Product


SELECT AVG(ProductPrice) AS 'Ortalama' FROM ProductDetail





SELECT -- Satislar tablosu sorgu
satis.PersonId,
(SELECT urun.ProductName FROM Product urun WHERE urun.ProductId=satis.ProductId) as ProductName,
satis.SalesDate
FROM sales satis


SELECT -- Hangi ürünler satýldý. Ve satýþ tarihi ne zaman?
satis.PersonId,
urun.ProductName,
satis.SalesDate
FROM sales satis
INNER JOIN Product urun ON urun.ProductId = satis.ProductId 


SELECT -- Kullanýcý bilgilerini tutan sorgu
	p.PersonId,
	p.PersonName,
	p.PersonMail,
	p.PersonNumber,
	pt.PersonType,
	CASE  
	WHEN p.PersonActive = 1 THEN 'Aktif'
	WHEN p.PersonActive = 2 THEN 'Pasif'
	ELSE 'Belirsiz' END AS PersonActive,
	pd.PersonGender

FROM dbo.Person p
INNER JOIN dbo.PersonType pt ON pt.PersonTypeId=p.PersonTypeId
INNER JOIN dbo.PersonDetail pd ON pd.PersonId = p.PersonId

SELECT PersonName, City, Country, PersonAddress -- Kullanýcý adresi tutan sorgu
FROM PersonDetail
INNER JOIN City ON PersonDetail.PersonCityId = City.CityId
INNER JOIN Country ON PersonDetail.PersonCountryId = Country.CountryId
INNER JOIN Person ON PersonDetail.PersonId = Person.PersonId

SELECT 
PersonName,
Comment,
CommentId
FROM Comment
INNER JOIN Person ON Person.PersonId = Comment.PersonId

SELECT -- Hangi yorumu hangi kullanýcý attý.
	p.PersonName,
	c.CommentId,
	c.Comment
FROM dbo.Comment c
INNER JOIN dbo.Person p ON p.PersonId = c.PersonId

SELECT PersonName, Comment
FROM Comment
INNER JOIN Person ON Comment.CommentId = Person.PersonId

SELECT -- Hangi kategoride hangi alt kategori ürünleri var
	c.CategoryId,
	c.CategoryName,
	sc.SubCategoryId,
	sc.SubCategoryName
	
FROM dbo.Category c
INNER JOIN dbo.SubCategory sc ON sc.CategoryId = c.CategoryId



SELECT -- Hangi alt kategoride hangi ürünler var.
	sc.SubCategoryId,
	sc.SubCategoryName,
	p.ProductId,
	p.ProductName
	
FROM dbo.Product p
INNER JOIN dbo.SubCategory sc ON sc.SubCategoryId = p.SubCategoryId



SELECT -- Hangi Kategori hangi alt kategoriye ait ve o alt kategoride hangi ürünler var.
	c.CategoryId,
	c.CategoryName,
	sc.SubCategoryId,
	sc.SubCategoryName,
	p.ProductId,
	p.ProductName

FROM dbo.Product p
INNER JOIN dbo.SubCategory sc ON sc.SubCategoryId=p.SubCategoryId
INNER JOIN dbo.Category c ON c.CategoryId = p.CategoryId






-- DISTINC --> Ayný olan kayýtlarý tutmaz
SELECT distinct * FROM Category -- Ayný kategoriyi 2 kere yazmýþ mýyýz diye kontrol ediyorum
SELECT distinct PersonCityId FROM PersonDetail -- Ayný þehirde yaþayan insanlarý filtreler tek þekilde gösterir.

-- ORDER BY --> Koyduðumuz þarta göre sýralama iþlemi yapar.
SELECT * FROM Product order by ProductName desc -- desc dediðim için isimleri alfabetik sýranýn tersine göre sýraladý.
SELECT * FROM Person order by PersonName asc
SELECT * FROM Comment order by Comment desc -- son atýlan yorumdan ilk yoruma doðru görüntülüyorum

SELECT * FROM ProductDetail WHERE ProductPrice>10 and ProductPrice<20 -- Fiyatý 10 ile 20 arasýndaki ürünleri fiyatlarýný düþükten yükseðe göre sýrala
order by ProductPrice ASC

SELECT * FROM ProductDetail

-- AS --> Tablo column isimlerine takma ad koymamýzý saðlar.
SELECT PersonId as 'Kiþi Numarasý', 
PersonName as 'Kiþi Ýsmi', 
PersonMail as 'E-Mail Adresi', 
PersonNumber as 'Telefon Numarasý', 
PersonTypeId as 'Kiþi Yetki Durumu',
PersonActive as 'Aktiflik Durumu',
PersonCreateDate as 'Üyelik Oluþturulma Tarihi'
FROM Person

-- Aritmatik Ýþlemler

SELECT -- Ürünlerin vergilendirilmiþ fiyatý
ProductId, 
ProductDetailId, 
ProductPrice,
ProductTax,
ProductPrice+ProductPrice*ProductTax/100
FROM ProductDetail

SELECT -- Yýlbaþýna özel bütün ürünlerde (vergisiz fiyatlarýna) %10 indirim
ProductId, 
ProductDetailId, 
ProductPrice,
ProductPrice-ProductPrice*10/100
FROM ProductDetail

-- Tarih Sorgularý
SELECT * FROM Sales
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (6,13,1,6) 
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (7,12,1,6) 
SELECT * FROM Sales WHERE SalesDate >= '2022-01-26' -- 26 Ocak ve sonrasýnda yapýlan satýþlar (Benim bu satýrý yazdýðým gün ve sonrasý)

SELECT datediff(day,'01-01-1999',getdate())

-- Between komutu
SELECT * FROM ProductDetail WHERE ProductPrice between 10 and 20 -- Fiyatý 10 ile 20 arasýndaki deðerleri döndürür

-- in komutu
SELECT * FROM Product WHERE CategoryId in (1) and SubCategoryId in (2) -- SubCategory 2, Category 1 olanlarý getir.

-- LIKE komutu
SELECT * FROM Category WHERE CategoryName like '[sa]%' -- Baþ harfi s veya a olan kategorileri getir.
SELECT * FROM Person WHERE PersonMail like '%hotmail.com%' -- Mail adresi hotmail olanlarý inceliyorum!!
SELECT * FROM Person WHERE PersonMail like '%gmail.com%' -- Mail adresi gmail olanlarý inceliyorum!!

-- Substring, upper, left, right --> Karakter iþleri
SELECT substring(ProductName,1,5) FROM Product -- 1 ve 5. aralýktaki harf
SELECT substring(PersonName,2,4) FROM Person -- 2 ve 4. aralýktaki harf
SELECT left (ProductName,7) FROM Product -- soldan 7 karakter
SELECT right(ProductName,6) FROM Product -- saðdan 6 karakter
SELECT upper (ProductName) as 'BÜYÜK HARF', lower(ProductName) as 'küçük harf' FROM Product

SELECT PersonName, replace(PersonName,'Duhan Kösali', 'D. Kösali') FROM Person -- Replace Kalýcý bir iþlem deðildir. !!

-- HAVING --> Bir fonksiyonda dönen deðere göre koþul yazýlmak istenirse
SELECT * FROM Person

SELECT count(PersonTypeId), PersonId
FROM Person
GROUP BY PersonId
HAVING count(PersonTypeId) = 1;

SELECT count(CommentActive), CommentId
FROM Comment
GROUP BY CommentId
HAVING count(CommentActive) = 1;

-- GROUP BY
SELECT * FROM ProductDetail

SELECT ProductId, count(ProductName) as 'STOK' FROM Product  -- Kaç tane ürünümüz var. Ayný üründen 1 den fazla veri girilmiþ mi?
GROUP by ProductId

SELECT * FROM Sales

SELECT SalesDate, count(SalesId) as 'Satýlan Ürün ID' FROM Sales -- Ýlk satýlan üründen son satýlan ürüne kadar sýraladým.
GROUP by SalesDate order by SalesDate ASC 

SELECT SalesDate, count(SalesId) as 'Satýlan Ürün ID' FROM Sales -- Son satýlan üründen son satýlan ürüne kadar sýraladým.
GROUP by SalesDate order by SalesDate DESC

SELECT * FROM Comment

SELECT Comment, count(PersonId) as 'Kullanýcý NO' FROM Comment
GROUP BY Comment


-- TABLO BÝRLEÞTÝRME

-- where komutu ile
 SELECT ProductName, ProductPrice FROM Product P, ProductDetail PD where P.ProductId = PD.ProductId

 -- inner join
 SELECT * 
 FROM Product P 
 INNER JOIN ProductDetail PD on P.ProductId=pd.ProductId

 SELECT sum(ProductPrice) as 'Toplam Fiyat', CategoryName -- Category ye göre fiyat daðýlýmlarý
 FROM Product P 
 INNER JOIN ProductDetail PD on P.ProductId = PD.ProductId
 INNER JOIN Category C on P.CategoryId = C.CategoryId
 GROUP BY CategoryName ORDER BY CategoryName
 

 SELECT CategoryId, count(*) FROM Product
 GROUP BY CategoryId

-- left ve right outer join

-- 2 ADET STORED PROCEDURE

CREATE PROCEDURE dbo.UrunDurum -- Ürün Durum Procedure
AS BEGIN
SELECT 
	p.ProductName AS Urun,
	c.CategoryName AS Kategori,
	sc.SubCategoryName AS AltKategori,
	pd.ProductCount AS StokDurumu,
	pd.ProductPrice AS Fiyat,
	pd.ProductTax AS KDVMiktar,
	(pd.ProductPrice * (pd.ProductTax/100) + (pd.ProductPrice)) AS VergiliFiyat,
	CASE 
		WHEN p.ProductActive = 1 THEN 'Aktif'
		WHEN p.ProductActive = 2 THEN 'Pasif'
	ELSE 'Belirsiz' END AS Durum

FROM dbo.Product p WITH(NOLOCK)
INNER JOIN dbo.ProductDetail pd ON pd.ProductDetailId = p.ProductId
INNER JOIN dbo.Category c ON c.CategoryId = p.CategoryId
INNER JOIN dbo.SubCategory sc ON sc.SubCategoryId = p.SubCategoryId
END -- Procedure Sonu


EXEC [dbo].[UrunDurum] -- Ürün Durum Stored Procedure mizi çaðýrýyoruz. (Bu Procedure mi sonradan Modify ettim onlar da raporumda olacak.)


SELECT * FROM Sales
SELECT * FROM Product
SELECT * FROM Person

CREATE PROCEDURE dbo.UrunSatislar -- Ürün Satis Procedure
AS BEGIN

-- Test amacýyla INSERT iþlemi yapýyoruz.
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (3,11,1,4)
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (4,6,1,3)
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (5,9,1,1)

END

EXEC dbo.UrunSatislar -- Ürün Satislar Stored Procedure mizi çaðýrýyoruz.