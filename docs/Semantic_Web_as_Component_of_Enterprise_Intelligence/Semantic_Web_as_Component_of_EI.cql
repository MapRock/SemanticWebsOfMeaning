// ============================================================================
// ENTERPRISE INTELLIGENCE TOSN — SECOND CUT
// Clears the current graph and rebuilds it.
// ============================================================================

MATCH (n:TOSNNode)
DETACH DELETE n;

DROP CONSTRAINT tosn_node_id IF EXISTS;


// ============================================================================
// CONSTRAINT
// ============================================================================

CREATE CONSTRAINT tosn_node_id IF NOT EXISTS
FOR (n:TOSNNode)
REQUIRE n.id IS UNIQUE;


// ============================================================================
// CENTRAL GOAL
// ============================================================================

CREATE (:TOSNNode:Goal {
    id: 'IntegratedKnowledge',
    name: 'Integrated Knowledge',
    description:
      'An integrated web of knowledge across business domains for people, software, analytics, and AI.'
});


// ============================================================================
// THREE CENTRAL COMPONENTS
// ============================================================================

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'LLM',
    name: 'LLM',
    description:
      'Broad learned knowledge, synthesis, language understanding, and reasoning across many domains.'
});

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'SemanticLayer',
    name: 'Semantic Layer',
    description:
      'Highly curated, governed, secure, business-friendly, high-performance access to enterprise data.'
});

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'KnowledgeGraph',
    name: 'Knowledge Graph',
    description:
      'Explicit governed meaning and relationships that ground LLMs and extend beyond the Semantic Layer schema.'
});


// ============================================================================
// LLM VALUES
// ============================================================================

CREATE (:TOSNNode:Value {
    id: 'BroadKnowledge',
    name: 'Broad Knowledge',
    description:
      'Knowledge across an unusually broad range of subjects and domains.'
});

CREATE (:TOSNNode:Value {
    id: 'RapidSynthesis',
    name: 'Rapid Synthesis',
    description:
      'Ability to combine information and ideas rapidly across domains.'
});

CREATE (:TOSNNode:Value {
    id: 'NaturalLanguage',
    name: 'Natural Language',
    description:
      'A conversational interface for accessing, explaining, and working with knowledge.'
});


// ============================================================================
// LLM LIMITATIONS
// ============================================================================

CREATE (:TOSNNode:CostOrCon {
    id: 'DepthLimit',
    name: 'Depth Limit',
    description:
      'Broad LLM knowledge does not guarantee the deepest specialist expertise in every domain.'
});

CREATE (:TOSNNode:CostOrCon {
    id: 'TrainingGap',
    name: 'Knowledge Gap',
    description:
      'Important knowledge may be absent from training data, including knowledge that was never written down.'
});

CREATE (:TOSNNode:CostOrCon {
    id: 'ComputeCost',
    name: 'LLM Cost',
    description:
      'LLM inference can consume significant tokens, compute, energy, and infrastructure resources.'
});


// ============================================================================
// HUMAN EXPERTS
// ============================================================================

CREATE (:TOSNNode:IntelligenceComponent:KnowledgeSource {
    id: 'HumanExperts',
    name: 'Human Experts',
    description:
      'People with deep domain expertise, experience, judgment, and knowledge that may never have been formally recorded.'
});

CREATE (:TOSNNode:Value {
    id: 'DeepExpertise',
    name: 'Deep Expertise',
    description:
      'Specialized knowledge and judgment deeper than general-purpose knowledge.'
});

CREATE (:TOSNNode:Value {
    id: 'TacitKnowledge',
    name: 'Tacit Knowledge',
    description:
      'Experience, judgment, preferences, beliefs, and knowledge people possess but may never have documented.'
});


// ============================================================================
// SEMANTIC LAYER VALUES
// ============================================================================

CREATE (:TOSNNode:Value {
    id: 'CuratedData',
    name: 'Curated Data',
    description:
      'Business data that has been integrated, modeled, cleaned, governed, and made suitable for decision making.'
});

