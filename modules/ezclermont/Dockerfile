# Dockerfile
FROM --platform=linux/x86_64 continuumio/miniconda3

RUN conda config --add channels bioconda && conda install -y ezclermont \ 
    && conda clean -a -y
