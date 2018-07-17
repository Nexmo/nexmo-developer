---
title: Broadcast Voice-based Critical Alerts
products: voice/voice-api
description: In this tutorial, you will learn how to send out voice messages and see who was contacted, who responded, and when. These voice-based critical alerts are more persistent than a text message, making your message more likely to be noticed. Additionally, with the recipient confirmation, you can be sure that your message made it through.
languages:
    - PHP
---

# Broadcast Voice-based Critical Alerts

A persistently ringing phone is harder to miss than a text message or push alert, so when you need to ensure that [critical  alerts](https://www.nexmo.com/use-cases/voice-based-critical-alerts) make it through to the right person a phone call is one of the best options available.

In this tutorial, you will learn how to send out voice messages and see who was contacted, who responded, and when. These voice-based critical alerts are more persistent than a text message, making your message more likely to be noticed. Additionally, with the recipient confirmation, you can be sure that your message made it through.

- [Create a Voice Application](#create-a-voice-application) - create a Nexmo application using the Nexmo API and Nexmo CLI
- [Provision a Virtual Number](#provision-a-virtual-number) - rent the number from which your message will come
- [Creating a Nexmo Call Control Object](#creating-a-nexmo-call-control-object-ncco) - using Nexmo Call Control Objects, return information to the user, and prompt for input
- [Creating a call](#creating-a-call) - initiate the calls to everyone who needs to be notified
- [Using a Recording Instead of Text-To-speech](#using-a-recording-instead-of-text-to-speech) - Use a pre-recorded message for the call instead of a text-to-speech message
- [Handling Answering Machines and Voicemail](#handling-answering-machines-and-voicemail) - Log if a call is answered by an answering machine or voicemail
- [Confirming Receipt of the Message](#confirming-receipt-of-the-message) - Receive and log confirmation of receipt from the user
- [Broadcasting to multiple people](#broadcasting-to-multiple-people) - Broadcast the alert to multiple people who all need to be aware

# Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and set up
* [Composer](http://getcomposer.org/) to install the [Nexmo PHP library](https://github.com/nexmo/nexmo-php)
* A publicly accessible web server so Nexmo can make webhook requests to your app
* The tutorial code from <https://github.com/Nexmo/php-voice-alerts-tutorial>

If you're developing behind a firewall or a NAT, use [ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) to tunnel access to your Web server.

# Getting Started

First, you'll need to collect a few details for the configuration. The project will be comprised of:

**A Web Application**: this will initiate the calls and track the user response by responding to a series of webhooks from Nexmo. We need the publicly accessible URL of the application. A tool like [ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) will provide you a subdomain pointing to your local development system.

> For the rest of this tutorial, we will use `http://example.com/` as our domain. You will need to replace that domain with your own (and include any additional URL path info) for your application to work.

**A Nexmo Application**: this holds the configuration that Nexmo needs to interact with your Web Application.

**A Nexmo Virtual Number**: this number will be associated with the Nexmo Application and is the number users will see when they receive your alert.

## Create a Voice Application

To create a voice application on the Nexmo platform, you can use either the [use the Nexmo API](https://dashboard.nexmo.com) or the Nexmo API. We're going to use the API via the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) tool. Execute the following command to create a Nexmo Application with the Nexmo CLI:

```bash
nexmo app:create --keyfile private.key phone-alerts https://example.com/answer.php https://example.com/event.php
Application created: 5555f9df-05bb-4a99-9427-6e43c83849b8
```

`phone-alerts` is the name of the application and the next parameter is the webhook endpoint that Nexmo will make a request to when a call is made to a number associated with the application. The final parameter is also a webhook endpoint so that Nexmo can inform your application of other events related your Nexmo app.

The output of this command is the Application UUID (Universally Unique IDentifier) - make a note of this as we'll need it soon. The command will also write `private.key` to disk (thanks to the `--keyfile private.key` option) so that we can authenticate our requests later.

## Provision a Virtual Number

To make the calls to send out the alert, you need a phone number. Numbers can be managed with the API or in the Nexmo Dashboard. You can also buy a number using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli). If you're using the CLI, the following command will purchase a US number for you automatically:

> If you have an existing number in your Nexmo account, you can skip purchasing a new number and just associate it with your application.

```bash
nexmo number:buy --country_code US --confirm
Number purchased: 14155550100
```

Next, associate the number you just purchased with the application that you created above. This ensures that a request is made to your application's webhook when any event takes place relating to the number, like user input after your alert message plays.

```bash
nexmo link:app 14155550100 5555f9df-05bb-4a99-9427-6e43c83849b8
```

## Creating a Nexmo Call Control Object (NCCO)

Now that you have an application and linked number, it's time to create your first call. Let's start with something simple to get this working - we're going to create an [NCCO](/voice/voice-api/ncco-reference) to deliver a text-to-speech message. Create `answer.php` with the following contents:

```php
<?php

// The incoming request could be a GET or a POST, depending on how your
// account is configured
$request = array_merge($_GET, $_POST);

// This is the phone number being called
$to = $request['to'];

// This is the caller's phone number
$from = $request['from'];

// Nexmo provide a unique ID for all calls
$uuid = $request['conversation_uuid'];

// For more advanced Conversations you use the above parameters to
// dynamically create the NCCO and provide a personalised experience

$ncco = [
    [
        "action" => "talk",
        "voiceName" => "Jennifer",
        "text" => "Hello, here is your message. I hope you have a nice day."
    ]
];

// Nexmo expect you to return JSON with the correct headers
header('Content-Type: application/json');
echo json_encode($ncco);
```

This configures Nexmo to respond to our call with "Hello, here is your message. I hope you have a nice day".

As well as responding with JSON to configure our call, we need an endpoint that Nexmo will use to send call events to our system. Create `event.php` with the following contents to handle status changes to your call:

```php
<?php

// Nexmo send a JSON payload to your event endpoint, so read and decode it
$request = json_decode(file_get_contents('php://input'), true);

// Work with the call status
if (isset($request['status'])) {
    switch ($request['status']) {
    case 'ringing':
        record_steps("UUID: {$request['conversation_uuid']} - ringing.");
        break;
    case 'answered':
        record_steps("UUID: {$request['conversation_uuid']} - was answered.");
        break;
    case 'complete':
        // If you set eventUrl in your NCCO. The recording download URL
        // is returned in recording_url. It has the following format
        // https://api.nexmo.com/media/download?id=52343cf0-342c-45b3-a23b-ca6ccfe234b0
        //
        // Make a GET request to this URL using JWT authentication to download
        // the recording. For more information, see
        // https://developer.nexmo.com/voice/voice-api/guides/record-calls-and-conversations
        record_steps("UUID: {$request['conversation_uuid']} - complete.");
        break;
    default:
        break;
    }
}

function record_steps($message) {
    file_put_contents('./call_log.txt', $message.PHP_EOL, FILE_APPEND | LOCK_EX);
}
```

> The `record_steps()` function here is just a very basic logging example, writing to a text file. You can replace this with your preferred logging protocol.

At this point, we've written enough code to test our voice call system. Call the number you purchased earlier using your own phone, and you should hear a text to speech message played. However, we're creating a system to broadcast alerts out when they happen, which means we need to make outbound calls.

## Creating a call

Creating an outbound call involves using the private key we saved earlier to generate an authentication token for the Nexmo API. To make things easier, we've wrapped up all of the code to do this in the [Nexmo PHP library](https://github.com/nexmo/nexmo-php).You'll need to [install the library](https://github.com/nexmo/nexmo-php#installation), then create a file named `broadcast.php` with the following contents:

```php
<?php

require_once 'vendor/autoload.php';

$basic  = new \Nexmo\Client\Credentials\Basic('API_KEY', 'API_SECRET');
$keypair = new \Nexmo\Client\Credentials\Keypair(
    file_get_contents(__DIR__ . '/private.key'),
    '5555f9df-05bb-4a99-9427-6e43c83849b8'
);

$client = new \Nexmo\Client(new \Nexmo\Client\Credentials\Container($basic, $keypair));

$client->calls()->create([
    'to' => [[
        'type' => 'phone',
        'number' => 'TO_NUMBER'
    ]],
    'from' => [
        'type' => 'phone',
        'number' => '14155550100'
    ],
    'answer_url' => ['https://example.com/answer.php'],
    'event_url' => ['https://example.com/event.php'],
]);
```

At this point, you have a functioning call system. Test it out now by updating the "to" number in the call payload in your answer script and then running `php broadcast.php`. You can modify the message that is spoken in the NCCO file. You can also specify different voices and languages (see the full list of options in the [NCCO Reference section](https://docs.nexmo.com/voice/voice-api/ncco-reference#talk).

## Using a Recording Instead of Text-To-Speech

To use a pre-recorded message instead of (or as well as!) using Nexmo's text-to-speech functionality, update the NCCO file with a new action, `stream`. `stream` allows you to play back an audio file to the caller. The "streamUrl" will point to your audio file.

```php
[
    "action" => "stream",
    "streamUrl" => ["https://example.com/audioFile.mp3"]
],
```

> If you test the recording, and it is too loud or too quiet, you can adjust the volume level of the recording on the call by setting the "level". The default value is "0", and you can turn the volume down to -1 or up to 1 in increments of 0.1.

```php
[
    "action" => "stream",
    "level" => "-0.4",
    "streamUrl" => ["https://example.com/audioFile.mp3"]
],
```

## Handling Answering Machines and Voicemail

If you want to keep track of which numbers went to voicemail instead of being answered, you need to add the `machine_detection` parameter to your call payload in your broadcast script. There are two options you can set for this, `continue` or `hangup`. If you want to log that the call went to voicemail, choose `continue`, and an HTTP request will be sent to your event script (the URL specified in `event_url`).

```php
'answer_url' => ['https://example.com/answer.php'],
'event_url' =>  ['https://example.com/event.php'],
'machine_detection' => 'continue'
```

Then, in your event script, you will now receive the status of "machine" when handling the call status for a call that goes to voicemail.

```php
if (isset($request['status'])) {
    switch ($request['status']) {
    case 'ringing':
        record_steps("UUID: {$request['conversation_uuid']} - ringing.");
        break;
    case 'answered':
        record_steps("UUID: {$request['conversation_uuid']} - was answered.");
        break;
    case 'machine':
        record_steps("UUID: {$request['conversation_uuid']} - answering machine.");
        break;
    case 'complete':
        // If you set eventUrl in your NCCO. The recording download URL
        // is returned in recording_url. It has the following format
        // https://api.nexmo.com/media/download?id=52343cf0-342c-45b3-a23b-ca6ccfe234b0
        //
        // Make a GET request to this URL using JWT authentication to download
        // the recording. For more information, see
        // https://developer.nexmo.com/voice/voice-api/guides/record-calls-and-conversations
        record_steps("UUID: {$request['conversation_uuid']} - complete.");
        break;
    default:
        break;
    }
}
```

## Confirming Receipt of the Message

If you would like your call recipients to confirm that they have received your message, you can ask them to push a button and record that action in your log. To do this, update the NCCO file with a second "talk" action giving the recipient instructions to follow.

```php
[
  "action" => "talk",
  "voiceName" => "Jennifer",
  "text" => "To confirm receipt of this message, please press 1 followed by the pound sign"
],
```

Next, add an "input" action to capture any buttons that the recipient presses. We set `submitOnHash` to true to allow early submission of their confirmation. If they don't confirm within 10 seconds (the `timeout` parameter - it defaults to 3 seconds) the call will automatically progress.

```php
[
  "action" => "input",
  "submitOnHash" => "true",
  "timeout" => 10
],
```

Finally, add another "talk" action to acknowledge their action and finish the call.

```php
[
  "action" => "talk",
  "voiceName" => "Jennifer",
  "text" => "Thank you, you may now hang up."
]
```

Altogether, your NCCO file should now contain five actions - a `talk` action, a `stream` action, another `talk` action, an `input` action and then one final `talk` action to round it off.

In your event script, you'll need to add some code to handle the input action. The data from the input action will be provided under the `dtmf` key, with the number that was pressed as the value. You can add this after the `$request['status']` case statement.

```php
if (isset($request['dtmf'])) {
  switch ($request['dtmf']) {
      case '1':
          record_steps("UUID: {$request['conversation_uuid']} - confirmed receipt.");
          break;
      default:
          record_steps("UUID: {$request['conversation_uuid']} - other button pressed ({$request['dtmf']}).");
          break;
  }
}
```

## Broadcasting to multiple people

At this point we can make and receive phone calls, use text-to-speect, stream an mp3 to the receiver and capture that they got the message via DTMF. It's a great start, but there's just one thing missing - we still have a single point of failure. If we call a single person and they don't see the message, our critical alert goes unnoticed. We need to [broadcast our message](https://www.nexmo.com/use-cases/voice-broadcast) out to multiple people.

The first thing to do is to update our log messages to contain the phone number that we're interacting with. The recipient's number is available as `$request['to']` in the `completed` event type, so let's update the `case 'complete':` block to also log the phone number by changing it to the following code:

```php
case 'complete':
    // If you set eventUrl in your NCCO. The recording download URL
    // is returned in recording_url. It has the following format
    // https://api.nexmo.com/media/download?id=52343cf0-342c-45b3-a23b-ca6ccfe234b0
    //
    // Make a GET request to this URL using JWT authentication to download
    // the recording. For more information, see
    // https://developer.nexmo.com/voice/voice-api/guides/record-calls-and-conversations
    record_steps("To: {$request['to'] - UUID: {$request['conversation_uuid']} - complete.");
    break;
```

By storing the recipient's phone number along with the request `conversation_uuid`, we can link a set of call events to a specific phone number once the call has completed.

Now that we can track which phone number a call is made to, it's time to add support for broadcasting out to multiple people! This data could come from any data source you like, but we'll add a static array in our script. At the top of `broadcast.php`, define an array of people to call like so:


```php
$contacts = [
    "Bob Smith" => 14155550200,
    "Jenny Cable" => 14155550355
];
```

Once you have this array, there's just one small change left to make. We need to wrap `$client->calls()->create()` in a loop so that it calls each number in turn. We also add a small delay after each call to ensure that we don't hit the [API rate limit](https://help.nexmo.com/hc/en-us/articles/207100288-What-is-the-maximum-number-of-calls-per-second-):

```php
foreach ($contacts as $name => $number) {
    $client->calls()->create([
        'to' => [[
            'type' => 'phone',
            'number' => $number
        ]],
        'from' => [
            'type' => 'phone',
            'number' => '14155550100'
        ],
        'answer_url' => ['https://example.com/answer.php'],
        'event_url' => ['https://example.com/event.php'],
        'machine_detection' => 'continue'
    ]);

    // Sleep for half a second
    usleep(500000);
}
```

Once you've made this change, run `php broadcast.php` again and watch as each number you've listed is called simultaneously!

# Conclusion

You now have a simple, but working, voice-alert system where you can broadcast out a text-to-speech or pre-recorded message, log which calls are answered versus sent to voicemail, and receive confirmation of receipt from users who receive the message.

# References

- [JWT](/concepts/guides/authentication#json-web-tokens-jwt)
- [Making an Outbound Call](/voice/voice-api/guides/outbound-calls)
- [Creating Your Voice Application](/concepts/guides/applications#apps_quickstart)
- [NCCO Reference](/voice/voice-api/ncco-reference)