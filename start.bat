@echo off
REM L-Shop Auto Setup & Start (Windows)
REM Este script instala e executa tudo automaticamente

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════╗
echo ║     L-Shop Auto Setup ^& Start              ║
echo ║     IP: 31.57.60.2:11189                   ║
echo ╚════════════════════════════════════════════╝
echo.

REM Cores (usando ANSI)
for /F %%A in ('echo prompt $H ^| cmd') do set "BS=%%A"

REM Verificar se Docker está rodando
echo [1/6] Verificando Docker...
docker --version >nul 2>&1
if errorlevel 1 (
    echo ✗ Docker não está instalado ou não está rodando!
    echo   Instale Docker Desktop em: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)
echo ✓ Docker está pronto!
echo.

REM Verificar docker-compose
echo [2/6] Verificando Docker Compose...
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo ✗ Docker Compose não está instalado!
    pause
    exit /b 1
)
echo ✓ Docker Compose está pronto!
echo.

REM Criar .env se não existir
echo [3/6] Configurando ambiente...
if not exist .env (
    echo   Criando .env a partir de .env.example...
    copy .env.example .env >nul
    echo   ✓ Arquivo .env criado!
) else (
    echo   ✓ Arquivo .env já existe!
)
echo.

REM Build das imagens
echo [4/6] Compilando imagens Docker...
docker-compose build --no-cache
if errorlevel 1 (
    echo ✗ Erro ao compilar imagens!
    pause
    exit /b 1
)
echo ✓ Imagens compiladas!
echo.

REM Iniciar containers
echo [5/6] Iniciando containers...
docker-compose up -d
if errorlevel 1 (
    echo ✗ Erro ao iniciar containers!
    pause
    exit /b 1
)
echo ✓ Containers iniciados!
echo.

REM Aguardar inicialização
echo [6/6] Aguardando inicialização completa...
echo   Isto pode levar 30-60 segundos na primeira execução...
timeout /t 10 /nobreak
echo.

REM Exibir status
echo ╔════════════════════════════════════════════╗
echo ║ ✓ L-Shop está pronto!                      ║
echo ╚════════════════════════════════════════════╝
echo.
echo 🎯 Acesse:
echo    http://elgae-sp1-b001.elgaehost.com.br:11189
echo.
echo 📊 Painel MySQL (PhpMyAdmin):
echo    Host: 127.0.0.1:3306
echo    User: lshop
echo    Pass: lshop_password
echo.
echo 💾 Redis (Porta):
echo    localhost:6379
echo.
echo 📋 Comandos úteis:
echo    docker-compose ps          - Ver status dos containers
echo    docker-compose logs app    - Ver logs da aplicação
echo    docker-compose down        - Parar tudo
echo    docker-compose up -d       - Reiniciar
echo.
echo ℹ  Para reabrir este terminal, execute:
echo    docker-compose up -d
echo.

REM Abrir navegador
echo Abrindo navegador em 5 segundos...
timeout /t 5 /nobreak
start http://elgae-sp1-b001.elgaehost.com.br:11189

REM Manter terminal aberto
pause
