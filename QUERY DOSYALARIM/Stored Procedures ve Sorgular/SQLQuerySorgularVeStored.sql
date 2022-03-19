-- 20 ADET SQL SORGUMUZ (En az 5 tanesi Join i�eriyor)

use DbProjectOnlineMagaza

SELECT TOP 5 * FROM Product -- En �stteki 5 
�r�n
SELECT 20+4 AS 'TOPLAM', 20-4 AS 'FARK'
SELECT COUNT(*) FROM Product -- �r�nler tablosundaki veri say�s�
SELECT SUM(ProductId) FROM Product;
SELECT MAX(ProductId) FROM Product


SELECT AVG(ProductPrice) AS 'Ortalama' FROM ProductDetail





SELECT -- Satislar tablosu sorgu
satis.PersonId,
(SELECT urun.ProductName FROM Product urun WHERE urun.ProductId=satis.ProductId) as ProductName,
satis.SalesDate
FROM sales satis


SELECT -- Hangi �r�nler sat�ld�. Ve sat�� tarihi ne zaman?
satis.PersonId,
urun.ProductName,
satis.SalesDate
FROM sales satis
INNER JOIN Product urun ON urun.ProductId = satis.ProductId 


SELECT -- Kullan�c� bilgilerini tutan sorgu
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

SELECT PersonName, City, Country, PersonAddress -- Kullan�c� adresi tutan sorgu
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

SELECT -- Hangi yorumu hangi kullan�c� att�.
	p.PersonName,
	c.CommentId,
	c.Comment
FROM dbo.Comment c
INNER JOIN dbo.Person p ON p.PersonId = c.PersonId

SELECT PersonName, Comment
FROM Comment
INNER JOIN Person ON Comment.CommentId = Person.PersonId

SELECT -- Hangi kategoride hangi alt kategori �r�nleri var
	c.CategoryId,
	c.CategoryName,
	sc.SubCategoryId,
	sc.SubCategoryName
	
FROM dbo.Category c
INNER JOIN dbo.SubCategory sc ON sc.CategoryId = c.CategoryId



SELECT -- Hangi alt kategoride hangi �r�nler var.
	sc.SubCategoryId,
	sc.SubCategoryName,
	p.ProductId,
	p.ProductName
	
FROM dbo.Product p
INNER JOIN dbo.SubCategory sc ON sc.SubCategoryId = p.SubCategoryId



SELECT -- Hangi Kategori hangi alt kategoriye ait ve o alt kategoride hangi �r�nler var.
	c.CategoryId,
	c.CategoryName,
	sc.SubCategoryId,
	sc.SubCategoryName,
	p.ProductId,
	p.ProductName

FROM dbo.Product p
INNER JOIN dbo.SubCategory sc ON sc.SubCategoryId=p.SubCategoryId
INNER JOIN dbo.Category c ON c.CategoryId = p.CategoryId






-- DISTINC --> Ayn� olan kay�tlar� tutmaz
SELECT distinct * FROM Category -- Ayn� kategoriyi 2 kere yazm�� m�y�z diye kontrol ediyorum
SELECT distinct PersonCityId FROM PersonDetail -- Ayn� �ehirde ya�ayan insanlar� filtreler tek �ekilde g�sterir.

-- ORDER BY --> Koydu�umuz �arta g�re s�ralama i�lemi yapar.
SELECT * FROM Product order by ProductName desc -- desc dedi�im i�in isimleri alfabetik s�ran�n tersine g�re s�ralad�.
SELECT * FROM Person order by PersonName asc
SELECT * FROM Comment order by Comment desc -- son at�lan yorumdan ilk yoruma do�ru g�r�nt�l�yorum

SELECT * FROM ProductDetail WHERE ProductPrice>10 and ProductPrice<20 -- Fiyat� 10 ile 20 aras�ndaki �r�nleri fiyatlar�n� d���kten y�kse�e g�re s�rala
order by ProductPrice ASC

SELECT * FROM ProductDetail

-- AS --> Tablo column isimlerine takma ad koymam�z� sa�lar.
SELECT PersonId as 'Ki�i Numaras�', 
PersonName as 'Ki�i �smi', 
PersonMail as 'E-Mail Adresi', 
PersonNumber as 'Telefon Numaras�', 
PersonTypeId as 'Ki�i Yetki Durumu',
PersonActive as 'Aktiflik Durumu',
PersonCreateDate as '�yelik Olu�turulma Tarihi'
FROM Person

-- Aritmatik ��lemler

SELECT -- �r�nlerin vergilendirilmi� fiyat�
ProductId, 
ProductDetailId, 
ProductPrice,
ProductTax,
ProductPrice+ProductPrice*ProductTax/100
FROM ProductDetail

