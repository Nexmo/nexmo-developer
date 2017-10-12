<?php 
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

// Support direct execution from command line or via a GET request as a web server
define('VERIFY_REQUEST_ID', isset($argv[1])? $argv[1]: $_GET['request_id']);
define('PIN_CODE', isset($argv[2])? $argv[2]: $_GET['pin_code']);

error_log('Verifying that request ' . VERIFY_REQUEST_ID . ' was pin code ' . PIN_CODE);

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$client = new \Nexmo\Client(new \Nexmo\Client\Credentials\Container($basic));

$verification = new \Nexmo\Verify\Verification(VERIFY_REQUEST_ID);
$result = $client->verify()->check($verification, PIN_CODE);

var_dump($result->getResponseData());