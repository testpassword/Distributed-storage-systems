CREATE DISKGROUP sadwolf NORMAL REDUNDANCY
DISK
  '/u01/sadwolf/sadwolf0' NAME sadwolf0,
  '/u01/sadwolf/sadwolf1' NAME sadwolf1,
  '/u01/sadwolf/sadwolf2' NAME sadwolf2
ATTRIBUTE 'au_size'='16M';
