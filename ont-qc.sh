#!/bin/bash -l
#SBATCH --job-name=<Genus_species>-short-read_qc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=14
#SBATCH --mem=25G
#SBATCH --time=23:59:00
#SBATCH --account=pawsey1132
#SBATCH --partition=work

module load singularity/4.1.0-nohost

# where to put singularity files
if [ -z "${SINGULARITY_CACHEDIR}" ]; then
	export SINGULARITY_CACHEDIR=/software/projects/pawsey1132/atims/.singularity
	export APPTAINER_CACHEDIR="${SINGULARITY_CACHEDIR}"
fi

export NXF_APPTAINER_CACHEDIR="${SINGULARITY_CACHEDIR}/library"
export NXF_SINGULARITY_CACHEDIR="${SINGULARITY_CACHEDIR}/library"

singularity exec \
    /software/projects/pawsey1132/atims/.singularity/library/atol-qc-raw-ont_0.1.3--pyhdfd78af_0.sif \
    atol-qc-raw-ont \
        --tarfile results/raw_reads/ont/reads_in_directory.tar \
		--out results/processed_reads/ont/ont_reads.fastq.gz \
		--stats results/qc/ont_stats.json \
		--logs results/qc/ont_logs \
		--min-length 1000