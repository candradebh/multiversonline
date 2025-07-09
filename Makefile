.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:


SUBMODULE_DIR = k3s-ansible
PLAYBOOK_K3S_SITE = playbooks/site.yml
PLAYBOOK_K3S_RESET = playbooks/reset.yml
PLAYBOOK_K3S_POST_INSTALL = ./roles/post-install.yml

# KUBECONFIG = $(shell pwd)/metal/kubeconfig.yaml
KUBECONFIG = ~/.kube/config
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: k3s-ansible namespaces copy-project python-install helm cilium make-master

cluster: k3s-ansible namespaces copy-project python-install helm cilium make-master

apps: namespaces copy-project cilium make-master


# para ajustar external (tem que rodar dentro do cluster)  system  post-install (nunca funcionou)
k3s-ansible:
	cd k3s-ansible && \
    	ansible-playbook $(PLAYBOOK_K3S_SITE) -i ../inventory.yml

python-install:
	ansible-playbook ./roles/python-install.yml -i inventory.yml

namespaces:
	ansible-playbook ./roles/namespaces.yml -i inventory.yml

copy-project:
	ansible-playbook ./roles/copy-project.yml -i inventory.yml

metal-lb:
	ansible-playbook ./roles/metal-lb.yml -i inventory.yml

helm:
	ansible-playbook ./roles/heml.yml -i inventory.yml

cilium:
	ansible-playbook ./roles/cilium.yml -i inventory.yml

make-master:
	ansible-playbook ./roles/make-master.yml -i inventory.yml

portainer:
	ansible-playbook ./roles/portainer.yml -i inventory.yml

post-install:
	@./scripts/hacks

system:
	make -C system

external:
	make -C external

smoke-test:
	make -C test filter=Smoke



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
