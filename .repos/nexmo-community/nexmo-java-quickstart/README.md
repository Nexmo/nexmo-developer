# Nexmo Quickstart Examples for Java

Quickstarts also available for: [.NET](https://github.com/nexmo-community/nexmo-dotnet-quickstart), [Node.js](https://github.com/nexmo-community/nexmo-node-quickstart), [PHP](https://github.com/nexmo-community/nexmo-php-quickstart), [Python](https://github.com/nexmo-community/nexmo-python-quickstart), [Ruby](https://github.com/nexmo-community/nexmo-ruby-quickstart)
  
The purpose of the quickstart guide is to provide simple examples focused on
one goal. For example, sending and SMS, handling an incoming SMS webhook,
making a Text to Speech call.

## Setup

To use this sample you will first need a [Nexmo account][sign-up].

For some of the examples you will need to [buy a number][buy-number].

## Building The Library

You will need to have [Gradle](gradle) installed to build the code. Once
you have gradle installed, run the following to build a jar that contains
the quickstart code along with all the nexmo client library dependencies:

```sh
gradle assemble
```

This will build the following file: `build/libs/nexmo-java-quickstart-with-dependencies.jar`

## Running The Examples

Copy `.env-example` to `.env` and edit the values. You'll need to load those
values into environment variables, so you'll probably want to use a tool like
[Foreman](foreman) to run your code like this:

```sh
foreman run java -cp build/libs/nexmo-java-quickstart-with-dependencies.jar CLASS
```

So to run the OutboundTextToSpeechExample class, you would run the following:

```sh
foreman run java -cp build/libs/nexmo-java-quickstart-with-dependencies.jar com.nexmo.quickstart.voice.OutboundTextToSpeech
```

If you set the environment variable `QUICKSTART_DEBUG` to any value, extra information
will be output to the console from the Nexmo Client library.

## Request an Example

Please [raise an issue](https://github.com/nexmo-community/nexmo-java-quickstart/issues) to request an example that isn't present within the quickstart. Pull requests will be gratefully received.

## License

This code is licensed under the [MIT](LICENSE.txt) license.

[gradle]: https://gradle.org/
[foreman]: https://github.com/ddollar/foreman
[sign-up]: https://dashboard.nexmo.com/sign-up
[buy-number]: https://dashboard.nexmo.com/buy-numbers
