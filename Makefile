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

.PHONY: tags
tags:
	PATH=/usr/bin ansible-playbook -K provision.yml --tags $(TAGS)

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
	$(error No ssh key found at $(SSH_KEY), you\'re gonna need this to clone git repos)

.PHONY: backup
backup:
	tar -czpf "$(TARGET)" -C "$(HOME)" \
		--exclude "VirtualBox VMs" \
		--exclude "Dropbox (Greenhouse)" \
		--exclude .cache \
		--exclude .cask \
		--exclude .dajoku-cli \
		--exclude .dbus \
		--exclude .dropbox \
		--exclude .dropbox-dist \
		--exclude .gem \
		--exclude .local/share/Trash \
		--exclude .minikube \
		--exclude .pack \
		--exclude .pyenv \
		--exclude .rbenv \
		--exclude .terraform-plugin-cache \
		--exclude .tfenv \
		--exclude .vagrant.d \
		--exclude .wine \
		--exclude old-home.tar.gz \
		--exclude secrets \
		.
	sha1sum "$(TARGET)" > "$(TARGET).sha1"
