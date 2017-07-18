---
title: Make outbound calls
description: Voice API Calls
---

# Make outbound calls

The workflow to make a Call using the Voice API is:

![Outbound call workflow](/assets/images/workflow_voice_api_outbound_call.svg)

1. You make an [authenticated](/concepts/guides/applications#minting) Call request to the Voice API.
2. Nexmo accepts the request and sends response information.  
3. Nexmo places a call and makes a GET request to retrieve an NCCO from your *answer_url* webhook endpoint.
4. Nexmo follows the actions in your NCCO.
5. Nexmo sends POST request to your *event_url* webhook endpoint when the Call status changes.
 For more advanced systems, depending on the input from your user, you can return an NCCO to customize their experience.

To create a Call using the Voice API:


1. [Create a Nexmo application](/concepts/guides/applications#apps_quickstart).</li>
2. Create the NCCOs for the business logic you are implementing in your Voice app: 

    ```tabbed_content
    source: '_examples/voice/guides/outbound-calls/ncco'
    ```

    To run a few tests without creating an NCCO provider in the next step, use the following static NCCOs:
      * <https://nexmo-community.github.io/ncco-examples/first_call_talk.json>
      * <https://nexmo-community.github.io/ncco-examples/first_call_speech.json>
      * <https://nexmo-community.github.io/ncco-examples/first_call_input.json>

3. Create the webhook endpoint that provides an NCCO:

    ```tabbed_examples
    source: '_examples/voice/guides/outbound-calls/webhook'
    ```

4. Handle the call state changes at <i>event_url</i>. To inspect and debug state changes without writing your own server, create an online endpoint service such as [requestb.in](http://requestb.in/) or [https://hookbin.com/](https://hookbin.com/). The following code examples show you how to handle changes in Conversation state:

    ```tabbed_examples
    source: '_examples/voice/guides/outbound-calls/handle-the-call-state-changes'
    ```

5. Write a method to generate the JWT you use to access Nexmo API for your application:

    ```tabbed_examples
    source: '_examples/voice/guides/outbound-calls/jwt'
    ```

    > **Note**: after you have generated a jwt, it is valid for 24 hours.


6. Use the Voice API to create your Call:

    ```tabbed_examples
    source: '_examples/voice/guides/outbound-calls/create-call'
    ```
