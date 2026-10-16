## Appendix C – From Brain Dump to Expert Reasoning Graph

An Expert Reasoning Graph may be considerably harder to construct than a conventional ontology. Classes, properties, definitions, and taxonomies are often already documented somewhere. The most valuable expert reasoning frequently is not.

It may exist only in the head of someone who has spent twenty years diagnosing unusual failures, examining rocks, investigating fraud, tuning databases, repairing equipment, negotiating contracts, or dealing with customers who do not fit the normal script.

That creates an old knowledge-management problem: **how do we get the expertise out?**

But LLMs substantially change the practical difficulty of that problem. LLMs are what I wish existed back in 2004 when I built my graph on SQL Server performance tuning. I could have written a book, but chose to build a graph that would be "live". I believe what took me over half a year back in 2004 would take a matter of weeks.

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

### The LLM Usually Isn't Starting From Zero

There is another important advantage. Unless someone's work is extraordinarily exotic, proprietary, or new, today's LLM will probably already have at least a general understanding of the field in which that person works. A database administrator does not have to begin by explaining what a database, index, query optimizer, or execution plan is. A geologist does not have to explain rocks, minerals, erosion, metamorphism, or plate tectonics. A lawyer does not have to begin by explaining statutes, precedent, evidence, or contracts.

That matters because the expert can spend more time explaining the **finer details of what they actually do**: the exceptions, unusual cases, subtle clues, mechanisms, shortcuts, suspicions, and judgments that are unlikely to appear in ordinary documentation. The LLM already has enough of the surrounding vocabulary and conceptual structure to follow much of that conversation, ask reasonably informed questions, and suggest connections the expert can accept, reject, or correct.

It will not know the expert's particular environment, and its general knowledge may be incomplete or wrong. That is why the SME remains the authority. But the conversation usually does not have to start from first principles. The LLM arrives with enough background knowledge that the expert can begin much farther into the weeds.

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

### Not a Cookbook: Books That Capture Generative Expertise

When I compare building an Expert Reasoning Graph with writing a book about one's expertise, I do **not** mean a cookbook in the usual sense.

A cookbook preserves known recipes. Given a desired dish, it tells us what ingredients to obtain and what sequence of steps to follow. The enterprise equivalents are procedures, runbooks, checklists, decision trees, and documented best practices. Those are valuable, but they describe situations for which we already know what to do.

The harder expertise appears when **there is no recipe**.

A chef is given unfamiliar ingredients and asked to invent dinner. A lawyer encounters a fact pattern that has never occurred exactly this way before. A database specialist faces a performance failure they have never seen. An architect must design a building for a combination of site, people, constraints, and purposes that has never existed before. A jazz musician must decide what to play next while the music is unfolding.

There are books that attempt to teach precisely this deeper kind of knowledge:

| Domain | Example | What makes it different from a recipe book |
| --- | --- | --- |
| **Cooking** | *Kitchen Creativity*, Karen Page | Focuses on inventive cooking without recipes: how accomplished chefs combine technique, intuition, ingredients, constraints, and imagination to create dishes that do not already exist. |
| **Cooking / sensory reasoning** | *Taste What You're Missing*, Barb Stuckey | Breaks taste and flavor into underlying sensory dimensions so that the reader can reason about what a dish is missing and construct new combinations. Rather than supplying the finished recipe, it provides some of the conceptual building blocks from which a new recipe can be invented. |
| **Database performance** | *The Guru's Guide to SQL Server Architecture and Internals*, Ken Henderson | Rather than cataloging performance fixes, Henderson explains the architecture and internals of SQL Server and how those mechanisms affect tuning. Understanding what the system is actually doing provides a mental model from which an expert can diagnose problems that no troubleshooting recipe anticipated. |
| **Law** | *Thinking Like a Lawyer*, Frederick Schauer | Legal expertise cannot consist of memorizing every rule or prior case. The emphasis is on rules, precedent, authority, analogy, interpretation, evidence, and other forms of legal reasoning that allow a lawyer to reason about a new set of facts. |
| **Architecture** | *A Pattern Language*, Christopher Alexander et al. | The patterns are not building plans to copy. They form a language whose elements can be recombined to produce an enormous variety of new buildings and environments. |
| **Jazz improvisation** | *How to Improvise*, Hal Crook | The goal is not to reproduce a composition. It develops the musical structures, choices, and judgment that allow the musician to create something while the performance is actually unfolding. |
| **Medicine** | *How Doctors Think*, Kathryn Montgomery | Clinical reasoning begins with a particular patient rather than a known answer. The physician combines history, observations, empirical knowledge, causal reasoning, and judgment to construct and revise a tentative explanation under uncertainty. |
| **Computer programming** | *Structure and Interpretation of Computer Programs*, Abelson and Sussman et al. | Emphasizes mental models, abstraction, composition, state, modularity, and the structure of computational processes rather than memorizing solutions to particular programming tasks. These concepts become tools for constructing systems that have never previously existed. |

**Table C1 – Books that attempt to capture generative rather than merely procedural expertise.**

These books sit at different points on the spectrum, but they share an important characteristic. They try to communicate **the structures from which answers can be generated**, rather than simply recording the answers that were generated previously.

That distinction is close to the purpose of an Expert Reasoning Graph.

A conventional knowledge base might contain the recipe:

**Problem A → perform Step 1 → Step 2 → Step 3**

The deeper representation attempts to preserve why those steps work, what mechanisms are involved, which conditions matter, what alternatives are available, what evidence would distinguish them, and what to do when the situation does not match anything previously encountered.

In cooking terms, the interesting knowledge is not merely how to make Beef Bourguignon. It is how someone who deeply understands ingredients, heat, texture, acidity, fat, technique, and flavor can look at what happens to be in the kitchen and create a good dish that has never had a recipe.

That is much closer to the kind of expertise an Expert Reasoning Graph is intended to capture.

#### The Knowledge Has to Be Articulatable

There is an important limit to this analogy. Not every form of expertise can necessarily be captured in an Expert Reasoning Graph.

Some expertise becomes deeply embodied or automatic. An accomplished guitarist may perform movements they can no longer consciously decompose. Even when experts can explain what they do, years of experience can make it difficult for them to remember what was once confusing, which intermediate concepts a beginner needs, or which assumptions they are silently making.

The useful target therefore lies somewhere between a recipe and ineffable intuition.

The expert must be able, perhaps with help from an interviewer or LLM, to articulate enough of the underlying structure: what matters, why it matters, what mechanisms are involved, what conditions change the answer, what alternatives they consider, and what evidence causes them to choose one path rather than another.

But the representation should not descend so far into the weeds that it merely documents one particular case. It must preserve knowledge at a level that can be recombined and applied to situations that have not occurred before.

This is why books such as Barb Stuckey's *Taste What You're Missing* are interesting examples. Rather than providing a collection of finished dishes, the book explains underlying dimensions of taste and perception that help a cook understand why combinations work and devise combinations of their own.

That is the level of knowledge an Expert Reasoning Graph needs: **not the finished answer, and not every microscopic movement involved in producing it, but the transferable structure from which a new answer can be reasoned.**
