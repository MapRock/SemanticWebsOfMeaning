# Appendix F – Rich Properties

<i>This appendix accompanies [***Semantic Webs of Meaning: Building Contextual Knowledge Graphs for Deduction and Integration***](https://technicspub.com/semantic-webs-of-meaning/) by Eugene Asahara, published by [Technics Publications](https://technicspub.com).</i>

## F.1 Beyond Simple Properties

Knowledge graphs are usually introduced through relatively simple properties:

```turtle
:EugenesCar
    :manufacturer :Honda ;
    :modelName "Accord" ;
    :modelYear "2024"^^xsd:gYear .
```

These properties work well for values and relationships that can be represented clearly as literals or links to other entities. However, not every important property can be adequately expressed as a string, number, class, or ordinary relationship.

A car may also have:

* an engineering schematic;
* a three-dimensional CAD model;
* a wiring diagram;
* a maintenance manual;
* a photograph;
* a diagnostic recording;
* or a simulation model.

These artifacts may contain spatial, visual, temporal, mathematical, or procedural knowledge that would be difficult—and sometimes pointless—to reproduce completely as RDF triples.

In this book, I use the term **rich property** for this pattern:

> A rich property is an external digital artifact—such as a diagram, model, document, recording, or executable object—that describes an entity more fully than ordinary RDF literals and relationships can. The artifact remains in its native format, while the knowledge graph records its identity, metadata, meaning, and links to important elements within it.

The individual mechanisms behind this idea are not new. RDF has always allowed one resource to link to another resource. Media annotation, digital twins, model registries, document management, and engineering systems all use related patterns. What is less commonly emphasized is that these different artifacts form one general category: properties whose knowledge is too rich to flatten entirely into ordinary graph statements.

These are my blogs supporting this thesis:

- [Embedding Machine Learning Models into Knowledge Graphs](https://eugeneasahara.com/2025/01/09/machine-learning-models-embedded-in-knowledge-graphs/)
- [Prolog and ML Models – Prolog’s Role in the LLM Era, Part 4](https://eugeneasahara.com/2024/08/15/prolog-and-ml-models-prologs-role-in-the-llm-era-part-4/)

## F.2 The Artifact as a First-Class Node

The simplest approach is to attach a file location directly to an entity:

```turtle
:EugenesCar
    :schematicFile <https://example.org/eugenes-car.svg> .
```

This identifies the file, but it tells us little about it. A stronger approach is to represent the schematic itself as a node:

```turtle
:EugenesCar
    :hasSchematic :EugenesCarSchematic .

:EugenesCarSchematic
    a :EngineeringSchematic ;
    :fileLocation <https://example.org/eugenes-car.svg> ;
    :version "3.1" ;
    :createdBy :EngineeringDepartment ;
    :effectiveDate "2026-05-01"^^xsd:date ;
    :depicts :EugenesCar .
```

The schematic can now have its own:

| Attribute                              | Description                                                                                                                  |
| -------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| **Identity**                           | A distinct identifier that allows the artifact itself to be addressed and related to other resources in the knowledge graph. |
| **Format**                             | The artifact’s native representation, such as SVG, PDF, CAD, image, audio, video, or another digital format.                 |
| **Author**                             | The person, team, department, organization, or system responsible for creating the artifact.                                 |
| **Version**                            | The specific revision or release of the artifact, allowing multiple versions to be distinguished.                            |
| **Creation date**                      | The date or time at which the artifact was created or became effective.                                                      |
| **Provenance**                         | Information about where the artifact came from, how it was produced, and the sources or processes behind it.                 |
| **Access rules**                       | Policies governing who or what may view, retrieve, modify, or otherwise use the artifact.                                    |
| **Lifecycle status**                   | The artifact’s current state, such as draft, approved, active, superseded, or retired.                                       |
| **Relationships to depicted entities** | Explicit links between the artifact and the entities, components, systems, or other things that it describes or depicts.     |


The rich property is therefore not merely an attachment. It becomes a governed and graph-addressable resource.

## F.3 Engineering Schematics

Some objects are best understood visually. A car schematic can identify the engine, battery, suspension, wiring, and other parts while showing where those parts are located and how they fit together.

A class hierarchy may tell us that an electric motor is a kind of vehicle component. The graph can also represent its location and connections, but a schematic may communicate the integrated physical arrangement much more effectively.


```turtle
:CarModelS
    a :VehicleModel ;
    :hasSchematic :ModelSChassisSchematic .

:ModelSChassisSchematic
    a :EngineeringSchematic ;
    :fileLocation <https://example.org/model-s-chassis.svg> ;
    :depictsPart :BatteryPack ;
    :depictsPart :FrontMotor ;
    :depictsPart :RearMotor .
```

The depicted parts may also be explicit knowledge graph entities:

```turtle
:BatteryPack
    a :VehicleComponent ;
    :partOf :CarModelS .

:FrontMotor
    a :ElectricMotor ;
    :partOf :CarModelS ;
    :poweredBy :BatteryPack .
```

The schematic preserves physical placement, geometry, and assembly context. The knowledge graph preserves identity, classification, relationships, and facts about each component.

## F.4 Anchoring Elements Within a Rich Property

The graph can link not only to the entire artifact but also to identifiable elements within it. SVG is especially useful because individual visual elements can have stable identifiers.

```turtle
:BatteryPackAnchor
    a :SchematicAnchor ;
    :belongsToSchematic :ModelSChassisSchematic ;
    :identifiesEntity :BatteryPack ;
    :svgElementID "battery-pack-01" .

:FrontMotorAnchor
    a :SchematicAnchor ;
    :belongsToSchematic :ModelSChassisSchematic ;
    :identifiesEntity :FrontMotor ;
    :svgElementID "front-motor-01" .
```

The SVG might contain:

```xml
<g id="battery-pack-01">...</g>
<g id="front-motor-01">...</g>
```

A user could select the battery pack in the drawing and retrieve:

| Attribute                             | Description                                                                                                                               |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Specifications**                    | Technical characteristics of the selected component, such as dimensions, capacity, ratings, tolerances, materials, or performance limits. |
| **Supplier**                          | The organization or vendor that manufactures, supplies, or services the component.                                                        |
| **Maintenance procedures**            | Instructions, schedules, tools, and procedures required to inspect, service, repair, or maintain the component.                           |
| **Replacement history**               | Records of previous replacements, including dates, reasons, replacement parts, and related service events.                                |
| **Failure risks**                     | Known failure modes, risk factors, warning conditions, and potential consequences associated with the component.                          |
| **Compatible parts**                  | Other components, replacements, accessories, or assemblies known to be compatible with the selected component.                            |
| **Vehicles in which it is installed** | Links to the specific vehicles, models, configurations, or assemblies in which the component is installed or supported.                   |


The schematic becomes a **visual index into the knowledge graph**.

This resembles established semantic-media annotation practices, where a graph entity is connected to a region of an image, a portion of a document, or a segment of audio or video. The broader rich-property pattern applies the same idea to many kinds of structured artifacts.

## F.5 Design Schematics and As-Built Schematics

A rich property may describe either a class of objects or a specific individual.

A generic schematic describes the intended design of a vehicle model:

```turtle
:ModelSBatteryPack
    a owl:Class ;
    rdfs:subClassOf :BatteryPack .
```

An as-built schematic can describe the actual components installed in one vehicle:

```turtle
:EugenesCar
    a :CarModelS ;
    :hasInstalledPart :BatterySN84721 ;
    :hasSchematic :EugenesCarAsBuiltSchematic .

:BatterySN84721
    a :ModelSBatteryPack ;
    :serialNumber "84721" ;
    :installedIn :EugenesCar .
```

The design schematic describes what a type of object is expected to contain. The as-built schematic describes what actually exists.

Conceptually, this resembles the distinction between a class-level description and an instantiated object.

## F.6 Multiple Views of the Same Entity

One object may have several rich properties, each offering a different view:

```turtle
:CarModelS
    :hasSchematic :ElectricalSchematic ;
    :hasSchematic :CoolingSystemSchematic ;
    :hasSchematic :ChassisAssemblyDiagram ;
    :hasSchematic :RepairPartsDiagram ;
    :hasModel :ModelS3DCADModel .
```

Each artifact answers different questions.

| Rich property        | Primary purpose                                             |
| -------------------- | ----------------------------------------------------------- |
| Electrical schematic | Wiring, circuits, connectors, and current paths             |
| Cooling schematic    | Coolant flow, pumps, radiators, and dependencies            |
| Assembly diagram     | Physical placement and part assembly                        |
| Repair-parts diagram | Replaceable components and part numbers                     |
| 3D CAD model         | Geometry, dimensions, clearances, and spatial relationships |

No single representation is necessarily the complete truth. Each is a view of the same entity created for a particular purpose.

## F.7 Structures Beyond Traditional Ontologies

Rich properties are especially useful for graphs and diagrams that are not simply taxonomies or traditional ontologies.

A taxonomy answers questions such as:

> What kind of thing is this?

An ontology can add:

> What properties and relationships may this kind of thing have?

However, many useful knowledge structures also depend on:

| Element                           | Description                                                                                                                                        |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Direction**                     | Indicates that a relationship operates from one thing toward another, such as a cause producing an effect or data flowing between systems.         |
| **Sequence**                      | Captures the order in which activities, events, or states occur.                                                                                   |
| **Placement**                     | Shows where an element is located relative to other elements within a physical or conceptual structure.                                            |
| **Geometry**                      | Preserves shapes, dimensions, orientation, and other spatial characteristics that may be difficult to express naturally as ordinary triples.       |
| **Flow**                          | Represents movement through a system, such as materials, information, energy, money, or control.                                                   |
| **Dependency**                    | Shows that one component, activity, or outcome relies on another.                                                                                  |
| **Feedback**                      | Represents situations in which an outcome influences an earlier part of the system, potentially reinforcing or counteracting its behavior.         |
| **Cardinality**                   | Expresses how many instances or connections may participate in a relationship.                                                                     |
| **Visual grouping**               | Communicates that elements belong together through their placement, enclosure, color, or other visual organization.                                |
| **Hypothesized cause and effect** | Represents a proposed causal relationship that may be important to investigate without asserting that causation has been conclusively established. |


Labels and class hierarchies alone are not enough.

| Diagram or model      | Knowledge not conveyed well by a class hierarchy alone |
| --------------------- | ------------------------------------------------------ |
| Engineering schematic | Placement, assembly, interfaces, and connectivity      |
| UML diagram           | Composition, inheritance, interfaces, and cardinality  |
| Workflow              | Sequence, branching, roles, loops, and exceptions      |
| Strategy map          | Intended influence among strategic objectives          |
| Trophic cascade       | Direct and indirect ecological effects                 |
| Network topology      | Routing, zones, redundancy, and failure paths          |
| Building plan         | Spatial layout, containment, and access                |
| Process map           | Activities, decisions, handoffs, and bottlenecks       |
| Neural network        | Layers, weights, activations, and learned behavior     |
| Simulation model      | Dynamic behavior under changing inputs                 |

These structures may themselves be graph-shaped, but they are not necessarily ontologies. A graph is a general data structure. An ontology is one particular use of a graph for defining concepts and formal relationships.

## F.8 UML Diagrams

A UML class diagram can show inheritance, composition, interfaces, associations, and cardinality. Much of this information can be translated into graph statements, but the visual diagram remains valuable because it presents the software design as an integrated whole.

```turtle
:OrderSystem
    a :SoftwareSystem ;
    :hasUMLDiagram :OrderSystemClassDiagram .

:OrderSystemClassDiagram
    a :UMLClassDiagram ;
    :fileLocation <https://example.org/order-system.svg> ;
    :depictsEntity :Order ;
    :depictsEntity :Customer ;
    :depictsEntity :OrderLine .
```

The depicted classes can link to other resources:

```turtle
:Order
    a :SoftwareClass ;
    :implementedInFile <https://example.org/src/Order.cs> ;
    :storedInTable :OrdersTable ;
    :depictedIn :OrderSystemClassDiagram .
```

The graph can answer detailed questions about `:Order`. The UML diagram shows how `:Order` fits into the broader design.

A future system might allow a user to click a UML class and move directly to:

| Related resource                 | Description                                                                                                              |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source file**                  | The source-code file or files that implement the class represented in the UML model.                                     |
| **Database table**               | The physical or logical database structures used to persist objects or data associated with the class.                   |
| **API endpoints**                | Services or operations through which the class or its associated business capability can be accessed.                    |
| **Unit tests**                   | Automated tests that verify the behavior of the class and help reveal its expected behavior.                             |
| **Documentation**                | Technical, architectural, or business documentation that explains the class and its role in the larger system.           |
| **Known defects**                | Open bugs, limitations, or other known problems associated with the implementation.                                      |
| **Responsible development team** | The team or organizational unit responsible for developing, maintaining, or supporting the class and its implementation. |


## F.9 Workflows

A workflow does more than classify activities. It shows what happens first, what follows, where decisions occur, and which paths are possible.

```turtle
:LoanApprovalProcess
    a :BusinessProcess ;
    :hasWorkflowDiagram :LoanApprovalWorkflow .

:LoanApprovalWorkflow
    a :WorkflowDiagram ;
    :depictsStep :ReceiveApplication ;
    :depictsStep :CheckCredit ;
    :depictsStep :ApproveLoan ;
    :depictsStep :ManualReview .
```

Important transitions can also be represented explicitly:

```turtle
:ReceiveApplication
    :nextStep :CheckCredit .

:CheckCredit
    :onPass :ApproveLoan ;
    :onFail :ManualReview .
```

The graph representation allows the process to be queried and reasoned over. The original workflow preserves:

| Workflow element        | Description                                                                                                  |
| ----------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Branches**            | Alternative paths that may be followed depending on conditions or decisions encountered during the process.  |
| **Loops**               | Activities or groups of activities that may repeat until a condition is satisfied.                           |
| **Decision symbols**    | Visual decision points showing where process execution can follow different paths.                           |
| **Swim lanes**          | Visual groupings showing which person, role, department, or system is responsible for particular activities. |
| **Timing expectations** | Expected durations, deadlines, waiting periods, or other temporal constraints associated with process steps. |
| **Exceptions**          | Alternate paths used when normal processing cannot continue or exceptional circumstances occur.              |
| **Overall visual path** | The integrated view of how activities, decisions, roles, and transitions fit together from beginning to end. |


The workflow may also link each step to policies, roles, systems, event types, KPIs, and historical process-mining results.

## F.10 Strategy Maps

A strategy map is not primarily a taxonomy. It represents a set of hypotheses about how one objective contributes to another.

```turtle
:CorporateStrategy
    a :Strategy ;
    :hasStrategyMap :GrowthStrategyMap .

:GrowthStrategyMap
    a :StrategyMap ;
    :includesObjective :ImproveEmployeeSkills ;
    :includesObjective :ImproveCustomerService ;
    :includesObjective :IncreaseCustomerRetention ;
    :includesObjective :IncreaseRevenue .
```

The intended chain can be represented in the graph:

```turtle
:ImproveEmployeeSkills
    :contributesTo :ImproveCustomerService .

:ImproveCustomerService
    :contributesTo :IncreaseCustomerRetention .

:IncreaseCustomerRetention
    :contributesTo :IncreaseRevenue .
```

However, the map may also communicate meaning through layout. Objectives may be grouped into perspectives such as:

| Perspective               | Description                                                                                                              |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Learning and growth**   | Capabilities such as employee skills, organizational knowledge, technology, and culture that support future performance. |
| **Operations**            | Internal processes and capabilities through which the organization produces and delivers value.                          |
| **Customers**             | Objectives concerning customer value, satisfaction, retention, acquisition, relationships, and market outcomes.          |
| **Financial performance** | Financial outcomes such as revenue, profitability, cost control, cash flow, or return on investment.                     |


The strategy map preserves the executive-level view. The graph can connect each objective to:

| Related knowledge           | Description                                                                                                                        |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **KPIs**                    | Measures used to determine whether progress toward the objective is occurring.                                                     |
| **Responsible departments** | Organizational units accountable for pursuing, influencing, or reporting on the objective.                                         |
| **Initiatives**             | Projects, programs, and actions undertaken to achieve the objective.                                                               |
| **Assumptions**             | Beliefs about conditions or relationships that must hold for the strategy to work as intended.                                     |
| **Evidence**                | Data, research, observations, or other information supporting or challenging the strategic hypothesis.                             |
| **Risks**                   | Conditions or events that could prevent the objective from being achieved or weaken its expected contribution to other objectives. |
| **Observed results**        | Actual outcomes that can be compared with the intended effects expressed by the strategy map.                                      |


The relationships in a strategy map should not automatically be treated as proven causation. They may be hypotheses that the organization intends to test. The graph can record that distinction:

```turtle
:EmployeeSkillsToCustomerService
    a :StrategicHypothesis ;
    :sourceObjective :ImproveEmployeeSkills ;
    :targetObjective :ImproveCustomerService ;
    :confidence 0.72 ;
    :supportedBy :EmployeeCustomerStudy2025 .
```
Please see my blog: [Prolog Strategy Map – Prolog in the LLM Era – Holiday Season Special](https://eugeneasahara.com/2024/11/29/prolog-strategy-map-prolog-in-the-llm-era-holiday-season-special/)

## F.11 Trophic Cascades

A trophic cascade describes how a change involving one species can indirectly affect many others.

A taxonomy can classify wolves, elk, willow trees, and beavers. It does not adequately express the dynamic sequence of effects among them.

```turtle
:YellowstoneCascade
    a :EcologicalModel ;
    :hasDiagram :YellowstoneTrophicCascadeDiagram .

:Wolf
    :preysOn :Elk .

:Elk
    :feedsOn :Willow .
```

The broader effects may also be represented:

```turtle
:WolfPopulationIncrease
    :reduces :ElkBrowsing .

:ReducedElkBrowsing
    :supports :WillowGrowth .

:WillowGrowth
    :supports :BeaverPopulation .

:BeaverPopulation
    :affects :WetlandFormation .
```

The knowledge graph makes the relationships explicit and queryable. The trophic-cascade diagram makes the chain of direct and indirect effects easier to see as a whole.

It may also distinguish positive and negative effects:

```turtle
:WolfPopulationIncrease
    :hasEffect [
        a :NegativeEffect ;
        :affects :ElkPopulation
    ] .

:ReducedElkBrowsing
    :hasEffect [
        a :PositiveEffect ;
        :affects :WillowGrowth
    ] .
```

The original diagram may communicate effect direction, strength, uncertainty, and ecological layers more effectively than a list of triples.

## F.12 Network and Infrastructure Diagrams

A network topology may show servers, routers, firewalls, data stores, security zones, and communication paths.

```turtle
:ProductionEnvironment
    a :ITEnvironment ;
    :hasTopologyDiagram :ProductionNetworkDiagram .

:WebServer01
    a :WebServer ;
    :connectsTo :ApplicationServer01 .

:ApplicationServer01
    :connectsTo :CustomerDatabase .
```

The topology diagram may additionally show:

| Topology element                        | Description                                                                                                 |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| **Internal and external network zones** | Logical or security boundaries separating systems according to trust level, purpose, or accessibility.      |
| **Load balancers**                      | Components that distribute requests or traffic among multiple servers or services.                          |
| **Redundant routes**                    | Alternate communication paths that allow traffic to continue when a primary route becomes unavailable.      |
| **Firewall boundaries**                 | Points at which network traffic is filtered or controlled according to security policies.                   |
| **Traffic direction**                   | The permitted or expected direction in which requests, responses, messages, or other network traffic flows. |
| **Cloud regions**                       | Geographic or provider-defined locations in which cloud infrastructure and services are deployed.           |
| **Failover paths**                      | Alternate systems or routes used when the normal processing path or infrastructure component fails.         |


The graph can link the depicted devices to operational knowledge:

```turtle
:ApplicationServer01
    :ownedBy :ApplicationOperations ;
    :runsSoftware :OrderService ;
    :hasPatchStatus :Current ;
    :dependsOn :CustomerDatabase ;
    :depictedIn :ProductionNetworkDiagram .
```

The rich property preserves the architectural view. The graph adds ownership, vulnerabilities, incidents, dependencies, configuration, and governance.

## F.13 Building Plans

A building plan communicates spatial knowledge that is difficult to express naturally through class hierarchies.

```turtle
:Headquarters
    a :OfficeBuilding ;
    :hasFloorPlan :FirstFloorPlan .

:FirstFloorPlan
    a :BuildingPlan ;
    :depictsRoom :ConferenceRoomA ;
    :depictsRoom :ServerRoom ;
    :depictsAsset :FireExtinguisher17 .
```

The graph may express containment:

```turtle
:ServerRoom
    :partOf :Headquarters ;
    :locatedOn :FirstFloor .

:Firewall01
    :locatedIn :ServerRoom .
```

But the original floor plan retains:

| Spatial element           | Description                                                                                                    |
| ------------------------- | -------------------------------------------------------------------------------------------------------------- |
| **Exact placement**       | The precise physical location of rooms, equipment, fixtures, and other elements within the building.           |
| **Dimensions**            | Measurements describing the size, length, width, height, or area of physical spaces and structures.            |
| **Entrances**             | Locations through which people, equipment, or materials can enter a space.                                     |
| **Exits**                 | Locations through which occupants can leave a space, including designated emergency exits.                     |
| **Adjacency**             | Information about which rooms, areas, or physical structures are next to or directly connected to one another. |
| **Wall boundaries**       | Physical boundaries that define and separate rooms, corridors, secured areas, and other spaces.                |
| **Evacuation routes**     | Planned paths for safely leaving an area or building during an emergency.                                      |
| **Physical access paths** | Routes through which people or equipment can move from one physical location to another.                       |


A region within the floor plan could be anchored to `:ServerRoom`, allowing a user to click the room and retrieve its devices, access controls, environmental sensors, and maintenance history.

## F.14 Machine-Learning Models as Rich Properties

A trained machine-learning model is another example of knowledge that cannot be usefully reduced to a handful of literals.

```turtle
:CustomerChurnProcess
    :hasPredictiveModel :ChurnModelV3 .

:ChurnModelV3
    a :MachineLearningModel ;
    :modelType :GradientBoostedTree ;
    :fileLocation <https://example.org/models/churn-v3.pkl> ;
    :trainedOn :CustomerTrainingDataset ;
    :predicts :CustomerChurnProbability ;
    :version "3.0" .
```

The graph can describe the model, but the actual learned structure remains in the serialized model or model artifact, such as a pickle, ONNX, PMML, or platform-specific file.

The model may be connected to:

| Model information          | Description                                                                                                                   |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Input features**         | Variables or attributes supplied to the model when producing a prediction or other output.                                    |
| **Output values**          | Predictions, classifications, scores, probabilities, embeddings, or other results produced by the model.                      |
| **Training data**          | The dataset or datasets used to fit the model and establish its learned behavior.                                             |
| **Evaluation metrics**     | Measures such as accuracy, precision, recall, error, or other domain-specific criteria used to evaluate model performance.    |
| **Model owner**            | The person, team, department, or organization responsible for the model and its lifecycle.                                    |
| **Deployment endpoint**    | The service, API, application, or other runtime location through which the trained model can be invoked.                      |
| **Applicable populations** | The subjects, cases, environments, or data populations for which the model was designed or validated.                         |
| **Known limitations**      | Conditions under which the model may perform poorly, should not be used, or requires additional interpretation or safeguards. |


```turtle
:ChurnModelV3
    :hasInputFeature :DaysSinceLastPurchase ;
    :hasInputFeature :SupportCallCount ;
    :hasOutput :ChurnProbability ;
    :hasAccuracy 0.87 ;
    :deployedAt <https://example.org/api/churn-v3> .
```

A decision tree might be partially converted to explicit rules. A neural network may not be usefully reducible in that manner. Retaining the original artifact allows investigators to return to the full model—the equivalent of going back to the scene of the crime.

## F.15 Audio, Video, and Signals

Audio and video contain detail that words alone cannot fully explain.

```turtle
:EngineSN4421
    :hasDiagnosticRecording :EngineRecording20260601 .

:EngineRecording20260601
    a :AudioRecording ;
    :fileLocation <https://example.org/audio/engine-4421.wav> ;
    :recordedOn "2026-06-01"^^xsd:date ;
    :indicates :PossibleBearingFailure .
```

The KG might store extracted properties such as:

```turtle
:EngineRecording20260601
    :dominantFrequency "184.2"^^xsd:decimal ;
    :hasSpectralModel :EngineRecordingFourierTransform .
```

The Fourier transform is itself another representation of the recording:

```turtle
:EngineRecordingFourierTransform
    a :FrequencyDomainRepresentation ;
    :derivedFrom :EngineRecording20260601 ;
    :fileLocation <https://example.org/signals/engine-4421-spectrum.parquet> .
```

The recording preserves the sound. The Fourier representation exposes frequency structure. The graph preserves identity, provenance, interpretation, and relationships to the equipment and diagnosis.

No one representation replaces the others.

### Neural and Other Interpreters

A rich property often requires an interpreter before some of its knowledge can become explicit in the graph. Audio, video, images, and other complex signals are increasingly interpreted by neural networks. A vision model might identify an object in an image, a speech model might extract words from audio, or an anomaly detector might recognize an unusual pattern in a machine signal. Those interpretations can then become graph statements linked back to both the source artifact and the model that produced them.

```turtle
:EngineRecording20260601
    :interpretedBy :BearingFailureDetector .


:BearingFailureDetector
    a :NeuralNetworkModel ;
    :produces :PossibleBearingFailure .


:PossibleBearingFailure
    :derivedFrom :EngineRecording20260601 ;
    :confidence 0.83 .
```

When a neural model extracts meaning from a rich artifact and that meaning is represented in a knowledge graph where it can be connected to explicit concepts, rules, and relationships, the architecture begins to take on a neuro-symbolic character. The neural component is good at recognizing patterns in signals that are difficult to describe symbolically in advance; the knowledge graph gives those detected patterns explicit identity, context, relationships, provenance, and a place for further symbolic reasoning.

The interpreter does not have to be neural. A Fourier transform interprets a signal mathematically. A parser can interpret a structured document. A simulation engine can interpret a mathematical model. Image-processing algorithms, statistical models, rules engines, and specialized domain software can each expose different aspects of a rich property. The general pattern is:

> Native artifact-->Interpreter-->Extracted representation or observation-->Knowledge graph-->Integration and reasoning

This also reinforces the central rich-property idea: the graph does not replace the artifact or the interpreter. It records the important meanings they expose and connects those meanings to the larger web of knowledge.

## F.16 Native Artifact and Graph Extraction

A rich property can be represented at several levels:

| Level             | Description                                                                        |
| ----------------- | ---------------------------------------------------------------------------------- |
| Native artifact   | The original SVG, CAD file, PDF, video, model, or recording                        |
| Artifact metadata | Format, version, creator, location, date, provenance, and access                   |
| Semantic anchors  | Links from regions or components within the artifact to KG entities                |
| Extracted graph   | Important facts translated from the artifact into explicit nodes and relationships |

For example, a workflow can remain as a BPMN file while its most important steps and transitions are also represented in RDF.

The decision is not between storing the artifact or graphing it. A useful implementation usually does both.

The artifact preserves the original representation. The graph exposes the parts needed for:

| Graph purpose    | Description                                                                                                                   |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Discovery**    | Finding the artifact and relevant elements within it based on entities, subjects, relationships, metadata, or other criteria. |
| **Integration**  | Connecting information represented in the artifact with entities and knowledge from other systems and domains.                |
| **Querying**     | Making important facts and relationships from the artifact directly searchable through graph queries.                         |
| **Governance**   | Managing ownership, provenance, versions, access, authority, and lifecycle information associated with the artifact.          |
| **Reasoning**    | Exposing selected facts and relationships in forms that inference engines and rules can use.                                  |
| **AI retrieval** | Making relevant artifact content and graph context discoverable for RAG, agents, and other AI processes.                      |



## F.17 Why Not Convert Everything to Triples?

In theory, every line, coordinate, pixel, neural-network weight, and audio sample could be represented as triples. That would not necessarily make the knowledge more useful.

A diagram often communicates through:

| Visual characteristic                 | Description                                                                                                             |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Spatial arrangement**               | The overall positioning of elements, which can reveal structure or meaning simply through where things are placed.      |
| **Proximity**                         | Closeness between elements that may imply association, interaction, similarity, or functional relationship.             |
| **Visual grouping**                   | The use of regions, boundaries, alignment, or other visual devices to indicate that elements belong together.           |
| **Direction**                         | Arrows, orientation, or layout that communicates movement, influence, dependency, or progression.                       |
| **Sequence**                          | Visual order showing how events, activities, states, or components follow one another.                                  |
| **Containment**                       | Enclosure of one element within another to show membership, physical containment, ownership, or structural composition. |
| **Shape**                             | Visual form used to distinguish different types of elements or convey domain-specific meaning.                          |
| **Scale**                             | Relative or absolute size that may communicate dimensions, magnitude, importance, or physical proportion.               |
| **Color**                             | A visual encoding that can distinguish categories, status, severity, ownership, or other characteristics.               |
| **Notation**                          | Domain-specific symbols, lines, icons, and conventions whose meanings are understood as part of the representation.     |
| **Interaction of all these elements** | Meaning that emerges from the combined visual arrangement rather than from any single feature considered independently. |


Flattening everything into triples can obscure the whole while producing an enormous quantity of low-value graph data.

The graph should generally extract what needs to be identified, linked, queried, governed, or reasoned over. The original artifact should preserve the rest.

This is a division of labor:

> The artifact preserves fidelity. The knowledge graph preserves semantic accessibility.

## F.18 Relationship to Established Practices

The idea of rich properties intersects several established areas.

| Established area             | Related practice                                                            |
| ---------------------------- | --------------------------------------------------------------------------- |
| RDF and Linked Data          | Representing artifacts as identifiable resources                            |
| Web annotation               | Linking KG entities to regions or segments of media                         |
| Digital twins                | Connecting physical assets to models, simulations, and observations         |
| Product lifecycle management | Managing engineering drawings, CAD models, and versions                     |
| Model registries             | Governing trained machine-learning models and deployments                   |
| Document management          | Linking entities to manuals, reports, and records                           |
| Process management           | Connecting business processes to BPMN and workflow artifacts                |
| Geospatial systems           | Linking entities to maps, layers, and geometry                              |
| Media knowledge graphs       | Connecting people, events, and concepts to image, audio, and video segments |

The individual practices are therefore well established.

The term **rich property**, however, is not standard knowledge-graph vocabulary with this exact meaning. In other contexts, it might be interpreted as a JSON-valued property, an RDF-star annotation, or a graph property with several internal fields.

For that reason, the term should be explicitly defined as it is used in this book.

The broader contribution is the synthesis: recognizing that an engineering schematic, UML diagram, strategy map, trophic cascade, workflow, neural network, recording, and simulation model all follow a common architectural pattern.

Each is a representation of knowledge that can be linked to the graph without pretending that all of its meaning must first be converted into an ontology.

## F.19 Conclusion

Knowledge graphs are powerful because they make identity, meaning, and relationships explicit. They should not, however, be treated as the only useful representation of knowledge.

Some knowledge is inherently visual. Some is spatial. Some is temporal, mathematical, procedural, or executable. A rich property allows that knowledge to remain in the representation best suited to it while still participating in the larger knowledge graph.

The knowledge graph does not need to reproduce every detail of a schematic, model, recording, or diagram. It needs to know:

| What the KG needs to know                                       | Description                                                                                                                                |
| --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **What the artifact is**                                        | Its identity and type—such as a schematic, CAD model, workflow, recording, trained model, or simulation.                                   |
| **What it describes**                                           | The entity, system, process, event, or other subject whose knowledge the artifact represents.                                              |
| **Where it came from**                                          | Its creator, source, provenance, production process, and other information needed to understand its origin.                                |
| **Which version is authoritative**                              | The version, approval state, effective date, or other information needed to determine which artifact should currently be trusted or used.  |
| **How its important elements connect to the rest of the graph** | Semantic anchors and relationships connecting meaningful regions, components, steps, or other internal elements to identified KG entities. |


The external artifact preserves nuance and fidelity. The knowledge graph provides identity, context, governance, integration, and reasoning.

Together, they describe more than either could describe alone.
