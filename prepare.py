import os
import re
import subprocess
import argparse

def build_singularity_containers(config_file_path, image_dir):
    os.makedirs(image_dir, exist_ok=True)
    container_mentions = []

    with open(config_file_path, 'r') as config_file:
        for line in config_file:
            if re.search(r"container = '(\w+\/e\w+:\w+)'", line):
                container_mentions.append(line.strip())

    for mention in container_mentions:
        command = f'singularity pull {image_dir} docker://{mention}'
        subprocess.run(command, shell=True)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Build Singularity containers from config file')
    parser.add_argument('-c', '--config_file', type=str, help='Path to the config file', default='nextflow.config')
    parser.add_argument('-i', '--image_dir', type=str, help='Path to the directory to store the Singularity images', default='/well/aanensen/shared/singularity/')

    args = parser.parse_args()

    build_singularity_containers(args.config_file, args.image_dir)
