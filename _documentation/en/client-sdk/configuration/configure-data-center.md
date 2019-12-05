---
title: Configure your data center
description: This topic shows you how to configure the appropriate data centre to minimize network delays in your application.
navigation_weight: 1
---

# Configure your data center

You may need to configure the Client SDK to connect to your nearest data center. You can use this guide to help determine your best configuration.

> **NOTE:** This is an advanced optional step. You only need to do this if you determine your network performance needs to be enhanced. For most users this configuration is not required. This step can be done after [adding the SDK to your application](/client-sdk/setup/add-sdk-to-your-app).

## Why configure your data centers?

You only need to do this if you believe your application performance could be improved by connecting to a more local data center.

## Data centers available

Here are the available data centers:

Data Center | Location
---|---
`WDC` | Washington DC
`DAL` | Dallas
`LON` | London
`SNG` | Singapore

## URLs

It is possible to configure the following three URLs:

1. `nexmo_api_url`: the Nexmo Conversation API URL.
2. `url`: the Nexmo websocket URL.
3. `ips_url`: the Nexmo IPS URL for image upload.

### `nexmo_api_url`

This is the Nexmo Conversation API URL. This is the URL used when the Client SDK calls the API.

The default value is `https://api.nexmo.com`.

Data Center | URL
---|---
`WDC` | `https://api-us-1.nexmo.com`
`DAL` | `https://api-us-2.nexmo.com`
`LON` | `https://api-eu-1.nexmo.com`
`SNG` | `https://api-sg-1.nexmo.com`

### `url`

This is the Nexmo websocket URL. The URL that receives realtime events.

The default value is `wss://ws.nexmo.com`.

Data Center | URL
---|---
`WDC` | `wss://ws-us-1.nexmo.com`
`DAL` | `wss://ws-us-2.nexmo.com`
`LON` | `wss://ws-eu-1.nexmo.com`
`SNG` | `wss://ws-sg-1.nexmo.com`

### `ips_url`

This is the Nexmo IPS URL for image upload. This is the internal service used to store images being sent via in-app messages.

The default value is `https://api.nexmo.com/v1/image`.

Data Center | URL
---|---
`WDC` | `https://api-us-1.nexmo.com/v1/image`
`DAL` | `https://api-us-2.nexmo.com/v1/image`
`LON` | `https://api-eu-1.nexmo.com/v1/image`
`SNG` | `https://api-sg-1.nexmo.com/v1/image`

## Configuration

You can specify your preferred URLs when you create the Client SDK `NexmoClient` object:

```tabbed_content
source: '/_examples/client-sdk/dc-config'
```

## See also

* [Add the SDK to your application](/client-sdk/setup/add-sdk-to-your-app)
