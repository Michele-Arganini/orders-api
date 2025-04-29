-- CREA TABELLE
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_items (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  PRIMARY KEY (order_id, product_id)
);

-- INSERISCI UTENTI
INSERT INTO users (email) VALUES
('mario.rossi@example.com'),
('laura.bianchi@example.com'),
('alessandro.verdi@example.com');

-- INSERISCI PRODOTTI
INSERT INTO products (name) VALUES
('Abbonamento Mensile'),
('Abbonamento Annuale'),
('Edizione Digitale'),
('Libro Internazionale'),
('Rivista Cartacea'),
('Podcast Exclusive'),
('Video Corso Premium'),
('Newsletter Premium'),
('Webinar Access'),
('Gift Card 50€'),
('Gift Card 100€'),
('E-book Scaricabile'),
('Audiolibro Internazionale'),
('T-shirt Brand'),
('Cappellino Brand'),
('Poster da Collezione'),
('Agenda 2025'),
('Zaino Brand'),
('Penna Personalizzata'),
('Calendario Digitale'),
('Corso di Cucina Online'),
('Masterclass Fotografia'),
('Corso Business Online'),
('Badge Premium Member'),
('Accesso Archivio Storico'),
('Abbonamento 6 Mesi');

-- INSERISCI ORDINI E ORDER ITEMS
INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 17 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 21, 3),
(1, 13, 3),
(1, 10, 1),
(1, 18, 4),
(1, 6, 2),
(1, 3, 1);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 10 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(2, 13, 4),
(2, 11, 1),
(2, 20, 1),
(2, 21, 1),
(2, 8, 2),
(2, 9, 2),
(2, 17, 3);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 2 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(3, 11, 3);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 3 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(4, 22, 3),
(4, 17, 3),
(4, 1, 3),
(4, 11, 3),
(4, 25, 4);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 26 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(5, 9, 3),
(5, 13, 1),
(5, 23, 1),
(5, 6, 3),
(5, 7, 1),
(5, 8, 4);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 22 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(6, 24, 2);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 14 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(7, 10, 3),
(7, 14, 3),
(7, 11, 2),
(7, 17, 2);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 2 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(8, 16, 4),
(8, 4, 3),
(8, 12, 4);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 27 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(9, 23, 4),
(9, 18, 2),
(9, 25, 3),
(9, 24, 4);

INSERT INTO orders (user_id, order_date) VALUES (1, NOW() - INTERVAL 4 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(10, 18, 2),
(10, 25, 4);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 24 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(11, 7, 4),
(11, 16, 3);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 2 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(12, 21, 4),
(12, 6, 1),
(12, 18, 2),
(12, 23, 1),
(12, 13, 2),
(12, 16, 1);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 29 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(13, 26, 3),
(13, 15, 4),
(13, 14, 4),
(13, 18, 1),
(13, 23, 2),
(13, 22, 2);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 27 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(14, 4, 1),
(14, 24, 3),
(14, 26, 3),
(14, 1, 1),
(14, 2, 4);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 12 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(15, 6, 2),
(15, 19, 1),
(15, 15, 4);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 28 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(16, 4, 3),
(16, 8, 2),
(16, 5, 4),
(16, 17, 1);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 28 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(17, 4, 1),
(17, 12, 3),
(17, 23, 4),
(17, 26, 3),
(17, 9, 3);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 11 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(18, 25, 2),
(18, 15, 4);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 29 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(19, 6, 3),
(19, 12, 3),
(19, 23, 2),
(19, 17, 2),
(19, 9, 2),
(19, 21, 2),
(19, 8, 2);

INSERT INTO orders (user_id, order_date) VALUES (2, NOW() - INTERVAL 15 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(20, 9, 4),
(20, 23, 2),
(20, 14, 2),
(20, 16, 1),
(20, 5, 3),
(20, 1, 3),
(20, 24, 2);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 11 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(21, 22, 4),
(21, 6, 1),
(21, 5, 4),
(21, 1, 3),
(21, 16, 1),
(21, 24, 4);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 6 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(22, 17, 1),
(22, 5, 2),
(22, 12, 4),
(22, 3, 4),
(22, 15, 2),
(22, 14, 2),
(22, 9, 3);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 8 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(23, 15, 2),
(23, 2, 3),
(23, 5, 3),
(23, 6, 4),
(23, 4, 4),
(23, 12, 2);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 20 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(24, 26, 3),
(24, 14, 3),
(24, 4, 3),
(24, 8, 3),
(24, 5, 4),
(24, 6, 1);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 5 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(25, 21, 4),
(25, 9, 3);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 5 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(26, 24, 3);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 20 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(27, 21, 3),
(27, 20, 1),
(27, 18, 4),
(27, 4, 2),
(27, 7, 3);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 14 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(28, 15, 1),
(28, 1, 1),
(28, 12, 4),
(28, 5, 4),
(28, 21, 3),
(28, 16, 1),
(28, 6, 1);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 6 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(29, 15, 2),
(29, 24, 3),
(29, 25, 3),
(29, 22, 1);

INSERT INTO orders (user_id, order_date) VALUES (3, NOW() - INTERVAL 16 DAY);
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(30, 16, 2),
(30, 5, 3),
(30, 19, 1),
(30, 11, 3),
(30, 1, 2),
(30, 22, 1),
(30, 4, 1);

