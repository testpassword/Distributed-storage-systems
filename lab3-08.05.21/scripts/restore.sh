echo "ВОССТАНОВЛЕНИЕ НА УЗЛЕ НАЗНАЧЕНИЯ ИЗ РЕЗЕРВНОЙ КОПИИ"
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
RECOVER DATABASE;
ALTER DATABASE OPEN RESETLOGS;
EXIT;
EOF