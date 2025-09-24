# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is an Ansible configuration management project (`ansix`) that demonstrates infrastructure automation for Linux server setup. The project creates a complete web server environment with Nginx, security hardening, and application deployment capabilities.

## Project Structure

The project follows Ansible best practices with organized directories:

```
ansix/
├── playbooks/              # Ansible playbooks
│   ├── setup.yml          # Main server configuration
│   ├── deploy-to-aws.yml  # AWS deployment playbook
│   └── provision-ec2.yml  # EC2 provisioning only
├── inventories/            # Inventory configurations
│   ├── inventory.ini      # Static servers
│   └── inventory-aws.ini  # AWS/EC2 servers
├── vars/                   # Variable files
│   └── aws-vars.yml.example # AWS configuration template
├── roles/                  # Ansible roles
│   ├── base/              # Basic server setup
│   ├── nginx/             # Web server configuration
│   ├── app/               # Application deployment
│   ├── ssh/               # SSH access management
│   └── aws/               # AWS infrastructure provisioning
├── docs/                   # Documentation
└── logs/                   # Ansible logs
```

## Architecture

The project follows Ansible's role-based architecture pattern:

- **Main Playbook**: `playbooks/setup.yml` orchestrates all roles with proper tagging
- **Inventory**: `inventories/inventory.ini` defines target servers (webservers group)
- **Role Structure**: Five specialized roles handle different aspects of server configuration
  
### Role Architecture

1. **base role**: Foundation server setup
   - Cross-platform package management (Debian/Ubuntu via apt, RHEL/CentOS via yum)
   - System updates and essential utilities installation
   - EPEL repository enablement for RHEL-based systems

2. **ssh role**: SSH access management
   - SSH directory creation and permissions (0700)
   - Public key deployment via authorized_keys

3. **nginx role**: Web server setup
   - Nginx installation and service management
   - Custom configuration deployment with handlers
   - Configuration validation before restart

4. **app role**: Application deployment
   - Static website deployment via tarball extraction
   - File ownership and permission management (www-data)
   - Alternative GitHub-based deployment option

### Key Design Patterns

- **Conditional execution**: OS-family-specific tasks using `when` conditions
- **Idempotency**: All tasks are designed to be safely re-runnable
- **Handler-driven restarts**: Service restarts only occur when configuration changes
- **Security-first approach**: Proper file permissions and ownership throughout

## Common Development Commands

### Core Operations
```bash
make run        # Run complete playbook
make check      # Validate syntax
make dry-run    # Show changes without applying
make help       # View all commands
```

### Role-Specific Execution
```bash
make base       # Basic server setup
make nginx      # Web server setup
make app        # Application deployment
make ssh        # SSH configuration
```

### Utility Commands
```bash
make setup-aws-vars  # Setup AWS variables
make install-deps    # Install collections
make tree           # View project structure
make clean          # Clean temporary files
```

## Configuration Requirements

1. **Inventory**: Update `inventories/inventory.ini` with server details
2. **SSH Keys**: Ensure SSH public key is accessible for roles
3. **Website Content**: Place static site files in `roles/app/files/`
4. **AWS Variables**: Run `make setup-aws-vars` and edit configuration

## Project Context

This project serves as a roadmap.sh configuration management challenge, demonstrating:
- Multi-role Ansible playbook design
- Cross-platform Linux administration
- Infrastructure as Code principles
- Security-conscious server hardening
- Tag-based selective execution

The codebase prioritizes maintainability through clear role separation and supports both development and production deployment scenarios.

## AWS/EC2 Deployment

### AWS Role Architecture

5. **aws role**: EC2 infrastructure provisioning
   - EC2 instance creation and security group configuration
   - SSH key pair management and dynamic inventory population

### AWS Commands

```bash
make aws-deploy     # Full deployment (provision + configure)
make aws-provision  # Provision EC2 only
make aws-configure  # Configure existing instance
make aws-check      # Validate AWS playbook
```

### AWS Setup

1. Configure AWS credentials (CLI, environment variables, or IAM roles)
2. Install dependencies: `make install-deps`
3. Setup variables: `make setup-aws-vars`
4. Edit `vars/aws-vars.yml` with your AWS settings
