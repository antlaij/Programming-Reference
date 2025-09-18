# DOS Command

## Table of Contents
1. [Check Parameter is empty or not](#Check-Parameter-is-empty-or-not)
1. [IF, ELSE IF, ELSE](#IF,-ELSE-IF,-ELSE)
1. [Set current date and time](#Set-current-date-and-time)
1. [Reset date and time variables](#Reset-date-and-time-variables)
1. [Create zip file by 7-Zip](#Create-zip-file-by-7-Zip)
    1. [do not zip .git folder](#do-not-zip-.git-folder)
1. [Create zip file by Power Shell](#Create-zip-file-by-Power-Shell)
1. [Generate folder creation command from DOS](#Generate-folder-creation-command-from-DOS)

***

## Get System Info.
```sh
systeminfo
```

## System Process like task manager
[Gets the processes that are running on the local computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-process?view=powershell-7.5)
```sh
Get-Process node -FileVersion
Get-Process node | ? { $_.Path -ne $null -and $_.Path -ne '' } | Select Responding,Description,ProcessName,CommandLine,Path,Threads,CPU,PeakPageMemorySize64,FileVersin,StartTime,MalnWindowTitle,Modules > E:\Buffer\1.log

# Search process by name
Get-Process winword, explorer | Format-List * > E:\Buffer\1.log

# Get all processes with a working set greater than a specified size
Get-Process | Where-Object {$_.WorkingSet -gt 20000000} > E:\Buffer\1.log
```

## Search command line process
Run in Powershell
### List all process
```sh
wmic path win32_process get Caption,Processid,Commandline > E:\Buffer\1.log
wmic path win32_process get /format:list > E:\Buffer\1.log
```
```sh
# Search for node.exe in ExecutablePath
wmic process where "ExecutablePath like '%node.exe%'" get /format:list > E:\Buffer\1.log

# Search for node.exe in commandline
wmic process where "commandline like '%node.exe%'" get /format:list > E:\Buffer\1.log
wmic process where "commandline like '%node.exe%'" get processid"," commandline > E:\Buffer\1.log
wmic process where "commandline like '%node.exe%'" get ProcessId"," Caption"," Name"," CommandLine /format:list > E:\Buffer\1.log
wmic process where "commandline like '%aaron-expo-app%'" get ProcessId"," Caption"," Name"," CommandLine /format:list > E:\Buffer\1.log

```

## Kill process by PID
```sh
taskkill /PID 123456
```

## Check Parameter is empty or not
```batch
IF [%3] == [] (
  echo Third Arg is empty
)
```

## IF, ELSE IF, ELSE
```batch
IF %myvariable%==1 (
   echo myvariable == 1
) ELSE IF %myvariable%==2 (
   echo myvariable == 2
) ELSE (
    echo In Else block
)
```

## Set current date and time
```batch
@echo off
cls
echo Date format = %date%
set Year=%date:~0,4%
set Month=%date:~5,2%
set Day=%date:~8,2%
echo.
echo Time format = %time%
echo 24 Hour Time format = %TIME: =0%
set H24Time=%TIME: =0%
set Hour=%H24Time:~0,2%
set Minute=%time:~3,2%
set Second=%time:~6,2%
echo.
echo Current Date: %Year%-%Month%-%Day% %Hour%:%Minute%:%Second%
```

## Reset date and time variables
```batch
@echo off

set Year=
set Month=
set Day=
set Hour=
set Minute=
set Second=
set Current_Date=
set Current_Time=
set Temp_use=
set Temp_Hour=
set Temp_Min=
```

## Create zip file by 7-Zip
### do not zip .git folder
```batch
cls
set Folder_To_Zip=C:\temp
set Zip_Folder=C:\zip

mkdir %Zip_Folder%
cd %Folder_To_Zip%
"C:\Program Files\7-Zip\7z" a -tzip createdZipFile.zip -r *.*  -xr!.git
move createdZipFile.zip %Zip_Folder%

set Folder_To_Zip=
set Zip_Folder=
```

## Create zip file by Power Shell
```batch
cls
set Folder_To_Zip=C:\temp

PowerShell -Command "Compress-Archive -LiteralPath '%Folder_To_Zip%' -DestinationPath 'C:\temp.zip'"

set Folder_To_Zip=
```

## Generate folder creation command from DOS
```bat
REM 
d:
FOR /f "tokens=*" %x IN ( 'DIR /B /S /A:D' ) DO ECHO MKDIR "%x" >> E:\Buffer\1.txt
```

## Command - DIR
### List filename only
```bat
dir /b /a-d
```

## Command - forfiles
### Copy file by date
```bat
REM Set target date variable to 7 days ago
for /f %i in ('powershell -command "((Get-Date).AddDays(-7)).ToString('MM/dd/yyyy')"') do set SevenDaysAgo=%i

REM Set date variable manually
set SevenDaysAgo=2025-09-09
echo %SevenDaysAgo%

forfiles /P "D:\Temp" /S /D +%SevenDaysAgo% /C "cmd /c copy @path E:\Temp"

```



