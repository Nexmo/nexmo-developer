<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

$app->get('/webhooks/answer', function (Request $request, Response $response) {
    $uri = $request->getUri();
    $ncco = [
        [
            'action' => 'record',
            'split' => 'conversation',
            'channels' => 2,
            'eventUrl' => [
                $uri->getScheme().'://'.$uri->getHost().':'.$uri->getPort().'/webhooks/recording'
            ]
        ],
        [
            'action' => 'connect',
            'from' => NEXMO_NUMBER,
            'endpoint' => [
                [
                    'type' => 'phone',
                    'number' => TO_NUMBER
                ]
            ]
        ],

    ];

    return $response->withJson($ncco);
});

$app->post('/webhooks/recording', function (Request $request, Response $response) {
    $params = $request->getParsedBody();
    error_log($params['recording_url']);
    return $response->withStatus(204);
});

$app->run();
