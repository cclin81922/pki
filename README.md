# pki

To make key and cert, there are 3 options of tool ([example usage](https://kubernetes.io/docs/concepts/cluster-administration/certificates/))

* easyrsa
* openssl
* cfssl

# Chain

a.k.a. `certification path` or `signature hierarchy`

4 tier

```
root cert
|_ _ intermediateA cert (signed by root cert)
	 |_ _ intermediateB cert (signed by intermediateA cert)
	  	  |_ _ server/client cert (signed by intermediateB cert)
```

3 tier

```
root cert
|_ _ intermediate cert (signed by root cert)
	 |_ _ server/client cert (signed by intermediate cert)
```

2 tier

```
root cert
|_ _ server/client cert (signed by root cert)
```

# Create

* Create new cert and key with existing ca


Create new cert and key with existing ca

```
bash scripts/openssl/mk-cert-key.sh <CN>
bash scripts/openssl/mk-cert-key.sh www.cc.lin
bash scripts/openssl/mk-cert-key.sh 192.168.33.101
bash scripts/openssl/mk-cert-key.sh 192.168.33.101.xip.io
```

# Inspect

* Inspect CN of a cert
* Inspect SANs of a cert

Inspect CN of a cert with openssl

```
openssl x509 -in <cert> -text -noout | grep Subject | grep CN
openssl x509 -in data/ca/ca.cclin/ca.cert.pem -text -noout | grep Subject | grep CN
```

Inspect SANs of a cert with openssl

```
openssl x509 -in <cert> -text -noout | egrep 'IP|DNS'
openssl x509 -in data/ca/ca.cclin/ca.cert.pem -text -noout | egrep 'IP|DNS'
```

# Check

* Check if cert is signed by given ca cert

Check if cert is signed by given ca cert

```
openssl verify -CAfile <ca cert> <cert> 
openssl verify -CAfile data/ca/ca.cclin/ca.cert.pem data/certs-signed-by-ca.cclin/www.cc.lin/www.cc.lin.cert.pem 
```

# Load

# Related Resources

* Evernote :: OpenSSL
* https://github.com/jinsenglin/xip.io-ssl-generator
* https://github.com/cclin81922/tls
* https://github.com/cloudflare/cfssl
* https://kubernetes.io/docs/concepts/cluster-administration/certificates/
* https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
* https://hackmd.io/xrDSH8uuQPeOsUoY2Xz8uw
* SANs https://geekflare.com/san-ssl-certificate/
* SANs https://github.com/chef-cookbooks/openssl/issues/37
* .srl file http://www.gutizz.com/openssl-creates-ca-serial-file/
* .srl file http://users.skynet.be/pascalbotte/art/server-cert.htm
