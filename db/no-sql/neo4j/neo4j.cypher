// Clauses
// https://neo4j.com/docs/cypher-manual/current/clauses/

// ==================================================
// |  Server setup
// ==================================================
// Using Neo4j in docker under Synology
docker run \
    --name dockertestneo4j \
    -p7474:7474 -p7687:7687 \
    -d \
    -v $HOME/neo4j/data:/data \
    -v $HOME/neo4j/logs:/logs \
    -v $HOME/neo4j/import:/var/lib/neo4j/import \
    -v $HOME/neo4j/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/test \
    neo4j:latest
// mount local import folder to /var/lib/neo4j/import under -> Docker -> Container -> Edit -> Mount Folder
// Add ENV to install APOC

// Export Database
// Backup Location for Windows: C:\Users\[yourUsername]\.Neo4jDesktop\neo4jDatabases\database-db498af1-dea2-2222-aaf3-c7b97059c3b6\installation-3.5.6\import
// Export to cypher or json
CALL apoc.export.cypher.all("export-pWalkern.cypher",{format:'pWalkern'})
CALL apoc.export.cypher.all("export-cypher-shell.cypher",{format:'cypher-shell'})
CALL apoc.export.cypher.all("export-neo4j-shell.cypher",{format:'neo4j-shell'})
CALL apoc.export.json.all("export.json",{useTypes:true})

// Import Data from json
CALL apoc.load.json('import.json')
CALL apoc.load.json('import.json') yield value return value limit;
CALL apoc.load.json('import.json') yield value as products
MERGE (t:Tablet {ID:products.id}) ON CREATE
SET t.name = products.properties.name,
  t.model = products.properties.model,
  t.price = products.properties.price,
  t.purchaseDate = products.properties.purchaseDate

// Export to json
CALL apoc.load.json("export.json") yield value
unwind value.type as q
return q

// Import data from twitter
CALL apoc.static.getAll("twitter") yield value AS twitter
CALL apoc.load.jsonParams(twitter.url + "oscon+OR+neo4j+OR+%23oscon+OR+%40neo4j",{Authorization:"Bearer "+twitter.bearer},null) yield value
UNWIND value.statuses as status
WITH status, status.user as u, status.entities as e
RETURN status.id, status.text, u.screen_name, [t IN e.hashtags | t.text] as tags, e.symbols, [m IN e.user_mentions | m.screen_name] as mentions, [u IN e.urls | u.expanded_url] as urls


// Run script file and How do I pass parameters
// Script file => C:\Users\[yourUsername]\.Neo4jDesktop\neo4jDatabases\database-db498af1-dea2-2222-aaf3-c7b97059c3b6\installation-3.5.6\import\script.cypher
call apoc.cypher.runFile("script.cypher",{}) yield row, result;
call apoc.cypher.runFile("script.cypher",{parameters: {id_p1: 123, name_p2:'my name'}}) yield row, result;


// Run multiple Statements
CALL apoc.cypher.runMany('
  MATCH (n) WHERE ID(n) = 443 detach delete n;
  MATCH (p)-[r:OWNED_BY]->(n:Person) where ID(p) = 450 set p.InventoryLocation = "\\Electronics\\Imaging\\Digital_Camara\\Carson_Digital_Microsocope" RETURN p;
  ',
  {})
YIELD row, result
RETURN row, result {.nodesCreated, .propertiesSet, .labelsAdded, .relationshipsCreated};


// List Data from URL
WITH "https://api.stackexchange.com/2.2/questions?pagesize=100&order=desc&sort=creation&tagged=neo4j&site=stackoverflow&filter=!5-i6Zw8Y)4W7vpy91PMYsKM-k9yzEsSC1_Uxlf" AS url
CALL apoc.load.json(url) YIELD value
UNWIND value.items AS item
RETURN item.title, item.owner, item.creation_date, keys(item);


// +------------------------------------------------+
// |  SETUP THE DATABASE
// +------------------------------------------------+

// Create CONSTRAINT
CREATE CONSTRAINT ON (c:Country) ASSERT c.name IS UNIQUE;


