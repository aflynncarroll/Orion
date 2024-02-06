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
# this made the environment not work

#source /home/aflynn/anaconda3/etc/profile.d/conda.sh
conda activate impute_env
# installed:
#   R
#   plink
#   python
#   crossmap

##### inputs
workdir="/home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation" 
file_loc="/geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd"
bfile_name="2020-9133.clean201112"

##### set aliases
alias liftOver=/home/aflynn/tools/liftover/liftOver
alias python2=/home/aflynn/.conda/envs/py2/bin/python2
alias bgzip=/share/apps/htslib/base/1.10.2/bin/bgzip
alias perl3=/share/apps/ActivePerl/5.28/bin/perl

cd $workdir

###### copy raw data to local directory
# cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.bed .
# cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.bim .
# cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.fam .
# ##cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.hh .
# ##cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.log .
# cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/README.2020-9133.txt .
#SNP names and marker positions were not updated; positions are on human genome build hg37 
#per Joe de Young/UNGC, as reported by Illumina's reference files.



#cd /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/

#liftOver \
#    /home/aflynn/projects/20230628_imputation_2020-9133/2020-9133.clean201112.bed \
#    /home/aflynn/tools/liftover/hg19ToHg38.over.chain.gz \
#    /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/2020-9133.clean201112.bed \
#    /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/unlifted.bed # what could not be lifted over 
# 9.1. plink QC

mkdir ${workdir}/hg19_plink

#plink2 \
#	--bfile /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112 \
#	--maf 0.01 \
#    --geno 0.05 \
#    --hwe 1e-6 \
#    --mind 0.1 \
#	--genotyping-rate \
#	--make-bed \
#    --out /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/hg19_plink/2020-9133.clean201112
#0 samples removed due to missing genotype data (--mind).
#--geno: 0 variants removed due to missing genotype data.
#Warning: --hwe observation counts vary by more than 10%. 
#--hwe: 0 variants removed due to Hardy-Weinberg exact test (founders only).
#252516 variants removed due to allele frequency threshold(s)
#408062 variants remaining after main filters.

##### copy data to local repo and remove samples with missing genotype data
plink2 \
	--bfile "$file_loc/$bfile_name" \
    --mind 0.1 \
	--genotyping-rate \
	--make-bed \
    --out "${workdir}/hg19_plink/${bfile_name}"

##### make vcf from plink bed/bim/fam for crossmap hg19 to hg38
plink \
	--bfile "${workdir}/hg19_plink/${bfile_name}"  \
	--keep-allele-order \
	--recode vcf-iid bgz \
	--out "${workdir}/${bfile_name}.hg19"
    #/home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/2020-9133.clean201112.hg19


#gzip -d /home/aflynn/tools/crossmap/Homo_sapiens.GRCh38.dna.toplevel.fa.gz

#gzip -d /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/2020-9133.clean201112.hg19.vcf.gz
mkdir ${workdir}/hg19_vcf
###### recode sex chromosome: 23 -> X
hg19_vcf="${workdir}/hg19_vcf/${bfile_name}.hg19.vcf.gz"
#"/home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/2020-9133.clean201112.hg19.vcf.gz"

#bgzip=/u/project/gandalm/shared/apps/tabix-0.2.6/bgzip
zcat $hg19_vcf | awk '{ if ($0 ~ /^#/ || $0 ~ /^23\t/) { sub(/^23\t/, "X\t", $0); print } else { print } }' | bgzip > $hg19_vcf

#zcat $hg19_vcf | awk '{ if ($0 ~ /^#/ || $0 ~ /^23\t/) { sub(/^23\t/, "X\t", $0); print } else { print } }' | bgzip > /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/2020-9133.clean201112.hg19_2.vcf.gz

mkdir ${workdir}/hg38_vcf

