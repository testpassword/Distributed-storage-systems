CONNECT / AS sysdba;
CREATE TABLESPACE busy_green_fish
    DATAFILE
        '/u01/qvs94/leftfish/node03/busygreenfish01.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED,
        '/u01/qvs94/leftfish/node02/busygreenfish02.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED,
        '/u01/qvs94/leftfish/node04/busygreenfish03.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED;

CREATE TABLESPACE dry_gray_soup
    DATAFILE
        '/u01/qvs94/leftfish/node03/drygraysoup01.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED,
        '/u01/qvs94/leftfish/node04/drygraysoup02.dbf'
        SIZE 20M
        REUSE
        AUTOEXTEND ON
        MAXSIZE UNLIMITED;