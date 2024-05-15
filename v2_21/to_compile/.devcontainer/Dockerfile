# Get the image from microsoft server
# https://hub.docker.com/_/ubuntu
FROM ubuntu:jammy

# Install the compilers
RUN apt-get update && apt-get install -y gcc gfortran bash make nano bzip2 libblas-dev liblapack-dev liblapacke-dev nano unzip
RUN rm -rf /var/lib/apt/lists/*

# Copy the requirement file on the docker machine
COPY install_calculix.sh .
# Install the requirements on the docker machine (venv is redundant)
# RUN pip3 install -r requirements.txt

CMD ["/bin/bash"]

#CMD tail -F /dev/null

