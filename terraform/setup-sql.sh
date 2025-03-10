#!/bin/bash
# Update system packages
sudo apt update -y
sudo apt install -y mysql-server

# Start and enable MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql

# Change MySQL port to 3307
sudo sed -i 's/^#\s*port\s*=.*/port = 3307/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Secure MySQL and create an admin user
sudo mysql -e "CREATE USER '<user>'@'%' IDENTIFIED BY '<pass>';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '<user>'@'%' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"
