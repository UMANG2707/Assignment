#!/bin/bash

# Fetch MySQL credentials from AWS Secrets Manager
SECRET_NAME="test"  # Change to your actual secret name
AWS_REGION="us-east-1"  # Change to your AWS region
# Retrieve the secret
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$SECRET_NAME" --query SecretString --output text)

MYSQL_HOST=$(echo "$SECRET_JSON" | jq -r '.host')
MYSQL_PORT=$(echo "$SECRET_JSON" | jq -r '.port')
MYSQL_USER=$(echo "$SECRET_JSON" | jq -r '.username')
MYSQL_PASS=$(echo "$SECRET_JSON" | jq -r '.password')
MYSQL_DB=$(echo "$SECRET_JSON" | jq -r '.dbname')

# Query to execute
QUERY="SELECT * FROM employees LIMIT 10;"

# Connect and Execute the query
mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASS" -D "$MYSQL_DB" -e "$QUERY"
