service mysql start
mysql -uroot -proot -e "CREATE USER 'pma'@'localhost' IDENTIFIED BY 'pmapass'"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'pma'@'localhost'"
#wp
mysql -uroot -proot -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci"
mysql -uroot -proot -e "GRANT ALL ON wordpress.* TO 'wpuser'@'localhost' IDENTIFIED BY 'dbpassword'"
mysql -uroot -proot -e "FLUSH PRIVILEGES"

