# скрипт запускать командой `. configurer.sh` или `source configurer.sh` чтобы импорт переменных сработал (https://stackoverflow.com/questions/10781824/export-not-working-in-my-shell-script)

function drop_db {
  echo "УДАЛЕНИЕ БАЗЫ ДАННЫХ"
  sqlplus /nolog <<< "SHUTDOWN ABORT; EXIT;"
  rm -rf $mount_dir
  rm $ORACLE_HOME/dbs/*
}

function set_envs {
  echo "ЗАДАНИЕ ЗНАЧЕНИЙ НЕОБХОДИМЫХ ДЛЯ КОНФИГУРАЦИИ ПЕРЕМЕННЫХ ОКРУЖЕНИЯ"
  export ORACLE_BASE=/u01/app/oracle
  export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
  export ORACLE_SID=kulbako_saraev_p33112
  export PATH=$PATH:$ORACLE_HOME/bin
  export LD_LIBRARY_PATH=$ORACLE_HOME/lib
  export NLS_LANG=American_America.UTF8
  export NLS_SORT=AMERICAN
  export NLS_DATE_LANGUAGE=AMERICAN
  export NLS_DATE_FORMAT="DD.MM.YYYY"
}

function create_dirs {
  echo "ПОДГОТОВКА НЕОБХОДИМЫХ КАТАЛОГОВ"
  mkdir -p $mount_dir   # создание точки монтирования
  chown oracle:oinstall $mount_dir   # задание прав на точку
  for (( i = 1; i <= 4; i++ ))
  do
    mkdir -p $mount_dir/$db_name/node0$i
  done
  mkdir $mount_dir/$db_name/logs
  recovery_dir=$mount_dir/fra
  mkdir $recovery_dir  # создание директории для резервных копий
}

function auth {
  echo "ЗАДАНИЕ МЕТОДА АУТЕНТИФИКАЦИИ АДМИНИСТРАТОРА"
  cd $ORACLE_HOME/dbs   # переход в стандартный каталог для конфигов
  orapwd file=ora$ORACLE_SID force=Y    # создание файла аутентификации
}

function create_configs {
  echo "СОЗДАНИЕ КОНФИГУРАЦИОННЫХ ФАЙЛЫ, НЕОБХОДИМЫХ ДЛЯ ИНИЦИАЛИЗАЦИИ И ЗАПУСКА ЭКЗЕМПЛЯРА ORACLE"
  # параметры DB_RECOVERY не нужны для лаб2 и их можно удалить, но пригодятся в лаб3
  echo "
  DB_NAME=$db_name
  DB_BLOCK_SIZE=4096
  SGA_TARGET=440M
  DB_RECOVERY_FILE_DEST_SIZE=20G
  DB_RECOVERY_FILE_DEST='$recovery_dir'
  " >> init$ORACLE_SID.ora    # создание файла инициализации экземпляра
}

script_dir=$(pwd)
mount_dir=/u01/qvs94
db_name=leftfish
case ${1} in
  "DROP")
    drop_db
    ;;
  "ENV")
    set_envs
    ;;
  "EX_ONLY")
    set_envs
    create_dirs
    auth
    create_configs
    ;;
  "FULL")
    echo "СОЗДАНИЕ БАЗЫ ДАННЫХ"
    set_envs
    create_dirs
    auth
    create_configs
    echo "ЗАПУСК ЭКЗЕМПЛЯРА ORACLE"
    cd $script_dir
    exit | sqlplus /nolog @mounter.sql
    echo "СОЗДАНИЕ НОВОЙ БАЗЫ ДАННЫХ"
    exit | sqlplus /nolog @db_creator.sql
    echo "СОЗДАНИЕ ДОПОЛНИТЕЛЬНЫХ ТАБЛИЧНЫХ ПРОСТРАНСТВ"
    exit | sqlplus /nolog @tb_creator.sql
    echo "ФОРМИРОВАНИЕ ПРЕДСТАВЛЕНИЯ СЛОВАРЯ ДАННЫХ"
    exit | sqlplus /nolog @view_creator.sql
    ;;
  *)
    echo "РЕЖИМ НЕ ЗАДАН"
    ;;
esac