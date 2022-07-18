/*
usage: osql              [-U login id]          [-P password]
  [-S server]            [-H hostname]          [-E trusted connection]
  [-d use database name] [-l login timeout]     [-t query timeout]
  [-h headers]           [-s colseparator]      [-w columnwidth]
  [-a packetsize]        [-e echo input]        [-I Enable Quoted Identifiers]
  [-L list servers]      [-c cmdend]            [-D ODBC DSN name]
  [-q "cmdline query"]   [-Q "cmdline query" and exit]
  [-n remove numbering]  [-m errorlevel]
  [-r msgs to stderr]    [-V severitylevel]
  [-i inputfile]         [-o outputfile]
  [-p print statistics]  [-b On error batch abort]
  [-X[1] disable commands [and exit with warning]]
  [-O use Old ISQL behavior disables the following]
      <EOF> batch processing
      Auto console width scaling
      Wide messages
      default errorlevel is -1 vs 1
  [-? show syntax summary]
*/

/*
"C:\Program Files\Microsoft SQL Server\140\Tools\Binn\OSQL.EXE" -S sqlserver.com -d "DATABASE_NAME" -U "username" -P password /w 32768 -e -c "r"
"C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.EXE" -S "SERVER-NAME\SQLEXPRESS" -S server -U username -P password -d DATABASE_NAME -w 32768 -c "r"
"C:\Program Files\Microsoft SQL Server\80\Tools\Binn\osql.exe" /U "USERNAME" /P "PASSWORD" /w 32768 -e -n -c "r" -d "DATABASENAME"
"C:\Program Files\Microsoft SQL Server\80\Tools\Binn\osql.exe" /E /w 32768 -c "r" -d "master"
*/

/*
Microsoft (R) SQL Server Command Line Tool
Version 9.00.1399.06 NT INTEL X86
Copyright (c) Microsoft Corporation.  All rights reserved.

usage: Sqlcmd            [-U login id]          [-P password]
  [-S server]            [-H hostname]          [-E trusted connection]
  [-d use database name] [-l login timeout]     [-t query timeout]
  [-h headers]           [-s colseparator]      [-w screen width]
  [-a packetsize]        [-e echo input]        [-I Enable Quoted Identifiers]
  [-c cmdend]            [-L[c] list servers[clean output]]
  [-q "cmdline query"]   [-Q "cmdline query" and exit]
  [-m errorlevel]        [-V severitylevel]     [-W remove trailing spaces]
  [-u unicode output]    [-r[0|1] msgs to stderr]
  [-i inputfile]         [-o outputfile]        [-z new password]
  [-f <codepage> | i:<codepage>[,o:<codepage>]] [-Z new password and exit]
  [-k[1|2] remove[replace] control characters]
  [-y variable length type display width]
  [-Y fixed length type display width]
  [-p[1] print statistics[colon format]]
  [-R use client regional setting]
  [-b On error batch abort]
  [-v var = "value"...]  [-A dedicated admin connection]
  [-X[1] disable commands, startup script, enviroment variables [and exit]]
  [-x disable variable substitution]
  [-? show syntax summary]



sqlcmd -S DESKTOP-NAME\SQLEXPRESS -E
"C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\SQLCMD.EXE" -S violet.arvixe.com -d "DATABASE_NAME" -U "username" -P "password" /w 32768 -e -c "r"
"C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\SQLCMD.EXE" -S violet.arvixe.com /U "username" /P "password" /w 32768 -e -c "r" -d "DB_NAME"
"C:\Program Files\Microsoft SQL Server\90\Tools\Binn\SQLCMD.EXE" -S SERVER_MACHINE\SQLEXPRESS -w 32768 -c "r"
"C:\Program Files\Microsoft SQL Server\90\Tools\Binn\SQLCMD.EXE" /?
Microsoft (R) SQL Server Command Line Tool
Version 9.00.3042.00 NT INTEL X86
Copyright (c) Microsoft Corporation.  All rights reserved.

usage: Sqlcmd            [-U login id]          [-P password]
  [-S server]            [-H hostname]          [-E trusted connection]
  [-d use database name] [-l login timeout]     [-t query timeout]
  [-h headers]           [-s colseparator]      [-w screen width]
  [-a packetsize]        [-e echo input]        [-I Enable Quoted Identifiers]
  [-c cmdend]            [-L[c] list servers[clean output]]
  [-q "cmdline query"]   [-Q "cmdline query" and exit]
  [-m errorlevel]        [-V severitylevel]     [-W remove trailing spaces]
  [-u unicode output]    [-r[0|1] msgs to stderr]
  [-i inputfile]         [-o outputfile]        [-z new password]
  [-f <codepage> | i:<codepage>[,o:<codepage>]] [-Z new password and exit]
  [-k[1|2] remove[replace] control characters]
  [-y variable length type display width]
  [-Y fixed length type display width]
  [-p[1] print statistics[colon format]]
  [-R use client regional setting]
  [-b On error batch abort]
  [-v var = "value"...]  [-A dedicated admin connection]
  [-X[1] disable commands, startup script, enviroment variables [and exit]]
  [-x disable variable substitution]
  [-? show syntax summary]
*/









/*------------------------------     SQLCMD      ------------------------------*/

/*-----   Run Script   -----*/
/*-----   TMRW003038   -----*/
"C:\Program Files\Microsoft SQL Server\90\Tools\Binn\SQLCMD.EXE" -S TMRW003038\SQLEXPRESS -w 32768 -i "d:\Library_script.sql" -o "C:\Temp\SqlOut.txt"




/*------------------------------     System Administration      ------------------------------*/

/*-----   show system config   -----*/

SP_CONFIGURE


/*
||	Changing Memory Usage
||	Max Server Memory (MB) - Use the sp_configure command to set the Max Server Memory to 200M as follows:
*/

EXEC master.dbo.sp_configure
GO
EXEC master.dbo.sp_configure 'show advanced options', 1
RECONFIGURE
GO
EXEC master.dbo.sp_configure 'max server memory', 200
RECONFIGURE
GO
EXEC master.dbo.sp_configure
GO


/*
||	Changing Memory Usage
||	Min Server Memory (MB) - Use the sp_configure command to set the Min Server Memory to 1024 as follows:
*/

EXEC master.dbo.sp_configure
GO
EXEC master.dbo.sp_configure 'show advanced options', 1
RECONFIGURE
GO
EXEC master.dbo.sp_configure 'min server memory', 1024
RECONFIGURE
GO
EXEC master.dbo.sp_configure
GO


/*-----   Add user in database   -----*/
create user lai identified by lai default tablespace def_t temporary tablespace t_name


/*
||	CREATE USER FOR SQL SERVER 2000
*/
USE DATABASE_NAME
EXEC sp_dropuser 'FM_Admin'
EXEC sp_droplogin 'FM_Admin'
EXEC sp_droprole 'FM_Admin_Role'
EXEC sp_addrole 'FM_Admin_Role'
EXEC sp_addlogin 'FM_Admin', 'LIB_FM_Admin', 'LIBRARY'
EXEC sp_adduser 'FM_Admin', 'FM_Admin', 'FM_Admin_Role'
EXEC sp_addrolemember 'FM_Admin_Role', 'FM_Admin'
GO

/*-----   Create New Database   -----*/
USE MASTER
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'NEW_DB')
	DROP DATABASE [NEW_DB]
GO

CREATE DATABASE NEW_DB
ON
( NAME = Sales_dat,
   FILENAME = 'c:\program files\microsoft sql server\mssql\data\NEW_DB_dat.mdf',
   SIZE = 10,
   MAXSIZE = 50,
   FILEGROWTH = 5 )
LOG ON
( NAME = 'Sales_log',
   FILENAME = 'c:\program files\microsoft sql server\mssql\data\NEW_DB_log.ldf',
   SIZE = 5MB,
   MAXSIZE = 25MB,
   FILEGROWTH = 5MB );




/*-----   V2005   -----*/

CREATE DATABASE [INV] ON  PRIMARY
( NAME = N'INV', FILENAME = N'C:\Document\DB\INV.mdf' , SIZE = 5120KB , FILEGROWTH = 10%)
 LOG ON
( NAME = N'INV_log', FILENAME = N'C:\Document\DB\INV_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO

ALTER DATABASE [MyCompany] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [MyCompany] SET ANSI_NULLS OFF
GO
ALTER DATABASE [MyCompany] SET ANSI_PADDING OFF
GO
ALTER DATABASE [MyCompany] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [MyCompany] SET ARITHABORT OFF
GO
ALTER DATABASE [MyCompany] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [MyCompany] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [MyCompany] SET AUTO_SHRINK ON
GO
ALTER DATABASE [MyCompany] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [MyCompany] SET CURSOR_CLOSE_ON_COMMIT ON
GO
ALTER DATABASE [MyCompany] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [MyCompany] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [MyCompany] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [MyCompany] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [MyCompany] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [MyCompany] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [MyCompany] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [MyCompany] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [MyCompany] SET  READ_WRITE
GO
ALTER DATABASE [MyCompany] SET RECOVERY SIMPLE
GO
ALTER DATABASE [MyCompany] SET  MULTI_USER
GO
ALTER DATABASE [MyCompany] SET PAGE_VERIFY CHECKSUM
GO
USE [MyCompany]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [MyCompany] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO



SELECT TABLE_NAME as Name, TABLE_NAME as Value FROM Information_Schema.Tables WHERE TABLE_TYPE IN ('BASE TABLE', 'VIEW')




/*-----   V2008   -----*/

CREATE DATABASE [SH] ON  PRIMARY
( NAME = N'SH', FILENAME = N'E:\Data\MS_SQL\SH.mdf' , SIZE = 2048KB , FILEGROWTH = 1024KB )
 LOG ON
( NAME = N'SH_log', FILENAME = N'E:\Data\MS_SQL\SH_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SH] SET COMPATIBILITY_LEVEL = 100
GO
ALTER DATABASE [SH] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [SH] SET ANSI_NULLS OFF
GO
ALTER DATABASE [SH] SET ANSI_PADDING OFF
GO
ALTER DATABASE [SH] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [SH] SET ARITHABORT OFF
GO
ALTER DATABASE [SH] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [SH] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [SH] SET AUTO_SHRINK ON
GO
ALTER DATABASE [SH] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [SH] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [SH] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [SH] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [SH] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [SH] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [SH] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [SH] SET  DISABLE_BROKER
GO
ALTER DATABASE [SH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [SH] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [SH] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [SH] SET  READ_WRITE
GO
ALTER DATABASE [SH] SET RECOVERY FULL
GO
ALTER DATABASE [SH] SET  MULTI_USER
GO
ALTER DATABASE [SH] SET PAGE_VERIFY CHECKSUM
GO
USE [SH]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [SH] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO


/*--------------------   Database Mantinance   --------------------*/

/*-----   LOG FILE   -----*/

/*
||	Example Shrinking the Transaction Log
||	Here is an example how boths steps can be performed:
||
||	Database is in FULL Recovery Mode
||	# For this example we switch to FULL Mode
*/


USE MASTER
ALTER DATABASE DATABASE_NAME SET RECOVERY FULL;

/*
||	# Add logical Devices for the Backup (The directories must exist!)
*/

EXEC sp_addumpdevice 'disk', 'DATABASE_NAME_dat', 'C:\Program Files\Microsoft SQL Server\MSSQL\BACKUP\curia_dat.dat'

EXEC sp_addumpdevice 'disk', 'DATABASE_NAME_log', 'C:\Program Files\Microsoft SQL Server\MSSQL\BACKUP\curia_log.dat'

/*
||	# Create a Backup before Truncating / Shrinking
*/

BACKUP DATABASE DATABASE_NAME TO DATABASE_NAME_dat

BACKUP LOG DATABASE_NAME TO DATABASE_NAME_log

/*
||	# Truncate the Transaction Log
*/

BACKUP LOG Curia WITH TRUNCATE_ONLY

/*
||	# If the Log file is too big Truncating log file and Shrinking log file to 10M
*/

SELECT name, filename FROM sysfiles
GO

BACKUP LOG DATABASE_NAME WITH TRUNCATE_ONLY
GO

USE DATABASE_NAME;

-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE DATABASE_NAME SET RECOVERY SIMPLE;

-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (LOG_FILE_NAME, 5);
GO
DBCC SHRINKDATABASE(N'Library' )
GO


-- Reset the database recovery model.
ALTER DATABASE DATABASE_NAME SET RECOVERY FULL;




/*
||	# Drop logical Devices
*/

sp_dropdevice 'DATABASE_NAME_dat'

sp_dropdevice 'DATABASE_NAME_log'

/*
||	# Get the Name of the Transaction Log
*/

USE DATABASE_NAME
SELECT name, filename FROM dbo.sysfiles
GO


/*
||	# Shrink the physical Size of the Transaction Log to 20MB
*/

USE PIM, 'PIM_Log', 20
GO



/*
||	# Check and repair Database Table
*/
--Change to the single user first
sp_dboption DATABASE_NAME, single, true
DBCC CHECKDB (DATABASE_NAME, repair_allow_data_loss);


USE [DATABASE]
GO
EXEC dbo.sp_changedbowner @loginame = N'sa', @map = false
GO


/*-----   LIST ALL DATABASE   -----*/

SELECT
	CAST(DB.NAME AS VARCHAR(20)) AS DATABASE_NAME,
	DB.CRDATE,
	CAST(F.NAME AS VARCHAR(20)) AS DATABASE_FILE,
	F.FILENAME,
--	DB.CATEGORY,
--	DB.CMPTLEVEL,
	DB.DBID,
--	DB.FILENAME,
--	DB.MODE,
	DB.RESERVED,
	DB.SID,
	DB.STATUS,
	DB.STATUS2,
	DB.VERSION,
--	F.CREATELSN,
	F.DBID,
--	F.DROPLSN,
	F.FILEID,
--	F.GROUPID,
	F.GROWTH,
	F.MAXSIZE,
--	F.PERF,
	F.SIZE,
	F.STATUS,
	'END'
	FROM
		MASTER.DBO.SYSALTFILES AS F
			INNER JOIN MASTER.DBO.SYSDATABASES AS DB ON F.DBID = DB.DBID
		WHERE
			F.DBID = DB.DBID
			ORDER BY
				DB.NAME,
				F.FILEID,
				F.FILENAME;
GO




/*-----   CREATE Database   -----*/

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DATABASE_NAME')
	DROP DATABASE [DATABASE_NAME]


CREATE DATABASE [DATABASE_NAME]
	ON (NAME = N'DATABASE_NAME_Data' FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL\data\DATABASE_NAME_Data.MDF'
SIZE = 2
FILEGROWTH = 10%) LOG
	ON (NAME = N'DATABASE_NAME_Log' FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL\data\DATABASE_NAME_Log.LDF'
SIZE = 1
FILEGROWTH = 10%)




/*-----   Backup Database   -----*/

BACKUP DATABASE [DATABASE_NAME] TO DISK = 'C:\DATABASE_NAME.BAK'
BACKUP DATABASE [DATABASE_NAME] TO  DISK = N'D:\WEDDING_db_200511230100.BAK' WITH  INIT ,  NOUNLOAD ,  NOSKIP ,  STATS = 10,  NOFORMAT

--For Server 2005
BACKUP DATABASE [DATABASE_NAME] TO  DISK = N'C:\SQL_Backup\DATABASE_NAME\DATABASE_NAME_backup_200807062147.bak' WITH  RETAINDAYS = 14, NOFORMAT, NOINIT,  NAME = N'DATABASE_NAME_backup_20080101214707', SKIP, REWIND, NOUNLOAD,  STATS = 10




/*-----   Restore Database   -----*/

USE MASTER

RESTORE DATABASE [DATABASE_NAME]
   FROM DISK = 'C:\Test_db_200402100530.BAK'
   WITH MOVE 'Northwind' TO 'c:\test\testdb.mdf',
   MOVE 'Northwind_log' TO 'c:\test\testdb.ldf'

RESTORE DATABASE [MyCompany] FROM  DISK = N'Z:\DB_Backup\SQL_Server_2008\MyCompany\MyCompany_backup_2011_11_26_050020_8080625.bak' WITH  FILE = 1,  MOVE N'MyCompany_log' TO N'E:\Data\MS_SQL\MyCompany_1.ldf',  NOUNLOAD,  REPLACE,  STATS = 10
GO



BACKUP DATABASE Northwind
   TO DISK = 'C:\Test_db_200402100530.BAK'
RESTORE FILELISTONLY
   FROM DISK = 'C:\Test_db_200402100530.BAK'
RESTORE DATABASE MyCompany
   FROM DISK = 'C:\Test_db_200402100530.BAK'
   WITH MOVE 'Northwind' TO 'c:\test\testdb.mdf',
   MOVE 'Northwind_log' TO 'c:\test\testdb.ldf'
RESTORE DATABASE [MyCompany]
	FROM  DISK = N'D:\SQL_Backup\MyCompany\MyCompany\MyCompany_db_USB.BAK'
		WITH  FILE = 1,
	MOVE N'MyCompany_dat'
		TO N'C:\Document\DB\MyCompany.mdf',
	MOVE N'MyCompany_log'
		TO N'C:\Document\DB\MyCompany.ldf',
	NOUNLOAD,  REPLACE,  STATS = 5
GO

BACKUP DATABASE [EDI] TO  DISK = N'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\EDI.bak' WITH NOFORMAT, INIT,  NAME = N'EDI-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'EDI' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'EDI' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''EDI'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\EDI.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO






/*-----   GRANT PREMISSION   -----*/

GRANT SELECT, UPDATE, INSERT, DELETE, DRI ON TABLE_NAME TO SYSTEM_ROLES

GRANT SELECT, UPDATE, INSERT, DELETE, DRI ON TABLE_NAME TO USER_01, USER_01, USER_03




/*-----   DENY PREMISSION   -----*/

DENY SELECT, UPDATE, INSERT, DELETE, DRI ON TABLE_NAME TO SYSTEM_ROLES




/*-----   CHECK TABLE CONSTRAINTS EXIST OR NOT   -----*/


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONSTRAINTS_NAME]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)





/*------------------------------          Restore DATABASE Start          ------------------------------*/

-- For SQL Server 2005:


/*
||	Drop Login
*/

USE [master]
GO

IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'Username')
DROP LOGIN [Username]
GO

CREATE LOGIN [Username] WITH PASSWORD=N'MyCompany_Username', DEFAULT_DATABASE=[DATABASE_NAME], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

USE [DATABASE_NAME]
GO

EXEC sp_droprolemember N'User_Role', N'Username'
GO

IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'Username')
DROP SCHEMA [Username]
GO

IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'User_Role')
DROP SCHEMA [User_Role]
GO

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Username')
DROP USER [Username]
GO

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'User_Role' AND type = 'R')
DROP ROLE [User_Role]
GO

CREATE ROLE [User_Role]
GO

CREATE USER [Username] FOR LOGIN [Username]
GO

EXEC sp_addrolemember N'User_Role', N'Username'
GO

CREATE SCHEMA [User_Role] AUTHORIZATION [User_Role]
GO

CREATE SCHEMA [Username] AUTHORIZATION [Username]
GO



/*------------------------------          Grant User Access          ------------------------------*/

USE [DATABASE_NAME]


SELECT 'GRANT SELECT, UPDATE, INSERT, DELETE ON ' + NAME + ' TO USER_Role;' AS GRANT_SQL, NAME OBJECT_NAME, 'FULL ACCESS' AS RIGHTS, XTYPE AS TYPE FROM SYSOBJECTS
	WHERE XTYPE = 'U' AND NAME LIKE '%'
UNION
SELECT 'GRANT SELECT, UPDATE, INSERT, DELETE ON ' + NAME + ' TO USER_Role;' AS GRANT_SQL, NAME OBJECT_NAME, 'FULL ACCESS' AS RIGHTS, XTYPE AS TYPE FROM SYSOBJECTS
	WHERE XTYPE = 'U' AND NAME LIKE 'GEN_%'
UNION
SELECT 'GRANT SELECT ON ' + NAME + ' TO USER_Role;', NAME OBJECT_NAME, 'SELECT' AS RIGHTS, XTYPE AS TYPE FROM SYSOBJECTS
	WHERE XTYPE = 'V' AND NAME LIKE 'VW_%'
UNION
SELECT 'GRANT EXECUTE ON ' + NAME + ' TO USER_Role;', NAME OBJECT_NAME, 'EXECUTE' AS RIGHTS, XTYPE AS TYPE FROM SYSOBJECTS
	WHERE XTYPE = 'P' AND NAME LIKE 'PROC_%'
UNION
SELECT 'GRANT EXECUTE ON ' + NAME + ' TO USER_Role;', NAME OBJECT_NAME, 'EXECUTE' AS RIGHTS, XTYPE AS TYPE FROM SYSOBJECTS
	WHERE XTYPE = 'FN' AND NAME LIKE 'FN_%';
GO







/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Database Information      ------------------------------*/

/*
System Tables in the master Database Only
These tables store server-level system information.
*/

SELECT * FROM MASTER.DBO.SYSALTFILES
GO

SELECT * FROM MASTER.DBO.SYSLOCKINFO
GO

SELECT * FROM MASTER.DBO.SYSCACHEOBJECTS
GO

SELECT * FROM MASTER.DBO.SYSLOGINS
GO

SELECT * FROM MASTER.DBO.SYSCHARSETS
GO

