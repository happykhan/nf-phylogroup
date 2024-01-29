#!/usr/bin/env nextflow

// Importing required functions from 'plugin/nf-validation'
include { validateParameters; paramsHelp; paramsSummaryLog; } from 'plugin/nf-validation'

// Importing CLEMONTTYPING1 module from './modules/clemontABN/clemont'
include { CLEMONTTYPING1 } from './modules/clemontABN/clemont'

// Importing CLEMONTTYPING2 module from './modules/clemontIAME/clemont'
include { CLEMONTTYPING2 } from './modules/clemontIAME/clemont'

// Setting the default value for params.help
params.help = false

// Checking if params.help is true
if (params.help) {
    // Displaying help message using paramsHelp function
    log.info paramsHelp("nextflow main.nf --index sample_data.csv -with-trace -with-report")
    exit 0
}

// Setting the default value for params.index
params.index = "sample_data.csv"

// Validating the parameters
validateParameters()

// Logging the summary of the parameters
log.info paramsSummaryLog(workflow)

process SECOND {
    debug true

    input:
    tuple val(sample), file(fasta)

    script:
    """
    echo $fasta
    """

}



// Defining the workflow
workflow {
    // Creating a channel from the file specified in params.index
    FASTA = Channel.fromPath(params.index) \
        // Splitting the CSV file into rows with headers
        | splitCsv(header:true) \
        // Mapping each row to a tuple with sample and fasta file
        | map { row-> tuple(row.sample, file(row.fasta)) } 

    // Running the CLEMONTTYPING1 module
    CLEMONTTYPING( FASTA )
    EZCLERMONT( FASTA )
}
