#!/usr/bin/bash
echo "Create diskgroup creator script..."

DISKGROUPS=($(echo $ASM_DISKGROUPS | sed "s/,/ /g"))
DISKS_AMOUNTS=($(echo $DISKS_AMOUNTS_STR | sed "s/,/ /g"))
echo DISKGROUPS=${DISKGROUPS[@]}
echo DISKS_AMOUNTS=${DISKS_AMOUNTS[@]}

FILENAME=create_diskgroups.sql
set_diskgroup_creator()
{
    echo "Write $FILENAME: $1"
    echo "$1" >> $FILENAME
}

echo "Start $FILENAME writing"
rm $FILENAME
for diskgroup_index in ${!DISKGROUPS[@]}; do
    DISKGROUP=${DISKGROUPS[$diskgroup_index]}
    set_diskgroup_creator "CREATE DISKGROUP $DISKGROUP NORMAL REDUNDANCY DISK"
    for (( i=1; i < ${DISKS_AMOUNTS[$diskgroup_index]}; i++ )); do
        set_diskgroup_creator "   '$ASM_DISKS_DEST/$DISKGROUP/$DISKGROUP$i' NAME $DISKGROUP$i,"
    done
    set_diskgroup_creator "   '$ASM_DISKS_DEST/$DISKGROUP/${DISKGROUP}0' NAME ${DISKGROUP}0;"
    set_diskgroup_creator
done

