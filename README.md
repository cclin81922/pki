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

* [Adding trusted root certificates to the server](https://manuals.gfi.com/en/kerio/connect/content/server-configuration/ssl-certificates/adding-trusted-root-certificates-to-the-server-1605.html)
  * Mac OS X
  * Windows
  * Linux (Ubuntu)
  * Linux (CentOS)
* Docker loads ca cert which is located in `/etc/docker/certs.d/`
* Docker-for-mac loads ca cert which is located in `~/.docker/certs.d/`
* GitLab loads server cert and server key which are located in `/etc/gitlab/ssl/`

Docker loads ca cert which is located in `/etc/docker/certs.d/`

```
/etc/docker/certs.d/
|_ _ <MyRegistry>:<Port>
	 |_ _ca.crt
```

Docker-for-mac loads ca cert which is located in `~/.docker/certs.d/`

```
~/.docker/certs.d/
|_ _ <MyRegistry>:<Port>
	 |_ _ca.crt
```

GitLab loads server cert and server key which are located in `/etc/gitlab/ssl/`

```
/etc/gitlab/ssl/
|_ _ <CN>.key <CN>.crt
```

# Note

* [Chrome 56 以上版本不支援 SHA-1 憑證](https://security.googleblog.com/2016/11/sha-1-certificates-in-chrome.html)
* [Chrome 58 以上版本只會使用 subjectAlternativeName 延伸 (而非 commonName) 來比對網域名稱和網站憑證。](https://support.google.com/chrome/a/answer/7391219?hl=zh-Hant)

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
* https://docs.docker.com/docker-for-mac/#directory-structures-for-certificates
