<?php

// Funzione per generare righe di order_items
function generateOrderItems($orderId, $productCount = 26) {
    $products = range(1, $productCount); // ID prodotti da 1 a 26
    shuffle($products);
    $numProducts = rand(1, 7); // Da 1 a 7 prodotti per ordine
    $selectedProducts = array_slice($products, 0, $numProducts);

    $values = [];
    foreach ($selectedProducts as $productId) {
        $quantity = rand(1, 4); // Quantità tra 1 e 4
        $values[] = "($orderId, $productId, $quantity)";
    }

    return $values;
}

// Utenti finti
$users = [
    1 => 'mario.rossi@example.com',
    2 => 'laura.bianchi@example.com',
    3 => 'alessandro.verdi@example.com',
];

// Prodotti finti
$products = [
    'Abbonamento Mensile',
    'Abbonamento Annuale',
    'Edizione Digitale',
    'Libro Internazionale',
    'Rivista Cartacea',
    'Podcast Exclusive',
    'Video Corso Premium',
    'Newsletter Premium',
    'Webinar Access',
    'Gift Card 50€',
    'Gift Card 100€',
    'E-book Scaricabile',
    'Audiolibro Internazionale',
    'T-shirt Brand',
    'Cappellino Brand',
    'Poster da Collezione',
    'Agenda 2025',
    'Zaino Brand',
    'Penna Personalizzata',
    'Calendario Digitale',
    'Corso di Cucina Online',
    'Masterclass Fotografia',
    'Corso Business Online',
    'Badge Premium Member',
    'Accesso Archivio Storico',
    'Abbonamento 6 Mesi',
];

// Crea tabelle
echo "-- CREA TABELLE\n";
echo "DROP TABLE IF EXISTS order_items;\n";
echo "DROP TABLE IF EXISTS orders;\n";
echo "DROP TABLE IF EXISTS products;\n";
echo "DROP TABLE IF EXISTS users;\n\n";

echo "CREATE TABLE users (\n  id INT AUTO_INCREMENT PRIMARY KEY,\n  email VARCHAR(255) NOT NULL UNIQUE\n);\n\n";
echo "CREATE TABLE products (\n  id INT AUTO_INCREMENT PRIMARY KEY,\n  name VARCHAR(255) NOT NULL\n);\n\n";
echo "CREATE TABLE orders (\n  id INT AUTO_INCREMENT PRIMARY KEY,\n  user_id INT NOT NULL,\n  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\n  FOREIGN KEY (user_id) REFERENCES users(id)\n);\n\n";
echo "CREATE TABLE order_items (\n  order_id INT NOT NULL,\n  product_id INT NOT NULL,\n  quantity INT NOT NULL DEFAULT 1,\n  FOREIGN KEY (order_id) REFERENCES orders(id),\n  FOREIGN KEY (product_id) REFERENCES products(id),\n  PRIMARY KEY (order_id, product_id)\n);\n\n";

// Inserisci utenti
echo "-- INSERISCI UTENTI\n";
echo "INSERT INTO users (email) VALUES\n";
echo implode(",\n", array_map(fn($email) => "('$email')", $users)) . ";\n\n";

// Inserisci prodotti
echo "-- INSERISCI PRODOTTI\n";
echo "INSERT INTO products (name) VALUES\n";
echo implode(",\n", array_map(fn($name) => "('$name')", $products)) . ";\n\n";

$orderId = 1;

// Inserisci ordini e prodotti per ogni utente
echo "-- INSERISCI ORDINI E ORDER ITEMS\n";

foreach ($users as $userId => $email) {
    for ($i = 0; $i < 10; $i++) { // 10 ordini per utente
        echo "INSERT INTO orders (user_id, order_date) VALUES ($userId, NOW() - INTERVAL " . rand(1, 30) . " DAY);\n";
        $orderItems = generateOrderItems($orderId);
        echo "INSERT INTO order_items (order_id, product_id, quantity) VALUES\n" . implode(",\n", $orderItems) . ";\n\n";
        $orderId++;
    }
}
?>
