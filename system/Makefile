.POSIX:

#export KUBECONFIG = $(shell pwd)/../metal/kubeconfig.yaml

.PHONY: bootstrap
bootstrap:
	ansible-playbook bootstrap.yml \
	-i ../inventory.yml -vvv
