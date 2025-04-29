# Progetto Test – Frontend Vue + Backend PHP (MysqliDb)

**Live Demo:**

- **Frontend:** [https://orders-eck1n27mi-micheles-projects-727ff2b5.vercel.app/](https://orders-eck1n27mi-micheles-projects-727ff2b5.vercel.app/)
- **API Backend:** [https://orders-api-wnz2.onrender.com/](https://orders-api-wnz2.onrender.com/)

Una API PHP che espone l’endpoint `/api/orders?email=` e un frontend **Vue 3 + Vite** per cercare e visualizzare gli ordini degli ultimi 30 giorni.

Il progetto può essere eseguito **in locale** con Lando o con PHP-CLI + MySQL, e **in produzione** tramite Render e Vercel.

---
## Utenti di Test

Gli utenti disponibili per i test sono:

- mario.rossi@example.com
- laura.bianchi@example.com
- alessandro.verdi@example.com

---

## Prerequisiti locali

Per eseguire il progetto in locale con **Lando**, assicurati di avere:

- **Lando** (>= v3.x) con recipe `lamp` installato
  - Include: PHP 8.1, MySQL 5.7, Node.js (per Vite), Composer, Git e altri tool
- **Docker** / Docker Desktop in esecuzione (Lando richiede Docker)
- **Credenziali DB** definite in `.lando.yml`:
  - Utente: `admin`
  - Password: `sviluppo`
  - Database: `progetto`

Lando fornisce automaticamente:

- Container **appserver** con Apache/PHP e Composer
- Container **database** MySQL accessibile su porta 3307
- Servizio **phpMyAdmin** per ispezionare il DB
- CLI semplificate: `lando php`, `lando composer`, `lando mysql`, etc.

---

## Sviluppo in locale

### 1. Clona il repository

```bash
git clone https://github.com/Michele-Arganini/progetto-test.git
cd progetto-test
```

### 2. Configura le variabili d’ambiente

```bash
cp backend/.env.example backend/.env
# Modifica backend/.env:
# DB_HOST=database
# DB_PORT=3306
# DB_DATABASE=progetto
# DB_USERNAME=admin
# DB_PASSWORD=sviluppo
```

### 3. Avvia i servizi

```bash
lando start
```

### 4. Installa dipendenze & avvia

**Backend**

```bash
cd backend
lando composer install
```

**Frontend**

```bash
cd frontend
lando npm install
lando npm run dev
```

---

## Generazione del database di test

Dalla root del progetto, esegui:

```bash
php db/genera_sql.php > db/output.sql
```

Questo script genera le tabelle e popola il DB con dati di esempio.

### Import con Lando

```bash
lando db-import db/output.sql
```

---

## Utilizzo dell’API

### Esempio di richiesta

```bash
curl "https://orders-api-wnz2.onrender.com/api/orders?email=laura.bianchi@example.com"
```

### Esempio di risposta

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
    // ... altri ordini
  ]
}
```

---



## Credits

Creato da **Michele Arganini**

