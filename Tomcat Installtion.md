**Step 1 – Install Apache Tomcat on Oracle Linux**

Next, go to the Tomcat download page and download the latest version of Apache Tomcat 9 using the [wget command](https://www.atlantic.net/dedicated-server-hosting/how-to-download-file-using-wget-in-linux/):

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.88/bin/apache-tomcat-9.0.88.tar.gz

Once Apache Tomcat is downloaded, create a directory for Tomcat and extract the downloaded file inside the /opt/tomcat directory:

```
sudo mkdir /opt/tomcat

sudo tar xzf apache-tomcat-9.0.88.tar.gz -C /opt/tomcat --strip-components=1
```
Next, change the ownership of /opt/tomcat directory to Tomcat:

``sudo chown -R your\_user\_name: /opt/tomcat/``

**Step 2 – Create a Tomcat Administrative User**

By default, Tomcat can be accessed without authentication. For security reasons, it is recommended to enable authentication in Tomcat.

You can enable Tomcat authentication and create an admin user by editing the /opt/tomcat/conf/tomcat-users.xml file:
```
sudo vim /opt/tomcat/conf/tomcat-users.xml

Add the following lines just above the last line:

<role rolename="manager-gui"/>

<user username="admin" password="password" roles="manager-gui,admin-gui"/>
```
Save and close the file when you are finished.

**Step 3 – Configure Tomcat for Remote Access**

By default, Tomcat can be accessed only from the local host, so you must configure Tomcat to access it from the remote machine.

To allow the Manager App from the remote host, edit the context.xml file:
```
sudo vim /opt/tomcat/webapps/manager/META-INF/context.xml

Remove the following lines:

<Valve className="org.apache.catalina.valves.RemoteAddrValve"

        allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
```
Save and close the file when you are finished.

To allow the Host Manager App from the remote host, edit the context.xml file:

``sudo vim /opt/tomcat/webapps/host-manager/META-INF/context.xml``

Remove the following lines:
```
<Valve className="org.apache.catalina.valves.RemoteAddrValve"

allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
```
Save and close the file when you are finished.

**Step 4 – Create a Systemd Unit File for Apache Tomcat**

Next, it is recommended to create a systemd unit file to manage the Tomcat service. You can create it with the following command:

``sudo vim /etc/systemd/system/tomcat.service``

Add the following lines:
```
[Unit]

Description=Apache Tomcat Server

After=syslog.target network.target

[Service]

Type=forking

User=your\_user\_name

\# (optional)Group=your\_gourp\_name

Environment=CATALINA\_PID=/opt/tomcat/temp/tomcat.pid

Environment=CATALINA\_HOME=/opt/tomcat

Environment=CATALINA\_BASE=/opt/tomcat

ExecStart=/opt/tomcat/bin/startup.sh

ExecStop=/opt/tomcat/bin/shutdown.sh

RestartSec=10

Restart=always

[Install]

WantedBy=multi-user.target
```
Save and close the file, then reload the systemd daemon with the following command:

``systemctl daemon-reload``

Next, start the Tomcat service and enable it to start at system reboot:
```
systemctl start tomcat

systemctl enable tomcat
```
You can verify the status of the Tomcat service with the following command:

``systemctl status tomcat``

You will get the following output:
```
● tomcat.service - Apache Tomcat Server

`   `Loaded: loaded (/etc/systemd/system/tomcat.service; disabled; vendor preset: disabled)

`   `Active: active (running) since Tue 2022-05-03 09:26:42 EDT; 16s ago

`  `Process: 23184 ExecStart=/opt/tomcat/bin/catalina.sh start (code=exited, status=0/SUCCESS)

` `Main PID: 23195 (java)

`    `Tasks: 34 (limit: 23694)

`   `Memory: 98.3M

`   `CGroup: /system.slice/tomcat.service

`           `└─23195 /usr/bin/java -Djava.util.logging.config.file=/opt/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.j>

May 03 09:26:42 oraclelinux8 systemd[1]: Starting Apache Tomcat Server...

May 03 09:26:42 oraclelinux8 systemd[1]: Started Apache Tomcat Server.
```

**Step 5 – Expose 8080 port as public**

Run the below command 
```
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent      

sudo firewall-cmd --reload                                          
```                               


