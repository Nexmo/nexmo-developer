---
title: Link your Facebook Page to your Nexmo account
description: In this step you learn how to link your Facebook Page to your Nexmo account. This process is validating using a JWT associated with an application in your Nexmo account.
---

# Link your Facebook Page to your Nexmo account

## Generate a JWT

You will need to generate a JWT to validate the linking of your Facebook Page to your Nexmo account. You can skip this step if you have already linked your Facebook Page to your Nexmo account.

In the following command make sure you paste in the Application ID of the Nexmo application you created in the [previous step](/task/sending-facebook-message-with-failover/olympus/create-application):

``` shell
JWT="$(nexmo jwt:generate ./private.key application_id=YOUR_APP_ID)"
```

> **NOTE:** The default expiry time for the JWT is 15 minutes.

Type the following command to echo your JWT:

``` shell
echo $JWT
```

Copy the JWT text to the clipboard. You will use it later to validate the linking of your Facebook Page to your Nexmo account.

## Link your Facebook Page to your Nexmo account

To link your Facebook Page to your Nexmo account navigate to the following page:

* [Link your Facebook Page to Nexmo](https://static.nexmo.com/messenger/)

Select the Facebook Page you want to link to your account from the dropdown list.

Paste the JWT you previously copied to your clipboard into the JWT Token field and click Subscribe. You receive a message confirming the page is now linked to your account.
