<i>This document accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>

## Example: Validate a Fire Door Design


A fire-door design illustrates where a knowledge graph can provide more value than a plain reference table. The graph links the part, its parameters, its location, the applicable rule, the regulatory source, and the reason the rule applies.

Suppose an architect models a door in a building design:

```text
Door D-104
Fire rating: 30 minutes
Width: 900 mm
Height: 2100 mm
Location: Exit stairwell
Material: Timber
```

A public engineering dictionary could define the expected properties for a fire-resistant door:

```text
Fire-resistant door
Required properties:
- fire-resistance rating
- width
- height
- material
- smoke-control classification
- self-closing capability
```

The project knowledge graph then combines:

```text
Public engineering knowledge
        +
Project design data
        +
Project-specific requirements
```

The graph could represent the proposed component like this:

```turtle
:DoorD104
    a :FireResistantDoor ;
    :hasFireResistanceRating "30"^^xsd:integer ;
    :hasWidth "900"^^qudt:MilliM ;
    :hasHeight "2100"^^qudt:MilliM ;
    :hasMaterial :Timber ;
    :locatedIn :ExitStairwell ;
    :isSelfClosing false .
```

The project requirements might say:

```turtle
:ExitStairwellDoorRequirement
    :minimumFireResistanceRating "60"^^xsd:integer ;
    :requiresSelfClosing true ;
    :requiresSmokeControl true .
```

SHACL or rules could then detect:

```text
FAIL: fire rating is 30 minutes; minimum required is 60.
FAIL: door is not self-closing.
FAIL: smoke-control classification is missing.
PASS: width and height are present.
```

## Knowledge and standards that can contribute

| Source                           | What it contributes                                                                                               |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **bSDD**                         | Standardized construction dictionaries containing classes, properties, allowed values, units, and classifications |
| **IFC**                          | A standardized information model for building elements, spaces, systems, properties, and relationships            |
| **ETIM**                         | Standardized product classes and technical characteristics for construction and installation products             |
| **QUDT**                         | Standard vocabularies for quantities, units, dimensions, and measurement values                                   |
| **GeoSPARQL**                    | Standard vocabulary and query semantics for representing spatial features, geometries, and spatial relationships  |
| **Building codes / regulations** | Jurisdiction-specific requirements, limits, and compliance criteria                                               |
| **Project ontology**             | Project-specific concepts, classifications, relationships, and requirements                                       |
| **SHACL shapes**                 | Machine-testable constraints used to validate project data against applicable requirements                        |


bSDD is especially suitable because it is designed to distribute independently maintained engineering dictionaries and exposes class and property information through an API. ETIM contributes standardized product classes and technical features, while IFC provides the broader building-information structure. ([buildingSMART Technical][2])

## Important distinction

The public source may tell you:

```text
A fire-resistant door has a fire-rating property.
The property's unit is minutes.
The allowed classification values are X, Y, and Z.
```

It may not, by itself, tell you:

```text
Every exit-stairwell door in this jurisdiction must have a 60-minute rating.
```

That requirement may come from:

* a building code;
* an owner specification;
* a contract;
* a jurisdiction;
* a project type;
* or a safety policy.

So the complete validation pattern is:

```text
Public component vocabulary
    defines what properties mean

Public or licensed regulation
    defines acceptable limits

Project graph
    holds the proposed design

SHACL or rules
    compare the design with the requirements
```

## Why this is a good knowledge-graph example

It shows several important ideas at once:

* reuse of public engineering knowledge;
* linking design objects to standard component definitions;
* consistent units and property meanings;
* project-specific constraints;
* deterministic validation;
* provenance for every requirement;
* and explainable failure messages.

The result is not merely:

> “The design is invalid.”

It can explain:

```text
Door D-104 violates Requirement R-17
because its fire rating is 30 minutes
and the minimum permitted rating is 60 minutes.

Requirement R-17 applies because:
Door D-104 is located in Exit Stairwell S-2.
Exit Stairwell S-2 is classified as a protected egress route.
Protected egress routes require 60-minute fire doors.
```


[1]: https://www.buildingsmart.org/users/services/buildingsmart-data-dictionary/ "buildingSMART Data Dictionary (bSDD)"
[2]: https://technical.buildingsmart.org/services/bsdd/data-structure/ "Data structure of bSDD - buildingSMART Technical"
