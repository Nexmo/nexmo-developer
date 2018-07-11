<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->get('/answer', function () {
    $from = app('request')->input('from');
    $log = date('Y-m-d H:i:s') .' '. $from.PHP_EOL;
    file_put_contents(__DIR__.'/../call-log.txt', $log, FILE_APPEND | LOCK_EX);

    $voice = 'Russell';

    // If it's a UK number, use an en-GB voice
    if (substr($from, 0, 2) == '44') {
        $voice = 'Amy';
    }

    return response()->json([
        [
            'action' => 'talk',
            'voiceName' => $voice,
            'text' => 'Thanks for your call. We are unable to take your call at the moment but the robot will make sure we know you called.',
        ]
    ]);
});
