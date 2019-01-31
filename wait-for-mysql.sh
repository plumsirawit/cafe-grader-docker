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
rails s -p 3000 -b '0.0.0.0'
