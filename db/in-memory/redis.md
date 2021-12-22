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
keys *

## Delete Key
```
del batch:job-queue:completed
del batch:job-queue:failed
del batch:job-queue:id
del batch:job-queue:limiter
del batch:job-queue:stalled-check
```



