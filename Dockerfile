FROM python:3.10-slim-buster
USER root

# Install system deps
#RUN apt-get update -y && apt-get install -y build-essential libpq-dev

RUN mkdir /app
COPY . /app/
WORKDIR /app/

# Install Python deps (including pinned Airflow)
RUN pip3 install -r requirements.txt

ENV AWS_DEFAULT_REGION="us-east-1"
ENV BUCKET_NAME="mitesh-mlops-nwtworksecurity"
ENV PREDICTION_BUCKET_NAME="mitesh-mlops-network-datasource"
ENV AIRFLOW_HOME="/app/airflow"
ENV AIRFLOW_CORE_DAGBAG_IMPORT_TIMEOUT=1000
ENV AIRFLOW_CORE_ENABLE_XCOM_PICKLING=True

RUN mkdir -p $AIRFLOW_HOME && chmod -R 777 $AIRFLOW_HOME

# Initialize DB and create user
RUN airflow db migrate
RUN airflow users create \
    --username admin \
    --firstname mitesh \
    --lastname upadhyay \
    --role Admin \
    --email upadhyaymitesh91@gmail.com \
    --password admin

RUN chmod 777 start.sh

ENTRYPOINT ["/bin/sh"]
CMD ["start.sh"]
