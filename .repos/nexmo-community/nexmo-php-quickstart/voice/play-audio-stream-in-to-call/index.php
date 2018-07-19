<?php
require_once __DIR__ . '/../../config.php';
require_once __DIR__ . '/../../vendor/autoload.php';

$keypair = new \Nexmo\Client\Credentials\Keypair(file_get_contents(NEXMO_APPLICATION_PRIVATE_KEY_PATH), NEXMO_APPLICATION_ID);
$client = new \Nexmo\Client($keypair);

$stream = $client->calls[UUID]->stream();
$stream->setUrl('https://nexmo-community.github.io/ncco-examples/assets/voice_api_audio_streaming.mp3');
$stream->put();
