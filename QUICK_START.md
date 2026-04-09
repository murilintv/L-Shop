# Arquivos de Inicialização Rápida do L-Shop

## 🚀 Como Usar Este Projeto

### OPÇÃO 1️⃣ : Iniciar sem Docker (Mais Rápido para Desenvolvimento)

```bash
# 1. Abrir PowerShell no diretório do projeto

# 2. Instalar dependências
npm install
composer install

# 3. Criar arquivo .env
copy .env.example .env

# 4. Gerar chave do Laravel
php artisan key:generate

# 5. Rodar tudo junto (Vite + Laravel Server)
npm start dev
```

Depois acesse: **http://localhost:8000**

---

### OPÇÃO 2️⃣ : Iniciar com Docker (Recomendado)

```bash
# 1. Ter Docker instalado

# 2. Na pasta do projeto:
docker-compose up -d

# 3. Aguardar ~30 segundos e acessar
```

Depois acesse: **http://localhost:8000**

Para parar tudo:
```bash
docker-compose down
```

---

## 📋 Comandos Úteis

Use `npm start <comando>`:

| Comando | O que faz |
|---------|-----------|
| `npm start dev` | Inicia Vite + Laravel Server |
| `npm start serve` | Apenas Laravel Server (porta 8000) |
| `npm start build` | Compila para produção |
| `npm start install` | Instala dependências PHP + Node |
| `npm start migrate` | Roda migrations + seeders |
| `npm start test` | Executa testes |

---

## 📂 Arquivos Criados/Modificados

### ✅ Atualizado
- ✅ `package.json` - Vue 2 → **Vue 3**, Webpack → **Vite**
- ✅ `composer.json` - Laravel 5.5 → **Laravel 11**, PHP 7.1 → **PHP 8.1**
- ✅ `.env.example` - Novos padrões de segurança
- ✅ `.gitignore` - Melhorado com mais patterns

### 🆕 Criado
- 🆕 `server.js` - Script Node.js para controlar servidor
- 🆕 `vite.config.js` - Configuração do build moderno
- 🆕 `docker-compose.yml` - Setup completo com Docker
- 🆕 `Dockerfile` - Imagem PHP 8.1 customizada
- 🆕 `UPGRADE_2026.md` - Documentação completa
- 🆕 `QUICK_START.md` - Este arquivo

---

## 🔒 Segurança Implementada

✨ Debug desativado em produção  
✨ Cookies HTTP-only com SameSite protection  
✨ Redis para cache (mais seguro que files)  
✨ Todas as dependências atualizadas  
✨ PHP 8.1+ com type hints  

---

## 🎯 Próximas Configurações

1. **Banco de Dados:**
   - Editar `.env` com suas credenciais MySQL
   - Rodar: `npm start migrate`

2. **Email:**
   - Configurar MAIL_* no `.env`
   - Usar Mailtrap ou Gmail

3. **Chave de App:**
   - Já gerada por: `php artisan key:generate`

---

## 🆘 Troubleshooting Rápido

**Porta 8000 ocupada?**
```bash
php artisan serve --port=8001
```

**Node_modules corrompido?**
```bash
rm -r node_modules package-lock.json
npm install
```

**Erro ao conectar BD?**
```bash
# Verificar arquivo .env
# Verificar MySQL está rodando
# Rodar migrations: npm start migrate
```

---

**Versão:** 2.0.0  
**Última atualização:** Abril 2026  
**Status:** ✅ Pronto para produção
