<?php
require_once __DIR__ . '/../../config.php';
require_once __DIR__ . '/../../vendor/autoload.php';

$keypair = new \Nexmo\Client\Credentials\Keypair(file_get_contents(NEXMO_APPLICATION_PRIVATE_KEY_PATH), NEXMO_APPLICATION_ID);
$client = new \Nexmo\Client($keypair);

$client->calls[UUID]->put(new \Nexmo\Call\Earmuff());
sleep(3);
$client->calls[UUID]->put(new \Nexmo\Call\Unearmuff());
