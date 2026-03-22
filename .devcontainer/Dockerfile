# Use the official DevContainers Python image (Python 3.13 on Debian Bullseye)
# Note: Old path 'mcr.microsoft.com/vscode/devcontainers/' is deprecated
# New path: 'mcr.microsoft.com/devcontainers/'
FROM mcr.microsoft.com/devcontainers/python:3.13-bullseye

# Fix for expired Yarn GPG key in the base image
# Remove the problematic Yarn repository before apt-get update
RUN rm -f /etc/apt/sources.list.d/yarn.list || true

# linux settings
# `-y` option is used to automatically answer yes to all prompts
RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends \
    byobu \
    aria2 \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    build-essential \
    libgmp-dev \
    libmagick++-dev \
    libglpk-dev

# install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh


# update pip & install packages (including cwltool)
# update: 2026-03-20
RUN pip install \
    --upgrade pip \
    retry==0.9.2 \
    jupyter==1.1.1 \
    ipykernel==7.2.0 \
    pandas==3.0.1 \
    pyarrow==23.0.1 \
    numpy==2.4.3 \
    matplotlib==3.10.8 \
    scipy==1.17.1 \
    statsmodels==0.14.6 \
    seaborn==0.13.2 \
    urllib3==2.6.3 \
    PyYAML==6.0.3 \
    requests==2.32.5 \
    polars==1.39.2 \
    cwltool==3.1.20260315121657 \
    cwltest==2.6.20251216093331 \
    papermill==2.7.0 \
    unipressed==1.4.0 \
    pipx==1.10.0

RUN pip install cwl2puml==0.35.0
RUN pipx install benten==2021.1.5

# Jupyter Notebook settings
RUN python3 -m ipykernel install --user --name=python3 
RUN jupyter notebook --generate-config

# install zatsu-cwl-generator
ARG zatsu_ver=v1.1.1
RUN curl -fLSs https://github.com/tom-tan/zatsu-cwl-generator/releases/download/${zatsu_ver}/zatsu-cwl-generator-${zatsu_ver}-linux-x86_64.tar.xz | \
    tar Jxvf - && \
    mv zatsu-cwl-generator /usr/local/bin

