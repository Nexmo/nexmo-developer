---
title: Interactive Voice Response
products: voice/voice-api
description: Make it easy for visitors to navigate an Interactive Voice Response (IVR) application with simple text-to-speech (TTS) prompts.
---

# Interactive Voice Response

Make it easy for visitors to navigate an Interactive Voice Response (IVR) application with simple text-to-speech (TTS) prompts.

This tutorial is based on the [Simple IVR](https://www.nexmo.com/use-cases/interactive-voice-response/) use case. You download the code from <https://github.com/Nexmo/php-phone-menu>.

## In this tutorial

In this tutorial you build an interactive phone menu with different paths based on the user's responses and identity:

- [Create a voice application](#create-a-voice-application) - create and configure an application using [Nexmo CLI](https://github.com/nexmo/nexmo-cli), then configure the webhook endpoints to provide NCCOs and handle changes in Call status
- [Buy a phone number](#buy-a-phone-number) - buy voice enabled numbers for use in the application
* [Link the phone numbers to the Nexmo Application](#link-numbers) - configure the voice enabled phone numbers to mask user numbers
- [Route an inbound call](#route-an-inbound-call) - configure your webhook endpoint to handle incoming voice calls, find the phone number it is associated with and handle the call
- [Send text-to-speech greeting](#text-to-speech) - Greet the user with text-to-speech upon answer
- [Request user input via IVR](#request-user-input) - Create a text-to-speech prompt followed by requesting user input via IVR
- [Receive user input webhook](#receive-user-input) - Handle the user order number input and play back status via text-to-speech

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and set up
* A publicly accessible web server so Nexmo can make webhook requests to your app
* The tutorial code from <https://github.com/Nexmo/php-phone-menu>

If you're developing behind a firewall or a NAT, use [ngrok](https://ngrok.com/) to tunnel access to your Web server.

## Create a Voice Application

A Nexmo application contains the security and configuration information you need to connect to Nexmo endpoints and easily use our products. You make calls to a Nexmo product using the security information in the application. When you make a Call, Nexmo communicates with your webhook endpoints so you can manage your call.

You can use Nexmo CLI to create an application for Voice API:

```bash
nexmo app:create phone-menu https://example.com/answer https://example.com/event
Application created: 5555f9df-05bb-4a99-9427-6e43c83849b8
```

This command returns the UUID (Universally Unique Identifier) that identifies your application.

The parameters are:

* `phone-menu` - the name you give to this application
* `https://example.com/answer` - when you receive an inbound call to your Nexmo number, Nexmo makes a [GET] request and retrieves the NCCO that controls the call flow from this webhook endpoint
* `https://example.com/event` - as the call status changes, Nexmo sends status updates to this webhook endpoint

## Buy a phone number

To handle inbound calls to the IVR, you need to buy a number from Nexmo.

Use the [Nexmo CLI](https://github.com/nexmo/nexmo-cli) to buy the phone numbers:

```bash
nexmo number:buy --country_code GB --confirm
Number purchased: 441632960960
```

**Note**: if you already bought a number from Nexmo, you do not need to buy another one for this tutorial. Associate your existing phone number with your application.

⚓ link-numbers
## Link phone numbers to the Nexmo Application

Now link each phone number with the *phone-menu* application. When any event occurs relating to a number associated with an application, Nexmo sends a request to your webhook endpoints with information about the event.

```bash
nexmo link:app 441632960960 5555f9df-05bb-4a99-9427-6e43c83849b8
```

Parameters are a phone number and the UUID returned when you [Create a voice application](#create-a-voice-application).

## Route an Inbound Call

When Nexmo receives an inbound call to your Nexmo number it makes a request to the webhook endpoint you set when you [created a Voice application](#create-a-voice-application). A call to your webhook endpoint is also made each time *dtmf* input is collected from the menu.

This tutorial code uses a simple router to handle these inbound webhooks. The router determines the requested URI path and uses it to map the caller's navigation through the phone menu - the same as URLs in web application.

Data from webhook body is captured and passed in the request information to the Menu:

```php
<?php

// public/index.php

require_once __DIR__ . '/../bootstrap.php';

$uri = ltrim(strtok($_SERVER["REQUEST_URI"],'?'), '/');
$data = file_get_contents('php://input');
```

Nexmo sends a webhook for every change in (link: voice/voice-api/handle-call-state text: Call status). For example, when the phone is `ringing`, the Call has been `answered` or is `complete`. Menu uses a switch to log this data for debug purposes. Every other request goes to the IVR code:

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

Any request that is not for `/event` is mapped to an `Action` method on the `Menu` object. Incoming request data is passed to that method. The router retrieves the NCCO and sends it in the response as a JSON body with the correct Content-Type.

The `$config` array is passed to the `Menu` object, as it needs to know the base URL for the application when generating NCCOs:

```php
<?php

// src/Menu.php

public function __construct($config)
{
    $this->config = $config;
}
```

## Generate NCCOs

A Nexmo Call Control Object (NCCO) is a JSON array that is used to control the flow of a Voice API call. Nexmo expects your webhook to return an NCCO to control the Call.

To manage NCCOs this tutorial uses array manipulation and a few simple methods.

The router handles encoding to JSON, the `Menu` object provides access to the the NCCO stack:

```php
<?php

// src/Menu.php

public function getStack()
{
    return $this->ncco;
}
```

The following methods provide the foundation for managing the NCCO stack:

```php
<?php

// src/Menu.php

protected function append($ncco)
{
    array_push($this->ncco, $ncco);
}

protected function prepend($ncco)
{
    array_unshift($this->ncco, $ncco);
}
```

⚓ text-to-speech
### Send text-to-speech greeting

The `talk` action NCCO is added to the stack to greet the user:

```php
<?php

// src/Menu.php

public function answerAction()
{
    $this->append([
        'action' => 'talk',
        'text' => 'Thanks for calling our order status hotline.'
    ]);

    $this->promptSearch();
}
```

⚓ request-user-input
### Request user input via IVR

The user is then prompted to input an order ID. This prompt is in a separate method so the user is not greeted every time they are prompted:

```php
<?php

// src/Menu.php

protected function promptSearch()
{
    $this->append([
        'action' => 'talk',
        'text' => 'Using the numbers on your phone, enter your order number followed by the pound sign'
    ]);

    $this->append([
        'action' => 'input',
        'eventUrl' => [$this->config['base_path'] . '/search'],
        'timeOut' => '10',
        'submitOnHash' => true
    ]);
}
```

The `eventUrl` option in your NCCO is used to send the input to a particular `Action`. This is essentially the same thing you do with the `action` property of a HTML `<form>`. This is where the `$config` array and the base URL are used.

A few other `input` specific properties are used. `timeOut` gives the user more time to enter the order number and `submitOnHash` lets them avoid waiting by ending their order ID with the pound sign.

⚓ receive-user-input
### Receive user input webhook

After the user has provided input, Nexmo sends a webhook to the `eventUrl` defined in the `input`. This is routed to `searchAction()`:

```php
<?php

// src/Menu.php

public function searchAction($request)
{
    if(isset($request['dtmf'])) {
        $dates = [new \DateTime('yesterday'), new \DateTime('today'), new \DateTime('last week')];
        $status = ['shipped', 'backordered', 'pending'];

        $this->append([
            'action' => 'talk',
            'text' => 'Your order ' . $this->talkCharacters($request['dtmf'])
                      . $this->talkStatus($status[array_rand($status)])
                      . ' as  of ' . $this->talkDate($dates[array_rand($dates)])
        ]);
    }

    $this->append([
        'action' => 'talk',
        'text' => 'If you are done, hangup at any time. If you would like to search again'
    ]);

    $this->promptSearch();
}
```

Remember that the router script passes on any data sent in the body of the request. If the user provided input, you find it in the `dtmf` property. When that happens in this simple tutorial, some order data is randomized. A more useful menu would provide the user information from a database, or perhaps an API of another system.

Once the order information is passed to the user, they are told that they can hang up at anytime. The method that adds the order prompt NCCO is reused. That way the user can search for another order, but does not hear the welcome prompt every time.

There are few more methods in our `Menu` code. Many times a phone menu interfaces with an existing system having data objects not easy converted to spoken prompts. In this example we have three things: objects that represent dates, an order ID, and a set of status constants.

Properly communicating those values to the caller uses three methods. The `talkDate` method just returns a string with a date format that works well for spoken words.

```php
<?php

// src/Menu.php

protected function talkDate(\DateTime $date)
{
    return $date->format('l F jS');
}
```

The `talkCharacters` method puts a space between each character in a string, so they are read individually.


```php
<?php

// src/Menu.php

protected function talkCharacters($string)
{
    return implode(' ', str_split($string));
}
```

The `talkStatus` method converts a very terse constant into a more conversational phrase.

```php
<?php

// src/Menu.php

protected function talkStatus($status)
{
    switch($status){
        case 'shipped':
            return 'has been shipped';
        case 'pending':
            return 'is still pending';
        case 'backordered':
            return 'is backordered';
        default:
            return 'can not be located at this time';
    }
}
```

## Conclusion

Now you've built a interactive phone menu that both collects input from the user, and responds with (albeit fake) information. Instead of using the `talk` NCCO to inform the user, a `connect` NCCO could forward the call to a particular department, or a `record` NCCO could capture a voicemail from the user.
