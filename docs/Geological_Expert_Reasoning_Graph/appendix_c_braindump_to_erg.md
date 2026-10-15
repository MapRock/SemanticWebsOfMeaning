## Appendix C – From Brain Dump to Expert Reasoning Graph

An Expert Reasoning Graph may be considerably harder to construct than a conventional ontology. Classes, properties, definitions, and taxonomies are often already documented somewhere. The most valuable expert reasoning frequently is not.

It may exist only in the head of someone who has spent twenty years diagnosing unusual failures, examining rocks, investigating fraud, tuning databases, repairing equipment, negotiating contracts, or dealing with customers who do not fit the normal script.

That creates an old knowledge-management problem: **how do we get the expertise out?**

But LLMs substantially change the practical difficulty of that problem.

### The SME Does Not Have to Write a Book

Before LLMs, asking an expert to externalize this kind of knowledge could amount to asking them to become an author, knowledge engineer, and ontologist in addition to doing their actual job.

Consider what would be required for me to formally document how I identify an unfamiliar rock while rockhounding. I would have to remember what I notice, separate important cues from incidental ones, explain why geological context changes my interpretation, enumerate plausible alternatives, describe which observations distinguish among them, explain the geological mechanisms behind those distinctions, organize all of that into coherent prose, and probably have someone with more geological expertise correct the result.

Done thoroughly, that begins to resemble writing a small book.

An LLM changes the division of labor.

The subject-matter expert can begin much closer to how the knowledge actually exists in their head: as stories, examples, fragments, exceptions, hunches, comparisons, remembered failures, and statements such as:

> “Usually I would think X, except when Y is present. Then I start wondering about Z.”

That material can be messy. In fact, allowing it to be messy may expose more of the reasoning than requiring the expert to prematurely organize it.

The LLM can do much of the grunt work involved in turning that material into structure: identifying candidate entities and events, separating observations from interpretations, recognizing possible mechanisms, finding implicit conditions, surfacing competing hypotheses, asking for missing context, identifying statements that need qualification, and proposing graph structures for the SME to correct.

The SME's job shifts from **authoring the representation** toward **recognizing whether the representation accurately captures how they think**.

That is a much easier task.

### A Possible Workflow

| Stage | SME contribution | LLM contribution | Result |
| --- | --- | --- | --- |
| **1. Brain dump** | Describe how the work is actually done, including examples, exceptions, hunches, failures, and context. | Listen without forcing premature structure. | Raw expertise |
| **2. Interrogation** | Answer questions about why a clue matters, what alternatives existed, and what would change the conclusion. | Ask specifically for missing context, alternatives, discriminating evidence, and exceptions. | Richer reasoning trace |
| **3. Extraction** | Correct misunderstandings. | Separate observations, states, events, mechanisms, hypotheses, evidence, and actions. | Candidate graph elements |
| **4. Expansion** | Decide whether additional domain knowledge is relevant. | Use broader domain knowledge to suggest relationships or possibilities the SME may have left implicit. | Candidate enrichment |
| **5. Validation** | Accept, reject, qualify, or revise the proposed structure. | Preserve corrections and unresolved uncertainty rather than forcing agreement. | Validated reasoning model |
| **6. Graph construction** | Approve terminology and meaning. | Convert the validated model into graph structures, relationships, IRIs, provenance, and other formal representation. | Initial Expert Reasoning Graph |
| **7. Case testing** | Apply it to additional real situations. | Identify where new cases fit poorly, expose missing branches, and propose revisions. | Evolving graph |

**Table C1 – A possible SME–LLM workflow for constructing an Expert Reasoning Graph.**

The process should be iterative. One conversation is unlikely to capture decades of expertise.

Real cases are particularly valuable because experts often cannot accurately enumerate everything they know in the abstract. Put an actual problem in front of them and previously invisible knowledge appears:

- Why did that detail catch your attention?
- What did you initially think was happening?
- What else could have explained it?
- Why did you reject that possibility?
- What did you look at next?
- What result would have changed your mind?
- Was there something about the surrounding context that made one explanation more plausible?
- Have you seen an exception to this before?

Those questions are much closer to eliciting reasoning than asking an expert to “document your process.”

### The Context Is Part of the Expertise

A useful brain dump cannot consist only of decisions.

The graph needs enough information to reconstruct **why a decision made sense under those circumstances**.

Useful things to elicit include:

| Kind of knowledge | Question to ask |
| --- | --- |
| Observation | What did you actually see or measure? |
| Context | What about the surrounding situation mattered? |
| Cue | What caught your attention? |
| Mechanism | What process could produce what you observed? |
| Hypothesis | What explanations did you consider? |
| Prior expectation | What did you already believe was likely here? |
| Predicted evidence | If this explanation were correct, what else should exist? |
| Discriminating evidence | What observation would distinguish one explanation from another? |
| Contradiction | What did not fit your preferred explanation? |
| Next action | What did you decide to examine next, and why? |
| Exception | When would your normal interpretation fail? |
| Confidence | How strongly did you believe the explanation at that point? |
| Revision | What new evidence caused you to change your mind? |

**Table C2 – Information worth eliciting from a subject-matter expert.**

This is especially important because practical expertise is often encoded in context.

An expert may say:

> “That usually means X.”

But what they really mean may be:

> “That usually means X **in systems configured this way, under these operating conditions, assuming these other two things have already been ruled out**.”

Much of expertise resides in those unstated qualifications.

### What a Brain Dump Might Actually Look Like

It does not have to begin elegantly.

For example, if I were trying to explain how I identify rocks, my first attempt might look more like this than a geology textbook:

