<?php 
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$client = new \Nexmo\Client(new \Nexmo\Client\Credentials\Container($basic));

$verification = new \Nexmo\Verify\Verification(NEXMO_TO_NUMBER, 'My App');
$client->verify()->start($verification);

echo "Started verification with an id of: " . $verification->getRequestId();