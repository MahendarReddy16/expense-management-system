#!/bin/bash

LOG_FOLDER=
SCRIPT_NAME=
TIME_STAMP=
LOG_FILE=

PACKAGE=$1

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo " Root Previlegous required "
   exit 1
fi

if [ -z "$PACKAGE" ]
then
   echo " USAGE:: $0 provide atleast one package name "
   exit 1
fi

dnf list installed $PACKAGE
if [ $? -ne 0 ]
then 
   echo " $PACKAGE is not installed, installin it.. "
   dnf install $PACKAGE -y
   if [ $? -ne 0 ]
   then 
      echo " $PACKAGE installation failed... check the error. "
   else
      echo " $PACKAGE Installation is Successfully done!.. "
else
   echo " $PACKAGE installed, Nothing to do. "
fi