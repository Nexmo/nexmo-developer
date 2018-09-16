<?php

require __DIR__ . '/../../config.php';
require 'vendor/autoload.php';
$app = new Slim\App();

$app->post('/sms/{number}', function ($request, $response, $args) {
    $body = $request->getParsedBody();

    if (!isset($body['text'])) {
        return $response->withStatus(400)->write("No message provided");
    }

    $client = new Nexmo\Client(new Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET));
    $text = new \Nexmo\Message\Text($args['number'], FROM, $body['text']);
    $client->message()->send($text);
    return $response->write("Sending an SMS to " . $args['number']);
});

$app->run();
