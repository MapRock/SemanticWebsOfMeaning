USE AdventureWorksDW2017;
GO

SET NOCOUNT ON;

DECLARE @DatabaseName sysname = DB_NAME();
DECLARE @ServerName   sysname = @@SERVERNAME;

IF OBJECT_ID('tempdb..#Turtle') IS NOT NULL
    DROP TABLE #Turtle;

CREATE TABLE #Turtle
(
    LineID int IDENTITY(1,1) PRIMARY KEY,
    TurtleLine nvarchar(max) NOT NULL
);

IF OBJECT_ID('tempdb..#Tables') IS NOT NULL
    DROP TABLE #Tables;

CREATE TABLE #Tables
(
    TableOrdinal int IDENTITY(1,1) PRIMARY KEY,
    SchemaName sysname NOT NULL,
    TableName sysname NOT NULL,
    SemanticClassName nvarchar(300) NOT NULL,
    SourceTableIRI nvarchar(500) NOT NULL
);

IF OBJECT_ID('tempdb..#Columns') IS NOT NULL
    DROP TABLE #Columns;

CREATE TABLE #Columns
(
    ColumnOrdinal int IDENTITY(1,1) PRIMARY KEY,
    SchemaName sysname NOT NULL,
    TableName sysname NOT NULL,
    ColumnName sysname NOT NULL,
    SemanticClassName nvarchar(300) NOT NULL,
    SourceTableIRI nvarchar(500) NOT NULL,
    SourceColumnIRI nvarchar(600) NOT NULL,
    SemanticPropertyName nvarchar(600) NOT NULL,
    DataTypeName sysname NOT NULL,
    IsNullable bit NOT NULL,
    ColumnID int NOT NULL
);

INSERT INTO #Tables
(
    SchemaName,
    TableName,
    SemanticClassName,
    SourceTableIRI
)
SELECT
    s.name AS SchemaName,
    t.name AS TableName,

    -- DimEmployee -> Employee
    -- FactInternetSales -> InternetSales
    REPLACE(REPLACE(REPLACE(
        CASE
            WHEN t.name LIKE 'Dim%'  THEN SUBSTRING(t.name, 4, LEN(t.name))
            WHEN t.name LIKE 'Fact%' THEN SUBSTRING(t.name, 5, LEN(t.name))
            ELSE t.name
        END,
        ' ', '_'), '-', '_'), '.', '_') AS SemanticClassName,

    REPLACE(REPLACE(REPLACE(
        CONCAT(@DatabaseName, '_', s.name, '_', t.name),
        ' ', '_'), '-', '_'), '.', '_') AS SourceTableIRI
FROM sys.tables t
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
WHERE t.is_ms_shipped = 0
ORDER BY s.name, t.name;

INSERT INTO #Columns
(
    SchemaName,
    TableName,
    ColumnName,
    SemanticClassName,
    SourceTableIRI,
    SourceColumnIRI,
    SemanticPropertyName,
    DataTypeName,
    IsNullable,
    ColumnID
)
SELECT
    tb.SchemaName,
    tb.TableName,
    c.name AS ColumnName,
    tb.SemanticClassName,
    tb.SourceTableIRI,

    REPLACE(REPLACE(REPLACE(
        CONCAT(tb.SourceTableIRI, '_', c.name),
        ' ', '_'), '-', '_'), '.', '_') AS SourceColumnIRI,

    -- Make property names table-specific to avoid collisions like StartDate appearing in many tables.
    REPLACE(REPLACE(REPLACE(
        CONCAT(
            LOWER(LEFT(tb.SemanticClassName, 1)),
            SUBSTRING(tb.SemanticClassName, 2, LEN(tb.SemanticClassName)),
            '_',
            LOWER(LEFT(c.name, 1)),
            SUBSTRING(c.name, 2, LEN(c.name))
        ),
        ' ', '_'), '-', '_'), '.', '_') AS SemanticPropertyName,

    ty.name AS DataTypeName,
    c.is_nullable AS IsNullable,
    c.column_id AS ColumnID
FROM #Tables tb
JOIN sys.tables t
    ON t.name = tb.TableName
JOIN sys.schemas s
    ON t.schema_id = s.schema_id
   AND s.name = tb.SchemaName
JOIN sys.columns c
    ON c.object_id = t.object_id
JOIN sys.types ty
    ON c.user_type_id = ty.user_type_id
ORDER BY tb.SchemaName, tb.TableName, c.column_id;

-- Prefixes
INSERT INTO #Turtle (TurtleLine) VALUES
('@prefix :     <http://example.org/kg/> .'),
('@prefix owl:  <http://www.w3.org/2002/07/owl#> .'),
('@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .'),
('@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .'),
('');

-- Metadata classes
INSERT INTO #Turtle (TurtleLine) VALUES
('# Metadata classes'),
(':SourceTable a owl:Class .'),
(':SourceColumn a owl:Class .'),
('');

