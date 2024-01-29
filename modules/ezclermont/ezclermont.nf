
process EZCLEMONT {
    debug true
    time '1h'
    publishDir 'ezclemont'


    input:
    tuple val(sample), file(fasta)

    script:
    """
    echo $fasta
    ezclemont $fasta > $sample.ezclemont.txt
    """
    output:
        path("$sample.ezclemont.txt")

    stub:
        """
        mkdir $sample
        touch $sample/stub.txt
        """

}
