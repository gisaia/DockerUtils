FROM python:3.9-slim-buster

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt install -y --no-install-recommends netcat bash git

#clone stac-api-validator project
RUN git clone --depth 1 https://github.com/stac-utils/stac-api-validator.git /usr/src

RUN pip install --upgrade pip && \
    pip install -r /usr/src/requirements.txt

COPY . /opt/app/
CMD /opt/app/run.sh