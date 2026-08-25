## Overview

This article is based on my blog, [Conditional Trade-Off Graphs – Prolog in the LLM Era – AI 3rd Anniversary Special](https://eugeneasahara.com/2025/11/17/trade-off-semantic-network-prolog-in-the-llm-era-ai-3rd-anniversary-special/).

This folder contains a worked example of how Semantic Web technologies can be viewed as one component of a broader Enterprise Intelligence architecture. Rather than treating a Knowledge Graph as an isolated repository, the example models how it interacts with an LLM, a governed Semantic Layer, human expertise, RAG, data engineering, data science, and other sources of enterprise knowledge. The overall objective is Integrated Knowledge: a connected web of knowledge across business domains that can be used by people, software, analytics, and AI.

The architecture is expressed as a Trade-Off Semantic Network (TOSN) rather than a simple component diagram. The graph attempts to show why each component matters by representing benefits, limitations, costs, dependencies, and causal/value chains. For example, the Semantic Layer contributes curated, governed, high-performance business data but has limits in both data coverage and the kinds of meaning its schema can express. The Knowledge Graph extends that explicit meaning, connects knowledge across domains, captures human knowledge, and helps ground LLM reasoning, while introducing its own authoring and maintenance costs. LLMs provide broad knowledge, synthesis, and natural-language interaction, but are complemented by human expertise and governed enterprise knowledge.

The model also connects these core components to supporting ideas such as Data Mesh, Data Vault/ELT, LLM-assisted KG authoring, rule generation, data science, the Insight Space Graph (ISG), and Tuple Correlation Web (TCW). In particular, it shows how statistical observations and probabilistic relationships discovered through analytical activity can feed back into the Knowledge Graph, complementing explicitly asserted semantic knowledge.

The folder includes the original LLM prompts plus two representations of the resulting model: an RDF/OWL version for tools such as Protégé and a Neo4j Cypher version for graph visualization, along with a Neo4j screenshot. In that sense, it is both an architectural thought experiment and a concrete example of translating an architectural argument into an executable semantic graph.

## Files
- [Semantic_Web_as_Component_of_EI_LLM_prompt.md](./Semantic_Web_as_Component_of_EI_LLM_prompt.md) - Prompt to LLM that generated Semantic_Web_as_Component_of_EI.owl. I used ChatGPT to create the owl and cql files.
- [Semantic_Web_as_Component_of_EI.owl](./Semantic_Web_as_Component_of_EI.owl) - RDF/OWL output from the prompt. Load into Protege.
- [Semantic_Web_as_Component_of_EI.cql](./Semantic_Web_as_Component_of_EI.cql) - A Cypher (Neo4j) version.
- [Semantic_Web_as_Component_of_EI_LLM_Prompt2.md](./Semantic_Web_as_Component_of_EI_LLM_Prompt2.md) - Followup prompt in case the first prompt didn't fully include pros and cons.
- [Semantic_Web_as_Component_of_EI_Neo4j.png](./Semantic_Web_as_Component_of_EI_Neo4j.png) - Snapshot of Neo4j view.
## Reproducing the Demo

The easiest way to reproduce the Neo4j demo is to run the supplied Cypher script.

We're using [Neo4j](https://neo4j.com/download/) because we can get a pretty picture from an easy to install platform.

### Neo4j

1. Create or start a Neo4j database using Neo4j Desktop, Neo4j Aura, or another Neo4j installation.

2. Open Neo4j Browser (or the Query interface provided with your Neo4j environment).

3. Run the contents of: [Semantic_Web_as_Component_of_EI.cql](./Semantic_Web_as_Component_of_EI.cql)

   The script creates the TOSN nodes and relationships and finishes with:

   ```cypher
   MATCH (n)-[r]->(m)
   RETURN n, r, m;
   ```

   This displays the resulting Trade-Off Semantic Network as a graph.

   **Note:** the script removes existing nodes labeled `TOSNNode` before rebuilding the graph, so run it in a test database or a database where those nodes may safely be replaced.

4. In the graph visualization, use the `name` property as the node caption. The fuller explanation of each node is stored in its `description` property.

The result should resemble [Semantic_Web_as_Component_of_EI_Neo4j.png](./Semantic_Web_as_Component_of_EI_Neo4j.png). Exact node placement will vary because the visualization layout is generated dynamically.


### Recreating the Demo with an LLM

The repository also contains the prompts used to create the model. This makes it possible to reproduce the *process*, rather than simply loading the finished graph.

1. Supply [Semantic_Web_as_Component_of_EI_LLM_prompt.md](./Semantic_Web_as_Component_of_EI_LLM_prompt.md) to an LLM capable of generating Cypher.

2. Ask the model to return the complete executable Cypher script described by the prompt.

3. Run the generated Cypher in Neo4j and inspect the resulting graph.

4. Supply [Semantic_Web_as_Component_of_EI_LLM_Prompt2.md](./Semantic_Web_as_Component_of_EI_LLM_Prompt2.md) as a follow-up prompt. This asks the LLM to review the graph as a causal/trade-off network rather than merely an inventory of architectural components, remove weak or dangling relationships, improve descriptions, and return a complete replacement script.

5. Run the revised Cypher and compare the resulting graph with the supplied [Semantic_Web_as_Component_of_EI.cql](./Semantic_Web_as_Component_of_EI.cql) and [Semantic_Web_as_Component_of_EI_Neo4j.png](./Semantic_Web_as_Component_of_EI_Neo4j.png).

Because LLM output is nondeterministic and models change over time, regenerating the graph from the prompts will not necessarily produce exactly the same Cypher or graph. The supplied `.cql` file is the reproducible reference version of the demo.

<i>**Important: Whatever the LLM comes up with, it's just a starting point. Hopefully, it's mostly within the ballpark--the 80% of the work. That will leave tweaking, probably substantial, but still the LLM saved much time.**</i>

### RDF/OWL Version

The same architectural model is also supplied as: [Semantic_Web_as_Component_of_EI.owl](./Semantic_Web_as_Component_of_EI.owl)

Open this file in Protégé to inspect the RDF/OWL representation of the model. The Neo4j and OWL files are two representations of the same basic architectural exercise: expressing the components, values, limitations, and relationships of Enterprise Intelligence as an explicit semantic graph.
