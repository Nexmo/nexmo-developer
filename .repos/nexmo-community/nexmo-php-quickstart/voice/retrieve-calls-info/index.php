<?php 
require_once __DIR__ . '/../../config.php';
require_once __DIR__ . '/../../vendor/autoload.php';

$keypair = new \Nexmo\Client\Credentials\Keypair(file_get_contents(NEXMO_APPLICATION_PRIVATE_KEY_PATH), NEXMO_APPLICATION_ID);
$client = new \Nexmo\Client($keypair);

$filter = new \Nexmo\Call\Filter();
$filter->setStart(new DateTime('- 1 day'));
$filter->setEnd(new DateTime);

foreach ($client->calls($filter) as $call){
    echo json_encode($call).PHP_EOL;
}
