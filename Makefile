.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = /etc/rancher/k3s/k3s.yml
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: cluster system external smoke-test post-install clean

configure:
	./scripts/configure
	git status

cluster:
	ansible-playbook \
		--inventory inventory.yml \
		k3s-ansible/playbook/site.yml

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

clean:
	docker compose --project-directory ./metal/roles/pxe_server/files down

docs:
	mkdocs serve

git-hooks:
	pre-commit install
