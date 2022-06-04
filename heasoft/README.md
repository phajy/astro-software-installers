# HEASoft (XSPEC)

Full installation guide on the [HEASoft website](https://heasarc.gsfc.nasa.gov/lheasoft/download.html).

For running XSPEC, see [this guide in the astro-group-bristol/guidelines](https://github.com/astro-group-bristol/guidelines/blob/main/guides/xspec-setup.md).

## Docker

Docker images available for intel and arm architectures.

- x86 CPUs
```
docker pull dustpancake/heasoft:6.30.1
```

- ARM and Apple Silicon
```
docker pull dustpancake/heasoft:6.30.1-aarch64
```

Dockerfiles for these images are modified from the [HEASoft docker installation](https://heasarc.gsfc.nasa.gov/lheasoft/docker.html). In particular, the ARM version of this image does not include SUZAKU mission specifics.

## Building locally
To build locally, clone this repository and change to the `heasoft` directory.
```bash
git clone https://github.com/astro-group-bristol/astro-software-installers
cd astro-software-installers/heasoft
```

Next, download the source code for HEASoft:
```bash
HEASOFT_VERSION=6.30.1 wget "https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft${HEASOFT_VERSION}/heasoft-${HEASOFT_VERSION}src.tar.gz" \
    && tar xfz heasoft-${HEASOFT_VERSION}src.tar.gz \
    && rm -r heasoft-${HEASOFT_VERSION}src.tar.gz heasoft-${HEASOFT_VERSION}/suzaku
```

The Dockerfiles have been modified to copy in the source from the host machine to avoid having to re-download it incase anything goes wrong.

Finally, build the image in the usual way, with the option of specifying architecture as a build argument:

- x86 CPUs
```bash
docker build . -t heasoft --build-arg ARCH=x86_64
```

- ARM and Apple Silicon
```bash
docker build . -t heasoft --build-arg ARCH=aarch64
```