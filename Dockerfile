FROM python:3.9-bullseye

MAINTAINER Anyshpm Chen<anyshpm@anyshpm.com>

RUN set -x && \
    curl -Lo main.zip https://github.com/2noise/ChatTTS/archive/refs/heads/main.zip && \
    unzip main.zip && \
    cd ChatTTS-main && \
    pip install -r requirements.txt && \
    python webui.py
