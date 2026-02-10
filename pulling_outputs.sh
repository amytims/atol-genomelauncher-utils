#!/bin/bash

### pulling relevant outputs back from Acacia

#Who did we assemble?
TOLID="" # tolid? whatever we end up naming the directory on Acacia

# where is our results folder on /scratch? - MUST MATCH $OUTDIR in setup.sh
OUTDIR="" # e.g., p_mellis

# Where did we put the results on Acacia?
BUCKET="pawsey1132:pawsey1132.afgi.assemblies/${TOLID}/results/sanger_tol"

# Go to results dir on Pawsey
cd /scratch/pawsey1132/atims/afgi_assemblies/${OUTDIR}/

# make subdirectories for relevant results
mkdir results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco -p
mkdir results/genomeassembly_outputs/01_hifiasm_assembly_summaries/merquryk
mkdir results/genomeassembly_outputs/02_scaffolding_summaries/busco -p
mkdir results/genomeassembly_outputs/02_scaffolding_summaries/merquryk -p
mkdir results/genomeassembly_outputs/03_hic_contact_maps -p

################################################################################
### THESE FILE PATHS WILL NEED EDITING ONCE WE HAVE THE NEW PIPELINE VERSION ###
################################################################################

### hifiasm assembly summaries
rclone copy ${BUCKET}/${TOLID}.hifiasm-hic.v1/${TOLID}.asm.hic.hap1.assembly_summary results/genomeassembly_outputs/01_hifiasm_assembly_summaries/
rclone copy ${BUCKET}/${TOLID}.hifiasm-hic.v1/${TOLID}.asm.hic.hap2.assembly_summary results/genomeassembly_outputs/01_hifiasm_assembly_summaries/
rclone copy ${BUCKET}/${TOLID}.hifiasm.v1/${TOLID}.asm.p_ctg.assembly_summary results/genomeassembly_outputs/01_hifiasm_assembly_summaries/

# contigs - busco summaries
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/${TOLID}.hap1.actinopterygii_odb10.busco/${TOLID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/${TOLID}-actinopterygii_odb10-busco.batch_summary_hap1.txt 
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/${TOLID}.hap2.actinopterygii_odb10.busco/${TOLID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/${TOLID}-actinopterygii_odb10-busco.batch_summary_hap2.txt 

rclone copy ${BUCKET}/${TOLID}.hifiasm-hic.v1/${TOLID}.hap1.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.${TOLID}.asm.hic.hap1.fa.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/
rclone copy ${BUCKET}/${TOLID}.hifiasm-hic.v1/${TOLID}.hap2.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.${TOLID}.asm.hic.hap2.fa.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/

rclone copy ${BUCKET}/${TOLID}.hifiasm.v1/${TOLID}.p_ctg.actinopterygii_odb10.busco/${TOLID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/
rclone copy ${BUCKET}/${TOLID}.hifiasm.v1/${TOLID}.p_ctg.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.${TOLID}.asm.p_ctg.fa.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/

#contigs - merquryk summaries
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/${TOLID}.hap1.ccs.merquryk/${TOLID}.completeness.stats results/genomeassembly_outputs/01_hifiasm_assembly_summaries/merquryk/${TOLID}.hic.completeness.stats
rclone copy ${BUCKET}/${TOLID}.hifiasm.v1/${TOLID}.p_ctg.ccs.merquryk/${TOLID}.completeness.stats results/genomeassembly_outputs/01_hifiasm_assembly_summaries/merquryk/

# hic contact maps
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/${TOLID}.FullMap.png results/genomeassembly_outputs/03_hic_contact_maps/${TOLID}.hap1.FullMap.png
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap2/yahs/out.break.yahs/${TOLID}.FullMap.png results/genomeassembly_outputs/03_hic_contact_maps/${TOLID}.hap2.FullMap.png
rclone copyto ${BUCKET}/${TOLID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/${TOLID}.FullMap.png results/genomeassembly_outputs/03_hic_contact_maps/${TOLID}.p_ctg.FullMap.png

#scaffolding summaries
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/${TOLID}_scaffolds_final.assembly_summary results/genomeassembly_outputs/02_scaffolding_summaries/${TOLID}_scaffolds_final.hap1.assembly_summary
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap2/yahs/out.break.yahs/${TOLID}_scaffolds_final.assembly_summary results/genomeassembly_outputs/02_scaffolding_summaries/${TOLID}_scaffolds_final.hap2.assembly_summary
rclone copyto ${BUCKET}/${TOLID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/${TOLID}_scaffolds_final.assembly_summary results/genomeassembly_outputs/02_scaffolding_summaries/${TOLID}_scaffolds_final.p_ctg.assembly_summary

# scaffolds - busco summaries
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/${TOLID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/${TOLID}-actinopterygii_odb10-busco.batch_summary_hap1.txt
rclone copy ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.hap1_scaffolds_final.fa.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/

rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap2/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/${TOLID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/${TOLID}-actinopterygii_odb10-busco.batch_summary_hap2.txt
rclone copy ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap2/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.hap2_scaffolds_final.fa.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/

rclone copy ${BUCKET}/${TOLID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/${TOLID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/
rclone copy ${BUCKET}/${TOLID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.out_scaffolds_final.fa.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/

# scaffolds - merquryk stats
rclone copyto ${BUCKET}/${TOLID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/out_scaffolds_final.ccs.merquryk/${TOLID}.completeness.stats results/genomeassembly_outputs/02_scaffolding_summaries/merquryk/${TOLID}.hic.completeness.stats
rclone copy ${BUCKET}/${TOLID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/out_scaffolds_final.ccs.merquryk/${TOLID}.completeness.stats results/genomeassembly_outputs/02_scaffolding_summaries/merquryk/

# compress directory for download
tar -zcvf ${TOLID}.tar.gz results/genomeassembly_outputs/