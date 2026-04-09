#!/bin/bash

echo "╔════════════════════════════════════════════╗"
echo "║     L-Shop Auto Setup & Start              ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Função para esperar serviço
wait_for_service() {
  local host=$1
  local port=$2
  local service=$3
  local count=0
  
  echo -e "${YELLOW}⏳ Aguardando $service ($host:$port)...${NC}"
  while ! nc -z "$host" "$port" 2>/dev/null; do
    count=$((count+1))
    if [ $count -gt 30 ]; then
      echo -e "${RED}✗ Timeout aguardando $service${NC}"
      return 1
    fi
    sleep 1
  done
  echo -e "${GREEN}✓ $service está pronto!${NC}"
  return 0
}

# Step 1: Aguardar MySQL
echo ""
echo -e "${BLUE}[1/8]${NC} Conectando ao Banco de Dados..."
wait_for_service "db" "3306" "MySQL" || exit 1

# Step 2: Aguardar Redis
echo ""
echo -e "${BLUE}[2/8]${NC} Conectando ao Redis..."
wait_for_service "redis" "6379" "Redis" || exit 1

# Step 3: Instalar Composer
echo ""
echo -e "${BLUE}[3/8]${NC} Instalando dependências PHP (Composer)..."
cd /app
composer install --no-interaction --prefer-dist --optimize-autoloader 2>&1 | grep -E "(Installing|Generating)" || echo "Composer pronto"
if [ $? -ne 0 ]; then
  echo -e "${RED}✗ Erro ao instalar Composer${NC}"
  exit 1
fi
echo -e "${GREEN}✓ Composer instalado!${NC}"

# Step 4: Instalar NPM
echo ""
echo -e "${BLUE}[4/8]${NC} Instalando dependências Node.js (NPM)..."
npm install --production 2>&1 | tail -5
if [ $? -ne 0 ]; then
  echo -e "${RED}✗ Erro ao instalar NPM${NC}"
  exit 1
fi
echo -e "${GREEN}✓ NPM instalado!${NC}"

# Step 5: Gerar APP_KEY
echo ""
echo -e "${BLUE}[5/8]${NC} Gerando chave da aplicação..."
php artisan key:generate --force --quiet
echo -e "${GREEN}✓ APP_KEY gerada!${NC}"

# Step 6: Migrations
echo ""
echo -e "${BLUE}[6/8]${NC} Executando migrations do banco de dados..."
php artisan migrate --force --quiet 2>&1
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Migrations executadas!${NC}"
else
  echo -e "${YELLOW}⚠ Migrations já foram executadas ou erro (continuando)${NC}"
fi

# Step 7: Seeders
echo ""
echo -e "${BLUE}[7/8]${NC} Populando banco de dados..."
php artisan db:seed --force --quiet 2>&1
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Dados iniciais inseridos!${NC}"
else
  echo -e "${YELLOW}⚠ Seeders já foram executados ou erro (continuando)${NC}"
fi

# Step 8: Cache
echo ""
echo -e "${BLUE}[8/8]${NC} Compilando cache..."
php artisan config:cache --quiet
php artisan route:cache --quiet
php artisan view:cache --quiet 2>/dev/null || true
echo -e "${GREEN}✓ Cache compilado!${NC}"

# Iniciar servidor
echo ""
echo "╔════════════════════════════════════════════╗"
echo -e "║ ${GREEN}✓ Setup completo! Iniciando servidor...${NC}    ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo -e "${YELLOW}🎯 Acesse: http://elgae-sp1-b001.elgaehost.com.br:11189${NC}"
echo -e "${YELLOW}🔌 Porta Local: 8000${NC}"
echo ""

# Iniciar Laravel Server
exec php artisan serve --host=0.0.0.0 --port=8000
