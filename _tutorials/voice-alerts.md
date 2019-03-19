---
title: Broadcast Voice-based Critical Alerts
products: voice/voice-api
description: In this tutorial, you will learn how to contact a list of people by phone, convey a message, and see who confirmed that they had received the message. These voice-based critical alerts are more persistent than a text message, making your message more likely to be noticed. Additionally, with the recipient confirmation, you can be sure that your message made it through.
languages:
    - PHP
---

# Broadcast Voice-based Critical Alerts

A persistently ringing phone is harder to miss than a text message or push alert, so when you need to ensure that [critical  alerts](https://www.nexmo.com/use-cases/voice-based-critical-alerts) make it through to the right person a phone call is one of the best options available.

In this tutorial, you will learn how to contact a list of people by phone, convey a message, and see who confirmed that they had received the message. These voice-based critical alerts are more persistent than a text message, making your message more likely to be noticed. Additionally, with the recipient confirmation, you can be sure that your message made it through.

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* [Composer](http://getcomposer.org/) to install the [Nexmo PHP library](https://github.com/nexmo/nexmo-php)
* A publicly accessible web server so Nexmo can make webhook requests to your app, or [ngrok](https://ngrok.com/) to be able to access your local development platform from the outside world.
* The tutorial code from <https://github.com/Nexmo/php-voice-alerts-tutorial> - either clone the project or download the zip file.

⚓ Create a Voice Application
⚓ Provision a Virtual Number
## Getting Started

We'll start by registering a Nexmo number to use with this application. Follow the instructions for [getting started with applications](https://developer.nexmo.com/concepts/guides/applications#getting-started-with-applications). This will walk you through buying a number, creating an application, and linking the two.

You will need to give the URL of your publicly-accessible webserver or ngrok endpoint when you configure your application, as part of both the `answer_url` and the `event_url`. Those files are called `answer.php` and `event.php` respectively in this project. For example if your ngrok URL is `https://25b8c071.ngrok.io` then your configuration would be:

* **answer_url** `https://25b8c071.ngrok.io/answer.php`
* **event_url** `https://25b8c071.ngrok.io/event.php`

When you create an application, you will get a key to use for authentication. Save this into a file called `private.key` and keep it safe! You will need it later on to make outgoing phone calls.

Once the application is created, configured and linked to a phone number, take a look at the code and then go ahead and try it out.

⚓ Creating a Nexmo Call Control Object
⚓ Creating a call
## Teach Your Application to "Speak"

When a human is connected to your application by phone, you control what the human hears with Nexmo Call Control Objects (NCCOs). These can be used for both incoming and outgoing calls - once the call is in progress, it doesn't make much different which it was.

When a call is made to the number we linked to it earlier. Nexmo will make a request to the `answer_url` that you configured in the application and will expect the response to be an array of NCCOs.

Take a look at `answer.php` in the repository. This is the code that will return the NCCOs: in this case some text-to-speech messages and also a prompt for user input.

```php
$ncco = [
    [
        "action" => "talk",
        "voiceName" => "Jennifer",
        "text" => "Hello, here is your message. I hope you have a nice day."
    ],
    [
        "action" => "talk",
        "voiceName" => "Jennifer",
        "text" => "To confirm receipt of this message, please press 1 followed by the pound sign"
    ],
    [
        "action" => "input",
        "submitOnHash" => "true",
        "timeout" => 10
    ],
    [
        "action" => "talk",
        "voiceName" => "Jennifer",
        "text" => "Thank you, you may now hang up."
    ]
];

// Nexmo expect you to return JSON with the correct headers
header('Content-Type: application/json');
echo json_encode($ncco);
```

This shows off a few different types of NCCO in action, and hopefully gives you an idea of the types of things you can do with an NCCO (a detailed [NCCO reference](https://developer.nexmo.com/voice/voice-api/ncco-reference) is available if you're curious!). These are all JSON objects and your code builds the output and then sends it as the response, with correct JSON headers.

This would be an excellent time to dial your Nexmo number from another phone and see the above in action! Go ahead and feel free to edit things and see what else you can do.

## Track Events During a Call

It's helpful to be able to include information about the status of the phone call when you let your application talk on the phone unsupervised. To help with this Nexmo send webhooks to the `event_url` that you configured when you set up the application. These webhooks contain status updates to let you know the phone is ringing, has been answered, and so on.

The code for this is in `event.php` in our project: it checks for particular statuses and writes information about them to a log file.

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

You can look at what happened when you called your application earlier by inspecting the contents of `call_log.txt`. This file holds a record of each status that a particular phone call or "conversation" went through. Each line includes the conversation identifier; this becomes very important in a moment when we start making many outgoing calls at one time to pass on our broadcast message. We will still want to know which event belongs to which conversation!

You can try a few different things when you call your number, and watch the log file as you do. How about:

* Enter a number that isn't `1` when prompted
* Don't answer the call but instead send it to voicemail

Your application is ready to handle the calls once we make them so it's time to build the broadcasting part of the project.

⚓ Broadcasting to multiple people
## Make Outgoing Calls

We need to [broadcast our message](https://www.nexmo.com/use-cases/voice-broadcast) out to multiple people to avoid a critical message only going to one person and being missed. The script therefore loops through all the contacts you set up in `config.php` and requests that each one gets a call.

To make phone calls you will need to configure your PHP application with information about your Nexmo credentials, the application itself and the people you want to call.

Copy `config.php.example` to `config.php` and edit to add your own values for:

* API key and secret, which you can find from [your dashboard](https://dashboard.nexmo.com)
* The ID of the application you created at the beginning of this tutorial
* The Nexmo number that your users will be called from
* The public URL of your application
* An array of names and numbers of the people who should receive the broadcast message

> Also check that you have the key generated when you created the application saved in `private.key` in the top level of the project.

You will also need to run `composer install` to bring in the project dependencies. This includes the [Nexmo PHP library](https://github.com/nexmo/nexmo-php) which offers some helper code to make working with the Nexmo APIs easier.

Back in the repo, the code we need for this step is in `broadcast.php`:

```php
require 'vendor/autoload.php';
require 'config.php';

$basic  = new \Nexmo\Client\Credentials\Basic($config['api_key'], $config['api_secret']);
$keypair = new \Nexmo\Client\Credentials\Keypair(
    file_get_contents(__DIR__ . '/private.key'),
    $config['application_id']
);

$client = new \Nexmo\Client(new \Nexmo\Client\Credentials\Container($basic, $keypair));

$contacts = $config['contacts'];

foreach ($contacts as $name => $number) {
    $client->calls()->create([
        'to' => [[
            'type' => 'phone',
            'number' => $number
        ]],
        'from' => [
            'type' => 'phone',
            'number' => $config['from_number']
        ],
        'answer_url' => [$config['base_url'] . '/answer.php'],
        'event_url' => [$config['base_url'] . '/event.php'],
        'machine_detection' => 'continue'
    ]);

    // Sleep for half a second
    usleep(500000);
}
```

The code in `broadcast.php` uses your configured API key and secret, the application ID and the `private.key` file you saved earlier to create a `Nexmo\Client` object. This gives a simple interface to make a call and pass the [call options](https://developer.nexmo.com/api/voice#createCall) required.

You'll probably notice that there is an instruction for a short pause with the `usleep()` method. This is to avoid hitting the [API rate limit](https://help.nexmo.com/hc/en-us/articles/207100288-What-is-the-maximum-number-of-calls-per-second-).

Test your application out now by running `php broadcast.php` and seeing all the phone numbers you supplied ring at once. You can modify the message that is spoken by modifying the NCCOs that are returned to the user. You can also specify different voices and languages (see the full list of options in the [NCCO Reference section](https://docs.nexmo.com/voice/voice-api/ncco-reference#talk).

> You can add GET parameters to the `answer_url` if you have extra parameters that you want to pass along to that context. For example, you could add the person's name and then access that when the request arrives in `answer.php`.

There are a few other things you might choose to do with your application such as using a recording rather than the text-to-speech functionality, or recording responses from users. The next few sections show how to approach those activities.

### Using a Recording Instead of Text-To-Speech

To use a pre-recorded message instead of (or as well as!) using Nexmo's text-to-speech functionality, use an NCCO with action `stream`. `stream` allows you to play back an audio file to the caller. The "streamUrl" will point to your audio file.

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

For more information, checkout the [NCCO reference docs for stream](https://developer.nexmo.com/voice/voice-api/ncco-reference#stream).

### Handling Answering Machines and Voicemail

If you want to keep track of which numbers went to voicemail instead of being answered, you can add the `machine_detection` parameter when making the outgoing call, as you saw in `broadcast.php`. There are two options you can set for this, `continue` or `hangup`. If you want to log that the call went to voicemail, choose `continue`, and an HTTP request will be sent to your event webhook (the URL specified in `event_url`).

```php
'answer_url' => ['https://example.com/answer.php'],
'event_url' =>  ['https://example.com/event.php'],
'machine_detection' => 'continue'
```

In `event.php` the script looks for the status "machine" and logs the event accordingly. 

### Confirming Receipt of the Message

You'll have noticed that when the message is delivered, as a user you are then asked to press some keys to confirm that you have received the message. This is achieved by a `talk` action that gives instructions to the user, followed by an `input` action to capture the button presses.

```php
[
  "action" => "input",
  "submitOnHash" => "true",
  "timeout" => 10
],
```

By setting `submitOnHash` to true, the call will move to the next NCCO when the hash or pound sign (`#`) is entered. Otherwise, the call waits for the specified `timeout` number of seconds (the default is 3) before moving on automatically.

In your event script, you'll see some code to handle the input action. The data from the input action arrives under the `dtmf` key, with the number that was pressed as the value.

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

In this example we just log what happened, but in your own applications you could store or respond to the user input to suit your own needs.

⚓ Conclusion
## Your Broadcast Call Application

You now have a simple, but working, voice-alert system where you can broadcast out a text-to-speech or pre-recorded message, log which calls are answered versus sent to voicemail, and receive confirmation of receipt from users who receive the message.

⚓ References
## Next Steps and Further Reading

* [Using Ngrok for local development](https://developer.nexmo.com/concepts/guides/webhooks#using-ngrok-for-local-development) section from our Webhooks documentation
* [Making an Outbound Call](/voice/voice-api/guides/outbound-calls) - code snippets for making calls in different programming languages
* [Handling user input with DTMF](/voice/voice-api/code-snippets/handle-user-input-with-dtmf) - examples using code of various technology stacks to capture the user's button presses.
* [NCCO Reference](/voice/voice-api/ncco-reference) - the reference documentation for call control objects
* [Voice API Reference](/api/voice) - API reference documentation


