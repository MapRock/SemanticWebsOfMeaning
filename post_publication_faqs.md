## Post-Publication FAQs

[Semantic Webs of Meaning](https://technicspub.com/semantic-webs-of-meaning/) was published on August 17, 2026. It covers a broad subject, and some ideas naturally deserve additional clarification once the book is out in the world and readers begin comparing its approach with other ways of thinking about knowledge graphs. This document collects those post-publication questions, clarifications, and extensions.

These are not intended as corrections to the book so much as a continuing discussion around it. In some cases, a question may expose an assumption that was implicit in the text; in others, a later article, discussion, or implementation experience may provide an opportunity to explain why I took a particular approach. Where useful, I will point back to the relevant chapters and expand on how the ideas fit together.

### Where Should an Enterprise Knowledge Graph Start?
Added: Sept 12, 2026

This post, [Where Should an Enterprise Knowledge Graph Start?](https://eugeneasahara.com/2026/09/12/where-should-an-enterprise-knowledge-graph-start/), responds to the objection that ontology design should begin with competency questions rather than inherited databases and schemas, because existing structures may reflect implementation compromises instead of true domain meaning. I agree with that concern, but Chapter 4 deliberately starts by mining existing enterprise artifacts—especially BI semantic layers, software, databases, business processes, and domain language—because they contain valuable operationalized knowledge and keep the KG grounded in the enterprise. Chapter 10 provides the resolution: treat that existing knowledge as the foundation, make reflecting it the first competency questions, and then use subsequent competency questions to correct, extend, and connect the graph beyond what existing systems already know.



