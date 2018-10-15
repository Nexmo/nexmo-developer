---
title: OAuth
navigation_weight: 3
---

# OAuth

You can use the OAuth 1.0a protocol to give your App authorized access to the Nexmo APIs.

OAuth is an open standard that provides client apps with secure delegated access to HTTP resources on behalf of that resource's owner. It does this by providing access tokens to third-party clients with the approval of the resource owner. The client then uses the access token to access protected resources.

When you use OAuth for authentication:

* Nexmo can tell which App and user are calling Nexmo APIs
* Your app identifies the user
* The user's privacy is protected

**Note**: We strongly recommend you use an existing [OAuth Library](https://oauth.net/1/) for your App.

This section contains:

* [Setting up OAuth access](#setting-up-oauth-access)
* [Using OAuth in your App](#using-oauth-in-your-app)
* [Running the sample App](#running-the-sample-app)

## Setting up OAuth access

OAuth access is associated with a Developer App. You need to create and configure your App before you setup OAuth access.

To do this:

1. Contact <support@nexmo.com> and request OAuth access be enabled for your account. Nexmo support contacts you when access is granted.
3. Login to Dashboard: <https://dashboard.nexmo.com>.
4. In Dashboard, click *Apps* > *Developer*.
5. Click *create a new developer app*.
6. Fill the form and click *Save*. You see your *Consumer Key* and *Consumer Secret* in Dashboard.
7. Install an OAuth 1.0a library for your programming language from: <https://oauth.net/1/>.

## Using OAuth in your App

After you have [setup OAuth access](#setup), include OAuth in your App:

1. Define the names for incoming return parameters:

    ```tabbed_examples
    source: '_examples/messaging/oauth/using-oauth-in-your-app/1'
    ```

2. Create your OAuth object:

    ```tabbed_examples
    source: '_examples/messaging/oauth/using-oauth-in-your-app/2'
    ```

3. Retrieve an OAuth request token:

    ```tabbed_examples
    source: '_examples/messaging/oauth/using-oauth-in-your-app/3'
    ```

4. Authorize OAuth access for this App:

    ```tabbed_examples
    source: '_examples/messaging/oauth/using-oauth-in-your-app/4'
    ```

5. Retrieve an OAuth permanent access tokens from Nexmo using the *request_token* and *request_token_secret*:

    The access token:
    * Gives your App access to Nexmo API.
    * Enables your App to make calls through your Nexmo account.

    ```tabbed_examples
    source: '_examples/messaging/oauth/using-oauth-in-your-app/5'
    ```

6. Set your request parameters:

    ```tabbed_examples
    source: '_examples/messaging/oauth/using-oauth-in-your-app/6'
    ```

6. Make a request to the Nexmo APIs:

    ```tabbed_examples
    source: '_examples/messaging/oauth/using-oauth-in-your-app/7'
    ```

**The Nexmo OAuth endpoints are:**

Type | URL
-- | --
Request Token | `https://dashboard.nexmo.com/oauth/request_token`
Authorize | `https://dashboard.nexmo.com/oauth/authorize`
Authenticate | `https://dashboard.nexmo.com/oauth/authenticate`
Access Token | `https://dashboard.nexmo.com/oauth/access_token`

## Running the sample App

The code used in this page is part of a small PHP App that you can run locally. To do this:

1. [Setup OAuth access](#setting-up-oauth-access) with Nexmo.
2. Setup an [OAuth 1.0a](https://oauth.net/1/) library for PHP.
2. Download the sample from (file: nexmoOAuthDriver.sample text: nexmoOAuthDriver) and rename it *nexmoOAuthDriver.php*.
3. In *nexmoOAuthDriver.php*, replace `<YOUR Consumer Key>` and `<YOUR Consumer Secret>` with the values for your App.
  To find your Consumer Key and Secret, in **Dashboard**, click *Apps* > *Developer*.
3. Use the following command to run nexmoOAuthDriver.
	``php nexmoOAuthDriver.php``
