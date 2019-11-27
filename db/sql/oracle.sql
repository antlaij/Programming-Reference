
/*------------------------------     System Administration      ------------------------------*/

/*-------------------------     PRIVILEGES      -------------------------*/

/*--------------------     GRANT      --------------------*/


GRANT ALTER, DELETE, EXECUTE, INDEX, INSERT, READ, REFERENCES, SELECT, UPDATE
  ON TABLE_NAME
  TO USER_NAME;




/*--------------------     REVOKE      --------------------*/

REVOKE ALTER, DELETE, EXECUTE, INDEX, INSERT, READ, REFERENCES, SELECT, UPDATE
  ON TABLE_NAME
  FROM USER_NAME;




/*-------------------------     USER      -------------------------*/

/*-----   IF PASSWORD EXPIRE   -----*/
select * from DBA_USERS;
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

/*-----   Default user in database   -----*/
sys/change_on_install,
system/manager,
sysman/oem_temp

/*-----   Add user in database   -----*/
CREATE USER USER_NAME IDENTIFIED BY PASSWORD DEFAULT TABLESPACE DEF_T TEMPORARY TABLESPACE T_NAME;
CREATE USER NEW_USERNAME IDENTIFIED BY PASSWORD;
GRANT CONNECT TO NEW_USERNAME;
GRANT RESOURCE TO NEW_USERNAME;

CREATE USER "NEW_USERNAME" PROFILE "DEFAULT" IDENTIFIED BY "mypassword" DEFAULT TABLESPACE "VPX" ACCOUNT UNLOCK;
grant connect to NEW_USERNAME;
grant resource to NEW_USERNAME;
grant create view to NEW_USERNAME;
grant create sequence to NEW_USERNAME;
grant create table to NEW_USERNAME;
grant create materialized view to NEW_USERNAME;
grant execute on dbms_lock to NEW_USERNAME;
grant execute on dbms_job to NEW_USERNAME;
grant select on dba_tablespaces to NEW_USERNAME;
grant select on dba_temp_files to NEW_USERNAME;
grant select on dba_data_files to NEW_USERNAME;
grant unlimited tablespace to NEW_USERNAME;

/*-----   Change user password   -----*/
alter user user_name identified by password;






/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Database Maintainance      ------------------------------*/

/*-----   CREATE SCHEMA   -----*/

CREATE SCHEMA AUTHORIZATION

/*-----   Export database   -----*/

EXP sys/change_on_install owner=SCHEMA_NAME file=Export_file.dump log=log_file.log
EXP omni_uk/omni_uk owner=omni_uk file=OMNI_2_0_4_3.dump log=OMNI_2_0_4_3.log
EXP acord2/acord2 owner=acord2 file=ACORD2_TMRS160_20070302.dump log=ACORD2_TMRS160_20070302.log

/*-----   EXPORT SOME TABLES FROM SCHEMA   -----*/
EXP omni_uk/omni_uk tables=(FAC_COMMON, FAC_UNDERWRITING_EXPENSE, FAC_TRANSACTION_COMMON, FAC_TRANSACTION_PREMIUM, FAC_JOURNAL, FAC_JOURNAL, CLM_MASTER, CLM_COVERAGES, CLM_TRANSACTIONS, TUW_MASTER, TUW_CONTRACT , TAC_STATS_HEADER, TAC_STATS, OI_CASH_RECEIPT, OI_CASH_ITEM, OI_CASH_MATCHES, OI_MATCHES) file=OMNI_2_0_4_3.dump log=OMNI_2_0_4_3.log




/*-----   Import database   -----*/

IMP MEDIA/MEDIAADMIN FULL=Y FILE=Z:\SQL_Backup\Oracle\MEDIA.dump log=Z:\SQL_Backup\Oracle\MEDIA.log




/*-----   v$session and V$SQL   -----*/


COLUMN SQL_TEXT FORMAT A200;

SELECT
  S.SID,
  --S.SERIAL#,
  --S.USERNAME,
  S.STATUS,
  S.SCHEMANAME,
  S.MACHINE,
  S.OSUSER,
  S.LOCKWAIT,
  --S.SERVER,
  --S.SCHEMA#,
  S.PROCESS,
  --S.TERMINAL,
  S.PROGRAM,
  S.LOGON_TIME,
  Q.SQL_TEXT
  FROM
    V$SESSION S LEFT JOIN V$SQL Q ON S.SQL_HASH_VALUE = Q.HASH_VALUE
    WHERE
      SCHEMANAME <> 'SYS'
      AND
      (
        S.SCHEMANAME = 'AMERICA\TMRW001530'
        OR S.OSUSER = 'ny54866'
      )
    ORDER BY
      s.SCHEMANAME,
      s.MACHINE,
      S.LOGON_TIME;



DESC V$SQLTEXT;
DESC V$SQLTEXT_WITH_NEWLINES;
DESC V$SQLXS;
DESC V$SQL_BIND_DATA;
DESC V$SQL_BIND_METADATA;
DESC V$SQL_CURSOR;
DESC V$SQL_PLAN;
DESC V$SQL_PLAN_STATISTICS;
DESC V$SQL_PLAN_STATISTICS_ALL;












  s.MODULE,
  s.LAST_CALL_ET,
  s.SADDR,
  s.USER#,
  s.AUDSID,
  s.PADDR,
  s.COMMAND,
  s.OWNERID,
  s.TADDR,
  s.TYPE,
  s.SQL_ADDRESS,
  s.SQL_HASH_VALUE,
  s.PREV_SQL_ADDR,
  s.PREV_HASH_VALUE,
  s.MODULE_HASH,
  s.ACTION,
  s.ACTION_HASH,
  s.CLIENT_INFO,
  s.FIXED_TABLE_SEQUENCE,
  s.ROW_WAIT_OBJ#,
  s.ROW_WAIT_FILE#,
  s.ROW_WAIT_BLOCK#,
  s.ROW_WAIT_ROW#,
  s.PDML_ENABLED,
  s.FAILOVER_TYPE,
  s.FAILOVER_METHOD,
  s.FAILED_OVER,
  s.RESOURCE_CONSUMER_GROUP,
  s.PDML_STATUS,
  s.PDDL_STATUS,
  s.PQ_STATUS,
  s.CURRENT_QUEUE_DURATION,
  s.CLIENT_IDENTIFIER




/*------------------------------------------------------------
||	DESCRIPTION	:	locked Table List
------------------------------------------------------------*/
/*-----   sys.GV_$LOCKED_OBJECT L, DBA_OBJECTS O, sys.GV_$SESSION S, sys.GV_$PROCESS P   -----*/

SELECT
  l.inst_id,
  SUBSTR(L.ORACLE_USERNAME,1,8) ORA_USER, SUBSTR(L.SESSION_ID,1,3) SID,
  S.serial#,
  SUBSTR(O.OWNER||'.'||O.OBJECT_NAME,1,40) OBJECT, P.SPID OS_PID,
  DECODE(
    L.LOCKED_MODE, 0,’NONE’,
    1,’NULL’,
    2,’ROW SHARE’,
    3,’ROW EXCLUSIVE’,
    4,’SHARE’,
    5,’SHARE ROW EXCLUSIVE’,
    6,’EXCLUSIVE’,
    NULL
  ) LOCK_MODE
  FROM
    sys.GV_$LOCKED_OBJECT L, DBA_OBJECTS O, sys.GV_$SESSION S, sys.GV_$PROCESS P
    WHERE
      L.OBJECT_ID = O.OBJECT_ID
      and l.inst_id = s.inst_id
      AND L.SESSION_ID = S.SID
      and s.inst_id = p.inst_id
      AND S.PADDR = P.ADDR(+)
      order by l.inst_id;





/*------------------------------------------------------------
||	DESCRIPTION	:	Generate Backup
------------------------------------------------------------*/

SPOOL PG_ACORD_DATA_TRANSFER.sql
SELECT TEXT FROM
(
SELECT LINE, TEXT FROMC
(
SELECT
  LINE,
  TYPE,
  --NAME
  --SUBSTR(TEXT,1,1000)
  DECODE(LINE, 1, 'CREATE OR REPLACE ' || TEXT, TEXT) TEXT
  FROM
    USER_SOURCE
    WHERE
      UPPER(NAME) IN
      (
        'PG_ACORD_DATA_TRANSFER'
      )
      AND TYPE = 'PACKAGE'
      ORDER BY
      NAME,
      TYPE,
      LINE
) UNION SELECT 999999999 AS LINE, '/' AS TEXT FROM DUAL
) ORDER BY LINE;
SELECT TEXT FROM
(
SELECT LINE, TEXT FROM
(
SELECT
  LINE,
  TYPE,
  --NAME
  --SUBSTR(TEXT,1,1000)
  DECODE(LINE, 1, 'CREATE OR REPLACE ' || TEXT, TEXT) TEXT
  FROM
    USER_SOURCE
    WHERE
      UPPER(NAME) IN
      (
        'PG_ACORD_DATA_TRANSFER'
      )
      AND TYPE = 'PACKAGE BODY'
      ORDER BY
      NAME,
      TYPE,
      LINE
) UNION SELECT 999999999 AS LINE, '/' AS TEXT FROM DUAL
) ORDER BY LINE;
SPOOL OFF;




/*------------------------------------------------------------
||	DESCRIPTION	:	Generate UPDATE SQL
------------------------------------------------------------*/


set serveroutput on
set define off
declare
  IN_TABLE_NAME   varchar2(40) := 'ARD_EDI_FILE';
  IN_KEY_COLUMN   varchar2(40) := 'ARD_EDI_FILE_PK';
  IN_KEY_VALUE    varchar2(100) := 'D3F8DE4497944170A4A2B23A24074252';
  L_DATA          varchar2(4000) := NULL;
  L_SQL           varchar2(4000) := NULL;

  CURSOR DATA_CUR IS
  SELECT
    C.*
    FROM
      COLS C
      WHERE
        C.TABLE_NAME = IN_TABLE_NAME
        ORDER BY C.COLUMN_ID;
