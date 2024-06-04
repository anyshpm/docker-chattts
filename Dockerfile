FROM python:3.9-bullseye

MAINTAINER Anyshpm Chen<anyshpm@anyshpm.com>

WORKDIR /app

RUN set -xe && \
    curl -Lo main.zip https://github.com/2noise/ChatTTS/archive/refs/heads/main.zip && \
    unzip main.zip && \
    cd ChatTTS-main && \
    pip install -r requirements.txt && \
    curl -o Miniconda3-py39_24.4.0-0-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_24.4.0-0-Linux-x86_64.sh && \
    bash Miniconda3-py39_24.4.0-0-Linux-x86_64.sh -b -u -p ./Miniconda3-py39_24.4.0-0-Linux-x86_64 && \
    python webui.py

WORKDIR /app

COPY requirements.txt x.py /app

RUN set -xe && \
    pip install -r requirements.txt && \
    python x.py
