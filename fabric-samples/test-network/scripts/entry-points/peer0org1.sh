#!/bin/bash

softhsm2-util --init-token --slot 0 --label "fabric" --so-pin 71811222 --pin 71811222 

fabric-ca-client enroll -u https://peer0:peer0pw@ca_org1:7054 --caname ca-org1 -M /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp --csr.hosts peer0.org1.example.com --tls.certfiles /organizations/fabric-ca/org1/tls-cert.pem 

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

cp /organizations/peerOrganizations/org1.example.com/msp/config.yaml /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/config.yaml 

fabric-ca-client enroll -u https://peer0:peer0pw@ca_org1:7054 --caname ca-org1 -M /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp --csr.hosts peer0.org1.example.com --tls.certfiles /organizations/fabric-ca/org1/tls-cert.pem 

peer node start