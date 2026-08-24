USE AdventureWorksDW2017;
GO

SET NOCOUNT ON;

/*
    Tutorial: Relational Rows as Individuals vs. Relational Rows as Classes

    This script generates sample Turtle for two patterns:

    1. DimEmployee rows as individuals
       Example:
           :Employee_1 a :Employee .

    2. DimProductCategory, DimProductSubcategory, and DimProduct rows as classes
       Example:
           :ProductCategory_1 a owl:Class ;
               rdfs:subClassOf :ProductCategory .

           :ProductSubcategory_1 a owl:Class ;
               rdfs:subClassOf :ProductCategory_1 .

           :Product_212 a owl:Class ;
               rdfs:subClassOf :ProductSubcategory_1 .

    Output:
        One row per Turtle line.

    Export example:
        sqlcmd -S BI2002 -d AdventureWorksDW2017 -E ^
          -i C:\temp\generate_row_examples_turtle.sql ^
          -o C:\temp\adventureworks_row_examples.ttl ^
          -W -w 4000 -h -1
*/

DECLARE @EmployeeSample int = 10;
DECLARE @CategorySample int = 4;
DECLARE @SubcategorySample int = 12;
DECLARE @ProductSample int = 20;

DECLARE @DatabaseName sysname = DB_NAME();
DECLARE @ServerName   sysname = @@SERVERNAME;

IF OBJECT_ID('tempdb..#Turtle') IS NOT NULL
    DROP TABLE #Turtle;

CREATE TABLE #Turtle
(
    LineID int IDENTITY(1,1) PRIMARY KEY,
    TurtleLine nvarchar(max) NOT NULL
);

------------------------------------------------------------------------------
-- Prefixes
------------------------------------------------------------------------------

INSERT INTO #Turtle (TurtleLine) VALUES
('@prefix :     <http://example.org/kg/> .'),
('@prefix owl:  <http://www.w3.org/2002/07/owl#> .'),
('@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .'),
('@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .'),
('');

------------------------------------------------------------------------------
-- Basic tutorial classes
------------------------------------------------------------------------------

INSERT INTO #Turtle (TurtleLine) VALUES
('# Core tutorial classes'),
(':Employee a owl:Class .'),
(':ProductCategory a owl:Class .'),
(':ProductSubcategory a owl:Class .'),
(':Product a owl:Class .'),
(':SourceTable a owl:Class .'),
(':SourceRow a owl:Class .'),
('');

------------------------------------------------------------------------------
-- Basic tutorial properties
------------------------------------------------------------------------------

INSERT INTO #Turtle (TurtleLine) VALUES
('# Core tutorial properties'),
(':mappedToTable a owl:ObjectProperty .'),
(':mappedToSourceRow a owl:ObjectProperty .'),
(':isRowOf a owl:ObjectProperty .'),
(':sourceServer a owl:DatatypeProperty .'),
(':sourceDatabase a owl:DatatypeProperty .'),
(':sourceSchema a owl:DatatypeProperty .'),
(':sourceTable a owl:DatatypeProperty .'),
(':sourceKey a owl:DatatypeProperty .'),
(':employeeKey a owl:DatatypeProperty .'),
(':firstName a owl:DatatypeProperty .'),
(':lastName a owl:DatatypeProperty .'),
(':title a owl:DatatypeProperty .'),
(':departmentName a owl:DatatypeProperty .'),
(':emailAddress a owl:DatatypeProperty .'),
(':hireDate a owl:DatatypeProperty .'),
(':currentFlag a owl:DatatypeProperty .'),
(':productCategoryKey a owl:DatatypeProperty .'),
(':productSubcategoryKey a owl:DatatypeProperty .'),
(':productKey a owl:DatatypeProperty .'),
(':productAlternateKey a owl:DatatypeProperty .'),
(':productName a owl:DatatypeProperty .'),
(':modelName a owl:DatatypeProperty .'),
(':color a owl:DatatypeProperty .'),
(':size a owl:DatatypeProperty .'),
(':listPrice a owl:DatatypeProperty .'),
(':standardCost a owl:DatatypeProperty .'),
(':finishedGoodsFlag a owl:DatatypeProperty .'),
('');

