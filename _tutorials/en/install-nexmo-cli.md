---
title: Install the Nexmo CLI
description: Install the Nexmo CLI to get easy command line functionality
---

The [Nexmo CLI](https://developer.nexmo.com/application/nexmo-cli) allows you to carry out many operations on the command line. Examples include creating applications, purchasing numbers, and linking a number to an application.

To install the nexmo CLI with NPM you can use:

``` shell
npm install nexmo-cli -g
```

Set up the Nexmo CLI to use your Vonage API Key and API Secret. You can get these from the [settings page](https://dashboard.nexmo.com/settings) in the Vonage Dashboard.

Execute the following command in a terminal, replacing `API_KEY` and `API_SECRET` with your own:

```bash
nexmo setup API_KEY API_SECRET
```