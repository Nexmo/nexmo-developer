<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';

$app = new \Slim\App;

$handler = function (Request $request, Response $response) {
    $params = $request->getParsedBody();

    // Fall back to query parameters if needed
    if (!count($params)){
        $params = $request->getQueryParams();
    }

    error_log(print_r($params, true));

    return $response->withStatus(204);
};

$app->get('/webhooks/delivery-receipt', $handler);
$app->post('/webhooks/delivery-receipt', $handler);

$app->run();
