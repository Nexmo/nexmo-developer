---
title: Install the Nexmo CLI Beta
description: Install the Nexmo CLI Beta to get the latest functionality
---

The Nexmo CLI allows you to carry out many operations on the command line. Examples include creating applications, purchasing numbers, and linking a number to an application.

To install the Beta version of the CLI with NPM you can use:

``` shell
npm install nexmo-cli@beta -g
```

Set up the Nexmo CLI to use your Nexmo API Key and API Secret. You can get these from the [settings page](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard.

Run the following command in a terminal, while replacing `api_key` and `api_secret` with your own:

```bash
nexmo setup api_key api_secret
```