BEGIN

  Dbms_output.enable;
  dbms_output.put_line('');
  dbms_output.put_line('UPDATE ' || IN_TABLE_NAME || ' SET');

  FOR DATA_RT IN DATA_CUR
  LOOP
    L_SQL	:= 'SELECT ' || DATA_RT.COLUMN_NAME || ' INTO L_DATA FROM ' || IN_TABLE_NAME || ' WHERE ' || IN_KEY_COLUMN || ' = ''' || IN_KEY_VALUE || '''';
    DBMS_OUTPUT.PUT_LINE(L_SQL || ';');
--		EXECUTE IMMEDIATE L_SQL;
    DBMS_OUTPUT.PUT_LINE(DATA_RT.COLUMN_NAME || CHR(9) || ' = ' || CHR(9) || L_DATA || ',');

  END LOOP;

END;
/



/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Database Information      ------------------------------*/

System Table                        Description

ALL_ARGUMENTS                       Arguments in object accessible to the user
ALL_CATALOG                         All tables, views, synonyms, sequences accessible to the user
ALL_COL_COMMENTS                    Comments on columns of accessible tables and views
ALL_CONSTRAINTS                     Constraint definitions on accessible tables
ALL_CONS_COLUMNS                    Information about accessible columns in constraint definitions
ALL_DB_LINKS                        Database links accessible to the user
ALL_ERRORS                          Current errors on stored objects that user is allowed to create
ALL_INDEXES                         Descriptions of indexes on tables accessible to the user
ALL_IND_COLUMNS                     COLUMNs comprising INDEXes on accessible TABLES
ALL_LOBS                            Description of LOBs contained in tables accessible to the user
ALL_OBJECTS                         Objects accessible to the user
ALL_OBJECT_TABLES                   Description of all object tables accessible to the user
ALL_SEQUENCES                       Description of SEQUENCEs accessible to the user
ALL_SNAPSHOTS                       Snapshots the user can access
ALL_SOURCE                          Current source on stored objects that user is allowed to create
ALL_SYNONYMS                        All synonyms accessible to the user
ALL_TABLES                          Description of relational tables accessible to the user
ALL_TAB_COLUMNS                     Columns of user's tables, views and clusters
ALL_TAB_COL_STATISTICS              Columns of user's tables, views and clusters
ALL_TAB_COMMENTS                    Comments on tables and views accessible to the user
ALL_TRIGGERS                        Triggers accessible to the current user
ALL_TRIGGER_COLS                    Column usage in user's triggers or in triggers on user's tables
ALL_TYPES                           Description of types accessible to the user
ALL_UPDATABLE_COLUMNS               Description of all updatable columns
ALL_USERS                           Information about all users of the database
ALL_VIEWS                           Description of views accessible to the user
DATABASE_COMPATIBLE_LEVEL           Database compatible parameter set via init.ora
DBA_DB_LINKS                        All database links in the database
DBA_ERRORS                          Current errors on all stored objects in the database
DBA_OBJECTS                         All objects in the database
DBA_ROLES                           All Roles which exist in the database
DBA_ROLE_PRIVS                      Roles granted to users and roles
DBA_SOURCE                          Source of all stored objects in the database
DBA_TABLESPACES                     Description of all tablespaces
DBA_TAB_PRIVS                       All grants on objects in the database
DBA_TRIGGERS                        All triggers in the database
DBA_TS_QUOTAS                       Tablespace quotas for all users
DBA_USERS                           Information about all users of the database
DBA_VIEWS                           Description of all views in the database
DICTIONARY                          Description of data dictionary tables and views
DICT_COLUMNS                        Description of columns in data dictionary tables and views
GLOBAL_NAME                         global database name
NLS_DATABASE_PARAMETERS             Permanent NLS parameters of the database
NLS_INSTANCE_PARAMETERS             NLS parameters of the instance
NLS_SESSION_PARAMETERS              NLS parameters of the user session
PRODUCT_COMPONENT_VERSION           version and status information for component products
ROLE_TAB_PRIVS                      Table privileges granted to roles
SESSION_PRIVS                       Privileges which the user currently has set
SESSION_ROLES                       Roles which the user currently has enabled.
SYSTEM_PRIVILEGE_MAP                Description table for privilege type codes. Maps privilege type numbers to type names
TABLE_PRIVILEGES                    Grants on objects for which the user is the grantor, grantee, owner, or an enabled role or PUBLIC is the grantee
TABLE_PRIVILEGE_MAP                 Description table for privilege (auditing option) type codes. Maps privilege (auditing option) type numbers to type names


USER_OBJECTS

/*-----   LIST ALL DATABASE USER   -----*/

SELECT * FROM ALL_USERS ORDER BY USERNAME;




/*-----   ROW COUNT FOR ALL TABLES   -----*/

SELECT 'SELECT COUNT(*) FROM ' || OWNER || '.' || TABLE_NAME || ';' FROM DBA_TABLES WHERE OWNER = 'BCHU';

SELECT
  TABLE_NAME,
  TO_NUMBER
  (
    EXTRACTVALUE
    (
      xmltype(dbms_xmlgen.getxml('select count(*) c from '||table_name))
      ,'/ROWSET/ROW/C'
    )
  ) COUNT
  FROM USER_TABLES
  WHERE IOT_TYPE != 'IOT_OVERFLOW'
  OR    IOT_TYPE IS NULL;



/*-----   ALL_OBJECTS   -----*/

SELECT
  OWNER,
  OBJECT_NAME,
  --SUBOBJECT_NAME,
  OBJECT_ID,
  DATA_OBJECT_ID,
  OBJECT_TYPE,
  CREATED,
  LAST_DDL_TIME,
  TIMESTAMP,
  STATUS,
  TEMPORARY,
  GENERATED,
  SECONDARY
  FROM
    ALL_OBJECTS
    WHERE
      --OWNER = 'ACORD2'
      OBJECT_NAME LIKE 'PG_ACORD_PREMIUM_TRANSFER%'
      ORDER BY
        OBJECT_NAME,
        OBJECT_TYPE;

Name                                      Null?    Type
----------------------------------------- -------- ----------------------------
OWNER                                     NOT NULL VARCHAR2(30)
OBJECT_NAME                               NOT NULL VARCHAR2(30)
SUBOBJECT_NAME                                     VARCHAR2(30)
OBJECT_ID                                 NOT NULL NUMBER
DATA_OBJECT_ID                                     NUMBER
OBJECT_TYPE                                        VARCHAR2(18)
CREATED                                   NOT NULL DATE
LAST_DDL_TIME                             NOT NULL DATE
TIMESTAMP                                          VARCHAR2(19)
STATUS                                             VARCHAR2(7)
TEMPORARY                                          VARCHAR2(1)
GENERATED                                          VARCHAR2(1)
SECONDARY                                          VARCHAR2(1)


CONSUMER GROUP
FUNCTION
INDEX
PACKAGE
PACKAGE BODY
PROCEDURE
SYNONYM
TABLE
TYPE
VIEW

/*-----   USER_OBJECTS   -----*/


SELECT
  OBJECT_TYPE,
  SUBSTR(OBJECT_NAME,1,40) OBJECT_NAME,
  STATUS,
  GENERATED,
  --SUBOBJECT_NAME,
  OBJECT_ID,
  DATA_OBJECT_ID,
  CREATED,
  LAST_DDL_TIME,
  TIMESTAMP,
  TEMPORARY,
  SECONDARY
  FROM
    USER_OBJECTS
    WHERE
      OBJECT_TYPE IN
      (
        'CONSUMER GROUP',
        'FUNCTION',
        'INDEX',
        'PACKAGE BODY',
        'PACKAGE',
        'PROCEDURE',
        'SEQUENCE',
        'SYNONYM',
        'TABLE',
        'TRIGGER',
        'TYPE',
        'VIEW'
      )
      --AND OBJECT_NAME LIKE '%FN_VALIDATE_CLM_MASTER%'
      AND STATUS <> 'VALID'
      ORDER BY
        OBJECT_TYPE,
        OBJECT_NAME;

SPOOL ANTL;
SELECT
  'ALTER ' || DECODE(OBJECT_TYPE,'PACKAGE BODY', 'PACKAGE', OBJECT_TYPE) || ' ' || OBJECT_NAME || ' COMPILE ' || DECODE(OBJECT_TYPE,'PACKAGE BODY', 'BODY', NULL) || ';'
  FROM
    USER_OBJECTS
    WHERE
      OBJECT_TYPE IN
      (
        'CONSUMER GROUP',
        'FUNCTION',
        'INDEX',
        'PACKAGE BODY',
        'PACKAGE',
        'PROCEDURE',
        'SEQUENCE',
        'SYNONYM',
        'TABLE',
        'TRIGGER',
        'TYPE',
        'VIEW'
      )
      --AND OBJECT_NAME LIKE '%PG_FAC_ENDORSEMENT%'
      AND STATUS <> 'VALID'
      ORDER BY
        OBJECT_TYPE,
        OBJECT_NAME;
SPOOL OFF;



/*-----   USER_VIEWS   -----*/

SELECT
  V.OWNER,
  VIEW_NAME,
  VIEW_TYPE,
  O.CREATED,
  O.LAST_DDL_TIME,
  O.TIMESTAMP,
  O.STATUS,
  O.OBJECT_ID
  FROM
    ALL_VIEWS V INNER JOIN ALL_OBJECTS O ON V.VIEW_NAME = O.OBJECT_NAME AND V.OWNER = O.OWNER AND O.OBJECT_TYPE = 'VIEW'
    WHERE
      V.VIEW_NAME LIKE 'VW_ARD%'
    ORDER BY
      V.OWNER, V.VIEW_NAME;

SELECT * FROM USER_OBJECTS WHERE OBJECT_NAME LIKE 'PG_ACORD%';




/*-----   USER_DB_LINKS   -----*/
SELECT * FROM USER_DB_LINKS;

CREATE DATABASE LINK DB_LINK_NAME
CONNECT TO USERNAME
IDENTIFIED BY PASSWORD
USING 'TNS_NAME';


/*-----   GLOBAL_NAME   -----*/
SELECT * FROM GLOBAL_NAME;


/*-----   SELECT ALL TABLES FROM DBA_TABLES   -----*/
SELECT * FROM DBA_TABLES;


/*-----   SELECT ALL TABLES FROM DBA_TAB_COLUMNS   -----*/
SELECT * FROM DBA_TAB_COLUMNS;


/*-----   ALL_USERS   -----*/
SELECT * FROM ALL_USERS;


/*-----   Select all tables from database   -----*/
SELECT TABLE_NAME, OWNER FROM ALL_TABLES
WHERE TABLE_NAME LIKE 'FAC_%'
AND OWNER = 'OMNI'
ORDER BY TABLE_NAME;


/*-----   Select all tables from database   -----*/
SELECT TABLE_NAME, OWNER FROM ALL_TRIGGERS WHERE TABLE_NAME LIKE 'TUW_CONTRACT%'
AND OWNER = 'OMNI'
ORDER BY TABLE_NAME;

ALTER TRIGGER trigger_name DISABLE;
ALTER TRIGGER <TRIGGER_NAME> {DISABLE|ENABLE};




/*-----   ALL OBJECTS from database   -----*/

SELECT
  OBJECT_TYPE,
  OBJECT_NAME,
  --OBJECT_ID,
  --DATA_OBJECT_ID,
  CREATED,
  LAST_DDL_TIME,
  TIMESTAMP,
  STATUS
  FROM
    ALL_OBJECTS
      WHERE
      OBJECT_TYPE = 'TABLE'
      AND OBJECT_NAME LIKE 'FAC%'
      ORDER BY
        CREATED,
        OBJECT_TYPE,
        OBJECT_NAME


CLEAR COLUMNS;
COLUMN OBJECT_TYPE HEADING 'OBJECT TYPE' FORMAT A20;
COLUMN OBJECT_NAME FORMAT A32;
SET PAGESIZE 47;
SET LINESIZE 105;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

TTITLE 'ORACLE OBJECT LIST';
BREAK ON REPORT ON OBJECT_TYPE SKIP 1;
COMPUTE COUNT LABEL 'TOTAL' OF OBJECT_TYPE ON REPORT;

SELECT
  OBJECT_TYPE,
  OBJECT_NAME,
  --OBJECT_ID,
  --DATA_OBJECT_ID,
  CREATED,
  LAST_DDL_TIME,
  TIMESTAMP,
  STATUS
  FROM
    ALL_OBJECTS
      ORDER BY
        OBJECT_TYPE,
        OBJECT_NAME;

SET PAGESIZE 1000;
SET LINESIZE 32000;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
TTITLE OFF;
CLEAR BREAK;
CLEAR COLUMN;


/*-----   USER OBJECTS from database   -----*/

CLEAR COLUMNS;
COLUMN OBJECT_TYPE HEADING 'OBJECT TYPE' FORMAT A20;
COLUMN OBJECT_NAME FORMAT A32;
SET PAGESIZE 47;
SET LINESIZE 105;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

TTITLE 'ORACLE OBJECT LIST';
BREAK ON REPORT ON OBJECT_TYPE SKIP 1;
COMPUTE COUNT LABEL 'TOTAL' OF OBJECT_TYPE ON REPORT;

SELECT
  OBJECT_TYPE,
  OBJECT_NAME,
  --OBJECT_ID,
  --DATA_OBJECT_ID,
  CREATED,
  LAST_DDL_TIME,
  TIMESTAMP,
  STATUS
  FROM
    USER_OBJECTS
      ORDER BY
        OBJECT_TYPE,
        OBJECT_NAME;

SET PAGESIZE 1000;
SET LINESIZE 32000;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
TTITLE OFF;
CLEAR BREAK;
CLEAR COLUMN;

SELECT
  DISTINCT OBJECT_TYPE
  FROM
    USER_OBJECTS
    ORDER BY
        OBJECT_TYPE;




/*-----   Select all user constraints from database   -----*/
SELECT * FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE '%FKC_FAC_COMMON_DEP%';
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'CLAIM' AND CONSTRAINT_NAME LIKE '%%' ORDER BY CONSTRAINT_NAME;

/*-----   Select all user constraints from database   -----*/
SELECT * FROM ALL_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE '%XPKGT_GUARD_MRG_UNIT%';

SELECT TABLE_NAME
FROM ALL_CONSTRAINTS
WHERE CONSTRAINT_TYPE='R'
AND R_CONSTRAINT_NAME IN
  (SELECT CONSTRAINT_NAME
  FROM ALL_CONSTRAINTS
  WHERE CONSTRAINT_TYPE IN ('P','U')
  AND TABLE_NAME='<YOUR TABLE HERE>');

/*-----   View the table definition   -----*/
DESC TEMP_TABLE

/*-----   Select all user tables from database   -----*/
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE '%CON%';
SELECT 'SELECT ''' || TABLE_NAME || ''' AS TABLE_NAME, COUNT(*) FROM ' || TABLE_NAME || ' ' || 'UNION' AS SCRIPT FROM USER_TABLES ORDER BY TABLE_NAME;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE '%CON%';

/*-----   Select all columns from database   -----*/
SELECT * FROM COLS WHERE COLUMN_NAME LIKE '%MR_UW_OFFICE_ID%';

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_LENGTH, DATA_PRECISION, DATA_SCALE, NULLABLE FROM COLS WHERE TABLE_NAME = 'TAC_STATS'




/*-----   Select all VIEW from database   -----*/
SELECT VIEW_NAME FROM USER_VIEWS;

set head off
set long 100000
column xyz format a1000
column exeChar format a1000
set lines 1000
Spool def_views_123456789.sql

Prompt spool def_views_123456789.lst

select  chr(10)||chr(10)||chr(10)||
        '--***************************************************'||chr(10)||
        'prompt -- '||view_name||chr(10)||
        '--***************************************************'||chr(10)||
        'create or replace view '||view_name||' as ' as xyz
,text as xyz
,'/' as exeChar
from USER_VIEWS
Where owner = 'OMNI'
AND ROWNUM < 2;
Prompt spool off
Spool off



/*-----   Select all VIEW from database   -----*/
SELECT * FROM USER_CONS_COLUMNS WHERE CONSTRAINT_NAME LIKE '%CONSTRAINT_NAME%';


/*-----   CHECK TABLE CONSTRAINTS   -----*/

SELECT
  COL_00.CONSTRAINT_NAME,
  C.TABLE_NAME,
  SUBSTR(COL_00.COLUMN_NAME,1,40) COL_NAME,
  COL_01.TABLE_NAME REF_TABLE_NAME,
  SUBSTR(COL_01.COLUMN_NAME, 1, 40) REF_COLUMN_NAME,
  COL_01.CONSTRAINT_NAME REF_CONSTRAINT
  FROM
      USER_CONSTRAINTS C
         INNER JOIN USER_CONS_COLUMNS COL_00 ON C.CONSTRAINT_NAME = COL_00.CONSTRAINT_NAME
         INNER JOIN USER_CONS_COLUMNS COL_01 ON C.R_CONSTRAINT_NAME = COL_01.CONSTRAINT_NAME And COL_00.POSITION = COL_01.POSITION
      where C.status = 'ENABLED'
    --WHERE c.Table_name = 'APP_SECURITY_USERS'
      --where COL_01.TABLE_NAME = 'APP_SECURITY_USERS'
    ORDER BY
      C.TABLE_NAME,
      COL_00.CONSTRAINT_NAME,
      COL_00.POSITION;

SELECT
  A.CONSTRAINT_NAME,
  C.TABLE_NAME,
  SUBSTR(A.COLUMN_NAME,1,40) COL_NAME,
  B.TABLE_NAME REF_TABLE_NAME,
  SUBSTR(B.COLUMN_NAME, 1, 40) REF_COLUMN_NAME,
  B.CONSTRAINT_NAME REF_CONSTRAINT
  FROM
    USER_CONSTRAINTS C,
    USER_CONS_COLUMNS A,
    USER_CONS_COLUMNS B
  WHERE
    C.TABLE_NAME='ICT_CONTRACTCOVERAGEDEDUCT'
    AND C.CONSTRAINT_NAME = A.CONSTRAINT_NAME
    AND C.R_CONSTRAINT_NAME = B.CONSTRAINT_NAME
    ORDER BY
      C.TABLE_NAME,A.POSITION;


SELECT
  A.CONSTRAINT_NAME,
  C.TABLE_NAME,
  SUBSTR(A.COLUMN_NAME,1,40) COL_NAME,
  B.TABLE_NAME REF_TABLE_NAME,
  SUBSTR(B.COLUMN_NAME, 1, 40) REF_COLUMN_NAME,
  B.CONSTRAINT_NAME
  FROM
    USER_CONSTRAINTS C,
    USER_CONS_COLUMNS A,
    USER_CONS_COLUMNS B
  WHERE
    A.CONSTRAINT_NAME='UNQ_FAC_TRANS_EXP_PK'
    AND C.CONSTRAINT_NAME = A.CONSTRAINT_NAME
    AND C.R_CONSTRAINT_NAME = B.CONSTRAINT_NAME
    ORDER BY
      C.TABLE_NAME,A.POSITION;

Select
   COL_00.CONSTRAINT_NAME,
   COL_01.TABLE_NAME PARENT_TABLE,
   SUBSTR(COL_01.COLUMN_NAME, 1, 40) PARENT_COLUMN,
   C.TABLE_NAME As CHILD_TABLE,
   SUBSTR(COL_00.COLUMN_NAME,1,40) CHILD_COLUMN,
   COL_00.POSITION CONTSTRAINT_POS,
   COL_01.POSITION P2
   FROM
      USER_CONSTRAINTS C
         INNER JOIN USER_CONS_COLUMNS COL_00 ON C.CONSTRAINT_NAME = COL_00.CONSTRAINT_NAME
         INNER JOIN USER_CONS_COLUMNS COL_01 ON C.R_CONSTRAINT_NAME = COL_01.CONSTRAINT_NAME And COL_00.POSITION = COL_01.POSITION
      Where C.status = 'ENABLED'
      ORDER BY
         COL_00.CONSTRAINT_NAME,
         COL_01.TABLE_NAME,
         COL_00.POSITION;

/*-----   CHECK TABLE PRIMARY KEY   -----*/

SELECT
  CONS.CONSTRAINT_TYPE, CONS.STATUS,
  COL.CONSTRAINT_NAME, COL.TABLE_NAME, COL.COLUMN_NAME, COL.POSITION
  FROM
    USER_CONSTRAINTS CONS INNER JOIN USER_CONS_COLUMNS COL
      ON CONS.CONSTRAINT_NAME = COL.CONSTRAINT_NAME
    WHERE
      CONS.CONSTRAINT_TYPE = 'P'
      --AND CONS.TABLE_NAME = 'ARD_EDI_MESSAGE'
      ORDER BY COL.CONSTRAINT_NAME, COL.POSITION;


edi_test@omni-orcl-beta> DESC USER_CONS_COLUMNS
 Name
 -------------------------------------------------------------------------
 OWNER
 CONSTRAINT_NAME
 TABLE_NAME
 COLUMN_NAME
 POSITION

edi_test@omni-orcl-beta> DESC USER_CONSTRAINTS
 Name
 -------------------------------------------------------------------------
 OWNER
 CONSTRAINT_NAME
 CONSTRAINT_TYPE
 TABLE_NAME
 SEARCH_CONDITION
 R_OWNER
 R_CONSTRAINT_NAME
 DELETE_RULE
 STATUS
 DEFERRABLE
 DEFERRED
 VALIDATED
 GENERATED
 BAD
 RELY
 LAST_CHANGE


/*-----   LIST ALL COMMENTS FROM TABLES   -----*/
SELECT
  TABLE_NAME,
  COMMENTS
  FROM
    ALL_TAB_COMMENTS
    WHERE
      TABLE_NAME LIKE 'FAC_%'
      AND OWNER = 'OMNI_MROC'
      ORDER BY TABLE_NAME;


/*-----   LIST ALL COMMENTS FROM COLUMNS   -----*/
SELECT
  TABLE_NAME,
  COLUMN_NAME,
  COMMENTS
  FROM
    ALL_COL_COMMENTS
    WHERE
      OWNER = 'OMNI_MROC'
      AND TABLE_NAME LIKE 'FAC_COMMON'
      ORDER BY
        TABLE_NAME,
        COLUMN_NAME;




/*----------   USER VIEWS   ----------*/


/*-----   USER_VIEWS   -----*/
set long 100000
column VIEW_TEXT format a1000
column exeChar FORMAT A1000
SET LINES 1000
select
  TEXT AS VIEW_SOURCE
   FROM
           USER_VIEWS
           WHERE
                   VIEW_NAME IN ('VW_ARCHIVE_MESSAGE');
SET PAGES 500
SET LINES 32000


/*-----   SEARCH USER_VIEWS   -----*/
set long 100000
column VIEW_TEXT format a1000
column exeChar FORMAT A1000
SET LINES 1000
select
  TEXT AS VIEW_SOURCE
   FROM
           USER_VIEWS
           WHERE
                   VIEW_NAME IN ('VW_ARCHIVE_MESSAGE')
           AND dbms_xmlgen.getxml('select text from user_views where view_name = ''' || view_name || '''') like '%abc%';
SET PAGES 500
SET LINES 32000




/*----------   USER PROCEDURE   ----------*/


/*-----   USER_SOURCE   -----*/

SELECT DISTINCT NAME FROM USER_SOURCE ORDER BY NAME;

SELECT
  LINE,
  SUBSTR(TEXT,1,250)
  FROM
    USER_SOURCE
    WHERE
      NAME = UPPER('&PR_NAME')
      AND   TYPE = DECODE('&PR_TYPE','1','PACKAGE','2','PACKAGE BODY','3','FUNCTION')
      ORDER BY
      TYPE,
      LINE;

SELECT
  LINE,
  SUBSTR(TEXT,1,250)
  FROM
    USER_SOURCE
    WHERE
      NAME = UPPER('&PR_NAME')
      ORDER BY
      TYPE,
      LINE;

SELECT
  --LINE,
  DISTINCT TYPE, NAME
  --SUBSTR(TEXT,1,1000)
  --DECODE(LINE, 1, 'CREATE OR REPLACE ' || TEXT, TEXT) TEXT
  FROM
    USER_SOURCE
      ORDER BY
      NAME,
      TYPE;


SET PAGES 50000
SPOOL ANTL
SELECT
  LINE,
  --TYPE, NAME
  --SUBSTR(TEXT,1,1000)
  DECODE(LINE, 1, 'CREATE OR REPLACE ' || TEXT, TEXT) TEXT
  FROM
    USER_SOURCE
    WHERE
      UPPER(NAME) IN
      (
        'PG_ACORD_CALL'
      )
      ORDER BY
      NAME,
      TYPE,
      LINE;
SPOOL OFF;
SET PAGES 500


SELECT
  --LINE,
  SUBSTR(TEXT,1,500)
  FROM
    USER_SOURCE
    WHERE
      NAME LIKE '%' || UPPER('VW_EDI_MSG_INFO') || '%'
      ORDER BY
      TYPE,
      LINE;




/*-----   USER_ARGUMENTS   -----*/

SELECT * FROM USER_ARGUMENTS WHERE OBJECT_NAME;

SELECT * FROM USER_ARGUMENTS WHERE PACKAGE_NAME;

SELECT
  PACKAGE_NAME,
  OBJECT_NAME,
  ARGUMENT_NAME,
  SUBSTR(DATA_TYPE, 0, 15) DATA_TYPE,
  DATA_LENGTH,
  IN_OUT,
  DATA_PRECISION,
  DATA_SCALE,
  OBJECT_ID,
  OVERLOAD,
  POSITION,
  SEQUENCE,
  DATA_LEVEL,
  DEFAULT_VALUE,
  DEFAULT_LENGTH,
  RADIX,
  CHARACTER_SET_NAME,
  TYPE_OWNER,
  TYPE_NAME,
  TYPE_SUBNAME,
  TYPE_LINK,
  PLS_TYPE
  FROM
    USER_ARGUMENTS
    WHERE
      OBJECT_NAME LIKE 'PR_REOPEN_CLAIM%'
      ORDER BY
        PACKAGE_NAME,
        OBJECT_NAME;


/*-----   SELECT ALL TABLES FROM DBA_DB_LINKS   -----*/

SELECT * FROM DBA_DB_LINKS


/*-----   SELECT ALL TABLES FROM DBA_OBJECTS   -----*/

SELECT * FROM DBA_OBJECTS


/*-----   SELECT USER_SYNONYMS   -----*/

SELECT SYNONYM_NAME, TABLE_OWNER, TABLE_NAME FROM USER_SYNONYMS;


/*--------------------------------------------------------------------------------
||	NAME		:	CHECK TABLE PERMISSION OR PRIVILEGES
||	DESCRIPTION	:
--------------------------------------------------------------------------------*/

SELECT
  OWNER,
  TABLE_NAME,
  GRANTOR,
  GRANTEE,
  SELECT_PRIV,
  INSERT_PRIV,
  DELETE_PRIV,
  UPDATE_PRIV,
--	REFERENCES_PRIV,
  ALTER_PRIV,
--	INDEX_PRIV,
  CREATED
  FROM TABLE_PRIVILEGES
    WHERE
      OWNER = 'OMNI'
      --AND GRANTEE = 'ACORD2'
      --AND TABLE_NAME = 'CT_CURRENCY'
      ORDER BY
        TABLE_NAME,
        GRANTEE;


/*-----   SET   -----*/

SET ECHO OFF
SET FEEDBACK ON
SET DEFINE OFF
SET LINESIZE 300
SET PAGESIZE 999
SET HEAD OFF
SET TERMOUT OFF





/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Script File      ------------------------------*/

/*--------------------------------------------------------------------------------
||	NAME		:	Passing Parameter to a script file
||	DESCRIPTION	:
--------------------------------------------------------------------------------*/
Call Script.
This is a positioning parameter.
&&1..Table_name
&&2..Table_name





/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     TABLE Information      ------------------------------*/



/*-----   SELECT ALL TABLES FROM DBA_OBJECTS   -----*/

CLEAR COLUMNS;
COLUMN D_TYPE HEADING 'DATA TYPE' FORMAT A100;
COLUMN COMMENTS HEADING 'COLUMN COMMENTS' FORMAT A40;
COLUMN D_TYPE FORMAT A20;
--SET PAGESIZE 47;
set trimspool on;
SET LINESIZE 132;
--SET LINESIZE 1005;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

TTITLE 'ORACLE TABLE DEFINITION';
BREAK ON REPORT ON TABLE_NAME SKIP 3;
COMPUTE COUNT LABEL 'TOTAL COLUMN' OF COLUMN_NAME ON TABLE_NAME;

SPOOL ANTL

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT SYSDATE SCRIPT_RUN_ON FROM DUAL;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT
  T.TABLE_NAME,
  --TC.COMMENTS,
  C.COLUMN_NAME,
  --C.DATA_TYPE,
  DECODE
  (
    C.DATA_TYPE,
    'VARCHAR2',
      C.DATA_TYPE || '(' || C.DATA_LENGTH || ')',
    'NVARCHAR2',
      C.DATA_TYPE || '(' || C.DATA_LENGTH || ')',
    'NUMBER',
      C.DATA_TYPE || '(' || NVL(C.DATA_PRECISION,0) || ', ' || C.DATA_SCALE || ')',
    'DATE',
      C.DATA_TYPE,
    C.DATA_TYPE
  ) D_TYPE,
  --C.DATA_LENGTH,
  --C.DATA_PRECISION,
  --C.DATA_SCALE,
  --C.NULLABLE,
  DECODE
  (
    C.NULLABLE,
    'Y',
      'NULL',
    'N',
      'NOT NULL'
  ) ALLOW_NULL,
  CC.COMMENTS
  FROM
    USER_TABLES T,
    USER_TAB_COMMENTS TC,
    COLS C,
    USER_COL_COMMENTS CC
    WHERE
      T.TABLE_NAME = TC.TABLE_NAME
      AND T.TABLE_NAME = C.TABLE_NAME
      AND C.TABLE_NAME = CC.TABLE_NAME
      AND C.COLUMN_NAME = CC.COLUMN_NAME
      --AND T.TABLE_NAME LIKE 'CLM_%'
      --AND C.COLUMN_NAME LIKE '%LINESPERCENTAGEOFORDERIND%'
      ORDER BY
        T.TABLE_NAME,
        C.COLUMN_ID;

SPOOL OFF

SET PAGESIZE 490;
SET LINESIZE 32000;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
TTITLE OFF;
CLEAR BREAK;
CLEAR COLUMN;









/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/




/*-----   GENERATE TABLE PRINT PROCEDURE IN ORACLE PACKAGE   -----*/

spool antl

VARIABLE	CHECK_TABLE_NAME			VARCHAR2(32);

BEGIN
  :CHECK_TABLE_NAME	:= 'CLM_TRANSACTIONS';

END;
/

SELECT -100 AS COLUMN_ID,'PROCEDURE PRINT_' || :CHECK_TABLE_NAME || CHR(10) || '(' AS PART_01 FROM DUAL
UNION
SELECT -30 AS COLUMN_ID,CHR(9) || 'IN_HEADER                     IN VARCHAR2,' AS PART_01 FROM DUAL
UNION
SELECT -25 AS COLUMN_ID, CHR(9) || 'IN_' || :CHECK_TABLE_NAME || '_RT    IN ' || :CHECK_TABLE_NAME || '%ROWTYPE' || CHR(10) || ')' AS PART_01 FROM DUAL
UNION
SELECT -20 AS COLUMN_ID,'IS' || CHR(10) || 'BEGIN' AS PART_01 FROM DUAL
UNION
SELECT -15 AS COLUMN_ID,'PG_ICT_ERROR_HANDLER.INSERT_LOG_MSG' || CHR(10) || '(' AS PART_01 FROM DUAL
UNION
SELECT -10 AS COLUMN_ID,'IN_' || :CHECK_TABLE_NAME || '_RT.ARD_EDI_MESSAGE_ID,' AS PART_01 FROM DUAL
UNION
SELECT -5 AS COLUMN_ID,'IN_HEADER || CHR(10) || CHR(10) ||' AS PART_01 FROM DUAL
UNION
SELECT 0 AS COLUMN_ID,'/*-----   PUT PRINT CODE HERE   -----*/' AS PART_01 FROM DUAL
UNION
SELECT 1 AS COLUMN_ID,'' AS PART_01 FROM DUAL
UNION
SELECT 2 AS COLUMN_ID,'' AS PART_01 FROM DUAL
UNION
SELECT 3 AS COLUMN_ID,'' AS PART_01 FROM DUAL
UNION
SELECT 100000 AS COLUMN_ID,');' AS PART_01 FROM DUAL
UNION
SELECT 100001 AS COLUMN_ID,'EXCEPTION' AS PART_01 FROM DUAL
UNION
SELECT 100002 AS COLUMN_ID,'WHEN OTHERS THEN' AS PART_01 FROM DUAL
UNION
SELECT 100003 AS COLUMN_ID,'PG_ICT_ERROR_HANDLER.INSERT_DEV_ERR_MSG' || CHR(10) || '(' AS PART_01 FROM DUAL
UNION
SELECT 100004 AS COLUMN_ID,CHR(9) || 'IN_' || :CHECK_TABLE_NAME || '_RT.ARD_EDI_MESSAGE_ID,' AS PART_01 FROM DUAL
UNION
SELECT 100005 AS COLUMN_ID,CHR(9) || '''PRINT_' || :CHECK_TABLE_NAME || ' EXCEPTION:'' || CHR(10) ||' AS PART_01 FROM DUAL
UNION
SELECT 100006 AS COLUMN_ID,CHR(9) || '''ret_value:  '' || sqlcode || CHR(10) ||' AS PART_01 FROM DUAL
UNION
SELECT 100007 AS COLUMN_ID,CHR(9) || '''ret_sqlerrm:'' || CHR(10) || sqlerrm' || CHR(10) || ');' AS PART_01 FROM DUAL
UNION
SELECT 100008 AS COLUMN_ID,'RETURN;' AS PART_01 FROM DUAL
UNION
SELECT 100009 AS COLUMN_ID,'END PRINT_' || :CHECK_TABLE_NAME || ';' AS PART_01 FROM DUAL
  ORDER BY COLUMN_ID;

