#!/bin/bash
# file intended for running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=1g
#SBATCH --time=00:05:00
#SBATCH --job-name=bam2fqzip
#SBATCH --output=/gpfs01/home/USERNAME/LIFE4137-HPC_practice/slurm-%x-%j.out

# load software modules
module load samtools-uoneasy/1.18-GCC-12.3.0

# set variables
bam=~/LIFE4137-HPC_practice/stickleback.bam

# index the bam file
samtools index $bam

# convert the bam file to fastq format
# -O output qulaity tags if they exist
# -t output RG, BC and QT tags to the FASTQ header line
# then pipe to gzip to compress the fastq file
samtools bam2fq \
-O \
-t \
--threads 4 \
$bam | gzip > ${bam%.*}.fastq.gz

# unload modules
module unload samtools-uoneasy/1.18-GCC-12.3.0
