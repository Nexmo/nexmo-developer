<?php 
require_once __DIR__ . '/../config.php';

require_once __DIR__ . '/../vendor/autoload.php';

$request = array_merge($_GET, $_POST);

// Check that this is a delivery receipt.
if (!isset($request['messageId']) || !isset($request['status'])) {
    error_log('This is not a delivery receipt');
    return;
}

//Check if your message has been delivered correctly.
if ($request['status'] === 'delivered') {
    error_log("Your message to {$request['msisdn']} (message id {$request['messageId']}) was delivered.");
    error_log("The cost was {$request['price']}.");
}
else if ($request['status'] === 'accepted') {
    error_log("Your message to {$request['msisdn']} (message id {$request['messageId']}) was accepted by the carrier.");
    error_log("The cost was {$request['price']}.");
}
else {
    error_log("Your message to {$request['msisdn']} has a status of: {$request['status']}.");
    error_log("Check err-code {$request['err-code']} against the documentation.");
}