// Get the largest ID
match (n) return MAX(ID(n));


// ==================================================
// |>>>>>>>>>>>>>>>       NODE       <<<<<<<<<<<<<<<|
// ==================================================

// +-------------------------------------------------
// |  Create Node
// +-------------------------------------------------
UNWIND [
  {start: {}, end: {}, properties:{}},
  {start: {}, end: {}, properties:{}},
  {start: {}, end: {}, properties:{}},
  {start: {}, end: {}, properties:{}},
  {start: {}, end: {}, properties:{}}
] as row
MATCH (start:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row.start._id})
MATCH (end:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row.end._id})
CREATE (start)-[r:STORED_IN]->(end) SET r += row.properties;


// +-------------------------------------------------
// |  Delete Node
// +-------------------------------------------------

// Delete all node and relationship
MATCH (n) DETACH DELETE n;

// Delete node by ID
MATCH (n) WHERE ID(n) = 1661 delete n;

// Delete node by ID and all relationships
MATCH (n) WHERE ID(n) = 1688 detach delete n

// Delete all nodes from label testing by IDs and all relationships
match (n:testing) detach delete n

// Delete all nodes from label testing by IDs and all relationships
MATCH (n) WHERE ID(u) IN [1, 2, 3] RETURN n


// ==================================================
// |>>>>>>>>>>>>>>>   RELATIONSHIP   <<<<<<<<<<<<<<<|
// ==================================================

// +-------------------------------------------------
// |  CREATE Relationship
// +-------------------------------------------------

// Add Relationship RELATIONSHIP_NAME value: 'testing'
match (n1:Label1),(n2:Label2)
where not (n1)-[:RELATIONSHIP_NAME]->() AND n2.name = "testing"
CREATE (n1)-[re:RELATIONSHIP_NAME]->(n2)
return n1;

// Add Relationship RELATIONSHIP_NAME to ID in an Array of Node Name testing
match (n1:Label1),(n2:Label2)
WHERE ID(n1) in [390,1593,1604,1641,1598,419] AND n2.name = "testing"
CREATE (n1)-[re:RELATIONSHIP_NAME]->(n2)
return n1;

// Add Relationship STORED_IN to Name of the Room
MATCH (t),(r:Room)
WHERE ID(t) = 462 AND r.name = 'Name of the Room'
CREATE (t)-[re:STORED_IN]->(r)
RETURN type(re);


// Add Relationship from existing data CATEGORIZED_AS 'PROGRAMMING LANGUAGES'
MATCH (b:Book), (g:`ABC DEF`)
WHERE g.name = 'PROGRAMMING LANGUAGES'
WITH b, g as genre
WITH COLLECT(b) AS books, genre
UNWIND books as bk
CREATE (bk)-[re:CATEGORIZED_AS]->(genre)
RETURN ID(bk) as id, bk.name, genre;


// Add Relationship STORED_IN to Master Bedroom
MATCH (t),(r:Room)
WHERE ID(t) = 384 AND r.name = 'Master Bedroom'
CREATE (t)-[re:STORED_IN]->(r)
RETURN type(re);


// +-------------------------------------------------
// |  Delete Relationship
// +-------------------------------------------------

// Delete relationship with name:RELATIONSHIP_NAME by node ID
MATCH (n)-[r:RELATIONSHIP_NAME]->() WHERE ID(n) = 29 DELETE r RETURN n

// Delete Relations with name: RELATIONSHIP_NAME by property value 'PROGRAMMING LANGUAGES'
MATCH (n)-[r:RELATIONSHIP_NAME]->(b) where b.name = 'PROGRAMMING LANGUAGES'
DELETE r
RETURN b;




// ===================================================
// |>>>>>>>>>>>>>>>       LABEL       <<<<<<<<<<<<<<<|
// ===================================================

// +-------------------------------------------------
// |  Label Search
// +-------------------------------------------------

