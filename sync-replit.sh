#!/bin/bash

# Script de Sincronização Automática com Replit
# Autor: Elisson Uzual
# Data: $(date)

PROJECT_DIR="/Users/elissonuzual/Documents/mentor-labs-v2/mentor-labs-v2"
REPO_URL="https://github.com/Elisson78/mentor-labs-v2.git"

echo "🔄 Iniciando sincronização com Replit..."

# Navegar para o diretório do projeto
cd "$PROJECT_DIR" || {
    echo "❌ Erro: Não foi possível acessar o diretório do projeto"
    exit 1
}

# Verificar se há alterações
if [[ -n $(git status --porcelain) ]]; then
    echo "📝 Alterações detectadas, fazendo commit..."
    
    # Adicionar todas as alterações
    git add .
    
    # Fazer commit com timestamp
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "Auto-sync: $TIMESTAMP"
    
    # Fazer push
    echo "⬆️  Fazendo push para GitHub..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo "✅ Sincronização concluída com sucesso!"
        echo "🌐 As alterações estão disponíveis no Replit"
        echo "📋 No Replit, execute: git pull origin main"
    else
        echo "❌ Erro ao fazer push. Verifique sua conexão e credenciais."
        exit 1
    fi
else
    echo "ℹ️  Nenhuma alteração detectada"
fi

echo "🏁 Script finalizado"
