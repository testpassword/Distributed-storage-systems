#!/usr/bin/bash
rm -rf bravecheetah excitingalligator bravecat angryhamster sadwolf richspider interestingsquirrel poorhorse luckykitten
# Phase 1

. setenv.sh
. asm/asmsetenv.sh
. asm/create_asminit.sh
. asm/create_default_diskgroups.sh
. asm/create_diskgroups_creator.sh

sqlplus / as sysasm << EOF
CREATE SPFILE FROM PFILE;
STARTUP;
@create_diskgroups.sql;
@asm/display_disks.sql;
EXIT;
EOF

# Phase 2

sqlplus / as sysasm << EOF
DROP DISKGROUP bravecat;
EXIT;
EOF

. asm/create_diskgroup_files.sh bravecat 6;
sqlplus / as sysasm << EOF
 @asm/create_bravecat.sql;
 @asm/display_disks.sql;
 EXIT;
EOF


. asm/create_diskgroup_files.sh richspider 6
sqlplus / as sysasm << EOF
 shutdown;
 startup nomount;
 alter system set asm_diskstring='/u01/bravecheetah/*','/u01/excitingalligator/*','/u01/bravecat/*','/u01/angryhamster/*','/u01/richspider/*';
 shutdown;
 startup mount;
 @asm/create_richspider.sql;
 @asm/display_disks.sql;
 EXIT;
EOF

. asm/create_diskgroup_files.sh interestingsquirrel 4;
sqlplus / as sysasm << EOF
 shutdown;
 startup nomount;
 alter system set asm_diskstring='/u01/bravecheetah/*','/u01/excitingalligator/*','/u01/bravecat/*','/u01/angryhamster/*','/u01/richspider/*', '/u01/interestingsquirrel/*';
 shutdown;
 startup mount;
 @asm/create_interestingsquirrel.sql;
 @asm/display_disks.sql;
 EXIT;
EOF

. asm/create_diskgroup_files.sh poorhorse 5;
sqlplus / as sysasm << EOF
 shutdown;
 startup nomount;
 alter system set asm_diskstring='/u01/bravecheetah/*','/u01/excitingalligator/*','/u01/bravecat/*','/u01/angryhamster/*','/u01/richspider/*', '/u01/interestingsquirrel/*', '/u01/poorhorse/*';
 shutdown;
 startup mount;
 @asm/create_poorhorse.sql;
 @asm/display_disks.sql;
 EXIT;
EOF

sqlplus / as sysasm << EOF
DROP DISKGROUP richspider;
EXIT;
EOF

. asm/create_diskgroup_files.sh sadwolf 3;
sqlplus / as sysasm << EOF
 shutdown;
 startup nomount;
 alter system set asm_diskstring='/u01/bravecheetah/*','/u01/excitingalligator/*','/u01/bravecat/*','/u01/angryhamster/*','/u01/richspider/*', '/u01/interestingsquirrel/*', '/u01/poorhorse/*','/u01/sadwolf/*';
 shutdown;
 startup mount;
 @asm/create_sadwolf.sql;
 @asm/display_disks.sql;
 EXIT;
EOF

/usr/sbin/mkfile -n 500m /u01/bravecat/bravecat6
sqlplus / as sysasm << EOF
ALTER DISKGROUP bravecat ADD DISK '/u01/bravecat/bravecat6' NAME bravecat6;
@asm/display_disks.sql;
EXIT;
EOF

/usr/sbin/mkfile -n 500m /u01/excitingalligator/excitingalligator4
sqlplus / as sysasm << EOF
ALTER DISKGROUP excitingalligator ADD DISK '/u01/excitingalligator/excitingalligator4' NAME excitingalligator4;
@asm/display_disks.sql;
EXIT;
EOF

. asm/create_diskgroup_files.sh luckykitten 5;
sqlplus / as sysasm << EOF
 shutdown;
 startup nomount;
 alter system set asm_diskstring='/u01/bravecheetah/*','/u01/excitingalligator/*','/u01/bravecat/*','/u01/angryhamster/*','/u01/richspider/*', '/u01/interestingsquirrel/*', '/u01/poorhorse/*','/u01/sadwolf/*','/u01/luckykitten/*';
 shutdown;
 startup mount;
 @asm/create_luckykitten.sql;
 @asm/display_disks.sql;
 EXIT;
EOF
