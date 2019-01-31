#!/bin/sh
SECRET_A=`rake secret`
SECRET_B=`rake secret`
SECRET_C=`rake secret`
echo "development:" > config/secrets.yml
echo "  secret_key_base: '$SECRET_A'" >> config/secrets.yml
echo "test:" >> config/secrets.yml
echo "  secret_key_base: '$SECRET_B'" >> config/secrets.yml
echo "production:" >> config/secrets.yml
echo "  secret_key_base: '$SECRET_C'" >> config/secrets.yml

echo "development:" > config/database.yml
echo "  adapter: mysql2" >> config/database.yml
echo "  encoding: utf8" >> config/database.yml
echo "  reconnect: false" >> config/database.yml
echo "  database: $MYSQL_DATABASE" >> config/database.yml
echo "  pool: 5" >> config/database.yml
echo "  username: $MYSQL_USER" >> config/database.yml
echo "  password: $MYSQL_PASSWORD" >> config/database.yml
echo "  host: db" >> config/database.yml
echo "  socket: /var/run/mysqld/mysqld.sock" >> config/database.yml
echo "" >> config/database.yml
echo "production:" >> config/database.yml
echo "  adapter: mysql2" >> config/database.yml
echo "  encoding: utf8" >> config/database.yml
echo "  reconnect: false" >> config/database.yml
echo "  database: $MYSQL_DATABASE" >> config/database.yml
echo "  pool: 5" >> config/database.yml
echo "  username: $MYSQL_USER" >> config/database.yml
echo "  password: $MYSQL_PASSWORD" >> config/database.yml
echo "  host: db" >> config/database.yml
echo "  socket: /var/run/mysqld/mysqld.sock" >> config/database.yml

mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h db -e "CREATE DATABASE $MYSQL_DATABASE;" 2> /dev/null
RES=$(mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h db 2>&1 | grep -c "ERROR 1045")
if ! [ "$RES" = "0" ]; then
    echo "User not found, Creating user"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h db -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h db -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
fi
rake db:migrate
rake db:seed
rake assets:precompile
rm /cafe_grader/setup.sh
