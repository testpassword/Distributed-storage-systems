echo "ВОССТАНОВЛЕНИЕ ИЗ РЕПЛИКИ НА УЗЛЕ НАЗНАЧЕНИЯ ПЕРВЫЙ РАЗ"
# DBID - идентификатор исходной базы данных, нужен для восстановления. Получить его можно в выводе команды `rman target /` на исходной базе
rman target / << EOF
SHUTDOWN;
SET DBID 1388105612;                    # установка id аналогичному id исходной БД
STARTUP NOMOUNT;
RESTORE CONTROLFILE FROM AUTOBACKUP;    # восстановить контрольный файл
ALTER DATABASE MOUNT;
CROSSCHECK BACKUP;                      # проверки данных для восстановления на целостность
CROSSCHECK COPY;
CROSSCHECK ARCHIVELOG ALL;
RESTORE DATABASE;                       # восстановить БД
EXIT
EOF
sqlplus / as sysdba << EOF
RECOVER DATABASE UNTIL CANCEL;          # откатить/докатить до состояния из резервной копии
ALTER DATABASE OPEN RESETLOGS;          # сбросить лог, чтобы не возникало ошибок записи после восстановления
EXIT;
EOF