SELECT -- Y�lba��na �zel b�t�n �r�nlerde (vergisiz fiyatlar�na) %10 indirim
ProductId, 
ProductDetailId, 
ProductPrice,
ProductPrice-ProductPrice*10/100
FROM ProductDetail

-- Tarih Sorgular�
SELECT * FROM Sales
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (6,13,1,6) 
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (7,12,1,6) 
SELECT * FROM Sales WHERE SalesDate >= '2022-01-26' -- 26 Ocak ve sonras�nda yap�lan sat��lar (Benim bu sat�r� yazd���m g�n ve sonras�)

SELECT datediff(day,'01-01-1999',getdate())

-- Between komutu
SELECT * FROM ProductDetail WHERE ProductPrice between 10 and 20 -- Fiyat� 10 ile 20 aras�ndaki de�erleri d�nd�r�r

-- in komutu
SELECT * FROM Product WHERE CategoryId in (1) and SubCategoryId in (2) -- SubCategory 2, Category 1 olanlar� getir.

-- LIKE komutu
SELECT * FROM Category WHERE CategoryName like '[sa]%' -- Ba� harfi s veya a olan kategorileri getir.
SELECT * FROM Person WHERE PersonMail like '%hotmail.com%' -- Mail adresi hotmail olanlar� inceliyorum!!
SELECT * FROM Person WHERE PersonMail like '%gmail.com%' -- Mail adresi gmail olanlar� inceliyorum!!

-- Substring, upper, left, right --> Karakter i�leri
SELECT substring(ProductName,1,5) FROM Product -- 1 ve 5. aral�ktaki harf
SELECT substring(PersonName,2,4) FROM Person -- 2 ve 4. aral�ktaki harf
SELECT left (ProductName,7) FROM Product -- soldan 7 karakter
SELECT right(ProductName,6) FROM Product -- sa�dan 6 karakter
SELECT upper (ProductName) as 'B�Y�K HARF', lower(ProductName) as 'k���k harf' FROM Product

SELECT PersonName, replace(PersonName,'Duhan K�sali', 'D. K�sali') FROM Person -- Replace Kal�c� bir i�lem de�ildir. !!

-- HAVING --> Bir fonksiyonda d�nen de�ere g�re ko�ul yaz�lmak istenirse
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

SELECT ProductId, count(ProductName) as 'STOK' FROM Product  -- Ka� tane �r�n�m�z var. Ayn� �r�nden 1 den fazla veri girilmi� mi?
GROUP by ProductId

SELECT * FROM Sales

SELECT SalesDate, count(SalesId) as 'Sat�lan �r�n ID' FROM Sales -- �lk sat�lan �r�nden son sat�lan �r�ne kadar s�ralad�m.
GROUP by SalesDate order by SalesDate ASC 

SELECT SalesDate, count(SalesId) as 'Sat�lan �r�n ID' FROM Sales -- Son sat�lan �r�nden son sat�lan �r�ne kadar s�ralad�m.
GROUP by SalesDate order by SalesDate DESC

SELECT * FROM Comment

SELECT Comment, count(PersonId) as 'Kullan�c� NO' FROM Comment
GROUP BY Comment


-- TABLO B�RLE�T�RME

-- where komutu ile
 SELECT ProductName, ProductPrice FROM Product P, ProductDetail PD where P.ProductId = PD.ProductId

 -- inner join
 SELECT * 
 FROM Product P 
 INNER JOIN ProductDetail PD on P.ProductId=pd.ProductId

 SELECT sum(ProductPrice) as 'Toplam Fiyat', CategoryName -- Category ye g�re fiyat da��l�mlar�
 FROM Product P 
 INNER JOIN ProductDetail PD on P.ProductId = PD.ProductId
 INNER JOIN Category C on P.CategoryId = C.CategoryId
 GROUP BY CategoryName ORDER BY CategoryName
 

 SELECT CategoryId, count(*) FROM Product
 GROUP BY CategoryId

-- left ve right outer join

-- 2 ADET STORED PROCEDURE

CREATE PROCEDURE dbo.UrunDurum -- �r�n Durum Procedure
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


EXEC [dbo].[UrunDurum] -- �r�n Durum Stored Procedure mizi �a��r�yoruz. (Bu Procedure mi sonradan Modify ettim onlar da raporumda olacak.)


SELECT * FROM Sales
SELECT * FROM Product
SELECT * FROM Person

CREATE PROCEDURE dbo.UrunSatislar -- �r�n Satis Procedure
AS BEGIN

-- Test amac�yla INSERT i�lemi yap�yoruz.
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (3,11,1,4)
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (4,6,1,3)
INSERT INTO Sales (SalesId,ProductId, ProductCount, PersonId) VALUES (5,9,1,1)

END

EXEC dbo.UrunSatislar -- �r�n Satislar Stored Procedure mizi �a��r�yoruz.