#!/usr/bin/sh
echo "ASM init file has been set."

set_init()
{
    ROW="$1=$2"
    echo "Write row to $INIT_FILE: $ROW"
    echo "$ROW" >> $INIT_FILE
}

echo "Start $INIT_FILE writing"
echo "rm $INIT_FILE"
rm $INIT_FILE
set_init _ASM_ALLOW_ONLY_RAW_DISKS false
set_init INSTANCE_TYPE $INSTANCE_TYPE
set_init DB_UNIQUE_NAME $DB_UNIQUE_NAME
set_init ASM_POWER_LIMIT $ASM_POWER_LIMIT
set_init ASM_DISKSTRING $ASM_DISKSTRING
set_init ASM_DISKGROUPS $ASM_DISKGROUPS

echo "mv $INIT_FILE $ORACLE_HOME/dbs"
mv $INIT_FILE $ORACLE_HOME/dbs