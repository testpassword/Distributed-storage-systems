CREATE DISKGROUP interestingsquirrel NORMAL REDUNDANCY
DISK
  '/u01/interestingsquirrel/interestingsquirrel0' NAME interestingsquirrel0,
  '/u01/interestingsquirrel/interestingsquirrel1' NAME interestingsquirrel1,
  '/u01/interestingsquirrel/interestingsquirrel2' NAME interestingsquirrel2,
  '/u01/interestingsquirrel/interestingsquirrel3' NAME interestingsquirrel3
ATTRIBUTE 'au_size'='4M';
