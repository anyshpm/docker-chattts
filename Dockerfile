FROM python:3.9-bullseye

MAINTAINER Anyshpm Chen<anyshpm@anyshpm.com>

WORKDIR /app

COPY requirements.txt simple.py /app

RUN set -x && \
    apt update && \
    apt install -y ffmpeg

RUN set -x && \
    curl -o Miniconda3-py39_24.4.0-0-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_24.4.0-0-Linux-x86_64.sh && \
    bash Miniconda3-py39_24.4.0-0-Linux-x86_64.sh -b -u -p ./Miniconda3-py39_24.4.0-0-Linux-x86_64 && \
    Miniconda3-py39_24.4.0-0-Linux-x86_64/bin/conda install -y -c conda-forge pynini=2.1.5 && \
    pip install -r requirements.txt && \
    curl -Lo main.zip https://github.com/2noise/ChatTTS/archive/refs/heads/main.zip && \
    unzip main.zip && \
    cd ChatTTS-main && \
    pip install -r requirements.txt && \
    mv ../simple.py . && \
    python simple.py