SELECT 0 AS COLUMN_ID,'IN_HEADER || CHR(10) ||' AS PART_01, '' AS PART_02 FROM DUAL
UNION
SELECT
  COLUMN_ID,
  '''' || COLUMN_NAME AS PART_01, '= '' || IN_' || TABLE_NAME || '_RT.' || COLUMN_NAME || ' || CHR(10) ||' AS PART_02
  FROM
    COLS
    WHERE
      TABLE_NAME = :CHECK_TABLE_NAME
      ORDER BY COLUMN_ID;

spool off




/*-----   GENERATE FUNCTION INSERT IN ORACLE PACKAGE   -----*/

spool antl

VARIABLE	CHECK_TABLE_NAME			VARCHAR2(32);

BEGIN
  :CHECK_TABLE_NAME	:= 'CLM_TRANSACTIONS';

END;
/

SELECT -8 COLUMN_ID, 'FUNCTION FN_' || :CHECK_TABLE_NAME || '_INS' AS PART_01 FROM DUAL
UNION
SELECT -7 COLUMN_ID, '(' AS PART_01 FROM DUAL
UNION
SELECT -6 COLUMN_ID, CHR(9) || 'IN_' || :CHECK_TABLE_NAME || '_RT    IN ' || :CHECK_TABLE_NAME || '%ROWTYPE' AS PART_01 FROM DUAL
UNION
SELECT -5 COLUMN_ID, ')' AS PART_01 FROM DUAL
UNION
SELECT -4 COLUMN_ID, 'RETURN BOOLEAN IS' AS PART_01 FROM DUAL
UNION
SELECT -3 COLUMN_ID, 'BEGIN' AS PART_01 FROM DUAL
UNION
SELECT -2 COLUMN_ID, 'INSERT INTO ' || :CHECK_TABLE_NAME || '' AS PART_01 FROM DUAL
UNION
SELECT -1 COLUMN_ID, '(' AS PART_01 FROM DUAL
UNION
SELECT
  COLUMN_ID,
  CHR(9) || COLUMN_NAME || ',' AS PART_01
  FROM
    COLS
    WHERE
      TABLE_NAME = :CHECK_TABLE_NAME
UNION
SELECT 100000 COLUMN_ID, ')' || CHR(10) || 'VALUES' || CHR(10) || '(' AS PART_01 FROM DUAL
UNION
SELECT
  COLUMN_ID + 100000 AS COLUMN_ID,
   CHR(9) || 'IN_' || TABLE_NAME || '_RT.' || COLUMN_NAME || ',' AS PART_01
  FROM
    COLS
    WHERE
      TABLE_NAME = :CHECK_TABLE_NAME
UNION
SELECT 200000 COLUMN_ID, ');' || CHR(10) || CHR(10) || 'RETURN TRUE;' || CHR(10) || 'EXCEPTION' || CHR(10) || 'WHEN OTHERS' || CHR(10) || 'THEN' AS PART_01 FROM DUAL
UNION
SELECT 200001 COLUMN_ID, CHR(9) || 'PG_ICT_ERROR_HANDLER.INSERT_DEV_ERR_MSG' AS PART_01 FROM DUAL
UNION
SELECT 200002 COLUMN_ID, CHR(9) || '(' AS PART_01 FROM DUAL
UNION
SELECT 200003 COLUMN_ID, CHR(9) || CHR(9) || 'IN_' || :CHECK_TABLE_NAME || '_RT.ARD_EDI_MESSAGE_ID,' AS PART_01 FROM DUAL
UNION
SELECT 200004 COLUMN_ID, CHR(9) || CHR(9) || '''FN_' || :CHECK_TABLE_NAME || '_INS EXCEPTION:'' || CHR(10) ||' AS PART_01 FROM DUAL
UNION
SELECT 200005 COLUMN_ID, CHR(9) || CHR(9) || '''ret_value:  '' || sqlcode || CHR(10) ||' AS PART_01 FROM DUAL
UNION
SELECT 200006 COLUMN_ID, CHR(9) || CHR(9) || '''ret_sqlerrm:'' || CHR(10) || sqlerrm' || CHR(10) || CHR(9) || ');' || CHR(10) || CHR(9) || 'RETURN FALSE;' AS PART_01 FROM DUAL
UNION
SELECT 200007 COLUMN_ID, 'END FN_' || :CHECK_TABLE_NAME || '_INS;' AS PART_01 FROM DUAL
ORDER BY COLUMN_ID;

spool off




/*-----   GENERATE INSERT CODE FOR ORACLE PACKAGE   -----*/

SPOOL ANTL

VARIABLE	CHECK_TABLE_NAME			VARCHAR2(32);

BEGIN
  :CHECK_TABLE_NAME	:= 'CLM_MASTER';

END;
/

SELECT
  COLUMN_ID,
  DECODE(NULLABLE, 'Y', '-- ', ' ') AS PART_00,
  'INS_' || TABLE_NAME || '_RT.' || COLUMN_NAME AS PART_01, ':= INS_' || TABLE_NAME || '_DATA.' || COLUMN_NAME || ';' AS PART_02
  FROM
    COLS
    WHERE
      TABLE_NAME = :CHECK_TABLE_NAME
      ORDER BY NULLABLE, COLUMN_ID;

SPOOL OFF




/*-----   GENERATE FUNCTION UPDATE IN ORACLE PACKAGE   -----*/

spool antl

VARIABLE	CHECK_TABLE_NAME			VARCHAR2(32);

BEGIN
  :CHECK_TABLE_NAME	:= 'CLM_MASTER';

END;
/

SELECT -17 COLUMN_ID, 'FUNCTION FN_' || :CHECK_TABLE_NAME || '_UPD' AS PART_01 FROM DUAL
UNION
SELECT -15 COLUMN_ID, '(' AS PART_01 FROM DUAL
UNION
SELECT -13 COLUMN_ID, CHR(9) || 'IN_' || :CHECK_TABLE_NAME || '_RT    IN ' || :CHECK_TABLE_NAME || '%ROWTYPE' AS PART_01 FROM DUAL
UNION
SELECT -11 COLUMN_ID, ')' AS PART_01 FROM DUAL
UNION
SELECT -9 COLUMN_ID, 'RETURN BOOLEAN IS' AS PART_01 FROM DUAL
UNION
SELECT -7 COLUMN_ID, 'BEGIN' || CHR(10) AS PART_01 FROM DUAL
UNION
SELECT -5 COLUMN_ID, CHR(10) || CHR(9) || 'IF( IN_' || :CHECK_TABLE_NAME || '_RT.' || :CHECK_TABLE_NAME || '_PK IS NULL ) THEN' AS PART_01 FROM DUAL
UNION
SELECT -3 COLUMN_ID, CHR(9) || CHR(9) || 'RETURN FALSE;' AS PART_01 FROM DUAL
UNION
SELECT -1 COLUMN_ID, CHR(9) || 'END IF;' || CHR(10) AS PART_01 FROM DUAL
UNION
SELECT 0 AS COLUMN_ID, CHR(10) || CHR(9) || 'UPDATE ' || :CHECK_TABLE_NAME || ' SET' || CHR(10) || CHR(10) AS PART_01 FROM DUAL
UNION
SELECT 99999 AS COLUMN_ID,'/*-----   PUT UPDATE CODE HERE   -----*/' || CHR(10) || CHR(10) || CHR(10) AS PART_01 FROM DUAL
UNION
SELECT 100000 AS COLUMN_ID, CHR(9) || 'WHERE ' || :CHECK_TABLE_NAME || '_PK = IN_' || :CHECK_TABLE_NAME || '_RT.' || :CHECK_TABLE_NAME || '_PK;' || CHR(10) || CHR(10) AS PART_01 FROM DUAL
UNION
SELECT 200000 COLUMN_ID, CHR(9) || '' || 'RETURN TRUE;' || CHR(10) || CHR(10) || 'EXCEPTION' || CHR(10) || 'WHEN OTHERS' || CHR(10) || 'THEN' AS PART_01 FROM DUAL
UNION
SELECT 200001 COLUMN_ID, CHR(9) || 'PG_ICT_ERROR_HANDLER.INSERT_DEV_ERR_MSG' AS PART_01 FROM DUAL
UNION
SELECT 200002 COLUMN_ID, CHR(9) || '(' AS PART_01 FROM DUAL
UNION
SELECT 200003 COLUMN_ID, CHR(9) || CHR(9) || 'IN_' || :CHECK_TABLE_NAME || '_RT.ARD_EDI_MESSAGE_ID,' AS PART_01 FROM DUAL
UNION
SELECT 200004 COLUMN_ID, CHR(9) || CHR(9) || '''FN_' || :CHECK_TABLE_NAME || '_UPD EXCEPTION:'' || CHR(10) ||' AS PART_01 FROM DUAL
UNION
SELECT 200005 COLUMN_ID, CHR(9) || CHR(9) || '''ret_value:  '' || sqlcode || CHR(10) ||' AS PART_01 FROM DUAL
UNION
SELECT 200006 COLUMN_ID, CHR(9) || CHR(9) || '''ret_sqlerrm:'' || CHR(10) || sqlerrm' || CHR(10) || CHR(9) || ');' || CHR(10) || CHR(9) || 'RETURN FALSE;' AS PART_01 FROM DUAL
UNION
SELECT 200007 COLUMN_ID, 'END FN_' || :CHECK_TABLE_NAME || '_UPD;' AS PART_01 FROM DUAL
ORDER BY COLUMN_ID;

SELECT
  COLUMN_ID,
  COLUMN_NAME AS PART_01, '= IN_' || TABLE_NAME || '_RT.' || COLUMN_NAME || ',' AS PART_02
  FROM
    COLS
    WHERE
      TABLE_NAME = :CHECK_TABLE_NAME
ORDER BY COLUMN_ID;


spool off







/*-----   GENERATE PROCEDURE UPDATE IN ORACLE PACKAGE   -----*/


VARIABLE	CHECK_TABLE_NAME			VARCHAR2(32);

BEGIN
  :CHECK_TABLE_NAME	:= 'CLM_COVERAGES';

END;
/

SELECT 0 AS COLUMN_ID,'UPDATE ' || :CHECK_TABLE_NAME || ' SET' AS PART_01, '' AS PART_02 FROM DUAL
UNION
SELECT
  COLUMN_ID,
  COLUMN_NAME AS PART_01, '= IN_' || TABLE_NAME || '_RT.' || COLUMN_NAME || ',' AS PART_02
  FROM
    COLS
    WHERE
      TABLE_NAME = :CHECK_TABLE_NAME
UNION
SELECT 10000 AS COLUMN_ID, 'WHERE ' || :CHECK_TABLE_NAME || '_PK = IN_' || :CHECK_TABLE_NAME || '_PK;' AS PART_01, '' AS PART_02 FROM DUAL
ORDER BY COLUMN_ID;




/*-----   GENERATE DATA TRANSFER FROM IN ORACLE PACKAGE   -----*/

SELECT
  COLUMN_ID,
  TABLE_NAME || '_RT.' || COLUMN_NAME AS PART_01, ':= INS_' || TABLE_NAME || '_RT.' || COLUMN_NAME || ';' AS PART_02
  FROM
    COLS
    WHERE
      TABLE_NAME = 'FAC_JOURNAL'
      ORDER BY COLUMN_ID;




/*-----   GENERATE OBJECT BACKUP SCRIPT   -----*/

SET PAGESIZE 50000;
SET LINESIZE 32000;

SPOOL ANTL

SELECT
'SPOOL ' || OBJECT_NAME || '.sql' || CHR(10) ||
'SELECT TEXT FROM' || CHR(10) ||
'(' || CHR(10) ||
'SELECT LINE, TEXT FROM' || CHR(10) ||
'(' || CHR(10) ||
'SELECT' || CHR(10) ||
CHR(9) || 'LINE,' || CHR(10) ||
CHR(9) || 'TYPE,' || CHR(10) ||
CHR(9) || '--NAME' || CHR(10) ||
CHR(9) || '--SUBSTR(TEXT,1,1000)' || CHR(10) ||
CHR(9) || 'DECODE(LINE, 1, ''CREATE OR REPLACE '' || TEXT, TEXT) TEXT' || CHR(10) ||
CHR(9) || 'FROM' || CHR(10) ||
CHR(9) || CHR(9) || 'USER_SOURCE' || CHR(10) ||
CHR(9) || CHR(9) || 'WHERE' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'UPPER(NAME) IN' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || '(' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || CHR(9) || '''' || OBJECT_NAME || '''' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || ')' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'AND TYPE = ''PACKAGE''' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'ORDER BY' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'NAME,' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'TYPE,' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'LINE' || CHR(10) ||
') UNION SELECT 999999999 AS LINE, ''/'' AS TEXT FROM DUAL' || CHR(10) ||
') ORDER BY LINE;' || CHR(10) ||
'SELECT TEXT FROM' || CHR(10) ||
'(' || CHR(10) ||
'SELECT LINE, TEXT FROM' || CHR(10) ||
'(' || CHR(10) ||
'SELECT' || CHR(10) ||
CHR(9) || 'LINE,' || CHR(10) ||
CHR(9) || 'TYPE,' || CHR(10) ||
CHR(9) || '--NAME' || CHR(10) ||
CHR(9) || '--SUBSTR(TEXT,1,1000)' || CHR(10) ||
CHR(9) || 'DECODE(LINE, 1, ''CREATE OR REPLACE '' || TEXT, TEXT) TEXT' || CHR(10) ||
CHR(9) || 'FROM' || CHR(10) ||
CHR(9) || CHR(9) || 'USER_SOURCE' || CHR(10) ||
CHR(9) || CHR(9) || 'WHERE' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'UPPER(NAME) IN' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || '(' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || CHR(9) || '''' || OBJECT_NAME || '''' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || ')' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'AND TYPE = ''PACKAGE BODY''' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'ORDER BY' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'NAME,' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'TYPE,' || CHR(10) ||
CHR(9) || CHR(9) || CHR(9) || 'LINE' || CHR(10) ||
') UNION SELECT 999999999 AS LINE, ''/'' AS TEXT FROM DUAL' || CHR(10) ||
') ORDER BY LINE;' || CHR(10) ||
'SPOOL OFF;' || CHR(10) ||
'' AS SCRIPT
FROM ALL_OBJECTS OBJ
WHERE OBJ.OWNER = 'OMNI' AND OBJ.OBJECT_TYPE = 'PACKAGE'
  AND
  (
    OBJ.OBJECT_NAME LIKE 'PG_ICT_%'
    OR OBJ.OBJECT_NAME = 'PG_EDI'
  )
ORDER BY OBJ.STATUS, OBJ.OBJECT_TYPE, OBJ.OBJECT_NAME, TIMESTAMP;

SPOOL OFF

SET PAGESIZE 1000;
SET LINESIZE 32000;



/*
SPOOL PG_ACORD_DATA_TRANSFER.sql
SELECT TEXT FROM
(
SELECT LINE, TEXT FROMC
(
SELECT
  LINE,
  TYPE,
  --NAME
  --SUBSTR(TEXT,1,1000)
  DECODE(LINE, 1, 'CREATE OR REPLACE ' || TEXT, TEXT) TEXT
  FROM
    USER_SOURCE
    WHERE
      UPPER(NAME) IN
      (
        'PG_ACORD_DATA_TRANSFER'
      )
      AND TYPE = 'PACKAGE'
      ORDER BY
      NAME,
      TYPE,
      LINE
) UNION SELECT 999999999 AS LINE, '/' AS TEXT FROM DUAL
) ORDER BY LINE;
SELECT TEXT FROM
(
SELECT LINE, TEXT FROM
(
SELECT
  LINE,
  TYPE,
  --NAME
  --SUBSTR(TEXT,1,1000)
  DECODE(LINE, 1, 'CREATE OR REPLACE ' || TEXT, TEXT) TEXT
  FROM
    USER_SOURCE
    WHERE
      UPPER(NAME) IN
      (
        'PG_ACORD_DATA_TRANSFER'
      )
      AND TYPE = 'PACKAGE BODY'
      ORDER BY
      NAME,
      TYPE,
      LINE
) UNION SELECT 999999999 AS LINE, '/' AS TEXT FROM DUAL
) ORDER BY LINE;
SPOOL OFF;
*/




/*-----   GENERATE XSL CODE FOR TABLE   -----*/

spool antl

VARIABLE	CHECK_TABLE_NAME			VARCHAR2(32);

BEGIN
  :CHECK_TABLE_NAME	:= 'CLM_TRANSACTIONS';

END;
/


SELECT XSL_CODE FROM (
SELECT -10900 COLUMN_ID, '<xsl:template name="' || :CHECK_TABLE_NAME || '_TPL">' AS XSL_CODE FROM DUAL
UNION
SELECT -10800 COLUMN_ID, CHR(9) || '<xsl:param name="NODENAME"/>' AS XSL_CODE FROM DUAL
UNION
SELECT -10700 COLUMN_ID, CHR(9) || '<xsl:if test="$NODENAME">' AS XSL_CODE FROM DUAL
UNION
SELECT -10600 COLUMN_ID, CHR(9) || '<xsl:for-each select="$NODENAME">' AS XSL_CODE FROM DUAL
UNION
SELECT -10500 COLUMN_ID, CHR(9) || CHR(9) || '<xsl:sort select="SORT_COLUMN" order = "ascending" data-type="number"/>' AS XSL_CODE FROM DUAL
UNION
SELECT -10400 COLUMN_ID, CHR(9) || CHR(9) || '<table class="SectionTBL" border="0">' AS XSL_CODE FROM DUAL
UNION
SELECT -10200 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || '<tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -10100 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<td colspan="10" align="Center" class="MainTable_Green">' AS XSL_CODE FROM DUAL
UNION
SELECT -10000 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || :CHECK_TABLE_NAME AS XSL_CODE FROM DUAL
UNION
SELECT -9900 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || '</td>' AS XSL_CODE FROM DUAL
UNION
SELECT -9800 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || '</tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9700 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || '<tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9600 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<td colspan="10">' AS XSL_CODE FROM DUAL
UNION
SELECT -9500 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<table class="SectionTBL" border="1">' AS XSL_CODE FROM DUAL
UNION
SELECT -9490 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9480 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<td colspan="10" align="Center" class="Transaction">Section Info:</td>' AS XSL_CODE FROM DUAL
UNION
SELECT -9470 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '</tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9465 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<xsl:if test="COLUMN_NODE">' AS XSL_CODE FROM DUAL
UNION
SELECT -9460 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9450 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<td align="Center" class="TransLabelCenter">COLUMN_NODE</td>' AS XSL_CODE FROM DUAL
UNION
SELECT -9440 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '</tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9438 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9437 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<td align="Center" class="SectionDataCenter"><xsl:value-of select="COLUMN_NODE" /></td>' AS XSL_CODE FROM DUAL
UNION
SELECT -9436 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '</tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9435 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '</xsl:if>' AS XSL_CODE FROM DUAL
UNION
SELECT -9420 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '</table>' AS XSL_CODE FROM DUAL
UNION
SELECT -9400 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || CHR(9) || '</td>' AS XSL_CODE FROM DUAL
UNION
SELECT -9300 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || '</tr>' AS XSL_CODE FROM DUAL
UNION
SELECT -9200 COLUMN_ID, CHR(9) || CHR(9) || CHR(9) || '<tr><td colspan="10">-</td></tr>' AS XSL_CODE FROM DUAL
UNION
SELECT
  COLUMN_ID,
  CHR(9) || CHR(9) || CHR(9) || '<tr>' || CHR(10)
  || CHR(9) || CHR(9) || CHR(9) || CHR(9) || '<td class="TransLabel" width="40%">' || COLUMN_NAME || '</td>' || CHR(10)
  || CHR(9) || CHR(9) || CHR(9) || CHR(9) || DECODE(DATA_TYPE,
    'DATE', '<td><xsl:value-of select="js:TrimDate(string(' || COLUMN_NAME || '))" /></td>',
    'NUMBER', '<td><xsl:value-of select="format-number(' || COLUMN_NAME || ', ''#,###.00'')" /></td>',
    '<td><xsl:value-of select="' || COLUMN_NAME || '" /></td>') || CHR(10)
  || CHR(9) || CHR(9) || CHR(9) || '</tr>'
  AS XSL_CODE
  FROM
    COLS
    WHERE
      TABLE_NAME = :CHECK_TABLE_NAME
UNION
SELECT 200000 COLUMN_ID, CHR(9) || CHR(9) || '</table>' AS XSL_CODE FROM DUAL
UNION
SELECT 200001 COLUMN_ID, CHR(9) || '</xsl:for-each>' AS XSL_CODE FROM DUAL
UNION
SELECT 200003 COLUMN_ID, CHR(9) || '</xsl:if>' AS XSL_CODE FROM DUAL
UNION
SELECT 200004 COLUMN_ID, '</xsl:template>' AS XSL_CODE FROM DUAL
ORDER BY COLUMN_ID
);


spool off










/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     CREATE OBJECT      ------------------------------*/

/*--------------------------------------------------------------------------------
||	NAME		:	CREATE SYNONYM
||	DESCRIPTION	:
--------------------------------------------------------------------------------*/

DROP SYNONYM SCHEMA_NAME.SYNONYM_NAME;

CREATE SYNONYM SCHEMA_NAME.SYNONYM_NAME
  FOR REF_SCHEMA_NAME.OBJECT_NAME;




/*--------------------------------------------------------------------------------
||	NAME		:	CREATE INDEX
||	DESCRIPTION	:
--------------------------------------------------------------------------------*/

DROP INDEX IDX_TABLE_NAME

CREATE INDEX IDX_TABLE_NAME
  ON TABLE_NAME (TABLE_NAME_PK);

SELECT
  OBJECT_TYPE,
  SUBSTR(OBJECT_NAME,1,40) OBJECT_NAME,
  STATUS,
  GENERATED,
  --SUBOBJECT_NAME,
  OBJECT_ID,
  DATA_OBJECT_ID,
  CREATED,
  LAST_DDL_TIME,
  TIMESTAMP,
  TEMPORARY,
  SECONDARY
  FROM
    USER_OBJECTS
    WHERE
      OBJECT_TYPE IN
      (
        'INDEX'
      )
      --AND OBJECT_NAME LIKE '%FN_VALIDATE_CLM_MASTER%'
      --AND STATUS <> 'VALID'
      ORDER BY
        OBJECT_TYPE,
        OBJECT_NAME;


/*-----   UNIQUE INDEX WITH NULL VALUE   -----*/

CREATE UNIQUE INDEX UIDX_FIELD_NAME_MAP ON ICT_XML_ACORD_MAP (NVL2(FIELD_NAME, FILETYPE, NULL), FIELD_NAME);










/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Functions      ------------------------------*/

/*-----   ALTER   -----*/

ALTER VIEW VIEW_NAME COMPILE;

ALTER PROCEDURE PROCEDURE_NAME COMPILE;

ALTER PACKAGE PACKAGE_NAME COMPILE BODY;
ALTER PACKAGE PACKAGE_NAME COMPILE PACKAGE;


/*-----   CASE   -----*/

SELECT parameter,
       CASE WHEN parameter < 1000 THEN 'C' ELSE 'P' END AS BAND
FROM parameter_table;


/*-----   ALTER   -----*/

SELECT
  'ALTER ' || OBJECT_TYPE || ' ' || OWNER || '.' || OBJECT_NAME || ' COMPILE;'
  FROM
    DBA_OBJECTS
    WHERE
      STATUS = 'INVALID'
      AND OBJECT_TYPE IN ('PACKAGE','FUNCTION','PROCEDURE')
      AND OBJECT_NAME LIKE 'PG_ACORD%';




/*-----   COPY (INSERT ONLY)   -----*/
COPY FROM USERNAME/PASSWORD@DATABASE_NAME	-
     TO  USERNAME/PASSWORD@DATABASE_NAME	-
 INSERT  SCHEMA_NAME.TABLE_NAME				-
 USING  SELECT * FROM SCHEMA_NAME.TABLE_NAME;

COPY FROM omni/omni@MRUK_64BIT.world	-
     TO  OMNI/OMNIDEV@OMNI		-
  INSERT  omni.FAC_COMMON			-
  USING  SELECT FAC_COMMON_PK, MRG_UNIT_CODE, MR_UW_OFFICE_ID, WORKSHEET_NUMBER, UNDERWRITING_YEAR, CERTIFICATE_NUMBER, CEDENT_CODE, CEDENT_UNDERWRITER_CODE, BROKER_CODE, BROKER_UNDERWRITER_CODE, CEDENT_MASTER_CODE, BROKER_MASTER_CODE, DATE_ADDED_TO_FILE, DATE_LAST_UPDATE, WORKSHEET_STATUS, INSURED_NAME_FIRST_LINE, INSURED_NAME_SECOND_LINE, POLICY_NUMBER, CURRENCY_CODE, CURRENCY_DESC, CERT_PREM_ORIGINAL_AMT, CERT_PREM_ED_AMT, TOT_PREM_ORIGINAL_AMT, TOT_PREM_CONVERTED_AMT, BROKER_COMMISSION_PCT, CEDENT_COMMISSION_PCT, COMMISSION_PCT, OVERRIDE_PCT, TYPE_OF_PREMIUM, POLICY_EFFECTIVE_DATE, POLICY_EXPIRY_DATE, CERT_EFFECTIVE_DATE, CERT_EXPIRY_DATE, DATES_ARE_EQUAL, TYPE_OF_CERT, TECHNICAL_ASSISTANT, MR_UNDERWRITER, LANGUAGE, QUOTE_VALID_FOR, AGENT_NAME, ALTERNATE_QUOTES, AUTOMATIC_AGREEMENT, AGREEMENT_NAME, CERT_CANCELLED, CANCEL_METHOD, CEDENT_CONN, CERT_RENEWED, CERT_REISSUED, DATE_REISSUED, CLAIMS_ON_CURRENT_TERM, CLAIMS_ON_PREVIOUS_TERM, CLAIMS_ON_SUB_CERTS, COPY_SENT_TO_MRM, COPY_SENT_TO_HEADOFFICE, EASY_RENEWAL, EASY_RENEWAL_FAX_SENT, EASY_RENEWAL_NOTVALID_DATE, DO_NOT_DELETE_WORKSHEET, OIL_AND_GAS_WORKSHEET, REINSTATED, DATE_REINSTATED, SPECIAL_RISK, SUB_CERT_EXIST, SUBSEQUENT_SUBMISSIONS, CLEARED_BY_SYSTEM, DATE_QUOTED, DATE_BOUND, DATE_CANCELLED, DATE_CERT_ISSUED, DATE_LAPSED, DATE_LAPSED_BY_SYSTEM, DATE_QUOTE_FAX_SENT, DATE_BINDER_FAX_SENT, DATE_FOLLOW_UP_FAX_SENT, DATE_RENEWAL_FAX_SENT, DATE_EXTENSION_FAX_SENT, DATE_LAPSE_FAX_SENT, ADDITIONAL_QUOTES, ADDITIONAL_UWINFO_CB, TERMS_CONDITIONS_CB, MRG_UNIT_MINOR_LINE, MRG_UNIT_MINOR_LINE_DESC, NEW_BUSINESS, RENEWAL, REPLACEMENT, MRG_UNIT_DEPARTMENT_CODE, MR_DEPARTMENT, MR_UNDERWRITING_OFFICE, CEDENT_COMMISSION_IS_NET, BROKER_COMMISSION_IS_NET, COMMISSION_VARIES_PER_QUOTE, CONVERTED_FROM_MAINFRAME, MULTIPLE_CERTS, ROOT_CERT_NUMBER, AMERICAN_RE, WORKSHEET_FORTUNE_500, HARD_COPY, SPECIAL_AUTHORIZATION, REASON_EASYRENEWAL_OFF, KEEP_WORKSHEET_UNTIL, LAPSED_BY_SYSTEM, NOT_REQUIRED_BY_SYSTEM, NOT_REQUIRED_BY_SYSTEM_DATE, PREM_DESC, COPY_FROM_WORKSHEET_NUMBER, ROOT_CERTIFICATE_NUMBER, INSURED_SYSTEM_CLEARED, INSURED_SYSTEM_CLEARED_DATE, CERTIFICATE_TERM, TERM_IS_MONTHS, TERM_IS_DAYS, MR_REFERENCE_NUMBER, ERB_NUMBER, ORIGINAL_POLICY_PREM, LINE_SHOR_DESC, DAYS_STAY_UNLAPSED, WORKSHEET_VERSION_NUMBER, ORIG_CURR_CODE, BOOK_CURR_CODE, SYSTEM_DELETION_CB, ABEYANCEEXISTS_CB, INDEMNITY_PERIOD, MAINTENANCE_PERIOD, CONSTRUCTION_PERIOD, TESTING_PERIOD,	-
  TIME_EXCESS, ONE_JOB_ONLY, VIA_BROKER, FACULTATIVE_RETRO, SURPLUS_TREATY_RETRO, SURPLUS_TREATY_RETRO_PCT, FACULTATIVE_RETRO_PCT, INSPECTION_REPORT_AVAILABLE, RISK_DESC, LETTER_AGR_XREF_RECNUM, COMMISSION_ORIG_AMT, COMMISSION_BOOK_AMT, BROKER_ORIG_AMT, BROKER_BOOK_AMT, NET_PREMIUM_ORIG, NET_PREMIUM_BOOK, LOCATION, MR_RETRO, EARTHQUAKE_INDICATOR, CLM_PAY_ALLOW, EQ_TYPE_OF_POLICY, DOMICILE, CEDENT_CONN_GROUP_NODE, DATE_LAST_RECEIVE, DATE_LAST_SEND, MR_MINOR_LINE, CEDENT_CONN_MR_BRANCH, CEDENT_CONN_MR_NODE, CEDENT_CONN_MR_UW, DOCUMENT_NUMBER, RECORD_CODE, RECORD_SEQUENCE, S_LOCINFOATTACHED, S_LOCINFOBYFAX, S_LOCINFOBYMAIL, S_LOCINFOTOFOLLOW, URL, CEDENT_UW_FIRST_NAME, CEDENT_UW_LAST_NAME, MRG_UNIT_DEPARTMENT_DESC, INDEX_DATE, INDEX_POLICYSEARCH, INDEX_SEARCH_NAME, CEDENT_NAME, BROKER_NAME, INSURED_NAME_SOUNDEX, NO_KNOWN_LOSSES_5YRS, LOSS_HISTORY_TBA, DATE_COMMISSION_CHANGE, DATE_POLICY_NUMBER_CHANGE, BINDING_AUTHORITY, AGREEMENT_CB, CERT_LAPSED, DATE_RENEWED, TYPE_OF_CERT_CODE, LIM_NO, LAPSE_METHOD, NOT_REQUIRED_METHOD, DIRECT_BROKER_BUSINESS, FIRST_INSTALLMENT_EFF, FIRST_INSTALLMENT_EXP, CEDENT_BUSINESS_PARTY_TYPE, BROKER_BUSINESS_PARTY_TYPE, FIRST_INST_PREM_ORIGINAL_AMT, FIRST_INST_PREM_CONVERTED_AMT, SETTLEMENT_CURRENCY_CODE, SETTLEMENT_CURRENCY_EXCHANGE, SETTLEMENT_AMOUNT, PAYMENT_PERIOD, RENDER_PERIOD, EXPIRY_TIME, WORKSHEET_TYPE, SLIP_NUMBER, RENDERED_DATE, SETTLEMENT_DATE, COMMISSION_AMT_SETTLEMENT, MR_DIVISION_CODE, IS_EDI, CEDENT_DOMICILE, BROKER_DOMICILE, CEDENT_APPL_NUMBER, CEDENT_APPL_DATE, USE_MAIN_CURRENCY_ONLY, GTS_CODE, ARD_EDI_MESSAGE_ID, FRONTING_COMPANY_CODE, FRONTING_COMPANY_TYPE, IS_MR_LEAD, IS_TRIA, IS_PPW, IS_POOL_RE, IS_TERRORISM, IS_GAREAT, IS_ATAI, IS_SURPLUS_LINES, IS_INSTALLMENT, SURPLUS_LINE_BROKER_CODE, SURPLUS_LINE_BROKER_TYPE, IS_OTHER_TERRORISM, IS_ACCOUNTS, IS_COMMUTED, IS_SURVEY_FEE_FIXED, IS_SURVEY_FEE_INCUR FROM omni.FAC_COMMON WHERE FAC_COMMON_PK = 'A59E9D6BE9ED4EEFBFB46A463BBBEE05';




/*-----   COPY (CREATE AND INSERT)   -----*/
COPY FROM USERNAME/PASSWORD@DATABASE_NAME	-
     TO  USERNAME/PASSWORD@DATABASE_NAME	-
 CREATE  SCHEMA_NAME.TABLE_NAME				-
 USING  SELECT * FROM SCHEMA_NAME.TABLE_NAME;



/*-----   DATE   -----*/
An half hour from now SYSDATE + 1/48
Tomorrow at 12 midnight TRUNC(SYSDATE + 1)
Tomorrow at 8 AM TRUNC(SYSDATE + 1) + 8/24
Next Monday at 12:00 noon NEXT_DAY(TRUNC(SYSDATE), 'MONDAY') + 12/24
First day of the month at 12 midnight TRUNC(LAST_DAY(SYSDATE ) + 1)
The next Monday, Wednesday or Friday at 9 a.m TRUNC(LEAST(NEXT_DAY(sysdate,''MONDAY' ' ),NEXT_DAY(sysdate,''WEDNESDAY''), NEXT_DAY(sysdate,''FRIDAY'' ))) + (9/24)

SELECT
  SYSDATE,
  SYSDATE + 1 AS TOMORROW,
  SYSDATE + 7 AS NEXTWEEK,
  SYSDATE + 30/86400 AS NEXT_30_SEC,
  SYSDATE + 10/1440 AS NEXT_10_MIN,
  SYSDATE + 1/24 AS NEXT_HOUR
  FROM DUAL;


SELECT
  floor((((SYSDATE)-(SYSDATE+5))*24*60*60)/3600)
  || ' HOURS ' ||
  floor(((((SYSDATE)-(SYSDATE+5))*24*60*60) -
  floor((((SYSDATE)-(SYSDATE+5))*24*60*60)/3600)*3600)/60)
  || ' MINUTES ' ||
  round(((((SYSDATE)-(SYSDATE+5))*24*60*60) -
  floor((((SYSDATE)-(SYSDATE+5))*24*60*60)/3600)*3600 -
  (floor(((((SYSDATE)-(SYSDATE+5))*24*60*60) -
  floor((((SYSDATE)-(SYSDATE+5))*24*60*60)/3600)*3600)/60)*60) ))
  || ' SECS ' time_difference
  FROM DUAL;


/*--   ADD_MONTHS   --*/
-- Add 1 Month to current date
SELECT ADD_MONTHS(SYSDATE, 1) FROM dual;

/*--   LAST_DAY   --*/
SELECT LAST_DAY(SYSDATE) FROM dual;


/*-----   DBMS_OUTPUT   -----*/
set serveroutput on
BEGIN
Dbms_output.enable;
dbms_output.put_line('Run Time:  SELECT SYSDATE FROM DUAL');
END;
/



/*-----   DECODE   -----*/
SELECT DECODE('&PR_TYPE','1','PACKAGE','2','PACKAGE BODY','3','FUNCTION') FROM DUAL;
SELECT DECODE('&BOOLEAN_VALUE', TRUE,'PACKAGE', FALSE,'PACKAGE BODY') FROM DUAL;

SELECT parameter, DECODE(SIGN(parameter-1000),-1,'C','P') AS BAND
FROM parameter_table;



/*-----   INTO   -----*/

DECLARE
  TEST_DATE	DATE;
  TEST_ROWNUM	NUMBER;
BEGIN
  Dbms_output.enable;
  DBMS_OUTPUT.PUT_LINE(CHR(10));
  DBMS_OUTPUT.PUT_LINE('<--- START --->:' || CHR(10));

  DBMS_OUTPUT.PUT_LINE('TESTING');

  SELECT SYSDATE, ROWNUM INTO TEST_DATE, TEST_ROWNUM FROM DUAL;

  DBMS_OUTPUT.PUT_LINE('TEST_DATE = ' || TEST_DATE);

  DBMS_OUTPUT.PUT_LINE('TEST_ROWNUM = ' || TEST_ROWNUM);

EXCEPTION
WHEN OTHERS
THEN
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '< * * *   ERROR   * * * >' || CHR(10) );
  DBMS_OUTPUT.PUT_LINE('SQLCODE :   ' || SQLCODE );
  DBMS_OUTPUT.PUT_LINE('SQLERRM :' || CHR(10) || SQLERRM );
END;
/




/*-----   ERROR   -----*/
SHOW ERRORS


/*-----   HSOT ( SHOW THE CURRENT DIRECTORY )   -----*/
HOST


/*-----   INSERT   -----
|	INSERT FROM SELECT
*/

INSERT INTO TABLE_NAME (SELECT * FROM FROM_TABLE_NAME);


/*-----   INSTR   -----
|	Get the position of the searching character
*/
SELECT INSTR('ABCD, COL_01', '#') FROM DUAL;
SELECT INSTR('ABCD#EFG', '#', 1) FROM DUAL;
SELECT INSTR('', '1 XS', 1) FROM DUAL;
SELECT INSTR('ABAC - 3', '3', 1) FROM DUAL;
SELECT INSTR('1055807.', '.', 1) FROM DUAL;
SELECT INSTR('1055807', '.', 1) FROM DUAL;
SELECT INSTR('Toi Mary-Ann - Vancouver-MROC', ' - ', 1) FROM DUAL;
SELECT INSTR(RP_COMMENTS, chr(10), 1) FROM VW_ICT_FAC_COMMON_VALIDATE WHERE ARD_EDI_MESSAGE_ID = '5EF57AF5CA71475585252E7FA7007C20';
SELECT INSTR('ABCD#EFG', '#', 1) FROM DUAL;
SELECT INSTR('9509: Office and residential buildings, housing estate without shops, up to 7 floors', ':', 1) FROM DUAL;
SELECT INSTR('0000211537 - Economical Mutual Insurance Company', ' - ', 1) FROM DUAL;
SELECT INSTR('0000211537 - Economical Mutual Insurance Company', ' ', 1) FROM DUAL;
SELECT INSTR('http://i3s.munich.munichre.com/sm/index.do', 'http://') FROM DUAL;


/*
|	SEARCH FROM THE END
*/
SELECT INSTR('ABCD#EFG#HIJK', '#', -1) FROM DUAL;



/*
|	SEARCH THE 2rd OCCURRENCE
*/
SELECT INSTR('ABCD#EFG#HIJK', '#', 1, 2) FROM DUAL;

INSTR('ABCD#EFG#HIJK','#',1,2)
------------------------------
                             9

/*-----   LAG AND LEAD   -----*/
SELECT time_id, TO_CHAR(SUM(amount_sold),'9,999,999') AS SALES,
  TO_CHAR(LAG(SUM(amount_sold),1) OVER (ORDER BY time_id),'9,999,999') AS LAG1,
  TO_CHAR(LEAD(SUM(amount_sold),1) OVER (ORDER BY time_id),'9,999,999') AS LEAD1
FROM sales
WHERE time_id>=TO_DATE('10-OCT-2000') AND time_id<=TO_DATE('14-OCT-2000')
GROUP BY time_id;

TIME_ID   SALES      LAG1       LEAD1
--------- ---------- ---------- ----------
10-OCT-00    238,479                23,183
11-OCT-00     23,183    238,479     24,616
12-OCT-00     24,616     23,183     76,516
13-OCT-00     76,516     24,616     29,795
14-OCT-00     29,795     76,516



/*-----   LAST_DAY   -----*/

SELECT LAST_DAY(TO_DATE('2004-09', 'YYYY-MM')) FROM DUAL;


/*-----   LENGTH   -----*/

SELECT LENGTH('0123465789') FROM DUAL;
SELECT LENGTH('FPP ResultResponsibility 0025' || CHR(10) || CHR(10) || 'Omni:  929027 003F' || CHR(10) || 'LL, ta February 16th, 2010') FROM DUAL;


/*-----   LPAD   -----*/

SELECT LPAD( '0823', 4, '0') FROM DUAL;



/*--------------------   REGEXP   --------------------*/

/*-----   REGEXP_COUNT   -----*/

SELECT REGEXP_COUNT('testcol', 'e', 1, 'i') FROM dual;
SELECT REGEXP_COUNT('FPP ResultResponsibility 0025' || CHR(10) || CHR(10) || 'Omni:  929027 003F' || CHR(10) || 'LL, ta February 16th, 2010', 'd', 1, 'i') FROM DUAL;


/*-----   REGEXP_INSTR   -----*/

SELECT REGEXP_INSTR(srcstr, pattern [, position [, occurrence[, return_option [, match_option]]]]) FROM DUAL;
SELECT REGEXP_INSTR('OMNI - # 98767', '[0-9]') FROM DUAL;
SELECT REGEXP_INSTR('OMNI - 656237 000B', '[0-9]') FROM DUAL;
SELECT REGEXP_INSTR('9509: Office and residential buildings, housing estate without shops, up to 7 floors', '[:]') FROM DUAL;
SELECT REGEXP_INSTR('FPP ResultResponsibility 0025' || CHR(10) || CHR(10) || 'Omni:  929027 003F' || CHR(10) || 'LL, ta February 16th, 2010', chr(10)) FROM DUAL;
SELECT REGEXP_INSTR('FPP ResultResponsibility 0025' || CHR(10) || CHR(10) || 'Omni:  929027 003F' || CHR(10) || 'LL, ta February 16th, 2010', '^omni', 1, 1, 1, 'i') FROM DUAL;
SELECT REGEXP_INSTR('018099A2009', '^0[0-9]{5}[A-ZA-Z][0-9]{4}$') FROM DUAL;
SELECT REGEXP_INSTR('0123456A2009', '^0[0-9]{6}[A-ZA-Z][0-9]{4}$') FROM DUAL;
SELECT REGEXP_INSTR('01072100006', '^0[0-9]{10}$') FROM DUAL;
SELECT REGEXP_INSTR('018099A2009', '^0[0-9]{10}$|0[0-9]{5}[A-ZA-Z][0-9]{4}$|^0[0-9]{6}[A-ZA-Z][0-9]{4}$') FROM DUAL;
SELECT REGEXP_INSTR('Dath Restoration incl WTC U/ground Station - Archived File', '^D[A-Za-z0-9,]+$') FROM DUAL;




/*-----   REGEXP_SUBSTR   -----*/

SELECT REGEXP_SUBSTR('500 Oracle Parkway, Redwood Shores, CA', ',[^,]+,') RESULT FROM dual;
SELECT REGEXP_SUBSTR('Go to http://www.oracle.com/products and click on database', 'http://([[:alnum:]]+\.?){3,4}/?') RESULT FROM dual;
SELECT REGEXP_SUBSTR('We are trying to make the subject easier.','tr(y(ing)?|(ied)|(ies))') FROM dual;
SELECT REGEXP_SUBSTR('system/pwd@orabase:1521:sidval', '[^:]+', 1, 3) RESULT FROM dual;
SELECT REGEXP_SUBSTR('1:3,4:6,8:10,3:4,7:6,11:12', '[^:]+', 1, 1) RESULT FROM dual;
SELECT REGEXP_SUBSTR('1:3,4:6,8:10,3:4,7:6,11:12', '[^,]+', 3, 1) RESULT FROM dual;
SELECT 'a'||CHR(10)||'d' as ORIG, REGEXP_SUBSTR('a'||CHR(10)||'d', 'a.d', 1, 1, 'n') RESULT FROM dual;
SELECT 'a'||CHR(10)||'d' as ORIG, REGEXP_SUBSTR('ab'||CHR(10)||'ac', '^a.', 1, 2, 'm') RESULT FROM dual;

SELECT REGEXP_SUBSTR('OMNI - 656237 000B dfaskdfjkasdfs', '[^-]+', 1, 2) RESULT FROM dual;
SELECT REGEXP_SUBSTR('OMNI - 656237 000B dfaskdfjkasdfs', '[^ ]+', 1, 3) || ' ' || REGEXP_SUBSTR('OMNI - 656237 000B dfaskdfjkasdfs', '[^ ]+', 1, 4) RESULT FROM dual;
SELECT REGEXP_SUBSTR('9509: Office and residential buildings, housing estate without shops, up to 7 floors', '^:', 1, 2) RESULT FROM dual;



SELECT REGEXP_SUBSTR('OMNI - 656237 000B dfaskdfjkasdfs', '[^-]+', 1, 2) RESULT FROM dual;

SELECT REGEXP_SUBSTR(REGEXP_SUBSTR(TRANSLATE('OMNI - 657445 000', chr(10), '~~'), '[^~~]+', 1, 1), '[^ ]+', 1, 3) || ' ' || REGEXP_SUBSTR(REGEXP_SUBSTR(TRANSLATE('OMNI - 657445 000', chr(10), '~~'), '[^~~]+', 1, 1), '[^ ]+', 1, 4) FROM DUAL;

SELECT REGEXP_SUBSTR(REGEXP_SUBSTR(TRANSLATE(RP_COMMENTS, chr(10), '~~'), '[^~~]+', 1, 1), '[^ ]+', 1, 3) || ' ' || REGEXP_SUBSTR(REGEXP_SUBSTR(TRANSLATE(RP_COMMENTS, chr(10), '~~'), '[^~~]+', 1, 1), '[^ ]+', 1, 4) FROM VW_ICT_FAC_COMMON_VALIDATE WHERE ARD_EDI_MESSAGE_ID = '5EF57AF5CA71475585252E7FA7007C20';

SELECT REGEXP_SUBSTR(RP_COMMENTS, '[^~]+', 1, 1) || ' ' FROM VW_ICT_FAC_COMMON_VALIDATE WHERE ARD_EDI_MESSAGE_ID = '5EF57AF5CA71475585252E7FA7007C20';
SELECT REGEXP_SUBSTR(TRANSLATE(RP_COMMENTS, chr(10), '~~'), '[^~~]+', 1, 1) FROM VW_ICT_FAC_COMMON_VALIDATE WHERE ARD_EDI_MESSAGE_ID = '5EF57AF5CA71475585252E7FA7007C20';
SELECT REGEXP_SUBSTR('FPP ResultResponsibility 0025' || CHR(10) || CHR(10) || 'Omni:  929027 003F' || CHR(10) || 'LL, ta February 16th, 2010', '^omni') FROM DUAL;




/*-----   REPLACE   -----*/

SELECT REPLACE( 'A''B', '''', '''''' ) FROM DUAL;
SELECT REPLACE( 'A B', ' ', '@' ) FROM DUAL;



/*-----   ROWNUM   -----*/

SELECT * FROM TAC_STATS WHERE ROWNUM < 10


/*-----   SESSION   -----*/

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';


/*-----   SEQUENCE   -----*/

SQL> CREATE SEQUENCE ORDERS_SEQ
  2   START WITH     1000
  3   INCREMENT BY   1
  4   NOCACHE
  5   NOCYCLE;

Sequence created.

SQL> SELECT ORDERS_SEQ.NEXTVAL FROM DUAL

   NEXTVAL
----------
      1000

SQL> SELECT ORDERS_SEQ.CURRVAL FROM DUAL

   CURRVAL
----------
      1000




/*-----   SHOW   -----*/
/*--------------------------------------------------------------------------------
||	DESCRIPTION	: Show all setting
--------------------------------------------------------------------------------*/
SHOW ALL;
/*--------------------------------------------------------------------------------
||	DESCRIPTION	: Show all Error
--------------------------------------------------------------------------------*/
SHOW ERROR;


/*-----   SQLPROMPT   -----*/

set sqlprompt "sql>"


/*-----   SUBSTR   -----*/
SELECT SUBSTR('0123456789',2) FROM DUAL;
SELECT SUBSTR('0123456789',2,3) FROM DUAL;
SELECT SUBSTR('ABCDEFGHIJKLMNOPQRSTUVW',2,3) FROM DUAL;
SELECT SUBSTR('C:\Anthony\Document\Mroc\Team_Foundation_Server\OMNI_EDI\OMNI_EDI\log\FAB70020100114_13_56_54.csv', INSTR('C:\Anthony\Document\Mroc\Team_Foundation_Server\OMNI_EDI\OMNI_EDI\log\FAB70020100114_13_56_54.csv', '\', -1)+1) FROM DUAL;
SELECT SUBSTR('09QA0862/QA077109/A/X', INSTR('09QA0862/QA077109/A/X', '/', 1)+1) FROM DUAL;
SELECT SUBSTR('ICT_ACCOUNTTRANSACTION.ACCOUNTTRANSACTIONTYPE', INSTR('ICT_ACCOUNTTRANSACTION.ACCOUNTTRANSACTIONTYPE', '.', 1)+1) FROM DUAL;



/*
|	-----   SYSDATE   -----
|
*/
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYYMM') FROM DUAL;
SELECT TO_CHAR( TO_DATE('2002-12-27 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Q') FROM DUAL;
SELECT TRUNC( TO_DATE('2002-12-27 00:00:00','YYYY-MM-DD HH24:MI:SS')) FROM DUAL;



/*-----   SYS_GUID()   -----*/
SELECT SYS_GUID() FROM DUAL;


/*-----   TO_DATE   -----*/
SELECT * FROM TAC_STATS_HEADER
WHERE UPDATED_BY_WHOM = 'EDI'
and LAST_UPDATE > TO_DATE('2002-03-27 00:00:00','YYYY-MM-DD HH24:MI:SS');
SELECT TO_DATE('9999-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS') FROM DUAL;


/*-----   TO_CHAR   -----*/
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MON-DD HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(TO_DATE('2002-03-27 00:00:00','YYYY-MM-DD HH24:MI:SS'), 'MM') AS MONTH FROM DUAL;
SELECT TO_CHAR('10000000', '999,999,999.99') AS CONVERTED_NUMBER FROM DUAL;
SELECT TO_CHAR(10000000, '999,999,999.99') AS CONVERTED_NUMBER FROM DUAL;
SELECT TO_CHAR(100000000000, '999,999,999,999.99') AS CONVERTED_NUMBER FROM DUAL;


/*
|	-----   TO_NUMBER   -----
|	Check the size of the string and it is only working on select statement but not in function.
*/
SELECT TO_NUMBER('-AusDollars100','L9G999D99', ' NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY            = ''AusDollars''') "Amount" FROM DUAL;
SELECT TO_NUMBER('0123123', 99999999999) FROM DUAL;


