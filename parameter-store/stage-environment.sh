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
    --value "JingNV-Training" \
	--profile $1 \
    --region $2

aws ssm put-parameter \
    --name "VPCId" \
    --type "String" \
    --value "vpc-0e89f4904fcf2e20c" \
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
    --value "subnet-0d9071e7b96a2fe75,subnet-07f42585e44249b68,subnet-0645b2222530ced5e" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "PublicSubnetList" \
    --type "StringList" \
    --value "subnet-0a7729a9fdebf9437,subnet-0e4c697665d6367ff,subnet-04c98816f0a1b928f" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "ExternalHostedZoneName" \
    --type "String" \
    --value "1strategy-training.com." \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "ExternalRecordSetName" \
    --type "String" \
    --value "1s-jingprod" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "PrivateDNSHostedZoneName" \
    --type "String" \
    --value "internal.1strategy-training.com." \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "CertificateArn" \
    --type "String" \
    --value "arn:aws:acm:us-east-1:281782457076:certificate/6dcae0f8-28df-493e-8d57-f63ceded2ca1" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "AmazonCloudWatch-Analysis-Server-CW-Config" \
    --type "String" \
    --value "{
	"logs": {
		"logs_collected": {
			"files": {
				"collect_list": [
					{
						"file_path": "/var/log/pipeline.log",
						"log_group_name": "idbydna/analysis-server-pipeline-log",
						"log_stream_name": "analysisserver-{instance_id}"
					},
					{
						"file_path": "/var/log/core-analysis.log",
						"log_group_name": "idbydna/analysis-server-core-analysis-log",
						"log_stream_name": "analysisserver-{instance_id}"
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
    --name "PrivateSubnetId" \
    --type "String" \
    --value "subnet-0d9071e7b96a2fe75" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "EFSVolumeId" \
    --type "String" \
    --value "fs-eb93d508" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "EFSMountTargateSecurityGroupId" \
    --type "String" \
    --value "sg-096fea6d02fb4b967" \
    --profile $1 \
    --region $2

aws ssm put-parameter \
    --name "AnalysisServerCleanupSNSTopic" \
    --type "String" \
    --value "arn:aws:sns:us-east-1:281782457076:trigger-cleanup-lambda" \
    --profile $1 \
    --region $2