CREATE (:TOSNNode:Capability {
    id: 'TrustedDecisionData',
    name: 'Trusted Data',
    description:
      'Consistent governed information that users can rely upon when making business decisions.'
});

CREATE (:TOSNNode:Value {
    id: 'HighPerformance',
    name: 'High Performance',
    description:
      'High-performance analytical access through pre-aggregation, caching, query optimization, or similar techniques.'
});

CREATE (:TOSNNode:Value {
    id: 'CentralSecurity',
    name: 'Central Security',
    description:
      'Centralized enforcement of data security, governance, and access policies.'
});

CREATE (:TOSNNode:Capability {
    id: 'GovernedAccess',
    name: 'Governed Access',
    description:
      'Consistent controlled access to enterprise information across users, applications, analytics, and AI.'
});

CREATE (:TOSNNode:Value {
    id: 'BusinessView',
    name: 'Business View',
    description:
      'Measures, dimensions, hierarchies, and concepts presented in business terms rather than physical source schemas.'
});

CREATE (:TOSNNode:Capability {
    id: 'DecisionUsability',
    name: 'Decision Usability',
    description:
      'Information that business users can understand and use without needing to understand source-system implementation.'
});

CREATE (:TOSNNode:Value {
    id: 'CommonDecisionData',
    name: 'Common Decision Data',
    description:
      'The highly reused core of governed data required by most users for most recurring business decisions.'
});


// ============================================================================
// SEMANTIC LAYER LIMITATIONS
// ============================================================================

CREATE (:TOSNNode:CostOrCon {
    id: 'DataCoverageGap',
    name: 'Data Coverage Gap',
    description:
      'Relevant internal, partner, purchased, public, or other data that is not yet accessible through the governed Semantic Layer.'
});

CREATE (:TOSNNode:CostOrCon {
    id: 'MeaningCoverageGap',
    name: 'Meaning Gap',
    description:
      'Relationships, goals, beliefs, rules, opinions, context, and other meaning that cannot be fully represented as Semantic Layer measures, dimensions, and schemas.'
});

CREATE (:TOSNNode:CostOrCon {
    id: 'SLOnboardingEffort',
    name: 'SL Onboarding Effort',
    description:
      'Effort required to bring a new business domain, its data, semantics, measures, dimensions, security, and governance into the Semantic Layer.'
});


// ============================================================================
// KNOWLEDGE GRAPH VALUES
// ============================================================================

CREATE (:TOSNNode:Value {
    id: 'ExplicitMeaning',
    name: 'Explicit Meaning',
    description:
      'Explicit, addressable, governable meanings and relationships represented in the graph.'
});

CREATE (:TOSNNode:Value {
    id: 'HumanKnowledge',
    name: 'Human Knowledge',
    description:
      'Goals, appetites, desires, opinions, beliefs, expertise, and other knowledge explicitly contributed by people.'
});

CREATE (:TOSNNode:Value {
    id: 'CrossDomainLinks',
    name: 'Cross-Domain Links',
    description:
      'Explicit relationships connecting concepts and entities across organizational and technical boundaries.'
});

CREATE (:TOSNNode:Value {
    id: 'LLMGrounding',
    name: 'LLM Grounding',
    description:
      'Explicit governed enterprise context that can constrain and enrich LLM reasoning.'
});

CREATE (:TOSNNode:Value {
    id: 'BeyondSLSchema',
    name: 'Richer Meaning',
    description:
      'Meaning and relationships that extend beyond the measures, dimensions, hierarchies, and schemas of the Semantic Layer.'
});


// ============================================================================
// KNOWLEDGE GRAPH COSTS
// ============================================================================

CREATE (:TOSNNode:CostOrCon {
    id: 'KGAuthoringCost',
    name: 'KG Authoring',
    description:
      'Manual and intellectual effort required to identify, express, connect, and govern enterprise knowledge.'
});