-- Metadata properties
INSERT INTO #Turtle (TurtleLine) VALUES
('# Metadata properties'),
(':mappedToTable a owl:ObjectProperty .'),
(':mappedToColumn a owl:ObjectProperty .'),
(':hasColumn a owl:ObjectProperty .'),
(':isColumnOf a owl:ObjectProperty .'),
(':serverName a owl:DatatypeProperty .'),
(':databaseName a owl:DatatypeProperty .'),
(':schemaName a owl:DatatypeProperty .'),
(':tableName a owl:DatatypeProperty .'),
(':columnName a owl:DatatypeProperty .'),
(':dataType a owl:DatatypeProperty .'),
(':isNullable a owl:DatatypeProperty .'),
(':ordinalPosition a owl:DatatypeProperty .'),
('');

DECLARE
    @TableOrdinal int,
    @SchemaName sysname,
    @TableName sysname,
    @SemanticClassName nvarchar(300),
    @SourceTableIRI nvarchar(500);

DECLARE table_cursor CURSOR LOCAL FAST_FORWARD FOR
SELECT
    TableOrdinal,
    SchemaName,
    TableName,
    SemanticClassName,
    SourceTableIRI
FROM #Tables
ORDER BY TableOrdinal;

OPEN table_cursor;

FETCH NEXT FROM table_cursor
INTO @TableOrdinal, @SchemaName, @TableName, @SemanticClassName, @SourceTableIRI;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':', @SemanticClassName)),
    ('    a owl:Class ;'),
    (CONCAT('    rdfs:label "', @SemanticClassName, '" ;')),
    (CONCAT('    :mappedToTable :', @SourceTableIRI, ' .')),
    ('');

    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':', @SourceTableIRI)),
    ('    a :SourceTable ;'),
    (CONCAT('    :serverName "', @ServerName, '" ;')),
    (CONCAT('    :databaseName "', @DatabaseName, '" ;')),
    (CONCAT('    :schemaName "', @SchemaName, '" ;')),
    (CONCAT('    :tableName "', @TableName, '" .')),
    ('');

    FETCH NEXT FROM table_cursor
    INTO @TableOrdinal, @SchemaName, @TableName, @SemanticClassName, @SourceTableIRI;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;

DECLARE
    @ColumnOrdinal int,
    @ColumnName sysname,
    @SourceColumnIRI nvarchar(600),
    @SemanticPropertyName nvarchar(600),
    @DataTypeName sysname,
    @IsNullable bit,
    @ColumnID int;

DECLARE column_cursor CURSOR LOCAL FAST_FORWARD FOR
SELECT
    ColumnOrdinal,
    SchemaName,
    TableName,
    ColumnName,
    SemanticClassName,
    SourceTableIRI,
    SourceColumnIRI,
    SemanticPropertyName,
    DataTypeName,
    IsNullable,
    ColumnID
FROM #Columns
ORDER BY ColumnOrdinal;

OPEN column_cursor;

FETCH NEXT FROM column_cursor
INTO
    @ColumnOrdinal,
    @SchemaName,
    @TableName,
    @ColumnName,
    @SemanticClassName,
    @SourceTableIRI,
    @SourceColumnIRI,
    @SemanticPropertyName,
    @DataTypeName,
    @IsNullable,
    @ColumnID;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':', @SemanticPropertyName)),
    ('    a owl:DatatypeProperty ;'),
    (CONCAT('    rdfs:domain :', @SemanticClassName, ' ;')),
    (CONCAT('    :mappedToColumn :', @SourceColumnIRI, ' .')),
    ('');

    INSERT INTO #Turtle (TurtleLine) VALUES
    (CONCAT(':', @SourceColumnIRI)),
    ('    a :SourceColumn ;'),
    (CONCAT('    :columnName "', @ColumnName, '" ;')),
    (CONCAT('    :dataType "', @DataTypeName, '" ;')),
    (CONCAT('    :isNullable "', CASE WHEN @IsNullable = 1 THEN 'true' ELSE 'false' END, '"^^xsd:boolean ;')),
    (CONCAT('    :ordinalPosition "', @ColumnID, '"^^xsd:integer ;')),
    (CONCAT('    :isColumnOf :', @SourceTableIRI, ' .')),
    ('');

    FETCH NEXT FROM column_cursor
    INTO
        @ColumnOrdinal,
        @SchemaName,
        @TableName,
        @ColumnName,
        @SemanticClassName,
        @SourceTableIRI,
        @SourceColumnIRI,
        @SemanticPropertyName,
        @DataTypeName,
        @IsNullable,
        @ColumnID;
END

CLOSE column_cursor;
DEALLOCATE column_cursor;

SELECT TurtleLine
FROM #Turtle
ORDER BY LineID;
