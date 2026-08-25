# Semantic Webs of Meaning — Supplemental Book Material

This repository contains supplemental appendices, examples, and technical material accompanying the book:

[***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/)
**Eugene Asahara**
[Technics Publications](https://technicspub.com), 2026

Please see my blog, [Trailer to my book: Semantic Webs of Meaning](https://eugeneasahara.com/2026/08/12/trailer-for-my-new-book-semantic-webs-of-meaning/), for an overview.

The material here extends topics discussed in the book with implementation details, examples, code, and supporting material that are better suited to an online, evolving repository than to the printed text.

## About This Repository

The book focuses primarily on the architectural and conceptual role of knowledge graphs: making meaning explicit, connecting knowledge across boundaries, supporting reasoning, and providing structured context that people, software, and AI can use.

These appendices go further into selected technical subjects. They may include:

* RDF, OWL, SWRL, SPARQL, and related Semantic Web examples
* Knowledge graph modeling patterns
* Machine learning models as knowledge graph artifacts
* Rule-based and query-time reasoning examples
* Stardog and other graph-platform implementation patterns
* Code, sample data, and experimental techniques
* Additional material that expands upon topics in the book

The appendices should be considered **supplemental material**, not replacements for the explanations and context provided in the book.

## Relationship to the Book

Because this repository will continue to evolve after publication, examples here may be expanded, corrected, or updated independently of the printed edition.

Where there is a difference between an example in this repository and material in the published book, the repository should be treated as supplemental implementation material rather than as an amendment to the published text unless explicitly stated otherwise.

## Use of Examples

Most examples in this repository are intended to illustrate concepts and architectural patterns. They are not intended to be production-ready implementations.

Before using them in a production environment, evaluate them for your particular requirements, including:

* security
* performance
* scalability
* data governance
* licensing
* platform compatibility
* error handling
* operational support

Product names, technologies, and platforms mentioned in the examples remain the property of their respective owners.



## Repo Copyright

Copyright © 2026 Eugene Asahara. All rights reserved.

Unless a specific file or directory states otherwise, the explanatory text, diagrams, examples, and other original material in this repository are provided as supplemental material for *Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration*.

The presence of material in a public GitHub repository does not, by itself, place that material in the public domain or grant permission to reproduce, republish, redistribute, or incorporate substantial portions into other works.

Code samples may be provided under a separate license if one is included in this repository. Where a license file applies to code, that license governs the covered code. It does not automatically apply to the book text, appendix prose, figures, or other copyrighted material unless explicitly stated.

## Publisher of <i>Semantic Webs of Meaning</i>

*Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration* is published by [**Technics Publications**](https://technicspub.com).

This supplemental repository is maintained by the author. Unless explicitly stated otherwise, repository updates made after publication should not be interpreted as official publisher revisions to the book.

**Please note: This Github repo is owned and maintained by the author, [Eugene Asahara](https://www.linkedin.com/in/eugeneasahara/), not [**Technics Publications**](https://technicspub.com).**

## Author of <i>Semantic Webs of Meaning</i>

**[Eugene Asahara](https://www.linkedin.com/in/eugeneasahara/)**

### Additional material and related work

* [My blog site](https://eugeneasahara.com)
* [Enterprise Intelligence supplemental repo](https://github.com/MapRock/IntelligenceBusiness)
* [Time Molecules Supplemental Repo](https://github.com/MapRock/TimeMolecules)
* [Assemblage of AI Supplemental Repo](https://github.com/MapRock/assemblage-of-artificial-intelligence)

### Related Blogs

- [When Sedans have Four Doors Means Five Different Things](https://eugeneasahara.com/2026/08/24/when-sedans-have-four-doors-means-five-different-things-in-rdf/): This is where knowledge graph people can start to sound like the "Comic book Guy" on the Simpsons or Sheldon Cooper on the Big Bang Theory. But AI is a magnitude worse. And we'll need to deal with it in an increasingly automated fashion, which means we need to start getting into that mindset.

## Errors and Corrections

If you find an error in an example or supplemental appendix, please open a GitHub issue or submit a pull request where appropriate.

Corrections to this repository may be made independently of future printings or editions of the book.

## Book Erratum

This is a collections of errors discovered in the book:

- IRI stands for [Internationalized Resource Identifier](https://dbpedia.org/page/Internationalized_Resource_Identifier), not International Resource Identifier. I've been saying it so much as just IRI, I forgot the "ized".
- [Mistake on RDF 1.2 Reification-Chapter 6](https://github.com/MapRock/SemanticWebsOfMeaning/blob/main/appendices/appendix_g_reification_rdf_1_2.md#fix-to-the-topic-reification-in-rdf-12-august-24-2026) - Stil need to assert a triple in RDF 1.2.