CREATE (:TOSNNode:CostOrCon {
    id: 'KGMaintenanceCost',
    name: 'KG Maintenance',
    description:
      'Ongoing effort required to keep explicit knowledge synchronized with changes in the enterprise and outside world.'
});


// ============================================================================
// RAG AND GROUNDED REASONING
// ============================================================================

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'RAG',
    name: 'RAG',
    description:
      'Retrieval-Augmented Generation that supplies relevant enterprise data and knowledge to an LLM at inference time.'
});

CREATE (:TOSNNode:Capability {
    id: 'FastRAGRetrieval',
    name: 'Fast RAG',
    description:
      'Rapid retrieval of governed business data and knowledge for use in LLM prompts and reasoning.'
});

CREATE (:TOSNNode:Capability {
    id: 'GroundedReasoning',
    name: 'Grounded Reasoning',
    description:
      'LLM reasoning informed by governed enterprise data, explicit knowledge, and relationships.'
});


// ============================================================================
// DATA MESH
// ============================================================================

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'DataMesh',
    name: 'Data Mesh',
    description:
      'Domain-oriented data ownership and product practices that can accelerate the addition of business domains to the governed information environment.'
});

CREATE (:TOSNNode:Value {
    id: 'FasterDomainOnboarding',
    name: 'Faster Onboarding',
    description:
      'Faster onboarding of domain-owned business data and semantic models into the governed enterprise Semantic Layer.'
});

CREATE (:TOSNNode:Value {
    id: 'BroaderDataCoverage',
    name: 'Broader Coverage',
    description:
      'A greater portion of relevant enterprise and external data made available through the governed Semantic Layer.'
});


// ============================================================================
// DATA VAULT / ELT
// ============================================================================

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'DataVault',
    name: 'Data Vault / ELT',
    description:
      'An ingestion-oriented architecture that can capture source data before all downstream business transformation has been completed.'
});

CREATE (:TOSNNode:Value {
    id: 'FasterSourceIngestion',
    name: 'Faster Ingestion',
    description:
      'Faster capture of new source-system data into the enterprise data environment.'
});

CREATE (:TOSNNode:CostOrCon {
    id: 'TransformBottleneck',
    name: 'Transform Bottleneck',
    description:
      'Delay caused when extensive transformation and business modeling must be completed before source data can be incorporated.'
});


// ============================================================================
// KNOWLEDGE GRAPH AUTOMATION
// ============================================================================

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'LLMKGAuthoring',
    name: 'LLM KG Authoring',
    description:
      'LLM assistance for proposing, documenting, connecting, reviewing, and maintaining knowledge-graph content.'
});

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'DataScience',
    name: 'Data Science',
    description:
      'Statistical and machine-learning techniques that discover patterns, associations, classifications, and other candidate knowledge.'
});

CREATE (:TOSNNode:Value {
    id: 'DiscoveredPatterns',
    name: 'Discovered Patterns',
    description:
      'Automatically discovered patterns that can become observations, evidence, or candidate explicit knowledge.'
});

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'RuleGeneration',
    name: 'Rule Generation',
    description:
      'Automated or AI-assisted generation of explicit rules from data, models, documents, and expert knowledge.'
});


// ============================================================================
// ISG / TCW
// ============================================================================

CREATE (:TOSNNode:Capability {
    id: 'FrequentInsightRefresh',
    name: 'Rapid Insight Refresh',
    description:
      'Ability to repeatedly execute analytical functions and refresh statistical observations because the underlying Semantic Layer is highly performant.'
});

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'ISG',
    name: 'ISG',
    description:
      'Insight Space Graph that collects significant observations produced across analytical activity and domains.'
});

CREATE (:TOSNNode:IntelligenceComponent {
    id: 'TCW',
    name: 'TCW',
    description:
      'Tuple Correlation Web that records statistical relationships among observations, attributes, and analytical results.'
});

CREATE (:TOSNNode:Value {
    id: 'ObservedInsights',
    name: 'Observed Insights',
    description:
      'Significant observations discovered across business domains and analytical activity.'
});

