#!/bin/bash


### Install Python3 and dependencies
x=$(echo "$(python3 --version)" | cut -d " " -f 2 | cut -d "." -f1-2)
echo $x

### Create Files/Folders 
mkdir $PWD/dags
mkdir $PWD/.users

echo "AIRFLOW_HOME=$PWD/airflow
AIRFLOW__LOGGING__BASE_LOG_FOLDER=$PWD/logs
AIRFLOW__CORE__DAGS_FOLDER=$PWD/dags
AIRFLOW__CORE__LOAD_EXAMPLES=False
AIRFLOW__CORE__FERNET_KEY=$(openssl rand -base64 32)
AIRFLOW__API__AUTH_BACKEND=airflow.api.auth.backend.basic_auth" > .env

### Install Packages
pip install wheel apache-airflow==2.0.2 psycopg2-binary

### Export variables in future sessions
# echo "
# set -a
# source $PWD/.env
# set +a" >> $PWD/.venv/bin/activate

### Create Database
airflow db init

### Create Users (from script)
bash $PWD/.scripts/newUser.sh

### Create Heroku Files
pip freeze > $PWD/requirements.txt
echo "python-3.8.9" > $PWD/runtime.txt
echo "web: airflow webserver --port $PORT --daemon & airflow scheduler" > Procfile

### Set Heroku ENV
bash $PWD/.scripts/setConfig.sh