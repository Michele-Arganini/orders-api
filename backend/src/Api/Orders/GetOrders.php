<?php
declare(strict_types=1);

namespace Src\Api\Orders;

use MysqliDb;

class GetOrders
{
    public function handle(): void
    {
        // 1) Controlla che il metodo sia GET
        if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
            http_response_code(405);
            echo json_encode(['error' => 'Metodo non consentito']);
            return;
        }

        // 2) Valida l'email ricevuta
        $email = filter_input(INPUT_GET, 'email', FILTER_VALIDATE_EMAIL);
        if (!$email) {
            http_response_code(400);
            echo json_encode(['error' => 'Email non valida o mancante']);
            return;
        }

        // 3) Connessione al database
        $db = new MysqliDb(
            $_ENV['DB_HOST']     ?? 'database',
            $_ENV['DB_USERNAME'] ?? 'admin',
            $_ENV['DB_PASSWORD'] ?? 'sviluppo',
            $_ENV['DB_DATABASE'] ?? 'progetto',
            (int) ($_ENV['DB_PORT'] ?? 3306),
            'utf8mb4'
        );

        // 4) Calcola la data di 30 giorni fa
        $since = date('Y-m-d', strtotime('-30 days'));

        // 5) Recupera gli ordini recenti dell'utente
        $db->where('u.email', $email);
        $db->where('o.order_date', $since, '>=');
        $db->join('users u', 'o.user_id = u.id', 'LEFT');
        $orders = $db->get('orders o', null, 'o.id, o.order_date');

        // 6) Carica i prodotti per ogni ordine
        foreach ($orders as &$ord) {
            $db->where('oi.order_id', $ord['id']);
            $db->join('products p', 'oi.product_id = p.id', 'LEFT');
            $items = $db->get('order_items oi', null, 'p.name, oi.quantity');

            $grouped = [];
            foreach ($items as $it) {
                $name = $it['name'];
                $qty  = (int) $it['quantity'];
                if (isset($grouped[$name])) {
                    $grouped[$name]['quantity'] += $qty;
                } else {
                    $grouped[$name] = [
                        'name'     => $name,
                        'quantity' => $qty,
                    ];
                }
            }
            $ord['products'] = array_values($grouped);
        }

        // 7) Restituisce la risposta JSON
        echo json_encode([
            'success' => true,
            'orders'  => $orders,
        ]);
    }
}
