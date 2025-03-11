#!/bin/bash
# Update system packages
sudo apt update -y
sudo apt install -y mysql-server

# Start and enable MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql

# Change MySQL port to 3307
sudo sed -i 's/^#\s*port\s*=.*/port = 3307/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Setup Employee database
wget https://github.com/datacharmer/test_db/archive/refs/heads/master.zip -O employees-db.zip
sudo apt install -y unzip
unzip employees-db.zip
cd test_db-master
mysql -h <HOST_NAME> -P 3307 -u <user> -p <password> < employees.sql

# Secure MySQL and create an admin user
sudo mysql -e "CREATE USER ''@'%' IDENTIFIED BY '';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO ''@'%' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"
