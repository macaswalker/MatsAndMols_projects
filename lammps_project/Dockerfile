FROM gcr.io/deepnote-200602/templates/deepnote
RUN pip install --upgrade pip
RUN pip install git+https://gitlab.com/ase/ase
RUN pip install --no-cache-dir \
    imolecule \
    spglib \
    torch \
    torchani\
    nglview \
    matplotlib \
    scipy\
    dscribe\
    statsmodels


RUN sudo apt-get update &&  sudo apt-get install -y --reinstall openmpi-bin libopenmpi-dev

ENV LAMMPS_PATH /opt/lammps
ENV PATH ${LAMMPS_PATH}/src/:${PATH}

# Build LAMMPS from github - faster and more reliable than from the website 
RUN mkdir /opt/lammps;  cd /opt/lammps ; git clone --branch stable --depth 1 https://github.com/lammps/lammps.git .


# Build `shlib` objects first so they have `-fPIC` then symlink the directory
# so they can be reused to build the binaries halving the compilation time.
# Clean up Obj files immedaitely to keep image smaller.
RUN cd /opt/lammps/src \
 && make yes-all \
 && make no-lib \
 && make no-intel \
 && make yes-python \
 && make -j4 mpi mode=shlib \
 && ln -s Obj_shared_mpi Obj_mpi \
 && make -j4 mpi \
 && make clean-all