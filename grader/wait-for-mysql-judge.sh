#!/bin/bash

echo ""
echo "Waiting for mysql . . ."
until mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h db > /dev/null 2>&1
do
  echo "Waiting for mysql . . ."
  sleep 1
done

echo "MySQL is Ready"

# [7/2/2020] Judge Daemon
while [ -f "/cafe_grader/setup.sh" ];
do
  echo "Waiting for setup . . ."
  sleep 1
done

echo "Environment is ready"

/cafe_grader/judge/scripts/grader grading queue --err-log

# For non-SSL purpose
#rails s -p 3000 -b '0.0.0.0'

# with-ssl-cert (Sirawit, 8/4/2019)
# thin -p 3000 --ssl --ssl-key-file /cafe_grader/server.key --ssl-cert-file /cafe_grader/server.crt start 2>&1
