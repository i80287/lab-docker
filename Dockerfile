FROM jupyterhub/jupyterhub:main

ENV NOTEBOOKS_FROM=""

ENV HUB_PATH=""

WORKDIR /jupyterhub_lab

COPY ./jupyterhub/jupyterhub_config.py /jupyterhub_lab/jupyterhub_config.py

EXPOSE 80

ENTRYPOINT [ "jupyterhub", "-f", "/jupyterhub_lab/jupyterhub_config.py", "--ip", "0.0.0.0", "--port", "80" ]
