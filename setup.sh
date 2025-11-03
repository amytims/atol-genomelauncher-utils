#!/bin/bash

# Who am I assembling?
GENUS_SPECIES="p_obbesi"

# where's its script on github?
BRANCH="p_obbesi"

# make directory to put assembly scripts in
mkdir /home/atims/afgi_assemblies/${GENUS_SPECIES} -p

# create scratch directories
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/results -p
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/work
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/.snakemake

# link to home dir
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/results /home/atims/afgi_assemblies/${GENUS_SPECIES}/results
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/work /home/atims/afgi_assemblies/${GENUS_SPECIES}/work
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs /home/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/.snakemake /home/atims/afgi_assemblies/${GENUS_SPECIES}/.snakemake

# pull in the script to run 
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/launcher.sh -O /home/atims/afgi_assemblies/${GENUS_SPECIES}/launcher.sh

# pull in the short read qc script to run (comment out if not needed)
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/short-read-qc.sh -O /home/atims/afgi_assemblies/${GENUS_SPECIES}/short-read-qc.sh

# pull in ONT qc script to run (comment out if not needed)
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/ont-qc.sh -O /home/atims/afgi_assemblies/${GENUS_SPECIES}/ont-qc.sh

# pull in the sangertol config file
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/sangertol-nf.config -O /home/atims/afgi_assemblies/${GENUS_SPECIES}/sangertol-nf.config