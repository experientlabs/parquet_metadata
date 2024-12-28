# Use the official Python image with Python 3.12
FROM python:3.12-slim

# Set environment variables
ENV USERNAME=pyuser \
    USER_UID=1000 \
    USER_GID=1000 \
    DEBIAN_FRONTEND=noninteractive

# Install required Debian packages
RUN apt-get update && apt-get install -y \
    vim \
    wget \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set up Python environment
RUN pip install --no-cache-dir virtualenv 

# Create a virtual environment and install packages
COPY requirements.txt /tmp/requirements.txt
RUN python -m virtualenv /home/$USERNAME/venv \
    && /home/$USERNAME/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt

# Set up Jupyter to use the virtual environment
RUN /home/$USERNAME/venv/bin/pip install --no-cache-dir jupyter

# Create Jupyter configuration directory
RUN mkdir -p /home/$USERNAME/.jupyter \
    && echo "c.NotebookApp.notebook_dir = '/home/pyuser/app'" >> /home/pyuser/.jupyter/jupyter_notebook_config.py

# Set up working directory
WORKDIR /home/$USERNAME/app

# Set ownership of the working directory
RUN chown -R $USER_UID:$USER_GID /home/$USERNAME

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Switch to the non-root user
USER $USERNAME

# Expose Jupyter Notebook port
EXPOSE 8888

# Entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
