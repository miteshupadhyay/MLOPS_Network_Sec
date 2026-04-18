#!bin/sh
#nohup airflow schedular &
#airflow webserver

#!/bin/sh
set -e

# Initialize Airflow DB (safe to run every time)
airflow db init

# Start scheduler in background
nohup airflow scheduler &

# Start webserver in foreground
airflow webserver --port 8080
