#!/usr/bin/bash
echo "ASM environment variables have been set."

export ORACLE_SID=kulbako_saraev_p33112
export ORACLE_HOME=$ORACLE_MOUNT_POINT/app/11.2.0/grid
export PATH=$PATH:$ORACLE_HOME/bin
export INSTANCE_TYPE=ASM
export DB_UNIQUE_NAME=kulbako_saraev_p33112
export INIT_FILE=init$ORACLE_SID.ora
export ASM_POWER_LIMIT=7

DISKGROUPS=(bravecheetah excitingalligator bravecat angryhamster)
DISKS_AMOUNTS=(5 4 5 6)
ASM_DISKGROUPS=""
ASM_DISKSTRING=""
DISKS_AMOUNTS_STR=""
ASM_DISKS_DEST="/u01"

for diskgroup in ${DISKGROUPS[*]}
do
    ASM_DISKGROUPS=$ASM_DISKGROUPS,$diskgroup
    ASM_DISKSTRING=$ASM_DISKSTRING,"'$ASM_DISKS_DEST/$diskgroup/*'"
done

for amount in ${DISKS_AMOUNTS[*]}
do
    DISKS_AMOUNTS_STR=$DISKS_AMOUNTS_STR,$amount
done

ASM_DISKSTRING=$(echo $ASM_DISKSTRING | sed s/','/ /)
ASM_DISKGROUPS=$(echo $ASM_DISKGROUPS | sed s/','//)
DISKS_AMOUNTS_STR=$(echo $DISKS_AMOUNTS_STR | sed s/','//)

ASM_DISKGROUPS="$ASM_DISKGROUPS"
ASM_DISKSTRING="($ASM_DISKSTRING)"

export DISKS_AMOUNTS_STR
export ASM_DISKSTRING
export ASM_DISKGROUPS
export ASM_DISKS_DEST