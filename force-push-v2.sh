#!/bin/bash

echo "🔧 Forçando envio para mentor-labs-v2 (limpeza completa)..."

# Parar todos os processos Git
pkill -f git 2>/dev/null || true
sleep 2

# Remover todos os locks forçadamente
find .git -name "*.lock" -delete 2>/dev/null || true
rm -f .git/config.lock 2>/dev/null || true
rm -f .git/index.lock 2>/dev/null || true
rm -rf .git/refs/remotes/origin 2>/dev/null || true

# Recriar configuração do remote
git config --unset-all remote.origin.url 2>/dev/null || true
git config --unset-all remote.origin.fetch 2>/dev/null || true
git config --unset-all branch.main.remote 2>/dev/null || true
git config --unset-all branch.main.merge 2>/dev/null || true

# Adicionar remote limpo
git remote add origin https://github.com/Elisson78/mentor-labs-v2.git 2>/dev/null || true

# Verificar qual remote está configurado
echo "🔍 Remote atual:"
git remote -v

# Mudar URL do remote se necessário
git remote set-url origin https://github.com/Elisson78/mentor-labs-v2.git

echo "📦 Enviando projeto..."

# Push forçado para o repositório correto
git push origin main --force --set-upstream

echo "✅ Projeto enviado para mentor-labs-v2!"
echo "🔗 Verifique em: https://github.com/Elisson78/mentor-labs-v2"