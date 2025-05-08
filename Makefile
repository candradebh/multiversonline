.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = /etc/rancher/k3s/k3s.yml
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: k3s-ansible cilium

k3s-ansible:
	make -C k3s-ansible

cilium:
	ansible-playbook ./roles/cilium -i inventory-sample.yml

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
	ansible-playbook \
    		--inventory inventory.yml \
    		k3s-ansible/playbook/reset.yml

docs:
	mkdocs serve

git-hooks:
	pre-commit install
