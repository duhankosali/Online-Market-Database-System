-- Trigger

-- Her verilen sipariþ stoktan 1 adet düþürülür.

SELECT * FROM Sales -- Satýþ verisi eklenecek.
SELECT * FROM ProductDetail -- ProductCount-1 yapýlacak.
SELECT * FROM Product

CREATE Trigger dbo.UrunSatisi -- Trigger imiz yazýldý.
ON dbo.Sales AFTER INSERT 
AS BEGIN
	DECLARE @ProductId INT
	SELECT @ProductId = ProductId FROM INSERTED
	UPDATE ProductDetail SET ProductCount = ProductCount - 1 WHERE ProductId = @ProductId
END

-- UrunSatisi Trigger test amacýyla INSERT cümleleri yazýyoruz.

INSERT INTO Sales -- Sales e satýþ ekledik.
(SalesId, ProductId, ProductCount, PersonId) VALUES (1,7,1,1)

SELECT * FROM Sales -- Satýþ verisi eklendi.
SELECT * FROM ProductDetail -- ProductCount-1 yapýldý.

INSERT INTO Sales -- Sales e satýþ ekledik.
(SalesId, ProductId, ProductCount, PersonId) VALUES (2,13,1,3)

SELECT * FROM Sales -- Satýþ verisi eklendi.
SELECT * FROM ProductDetail -- ProductCount-1 yapýldý.


-- Trigger 2

-- Yorum satýrýna her veri eklendiðinde Ürün Yorum sayýsý artar.

SELECT * FROM Comment -- Yorum verisi eklenecek
SELECT * FROM ProductDetail -- ProductComment+1 yapýlacak

CREATE Trigger dbo.UrunYorum -- Trigger imiz yazýldý.
ON dbo.Comment AFTER INSERT 
AS BEGIN
	DECLARE @ProductId INT
	SELECT @ProductId = ProductId FROM INSERTED
	UPDATE ProductDetail SET ProductComment = ProductComment + 1 WHERE ProductId = @ProductId
END

-- UrunSatisi Trigger testleri

INSERT INTO Comment -- Sales e satýþ ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (1,'Ürün sipariþim 15 dakika içinde geldi. Gerçekten harikaydý. 5 Puan veriyorum',1,3)

INSERT INTO Comment -- Sales e satýþ ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (2,'Ürün sipariþim 15 dakika içinde geldi. Gerçekten harikaydý. 5 Puan veriyorum',5,1)

INSERT INTO Comment -- Sales e satýþ ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (3,'Ürün sipariþim 15 dakika içinde geldi. Gerçekten harikaydý. 5 Puan veriyorum',4,2)

DELETE FROM Comment WHERE Comment='Ürün sipariþim 15 dakika içinde geldi. Gerçekten harikaydý. 5 Puan veriyorum'


-- Triggerimizi update edeceðim. Çünkü ProductComment in yanýnda PersonComment in de tutulmasý gerekiyor
SELECT * FROM Comment -- Yorum verisi eklenecek
SELECT * FROM ProductDetail -- ProductComment+1 yapýlacak
SELECT * FROM PersonDetail -- PersonComment+1 yapýlacak


-- Trigger imizi update etmeden önce test aþamasýnda yaptýðýmýz iþlemleri geri alýyoruz. Bu nedenle 3 adet UPDATE cümlelerini kullanýyoruz. (Aksi takdirde veri uyuþmazlýðý olacaktý!!!)
UPDATE ProductDetail SET ProductComment=0 WHERE ProductDetailId=1
UPDATE ProductDetail SET ProductComment=1 WHERE ProductDetailId=4
UPDATE ProductDetail SET ProductComment=0 WHERE ProductDetailId=5


ALTER Trigger dbo.UrunYorum -- Trigger imiz update edildi. Artýk Yorum atan kiþinin sayýsý da tutuluyor.
ON dbo.Comment AFTER INSERT 
AS BEGIN
	DECLARE @ProductId INT
	DECLARE @PersonId INT
	SELECT @ProductId = ProductId FROM INSERTED
	SELECT @PersonId = PersonId FROM INSERTED
	UPDATE ProductDetail SET ProductComment = ProductComment + 1 WHERE ProductId = @ProductId
	UPDATE PersonDetail SET PersonComment = PersonComment + 1 WHERE PersonId = @PersonId
END
-- Satýþlarý eklemek için INSERT kullanýyorum
INSERT INTO Comment -- Sales e satýþ ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (4,'Aþýrý hýzlý teslimat!',4,2)

INSERT INTO Comment -- Sales e satýþ ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (1,'Ürünüm 5 dakika da kapýma geldi',5,4)

INSERT INTO Comment -- Sales e satýþ ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (5,'Güzel yorumlarýnýz için teþekkür ederiz:)',4,1)

INSERT INTO Comment -- Sales e satýþ ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (6,'Güzel yorumlarýnýz için teþekkür ederiz:)',5,1)



SELECT * FROM ProductDetail
-- 2 adet delete cümlemiz. Yanlýþlýkla eklenen 2 tane kayýtý sildim.
DELETE FROM ProductDetail WHERE ProductDetailId = 17;
DELETE FROM ProductDetail WHERE ProductDetailId = 16;

