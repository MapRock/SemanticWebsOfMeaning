<i>This document accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>

# Why This Book Does Not Emphasize Graph Visualization

Knowledge graphs are often introduced through attractive diagrams: colored circles, labeled arrows, expandable neighborhoods, and force-directed layouts. Those views are useful. They make relationships easier to grasp and can help nontechnical users explore a graph without first learning SPARQL.

However, graph visualization is not the main subject of this book.

The book focuses on the more fundamental work of:

- encoding knowledge explicitly in RDF and OWL;
- identifying resources with IRIs;
- defining classes, properties, and constraints;
- retrieving knowledge with SPARQL;
- applying rules and reasoners;
- distinguishing asserted facts from inferred knowledge; and
- understanding how a machine can derive a conclusion from connected facts.

A polished graph viewer can make those results easier to inspect, but it does not create the semantics or perform the reasoning. The visual interface is a presentation layer over the knowledge graph.

## The Practical Decision Made for the Book

The examples in this book use **Protégé** for ontology authoring and inspection, and **Apache Jena Fuseki** for RDF storage, SPARQL queries, and rule-based inference.

Protégé includes hierarchy views and basic graph visualization, including tools such as OntoGraf. These views are adequate for authoring and checking a small ontology, although they are not as polished or intuitive as the graph exploration interfaces available in products such as Stardog, GraphDB, or Neo4j.

Fuseki is primarily a SPARQL server. Its interface is well suited to loading RDF, running SPARQL queries, and examining query results. It is not intended to be a complete visual knowledge-graph exploration product.

It is possible to add a more attractive graph interface to Fuseki, but doing so introduces another product, application, configuration, or custom development task. For the purposes of this book, that would add a disproportionate amount of setup and explanation for something that is not central to the subject. The goal is to demonstrate how knowledge is represented and how inferences are retrieved—not to build a graph visualization application.

For that reason, Protégé's visualization will have to do for hands-on inspection, while carefully constructed figures in the book will present the graph more clearly. Those figures may resemble the output of an interactive graph browser, but they are designed to communicate a specific example rather than reproduce every technical detail in the underlying RDF graph.

## Visualization Is Usually Available in a Production Platform

A proof of concept or production knowledge-graph implementation will often use a platform that already includes a richer visual interface.

| Product | Native graph model | Query language | Visualization | RDF position |
|---|---|---|---|---|
| **Protégé** | RDF/OWL ontology | SPARQL through plugins and associated tools | Basic ontology and graph views | Native RDF/OWL authoring environment |
| **Apache Jena Fuseki** | RDF | SPARQL | Primarily query and dataset administration | Native RDF/SPARQL server |
| **GraphDB** | RDF | SPARQL | Workbench Visual Graph, class hierarchy, and relationship exploration | Native RDF platform |
| **Stardog** | RDF knowledge graph and virtual graphs | SPARQL | Stardog Explorer, Designer, and Studio | Native RDF enterprise platform |
| **Neo4j** | Labeled property graph | Cypher | Neo4j Browser and related visual tools | RDF supported through extensions such as Neosemantics, but RDF is not the native model |
| **AWS Graph Explorer** | Visualization client rather than a database | SPARQL, openCypher, or Gremlin depending on the endpoint | Interactive graph exploration | Can connect to an HTTP endpoint supporting RDF/SPARQL |
| **Cytoscape.js** | Client-side graph model | Application-defined | Fully customizable interactive visualization | RDF results must be converted into nodes and edges |

GraphDB and Stardog are natural choices when an organization wants RDF-native storage, inference, governance, and visual exploration in a more integrated platform. They also introduce product-specific deployment, licensing, administration, and architectural decisions. Those concerns are reasonable in an enterprise implementation, but they are unnecessary overhead for the small educational examples in this book.

