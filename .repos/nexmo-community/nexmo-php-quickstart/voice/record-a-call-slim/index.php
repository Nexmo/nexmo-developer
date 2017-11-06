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
            'text' => 'Please leave a message after the tone, then press pound.'
        ],
        [
            'action' => 'record',
            'endOnKey' => '#',
            'beepOnStart' => true,
            'eventUrl' => [
                $uri->getScheme().'://'.$uri->getHost().':'.$uri->getPort().'/webhooks/recording'
            ]
        ],
        [
            'action' => 'talk',
            'text' => 'Thank you for your message'
        ],

    ];

    return $response->withJson($ncco);
});

$app->any('/webhooks/recording', function (Request $request, Response $response) {
    $params = $request->getParsedBody();

    // Fall back to reading the query string if the body is empty
    if (!isset($params['recording_url'])) {
        $params = $request->getQueryParams();
    }

    error_log($params['recording_url']);

    return $response->withStatus(204);
});

$app->run();
