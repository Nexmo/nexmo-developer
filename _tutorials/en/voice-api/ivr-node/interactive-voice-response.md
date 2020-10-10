

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

A Nexmo Call Control Object (NCCO) is a JSON array that is used to control the flow of a Voice API call. Nexmo expects your answer webhook to return an NCCO to control the various stages of the call.

To manage NCCOs this example application uses array manipulation and a few simple methods.

The router handles encoding to JSON, the `Menu` object provides access to the NCCO stack with its `getStack()` method:

```php
<?php

// src/Menu.php

public function getStack()
{
    return $this->ncco;
}
```

There are also some helper methods to provide the foundation for managing the NCCO stack. You may find these useful in your own applications:

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

After the user has provided input, Nexmo sends a webhook to the `eventUrl` defined in the `input`. Since we set the `eventUrl` to `/search`, our code routes the request to `searchAction`. The request includes a `dtmf` field which contains the numbers input by the user. We use this input data and randomly generate example data to return to the user, your applications will probably do something much more useful such as fetch information from a database. Here's the action:

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


## Tips for better Text-To-Speech experiences

The `Menu` class has a few more methods that are there to improve the process of turning application data into spoken prompts. Examples in this application include:

* the date when the status was last reported
* the order number
* the order status

We have methods to assist us in communicating these values clearly to the user. First: the `talkDate` method just returns a string with a date format that works well for spoken words.

```php
<?php

// src/Menu.php

protected function talkDate(\DateTime $date)
{
    return $date->format('l F jS');
}
```

The `talkCharacters` method puts a space between each character in a string, so they are read individually. We use this when reporting the order number:


```php
<?php

// src/Menu.php

protected function talkCharacters($string)
{
    return implode(' ', str_split($string));
}
```

The `talkStatus` method converts a very terse constant into a more conversational phrase using a simple lookup:

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

## Next Steps

Here are a few more resources that could be useful for building this type of application:

* [Text-To-Speech Guide](https://developer.nexmo.com/voice/voice-api/guides/customizing-tts) - includes the different voices on offer and information about SSML (Speech Synthesis Markup Language) for better control of the spoken output.
* [Twitter IVR](https://www.nexmo.com/blog/2018/06/26/twitter-interactive-voice-response-dr/) - another fairly silly example but a great example app written in Python.
* [Text To Speech With Prompt Calls Using Python on AWS Lambda](https://www.nexmo.com/blog/2018/02/16/text-speech-prompt-calls-using-python-aws-lambda-dr/) - a similar application but this time using AWS Lambda (a serverless platform) and Python.
* [Code Samples for handling DTMF](https://developer.nexmo.com/voice/voice-api/code-snippets/handle-user-input-with-dtmf) - examples in various programming languages for handling the user keypad input as used in this tutorial.
