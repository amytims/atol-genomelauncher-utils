#!/bin/bash

# Who am I assembling?
GENUS_SPECIES=""

# make directory to put assembly scripts in
mkdir /home/atims/afgi_assemblies/${GENUS_SPECIES}

# create scratch directories
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/results
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/work
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs

# link to home dir
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/results /home/atims/afgi_assemblies/${GENUS_SPECIES}/results
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/work /home/atims/afgi_assemblies/${GENUS_SPECIES}/work
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs /home/atims/afgi_assemblies/${GENUS_SPECIES}/nextflow_logs

# pull in the script to run 
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils /scratch/pawsey1132/atims/afgi_assemblies/${GENUS_SPECIES}/launcher.sh