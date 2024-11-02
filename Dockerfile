FROM python:3.9-bullseye

MAINTAINER Anyshpm Chen<anyshpm@anyshpm.com>

ARG CHATTTS_VERSION

ENV CHATTTS_VERSION=${CHATTTS_VERSION:-0.2.0}

WORKDIR /app

COPY requirements.txt simple.py /app

RUN set -x && \
    apt update && \
    apt install -y ffmpeg && \
    apt clean

RUN set -x && \
    curl -o Miniconda3-py39_24.4.0-0-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_24.4.0-0-Linux-x86_64.sh && \
    bash Miniconda3-py39_24.4.0-0-Linux-x86_64.sh -b -u -p ./Miniconda3-py39_24.4.0-0-Linux-x86_64 && \
    rm -f Miniconda3-py39_24.4.0-0-Linux-x86_64.sh && \
    Miniconda3-py39_24.4.0-0-Linux-x86_64/bin/conda install -y -c conda-forge pynini=2.1.5 && \
    pip install -r requirements.txt && \
    curl -Lo ChatTTS-${CHATTTS_VERSION}.zip https://github.com/2noise/ChatTTS/archive/refs/tags/v${CHATTTS_VERSION}.zip && \
    unzip ChatTTS-${CHATTTS_VERSION}.zip && \
    cd ChatTTS-${CHATTTS_VERSION} && \
    pip install -r requirements.txt && \
    pip cache purge && \
    python examples/cmd/run.py "This is test text." && \
    rm ./output_audio_*.mp3

WORKDIR ChatTTS-${CHATTTS_VERSION}

CMD python examples/web/webui.py
