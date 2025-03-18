#!/bin/bash

echo "Starting LAMMPS simulation..."

docker run --rm \
    -v "$(pwd)":/data \
    -w /data \
    -e OMP_NUM_THREADS=2 \
    lammps/lammps:latest \
    mpirun -np 2 lmp_mpi -in lmp.input

echo "Completed LAMMPS simulation."

