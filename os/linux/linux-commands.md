# Linux commands

## System Infomation


## System Update
```sh
sudo apt-get update
```


### Hardware
#### how to get sd card info from raspberry pi 5
To get information about the SD card on your Raspberry Pi 5, you can use a few different methods. Here are some steps you can follow:

##### Command: lsblk
```sh
# This will list all the block devices, including your SD card. Look for the device labeled mmcblk0 (or similar), which represents your SD card.
lsblk

# This will list all block devices along with their model and serial number. Look for the entry corresponding to your SD card, usually labeled mmcblk0.
lsblk -o NAME,MODEL,SERIAL
```
Output:
```txt
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
mmcblk0     179:0    0 58.9G  0 disk
├─mmcblk0p1 179:1    0  512M  0 part /boot/firmware
└─mmcblk0p2 179:2    0 58.4G  0 part /
```
Output:
```txt
NAME        MODEL SERIAL
mmcblk0           0x35654e4e
├─mmcblk0p1
└─mmcblk0p2
```

##### Command: df
This will display the disk space usage of all mounted filesystems. Look for the entry corresponding to your SD card, usually labeled /dev/mmcblk0p1 or similar.
```sh
df -h
```
Output:
```txt
Filesystem      Size  Used Avail Use% Mounted on
udev            3.8G     0  3.8G   0% /dev
tmpfs           806M  7.7M  798M   1% /run
/dev/mmcblk0p2   58G   11G   44G  20% /
tmpfs           4.0G   32K  4.0G   1% /dev/shm
tmpfs           5.0M   64K  5.0M   2% /run/lock
/dev/mmcblk0p1  510M   64M  447M  13% /boot/firmware
tmpfs           806M     0  806M   0% /run/user/1000
```

##### Command: fdisk
This will list all the partitions on your SD card along with their sizes and types.
```sh
sudo fdisk -l
```
Output:
```txt
Device         Boot   Start       End   Sectors  Size Id Type
/dev/mmcblk0p1         8192   1056767   1048576  512M  c W95 FAT32 (LBA)
/dev/mmcblk0p2      1056768 123596799 122540032 58.4G 83 Linux
```

##### Command: udevadm
This will display the serial number of your SD card.
```sh
udevadm info --query=all --name=/dev/mmcblk0
```
Output:
```txt
E: ID_SERIAL=0x35654e4e
```

##### Command: cat
```sh
# get the brand of the SD card
cat /sys/block/mmcblk0/device/name

# get the serial number of the SD card
cat /sys/block/mmcblk0/device/serial
```
Output:
```txt
USD00
0x35654e4e
```


#### Network
[Ultimate nmcli Cheat Sheet for Linux Network Management](https://www.howtouselinux.com/post/ultimate-nmcli-cheat-sheet-for-linux-network-management)

##### General Network Management

###### Command: nmcli

This command shows you the status of all network devices recognized by NetworkManager, including their type, current state, and associated connection.
```sh
# List Network Interfaces
nmcli device status
```

This command lists all configured network connection profiles, providing details like the profile name, UUID, type (e.g., Ethernet, Wi-Fi), and the associated device.
```sh
# List Connection Profiles
nmcli connection show
```

Replace <connection_name> with the actual name of the profile (e.g., ‘Wired connection 1’). This command provides a detailed view of the connection profile settings, including IP configuration, DNS, gateway, and more.
```sh
# Show Details of a Connection Profile
nmcli connection show <connection_name>
```

This command activates the specified connection profile.
```sh
# Activate a Connection
nmcli connection up <connection_name>
```

This command deactivates the specified connection profile.
```sh
# Deactivate a Connection
nmcli connection down <connection_name>
```

This is a versatile command to modify settings within a connection profile. Replace <property> with the setting you want to change (e.g., ipv4.method, ipv4.addresses, ipv6.gateway) and <value> with the new value.
```sh
# Modify a Connection Profile
nmcli connection modify <connection_name> <property> <value>
```

Use this command to remove a connection profile.
```sh
# Delete a Connection Profile
nmcli connection delete <connection_name>
```

This command renames a connection profile from <old_name> to <new_name>. Use quotes around names that contain spaces.
```sh
# Rename a Connection Profile
nmcli connection modify "<old_name>" connection.id "<new_name>"
```

###### Command: ifconfig
```sh
# Network config
ifconfig
```


### List all installed packages:
```sh
# All packages
dpkg -l

# Packages contains sql
dpkg -l | grep sql
```

### System monitor
```sh
top

ps aux
```

## IO
### Show current working folder
```sh
pwd
```

### List files from current folder
```sh
ls -la
```

### delete file or folder
```sh
rm
```

### Crate new file
```sh
touch newfile.txt
echo "hello" > hello.txt

# Set file permission
chmod 755 hello.txt
```

### view file content
```sh
cat hello.txt
```

### Search text in file
```sh
grep "hello" hello.txt
```

### 
```sh

```







