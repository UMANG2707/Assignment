#!/bin/bash

# MySQL connection details
MYSQL_HOST="ip-of-server"
MYSQL_PORT=3307
MYSQL_USER="user"
MYSQL_PASS="pass"
MYSQL_DB="employees"

# Query to execute
QUERY="SELECT * FROM employees LIMIT 5;"

# Connect and Execute the query
mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASS" -D "$MYSQL_DB" -e "$QUERY"
