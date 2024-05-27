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
