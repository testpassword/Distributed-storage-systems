#!/usr/bin/bash
echo "Creating default diskgroups./."
DISKGROUPS=($(echo $ASM_DISKGROUPS | sed "s/,/ /g"))
DISKS_AMOUNTS=($(echo $DISKS_AMOUNTS_STR | sed "s/,/ /g"))
echo DISKGROUPS=${DISKGROUPS[@]}
echo DISKS_AMOUNTS=${DISKS_AMOUNTS[@]}

for index in ${!DISKGROUPS[@]}; do
    . asm/create_diskgroup_files.sh ${DISKGROUPS[$index]} ${DISKS_AMOUNTS[$index]}
done
