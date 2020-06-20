provider "aws" {
  region  = "ap-southeast-1"
}

resource "aws_organizations_policy" "scp-leave-org" {
#  name = "scp_organizations"
  name = "scp-leave-org"
  description = "This SCP prevents users or roles in any affected account from leaving AWS Organizations, either directly as a command or through the console. "
   content = file("scp-leave-org.json")
#  content = jsondecode(file("${path.module}/scp-leave-org.json"))
#  content = <<POLICY
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": [
#        "organizations:LeaveOrganization"
#      ],
#      "Resource": "*",
#      "Effect": "Deny"
#    }
#  ]
#}
#POLICY

}

resource "aws_organizations_policy" "ScpPolicy2" {
  name = "scp_account_billing"
  description = "This SCP prevents users or roles in any affected account from modifying the account and billing settings, either directly as a command or through the console."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "aws-portal:ModifyAccount",
        "aws-portal:ModifyBilling",
        "aws-portal:ModifyPaymentMethods"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy3" {
  name = "scp_deny_iam_user_creation"
  description = "This SCP restricts IAM principals from creating new IAM users or IAM Access Keys in an AWS account."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:CreateUser",
        "iam:CreateAccessKey"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Deny"
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "ScpPolicy4" {
  name = "scp_s3_block_public_access"
  description = "This SCP prevents users or roles in any affected account from modifying the S3 Block Public Access Settings in an Account."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutBucketPublicAccessBlock"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}



#############################################################
#provider "aws" {
#    version = "~> 2.0"
#    region  = "us-east-1"
#}

## Deploy Account AWS Org SCPs
#module "account" {
#  source = "./modules/account"

#  target_id = var.target_id
#}

## Deploy AWS Config AWS Org SCPs
#module "awsconfig" {
#  source = "./modules/awsconfig"

#  target_id = var.target_id
#}

## Deploy CloudTrail AWS Org SCPs
#module "cloudtrail" {
#  source = "./modules/cloudtrail"

#  target_id = var.target_id
#}

## Deploy EC2 AWS Org SCPs
#module "ec2" {
#  source = "./modules/ec2"

#  target_id         = var.target_id
#  ami_creator_account = var.ami_creator_account
#  ami_tag_key       = var.ami_tag_key
#  ami_tag_value     = var.ami_tag_value
#}

## Deploy GuardDuty AWS Org SCPs
#module "guardduty" {
#  source = "./modules/guardduty"

#  target_id = var.target_id
#}

## Deploy IAM Aws Org SCPs
#module "iam" {
#  source = "./modules/iam"

#  target_id = var.target_id
#}

## Deploy AWS Organizations SCPs
#module "organizations" {
#  source = "./modules/organizations"

#  target_id = var.target_id
#}

## Deploy S3 AWS Org SCPs
#module "s3" {
#  source = "./modules/s3"

#  target_id       = var.target_id
#  region_lockdown = var.region_lockdown
#}

## Deploy Shield AWS Org SCPs
#module "shield" {
#  source = "./modules/shield"

#  target_id = var.target_id
#}

## Deploy VPC AWS Org SCPs
#module "vpc" {
#  source = "./modules/vpc"

#  target_id = var.target_id
#}