/*-----   TRIM   -----*/
SELECT TRIM(' DFJSDKF ') FROM DUAL;
SELECT '->' || RTRIM('   Dan Morganxxx', 'xxx') || '<-' FROM dual;
SELECT RTRIM(RP_COMMENTS, chr(10)) FROM VW_ICT_FAC_COMMON_VALIDATE WHERE ARD_EDI_MESSAGE_ID = '5EF57AF5CA71475585252E7FA7007C20';

/*-----   TRIM.LEADING   -----*/
SELECT TRIM(LEADING '0' FROM '000123') FROM DUAL;

/*-----   TRIM.TRAILING   -----*/
SELECT TRIM(TRAILING '1' FROM 'TECH1') FROM DUAL;

/*-----   TRIM.BOTH   -----*/
SELECT TRIM(BOTH '1' FROM '1231Tech111') FROM DUAL;




/*-----   TRANSLATE   -----*/
SELECT TRANSLATE(t.text, chr(10), ' '))  FROM DUAL;
SELECT TRANSLATE(RP_COMMENTS, chr(10), '~') FROM VW_ICT_FAC_COMMON_VALIDATE WHERE ARD_EDI_MESSAGE_ID = '5EF57AF5CA71475585252E7FA7007C20';
SELECT TRANSLATE('ddd"dd', chr(10), ' ')  FROM DUAL;
SELECT TRANSLATE('ddd''dd', '''', 'AAAAAAAAAAAAA')  FROM DUAL;


/*
|	-----   VSIZE   -----
|	Check the size of the string and it is only working on select statement but not in function.
*/
SELECT VSIZE('DJFHASLDKFDKSLAF') FROM DUAL;


/*
|	-----   DOC   -----
|	EXIT FROM DOC>
*/
--DOC>#


/*--------------------     Table Functions      --------------------*/

/*-----   Alter table ADD COLUMN   -----*/

ALTER TABLE TABLE_1
  ADD ID_2 NUMBER(4);

ALTER TABLE CLM_TRANSACTIONS
  ADD SECOND_ARD_MESSAGE_ID VARCHAR2(32);







/*-----   Alter table DROP COLUMN   -----*/

ALTER TABLE TABLE_1
  DROP COLUMN ID_2;


/*-----   Alter table MODIFY COLUMN   -----*/

ALTER TABLE TABLE_NAME
  MODIFY TIME_TICKS VARCHAR(20);


/*-----   Alter table MODIFY COLUMN   -----*/

ALTER TABLE TABLE_000
  ADD CONSTRAINT UNIQUE_PROCESS_ID UNIQUE (PROCESS_ID);


/*-----   Alter table ENABLE OR DISABLE CONSTRAINT   -----*/

ALTER TABLE TABLE_NAME
  ENABLE CONSTRAINT CONSTRAINT_NAME;

ALTER TABLE TABLE_NAME
  DISABLE CONSTRAINT CONSTRAINT_NAME;


/*-----   Alter table ADD FOREIGN KEY   -----*/

ALTER TABLE TABLE_NAME
  ADD CONSTRAINT FK_TABLE_NAME
    FOREIGN KEY (STATION_ID)
    REFERENCES REF_TABLE_NAME (REF_COLUMN)
    ON DELETE CASCADE ENABLE;


/*-----   Create TABLE   -----*/

CREATE TABLE EDI_RUN_INFO
(
  EDI_RUN_INFO_PK VARCHAR2(32) NOT NULL,
  MRG_UNIT_CODE VARCHAR2(3) NOT NULL,
  EDI_FILE_TYPE VARCHAR2(20) NOT NULL,
  EDI_FILE_DATE DATE NOT NULL,
  TIME_TICKS VARCHAR2(20) NOT NULL,
  SETT_CASH_REF NUMBER(10) NULL,
  SUBMIT_DATE DATE NOT NULL,
  CONSTRAINT PK_EDI_RUN_INFO PRIMARY KEY (EDI_RUN_INFO_PK)
);

CREATE TABLE GT_TABLE_COLUMN
(
  GT_TABLE_COLUMN_PK VARCHAR2(32) DEFAULT SYS_GUID() NOT NULL,
  TABLE_NAME VARCHAR2(40) NOT NULL,
  COLUMN_NAME VARCHAR2(40) NOT NULL,
  LASTUPDATED_BY VARCHAR2(100) DEFAULT 'SYSTEM' NOT NULL,
  LAST_UPDATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT GT_TABLE_COLUMN PRIMARY KEY (GT_TABLE_COLUMN_PK)
);

/*-----   THIS WILL CREATE A NEW TABLE AND COPY ALL DATA FROM EXISTING TABLE WITH THE SAME TABLE DEFINATION   -----*/
/*-----   CREATE TABLE FROM SELECT   -----*/
CREATE TABLE NEW_TABLE_NAME AS SELECT * FROM EXISTING_TABLE_NAME;


/*-----   DROP TABLE   -----*/
DROP TABLE EDI_RUN_INFO CASCADE CONSTRAINTS;


create table table_1( id number(4) NOT NULL PRIMARY KEY,name varchar2(10) );

create table table_2
(
  id number(4) not null primary key,
  id_1 number (4)  NOT NULL  REFERENCES TABLE_1(ID)
);



/*-----   CREATE COMMENT TO COLUMN FOR TABLE   -----*/

SELECT
  'COMMENT ON COLUMN ' || C.TABLE_NAME || '.' || C.COLUMN_NAME || ' IS ''' || C.COLUMN_NAME || ''';'
  FROM
    COLS C, USER_COL_COMMENTS CC
    WHERE
      C.TABLE_NAME = CC.TABLE_NAME
      AND C.COLUMN_NAME = CC.COLUMN_NAME
      AND CC.COMMENTS IS NULL
      AND C.TABLE_NAME = 'ARD_EDI_MESSAGE';

COMMENT ON COLUMN CONTRACTPREMIUM.DEPOSITPREMIUMPAYABLEBYDATE IS 'DEPOSIT PREMIUM PAYABLE BY DATE';



/*------------------------------------------------------------
||	NAME		:	CREATE VIEWS
||	DESCRIPTION	:	CREATE VIEWS
||	CREATE		:	2006-08-31
||	LAST UPDATE	:	2006-08-31
------------------------------------------------------------*/


CREATE VIEW VW_FIELDS_TO_DISPLAY AS
  SELECT
    TABLE_NAME,
    COLUMN_NAME,
    LABEL,
    MSG_GROUP,
    DESCRIPTION,
    IS_VISIBLE,
    IS_EDITABLE
    FROM
      GT_TABLE_COLUMN TBL,
      GT_DISPLAY_FIELDS DIS
      WHERE
        TBL.GT_TABLE_COLUMN_PK = DIS.GT_TABLE_COLUMN_PK;








SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='TABLE_1';

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME  ='tac_retro_temp_1';



EXPLAIN PLAN FOR SQL STATEMENT

SELECT * FROM PLAN_TABLE;



/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*------------------------------------------------------------
||	NAME		:	Array of column Type
||	DESCRIPTION	:	Array of column Type
||	CREATE		:	2011-01-24
||	LAST UPDATE	:	2011-01-24
||	URL			:	http://download.oracle.com/docs/cd/B19306_01/appdev.102/b14261/tuning.htm#BABJCBGD
------------------------------------------------------------*/

DECLARE
  TYPE T_COL_NAME IS TABLE OF COLS.COLUMN_NAME%TYPE;
  NAME_OF_COLS T_COL_NAME;
BEGIN
  SELECT T.COLUMN_NAME BULK COLLECT INTO NAME_OF_COLS FROM COLS T WHERE T.TABLE_NAME = 'ARD_EDI_MESSAGE';

--  FORALL i IN 1..NAME_OF_COLS.COUNT

  FOR i IN 1..NAME_OF_COLS.COUNT LOOP
   DBMS_OUTPUT.PUT_LINE('Dept '||NAME_OF_COLS(i)||': inserted ');
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Total records inserted: ' || SQL%ROWCOUNT);
--   print_results();
END;
/

DECLARE
   TYPE NumTab IS TABLE OF employees.employee_id%TYPE;
   TYPE NameTab IS TABLE OF employees.last_name%TYPE;
   enums NumTab;   -- No need to initialize the collections.
   names NameTab;  -- Values will be filled in by the SELECT INTO.
   PROCEDURE print_results IS
   BEGIN
     IF enums.COUNT = 0 THEN
       DBMS_OUTPUT.PUT_LINE('No results!');
     ELSE
       DBMS_OUTPUT.PUT_LINE('Results:');
       FOR i IN enums.FIRST .. enums.LAST
       LOOP
         DBMS_OUTPUT.PUT_LINE('  Employee #' || enums(i) || ': ' || names(i));
       END LOOP;
     END IF;
   END;
BEGIN
 -- Retrieve data for employees with Ids greater than 1000
   SELECT employee_id, last_name
     BULK COLLECT INTO enums, names FROM employees WHERE employee_id > 1000;
-- The data has all been brought into memory by BULK COLLECT
-- No need to FETCH each row from the result set
   print_results();
 -- Retrieve approximately 20% of all rows
   SELECT employee_id, last_name
      BULK COLLECT INTO enums, names FROM employees SAMPLE (20);
   print_results();
END;
/













/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Object Update      ------------------------------*/

VARIABLE	RECORD_COUNT		NUMBER;

BEGIN

  :RECORD_COUNT	:= -1;

  SELECT COUNT(*) INTO :RECORD_COUNT FROM USER_TAB_COLS WHERE TABLE_NAME = 'FAC_OTHER_COMMON_INFO' AND COLUMN_NAME = 'ARD_EDI_MESSAGE_ID';

  IF ( :RECORD_COUNT = 0 ) THEN
    EXECUTE IMMEDIATE 'ALTER TABLE FAC_OTHER_COMMON_INFO ADD ARD_EDI_MESSAGE_ID VARCHAR2(32)';
  END IF;

END;
/
PRINT :RECORD_COUNT;




/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Setting      ------------------------------*/


COLUMN COLUMN_NAME FORMAT A30

CLEAR COLUMNS

SET AUTOT[RACE] {OFF | ON | TRACE[ONLY]} [EXP[LAIN]] [STAT[ISTICS]]
SET AUTOTRACE ON
SET AUTOTRACE OFF




/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Performance      ------------------------------*/

SET AUTOTRACE TRACEONLY EXPLAIN STATISTICS;

SET AUTOTRACE ON
SET AUTOTRACE OFF



/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     Reporting      ------------------------------*/

/*-----   Set Column Width   -----*/
COLUMN COLUMN_NAME FORMAT A30

/*-----   Set Column Width   -----*/
CLEAR COLUMNS

/*-----   Suppressing and Restoring Column Display Attributes   -----*/
COLUMN column_name ON
COLUMN column_name OFF

BREAK
CLEAR BREAKS




/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     BACKUP CURRENT INFO. INTO SCRIPT      ------------------------------*/


SELECT 'INSERT INTO GT_DISPLAY_FIELDS ( GT_TABLE_COLUMN_PK ) VALUES (''' || GT_TABLE_COLUMN_PK || ''')' FROM GT_DISPLAY_FIELDS;
INSERT INTO GT_DISPLAY_FIELDS (GT_TABLE_COLUMN_PK, LABEL, MSG_GROUP, DESCRIPTION, IS_VISIBLE, IS_EDITABLE, DISPLAY_INDEX, MSG_PRIMARY_KEY, LASTUPDATED_BY) VALUES ('4ABB82854BA14B949884940F2BBD3FA9', 'PROCESSED_DONE', 'CLAIM', 'C10_20', 1, 0, 100, 0, 'SCRIPT INSERT');





/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     SCRIPT TEST      ------------------------------*/

DECLARE
  X1	varchar2(250);
  STATEMENT_PERIOD_INFO	PG_TAC_VALIDATE.type_CEDENT_PERIOD_YEAR;
  treaty_info 			PG_TUW_CURSORS.treaty_Info_RecType;
  FREQUENCY_CODE 			TUW_CONTRACT.FREQUENCY_CODE%type;
BEGIN
  Dbms_output.enable;
  DBMS_OUTPUT.PUT_LINE(CHR(10));
  DBMS_OUTPUT.PUT_LINE('<--- START --->:' || CHR(10));

  treaty_info :=  PG_EDI.FN_GET_TREATY_RECORD('7000242004');

  DBMS_OUTPUT.PUT_LINE('CEDENT_PERIOD  = ' || treaty_info.effective_date);

  SELECT FREQUENCY_CODE INTO FREQUENCY_CODE FROM TUW_CONTRACT WHERE LIM_NO = '7000242004' AND EFFECTIVE_DATE = treaty_info.effective_date;

  DBMS_OUTPUT.PUT_LINE('FREQUENCY_CODE = ' || FREQUENCY_CODE);

  PG_TAC_VALIDATE.GET_CEDENT_PERIOD_YEAR(treaty_info.effective_date, FREQUENCY_CODE, '30 APR 05', STATEMENT_PERIOD_INFO);

  DBMS_OUTPUT.PUT_LINE('CEDENT_PERIOD  = ' || STATEMENT_PERIOD_INFO.CEDENT_PERIOD);
  DBMS_OUTPUT.PUT_LINE('CEDENT_YEAR    = ' || STATEMENT_PERIOD_INFO.CEDENT_YEAR);

  SELECT FN_TAC_GET_PERIOD_FOR_EDI('17 NOV 04','M', '30 APR 05') INTO X1 FROM DUAL;

  DBMS_OUTPUT.PUT_LINE('CEDENT_PERIOD  = ' || X1);


  DBMS_OUTPUT.PUT_LINE(CHR(10) || '<---  END  --->:' || CHR(10));

EXCEPTION
WHEN OTHERS
THEN
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '< * * *   ERROR   * * * >' || CHR(10) );
  DBMS_OUTPUT.PUT_LINE('SQLCODE :   ' || SQLCODE );
  DBMS_OUTPUT.PUT_LINE('SQLERRM :' || CHR(10) || SQLERRM );
END;
/




/*------------------------------     PACKAGE TEST      ------------------------------*/




/*---------------     PG_AL_TEST     ---------------*/

/*------     PR_CURSOR_TEST     -----*/

VARIABLE X1 VARCHAR2(4000);

execute PG_AL_TEST.PR_CURSOR_TEST('0000', :X1);

print :X1;


/*------     FN_GET_DATA     -----*/

SELECT * FROM ARD_EDI_FILE;

SELECT PG_AL_TEST.FN_GET_DATA('ARD_EDI_FILE', 'EDI_FILE_DATE, ARD_EDI_FILE_PK', 'ARD_EDI_FILE_PK = ''293D44F412FD4C5BB9C93E3D75B14D2C''') FROM DUAL;
SELECT PG_AL_TEST.FN_GET_DATA('ARD_EDI_FILE', 'ARD_EDI_FILE_PK', 'ARD_EDI_FILE_PK = ''293D44F412FD4C5BB9C93E3D75B14D2C''') FROM DUAL;


