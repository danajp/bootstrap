.PHONY: bootstrap
bootstrap:
	./bootstrap.sh

.PHONY: provision
provision:
	ansible-playbook --become provision.yml
