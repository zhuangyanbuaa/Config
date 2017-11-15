FROM ubuntu:14.04
LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +2 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64 /" > /etc/apt/sources.list.d/cuda.list

ENV CUDA_VERSION 8.0.61

ENV CUDA_PKG_VERSION 8-0=$CUDA_VERSION-1
RUN apt-get update && apt-get install -y --no-install-recommends \
        libssl-dev \
        make build-essential libssl-dev zlib1g-dev libbz2-dev libsqlite3-dev \
        git vim python wget \
        cuda-nvrtc-$CUDA_PKG_VERSION \
        cuda-nvgraph-$CUDA_PKG_VERSION \
        cuda-cusolver-$CUDA_PKG_VERSION \
        cuda-cublas-8-0=8.0.61.2-1 \
        cuda-cufft-$CUDA_PKG_VERSION \
        cuda-curand-$CUDA_PKG_VERSION \
        cuda-cusparse-$CUDA_PKG_VERSION \
        cuda-npp-$CUDA_PKG_VERSION \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-8.0 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda

#create user 
RUN useradd -g users -G users wchen -u 18998 &&\
    echo "wchen ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers &&\
    echo "su - wchen" >> /root/.bashrc

#install pyenv
RUN cd ~ &&\
    git clone git://github.com/yyuu/pyenv.git .pyenv &&\
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile &&\
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile &&\
    echo 'eval "$(pyenv init -)"' >> ~/.bash_profile &&\
    git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

#install cudnn
ENV CUDNN_TAR_FILE cudnn-8.0-linux-x64-v6.0.tgz
RUN cd ~ &&\
    mkdir cudnn &&\
    cd cudnn &&\ 
    wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/$CUDNN_TAR_FILE &&\
    tar -xzvf $CUDNN_TAR_FILE &&\
    sudo cp -P cuda/include/cudnn.h /usr/local/cuda-8.0/include &&\
    sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-8.0/lib64/ &&\
    sudo chmod a+r /usr/local/cuda-8.0/lib64/libcudnn*

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=8.0"
