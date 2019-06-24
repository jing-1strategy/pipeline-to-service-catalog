# Manage Cloudformation Templates and Pipelines

## Step 0: Set Up Prerequisites

1. Generate Github personal access tokens

You need personal access tokens to access your GitHub repositories and retrieve the latest changes when you use the CLI, SDK, or AWS CloudFormation to create or update your pipeline. As a security best practice, do not share a single token across multiple applications, Create a personal access token for each application.

* In GitHub, from the drop-down option on your profile photo, choose Settings.

* Choose Developer settings, and then choose Personal access tokens.

* Choose Generate new token.

* Under Select scopes, select admin:repo_hook and repo.

* Choose Generate token.

* Next to the generated token, choose the copy icon. (Make sure you copy your generated token at this time. You cannot view the token after you close this page.)

## Set up CodePipeline for WebPortal

## Step 1: Deploy prerequisites-step1.yaml in the shared-services account
This template will create below resource and will be used by other templates:

* S3 bucket for CodePipeline artifacts, with bucket policy to allow access from application accounts (test, stage and prod).

* KMS customer master keys (CMKs) used to encrypt the above S3 bucket, with key policy to allow access from application accounts (test, stage and prod).

## Step 2: Deploy review-portal-asg-step2.yaml to all application accounts 
This template will create the webportal environment including web server, autoscaling group, application load balancers and DNS records.

Please update the parameters with the account specific info.

## Step 3: Deploy webportal-codedeploy-step3 to all application accounts
This template will create CodeDeploy applicaion and deployment group with IAM roles and policies in the application accounts. It will also help set up the trust relationship of the cross account role to allow to be consumed by the Shared-Services account. 

This template will create below resource:

* CodeDeployApplication
* CodeDeployDeploymentGroup
* CrossAccountCodeDeployPolicy
* CrossAccountCodeDeployServiceRole

## Step 4: Deploy webportal-codepipeline-step4.yaml in the shared-services account
This template will create a CodePipeline in the shared-service account to get source code from Github, build the code using CodeBuild. Allow codepipeline IAM role assume CrossAccountCodeDeployServiceRole in the application accounts.

This template will create below resource:
* AppPipelineWebhook
* CodeBuildPolicy, CodeBuildRole, CodeBuildProject
* PipelinePolicy, PipelineRole, WebPortalPipeline

## Update the pipeline adding deployment stages
You cannot use the CodePipeline console to create or edit a pipeline that uses resources associated with another AWS account. However, you can use the console to create the general structure of the pipeline, and then use the AWS CLI to edit the pipeline and add those resources.

1. At a terminal, run the get-pipeline command on the pipeline to which you want to add resources. e.g. codepipeline-demo-CodePipeline

```shell
aws codepipeline get-pipeline --name codepipeline-demo-CodePipeline > pipeline.json
```

2. Open the JSON file in any text editor, add the deployment stages to the pipeline, save the file.

3. Run the update-pipeline command to apply your changes, specifying the pipeline JSON file

```
aws codepipeline update-pipeline --cli-input-json file://pipeline.json
```
