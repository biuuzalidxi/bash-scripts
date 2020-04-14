#!/bin/bash
DBS=""
DBS="${DBS} db1"
DBS="${DBS} db2"
DBS="${DBS} db3"

current_date_time="`date +%Y%m%d%H%M%S`";

for NAME in ${DBS}; do
    echo ${NAME};
done


echo ${DBS}
