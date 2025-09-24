# ANSIX - Ansible Configuration Management

Ansible project for Linux server configuration management with AWS EC2 provisioning capabilities.

## Quick Start

```bash
# Local deployment
make run

# AWS deployment
make aws-deploy
```

## Features

- Multi-platform support (Ubuntu/Debian, RHEL/CentOS/Amazon Linux)
- Role-based architecture with modular components
- AWS EC2 integration with complete provisioning
- Security-focused with proper permissions and access control
- Tag-based execution for selective role deployment

## Requirements

- Ansible >= 2.9
- Python >= 3.6
- AWS CLI (for AWS deployments)
- Boto3/Botocore (for AWS operations)

```bash
ansible-galaxy collection install -r requirements.yml
pip install boto3 botocore
```

## Documentation

- [Project Documentation](docs/README.md) - Original requirements and setup
- [AWS Setup Guide](docs/AWS-SETUP.md) - AWS deployment configuration
- [WARP Guidelines](docs/WARP.md) - AI assistant integration

Run `make help` for all available commands.
