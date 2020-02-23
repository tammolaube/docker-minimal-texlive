FROM debian:stretch-slim
ARG TEX_PACKAGES 

RUN apt-get update && apt-get install \ 
	perl \
	wget \
	-y 

WORKDIR /workdir
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xzf install-tl-unx.tar.gz
COPY texlive.profile texlive.profile
RUN mv */* .
RUN ./install-tl --profile=texlive.profile
ENV PATH "/usr/local/texlive/2019/bin/x86_64-linux:$PATH"
RUN tlmgr install $TEX_PACKAGES

FROM frolvlad/alpine-glibc:latest
ARG TEX_PACKAGES 
ENV TEX_PACKAGES $TEX_PACKAGES 
WORKDIR /root
COPY --from=0 /usr/local/texlive /usr/local/texlive
ENV PATH "/usr/local/texlive/2019/bin/x86_64-linux:$PATH"
CMD echo "Installed with tex packages: ${TEX_PACKAGES}"