> somebody hands me a green rock and says is this jade. i don't really start with “jade has these five properties.” first thing is probably where are we? what kind of rocks have i been seeing around here? what is coming down the washes? is this volcanic country, sedimentary, metamorphic? is there some reason nephrite should even be here?
>
> green by itself doesn't tell me much. there are way too many green things. serpentine, nephrite, jasper, chlorite stuff, epidote, maybe altered volcanic material, aventurine, whatever. some are obviously more likely depending on where we are.
>
> and i'm probably already thinking about how the rock could have gotten here. did it form here? did it wash down from somewhere uphill? glacial transport? somebody dumped it? what formations are around?
>
> texture matters a lot. waxy? granular? crystals? fibrous? does it fracture like jasper? nephrite has that really tough interlocking thing going on. serpentine can look amazingly jade-like but the geology that makes serpentine and the geology that makes nephrite aren't exactly the same.
>
> hardness might help but i don't necessarily start there. same with density. i might try a knife or look at a fresh broken surface, translucence at an edge, weathering, associated minerals. but what i test next depends on what i'm currently wondering about.
>
> that's probably the important part. i don't have a fixed sequence. if something about the location screams altered ultramafic rocks, serpentine jumps way up. if i'm somewhere with the right metamorphic history and nephrite is known around there, that changes things. if it looks green but fractures like chert then maybe i'm going down the wrong road completely.
>
> and sometimes the rock makes me change what i think about the location. maybe i start with what i know about the area, but then the rock contains something that shouldn't be there under my current story. now either the rock came from somewhere else or my story about the geology is wrong.
>
> so i'm bouncing between the rock and the world around the rock. what is it? what could have made it? what else should be here if that's true? what's the easiest thing i can look at next that would knock one of these possibilities out?

That is not ready for publication.

It is, however, extremely useful material for an Expert Reasoning Graph.

An LLM could begin extracting structures such as:

**Observation**

`Specimen 47 → has observed color → Green`

**Context**

`Specimen 47 → found at → Location A`

`Location A → exposes → Metamorphic Formation B`

**Competing hypotheses**

`Specimen 47 → may be → Nephrite`

`Specimen 47 → may be → Serpentine-rich Rock`

`Specimen 47 → may be → Green Jasper`

**Mechanisms and context**

`Ultramafic Alteration → can produce → Serpentine Minerals`

`Metamorphic / Metasomatic Conditions → can produce → Nephrite`

`Transport → can move → Rock away from Source Formation`

**Predicted or discriminating evidence**

`Nephrite Hypothesis → predicts → Exceptional Toughness`

`Jasper Hypothesis → predicts → Conchoidal Fracture`

`Serpentine Hypothesis → predicts → Properties consistent with serpentine minerals`

**Investigation**

`Competing Identification → motivates → Hardness Test`

`Competing Identification → motivates → Examination of Fresh Fracture`

`Competing Identification → motivates → Investigation of Surrounding Geology`

But the LLM should not simply declare this graph correct.

It should return it to the SME:

> Is this actually what you meant?

> Does location influence the hypotheses before you inspect hardness, or only afterward?

> When you say “waxy,” which hypotheses does that strengthen?

> You mentioned material moving down a wash. Should transport history be represented separately from formation history?

> Are there situations where you would ignore the surrounding geology because the specimen is obviously transported?

Those questions can reveal another layer of expertise.

And the cycle repeats.

### The LLM Can Contribute Knowledge Too

There is another unusual advantage.

The SME does not necessarily possess all of the formal domain knowledge needed to express what they know.

I am not a geologist. My practical rockhounding knowledge contains holes. An LLM, however, may know relevant geological terminology, mineral-forming processes, established classifications, published ontologies, and relationships that help make my informal reasoning explicit.

That means the interaction need not be limited to transcription.

I might say:

> “I know that this kind of green rock makes more sense where certain deep rocks have been altered by water.”

The LLM may recognize that I am probably reaching toward concepts involving ultramafic rocks, serpentinization, hydrothermal alteration, or metasomatism and can ask whether those concepts accurately describe what I mean.

But the provenance matters.

Knowledge supplied by the SME should not silently become indistinguishable from knowledge supplied by the model, a publication, an ontology, or another expert. The graph should be able to retain where each assertion came from and how strongly it has been validated.

The LLM helps construct the model. It does not become the unquestioned authority behind it.

### From Writing Books to Building Graphs

The hardest part remains the same problem humans have always faced: converting tacit expertise into something explicit.

Experts have done this before.

It is what happens when someone spends several years writing a serious technical book. They remember cases, explain concepts they normally take for granted, invent examples, organize dependencies, define terms, identify exceptions, and repeatedly discover that something obvious to them was not obvious to the reader.

The LLM does not eliminate that intellectual work.

It can eliminate a remarkable amount of the **serialization work surrounding it**.

The expert can talk, brainstorm, paste notes, describe cases, correct proposed interpretations, and react to candidate graph structures rather than personally turning decades of experience into polished prose before anyone can structure it.

In that sense, constructing an Expert Reasoning Graph may be similar to writing a book about one's expertise—but with an unusually capable interviewer, researcher, editor, knowledge engineer, and first-draft ontologist participating continuously.

And the final artifact is different.

A book serializes knowledge into a form a human reads from beginning to end.

An Expert Reasoning Graph serializes much of that same knowledge into something that a person or AI can **traverse**:

**observation → possible mechanism → hypothesis → predicted evidence → investigation → new observation → support or contradiction → revised hypothesis**

That does not make the Expert Reasoning Graph easy to construct.

It may, however, make something that was once prohibitively difficult merely difficult.
