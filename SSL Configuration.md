# SSL Certificate Configuration

## Paths of trust source:
``/usr/share/pki/ca-trust-source/anchors``

``/etc/pki/ca-trust/source/anchors``

## Commands related to certificate configuration:

### Generate CSR and key without SubjectAlternativeName:
``openssl req -new -newkey rsa:2048 -nodes -keyout filename.key -out filename.csr``

### Generate CSR and key with SubjectAlternativeName:
``openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj “/C=IN,ST=TG,L=HYDERABAD/O=ICONIC/CN=\*.ICONIC.COM” -addext “subjectAltName=DNS:servername.ICONIC.COM,DNS:servername.ICONIC.COM,DNS:servername,DNS:servername”``

### Fetch contents of CSR file:
``openssl req -in filename.csr -noout -text``

### Combine private and public key:
``Openssl pkcs12 -export -in <certificatefile>.cer -inkey <keyfilename>.key -out <outfilename>.p12 -name <alias name>  ``

### Import certificate into key store:
``keytool -importcert -alias alias\_name -file my\_cert.cer -keystore tomcat.jks``

### Delete certificate from key store:
``keytool -delete -alias aliasname -keystore filename.jks``

### Export certificate from jks:
``Keytool -export -alias <aliasname>  -keysotre <keystorefile> -rfc -file <ouput filename>``

### Combine 2 certificates:

``cat file1.cer file2.cer > combined.cer``

### Command to check trust source in Linux:
trust list

### Process to add certificate in trust source( manual ):
cp file.cer /etc/pki/ca-trust/source/anchors

``sudo update-ca-trust``

### copy certificate to java key store
``sudo keytool -importcert -alias <alias name> -file filename.cer -keystore /usr/lib/jvm/jre-openjdk/lib/security/cacerts -storepass changeit``

``my open jdk path :  /usr/lib/jvm/jre-openjdk/``

``default password: changeit``

