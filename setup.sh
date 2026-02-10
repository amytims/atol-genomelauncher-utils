#!/bin/bash

# Who am I assembling?
OUTDIR="" # directory name on Pawsey where everything will run from. e.g., p_mellis. 
                 # Keep separate from $BRANCH in case we need a different dirname, e.g., running from dev branch

# where's its script on github?
BRANCH="" # # github branch name, for pulling files in. e.g., p_mellis

# make directory to put assembly scripts in
mkdir /home/atims/afgi_assemblies/${OUTDIR} -p

# create scratch directories
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/results -p
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/work
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/nextflow_logs
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/.snakemake
mkdir /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/.nextflow

# link to home dir
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/results /home/atims/afgi_assemblies/${OUTDIR}/results
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/work /home/atims/afgi_assemblies/${OUTDIR}/work
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/nextflow_logs /home/atims/afgi_assemblies/${OUTDIR}/nextflow_logs
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/.snakemake /home/atims/afgi_assemblies/${OUTDIR}/.snakemake
ln -s /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/.snakemake /home/atims/afgi_assemblies/${OUTDIR}/.nextflow

# pull in the script to run 
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/launcher.sh -O /home/atims/afgi_assemblies/${OUTDIR}/launcher.sh

# pull in the short read qc script to run (comment out if not needed)
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/short-read-qc.sh -O /home/atims/afgi_assemblies/${OUTDIR}/short-read-qc.sh

# pull in ONT qc script to run (comment out if not needed)
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/ont-qc.sh -O /home/atims/afgi_assemblies/${OUTDIR}/ont-qc.sh

# pull in the sangertol config file
wget https://raw.githubusercontent.com/amytims/atol-genomelauncher-utils/refs/heads/${BRANCH}/sangertol-nf.config -O /home/atims/afgi_assemblies/${OUTDIR}/sangertol-nf.config