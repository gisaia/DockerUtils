FROM python:3.12.11
WORKDIR /docs
RUN pip install mkdocs==1.6.1 \
  && pip install mkdocs-to-pdf==0.10.1 \
  && pip install mkdocs-with-pdf==0.9.3 \
  && pip install pymdown-extensions==10.15 \
  && pip install mkdocs_puml==2.3.0 \
  && pip install mkdocs-redoc-tag==0.2.0 \
  && pip install mkdocstrings==0.29.1 \
  && pip install mkdocstrings-python==1.16.12 \
  && pip install griffe-pydantic==1.1.4 \
  && pip install mkdocs-material==9.6.14 \
  && pip install pydantic==2.11.7
EXPOSE 8000
ENTRYPOINT ["mkdocs"]