/*------     FN_GEN_UPD_SQL     -----*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT PG_AL_TEST.FN_GEN_UPD_SQL('ARD_EDI_FILE', 'ARD_EDI_FILE_PK = ''1021407384CE4A46A3156918CB8E9446''') FROM DUAL;
SELECT PG_AL_TEST.FN_GEN_UPD_SQL('ARD_EDI_MSG_LOG', 'ARD_EDI_MSG_LOG_PK = ''83FEBBE783274437819E1414A91A73F7''', 'ARD_EDI_MSG_LOG_PK') FROM DUAL;
SELECT PG_AL_TEST.FN_GEN_UPD_SQL('ARD_EDI_MSG_LOG', 'ARD_EDI_MSG_LOG_PK = ''83FEBBE783274437819E1414A91A73F7''') FROM DUAL;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';


/*----------     TEST_GBL_IN      ----------*/

execute PG_AL_TEST.TEST_GBL_IN( '00000' );



/*----------     TEST_GBL_OUT      ----------*/

SELECT PG_AL_TEST.TEST_GBL_OUT() FROM DUAL;


/*----------     PR_TABLE_CONSTRAINTS      ----------*/

VARIABLE X1 REFCURSOR;

execute PG_AL_TEST.PR_TABLE_CONSTRAINTS( 'RDO_DOWNLOAD', :X1);

