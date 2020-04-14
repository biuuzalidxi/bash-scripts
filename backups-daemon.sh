#!/bin/bash
docker exec -ti postgresdb mkdir -p home/.backups;
workdir="home/.backups";

DBS=""
DBS="${DBS} vitay_empty_01";

current_date_time="`date +%Y%m%d%H%M%S`";
PGPASSWORD=""
for NAME in ${DBS}; do
    docker exec -ti postgresdb mkdir -p $workdir/$NAME;
   # docker exec -ti postgresdb pg_dump -U UserKore2019  -F t $NAME  -f $workdir/$NAME/$current_date_time.tar
    docker exec -ti postgresdb pg_dump -U   -F t $NAME  -f $workdir/$NAME/$current_date_time.tar
   # echo "docker exec -ti postgresdb pg_dump  $NAME  > $workdir/$NAME/$current_date_time.sql"
    backups_count="` docker exec -ti postgresdb find  $workdir/$NAME/ -type f | wc -l`"
    echo " docker exec -ti postgresdb find  $workdir/$NAME/ -type f | wc -l"
    #first_backup="` docker exec -ti postgresdb ls -A1 $workdir/$NAME | sort -n | head -1`"
    first_backup="`docker exec -ti postgresdb find  home/.backups/vitay_empty_01 -name "*.tar" | sort | head -1`"
    AUX=$(echo $first_backup | sed -e 's/\r//g')

    if [ $backups_count -ge 5 ] ; then
        docker exec -ti postgresdb rm $AUX
        $first_backup >> $workdir/$NAME/$current_date_time.txt
    fi
done    