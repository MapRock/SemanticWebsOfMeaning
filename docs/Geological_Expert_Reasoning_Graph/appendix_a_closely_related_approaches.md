# Appendix A — Closely Related Approaches

## Relationship to Cognitive Task Analysis

The most relevant established family of methods I have found for uncovering the kind of expertise an Expert Reasoning Graph would need to capture is Cognitive Task Analysis (CTA). CTA was developed to uncover the cognitive skills and knowledge required to perform difficult work proficiently. Rather than merely documenting the visible steps of a process, it attempts to elicit such things as the cues experts notice, the judgments they make, the strategies they use, and the knowledge that distinguishes expert performance from following a procedure.

I now think of CTA less as a competing structure than as one possible way of obtaining the knowledge that would populate an Expert Reasoning Graph. The analogy to software development is imperfect but useful: requirements gathering, conceptual design, and related activities help uncover what a system needs to embody before developers can construct it. CTA can play a similar role in surfacing expert reasoning before or while that reasoning is made persistent in a graph. CTA itself is broader than requirements gathering—it can include analysis, representation, and application—but the analogy captures the relationship I have in mind.

One particularly relevant CTA technique is the Critical Decision Method (CDM). Instead of asking an expert to describe an idealized workflow, the interviewer reconstructs a difficult or unusual incident and probes for decision points, cues, alternatives, expectations, goals, and judgments: What did you notice? Why did that matter? What possibilities were you considering? What did you expect to happen? What would have changed your mind? That is remarkably close to the kind of reasoning I am attempting to represent here.

CTA has even been applied directly to technical troubleshooting, where the objective is to uncover the reasoning that allows an experienced technician to diagnose problems that a novice may not know how to approach. Research on aircraft hydraulic systems, for example, used expert–novice analysis to identify critical troubleshooting skills, while other work has used CTA to develop structured approaches for troubleshooting complex systems. This is very close to the SQL Server performance-tuning work I began in 2004, when I attempted to encode what I knew about diagnosing difficult, often “un-Google-able” performance problems into an expert system capable of reasoning toward novel solutions. The important knowledge wasn't simply a checklist of counters to examine; it was the accumulated understanding of which symptoms mattered, what mechanisms might produce them, what evidence to collect next, and how new evidence should change the diagnosis.

The difference here is not that Cognitive Task Analysis stops at elicitation. CTA can include elicitation, analysis, representation, and application of expert knowledge. The Expert Reasoning Graph proposed here is instead a particular way of operationalizing that knowledge: preserving observations, cues, mechanisms, competing hypotheses, predicted evidence, investigative actions, supporting and contradictory evidence, exceptions, and revisions as a persistent graph that can be traversed repeatedly. It can also connect that reasoning directly to enterprise events, the broader KG, and the analytical information supplied through the semantic layer.

Table A1 compares CTA and the Expert Reasoning Graph:

| What CTA may elicit from the expert | How an Expert Reasoning Graph could represent and reuse it |
| --- | --- |
| Cue: “High SQL latency with low CPU gets my attention.” | High SQL Latency + Low CPU → suggests → I/O or Wait-State Hypothesis |
| Mental model: “CPU is not the bottleneck, so I start thinking about waits, storage, blocking, or external dependencies.” | Connect observations to possible mechanisms such as I/O Contention, Locking, Network Delay, or External Service Delay. |
| Competing hypotheses: “It could be disk latency, blocking, a bad query plan, or something outside SQL Server.” | Represent several hypotheses simultaneously rather than prematurely choosing one. |
| Predicted evidence: “If I/O is the problem, I should see particular wait types and elevated storage latency.” | I/O Hypothesis → predicts → PAGEIOLATCH waits and I/O Hypothesis → predicts → elevated disk latency. |
| Investigative action: “Check wait statistics, PerfMon, execution plans, and recent changes.” | Connect each hypothesis to the evidence or analysis most useful for distinguishing it from alternatives. |
| Supporting evidence: “PAGEIOLATCH waits are dominant and storage latency spiked at the same time.” | Observation 91 → supports → I/O Hypothesis. |
| Contradictory evidence: “Disk latency is normal and the waits do not match the hypothesis.” | Observation 104 → contradicts → I/O Hypothesis. |
| Exception: “High I/O waits do not necessarily mean the storage system itself is bad; the workload may simply be requesting excessive I/O.” | Represent exceptions and conditions so rules do not become simplistic cause-and-effect assertions. |
| Revision: “The storage is behaving normally; now I suspect a query-plan change that caused far more reads.” | Weaken one hypothesis, strengthen another, and preserve the path by which the diagnosis changed. |
| Experience from prior cases: “I have seen this pattern after statistics changes or parameter-sensitive plans.” | Link the current investigation to previous cases, recurring patterns, and generalized mechanisms. |
| Next-best question: “What changed immediately before the slowdown?” | Traverse the graph to identify the next observation with the greatest potential to discriminate among hypotheses. |
| Connection to enterprise data: “Show me waits, query plans, deployment history, workload, and storage metrics over the same period.” | Use the graph to formulate analytical questions, then use the semantic layer and event history to supply consistently defined evidence. |

