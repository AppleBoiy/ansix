# AWS Setup Guide

Setup AWS EC2 provisioning and deployment for the ansix project.

## Prerequisites

- AWS Account with appropriate permissions
- AWS CLI installed and configured
- Python with boto3/botocore packages
- Ansible collections installed

## Setup Steps

### 1. Install Dependencies

```bash
pip install boto3 botocore
make install-deps
```

### 2. Configure AWS Credentials

```bash
aws configure  # Recommended method
```

Alternative methods:
- Environment variables: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`
- IAM roles (when running from EC2)

### 3. Configure Project Variables

```bash
make setup-aws-vars
# Edit vars/aws-vars.yml with your settings
```

## Deployment

```bash
# Full deployment (provision + configure)
make aws-deploy

# Step-by-step
make aws-provision   # Provision instance
make aws-configure   # Configure instance
```

## Configuration Options

Key variables in `vars/aws-vars.yml`:

- `ec2_image`: AMI ID (defaults to Amazon Linux 2)
- `ec2_instance_type`: Instance size (default: t3.micro)
- `ssh_user`: Login user (ec2-user for Amazon Linux, ubuntu for Ubuntu)
- `aws_region`: AWS region for deployment

## Troubleshooting

### Common Issues

- **Permission Denied**: Ensure AWS credentials have EC2 permissions
- **Key Pair Exists**: Change `ec2_key_name` in aws-vars.yml
- **AMI Not Found**: Update `ec2_image` with correct regional AMI ID
- **SSH Issues**: Check security group and SSH key permissions

### Validation Commands

```bash
make aws-check      # Check syntax
make aws-dry-run    # Show changes
aws ec2 describe-instances  # Test AWS access
```

## Cleanup

Terminate instances to avoid charges:

```bash
aws ec2 terminate-instances --instance-ids INSTANCE_ID
```

Or use AWS Console: EC2 > Instances > Actions > Terminate

## Cost Notes

- t3.micro instances are Free Tier eligible (750 hours/month)
- Always terminate unused instances
- Monitor usage to avoid unexpected charges
