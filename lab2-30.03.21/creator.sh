export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/11.2.0.3.0/db_1
export ORACLE_SID=kulbako_saraev.artemy_vladislav.p33112
PATH=$PATH:$ORACLE_HOME/bin
#TODO: export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:/usr/local/lib
export NLS_LANG=American_America.UTF8
export NLS_SORT=AMERICAN
export NLS_DATE_LANGUAGE=AMERICAN
export NLS_DATE_FORMAT="DD.MM.YYYY"

cd $ORACLE_HOME/dbs
orapwd file=orakulbako_saraev.artemy_vladislav.p33112 entries=10
mv init.ora kulbako_saraev.artemy_vladislav.p33112.ora
vi initkulbako_saraev.artemy_vladislav.p33112


echo "
db_name=leftfish
memory_target=440M
db_block_size=4096
" >> dfg.ora