# Orders API – Frontend Vue + Backend PHP (MysqliDb)

Un'app Vue 3 + Vite con backend PHP che consente la ricerca di ordini tramite email.

## Demo Live

- **Frontend:** [https://orders-eck1n27mi-micheles-projects-727ff2b5.vercel.app/](https://orders-eck1n27mi-micheles-projects-727ff2b5.vercel.app/)
- **Backend API:** [https://orders-api-wnz2.onrender.com/](https://orders-api-wnz2.onrender.com/)

## Utenti di Test

- mario.rossi@example.com
- laura.bianchi@example.com
- alessandro.verdi@example.com

## Requisiti

- Lando >= 3.x con recipe lamp
- Docker attivo
- PHP 8.1
- MySQL 5.7
- Node.js
- Composer
- Git

## Credenziali Database

```
DB_HOST: database
DB_PORT: 3306
DB_DATABASE: progetto
DB_USERNAME: admin
DB_PASSWORD: sviluppo
```

## Setup del Progetto

1. **Clona il repository**
   ```bash
   git clone https://github.com/Michele-Arganini/orders-api.git
   cd orders-api
   ```

2. **Configura backend/.env**
   ```bash
   cp backend/.env.example backend/.env
   ```
   
   Aggiungi questi valori nel file .env:
   ```
   DB_HOST=database
   DB_PORT=3306
   DB_DATABASE=progetto
   DB_USERNAME=admin
   DB_PASSWORD=sviluppo
   ```

3. **Configura frontend/.env**
   
   Crea il file `frontend/.env` con il seguente contenuto:
   ```
   VITE_API_URL=https://orders-api.lndo.site
   ```

4. **Configurazione Lando**

   Assicurati che il file `.lando.yml` contenga la seguente configurazione:

   ```yaml
   name: orders-api
   recipe: lamp
   config:
     php: '8.1'
     webroot: backend
     database: mysql:5.7
     xdebug: false

   services:
     appserver:
       build_as_root:
         - apt-get update && apt-get install -y git curl
         - curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
         - apt-get install -y nodejs
       composer:
         phpunit/phpunit: '*'
       build:
         - npm install

     database:
       portforward: 3306
       creds:
         user: admin
         password: sviluppo
         database: progetto
         
     pma:
       type: phpmyadmin
       hosts:
         - database

   tooling:
     composer:
       service: appserver
       cmd: composer
     
     php:
       service: appserver
       cmd: php

     mysql:
       service: database
       cmd: mysql
     
     phpmyadmin:
       service: pma
       cmd: lando-pma
       
     npm:
       service: appserver
       cmd: npm
       
     'npm:i':
       service: appserver
       cmd: npm i
       
     'npm:build':
       service: appserver
       cmd: npm run build
       
     'npm:dev':
       service: appserver
       cmd: npm run dev
       
     node:
       service: appserver
       cmd: node

   proxy:
     appserver:
       - orders-api.lndo.site
     pma:
       - pma-orders-api.lndo.site
   ```

5. **Avvia i container**
   ```bash
   lando start
   ```

6. **Installa dipendenze backend**
   ```bash
   cd backend
   lando composer install
   ```

7. **Installa dipendenze frontend**
   ```bash
   cd ../frontend
   lando npm install
   ```

8. **Avvia in modalità sviluppo**
   ```bash
   lando npm run dev
   ```

9. **Oppure build per produzione**
   ```bash
   lando npm run build
   ```

## Database

### Generazione SQL
```bash
php db/genera_sql.php > db/output.sql
```

### Importazione SQL
```bash
lando db-import db/output.sql
```

## Utilizzo API

### Esempio Richiesta
```bash
curl "https://orders-api-wnz2.onrender.com/api/orders?email=laura.bianchi@example.com"
```

### Esempio Risposta
```json
{
  "success": true,
  "orders": [
    {
      "id": 11,
      "order_date": "2025-04-04 22:31:37",
      "products": [
        {"name": "Video Corso Premium", "quantity": 4},
        {"name": "Poster da Collezione", "quantity": 3}
      ]
    }
  ]
}
```

## Comandi Lando Utili

- `lando node -v` - Verifica la versione di Node.js
- `lando npm -v` - Verifica la versione di npm
- `lando npm i` - Installa le dipendenze
- `lando npm run build` - Compila il progetto
- `lando npm run dev` - Avvia l'ambiente di sviluppo

## Autore

**Michele Arganini**  
[LinkedIn](https://linkedin.com/in/arganinim)