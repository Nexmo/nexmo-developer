---
title: Postman
---

# Postman

Our APIs can be used with any HTTP client; choose your favorite! We love [Postman](https://postman.com), it's a friendly graphical interface to a powerful cross-platform HTTP client. Best of all it has support for the OpenAPI specs that we publish with all our APIs.

> If you're new to OpenAPI, we have a [Guide to OpenAPI](/concepts/guides/openapi) just for you!

Install Postman and follow the steps laid out below to very quickly try out any of the Nexmo APIs. We publish an OpenAPI specification for each API and Postman can read these and create a collection of requests that you can simply enter values into.

## Get the OpenAPI Spec of the API

The easiest way to find the OpenAPI spec is to click the "Download OpenAPI 3 Specification" button on the API reference for the API you'd like to try. For example visit the [Verify API reference page](https://developer.nexmo.com/api/verify) and click the download button. The files are in `.yml` format.

> We also publish all our specs on GitHub, if you'd like to see the whole collection, they're in the `definitions/` folder: <https://github.com/nexmo/api-specification>

## Import Spec into Postman

Start Postman and look for the "Import" button above the left hand bar. Browse to find the `.yml` file you want to use, and choose "Open", and then "Next".

In the left hand side bar, you will now have a folder/collection for your API, and inside it a template request for each of the endpoints in the API.

## Make an API Call

For example if you imported the Verify API spec, you'd be able to choose "Verify Request" from the left hand bar, and get a ready-made request to use. Go ahead and add the fields you need:

* Your API credentials! For Verify API that's the `api_key` and `api_secret` fields and you can find these details in your account dashboard
* The phone number to Verify (remember to use E.164 format)
* The name of the brand doing the verifying (you can choose anything here as you are just testing things)
* Set the `format` value in the path parameters section to `json`

Now press "Send" and check the response from the API.

## Postman Advanced Usage

We're big fans of Postman so we thought we'd share our best tips with you here.

### Use Environments

Postman has an [environments feature](https://learning.postman.com/docs/postman/variables-and-environments/variables/) that is really useful when you're using the same variables (such as your API credentials) in many different requests.

To create an environment, click the settings cog in the top right hand side of the screen and choose "Add". Give your environment a name, and add any variables you want to use, such as:

* `api_key`
* `api_secret`
* `phone_number`

Save the values and then in your request, instead of pasting in your API key, you can type `{{api_key}}` and Postman will use the value from the current environment.

You can have multiple environments, which is useful if you use different keys for different things, or if you are sending API requests to a debugging tool or API mocking server such as Prism. Add as many environments as you need by repeating the steps above and choosing the environment to use from the dropdown in the top right hand section of the screen.


