You are given an OWL/RDF Turtle file generated from a machine-learning model. The file represents some combination of:

* the machine-learning model itself
* model outputs such as clusters, classes, predictions, rules, features, centroids, or scores
* learned OWL classes
* individuals representing concrete model artifacts or outputs
* datatype and object properties
* labels, comments, descriptions, provenance, feature names, and other metadata

Your task is to create a **separate companion OWL/RDF Turtle ontology** that connects the local machine-learning ontology to the wider world of meaning.

Call the output file:

`<source-name>_world_links.ttl`

For example, given `iris_rdf.ttl`, create:

`iris_world_links.ttl`

## Goal

Treat the source ontology as a local semantic model produced from machine learning. Build a second ontology that enriches it with:

* established domain concepts
* taxonomy
* meaningful relationships
* external identifiers
* Wikidata entities where appropriate
* other authoritative RDF/OWL vocabularies or IRIs when they are better than Wikidata
* semantic interpretation of ML features and outputs

The result should make it possible to load the original ontology and the world-links ontology together in Protégé and see how locally discovered statistical structure connects to broader knowledge.

Do **not** rewrite the original ontology unless absolutely necessary. The world-links file should normally enrich resources already defined there.

---

## 1. First understand the source ontology

Inspect the entire RDF/OWL file before creating anything.

Determine, from IRIs, labels, comments, descriptions, property names, class hierarchy, individuals, and values:

* What real-world domain is being modeled?
* What does each important class represent?
* What do important individuals represent?
* Which resources are machine-learning artifacts?
* Which resources are learned semantic classes?
* Which properties represent model metadata?
* Which properties represent actual domain concepts?
* What do feature names mean in the real world?
* What dataset, algorithm, model family, or statistical technique appears to have produced the model?

Do not interpret resources only from their IRI names if labels, comments, or surrounding RDF give more information.

Where the source distinguishes between:

1. a **model-output individual**, such as a particular cluster produced by K-means, and
2. a **learned OWL class**, such as a semantic category suggested by that cluster,

preserve that distinction.

For example:

```text
IrisKMeansCluster_1
    instance of MachineLearnedCluster

IrisCluster_SetosaLike
    subclass of Iris
```

These are related concepts but are **not the same thing**.

Do not introduce OWL punning merely to make a relationship convenient.

---

## 2. Create a separate ontology

Create a new `owl:Ontology` resource for the world-links file.

If the source file declares an ontology IRI, add:

```turtle
owl:imports <SOURCE_ONTOLOGY_IRI>
```

The dependency should normally be:

```text
world-links ontology
        |
        | imports
        v
local ML ontology
```

The original ML ontology should not have to import its enrichment ontology.

This keeps the local ontology independently usable.

If the source ontology has no ontology IRI, do not invent an import that cannot be resolved. Explain this briefly and keep the files independently loadable.

---

## 3. Map local concepts to established external concepts

For each important domain resource, search for an appropriate external concept.

Prefer, in roughly this order:

1. established domain ontologies or vocabularies
2. Wikidata
3. other authoritative linked-data resources

Use Wikidata QIDs where they provide a clear match.

Examples might include:

```turtle
world:IrisVersicolor
    rdfs:seeAlso wd:Q164844 .

world:Petal
    rdfs:seeAlso wd:Q107412 .

world:Sepal
    rdfs:seeAlso wd:Q107216 .

ex:IrisKMeansModel
    world:usesAlgorithm wd:Q310401 .
```

Verify Wikidata QIDs before using them.

Never invent QIDs.

Do not guess when an external mapping is uncertain.

If no sufficiently good external concept exists, keep the concept local.

---

## 4. Prefer conservative external links

For ordinary external mappings, prefer:

```turtle
rdfs:seeAlso
```

Do **not** create a redundant custom property such as:

```turtle
world:wikidataEntity
```

if `rdfs:seeAlso` already expresses what is needed.

Do not use:

```turtle
owl:sameAs
```

unless the two resources genuinely denote the same individual/resource under strong OWL identity semantics.

Do not use `owl:equivalentClass` merely because two class labels appear similar.

The world-links ontology should enrich meaning without making unjustifiably strong logical claims.

---

## 5. Build useful domain structure

Do more than simply attach QIDs.

Construct a small, intuitive domain model around the concepts discovered in the source ontology when doing so improves meaning.

For example, an Iris model might lead to:

```text
FloweringPlant
    └── Iridaceae
         └── Iris
              ├── Iris setosa
              ├── Iris versicolor
              └── Iris virginica

Flower
    └── IrisFlower

FloralPart
    ├── Petal
    └── Sepal

Color
    ├── Blue
    ├── Violet
    ├── Purple
    ├── White
    └── Yellow
```

Only add domain concepts that meaningfully explain or connect the ML ontology.

Do not build a huge general-purpose ontology.

The purpose is to expose the semantic neighborhood surrounding the ML model.

---

## 6. Give ML features real-world meaning

Pay particular attention to datatype properties and model features.

A feature such as:

```text
petalLengthCentroid
```

is not merely a number. It contains semantic information about what was measured.

Connect features to the concepts they measure.

For example:

```turtle
ex:petalLengthCentroid
    world:measuresPlantPart world:Petal ;
    rdfs:seeAlso wd:Q107412 .
```

Likewise, identify the meaning of:

* feature columns
* dimensions
* measurements
* units
* categories
* targets
* prediction outputs
* centroid components
* rule conditions

where possible.

Use annotation properties when the relationship is metadata **about a property or class**, rather than an ordinary relationship between individuals.

