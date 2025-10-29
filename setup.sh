#!/bin/bash

# Who am I assembling?
GENUS_SPECIES="g_marmoratus"

# where's its script on github?
BRANCH="g_marmoratus"

# make directory to put assembly scripts in
mkdir /home/atims/afgi_assemblies/${GENUS_SPECIES} -p

# create scratch directories
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/results -p
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/work
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs

# link to home dir
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/results /home/atims/afgi_assemblies/${GENUS_SPECIES}/results
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/work /home/atims/afgi_assemblies/${GENUS_SPECIES}/work
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs /home/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs

# pull in the script to run 
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/launcher.sh -O /home/atims/afgi_assemblies/${GENUS_SPECIES}/launcher.sh

wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/sangertol-nf.config -O /home/atims/afgi_assemblies/${GENUS_SPECIES}/sangertol-nf.config