------------------------------------------------------------------------------
-- Source table metadata nodes
------------------------------------------------------------------------------

INSERT INTO #Turtle (TurtleLine) VALUES
('# Source table metadata'),
(':AdventureWorksDW2017_dbo_DimEmployee'),
('    a :SourceTable ;'),
(CONCAT('    :sourceServer "', STRING_ESCAPE(@ServerName, 'json'), '" ;')),
(CONCAT('    :sourceDatabase "', STRING_ESCAPE(@DatabaseName, 'json'), '" ;')),
('    :sourceSchema "dbo" ;'),
('    :sourceTable "DimEmployee" .'),
('');

INSERT INTO #Turtle (TurtleLine) VALUES
(':AdventureWorksDW2017_dbo_DimProductCategory'),
('    a :SourceTable ;'),
(CONCAT('    :sourceServer "', STRING_ESCAPE(@ServerName, 'json'), '" ;')),
(CONCAT('    :sourceDatabase "', STRING_ESCAPE(@DatabaseName, 'json'), '" ;')),
('    :sourceSchema "dbo" ;'),
('    :sourceTable "DimProductCategory" .'),
('');

INSERT INTO #Turtle (TurtleLine) VALUES
(':AdventureWorksDW2017_dbo_DimProductSubcategory'),
('    a :SourceTable ;'),
(CONCAT('    :sourceServer "', STRING_ESCAPE(@ServerName, 'json'), '" ;')),
(CONCAT('    :sourceDatabase "', STRING_ESCAPE(@DatabaseName, 'json'), '" ;')),
('    :sourceSchema "dbo" ;'),
('    :sourceTable "DimProductSubcategory" .'),
('');

INSERT INTO #Turtle (TurtleLine) VALUES
(':AdventureWorksDW2017_dbo_DimProduct'),
('    a :SourceTable ;'),
(CONCAT('    :sourceServer "', STRING_ESCAPE(@ServerName, 'json'), '" ;')),
(CONCAT('    :sourceDatabase "', STRING_ESCAPE(@DatabaseName, 'json'), '" ;')),
('    :sourceSchema "dbo" ;'),
('    :sourceTable "DimProduct" .'),
('');

------------------------------------------------------------------------------
-- Section 1: Employee rows as individuals
------------------------------------------------------------------------------

INSERT INTO #Turtle (TurtleLine) VALUES
('# ------------------------------------------------------------'),
('# Pattern 1: DimEmployee rows become individuals'),
('# ------------------------------------------------------------'),
('');

IF OBJECT_ID('tempdb..#EmployeeSample') IS NOT NULL
    DROP TABLE #EmployeeSample;

SELECT TOP (@EmployeeSample)
    EmployeeKey,
    FirstName,
    LastName,
    Title,
    DepartmentName,
    EmailAddress,
    HireDate,
    CurrentFlag
INTO #EmployeeSample
FROM dbo.DimEmployee
WHERE EmployeeKey IS NOT NULL
ORDER BY EmployeeKey;

DECLARE
    @EmployeeKey int,
    @FirstName nvarchar(100),
    @LastName nvarchar(100),
    @Title nvarchar(100),
    @DepartmentName nvarchar(100),
    @EmailAddress nvarchar(100),
    @HireDate date,
    @CurrentFlag bit;

DECLARE employee_cursor CURSOR LOCAL FAST_FORWARD FOR
SELECT
    EmployeeKey,
    FirstName,
    LastName,
    Title,
    DepartmentName,
    EmailAddress,
    HireDate,
    CurrentFlag
FROM #EmployeeSample
ORDER BY EmployeeKey;

OPEN employee_cursor;

