#!/bin/bash

#Step 1
# 生成服务器keystore(密钥和证书)
keytool -genkey -alias localhost -keypass 123456 -keyalg RSA -keysize 1024 -validity 365 -keystore server.keystore.jks -storepass 123456 -dname "CN=rannuo.cn, OU=rannuo, O= XY Inc., L=CD, ST=SC, C=CN"
# 生成客户端keystore(密钥和证书)
keytool -genkey -alias localhost -keypass 123456 -keyalg RSA -keysize 1024 -validity 365 -keystore client.keystore.jks -storepass 123456 -dname "CN=rannuo.cn, OU=rannuo, O= XY Inc., L=CD, ST=SC, C=CN"

#Step 2
# 创建CA证书
openssl req -new -x509 -keyout ca-key -out ca-cert -days 365 -passin pass:123456 -passout pass:123456 -subj "/C=CN/ST=SC/L=CD/O=XY Inc./OU=rannuo/CN=rannuo.cn"
# 将CA证书导入到服务器truststore
keytool -keystore server.truststore.jks -alias CARoot -import -file ca-cert -storepass 123456 -keypass 123456 -noprompt
# 将CA证书导入到客户端truststore
keytool -keystore client.truststore.jks -alias CARoot -import -file ca-cert -storepass 123456 -keypass 123456 -noprompt

#Step 3
# 导出服务器证书
keytool -keystore server.keystore.jks -alias localhost -certreq -file cert-file -storepass 123456 -keypass 123456 -noprompt
keytool -keystore client.keystore.jks -alias localhost -certreq -file client-cert-file -storepass 123456 -keypass 123456 -noprompt
# 用CA证书给服务器证书签名
openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:123456
openssl x509 -req -CA ca-cert -CAkey ca-key -in client-cert-file -out client-cert-signed -days 365 -CAcreateserial -passin pass:123456
# 将CA证书导入服务器keystore
keytool -keystore server.keystore.jks -alias CARoot -import -file ca-cert -storepass 123456 -keypass 123456 -noprompt
keytool -keystore client.keystore.jks -alias CARoot -import -file ca-cert -storepass 123456 -keypass 123456 -noprompt
# 将已签名的服务器证书导入服务器keystore
keytool -keystore server.keystore.jks -alias localhost -import -file cert-signed -storepass 123456 -keypass 123456 -noprompt
keytool -keystore client.keystore.jks -alias localhost -import -file client-cert-signed -storepass 123456 -keypass 123456 -noprompt


