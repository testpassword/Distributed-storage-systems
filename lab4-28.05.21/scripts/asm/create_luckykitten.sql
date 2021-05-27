CREATE DISKGROUP luckykitten NORMAL REDUNDANCY
DISK
  '/u01/luckykitten/luckykitten0' NAME luckykitten0,
  '/u01/luckykitten/luckykitten1' NAME luckykitten1,
  '/u01/luckykitten/luckykitten2' NAME luckykitten2,
  '/u01/luckykitten/luckykitten3' NAME luckykitten3,
  '/u01/luckykitten/luckykitten4' NAME luckykitten4
ATTRIBUTE 'au_size'='2M';
