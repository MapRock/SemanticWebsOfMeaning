# Geological Expert Reasoning Graph — RDF Sample and Query Examples

This file accompanies the **Expert Reasoning Graphs: Reasoning Under Imperfect Information** example from *Semantic Webs of Meaning*. The companion Turtle file is:

[`geology_expert_reasoning_hybrid_v3.ttl`](./geology_expert_reasoning_hybrid_v3.ttl)

The purpose of the sample is **not** to build a complete geological ontology or a production rock-identification system. It is to show how a graph can preserve enough world knowledge and expert reasoning structure to do something more useful than:

> green rock → probably serpentine

The intended interaction is closer to:

> I found a green rock in a wash. What could it be? What about the surrounding geology matters? What should I look at next? If I add another observation, how should the candidate set change?

That is the distinction between storing a classification and storing enough structure to support an investigation.

---

## 1. What the RDF is trying to represent

The model deliberately separates three layers.

### World model

SKOS concepts describe things that can be true in geology:

- rock and mineral materials
- observable features
- geologic settings
- formation conditions
- surface, igneous, metamorphic, sedimentary, and tectonic processes
- relationships such as `canProduce`, `canTransform`, `canHaveObservableFeature`, `suggestsPossibility`, and `canLeaveEvidence`

These are **modal** relationships. For example:

```turtle
erggeo:Serpentinization
    erggeo:canProduce cgiLith:serpentinite .

cgiLith:serpentinite
    erggeo:canHaveObservableFeature erggeo:GreenColor,
        erggeo:WaxyLuster .
```

This says serpentinite *can* be produced by serpentinization and *can* be green and waxy. It does **not** say that a particular green specimen is serpentinite.

### Case layer

OWL classes and individuals describe a particular investigation:

```turtle
erggeo:ExpertReasoningCase
erggeo:PhysicalSample
erggeo:Observation
erggeo:Hypothesis
erggeo:InvestigationAction
erggeo:EvidenceAssessment
```

A case can therefore preserve the difference between:

- what was observed,
- what was hypothesized,
- what evidence was sought next,
- and what eventually supported or contradicted the hypotheses.

### Query / reasoning layer

RDF itself does not "take parameters." A caller — a SPARQL query, application, rules engine, or LLM — binds observed parameters to graph concepts and traverses the graph.

For example, the caller might map:

| Field observation | Graph concept |
|---|---|
| The specimen is green | `erggeo:GreenColor` |
| It was found in a wash | `erggeo:WashOrStreamSetting` |
| It has glittery inclusions | `erggeo:Aventurescence` |
| It has a waxy/greasy luster | `erggeo:WaxyLuster` |
| It has a tough fibrous texture | `erggeo:InterlockingFibrousTexture` |
| It breaks conchoidally | `erggeo:ConchoidalFracture` |
| Upstream rocks are ultramafic | `erggeo:UltramaficSourceGeology` |
| Mohs hardness is about 7 | numeric parameter `7.0` |

The graph can then generate candidate materials and suggest observations that would help discriminate among them.

---

## 2. The initial green-rock clue

The green-rock example begins broadly on purpose.

```turtle
erggeo:GreenColor a skos:Concept ;
    skos:broader erggeo:ObservableFeature ;
    skos:prefLabel "green color"@en ;
    skos:scopeNote
        "Useful as an initial cue, but weakly discriminating because many unrelated rocks and minerals can be green."@en ;
    erggeo:suggestsPossibility
        cgiLith:serpentinite,
        erggeo:AlteredVolcanicRock,
        erggeo:ChloriteRichMetamorphicRock,
        erggeo:EpidoteRichRock,
        erggeo:GreenJasperOrChert,
        erggeo:GreenQuartzAventurine,
        erggeo:Nephrite,
        erggeo:PrehniteBearingRock .
```

This is intentionally not a decision-tree terminal. `GreenColor` opens a hypothesis set.

It also points toward mechanisms that could explain the color:

