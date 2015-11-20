mysql_install_db --user=mysql --basedir='/usr/' --ldata='/var/lib/mysql/'

mysqld_safe  --user=root --basedir='/usr' --datadir='/var/lib/mysql/'  &

sleep 5s
tail -n 30 /var/log/mariadb/mariadb.log

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"
expect \"Change the root password?\"
send \"Y\r\"
expect \"New password:\"
send \"mariadb\r\"
expect \"Re-enter new password:\"
send \"mariadb\r\"
expect \"Remove anonymous users?\"
send \"n\r\"
expect \"Disallow root login remotely?\"
send \"n\r\"
expect \"Remove test database and access to it?\"
send \"n\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"
