---
title: Developer - Account API Reference
description: Reference guide for the Account API.
api: Developer API
---

# Developer - Account API Reference

## Account

The Account API allows you to retrieve your balance, change settings on your account, and top-up your account.

### Authentication information

If you are not using applications, you use the following parameters for calls to Nexmo API:

Parameter | Description
-- | --
`api_key` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview)
`api_secret` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview)

### Get Balance

Retrieve the current balance of your Nexmo account

#### Request

```
[GET] https://rest.nexmo.com/account/get-balance
```

#### Response

The following shows example Responses in JSON or XML:

**JSON**

```tabbed_examples
source: _examples/api/developer/account/get-balance
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`value` | The accounts remaining balance in euros.
`autoReload` | A boolean indicating if autoReload is enabled on your account.

### Settings

Modify settings for your account including callback URLs and your API secret.

#### Request

```
[POST] https://rest.nexmo.com/account/settings
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`moCallBackUrl` | An URL encoded URI to the webhook endpoint that handles inbound messages. Your webhook endpoint must be active before you make this request, Nexmo makes a [GET] request to your endpoint and checks that it returns a `200 OK` response. Set to empty string to clear. | No
`drCallBackUrl` | An URL encoded URI to the webhook endpoint that handles delivery receipts (DLR). Your webhook endpoint must be active before you make this request, Nexmo makes a [GET] request to your endpoint and checks that it returns a `200 OK` response. Set to empty string to clear. | No

#### Response

The following shows example Responses in JSON or XML:

**JSON**

```tabbed_examples
source: _examples/api/developer/account/settings
```

##### Keys and Values

The response contains the following keys and values:

Key | Value
-- | --
`mo-callback-url` | The current or updated inbound message URI
`dr-callback-url` | The current or updated delivery receipt URI
`max-outbound-request` | The maximum amount of outbound messages per second.
`max-inbound-request` | The maximum amount of inbound messages per second.

### Top up

You can top-up your account using Developer API when you have enabled auto-reload in Dashboard. The amount added to your account at each top up is based on your initial reload-enabled payment. That is, if you topped up `€50.00` when you enabled auto-reload, `€50.00` is automatically credited to your account when your balance reaches `€20.00`.

Your account balance is checked every 6 minutes. If you are sending a lot of messages, use this API to manage reloads when remaining-balance in the response goes below a specific amount.

#### Request

```
[POST] https://rest.nexmo.com/account/top-up
```

##### Parameters

The following shows the parameters you use in the request:

Parameter | Description | Required
-- | -- | --
`trx` | The ID associated with your original auto-reload transaction. For example, `00X123456Y7890123Z`. | Yes

#### Response

HTTP code | Description
-- | --
`200 OK` | Top up successful
`401 Unauthorized` | You have not setup auto-reload in Dashboard
`420 Enhance Your Calm` | Top up failed
