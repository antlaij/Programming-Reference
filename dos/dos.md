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
set Hour=%time:~0,2%
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