Neo4j provides one of the most approachable graph experiences, particularly for developers who want to explore nodes and relationships visually. However, Neo4j is natively a labeled property graph platform using Cypher rather than an RDF triple store using SPARQL. Its Neosemantics extension can import and export RDF, work with OWL, RDFS, and SKOS vocabularies, validate with SHACL, and provide basic inferencing. This makes Neo4j a viable bridge into RDF, but it does not change the central architectural distinction: RDF support is added to a property-graph platform rather than being the platform's native foundation.


## Separation of Responsibilities

The book's tool choices can be understood as a separation of concerns:

| Layer                               | Role                                                                                                      |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------- |
| **Protégé**                         | Author and inspect the ontology, including classes, properties, restrictions, and inferred relationships. |
| **RDF / OWL files**                 | Store the ontology and graph statements in a portable, standards-based form.                              |
| **Apache Jena Fuseki**              | Store RDF, execute SPARQL queries, apply reasoning, and return both asserted and inferred results.        |
| **Book figures or optional viewer** | Present the graph visually so people can understand the structure and relationships more intuitively.     |


This separation is not a limitation of RDF. It is a normal software architecture. The database and reasoner do not need to be the same component as the user interface.

At enterprise scale, a product such as Stardog or GraphDB may package more of these responsibilities together. In a custom application, Fuseki can remain the RDF and inference engine while another component supplies visualization.

# Optional Visualization Paths for the GitHub Tutorials

The GitHub repository may eventually include tutorials for readers who want a more intuitive graph interface. The following approaches preserve the book's RDF focus while adding visual exploration.

## Option 1: Load the Example into GraphDB

GraphDB is likely the simplest path to a polished RDF-native visual experience.

A tutorial could:

1. Install GraphDB Free or use an appropriate GraphDB environment.
2. Create a repository with the desired ruleset.
3. Import the Turtle files used in the book.
4. Open **Explore → Visual Graph** in GraphDB Workbench.
5. Search for a resource such as a programmer, programming language, or inferred class.
6. Expand neighboring resources interactively.
7. Configure labels and relationship queries so that human-readable names appear instead of full IRIs.
8. Compare an asserted relationship with an inferred `rdf:type`.

This would let readers see essentially the same RDF graph in a richer interface without translating it into a property-graph model.

GraphDB also supports configurable visual graph queries. A focused tutorial could provide a visual configuration that emphasizes only the classes and predicates used in the book rather than displaying every RDF and OWL implementation detail.

## Option 2: Load the Example into Stardog

Stardog is another RDF-native option and is especially relevant to enterprise knowledge-graph work.

A tutorial could:

1. Create a Stardog database.
2. Load the book's ontology and instance data.
3. enable the appropriate reasoning level;
4. run the same SPARQL queries used in the Fuseki examples;
5. browse the graph through Stardog Explorer;
6. inspect the model through Stardog Designer or Studio; and
7. compare the inferred results returned by Stardog with those returned by Jena.

This would be useful not merely as a visualization tutorial, but also as a comparison of inference behavior, rule support, deployment style, and enterprise tooling.

## Option 3: Place AWS Graph Explorer in Front of Fuseki

AWS Graph Explorer is an open-source React application for exploring graph data. It supports RDF graphs exposed through an HTTP SPARQL endpoint, as well as property-graph endpoints using openCypher or Gremlin.

The conceptual architecture would be:

```text
Browser
   |
   v
AWS Graph Explorer
   |
   | SPARQL over HTTP
   v
Apache Jena Fuseki
```

A tutorial would need to address:

- the Fuseki SPARQL endpoint URL;
- browser access and Cross-Origin Resource Sharing configuration;
- authentication, if the endpoint is protected;
- whether a small proxy service is needed between the browser and Fuseki;
- resource labels, because raw IRIs make a graph difficult to read;
- limits on the number of returned nodes and edges; and
- queries used to retrieve neighboring resources.

A bounded query is important. Sending an entire RDF dataset to a browser is rarely useful, even when the dataset is not especially large. A graph explorer should usually begin with one resource and retrieve only a limited neighborhood.

For example:

