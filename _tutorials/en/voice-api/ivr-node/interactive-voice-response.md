





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
