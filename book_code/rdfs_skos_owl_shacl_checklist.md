<i>This document accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>

# Choosing Between RDFS, SKOS, OWL, and SHACL

RDF gives us the basic graph structure, but RDFS, SKOS, OWL, and SHACL serve different purposes. The choice depends on what we are trying to express: a simple class hierarchy, a managed vocabulary, formal logical meaning, or data-quality rules. They overlap, and they are often used together, but choosing the wrong one can make a model either too weak or unnecessarily rigid. The table below is a quick guide to which tool best fits which job.

| Question / attribute                                                           |    RDFS |                      SKOS |                  OWL |              SHACL |
| ------------------------------------------------------------------------------ | ------: | ------------------------: | -------------------: | -----------------: |
| Do I need to define a basic class or category?                                 | **Yes** | **Concepts, not classes** |              **Yes** |                 No |
| Do I need to say one class is a subclass of another?                           | **Yes** |                    **No** |              **Yes** |                 No |
| Do I need human-readable labels or comments?                                   | **Yes** |                   **Yes** | **Yes, via annotations** |         Sometimes |
| Do I need a glossary, taxonomy, thesaurus, or controlled vocabulary?           | Limited |                   **Yes** |            Sometimes |                 No |
| Do I need preferred labels, alternate labels, or hidden labels?                | Limited |                   **Yes** |             Limited |                 No |
| Do I need broader/narrower concept relationships?                              | Limited |                   **Yes** |            Sometimes |                 No |
| Do I need formal logical reasoning?                                            | Limited |                        No |              **Yes** |                 No |
| Do I need to define equivalent classes or equivalent properties?               |      No |                        No |              **Yes** |                 No |
| Do I need inverse relationships?                                               |      No |                        No |              **Yes** |                 No |
| Do I need restrictions such as “a parent is a person with at least one child”? |      No |                        No |              **Yes** |                 No |
| Do I need cardinality rules for logical meaning?                               |      No |                        No |              **Yes** |                 No |
| Do I need to validate that data has required properties?                       |      No |                        No |                   No |            **Yes** |
| Do I need to validate datatypes, counts, patterns, or allowed values?          |      No |                        No |                   No |            **Yes** |
| Do I need to check graph data quality before publishing?                       |      No |                        No |                   No |            **Yes** |
| Do I need to support AI/RAG with clearer governed meaning?                     |     Yes |                       Yes |                  Yes |      **Sometimes** |
| Do I need to help humans understand the graph?                                 |     Yes |                   **Yes** |                  Yes |          Sometimes |
| Do I need to help machines infer new facts?                                    | Limited |                   Limited |              **Yes** |                 No |
| Do I need to help machines detect nonconforming data?                          |      No |                        No |                   No |            **Yes** |
