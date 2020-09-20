FROM ubuntu:20.04
LABEL maintainer="hosta1"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
    && apt install -y texlive-lang-cjk xdvik-ja \
    && apt install -y texlive-fonts-recommended texlive-fonts-extra \
    && apt install -y latexmk

WORKDIR /working
