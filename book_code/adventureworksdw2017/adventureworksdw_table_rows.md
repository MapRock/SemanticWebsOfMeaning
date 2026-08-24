

```text
DimEmployee rows -> individuals
DimProductCategory / DimProductSubcategory / DimProduct rows -> classes / subclasses
```




The generated Turtle will show the two patterns clearly.

Employee row as an individual:

```turtle
:Employee_1
    a :Employee ;
    rdfs:label "Guy Gilbert" ;
    :employeeKey "1"^^xsd:integer ;
    :mappedToSourceRow :AdventureWorksDW2017_dbo_DimEmployee_Row_1 .
```

Product category row as a class:

```turtle
:ProductCategory_1
    a owl:Class ;
    rdfs:subClassOf :ProductCategory ;
    rdfs:label "Bikes" ;
    :productCategoryKey "1"^^xsd:integer ;
    :mappedToSourceRow :AdventureWorksDW2017_dbo_DimProductCategory_Row_1 .
```

Product subcategory row as a subclass of the category row-class:

```turtle
:ProductSubcategory_1
    a owl:Class ;
    rdfs:subClassOf :ProductCategory_1 ;
    rdfs:label "Mountain Bikes" ;
    :productSubcategoryKey "1"^^xsd:integer ;
    :mappedToSourceRow :AdventureWorksDW2017_dbo_DimProductSubcategory_Row_1 .
```

Product row as a subclass of the subcategory row-class:

```turtle
:Product_212
    a owl:Class ;
    rdfs:subClassOf :ProductSubcategory_1 ;
    rdfs:label "Sport-100 Helmet, Red" ;
    :productKey "212"^^xsd:integer ;
    :mappedToSourceRow :AdventureWorksDW2017_dbo_DimProduct_Row_212 .
```

This gives you a clean tutorial contrast:

```text
DimEmployee rows describe actual people in the enterprise data.
Those rows become individuals.

DimProductCategory, DimProductSubcategory, and DimProduct rows describe product kinds.
Those rows can become classes in a product taxonomy.
```
