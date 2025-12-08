# We label our stage as 'typedoc'
FROM node:24-alpine AS typedoc

WORKDIR typedocs

COPY ./generate-doc.sh  ./generate-doc.sh

RUN echo -e '#!/bin/sh\nsh /typedocs/generate-doc.sh ${*}' > /usr/bin/generatedoc && \
    chmod +x /usr/bin/generatedoc   
