---
title: Receive product information interactively via Facebook Messenger
products: messages
description: This tutorial looks at a use case where the user receives relevant product information interactively via Facebook Messenger, without the need for support personnel.
languages:
    - Python
---

# Receive product information interactively via Facebook Messenger

This tutorial shows you how to provide a user with relevant product information via Facebook Messenger.

In this use case the user greets the company via the company's Facebook Page. A message is automatically sent back to the user. Using a simple command the user can obtained tailored information based on their product choice.

> **NOTE:** This tutorial assumes you have already created a Facebook Profile and a Facebook Page.

## Source code

The source code for this project is available in the Nexmo Community [GitHub repository](https://github.com/nexmo-community/fbm-product-info).

```partial
source: _partials/reusable/prereqs.md
```

## The steps

After the prerequisites have been met, the steps are as follows:

1. Create a Nexmo Application
2. Generate a JWT
3. Link your Facebook Page to Nexmo
. [](#)

There are various ways you can achieve the same result with Nexmo. This tutorial shows only one specific way to do things, for example we use the command line to create the application, rather than the Dashboard. Other tutorials demonstrate other ways of doing things.

## Create your Nexmo Application

If you have not yet done so, create a new directory for your project, such as `fbm-app`. Change into this directory.

Use the CLI to create your Nexmo application:

``` shell
nexmo app:create "FBM Product Info" https://abcd1234.ngrok.io/inbound https://abcd1234.ngrok.io/status --keyfile=private.key --type=messages
```

Make a note of the generated Application ID. You can also check this in the Dashboard.

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

Add this code to a file called `app.py` and save it.

Run it locally with:

``` shell
python3 app.py
```

Your base application is now up and running and ready to log events.

## Interact with your Facebook Page

Now that your base app is up and running, you can send a message to your Facebook Page and then check that the message is logged. So, if you send a basic message to your Facebook Page using Messenger you will see logging such as the following:

```

```

There is some important information here which you can use to build out your application to make it more useful.


