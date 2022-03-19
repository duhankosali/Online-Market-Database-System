-- Trigger

-- Her verilen sipari� stoktan 1 adet d���r�l�r.

SELECT * FROM Sales -- Sat�� verisi eklenecek.
SELECT * FROM ProductDetail -- ProductCount-1 yap�lacak.
SELECT * FROM Product

CREATE Trigger dbo.UrunSatisi -- Trigger imiz yaz�ld�.
ON dbo.Sales AFTER INSERT 
AS BEGIN
	DECLARE @ProductId INT
	SELECT @ProductId = ProductId FROM INSERTED
	UPDATE ProductDetail SET ProductCount = ProductCount - 1 WHERE ProductId = @ProductId
END

-- UrunSatisi Trigger test amac�yla INSERT c�mleleri yaz�yoruz.

INSERT INTO Sales -- Sales e sat�� ekledik.
(SalesId, ProductId, ProductCount, PersonId) VALUES (1,7,1,1)

SELECT * FROM Sales -- Sat�� verisi eklendi.
SELECT * FROM ProductDetail -- ProductCount-1 yap�ld�.

INSERT INTO Sales -- Sales e sat�� ekledik.
(SalesId, ProductId, ProductCount, PersonId) VALUES (2,13,1,3)

SELECT * FROM Sales -- Sat�� verisi eklendi.
SELECT * FROM ProductDetail -- ProductCount-1 yap�ld�.


-- Trigger 2

-- Yorum sat�r�na her veri eklendi�inde �r�n Yorum say�s� artar.

SELECT * FROM Comment -- Yorum verisi eklenecek
SELECT * FROM ProductDetail -- ProductComment+1 yap�lacak

CREATE Trigger dbo.UrunYorum -- Trigger imiz yaz�ld�.
ON dbo.Comment AFTER INSERT 
AS BEGIN
	DECLARE @ProductId INT
	SELECT @ProductId = ProductId FROM INSERTED
	UPDATE ProductDetail SET ProductComment = ProductComment + 1 WHERE ProductId = @ProductId
END

-- UrunSatisi Trigger testleri

INSERT INTO Comment -- Sales e sat�� ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (1,'�r�n sipari�im 15 dakika i�inde geldi. Ger�ekten harikayd�. 5 Puan veriyorum',1,3)

INSERT INTO Comment -- Sales e sat�� ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (2,'�r�n sipari�im 15 dakika i�inde geldi. Ger�ekten harikayd�. 5 Puan veriyorum',5,1)

INSERT INTO Comment -- Sales e sat�� ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (3,'�r�n sipari�im 15 dakika i�inde geldi. Ger�ekten harikayd�. 5 Puan veriyorum',4,2)

DELETE FROM Comment WHERE Comment='�r�n sipari�im 15 dakika i�inde geldi. Ger�ekten harikayd�. 5 Puan veriyorum'


-- Triggerimizi update edece�im. ��nk� ProductComment in yan�nda PersonComment in de tutulmas� gerekiyor
SELECT * FROM Comment -- Yorum verisi eklenecek
SELECT * FROM ProductDetail -- ProductComment+1 yap�lacak
SELECT * FROM PersonDetail -- PersonComment+1 yap�lacak


-- Trigger imizi update etmeden �nce test a�amas�nda yapt���m�z i�lemleri geri al�yoruz. Bu nedenle 3 adet UPDATE c�mlelerini kullan�yoruz. (Aksi takdirde veri uyu�mazl��� olacakt�!!!)
UPDATE ProductDetail SET ProductComment=0 WHERE ProductDetailId=1
UPDATE ProductDetail SET ProductComment=1 WHERE ProductDetailId=4
UPDATE ProductDetail SET ProductComment=0 WHERE ProductDetailId=5


ALTER Trigger dbo.UrunYorum -- Trigger imiz update edildi. Art�k Yorum atan ki�inin say�s� da tutuluyor.
ON dbo.Comment AFTER INSERT 
AS BEGIN
	DECLARE @ProductId INT
	DECLARE @PersonId INT
	SELECT @ProductId = ProductId FROM INSERTED
	SELECT @PersonId = PersonId FROM INSERTED
	UPDATE ProductDetail SET ProductComment = ProductComment + 1 WHERE ProductId = @ProductId
	UPDATE PersonDetail SET PersonComment = PersonComment + 1 WHERE PersonId = @PersonId
END
-- Sat��lar� eklemek i�in INSERT kullan�yorum
INSERT INTO Comment -- Sales e sat�� ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (4,'A��r� h�zl� teslimat!',4,2)

INSERT INTO Comment -- Sales e sat�� ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (1,'�r�n�m 5 dakika da kap�ma geldi',5,4)

INSERT INTO Comment -- Sales e sat�� ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (5,'G�zel yorumlar�n�z i�in te�ekk�r ederiz:)',4,1)

INSERT INTO Comment -- Sales e sat�� ekledik.
(CommentId, Comment, ProductId, PersonId) VALUES (6,'G�zel yorumlar�n�z i�in te�ekk�r ederiz:)',5,1)



SELECT * FROM ProductDetail
-- 2 adet delete c�mlemiz. Yanl��l�kla eklenen 2 tane kay�t� sildim.
DELETE FROM ProductDetail WHERE ProductDetailId = 17;
DELETE FROM ProductDetail WHERE ProductDetailId = 16;

