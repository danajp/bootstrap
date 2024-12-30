ANSIBLE?=/usr/bin/ansible
SSH_KEY?=~/.ssh/id_rsa
IMAGE?=bootstrap
USER?=dana

ifneq ($(strip $(TAGS)),)
override TAGS := --tags $(TAGS)
endif

.PHONY: base
base: $(ANSIBLE) $(SSH_KEY)
	ansible-playbook -K base.yaml -e @vars.yaml $(TAGS) $(ARGS)

.PHONY: user
user: $(ANSIBLE) $(SSH_KEY)
	ansible-playbook -K user.yaml -e @vars.yaml $(TAGS) $(ARGS)

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

.PHONY: bootstrap
bootstrap:
	./bin/bootstrap

.PHONY: nix
nix:
	curl -L https://nixos.org/nix/install | sh -- --daemon
	nix-env -iA cachix -f https://cachix.org/api/v1/install
	cachix use devenv
	nix-env -if https://install.devenv.sh/latest
