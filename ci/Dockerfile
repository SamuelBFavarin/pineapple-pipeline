FROM python:3.10.6-slim

LABEL Pineapple Squad

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

ENV POETRY_VERSION=1.1.15

WORKDIR /ci/

# Install requirements
COPY pyproject.toml /ci/

# Add credentials for  library
RUN apt-get -yq update \
    && apt-get --no-install-recommends -yqq install curl build-essential
# ssh \
# && mkdir -p -m 0600 ~/.ssh \
# && ssh-keyscan github.com >> ~/.ssh/known_hosts \
# && apt-get install -y git \
# && apt-get install -y gcc

RUN curl -sSL https://install.python-poetry.org | python3 -


RUN poetry export --extras ci --without-hashes -f requirements.txt --output /ci/requirements.txt
RUN pip install --no-cache-dir -r /ci/requirements.txt

WORKDIR /ci/
ENV PYTHONPATH=/
COPY ./ci /ci/
ENV PORT 8080

EXPOSE ${PORT}
ENTRYPOINT /ci/docker-entrypoint.sh $0 $@
CMD ["streamlit", "run", "Seeder.py", "--server.enableCORS=false", "--server.port=8080", "--server.headless=true"]
