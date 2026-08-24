# Appendix C: Additional Enterprise Knowledge Sources for Knowledge Graphs

<i>This appendix accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>

Enterprise knowledge graphs rarely begin with a blank slate. This appendix presents additional sources of organizational knowledge that can be mined to enrich a graph, including ER diagrams, master data systems, feature stores, dashboards, business glossaries, policies, source-code comments, APIs, event streams, documentation, collaboration sites, and operational tickets. Together, these sources provide not only data, but also business meaning, intent, and organizational knowledge that can be incorporated into the graph.

## ER Diagrams

ER diagrams are a traditional source of structural knowledge. They show entities, relationships, cardinalities, and sometimes key attributes. They are especially useful when the database schema is difficult to inspect directly or when the diagram explains the intended model better than the implemented schema.

**Extraction method:** diagram interpretation, metadata alignment, and LLM-assisted labeling.

**Useful graph candidates:**

| ER Diagram Element   | KG Candidate                  |
|----------------------|-------------------------------|
| Entity box           | Class or entity type          |
| Relationship line    | Object property or relationship |
| Cardinality marker   | Constraint or shape           |
| Attribute            | Data property                 |
| Weak entity          | Dependent entity              |

ER diagrams are helpful, but they should not be treated as automatically current. Many diagrams are idealized, outdated, or incomplete.

## Master Data Systems

Master data systems manage core business entities such as customers, products, suppliers, employees, locations, assets, and accounts. They are valuable because they often contain identifiers, survivorship rules, hierarchies, golden records, and cross-system mappings.

**Extraction method:** master-data ingestion, entity-resolution mapping, and identifier alignment.

**Useful graph candidates:**

| MDM Asset                  | KG Candidate                          |
|----------------------------|---------------------------------------|
| Golden record              | Canonical entity                      |
| Source-system crosswalk    | Same-as or equivalent-identity relationship |
| Hierarchy                  | Parent/child relationship             |
| Match rule                 | Identity-resolution rule              |
| Survivorship rule          | Trust or precedence rule              |

Master data is important because knowledge graphs need stable identity. Without identity resolution, the graph may contain many disconnected versions of the same thing.

## Existing Taxonomies

Existing taxonomies provide controlled categories and hierarchies. They may describe products, risks, document types, business capabilities, industries, topics, departments, or customer segments.

**Extraction method:** taxonomy import, SKOS modeling, and hierarchy normalization.

**Useful graph candidates:**

| Taxonomy Element   | KG Candidate     |
|--------------------|------------------|
| Term               | Concept          |
| Preferred label    | skos:prefLabel   |
| Synonym            | skos:altLabel    |
| Parent term        | skos:broader     |
| Child term         | skos:narrower    |
| Definition         | skos:definition  |

Taxonomies are especially useful when modeled with SKOS because they may not require heavy OWL-style logical modeling.

## Machine Learning Feature Stores

Feature stores contain variables used by machine learning models. These features often represent carefully engineered business signals, such as customer tenure, average transaction amount, late-payment count, risk score, recency, frequency, or recent behavior.

**Extraction method:** feature metadata extraction, model-card review, and statistical profiling.

**Useful graph candidates:**

| Feature Store Asset     | KG Candidate                          |
|-------------------------|---------------------------------------|
| Feature                 | Derived attribute or business signal  |
| Feature group           | Domain grouping                       |
| Source table            | Lineage relationship                  |
| Transformation logic    | Derivation rule                       |
| Model usage             | Predictive relationship               |
| Feature importance      | Evidence or influence relationship    |

Feature stores are useful because they reveal which data points the organization has found predictive or meaningful.

## Dashboards

Dashboards deserve separate mention even though they overlap with BI semantic layers. A dashboard is not just a report. It is a packaged business viewpoint. It shows what the organization monitors, how measures are grouped, and what comparisons matter.

**Extraction method:** dashboard metadata parsing, visual analysis, usage analytics, and LLM summarization.

**Useful graph candidates:**

| Dashboard Element | KG Candidate              |
|-------------------|---------------------------|
| Page              | Analytical topic          |
| Visual            | Question or viewpoint     |
| Measure           | Metric                    |
| Axis              | Dimension                 |
| Filter            | Business condition        |
| Drill-through     | Related analytical path   |

Dashboards are useful because they reveal how knowledge is consumed, not just how it is stored.

## Business Glossaries

Business glossaries define business terms, acronyms, metrics, and concepts. They are often less technical than data catalogs and more accessible to business users.

**Extraction method:** glossary ingestion, synonym detection, term mapping, and human stewardship.

**Useful graph candidates:**

