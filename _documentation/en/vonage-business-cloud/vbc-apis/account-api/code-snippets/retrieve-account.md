---
title: Retrieve an account
navigation_weight: 1
---

# Retrieve Details for a Specific Account

This example shows you how to use the Account API to retrieve details about an individual account.

Replace the following placeholders in the example with your own details:

* `VBC_TOKEN` - a valid token (see [authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication))
* `VBC_ACCOUNT_ID` - the account number you want to retrieve details for

```code_snippets
source: '_examples/vonage-business-cloud/vbc-apis/account-api/retrieve-account'
```

The response is a JSON object containing details about the account. See the [API documentation](/api/vonage-business-cloud/account?expandResponses=true#AccountCtrl.getAccountServicesByAccountID) for descriptions of the fields in the response.

```json
{
   "_links":{
      "self":{
         "href":".../accounts/9999999"
      }
   },
   "_embedded":{
      "account":{
         "id":999999,
         "name":"Test Account",
         "status":"ACTIVE",
         "address":{
            "address_1":"23 MAIN ST",
            "address_2":null,
            "country":"US",
            "state":"NJ",
            "city":"holmdel",
            "postal_code":"07733"
         }
      }
   }
}
```
