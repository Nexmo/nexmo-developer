# Nexmo Quickstart Examples for Python

Quickstarts also available for: [Java](https://github.com/nexmo-community/nexmo-java-quickstart), [.NET](https://github.com/nexmo-community/nexmo-dotnet-quickstart), [Node.js](https://github.com/nexmo-community/nexmo-node-quickstart), [PHP](https://github.com/nexmo-community/nexmo-php-quickstart),  [Ruby](https://github.com/nexmo-community/nexmo-ruby-quickstart)

The purpose of the quickstart guide is to provide simple examples focused
on one goal. For example, sending and SMS, handling and incoming SMS webhook,
making a Text to Speech call.

## Setup

To use this sample you will first need a [Nexmo account][sign-up]. Then rename
the `.env-example` file to `.env` and set the values as required.

For some of the examples you will need to [buy a number][buy-number].

## Running the Examples

All the examples run from a [Flask](http://flask.pocoo.org/) server.

Install any dependencies:


```sh
pip install -r requirements.txt
```

Run the server:

```sh
python server.py
```

Navigate to the appropriate route defined in `server.py` to execute the example.

## Request an Example

Please [raise and issue](https://github.com/nexmo-community/nexmo-python-quickstart/issues) to request an example that isn't present within the quickstart. Pull requests will be gratefully received.

## License

[MIT](LICENSE)

[sign-up]: https://dashboard.nexmo.com/sign-up
[buy-number]: https://dashboard.nexmo.com/buy-numbers
