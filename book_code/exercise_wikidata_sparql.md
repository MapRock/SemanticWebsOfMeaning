# Wikidata SPARQL Hello World Tutorial

## Connecting to Your `programmers.ttl` File

This is a short, practical introduction to SPARQL using the public Wikidata Query Service. The examples focus on programming languages, so they connect directly to the languages defined in your `programmers.ttl` file:

* CSharp
* Python
* JavaScript
* SQL

---


# Basic Query Structure

Most queries follow this pattern:

```sparql
SELECT ?variable1 ?variable2
WHERE {
  your conditions go here

  SERVICE wikibase:label { 
    bd:serviceParam wikibase:language "en". 
  }
}
LIMIT 20
```

The `SERVICE wikibase:label` part gives you readable names instead of Wikidata IDs.

| Code | Type | Meaning |
|---|---|---|
| `wdt:P31` | Property | “is an instance of” — used to say something is a programming language |
| `wd:Q9143` | Item | The concept “programming language” |
| `wdt:P3966` | Property | “has paradigm” — used to get whether it is object-oriented, functional, etc. |
| `wd:Q79872` | Item | The concept “object-oriented programming” |
| `wdt:P571` | Property | “inception” — when it was created |
| `wdt:P178` | Property | “developer” — who created it |
|

**Figure 7 - Wikidata QIDs used in this tutorial.**

| Prefix | Meaning | Example |
|---|---|---|
| `wd:` | Wikidata Item: a thing or concept | `wd:Q9143` |
| `wdt:` | Wikidata Property: a relationship | `wdt:P31` |

---

# Examples

Go to this address in your browser: Go to this address in your browser: <a href="https://query.wikidata.org/" target="_blank">https://query.wikidata.org/</a>


You will see a large text box where you can write and run queries.

## Query 1 — Hello World: List Programming Languages

**Figure SQ1 - Get all programming languages.**

```sparql
SELECT ?language ?languageLabel
WHERE {
  ?language wdt:P31 wd:Q9143 .

  SERVICE wikibase:label { 
    bd:serviceParam wikibase:language "en". 
  }
}
LIMIT 20
```

This returns a list of programming languages.

In this query:

```text
wd:Q9143
```

means:

```text
programming language
```

---

## Query 2 — Add Year Created

```sparql
SELECT ?language ?languageLabel ?year
WHERE {
  ?language wdt:P31 wd:Q9143 ;
            wdt:P571 ?inception .

  BIND(YEAR(?inception) AS ?year)

  SERVICE wikibase:label { 
    bd:serviceParam wikibase:language "en". 
  }
}
ORDER BY ?year
LIMIT 15
```

This adds the year each language was created.

You can now see when Python, C#, and JavaScript first appeared.

---

## Query 3 — Only Object-Oriented Languages

```sparql
SELECT ?language ?languageLabel WHERE {
  ?language wdt:P3966 wd:Q79872 .   # programming paradigm = object-oriented programming
  SERVICE wikibase:label { bd:serviceParam wikibase:language "en" . }
}
LIMIT 20
```

This filters the results to only languages that are object-oriented, matching the `ObjectOrientedProgrammer` and `ObjectOrientedLanguage` classes in the file.

---

## Query 4 — Languages and Their Creators

```sparql
SELECT ?language ?languageLabel ?creatorLabel ?year
WHERE {
  ?language wdt:P31 wd:Q9143 ;
            wdt:P571 ?inception .

  BIND(YEAR(?inception) AS ?year)

  OPTIONAL { 
    ?language wdt:P178 ?creator . 
  }

  SERVICE wikibase:label { 
    bd:serviceParam wikibase:language "en". 
  }
}
ORDER BY DESC(?year)
LIMIT 15
```

This shows who created each language when that information exists.

The `OPTIONAL` keyword means the query still works even if some languages have no creator listed.

---

## Query 5 — Count Languages by Paradigm

```sparql
SELECT ?paradigmLabel (COUNT(?language) AS ?count)
WHERE {
  ?language wdt:P31 wd:Q9143 ;
            wdt:P3966 ?paradigm .

  SERVICE wikibase:label { 
    bd:serviceParam wikibase:language "en". 
  }
}
GROUP BY ?paradigmLabel
ORDER BY DESC(?count)
LIMIT 15
```

This shows how many languages exist for each paradigm.

It introduces grouping and counting.

---

# How This Connects to `programmers.ttl` File

Your file already defines these languages:

* C#
* Python
* JavaScript
* SQL

You can use the queries above to pull real data from Wikidata about them.

For example:

* Use Query 2 to get the actual creation year for Python, C#, and JavaScript.
* Use Query 3 to confirm which of your languages are object-oriented.
* Use Query 4 to see who created them, when known.

You can then take that information and add it to the local file.

For instance, you could add statements like:

```turtle
:Python :inceptionYear 1991 .
:CSharp :paradigm :ObjectOrientedLanguage .
```

This is a common and powerful pattern:

```text
Use Wikidata as a source of structured data to enrich your own knowledge graph.
```

---

# Next Steps

Once you are comfortable with these queries, you can:

* Increase the `LIMIT` value to see more results.
* Add more properties from Wikidata.
* Run these queries from Python or from your own Fuseki server instead of the web interface.

The SPARQL endpoint address is:

```text
https://query.wikidata.org/sparql
```

This gives you a simple starting point that directly relates to the `Programmer`, `ProgrammingLanguage`, and `ObjectOrientedProgrammer` classes in the `programmers.ttl` file.
