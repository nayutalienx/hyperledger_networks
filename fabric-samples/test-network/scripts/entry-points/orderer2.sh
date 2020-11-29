#!/bin/bash


softhsm2-util --init-token --slot 0 --label "fabric" --so-pin 71811222 --pin 71811222 

fabric-ca-client enroll -u https://orderer2:ordererpw@ca_orderer:9054 --caname ca-orderer -M /organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem 

sed '161,$d' /root/.fabric-ca-client/fabric-ca-client-config.yaml >> /root/.fabric-ca-client/temporary.yaml 

echo '
bccsp:
  default: PKCS11
  pkcs11:
    Library: /usr/local/lib/softhsm/libsofthsm2.so
    Pin: 71811222
    Label: fabric
    hash: SHA2
    security: 256
    Immutable: false' >> /root/.fabric-ca-client/temporary.yaml

cp -rf /root/.fabric-ca-client/temporary.yaml /root/.fabric-ca-client/fabric-ca-client-config.yaml 

cp /organizations/ordererOrganizations/example.com/msp/config.yaml /organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/config.yaml 

fabric-ca-client enroll -u https://orderer2:ordererpw@ca_orderer:9054 --caname ca-orderer -M /organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles /organizations/fabric-ca/ordererOrg/tls-cert.pem 

orderer
