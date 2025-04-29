# Progetto Test – Frontend Vue + Backend PHP (MysqliDb)

Una piccola API PHP che espone un endpoint `/api/orders?email=` e un frontend Vue 3/Vite che permette di cercare e visualizzare gli ordini degli ultimi 30 giorni.  
Il progetto può essere eseguito **in locale** con Lando o PHP-CLI + MySQL, e **in produzione** tramite Vercel.

---

## ⚙️ Prerequisiti locali

- **Node.js** (per il frontend)
- **PHP 8.1+** (`php-cli`)
- **Composer** (per il backend)
- **MySQL 5.7+** (o MariaDB)
- **Lando** (consigliato) _oppure_ Docker Desktop / docker-compose

---

## 🚀 Sviluppo in locale

### 1. Clona e setup

```bash
git clone https://github.com/Michele-Arganini/orders-api.git
cd progetto-test

🎉 Credits

Creato da Michele Arganini.