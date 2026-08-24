## Installing Apache Jena Fuseki on Windows

Apache Jena Fuseki is a local SPARQL server. It lets you load RDF/Turtle files into a dataset and query them through a browser-based SPARQL interface. For this book, Fuseki is useful because it allows us to query our own RDF data instead of relying only on public examples such as Wikidata.

Fuseki is part of Apache Jena. The Jena project provides two similarly named downloads, which can be confusing. The general **Apache Jena** download contains libraries, command-line tools, and the ARQ SPARQL engine. The **Apache Jena Fuseki** download is the SPARQL server and web UI. For this walkthrough, use the Fuseki download. Apache describes Fuseki as a SPARQL server that provides SPARQL query/update protocols and a UI for administration and monitoring. ([Apache Jena][1])

### 1. Install Java First

Fuseki is a Java application. If Java is not installed, Fuseki will not start.

Open PowerShell and run:

```powershell
java -version
```

If Java is installed, you should see a version message such as:

```text
openjdk 21...
```

or later.

If PowerShell says:

```text
java : The term 'java' is not recognized...
```

then Java is missing or not on the Windows PATH.

Apache Jena 6 requires Java 21 or later, so install a recent Java Development Kit before running Fuseki. ([Apache Jena][2])

A simple Windows choice is the Microsoft OpenJDK installer. Download and install the Windows x64 MSI for OpenJDK 21 or later. After installation, close all PowerShell windows and open a new one. Then run:

```powershell
java -version
```

Do not continue until this works.

### 2. Download the Correct Fuseki File

Go to the Apache Jena download page and look for the Fuseki binary distribution. The file name should look like this:

```text
apache-jena-fuseki-6.x.x.zip
```
<b>At the time of writing, the current version is 6.1.0.</b>

Do not download the source release. Do not download the general Jena package unless you specifically want the command-line tools. The Fuseki package is the one containing the server and UI. Apache’s Fuseki documentation describes this as the `apache-jena-fuseki-*VER*.zip` package. ([Apache Jena][1])

Extract the ZIP so that the folder contained inside the ZIP is placed directly under:
```text
C:\temp
```
For version 6.1.0, the result should be:
```text
C:\temp\apache-jena-fuseki-6.1.0
```
and files such as these should be directly inside that folder:
```text
C:\temp\apache-jena-fuseki-6.1.0\fuseki-server.bat
C:\temp\apache-jena-fuseki-6.1.0\fuseki-server.jar
```
**Do not** end up with an extra nested directory such as:
```text
C:\temp\apache-jena-fuseki-6.1.0\apache-jena-fuseki-6.1.0\fuseki-server.bat
```
The tutorials assume the simpler directory structure:
```text
C:\temp\apache-jena-fuseki-6.1.0
```
Avoid deeply nested paths and folders with unusual characters.

### 3. Start Fuseki

Open PowerShell and change into the Fuseki folder:

```powershell
cd C:\temp\apache-jena-fuseki-6.1.0
```

Now check what files are present:

```powershell
dir
```

Depending on the exact distribution, you may start Fuseki with a batch file or directly from the server jar.

First try:

```powershell
.\fuseki-server.bat --mem /kg
```

If that fails with:

```text
.\fuseki-server.bat : The term '.\fuseki-server.bat' is not recognized...
```

then the batch file is not in that folder. Find the Fuseki server file:

```powershell
Get-ChildItem -Recurse -Filter "fuseki-server*" | Select-Object FullName
```

If you see a file such as:

```text
fuseki-server.jar
```

then run it directly:

```powershell
java -jar .\fuseki-server.jar --mem /kg
```

The `--mem /kg` option creates an in-memory dataset named `/kg`. This is good for examples, screenshots, and temporary experiments. It does not persist data after the server is stopped.

### 4. Open the Fuseki UI

Once the server starts, open a browser and go to:

```text
http://localhost:3030
```

You should see the Apache Jena Fuseki interface.

Click the dataset named:

```text
/kg
```

Then open the **query** tab.

Fuseki will show a SPARQL query editor. A simple first query is:

```sparql
SELECT ?s ?p ?o
WHERE {
  ?s ?p ?o .
}
LIMIT 10
```

If the dataset is empty, this may return no rows. That is not an error.

### 5. Add a Turtle File

Click **add data** for the `/kg` dataset.

Upload a Turtle file such as:

```text
programmer.ttl
```

After uploading, return to the **query** tab and run:

```sparql
PREFIX : <http://example.org/kg/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?s ?p ?o
WHERE {
  ?s ?p ?o .
}
LIMIT 50
```

This should show triples from your Turtle file.

### 6. Example Query

For the programmer example used in this book, a more meaningful query is:

```sparql
PREFIX : <http://example.org/kg/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT
    ?programmer
    ?programmerName
    (COUNT(DISTINCT ?language) AS ?languageCount)
    (GROUP_CONCAT(DISTINCT ?languageLabel; separator=", ") AS ?languages)
    (GROUP_CONCAT(DISTINCT ?expertiseLabel; separator=", ") AS ?expertiseAreas)
WHERE {
    ?programmer
        a :Programmer ;
        rdfs:label ?programmerName ;
        :knowsLanguage ?language ;
        :hasExpertise ?expertise .

    ?language rdfs:label ?languageLabel .
    ?expertise rdfs:label ?expertiseLabel .
}
GROUP BY ?programmer ?programmerName
HAVING (COUNT(DISTINCT ?language) >= 1)
ORDER BY DESC(?languageCount)
```

This query finds programmers, counts the programming languages they know, and concatenates their languages and expertise areas into readable lists.

### Troubleshooting Notes

The most common installation problems are not SPARQL problems. They are Windows setup problems.

| Symptom                                        | Likely cause                                                                        | Fix                                                                                                                                |
| ---------------------------------------------- | ----------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `java : The term 'java' is not recognized`     | Java is not installed or not on PATH.                                               | Install OpenJDK 21 or later, close PowerShell, open a new PowerShell, and run `java -version`.                                     |
| `winget : The term 'winget' is not recognized` | Windows App Installer / winget is not available.                                    | Do not use winget. Download and run the Java MSI installer manually.                                                               |
| `.\fuseki-server.bat is not recognized`        | The batch file is not in the current folder or the distribution uses a jar instead. | Run `dir`, then `Get-ChildItem -Recurse -Filter "fuseki-server*"`. If a jar exists, run `java -jar .\fuseki-server.jar --mem /kg`. |
| Browser cannot open `localhost:3030`           | Fuseki is not running or started on another port.                                   | Check the PowerShell window where Fuseki is running. It must remain open.                                                          |
| Query returns no rows                          | Dataset is empty or the Turtle file was not uploaded.                               | Upload data through **add data**, then run `SELECT ?s ?p ?o WHERE { ?s ?p ?o } LIMIT 50`.                                          |
| Query returns no matches for your terms        | Prefix mismatch.                                                                    | Make sure the SPARQL prefix exactly matches the Turtle prefix, including `/` versus `#`.                                           |

### Practical Lesson

For book examples, Fuseki is useful because it separates two jobs:

```text
Protégé
    Edit and inspect the ontology.

Fuseki
    Load RDF/Turtle data and run SPARQL queries.
```

This is a realistic workflow. Protégé is primarily an ontology editor. Fuseki is a SPARQL server. Using both tools makes the process clearer: define the graph in Turtle or Protégé, load it into Fuseki, and query it with SPARQL.

[1]: https://jena.apache.org/documentation/fuseki2 "Apache Jena - Apache Jena Fuseki"
[2]: https://jena.apache.org/download/index.cgi "Apache Jena - Apache Jena Releases"