| Glossary Element | KG Candidate          |
|------------------|-----------------------|
| Term             | Concept               |
| Acronym          | Alternate label       |
| Definition       | Description           |
| Owner            | Steward               |
| Related term     | Semantic relationship |
| Approved term    | Preferred label       |

Glossaries are especially important when different departments use the same word differently.

## Source-Code Comments

Source-code comments can contain valuable explanations of why logic exists. They may explain edge cases, assumptions, temporary fixes, system limitations, and business rules.

**Extraction method:** code parsing, comment extraction, static analysis, and LLM summarization.

**Useful graph candidates:**

| Code Comment Clue     | KG Candidate             |
|-----------------------|--------------------------|
| Business rule explanation | Rule                  |
| TODO or FIXME         | Known issue              |
| Edge-case note        | Exception condition      |
| Warning               | Constraint or risk       |
| Example input/output  | Transformation pattern    |

Code comments are uneven in quality, but they can reveal intent that is missing from technical metadata.

## Policies

Policies define official rules, obligations, permissions, prohibitions, thresholds, and responsibilities. They are important in regulated domains and in organizations where governance matters.

**Extraction method:** LLM-based rule extraction, legal/policy review, and controlled vocabulary mapping.

**Useful graph candidates:**

| Policy Text          | KG Candidate   |
|---------------------|----------------|
| Must / shall        | Obligation     |
| May                 | Permission     |
| Must not            | Prohibition    |
| Unless              | Exception      |
| Responsible party   | Role           |
| Threshold           | Constraint     |

Policies are useful because they encode normative knowledge: what should happen, not necessarily what does happen.

## Tickets

Tickets contain operational reality. They describe incidents, requests, failures, confusion, exceptions, workarounds, and recurring pain points.

**Extraction method:** text clustering, LLM summarization, root-cause extraction, and topic modeling.

**Useful graph candidates:**

| Ticket Content    | KG Candidate             |
|-------------------|--------------------------|
| Error report      | Failure mode             |
| Resolution note   | Fix or workaround        |
| Assignment group  | Ownership relationship   |
| Repeated issue    | Pattern                  |
| Severity          | Impact level             |
| Root cause        | Causal relationship      |

Tickets are useful because they reveal where formal models break down.

## SharePoint and Confluence Pages

Collaboration pages often contain team-level knowledge: onboarding instructions, local procedures, diagrams, FAQs, meeting notes, release notes, project decisions, and informal definitions.

**Extraction method:** document crawling, LLM extraction, link analysis, and freshness scoring.

**Useful graph candidates:**

| Page Content       | KG Candidate                |
|--------------------|-----------------------------|
| Procedure          | Process                     |
| FAQ                | Common question and answer  |
| Diagram            | Conceptual model            |
| Decision note      | Decision and rationale      |
| Link cluster       | Related topic area          |
| Owner or maintainer| Stewardship relationship    |

These pages are valuable but require freshness checks. Collaboration sites often accumulate outdated knowledge.

## Documentation

Documentation includes system manuals, architecture documents, user guides, runbooks, design documents, and training material.

**Extraction method:** document segmentation, LLM extraction, entity recognition, and human validation.

**Useful graph candidates:**

| Documentation Element | KG Candidate           |
|-----------------------|------------------------|
| System overview       | Application or capability |
| Architecture diagram  | System relationship    |
| Runbook step          | Operational procedure  |
| User guide section    | Business function      |
| Data dictionary       | Field definition       |
| Known limitation      | Constraint             |

Documentation is useful because it often explains why a system exists and how people are supposed to use it.

## APIs

APIs expose capabilities, entities, payloads, and integration contracts. Even when the underlying database is unavailable, an API can reveal how a system wants to be understood externally.

**Extraction method:** OpenAPI parsing, schema extraction, payload profiling, and endpoint classification.

**Useful graph candidates:**

| API Artifact        | KG Candidate        |
|---------------------|---------------------|
| Endpoint            | Capability or action|
| Request object      | Input entity        |
| Response object     | Output entity       |
| Status code         | Outcome             |
| Authentication scope| Access rule         |
| Error response      | Failure mode        |

APIs are useful because they describe the boundary between systems.

## Event Streams

Event streams are high-volume sources of real-time or near-real-time behavioral data. They may come from applications, devices, web systems, operational platforms, or messaging systems.

**Extraction method:** event classification, stream profiling, sequence mining, and anomaly detection.

**Useful graph candidates:**

| Event Stream Element | KG Candidate              |
|----------------------|---------------------------|
| Topic                | Event family              |
| Message type         | Event type                |
| Payload field        | Event property            |
| Timestamp            | Event occurrence time     |
| Partition key        | Case or entity grouping   |
| Consumer             | Downstream dependency     |

Event streams are important because they reveal what is happening now, not just what has been stored historically.
