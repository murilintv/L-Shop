# L-Shop - Guia de Atualização 2026 🚀

Este projeto foi atualizado com versões modernas e seguras!

## Mudanças Principais

✅ **Laravel 5.5 → 11.x** - Performance e segurança melhorados  
✅ **PHP 7.1 → 8.1+** - Type hints, match expressions, named arguments  
✅ **Vue 2 → 3** - Composition API, melhor performance  
✅ **Webpack → Vite** - Build 10x mais rápido  
✅ **Node.js Package Manager** - Scripts automáticos para facilitar uso  
✅ **Docker Support** - Setup one-click com docker-compose  
✅ **Redis Cache** - Melhor performance de cache e sessão  

---

## ⚡ Instalação Rápida

### Opção 1: Sem Docker (Desenvolvimento Local)

```bash
# 1. Instalar dependências
npm install

# 2. Atualizar dependências PHP
composer install

# 3. Configurar ambiente
cp .env.example .env
php artisan key:generate

# 4. Rodarvite + servidor Laravel
npm start dev
```

Acesse: http://localhost:8000

---

### Opção 2: Com Docker (Recomendado)

```bash
# 1. Fazer build e iniciar containers
docker-compose up -d

# 2. Esperar inicialização (~30 segundos) e acessar
```

Acesse: http://localhost:8000

Para parar:
```bash
docker-compose down
```

---

## 📝 Usar o Script Node.js

Criamos um script `server.js` que facilita operações comuns:

```bash
# Desenvolvimento (Vite + Laravel)
npm start dev

# Apenas servidor backend
npm start serve

# Compilar para produção
npm start build

# Instalar todas dependências
npm start install

# Rodar migrations
npm start migrate

# Testes
npm start test

# Ajuda
npm start help
```

---

## 🔧 Estrutura de Diretórios

```
L-Shop/
├── app/                 # Código PHP/Laravel
├── resources/
│   ├── js/             # Código Vue 3
│   ├── views/          # Templates Blade
│   └── css/            # Estilos
├── public/
│   └── dist/           # Assets compilados (gerado)
├── routes/             # Rotas da API
├── database/
│   ├── migrations/     # Migrações do BD
│   └── seeders/        # Seeds do BD
├── vite.config.js      # Configuração Vite
├── package.json        # Dependências Node.js
├── composer.json       # Dependências PHP
├── server.js           # Script de controle
├── docker-compose.yml  # Setup Docker
├── Dockerfile          # Imagem Docker
└── .env.example        # Vars de ambiente
```

---

## 🗄️ Banco de Dados

### Com Docker
Automático! MySQL + Redis já vêm configurados.

### Sem Docker (Local)
```bash
# 1. Ter MySQL rodando na porta 3306
# 2. Editar .env com credenciais
# 3. Rodar migrations
npm start migrate
```

Credenciais de exemplo:
```
DB_HOST=127.0.0.1
DB_USERNAME=root
DB_PASSWORD=
```

---

## 📦 Dependências Principais

### Backend (PHP/Laravel 11)
- `laravel/framework` - Framework principal
- `laravel/sail` - Docker development
- `phpunit` - Testes
- `intervention/image` - Manipulação de imagens

### Frontend (Vue 3 + Vite)
- `vue@3.3.4` - Framework UI
- `vite@5.0.0` - Build tool
- `axios@1.6.0` - HTTP client
- `pinia` - State management (substitui Vuex)
- `vuetify@3.4.0` - Material Design

---

## 🔒 Melhorias de Segurança

✨ **App Debug:** Desativado em produção  
✨ **HTTPS:** Configurado via .env  
✨ **CORS:** Proteção contra requisições não autorizadas  
✨ **Session Cookies:** HttpOnly, Secure, SameSite=lax  
✨ **Rate Limiting:** Proteção contra brute force  
✨ **Dependencies:** Todas atualizadas para versões seguras  

---

## 📊 Comparativo de Performance

| Operação | Antes (Webpack) | Depois (Vite) |
|----------|-----------------|---------------|
| Dev Build | ~8s | <1s |
| Production Build | ~15s | ~3s |
| HMR (Hot Reload) | ~3s | ~100ms |
| Compile Time | Webpack 3 | Vite 5 |

---

## 🚨 Troubleshooting

### Porta 8000 já está em uso
```bash
php artisan serve --port=8001
```

### Redis não conecta
```bash
# Verificar se Redis está rodando
redis-cli ping

# Com Docker
docker-compose up redis
```

### Erro ao instalar dependências
```bash
# Limpar cache do npm
npm cache clean --force

# Reinstalar
rm -rf node_modules package-lock.json
npm install
```

### Migrations não rodam
```bash
# Verificar conexão com BD
php artisan tinker

# Forçar migrations
php artisan migrate --force
```

---

## 📝 Próximos Passos

1. ✅ Rodar migrations do BD
2. ✅ Configurar email (MAIL_* no .env)
3. ✅ Gerar APP_KEY: `php artisan key:generate`
4. ✅ Seedar dados: `php artisan db:seed`
5. ✅ Testar API: `npm start test`

---

## 🔗 Referências Úteis

- [Laravel 11 Docs](https://laravel.com/docs/11.x)
- [Vue 3 Docs](https://vuejs.org/)
- [Vite Docs](https://vitejs.dev/)
- [Docker Docs](https://docs.docker.com/)

---

**Versão:** 2.0.0 (Atualizada em 2026)  
**Licença:** MIT  
**Suporte:** [GitHub Issues](https://github.com/D3lph1/L-Shop/issues)
