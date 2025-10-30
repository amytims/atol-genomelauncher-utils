#!/bin/bash

### pulling relevant outputs back from Acacia

#Who did we assemble?
SAMPLE_ID="MelanotaeniaRR"

#Where did we put the results?
BUCKET="pawsey1132:pawsey1132.afgi.assemblies/${SAMPLE_ID}/results/sanger_tol"

mkdir results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco -p
mkdir results/genomeassembly_outputs/01_hifiasm_assembly_summaries/merquryk
mkdir results/genomeassembly_outputs/02_scaffolding_summaries/busco -p
mkdir results/genomeassembly_outputs/02_scaffolding_summaries/merquryk -p
mkdir results/genomeassembly_outputs/03_hic_contact_maps -p

### hifiasm assembly summaries
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/${SAMPLE_ID}.asm.hic.hap1.assembly_summary results/genomeassembly_outputs/01_hifiasm_assembly_summaries/
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/${SAMPLE_ID}.asm.hic.hap2.assembly_summary results/genomeassembly_outputs/01_hifiasm_assembly_summaries/
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/${SAMPLE_ID}.asm.p_ctg.assembly_summary results/genomeassembly_outputs/01_hifiasm_assembly_summaries/

# contigs - busco summaries
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/${SAMPLE_ID}.hap1.actinopterygii_odb10.busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary_hap1.txt 
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/${SAMPLE_ID}.hap2.actinopterygii_odb10.busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary_hap2.txt 

rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/${SAMPLE_ID}.hap1.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.${SAMPLE_ID}.asm.hic.hap1.fa.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/${SAMPLE_ID}.hap2.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.${SAMPLE_ID}.asm.hic.hap2.fa.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/

rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/${SAMPLE_ID}.p_ctg.actinopterygii_odb10.busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/${SAMPLE_ID}.p_ctg.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.${SAMPLE_ID}.asm.p_ctg.fa.txt results/genomeassembly_outputs/01_hifiasm_assembly_summaries/busco/

#contigs - merquryk summaries
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/${SAMPLE_ID}.hap1.ccs.merquryk/${SAMPLE_ID}.completeness.stats results/genomeassembly_outputs/01_hifiasm_assembly_summaries/merquryk/${SAMPLE_ID}.hic.completeness.stats
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/${SAMPLE_ID}.p_ctg.ccs.merquryk/${SAMPLE_ID}.completeness.stats results/genomeassembly_outputs/01_hifiasm_assembly_summaries/merquryk/

# hic contact maps
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/${SAMPLE_ID}.FullMap.png results/genomeassembly_outputs/03_hic_contact_maps/${SAMPLE_ID}.hap1.FullMap.png
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap2/yahs/out.break.yahs/${SAMPLE_ID}.FullMap.png results/genomeassembly_outputs/03_hic_contact_maps/${SAMPLE_ID}.hap2.FullMap.png
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/${SAMPLE_ID}.FullMap.png results/genomeassembly_outputs/03_hic_contact_maps/${SAMPLE_ID}.p_ctg.FullMap.png

#scaffolding summaries
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/${SAMPLE_ID}_scaffolds_final.assembly_summary results/genomeassembly_outputs/02_scaffolding_summaries/${SAMPLE_ID}_scaffolds_final.hap1.assembly_summary
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap2/yahs/out.break.yahs/${SAMPLE_ID}_scaffolds_final.assembly_summary results/genomeassembly_outputs/02_scaffolding_summaries/${SAMPLE_ID}_scaffolds_final.hap2.assembly_summary
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/${SAMPLE_ID}_scaffolds_final.assembly_summary results/genomeassembly_outputs/02_scaffolding_summaries/${SAMPLE_ID}_scaffolds_final.p_ctg.assembly_summary

# scaffolds - busco summaries
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary_hap1.txt
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.hap1_scaffolds_final.fa.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/

rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap2/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary_hap2.txt
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap2/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.hap2_scaffolds_final.fa.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/

rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/${SAMPLE_ID}-actinopterygii_odb10-busco.batch_summary.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/out_scaffolds_final.actinopterygii_odb10.busco/short_summary.specific.actinopterygii_odb10.out_scaffolds_final.fa.txt results/genomeassembly_outputs/02_scaffolding_summaries/busco/

# scaffolds - merquryk stats
rclone copyto ${BUCKET}/${SAMPLE_ID}.hifiasm-hic.v1/scaffolding_hap1/yahs/out.break.yahs/out_scaffolds_final.ccs.merquryk/${SAMPLE_ID}.completeness.stats results/genomeassembly_outputs/02_scaffolding_summaries/merquryk/${SAMPLE_ID}.hic.completeness.stats
rclone copy ${BUCKET}/${SAMPLE_ID}.hifiasm.v1/scaffolding/yahs/out.break.yahs/out_scaffolds_final.ccs.merquryk/${SAMPLE_ID}.completeness.stats results/genomeassembly_outputs/02_scaffolding_summaries/merquryk/

# compress directory for download
tar -zcvf ${SAMPLE_ID}.tar.gz results/genomeassembly_outputs/