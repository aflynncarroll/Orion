
#Key
#eyJjdHkiOiJ0ZXh0XC9wbGFpbiIsImFsZyI6IkhTMjU2In0.eyJuYW1lIjoiQWxleGFuZGVyIEZseW5uLUNhcnJvbGwiLCJhcGkiOnRydWUsIm1haWwiOiJhLmZseW5uY2Fycm9sbEBnbWFpbC5jb20iLCJleHBpcmUiOjE2OTExODQzMTg5ODMsInVzZXJuYW1lIjoiYWZseW5uY2Fycm9sbCJ9.PYg7ct0htpaeNx9avboq6JlYIAStfBeMZ7lwsdA1xEk
api_token="eyJjdHkiOiJ0ZXh0XC9wbGFpbiIsImFsZyI6IkhTMjU2In0.eyJtYWlsIjoiYS5mbHlubmNhcnJvbGxAZ21haWwuY29tIiwiYXBpX2hhc2giOiJwQTJpVUZFSEFDQWlNUXlwNnA5R1lzTkZqMDE1ZEEiLCJleHBpcmUiOjE2OTY2MjEwNDgxNTEsIm5hbWUiOiJBbGV4YW5kZXIgRmx5bm4tQ2Fycm9sbCIsImFwaSI6dHJ1ZSwidXNlcm5hbWUiOiJhZmx5bm5jYXJyb2xsIn0.KZ4BNm_I1wfZH-JK-jPqDgG9e0xMqTfbGVdLTtsCx4w"
# submit file for imputation
curl \
    -H "X-Auth-Token:X-Auth-Token:eyJjdHkiOiJ0ZXh0XC9wbGFpbiIsImFsZyI6IkhTMjU2In0.eyJuYW1lIjoiQWxleGFuZGVyIEZseW5uLUNhcnJvbGwiLCJhcGkiOnRydWUsIm1haWwiOiJhLmZseW5uY2Fycm9sbEBnbWFpbC5jb20iLCJleHBpcmUiOjE2OTExODQzMTg5ODMsInVzZXJuYW1lIjoiYWZseW5uY2Fycm9sbCJ9.PYg7ct0htpaeNx9avboq6JlYIAStfBeMZ7lwsdA1xEk" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr1.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr2.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr3.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr4.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr5.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr6.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr7.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr8.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr9.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr10.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr11.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr12.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr13.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr14.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr15.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr16.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr17.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr18.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr19.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr20.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr21.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr22.vcf.gz" \
    -F "input-files-upload=@/home/aflynn/projects/20230801_imputation_2020-9133_v2/hg38_upload_vcf/2020-9133.clean201112-updated-chr23.vcf.gz" \
    -F "input-refpanel=apps@topmed-r2@1.0.0" \
    -F "input-phasing=eagle" \
    -F "population=all" \
    -F "r2Filter=0.3" \
    -F "build=hg38" \
    https://imputation.biodatacatalyst.nhlbi.nih.gov/api/v2/jobs/submit/imputationserver


# go to working directory
cd /home/aflynn/projects/20230801_imputation_2020-9133_v2

# make directory for download
mkdir imputed_data

cd imputed_data

# download imputed data
# download code came from topmed website
curl -sL https://imputation.biodatacatalyst.nhlbi.nih.gov/get/1014211/f178aedb40adfe680ce449614bd89a3b3f1f8a5e1b87f05991728d8988f1cf10 | bash

# make directory for logs and download log data
mkdir logs

cd logs

curl -sL https://imputation.biodatacatalyst.nhlbi.nih.gov/get/1014205/c0b687d284c2a670e73f9c52128cbf2206d31aa18e567c416a355115a83155da | bash

curl -sL https://imputation.biodatacatalyst.nhlbi.nih.gov/get/1014209/6b3a79a16d5146b4ab74ef7cbf171dfd40498bc5f6f012c51cba9d0455a21946 | bash

curl -sL https://imputation.biodatacatalyst.nhlbi.nih.gov/get/1014212/e9cdaaed594e8e9cd01dcfc95c7f599f4c8690f10d75f749e31110eb19aef88a | bash

