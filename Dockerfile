# Original source: Miniconda install copy-pasted from Miniconda's own Dockerfile reachable
# at: https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/debian/Dockerfile

FROM debian:buster-slim
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Toronto
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# Setup the startup script
COPY conda-start.sh /usr/local/bin/conda-start.sh
RUN chmod +x /usr/local/bin/conda-start.sh
CMD ["conda-start.sh"]

RUN apt-get update --fix-missing && \
    apt-get install -y \
       wget \
       bzip2 \
       ca-certificates \
       libglib2.0-0 \
       libxext6 \
       libsm6 \
       libxrender1 \
       git \
       mercurial \
       subversion && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

# Install Jupyter conda packages
RUN /opt/conda/bin/conda install jupyter -y --quiet && \
    jupyter notebook --generate-config && \
    sed -i "s/^\s*# c.NotebookApp.token\s*=.*$/c.NotebookApp.token=''/" /root/.jupyter/jupyter_notebook_config.py && \
    sed -i "s/^\s*# c.NotebookApp.allow_password_change\s*=.*$/c.NotebookApp.allow_password_change=True/" /root/.jupyter/jupyter_notebook_config.py

# Any ports required based on packages installed
EXPOSE 8888/tcp
EXPOSE 8081/tcp

# Persistant Storage for Notebooks
VOLUME /opt/notebooks
