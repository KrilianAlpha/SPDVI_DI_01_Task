# SPDVI_DI_O1Task
(Me faltan algunas funcionalidades que no entendido, pero por lo general creo que esta bastante completo)

Tambien se me olvido los commits asi que voy ha hacer un resumen aqui:

Primero empeze haciendo la conexiony inmediatamente me puse a hacer los filtros, usando querrys normales y no stored procedures
Luego empeze a aplicar los stored procedures y implemente la busqueda y el idioma,
Mas tarde añadi el checkbox para el SellEndDate y la paginacion, al hacer la paginacion me di cuenta de que tenia que cambiar mi codigo para poder actualizar la pagina en el filtro que pertocaba asi que modifique el codigo y lo volvi a implementar
Por ultimo hice el Form Dialog, consegui sin dificultad recoger los datos del item selecionado, pero a la hora de hacer los updates no he tenido tiempo y ademas de eso las dificultades me lo han puesto muy dificil asi que en ese apartado no esta completo

Ahora pongo todos mis stored Procedures aqui:
Parametros Para Obtener Las Opciones de Los Filtros:
[dbo].[getCategory]
as
begin
	SELECT Name FROM Production.ProductCategory
end

[dbo].[getClass]
	@Line nvarchar(5)
as
begin
	SELECT DISTINCT Class FROM Production.Product WHERE ProductLine = @Line AND Class IS NOT NULL
end

[dbo].[getListPrice]
as
begin
	SELECT DISTINCT [ListPrice] FROM [Production].[Product] WHERE listprice IS NOT NULL
end

[dbo].[getSize]
as
begin
	SELECT DISTINCT [Size] FROM [Production].[Product] WHERE Size IS NOT NULL
end

[dbo].[getStyle]
	@Line nvarchar(5)
as
begin
	SELECT DISTINCT Style FROM Production.Product WHERE ProductLine = @Line AND Style IS NOT NULL
end

[dbo].[getProductLine]
as
begin
	SELECT DISTINCT [ProductLine] FROM [Production].[Product] WHERE ProductLine IS NOT NULL
end

[dbo].[getSubCategory]
	@Line nvarchar(20)
as
begin
	SELECT ProductSubcategory.Name from Production.ProductSubcategory 
	INNER JOIN Production.ProductCategory ON ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID 
	WHERE ProductCategory.Name = @Line;
end

Lista principal:

[dbo].[getProducts]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(100),
	@Page smallint,
	@NPP smallint
as
begin
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

Querys de Los Filtros:

[dbo].[getProducts_filterCategory]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@Filter1 nvarchar(20)
as
begin
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

[dbo].[getProduct_filterSubCategory]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@Category nvarchar(20),
	@SubCategory nvarchar(20)
as
begin
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

[dbo].[getProduct_filterSize]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@Size nvarchar(20)
	
as
begin
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

[dbo].[getProduct_filterProductLine]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@Line nvarchar(1)
as
begin
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

[dbo].[getProduct_filterClass]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@ProductLine nvarchar(20),
	@Class nvarchar(20)
as
begin
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

[dbo].[getProduct_filterStyle]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@ProductLine nvarchar(20),
	@Style nvarchar(20)
as
begin
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

[dbo].[getProduct_filterListPrice]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@ListPrice float(20)
as
begin
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

Querys Para Las Busquedas con El TextBox:

[dbo].[getProduct_SearchName]
	@Lenguage nvarchar(2),
	@Avaible nvarchar (3),
	@Page smallint,
	@NPP smallint,
	@SearchName nvarchar(100)
as
begin
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

[dbo].[getProduct_SearchProductModel]
	@Lenguage nvarchar(2),
	@Avaible nvarchar(3),
	@Page smallint,
	@NPP smallint,
	@SearchProductModel nvarchar(100)
as
begin
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

Query Para Sacar Todos Los datos de El item selecionado (La idea era obtener el id para poder cambiar el resto de campos en el form dialog):

[dbo].[getProductDialog]
	@Lenguage nvarchar(2),
	@Name nvarchar(50)
as
begin
	SELECT Production.ProductModel.Name AS ProductModel, Production.ProductDescription.Description, Production.Product.Name, Production.Product.ProductNumber, Production.Product.Color, Production.Product.ListPrice, Production.Product.Size, Production.Product.ProductLine, Production.Product.Class AS Classe, Production.Product.Style, Production.ProductCategory.Name As [ProductCategory], Production.ProductSubcategory.Name AS [ProductSubcategory] 
	FROM Production.Product INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID 		
	INNER JOIN Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID 
	INNER JOIN Production.ProductModel ON Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
	INNER JOIN Production.ProductModelProductDescriptionCulture ON Production.ProductModel.ProductModelID = Production.ProductModelProductDescriptionCulture.ProductModelID 
	INNER JOIN Production.ProductDescription ON Production.ProductModelProductDescriptionCulture.ProductDescriptionID = Production.ProductDescription.ProductDescriptionID 
	WHERE ProductModelProductDescriptionCulture.CultureID = @Lenguage AND Product.Name LIKE @NAME
	
end

Query Para hacer el update, (como he dicho antes bastante inacabado):

[dbo].[updateProduct]
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


Aparte de todos estos hay unos cunatos mas parecidos entre los que hay aqui que sirven para sacar la cantidad de paginas que hay en cada filtro.