CREATE (:TOSNNode:Value {
    id: 'StatisticalLinks',
    name: 'Statistical Links',
    description:
      'Probabilistic and statistical relationships that complement explicitly asserted semantic relationships.'
});


// ============================================================================
// ADDITIONAL DATA SOURCES
// ============================================================================

CREATE (:TOSNNode:KnowledgeSource {
    id: 'InternalData',
    name: 'Internal Data',
    description:
      'Relevant enterprise data that exists internally but has not yet been incorporated into the governed Semantic Layer.'
});

CREATE (:TOSNNode:KnowledgeSource {
    id: 'PartnerData',
    name: 'Partner Data',
    description:
      'Data and knowledge supplied by customers, suppliers, partners, or other organizations in the business ecosystem.'
});

CREATE (:TOSNNode:KnowledgeSource {
    id: 'ExternalData',
    name: 'External Data',
    description:
      'Purchased, public, licensed, or other third-party data that can add context unavailable from internal systems.'
});


// ============================================================================
// CORE COMPONENTS CONTRIBUTE TO THE CENTRAL GOAL
// ============================================================================

MATCH
    (llm:TOSNNode {id:'LLM'}),
    (sl:TOSNNode {id:'SemanticLayer'}),
    (kg:TOSNNode {id:'KnowledgeGraph'}),
    (goal:TOSNNode {id:'IntegratedKnowledge'})
MERGE (llm)-[:CONTRIBUTES_TO]->(goal)
MERGE (sl)-[:CONTRIBUTES_TO]->(goal)
MERGE (kg)-[:CONTRIBUTES_TO]->(goal);


// ============================================================================
// LLM VALUE CHAINS
// ============================================================================

MATCH
    (llm:TOSNNode {id:'LLM'}),
    (broad:TOSNNode {id:'BroadKnowledge'}),
    (synth:TOSNNode {id:'RapidSynthesis'}),
    (nl:TOSNNode {id:'NaturalLanguage'}),
    (goal:TOSNNode {id:'IntegratedKnowledge'})
MERGE (llm)-[:PROVIDES_VALUE {polarity:'pro'}]->(broad)
MERGE (llm)-[:PROVIDES_VALUE {polarity:'pro'}]->(synth)
MERGE (llm)-[:PROVIDES_VALUE {polarity:'pro'}]->(nl)
MERGE (broad)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal)
MERGE (synth)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal)
MERGE (nl)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal);


// ============================================================================
// LLM LIMITATIONS
// ============================================================================

MATCH
    (llm:TOSNNode {id:'LLM'}),
    (depth:TOSNNode {id:'DepthLimit'}),
    (gap:TOSNNode {id:'TrainingGap'}),
    (cost:TOSNNode {id:'ComputeCost'})
MERGE (llm)-[:HAS_LIMITATION {polarity:'con'}]->(depth)
MERGE (llm)-[:HAS_LIMITATION {polarity:'con'}]->(gap)
MERGE (llm)-[:INCURS_COST {polarity:'con'}]->(cost);


// ============================================================================
// HUMAN EXPERTS ADDRESS LLM LIMITATIONS
// ============================================================================

MATCH
    (experts:TOSNNode {id:'HumanExperts'}),
    (deep:TOSNNode {id:'DeepExpertise'}),
    (tacit:TOSNNode {id:'TacitKnowledge'}),
    (depth:TOSNNode {id:'DepthLimit'}),
    (gap:TOSNNode {id:'TrainingGap'})
MERGE (experts)-[:PROVIDES_VALUE {polarity:'pro'}]->(deep)
MERGE (experts)-[:PROVIDES_VALUE {polarity:'pro'}]->(tacit)
MERGE (deep)-[:MITIGATES {polarity:'pro'}]->(depth)
MERGE (tacit)-[:MITIGATES {polarity:'pro'}]->(gap);


// ============================================================================
// SEMANTIC LAYER VALUE CHAINS
// ============================================================================

