---
title: Verify - Templates API Reference
description: Reference guide customizing your verification message
api: Verify
---

# Verify - Templates API Reference

You use custom templates to modify the default messages sent by the Verify API. You can even add messages in currently unsupported languages.

By default Verify messages conform to the following templates:

```tabbed_content
source: '_examples/api/templates/default'
```

Nexmo inserts a random ${pin} into *template*. The *brand* and *pin_expiry* parameters in your call to [Verify Request](/api/verify) fill ${brand} and ${pin_expiry} in the template.

You use a custom template to create a fully branded experience for your user. You completely manage the text, variables and audio streams.

A custom template looks like:

```tabbed_content
source: '_examples/api/templates/custom'
```

> **Note**: you do not use the *type* parameter for Voice custom templates.

To setup custom templates:

```tabbed_examples
source: '_examples/api/templates/register'
```

* [Create custom template](#create-a-custom-template): add a custom template used by Verify Request.


### Create a custom template

The following code examples show you how to register a custom template:

```tabbed_examples
source: '_examples/api/templates/register'
```

This request contains:

* [Base URL](#base-url)
* [Payload](#payload)


Information about the Call is sent to you in the:

* [Response](#response) - parameters sent synchronously when the Call starts

#### Base URL

All requests to manage custom templates must contain:

* `https://api.nexmo.com/verify/templates`

#### Payload

The payload to create a new custom template looks like:

```tabbed_content
source: '_examples/api/templates/payload'
```

The following table shows the parameters you use to create a custom template:

Parameter | Description | Required
-- | -- | --
`action_type` | Possible values are: `sms` - send a text message _or_ `voice` - send a text-to-speech message | Yes
`lg` | Explicitly control the [language, accent and gender](https://docs.nexmo.com/voice/voice-deprecated/supported-languages) used to deliver the message in your custom template. For example, *en-in* is a female voice that delivers your message in English with an Indian accent. Calls to (link: verify/api-reference/api-reference#vrequest text: Verify Request) for a custom template must use the same *lg*. <br>For templates in an (link: #custom_templates text: custom locale) such as *en-ie*, you must supply links to recorded files in your template. | yes
`template` | The content displayed in the text message or spoken to your user in a text-to-speech call. For example: *Your ${brand} download code ${pin} is valid for the next ${pin_expiry} minutes*. You must set the custom template variables in calls to (link: verify/api-reference/api-reference#vrequest text: Verify Request).<br> If you set *action_type* to *voice* and specify a template, it is used in a text-to-speech call. Do not specify *digit_n*, *welcome_message* or *bye_message*. | No
`type` | The encoding used for *template*. Possible values are: `unicode` _or_ `text` | No
`digit_n` | URL to the media file played when digit n (0-9) is touched on the user's handset. If you specify *digit_n*, you must set *welcome_message* or *bye_message*. Nexmo inserts a PIN between *welcome_message* and *bye_message*. | No
`welcome_message` | URL to the media file played at the start of the call. | If you set digit_n
`bye_message` | URL to the media file played at the end of the call. | If you set digit_n
`contact_email` | Set the email address used to generate a Zendesk ticket and activate your custom template. If you do not set this parameter, the email address associated to your Master API key is used. | No

#### Response

The JSON response looks like:

```tabbed_content
source: '_examples/api/templates/response'
```

The response headers has one of the following HTTP status codes:

* 201 - Your custom template has been created
* 400 - Incorrect parameters in your request. This value is also returned when Nexmo could not upload the media files in your request.
* 401 - The `api_key` / `api_secret` combination you used in your request was invalid or your account has been disabled.
* 500 - Internal error.

The response body contains the following keys and values:

| Key | Value |
|---- | --- |
`account_id` | Your `api_key`.
`action_type` | Possible values are: `sms` - an sms template was used _or_ `voice` - a voice template was used
`bye_message` | The ID for the media file played at the end of the call.
`digit_n` | The IDs for the media files used for each digit.
`lg` |  The template [locale](https://docs.nexmo.com/voice/voice-deprecated/supported-languages).
`status` | Possible values are: `ACTIVE` - this template is currently in us, `PENDING` - waiting to be approved and activated _or_ `RETIRED` - no longer active
`template` | The message sent to your user in an SMS or a text-to-speech Call.
`type` | The encoding used for *template* when *action_type* is *SMS*. Possible values are: `unicode` _or_ `text` (default)
`version` | The version number for this custom template. This number is generated automatically.
`welcome_message` | The ID for the media file played at the start of the call.
