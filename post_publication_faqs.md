## Post-Publication FAQs

<i>[Semantic Webs of Meaning](https://technicspub.com/semantic-webs-of-meaning/)</i> was published on August 17, 2026. It covers a broad subject, and some ideas naturally deserve additional clarification once the book is out in the world and readers begin comparing its approach with other ways of thinking about knowledge graphs. This document collects those post-publication questions, clarifications, and extensions.

These are not intended as corrections to the book so much as a continuing discussion around it. In some cases, a question may expose an assumption that was implicit in the text; in others, a later article, discussion, or implementation experience may provide an opportunity to explain why I took a particular approach. Some are "deleted scenes" dropped to keep the page count down but does help to fill in a few places. Where useful, I will point back to the relevant chapters and expand on how the ideas fit together. Please see [Book Erratum](https://github.com/MapRock/SemanticWebsOfMeaning#book-erratum) for actual errors.

### How should an enterprise knowledge graph deal with rare events and risks that look stable until they suddenly aren’t?

Added: Sept 21, 2026

This post, [Chains of Unstable Correlations](https://eugeneasahara.com/2026/02/13/chains-of-unstable-correlations/), is a deleted scene from Chapter 9. Readers of that chapter might ask how an EKG should treat risks that do not announce themselves as bad triples or known threat classes—the rare, threshold-crossing events that look routine until a chain of relationships tips. Chapter 9 already argues that the same graph used to discover opportunities can reveal vulnerabilities, and that a plausible relationship can propagate as a semantic virus. What did not fit the page count is the statistical form of that problem: many dangerous enterprise relationships are not linear. They sit quietly in a long left tail, then amplify after an elbow.

The Tuple Correlation Web from [Enterprise Intelligence](https://technicspub.com/enterprise-intelligence/) treats BI results as attention signals and correlations as transient, abductive clues—Chains of Strong Correlations as “hypothesis ore” for System 1, System 2, and System ⅈ. Those chains are not reliably linear. Port congestion versus retail stockouts, stockouts versus emergency freight, early fraud anomalies versus accelerating loss, and overloaded grid components versus cascade blackouts share the same hockey-stick shape. A small further change in X produces a disproportionate change in Y. Once that edge sits in a chain, fragility is contagious. That is how rare events become visible late: the correlation was always there; the regime was not.

For Chapter 9 this cuts two ways. Defensively, an adversary reasoning over the same EKG can hunt elbows and correlation chains the way an analyst hunts opportunities. The attack surface is not only restricted triples, but combinations that become identifying or exploitable only after a threshold. For the enterprise, the Risk Knowledge Graph should treat unstable-correlation signatures—elbow location, regime-specific slopes, cascade paths, and whether the curve is a failure hockey stick, a restabilizing S-curve, a multi-regime relationship, or an antifragile curve that hardens defenses—as first-class indicators, not only as static risk classes. The article’s blast-radius intuition matches the chapter’s sandbox inference tests and canary questions: a new correlation edge can change conclusions without any single triple looking wrong.

The practical stance is therefore not to wait for the rare event to be labeled in a risk register. Preserve the structural facts of the correlation, including its shape; attach them to risk classes, cause-effect links, and named-graph controls; and test what new conclusions become possible when the chain is allowed to fire. The TCW does not assert cause or policy. It keeps the map of how pressure propagates so the EKG can reason about rare events before the elbow is crossed.

### How are competency questions created?

Added: Sept 17, 2026

This post, [The Art of Crafting Competency Questions for Knowledge Graphs](https://eugeneasahara.com/2026/09/16/the-art-of-knowledge-graph-competency-questions/), continues the discussion of competency questions from Chapter 10 and the preceding FAQ. It argues that a competency question is a test of competence, not the competence itself, and therefore should not become a fixed and exhaustive requirements list. Using self-service BI as an analogy, the article describes a structure designed to support many questions that were not individually specified beforehand. It compares the requirements, testing, and maintenance expectations of traditional projects, self-service BI, knowledge graphs, and LLM-based systems. It also relates Grüninger and Fox’s progression from motivating scenarios through informal and formal competency questions to a modern hierarchy that begins with broad purpose and works downward toward concrete queries and test cases. Dental-practice and Idaho Plant Rescue examples demonstrate how connected knowledge can support lines of inquiry beyond the initial questions used to design and test the graph.


### Where Should an Enterprise Knowledge Graph Start?
Added: Sept 12, 2026

This post, [Where Should an Enterprise Knowledge Graph Start?](https://eugeneasahara.com/2026/09/12/where-should-an-enterprise-knowledge-graph-start/), responds to the objection that ontology design should begin with competency questions rather than inherited databases and schemas, because existing structures may reflect implementation compromises instead of true domain meaning. I agree with that concern, but Chapter 4 deliberately starts by mining existing enterprise artifacts—especially BI semantic layers, software, databases, business processes, and domain language—because they contain valuable operationalized knowledge and keep the KG grounded in the enterprise. Chapter 10 provides the resolution: treat that existing knowledge as the foundation, make reflecting it the first competency questions, and then use subsequent competency questions to correct, extend, and connect the graph beyond what existing systems already know.



