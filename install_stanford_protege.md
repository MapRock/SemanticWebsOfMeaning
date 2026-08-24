## Installing Protégé on Windows

Protégé is a free, open-source ontology editor used to create and maintain OWL ontologies. In the workflow used in this book, Protégé is the authoring tool: it is where we define classes, subclasses, object properties, datatype properties, individuals, labels, and ontology relationships. The resulting ontology can then be saved as Turtle and loaded into a SPARQL tool such as Apache Jena Fuseki for querying. The current Protégé Desktop Windows download is distributed as a ZIP file and includes its own 64-bit Java Runtime Environment, so a separate Java installation is not normally required for the Windows package. ([Protege Project][1])

### 1. Download Protégé Desktop

Go to the Protégé website and choose the **Protégé Desktop** download. Protégé also offers WebProtégé, which runs in the browser and supports collaborative ontology editing, but for the examples in this book, use **Protégé Desktop** so the ontology can be authored locally and saved as files such as `.ttl`, `.owl`, or `.rdf`. ([Protégé][2])

For Windows, download the file named something like:

```text
Protege-5.6.9-win.zip
```

The exact version number may change over time, but the important points are:

```text
Use the Windows ZIP download.
Do not download the source code package.
Do not download WebProtégé if you want the local desktop editor.
```

### 2. Extract the ZIP file

After the download finishes, open your Downloads folder and find the Protégé ZIP file.

Right-click the ZIP file and choose:

```text
Extract All...
```

Choose a simple destination folder, such as:

```text
C:\Tools\Protege-5.6.9
```

or:

```text
C:\Program Files\Protege-5.6.9
```

A simple path is usually easier when writing examples, taking screenshots, or troubleshooting.

### 3. Start Protégé

Open the extracted folder and look for:

```text
Protege.exe
```

Double-click `Protege.exe` to launch Protégé.

There may also be a file named:

```text
run.bat
```

That can also start Protégé, often with a console window visible. For normal use, `Protege.exe` is usually cleaner. For troubleshooting, `run.bat` can be useful because it may show startup messages. The official Windows installation instructions describe both launch options. ([Protege Project][1])

### 4. Create a desktop shortcut

For easier access, right-click:

```text
Protege.exe
```

Then choose:

```text
Send to → Desktop (create shortcut)
```

This creates a Windows desktop shortcut so you do not have to browse back to the install folder each time.

### 5. Open or create an ontology

After Protégé opens, you can either create a new ontology or open an existing Turtle/OWL file.

For a local Turtle file, use:

```text
File → Open...
```

Then select the `.ttl` file.

Protégé can load RDF/OWL ontologies and display their classes, object properties, datatype properties, individuals, annotations, and ontology structure. In this book’s workflow, Protégé is used mainly to inspect and author the ontology, while SPARQL querying is handled separately in Fuseki.

### 6. Useful tabs to enable

Protégé allows different tabs to be shown or hidden. For the examples in this book, useful tabs include:

| Tab                      | What it is useful for                                                                                                                                                                                                                                                                                       |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Entities**             | The best general starting point. It brings together classes, object properties, data properties, annotation properties, and individuals so you can navigate the main elements of the ontology from one place. Protégé describes this as the “workhorse” of the ontology editor. ([Protege Project][1])      |
| **Classes**              | Used to create and inspect the class hierarchy, including subclasses and class descriptions. This is where much of the ontology’s type structure is authored.                                                                                                                                               |
| **Object properties**    | Used to define relationships between individuals or entities, such as `worksFor`, `locatedIn`, or `hasPart`. The tab shows the object-property hierarchy and lets you inspect characteristics and logical descriptions. ([Protege Project][2])                                                              |
| **Data properties**      | Used to define properties whose values are literals, such as strings, numbers, dates, or Boolean values. Examples include `birthDate`, `employeeNumber`, or `temperature`.                                                                                                                                  |
| **Individuals by class** | Shows individuals grouped by the classes to which they belong. This is useful for inspecting instance data and confirming that individuals have been assigned to the expected classes. Protégé provides an Instances view for listing the individuals belonging to a selected class. ([Protege Project][3]) |
| **OntoGraf**             | Provides a visual graph view of ontology entities and their relationships. It is useful for exploring a portion of the ontology visually rather than only through hierarchies and property lists.                                                                                                           |
| **DL Query**             | Lets you enter OWL class expressions and ask the reasoner which classes or individuals satisfy them. It is especially useful for testing inferred relationships after a reasoner has been started.                                                                                                          |
| **Active ontology**      | Shows information about the ontology currently being edited, including its ontology IRI, version information, imports, annotations, and other ontology-level metadata.                                                                                                                                      |

