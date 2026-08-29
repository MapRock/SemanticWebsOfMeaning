You are given an RDF/OWL Turtle file generated from a machine-learning model.

Create a separate companion Turtle file named:

`<source-name>_rdf_world_links.ttl`

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

* `Cat` → domestic cat
* `Mammal` → mammal
* `Tabby-like cat` → tabby cat
* `Siamese-like cat` → Siamese cat
* `Persian-like cat` → Persian cat
* `ear length centroid` → ear
* `ear width centroid` → ear
* `tail length centroid` → tail
* `tail width centroid` → tail
* `Cat KMeans model` → K-means clustering
* a comment mentioning `dominant known breed ... Siamese` → Siamese cat

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
````

Example:

```turtle
ex:Cat
    rdfs:seeAlso wd:Q146 .
```

Likewise:

```turtle
ex:Mammal
    rdfs:seeAlso wd:Q7377 .
```

If a learned class is only similar to a known real-world class, still use the conservative `rdfs:seeAlso`.

For example:

```turtle
ex:CatCluster_TabbyLike
    rdfs:seeAlso wd:Q1474329 .
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
ex:earLengthCentroid
    rdfs:label "ear length centroid" .
```

The important world concept is:

`ear`

Find the external IRI for ear and include that connection.

For example:

```turtle
ex:earLengthCentroid
    rdfs:seeAlso wd:Q7362 .
```

Likewise:

```turtle
ex:earWidthCentroid
    rdfs:seeAlso wd:Q7362 .

ex:tailLengthCentroid
    rdfs:seeAlso wd:Q60960 .

ex:tailWidthCentroid
    rdfs:seeAlso wd:Q60960 .
```

The purpose of `rdfs:seeAlso` here is not to claim that the datatype property **is** an ear or tail. It is a semantic pointer to the real-world concept contained in the feature name.

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

## Step 8: Relate the companion file to the source ontology safely

If the source RDF contains an `owl:Ontology` IRI, use that IRI to identify the source ontology, but do not automatically add an `owl:imports` statement.

The source ontology IRI may be an identifier rather than a dereferenceable URL. Adding `owl:imports` to such an IRI can cause ontology tools such as Protégé to attempt to retrieve a resource that does not exist at that web location.

By default, declare the companion ontology without importing the source ontology.

For example:



```turtle
<https://example.org/cat/world/ontology>
    a owl:Ontology ;
    rdfs:label "Cat model world links" .
```

Assume that the source RDF and the companion world-links file will be loaded together by the application, RDF store, or ontology tool.

Only add:

```turtle
owl:imports <source-ontology-IRI>
```

when at least one of the following is true:

1. the source ontology IRI is known to be dereferenceable and returns the source ontology;
2. the target ontology environment explicitly provides an IRI mapping for that ontology;
3. the user specifically requests an `owl:imports` relationship.

Do not infer that an ontology IRI is dereferenceable merely because it begins with `http://` or `https://`.

In particular, IRIs under domains such as `example.org` should normally be treated as identifiers, not as retrievable ontology locations.


## Final checks

Before returning the file:

1. Verify every external IRI.
2. Verify every Wikidata QID.
3. Make sure every local IRI used actually exists in the source RDF.
4. Make sure no class became an individual.
5. Do not use `owl:sameAs` or `owl:equivalentClass` for approximate matches.
6. Parse the generated Turtle.
7. Parse it together with the source RDF.
8. Do not add `owl:imports` unless the source ontology is known to be resolvable
   or an ontology IRI mapping is explicitly available.
9. If `owl:imports` is omitted, make sure the companion file remains valid
   when loaded alongside the source RDF.

Produce the complete `<source-name>_rdf_world_links.ttl` file.

