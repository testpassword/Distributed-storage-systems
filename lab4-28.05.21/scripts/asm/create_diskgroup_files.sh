#!/usr/bin/bash

DISKGROUP=$1
AMOUNT=$2

CURRENT_DIR=$ASM_DISKS_DEST/$DISKGROUP
echo "mkdir -p $CURRENT_DIR"
echo "chown oracle:dba $CURRENT_DIR"
mkdir -p $CURRENT_DIR
chown oracle:dba $CURRENT_DIR

for (( i=0; i < AMOUNT; i++ )); do
    CURRENT_FILE=$CURRENT_DIR/$DISKGROUP$i
    echo "mkfile -n 500m $CURRENT_FILE"
    /usr/sbin/mkfile -n 500m $CURRENT_FILE
done
