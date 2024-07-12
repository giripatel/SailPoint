#Tomcat SSL Configuration
```
<Connector
           protocol="org.apache.coyote.http11.Http11NioProtocol"
           port="8443" maxThreads="200"
           scheme="https" secure="true" SSLEnabled="true"
           keystoreFile="/home/username/certificate/server.p12"     
	   keystorePass="P@ssw0rd"
	   truststoreFile=”/usr/lib/jvm/jre-11-openjdk/lib/security/cacerts”
		truststorePass=”changeit”
		enableLookups=”false”
		type=”RSA”
           clientAuth="false" sslProtocol="TLS"/>
```