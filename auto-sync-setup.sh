#!/bin/bash

# Setup de Sincronização Automática
echo "🛠️  Configurando sincronização automática..."

# Adicionar alias ao .zshrc
ALIAS_LINE='alias sync-replit="cd /Users/elissonuzual/Documents/mentor-labs-v2/mentor-labs-v2 && ./sync-replit.sh"'

if ! grep -q "sync-replit" ~/.zshrc 2>/dev/null; then
    echo "" >> ~/.zshrc
    echo "# Mentor Labs - Sincronização Replit" >> ~/.zshrc
    echo "$ALIAS_LINE" >> ~/.zshrc
    echo "✅ Alias adicionado ao .zshrc"
else
    echo "ℹ️  Alias já existe no .zshrc"
fi

echo ""
echo "🎉 Configuração concluída!"
echo ""
echo "📋 Como usar:"
echo "   1. Execute 'source ~/.zshrc' ou abra um novo terminal"
echo "   2. Use o comando 'sync-replit' de qualquer lugar"
echo "   3. Ou execute diretamente: './sync-replit.sh'"
echo ""
echo "🔄 Fluxo de trabalho:"
echo "   1. Faça suas alterações localmente"
echo "   2. Execute 'sync-replit'"
echo "   3. No Replit, execute 'git pull origin main'"