SELECT * FROM MASTER.DBO.SYSMESSAGES
GO

SELECT * FROM MASTER.DBO.SYSCONFIGURES
GO

SELECT * FROM MASTER.DBO.SYSOLEDBUSERS
GO

SELECT * FROM MASTER.DBO.SYSCURCONFIGS
GO

SELECT * FROM MASTER.DBO.SYSPERFINFO
GO

SELECT * FROM MASTER.DBO.SYSDATABASES
GO

SELECT * FROM MASTER.DBO.SYSPROCESSES
GO

SELECT * FROM MASTER.DBO.SYSDEVICES
GO

SELECT * FROM MASTER.DBO.SYSREMOTELOGINS
GO

SELECT * FROM MASTER.DBO.SYSLANGUAGES
GO

SELECT * FROM MASTER.DBO.SYSSERVERS
GO


/*
System Tables in Every Database
These tables store database-level system information for each database.
*/

SELECT * FROM SYSCOLUMNS
GO

SELECT * FROM SYSINDEXKEYS
GO

SELECT * FROM SYSCOMMENTS
GO

SELECT * FROM SYSMEMBERS
GO

SELECT * FROM SYSCONSTRAINTS
GO

SELECT * FROM SYSOBJECTS
GO

SELECT * FROM SYSDEPENDS
GO

SELECT * FROM SYSPERMISSIONS
GO

SELECT * FROM SYSFILEGROUPS
GO

SELECT * FROM SYSPROTECTS
GO

SELECT * FROM SYSFILES
GO

SELECT * FROM SYSREFERENCES
GO

SELECT * FROM SYSFOREIGNKEYS
GO

SELECT * FROM SYSTYPES
GO

SELECT * FROM SYSFULLTEXTCATALOGS
GO

SELECT * FROM SYSUSERS
GO

SELECT * FROM SYSINDEXES
GO

/*
SQL Server Agent Tables in the msdb Database
These tables store information used by SQL Server Agent.
*/

sysalerts
sysjobsteps
syscategories
sysnotifications
sysdownloadlist
sysoperators
sysjobhistory
systargetservergroupmembers
sysjobs
systargetservergroups
sysjobschedules
systargetservers
sysjobservers
systaskids

/*
Tables in the msdb Database
These tables store information used by database backup and restore operations.
*/

backupfile
restorefile
backupmediafamily
restorefilegroup
backupmediaset
restorehistory
backupset


Tables Used to Store Replication Information
These tables are used by replication and stored in the master database.

sysdatabases
sysservers


These tables are used by replication and stored in the msdb database.

sysreplicationalerts


These tables are used by replication and stored in the distribution database.

MSagent_parameters
Mspublisher_databases
MSagent_profiles
MSreplication_objects
MSarticles
MSreplication_subscriptions
MSdistpublishers
MSrepl_commands
MSdistributiondbs
MSrepl_errors
MSdistribution_agents
MSrepl_originators
MSdistribution_history
MSrepl_transactions
MSdistributor
MSrepl_version
MSlogreader_agents
MSsnapshot_agents
MSlogreader_history
MSsnapshot_history
MSmerge_agents
MSsubscriber_info
MSmerge_history
MSsubscriber_schedule
MSmerge_subscriptions
MSsubscriptions
MSpublication_access
MSsubscription_properties
Mspublications


These tables are used by replication and stored in the publication database.

MSmerge_contents
sysmergearticles
MSmerge_delete_conflicts
sysmergepublications
MSmerge_genhistory
sysmergeschemachange
MSmerge_replinfo
sysmergesubscriptions
MSmerge_tombstone
sysmergesubsetfilters
sysarticles
syspublications
sysarticleupdates
syssubscriptions






/*-----   Select all tables from database   -----*/
SELECT
	*
	FROM
		SYSOBJECTS
		WHERE
			XTYPE = 'U'
			ORDER BY
				NAME;
GO


/*------------------------------------------------------------
||	TABLE		:	SYSOBJECTS, SYSINDEXES
||	DESCRIPTION	:	To get an *approximate* ROW count for all tables
------------------------------------------------------------*/

SELECT
    [Table Name] = SUBSTRING(SO.NAME, 1, 30),
    [RowCount] = MAX(si.rows)
	FROM
		sysobjects so inner JOIN sysindexes si
			ON si.id = OBJECT_ID(so.name)
		WHERE
			so.xtype = 'U'
			GROUP BY
				so.name
			ORDER BY
				2 DESC, 1
GO


/*------------------------------------------------------------
||	TABLE		:	SYSINDEXES
||	DESCRIPTION	:	LIST ALL INDEXES IN THE DATABASE
------------------------------------------------------------*/

SELECT '[' + s.NAME + '].[' + o.NAME + ']' AS 'table_name'
    ,+ i.NAME AS 'index_name'
    ,LOWER(i.type_desc) + CASE 
        WHEN i.is_unique = 1
            THEN ', unique'
        ELSE ''
        END + CASE 
        WHEN i.is_primary_key = 1
            THEN ', primary key'
        ELSE ''
        END AS 'index_description'
    ,STUFF((
            SELECT ', [' + sc.NAME + ']' AS "text()"
            FROM syscolumns AS sc
            INNER JOIN sys.index_columns AS ic ON ic.object_id = sc.id
                AND ic.column_id = sc.colid
            WHERE sc.id = so.object_id
                AND ic.index_id = i1.indid
                AND ic.is_included_column = 0
            ORDER BY key_ordinal
            FOR XML PATH('')
            ), 1, 2, '') AS 'indexed_columns'
    ,STUFF((
            SELECT ', [' + sc.NAME + ']' AS "text()"
            FROM syscolumns AS sc
            INNER JOIN sys.index_columns AS ic ON ic.object_id = sc.id
                AND ic.column_id = sc.colid
            WHERE sc.id = so.object_id
                AND ic.index_id = i1.indid
                AND ic.is_included_column = 1
            FOR XML PATH('')
            ), 1, 2, '') AS 'included_columns'
FROM sysindexes AS i1
INNER JOIN sys.indexes AS i ON i.object_id = i1.id
    AND i.index_id = i1.indid
INNER JOIN sysobjects AS o ON o.id = i1.id
INNER JOIN sys.objects AS so ON so.object_id = o.id
    AND is_ms_shipped = 0
INNER JOIN sys.schemas AS s ON s.schema_id = so.schema_id
WHERE so.type = 'U'
    AND i1.indid < 255
    AND i1.STATUS & 64 = 0 --index with duplicates
    AND i1.STATUS & 8388608 = 0 --auto created index
    AND i1.STATUS & 16777216 = 0 --stats no recompute
    AND i.type_desc <> 'heap'
    AND so.NAME <> 'sysdiagrams'
ORDER BY table_name
    ,index_name;

/*-----   Select all cols from database   -----*/
SELECT * FROM SYSCOLUMNS;
GO



/*-----   Select all cols from database   -----*/
SELECT * FROM SYSPROPERTIES

SELECT OBJECT_NAME(ID), NAME FROM SYSPROPERTIES;
GO

SELECT * FROM ::fn_listextendedproperty (NULL, 'user', 'dbo', 'table', 'T1', 'column', default);
GO

EXEC   sp_addextendedproperty 'caption', 'Palm_Temp Phone_Work', 'user', dbo, 'table', Palm_Temp, 'column', Phone_Work
GO



/*------------------------------------------------------------
||	DESCRIPTION	:	LIST DB INFO
------------------------------------------------------------*/
SELECT
	CAST(OBJ.NAME AS VARCHAR(30)) AS OBJECT_NAME,
	CAST(COL.NAME AS VARCHAR(30)) AS COLUMN_NAME,
	--CAST(TYPE.NAME AS VARCHAR(16)) AS DB_TYPE,
	DATA_TYPE =
	CASE TYPE.NAME
		WHEN 'bit' THEN CAST(TYPE.NAME AS VARCHAR(20))
		WHEN 'varchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'nvarchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'decimal' THEN CAST(TYPE.NAME + '(' + CAST(COL.PREC AS VARCHAR(3)) + ', ' + CAST(COL.SCALE AS VARCHAR(3)) + ')' AS VARCHAR(20))
		ELSE CAST(TYPE.NAME AS VARCHAR(20))
	END,
--	TYPE.*,
	--COL.LENGTH,
	--COL.PREC,
	--COL.SCALE,
	DIRECTION =
	CASE COL.ISOUTPARAM
		WHEN 1 THEN 'OUT'
		ELSE 'IN'
	END,
	NULLABLE =
	CASE COL.ISNULLABLE
		WHEN 0 THEN 'NO'
		WHEN 1 THEN 'YES'
		ELSE 'UNKNOWN'
	END,
	OBJ.XTYPE,
	CASE OBJ.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END AS OBJECT_TYPE,
	CASE
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsClustKey') = 1 THEN 'Constraint - A primary key with a clustered index.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsColumn') = 1 THEN 'Constraint - COLUMN constraint.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsDeleteCascade') = 1 THEN 'Constraint - A foreign key constraint with the ON DELETE CASCADE option.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsDisabled') = 1 THEN 'Constraint - Disabled constraint.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsNonclustKey') = 1 THEN 'Constraint - A primary key with a nonclustered index.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsNotTrusted') = 1 THEN 'Constraint - Constraint was enabled without checking existing rows, so constraint may not hold for all rows.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsNotRepl') = 1 THEN 'Constraint - The constraint is defined with the NOT FOR REPLICATION keywords.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsUpdateCascade') = 1 THEN 'Constraint - A foreign key constraint with the ON UPDATE CASCADE option.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsAfterTrigger') = 1 THEN 'Trigger - AFTER trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsAnsiNullsOn') = 1 THEN 'Scalar and Inline Table-valued Function, Procedure, Trigger, View - The setting of ANSI_NULLS at creation time.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsDeleteTrigger') = 1 THEN 'Trigger - DELETE trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsFirstDeleteTrigger') = 1 THEN 'Trigger - The first trigger fired when a DELETE is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsFirstInsertTrigger') = 1 THEN 'Trigger - The first trigger fired when an INSERT is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsFirstUpdateTrigger') = 1 THEN 'Trigger - The first trigger fired when an UPDATE is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsInsertTrigger') = 1 THEN 'Trigger - INSERT trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsInsteadOfTrigger') = 1 THEN 'Trigger - INSTEAD OF trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsLastDeleteTrigger') = 1 THEN 'Trigger - The last trigger fired when a DELETE is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsLastInsertTrigger') = 1 THEN 'Trigger - The last trigger fired when an INSERT is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsLastUpdateTrigger') = 1 THEN 'Trigger - The last trigger fired when an UPDATE is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsQuotedIdentOn') = 1 THEN 'Scalar and Inline Table-valued Function, Procedure, Trigger, View - The setting of QUOTED_IDENTIFIER at creation time.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsStartup') = 1 THEN 'Procedure - Startup procedure.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsTriggerDisabled') = 1 THEN 'Trigger - Disabled trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsUpdateTrigger') = 1 THEN 'Trigger - UPDATE trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'HasAfterTrigger') = 1 THEN 'Table, View - Table or view has an AFTER trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'HasDeleteTrigger') = 1 THEN 'Table, View - Table or view has a DELETE trigger.'
		ELSE 'UNKNOW PROPERTY'
	END AS OBJECT_PROP,
	SORT_ORDER =
	CASE OBJ.XTYPE
		WHEN 'C' THEN 10000
		WHEN 'D' THEN 10000
		WHEN 'F' THEN 10000
		WHEN 'L' THEN 10000
		WHEN 'FN' THEN 10000
		WHEN 'IF' THEN 10000
		WHEN 'P' THEN 15
		WHEN 'PK' THEN 20
		WHEN 'RF' THEN 25
		WHEN 'S' THEN 10000
		WHEN 'TF' THEN 10000
		WHEN 'TR' THEN 10000
		WHEN 'U' THEN 0
		WHEN 'UQ' THEN 30
		WHEN 'V' THEN 10
		WHEN 'X' THEN 10000
		ELSE 10000
	END
--	,OBJ.CATEGORY
	FROM
		SYSOBJECTS AS OBJ
			LEFT JOIN SYSCOLUMNS AS COL
				ON OBJ.ID = COL.ID
			LEFT JOIN SYSTYPES AS TYPE
				ON COL.XTYPE = TYPE.XTYPE AND TYPE.STATUS = 0
		WHERE
			OBJ.xtype in
			(
				'C',
				--'D',
				'F',
				'FN',
				'IF',
				'P',
				'PK',
				'RF',
				'S',
				'TF',
				'TR',
				'U',
				'UQ',
				'V',
				'X'
			)
			--AND OBJ.NAME LIKE '%tblUnitPart' OR OBJ.NAME LIKE '%tblPart'
			AND OBJ.XTYPE <> 'S'
			AND NOT
			(
				(OBJ.XTYPE = 'P' AND OBJ.CATEGORY = 2)
				OR (OBJ.XTYPE = 'V' AND OBJ.CATEGORY = 2)
			) -- NOT SELECTING SYSTEM PROCEDURE
			ORDER BY
				SORT_ORDER,
				OBJ.xtype,
				OBJ.NAME,
				COL.COLORDER;
GO



--		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsColumn') = 1 THEN 'Constraint - '

HasInsertTrigger Table, View Table or view has an INSERT trigger.
1 = True
0 = False

HasInsteadOfTrigger Table, View Table or view has an INSTEAD OF trigger.
1 = True
0 = False

HasUpdateTrigger Table, View Table or view has an UPDATE trigger.
1 = True
0 = False

IsAnsiNullsOn Scalar and Inline Table-valued Function, Procedure, Table, Trigger, View Specifies that the ANSI NULLS option setting for the table is ON, meaning all comparisons against a null value evaluate to UNKNOWN. This setting applies to all expressions in the table definition, including computed columns and constraints, for as long as the table exists.
1 = ON
0 = OFF

IsCheckCnst Any CHECK constraint.
1 = True
0 = False

IsConstraint Any Constraint.
1 = True
0 = False

IsDefault Any Bound default.
1 = True
0 = False

IsDefaultCnst Any DEFAULT constraint.
1 = True
0 = False

IsDeterministic Function, View The determinism property of the function or view. Applies to scalar- and table-valued functions and views.
1 = Deterministic
0 = Not Deterministic
NULL = Not a function or view, or invalid object ID.

IsExecuted Any Specifies the object can be executed (view, procedure, function, or trigger).
1 = True
0 = False

IsExtendedProc Any Extended procedure.
1 = True
0 = False

IsForeignKey Any FOREIGN KEY constraint.
1 = True
0 = False

IsIndexed Table, View A table or view with an index.
IsIndexable Table, View A table or view on which an index may be created.
IsInlineFunction Function Inline function.
1 = Inline function
0 = Not inline function
NULL = Not a function, or invalid object ID.

IsMSShipped Any An object created during installation of Microsoft?SQL Server?2000.
1 = True
0 = False

IsPrimaryKey Any PRIMARY KEY constraint.
1 = True
0 = False

IsProcedure Any Procedure.
1 = True
0 = False

IsQuotedIdentOn Scalar and Inline Table-valued Function, Procedure, Table, Trigger, View, CHECK Constraint, DEFAULT Definition Specifies that the quoted identifier setting for the object is ON, meaning double quotation marks delimit identifiers in all expressions involved in the object definition.
1 = ON
0 = OFF

IsReplProc Any Replication procedure.
1 = True
0 = False

IsRule Any Bound rule.
1 = True
0 = False

IsScalarFunction Function Scalar-valued function.
1 = Scalar-valued
0 = Table-valued
NULL = Not a function, or invalid object ID.

IsSchemaBound Function, View A schema bound function or view created with SCHEMABINDING.
1 = Schema-bound
0 = Not schema-bound
NULL = Not a function or a view, or invalid object ID.

IsSystemTable Table System table.
1 = True
0 = False

IsTable Table Table.
1 = True
0 = False

IsTableFunction Function Table-valued function.
1 = Table-valued
0 = Scalar-valued
NULL = Not a function, or invalid object ID.

IsTrigger Any Trigger.
1 = True
0 = False

IsUniqueCnst Any UNIQUE constraint.
1 = True
0 = False

IsUserTable Table User-defined table.
1 = True
0 = False

IsView View View.
1 = True
0 = False

OwnerId Any Owner of the object.
Nonnull = The database user ID of the object owner.
NULL = Invalid input.

TableDeleteTrigger Table Table has a DELETE trigger.
>1 = ID of first trigger with given type.

TableDeleteTriggerCount Table The table has the specified number of DELETE triggers.
>0 = The number of DELETE triggers.
NULL = Invalid input.

TableFullTextBackgroundUpdateIndexOn Table The table has full-text background update index enabled.
1 = TRUE
0 = FALSE

TableFulltextCatalogId Table The ID of the full-text catalog in which the full-text index data for the table resides.
Nonzero = Full-text catalog ID, associated with the unique index that identifies the rows in a full-text indexed table.
0 = Table is not full-text indexed.

TableFullTextChangeTrackingOn Table The table has full-text change-tracking enabled.
1 = TRUE
0 = FALSE

TableFulltextKeyColumn Table The ID of the column associated with the single-column unique index that is participating in the full-text index definition.
0 = Table is not full-text indexed.

TableFullTextPopulateStatus Table 0 = No population
1 = Full population
2 = Incremental population
TableHasActiveFulltextIndex  Table The table has an active full-text index.
1 = True
0 = False

TableHasCheckCnst Table The table has a CHECK constraint.
1 = True
0 = False

TableHasClustIndex Table The table has a clustered index.
1 = True
0 = False

TableHasDefaultCnst Table The table has a DEFAULT constraint.
1 = True
0 = False

TableHasDeleteTrigger Table The table has a DELETE trigger.
1 = True
0 = False

TableHasForeignKey Table The table has a FOREIGN KEY constraint.
1 = True
0 = False

TableHasForeignRef Table Table is referenced by a FOREIGN KEY constraint.
1 = True
0 = False

TableHasIdentity Table The table has an identity column.
1 = True
0 = False

TableHasIndex Table The table has an index of any type.
1 = True
0 = False

TableHasInsertTrigger Table The object has an Insert trigger.
1 = True
0 = False
NULL = Invalid input.

TableHasNonclustIndex Table The table has a nonclustered index.
1 = True
0 = False

TableHasPrimaryKey Table The table has a primary key.
1 = True
0 = False

TableHasRowGuidCol Table The table has a ROWGUIDCOL for a uniqueidentifier column.
1 = True
0 = False

TableHasTextImage Table The table has a text column.
1 = True
0 = False

TableHasTimestamp Table The table has a timestamp column.
1 = True
0 = False

TableHasUniqueCnst Table The table has a UNIQUE constraint.
1 = True
0 = False

TableHasUpdateTrigger Table The object has an Update trigger.
1 = True
0 = False

TableInsertTrigger Table The table has an INSERT trigger.
>1 = ID of first trigger with given type.

TableInsertTriggerCount  Table The table has the specified number of INSERT triggers.
>0 = The number of INSERT triggers.
NULL = Invalid input.

TableIsFake Table The table is not real. It is materialized internally on demand by SQL Server.
1 = True
0 = False

TableIsLockedOnBulkLoad Table The table is locked due to a BCP or BULK INSERT job.
1 = True
0 = False

TableIsPinned Table The table is pinned to be held in the data cache.
1 = True
0 = False

TableTextInRowLimit Table The maximum bytes allowed for text in row, or 0 if text in row option is not set.
TableUpdateTrigger Table The table has an UPDATE trigger.
>1 = ID of first trigger with given type.

TableUpdateTriggerCount  Table The table has the specified number of UPDATE triggers.
>0 = The number of UPDATE triggers.
NULL = Invalid input.



/*-----   Select all user and system tables from database   -----*/

