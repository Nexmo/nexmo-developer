# Sending an SMS with Slim and Nexmo

Here is a very simple example to show how you can send an SMS from Slim, using Nexmo's API.  If you're new to Nexmo, try our [getting started guide](https://developer.nexmo.com/messaging/sms/overview#getting-started) for SMS before diving into this lightweight example.

## Usage

* If you haven't already, at the top level of this repository: Copy `.env-example` to `.env` and add your own values.
* Install the dependencies with `composer install`.
* Start the PHP webserver from the current directory (where this README is) with this command: `php -S localhost:8080`.
* Send a `POST` request to `http://localhost:8080/sms/[PHONE_NUMBER]` with a body parameter `text` containing the message to send

Here's an example curl command:

```
curl http://localhost:8080/sms/ 442079460000 -d text="Have a nice day"
```
