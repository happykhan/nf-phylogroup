# Running nextflow on the BMRC

Compute nodes have no internet access, and no docker. You will need to set up singularity images, and install anything nextflow plugins. 

Installing nextflow plugins (on the head node)
```
nextflow plugin install nf-validation
```


To get an interactive shell:

```
srun  --time 2:00:00 --pty bash
```

Check everything is installed by doing a dry-run with the `-stub` command.
```
nextflow run main.nf -profile bmrc -stub
```

