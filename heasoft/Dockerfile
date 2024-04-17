# Dockerfile for complete HEASoft downloads
FROM ubuntu:22.04 as build

ARG HEASOFT_VERSION=6.33.1
# architectures: x86_64 or aarch64
ARG ARCH=x86_64

ENV DEBIAN_FRONTEND=noninteractive

# Install HEASoft prerequisites
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install \
	gcc \
	gfortran \
	g++ \
	curl \
	libcurl4 \
	libcurl4-gnutls-dev \
	libncurses5-dev \
	libreadline6-dev \
	libfile-which-perl \
	libdevel-checklib-perl \
	make \
	ncurses-dev \
	perl-modules \
	python3-dev \
	python3-pip \
	python3-setuptools \
	python3-astropy python3-numpy python3-scipy python3-matplotlib \
	python-is-python3 \
	tcsh \
	lsb-release \
	wget \
	xorg-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd heasoft && useradd -r -m -g heasoft heasoft \
 && mkdir -p /opt/heasoft/caldb \
 && chown -R heasoft:heasoft /opt/heasoft

COPY heasoft-${HEASOFT_VERSION} /home/heasoft/heasoft-${HEASOFT_VERSION}

WORKDIR /home/heasoft/heasoft-${HEASOFT_VERSION}/BUILD_DIR/
RUN ./configure --prefix=/opt/heasoft

# this can clutter the build output if something fails
# to increase the log size for debugging, use docker buildx:
# ```bash
# docker buildx create --use --name larger_log --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=50000000
# docker buildx build . -t heasoft
# ```
# unfortunately this method doesn't seem to cache layers very well
RUN make

# update pip to be compatible with latest pyproject.toml versions
RUN apt update \
    && apt-get install -y python3-pip \
    && python3 -m pip install -U pip

RUN make install && make clean

# make sure we pick the right architecture, else we won't find the binaries
RUN /bin/bash -c 'cd /opt/heasoft/; for loop in ${ARCH}*/*; do ln -sf $loop; done' \
 && cd /home/heasoft/heasoft-${HEASOFT_VERSION} \
 && cp -p Xspec/BUILD_DIR/hmakerc /opt/heasoft/bin/ \
 && cp -p Xspec/BUILD_DIR/Makefile-std /opt/heasoft/bin/ \
 && rm -rf Xspec/src/spectral \
 && cp -p /home/heasoft/heasoft-${HEASOFT_VERSION}/Release_Notes* /opt/heasoft/

# Configure shells...
RUN /bin/echo >> /home/heasoft/.bashrc \
 && /bin/echo '# Initialize HEASoft environment' >> /home/heasoft/.bashrc \
 && /bin/echo 'export HEADAS=/opt/heasoft' >> /home/heasoft/.bashrc \
 && /bin/echo '. $HEADAS/headas-init.sh' >> /home/heasoft/.bashrc \
 && /bin/echo >> /home/heasoft/.bashrc \
 && /bin/echo '# Initialize environment for CALDB' >> /home/heasoft/.bashrc \
 && /bin/echo 'export CALDB=https://heasarc.gsfc.nasa.gov/FTP/caldb' >> /home/heasoft/.bashrc \
 && /bin/echo 'export CALDBCONFIG=/opt/heasoft/caldb/caldb.config' >> /home/heasoft/.bashrc \
 && /bin/echo 'export CALDBALIAS=/opt/heasoft/caldb/alias_config.fits' >> /home/heasoft/.bashrc \
 && /bin/echo >> /home/heasoft/.profile \
 && /bin/echo '# Initialize HEASoft environment' >> /home/heasoft/.profile \
 && /bin/echo 'export HEADAS=/opt/heasoft' >> /home/heasoft/.profile \
 && /bin/echo '. $HEADAS/headas-init.sh' >> /home/heasoft/.profile \
 && /bin/echo >> /home/heasoft/.profile \
 && /bin/echo '# Initialize environment for CALDB' >> /home/heasoft/.profile \
 && /bin/echo 'export CALDB=https://heasarc.gsfc.nasa.gov/FTP/caldb' >> /home/heasoft/.profile \
 && /bin/echo 'export CALDBCONFIG=/opt/heasoft/caldb/caldb.config' >> /home/heasoft/.profile \
 && /bin/echo 'export CALDBALIAS=/opt/heasoft/caldb/alias_config.fits' >> /home/heasoft/.profile \
 && /bin/echo '# Initialize HEASoft environment' >> /home/heasoft/.cshrc \
 && /bin/echo 'setenv HEADAS /opt/heasoft' >> /home/heasoft/.cshrc \
 && /bin/echo 'source $HEADAS/headas-init.csh' >> /home/heasoft/.cshrc \
 && /bin/echo >> /home/heasoft/.cshrc \
 && /bin/echo '# Initialize environment for CALDB' >> /home/heasoft/.cshrc \
 && /bin/echo 'setenv CALDB https://heasarc.gsfc.nasa.gov/FTP/caldb' >> /home/heasoft/.cshrc \
 && /bin/echo 'setenv CALDBCONFIG /opt/heasoft/caldb/caldb.config' >> /home/heasoft/.cshrc \
 && /bin/echo 'setenv CALDBALIAS /opt/heasoft/caldb/alias_config.fits' >> /home/heasoft/.cshrc

RUN cd /opt/heasoft/caldb \
    && wget https://heasarc.gsfc.nasa.gov/FTP/caldb/software/tools/caldb.config \
    && wget https://heasarc.gsfc.nasa.gov/FTP/caldb/software/tools/alias_config.fits

USER heasoft
WORKDIR /home/heasoft

ENV CC=/usr/bin/gcc \
    CXX=/usr/bin/g++ \
    FC=/usr/bin/gfortran \
    PERL=/usr/bin/perl \
    PERLLIB=/opt/heasoft/lib/perl \
    PERL5LIB=/opt/heasoft/lib/perl \
    PYTHON=/usr/bin/python \
    PYTHONPATH=/opt/heasoft/lib/python:/opt/heasoft/lib \
    PATH=/opt/heasoft/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    HEADAS=/opt/heasoft \
    LHEASOFT=/opt/heasoft \
    FTOOLS=/opt/heasoft \
    LD_LIBRARY_PATH=/opt/heasoft/lib \
    LHEAPERL=/usr/bin/perl \
    PFCLOBBER=1 \
    PFILES=/home/heasoft/pfiles;/opt/heasoft/syspfiles \
    FTOOLSINPUT=stdin \
    FTOOLSOUTPUT=stdout \
    LHEA_DATA=/opt/heasoft/refdata \
    LHEA_HELP=/opt/heasoft/help \
    EXT=lnx \
    PGPLOT_FONT=/opt/heasoft/lib/grfont.dat \
    PGPLOT_RGB=/opt/heasoft/lib/rgb.txt \
    PGPLOT_DIR=/opt/heasoft/lib \
    POW_LIBRARY=/opt/heasoft/lib/pow \
    XRDEFAULTS=/opt/heasoft/xrdefaults \
    TCLRL_LIBDIR=/opt/heasoft/lib \
    XANADU=/opt/heasoft \
    XANBIN=/opt/heasoft \
    CALDB=https://heasarc.gsfc.nasa.gov/FTP/caldb \
    CALDBCONFIG=/opt/heasoft/caldb/caldb.config \
    CALDBALIAS=/opt/heasoft/caldb/alias_config.fits

CMD [ "fversion" ]

