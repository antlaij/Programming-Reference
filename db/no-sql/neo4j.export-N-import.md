# Export Data
## [neo4j Export Reference](https://neo4j.com/labs/apoc/4.2/overview/apoc.export/apoc.export.cypher.query/)

## Setup Default Data
```cypher
CREATE (TheMatrix:Movie {title:'The Matrix', released:1999, tagline:'Welcome to the Real World'})
CREATE (Keanu:Person {name:'Keanu Reeves', born:1964})
CREATE (Carrie:Person {name:'Carrie-Anne Moss', born:1967})
CREATE (Laurence:Person {name:'Laurence Fishburne', born:1961})
CREATE (Hugo:Person {name:'Hugo Weaving', born:1960})
CREATE (LillyW:Person {name:'Lilly Wachowski', born:1967})
CREATE (LanaW:Person {name:'Lana Wachowski', born:1965})
CREATE (JoelS:Person {name:'Joel Silver', born:1952})
CREATE
(Keanu)-[:ACTED_IN {roles:['Neo']}]->(TheMatrix),
(Carrie)-[:ACTED_IN {roles:['Trinity']}]->(TheMatrix),
(Laurence)-[:ACTED_IN {roles:['Morpheus']}]->(TheMatrix),
(Hugo)-[:ACTED_IN {roles:['Agent Smith']}]->(TheMatrix),
(LillyW)-[:DIRECTED]->(TheMatrix),
(LanaW)-[:DIRECTED]->(TheMatrix),
(JoelS)-[:PRODUCED]->(TheMatrix);
```

## Export Nodes to cypher query by using apoc
### Export All Nodes to cypher query
```cypher
CALL apoc.export.cypher.query(
  "MATCH ()-[r]->() RETURN *",
  "databaseName.all.cypher",
  { format: "cypher-shell", separateFiles: true })
YIELD file, batches, source, format, nodes, relationships, time, rows, batchSize
RETURN file, batches, source, format, nodes, relationships, time, rows, batchSize;
```

### Export All Nodes on one relationship to cypher query
```cypher
CALL apoc.export.cypher.query(
  "MATCH ()-[r:ACTED_IN]->()
   RETURN *",
  "databaseName.actedIn.cypher",
  { format: "cypher-shell", separateFiles: true })
YIELD file, batches, source, format, nodes, relationships, time, rows, batchSize
RETURN file, batches, source, format, nodes, relationships, time, rows, batchSize;
```
```cypher
CALL apoc.export.cypher.query(
  "MATCH ()-[r:DIRECTED]->()
   RETURN *",
  "databaseName.directed.cypher",
  { format: "cypher-shell", separateFiles: true })
YIELD file, batches, source, format, nodes, relationships, time, rows, batchSize
RETURN file, batches, source, format, nodes, relationships, time, rows, batchSize;
```
```cypher
CALL apoc.export.cypher.query(
  "MATCH ()-[r:PRODUCED]->()
   RETURN *",
  "databaseName.produced.cypher",
  { format: "cypher-shell", separateFiles: true })
YIELD file, batches, source, format, nodes, relationships, time, rows, batchSize
RETURN file, batches, source, format, nodes, relationships, time, rows, batchSize;
```

## Delete all nodes from neo4j
```cypher
MATCH (n) DETACH DELETE n;
```


## Import Data from exported cypher
### Import Data from exported cypher files in one command
```cypher
call apoc.cypher.runFiles(["databaseName.all.nodes.cypher", "databaseName.all.relationships.cypher", "databaseName.all.cleanup.cypher", "databaseName.all.schema.cypher"]);
```
### Import Data from exported cypher files in multiple commands
```cypher
call apoc.cypher.runFiles(["databaseName.all.nodes.cypher"]);
call apoc.cypher.runFiles(["databaseName.all.relationships.cypher"]);
call apoc.cypher.runFiles(["databaseName.all.cleanup.cypher"]);
call apoc.cypher.runFiles(["databaseName.all.schema.cypher"]);
```


