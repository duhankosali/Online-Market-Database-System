use DbProjectOnlineMagaza


-- Transaction

/* 
BEGIN --> Ýþlem baþlangýcý
ROLLBACK --> Ýþlemleri geri alma / iptal etme
Commit --> Ýþlemleri Kaydetme
*/

SELECT * FROM ProductDetail

BEGIN TRANSACTION -- iþlem baþlangýcý
UPDATE ProductDetail set ProductCount = 100
UPDATE ProductDetail set ProductPrice = 1 
SELECT * FROM ProductDetail
ROLLBACK
SELECT * FROM ProductDetail


BEGIN TRANSACTION -- iþlem baþlangýcý
UPDATE Comment set CommentActive = 1 
SELECT CommentActive FROM Comment
COMMIT -- Yorumlarýmýz ilk baþta aktif deðil. Gerekli kontrollerden geçirdik. Þimdi hepsini aktif hale getirebiliriz. Bu nedenle COMMIT ettim.
SELECT * FROM Comment 



BEGIN TRANSACTION Kontrol
