# Network command:
## Table of Contents
  1. [Show Wifi Profile](#Show-Wifi-Profile)
  1. [Export Wifi Profile to a file](#Export-Wifi-Profile-to-a-file)
  1. [Check what port is open](#Check-what-port-is-open)
      1. [Search for "LISTENING" Only](#Search-for-"LISTENING"-Only)
      1. [Find port 3000 only](#Find-port-3000-only)
      1. [Output:](#Output:)
  1. [Kill Process for by PID](#Kill-Process-for-by-PID)

***

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
netstat -aon | find "LISTENING"
```
### Find port 3000 only
```batch
netstat -aon | find "3000"
```
#### Output:
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

## Redirect user to different port
### Change host file and netsh (windows)
#### Use any free address in the subnet 127.0.0.0/8 (127.x.x.x).
##### Check listening ports
###### For Linux
```bash
netstat -a -n -p TCP | grep "LISTENING"
```
###### For Windows
```batch
netstat -a -n -p TCP | find "LISTENING"
```
#### Add the following entry to the host file
```txt
127.1.2.3     example.test
```
#### Redirect port from 80 to 8080 by proxy
#### Use Netsh interface portproxy commands
[Reference](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-interface-portproxy#add-v4tov4)
```batch
netsh interface portproxy add v4tov4 listenport=80 listenaddress=127.1.2.3 connectport=8080 connectaddress=127.0.0.1
```
