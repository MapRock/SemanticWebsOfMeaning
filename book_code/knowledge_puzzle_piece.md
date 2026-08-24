<i>This document accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>

# Knowledge Graphs as a Part of the Assemblage of AGI

Artificial intelligence is often discussed as though it were a single thing, or at least as though one dominant technology will eventually absorb all the others. That is not how intelligence works, and it is not how enterprise AI will work.

A human mind is not just a language engine. It carries memories, habits, procedures, expectations, facts, relationships, and impressions of the world. Some of this is conscious and available for deliberate reasoning. Much of it is subconscious, carried out as process. We recognize, associate, decide, move, speak, and act through an assemblage of capabilities, not through one general mechanism.

Enterprise AI will be similar. It will not be built from one component, but from many components playing different roles.

Documents are one of the oldest examples. A document is a serialization of thought. Something held in one mind is written down so another mind can reconstruct it later. Databases play a different role. An OLTP system holds operational state: the customer, the order, the claim, the payment, the status of the world as the enterprise currently records it. BI systems and event-processing systems hold history: what happened, when it happened, how often it happened, and under what conditions. Machine learning models hold relationships learned statistically from data. They may discover patterns, but those patterns are usually compressed into parameters rather than expressed as explicit beliefs.

Knowledge graphs play a different role again. A knowledge graph holds relationships explicitly. It records what an organization currently believes about things, categories, meanings, dependencies, rules, and context. It is not merely another data store, and its value is not simply data retrieval. Its deeper value is reasoning and consultation. It gives both machines and people a structure they can inspect, traverse, question, govern, and use to make sense of other information.

This is why knowledge graphs matter in the AI landscape. They occupy a missing position between data, documents, machine learning, and language models. They give the enterprise a place to represent relationships as relationships, rather than leaving them buried in application code, scattered across documents, implied by database schemas, or compressed inside statistical models.

The purpose of this book is to examine that missing puzzle piece. But the book is not only about knowledge graphs in isolation. A puzzle piece only matters because of where it fits. The larger subject is the AI assemblage itself: the roles different components play, the limits of each component, and why knowledge graphs are essential if enterprise AI is to become more than retrieval, summarization, and pattern matching.

See [The Assemblage of Artificial Intelligence](https://eugeneasahara.com/the-assemblage-of-artificial-intelligence/).

This is Figure 7 on page 21 of the book:

![Knowledge puzzle pieces](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/book_code/images/Figure_7_knowledge_puzzle_pieces.png?raw=true)


## Relationship labels

### Human mind and documents

| From               | Relationship label                      | To                           |
| ------------------ | --------------------------------------- | ---------------------------- |
| Human Brain / Mind | **serializes thought into**             | Documents                    |
| Documents          | **are read and reconstructed by**       | Human Brain / Mind           |
| Documents          | **preserve historical explanation for** | Human / Consultant / Analyst |
| Documents          | **provide textual context to**          | Large Language Models        |

### Databases, BI, and events

| From                             | Relationship label                          | To                               |
| -------------------------------- | ------------------------------------------- | -------------------------------- |
| OLTP Databases                   | **record current operational state**        | Enterprise AI Assemblage         |
| OLTP Databases                   | **emit or imply events for**                | Event Processing / Event Streams |
| Event Processing / Event Streams | **capture history as sequences**            | BI / Analytics                   |
| Event Processing / Event Streams | **supply training and observation data to** | Machine Learning Models          |
| BI / Analytics                   | **summarizes and compares history for**     | Human / Consultant / Analyst     |
| BI / Analytics                   | **provides measures and trends to**         | Enterprise AI Assemblage         |

### Machine learning and LLMs

| From                    | Relationship label                      | To                         |
| ----------------------- | --------------------------------------- | -------------------------- |
| Machine Learning Models | **compress learned relationships into** | Parameters                 |
| Machine Learning Models | **predict or classify for**             | Applications / Agents      |
| Machine Learning Models | **infer patterns from**                 | BI / Analytics             |
| Large Language Models   | **generate language from**              | Documents                  |
| Large Language Models   | **interpret prompts and questions for** | Applications / Agents      |
| Large Language Models   | **summarize and explain outputs from**  | Enterprise AI Assemblage   |
| Large Language Models   | **need grounding from**                 | Knowledge Graphs           |
| Large Language Models   | **need factual context from**           | Documents / Databases / BI |


## Knowledge graph-centered relationships

| From             | Relationship label                    | To                                              |
| ---------------- | ------------------------------------- | ----------------------------------------------- |
| Knowledge Graphs | **hold explicit relationships among** | Things, concepts, categories, and events        |
| Knowledge Graphs | **represent current beliefs for**     | Enterprise AI Assemblage                        |
| Knowledge Graphs | **make relationships inspectable by** | Human / Consultant / Analyst                    |
| Knowledge Graphs | **make relationships traversable by** | Applications / Agents                           |
| Knowledge Graphs | **provide semantic grounding for**    | Large Language Models                           |
| Knowledge Graphs | **connect meanings across**           | Documents / Databases / BI / Events / Models    |
| Knowledge Graphs | **support reasoning over**            | State, history, categories, rules, dependencies |
| Knowledge Graphs | **turn implicit context into**        | Explicit relationships                          |
| Knowledge Graphs | **govern and expose**                 | Enterprise meaning                              |

## Puzzle-piece framing

| From                    | Relationship label                                      | To                       |
| ----------------------- | ------------------------------------------------------- | ------------------------ |
| Documents               | **hold serialized thought**                             | Enterprise AI Assemblage |
| OLTP Databases          | **hold state**                                          | Enterprise AI Assemblage |
| BI / Analytics          | **holds summarized history**                            | Enterprise AI Assemblage |
| Event Streams           | **hold sequence and process history**                   | Enterprise AI Assemblage |
| Machine Learning Models | **hold learned statistical relationships**              | Enterprise AI Assemblage |
| Large Language Models   | **hold language capability and associative generation** | Enterprise AI Assemblage |
| Knowledge Graphs        | **hold explicit relationships and beliefs**             | Enterprise AI Assemblage |

## Most important relationship labels for the graphic


| Label                                   | Use it for                                |
| --------------------------------------- | ----------------------------------------- |
| **serializes thought**                  | Brain → Documents                         |
| **holds state**                         | OLTP → Assemblage                         |
| **holds history**                       | BI / Events → Assemblage                  |
| **learns statistical relationships**    | Data / Events → ML Models                 |
| **generates and interprets language**   | LLMs → Humans / Agents                    |
| **holds explicit relationships**        | Knowledge Graphs → Assemblage             |
| **grounds meaning**                     | Knowledge Graphs → LLMs / Agents          |
| **supports reasoning and consultation** | Knowledge Graphs → Humans / Agents        |
| **acts through**                        | Agents / Applications → Actions           |
| **informs judgment**                    | Assemblage → Human / Consultant / Analyst |

