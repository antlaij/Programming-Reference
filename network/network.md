## Check Network port is in use

### On Windows
```batch
netstat -aon | find "3000"
```
Output:
```txt
Active Connections

  Proto  Local Address          Foreign Address        State           PID
  TCP    0.0.0.0:135            0.0.0.0:0              LISTENING       1100
  TCP    0.0.0.0:445            0.0.0.0:0              LISTENING       4
  TCP    0.0.0.0:2222           0.0.0.0:0              LISTENING       4
  TCP    0.0.0.0:3333           0.0.0.0:0              LISTENING       3756
  TCP    0.0.0.0:5040           0.0.0.0:0              LISTENING       7208
  TCP    0.0.0.0:5357           0.0.0.0:0              LISTENING       4
  TCP    0.0.0.0:5700           0.0.0.0:0              LISTENING       4
  TCP    0.0.0.0:7680           0.0.0.0:0              LISTENING       11076
  TCP    0.0.0.0:7999           0.0.0.0:0              LISTENING       4
  TCP    0.0.0.0:8088           0.0.0.0:0              LISTENING       13164
```

### On Linux
```batch
netstat -tulpn | grep LISTEN
```
Output:
```
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:139             0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:2000            0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:2001            0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:5555            0.0.0.0:*               LISTEN      -
tcp        0      0 127.0.0.1:915           0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -
tcp        0      0 127.0.0.1:5432          0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:445             0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:3262            0.0.0.0:*               LISTEN      -
tcp        0      0 127.0.0.1:512           0.0.0.0:*               LISTEN      -
tcp6       0      0 :::139                  :::*                    LISTEN      -
tcp6       0      0 :::80                   :::*                    LISTEN      -
tcp6       0      0 :::2000                 :::*                    LISTEN      -
tcp6       0      0 :::2001                 :::*                    LISTEN      -
tcp6       0      0 :::5555                 :::*                    LISTEN      -
tcp6       0      0 :::22                   :::*                    LISTEN      -
```

### Kill task
```bat
taskkill /PID 12356 /F
```

