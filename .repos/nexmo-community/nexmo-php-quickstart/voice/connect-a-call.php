<?php 
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

// Retrive the inbound call details
$from = $_GET['from'];
$to = $_GET['to'];

// Create the `connect` NCCO
$ncco = [
    [
        'action' => 'connect',
        'from' => $from,
        'endpoint' => [
          [
            'type' => 'phone',
            'number' => NEXMO_TO_NUMBER
          ]
        ]
    ]
];

header('Content-Type: application/json');
$json = json_encode($ncco);
echo($json);
