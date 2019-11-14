---
title: Configure your data center
description: This topic shows you how to configure the appropriate data centre to minimize network delays in your application.
navigation_weight: 4
---

# Configure your data center

You will  probably want to configure the Client SDK to connect to your nearest data center. You can use this guide to help determine your best configuration.

## URLs

You need to configure the following three URLs:

1) `nexmo_api_url`: the Nexmo Conversation API URL, the default value is `https://api.nexmo.com`.

Data Center | URL
---|---
`WDC` | `https://api-us-1.nexmo.com`
`DAL` | `https://api-us-2.nexmo.com`
`LON` | `https://api-eu-1.nexmo.com`
`SNG` | `https://api-sg-1.nexmo.com`

2) `url`: the Nexmo websocket URL, the default value is `wss://ws.nexmo.com`.

Data Center | URL
---|---
`WDC` | `wss://ws-us-1.nexmo.com`
`DAL` | `wss://ws-us-2.nexmo.com`
`LON` | `wss://ws-eu-1.nexmo.com`
`SNG` | `wss://ws-sg-1.nexmo.com`

3) `ips_url`: the Nexmo IPS URL for image upload, the default value is `https://api.nexmo.com/v1/image`.

Data Center | URL
---|---
`WDC` | `https://api-us-1.nexmo.com/v1/image`
`DAL` | `https://api-us-2.nexmo.com/v1/image`
`LON` | `https://api-eu-1.nexmo.com/v1/image`
`SNG` | `https://api-sg-1.nexmo.com/v1/image`

**NOTE:** The data centers are as follows:

Data Center | Location
---|---
`WDC` | Washington DC
`DAL` | Dallas
`LON` | London
`SNG` | Singapore

## Configuration for JavaScript Client SDK

You can specify your preferred URLs when you create the Client SDK `NexmoClient` object:

``` javascript
const nexmoClient = new NexmoClient({
  nexmo_api_url: "https://api-eu-1.nexmo.com",
  url: "wss://ws-eu-1.nexmo.com",
  ips_url: "https://api-eu-1.nexmo.com/v1/image"
});
```