```sparql
PREFIX : <http://example.org/programmers#>

CONSTRUCT {
    ?programmer a ?programmerType ;
                :knowsLanguage ?language .

    ?language a ?languageType .
}
WHERE {
    VALUES ?programmer { :Eugene }

    OPTIONAL {
        ?programmer a ?programmerType .
    }

    OPTIONAL {
        ?programmer :knowsLanguage ?language .
        OPTIONAL {
            ?language a ?languageType .
        }
    }
}
```

The viewer could then expand a selected node by issuing another bounded SPARQL query.

AWS Graph Explorer is more work than using GraphDB Workbench or Stardog Explorer, but it allows Fuseki to remain the RDF server and reasoner.

## Option 4: Build a Small Cytoscape.js Viewer

Cytoscape.js is a JavaScript library for interactive graph visualization and analysis. It is not a knowledge-graph database and does not understand RDF directly. An application must query Fuseki and translate the results into Cytoscape's node-and-edge structure.

The architecture could be kept small:

```text
Fuseki SPARQL endpoint
          |
          v
Small Python, Node.js, or browser-side adapter
          |
          | JSON nodes and edges
          v
Cytoscape.js
```

### Querying Fuseki

A `SELECT` query can return triples or a more application-specific result:

```sparql
SELECT ?source ?predicate ?target
WHERE {
    VALUES ?source {
        <http://example.org/programmers#Eugene>
    }

    ?source ?predicate ?target .
}
LIMIT 100
```

A more selective query will normally produce a clearer diagram:

```sparql
PREFIX : <http://example.org/programmers#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

SELECT ?source ?predicate ?target
WHERE {
    VALUES ?source { :Eugene }

    {
        ?source :knowsLanguage ?target .
        BIND(:knowsLanguage AS ?predicate)
    }
    UNION
    {
        ?source rdf:type ?target .
        BIND(rdf:type AS ?predicate)
    }
}
```

### Converting Results to Cytoscape Elements

The adapter would convert each unique RDF resource into a node:

```json
{
  "data": {
    "id": "http://example.org/programmers#Eugene",
    "label": "Eugene"
  }
}
```

Each RDF statement becomes an edge:

```json
{
  "data": {
    "id": "edge-1",
    "source": "http://example.org/programmers#Eugene",
    "target": "http://example.org/programmers#CSharp",
    "label": "knows language"
  }
}
```

The page could then initialize Cytoscape:

```javascript
const cy = cytoscape({
    container: document.getElementById("graph"),
    elements: graphElements,
    layout: {
        name: "cose"
    },
    style: [
        {
            selector: "node",
            style: {
                "label": "data(label)"
            }
        },
        {
            selector: "edge",
            style: {
                "label": "data(label)",
                "curve-style": "bezier",
                "target-arrow-shape": "triangle"
            }
        }
    ]
});
```

### Features Worth Adding

A book-specific viewer could be more informative than a generic graph browser because it could emphasize reasoning:

- **Asserted only** — show triples explicitly present in the source data.
- **Inferred only** — show conclusions produced by the reasoner.
- **Asserted and inferred** — show both with different visual styles.
- **Show rule** — display the rule responsible for an inferred class or relationship.
- **Expand node** — query Fuseki for a bounded neighborhood.
- **Show IRI** — reveal the full resource identifier when a node is selected.
- **Show source** — link the displayed statement to its Turtle file or named graph.
- **Hide RDF plumbing** — suppress triples such as internal list structures unless requested.

Distinguishing asserted from inferred triples requires some design. Possible approaches include:

1. querying the unreasoned base graph and the inferred graph separately;
2. storing asserted and derived statements in separate named graphs;
3. comparing the reasoner's output with the original source graph; or
4. recording provenance when rules generate derived statements.

The fourth option is the most informative, but it requires more than ordinary RDF inference. A conventional reasoner may return the inferred statement without preserving a complete proof trace. A future tutorial could demonstrate a small provenance structure specifically for the book's rules.

## Option 5: Export a Small Visualization Dataset

Another simple approach is to avoid a live connection entirely.

