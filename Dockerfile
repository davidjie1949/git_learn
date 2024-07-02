# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04 as base

# Configure RTI DDS
FROM base AS dds

WORKDIR /app/dds

# Update package lists and install vi
RUN apt-get update
RUN apt-get install -y git vim gcc g++ iputils-ping

# Basic install and x64 toolchain
COPY sd-maps/resources/rti_connext_dds-6.1.2-pro-host-x64Linux.run .

# RUN the installer in unattended mode
RUN ./rti_connext_dds-6.1.2-pro-host-x64Linux.run --unattendedmodeui minimal --mode unattended --prefix /root

# Environment variables
ENV NDDSHOME="/root/rti_connext_dds-6.1.2"
ENV PATH="$PATH:$HOME/bin:$NDDSHOME/bin"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$NDDSHOME/lib/x64Linux4gcc7.3.0/"
ENV CONNEXTDDS_ARCH="x64Linux4gcc7.3.0"

# Setting RTI environment variables in ~/.bashrc
RUN echo 'export NDDSHOME=/root/rti_connext_dds-6.1.2'                              >> ~/.bashrc
RUN echo 'export PATH=$PATH:$HOME/bin:$NDDSHOME/bin'                                >> ~/.bashrc
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NDDSHOME/lib/x64Linux4gcc7.3.0/' >> ~/.bashrc
RUN echo 'export CONNEXTDDS_ARCH=x64Linux4gcc7.3.0'                                 >> ~/.bashrc

COPY sd-maps/resources/rti_connext_dds-6.1.2-pro-target-x64Linux4gcc7.3.0.rtipkg .
RUN $NDDSHOME/bin/rtipkginstall -unattended rti_connext_dds-6.1.2-pro-target-x64Linux4gcc7.3.0.rtipkg

# COPY resources/rti_license.dat .
COPY sd-maps/resources/rti_license.dat $NDDSHOME
RUN echo 'export RTI_LICENSE_FILE=$NDDSHOME/rti_license.dat'      >> ~/.bashrc

# Make the binary executable (if needed)
# RUN chmod +x /app/your_binary_name

# Set the SDMap working directory inside the container
WORKDIR /app/SDMap

COPY sd-maps/artifacts ./artifacts/
COPY sd-maps/runSDMaps.sh .

WORKDIR /app/vehicleDemo

RUN apt install -y libeigen3-dev libboost-all-dev

COPY vehicle-demo/artifacts ./artifacts/
COPY vehicle-demo/src/ODD_Localization/qos_xml ./src/ODD_Localization/qos_xml/

# Expose the port your application is listening on
EXPOSE 8080

# Specify the command to run when the container starts
# CMD ["./runSDMaps.sh 110"]
# Default command to run when the container starts

WORKDIR /app/regressionTestLog
COPY dds_log_1709167619 ./dds_log_1709167619/

WORKDIR /app/odd_kpi

# Install python3
RUN apt-get install -y python3-pip

# Install Python package
RUN pip3 install pymap3d

COPY odd_kpi ./odd_kpi/

CMD ["/bin/bash"]

