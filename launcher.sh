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

unset SBATCH_EXPORT

# Application specific commands:
set -eux

# sample to run - organism grouping key
SAMPLE_ID="MelanotaeniaRR"

# where to put nextflow tmpfiles
SOURCE_DIRNAME="RR_rainbow"

# params for DToL pipeline
PIPELINE_VERSION="a6f7cb6"
RESULT_DIRNAME=${SAMPLE_ID} # dataset_id for DToL pipeline - do not include underscores!
RESULT_VERSION="v1"

PIPELINE_PARAMS=(
        "--input" "results/config/config_file.yaml"
        "--outdir" "s3://pawsey1132.afgi.assemblies/${RESULT_DIRNAME}/results/sanger_tol"
        "--timestamp" "${RESULT_VERSION}"
        "--hifiasm_hic_on"
        "-profile" "singularity,pawsey"
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

# load the manual nextflow install
export PATH="${PATH}:/software/projects/pawsey1132/atims/assembly_testing/bin"
printf "nextflow: %s\n" "$( readlink -f $( which nextflow ) )"

# set the NXF home for plugins etc
export NXF_HOME="/scratch/pawsey1132/atims/afgi_assemblies/${SOURCE_DIRNAME}/.nextflow/"
export NXF_CACHE_DIR="/scratch/pawsey1132/atims/afgi_assemblies/${SOURCE_DIRNAME}/.nextflow/"
export NXF_WORK="${PWD}/work"
printf "NXF_HOME: %s\n" "${NXF_HOME}"
printf "NXF_WORK: %s\n" "${NXF_WORK}"

# download files with atol-data-mover pipeline
nextflow \
        -log "nextflow_logs/nextflow_run_atol-bpa-download.$(date +"%Y%m%d%H%M%S").${RANDOM}.log" \
        run amytims/atol-bpa-download \
        -profile pawsey \
        --sample_id ${SAMPLE_ID} \
        --use_samplesheet \
        --samplesheet ~/atol-data-mover_samplesheet_251023.csv \
        --pacbio_data \
        --hic_data \
        --bpa_api_token ${BPA_API_TOKEN}

# run pacbio QC pipeline
nextflow \
        -log "nextflow_logs/nextflow_run_atol-qc-raw-pacbio.$(date +"%Y%m%d%H%M%S").${RANDOM}.log" \
        run amytims/atol-qc-raw-pacbio \
        --plot_title "Running River Rainbowfish - Read Length Distribution" \
        -profile pawsey -resume &

# run hi-c qc
sbatch short-read-qc.sh &

# run ont qc
sbatch ont-qc.sh

exit 0

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
