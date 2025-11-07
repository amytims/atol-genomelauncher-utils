#!/bin/bash -l
#SBATCH --job-name=Melanotaenia_RR-short-read_qc
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
/software/projects/pawsey1132/atims/.singularity/library/atol-qc-raw-shortread_0.1.7--pyhdfd78af_0.sif \
atol-qc-raw-shortread \
    --in results/raw_reads/hic/616642_FISH_BRF_232K7NLT3_AGTCGCGA-TAGACCAA_S3_R1_001.fastq.gz \
    --in2 results/raw_reads/hic/616642_FISH_BRF_232K7NLT3_AGTCGCGA-TAGACCAA_S3_R2_001.fastq.gz \
    --adaptors /usr/local/opt/bbmap-38.95-1/resources/adapters.fa \
    --out results/processed_reads/hic/616642_FISH_BRF_232K7NLT3_AGTCGCGA-TAGACCAA_S3_R1_001.trim.fastq.gz\
    --out2 results/processed_reads/hic/616642_FISH_BRF_232K7NLT3_AGTCGCGA-TAGACCAA_S3_R2_001.trim.fastq.gz\
    --stats results/qc/hic_stats.json \
    --threads 14 --logs results/qc/hic_logs
