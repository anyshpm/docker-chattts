# Dockerfile

FROM python:3.9-bullseye

LABEL maintainer="Anyshpm Chen <anyshpm@anyshpm.com>"

ARG CHATTTS_VERSION

ENV CHATTTS_VERSION=${CHATTTS_VERSION:-0.2.3}

WORKDIR /app

COPY requirements.txt simple.py /app/

RUN set -x && \
    apt update && \
    apt install -y ffmpeg && \
    apt clean

RUN set -x && \
    curl -Lo ChatTTS-${CHATTTS_VERSION}.zip https://github.com/2noise/ChatTTS/archive/refs/tags/v${CHATTTS_VERSION}.zip && \
    unzip ChatTTS-${CHATTTS_VERSION}.zip && \
    cd ChatTTS-${CHATTTS_VERSION} && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install safetensors vllm==0.2.7 torchaudio && \
    pip cache purge && \
    python examples/cmd/run.py "This is test text." && \
    rm ./output_audio_*.mp3

WORKDIR /app/ChatTTS-${CHATTTS_VERSION}

CMD ["python", "examples/web/webui.py"]
