#!/usr/bin/env node

const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

const args = process.argv.slice(2);
const command = args[0] || 'dev';

// Cores para terminal
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  blue: '\x1b[34m',
  yellow: '\x1b[33m',
  red: '\x1b[31m'
};

function log(color, message) {
  console.log(`${color}${message}${colors.reset}`);
}

function checkEnvFile() {
  const envPath = path.join(__dirname, '.env');
  if (!fs.existsSync(envPath)) {
    const examplePath = path.join(__dirname, '.env.example');
    if (fs.existsSync(examplePath)) {
      fs.copyFileSync(examplePath, envPath);
      log(colors.green, '✓ Arquivo .env criado a partir de .env.example');
    } else {
      log(colors.red, '✗ Erro: .env.example não encontrado');
      process.exit(1);
    }
  }
}

function runCommand(cmd, args, name) {
  log(colors.blue, `\n▶ Iniciando: ${name}`);
  const proc = spawn(cmd, args, {
    stdio: 'inherit',
    shell: true,
    cwd: __dirname
  });

  proc.on('error', (err) => {
    log(colors.red, `✗ Erro ao executar ${name}: ${err.message}`);
    process.exit(1);
  });

  return proc;
}

async function main() {
  checkEnvFile();

  switch (command) {
    case 'dev':
      log(colors.yellow, '🚀 Iniciando ambiente de desenvolvimento...\n');
      runCommand('npm', ['run', 'dev'], 'Vite (Frontend)');
      setTimeout(() => {
        runCommand('php', ['artisan', 'serve', '--port=8000'], 'Laravel (Backend)');
      }, 2000);
      break;

    case 'build':
      log(colors.yellow, '🔨 Compilando produção...\n');
      runCommand('npm', ['run', 'build'], 'Build Frontend').on('close', (code) => {
        if (code === 0) {
          runCommand('composer', ['build'], 'Cache Laravel');
        }
      });
      break;

    case 'serve':
      log(colors.yellow, '🎯 Iniciando servidor Laravel...\n');
      runCommand('php', ['artisan', 'serve', '--port=8000'], 'Laravel');
      break;

    case 'migrate':
      log(colors.yellow, '📦 Executando migrations...\n');
      runCommand('php', ['artisan', 'migrate', '--seed'], 'Database');
      break;

    case 'install':
      log(colors.yellow, '📥 Instalando dependências...\n');
      runCommand('composer', ['install'], 'Composer').on('close', () => {
        runCommand('npm', ['install'], 'NPM');
      });
      break;

    case 'test':
      log(colors.yellow, '🧪 Executando testes...\n');
      runCommand('php', ['artisan', 'test'], 'PHPUnit');
      break;

    default:
      log(colors.blue, `
╔════════════════════════════════════════════╗
║     L-Shop - Server Control Script         ║
╚════════════════════════════════════════════╝

Comandos disponíveis:

  npm start [comando]              Executar um comando

DESENVOLVIMENTO:
  npm start dev                    Iniciar dev (Vite + Laravel)
  npm start serve                  Apenas servidor Laravel
  npm start build                  Build para produção
  npm start install                Instalar todas as dependências

DATABASE:
  npm start migrate                Executar migrations e seeders

TESTES:
  npm start test                   Rodar testes PHPUnit

EXEMPLOS:
  npm start dev                    # Começa com tudo pronto
  npm start build && npm start serve # Build e depois servir
      `);
  }
}

main().catch(err => {
  log(colors.red, `Erro: ${err.message}`);
  process.exit(1);
});
