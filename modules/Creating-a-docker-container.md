# How to build and push a docker container. 
To make this work you’re going to need the following:

* A Docker Hub account, [this is mine](https://hub.docker.com/repository/docker/happykhan).
* Docker installed on your local machine, [documentation for install on macOSX](https://docs.docker.com/desktop/install/mac-install/)

The process is; 

* Create a remote repo 
* Build the docker image (container) on your local machine, 
* Tag the local image
* Push the image to the remote repo 

The outcome is that you will be able to pull the container for anywhere, like `docker pull happykhan/ezclermont`. 
You can then specify this in nextflow workflows, and avoid directly installing tools!

## How to write your dockerfile
The image we’re going to build is installing `ezclermont` using `conda`. 

If you building a new image for a module in `nextflow`, in your nextflow pipeline folder create a `Dockerfile` (this is just a text file) in the modules/<your module name> directory. 
This is a sample Dockfile installing `ezclemont` 

```bash 
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
```

## How to log into your Docker Hub account
We have to log into our Docker Hub account to push the new image. To successfully log into Docker Hub from the command line, you must first create an access token. Log in to Docker Hub and click your profile image. From the popup menu, select Account Settings. On the resulting page, click Security in the left navigation and then click New Access Token.

## Creating a new access token in Docker Hub.
Once you’ve generated the access token, copy it to your clipboard. Go back to the terminal window and issue the command:

```bash
docker login -u NAME
```

Where NAME is your Docker Hub username. You will be prompted for your Docker Hub password, where you’ll use the access token you just generated.

## How to build your image
It’s time to build our image. We’re going to name the image trtest. To do this, issue the command:

```bash
docker build -t ezclemont modules/ezclermont
```

When the build completes, you’ll have a new image, named `ezclemont`. You can confirm this with `docker images`

```bash
❯ docker images
REPOSITORY             TAG       IMAGE ID       CREATED          SIZE
happykhan/ezclermont   latest    7b061d1a55e0   9 minutes ago    853MB
ezclermont             latest    7b061d1a55e0   9 minutes ago    853MB
```

You can troubleshoot any issues by interacting with the container. If you want to run the software, `ezclermont` in this case, you can run something like the following: 

```bash
❯ docker run --platform=linux/x86_64 ezclermont  ezclermont
usage: ezclermont [-m MIN_LENGTH] [-e EXPERIMENT_NAME] [-n]
                  [--logfile LOGFILE] [-h] [--version]
                  contigs
ezclermont: error: the following arguments are required: contigs
```

To run with some test data:

```bash
❯ docker run --platform=linux/x86_64  -v ${PWD}/sample_data:/data  ezclermont ezclermont  /data/GCF_002893905.2.fna
Reading in sequence(s) from GCF_002893905.2.fna
.....
GCF_002893905.2 C
('C', 'TspE4: -\narpA: +\nchu: -\nyjaA: +\n')
```

**The `-v `is to mount a location in the container.**

**N.B `--platform=linux/x86_64` is to handle the fact I am running the docker container on a MacBook with Apple Silicon (M1).**

To work from within the container: 

```bash
❯ docker run --platform=linux/x86_64  -v ${PWD}/sample_data:/data -it ezclermont bash                              
root@ed75c32bd4d2:/# ls
bin  boot  data  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
```

# How to tag and push the image
Finally, we’re going to tag our new image and then push it to Docker Hub. First tag the image with :latest using the command:

```bash
docker image tag ezclermont USER/ezclermont:latest
```

Where USER is your Docker Hub username.

Now that the image is tagged, we can push it to Docker Hub with:

```bash
docker image push USER/ezclermont:latest
```

Where USER is your Docker Hub username.

You can then see the image online, in this example, mine is at: [https://hub.docker.com/repository/docker/happykhan/ezclermont/general](https://hub.docker.com/repository/docker/happykhan/ezclermont/general)

Now anyone can pull the image using 

```
docker push happykhan/ezclermont:latest
```

If you want nextflow to use this container you can add something like below to your `nextflow.config`:

```
    docker.runOptions='-u $(id -u):$(id -g)'
    docker.enabled = true
    process {
        executor = 'local'
        withName:'EZCLERMONT' {
            container = 'happykhan/ezclermont:latest'
        }
    }   
```

OR you can embed this in your nextflow process: 

```
process foo {
  container 'happykhan/ezclermont:latest'

  '''
  do this
  '''
}
```
