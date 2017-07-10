#  sudo docker build --no-cache -t spacy-api/alpha .
#  sudo docker run --net=host spacy-api/alpha:latest
#  curl http://localhost:5000/api --header 'content-type: application/json' --data '{"text": "angela merkel loves spending holiday in Italy."}'
FROM debian:sid
MAINTAINER Leonardo D'Ambrosi <leonardo.dambrosi@gmail.com>
ENV LANG en
ENV PORT 5000

RUN mkdir -p /usr/spacyapi
COPY . /usr/spacyapi/

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python3 build-essential gcc g++ python3-dev python3-setuptools python3-pip
RUN export PIP_CERT='python3 -m pip._vendor.requests.certs'

RUN pip3 install --upgrade pip setuptools
RUN pip3 install -r /usr/spacyapi/requirements.txt

RUN python3 -m spacy download en_core_web_sm-2.0.0-alpha --direct

ENTRYPOINT cd /usr/spacyapi && python3 server.py

EXPOSE ${PORT}
