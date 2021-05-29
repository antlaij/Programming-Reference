## Loop folder name from a directory
```batch
cls
set BackupFolder=C:\temp

cd %BackupFolder%

for /f "tokens=*" %%G in ('dir /b /a:d "%BackupFolder%\*"') do (
title Updating: %%G
echo Folder Name: %%G
)

set BackupFolder=
```
