# Mentioned on page 173 of the book, Semantic Webs of Meaning.

from sklearn.datasets import load_iris
from sklearn.cluster import KMeans
from collections import Counter
import re

# ------------------------------------------------------------
# 1. Train a simple clustering model on the Iris dataset
# ------------------------------------------------------------

model_url = "https://github.com/MapRock/knowledge_graph_book/blob/main/book_code/iris_kmeans_model.pkl"

iris = load_iris()
X = iris.data
feature_names = iris.feature_names
target_names = iris.target_names
y = iris.target

kmeans = KMeans(n_clusters=3, random_state=42, n_init=10)
cluster_ids = kmeans.fit_predict(X)

# ------------------------------------------------------------
# 2. Give each cluster a simple human-readable name
#    using the dominant known Iris species in the cluster.
#    This is still a cluster model; the species labels are used
#    only to name the learned clusters for readability.
# ------------------------------------------------------------

def safe_name(text):
    return re.sub(r"[^A-Za-z0-9]+", "", text.title())

cluster_names = {}

for cluster_id in range(3):
    members = [i for i, c in enumerate(cluster_ids) if c == cluster_id]
    dominant_species_id = Counter(y[members]).most_common(1)[0][0]
    dominant_species = target_names[dominant_species_id]
    cluster_names[cluster_id] = f"IrisCluster_{safe_name(dominant_species)}Like"

# ------------------------------------------------------------
# 3. Export the learned clusters as Turtle
# ------------------------------------------------------------

ttl_lines = []

ttl_lines.append("@prefix ex:   <https://example.org/iris/> .")
ttl_lines.append("@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .")
ttl_lines.append("@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .")
ttl_lines.append("@prefix owl:  <http://www.w3.org/2002/07/owl#> .")
ttl_lines.append("@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .")
ttl_lines.append("")

ttl_lines.append("ex:Iris")
ttl_lines.append("    a owl:Class ;")
ttl_lines.append('    rdfs:label "Iris" ;')
ttl_lines.append(f'    ex:modelFileUrl "{model_url}"^^xsd:anyURI ;')
ttl_lines.append("    rdfs:subClassOf ex:FloweringPlant .")
ttl_lines.append("")

ttl_lines.append("ex:FloweringPlant")
ttl_lines.append("    a owl:Class ;")
ttl_lines.append('    rdfs:label "Flowering plant" .')
ttl_lines.append("")

ttl_lines.append("ex:MachineLearnedCluster")
ttl_lines.append("    a owl:Class ;")
ttl_lines.append('    rdfs:label "Machine learned cluster" ;')
ttl_lines.append('    rdfs:comment "A class generated from a machine learning clustering model." .')
ttl_lines.append("")

# Properties used to describe the learned cluster
for prop, label in [
    ("modelName", "model name"),
    ("clusterId", "cluster id"),
    ("memberCount", "member count"),
    ("dominantSpecies", "dominant species"),
    ("sepalLengthCentroid", "sepal length centroid"),
    ("sepalWidthCentroid", "sepal width centroid"),
    ("petalLengthCentroid", "petal length centroid"),
    ("petalWidthCentroid", "petal width centroid"),
]:
    ttl_lines.append(f"ex:{prop}")
    ttl_lines.append("    a owl:DatatypeProperty ;")
    ttl_lines.append(f'    rdfs:label "{label}" .')
    ttl_lines.append("")

for cluster_id, centroid in enumerate(kmeans.cluster_centers_):
    class_name = cluster_names[cluster_id]
    members = [i for i, c in enumerate(cluster_ids) if c == cluster_id]
    dominant_species_id = Counter(y[members]).most_common(1)[0][0]
    dominant_species = target_names[dominant_species_id]

    ttl_lines.append(f"ex:{class_name}")
    ttl_lines.append("    a owl:Class ;")
    ttl_lines.append("    rdfs:subClassOf ex:Iris ;")
    ttl_lines.append("    rdfs:subClassOf ex:MachineLearnedCluster ;")
    ttl_lines.append(f'    rdfs:label "{class_name}" ;')
    ttl_lines.append('    ex:modelName "KMeans Iris clustering model" ;')
    ttl_lines.append(f'    ex:clusterId "{cluster_id}"^^xsd:integer ;')
    ttl_lines.append(f'    ex:memberCount "{len(members)}"^^xsd:integer ;')
    ttl_lines.append(f'    ex:dominantSpecies "{dominant_species}" ;')
    ttl_lines.append(f'    ex:sepalLengthCentroid "{centroid[0]:.3f}"^^xsd:decimal ;')
    ttl_lines.append(f'    ex:sepalWidthCentroid "{centroid[1]:.3f}"^^xsd:decimal ;')
    ttl_lines.append(f'    ex:petalLengthCentroid "{centroid[2]:.3f}"^^xsd:decimal ;')
    ttl_lines.append(f'    ex:petalWidthCentroid "{centroid[3]:.3f}"^^xsd:decimal .')
    ttl_lines.append("")

ttl = "\n".join(ttl_lines)

print(ttl)

with open("iris_clusters.ttl", "w", encoding="utf-8") as f:
    f.write(ttl)

import pickle

from pathlib import Path

output_dir = Path(__file__).parent

model_file = output_dir / "iris_kmeans_model.pkl"

with open(model_file, "wb") as f:
    pickle.dump(kmeans, f)
