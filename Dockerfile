# Use an official python runtime as a parent image
FROM python:slim

LABEL maintainer="avthatte@gmail.com"

# Set the working directory to /notebooks within the container
WORKDIR /notebooks

# Set the exposed port for jupyter notebook
EXPOSE 8888

# Install pre-reqs for scipy
RUN apt-get update && apt-get install -y \
#    libopenblas-dev \
    libblas-dev \
    libatlas-dev \
    liblapack-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

#libblas-dev liblapack-dev libatlas-base-dev gfortran

# Install numpy - it is essential for scipy and a bunch of other libraries
RUN pip3 install \
    numpy \
    && rm -r /root/.cache/pip

# Install scipy - is this necessary?
RUN apt-get update && apt-get install -y \
    python3-scipy \
    && rm -rf /var/lib/apt/lists/*


# Install scipy
RUN pip3 install \
    scipy \
    && rm -r /root/.cache/pip

# Install the necessary libraries for graphviz
RUN apt-get update && apt-get install -y \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# Install other necessary python packages
RUN pip3 install \
    graphviz \
    && rm -r /root/.cache/pip

# Install other necessary python packages
RUN pip3 install \
    jupyter \
    && rm -r /root/.cache/pip

# Install other necessary python packages
RUN pip3 install \
    keras \
    && rm -r /root/.cache/pip

# Install other necessary python packages
RUN pip3 install \
    pandas \
    && rm -r /root/.cache/pip

# Install other necessary python packages
RUN pip3 install \
    pydot \
    && rm -r /root/.cache/pip

# Install other necessary python packages
RUN pip3 install \
    sklearn \
    && rm -r /root/.cache/pip

# Install the necessary libraries for matplotlib
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libpng12-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install other necessary python packages
RUN pip3 install \
    matplotlib \
    && rm -r /root/.cache/pip

# Install other necessary python packages
RUN pip3 install \
    seaborn \
    && rm -r /root/.cache/pip

# Install the necessary libraries for hdf5
RUN apt-get update && apt-get install -y \
    libhdf5-dev \
    && rm -rf /var/lib/apt/lists/*

# Install other necessary python packages
RUN pip3 install \
    h5py \
    && rm -r /root/.cache/pip

# Install other necessary python packages
RUN pip3 install \
    statsmodels \
    && rm -r /root/.cache/pip



# Install the necessary libraries for opencv
#*RUN apt-get purge \
#*    libopencv4tegra-dev \
#*    libopencv4tegra \
#*    libopencv4tegra-repo

# Install base packages for opencv
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libavcodec-dev \
    libavformat-dev \
    libgtk2.0-dev \
    libsm6 \
    libswscale-dev \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

# GStreamer support
RUN apt-get update && apt-get install -y \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    && rm -rf /var/lib/apt/lists/*

# Python support
RUN apt-get update && apt-get install -y \
    python-dev \
    python-numpy \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libdc1394-22-dev \
    && rm -rf /var/lib/apt/lists/*

# OpenGL support
RUN apt-get update && apt-get install -y \
    libgtkglext1 \
    libgtkglext1-dev \
    qtbase5-dev \
    && rm -rf /var/lib/apt/lists/*

# video4linux2 support
RUN apt-get update && apt-get install -y \
    libv4l-dev \
    v4l-utils \
    qv4l2 \
    v4l2ucp \
    && rm -rf /var/lib/apt/lists/*

# Install unzip
RUN apt-get update && apt-get install -y \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Download OpenCV source code
#* RUN git clone https://github.com/opencv/opencv.git \
RUN curl -L https://github.com/opencv/opencv/archive/3.2.0.zip -o opencv-3.2.0.zip \
    && unzip opencv-3.2.0.zip \
    && cd opencv-3.2.0

# Build OpenCV
RUN cd opencv-3.2.0 \
    && mkdir release \
    && cd release \
#*    && cmake -D WITH_CUDA=ON -D CUDA_ARCH_BIN="5.3" -D CUDA_ARCH_PTX="" -D WITH_OPENGL=ON -D WITH_LIBV4L=ON -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
    && cmake -D WITH_CUDA=ON -D CUDA_ARCH_BIN="6.2" -D CUDA_ARCH_PTX="" -D WITH_LIBV4L=ON -D CUDA_FAST_MATH=ON \
       -D CMAKE_BUILD_TYPE=RELEASE -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_INSTALL_PREFIX=/usr/local ..



# Install other necessary python packages
RUN pip3 install \
    opencv-python-aarch64 \
    && rm -r /root/.cache/pip

#*RUN pip3 install \
#!    opencv-python \
#!   tensorflow \
#*    && rm -r /root/.cache/pip

# Start jupyter notebook
CMD jupyter-notebook --ip="*" --no-browser --allow-root
