CREATE DISKGROUP bravecat NORMAL REDUNDANCY
 FAILGROUP faill_group1 DISK
  '/u01/bravecat/bravecat0' NAME bravecat0,
  '/u01/bravecat/bravecat1' NAME bravecat1,
  '/u01/bravecat/bravecat2' NAME bravecat2
  FAILGROUP faill_group2 DISK
  '/u01/bravecat/bravecat3' NAME bravecat3,
  '/u01/bravecat/bravecat4' NAME bravecat4,
  '/u01/bravecat/bravecat5' NAME bravecat5;