Avoid creating an object property whose object is an OWL class if doing so would inadvertently cause that class to become a named individual through OWL 2 punning.

---

## 7. Connect the ML model itself to the wider ML world

If the source ontology contains a machine-learning model individual, enrich that individual.

For example:

```turtle
ex:IrisKMeansModel
    world:trainedOnDataset wd:Q4203254 ;
    world:usesAlgorithm wd:Q310401 .
```

Dataset and algorithm relationships generally belong on the **model**, not redundantly on every output cluster.

Use proper object properties for relationships between ordinary individuals/resources where appropriate.

Examples:

```turtle
world:trainedOnDataset
    a owl:ObjectProperty .

world:usesAlgorithm
    a owl:ObjectProperty .
```

If an external dataset or algorithm has a recognized Wikidata item or authoritative IRI, use it.

---

## 8. Connect ML outputs to domain interpretation

When a model-output individual has a learned semantic interpretation, enrich the output appropriately.

For example:

```turtle
ex:IrisKMeansCluster_0
    world:dominantTaxon world:IrisVersicolor .
```

If the original ontology already says:

```turtle
ex:IrisKMeansCluster_0
    ex:representsLearnedClass ex:IrisCluster_VersicolorLike .
```

do not duplicate or replace that relationship unnecessarily.

Instead, enrich the resources around it:

```text
IrisKMeansCluster_0
       |
       | representsLearnedClass
       v
IrisCluster_VersicolorLike

IrisKMeansCluster_0
       |
       | dominantTaxon
       v
IrisVersicolor
       |
       | rdfs:seeAlso
       v
Wikidata Q164844
```

Do not claim that a learned class and an established real-world taxon/category are identical unless there is strong evidence for that assertion.

For a label such as `SetosaLike`, the word **Like** is important. Treat it as a learned approximation or interpretation, not automatically as logical equivalence with `Iris setosa`.

---

## 9. Add contextual knowledge that was not part of the ML features

The enrichment ontology may add useful real-world facts that the model itself did not use.

For example, an Iris model based only on sepal and petal dimensions might be connected to flower colors.

Clearly distinguish this **domain enrichment** from features observed by the ML model.

Use descriptive annotation properties for facts such as:

```turtle
world:typicalFlowerColor
world:flowerMarkingColor
```

Do not imply that these properties influenced the ML model unless the source actually says so.

---

## 10. Avoid unnecessarily strong OWL restrictions

Do not add logical restrictions merely because a natural-language statement sounds reasonable.

For example, avoid automatically asserting:

```turtle
ex:Iris
    rdfs:subClassOf [
        owl:onProperty world:hasPart ;
        owl:someValuesFrom world:IrisFlower
    ] .
```

That means every Iris instance must have at least one Iris flower.

If the intended meaning is merely descriptive, prefer something such as:

```turtle
ex:Iris
    world:characteristicFlower world:IrisFlower .
```

Use OWL restrictions only when the logical semantics are genuinely intended.

---

## 11. Make the ontology readable in Protégé

Add good `rdfs:label` values for local classes, individuals, and properties.

For external IRIs such as Wikidata resources, optionally add local labels:

```turtle
wd:Q164844
    rdfs:label "Iris versicolor"@en .
```

These labels are convenience annotations so that Protégé displays readable names even without importing or dereferencing Wikidata.

Do not attempt to recreate Wikidata locally.

---

## 12. Preserve modularity

The final architecture should resemble:

```text
LOCAL ML ONTOLOGY

MachineLearningModel
    └── IrisKMeansModel

MachineLearnedCluster
    ├── IrisKMeansCluster_0
    ├── IrisKMeansCluster_1
    └── IrisKMeansCluster_2

Iris
    ├── IrisCluster_SetosaLike
    ├── IrisCluster_VersicolorLike
    └── IrisCluster_VirginicaLike


WORLD-LINKS ONTOLOGY

IrisKMeansModel
    ├── trainedOnDataset → external dataset
    └── usesAlgorithm → external algorithm

IrisKMeansCluster_0
    └── dominantTaxon → Iris versicolor → Wikidata

Iris
    └── Iridaceae
         └── broader botanical world

petalLengthCentroid
    └── measuresPlantPart → Petal → Wikidata
```

The local ML ontology represents **what the model discovered or produced**.

The world-links ontology represents **what those local things mean in the larger world**.

---

## 13. Validate the result

Before returning the file:

1. Parse the generated Turtle to ensure it is syntactically valid.
2. Parse it together with the source ontology.
3. Check for accidental class/individual punning.
4. Check that referenced local IRIs actually exist in the source ontology.
5. Check all Wikidata QIDs used.
6. Check that learned classes remain classes unless the source intentionally uses punning.
7. Check that ML cluster/model artifacts that should be individuals remain individuals.
8. Check that no unnecessary duplicate predicates express the same external mapping.
9. Check that the ontology import points to the source ontology IRI exactly.
10. Check that the resulting graph should load sensibly in Protégé.

If something in the source ontology appears semantically questionable, do not silently compensate for it in the world-links ontology. Call it out separately.

---

## Output

Create the complete Turtle file:

`<source-name>_world_links.ttl`

Return the file for download.

Also provide a short explanation of:

* the major external concepts added
* important Wikidata or other external mappings
* how ML outputs were connected to real-world concepts
* any mappings you deliberately did **not** make because they were uncertain
* any modeling issues discovered in the source ontology

Do not merely provide suggestions or a sample fragment. Produce the complete companion ontology.
