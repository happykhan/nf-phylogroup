process CLEMONTTYPING {
    debug true
    time '1h'
    publishDir 'clemonttyping'


    input:
    tuple val(sample), file(fasta)

    script:
    """
    echo $fasta
    clermonTyping.sh --fasta $fasta --name $sample
    """
    output:
        path("$sample")

    stub:
        """
        mkdir $sample
        touch $sample/stub.txt
        """

}
