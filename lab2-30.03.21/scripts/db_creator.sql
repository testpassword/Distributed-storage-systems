CONNECT / AS sysdba;
CREATE DATABASE leftfish
    USER SYS IDENTIFIED BY admin
    USER SYSTEM IDENTIFIED BY admin
    LOGFILE
        GROUP 1
            ('/u01/qvs94/leftfish/logs/redo01.log')
            SIZE 8M,
        GROUP 2
            ('/u01/qvs94/leftfish/logs/redo02.log')
            SIZE 8M
    MAXLOGFILES 3
    MAXLOGMEMBERS 3
    MAXDATAFILES 128
    CHARACTER SET UTF8
    EXTENT MANAGEMENT LOCAL
    DATAFILE
        '/u01/qvs94/leftfish/node04/elide49.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED,
        '/u01/qvs94/leftfish/node02/edive1.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED
    sysaux DATAFILE
        '/u01/qvs94/leftfish/node01/dep34.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED,
        '/u01/qvs94/leftfish/node03/sef98.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED
    DEFAULT TABLESPACE users DATAFILE
        '/u01/qvs94/leftfish/node01/eguqihu344.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED,
        '/u01/qvs94/leftfish/node02/evadagi518.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED
    DEFAULT TEMPORARY TABLESPACE temp TEMPFILE
        '/u01/qvs94/leftfish/temp01.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED
    UNDO TABLESPACE undotbs DATAFILE
        '/u01/qvs94/leftfish/undotbs01.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED;