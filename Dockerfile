FROM gcr.io/deeplearning-platform-release/base-cu101
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg --purge packages-microsoft-prod && \
    dpkg -i packages-microsoft-prod.deb && \
    apt update -y && \
    apt install -y --reinstall openmpi-bin libopenmpi-dev libhdf5-openmpi-dev apt-transport-https && \
    apt-get install -y --no-install-recommends build-essential dotnet-sdk-3.1 powershell clang mono-complete ca-certificates curl file g++ git locales make uuid-runtime && \
    conda update --all && \
    rm -rf /var/lib/apt/lists/*
RUN conda install xeus cling clangdev llvmdev nlohmann_json cppzmq xt1 pugixml cxxopts xeus-cling setuptools cmake jupyterlab sos-notebook jupyterlab-sos sos-papermill libsndfile mkl zeromq pip && \
    export SETUPTOOLS_USE_DISTUTILS=stdlib && \ 
    pip install --no-cache-dir modin[all] wheel onnxruntime-gpu pycparser nimbusml pycuda horovod nvidia-pyindex jupyter_c_kernel hummingbird-ml fastai h2o ffmpeg chaostoolkit chaostoolkit-google-cloud-platform && \
    install_c_kernel
