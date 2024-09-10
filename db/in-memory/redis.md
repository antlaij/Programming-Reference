https://redis.io/commands

# Install redis-cli
```
npm install -g redis-cli
```


## Connect to Redis Server
```
rdcli -h server -p 123456
```

## List all keys
```bash
keys *
keys batch:job-queue:76*
```

## Delete
### Delete all keys
```
flushall
```
### Delete a Key
```
del batch:job-queue:completed
del batch:job-queue:failed
del batch:job-queue:id
del batch:job-queue:limiter
del batch:job-queue:stalled-check
```

## Get the value type
### type [key]
```bash
type batch:job-queue:286
```

## Get all HASH values from a key
### HGETALL [KEY]
```bash
hgetall batch:job-queue:802
```

## Get field from HASH value of a key
### HGET key field
#### Get field "opts"
```bash
hget batch:job-queue:286 opts
```
#### Get field "name"
```bash
hget batch:job-queue:286 name
```

## Get list values from a key
### LRANGE key start stop
```bash
# Get all the values from a list
lrange batch:job-queue:110:logs 0 -1
```

## TTL - Time To Live 
### LRANGE key start stop
```bash
ttl batch:job-queue:286
```



