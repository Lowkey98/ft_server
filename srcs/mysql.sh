wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
apt-get install expect -y
expect -c "
set timeout 10
spawn dpkg -i mysql-apt-config_0.8.13-1_all.deb
expect \"Which MySQL product do you wish to configure? \"
send \"1\r\"
expect \"Which server version do you wish to receive? \"
send \"1\r\"
expect \"Which MySQL product do you wish to configure? \"
send \"4\r\"
expect eof
"
apt update
expect -c "
set timeout 10
spawn apt install mysql-server -y
expect \"Enter root password:\"
send \"root\r\"
expect \"Re-enter root password:\"
send \"root\r\"
expect eof
"
 /bin/bash
