ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

USER root

# Install curl & wget

RUN apt-get update && apt-get install -y curl wget

# Install aws-cli

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
sudo ./aws/install

RUN aws --version

# Clone repo to create env

RUN git clone https://github.com/farreg/jupyter-datascience-dev.git /home/jupyter-datascience-dev/ 

RUN cd /home/jupyter-datascience-dev/envs/ 
RUN conda env create -f /home/jupyter-datascience-dev/envs/environment_guido.yml
SHELL ["conda","run","-n","guido_env","/bin/bash","-c"]
RUN python -m ipykernel install --name guido_env --display-name "guido_env"