SELECT
	CAST(OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
	CAST(COL.NAME AS VARCHAR(30)) AS COLUMN_NAME,
	--CAST(TYPE.NAME AS VARCHAR(16)) AS DB_TYPE,
	DATA_TYPE =
	CASE TYPE.NAME
		WHEN 'bit' THEN CAST(TYPE.NAME AS VARCHAR(20))
		WHEN 'varchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'nvarchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'decimal' THEN CAST(TYPE.NAME + '(' + CAST(COL.PREC AS VARCHAR(3)) + ', ' + CAST(COL.SCALE AS VARCHAR(3)) + ')' AS VARCHAR(20))
		ELSE CAST(TYPE.NAME AS VARCHAR(20))
	END,
	--COL.LENGTH,
	--COL.PREC,
	--COL.SCALE,
	NULLABLE =
	CASE COL.ISNULLABLE
		WHEN 0 THEN 'NO'
		WHEN 1 THEN 'YES'
		ELSE 'UNKNOWN'
	END,
	CASE OBJ.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END
	AS OBJECT_TYPE
--	,OBJ.CATEGORY
	FROM
		SYSOBJECTS AS OBJ
			INNER JOIN SYSCOLUMNS AS COL
				ON OBJ.ID = COL.ID
			INNER JOIN SYSTYPES AS TYPE
				ON COL.XTYPE = TYPE.XTYPE
		WHERE
			OBJ.xtype in ('U')
			AND OBJ.NAME LIKE '%'
			ORDER BY
				OBJ.xtype,
				OBJ.NAME,
				COL.COLORDER;
GO




/*-----   Select all View from database   -----*/
SELECT
	CAST(OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
	CAST(COL.NAME AS VARCHAR(30)) AS COLUMN_NAME,
	--CAST(TYPE.NAME AS VARCHAR(16)) AS DB_TYPE,
	DATA_TYPE =
	CASE TYPE.NAME
		WHEN 'bit' THEN CAST(TYPE.NAME AS VARCHAR(20))
		WHEN 'varchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'nvarchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'decimal' THEN CAST(TYPE.NAME + '(' + CAST(COL.PREC AS VARCHAR(3)) + ', ' + CAST(COL.SCALE AS VARCHAR(3)) + ')' AS VARCHAR(20))
		ELSE CAST(TYPE.NAME AS VARCHAR(20))
	END,
	--COL.LENGTH,
	--COL.PREC,
	--COL.SCALE,
	NULLABLE =
	CASE COL.ISNULLABLE
		WHEN 0 THEN 'NO'
		WHEN 1 THEN 'YES'
		ELSE 'UNKNOWN'
	END,
	CASE OBJ.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END
	AS OBJECT_TYPE
	FROM
		SYSOBJECTS AS OBJ
			INNER JOIN SYSCOLUMNS AS COL
				ON OBJ.ID = COL.ID
			INNER JOIN SYSTYPES AS TYPE
				ON COL.XTYPE = TYPE.XTYPE
		WHERE
			OBJ.xtype in ('V')
			AND OBJ.NAME LIKE '%%'
			ORDER BY
				OBJ.xtype,
				OBJ.NAME,
				COL.COLORDER;
GO




/*-----   Select all Trigger from database   -----*/

SELECT * FROM SYSOBJECTS WHERE XTYPE = 'TR'
GO

SELECT
	CAST(OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
	CAST(COL.NAME AS VARCHAR(30)) AS COLUMN_NAME,
	CAST(TYPE.NAME AS VARCHAR(16)) AS DB_TYPE,
	COL.LENGTH,
	COL.PREC,
	COL.SCALE,
	NULLABLE =
	CASE COL.ISNULLABLE
		WHEN 0 THEN 'NO'
		WHEN 1 THEN 'YES'
		ELSE 'UNKNOWN'
	END,
	CASE OBJ.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END
	FROM
		SYSOBJECTS AS OBJ
			INNER JOIN SYSCOLUMNS AS COL
				ON OBJ.ID = COL.ID
			INNER JOIN SYSTYPES AS TYPE
				ON COL.XTYPE = TYPE.XTYPE
		WHERE
			OBJ.xtype in ('TR')
			AND OBJ.NAME LIKE '%%'
			ORDER BY
				OBJ.xtype,
				OBJ.NAME,
				COL.COLORDER
GO



/*-----   LIST all CONSTRAINTS IN database   -----*/

SELECT DISTINCT
	--CONS.ID CONSTRAINT_ID,
	--CONS.ID CONSTRAINT_ID,
	CAST(OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
	CAST(CONS_OBJ.NAME AS VARCHAR(30)) AS CONSTRAINT_NAME,
	CASE CONS_OBJ.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END
	AS CONSTRAINT_TYPE
	FROM
		SYSCONSTRAINTS AS CONS
			INNER JOIN SYSOBJECTS AS OBJ
				ON CONS.ID = OBJ.ID
			INNER JOIN SYSOBJECTS AS CONS_OBJ
				ON OBJ.ID = CONS_OBJ.PARENT_OBJ
			INNER JOIN SYSFOREIGNKEYS AS FK_CONS
				ON FK_CONS.constid = CONS.constid
		WHERE
			CONS_OBJ.xtype in ('PK', 'F', 'UQ')
			--AND OBJ.NAME LIKE '%ACL_RIGHTS_RELATION%'
			ORDER BY TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE;
GO

SELECT
	--CONS.*,
	--FK_CONS.*,
	--F_OBJ.*,
	--R_OBJ.*,
	--FK_CONS.NAME,
	CAST(F_OBJ.NAME + '.' + F_COL.NAME AS VARCHAR(70)) AS TABLES,
	CAST(R_OBJ.NAME + '.' + R_COL.NAME AS VARCHAR(70)) AS REF_TABLES,
	CAST(CONS_OBJ.NAME AS VARCHAR(30)) AS CONSTRAINTS_NAME
	FROM
		SYSCONSTRAINTS AS CONS
		INNER JOIN SYSFOREIGNKEYS AS FK_CONS
			ON CONS.CONSTID = FK_CONS.CONSTID
		INNER JOIN SYSOBJECTS AS CONS_OBJ
			ON CONS.CONSTID = CONS_OBJ.ID
		INNER JOIN SYSOBJECTS AS F_OBJ
				ON FK_CONS.FKEYID = F_OBJ.ID
		INNER JOIN SYSOBJECTS AS R_OBJ
			ON FK_CONS.RKEYID = R_OBJ.ID
		INNER JOIN SYSCOLUMNS AS F_COL
			ON FK_CONS.fkeyid = F_COL.ID AND FK_CONS.fkey = F_COL.COLID
		INNER JOIN SYSCOLUMNS AS R_COL
			ON FK_CONS.Rkeyid = R_COL.ID AND FK_CONS.Rkey = R_COL.COLID
		ORDER BY TABLES;
GO

SELECT * FROM SYSOBJECTS WHERE parent_obj = '1049770797';
SELECT * FROM SYSCONSTRAINTS WHERE ID = '1161771196';

SELECT
	CONS.*,
	--FK_CONS.*,
	--F_OBJ.*,
	--R_OBJ.*,
	CONS_OBJ.*
	FROM
		SYSCONSTRAINTS AS CONS
		INNER JOIN SYSFOREIGNKEYS AS FK_CONS
			ON CONS.CONSTID = FK_CONS.CONSTID
		LEFT JOIN SYSOBJECTS AS CONS_OBJ
			ON CONS.ID = CONS_OBJ.PARENT_OBJ;
GO

SELECT
	OBJ.*,
	--FK_CONS.*,
	--F_OBJ.*,
	--R_OBJ.*,
	PAR_OBJ.*
	FROM
		SYSOBJECTS AS OBJ
		INNER JOIN SYSOBJECTS AS PAR_OBJ
			ON OBJ.ID = PAR_OBJ.PARENT_OBJ;
GO

SELECT * FROM SYSCONSTRAINTS;
GO

SELECT * FROM SYSOBJECTS AS OBJ INNER JOIN SYSCOLUMNS AS COL ON OBJ.ID = COL.ID WHERE OBJ.NAME LIKE 'GEN%';
GO


/*------------------------------------------------------------
||	TABLE		:	SYSINDEXES
||	DESCRIPTION	:	LIST ALL INDEXES
------------------------------------------------------------*/

SELECT
        TABLE_NAME = SUBSTRING(OBJECT_NAME(i.id), 1, 25),
        INDEX_NAME = SUBSTRING(i.name, 1, 35),
        IS_CLUSTERED = INDEXPROPERTY(i.id, i.name, 'IsClustered'),
        IS_UNIQUE = INDEXPROPERTY(i.id, i.name, 'IsUnique'),
        ROWS = I.ROWS,
        FILE_GROUP = g.GroupName
    FROM
        SYSINDEXES I
	    INNER JOIN SYSFILEGROUPS G
		    ON I.GROUPID = G.GROUPID
    WHERE
        (i.indid BETWEEN 1 AND 254)
        -- leave out AUTO_STATISTICS:
        AND (i.Status & 64)=0
        -- leave out system tables:
        AND OBJECTPROPERTY(i.id, 'IsMsShipped') = 0
        ORDER BY
        	TABLE_NAME;
GO




/*-----   Select all USER Procedure from database   -----*/

SELECT
	CAST(OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
	CAST(COL.NAME AS VARCHAR(30)) AS COLUMN_NAME,
	--CAST(TYPE.NAME AS VARCHAR(16)) AS DB_TYPE,
	DIRECTION =
	CASE COL.ISOUTPARAM
		WHEN 1 THEN 'OUT'
		ELSE 'IN'
	END,
	DATA_TYPE =
	CASE TYPE.NAME
		WHEN 'bit' THEN CAST(TYPE.NAME AS VARCHAR(20))
		WHEN 'varchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'nvarchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'decimal' THEN CAST(TYPE.NAME + '(' + CAST(COL.PREC AS VARCHAR(3)) + ', ' + CAST(COL.SCALE AS VARCHAR(3)) + ')' AS VARCHAR(20))
		ELSE CAST(TYPE.NAME AS VARCHAR(20))
	END,
	--COL.LENGTH,
	--COL.PREC,
	--COL.SCALE,
	NULLABLE =
	CASE COL.ISNULLABLE
		WHEN 0 THEN 'NO'
		WHEN 1 THEN 'YES'
		ELSE 'UNKNOWN'
	END,
	CASE OBJ.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END
	AS OBJECT_TYPE
--	,OBJ.CATEGORY
	FROM
		SYSOBJECTS AS OBJ
			INNER JOIN SYSCOLUMNS AS COL
				ON OBJ.ID = COL.ID
			INNER JOIN SYSTYPES AS TYPE
				ON COL.XTYPE = TYPE.XTYPE
		WHERE
			OBJ.xtype in ('P')
			AND OBJ.CATEGORY <> 2
			AND OBJ.NAME LIKE '%%'
			ORDER BY
				OBJ.xtype,
				OBJ.NAME,
				COL.COLORDER
GO


/*-----   LIST all Primary Key IN database   -----*/
SELECT DISTINCT
	CAST(OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
	CAST(CONS_OBJ.NAME AS VARCHAR(30)) AS CONSTRAINT_NAME,
	CONS.ID
	FROM
		SYSCONSTRAINTS AS CONS
			INNER JOIN SYSOBJECTS AS OBJ
				ON CONS.ID = OBJ.ID
			INNER JOIN SYSOBJECTS AS CONS_OBJ
				ON OBJ.ID = CONS_OBJ.PARENT_OBJ
		WHERE
			CONS_OBJ.xtype in ('PK')
			ORDER BY TABLE_NAME, CONSTRAINT_NAME;
GO


/*-----   LIST all FOREIGN Key CONSTRAINTS IN database   -----*/

SELECT
	--CONS.*,
	--FK_CONS.*,
	--F_OBJ.*,
	--R_OBJ.*,
	--FK_CONS.NAME,
	CAST(CONS_OBJ.NAME AS VARCHAR(30)) AS CONSTRAINTS_NAME,
	CAST(F_OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
	CAST(F_OBJ.NAME + '.' + F_COL.NAME AS VARCHAR(70)) AS FOREIGN_KEY_TABLES,
	CAST(R_OBJ.NAME + '.' + R_COL.NAME AS VARCHAR(70)) AS REF_TABLES
	FROM
		SYSCONSTRAINTS AS CONS
		INNER JOIN SYSFOREIGNKEYS AS FK_CONS
			ON CONS.CONSTID = FK_CONS.CONSTID
		INNER JOIN SYSOBJECTS AS CONS_OBJ
			ON CONS.CONSTID = CONS_OBJ.ID
		INNER JOIN SYSOBJECTS AS F_OBJ
				ON FK_CONS.FKEYID = F_OBJ.ID
		INNER JOIN SYSOBJECTS AS R_OBJ
			ON FK_CONS.RKEYID = R_OBJ.ID
		INNER JOIN SYSCOLUMNS AS F_COL
			ON FK_CONS.fkeyid = F_COL.ID AND FK_CONS.fkey = F_COL.COLID
		INNER JOIN SYSCOLUMNS AS R_COL
			ON FK_CONS.Rkeyid = R_COL.ID AND FK_CONS.Rkey = R_COL.COLID
		ORDER BY FOREIGN_KEY_TABLES;
GO




/*-----   xtype Definition   -----*/
Object type. Can be one of these object types:
C	= CHECK constraint
D	= Default or DEFAULT constraint
F	= FOREIGN KEY constraint
L	= Log
FN	= Scalar function
IF	= Inlined table-function
P	= Stored procedure
PK	= PRIMARY KEY constraint (type is K)
RF	= Replication filter stored procedure
S	= System table
TF	= Table function
TR	= Trigger
U	= User table
UQ	= UNIQUE constraint (type is K)
V	= View
X	= Extended stored procedure




/*-----   LIST ALL Procedure in database   -----*/
SELECT
	CAST(OBJ.NAME AS VARCHAR(35)) AS TABLE_NAME,
	CAST(COL.NAME AS VARCHAR(25)) AS COLUMN_NAME,
	CAST(TYPE.NAME AS VARCHAR(15)) AS PARAMETER_TYPE,
	COL.LENGTH,
	COL.PREC,
	COL.SCALE,
	COL.ISNULLABLE,
	OBJ.xtype
	FROM SYSOBJECTS AS OBJ
		INNER JOIN SYSCOLUMNS AS COL ON OBJ.ID = COL.ID
		INNER JOIN SYSTYPES AS TYPE ON COL.XTYPE = TYPE.XTYPE
		WHERE OBJ.xtype in ('P')
			AND OBJ.NAME LIKE '%'
			ORDER BY
				OBJ.NAME,
				COL.NAME;
GO

SELECT COM.TEXT
	FROM SYSOBJECTS AS OBJ
		INNER JOIN SYSCOMMENTS AS COM ON OBJ.ID = COM.ID
		WHERE OBJ.xtype in ('P')
			AND OBJ.NAME LIKE 'UPDATE_TRANSACTION%'
			ORDER BY OBJ.NAME;
GO

SELECT OBJ.NAME
	FROM SYSOBJECTS AS OBJ
		INNER JOIN SYSCOMMENTS AS COM ON OBJ.ID = COM.ID
		WHERE OBJ.xtype in ('P')
			AND OBJ.NAME LIKE '%%'
			ORDER BY OBJ.NAME;
GO


/*
||	GENERATE INDEX QUERY
*/

SELECT 'SP_HELPINDEX ' + NAME + ';' FROM SYSOBJECTS WHERE XTYPE='U' ORDER BY NAME;
GO




/*
||	LIST ALL TRIGGERS IN DATABASE
*/

SELECT
	"TABLE"=CAST(P.NAME AS VARCHAR(30)),
	"TRIGGER NAME"=CAST(O.NAME AS VARCHAR(40)),
	"TRIGGER DATE"=O.REFDATE,
--	"DEFN"=CASE C.ENCRYPTED WHEN 0 THEN C.TEXT ELSE '<< ENCRYPTED >>' END,
	STATUS = CASE WHEN OBJECTPROPERTY (O.ID, 'ExecIsTriggerDisabled') = 0 THEN 'ENABLED' ELSE 'DISABLED' END
	FROM
		SYSCOMMENTS C
		INNER JOIN SYSOBJECTS O ON (C.ID = O.ID)
		INNER JOIN SYSOBJECTS P ON (O.PARENT_OBJ = P.ID)
			WHERE
				O.XTYPE = 'TR'
				AND P.XTYPE = 'U'
				ORDER BY P.NAME, O.NAME;
GO

ALTER TABLE TABLE_NAME DISABLE TRIGGER TRIGGER_NAME;
GO




/*
||	INFORMATION_SCHEMA
*/

SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS
GO

SELECT
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	CAST(COLUMN_NAME AS VARCHAR(35)) AS COLUMN_NAME,
	CAST(DATA_TYPE AS VARCHAR(20)) AS DATA_TYPE,
	CASE
		WHEN CHARACTER_MAXIMUM_LENGTH IS NULL THEN ''
		ELSE CHARACTER_MAXIMUM_LENGTH
	END AS MAXIMUM_LENGTH,
	IS_NULLABLE AS 'NULLABLE',
	CASE
		WHEN COLUMN_DEFAULT IS NULL THEN ''
		ELSE CAST(COLUMN_DEFAULT AS VARCHAR(50))
	END AS COLUMN_DEFAULT,
	TABLE_CATALOG,
	TABLE_SCHEMA,
	ORDINAL_POSITION,
	CHARACTER_OCTET_LENGTH,
	NUMERIC_PRECISION,
	NUMERIC_PRECISION_RADIX,
	NUMERIC_SCALE,
	DATETIME_PRECISION,
	CHARACTER_SET_CATALOG,
	CHARACTER_SET_SCHEMA,
	CHARACTER_SET_NAME,
	COLLATION_CATALOG,
	COLLATION_SCHEMA,
	COLLATION_NAME,
	DOMAIN_CATALOG,
	DOMAIN_SCHEMA,
	DOMAIN_NAME
	FROM
		INFORMATION_SCHEMA.COLUMNS
		ORDER BY
			TABLE_NAME,
			ORDINAL_POSITION;
GO


/*-----   INFORMATION_SCHEMA.COLUMN_DOMAIN_USAGE   -----*/

SELECT * FROM INFORMATION_SCHEMA.COLUMN_DOMAIN_USAGE;
GO


/*-----   INFORMATION_SCHEMA.COLUMN_PRIVILEGES   -----*/

SELECT * FROM INFORMATION_SCHEMA.COLUMN_PRIVILEGES
GO

SELECT
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	CAST(COLUMN_NAME AS VARCHAR(35)) AS COLUMN_NAME,
	PRIVILEGE_TYPE,
	GRANTEE,
	GRANTOR,
	TABLE_CATALOG,
	TABLE_SCHEMA,
	IS_GRANTABLE
	FROM
		INFORMATION_SCHEMA.COLUMN_PRIVILEGES
GO


/*-----   INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE   -----*/

SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
GO

SELECT
	CAST(CONSTRAINT_NAME AS VARCHAR(35)) AS CONSTRAINT_NAME,
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	CAST(COLUMN_NAME AS VARCHAR(35)) AS COLUMN_NAME,
	CONSTRAINT_CATALOG,
	CONSTRAINT_SCHEMA
	FROM
		INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
		WHERE
			CONSTRAINT_NAME LIKE '%FK_FM_CAT_RELATION_FM_CATEGORY%'
		ORDER BY
			CONSTRAINT_NAME,
			TABLE_NAME,
			COLUMN_NAME
GO


/*-----   INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE   -----*/

SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
GO


/*-----   INFORMATION_SCHEMA.DOMAINS   -----*/

SELECT * FROM INFORMATION_SCHEMA.DOMAINS
GO


/*-----   INFORMATION_SCHEMA.DOMAIN_CONSTRAINTS   -----*/

SELECT * FROM INFORMATION_SCHEMA.DOMAIN_CONSTRAINTS
GO


/*-----   INFORMATION_SCHEMA.KEY_COLUMN_USAGE   -----*/

SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
GO


/*-----   INFORMATION_SCHEMA.PARAMETERS   -----*/

SELECT
	CAST(SPECIFIC_NAME AS VARCHAR(35)) AS SPECIFIC_NAME,
	CAST(PARAMETER_NAME AS VARCHAR(35)) AS PARAMETER_NAME,
	CAST(DATA_TYPE AS VARCHAR(20)) AS DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH,
	PARAMETER_MODE,
	CAST(SPECIFIC_CATALOG AS VARCHAR(35)) AS SPECIFIC_CATALOG,
	SPECIFIC_SCHEMA,
	ORDINAL_POSITION,
	IS_RESULT,
	AS_LOCATOR,
	CHARACTER_OCTET_LENGTH,
	COLLATION_CATALOG,
	COLLATION_SCHEMA,
	COLLATION_NAME,
	CHARACTER_SET_CATALOG,
	CHARACTER_SET_SCHEMA,
	CHARACTER_SET_NAME,
	NUMERIC_PRECISION,
	NUMERIC_PRECISION_RADIX,
	NUMERIC_SCALE,
	DATETIME_PRECISION,
	INTERVAL_TYPE,
	INTERVAL_PRECISION,
	USER_DEFINED_TYPE_CATALOG,
	USER_DEFINED_TYPE_SCHEMA,
	USER_DEFINED_TYPE_NAME,
	SCOPE_CATALOG,
	SCOPE_SCHEMA,
	SCOPE_NAME
	FROM
		INFORMATION_SCHEMA.PARAMETERS
		ORDER BY
			SPECIFIC_NAME,
			ORDINAL_POSITION;
GO


/*-----   INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS   -----*/

SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS;
GO


/*-----   INFORMATION_SCHEMA.ROUTINES   -----*/

SELECT
	CAST(SPECIFIC_NAME AS VARCHAR(35)) AS SPECIFIC_NAME,
	ROUTINE_TYPE,
	CREATED,
	LAST_ALTERED,
	SPECIFIC_CATALOG,
	SPECIFIC_SCHEMA,
	ROUTINE_CATALOG,
	ROUTINE_SCHEMA,
	ROUTINE_NAME,
	MODULE_CATALOG,
	MODULE_SCHEMA,
	MODULE_NAME,
	UDT_CATALOG,
	UDT_SCHEMA,
	UDT_NAME,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH,
	CHARACTER_OCTET_LENGTH,
	COLLATION_CATALOG,
	COLLATION_SCHEMA,
	COLLATION_NAME,
	CHARACTER_SET_CATALOG,
	CHARACTER_SET_SCHEMA,
	CHARACTER_SET_NAME,
	NUMERIC_PRECISION,
	NUMERIC_PRECISION_RADIX,
	NUMERIC_SCALE,
	DATETIME_PRECISION,
	INTERVAL_TYPE,
	INTERVAL_PRECISION,
	TYPE_UDT_CATALOG,
	TYPE_UDT_SCHEMA,
	TYPE_UDT_NAME,
	SCOPE_CATALOG,
	SCOPE_SCHEMA,
	SCOPE_NAME,
	MAXIMUM_CARDINALITY,
	DTD_IDENTIFIER,
	ROUTINE_BODY,
	--ROUTINE_DEFINITION,
	EXTERNAL_NAME,
	EXTERNAL_LANGUAGE,
	PARAMETER_STYLE,
	IS_DETERMINISTIC,
	SQL_DATA_ACCESS,
	IS_NULL_CALL,
	SQL_PATH,
	SCHEMA_LEVEL_ROUTINE,
	MAX_DYNAMIC_RESULT_SETS,
	IS_USER_DEFINED_CAST,
	IS_IMPLICITLY_INVOCABLE
	FROM
		INFORMATION_SCHEMA.ROUTINES

SELECT
	ROUTINE_DEFINITION
	FROM
		INFORMATION_SCHEMA.ROUTINES
		WHERE
			SPECIFIC_NAME = '';
GO


/*-----   INFORMATION_SCHEMA.ROUTINE_COLUMNS   -----*/

SELECT * FROM INFORMATION_SCHEMA.ROUTINE_COLUMNS
GO


/*-----   INFORMATION_SCHEMA.SCHEMATA   -----*/

SELECT * FROM INFORMATION_SCHEMA.SCHEMATA
GO


/*-----   INFORMATION_SCHEMA.TABLES   -----*/

SELECT
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	TABLE_TYPE,
	TABLE_CATALOG,
	TABLE_SCHEMA
	FROM
		INFORMATION_SCHEMA.TABLES
		ORDER BY
			TABLE_CATALOG,
			TABLE_TYPE,
			TABLE_NAME
GO


/*-----   INFORMATION_SCHEMA.TABLE_CONSTRAINTS   -----*/

SELECT
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	CONSTRAINT_TYPE,
	CAST(CONSTRAINT_NAME AS VARCHAR(70)) AS CONSTRAINT_NAME,
	IS_DEFERRABLE,
	CONSTRAINT_CATALOG,
	CONSTRAINT_SCHEMA,
	TABLE_CATALOG,
	TABLE_SCHEMA,
	INITIALLY_DEFERRED
	FROM
		INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		ORDER BY
			TABLE_NAME,
			CONSTRAINT_TYPE DESC;
GO


/*------------------------------------------------------------
||	TABLE		:	INFORMATION_SCHEMA.TABLE_PRIVILEGES
||	DESCRIPTION	:	GET TABLE PRIVILEGES BY TABLE NAME
------------------------------------------------------------*/

SELECT
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	CAST(GRANTEE AS VARCHAR(35)) AS GRANTEE,
	PRIVILEGE_TYPE,
	CAST(TABLE_CATALOG AS VARCHAR(20)) AS TABLE_CATALOG,
	CAST(GRANTOR AS VARCHAR(20)) AS GRANTOR,
	CAST(TABLE_SCHEMA AS VARCHAR(20)) AS TABLE_SCHEMA,
	IS_GRANTABLE
	FROM
		INFORMATION_SCHEMA.TABLE_PRIVILEGES
		ORDER BY TABLE_NAME;
GO


/*------------------------------------------------------------
||	TABLE		:	INFORMATION_SCHEMA.TABLE_PRIVILEGES
||	DESCRIPTION	:	GET TABLE PRIVILEGES BY TABLE NAME
------------------------------------------------------------*/

SELECT
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	CAST(GRANTEE AS VARCHAR(35)) AS GRANTEE,
	PRIVILEGE_TYPE,
	CAST(TABLE_CATALOG AS VARCHAR(20)) AS TABLE_CATALOG,
	IS_GRANTABLE
	FROM
		INFORMATION_SCHEMA.TABLE_PRIVILEGES
		ORDER BY TABLE_NAME;
GO


/*------------------------------------------------------------
||	TABLE		:	INFORMATION_SCHEMA.TABLE_PRIVILEGES
||	DESCRIPTION	:	GET TABLE PRIVILEGES BY USER NAME
------------------------------------------------------------*/

SELECT
	CAST(GRANTEE AS VARCHAR(35)) AS GRANTEE,
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	PRIVILEGE_TYPE,
	CAST(TABLE_CATALOG AS VARCHAR(20)) AS TABLE_CATALOG,
	IS_GRANTABLE
	FROM
		INFORMATION_SCHEMA.TABLE_PRIVILEGES
		ORDER BY GRANTEE, TABLE_NAME;
GO


/*-----   INFORMATION_SCHEMA.VIEWS   -----*/

SELECT * FROM INFORMATION_SCHEMA.VIEWS
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS ORDER BY TABLE_NAME
GO


/*------------------------------------------------------------
||	TABLE		:	INFORMATION_SCHEMA.VIEW_COLUMN_USAGE
||	DESCRIPTION	:	LIST ALL TABLE AND COLUMN USE IN THE VIEW
------------------------------------------------------------*/

SELECT * FROM INFORMATION_SCHEMA.VIEW_COLUMN_USAGE
GO

SELECT
	CAST(VIEW_NAME AS VARCHAR(35)) AS VIEW_NAME,
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	CAST(COLUMN_NAME AS VARCHAR(35)) AS COLUMN_NAME,
	TABLE_CATALOG,
	TABLE_SCHEMA
	FROM
		INFORMATION_SCHEMA.VIEW_COLUMN_USAGE
		ORDER BY
			VIEW_NAME,
			TABLE_NAME,
			COLUMN_NAME
GO


/*------------------------------------------------------------
||	TABLE		:	INFORMATION_SCHEMA.VIEW_TABLE_USAGE
||	DESCRIPTION	:	LIST ALL TABLE AND COLUMN USE IN THE VIEW
------------------------------------------------------------*/

SELECT * FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
GO

SELECT
	CAST(VIEW_NAME AS VARCHAR(35)) AS VIEW_NAME,
	CAST(TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	TABLE_CATALOG,
	TABLE_SCHEMA,
	VIEW_CATALOG,
	VIEW_SCHEMA
	FROM
		INFORMATION_SCHEMA.VIEW_TABLE_USAGE
GO



/*-----   INFORMATION_SCHEMA TABLE PRIVILEGES   -----*/

SELECT
	T.TABLE_TYPE,
	CAST(T.TABLE_NAME AS VARCHAR(35)) AS TABLE_NAME,
	CASE
		WHEN TP.GRANTEE IS NULL THEN ''
		ELSE CAST(TP.GRANTEE AS VARCHAR(35))
	END AS GRANTEE,
	CASE
		WHEN TP.PRIVILEGE_TYPE IS NULL THEN ''
		ELSE TP.PRIVILEGE_TYPE
	END AS PRIVILEGE_TYPE,
	CASE
		WHEN TP.GRANTOR IS NULL THEN ''
		ELSE CAST(TP.GRANTOR AS VARCHAR(20))
	END AS GRANTOR,
	T.TABLE_CATALOG,
	T.TABLE_SCHEMA
	FROM
		INFORMATION_SCHEMA.TABLES AS T
			LEFT JOIN INFORMATION_SCHEMA.TABLE_PRIVILEGES AS TP
				ON T.TABLE_NAME = TP.TABLE_NAME
		ORDER BY
			T.TABLE_CATALOG,
			T.TABLE_TYPE,
			T.TABLE_NAME,
			TP.GRANTEE,
			TP.PRIVILEGE_TYPE;
GO













CHECK_CONSTRAINTS		Contains one row for each CHECK constraint in the current database

COLUMN_DOMAIN_USAGE		Contains one row for each column
in the current database
that has a user-defined data type.

COLUMN_PRIVILEGES		Contains one row for each column with a privilege either granted to or by the current user in the current database

COLUMNS					Contains one row for each column accessible to the current user in the current database.

CONSTRAINT_COLUMN_USAGE	Contains one row for each column
in the current database
that has a constraint defined on it.

CONSTRAINT_TABLE_USAGE	Contains one row for each table
in the current database
that has a constraint defined on it.

DOMAIN_CONSTRAINTS		Contains one row for each user-defined data type
accessible to the current user in the current database
with a rule bound to it

DOMAINS					Contains one row for each user-defined data type accessible to the current user in the current database

KEY_COLUMN_USAGE		Contains one row for each column
in the current database
that is constrained as a key

PARAMETERS				Contains one row for each parameter of a user-defined function or stored procedure accessible to the current user in the current database.

REFERENTIAL_CONSTRAINTS	Contains one row for each foreign constraint in the current database. This information schema view returns information about the objects to which the current user has permissions.

ROUTINE_COLUMNS			Contains one row for each column returned by the table-valued functions accessible to the current user in the current database

ROUTINES				Contains one row for each stored procedure and function accessible to the current user in the current database.

SCHEMATA				Contains one row for each database that has permissions for the current user

TABLE_CONSTRAINTS		Contains one row for each table constraint in the current database.

TABLE_PRIVILEGES		Contains one row for each table privilege granted to or by the current user in the current database

TABLES					Contains one row for each table in the current database for which the current user has permissions

VIEW_COLUMN_USAGE		Contains one row for each column
in the current database
used in a view definition

VIEW_TABLE_USAGE		Contains one row for each table
in the current database
used in a view

VIEWS					Contains one row for views accessible to the current user in the current database





/*-----   LIST SYSUSERS   -----*/

SELECT * FROM SYSUSERS;
GO





/*-----   CHECK SYSPERMISSIONS   -----*/

DECLARE @object_id INT
DECLARE @object_name VARCHAR(40)
DECLARE @object_type CHAR(2)
DECLARE @check_message VARCHAR(250)
DECLARE @RECORD_COUNT INT

DECLARE tnames_cursor CURSOR FOR
	SELECT id, name, type FROM sysobjects
		WHERE type IN ('U','P', 'FN','V')
		ORDER BY 2, 1
OPEN tnames_cursor
FETCH NEXT FROM tnames_cursor INTO @object_id, @object_name, @object_type
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN
		SELECT @check_message = CHAR(10) + CHAR(10) + "Checking permissions on "
			IF @object_type = 'U'
				SELECT @check_message = @check_message + 'Table '
			IF @object_type = 'V'
				SELECT @check_message = @check_message + 'View '
			IF @object_type = 'P'
				SELECT @check_message = @check_message + 'Stored Procedure '

		SELECT @RECORD_COUNT = COUNT(*) FROM SYSPERMISSIONS WHERE ID = @object_id

		IF (@RECORD_COUNT > 0)
		BEGIN
			SELECT @check_message = @check_message + RTRIM(UPPER(@object_name)) + CHAR(10)
			PRINT @check_message
			EXEC ("sp_helprotect " + @object_name )
		END
		ELSE
		BEGIN
			SELECT @check_message = @check_message + RTRIM(UPPER(@object_name)) + CHAR(10)
			SELECT @check_message = @check_message + '|*****   NO PERMISSION GRANTED   *****|' + CHAR(10)
			PRINT @check_message
		END
	END
	FETCH NEXT FROM tnames_cursor INTO @object_id, @object_name, @object_type
END
CLOSE tnames_cursor
DEALLOCATE tnames_cursor
GO



/*
||	CHECK PERMISSIONS FOR ALL DATABASE OBJECTS
*/

SELECT
	*, 'SELECT * FROM ' + OBJ_NAME + ';' SELECT_SQL
FROM
(
SELECT
	*, PERMISSION + ' ' + RIGHTS + ' ON ' + OBJ_NAME + ' TO ' + USER_NAME + ';' GRANT_SQL
FROM
(
SELECT
	U.NAME AS USER_NAME,
	PERMISSION =
	CASE R.protecttype
		WHEN 204 THEN 'GRANT_W_GRANT'
		WHEN 205 THEN 'GRANT'
		WHEN 206 THEN 'DENY'
		ELSE 'UNKNOWN'
	END,
	RIGHTS =
	CASE R.ACTION
		WHEN 26 THEN 'REFERENCES'
		WHEN 178 THEN 'CREATE FUNCTION'
		WHEN 193 THEN 'SELECT'
		WHEN 195 THEN 'INSERT'
		WHEN 196 THEN 'DELETE'
		WHEN 197 THEN 'UPDATE'
		WHEN 198 THEN 'CREATE TABLE'
		WHEN 203 THEN 'CREATE DATABASE'
		WHEN 207 THEN 'CREATE VIEW'
		WHEN 222 THEN 'CREATE PROCEDURE'
		WHEN 224 THEN 'EXECUTE'
		WHEN 228 THEN 'BACKUP DATABASE'
		WHEN 233 THEN 'CREATE DEFAULT'
		WHEN 235 THEN 'BACKUP LOG'
		WHEN 236 THEN 'CREATE RULE'
		ELSE 'UNKNOWN'
	END,
	O.NAME AS OBJ_NAME,
	OBJ_TYPE =
	CASE O.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END,
	U.UID AS USER_ID,  O.ID AS OBJ_ID, R.ACTION
	FROM
		SYSUSERS AS U INNER JOIN SYSPERMISSIONS AS P
			ON P.GRANTEE = U.UID
		RIGHT JOIN SYSOBJECTS AS O
			ON P.ID = O.ID
		LEFT JOIN SYSPROTECTS AS R
			ON R.UID = U.UID AND R.ID = O.ID
) T
WHERE USER_NAME NOT IN ( 'public' )
UNION
SELECT
	*
FROM
(
SELECT
	NULL AS USER_NAME,
	PERMISSION = NULL,
	RIGHTS = NULL,
	O.NAME AS OBJ_NAME,
	OBJ_TYPE =
	CASE O.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END,
	NULL AS USER_ID,  O.ID AS OBJ_ID, NULL AS ACTION,
	GRANT_SQL =
	CASE O.XTYPE
		WHEN 'FN' THEN 'GRANT EXECUTE ON ' + O.NAME + ' TO [BB_DBA_Role];'
		WHEN 'P' THEN 'GRANT EXECUTE ON ' + O.NAME + ' TO [BB_DBA_Role];'
		WHEN 'U' THEN 'GRANT SELECT, UPDATE, INSERT, DELETE ON ' + O.NAME + ' TO [BB_DBA_Role];'
		WHEN 'V' THEN 'GRANT SELECT ON ' + O.NAME + ' TO [BB_DBA_Role];'
		ELSE 'NO SQL STATEMENT'
	END
	FROM
		SYSOBJECTS AS O
		WHERE O.ID NOT IN (SELECT P.ID FROM SYSPERMISSIONS AS P) AND O.XTYPE IN ('FN', 'P', 'U', 'V')
) T
) V
ORDER BY USER_NAME, OBJ_TYPE, OBJ_NAME, ACTION;
GO



/*
||	CHECK PERMISSIONS FOR A TABLE
*/

EXEC sp_helprotect 'TABLE_NAME'
GO


/*
||	CHECK PERMISSIONS FOR A USER
*/

EXEC sp_helprotect NULL 'USERNAME'
GO


/*
||	LISTS ALL PERMISSIONS THAT WERE GRANTED BY USER JUDY IN THE CURRENT DATABASE
USING A NULL AS A PLACEHOLDER FOR THE MISSING PARAMETERS.
*/

EXEC sp_helprotect NULL, NULL, 'USERNAME'
GO

List the statement permissions only
This example lists all the statement permissions in the current database
using NULL as a placeholder for the missing parameters.

EXEC sp_helprotect NULL, NULL, NULL, 's'
GO









/*---------------------------------------
||	GENERATE TABLE CHECK
---------------------------------------*/

SELECT 'BEGIN' + CHAR(10) + CHAR(10) + 'DECLARE @REPORT_STR VARCHAR(2000)' + CHAR(10) + CHAR(10) + 'SET @REPORT_STR = '''';' + CHAR(10), 0 AS ROWNUM
UNION
SELECT 'IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[' + NAME + ']'') AND type in (N''U''))' + CHAR(10) + '    ' + 'SET @REPORT_STR = @REPORT_STR + CHAR(10) + ''***  TABLE [' + NAME + '] IS MISSING!  ***''', ROW_NUMBER() OVER (ORDER BY NAME) AS ROWNUM
	FROM SYSOBJECTS WHERE XTYPE = 'U' AND ( NAME LIKE 'PI_%' OR NAME LIKE 'GEN_%' )
UNION
SELECT CHAR(10) + CHAR(10) + 'IF(@REPORT_STR IS NULL OR LEN(@REPORT_STR) = 0)' + CHAR(10) + '    PRINT CHAR(10) + ''PI TABLE CHECK PASS'' + CHAR(10);' + CHAR(10) + 'ELSE' + CHAR(10) + '    ' + 'PRINT CHAR(10) + @REPORT_STR;' + CHAR(10) + 'END;' + CHAR(10), 99999 AS ROWNUM
		ORDER BY ROWNUM;
GO









/*---------------------------------------
||	GENERATE C# TableAdapters
---------------------------------------*/

SELECT '#region Table Adapter', 0 AS ROWNUM
UNION
SELECT 'private static SchemaTableAdapters.' + NAME + 'TableAdapter ' + NAME + 'TableAdapter = new SchemaTableAdapters.' + NAME + 'TableAdapter();', ROW_NUMBER() OVER (ORDER BY NAME) AS ROWNUM
	FROM SYSOBJECTS WHERE XTYPE = 'U'
UNION
SELECT '#endregion' + CHAR(10), 99999 AS ROWNUM
		ORDER BY ROWNUM;
GO




/*---------------------------------------
||	GENERATE C# Binding Source
---------------------------------------*/

SELECT '#region Table Adapters', 0 AS ROWNUM
UNION
SELECT
'private static SchemaTableAdapters.' + NAME + 'TableAdapter ' + NAME + 'TableAdapter = new SchemaTableAdapters.' + NAME + 'TableAdapter();' + CHAR(10)
 + 'private System.Windows.Forms.BindingSource _' + NAME + '_BS = new System.Windows.Forms.BindingSource();' + CHAR(10)
 + 'public System.Windows.Forms.BindingSource ' + NAME + '_BindingSource' + CHAR(10)
 + '{'
 + CHAR(9) + 'get' + CHAR(10)
 + CHAR(9) + '{' + CHAR(10)
 + CHAR(9) + CHAR(9) + '_' + NAME + '_BS.DataSource = this;' + CHAR(10)
 + CHAR(9) + CHAR(9) + '_' + NAME + '_BS.DataMember = this.' + NAME + '.TableName;' + CHAR(10)
 + CHAR(9) + CHAR(9) + 'return _' + NAME + '_BS;' + CHAR(10)
 + CHAR(9) + '}' + CHAR(10)
 + '}' + CHAR(10), ROW_NUMBER() OVER (ORDER BY NAME) AS ROWNUM
	FROM SYSOBJECTS WHERE XTYPE = 'U' and name not like 'sysdiagrams%'
UNION	
SELECT '#endregion' + CHAR(10), 99999 AS ROWNUM
		ORDER BY ROWNUM;
GO




/*---------------------------------------
||	GENERATE C# Save Class
---------------------------------------*/

SELECT '#region Main Class Function', -100 AS ROWNUM
UNION
SELECT 'public void Save()', -90 AS ROWNUM
UNION
SELECT '{', -80 AS ROWNUM
UNION
SELECT
CHAR(9) + 'if (this.' + NAME + '.GetChanges() != null && this.' + NAME + '.GetChanges().Rows.Count > 0) { ' + NAME + 'TableAdapter.Update(this); }' + CHAR(10)
+ CHAR(10), ROW_NUMBER() OVER (ORDER BY NAME) AS ROWNUM
	FROM SYSOBJECTS WHERE XTYPE = 'U' and name not like 'sysdiagrams%'
UNION
SELECT '}', 99989 AS ROWNUM
UNION
SELECT '#endregion' + CHAR(10), 99999 AS ROWNUM
		ORDER BY ROWNUM;
GO




/*---------------------------------------
||	GENERATE C# partial class DataTable
---------------------------------------*/

SELECT '#region Fill Table', 0 AS ROWNUM
UNION
SELECT
'partial class ' + NAME + 'DataTable' + CHAR(10)
 + '{'
 + CHAR(9) + 'public void Fill()' + CHAR(10)
 + CHAR(9) + '{' + CHAR(10)
 + CHAR(9) + CHAR(9) + NAME + 'TableAdapter.Fill(this);' + CHAR(10)
 + CHAR(9) + '}' + CHAR(10)
 + CHAR(10)
 + CHAR(9) + 'public void Save()' + CHAR(10)
 + CHAR(9) + '{' + CHAR(10)
 + CHAR(9) + CHAR(9) + NAME + 'TableAdapter.Update(this);' + CHAR(10)
 + CHAR(9) + '}' + CHAR(10)
 + '}' + CHAR(10), ROW_NUMBER() OVER (ORDER BY NAME) AS ROWNUM
	FROM SYSOBJECTS WHERE XTYPE = 'U' and name not like 'sysdiagrams%'
UNION
SELECT '#endregion' + CHAR(10), 99999 AS ROWNUM
		ORDER BY ROWNUM;
GO




/*---------------------------------------
||	GENERATE C# partial class DataTable
---------------------------------------*/

SELECT '#region Fill Table', 0 AS ROWNUM
UNION
SELECT
'public void Fill_' + NAME + '()' + CHAR(10)
 + '{'
 + CHAR(9) + '_SYSDB.' + NAME + '.Fill();' + CHAR(10)
 + '}' + CHAR(10), ROW_NUMBER() OVER (ORDER BY NAME) AS ROWNUM
	FROM SYSOBJECTS WHERE XTYPE = 'U' and name not like 'sysdiagrams%'
UNION
SELECT '#endregion' + CHAR(10), 99999 AS ROWNUM
		ORDER BY ROWNUM;
GO







CREATE PROCEDURE sp_helprotect
	@name				ncharacter varying(776)  = NULL
	,@username			sysname  = NULL
	,@grantorname		sysname  = NULL
	,@permissionarea	character varying(10)  = 'o s'
as

/********
Explanation of the parms...
---------------------------
@name:  Name of [Owner.]Object and Statement; meaning
for sysprotects.id and sysprotects.action at the
same time; thus see parm @permissionarea.
   Examples-   'user2.tb'
'CREATE TABLE'
null

@username:  Name of the grantee (for sysprotects.uid).
   Examples-   'user2'
null

@grantorname:  Name of the grantor (for sysprotects.grantor).
   Examples-   'user2' --Would prevent report rows which would
                       --  have 'dbo' as grantor.

@permissionarea:  O=Object
S=Statement; include all which apply.
   Examples-   'o', ',s', 'os', 'so', 's o', 's,o', GeneMi
********/

	Set nocount on

	Declare
	@vc1                   sysname
	,@Int1                  integer

	Declare
	@charMaxLenOwner		character varying(11)
	,@charMaxLenObject		character varying(11)
	,@charMaxLenGrantee		character varying(11)
	,@charMaxLenGrantor		character varying(11)
	,@charMaxLenAction		character varying(11)
	,@charMaxLenColumnName	character varying(11)

	Declare
	@OwnerName				sysname
	,@ObjectStatementName	sysname


	/* Perform temp table DDL here to minimize compilation costs*/
CREATE Table #t1_Prots
	(	Id					int				Null
		,Type1Code			char(6)			collate database_default NOT Null
		,ObjType			char(2)			collate database_default Null

		,ActionName		varchar(20)			collate database_default Null
		,ActionCategory	char(2)				collate database_default Null
		,ProtectTypeName	char(10)		collate database_default Null

		,Columns_Orig		varbinary(32)	Null

		,OwnerName			sysname			collate database_default NOT Null
		,ObjectName			sysname			collate database_default NOT Null
		,GranteeName		sysname			collate database_default NOT Null
		,GrantorName		sysname			collate database_default NOT Null

		,ColumnName			sysname			collate database_default Null
		,ColId				smallint		Null

		,Max_ColId			smallint		Null
		,All_Col_Bits_On	tinyint			Null
		,new_Bit_On			tinyint			Null )  -- 1=yes on


	/*	Check for valid @permissionarea */
	Select @permissionarea = upper( isnull(@permissionarea,'?') )

	IF (	charindex('O',@permissionarea) <= 0
		AND  charindex('S',@permissionarea) <= 0)
	begin
		raiserror(15300,-1,-1 ,@permissionarea,'o,s')
		return (1)
	end

	select @vc1 = parsename(@name,3)

	/* Verified db qualifier is current db*/
	IF (@vc1 is not null and @vc1 <> db_name())
	begin
		raiserror(15302,-1,-1)  --Do not qualify with DB name.
		return (1)
	end

	/*  Derive OwnerName and @ObjectStatementName*/
	select	@OwnerName				=	parsename(@name, 2)
			,@ObjectStatementName	=	parsename(@name, 1)

	IF (@ObjectStatementName is NULL and @name is not null)
	begin
		raiserror(15253,-1,-1,@name)
		return (1)
	end

	/*	Copy info from sysprotects for processing	*/
	IF charindex('O',@permissionarea) > 0
	begin
		/*	Copy info for objects	*/
		INSERT	#t1_Prots
        (	Id
			,Type1Code

			,ObjType
			,ActionName
			,ActionCategory
			,ProtectTypeName

			,Columns_Orig
			,OwnerName
			,ObjectName
			,GranteeName

			,GrantorName
			,ColumnName
            ,ColId

			,Max_ColId
			,All_Col_Bits_On
			,new_Bit_On	)

	/*	1Regul indicates action can be at column level,
		2Simpl indicates action is at the object level */
		SELECT	id
				,case
					when columns is null then '2Simpl'
					else '1Regul'
				end

				,Null
				,val1.name
				,'Ob'
				,val2.name

				,columns
				,user_name(objectproperty( id, 'ownerid' ))
				,object_name(id)
				,user_name(uid)

				,user_name(grantor)
				,case
					when columns is null then '.'
					else Null
				end
				,-123

				,Null
				,Null
				,Null
		FROM	sysprotects sysp
				,master.dbo.spt_values  val1
				,master.dbo.spt_values  val2
		where	(@OwnerName is null or user_name(objectproperty( id, 'ownerid' )) = @OwnerName)
		and	(@ObjectStatementName is null or object_name(id) =  @ObjectStatementName)
		and	(@username is null or user_name(uid) =  @username)
		and	(@grantorname is null or user_name(grantor) =  @grantorname)
		and	val1.type     = 'T'
		and	val1.number   = sysp.action
		and	val2.type     = 'T' --T is overloaded.
		and	val2.number   = sysp.protecttype
		and sysp.id != 0


		IF EXISTS (SELECT * From #t1_Prots)
		begin
			UPDATE	#t1_Prots set ObjType = ob.xtype
			FROM	sysobjects    ob
			WHERE	ob.id	=  #t1_Prots.Id


			UPDATE 	#t1_Prots
			set		Max_ColId = (select max(colid) from syscolumns sysc
								where #t1_Prots.Id = sysc.id)	-- colid may not consecutive if column dropped
			where Type1Code = '1Regul'


			/*	First bit set indicates actions pretains to new columns. (i.e. table-level permission)
				Set new_Bit_On accordinglly							*/
			UPDATE	#t1_Prots SET new_Bit_On =
			CASE	convert(int,substring(Columns_Orig,1,1)) & 1
				WHEN	1 then	1
				ELSE	0
			END
			WHERE	ObjType	<> 'V'	and	 Type1Code = '1Regul'


			/* Views don't get new columns	*/
			UPDATE #t1_Prots set new_Bit_On = 0
			WHERE  ObjType = 'V'


			/*	Indicate enties where column level action pretains to all
				columns in table All_Col_Bits_On = 1					*/
			UPDATE	#t1_Prots	set		All_Col_Bits_On = 1
			where	#t1_Prots.Type1Code	 =  '1Regul'
			and	not exists
				(select *
				from syscolumns sysc
master..spt_values v
				where #t1_Prots.Id = sysc.id and sysc.colid = v.number
				and v.number <= Max_ColId		-- column may be dropped/added after Max_ColId snap-shot
				and v.type = 'P' and
			/*	Columns_Orig where first byte is 1 means off means on and on mean off
				where first byte is 0 means off means off and on mean on	*/
					case convert(int,substring(#t1_Prots.Columns_Orig, 1, 1)) & 1
						when 0 then convert(tinyint, substring(#t1_Prots.Columns_Orig, v.low, 1))
						else (~convert(tinyint, isnull(substring(#t1_Prots.Columns_Orig, v.low, 1),0)))
					end & v.high = 0)


			/* Indicate entries where column level action pretains to
				only some of columns in table  All_Col_Bits_On  =  0*/
			UPDATE	#t1_Prots	set  All_Col_Bits_On  =  0
			WHERE	#t1_Prots.Type1Code  =  '1Regul'
			and	All_Col_Bits_On  is  null


			Update #t1_Prots
			set ColumnName  =
			case
				when All_Col_Bits_On = 1 and new_Bit_On = 1 then '(All+New)'
				when All_Col_Bits_On = 1 and new_Bit_On = 0 then '(All)'
				when All_Col_Bits_On = 0 and new_Bit_On = 1 then '(New)'
			end
			from	#t1_Prots
			where	ObjType    IN ('S ' ,'U ', 'V ')
			and	Type1Code = '1Regul'
			and   NOT (All_Col_Bits_On = 0 and new_Bit_On = 0)


			/* Expand and Insert individual column permission rows */
			INSERT	into   #t1_Prots
				(Id
				,Type1Code
				,ObjType
				,ActionName

				,ActionCategory
				,ProtectTypeName
				,OwnerName
				,ObjectName

				,GranteeName
				,GrantorName
				,ColumnName
				,ColId	)
		   SELECT	prot1.Id
					,'1Regul'
					,ObjType
					,ActionName

					,ActionCategory
					,ProtectTypeName
					,OwnerName
					,ObjectName

					,GranteeName
					,GrantorName
					,col_name ( prot1.Id ,val1.number )
					,val1.number
			from	#t1_Prots              prot1
					,master.dbo.spt_values  val1
					,syscolumns sysc
			where	prot1.ObjType    IN ('S ' ,'U ' ,'V ')
				and	prot1.All_Col_Bits_On = 0
				and prot1.Id	= sysc.id
				and	val1.type   = 'P'
				and	val1.number = sysc.colid
				and
				case convert(int,substring(prot1.Columns_Orig, 1, 1)) & 1
					when 0 then convert(tinyint, substring(prot1.Columns_Orig, val1.low, 1))
					else (~convert(tinyint, isnull(substring(prot1.Columns_Orig, val1.low, 1),0)))
				end & val1.high <> 0

			delete from #t1_Prots
					where	ObjType    IN ('S ' ,'U ' ,'V ')
							and	All_Col_Bits_On = 0
							and new_Bit_On = 0
		end
	end


	/* Handle statement permissions here*/
	IF (charindex('S',@permissionarea) > 0)
	begin
	   /*	All statement permissions are 2Simpl */
		INSERT	#t1_Prots
			 (	Id
				,Type1Code
				,ObjType
				,ActionName

				,ActionCategory
				,ProtectTypeName
				,Columns_Orig
				,OwnerName

				,ObjectName
				,GranteeName
				,GrantorName
				,ColumnName

				,ColId
				,Max_ColId
				,All_Col_Bits_On
				,new_Bit_On	)
		SELECT	id
				,'2Simpl'
				,Null
				,val1.name

				,'St'
				,val2.name
				,columns
				,'.'

				,'.'
				,user_name(sysp.uid)
				,user_name(sysp.grantor)
				,'.'
				,-123

				,Null
				,Null
				,Null
		FROM	sysprotects				sysp
				,master.dbo.spt_values	val1
				,master.dbo.spt_values  val2
		where	(@username is null or user_name(sysp.uid) = @username)
			and	(@grantorname is null or user_name(sysp.grantor) = @grantorname)
			and	val1.type     = 'T'
			and	val1.number   =  sysp.action
			and	(@ObjectStatementName is null or val1.name = @ObjectStatementName)
			and	val2.number   = sysp.protecttype
			and	val2.type     = 'T'
			and sysp.id = 0
	end


	IF NOT EXISTS (SELECT * From #t1_Prots)
	begin
		raiserror(15330,-1,-1)
		return (1)
	end


	/*	Calculate dynamic display col widths		*/
	SELECT
	@charMaxLenOwner       =
		convert ( varchar
max(datalength(OwnerName)))

	,@charMaxLenObject      =
		convert ( varchar
max(datalength(ObjectName)))

	,@charMaxLenGrantee     =
		convert ( varchar
max(datalength(GranteeName)))

	,@charMaxLenGrantor     =
		convert ( varchar
max(datalength(GrantorName)))

	,@charMaxLenAction      =
		convert ( varchar
max(datalength(ActionName)))

	,@charMaxLenColumnName  =
		convert ( varchar
max(datalength(ColumnName)))
	from	#t1_Prots


/*  Output the report	*/
EXECUTE(
'Set nocount off

SELECT	''Owner''		= substring (OwnerName   ,1 ,' + @charMaxLenOwner   + ')

		,''Object''		= substring (ObjectName  ,1 ,' + @charMaxLenObject  + ')

		,''Grantee''	= substring (GranteeName ,1 ,' + @charMaxLenGrantee + ')

		,''Grantor''	= substring (GrantorName ,1 ,' + @charMaxLenGrantor + ')

		,''ProtectType''= ProtectTypeName

		,''Action''		= substring (ActionName ,1 ,' + @charMaxLenAction + ')

		,''Column''		= substring (ColumnName ,1 ,' + @charMaxLenColumnName + ')
   from	#t1_Prots
   order by
		ActionCategory
		,Owner				,Object
		,Grantee			,Grantor
		,ProtectType		,Action
		,ColId  --Multiple  -123s  ( <0 )  possible

Set nocount on'
)

Return (0) -- sp_helprotect









/*-----   Check active session in database   -----*/
exec sp_who

SELECT * FROM SYSPROCESSES WHERE spid = '52'

KILL 52 WITH STATUSONLY







/*-----   Check temp table in database   -----*/

IF OBJECT_ID('tempdb..#some_temp_name') IS NOT NULL
    PRINT '#some_temp_name exists.'
ELSE
    PRINT '#some_temp_name does not exist.'










/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     DATATYPE      ------------------------------*/

/*-----   DATETIME   -----*/


CREATE TABLE A(T1 DATETIME)
CREATE TABLE B(T1 SMALLDATETIME)
INSERT A VALUES('2005-10-18 14:24:15.137')
INSERT A VALUES('14:24:15.137') -- INSERT TIME ONLY IN THE COLUMN BUT THE ACTUAL VALUE IS 1900-01-01 14:24:15.137
INSERT B VALUES('14:24')
SELECT * FROM A
SELECT * FROM B

SELECT CAST(0x0000A03C00000000 AS DateTime);




/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*--------------------     Database Functions      --------------------*/
/*
||	SHOW CURRENT DATABASE
||
*/
SELECT DB_NAME();
GO




/*------------------------------     Functions      ------------------------------*/

/*-----   BETWEEN   -----*/

SELECT *
FROM TABLE_NAME
WHERE LAST_UPDATE BETWEEN '2003-07-18 00:00:00.000' AND '2222-06-01 00:00:00.000'

SELECT GETDATE() BETWEEN '01/01/2009 00:00:00' AND '01/31/2009 00:00:00'


/*-----   CASE   -----*/

SELECT
	DISPLAY_NAME =
	CASE COL_NAME
		WHEN 0 THEN 'COLUMN = 0'
		ELSE 'UNKNOWN'
	END
	FROM
		TABLE_NAME

SELECT
	DISPLAY_NAME =
	CASE
		WHEN COL_NAME IS NULL THEN 'COLUMN IS NULL'
		ELSE 'UNKNOWN'
	END
	FROM
		TABLE_NAME

SELECT
	GRE.ID,
	DISPLAY =
	G.FIRST_NAME
	+
	CASE
		WHEN G.LAST_NAME IS NOT NULL THEN ' ' + G.LAST_NAME
		ELSE ''
	END,
	GRE.ID AS VALUE,
	CASE G.IS_COMMING
		WHEN '0' THEN '4'
		ELSE '5'
	END
	AS IMG_INDEX,
	6 AS SELECTED_IMG_INDEX,
	CAST(GRE.GUEST_LOOPBACK_ID AS VARCHAR(50)) AS PARENT_KEY
	FROM
		GUEST_RELATION AS GRE
			INNER JOIN GUEST AS G
				ON GRE.GUEST_ID = G.ID



/*-----   CAST   -----*/

--Convert DataType
SELECT CAST(int_column AS VARCHAR(10)) FROM TABLE_NAME
SELECT CAST(varchar_column AS int) FROM TABLE_NAME


/*-----   CHARINDEX   -----*/

DECLARE @CHECK_STR VARCHAR(50)
DECLARE @FIND_STR VARCHAR(50)
SET @CHECK_STR = '    bicycle';
SET @FIND_STR = 'bicycle';
SELECT @CHECK_STR AS CHECK_STR, @FIND_STR AS FIND_STR, CHARINDEX(@FIND_STR, @CHECK_STR) AS INDEX_OF;
GO

-- FIND LAST INDEX OF
DECLARE @CHECK_STR VARCHAR(50)
DECLARE @FIND_STR VARCHAR(50)
SET @CHECK_STR = 'C:\Temp\OIMROA.csv';
SET @FIND_STR = '\';
SELECT (LEN(@CHECK_STR) - CHARINDEX(@FIND_STR, REVERSE(@CHECK_STR), 1 + 1))+1
GO




/*-----   CONVERT   -----*/

Without century (yy)		With century (yyyy)			Standard						Input/Output**
-							0 or 100 (*)  				Default 						mon dd yyyy hh:miAM (or PM)
1							101							USA								mm/dd/yy
2							102 						ANSI 							yy.mm.dd
3 							103 						British/French	 				dd/mm/yy
4 							104 						German 							dd.mm.yy
5 							105 						Italian 						dd-mm-yy
6 							106 						- 								dd mon yy
7 							107 						- 								Mon dd, yy
8 							108 						- 								hh:mm:ss
- 							9 or 109 (*)  				Default + milliseconds 			mon dd yyyy hh:mi:ss:mmmAM (or PM)
10 							110 						USA 							mm-dd-yy
11 							111 						JAPAN 							yy/mm/dd
12 							112 						ISO 							yymmdd
- 							13 or 113 (*)  				Europe default + milliseconds 	dd mon yyyy hh:mm:ss:mmm(24h)
14  						114  						-  								hh:mi:ss:mmm(24h)
- 							20 or 120 (*)   			ODBC canonical 					yyyy-mm-dd hh:mi:ss(24h)
- 							21 or 121 (*)  				ODBC canonical (with milliseconds)	yyyy-mm-dd hh:mi:ss.mmm(24h)
- 							126(***) 					ISO8601 						yyyy-mm-dd Thh:mm:ss.mmm(no spaces)
- 							130* 						Hijri**** 						dd mon yyyy hh:mi:ss:mmmAM
- 							131* 						Hijri**** 						dd/mm/yy hh:mi:ss:mmmAM


*    The default values (style 0 or 100, 9 or 109, 13 or 113, 20 or 120, and 21 or 121) always return the century (yyyy).
** Input when converting to datetime; output when converting to character data.
*** Designed for XML use. For conversion from datetime or smalldatetime to character data, the output format is as described in the table. For conversion from float, money, or smallmoney to character data, the output is equivalent to style 2. For conversion from real to character data, the output is equivalent to style 1.
****Hijri is a calendar system with several variations, of which Microsoft?SQL Server?2000 uses the Kuwaiti algorithm.


SELECT CONVERT(VARCHAR, GETDATE(), 101) AS DATE_FORMAT_101;
SELECT CONVERT(VARCHAR, GETDATE(), 102) AS DATE_FORMAT_102;
SELECT LEFT(CONVERT(VARCHAR, GETDATE(), 120), 10) AS DATE_YYYY_MM_DD;
SELECT LEFT(CONVERT(VARCHAR, GETDATE(), 120), 10) AS DATE_YYYY_MM_DD;




/*-----   DATEADD   -----*/

	DECLARE @FROM_TABLE varchar(30);
	DECLARE @NEW_TABLE varchar(30);

	SET @FROM_TABLE = 'EVT_TYPE';
	SET @NEW_TABLE	= 'NEW_TEST';

SELECT 'SELECT * INTO ' + @NEW_TABLE + ' FROM ' + @FROM_TABLE + ';' AS SQL_STATEMENT

BEGIN
	DECLARE @datetime2 DATETIME;
--	SET @datetime2 = '2007-01-01 13:10:10.1111111';
	SET @datetime2 = GETDATE();

	SELECT 'ALL 1 year', DATEADD(year,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 quarter',DATEADD(quarter,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 month',DATEADD(month,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 dayofyear',DATEADD(dayofyear,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 day',DATEADD(day,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 week',DATEADD(week,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 weekday',DATEADD(weekday,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 hour',DATEADD(hour,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 minute',DATEADD(minute,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 second',DATEADD(second,1,@datetime2)
	UNION ALL
	SELECT 'ALL 1 millisecond',DATEADD(millisecond,1,@datetime2);
END;
GO





/*-----   DATEPART   -----*/

select
	datepart(yyyy,DATE_COLUMN) as Year,
	datepart(mm,DATE_COLUMN) as Month,
	datepart(dd,DATE_COLUMN) as Day,
	count(*) as Counter
	from
		TABLE_NAME
		group by
			datepart(yyyy,DATE_COLUMN),
			datepart(mm,DATE_COLUMN),
			datepart(dd,DATE_COLUMN)
			order by 1,2,3

select
	datepart(yyyy,GETDATE()) as YEAR,
	datepart(mm,GETDATE()) as MONTH,
	datepart(dd,GETDATE()) as DAY,
	datepart(qq,GETDATE()) as QUARTER,
	datepart(dy,GETDATE()) as DAY_OF_YEAR,
	datepart(wk,GETDATE()) as WEEK,
	datepart(dw,GETDATE()) as WEEKDAY,
	datepart(hh,GETDATE()) as HOUR,
	datepart(mi,GETDATE()) as MINUTE,
	datepart(ss,GETDATE()) as SECOND,
	datepart(ms,GETDATE()) as MILLISECOND,
	CAST(datepart(yyyy, GETDATE()) AS varchar(4)) + '-' + CAST(datepart(mm, GETDATE()) AS varchar(2)) + '-' + CAST(datepart(dd, GETDATE()) AS varchar(2)) AS SHORT_DATE
GO

select
	datepart(yyyy,'2011-06-25 16:41.50') as YEAR,
	datepart(mm,'2011-06-25 16:41.50') as MONTH,
	datepart(dd,'2011-06-25 16:41.50') as DAY,
	datepart(qq,'2011-06-25 16:41.50') as QUARTER,
	datepart(dy,'2011-06-25 16:41.50') as DAY_OF_YEAR,
	datepart(wk,'2011-06-25 16:41.50') as WEEK,
	datepart(dw,'2011-06-25 16:41.50') as WEEKDAY,
	datepart(hh,'2011-06-25 16:41.50') as HOUR,
	datepart(mi,'2011-06-25 16:41.50') as MINUTE,
	datepart(ss,'2011-06-25 16:41.50') as SECOND,
	datepart(ms,'2011-06-25 16:41.50') as MILLISECOND;
GO

select
	right('00' + CAST(datepart(yyyy, GETDATE()) AS varchar(4)), 4) + '-'
	+ right('00' + CAST(datepart(mm, GETDATE()) AS varchar(2)), 2) + '-'
	+ right('00' + CAST(datepart(dd, GETDATE()) AS varchar(2)), 2) AS [CURRENT DATE],
	right('00' + CAST(datepart(hh, GETDATE()) AS varchar(2)), 2) + ':'
	+ right('00' + CAST(datepart(mi, GETDATE()) AS varchar(2)), 2) + ':'
	+ right('00' + CAST(datepart(ss, GETDATE()) AS varchar(2)), 2) AS [CURRENT TIME];
GO


Datepart	Abbreviations
year		yy,	yyyy
quarter		qq,	q
month		mm,	m
dayofyear	dy,	y
day			dd,	d
week		wk,	ww
weekday		dw
hour		hh
minute		mi,	n
second		ss,	s
millisecond	ms


/*-----   GETDATE()   -----*/

Get the Current Date and Time
select GETDATE()


/*-----   NEWID()   -----*/

Get NEW GUID
select NEWID()


/*-----   TOP   -----*/
SELECT TOP 10 * FROM TABLE_NAME




/*--------------------   REGEXP   --------------------*/

/*-----   RegexMatches   -----*/

declare @text nvarchar(max), @pattern nvarchar(max)
select
    @text = N'Here are four words.',
    @pattern = '\w+'
select count(distinct [Text])
    from dbo.RegexMatches( @text, @pattern )





/*--------------------     Table Functions      --------------------*/

/*---------------   Drop table   ---------------*/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TABLE_NAME]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table TABLE_NAME;

/*---------------   Create table   ---------------*/

CREATE TABLE [dbo].[DATATYPE_SAMPLE](
	[Bigint] [bigint] NULL,
	[Binary] [binary](50) NULL,
	[Bit] [bit] NULL,
	[Char] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateTime] [datetime] NULL,
	[Decimal] [decimal](18, 0) NULL,
	[Float] [float] NULL,
	[Image] [image] NULL,
	[Int] [int] NULL,
	[Money] [money] NULL,
	[Nchar] [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Ntext] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Numeric] [numeric](18, 0) NULL,
	[Nvarchar] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Real] [real] NULL,
	[SmalldateTime] [smalldatetime] NULL,
	[Smallint] [smallint] NULL,
	[Smallmoney] [smallmoney] NULL,
	[SQL_Variant] [sql_variant] NULL,
	[Text] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Timestamp] [timestamp] NULL,
	[Tinyint] [tinyint] NULL,
	[Uniqueidentifier] [uniqueidentifier] NULL,
	[Varbinary] [varbinary](50) NULL,
	[Varchar] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[XML] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE DEFAULT_TABLE
(
	ID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT (NEWID()),
	NAME VARCHAR(100) NOT NULL,
	DESCRIPTION VARCHAR(1000) NULL,
	CREATED_BY varchar(100)  NOT NULL DEFAULT 'SYSTEM',
	CREATION_DATE datetime NOT NULL DEFAULT GETDATE(),
	LASTUPDATED_BY varchar(100)  NOT NULL DEFAULT 'SYSTEM',
	LAST_UPDATE DATETIME NOT NULL DEFAULT (GETDATE())
)


/*---------------   Alter table   ---------------*/

/*-----   Add Column   -----*/

ALTER TABLE log_shipping_plans ADD maintenance_plan_id UNIQUEIDENTIFIER NULL

/*-----   DROP Column   -----*/

ALTER TABLE doc_exb DROP COLUMN column_b

CREATE TABLE doc_exe ( column_a INT CONSTRAINT column_a_un UNIQUE)

ALTER TABLE doc_exe ADD

-- CREATE A UNIQUE CONSTRAINT ON A EXISTING COLUMN
ALTER TABLE TABLE_NAME WITH NOCHECK ADD CONSTRAINT CONSTRAINT_NAME UNIQUE (COLUMN_NAME);

-- CREATE A CHECK CONSTRAINT ON A EXISTING COLUMN
ALTER TABLE TABLE_NAME ADD CONSTRAINT MX_CONSTRAINT_NAME CHECK (COLUMN_NAME IS NULL);



/* Add a PRIMARY KEY identity column. */
column_b INT IDENTITY
CONSTRAINT column_b_pk PRIMARY KEY,

/* Add a column referencing another column in the same table. */
column_c INT NULL
CONSTRAINT column_c_fk
REFERENCES doc_exe(column_a),

/* Add a column with a constraint to enforce that   */
/* nonnull data is in a valid phone number format.  */
column_d VARCHAR(16) NULL
CONSTRAINT column_d_chk
CHECK
(column_d IS NULL OR
column_d LIKE "[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]" OR
column_d LIKE "([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]"),

/* Add a nonnull column with a default.  */
column_e DECIMAL(3,3)
CONSTRAINT column_e_default
DEFAULT .081

EXEC sp_help doc_exe

DROP TABLE doc_exe





/*-----   Create TABLE   -----*/

CREATE TABLE [dbo].[TABLE_NAME]
(
	[ID] [int] IDENTITY (1,1) NOT NULL ,
	[FOREIGN_ID] [int] NOT NULL ,
	[AMOUNT_01] [money] NOT NULL ,
	[AMOUNT_01] [decimal](19,4) NOT NULL ,
	[DATE] [datetime] NOT NULL ,
	[NOTES] [varchar] (100) NOT NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[TABLE_NAME] WITH NOCHECK ADD
	CONSTRAINT [PK_TABLE_NAME] PRIMARY KEY  CLUSTERED
	(
		[ID]
	) WITH  FILLFACTOR = 90  ON [PRIMARY]

-- CREATE TABLE FROM INSERT

SELECT * INTO [NEW_TABLE_NAME] FROM [EXISTING_TABLE_NAME]


if exists (select * from dbo.sysobjects where id = object_id(N'dbo.ALL_COLS') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table dbo.ALL_COLS
GO

CREATE TABLE dbo.ALL_COLS (
	ID UNIQUEIDENTIFIER NOT NULL ,
	COL_BIGINT BIGINT NULL ,
	COL_BINARY BINARY (50) NULL ,
	COL_BIT BIT NULL ,
	COL_CHAR CHAR (10) NULL ,
	COL_DATETIME DATETIME NULL ,
	COL_DECIMAL DECIMAL(18, 0) NULL ,
	COL_FLOAT FLOAT NULL ,
	COL_IMAGE IMAGE NULL ,
	COL_INT INT NULL ,
	COL_MONEY MONEY NULL ,
	COL_NCHAR NCHAR (10) NULL ,
	COL_NTEXT NTEXT NULL ,
	COL_NUMERIC NUMERIC(18, 0) NULL ,
	COL_NVARCHAR NVARCHAR (50) NULL ,
	COL_REAL REAL NULL ,
	COL_SMALLDATETIME SMALLDATETIME NULL ,
	COL_SMALLINT SMALLINT NULL ,
	COL_SMALLMONEY SMALLMONEY NULL ,
	COL_SQL_VARIANT SQL_VARIANT NULL ,
	COL_TEXT TEXT NULL ,
	COL_TIMESTAMP TIMESTAMP NULL ,
	COL_TINYINT TINYINT NULL ,
	COL_UNIQUEIDENTIFIER UNIQUEIDENTIFIER NULL ,
	COL_VARBINARY VARBINARY (50) NULL ,
	COL_VARCHAR VARCHAR (50) NULL
) ON PRIMARY TEXTIMAGE_ON PRIMARY
GO

ALTER TABLE [dbo].[ALL_COLS] ADD
	CONSTRAINT [PK_ALL_COLS] PRIMARY KEY  CLUSTERED
	(
		[ID]
	)  ON [PRIMARY]


ALTER TABLE ALL_COLS ADD
	CONSTRAINT FK_KEY_NAME FOREIGN KEY
	(
		TRANS_CAT_ID
	) REFERENCES REF_TABLE (
		ID
	)ON UPDATE  CASCADE
	 ON DELETE  CASCADE;



/*
||	CREATE UNIQUE CONSTRAINT FOR COLUMN
||
*/

ALTER TABLE TABLE_NAME ADD CONSTRAINT UC_CONSTRAINT UNIQUE (COLUMN_001, COLUMN_002);




/*
||	ADD DEFAULT VALUE TO A COLUMN
||
*/

ALTER TABLE TABLE_NAME ADD  DEFAULT (newid()) FOR [ID]
ALTER TABLE TABLE_NAME ADD  DEFAULT (getdate()) FOR [LAST_UPDATE]




/*
||	CREATE UNIQUE INDEX FOR COLUMN
||
*/

CREATE UNIQUE INDEX UIDX_INDEX_NAME ON TABLE_NAME (COLUMN_01, COLUMN_02)
ALTER INDEX UIDX_INDEX_NAME ON TABLE_NAME DISABLE




/*
||	CREATE INDEX FOR COLUMN
||
*/

CREATE INDEX IDX_INDEX_NAME ON TABLE_NAME (COLUMN_01, COLUMN_02)
CREATE INDEX IDX_FM_TITLE_NAME ON FM_TITLE (NAME)

USE [Library]
GO
/****** Object:  Index [IDX_FM_DETAIL_F_DATE]    Script Date: 04/07/2010 01:58:45 ******/
CREATE NONCLUSTERED INDEX [IDX_FM_DETAIL_F_DATE] ON [dbo].[FM_DETAIL]
(
	[FILE_DATE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]




/*
||	CREATE TRIGGER FOR A TABLE
||
*/

CREATE TRIGGER TRIGGER_NAME ON TABLE_NAME FOR INSERT, UPDATE, DELETE
AS
	DECLARE @INS_COLUMN_01 varchar(100)
	DECLARE @INS_COLUMN_02 varchar(100)
	SELECT @INS_COLUMN_01 = COLUMN_01, @INS_COLUMN_02 = COLUMN_02 FROM INSERTED;
	SELECT @INS_COLUMN_01 = COLUMN_01, @INS_COLUMN_02 = COLUMN_02 FROM DELETED;

GO




/*
||	DISABLE TRIGGER
||
*/
DISABLE TRIGGER { [ schema_name . ] trigger_name [ ,...n ] | ALL }
ON { object_name | DATABASE | ALL SERVER } [ ; ]





/*
||	INSERT FROM SELECT
||
*/

INSERT INTO TABLENAME (COLUMN_NAME)
SELECT COLUMN_NAME FROM TABLENAME;

INSERT INTO [DB_NAME_01].[dbo].[TABLE]
SELECT * FROM [DB_NAME_02].[dbo].[TABLE];




/*------------------------------------------------------------
||	FUNCTION	:	SUBSTRING
||	DESCRIPTION	:	SUBSTRING
------------------------------------------------------------*/

SELECT SUBSTRING('123456789', 1, 2);
GO




/*------------------------------------------------------------
||	FUNCTION	:	BULK
||	DESCRIPTION	:	INSERT FILE FROM COMMAND LINE
------------------------------------------------------------*/

DROP TABLE FILE_TABLE
CREATE TABLE FILE_TABLE
(
	[ID] [uniqueidentifier] NOT NULL PRIMARY KEY DEFAULT (NEWID()),
	[FILENAME] [nvarchar](1000) NOT NULL,
	[FILE_DATA] [image] NULL
);
ALTER TABLE FILE_TABLE ADD CONSTRAINT UC_FILENAME UNIQUE (FILENAME);
GO

INSERT INTO FILE_TABLE ( FILENAME, FILE_DATA) SELECT 'C:\Temp\tnsnames.ora', * FROM OPENROWSET(BULK 'C:\Temp\tnsnames.ora', SINGLE_BLOB) AS X;
GO

DROP PROCEDURE PROC_INS_FILE
CREATE PROCEDURE PROC_INS_FILE
--ALTER PROCEDURE PROC_INS_FILE
(
        @FILE_FULL_PATH NVARCHAR(1000) = NULL
)
AS

BEGIN

	DECLARE @SQL NVARCHAR(2000)

	SET @SQL = "INSERT INTO FILE_TABLE ( FILENAME, FILE_DATA) SELECT '" + @FILE_FULL_PATH + "', * FROM OPENROWSET(BULK '" + @FILE_FULL_PATH + "', SINGLE_BLOB) AS X"

	PRINT 'FILE PATH: ' + @FILE_FULL_PATH;
	PRINT 'SQL:' + CHAR(10) + @SQL;

	--EXEC (@SQL)

	SELECT * FROM FILE_TABLE;

END;
GO

EXEC PROC_INS_FILE 'C:\Temp\tnsnames.ora';
GO




/*------------------------------------------------------------
||	FUNCTION	:	OPENROWSET
||	DESCRIPTION	:
------------------------------------------------------------*/

/*
||	READ TXT FILE FROM SQL
||
*/

SELECT a.* FROM OPENROWSET( BULK 'D:\Program\DB\sql\FunctionTest\value.txt', SINGLE_CLOB ) AS a;
GO


/*
||	READ TXT FILE FROM SQL WITH FORMAT
||
*/
SELECT a.* FROM OPENROWSET( BULK 'D:\Program\DB\sql\FunctionTest\value.txt', FORMATFILE = 'D:\Program\DB\sql\FunctionTest\values.fmt') AS a;
GO





/*--------------------     VIEWS Functions      --------------------*/


/*-----   CREATE OR REPLACE VIEWS   -----*/

CREATE VIEW VW_VIEW_NAME
--ALTER VIEW VW_VIEW_NAME
AS
SELECT
	*
	FROM
		TABLE_NAME

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_VIEW_NAME]'))
DROP VIEW [dbo].[VW_VIEW_NAME]









/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Build-in VARIABLE      ------------------------------*/

/*
||	@@CONNECTIONS
||	Returns the number of connections
or attempted connections
since Microsoft?SQL Server?was last started.
*/

SELECT GETDATE() AS 'Today''s Date and Time', @@CONNECTIONS AS 'Login Attempts'


/*
||	@@CPU_BUSY
||	Returns the time in milliseconds (based on the resolution of the system timer) that the CPU has spent working since Microsoft?SQL Server?was last started.
*/

SELECT @@CPU_BUSY AS 'CPU ms', GETDATE() AS 'As of'


/*
||	@@SPID
||	Returns the number of connections
or attempted connections
since Microsoft?SQL Server?was last started.
*/

SELECT @@SPID AS 'ID', SYSTEM_USER AS 'Login Name', USER AS 'User Name'


/*
||	@@VERSION
||	Returns the date
version
and processor type for the current installation of Microsoft?SQL Server?
*/


SELECT @@VERSION



/*------------------------------     SYSTEM STORED PROCEDURE      ------------------------------*/


/*
||	PROCEDURE:		sp_helpuser
||	DESCRIPTION:	Return information about all USER
*/

EXEC sp_helpuser
GO


/*
||	PROCEDURE:		sp_helpgroup
||	DESCRIPTION:	Return information about all roles
*/

EXEC sp_helpgroup
GO


/*
||	PROCEDURE:		sp_helpdb
||	DESCRIPTION:	Return information about all databases
*/

exec sp_helpdb
GO


/*
||	PROCEDURE:		sp_helprole
||	DESCRIPTION:	Return information about all roles
*/

EXEC sp_helprole
GO


























Here are some system stored procedure will create Linked Server and Drop Linked Server

Create Linked Server:
sp_addlinkedserver
sp_addlinkedsrvlogin

Drop Linked Server:
sp_dropserver
sp_dropremotelogin

exec sp_dropserver 'MROC_WEB1', 'droplogins'

Definition:

/*-----   Add Linked Server   -----*/

Procedure Name: sp_addlinkedserver
Parameter:
	@server           -- Display Server Name
	@srvproduct       -- product name (dflt to ss)
	@provider         -- oledb Provider Name
	@datasrc          -- oledb Datasource Property
	@location         -- oledb Location Property
	@provstr          -- oledb provider-string property
	@catalog          -- oledb SQL Server Database Name ( for SQL Server Only )


/*-----   Add User   -----*/

Procedure Name: sp_addlinkedsrvlogin
Parameter:
	@rmtsrvname		 -- Display Server Name
	@useself		 -- If True It Overrides Parameters @rmtuser
and @rmtpassword to Null
	@locallogin		 -- Current SQL Server login
	@rmtuser    	 -- Remote Server Login Name
	@rmtpassword	 -- Reomte Server Password


/*-----   Delete Linked Server   -----*/

Procedure Name: sp_dropserver
Parameter:
    @server			-- server name
    @droplogins		-- drop all related logins?


/*-----   Delete User   -----*/

Procedure Name: sp_dropremotelogin
Parameter:
	@rmtsrvname		-- Display Server Name
	@locallogin		sysname


Example:

For SQL Server:

exec sp_addlinkedserver 'DISPLAY_NAME', 'SERVER_NAME', 'SQLOLEDB', 'SERVER_NAME', null, null, 'DATABASE_NAME'

exec sp_addlinkedsrvlogin 'DISPLAY_NAME', false, 'DOMAIN_NAME\USERNAME', 'DATABASE_USERNAME', 'DATABASE_PASSWORD'

exec sp_addlinkedsrvlogin 'DISPLAY_NAME', false, null, 'DATABASE_USERNAME', 'DATABASE_PASSWORD'

SELECT * FROM OPENQUERY(DISPLAY_NAME
'SELECT * FROM TABLE_NAME')


For Oracle Server

exec sp_addlinkedserver 'DISPLAY_NAME', 'ORACLE_TSN_NAME', 'MSDAORA', 'ORACLE_TSN_NAME', null, null, null

exec sp_addlinkedsrvlogin 'DISPLAY_NAME', false, null, 'DATABASE_USERNAME', 'DATABASE_PASSWORD'

SELECT * FROM OPENQUERY(DISPLAY_NAME
'SELECT * FROM TABLE_NAME')

Customs Stored Procedure

exec Add_Linked_Server 'DISPLAY_NAME', 'ORACLE_TSN_NAME', 'MSDAORA', 'ORACLE_TSN_NAME', null, null, null, false, null, 'DATABASE_USERNAME', 'DATABASE_PASSWORD'


create procedure Add_Linked_Server
    @server         sysname
               -- server name
    @srvproduct     nvarchar(128) = NULL
  -- product name (dflt to ss)
    @provider       nvarchar(128) = NULL
  -- oledb provider name
    @datasrc        nvarchar(4000) = NULL
 -- oledb datasource property
    @location       nvarchar(4000) = NULL
 -- oledb location property
    @provstr        nvarchar(4000) = NULL
 -- oledb provider-string property
    @catalog        sysname = NULL          -- oledb catalog property
	@useself		varchar(8) = 'true',
	@locallogin		sysname = NULL,
	@rmtuser    	sysname = NULL,
	@rmtpassword	sysname = NULL
as
	declare	@ret	int


	if (@server IS NOT NULL)
	begin
		-- ADD ROW FOR NT LOGIN IF NEEDED --
		execute @ret = sp_addlinkedserver @server, @srvproduct, @provider, @datasrc, @location, @provstr,@catalog
		if @localsid IS NULL
		begin
			if (@ret = 0)
				execute @ret = sp_addlinkedsrvlogin @server, @useself, @locallogin, @rmtuser, @rmtpassword
		end
	end
    -- RETURN SUCCESS
    return(1) -- Add_Linked_Server








REMOTE CONNECTION

MAKE A CONNECTION TO REMOTE DATABASE SERVER AND EXECUTE QUERY


For SQL Server:

SELECT *
FROM OPENDATASOURCE( 'SQLOLEDB', 'Data Source=mroc_web1;User ID=sa;Password=OfficePassword' ).mroc.dbo.CCI_USER
where EMAIL_FLAG = 0


For Oracle Server:

SELECT *
FROM OPENDATASOURCE( 'MSDAORA', 'Data Source=omni_oracle_beta;User ID=edi_test2;Password=OfficePassword' ).edi_test2.fac_common
where EMAIL_FLAG = 0










/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     USEFULL FUNCTION      ------------------------------*/

/*---------------     FN_INT_TO_FIX_LEN_INT    ---------------*/


CREATE FUNCTION FN_INT_TO_FIX_LEN_INT
--ALTER FUNCTION FN_INT_TO_FIX_LEN_INT
(
	@NUM	INT,
	@NUM_OF_DIGIT	INT
)
RETURNS VARCHAR(100)
AS

BEGIN
	DECLARE @RTN_STR VARCHAR(100)
	SET @RTN_STR = RTRIM(LTRIM(CAST(@NUM AS varchar(100))))

	WHILE LEN(@RTN_STR) < @NUM_OF_DIGIT
	BEGIN
		SET @RTN_STR = '0' + @RTN_STR
	END


	IF @@ERROR <> 0
		BEGIN
			SET @RTN_STR = RTRIM(LTRIM(CAST(@NUM AS varchar(100))))
		END

	RETURN @RTN_STR
END


SELECT MyCompany.DBO.FN_INT_TO_FIX_LEN_INT(2, 5)
SELECT MyCompany.DBO.FN_INT_TO_FIX_LEN_INT(DATEPART(m, getdate()), 2)








/*------------------------------------------------------------
||	NAME		:	LAST_INDEX_OF
||	DESCRIPTION	:	Insert attachement record
||	CREATE		:
||	LAST UPDATE	:
------------------------------------------------------------*/

CREATE FUNCTION LAST_INDEX_OF
--ALTER FUNCTION LAST_INDEX_OF
(
	@SEARCH varchar(1000),
	@SOURCE varchar(1000)
)
RETURNS INT
AS

BEGIN
	DECLARE @RTN_INT INT;
	SET @RTN_INT = 0;

	IF CHARINDEX(@SEARCH, @SOURCE) > 0
	BEGIN
		SET @RTN_INT = LEN(@SOURCE) - CHARINDEX(@SEARCH, REVERSE(@SOURCE)) + 1;
	END

	IF @@ERROR <> 0
		BEGIN
			SET @RTN_INT = 0;
		END

	RETURN @RTN_INT
END
GO


SELECT DBO.LAST_INDEX_OF('4', '12345');
GO








/*------------------------------------------------------------
||	NAME		:	FN_GEN_DROP_TABLE
||	DESCRIPTION	:	Insert attachement record
||	CREATE		:
||	LAST UPDATE	:
------------------------------------------------------------*/

DROP FUNCTION FN_GEN_DROP_TABLE;

CREATE FUNCTION FN_GEN_DROP_TABLE
--ALTER FUNCTION FN_GEN_DROP_TABLE
(
	@SEARCH varchar(1000)
)
RETURNS VARCHAR(2000)
AS

BEGIN
	DECLARE @RTN_VARCHAR VARCHAR(2000);
	DECLARE @EACH_COL varchar(50)

	SET @RTN_VARCHAR = CHAR(10) + '/*------------------------------          DROP TABELS          ------------------------------*/' + CHAR(10) + CHAR(10);

	DECLARE NEW_TABLE_CUR CURSOR FOR
		SELECT NAME FROM SYSOBJECTS WHERE XTYPE = 'U' AND NAME LIKE '%' + @SEARCH + '%' ORDER BY NAME

	OPEN NEW_TABLE_CUR
	FETCH NEXT FROM NEW_TABLE_CUR INTO @EACH_COL
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @@ERROR = 0
		BEGIN
			SET @RTN_VARCHAR = @RTN_VARCHAR + 'DROP TABLE ' + @EACH_COL + ';' + CHAR(10)
			IF @@ERROR <> 0
			BEGIN
				GOTO CLEAN_UP
			END
		END
		FETCH NEXT FROM NEW_TABLE_CUR INTO @EACH_COL
	END
	CLOSE NEW_TABLE_CUR


CLEAN_UP:
        RETURN @RTN_VARCHAR

	RETURN @RTN_VARCHAR
END
GO

SELECT DBO.FN_GEN_DROP_TABLE('EDI');
GO





/*------------------------------------------------------------
||	NAME		:	PR_GEN_DROP_TABLE
||	DESCRIPTION	:	GENERATE DROP ALL TABLE SQL
------------------------------------------------------------*/

DROP PROCEDURE PR_GEN_DROP_TABLE

CREATE Procedure PR_GEN_DROP_TABLE
--ALTER Procedure PR_GEN_DROP_TABLE
AS

BEGIN
SELECT
	CAST(F_OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
	CAST(CONS_OBJ.NAME AS VARCHAR(30)) AS CONSTRAINTS_NAME,
	CAST(F_OBJ.NAME + '.' + F_COL.NAME AS VARCHAR(70)) AS FOREIGN_KEY_TABLES,
	CAST(R_OBJ.NAME + '.' + R_COL.NAME AS VARCHAR(70)) AS REF_TABLES
	FROM
		SYSCONSTRAINTS AS CONS
		INNER JOIN SYSFOREIGNKEYS AS FK_CONS
			ON CONS.CONSTID = FK_CONS.CONSTID
		INNER JOIN SYSOBJECTS AS CONS_OBJ
			ON CONS.CONSTID = CONS_OBJ.ID
		INNER JOIN SYSOBJECTS AS F_OBJ
				ON FK_CONS.FKEYID = F_OBJ.ID
		INNER JOIN SYSOBJECTS AS R_OBJ
			ON FK_CONS.RKEYID = R_OBJ.ID
		INNER JOIN SYSCOLUMNS AS F_COL
			ON FK_CONS.fkeyid = F_COL.ID AND FK_CONS.fkey = F_COL.COLID
		INNER JOIN SYSCOLUMNS AS R_COL
			ON FK_CONS.Rkeyid = R_COL.ID AND FK_CONS.Rkey = R_COL.COLID
		ORDER BY FOREIGN_KEY_TABLES;
END;





/*------------------------------------------------------------
||	NAME		:	RECURSIVE counter function
||	DESCRIPTION	:	GENERATE DROP ALL TABLE SQL
------------------------------------------------------------*/


CREATE FUNCTION FN_ITEM_COUNT
--ALTER FUNCTION FN_ITEM_COUNT
(
	@TYPE_RE_ID UNIQUEIDENTIFIER
)
RETURNS INT
AS
BEGIN
	DECLARE @PARENT_ID			UNIQUEIDENTIFIER;
	DECLARE @RTN_INT			INT;

	SET @RTN_INT = 0;
	IF EXISTS
	(
		SELECT *
			FROM
				VW_EVT_MAIN
				WHERE
					TYPE_RE_ID = @TYPE_RE_ID
	)
	BEGIN
		SELECT @RTN_INT = (SELECT SUM(M.NO_of_Item) FROM VW_EVT_MAIN AS M WHERE M.TYPE_RE_ID = @TYPE_RE_ID GROUP BY M.TYPE_RE_ID);
	END

	IF EXISTS
	(
		SELECT *
			FROM
				EVT_TYPE_RELATION
				WHERE
					ID = @TYPE_RE_ID
					AND LOOPBACK_ID IS NOT NULL
	)
	BEGIN
		SELECT @PARENT_ID = LOOPBACK_ID FROM EVT_TYPE_RELATION WHERE ID = @TYPE_RE_ID;
		SELECT @RTN_INT = DBO.FN_ITEM_COUNT(@PARENT_ID) + @RTN_INT

		IF @@ERROR <> 0
			BEGIN
				SELECT @RTN_INT = 0
			END
	END

	RETURN @RTN_INT
END
GO








/*------------------------------------------------------------
||	NAME		:	TABLE VALUED FUNCTION
||	DESCRIPTION	:	CREATE TABLE VALUED FUNCTION
||	CREATE		:
||	LAST UPDATE	:
------------------------------------------------------------*/

CREATE FUNCTION [dbo].[function_string_to_table]
(
    @string VARCHAR(MAX),
    @delimiter CHAR(1)
)
RETURNS @output TABLE(
    data VARCHAR(256)
)
BEGIN

    DECLARE @start INT, @end INT
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string)

    WHILE @start < LEN(@string) + 1 BEGIN
        IF @end = 0
            SET @end = LEN(@string) + 1

        INSERT INTO @output (data)
        VALUES(SUBSTRING(@string, @start, @end - @start))
        SET @start = @end + 1
        SET @end = CHARINDEX(@delimiter, @string, @start)
    END

    RETURN

END;


--JUST RETURN THE KEYS
SELECT * FROM dbo.function_string_to_table('key1|key2|key3|key4|key5', '|');

--USE THE FUNCTION AS A SUBQUERY
SELECT * FROM table1 WHERE sID IN (SELECT *
    FROM dbo.function_string_to_table('key1|key2|key3|key4|key5', '|'));








/*------------------------------------------------------------
||	NAME		:	TABLE VALUED FUNCTION
||	DESCRIPTION	:	Check File path exist or not
||	CREATE		:
||	LAST UPDATE	:
------------------------------------------------------------*/
create FUNCTION dbo.Is_FILE_EXIST(@path NVARCHAR(4000))
RETURNS BIT
AS
BEGIN
     DECLARE @result INT
     EXEC master.dbo.xp_fileexist @path, @result OUTPUT
     RETURN cast(@result as bit)
END;







/*------------------------------------------------------------
||	NAME		:	TABLE VALUED FUNCTION
||	DESCRIPTION	:	CREATE TABLE VALUED FUNCTION
||	CREATE		:
||	LAST UPDATE	:
------------------------------------------------------------*/
CREATE PROCEDURE procedure_takes_array
    @string VARCHAR(MAX),
    @delimiter CHAR(1)
AS

    SELECT * FROM table1 WHERE sID IN
    (SELECT * FROM dbo.function_string_to_table(@string, @delimiter))

GO

CALL FROM APPLICATION

void GetData(string[] keys)
{
    using (SqlConnection oconn = new SqlConnection("Application Name=SQLArrayTest;Server=(local);
    Database=MaxPreps_v2;Trusted_Connection=Yes;"))
    {
        oconn.Open();

        string SQL = "SELECT * FROM dbo.function_string_to_table(@keys, '|')";

        using (SqlCommand cmd = oconn.CreateCommand())
        {
            cmd.CommandText = sql;
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Add("@keys", SqlDbType.VarChar, -1);
            cmd.Parameters["@keys"].Value = string.Join("|", keys);

            //execute the command
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Close();
        }
    }
}











/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     TN USEFULL VIEW      ------------------------------*/

/*---------------     _VW_DESC    ---------------*/

CREATE VIEW _VW_DESC
--ALTER VIEW _VW_DESC
AS
SELECT
	CAST(OBJ.NAME AS VARCHAR(30)) AS OBJECT_NAME,
	CAST(COL.NAME AS VARCHAR(30)) AS COLUMN_NAME,
	--CAST(TYPE.NAME AS VARCHAR(16)) AS DB_TYPE,
	DATA_TYPE =
	CASE TYPE.NAME
		WHEN 'bit' THEN CAST(TYPE.NAME AS VARCHAR(20))
		WHEN 'varchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'nvarchar' THEN CAST(TYPE.NAME + '(' + CAST(COL.LENGTH AS VARCHAR(5)) + ')' AS VARCHAR(20))
		WHEN 'decimal' THEN CAST(TYPE.NAME + '(' + CAST(COL.PREC AS VARCHAR(3)) + ', ' + CAST(COL.SCALE AS VARCHAR(3)) + ')' AS VARCHAR(20))
		ELSE CAST(TYPE.NAME AS VARCHAR(20))
	END,
	--COL.LENGTH,
	--COL.PREC,
	--COL.SCALE,
	DIRECTION =
	CASE COL.ISOUTPARAM
		WHEN 1 THEN 'OUT'
		ELSE 'IN'
	END,
	NULLABLE =
	CASE COL.ISNULLABLE
		WHEN 0 THEN 'NOT NULL'
		WHEN 1 THEN 'NULL'
		ELSE 'UNKNOWN'
	END,
	OBJ.XTYPE,
	CASE OBJ.XTYPE
		WHEN 'C' THEN 'CHECK constraint'
		WHEN 'D' THEN 'Default or DEFAULT constraint'
		WHEN 'F' THEN 'FOREIGN KEY constraint'
		WHEN 'L' THEN 'Log'
		WHEN 'FN' THEN 'Scalar function'
		WHEN 'IF' THEN 'Inlined table-function'
		WHEN 'P' THEN 'Stored procedure'
		WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
		WHEN 'RF' THEN 'Replication filter stored procedure'
		WHEN 'S' THEN 'System table'
		WHEN 'TF' THEN 'Table function'
		WHEN 'TR' THEN 'Table Trigger'
		WHEN 'U' THEN 'User table'
		WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
		WHEN 'V' THEN 'View'
		WHEN 'X' THEN 'Extended stored procedure'
		ELSE 'UNKNOWN'
	END AS OBJECT_TYPE,
	CASE
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsClustKey') = 1 THEN 'Constraint - A primary key with a clustered index.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsColumn') = 1 THEN 'Constraint - COLUMN constraint.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsDeleteCascade') = 1 THEN 'Constraint - A foreign key constraint with the ON DELETE CASCADE option.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsDisabled') = 1 THEN 'Constraint - Disabled constraint.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsNonclustKey') = 1 THEN 'Constraint - A primary key with a nonclustered index.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsNotTrusted') = 1 THEN 'Constraint - Constraint was enabled without checking existing rows, so constraint may not hold for all rows.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsNotRepl') = 1 THEN 'Constraint - The constraint is defined with the NOT FOR REPLICATION keywords.'
		WHEN OBJECTPROPERTY(OBJ.id, N'CnstIsUpdateCascade') = 1 THEN 'Constraint - A foreign key constraint with the ON UPDATE CASCADE option.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsAfterTrigger') = 1 THEN 'Trigger - AFTER trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsAnsiNullsOn') = 1 THEN 'Scalar and Inline Table-valued Function, Procedure, Trigger, View - The setting of ANSI_NULLS at creation time.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsDeleteTrigger') = 1 THEN 'Trigger - DELETE trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsFirstDeleteTrigger') = 1 THEN 'Trigger - The first trigger fired when a DELETE is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsFirstInsertTrigger') = 1 THEN 'Trigger - The first trigger fired when an INSERT is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsFirstUpdateTrigger') = 1 THEN 'Trigger - The first trigger fired when an UPDATE is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsInsertTrigger') = 1 THEN 'Trigger - INSERT trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsInsteadOfTrigger') = 1 THEN 'Trigger - INSTEAD OF trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsLastDeleteTrigger') = 1 THEN 'Trigger - The last trigger fired when a DELETE is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsLastInsertTrigger') = 1 THEN 'Trigger - The last trigger fired when an INSERT is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsLastUpdateTrigger') = 1 THEN 'Trigger - The last trigger fired when an UPDATE is executed against the table.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsQuotedIdentOn') = 1 THEN 'Scalar and Inline Table-valued Function, Procedure, Trigger, View - The setting of QUOTED_IDENTIFIER at creation time.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsStartup') = 1 THEN 'Procedure - Startup procedure.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsTriggerDisabled') = 1 THEN 'Trigger - Disabled trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'ExecIsUpdateTrigger') = 1 THEN 'Trigger - UPDATE trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'HasAfterTrigger') = 1 THEN 'Table, View - Table or view has an AFTER trigger.'
		WHEN OBJECTPROPERTY(OBJ.id, N'HasDeleteTrigger') = 1 THEN 'Table, View - Table or view has a DELETE trigger.'
		ELSE 'UNKNOW PROPERTY'
	END AS OBJECT_PROP,
	COL.COLORDER AS OBJ_INDEX
--	,OBJ.CATEGORY
	FROM
		SYSOBJECTS AS OBJ
			LEFT JOIN SYSCOLUMNS AS COL
				ON OBJ.ID = COL.ID
			LEFT JOIN SYSTYPES AS TYPE
				ON COL.XTYPE = TYPE.XTYPE
		WHERE
			OBJ.xtype in
			(
				'C',
				'D',
				'F',
				'FN',
				'IF',
				'P',
				'RF',
				--'S',
				'TF',
				'TR',
				'U',
				'UQ',
				'V',
				'X'
			)
			AND NOT
			(
				(OBJ.XTYPE = 'P' AND OBJ.CATEGORY = 2)
				OR (OBJ.XTYPE = 'V' AND OBJ.CATEGORY = 2)
			) -- NOT SELECTING SYSTEM PROCEDURE
GO




/*------------------------------     TN USEFULL PROCEDURE      ------------------------------*/

/*---------------     _DESC    ---------------*/

DROP PROCEDURE _DESC
GO

CREATE Procedure _DESC
--ALTER PROCEDURE _DESC
(
        @OBJ_NAME VARCHAR(50) = NULL
)
AS

BEGIN
	-- TABLE NAME CHECK
	IF @OBJ_NAME IS NULL
		SELECT OBJECT_NAME, COLUMN_NAME, DATA_TYPE, DIRECTION, NULLABLE, XTYPE, OBJECT_TYPE, OBJECT_PROP, OBJ_INDEX
			FROM _VW_DESC
				ORDER BY
					OBJECT_TYPE,
					OBJECT_NAME,
					OBJ_INDEX;
	ELSE
	BEGIN
		IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[' + @OBJ_NAME + ']') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			SELECT OBJECT_NAME, COLUMN_NAME, DATA_TYPE, NULLABLE, OBJECT_TYPE
				FROM _VW_DESC WHERE OBJECT_NAME LIKE '%' + @OBJ_NAME
					ORDER BY
						OBJECT_TYPE,
						OBJECT_NAME,
						OBJ_INDEX;
		END
		ELSE IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[' + @OBJ_NAME + ']') AND XTYPE = 'V')
		BEGIN
			SELECT OBJECT_NAME, COLUMN_NAME, DATA_TYPE, NULLABLE, OBJECT_TYPE
				FROM _VW_DESC WHERE OBJECT_NAME LIKE '%' + @OBJ_NAME
					ORDER BY
						OBJECT_TYPE,
						OBJECT_NAME,
						OBJ_INDEX;
		END
		ELSE IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[' + @OBJ_NAME + ']') AND XTYPE = 'P')
		BEGIN
			SELECT OBJECT_NAME, COLUMN_NAME, DATA_TYPE, DIRECTION, NULLABLE, OBJECT_TYPE
				FROM _VW_DESC WHERE OBJECT_NAME LIKE '%' + @OBJ_NAME
					ORDER BY
						OBJECT_TYPE,
						OBJECT_NAME,
						OBJ_INDEX;
		END
		ELSE IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[' + @OBJ_NAME + ']') AND XTYPE = 'TR')
		BEGIN
			SELECT OBJECT_NAME, OBJECT_TYPE, OBJECT_PROP
				FROM _VW_DESC WHERE OBJECT_NAME LIKE '%' + @OBJ_NAME
					ORDER BY
						OBJECT_TYPE,
						OBJECT_NAME,
						OBJ_INDEX;
		END
		ELSE IF EXISTS (SELECT * FROM dbo.sysobjects WHERE NAME LIKE @OBJ_NAME + '%' and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			SELECT OBJECT_NAME, COLUMN_NAME, DATA_TYPE, NULLABLE, OBJECT_TYPE
				FROM _VW_DESC WHERE OBJECT_NAME LIKE @OBJ_NAME + '%'
					ORDER BY
						OBJECT_TYPE,
						OBJECT_NAME,
						OBJ_INDEX;
		END
		ELSE IF EXISTS (SELECT * FROM dbo.sysobjects WHERE NAME LIKE @OBJ_NAME + '%' AND XTYPE = 'V')
		BEGIN
			SELECT OBJECT_NAME, COLUMN_NAME, DATA_TYPE, NULLABLE, OBJECT_TYPE
				FROM _VW_DESC WHERE OBJECT_NAME LIKE @OBJ_NAME + '%'
					ORDER BY
						OBJECT_TYPE,
						OBJECT_NAME,
						OBJ_INDEX;
		END
		ELSE IF EXISTS (SELECT * FROM dbo.sysobjects WHERE NAME LIKE @OBJ_NAME + '%' AND XTYPE = 'P')
		BEGIN
			SELECT OBJECT_NAME, COLUMN_NAME, DATA_TYPE, DIRECTION, NULLABLE, OBJECT_TYPE
				FROM _VW_DESC WHERE OBJECT_NAME LIKE @OBJ_NAME + '%'
					ORDER BY
						OBJECT_TYPE,
						OBJECT_NAME,
						OBJ_INDEX;
		END
		ELSE
		BEGIN
				GOTO OBJECT_NAME_NOT_FOUND
		END
	END
	GOTO CLEAN_UP
END

OBJECT_NAME_NOT_FOUND:
        PRINT 'OBJECT ''' + @OBJ_NAME + ''' DOES NOT EXIST'
        GOTO CLEAN_UP

CLEAN_UP:
        return
GO

SELECT * FROM _VW_DESC WHERE OBJECT_TYPE IN ('Stored procedure', 'Scalar function');





/*---------------     _ALL_TABLES    ---------------*/

DROP PROCEDURE TN_ALL_TABLES

CREATE Procedure TN_ALL_TABLES
--ALTER Procedure TN_ALL_TABLES
AS
BEGIN
	SELECT OBJECT_NAME, COLUMN_NAME, DATA_TYPE, NULLABLE, OBJECT_TYPE FROM _VW_DESC WHERE OBJECT_TYPE = 'User table';
END
RETURN


DROP PROCEDURE _ALL_USER_TABLES

CREATE Procedure _ALL_USER_TABLES
--ALTER Procedure _ALL_USER_TABLES
AS

BEGIN
	SELECT
		CAST(OBJ.NAME AS VARCHAR(30)) AS TABLE_NAME,
		CAST(COL.NAME AS VARCHAR(30)) AS COLUMN_NAME,
		CAST(TYPE.NAME AS VARCHAR(16)) AS DB_TYPE,
		COL.LENGTH,
		COL.PREC,
		COL.SCALE,
		NULLABLE =
		CASE COL.ISNULLABLE
			WHEN 0 THEN 'NO'
			WHEN 1 THEN 'YES'
			ELSE 'UNKNOWN'
		END,
		CASE OBJ.XTYPE
			WHEN 'C' THEN 'CHECK constraint'
			WHEN 'D' THEN 'Default or DEFAULT constraint'
			WHEN 'F' THEN 'FOREIGN KEY constraint'
			WHEN 'L' THEN 'Log'
			WHEN 'FN' THEN 'Scalar function'
			WHEN 'IF' THEN 'Inlined table-function'
			WHEN 'P' THEN 'Stored procedure'
			WHEN 'PK' THEN 'PRIMARY KEY constraint (type is K)'
			WHEN 'RF' THEN 'Replication filter stored procedure'
			WHEN 'S' THEN 'System table'
			WHEN 'TF' THEN 'Table function'
			WHEN 'U' THEN 'User table'
			WHEN 'UQ' THEN 'UNIQUE constraint (type is K)'
			WHEN 'V' THEN 'View'
			WHEN 'X' THEN 'Extended stored procedure'
			ELSE 'UNKNOWN'
		END AS OBJECT_TYPE
		FROM
			SYSOBJECTS AS OBJ
				INNER JOIN SYSCOLUMNS AS COL
					ON OBJ.ID = COL.ID
				INNER JOIN SYSTYPES AS TYPE
					ON COL.XTYPE = TYPE.XTYPE
			WHERE
				OBJ.xtype in ('U', 'TR', 'PK', 'F')
				ORDER BY
					OBJ.NAME,
					COL.COLORDER
		END
END
RETURN


/*------------------------------------------------------------
||	NAME		:	PROC_TN_TABLE_STATS
||	DESCRIPTION	:	To get an *approximate* ROW count for all tables
------------------------------------------------------------*/

DROP PROCEDURE PROC_TN_TABLE_STATS

CREATE Procedure PROC_TN_TABLE_STATS
--ALTER Procedure PROC_TN_TABLE_STATS
AS

BEGIN
	SELECT
		[TABLE_NAME] = SUBSTRING(SO.NAME, 1, 30),
		[ROW_COUNT] = MAX(SI.ROWS)
		FROM
			SYSOBJECTS SO INNER JOIN SYSINDEXES SI
				ON SI.ID = OBJECT_ID(SO.NAME)
			WHERE
				SO.XTYPE = 'U'
				GROUP BY
					SO.NAME
				ORDER BY
					1 DESC
END;









/*------------------------------------------------------------
||	NAME		:	PR_GEN_OBJ_SCRIPT
||	DESCRIPTION	:	Insert attachement record
||	CREATE		:
||	LAST UPDATE	:
------------------------------------------------------------*/

DROP PROCEDURE PR_GEN_OBJ_SCRIPT;

CREATE PROCEDURE PR_GEN_OBJ_SCRIPT
--ALTER PROCEDURE PR_GEN_OBJ_SCRIPT
(
	@SEARCH varchar(1000),
	@ROLE varchar(50)
)
AS

BEGIN
	DECLARE @RTN_VARCHAR VARCHAR(2000);
	DECLARE @EACH_COL varchar(50)


	DECLARE ALL_TABLE_CUR CURSOR FOR
		SELECT NAME FROM SYSOBJECTS WHERE XTYPE = 'U' AND NAME LIKE '%' + @SEARCH + '%' ORDER BY NAME;

	DECLARE ALL_VIEWS_CUR CURSOR FOR
		SELECT NAME FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME LIKE '%' + @SEARCH + '%' ORDER BY NAME;

	DECLARE ALL_PROCS_CUR CURSOR FOR
		SELECT NAME FROM SYSOBJECTS WHERE XTYPE = 'P' AND NAME LIKE '%' + @SEARCH + '%' ORDER BY NAME;

	PRINT '/*------------------------------          GRANT ACCESS RIGHT         ------------------------------*/' + CHAR(10) + CHAR(10);

	OPEN ALL_TABLE_CUR
	FETCH NEXT FROM ALL_TABLE_CUR INTO @EACH_COL
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @@ERROR = 0
		BEGIN
			PRINT 'GRANT SELECT, UPDATE, INSERT, DELETE ON ' + @EACH_COL + ' TO ' + @ROLE + ';'
			IF @@ERROR <> 0
			BEGIN
				GOTO CLEAN_UP
			END
		END
		FETCH NEXT FROM ALL_TABLE_CUR INTO @EACH_COL
	END
	CLOSE ALL_TABLE_CUR

	PRINT CHAR(10);

	OPEN ALL_VIEWS_CUR
	FETCH NEXT FROM ALL_VIEWS_CUR INTO @EACH_COL
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @@ERROR = 0
		BEGIN
			PRINT 'GRANT SELECT ON ' + @EACH_COL + ' TO ' + @ROLE + ';'
			IF @@ERROR <> 0
			BEGIN
				GOTO CLEAN_UP
			END
		END
		FETCH NEXT FROM ALL_VIEWS_CUR INTO @EACH_COL
	END
	CLOSE ALL_VIEWS_CUR

	PRINT CHAR(10);

	OPEN ALL_PROCS_CUR
	FETCH NEXT FROM ALL_PROCS_CUR INTO @EACH_COL
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @@ERROR = 0
		BEGIN
			PRINT 'GRANT EXECUTE ON ' + @EACH_COL + ' TO ' + @ROLE + ';'
			IF @@ERROR <> 0
			BEGIN
				GOTO CLEAN_UP
			END
		END
		FETCH NEXT FROM ALL_PROCS_CUR INTO @EACH_COL
	END
	CLOSE ALL_PROCS_CUR

	PRINT CHAR(10) + CHAR(10) + CHAR(10);

	PRINT '/*------------------------------          DROP TABELS         ------------------------------*/' + CHAR(10) + CHAR(10);

	OPEN ALL_TABLE_CUR
	FETCH NEXT FROM ALL_TABLE_CUR INTO @EACH_COL
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @@ERROR = 0
		BEGIN
			PRINT 'DROP TABLE ' + @EACH_COL + ';'
			IF @@ERROR <> 0
			BEGIN
				GOTO CLEAN_UP
			END
		END
		FETCH NEXT FROM ALL_TABLE_CUR INTO @EACH_COL
	END
	CLOSE ALL_TABLE_CUR


CLEAN_UP:
	DEALLOCATE ALL_TABLE_CUR
	DEALLOCATE ALL_VIEWS_CUR
	DEALLOCATE ALL_PROCS_CUR
	PRINT CHAR(10) + CHAR(10) + CHAR(10);
	RETURN
END
GO

EXEC PR_GEN_OBJ_SCRIPT '', 'EDI_DB_Role';
GO

GRANT EXECUTE ON PR_GEN_OBJ_SCRIPT TO USER;







CREATE PROCEDURE ARRAY_TEST
--ALTER Procedure ARRAY_TEST
(
	@ID_ARRAY varchar(500)
)
AS
BEGIN
	SET NOCOUNT ON

	CREATE TABLE #ID_TMP
	(
		ID int
	)

	DECLARE @EACH_ID varchar(10)
	DECLARE @END_INDEX int

	SET @ID_ARRAY	= LTRIM(RTRIM(@ID_ARRAY)) + ','
	SET @END_INDEX	= CHARINDEX(',', @ID_ARRAY, 1)

	IF REPLACE(@ID_ARRAY, ',', '') <> ''
	BEGIN
		WHILE @END_INDEX > 0
		BEGIN
			SET @EACH_ID = LTRIM(RTRIM(LEFT(@ID_ARRAY, @END_INDEX - 1)))
			IF @EACH_ID <> ''
			BEGIN
				INSERT INTO #ID_TMP (ID) VALUES (CAST(@EACH_ID AS int)) --Use Appropriate conversion
			END
			SET @ID_ARRAY	= RIGHT(@ID_ARRAY, LEN(@ID_ARRAY) - @END_INDEX)
			SET @END_INDEX	= CHARINDEX(',', @ID_ARRAY, 1)
		END
	END

	SELECT * FROM #ID_TMP

END




CREATE PROCEDURE ARRAY_INSERT
--ALTER PROCEDURE ARRAY_INSERT
(
	@ID_ARRAY varchar(500),
	@OUT_STR varchar(100) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON

	CREATE TABLE #ID_TMP
	(
		ID int
	)

	DECLARE @EACH_ID varchar(10)
	DECLARE @END_INDEX int

	SET @ID_ARRAY	= LTRIM(RTRIM(@ID_ARRAY)) + ','
	SET @END_INDEX	= CHARINDEX(',', @ID_ARRAY, 1)

	IF REPLACE(@ID_ARRAY, ',', '') <> ''
	BEGIN
		WHILE @END_INDEX > 0
		BEGIN
			SET @EACH_ID = LTRIM(RTRIM(LEFT(@ID_ARRAY, @END_INDEX - 1)))
			IF @EACH_ID <> ''
			BEGIN
				INSERT INTO #ID_TMP (ID) VALUES (CAST(@EACH_ID AS int)) --Use Appropriate conversion
			END
			SET @ID_ARRAY	= RIGHT(@ID_ARRAY, LEN(@ID_ARRAY) - @END_INDEX)
			SET @END_INDEX	= CHARINDEX(',', @ID_ARRAY, 1)
		END
	END

	BEGIN TRAN
	DECLARE ARRAY_CUR CURSOR FOR
		SELECT ID FROM #ID_TMP

	OPEN ARRAY_CUR
	FETCH NEXT FROM ARRAY_CUR INTO @EACH_ID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'CURSOR ARRAY_CUR STARTED'
		IF @@ERROR = 0

		PRINT 'EACH_ID = ' + @EACH_ID

		FETCH NEXT FROM ARRAY_CUR INTO @EACH_ID
	END
	CLOSE ARRAY_CUR
	IF @@ERROR = 0
		COMMIT
	ELSE
		ROLLBACK

	SELECT @OUT_STR	= 'SELECT * FROM I_BRAND'
END

CLEAN_UP:
        RETURN
GO

GRANT EXEC ON ARRAY_INSERT TO Invoice

BEGIN

	DECLARE @OUT_STR varchar(100);

	EXEC ARRAY_INSERT '1,2,3,4,5', @OUT_STR;

	PRINT @OUT_STR;
END;
GO



CREATE PROCEDURE REPORT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @BUILD_TABLE_STR varchar(2000)
	DECLARE @EACH_COL varchar(50)

	SET @BUILD_TABLE_STR = 'CREATE TABLE COL_TMP'
	SET @BUILD_TABLE_STR = @BUILD_TABLE_STR + '('

	DECLARE NEW_TABLE_CUR CURSOR FOR
		SELECT NAME FROM SYSOBJECTS WHERE XTYPE = 'U' AND NAME LIKE 'TBL%'

	OPEN NEW_TABLE_CUR
	PRINT 'CURSOR NEW_TABLE_CUR START'
	FETCH NEXT FROM NEW_TABLE_CUR INTO @EACH_COL
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @@ERROR = 0
		BEGIN
			SET @BUILD_TABLE_STR = @BUILD_TABLE_STR + REPLACE(REPLACE(@EACH_COL, ' ', ''), '-', '') + ' int,'
			IF @@ERROR <> 0
			BEGIN
				PRINT 'ERROR'
				GOTO CLEAN_UP
			END
		END
		PRINT @BUILD_TABLE_STR
		FETCH NEXT FROM NEW_TABLE_CUR INTO @EACH_COL
	END
	CLOSE NEW_TABLE_CUR
	PRINT 'CURSOR NEW_TABLE_CUR END'
	SET @BUILD_TABLE_STR = RTRIM(SUBSTRING(@BUILD_TABLE_STR, 1, LEN(@BUILD_TABLE_STR-1)))
	SET @BUILD_TABLE_STR = @BUILD_TABLE_STR + ')'
	EXEC (@BUILD_TABLE_STR)
END

CLEAN_UP:
        RETURN
GO

EXEC REPORT
GO









/*---------------     CREATE TABLE FROM SELECT FROM EXISTING TABLE    ---------------*/

BEGIN
	DECLARE @FROM_TABLE varchar(30);
	DECLARE @NEW_TABLE varchar(30);

	SET @FROM_TABLE = 'EVT_TYPE';
	SET @NEW_TABLE	= 'NEW_TEST';

SELECT 'SELECT * INTO ' + @NEW_TABLE + ' FROM ' + @FROM_TABLE + ';' AS SQL_STATEMENT
END;
GO




/*---------------     GENERATE INSERT FROM EXISTING TABLE    ---------------*/

BEGIN
	DECLARE @FROM_TABLE varchar(30);
	DECLARE @TO_TABLE varchar(30);
	DECLARE @NUMBER_OF_COL INT;

	SET @FROM_TABLE = 'EVT_TYPE';
	SET @TO_TABLE	= 'NEW_TEST';
	SELECT @NUMBER_OF_COL = MAX(COLORDER) FROM SYSCOLUMNS WHERE ID = OBJECT_ID(@FROM_TABLE);

SELECT 'INSERT INTO ' + @TO_TABLE + ' (' AS COLUMN_NAME, 0 AS OBJ_INDEX
UNION ALL
SELECT
	CASE
		WHEN COL.COLORDER = @NUMBER_OF_COL THEN COL.NAME
		ELSE COL.NAME + ','
	END AS COLUMN_NAME,
	COL.COLORDER AS OBJ_INDEX
	FROM
		SYSOBJECTS AS OBJ
			LEFT JOIN SYSCOLUMNS AS COL
				ON OBJ.ID = COL.ID
		WHERE
			OBJ.xtype in('U')
			AND OBJ.NAME = @FROM_TABLE
UNION ALL
SELECT ') SELECT * FROM ' + @FROM_TABLE + ';' AS COLUMN_NAME, 9999 AS OBJ_INDEX
ORDER BY OBJ_INDEX;
END;
GO








CREATE TABLE Employees
(empid int NOT NULL,
 mgrid int NULL,
 empname varchar(25) NOT NULL,
 salary money NOT NULL,
 CONSTRAINT PK_Employees_empid PRIMARY KEY(empid))

INSERT INTO employees(empid, mgrid, empname, salary)
  VALUES( 1, NULL, 'Nancy',  $10000.00)
INSERT INTO employees(empid, mgrid, empname, salary)
  VALUES( 2,    1, 'Andrew',  $5000.00)
INSERT INTO employees(empid, mgrid, empname, salary)
  VALUES( 3,    1, 'Janet',   $5000.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES( 4
   1
'Margaret',$5000.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES( 5
   2
'Steven'
 $2500.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES( 6
   2
'Michael'
$2500.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES( 7
   3
'Robert'
 $2500.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES( 8
   3
'Laura'
  $2500.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES( 9
   3
'Ann'
    $2500.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES(10
   4
'Ina'
    $2500.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES(11
   7
'David'
  $2000.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES(12
   7
'Ron'
    $2000.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES(13
   7
'Dan'
    $2000.00)
INSERT INTO employees(empid
mgrid
empname
salary)
  VALUES(14
  11
'James'
  $1500.00)


ALTER TABLE Employees ADD CONSTRAINT FK_Employees_Employees
  FOREIGN KEY(mgrid)
  REFERENCES Employees(empid)


ALTER TABLE Employees DROP CONSTRAINT FK_Employees_Employees




CREATE TRIGGER trg_d_employees_on_delete_cascade ON Employees FOR DELETE
AS

IF EXISTS
(
	SELECT *
		FROM
			Employees AS E
            JOIN deleted AS D ON E.mgrid = D.empid
)
  DELETE FROM Employees
  	FROM
		Employees AS E
		JOIN deleted AS D ON E.mgrid = D.empid



CREATE TRIGGER trg_d_employees_prevent_delete ON Employees FOR DELETE
AS

IF EXISTS(SELECT *
          FROM
              Employees AS E
            JOIN
              deleted   AS D ON E.mgrid = D.empid)
BEGIN
     RAISERROR ('The level for job_id:%d should be between %d and %d.', 16, 1, @@JOB_ID, @@MIN_LVL, @@MAX_LVL)

  ROLLBACK TRANSACTION
END



















































/*	Procedure for 8.0 server */
create procedure sp_tables(
			   @table_name		nvarchar(384)	= null,
			   @table_owner 	nvarchar(384)	= null,
			   @table_qualifier sysname	= null,
			   @table_type		varchar(100) = null)
as
	declare @type1 varchar(3)
	declare @tableindex int


	/* Special feature #1:	enumerate databases when owner and name
		 are blank but qualifier is explicitly '%'.  */
	if @table_qualifier = '%' and
		@table_owner = '' and
		@table_name = ''
	begin	/* If enumerating databases */
		select
			TABLE_QUALIFIER = convert(sysname,d.name),
			TABLE_OWNER = convert(sysname,null),
			TABLE_NAME = convert(sysname,null),
			TABLE_TYPE = convert(varchar(32),null),
			REMARKS = convert(varchar(254),null)	/* Remarks are NULL */
		from master.dbo.sysdatabases d
		where d.name <> 'model'	/* eliminate MODEL database */
		order by 1
	end

	/* Special feature #2:	enumerate owners when qualifier and name
		 are blank but owner is explicitly '%'.  */
	else if @table_qualifier = '' and
		@table_owner = '%' and
		@table_name = ''
	begin	/* If enumerating owners */
		select distinct
			TABLE_QUALIFIER = convert(sysname,null),
			TABLE_OWNER = convert(sysname,user_name(uid)),
			TABLE_NAME = convert(sysname,null),
			TABLE_TYPE = convert(varchar(32),null),
			REMARKS = convert(varchar(254),null)	/* Remarks are NULL */
		from sysobjects
		order by 2
	end

	/* Special feature #3:	enumerate table types when qualifier
owner and
		 name are blank but table type is explicitly '%'.	*/
	else if @table_qualifier = '' and
		@table_owner = '' and
		@table_name = '' and
		@table_type = '%'
	begin	/* If enumerating table types */
		select
			TABLE_QUALIFIER = convert(sysname,null),
			TABLE_OWNER = convert(sysname,null),
			TABLE_NAME = convert(sysname,null),
			TABLE_TYPE = convert(varchar(32),rtrim(substring('SYSTEM TABLETABLE       VIEW',(colid-1)*12+1,12))),
			REMARKS = convert(varchar(254),null)	/* Remarks are NULL */
		from sysobjects o
syscolumns c
		where o.id=c.id and o.name='sysusers' and colid<=3
	end

	else
	begin /* end of special features - do normal processing */
		if @table_qualifier is not null
		begin
			if db_name() <> @table_qualifier
			begin
				if @table_qualifier = ''
				begin  /* If empty qualifier supplied */
					/* Force an empty result set */
					select @table_name = ''
					select @table_owner = ''
				end
				else
				begin	/* If qualifier doesn't match current database */
					raiserror (15250, -1,-1)
					return
				end
			end
		end
		if @table_type is null
		begin	/* Select all ODBC supported table types */
			select @type1 = 'SUV'
		end
		else
		begin
			/*	TableType is case sensitive if CS server */
			select @type1 = ''
			if (charindex('''SYSTEM TABLE''',@table_type) <> 0)
				select @type1 = @type1 + 'S'	/* Add System Tables */
			if (charindex('''TABLE''',@table_type) <> 0)
				select @type1 = @type1 + 'U'	/* Add User Tables */
			if (charindex('''VIEW''',@table_type) <> 0)
				select @type1 = @type1 + 'V'	/* Add Views */
		end
		if @table_name is null
		begin	/*	If table name not supplied
match all */
			select @table_name = '%'
		end
		else
		begin
			if (@table_owner is null) and (charindex('%', @table_name) = 0)
			begin	/* If owner not specified and table is specified */
				if exists (select * from sysobjects
					where uid = user_id()
					and name = @table_name
					and (type = 'U' or type = 'V' or type = 'S'))
				begin	/* Override supplied owner w/owner of table */
					select @table_owner = user_name()
				end
			end
		end
		if @table_owner is null /* If no owner supplied
force wildcard */
			select @table_owner = '%'
		select
			TABLE_QUALIFIER = convert(sysname,db_name()),
			TABLE_OWNER = convert(sysname,user_name(o.uid)),
			TABLE_NAME = convert(sysname,o.name),	/* make nullable */
			TABLE_TYPE = convert(varchar(32),rtrim(
				substring('SYSTEM TABLE            TABLE       VIEW       ',
					(ascii(o.type)-83)*12+1,12))),	/* 'S'=0,'U'=2,'V'=3 */
			REMARKS = convert(varchar(254),null)	/* Remarks are NULL */
		from sysobjects o
		where
			o.name like @table_name
			and user_name(o.uid) like @table_owner
			and o.type in ('U','V','S')
			and charindex(substring(o.type,1,1),@type1) <> 0 /* Only desired types */
			and permissions (o.id)&4096 <> 0
		order by 4, 1, 2, 3
	end







/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     XML FUNCTION      ------------------------------*/

/*
||	Generate Xsd schema from Table
||
*/
DECLARE @MySchema xml
set @MySchema = (select * from acl_group for xml auto, elements, xmlschema('clientattributes'))
select @MySchema

































































































































SELECT sqltext.TEXT,
req.session_id,
req.status,
req.command,
req.cpu_time,
req.total_elapsed_time
FROM sys.dm_exec_requests req
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext

