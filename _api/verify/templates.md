---
title: Verify Templates
description: How to customize your verification message
api: Verify
---

# Verify Templates

The messages that the Verify API sends during the verification process are created using a template. Default templates are provided. You can create your own templates to customize the content of any SMS or voice messages that the Verify API sends on your behalf, to create a fully branded experience for your users.

> If you want to continue using the default templates then no further configuration is required and you can ignore this guide.

### Default templates

By default, the Verify API uses the following templates:

```tabbed_content
source: '_examples/api/templates/default'
```

In the above template, `${pin}`, `${brand}` and `${pin_expiry}` are [template variables](#template-variables).

### Template variables
You can use the following variables in any Verify templates:

* `${pin}`: a placeholder for the random verification code
* `${brand}`: the name of your company or application
* `${pin_expiry}`: how long the verification code is valid for, in seconds

The `${pin}` is generated randomly by the Verify API. The values for `${brand}` and `${pin_expiry}` are the parameters you set in your call to [Verify request](/api/verify#verify-request).

The `<break time="1s" />` is a [Speech Synthesis Markup Language (SSML)](/voice/voice-api/guides/customizing-tts) tag. It adds a one second delay before the text-to-speech message is played.

### Creating a custom template

To create a custom template you must first define it in JSON format and then [register](#registering-a-custom-template) it.

The following table lists the settings you can use in your custom templates:

Parameter | Description | Required | 
-- | -- | --
`action_type` | Possible values are: `sms` - send a text message _or_ `voice` - send a text-to-speech message | Yes
`lg` | Specifies the [locale](/voice/voice-api/guides/text-to-speech#locale) used to deliver text-to-speech verification messages in your chosen language, accent and gender. All calls to [Verify request](/api/verify#verify-request) for a custom template must use the same `lg`. <br>If you want to use a non-standard locale, you must supply links to audio files in your template as shown in the "Custom Locale" example [here](#custom-template-examples). | Yes
`template` | The content displayed in an SMS message (when the `action_type` is `sms`) or spoken to your user in a text-to-speech call (when the `action_type` is `voice`). This content can include [variables](#template_variables).<br> If you provide a value for `template` and `action_type` is `voice`, do not specify `digit_n`, `welcome_message` or `bye_message`. | No
`type` | The encoding used for `template` when the `action_type` is `sms`. Possible values are: `unicode` _or_ `text` | No
`digit_n` | URL to the media file played when Nexmo reads out a digit to the user using text-to-speech. If you specify `digit_n`, you should also specify  `welcome_message` and `bye_message`. Nexmo inserts the verification code between the two. | No
`welcome_message` | URL to the media file played at the start of the call. | Yes, if you specify `digit_n`
`bye_message` | URL to the media file played at the end of the call. | Yes, if you specify `digit_n`
`contact_email` | Set the email address used to generate a Zendesk ticket and activate your custom template. If you do not set this parameter, Verify uses the email address associated with your master API key. | No

### Custom template examples

The following are examples of templates:

```tabbed_content
source: '_examples/api/templates/custom'
```

### Registering a custom template

#### Making the request

After you have defined the template, you need to register it with the Verify API. You do this by making a request to the `https://api.nexmo.com/verify/templates` endpoint, with the template as the payload.

The following code examples show you how to register your custom template:

```tabbed_examples
source: '_examples/api/templates/register'
```

#### Understanding the response

The JSON response looks like:

```tabbed_content
source: '_examples/api/templates/response'
```
The response header contains one of the following HTTP status codes:

* [201] - Your custom template has been created
* [400] - Your request contains incorrect parameters or Nexmo could not upload any media that you specified in your template.
* [401] - The `api_key` / `api_secret` combination you used in your request was invalid or your account has been disabled.
* [500] - Internal error.

The response body contains the following keys and values:

| Key | Value |
|---- | --- |
`account_id` | Your `api_key`.
`action_type` | Possible values are: `sms` - SMS template _or_ `voice` - Voice template was used
`bye_message` | The ID of the media file played at the end of the call.
`digit_n` | The IDs of the media files used for each digit.
`lg` |  The template [locale](/voice/voice-api/guides/text-to-speech#locale).
`status` | The template's current status in the system. Possible values are: `ACTIVE` - currently in use, `PENDING` - waiting to be approved and activated _or_ `RETIRED` - no longer active
`template` | The message that will be sent to your user in an SMS or a text-to-speech Call.
`type` | The encoding used for the template when the `action_type` is `sms`. Possible values are: `unicode` _or_ `text` (default)
`version` | The template's version number. This number is generated automatically.
`welcome_message` | The ID of the media file played at the start of the call.
