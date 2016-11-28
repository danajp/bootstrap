.PHONY: bootstrap
bootstrap:
	./bootstrap.sh

.PHONY: provision
provision:
	ansible-playbook -K provision.yml

.PHONY: packages
packages:
	ansible-playbook -K provision.yml --tags packages
