<?php 
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

// Building Blocks
// 1. Make a Phone Call
// 2. Play Text-to-Speech

$keypair = new \Nexmo\Client\Credentials\Keypair(file_get_contents(NEXMO_APPLICATION_PRIVATE_KEY_PATH), NEXMO_APPLICATION_ID);
$client = new \Nexmo\Client($keypair);

$call = $client->calls()->create([
    'to' => [[
        'type' => 'phone',
        'number' => TO_NUMBER
    ]],
    'from' => [
        'type' => 'phone',
        'number' => NEXMO_NUMBER
    ],
    'answer_url' => ['https://developer.nexmo.com/ncco/tts.json'],
]);

error_log($call);
