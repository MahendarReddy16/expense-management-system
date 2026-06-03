#!/bin/bash

LOG_FOLDER=
SCRIPT_NAME=
TIME_STAMP=
LOG_FILE=

USERID=$(id -u)
if [ $USERID -ne 0 ]
then
   echo " Root Prevligeous required"
fi

echo " Hello World "