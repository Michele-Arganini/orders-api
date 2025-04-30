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

3. **Configura frontend/.env**
    ```bash
   cp ../frontend/.env.example ../frontend/.env
   ```

4. **Avvia i container**
   ```bash
   lando start
   ```

5. **Installa dipendenze backend**
   ```bash
   cd backend
   lando composer install
   ```

6. **Installa dipendenze frontend**
   ```bash
   cd ../frontend
   lando npm install
   ```

7. **build per creare frontend/dist**
   ```bash
   lando npm run build
   ```

8. **Avvia in modalità sviluppo**
   ```bash
   lando npm run dev
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

## Utilizzo API in produzione

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