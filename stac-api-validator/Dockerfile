# Use an official Python runtime as a base image
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc curl gnupg2 netcat-openbsd bash git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 -b v0.6.5 https://github.com/stac-utils/stac-api-validator.git /usr/src

# Set the working directory in the container
WORKDIR /stac-validator

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Add Poetry to PATH
ENV PATH="${PATH}:/root/.local/bin"

# Copy the source project in the workdir
RUN cp -r /usr/src/*  ./

# Configure Poetry: Do not create a virtual environment as the container itself provides isolation
RUN poetry config virtualenvs.create false

# Install dependencies using Poetry
RUN poetry install

# Copy the script and git patch files into the container
COPY run.sh ./
COPY git.patch ./

CMD /stac-validator/run.sh


COPY . /opt/app/
ENTRYPOINT [ "/opt/app/run.sh" ] 
