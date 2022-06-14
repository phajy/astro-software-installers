# relxill (XSPEC relativistic disk reflection model)

Full installation guide on the [relxill website](http://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/).

For running XSPEC, see [this guide in the astro-group-bristol/guidelines](https://github.com/astro-group-bristol/guidelines/blob/main/guides/xspec-setup.md).

## Docker

Note that this builds on the [Docker XSPEC](../heasoft) image.

## Building locally
To build locally, clone this repository and change to the `relxill` directory.
```bash
git clone https://github.com/astro-group-bristol/astro-software-installers
cd astro-software-installers/relxill
```

Next, download the source code for HEASoft:
```bash
    wget http://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/relxill_model_v1.4.3.tgz
    wget http://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/relxill_tables.tgz
```

The Dockerfile will copy the source from the host machine to avoid having to re-download it incase anything goes wrong.

Finally, build the image in the usual way, with the option of specifying architecture as a build argument:

- ARM and Apple Silicon
```bash
docker build . -t relxill --build-arg ARCH=aarch64
```