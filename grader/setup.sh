#!/bin/sh
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h db -e "CREATE DATABASE $MYSQL_DATABASE;" 2> /dev/null
RES=$(mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h db 2>&1 | grep -c "ERROR 1045")
if ! [ "$RES" = "0" ]; then
    echo "User not found, Creating user"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h db -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h db -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
fi
rake db:migrate
rake db:seed
rm /cafe_grader/judge/setup.sh
