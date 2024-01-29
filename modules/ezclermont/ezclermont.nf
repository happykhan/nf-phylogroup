
process EZCLERMONT {
    debug true
    time '1h'
    publishDir "${params.output_dir}/ezclermont"

    input:
    tuple val(sample), file(fasta)

    script:
    """
    ezclermont $fasta --logfile ${sample}.ezclermont.log > ${sample}.ezclermont.txt || true
    """
    output:
        path("${sample}.ezclermont.txt")
        path("${sample}.ezclermont.log")
    stub:
        """
        touch ${sample}.ezclermont.txt
        touch ${sample}.ezclermont.log
        """

}