**Table A1 — Comparison of the CTA methodology to the ERG.**

CTA can help surface aspects of what is in the expert's head; the ERG attempts to turn that elicited knowledge into a persistent reasoning structure that can be traversed again by another person—or by AI.

In that sense, an ERG is not simply a graph made by an expert, nor a graph containing expert facts. It is an attempt to capture some of the reasoning that makes the expert an expert—especially the reasoning used when the answer cannot simply be looked up or found in the standard procedure.

### CTA references

- Militello, Laura G., and Robert J. B. Hutton. “Applied Cognitive Task Analysis (ACTA): A Practitioner’s Toolkit for Understanding Cognitive Task Demands.” *Ergonomics*, 1998. A foundational description of CTA as a means of eliciting cognitive skills and demands underlying proficient performance. PubMed record.
- Critical Decision Method / CTA in complex decision making. This example provides a particularly clear description of CDM probes for cues, alternatives, goals, expectations, and decision strategies. PubMed Central (PMC), *Cognitive Task Analysis and the Critical Decision Method*.
- Steinberg, L. S., and D. H. Gitomer. “Cognitive Task Analysis and Interface Design in a Technical Troubleshooting Domain.” *Knowledge-Based Systems*, 1993. Applies CTA to expert troubleshooting of aircraft hydraulic systems. ScienceDirect technical troubleshooting study.
- Schaafstal, Alma, Jan Maarten Schraagen, and Marcel van Berl. “Cognitive Task Analysis and Innovation of Training: The Case of Structured Troubleshooting.” *Human Factors*, 2000. Uses CTA to develop a more systematic approach to complex troubleshooting. Sage Journals structured troubleshooting study.

## Relationship to Clinical Reasoning Graphs

A particularly close recent development is Nisarg Patel's Clinical Reasoning Graphs. Clinical Reasoning Graphs turn diagnostic reasoning into an explicit graph containing clinical features, competing diagnoses, discriminating features, evidence, and relationships such as support, evidence against, and the promotion or demotion of diagnoses as reasoning is revised. Structurally, this is remarkably close to some of what I am trying to capture with an Expert Reasoning Graph.

The purpose, however, is different. Patel's work extracts graphs from free-text LLM diagnostic traces and uses them to examine whether models exhibit stable, clinically grounded reasoning patterns across related cases. The graph is therefore primarily a means of making an already-produced reasoning trace analyzable. The Expert Reasoning Graph described here is intended primarily as persistent and reusable reasoning knowledge: something that can preserve expert observations, mechanisms, competing explanations, predicted evidence, investigative actions, exceptions, and revisions, and can help determine what evidence should be sought next. It can also connect those reasoning structures to event histories, broader domain knowledge, and operational evidence supplied through the semantic layer.

That distinction should not obscure how close the two ideas are. Clinical Reasoning Graphs provide independent evidence that the reasoning process itself—not merely the final diagnosis or answer—can be useful graph-structured information. They also illustrate how such a graph can preserve something that ordinary knowledge representation often loses: how an explanation changed as evidence accumulated.