// All labels
MATCH (n) RETURN distinct labels(n) as l order by l;
MATCH (n) WITH DISTINCT labels(n) AS labels UNWIND labels AS label RETURN DISTINCT label ORDER BY label;
MATCH (n) where not (n:Person) and not (n:Room) and not (n:Family) and not (n:Brand) and not (n:`Books Genre`) RETURN distinct labels(n)
MATCH (n:Product) RETURN distinct labels(n) as l order by l

// +-------------------------------------------------
// |  ADD Label
// +-------------------------------------------------

// replace label by Node ID
MATCH (n) where ID(n) = 1727
SET n:NEW_LABEL
RETURN n.name, labels(n) AS labels

// +-------------------------------------------------
// |  UPDATE Label
// +-------------------------------------------------

// replace label by Node ID
MATCH (n) where ID(n) = 1727
REMOVE n:OLD_LABEL
SET n:NEW_LABEL

// +-------------------------------------------------
// |  Remove multiple labels from a node
// +-------------------------------------------------
MATCH (n {title: 'search title here'})
REMOVE n:RemovedLabel1:RemovedLabel2
RETURN n, labels(n)


// ==================================================
// |>>>>>>>>>>>>>>>    QUERY DATA    <<<<<<<<<<<<<<<|
// ==================================================

// +-------------------------------------------------
// |  Global Search
// +-------------------------------------------------

// Search all properties in all nodes by RegEx and size() > 0 where properties contains 'SearchTerms'
match (n)
with n, [x in keys(n) WHERE n[x] =~ '(?i).*SearchTerms.*'] as doesMatch
where size(doesMatch) > 0
return n
order by n.name;

// Search a product owened by a Person
MATCH (p)-[r:OWNED_BY]->(n:Person)
where
  NOT EXISTS(p.OtherLabel)
  and (
    p.name =~'(?i).*X10.*'
    or p.name =~'(?i).*All Boxes.*'
    or p.name =~'(?i).*P750.*'
    or p.name =~'(?i).*2210.*'
    or p.name =~'(?i).*610.*')
RETURN p;

// Search all properties in all nodes by text
match (n)  with n, [x in keys(n) WHERE "text" in n[x]] as doesMatch where size(doesMatch) > 0 return n

// Get relationship by relationship ID
MATCH ()-[r]->()
WHERE id(r)= 0
RETURN r;


// All Non Product nodes
MATCH (n) WHERE NOT n:Product and not (n:Room) and not (n:Family) and not (n:Brand) and not (n:Person) and not (n:`Books Genre`) RETURN n;

// All Non-Product with labels nodes
MATCH (n) WHERE NOT n:Product RETURN labels(n), n;

// Product Owned by Someone and Stored in somewhere
MATCH x=(c)-[s:STORED_ID]<-(p:Product)-[ob:OWNED_BY]->(per:Person) RETURN x order by p.name

// Anything Owned by Someone
MATCH p=()-[r:OWNED_BY]->(n:Person) RETURN p
// Anything Owned by a Person or a Family
MATCH p=()-[r:OWNED_BY]->(n) where n:Person or n:Family RETURN p
// Anything Owned by a Person or a Family - Using UNION
MATCH p=()-[r:OWNED_BY]->(n:Person) RETURN p union MATCH p=()-[r:OWNED_BY]->(n:Family) RETURN p

// Anything Owned by a Person with name
MATCH p=()-[r:OWNED_BY]->(n:Person) where n.name = 'Rich Man' RETURN p

// Get all TYPE_OF Relationship
MATCH p=()-[r:TYPE_OF]->() RETURN p

// Get all TYPE_OF Computers
MATCH p=()-[r:TYPE_OF]->(:Computers) RETURN p

// Get Node and relationship by ID
match(node)-[re]-(to) where id(node) = 326 return node, re, to

// Get Tablet with name like 'Dell Computer'
match(a:Tablet)-[r]-(b) where a.name contains 'Dell Computer' return a, r, b

