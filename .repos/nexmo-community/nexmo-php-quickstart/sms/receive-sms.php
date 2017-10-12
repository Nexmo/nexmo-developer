<?php 
require_once __DIR__ . '/../config.php';

require_once __DIR__ . '/../vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$client = new \Nexmo\Client(new \Nexmo\Client\Credentials\Container($basic));

$inbound = \Nexmo\Message\InboundMessage::createFromGlobals();

if($inbound->isValid()){
    error_log($inbound->getBody());

    $client->message()->send($inbound->createReply('Thanks for the SMS!'));
} else {
    error_log('invalid message');
}