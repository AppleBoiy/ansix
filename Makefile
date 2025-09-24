INVENTORY=inventories/inventory.ini
PLAYBOOK=playbooks/setup.yml
AWS_INVENTORY=inventories/inventory-aws.ini
AWS_PLAYBOOK=playbooks/deploy-to-aws.yml
PROVISION_PLAYBOOK=playbooks/provision-ec2.yml

all: run

help:
	@echo "ANSIX - Ansible Configuration Management"
	@echo ""
	@echo "Available targets:"
	@echo ""
	@echo "Local Server Management:"
	@echo "  run        - Run complete deployment playbook"
	@echo "  deploy     - Run deployment role (all components)"
	@echo "  base       - Run base system configuration only"
	@echo "  nginx      - Run nginx web server setup only"
	@echo "  app        - Run application deployment only"
	@echo "  ssh        - Run SSH configuration only"
	@echo "  check      - Validate playbook syntax"
	@echo "  dry-run    - Show what would change without applying"
	@echo ""
	@echo "AWS/EC2 Management:"
	@echo "  aws-deploy      - Full AWS deployment (provision + configure)"
	@echo "  aws-provision   - Provision EC2 instance only"
	@echo "  aws-configure   - Configure existing EC2 instance"
	@echo "  aws-provision-only - Provision using main playbook with tags"
	@echo "  aws-check       - Validate AWS playbook syntax"
	@echo "  aws-dry-run     - Dry run AWS configuration"
	@echo ""
	@echo "Project Structure:"
	@echo "  tree       - Show project structure"
	@echo "  clean      - Clean up temporary files"
	@echo ""

## Local server deployment
run:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK)

deploy:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --tags "deploy"

base:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --tags "base"

nginx:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --tags "nginx"

app:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --tags "app"

ssh:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --tags "ssh"

## Check syntax before running
check:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --syntax-check

## Dry-run (show what would change)
dry-run:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --check

## AWS/EC2 targets
aws-deploy:
	ansible-playbook -i $(AWS_INVENTORY) $(AWS_PLAYBOOK)

aws-provision:
	ansible-playbook -i $(AWS_INVENTORY) $(PROVISION_PLAYBOOK)

aws-configure:
	ansible-playbook -i $(AWS_INVENTORY) $(AWS_PLAYBOOK) --tags "configure"

aws-provision-only:
	ansible-playbook -i $(AWS_INVENTORY) $(AWS_PLAYBOOK) --tags "provision"

aws-check:
	ansible-playbook -i $(AWS_INVENTORY) $(AWS_PLAYBOOK) --syntax-check

aws-dry-run:
	ansible-playbook -i $(AWS_INVENTORY) $(AWS_PLAYBOOK) --check --tags "configure"

## Utility targets
tree:
	tree . -I '.git|__pycache__|*.pyc'

clean:
	rm -rf logs/*.log
	rm -rf .ansible/
	rm -rf *.retry
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete

setup-aws-vars:
	@if [ ! -f vars/aws-vars.yml ]; then \
		cp vars/aws-vars.yml.example vars/aws-vars.yml; \
		echo "Created vars/aws-vars.yml from example. Please edit it with your settings."; \
	else \
		echo "vars/aws-vars.yml already exists."; \
	fi

install-deps:
	ansible-galaxy collection install -r requirements.yml
	@echo "Install Python dependencies with: pip install boto3 botocore"
