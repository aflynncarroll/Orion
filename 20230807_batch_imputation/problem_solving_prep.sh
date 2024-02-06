

"/home/aflynn/projects/20230807_batch_imputation/2017-9154_merge_clean190118/hg38_upload_vcf/2017-9154_merge_clean190118"

"/home/aflynn/projects/20230807_batch_imputation/2017-9154-merge_clean181212/hg38_upload_vcf/2017-9154-merge_clean181212"


sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2017-9154/plinkable.HM_fwd" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2017-9154_merge_clean190118" 

sh /home/aflynn/projects/20230807_batch_imputation/data_prep_v4.sh \
    "/geschwindlabshares/HumanGenotypeArray/AGRE.ILMN.Omni/2017-9154-RPT/plinkable.HM_fwd_re-export" \
    "/home/aflynn/projects/20230807_batch_imputation" \
    "2017-9154-merge_clean181212" 

rm -r /home/aflynn/projects/20230807_batch_imputation/2017-9154_merge_clean190118

rm -r /home/aflynn/projects/20230807_batch_imputation/2017-9154-merge_clean181212

#after crossmap
PLINK v1.90b6.21 64-bit (19 Oct 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to /home/aflynn/projects/20230807_batch_imputation/2017-9154_merge_clean190118/hg38_plink/2017-9154_merge_clean190118.log.
Options in effect:
  --allow-extra-chr
  --chr 1-23
  --keep-allele-order
  --make-bed
  --out /home/aflynn/projects/20230807_batch_imputation/2017-9154_merge_clean190118/hg38_plink/2017-9154_merge_clean190118
  --vcf /home/aflynn/projects/20230807_batch_imputation/2017-9154_merge_clean190118/hg38_vcf/2017-9154_merge_clean190118.vcf

128638 MB RAM detected; reserving 64319 MB for main workspace.
Error: Multiple instances of '_' in sample ID.
If you do not want '_' to be treated as a FID/IID delimiter, use --double-id or
--const-fid to choose a different method of converting VCF sample IDs to PLINK
IDs, or --id-delim to change the FID/IID delimiter.