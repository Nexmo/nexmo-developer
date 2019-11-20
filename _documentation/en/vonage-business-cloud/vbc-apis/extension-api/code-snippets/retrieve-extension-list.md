---
title: Retrieve a list of extensions
navigation_weight: 2
---

# Retrieve a List of Extensions

This example shows you how to use the Extension API to retrieve a list of extensions associated with an account.

Replace the following placeholders in the example with your own details:

* `VBC_TOKEN` - a valid token (see [authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication))
* `VBC_ACCOUNT_ID` - the account number the extensions are associated with

```code_snippets
source: '_examples/vonage-business-cloud/vbc-apis/extension-api/retrieve-extension-list'
```

The response is a JSON object containing an array of extension objects. See the [API documentation](/api/vonage-business-cloud/extension?expandResponses=true#ExtensionCtrl.getAccountExtensions) for descriptions of the fields in the response.

```json
{
   "page_size":100,
   "page":1,
   "total_pages":1,
   "total_items":51,
   "_links":{
      "first":{
         "href":".../accounts/9999999/extensions?page_size=100&page=1"
      },
      "self":{
         "href":".../accounts/9999999/extensions?page_size=100&page=1"
      },
      "last":{
         "href":".../accounts/9999999/extensions?page_size=100&page=1"
      }
   },
   "_embedded":{
      "extensions":[
         {
            "extension_number":"2222",
            "location_id":1111111,
            "vtt_enabled":false,
            "dnd_enabled":false,
            "caller_id":"14155550100",
            "block_caller_id":false,
            "dids":[

            ],
            "extension_handsets":[
               {
                  "handset_name":"line1-ABC123",
                  "sip_id":"ABC123"
               }
            ]
         },
         {
           ...
         }
      ]
   }
}
```
