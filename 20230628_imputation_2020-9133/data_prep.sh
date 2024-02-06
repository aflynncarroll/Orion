#!/bin/bash
#
# Script Name: data_prep.sh
# Author: Alexander Flynn-Carroll
# Date: June 28, 2023
# Description: This does the data preparation for 
# Source: https://topmedimpute.readthedocs.io/en/latest/prepare-your-data.html
# Impute: https://imputationserver.sph.umich.edu
#

####### download required tools
# tools in: /home/aflynn/projects/20230628_TOPMed_Imputation_tools

# wget http://www.well.ox.ac.uk/~wrayner/tools/HRC-1000G-check-bim-v4.2.7.zip
# wget ftp://ngs.sanger.ac.uk/production/hrc/HRC.r1-1/HRC.r1-1.GRCh37.wgs.mac5.sites.tab.gz
# git clone https://github.com/zhanxw/checkVCF.git

# unzip HRC-1000G-check-bim-v4.2.7.zip 
# rm HRC-1000G-check-bim-v4.2.7.zip
# gzip -d HRC.r1-1.GRCh37.wgs.mac5.sites.tab.gz 


###### start an interactive bash session
srun --pty --mem=32G bash


###### difine alii for required software
alias plink=/share/apps/plink/1.90b6.18/plink
alias bcftools=/share/apps/bcftools/base/1.10.2/bin/bcftools
alias bedtools=/share/apps/bedtools/2.29.2/bin/bedtools
alias perl2=/share/apps/perl/brew/perls/perl-5.14.2/bin/perl
alias perl3=/share/apps/ActivePerl/5.28/bin/perl
alias cpan=/share/apps/ActivePerl/5.28/bin/cpan
#alias perl=/share/apps/perl/brew/build/perl-5.14.2/perl-5.14.2/perl
#alias python=/share/apps/anaconda3/2020.07/bin/python3.8
#alias conda=/share/apps/anaconda3/2020.07/bin/conda
alias conda=/home/aflynn/anaconda3/bin/conda
alias R=/share/apps/R/base/4.1.2/bin/R
alias bgzip=/share/apps/htslib/base/1.10.2/bin/bgzip
alias unzip=/home/aflynn/anaconda3/bin/unzip
# r packages:
#‘/tmp/RtmpKEtWKS/downloaded_packages’

# create a python2 environement
#conda create --name py2 python=2.7

conda activate py2
conda deactivate
alias python2=/home/aflynn/.conda/envs/py2/bin/python2


source /home/aflynn/anaconda3/bin/activate
conda create --name impute_env
conda activate impute_env
alias 7z=/home/aflynn/anaconda3/envs/impute_env/bin/7z

###### copy raw data to local directory
cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.bed .
cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.bim .
cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.fam .
##cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.hh .
##cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112.log .
cp /geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/README.2020-9133.txt .
#SNP names and marker positions were not updated; positions are on human genome build hg37 
#per Joe de Young/UNGC, as reported by Illumina's reference files.


##### set file locations to use
bfile_in=/geschwindlabshares/HumanGenotypeArray/G-ACE.Illumina.GSA/2020-9133/plinkable.HM.fwd/2020-9133.clean201112
freq_file=/home/aflynn/projects/20230628_imputation_2020-9133/2020-9133.clean201112

##### convert ped/map to bed
#plink --file <input-file> --make-bed --out <output-file>

##### create a frequency file
plink --freq --bfile $bfile_in --out $freq_file
# 48 people (19 males, 29 females)
# sex chroms included

##### execute script
perl3 /home/aflynn/projects/20230628_TOPMed_Imputation_tools/HRC-1000G-check-bim.pl \
    -b $bfile_in.bim\
    -f $freq_file.frq \
    -r /home/aflynn/projects/20230628_TOPMed_Imputation_tools/ALL.TOPMed_freeze8_hg38_dbSNP.tab.gz -h
    #-r /home/aflynn/projects/20230628_TOPMed_Imputation_tools/HRC.r1-1.GRCh37.wgs.mac5.sites.tab -h

