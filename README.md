# MultiVersOnline



## Problemas 
remova o ip adicionado pois nao encontrei onde ele adiciona isso.
sudo ip addr del 192.168.1.48/32 dev ens18


### Pyaml Erro ao instalar cillium

nix-shell -p python311Packages.ansible python311Packages.pyyaml



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
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
echo 'export LC_ALL=C.UTF-8' >> ~/.bashrc
echo 'export LANG=C.UTF-8' >> ~/.bashrc
source ~/.bashrc



```

### SSH 

Failed to connect to the host via ssh: carlos@192.168.1.12: Permission denied (publickey,password).
``` 
ssh-copy-id -i ~/.ssh/id_rsa.pub carlos@192.168.1.6
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




**[Features](#features) • [Get Started](#get-started) • [Documentation](https://homelab.khuedoan.com)**

[![tag](https://img.shields.io/github/v/tag/khuedoan/homelab?style=flat-square&logo=semver&logoColor=white)](https://github.com/khuedoan/homelab/tags)
[![document](https://img.shields.io/website?label=document&logo=gitbook&logoColor=white&style=flat-square&url=https%3A%2F%2Fhomelab.khuedoan.com)](https://homelab.khuedoan.com)
[![license](https://img.shields.io/github/license/khuedoan/homelab?style=flat-square&logo=gnu&logoColor=white)](https://www.gnu.org/licenses/gpl-3.0.html)
[![stars](https://img.shields.io/github/stars/khuedoan/homelab?logo=github&logoColor=white&color=gold&style=flat-square)](https://github.com/khuedoan/homelab)

This project utilizes [Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code) and [GitOps](https://www.weave.works/technologies/gitops) to automate provisioning, operating, and updating self-hosted services in my homelab.
It can be used as a highly customizable framework to build your own homelab.

> **What is a homelab?**
>
> Homelab is a laboratory at home where you can self-host, experiment with new technologies, practice for certifications, and so on.
> For more information, please see the [r/homelab introduction](https://www.reddit.com/r/homelab/wiki/introduction) and the
> [Home Operations Discord community](https://discord.gg/home-operations) (formerly known as [k8s-at-home](https://k8s-at-home.com)).

If you encounter an issue, please create [a bug report](https://github.com/khuedoan/homelab/issues/new?template=bug_report.md)
(avoid asking for support about issues specific to this project in other communication channels).

## Overview

Project status: **ALPHA**

This project is still in the experimental stage, and I don't use anything critical on it.
Expect breaking changes that may require a complete redeployment.
A proper upgrade path is planned for the stable release.
More information can be found in [the roadmap](#roadmap) below.

### Hardware

![Hardware](https://user-images.githubusercontent.com/27996771/98970963-25137200-2543-11eb-8f2d-f9a2d45756ef.JPG)

- 4 × NEC SFF `PC-MK26ECZDR` (Japanese version of the ThinkCentre M700):
    - CPU: `Intel Core i5-6600T @ 2.70GHz`
    - RAM: `16GB`
    - SSD: `128GB`
- TP-Link `TL-SG108` switch:
    - Ports: `8`
    - Speed: `1000Mbps`

### Features

- [x] Common applications: Gitea, Jellyfin, Paperless...
- [x] Automated bare metal provisioning with PXE boot
- [x] Automated Kubernetes installation and management
- [x] Installing and managing applications using GitOps
- [x] Automatic rolling upgrade for OS and Kubernetes
- [x] Automatically update apps (with approval)
- [x] Modular architecture, easy to add or remove features/components
- [x] Automated certificate management
- [x] Automatically update DNS records for exposed services
- [x] VPN (Tailscale or Wireguard)
- [x] Expose services to the internet securely with [Cloudflare Tunnel](https://www.cloudflare.com/products/tunnel/)
- [x] CI/CD platform
- [x] Private container registry
- [x] Distributed storage
- [x] Support multiple environments (dev, prod)
- [x] Monitoring and alerting
- [x] Automated backup and restore
- [x] Single sign-on
- [x] Infrastructure testing

Some demo videos and screenshots are shown here.
They can't capture all the project's features, but they are sufficient to get a concept of it.

| Demo                                                                                                            |
| :--:                                                                                                            |
| [![][deploy-demo]](https://asciinema.org/a/xkBRkwC6e9RAzVuMDXH3nGHp7)                                           |
| Deploy with a single command (after updating the configuration files)                                           |
| [![][pxe-demo]](https://www.youtube.com/watch?v=y-d7btNNAT8)                                                    |
| PXE boot                                                                                                        |
| [![][hubble-demo]][hubble-demo]                                                                                 |
| Observe network traffic with Hubble, built on top of [Cilium](https://cilium.io) and eBPF                       |
| [![][homepage-demo]][homepage-demo]                                                                             |
| Homepage powered by... [Homepage](https://gethomepage.dev)                                                      |
| [![][grafana-demo]][grafana-demo]                                                                               |
| Monitoring dashboard powered by [Grafana](https://grafana.com)                                                  |
| [![][gitea-demo]][gitea-demo]                                                                                   |
| Git server powered by [Gitea](https://gitea.io/en-us)                                                           |
| [![][matrix-demo]][matrix-demo]                                                                                 |
| [Matrix](https://matrix.org/) chat server                                                                       |
| [![][woodpecker-demo]][woodpecker-demo]                                                                         |
| Continuous integration with [Woodpecker CI](https://woodpecker-ci.org)                                          |
| [![][argocd-demo]][argocd-demo]                                                                                 |
| Continuous deployment with [ArgoCD](https://argoproj.github.io/cd)                                              |
| [![][alert-demo]][alert-demo]                                                                                   |
| [ntfy](https://ntfy.sh) displaying received alerts                                                              |
| [![][ai-demo]][ai-demo]                                                                                         |
| Self-hosted AI powered by [Ollama](https://ollama.com) (experimental, not very fast because I don't have a GPU) |

[deploy-demo]: https://asciinema.org/a/xkBRkwC6e9RAzVuMDXH3nGHp7.svg
[pxe-demo]: https://user-images.githubusercontent.com/27996771/157303477-df2e7410-8f02-4648-a86c-71e6b7e89e35.png
[hubble-demo]: https://github.com/khuedoan/homelab/assets/27996771/9c6677d0-3564-47c0-852b-24b6a554b4a3
[homepage-demo]: https://github.com/khuedoan/homelab/assets/27996771/d0eaf620-be08-48d8-8420-40bcaa86093b
[grafana-demo]: https://github.com/khuedoan/homelab/assets/27996771/ad937b26-e9bc-4761-83ae-1c7f512ea97f
[gitea-demo]: https://github.com/khuedoan/homelab/assets/27996771/c245534f-88d9-4565-bde8-b39f60ccee9e
[matrix-demo]: https://user-images.githubusercontent.com/27996771/149448510-7163310c-2049-4ccd-901d-f11f605bfc32.png
[woodpecker-demo]: https://github.com/khuedoan/homelab/assets/27996771/5d887688-d20a-44c8-8f77-0c625527dfe4
[argocd-demo]: https://github.com/khuedoan/homelab/assets/27996771/527e2529-4fe1-4664-ab8a-b9eb3c492d20
[alert-demo]: https://github.com/khuedoan/homelab/assets/27996771/c922f755-e911-4ca0-9d4a-6e552d387f18
[ai-demo]: https://github.com/khuedoan/homelab/assets/27996771/d77ba511-00b7-47c3-9032-55679a099e70

### Tech stack

<table>
    <tr>
        <th>Logo</th>
        <th>Name</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><img width="32" src="https://simpleicons.org/icons/ansible.svg" alt=""></td>
        <td><a href="https://www.ansible.com">Ansible</a></td>
        <td>Automate bare metal provisioning and configuration</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/30269780" alt=""></td>
        <td><a href="https://argoproj.github.io/cd">ArgoCD</a></td>
        <td>GitOps tool built to deploy applications to Kubernetes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://github.com/jetstack/cert-manager/raw/master/logo/logo.png" alt=""></td>
        <td><a href="https://cert-manager.io">cert-manager</a></td>
        <td>Cloud native certificate management</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/21054566?s=200&v=4" alt=""></td>
        <td><a href="https://cilium.io">Cilium</a></td>
        <td>eBPF-based Networking, Observability and Security (CNI, LB, Network Policy, etc.)</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/314135?s=200&v=4" alt=""></td>
        <td><a href="https://www.cloudflare.com">Cloudflare</a></td>
        <td>DNS and Tunnel</td>
    </tr>
    <tr>
        <td><img width="32" src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png" alt=""></td>
        <td><a href="https://www.docker.com">Docker</a></td>
        <td>Ephemeral PXE server</td>
    </tr>
    <tr>
        <td><img width="32" src="https://github.com/kubernetes-sigs/external-dns/raw/master/docs/img/external-dns.png" alt=""></td>
        <td><a href="https://github.com/kubernetes-sigs/external-dns">ExternalDNS</a></td>
        <td>Synchronizes exposed Kubernetes Services and Ingresses with DNS providers</td>
    </tr>
    <tr>
        <td><img width="32" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Fedora_logo.svg/267px-Fedora_logo.svg.png" alt=""></td>
        <td><a href="https://getfedora.org/en/server">Fedora Server</a></td>
        <td>Base OS for Kubernetes nodes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://upload.wikimedia.org/wikipedia/commons/b/bb/Gitea_Logo.svg"></td>
        <td><a href="https://gitea.com">Gitea</a></td>
        <td>Self-hosted Git service</td>
    </tr>
    <tr>
        <td><img width="32" src="https://grafana.com/static/img/menu/grafana2.svg"></td>
        <td><a href="https://grafana.com">Grafana</a></td>
        <td>Observability platform</td>
    </tr>
    <tr>
        <td><img width="32" src="https://helm.sh/img/helm.svg"></td>
        <td><a href="https://helm.sh">Helm</a></td>
        <td>The package manager for Kubernetes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/49319725"></td>
        <td><a href="https://k3s.io">K3s</a></td>
        <td>Lightweight distribution of Kubernetes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://kanidm.com/images/logo.svg"></td>
        <td><a href="https://kanidm.com">Kanidm</a></td>
        <td>Modern and simple identity management platform</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/13629408"></td>
        <td><a href="https://kubernetes.io">Kubernetes</a></td>
        <td>Container-orchestration system, the backbone of this project</td>
    </tr>
    <tr>
        <td><img width="32" src="https://github.com/grafana/loki/blob/main/docs/sources/logo.png?raw=true"></td>
        <td><a href="https://grafana.com/oss/loki">Loki</a></td>
        <td>Log aggregation system</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/1412239?s=200&v=4"></td>
        <td><a href="https://www.nginx.com">NGINX</a></td>
        <td>Kubernetes Ingress Controller</td>
    </tr>
    <tr>
        <td><img width="32" src="https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-colours.svg"></td>
        <td><a href="https://nixos.org">Nix</a></td>
        <td>Convenient development shell</td>
    </tr>
    <tr>
        <td><img width="32" src="https://ntfy.sh/_next/static/media/logo.077f6a13.svg"></td>
        <td><a href="https://ntfy.sh">ntfy</a></td>
        <td>Notification service to send notifications to your phone or desktop</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/3380462"></td>
        <td><a href="https://prometheus.io">Prometheus</a></td>
        <td>Systems monitoring and alerting toolkit</td>
    </tr>
    <tr>
        <td><img width="32" src="https://docs.renovatebot.com/assets/images/logo.png"></td>
        <td><a href="https://www.whitesourcesoftware.com/free-developer-tools/renovate">Renovate</a></td>
        <td>Automatically update dependencies</td>
    </tr>
    <tr>
        <td><img width="32" src="https://raw.githubusercontent.com/rook/artwork/master/logo/blue.svg"></td>
        <td><a href="https://rook.io">Rook Ceph</a></td>
        <td>Cloud-Native Storage for Kubernetes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/48932923?s=200&v=4"></td>
        <td><a href="https://tailscale.com">Tailscale</a></td>
        <td>VPN without port forwarding</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/13991055?s=200&v=4"></td>
        <td><a href="https://www.wireguard.com">Wireguard</a></td>
        <td>Fast, modern, secure VPN tunnel</td>
    </tr>
    <tr>
        <td><img width="32" src="https://avatars.githubusercontent.com/u/84780935?s=200&v=4"></td>
        <td><a href="https://woodpecker-ci.org">Woodpecker CI</a></td>
        <td>Simple yet powerful CI/CD engine with great extensibility</td>
    </tr>
    <tr>
        <td><img width="32" src="https://zotregistry.dev/v2.0.2/assets/images/logo.svg"></td>
        <td><a href="https://zotregistry.dev">Zot Registry</a></td>
        <td>Private container registry</td>
    </tr>
</table>

## Get Started

- [Try it out locally](https://homelab.khuedoan.com/installation/sandbox) without any hardware (just 4 commands!)
- [Deploy on real hardware](https://homelab.khuedoan.com/installation/production/prerequisites) for production workload

## Roadmap

See [roadmap](https://homelab.khuedoan.com/reference/roadmap) and [open issues](https://github.com/khuedoan/homelab/issues) for a list of proposed features and known issues.

## Contributing

Any contributions you make are greatly appreciated.

Please see [contributing guide](https://homelab.khuedoan.com/reference/contributing) for more information.

## License

Copyright &copy; 2020 - 2024 Khue Doan

Distributed under the GPLv3 License.
See [license page](https://homelab.khuedoan.com/reference/license) or `LICENSE.md` file for more information.

## Acknowledgements

References:

- [Ephemeral PXE server inspired by Minimal First Machine in the DC](https://speakerdeck.com/amcguign/minimal-first-machine-in-the-dc)
- [ArgoCD usage and monitoring configuration in locmai/humble](https://github.com/locmai/humble)
- [README template](https://github.com/othneildrew/Best-README-Template)
- [Run the same Cloudflare Tunnel across many `cloudflared` processes](https://developers.cloudflare.com/cloudflare-one/tutorials/many-cfd-one-tunnel)
- [MAC address environment variable in GRUB config](https://askubuntu.com/questions/1272400/how-do-i-automate-network-installation-of-many-ubuntu-18-04-systems-with-efi-and)
- [Official k3s systemd service file](https://github.com/k3s-io/k3s/blob/master/k3s.service)
- [Official Cloudflare Tunnel examples](https://github.com/cloudflare/argo-tunnel-examples)
- [Initialize GitOps repository on Gitea and integrate with Tekton by RedHat](https://github.com/redhat-scholars/tekton-tutorial/tree/master/triggers)
- [SSO configuration from xUnholy/k8s-gitops](https://github.com/xUnholy/k8s-gitops)
- [Pre-commit config from k8s-at-home/flux-cluster-template](https://github.com/k8s-at-home/flux-cluster-template)
- [Diátaxis technical documentation framework](https://diataxis.fr)
- [Official Terratest examples](https://github.com/gruntwork-io/terratest/tree/master/test)
- [Self-host an automated Jellyfin media streaming stack](https://zerodya.net/self-host-jellyfin-media-streaming-stack)
- [App Template Helm chart by bjw-s](https://bjw-s.github.io/helm-charts/docs/app-template)
- [Various application configurations in onedr0p/home-ops](https://github.com/onedr0p/home-ops)

Here is a list of the contributors who have helped to improve this project.
Big shout-out to them!

- ![](https://github.com/locmai.png?size=24) [@locmai](https://github.com/locmai)
- ![](https://github.com/MatthewJohn.png?size=24) [@MatthewJohn](https://github.com/MatthewJohn)
- ![](https://github.com/karpfediem.png?size=24) [@karpfediem](https://github.com/karpfediem)
- ![](https://github.com/linhng98.png?size=24) [@linhng98](https://github.com/linhng98)
- ![](https://github.com/elliotblackburn.png?size=24) [@elliotblackburn](https://github.com/elliotblackburn)
- ![](https://github.com/dotdiego.png?size=24) [@dotdiego](https://github.com/dotdiego)
- ![](https://github.com/Crimrose.png?size=24) [@Crimrose](https://github.com/Crimrose)
- ![](https://github.com/eventi.png?size=24) [@eventi](https://github.com/eventi)
- ![](https://github.com/Bourne-ID.png?size=24) [@Bourne-ID](https://github.com/Bourne-ID)
- ![](https://github.com/akwan.png?size=24) [@akwan](https://github.com/akwan)
- ![](https://github.com/trangmaiq.png?size=24) [@trangmaiq](https://github.com/trangmaiq)
- ![](https://github.com/tangowithfoxtrot.png?size=24) [@tangowithfoxtrot](https://github.com/tangowithfoxtrot)
- ![](https://github.com/raedkit.png?size=24) [@raedkit](https://github.com/raedkit)
- ![](https://github.com/ClashTheBunny.png?size=24) [@ClashTheBunny](https://github.com/ClashTheBunny)
- ![](https://github.com/retX0.png?size=24) [@retX0](https://github.com/retX0)

If you feel you're missing from this list, please feel free to add yourself in a PR.

## Stargazers over time

[![Stargazers over time](https://starchart.cc/khuedoan/homelab.svg)](https://starchart.cc/khuedoan/homelab)
