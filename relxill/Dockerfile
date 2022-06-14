# Build with docker build . -t relxill:1.4.3-aarch64
# Run with, e.g.,
# /opt/X11/bin/xhost + 127.0.0.1
# docker run --rm -it -e DISPLAY=host.docker.internal:0 -v /path/to/my/data:/data relxill tcsh

FROM dustpancake/heasoft:6.30.1-aarch64

ARG RELXILL_VERSION=1.4.3
# architectures: x86_64 or aarch64
ARG ARCH=aarch64

WORKDIR /home/relxill

# Comment in/out the download or copy options
# RUN wget http://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/relxill_model_v1.4.3.tgz
COPY relxill_model_v1.4.3.tgz .
# RUN wget http://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/relxill_tables.tgz
COPY relxill_tables.tgz .

RUN tar xfz relxill_tables.tgz
RUN tar xfz relxill_model_v1.4.3.tgz

RUN ./compile_relxill.sh

WORKDIR /home/heasoft

RUN echo "lmod relxill /home/relxill" >> ~/.xspec/xspec.rc
