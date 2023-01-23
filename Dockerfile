FROM python:3.10.6-slim

LABEL Pipeline Squad

WORKDIR /app
RUN pip install --upgrade pip && pip install poetry

# Install requirements
COPY pyproject.toml /app/

# Add credentials for paperlabs library
RUN apt-get -yq update \
    && apt-get install -y git \
    && apt-get install -y gcc \
    && apt-get install -y jq \
    && apt-get install -y curl 

RUN poetry export --extras dbt --without-hashes -f requirements.txt --output /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt


ENV ENV_NAME=dev
ENV DBT_PROJECT=dev-pineapple-pipeline
ENV DBT_DEFAULT_DATASET=application
ENV DBT_PROFILES_DIR=/app/
ENV DBT_PRIVATE_KEY_ID=your-private-key-id
ENV DBT_PRIVATE_KEY=your-private-key
ENV DBT_METADATA_API_TOKEN=your-token

COPY . /app/

RUN chmod +x ./ci/run_ci.sh 
ENTRYPOINT ./ci/run_ci.sh