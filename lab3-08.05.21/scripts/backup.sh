# предварительно нужно создать экземпляр oracle и базу данных на узле-источнике и только экземпляр oracle на узле назначения (запустить configurer.sh в режиме EX_ONLY)

echo "СОЗДАНИЕ РЕЗЕРВНОЙ КОПИИ"
rman target / << EOF                    # подключение к rman с помощью механизма аутентификации ОС
SQL 'ALTER SYSTEM ARCHIVE LOG CURRENT';
CONFIGURE CONTROLFILE AUTOBACKUP ON;
BACKUP DATABASE PLUS ARCHIVELOG;      # создание полной резервной копии БД
EXIT;
EOF

echo "ОТПРАВКА БЭКАПА НА УЗЕЛ НАЗНАЧЕНИЯ"
dest=oracle@db197
backup_path=/u01/qvs94/fra
scp -r $backup_path/LEFTFISH/ $dest:$backup_path
scp restore.sh $dest:/u01/dss3/restore.sh
ssh $dest << EOF
bash
chmod +x ~/dss3/restore.sh
source ~/dss3/restore.sh
EOF