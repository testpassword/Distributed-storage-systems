# 0. СОЗДАНИЕ ЭКЗЕМПЛЯРА БД НА УЗЛАХ КАК В ЛАБ2 И НАПОЛНЕНИЕ ИХ ТЕСТОВЫМИ ДАННЫМИ

echo "1. СОЗДАНИЕ РЕЗЕРВНОЙ КОПИИ"
sqlplus / as sysdba <<< "ALTER SYSTEM ARCHIVE LOG CURRENT; EXIT;"
rman target /<<EOF                    # подключение к rman с помощью механизма аутентификации ОС
CONFIGURE CONTROLFILE AUTOBACKUP ON;  # создание резервной копии управляющего файла
BACKUP DATABASE PLUS ARCHIVELOG;      # создание полной резервной копии БД
EXIT;
EOF

echo "2. ФОРМИРОВАНИЕ КОМАНД НА ВЫПОЛНЕНИЕ УЗЛУ НАЗНАЧЕНИЯ"
echo '
echo "4. ВОССТАНОВЛЕНИЕ НА УЗЛЕ НАЗНАЧЕНИЯ"
rman target/<<EOF
SHUTDOWN;
SET DBID 1387713281;
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
' > restore.sh

echo "3. ОТПРАВКА БЭКАПА НА УЗЕЛ НАЗНАЧЕНИЯ"
dest=oracle@db197
backup_path=/u01/qvs94/fra/LEFTFISH/
scp -r $backup_path/autobackup/ $dest:$backup_path
scp -r $backup_path/backupset/ $dest:$backup_path
scp restore.sh $dest:/u01/lab3_s/restore.sh
ssh $dest <<EOF
bash /u01/lab3_s/restore.sh
EOF