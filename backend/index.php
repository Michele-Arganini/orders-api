<?php
require __DIR__ . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->safeLoad();

// Inizializza ambiente e CORS
\Src\Core\Bootstrap::init();

// Gestisce la richiesta
\Src\Core\Router::dispatch();
