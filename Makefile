.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = ~/.kube/config
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: k3s-ansible namespaces copy-project python-install helm cilium make-master

cluster: k3s-ansible namespaces copy-project python-install helm cilium make-master

apps: namespaces copy-project cilium make-master


# para ajustar external (tem que rodar dentro do cluster)  system  post-install (nunca funcionou)
k3s-ansible:
	make -C k3s-ansible

python-install:
	ansible-playbook ./roles/python-install.yml -i inventory.yml

namespaces:
	ansible-playbook ./roles/namespaces.yml -i inventory.yml

namespaces_delete:
	ansible-playbook ./roles/namespaces_delete.yml -i inventory.yml

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

passwords:
	ansible-playbook ./roles/passwords.yml -i inventory.yml

kanidm-recovery-pass:
	ansible-playbook ./roles/reset_kanin_pass.yml -i inventory.yml > logs/kanin_pass_make.log 2>&1

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
    	ansible-playbook playbooks/reset.yml -i ../inventory.yml

docs:
	mkdocs serve

git-hooks:
	pre-commit install
