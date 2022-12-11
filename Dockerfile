FROM ubuntu:22.04
FROM python:3.11-alpine
FROM node:12.18.1-alpine

# Keeps Python from generating 
# .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

#ENV NOTEBOOKS_FROM=""

#ENV HUB_PATH=""

COPY requirements.txt .

RUN python -m pip install --upgrade pip

RUN python -m pip install -r requirements.txt

RUN npm install -g configurable-http-proxy

RUN mkdir /etc/jupyterhub/

WORKDIR /etc/jupyterhub/

COPY ./jupyterhub/jupyterhub_config.py .

EXPOSE 80

ENTRYPOINT [ "jupyterhub", "-f /etc/jupyterhub/jupyterhub_config.py" ]
