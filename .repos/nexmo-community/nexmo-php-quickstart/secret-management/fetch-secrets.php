<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$client = new \Nexmo\Client($basic);

$response = $client->account()->listSecrets(NEXMO_API_KEY);
foreach($response['secrets'] as $secret) {
    echo "ID: " . $secret['id'] . " (created " . $secret['created_at'] .")\n";
}
