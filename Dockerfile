FROM docker.io/fedora:latest
MAINTAINER Maxim.Belooussov@ing.nl

# set the timezone to be Europe/Amsterdam
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
#RUN yum -y update
RUN dnf clean all
RUN dnf -y install libXext libX11 libXcursor libSM libICE libGL fontconfig libXinerama
RUN dnf -y install qt \
                   tar \
                   gcc \
                   make \
                   curl \
                   dkms \
                   bzip2 \
                   patch \
                   python \
                   procps \
                   vagrant \
                   libgomp \
                   binutils \
                   glibc-devel \
                   kernel-devel \
                   glibc-headers \
                   kernel-headers \
                   vagrant-libvirt \
                   openssh-clients \
                   libvirt-daemon-vbox --allowerasing
RUN curl -kls http://download.virtualbox.org/virtualbox/5.0.20/VirtualBox-5.0.20-106931-Linux_amd64.run -o /VirtualBox-5.0.20-106931-Linux_amd64.run
RUN chmod +x /VirtualBox-5.0.20-106931-Linux_amd64.run
RUN /VirtualBox-5.0.20-106931-Linux_amd64.run
RUN rm -f /VirtualBox-5.0.20-106931-Linux_amd64.run
RUN dnf clean all
VOLUME /usr/src/
COPY artifacts/packer*.* /
COPY artifacts/entrypoint.sh /entrypoint.sh
EXPOSE 5555
CMD /entrypoint.sh
