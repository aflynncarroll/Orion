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
