FROM python:3.10.0b4
WORKDIR /home/freshonions
ADD . /home/freshonions
RUN pip install -r requirements.txt
RUN groupadd -r freshonions && useradd --no-log-init -r -g freshonions freshonions
USER freshonions
CMD init/isup-service.sh # to keep site status up to date
