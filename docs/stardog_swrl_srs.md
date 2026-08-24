<i>This document accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>


# SWRL Support in Stardog

Stardog can automatically detect and process rules written using the **RDF serialization of SWRL**. It can also translate between SWRL and its native Stardog Rules Syntax (SRS) where possible. Stardog describes SWRL as a proposed rule language layered on OWL. ([Stardog Documentation][1])

With Stardog's established **Blackout** reasoner, user-defined rules are included in the `SL` reasoning type. `SL` is Stardog's default reasoning type and combines the RDFS, OWL 2 QL, RL, and EL reasoning profiles with user-defined rules. ([Stardog Documentation][2])

The reasoning type tells Stardog **which kinds of axioms and rules it may use when reasoning over a query**:

| Reasoning type | What it enables                                                           |
| -------------- | ------------------------------------------------------------------------- |
| `NONE`         | No reasoning                                                              |
| `RDFS`         | RDF Schema reasoning                                                      |
| `QL`           | OWL 2 QL profile                                                          |
| `RL`           | OWL 2 RL profile                                                          |
| `EL`           | OWL 2 EL profile                                                          |
| `SL`           | RDFS + supported QL/RL/EL reasoning + user-defined rules such as SWRL/SRS |

Thus, `SL` is not a more powerful version of SWRL. It is the Stardog reasoning profile that includes user-defined rules. Any axioms outside the selected reasoning type are ignored. ([Stardog Documentation][2])

Older Stardog versions also had a `DL` reasoning type for broader OWL 2 Description Logic reasoning. It was **not** a mode for more complicated SWRL rules and was removed in Stardog 9. ([Stardog Documentation][3])

## Preferred Syntax: Stardog Rules Syntax (SRS)

Stardog's native syntax for user-defined rules is **Stardog Rules Syntax (SRS)**. SRS is based on SPARQL syntax and represents rules as `IF...THEN` statements. Stardog describes its user-defined rules conceptually as Datalog rules over RDF graphs. ([Stardog Documentation][1])

```turtle
IF {
    # SPARQL-like conditions
}
THEN {
    # Triples to infer
}
```

**Example SRS rule**:

```turtle
PREFIX : <http://example.org/>

RULE :CountryOfResidenceRule
IF {
    ?person :hasAddress ?address .
    ?address :country ?country .
}
THEN {
    ?person :countryOfResidence ?country .
}
```

SRS supports triple patterns as well as `FILTER`, `BIND`, and `UNION`. Stardog's newer **Stride** reasoner extends rule support with `VALUES`, aggregation using `GROUP BY`, and `EXISTS`/`NOT EXISTS`. Stride is a separate reasoner implementation; when Stride is enabled, the `reasoning.type` setting such as `SL` no longer applies. ([Stardog Documentation][1])

Stardog can translate between SRS and SWRL where possible. Negation and aggregation available through SRS cannot be represented in SWRL and therefore cannot be translated back to SWRL. ([Stardog Documentation][1])

## Summary

| Feature                                | SWRL         | SRS              | Notes                                 |
| -------------------------------------- | ------------ | ---------------- | ------------------------------------- |
| Basic rules                            | Yes          | Yes              | Both are supported                    |
| SPARQL-style `FILTER`, `BIND`, `UNION` | More limited | Yes              | Native SRS capability                 |
| Negation with `NOT EXISTS`             | No           | Yes, with Stride | Stride feature                        |
| Aggregation / `GROUP BY`               | No           | Yes, with Stride | Stride feature                        |
| Translation                            | Yes          | Yes              | Where the constructs have equivalents |
| Stardog-native authoring syntax        | No           | Yes              | SRS is Stardog's own rule syntax      |

For new Stardog-specific rule development, **SRS is generally the more natural choice** because it is Stardog's native SPARQL-oriented rule syntax. SWRL remains useful when rules need to be represented using the SWRL vocabulary or exchanged with systems that understand SWRL. ([Stardog Documentation][1])

## Example

Here is the same kind of reasoning in Stardog, first in the **preferred** syntax (SRS), then in **SWRL**. Stardog does not materialize inferred triples. With reasoning on, it rewrites the query against the schema (OWL/RDFS + rules) and evaluates that rewritten query.

Use `reasoning.type=SL` (default, Blackout) for SWRL/SRS. Advanced constructs (`NOT EXISTS`, `GROUP BY`) need the Stride reasoner.

---

### 1. Same rule: country of residence

**SRS (preferred)** — SPARQL-shaped, what you should write for new Stardog work:

```turtle
PREFIX : <http://example.org/>

:Alice a :Person ;
       :hasAddress :Addr1 .
:Addr1 :country :USA .

RULE :CountryOfResidenceRule
IF {
    ?person :hasAddress ?address .
    ?address :country ?country .
}
THEN {
    ?person :countryOfResidence ?country .
}
```

Equivalent stored form (standard RDF, good for `INSERT DATA`):

```turtle
PREFIX rule: <tag:stardog:api:rule:>
PREFIX : <http://example.org/>

:CountryOfResidenceRule a rule:SPARQLRule ;
    rule:content """
        PREFIX : <http://example.org/>
        RULE :CountryOfResidenceRule
        IF {
            ?person :hasAddress ?address .
            ?address :country ?country .
        }
        THEN {
            ?person :countryOfResidence ?country .
        }
    """ .
```

**Same idea in SWRL** (abstract / Manchester-style, as in Protégé):

```text
hasAddress(?person, ?address) ^ country(?address, ?country)
  -> countryOfResidence(?person, ?country)
```

