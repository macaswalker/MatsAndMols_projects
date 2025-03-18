#!/bin/bash

# Loop through both temperature values (300K and 600K)
for T in 300 600; do
    for L in 130 140 150 160 170 180 190 200; do
        echo "Starting LAMMPS simulation for L=$L at T=$T..."

        docker run --rm \
            -v "$(pwd)":/data \
            -w /data \
            -e OMP_NUM_THREADS=2 \
            lammps/lammps:latest \
            mpirun -np 2 lmp_mpi -in lmp_temp_L.input -var L $L -var temp $T

        echo "Completed simulation for L=$L at T=$T."
    done
done
