---
title: Interactive Voice Response
products: voice/voice-api
description: Make it easy for visitors to navigate an Interactive Voice Response (IVR) application with simple text-to-speech (TTS) prompts.
languages:
    - PHP
---

# Interactive Voice Response

Make it easy for visitors to navigate an Interactive Voice Response (IVR) application with simple text-to-speech (TTS) prompts.

This tutorial is based on the [Simple IVR](https://www.nexmo.com/use-cases/interactive-voice-response/) use case. You download the code from <https://github.com/Nexmo/php-phone-menu>.

## In this tutorial

In this tutorial you build an interactive phone menu. The scenario is that a user is calling an automated service to get an update on the status of their order. We will set up a number to call, prompt a user to input their order with the keypad and then inform them of the (completely random and fictitious) status of their order.

- [Create a voice application](#create-a-voice-application) - create and configure an application using [Nexmo CLI](https://github.com/nexmo/nexmo-cli), then configure the webhook endpoints to provide NCCOs and handle changes in Call status
- [Buy a phone number](#buy-a-phone-number) - buy voice enabled numbers for use in the application
* [Link the phone numbers to the Nexmo Application](#link-phone-numbers-to-the-nexmo-application) - configure application to use the chosen numbers
- [Try it yourself](#try-it-yourself) - enough reading the code, let's run it!
- [Handle an inbound call](#handle-an-inbound-call) - configure your webhook endpoint to handle incoming voice calls, find the phone number it is associated with and handle the call
- [Send a text-to-speech greeting](#send-text-to-speech-greeting) - Greet the user with text-to-speech upon answer
- [Request user input via IVR](#request-user-input-via-ivr) - Create a text-to-speech prompt followed by requesting user input via IVR (Interactive Voice Response)
- [Respond to user input](#respond-to-user-input) - Handle the user order number input and play back status via text-to-speech

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and set up
* A publicly accessible web server so Nexmo can make webhook requests to your app
* The tutorial code from <https://github.com/Nexmo/php-phone-menu>

If you're developing behind a firewall or a NAT, use [ngrok](https://ngrok.com/) to tunnel access to your Web server.

## Create a Voice Application

A Nexmo application contains the security and configuration information you need to connect to Nexmo endpoints and easily use our products. You make calls to a Nexmo product using the security information in the application. When you make a Call, Nexmo communicates with your webhook endpoints so you can manage your call.

You can use Nexmo CLI to create an application for Voice API by using the following command and replacing the `YOUR_URL` segments with the URL of your own application:

```bash
nexmo app:create phone-menu YOUR_URL/answer YOUR_URL/event
Application created: 5555f9df-05bb-4a99-9427-6e43c83849b8
```

This command uses the `app:create` command to create a new app. The parameters are:

* `phone-menu` - the name you give to this application
* `https://example.com/answer` - when you receive an inbound call to your Nexmo number, Nexmo makes a [GET] request and retrieves the NCCO that controls the call flow from this webhook endpoint
* `https://example.com/event` - as the call status changes, Nexmo sends status updates to this webhook endpoint

It returns the UUID (Universally Unique Identifier) that identifies your application - we will need this later.

## Buy a phone number

To handle inbound calls to your application, you need a number from Nexmo. If you already have a number to use, jump to the next section to associate the existing number with your application.

If you don't have a number yet, use the [Nexmo CLI](https://github.com/nexmo/nexmo-cli) to buy the phone number:

```bash
nexmo number:buy --country_code GB --confirm
Number purchased: 441632960960
```

Now we can set up the phone number to point to the application you created earlier.

## Link phone numbers to the Nexmo Application

Next you will link each phone number with the *phone-menu* application. When any event occurs relating to a number associated with an application, Nexmo sends a web request to your webhook endpoints with information about the event. To do this, use the `link:app` command in the Nexmo CLI:

```bash
nexmo link:app 441632960960 5555f9df-05bb-4a99-9427-6e43c83849b8
```

The parameters are the phone number you want to use and the UUID returned when you [created a voice application](#create-a-voice-application) earlier.

## Try it yourself!

There's a detailed walkthrough of the code sample but for the impatient, let's try the application before we dive in too deeply. You should have your number and application created and linked from the above instructions; now we'll grab and run the code.

Start by cloning the repository if you haven't already: <git@github.com:Nexmo/php-phone-menu.git>

In the project directory, install the dependencies with Composer:

```
composer install
```

Copy the `config.php.dist` to `config.php` and edit it to add your base URL (the same URL that you used when setting up the application above).

> If you're using ngrok, it randomly generates a tunnel URL. It can be helpful to start ngrok before doing the other configuration so that you know what URL your endpoints will be on (paid ngrok users can reserve tunnel names). It might also be useful to know that there is a `nexmo app:update` command if you need update the URLs you set at any time

All set? Then start up the PHP webserver:

```
php -S 0:8080 ./public/index.php
```

Once it's running, call your nexmo voice number and follow the instructions! The code receives webhooks to `/event` as the call is started, ringing, etc. When the system answers the call, a webhook comes in to `/answer` and the code responds with some text-to-speech and then waits for user input. The user's input then arrives by webhook to '/search' and again the code responds with some text-to-speech.

Now you've seen it in action, you may be curious to know how the various elements work? Read on for a full walkthrough of our PHP code and how it manages the flow of the call...

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

## Generate NCCOs

A Nexmo Call Control Object (NCCO) is a JSON array that is used to control the flow of a Voice API call. Nexmo expects your webhook to return an NCCO to control the call.

To manage NCCOs this example application uses array manipulation and a few simple methods.

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

### Send text-to-speech greeting

Nexmo sends a webhook to the `/answer` endpoint of the application when the call is answered. The routing code sends this to the `answerAction()` method of the `Menu` object, which begins by adding an NCCO containing a greeting.

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

This is a great example of how to return a simple text-to-speech message.

### Request user input via IVR (Interactive Voice Response)

For our example application, the user needs to supply their order ID. For this part, first add another "talk" NCCO to the prompt (if the greeting was included, you'd greet the user every time we asked them for their order number). The next NCCO is where the user's input is received:

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

The `eventUrl` option in your NCCO is used to specify where to send the webhook when the user has entered their data. This is essentially the same thing you do with the `action` property of a HTML `<form>`. This is where the `$config` array and the base URL are used.

A few other `input` specific properties are used. `timeOut` gives the user more time to enter the order number and `submitOnHash` lets them avoid waiting by ending their order ID with the pound sign (that's a hash symbol '#' for all you British English speakers).

### Respond to user input

After the user has provided input, Nexmo sends a webhook to the `eventUrl` defined in the `input`. This results in a request to `/search` and is routed to `searchAction()`:

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

As you can see from the search action, the sample application sends some rather silly data back to the user! There is an NCCO that includes the order number from the incoming `dtmf` data field, a random order status and a random date (today, yesterday or a week ago) as a spoken "update". In your own application, there would probably be some more logical, err, logic.

Once the order information is passed to the user, they are told that they can hang up at anytime. The method that adds the order prompt NCCO is reused. That way the user can search for another order, but does not hear the welcome prompt every time.


### Some finer details of the tutorial application

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
