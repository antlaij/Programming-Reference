# Linux commands
## Table of Contents
  1. [System Infomation](#System-Infomation)
      1. [Hardware](#Hardware)
          1. [Storage](#Storage)
              1. [Command: lsblk](#Command:-lsblk)
              1. [Command: df](#Command:-df)
              1. [Command: fdisk](#Command:-fdisk)
              1. [Command: udevadm](#Command:-udevadm)
              1. [Command: cat](#Command:-cat)
          1. [Network](#Network)
              1. [General Network Management](#General-Network-Management)
                  1. [Command: nmcli](#Command:-nmcli)
                  1. [Command: ifconfig](#Command:-ifconfig)
                  1. [Command: hostname](#Command:-hostname)
          1. [Camera](#Camera)
              1. [command: v4l2-ctl](#command:-v4l2-ctl)
      1. [Software](#Software)
          1. [System Update](#System-Update)
          1. [List all installed packages:](#List-all-installed-packages:)
          1. [System monitor](#System-monitor)
          1. [Development](#Development)
              1. [python](#python)
              1. [Flask](#Flask)
  1. [System Administration](#System-Administration)
      1. [OS](#OS)
      1. [User](#User)
          1. [Create new user](#Create-new-user)
      1. [Switch between the CLI and GUI on a Linux server](#Switch-between-the-CLI-and-GUI-on-a-Linux-server)
          1. [Change targets manually](#Change-targets-manually)
          1. [Set a default target](#Set-a-default-target)
  1. [IO](#IO)
      1. [Show current working folder](#Show-current-working-folder)
      1. [List files from current folder](#List-files-from-current-folder)
      1. [delete file or folder](#delete-file-or-folder)
      1. [Crate new file](#Crate-new-file)
      1. [view file content](#view-file-content)
      1. [Search text in file](#Search-text-in-file)
      1. [Clone SD Card](#Clone-SD-Card)

***

## System Infomation

### Hardware

#### Check disk space
```sh
# show folder usages
dr -h

sudo fdisk -l
```

#### list folder size
```sh
# show folder usages
du -h --max-depth=1

# count how many file in a folder
ls /folderName | wc -l
```
```
Output:
```txt
Device         Boot   Start      End  Sectors  Size Id Type
/dev/mmcblk0p1         8192  1056767  1048576  512M  c W95 FAT32 (LBA)
/dev/mmcblk0p2      1056768 61407231 60350464 28.8G 83 Linux
```

#### Storage include USB drive
How to get sd card info from raspberry pi 5?
To get information about the SD card on your Raspberry Pi 5, you can use a few different methods. Here are some steps you can follow:

##### Command: lsblk
```sh
# This will list all the block devices, including your SD card. Look for the device labeled mmcblk0 (or similar), which represents your SD card.
lsblk
```
Output:
```txt
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
mmcblk0     179:0    0 58.9G  0 disk
├─mmcblk0p1 179:1    0  512M  0 part /boot/firmware
└─mmcblk0p2 179:2    0 58.4G  0 part /
```

```sh
# This will list all block devices along with their model and serial number. Look for the entry corresponding to your SD card, usually labeled mmcblk0.
lsblk -o NAME,MODEL,SERIAL
```
Output:
```txt
NAME        MODEL SERIAL
mmcblk0           0x35654e4e
├─mmcblk0p1
└─mmcblk0p2
```

##### Mount USB drive
```sh
lsblk

# Create a usb folder
sudo mkdir /mnt/usb

# Mount USB device to the folder
sudo mount /dev/sda1 /mnt/usb

# Unmount a USB drive
sudo umount /mnt/usb
```
Output:
```txt
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    1 476.7G  0 disk
└─sda1        8:1    1 476.7G  0 part
mmcblk0     179:0    0  58.9G  0 disk
├─mmcblk0p1 179:1    0   512M  0 part /boot/firmware
└─mmcblk0p2 179:2    0  58.4G  0 part /
```

##### Copy file to USB folder
```sh
cp ~/ls/development/raspberry-pi/data/*.mp4 /mnt/usb/RaspberryPi/

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
Output:
```txt
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:37:86:55:c8  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.111.123  netmask 255.255.255.0  broadcast 192.168.111.255
        inet6 fe80::110b:aaf1:cda4:c2a0  prefixlen 64  scopeid 0x20<link>
        ether 2c:cf:67:52:fd:e0  txqueuelen 1000  (Ethernet)
        RX packets 1043194  bytes 497518558 (474.4 MiB)
        RX errors 0  dropped 2  overruns 0  frame 0
        TX packets 721348  bytes 20422533963 (19.0 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 106

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 73595  bytes 39454358 (37.6 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 73595  bytes 39454358 (37.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.42.0.1  netmask 255.255.255.0  broadcast 10.42.0.255
        inet6 fe80::2ecf:67ff:fe52:fde1  prefixlen 64  scopeid 0x20<link>
        ether 2c:cf:67:52:fd:e1  txqueuelen 1000  (Ethernet)
        RX packets 23889  bytes 2787755 (2.6 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 48585  bytes 70174773 (66.9 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

###### Command: hostname
```sh
# Show all IP address
hostname -I
```

###### Command: netstat
```sh
# Show Listening Ports
sudo netstat -tunlp

# check for port 5000
sudo netstat -tunlp | grep :5000
```
Output:
```txt
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 10.42.0.1:53            0.0.0.0:*               LISTEN      946/dnsmasq
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      774/sshd: /usr/sbin
tcp        0      0 0.0.0.0:139             0.0.0.0:*               LISTEN      933/smbd
tcp        0      0 127.0.0.1:8080          0.0.0.0:*               LISTEN      769/motion
tcp        0      0 127.0.0.1:8081          0.0.0.0:*               LISTEN      769/motion
tcp6       0      0 :::445                  :::*                    LISTEN      933/smbd
tcp6       0      0 :::22                   :::*                    LISTEN      774/sshd: /usr/sbin
tcp6       0      0 :::139                  :::*                    LISTEN      933/smbd
udp        0      0 0.0.0.0:49102           0.0.0.0:*                           645/avahi-daemon: r
udp        0      0 10.42.0.1:53            0.0.0.0:*                           946/dnsm
udp        0      0 0.0.0.0:5353            0.0.0.0:*                           645/avahi-daemon: r
udp6       0      0 :::60601                :::*                                645/avahi-daemon: r
udp6       0      0 :::5353                 :::*                                645/avahi-daemon: r
```

###### Kill the process by PID
```sh
kill <PID>
```

###### Change IP address
```sh
# show connections
nmcli con show

sudo nmcli con mod "Wired connection 1" ipv4.addresses 192.168.0.152/24
sudo nmcli con mod "Wired connection 1" ipv4.gateway 192.168.0.254
sudo nmcli con mod "Wired connection 1" ipv4.method manual
sudo nmcli con mod "Wired connection 1" ipv4.dns 192.168.0.254

# Restart Connection: Apply the changes by restarting the connection:
sudo nmcli con up "Wired connection 1"

```

###### Error:
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
open known_hosts from your user .ssh folder
Remove that hostname



```sh
sudo nano /etc/dhcpcd.conf
```

```txt
interface eth0
static ip_address=192.168.0.152/255.255.255.0
static routers=192.168.0.254
static domain_name_servers=192.168.0.254
```

###### Restart dhcp
```sh
sudo systemctl restart dhcpcd
```


#### Camera
##### command: v4l2-ctl
```sh
# install v4l-utils
sudo apt install v4l-utils

# list all camera
v4l2-ctl --list-devices

# 
v4l2-ctl --list-formats-ext
```


### Software


#### System Update
```sh
sudo apt-get update
```

#### List all installed packages:
```sh
# All packages
dpkg -l

# Packages contains sql
dpkg -l | grep sql
```

#### System monitor
```sh
top

ps aux
```


#### Development

##### python
```sh
# Install pip
sudo apt install python3-pip

# Check pip3 version
pip3 --version

# 
pip3 install Flask

```

##### Flask
```sh
# Install Flash
pip3 install Flask

```



## System Administration

### OS
```bash
# Shutdown immediately
sudo shutdown now

# Reboot system
sudo reboot
```

### User
#### Create new user
```sh
sudo adduser <username>
sudo usermod -aG sudo <username>

```

Output
```txt
cker@raspberrypidocker:~ $ sudo adduser <username>
Adding user `<username>' ...
Adding new group `<username>' (1001) ...
Adding new user `<username>' (1001) with group `<username> (1001)' ...
Creating home directory `/home/<username>' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for <username>
Enter the new value, or press ENTER for the default
        Full Name []: <User Full name>
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] Y
Adding new user `<username>' to supplemental / extra groups `users' ...
Adding user `<username>' to group `users' ...
```


### Switch between the CLI and GUI on a Linux server
[Ref.](https://www.redhat.com/en/blog/configure-systemd-startup-targets)

```sh
# Identify the current target
sudo systemctl get-default

```

#### Change targets manually
You can switch between targets on the fly by using the isolate subcommand. Perhaps you have a long checklist of administrative tasks, and it would be simplest for you to accomplish these in a GUI, but your server boots to the CLI. You can switch to the GUI, perform your tasks, and then switch the system back to the more efficient CLI.

```sh
# launch the GUI from the multi-user.target
sudo systemctl isolate graphical.target

# Switch back by specifying the multi-user.target
sudo systemctl isolate multi-user.target
```

#### Set a default target
The default target represents the interface presented when the system first boots. Booting a server to a CLI for efficiency and security is common. The CLI consumes far fewer resources and contains less software to patch and worry over. Newer administrators or those migrating from another server platform may not be comfortable enough with Bash to work effectively at the command line. End-user workstations rarely boot to the CLI because the user typically needs graphics-based software, such as productivity suites and web browsers. For these users, the performance hit is worth the convenience.

```sh
# Configure the default startup target as the CLI:
sudo systemctl set-default multi-user.target

# Check the current default target:
sudo systemctl get-default

# Switch to the opposite target (for example, if your system boots to the GUI, switch to the CLI):
sudo systemctl set-default multi-user.target

# Reboot and confirm the appropriate target launched:
sudo systemctl reboot

# Manually switch targets:
sudo systemctl isolate graphical.target

# Configure the system back to the original target:
sudo systemctl set-default graphical.target

# Reboot and then confirm the default target:
sudo systemctl reboot

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


### Clone SD Card
```sh
sudo dd if=/dev/sda of=/home/docker/RaspberryPi_5-headless.img
sudo dd if=/dev/sda of=/home/docker/RaspberryPi_5-headless.img bs=4M status=progress
```


