---
title: Retrieve a list of locations
navigation_weight: 3
---

# Retrieve a List of Locations for an Account

This example shows you how to retrieve all the locations associated with an account.

Replace the following placeholders in the example with your own details:

* `VBC_TOKEN` - a valid token (see [authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication))
* `VBC_ACCOUNT_ID` - the account number for the locations you are interested in

```code_snippets
source: '_examples/vonage-business-cloud/vbc-apis/account-api/retrieve-locations'
```
The response is a JSON object containing an array of location objects. See the [API documentation](/api/vonage-business-cloud/account?expandResponses=true#AccountCtrl.getLocationsByAccountID) for descriptions of the fields in the response.

```json
{
   "_links":{
      "self":{
         "href":".../accounts/9999999/locations"
      }
   },
   "_embedded":{
      "locations":[
         {
            "id":1111111,
            "name":"Test Location",
            "address":{
               "address_1":"23 MAIN ST",
               "address_2":null,
               "country":"US",
               "state":"NJ",
               "city":"holmdel",
               "postal_code":"07733",
               "time_zone":"America/New York"
            }
         }
      ]
   }
}
```
