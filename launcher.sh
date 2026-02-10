#!/bin/bash -l
#SBATCH --job-name=atol-launcher-test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4g
#SBATCH --time=1-00
#SBATCH --account=pawsey1132
#SBATCH --partition=work

module load singularity/4.1.0-nohost
module load nextflow/25.04.6

unset SBATCH_EXPORT

# Application specific commands:
set -eux

# yaml file to use - this will be the output of a datamapper query
YAML=""

# sample to run - tolid of assembly
TOLID="" # e.g., fPseMel1

# Where did we set up those directories in the setup.sh script?
OUTDIR="" # e.g., p_mellis

# params for DToL pipeline
PIPELINE_VERSION="v0.50.0"
RESULT_DIRNAME=${TOLID} # dataset_id for DToL pipeline - do not include underscores!

RESULT_VERSION="v1" # <<<<< unsure if needed? Take a look

PIPELINE_PARAMS=(
        "--input" "config/config_file.yaml"
        "--outdir" "s3://pawsey1132.afgi.assemblies/${TOLID}/results/sanger_tol"
        "-profile" "singularity,pawsey"
        "--enable-hic-phasing"
        "-r" "${PIPELINE_VERSION}"
        "-c" "sangertol-nf.config"
)

# where to put singularity files
if [ -z "${SINGULARITY_CACHEDIR}" ]; then
	export SINGULARITY_CACHEDIR=/software/projects/pawsey1132/atims/.singularity
	export APPTAINER_CACHEDIR="${SINGULARITY_CACHEDIR}"
fi

export NXF_APPTAINER_CACHEDIR="${SINGULARITY_CACHEDIR}/library"
export NXF_SINGULARITY_CACHEDIR="${SINGULARITY_CACHEDIR}/library"

# load the manual nextflow install if not using a module version
#export PATH="${PATH}:/software/projects/pawsey1132/atims/assembly_testing/bin"
#printf "nextflow: %s\n" "$( readlink -f $( which nextflow ) )"

# set the NXF home for plugins etc
export NXF_HOME="/scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/.nextflow/"
export NXF_CACHE_DIR="/scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/.nextflow/"
export NXF_WORK="/scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/work"
printf "NXF_HOME: %s\n" "${NXF_HOME}"
printf "NXF_WORK: %s\n" "${NXF_WORK}"

# download files with atol-bpa-download pipeline
nextflow \
        -log "nextflow_logs/nextflow_run_atol-bpa-download.$(date +"%Y%m%d%H%M%S").${RANDOM}.log" \
        run amytims/atol-bpa-download \
        -r dev \
        --yaml ${YAML} \
        --bpa_api_token ${CKAN_API_TOKEN} \
        --pacbio_data --hic_data \
        --dry_run false

exit 0

# run pacbio QC pipeline
nextflow \
        -log "nextflow_logs/nextflow_run_atol-qc-raw-pacbio.$(date +"%Y%m%d%H%M%S").${RANDOM}.log" \
        run amytims/atol-qc-raw-pacbio \
        -r dev \
        -profile pawsey \
        --yaml ${YAML} 

exit 0

# run hi-c qc
# >!make sure you've fixed the file paths before running this, cos you keep overwriting your old dat by accident...!<
#sbatch short-read-qc.sh

#exit 0

# run ont qc
#sbatch ont-qc.sh

#exit 0

# >>> FIX THE BELOW WHEN atol-genomeassembly-inputs IS WORKING <<<

# run read concatenation and config creation
nextflow \
        -log "nextflow_logs/nextflow_run_atol-genomeassembly-inputs.$(date +"%Y%m%d%H%M%S").${RANDOM}.log" \
        run \
        amytims/atol-genomeassembly-inputs \
        -profile pawsey \
        --pacbio_reads ./results/processed_reads/hifi \
        --hic_reads ./results/processed_reads/hic \
        --outdir s3://pawsey1132.afgi.assemblies/${SAMPLE_ID}/results \
        --sample_id ${SAMPLE_ID} -r v0.1 -resume
exit 0

# check sangertol assembly pipeline before running
nextflow \
        -log "nextflow_logs/nextflow_inspect_genomeassembly.$(date +"%Y%m%d%H%M%S").${RANDOM}.log" \
        inspect \
        -concretize sanger-tol/genomeassembly \
        "${PIPELINE_PARAMS[@]}"
exit 0
 
# run sangertol assembly pipeline
nextflow \
        -log "nextflow_logs/nextflow_run_genomeassembly.$(date +"%Y%m%d%H%M%S").${RANDOM}.log" \
        run \
        sanger-tol/genomeassembly \
        "${PIPELINE_PARAMS[@]}" \
        -resume
