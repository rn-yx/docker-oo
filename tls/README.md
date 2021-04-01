# Kafka

## Keytool
Keytool 是一个Java 数据证书的管理工具 ,Keytool 将密钥（key）和证书（certificates）存在一个称为keystore的文件中
在keystore里，包含两种数据：密钥实体（Key entity）——密钥（secret key）又或者是私钥和配对公钥（采用非对称加密） 
可信任的证书实体（trusted certificate entries）——只包含公钥

### keystore的生成

keytool -genkey -alias raykey -keypass 123456 -keyalg RSA -keysize 1024 -validity 365 -keystore server.keystore.jks -storepass 123456 -dname "CN=(名字与姓氏), OU=(组织单位名称), O=(组织名称), L=(城市或区域名称), ST=(州或省份名称), C=(单位的两字母国家代码)";(中英文即可)
例如：
```bash
keytool -genkey -alias raykey -keypass 123456 -keyalg RSA -keysize 1024 -validity 365 -keystore server.keystore.jks -storepass 123456 -dname "CN=rannuo, OU=rannuo, O= XY Inc., L=chengdu, ST=SC, C=CN"
```


openssl s_client -debug -connect 192.168.125.118:9092 -tls1