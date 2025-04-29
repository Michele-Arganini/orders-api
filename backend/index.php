<?php
// Carica le dipendenze
require __DIR__ . '/vendor/autoload.php';

// Inizializza ambiente e CORS
\Src\Core\Bootstrap::init();

// Gestisce la richiesta
\Src\Core\Router::dispatch();
