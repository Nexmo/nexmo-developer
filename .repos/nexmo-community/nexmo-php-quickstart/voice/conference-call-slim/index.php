<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

$app->any('/webhooks/answer', function (Request $request, Response $response) {
    // Nexmo may send a GET or a POST request, depending on your account
    // settings. Reject anything that isn't a GET/POST
    if (!in_array($request->getMethod(), ['GET', 'POST'])) {
        return $response->withStatus(404);
    }

    $ncco = [
        [
            'action' => 'talk',
            'text' => 'Welcome to a Nexmo powered conference call'
        ],
        [
            'action' => 'conversation',
            'name' => 'room-name'
        ]
    ];

    return $response->withJson($ncco);
});


$app->run();
