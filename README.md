# MultiVersOnline

## CRIAR VMS

CRIAR AS VMS adicionar ipfixo no router

habilitar root

``` 
sudo passwd root

sudo nano /etc/ssh/sshd_config
PermitRootLogin yes

sudo systemctl restart ssh

sudo hostnamectl set-hostname kubmaster1

sudo nano /etc/hosts

127.0.1.1  kubmaster1
```
System 

DEX
cloudflared
renovate
woodpecker
zot
gitea
external-secrets

plataform
## Problemas 
remova o ip adicionado pois nao encontrei onde ele adiciona isso.
sudo ip addr del 192.168.1.48/32 dev ens18


### Pyaml Erro ao instalar cillium

nix-shell -p python311Packages.ansible python311Packages.pyyaml

### KUB

``` 
kubectl delete all --all -n cilium
kubectl delete pvc --all -n cilium
kubectl delete configmap --all -n cilium
kubectl delete secret --all -n cilium

```

## cONECTAR FONTE EXTERTAL 


## Instalar k3s para criar o controlpane

```
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable traefik --flannel-backend none" sh -

sudo chmod 644 /etc/rancher/k3s/k3s.yaml

kubectl get pod --all-namespaces


```
![img_1.png](img_1.png)

### Configurações

```

```

### SSH 

Failed to connect to the host via ssh: carlos@192.168.1.12: Permission denied (publickey,password).
``` 
ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.1.50
```

### Instalar o Helm 

``` 
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

helm version


```

### Instalar o cilium

```
helm repo add cilium https://helm.cilium.io
helm repo update

helm install cilium cilium/cilium \
  --version 1.17.3 \
  --namespace kube-system \

cilium version

SE ERRO DE PORTA
kubectl -n kube-system scale deployment cilium-operator --replicas=1

```

### Desinstalar k3s 
sudo /usr/local/bin/k3s-uninstall.sh


## Deployer 
![img.png](img.png)

### Dependencias 

#### NIX 

```
sh <(curl -L https://nixos.org/nix/install) --daemon
apt install nix-bin

#configuracao
mkdir -p ~/.config/nix
nano ~/.config/nix/nix.conf

#adicione essa linha
experimental-features = nix-command flakes
```



#### MAKE

```
sudo apt install build-essential
apt install make
```

#### CLONAR

```
#se nao tiver arquivo chave
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

#clonar
git clone git@github.com:candradebh/homelab1.git
```

## Terraform

cp ./files_secrets/credentials.tfrc.json /root/.terraform.d/

tofu destroy

## CLoudflare 
token dns e tunel: Jwy9Iy_PvIEs3LBDz4AAU5x23ZHidbANAoiEfNAS

```
curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
     -H "Authorization: Bearer Jwy9Iy_PvIEs3LBDz4AAU5x23ZHidbANAoiEfNAS" \
     -H "Content-Type:application/json"
```

## TUNEL
cloudflared.exe service install eyJhIjoiNDc1MzdmZjRjYWY1ZWM2MDVkMGNmYjM1YTBhMGY2ZWQiLCJ0IjoiMzJiZWNlZGItMWNiZC00Y2RlLWI2YzctOWUxNjYzZWU0ODQ1IiwicyI6Ik5XSmpZbUl4TURBdE1USm1PUzAwTURSaUxUaGtaVFV0WlRka01EazFNREV5WkRjNCJ9


## TEM QUE INSTALAR 

### tofu
snap install --classic opentofu

### novim

### ansible


### go 
sudo apt install golang-1.22 golang-1.22-go golang-1.22-src golang-1.22-doc -y

#### gotestsum 
apt install gotestsum


### ERRO Failed to connect to the host via ssh: root@192.168.1.48: Permission denied (publickey,password).



### Erro de locale 

ERROR: Ansible could not initialize the preferred locale: unsupported locale setting


Adicionar ao bash
```
nano ~/.bashrc
```

Adicione ao final da linha
```
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
```

Carregue
```
source ~/.bashrc
```

## Testes

```
make test filter=ArgoCDCheck

ou

cd test
gotestsum --format testname -- -timeout 5m -run "ArgoCDCheck"
```



# 🏡 Homelab Multiverso Online

Este repositório define a infraestrutura do projeto **Homelab Multiverso Online**, uma nuvem caseira automatizada com foco em aprendizado, hospedagem de serviços e GitOps.

## 📀 Infraestrutura
- **Hypervisor**: Proxmox
- **Orquestrador**: Kubernetes (K3s)
- **Provisionamento**: OpenTofu
- **Fluxo GitOps**: FluxCD
- **DNS/Túnel Seguro**: Cloudflare
- **Scripts & Automacoes**: Makefile + Bash/Python

## ⚙️ Principais Componentes
- **Gitea**: Git self-hosted
- **ArgoCD**: Deploy GitOps
- **ntfy**: Notificações via webhook
- **Pi-hole**: DNS e bloqueio de propagandas
- **Secrets & Configs**: Armazenados em Kubernetes (namespaces dedicados)

## ✨ Objetivos
- Centralizar e automatizar o deploy de aplicações
- Aprendizado em DevOps, Kubernetes, GitOps
- Hospedar serviços web, páginas e ferramentas pessoais

## ⚡ Tecnologias Utilizadas
- Proxmox VE 8
- Ubuntu Server (como base nas VMs)
- K3s Kubernetes
- OpenTofu (Terraform fork)
- FluxCD
- Helm
- Cloudflare API

## 🔧 Execução

```bash
# Inicializa provisionamento externo
make external

# Instala secrets, ArgoCD, ntfy, etc
make post-install

# Verifica pods rodando
kubectl get pods -A
```

---

Desenvolvido com <3 por Carlos Andrade
