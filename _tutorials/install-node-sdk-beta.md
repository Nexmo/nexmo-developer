---
title: Install the Node Beta Server SDK
description: Install the Nexmo Node Beta Server SDK to get the latest functionality.
---

If you are planning to use JavaScript to develop your application, you'll need to install (or update) the Beta version of the Nexmo Node SDK.

### Installation

During Beta, the Node Server SDK can be installed using:

``` bash
$ npm install --save nexmo@beta
```

If you already have the Server SDK installed the above command will upgrade your Server SDK to the latest version.

### Usage

If you decide to use the Server SDK you will need the following information:

Key | Description
-- | --
`NEXMO_API_KEY` | The Nexmo API key which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | The Nexmo API secret which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_APPLICATION_ID` | The Nexmo Application ID for your Nexmo Application which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` | The path to the `private.key` file that was generated when you created your Nexmo Application.

These variables can then be replaced with actual values in the Server SDK example code.