MATCH
    (sl:TOSNNode {id:'SemanticLayer'}),
    (curated:TOSNNode {id:'CuratedData'}),
    (trusted:TOSNNode {id:'TrustedDecisionData'}),
    (goal:TOSNNode {id:'IntegratedKnowledge'})
MERGE (sl)-[:PROVIDES_VALUE {polarity:'pro'}]->(curated)
MERGE (curated)-[:PROMOTES {polarity:'pro'}]->(trusted)
MERGE (trusted)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal);


MATCH
    (sl:TOSNNode {id:'SemanticLayer'}),
    (security:TOSNNode {id:'CentralSecurity'}),
    (access:TOSNNode {id:'GovernedAccess'}),
    (goal:TOSNNode {id:'IntegratedKnowledge'})
MERGE (sl)-[:PROVIDES_VALUE {polarity:'pro'}]->(security)
MERGE (security)-[:ENABLES {polarity:'pro'}]->(access)
MERGE (access)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal);


MATCH
    (sl:TOSNNode {id:'SemanticLayer'}),
    (view:TOSNNode {id:'BusinessView'}),
    (usable:TOSNNode {id:'DecisionUsability'}),
    (goal:TOSNNode {id:'IntegratedKnowledge'})
MERGE (sl)-[:PROVIDES_VALUE {polarity:'pro'}]->(view)
MERGE (view)-[:PROMOTES {polarity:'pro'}]->(usable)
MERGE (usable)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal);


MATCH
    (sl:TOSNNode {id:'SemanticLayer'}),
    (common:TOSNNode {id:'CommonDecisionData'}),
    (goal:TOSNNode {id:'IntegratedKnowledge'})
MERGE (sl)-[:PROVIDES_VALUE {polarity:'pro'}]->(common)
MERGE (common)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal);


// ============================================================================
// SEMANTIC LAYER PERFORMANCE
// ============================================================================

MATCH
    (sl:TOSNNode {id:'SemanticLayer'}),
    (perf:TOSNNode {id:'HighPerformance'}),
    (fast:TOSNNode {id:'FastRAGRetrieval'}),
    (refresh:TOSNNode {id:'FrequentInsightRefresh'})
MERGE (sl)-[:PROVIDES_VALUE {polarity:'pro'}]->(perf)
MERGE (perf)-[:ENABLES {polarity:'pro'}]->(fast)
MERGE (perf)-[:ENABLES {polarity:'pro'}]->(refresh);


// ============================================================================
// SEMANTIC LAYER LIMITATIONS
// ============================================================================

MATCH
    (sl:TOSNNode {id:'SemanticLayer'}),
    (dataGap:TOSNNode {id:'DataCoverageGap'}),
    (meaningGap:TOSNNode {id:'MeaningCoverageGap'}),
    (effort:TOSNNode {id:'SLOnboardingEffort'})
MERGE (sl)-[:HAS_LIMITATION {polarity:'con'}]->(dataGap)
MERGE (sl)-[:HAS_LIMITATION {polarity:'con'}]->(meaningGap)
MERGE (sl)-[:INCURS_COST {polarity:'con'}]->(effort);


// ============================================================================
// KNOWLEDGE GRAPH VALUE CHAINS
// ============================================================================

MATCH
    (kg:TOSNNode {id:'KnowledgeGraph'}),
    (meaning:TOSNNode {id:'ExplicitMeaning'}),
    (human:TOSNNode {id:'HumanKnowledge'}),
    (links:TOSNNode {id:'CrossDomainLinks'}),
    (ground:TOSNNode {id:'LLMGrounding'}),
    (beyond:TOSNNode {id:'BeyondSLSchema'}),
    (goal:TOSNNode {id:'IntegratedKnowledge'}),
    (trainingGap:TOSNNode {id:'TrainingGap'}),
    (meaningGap:TOSNNode {id:'MeaningCoverageGap'})
