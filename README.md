# LIFE4137-HPC_practice
Some small datasets and example job submission scripts to practice using simple commands on the HPC with.

## Part 1: job submission and monitoring

### Run through the practical as follows:

Connect to the VPN using forticlient

Login to Ada
```
ssh ada
```

Clone the github repository
```
git clone https://github.com/lldean18/LIFE4137-HPC_practice
```

Move into the repo you cloned and have a look what is in it
```
cd ~/LIFE4137-HPC_practice
ls -lh
```

Edit the file job_submission_script.bash and substitute USERNAME for your username
```
nano job_submission_script.bash
```

Submit the job submuission script
```
sbatch job_submission_script.bash
```

Check your job in the queue (substitute USERNAME for your actual username)
```
squeue -l -u USERNAME
```

After your job has completed, look at some information about how it ran
```
sacct --format="JobID,JobName,AllocCPUS,State,time,Elapsed,CPUTime,ReqMem,MaxRSS,ExitCode"
```

Key things to notice from the output of the sacct command:
- time limit vs. elapsed time (how long you gave it vs. how long it actually took)
- CPUTime is time multiplied by number of allocated CPUS (AllocCPUS)
- requested memory (ReqMem) vs. actual memory used (MaxRss)
- exit code is 0:0 if the job completed successfully (as far as slurm is concerned)

## Part 2: Interactive jobs using srun

Use this srun command to enter an interactive session
```
srun --partition defq --cpus-per-task 2 --mem 10g --time 00:20:00 --pty bash
```

Move into the repo you cloned earlier
```
cd ~/LIFE4137-HPC_practice
```

Load the software modules you will use
```
module load samtools-uoneasy/1.18-GCC-12.3.0
module load gnuplot/5.4.8-GCCcore-12.3.0
```

Plot the coverage of the data in your bam file
```
samtools coverage --histogram ~/LIFE4137-HPC_practice/stickleback.bam 
```

Create some plots for stats on your bam file
```
samtools stats stickleback.bam > stickleback_stats.txt 
plot-bamstats stickleback_stats.txt 
```

## Part 3: View your plots using an interactive VNC session in OpenOnDemand

Follow this link and login when prompted:
https://hpcondemand01.ada.nottingham.ac.uk

Click on interactive apps at the top and VNC Desktop session. Change the default memory to 5, leave everything else as the default settings and click Launch at the bottom of the page

Once resources have been allocated to your job, click Launch VNC Desktop Session

Click on the little black box in the panel at the bottom of the screen to open a terminal

Navigate to your working folder:
```
cd LIFE4137-HPC_practice
```

Open the images in a web page using the html file:
```
firefox bamstats.html
```

Move your cursor over the images to view them

## Part 4: Search for, load and unload software modules

List all available software modules
```
module avail
```

Search for a software module using a keyword e.g.
```
module avail vcftools
```

Load the module you found from your search
```
module load vcftools-uoneasy/0.1.16-GCC-12.3.0
```

Print the help message or open the manual page to check you have loaded the software:
```
vcftools --help
man vcftools
```

Unload the module e.g.
```
module load vcftools-uoneasy/0.1.16-GCC-12.3.0
```

Repeat the above steps with a different module – try e.g. bcftools, bedtools, hifiasm, python

## Part 4: Practice installing and using Conda

Download conda:
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

Run through the install:
```
bash Miniconda3-latest-Linux-x86_64.sh
```
Say yes to everything it asks you during the install process

Log out of Ada and back in again:
```
exit
ssh ada
```

Then run the following commands to configure conda:
```
conda config --set auto_activate_base false
conda config --append channels conda-forge
conda config --append channels bioconda
conda deactivate
```

Create a test conda environment, activate it and check the software is available, then deactivate it: 
```
conda create --name nanoplot nanoplot
conda activate nanoplot
NanoPlot -h
conda deactivate
```

## Part 5: Copying files to and from Ada and your local machine

Logout of Ada (scp is always run from your laptop terminal not from Ada):
```
exit
```

Copy a file from the LIFE4137-HPC_practical folder on Ada to your laptop:
```
scp ada:~/LIFE4137-HPC_practice/job_submission_script.bash ./
```

Check the file is now there on your laptop:
```
ls
```

Copy a file from your laptop to the LIFE4137-HPC_practical folder on Ada:
```
touch test_file.txt
scp test_file.txt ada:~/LIFE4137-HPC_practice/
```

Log back into Ada and check your test_file.txt is there: 
```
ssh ada
cd ~/LIFE4137-HPC_practice
ls
```

