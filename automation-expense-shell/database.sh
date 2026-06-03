#!/bin/bash

# Creating the log folder 
LOG_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"

#creating log folder directory if not present

mkdir -p "$LOG_FOLDER"

#PACKAGE=$1 # variable to pass an argument!..

USERID=$(id -u)
#defining the colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# function to validate 
VALIDATE () {  
    if [ $1 -ne 0 ]
   then 
      echo -e "$2 $R FAILURE $N" | tee -e $LOG_FILE
      exit 1
   else
      echo -e "$2 $G SUCCESS!..$N" | tee -e $LOG_FILE
   fi 
}

echo "Script started execution at $(date)" | tee -e $LOG_FILE

if [ $USERID -ne 0 ]
then
   echo -e " $R Root Previlegous required $N " | tee -e $LOG_FILE
   exit 1
fi

#if [ -z "$PACKAGE" ] # checking whether argument is passed or not
#then
#   echo " USAGE:: $0 provide atleast one package name "
#   exit 1
#fi

dnf list installed mysql-server
if [ $? -ne 0 ]
then 
   echo " mysql-server is not installed, installing it...."
   dnf install mysql-server -y >> $LOG_FILE
   VALIDATE $? "Installing  mysql-server"
   systemctl start mysqld
   VALIDATE $? "Starting mysql Server"
   systemctl enable mysqld
   VALIDATE $? "Enabled mysql Server"
else
   echo -e " $Y mysql-server installed, Nothing to do. $N "
fi

mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? "Setting up the root password"