
#!/bin/bash
#SBATCH --job-name=parallel_jobs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=5
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=12:00:00

# Your parallel commands

#--2020-9133 and 2022-9163 and --2011-158 

# DID THESE RUN CORRECTLY WITH THE ADDITIONAL SLASH? - line 2 of input
sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2011-158/2011-158.HM/plinkable.HM.fwd/" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2011-158.clean230815" &

# GRCh37

sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2020-9133.clean201112" &
# rs11260562  

# GRCh37

# sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
#     "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2010-002.reclustered/plinkable.HM.fwd" \
#     "/home/aflynn/projects/20230807_batch_imputation" \
#     "2010-002.clean101007"




sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4_hg18.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2010-002.reclustered/plinkable.HM.fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2010-002.clean101007"
# hg 18
    

#/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2011-158/2011-158.HM/plinkable.HM.fwd

sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2013-438/2013-438.HM/plinkable.HM.fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2013-438.clean230817" 

# GRCh37


sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4_hg38.sh \
    "/home/aflynn/projects/20230807_batch_imputation/2022-9163_data/2022-9163_Geschwind_GSAMD/plinkable.HM.fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2022-9163.clean230801" 
# GRCh38

# the directory name was throwing too many errors so I just copied it then renamed the copy 
# "/geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2022-9163\ Geschwind\ GSAMD/plinkable.HM.fwd" \