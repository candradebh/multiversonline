#!/bin/bash

# Lista dos hosts
HOSTS=("192.168.1.44" "192.168.1.20")

# Caminho da chave pública do usuário carlos
PUBKEY_PATH="/home/carlos/.ssh/id_ed25519.pub"

# Confirma se a chave existe
if [ ! -f "$PUBKEY_PATH" ]; then
  echo "Chave pública não encontrada em $PUBKEY_PATH"
  exit 1
fi

# Copia chave para cada host e configura SSH
for HOST in "${HOSTS[@]}"; do
  echo "🔧 Configurando $HOST..."

  # Copia a chave para o host como root
  scp -o StrictHostKeyChecking=no "$PUBKEY_PATH" root@"$HOST":/tmp/pubkey_temp

  # Conecta como root e configura tudo
  ssh -o StrictHostKeyChecking=no root@"$HOST" "bash -s" <<'EOF'
    # Garante que diretório SSH do root existe
    mkdir -p /root/.ssh
    touch /root/.ssh/authorized_keys

    # Adiciona chave pública ao root
    cat /tmp/pubkey_temp >> /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    chmod 700 /root/.ssh
    rm /tmp/pubkey_temp

    # Habilita login root e autenticação por senha no SSH
    sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

    # Reinicia o serviço SSH
    systemctl restart sshd
EOF

  echo "✅ $HOST configurado."
done
