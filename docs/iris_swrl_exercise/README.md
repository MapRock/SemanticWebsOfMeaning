# SWRL Exercise with iris_rdf.rdf

Put your existing iris_rdf.rdf into the <i>apache-jena-fuseki-6.x.x</i> directory with these three additional files. First create iris-test.ttl:
@prefix ex: <https://example.org/iris/> .

```turtle
ex:TestIris
    a ex:Iris ;
    ex:hasSepalLength 6.1 ;
    ex:hasSepalWidth 2.8 ;
    ex:hasPetalLength 4.7 ;
    ex:hasPetalWidth 1.2 .
```

Those values should classify as Versicolor-like.

Next save this as iris-kmeans.rules:

```turtle
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>.
@prefix ex:  <https://example.org/iris/>.

# ---------------------------------------------------------
# K-Means cluster 0: Versicolor-like
# centroid = 5.9016129, 2.7483871, 4.39354839, 1.43387097
# ---------------------------------------------------------

[versicolorDistance:
    (?i rdf:type ex:Iris)
    (?i ex:hasSepalLength ?sl)
    (?i ex:hasSepalWidth ?sw)
    (?i ex:hasPetalLength ?pl)
    (?i ex:hasPetalWidth ?pw)

    difference(?sl, 5.9016129, ?d1)
    product(?d1, ?d1, ?d1sq)

    difference(?sw, 2.7483871, ?d2)
    product(?d2, ?d2, ?d2sq)

    difference(?pl, 4.39354839, ?d3)
    product(?d3, ?d3, ?d3sq)

    difference(?pw, 1.43387097, ?d4)
    product(?d4, ?d4, ?d4sq)

    sum(?d1sq, ?d2sq, ?s1)
    sum(?d3sq, ?d4sq, ?s2)
    sum(?s1, ?s2, ?distance)

 ->
    (?i ex:distanceToVersicolorCentroid ?distance)
]


# ---------------------------------------------------------
# K-Means cluster 1: Setosa-like
# centroid = 5.006, 3.428, 1.462, 0.246
# ---------------------------------------------------------

[setosaDistance:
    (?i rdf:type ex:Iris)
    (?i ex:hasSepalLength ?sl)
    (?i ex:hasSepalWidth ?sw)
    (?i ex:hasPetalLength ?pl)
    (?i ex:hasPetalWidth ?pw)

    difference(?sl, 5.006, ?d1)
    product(?d1, ?d1, ?d1sq)

    difference(?sw, 3.428, ?d2)
    product(?d2, ?d2, ?d2sq)

    difference(?pl, 1.462, ?d3)
    product(?d3, ?d3, ?d3sq)

    difference(?pw, 0.246, ?d4)
    product(?d4, ?d4, ?d4sq)

    sum(?d1sq, ?d2sq, ?s1)
    sum(?d3sq, ?d4sq, ?s2)
    sum(?s1, ?s2, ?distance)

 ->
    (?i ex:distanceToSetosaCentroid ?distance)
]


# ---------------------------------------------------------
# K-Means cluster 2: Virginica-like
# centroid = 6.85, 3.07368421, 5.74210526, 2.07105263
# ---------------------------------------------------------

[virginicaDistance:
    (?i rdf:type ex:Iris)
    (?i ex:hasSepalLength ?sl)
    (?i ex:hasSepalWidth ?sw)
    (?i ex:hasPetalLength ?pl)
    (?i ex:hasPetalWidth ?pw)

    difference(?sl, 6.85, ?d1)
    product(?d1, ?d1, ?d1sq)

    difference(?sw, 3.07368421, ?d2)
    product(?d2, ?d2, ?d2sq)

    difference(?pl, 5.74210526, ?d3)
    product(?d3, ?d3, ?d3sq)

    difference(?pw, 2.07105263, ?d4)
    product(?d4, ?d4, ?d4sq)

    sum(?d1sq, ?d2sq, ?s1)
    sum(?d3sq, ?d4sq, ?s2)
    sum(?s1, ?s2, ?distance)

 ->
    (?i ex:distanceToVirginicaCentroid ?distance)
]


# ---------------------------------------------------------
# Pick nearest centroid.
#
# Cluster numbering here follows the sklearn model:
#   0 = Versicolor-like
#   1 = Setosa-like
#   2 = Virginica-like
#
# The asymmetric <= / < also gives deterministic
# tie-breaking in cluster-number order.
# ---------------------------------------------------------

[classifyVersicolor:
    (?i ex:distanceToVersicolorCentroid ?dv)
    (?i ex:distanceToSetosaCentroid ?ds)
    (?i ex:distanceToVirginicaCentroid ?dvi)

    le(?dv, ?ds)
    le(?dv, ?dvi)

 ->
    (?i rdf:type ex:IrisCluster_VersicolorLike)
]


[classifySetosa:
    (?i ex:distanceToVersicolorCentroid ?dv)
    (?i ex:distanceToSetosaCentroid ?ds)
    (?i ex:distanceToVirginicaCentroid ?dvi)

    lessThan(?ds, ?dv)
    le(?ds, ?dvi)

 ->
    (?i rdf:type ex:IrisCluster_SetosaLike)
]


[classifyVirginica:
    (?i ex:distanceToVersicolorCentroid ?dv)
    (?i ex:distanceToSetosaCentroid ?ds)
    (?i ex:distanceToVirginicaCentroid ?dvi)

    lessThan(?dvi, ?dv)
    lessThan(?dvi, ?ds)

 ->
    (?i rdf:type ex:IrisCluster_VirginicaLike)
]
```

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
