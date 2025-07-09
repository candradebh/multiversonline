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

# Cria e configura o cluster kubernets
make k3s-ansible

make helm

make cillium

make namespaces

make system 

# entrei na maquina e executei o tofu aply de la 
tofu apply -auto-aprove

# nunca consegui
make post-install

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
vKRkgP3PozkwuZtJ

# Verifica pods rodando
kubectl get pods -A
```


## APOS INSTALACAO

Em kubmaster1


kubectl exec -it -n kanidm statefulset/kanidm -- kanidmd recover-account admin
Z1QMrLQAAN012c73xSkB4a03CAeE188Wwu5BkgVhPbqTRSZ9B8

kubectl exec -it -n kanidm statefulset/kanidm -- kanidmd recover-account idm_admin

ucbN0VV3MYQhLpA8WcBRjZZxxQvq9dhSLdS0RCr1wMJAahzF




###############################
ADICIONAR O METAL LB NO DELOY

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.5/config/manifests/metallb-native.yaml

# metallb-config.yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
name: lb-pool
namespace: metallb-system
spec:
addresses:
- 192.168.1.240-192.168.1.250

---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
name: lb-adv
namespace: metallb-system



kubectl apply -f metallb-config.yaml


###############################


# Pre-requisitos
 
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


# Clonar o repositório

```
git clone git@github.com:candradebh/multiversonline.git
```




# Estrutura

```

                    ┌──────────────────────────────────┐
                    │             SYSTEM               │
                    │                                  │
                    │  - Cilium (rede + segurança)     │
                    │  - ArgoCD (GitOps)               │
                    │  - ingress-nginx + cert-manager  │
                    │  - external-dns + cloudflared    │
                    │  - kured + volsync + rock-ceph   │
                    │  - loki + kube-prometheus-stack  │
                    └──────────────┬───────────────────┘
                                   │
                    ┌──────────────▼──────────────┐
                    │          PLATFORM           │
                    │                              │
                    │  - Woodpecker CI/CD          │
                    │  - Gitea (Git)               │
                    │  - Renovate (auto update)    │
                    │  - Zot (registro de imagem)  │
                    │  - External-Secrets + DEX    │
                    └──────────────┬───────────────┘
                                   │
                    ┌──────────────▼──────────────┐
                    │            APPS             │
                    │                              │
                    │  ActualBudget, Jellyfin, etc │
                    │  Wireguard, Tailscale        │
                    └──────────────────────────────┘

```

## UTIL 

````
# Copiar a config de um namespace para um aqrquibo json para editar
kubectl get namespace cilium-secrets -o json > cilium-secrets.json
 
# Para aplicar o arquivo editado: 
kubectl replace --raw "/api/v1/namespaces/cilium-secrets/finalize" -f ./cilium-secrets.json

````

## Problemas 
remova o ip adicionado pois nao encontrei onde ele adiciona isso.
sudo ip addr del 192.168.1.48/32 dev ens18


### Pyaml Erro ao instalar cillium

nix-shell -p python311Packages.ansible python311Packages.pyyaml

### KUB

``` 
kubectl delete pods --all -n dex
kubectl delete all --all -n dex
kubectl delete pvc --all -n dex
kubectl delete configmap --all -n dex
kubectl delete secret --all -n dex

```

## CONECTAR FONTE EXTERTAL 


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

### cilium

problemas com desintalacao

````
kubectl get namespace cilium-secrets -o json > cilium-secrets.json
nano cilium-secrets.json
kubectl replace --raw "/api/v1/namespaces/cilium-secrets/finalize" -f ./cilium-secrets.json
````




```

helm repo add cilium https://helm.cilium.io
helm repo update

API_SERVER_IP=127.0.0.1
# Kubeadm default is 6443
API_SERVER_PORT=6443
helm install cilium cilium/cilium --version 1.17.3 \
    --namespace kube-system \
    --set kubeProxyReplacement=true \
    --set k8sServiceHost=${API_SERVER_IP} \
    --set k8sServicePort=${API_SERVER_PORT}

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
cloudflared.exe service install eyJhIjoiNDc1MzdmZjRjYWY1ZWM2MDVkMGNmYjM1YTBhMGY2ZWQiLCJ0IjoiMzJiZWNlZGItMWNiZC00Y2RlLWI2YzctOWUxNjYzZWU0ODQ1IiwicyI6Ik5XSmpZbUl4TURBdE1USm1PUzAwTURSaUxUaGtaVFV0WlRka01EazFNREV5WkRjNCJ9CA


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



## MIGRACAO GODADY

Apontar para cloudflare em registro.br
```
sudo nano /etc/apache2/sites-available/embalardesc.com.br.conf
```

```
<VirtualHost *:9004>
    ServerName embalardesc.com.br
    ServerAlias www.embalardesc.com.br

    DocumentRoot /sites/embalardesc/public

    <Directory /sites/embalardesc/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/embalardesc_error.log
    CustomLog ${APACHE_LOG_DIR}/embalardesc_access.log combined
</VirtualHost>
```

sudo a2ensite embalardesc.com.br.conf

unzip cgi-bin.zip -d /sites/embalardesc/public

PORTS 
```
cd /sites/embalardesc/public
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip -d /sites/embalardesc/public
sudo mv wordpress/* .
sudo rm -rf wordpress latest.zip
```

```
sudo chown -R www-data:www-data /sites/embalardesc/public
sudo find /sites/embalardesc/public -type d -exec chmod 755 {} \;
sudo find /sites/embalardesc/public -type f -exec chmod 644 {} \;
```

sudo chown -R www-data:www-data /sites/flabelltda/public
sudo find /sites/flabelltda/public -type d -exec chmod 755 {} \;
sudo find /sites/flabelltda/public -type f -exec chmod 644 {} \;

````
cd /sites/oficinadoalberto/public
sudo cp wp-config-sample.php wp-config.php

# dados do banco
sudo nano wp-config.php

````

TASK [debug] *************************************************************************************************************************************************************************************************************************
ok: [192.168.1.50] => {
"msg": "Senha ArgoCD: BnnY7XcQnfqV0Qpe"
}
fatal: [192.168.1.51]: FAILED! => {"msg": "The task includes an option with an undefined variable.. 'dict object' has no attribute 'stdout'\n\nThe error appears to be in '/home/carlos/multiversonline/roles/senhas.yml': line 11, column 7, but may\nbe elsewhere in the file depending on the exact syntax problem.\n\nThe offending line appears to be:\n\n\n    - debug:\n      ^ here\n"}

TASK [Mostrar client_secret do kanidm.dex] *******************************************************************************************************************************************************************************************
ok: [192.168.1.50]

TASK [debug] *************************************************************************************************************************************************************************************************************************
ok: [192.168.1.50] => {
"msg": "Client Secret DEX Kanidm: "
}

TASK [Mostrar client_secret do dex.gitea] ********************************************************************************************************************************************************************************************
ok: [192.168.1.50]

TASK [debug] *************************************************************************************************************************************************************************************************************************
ok: [192.168.1.50] => {
"msg": "Client Secret DEX Gitea: WQ73gYR8g2JZLRMWKg1uGVbS5TEv3KhP"
}

TASK [Mostrar client_secret do dex.grafana] ******************************************************************************************************************************************************************************************
ok: [192.168.1.50]

TASK [debug] *************************************************************************************************************************************************************************************************************************
ok: [192.168.1.50] => {
"msg": "Client Secret DEX Grafana: uMWR83Qw8TmJTKZQPQBzwL1WtD5xV1m9"
}


Desenvolvido com <3 por Carlos Andrade
