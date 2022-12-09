FROM python:3.11
FROM node:12.18.1-alpine

RUN mkdir /etc/jupyterhub/

WORKDIR /etc/jupyterhub/

COPY ./jupyterhub/jupyterhub_config.py .

RUN npm install -g configurable-http-proxy

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

EXPOSE 80

# LABEL NOTEBOOKS_FROM=""

# LABEL HUB_PATH=""

ENTRYPOINT [ "jupyterhub", "-f /etc/jupyterhub/jupyterhub_config.py" ]
