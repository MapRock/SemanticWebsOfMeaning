You are given an RDF/OWL Turtle file generated from a machine-learning model.

Create a separate companion Turtle file named:

`<source-name>_world_links.ttl`

Its purpose is to connect concepts mentioned in the source RDF to established external IRIs, preferably Wikidata.

Do not redesign the source ontology. Do not add a large new ontology. Keep the result simple and conservative.

## Step 1: Read the source RDF

Inspect:

* OWL classes
* named individuals
* datatype properties
* object properties
* `rdfs:label`
* `rdfs:comment`
* descriptions
* model names
* other textual metadata

Use the text in those resources to determine what real-world concepts are being discussed.

## Step 2: Extract meaningful concepts

Look inside labels, property names, and descriptions for recognizable real-world concepts.

Do not require the entire label to correspond to an external entity.

For example:

* `Iris` → Iris genus
* `Flowering plant` → flowering plant
* `Setosa-like Iris` → Iris setosa
* `Versicolor-like Iris` → Iris versicolor
* `Virginica-like Iris` → Iris virginica
* `petal length centroid` → petal
* `petal width centroid` → petal
* `sepal length centroid` → sepal
* `sepal width centroid` → sepal
* `Iris KMeans model` → K-means clustering
* a comment mentioning `dominant known species ... setosa` → Iris setosa

Ignore generic words such as:

* value
* result
* ID
* count
* centroid
* model
* property

unless they identify a real concept worth linking.

## Step 3: Find the best external IRI

For every meaningful concept found, search for the closest authoritative external IRI.

Prefer:

1. Wikidata
2. a well-established domain ontology
3. another authoritative linked-data source

For Wikidata, verify that the QID actually represents the intended concept.

Never invent a QID.

If a mapping is uncertain, omit it.

## Step 4: Directly link source resources when appropriate

When an existing RDF resource clearly represents the external concept, add:

```turtle
rdfs:seeAlso
```

Example:

```turtle
ex:Iris
    rdfs:seeAlso wd:Q156901 .
```

Likewise:

```turtle
ex:FloweringPlant
    rdfs:seeAlso wd:Q25314 .
```

If a learned class is only similar to a known real-world class, still use the conservative `rdfs:seeAlso`.

For example:

```turtle
ex:IrisCluster_SetosaLike
    rdfs:seeAlso wd:Q894226 .
```

Do not use:

```turtle
owl:sameAs
owl:equivalentClass
```

for approximate or learned categories.

## Step 5: Extract concepts from properties and descriptions

This is important.

A datatype property may contain a meaningful real-world concept even though the property itself is not that thing.

For example:

```turtle
ex:petalLengthCentroid
    rdfs:label "petal length centroid" .
```

The important world concept is:

`petal`

Find the external IRI for petal and include that connection.

For example:

```turtle
ex:petalLengthCentroid
    rdfs:seeAlso wd:Q107412 .
```

Likewise:

```turtle
ex:petalWidthCentroid
    rdfs:seeAlso wd:Q107412 .

ex:sepalLengthCentroid
    rdfs:seeAlso wd:Q107216 .

ex:sepalWidthCentroid
    rdfs:seeAlso wd:Q107216 .
```

The purpose of `rdfs:seeAlso` here is not to claim that the datatype property **is** a petal or sepal. It is a semantic pointer to the real-world concept contained in the feature name.

Do the same thing with important concepts found inside comments and descriptions.

## Step 6: Preserve the source ontology

Do not change existing resources from:

* class to individual
* individual to class
* datatype property to object property
* object property to datatype property

Do not introduce OWL punning.

Do not replace or rename resources from the source ontology.

The companion file should mostly add external links to existing source resources.

## Step 7: Keep the world file simple

Do not automatically create:

* complex OWL restrictions
* taxonomic hierarchies
* part-of structures
* color ontologies
* new domain models
* equivalence axioms
* inferred classes

unless they are absolutely necessary to express a clear external connection.

The main task is:

```text
source RDF text
    ↓
recognize concepts
    ↓
find authoritative external IRI
    ↓
add conservative semantic link
```

## Step 8: Import the source ontology

If the source RDF contains an `owl:Ontology` IRI, make the world-links ontology import it.

For example:

```turtle
<https://example.org/iris/world/ontology>
    a owl:Ontology ;
    owl:imports <https://example.org/iris/ontology> .
```

The world-links ontology imports the source ontology.

The source ontology should not need to import the world-links ontology.

## Example expected from the Iris RDF

A good result would contain mappings such as:

```turtle
@prefix ex:   <https://example.org/iris/> .
@prefix wd:   <http://www.wikidata.org/entity/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl:  <http://www.w3.org/2002/07/owl#> .

<https://example.org/iris/world/ontology>
    a owl:Ontology ;
    owl:imports <https://example.org/iris/ontology> .

ex:FloweringPlant
    rdfs:seeAlso wd:Q25314 .

ex:Iris
    rdfs:seeAlso wd:Q156901 .

ex:IrisCluster_SetosaLike
    rdfs:seeAlso wd:Q894226 .

ex:IrisCluster_VersicolorLike
    rdfs:seeAlso wd:Q164844 .

ex:IrisCluster_VirginicaLike
    rdfs:seeAlso wd:Q7934335 .

ex:petalLengthCentroid
    rdfs:seeAlso wd:Q107412 .

ex:petalWidthCentroid
    rdfs:seeAlso wd:Q107412 .

ex:sepalLengthCentroid
    rdfs:seeAlso wd:Q107216 .

ex:sepalWidthCentroid
    rdfs:seeAlso wd:Q107216 .
```

Also look for useful concepts mentioned in model names and descriptions, such as:

* K-means clustering
* the Iris data set
* Iris setosa
* Iris versicolor
* Iris virginica

Connect them to appropriate source resources when doing so is clear and conservative.

## Final checks

Before returning the file:

1. Verify every external IRI.
2. Verify every Wikidata QID.
3. Make sure every local IRI used actually exists in the source RDF.
4. Make sure no class became an individual.
5. Do not use `owl:sameAs` or `owl:equivalentClass` for approximate matches.
6. Parse the generated Turtle.
7. Parse it together with the source RDF.

Produce the complete `<source-name>_world_links.ttl` file.

After the Turtle file, briefly list the concepts recognized and the external IRIs selected.
