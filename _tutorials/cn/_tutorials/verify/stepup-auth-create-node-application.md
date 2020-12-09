---
title:  Create the Node.js application
description:  In this step you create the basic Node.js application

---

Create the Node.js application
==============================

Enter the following commands at a terminal prompt:

```sh
mkdir stepup-auth
cd stepup-auth
touch server.js
```

Run `npm init` to create the Node.js application, accepting all the defaults.

The application you will create uses the [Express](https://expressjs.com/) framework for routing and the [Pug](https://www.npmjs.com/package/pug) templating system for building the UI.

In addition to `express` and `pug`, you will be using the following external modules:

* `express-session` - to manage the login state of the user
* `body-parser` - to parse `POST` requests
* `dotenv` - to store your Vonage API key and secret and the name of your application in a `.env` file
* `nexmo` - the [Node Server SDK](https://github.com/nexmo/nexmo-node)

Install these dependencies by running the following `npm` command at a terminal prompt:

```sh
npm install express express-session pug body-parser dotenv nexmo
```

> **Note** : This tutorial assumes that you have [Node.js](https://nodejs.org/) installed and are running in a Unix-like environment. The terminal commands for Windows environments might be different.

