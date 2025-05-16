Esses serviços dão suporte ao ciclo de vida do desenvolvimento e operações: CI/CD, autenticação, versionamento, automação e integração de segredos.


| Ferramenta           | Função                                                              |
| -------------------- | ------------------------------------------------------------------- |
| **DEX**              | Autenticação OIDC/SAML (SSO). Pode ser integrado ao ArgoCD, Matrix. |
| **Renovate**         | Automatiza atualizações de dependências em repositórios Git.        |
| **Woodpecker**       | CI/CD (execução de pipelines de build/test/deploy).                 |
| **Zot**              | Registro de container OCI. Armazena imagens Docker/Helm.            |
| **Gitea**            | Repositório Git auto-hospedado (GitHub alternativo).                |
| **External-Secrets** | Sincroniza segredos com o Kubernetes a partir de fontes externas.   |
