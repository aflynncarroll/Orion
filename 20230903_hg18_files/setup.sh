#!/bin/bash
#
# Script Name: data_prep.sh
# Author: Alexander Flynn-Carroll
# Date: Sep 03, 2023
# Description: get data to lyft over hg18 tp hg38
# Source: http://hgdownload.cse.ucsc.edu/goldenpath/hg18/liftOver/


cd /home/aflynn/tools/liftover/

#wget --timestamping 'ftp://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg18ToHg38.over.chain.gz'  -O hg18ToHg38.over.chain.gz

# http://hgdownload.cse.ucsc.edu/goldenpath/hg18/liftOver/
wget http://hgdownload.cse.ucsc.edu/goldenpath/hg18/liftOver/hg18ToHg38.over.chain.gz