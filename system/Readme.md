
Componentes que orquestram, protegem, monitoram e garantem alta disponibilidade de todo o ecossistema.

| Componente            | Função                                                               |
| --------------------- | -------------------------------------------------------------------- |
| **ArgoCD**            | GitOps: sincroniza o estado do cluster com repositórios Git.         |
| **cert-manager**      | Emissão automática de certificados TLS. Integrado com Cloudflare.    |
| **cloudflared**       | Túnel seguro entre sua rede e o Cloudflare (acesso remoto seguro).   |
| **external-dns**      | Cria entradas DNS automaticamente no Cloudflare com base no ingress. |
| **ingress-nginx**     | Controlador de entrada HTTP para expor os serviços via DNS.          |
| **kured**             | Reinicia nodes automaticamente após atualizações de segurança.       |
| **loki**              | Logs centralizados de aplicações.                                    |
| **monitoring-system** | Stack Prometheus + Grafana: métricas, alertas e visualizações.       |
| **rock-ceph**         | Armazenamento distribuído persistente. Suporte a PVCs.               |
| **volsync-system**    | Sincronização de volumes entre clusters ou para backup.              |