chain_file="/home/aflynn/tools/liftover/hg19ToHg38.over.chain.gz"
hg38_fasta="/home/aflynn/tools/crossmap/Homo_sapiens.GRCh38.dna.toplevel.fa"
hg38_vcf="${workdir}/hg38_vcf/${bfile_name}.vcf"

CrossMap.py \
    vcf \
    $chain_file \
    $hg19_vcf \
    $hg38_fasta \
    $hg38_vcf

# CrossMap.py \
#     vcf \
#     /home/aflynn/tools/liftover/hg19ToHg38.over.chain.gz \
#     /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/2020-9133.clean201112.hg19_2.vcf.gz \
#     /home/aflynn/tools/crossmap/Homo_sapiens.GRCh38.dna.toplevel.fa \
#     /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/2020-9133.clean201112_2.vcf
    #2020-9133.clean201112.hg19_2.vcf.gz to hg38_imputation/2020-9133.clean201112_2.vcf = final version
#2023-07-28 12:45:44 [INFO]  Total entries: 660578
#2023-07-28 12:45:44 [INFO]  Failed to map: 89349
#emma:
#I followed an advice in the lab that replace a line in CrossMap's code (mapvcf.py) so that CrossMap won't do unnecessary removals: "at line 155, replace the fields[3] = refFasta.fetch(target_chr,target_start,target_end).upper() with if a[1][3] == '-': fields[3] = revcomp_DNA(fields[3], True) so that all CrossMap will do is reverse complement the alleles if the strand is flipped in the new reference." With this, the failed to map SNPs became ~3K ish or less.
# anaconda3/envs/lib/python3.9/site-packages/cmmodule/mapvcf.py
# line 182
#2023-07-30 04:59:36 [INFO]  Total entries: 660578
#2023-07-30 04:59:36 [INFO]  Failed to map: 23954



# converted chr23 to x

#2023-07-30 05:08:45 [INFO]  Total entries: 660578
#2023-07-30 05:08:45 [INFO]  Failed to map: 7795
 #wget  https://ftp.ensembl.org/pub/release-76/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.toplevel.fa.gz

 #wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_44/GRCh38.primary_assembly.genome.fa.gz

mkdir ${workdir}/hg38_plink

##### convert vcf to bed and remove chromosomes not in 1-23

plink \
	--vcf $hg38_vcf \
	--keep-allele-order \
    --allow-extra-chr --chr 1-23 \
	--make-bed --out ${workdir}/hg38_plink/${bfile_name}


# plink \
# 	--vcf /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/2020-9133.clean201112_2.vcf \
# 	--keep-allele-order \
#     --allow-extra-chr --chr 1-23 \
# 	--make-bed --out /home/aflynn/projects/20230628_imputation_2020-9133/hg38_imputation/hg38_plink/2020-9133.clean201112


##### create a frequency file
bfile_in=${workdir}/hg38_plink/${bfile_name}
freq_file=${workdir}/hg38_plink/${bfile_name}
hg38_ref_tab="/home/aflynn/projects/20230628_TOPMed_Imputation_tools/ALL.TOPMed_freeze8_hg38_dbSNP.tab.gz"

plink --freq --bfile $bfile_in --out $freq_file

##### execute perl QC script
perl3 /home/aflynn/projects/20230628_TOPMed_Imputation_tools/HRC-1000G-check-bim-v4.3.0/HRC-1000G-check-bim.pl \
    -b $bfile_in.bim\
    -f $freq_file.frq \
    -r $hg38_ref_tab -n -h
# -n keeps all snps despite allele frequency differences

##### run generated script to convert to chrom bed files
bash Run-plink.sh 

mkdir ${workdir}/hg38_plink/vcf_out

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
        plink --bfile ${bed_files} --recode vcf --out ${vcf_file} 
    done
}

##### convert chrom bed files to vcfs
bed_dir="${workdir}/hg38_plink"
vcf_dir="${workdir}/hg38_plink/vcf_out"
chrom_names="${bfile_name}-updated-"
convert_bed_to_vcf $bed_dir $vcf_dir $chrom_names