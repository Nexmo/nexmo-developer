---
title: Contact Center Intelligence
description: Learn how to enhance your contact center solution with Voice API.
navigation_weight: 9
---

# Contact Center Intelligence

The Vonage Voice API, together with partner solutions, empowers you with the cutting-edge technology of phone call processing, assistance, and analytics, which is extremely helpful for Contact Center cases. It does not matter if you’re building a Contact Center solution from scratch, or already have a legacy CC/PBX solution which you want to extend with modern features and workflows such as AI voice assistants or sentiment analysis, Voice API and partner solutions are ideal to assist you.
There are three groups of contact center oriented use-cases where the Voice API can help:

* **Self-service**. Offer more choice with customers having the option to select self-service for faster resolutions to low complexity inquiries with smart FAQs.
* **Real-time analytics and agent assist**. Empower agents with real-time insights and in-call tools delivered through AI engines.  Provide feedback to the customer’s real-time call experience and populate key information so agents can provide a top-level customer experience.
* **Post-call analytics**. Extract meaningful insights from recorded calls or chats to help agents and supervisors better understand conversations with customers. Uncover patterns and quality concerns so that they can resolve issues faster and ultimately improve the overall customer experience. Post-call speech analytics dashboards drive agent and operational performance statistics and provide insights for managers, quality assurance personnel, and other leadership groups.

For *self-service* cases, the Voice API provides the following set of features:

* [Text-to-Speech](/voice/voice-api/guides/text-to-speech) and [Speech Recognition](/voice/voice-api/guides/asr) for advanced IVR or simple voice bots. Follow this [tutorial](/use-cases/asr-use-case-voice-bot) to learn more.
* [WebSockets](/voice/voice-api/guides/websockets) allow you to connect phone calls to any AI bot engine of your choice. Clone our [reference application](https://github.com/Nexmo/lex-connector) to quickly start with [Amazon Lex](https://aws.amazon.com/lex/) integration, which applies natural language understanding (NLU) to recognize the intent of the text, enabling you to build applications with highly engaging user experiences and lifelike conversational interactions. 

With WebSockets, you can also embed any kind of *real-time analytics* into your contact center. With an NCCO [`connect`](/voice/voice-api/ncco-reference#connect) action, you can attach a WebSocket one-way (or two-way, depending on the case) stream to any inbound or outbound call and then pass the media to an analytics engine, such as [Amazon Transcribe](https://aws.amazon.com/transcribe/). You can perform a deeper analysis with [Amazon Comprehend](https://aws.amazon.com/comprehend/) to provide the agent with useful insights and real-time hints during the call.

*After the call is completed*, it is likely you may want to keep the keynotes, as well as be able to search through the recordings. In order to do that, the Voice API enables you to record every call or part of the call so that you can store and analyze it. Learn how to do that with our [Transcribe a Recorded Call with Amazon Transcribe](/use-cases/trancribe-amazon-api) complete tutorial.

If you want to get everything working out of the box or if you are looking for a very specific use case implementation, [Vonage AI](ai.vonage.com) offers turn-key solutions made by industry experts.

## How it works

Let’s take a closer look at the components of the solution you might want to build for each use case.

### IVR

For the typical IVR case, the user calls a PSTN (phone) number and interacts with the virtual operator by choosing the options via DTMF tones (key input) or by saying the option (speech input). To build a solution like this, what is needed is a [Vonage virtual number](/numbers/overview) assigned to your [application](/application/overview), which interacts with the user through the Vonage Voice API platform by providing [NCCO](/voice/voice-api/guides/ncco) commands (actions) such as [`talk`](/voice/voice-api/ncco-reference#talk) for Text-to-Speech message and [`input`](/voice/voice-api/ncco-reference#input) for DTMF/speech input:

![IVR](/images/voice-api/cci_ivr.png)

Vonage deals with the complexity of connecting the call, so all you need is to provision a Vonage virtual number, assign it to your app, and implement HTTP request handlers ([webhooks](/voice/voice-api/webhook-reference)) to instruct the Voice platform with the desired call control [actions](/voice/voice-api/ncco-reference). Building a simple IVR is this easy.

Quite a similar approach can be used for voice notifications with or without IVR as a part of it. The difference is that now your app initiates the call with a [REST API](/api/voice#createCall) (HTTP) request:

![Voice Notification](/images/voice-api/cci_outbound.png)

As a step in your IVR flow, you may want to have an option to connect the user to your contact center agent. You can do this with the [`connect`](/voice/voice-api/ncco-reference#connect) NCCO action by either forwarding the call to a PSTN number or connecting it to the SIP endpoint of your contact center platform:

![Connect to Contact Center](/images/voice-api/cci_ivr_connect.png)

Learn more about connecting PBX/CC in [SIP documentation](/voice/sip/overview), including configuration steps for various types of platforms, such as FreeSWITCH or Avaya SBCe.
Many contact center solutions require a way to receive context information regarding the currently processed call. A traditional way to send such data to the CC is by adding one or more custom SIP Headers with tokens to the SIP INVITE message. Generally, this token may be used to send the call to a specific group of specialized Agents. Some CC solutions may even use this token, for example, to automatically open a browser to the customer CRM page in the Agent’s computer, via the CTI, when they answer the call. 
The transmission of one or more custom SIP Headers from the Voice platform to the CC is achievable using the [`headers`](/voice/voice-api/ncco-reference#sip-the-sip-endpoint-to-connect-to) parameter in the `connect` NCCO action.

### Voice Bot

If you want to enhance your IVR with natural language understanding (NLU), you may connect it to an AI service, such as [Amazon Lex](https://aws.amazon.com/lex/). Lex accepts both text and media (audio) and provides text and media output following the business logic you implement in your bot. In order to connect the telephony world with binary media processing services, you may use a WebSocket connection, supported by the Vonage Voice platform. To do that, include the [`connect` action](/voice/voice-api/ncco-reference#connect) with your app WebSocket URL as the endpoint into your NCCO - and the call will be immediately connected to your app with media flowing from the user and backward. Then you just need to pass the media frames to Lex and stream Lex responses back through the same connection:

![Voice Bot](/images/voice-api/cci_bot.png)

For a quick implementation, clone the reference [Lex Connector](https://github.com/Nexmo/lex-connector) application, which has everything you need to connect the voice calls to your Lex bot.

Furthermore, when your bot detects user intent to have a conversation with a human agent, your application may send a [transfer](/voice/voice-api/code-snippets/transfer-a-call) request to the Vonage API, and it will connect the user to your Contact Center:

![Voice Bot with Transfer](/images/voice-api/cci_bot_transfer.png)

Provide full context of the bot conversation to your CC by connecting directly to your CC using SIP and custom SIP Headers to transmit the correlated information.

### Real-Time Analytics

Use a similar approach to perform real-time analysis of the conversation between the user and the agent: the user is connected to your contact center through the Vonage voice platform with the [`connect`](/voice/voice-api/ncco-reference#connect) action sent from your application, then another `connect`action is used to establish a [WebSocket](/voice/voice-api/guides/websockets) connection for sending the call media to your app, which then sends it to the analytics engine. Your application may then send the results of the analysis, such as sentiment or call hints to the agent to some widget on your agent's screen. You could embed this widget in your contact center user interface or use it in a standalone application:

![CCI Analytics](/images/voice-api/cci_analytics.png)

### Post-call Analytics

The Vonage Voice API enables you to easily [record](/voice/voice-api/guides/recording) the conversation or a part of the conversation, depending on your call flow and the use case. Because you can record across [multiple channels](/voice/voice-api/guides/recording#multi-channel-recording), the audio file can be further processed by various analytics services. Check our detailed tutorial to learn how to [transcribe the recording using Amazon Transcribe](/use-cases/trancribe-amazon-api).

### Further Reading
* Check [NCCO Reference](/voice/voice-api/ncco-reference) for all the supported NCCO actions
* Learn more about [WebSockets](/voice/voice-api/guides/websockets)
* See how [Amazon Contact Center Intelligence](https://aws.amazon.com/machine-learning/contact-center-intelligence/) solutions may improve your customer experience
* Visit [Vonage AI](ai.vonage.com) to learn how Vonage can build AI solution for you
