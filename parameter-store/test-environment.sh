#!/bin/bash

aws ssm put-parameter \
    --name "AmazonCloudWatch-Review-Portal-CW-Config" \
    --type "String" \
    --value "{
	"logs": {
		"logs_collected": {
			"files": {
				"collect_list": [
					{
						"file_path": "/var/log/nginx-access.log",
						"log_group_name": "idbydna/review-portal-nginx-access-log",
						"log_stream_name": "reviewportal-{instance_id}"
					},
					{
						"file_path": "/var/log/nginx-error.log",
						"log_group_name": "idbydna/review-portal-nginx-error-log",
						"log_stream_name": "reviewportal-{instance_id}"
					},
					{
						"file_path": "/var/log/review-portal-stdout.log",
						"log_group_name": "idbydna/review-portal-stdout-log",
						"log_stream_name": "reviewportal-{instance_id}"
					},
					{
						"file_path": "/var/log/review-portal-stderr.log",
						"log_group_name": "idbydna/review-portal-stderr-log",
						"log_stream_name": "reviewportal-{instance_id}"
					}
				]
			}
		}
	},
	"metrics": {
		"append_dimensions": {
			"AutoScalingGroupName": "${aws:AutoScalingGroupName}",
			"ImageId": "${aws:ImageId}",
			"InstanceId": "${aws:InstanceId}",
			"InstanceType": "${aws:InstanceType}"
		},
		"metrics_collected": {
			"cpu": {
				"measurement": [
					"cpu_usage_idle",
					"cpu_usage_iowait",
					"cpu_usage_user",
					"cpu_usage_system"
				],
				"metrics_collection_interval": 30,
				"resources": [
					"*"
				],
				"totalcpu": false
			},
			"disk": {
				"measurement": [
					"used_percent",
					"inodes_free"
				],
				"metrics_collection_interval": 30,
				"resources": [
					"*"
				]
			},
			"diskio": {
				"measurement": [
					"io_time"
				],
				"metrics_collection_interval": 30,
				"resources": [
					"*"
				]
			},
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
				"metrics_collection_interval": 30
			},
			"swap": {
				"measurement": [
					"swap_used_percent"
				],
				"metrics_collection_interval": 30
			}
		}
	}
}" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "EC2KeyPairName" \
    --type "String" \
    --value "JingNVKeyPair" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "VPCId" \
    --type "String" \
    --value "vpc-05ad25cd042facb61" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "VPCCidrBlock" \
    --type "String" \
    --value "10.64.0.0/16" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "PrivateSubnetList" \
    --type "StringList" \
    --value "subnet-0c1df95c81e4f0b48,subnet-0a7ff68fb72c66823,subnet-00b6b2301230ca831" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "PublicSubnetList" \
    --type "StringList" \
    --value "subnet-0fba18d11f5066df4,subnet-05fda5d3c1d844f7d,subnet-012a43b6b39f9233d" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "ExternalHostedZoneName" \
    --type "String" \
    --value "1strategy-sandbox.com" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "ExternalRecordSetName" \
    --type "String" \
    --value "1s-jingtest" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "PrivateDNSHostedZoneName" \
    --type "String" \
    --value "internal.1strategy-sandbox.com." \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "CertificateArn" \
    --type "String" \
    --value "arn:aws:acm:us-east-1:842337631775:certificate/4c676396-4c8f-41fd-b5a3-7b71cf35adff" \
    --profile $1 \
    --region $2
