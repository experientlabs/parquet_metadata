#!/bin/bash

# Activate the virtual environment
source /home/pyuser/venv/bin/activate

# Entrypoint script for the container
if [[ "$1" == "jupyter" ]]; then
    exec jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root
else
    exec python
fi

