# Network command:

## Show Wifi Profile
```batch
netsh wlan show profile
```

## Export Wifi Profile to a file
```batch
netsh wlan export profile folder=d:\ key=clear
```

## Check what port is open
### Search for "LISTENING" Only
```batch
netstat –aon | find "LISTENING"
```
### Find port 3000 only
```batch
netstat –aon | find "3000"
```
### Output:
```
Protocol Local IP               Foreign IP             State           PID
  TCP    127.0.0.1:3000         0.0.0.0:0              LISTENING       28876
  TCP    127.0.0.1:3000         127.0.0.1:57068        ESTABLISHED     28876
  TCP    127.0.0.1:57068        127.0.0.1:3000         ESTABLISHED     2976
```

## Kill Process for by PID
```batch
Taskkill /PID 28876 /F
```
