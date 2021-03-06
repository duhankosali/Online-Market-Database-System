USE [DbProjectOnlineMagaza]
GO
/****** Object:  StoredProcedure [dbo].[UrunDurum]    Script Date: 25.01.2022 12:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UrunDurum] -- Procedure oluşturdum
( 
	@CategoryId INT = NULL 
)
AS
BEGIN
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

WHERE ((@CategoryId IS NULL) OR (c.CategoryId=@CategoryId))

END