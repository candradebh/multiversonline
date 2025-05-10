.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:


SUBMODULE_DIR = k3s-ansible
PLAYBOOK_K3S_SITE = playbooks/site.yml
PLAYBOOK_K3S_RESET = playbooks/reset.yml
PLAYBOOK_K3S_CILIUM = ./roles/cilium.yml
PLAYBOOK_K3S_HEML = ./roles/heml.yml

# KUBECONFIG = $(shell pwd)/metal/kubeconfig.yaml
KUBECONFIG = /home/carlos/.kube/config
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: k3s-ansible helm cilium system external post-install

k3s-ansible:
	cd k3s-ansible && \
    	ansible-playbook $(PLAYBOOK_K3S_SITE) -i ../inventory.yml

helm:
	ansible-playbook $(PLAYBOOK_K3S_HEML) -i inventory.yml

cilium:
	ansible-playbook $(PLAYBOOK_K3S_CILIUM) -i inventory.yml

system:
	make -C system

external:
	make -C external

smoke-test:
	make -C test filter=Smoke

post-install:
	@./scripts/hacks

# TODO maybe there's a better way to manage backup with GitOps?
backup:
	./scripts/backup --action setup --namespace=actualbudget --pvc=actualbudget-data
	./scripts/backup --action setup --namespace=jellyfin --pvc=jellyfin-data

restore:
	./scripts/backup --action restore --namespace=actualbudget --pvc=actualbudget-data
	./scripts/backup --action restore --namespace=jellyfin --pvc=jellyfin-data

test:
	make -C test

reset:
	cd k3s-ansible && \
    	ansible-playbook $(PLAYBOOK_K3S_RESET) -i ../inventory.yml

docs:
	mkdocs serve

git-hooks:
	pre-commit install
