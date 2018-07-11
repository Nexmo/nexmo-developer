<?php 
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

// Instruct Nexmo to add this call to a conference
// Start with an optional announcement using the `talk` action
$ncco = [
    [
        'action' => 'talk',
        'text' => 'Welcome to the amazing Nexmo conference call'
    ],
    [
        'action' => 'conversation',
        'name' => 'amazing-conference-call'
    ]
];

header('Content-Type: application/json');
$json = json_encode($ncco);
echo($json);
