#!/bin/bash
for L in 130 140 150 160 170 180 190 200; do
    echo "Starting LAMMPS simulation for L=$L..."

    docker run --rm \
        -v "$(pwd)":/data \
        -w /data \
        -e OMP_NUM_THREADS=2 \
        lammps/lammps:latest \
        mpirun -np 2 lmp_mpi -in lmp.input -var L $L

    echo "Completed simulation for L=$L."
done

echo "All LAMMPS simulations finished."

