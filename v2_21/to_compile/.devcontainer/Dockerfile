# Get the image from microsoft server
# https://hub.docker.com/_/ubuntu
FROM ubuntu:jammy

# Install the compilers
RUN apt-get update && apt-get install -y gcc gfortran bash
RUN rm -rf /var/lib/apt/lists/*

# Copy the requirement file on the docker machine
# COPY requirements.txt .
# Install the requirements on the docker machine (venv is redundant)
# RUN pip3 install -r requirements.txt

CMD ["/bin/bash"]

#CMD tail -F /dev/null

