

#eyJjdHkiOiJ0ZXh0XC9wbGFpbiIsImFsZyI6IkhTMjU2In0.eyJuYW1lIjoiQWxleGFuZGVyIEZseW5uLUNhcnJvbGwiLCJhcGkiOnRydWUsIm1haWwiOiJhLmZseW5uY2Fycm9sbEBnbWFpbC5jb20iLCJleHBpcmUiOjE2OTExODQzMTg5ODMsInVzZXJuYW1lIjoiYWZseW5uY2Fycm9sbCJ9.PYg7ct0htpaeNx9avboq6JlYIAStfBeMZ7lwsdA1xEk
api_token="eyJjdHkiOiJ0ZXh0XC9wbGFpbiIsImFsZyI6IkhTMjU2In0.eyJtYWlsIjoiYS5mbHlubmNhcnJvbGxAZ21haWwuY29tIiwiYXBpX2hhc2giOiJwQTJpVUZFSEFDQWlNUXlwNnA5R1lzTkZqMDE1ZEEiLCJleHBpcmUiOjE2OTY2MjEwNDgxNTEsIm5hbWUiOiJBbGV4YW5kZXIgRmx5bm4tQ2Fycm9sbCIsImFwaSI6dHJ1ZSwidXNlcm5hbWUiOiJhZmx5bm5jYXJyb2xsIn0.KZ4BNm_I1wfZH-JK-jPqDgG9e0xMqTfbGVdLTtsCx4w"
# submit file for imputation
submit_job(){
    curl \
        -H "X-Auth-Token:${api_token}" \
        -F "input-files-upload=@${1}-updated-chr1.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr2.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr3.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr4.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr5.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr6.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr7.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr8.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr9.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr10.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr11.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr12.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr13.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr14.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr15.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr16.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr17.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr18.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr19.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr20.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr21.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr22.vcf.gz" \
        -F "input-files-upload=@${1}-updated-chr23.vcf.gz" \
        -F "input-refpanel=apps@topmed-r2@1.0.0" \
        -F "input-phasing=eagle" \
        -F "population=all" \
        -F "r2Filter=0.3" \
        -F "build=hg38" \
        https://imputation.biodatacatalyst.nhlbi.nih.gov/api/v2/jobs/submit/imputationserver
}

submit_job "/home/aflynn/projects/20230807_batch_imputation/2013-111A.ATN.clean170906/hg38_upload_vcf/2013-111A.ATN.clean170906"
#"id":"job-20230808-191628-048" -d

submit_job "/home/aflynn/projects/20230807_batch_imputation/2016-9174-3_clean190123/hg38_upload_vcf/2016-9174-3_clean190123"
# "id":"job-20230808-191703-676" -d

submit_job "/home/aflynn/projects/20230807_batch_imputation/2017-9154-merge_clean181212/hg38_upload_vcf/2017-9154-merge_clean181212"
# failed
#/home/aflynn/projects/20230807_batch_imputation/2013-111A.ATN.clean170906_R2/hg38_upload_vcf
#"id":"job-20230810-224312-644"



submit_job "/home/aflynn/projects/20230807_batch_imputation/2015-9017.clean170906/hg38_upload_vcf/2015-9017.clean170906"
# "id":"job-20230808-191749-473"

submit_job "/home/aflynn/projects/20230807_batch_imputation/2016-9174_clean190123/hg38_upload_vcf/2016-9174_clean190123"
# "id":"job-20230809-151648-696"

submit_job "/home/aflynn/projects/20230807_batch_imputation/2017-9154_merge_clean190118/hg38_upload_vcf/2017-9154_merge_clean190118"
# "id":"job-20230809-151712-586","message"
#failed
#after clean "id":"job-20230810-205815-626"

#2017-9154-merge_clean181212
#2017-9154-merge_clean181212

submit_job "/home/aflynn/projects/20230807_batch_imputation/2020-9133.clean201112/hg38_upload_vcf/2020-9133.clean201112"
# "id":"job-20230816-190638-717"

submit_job "/home/aflynn/projects/20230807_batch_imputation/2011-158.clean230815/hg38_upload_vcf/2011-158.clean230815"
# "id":"job-20230816-190700-543" - ?
# job-20230906-205253-706

submit_job "/home/aflynn/projects/20230807_batch_imputation/2010-002.clean101007/hg38_upload_vcf/2010-002.clean101007"
# "id":"job-20230817-210530-805"
# "id":"job-20230831-205928-561"
#hg18-38
#"id":"job-20230903-222019-537"


submit_job "/home/aflynn/projects/20230807_batch_imputation/2013-438.clean230817/hg38_upload_vcf/2013-438.clean230817"
#"id":"job-20230905-210417-523"

submit_job "/home/aflynn/projects/20230807_batch_imputation/2022-9163.clean230801/hg38_upload_vcf/2022-9163.clean230801"
# "id":"job-20230906-200635-916"