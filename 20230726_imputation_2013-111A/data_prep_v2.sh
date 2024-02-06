#!/bin/bash
#
# Script Name: data_prep.sh
# Author: Alexander Flynn-Carroll
# Date: July 26, 2023
# Description: This does the data preparation for TOPMed imputation server
# Source: https://topmedimpute.readthedocs.io/en/latest/prepare-your-data.html
# Impute: https://imputationserver.sph.umich.edu
#


###### start an interactive bash session
srun --pty --mem=32G bash


#alias conda=/home/aflynn/anaconda3/bin/conda

#source /home/aflynn/anaconda3/etc/profile.d/conda.sh
conda activate impute_env
# installed:
#   R
#   plink

# go to imputation directory
cd /home/aflynn/projects/20230726_imputation_2013-111A

###### copy raw data to local directory
cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.bed .
cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.bim .
cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.fam .
##cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.hh .
##cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.log .
cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/README.2020-9133.txt .