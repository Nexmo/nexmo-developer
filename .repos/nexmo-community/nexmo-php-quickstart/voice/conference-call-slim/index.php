<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

$app->get('/webhooks/answer', function (Request $request, Response $response) {
    $ncco = [
        [
            'action' => 'talk',
            'text' => 'Hi, welcome to this Nexmo conference call.'
        ],
        [
            'action' => 'conversation',
            'name' => 'nexmo-conference-standard'
        ]
    ];

    return $response->withJson($ncco);
});


$app->run();
