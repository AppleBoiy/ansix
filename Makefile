INVENTORY=inventory.ini
PLAYBOOK=setup.yml

all: run

run:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK)

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
