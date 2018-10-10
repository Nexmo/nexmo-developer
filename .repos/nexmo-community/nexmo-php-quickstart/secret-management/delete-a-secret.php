<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$client = new \Nexmo\Client($basic);

try {
    $response = $client->account()->deleteSecret(NEXMO_API_KEY, NEXMO_SECRET_ID);
    echo "OK\n";
} catch(\Nexmo\Client\Exception\Request $e) {
    echo $e->getMessage();
}

