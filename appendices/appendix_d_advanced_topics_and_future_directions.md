# Appendix D: Advanced Topics and Future Directions

<i>This appendix accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>

## The Pareto of Capturable Knowledge

KGs are about capturing knowledge that humans know. But a basic problem is that the knowledge in human brains is unimaginably nuanced. KGs capture the important stuff, but the “devil is in the details” is a bona fide hindrance to “artificial intelligence.”

Brains capture nuanced, cross-domain knowledge that databases miss (the 20 % that is really 80 % of value). Multi-modal and neuro-symbolic approaches, [Prolog in the LLM era](https://eugeneasahara.com/category/prolog-in-the-llm-era/), and the need for history and provenance. Can KGs ever replicate the contextual richness of human knowledge workers while scaling?

## History, Provenance, and Time Travel

The problem with software is that it generally reflects the current rules. But for intelligence, we need to know that things were different, so decisions were made on different rules.

This means we need to inject an equivalent of “slowly changing dimensions” in KGs. We also need to provide a sense of provenance — who says so?

See: 
- [https://eugeneasahara.com/2024/11/10/deductive-time-travel-prolog-in-the-llm-era-thanksgiving-special/](https://eugeneasahara.com/2024/11/10/deductive-time-travel-prolog-in-the-llm-era-thanksgiving-special/)
- [Topic in appendix E - Machine learning model versions](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/appendices/appendix_e_machine_learning_models.md#model-identity-versions-and-time-travel)
  
## Multi-Modal Knowledge Graphs

A picture is worth a thousand words and a video or audio, many times more.

This takes us closer to the notion of neuro-symbolic, since the models that will parse a picture, video, or audio are mostly neural networks.

We need to distinguish between mapping the rules of an ML model and mapping the input values and the output values.

As discussed earlier, not all machine learning models lend themselves well to a knowledge graph. The types that do are the categorization and set types: association, cluster. Equations such as those found in linear regressions could be modeled, but in a way that’s very different from RDF. An extreme case is modeling a neural network as RDF. We could have relationships for each weight in the network. That’s not human-readable and that doesn’t add much value.

However, it’s valuable to include the model as a node with relationships to input parameters. The inner workings of the model could be stored as an encoding blob such as pickle, PMML, etc. We could even store Python, SQL.

See: 
- [https://eugeneasahara.com/2025/01/09/machine-learning-models-embedded-in-knowledge-graphs/](https://eugeneasahara.com/2025/01/09/machine-learning-models-embedded-in-knowledge-graphs/)
- [appendix f rich properties](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/appendices/appendix_f_rich_properties.md)

## Logic in Knowledge Graphs

This is a very important aspect that I’ve focused on since 2005 (with my [SQL Server troubleshooting KG](https://eugeneasahara.com/2025/11/17/trade-off-semantic-network-prolog-in-the-llm-era-ai-3rd-anniversary-special/#sql_server_example)). Relationships aren’t just a symbol. They are dynamic, different under different contexts, very complex. This is the notion of applying logic in relationships to determine the strength.

This will focus on SWRL (Semantic Web Rule Language) — and the peculiarities of authoring KGs for reasoning, not Prolog.

The Semantic Web stack—RDF and OWL, supplemented where appropriate by rule languages such as SWRL—does not express arbitrary computational logic as naturally as Prolog.


These are the Prolog posts that actually put logic on the graph, not just “Prolog is still useful.”

- [Knowledge Graphs vs Prolog – Prolog’s Role in the LLM Era, Part 7](https://eugeneasahara.com/2024/08/26/knowledge-graphs-vs-prolog-prologs-role-in-the-llm-era-part-7/)
- [System 1 and System 2 – Prolog and Knowledge Graphs vs. LLMs](https://eugeneasahara.com/system-1-and-system-2-prolog-and-knowledge-graphs-vs-llms/)
- [Four Levels of Intelligence – Prolog’s Role in the LLM Era, Part 6](https://eugeneasahara.com/2024/08/21/four-levels-of-intelligence-prologs-role-in-the-llm-era-part-6/)
- [Prolog Strategy Map – Prolog in the LLM Era – Holiday Season Special](https://eugeneasahara.com/2024/11/29/prolog-strategy-map-prolog-in-the-llm-era-holiday-season-special/)
- [The Products of System 2 – Prolog in the LLM Era](https://eugeneasahara.com/2026/03/04/the-products-of-system-2/)
- [Conditional Trade-Off Graphs – Prolog in the LLM Era – AI 3rd Anniversary Special](https://eugeneasahara.com/2025/11/17/trade-off-semantic-network-prolog-in-the-llm-era-ai-3rd-anniversary-special/)
- [Thinking Deterministically or Creatively – Prolog in the LLM Era – Summer Vacation Special](https://eugeneasahara.com/2025/07/04/thinking-deterministically-or-creatively-prolog-in-the-llm-era-summer-vacation-special/)
- [Closer to Causation – Prolog in the LLM Era – Spring Break Special](https://eugeneasahara.com/2025/03/29/closer-to-causation-prolog-in-the-llm-era-spring-break-special/)

Part 7 is the one that states the split: the KG holds the mapped world; Prolog (or rules) is the deduction over it. The System 1/2 post and Part 6 put that split in the larger architecture. Strategy map and the trade-off/causation posts are the worked examples of logic *on* a graph.

### The Limits of RDF/OWL Logic vs. Prolog

You now have a solid picture of how ontologies and knowledge graphs use RDF, OWL, and the core relationships we listed earlier. A natural next question is whether this stack is powerful enough for *all* the logical reasoning you might need.

The short answer is: no. The RDF/OWL standards (even when extended with SWRL rules) are deliberately more limited than a full logic-programming language like Prolog. This is not a flaw — it is a design choice.

#### Why RDF/OWL + SWRL is weaker at expressing logic

- **Decidability and tractability**: OWL is based on description logics. OWL DL is based on description logics designed to retain decidability. Adding unrestricted SWRL rules can remove that guarantee, which is one reason practical rule systems often impose additional restrictions. Adding full SWRL rules can make the system undecidable in theory, but real-world tools (HermiT, Pellet, etc.) restrict or approximate the rules to keep reasoning practical. Prolog makes no such promise — it is Turing-complete and happily runs forever if your recursion is badly written.

- **Open-world vs. closed-world assumption**: RDF/OWL assumes the open world — anything not stated might still be true. This makes negation (“not”) and counting (“exactly one”) awkward. Prolog commonly uses negation as failure, which provides closed-world-like behavior: failure to prove a goal can be treated as grounds for succeeding with its negation. This is not the same as classical logical negation.

- **Recursion and complex structures**: Simple recursion is possible in SWRL, but deep or mutual recursion quickly hits practical limits in OWL reasoners. Prolog handles recursion, lists, trees, and backtracking as first-class citizens.

- **Procedural control**: Prolog lets you control *how* rules fire (with cuts, ordering, meta-predicates). SWRL is purely declarative and gives the reasoner full freedom over execution order.

In practice, many people who need heavy logic end up writing a hybrid system: they keep the ontology in RDF/OWL for interoperability and use Prolog (or another logic engine) for the parts that SWRL cannot express cleanly.

#### Is it better to use only RDF and SWRL?

It depends on your goals:

- If interoperability, linked open data, and standard tools matter: **Yes**. Stick to RDF + OWL + SWRL. You gain mature reasoners, SPARQL queries, easy exchange with other systems, and future-proofing.
- If maximum logical power and efficiency matter more: **No**. Pure RDF/SWRL will feel restrictive for complex rules, recursive inference, or closed-world reasoning. Many real-world projects use RDF as the *data layer* and a more powerful rule engine (Prolog, Datalog, or even Python-based logic) for the *reasoning layer*.

#### Can RDF + SWRL Be as Robust as Prolog?

Not in its current standard form. SWRL gives you a useful and very readable subset of what Prolog offers, but it sacrifices expressiveness for web-scale interoperability and decidability. You can get surprisingly far with clever modeling, but you will eventually hit walls that Prolog simply walks past.

| Aspect                        | RDF/OWL + SWRL                                                                  | Prolog                                                                |
| ----------------------------- | ------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| Primary orientation           | Ontology, semantic relationships, and declarative rules                         | Logic programming and rule-based computation                          |
| Reasoning model               | OWL description-logic semantics; SWRL adds Horn-like rules                      | Rule evaluation, unification, search, and backtracking                |
| Decidability                  | OWL DL is designed to be decidable; unrestricted SWRL can remove that guarantee | Termination is not generally guaranteed                               |
| Missing information           | Open-world semantics in OWL                                                     | Commonly uses negation as failure                                     |
| Recursion                     | Possible in rule extensions, but not the natural strength of OWL reasoning      | Fundamental programming technique                                     |
| Procedural control            | Primarily declarative                                                           | Can provide execution-order and search control                        |
| Semantic-Web interoperability | Native RDF/OWL ecosystem                                                        | Requires explicit integration or mapping                              |
| Best suited for               | Shared semantic models, classification, inference, and interoperable KGs        | Complex rule execution, recursive reasoning, search, and custom logic |


RDF and OWL provide a standardized, interoperable foundation. SWRL can extend that foundation with rules where supported, but SWRL remains a W3C Member Submission rather than a W3C Recommendation, and support varies among reasoners and graph platforms.

