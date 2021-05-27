echo "Environment variables have been set."

export ORACLE_MOUNT_POINT=/u01
export ORACLE_BASE=$ORACLE_MOUNT_POINT/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=kulbako_saraev_p33112
export DB_NAME=leftfish
export ORACLE_INIT_FILE_DEST=$ORACLE_HOME/dbs
export ORADATA_DEST=$ORACLE_MOUNT_POINT/qvs94
export ORADATA=$ORADATA_DEST/$DB_NAME
export INIT_FILE=init$ORACLE_SID.ora
export PATH=$PATH:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export NLS_LANG=American_America.UTF8
export NLS_SORT=AMERICAN
export NLS_DATE_LANGUAGE=AMERICAN
export NLS_DATE_FORMAT="DD.MM.YYYY"