# MongoDB Tools
[MongoDB Command Line Database Tools Download](https://www.mongodb.com/try/download/database-tools)
[The MongoDB Database Tools Documentation](https://www.mongodb.com/docs/database-tools/)


## mongosh
[Welcome to MongoDB Shell (mongosh)](https://www.mongodb.com/docs/mongodb-shell/)

### Connection to a shell
```sh
mongosh "mongodb+srv://YOUR_CLUSTER_NAME.YOUR_HASH.mongodb.net/" --apiVersion YOUR_API_VERSION --username USERNAME

mongosh "mongodb://<username>:<password>@<host>:<port>/<db>?authSource=<authDB>"
mongosh "mongodb://myUser:myPass@localhost:27017/myDatabase?authSource=admin"

```
### Run js file from mongoDB shell
```sh
mongosh "mongodb://<username>:<password>@<host>:<port>/<db>?authSource=<authDB>" --file TARGET_FILENAME
```


## mongoimport
```sh
mongoimport --db DATABASE_NAME --collection COLLECTION_NAME --file TARGET_FILENAME --jsonArray
```
### Import from JSON
```sh
# Import array of JSON objects from a file to a collection
mongoimport --host HOSTNAME_OR_IP --port 27017 --username USERNAME --password PASSWORD --authenticationDatabase=admin --db DATABASE_NAME --collection COLLECTION_NAME --file TARGET_FILENAME --jsonArray
```


## mongoexport
## Export to json
```sh
# With authenticationDatabase
mongoexport --host HOSTNAME_OR_IP --port 27017 --username USERNAME --password PASSWORD --authenticationDatabase=admin --db DATABASE_NAME --collection COLLECTION_NAME --out TARGET_FILENAME --jsonArray
mongoexport --host HOSTNAME_OR_IP --port 27017 --username USERNAME --password PASSWORD --db DATABASE_NAME --collection COLLECTION_NAME --out TARGET_FILENAME --jsonArray
```


## mongodump
### Dump database sh
```sh
mongodump --host HOSTNAME_OR_IP --port 27017 --username USERNAME --password PASSWORD --authenticationDatabase=admin --db DATABASE_NAME --out TARGET_FOLDER_NAME
```
