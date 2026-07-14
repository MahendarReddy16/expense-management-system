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

dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "Disable default nodejs"

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? " Enable nodejs:20"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "Installed nodejs:20"

id expense &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo -e " Expense user not exist ... $G Creating it .. $N"
    useradd expense &>>$LOG_FILE
    VALIDATE $? "Creating expense user"
else
    echo -e "expense user already exists.. $Y SKIPPING $N"
fi

mkdir -p /app
VALIDATE $? " Creating /app folder"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE
VALIDATE $? "Downloading the backend application code"

cd /app

rm -rf /app/* # removing the current files under /app folder
unzip /tmp/backend.zip &>>$LOG_FILE
VALIDATE $? "Extracting the backed application code"
pwd

npm install &>>$LOG_FILE
VALIDATE $? "Installing the npm package"

cp /home/ec2-user/expense-management-system/automation-expense-shell/backend.service /etc/systemd/system/backend.service
VALIDATE $? "Copying the path"

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Installing the mysql client"

mysql -h mysql.devsecoops.online -u root -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG_FILE
VALIDATE $? "Schema loading"

systemctl daemon-reload &>>$LOG_FILE
VALIDATE $? "Daemon-reload"

systemctl enable backend &>>$LOG_FILE
VALIDATE $? "Enabled backed"

systemctl restart backend &>>$LOG_FILE
VALIDATE $? "Restart backend"



