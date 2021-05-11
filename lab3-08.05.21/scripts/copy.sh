echo "КОПИРОВАНИЕ НА УЗЕЛ НАЗНАЧЕНИЯ ПЕРВЫЙ РАЗ"
# DBID - идентификатор исходной базы данных, нужен для восстановления. Получить его можно в выводе команды `rman target /` на исходной базе
rman target / << EOF
SHUTDOWN;
SET DBID 1387880629;
STARTUP NOMOUNT;
RESTORE CONTROLFILE FROM AUTOBACKUP;
ALTER DATABASE MOUNT;
CROSSCHECK BACKUP;
CROSSCHECK COPY;
CROSSCHECK ARCHIVELOG ALL;
RESTORE DATABASE;
EOF
sqlplus / as sysdba << EOF
RECOVER DATABASE UNTIL CANCEL;
ALTER DATABASE OPEN RESETLOGS;
EXIT;
EOF