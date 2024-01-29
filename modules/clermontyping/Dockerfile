# Dockerfile
# Init: antoine.bridier-nahmias@inserm.fr
# nabil-fareed.alikhan@cgps.group 
# 2024-01-25

# Base image
FROM --platform=linux/amd64 debian:trixie
# Update and upgrade packages
RUN apt update && apt upgrade -y
# Install required packages
RUN apt install -y less vim tree python3 python3-pip zip git python3-biopython r-base r-base-dev pandoc
# Install R packages
RUN printf 'install.packages(c("readr", "dplyr", "tidyr", "stringr", "knitr", "markdown", "pandoc"), repos="http://cran.us.r-project.org")' | Rscript --vanilla /dev/stdin
# Clone ClermonTyping repository

RUN apt install -y procps less vim tree python3 python3-pip zip git python3-biopython
RUN git clone https://github.com/A-BN/ClermonTyping /2024-clermontyping

# Change directory to /2024-clermontyping

WORKDIR /2024-clermontyping
ENV PATH="/2024-clermontyping:${PATH}"