// get all Inventories with Label:Product
MATCH (n:Product) RETURN n order by n.name
MATCH (n) WHERE (n:Tablet OR n:MobilePhone OR n:DigitalCamara OR n:Printer OR n:Headphone OR n:Car OR n:TV OR n:DockingStation OR n:Charger OR n:Watch OR n:Mouse OR n:Book OR n:Computer OR n:Iron OR n:Battery OR n:MicroSD_Card OR n:USB_FlashDrives OR n:Multimeter) RETURN n

// get all Product node with property PropertyName
MATCH (P:Product) WHERE EXISTS(P.PropertyName) RETURN P

// get all node without PropertyName
MATCH (P:Product) WHERE NOT EXISTS(P.PropertyName) RETURN P

// get all node without PropertyName with relationship
MATCH (p:Product)-[r:OWNED_BY]->(n:Person) where NOT EXISTS(p.PropertyName) RETURN p
MATCH (P) WHERE NOT EXISTS(P.PropertyName) and NOT P:Person AND NOT P:Room and not P:Brand and not P:`Books Genre` RETURN P

// get all node without imageUrl
MATCH (P:Product) WHERE NOT EXISTS(P.imageUrl) RETURN P


// Find Node is not OWNED_BY anyone and not a Room and not a Person and not a Computer
match (n)
where not (n)-[:OWNED_BY]->() and not (n:Room) and not (n:Person) and not (n:Computers)
return n;

// Find All Inventory not owned by anyone
MATCH (n) WHERE not (n)-[:OWNED_BY]->() and (n:Tablet OR n:MobilePhone OR n:DigitalCamara OR n:Printer OR n:Headphone OR n:Car OR n:TV OR n:DockingStation OR n:Charger OR n:Watch OR n:Mouse OR n:Book OR n:Computer OR n:Iron OR n:Battery OR n:MicroSD_Card OR n:USB_FlashDrives OR n:Multimeter) RETURN n


// Find all DigitalCamara with name start with 'Song' does not MANUFACTURED_BY any company
match (n:DigitalCamara)
where n.name STARTS WITH 'Sony' and not (n)-[:MANUFACTURED_BY]->()
return n;


// Find a Product not STORED_IN anywhere
match (n:Product)
where not (n)-[:STORED_IN]->()
return n;

// Find node without any relationship
MATCH (n) WHERE NOT (n)--() RETURN n
MATCH (n) WHERE size (  (n)-[]-() ) = 0 RETURN n;

// Nodes without labels:
MATCH (n) WHERE size(labels(n)) = 0 RETURN n

// Nodes  nodes without labels and without properties:
MATCH (n) WHERE size(labels(n)) = 0 AND properties(n) = {} RETURN n

// Find product node without any relationship
MATCH (n) WHERE NOT (n)--() and NOT n:Person AND NOT n:Room and not n:Brand and not n:`Books Genre` RETURN n

// Find a Person and Family with number of owned Products
MATCH (p:Person)<-[:OWNED_BY]-(prod:Product) return p.name, count(*) as numberOfOwnedProducts order by numberOfOwnedProducts desc
union
MATCH (p:Family)<-[:OWNED_BY]-(prod:Product) return p.name, count(*) as numberOfOwnedProducts order by numberOfOwnedProducts desc

// Find duplicate Name
match (p:Product)
with p.name as name, collect(p) as products, size(collect(p)) as numberOfNodes
where size(products) > 1
return name, numberOfNodes


// Find string in multiple properties
MATCH (p:Product)
WHERE ANY(propertyName IN ['name', 'model'] WHERE toString(p[propertyName]) =~ '(?i).*950.*')
RETURN p


// Count all label
CALL db.labels() YIELD label
CALL apoc.cypher.run('MATCH (:`'+label+'`) RETURN count(*) as count',{}) YIELD value
RETURN label, value.count


// Count all relationship
CALL db.relationshipTypes() YIELD relationshipType as type
CALL apoc.cypher.run('MATCH ()-[:`'+type+'`]->() RETURN count(*) as count',{}) YIELD value
RETURN type, value.count


// ==================================================
// |>>>>>>>>>>   Aggregating functions   <<<<<<<<<<<|
// ==================================================
// +------------------------------------------------+
// |  count()
// +------------------------------------------------+
// Number of restaurant serving this Food
MATCH (r:Restaurant)-[s:SERVE]->(f:Food) with f,count(r) as NumOfRestaurantServing return * order by NumOfRestaurantServing desc;


