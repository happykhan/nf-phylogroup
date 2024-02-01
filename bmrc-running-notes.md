# Running nextflow on the BMRC

Compute nodes have no internet access, and no docker. You will need to set up singularity images, and install anything nextflow plugins. 

You can get your own up to date nextflow binary with:

```
wget -qO- https://get.nextflow.io | bash
```

## Building singularity containers

In the local/standard model, software will be run through docker containers but this needs to be done using singularity on an HPC. There
is a helper script `prepare.py` that will help convert the docker images to singularity images and put them in the right place. 

Basically, 

```
singularity pull {docker_image_file}.sif docker://{docker_uri} 
```

## Installing nextflow plugins (on the head node)

This will create a local cached copy of the plugins, usually in `~/.nextflow/plugins`. 
```
nextflow plugin install nf-validation@1.1.3
```

Make sure that the `nexflow.config` includes the plugin and the version number, otherwise nextflow will try to download the pipeline (which it can't).

```
plugins {
  id 'nf-validation@1.1.3'
}
```

## Interative shell 
To get an interactive shell:

```
srun  --time 2:00:00 --pty bash
```

## Doing a dry run with stub 
Check everything is installed by doing a dry-run with the `-stub` command.
```
nextflow run main.nf -profile bmrc -stub
```

