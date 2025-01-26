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
    ipykernel==6.29.4 \
    pandas==2.2.0 \
    pyarrow==15.0.0 \
    upsetplot==0.9.0 \
    numpy==1.26.3 \
    matplotlib==3.8.2 \ 
    scipy==1.12.0 \
    statsmodels==0.14.1 \
    seaborn==0.13.2 \
    urllib3==2.1.0 \ 
    retry==0.9.2 \ 
    PyYAML==6.0.1 \ 
    requests==2.31.0 \ 
    #python-dotenv==1.0.1 \
    #polars version update 2024-12-19
    polars==1.17.1 \
    cwltool==3.1.20250110105449 \
    cwltest==2.5.20241122133319 \
    cwl_runner==1.0 \
    argparse==1.4.0 \
    #duckdb==1.0.0 \
    unipressed==1.3.0 \
    papermill==2.6.0 \
    goatools==1.4.12 \
    pipx==1.6.0 \
    biopython==1.84

RUN pipx install benten==2021.1.5

# Jupyter Notebook settings
RUN python3 -m ipykernel install --user --name=python3 
RUN jupyter notebook --generate-config

# install zatsu-cwl-generator
ARG zatsu_ver=v1.1.1
RUN curl -fLSs https://github.com/tom-tan/zatsu-cwl-generator/releases/download/${zatsu_ver}/zatsu-cwl-generator-${zatsu_ver}-linux-x86_64.tar.xz | \
    tar Jxvf - && \
    mv zatsu-cwl-generator /usr/local/bin

#install fasta36
# ARG fasta36_ver="fasta-36.3.8i"
# RUN curl -fLSs -o ${fasta36_ver}.tar.gz https://fasta.bioch.virginia.edu/wrpearson/fasta/fasta36/${fasta36_ver}.tar.gz && \
#     tar zxvf ${fasta36_ver}.tar.gz && \
#     cd ${fasta36_ver}/src && \
#     make -f ../make/Makefile.linux64_sse2 all && \
#     mv ../bin/* /usr/local/bin && \
#     cd /usr/local/bin && \
#     ln -s fasta36 fasta && \
#     cd / && \
#     rm -rf ${fasta36_ver} ${fasta36_ver}.tar.gz

#install foldseek (Linux arm64) 2024-08-04 download from mmseqs.com
# RUN curl -fLSs https://mmseqs.com/foldseek/foldseek-linux-arm64.tar.gz | \
#     tar zxvf - -C /usr/local && \
#     ln -s /usr/local/foldseek/bin/* /usr/local/bin/

