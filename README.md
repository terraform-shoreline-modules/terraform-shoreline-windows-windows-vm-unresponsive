
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Unresponsive Windows EC2 Instance on AWS with RDP Connection Issue
---

This incident type refers to a problem where a Windows EC2 instance on Amazon Web Services (AWS) becomes unresponsive and users are unable to connect to it via Remote Desktop Protocol (RDP). The incident requires troubleshooting using the AWS Command Line Interface (CLI) to identify and resolve the underlying issues causing the unresponsiveness and RDP connection problem.

### Parameters
```shell
export PUBLIC_IP_ADDRESS_OF_INSTANCE="PLACEHOLDER"

export PRIVATE_IP_ADDRESS_OF_INSTANCE="PLACEHOLDER"

export INSTANCE_ID="PLACEHOLDER"

export SECURITY_GROUP_NAME="PLACEHOLDER"

export LOG_FILE_PATH_AND_NAME="PLACEHOLDER"

export REGION="PLACEHOLDER"
```

## Debug

### Connect to the AWS EC2 instance using RDP
```shell
mstsc /v:${PUBLIC_IP_ADDRESS_OF_INSTANCE}
```

### Check if the instance is running and responding to ping
```shell
ping ${PRIVATE_IP_ADDRESS_OF_INSTANCE}
```

### Get the instance ID for the EC2 instance
```shell
aws ec2 describe-instances --region ${REGION} --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId]" --output text
```

### Check the status of the instance
```shell
aws ec2 describe-instances --region ${REGION} --instance-ids ${INSTANCE_ID}
```

### Get the system log for the instance to check for any errors
```shell
aws ec2 get-console-output --region ${REGION} --instance-id ${INSTANCE_ID} --output text
```

### Check if the RDP port is open in the security group
```shell
aws ec2 describe-security-groups --region ${REGION} --filters Name=group-name,Values=${SECURITY_GROUP_NAME} --query "SecurityGroups[].IpPermissions[?ToPort=='3389']" --output text
```

## Repair

### Check the EC2 instance's system and application logs for any errors or warnings that could provide clues to the cause of the unresponsiveness and RDP connection issue.
```shell


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


```

### Try rebooting the instance from the AWS CLI to see if that resolves the issue.
```shell
aws ec2 reboot-instances --instance-ids ${INSTANCE_ID}
```