FROM debian:buster
#Update packages
ENV DEBIAN_FRONTEND noninteractive
RUN echo "mysql-apt-config mysql-apt-config/select-server select mysql-5.7" | debconf-set-selections
RUN apt-get update
RUN apt-get -y upgrade
#Install nginx
RUN apt-get -y install nginx
#Install MYSQL
RUN apt-get install -y wget
RUN apt-get install -y lsb-release
RUN apt-get install -y gnupg
RUN apt-get install -y vim
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
RUN dpkg -i mysql-apt-config_0.8.13-1_all.deb
RUN apt update
RUN apt install mysql-server -y
#Install PHP
RUN apt-get update
RUN apt-get -y upgrade
RUN apt install php-fpm php-mysql -y
#Install pma
RUN apt-get update
RUN apt install -y php-json php-mbstring
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
RUN mkdir /var/www/html/phpmyadmin
RUN tar xzf phpMyAdmin-5.0.4-english.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
RUN cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php
RUN chmod 660 /var/www/html/phpmyadmin/config.inc.php
RUN chown -R www-data:www-data /var/www/html/phpmyadmin
COPY srcs/setupdb.sh .
RUN sh setupdb.sh

#Install wp
RUN apt-get install curl -y
RUN apt update
RUN apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip -y
RUN curl -LO https://wordpress.org/latest.tar.gz
RUN tar xzvf latest.tar.gz
RUN mv wordpress /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress
COPY srcs/wp-config.php /var/www/html/wordpress/wp-config.php
COPY srcs/default etc/nginx/sites-available/
COPY srcs/ssl.crt /etc/ssl/
COPY srcs/ssl.key /etc/ssl/
COPY srcs/config.inc.php /var/www/html/phpmyadmin/config.inc.php
COPY srcs/localhost.sql ./
COPY srcs/start.sh .
CMD bash start.sh
