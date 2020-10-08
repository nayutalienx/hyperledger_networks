#!/bin/bash


softhsm2-util --init-token --slot 0 --label "fabric" --so-pin 71811222 --pin 71811222 

fabric-ca-client enroll -u https://peer0:peer0pw@ca_org2:8054 --caname ca-org2 -M /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp --csr.hosts peer0.org2.example.com --tls.certfiles /organizations/fabric-ca/org2/tls-cert.pem 

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

cp /organizations/peerOrganizations/org2.example.com/msp/config.yaml /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/config.yaml 

fabric-ca-client enroll -u https://peer0:peer0pw@ca_org2:8054 --caname ca-org2 -M /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp --csr.hosts peer0.org2.example.com --tls.certfiles /organizations/fabric-ca/org2/tls-cert.pem 

peer node start