FETCH NEXT FROM employee_cursor
INTO
    @EmployeeKey,
    @FirstName,
    @LastName,
    @Title,
    @DepartmentName,
    @EmailAddress,
    @HireDate,
    @CurrentFlag;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':Employee_', @EmployeeKey)),
    ('    a :Employee ;'),
    (CONCAT('    rdfs:label "', STRING_ESCAPE(CONCAT(ISNULL(@FirstName, ''), ' ', ISNULL(@LastName, '')), 'json'), '" ;')),
    (CONCAT('    :employeeKey "', @EmployeeKey, '"^^xsd:integer ;')),
    (CONCAT('    :mappedToSourceRow :AdventureWorksDW2017_dbo_DimEmployee_Row_', @EmployeeKey, ' .')),
    ('');

    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':AdventureWorksDW2017_dbo_DimEmployee_Row_', @EmployeeKey)),
    ('    a :SourceRow ;'),
    ('    :isRowOf :AdventureWorksDW2017_dbo_DimEmployee ;'),
    (CONCAT('    :sourceKey "', @EmployeeKey, '"^^xsd:integer .')),
    ('');

    IF @FirstName IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Employee_', @EmployeeKey, ' :firstName "', STRING_ESCAPE(@FirstName, 'json'), '" .'));

    IF @LastName IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Employee_', @EmployeeKey, ' :lastName "', STRING_ESCAPE(@LastName, 'json'), '" .'));

    IF @Title IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Employee_', @EmployeeKey, ' :title "', STRING_ESCAPE(@Title, 'json'), '" .'));

    IF @DepartmentName IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Employee_', @EmployeeKey, ' :departmentName "', STRING_ESCAPE(@DepartmentName, 'json'), '" .'));

    IF @EmailAddress IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Employee_', @EmployeeKey, ' :emailAddress "', STRING_ESCAPE(@EmailAddress, 'json'), '" .'));

    IF @HireDate IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Employee_', @EmployeeKey, ' :hireDate "', CONVERT(varchar(10), @HireDate, 23), '"^^xsd:date .'));

    IF @CurrentFlag IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Employee_', @EmployeeKey, ' :currentFlag "', CASE WHEN @CurrentFlag = 1 THEN 'true' ELSE 'false' END, '"^^xsd:boolean .'));

    INSERT INTO #Turtle (TurtleLine) VALUES ('');

    FETCH NEXT FROM employee_cursor
    INTO
        @EmployeeKey,
        @FirstName,
        @LastName,
        @Title,
        @DepartmentName,
        @EmailAddress,
        @HireDate,
        @CurrentFlag;
END

CLOSE employee_cursor;
DEALLOCATE employee_cursor;

------------------------------------------------------------------------------
-- Section 2: Product rows as classes and subclasses
------------------------------------------------------------------------------

INSERT INTO #Turtle (TurtleLine) VALUES
('# ------------------------------------------------------------'),
('# Pattern 2: DimProductCategory, DimProductSubcategory, and DimProduct rows become classes'),
('# ------------------------------------------------------------'),
('');

------------------------------------------------------------------------------
-- Product categories as subclasses of :ProductCategory
------------------------------------------------------------------------------

IF OBJECT_ID('tempdb..#ProductCategorySample') IS NOT NULL
    DROP TABLE #ProductCategorySample;

SELECT TOP (@CategorySample)
    ProductCategoryKey,
    EnglishProductCategoryName
INTO #ProductCategorySample
FROM dbo.DimProductCategory
WHERE ProductCategoryKey IS NOT NULL
ORDER BY ProductCategoryKey;

DECLARE
    @ProductCategoryKey int,
    @EnglishProductCategoryName nvarchar(100);

DECLARE category_cursor CURSOR LOCAL FAST_FORWARD FOR
SELECT
    ProductCategoryKey,
    EnglishProductCategoryName
FROM #ProductCategorySample
ORDER BY ProductCategoryKey;

OPEN category_cursor;

FETCH NEXT FROM category_cursor
INTO @ProductCategoryKey, @EnglishProductCategoryName;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':ProductCategory_', @ProductCategoryKey)),
    ('    a owl:Class ;'),
    ('    rdfs:subClassOf :ProductCategory ;'),
    (CONCAT('    rdfs:label "', STRING_ESCAPE(@EnglishProductCategoryName, 'json'), '" ;')),
    (CONCAT('    :productCategoryKey "', @ProductCategoryKey, '"^^xsd:integer ;')),
    (CONCAT('    :mappedToSourceRow :AdventureWorksDW2017_dbo_DimProductCategory_Row_', @ProductCategoryKey, ' .')),
    ('');

    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':AdventureWorksDW2017_dbo_DimProductCategory_Row_', @ProductCategoryKey)),
    ('    a :SourceRow ;'),
    ('    :isRowOf :AdventureWorksDW2017_dbo_DimProductCategory ;'),
    (CONCAT('    :sourceKey "', @ProductCategoryKey, '"^^xsd:integer .')),
    ('');

    FETCH NEXT FROM category_cursor
    INTO @ProductCategoryKey, @EnglishProductCategoryName;
END

CLOSE category_cursor;
DEALLOCATE category_cursor;

------------------------------------------------------------------------------
-- Product subcategories as subclasses of their category row-class
------------------------------------------------------------------------------

IF OBJECT_ID('tempdb..#ProductSubcategorySample') IS NOT NULL
    DROP TABLE #ProductSubcategorySample;

SELECT TOP (@SubcategorySample)
    ps.ProductSubcategoryKey,
    ps.ProductCategoryKey,
    ps.EnglishProductSubcategoryName
INTO #ProductSubcategorySample
FROM dbo.DimProductSubcategory ps
JOIN #ProductCategorySample pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey
WHERE ps.ProductSubcategoryKey IS NOT NULL
ORDER BY ps.ProductCategoryKey, ps.ProductSubcategoryKey;

DECLARE
    @ProductSubcategoryKey int,
    @ProductSubcategoryCategoryKey int,
    @EnglishProductSubcategoryName nvarchar(100);

DECLARE subcategory_cursor CURSOR LOCAL FAST_FORWARD FOR
SELECT
    ProductSubcategoryKey,
    ProductCategoryKey,
    EnglishProductSubcategoryName
FROM #ProductSubcategorySample
ORDER BY ProductCategoryKey, ProductSubcategoryKey;

OPEN subcategory_cursor;

FETCH NEXT FROM subcategory_cursor
INTO
    @ProductSubcategoryKey,
    @ProductSubcategoryCategoryKey,
    @EnglishProductSubcategoryName;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':ProductSubcategory_', @ProductSubcategoryKey)),
    ('    a owl:Class ;'),
    (CONCAT('    rdfs:subClassOf :ProductCategory_', @ProductSubcategoryCategoryKey, ' ;')),
    (CONCAT('    rdfs:label "', STRING_ESCAPE(@EnglishProductSubcategoryName, 'json'), '" ;')),
    (CONCAT('    :productSubcategoryKey "', @ProductSubcategoryKey, '"^^xsd:integer ;')),
    (CONCAT('    :mappedToSourceRow :AdventureWorksDW2017_dbo_DimProductSubcategory_Row_', @ProductSubcategoryKey, ' .')),
    ('');

    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':AdventureWorksDW2017_dbo_DimProductSubcategory_Row_', @ProductSubcategoryKey)),
    ('    a :SourceRow ;'),
    ('    :isRowOf :AdventureWorksDW2017_dbo_DimProductSubcategory ;'),
    (CONCAT('    :sourceKey "', @ProductSubcategoryKey, '"^^xsd:integer .')),
    ('');

    FETCH NEXT FROM subcategory_cursor
    INTO
        @ProductSubcategoryKey,
        @ProductSubcategoryCategoryKey,
        @EnglishProductSubcategoryName;
END

CLOSE subcategory_cursor;
DEALLOCATE subcategory_cursor;

------------------------------------------------------------------------------
-- Products as subclasses of their product subcategory row-class
------------------------------------------------------------------------------

IF OBJECT_ID('tempdb..#ProductSample') IS NOT NULL
    DROP TABLE #ProductSample;

SELECT TOP (@ProductSample)
    p.ProductKey,
    p.ProductAlternateKey,
    p.ProductSubcategoryKey,
    p.EnglishProductName,
    p.ModelName,
    p.Color,
    p.Size,
    p.ListPrice,
    p.StandardCost,
    p.FinishedGoodsFlag
INTO #ProductSample
FROM dbo.DimProduct p
JOIN #ProductSubcategorySample ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
WHERE p.ProductKey IS NOT NULL
ORDER BY p.ProductSubcategoryKey, p.ProductKey;

