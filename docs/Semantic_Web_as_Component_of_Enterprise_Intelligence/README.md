## Overview

This article is based on my blog, [Conditional Trade-Off Graphs – Prolog in the LLM Era – AI 3rd Anniversary Special](https://eugeneasahara.com/2025/11/17/trade-off-semantic-network-prolog-in-the-llm-era-ai-3rd-anniversary-special/).

This folder contains a worked example of how Semantic Web technologies can be viewed as one component of a broader Enterprise Intelligence architecture. Rather than treating a Knowledge Graph as an isolated repository, the example models how it interacts with an LLM, a governed Semantic Layer, human expertise, RAG, data engineering, data science, and other sources of enterprise knowledge. The overall objective is Integrated Knowledge: a connected web of knowledge across business domains that can be used by people, software, analytics, and AI.

The architecture is expressed as a Trade-Off Semantic Network (TOSN) rather than a simple component diagram. The graph attempts to show why each component matters by representing benefits, limitations, costs, dependencies, and causal/value chains. For example, the Semantic Layer contributes curated, governed, high-performance business data but has limits in both data coverage and the kinds of meaning its schema can express. The Knowledge Graph extends that explicit meaning, connects knowledge across domains, captures human knowledge, and helps ground LLM reasoning, while introducing its own authoring and maintenance costs. LLMs provide broad knowledge, synthesis, and natural-language interaction, but are complemented by human expertise and governed enterprise knowledge.

The model also connects these core components to supporting ideas such as Data Mesh, Data Vault/ELT, LLM-assisted KG authoring, rule generation, data science, the Insight Space Graph (ISG), and Tuple Correlation Web (TCW). In particular, it shows how statistical observations and probabilistic relationships discovered through analytical activity can feed back into the Knowledge Graph, complementing explicitly asserted semantic knowledge.

The folder includes the original LLM prompts plus two representations of the resulting model: an RDF/OWL version for tools such as Protégé and a Neo4j Cypher version for graph visualization, along with a Neo4j screenshot. In that sense, it is both an architectural thought experiment and a concrete example of translating an architectural argument into an executable semantic graph.

## Files
- Semantic_Web_as_Component_of_EI_LLM_prompt.md - Prompt to LLM that generated Semantic_Web_as_Component_of_EI.owl. I used ChatGPT to create the owl and cql files.
- Semantic_Web_as_Component_of_EI.owl - RDF/OWL output from the prompt. Load into Protege.
- Semantic_Web_as_Component_of_EI.cql - A Cypher (Neo4j) version.
- Semantic_Web_as_Component_of_EI_LLM_Prompt2.md - Followup prompt in case the first prompt didn't fully include pros and cons.
- Semantic_Web_as_Component_of_EI_Neo4j.png - Snapshot of Neo4j view.
