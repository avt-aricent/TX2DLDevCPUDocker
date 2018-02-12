# Use an official python runtime as a parent image
FROM python:slim

LABEL maintainer="avthatte@gmail.com"

# Set the working directory to /notebooks within the container
WORKDIR /notebooks

# Set the exposed port for jupyter notebook
EXPOSE 8888

# Install the necessary libraries for graphviz
RUN apt-get update && apt-get install -y \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# Install the necessary libraries for opencv
RUN apt-get update && apt-get install -y \
    libgtk2.0-dev \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

# Install the necessary python libraries
RUN pip3 install \
    graphviz \
    h5py \
    jupyter \
    keras \
    matplotlib \
    numpy \
    opencv-python \
    pandas \
    pydot \
    scipy \
    seaborn \
    sklearn \
    statsmodels \
    tensorflow \
    && rm -r /root/.cache/pip

# Install necessary libraries for Mask R-CNN
RUN pip3 install \
    scikit-image \
    Cython \
    && rm -r /root/.cache/pip

# Install necessary libraries to build pycocotools
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN cd $WORKDIR \
    && git clone https://github.com/waleedka/coco \
    && cd coco/PythonAPI \
    && make \
    && make install \
    && python3 setup.py install

# Start jupyter notebook
CMD jupyter-notebook --ip="*" --no-browser --allow-root
