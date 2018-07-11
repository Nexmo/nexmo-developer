<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

$app->get('/webhooks/answer', function (Request $request, Response $response) {
    $uri = $request->getUri();
    $ncco = [
        [
            'action' => 'conversation',
            'name' => CONV_NAME,
            'record' => true,
            'eventMethod' => 'POST', // # This currently needs to be set rather than default due to a known issue https://help.nexmo.com/hc/en-us/articles/360001162687
            'eventUrl' => [
                $uri->getScheme().'://'.$uri->getHost().':'.$uri->getPort().'/webhooks/recording'
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
