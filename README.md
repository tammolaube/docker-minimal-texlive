# Docker Minimal TeX Live
Creates a container with a minimal installation of TeX Live.

## Build
Use the `--build-arg` option with the variable `TEX_PACKAGES` to specify the packages that need to be installed in your container.
```
$ docker build -t mintexlive --build-arg TEX_PACKAGES="koma-script verbatimbox readarray listofitems advdate marvosym babel-german" .
```
## Run
To run, call the tex program you would like to run. For example, to run pdflatex on all files in current directory:
```
$ docker run --rm -v "$PWD":/workdir -w /workdir mintexlive pdflatex *.tex
```
If no command is given the container will echo the environment variable `TEX_PACKAGES` specified at container build time.
```
$ docker run --rm mintexlive 
Installed with tex packages: koma-script verbatimbox readarray listofitems advdate marvosym babel-german
```