// Create Data

// Create a new node
CREATE (n:Headphone { name: 'Name of the Node', type: 'Wireless', price: 79.99 })

// Create OWNED_BY Relationship
MATCH (a:Person),(b:Headphone) where a.name = 'Peter Walker' create (b)-[r:OWNED_BY]->(a) return type(r)
MATCH (a:Person),(b:Headphone) where a.name = 'Peter Walker' and b.name = 'Name of the Node' create (b)-[r:OWNED_BY]->(a) return type(r)

// Create a new node and relation
CREATE (n:DockingStation { name: 'USB 3.0 & USB-C Dual Video 1K-2K Travel Docking Station'})
// Set properties
match (n:DockingStation) set n.price = 149.99 return n
MATCH (a:Person),(b:DockingStation) where a.name = 'Peter Walker' and b.name = 'USB 3.0 & USB-C Dual Video 1K-2K Travel Docking Station' create (b)-[r:OWNED_BY]->(a) return type(r)

MATCH (me:Person), (mWalker:Person), (lWalker:Person) where me.name = "Peter Walker" and mWalker.name = "Mary Walker" and lWalker.name = "Little Walker"
CREATE
(bm323:Car { name: "BMW 523i sedan", year: 2000 }),
(integra:Car { name: "Acura Integra", year: 2000 }),
(jetta:Car { name: "Volkswagen Jetta", year: 2004 }),
(tl:Car { name: "Acura TL", year: 2008 }),
(golf:Car { name: "Volkswagen Golf", year: 2012 }),
(glk:Car { name: "Mercedes-Benz GLK 250", year: 2010 }),
(bm528:Car { name: "BMW 528i", year: 2016 }),
(integra)-[:OWNED_BY]->(me),
(jetta)-[:OWNED_BY]->(me),
(tl)-[:OWNED_BY]->(me),
(golf)-[:OWNED_BY]->(me),
(glk)-[:OWNED_BY]->(mWalker),
(bm528)-[:OWNED_BY]->(mWalker),
(bm323)-[:OWNED_BY]->(mWalker)

// Add relationship from 323 to Mary Walker
MATCH (mWalker:Person {name: "Mary Walker"}), (bm323:Car {name: "BMW 323i sedan"})
CREATE (bm323)-[:OWNED_BY]->(mWalker)

// Create Headphone for me
MATCH (me:Person {name: "Peter Walker"}), (mWalker:Person {name: "Mary Walker"}), (lWalker:Person {name: "Little Walker"}),
(studyroom:Room {name:'Study Room'}), (masterroom:Room {name: "Master Bedroom"}),
(samsung:Brand {name: "Samsung"}), (sony:Brand {name: "Sony"})
CREATE
(item:Family { name: "Walker\'s Family" }),
(me)-[:MEMBER_OF]->(item),
(mWalker)-[:MEMBER_OF]->(item),
(lWalker)-[:MEMBER_OF]->(item)


// Create Node for Peter Walker
MATCH
(me:Person {name: "Peter Walker"}), (mWalker:Person {name: "Mary Walker"}), (lWalker:Person {name: "Little Walker"}),(family:Family),
(livingroom:Room {name: "Living Room"}), (studyroom:Room {name: "Study Room"}), (frontDoor:Room {name: "Front Door"}), (masterroom:Room {name: "Master Bedroom"}),
(apple:Brand {name: "Apple"}), (logitech:Brand {name: "Logitech"}), (huawei:Brand {name: "Huawei"}), (microsoft:Brand {name: "Microsoft"}), (uniden:Brand {name: "Uniden"}), (dell:Brand {name: "Dell"}), (rowenta:Brand {name: "Rowenta"}), (btmeter:Brand {name: "BTMETER"}), (powobest:Brand {name: "Powobest"}), (sanDisk:Brand {name: "SanDisk"}), (Samsung:Brand {name: "Samsung"})
where family.name contains "Walker"
CREATE
(product:MicroSD_Card { name: "Select 256GB", price: 54.99, purchaseDate: date('2020-02-07'), model: "SDXC UHS-I U3", url: "https://www.amazon.ca/gp/product/B072HRDM55/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1" }),
(product)-[:OWNED_BY]->(me),
(product)-[:MANUFACTURED_BY]->(Samsung),
(product)-[:STORED_IN]->(studyroom)




