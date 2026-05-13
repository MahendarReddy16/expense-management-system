## Manual Project ##
## User → Frontend(Presentation Layer) → Backend(Application Layer) ↔ Database(Data Layer) ## 

## DataBase ##

## Creating Database Server ##
i. Create an EC2 instance.

ii. Connect to the instance (Database Server).

iii. Install the database software:

1. Database: MySQL
2. Need to check if the DB is installed and running: 
    i. Check the service status 
    ii. Check whether port is available and it is enabled or not 
    iii. Check whether the process status is running or not

Note:
```
During process checking, if the port is not visible, it means the database is not running.
```

iv. Enable MySQL Service:
```
systemctl enable mysqld (This ensures the daemon starts automatically on system boot).

systemctl start mysqld
```
This ensures the service starts automatically when the system boots.
MySQL runs in the background and handles database requests.

v. After Installation, Password must be set.
By Default:
Username: root
Password: needs to be set manually.

vi. Client package need to be installed
1. Install MySQL Client --> Server software = mysql-server
2. To check data inside the server, we must connect using a client.
```
dnf install mysql -y
```
Connect Client to Server

Outside server:
```
mysql -h <IP_Address> -u root -p
```
Inside server:
```
mysql -u root -p or mysql
```

Schema & SQL Commands
Schema / Database

A schema defines how data is organized into tables, fields, and relationships.
It helps in easy identification and management of data.

Example: Facebook-like system:
Users → users Schema
Posts → posts Schema
Videos → videos Schema
```
MySQL Server → Database → Tables
```
vii. Connecting to SQL (Client)

Show databases:
```
mysql>show databases;
```
Switch database:
```
mysql>use <database_name>;
```
Show tables:
```
mysql>show tables;
```
View table data:
```
mysql>select * from <table_name>;
```

## Backend Configuration ###

i. Create an EC2 instance.

ii. Connect to the backend server.

iii. Install the required backend language based on THE project requirements.

Examples:
```
Java
Python
Node.js
.NET
```
iv. We will use Node.js specifics to build project.
```
Build file: package.json.

Build tool: npm (Node Package Manager).
```
v. Installation of Node.js and version will be defined by the developer
steps:
i.
```
dnf module list nodejs
```
```
dnf module disable nodejs -y (If a different version is needed).
```
```
dnf module enable nodejs:20 -y  
```
```
dnf install nodejs -y
```

ii. Configure Application Users:
Creating a system user for security for running the application(Used for common purpose)
```
useradd expense.
```
iii. Creating Application Directory:
We need to place application under a particular created directory.
```
mkdir /app
```
iv. Download Source Code:
Downloading application code on tmp directory
```
curl -o /tmp/backend.zip https://<url_to_code>.zip
```
v. Deploy Code:
We need to navigate to the created folder path /app and we need to unzip the downloaded application code
```
cd /app
```
```
unzip /tmp/backend.zip
```
vi. Install Dependencies:
Below command will installs the required libraries and also validates whether the folder contains package.json file and downloads required libraries from internet.
```
npm install
```
Creates new folder as the node_modules folder

vii. Managing the Process:

1. To start the backend we need to run index.json file contains in /bin/node
```
node /app/index.js
```
Note: Each time running manually is inefficient. So we create systemctl service to manage application so that it will be easy start/stop/restart it.

2. From google search for systemctl service file

viii. All the systemctl service files will locate under this path

i.Systemd service files are located in: 
```
/etc/systemd/system/backend.service
```
ii. Use vim /etc/systemd/system/backend.service to create the configuration.
```
vim /etc/systemd/system/backend.service 
```
When the linux server starts it will check the .service files under the above folder and restarts automatically.
 Note:
 1.  Use Private IPs for communication within the network (faster/secure) 
 2. Public IPs for outside communication.

iii. In systemctl service file we need to specify private IP of detabase server

iv. Once placed need to reload and Start.
```
systemctl daemon-reload
```
Starting the backend server:
```
systemctl start backend
```
```
systemctl enable backend
```
Checks the status of the server:
```
systemctl status backend
```

v. Verification:
Checking listening ports is running or not
```
netstat -lntp
```
Validating the node.js prcess is running or not
```
ps -ef | grep node
``

vi. Troubleshooting:
If it is failed to start we need to check the logs in the below folder
```
/var/log/messages
```
```
>less /var/log/messages

Navigation in less: 
```
Shift + G  ---> to go to the bottom
gg ---> to go to the top.
```
## Database Connection Establishment Process ##
Database Connection Process
1. Need to Create schema/database
2. Need to create table 
File path in backend server
```
cat schema/backend.sql
```
3. To load schema we need to install mysql client
```
dnf install mysql -y
```
4. To load schema command
```
mysql> mysql -h <DB_IP> -u root -pExpenseApp@1 < /app/schema/backend.sql.
```
5. After schema is created we need to restart backend server to verify connection to client is successful or not
```
systemctl restart backend.
```
To check the port and the process
```
systemctl status backend
```

6. Connectivity Checks:
To cehck whether the app server is connected to database server or not. we will use below command to check

```
ping <IP_Address>
```
Check if the DB port is reachable.
```
telnet <IP_Address> <port_no> 
```
DB port = 3306


## Frontend Server Configuration ##

i. Create EC2 instance and connect.

ii. We will install Nginx (Web Server for static content):
```
dnf install nginx -y
```
```
systemctl start nginx
```
```
systemctl status nginx
```
iii. Nginx Config path:
```
 /etc/nginx
```
Websites path
```
/usr/share/nginx/html
```
Logs path
```
/var/log/nginx
```
iv. Need to delete default content in the .html 
```
rm -rf /usr/share/nginx/html/*
```
v. Need to install the developers code in the tmp directory
```
curl -o /tmp/frontend.zip https://<url>.zip
```
From tmp directory to we need to deploy in the below path by unzipping the zip file
```
cd /usr/share/nginx/html
```
```
unzip /tmp/frontend.zip
```

Configure Reverse Proxy:
```
vim /etc/nginx/default.d/expense.conf
```
Add the following content
```
proxy_http_version 1.1;

location /api/ { proxy_pass http://localhost:8080/; }

location /health {
  stub_status on;
  access_log off;
}
```

Open the Frontend Public IP in a browser to check the application.