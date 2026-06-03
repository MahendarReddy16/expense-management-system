# MySQL
Developer has chosen the database MySQL. Hence, we are trying to install it up and configure it.
**Versions of the DB Software you will get context from the developer, Meaning we need to check with developer.**
Install MySQL Server 8.0.x
```
dnf install mysql-server -y
```
Start MySQL Services:

Created symlink /etc/systemd/system/multi-user.target.wants/mysqld.service → /usr/lib/systemd/system/mysqld.service.

The systemctl enable command configures a service to start automatically when the server boots.
```
systemctl enable mysqld
```
```
systemctl start mysqld
```
### If the above command failed with below error that means the MySQL server service (mysqld) is not installed or is registered under a different service name.

# Failed to enable unit: Unit file mysqld.service does not exist.

Check what MySQL/MariaDB packages are installed:
```
rpm -qa | grep -Ei "mysql|mariadb"
```
Check available services:
```
systemctl list-unit-files | grep -Ei "mysql|mariadb"
```
verify available packages
```
dnf list installed | grep mysql

dnf search mysql-server
```
if server package is missing install it:
```
dnf install -y mysql-server
```
# Post installation run the commands systemctl enable and start and validate if the services are enabled or not by using below commands

To validate the status of database is  active (running) or not
```
systemctl status mysqld
```
To validate port is enabled or not
```
netstat -lntp
```
To validate the process running or not
```
ps -ef | grep <name of service>
```

By defalut username is root and pasword need to set as below 

We need to change the default root password in order to start using the database service. 
Use password ***** example: ExpenseApp@1 or any other as per your choice.
```
mysql_secure_installation --set-root-pass ****
```
# To check data we should connect to server through client
Server software is mysql-server and it is running, To check data we should connect to server through client
client package is just mysql.

```
dnf install mysql -y
```
## Connecting to client and Verifing data
We can check data by using client package called mysql.
Usually command to connect mysql server if outside
```
mysql -h <host-address> -u root -p<password>
```
But if your client and server both are in a single server, you can simply use.
```
mysql
```
Once you got mysql prompt, you can use below command to check schemas/databases exist.
```
show databases;
```
Once you are in particular schema, you can get the list of tables.
```
show tables;
```
You can get entries of a table using
```
select * from <table_name>;
```

