 /* 
 * pipeline processes
 */
 
 /*
* should I include a summary step for centrifuge output, in case I need to remove contaminant reads?
*/
process centrifuge {

    publishDir "${params.outdir}/centrifuge", mode:'copy'
    cache 'lenient'

    input:
    path fasta
    val centrifugedb

    output:
    path "*.tsv"

    script:
    """
    centrifuge -f \
        -x ${centrifugedb} \
        --report-file centrifuge_report.tsv \
        --quiet \
        --threads ${task.cpus} \
        --min-hitlen 1000 \
        -U $fasta \
    >centrifuge_classifications.tsv
    """

}

/*
* should I just run the whole pipeline on fastas, instead of using fastqs at all?
*/
process nanoplot {

    publishDir "${params.outdir}/nanoplot", mode:'copy'
    cache 'lenient'

    input:
    path fastq

    output:
    path "nanoplot_out"

    script:
    """
    NanoPlot --fastq ${fastq} \
        --loglength \
        -o nanoplot_out \
        -t ${task.cpus}
    """

}

process shasta {

    publishDir "${params.outdir}/assembly_initial", mode:'copy'
    cache 'lenient'

    input:
    path fasta

    output:
    path "assembly"

    script:
    """
    shasta \
    --input ${fasta}  \
    --assemblyDirectory assembly \
    --Reads.minReadLength 500 \
    --memoryMode anonymous \
    --memoryBacking 4K \
    --threads 36 \
    --Assembly.detangleMethod 1
    """
}

process medaka_polish {

    publishDir "${params.outdir}", mode:'copy'
    cache 'lenient'

    input:
    path assembly_initial
    path fasta
    val medaka_model

    output:
    path "assembly_polished"

    script:
    """
    medaka_consensus \
    -i ${fasta} \
    -d ${assembly_initial}/Assembly.fasta \
    -o assembly_polished \
    -t ${task.cpus} \
    -m ${medaka_model}
    """

}

process busco_initial {

    publishDir "${params.outdir}", mode:'copy'
    label 'busco'
    cache 'lenient'

    input:
    path assembly_initial
    val augustus_config
    val busco_db
    
    output:
    path "busco_initial"

    script:
    """
    export AUGUSTUS_CONFIG_PATH=config
    cp -r ${augustus_config} config
    echo \$AUGUSTUS_CONFIG_PATH

    busco \
	-i ${assembly_initial}/Assembly.fasta \
	-o busco_initial \
	-l ${busco_db} \
	-c ${task.cpus} \
    -m genome
    """

}

process busco_polished {

    publishDir "${params.outdir}", mode:'copy'
    label 'busco'
    cache 'lenient'

    input:
    path assembly_polished
    val augustus_config
    val busco_db
    
    output:
    path "busco_polished"

    script:
    """
    export AUGUSTUS_CONFIG_PATH=config
    cp -r ${augustus_config} config
    echo \$AUGUSTUS_CONFIG_PATH

    busco \
	-i ${assembly_polished}/consensus.fasta \
	-o busco_polished \
	-l ${busco_db} \
    -c ${task.cpus} \
	-m genome
    """

}

process quast_polished {

    publishDir "${params.outdir}", mode:'copy'
    label 'quast'
    cache 'lenient'

    input:
    path assembly_polished
    
    output:
    path "quast_polished"

    script:
    """
    quast.py ${assembly_polished}/consensus.fasta \
    --threads ${task.cpus} \
    -o quast_polished
    """

}

process repeatmodeler_db {

    cache 'lenient'

    input:
    path assembly_polished
    
    output:
    path "rep_db*"

    script:
    """
    BuildDatabase -name "rep_db" -engine ncbi ${assembly_polished}/consensus.fasta
    """

}

process repeatmodeler_model {

    cache 'lenient'

    input:
    path rep_db
    
    output:
    path ""

    script:
    """
    RepeatModeler -engine ncbi -pa ${task.cpus} -database rep_db
    """

}