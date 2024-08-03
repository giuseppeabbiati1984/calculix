# Get the image from microsoft server
# https://hub.docker.com/_/ubuntu
FROM ubuntu:jammy

# Install the compilers
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && apt-get update && apt-get upgrade -y && apt-get update
RUN apt-get install -y gcc gfortran bash make nano bzip2 libblas-dev liblapack-dev liblapacke-dev nano unzip xfce4 xfce4-goodies xfce4-terminal tightvncserver doxygen python3 python3-pip
# qtbase5-dev libqwt-qt5-6 libboost-all-dev libqt5x11extras5 libqt5help5 libfreeimage3 libgdal30 libtbb2

# Copy the requirement file on the docker machine
COPY install_calculix.sh .
COPY install_salome.sh .
COPY requirements.txt .

# Set environment variables
ENV USER=root

# Expose VNC port
EXPOSE 5901

# Add startup script
COPY startup.sh .
RUN chmod +x /startup.sh

# sat/sat config SALOME-9.10.0-native --check_system

# create a link to python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# install python packages
# RUN pip3 install -r requirements.txt

# Create VNC startup script
# RUN mkdir -p /root/.vnc && echo '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &' > /root/.vnc/xstartup && chmod +x /root/.vnc/xstartup
# Start VNC server
# CMD /bin/bash -c "echo $VNC_PASSWORD | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd && vncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log"
#Set the entrypoint
#ENTRYPOINT ["/startup.sh"]
#Run the startup script
#CMD ["/startup.sh"]
#CMD output is not visible from here
#RUN does not have access to volumes
#CMD ["/install_calculix.sh"]
#CMD ["/bin/bash"]
#CMD tail -F /dev/null
