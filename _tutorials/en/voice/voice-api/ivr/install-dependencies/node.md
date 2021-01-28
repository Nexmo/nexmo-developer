---
title: Install the dependencies
description: Install the required dependencies
---

# Install the dependencies

In this tutorial, you will use the [express](https://expressjs.com/) web application framework to create the server and define the routes for your webhook endpoints.

You will access the JSON bodies of the requests that the Vonage API platform makes to your webhooks, so you'll need the `body-parser` package too.

Create a directory called `phone-ivr` for your application and change into it:

```
mkdir phone-ivr
cd phone-ivr
```

Run `npm init` to create a node application in the `phone-ivr` directory and accept all the defaults.

Then, install `express` and `body-parser`:

```
npm install express body-parser
```