// Create Headphone for Mary Walker
MATCH
(me:Person {name: "Peter Walker"}), (mWalker:Person {name: "Mary Walker"}), (lWalker:Person {name: "Little Walker"}),(family:Family),
(livingroom:Room {name: "Living Room"}), (studyroom:Room {name: "Study Room"}),
(sony:Brand {name: "Sony"})
where family.name contains "Walker"
CREATE
(product:MobilePhone { name: "Sony Ericsson", purchaseDate: date('2009-12-27'), model: "A810" }),
(product)-[:OWNED_BY]->(mWalker),
(product)-[:MANUFACTURED_BY]->(sony),
(product)-[:STORED_IN]->(studyroom)




// Create new Product
MATCH
(me:Person {name: "Peter Walker"}), (mWalker:Person {name: "Mary Walker"}), (lWalker:Person {name: "Little Walker"}),(family:Family {name: "Walker's Family"}),
(livingroom:Room {name: "Living Room"}), (studyroom:Room {name: "Study Room"}), (playroom:Room {name: "Play Room"})
MERGE (b:Brand {name: "Sanwa"})
CREATE
(product:Product:Mouse {
  name: "SANWA Wired Ergonomic Trackball Mouse",
  model: "MA-TB44BKN",
  price: 49.99,
  purchaseDate: date('2021-01-17'),
  InventoryLocation: "\\mouse\\SANWA_Wired_Ergonomic_Trackball_Mouse",
  imageUrl: "/mouse/SANWA_Wired_Ergonomic_Trackball_Mouse/Photo/71LSLmvY0RL._AC_SL1280_.jpg",
  url: "https://www.sanwa.co.jp/product/syohin.asp?code=MA-TB44BKN",
  isPhotoMapComplete: false
}),
(product)-[:OWNED_BY]->(me),
(product)-[:MANUFACTURED_BY]->(b),
(product)-[:STORED_IN]->(studyroom)
return product




// Create Watch
UNWIND [
  {_id:156, properties:{purchaseDate:date('2000-05-13'), price:249.99, name:"Fitbit Versa", model:"MFC-123456"}},
  {_id:179, properties:{purchaseDate:date('2019-05-13'), price:299.99, name:"HUAWEI WATCH GT", model:"GT"}}
] as row
CREATE (n:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row._id}) SET n += row.properties SET n:Watch;


// Create Books
UNWIND [
  {properties:{name:"Beginning E-Commerce with Visual Basic, ASP, SQL Server 7.0 and MTS", imageUrl:"/Ecommerce.gif"}},
  {properties:{name:"ASP Components", imageUrl:"/inventory/ASP_Com.gif"}}
] as row
CREATE (n) SET n += row.properties SET n:Book;

// Create BOOKS Genre
UNWIND [
  {properties:{name:"PROGRAMMING LANGUAGES"}}
] as row
CREATE (n) SET n += row.properties SET n:`Books Genre`;





// Create Relationship OWNED_BY by Label
MATCH (me:Person {name: "Peter Walker"}), (mWalker:Person {name: "Mary Walker"}), (lWalker:Person {name: "Little Walker"}), (f:Family),
(tv:TV)
where f.name contains "Walker"
CREATE
(tv)-[:OWNED_BY]->(f)

// Create Relationship STORED_IN by ID
MATCH (product:MobilePhone), (studyroom:Room {name:'Study Room'}) where ID(product) = 44
CREATE
(product)-[:STORED_IN]->(studyroom)

