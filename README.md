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
