FROM python:3.9.2
WORKDIR /docs
RUN pip install mkdocs==1.1.2 \
  && pip install mkdocs-with-pdf==0.8.3 \
  && pip install mkdocs-material==7.0.6
EXPOSE 8000
CMD ["mkdocs","serve"]
