FROM ubuntu:latest
MAINTAINER Marcos Balsamo/ Anderson Davi  <suporte.foz@gmail.com>


WORKDIR /opt/
RUN apt-get update && apt-get -y --no-install-recommends install \
                                libmodbus5 liblog4cxx10v5 \
                                libboost-regex1.58.0 libboost-system1.58.0 \
                                libboost-program-options1.58.0 libboost-thread1.58.0 \
                                libboost-filesystem1.58.0 libpthread-workqueue0 \
                                libssl1.0.0 libcpprest2.8 git cmake make autotools-dev build-essential \
                                libcrypto++-dev libssl-dev libboost-all-dev




RUN git config --global http.sslVerify false && \
    git clone https://github.com/Microsoft/cpprestsdk.git cpprestsdk
RUN mkdir cpprestsdk/Release/build/
RUN cd cpprestsdk/Release/build/ && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make && \
    make install
RUN echo "/usr/local/lib" >> /etc/ld.so.conf
RUN ldconfig


RUN apt-get remove -y git cmake make libcrypto++-dev libssl-dev libboost-all-dev &&\
    apt-get autoremove -y && \
    apt-get clean && rm -r /var/lib/apt/lists/*
