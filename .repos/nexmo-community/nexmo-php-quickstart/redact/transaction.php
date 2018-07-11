<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic(NEXMO_API_KEY, NEXMO_API_SECRET);
$client = new \Nexmo\Client($basic);

// This request returns a 204 on success, and throws on error
$client->redact()->transaction(NEXMO_REDACT_ID, NEXMO_REDACT_TYPE);
