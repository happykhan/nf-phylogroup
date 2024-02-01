# Dockerfile
FROM --platform=linux/x86_64 continuumio/miniconda3

RUN conda config --add channels bioconda && conda install -y ezclermont \ 
    && conda clean -a -y
RUN chmod -R o+rX /opt/conda 
 
ENV PATH="/opt/conda/bin/:${PATH}"
