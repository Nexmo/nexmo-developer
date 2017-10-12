<?php 
require_once __DIR__ . '/../config.php';

require_once __DIR__ . '/../vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);

$client = new \Nexmo\Client(new \Nexmo\Client\Credentials\Container($basic));

$message = $client->message()->send([
    'to' => NEXMO_TO_NUMBER,
    'from' => NEXMO_FROM_NUMBER,
    'text' => 'Test message from the Nexmo PHP Client'
]);

var_dump($message->getResponseData());