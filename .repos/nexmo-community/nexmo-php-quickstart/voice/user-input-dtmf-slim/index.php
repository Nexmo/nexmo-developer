<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

$app->get('/webhooks/answer', function (Request $request, Response $response) {
    $uri = $request->getUri();
    $ncco = [
        [
            'action' => 'talk',
            'text' => 'Please enter a digit'
        ],
        [
            'action' => 'input',
            'eventUrl' => [
                $uri->getScheme().'://'.$uri->getHost().':'.$uri->getPort().'/webhooks/dtmf'
            ]
        ]
    ];

    return $response->withJson($ncco);
});

$app->post('/webhooks/dtmf', function (Request $request, Response $response) {
    $params = $request->getParsedBody();

    $ncco = [
        [
            'action' => 'talk',
            'text' => 'You pressed '.$params['dtmf']
        ]
    ];

    return $response->withJson($ncco);
});

$app->run();
