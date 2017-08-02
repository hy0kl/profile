#!/usr/bin/env bash
# @describe: 使用openssl 生成RSA pem格式密钥对
# @see: http://linghaolu.github.io/openssl/2016/04/02/openssl-rsa-pem.html
# @author:   Jerry Yang(hy0kle@gmail.com)

#set -x

# 生成 1024 位的私钥
openssl genrsa -out rsa_private_key.pem 1024
# 转成 pkcs8 格式
openssl pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt
# 生成 rsa 公钥
openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem

# vim:set ts=4 sw=4 et fdm=marker:

