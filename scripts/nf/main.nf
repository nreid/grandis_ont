/* 
 * F. grandis genome assembly
 * Author: Noah Reid
 */ 

 /* 
 * pipeline input parameters 
 */
params.fasta           = "../../results/fastas/male.test.fasta"
params.fastq           = "../../results/fastqs/male.test.fastq.gz"
params.outdir          = "../../results/nf"
params.centrifugedb    = "/isg/shared/databases/centrifuge/b+a+v+h/p_compressed+h+v"
params.medaka_model    = "r941_prom_high_g303"
params.busco_db        = "/isg/shared/databases/BUSCO/odb10/lineages/actinopterygii_odb10"
params.augustus_config = "/isg/shared/apps/augustus/3.2.3/config"

log.info """\
         F. GRANDIS GENOME   P I P E L I N E    
         ===================================
         fasta reads  : ${params.fasta}
         fastq reads  : ${params.fastq}
         outdir       : ${params.outdir}
         centrifuge db: ${params.centrifugedb}
         medaka model : ${params.medaka_model}
         """
         .stripIndent()

include { centrifuge; nanoplot; shasta; medaka_polish; busco_initial; busco_polished; quast_polished } from './tasks.nf'

workflow assembly {
    main:
        centrifuge(params.fasta, params.centrifugedb)
        nanoplot(params.fastq)
        shasta(params.fasta)
        medaka_polish(shasta.out, params.fasta, params.medaka_model)
        busco_initial(shasta.out, params.augustus_config, params.busco_db)
        busco_polished(medaka_polish.out, params.augustus_config, params.busco_db)
        quast_polished(medaka_polish.out)
    emit:
        assembly = medaka_polish.out
}

workflow {

    assembly()

}