print :X1;


/*----------     PR_ALL_CHILD_TABLE      ----------*/

VARIABLE X1 REFCURSOR;

execute PG_AL_TEST.PR_ALL_CHILD_TABLE( 'RDO_DOWNLOAD', :X1);

print :X1;


/*----------     PR_TABLE_DESC      ----------*/

VARIABLE X1 REFCURSOR;

execute PG_AL_TEST.PR_TABLE_DESC(:X1);

print :X1;



/*----------     FN_GEN_CHILD_SQL      ----------*/

SELECT PG_AL_TEST.FN_GEN_CHILD_SQL('FAC_COMMON', '067906704C54491DA2A32E82CBF0BD24') FROM DUAL;



/*----------     FN_FILEPATH_TEST      ----------*/

SELECT PG_AL_TEST.FN_FILEPATH_TEST('C:\temp\Source\PF.GBMUR.REDMROC.CLMLRC.D100327.R03106_139_1.xml') FROM DUAL;



/*----------     FN_GET_ICT_MSG_RUNTIME      ----------*/

SELECT PG_AL_TEST.FN_GET_ICT_MSG_RUNTIME('E97DB5AE2E0C4BAA8BFA37F32A55A28B') FROM DUAL;



/*----------     PRT_CHR_CODE      ----------*/

