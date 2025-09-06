#!/bin/bash

echo "🧹 Fazendo push limpo para mentor-labs-v2..."

# Criar um novo branch temporário sem histórico problemático
git checkout --orphan temp-main

# Adicionar todos os arquivos atuais
git add .

# Fazer um commit limpo
git commit -m "Mentor Labs v2 - Plataforma educacional completa com IA e gamificação

✨ Funcionalidades principais:
- Sistema de autenticação customizado
- Dashboard para mentores com criação de mentorias
- Dashboard gamificado para estudantes (XP, níveis, badges)
- Geração automática de quizzes usando IA
- Integração com APIs do OpenAI/Google AI
- Sistema de trilhas de aprendizado
- Backend Next.js + PostgreSQL + Drizzle ORM
- Deploy configurado para Replit

🛠 Stack:
- Next.js 15 + React 19 + TypeScript
- TailwindCSS + shadcn/ui + Framer Motion
- PostgreSQL + Drizzle ORM
- Sistema híbrido de autenticação"

# Deletar branch main antiga
git branch -D main 2>/dev/null || true

# Renomear branch temp para main
git branch -m main

# Configurar remote para mentor-labs-v2
git remote set-url origin https://github.com/Elisson78/mentor-labs-v2.git

# Push forçado com histórico limpo
git push origin main --force

echo "✅ Projeto enviado com sucesso para mentor-labs-v2!"
echo "🔗 Acesse: https://github.com/Elisson78/mentor-labs-v2"
echo "📊 Enviado: Projeto completo sem histórico problemático"