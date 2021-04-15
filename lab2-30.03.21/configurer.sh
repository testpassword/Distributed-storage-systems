echo "0. ПОДГОТОВКА НЕОБХОДИМЫХ КАТАЛОГОВ"
mount_dir=/u01/qvs94
db_name=leftfish
mkdir -p mount_dir   # создание точки монтирования
chown oracle:oinstall mount_dir   # задание прав на точку
for (( i = 1; i <= 4; i++ ))
do
  mkdir -p $mount_dir/$db_name/node0$i
done
mkdir $mount_dir/$db_name/logs

echo "1. ЗАДАНИЕ ЗНАЧЕНИЙ НЕОБХОДИМЫХ ДЛЯ КОНФИГУРАЦИИ ПЕРЕМЕННЫХ ОКРУЖЕНИЯ"
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=kulbako_saraev_p33112
export PATH=$PATH:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export NLS_LANG=American_America.UTF8
export NLS_SORT=AMERICAN
export NLS_DATE_LANGUAGE=AMERICAN
export NLS_DATE_FORMAT="DD.MM.YYYY"

# Установка Oracle Database 11G (в лабе этот шаг отсутствует)

echo "2. ЗАДАНИЕ МЕТОДА АУТЕНТИФИКАЦИИ АДМИНИСТРАТОРА"
cd $ORACLE_HOME/dbs   # переход в стандартный каталог для конфигов
orapwd file=ora$ORACLE_SID force=Y    # создание файла аутентификации

echo "3. СОЗДАНИЕ КОНФИГУРАЦИОННЫХ ФАЙЛЫ, НЕОБХОДИМЫХ ДЛЯ ИНИЦИАЛИЗАЦИИ И ЗАПУСКА ЭКЗЕМПЛЯРА ORACLE"
echo "
DB_NAME=$db_name
DB_BLOCK_SIZE=4096
SGA_TARGET=440M
" >> init$ORACLE_SID.ora    # создание файла инициализации экземпляра

echo "4. ЗАПУСК ЭКЗЕМПЛЯРА ORACLE"
exit | sqlplus /nolog @mounter.sql

echo "5. СОЗДАНИЕ НОВОЙ БАЗЫ ДАННЫХ"
exit | sqlplus /nolog @db_creator.sql

echo "6. СОЗДАНИЕ ДОПОЛНИТЕЛЬНЫХ ТАБЛИЧНЫХ ПРОСТРАНСТВ"
exit | sqlplus /nolog @tb_creator.sql

echo "7. ФОРМИРОВАНИЕ ПРЕДСТАВЛЕНИЯ СЛОВАРЯ ДАННЫХ"
exit | sqlplus /nolog @view_creator.sql