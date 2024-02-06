#!/bin/bash
#
# Script Name: data_prep.sh
# Author: Alexander Flynn-Carroll
# Date: July 26, 2023
# Description: This does the data preparation for TOPMed imputation server
# Source: https://topmedimpute.readthedocs.io/en/latest/prepare-your-data.html
# Impute: https://imputationserver.sph.umich.edu
#

    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2013-111A.reclustered/plinkable.HM.fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2013-111A.ATN.clean170906" \

2017-9154-merge_clean181212
###### start an interactive bash session
#srun --pty --mem=32G bash

##### activate imputation environment
conda activate impute_env

##### inputs
# workdir="/home/aflynn/projects/20230801_imputation_2020-9133_v2" 
# file_loc="/geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd"
# bfile_name="2020-9133.clean201112"

##### inputs
file_loc="/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2013-111A.reclustered/plinkable.HM.fwd"
# this is directory path to the original plink files
workdir="/home/aflynn/projects/20230807_batch_imputation/2013-111A.ATN.clean170906_R2"
# this is the directory where all the files will be stored - it is a created subdirectory of 
# 2nd input
bfile_name="2013-111A.ATN.clean170906"
# name of the file: subdirectory input and output files will use this



##### create directories
mkdir ${workdir}
mkdir ${workdir}/hg19_plink
mkdir ${workdir}/hg19_vcf
mkdir ${workdir}/hg38_vcf
mkdir ${workdir}/hg38_plink
mkdir ${workdir}/hg38_upload_vcf

##### set aliases
alias liftOver=/home/aflynn/tools/liftover/liftOver
alias python2=/home/aflynn/.conda/envs/py2/bin/python2
alias bgzip=/share/apps/htslib/base/1.10.2/bin/bgzip
alias perl3=/share/apps/ActivePerl/5.28/bin/perl

cd $workdir

##### copy data to local repo and remove samples with missing genotype data
    plink2 \
        --bfile "${file_loc}/${bfile_name}" \
        --mind 0.1 \
        --genotyping-rate \
        --make-bed \
        --out "${workdir}/hg19_plink/${bfile_name}"

##### make vcf from plink bed/bim/fam for crossmap hg19 to hg38
plink \
    --bfile "${workdir}/hg19_plink/${bfile_name}"  \
    --keep-allele-order \
    --snps-only 'just-acgt' \
    --recode vcf-iid bgz \
    --out "${workdir}/hg19_vcf/${bfile_name}.hg19"
# added snps only to remove non-atgc entries

###### recode sex chromosome: 23 -> X
hg19_vcf="${workdir}/hg19_vcf/${bfile_name}.hg19.vcf.gz"
hg19_vcf_x="${workdir}/hg19_vcf/${bfile_name}.hg19_x.vcf.gz"

zcat $hg19_vcf | awk '{ if ($0 ~ /^#/ || $0 ~ /^23\t/) { sub(/^23\t/, "X\t", $0); print } else { print } }' | bgzip > ${hg19_vcf_x}

##### convert hg19 to hg38
chain_file="/home/aflynn/tools/liftover/hg19ToHg38.over.chain.gz"
hg38_fasta="/home/aflynn/tools/crossmap/Homo_sapiens.GRCh38.dna.toplevel.fa"
hg38_vcf="${workdir}/hg38_vcf/${bfile_name}.vcf"

CrossMap.py \
    vcf \
    $chain_file \
    $hg19_vcf_x \
    $hg38_fasta \
    $hg38_vcf

##### convert vcf to bed and remove chromosomes not in 1-23

plink \
    --vcf $hg38_vcf \
    --keep-allele-order \
    --allow-extra-chr --chr 1-23 \
    --make-bed --out ${workdir}/hg38_plink/${bfile_name}


##### create a frequency file for hg38 plink
bfile_in=${workdir}/hg38_plink/${bfile_name}
freq_file=${workdir}/hg38_plink/${bfile_name}


plink --freq --bfile $bfile_in --out $freq_file

##### execute perl QC script
hg38_ref_tab="/home/aflynn/projects/20230628_TOPMed_Imputation_tools/ALL.TOPMed_freeze8_hg38_dbSNP.tab.gz"

perl3 /home/aflynn/projects/20230628_TOPMed_Imputation_tools/HRC-1000G-check-bim-v4.3.0/HRC-1000G-check-bim.pl \
    -b $bfile_in.bim\
    -f $freq_file.frq \
    -r $hg38_ref_tab -n -h
# -n keeps all snps despite allele frequency differences

##### run generated script to convert to chrom bed files
bash ${workdir}/hg38_plink/Run-plink.sh 



##### function to convert chrom bed files to vcfs
convert_bed_to_vcf() {
    local bed_directory="$1"
    local vcf_directory="$2"
    local bed_name="$3"

    for ((chromosome=1; chromosome<=23; chromosome++))
    do
        bed_files="${bed_directory}/${bed_name}chr${chromosome}"
        vcf_file="${vcf_directory}/${bed_name}chr${chromosome}"
        echo ${bed_files}
        plink --bfile ${bed_files} --recode vcf --out ${vcf_file}_temp
        awk '{if($0 !~ /^#/) print "chr"$0; else print $0}' ${vcf_file}_temp.vcf | bgzip > ${vcf_file}.vcf.gz && rm ${vcf_file}_temp.vcf
        #bgzip ${vcf_file}.vcf
    done
}

##### convert chrom bed files to vcfs
bed_dir="${workdir}/hg38_plink"
vcf_dir="${workdir}/hg38_upload_vcf"
chrom_names="${bfile_name}-updated-"
convert_bed_to_vcf $bed_dir $vcf_dir $chrom_names

##### example from using the checking file
#python2 /home/aflynn/projects/20230628_TOPMed_Imputation_tools/checkVCF/checkVCF.py -r $hg38_fasta -o out /home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr1.vcf.gz