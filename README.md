# nf-phylotyping 

This is a Nextflow pipeline for phylotyping *E. coli*, and for testing different tools for that purpose. 

*E. coli* phylogroups are a classification system used to categorize different strains of *Escherichia coli* (*E. coli*) bacteria based on their genetic relatedness using a set of fixed markers. Phylogroups provide insights into the evolutionary relationships and genetic diversity among *E. coli* strains.

There are currently six recognized phylogroups, labeled A, B1, B2, C, D, and E. Each phylogroup represents a distinct lineage of *E. coli* strains that share common genetic characteristics. These characteristics are determined by analyzing specific genetic markers or genes present in the bacterial genome.


## Installation

To install and set up the pipeline, follow these steps:

1. Install Nextflow by following the instructions provided in the [Nextflow documentation](https://www.nextflow.io/docs/latest/getstarted.html).

2. Clone the repository:

    ```bash
    git clone https://github.com/nfareed/nf-phylotyping.git
    ```

3. Change into the cloned directory:

    ```bash
    cd nf-phylotyping
    ```

4. Run the pipeline using Nextflow:

    ```bash
    nextflow run main.nf
    ```
