CREATE DISKGROUP poorhorse NORMAL REDUNDANCY
DISK
  '/u01/poorhorse/poorhorse0' NAME poorhorse0,
  '/u01/poorhorse/poorhorse1' NAME poorhorse1,
  '/u01/poorhorse/poorhorse2' NAME poorhorse2,
  '/u01/poorhorse/poorhorse3' NAME poorhorse3,
  '/u01/poorhorse/poorhorse4' NAME poorhorse4
ATTRIBUTE 'au_size'='16M';
