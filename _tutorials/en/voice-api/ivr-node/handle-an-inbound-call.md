---
title: Handle an Inbound Call
description: Handle an Inbound Call
---

## Handle an Inbound Call

When Nexmo receives an inbound call to your Nexmo number it makes a request to the event webhook endpoint you set when you [created a Voice application](#create-a-voice-application). A webhook is also sent each time *DTMF* input is collected from the user.

This tutorial code uses a simple router to handle these inbound webhooks. The router determines the requested URI path and uses it to map the caller's navigation through the phone menu - the same as URLs in web application.

Data from webhook body is captured and passed in the request information to the Menu:

```php
<?php

// public/index.php

require_once __DIR__ . '/../bootstrap.php';

$uri = ltrim(strtok($_SERVER["REQUEST_URI"],'?'), '/');
$data = file_get_contents('php://input');
```

Nexmo sends a webhook for every change in call status. For example, when the phone is `ringing`, the call has been `answered` or is `complete`. The application uses a `switch()` statement to log the data received by the `/event` endpoint for debug purposes. Every other request goes to the code that handles the user input. Here is the code:

```php
<?php

// public/index.php

switch($uri) {
    case 'event':
        error_log($data);
        break;
    default:
        $ivr = new \NexmoDemo\Menu($config);
        $method = strtolower($uri) . 'Action';

        $ivr->$method(json_decode($data, true));

        header('Content-Type: application/json');
        echo json_encode($ivr->getStack());
}
```

Any request that is not for `/event` is mapped to an `Action` method on the `Menu` object. Incoming request data is passed to that method. The router retrieves the NCCO (Nexmo Call Control Object) and sends it in the response as a JSON body with the correct `Content-Type`.

The `$config` array is passed to the `Menu` object, as it needs to know the base URL for the application when generating NCCOs that could include callback URLs:

```php
<?php

// src/Menu.php

public function __construct($config)
{
    $this->config = $config;
}
```