FROM ubuntu:16.04

RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:stebbins/handbrake-releases
RUN apt-get update && apt-get install -y make git mkvtoolnix handbrake-cli mplayer ffmpeg mp4v2-utils linux-headers-generic build-essential dkms

RUN mkdir /src/
WORKDIR /src

RUN git clone https://github.com/donmelton/video-transcoding-scripts
RUN mv video-transcoding-scripts/*.sh /usr/local/bin/

COPY transcoder.py /src/
RUN chmod +x transcoder.py
CMD ./transcoder.py