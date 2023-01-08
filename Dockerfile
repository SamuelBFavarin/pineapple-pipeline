FROM python:3.10.6-slim

LABEL Pipeline Squad

WORKDIR /app
RUN pip install --upgrade pip && pip install poetry

# Install requirements
COPY pyproject.toml /app/

# Add credentials for paperlabs library
RUN apt-get -yq update \
    && apt-get install -y git \
    && apt-get install -y gcc

RUN poetry export --extras dbt --without-hashes -f requirements.txt --output /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt


COPY . /app/

ENTRYPOINT ["dbt", "build"]