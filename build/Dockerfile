FROM registry.access.redhat.com/ubi7-dev-preview/ubi-minimal:7.6

ENV OPERATOR=crontab-operator \
    WORKDIR=/usr/local/bin \
    USER_UID=1001 \
    USER_NAME=crontab-operator

WORKDIR ${WORKDIR}

# install operator binary

COPY bin/ /usr/local/bin/
RUN  /usr/local/bin/user_setup

ENTRYPOINT ["/usr/local/bin/entrypoint"]

USER ${OPERATOR}
