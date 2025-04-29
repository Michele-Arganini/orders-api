<?php
namespace Src\Core;

class Router {
    public static function dispatch(): void {
        // Pulisce l'URI della richiesta
        $req = trim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');

        // Se root o index.php, mostra messaggio API online
        if ($req === '' || $req === 'index.php') {
            echo json_encode(['message' => 'API online']);
            return;
        }

        // Se URI inizia con api/, instrada alla classe corretta
        if (str_starts_with($req, 'api/')) {
            $parts     = explode('/', substr($req, 4), 2);
            $className = 'Src\\Api\\' . ucfirst($parts[0]) . '\\Get' . ucfirst($parts[0]);
            if (class_exists($className)) {
                (new $className())->handle();
                return;
            }
        }

        // Se non trova nulla, 404
        http_response_code(404);
        echo json_encode(['error' => 'Endpoint non trovato']);
    }
}
