ANSIBLE?=/usr/bin/ansible
SSH_KEY?=~/.ssh/id_rsa
IMAGE?=bootstrap
USER?=dana

.PHONY: provision
provision: $(ANSIBLE) $(SSH_KEY)
	ansible-playbook -K provision.yml

.PHONY: packages
packages: $(ANSIBLE)
	ansible-playbook -K provision.yml --tags packages

.PHONY: image
image:
	docker build -t $(IMAGE) .

.PHONY: test
test: image
	docker run -it --rm -v $(HOME)/.ssh:/home/$(USER)/.ssh $(IMAGE) ansible-playbook provision.yml

$(ANSIBLE):
	sudo apt-get update
	DEBIAN_FRONTEND=noninteractive sudo apt-get install -y ansible

$(SSH_KEY):
	$(error No ssh key found at $(SSH_KEY), you're gonna need this to clone git repos)
