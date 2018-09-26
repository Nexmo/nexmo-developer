---
title: Client library
navigation_weight: 1
---

# Nexmo client library support

In addition to using the Messages and Workflows API via HTTP, the Nexmo Node client library also provides support.

During the Developer Preview the Node client library with support for the Messages and Workflows API can be installed using:

```
$ npm install nexmo@beta
```

If you decide to use the client library you will need the following information:

Key | Description
-- | --
`NEXMO_API_KEY` | The Nexmo API key which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_API_SECRET` | The Nexmo API secret which you can obtain from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_APPLICATION_ID` | The Nexmo Application ID for your Nexmo Application which can be obtained from your [Nexmo Dashboard](https://dashboard.nexmo.com).
`NEXMO_APPLICATION_PRIVATE_KEY_PATH` | The path to the `private.key` file that was generated when you created your Nexmo Application.

These variables can then be replaced with actual values in the client library example code.
