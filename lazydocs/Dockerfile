FROM python:3.10
WORKDIR /docs
RUN pip3.10 install lazydocs
COPY run.sh /opt/app/
ENTRYPOINT ["/opt/app/run.sh"]
