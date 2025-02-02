# Get arguments for python version (in this case, python 3.10 image is used)
ARG VARIANT="3.11-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

# linux settings
# `-y` option is used to automatically answer yes to all prompts
RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends \
    byobu \
    emboss \
    aria2 \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    build-essential \
    libgmp-dev \
    libmagick++-dev \
    libglpk-dev

# RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
#     && echo "$SNIPPET" >> "/root/.bashrc"

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
# ARG NODE_VERSION="none"
# RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi


# update pip & install packages (including CWL tool)
RUN pip install \
    --upgrade pip \ 
    jupyter==1.0.0 \ 
    ipykernel==6.29.5 \
    pandas==2.2.3 \
    pyarrow==15.0.0 \
    upsetplot==0.9.0 \
    numpy==1.26.3 \
    matplotlib==3.8.2 \ 
    scipy==1.12.0 \
    statsmodels==0.14.1 \
    argparse==1.4.0 \
    seaborn==0.13.2 \
    urllib3==2.1.0 \ 
    retry==0.9.2 \ 
    PyYAML==6.0.1 \ 
    requests==2.31.0 \ 
    cwl_runner==1.0 \
    #polars version update 2024-12-19
    polars==1.17.1 \
    ibis-framework==9.5.0 \
    cwltool==3.1.20250110105449 \
    cwltest==2.5.20241122133319 \
    unipressed==1.4.0 \
    papermill==2.6.0 \
    pipx==1.7.1

RUN pipx install benten==2021.1.5

# Jupyter Notebook settings
RUN python3 -m ipykernel install --user --name=python3 
RUN jupyter notebook --generate-config

# install zatsu-cwl-generator
ARG zatsu_ver=v1.1.1
RUN curl -fLSs https://github.com/tom-tan/zatsu-cwl-generator/releases/download/${zatsu_ver}/zatsu-cwl-generator-${zatsu_ver}-linux-x86_64.tar.xz | \
    tar Jxvf - && \
    mv zatsu-cwl-generator /usr/local/bin

