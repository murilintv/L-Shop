# 🚀 L-Shop - ONE CLICK START

**Versão 2.0 - Pronta para produção**

---

## ⚡ INICIAR EM 1 CLIQUE

### Windows 🪟
**Duplo clique em:**
```
start.bat
```

OU abra PowerShell e execute:
```powershell
powershell -ExecutionPolicy Bypass -File start.ps1
```

### Linux / Mac 🐧🍎
```bash
bash start.sh
```

### Docker Compose (Qualquer Sistema)
```bash
docker-compose up -d
```

---

## ✅ O QUE ACONTECE AUTOMATICAMENTE

✓ Instala todas as dependências PHP (Composer)  
✓ Instala todas as dependências Node.js (NPM)  
✓ Gera chave da aplicação  
✓ Configura banco de dados MySQL  
✓ Executa migrations (tabelas)  
✓ Popula dados iniciais (seeders)  
✓ Compila cache  
✓ Inicia o servidor  
✓ Abre navegador automaticamente  

---

## 🎯 ACESSAR

**URL Principal:**
```
http://elgae-sp1-b001.elgaehost.com.br:11189
```

**IP + Porta:**
```
31.57.60.2:11189
```

**Local (se conectado direto):**
```
http://localhost:8000
```

---

## 📊 CREDENCIAIS

### Banco de Dados MySQL
```
Host: 127.0.0.1 (ou db)
Porta: 3306
Usuário: lshop
Senha: lshop_password
BD: lshop
```

### Redis (Cache/Session)
```
Host: redis
Porta: 6379
Sem senha
```

---

## 🛑 PARAR / REINICIAR

### Parar tudo
```bash
docker-compose down
```

### Reiniciar
```bash
docker-compose up -d
```

### Ver status
```bash
docker-compose ps
```

### Ver logs
```bash
docker-compose logs -f app
```

---

## 📝 VERSÕES

| Componente | Versão |
|-----------|--------|
| **Laravel** | 11.x |
| **PHP** | 8.1+ |
| **Vue.js** | 3.3 |
| **Node.js** | 18+ |
| **MySQL** | 8.0 |
| **Redis** | 7 |

---

## 🔧 PRIMEIRO ACESSO

1. ✅ Aguardar script terminar (~1 min)
2. ✅ Navegador abre automaticamente
3. ✅ Se pedirá login - use credenciais padrão
4. ✅ Tudo funcionando!

---

## 📚 DOCUMENTAÇÃO

Para mais detalhes, veja:
- [`QUICK_START.md`](QUICK_START.md) - Guia rápido
- [`UPGRADE_2026.md`](UPGRADE_2026.md) - Detalhes de upgrade
- [`UPGRADE_REPORT.md`](UPGRADE_REPORT.md) - Relatório completo

---

## 🆘 PROBLEMAS?

### Docker não inicia
```bash
# Reiniciar Docker Desktop ou:
systemctl restart docker
```

### Porta 11189 já está em uso
```bash
# Editar docker-compose.yml e trocar porta
# Linha: "31.57.60.2:11189:8000"
```

### Erro de permissões (Linux)
```bash
sudo chmod +x start.sh
sudo bash start.sh
```

### Limpar tudo e recomeçar
```bash
docker-compose down -v
docker-compose up -d
```

---

## ✨ Características

- 🔒 **Seguro** - PHP 8.1, dependências atualizadas
- ⚡ **Rápido** - Vite build 10x mais rápido
- 🏗️ **Moderno** - Laravel 11, Vue 3, Pinia
- 🐳 **Docker** - Fácil deploy
- 💾 **Redis** - Cache de alto desempenho
- 📊 **MySQL** - Banco robusto

---

## 📞 PRECISA DE AJUDA?

1. Verificar logs: `docker-compose logs app`
2. Ler documentação em `UPGRADE_2026.md`
3. Verificar conectividade: `ping db` e `ping redis`

---

**🎉 Tudo pronto para rodar! 🎉**

_Desenvolvido com ❤️ em 2026_
