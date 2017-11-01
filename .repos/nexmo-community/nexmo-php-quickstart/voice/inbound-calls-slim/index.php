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

    $params = $request->getParsedBody();

    // Fall back to reading the query string if the body is empty
    if (!isset($params['from'])) {
        $params = $request->getQueryParams();
    }

    $fromSplitIntoCharacters = implode(" ", str_split($params['from']));

    $ncco = [
        [
            'action' => 'talk',
            'text' => 'Thank you for calling from '.$fromSplitIntoCharacters
        ]
    ];

    return $response->withJson($ncco);
});

$app->run();
