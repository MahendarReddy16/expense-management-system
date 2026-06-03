### Backend
Backend service is responsible for adding the given values to database. Backend service can be written in any language like Java, Python,.Net and NodeJS etc.. based on the project and availability.

**Developer has chosen the language, Check with developer which version of language is need to be installed. Developer has set a context that it can work with NodeJS >20**

 Hence we need to install NodeJS here as per the requirement.
 Nodejs build file == package.json
 buils tool == npm --> called as node package manager
 
Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install this.

**You can list modules by using dnf module list**
Check the installed packages
```
dnf module list nodejs -y
```
Need to disable the unnecessary packages which are not required and enable the required version
```
dnf module disable nodejs -y
```
```
dnf module enable nodejs:20 -y
```
```
dnf install nodejs -y
```
## Configure the application user
System users are created for running the application( used for the common purpose )

Add application User
```
useradd expense
```
User expense is a function / daemon user to run the application. Apart from that we don't use this user to login to server.

We keep application in one standard location. This is a usual practice that runs in the organization.
Lets setup an app directory.
```
mkdir /app
```
Download the application code to created app directory.
```
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
```
```
cd /app
```
```
unzip /tmp/backend.zip
```
Every application is developed by development team will have some common softwares that they use as libraries. This application also have the same way of defined dependencies in the application configuration.
Lets download the dependencies.
```
cd /app
```
npm install command will validate whether the folder contains package.json file and install the required libraries from the internet
It will create a new folder as node_modules
```
npm install
```
To start the backend server we need to run the index.json file contains /bin/node /app/index.json but each time running manually is quite difficult. So if we create the systemctl to run it will be east to start/stop/restart the services.

From google we need to search for the systemctl service file and place under /etc/systemd/system/ folder where all systemctl service files will contain and the name of the file should contain as .service

When the linux server starts it checks all the .service files under the above folder and restarts automatically.

Note: In systemctl service file we need to specify the private IP of database server for the faster communication(inside network)

Outside network --> we will use public IP

```
vim /etc/systemd/system/backend.service
```
```
[Unit]
Description = Backend Service
[Service]
User=expense
Environment=DB_HOST="<MYSQL-SERVER-IPADDRESS>"
ExecStart=/bin/node /app/index.js
SyslogIdentifier=backend
[Install]
WantedBy=multi-user.target
```
**NOTE: Ensure you replace <MYSQL-SERVER-IPADDRESS> with IP address**
Once placed and saved we need to reload the service.
```
systemctl daemon-reload
```
Start the service.
```
systemctl start backend
```
```
systemctl enable backend
```
To validate the status of backend server is  active (running) or not
```
systemctl status backend
```
To validate port is enabled or not
```
netstat -lntp
```
To validate the process running or not
```
ps -ef | grep <name of service>
```

If failed to start we need to check the logs in this folder /var/log/messages  --> linux log folder
>less /var/log/messages
Shift+G --> to go down
gg --> to go up

## Database connection Establishment Process

To work application fully functional we need to create the schema/database for expense project and create table
path in backend server --> cat schema/backend.sql

We can't use every where root credientials so js developer creats user and password

Backend server contains sql file to connect to database server we need have client. Below is the command to install mysql client.
```
dnf install mysql -y
```
Load Schema
Output --> >(greater than)  Input -->  < (less than)
```
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql
```
Restart the service.
```
systemctl restart backend
```