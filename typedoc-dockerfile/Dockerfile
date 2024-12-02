# We label our stage as 'typedoc'
FROM node:18.19-alpine AS typedoc

WORKDIR typedoc

COPY ./generate-doc.sh  ./generate-doc.sh

RUN echo -e '#!/bin/sh\nsh /typedoc/generate-doc.sh ${*}' > /usr/bin/generatedoc && \
    chmod +x /usr/bin/generatedoc
