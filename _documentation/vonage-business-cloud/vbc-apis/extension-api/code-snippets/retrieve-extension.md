---
title: Retrieve an extension
navigation_weight: 1
---

# Retrieve Details of a Specific Extension

This example shows you how to use the Extension API to retrieve details about a specific extension associated with an account.

Replace the following placeholders in the example with your own details:

* `VBC_TOKEN` - a valid token (see [authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication))
* `VBC_ACCOUNT_ID` - the account number the extension is associated with
* `VBC_EXTENSION` - the ID of the extension you want to retrieve details for

```code_snippets
source: '_examples/vonage-business-cloud/vbc-apis/extension-api/retrieve-extension'
```

The response is a JSON object containing details about the extension. See the [API documentation](/api/vonage-business-cloud/extension?expandResponses=true#ExtensionCtrl.getAccountExtensionByID) for descriptions of the fields in the response.

```json
{
   "_links":{
      "self":{
         "href":".../accounts/9999999/extensions/2222"
      }
   },
   "_embedded":{
      "extension":{
         "extension_number":"2222",
         "location_id":1111111,
         "vtt_enabled":false,
         "dnd_enabled":true,
         "caller_id":"14155550100",
         "block_caller_id":false,
         "dids":[

         ],
         "extension_handsets":[

         ]
      }
   }
}
```
