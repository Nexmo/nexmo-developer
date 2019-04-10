---
title: Receive product information automatically via Facebook Messenger
products: messages
description: This tutorial looks at a use case where the user receives relevant product information automatically via Facebook Messenger, without the need for support personnel.
languages:
    - Python
---

# Receive product information automatically via Facebook Messenger

This tutorial shows you how to provide a user with relevant product information automatically via Facebook Messenger.

In this use case the user greets the company via the company's Facebook Page. A message is automatically sent back to the user. Using keyword matching the user can receive tailored product and service information.

> **NOTE:** This tutorial assumes you have already created a Facebook Profile and a Facebook Page.

## Source code

The source code for this project is available in the Nexmo Community [GitHub repository](https://github.com/nexmo-community/fbm-product-info).

## Prerequisites

1. [Create a Nexmo Account](https://dashboard.nexmo.com/sign-in)
2. [Install Node JS](https://nodejs.org/en/download/) - required for using the Nexmo Command Line Interface (CLI).
3. [Install the Beta version of the Nexmo CLI](/messages/code-snippets/install-cli)
4. [Know how to test your webhook server locally](/messages/code-snippets/configure-webhooks#testing-locally-via-ngrok)
5. [Python 3 installed](https://www.python.org/)
6. [Flask installed](http://flask.pocoo.org/)

## The steps

After the prerequisites have been met, the steps are as follows:

1. Create a Nexmo Application
2. Generate a JWT
3. Link your Facebook Page to Nexmo
4. Link your Nexmo application to your Facebook page
5. Build out your application to implement the use case

There are various ways you can achieve the same result with Nexmo. This tutorial shows only one specific way to do things, for example you will see how to use the command line to create the application, rather than the Dashboard. Other tutorials demonstrate other ways of doing things.

## Create your Nexmo Application

If you have not yet done so, create a new directory for your project, such as `fbm-app`. Change into this directory.

Use the CLI to create your Nexmo application:

``` shell
nexmo app:create "FBM App" https://abcd1234.ngrok.io/inbound https://abcd1234.ngrok.io/status --keyfile=private.key --type=messages
```

Make a note of the generated Application ID. You can also check this in the [Nexmo Dashboard](https://dashboard.nexmo.com/messages/applications).

This command will also have created a private key, `private.key` in your current directory.

This command has also set the two webhooks that need to be set. All interaction between your App and Nexmo takes place through these webhooks.

## Generate a JWT

You will need to generate a JWT to validate the linking of your Facebook Page to your Nexmo account. You can skip this step if you have already linked your Facebook Page to your Nexmo account.

In the following command make sure you paste in the Application ID of the Nexmo application you just created.

``` shell
JWT="$(nexmo jwt:generate ./private.key application_id=YOUR_APP_ID)"
```

Note the default expiry time for the JWT is 15 minutes.

Type the following command to echo your JWT:

``` shell
echo $JWT
```

Copy the JWT to the clipboard. You will use it in linking your Facebook Page to your Nexmo account.

## Link your Facebook Page to your Nexmo account

To link your Facebook Page to your Nexmo account navigate to the following page:

* [Link your Facebook Page to Nexmo](https://static.nexmo.com/messenger/)

Select the Facebook Page you want to link to your account from the dropdown list.

Paste the JWT you copied to your clipbnoard earlier into the JWT Token field and click Subscribe. You will receive a message confirming the page is now linked to your account.

## Link your application to your Facebook Page

Go into the Nexmo Dashboard and check your Nexmo application [is listed](https://dashboard.nexmo.com/messages/applications).

Click on your app and then click the External Accounts tab. Facebook Pages that you've linked to your Nexmo account are listed. Click the `Link` button to link your application to the desired Facebook Page.

> At this point you have the preparatory work completed. You now have a Nexmo app and your Facebook Page connected to your Nexmo account. In subsequent sections you will write the code for your application.

## Get Ngrok up and running

Make sure you have Ngrok running for testing locally. To start Ngrok type:

``` shell
ngrok http 9000
```

To generate a temporary Ngrok URL. If you are a paid subscriber you could type:

``` shell
ngrok http 9000 -subdomain=your_domain
```

> Note in this case Ngrok will divert hte Nexmo webhooks you specified when you created your Nexmo application to `localhost:9000`.

## Write your basic application

So in the simplest case your application would look like the following:

``` python
from flask import Flask, request, jsonify
from pprint import pprint

app = Flask(__name__)

@app.route('/inbound', methods=['POST'])
def inbound_message():
    data = request.get_json()
    pprint(data)
    return ("200")

@app.route('/status', methods=['POST'])
def message_status():
    data = request.get_json()
    pprint(data)
    return ("200")

if __name__ == '__main__':
    app.run(host="localhost", port=9000)
```

Add this code to a file called `app1.py` and save it.

Run it locally with:

``` shell
python3 app.py
```

Your base application is now up and running and ready to log events.

## Interact with your Facebook Page

Now that your base app is up and running, you can send a message to your Facebook Page and then check that the message is logged. So, if you send a basic message to your Facebook Page using Messenger you will see logging such as the following:

```
{'direction': 'inbound',
 'from': {'id': '1234567890123456', 'type': 'messenger'},
 'message': {'content': {'text': 'Hello Mr. Cat', 'type': 'text'}},
 'message_uuid': 'da13a7b0-307c-4029-bbcd-ec2a391873de',
 'timestamp': '2019-04-09T12:26:47.242Z',
 'to': {'id': '543210987654321', 'type': 'messenger'}}
127.0.0.1 - - [09/Apr/2019 13:26:58] "POST /inbound HTTP/1.1" 200 -
```

There is some important information here which you can use to build out your application to make it more useful.

Field | Description
--- | ---
`from` | The Facebook ID of the person sending a message to your page.
`to` | The Facebook ID of your page (the page the person is sending a message to).
`message` | The message being sent.

You can see that the message is a JSON object. You can extract the message text from this object.

Note that it is useful to record both the Facebook ID of your page (which you might not have known), and the Facebook ID of the user sending you a message. Note the Facebook ID is especially useful if your application is handling multiple Facebook Pages.

## Minimal client for sending Facebook Messenger messages using Python

Currently Nexmo does not officially support Messages and Dispatch API in the Python client library, but our REST API is fully supported and the [Python code is provided](https://github.com/nexmo-community/fbm-product-info/blob/master/FBMClient/FBMClient.py) in the project for you in a reusable class. As the code is provided we will not cover it further in this tutorial.

## The use case revisited

It's time to look into this use case in more detail so you can more effectively build out your application.

Imagine a user messages your Facebook Page via Messenger with a message such as "Hi". However due to time zones you are not available to respond to the message - this may leave the user feeling dejected. On the other hand it would be great if you could automatically respond with useful information. For example, to a message such as "Hi" you might respond with "Welcome to T's Cat Supplies. Here are our main product categories: toys, food, meds, bling."

Using a Python construct such as `if keyword in msg` you can detect keywords and send material based on that. For example if a user sends in a message like "Hi my tanks need sorting" you might detect the word `tank` and send information on your tank cleaning services. Or if you receive a message such as "Hi, I think I need a crane to lift our pipeline sections." You could send information on your crane hire services. Where keywords are not detected it is a simple matter to send a generic message back to the user to help orientate them.

This auto-response feature is useful as some companies have hundreds of products and services.

Another feature that is useful is the ability to switch auto-response off, perhaps to deal directly with a human. You could build in commands such as `auto: off` and `auto: on` to control how your customer interacts with your Facebook Page.

In the following sections you will see how to implement this use case.

## A simple messages dictionary

One of the useful data structures in implementing this use case is the Python dictionary. You can see an example here:

``` python
cats_dict = {
    'other': 'Our products: toys, food, meds, and bling',
    'toys': 'More info on cat toys here https://bit.ly/abc',
    'food': 'More info on cat food here https://bit.ly/def',
    'meds': 'More info on cat meds here https://bit.ly/ghi',
    'bling': 'More info on cat bling here https://bit.ly/jkl'
}
```

To put this into perspective review the following code:

``` python
class ProductMatcher:

    auto_mode = True

    cats_dict = {
        'other': 'Our products: toys, food, meds, and bling',
        'toys': 'More info on cat toys here https://bit.ly/abc',
        'food': 'More info on cat food here https://bit.ly/def',
        'meds': 'More info on cat meds here https://bit.ly/ghi',
        'bling': 'More info on cat bling here https://bit.ly/jkl'
    }

...

    def product_matcher(self, fb_sender, user, msg):
        product = 'other'
        msg = msg.lower().strip()
        if self.auto_mode:
            if "auto: off" in msg:
                self.auto_mode = False
                self.fbm.send_message(fb_sender, user, "Auto mode is off")
                return
            for k in self.cats_dict.keys():
                if k in msg:
                    product = k
                    break
            self.fbm.send_message(fb_sender, user, self.cats_dict[product])
        if "auto: on" in msg:
                self.auto_mode = True
                self.fbm.send_message(fb_sender, user, "Auto mode is on")
        return product
```

If the user sends a message via Messenger and there's no human to respond a simple menu is sent back to the user. In the user's message the product is extracted and the appropriate message sent. Of course this code takes a naive approach, but hopefully it indicates the potential.

You might be wondering would this get annoying for the user if they want to talk to a real person? However, the auto-respond could be disabled once you are online and able to take messages. The code allows the user to use the commands `auto: off` and `auto: on` to control interaction. This could also be controlled by the channel manager.

In the above code the product the user is interested in is also returned. This could be used if, for example, you wanted to log the user and thier product choice to a database. You could also look up a user in the database to find out if they are a new customer or they have had dealings with the company before.

## Summary

In this tutorial you have seen a use case where the user can receive product information automatically via Facebook Messenger. This was based around simple keyword matching. The user also had the ability to toggle auto-response mode as required.

## Further resources

* The complete [source code](https://github.com/nexmo-community/fbm-product-info).
* Messages API [documentation](/messages/overview)