A script could:

1. run a bounded SPARQL query against Fuseki;
2. export the selected nodes and relationships to JSON;
3. save the JSON beside a static HTML page; and
4. render it with Cytoscape.js.

This is appropriate for documentation, demonstrations, and GitHub Pages because it does not require a running Fuseki server. It also ensures that the graph shown to readers is stable and limited to the concepts being taught.

The disadvantage is that it is not a live explorer. It is a published visual snapshot.

# Why the Book Uses Designed Figures

A raw knowledge graph is often visually noisy. RDF graphs include implementation details that are technically important but distracting in an introductory figure:

| Detail                                | Why it can distract in an introductory figure                                                                                    |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| **Full IRIs**                         | Necessary for unambiguous identity, but often too long and visually dominant for a conceptual diagram.                           |
| **`rdf:type` statements**             | Important for classification, but repeated type edges can overwhelm the relationships the example is trying to explain.          |
| **Ontology declarations**             | Necessary for the formal model, but usually not central to the immediate conceptual point.                                       |
| **Blank nodes**                       | Common in RDF and OWL structures, but can make a graph harder to read because they introduce unnamed intermediate nodes.         |
| **RDF lists**                         | Useful for representing ordered collections and OWL constructs, but often expand into several technical nodes and relationships. |
| **Domain and range statements**       | Important for semantics and inference, but can distract when the figure is focused on a specific instance-level relationship.    |
| **Labels and descriptions**           | Helpful as metadata, but displaying them as graph nodes or edges can add substantial visual noise.                               |
| **Imported vocabularies**             | Provide reusable external semantics, but may introduce many classes and properties unrelated to the immediate example.           |
| **Reasoner-supporting relationships** | Technically important for inference, but not always relevant to the particular conclusion being illustrated.                     |


An automatically generated visualization cannot always know which details matter to the reader. A designed figure can intentionally show:

| Element                                | Purpose in the figure                                                                                      |
| -------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| **Relevant individuals**               | Shows the particular entities involved in the example.                                                     |
| **Relevant classes**                   | Shows the categories to which those individuals belong and the class structure needed for the explanation. |
| **Predicates used by the rule**        | Highlights the specific relationships or properties that participate in the reasoning.                     |
| **Conclusion produced by the rule**    | Makes the inferred result visible rather than requiring the reader to derive it mentally.                  |
| **Asserted versus inferred knowledge** | Distinguishes what was explicitly stated in the graph from what the reasoner derived.                      |


The figure is therefore not pretending to be the knowledge graph itself. It is an explanatory projection of the graph, much as an entity-relationship diagram or dimensional model diagram is a projection of a larger database.

# Recommended Progression

For readers following the book:

1. Use **Protégé** to author and inspect the ontology.
2. Use **Fuseki** to load RDF, execute SPARQL, and retrieve inferred results.
3. Use the book's figures to understand the intended graph structure.
4. Move to **GraphDB** or **Stardog** when a proof of concept requires integrated visual exploration and broader platform capabilities.
5. Try **AWS Graph Explorer** when Fuseki should remain the server but a general-purpose visual client is desired.
6. Use **Cytoscape.js** when a tailored application should show only the graph concepts relevant to a particular audience or use case.

The important point is that visualization is optional, while semantics and inference are foundational. A graph can look impressive while carrying little formal meaning. Conversely, an RDF graph can support precise machine reasoning even when its native user interface is visually plain.

# References

- Apache Jena Fuseki documentation: https://jena.apache.org/documentation/fuseki2/
- Protégé: https://protege.stanford.edu/
- GraphDB Workbench visual exploration: https://graphdb.ontotext.com/documentation/11.3/visualize-and-explore.html
- Stardog applications and Explorer: https://docs.stardog.com/stardog-applications/
- Neo4j Neosemantics: https://neo4j.com/labs/neosemantics/
- AWS Graph Explorer: https://github.com/aws/graph-explorer
- Cytoscape.js: https://js.cytoscape.org/