MERGE (kg)-[:PROVIDES_VALUE {polarity:'pro'}]->(meaning)
MERGE (kg)-[:PROVIDES_VALUE {polarity:'pro'}]->(human)
MERGE (kg)-[:PROVIDES_VALUE {polarity:'pro'}]->(links)
MERGE (kg)-[:PROVIDES_VALUE {polarity:'pro'}]->(ground)
MERGE (kg)-[:PROVIDES_VALUE {polarity:'pro'}]->(beyond)

MERGE (meaning)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal)
MERGE (human)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal)
MERGE (links)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal)

MERGE (human)-[:MITIGATES {polarity:'pro'}]->(trainingGap)
MERGE (beyond)-[:MITIGATES {polarity:'pro'}]->(meaningGap);


// ============================================================================
// KNOWLEDGE GRAPH COSTS
// ============================================================================

MATCH
    (kg:TOSNNode {id:'KnowledgeGraph'}),
    (author:TOSNNode {id:'KGAuthoringCost'}),
    (maint:TOSNNode {id:'KGMaintenanceCost'})
MERGE (kg)-[:INCURS_COST {polarity:'con'}]->(author)
MERGE (kg)-[:INCURS_COST {polarity:'con'}]->(maint);


// ============================================================================
// RAG
// ============================================================================

MATCH
    (llm:TOSNNode {id:'LLM'}),
    (rag:TOSNNode {id:'RAG'}),
    (kg:TOSNNode {id:'KnowledgeGraph'}),
    (sl:TOSNNode {id:'SemanticLayer'}),
    (grounding:TOSNNode {id:'LLMGrounding'}),
    (fast:TOSNNode {id:'FastRAGRetrieval'}),
    (reason:TOSNNode {id:'GroundedReasoning'}),
    (goal:TOSNNode {id:'IntegratedKnowledge'})
MERGE (llm)-[:USES]->(rag)
MERGE (rag)-[:RETRIEVES_FROM]->(kg)
MERGE (rag)-[:RETRIEVES_FROM]->(sl)
MERGE (grounding)-[:PROMOTES {polarity:'pro'}]->(reason)
MERGE (fast)-[:ENABLES {polarity:'pro'}]->(reason)
MERGE (rag)-[:ENABLES {polarity:'pro'}]->(reason)
MERGE (reason)-[:CONTRIBUTES_TO {polarity:'pro'}]->(goal);


// ============================================================================
// KG / SEMANTIC LAYER SYMBIOSIS
// ============================================================================

MATCH
    (kg:TOSNNode {id:'KnowledgeGraph'}),
    (sl:TOSNNode {id:'SemanticLayer'})
MERGE (kg)-[:USES_AS_VIRTUAL_GRAPH]->(sl)
MERGE (kg)-[:EXTENDS_MEANING_BEYOND {polarity:'pro'}]->(sl);


// ============================================================================
// DATA MESH
// Data Mesh -> Faster Onboarding -> less onboarding effort
//                                  -> broader coverage -> less coverage gap
// ============================================================================

MATCH
    (mesh:TOSNNode {id:'DataMesh'}),
    (fast:TOSNNode {id:'FasterDomainOnboarding'}),
    (effort:TOSNNode {id:'SLOnboardingEffort'}),
    (coverage:TOSNNode {id:'BroaderDataCoverage'}),
    (gap:TOSNNode {id:'DataCoverageGap'})
MERGE (mesh)-[:PROMOTES {polarity:'pro'}]->(fast)
MERGE (fast)-[:MITIGATES {polarity:'pro'}]->(effort)
MERGE (fast)-[:PROMOTES {polarity:'pro'}]->(coverage)
MERGE (coverage)-[:MITIGATES {polarity:'pro'}]->(gap);


// ============================================================================
// DATA VAULT / ELT
// Data Vault -> Faster Ingestion -> less transformation bottleneck
//                                -> faster domain onboarding
// ============================================================================

