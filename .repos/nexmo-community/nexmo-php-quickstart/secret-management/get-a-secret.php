<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$client = new \Nexmo\Client($basic);

try {
    $secret = $client->account()->getSecret(NEXMO_API_KEY, NEXMO_SECRET_ID);
    echo "ID: " . $secret['id'] . " (created " . $secret['created_at'] .")\n";
} catch (\Nexmo\Client\Exception\Request $e) {
    echo $e->getMessage();
}
