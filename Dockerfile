FROM python:3.10-slim-buster
USER root
RUN mkdir /app
COPY . /app/
WORKDIR /app/
RUN pip3 install -r requirements.txt
ENV AWS_DEFAULT_REGION = "us-east-1"
ENV BUCKET_NAME="mitesh-mlops-nwtworksecurity"
ENV PREDICTION_BUCKET_NAME="mitesh-mlops-network-datasource"
ENV AIRFLOW_HOME="/app/airflow"
ENV AIRFLOW_CORE_DAGBAG_IMPORT_TIMEOUT=1000
ENV AIRFLOW_CORE_ENABLE_XCOM_PICKLING=True
#RUN airflow db init
RUN airflow db migrate
RUN airflow users create -e upadhyaymitesh91@gmail.com -f mitesh -l upadhyay -p admin -r Admin -u admin
RUN chmod 777 start.sh
RUN apt update -y
ENTRYPOINT [ "/bin/sh" ]
CMD ["start.sh"]