DECLARE
    @ProductKey int,
    @ProductAlternateKey nvarchar(50),
    @ProductSubcategoryKeyForProduct int,
    @EnglishProductName nvarchar(100),
    @ModelName nvarchar(100),
    @Color nvarchar(50),
    @Size nvarchar(50),
    @ListPrice money,
    @StandardCost money,
    @FinishedGoodsFlag bit;

DECLARE product_cursor CURSOR LOCAL FAST_FORWARD FOR
SELECT
    ProductKey,
    ProductAlternateKey,
    ProductSubcategoryKey,
    EnglishProductName,
    ModelName,
    Color,
    Size,
    ListPrice,
    StandardCost,
    FinishedGoodsFlag
FROM #ProductSample
ORDER BY ProductSubcategoryKey, ProductKey;

OPEN product_cursor;

FETCH NEXT FROM product_cursor
INTO
    @ProductKey,
    @ProductAlternateKey,
    @ProductSubcategoryKeyForProduct,
    @EnglishProductName,
    @ModelName,
    @Color,
    @Size,
    @ListPrice,
    @StandardCost,
    @FinishedGoodsFlag;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':Product_', @ProductKey)),
    ('    a owl:Class ;'),
    (CONCAT('    rdfs:subClassOf :ProductSubcategory_', @ProductSubcategoryKeyForProduct, ' ;')),
    (CONCAT('    rdfs:label "', STRING_ESCAPE(@EnglishProductName, 'json'), '" ;')),
    (CONCAT('    :productKey "', @ProductKey, '"^^xsd:integer ;')),
    (CONCAT('    :mappedToSourceRow :AdventureWorksDW2017_dbo_DimProduct_Row_', @ProductKey, ' .')),
    ('');

    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':AdventureWorksDW2017_dbo_DimProduct_Row_', @ProductKey)),
    ('    a :SourceRow ;'),
    ('    :isRowOf :AdventureWorksDW2017_dbo_DimProduct ;'),
    (CONCAT('    :sourceKey "', @ProductKey, '"^^xsd:integer .')),
    ('');

    IF @ProductAlternateKey IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Product_', @ProductKey, ' :productAlternateKey "', STRING_ESCAPE(@ProductAlternateKey, 'json'), '" .'));

    IF @EnglishProductName IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Product_', @ProductKey, ' :productName "', STRING_ESCAPE(@EnglishProductName, 'json'), '" .'));

    IF @ModelName IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Product_', @ProductKey, ' :modelName "', STRING_ESCAPE(@ModelName, 'json'), '" .'));

    IF @Color IS NOT NULL AND @Color <> 'NA'
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Product_', @ProductKey, ' :color "', STRING_ESCAPE(@Color, 'json'), '" .'));

    IF @Size IS NOT NULL AND @Size <> 'NA'
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Product_', @ProductKey, ' :size "', STRING_ESCAPE(@Size, 'json'), '" .'));

    IF @ListPrice IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Product_', @ProductKey, ' :listPrice "', CONVERT(varchar(50), CONVERT(decimal(18,2), @ListPrice)), '"^^xsd:decimal .'));

    IF @StandardCost IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Product_', @ProductKey, ' :standardCost "', CONVERT(varchar(50), CONVERT(decimal(18,2), @StandardCost)), '"^^xsd:decimal .'));

    IF @FinishedGoodsFlag IS NOT NULL
        INSERT INTO #Turtle (TurtleLine) VALUES
        (CONCAT(':Product_', @ProductKey, ' :finishedGoodsFlag "', CASE WHEN @FinishedGoodsFlag = 1 THEN 'true' ELSE 'false' END, '"^^xsd:boolean .'));

    INSERT INTO #Turtle (TurtleLine) VALUES ('');

    FETCH NEXT FROM product_cursor
    INTO
        @ProductKey,
        @ProductAlternateKey,
        @ProductSubcategoryKeyForProduct,
        @EnglishProductName,
        @ModelName,
        @Color,
        @Size,
        @ListPrice,
        @StandardCost,
        @FinishedGoodsFlag;
END

CLOSE product_cursor;
DEALLOCATE product_cursor;

------------------------------------------------------------------------------
-- Output
------------------------------------------------------------------------------

SELECT TurtleLine
FROM #Turtle
ORDER BY LineID;
