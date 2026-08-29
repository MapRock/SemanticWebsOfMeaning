Yes. I kept the structure and behavior of the prompt essentially unchanged and replaced the Iris-specific clues with a **cat-recognition / cat-feature clustering** example. I also checked the Wikidata IDs rather than carrying them over by analogy.

````text
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

## Step 8: Import the source ontology

If the source RDF contains an `owl:Ontology` IRI, make the world-links ontology import it.

For example:

```turtle
<https://example.org/cat/world/ontology>
    a owl:Ontology ;
    owl:imports <https://example.org/cat/ontology> .
```

The world-links ontology imports the source ontology.

The source ontology should not need to import the world-links ontology.

## Example expected from the Cat RDF

A good result would contain mappings such as:

```turtle
@prefix ex:   <https://example.org/cat/> .
@prefix wd:   <http://www.wikidata.org/entity/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl:  <http://www.w3.org/2002/07/owl#> .

<https://example.org/cat/world/ontology>
    a owl:Ontology ;
    owl:imports <https://example.org/cat/ontology> .

ex:Mammal
    rdfs:seeAlso wd:Q7377 .

ex:Cat
    rdfs:seeAlso wd:Q146 .

ex:CatCluster_TabbyLike
    rdfs:seeAlso wd:Q1474329 .

ex:CatCluster_SiameseLike
    rdfs:seeAlso wd:Q42604 .

ex:CatCluster_PersianLike
    rdfs:seeAlso wd:Q42610 .

ex:earLengthCentroid
    rdfs:seeAlso wd:Q7362 .

ex:earWidthCentroid
    rdfs:seeAlso wd:Q7362 .

ex:tailLengthCentroid
    rdfs:seeAlso wd:Q60960 .

ex:tailWidthCentroid
    rdfs:seeAlso wd:Q60960 .
```

Also look for useful concepts mentioned in model names and descriptions, such as:

* K-means clustering
* domestic cat
* tabby cat
* Siamese cat
* Persian cat
* mammal

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

```

I specifically verified the QIDs used in the rewritten prompt:

| Concept | Verified Wikidata item |
|---|---|
| domestic cat | `Q146` :contentReference[oaicite:0]{index=0} |
| mammal | `Q7377` :contentReference[oaicite:1]{index=1} |
| tabby cat | `Q1474329` :contentReference[oaicite:2]{index=2} |
| Siamese cat | `Q42604` :contentReference[oaicite:3]{index=3} |
| Persian cat | `Q42610` :contentReference[oaicite:4]{index=4} |
| ear | `Q7362` :contentReference[oaicite:5]{index=5} |
| tail | `Q60960` :contentReference[oaicite:6]{index=6} |
| K-means clustering | `Q310401` :contentReference[oaicite:7]{index=7} |

One deliberate choice: I used **`Q146` for domestic cat**, not `Q25265`. `Q25265` is **Felidae**, the entire cat family, whereas `Q146` is specifically the domestic cat. :contentReference[oaicite:8]{index=8}

I also deliberately retained your strongest part of the original prompt: the instruction to extract a concept **from within a property name** without pretending that the property itself *is* that concept. `earLengthCentroid → ear` and `tailLengthCentroid → tail` exercise exactly the same behavior as your petal/sepal examples without giving the LLM any Iris clues.
```
