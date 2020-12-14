


#正确案例--导入
/usr/local/service/sqoop/bin/sqoop import \
  --connect jdbc:mysql://10.0.16.14:3306/lazada_base \
  --username lazada_dev \
  --password v0ZsvowM6JzTNoSw \
  --query  'SELECT * FROM lz_site_info  and $CONDITIONS'  \
  --fields-terminated-by '\001' \
  --lines-terminated-by '\n' \
  --delete-target-dir \
  --target-dir  cosn://emr-1254463213/lazada_dw/ods/ods_mysql_station/20201107 \
  --direct --m 1




#正确案例--导入
/usr/local/service/sqoop/bin/sqoop export \
  --connect jdbc:mysql://10.0.16.14:3306/lazada_base \
  --username lazada_dev \
  --password v0ZsvowM6JzTNoSw \
  --table bd_testdata \
  --fields-terminated-by '\001' \
  --lines-terminated-by '\n' \
  --export-dir cosn://emr-1254463213/bigdata-export/lazada_base/bd_testdata/20201107/ \
  --direct








