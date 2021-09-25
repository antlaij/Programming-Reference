# Create Host Key
```batch
ssh-keygen -f localhost.yourdomain.com.key
```

## Response:
```txt
$ ssh-keygen -f localhost.yourdomain.com.key
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in localhost.yourdomain.com.key.
Your public key has been saved in localhost.yourdomain.com.key.pub.
The key fingerprint is:
SHA256:Yf03fiU123KHY/12345WTI+dfasdfawefasdf Username@Computer-Name
The key's randomart image is:
+---[RSA 2048]----+
|           N**0  |
|         . .%+0  |
|        0..N.T . |
|       . .D.+.N .|
|        A. +.++T0|
|            C0+0N|
|           0 N.N.|
|            . *.N|
|             . 0.|
+----[SHA256]-----+
```


# Create Certificate Request
```batch
openssl req -new -key localhost.yourdomain.com.key -out localhost.yourdomain.com.csr
```

## Response:
```text
$ openssl req -new -key localhost.yourdomain.com.key -out localhost.yourdomain.com.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:CA
State or Province Name (full name) [Some-State]:Ontario
Locality Name (eg, city) []:Toronto
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Mycompany
Organizational Unit Name (eg, section) []:IT
Common Name (e.g. server FQDN or YOUR name) []:localhost.yourdomain.com
Email Address []:web@mycompany.com

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```


# Create SSL Certificate
```batch
openssl x509 -req -days 3650 -in localhost.yourdomain.com.csr -signkey localhost.yourdomain.com.key -out localhost.yourdomain.com.crt
```

## Response:
```text
openssl x509 -req -days 3650 -in localhost.yourdomain.com.csr -signkey localhost.yourdomain.com.key -out localhost.yourdomain.com.crt
Signature ok
subject=/C=CA/ST=Ontario/L=Toronto/O=Rogers/OU=IT/CN=localhost.yourdomain.com/emailAddress=web@rci.rogers.com\x1B[D\x1B[D\x1B[D\x1B[D\x1B[D\x1B[D\x1B[D\x1B[D\x1B[\x1B[3~
Getting Private key
```



```batch
sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout localhost.yourdomain.com.key -out localhost.yourdomain.com.key.crt
```


# Create nopass Host Key
```batch
openssl rsa -in local.example.com.key -out local.example.com.nopass.key
```




