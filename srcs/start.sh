service mysql start
service nginx start
service php7.3-fpm start
mysql --password=pmapass --user=pma wordpress < /localhost.sql
/bin/bash
