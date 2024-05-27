# Get the image from microsoft server
# https://hub.docker.com/_/ubuntu
FROM ubuntu:jammy

# Install the compilers
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y gcc gfortran bash make nano bzip2 libblas-dev liblapack-dev liblapacke-dev nano unzip doxygen
RUN rm -rf /var/lib/apt/lists/*

# Copy the requirement file on the docker machine
COPY install_calculix.sh .

#CMD output is not visible from here
#RUN does not have access to volumes
#CMD ["/install_calculix.sh"]
#CMD ["/bin/bash"]
#CMD tail -F /dev/null
