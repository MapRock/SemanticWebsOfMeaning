## Post-Publication FAQs

<i>[Semantic Webs of Meaning](https://technicspub.com/semantic-webs-of-meaning/)</i> was published on August 17, 2026. It covers a broad subject, and some ideas naturally deserve additional clarification once the book is out in the world and readers begin comparing its approach with other ways of thinking about knowledge graphs. This document collects those post-publication questions, clarifications, and extensions.

These are not intended as corrections to the book so much as a continuing discussion around it. In some cases, a question may expose an assumption that was implicit in the text; in others, a later article, discussion, or implementation experience may provide an opportunity to explain why I took a particular approach. Some are "deleted scenes" dropped to keep the page count down but does help to fill in a few places. Where useful, I will point back to the relevant chapters and expand on how the ideas fit together. Please see [Book Erratum](https://github.com/MapRock/SemanticWebsOfMeaning#book-erratum) for actual errors.

### The Art of Crafting Competency Questions for Knowledge Graphs

Added: Sept 17, 2026

This post, [The Art of Crafting Competency Questions for Knowledge Graphs](https://eugeneasahara.com/2026/09/16/the-art-of-knowledge-graph-competency-questions/), continues the discussion of competency questions from Chapter 10 and the preceding FAQ. It argues that a competency question is a test of competence, not the competence itself, and therefore should not become a fixed and exhaustive requirements list. Using self-service BI as an analogy, the article describes a structure designed to support many questions that were not individually specified beforehand. It compares the requirements, testing, and maintenance expectations of traditional projects, self-service BI, knowledge graphs, and LLM-based systems. It also relates Grüninger and Fox’s progression from motivating scenarios through informal and formal competency questions to a modern hierarchy that begins with broad purpose and works downward toward concrete queries and test cases. Dental-practice and Idaho Plant Rescue examples demonstrate how connected knowledge can support lines of inquiry beyond the initial questions used to design and test the graph.


### Where Should an Enterprise Knowledge Graph Start?
Added: Sept 12, 2026

This post, [Where Should an Enterprise Knowledge Graph Start?](https://eugeneasahara.com/2026/09/12/where-should-an-enterprise-knowledge-graph-start/), responds to the objection that ontology design should begin with competency questions rather than inherited databases and schemas, because existing structures may reflect implementation compromises instead of true domain meaning. I agree with that concern, but Chapter 4 deliberately starts by mining existing enterprise artifacts—especially BI semantic layers, software, databases, business processes, and domain language—because they contain valuable operationalized knowledge and keep the KG grounded in the enterprise. Chapter 10 provides the resolution: treat that existing knowledge as the foundation, make reflecting it the first competency questions, and then use subsequent competency questions to correct, extend, and connect the graph beyond what existing systems already know.



