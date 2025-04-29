<?php
namespace Src\Core;

use Src\Helpers\Cors;

class Bootstrap
{
    public static function init(): void
    {
        // Carica variabili d'ambiente da file .env
        if (file_exists(__DIR__ . '/../../.env')) {
            $env = parse_ini_file(__DIR__ . '/../../.env', false, INI_SCANNER_TYPED);
            foreach ($env as $k => $v) {
                $_ENV[$k] = $v;
            }
        }

        // Imposta gli header CORS
        Cors::setHeaders();
    }
}
