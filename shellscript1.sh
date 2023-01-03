#!/bin/bash



dir="/home/wilfried/bsm/test"


files=$(find $dir -type f)

for file in $files

do

if [ $(stat -c %Y "$file") -ge $(( $(date +%s) - 10 )) ]

then

psql -h "localhost" -U "postgres" -d "fardb" <<EOF 

  INSERT INTO fini  (date, filename,deletion_date) VALUES (now(),'$file',now())
EOF
fi
done

