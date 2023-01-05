#!/bin/sh

# Credits to michaeloliverx
# https://github.com/michaeloliverx/python-poetry-docker-example/blob/master/docker/docker-entrypoint.sh

set -e

# activate our virtual environment here
. /opt/pysetup/.venv/bin/activate

# You can put other setup logic here

# Evaluating passed command:
exec "$@"