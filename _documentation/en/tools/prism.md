---
title: Prism
---

# Prism

Working with APIs is great but sometimes you don't need to work with the real API to get development work done. One tool that you may find useful to include in your development workflow is [Prism](https://stoplight.io/open-source/prism/) from [Stoplight](https://stoplight.io/). Prism is a mock server, it imitates our live APIs in a simple tool that you can run locally and test your API calls and whole applications against.

Prism understands the [OpenAPI](/concepts/guides/openapi) specs we publish for each of our APIs, so you can use this approach to work with any of Nexmo's APIs.

## Install Prism

Prism is a node.js tool, so you will need to have node.js installed locally. Full [documentation and installation instructions](https://github.com/stoplightio/prism#installation) are of course available but the simple version is an `npm install` command:

```
npm install -g @stoplight/prism-cli
```

Check the command is installed and working by running `prism --version` from a terminal.

## Get the OpenAPI Spec

The easiest way to find the OpenAPI specification for any of our APIs is to choose it from the [list of API references](https://developer.nexmo.com/api) and then select "Download OpenAPI 3 Specification" from the API reference for the API you're interested in.

> We do also publish all our APIs on GitHub, look under `definitions/`: <https://github.com/nexmo/api-specification>

Once you have the `.yml` file you want, you are ready to start Prism.

## Start a Mock Server with Prism

From the terminal, start prism with a command like this:

```
prism mock [api-spec.yml]
```

For example for Number Insights API, my command and its output look like this:

```
$ prism mock number-insight.yml
[12:13:06] › [CLI] …  awaiting  Starting Prism…
[12:13:06] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/basic/json?number=1%295-2%209%2B2&country=UV
[12:13:06] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/standard/xml?number=67-64%298427&country=OU&cnam=false
[12:13:06] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/advanced/async/json?callback=sunt%20deserunt%20dolore%20id&number=%2B1208&country=CM&cnam=false&ip=accusamus
[12:13:06] › [CLI] ℹ  info      GET        http://127.0.0.1:4010/advanced/xml?number=-47&country=MU&cnam=false&ip=non
[12:13:06] › [CLI] ▶  start     Prism is listening on http://127.0.0.1:4010
```

The final line of the output shows you where Prism is running; for me that's locally on port 4010.

## Make API Requests to Prism

With the URL shown in Prism's startup output as the base URL, use your favorite HTTP client to try the example API. The example above used the Number Insights API, so you could make a curl request like this:

```
curl "http://localhost:4010/basic/json?api_key=abcd1234&api_secret=VerySecret1&number=44777000777"
```

The response from Prism has the same fields as the live API and some example values, making it an ideal replacement for the "real thing" when testing.

For an even easier way to work with Prism and make API requests, try importing the same OpenAPI spec you gave to Prism into Postman and use the ready-made collection of requests. By changing the `{{baseUrl}}` variable, you can quickly use Postman and Prism to explore the shape of any Nexmo API without charges.

## Use Prism with Your Application

Our SDKs all offer support for changing the Base URL that API requests are directed to (detailed in the `README` of each of the libraries) to enable you to use other endpoints for testing.

## Prism Advanced Usage

Once you've settled in with Prism, here are some tips for taking things to the next level.

### Request a Specific Response

Our APIs can return error responses in some situations, and it can be difficult (or just annoying) to recreate those error situations on the live platform. Using Prism gives an opportunity to test applications against all the possible responses.

Some of our API specs have error responses described in detail, and you can use the name of the response to ask Prism to return it.

For example, in the Verify API, you will find this in the example responses in the API spec:

```
              examples:
                success:
                  summary: Request was started
                  value:
                    request_id: abcdef0123456789abcdef0123456789
                    status: "0"

                throttled:
                  summary: Request limit exceeded
                  value:
                    status: "1"
                    error_text: Throttled

                account-disabled:
                  summary: Account is barred
                  value:
                    status: "8"
                    error_text: The api_key you supplied is for an account that has been barred from submitting messages.

                rejected:
                  summary: Rejected
                  value:
                    status: "15"
                    error_text: The destination number is not in a supported network

```

By default, Prism returns the first response which is great, that's a good example of what the API will usually return.

However to check your code handles some of these other possible responses would not be ideal. This is where Prism can help a lot! By appending a `__example` parameter to your request, you can select which of the examples Prism should return. For example to take a curl request to Verify API but get it to return the "throttled" response, it would look like this:

```
curl "http://localhost:4010/json?api_key=abcd1234&api_secret=VerySecret1&number=44777000777&brand=Test&__example=throttled"
```

By using Prism in this way you can check your application's behavior with all the responses the API can return.

### Better JSON Handling with JQ

If you're working with JSON on the command line as in the curl examples shown here, try the tool [`jq`](https://stedolan.github.io/jq/) to level up how you work with JSON. It's a great formatter in its own right, and can extract particular fields from the response or handle the data in other ways too.

In its simplest form, use it to get a nicer output from the curl example we used when first testing out Prism:

```
curl "http://localhost:4010/basic/json?api_key=abcd1234&api_secret=VerySecret1&number=44777000777" | jq "."
```



