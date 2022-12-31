FROM jupyterhub/jupyterhub:latest

COPY ./requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt

WORKDIR /jupyterhub_lab

RUN useradd --system \
    --create-home \
    --home-dir /home/admin \
    --shell /bin/bash \
    --gid root \
    --groups sudo \
    --uid 4242 \
    admin && \
    chown -R admin /jupyterhub_lab

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN echo 'admin:admin' | chpasswd

USER admin

COPY ./jupyterhub/jupyterhub_config.py /jupyterhub_lab/jupyterhub_config.py

EXPOSE 80

# Default value is "./*.ipynb"
# ENV NOTEBOOKS_FROM="./*.ipynb"

# Default value is "/home/admin"
# ENV HUB_PATH="/home/admin"

# COPY ${NOTEBOOKS_FROM} ${HUB_PATH}

ENTRYPOINT [ "jupyterhub", "-f", "/jupyterhub_lab/jupyterhub_config.py", "--ip", "0.0.0.0", "--port", "80" ]
