FROM python:3.13.3-slim AS base

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

FROM base AS python-deps
RUN apt-get update && apt-get install -y gcc wget curl
# Install deps
COPY requirements.txt .
RUN pip3 install -r requirements.txt

FROM python-deps AS runtime
WORKDIR /home/freshonions
ADD . /home/freshonions
RUN mkdir .cache
RUN chmod 755 .cache
RUN pip install -r requirements.txt
RUN groupadd -r freshonions && useradd --no-log-init -r -g freshonions freshonions
USER freshonions
CMD init/scraper-service.sh # to start crawling
