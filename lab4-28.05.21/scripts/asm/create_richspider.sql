CREATE DISKGROUP richspider NORMAL REDUNDANCY
DISK
  '/u01/richspider/richspider0' NAME richspider0,
  '/u01/richspider/richspider1' NAME richspider1,
  '/u01/richspider/richspider2' NAME richspider2,
  '/u01/richspider/richspider3' NAME richspider3,
  '/u01/richspider/richspider4' NAME richspider4,
  '/u01/richspider/richspider5' NAME richspider5
ATTRIBUTE 'au_size'='4M';
