#!/bin/bash

LOG_FOLDER=
SCRIPT_NAME=
TIME_STAMP=
LOG_FILE=

USERID=$(id -u)
if ( $SERID -ne 0 )
then
   echo " you need to run using the root previleges"
fi

echo " Hello World "