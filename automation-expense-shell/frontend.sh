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
      echo -e "$2 $R FAILURE $N" | tee -a $LOG_FILE
      exit 1
   else
      echo -e "$2 $G SUCCESS!..$N" | tee -a $LOG_FILE
   fi 
}

echo "Script started execution at $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
   echo -e " $R Root Previlegous required $N " | tee -a $LOG_FILE
   exit 1
fi

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "Installing Nginx"

systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "Enabling Nginx"

systemctl start nginx &>>$LOG_FILE
VALIDATE $? "Starting Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
VALIDATE $? "Removing default website files under /html folder"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE
VALIDATE $? "Downloading the frontend code"

cd /usr/share/nginx/html

unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "Extracting the files"

cp /home/ec2-user/ /etc/nginx/default.d/expense.conf
VALIDATE $? "copying the expense.conf"

systemctl restart nginx &>>$LOG_FILE
VALIDATE $? "Restarting the Nginx"