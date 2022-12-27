FROM jupyterhub/jupyterhub:main

WORKDIR /jupyterhub_lab

COPY ./jupyterhub/jupyterhub_config.py /jupyterhub_lab/jupyterhub_config.py

RUN pip install jupyterhub-firstuseauthenticator

EXPOSE 80

ENV NOTEBOOKS_FROM=""

ENV HUB_PATH=""

ENTRYPOINT [ "jupyterhub", "-f", "/jupyterhub_lab/jupyterhub_config.py", "--ip", "0.0.0.0", "--port", "80" ]
