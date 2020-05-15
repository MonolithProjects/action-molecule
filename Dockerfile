FROM python:3.8-alpine

LABEL "maintainer"="Michal Muransky <mike.muransky@gmail.com>"
LABEL "repository"="https://github.com/monolithprojects/action-molecule"

LABEL "com.github.actions.name"="molecule"
LABEL "com.github.actions.description"="Test Ansible with Molecule"
LABEL "com.github.actions.icon"="play"
LABEL "com.github.actions.color"="green"

RUN apk add --update --no-cache \
    docker \
    gcc \
    git \
    libc-dev \
    libffi-dev \
    make \
    musl-dev \
    openssh-client \
    openssl-dev \
    && pip install --no-cache-dir \
       ansible-lint \
       "molecule[docker]" \
       yamllint \
    && rm -rf /root/.cache

CMD cd ${GITHUB_REPOSITORY}; if [ "${M_COMMAND}" = "converge" ] && [ -n "${C_TAGS}" ]; then; echo "Ansible tags used: ${C_TAGS}"; molecule converge -- -tags "${C_TAGS}"; else; molecule "${M_COMMAND}"; fi
