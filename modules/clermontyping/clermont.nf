process CLEMONTTYPING {
    debug true
    time '1h'
    publishDir "${params.output_dir}/clemonttyping"


    input:
    tuple val(sample), file(fasta)

    script:
    """
    clermonTyping.sh --fasta $fasta --name $sample
    """
    output:
        path("$sample")

    stub:
        """
        mkdir $sample
        touch $sample/${sample}-stub.txt
        """

}
