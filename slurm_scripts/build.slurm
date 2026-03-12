#!/bin/bash
#SBATCH -J singularity-build-laif-te-fa
#SBATCH -A project_462000963
#SBATCH -c 56
#SBATCH --mem=480G
#SBATCH -p dev-g
#SBATCH -t 02:00:00
#SBATCH -o logs/%x-%j.log

#TODO: Add a symbolic link to the latest build's log

set -eox pipefail


#MODULES
module purge 
module load LUMI partition/G #Get access to system tools module
module load systools #Get access to proot, which is like a fakeroot

#Singularity will refuse to build on compute nodes without these cache directories set
export SINGULARITY_TMPDIR=/tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER

#$1 Name for the .sif file that you WILL build
#$2 Path of the .def file you're building from
#$3 Job name-$SLURM_JOB_ID
time srun --label singularity build $1 $2
