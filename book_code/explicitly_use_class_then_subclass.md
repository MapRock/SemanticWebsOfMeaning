
# Using Subclass Inference Without Overstating the Model

Throughout the book I mostly follow a consistent modeling practice. That is, I usually declare only the most direct and meaningful `rdfs:subClassOf` relationships and let inference do the rest.

Consider the following declarations:

```turtle
ex:MainDish
    rdfs:subClassOf rdfs:Class .

ex:KalbiPlate
    rdfs:subClassOf ex:MainDish ;
    rdfs:label "Kalbi Plate" .

ex:KoreanKalbiPlate
    rdfs:subClassOf ex:KoreanMainDish, ex:KalbiPlate ;
    rdfs:label "Kalbi Plate" .
```

Because `rdfs:subClassOf` is used, a reasoner can infer the following without any additional statements:

```turtle
ex:KalbiPlate      a rdfs:Class .
ex:KoreanKalbiPlate a rdfs:Class .
ex:KoreanKalbiPlate rdfs:subClassOf ex:MainDish .
```

In other words, once `KoreanKalbiPlate` is declared as a subclass of both `KalbiPlate` and `KoreanMainDish`, the broader classification (`KoreanKalbiPlate` is a kind of `MainDish`) follows automatically. There is no need to restate every inherited superclass on every subclass.

A more explicit style is also valid:

```turtle
ex:KoreanKalbiPlate a rdfs:Class ;
    rdfs:subClassOf ex:KoreanMainDish, ex:KalbiPlate, ex:MainDish .
```

This approach can be useful for tools, validators, or when maximum clarity is required. However, it tends to produce repetitive and verbose graphs. The practice used in this book is more economical: declare the direct, meaningful relationships and allow the model’s built-in inference rules to do their work.

It is a deliberate modeling choice that reflects one of the core strengths of RDF and OWL — the ability to state what is necessary and infer what follows.
