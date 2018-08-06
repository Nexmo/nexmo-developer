---
title: NCCO for Outbound Phone Calls
---

# Outbound PSTN Calling NCCO guide

In this guide we'll demonstrate how to set up a dynamic answer URL with NCCO that will allow you to make outbound PSTN calls from within your application. After completing this guide, you can follow along with the [JavaScript, Android, or iOS guides](/stitch/in-app-voice/guides/outbound-pstn).

## Concepts

This guide will introduce you to the following concepts:

**Nexmo Applications**
    -> Contain configuration for the application that you are building.

**PSTN**
    -> Short for "public switched telephone network". Basically the network of Telephones and Cell Phones that can make and receive calls.

**NCCO**
    -> Short for "Nexmo Call Control Object". A JSON array that you use to control the flow of a Voice API call. Read more in [the NCCO Reference Guide](https://developer.nexmo.com/voice/voice-api/ncco-reference).

## Before you begin

Ensure you have the following in place before you begin:

* Ensure you have [Node.JS](https://nodejs.org/) installed.
* Create a free Nexmo account - [signup](https://dashboard.nexmo.com).
* Install the Nexmo CLI.
* Setup the CLI to use your Nexmo API Key and API Secret. You can get these from the [setting page](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard.

To install the Nexmo CLI enter the following command:

```bash
$ npm install -g nexmo-cli@beta
```

To set up the CLI to use your API Key and API Secret use the following command:

```bash
$ nexmo setup api_key api_secret
```


## Setup instructions

For this guide, you'll need to link it an answer and event URL to either a preexisting Nexmo Application or create a new one:

```sh
nexmo app:create "Stitch Outbound PSTN" https://example.com/answer https://example.com/events
```

or:

```sh
nexmo app:update aaaaaaaa-bbbb-cccc-dddd-0123456789ab "Stitch Outbound PSTN" https://example.com/answer https://example.com/events
```

Then you'll need to buy a number with Nexmo and link the number to your new or existing Stitch application:

```sh
nexmo number:buy 16625461410
nexmo link:app 16625461410 aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

## Using the SDKs with an answer URL

The new or existing application should be used to generate a user JWT that your user will use to login to one of the Stitch SDKs. For more info about creating a JWT and associating with a user or application. See the first [In-App Messaging quickstart](/stitch/in-app-messaging/guides/simple-conversation)

When you use one of the Nexmo Stitch SDKs to make a PSTN call, you'll pass in the phone number in [E.164](https://en.wikipedia.org/wiki/E.164) format you want to call as an argument to that SDK's `callPhone()` method. Then the Stitch API will make a request to your answer URL `https://example.com/answer` with the following parameters:

```
?from=demo
&to=14155550100\
&conversation_uuid=CON-4e977dab-2abc-42b5-bf64-d468d4763e54\
&uuid=NONE
```

We can use the `to` parameter to dynamically tell Nexmo which phone number to call. The `from` parameter is the name of the Stitch user that initiated the call. The `conversation_uuid` is the ID of the conversation that is created for the IP and PSTN user for this call. The `UUID` parameter does not apply to this guide.

## Setting up the answer and event URLs

If you'd like to set the caller's number the PSTN recipient will see when their PSTN phone rings, we can use the NCCO to set a `from` parameter with a Nexmo virtual number.

Using the `to` parameter that Nexmo sends our answer URL and the `NEXMO_NUMBER` that you bought we can construct an NCCO like so:

```json
[{
  "action": "connect",
  "from": "NEXMO_NUMBER",
  "endpoint": [{
    "type": "phone",
    "number": "TO_NUMBER"
  }]
}]
```

This is the NCCO that should be served from the answer URL, with `NEXMO_NUMBER` replaced with the number you've bought from Nexmo and `TO_NUMBER` replaced with the `to` query parameter that the Nexmo API serves your answer URL.

After you've implemented the `callPhone()` method and called it in your project using one of the Nexmo SDKs, the caller you just dialed should receive your call and see the from number that you've set with the `NEXMO_NUMBER`.

## Where next?

An example of an answer URL with a dynamic NCCO object using the `NEXMO_NUMBER` and `TO_NUMBER` is available in the [IP to PSTN glitch demo project](https://glitch.com/edit/#!/nexmo-ip-to-pstn)

After reading this guide, you should read more about implementing outbound PSTN calling with the [JavaScript, Android or iOS SDKs](/stitch/in-app-voice/guides/outbound-pstn).

If you'd like to learn more about other actions you can use in your NCCO to control the flow of a call such as recording, sending audio files or synthesised speech, you can read more about that in the [NCCO reference guide for the Voice API](/voice/voice-api/ncco-reference).
