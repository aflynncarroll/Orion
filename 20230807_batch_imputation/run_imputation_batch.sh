
#!/bin/bash
#SBATCH --job-name=parallel_jobs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=5
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=12:00:00

# Your parallel commands

sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2013-111A.reclustered/plinkable.HM.fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2013-111A.ATN.clean170906" \
    > command_2013-111A.ATN.clean170906.log 2>&1 &
    # GRCh37
# saving the log files did not work
sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2016-9174/plinkable.HM.fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2016-9174_clean190123" \
    > command_2016-9174_clean190123.log 2>&1 &
    # GRCh37
sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2016-9174-3/plinkable.HM.fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2016-9174-3_clean190123" \
    > command_2016-9174-3_clean190123.log 2>&1 &
    # GRCh37
sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2017-9154/plinkable.HM_fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2017-9154_merge_clean190118" \
    > command_2017-9154_merge_clean190118.log 2>&1 &
    # GRCh37
sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2017-9154-RPT/plinkable.HM_fwd_re-export" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2017-9154-merge_clean181212" \
    > command_2017-9154-merge_clean181212.log 2>&1 
    # GRCh37

wait  # Wait for all background commands to finish


# /geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2010-002.reclustered/plinkable.HM.fwd/2010-002.clean101007