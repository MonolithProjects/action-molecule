FROM python:3.9-alpine3.13 AS builder

RUN set -eux \
    && apk add --update --no-cache \
            gcc \
            libc-dev \
            libffi-dev \
            make \
            musl-dev \
            openssl-dev \
    && pip install --no-cache-dir \
            cryptography==2.8 \
            ansible \
            ansible-lint \
            jmespath \
            "molecule[docker]" \
            yamllint

FROM python:3.9-alpine3.13

LABEL "maintainer"="Michal Muransky <mike.muransky@gmail.com>"
LABEL "repository"="https://github.com/MonolithProjects/action-molecule"
LABEL "com.github.actions.icon"="play-circle"
LABEL "com.github.actions.color"="gray-dark"
LABEL "com.github.actions.name"="action-molecule"
LABEL "com.github.actions.description"="Molecule for Ansible"

RUN set -eux \ 
    && apk add --update --no-cache \
        docker \
        git \
        openssh-client \
        && rm -rf /root/.cache

COPY --from=builder /usr/local/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/
COPY --from=builder /usr/local/bin/molecule /usr/local/bin/molecule
COPY --from=builder /usr/local/bin/yamllint /usr/local/bin/yamllint
COPY --from=builder /usr/local/bin/ansible* /usr/local/bin/

CMD cd ${GITHUB_REPOSITORY} ; if [ "${M_COMMAND}" = "converge" ] && [ -n "${EXTRA_ARGS}" ] ; then echo "Ansible extra arguments: ${EXTRA_ARGS}" ; ASSEMBLED_CMD="molecule converge -s ${SCENARIO:-default} -- ${EXTRA_ARGS}" ; eval $ASSEMBLED_CMD; else molecule "${M_COMMAND}" -s ${SCENARIO:-default} ; fi