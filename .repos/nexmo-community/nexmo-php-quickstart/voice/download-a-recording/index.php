<?php
require_once __DIR__ . '/../../config.php';
require_once __DIR__ . '/../../vendor/autoload.php';

$keypair = new \Nexmo\Client\Credentials\Keypair(file_get_contents(NEXMO_APPLICATION_PRIVATE_KEY_PATH), NEXMO_APPLICATION_ID);
$client = new \Nexmo\Client($keypair);

$recordingUrl = 'https://api.nexmo.com/v1/files/'.NEXMO_RECORDING_ID;
$data = $client->get($recordingUrl);
file_put_contents($recordingId.'.mp3', $data->getBody());
