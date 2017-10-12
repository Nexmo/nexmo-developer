<?php 
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

// Building Blocks
// 1. Make a Phone Call
// 2. Play Text-to-Speech

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$keypair = new \Nexmo\Client\Credentials\Keypair(file_get_contents(NEXMO_PRIVATE_KEY), NEXMO_APPLICATION_ID);

$client = new \Nexmo\Client(new \Nexmo\Client\Credentials\Container($basic, $keypair));

$call = $client->calls()->create([
    'to' => [[
        'type' => 'phone',
        'number' => NEXMO_TO_NUMBER
    ]],
    'from' => [
        'type' => 'phone',
        'number' => NEXMO_FROM_NUMBER
    ],
    'answer_url' => ['https://nexmo-community.github.io/ncco-examples/first_call_talk.json'],
]);

error_log($call);