```turtle
erggeo:GreenColor
    erggeo:mayBeCausedBy
        erggeo:ChloritePresence,
        erggeo:ChromiumSubstitution,
        erggeo:EpidotePresence,
        erggeo:FerrousIronBearingSilicate,
        erggeo:GreenMineralInclusions,
        erggeo:NickelSubstitution,
        erggeo:SecondaryCopperMineralization,
        erggeo:SerpentineMineralPresence .
```

So the graph supports two related questions:

1. **What might this material be?**
2. **What might have made it green?**

Those are not the same question.

---

## 3. Example: "I found a green rock in a wash"

### Parameters

```text
observed feature = green
observation context = wash or stream
```

A simple candidate query is:

```sparql
PREFIX erggeo: <https://eugeneasahara.com/ontology/geology-expert-reasoning#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?candidate ?label
WHERE {
  erggeo:GreenColor erggeo:suggestsPossibility ?candidate .
  ?candidate skos:prefLabel ?label .
}
ORDER BY ?label
```

The sample graph returns candidates including:

- altered volcanic rock
- chlorite-rich metamorphic rock
- epidote-rich rock
- green jasper or chert
- green quartz / aventurine
- nephrite
- prehnite-bearing rock
- serpentinite

That is not supposed to be a satisfying final answer. Green is a weak clue.

The *wash* context changes the investigation:

```turtle
erggeo:WashOrStreamSetting
    skos:scopeNote
        "A place of observation that commonly contains transported material; the found location need not be the formation location."@en ;
    erggeo:supportsInferenceOf erggeo:UpstreamGeology .
```

And the graph contains a corresponding action:

```turtle
erggeo:ActionInspectUpstreamGeology a erggeo:InvestigationAction ;
    rdfs:label "inspect upstream geology and nearby rock assemblage"@en ;
    erggeo:investigatesConcept
        erggeo:MineralAssociationObservation,
        erggeo:UpstreamGeology .
```

The important result is therefore not merely a list of rock names. It is also:

> **Because the specimen was found in a wash, inspect the upstream geology before assuming it formed where it was found.**

---

## 4. Example: green + glittery inclusions

Suppose another observation is added:

```text
color = green
texture/optical clue = aventurescence or glittery inclusions
```

The graph encodes:

```turtle
erggeo:Aventurescence
    erggeo:suggestsPossibility erggeo:GreenQuartzAventurine ;
    erggeo:helpsDiscriminate erggeo:GreenQuartzAventurine .

erggeo:GreenQuartzAventurine
    erggeo:canHaveObservableFeature
        erggeo:Aventurescence,
        erggeo:GreenColor,
        erggeo:MacrocrystallineTexture,
        erggeo:ConchoidalFracture .
```

The following query counts how many supplied observations are consistent with each candidate:

```sparql
PREFIX erggeo: <https://eugeneasahara.com/ontology/geology-expert-reasoning#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?candidate ?label (COUNT(DISTINCT ?input) AS ?matches)
WHERE {
  VALUES ?input {
    erggeo:GreenColor
    erggeo:Aventurescence
  }

  {
    ?input erggeo:suggestsPossibility ?candidate .
  }
  UNION
  {
    ?candidate erggeo:canHaveObservableFeature ?input .
  }

  ?candidate skos:prefLabel ?label .
}
GROUP BY ?candidate ?label
ORDER BY DESC(?matches) ?label
```

With the sample graph the top result is:

| Candidate | Matching supplied clues |
|---|---:|
| **green quartz / aventurine** | **2** |
| other green candidates | 1 each |

The count is **not a probability or confidence score**. It only demonstrates graph traversal over multiple supplied cues.

Still, this is already more useful than a static lookup. Adding one observation changes the structure of the answer.

---

## 5. Example: green + waxy + ultramafic rocks upstream

Parameters:

```text
color = green
luster = waxy/greasy
upstream/source geology = ultramafic
```

Relevant graph statements include:

