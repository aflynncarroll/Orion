#!/bin/bash

# Set the parent directory
parent_dir="/home/aflynn/projects/20230807_batch_imputation"

# List of subdirectories to delete
subdirs=("hg19_plink" "hg19_vcf" "hg38_plink" "hg38_vcf")

# Loop through directories and delete subdirectories
for dir in "$parent_dir"/*; do
  if [ -d "$dir" ]; then
    for subdir in "${subdirs[@]}"; do
      sub_dir_path="$dir/$subdir"
      if [ -d "$sub_dir_path" ]; then
        echo "Deleting $sub_dir_path"
        rm -rf "$sub_dir_path"
      fi
    done
  fi
done
