set lin 500
column name format a30
column path format a60
select name,path,mount_status from v$asm_disk order by path;