MATCH
    (vault:TOSNNode {id:'DataVault'}),
    (ingest:TOSNNode {id:'FasterSourceIngestion'}),
    (bottle:TOSNNode {id:'TransformBottleneck'}),
    (onboard:TOSNNode {id:'FasterDomainOnboarding'})
MERGE (vault)-[:PROMOTES {polarity:'pro'}]->(ingest)
MERGE (ingest)-[:MITIGATES {polarity:'pro'}]->(bottle)
MERGE (ingest)-[:PROMOTES {polarity:'pro'}]->(onboard);


// ============================================================================
// ADDITIONAL DATA SOURCES CAN EXTEND SEMANTIC-LAYER COVERAGE
// ============================================================================

MATCH
    (internal:TOSNNode {id:'InternalData'}),
    (partner:TOSNNode {id:'PartnerData'}),
    (external:TOSNNode {id:'ExternalData'}),
    (coverage:TOSNNode {id:'BroaderDataCoverage'})
MERGE (internal)-[:CAN_EXTEND {polarity:'pro'}]->(coverage)
MERGE (partner)-[:CAN_EXTEND {polarity:'pro'}]->(coverage)
MERGE (external)-[:CAN_EXTEND {polarity:'pro'}]->(coverage);


// ============================================================================
// LLM-ASSISTED KG CREATION AND MAINTENANCE
// ============================================================================

MATCH
    (helper:TOSNNode {id:'LLMKGAuthoring'}),
    (author:TOSNNode {id:'KGAuthoringCost'}),
    (maint:TOSNNode {id:'KGMaintenanceCost'})
MERGE (helper)-[:MITIGATES {polarity:'pro'}]->(author)
MERGE (helper)-[:MITIGATES {polarity:'pro'}]->(maint);


// ============================================================================
// DATA SCIENCE AND RULE GENERATION
// ============================================================================

MATCH
    (ds:TOSNNode {id:'DataScience'}),
    (patterns:TOSNNode {id:'DiscoveredPatterns'}),
    (kg:TOSNNode {id:'KnowledgeGraph'})
MERGE (ds)-[:PRODUCES {polarity:'pro'}]->(patterns)
MERGE (patterns)-[:FEEDS {polarity:'pro'}]->(kg);


MATCH
    (rules:TOSNNode {id:'RuleGeneration'}),
    (author:TOSNNode {id:'KGAuthoringCost'}),
    (kg:TOSNNode {id:'KnowledgeGraph'})
MERGE (rules)-[:MITIGATES {polarity:'pro'}]->(author)
MERGE (rules)-[:FEEDS {polarity:'pro'}]->(kg);


// ============================================================================
// ISG / TCW
// High-performance Semantic Layer -> rapid statistical refresh
// -> ISG / TCW -> observations and statistical relationships -> KG
// ============================================================================

MATCH
    (refresh:TOSNNode {id:'FrequentInsightRefresh'}),
    (isg:TOSNNode {id:'ISG'}),
    (tcw:TOSNNode {id:'TCW'})
MERGE (refresh)-[:ENABLES {polarity:'pro'}]->(isg)
MERGE (refresh)-[:ENABLES {polarity:'pro'}]->(tcw);


MATCH
    (isg:TOSNNode {id:'ISG'}),
    (insights:TOSNNode {id:'ObservedInsights'}),
    (kg:TOSNNode {id:'KnowledgeGraph'})
MERGE (isg)-[:PRODUCES {polarity:'pro'}]->(insights)
MERGE (insights)-[:FEEDS {polarity:'pro'}]->(kg);


MATCH
    (tcw:TOSNNode {id:'TCW'}),
    (stats:TOSNNode {id:'StatisticalLinks'}),
    (kg:TOSNNode {id:'KnowledgeGraph'})
MERGE (tcw)-[:PRODUCES {polarity:'pro'}]->(stats)
MERGE (stats)-[:FEEDS {polarity:'pro'}]->(kg);


// ============================================================================
// DISPLAY THE GRAPH
// ============================================================================

MATCH (n)-[r]->(m)
RETURN n, r, m;
