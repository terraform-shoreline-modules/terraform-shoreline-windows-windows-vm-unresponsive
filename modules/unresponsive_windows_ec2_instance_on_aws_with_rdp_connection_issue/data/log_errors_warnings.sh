

#!/bin/bash



# Set the instance ID and region

INSTANCE_ID=${INSTANCE_ID}

REGION=${REGION}



# Get the log file path and name

LOG_FILE=${LOG_FILE_PATH_AND_NAME}



# Use AWS CLI to retrieve the log file from the instance

aws ec2 get-console-output --instance-id $INSTANCE_ID --region $REGION > $LOG_FILE



# Check the log file for any errors or warnings

if grep -q "error" $LOG_FILE; then

    echo "Error found in log file"

elif grep -q "warning" $LOG_FILE; then

    echo "Warning found in log file"

else

    echo "No errors or warnings found in log file"

fi