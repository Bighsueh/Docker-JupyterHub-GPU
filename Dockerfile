# Use the official JupyterHub image as the base
FROM jupyterhub/jupyterhub:latest

# Install dependencies
RUN pip install notebook

# Install NVIDIA Container Toolkit for GPU support
RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - \
    && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list

RUN apt-get update && apt-get install -y nvidia-container-toolkit

# Add a user
RUN useradd -ms /bin/bash admin

# Add a user and set password
RUN useradd -ms /bin/bash admin && echo "admin:admin" | chpasswd

# Set the working directory
WORKDIR /home/admin

# Start JupyterHub
CMD ["jupyterhub", "--ip", "0.0.0.0"]
