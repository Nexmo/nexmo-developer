---
title: Retrieve a location
navigation_weight: 2
---

# Retrieve Details of an Account Location

This example shows you how to use the Account API to retrieve details about a specific location associated with an account.

Replace the following placeholders in the example with your own details:

* `VBC_TOKEN` - a valid token (see [authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication))
* `VBC_ACCOUNT_ID` - the account number the location is associated with
* `VBC_LOCATION_ID` - the location ID you want to retrieve details for

```building_blocks
source: '_examples/vonage-business-cloud/vbc-apis/account-api/retrieve-location'
```

The response is a JSON object containing details about the location. See the [API documentation](/api/vonage-business-cloud/account?expandResponses=true#AccountCtrl.getLocationByID) for descriptions of the fields in the response.

```json
{
   "_links":{
      "self":{
         "href":".../accounts/9999999/locations/1111111"
      }
   },
   "_embedded":{
      "location":{
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
   }
}
```
