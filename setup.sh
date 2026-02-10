#!/bin/bash

# Who am I assembling?
OUTPUT_DIRECTORY="PseudomugilHalophilus3240756" # directory name on Pawsey where everything will run from

# where's its script on github?
BRANCH="p_halophilus" # github branch name

# make directory to put assembly scripts in
mkdir /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY} -p

# create scratch directories
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/results -p
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/work
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/nextflow_logs
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/.snakemake

# link to home dir
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/results /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/results
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/work /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/work
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/nextflow_logs /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/nextflow_logs
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/.snakemake /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/.snakemake

# pull in the script to run 
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/launcher.sh -O /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/launcher.sh

# pull in the short read qc script to run (comment out if not needed)
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/short-read-qc.sh -O /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/short-read-qc.sh

# pull in ONT qc script to run (comment out if not needed)
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/ont-qc.sh -O /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/ont-qc.sh

# pull in the sangertol config file
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/sangertol-nf.config -O /home/atims/afgi_assemblies/${OUTPUT_DIRECTORY}/sangertol-nf.config