.PHONY: bootstrap
bootstrap:
	./bootstrap.sh

.PHONY: provision
provision:
	ansible-playbook -K provision.yml
