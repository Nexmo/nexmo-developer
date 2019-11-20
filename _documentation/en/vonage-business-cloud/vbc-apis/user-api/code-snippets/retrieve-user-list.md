---
title: Retrieve a list of users
navigation_weight: 2
---

# Retrieve a List of Users

This example shows you how to use the User API to retrieve a list of users associated with an account.

Replace the following placeholders in the example with your own details:

* `VBC_TOKEN` - a valid token (see [authentication](/vonage-business-cloud/vbc-apis/getting-started/authentication))
* `VBC_ACCOUNT_ID` - the account number the users are associated with

```code_snippets
source: '_examples/vonage-business-cloud/vbc-apis/user-api/retrieve-user-list'
```

The response is a JSON object containing an array of user objects. See the [API documentation](/api/vonage-business-cloud/user?expandResponses=true#UserCtrl.getUserByID) for descriptions of the fields in the response.

```json
{
   "page_size":100,
   "page":1,
   "total_pages":1,
   "total_items":47,
   "_links":{
      "first":{
         "href":".../accounts/9999999/users?page_size=100&page=1"
      },
      "self":{
         "href":".../accounts/9999999/users?page_size=100&page=1"
      },
      "last":{
         "href":".../accounts/9999999/users?page_size=100&page=1"
      }
   },
   "_embedded":{
      "users":[
         {
            "email":"alice.jones@example.com",
            "login_name":"alice.jones",
            "first_name":"Alice",
            "last_name":"Jones",
            "id":8888888,
            "contact_numbers":[
               {
                  "type":"Mobile",
                  "value":"447700900001"
               },
               {
                  "type":"Home",
                  "value":"442079460003"
               },
               {
                  "type":"Fax",
                  "value":null
               }
            ],
            "extensions":[
               {
                  "dids":[
                     "447700900002"
                  ],
                  "extension_number":"333"
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
