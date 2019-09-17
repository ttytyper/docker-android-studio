FROM debian:10

ARG USER=android

RUN apt-get update && apt-get install -y \
        tar wget sudo git \
        qemu-kvm libvirt-daemon-system
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --disabled-password --gecos '' --home /home/android android
RUN adduser android libvirt
RUN adduser android kvm
RUN usermod -aG plugdev android
# /dev/kvm is group owned by messagebus, for some reason
RUN usermod -aG messagebus android

COPY 51-android.rules /etc/udev/rules.d/51-android.rules

USER android
WORKDIR /home/android
RUN wget https://dl.google.com/dl/android/studio/ide-zips/3.5.0.21/android-studio-ide-191.5791312-linux.tar.gz
# Unpacks to /home/android/android-studio/
RUN tar -xzvf android-studio-ide-191.5791312-linux.tar.gz
RUN rm android-studio-ide-191.5791312-linux.tar.gz

USER android
WORKDIR /home/android
RUN mkdir -p /home/android/.AndroidStudio3.5
RUN mkdir -p /home/android/Android/Sdk
ENTRYPOINT ["/home/android/android-studio/bin/studio.sh"]
