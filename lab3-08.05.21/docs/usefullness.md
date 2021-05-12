- Для удобства лучше предварительно:
    1. Создать ssh-ключи для подключения к узлам (`ssh-keygen`)
    2. Прописать все переменные окружения в `.bashrc`
- Включение БД:
```
sqlplus / as sysdba;
STARTUP;
```
- Подключение без входа: `sqlplus /nolog`
- Подключение как системный пользователь: `sqlplus / as sysdba`
- Удалить логи из отслеживаемых RMAN-ом: https://knowledge.exlibrisgroup.com/Aleph/Knowledge_Articles/Expected_archived_log_not_found%2C_lost_of_archived_log_compromises_recoverability
- [Подготовка БД](prepare_db.sql) и [заполнение](filter.sql) выполняются один раз.
- При первоначальном копировании нужно выполнять `recover database until cancel;`, в последующие разы `recover database;`
- Создание задачи для cron:
```
crontab -e
0 * 1 * * source /u01/qvs94/backup.sh
```