# Position Matches
#  ID matches HRC 282035
#  ID Doesn't match HRC 309532
#  Total Position Matches 591567
# ID Match
#  Different position to HRC 188
# No Match to HRC 62949
# Skipped (X, XY, Y, MT) 1630
# Total in bim file 660578
# Total processed 656334

# Indels (ignored in r1) 3813

# SNPs not changed 64599
# SNPs to change ref alt 363201
# Strand ok 404869
# Total Strand ok 427800

# Strand to change 36442
# Total checked 591755
# Total checked Strand 441311
# Total removed for allele Frequency diff > 0.2 30169
# Palindromic SNPs with Freq > 0.4 348


# Non Matching alleles 150096
# ID and allele mismatching 125188; where HRC is . 773
# Duplicates removed 431

sh Run-plink.sh # created from the previous step
# I added the paths above to where I assume this is calling from - the downloaded tools

##### this was copied out of Run-plink.sh
# the plink alias is not passed to the script?
#mod the file to add the alias call - ?
plink --bfile 2020-9133.clean201112 --exclude Exclude-2020-9133.clean201112-HRC.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-map Chromosome-2020-9133.clean201112-HRC.txt --update-chr --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-2020-9133.clean201112-HRC.txt --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-2020-9133.clean201112-HRC.txt --make-bed --out TEMP4
plink --bfile TEMP4 --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --out 2020-9133.clean201112-updated
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 1 --out 2020-9133.clean201112-updated-chr1
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 2 --out 2020-9133.clean201112-updated-chr2
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 3 --out 2020-9133.clean201112-updated-chr3
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 4 --out 2020-9133.clean201112-updated-chr4
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 5 --out 2020-9133.clean201112-updated-chr5
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 6 --out 2020-9133.clean201112-updated-chr6
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 7 --out 2020-9133.clean201112-updated-chr7
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 8 --out 2020-9133.clean201112-updated-chr8
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 9 --out 2020-9133.clean201112-updated-chr9
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 10 --out 2020-9133.clean201112-updated-chr10
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 11 --out 2020-9133.clean201112-updated-chr11
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 12 --out 2020-9133.clean201112-updated-chr12
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 13 --out 2020-9133.clean201112-updated-chr13
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 14 --out 2020-9133.clean201112-updated-chr14
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 15 --out 2020-9133.clean201112-updated-chr15
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 16 --out 2020-9133.clean201112-updated-chr16
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 17 --out 2020-9133.clean201112-updated-chr17
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 18 --out 2020-9133.clean201112-updated-chr18
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 19 --out 2020-9133.clean201112-updated-chr19
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 20 --out 2020-9133.clean201112-updated-chr20
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 21 --out 2020-9133.clean201112-updated-chr21
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 22 --out 2020-9133.clean201112-updated-chr22
plink --bfile 2020-9133.clean201112-updated --reference-allele Force-Allele1-2020-9133.clean201112-HRC.txt --make-bed --chr 23 --out 2020-9133.clean201112-updated-chr23
rm TEMP*




##### create a VCF
#vcfCooker --in-bfile <bim file> --ref <reference.fasta>  --out <output-vcf> --write-vcf
#bgzip <output-vcf>

# instead:
#vcftools --plink myfile --vcf output.vcf
#In this example, myfile is the prefix of the BED file (myfile.bed, myfile.bim, myfile.fam), and output.vcf is the resulting VCF file.



convert_bed_to_vcf() {
    local bed_directory="$1"
    local vcf_directory="$2"
    local bed_name="$3"

    for ((chromosome=1; chromosome<=23; chromosome++))
    do
        bed_files="${bed_directory}/${bed_name}chr${chromosome}"
        vcf_file="${vcf_directory}/${bed_name}chr${chromosome}"
        #vcf_gz_file="${vcf_directory}/${bed_name}chr${chromosome}.vcf.gz"
        echo ${bed_files}
        # Convert BED to VCF using bedtools
        #bedtools convert -i bed -g genome_file.txt < "${bed_file}" > "${vcf_file}"
       # vcftools --plink "${bed_file}" --vcf "${vcf_file}"
        # Compress VCF using bgzip
       # bgzip "${vcf_file}"
        plink --bfile ${bed_files} --recode vcf --out ${vcf_file} 
        bgzip ${vcf_file}.vcf

    #    echo "Converted and compressed chr${chromosome}.bed to chr${chromosome}.vcf.gz"
    done
}


