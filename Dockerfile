FROM alpine
RUN apk add git bash

COPY semantic-versioning.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/semantic-versioning.sh
