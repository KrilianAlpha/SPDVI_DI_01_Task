/****** Object:  StoredProcedure [dbo].[getCategory]    Script Date: 12/12/2020 15:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCategory]
as
begin
	SET NOCOUNT ON;
	SELECT [ProductCategory].[Name] FROM Production.ProductCategory
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getClass]
	@Line nvarchar(5)
as
begin
	SET NOCOUNT ON;
	SELECT DISTINCT Class FROM Production.Product WHERE ProductLine = @Line AND Class IS NOT NULL
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getProductLine]
as
begin
	SET NOCOUNT ON;
	SELECT DISTINCT [ProductLine] FROM [Production].[Product] WHERE ProductLine IS NOT NULL
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getListPrice]
as
begin
	SET NOCOUNT ON;
	SELECT DISTINCT [ListPrice] FROM [Production].[Product] WHERE listprice IS NOT NULL
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getSize]
as
begin
	SET NOCOUNT ON;
	SELECT DISTINCT [Size] FROM [Production].[Product] WHERE Size IS NOT NULL
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getStyle]
	@Line nvarchar(5)
as
begin
	SET NOCOUNT ON;
	SELECT DISTINCT Style FROM Production.Product WHERE ProductLine = @Line AND Style IS NOT NULL
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getSubCategory]
	@Line nvarchar(20)
as
begin
	SET NOCOUNT ON;
	SELECT ProductSubcategory.Name from Production.ProductSubcategory 
	INNER JOIN Production.ProductCategory ON ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID 
	WHERE ProductCategory.Name = @Line;
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProducts]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(100),
	@Page smallint,
	@NPP smallint
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		fetch next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage
		ORDER BY Product.ProductID
		OFFSET @Page rows
		fetch next @NPP rows only
	
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProductDialog]
	@Lenguage nvarchar(2),
	@Name nvarchar(50)
as
begin
	SET NOCOUNT ON;
	SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class AS Classe, Production.Product.Style, Production.ProductCategory.Name As [ProductCategory], Production.ProductSubcategory.Name AS [ProductSubcategory] 
	FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 		
	INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
	INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
	INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
	INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
	WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.Name LIKE @NAME
	
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterClass]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@ProductLine nvarchar(20),
	@Class nvarchar(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @ProductLine AND Product.Class = @Class AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @ProductLine AND Product.Class = @Class
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterClassPages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@ProductLine nvarchar(20),
	@Class nvarchar(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @ProductLine AND Product.Class = @Class AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @ProductLine AND Product.Class = @Class
		ORDER BY Product.ProductID
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterListPrice]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@ListPrice float(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ListPrice = @ListPrice AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ListPrice = @ListPrice
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterListPricePages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@ListPrice float(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ListPrice = @ListPrice AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ListPrice = @ListPrice
		ORDER BY Product.ProductID
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterProductLine]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@Line nvarchar(1)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @Line AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @Line
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterProductLinePages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Line nvarchar(1)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @Line AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @Line
		ORDER BY Product.ProductID
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterSize]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@Size nvarchar(20)
	
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.Size = @Size AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.Size = @Size
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getProduct_filterSizePages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Size nvarchar(20)
	
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.Size = @Size AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.Size = @Size
		ORDER BY Product.ProductID
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterStyle]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@ProductLine nvarchar(20),
	@Style nvarchar(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @ProductLine AND Product.Style = @Style AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @ProductLine AND Product.Style = @Style
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterStylePages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@ProductLine nvarchar(20),
	@Style nvarchar(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @ProductLine AND Product.Style = @Style AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.ProductLine = @ProductLine AND Product.Style = @Style
		ORDER BY Product.ProductID
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterSubCategory]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@Category nvarchar(20),
	@SubCategory nvarchar(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductCategory.Name = @Category AND ProductSubcategory.Name = @SubCategory AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductCategory.Name = @Category AND ProductSubcategory.Name = @SubCategory
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_filterSubCategoryPages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Category nvarchar(20),
	@SubCategory nvarchar(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductCategory.Name = @Category AND ProductSubcategory.Name = @SubCategory AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductCategory.Name = @Category AND ProductSubcategory.Name = @SubCategory
		ORDER BY Product.ProductID
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProducts_filterCategory]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@Filter1 nvarchar(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductCategory.Name = @Filter1 AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductCategory.Name = @Filter1
		ORDER BY Product.ProductID
		OFFSET @Page rows
		FETCH next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProducts_filterCategoryPages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Filter1 nvarchar(20)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductCategory.Name = @Filter1 AND Product.SellEndDate IS NULL
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductCategory.Name = @Filter1
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_SearchName]
	@Lenguage nvarchar(2),
	@Avaible nvarchar (3),
	@Page smallint,
	@NPP smallint,
	@SearchName nvarchar(100)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.Name Like @SearchName AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		fetch next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.Name Like @SearchName
		ORDER BY Product.ProductID
		OFFSET @Page rows
		fetch next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_SearchNamePages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar (3),
	@SearchName nvarchar(100)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.Name Like @SearchName AND Product.SellEndDate IS NULL
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND Product.Name Like @SearchName
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_SearchProductModel]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@SearchProductModel nvarchar(100)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductModel.Name Like @SearchProductModel AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
		OFFSET @Page rows
		fetch next @NPP rows only
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductModel.Name Like @SearchProductModel
		ORDER BY Product.ProductID
		OFFSET @Page rows
		fetch next @NPP rows only
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProduct_SearchProductModelPages]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@SearchProductModel nvarchar(100)
as
begin
	SET NOCOUNT ON;
	IF(@Avaible = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductModel.Name Like @SearchProductModel AND Product.SellEndDate IS NULL
	ELSE IF(@Avaible = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.ProductModelID IS NOT NULL AND ProductModel.Name Like @SearchProductModel;
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getProductPages]
	@Lenguage nvarchar(2),
	@SearchProductModel nvarchar(100)
as
begin
	SET NOCOUNT ON;
	IF(@SearchProductModel = 'yes')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.SellEndDate IS NULL
		ORDER BY Product.ProductID
	ELSE IF(@SearchProductModel = 'no')
		SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class, Production.Product.Style, Production.ProductCategory.Name As [Product Category], Production.ProductSubcategory.Name AS [Product Subcategory] 
		FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 
		INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
		INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
		INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
		INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
		WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage
		ORDER BY Product.ProductID
end
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateProduct]
	@Name nvarchar(50),
	@ProductNumber nvarchar(25), 
	@Color nvarchar(15),
	@ListPrice float,
	@Size nvarchar(5),
	@ProductLine nvarchar(2),
	@Class nvarchar(2),
	@Style nvarchar(2)
as
begin
	UPDATE Production.Product
	SET Production.Product.Name = @Name, ProductNumber = @ProductNumber, Color = @Color, ListPrice = @ListPrice, Size = @Size, 
	ProductLine = @ProductLine, Class = @Class, Style = @Style
	WHERE Production.Product.Name LIKE @Name;

end
