---
title: Retrieve a user
navigation_weight: 1
---

# Retrieve a User's Details

This example shows you how to use the User API to retrieve details about a specific user associated with an account.

Replace the following placeholders in the example with your own details:

* `VBC_TOKEN` - a valid token (see [authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication))
* `VBC_ACCOUNT_ID` - the account number the extension is associated with
* `VBC_USER_ID` - the ID of the user you want to retrieve details for

```code_snippets
source: '_examples/vonage-business-cloud/vbc-apis/user-api/retrieve-user'
```

The response is a JSON object containing details about the user. See the [API documentation](/api/vonage-business-cloud/user?expandResponses=true#UserCtrl.getUserByID) for descriptions of the fields in the response.

```json
{
   "_links":{
      "self":{
         "href":".../accounts/9999999/users/7777777"
      }
   },
   "_embedded":{
      "user":{
         "email":"bob.smith@example.com",
         "login_name":"bob.smith",
         "first_name":"Robert",
         "last_name":"Smith",
         "id":7777777,
         "contact_numbers":[
            {
               "type":"Mobile",
               "value":"447700900000"
            },
            {
               "type":"Home",
               "value":"442079460000"
            },
            {
               "type":"Fax",
               "value":"442079460005"
            }
         ],
         "extensions":[

         ]
      }
   }
}
```
