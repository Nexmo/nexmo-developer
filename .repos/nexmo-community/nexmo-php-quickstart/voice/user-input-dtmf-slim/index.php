<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

$app->add(function (Request $request, Response $response, $next) {
    // Nexmo may send a GET or a POST request, depending on your account
    // settings. Reject anything that isn't a GET/POST
    if (!in_array($request->getMethod(), ['GET', 'POST'])) {
        return $response->withStatus(404);
    }

    return $next($request, $response);
});

$app->any('/webhooks/answer', function (Request $request, Response $response) {
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

$app->any('/webhooks/dtmf', function (Request $request, Response $response) {
    $params = $request->getParsedBody();

    // Fall back to reading the query string if the body is empty
    if (!isset($params['dtmf'])) {
        $params = $request->getQueryParams();
    }

    $ncco = [
        [
            'action' => 'talk',
            'text' => 'You pressed '.$params['dtmf']
        ]
    ];

    return $response->withJson($ncco);
});

$app->run();