**SWRL RDF serialization** (what Stardog auto-detects). Verbose by design:

```turtle
PREFIX swrl:   <http://www.w3.org/2003/11/swrl#>
PREFIX swrlb:  <http://www.w3.org/2003/11/swrlb#>
PREFIX ruleml: <http://www.w3.org/2003/11/ruleml#>
PREFIX rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX :       <http://example.org/>

:person  a swrl:Variable .
:address a swrl:Variable .
:country a swrl:Variable .

[] a ruleml:Imp ;
   ruleml:body (
     [ a swrl:IndividualPropertyAtom ;
       swrl:propertyPredicate :hasAddress ;
       swrl:argument1 :person ;
       swrl:argument2 :address ]
     [ a swrl:IndividualPropertyAtom ;
       swrl:propertyPredicate :country ;
       swrl:argument1 :address ;
       swrl:argument2 :country ]
   ) ;
   ruleml:head (
     [ a swrl:IndividualPropertyAtom ;
       swrl:propertyPredicate :countryOfResidence ;
       swrl:argument1 :person ;
       swrl:argument2 :country ]
   ) .
```

Stardog can translate between SRS and SWRL **when the constructs overlap**. Negation and aggregation in SRS have no SWRL equivalent.

---

### 2. How the inference is used (query time)

Data:

```turtle
:Alice :hasAddress :Addr1 .
:Addr1 :country :USA .
```

Query **without** reasoning: no `:countryOfResidence` triple.

Query **with** reasoning:

```sparql
SELECT ?person ?country
WHERE {
  ?person :countryOfResidence ?country .
}
```

```
?person  ?country
:Alice   :USA
```

CLI:

```bash
stardog query execute --reasoning myDB \
  "SELECT ?person ?country { ?person :countryOfResidence ?country }"
```

HTTP: `...?reasoning=true`. The inferred triple is not stored; it is produced by rewriting the query using the rule.

---

## 3. FILTER / BIND (SRS is the natural fit)

These are awkward or impossible as clean SWRL. They work natively in SRS under Blackout/`SL`.

**Adult from age:**

```turtle
RULE :AdultRule
IF {
    ?person a :Person ;
            :age ?age .
    FILTER (?age >= 18)
}
THEN {
    ?person a :Adult .
}
```

**Compute a value, then chain rules:**

```turtle
RULE :AgeFromBirthdate
IF {
    ?person :birthDate ?birthDate .
    BIND (year(now()) - year(?birthDate) AS ?age)
}
THEN {
    ?person :age ?age .
}
```

The second rule’s inferred `:age` can fire `:AdultRule`. That chaining is the point of user-defined rules.

**SWRL analogue** for the adult rule (built-in comparison):

```text
Person(?person) ^ age(?person, ?age) ^ swrlb:greaterThanOrEqual(?age, 18)
  -> Adult(?person)
```

`BIND`/`concat`/`year(now())` are SRS-native. SWRL has a builtins library (`swrlb:`), but Stardog’s preferred path is SPARQL functions in SRS.

---

### 4. Coworker example (same pattern)

SRS:

```turtle
RULE :CoworkerRule
IF {
    ?p1 :worksFor ?org .
    ?p2 :worksFor ?org .
    FILTER (?p1 != ?p2)
}
THEN {
    ?p1 :coworker ?p2 .
}

:Alice   :worksFor :ACME .
:Charlie :worksFor :ACME .
```

With reasoning:

```sparql
SELECT ?who { ?who :coworker :Alice }
```

returns `:Charlie` (and the symmetric binding if you query the other direction, because the rule is not automatically symmetric unless you write both directions or add an OWL inverse).

SWRL:

```text
worksFor(?p1, ?org) ^ worksFor(?p2, ?org) ^ differentFrom(?p1, ?p2)
  -> coworker(?p1, ?p2)
```

---

### 5. Practical load + run

1. Put axioms/rules in the schema graph (`tag:stardog:api:context:schema` or your configured schema).
2. Keep `reasoning.type=SL` for Blackout + rules.
3. Enable reasoning **on the query**, not on the data load.
4. Prefer inline `RULE ... IF ... THEN` or `rule:SPARQLRule` / `rule:content`.
5. Use SWRL when you need interchange with Protégé/Pellet or an existing SWRL ontology.

| | SRS | SWRL |
|---|---|---|
| Authoring | SPARQL `IF`/`THEN` | Atoms + `swrl:` RDF |
| FILTER / BIND / UNION | Native | Limited / builtins |
| Negation, GROUP BY | Stride only | No |
| Interop | Stardog-native | OWL/SWRL tools |
| Translation | To SWRL if no extra features | To SRS where equivalent |

**Bottom line:** write rules in SRS. Keep SWRL for import/export. Same deduction either way for the basic horn-rule fragment.


## Official Documentation

* [User-defined Rule Reasoning](https://docs.stardog.com/inference-engine/user-defined-rules)
* [Inference Engine](https://docs.stardog.com/inference-engine/)

Stardog normally applies these inferences at query time through query rewriting rather than materializing all inferred triples. ([Stardog Documentation][4])

[1]: https://docs.stardog.com/inference-engine/user-defined-rules "User-defined Rule Reasoning | Stardog Documentation Latest"
[2]: https://docs.stardog.com/operating-stardog/database-administration/database-configuration "Database Configuration | Stardog Documentation Latest"
[3]: https://docs.stardog.com/additional-resources/migration-guide "Migration Guides | Stardog Documentation Latest"
[4]: https://docs.stardog.com/inference-engine/ "Inference Engine | Stardog Documentation Latest"
