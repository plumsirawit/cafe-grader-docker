#!/bin/bash

echo ""
echo "Waiting for mysql . . ."
until mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h db > /dev/null 2>&1
do
  echo "Waiting for mysql . . ."
  sleep 1
done

echo "MySQL is Ready"
if [ -f "/cafe_grader/setup.sh" ]; then
  /bin/bash /cafe_grader/setup.sh ;
fi
rm tmp/pids/server.pid
# For non-SSL purpose
# rails s -p 3000 -b '0.0.0.0'

# with-ssl-cert (Sirawit, 8/4/2019)
thin -a 0.0.0.0 -p 3000 --ssl --ssl-verify --ssl-key-file /cafe_grader/server.key --ssl-cert-file /cafe_grader/server.crt start