```turtle
erggeo:WaxyLuster
    erggeo:suggestsPossibility cgiLith:serpentinite ;
    erggeo:helpsDiscriminate cgiLith:serpentinite .

erggeo:UltramaficSourceGeology
    erggeo:suggestsPossibility cgiLith:serpentinite ;
    erggeo:supportsInferenceOf erggeo:Serpentinization .

cgiLith:serpentinite
    erggeo:canHaveObservableFeature
        erggeo:GreenColor,
        erggeo:WaxyLuster ;
    erggeo:mayBeAssociatedWith
        erggeo:MetamorphicTerrane,
        erggeo:UltramaficComposition .
```

Using the same cue-counting query with those three inputs produces:

| Candidate | Matching supplied clues |
|---|---:|
| **serpentinite** | **3** |
| other green candidates | 1 each |

Again, three matches do not prove serpentinite. They say that this candidate is connected to all three supplied observations in the sample world model.

A next step could then be a hardness, density, fracture, or mineral-association test rather than simply declaring the rock identified.

---

## 6. Example: use a numeric parameter — Mohs hardness

The sample includes approximate Mohs ranges for several common green-rock candidates:

```turtle
erggeo:GreenQuartzAventurine
    erggeo:mohsHardnessMin "7.0"^^xsd:decimal ;
    erggeo:mohsHardnessMax "7.0"^^xsd:decimal .

erggeo:GreenJasperOrChert
    erggeo:mohsHardnessMin "6.5"^^xsd:decimal ;
    erggeo:mohsHardnessMax "7.0"^^xsd:decimal .

erggeo:Nephrite
    erggeo:mohsHardnessMin "6.0"^^xsd:decimal ;
    erggeo:mohsHardnessMax "6.5"^^xsd:decimal .

cgiLith:serpentinite
    erggeo:mohsHardnessMin "2.5"^^xsd:decimal ;
    erggeo:mohsHardnessMax "5.5"^^xsd:decimal .
```

These values are intentionally treated as approximate filtering information, not rigid definitions.

If the observed hardness is approximately `7.0`:

```sparql
PREFIX erggeo: <https://eugeneasahara.com/ontology/geology-expert-reasoning#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?candidate ?label ?min ?max
WHERE {
  erggeo:GreenColor erggeo:suggestsPossibility ?candidate .

  ?candidate skos:prefLabel ?label ;
             erggeo:mohsHardnessMin ?min ;
             erggeo:mohsHardnessMax ?max .

  VALUES ?observedHardness { 7.0 }

  FILTER(
    ?observedHardness >= ?min &&
    ?observedHardness <= ?max
  )
}
ORDER BY ?label
```

The candidates in the current sample that satisfy both "green" and the stored hardness range are:

- **green jasper or chert**
- **green quartz / aventurine**

That result naturally leads to another question rather than a final declaration:

> Is the material cryptocrystalline and jasper/chert-like, or does it show visible quartz texture or aventurescence?

---

## 7. Ask the graph: "What should I look at next?"

Suppose the current candidate set is:

- green quartz / aventurine
- green jasper or chert
- nephrite
- serpentinite

The graph can be asked for observations that help discriminate those possibilities.

```sparql
PREFIX erggeo: <https://eugeneasahara.com/ontology/geology-expert-reasoning#>
PREFIX cgiLith: <http://resource.geosciml.org/classifier/cgi/lithology/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT ?clue ?clueLabel
       (COUNT(DISTINCT ?candidate) AS ?candidateCount)
WHERE {
  VALUES ?candidate {
    erggeo:GreenQuartzAventurine
    erggeo:GreenJasperOrChert
    erggeo:Nephrite
    cgiLith:serpentinite
  }

  ?clue erggeo:helpsDiscriminate ?candidate ;
        skos:prefLabel ?clueLabel .
}
GROUP BY ?clue ?clueLabel
ORDER BY DESC(?candidateCount) ?clueLabel
```

The sample graph returns general tests such as:

| Useful clue | Candidates it is connected to in this set |
|---|---:|
| density | 4 |
| fracture behavior | 4 |
| hardness | 4 |
| translucency | 4 |
| mineral associations | 3 |

It also returns more candidate-specific clues:

- aventurescence / glittery inclusions
- cryptocrystalline texture
- macrocrystalline texture
- tough interlocking fibrous texture
- waxy or greasy luster
- conchoidal fracture

Those clue concepts can be connected to human-readable actions:

```sparql
PREFIX erggeo: <https://eugeneasahara.com/ontology/geology-expert-reasoning#>
PREFIX cgiLith: <http://resource.geosciml.org/classifier/cgi/lithology/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?actionLabel ?clueLabel
WHERE {
  VALUES ?candidate {
    erggeo:GreenQuartzAventurine
    erggeo:GreenJasperOrChert
    erggeo:Nephrite
    cgiLith:serpentinite
  }

  ?clue erggeo:helpsDiscriminate ?candidate ;
        skos:prefLabel ?clueLabel .

  ?action a erggeo:InvestigationAction ;
          erggeo:investigatesConcept ?clue ;
          rdfs:label ?actionLabel .
}
ORDER BY ?actionLabel
```

Examples include:

- check density / specific gravity
- check hardness
- inspect fracture behavior
- inspect translucency, especially at thin edges
- look for aventurescence or glittery inclusions
- inspect for a tough interlocking fibrous texture
- inspect whether the luster is waxy or greasy
- inspect whether the material is cryptocrystalline, microcrystalline, or visibly crystalline

This is the part of the sample that most directly illustrates an Expert Reasoning Graph:

> **A candidate explanation suggests what evidence would be useful to seek next.**

---

## 8. Persisting the investigation instead of only querying the world model

The graph can also record a particular case.

```turtle
erggeo:GreenRockIllustrativeCase a erggeo:ExpertReasoningCase ;
    rdfs:label "illustrative green-rock identification case"@en ;
    erggeo:hasSample erggeo:GreenRockSample ;
    erggeo:hasObservation
        erggeo:ObsGreenColor,
        erggeo:ObsFoundInWash,
        erggeo:ObsNearbyGeology ;
    erggeo:considersHypothesis
        erggeo:HypothesisGreenQuartz,
        erggeo:HypothesisGreenJasper,
        erggeo:HypothesisNephrite,
        erggeo:HypothesisSerpentinite,
        erggeo:HypothesisCopperColorCause ;
    erggeo:hasInvestigationAction
        erggeo:ActionCheckHardness,
        erggeo:ActionCheckDensity,
        erggeo:ActionInspectFracture,
        erggeo:ActionCheckAventurescence,
        erggeo:ActionCheckWaxyLuster,
        erggeo:ActionCheckFibrousTexture,
        erggeo:ActionInspectUpstreamGeology .
```

A hypothesis is separate from the underlying geological concept:

```turtle
erggeo:HypothesisGreenQuartz a erggeo:Hypothesis ;
    rdfs:label "hypothesis: specimen may be green quartz / aventurine"@en ;
    erggeo:aboutSample erggeo:GreenRockSample ;
    erggeo:promptedBy erggeo:ObsGreenColor ;
    erggeo:proposesConcept erggeo:GreenQuartzAventurine ;
    erggeo:predictsObservationConcept
        erggeo:Aventurescence,
        erggeo:MacrocrystallineTexture .
```

That separation matters.

The world model says:

> Green quartz / aventurine can have certain features.

The case says:

> For **this** specimen, green quartz is one of the hypotheses currently being considered.

Those should not be confused.

---

## 9. The quartz-cycle knowledge is part of the same world model

The blog's quartz-cycle discussion is useful because it shows why a rock is not merely a label. A material can be placed in a history of processes.

A deliberately simplified portion of that world model is encoded as:

```turtle
erggeo:Weathering
    erggeo:canRelease erggeo:QuartzGrain .

erggeo:FluvialTransport
    erggeo:canTransport erggeo:QuartzGrain .

cgiProc:deposition
    erggeo:canProduce erggeo:QuartzRichSand .

erggeo:Lithification
    erggeo:canTransform erggeo:QuartzRichSand ;
    erggeo:canProduce cgiLith:sandstone .

cgiProc:metamorphic_process
    erggeo:canTransform cgiLith:sandstone ;
    erggeo:canProduce cgiLith:quartzite .

erggeo:Uplift
    erggeo:canExpose
        cgiLith:granite,
        cgiLith:sandstone,
        cgiLith:quartzite,
        erggeo:GneissicRock .

erggeo:HighGradeMetamorphism
    erggeo:canProduce erggeo:GneissicRock .

erggeo:PartialMelting
    erggeo:canProduce erggeo:Magma .

erggeo:Crystallization
    erggeo:canProduce
        cgiLith:igneous_rock,
        cgiLith:granite .
```

This is intentionally **not** encoded as one mandatory cycle.

The graph permits branches:

- uplift and renewed weathering,
- deeper metamorphism,
- tectonic burial,
- partial melting,
- crystallization,
- and other histories.

That mirrors the point of the blog: the simple "quartz cycle" was useful because it changed rocks from isolated labels into things with **pasts and possible futures**.

---

## 10. How an LLM could use this graph

An LLM does not need to replace the graph. It can act as the interface between natural-language observations and the explicit reasoning structure.

A possible loop is:

1. **Human:** "I found a green rock in a wash."
2. **LLM:** map "green" → `erggeo:GreenColor`; "wash" → `erggeo:WashOrStreamSetting`.
3. Query the graph for candidate materials and relevant contextual cues.
4. **Graph:** several green candidates; because it was found in a wash, upstream geology matters.
5. **LLM:** "Does it have a waxy luster? Does it glitter? How hard is it? What kinds of rocks occur upstream?"
6. Human supplies another observation.
7. LLM maps the answer to another graph concept or numeric value.
8. Query again.
9. Persist the observation, current hypotheses, supporting/contradictory evidence, and next investigation in the case graph.
10. Repeat until the remaining hypotheses are sufficiently distinguished — or until the evidence is genuinely inconclusive.

This is intentionally different from asking an LLM to look at a photograph and emit one rock name.

The graph preserves **why** a possibility is being considered and **what observation would help next**.

---

## 11. Important limitations of this sample

This is a demonstration ontology, not a geological identification authority.

In particular:

- The concept vocabulary is deliberately incomplete.
- The graph does not encode all of plate tectonics, mineralogy, petrology, metamorphic facies, weathering reactions, or depositional environments.
- Many geological relationships are contingent on composition, pressure, temperature, fluids, tectonic history, and local setting.
- `suggestsPossibility`, `mayIndicate`, and similar relations are intentionally weak and defeasible.
- The cue-count examples above are **not Bayesian probabilities** and should not be interpreted as statistical confidence.
- Hardness ranges are approximate and are included only to demonstrate how numeric parameters can participate in candidate filtering.
- A production implementation would likely add provenance, source quality, explicit confidence, contradiction, observation methods, units, more complete quantitative ranges, and a richer mechanism for ranking the information value of the next test.

That incompleteness is not contrary to the Expert Reasoning Graph idea. It is part of it.

The graph is intended to support reasoning **under imperfect information**, while preserving enough structure to make the investigation inspectable and revisable.

---

## 12. The larger pattern

The geological example is only a concrete demonstration.

The same graph pattern can be used whenever the system must move through:

```text
observation
    ↓
candidate explanations
    ↓
predicted evidence
    ↓
most useful next question or test
    ↓
new observation
    ↓
support / contradiction
    ↓
revised explanation
```

For geology the answer might eventually be:

> likely green quartz / aventurine

For an enterprise problem it might be:

> the churn increase is more consistent with service deterioration than with the price increase alone

The point of the Expert Reasoning Graph is not the final label.

It is preserving the structure by which an intelligent investigator gets there.
