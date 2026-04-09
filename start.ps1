# L-Shop Auto Setup & Start (PowerShell)
# Execute: powershell -ExecutionPolicy Bypass -File start.ps1

$ErrorActionPreference = "Stop"

# Cores
$Green = @{ ForegroundColor = 'Green' }
$Red = @{ ForegroundColor = 'Red' }
$Yellow = @{ ForegroundColor = 'Yellow' }
$Blue = @{ ForegroundColor = 'Cyan' }

Write-Host ""
Write-Host "╔════════════════════════════════════════════╗" @Blue
Write-Host "║     L-Shop Auto Setup & Start              ║" @Blue
Write-Host "║     IP: 31.57.60.2:11189                   ║" @Blue
Write-Host "╚════════════════════════════════════════════╝" @Blue
Write-Host ""

# Step 1: Verificar Docker
Write-Host "[1/6] Verificando Docker..." @Blue
try {
    $dockerVersion = docker --version 2>$null
    Write-Host "✓ Docker pronto: $dockerVersion" @Green
} catch {
    Write-Host "✗ Docker não está instalado ou não está rodando!" @Red
    Write-Host "  Instale em: https://www.docker.com/products/docker-desktop" @Yellow
    Read-Host "Pressione Enter para sair"
    exit 1
}
Write-Host ""

# Step 2: Verificar Docker Compose
Write-Host "[2/6] Verificando Docker Compose..." @Blue
try {
    $composeVersion = docker-compose --version 2>$null
    Write-Host "✓ Docker Compose pronto: $composeVersion" @Green
} catch {
    Write-Host "✗ Docker Compose não está instalado!" @Red
    Read-Host "Pressione Enter para sair"
    exit 1
}
Write-Host ""

# Step 3: Criar .env
Write-Host "[3/6] Configurando ambiente..." @Blue
if (!(Test-Path ".env")) {
    Write-Host "  Criando .env a partir de .env.example..." @Yellow
    Copy-Item ".env.example" ".env" -Force
    Write-Host "  ✓ Arquivo .env criado!" @Green
} else {
    Write-Host "  ✓ Arquivo .env já existe!" @Green
}
Write-Host ""

# Step 4: Build imagens
Write-Host "[4/6] Compilando imagens Docker..." @Blue
docker-compose build --no-cache
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Erro ao compilar imagens!" @Red
    Read-Host "Pressione Enter para sair"
    exit 1
}
Write-Host "✓ Imagens compiladas!" @Green
Write-Host ""

# Step 5: Iniciar containers
Write-Host "[5/6] Iniciando containers..." @Blue
docker-compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Erro ao iniciar containers!" @Red
    Read-Host "Pressione Enter para sair"
    exit 1
}
Write-Host "✓ Containers iniciados!" @Green
Write-Host ""

# Step 6: Aguardar inicialização
Write-Host "[6/6] Aguardando inicialização completa..." @Blue
Write-Host "  Isto pode levar 30-60 segundos na primeira execução..." @Yellow
for ($i = 1; $i -le 5; $i++) {
    Write-Host -NoNewline "."
    Start-Sleep -Seconds 2
}
Write-Host ""
Write-Host ""

# Status final
Write-Host "╔════════════════════════════════════════════╗" @Blue
Write-Host "║ ✓ L-Shop está pronto!                      ║" @Blue
Write-Host "╚════════════════════════════════════════════╝" @Blue
Write-Host ""

Write-Host "🎯 Acesse:" @Green
Write-Host "   http://elgae-sp1-b001.elgaehost.com.br:11189" @Yellow
Write-Host ""

Write-Host "📊 Banco de Dados MySQL:" @Green
Write-Host "   Host: 127.0.0.1:3306" @Yellow
Write-Host "   Usuário: lshop" @Yellow
Write-Host "   Senha: lshop_password" @Yellow
Write-Host ""

Write-Host "💾 Redis (Cache/Session):" @Green
Write-Host "   localhost:6379" @Yellow
Write-Host ""

Write-Host "📋 Comandos úteis:" @Green
Write-Host "   docker-compose ps           - Ver status dos containers"
Write-Host "   docker-compose logs app     - Ver logs da aplicação"
Write-Host "   docker-compose down         - Parar tudo"
Write-Host "   docker-compose up -d        - Reiniciar"
Write-Host ""

# Tentar abrir navegador
Write-Host "Abrindo navegador..." @Yellow
try {
    Start-Process "http://elgae-sp1-b001.elgaehost.com.br:11189"
} catch {
    Write-Host "Não foi possível abrir o navegador automaticamente." @Yellow
    Write-Host "Acesse manualmente: http://elgae-sp1-b001.elgaehost.com.br:11189" @Yellow
}

Write-Host ""
Read-Host "Pressione Enter para sair"
