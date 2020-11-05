FROM gcr.io/deeplearning-platform-release/base-cu101
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg --purge packages-microsoft-prod && \
    dpkg -i packages-microsoft-prod.deb && \
    apt update -y && \
    apt install -y --reinstall openmpi-bin libopenmpi-dev libhdf5-openmpi-dev apt-transport-https && \
    apt-get install -y --no-install-recommends build-essential dotnet-sdk-3.1 powershell clang mono-complete ca-certificates curl file g++ git locales make uuid-runtime && \
    conda update --all && \
    rm -rf /var/lib/apt/lists/*
RUN conda install setuptools cmake jupyterlab sos-notebook jupyterlab-sos sos-papermill libsndfile mkl xeus=0.23.3 cling=0.6.0 clangdev=5.0 llvmdev=5 nlohmann_json cppzmq=4.3.0 xtl=0.6.9 pugixml cxxopts=2.1.1 zeromq pip && \
    export SETUPTOOLS_USE_DISTUTILS=stdlib && \
    cmake -D CMAKE_INSTALL_PREFIX=${CONDA_PREFIX} -D CMAKE_C_COMPILER=$CC -D CMAKE_CXX_COMPILER=$CXX -D CMAKE_INSTALL_LIBDIR=${CONDA_PREFIX}/lib -D DOWNLOAD_GTEST=ON && \
    make && make install && \
    pip install --no-cache-dir modin[all] wheel onnxruntime-gpu pycparser nimbusml pycuda horovod nvidia-pyindex jupyter_c_kernel hummingbird-ml fastai h2o ffmpeg chaostoolkit chaostoolkit-google-cloud-platform && \
    install_c_kernel
