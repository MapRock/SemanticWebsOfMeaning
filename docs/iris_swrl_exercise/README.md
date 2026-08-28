# SWRL Exercise with iris_rdf.rdf

Put your existing iris_rdf.rdf into the <i>apache-jena-fuseki-6.x.x</i> directory with these three additional files. 

iris-test.ttl

Those values should classify as Versicolor-like.

Next save this as iris-kmeans.rules:



Those are the actual centroids produced by your KMeans(n_clusters=3, random_state=42, n_init=10) Iris model, rather than the approximate threshold rules.

Create iris-fuseki.ttl in the same directory:

```turtle
PREFIX rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:   <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ja:     <http://jena.hpl.hp.com/2005/11/Assembler#>
PREFIX fuseki: <http://jena.apache.org/fuseki#>

<#service>
    rdf:type fuseki:Service ;
    fuseki:name "iris" ;

    fuseki:endpoint [
        fuseki:operation fuseki:query ;
        fuseki:name "sparql"
    ] ;

    fuseki:dataset <#dataset> .


<#dataset>
    rdf:type ja:RDFDataset ;
    ja:defaultGraph <#infGraph> .


<#infGraph>
    rdf:type ja:InfModel ;

    ja:baseModel <#baseModel> ;

    ja:reasoner [
        ja:reasonerURL
            <http://jena.hpl.hp.com/2003/GenericRuleReasoner> ;

        ja:rulesFrom
            <file:iris-kmeans.rules>
    ] .


<#baseModel>
    rdf:type ja:MemoryModel ;

    ja:content [
        ja:externalContent <file:iris_rdf.rdf>
    ] ;

    ja:content [
        ja:externalContent <file:iris-test.ttl>
    ] .
```

This is the standard Jena assembler pattern: an InfModel wraps a base model and uses a GenericRuleReasoner whose rules are loaded with ja:rulesFrom.

From that directory, start Fuseki:

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

SELECT ?cluster
WHERE {
    ex:TestIris a ?cluster .

    VALUES ?cluster {
        ex:IrisCluster_SetosaLike
        ex:IrisCluster_VersicolorLike
        ex:IrisCluster_VirginicaLike
    }
}
```

You should get:

```text
IrisCluster_VersicolorLike
```

For debugging, this query is also useful:

```sparql
PREFIX ex: <https://example.org/iris/>

SELECT ?setosa ?versicolor ?virginica
WHERE {
    ex:TestIris
        ex:distanceToSetosaCentroid ?setosa ;
        ex:distanceToVersicolorCentroid ?versicolor ;
        ex:distanceToVirginicaCentroid ?virginica .
}
```

With the test values above, you should see squared distances approximately:
```text
Setosa       12.986
Versicolor    0.191
Virginica     2.482
```

So you can visually verify that Versicolor is the nearest centroid before even checking the inferred class.
