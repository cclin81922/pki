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

# Inspect

# Check

# Load

# Related Resources

* Evernote :: OpenSSL
* https://github.com/jinsenglin/xip.io-ssl-generator
* https://github.com/cclin81922/tls
* https://github.com/cloudflare/cfssl
* https://kubernetes.io/docs/concepts/cluster-administration/certificates/
* https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
* https://hackmd.io/xrDSH8uuQPeOsUoY2Xz8uw
* https://geekflare.com/san-ssl-certificate/
