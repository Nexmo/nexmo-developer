---
title: Configure Authentication
description: Configure authentication details to access the APIs
navigation_weight: 2
---

# Configure Authentication for your Application

Once you have [created your application](/vonage-business-cloud/vbc-apis/getting-started/create-application), you need to configure it so that it can authenticate against the [Account](/vonage-business-cloud/vbc-apis/account-api/overview), [Extension](/vonage-business-cloud/vbc-apis/extension-api/overview) and [User](/vonage-business-cloud/vbc-apis/user-api/overview) APIs. The VBC APIs use  [OAuth](https://oauth.net/2/) for authentication.

## Generating the authentication keys

1. Log into [developer.vonage.com](https://developer.vonage.com/store).

2. Select "My Applications" in the left-hand navigation menu.

3. On the "My Application" page, locate your Application in the table and click the "View" link in the "Actions" column.

4. Select the "Production Keys" tab:

    ![Screenshot showing the Production Keys tab of the My Applications page](/assets/images/vbc/production-keys.png)

    > Note that the default grant type is `Code`. The [grant type](https://oauth.net/2/grant-types/) is the method OAuth uses to generate an access token. When you create a production application you will typically want to use this method to authenticate requests. The `Refresh Token` option will create a new token when the current one expires.

5. In the "Callback URL" field, enter a valid callback URL that your application will use to receive the generated token. If you haven't created your application yet, enter `http://localhost` for now and remember to enter the correct URL when you are ready to test it.

6. Click the "Generate Keys" button. This generates the "Consumer Key" and "Consumer Secret" that your application will use to request a token.

7. Look at the "Endpoint Examples" and "Generating Access Tokens" samples to learn how to request the authentication code and exchange it for an access token:

![Screenshot showing endpoint and generating access token examples](/assets/images/vbc/examples.png)

> In production, you should use the [authorization_code](https://oauth.net/2/grant-types/authorization-code/) grant type (`Code`) and this is the only option shown in the My Applications tab at [developer.vonage.com](https://developer.vonage.com/store). The `Code` grant type requires your application to implement a valid callback URL to retrieve the authorization code from the Vonage servers and exchange it for a token. See the Endpoint examples in the My Applications tab to learn how to create the authorization and token requests.

## Authenticating with the password grant type

All the code snippets in the VBC API documentation use the [password grant type](https://oauth.net/2/grant-types/password) instead of the recommended `authorization_code` to make them easy to run. This grant type does not require you to implement a callback URL. Instead, you provide your VBC user name and password to request a token.

Replace the following placeholders in the example with your own values:

* `VBC_USERNAME` - Your Vonage Business Cloud user name
* `VBC_PASSWORD` - Your Vonage Business Cloud password
* `VBC_CLIENT_ID` - The Consumer Key that you generated in step 5 above
* `VBC_CLIENT_SECRET` - The Consumer Secret that you generated in step 5 above

When using this type of authentication, you will need to append `@vbc.prod` to your username. 

```code_snippets
source: '_examples/vonage-business-cloud/vbc-apis/general/authenticate-password'
```

When you run it, you will receive a JSON response with the `access_token` embedded in it. You need this token to use the Account, Extension and User APIs:

```json
{
   "access_token":"1c31afac-175c-3e3a-9d4b-8ecee3980cfa",
   "refresh_token":"dde2a67f-d99f-3f03-810b-1fcae59245de",
   "scope":"default",
   "token_type":"Bearer",
   "expires_in":3600
}
```

> Now that you have configured authentication, you must [subscribe to the Provisioning API](/vonage-business-cloud/vbc-apis/getting-started/subscribe-api) before you can use the Account, Extension, and User APIs.
