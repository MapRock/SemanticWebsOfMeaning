# Appendix B: Additional Domain-Centric Vocabularies and Standards
<i>This appendix accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>

These vocabularies do not all play the same role. Some are domain ontologies, some are code systems, some are RDF vocabularies, and some are standards for representing rules or spatial data. The common thread is that each provides a shared language for a domain.

A knowledge graph becomes more useful when it does not invent every term from scratch. Where a mature vocabulary exists, the graph can reuse it, align to it, or at least record mappings to it. That makes the graph easier to integrate, easier to explain, and easier to connect to outside systems.

## Gene Ontology

The Gene Ontology, usually abbreviated **GO**, is one of the central vocabularies in biomedical research. It is used to describe the functions of gene products across species in a consistent way. GO is organized around three broad areas: molecular function, biological process, and cellular component. The Gene Ontology Resource describes GO as a computational model of biological systems and as a major machine-readable source for information about gene function.

In a knowledge graph, GO is useful when the graph needs to connect genes, proteins, biological functions, pathways, and experimental annotations. It helps avoid treating gene-function descriptions as plain text.

**Common URI pattern:**

`http://purl.obolibrary.org/obo/GO_0008150`

**Examples:**

- `GO:0008150` — biological_process
- `GO:0003674` — molecular_function
- `GO:0005575` — cellular_component

**Example triple-style usage:**

```turtle
:GeneProduct123 :hasBiologicalProcess <http://purl.obolibrary.org/obo/GO_0008150> .
```

## ChEBI

**ChEBI**, or Chemical Entities of Biological Interest, is an ontology and database for chemical entities. It is especially useful for chemistry, biochemistry, pharmacology, toxicology, and biological research. ChEBI describes molecular entities, chemical classes, roles, and biologically relevant compounds. The European Bioinformatics Institute describes ChEBI as an open-access database and ontology of chemical entities, including atoms, molecules, ions, radicals, complexes, and related chemical forms.

In a knowledge graph, ChEBI is useful when chemical names need stable identifiers. For example, a graph should not rely only on the string “water,” “caffeine,” or “glucose.” Those names should point to identifiable chemical entities.

**Common URI pattern:**

`http://purl.obolibrary.org/obo/CHEBI_15377`

**Examples:**

- `CHEBI:15377` — water
- `CHEBI:17234` — glucose
- `CHEBI:27732` — caffeine

**Example triple-style usage:**

```turtle
:SampleA :containsChemical <http://purl.obolibrary.org/obo/CHEBI_15377> .
```

## RxNorm

**RxNorm** is a normalized naming system for clinical drugs, produced by the U.S. National Library of Medicine. Its purpose is to support semantic interoperability between different drug vocabularies and pharmacy systems. NLM describes RxNorm as both a normalized naming system for generic and branded drugs and a tool for semantic interoperation between drug terminologies and pharmacy knowledge-base systems.

In a knowledge graph, RxNorm is useful when connecting prescriptions, medications, drug ingredients, branded drugs, and clinical drug records. It is especially helpful because different systems may use different names for the same medication.

**Common identifier pattern:**

`RXCUI:198013`

For RDF or linked-data-style use, many systems mint or map RxNorm concepts into local URI patterns, for example:

`https://example.org/rxnorm/RXCUI/198013`

**Examples:**

- `RXCUI:198013` — naproxen 250 MG Oral Tablet
- `RXCUI:617314` — atorvastatin 20 MG Oral Tablet

**Example triple-style usage:**

```turtle
:Prescription456 :prescribedDrug :RxNorm_198013 .
```

## ICD

**ICD**, the International Classification of Diseases, is used for diseases, diagnoses, causes of death, health reporting, billing, epidemiology, and healthcare administration. ICD is maintained by the World Health Organization. ICD-11 uses URIs as unique identifiers for classification entities, and the WHO ICD API exposes those entities through HTTP endpoints.

In a knowledge graph, ICD is useful when a diagnosis needs to connect to reporting, classification, public health, billing, or analytics. It is more classification-oriented than SNOMED CT, which is generally richer as a clinical terminology.

**Common ICD-11 URI pattern:**

`http://id.who.int/icd/entity/257068234`

**Examples:**

- `http://id.who.int/icd/entity/257068234` — cholera
- ICD-10 example code: `E11` — Type 2 diabetes mellitus
- ICD-10 example code: `I10` — Essential hypertension

**Example triple-style usage:**

```turtle
:Diagnosis789 :classifiedAs <http://id.who.int/icd/entity/257068234> .
```

## CPT

