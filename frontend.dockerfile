FROM python:3.13.3-slim AS base

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1
ENV FLASK_SECRET etc/flask.secret

FROM base AS python-deps
RUN apt-get update && apt-get install -y gcc
# Install deps
COPY requirements_frontend.txt .
RUN pip install --user -r requirements_frontend.txt

FROM python-deps AS runtime
RUN groupadd -r freshonions && useradd --no-log-init -r -g freshonions freshonions
WORKDIR /home/freshonions
USER freshonions
COPY . .
EXPOSE 8080
CMD sh scripts/web.sh