convert_bed_to_vcf "/home/aflynn/projects/20230628_imputation_2020-9133" "/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out" "2020-9133.clean201112-updated-"

convert_bed_to_vcf "/home/aflynn/projects/20230628_imputation_2020-9133" "/home/aflynn/projects/20230628_imputation_2020-9133/test_vcf" "2020-9133.clean201112-updated-"
##### check VCF
python2 /home/aflynn/projects/20230628_TOPMed_Imputation_tools/checkVCF/checkVCF.py -r /home/aflynn/projects/20230628_TOPMed_Imputation_tools/checkVCF/hs37d5.fa -o out /home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr1.vcf.gz


/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr1.vcf.gz

vcfCooker --in-bfile <bim file> --ref <reference.fasta>  --out <output-vcf> --write-vcf


curl \
    -H "X-Auth-Token:eyJjdHkiOiJ0ZXh0XC9wbGFpbiIsImFsZyI6IkhTMjU2In0.eyJuYW1lIjoiQWxleGFuZGVyIEZseW5uLUNhcnJvbGwiLCJhcGkiOnRydWUsIm1haWwiOiJhLmZseW5uY2Fycm9sbEBnbWFpbC5jb20iLCJleHBpcmUiOjE2OTExODQzMTg5ODMsInVzZXJuYW1lIjoiYWZseW5uY2Fycm9sbCJ9.PYg7ct0htpaeNx9avboq6JlYIAStfBeMZ7lwsdA1xEk" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr1.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr2.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr3.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr4.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr5.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr6.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr7.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr8.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr9.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr10.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr11.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr12.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr13.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr14.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr15.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr16.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr17.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr18.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr19.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr20.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr21.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr22.vcf.gz" \
    -F "input-files=@/home/aflynn/projects/20230628_imputation_2020-9133/vcf_out/2020-9133.clean201112-updated-chr23.vcf.gz" \
    -F "input-refpanel=apps@topmed-r2@1.0.0" \
    -F "input-phasing=eagle" \
    -F "population=all" \
    -F "r2Filter=0.3" \
    -F "build=hg19" \
    https://imputation.biodatacatalyst.nhlbi.nih.gov/api/v2/jobs/submit/imputationserver





TOKEN="eyJjdHkiOiJ0ZXh0XC9wbGFpbiIsImFsZyI6IkhTMjU2In0.eyJuYW1lIjoiQWxleGFuZGVyIEZseW5uLUNhcnJvbGwiLCJhcGkiOnRydWUsIm1haWwiOiJhLmZseW5uY2Fycm9sbEBnbWFpbC5jb20iLCJleHBpcmUiOjE2OTExODQzMTg5ODMsInVzZXJuYW1lIjoiYWZseW5uY2Fycm9sbCJ9.PYg7ct0htpaeNx9avboq6JlYIAStfBeMZ7lwsdA1xEk"

curl -H "X-Auth-Token:$TOKEN" \
    https://imputation.biodatacatalyst.nhlbi.nih.gov/api/v2/jobs



# curl https://imputationserver.sph.umich.edu/api/v2/jobs/submit/minimac4 \
#   -H "X-Auth-Token: $TOKEN" \
#   -F "files=@/path-to/file1.vcf.gz" \
#   -F "files=@/path-to/file2.vcf.gz" \
#   -F "refpanel=1000g-phase-3-v5" \
#   -F "population=eur"



for file in *.zip; do 7z x -p27Cz>OGfr.FpoS -o~/home/aflynn/projects/20230628_imputation_2020-9133/results/imputation_results/unzipped/ "$file"; done

7z x -p"27Cz>OGfr.FpoS" chr_1.zip