**CPT**, or Current Procedural Terminology, is the major U.S. code set for reporting medical services and procedures. The American Medical Association describes CPT as a listing of descriptive terms and five-digit codes for medical services and procedures performed by physicians and other qualified healthcare professionals. CPT is widely used by providers, payers, regulators, vendors, and healthcare technology organizations.

CPT is important for healthcare knowledge graphs because procedures are different from diagnoses. A patient may have an ICD-coded condition, a SNOMED CT clinical concept, an RxNorm medication, and a CPT-coded procedure. Those should not be collapsed into one kind of “medical thing.”

CPT is also different from some open Semantic Web vocabularies because it is copyrighted and licensed by the AMA. For a knowledge graph, CPT codes are often represented as controlled identifiers inside a licensed or internal terminology model rather than as freely dereferenceable public RDF URIs.

**Common code pattern:**

`CPT:99213`

**Examples:**

- `99213` — office or other outpatient visit
- `93000` — electrocardiogram

**Example local URI pattern:**

`https://example.org/cpt/99213`

**Example triple-style usage:**

```turtle
:Encounter123 :includedProcedure :CPT_99213 .
```
Note: CPT is copyrighted and licensed by the AMA, so a production knowledge graph using CPT content should obtain the appropriate license.

## LegalRuleML

**LegalRuleML** is a standard for representing legal norms, policies, guidelines, and legal reasoning structures in machine-readable form. It extends RuleML with features specific to the legal domain. OASIS describes LegalRuleML as a way to model legal norms, guidelines, policies, and reasoning.

In a knowledge graph context, LegalRuleML is useful when a graph needs to represent obligations, permissions, prohibitions, exceptions, penalties, or rule-based legal interpretations. It is less about naming legal documents and more about representing legal rules.

**Namespace URI:**

`http://docs.oasis-open.org/legalruleml/ns/v1.0/`

OASIS also defines a metadata namespace:

`http://docs.oasis-open.org/legalruleml/ns/mm/v1.0/`

**Examples of legal-rule concepts:**

| Legal-rule concept | Description                                                                              |
| ------------------ | ---------------------------------------------------------------------------------------- |
| **Obligation**     | Something a person, organization, or other party is required to do.                      |
| **Permission**     | Something a party is allowed to do, even if it is not required.                          |
| **Prohibition**    | Something a party is not allowed to do.                                                  |
| **Penalty**        | A consequence that may apply when an obligation is not met or a prohibition is violated. |
| **Exception**      | A condition under which a general rule does not apply or applies differently.            |
| **Jurisdiction**   | The legal or organizational context in which a rule has authority or applies.            |


**Conceptual RDF representation inspired by the kinds of legal semantics represented by LegalRuleML:**

```turtle
:LeaseRule42 :createsObligation :TenantPaymentObligation .
:TenantPaymentObligation :appliesTo :Tenant .
```

## GeoSPARQL

**GeoSPARQL** is an Open Geospatial Consortium standard for representing and querying geospatial data in RDF. It defines both a vocabulary for geographic features and geometries and extensions to SPARQL for spatial queries. The OGC describes GeoSPARQL as supporting representation and querying of geospatial data on the Semantic Web.

In a knowledge graph, GeoSPARQL is useful when entities have locations, boundaries, distances, containment relationships, or spatial intersections. It helps express questions such as “Which stores are within this region?” or “Which properties intersect this flood zone?”

**Namespace URI:**

`http://www.opengis.net/ont/geosparql#`

**Common prefix:**

```turtle
@prefix geo: <http://www.opengis.net/ont/geosparql#> .
```

**Examples:**

- `geo:Feature`
- `geo:Geometry`
- `geo:hasGeometry`
- `geo:asWKT`

**Example triple-style usage:**

```turtle
:Store123 a geo:Feature ;
    geo:hasGeometry :Store123Geometry .

:Store123Geometry geo:asWKT "POINT(-116.2023 43.6150)"^^geo:wktLiteral .
```

## FOAF

**FOAF**, or Friend of a Friend, is an RDF vocabulary for describing people, organizations, documents, accounts, and social relationships. The FOAF specification describes it as a dictionary of named properties and classes using RDF technology, with a focus on linking people and information on the Web.

FOAF is not a modern enterprise identity-management system, but it remains historically and conceptually important. It is a simple example of how RDF can describe people and relationships without depending on one centralized database.

**Namespace URI:**

`http://xmlns.com/foaf/0.1/`

**Common prefix:**

```turtle
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
```

**Examples:**

- `foaf:Person`
- `foaf:Organization`
- `foaf:name`
- `foaf:knows`
- `foaf:mbox`
- `foaf:homepage`

**Example triple-style usage:**

```turtle
:Alice a foaf:Person ;
    foaf:name "Alice Chen" ;
    foaf:knows :Bob .
```
