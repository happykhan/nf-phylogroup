# Dockerfile
# Use the ubuntu:22.04 base image for the container
FROM --platform=linux/x86_64 ubuntu:22.04

# Set the environment variable PATH to include the miniconda3 bin directory
ENV PATH="/root/miniconda3/bin:${PATH}"

# Define the ARG PATH and set it to include the miniconda3 bin directory
ARG PATH="/root/miniconda3/bin:${PATH}"

# Update the package lists in the container
RUN apt-get update

# Install wget and procps packages, then remove the package lists
RUN apt-get install -y wget procps && rm -rf /var/lib/apt/lists/*

# Download the latest Miniconda3 installer script and run the installer
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

# Configure conda channels and update conda
RUN conda config --add channels bioconda \
    && conda config --add channels conda-forge \
    && conda config --set channel_priority strict \
    && conda update -n base -c defaults conda \
    && conda install -n base conda-libmamba-solver \
    && conda config --set solver libmamba \
    && conda install -y ezclermont \ 
    && conda clean -a -y