// Create Relationship STORED_IN
MATCH (f828:DigitalCamara { name: "Sony Cybershot DSC-F828" }), (studyroom:Room {name:'Study Room'})
CREATE
(f828)-[:STORED_IN]->(studyroom)

// Create Relationship STORED_IN By ID 
match (n), (r:Room {name:'Study Room'})
where ID(n) = 157
CREATE (n)-[:STORED_IN]->(r)
return n;

// Create Relationship MANUFACTURED_BY
MATCH
(product:Watch { name: "Fitbit Versa" }),
(brand:Brand {name: "Fitbit"})
CREATE (product)-[:MANUFACTURED_BY]->(brand)

match (n:MobilePhone), (b:Brand {name: "Apple"})
where n.name CONTAINS 'iphone' and not (n)-[:MANUFACTURED_BY]->()
CREATE (n)-[:MANUFACTURED_BY]->(b)
return n;

// Create Relationship MANUFACTURED_BY By ID 
match (n), (b:Brand {name: "Western Digital"})
where ID(n) = 1727
CREATE (n)-[:MANUFACTURED_BY]->(b)
return n;

match (n), (b:Brand {name: "Microsoft"})
where ID(n) = 1
CREATE (n)-[:MANUFACTURED_BY]->(b)
return n;

match (tv:TV), (digitalcamera:DigitalCamara), (sony:Brand {name: "Sony"}), (samsung:Brand {name: "Samsung"})
where tv.name CONTAINS '4500' and not (tv)-[:MANUFACTURED_BY]->()
return tv;
CREATE (tv)-[:MANUFACTURED_BY]->(samsung)


// List all Brand
MATCH (n:Brand) RETURN n ORDER BY n.name

// Create New Brand
CREATE
(WesternDigital:Brand {name: "Western Digital"}),
(SanDisk:Brand {name: "SanDisk"}),
(microsoft:Brand {name: "Microsoft"}),
(logitech:Brand {name: "Logitech"}),
(netgear:Brand {name: "NETGEAR"}),


// List all Room
MATCH (n:Room) RETURN n ORDER BY n.name

// Create New Room
CREATE (frontDoor:Room {name: "Play Room"})


// Update data by property
match (p:Headphone { name: "Headphones with Mic - Black"})
set p.purchaseDate = date('2018-12-15')
return p

// Update name by ID
match (p) WHERE ID(p) = 454
set p.InventoryLocation = "\\Catagory\\ProductName",
  p.model = 'Product Model number',
  p.price = 399.99,
  p.purchaseDate = date('2017-12-25')
return p


// Update model by ID
match (p) WHERE ID(p) = 85
set p.name = "Alpha 6000"
return p

// Update imageUrl by ID
match (p) WHERE ID(p) = 454 set p.imageUrl = "/Photo/image1001.png" return p;

// Update imageUrl by ID
match (p) WHERE ID(p) = 1 set p.isPhotoMapCompleted = true return p

// update property by ID
MATCH (p:Product) where ID(p) = 154 set p.InventoryLocation = '\\ABC12345' RETURN p
MATCH (p)-[r:OWNED_BY]->(n:Person) where ID(p) = 154 set p.InventoryLocation = '\\ABC12345' RETURN p
MATCH (p:Product) where ID(p) = 1689 set p.name = "Router with 16 Gigabit Ethernet", p.model ="ABC12345" RETURN p

// Add label by Node ID
MATCH (n) where ID(n) in [1689,1706,1670,1668]
SET n:Product

// update property by replace
MATCH (n:Book) where exists(n.imageUrl) RETURN replace(n.imageUrl, "/", "/Programming/Collections/Photo/") order by n.name

// update property from other node value
MATCH (p:Product) WHERE EXISTS(p.myprop) and p.myprop = []
set p.myprop = [p.otherprop]
return p;

// update array property - add
MATCH (p:Product) WHERE ID(p) = 1
SET p.myArrayProp = coalesce(p.myArrayProp, []) + ['a', 'b', 'c']
return p;


// Add Property
match (p:Product) set p.isPhotoMapCompleted = false return p

// Remove Property
match (n:Product) remove n.isPhotoMapComplete return n






