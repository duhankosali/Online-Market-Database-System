use DbProjectOnlineMagaza


-- Transaction

/* 
BEGIN --> ��lem ba�lang�c�
ROLLBACK --> ��lemleri geri alma / iptal etme
Commit --> ��lemleri Kaydetme
*/

SELECT * FROM ProductDetail

BEGIN TRANSACTION -- i�lem ba�lang�c�
UPDATE ProductDetail set ProductCount = 100
UPDATE ProductDetail set ProductPrice = 1 
SELECT * FROM ProductDetail
ROLLBACK
SELECT * FROM ProductDetail


BEGIN TRANSACTION -- i�lem ba�lang�c�
UPDATE Comment set CommentActive = 1 
SELECT CommentActive FROM Comment
COMMIT -- Yorumlar�m�z ilk ba�ta aktif de�il. Gerekli kontrollerden ge�irdik. �imdi hepsini aktif hale getirebiliriz. Bu nedenle COMMIT ettim.
SELECT * FROM Comment 



BEGIN TRANSACTION Kontrol
