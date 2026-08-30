# SWRL Rules Exercise with iris_rdf.rdf

This exercise uses Apache Jena Rules rather than a SWRL execution engine. The rules reproduce the nearest-centroid logic of the trained Iris K-Means model. Apache Jena Fuseki loads the RDF model and test observation, applies the Jena rule reasoner, and exposes the inferred classification through SPARQL.

Copy these files into the <i>apache-jena-fuseki-6.x.x</i> directory with these three additional files. See [install_jena_fuseki.md](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/install_jena_fuseki.md).

| File                | Brief description                                                                                                                                                                              |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`iris_rdf.rdf`](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/book_code/iris_rdf.rdf)      | The semantic description of the trained Iris K-Means model. It defines the model, learned cluster classes, cluster-result individuals, centroids, provenance, and related ontology terms.      |
| [`iris-test.ttl`](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/docs/iris_swrl_exercise/iris-test.ttl)     | A small test input containing a new Iris individual with sepal and petal measurements to classify.                                                                                             |
| [`iris-kmeans.rules`](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/docs/iris_swrl_exercise/iris-kmeans.rules) | Jena rules that reproduce the K-Means nearest-centroid logic by calculating the distance from the test Iris to each learned centroid and inferring the closest cluster class.                  |
| [`iris-fuseki.ttl`](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/docs/iris_swrl_exercise/iris-fuseki.ttl)   | The Fuseki/Jena assembler configuration that loads the RDF model and test data, attaches the Jena rule reasoner, and exposes the resulting inferred graph through the `/iris` SPARQL endpoint. |




This is the standard Jena assembler pattern: an InfModel wraps a base model and uses a GenericRuleReasoner whose rules are loaded with ja:rulesFrom.

Using PowerShell, navigate to that directory:
```text
cd C:\temp\apache-jena-fuseki-6.1.0
```

Start Fuseki:

```bat
fuseki-server.bat --conf=iris-fuseki.ttl
```

Then open the Fuseki UI and select the iris dataset, or query the endpoint at:

```bat
http://localhost:3030/iris/sparql
```
Fuseki supports assembler configuration files exactly this way.

Run this SPARQL:

```sparql
PREFIX ex: <https://example.org/iris/>

SELECT ?iris ?cluster
WHERE {
    ?iris a ex:Iris ;
          a ?cluster .

    VALUES ?cluster {
        ex:IrisCluster_SetosaLike
        ex:IrisCluster_VersicolorLike
        ex:IrisCluster_VirginicaLike
    }
}
ORDER BY ?iris
```

You should get:

```text
IrisCluster_VersicolorLike
```

For debugging, this query is also useful:

```sparql
PREFIX ex: <https://example.org/iris/>

SELECT ?iris ?setosa ?versicolor ?virginica
WHERE {
    ?iris
        ex:distanceToSetosaCentroid ?setosa ;
        ex:distanceToVersicolorCentroid ?versicolor ;
        ex:distanceToVirginicaCentroid ?virginica .
}
ORDER BY ?iris
```

With the test values above, you should see squared distances approximately:
```text
Setosa       12.986
Versicolor    0.191
Virginica     2.482
```

So you can visually verify that Versicolor is the nearest centroid before even checking the inferred class.