[1]: https://protegeproject.github.io/protege/getting-started/?utm_source=chatgpt.com "Getting Started"
[2]: https://protegeproject.github.io/protege/views/object-property-hierarchy/?utm_source=chatgpt.com "Object Property Hierarchy"
[3]: https://protegeproject.github.io/protege/views/?utm_source=chatgpt.com "Views"


Use:

```text
Window → Tabs
```

to turn tabs on or off.

The **Entities** tab is usually the best starting point. It lets you inspect classes, properties, individuals, and annotations from one place.

### 7. Practical note about SPARQL

Protégé may include a SPARQL Query tab, but it is not always reliable as the main SPARQL environment. For this book, the cleaner workflow is:

```text
Protégé
    Author and inspect the ontology.

Apache Jena Fuseki
    Load the Turtle file and run SPARQL queries.
```

This separation avoids confusing ontology authoring with query execution. Protégé is excellent for seeing and editing the semantic structure of the graph. Fuseki is better suited for querying RDF data with SPARQL.

### 8. Quick verification

To verify Protégé is working:

1. Open Protégé.
2. Create or load a small `.ttl` file.
3. Go to the **Entities** tab.
4. Confirm that classes appear in the class hierarchy.
5. Open **OntoGraf** to view the ontology structure visually.
6. Save the ontology as Turtle if needed:

```text
File → Save as...
```

### Installing and Configuring the Pellet Reasoner

Protégé comes with **HermiT** as the default reasoner. While HermiT is good for basic OWL reasoning, it has **limited and sometimes unreliable support for SWRL rules**.

For the exercises in this book that involve SWRL rules and inference (such as inferring new class membership), we use **Pellet** instead. Pellet has significantly better support for SWRL rules and is the recommended reasoner when working with rules in Protégé.

#### Step 1: Install the Pellet Plugin

1. Open **Protégé**.
2. Go to the menu: **File → Check for plugins**.
3. In the plugin window, type **Pellet** in the search box.
4. Find the plugin named **Pellet Reasoner** (or similar) and click **Install**.
5. Once installation completes, **restart Protégé** completely.

#### Step 2: Configure Pellet as the Active Reasoner

After restarting Protégé, follow these steps:

1. Go to the menu: **Reasoner → Configure**.
2. In the configuration dialog:
   - Select **Pellet** from the list of available reasoners.
   - Check the following options:
     - **SWRL rules**
     - **Classify taxonomy**
     - **Realize instances**
3. Click **OK**.

#### Step 3: Using the Reasoner

- To start reasoning, go to **Reasoner → Start reasoner**.
- After making changes (especially after adding or editing SWRL rules), it is often necessary to **stop and restart** the reasoner for the changes to take effect.
- You can also use **Reasoner → Synchronize reasoner** in some cases.

#### Why We Use Pellet Instead of HermiT

| Reasoner   | SWRL Support     | Recommended For                  | Notes |
|------------|------------------|----------------------------------|-------|
| **HermiT** | Limited          | Basic OWL reasoning              | Default in Protégé |
| **Pellet** | Strong           | SWRL rules + OWL reasoning       | Best choice for rule-based inference |

Because some exercises in this book use **SWRL rules** to demonstrate inference, we install and use **Pellet** for more reliable results.


[1]: https://protegeproject.github.io/protege/installation/windows/?utm_source=chatgpt.com "Windows Installation"
[2]: https://protege.stanford.edu/?utm_source=chatgpt.com "Protégé"
