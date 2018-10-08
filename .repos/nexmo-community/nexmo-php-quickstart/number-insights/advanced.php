<?php 
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$client = new \Nexmo\Client($basic);

$insights = $client->insights()->advanced(INSIGHT_NUMBER);

switch($insights->getReachable()) {
    case 'reachable':
        $reachableStatus = 'is reachable';
        break;
    case 'unknown':
        $reachableStatus = 'may be reachable';
        break;
    default:
        $reachableStatus = 'could not be queried';
}

echo "The number ".$insights->getNationalFormatNumber()." ". $reachableStatus;