@CLS

execute PG_AL_TEST.PRT_CHR_CODE();



/*----------     PRT_CHR_CODE      ----------*/

execute PG_AL_TEST.ARD_MSG_ERROR_COUNT();



/*----------     FN_URL      ----------*/

SELECT PG_AL_TEST.FN_URL('http://msdn.microsoft.com/en-us/library/system.xml.serialization.xmlserializer.aspx?T=9') FROM DUAL;



/*----------     FN_get_DomainFromURL      ----------*/

SELECT PG_AL_TEST.FN_get_DomainFromURL('http://msdn.microsoft.com/en-us/library/system.xml.serialization.xmlserializer.aspx?T=9') FROM DUAL;



/*----------     FN_get_RelativePathFromURL      ----------*/

SELECT PG_AL_TEST.FN_get_RelativePathFromURL('http://msdn.microsoft.com/en-us/library/system.xml.serialization.xmlserializer.aspx?T=9') FROM DUAL;



/*----------     FN_get_FilenameFromURL      ----------*/

SELECT PG_AL_TEST.FN_get_FilenameFromURL('http://msdn.microsoft.com/en-us/library/system.xml.serialization.xmlserializer.aspx?T=9') FROM DUAL;



/*----------     FN_TRIM_ProtocolFromURL      ----------*/

SELECT PG_AL_TEST.FN_TRIM_ProtocolFromURL('http://msdn.microsoft.com/en-us/library/system.xml.serialization.xmlserializer.aspx?T=9') FROM DUAL;




/*----------     ARD_DEL_ACORD_XML_FILE      ----------*/

@CLS

VARIABLE	X1			VARCHAR2(4000);

execute PG_AL_TEST.ARD_DEL_ACORD_XML_FILE( '', :X1);
ROLLBACK;
print :X1;


execute PG_AL_TEST.ARD_DEL_ACORD_XML_FILE( 'E97DB5AE2E0C4BAA8BFA37F32A55A28B', :X1);
ROLLBACK;
print :X1;

execute PG_AL_TEST.ARD_DEL_ACORD_XML_FILE( 'F7CD41B398C3487794A4E943FB6AE0A2', :X1);
ROLLBACK;
print :X1;

execute PG_AL_TEST.ARD_DEL_ACORD_XML_FILE( '55DAA0F802284B508AAE39FE18574489', :X1);
ROLLBACK;
print :X1;



/*----------     ARD_MESSAGE_LOG_BY_MSG_ID      ----------*/

@CLS

VARIABLE	X1			REFCURSOR;

execute PG_AL_TEST.ARD_MESSAGE_LOG_BY_MSG_ID( '', :X1);
ROLLBACK;
print :X1;


execute PG_AL_TEST.ARD_MESSAGE_LOG_BY_MSG_ID( 'E97DB5AE2E0C4BAA8BFA37F32A55A28B', :X1);
ROLLBACK;
print :X1;



/*----------     ARD_MESSAGE_INFO_BY_MSG_ID      ----------*/

@CLS

execute PG_AL_TEST.ARD_MESSAGE_INFO_BY_MSG_ID( '');
ROLLBACK;
print :X1;


execute PG_AL_TEST.ARD_MESSAGE_INFO_BY_MSG_ID( '3D478B49DC4344C7AD6EFF23DB3C6DB9');
ROLLBACK;



/*----------     ARD_FAC_COMMON_INFO_BY_PK      ----------*/

@CLS

execute PG_AL_TEST.ARD_FAC_COMMON_INFO_BY_PK( '');
ROLLBACK;


execute PG_AL_TEST.ARD_FAC_COMMON_INFO_BY_PK( '1A315D3CAC7945648ADAEE5BADB8907B');
ROLLBACK;



/*----------     ARD_FAC_COMMON_INFO_BY_PK      ----------*/

SELECT PG_AL_TEST.ARD_F_GET_F_OR_T_BY_MSG_ID('1A315D3CAC7945648ADAEE5BADB8907B') AS FAC_OR_TREATY FROM DUAL;
ROLLBACK;



/*----------     ARD_IS_SETT_MATCHED_BY_MSG_ID      ----------*/

SELECT PG_AL_TEST.ARD_IS_SETT_MATCHED_BY_MSG_ID('1A315D3CAC7945648ADAEE5BADB8907B') AS IS_SETT_MATCHED FROM DUAL;



/*------     PR_CURSOR_TEST     -----*/

VARIABLE X1 VARCHAR2(4000);

execute PG_AL_TEST.UT_Isycl_Populate_Data('6E8A50521E2640F381CA81022C2D11DD', 'TEST 4', :X1);

print :X1;













/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

/*------------------------------     MROC      ------------------------------*/

/*---------------     @shcon     ---------------*/
SQL>@shcon


/*---------------     @shcon     ---------------*/

SELECT TABLE_NAME, NUM_ROWS, LAST_ANALYZED FROM ALL_TABLES
WHERE OWNER = 'ACORD2'
--AND TABLE_NAME LIKE 'FAC_%'
ORDER BY TABLE_NAME;


/*---------------     @shu     ---------------*/
SQL>@shu

/*---------------     @SKILL     ---------------*/
SQL>@SKILL


















select column_name
 ,DATA_TYPE
 ,DATA_LENGTH
  ,DATA_PRECISION
  ,DATA_SCALE
 ,NULLABLE
 from USER_TAB_COLUMNS WHERE table_name = '&TAC_STATS'
 MINUS
 (select column_name
 ,DATA_TYPE
 ,DATA_LENGTH
 ,DATA_PRECISION
 ,DATA_SCALE
 ,NULLABLE
 from XYZ_ANTHONY  WHERE table_name = '&TAC_STATS'
 INTERSECT
 select column_name
 ,DATA_TYPE
 ,DATA_LENGTH
 ,DATA_PRECISION
 ,DATA_SCALE
 ,NULLABLE
 from dba_TAB_COLUMNS where table_name = '&TAC_STATS'
 )


SELECT COLUMN_NAME
 ,SUBSTR(DATA_TYPE, 1, 30)
 ,DATA_LENGTH
  ,DATA_PRECISION
  ,DATA_SCALE
 ,NULLABLE
 FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'FAC_COMMON'
 MINUS
 (SELECT COLUMN_NAME
 ,DATA_TYPE
 ,DATA_LENGTH
 ,DATA_PRECISION
 ,DATA_SCALE
 ,NULLABLE
 FROM XYZ_ANTHONY  WHERE TABLE_NAME = 'FAC_COMMON'
 INTERSECT
 SELECT COLUMN_NAME
 ,DATA_TYPE
 ,DATA_LENGTH
 ,DATA_PRECISION
 ,DATA_SCALE
 ,NULLABLE
 FROM DBA_TAB_COLUMNS WHERE TABLE_NAME = 'FAC_COMMON'
 );

SELECT COLUMN_NAME
 ,DATA_TYPE
 ,DATA_LENGTH
 ,DATA_PRECISION
 ,DATA_SCALE
 ,NULLABLE
 FROM XYZ_ANTHONY  WHERE TABLE_NAME = 'TAC_STATS'

SELECT COLUMN_NAME, SUBSTR(DATA_TYPE, 1, 30), DATA_LENGTH, DATA_PRECISION, DATA_SCALE, NULLABLE
FROM XYZ_ANTHONY WHERE TABLE_NAME = 'FAC_COMMON'
MINUS
SELECT COLUMN_NAME, SUBSTR(DATA_TYPE, 1, 30), DATA_LENGTH, DATA_PRECISION, DATA_SCALE, NULLABLE
FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'TAC_STATS';



ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';


































