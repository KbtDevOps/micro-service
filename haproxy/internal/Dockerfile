FROM haproxy:1.7-alpine

COPY ./ /

RUN chmod 755 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]