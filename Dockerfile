FROM python:3.10-buster

RUN apt update
RUN apt -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

ENV POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_CREATE=false \
    \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    \
    PYSETUP_PATH="/opt/pysetup"

ENV PATH="$POETRY_HOME/bin:$PATH"

WORKDIR /app

RUN apt update && \
    apt install --no-install-recommends -y curl && \
    apt clean

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

RUN curl -sSL https://install.python-poetry.org/ | python -
RUN /bin/bash -c "$(curl -fsSL https://exaloop.io/install.sh)"
RUN echo 'export PATH="$HOME/.codon/bin:$PATH"' >> ~/.bashrc
