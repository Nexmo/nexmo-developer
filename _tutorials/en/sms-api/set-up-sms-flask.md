---
title: Set up an SMS Sending Flask App
description: Create a web application that allows you to send an SMS message.
---

# Build an SMS Sending Flask App

> The rest of this tutorial will show you how to build a small Flask app with a form for a phone number and an SMS message. When you press "Send SMS" it will post to a second view that will send the SMS using the Vonage SMS API.

First, install dependencies. Check out this [sample code](https://github.com/Nexmo/nexmo-python-code-snippets/blob/master/sms/send-an-sms.py) and run `pip install -r requirements.txt`. At the very least, you’ll need to install Flask into your `virtualenv`.

Create a `Client` object and an empty Flask app. If you would like to create a [12 factor](https://12factor.net/) app, load in configuration from environment variables (check out the helper function in `utils.py` in the sample code).

The problem with loading in environment variables is that it can make running the app a little bit more difficult. Use the [`python-dotenv`](https://github.com/theskumar/python-dotenv) library to load a `.env` file. It copies the values into the `env` var dictionary, so you can get the values using `getenv` as you would normally.

```
from dotenv import load_dotenv
from flask import Flask, flash, redirect, render_template, request, url_for
import nexmo
 
from .util import env_var, extract_error
 
# Load environment variables from a .env file:
load_dotenv('.env')
 
# Load in configuration from environment variables:
VONAGE_API_KEY = env_var('VONAGE_API_KEY')
VONAGE_API_SECRET = env_var('VONAGE_API_SECRET')
VONAGE_NUMBER = env_var('VONAGE_NUMBER')
 
# Create a new Client object:
nexmo_client = nexmo.Client(
    api_key=VONAGE_API_KEY, api_secret=VONAGE_API_SECRET
)
 
# Initialize Flask:
app = Flask(__name__)
app.config['SECRET_KEY'] = env_var('FLASK_SECRET_KEY')
```